Return-Path: <linux-kselftest+bounces-24165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69BA0837C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 00:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587CF188BD2A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB550205E0B;
	Thu,  9 Jan 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="RffI9t5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2Mb/yk1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E7189BBB;
	Thu,  9 Jan 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465460; cv=none; b=Iv6F374YLK71mt9lkoyfygadx2nCVpjtxPHcAnzTuZ36Ft84EZxve2EkzWRzcD4XXCZknMpkMBqgrel+YKwPw0HHJRMj4CMNHFNVWRijnf0ztbTV1cXAqhDSbC6//eIl2bB7hBKluw6Wz7sTeYaPwZbX8rs8jezhaiMVL4rUf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465460; c=relaxed/simple;
	bh=w7GkOc9bZq2Zjok5ovgUZijFRHaFsLDijd9IU/zYoGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2ElfJ0YRx+lkQViWgExWYWox+fgaHlMnHwL/7CcP4iw1zPge//35EkBO8dGC8ByRZQq/hcdV4rbV261ptl1rmsVXT4QOZxSvO8bJ5zaqQCxrewqSavlsDvZ+D0mZqGLPO8Dx9GhPelEaP+CH0Bgd+Cn4CLpDfzo0aYOby+rjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=RffI9t5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2Mb/yk1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AF6411380264;
	Thu,  9 Jan 2025 18:30:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Jan 2025 18:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736465457; x=1736551857; bh=16dvk/IUtc
	/d/6djVXoA4pGwlcklIfSpJOnuxMcfJ90=; b=RffI9t5r9ljgXbZGIIheYL3knI
	QhQ865YwYOTZX30Pw712e4SysCuFt2LHJbygAOgGRaiVHpDgY4mSOBwTdLF+Njmw
	5b2FutGJhNTM1OoJ/z4+tgJAtewj5PL1/wySLLIxdPAflMPxGdOH/mHvt0OgO6aw
	9vLMw2QtDCX0ZS3j4x8n602a5y/2uWKy6CV5c+ucSAKh++whsRtmYHAbRdyj64Ag
	99f8RQIASWvsPeVxPrW0vmVinGHbcz/C0Ygc1TOwZFgPvFc34IQOy5Y0Pvvr2nRm
	GEUlwPGhA5xM+lnO2kRK3ZT3vtiIB5LdapvxJ5w7VeB5iAGJtw32eXel43Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736465457; x=1736551857; bh=16dvk/IUtc/d/6djVXoA4pGwlcklIfSpJOn
	uxMcfJ90=; b=i2Mb/yk1Nu+xU05U0olQh6zdaLEAlcWcpIpjtm1SrKtYJwNy7aB
	FqlLe0u9FNJV4290H7F5TmGkGfqT60luvLtKqmOToqh5QS+N8uq/UjzAXPJtHtXG
	l68YyHmPnXH3dFSE2xhID9iXzRM73epM71kKmCju65+hOjWcNy33akdqGCGbFOf6
	09P6Ng+cMVJtpjtT4M74dmDAhb6A3bSWjOKzVejZAKtBKaOb/faW3AU/o0QFON2a
	wgswglbA1ZPX9fPiwJH8cOHNIodUmJ69ZyMm4+7m2tfyA8V+BrPhtDps3qju16Po
	7ytT1IOJyiThsS7StsCIbzAaYfcRdBaUJ4Q==
X-ME-Sender: <xms:MFyAZ6fbRro6Lemb1a3AHKXHveXVPSibn23FQZkbtpujXz30TiNUqA>
    <xme:MFyAZ0OsbZFLB6fquwVQSXFGiumOklqplchnIZFX-TFuQSe_YNxJYNmOdGrdc1XSz
    6ysYcii_0TBCLA-kw>
