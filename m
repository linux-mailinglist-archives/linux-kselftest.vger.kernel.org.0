Return-Path: <linux-kselftest+bounces-23409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6D9F301D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA62188356A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F3204681;
	Mon, 16 Dec 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ChfgpvZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAD38FA6
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350988; cv=none; b=hbc4nYvbe9nfgxzDWlaFI7Xu2uQvvvML5taEK7feZInyUd+Vih4mYG6inyNwDlfo2YoyWcrRXROAucP5zTHkaxHFeFvuAgLTNQ2ILzi8dC1GLD7aUnwH/YBWv5NXT9AkS+v2oBOKPz2unUyae1cLeXYt/bFGp/TkMUNyYhcV8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350988; c=relaxed/simple;
	bh=qnTfM1RDGI+BOo3E0RgeA8Wurqz5znwsN2lu8UFXSrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prTLf8ER3eJ176XmwtTInwwu+aimBG8J4pN8lPzwNFXddKHGjDY2zVi+3qwPMifgQDU4qU0nxmir3uX350nUUFd7muHjghGrRlcoBiS2Cj7lv8xgr9dPseV3oMtAqcFNflWGKNOx1AqrUMci8cFiW+IWY0imxu3xnZXp5B5T5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ChfgpvZ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85ZiZ027025;
	Mon, 16 Dec 2024 12:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WTSHcJ
	8eRCQYNL+hWiFrScopX+ZbF/jNY8lXSWTn3Ck=; b=ChfgpvZ1WWBUw2MPcuNizl
	tM7m1HK6aVnVvzOUzaRRtS1ozNw+v/vY/zekAW08+rHzh7M8UkVvTPHwk+nNMTLS
	k6OmfCGcYd+j/H9FEVm6alLI70902+8Pdl+tzL2LhZ0UwXDtwDwEKpwBNuz0Y1fL
	jLnzzGqeGTtS2zqKOEWWFDiX8yLFEY79xNKY+E4D8qgHX+EG9iDKjShx6EGScife
	ffZUgnzbqIvghUIHCTCgwA0jTRpEwyLcX9OmMh3ubMYujINL8rcF/E+lYKnjldyD
	Nhjg4WI/exQMRWeCfxHRUkYpyXHnGY8t76Q+zXpUsogVe/44y2GMxLba1JB7GArQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd292kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:09:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGC3TIN002189;
	Mon, 16 Dec 2024 12:09:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd292kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:09:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGASkJ8011260;
	Mon, 16 Dec 2024 12:09:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjwjcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:09:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGC9OKY27132444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 12:09:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ADB658065;
	Mon, 16 Dec 2024 12:09:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C54EC5805D;
	Mon, 16 Dec 2024 12:09:19 +0000 (GMT)
Received: from [9.43.70.111] (unknown [9.43.70.111])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 12:09:19 +0000 (GMT)
Message-ID: <bbde8e05-fc85-434e-998c-a6fcc8b2df4e@linux.ibm.com>
Date: Mon, 16 Dec 2024 17:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftest/powerpc/ptrace: Cleanup duplicate macro
 definitions
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
References: <20241209151418.348085-1-maddy@linux.ibm.com>
 <20241209151418.348085-3-maddy@linux.ibm.com> <87ldwf520w.fsf@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <87ldwf520w.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l6k8yrErjU-dP8EVAwrEkxuevyu2ZaYK
X-Proofpoint-GUID: SZ4kf7HNimysG9KiQGPyaUuUwoSNRgI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=867 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160101



On 12/16/24 4:27 PM, Ritesh Harjani (IBM) wrote:
> Madhavan Srinivasan <maddy@linux.ibm.com> writes:
> 
>> Both core-pkey.c and ptrace-pkey.c tests have similar macro
>> definitions, move them to "pkeys.h" and remove the macro
>> definitions from the C file.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>>  tools/testing/selftests/powerpc/include/pkeys.h      | 8 ++++++++
>>  tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 8 --------
>>  tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 8 --------
>>  3 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
>> index 51729d9a7111..3a0129467de6 100644
>> --- a/tools/testing/selftests/powerpc/include/pkeys.h
>> +++ b/tools/testing/selftests/powerpc/include/pkeys.h
>> @@ -35,10 +35,18 @@
>>  #define __NR_pkey_alloc		384
>>  #define __NR_pkey_free		385
>>  
>> +#ifndef NT_PPC_PKEY
>> +#define NT_PPC_PKEY		0x110
>> +#endif
>> +
>>  #define PKEY_BITS_PER_PKEY	2
>>  #define NR_PKEYS		32
>>  #define PKEY_BITS_MASK		((1UL << PKEY_BITS_PER_PKEY) - 1)
>>  
>> +#define AMR_BITS_PER_PKEY 2
>> +#define PKEY_REG_BITS (sizeof(u64) * 8)
>> +#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
>> +
>>  inline unsigned long pkeyreg_get(void)
>>  {
>>  	return mfspr(SPRN_AMR);
>> diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> index 31c9bf6d95db..f8ff05e5bf6e 100644
>> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> @@ -18,18 +18,10 @@
>>  #include "child.h"
>>  #include "pkeys.h"
>>  
>> -#ifndef NT_PPC_PKEY
>> -#define NT_PPC_PKEY		0x110
>> -#endif
>> -
>>  #ifndef PKEY_DISABLE_EXECUTE
>>  #define PKEY_DISABLE_EXECUTE	0x4
>>  #endif
> 
> We could remove this as well right. Since pkeys.h already has this
> permission defines i.e.
> PKEY_DISABLE_[ACCESS|WRITE|EXECUTE] 
> 

Nice catch. Yes we can drop these too.
Will fix and send a v2
 

>>  
>> -#define AMR_BITS_PER_PKEY 2
>> -#define PKEY_REG_BITS (sizeof(u64) * 8)
>> -#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
>> -
>>  #define CORE_FILE_LIMIT	(5 * 1024 * 1024)	/* 5 MB should be enough */
>>  
>>  static const char core_pattern_file[] = "/proc/sys/kernel/core_pattern";
>> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
>> index 6893ed096457..5d528d0ea9d1 100644
>> --- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
>> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
>> @@ -9,18 +9,10 @@
>>  #include "child.h"
>>  #include "pkeys.h"
>>  
>> -#ifndef NT_PPC_PKEY
>> -#define NT_PPC_PKEY		0x110
>> -#endif
>> -
>>  #ifndef PKEY_DISABLE_EXECUTE
>>  #define PKEY_DISABLE_EXECUTE	0x4
>>  #endif
>>  
> 
> Same here. This can be cleaned up, no? Since pkeys already has this defined.
> 
> 
> -ritesh
> 
>> -#define AMR_BITS_PER_PKEY 2
>> -#define PKEY_REG_BITS (sizeof(u64) * 8)
>> -#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
>> -
>>  static const char user_read[] = "[User Read (Running)]";
>>  static const char user_write[] = "[User Write (Running)]";
>>  static const char ptrace_read_running[] = "[Ptrace Read (Running)]";
>> -- 
>> 2.47.0


