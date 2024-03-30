Return-Path: <linux-kselftest+bounces-6913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69934892934
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 05:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85312B22288
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 04:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E1AD27;
	Sat, 30 Mar 2024 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lotuHB3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98279C3
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Mar 2024 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772137; cv=none; b=Jh+cPj+eyyNv6FAfH4K/vYmjkmfB4C2H8THUo0DqjN1FnqjvdYppbxjR+q2t3XHBuVYAWphmXMEjoE8BhiG8J1STZGDkZxSkeLPlBzjkPeqtu2Zgaoeysn1WN5Tcmgm0Vb9KJQg9SrCTEpVzioRDQQUujaLdNTyOozh9uTdGeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772137; c=relaxed/simple;
	bh=qgobxYsoW4+2TT3KspAAgbFZjvWwlDQJ1EahoxZ6SUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekMHrMAR2x/oVMtGV/zTMtk+3rkihZNIOhVGKhsgpBc0CYCZ47tVMlG98ByD9aXVMQt2MNsAZlb/Dxk0Q4+cj5fY/XqdMt6vKp6/8U325i9V1aOTEgRbjUFyLYP5QaxLdy+pk/lpNM1ls7/3nwpGP0D4XeAE6xZLuo4pCcoo8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lotuHB3Y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1950174a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 21:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711772130; x=1712376930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofE4DiMnvHuiRZX1XlrIQJQuThx3U4684j2Vrwr4bOc=;
        b=lotuHB3YqxI5vNiMNQShMPcZpMVUJ465SPLPfA2ZffKWYhtiIpcCAVyZSTq4l0PlVm
         cPPfJ5K6RIbzdDn0T2br/TIueszyxszgWUTJ380vTjs5mQUui38KoyOVDnG1aNFg3ojX
         qT7UlrcsXggaNQXe9AuPEuT0Sb7F0MLi7Nw6l+TH1U0d7yiQ+7KnPDVXHegP8jKCK6Em
         Uow1+d0qBdtY/BbdJh5NtxxGHAY5F7ea4QmX/AcK49wR4lbjbtMz9p1a1106CIP7G/p2
         F5jxnpW89ievSd3eMy5KK8/Cy/eyEh2UtRV9jEB1VoadAT58X+0FxQfYCzwBApOxWs6q
         CZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711772130; x=1712376930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofE4DiMnvHuiRZX1XlrIQJQuThx3U4684j2Vrwr4bOc=;
        b=YXofFTg2bxJY3MKhyTPpRRXl6EgBBo1Ithmn8BPs8o48/fz8YrZnNRUIDCGk7AxGDD
         c37RBZTrfYuBvFo19WoAUczMyvxx5VMwnFQHIuGwZxc24RA5S4NYiLCL7Q0Be0uuFu7h
         kpbcaKiOfOhLauwTsneAxfXwvQOFnzaBTuQeDnm/npAa+W6fuoV5X+DFYrjOD+WWnmpE
         HanyM58UPU5qFdr7O1qUAHIfn/gDIFolM6wtufl1gSsEk9GAU7WKLMy47J1ZoKGy4giS
         0YSYi/Z07175ygBK2K5uyo0Ki/HGYPm4dKSR5bjDHcnnDLpxHmEY4K/qktjuJCzbBb0z
         qwkg==
X-Forwarded-Encrypted: i=1; AJvYcCUFmBH87NWNAGqt/OyoS5JBAGfQ2aKVpqlJc2t0KUjnqKrTRLqQj1pjhUHml0Akq4nl7osa4VAbAfKr84JDPtbFPtfS3NCsC5BxZeqQV4JE
X-Gm-Message-State: AOJu0YzU82S8Vi+/GIp7g13MVbPYu0o4TJlJe5QXEyhmPEHBX8uuaIpD
	52kw8ga9ghZyAMTaRlORYNCTPDDSmHn6aX8IR47TmsuOQEV3GQOmHZjw2KDx58xjuepVBJQTQK0
	niSXoz435qGh4Bbn7C5dg02qYcML+J9Ozlw5PkA==
X-Google-Smtp-Source: AGHT+IGgndwZ3xqfDhf4CyJqUlqHUpBRYWacoRvVkoWzKCTwU3GtudllRjOr+s4vd+S8mdhVeoofK0l9Hh+AwBW0mGw=
X-Received: by 2002:a05:6a20:17a2:b0:1a3:67fd:46b1 with SMTP id
 bl34-20020a056a2017a200b001a367fd46b1mr3653617pzb.36.1711772130610; Fri, 29
 Mar 2024 21:15:30 -0700 (PDT)
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
 <20240328111330.194dcbe5@gandalf.local.home> <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
In-Reply-To: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Sat, 30 Mar 2024 12:16:52 +0800
Message-ID: <CALz3k9hm6U90K8+d7SprXiKvscRjFno83idqYneHEVwgs4pCiw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Sat, Mar 30, 2024 at 7:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
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
> >
>
> I thought I'll just ask instead of digging through code, sorry for
> being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
> before function execution to a return probe (fexit/kretprobe)? I.e.,
> how hard is it to pass input function arguments to a kretprobe? That's
> the biggest advantage of fexit over kretprobe, and if we can make
> these original pt_regs/ftrace_regs available to kretprobe, then
> multi-kretprobe will effectively be this multi-fexit.

Yes, we can use multi-kretprobe instead of multi-fexit
if we can obtain the function args in kretprobe.

I think it's hard. The reason that we can obtain the
function args is that we have a trampoline, and it
call the origin function for FEXIT. If we do the same
for multi-kretprobe, we need to modify ftrace_regs_caller
to:

ftrace_regs_caller
|
__ftrace_ops_list_func
|
call all multi-kprobe callbacks
|
call orgin
|
call all multi-kretprobe callbacks
|
call bpf trampoline(for TRACING)

However, this logic conflicts with bpf trampoline,
as it can also call the origin function. What's more,
the FENTRY should be called before the "call origin"
above.

I'm sure if I understand correctly, as I have not
figured out how multi-kretprobe works in fprobe.

Thanks!
Menglong Dong

>
> > -- Steve

