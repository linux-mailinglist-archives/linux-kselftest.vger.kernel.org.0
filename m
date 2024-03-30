Return-Path: <linux-kselftest+bounces-6912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A43892905
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 04:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515CEB2124A
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 03:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A629A1;
	Sat, 30 Mar 2024 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KuELMr/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEB6FA8
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Mar 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711769718; cv=none; b=W1axPyHgfl5WiC4TsPvFNIPMOGaw+eYK+/BBijDHPsv1OGFnf1cIVal2Yni5vpO0ESEvBKWsbGjhwSuEsXuG1e4aUs0DW+npO3ker7CLixUpynFwE4S4McHvinzmwDyk35+7AwkNre9NryHqGINqtI4kLbDZHMPQGOb8H1PC87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711769718; c=relaxed/simple;
	bh=VpC0J23Jn0yxmT2wv6lawJLz4zGJD1QUQuuuKn67A+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUD2cIvvZEt+1lu8OPyf8CsUNYkh5PAq8FoSMCuT1Y9WJO7xPi2adsi4JMABeTX4dlLeWoHR/PbjxoZim3eKMRwtMDPmMnj8+LN5bmslFn4miQa4f0eGz7o6UoVJd3b76qQIDU36ePYO7dymIiJ0iK3BqTPkkfJM4uVjX2dTU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KuELMr/f; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so1991003a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711769716; x=1712374516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQY9GynfzjdgI1A44B4TVgDxB7Pe9LKkrSIu40Cboqk=;
        b=KuELMr/fHUb3LuvaL1wmjrIgOwqE1VjwZmGWVIb/R4EP3rfDlpG9rREXcuMK40a7Zc
         AGRk8zjmzqoSMSqGWWwRERmKZgpxbGVcxU8j5fZZH3SPYt58Dlz5MdUCRSLk2q8IR+sa
         WzNm6wsAEdtmK3ukV19cG5+97BWl74qB/bct5O60IeFY9Re7csPxBasiMGBmPwLa06U8
         TyuafFyvk0kZfhscsfXB0Kqortrcof2oQnv3Z01KhxyCLqfUnRVIJeB5VrfEA2a4l/Bh
         0tUmbaUO4ddBxnh1VQQhO+7SPXee7HiSfR/s+/iFY79l1dBk3xGeFPzWxPkgl/b1fgjg
         dgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711769716; x=1712374516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQY9GynfzjdgI1A44B4TVgDxB7Pe9LKkrSIu40Cboqk=;
        b=YrSvse1TaoL9dm0506oVSl5piQvx2l/Pz0bMfoSsSXGPS8+THAq1t4la9NaDJESUks
         IYmJ8XnaDJUk3ICezOTQ65LVNd5wOMvbJqlarSJbpF+YWStffIQnoOlAaH6GyWvik/uX
         Xrf5acEUkDIRjGFc5dTCdfCprjl/Nciovt+I0kUbLsyitef20UBngjjqbGAEsOIzkgX5
         Lc3mNI6mMSfJ5tLY80+7yYlevefjF3fzIWRjQRGfGsRqOreMrJBb2INI1e/WOGnkPr7L
         LdihAOHh+4tUmyv4PExGLmOF6s3qWU8COlOkef87wTsxNKi6DVU8gRYfZa8g4esNg6qb
         pThQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Lc8GxTC2UgQln0RLwPxEbjIhqXNV9+LikPAjKRY5xSAZoYhn1CZIDzJ+l77miAaw7qBdLr3CZQ7G1ok2DHiU9B1uEoTo2lnuGWf6QSs9
X-Gm-Message-State: AOJu0YytNVsB3UOq/PscO/4Kg5aapzWsBhYxCVJFBoTb5Lmz86SdWHuh
	gKTLgEiBsUHVNiXkujxy/8nH0aIF99F4Mtv5dRno0pKCxJH8isVJuFmQQHKvDjvArFsHkCc7s+x
	5Mrb7ny3fUFq1KMMdE03mSDy7vxEyCv1eD2MLyA==
