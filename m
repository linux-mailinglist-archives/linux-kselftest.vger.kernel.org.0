Return-Path: <linux-kselftest+bounces-6910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB88927CA
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 00:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF381F225EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17F13DDAC;
	Fri, 29 Mar 2024 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm8qb98v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE5347B6;
	Fri, 29 Mar 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754928; cv=none; b=BiF0sOPYXhrbjY9cOS6Nmj4VXF++Yx8MtZjBDxanMefli+BulHO4QXKn7qwpW3i+7uN65u5cLGhThPJZ2akcLjIgY9UcOJfH9j6D484gs+N5O8HXdnQzg8eZ93GRBeBoDesuvP5WyVY1RlteRQZLbYRhS27z9mKgIzxIt2bJ+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754928; c=relaxed/simple;
	bh=M+CkTC/9QOPKjcAq26pJFK75aD0g4y2+LXJsB0P1JY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lu4xUrtWjk3J0kbVbPD5XAlV9JEyhRuyqvveB8mIxkffhtOM1Y7m4+o5XzftYMKn592GD5CBw41tS2CCKYzMtaJurKzqjxkWsFCCe3ELmR9AEyVvEBDa4PpVwvE2aS0et1z2P9rOIk0ldc7OMYPnDpWEu3jfzLxb8Y4CGi6sJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm8qb98v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1860607a12.3;
        Fri, 29 Mar 2024 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711754926; x=1712359726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=;
        b=Fm8qb98vO+2rZQDr4ACVbzWOOBhMbNP973of56VDx+7dzKarS23b4VDs0QCZjE/zey
         IJ/g2gwkTlDZp557gqFy6HVirUKvvI/RhzQOrPjsYmqnt0OS+LXZWxBGcD9ooJmS1u1N
         Wdq60dFcb/ee3JYL5bUFYzr07cJmwvvmIZoI/b1KQpo+K6ftMzexzXAN8iXh1nJo1QdC
         4CFMaxfeoUIzc6fyg2ScGW/5rPdZFOXPIXIjGrA7V7Ij1KqAkHvKfDNzy1QS7jMz6z0E
         /W8l0QAzZuWpon/+MGFe6iPNG81xSsUfka4lIyvOK31ZY63E/sqixJRnh7RpDV18WsJY
         CtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711754926; x=1712359726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=;
        b=RU6CYGdij3I8SMDFuLcEkXFxxuMDLhpfo6RmyHf+rD3z+RBxrsmoJ1YligUcYT3VoL
         YtUHguMvFF7xT9YjyGrK4ujkEA13NT+X1hwUNhKsWaXhpLBG2Wyh4eNaw4zkHN28eYkq
         dj4reqkSxtXQvjpns3NtubA0ld6+woHqICxMQVR26maDt91aYEPooASIjOoCRnxMnIpI
         KqBMby8F8aarmJfc6c16rp9hDJK1Cr34usuvnIOrnJ2bdp2qTCOMpl6ARzTAtPA9p7n7
         9p9R345kssoRHOmDzo2WcF/0oG4wRjb+owNVpsCTExoqfee0d+FSjcyFxitgRQvMQzcC
         9Pqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlnHyNUDZ0fbOQSV0NEVvOtJTaOmaxwPgZy047hqztaIz7SMsnLeomStI1EizImJzlky/xJNYIS4RJsXEX2rbQoVyo7MFG2+RfwxWnjGonfBHU0k5JSlRGPFtF8Te8neu3qxCi25AWVXDje1k1qkzJLjDnQ+s4R4WJmDmbw/KdNN4l/EBnMx0Wq+GOvmC+DkjFlyebAZoKGfgwdw8BgI1xISF1T+wxXijKToVLbwSSua486L4tXm8nE4lXExEMG+QxE02AxDYDKshvWmyLqPiNewg+cXpbihxLyg==
X-Gm-Message-State: AOJu0YwCezoL4rml44Ulwt5kaSYk47W3cr0evd5PMAYC8La4m9gnILHN
	FRelRR6zMz1Bz2qJo3eFKeNyq28N5Yo0kJIQ72rv0EkZFGKfSnjbac0fnT9zQAwbNl/tFnTmfuG
	Y3REKAMgIbWmVvmHWWGOk0v3R69U=
X-Google-Smtp-Source: AGHT+IFNbTnA2C1UowyvpIWfWMecar3RYOVPJRlOoVy5NMmPOOKB6ZhvqfzCxbpKkf/w3Z3THbX/GA+A1iwjf07EvPY=
X-Received: by 2002:a17:90a:be04:b0:2a2:1415:723d with SMTP id
 a4-20020a17090abe0400b002a21415723dmr3177860pjs.42.1711754926271; Fri, 29 Mar
 2024 16:28:46 -0700 (PDT)
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
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 16:28:33 -0700
Message-ID: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
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

On Thu, Mar 28, 2024 at 8:10=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
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
> If you really want to have thousands of functions, why not just register =
it
> with ftrace itself. It will give you the arguments via the ftrace_regs
> structure. Can't you just register a program as the callback?
>
> It will probably make your accounting much easier, and just let ftrace
> handle the fentry logic. That's what it was made to do.
>

I thought I'll just ask instead of digging through code, sorry for
being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
before function execution to a return probe (fexit/kretprobe)? I.e.,
how hard is it to pass input function arguments to a kretprobe? That's
the biggest advantage of fexit over kretprobe, and if we can make
these original pt_regs/ftrace_regs available to kretprobe, then
multi-kretprobe will effectively be this multi-fexit.

> -- Steve

