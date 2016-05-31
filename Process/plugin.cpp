#include <QDebug>
#include <QtQuick>
#include <QProcess>
#include <QtQml/qqml.h>
#include <QtQml/QQmlExtensionPlugin>

class ProcessModel : public QProcess
{
	Q_OBJECT

public:
	ProcessModel(QObject *parent=0) : QProcess(parent)
	{
	}

	~ProcessModel()
	{
	}

        Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
            QStringList args;
            for (int i = 0; i < arguments.length(); i++)
                args << arguments[i].toString();

            qDebug() << program << args;
            
            QProcess::start(program, args);
        }

        Q_INVOKABLE QByteArray readAll() {
            return QProcess::readAll();
        }
	Q_INVOKABLE void cmd(const QString &s) {
		qDebug() << s;
                QProcess::startDetached(s);
	}
};

class ProcessPlugin : public QQmlExtensionPlugin
{
	Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.slatekit.Process" FILE "process.json")

public:
	 void registerTypes(const char *uri)
	 {
		qmlRegisterType<ProcessModel>(uri, 1, 0, "Process");
	 }

};

#include "plugin.moc"
