import { StyleSheet, Text, View } from 'react-native';

import * as Cobra from 'picovoice-cobra-react-native';


export const startCobra = () =>
{
  Cobra.setCobra("60");
  return "cobra started"
}

export const stopCobra = async () => {  
  Cobra.stopCobra();
  console.log("Cobra stopped");
}


export default function App() {
  return (
    <View style={styles.container}>
      <Text>{startCobra()}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
