Return-Path: <linux-kselftest+bounces-17708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7C8974959
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 06:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0531B1F268DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79780524D7;
	Wed, 11 Sep 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DEH+eF2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LX9q9qim"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFB39AEB;
	Wed, 11 Sep 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029822; cv=none; b=R6jy5M62GbZOXHuLgQnLxpI0drWy5EyVgoy97TdmotVkTw2XWJinjHNtqwVQ0lLtsaQ3dAUJ6mBiCdxxy52UuP8NqlCrpv6rXNwrft9zGDQdHCVC13B7SEjIxM978ibcInMTAxWiXXG41kNewvLwq86jUi7+GEeh+GiTmvQOVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029822; c=relaxed/simple;
	bh=5WJmlUpv4uarehRVhZPvsD4DxEp0exdQL0oR9rX1viQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BSrlA3C0JUxUSYkcYy1Rt5TyqUBTqQchkps3RiL5R+t/7WuYFYLSrPDIKLIfTyHAPD2idICjV455kzB2N29EWiAkwZr148DNlatECOx762qpzY5jj4rmOEQdBul/ljFCtK+TjMQgSjMlbqep/zWRp7iytSlSxPqrXQ7nmWeEyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=DEH+eF2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LX9q9qim; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 2F9A22002F0;
	Wed, 11 Sep 2024 00:43:39 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 11 Sep 2024 00:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726029819;
	 x=1726037019; bh=U9YHIYH7MDBn8W8m5ipffYcdOZHKNXYCU4csAZFBp0E=; b=
	DEH+eF2apJ98APgQPYNh6XK2m04O63eL+8sF5i84xFMQzIqX/d+dYYEOy+GbalG9
	RBoxkO+Wb7x6qitIUKJfeuVi/h/wl5tkvofP7pli+zyRRDT9zlxRZ7yDEL799Tkq
	sjNOJ9y+HDMgiijlJIfLpXFqsQtDVJZ0UTpvZ96ySqIwFcqYPyUKy+MqiuqqPeJf
	sfgp5vjcA/1UPX74v7G5dTTJo/VxKdi6vo8H3NmYHS3R9aAXYT8aQKiKlxhxw8/a
	CwnWM5ne6295Mo5HER9qsKzdEzbh4W/VE6DodyQA/352i6exJrDKIo/U0VXlBL8b
	1jhe26IDKj7xjGuPndO0jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726029819; x=
	1726037019; bh=U9YHIYH7MDBn8W8m5ipffYcdOZHKNXYCU4csAZFBp0E=; b=L
	X9q9qimlwytCr3wy6RA8JWzTHF1PgCsvxU860sGMMA79qsULmzRRCwAFjkMCtXJB
	+Xmr3JRi7DJEI9BAos8cPR3bXS90IgMJ4tAXw8LB0xLWFTSqOLwdcvYp2+TKSrPQ
	4kfZm1speIONlYJjI7z0S0kgAk5NT1zayt5xe+gmn1t4Uex0fMCJZ40LOOHlxvw5
	mDiWbZMW6AqNaXWftwSzHf8CnxF5IOyE3bquDZDGJSe8YGUSc078T08uRmKpVJ+M
	TlY147lf0miNsRTSq9+BKpBlBizRDuTfsc8+ugJ2fSqkq8nINU3QusnKkFU1+bXQ
	h0AMY7dG5p3bNeu3i+JBA==
X-ME-Sender: <xms:-h_hZnVHLkV6mN97PjZRXqceB6Z5mDZ2YJSLeru-OZkHO0vbuMi5Kw>
    <xme:-h_hZvmmuaYz2KzfoieYhR2XT1nUh2i9uiLgIJEH2U5iZQhBNs1qjtqTnQGdkyz2E
    2oh9v2febItXn-UyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleeitefgvefffedufefh
    ffdtieetgeetgeegheeufeeufeekgfefueffvefhffenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhihkhholh
    grlhesfhgsrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgt
    phhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprh
    gtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehhrgholhhuohesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvg
    htpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-h_hZjYm_JsKU-SWJKhPpHRf7HWtCOSPBCgDn8nzsSGKcm_vp1fIFQ>
    <xmx:-h_hZiU1XEdfk4qEEiTkQhBsliDp5bOXeBQ6jnFiE8rl1xpZj55SFQ>
    <xmx:-h_hZhmjYYpmDMXp2qtu_tZQzOf6Tm1OUPntjnpJnzKBZ_fagGcxUQ>
    <xmx:-h_hZveDDS4Ebten0B46D8YD2SXxZ72BGY9TvNJrMPJY1BrQkAddgQ>
    <xmx:-x_hZspB9AnDHwaJNIMKwExFdXvRGlhbATh1-oGx7fGBCDDPhr5WxSF7>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 732FC18A0065; Wed, 11 Sep 2024 00:43:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 21:43:18 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <8a088e49-2b40-4a04-ae16-57cdddde09bc@app.fastmail.com>
