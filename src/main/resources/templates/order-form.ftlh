<#ftl encoding="UTF-8">
<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Оформление заказа</h1>
    <hr>
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
        <#list products as product>
            <input type="hidden" name="productIds" value="${product.id}">
        </#list>
        <button type="submit" class="btn btn-dark w-100">Оформить заказ</button>
    </form>
</@t.template>