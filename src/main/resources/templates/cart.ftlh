<#ftl encoding="UTF-8">
<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Корзина</h1>
    <hr>
    <#if cart?? && cart.items?? && cart.items?size gt 0>
        <div class="card-columns">
            <#list cart.items as item>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">${item.product.title}</h5>
                        <p class="card-text">Количество: ${item.quantity}</p>
                        <p class="card-text">Цена: ${item.product.price} ₽</p>
                        <form action="/cart/remove/${item.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-danger">Удалить</button>
                        </form>
                    </div>
                </div>
            </#list>
        </div>
        <form action="/order/create" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div class="form-group">
                <label for="paymentMethod">Способ оплаты</label>
                <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                    <option value="Карта">Карта</option>
                    <option value="Наличные">Наличные</option>
                </select>
            </div>
            <div class="form-group">
                <label for="deliveryAddress">Адрес доставки</label>
                <input type="text" class="form-control" id="deliveryAddress" name="deliveryAddress" required>
            </div>
            <#list cart.items as item>
                <input type="hidden" name="productIds" value="${item.product.id}">
            </#list>
            <button type="submit" class="btn btn-dark w-100">Оформить заказ</button>
        </form>
    <#else>
        <h3 style="text-align: center">Ваша корзина пуста.</h3>
    </#if>
</@t.template>