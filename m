Return-Path: <linux-kselftest+bounces-6911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF48928FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1153282ECB
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404434C90;
	Sat, 30 Mar 2024 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NJ9zwf18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE554685
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Mar 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711768630; cv=none; b=jYFykMEtKjw37tiQcw5PqGN1C/nIpV47Y1pI7zMdCh+88hNdecef9fjr1+P8Lwq1YQ8CoFd1aj4OzuWS48mL/uBJfnNj994LDmgTqcaOp8yVJIqOr/h+H9FRSWNyxjzSPu5gbcWx+5O8IRFltWKLTQpgNzqtV885qIIOWciSvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711768630; c=relaxed/simple;
	bh=VmRd6vdqQ/4kj1fNz8tXb6dpWXuQ22GvcuAxWJLw2Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHG/uNMYN22N49LJOpnILpP9AZYT+nDtYOLrVOinEHxgzgfksVP6g/YjGK3xSQYsTc8e1pLZERNuXzwGwitYhyzcXT7oQHfi5NMxr6H+W6Q+8vsTFMrtdLKK5YxL+FoOM2J+HcP1bYUOMLCBPAnE042wUnWzf58f8jd9zchvXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NJ9zwf18; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so2306800b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711768628; x=1712373428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+7nrVQkSe14hYl8Q/RTZav7B+/IIz7y9mWl0h4nHVI=;
        b=NJ9zwf18p7aCeardjmlLPL/ya6ehQ2UR0n73FuJd3VldOc2h/iS/gdTC5rr76kLorV
         jk9frrEBYFm+FAVyBilKWExgAlTri5cWDU5cvVrSZFW04n8jqm3ZSTfqYRy7AAkwFstX
         EiIM0t4XC5dFOJ3IHBB3cq+jezLRmcfFGnX0q0dPRsVG1r8zIg/v01mQv2JjQlO/XTMi
         2ry0wzMjopaa9ovGqDnrz87SfuzD1l6GTbNOF4u9mvBxDWR7RLIAGf3CpORGegtRDtvl
         tfxveM1hHblM4xnRgn1yH4NgaHzqA8tHGZNnmAWGxlGju2kll9wGHsHh8k6eqhiVgjQp
         pGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711768628; x=1712373428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+7nrVQkSe14hYl8Q/RTZav7B+/IIz7y9mWl0h4nHVI=;
        b=AR2dYdKOuBCc4CuPdeQ95LLagR9Ip8qhtLW40iMz5/RpOsssc5FlR/XHYCq0jm8T8i
         igpBegy1FFwW7lELCQqZElYjfc+2sASkG5m94MmqGSJJNtEnBAF0ZGpW3dgxaI4yAQQf
         nXw0MWwOXvkdXlJReG+Pqp7wkEb/qWrg1U9qHS0SFWxPa5WdTAbNBsKrgYyDRGxTUHZy
         C5QThdpwXEvnwCdHIvMFsCuSlsrl0M153M4vqqE5LG74+x4vNNgVyYXTSoEJw9cIaYL4
         H9A/V6YvVnKMZ8tvOPvSVvNelkxHAzDdNxysNC91GLQ17qHFQ6TqLuarObaMJyrupOjA
         xgFA==
X-Forwarded-Encrypted: i=1; AJvYcCXrkFiYm9FO0U70aGe8QTwwiA2gz6dUb6ZJ12YB3uPWKb/FTWwznmoeUvF6tZMGd9KoK9zsPEsUz9hnwT/3chbCEU8B7wR0938JuUDcEbWC
X-Gm-Message-State: AOJu0YzplJdEEL+fLESS4GGsYRvPEuzP0M4CKsCYipYzh41NTCAamF8b
	lr75Zby6MzJ4sZI7wnBQyshrUSy4O1I+L86B3H+OwaSb3pqlv96a6NcedUxvPYWDH82Bj3eGwNB
	p2Ig1oZPBBQewFy9SpS//vDZteUlHUvv6SYhS5g==
X-Google-Smtp-Source: AGHT+IGVN8mj6fsGuWs3zLqNPpTPCwZ1MIebWhJAEg3QqqK8w6bYcTZi6CuQt3e1msFgcsuQUeuxtwR9869SV0mzVgs=
X-Received: by 2002:a05:6a21:189:b0:1a3:dc33:2e47 with SMTP id
 le9-20020a056a21018900b001a3dc332e47mr3993857pzb.4.1711768627780; Fri, 29 Mar
 2024 20:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com> <20240328111330.194dcbe5@gandalf.local.home>
In-Reply-To: <20240328111330.194dcbe5@gandalf.local.home>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Sat, 30 Mar 2024 11:18:29 +0800
Message-ID: <CALz3k9idLX10+Gh18xWepwtgvp4VZ3zQfY4aoNXn0gCh8Fs_fA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:11=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 28 Mar 2024 22:43:46 +0800
> =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
>
> > I have done a simple benchmark on creating 1000
> > trampolines. It is slow, quite slow, which consume up to
> > 60s. We can't do it this way.
> >
> > Now, I have a bad idea. How about we introduce
> > a "dynamic trampoline"? The basic logic of it can be:
> >
> > """
> > save regs
> > bpfs =3D trampoline_lookup_ip(ip)
> > fentry =3D bpfs->fentries
> > while fentry:
> >   fentry(ctx)
> >   fentry =3D fentry->next
> >
> > call origin
> > save return value
> >
> > fexit =3D bpfs->fexits
> > while fexit:
> >   fexit(ctx)
> >   fexit =3D fexit->next
> >
> > xxxxxx
> > """
> >
> > And we lookup the "bpfs" by the function ip in a hash map
> > in trampoline_lookup_ip. The type of "bpfs" is:
> >
> > struct bpf_array {
> >   struct bpf_prog *fentries;
> >  struct bpf_prog *fexits;
> >   struct bpf_prog *modify_returns;
> > }
> >
> > When we need to attach the bpf progA to function A/B/C,
> > we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
> > and add the progA to them, and insert them to the hash map
> > "direct_call_bpfs", and attach the "dynamic trampoline" to
> > A/B/C. If bpf_arrayA exist, just add progA to the tail of
> > bpf_arrayA->fentries. When we need to attach progB to
> > B/C, just add progB to bpf_arrayB->fentries and
> > bpf_arrayB->fentries.
> >
> > Compared to the trampoline, extra overhead is introduced
> > by the hash lookuping.
> >
> > I have not begun to code yet, and I am not sure the overhead is
> > acceptable. Considering that we also need to do hash lookup
> > by the function in kprobe_multi, maybe the overhead is
> > acceptable?
>
> Sounds like you are just recreating the function management that ftrace
> has. It also can add thousands of trampolines very quickly, because it do=
es
> it in batches. It takes special synchronization steps to attach to fentry=
.
> ftrace (and I believe multi-kprobes) updates all the attachments for each
> step, so the synchronization needed is only done once.
>

Yes, it is fast to register a trampoline for a kernel function
in the managed ftrace in
register_fentry->register_ftrace_direct->ftrace_add_rec_direct.
And it will add the trampoline to the hash table "direct_functions".

And the trampoline will be called in the following
step (I'm not sure if I understand it correctly):

ftrace_regs_caller
|
__ftrace_ops_list_func -> call_direct_funcs -> save trampoline to
pt_regs->origin_ax
|
call pt_regs->origin_ax if not NULL

The logic above means that we can only call a
trampoline once, and a kernel function can only have
one trampoline.

The original idea of mine is to register all the shared
trampoline to the managed ftrace. For example, if we have
the shared trampoline1 for function A/B/C, and shared
trampoline2 for function B/C/D, then I register trampoline1
and trampoline2 for function B/C. However, it can't work,
as we can't call 2 trampolines for a function.

Then, I thought that we could create a "dynamic trampoline".
The logic for the non-ftrace-managed case is simple, we
only need to replace the "nop" of all the target functions
to "call dynamic_trampoline". And for the ftrace-managed
case, the logic is the same too, except that the trampoline
that we add to the "direct_functions" hash is the
dynamic-trampoline:

ftrace_regs_caller
|
__ftrace_ops_list_func -> call_direct_funcs -> save dynamic-trampoline
to pt_regs->origin_ax
|
call pt_regs->origin_ax(dynamic-trampoline) if not NULL

And in the dynamic-trampoline, we can call prog1 for
A, call prog1 and prog2 for B/C, call prog2 for D.

And the register is fast enough.

> If you really want to have thousands of functions, why not just register =
it
> with ftrace itself. It will give you the arguments via the ftrace_regs
> structure. Can't you just register a program as the callback?
>

Ennn...I don't understand. The main purpose for
me to use TRACING is:

1. we can directly access the memory, which is more
   efficient.
2. we can obtain the function args in FEXIT, which
    kretprobe can't do it. And this is the main reason.

Thanks!
Menglong Dong

> It will probably make your accounting much easier, and just let ftrace
> handle the fentry logic. That's what it was made to do.
>
> -- Steve

