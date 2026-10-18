# TODO

## Settings + Notifications
- [ ] Add `frontend/src/Settings.js` (dark/light + notification enable/disable)
- [ ] Wire route `/settings` in `frontend/src/App.js`
- [ ] Update gear icon navigation in `frontend/src/Topbar.js` to `/settings`
- [ ] Implement dark mode in `frontend/src/index.css` using `.dark-mode` class
- [ ] Apply initial theme from `localStorage` in `frontend/src/index.js`
- [ ] Add DB column `notifications_enabled` to `backend/laravel/database/migrations/*`
- [ ] Update `backend/laravel/app/Models/User.php` fillable
- [ ] Add API endpoints + controller updates for reading/updating notification enabled state
- [ ] Update `backend/laravel/app/Http/Controllers/NotificationController.php` to return empty when disabled
- [ ] Update `frontend/src/Topbar.js` bell dropdown + badge behavior when notifications disabled

