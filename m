Return-Path: <linux-kselftest+bounces-49230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4E2D38DCA
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3202D3015846
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587C3043BE;
	Sat, 17 Jan 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i74IbytS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F125FA0E;
	Sat, 17 Jan 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768646369; cv=none; b=QCVvZFfdb7GxjcEUe/GyFI+f1eV9/C6jbSqY6qauH27GwhQlHMNNpAkFSwjRa0lShB17v5d1Beff0hFGQvJpH0rxQfbGt9udsnFPyWiMlK4vK11qW3f16D92YU4r0HZ6EE0ZkN03wjjd70bnbRypR12XRHVrLjvZULQu+vHdCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768646369; c=relaxed/simple;
	bh=4Rl/ipNalewA/fuSDICIGYJ4LO4jxdn5Bou9/prqk2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1UWk5I5HQbLUnynyZV/FFtCBLb+fIe/j+5T1mBN5/w7zNbixXLwchbFPGpgMT+noPc6mFeZA728jSJRiHuXC1eBait/cAPmW8QUTMHfXrhjwiUwkmKRi/ZNDl4Yuvcx49QMhUDXRJUp0dcRU7eg/uioBEidPRkwR/hncoWjIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i74IbytS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H9HfKo007392;
	Sat, 17 Jan 2026 10:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EDU52d
	hd8OnGtL6KexpRJpCaQYA2Ct4rZnuShWVRD+8=; b=i74IbytSeqJpb6a8wBp2mv
	rlpKYwt3952FEkYcq5VnSqpLpvmY0vYISJ0F1hyY26OD+UnC+YiRhEXQIiAvHmNz
	SraZp+0Kxqkbtf97eC0kYEdYTFEVszoK3/QQGcDCYYCIyy9APNBWkJs3zkF67xes
	OcfhobMNpaJNpAH7X0tVKgPgqRhiKU/mxRpIsk+Sn5eEs+G9CsJwdw8Z2XyAyb8S
	sm5svudOAqlCQJD6Hl2ci1RgJXncdrNWA4pUtknEn6ViHP7NqxCqZYXByLOxX8ZM
	iJTPCJG6iS/oC+ogQiLUpEHLyh+URMhWCw3+jFPB0GbyZPthW69Cwld+1yLRIeSg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4s00f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:39:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60H5PrKh009093;
	Sat, 17 Jan 2026 10:39:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bqv8xjmfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:39:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HAdEfm30474972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 10:39:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35EC20043;
	Sat, 17 Jan 2026 10:39:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F25B320040;
	Sat, 17 Jan 2026 10:39:07 +0000 (GMT)
