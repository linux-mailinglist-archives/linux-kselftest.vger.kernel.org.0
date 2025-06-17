Return-Path: <linux-kselftest+bounces-35215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5439ADD0E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6485B188A6A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292A2E7F26;
	Tue, 17 Jun 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oV/Q1qfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336E20C001;
	Tue, 17 Jun 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172692; cv=none; b=uH35XWIDhtB6nMrZtYx8WP55pn4sWEmbLogvRStFf+efCMqnYRHeX4gKW6j9xoeNn43YK5A9aCjnlPQxvxDPUDJ564JgHgARRj1UhWZpixNqQBvwC7m8N9JlSrbQtyz3t3pA+74bu4K2MPlE/3QhsAwupn9Qg9NxKD32BHSMuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172692; c=relaxed/simple;
	bh=VyHjRTqOfzaroymnLXyjHij86o2BvFG9B9owgRHE/2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLCrptvpu0V8Kl57ACpQxDOc4JoI3GBPkH6enWzsaJ2rMju6rOuiPrlXrKHpeGYLr3wMBvBhyr638YQaf5kqj94QJPN7/ywyLj+gpE4j1lRUeIXgY65gN4jcnQzs6wx1Ikafj0CN2Ygc1EX9BZ/yVGlQzAU/09NADhpayBjhB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oV/Q1qfk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEht5A012280;
	Tue, 17 Jun 2025 15:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5Pco8NtNLrHhB/yIwu2Z6bOKRZjDwP
	02vOI5xrCA/Fg=; b=oV/Q1qfkdX/Z+dafal7f6S2wkvMSpyiO95yDRCkizF/+c2
	g/hqvf8PKUhFL+lq4SOhEdALkkdzdPJH8FEtPr2yDYy1akVu4NJSQql/nrlCNpDG
	fYLVuJ6xoR3c3OyRuSg1FQDls2jqliaqfS9QE43bWRuwIP00L+U8DNC13W/pFBls
	shw3BE89dsZzECwctFUy1cPdQDjMkoSEGTgQbMgfNmUJihDWePn5EJBrpz2E0IlM
	flWta5QYj1HMPJ6qDPgN4sfpnksNggyZHRJMc8sQGE3eV5oM8Zof59FRAFB7f+6x
	xSGV4Y+ne8BDdY/ZgZQauCC4iUKhpvAbcBqk+KFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn904b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:04:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55HF4WPj018331;
	Tue, 17 Jun 2025 15:04:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn9042-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:04:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEsr6K010853;
	Tue, 17 Jun 2025 15:04:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtcb6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:04:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HF4TH946727498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 15:04:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DFF520040;
	Tue, 17 Jun 2025 15:04:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94B6E20049;
	Tue, 17 Jun 2025 15:04:25 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com (unknown [9.109.245.113])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Jun 2025 15:04:25 +0000 (GMT)
Date: Tue, 17 Jun 2025 20:34:14 +0530
From: donettom <donettom@linux.ibm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        baohua@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH 3/6] selftests/mm : fix test_prctl_fork_exec failure
Message-ID: <aFGD7qEQ6nHg1CTt@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-4-aboorvad@linux.ibm.com>
 <063206d1-9f60-44b0-a8e6-77b49ba4a871@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063206d1-9f60-44b0-a8e6-77b49ba4a871@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExNSBTYWx0ZWRfX/hgxeb7CRsvT LsyVsgTgBOMNXmr8Gxp4wzPt+ncDUuX/Dj6kzkBhVpe2Iiaax5TjuA81zLPsomkSbAsS2zLRL8j cPVwvFPjOsDiMyesylVVEZNbdLHh/XWTkSOPsvdytOizeIZM/rdlPSeF9aGx00m2QzxcwEYM9WZ
 uvel/It/zWq7d6KGSPGpQIj6P2oYXFFqekTLKXrcOxHCHE97M6LU5lLTjPT1bYfP4ddfack6te9 rjH6e3C99IiZdGAiJnpiu0YbZJ/TcasOqs43g9WQCq6hKcKwuM5kykDuIrVy8p6PMAgt9JFfxzA 2qfxCwqUSfvloxeVkdEBQfCGKLOF7Z5cf3h7jMk/YGyOxv47Rpf2IzD2s2WcchwRes7vignRMGI
 kg1e8qWZgITB8NdS0cT6V08jj7E9yeoao2byhtxzo+nSPaPRlUTvu74rqg+t4uYPQ57x5OLG
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68518400 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=cVMMt7Et61PNXrXzi4wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: inzRLXJe7eJSyI1kLE0mAF2I7rKUPx-7
X-Proofpoint-GUID: 6nWfDvfXN16jzlIKnOTpHO36bYZq-x_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170115

esOn Mon, Jun 16, 2025 at 09:58:38PM +0530, Dev Jain wrote:
> 
> On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
> > From: Donet Tom <donettom@linux.ibm.com>
> > 
> > execv argument is an array of pointers to null-terminated strings.
> > In this patch we added NULL in the execv argument to fix the test
> > failure.
> 
> Just a comment, how did this test suddenly start failing now? Also is a
> fixes tag required? Clearly I am missing something.
> 

This test has been failing on my machine since the version in which
it was introduced.

Will add the fixes-by tag in next version.


Below is the test result on 0374af1da077- mm/ksm: test case for prctl fork/exec workflow

./ksm_functional_tests 
TAP version 13
1..9
 [RUN] test_unmerge
ok 1 Pages were unmerged
 [RUN] test_unmerge_zero_pages
ok 2 KSM zero pages were unmerged
 [RUN] test_unmerge_discarded
ok 3 Pages were unmerged
 [RUN] test_unmerge_uffd_wp
ok 4 # SKIP UFFD_FEATURE_PAGEFAULT_FLAG_WP not available
 [RUN] test_prot_none
ok 5 Pages were unmerged
 [RUN] test_prctl
ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
 [RUN] test_prctl_fork
ok 7 PR_SET_MEMORY_MERGE value is inherited
 [RUN] test_prctl_fork_exec
 [RUN] test_prctl_unmerge
not ok 8 No pages got merged
Bail out! 1 out of 8 tests failed
 Planned tests != run tests (9 != 8)
 Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0
not ok 8 KSM not enabled
 [RUN] test_prctl_unmerge
ok 9 Pages were unmerged
Bail out! 1 out of 9 tests failed
 Totals: pass:7 fail:1 xfail:0 xpass:0 skip:1 error:0


With the above patch the test is passing.

 [RUN] test_prctl_fork_exec
ok 8 PR_SET_MEMORY_MERGE value is inherited

> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >   tools/testing/selftests/mm/ksm_functional_tests.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> > index d7d3c22c077a..6ea50272a0ba 100644
> > --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> > +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> > @@ -579,7 +579,7 @@ static void test_prctl_fork_exec(void)
> >   		return;
> >   	} else if (child_pid == 0) {
> >   		char *prg_name = "./ksm_functional_tests";
> > -		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
> > +		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME, NULL };
> >   		execv(prg_name, argv_for_program);
> >   		return;
> 

