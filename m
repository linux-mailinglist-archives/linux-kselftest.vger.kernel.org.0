Return-Path: <linux-kselftest+bounces-28490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54286A56BE7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFD13A847B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17521CC55;
	Fri,  7 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OQu1cQ2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69317583;
	Fri,  7 Mar 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361077; cv=none; b=sR2IzXV3tfIc0hqI36KeTnPQlHzeJxjFsx7M8kiqxpWNf2oPhfD6jqUgP5wiqt2DusEo323vsXCSR8/X/Xsab5ZM/whEiQyL8mT6CM7m38GWEYiXjPOifhOrsKdkAxuvEM8rGqFMz92pVonsQ1s9lAOm2cqvbFlEuhke2Et2WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361077; c=relaxed/simple;
	bh=p+AAle601s8Mkt5jP13A76T+lDUffR7WvVS+F7N+RSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptmpuHoSc/Kfz/YuYSJ+VSTvjYxCQ3I/0WQlqhcjZvUxLx0tv/es+kvu8UTX4Ablz7M6l/uVd9bFY6aIc9YScsabxau1lHr/hy+tYtv3nJlYpNAsNjDX7rG1/UBmcfRUxglGtwNznCFhh9nMczj/T6GfAVOod7ksCNni8rDOuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OQu1cQ2M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527E38vb028354;
	Fri, 7 Mar 2025 15:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fpXEGy
	SQym7CPwOOwdiRHKcf9MJxqIIxYTXw8n7IaB0=; b=OQu1cQ2M7OWqlcAdaRN5Yz
	v2iJgkPtV8ZA2r4GgDhoL3ShW5G8xbOtUPSzN62+6HCCef0KCl1sPv1MeU3PeiyK
	hAxczM6GZ/6zw07SIPx3o9K7Dzga51b9rjZgQ1l/C0YD4pCypOfiRfegD26jtQQJ
	BnnFCYHospyqQKK6o0Pc5UZVDd9yTnvrDSOynkIW32HufSYjWq4DBsJoArozwzvE
	OzaBvphmcYiukEGuYSjm2qpOdFyG9KOmlXYE/UFDJ2xYdOhxBciLQveBxDLZ39nT
	cvc00sw++yGC6pet6Euva8YGr2Z7a1jli5ctUraSwzE7zq9ixgf/mSVx2jZB0DyQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45827p8dmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:24:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 527FOARD008923;
	Fri, 7 Mar 2025 15:24:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45827p8dm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:24:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527CKNqq020845;
	Fri, 7 Mar 2025 15:24:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnyh4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:24:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527FO7SF12780042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 15:24:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED9858065;
	Fri,  7 Mar 2025 15:24:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C534258052;
	Fri,  7 Mar 2025 15:24:01 +0000 (GMT)
Received: from [9.61.252.177] (unknown [9.61.252.177])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 15:24:01 +0000 (GMT)
Message-ID: <96a959ec-c6a6-4740-a560-34134b2af7f7@linux.ibm.com>
Date: Fri, 7 Mar 2025 20:54:00 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix xdp_adjust_frags_tail_grow selftest on powerpc
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        aleksander.lobakin@intel.com, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org
References: <cover.1741188826.git.skb99@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <cover.1741188826.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w_vQ1sg3EnNrJ9rwrvqqGpqRrNaPY13f
X-Proofpoint-GUID: N_JYlXhT-dlVYCS5vQ5ZhKyN0HCa-eA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070111


On 05/03/25 10:43 pm, Saket Kumar Bhaskar wrote:
> For platforms on powerpc architecture with a default page size greater
> than 4096, there was an inconsistency in fragment size calculation.
> This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
> to fail on powerpc.
>
> The issue occurred because the fragment buffer size in
> bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
> the fragment within the shared skb was checked against PAGE_SIZE
> (65536 on powerpc) in min_t, causing it to exceed 4096 and be set
> accordingly. This discrepancy led to an overflow when
> bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
> could be greater than rxq->frag_size (when PAGE_SIZE > 4096).
>
> This change fixes:
>
> 1. test_run by getting the correct arch dependent PAGE_SIZE.
> 2. selftest by caculating tailroom and getting correct PAGE_SIZE.
>
> Changes:
> v1 -> v2:
>     * Address comments from Alexander
>        * Use dynamic page size, cacheline size and size of
>          struct skb_shared_info to calculate parameters.
>        * Fixed both test_run and selftest.
>
> v1: https://lore.kernel.org/all/20250122183720.1411176-1-skb99@linux.ibm.com/
>
> Saket Kumar Bhaskar (2):
>    bpf, test_run: Replace hardcoded page size with dynamic PAGE_SIZE in
>      test_run
>    selftests/bpf: Refactor xdp_adjust_tail selftest with dynamic sizing
>
>   .../bpf/prog_tests/xdp_adjust_tail.c          | 160 +++++++++++++-----
>   .../bpf/progs/test_xdp_adjust_tail_grow.c     |  41 +++--
>   2 files changed, 149 insertions(+), 52 deletions(-)
>
Applied the patch series on the bpf-next and patch works as expected.


With Out the Patch:

test_xdp_adjust_frags_tail_grow:PASS:9Kb+10b 0 nsec
test_xdp_adjust_frags_tail_grow:FAIL:9Kb+10b retval unexpected 9Kb+10b 
retval: actual 3 != expected 1
test_xdp_adjust_frags_tail_grow:FAIL:9Kb+10b size unexpected 9Kb+10b 
size: actual 13097 != expected 9001
#583/5   xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL
#583     xdp_adjust_tail:FAIL
Summary: 0/4 PASSED, 0 SKIPPED, 1 FAILED


With Patch:

# ./test_progs -t xdp_adjust_tail
#583/1   xdp_adjust_tail/xdp_adjust_tail_shrink:OK
#583/2   xdp_adjust_tail/xdp_adjust_tail_grow:OK
#583/3   xdp_adjust_tail/xdp_adjust_tail_grow2:OK
#583/4   xdp_adjust_tail/xdp_adjust_frags_tail_shrink:OK
#583/5   xdp_adjust_tail/xdp_adjust_frags_tail_grow:OK
#583     xdp_adjust_tail:OK
Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED


Please add below tag to all the patches in series.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


