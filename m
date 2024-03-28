Return-Path: <linux-kselftest+bounces-6781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54258890E60
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E76290C7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4947E772;
	Thu, 28 Mar 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZORLLVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F73BBF1;
	Thu, 28 Mar 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667854; cv=none; b=GXxLly7f42ZVPohQUJrkguieuROh8N+zEdKyQb56kiNhdvp8POAgArD5exAMwV6QkDULSaoYxipMDgWgU2Nfv9RheM7nQsRuoabVtkzsLZaXnBaP2tcxYAd1BngnxixHwJa6NJy47kYInW+nAh24wzgqv0dASW7JVqpd2kSebPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667854; c=relaxed/simple;
	bh=lxs2ZFR/bExqKNMSEhSfupLSlYECG6xtGJZ2Htju2B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIHMp4GUzrUUQ3yTRz/G/FMagjavFSfHSAJrrYmzV7/hTROS/LtudG66Fm/dZ0199SEms9GgsmwvQmVjkXoORw/rIdTZ5VB+sOE40K7GzykLs5AOmru4r53RlmfsmiWuCM6ZiAef1Gh6t7E7diOrBeLx+KgrekEJNREJAwu0wQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZORLLVM; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d717603aa5so586161fa.0;
        Thu, 28 Mar 2024 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711667851; x=1712272651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBPtswbRJVFEjRlZATnnC5PXpnMT+l8bd9tpx27HnBM=;
        b=FZORLLVM4zTQrqx2Nmbsi0cxFMKlY+f0aT4H8rCdE6yZSJYjqMDcdjuqe/TEn+Wo7F
         ghBvacZZoOJOcpwzMcXvG0TG3S/0fOKIdwHFmFRxu2LYqVYBt+rMN7bjgyQnaJBxPkf9
         h+liqXbkE9MUNcLcxMa0vOhpY7I582D/xgj+HRQALIYoSnC6YUy45xGAbxV5SB/1JeCy
         6BMhl4d9G3np8DiZMRhYLdJ2NDZd9berzJVlhWriMAj/RaXWcZ2fqquz1dnEdRGvTgGw
         cT79hNvmyuCk+jFeZoKG0m2pdrOzjq4LEZYArlYYR9pzXxo4ZxayLmm+RDHtfH7PcfSu
         u3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667851; x=1712272651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBPtswbRJVFEjRlZATnnC5PXpnMT+l8bd9tpx27HnBM=;
        b=xBC3yMEy+HMKWfXGDitVEIWuIyFzdFfJiXpOKiUUO55CbpduuFFsIX6Q1nmtUIiqAa
         yrh0Z7vpFFSJbot1mO0B24HeDaMMxLSdUgOElK38mwLLx/JvhSShIKrH6zcCEwgzCFz0
         EjIVA8mk/ITVub1JKA1wPoflbfpkYtdZWUqpIr3wxmVRMmDBw3VASGu2r5MDfvStJP/3
         EiZ/w40Vwv7pAb7wrcVkSCcYva05Fy1SZ7lAuezqiZdBD03BB0kiagmOIiTcri9SUOCx
         FEgcPpaDRxaW6WU9myeJA6xhY8P4eBl++2bSBMep53snjpUDpxqH0Wn3m4khbZkdzx1Z
         dIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrEhk9ZCNz2T3dkDxm800rRE2SbENK0BG54VELoFgUmeu90XQvXJYAaBWTJb0R/vKfbyGH1N+YU+X4V6FmXQZhvezuJm96cn+XHgqFU/L7f+19eWedq3rADJ3G6q2Y4iTpjdYR3e1CuDm7MUcY7d+Hu1xZxHYiBEshJBjQU/NIS33K7Hx5f3u+u2mk5hjYCHQjjZvuyu3Q0gNUpiOA+w36R7dhy7k4zS9tUlEmDs6kXHb9HgvmU72zuHkzrunOk3HnMrroQzgUNW1kPcmiBr06JnzXwNwo7keA5A==
X-Gm-Message-State: AOJu0YzLkPKp0+yi/a53yiskBjpLMm/atVgfDkEzvBTNZVeSz9RK3D39
	0c6gtF6WEEu20HS2BbEKxaMfXuNlIJXO6MBhMDxIvA0xoCXpUQq3YmQb+BLMhmo6KjNFzPleVX6
	jUb/86upMXvx4sSYsD90CpFmTiPs=
X-Google-Smtp-Source: AGHT+IG5xIH2Dr8kwrbaPKFwGkwQN2RxPioeS2J7HN42D01hRwbUDEoBKIDHKJKBLqNdT3QFt8lsl8OnqZLOHWZb5Wo=
X-Received: by 2002:a05:651c:1692:b0:2d6:c7b5:989c with SMTP id
 bd18-20020a05651c169200b002d6c7b5989cmr378385ljb.28.1711667850565; Thu, 28
 Mar 2024 16:17:30 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Mar 2024 16:17:19 -0700
Message-ID: <CAADnVQKsuV2OhT4rc+k=WDmVMQxbjDiC4+zNbre2Kpj1hod5xw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
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

Absolutely agree.
There is no point re-inventing this logic.

Menlong,
before you hook up into ftrace check whether
it's going to be any different from kprobe-multi,
since it's the same ftrace underneath.
I suspect it will look exactly the same.
So it sounds like multi-fentry idea will be shelved once again.

