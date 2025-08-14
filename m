Return-Path: <linux-kselftest+bounces-38948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B7B25FE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F541CC39B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60602F39C0;
	Thu, 14 Aug 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XFZr1VeO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B32E92DD;
	Thu, 14 Aug 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161724; cv=none; b=As53RfXY8d93UepllxUHoviirsCqCDT6V4CoLOM0D/WsMYeewe6LGWoGaK+USgBQ931YaORr2UlHCscZisieXt/JRsYb7LrUx0TzN8IGjKPYq8tkcO0YPCE0Uc9Y7BdbdIKEFJjS/5x4oAq4bOPmjOCj+mMmaGkYvWC+hbmZfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161724; c=relaxed/simple;
	bh=6Vmj4US5Xqyf9e048bCgwbT9NTHN5rIV31COgxRmz60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6ZUWvTTuRC4F82mzwlLHZBblMkuqs4iMDM0CoSLJEvVdk7fgOWDfHiMUNNmiznMa1I2wP8Peebp8P1R1jdDxuL6E9ipSFdW1IpziNpcbr+3jBSgCn9UVNyJBjWrdEr/LlN+LgPqa3NYZK1kSSEV+UOLLMdINynyVM+oaGUW0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XFZr1VeO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DL3dI3029469;
	Thu, 14 Aug 2025 08:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=whOdfr
	q61HC2b6c2RvEBosbosNIAYwaBjKqGxS/i3L8=; b=XFZr1VeOTAS4pnDaNs6ZlU
	MCEGfY7cRFlmXjuXJmf6WLvv1Ah7GuoAPFztJYtWn14Iy5zzcHlLO/5sNKgvnVTn
	ZGIfFZoU8qz2ZiNgGrxm6InOpgYzNjMVET0BNrG7XyKxdtuxLVheW35HpetFXgxf
	Ov69DW/Co+9wCL49dNNr0MwPD4tDswQK6kFk0eayzDGE62R83Xr0kO25gOYiEBsy
	68lYhrWF+AWmUOM2VNqueYRRyzIh/F2iQO91r7LBSMrw7nA8UyMc9iOmdRl1qvJq
	YOPLgcVcN1ugUKyTcfYNns5fHmYPkOQJQBONZpgLCSLilNH5DDHxDQKMJsWeM3QA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudh6we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:54:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57E8mIRc016114;
	Thu, 14 Aug 2025 08:54:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudh6wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:54:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8HQ1k026282;
	Thu, 14 Aug 2025 08:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21bjtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:54:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8sgdj34341592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:54:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3878A20043;
	Thu, 14 Aug 2025 08:54:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62B1920040;
	Thu, 14 Aug 2025 08:54:36 +0000 (GMT)
