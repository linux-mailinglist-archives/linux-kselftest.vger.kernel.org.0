Return-Path: <linux-kselftest+bounces-23372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6299F17A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BA8188344D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEE2191F77;
	Fri, 13 Dec 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="l2Cb4Qlf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zloanI0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315D6FC3;
	Fri, 13 Dec 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123447; cv=none; b=sTFrMJ2uGWBd93vUl928DG3DdknyPGBpkgi+9WrOmxi7BFGiWgGVXwG2cwioKlmkljiyzkDK65yVWU7o72x/Tby572V9P2SQyfmTqxLK/8T7Bc/ggBIj41jpLhbchPBzyb8OQoO0KRsuaX7332TVbFJQE2cE2DJt7pzcEkG1S04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123447; c=relaxed/simple;
	bh=TaOfAr9PuPuG0v0gREzQnJHMwkU+7sMrCcJ7h/OokZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtGHX66VyT3IEA3Cu7D5OFeYYlYwGQfF9dQyNKxBjzspYS/K9R/CaGaeOASgHVMX29skpTGmHSSS85tongZXssaBD9ORe5dp9TA9S/AdHzIkxySjWDgfROioiCQYxR3oINFwCCddgxtOa3RdqPIGKtjhQxEpFRQ46rvSbYnbEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=l2Cb4Qlf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zloanI0u; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 183861140189;
	Fri, 13 Dec 2024 15:57:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 15:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734123444; x=1734209844; bh=KSskvKq7uJ
	buKd7qfjsaoB+qKSL3/ZGIuEV/YTCll5I=; b=l2Cb4QlfW5NrOjDTAQCbYzKHGF
	kn/2NISHbjYEi321GkR/zwsK0dwU/YXOWYQqTMONHqU5mmrxUYW7eiXt1t6DsTYR
	QggkWc2Rf5xqeCQ6w9ygGDFeTBUrMEZyyvXZhbqTMthUfAwaPZQ2teMLQV+mVTSu
	oW73O/nFkzMcCmk+rz6D3t94rKIC2qnRHh0xo5OqWBPYaJpxf3E43vaqDvMk7LYs
	cWyinwUgSVd5u0ffrwYukccZmNM6sD8R+W8YD/8MgzQKIhZjtntd8dtt68/sr0wh
	weaiudZLuzGUmXu+J4NQvbtWSWX0OFGDkCp24FiM22rnvUJnqidvMQeD7i6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734123444; x=1734209844; bh=KSskvKq7uJbuKd7qfjsaoB+qKSL3/ZGIuEV
	/YTCll5I=; b=zloanI0upFDx5Z53vm9NiriOstiqqs7dSYUjXF/km+Yy6LCj9hv
	p8xLimeUN5/7ZVR97TJIByllf7v8xV1Ue2YQcDpobeNZrzJpikps0rLIsbi7uaS5
	/LrBJJIT47B2NaCGFRDGJEAAgNYyCAy9HddC80P0mhpVemsw9c9n8dvIwroeFSdN
	zArNXhY354SxMF+5hie4sGxQAEzs+DldaAU/dCD1qhGkMQeJWa0miUXZXZo8uDkx
	Kf+1mBwRXHtG+CUaZj60K5Qhr5OjWgWYnpp5kQQSnOidgKxprycu/i4NIvc7rarU
	ueRDkwo2Xaj4B8KhNm751G9UGLksl6DyAQg==
X-ME-Sender: <xms:s59cZ-Jp0jEUnKOxTtbYeUHhAUwS_7JpVJaiX_Ul5WKDCFVjfsrSSg>
    <xme:s59cZ2I9BiK0nGugoeQVIrKDCD9hy7nB7XoKi6ef_1xgifT14Xl98SLXdFPLNHaUc
    aYkGR83_tR6j3ilHQ>
