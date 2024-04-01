Return-Path: <linux-kselftest+bounces-6949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9D893DEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86AFB228BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6B47768;
	Mon,  1 Apr 2024 15:57:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E817552;
	Mon,  1 Apr 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987037; cv=none; b=nRUEnkdV9nTDCXyaNss9r0zxsjhqs2+unLdT0Ntd+fqnMT1aGdEEu0Tb8Q1yo5bk6Goe+GaGR+KKdRUj8Fr+k9MLBaMBF+LVLEC/HdL1gssBamsIWtLYoU36RafdBVBaXMDXEn3eZzNDljcTiXy3zPz48/4CpEQlgoPE5Njg3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987037; c=relaxed/simple;
	bh=hWWP4R/JFRFxsD5wn5WwHEfJM77NgnC9mgolOKg4FdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc4KM8If9MVLcx2Pt5XaiXk/SbmBLTBjJ+liGWJD4J3Q85j84V+1xIooH1i6mkZ9KzAmsxmPDcrzwAblhiYUm+OdlN4fu0QjT4bz8/FWVyg9OXBWfGthhCjHOpND+tw+QpZS3e6QYFm8xbDzVjzRDJWvW8wVRFAQK0GsUQMF/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C86C433F1;
	Mon,  1 Apr 2024 15:57:13 +0000 (UTC)
Date: Mon, 1 Apr 2024 11:59:28 -0400
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
Message-ID: <20240401115928.3d012be2@gandalf.local.home>
In-Reply-To: <CALz3k9j_RGqSMdN+GvbHEjRqMWYe4R9VNZRANG7jbfL_jVpoVg@mail.gmail.com>
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
	<20240328111330.194dcbe5@gandalf.local.home>
	<CALz3k9idLX10+Gh18xWepwtgvp4VZ3zQfY4aoNXn0gCh8Fs_fA@mail.gmail.com>
	<20240330153722.65104301@gandalf.local.home>
	<CALz3k9j_RGqSMdN+GvbHEjRqMWYe4R9VNZRANG7jbfL_jVpoVg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 10:28:17 +0800
=E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:

> On Sun, Mar 31, 2024 at 3:34=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Sat, 30 Mar 2024 11:18:29 +0800
> > =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
> > =20
> > > > If you really want to have thousands of functions, why not just reg=
ister it
> > > > with ftrace itself. It will give you the arguments via the ftrace_r=
egs
> > > > structure. Can't you just register a program as the callback?
> > > > =20
> > >
> > > Ennn...I don't understand. The main purpose for
> > > me to use TRACING is:
> > >
> > > 1. we can directly access the memory, which is more
> > >    efficient. =20
> >
> > I'm not sure what you mean by the above. Access what memory?
> > =20
>=20
> We need to use the helper of bpf_probe_read_kernel
> when we read "skb->sk" in kprobe, and the "skb" is the
> 1st arg in ip_rcv(). And we can directly read "skb->sk"
> in tracing, which is more efficient. Isn't it?

If you add a ftrace_ops function handler that calls a BPF program, I don't
see why you can't just give it the parameters it needs instead of using bpf
helpers. It's no different than using a trampoline to do the same thing.

-- Steve