Received: from [9.43.48.93] (unknown [9.43.48.93])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:54:36 +0000 (GMT)
Message-ID: <da3aef2d-44ab-4642-9114-15ef1e724bac@linux.ibm.com>
Date: Thu, 14 Aug 2025 14:24:35 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next 2/6] bpf,powerpc: Implement PROBE_MEM32 pseudo
 instructions
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-3-skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250805062747.3479221-3-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX5CgL0E9wwkun
 R63f9KBg7wVdCu8SuS/cIOVq1mUF0DdXWrs/1dBdDy7O3LfYw1O3G8a+mdeKQqBZseGvjhnkfs0
 303tA1UW5ALCBhUGzzLfEhN8Y5TBEJt5S5GJuTs3yshRD3DldnGnpLngyfBUSkp4bJQmuTUASsS
 WD3DqKGn6TdrQtLGe7daJtnLaFahfKMsm0D3vTL3MpRLP9qzVCYO/bESQU3dKz4EkR1Lc0wtnIC
 GZlCgEBien/h2XBW40pP2qvbWrOcRmJxofEdMUgq6HddpH8lqvefZyWB4n4uygB8npXgHlskhYK
 JWw42lgkbcf3Qw/7IRZkUqjKpCa0A4yFazrbrAx/Eg2ct6dJYbQHyGgIiCjPYeR+PjuB2XD9JqQ
 b+W/GBbD
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689da458 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=BwONYSiD_Lj_i5xjnBcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zwug4dAFJ6t_WLhbM3tnQg_dATGDni6l
X-Proofpoint-ORIG-GUID: Z6qPLp--akW95X8YqFoE3NvnVSuMsMU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 05/08/25 11:57 am, Saket Kumar Bhaskar wrote:
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
> instructions.  They are similar to PROBE_MEM instructions with the
> following differences:
> - PROBE_MEM32 supports store.
> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
> src/dst register
> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in _R26
> in the prologue). Due to bpf_arena constructions such _R26 + reg +
> off16 access is guaranteed to be within arena virtual range, so no
> address check at run-time.
> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
> LDX faults the destination register is zeroed.
> 
> To support these on powerpc, we do tmp1 = _R26 + src/dst reg and then use
> tmp1 as the new src/dst register. This allows us to reuse most of the
> code for normal [LDX | STX | ST].
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |   5 +-
>   arch/powerpc/net/bpf_jit_comp.c   |  10 ++-
>   arch/powerpc/net/bpf_jit_comp32.c |   2 +-
>   arch/powerpc/net/bpf_jit_comp64.c | 108 ++++++++++++++++++++++++++++--
>   4 files changed, 114 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 4c26912c2e3c..2d095a873305 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -161,9 +161,10 @@ struct codegen_context {
>   	unsigned int seen;
>   	unsigned int idx;
>   	unsigned int stack_size;
> -	int b2p[MAX_BPF_JIT_REG + 2];
> +	int b2p[MAX_BPF_JIT_REG + 3];
>   	unsigned int exentry_idx;
>   	unsigned int alt_exit_addr;
> +	u64 arena_vm_start;
>   };
>   
>   #define bpf_to_ppc(r)	(ctx->b2p[r])
> @@ -201,7 +202,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
>   
>   int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
>   			  struct codegen_context *ctx, int insn_idx,
> -			  int jmp_off, int dst_reg);
> +			  int jmp_off, int dst_reg, u32 code);
>   
>   #endif
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index c0684733e9d6..35bfdf4d8785 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -204,6 +204,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   
>   	/* Make sure that the stack is quadword aligned. */
>   	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
> +	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
>   
>   	/* Scouting faux-generate pass 0 */
>   	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> @@ -326,7 +327,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>    */
>   int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
>   			  struct codegen_context *ctx, int insn_idx, int jmp_off,
> -			  int dst_reg)
> +			  int dst_reg, u32 code)
>   {
>   	off_t offset;
>   	unsigned long pc;
> @@ -354,7 +355,12 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>   		(fp->aux->num_exentries * BPF_FIXUP_LEN * 4) +
>   		(ctx->exentry_idx * BPF_FIXUP_LEN * 4);
>   
> -	fixup[0] = PPC_RAW_LI(dst_reg, 0);
> +	if ((BPF_CLASS(code) == BPF_LDX && BPF_MODE(code) == BPF_PROBE_MEM32) ||
> +	    (BPF_CLASS(code) == BPF_LDX && BPF_MODE(code) == BPF_PROBE_MEM))
> +		fixup[0] = PPC_RAW_LI(dst_reg, 0);
> +	else if (BPF_CLASS(code) == BPF_ST || BPF_CLASS(code) == BPF_STX)
> +		fixup[0] = PPC_RAW_NOP();
> +
>   	if (IS_ENABLED(CONFIG_PPC32))
>   		fixup[1] = PPC_RAW_LI(dst_reg - 1, 0); /* clear higher 32-bit register too */
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 0aace304dfe1..3087e744fb25 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -1087,7 +1087,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   				}
>   
>   				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx, insn_idx,
> -							    jmp_off, dst_reg);
> +							    jmp_off, dst_reg, code);
>   				if (ret)
>   					return ret;
>   			}
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 489de21fe3d6..16e62766c757 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -44,6 +44,7 @@
>   /* BPF register usage */
>   #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
>   #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)
> +#define ARENA_VM_START  (MAX_BPF_JIT_REG + 2)
>   
>   /* BPF to ppc register mappings */
>   void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
> @@ -61,6 +62,8 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
>   	ctx->b2p[BPF_REG_7] = _R28;
>   	ctx->b2p[BPF_REG_8] = _R29;
>   	ctx->b2p[BPF_REG_9] = _R30;
> +	/* non volatile register for kern_vm_start address */
> +	ctx->b2p[ARENA_VM_START] = _R26;
>   	/* frame pointer aka BPF_REG_10 */
>   	ctx->b2p[BPF_REG_FP] = _R31;
>   	/* eBPF jit internal registers */
> @@ -69,8 +72,8 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
>   	ctx->b2p[TMP_REG_2] = _R10;
>   }
>   
> -/* PPC NVR range -- update this if we ever use NVRs below r27 */
> -#define BPF_PPC_NVR_MIN		_R27
> +/* PPC NVR range -- update this if we ever use NVRs below r26 */
> +#define BPF_PPC_NVR_MIN		_R26
>   
>   static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
>   {
> @@ -170,10 +173,17 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>   		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
>   			EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
>   
> +	if (ctx->arena_vm_start)
> +		EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
> +				 bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
> +

I don't see a selftest that tests both arena and tailcalls
together but the above change is going to clobber tailcall count.
That is because the current stack layout is impacted with this
new non-volatile register usage:

/*
  *              [       prev sp         ] <-------------
  *              [   nv gpr save area    ] 5*8           |
  *              [    tail_call_cnt      ] 8             |
  *              [    local_tmp_var      ] 16            |
  * fp (r31) --> [   ebpf stack space    ] upto 512      |
  *              [     frame header      ] 32/112        |
  * sp (r1) ---> [    stack pointer      ] --------------
  */

Please rework the above stack layout and the corresponding macros
accordingly.

>   	/* Setup frame pointer to point to the bpf stack area */
>   	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
>   		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
>   				STACK_FRAME_MIN_SIZE + ctx->stack_size));
> +
> +	if (ctx->arena_vm_start)
> +		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
>   }
>   
>   static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx)
> @@ -185,6 +195,10 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>   		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
>   			EMIT(PPC_RAW_LD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
>   
> +	if (ctx->arena_vm_start)
> +		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
> +				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
> +
>   	/* Tear down our stack frame */
>   	if (bpf_has_stack_frame(ctx)) {
>   		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));

- Hari


