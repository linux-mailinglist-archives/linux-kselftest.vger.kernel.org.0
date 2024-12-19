Return-Path: <linux-kselftest+bounces-23622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8B9F8739
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A35188FF32
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445A1C07EC;
	Thu, 19 Dec 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="aXqnkQNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gni1hwxs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6817E00E;
	Thu, 19 Dec 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644496; cv=none; b=tEdWkNyLf3g3ToneVXA0MPWtHN7zeJAvuS49n92IXQyC2nZIDnecr8Vomnv+21ImweymfKVjwIUOb6FGjD7jn9F4a4V0O6uuOfJXiZ/6Zsncfxk7iEoCBUEjGA1Tevo0WKhYe8aCxNH8eXpHIpI3CL6u422nJ7kQcx4KnvZMniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644496; c=relaxed/simple;
	bh=8UmFB3ctcuiDHHQgssQ2wpXNJtLZB9VRdpGjPoqc53c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoWvEIJWHEcGn6UBTf6LCxNpNk6Ir1bI+bMtUkIagvRX+pZoM27hlLeVmn/zIBjk5vFqSvokqzcz0xYvCOlKgBgKggG7bPG76hnzr51+VbFv8RkyPIniak75SCW2OK9+41DeTvXDKoDwX0VHLWXlpLekzDtmfGDn2FdI8I2wH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=aXqnkQNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gni1hwxs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D1292540182;
	Thu, 19 Dec 2024 16:41:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 19 Dec 2024 16:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734644493;
	 x=1734730893; bh=7HNi+Oxo7O1Ju2DD7K0mOmaR80xjOw6PNJN1e+KhpbM=; b=
	aXqnkQNR3d4MgNYa6yjoWsP6xiRkRsdBfyzbaBPfFgYL2p9cOD4pg+6UxHFcLC5k
	J50kpE5mXr8qXwcQKQxoAhXjiy9l6ouEOkkHiEFMlfSWgn/7tlbvs7ye8YFfDj4R
	SnQmEPepYRlfLbK2keSzfro7v8jrCJHlhsikDsCIRCXvJuEoa+fESE5v6BlLod5d
	wrLvRIhuUQVwIxKzB1k2lz1Xzk/leKfdRp9Pi0L8eoRV/QayGR7RAvgEfMaJJ9z6
	KCzY20R86edRUjXKR2HiVqQ4B2N3x7c/7rDaGgBdxbiw54ekvmHOG/XGC1B0VIg4
	Uf9jImKEdTafcxvKWZRfjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734644493; x=
	1734730893; bh=7HNi+Oxo7O1Ju2DD7K0mOmaR80xjOw6PNJN1e+KhpbM=; b=g
	ni1hwxsdt4SNB0gY+1IgszsJ9zAT+MxNl/2jLMy2SlPZpWPQ3yeuPthjsgn4xY6E
	t+RK7s85SZR6vpxTK9asl0vMe9Sx6ChpE01Xdrb7jf+5mj3HwNo+QeiQqRmLh8gf
	81hyCYql5vNYWMtgf4OvAHC7kAOiih0oovOIsWgiILNbH73sYeo+lj1pePstwP5L
	4cG9Jg1TAeKz1fjT7H9SD+evrOoMbDz6iZ4+5joXf2gyalPrn1HIzVfuZg1W8HAe
	TBmpQ6pG2aH2uPIZl+sxwTNxoWQbEOezw/8QlSlaOcxa1aVtMQkqK/zX3DQD9jpH
	WwCDo22CRv5mVu+0pdtmw==
X-ME-Sender: <xms:DJNkZ4MfS_mMLK-6pgjkj4iNJcdBe1MCEG_nYiLSROzlMYvu6f1rvQ>
    <xme:DJNkZ-84BpKcm-vbdCGMBYvx51fgjjdVMtcA1xJBb46mxjomyLpmdGZC3WmtaykXm
    7Juoay2cdGNPVE3dA>
X-ME-Received: <xmr:DJNkZ_RPgXleWpRlpYjgkVgZwxXJHl7_pVayffhAJAPPy6aayesmVu-r0ZGHU_Qy16_w4HH4TLX1J-4nr4ltjL4wKFPX8z2yLJY1obBS1K1q7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueek
    ffelteekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhhiih
    drnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjees
    ghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrd
    hnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtoh
    epshhonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DJNkZwuvt3tnYN54Eq1uCnYDL2NlcgftMQqLbPS3hCicaEnlK-C9RQ>
    <xmx:DJNkZwcu4dgkXVG_TC3yvX_tQUw50WSvlFrwejV8-9ZTU2yDULRqCw>
    <xmx:DJNkZ01_lajFu88kt7VPEYaTOYbNua-CPngYe30YRiAe3pQzO4D1gg>
    <xmx:DJNkZ0_zn6tANlSHMEmNp7rv9Qo5dDBHnLCG03IrUQZQd5i-__UpSQ>
    <xmx:DZNkZ1CNOK4IR9-6Dou635QXItOGMbuJqTvu-3T0UnBwzn7Hc6e7U4hZ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 16:41:30 -0500 (EST)
Date: Thu, 19 Dec 2024 14:41:28 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, 
	ast@kernel.org, shuah@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>

On Mon, Dec 16, 2024 at 03:24:01PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 13, 2024 at 7:13 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Fri, 2024-12-13 at 19:44 -0700, Daniel Xu wrote:
> >
> > [...]
> >
> > > > > +       /* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE */
> > > > > +       stype = state->stack[spi].slot_type;
> > > > > +       for (i = 0; i < BPF_REG_SIZE && stype[i] == STACK_ZERO; i++)
> > > >
> > > > it's Friday and I'm lazy, but please double-check that this works for
> > > > both big-endian and little-endian :)
> > >
> > > Any tips? Are the existing tests running thru s390x hosts in CI
> > > sufficient or should I add some tests writen in C (and not BPF
> > > assembler)? I can never think about endianness correctly...
> >
> > I think that if test operates on a key like:
> >
> >       valid key 15
> >              v
> >       0000000f   <-- written to stack as a single u64 value
> >       ^^^^^^^
> >     stack zero marks
> >
> > and is executed (e.g. using __retval annotation),
> > then CI passing for s390 should be enough.
> 
> +1, something like that where for big-endian it will be all zero while
> for little endian it would be 0xf (and then make sure that the test
> should *fail* by making sure that 0xf is not a valid index, so NULL
> check is necessary)

How would it work for LE to be 0xF but BE to be 0x0?

The prog passes a pointer to the beginning of the u32 to
bpf_map_lookup_elem(). The kernel does a 4 byte read starting from that
address. On both BE and LE all 4 bytes will be interpreted. So set bits
cannot just go away.

Am I missing something?

Thanks,
Daniel

