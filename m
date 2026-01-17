Return-Path: <linux-kselftest+bounces-49232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 321F1D38DE1
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57ADA301895E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898A930E851;
	Sat, 17 Jan 2026 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yy+z4kan"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C826F288;
	Sat, 17 Jan 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647119; cv=none; b=UaCZio2Hzdm5ZsYUlxCAwdx+i2NWN1kb7BPKbg+MKCEyji9xAMxvBTHrPqCWwwEXYX/czqx0xPddjPl2d59o8sD6whgnYI1zpXkIQv1nCUWK42Mdm3iUOJrSJ2boBxUCCsGjaAeOKkv3mhCRMj7ACIzBLIc4ov6Bh700Ic5BNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647119; c=relaxed/simple;
	bh=MOrXVS9brqjD8HkpCrDuRN6ePQPJZSXgRkzE56IB/jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAy/uv2s2FkHxmjO45ygvodpUfo9p7o5UoV/lcqziaqDK9pFD4EE+RgO6c8Iska2LJk+vMS8MI46E5fPd6MyR1CRwCS5aURL4O3/Mkt2kaiDoTN+Uxxnnh3Xvk+B0FMeVQ3CbKsh51VlHutVkmkj6XVaQYjMLJbCS0AfnZ55Bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yy+z4kan; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H4HApp018808;
	Sat, 17 Jan 2026 10:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kfVDCb
	jXC8zqETWW541g80/vE5JuUUf+AK8NyNjIWsk=; b=Yy+z4kanN6H87zn0xH0gGe
	ciWlsgTwNuIaqAoCSoa5gKzea3KtpcgZ/nDNkyAp2yoQBN7u1EftvdTyqVaijpRG
	ctDemLeY/IA4jZxPfFiTJgVkLmwKZPJGXpw84Qn91uG3zHUusdm5wAVH5d9foru4
	eC0zDkQ5pNESSKdbvr2ayXtBKzev0m9tRgDe42sScTXiYUH5l4TrL60HbZxaDldV
	wSwuPmQ6m87gYgp7Ku/OKQ2ByV5jao+QHI6w7L0FTMIVHIaCdTRC4Oez1JbJO7UV
	m7fqMjYXPHvovjHdTo/fqarA9qTANl/5JbrbS8e6if1ZE/LjqO04J9mElc2LLheQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255gyr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:51:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60HApP6n024799;
	Sat, 17 Jan 2026 10:51:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255gyr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:51:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60H5cM8P021593;
	Sat, 17 Jan 2026 10:51:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bqv8utnb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:51:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HApKaB53084496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 10:51:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC6320043;
	Sat, 17 Jan 2026 10:51:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F55C20040;
	Sat, 17 Jan 2026 10:51:14 +0000 (GMT)
