package expo.modules.mainconbra;

import android.util.Log;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import androidx.annotation.NonNull;

import ai.picovoice.android.voiceprocessor.VoiceProcessor;
import ai.picovoice.android.voiceprocessor.VoiceProcessorException;
import ai.picovoice.cobra.Cobra;
import ai.picovoice.cobra.CobraActivationException;
import ai.picovoice.cobra.CobraActivationLimitException;
import ai.picovoice.cobra.CobraActivationRefusedException;
import ai.picovoice.cobra.CobraActivationThrottledException;
import ai.picovoice.cobra.CobraException;
import ai.picovoice.cobra.CobraInvalidArgumentException;

public class cobraMainClass {
    public static final String ACCESS_KEY = "CgDGZHMYBX4fQSEOwGAZEAQDBTd9Zvlf/EJOuFdbie6FF3cA50K1kg==";

    public final VoiceProcessor voiceProcessor = VoiceProcessor.getInstance();

    public Cobra cobra;
    private float ALPHA = (float) 0.5;
    public float THRESHOLD = (float) 0.8;
    public float voiceProbability = (float) 0.0;
    public int secondsBetweenCollection = 60;
    private LocalDateTime lastChange = LocalDateTime.now();

 //   public ToggleButton recordButton;
    public boolean isActive;
    public TextView detectedText;
    
    public CountDownTimer visibilityTimer;

    public void init(String interval) {
//    public void onCreate() {
        Log.d("Init", "This is a debug message");

        secondsBetweenCollection = Integer.parseInt(interval);
        isActive = false;
        visibilityTimer = new CountDownTimer(750, 750) {
            public void onTick(long l) {
            //    detectedText.setVisibility(View.VISIBLE);
            }

            public void onFinish() {
            //    detectedText.setVisibility(View.INVISIBLE);
            }
        };

        try {
            cobra = new Cobra(ACCESS_KEY);
        } catch (CobraInvalidArgumentException e) {
            onCobraInitError(e.getMessage());
        } catch (CobraActivationException e) {
            onCobraInitError("AccessKey activation error");
        } catch (CobraActivationLimitException e) {
            onCobraInitError("AccessKey reached its device limit");
        } catch (CobraActivationRefusedException e) {
            onCobraInitError("AccessKey refused");
        } catch (CobraActivationThrottledException e) {
            onCobraInitError("AccessKey has been throttled");
        } catch (CobraException e) {
            onCobraInitError("Failed to initialize Cobra " + e.getMessage());
        }
        float frameLength = cobra.getFrameLength();
               
        voiceProcessor.addFrameListener(frame -> {
            try {
                final float rawVoiceProbability = cobra.process(frame);
                // voiceProbability = rawVoiceProbability;
                setProbability(rawVoiceProbability);
            } catch (CobraException e) {
                voiceProbability = -1;
                //runOnUiThread(() -> displayError(e.toString()));
            }
        });

        voiceProcessor.addErrorListener(error -> {
            //runOnUiThread(() -> displayError(error.toString()));
        });
    }

    public String getVoiceProbability()
    {
        String retval = String.valueOf(voiceProbability); 
        if (voiceProbability >= THRESHOLD) 
            retval += " - Voice Detected!";
        return retval;
    }
     public void onDestroy() {
        cobra.delete();
    }

    public void onCobraInitError(String error) {
        //TextView errorMessage = findViewById(R.id.errorMessage);
        //errorMessage.setText(error);
        //errorMessage.setVisibility(View.VISIBLE);

        //recordButton.setEnabled(false);
        //recordButton.setBackground(ContextCompat.getDrawable(this, R.drawable.button_disabled));
    }

    public void displayError(String message) {
        //Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    public void requestRecordPermission() {
//        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECORD_AUDIO}, 0);
    }
    public void toggle() {
                Log.d("Init", "This is a debug message");

        try {
            if (!isActive) {
                voiceProcessor.start(cobra.getFrameLength(), cobra.getSampleRate());
                isActive = true;
            } else {
                voiceProcessor.stop();
                isActive = false;
            }
        } catch (VoiceProcessorException e) {
            //displayError(e.getMessage());
        }
    }
    private void setProbability(float value) {
        //voiceProbability = (ALPHA * value) + ((1 - ALPHA) * voiceProbability);
        if (value >= voiceProbability) {
            lastChange = LocalDateTime.now(); // Mark the time of change
            voiceProbability = ALPHA * value + (1 - ALPHA) * voiceProbability;
        } else {
            if (lastChange.plusSeconds(secondsBetweenCollection).isBefore(LocalDateTime.now())) {
                // Only update the probability if more than the defined seconds have passed.
                voiceProbability = ALPHA * value + (1 - ALPHA) * voiceProbability;
                lastChange = LocalDateTime.now(); // Reset the last change time
            }
        }
    }

/*
        if (self.voiceProbability >= self.THRESHOLD) {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) {_ in
                self.detectedText = ""
            }
            self.detectedText = "Voice Detected!"
            newStr += " - Voice Detected!"
        }
        print ("New Propability", self.voiceProbability)
*/

}