In-Reply-To: 
 <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
References: 
 <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
 <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
 <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
 <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
 <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com>
 <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming BPF_MAP_TYPE_RINGBUF from
 prog
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[cc Jesper]

On Tue, Sep 10, 2024, at 8:31 PM, Daniel Xu wrote:
> On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
>> On Tue, Sep 10, 2024 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wro=
te:
>> >
>> > On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
>> > > On Tue, Sep 10, 2024 at 3:16=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz>=
 wrote:
>> > > >
>> > > >
>> > > >
>> > > > On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
>> > > > > On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
>> > > > >> On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
>> > > > [...]
>> > > > >
>> > > > >>
>> > > > >> Also, Daniel, can you please make sure that dynptr we return=
 for each
>> > > > >> sample is read-only? We shouldn't let consumer BPF program a=
bility to
>> > > > >> corrupt ringbuf record headers (accidentally or otherwise).
>> > > > >
>> > > > > Sure.
>> > > >
>> > > > So the sample is not read-only. But I think prog is prevented f=
rom messing
>> > > > with header regardless.
>> > > >
>> > > > __bpf_user_ringbuf_peek() returns sample past the header:
>> > > >
>> > > >         *sample =3D (void *)((uintptr_t)rb->data +
>> > > >                            (uintptr_t)((cons_pos + BPF_RINGBUF_=
HDR_SZ) & rb->mask));
>> > > >
>> > > > dynptr is initialized with the above ptr:
>> > > >
>> > > >         bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL,=
 0, size);
>> > > >
>> > > > So I don't think there's a way for the prog to access the heade=
r thru the dynptr.
>> > > >
>> > >
>> > > By "header" I mean 8 bytes that precede each submitted ringbuf re=
cord.
>> > > That header is part of ringbuf data area. Given user space can set
>> > > consumer_pos to arbitrary value, kernel can return arbitrary part=
 of
>> > > ringbuf data area, including that 8 byte header. If that data is
>> > > writable, it's easy to screw up that header and crash another BPF
>> > > program that reserves/submits a new record. User space can only r=
ead
>> > > data area for BPF ringbuf, and so we rely heavily on a tight cont=
rol
>> > > of who can write what into those 8 bytes.
>> >
>> > Ah, ok. I think I understand.
>> >
>> > Given this and your other comments about rb->busy, what about enfor=
cing
>> > bpf_user_ringbuf_drain() NAND mmap? I think the use cases here are
>> > different enough where this makes sense.
>>=20
>> You mean disabling user-space mmap()? TBH, I'd like to understand the
>> use case first before we make such decisions. Maybe what you need is
>> not really a BPF ringbuf? Can you give us a bit more details on what
>> you are trying to achieve?
>
> BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) for ea=
ch
> entry in the cpumap. When a prog redirects to an entry in the cpumap,
> the machinery queues up the xdp frame onto the destination CPU ptr_rin=
g.
> This can occur on any cpu, thus multi-producer. On processing side,
> there is only the kthread created by the cpumap entry and bound to the
> specific cpu that is consuming entries. So single consumer.
>
> Goal is to track the latency overhead added from ptr_ring and the
> kthread (versus softirq where is less overhead). Ideally we want p50,
> p90, p95, p99 percentiles.
>
> To do this, we need to track every single entry enqueue time as well as
> dequeue time - events that occur in the tail are quite important.
>
> Since ptr_ring is also a ring buffer, I thought it would be easy,
> reliable, and fast to just create a "shadow" ring buffer. Every time
> producer enqueues entries, I'd enqueue the same number of current
> timestamp onto shadow RB. Same thing on consumer side, except dequeue
> and calculate timestamp delta.
>
> I was originally planning on writing my own lockless ring buffer in pu=
re
> BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hoping I
> could avoid that with this patch.

[...]

Alternatively, could add a u64 timestamp to xdp_frame, which makes all
this tracking inline (and thus more reliable). But I'm not sure how prec=
ious
the space in that struct is - I see some references online saying most d=
rivers
save 128B headroom. I also see:

        #define XDP_PACKET_HEADROOM 256

Could probably amortize the timestamp read by setting it in
bq_flush_to_queue().

