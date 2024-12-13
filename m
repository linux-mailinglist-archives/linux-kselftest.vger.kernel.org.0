Return-Path: <linux-kselftest+bounces-23367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954609F1722
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EB2161962
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947B1F130A;
	Fri, 13 Dec 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="QaOiHdKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="npwipiP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFB190471;
	Fri, 13 Dec 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120132; cv=none; b=dguIrS5ul4EbhmwxU8HIcyc1nCtTXBPRhnQi1acYSlSs9G8h4QLmOOowXyJHdY3GmbstALd9WIYhl5bifH9DEnG+cRuoUoi38czImhrCjlvw8Aum6KiCN/hkh9GIaZ+CEyGEdPkC9vsAmMmywmFBTHN/h1eGgFgWllPsE3OtiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120132; c=relaxed/simple;
	bh=cQ7JGQb4NBBf1Vsc9XB1qFiRbuBlTCVNsKyI+dsWoFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=madOa7XmyC8oadtIutfXwug/9zzVGAjZy8ooPg9SNaD+D/OaF89QX3CiyDL5y3hprPuSTzW/Wz5dwC7dYUNwwwybZ8/GEESfRVHVtr5AuFBIQVkmeFFYZ8miixyyynbAPERSEXwknVD3TADfha2HShcFpfe77M4G+KGk63RfhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=QaOiHdKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=npwipiP1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DE081382149;
	Fri, 13 Dec 2024 15:02:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 15:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734120130; x=1734206530; bh=oZSIPzAhQd
	6vMkfp3yMQ1DBeWcFBflQVOjU83wzxEX4=; b=QaOiHdKKYfMaqckjyQp2jyBt70
	TNQZ9wbVN0hS8LoeUM0Uf4as2f8fEEd0zQmBJn9nPNnAosINt3wCW2FXbu4iKDrU
	2NG+IwCrn+dvpAykLDXx9Xn7NWoMoRUO8XyMNQUZbBSeodLfAHs5Ahd7us7jyTN3
	sVt8xYd5nQsuJWixAzePTvnzqjy71eW5V3jFOStho+145G1QypGSa4jtmWcjNdsm
	FptiqWaAEk7kjy1L7PzlN7HWU30gTwpgeKwvXK0gpBlWKooQdIXMhQx5qLRUiRWF
	ZdpgL+/JgtO+UFvwbAU91Waoqd/6CQwY9FNakNzVjHi/hhtkksv+8JgSFl6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734120130; x=1734206530; bh=oZSIPzAhQd6vMkfp3yMQ1DBeWcFBflQVOjU
	83wzxEX4=; b=npwipiP1XXC2keiLDgS4skVFf57oEJxqMFIg2wrWPLmrLoLm0qo
	ff9VPo/lq5SzuxayZ1qQwQJ85B29XG5N1FHHw9RP7k6LON+WKFfFL/JHmAF59AZc
	zfIF5Rb4RqUlgTzvuU7wFSjPUZHpycihMDsPmqsv2VqfngQJhjyLF3N4UqhLdX/p
	S3nQiqUrgil8/BSac85SYjv71Gd/TF07XSjc43IVv5+sycYpW5tBO+ISPG4Or18D
	1UXXZfgIR75Xo2/WDjdl1kaDy8ps8VFp0lDDr+gj907ZmrCHcIyVv395Qa7LEvZi
	L4lb10YHHh19Q7Caz2IsZZCH2odIx3RxyyQ==
X-ME-Sender: <xms:wZJcZ0WgkYbzWqiAjt18KImf03Tm8rYkNAVORZ_oAtQPC8tVjGoupg>
    <xme:wZJcZ4lXkf9NCylP0JqFFD9cqfAm9EQooK7iCeOvZWignuW6EiKow32bV8kDT8cL1
    Auyf2TugP6Mc886pw>
X-ME-Received: <xmr:wZJcZ4azM93Sv3SSPD2xB6B3NCzflyPluMxk7l4IIDQfFzXVj-sZSIwKqXF8fJ-zgccRdoAL29iwGU-o3pGu4vS1UB0rg5L62vJEFDZU4e1enA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epvdefkeetuddufeeigedtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnug
    hrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:wZJcZzVAuZoo_2tDsg6gQgXZbVOiPgqlD3wNsaphtsHG3dO4cQDPnA>
    <xmx:wZJcZ-m4r7NVbXa1e__aK0bY2ojwi4zXhzLI2T_JFW5x1NJu7JASvQ>
    <xmx:wZJcZ4etpWewECywR9VZ9iMk32de5di6Ekv7arBhe6jCuNsh0hWoWA>
    <xmx:wZJcZwG-g3hDriQIbatprdiZNUTPppPi91VzzKYOdQ2-g0b2f1Uqbg>
    <xmx:wpJcZ0pbJKun6Nq6gQOkEMqvVGN8jJOtoZQAmCqu9IZ4W98mHU_B-79P>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 15:02:07 -0500 (EST)
Date: Fri, 13 Dec 2024 13:02:06 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/5] bpf: verifier: Refactor helper access
 type tracking
Message-ID: <fsclbw3cvixxy3p3toxqegi55wew6mpqmkjs3uyhfxxgfwg5ic@k7g6iu6qgzze>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <4727abf12fbc53723359d4edcdf5b6dd7d33f9cb.1734045451.git.dxu@dxuuu.xyz>
 <341df2d52af6c1584353b89a8a65d9d0fb5f0f27.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341df2d52af6c1584353b89a8a65d9d0fb5f0f27.camel@gmail.com>

On Thu, Dec 12, 2024 at 08:04:28PM GMT, Eduard Zingerman wrote:
> On Thu, 2024-12-12 at 16:22 -0700, Daniel Xu wrote:
> > Previously, the verifier was treating all PTR_TO_STACK registers passed
> > to a helper call as potentially written to by the helper. However, all
> > calls to check_stack_range_initialized() already have precise access type
> > information available.
> > 
> > Rather than treat ACCESS_HELPER as a proxy for BPF_WRITE, pass
> > enum bpf_access_type to check_stack_range_initialized() to more
> > precisely track helper arguments.
> > 
> > One benefit from this precision is that registers tracked as valid
> > spills and passed as a read-only helper argument remain tracked after
> > the call.  Rather than being marked STACK_MISC afterwards.
> > 
> > An additional benefit is the verifier logs are also more precise. For
> > this particular error, users will enjoy a slightly clearer message. See
> > included selftest updates for examples.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> I think this change is ok.
> With it there is only one use of 'enum bpf_access_src' remains,
> but it doesn't look like it could be removed.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
> > --- a/tools/testing/selftests/bpf/progs/uninit_stack.c
> > +++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
> > @@ -55,33 +55,4 @@ exit_%=:	r0 = 0;					\
> >  		      : __clobber_all);
> >  }
> >  
> > -static __noinline void dummy(void) {}
> > -
> > -/* Pass a pointer to uninitialized stack memory to a helper.
> > - * Passed memory block should be marked as STACK_MISC after helper call.
> > - */
> > -SEC("socket")
> > -__log_level(7) __msg("fp-104=mmmmmmmm")
> > -__naked int helper_uninit_to_misc(void *ctx)
> 
> Is it possible to peek a helper that writes into memory and not delete
> this test?

Yeah, good idea. Will do.

