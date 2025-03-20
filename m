Return-Path: <linux-kselftest+bounces-29483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE4A6A11D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 09:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D5A3BF184
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8120FA85;
	Thu, 20 Mar 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xebot/+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587F1F03F2;
	Thu, 20 Mar 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458867; cv=none; b=eOxDIKFArb9sPJ7n9YnijCcCVCLASLMGdCnksUUBCaINREXLWLson2fTLzcTL8Ylhwfco8NsU3yqamkD7NoyMVUWyks4T5T7M1930K6Y4eCsLo0o+iYDyWV8K2FxVunRMncMrIZ5Jw4HES4pltw7tf6V251letkci+tlC120LC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458867; c=relaxed/simple;
	bh=9jVOE5DG0El/OsB+pqGYbr940r5MPTlxNv0abE4J8XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG6GpZEJ4WpHOplcaNO6Xv4crHXh/Xq4g8Q3pEOkmcjrvJcwZkVDXka+KguJ53qtAaSFXFhsyrced1bny3ym8J1v5Zp/Fskd3/tiHvIrt7EAoIUsyJmRa+9p+U5CV5l8VEAhJS8FFEit/KTMcPeLwX6t/S2R8LFCnyu6041MB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xebot/+8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K3kF6A030483;
	Thu, 20 Mar 2025 08:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SxBx6A
	aVQMU5kwkXSwRaRr0kAHgIW2x2jaGLw6CxjIs=; b=Xebot/+8ITMZHWcmOSFpet
	VnwhSIzeRVFCMRGrAwnjRpnIJKWuSROm7WLFpn+lTCKQBT2eKghO2hkvBznyNff0
	ojJw3HGUUEq2rReMlM+2vW/2YzxJxnFvpcKVmSzs4JVviLRbNnBodoBSo1VlaT51
	kzlvP0eqZFf9QISaNZ4lNpU9m73RuAjxX4G5AL7tipikosTHEyNC4kmlvGCT99S/
	tJiEDARt/4rbxW3Fgl+9KT4XeUR3bEtfMquDz5bN1AHAiMjPv9Muhp2aw1swxRjS
	ODBITC+JYRNxY2nViGUblZD5HfWEWIe51ijz2CWG9ugxVCsmNifdHw5ql8Kot8ig
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gbd9h51v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 08:20:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52K8IkSo022645;
	Thu, 20 Mar 2025 08:20:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gbd9h51q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 08:20:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6XmTp005721;
	Thu, 20 Mar 2025 08:20:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2pfvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 08:20:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K8Kb3f57278776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:20:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F6320049;
	Thu, 20 Mar 2025 08:20:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43A2A2004E;
	Thu, 20 Mar 2025 08:20:33 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 08:20:33 +0000 (GMT)
Date: Thu, 20 Mar 2025 13:50:30 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, venkat88@linux.ibm.com
Subject: Re: [PATCH v2 0/2] Fix xdp_adjust_frags_tail_grow selftest on powerpc
Message-ID: <Z9vPzpfMlKE+D8kx@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -zPmiBqpxt79rPkJ35Rjh__UWc9xdsBB
X-Proofpoint-GUID: R9T0fej3nwi7dxupY1mldgeegiMu11wN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503200046

Gentle Ping...

Hi Alexander and other net bpf guys, it would be great if you could share your
feedback whenever you have a moment. Please do let me know if there's any
additional change needed.

Thanks,
Saket

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

