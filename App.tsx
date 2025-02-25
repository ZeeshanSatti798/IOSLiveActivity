import React, { useEffect } from 'react';
import {
    View,
    StyleSheet,
    Button,
    NativeModules,
    Linking,
    Alert,
} from 'react-native';

// Define the type for the Native Module
interface FoodDeliveryModule {
    startActivity: () => void;
    endActivity: () => void;
    updateActivity: (name: string, driverName: string, deliverTime: string) => void;
}

const { FoodDelivery } = NativeModules as { FoodDelivery: FoodDeliveryModule };

const App: React.FC = () => {
    useEffect(() => {
        console.log('Setting up deep link handler...');

        const extractDynamicValue = (url: string): string | null => {
            console.log('Extracting dynamic value from URL:', url);
            try {
                const params = new URLSearchParams(url.split('?')[1]);
                return params.get('value');
            } catch (error) {
                console.error('Failed to parse URL:', error);
                return null;
            }
        };

        const handleDeepLink = (event: { url: string }) => {
            console.log('Handling deep link...');
            const url = event.url;
            const value = extractDynamicValue(url);
            if (value) {
                console.log('Dynamic Value from Widget:', value);
                Alert.alert('Widget Opened', `Received value: ${value}`);
            }
        };

        const unsubscribe = Linking.addEventListener('url', handleDeepLink);

        Linking.getInitialURL()
            .then(url => {
                if (url) {
                    console.log('App launched with URL:', url);
                    const value = extractDynamicValue(url);
                    if (value) {
                        console.log('Dynamic Value from Widget on App Launch:', value);
                        Alert.alert('Widget Opened', `Received value on launch: ${value}`);
                    }
                }
            })
            .catch(error => console.error('Failed to get initial URL:', error));

        return () => {
            unsubscribe.remove();
            console.log('Deep link handler cleaned up');
        };
    }, []);

    const onStartActivity = () => {
        console.log('Starting Activity........');
        FoodDelivery.startActivity();
    };

    const onEndActivity = () => {
        console.log('Ending Activity........');
        FoodDelivery.endActivity();
    };

    const updateActivity = (name: string, driverName: string, deliverTime: string) => {
        console.log('Updating Activity........');
        FoodDelivery.updateActivity(name, driverName, deliverTime);
    };

    return (
        <View style={styles.container}>
            <Button title="Start Activity" onPress={onStartActivity} />
            <Button
                title="Update Activity"
                onPress={() => {
                    updateActivity('name', 'lsdkjflk', 'Order Pick-up');
                }}
            />
            <Button title="End Activity" onPress={onEndActivity} />
        </View>
    );
};

export default App;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
    },
});
