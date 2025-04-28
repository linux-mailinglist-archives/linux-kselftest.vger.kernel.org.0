Return-Path: <linux-kselftest+bounces-31789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C521A9F62E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB01916FE35
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8B27F4E5;
	Mon, 28 Apr 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MYeM9g6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600972CCC0;
	Mon, 28 Apr 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858996; cv=none; b=LdGPO3I6Dg2lko5nYURrc8nk/8r+hGZZbSbx2+m5pMzS9gz4ZCrw4NJYVBHG8/N0A9ZsOC4456UdlKtah3MWpxNF/RrNOQJGRre6RY8OPOuW4INCQraclDndnstEgZLVOlCUp6+FWGVpNQKHNp7+VdO6Y/fp9aDFPeWp2hIKJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858996; c=relaxed/simple;
	bh=PNVESParaTXWsmP+JHkLHUMZWi4KYr64YnTUoIRoYSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1Cu9mcqXBpZbwAwRYFg66Yk1m5urcfW39wZ5lcV0HIKQfzqE4hqK4mND3rK1JYtZG5XoKWaWwszo1fkd0Hnzd7uvEW7myIf2YIg7MP1j2CHCNeisOMwCrRj+sJObT60PzkX1tI/jXN+JxschYUOAWgvRUdvN64Xie+3ajZmi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MYeM9g6C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAwLvB003967;
	Mon, 28 Apr 2025 16:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ygTqjY
	J03RIKTAhwuPR9emo/CxF/ClTtTaFmG2r3wo0=; b=MYeM9g6C9vGxWHYGP93kb4
	7Ti6MDDwnT6wM6bRr66yC6Z+6whMfJ6NrANS+XaD2DzNDtqPceMW/RgGtXm9pPXK
	Y5jstlJpHpaC3VuIGl2FSBDsR5DYJnjjuCQRnCGhwXajerOtuwsN7z8jza3QRGua
	AYyzgSHdSBrOM9Cb8dn7ONJcKYswG5GPV/0jLzJ9950dz8lctgQAXZ58W2H1e7R/
	u2iMTzg0ygca1YuiOh6pOH5aPFJvtorGvvzMBwR9oQzF5v3EOAhLKSIr1ITPZ0bd
	tDYKv23Q/3qxY1riQak5skENJ1VQwQAOUVZ2x7xs5uEiHm8Rb002iadDcPq0TPgA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469xj0v2xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:49:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFakuI000678;
	Mon, 28 Apr 2025 16:49:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atp7c41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:49:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SGnX5L22479518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 16:49:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE38D58061;
	Mon, 28 Apr 2025 16:49:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43A5D58043;
	Mon, 28 Apr 2025 16:49:30 +0000 (GMT)
Received: from [9.61.244.200] (unknown [9.61.244.200])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 16:49:29 +0000 (GMT)
Message-ID: <a1d2c51c-7959-4446-81b7-bfc48ced606e@linux.ibm.com>
Date: Mon, 28 Apr 2025 22:19:28 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: Fix a build failure on powerpc
Content-Language: en-GB
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250428131937.641989-1-nysal@linux.ibm.com>
 <20250428131937.641989-2-nysal@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250428131937.641989-2-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J6ksxhAtcHshXhJfcAb6W-WApMO61Lob
X-Authority-Analysis: v=2.4 cv=GJYIEvNK c=1 sm=1 tr=0 ts=680fb1a0 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=NIXEo0iNHiUJsitbC-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNiBTYWx0ZWRfX7zvjH1N22yRZ MQHKqthnSgK9mU/PNzj6VgZGReWR/Mh/SzooAI3qWaUEeUAgrEk4cdGsICEzYCYzVPz8vsJU1Qj eH92pWxMPQuGMamil1p42avJWmKz1a0E6KrFL+CgTsCvaxRORJ7prLmtoiWo2mBV4aXrY+7CBL9
 09NZvYcq17bCqcxqr48iner7oH6kE6kOU0cuD1bMYQmEFdt8xZOTsG/0MTwPmeDncrM+J/Y3zJR C9hpqo7jrc1TxGlwIEUVOab4ghq1HOkF7QYIsA6eE1qm5t22Smx03J+4oaXBPHWaBQUXDRaFaSS 0H9O9gR2y3V1CCl/yqkOFaDcOdtMqXoCXcY0TK7qauvypPQsb8fuTeVJ7vXLZgiIK3mULNthjIX
 sHb8ic+HuLvA9slHfV2pRDNVgHNtvK9Ot+OUKDhNAalJ2E9qhOH0cCdTmiVcI9jbC+ftJq32