Received: from [9.43.67.105] (unknown [9.43.67.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 10:51:14 +0000 (GMT)
Message-ID: <32757ffb-2fa8-448b-8c47-6979b430cad7@linux.ibm.com>
Date: Sat, 17 Jan 2026 16:21:13 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] powerpc64/bpf: Additional NVR handling for
 bpf_throw
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-7-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260114114450.30405-7-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA4OCBTYWx0ZWRfX6nH7ICCQkVCE
 og1USG+RnWHrvVogNWUhH0+zNBSIJf6Htc5W8glhn2MnWIaO+eCMfGzeWO2sioIrkMpvjEtBTEA
 CHr+kuUqTRg9o0w2LBI/zJpTJo/MNqlqnLucZYXjTy9G1zlTzWYdZoOW4xbkDQpZZBfyJtAXmBu
 R+9G0IMUOXu8WERZOklflR3Xgc1HEkSwMNPWbMTPJDQLevP1+wzmKUtphRg+tnobV3823KUR626
 4do3PXI2Zg8hPQ3FQlYCTzLzSQfEo+xeIS7znzZz+FLucRp/Pmf0B0A8sIQ1vXOfef4rESEwvlx
 k9zcEjrxSZvOuXBJt86Lar0+jFznW+/MB0hbYsYBHn7Jf9nhb637lzUASTkpkf3fjSej27thxQC
 HQoe8YaO70PS1H4fwpVv4Ny5l7C5d0iXWvfmnEXijkyWF1TobEe+T0qVEyIFYLW00Dq9XC9mxlf
 Fl6g/g5SyR3NYI8npEQ==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696b69ae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=rcOsPj18wkOm5uxQGMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dVXrvtC4vpHazqFy0P9N_mhGeRpl12rg
X-Proofpoint-ORIG-GUID: 1IZe1mavxB3DiKkNPWGqbAmNS8ajKMCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601170088



On 14/01/26 5:14 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The bpf_throw() function never returns, if it has
> clobbered any callee-saved register, those will
> remain clobbered. The prologue must take care of
> saving all callee-saved registers in the frame of
> exception boundary program. Later these additional
> non volatile registers R14-R25 along with other
> NVRs are restored back in the epilogue of exception
> callback.
> 
> To achieve above objective the frame size is
> determined dynamically to accommodate additional
> non volatile registers in exception boundary's frame.
> For non-exception boundary program, the frame size
> remains optimal. The additional instructions to
> save & restore r14-r25 registers are emitted only during
> exception boundary and exception callback respectively.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 70 +++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index a6083dd9786c..941e0818c9ec 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -32,21 +32,37 @@
>    *
>    *		[	prev sp		] <-------------
>    *		[    tail_call_info	] 8		|
> - *		[   nv gpr save area	] 6*8		|
> + *		[   nv gpr save area	] 6*8 + (12*8)	|
>    *		[    local_tmp_var	] 24		|
>    * fp (r31) -->	[   ebpf stack space	] upto 512	|
>    *		[     frame header	] 32/112	|
>    * sp (r1) --->	[    stack pointer	] --------------
> + *
> + * Additional (12*8) in 'nv gpr save area' only in case of
> + * exception boundary.
>    */
>   
>   /* for bpf JIT code internal usage */
>   #define BPF_PPC_STACK_LOCALS	24
> +/*
> + * for additional non volatile registers(r14-r25) to be saved
> + * at exception boundary
> + */
> +#define BPF_PPC_EXC_STACK_SAVE (12*8)
> +
>   /* stack frame excluding BPF stack, ensure this is quadword aligned */
>   #define BPF_PPC_STACKFRAME	(STACK_FRAME_MIN_SIZE + \
>   				 BPF_PPC_STACK_LOCALS + \
>   				 BPF_PPC_STACK_SAVE   + \
>   				 BPF_PPC_TAILCALL)
>   
> +/*
> + * same as BPF_PPC_STACKFRAME with save area for additional
> + * non volatile registers saved at exception boundary.
> + * This is quad-word aligned.
> + */
> +#define BPF_PPC_EXC_STACKFRAME (BPF_PPC_STACKFRAME + BPF_PPC_EXC_STACK_SAVE)
> +
>   /* BPF register usage */
>   #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
>   #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)
> @@ -103,9 +119,12 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
>    *		[	  ...       	] 		|
>    * sp (r1) --->	[    stack pointer	] --------------
>    *		[    tail_call_info	] 8
> - *		[   nv gpr save area	] 6*8
> + *		[   nv gpr save area	] 6*8 + (12*8)
>    *		[    local_tmp_var	] 24
>    *		[   unused red zone	] 224
> + *
> + * Additional (12*8) in 'nv gpr save area' only in case of
> + * exception boundary.
>    */
>   static int bpf_jit_stack_local(struct codegen_context *ctx)
>   {
> @@ -114,7 +133,11 @@ static int bpf_jit_stack_local(struct codegen_context *ctx)
>   		return STACK_FRAME_MIN_SIZE + ctx->stack_size;
>   	} else {
>   		/* Stack layout 2 */
> -		return -(BPF_PPC_TAILCALL + BPF_PPC_STACK_SAVE + BPF_PPC_STACK_LOCALS);
> +		return -(BPF_PPC_TAILCALL
> +			+ BPF_PPC_STACK_SAVE
> +			+ (ctx->exception_boundary || ctx->exception_cb ?
> +							BPF_PPC_EXC_STACK_SAVE:0)
> +			+ BPF_PPC_STACK_LOCALS);
>   	}
>   }
>   
> @@ -125,9 +148,19 @@ int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
>   
>   static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
>   {
> -	if (reg >= BPF_PPC_NVR_MIN && reg < 32)
> +	int min_valid_nvreg = BPF_PPC_NVR_MIN;
> +	/* Default frame size for all cases except exception boundary */
> +	int frame_nvr_size = BPF_PPC_STACKFRAME;
> +
> +	/* Consider all nv regs for handling exceptions */
> +	if (ctx->exception_boundary || ctx->exception_cb) {
> +		min_valid_nvreg = _R14;
> +		frame_nvr_size = BPF_PPC_EXC_STACKFRAME;
> +	}
> +
> +	if (reg >= min_valid_nvreg && reg < 32)
>   		return (bpf_has_stack_frame(ctx) ?
> -			(BPF_PPC_STACKFRAME + ctx->stack_size) : 0)
> +			(frame_nvr_size + ctx->stack_size) : 0)
>   				- (8 * (32 - reg)) - BPF_PPC_TAILCALL;
>   
>   	pr_err("BPF JIT is asking about unknown registers");
> @@ -189,7 +222,20 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>   			EMIT(PPC_RAW_STD(_R0, _R1, PPC_LR_STKOFF));
>   		}
>   

> -		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_STACKFRAME + ctx->stack_size)));
> +		int stack_expand = ctx->exception_boundary || ctx->exception_cb ?
> +					BPF_PPC_EXC_STACKFRAME : BPF_PPC_STACKFRAME;
> +		EMIT(PPC_RAW_STDU(_R1, _R1, -(stack_expand + ctx->stack_size)));

[...]

> -		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
> +		int stack_shrink = ctx->exception_cb || ctx->exception_boundary ?
> +					BPF_PPC_EXC_STACKFRAME : BPF_PPC_STACKFRAME;
> +		EMIT(PPC_RAW_ADDI(_R1, _R1, stack_shrink + ctx->stack_size));
> +

An inline helper bpf_jit_stack_size() defined to return the stack
size in both prologue and epilogue while setting up and tearing
down the stack should be more elegant.


Also, IIUC, the JIT code to handle tailcall info is irrelevant for
all subprogs of a BPF program with seen_exception. JIT code in the
prologue for tailcall count handling can be skipped for exception_cb
at least?

- Hari

