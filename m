Return-Path: <linux-kselftest+bounces-48934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 419FED1ED26
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 13:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE5E304D4A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E49395242;
	Wed, 14 Jan 2026 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxhIGXZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E037BE9D;
	Wed, 14 Jan 2026 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394277; cv=none; b=mSho5wQL5mziBdJxFW3mgHJ7fsE7xKnnGS+WdS1EsSnqqR1Fj2o3WBI3a+fihopuooqJ0BI+Kgh3bho8pEyrIg22PrJ+3gyXqBq7LFLkWSLMaJVV49vypy1kM8ECtTUbnBNnSsmHZePiv2FlkecyNEHdMduoO/UCcG+ETw/q7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394277; c=relaxed/simple;
	bh=lNpjmkdFV/Up7u2UcfDh2qsaN2WPt0yc3qVyJNVl+04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sc8ZDhdOfmqA51V8vP4J7APwi24NriMKefs7mKXZFOta8CExv9M2RtWmTCubHdMIfCAe2/x6rS9qQyuArRUG2GNO6ljI1d1w0MYV2o1Q8UXbpeEHDg5frhDQaBAtU4LQm9QLisnbuPKuAuBMjBK3VKh8YoGV5o2d5o/QXCbEZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxhIGXZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E449EC4CEF7;
	Wed, 14 Jan 2026 12:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394276;
	bh=lNpjmkdFV/Up7u2UcfDh2qsaN2WPt0yc3qVyJNVl+04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mxhIGXZSrgGZ43btZ+ttNG5DeVmxHV6GEwrU66wB/pmLKSOywFZDEEG5gTiCS/or1
	 5zHdjDSRSL/kr6cHiZcckKD9fIfC61cyBEQUiK9hVGZTzkDpbB7ihDmfYELUZeJUOE
	 co724rkK9uytdwLB3BSN+3aMrb7WTWgY5Bu3wLdVCK3nDaFTP4btHhbP0tjKa6Fw5A
	 dFXOPC3hk62hU9/FezcMOsHId5HId+YxFmoK6sjvqm0TW9kxjkLm3vf8I2jxNqCg5b
	 YfrAAFtT66/gspVbpkk/azZaC4E9tetUPsVBGNd8FxAEue629r3yRzoIPg//nA1lm2
	 UgXStecUrLNzQ==
Message-ID: <18dacad3-ec1d-4c91-adfb-2ee8d592de29@kernel.org>
Date: Wed, 14 Jan 2026 13:37:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF
 JIT
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-5-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260114114450.30405-5-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/01/2026 à 12:44, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> This function is used by bpf_throw() to unwind the stack
> until frame of exception-boundary during BPF exception
> handling.
> 
> This function is necessary to support BPF exceptions on
> PowerPC.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index cebf81fbd59f..ec58395f74f7 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -247,6 +247,34 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>   	bpf_jit_build_fentry_stubs(image, ctx);
>   }
>   
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie)
> +{
> +	// callback processing always in current context
> +	unsigned long fp = current_stack_frame();
> +
> +	for (;;) {
> +		unsigned long *frame = (unsigned long *) fp;
> +		unsigned long ip;
> +
> +		if (!validate_sp(fp, current))
> +			return;
> +
> +		ip = frame[STACK_FRAME_LR_SAVE];
> +		if (!ip)
> +			break;
> +
> +		/*
> +		 * consume_fn common code expects stack pointer(sp) in third
> +		 * argument. There is no sp in ppc64, rather pass frame
> +		 * pointer.
> +		 */
> +		if (ip && !consume_fn(cookie, ip, fp, fp))
> +			break;
> +
> +		fp = frame[0];
> +	}
> +}
> +

This fonction looks very close to arch_stack_walk(). Would it be 
possible to refactor and have a common part used by both functions, like 
ARM64 for instance ?

>   int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;


