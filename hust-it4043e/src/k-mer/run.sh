hadoop jar ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -file hw1/kmer/mapper.py -mapper "python3 mapper.py" \
    -file hw1/kmer/reducer.py -reducer "python3 reducer.py" \
    -input hw1/kmer/input -output hw1/kmer/output \
    -cmdenv k=3