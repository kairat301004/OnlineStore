<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        :root {
            --bg-color: #ffffff;
            --text-color: #343a40;
            --card-bg: #f8f9fa;
            --primary-color: #336218;
            --danger-color: #dc3545;
            --border-color: #dee2e6;
        }

        .dark-theme {
            --bg-color: #121212;
            --text-color: #e0e0e0;
            --card-bg: #1e1e1e;
            --primary-color: #4caf50;
            --danger-color: #f44336;
            --border-color: #424242;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: all 0.3s ease;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .sidebar {
            width: 280px;
            text-align: center;
            background: var(--card-bg);
            color: var(--text-color);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .sidebar img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 2px solid var(--border-color);
            object-fit: cover;
        }

        .grid-container {
            flex-grow: 1;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
        }

        .tile {
            background: var(--card-bg);
            color: var(--text-color);
            padding: 15px;
            text-align: center;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            font-weight: bold;
            border: 1px solid var(--border-color);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .tile:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }

        .tile i {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .btn-dark {
            background-color: var(--primary-color);
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.3s ease;
            cursor: pointer;
            font-weight: 500;
        }

        .btn-dark:hover {
            background-color: #2a5214;
            transform: translateY(-1px);
        }

        .footer {
            background: var(--card-bg);
            color: var(--text-color);
            padding: 20px;
            text-align: center;
            margin-top: 40px;
            border-top: 1px solid var(--border-color);
        }

        .theme-switcher-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }

        .theme-switcher {
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 20px;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            position: relative;
        }

        .theme-switcher:hover {
            transform: scale(1.1);
        }

        .theme-switcher:hover::after {
            content: "Тема сохраняется автоматически. Рекомендуем темный режим для работы ночью.";
            position: absolute;
            right: 60px;
            bottom: 50%;
            transform: translateY(50%);
            min-width: 200px;
            max-width: 300px;
            background: var(--card-bg);
            color: var(--text-color);
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 100;
            font-weight: normal;
            font-size: 14px;
            border: 1px solid var(--border-color);
        }

        .help-btn {
            position: fixed;
            bottom: 140px;
            right: 20px;
            z-index: 1000;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 20px;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .help-btn:hover {
            transform: scale(1.1);
        }

        .help-icon {
            margin-left: 5px;
            cursor: help;
            color: var(--primary-color);
            position: relative;
            display: inline-block;
        }

        .help-icon:hover::after {
            content: attr(data-tooltip);
            position: absolute;
            left: 100%;
            top: 0;
            min-width: 200px;
            max-width: 300px;
            background: var(--card-bg);
            color: var(--text-color);
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 100;
            font-weight: normal;
            font-size: 14px;
            border: 1px solid var(--border-color);
        }

        .help-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1050;
            overflow-y: auto;
        }

        .help-modal-content {
            background: var(--card-bg);
            margin: 5% auto;
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 800px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            border: 1px solid var(--border-color);
            animation: modalFadeIn 0.3s ease;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .help-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .help-modal-title {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin: 0;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
        }

        .help-modal-close {
            font-size: 1.8rem;
            cursor: pointer;
            color: var(--text-color);
            background: none;
            border: none;
            transition: all 0.2s ease;
        }

        .help-modal-close:hover {
            color: var(--danger-color);
            transform: rotate(90deg);
        }

        .faq-container {
            max-height: 60vh;
            overflow-y: auto;
            padding-right: 10px;
        }

        .faq-item {
            margin-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 20px;
        }

        .faq-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .faq-question {
            font-weight: 600;
            font-size: 1.2rem;
            color: var(--text-color);
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            transition: all 0.2s ease;
        }

        .faq-question:hover {
            color: var(--primary-color);
        }

        .faq-answer {
            margin-top: 10px;
            padding: 15px;
            background: rgba(0,0,0,0.03);
            border-radius: 8px;
            display: none;
            animation: fadeIn 0.3s ease;
        }

        .faq-item.active .faq-answer {
            display: block;
        }

        .faq-toggle {
            font-size: 1.3rem;
            color: var(--primary-color);
            margin-left: 15px;
            transition: all 0.2s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section-title {
            font-size: 1.4rem;
            color: var(--primary-color);
            margin: 30px 0 15px;
            padding-bottom: 5px;
            border-bottom: 1px solid var(--border-color);
        }

        .instruction-content ol {
            padding-left: 25px;
            counter-reset: step;
        }

        .instruction-content li {
            margin-bottom: 15px;
            padding-left: 15px;
            position: relative;
            line-height: 1.6;
        }

        .instruction-content li:before {
            content: counter(step);
            counter-increment: step;
            position: absolute;
            left: -25px;
            top: 0;
            background: var(--primary-color);
            color: white;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            text-align: center;
            line-height: 20px;
            font-size: 0.9rem;
        }

        .glossary-content dt {
            font-weight: 600;
            color: var(--primary-color);
            margin-top: 15px;
        }

        .glossary-content dd {
            margin-left: 20px;
            margin-bottom: 15px;
            padding-left: 10px;
            border-left: 2px solid var(--border-color);
        }

        .contact-content ul {
            list-style: none;
            padding-left: 0;
        }

        .contact-content li {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .contact-content i {
            font-size: 1.2rem;
            margin-right: 10px;
            width: 25px;
        }
    </style>

    <div class="container mt-4">
        <h1 class="text-center mb-4">Личный кабинет</h1>
        <div class="profile-container">
            <div class="sidebar">
                <#if user.avatar??>
                    <img src="/images/${user.avatar.id}">
                <#else>
                    <img src="/static/images/avatar.png">
                </#if>
                <h3>${user.name}</h3>
                <p><b>${user.email}</b></p>
                <p><b>${user.phoneNumber}</b></p>
                <form id="uploadForm" action="/profile/upload-avatar" method="post" enctype="multipart/form-data">
                    <input type="file" name="file" id="fileInput" style="display: none;">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <button type="button" id="uploadButton" class="btn btn-dark btn-sm">Загрузить аватар</button>
                    <span class="help-icon" data-tooltip="Нажмите на кнопку Загрузить аватар и выберите изображение из вашего устройства. Допустимые форматы: JPG, PNG, WebP (до 5 МБ). Оптимальный размер: 200×200 px.">
                        <i class="bi bi-question-circle"></i>
                    </span>
                </form>
            </div>

            <div class="grid-container">
                <#if user.isAdmin()>
                    <a href="/admin" class="tile">
                        <i class="bi bi-gear"></i>
                        <span>Админ-панель</span>
                    </a>
                </#if>
                <a href="/my/products" class="tile">
                    <i class="bi bi-box-seam"></i>
                    <span>Мои товары</span>
                </a>
                <a href="/favorites" class="tile">
                    <i class="bi bi-heart"></i>
                    <span>Избранное</span>
                    <span class="help-icon" data-tooltip="Нажмите на кнопку Добавить в избранное на карточке товара, чтобы добавить его сюда. Список доступен на всех ваших устройствах.">
                        <i class="bi bi-question-circle"></i>
                    </span>
                </a>
                <a href="/orders" class="tile">
                    <i class="bi bi-receipt"></i>
                    <span>Мои заказы</span>
                </a>
                <a href="/cart" class="tile">
                    <i class="bi bi-cart"></i>
                    <span>Корзина</span>
                </a>
                <form action="/logout" method="post" class="tile" style="background: var(--danger-color);">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" style="border: none; background: none; color: white; font-weight: bold; width: 100%; height: 100%;">
                        <i class="bi bi-box-arrow-right"></i>
                        <span>Выйти</span>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <button class="help-btn" id="helpBtn">
        <i class="bi bi-question-lg"></i>
    </button>

    <div class="help-modal" id="helpModal">
        <div class="help-modal-content">
            <div class="help-modal-header">
                <h2 class="help-modal-title">Руководство пользователя</h2>
                <button class="help-modal-close" id="helpModalClose">&times;</button>
            </div>
            <div class="faq-container">
                <h3 class="section-title">Часто задаваемые вопросы (FAQ)</h3>
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Как оформить заказ онлайн?</span>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div class="faq-answer">
                        <ol>
                            <li>Добавьте товары в корзину</li>
                            <li>Перейдите в раздел "Корзина"</li>
                            <li>Выберите способ оплаты и доставки</li>
                            <li>Подтвердите заказ</li>
                        </ol>
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Как работать с избранными товарами?</span>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div class="faq-answer">
                        <h3 class="section-title">Добавление товара в избранное:</h3>
                        <ol>
                            <li>Откройте страницу иинтересующего товара</li>
                            <li>Нажмите кнопку "Добавить в избранное"</li>
                            <li>Товар автоматически добавится в список избранного</li>
                        </ol>
                        <h3 class="section-title">Просмотр избранных товаров:</h3>
                        <ol>
                            <li>Перейдите в раздел "Избранное" через меню личного кабинета</li>
                            <li>Просматривайте все добавленные товарыв одном месте"</li>
                        </ol>
                        <h3 class="section-title">Удаление товара из избранного:</h3>
                        <ol>
                            <li>Откройте раздел страницу товара в разделе "Избранное"</li>
                            <li>Нажмите кнопку "Удалить из избранного"</li>
                        </ol>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <span>Как опубликовать товар?</span>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div class="faq-answer">
                        <ol>
                            <li>Перейдите в "Мои товары"</li>
                            <li>Нажмите "Добавить новый товар"</li>
                            <li>Заполните информацию о товаре</li>
                            <li>Загрузите фотографии товара</li>
                            <li>Нажмите кнопку "Добавить"</li>
                        </ol>
                    </div>
                </div>

                <h3 class="section-title">Пошаговая инструкция</h3>
                <div class="instruction-content">
                    <div class="faq-item">
                        <div class="faq-question">
                            <li><span>Регистрация аккаунта</span></li>
                            <span class="faq-toggle">+</span>
                        </div>
                        <div class="faq-answer">
                            <ol>
                                <li>Заполните все необходимые поля</li>
                                <li>Укажите актуальный номер телефона и email</li>
                                <li>Нажмите кнопку зарегистрироваться</li>
                                <li>Далее, зайдите в свой личный кабинет используя email которую указали
                                при регистрации и пароль.</li>
                            </ol>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <li><span>Настройка профиля</span></li>
                            <span class="faq-toggle">+</span>
                        </div>
                        <div class="faq-answer">
                            <ol>
                                <li>Настройте профиль под себя</li>
                                <li>Загрузите аватар</li>
                                <li>Изменяйте информацию о пользователе при необходимости</li>
                            </ol>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <li><span>Работа с товарами</span></li>
                            <span class="faq-toggle">+</span>
                        </div>
                        <div class="faq-answer">
                            <ol>
                                <h4>Чтобы опубликовать свой товар на сайте, необходимо:</h4>
                                <li>Перейти в раздел "Мои товары" -> "Добавить новый товар"</li>
                                <li>Заполнить корректно все необходимые поля</li>
                                <li>Нажать кнопку "Добавить"</li>
                            </ol>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <li><span>Оформление покупок</span></li>
                            <span class="faq-toggle">+</span>
                        </div>
                        <div class="faq-answer">
                            <ol>
                                <h4>Чтобы оформить покупку, необходимо:</h4>
                                <li>Добавить необходимый товар в корзину -> перейти в раздел "Корзина" в личном кабинете</li>
                                <li>Указать способ оплаты "Наличными или Картой"</li>
                                <li>Указать адрес доставки</li>
                                <li>Нажать кнопку "Оформить заказ"</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <h3 class="section-title">Глоссарий терминов</h3>
                <div class="glossary-content">
                    <dl>
                        <dt>Личный кабинет</dt>
                        <dd>Персональное пространство пользователя</dd>
                        <dt>Корзина</dt>
                        <dd>Временное хранилище товаров</dd>
                        <dt>Избранное</dt>
                        <dd>Список отложенных товаров</dd>
                    </dl>
                </div>

                <h3 class="section-title">Контактная информация</h3>
                <div class="contact-content">
                    <ul>
                        <li><i class="bi bi-telephone"></i>+7 (999) 123-45-67</li>
                        <li><i class="bi bi-envelope"></i>support@example.com</li>
                        <li><i class="bi bi-geo-alt"></i>Санкт-Петербург, ул. Примерная, 1</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container text-center">
            <p>© 2024 OnlineStore. Все права защищены.</p>
        </div>
    </footer>

    <div class="theme-switcher-container">
        <button class="theme-switcher" id="themeSwitcher">
            <i class="bi bi-moon-fill"></i>
        </button>
    </div>

    <script>
        document.getElementById('uploadButton').addEventListener('click', function() {
            document.getElementById('fileInput').click();
        });

        document.getElementById('fileInput').addEventListener('change', function() {
            document.getElementById('uploadForm').submit();
        });

        const themeSwitcher = document.getElementById('themeSwitcher');
        const body = document.body;

        if (localStorage.getItem('theme') === 'dark') {
            body.classList.add('dark-theme');
            themeSwitcher.innerHTML = '<i class="bi bi-sun-fill"></i>';
        }

        themeSwitcher.addEventListener('click', function() {
            body.classList.toggle('dark-theme');
            const isDark = body.classList.contains('dark-theme');

            themeSwitcher.innerHTML = isDark
                ? '<i class="bi bi-sun-fill"></i>'
                : '<i class="bi bi-moon-fill"></i>';
            localStorage.setItem('theme', isDark ? 'dark' : 'light');
        });

        const helpBtn = document.getElementById('helpBtn');
        const helpModal = document.getElementById('helpModal');
        const helpModalClose = document.getElementById('helpModalClose');

        helpBtn.addEventListener('click', () => helpModal.style.display = 'block');
        helpModalClose.addEventListener('click', () => helpModal.style.display = 'none');
        window.addEventListener('click', (e) => e.target === helpModal && (helpModal.style.display = 'none'));

        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', () => {
                const item = question.parentNode;
                item.classList.toggle('active');
                question.querySelector('.faq-toggle').textContent =
                    item.classList.contains('active') ? '−' : '+';
            });
        });
    </script>
</@t.template>