Received: from [9.43.67.105] (unknown [9.43.67.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 10:39:07 +0000 (GMT)
Message-ID: <49fda5e0-554b-4c62-a1be-477c5337b591@linux.ibm.com>
Date: Sat, 17 Jan 2026 16:09:07 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] powerpc64/bpf: Tailcall handling with trampolines
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
 <20260114114450.30405-4-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260114114450.30405-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696b66d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=MoZGA3zZGvtkHrcMs6gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IfLNrYfl0ZKhaRVBMlSl0c1aK3Tx11hm
X-Proofpoint-GUID: IfLNrYfl0ZKhaRVBMlSl0c1aK3Tx11hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA4NCBTYWx0ZWRfX/S7/hC+EOPs4
 T+9SPEMoqejPx75f2WvFYjd6J8+vo8KBfyq0eKFPmtLSEd8/LoHIFDwQWHR0P2jj/TW/a88PRU5
 yQi9pOXFMDsWDQw+MyHE+1mZex3KmxWMMgH4QWJMkM35XE9TG9qwfDMBN4+5P6Sb61Yv18x7+w0
 hhRjfXhLCoS76l0gVkFDTbxtKP+fLAa8GGCrIMcxDrigKyefXg7E9f7ZuMeJ0Yh7QcLmeONpGRf
 vFa4JUVRehhyPvBxO6fd/rp3uEVU+vfdR97riUF4hNvi6SFr5Bpr1B2tviGD4a8xdpkq6tCvMc8
 vlHUua3DQa9fzDnfAe//BqPZS7EGCCpU80+yTwUtE5JZYYWZ1ZwxI3JLShMdZs95fWDGj4D/wMJ
 oBKdZyxa6c0KLruKoba9TYCdp8FlA5fOXHUnsCkg6t/EKrc0JqlgHvd7rUXf4tH6s4UDKD821Ew
 ikYK8A2QDH8Y9v6vDAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601170084



On 14/01/26 5:14 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The trampoline mechanism sets up its own stack frame and
> an additional dummy frame. We need to have additional JIT
> instructions handling tailcall dereferencing in the
> trampoline's context.
> 
> We don't add the two stack frames pointed above, rather
> add space for tail_call_info at bottom in trampoline frame
> for ppc64. This makes the trampoline's frame consistent with
> layout of all other frames wrt tail_call_info offset.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 83 ++++++++++++++++++++++-----------
>   1 file changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 069a8822c30d..e3088cf089d1 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -606,33 +606,58 @@ static int invoke_bpf_mod_ret(u32 *image, u32 *ro_image, struct codegen_context
>   	return 0;
>   }
>   
> -static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_context *ctx,
> -					       int func_frame_offset, int r4_off)
> -{
> -	if (IS_ENABLED(CONFIG_PPC64)) {
> -		/* See bpf_jit_stack_tailcallinfo_offset() */
> -		int tailcallcnt_offset = 7 * 8;
> -
> -		EMIT(PPC_RAW_LL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
> -		EMIT(PPC_RAW_STL(_R3, _R1, -tailcallcnt_offset));
> -	} else {
> -		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
> -		EMIT(PPC_RAW_LL(_R4, _R1, r4_off));
> -	}
> -}
> +/*
> + * Refer the label 'Generated stack layout' in this file for actual stack
> + * layout during trampoline invocation.
> + *
> + * Refer __arch_prepare_bpf_trampoline() for stack component details.
> + *
> + * The tailcall count/reference is present in caller's stack frame. Its required
> + * to copy the content of tail_call_info before calling the actual function
> + * to which the trampoline is attached.
> + *
> + */
>   
> -static void bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_context *ctx,
> -						 int func_frame_offset, int r4_off)
> +static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
> +					       int func_frame_offset,
> +					       int bpf_dummy_frame_size, int r4_off)
>   {
>   	if (IS_ENABLED(CONFIG_PPC64)) {
>   		/* See bpf_jit_stack_tailcallinfo_offset() */

> -		int tailcallcnt_offset = 7 * 8;
> +		int tailcallinfo_offset = BPF_PPC_TAILCALL;

This offset update should have been part of patch#1

> +		/*
> +		 * func_frame_offset =                                   ...(1)
> +		 *     bpf_dummy_frame_size + trampoline_frame_size
> +		 */
> +		EMIT(PPC_RAW_LD(_R4, _R1, func_frame_offset));
> +		EMIT(PPC_RAW_LD(_R3, _R4, -tailcallinfo_offset));
> +
> +		/*
> +		 * Setting the tail_call_info in trampoline's frame
> +		 * depending on if previous frame had value or reference.
> +		 */
> +		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
> +		PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
> +		EMIT(PPC_RAW_ADDI(_R3, _R4, bpf_jit_stack_tailcallinfo_offset(ctx)));
> +		/*
> +		 * From ...(1) above:
> +		 * trampoline_frame_bottom =                            ...(2)
> +		 *     func_frame_offset - bpf_dummy_frame_size
> +		 *
> +		 * Using ...(2) derived above:
> +		 *  trampoline_tail_call_info_offset =                  ...(3)
> +		 *      trampoline_frame_bottom - tailcallinfo_offset
> +		 *
> +		 * From ...(3):
> +		 * Use trampoline_tail_call_info_offset to write reference of main's
> +		 * tail_call_info in trampoline frame.
> +		 */
> +		EMIT(PPC_RAW_STL(_R3, _R1, (func_frame_offset - bpf_dummy_frame_size)
> +					- tailcallinfo_offset));
>   
> -		EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
> -		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
>   	} else {
>   		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
> -		EMIT(PPC_RAW_STL(_R4, _R1, r4_off));
> +		EMIT(PPC_RAW_LL(_R4, _R1, r4_off));
>   	}
>   }
>   
> @@ -720,6 +745,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   	 * LR save area                 [ r0 save (64-bit)  ]   | header
>   	 *                              [ r0 save (32-bit)  ]   |
>   	 * dummy frame for unwind       [ back chain 1      ] --
> +	 *                              [ tail_call_info    ] non optional - 64-bit powerpc
>   	 *                              [ padding           ] align stack frame
>   	 *       r4_off                 [ r4 (tailcallcnt)  ] optional - 32-bit powerpc
>   	 *       alt_lr_off             [ real lr (ool stub)] optional - actual lr

> @@ -801,8 +827,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		}
>   	}
>   
> -	/* Padding to align stack frame, if any */
> -	bpf_frame_size = round_up(bpf_frame_size, SZL * 2);
> +	if (!(bpf_frame_size % (2 * SZL))) {
> +		/* Stack is 16-byte aligned */
> +		/* Room for padding followed by 64-bit tail_call_info */
> +		bpf_frame_size += SZL + BPF_PPC_TAILCALL;
> +	} else {
> +		/* Room for 64-bit tail_call_info */
> +		bpf_frame_size += BPF_PPC_TAILCALL;
> +	}
>   
>   	/* Dummy frame size for proper unwind - includes 64-bytes red zone for 64-bit powerpc */
>   	bpf_dummy_frame_size = STACK_FRAME_MIN_SIZE + 64;

This change assumes the size is at least 8-byte aligned which is
true today but better skip that assumption by not touching the
padding part. The above hunk could simply be:

diff --git a/arch/powerpc/net/bpf_jit_comp.c 
b/arch/powerpc/net/bpf_jit_comp.c
index 5e976730b2f5..266cc6f17dcc 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -795,6 +795,10 @@ static int __arch_prepare_bpf_trampoline(struct 
bpf_tramp_image *im, void *rw_im
                 }
         }

+       /* Save tailcall count pointer at the same offset on the stack 
where subprogs expect it */
+       if ((flags & BPF_TRAMP_F_CALL_ORIG) && (flags & 
BPF_TRAMP_F_TAIL_CALL_CTX))
+               bpf_frame_size += SZL;
+
         /* Padding to align stack frame, if any */
         bpf_frame_size = round_up(bpf_frame_size, SZL * 2);


Patch#2 is not complete without this change. Please fold this patch
into patch#2 itself.

- Hari


