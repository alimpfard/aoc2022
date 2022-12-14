day=$1
shift

if [ -z "$day" ]; then
    echo "Usage: day.sh <day>"
    exit 1
fi

cat <<EOF > day$day.jakt
import day$day::part1 as p1
import day$day::part2 as p2

function main() {
    p1::solution()
    p2::solution()
}
EOF

mkdir -p day$day
ln -s ../utils.jakt day$day/utils.jakt

cat <<EOF | tee day$day/part1.jakt day$day/part2.jakt > /dev/null
import utils { read_file }

function solution() throws {
    let contents = read_file(path: "data/day$day")
}
EOF

git add day$day.jakt day$day
