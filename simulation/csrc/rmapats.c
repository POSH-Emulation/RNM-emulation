// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1293, EBLK  * I1288, U  I688);
void  hsG_0__0 (struct dummyq_struct * I1293, EBLK  * I1288, U  I688)
{
    U  I1558;
    U  I1559;
    U  I1560;
    struct futq * I1561;
    struct dummyq_struct * pQ = I1293;
    I1558 = ((U )vcs_clocks) + I688;
    I1560 = I1558 & ((1 << fHashTableSize) - 1);
    I1288->I733 = (EBLK  *)(-1);
    I1288->I734 = I1558;
    if (I1558 < (U )vcs_clocks) {
        I1559 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1288, I1559 + 1, I1558);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I688 == 1)) {
        I1288->I736 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I733 = I1288;
        peblkFutQ1Tail = I1288;
    }
    else if ((I1561 = pQ->I1198[I1560].I748)) {
        I1288->I736 = (struct eblk *)I1561->I747;
        I1561->I747->I733 = (RP )I1288;
        I1561->I747 = (RmaEblk  *)I1288;
    }
    else {
        sched_hsopt(pQ, I1288, I1558);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
