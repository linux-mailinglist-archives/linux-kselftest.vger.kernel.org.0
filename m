Return-Path: <linux-kselftest+bounces-48929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D496BD1EB91
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 13:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54EEA30049DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C6396B6D;
	Wed, 14 Jan 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTGnJs3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42213806AC;
	Wed, 14 Jan 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393519; cv=none; b=ORLPJr7XMrMa2wfkZWEtO9jmAiwkzuYH3CGcSeRgCfDCOWtBM1UjtsODhGMuxd0T7SPTHt0E1PkZ0gqFFtFtKXLNrB6hW52YjxcyTgtE8t3BnmrSMXZzkttxuKYuP+4OMuuDUyHoTueqCIjNkPCIT/Q7Wx5iRJZY75+DyY8oLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393519; c=relaxed/simple;
	bh=QxoiBpLx6OZiyhYHiapNZwXCTki0kD1H0U4PXDfMYEM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n80kThnG4FVm6TpgkTuFzy06uBppCtZXtYKQRLYlXFneRUEKlonNeu9aQ1HXv9ad5mBoqWeGy7N01LZoDNd0N/leC0S09f+xYvfbyoXnBXHP5JkGg7LOPX9u29OGIH7cdwbLmCKPk8UmaXU9xb4T0li8lGVg6vBCTEHueBSxIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTGnJs3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059F8C4CEF7;
	Wed, 14 Jan 2026 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768393518;
	bh=QxoiBpLx6OZiyhYHiapNZwXCTki0kD1H0U4PXDfMYEM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BTGnJs3tef9v610pM4uVaHIhxTH5VIDn76eDjF4v1eCSUl1IJ6vdvzhhYK9fPQe0k
	 lKyzbtESgNYvVN6hSeEHO6ItdQ8vjnwVvIzbcraevbMJHm5Hhn3VRl5qtSQU5Gu2V/
	 4rchIVofcJQxjty+VX/prLA3Itc4wtmz7Mn8lJ5E0Y5p82qLmimHleev7qkSoAssZx
	 HZcwnmO1ivtFs1fDbES/MstSO5uPDhlRDNRsPhgXS9Ep2zogyUChbFH2S0Q2Q++rRV
	 KnkaOcFrCyqG1Pj7n6Avqdy1wFFdUe1aaK3s0jXdgWfywdYNBEZBrMkCQBPQV0FJry
	 X2wY/sElKZF0w==
Content-Type: multipart/mixed; boundary="===============3352543397498476185=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f1767f79eaba1fc1581a544da924ebcbd3f9ee253a092fa4b6c8415212be04d@mail.kernel.org>
In-Reply-To: <20260114114450.30405-2-adubey@linux.ibm.com>
References: <20260114114450.30405-2-adubey@linux.ibm.com>
Subject: Re: [PATCH v2 1/6] powerpc64/bpf: Move tail_call_cnt to bottom of stack frame
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 12:25:18 +0000 (UTC)

--===============3352543397498476185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 8334cd667bba..45d419c0ee73 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h

[ ... ]

> +/* for tailcall counter */
> +#define BPF_PPC_TAILCALL        8

This new constant defines tail_call_cnt offset as 8 bytes from prev sp.

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 1fe37128c876..39061cd742c1 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> static int bpf_jit_stack_tailcallcnt(struct codegen_context *ctx)
> {
>-	return bpf_jit_stack_local(ctx) + 24;
>+	return bpf_jit_stack_local(ctx) + BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE;
> }

The tail_call_cnt offset changes from +24 to +72 (24 + 48) relative to
bpf_jit_stack_local().

There appears to be an inconsistency with the trampoline code in
bpf_jit_comp.c. The function bpf_trampoline_setup_tail_call_cnt() and
bpf_trampoline_restore_tail_call_cnt() use a hardcoded offset:

    int tailcallcnt_offset = 7 * 8;  /* = 56 */

The comment says "See bpf_jit_stack_tailcallcnt()" but after this patch,
bpf_jit_stack_tailcallcnt() returns an offset that corresponds to 8 bytes
from prev sp (BPF_PPC_TAILCALL), not 56 bytes. When BPF_TRAMP_F_TAIL_CALL_CTX
is set, will the trampoline read/write to the wrong stack location?

Note: This appears to be fixed later in the same series by commit 6889ec3d3e10
("powerpc64/bpf: Tailcall handling with trampolines") which updates the
trampoline code to use BPF_PPC_TAILCALL instead of the hardcoded 7 * 8.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20993216190

--===============3352543397498476185==--

