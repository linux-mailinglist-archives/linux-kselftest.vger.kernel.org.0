Return-Path: <linux-kselftest+bounces-49233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9FD38DF3
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C6F30198C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7B2E2DD2;
	Sat, 17 Jan 2026 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FIewgLUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082C1A2545;
	Sat, 17 Jan 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647681; cv=none; b=jokDXCnKVnDSArRNzu+25YUH6K9NaTmV+wS+9fiN8phyUi+WeD6z0oOTezlya2sBTSahBIGSqG931mQGHssmpX0EuIzG3GKI46DEQFmWfrjHjcHaEM/Zs2x82yy6OXlkosAfFiOV885tnVF7Et7sTsyD2ZLzSfQR2HdHrNXqmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647681; c=relaxed/simple;
	bh=deC+835z9R5t/JPqLFD/cwv7icZETy/IhbdOL1VzoFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAeyQ4zuf5wTXM3JiZhGFRqnO6dBuuc2ThN4ODlhxDmxha3iNYhNHdegg6zeC0mMHIP0GFvAqcJJnxc8V8RVxmwfBpV+gmT3AQicQUtTtWW4uge41R9vkn2XddFAaV4IplATIm34uhi3cknHB+2V5EMZHatCvh3PB/s85BF7Q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FIewgLUO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H4HZHh004816;
	Sat, 17 Jan 2026 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1SNm/5
	aqZ3rhSbT+9otGtxRrbWbLqj+kZVATUj1YiFs=; b=FIewgLUOs+kWkL5k8sCPL3
	rhAPIFzFMC6b+mW6ccAoa7+mSNZJ5IW5o3lXKI4wx/L32DQZXqXJFV1VYtmoiQsW
	skaut/3L/eOdxjcjQd4n5UX9ZzvrsTTcti5mXa/9YYaKBuQyg4kU227UfkMCZlg8
	egyyeH0hu9g+jse2DHp6trZukVsd0i4OHpKsNffivWR7vdcu8NrjVSTemef3audT
	EB8CChKnxwj4KBqV81QePUKAxAdQLWkvgU9Yh/nELpatRnby4IgY8EWt4ydWL6aH
	kY1An1vOT9UuTatr9UiLtVjVdjJjLUk45pMwWyTBHHPLHbhXTBDQ7QRkxicw/nag
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf129b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:59:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60HAxcGn030530;
	Sat, 17 Jan 2026 10:59:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf1298-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:59:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60HAhlrK026546;
	Sat, 17 Jan 2026 10:59:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bqv8xjnpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:59:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HAxXRK59703790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 10:59:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE9520043;
	Sat, 17 Jan 2026 10:59:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C051520040;
	Sat, 17 Jan 2026 10:59:27 +0000 (GMT)
