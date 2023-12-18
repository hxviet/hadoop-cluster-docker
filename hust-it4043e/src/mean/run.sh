hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mean/mapper-1.py -mapper "python3 mapper-1.py" \
    -file hw2/mean/reducer-1.py -reducer "python3 reducer-1.py" \
    -input hw2/mean/input/simple -output hw2/mean/output1 \
    -cmdenv n=5

hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw2/mean/mapper-2.py -mapper "python3 mapper-2.py" \
    -file hw2/mean/reducer-2.py -reducer "python3 reducer-2.py" \
    -input hw2/mean/output1 -output hw2/mean/output2 \
    -cmdenv n=5