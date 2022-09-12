Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D65B5644
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiILIdb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiILIda (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 04:33:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152912774;
        Mon, 12 Sep 2022 01:33:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C6pUbF030337;
        Mon, 12 Sep 2022 08:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=EjE9zfjlnKovnDP6IZKDJlDIT/54CIuxhpam2s6FIVg=;
 b=ma0YAO+qizluQ+Meg2d3HpZXa6eNz6hS4xQyPuNBL5c2G5XueBcBMuueBHLihwnAE6Md
 68xxna8e8TW6GT7wdXR79OvRhQs6lBAb/uia88VHvhKSVesWCGIG4Ep+Bk3lVB2fvOy4
 fUvycYcnQfLqOmbvbdXl93dEGs/FZKBkJiOJ90Qw1GAMVzGzGFNPW8COld3zatF7oSSm
 0d8lroNrn/mjONbbYoWboInbv5qZYXeY6KnFJ+HqXJ40aR/604nKppDmV8Q6clfNCBCn
 UpkjoJikqsXmiPeTtFK0PA0doarNsa1J9OHrgeH/y3kDtHGPJob2nMOgUCa/5CV0ls3u hw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jhyv82xwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:33:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28C86Tm8003747;
        Mon, 12 Sep 2022 08:33:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3jgj79t35y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:33:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28C8XDDk33685950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 08:33:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5414252052;
        Mon, 12 Sep 2022 08:33:13 +0000 (GMT)
Received: from tarunpc (unknown [9.43.18.53])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B14935204E;
        Mon, 12 Sep 2022 08:33:11 +0000 (GMT)
Message-ID: <2412537e2e07ebf62fe95971a3022336cde9833a.camel@linux.ibm.com>
Subject: Re: [LTP] [RFC PATCH] Hugetlb: Migrating hugetlb tests from
 libhugetlbfs
From:   Tarun Sahu <tsahu@linux.ibm.com>
Reply-To: tsahu@linux.ibm.com
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Sep 2022 14:03:10 +0530
In-Reply-To: <YxsCJi8O+HmMpefq@yuki>
References: <20220908173947.17956-1-tsahu@linux.ibm.com>
         <YxsCJi8O+HmMpefq@yuki>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: evC1WQmHcygrKYDCWv4Qf0DyQYPjYVSm
X-Proofpoint-GUID: evC1WQmHcygrKYDCWv4Qf0DyQYPjYVSm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Cyril, Thanks for reviewing the patch.
Below I have added my
comments. Will update changes in V2.

On Fri, 2022-09-09 at 11:06 +0200,
Cyril Hrubis wrote:
> Hi!
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  runtest/hugetlb                               |   2 +
> >  testcases/kernel/mem/.gitignore               |   1 +
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 106
> > ++++++++++++++++++
> >  3 files changed, 109 insertions(+)
> >  create mode 100644
> > testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > 
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index f719217ab..ee02835d3 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -3,6 +3,8 @@ hugemmap02 hugemmap02
> >  hugemmap04 hugemmap04
> >  hugemmap05 hugemmap05
> >  hugemmap06 hugemmap06
> > +hugemmap07 hugemmap07
> > +
> >  hugemmap05_1 hugemmap05 -m
> >  hugemmap05_2 hugemmap05 -s
> >  hugemmap05_3 hugemmap05 -s -m
> > diff --git a/testcases/kernel/mem/.gitignore
> > b/testcases/kernel/mem/.gitignore
> > index ff2910533..df5256ec8 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -4,6 +4,7 @@
> >  /hugetlb/hugemmap/hugemmap04
> >  /hugetlb/hugemmap/hugemmap05
> >  /hugetlb/hugemmap/hugemmap06
> > +/hugetlb/hugemmap/hugemmap07
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > new file mode 100644
> > index 000000000..798735ed0
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > @@ -0,0 +1,106 @@
> > +/*
> > + * License/Copyright Details
> > + */
> 
> There should be a SPDX licence identifier here instead.
> 
> Also testcase should include a special ascii-doc formatted comment
> here
> that describes the purpose of the test.
As mentioned in the patch description, there is a conflict in license,
That is why, I have avoided to put any of them in the header. Once
confirmed within the community, I can add the original license here.
(GPL2.1+) as 
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
this says only to add code with GPL2.0+.

> 
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <sys/mount.h>
> > +#include <limits.h>
> > +#include <sys/param.h>
> > +#include <sys/types.h>
> > +
> > +#include "tst_test.h"
> > +
> > +#define P0 "ffffffff"
> > +#define IOSZ 4096
> > +char buf[IOSZ] __attribute__((aligned(IOSZ)));
> > +static int  fildes = -1, nfildes = -1;
> > +static char TEMPFILE[MAXPATHLEN];
> > +static char NTEMPFILE[MAXPATHLEN];
> 
> Uppercase is reserved for macros in C.
> 
> Have you run 'make check' to check for common mistakes before
> submitting?

> 
> > +void test_directio(void)
> 
> should be static
Ok Will update in V2.
> 
> > +{
> > +	long hpage_size;
> > +	void *p;
> > +	int ret;
> > +
> > +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:");
> > +
> > +	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0600);
> > +	nfildes = SAFE_OPEN(NTEMPFILE, O_CREAT|O_EXCL|O_RDWR|O_DIRECT,
> > 0600);
> 
> I would say that fd and nfd in the original code was were better
> names,
> shorter and to the point. See also:
> 
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

I agree, I tried to follow what was in hugemmap01..06 test cases to
keep things similar all across the tests. I will update it in v2.
> 
> > +	p = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
> > fildes, 0);
> > +	if (p == MAP_FAILED)
> > +		tst_brk(TFAIL | TERRNO, "mmap() Failed on %s",
> > TEMPFILE);
> 
> We do have SAFE_MMAP() as well.
Yeah, I will update them in v2.