X-Google-Smtp-Source: AGHT+IFQotfennixOm6ZOmiuiGgpegIwFVTzo5108kmA5lzvm5WNhtg5jy9iBOk0AMJbaUTPpapkU4prCLDmk6G3k3I=
X-Received: by 2002:a17:90a:474f:b0:29d:fe1c:79e7 with SMTP id
 y15-20020a17090a474f00b0029dfe1c79e7mr3306403pjg.45.1711769716617; Fri, 29
 Mar 2024 20:35:16 -0700 (PDT)
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
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home> <CAADnVQKsuV2OhT4rc+k=WDmVMQxbjDiC4+zNbre2Kpj1hod5xw@mail.gmail.com>
In-Reply-To: <CAADnVQKsuV2OhT4rc+k=WDmVMQxbjDiC4+zNbre2Kpj1hod5xw@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Sat, 30 Mar 2024 11:36:38 +0800
Message-ID: <CALz3k9j3aMpnuy3-6dPB9UiQ82LEE-bPapwJfotxX8DyAOc=iw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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

On Fri, Mar 29, 2024 at 7:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 28, 2024 at 8:10=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Thu, 28 Mar 2024 22:43:46 +0800
> > =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
> >
> > > I have done a simple benchmark on creating 1000
> > > trampolines. It is slow, quite slow, which consume up to
> > > 60s. We can't do it this way.
> > >
> > > Now, I have a bad idea. How about we introduce
> > > a "dynamic trampoline"? The basic logic of it can be:
> > >
> > > """
> > > save regs
> > > bpfs =3D trampoline_lookup_ip(ip)
> > > fentry =3D bpfs->fentries
> > > while fentry:
> > >   fentry(ctx)
> > >   fentry =3D fentry->next
> > >
> > > call origin
> > > save return value
> > >
> > > fexit =3D bpfs->fexits
> > > while fexit:
> > >   fexit(ctx)
> > >   fexit =3D fexit->next
> > >
> > > xxxxxx
> > > """
> > >
> > > And we lookup the "bpfs" by the function ip in a hash map
> > > in trampoline_lookup_ip. The type of "bpfs" is:
> > >
> > > struct bpf_array {
> > >   struct bpf_prog *fentries;
> > >  struct bpf_prog *fexits;
> > >   struct bpf_prog *modify_returns;
> > > }
> > >
> > > When we need to attach the bpf progA to function A/B/C,
> > > we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
> > > and add the progA to them, and insert them to the hash map
> > > "direct_call_bpfs", and attach the "dynamic trampoline" to
> > > A/B/C. If bpf_arrayA exist, just add progA to the tail of
> > > bpf_arrayA->fentries. When we need to attach progB to
> > > B/C, just add progB to bpf_arrayB->fentries and
> > > bpf_arrayB->fentries.
> > >
> > > Compared to the trampoline, extra overhead is introduced
> > > by the hash lookuping.
> > >
> > > I have not begun to code yet, and I am not sure the overhead is
> > > acceptable. Considering that we also need to do hash lookup
> > > by the function in kprobe_multi, maybe the overhead is
> > > acceptable?
> >
> > Sounds like you are just recreating the function management that ftrace
> > has. It also can add thousands of trampolines very quickly, because it =
does
> > it in batches. It takes special synchronization steps to attach to fent=
ry.
> > ftrace (and I believe multi-kprobes) updates all the attachments for ea=
ch
> > step, so the synchronization needed is only done once.
> >
> > If you really want to have thousands of functions, why not just registe=
r it
> > with ftrace itself. It will give you the arguments via the ftrace_regs
> > structure. Can't you just register a program as the callback?
> >
> > It will probably make your accounting much easier, and just let ftrace
> > handle the fentry logic. That's what it was made to do.
>
> Absolutely agree.
> There is no point re-inventing this logic.
>
> Menlong,
> before you hook up into ftrace check whether
> it's going to be any different from kprobe-multi,
> since it's the same ftrace underneath.
> I suspect it will look exactly the same.

Yeah, I dig it a little. I think it is different. For multi-kprobe,
it registers a ftrace_ops to ftrace_ops_list for every bpf
program. This means that we can register 2 or more
multi-kprobe in the same function. The bpf is called in
the following step:

ftrace_regs_caller
|
__ftrace_ops_list_func -> fprobe_handler -> kprobe_multi_link_handler -> ru=
n BPF

And for trampoline, it needs to be called directly,
so it can't be registered as a callback to ftrace_ops_list.
It need to be called in the following step:

ftrace_regs_caller
|
__ftrace_ops_list_func -> call_direct_funcs -> save trampoline to
pt_regs->origin_ax
|
call pt_regs->origin_ax if not NULL

> So it sounds like multi-fentry idea will be shelved once again.

Enn...this is the best solution that I can think of. If it
doesn't work, I suspect it will be shelved again.

Thanks!
Menglong Dong

