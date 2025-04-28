Return-Path: <linux-kselftest+bounces-31788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A6FA9F625
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFA1890420
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F327F747;
	Mon, 28 Apr 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PtHukaKq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0F27C862;
	Mon, 28 Apr 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858892; cv=none; b=pOKRGJ6guvppZrrAGIQr6SJ1PFgwNTuEMBcxdWZKWqYsOs7qAaRXr2oyFuQ8mECf/lo+d/hSrp/3YSVsBprDa2yBzhQxGR/K5h0idbEDqHiJdE2LPFq/9rVxoR4D6Vq1/ULtI7msko6l0472Nf5Dc/fFRK8Gtf6rfde/uswTAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858892; c=relaxed/simple;
	bh=kZ52g4EMAhKMRVX+SCcoN5zaJjLL6F5WzhUcPXaNTAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMMYVEG2EGcuyrZZ36Cnlil1Dg/6BXmtXLroaEMsUQyr6FVe50HE8Y8AuJuR3sgU5KAKeTS7v07AaD72EiQyT4b8PIR9v3V2VGWC6lJ19E3BHzyUUIJ4KnmnlbBaLD7PBWX0B0D/Ko/SoGfHr8/RCU9djkPM/oe80/Oikl0967M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PtHukaKq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAFSlS006000;
	Mon, 28 Apr 2025 16:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IE11iF
	Gkxt6+d8e7SYO/zW7y+SDZ0cXPl/ZiULcYduk=; b=PtHukaKqw4z3BRk+B46UNG
	Ke+9X8l5eYf0aoPsBt+Uk9ACnVbnvn6m0lL1lGo44heDEScW3B9dRdT+pfECO3O0
	d/HGKBgh0r3uktO4g9IqVW2SLy75rSNXPdZGj40V9O7RfKmXEfwT/N122AcNTKW/
	NndMU5y0LfW5Z8JpTDrg33TKZjSGcCfY5zIsXlYXhwcsqWb8hxxKDU6kZp1SyZgL
	ELU/f+cRBstkTBf+2aZdcxSAOhHo60tr1df0PfuKfF1JUwDhbyjS1WH2QOTK9m0H
	6xaZqn2c6a8wZY3yhDHP3EmQ7AEZ+MeXEYglgymDDr446RbUEA61DrIdzdXv9SiA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469vqvmbgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:47:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SF55iB016122;
	Mon, 28 Apr 2025 16:47:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a707fjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:47:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SGlj7u54722914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 16:47:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E7FE58063;
	Mon, 28 Apr 2025 16:47:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0593A58043;
	Mon, 28 Apr 2025 16:47:42 +0000 (GMT)
Received: from [9.61.244.200] (unknown [9.61.244.200])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 16:47:41 +0000 (GMT)
Message-ID: <18c375a5-9d0c-49ca-995c-efaec95aa3a7@linux.ibm.com>
Date: Mon, 28 Apr 2025 22:17:40 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: Fix build break when compiling
 pkey_util.c
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
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250428131937.641989-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNiBTYWx0ZWRfX6tEt5s6HzDTO RfUexhfTtbx+K1wfhc6nWOrEuEJ1oXns+O/kf43gZ/qNe2Gli8r7OUu2q8TSFDCbqdRyxYjpuzM BPHRjqXSpM24km4euNMRfKgVFwVjJT5CPrrfOyDpRE3lKIXnLcNhVoSg3B8FUvdJgjz2mYelT/T
 M6UFXT2OpYbCAoUiMVQIzX/fcD0FFOADvouaftclRCLfmR4VoONP0X+MTZV0l4Hs3SWU0yKB+oG /SnZVR77Dqr30oH7hQofIByrZ1V+cxFy8j97Ngp6nsTAIZUgJx1LO//DJOLt/CqHRYCnFySSaRS qOmpqEkCNMB4Ka5gmJKQq/Pmm3CRcQ4t/2vaGGhXCwUNKZEFUsXcsBSuZuwV3CeL2gI4yRtQpXu
 AsSdYxQxQr3IeFMSgcmlv+iXPjmDNbXtCn/rv3/AHSZuW+s1cMzFHcIycXvuHL/S+y7PbQvj
