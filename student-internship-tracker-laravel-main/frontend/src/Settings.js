import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "./services/api";
import Topbar from "./Topbar";

export function SettingsModal({ onClose }) {
    const navigate = useNavigate();

    const [loading, setLoading] = useState(true);
    const [mode, setMode] = useState(() => localStorage.getItem("theme") || "light");

    const [notifEnabled, setNotifEnabled] = useState(true);
    const [savingNotif, setSavingNotif] = useState(false);

    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");

    useEffect(() => {
        const root = document.documentElement;
        if (mode === "dark") root.classList.add("dark-mode");
        else root.classList.remove("dark-mode");

        api
            .get("/notifications/enabled")
            .then((res) => {
                const v = res.data?.enabled;
                if (typeof v === "boolean") setNotifEnabled(v);
            })
            .catch(() => {})
            .finally(() => setLoading(false));
    }, []);

    const setTheme = (next) => {
        setMode(next);
        localStorage.setItem("theme", next);
        const root = document.documentElement;
        if (next === "dark") root.classList.add("dark-mode");
        else root.classList.remove("dark-mode");
    };

    const toggleNotif = async () => {
        setSavingNotif(true);
        setError("");
        setSuccess("");
        const next = !notifEnabled;

        setNotifEnabled(next);
        try {
            await api.put("/notifications/enabled", { enabled: next });
            setSuccess(next ? "Notifications enabled." : "Notifications disabled.");
        } catch (e) {
            setNotifEnabled(!next);
            setError(e?.response?.data?.message || "Failed to update notification setting.");
        } finally {
            setSavingNotif(false);
        }
    };

    if (loading) {
        return (
            <div className="modal-overlay" onClick={onClose}>
                <div className="modal-window settings-modal" onClick={(e) => e.stopPropagation()}>
                    <div className="dash-loading" style={{ minHeight: 200 }}>
                        <div className="dash-spinner"></div>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="modal-overlay" onClick={onClose}>
            <div className="modal-window settings-modal" onClick={(e) => e.stopPropagation()}>
                <header className="modal-header">
                    <div className="modal-header-left">
                        <i className="bi bi-gear-fill modal-header-icon"></i>
                        <div>
                            <h2 className="modal-title">Settings</h2>
                            <p className="modal-subtitle">Theme + notification preferences</p>
                        </div>
                    </div>
                    <button className="modal-close-btn" onClick={onClose}>
                        <i className="bi bi-x-lg"></i>
                    </button>
                </header>

                <div className="modal-body">
                    {error && (
                        <div className="pf-alert pf-alert-error">
                            <i className="bi bi-exclamation-circle-fill"></i> {error}
                            <button onClick={() => setError("")}><i className="bi bi-x"></i></button>
                        </div>
                    )}
                    {success && (
                        <div className="pf-alert pf-alert-success">
                            <i className="bi bi-check-circle-fill"></i> {success}
                            <button onClick={() => setSuccess("")}><i className="bi bi-x"></i></button>
                        </div>
                    )}

                    <section className="modal-section">
                        <h3 className="modal-section-title">
                            <i className="bi bi-moon-stars-fill"></i> Appearance
                        </h3>
                        <div className="modal-theme-buttons">
                            <button
                                type="button"
                                className={`modal-theme-btn ${mode === "light" ? "active" : ""}`}
                                onClick={() => setTheme("light")}
                            >
                                <i className="bi bi-sun"></i>
                                <div>
                                    <strong>Light</strong>
                                    <span>Use light theme</span>
                                </div>
                            </button>

                            <button
                                type="button"
                                className={`modal-theme-btn ${mode === "dark" ? "active" : ""}`}
                                onClick={() => setTheme("dark")}
                            >
                                <i className="bi bi-moon"></i>
                                <div>
                                    <strong>Dark</strong>
                                    <span>Use dark theme</span>
                                </div>
                            </button>
                        </div>
                    </section>

                    <section className="modal-section">
                        <h3 className="modal-section-title">
                            <i className="bi bi-bell-fill"></i> Notifications
                        </h3>
                        <div className="modal-notif-row">
                            <div className="modal-notif-info">
                                <div className="modal-notif-label">Notification status</div>
                                <div className="modal-notif-status">
                                    {notifEnabled ? "Enabled" : "Disabled"}
                                </div>
                            </div>

                            <button
                                className="modal-btn-toggle"
                                onClick={toggleNotif}
                                disabled={savingNotif}
                            >
                                {savingNotif ? "Saving..." : notifEnabled ? "Disable" : "Enable"}
                            </button>
                        </div>

                        <div className="modal-notif-hint">
                            {notifEnabled
                                ? "You will see updates in the bell icon (reports/supervision/activity)."
                                : "Notifications are turned off. The bell icon will show that notifications are disabled."}
                        </div>
                    </section>
                </div>

                <style>{`
                    .settings-modal {
                        width: 100%;
                        max-width: 480px;
                        padding: 0;
                    }
                    .modal-header {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        padding: 24px 26px 20px;
                        border-bottom: 1px solid var(--border);
                    }
                    .modal-header-left {
                        display: flex;
                        align-items: center;
                        gap: 14px;
                    }
                    .modal-header-icon {
                        width: 44px;
                        height: 44px;
                        border-radius: 13px;
                        background: rgba(37,99,235,0.1);
                        color: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 20px;
                        flex-shrink: 0;
                    }
                    .modal-title {
                        font-size: 18px;
                        font-weight: 900;
                        margin: 0;
                        color: var(--dark);
                    }
                    .modal-subtitle {
                        font-size: 12px;
                        color: var(--muted);
                        margin: 2px 0 0;
                        font-weight: 600;
                    }
                    .modal-close-btn {
                        width: 36px;
                        height: 36px;
                        border-radius: 10px;
                        border: 1.5px solid var(--border);
                        background: white;
                        color: var(--muted);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 15px;
                        cursor: pointer;
                        transition: 0.2s;
                    }
                    .modal-close-btn:hover {
                        background: #fef2f2;
                        color: #dc2626;
                        border-color: #fecaca;
                    }
                    .modal-body {
                        padding: 22px 26px 26px;
                        display: flex;
                        flex-direction: column;
                        gap: 20px;
                        max-height: 70vh;
                        overflow-y: auto;
                    }
                    .modal-section {
                        display: flex;
                        flex-direction: column;
                        gap: 12px;
                    }
                    .modal-section-title {
                        font-size: 14px;
                        font-weight: 900;
                        margin: 0;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        color: var(--dark);
                    }
                    .modal-section-title i {
                        color: var(--primary);
                        font-size: 15px;
                    }
                    .modal-theme-buttons {
                        display: flex;
                        gap: 10px;
                    }
                    .modal-theme-btn {
                        flex: 1;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        padding: 12px 14px;
                        border-radius: 13px;
                        border: 1.5px solid var(--border);
                        background: white;
                        cursor: pointer;
                        font-family: inherit;
                        text-align: left;
                        transition: 0.2s;
                        color: var(--dark);
                    }
                    .modal-theme-btn i {
                        font-size: 20px;
                        color: var(--primary);
                        flex-shrink: 0;
                    }
                    .modal-theme-btn div {
                        display: flex;
                        flex-direction: column;
                    }
                    .modal-theme-btn strong {
                        font-size: 13px;
                        font-weight: 800;
                        color: var(--dark);
                    }
                    .modal-theme-btn span {
                        font-size: 11px;
                        color: var(--muted);
                        font-weight: 500;
                    }
                    .modal-theme-btn.active {
                        border-color: var(--primary);
                        background: rgba(37,99,235,0.08);
                    }
                    .modal-theme-btn:hover {
                        border-color: var(--primary);
                        background: rgba(37,99,235,0.05);
                    }
                    .modal-notif-row {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        gap: 16px;
                    }
                    .modal-notif-info {
                        display: flex;
                        flex-direction: column;
                        gap: 3px;
                    }
                    .modal-notif-label {
                        font-weight: 800;
                        font-size: 14px;
                        color: var(--dark);
                    }
                    .modal-notif-status {
                        color: var(--muted);
                        font-size: 12px;
                        font-weight: 700;
                    }
                    .modal-btn-toggle {
                        padding: 10px 20px;
                        border-radius: 11px;
                        font-weight: 800;
                        font-size: 13px;
                        font-family: inherit;
                        cursor: pointer;
                        transition: 0.2s;
                        border: 1.5px solid var(--primary);
                    }
                    .modal-btn-toggle:disabled {
                        opacity: 0.7;
                        cursor: not-allowed;
                    }
                    .modal-notif-hint {
                        color: var(--muted);
                        font-size: 12px;
                        font-weight: 600;
                        line-height: 1.6;
                    }
                    .pf-alert {
                        display: flex; align-items: center; gap: 10px;
                        padding: 12px 16px; border-radius: 12px;
                        font-size: 14px; font-weight: 500;
                    }
                    .pf-alert button { margin-left: auto; background: none; border: none; cursor: pointer; opacity: 0.7; font-size: 16px; }
                    .pf-alert-error { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
                    .pf-alert-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
                    :root.dark-mode .pf-alert-error {
                        background: rgba(220,38,38,0.15);
                        color: #fca5a5;
                        border-color: rgba(220,38,38,0.3);
                    }
                    :root.dark-mode .pf-alert-success {
                        background: rgba(16,163,74,0.15);
                        color: #4ade80;
                        border-color: rgba(16,163,74,0.3);
                    }
                    :root.dark-mode .modal-close-btn {
                        background: rgba(15,23,42,0.8);
                        border-color: rgba(148,163,184,0.2);
                        color: #94a3b8;
                    }
                    :root.dark-mode .modal-close-btn:hover {
                        background: rgba(220,38,38,0.15);
                        color: #fca5a5;
                        border-color: rgba(220,38,38,0.3);
                    }
                    :root.dark-mode .modal-theme-btn {
                        background: rgba(15,23,42,0.8);
                        border-color: rgba(148,163,184,0.2);
                    }
                    :root.dark-mode .modal-theme-btn strong { color: #e2e8eb; }
                    :root.dark-mode .modal-theme-btn.active {
                        background: rgba(37,99,235,0.15);
                        border-color: var(--primary);
                    }
                    :root.dark-mode .modal-btn-toggle {
                        background: var(--primary);
                        color: white;
                        border-color: var(--primary);
                    }
                    :root.dark-mode .modal-btn-toggle:hover:not(:disabled) {
                        background: var(--primary-dark);
                    }
                    :root.dark-mode .modal-notif-label { color: #e2e8eb; }
                `}</style>
            </div>
        </div>
    );
}

function SettingsPage() {
    const navigate = useNavigate();

    const [loading, setLoading] = useState(true);
    const [mode, setMode] = useState(() => localStorage.getItem("theme") || "light");

    const [notifEnabled, setNotifEnabled] = useState(true);
    const [savingNotif, setSavingNotif] = useState(false);

    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");

    useEffect(() => {
        const root = document.documentElement;
        if (mode === "dark") root.classList.add("dark-mode");
        else root.classList.remove("dark-mode");

        api
            .get("/notifications/enabled")
            .then((res) => {
                const v = res.data?.enabled;
                if (typeof v === "boolean") setNotifEnabled(v);
            })
            .catch(() => {})
            .finally(() => setLoading(false));
    }, []);

    const setTheme = (next) => {
        setMode(next);
        localStorage.setItem("theme", next);
        const root = document.documentElement;
        if (next === "dark") root.classList.add("dark-mode");
        else root.classList.remove("dark-mode");
    };

    const toggleNotif = async () => {
        setSavingNotif(true);
        setError("");
        setSuccess("");
        const next = !notifEnabled;

        setNotifEnabled(next);
        try {
            await api.put("/notifications/enabled", { enabled: next });
            setSuccess(next ? "Notifications enabled." : "Notifications disabled.");
        } catch (e) {
            setNotifEnabled(!next);
            setError(e?.response?.data?.message || "Failed to update notification setting.");
        } finally {
            setSavingNotif(false);
        }
    };

    if (loading) {
        return (
            <div className="pro-dashboard">
                <div className="pro-main-wrapper" style={{ marginLeft: 0 }}>
                    <div className="dash-loading">
                        <div className="dash-spinner"></div>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="pro-dashboard">
            <div className="pro-main-wrapper" style={{ marginLeft: 0 }}>
                <Topbar title="Settings" subtitle="Theme + notification preferences" />

                <main className="pro-content">
                    {error && (
                        <div className="pf-alert pf-alert-error" style={{ marginBottom: 16, maxWidth: 720 }}>
                            <i className="bi bi-exclamation-circle-fill"></i> {error}
                            <button onClick={() => setError("")}>
                                <i className="bi bi-x"></i>
                            </button>
                        </div>
                    )}
                    {success && (
                        <div className="pf-alert pf-alert-success" style={{ marginBottom: 16, maxWidth: 720 }}>
                            <i className="bi bi-check-circle-fill"></i> {success}
                            <button onClick={() => setSuccess("")}>
                                <i className="bi bi-x"></i>
                            </button>
                        </div>
                    )}

                    <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 24, alignItems: "start" }}>
                        <section className="pro-card" style={{ maxWidth: 720 }}>
                            <div className="pro-card-header">
                                <h3>
                                    <i className="bi bi-moon-stars-fill"></i> Appearance
                                </h3>
                            </div>
                            <div className="pro-card-body">
                                <div style={{ display: "flex", gap: 12, alignItems: "center" }}>
                                    <button
                                        type="button"
                                        className="qa-vertical-btn"
                                        style={{
                                            flex: 1,
                                            borderColor: mode === "light" ? "var(--primary)" : undefined,
                                            background: mode === "light" ? "rgba(37,99,235,0.12)" : undefined,
                                        }}
                                        onClick={() => setTheme("light")}
                                    >
                                        <i className="bi bi-sun"></i>
                                        <div>
                                            <strong>Light</strong>
                                            <span>Use light theme</span>
                                        </div>
                                    </button>

                                    <button
                                        type="button"
                                        className="qa-vertical-btn"
                                        style={{
                                            flex: 1,
                                            borderColor: mode === "dark" ? "var(--primary)" : undefined,
                                            background: mode === "dark" ? "rgba(37,99,235,0.12)" : undefined,
                                        }}
                                        onClick={() => setTheme("dark")}
                                    >
                                        <i className="bi bi-moon"></i>
                                        <div>
                                            <strong>Dark</strong>
                                            <span>Use dark theme</span>
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </section>

                        <section className="pro-card" style={{ maxWidth: 720 }}>
                            <div className="pro-card-header">
                                <h3>
                                    <i className="bi bi-bell-fill"></i> Notifications
                                </h3>
                            </div>

                            <div className="pro-card-body">
                                <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 16 }}>
                                    <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
                                        <div style={{ fontWeight: 900, fontSize: 15 }}>Notification status</div>
                                        <div style={{ color: "var(--muted)", fontSize: 13, fontWeight: 600 }}>
                                            {notifEnabled ? "Enabled" : "Disabled"}
                                        </div>
                                    </div>

                                    <button
                                        className="modal-btn-save"
                                        onClick={toggleNotif}
                                        disabled={savingNotif}
                                        style={{
                                            background: notifEnabled ? "#f8fafc" : "var(--primary)",
                                            color: notifEnabled ? "var(--primary)" : "white",
                                            border: notifEnabled ? "1.5px solid var(--primary)" : "none",
                                            opacity: savingNotif ? 0.7 : 1,
                                        }}
                                    >
                                        {savingNotif ? "Saving..." : notifEnabled ? "Disable" : "Enable"}
                                    </button>
                                </div>

                                <div style={{ marginTop: 14, color: "var(--muted)", fontSize: 12, fontWeight: 600, lineHeight: 1.6 }}>
                                    {notifEnabled
                                        ? "You will see updates in the bell icon (reports/supervision/activity)."
                                        : "Notifications are turned off. The bell icon will show that notifications are disabled."}
                                </div>
                            </div>
                        </section>
                    </div>
                </main>

                <style>{`
          .pf-alert {
            display: flex; align-items: center; gap: 10px;
            padding: 12px 16px; border-radius: 12px; margin-bottom: 16px;
            font-size: 14px; font-weight: 500;
            max-width: 720px;
          }
          .pf-alert button { margin-left: auto; background: none; border: none; cursor: pointer; opacity: 0.7; font-size: 16px; }
          .pf-alert-error { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
          .pf-alert-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        `}</style>
            </div>
        </div>
    );
}

export default SettingsPage;

