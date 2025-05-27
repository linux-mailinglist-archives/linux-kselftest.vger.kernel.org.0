Return-Path: <linux-kselftest+bounces-33837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745DAC49EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BB2189B70D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A9248886;
	Tue, 27 May 2025 08:11:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A7154457;
	Tue, 27 May 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333487; cv=none; b=Um90nfWcs7Y+8UFnlNQIH4t5goYgn1lRWrpLdJOwm5dcqGQaUDznyRPV88hmlehVV15ArJa+Y1SE/uGO5kyhjJE6KAbq0PdRtif6QkxfEYNysJVAN77W10CdB/n8WOthFfIKFNxzJmwlopPuaGTqmPl+xADNfbU6/iD7tzmY3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333487; c=relaxed/simple;
	bh=wkEbYlUmL/0e/Oq4Kc62UXZiv8Icaa5HQS20G9Srl+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtejY/z44ULheguW0DREMGSkiwVuHAzN/mBHqtWdRQ/20XB/DyANNKjbSRFc2/JzvsBHAR6+02F0T+5ezsZMVFq1T13sH+s0ROk17Y2Ww4NkNprSPOgRNB/OnyDfx+A3N6w00qabrlua7tnRwiz5gd5psAzfFkZ0qPUk7ruMtCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b651k2LxrzYQv8L;
	Tue, 27 May 2025 16:11:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 701BD1A252A;
	Tue, 27 May 2025 16:11:21 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCXRlunczVo2KyeNg--.19162S2;
	Tue, 27 May 2025 16:11:21 +0800 (CST)
Message-ID: <8d184497-fecf-497f-8b4c-bcd4b0a697ce@huaweicloud.com>
Date: Tue, 27 May 2025 16:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, arm64: Support up to 12 function
 arguments
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Xu Kuohai <xukuohai@huawei.com>
References: <20250522-many_args_arm64-v2-0-d6afdb9cf819@bootlin.com>
 <20250522-many_args_arm64-v2-1-d6afdb9cf819@bootlin.com>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250522-many_args_arm64-v2-1-d6afdb9cf819@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXRlunczVo2KyeNg--.19162S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxAw1DZr17tr1xKryrtFb_yoWrCrWxpr
	nYk3ZxGFs3Zw40g3WrXw4UX34FkFs5tF4Y9r48A343AF4DKrykKFsYkayjkFyfCr1kAF4j
	93s0vrsxAF45J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 5/22/2025 6:14 PM, Alexis Lothoré wrote:

[...]

> -static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
> +struct arg_aux {
> +	/* how many args are passed through registers, the rest of the args are
> +	 * passed through stack
> +	 */
> +	int args_in_regs;
> +	/* how many registers are used to pass arguments */
> +	int regs_for_args;
> +	/* how much stack is used for additional args passed to bpf program
> +	 * that did not fit in original function registers
> +	 **/

nit: "**/" should be "*/"

> +	int bstack_for_args;
> +	/* home much stack is used for additional args passed to the
> +	 * original function when called from trampoline (this one needs
> +	 * arguments to be properly aligned)
> +	 */
> +	int ostack_for_args;
> +};
> +
> +static int calc_arg_aux(const struct btf_func_model *m,
> +			 struct arg_aux *a)
>   {
> -	int i;
> +	int stack_slots, nregs, slots, i;
> +
> +	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
> +	for (i = 0, nregs = 0; i < m->nr_args; i++) {
> +		slots = (m->arg_size[i] + 7) / 8;
> +		if (nregs + slots <= 8) /* passed through register ? */
> +			nregs += slots;
> +		else
> +			break;
> +	}
> +
> +	a->args_in_regs = i;
> +	a->regs_for_args = nregs;
> +	a->ostack_for_args = 0;
> +
> +	/* the rest arguments are passed through stack */
> +	for (a->ostack_for_args = 0, a->bstack_for_args = 0;
> +	     i < m->nr_args; i++) {

a->ostack_for_args is initialized twice.

move all initializations before the loop?

> +		/* We can not know for sure about exact alignment needs for
> +		 * struct passed on stack, so deny those
> +		 */
> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> +			return -EOPNOTSUPP;

leave the error code as is, namely, return -ENOTSUPP?

> +		stack_slots = (m->arg_size[i] + 7) / 8;
> +		/* AAPCS 64 C.14: arguments passed on stack must be aligned to
> +		 * max(8, arg_natural_alignment)
> +		 */
> +		a->bstack_for_args += stack_slots * 8;
> +		a->ostack_for_args = round_up(a->ostack_for_args + stack_slots * 8, 8);

since a->ostack_for_args starts from 0 and is always incremented
by multiples of 8, round_up() to 8 is not needed.

> +	}
>   
> -	for (i = 0; i < nregs; i++) {
> -		emit(A64_STR64I(i, A64_SP, args_off), ctx);
> -		args_off += 8;
> +	return 0;
> +}
> +
> +static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
> +{
> +	if (effective_bytes) {
> +		int garbage_bits = 64 - 8 * effective_bytes;
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +		/* garbage bits are at the right end */
> +		emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
> +		emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
> +#else
> +		/* garbage bits are at the left end */
> +		emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
> +		emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
> +#endif
>   	}
>   }
>   
> -static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
> +static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
> +		      const struct btf_func_model *m,
> +		      const struct arg_aux *a,
> +		      bool for_call_origin)
>   {
>   	int i;
> +	int reg;
> +	int doff;
> +	int soff;
> +	int slots;
> +	u8 tmp = bpf2a64[TMP_REG_1];
> +
> +	/* store arguments to the stack for the bpf program, or restore
> +	 * arguments from stack for the original function
> +	 */
> +	for (reg = 0; reg < a->regs_for_args; reg++) {
> +		emit(for_call_origin ?
> +		     A64_LDR64I(reg, A64_SP, bargs_off) :
> +		     A64_STR64I(reg, A64_SP, bargs_off),
> +		     ctx);
> +		bargs_off += 8;
> +	}
> +
> +	soff = 32; /* on stack arguments start from FP + 32 */
> +	doff = (for_call_origin ? oargs_off : bargs_off);
> +
> +	/* save on stack arguments */
> +	for (i = a->args_in_regs; i < m->nr_args; i++) {
> +		slots = (m->arg_size[i] + 7) / 8;
> +		/* AAPCS C.14: additional arguments on stack must be
> +		 * aligned on max(8, arg_natural_alignment)
> +		 */
> +		soff = round_up(soff, 8);
> +		if (for_call_origin)
> +			doff =  round_up(doff, 8);

since both soff and doff start from multiples of 8 and are
incremented by 8 each time, the two round_up()s are also
not needed.

> +		/* verifier ensures arg_size <= 16, so slots equals 1 or 2 */
> +		while (slots-- > 0) {
> +			emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
> +			/* if there is unused space in the last slot, clear
> +			 * the garbage contained in the space.
> +			 */
> +			if (slots == 0 && !for_call_origin)
> +				clear_garbage(ctx, tmp, m->arg_size[i] % 8);
> +			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
> +			soff += 8;
> +			doff += 8;
> +		}
> +	}
> +}

[...]