Received: from [9.43.67.105] (unknown [9.43.67.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 10:59:27 +0000 (GMT)
Message-ID: <05f17f8b-4cbb-4d17-81f3-ada2ac12ce6b@linux.ibm.com>
Date: Sat, 17 Jan 2026 16:29:26 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] powerpc64/bpf: Move tail_call_cnt to bottom of
 stack frame
To: adubey <adubey@imap.linux.ibm.com>
Cc: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-2-adubey@linux.ibm.com>
 <dc2ab557-32d4-4c0e-a422-a41244f1dc3c@linux.ibm.com>
 <3e1c5930518113f349625cfa80ce82f5@imap.linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <3e1c5930518113f349625cfa80ce82f5@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XpzsFanhip6ZgallosX_6rsog6kTVlTe
X-Proofpoint-ORIG-GUID: a8QpuXkVbTaAuzgJwXmHK5LCurksTJhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA4OCBTYWx0ZWRfX8HwkPuiX2O8F
 cwVrcLbXud4SxS1I6m9ZzJRz6rLYq+0LsrrRuxv/HDiCIfZNwEObx2/M4t1Qi1hZyuDX4kGPlW7
 DRpq2+FixLDUKE1ckuE6ijSZc5vwBZ017tlCUwdKbBWQ/miPTzHjKcFX0D4h9jNJt3RNsje+pRR
 Pn6cPCdHpcmHVsVfE40il4lFuIsztYp2cCrAJo01JT1LjYO1zd844AX/Gh2nXlxZfE7+Tb1+vBY
 XBHsTIN5khE4OD64t8l3/QVueXISXsBRsfugJIsWoyZ12s9VSXE8eAhErPb4lFysJ8JUUX9PVyE
 5FH7OUZ0VO3iCNiex60Zj/Z1lXWCbmEM+pXVEHoD/bi8IXxbM6GkavYU2FrNvElwdyj6chHzpMW
 WotD5mFir3+9fi8HVh5mMX2+JwrVafh0ecBX6dNVSD7Gj/vmMd8b/AkhyqjPtmkJdl6+9ZMaIW/
 DiTrVJU3zYdhnfuIVTA==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696b6b9b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=kXKDjQROEg0k6TLzu70A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601170088



On 17/01/26 4:11 pm, adubey wrote:
> On 2026-01-17 15:41, Hari Bathini wrote:
>> On 14/01/26 5:14 pm, adubey@linux.ibm.com wrote:
>>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>>
>>> In the conventional stack frame, the position of tail_call_cnt
>>> is after the NVR save area (BPF_PPC_STACK_SAVE). Whereas, the
>>> offset of tail_call_cnt in the trampoline frame is after the
>>> stack alignment padding. BPF JIT logic could become complex
>>> when dealing with frame-sensitive offset calculation of
>>> tail_call_cnt. Having the same offset in both frames is the
>>> desired objective.
>>>
>>> The trampoline frame does not have a BPF_PPC_STACK_SAVE area.
>>> Introducing it leads to under-utilization of extra memory meant
>>> only for the offset alignment of tail_call_cnt.
>>> Another challenge is the variable alignment padding sitting at
>>> the bottom of the trampoline frame, which requires additional
>>> handling to compute tail_call_cnt offset.
>>>
>>> This patch addresses the above issues by moving tail_call_cnt
>>> to the bottom of the stack frame at offset 0 for both types
>>> of frames. This saves additional bytes required by BPF_PPC_STACK_SAVE
>>> in trampoline frame, and a common offset computation for
>>> tail_call_cnt serves both frames.
>>>
>>> The changes in this patch are required by the third patch in the
>>> series, where the 'reference to tail_call_info' of the main frame
>>> is copied into the trampoline frame from the previous frame.
>>>
>>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>>> ---
>>>   arch/powerpc/net/bpf_jit.h        |  4 ++++
>>>   arch/powerpc/net/bpf_jit_comp64.c | 31 ++++++++++++++++++++-----------
>>>   2 files changed, 24 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>>> index 8334cd667bba..45d419c0ee73 100644
>>> --- a/arch/powerpc/net/bpf_jit.h
>>> +++ b/arch/powerpc/net/bpf_jit.h
>>> @@ -72,6 +72,10 @@
>>>       } } while (0)
>>>     #ifdef CONFIG_PPC64
>>> +
>>> +/* for tailcall counter */
>>> +#define BPF_PPC_TAILCALL        8
>>> +
>>>   /* If dummy pass (!image), account for maximum possible 
>>> instructions */
>>>   #define PPC_LI64(d, i)        do {                          \
>>>       if (!image)                                  \
>>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/ 
>>> bpf_jit_comp64.c
>>> index 1fe37128c876..39061cd742c1 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>>> @@ -20,13 +20,15 @@
>>>   #include "bpf_jit.h"
>>>     /*
>>> - * Stack layout:
>>> + * Stack layout 1:
>>> + * Layout when setting up our own stack frame.
>>> + * Note: r1 at bottom, component offsets positive wrt r1.
>>>    * Ensure the top half (upto local_tmp_var) stays consistent
>>>    * with our redzone usage.
>>>    *
>>>    *        [    prev sp        ] <-------------
>>> - *        [   nv gpr save area    ] 6*8        |
>>>    *        [    tail_call_cnt    ] 8        |
>>> + *        [   nv gpr save area    ] 6*8        |
>>>    *        [    local_tmp_var    ] 24        |
>>>    * fp (r31) -->    [   ebpf stack space    ] upto 512    |
>>>    *        [     frame header    ] 32/112    |
>>> @@ -36,10 +38,12 @@
>>>   /* for gpr non volatile registers BPG_REG_6 to 10 */
>>>   #define BPF_PPC_STACK_SAVE    (6*8)
>>>   /* for bpf JIT code internal usage */
>>> -#define BPF_PPC_STACK_LOCALS    32
>>> +#define BPF_PPC_STACK_LOCALS    24
>>>   /* stack frame excluding BPF stack, ensure this is quadword aligned */
>>>   #define BPF_PPC_STACKFRAME    (STACK_FRAME_MIN_SIZE + \
>>> -                 BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE)
>>> +                 BPF_PPC_STACK_LOCALS + \
>>> +                 BPF_PPC_STACK_SAVE   + \
>>> +                 BPF_PPC_TAILCALL)
>>>     /* BPF register usage */
>>>   #define TMP_REG_1    (MAX_BPF_JIT_REG + 0)
>>> @@ -87,27 +91,32 @@ static inline bool bpf_has_stack_frame(struct 
>>> codegen_context *ctx)
>>>   }
>>>
>>
>>>   /*
>>> + * Stack layout 2:
>>>    * When not setting up our own stackframe, the redzone (288 bytes) 
>>> usage is:
>>> + * Note: r1 from prev frame. Component offset negative wrt r1.
>>>    *
>>>    *        [    prev sp        ] <-------------
>>>    *        [      ...           ]         |
>>>    * sp (r1) --->    [    stack pointer    ] --------------
>>> - *        [   nv gpr save area    ] 6*8
>>>    *        [    tail_call_cnt    ] 8
>>> + *        [   nv gpr save area    ] 6*8
>>>    *        [    local_tmp_var    ] 24
>>>    *        [   unused red zone    ] 224
>>>    */
>>
>> Calling it stack layout 1 & 2 is inappropriate. The stack layout
>> is essentially the same. It just goes to show things with reference
>> to r1 when stack is setup explicitly vs when redzone is being used...
> Agree. I am using it as labels to refer in comment. Any better suggestions?
I think the comments could refer to has stack frame vs Redzone case..

- Hari


