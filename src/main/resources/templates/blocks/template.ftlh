<#macro template user>
    <!doctype html>
    <html lang="ru">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="/static/css/style.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
              integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
              crossorigin="anonymous">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <title>OnlineStore</title>
        <style>
            /* Кастомные стили для текста */
            .modal-title {
                color: #000 !important; /* Черный цвет для заголовков */
                font-weight: 600 !important; /* Полужирный */
            }
            .modal-body p {
                color: #212529 !important; /* Темно-серый (почти черный) */
                font-weight: 400 !important;
            }
            .modal-body i {
                color: #007bff !important; /* Синий для иконок */
            }
            /* Стили для выпадающего меню */
            .navbar-dark .dropdown-menu {
                background-color: #343a40;
            }
            .navbar-dark .dropdown-item {
                color: #fff !important;
            }
            .navbar-dark .dropdown-item:hover {
                background-color: rgba(255,255,255,0.1);
            }
        </style>
    </head>
    <body>
    <!-- Навигационная панель -->
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <a href="/">
                <span class="navbar-brand mb-0 h1">OnlineStore</span>
            </a>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-dark dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-list"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#aboutModal">О компании</a>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#contactsModal">Контакты</a>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#promotionsModal">Акции и скидки</a>
                    </div>
                </div>

                <#if user.email??>
                    <div class="dropdown text-end ml-3">
                        <a href="/profile">
                            <img src="/static/images/avatar.png" alt="mdo" width="32" height="32" class="rounded-circle">
                        </a>
                    </div>
                <#else>
                    <button class="btn btn-light my-2 my-sm-0" type="button" onclick="window.location.href = '/login'">
                        Войти
                    </button>
                </#if>
            </div>
        </div>
    </nav>

    <!-- Основной контент -->
    <div class="container mt-4">
        <#nested/>
    </div>

    <!-- Модальные окна с исправленными стилями текста -->
    <div class="modal fade" id="aboutModal" tabindex="-1" aria-labelledby="aboutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="aboutModalLabel">О компании</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="mb-3">Мы — ваш надежный партнер в мире онлайн-шопинга. У нас вы найдете лучшие товары по выгодным ценам. Мы заботимся о каждом клиенте и гарантируем качество!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Закрыть</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="contactsModal" tabindex="-1" aria-labelledby="contactsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="contactsModalLabel">Контакты</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="mb-2"><i class="bi bi-geo-alt mr-2"></i> Адрес: ул. Примерная, 123, г. Санкт-Петербург</p>
                    <p class="mb-2"><i class="bi bi-telephone mr-2"></i> Телефон: +7 (123) 456-78-90</p>
                    <p class="mb-0"><i class="bi bi-envelope mr-2"></i> Email: info@onlinestore.com</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Закрыть</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="promotionsModal" tabindex="-1" aria-labelledby="promotionsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="promotionsModalLabel">Акции и скидки</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="mb-3 text-success"><i class="bi bi-emoji-smile mr-2"></i> Скидка 10% на все товары до конца месяца!</p>
                    <p class="mb-0 text-info"><i class="bi bi-truck mr-2"></i> Бесплатная доставка при заказе от 10 000 ₽.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Закрыть</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Скрипты -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            crossorigin="anonymous"></script>
    </body>
    </html>
</#macro>