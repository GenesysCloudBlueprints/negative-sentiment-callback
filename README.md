# Proactively reach out to customers with negative sentiment score and create supervisor callback

This Blueprint is a series of Architect Flows with a Trigger that fires on every conversation finishing to analyze the sentiment score and determine if it was negative. For conversations with negative sentiment, the Architect Workflow sends the customer an SMS message acknowledging the issue, and creates a callback that is placed into a Queue staffed with supervisors or team leads to reach back out to the customer to see if anything can be done to help.

This trigger and workflow are designed to provide near-immediate notification to supervisors of calls with negative sentiment.  The workflow gets the interaction sentiment score and sends three different notification types:  SMS message, Scheduled Callback and/or chat group notification.  For demo purposes, this trigger is keyed off of a specific wrap-up code as we didn’t want every call interaction to trigger the workflow.  In a customer environment, the trigger would likely be executed at the end of each ACD interaction.

![Negative sentiment callback flow](blueprint/images/overview.png "Negative sentiment callback flow")
