<#ftl encoding="UTF-8">
<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Мои заказы</h1>
    <hr>
    <#if orders?? && orders?size gt 0>
        <div class="card-columns">
            <#list orders as order>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Заказ №${order.id}</h5>
                        <p class="card-text">Статус: ${order.status}</p>
                        <p class="card-text">Способ оплаты: ${order.paymentMethod}</p>
                        <p class="card-text">Адрес доставки: ${order.deliveryAddress}</p>
                        <p class="card-text">Дата создания: ${order.createdAt}</p>
                        <h6>Товары:</h6>
                        <ul>
                            <#list order.items as item>
                                <li>${item.product.title} - ${item.price} ₽</li>
                            </#list>
                        </ul>
                        <#if order.status == "В обработке">
                            <form action="/orders/${order.id}/delete" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit" class="btn btn-danger">Удалить заказ</button>
                            </form>
                        </#if>
                    </div>
                </div>
            </#list>
        </div>
    <#else>
        <h3 style="text-align: center">У вас пока нет заказов.</h3>
    </#if>
</@t.template>