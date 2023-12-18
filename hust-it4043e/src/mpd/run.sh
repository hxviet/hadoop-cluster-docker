hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-1.py -mapper "python3 mapper-1.py" \
    -file hw2/mpd/reducer-1.py -reducer "python3 reducer-1.py" \
    -input hw2/mpd/input/simple -output hw2/mpd/output1 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-2.py -mapper "python3 mapper-2.py" \
    -file hw2/mpd/reducer-2.py -reducer "python3 reducer-2.py" \
    -input hw2/mpd/output1 -output hw2/mpd/output2 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-3.py -mapper "python3 mapper-3.py" \
    -file hw2/mpd/reducer-3.py -reducer "python3 reducer-3.py" \
    -input hw2/mpd/output2 -output hw2/mpd/output3 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-4.py -mapper "python3 mapper-4.py" \
    -file hw2/mpd/reducer-4.py -reducer "python3 reducer-4.py" \
    -input hw2/mpd/output3 -output hw2/mpd/output4 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-5.py -mapper "python3 mapper-5.py" \
    -file hw2/mpd/reducer-5.py -reducer "python3 reducer-5.py" \
    -input hw2/mpd/output4 -output hw2/mpd/output5 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-6.py -mapper "python3 mapper-6.py" \
    -file hw2/mpd/reducer-6.py -reducer "python3 reducer-6.py" \
    -input hw2/mpd/output5 -output hw2/mpd/output6 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mpd/mapper-7.py -mapper "python3 mapper-7.py" \
    -file hw2/mpd/reducer-7.py -reducer "python3 reducer-7.py" \
    -input hw2/mpd/output6 -output hw2/mpd/output7 \
    -cmdenv n=10