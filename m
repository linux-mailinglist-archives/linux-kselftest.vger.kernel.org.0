Return-Path: <linux-kselftest+bounces-31791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F122A9F70C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B547A4B19
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402725CC7C;
	Mon, 28 Apr 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lxsnSifw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB122423C;
	Mon, 28 Apr 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860448; cv=none; b=qglzuSoAoHIQvalB5LvZ+d8K/IFZR9vlLDue8d3FaDE3gdOUCIFPA2v6+XOq8JoRT/p5OrVMGTv4dvjSif/SLGqr8Lo7i4i9p0e6o8NYEOOTe6ems7blzIt7Quo9GemnwHyaVN33FJVcxhDheoXuNn0rwiNSCICu3U2gtyVWP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860448; c=relaxed/simple;
	bh=W6IEM/f2KLWUWLMtVhJuB467m5kJa8dSv7xFJFYzvzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB4eI5ALsi/zUsnk+VQlQ71AxCtqfWlMnA8htpe2BH1YRB3R6FGf/xy1oaQViNK/L09ahB6jzGTgCkVGR4QoclKQi9lme0LKj2a03mi9fDulSAz0EYMTgUYo0ejYOxloS/jsdC/S1UbDXUH56PIfmggsgf/HwMpIWyHb5dG4yJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lxsnSifw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8vRI4011968;
	Mon, 28 Apr 2025 17:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KomaKd
	ZjhofElzsKOtg4I+kL2PS3yimbP7HbLJSlulQ=; b=lxsnSifwoJMmlWz8KjinGm
	pyb3sVziw0856i6roV0tj3wCP9PhAxQVQEPxpr2ZGmNUC+JS79cPAhyuCqU58WrC
	BYYiNIjTGgnGR6pn+jYvPSXt27JpZEUMlO0bBXFYIBGfQn6ZFVLHbAYCigwowZ5M
	y9Qn/q+kf1lSkMyhXDUb44g9D9AQUeYDEEmqwt6PnM6FBqo4QjP+oTFd0OdgfdHn
	ixfvzBdxmXPMm48N1Sb65hVDmKw6InGQUEzENJNUwZzWHa5ON8yeRqnVPl14/k+U
	6HRIt0P6OBJZ56KrtENGAXE+zxM+FH8/q7ZSd3uYCLBjS55VrqGUdKQHng8wsL1g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469v5kmm69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 17:13:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SG4hau001803;
	Mon, 28 Apr 2025 17:13:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamfcyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 17:13:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SHDiwS31785558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 17:13:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7054C58059;
	Mon, 28 Apr 2025 17:13:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 762E658058;
	Mon, 28 Apr 2025 17:13:40 +0000 (GMT)
Received: from [9.39.16.18] (unknown [9.39.16.18])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 17:13:40 +0000 (GMT)
Message-ID: <f23608eb-3f4e-453c-bcfc-032f963d310c@linux.ibm.com>
Date: Mon, 28 Apr 2025 22:43:38 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: Fix a build failure on powerpc
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
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250428131937.641989-2-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KbhYiEFmmP_tUzB4rpXFNi3_j7M0PyVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNiBTYWx0ZWRfX8vQd+r/NVdK9 fVj89Nk81fj93yIB2WK4uyLM7M2mHWCc2/y4CfPB3vhVEHD61xJsc2tkwaYLeMAo1yZPGG2x6dm N6/occobZIF5tvvDpMBVNLKqwuD0ILpj3AhpKOro+gHjepSmyAR3zwBl4jwSjOC0XFRdJO78IvF
 63cjTo0OVdK2T0jqwU+mT4ZrZpKUZ9IXT4LlK8EaJ5rjawUKpt/6t0aslWBLVTDSR3Q/Oij9URI gbRM6RAky3R5e1w7XWGL+4tZoNYi5BSFK5TvAt5U5U/yjvaXvZL1jx9fj4NrvENMq7KyXXgLXUW eu3eugR/BYKbxdOp951n729X4QIrTsbuJG0jJmbMjsVpG946nf+Pkcdvxipk9dHdfgIAGhD47QW
 8Z7aBlg4v4J8yzNtx5fmE2j6pB8oC35I7r8W4BNQsUCCmMki2/wpZhW72L+YobWf0ODzjd9E
X-Proofpoint-GUID: KbhYiEFmmP_tUzB4rpXFNi3_j7M0PyVQ
X-Authority-Analysis: v=2.4 cv=DvxW+H/+ c=1 sm=1 tr=0 ts=680fb74b cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=QUTIWzIZJQuvQjQnFLoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=906 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280136


On 4/28/25 6:49 PM, Nysal Jan K.A. wrote:
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


Hi Nysal,

This change looks good to me. I tested in on power and the error is not seen.

   CC       droppable
   CC       guard-regions
   CC       soft-dirty
   CC       protection_keys
   CC       va_high_addr_switch
   CC       virtual_address_range
   CC       write_to_hugetlbfs

Reviewed-by:Donet Tom <donettom@linux.ibm.com>
Tested-by: Donet Tom <donettom@linux.ibm.com>


>   /* 4-byte instructions * 16384 = 64K page */
> -#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
> +#define __page_o_noops() asm(REPEAT_16384("nop\n"))
>   
>   static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
>   {