> 
> > +	memcpy(p, P0, 8);
> > +
> > +	/* Direct write from huge page */
> > +	ret = write(nfildes, p, IOSZ);
> > +	if (ret == -1)
> > +		tst_brk(TFAIL | TERRNO, "Direct-IO write from huge
> > page");
> > +	if (ret != IOSZ)
> > +		tst_brk(TFAIL, "Short direct-IO write from huge page");
> > +	if (lseek(nfildes, 0, SEEK_SET) == -1)
> > +		tst_brk(TFAIL | TERRNO, "lseek");
> > +
> > +	/* Check for accuracy */
> > +	ret = read(nfildes, buf, IOSZ);
> > +	if (ret == -1)
> > +		tst_brk(TFAIL | TERRNO, "Direct-IO read to normal
> > memory");
> > +	if (ret != IOSZ)
> > +		tst_brk(TFAIL, "Short direct-IO read to normal
> > memory");
> > +	if (memcmp(P0, buf, 8))
> > +		tst_brk(TFAIL, "Memory mismatch after Direct-IO
> > write");
> > +	if (lseek(nfildes, 0, SEEK_SET) == -1)
> > +		tst_brk(TFAIL | TERRNO, "lseek");
> 
> And we have SAFE_WRITE(), SAFE_READ(), and SAFE_LSEEK() as well.
ok Will update these too in v2.

> 
> Also tst_brk(TFAIL, "") usage is deprecated and should not be used in
> new tests.

Ok, Will update it to tst_res.

> 
> > +	/* Direct read to huge page */
> > +	memset(p, 0, IOSZ);
> > +	ret = read(nfildes, p, IOSZ);
> > +	if (ret == -1)
> > +		tst_brk(TFAIL | TERRNO, "Direct-IO read to huge page");
> > +	if (ret != IOSZ)
> > +		tst_brk(TFAIL, "Short direct-IO read to huge page");
> > +
> > +	/* Check for accuracy */
> > +	if (memcmp(p, P0, 8))
> > +		tst_brk(TFAIL, "Memory mismatch after Direct-IO read");
> > +	tst_res(TPASS, "Successfully tested Hugepage Direct I/O");
> 
> You should close filedescriptors and unmap memory here, otherwise the
> test will fail with large enough -i parameter.

Ok, I will update it too in v2. 

> 
> > +}
> > +
> > +void setup(void)
> 
> should be static.

Ok Will update it in V2.
> 
> > +{
> > +	if (tst_hugepages == 0)
> > +		tst_brk(TCONF, "Not enough hugepages for testing.");
> > +
> > +	if (!Hopt)
> > +		Hopt = tst_get_tmpdir();
> > +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> > +
> > +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt,
> > getpid());
> 
> Ideally all files created outside of the test temporary directory
> should
> be prefixed with "ltp_"

ok, Will update it in V2.
> 
> > +	snprintf(NTEMPFILE, sizeof(NTEMPFILE), "%s/nmmapfile%d",
> > "/home/", getpid());
> 
> Please do not create any files outside of the test temporary
> directory,
> also as the temporary directory is unique already, there is no need
> to
> actually create the second tempfile name like this. All we need to do
> is
> to is something as:
> 
> #define NTEMPFILE "tempfile"
> 

Ok Will update it in V2.
> > +}
> > +
> > +void cleanup(void)
> > +{
> > +	close(fildes);
> > +	close(nfildes);
> > +	remove(TEMPFILE);
> > +	remove(NTEMPFILE);
> > +	umount2(Hopt, MNT_DETACH);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.needs_tmpdir = 1,
> > +	.options = (struct tst_option[]) {
> > +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
> > /var/hugetlbfs"},
> > +		{"s:", &nr_opt, "Set the number of the been allocated
> > hugepages"},
> > +		{}
> > +	},
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = test_directio,
> > +	.hugepages = {2, TST_REQUEST},
> > +};
> > -- 
> > 2.31.1
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp



