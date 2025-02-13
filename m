Return-Path: <linux-kselftest+bounces-26565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E8A34B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB41F7A184F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D63145348;
	Thu, 13 Feb 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TrCxnxIh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C728A2A5;
	Thu, 13 Feb 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466243; cv=none; b=GH21qlJkk7+GPyU2Xy2iQG2FHlhG4FiZYBtyRanztKYr2brS4zf+jtgRLCkrtAQbKZlkn7M/wALoA0TThMaBIisAjyKjMxy31mRFwqF/kEdZHdClsp5k4R1qeKejkuukD3CWe6fMFdruFcF2dJbVkLtHiLWgCss7VREGe+Rd3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466243; c=relaxed/simple;
	bh=pwYagKv24qCrVWptNTz9ll8gBbuAPxwglYcScbxO3vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuTf+buVEwZQ180hbe2uCTJNCOF6Ug1pgKRLxSYPGXy7pvxvMABMLSPnpbASYx+P6XVGKgNrxn1puMWqUQw16OJb10TQzwnjopufAqftAsW4LjeYb0alhilX1JO48lKbjQBri9cT5Vnqa95+pSndtaTSAve6cFVm8+DxUGLbGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TrCxnxIh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=cIEJc0/6NZ6IBFRoZ8UFnbtt9VEgUoZ4eneWY8Zk3MI=;
	b=TrCxnxIhKRcKLEF2CYpvbv8DJk1ZZ4hquDisY3hyFqzzSkY4uvwBzuMb+zU57d
	T0V2FDaJV6yakYKM45boapK3oaWlU2XM6B8iBGTT42d1F1P082TUKYO2VVBaUInn
	zQxENpfMQhgwNVMqpvYAxxfS62F+3lF6//Tf6WSCRzfHY=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [8.217.230.114])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3JeuxJa5nWZdJNw--.31319S2;
	Fri, 14 Feb 2025 01:02:43 +0800 (CST)
Date: Fri, 14 Feb 2025 01:02:41 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix array bounds error with may_goto
Message-ID: <2ec2qjrwsdvdyr2wdo3gakv4hsikmvrhc47k3kii7nzj2e5tfm@zeiedp7wy3kj>
References: <20250213131214.164982-1-mrpre@163.com>
 <20250213131214.164982-2-mrpre@163.com>
 <CAADnVQ++goV=Yi=dhXNa5F-h0o7uSNEGiPHh0ArODt3TaEeeQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ++goV=Yi=dhXNa5F-h0o7uSNEGiPHh0ArODt3TaEeeQg@mail.gmail.com>
X-CM-TRANSID:QCgvCgD3JeuxJa5nWZdJNw--.31319S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryftry5WryUuw13WF17KFg_yoW5Xw43pF
	WDKa4UAF4DJw48t3s8CF40vr43JF4xtrn0kr43X348uF4UWFWkC3WUKa9Y934fXrn7Jw1x
	AF4Uurn3CFyay37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNYFZUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwXyp2euIJizyAAAsV

On Thu, Feb 13, 2025 at 08:02:55AM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 5:13 AM Jiayuan Chen <mrpre@163.com> wrote:
> >
> > may_goto uses an additional 8 bytes on the stack, which causes the
> > interpreters[] array to go out of bounds when calculating index by
> > stack_size.
> >
> > 1. If a BPF program is rewritten, re-evaluate the stack size. For non-JIT
> > cases, reject loading directly.
> >
> > 2. For non-JIT cases, calculating interpreters[idx] may still cause
> > out-of-bounds array access, and just warn about it.
> >
> > 3. For jit_requested cases, the execution of bpf_func also needs to be
> > warned. So Move the definition of function __bpf_prog_ret0_warn out of
> > the macro definition CONFIG_BPF_JIT_ALWAYS_ON
> >
[...]
> > ---
> >  EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
> >  EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
> >  };
> > +
> > +#define MAX_INTERPRETERS_CALLBACK (sizeof(interpreters) / sizeof(*interpreters))
> 
> There is ARRAY_SIZE macro.
Thanks, I will use it.
> 
> >  #undef PROG_NAME_LIST
> >  #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
> >  static __maybe_unused
> > @@ -2290,17 +2293,18 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
> >         insn->code = BPF_JMP | BPF_CALL_ARGS;
> >  }
> >  #endif
> > -#else
> > +#endif
> > +
> >  static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> >                                          const struct bpf_insn *insn)
> >  {
> >         /* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
> > -        * is not working properly, so warn about it!
> > +        * is not working properly, or interpreter is being used when
> > +        * prog->jit_requested is not 0, so warn about it!
> >          */
> >         WARN_ON_ONCE(1);
> >         return 0;
> >  }
> > -#endif
> >
> >  bool bpf_prog_map_compatible(struct bpf_map *map,
> >                              const struct bpf_prog *fp)
> > @@ -2380,8 +2384,14 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
> >  {
> >  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> >         u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
> > +       u32 idx = (round_up(stack_depth, 32) / 32) - 1;
> >
> > -       fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
> > +       if (!fp->jit_requested) {
> 
> I don't think above check is necessary.
> Why not just
> if (WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters)))
>   fp->bpf_func = __bpf_prog_ret0_warn;
> else
>   fp->bpf_func = interpreters[idx];
> 

When jit_requested is set 1, the stack_depth can still go above 512,
and we'd end up executing this function, where the index calculation would
overflow, triggering an array out-of-bounds warning from USCAN or WAR().

> > +               WARN_ON_ONCE(idx >= MAX_INTERPRETERS_CALLBACK);
> > +               fp->bpf_func = interpreters[idx];
> > +       } else {
> > +               fp->bpf_func = __bpf_prog_ret0_warn;
> >                         stack_depth_extra = 0;
> > --
> > 2.47.1
> >