X-Authority-Analysis: v=2.4 cv=AP4PelLR c=1 sm=1 tr=0 ts=680fb133 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=yfRTT-X1xsbtue6_pAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pIOnp1wWl2vCrNGN-I0LjbyS1booz0fH
X-Proofpoint-GUID: pIOnp1wWl2vCrNGN-I0LjbyS1booz0fH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280136


On 28/04/25 6:49 pm, Nysal Jan K.A. wrote:
> From: Madhavan Srinivasan <maddy@linux.ibm.com>
>
> Commit 50910acd6f615 ("selftests/mm: use sys_pkey helpers consistently")
> added a pkey_util.c to refactor some of the protection_keys functions accessible
> by other tests. But this broken the build in powerpc in two ways,
>
> pkey-powerpc.h: In function ‘arch_is_powervm’:
> pkey-powerpc.h:73:21: error: storage size of ‘buf’ isn’t known
>     73 |         struct stat buf;
>        |                     ^~~
> pkey-powerpc.h:75:14: error: implicit declaration of function ‘stat’; did you mean ‘strcat’? [-Wimplicit-function-declaration]
>     75 |         if ((stat("/sys/firmware/devicetree/base/ibm,partition-name", &buf) == 0) &&
>        |              ^~~~
>        |              strcat
>
> Since pkey_util.c includes pkeys-helper.h, which in turn includes pkeys-powerpc.h,
> stat.h including is missing for "struct stat". This is fixed by adding "sys/stat.h"
> in pkeys-powerpc.h
>
> Secondly,
>
> pkey-powerpc.h:55:18: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘u64’ {aka ‘long unsigned int’} [-Wformat=]
>     55 |         dprintf4("%s() changing %016llx to %016llx\n",
>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     56 |                          __func__, __read_pkey_reg(), pkey_reg);
>        |                                    ~~~~~~~~~~~~~~~~~
>        |                                    |
>        |                                    u64 {aka long unsigned int}
> pkey-helpers.h:63:32: note: in definition of macro ‘dprintf_level’
>     63 |                 sigsafe_printf(args);           \
>        |                                ^~~~
>
> These format specifier related warning are removed by adding
> "__SANE_USERSPACE_TYPES__" to pkeys_utils.c.
>
> Fixes: 50910acd6f615 ("selftests/mm: use sys_pkey helpers consistently")
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/pkey-powerpc.h | 2 ++
>   tools/testing/selftests/mm/pkey_util.c    | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
> index 1bad310d282a..d8ec906b8120 100644
> --- a/tools/testing/selftests/mm/pkey-powerpc.h
> +++ b/tools/testing/selftests/mm/pkey-powerpc.h
> @@ -3,6 +3,8 @@
>   #ifndef _PKEYS_POWERPC_H
>   #define _PKEYS_POWERPC_H
>   
> +#include <sys/stat.h>
> +
>   #ifndef SYS_pkey_alloc
>   # define SYS_pkey_alloc		384
>   # define SYS_pkey_free		385
> diff --git a/tools/testing/selftests/mm/pkey_util.c b/tools/testing/selftests/mm/pkey_util.c
> index ca4ad0d44ab2..255b332f7a08 100644
> --- a/tools/testing/selftests/mm/pkey_util.c
> +++ b/tools/testing/selftests/mm/pkey_util.c
> @@ -1,4 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> +#define __SANE_USERSPACE_TYPES__
>   #include <sys/syscall.h>
>   #include <unistd.h>
>   

Tested this patch by applying on top of mainline kernel v6.15-rc4, and 
it fixes the build issue. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Without this Patch:


pkey-powerpc.h: In function ‘arch_is_powervm’:
pkey-powerpc.h:73:21: error: storage size of ‘buf’ isn’t known
    73 |         struct stat buf;
       |                     ^~~
pkey-powerpc.h:75:14: warning: implicit declaration of function ‘stat’; 
did you mean ‘strcat’? [-Wimplicit-function-declaration]
    75 |         if 
((stat("/sys/firmware/devicetree/base/ibm,partition-name", &buf) == 0) &&
       |              ^~~~
       |              strcat


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


