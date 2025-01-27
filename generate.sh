# Define parameters
subject=linear_algebra
filename=layout
fullname="$filename.tex"
output="temp"
quiz=1

# Topics dictionary
declare -A topics
topics[linear_algebra]="\'Algebra Lineal"
readarray -t questions <<< $(ls topics/$subject/ | grep '.tex$')

# Add parameters.
params="-output-directory=$output"
params="$params \def\topic{${topics[$subject]}}"
params="$params \def\quiz{$quiz}"

# Add questions.
for (( i = 0; i < ${#questions[@]}; i++ ))
{
j=$(($i+1))
content=$(< "topics/$subject/${questions[i]}")
params="$params \expandafter\def\csname question$j \endcsname{$content}"
}
params="$params \input{$fullname}"
pdflatex $params
cp "temp/$filename.pdf" "result.pdf"
