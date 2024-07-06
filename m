Return-Path: <linux-kselftest+bounces-13275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F24929236
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FEC1F21816
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139B4D8CE;
	Sat,  6 Jul 2024 09:28:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB831758;
	Sat,  6 Jul 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720258105; cv=none; b=AefofWjHwYjp3lMthzCkPKy9KQbImHQq/JYz98598FyZkSlCqQ0o4p7ghBHJx2XwIF3CltQZux1YWFmDJZbbI1xlbWeBeGm3es2c0gVQ/mm/ltlVMBpb/kvODPQqIWmS+gmVZ/pnD+XRXKfv9NXHSPfYdBwSqDw9En6CdXKBK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720258105; c=relaxed/simple;
	bh=OdxGGvjzjgYb4vNkuEKT9XJdE4c3YaQ4kAN33ASuK7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CX3sSmz141HVJ6ZouTxs7bBXhtGzv3qjQEgAaOAJZ3ZgmXqkaMAh8oBhaFr97pnVGfigmue74Ky3js2+4QqJFxUSyHwHTXA6n/P4G/luXxKqr887o4AFLWQ8jPY9nzjouxodVi1AXjXsIlxNNH6FYF5mln5wP6WGKFO88Jmd2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WGQ6M16YDz4f3kpQ;
	Sat,  6 Jul 2024 17:28:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9B7A11A0199;
	Sat,  6 Jul 2024 17:28:18 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgBnKmQvDolmDVMQBQ--.59961S2;
	Sat, 06 Jul 2024 17:28:16 +0800 (CST)
Message-ID: <5c43f532-c849-41c9-92dc-83925f5835d7@huaweicloud.com>
Date: Sat, 6 Jul 2024 17:28:15 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] arm64, bpf: Add 12-argument support for bpf
 trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240705125336.46820-1-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240705125336.46820-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnKmQvDolmDVMQBQ--.59961S2
X-Coremail-Antispam: 1UD129KBjvAXoW3trWkJFW7Cr4DXw47Kw48WFg_yoW8JF4xZo
	ZFgFsFvF4xGryfJ393Kr95Jry7Zan29rn7XayrJrs8XFySqr45Kr1fWw4fJ3WruF4jgFs7
	CF1jqa4UtF4fZFn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/5/2024 8:53 PM, Puranjay Mohan wrote:
> The arm64 bpf JIT currently supports attaching the trampoline to
> functions with <= 8 arguments. This is because up to 8 arguments can be
> passed in registers r0-r7. If there are more than 8 arguments then the
> 9th and later arguments are passed on the stack, with SP pointing to the
> first stacked argument. See aapcs64[1] for more details.
> 
> If the 8th argument is a structure of size > 8B, then it is passed fully
> on stack and r7 is not used for passing any argument. If there is a 9th
> argument, it will be passed on the stack, even though r7 is available.
> 
> Add the support of storing and restoring arguments passed on the stack
> to the arm64 bpf trampoline. This will allow attaching the trampoline to
> functions that take up to 12 arguments.
> 
> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#parameter-passing
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
> Changes in V1 -> V2:
> V1: https://lore.kernel.org/all/20240704173227.130491-1-puranjay@kernel.org/
> - Fixed the argument handling for composite types (structs)
> ---
>   arch/arm64/net/bpf_jit_comp.c                | 139 ++++++++++++++-----
>   tools/testing/selftests/bpf/DENYLIST.aarch64 |   3 -
>   2 files changed, 107 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 751331f5ba90..063bf5e11fc6 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -30,6 +30,8 @@
>   #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
>   #define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
>   #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
> +/* Up to eight function arguments are passed in registers r0-r7 */
> +#define ARM64_MAX_REG_ARGS 8
>   
>   #define check_imm(bits, imm) do {				\
>   	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
> @@ -2001,26 +2003,51 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
>   	}
>   }
>   
> -static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
> +static void save_args(struct jit_ctx *ctx, int args_off, int orig_sp_off,
> +		      int nargs, int nreg_args)
>   {
> +	const u8 tmp = bpf2a64[TMP_REG_1];
> +	int arg_pos;
>   	int i;
>   
> -	for (i = 0; i < nregs; i++) {
> -		emit(A64_STR64I(i, A64_SP, args_off), ctx);
> +	for (i = 0; i < nargs; i++) {
> +		if (i < nreg_args) {
> +			emit(A64_STR64I(i, A64_SP, args_off), ctx);
> +		} else {
> +			arg_pos = orig_sp_off + (i - nreg_args) * 8;
> +			emit(A64_LDR64I(tmp, A64_SP, arg_pos), ctx);
> +			emit(A64_STR64I(tmp, A64_SP, args_off), ctx);
> +		}
>   		args_off += 8;
>   	}
>   }
>   
> -static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
> +static void restore_args(struct jit_ctx *ctx, int args_off, int nreg_args)
>   {
>   	int i;
>   
> -	for (i = 0; i < nregs; i++) {
> +	for (i = 0; i < nreg_args; i++) {
>   		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
>   		args_off += 8;
>   	}
>   }
>   
> +static void restore_stack_args(struct jit_ctx *ctx, int args_off, int stk_arg_off,
> +			       int nargs, int nreg_args)
> +{
> +	const u8 tmp = bpf2a64[TMP_REG_1];
> +	int arg_pos;
> +	int i;
> +
> +	for (i = nreg_args; i < nargs; i++) {
> +		arg_pos = args_off + i * 8;
> +		emit(A64_LDR64I(tmp, A64_SP, arg_pos), ctx);
> +		emit(A64_STR64I(tmp, A64_SP, stk_arg_off), ctx);
> +
> +		stk_arg_off += 8;
> +	}
> +}
> +
>   /* Based on the x86's implementation of arch_prepare_bpf_trampoline().
>    *
>    * bpf prog and function entry before bpf trampoline hooked:
> @@ -2034,15 +2061,17 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
>    */
>   static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   			      struct bpf_tramp_links *tlinks, void *func_addr,
> -			      int nregs, u32 flags)
> +			      int nargs, int nreg_args, u32 flags)
>   {
>   	int i;
>   	int stack_size;
> +	int stk_arg_off;
> +	int orig_sp_off;
>   	int retaddr_off;
>   	int regs_off;
>   	int retval_off;
>   	int args_off;
> -	int nregs_off;
> +	int nargs_off;
>   	int ip_off;
>   	int run_ctx_off;
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> @@ -2052,6 +2081,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	__le32 **branches = NULL;
>   
>   	/* trampoline stack layout:
> +	 * SP + orig_sp_off [ first stack arg   ] if nargs > 8
>   	 *                  [ parent ip         ]
>   	 *                  [ FP                ]
>   	 * SP + retaddr_off [ self ip           ]
> @@ -2069,14 +2099,24 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	 *                  [ ...               ]
>   	 * SP + args_off    [ arg reg 1         ]
>   	 *
> -	 * SP + nregs_off   [ arg regs count    ]
> +	 * SP + nargs_off   [ arg count         ]
>   	 *
>   	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
>   	 *
>   	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
> +	 *
> +	 *		    [ stack_argN	]
> +	 *		    [ ...		]
> +	 * SP + stk_arg_off [ stack_arg1	] BPF_TRAMP_F_CALL_ORIG
>   	 */
>   
>   	stack_size = 0;
> +	stk_arg_off = stack_size;
> +	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nargs - nreg_args > 0)) {
> +		/* room for saving arguments passed on stack */
> +		stack_size += (nargs - nreg_args) * 8;
> +	}
> +
>   	run_ctx_off = stack_size;
>   	/* room for bpf_tramp_run_ctx */
>   	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
> @@ -2086,13 +2126,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	if (flags & BPF_TRAMP_F_IP_ARG)
>   		stack_size += 8;
>   
> -	nregs_off = stack_size;
> +	nargs_off = stack_size;
>   	/* room for args count */
>   	stack_size += 8;
>   
>   	args_off = stack_size;
>   	/* room for args */
> -	stack_size += nregs * 8;
> +	stack_size += nargs * 8;
>   
>   	/* room for return value */
>   	retval_off = stack_size;
> @@ -2110,6 +2150,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	/* return address locates above FP */
>   	retaddr_off = stack_size + 8;
>   
> +	/* original SP position
> +	 * stack_size + parent function frame + patched function frame
> +	 */
> +	orig_sp_off = stack_size + 32;
> +
>   	/* bpf trampoline may be invoked by 3 instruction types:
>   	 * 1. bl, attached to bpf prog or kernel function via short jump
>   	 * 2. br, attached to bpf prog or kernel function via long jump
> @@ -2135,12 +2180,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
>   	}
>   
> -	/* save arg regs count*/
> -	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
> -	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
> +	/* save argument count */
> +	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
> +	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
>   
> -	/* save arg regs */
> -	save_args(ctx, args_off, nregs);
> +	/* save arguments passed in regs and on the stack */
> +	save_args(ctx, args_off, orig_sp_off, nargs, nreg_args);
>   
>   	/* save callee saved registers */
>   	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -2167,7 +2212,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		restore_args(ctx, args_off, nregs);
> +		/* restore arguments that were passed in registers */
> +		restore_args(ctx, args_off, nreg_args);
> +		/* restore arguments that were passed on the stack */
> +		restore_stack_args(ctx, args_off, stk_arg_off, nargs, nreg_args);
>   		/* call original func */
>   		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>   		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
> @@ -2196,7 +2244,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_args(ctx, args_off, nregs);
> +		restore_args(ctx, args_off, nreg_args);
>   
>   	/* restore callee saved register x19 and x20 */
>   	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -2228,19 +2276,42 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	return ctx->idx;
>   }
>   
> -static int btf_func_model_nregs(const struct btf_func_model *m)
> +static int btf_func_model_nargs(const struct btf_func_model *m)
>   {
> -	int nregs = m->nr_args;
> +	int nargs = m->nr_args;
>   	int i;
>   
> -	/* extra registers needed for struct argument */
> +	/* extra registers or stack slots needed for struct argument */
>   	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
>   		/* The arg_size is at most 16 bytes, enforced by the verifier. */
>   		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> -			nregs += (m->arg_size[i] + 7) / 8 - 1;
> +			nargs += (m->arg_size[i] + 7) / 8 - 1;
>   	}
>   
> -	return nregs;
> +	return nargs;
> +}
> +
> +/* get the count of the regs that are used to pass arguments */
> +static int btf_func_model_nreg_args(const struct btf_func_model *m)
> +{
> +	int nargs = m->nr_args;
> +	int nreg_args = 0;
> +	int i;
> +
> +	for (i = 0; i < nargs; i++) {
> +		/* The arg_size is at most 16 bytes, enforced by the verifier. */
> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
> +			/* struct members are all in the registers or all
> +			 * on the stack.
> +			 */
> +			if (nreg_args + ((m->arg_size[i] + 7) / 8 - 1) > 7)
> +				break;
> +			nreg_args += (m->arg_size[i] + 7) / 8 - 1;
> +		}
> +		nreg_args++;
> +	}
> +
> +	return (nreg_args > ARM64_MAX_REG_ARGS ? ARM64_MAX_REG_ARGS : nreg_args);
>   }
>   
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> @@ -2251,14 +2322,16 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   		.idx = 0,
>   	};
>   	struct bpf_tramp_image im;
> -	int nregs, ret;
> +	int nargs, nreg_args, ret;
>   
> -	nregs = btf_func_model_nregs(m);
> -	/* the first 8 registers are used for arguments */
> -	if (nregs > 8)
> +	nargs = btf_func_model_nargs(m);
> +	if (nargs > MAX_BPF_FUNC_ARGS)
>   		return -ENOTSUPP;
>   
> -	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
> +	nreg_args = btf_func_model_nreg_args(m);
> +
> +	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nargs, nreg_args,
> +				 flags);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -2285,7 +2358,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>   				u32 flags, struct bpf_tramp_links *tlinks,
>   				void *func_addr)
>   {
> -	int ret, nregs;
> +	int ret, nargs, nreg_args;
>   	void *image, *tmp;
>   	u32 size = ro_image_end - ro_image;
>   
> @@ -2302,13 +2375,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>   		.idx = 0,
>   	};
>   
> -	nregs = btf_func_model_nregs(m);
> -	/* the first 8 registers are used for arguments */
> -	if (nregs > 8)
> +	nargs = btf_func_model_nargs(m);
> +	if (nargs > MAX_BPF_FUNC_ARGS)
>   		return -ENOTSUPP;
>   
> +	nreg_args = btf_func_model_nreg_args(m);
> +
>   	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
> -	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
> +	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nargs, nreg_args,
> +				 flags);
>   
>   	if (ret > 0 && validate_code(&ctx) < 0) {
>   		ret = -EINVAL;
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 3c7c3e79aa93..e865451e90d2 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -4,9 +4,6 @@ fexit_sleep                                      # The test never returns. The r
>   kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
>   kprobe_multi_test                                # needs CONFIG_FPROBE
>   module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
> -fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
> -fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
> -tracing_struct/struct_many_args                  # struct_many_args:FAIL:tracing_struct_many_args__attach unexpected error: -524
>   fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95

It looks like this patch, similar to [1], also does not handle
parameter alignment properly [2].

For example:

int func(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64_t f, __int128 g)
{
}

parameter a~d are passed through register x0~x6, while parameter
e~g are passed through stack. Since __int128 is 16-byte aligned,
parameter e, f, and g should be placed at sp + 0, +16, and +32
respectively, with 8 bytes **padding** between f and g.


And the compiler's alignment or packed attribute may make things
worse, causing parameters to be placed on the stack at positions
that are not naturally aligned.

[1] https://lore.kernel.org/bpf/20230917150752.69612-1-xukuohai@huaweicloud.com/
[2] https://lore.kernel.org/bpf/CABRcYmLtk8aQEzoUFw+j5Rdd-MXf-q+i7RHXZtu-skjRz11ZDw@mail.gmail.com/


