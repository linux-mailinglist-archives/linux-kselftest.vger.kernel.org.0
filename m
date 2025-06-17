Return-Path: <linux-kselftest+bounces-35217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CD6ADD11B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE473BB452
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269C2E92A5;
	Tue, 17 Jun 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NCa84+KR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D122E3B06;
	Tue, 17 Jun 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173085; cv=none; b=suF2yvetCi0rBoOPjJjgZX6AAn/72pSBKD8vw7vz1BQAboRdEVSkJli4JjqHebrYfZeNthihXnLI30Cpicxxbg1u1Jjpj/J6fe7UFuxMv8F4QF+6kqmUy06vKTyXVDif1oVDLWh7eTepf4J60RFYbbNkSqPwrxojp08oOyi6rHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173085; c=relaxed/simple;
	bh=XIn+VDVkzqoxXJF3htMqN190qXbVe1Vk1GEFecXNELU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkdzUaVpdMzP15Qc+YDVub3XcTb8T3hK0J5OcB9bK1chLvqV/kt6EcmVPGmiQ8mYcTHQ7rPBvnRKPtklw1ujloNv90fNYONo6XAEylsUiPEFhkIKB/L1GB6X5W6QiQ7SSYpDmkK5whJIXDaRalzH/gVBFmhGru0g4fhqkcDdTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NCa84+KR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H9LGEm010036;
	Tue, 17 Jun 2025 15:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ED41I98dWWWiwqsfyllGBoGBfiF5ki
	5VU5dN4g06/D4=; b=NCa84+KRIM5g6UQm7IhXPMxiYgQGNaOncuA5g4te8HwiZS
	DRWAuiiVhhyoiP9nmD2jzi5ZVVLnxcHwNN9nvC+Y3uCt1GLPoumvPZUIbzg9XN3j
	9e1H9aFXpbHaCgwua9ZpqLyTGaFc0I6YdLgChH8SFJieD5I7h5rviEKvs9EhCfUv
	WSub1jymSIEUogK/pW7MuzxqIKsLktkx6/5SyEd4a80rsQDHHH5Jnhz0ZCaysOEI
	T5S3GTRWRODUxiEPJ/i29u6aKt2qLAwdSwmTLurB8kbuINOMnR8z6SZqE70AYhdq
	wXXaD1DKjvgVz0lR+VGWLqDPh1i+BeMGoAFrg7Tg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r20s4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:11:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55HFB6H9028468;
	Tue, 17 Jun 2025 15:11:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r20s4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:11:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCY0Ab000720;
	Tue, 17 Jun 2025 15:11:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp45eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 15:11:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HFB4BW51511736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 15:11:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D13620043;
	Tue, 17 Jun 2025 15:11:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98EBA20040;
	Tue, 17 Jun 2025 15:11:00 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com (unknown [9.109.245.113])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Jun 2025 15:11:00 +0000 (GMT)
Date: Tue, 17 Jun 2025 20:40:55 +0530
From: donettom <donettom@linux.ibm.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH 2/6] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <aFGFf-SUi41D9ZmV@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-3-aboorvad@linux.ibm.com>
 <5xw6iujjihdqy3sssmgo7z7rghsi3jgusc3kap7w7gbowisyc2@gfq633qx4bra>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5xw6iujjihdqy3sssmgo7z7rghsi3jgusc3kap7w7gbowisyc2@gfq633qx4bra>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vnWQwtFOm6AgWjbquX-JBGruMgndkPiG
X-Proofpoint-ORIG-GUID: qYsgt44I4M69X_JetsAMXC-L5shCziKB
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6851858b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Qi7r7Pc1jYxnUvlcgVAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExNSBTYWx0ZWRfX/FjqriRK9bew qMCOX1zzK/80ihxS1pddNhPHW5XIc1JueGjVrc0Q2mjEhLQ0Rc/a0sOpQNe/KHP5yg7WAaLXb3K pSyYE6dYn6eUTnr/PABfdw1wCG6abLBWTWk/ofqX/GNNGskcGXpXG51hT9S6lrB2clGcRxT2XRX
 bH7bip5KdAMaO2i7ZFbI/X8zfAFUbhjfrUisYLvOAEu2tW8iAvd3OUqMfexDr5SCbdCiBnusSBI H4VD4wp2uSRK4XFu4416L0thWtP62VWIjjyVL3HnA70X/+unmOoc7a52dpyGPVaHwTSI5852Dw9 H6dyu+/TorkqPv7Em9Xbd3K9Ouk7XtaUPQypLehOu4Rrpc95SLkALOrOoG7knMPViDB6taVQaXf
 Xkig/p0KJVmwI7kg9Q2a16XvWqWQL90UeTHxPfuz5NSRlGjNv+0SUVG730SxfqsYV7KnNT7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170115

