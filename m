Return-Path: <linux-kselftest+bounces-38284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A1CB1AFD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 09:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F006189FD79
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF62586C2;
	Tue,  5 Aug 2025 07:50:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F9230997;
	Tue,  5 Aug 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380247; cv=none; b=sjAKZvblyUxt1tdWEgd6TENDM9u2VjaPLD+6LuiAg3uNJfZ6hLzFYeFoxwvLI0rZsORl96SwexKIYWo2HEUBxl0w8tQ/0vUCDBUCysTwOfJMGmVU0gbdbiKUNdyiZyZTf0ZWWjjwv1X1seyL5DURYhqFW9fJ1z4fOkJrDSfKLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380247; c=relaxed/simple;
	bh=dcGXUt1lw3wXKBYwR4j+dEXdRhfuJ+Bo6i6A0db1rlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHT7XkB+MRLvpLUD9AYC4bEev4Th0/rNhLiuD9/0KZqCWZ1dKtMWJRZSvCDDrI3YQyQJeG/BbMRx14Nsy+bTN2l6y0/2B1t5hWTsTHWOg6zcI6S4mibwuQBAr7DJTIFgZ1sa59pgmn7JMJtvsh9ZjpdlNcjGyMGUOeDfR0KtNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bx4mh5xdKz9snj;
	Tue,  5 Aug 2025 09:29:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 223RPuL6PMvc; Tue,  5 Aug 2025 09:29:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bx4mh57Wpz9slR;
	Tue,  5 Aug 2025 09:29:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A64AA8B765;
	Tue,  5 Aug 2025 09:29:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9rErELeUWBy6; Tue,  5 Aug 2025 09:29:08 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A2B08B763;
	Tue,  5 Aug 2025 09:29:07 +0200 (CEST)
Message-ID: <bc6ef2d1-da06-4b29-a0ec-67549074bc0b@csgroup.eu>
Date: Tue, 5 Aug 2025 09:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next 3/6] bpf,powerpc: Implement bpf_addr_space_cast
 instruction
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-4-skb99@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250805062747.3479221-4-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> LLVM generates bpf_addr_space_cast instruction while translating
> pointers between native (zero) address space and
> __attribute__((address_space(N))). The addr_space=0 is reserved as
> bpf_arena address space.
> 
> rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
> converted to normal 32-bit move: wX = wY.
> 
> rY = addr_space_cast(rX, 1, 0) : used to convert a bpf arena pointer to
> a pointer in the userspace vma. This has to be converted by the JIT.
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |  1 +
>   arch/powerpc/net/bpf_jit_comp.c   |  6 ++++++
>   arch/powerpc/net/bpf_jit_comp64.c | 11 +++++++++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 2d095a873305..748e30e8b5b4 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -165,6 +165,7 @@ struct codegen_context {
>   	unsigned int exentry_idx;
>   	unsigned int alt_exit_addr;
>   	u64 arena_vm_start;
> +	u64 user_vm_start;
>   };
>   
>   #define bpf_to_ppc(r)	(ctx->b2p[r])
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 35bfdf4d8785..2b3f90930c27 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -205,6 +205,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	/* Make sure that the stack is quadword aligned. */
>   	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
>   	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
> +	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
>   
>   	/* Scouting faux-generate pass 0 */
>   	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> @@ -441,6 +442,11 @@ bool bpf_jit_supports_kfunc_call(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_arena(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>   bool bpf_jit_supports_far_kfunc_call(void)
>   {
>   	return IS_ENABLED(CONFIG_PPC64);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 16e62766c757..d4fe4dacf2d6 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -812,6 +812,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		 */
>   		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
>   		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
> +
> +			if (insn_is_cast_user(&insn[i])) {
> +				EMIT(PPC_RAW_RLDICL(tmp1_reg, src_reg, 0, 32));

Define and use PPC_RAW_RLDICL_DOT to avoid the CMPDI below.

> +				PPC_LI64(dst_reg, (ctx->user_vm_start & 0xffffffff00000000UL));
> +				EMIT(PPC_RAW_CMPDI(tmp1_reg, 0));
> +				PPC_BCC_SHORT(COND_EQ, (ctx->idx + 2) * 4);
> +				EMIT(PPC_RAW_OR(tmp1_reg, dst_reg, tmp1_reg));
> +				EMIT(PPC_RAW_MR(dst_reg, tmp1_reg));
> +				break;
> +			}
> +
>   			if (imm == 1) {
>   				/* special mov32 for zext */
>   				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));


