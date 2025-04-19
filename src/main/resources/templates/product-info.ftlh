<#ftl encoding="UTF-8">
<#import "blocks/template.ftlh" as t>
<@t.template user>

    <style>
        .custom-button {
            margin: 5px;
            padding: 10px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            font-weight: 500;
            transition: all 0.3s ease-in-out;
        }

        .custom-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .form-inline-center {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .quantity-input {
            width: 100px;
            text-align: center;
            margin-right: 10px;
        }
    </style>

    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <#list images as image>
                <li data-target="#myCarousel" data-slide-to="0" class=""></li>
            </#list>
        </ol>
        <div class="carousel-inner">
            <#list images as image>
                <div class="carousel-item <#if image.previewImage>active</#if>">
                    <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg"
                         role="img" aria-label=" :  " preserveAspectRatio="xMidYMid slice" focusable="false">
                        <title></title>
                        <rect width="100%" height="100%" fill="#777"></rect>
                        <text x="50%" y="50%" fill="#777" dy=".3em"></text>
                    </svg>

                    <div class="container">
                        <div class="carousel-caption">
                            <a href="/images/${image.id}">
                                <img class="product" style="height: 100px" src="/images/${image.id}">
                            </a>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <hr>
    <p><h1 style="text-align: center">${product.title} | ${product.price} ₽</h1></p>
    <p style="text-align: center">${product.description}</p>
    <p style="text-align: center">Номер телефона продавца: <b>${authorProduct.phoneNumber}</b></p>

    <!-- Кнопки "Избранное" -->
    <div class="form-inline-center">
        <form action="/favorites/add/${product.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-primary custom-button">Добавить в избранное</button>
        </form>
        <form action="/favorites/remove/${product.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger custom-button">Удалить из избранного</button>
        </form>
    </div>

    <!-- Кнопка "Добавить в корзину" -->
    <div class="form-inline-center">
        <form action="/cart/add" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="productId" value="${product.id}"/>
            <input type="number" name="quantity" value="1" min="1" class="form-control quantity-input"/>
            <button type="submit" class="btn btn-warning custom-button">Добавить в корзину</button>
        </form>
    </div>

    <!-- Кнопка "Выгрузить в PDF" -->
    <div class="form-inline-center">
        <a href="/product/${product.id}/pdf" class="btn btn-success custom-button">Выгрузить в PDF</a>
    </div>

    <!-- Кнопка "Удалить товар" для администратора -->
    <#if user.roles?map(role -> role.name())?seq_contains("ROLE_ADMIN")>
        <div class="form-inline-center">
            <form action="/product/delete/${product.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-danger custom-button">Удалить товар</button>
            </form>
        </div>
    </#if>

    <hr>
    <p style="text-align: center">
        <a href="/user/${authorProduct.id}">
            <img src="/static/images/avatar.png" alt="mdo" width="32" height="32" class="rounded-circle"> ${authorProduct.name}
        </a>
    </p>
</@t.template>
