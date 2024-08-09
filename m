Return-Path: <linux-kselftest+bounces-15053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC994C9A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 07:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27921C218EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 05:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062F167D98;
	Fri,  9 Aug 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MWgvsVga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23615433A7
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723181547; cv=none; b=tw/LBNvRUeQtTgiVGMbzGssZrnyyh9t4TLePlWKzWkI8RHQiKZ1dB/bA8wyPwoZyqNdfdNrPWyWd3qmwrblnCsfCV7pMEP5m+U+Wlb7Vg7ZBrplnlsw1T+RQg8zDI/b8miUp70QteEy/jeN06/NP8VVoK2KLG9CtRsbE8z8u+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723181547; c=relaxed/simple;
	bh=nMydObkwN0OGuaOz34TW63v4Fmq82cAy69Fn1ida438=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMIgt4c3xCFmGPm05s7TH7pCEh4OU7IHYC4Hgf1cSpG+nSyYPu59h68XteURvYtcuWQ3HuZRKIs+tZM26PNCKx0fNj3KRO1/bJP9qLhn1eJyUqghslmhD/rH43WkMz1cXyLg/5Jodff0p0taUx1LD81pZ2fbp8Nl7tJUnxSpyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MWgvsVga; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4794owWW014963;
	Fri, 9 Aug 2024 05:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	SJ7n+zh2H3t8ABBCU+R2z/NMZ2U3tuzgoekHD1N1Q0=; b=MWgvsVgaf44KtLtOb
	ZD2CncEBkRVRHLL1z0Ej9/PzNBpILvy6C5ah4UtxT41Uu8+3U56z0I/fEEXiLwl4
	m2h8MZ/JR58XxVZdvwCWVNb0APMddEFaA2Pb30KU7kzhZBmQj2NkDTUpGZyo2QQb
	48qCGVkjD3/WlMuUUCjoB+a7Yx7jU7D+Z0uv95IhMHlsrlpHvKSJ5Lzvq/hVaKas
	ws/doku6CBMhuxChIWDCSATWKOqOO5STu8HbCvnqAcAVAT4l5h4V5/wObfxxAHau
	Fch59jaIAFrSmhc1wxAmJ0JAbwNMEoCygRcCqTrwVfJevaugj4OPW/eWPD+9zyuu
	FIrRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbt3sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 05:32:10 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4795W9Ms019941;
	Fri, 9 Aug 2024 05:32:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbt3sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 05:32:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4793rClf018004;
	Fri, 9 Aug 2024 05:32:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cn1w37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 05:32:08 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4795W55k3474146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 05:32:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D38D158062;
	Fri,  9 Aug 2024 05:32:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A1F58054;
	Fri,  9 Aug 2024 05:32:03 +0000 (GMT)
Received: from [9.204.206.229] (unknown [9.204.206.229])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 05:32:03 +0000 (GMT)
Message-ID: <24253b41-4fb8-47f8-b090-06f1762d7104@linux.ibm.com>
Date: Fri, 9 Aug 2024 11:02:01 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/powerpc/benchmark: remove requirement libc-dev
To: Christophe Leroy <christophe.leroy@csgroup.eu>, mpe@ellerman.id.au,
        npiggin@gmail.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
References: <20240805083008.1300853-1-maddy@linux.ibm.com>
 <f4ae0d9e-5d1f-4b5e-92b9-aabb513e3097@csgroup.eu>
 <6e26fec3-0c27-45da-bd3b-69d3b7e0e493@linux.ibm.com>
 <493e1a40-6847-4be8-8978-ed71e7b8bf8c@csgroup.eu>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <493e1a40-6847-4be8-8978-ed71e7b8bf8c@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SXvOm5pxGGK6H6Lr8IQ-Vv0S2rEjs1Sr
X-Proofpoint-GUID: _FMXHlDvLK3POMBLQom_wEduN8jUmc22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_02,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090037


On 8/9/24 10:24 AM, Christophe Leroy wrote:
>
>
> Le 09/08/2024 à 06:25, Madhavan Srinivasan a écrit :
>>
>> On 8/6/24 12:24 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 05/08/2024 à 10:30, Madhavan Srinivasan a écrit :
>>>> Currently exec-target.c file is linked as static and this
>>>> post a requirement to install libc dev package to build.
>>>> Without it, build-breaks when compiling selftest/powerpc/benchmark.
>>>>
>>>>    CC       exec_target
>>>> /usr/bin/ld: cannot find -lc: No such file or directory
>>>> collect2: error: ld returned 1 exit status
>>>>
>>>> exec_target.c is using "syscall" library function which
>>>> could be replaced with a inline assembly and the same is
>>>> proposed as a fix here.
>>>>
>>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>> ---
>>>>   tools/testing/selftests/powerpc/benchmarks/Makefile    | 2 +-
>>>>   .../testing/selftests/powerpc/benchmarks/exec_target.c | 10 
>>>> ++++++++--
>>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile 
>>>> b/tools/testing/selftests/powerpc/benchmarks/Makefile
>>>> index 1321922038d0..ca4483c238b9 100644
>>>> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
>>>> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
>>>> @@ -18,4 +18,4 @@ $(OUTPUT)/context_switch: LDLIBS += -lpthread
>>>>     $(OUTPUT)/fork: LDLIBS += -lpthread
>>>>   -$(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
>>>> +$(OUTPUT)/exec_target: CFLAGS += -nostartfiles
>>>> diff --git 
>>>> a/tools/testing/selftests/powerpc/benchmarks/exec_target.c 
>>>> b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>>>> index c14b0fc1edde..20027a23b594 100644
>>>> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>>>> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>>>> @@ -7,10 +7,16 @@
>>>>    */
>>>>     #define _GNU_SOURCE
>>>> -#include <unistd.h>
>>>>   #include <sys/syscall.h>
>>>>     void _start(void)
>>>>   {
>>>> -    syscall(SYS_exit, 0);
>>>> +    asm volatile (
>>>> +        "li %%r0, %[sys_exit];"
>>>> +        "li %%r3, 0;"
>>>> +        "sc;"
>>>> +        :
>>>> +        : [sys_exit] "i" (SYS_exit)
>>>> +        : "r0", "r3"
>>>> +    );
>>>
>>> That looks ok because SYS_exit() is not supposed to return, but in 
>>> the general case you should take a lot more precautions regarding 
>>> which registers get clobbered when using sc.
>>>
>>> Maybe it is worth a comment.
>>
>>
>> ok sure and something like this will help?
>>
>>
>> +        : "r0", "r3" //clobber registers, r0 - syscall number, r3 - 
>> exit value
>>
>
> Not really.
>
> sc will clobber r0 and r3-r12, also SO bit in CR.
>
> Here the reason why you have no problem with that is that SYS_exit 
> never returns. At the end, even your "r0" and "r3" clobber are 
> unnecessary because of that.

ah nice. thanks for the details.
I will add comment and post a v2 soon.

Maddy


>
> Christophe

