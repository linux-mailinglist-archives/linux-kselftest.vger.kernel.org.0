Return-Path: <linux-kselftest+bounces-17706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3969748A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 05:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52CCB24334
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751937708;
	Wed, 11 Sep 2024 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="CTnssbu3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E//nWLKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3E225D7;
	Wed, 11 Sep 2024 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025511; cv=none; b=JldarTqvi+WYfLf3fjvORP4s819YtWe+dNJNcbki0C6eMqZF9i6DkkcWlBmRATB/QDhlBr/h0l2fSjikeX6SlxBGE9TW7sP3uWapKZDhH1jhtCOFqRMinnQ5Y1Qqm8u9N/IJIMGkyfDdIN2mxcU2CHub4hlMXzgbGU4KyFkD6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025511; c=relaxed/simple;
	bh=fh2mQQHN0+JyXsYmenNkWGkkjGx3ocELSgZ/ZIqwhUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We89M14djEJdth07Zh2LWKq2yEW9PDowJoyaPuxn4Ri1yU0BuY04H9+2TweXsnpjymGcVUuo2ksNF5sjJawvErS4DlDdhF+D6mM40OdPzT4xNNx7NgMPcrqKoJ2T/fwPGQTNb3283auoMbBEZoHoskwBozuDxWvnph6yazJ23Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=CTnssbu3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E//nWLKo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BB4511400BB;
	Tue, 10 Sep 2024 23:31:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 10 Sep 2024 23:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726025507;
	 x=1726111907; bh=dvDVMkbr7rfR+VCNGEE7NMGR6SEz2dyK7e21kWURShA=; b=
	CTnssbu3B6AtV3bXj661ntr/y/rpB6O/OZ45GMLskMx4TyAEliyU8GSs14vITv4W
	TrH8fzyrI4mvjdE13BEq0qI0wfiodvMqDofQzAlbifl9tSzWyQFWuZnpWVhSodos
	my5TLcq6QTJaO5KjwzBKLb1G8w7KMvczjMgFjk7EJsNIKAuQTVKdsgW+kkgxGB6S
	UqUAT0tp8uTfbxekCz98Uo7d6b41LMgwMQaiIGx1EyH8TCQ8vlJ3zMka8Fmqj322
	cl3+owVuIwTT2WKAZ9oN8h16PnzRCcO5Hy/leziW0fUgkJdLnlSXj4wDCeSKRNdP
	K/9bZ/ua6/aw05zKP89EIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726025507; x=
	1726111907; bh=dvDVMkbr7rfR+VCNGEE7NMGR6SEz2dyK7e21kWURShA=; b=E
	//nWLKoadYIePtJ3R+0d8frhqggwmLTDQNZAWUveLZc7cvfea1Mlv8+qiLF2i/5A
	Q96SnL2EOuMq4So4VZyoF2A0geWZ0nkSTX9BwAwJbu7B281npUMILl6KHwLMwCWv
	LQdXIP4YdyyXaKvDj9SIUS/IhHJvY3c2llVe4xX3C6go9Y7KkdFAlOw/bS1yyY+/
	ZVbvcVnH6XZcGfwJQfrQOxt8oMzeZxqHvNEUv735NIscPpHaTlmJdlQP8vUIrghC
	2HHlNtX7tiT5Pra2fhEgwzvMIoaKnNXeYXh2sXj6jLRtQYOz/fZZ4lQNNtZZDgBN
	o/ocqKwGGwbOYJmb0okTQ==
X-ME-Sender: <xms:Ig_hZgc-UibDzIpSgn1os821_tjPU_6mtuPws7Z3S33H5keeFQ1yNg>
    <xme:Ig_hZiPPKL3gSzA_gy5XtCVqBysTLlaRZPOckL2wKNOU1s49HB5MRBYPL1-W5UkEI
    0ehz6voKQ6AaPxGOw>
