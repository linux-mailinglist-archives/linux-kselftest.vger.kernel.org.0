Return-Path: <linux-kselftest+bounces-5486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DC869BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27701C22978
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ECF14830E;
	Tue, 27 Feb 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnLbJFsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA91482F5;
	Tue, 27 Feb 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050706; cv=none; b=DfmlKcOsjgtYNOtC2uDGaSvYeQD15AydW7N+gV31yU/oL3OnvP/ITxtUH501M+Lpe/zARUqMpgLwp2v4QUDw1nOaQpF1m/qQ8fmSt2qGxo8VhmCbRYgWJrLmAEBQlDJ8Ti4pKfS4WrcO/2SFFgzPyFm6fNuCb0m4dMVA6AhQSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050706; c=relaxed/simple;
	bh=S3QekCPGG3TBM+vOEI8NezVuo8KDNDTXQNBL2mYsxQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVlVfBYvr2QNWJLp4KDY0/VnmQ2oBSRfrLP0Kg2xmlQDM/n86TUJo995xvJTf55oNLz6cI+iYLivtY/wTqZMHfi3iZr55p9QMSqGmtyPbLrCV9DyIgWIYjuolZ0b978RKHqvn57n0LbgBGKy3o2uM0Xcrlm9M1i021byXu2VIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnLbJFsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F03C433C7;
	Tue, 27 Feb 2024 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050706;
	bh=S3QekCPGG3TBM+vOEI8NezVuo8KDNDTXQNBL2mYsxQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnLbJFsREb6KPExRQSL+P4hCQKpjoKhmFKNpqGZA9HBj8Wc9uWWHr6bBpF6CERK1q
	 W/6afuHi18HSZ/JKNaEYicNaQDMjMA+H8Aos7xrYY7EVjpwCh4wvT8jCjqTKii+yDg
	 i0/uGS5YMnSrGqVpPBF7T7U4sNmzB7eSRt5s1MVBDPzMhW65lwAPeTvk/MiHFcuPhP
	 prH8iPPTuQ6UrcrcbrJQI3FFGowe3SMLWDpe4pzFd61XM5VrL5MM1qOuuG/Uqxw+Xb
	 1L732slS1bPopC5DOnnbfooGjkdAdlFdCABORCJKPB2qQCAoZraSrYLPj0/yw/yIou
	 mddSw63BaXFdw==
Date: Tue, 27 Feb 2024 17:18:19 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for
 is_bpf_timer_set_sleepable_cb_kfunc
Message-ID: <pocfd5n6lxriqg7r6usyhrlprgslclxs44jqoq63lw734fjl2g@5kv4hjaux2fp>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org>
 <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>

On Feb 23 2024, Eduard Zingerman wrote:
> On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:
> > This is still a WIP, but I think this can be dropped as we never
> > get to this instruction. So what should we do here?
> 
> As Alexei replied in a separate sub-thread you probably want this
> for sleepable timers. Here is full source code block:
> 
>         if (insn->imm == BPF_FUNC_timer_set_callback ||
>             is_bpf_timer_set_sleepable_cb_kfunc(insn->imm)) {
>             ...
>             struct bpf_insn ld_addrs[2] = {
>                 BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
>             };
> 
>             insn_buf[0] = ld_addrs[0];
>             insn_buf[1] = ld_addrs[1];
>             insn_buf[2] = *insn;
>             cnt = 3;
> 
>             new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>             ...
>         }
> 
> Effectively, it sets up third function call parameter (R3)
> for timer_set_callback() to be prog->aux.
> E.g. before bpf_patch_insn_data():
> 
>    r1 = ... timer ...
>    r2 = ... callback address ...
>    call timer_set_callback
> 
> After bpf_patch_insn_data():
> 
>    r1 = ... timer ...
>    r2 = ... callback address ...
>    r3 = prog->aux ll
>    call timer_set_callback
> 
> This way it won't be necessary to walk stack in search for ctx.aux
> in bpf_timer_set_sleepable_cb().

Hmm, I must still be missing a piece of the puzzle:
if I declare bpf_timer_set_sleepable_cb() to take a third "aux"
argument, given that it is declared as kfunc, I also must declare it in
my bpf program, or I get the following:

# libbpf: extern (func ksym) 'bpf_timer_set_sleepable_cb': func_proto [264] incompatible with vmlinux [18151]

And if I declare it, then I don't know what to pass, given that this is
purely added by the verifier:

43: (85) call bpf_timer_set_sleepable_cb#18152
arg#2 pointer type STRUCT bpf_prog_aux must point to scalar, or struct with scalar

Maybe I should teach the verifier that this kfunc only takes 2
arguments, and the third one is virtual, but that also means that when
the kfunc definitions are to be included in vmlinux.h, they would also
have this special case.

(I just tried with a blank u64 instead of the struct bpf_prog_aux*, but
it crashes with KASAN complaining).

Cheers,
Benjamin

