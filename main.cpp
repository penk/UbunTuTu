#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("applicationDirPath", app.applicationDirPath());
    engine.load(QUrl::fromLocalFile(app.applicationDirPath() + "/qml/main.qml"));

    return app.exec();
}
