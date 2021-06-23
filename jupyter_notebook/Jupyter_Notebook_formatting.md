[lin](#section2)

Click on the link above to jump down to bottom of page

Horizontal line as separator
***


Numbered list can start with number. and a space. Eg: 1. text

1. This
2. Is
3. A
4. Numbered
5. List

- list1
- list2
 - sublist1
 - sublist2
- list3
- list4

Line break<br>
can be<br>
done this<br>
way

This is without
using the 
line break tag

<font color=blue>Text</font>
<font color=red>Text</font>
<font color=green>Text</font>
<font color=pink>Text</font>
<font color=yellow>Text</font>

> this is a sample text indentation

# Title
## Heading 2
### Heading 3
#### Heading 4
##### Normal size - smallest possible heading

__Bold text__

_Italics_

`this is text for monospace font`

Mathematical symbols $>$

$x = x + y$


External links

[Jupyter Notebook formatting](https://medium.com/ibm-data-science-experience/markdown-for-jupyter-notebooks-cheatsheet-386c05aeebed)

Images inline
![image](https://imgbbb.com/images/2019/12/18/Screenshot-2019-12-18-at-12.55.36-PM.png)



```python
!pip install jupyterthemes
```


```python
!jt -l
```

    Available Themes: 
       chesterish
       grade3
       gruvboxd
       gruvboxl
       monokai
       oceans16
       onedork
       solarizedd
       solarizedl


Embedding URLs


```python
from IPython.display import IFrame
IFrame('http://raghupro.com', width=800, height=450)
```





<iframe
    width="800"
    height="450"
    src="http://raghupro.com"
    frameborder="0"
    allowfullscreen
></iframe>





```python
from IPython.display import IFrame
IFrame('https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', width=800, height=450)
```





<iframe
    width="800"
    height="450"
    src="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
    frameborder="0"
    allowfullscreen
></iframe>




Embedding youtube video. 

A general youtube video link looks like this
https://www.youtube.com/watch?v=RBSGKlAvoiM

Copy the text after v= i.e. "RBSGKlAvoiM"

Then use the code as given below


```python
from IPython.display import YouTubeVideo
YouTubeVideo('RBSGKlAvoiM', width=800, height=500)
```





<iframe
    width="800"
    height="500"
    src="https://www.youtube.com/embed/RBSGKlAvoiM"
    frameborder="0"
    allowfullscreen
></iframe>




[Advanced jupyter notebook formatting](https://towardsdatascience.com/bringing-the-best-out-of-jupyter-notebooks-for-data-science-f0871519ca29)

<a id="section2"></a>

Write sample code to jump tp this area