X-Proofpoint-ORIG-GUID: J6ksxhAtcHshXhJfcAb6W-WApMO61Lob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280136


On 28/04/25 6:49 pm, Nysal Jan K.A. wrote:
> The compiler is unaware of the size of code generated by the ".rept"
> assembler directive. This results in the compiler emitting branch
> instructions where the offset to branch to exceeds the maximum allowed
> value, resulting in build failures like the following:
>
>    CC       protection_keys
>    /tmp/ccypKWAE.s: Assembler messages:
>    /tmp/ccypKWAE.s:2073: Error: operand out of range (0x0000000000020158
>    is not between 0xffffffffffff8000 and 0x0000000000007ffc)
>    /tmp/ccypKWAE.s:2509: Error: operand out of range (0x0000000000020130
>    is not between 0xffffffffffff8000 and 0x0000000000007ffc)
>
> Fix the issue by manually adding nop instructions using the preprocessor.
>
> Fixes: 46036188ea1f5 ("selftests/mm: build with -O2")
> Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/pkey-powerpc.h | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
> index d8ec906b8120..17bf2d1b0192 100644
> --- a/tools/testing/selftests/mm/pkey-powerpc.h
> +++ b/tools/testing/selftests/mm/pkey-powerpc.h
> @@ -104,8 +104,18 @@ static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
>   	return;
>   }
>   
> +#define REPEAT_8(s) s s s s s s s s
> +#define REPEAT_64(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) \
> +		     REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s)
> +#define REPEAT_512(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) \
> +		      REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s)
> +#define REPEAT_4096(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) \
> +		       REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s)
> +#define REPEAT_16384(s) REPEAT_4096(s) REPEAT_4096(s) \
> +			REPEAT_4096(s) REPEAT_4096(s)
> +
>   /* 4-byte instructions * 16384 = 64K page */
> -#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
> +#define __page_o_noops() asm(REPEAT_16384("nop\n"))
>   
>   static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
>   {


Tested this patch by applying on top of mainline kernel v6.15-rc4, and 
it fixes the build issue. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Without this Patch:


  CC       protection_keys
/tmp/ccG0zLKW.s: Assembler messages:
/tmp/ccG0zLKW.s:1694: Error: operand out of range (0x0000000000020138 is 
not between 0xffffffffffff8000 and 0x0000000000007ffc)
/tmp/ccG0zLKW.s:2577: Error: operand out of range (0x0000000000020110 is 
not between 0xffffffffffff8000 and 0x0000000000007ffc)
In file included from pkey_util.c:5:


With this patch:


make -j 33
/bin/sh ./check_config.sh gcc
   CC       cow
   CC       compaction_test
   CC       gup_longterm
   CC       gup_test
   CC       hmm-tests
   CC       hugetlb-madvise
   CC       hugetlb-read-hwpoison
   CC       hugetlb-soft-offline
   CC       hugepage-mmap
   CC       hugepage-mremap
   CC       hugepage-shm
   CC       hugepage-vmemmap
   CC       khugepaged
   CC       madv_populate
   CC       map_fixed_noreplace
   CC       map_hugetlb
   CC       map_populate
   CC       migration
   CC       mkdirty
   CC       mlock-random-test
   CC       mlock2-tests
   CC       mrelease_test
   CC       mremap_dontunmap
   CC       mremap_test
   CC       mseal_test
   CC       on-fault-limit
   CC       pagemap_ioctl
   CC       thuge-gen
   CC       transhuge-stress
   CC       uffd-stress
   CC       uffd-unit-tests
   CC       uffd-wp-mremap
   CC       split_huge_page_test
   CC       ksm_tests
   CC       ksm_functional_tests
   CC       hugetlb_fault_after_madv
   CC       hugetlb_madv_vs_map
   CC       mdwe_test
   CC       hugetlb_dio
   CC       droppable
   CC       guard-regions
   CC       soft-dirty
   CC       protection_keys
   CC       va_high_addr_switch
   CC       virtual_address_range
   CC       write_to_hugetlbfs
   CC [M]  page_frag_test.o
   MODPOST Module.symvers
   CC [M]  page_frag_test.mod.o
   CC [M]  .module-common.o
   LD [M]  page_frag_test.ko


Regards,

Venkat.