On Mon, Jun 16, 2025 at 01:04:40PM -0400, Liam R. Howlett wrote:
> * Aboorva Devarajan <aboorvad@linux.ibm.com> [250616 12:07]:
> > From: Donet Tom <donettom@linux.ibm.com>
> > 
> > This patch fixed 2 issues.
> > 
> > 1)After fork() in test_prctl_fork, the child process uses the file
> > descriptors from the parent process to read ksm_stat and
> > ksm_merging_pages. This results in incorrect values being read (parent
> > process ksm_stat and ksm_merge_pages will be read in child), causing
> > the test to fail.
> > 
> > This patch calls init_global_file_handles() in the child process to
> > ensure that the current process's file descriptors are used to read
> > ksm_stat and ksm_merging_pages.
> > 
> > 2) All tests currently call ksm_merge to trigger page merging.
> > To ensure the system remains in a consistent state for subsequent
> > tests, it is better to call ksm_unmerge during the test cleanup phase
> > 
> > In the test_prctl_fork test, after a fork(), reading ksm_merging_pages
> > in the child process returns a non-zero value because a previous test
> > performed a merge, and the child's memory state is inherited from the
> > parent.
> > 
> > Although the child process calls ksm_unmerge, the ksm_merging_pages
> > counter in the parent is reset to zero, while the child's counter
> > remains unchanged. This discrepancy causes the test to fail.
> > 
> > To avoid this issue, each test should call ksm_unmerge during cleanup
> > to ensure the counter is reset and the system is in a clean state for
> > subsequent tests.
> > 
> 
> Fixes: ?

Sorry I missed it. We will add and send a new version.

> 
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >  tools/testing/selftests/mm/ksm_functional_tests.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> > index b61803e36d1c..d7d3c22c077a 100644
> > --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> > +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> > @@ -46,6 +46,8 @@ static int ksm_use_zero_pages_fd;
> >  static int pagemap_fd;
> >  static size_t pagesize;
> >  
> > +static void init_global_file_handles(void);
> > +
> >  static bool range_maps_duplicates(char *addr, unsigned long size)
> >  {
> >  	unsigned long offs_a, offs_b, pfn_a, pfn_b;
> > @@ -274,6 +276,7 @@ static void test_unmerge(void)
> >  	ksft_test_result(!range_maps_duplicates(map, size),
> >  			 "Pages were unmerged\n");
> >  unmap:
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  }
> >  
> > @@ -338,6 +341,7 @@ static void test_unmerge_zero_pages(void)
> >  	ksft_test_result(!range_maps_duplicates(map, size),
> >  			"KSM zero pages were unmerged\n");
> >  unmap:
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  }
> >  
> > @@ -366,6 +370,7 @@ static void test_unmerge_discarded(void)
> >  	ksft_test_result(!range_maps_duplicates(map, size),
> >  			 "Pages were unmerged\n");
> >  unmap:
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  }
> >  
> > @@ -428,6 +433,7 @@ static void test_unmerge_uffd_wp(void)
> >  close_uffd:
> >  	close(uffd);
> >  unmap:
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  }
> >  #endif
> > @@ -491,6 +497,7 @@ static int test_child_ksm(void)
> >  	else if (map == MAP_MERGE_SKIP)
> >  		return -3;
> >  
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  	return 0;
> >  }
> > @@ -524,6 +531,7 @@ static void test_prctl_fork(void)
> >  
> >  	child_pid = fork();
> >  	if (!child_pid) {
> > +		init_global_file_handles();
> >  		exit(test_child_ksm());
> >  	} else if (child_pid < 0) {
> >  		ksft_test_result_fail("fork() failed\n");
> > @@ -620,6 +628,7 @@ static void test_prctl_unmerge(void)
> >  	ksft_test_result(!range_maps_duplicates(map, size),
> >  			 "Pages were unmerged\n");
> >  unmap:
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  }
> >  
> > @@ -653,6 +662,7 @@ static void test_prot_none(void)
> >  	ksft_test_result(!range_maps_duplicates(map, size),
> >  			 "Pages were unmerged\n");
> >  unmap:
> > +	ksm_unmerge();
> >  	munmap(map, size);
> >  }
> >  
> > -- 
> > 2.43.5
> > 
> > 

