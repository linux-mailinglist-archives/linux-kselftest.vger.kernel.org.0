Return-Path: <linux-kselftest+bounces-23640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129409F8AD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 05:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6105516B7E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8891369A8;
	Fri, 20 Dec 2024 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Clp+poIk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4GjNwJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2167DA7F;
	Fri, 20 Dec 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667243; cv=none; b=NBnP1TSM6Vbigfdd60zlmz2dkA5/UpvKI6zV2xC6ybaijfZlIaNJpVEm06NOC5fxAqRHOD3nKY6YhbrXlgG5uN6D2pRY4x8u5cjV6++TKh6Ns5io2pA/ADs+SMhZ0f4EdNMVLIUDe7vaUtxCzbGaHUMbQDVqKPs0IJMMgRBdGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667243; c=relaxed/simple;
	bh=/YBlrGNICdQHzth9nNWjpLOs63Mw+gXp+zl06s9QO4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik09kapKwyti39OW8ky7GaG2oMpz5TVhY4C/5t8d4hnC3MSVq8sYz3fgWhYglnJ5kRqeT85XBZSwrmKML6WUOk4E4eAD3Y0s2M9jkBRTaJnKIOteigNZPQ9S46IMjCNz5rEHlUHiXevD7Cn6eNu3pEcKzddQYeGQTPoNHgBQLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Clp+poIk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4GjNwJC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E95A11401A2;
	Thu, 19 Dec 2024 23:00:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Dec 2024 23:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734667230;
	 x=1734753630; bh=a93/s60Sb4m7eEnvHamsltol0F+Fr3WeswnBsnKBOFQ=; b=
	Clp+poIk5n7YEKcj5hxjLSTL/Mft/jPfWozhDry030atNMcTQNGYUWmkZtGij8bm
	fherECYxSnc/we9g1PEbFGKRGO6Wsi/QE7H9/A0HpoeCwE6+W8QN3H1okt+L3Hav
	mxCv9bAlgUSU6I3mDllI7lbqxNbi1EfAiKFecg6Fxw4qlFNAV+kpr0LWrzIiyoeQ
	pe1cfuRZcLSx55W7Nr58qad+DPwyOiyVxh3NNa0UNb3WIyU0Lb4SuAxmEcALQY1B
	9pSVt45wHfYWH1clgxBJwtALG+7rV1tK+psGC/JiUFDch2c1KAAIYvyh0Xa+CFFh
	erL4ZsW4rtbwfrDGObH53w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734667230; x=
	1734753630; bh=a93/s60Sb4m7eEnvHamsltol0F+Fr3WeswnBsnKBOFQ=; b=d
	4GjNwJCA9B3ilEpqIRwiag+IgBpfJD1fmueAmR6G0OK9pBK8WfqXK/aYXz6tqbws
	KFOYNEwhiwMlhtLMu38ntFMrOiWkWctYsJGDRQefZyGu744jNgn2ADXWgWa214hY
	d0DJ5bTFDe4VdGOxrBJbDWzogITK7hS83HgVXiNT82ayNh8QFA9Xbr1qiEHPsPDj
	u4GeLAuOU+b+Eba6CmLa7gCPlploLIJVh56IfBTWEbkW+nxY7LrLIjJdTzDWTZSh
	rwiuyCgbURXAyyi4NLf0Vo1l3tP2SWuaZD9YSgjcNFuQGQgim69UiQ6usJfp+R7o
	6qDLu8iz/FnYZiW+SGHow==
X-ME-Sender: <xms:3etkZ7oDqzbzKYA7xrzzwyAX5he_rVdsybR91R5JZBzNneBqGp040Q>
    <xme:3etkZ1rOl-8cLEKo703Ug0KwD-JoSbksLeRGDAVJmzG6doOm6GrwdgeY5NmAFmhgs
    WGzzf62ATdhK55TEw>
