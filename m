Return-Path: <linux-kselftest+bounces-6761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A98902B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 16:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1939E1C2AA6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE912D76F;
	Thu, 28 Mar 2024 15:10:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2A2C6AD;
	Thu, 28 Mar 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638651; cv=none; b=RTF9NSHXD+5MhH16WmzEsgBTAMHv5ymC3bHdaNYbwEbeBwYZmuhtjESbIG32YEAU/3A9o9B9sRqpH813TbJ1VJlV9ScMQoC5me7S318cwAXy0IDCcrc/rueWivK4dn2euhCnfWdvrVO79K6rnoW+CmrqWHIywX9Mu3knaQYMK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638651; c=relaxed/simple;
	bh=r2D0EqkpCrFqFode/ZlZv88Dg4Xknt6j7iyrIgxbYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrLs/p/darscR+NvP4+RVCZY73NhOQzeshRJ3qXd6r1FWuvJGfJv0F4JqW6gZYetnh3TH61LJ9Zc1Ch7Kb0z0CYuRI+BHxvs9E5PKPZqVeFXneU3UMXcNHyTC7QUddAc6/+WXNB0fbW87TAnaNWrSnH93X9jJXa8kxH/O/lhXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D2BC433C7;
	Thu, 28 Mar 2024 15:10:47 +0000 (UTC)
Date: Thu, 28 Mar 2024 11:13:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet
 <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-riscv
 <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add
 support to record and check the accessed args
Message-ID: <20240328111330.194dcbe5@gandalf.local.home>
In-Reply-To: <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
	<20240311093526.1010158-2-dongmenglong.8@bytedance.com>
	<CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
	<CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
	<CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
	<CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
	<CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
	<CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
	<CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
	<CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
	<CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 22:43:46 +0800
=E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:

> I have done a simple benchmark on creating 1000
> trampolines. It is slow, quite slow, which consume up to
> 60s. We can't do it this way.
>=20
> Now, I have a bad idea. How about we introduce
> a "dynamic trampoline"? The basic logic of it can be:
>=20
> """
> save regs
> bpfs =3D trampoline_lookup_ip(ip)
> fentry =3D bpfs->fentries
> while fentry:
>   fentry(ctx)
>   fentry =3D fentry->next
>=20
> call origin
> save return value
>=20
> fexit =3D bpfs->fexits
> while fexit:
>   fexit(ctx)
>   fexit =3D fexit->next
>=20
> xxxxxx
> """
>=20
> And we lookup the "bpfs" by the function ip in a hash map
> in trampoline_lookup_ip. The type of "bpfs" is:
>=20
> struct bpf_array {
>   struct bpf_prog *fentries;
>  struct bpf_prog *fexits;
>   struct bpf_prog *modify_returns;
> }
>=20
> When we need to attach the bpf progA to function A/B/C,
> we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
> and add the progA to them, and insert them to the hash map
> "direct_call_bpfs", and attach the "dynamic trampoline" to
> A/B/C. If bpf_arrayA exist, just add progA to the tail of
> bpf_arrayA->fentries. When we need to attach progB to
> B/C, just add progB to bpf_arrayB->fentries and
> bpf_arrayB->fentries.
>=20
> Compared to the trampoline, extra overhead is introduced
> by the hash lookuping.
>=20
> I have not begun to code yet, and I am not sure the overhead is
> acceptable. Considering that we also need to do hash lookup
> by the function in kprobe_multi, maybe the overhead is
> acceptable?

Sounds like you are just recreating the function management that ftrace
has. It also can add thousands of trampolines very quickly, because it does
it in batches. It takes special synchronization steps to attach to fentry.
ftrace (and I believe multi-kprobes) updates all the attachments for each
step, so the synchronization needed is only done once.

If you really want to have thousands of functions, why not just register it
with ftrace itself. It will give you the arguments via the ftrace_regs
structure. Can't you just register a program as the callback?

It will probably make your accounting much easier, and just let ftrace
handle the fentry logic. That's what it was made to do.

-- Steve

