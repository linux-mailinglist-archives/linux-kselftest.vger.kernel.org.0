Return-Path: <linux-kselftest+bounces-48933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A57D1ECED
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59EC6307930E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE561399024;
	Wed, 14 Jan 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/zoVWmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5752399014;
	Wed, 14 Jan 2026 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394140; cv=none; b=Sw4spEVgsgLZ7lBSpr7cDWpTHUrg8zHllNmi/UJYwdDZZamxKubDAGGFaz2pRS3m48YR3WNhX9iFTaN59kYn1o/1rlNyoG4vvJTJ7xNWaqvnN7nHdYTgZhGTcV9ZO5EOajdpWHMeUBtHqrteqhmE7zZUqxWBVBP/wjwxMf5AvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394140; c=relaxed/simple;
	bh=ev6Qij2PVomzOpcTr7azRUZ5e+KCI6UhuAdUkmLUPrc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IbrwTggB82RJgMogcYXdxhpNo9Q5a2jBkPhTaFBnwXJ4IRKbsd6e0Ck0hBjVUqFWblzj8njc648vEGpW+aU5gC18bkQgV68gWK68HimnuSpRSilp8cH5NjJOpSvfmQnkBoPJrU0M/g7Bg9zmQkCmxbbbeBCWSCSTnvYgVdG5C+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/zoVWmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13E1C4CEF7;
	Wed, 14 Jan 2026 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394140;
	bh=ev6Qij2PVomzOpcTr7azRUZ5e+KCI6UhuAdUkmLUPrc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G/zoVWmdhXzybUdcadiYCJpXQu4J3VXdcfvU837J9hK5D0iJPmrT3zqqQ6wb0i7/j
	 yzq9ITcA9CKpWNe5l/hJusxB5/KqJ9TlicSuwdrk0kMIf7B+sIVO9NJs1Y30FEFAnj
	 Z3w4oAmqc2HM5N98rk76kZUQ2ZcLZItSsBLwuArIMr3HlbaKjsjg8yeP2kXV41zYUl
	 dy1fpIPdSnvGXD+fF9qiY7Y3sK8mCqY3gSrq34uHkJoyu4ikVlyyn1gFuDQpzknAgl
	 Gb+vgUgflhJ41Igm2102XYyuzT0FnM7OK99wXylz936o2teDMyAF/FrdzYW7W/jZhF
	 D4qTB9Lk2Eiow==
Content-Type: multipart/mixed; boundary="===============7073946550903258648=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96af90062adce57ef61ae1fd070a0e45ad2e0f9f5043603f5f671601b6f442a0@mail.kernel.org>
In-Reply-To: <20260114114450.30405-7-adubey@linux.ibm.com>
References: <20260114114450.30405-7-adubey@linux.ibm.com>
Subject: Re: [PATCH v2 6/6] powerpc64/bpf: Additional NVR handling for bpf_throw
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 12:35:39 +0000 (UTC)

--===============7073946550903258648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index a6083dd9786c..941e0818c9ec 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> @@ -103,9 +119,12 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
>  *		[	  ...       	] 		|
>  * sp (r1) --->	[    stack pointer	] --------------
>  *		[    tail_call_info	] 8
> - *		[   nv gpr save area	] 6*8
> + *		[   nv gpr save area	] 6*8 + (12*8)
>  *		[    local_tmp_var	] 24
>  *		[   unused red zone	] 224
> + *
> + * Additional (12*8) in 'nv gpr save area' only in case of
> + * exception boundary.
>  */
>  static int bpf_jit_stack_local(struct codegen_context *ctx)
>  {
> @@ -114,7 +133,11 @@ static int bpf_jit_stack_local(struct codegen_context *ctx)
>  		return STACK_FRAME_MIN_SIZE + ctx->stack_size;

Does this need to account for BPF_PPC_EXC_STACK_SAVE when
exception_boundary or exception_cb is true?

In the else branch below, the exception case is handled, but the
bpf_has_stack_frame() case returns the same value regardless of
exception_boundary. However, bpf_jit_build_prologue() creates a larger
frame using BPF_PPC_EXC_STACKFRAME when exception_boundary is true.

This inconsistency appears to cause bpf_jit_stack_tailcallinfo_offset()
to return an incorrect offset when both bpf_has_stack_frame() returns
true AND exception_boundary is true. The offset would be off by 96 bytes
(BPF_PPC_EXC_STACK_SAVE).

For example, if a program uses bpf_throw (setting exception_boundary=true)
and also calls helper functions (setting SEEN_FUNC, making
bpf_has_stack_frame() return true), and uses tail calls, the tail call
handling in bpf_jit_emit_tail_call() would access the wrong stack location.

>  	} else {
>  		/* Stack layout 2 */
> -		return -(BPF_PPC_TAILCALL + BPF_PPC_STACK_SAVE + BPF_PPC_STACK_LOCALS);
> +		return -(BPF_PPC_TAILCALL
> +			+ BPF_PPC_STACK_SAVE
> +			+ (ctx->exception_boundary || ctx->exception_cb ?
> +							BPF_PPC_EXC_STACK_SAVE:0)
> +			+ BPF_PPC_STACK_LOCALS);
>  	}
>  }

[ ... ]

> @@ -189,7 +222,20 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>  			EMIT(PPC_RAW_STD(_R0, _R1, PPC_LR_STKOFF));
>  		}
>
> -		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_STACKFRAME + ctx->stack_size)));
> +		int stack_expand = ctx->exception_boundary || ctx->exception_cb ?
> +					BPF_PPC_EXC_STACKFRAME : BPF_PPC_STACKFRAME;
> +		EMIT(PPC_RAW_STDU(_R1, _R1, -(stack_expand + ctx->stack_size)));

The stack frame expansion here uses BPF_PPC_EXC_STACKFRAME for exception
cases, but bpf_jit_stack_local() in the bpf_has_stack_frame() branch does
not account for this larger frame size.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20993216190

--===============7073946550903258648==--