X-ME-Received: <xmr:s59cZ-uGhqEL5VndRY62Wvx_D40yfzrWbro1xhW1nl99LAYHeDFEKqhudO62AEhOUVd6ceUa7CkdttJcORdMalQSr-4ser3VXE0KSpKMGf5FKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddugedvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:s59cZzYABhOnYI_iGWdFNq1QAXq_AAJsIXv9eFtqoxYFP9p2bOehLA>
    <xmx:s59cZ1Zfyr-z7IPQfoR4KhR7913OfTYsG0hd_ulVL0g0W3nLxQRFoA>
    <xmx:s59cZ_B3AHP0GoWsjvnaMwj5FfLCCcfwiPO8_ZETVf6w8aHAlxv8xQ>
    <xmx:s59cZ7ZC0oaHJM_JgLZAi-mOAqP3Vx1cyAJb9CSwhKnZu3SIrUTuyQ>
    <xmx:tJ9cZyQl6iPDsqHnIjZlz-_HQLraRIf2kCGES6hmPhLqHIWiJLZEPNjQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 15:57:21 -0500 (EST)
Date: Fri, 13 Dec 2024 13:57:19 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <cs4dybyzefyyk3e7zzec6mayt6re773ouo3svar4kcoxd6rakg@qodmhcted3mm>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <1b0e59ee87b765513c6488112e6e3e3cf4af7cb6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0e59ee87b765513c6488112e6e3e3cf4af7cb6.camel@gmail.com>

On Thu, Dec 12, 2024 at 08:04:45PM GMT, Eduard Zingerman wrote:
> On Thu, 2024-12-12 at 16:22 -0700, Daniel Xu wrote:
> 
> I think these changes are fine in general, but see below.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 58b36cc96bd5..4947ef884a18 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -287,6 +287,7 @@ struct bpf_call_arg_meta {
> >  	u32 ret_btf_id;
> >  	u32 subprogno;
> >  	struct btf_field *kptr_field;
> > +	s64 const_map_key;
> >  };
> >  
> >  struct bpf_kfunc_call_arg_meta {
> > @@ -9163,6 +9164,53 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
> >  	return 0;
> >  }
> >  
> > +/* Returns constant key value if possible, else -1 */
> > +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> > +				struct bpf_reg_state *key,
> > +				u32 key_size)
> 
> I understand that this is not your use case, but maybe generalize this
> a bit by checking maximal register value instead of a constant?

I'll check on this. If it works I think you're right - it allows more
flexibility while retaining safety. User could define max_entries to be
a power of two and then mask key with with 0xFFFF.. to guarantee null
free codepaths.

> 
> > +{
> > +	struct bpf_func_state *state = func(env, key);
> > +	struct bpf_reg_state *reg;
> > +	int zero_size = 0;
> > +	int stack_off;
> > +	u8 *stype;
> > +	int slot;
> > +	int spi;
> > +	int i;
> > +
> > +	if (!env->bpf_capable)
> > +		return -1;
> > +	if (key->type != PTR_TO_STACK)
> > +		return -1;
> > +	if (!tnum_is_const(key->var_off))
> > +		return -1;
> > +
> > +	stack_off = key->off + key->var_off.value;
> > +	slot = -stack_off - 1;
> > +	spi = slot / BPF_REG_SIZE;
> > +
> > +	/* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE */
> > +	stype = state->stack[spi].slot_type;
> > +	for (i = 0; i < BPF_REG_SIZE && stype[i] == STACK_ZERO; i++)
> > +		zero_size++;
> > +	if (zero_size == key_size)
> > +		return 0;
> > +
> > +	if (!is_spilled_reg(&state->stack[spi]))
> > +		/* Not pointer to stack */
> > +		return -1;
> 
> Nit: there is a 'is_spilled_scalar_reg' utility function.

Ack.

> 
> > +
> > +	reg = &state->stack[spi].spilled_ptr;
> > +	if (reg->type != SCALAR_VALUE)
> > +		/* Only scalars are valid array map keys */
> > +		return -1;
> > +	else if (!tnum_is_const(reg->var_off))
> > +		/* Stack value not statically known */
> > +		return -1;
> 
> I think you need to check if size of the spill matches the size of the key.
> The mismatch would be unsafe when spill size is smaller than key size.
> E.g. consider 1-byte spill with mask 'mmmmmmrr' and a 4-byte key,
> at runtime the 'mmmmmm' part might be non-zero, rendering key to be
> out of range.

Ah great catch. I think you're right.