X-ME-Received: <xmr:3etkZ4MQYKWhOb2eMAlMYQHHf3WmwlCBBXJxt8VB3fT5AFdadm7IZD0SaIoYmolU0SGvQvF1U3L5qxW9fjN_1s0lcptW7UDNOeCLhQWnWS1XRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeff
    leetkeekkeeggeffvedtvdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghird
    hsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiek
    jeesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidr
    nhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:3etkZ-4lZNDPJ4GtnVBYWqwLaK-JuaGV6C7mAr9WH98Q2XL6SLw0kQ>
    <xmx:3etkZ66-Y0ziRQKj7Nm7yedgu30lck8XwFO3DaGQlgri7CK3xuhpGA>
    <xmx:3etkZ2ggF1HOUvgzDzxSWrL-nIaP0yhyxCr78LjBTLgekuUnsiz7gw>
    <xmx:3etkZ87Nc9BluhaxS8uTU1MUNH1bMvKRaI4Qn_PHNetTvSRxzK10wg>
    <xmx:3utkZw76pJc4VRYkDBC_VnTeauMOntkclIKxYIXtXDu7pBB_psxKBdpI>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:00:27 -0500 (EST)
Date: Thu, 19 Dec 2024 21:00:26 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <wqcsx7bejn7zz7o4pdpavc2ufjmtoaf47pkyzrng2666xriqqx@glo4iwpho3ah>
References: <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
 <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
 <a2999d8b4827516fe4bfd17646d2284580712d08.camel@gmail.com>
 <f7taicw6c3f3yae4d6lrdagv26jiuihumklo4tkmqduvauargi@ld4bcmsbbiqn>
 <d0b5e424445f498fdedca04fd4b0f138fbb6ae36.camel@gmail.com>
 <CAADnVQKs3=pEea7VeTfxpuB7uxzZRCjikPGu17uusTpGdqLxDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKs3=pEea7VeTfxpuB7uxzZRCjikPGu17uusTpGdqLxDA@mail.gmail.com>

On Thu, Dec 19, 2024 at 04:49:13PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 19, 2024 at 4:43 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Thu, 2024-12-19 at 17:40 -0700, Daniel Xu wrote:
> >
> > [...]
> >
> > > > Ok, thinking a bit more, the best test I can come up with is:
> > > >
> > > >   u8 vals[8];
> > > >   vals[0] = 0;
> > > >   ...
> > > >   vals[6] = 0;
> > > >   vals[7] = 0xf;
> > > >   p = bpf_map_lookup_elem(... vals ...);
> > > >   *p = 42;
> > > >
> > > > For LE vals as u32 should be 0x0f;
> > > > For BE vals as u32 should be 0xf000_0000.
> > > > Hence, it is not safe to remove null check for this program.
> > > > What would verifier think about the value of such key?
> > > > As far as I understand, there would be stack zero for for vals[0-6]
> > > > and u8 stack spill for vals[7].
> > >
> > > Right. By checking that spill size is same as key size, we stay endian
> > > neutral, as constant values are tracked in native endianness.
> > >
> > > However, if we were to start interpreting combinations of STACK_ZERO,
> > > STACK_MISC, and STACK_SPILL, the verifier would have to be endian aware
> > > (IIUC). Which makes it a somewhat interesting problem but also requires
> > > some thought to correctly handle the state space.
> >
> > Right.
> >
> > > > You were going to add a check for the spill size, which should help here.
> > > > So, a negative test like above that checks that verifier complains
> > > > that 'p' should be checked for nullness first?
> > > >
> > > > If anyone has better test in mind, please speak-up.
> > >
> > > I think this case reduces down to a spill_size != key_size test. As long
> > > as the sizes match, we don't have to worry about endianness.
> >
> > Agree.
> 
> Earlier I suggested to generalize this zero/misc/spill counting
> into a helper and reuse here and in check_stack_read_fixed_off().
> 
> We do very similar checks there with a similar purpose.

Looked again, didn't see any obvious way to share code that doesn't make
it more confusing. Let me post v6 without this particular refactor. If I
missed something I'll fix it up in v7.

> 
> It sounds there are ideas to make this particular feature smarter
> than what we have in check_stack_read_fixed_off().
> Let's not overdo it.
> Even if a common helper is not possible, keep things consistent.
> The simpler the better.

Fair enough. We can keep it simple. 

Thanks,
Daniel

