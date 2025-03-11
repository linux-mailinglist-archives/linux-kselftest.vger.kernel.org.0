Return-Path: <linux-kselftest+bounces-28690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12FA5B800
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 05:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3EA171391
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 04:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429A1E9B35;
	Tue, 11 Mar 2025 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFhrsUql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2B1DEFF3;
	Tue, 11 Mar 2025 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667569; cv=none; b=ACN8Yz1oWbiPRbyHg9WuLTFPBxWmShmjc9Co1uflnZMhvjz5GJV1He4V/wZifHwc9LPGNt9YUJ5zBBNKpl+fZpYOpPFjyrAZIDuCyYyZ6KF/IkcldQFsf9FMz+JSeW0a1AJ3AT94PC8i09wbwgxs7iH+kcxzlf7LPLIKAtJlkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667569; c=relaxed/simple;
	bh=37ux8iyEWWB9ed6gLYmpWbgzzlUkyqEkrpow+L4VVQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtPx2ClX+4ZOalS3v0f2jpw0HupkGMLnwPMq6IZxNhsN7QXTkyN4Xr8p49Dw+MRjVrvX/gZaPG8LV/caLWjvVSqLrMlz7wr3HQ3iQ5lHawO/mzcgY5L8KIoL4uR0IOmPv/sO/4JUalGMfNeMjYRftSrCh29ZZSpizZP01rPBsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFhrsUql; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKFaEB028830;
	Tue, 11 Mar 2025 04:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=emHXY3
	4nUGK7e99fHYDPih2r00/7gj841rkTYUwHmc0=; b=HFhrsUqlKASIBzfR98U2pz
	9h3spfbcyOmbxfj9N4DD1QRAf/6PKEcdrRhWV8b0XWhdycRF0/1oXMg0BqxWImUz
	5R/gxcRNNvi67ppfL5GPGiufC64CEKYJRKZi3gnO01Wws5/ndgri+qKILRiA6DaO
	pBECF7o1yz6Dhq+D5hck7pBLiown1EqP/YLMCnNCmTMPgyo5H85gfjo+2G9HWpzi
	cgatCBFr/HW5FG4docnfbng4z+CnFQrk69kGNHbmrFDP139SMXSZ/NyX/sM5Fqfj
	UrQs09hqrJfZS0GT4ccOUKrE5z039H2h4VphUMXkulNSOvPpIBEFEtU/s/jOiG0Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042v50a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:32:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B4WIpx007482;
	Tue, 11 Mar 2025 04:32:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042v508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:32:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B3cXtr014011;
	Tue, 11 Mar 2025 04:32:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1ssxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:32:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52B4WEJA32309962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 04:32:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FFF02004D;
	Tue, 11 Mar 2025 04:32:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6922920040;
	Tue, 11 Mar 2025 04:32:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.112.86])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 04:32:09 +0000 (GMT)
Date: Tue, 11 Mar 2025 10:02:06 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        aleksander.lobakin@intel.com, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org
Subject: Re: [PATCH v2 0/2] Fix xdp_adjust_frags_tail_grow selftest on powerpc
Message-ID: <Z8+8xoSUri3u6+JB@linux.ibm.com>
References: <cover.1741188826.git.skb99@linux.ibm.com>
 <96a959ec-c6a6-4740-a560-34134b2af7f7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a959ec-c6a6-4740-a560-34134b2af7f7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RrOflTFapXc75UGxugEjNKdeRMx0mkUY
X-Proofpoint-ORIG-GUID: ruWdKrsRvtewFmhtIVZw3sPmfHZ_XvBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110028

On Fri, Mar 07, 2025 at 08:54:00PM +0530, Venkat Rao Bagalkote wrote:
> 
> On 05/03/25 10:43 pm, Saket Kumar Bhaskar wrote:
> > For platforms on powerpc architecture with a default page size greater
> > than 4096, there was an inconsistency in fragment size calculation.
> > This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
> > to fail on powerpc.
> > 
> > The issue occurred because the fragment buffer size in
> > bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
> > the fragment within the shared skb was checked against PAGE_SIZE
> > (65536 on powerpc) in min_t, causing it to exceed 4096 and be set
> > accordingly. This discrepancy led to an overflow when
> > bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
> > could be greater than rxq->frag_size (when PAGE_SIZE > 4096).
> > 
> > This change fixes:
> > 
> > 1. test_run by getting the correct arch dependent PAGE_SIZE.
> > 2. selftest by caculating tailroom and getting correct PAGE_SIZE.
> > 
> > Changes:
> > v1 -> v2:
> >     * Address comments from Alexander
> >        * Use dynamic page size, cacheline size and size of
> >          struct skb_shared_info to calculate parameters.
> >        * Fixed both test_run and selftest.
> > 
> > v1: https://lore.kernel.org/all/20250122183720.1411176-1-skb99@linux.ibm.com/
> > 
> > Saket Kumar Bhaskar (2):
> >    bpf, test_run: Replace hardcoded page size with dynamic PAGE_SIZE in
> >      test_run
> >    selftests/bpf: Refactor xdp_adjust_tail selftest with dynamic sizing
> > 
> >   .../bpf/prog_tests/xdp_adjust_tail.c          | 160 +++++++++++++-----
> >   .../bpf/progs/test_xdp_adjust_tail_grow.c     |  41 +++--
> >   2 files changed, 149 insertions(+), 52 deletions(-)
> > 
> Applied the patch series on the bpf-next and patch works as expected.
> 
> 
> With Out the Patch:
> 
> test_xdp_adjust_frags_tail_grow:PASS:9Kb+10b 0 nsec
> test_xdp_adjust_frags_tail_grow:FAIL:9Kb+10b retval unexpected 9Kb+10b
> retval: actual 3 != expected 1
> test_xdp_adjust_frags_tail_grow:FAIL:9Kb+10b size unexpected 9Kb+10b size:
> actual 13097 != expected 9001
> #583/5   xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL
> #583     xdp_adjust_tail:FAIL
> Summary: 0/4 PASSED, 0 SKIPPED, 1 FAILED
> 
> 
> With Patch:
> 
> # ./test_progs -t xdp_adjust_tail
> #583/1   xdp_adjust_tail/xdp_adjust_tail_shrink:OK
> #583/2   xdp_adjust_tail/xdp_adjust_tail_grow:OK
> #583/3   xdp_adjust_tail/xdp_adjust_tail_grow2:OK
> #583/4   xdp_adjust_tail/xdp_adjust_frags_tail_shrink:OK
> #583/5   xdp_adjust_tail/xdp_adjust_frags_tail_grow:OK
> #583     xdp_adjust_tail:OK
> Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
> 
> 
> Please add below tag to all the patches in series.
> 
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> Regards,
> 
> Venkat.
> 
Thanks for testing this Venkat.

Regards,
Saket

