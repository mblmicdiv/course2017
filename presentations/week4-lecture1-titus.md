# MBL Microbial Diversity morning lecture

## first lecture @ week 4

[Titus Brown](http://ivory.idyll.org/lab/), UC Davis.

### The week ahead

Lectures by Scott Dawson, Tracy Teal, and myself; guest lecture by Murat Eren on Anvi'o.

Lisa Johnson Cohen (grad student in my lab) will be around as well.

Labs/tutorials:
* genome annotation
* intro UNIX command line
* sourmash tool for fast genome search and comparison/etc.
* R for statistics & some RNAseq.

I will be in the lab, at lunch, and at some dinners
for this week as well as next week.

### Today's lecture: why sequence genomes?

Genomic content:
* Typical bacterial genome (let's be E. coli-centric!), size = ~1-10 Megabase pairs (Mbp)
* not much repeated, ~80% coding 
* Major unit = operon, 10-20kb = collection of genes + promotor region to regulate transcription (like sigma factors) in front
* Once activated, gene gets transcribed
![](https://i.imgur.com/vR4zGZL.png)
* Gene finding in bacteria are highly reliable, 
* Identification and interpretation (functionally significant binding) of promotor region, less reliable
* *Are genes that are related always next to each other?*  Naming is sometimes related to function, "near". Turning on transcription iniates transcription of entire operon. Dianne Newman, arsenic resistance genes, encoded by operon. Whether the reductase within arsenic detoxification required for arsenic respiration, answer = No. Just upstream. ([paper](http://aem.asm.org/content/69/5/2800.full))
* Just because gene is transrcribed, doesn't mean it is translated. Just because it is present, doesn't mean it's transcribed.  

Gene regulation:
* binding sites upstream 5' of transcriptions start site, can block sigma factors from binding to either stimulate or repress transcription (best studied lac operon, various collection of transcription factors that are associated)
* RNA is polycistronic -> protein
![](https://i.imgur.com/8863zZD.png)

Why you might care: e.g. nirS and nirK catalyze nitrite reduction, are encoded in the genome.

![](https://i.imgur.com/PPQt3jT.png)

Why sequence a genome?
* No more degenerate PCR!!
* Identification
* Cloning aid
* Understand organism better, clues to physiology
* Evolutionary fingerprints of past environments
* Comparative genomics
* Discovery! of things! (let's think about what we're interested first...)
~~* Why not?~~ (not really a good reason!)

Question: *Why not skip to proteomics?* (short answer, proteomics without a genome is difficult)

* Assume sequencing just works. If interested in sequencing technology details, ask Titus (or Lisa)
* Interpretation is the MAJOR challenge (takes challenge): gene finding (open reading frame detection), annotation (functional pathway, physiological capabilities)
* 99% of genes have unknown functions, strong inference but little experimental evidence

How to publish your genome?
* Gene finding and open reading frame prediction
* Jared, identifies gaps in genome announcement paper, supposed to be accessible to people who use the genomes, but often the language and information are not accessible. Document environmental metadata with table, metadata minimum you should provide
* transcriptome assisted culture: free-living growth limited without community, had to spike in metabolites then do RNAseq, then used that to design media

Pangenomes, and why they might matter for environmental isolations:

Species
A: ------<--------->----[----]------
B: ----[-----]-------<---->--------
C: ----<----------->----[----]<---->

<---> fuzz,genome gain, loss, transposon (lateral transfer), species-specific lifestyle adaptatoin, difficult to say much else about it
[---] essential, core metabolism life genes

null hypothesis ([neutral model of evolution](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5180405/)) with conserved genes are nonessential

Strains: % core conserved vs. # genomes
5-10% range, genes in common between species of E. coli for example
Growth and study of physiology quite different than just looking at genome structure

Nowhere close to being able to tell you what bacteria does solely based on looking at its genome.

Is converse true? Make physiological observations in lab, will that help to parse through genome structure?

Genomes are dynamic! And they will change. And poorly understand.

Quiz: Genome sequencing is:

1. An (occaionally useful) distrction from Real Biology
2. A solution to all the things
3. ???
4. ???
5. ???

![](https://i.imgur.com/r6XYLNP.png)

Check out [Valerie de Crecy Lagard's work](http://microcell.ufl.edu/valerie-de-crecy-lagard/) to see some inspiring work on how to track down biochemical pathways in distant bacteria.



