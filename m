Return-Path: <linux-kselftest+bounces-17667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62B97468E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC031F26F40
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B81B4C2E;
	Tue, 10 Sep 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OIVcS2r1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Inov3oyk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B91B29D2;
	Tue, 10 Sep 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011884; cv=none; b=AUjFgVW3jHTuKpFIAyupEUNDty2t3mFBKdSU0rM9yBedoo6HKFlXJ9fLZqtPHWwV0W2mglTnFA0wt4HfRmXjWZimugqRLntQsulkOHRMEaNzCgkptg/kYc85Bml6d7Y6VmXdgk0l5qyn7eLRlhPLyN7ViuXLpVOwpT3FimsRMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011884; c=relaxed/simple;
	bh=NJRdyDt4ArtkhmucN0ADGasD7WAmAy2gcQoa3OuTEro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOmH1X4Zo2WJp+UqfL/PnvGJFoTY5QOjNjb84uzqu74fuW1t2kU1q9tCtMkMDfRr9BgRJ3dwrIU8DrHPqE8dCUjpO46gBhEy/hwWgLzw1dK8QFU4RMLI0hOPPnmqZ3+IYS9vi6hI9iizjx7KdDv2etK0LykPw+JyLcfboyMFeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OIVcS2r1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Inov3oyk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F50313801C0;
	Tue, 10 Sep 2024 19:44:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Sep 2024 19:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726011881;
	 x=1726098281; bh=7UKGu1SR/PBsryXACn9wUHAYZcr8DaV+dHj6lNuogFw=; b=
	OIVcS2r1Aud15229JwgZnwxT3mBmneFNGw0BhwEg1/ITv7i3nkj9/kXakxeYGBkC
	+TFkwXvg46EHuyOMNZHO2tDpa6U9KuO8c0KEkM45J+KDn9+n04cjh/JEW2gO2cHV
	tNRdrthYmKSFkRc2ODDNH2kx0+PEPHQSQug0cAuVmhbHPI1Vqmgo3yfwM5zHFNKt
	0o0ShbyyHWTUVZ3fAPhukxfGwy+Gmicov1d3mpl08YEdmJ+A7WgST11I4ktJUA72
	SFYnbFovXc/d4aUcPcaTcbT9rHhW1ntVQjhlsWAL8TbfvaGqPINuiQrfTWrfFwR+
	thh+GO784N1Squpemht2yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726011881; x=
	1726098281; bh=7UKGu1SR/PBsryXACn9wUHAYZcr8DaV+dHj6lNuogFw=; b=I
	nov3oykubRyvFUL238D2FQ/tN8Cz70Iq/eN9jHNgzSMMWVnaRTO6sHZJI9TxhKNf
	il/5Wk/5Er+Of0inHWAFpdBFJAhL0NxKg8CqHuWcRjAYbip0AA6klGnXpvJUdksy
	vb5P8IUjixWQAYwPabHaLKXgbHNRTyPWUCAWVZowixT/qXhdKfR5UMtgny2Akdrm
	1ZrQ236v+tnxs5x0NrLp89xaFU67ErIlqC/YWkOQKpYqUQARWaEKFA+T8PxRWrLl
	Ccjx8DJxrCoE5CBWbOM7jLFzGzC02ur9oQvEjA49CDAX2fdFKpywfSZYlw9sufVH
	b/UoTGiPBYx5qKu+aHePQ==
X-ME-Sender: <xms:6NngZvexNvWHH_w3EwaDDjHw_FDhYxNI-3wIYzE8iOJsetfLaxpgEQ>
    <xme:6NngZlPM1xWKKKhgyAwcfu2DNPqRJAY27abVucXtgKXf8Pdt3S25RdE8KkR9vJaxi
    IFEay2iD5x-avcAlw>
X-ME-Received: <xmr:6NngZojpWHyQrkkKZRu4dk2HBBx1p9ZWopb8PZh4EImW4cR3LGIdUqzucaLJ0onHwU0Ya_sSKmxep215SW7UABGhtuVqE7XTUTU36mGzUPN7tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddgvdegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:6NngZg8L71HmBOBoLv1wtNrsHY5RwO7HXkNgYOo5jSZzCxcf1ProMw>
    <xmx:6NngZrvzzhZi3sYRyo4_ykKOyJiDqdRudCs9NHec39zRWf-mcadWFw>
    <xmx:6NngZvFkYgBn7Rm9aQExLNG0HO7qsxsBfGPbhu3c38ajtr2FUn_oMA>
    <xmx:6NngZiMSXw_t2r7Sg_BFpPGXu6vnI83rksuUHcEz-KL0yh8tFXLvsw>
    <xmx:6dngZkP7UAAdT9-bYkHVmo429bErfwgctEYsJA4oXFvb8R1L2stEdSby>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 19:44:38 -0400 (EDT)
Date: Tue, 10 Sep 2024 17:44:36 -0600
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
Message-ID: <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
 <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
 <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>

On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
> On Tue, Sep 10, 2024 at 3:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> >
> >
> > On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
> > > On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> > >> On Tue, Sep 10, 2024 at 11:36 AM Alexei Starovoitov
> > [...]
> > >
> > >>
> > >> Also, Daniel, can you please make sure that dynptr we return for each
> > >> sample is read-only? We shouldn't let consumer BPF program ability to
> > >> corrupt ringbuf record headers (accidentally or otherwise).
> > >
> > > Sure.
> >
> > So the sample is not read-only. But I think prog is prevented from messing
> > with header regardless.
> >
> > __bpf_user_ringbuf_peek() returns sample past the header:
> >
> >         *sample = (void *)((uintptr_t)rb->data +
> >                            (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> >
> > dynptr is initialized with the above ptr:
> >
> >         bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
> >
> > So I don't think there's a way for the prog to access the header thru the dynptr.
> >
> 
> By "header" I mean 8 bytes that precede each submitted ringbuf record.
> That header is part of ringbuf data area. Given user space can set
> consumer_pos to arbitrary value, kernel can return arbitrary part of
> ringbuf data area, including that 8 byte header. If that data is
> writable, it's easy to screw up that header and crash another BPF
> program that reserves/submits a new record. User space can only read
> data area for BPF ringbuf, and so we rely heavily on a tight control
> of who can write what into those 8 bytes.

Ah, ok. I think I understand.

Given this and your other comments about rb->busy, what about enforcing
bpf_user_ringbuf_drain() NAND mmap? I think the use cases here are
different enough where this makes sense.

