Return-Path: <linux-kselftest+bounces-49148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B655D3240D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE9AD30081B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76E28C5AA;
	Fri, 16 Jan 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4JNMoGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551592882DB;
	Fri, 16 Jan 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572047; cv=none; b=h+1u4LtRWHmRjCThT9UR7vz5eW8BAzIntntYya9CdOCZ1R7YQfU5OiveJj5a95IFnxM57hDcmvcjgC83Ppy+TehDlpBEOK8cweULVzeWdU/Sj+XdST0bVwjSHleQ6obGygYAnMAwOikZTjGLRQjZMD/Dk7vY0klGF+VCc2OC2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572047; c=relaxed/simple;
	bh=Fwa4ncslrjiPica4CGUZuPDWw7Tx3y7S91lHl5KUNE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5rtgS/4OB/BM7n5ApFtvwSvlFMrU0vucDLnJWintpkyYde4PqendnHviOxjjVjuVaO4+UkZ8euThR4bTdbffSMkQercxZd6EJr24tES9J3Ih4JppnQIqHWOyK9XEYdH8uTciAeeztoPvjUIsgZox2qdcBY2BLp6v2TEHPnWSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4JNMoGH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60GCRw4i031369;
	Fri, 16 Jan 2026 13:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=myVOCt
	ChlyLQtK/gurvuHhrtUul1Cjy4qpiGZDFtLmI=; b=E4JNMoGH7I9epFA/V3UdGb
	9h54mFOicaoOHmiB7BYKzNYuJLgJz6+FOJQkQ8q6IdcdqUjvuCS8ecJG8vIlvAi8
	JuyyxwAKqQEQAdXgGhZ6C+nprlk1MpuLSTS2MPkgCYbWw9fzitMXQgWZ8aMWKEAh
	k5hho8DCOOTNRlSvu6tVLAy/7SzFOFtLuLAVQHgtY+x+8FETVTQuHARpsPsNxMEl
	Z8Wih2HZTR8ToNGgkCazJUu6Vob9xT80TNPzkLEfQxy8iBo+v/cj6AHWJoKa4vm9
	MvWtgheKzewkogMTYjlmTrXEd05PNUqHsTwtHAZ2oks9yB6nN05tkCEah14BDVQQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9bmk4b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 13:59:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60GDwqla025224;
	Fri, 16 Jan 2026 13:59:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9bmk4b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 13:59:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60GDjiBb014333;
	Fri, 16 Jan 2026 13:59:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fypn5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 13:59:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60GDxAwx50921824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 13:59:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0621C20043;
	Fri, 16 Jan 2026 13:59:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2CE620040;
	Fri, 16 Jan 2026 13:59:03 +0000 (GMT)
Received: from [9.43.86.214] (unknown [9.43.86.214])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Jan 2026 13:59:03 +0000 (GMT)
Message-ID: <051521cf-5dd2-4831-ab4c-b0db32436ba9@linux.ibm.com>
Date: Fri, 16 Jan 2026 19:29:02 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] powerpc64/bpf: Support tailcalls with subprogs
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        adubey <adubey@imap.linux.ibm.com>
Cc: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        naveen@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, memxor@gmail.com, iii@linux.ibm.com,
        shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-3-adubey@linux.ibm.com>
 <42d41a0d-9d26-4eeb-af46-200083261c09@kernel.org>
 <2d242f4476b61373da236d24272b0ec3@imap.linux.ibm.com>
 <78536979-e924-4be3-b847-332802ad82e2@linux.ibm.com>
 <ea66ddc5-984f-4873-993d-9de1140d7e6e@kernel.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ea66ddc5-984f-4873-993d-9de1140d7e6e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VuNl7drb6mZuvd-iVxqcmKJ66PXc6Fdf
X-Proofpoint-ORIG-GUID: jy3gV0NpS5tDjoM9jCk7woG2U7zqPjNr
X-Authority-Analysis: v=2.4 cv=TrvrRTXh c=1 sm=1 tr=0 ts=696a4434 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Gp1ZgnKn9qXeJorAczUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX9y61cOoBodfm
 V56e2FeZp4Ez7hzI/Q0J8IhFR2ker99R3rNCmZ8HZo5fU1Yk4vEmTWckVGEn3YO6c/8ziFDd5aH
 fZv7KrpPyB2Q7fuOaomaDe+i57xzsmhilxAZ980y/LOXKkXKNOKnd7IaBewj9blCHsu2TN7Qm++
 E5pkUYsWiilR0xMkrK34Ohmz2btmkR71BNZB+9BkLmQgIIv5+Knuct/k+0SCSEu+Zunqh4O0xWT
 3EAXaQ5xxQ2P2x2uuO4vkPxCjGoLtLzjLhbkQED0o6gd5j6r8CiKK0UbEEKjysDZGcDUA1HU3Nh
 2+jTb6k8K/CMS6Y2UuA/llTfcHe0ApyB0xZf/oWRMb7Kn7Vlh+t3v3v8yCx/T5kGLugVdPazYZz
 HePs4xqLkgaFX4qirP0xLKbUseFtTrTJiDsRP47ffZEl3GifURd8wtsJWQLIsR/zvpwjHIvPYw0
 LdTiKv2xhWpCfWo4tVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160097



On 16/01/26 1:19 pm, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 16/01/2026 à 05:50, Hari Bathini a écrit :
> 
> Not received this mail that Hari is reponding to.

