Return-Path: <linux-kselftest+bounces-49093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93289D2C0CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 06:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 877353011EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71A343207;
	Fri, 16 Jan 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UjB32P8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799872C0268;
	Fri, 16 Jan 2026 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541954; cv=none; b=KAXeiPt1zZDeZ/shT5SUz5zrBKuNMK37ANu10w+/Zn5Iz0+hYwuOBul4rcfeF4TOrc5bjo+YhV5Y487N00ZUg/naAqRj0YFLZasMQximrjE240uhdkh62DD3uSXOOLBwxBO7z5U8z3Qhzb96/uFSbQPQC4w3tJwSachIFLYKuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541954; c=relaxed/simple;
	bh=GbpCoT2dk0umbgSkUVrDyGSyRLxyF9kI2oNamVnOMj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4DFz4/7UiDws36nduXSEggYfGG2OtVsMjwH4QHLrSZkO6u0qRoZRUsKhsuRxpVkqJiyRhr6roXDistz/JHPSOEMdtxsK+oelOtQP7xy5cE4YCSxFRKbpvqO+/z5lcwCJbW9b4Pv4Jnm4F04VjCQmGzuXz4Ymq3Rq144lIXKEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UjB32P8e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FMsW6g012171;
	Fri, 16 Jan 2026 05:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Qw6+8
	EwTEg8x19YdYYbMQsXqO5XG8J0H7fwMnQWZsc=; b=UjB32P8ek2zhGT9Q8IzJRA
	zt50skPyfQWg6l5hkwUrXlcW65PSvTHvL69H/r7n1dDnP/i0H7maYqUmk3iLcInd
	P4UYbIlzPm+kuyaQQctoHe4TqXMaI9rxYSLN/uMYywkTF5dlFozkKXLya2+Rj2tT
	L+Dlnw22okV0SkzSCtOp0o+YbbVqmcGL8l5il1+Aa0rFYJmiIyjjVxyoHYwf5fvA
	uxsOgvL+E7ZD1ZgRHPo+sJdfsE3ZGRsRawnvXwGYD+PU02UiWgxIvCrbUD/5hX+B
	PIo2WWdmNXqe0c9gz60RAxstrJCXIsudE5636SiBSVUYcFDNyR9zfPH3OeJfv2Tw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9ems1yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:38:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60G5VwEr016974;
	Fri, 16 Jan 2026 05:38:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9ems1ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:38:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60G4I6TW025866;
	Fri, 16 Jan 2026 05:38:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kkvb6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:38:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60G5cakq18546982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 05:38:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A042004D;
	Fri, 16 Jan 2026 05:38:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BBD720040;
	Fri, 16 Jan 2026 05:38:30 +0000 (GMT)
Received: from [9.43.87.191] (unknown [9.43.87.191])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Jan 2026 05:38:29 +0000 (GMT)
Message-ID: <6581bdf8-9894-487d-8af9-6a2c1835f928@linux.ibm.com>
Date: Fri, 16 Jan 2026 11:08:29 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF
 JIT
To: adubey <adubey@imap.linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
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
 <20260114114450.30405-5-adubey@linux.ibm.com>
 <18dacad3-ec1d-4c91-adfb-2ee8d592de29@kernel.org>
 <bec1dfbacced0198fa76bc59e73811c6@imap.linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <bec1dfbacced0198fa76bc59e73811c6@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KvJAGGWN c=1 sm=1 tr=0 ts=6969cee2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=lYxblflcVYe3kxWlPs0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA0MSBTYWx0ZWRfXyXZg9DW4MZUw
 xt9toPifdcKfFmlCwtHJtx+AwHz4RfGAX4trJbJ+BJeMm+uv8XE4BM/wouUG4wQMoTZLXS0YcEo
 a9bb8Ths3qxHcYRW17QtT/MR1xbhY9lYcAU47PO+7ViM96cL1kcPFyoD9gOoON0yOfysh7taTJ3
 ONbN2XBx+MZcwvr5oZp71Qo1Q0VEr+5yuY85fOuBUgxn9mcYp2VBtv3kuRWmWYXOzAZBJrZMtmL
 3rPvxBOouPBEaeS4TJAgvmFxbMP/jpFImxj8ix7i4u9+bBVIbYeocbgfpFH4Qzd3mwwhj1GdgO9
 dEqcgC1nqfGBeBGuBbjgQmUpkF2b2IppGJYkWG4P7Hc4sQ3MRkI7m4vCuDiH8EKOGga6ZjOQHcp
 pRuBz+P8fH/jErkjmR7JvCYNUh2/BbrqAHvepRHO5PYGeVDhMagJNrM+yF8ABpUsVeSXuGLqDbv
 R9DB4zDMvNAjwQ8BPxA==
X-Proofpoint-GUID: eIoYnUEObe_7qWne2iLAqzI3t2kKt8Xs
X-Proofpoint-ORIG-GUID: Af97WJLKubpArLrWsKGXjjHPG2-iARZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160041



On 14/01/26 6:50 pm, adubey wrote:
> On 2026-01-14 18:07, Christophe Leroy (CS GROUP) wrote:
>> Le 14/01/2026 à 12:44, adubey@linux.ibm.com a écrit :
>>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>>
>>> This function is used by bpf_throw() to unwind the stack
>>> until frame of exception-boundary during BPF exception
>>> handling.
>>>
>>> This function is necessary to support BPF exceptions on
>>> PowerPC.
>>>
>>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>>> ---
>>>   arch/powerpc/net/bpf_jit_comp64.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/ 
>>> bpf_jit_comp64.c
>>> index cebf81fbd59f..ec58395f74f7 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>>> @@ -247,6 +247,34 @@ void bpf_jit_build_epilogue(u32 *image, struct 
>>> codegen_context *ctx)
>>>       bpf_jit_build_fentry_stubs(image, ctx);
>>>   }
>>>   +void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, 
>>> u64), void *cookie)
>>> +{
>>> +    // callback processing always in current context
>>> +    unsigned long fp = current_stack_frame();
>>> +
>>> +    for (;;) {
>>> +        unsigned long *frame = (unsigned long *) fp;
>>> +        unsigned long ip;
>>> +
>>> +        if (!validate_sp(fp, current))
>>> +            return;
>>> +
>>> +        ip = frame[STACK_FRAME_LR_SAVE];
>>> +        if (!ip)
>>> +            break;
>>> +
>>> +        /*
>>> +         * consume_fn common code expects stack pointer(sp) in third
>>> +         * argument. There is no sp in ppc64, rather pass frame
>>> +         * pointer.
>>> +         */
>>> +        if (ip && !consume_fn(cookie, ip, fp, fp))
>>> +            break;
>>> +
>>> +        fp = frame[0];
>>> +    }
>>> +}
>>> +
>>
>> This fonction looks very close to arch_stack_walk(). Would it be
>> possible to refactor and have a common part used by both functions,
>> like ARM64 for instance ?
> Yes, its inspired from arch_stack_walk(). consume_entry() have different 
> parameter count in both cases.
> If merged, it need additional handling to identify which call_back to 
> invoke.
> Also, we need to define arch-specific weak function 
> arch_bpf_stack_walk(), so renaming of arch_stack_walk is needed on merge.
> Stack walker logic with "bpf" name might be confusing when used at other 
> places. Thoughts?

Not sure what you mean by renaming of arch_stack_walk is needed on
merge but refactoring does not have to change API signature or any
common code for that matter..

- Hari


