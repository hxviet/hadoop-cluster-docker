hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/distinct/mapper-1.py -mapper "python3 mapper-1.py" \
    -file hw2/distinct/reducer-1.py -reducer "python3 reducer-1.py" \
    -input hw2/distinct/input/test -output hw2/distinct/output1 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/distinct/mapper-2.py -mapper "python3 mapper-2.py" \
    -file hw2/distinct/reducer-2.py -reducer "python3 reducer-2.py" \
    -input hw2/distinct/output1 -output hw2/distinct/output2 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/distinct/mapper-3.py -mapper "python3 mapper-3.py" \
    -file hw2/distinct/reducer-3.py -reducer "python3 reducer-3.py" \
    -input hw2/distinct/output2 -output hw2/distinct/output3 \
    -cmdenv n=10

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/distinct/mapper-4.py -mapper "python3 mapper-4.py" \
    -file hw2/distinct/reducer-4.py -reducer "python3 reducer-4.py" \
    -input hw2/distinct/output3 -output hw2/distinct/output4 \
    -cmdenv n=10