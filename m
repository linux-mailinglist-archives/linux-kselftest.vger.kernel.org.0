Return-Path: <linux-kselftest+bounces-48930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6FD1EBF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 13:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF9F307CA5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50A397AC1;
	Wed, 14 Jan 2026 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzW9sO8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B5397AB6;
	Wed, 14 Jan 2026 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393520; cv=none; b=daRb6GP82jC9WiLekHQ5vzDhbBlg/xWtDSjxS+nX9WiDdzlIakOGZoibB7bsyQVGtfGlmsUmFqI5J0kKOBChzyUR2FCsr036aLB/S+u9sl4/hig8rhNOB330XuCJcAop0KPyDA3on6l/v/N5d36/45X3p+q+uHlDBRlUSOgb3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393520; c=relaxed/simple;
	bh=28BXad19nCnp3Ql2evEZsEz6QgTpTejqit7mcwOnXto=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Iw1CUoHrGwBGNw2f5idOh/ah+SNX3XbW16w45JXBdI+VBwvDskmcrv5h2zl58C4CaK+g7720WhPiu6vUs+c2EV46f86fdrsnsx3UsKHMWM9yl075vKtfm/9de9cMRJ0nKPfmXfiUI2ZMVyYAfpEtoO8B+6BorFO4IaIVtQS64NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzW9sO8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC749C4CEF7;
	Wed, 14 Jan 2026 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768393520;
	bh=28BXad19nCnp3Ql2evEZsEz6QgTpTejqit7mcwOnXto=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RzW9sO8/lwBrOZ77Ow2EnrDxEEgjR2TVcUuODk+4bvyBnZp+621TosZfCBu+jP0VH
	 x9ve9MAlCtx7EY5Azgt/Q7C/nNL6fcIxxyPsSJYnYItVcwBZ/m3MpLx+gkIiW27PpZ
	 ryw/0QsCDz3MuCX/iZlPzPNFZjui6hfCE5K9dEWg5bym+bsSFM+PVGmhgfZtnvqCkr
	 R8yPQBAFCHQfaVx6OnZ1+azLsvl6b4m1spahLWbCckvme7mZSxJ6ff2PU2/Xsn+p17
	 HHMghCVsWQRBn2n3RpxY6jjCoSnEGgXB5MRmFg8xDH50GQfdyWaWpKNcN+eRbL0/kf
	 88KkDRIvaea8w==
Content-Type: multipart/mixed; boundary="===============3401074341333993029=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a6a90935a20db665f17f61d645d5aa03d8bbf1cb0763c7738b04a7af77b1729@mail.kernel.org>
In-Reply-To: <20260114114450.30405-4-adubey@linux.ibm.com>
References: <20260114114450.30405-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v2 3/6] powerpc64/bpf: Tailcall handling with trampolines
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 12:25:19 +0000 (UTC)

--===============3401074341333993029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 069a8822c30d..e3088cf089d1 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> +static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
> +					       int func_frame_offset,
> +					       int bpf_dummy_frame_size, int r4_off)
> +{
> +	if (IS_ENABLED(CONFIG_PPC64)) {
> +		/* See bpf_jit_stack_tailcallinfo_offset() */
> +		int tailcallinfo_offset = BPF_PPC_TAILCALL;
> +		/*
> +		 * func_frame_offset =                                   ...(1)
> +		 *     bpf_dummy_frame_size + trampoline_frame_size
> +		 */
> +		EMIT(PPC_RAW_LD(_R4, _R1, func_frame_offset));
> +		EMIT(PPC_RAW_LD(_R3, _R4, -tailcallinfo_offset));
                              ^^^^

Should this LD instruction be an ADDI instead? Looking at the stack frame
setup, after the two STLU instructions in __arch_prepare_bpf_trampoline():

  STLU _R1, _R1, -bpf_dummy_frame_size  ->  stores original _R1 at dummy frame
  STLU _R1, _R1, -bpf_frame_size        ->  stores dummy frame ptr at tramp frame

From the trampoline frame, the back chain stored in the dummy frame at offset
bpf_frame_size points to the caller's frame. But func_frame_offset equals
(bpf_dummy_frame_size + bpf_frame_size), which points into the caller's frame
itself. Loading from that address returns the caller's back chain (pointing
to the grandparent frame), not a pointer to the caller's frame.

This appears to cause the subsequent load at [_R4 - 8] to read the grandparent's
tail_call_info rather than the caller's. Would loading from [_R1 + bpf_frame_size]
give the correct pointer to the caller's frame?

For comparison, the subprogram prologue in bpf_jit_build_prologue() uses
[_R1 + 0] to get the back chain pointing to its caller, which seems like
the right pattern.

> +
> +		/*
> +		 * Setting the tail_call_info in trampoline's frame
> +		 * depending on if previous frame had value or reference.
> +		 */
> +		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
> +		PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
> +		EMIT(PPC_RAW_ADDI(_R3, _R4, bpf_jit_stack_tailcallinfo_offset(ctx)));

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20993216190

--===============3401074341333993029==--

