package FlowPlugin::Qlik;
use JSON;
use strict;
use warnings;
use base qw/FlowPDF/;
use FlowPDF::Log;

# Feel free to use new libraries here, e.g. use File::Temp;

# Service function that is being used to set some metadata for a plugin.
sub pluginInfo {
    return {
        pluginName          => '@PLUGIN_KEY@',
        pluginVersion       => '@PLUGIN_VERSION@',
        configFields        => ['config'],
        configLocations     => ['ec_plugin_cfgs'],
        defaultConfigValues => {}
    };
}

## === check connection ends ===

# Auto-generated method for the procedure Sample REST Procedure/Sample REST Procedure
# Add your code into this method and it will be called when step runs
# Parameter: config
# Parameter: username

sub sampleRESTProcedure {
    my ($pluginObject) = @_;

    my $context = $pluginObject->getContext();
    my $params = $context->getRuntimeParameters();

    my $ECQlikRESTClient = $pluginObject->getECQlikRESTClient;
    # If you have changed your parameters in the procedure declaration, add/remove them here
    my %restParams = (
        'username' => $params->{'username'},
    );
    my $response = $ECQlikRESTClient->getUser(%restParams);
    logInfo("Got response from the server: ", $response);

    my $stepResult = $context->newStepResult;

    $stepResult->apply();
}
# This method is used to access auto-generated REST client.
sub getECQlikRESTClient {
    my ($self) = @_;

    my $context = $self->getContext();
    my $config = $context->getRuntimeParameters();
    require FlowPlugin::ECQlikRESTClient;
    my $client = FlowPlugin::ECQlikRESTClient->createFromConfig($config);
    return $client;
}
# Auto-generated method for the procedure Get Application Id/Get Application Id
# Add your code into this method and it will be called when step runs
# Parameter: config
# Parameter: appId

sub getApplicationId {
    my ($pluginObject) = @_;

    my $context = $pluginObject->getContext();
    my $params = $context->getRuntimeParameters();

    my $ECQlikRESTClient = $pluginObject->getECQlikRESTClient;
    # If you have changed your parameters in the procedure declaration, add/remove them here
    my %restParams = (
        'appId' => $params->{'appId'},
    );
    my $response = $ECQlikRESTClient->getAppById(%restParams);
    logInfo("Got response from the server: ", $response);

    my $stepResult = $context->newStepResult;
    $stepResult->setOutputParameter('application', encode_json($response));

    $stepResult->apply();
}
## === step ends ===
# Please do not remove the marker above, it is used to place new procedures into this file.


1;