X-ME-Received: <xmr:MFyAZ7jimlOPvQcMxt2MdNdi3O2UKw--ChugNpbplwyk1Ce2xPOAjNLjDhkM0cQ-2XB3pI03c_ni0Oc6eZZIylqJIrUTNSRrwnIs1_tEdH2WGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epvdefkeetuddufeeigedtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnug
    hrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:MVyAZ39EJ5dmCb70mBTNz7FkW705Qi8VXqMAc2gR-Vci1anKrXZ8BQ>
    <xmx:MVyAZ2sImiYzxCzODb5vtw-9qmzF9H2AZwxuR4VV1qv0tigMnf-UIw>
    <xmx:MVyAZ-FTsODGcypL6puVZZAExNWpQdrsygGg757wrixqDVEes3tGqA>
    <xmx:MVyAZ1NuefqADU9au8diD_14DjnK93zhKX3HMWOvTTEpuRPOIJEoyA>
    <xmx:MVyAZ-R8LfOgNSoZ5rEIxMpNXlHq8Z0T2TkKoPLxk-jfdszoyQKxEpUj>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 18:30:55 -0500 (EST)
Date: Thu, 9 Jan 2025 16:30:53 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <gpqzoa2kvemzeuwpc2q4jnlcgscut5ouz7gcnd3e5my7vuml4a@bhhditb2jzq5>
References: <cover.1734667691.git.dxu@dxuuu.xyz>
 <86213ea40c6e6a30bf8ba967da9b9c4c6d77fd0b.1734667691.git.dxu@dxuuu.xyz>
 <478322da282bbdae28027967ff47bfe2504559fe.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478322da282bbdae28027967ff47bfe2504559fe.camel@gmail.com>

On Thu, Jan 02, 2025 at 06:53:54PM -0800, Eduard Zingerman wrote:
> On Thu, 2024-12-19 at 21:09 -0700, Daniel Xu wrote:
> 
> lgtm, but please see a note below.
> 
> [...]
> 
> > +/* Returns constant key value if possible, else negative error */
> > +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> > +				struct bpf_reg_state *key,
> > +				u32 key_size)
> > +{
> > +	struct bpf_func_state *state = func(env, key);
> > +	struct bpf_reg_state *reg;
> > +	int slot, spi, off;
> > +	int spill_size = 0;
> > +	int zero_size = 0;
> > +	int stack_off;
> > +	int i, err;
> > +	u8 *stype;
> > +
> > +	if (!env->bpf_capable)
> > +		return -EOPNOTSUPP;
> > +	if (key->type != PTR_TO_STACK)
> > +		return -EOPNOTSUPP;
> > +	if (!tnum_is_const(key->var_off))
> > +		return -EOPNOTSUPP;
> > +
> > +	stack_off = key->off + key->var_off.value;
> > +	slot = -stack_off - 1;
> > +	spi = slot / BPF_REG_SIZE;
> > +	off = slot % BPF_REG_SIZE;
> > +	stype = state->stack[spi].slot_type;
> > +
> > +	/* First handle precisely tracked STACK_ZERO */
> > +	for (i = off; i >= 0 && stype[i] == STACK_ZERO; i--)
> > +		zero_size++;
> > +	if (zero_size >= key_size)
> > +		return 0;
> > +
> > +	/* Check that stack contains a scalar spill of expected size */
> > +	if (!is_spilled_scalar_reg(&state->stack[spi]))
> > +		return -EOPNOTSUPP;
> > +	for (i = off; i >= 0 && stype[i] == STACK_SPILL; i--)
> > +		spill_size++;
> > +	if (spill_size != key_size)
> > +		return -EOPNOTSUPP;
> > +
> > +	reg = &state->stack[spi].spilled_ptr;
> > +	if (!tnum_is_const(reg->var_off))
> > +		/* Stack value not statically known */
> > +		return -EOPNOTSUPP;
> > +
> > +	/* We are relying on a constant value. So mark as precise
> > +	 * to prevent pruning on it.
> > +	 */
> > +	bt_set_frame_slot(&env->bt, env->cur_state->curframe, spi);
> 
> I think env->cur_state->curframe is not always correct here.
> It should be key->frameno, as key might point a few stack frames up.

Ack, nice catch.


