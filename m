Return-Path: <linux-kselftest+bounces-38645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FEB1FB31
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FEE18970BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635E425EF97;
	Sun, 10 Aug 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wr2Gi8Xa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B57223DF5;
	Sun, 10 Aug 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844964; cv=none; b=EPYxBedJRrxjumLlIJnVlMv84MWtgFgLvOxfeu5yE/+knUukRALr7rI7HUY1QLmETHYeiGME7BePXJgT9O/w1RtZL+2peq3Etp/uMRwldp3ERzCiWprS2DXqFiNDEILNkU2xxot5y8SvHjMMW74Vjuf3819OvXjr58XDD83nkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844964; c=relaxed/simple;
	bh=DfEfXXnSNLVtXNyz86N3wnFR2QxPYUD5ReOrqeXNMA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r65cpRfdYLuV/bWR/g2z4v2idGf39ac7e7t0XI7Syw4YyXmzIlWaxCW4oxKPuBGKLuucBTeGnE6MUPvN/S21eb9krhblrmoOS8zGeO4tdaM/44T9cyUpsNMpTsnto04aJUoSM8yEaoLFEqr0SmiHrqVVFOVvLU6w7D4lFFkYfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wr2Gi8Xa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A5aP0L017895;
	Sun, 10 Aug 2025 16:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z5cZnI
	Al7D6khCXJ9qDCiBDoxcLSRZ68O/xsxu5WVXs=; b=Wr2Gi8XaMNGJ8plXxxshPT
	a43X5+p/bqv9p/baEwchlvzStyPITPamfpjnJjYv56Ise4heBUcyq0cLx4+hLHbk
	qL0lAhSIyaez82pmUlfWyKQEjB2Sub5q+BgCMNZeQRdGMqRP75r4D7sq7yAxklrE
	TSJ08wtvMSeuzY67r2En2krcNhzmd00a8WxTdBMfC5UF9ZRDvUHgl4QciKPzRJrf
	xUyDrXk81JtncW5K+qhZJYFon+tGUVFTsLpYmFS0qlTmgJQONCtKmWZousItZOwB
	3xnNy5bwunQ9Fdamw+B/fxsPfVAPAIWIBNYX7JQXGRvcliVmuTCDTqm8xYYfp4vw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnnu18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:55:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57AGrcXU013512;
	Sun, 10 Aug 2025 16:55:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnnu16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:55:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57AEi5Q0017588;
	Sun, 10 Aug 2025 16:55:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3a6jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:55:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57AGtj9l32506432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 16:55:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19ED958045;
	Sun, 10 Aug 2025 16:55:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE17158056;
	Sun, 10 Aug 2025 16:55:36 +0000 (GMT)
Received: from [9.124.216.245] (unknown [9.124.216.245])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 16:55:36 +0000 (GMT)
Message-ID: <24df1782-29de-4ae6-8ca1-560e1208442f@linux.ibm.com>
Date: Sun, 10 Aug 2025 22:25:35 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/huge_memory: add new_order and offset to
 split_huge_pages*() pr_debug.
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
        wang lian <lianux.mm@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-2-ziy@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250808190144.797076-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDEyMyBTYWx0ZWRfX0bo86AIEb9/h
 y5nqKcFnEgc/yCOp/tkSrPwadJ7vT7KOtZuhVL+xzmk3eGApWdHG49A9ea3KDLNWTbbIwLFV6Xs
 RI3kTIeb6sU8tVxVi8mTy4KKT4xIqNEV/CEQ0aWMSUomWVX+Vnlm1+M1boJ1c3hr//F1EkMxoNz
 uC7pdk1nD57cjftz3U5Fuxw28Y2tw2PoK905xhF9zmu5G6sReogZxVvG3YEhHEFn5ZLtEXtCp8C
 isMKcZOUYN5z8CSEDvcTLXcTgZwQVBnLhbKqZm6ZS+O4PSDQG0hSXnPrglWNFpVWzOuYr5tdMS+
 DUrEfYYziiAoYrDZQ5DqaDszKu02bPsjHCS2s8OgAJkrlrDdPhpjVFtqHRl43+XNAO/9ez6Hs5f
 hKpOK/1/2E26dMDNst3+8aT5PW4JsldHHA42LTLKGt/pIS8rFOSd2Gm+C1qQPo0GV1ACOQVQ
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=6898cf13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=PAhIe5FWX1Uh35W7_zUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oDBoKho5lUfV8fWSHNW3-b74h_waRfUr
X-Proofpoint-ORIG-GUID: TQaPVa09PJpvjP4fXjwr5JGK8mJnWLjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100123


On 8/9/25 12:31 AM, Zi Yan wrote:
> They are useful information for debugging split huge page tests.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..ebf875928bac 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4327,8 +4327,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>   		goto out;
>   	}
>   
> -	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> -		 pid, vaddr_start, vaddr_end);
> +	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
> +		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
>   
>   	mmap_read_lock(mm);
>   	/*
> @@ -4438,8 +4438,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>   	if (IS_ERR(candidate))
>   		goto out;
>   
> -	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
> -		 file_path, off_start, off_end);
> +	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
> +		 file_path, off_start, off_end, new_order, in_folio_offset);
>   

LGTM

Reviewed by : Donet Tom <donettom@linux.ibm.com>

>   	mapping = candidate->f_mapping;
>   	min_order = mapping_min_folio_order(mapping);

