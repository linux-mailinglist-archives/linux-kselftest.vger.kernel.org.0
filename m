Return-Path: <linux-kselftest+bounces-48202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57206CF3391
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 12:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37124301D630
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3F3375C5;
	Mon,  5 Jan 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN3mASKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC9337118;
	Mon,  5 Jan 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611715; cv=none; b=Hc6SmqIEqGy1qX9lo5msHyALq1FCbN0QJpXv0Yww8ia+PtqMuSphxJRSKQyFX7HOCgIJ14TIZALyIWQ41DODFOQXNLPm3DoJz2Wev0kPanux5qEIjk4k/CnQNbQ6dVKfIoDscRucYDbc2p3TXSOkceEmOdnUt85f8l6aQxl5N7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611715; c=relaxed/simple;
	bh=gOPFCv6XsvdNRFL2RgDvRLwWfshb/oHcO2mTVP7fwUc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tYVJ9j3IaAiEhKrTVkZwkwoeheXs68bX59Wko4jtoEgzjNU34oHyiq2oUVI0blK9eHBTJdYFUK9yFhaJENHOyEhKCDQYSsfwkeB005tz1nRQnjr5BiWhmeM8xbyfcGKuHOfsqSV5CjTPqcfb+rh86o3HgQcbGsH3XQrMzu3iUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN3mASKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40353C116D0;
	Mon,  5 Jan 2026 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767611714;
	bh=gOPFCv6XsvdNRFL2RgDvRLwWfshb/oHcO2mTVP7fwUc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IN3mASKs9ZOdY3UWX865ZG6aB6zxt/yT04bcUJ7cuxkRQCHiOoJYOHXltLVYGrWnX
	 sLyyjN/mVfbdelfPtvuCgsuYc3e3xIs8WYSVdBfKfSdGRr7XCEYeoUVwx63W2eeyR1
	 YsnFKsk5+hPaqSv1yzLkJ4S4OTgLG6rS3lu4D8KK2SlOY/0lKgXSRV11vvvL2rVqWI
	 XcY69MIXG2csR5WWdunoLtYAYD6tqtRCAdOsZtO1xZXB2dLHSsAi9C2yiYDvkyXOqc
	 f7mR+nylEUhtKx6jI6FOEwEfDTmGJ57eATPOxskUiFgXDTbQrewzUkLONqDGvjlsYT
	 x269dn3xwSWxg==
Content-Type: multipart/mixed; boundary="===============0721075218538269164=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <655a960bb1b98cf56777481bd84ce53c2a17e527a8230edf9ad7523e98cce565@mail.kernel.org>
In-Reply-To: <20260105105212.136645-3-adubey@linux.ibm.com>
References: <20260105105212.136645-3-adubey@linux.ibm.com>
Subject: Re: [PATCH 2/6] powerpc64/bpf: Tailcall handling with trampolines
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  5 Jan 2026 11:15:14 +0000 (UTC)

--===============0721075218538269164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 069a8822c30d..4aaa0a287a45 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> -static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_context *ctx,
> -					       int func_frame_offset, int r4_off)
> +static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
> +					       int func_frame_offset,
> +					       int bpf_dummy_frame_size, int r4_off)
>  {
>  	if (IS_ENABLED(CONFIG_PPC64)) {
>  		/* See bpf_jit_stack_tailcallinfo_offset() */
> -		int tailcallcnt_offset = 7 * 8;
> +		int tailcallinfo_offset = BPF_PPC_STACK_SAVE + SZL;

[ ... ]

> +		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset
> +				- bpf_dummy_frame_size - tailcallinfo_offset));
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The new setup function stores tail_call_info at offset
(func_frame_offset - bpf_dummy_frame_size - tailcallinfo_offset) from R1.
Since func_frame_offset = bpf_dummy_frame_size + bpf_frame_size, this
resolves to (bpf_frame_size - 56), which is a positive offset from R1.

However, the corresponding bpf_trampoline_restore_tail_call_cnt() function
was not updated. It still reads from (R1 - 56):

    static void bpf_trampoline_restore_tail_call_cnt(...)
    {
        if (IS_ENABLED(CONFIG_PPC64)) {
            int tailcallcnt_offset = 7 * 8;
            EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
                                      ^^^^^^^^^^^^^^^^^^
            ...
        }
    }

Is there an offset mismatch here? The setup function stores at
R1 + (bpf_frame_size - 56) while restore reads from R1 - 56. These point
to different memory locations since bpf_frame_size is a positive value
(at minimum ~200 bytes given the frame contents).

When BPF_TRAMP_F_TAIL_CALL_CTX is set, the restore function would read
incorrect data after the traced function returns, potentially causing
wrong tail call context to be propagated.

> @@ -801,6 +830,12 @@ static int __arch_prepare_bpf_trampoline(...)
>  		}
>  	}
>
> +	/* Room for 64-bit tail_call_cnt */
> +	bpf_frame_size += SZL;
> +
> +	/* Room for nvr save area */
> +	bpf_frame_size += BPF_PPC_STACK_SAVE;
> +
>  	/* Padding to align stack frame, if any */
>  	bpf_frame_size = round_up(bpf_frame_size, SZL * 2);

The frame size is increased by 56 bytes (SZL + BPF_PPC_STACK_SAVE = 8 + 48)
for the tail_call_info and nvr save area. This affects all calculations
using bpf_frame_size, including the store offset in the setup function,
but the restore function continues to use a hardcoded negative offset.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20713322833

--===============0721075218538269164==--