X-ME-Received: <xmr:Ig_hZhj8HXoIG3s1CG7eEdDT_WgN_3ifMlELoT6y3obuMu7W5v7mf8zn3vMAeKnrnccq03F4tUVCo5aKK8uJbDoTXMaTrHOMTv1tJlHd1V2cLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeff
    leetkeekkeeggeffvedtvdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrihhird
    hnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigvihdrshht
    rghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegvugguhiiikeejse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    grshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:Ig_hZl9SRWqJlxlQUmUvRc9-qKX-cHiiTlyT7g_3S90qiOE53EhD6g>
    <xmx:Ig_hZsswXRUWAiEu-0LeBecg-chMObhr5fITv0QDA2dcNs3JaPbwJg>
    <xmx:Ig_hZsHEjlg0Et9_0xlHeRwDC0zg8UBO_lacLrbyzWyLv16sz9bf9Q>
    <xmx:Ig_hZrO9GCydkYdnqRAAtx4KSUAmLq6uG5z4ZQSe-YhFn8a3_9Zt1w>
    <xmx:Iw_hZtMMXVUBcRodGF11Hrlx4FwGUkDjkkqX_TKsNzhLxHq-m46M2PUq>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 23:31:44 -0400 (EDT)
Date: Tue, 10 Sep 2024 21:31:43 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
Message-ID: <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
 <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
 <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
 <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
 <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com>

On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
> On Tue, Sep 10, 2024 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
> > > On Tue, Sep 10, 2024 at 3:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > >
> > > >
> > > >
> > > > On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
> > > > > On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> > > > >> On Tue, Sep 10, 2024 at 11:36 AM Alexei Starovoitov
> > > > [...]
> > > > >
> > > > >>
> > > > >> Also, Daniel, can you please make sure that dynptr we return for each
> > > > >> sample is read-only? We shouldn't let consumer BPF program ability to
> > > > >> corrupt ringbuf record headers (accidentally or otherwise).
> > > > >
> > > > > Sure.
> > > >
> > > > So the sample is not read-only. But I think prog is prevented from messing
> > > > with header regardless.
> > > >
> > > > __bpf_user_ringbuf_peek() returns sample past the header:
> > > >
> > > >         *sample = (void *)((uintptr_t)rb->data +
> > > >                            (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> > > >
> > > > dynptr is initialized with the above ptr:
> > > >
> > > >         bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
> > > >
> > > > So I don't think there's a way for the prog to access the header thru the dynptr.
> > > >
> > >
> > > By "header" I mean 8 bytes that precede each submitted ringbuf record.
> > > That header is part of ringbuf data area. Given user space can set
> > > consumer_pos to arbitrary value, kernel can return arbitrary part of
> > > ringbuf data area, including that 8 byte header. If that data is
> > > writable, it's easy to screw up that header and crash another BPF
> > > program that reserves/submits a new record. User space can only read
> > > data area for BPF ringbuf, and so we rely heavily on a tight control
> > > of who can write what into those 8 bytes.
> >
> > Ah, ok. I think I understand.
> >
> > Given this and your other comments about rb->busy, what about enforcing
> > bpf_user_ringbuf_drain() NAND mmap? I think the use cases here are
> > different enough where this makes sense.
> 
> You mean disabling user-space mmap()? TBH, I'd like to understand the
> use case first before we make such decisions. Maybe what you need is
> not really a BPF ringbuf? Can you give us a bit more details on what
> you are trying to achieve?

BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) for each
entry in the cpumap. When a prog redirects to an entry in the cpumap,
the machinery queues up the xdp frame onto the destination CPU ptr_ring.
This can occur on any cpu, thus multi-producer. On processing side,
there is only the kthread created by the cpumap entry and bound to the
specific cpu that is consuming entries. So single consumer.

Goal is to track the latency overhead added from ptr_ring and the
kthread (versus softirq where is less overhead). Ideally we want p50,
p90, p95, p99 percentiles.

To do this, we need to track every single entry enqueue time as well as
dequeue time - events that occur in the tail are quite important.

Since ptr_ring is also a ring buffer, I thought it would be easy,
reliable, and fast to just create a "shadow" ring buffer. Every time
producer enqueues entries, I'd enqueue the same number of current
timestamp onto shadow RB. Same thing on consumer side, except dequeue
and calculate timestamp delta.

I was originally planning on writing my own lockless ring buffer in pure
BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hoping I
could avoid that with this patch.

About disabling user-space mmap: yeah, that's what I was suggesting. I
think it'd be a bit odd if you wanted BPF RB to support consumption from
both userspace && prog at the same time. And since draining from prog is
new functionality (and thus the NAND isn't a regression), you could
relax the restriction later without issues.