That is weird.

>>
>>
>> On 14/01/26 6:33 pm, adubey wrote:
>>> On 2026-01-14 17:57, Christophe Leroy (CS GROUP) wrote:
>>>> Le 14/01/2026 à 12:44, adubey@linux.ibm.com a écrit :
>>>>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>>>>
>>>>> Enabling tailcalls with subprog combinations by referencing
>>>>> method. The actual tailcall count is always maintained in the
>>>>> tail_call_info variable present in the frame of main function
>>>>> (also called entry function). The tail_call_info variables in
>>>>> the frames of all other subprog contains reference to the
>>>>> tail_call_info present in frame of main function.
>>>>>
>>>>> Dynamic resolution interprets the tail_call_info either as
>>>>> value or reference depending on the context of active frame
>>>>> while tailcall is invoked.
>>>>>
>>>>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>>>>> ---
>>>>>   arch/powerpc/net/bpf_jit.h        | 12 +++++-
>>>>>   arch/powerpc/net/bpf_jit_comp.c   | 10 ++++-
>>>>>   arch/powerpc/net/bpf_jit_comp64.c | 68 ++++++++++++++++++++++ 
>>>>> +--------
>>>>>   3 files changed, 70 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>>>>> index 45d419c0ee73..5d735bc5e6bd 100644
>>>>> --- a/arch/powerpc/net/bpf_jit.h
>>>>> +++ b/arch/powerpc/net/bpf_jit.h
>>>>> @@ -51,6 +51,12 @@
>>>>>           EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | 
>>>>> (offset & 0xfffc));                    \
>>>>>       } while (0)
>>>>>   +/* Same as PPC_BCC_SHORT, except valid dest is known prior to 
>>>>> call. */
>>>>> +#define PPC_COND_BRANCH(cond, dest)         \
>>>>> +    do {                                      \
>>>>> +        long offset = (long)(dest) - CTX_NIA(ctx);              \
>>>>> +        EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | 
>>>>> (offset & 0xfffc));    \
>>>>> +    } while (0)
>>>>
>>>> I don't like the idea of duplicating PPC_BCC_SHORT() to just kick the
>>>> verification out. Now we will have two macros doing the exact same
>>>> thing with one handling failure case and one ignoring failure case.
>>>> There is a big risk that one day or another someone will use the wrong
>>>> macro.
>>>>
>>>> Could you change bpf_jit_build_prologue() to return an int add use
>>>> PPC_BCC_SHORT() instead of that new PPC_COND_BRANCH() ?
>>> I implemented exactly same change in bpf_jit_build_prologue(). But, 
>>> during internal review, @HariBathini suggested
>>> to have separate macro with a caution note.
>>>
>>> @Hari please suggest here!
>>
>> Not just about the change of return type but the check seems like an
>> overkill for cases where the offset is known and within branch range.
>> How about using BUILD_BUG_ON() to avoid unecessary checks and
>> return type change for places where the branch offset is known
>> and is a constant?
> 
> When offset is a constant known at build time, checks are eliminated by 
> gcc at build, see exemple below from disasembly of bpf_jit_comp32.o, 
> there are no checks.
> 
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      36d8:       3c 80 41 81     lis     r4,16769
>                                  EMIT(PPC_RAW_CMPLW(src_reg, _R0));
>      36dc:       81 3f 00 04     lwz     r9,4(r31)
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      36e0:       60 84 00 10     ori     r4,r4,16
>                                  EMIT(PPC_RAW_CMPLW(src_reg, _R0));
>      36e4:       39 29 00 01     addi    r9,r9,1
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      36e8:       55 23 10 3a     slwi    r3,r9,2
>                                  EMIT(PPC_RAW_CMPLW(src_reg, _R0));
>      36ec:       91 3f 00 04     stw     r9,4(r31)
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      36f0:       7c 97 19 2e     stwx    r4,r23,r3
>                                  EMIT(PPC_RAW_LI(dst_reg, 0));
>      36f4:       55 49 a9 94     rlwinm  r9,r10,21,6,10
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      36f8:       80 9f 00 04     lwz     r4,4(r31)
>                                  EMIT(PPC_RAW_LI(dst_reg, 0));
>      36fc:       65 29 38 00     oris    r9,r9,14336
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      3700:       38 84 00 01     addi    r4,r4,1
>                                  EMIT(PPC_RAW_LI(dst_reg, 0));
>      3704:       54 83 10 3a     slwi    r3,r4,2
>                                  PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 
> 4);
>      3708:       90 9f 00 04     stw     r4,4(r31)
>                                  EMIT(PPC_RAW_LI(dst_reg, 0));
>      370c:       7d 37 19 2e     stwx    r9,r23,r3
> 

Interesting. I do see is_offset_in_cond_branch_range() in action with
constant offsets too, on ppc64 compile at least. fwiw, I had this
optimized version in mind for constant offset:

   #define PPC_BCC_CONST_SHORT(cond, offset) 
                     \
         do { 
                     \
                 BUILD_BUG_ON(offset < -0x8000 || offset > 0x7fff || 
(offset & 0x3));        \
                 EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | 
(offset & 0xfffc));  \
         } while (0)

With that, something like:

     PPC_BCC_SHORT(COND_NE, (ctx->idx + 3) * 4);

becomes

     PPC_BCC_CONST_SHORT(COND_NE, 12);

- Hari

