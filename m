Return-Path: <linux-kselftest+bounces-23107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFCF9EB5E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81935188BF6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA51BD9F9;
	Tue, 10 Dec 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aUXQVVkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUXK9X3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEC1B423F;
	Tue, 10 Dec 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847379; cv=none; b=cUcVHG+TY95M6JqAC9qyCg6P421ZSiEPphUxMXzcVVQ5Gm9SJlL6DbyBM0rKnvcmy17Ol0M7/TEC9B/neMWe1mUmlX3IM0y06oZkVgMWuQyLQc383Q85FOQc5Fu4nmppgKhUnQ//KgnpCxA7zu8b92XmtBy1Cqv93BRs5hrI748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847379; c=relaxed/simple;
	bh=viUmSs0HvGY4X79TSdydr20WipmovPOTq5y6AzuszwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF+oNcq9j7rh/OWKefNY3yszhp0oQJK4st7+B92JzId41mK/zG190FWpHLHHKSrqbhhoaOMD8/fmHpSFcUPQD4q5/03rhSyn1In47JrPC16ODLEkVNNVl4giUfdo03lizBdxIH7Q5ITqGFixjH0xCzOQsageMq6QzdGH4pddgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aUXQVVkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUXK9X3L; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A287254015A;
	Tue, 10 Dec 2024 11:16:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Dec 2024 11:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733847373; x=
	1733933773; bh=oD7elXkrVIabNJ1sH7sT/UFc6vHA8qZV5oZsH/wBIvE=; b=a
	UXQVVkRq+nlYoAXiUrOeOo0UWA5CvuErTkd4LN2ZPiC4LRwanfFurVCLq9LDSAu5
	PvucFTL65Mvv1SbGC42rQ1qxAb4iZV6stTHyI+g/sI2NS8qK9DtoDogPvSHuGMO2
	gd5bDxWFmQVewtEeeDGWLYcQcyNKVew4HFLu6YbnEt9iKzxwEMAoSa3rZf/22cuj
	ZtrW+wHPbCjeWn9k3VbUCo7vl8Wis+JWamKbxyfO0+l2z6ahdQswgDt1qfnoDmMx
	fcN7LI0WJwv2JVe5TaPuIGR3Qztxo5P2XJDAbNPtx3PsgXqkzPrBcg5c7IOezQvj
	u3Vn/6foOAoW0M1nYt+vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733847373; x=1733933773; bh=oD7elXkrVIabNJ1sH7sT/UFc6vHA8qZV5oZ
	sH/wBIvE=; b=JUXK9X3LJfPR/oMAUCJOsq5BhRYTMa1vl9WOcEGW2fTQ99FKGlw
	UeoiZbGJK0Dz7EVc2OHkpMbkAKOtr8LbVXuWjlJEKOeAJXZntgwar1dmPpFr3xIM
	0GMECvj2enumHG9TCUAAYvEEssY1wt2/YLLy9bdNh4A0906ky/Mu4pKMjDIvlM3O
	myjdipGeWp0355AOA6dRBqgr0zqhxph++Ok4y2P3rTJAv8oGEgK3U8MWaFNoPsKM
	UaHxqCuUN1VqkI1LU7YkRS0Q987CJMeXBsgNVcbz5NWUkvi8Oj0TsU7Jevtrh57p
	uqTZ+IIVKzqGVTciyE4ve1bzDY22a/Qrp0w==
X-ME-Sender: <xms:TGlYZ2BLF02PdMzLCDBLw4ArpIbECMkrRc9-CtaAi9X5eUwHRyOHOA>
    <xme:TGlYZwh0GcWHyJiDcgrHxrxLmfJ4h-qjzm7C9dm3wIoTUbubmNVxAYPuBwhffXzBc
    5gptUcpYDGnW4LEvOo>
X-ME-Received: <xmr:TGlYZ5nv1ajhV3oXbvU5HjxzZqebIRuUhPo9zN910mGCSSLtHWd3CFaOsXnZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpedukeeiieejvdefudfgieeiudejieehiefh
    keeiffehgfehleduieefgfeujeekjeenucffohhmrghinhepihgvthhfrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgv
    rghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvfhgvughorh
    gvnhhkohesnhhovhgvkhdrrhhupdhrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpth
    htoheprghpohhorhhvkhhosegrmhgriihonhdrtghomhdprhgtphhtthhopegsohhrihhs
    phesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhguse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TGlYZ0zmSeyabU5v0U-V7-mbGJ8wL6F9prV4Gbag6AlN1o0WTEMJ7A>
    <xmx:TGlYZ7Qas3JGPQMgMaYUIw-5-UWGBk8RbrxqcQIrqQy-Mszj66kG0w>
    <xmx:TGlYZ_ayFvdbyOAa5GPxR-0eYsV5QxtX9HjbHCHYqT8oXZ8M_m3_uw>
    <xmx:TGlYZ0TI2Fr83HEssJhWt7pH49vV2h9pg3pmyozIG7wm_QagHwTbbg>
    <xmx:TWlYZ5CZZXtUDzoER9w2UytJm_ZFG72sfcelgWM1TWGTcBvw5aMPhj3q>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 11:16:11 -0500 (EST)
Date: Tue, 10 Dec 2024 17:16:09 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 1/6] tls: block decryption when a rekey is
 pending
Message-ID: <Z1hpSbYKgytCFiPG@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
 <327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
 <20241203194701.48e74c8e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203194701.48e74c8e@kernel.org>

2024-12-03, 19:47:01 -0800, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 16:50:48 +0100 Sabrina Dubroca wrote:
> > +static int tls_check_pending_rekey(struct tls_context *ctx, struct sk_buff *skb)
> > +{
> > +	const struct tls_msg *tlm = tls_msg(skb);
> > +	const struct strp_msg *rxm = strp_msg(skb);
> > +	char hs_type;
> > +	int err;
> > +
> > +	if (likely(tlm->control != TLS_RECORD_TYPE_HANDSHAKE))
> > +		return 0;
> > +
> > +	if (rxm->full_len < 1)
> > +		return -EINVAL;
> > +
> > +	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
> > +		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
> > +
> > +		WRITE_ONCE(rx_ctx->key_update_pending, true);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
> >  			     struct tls_decrypt_arg *darg)
> >  {
> > @@ -1739,6 +1769,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
> >  	rxm->full_len -= prot->overhead_size;
> >  	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
> >  
> > +	err = tls_check_pending_rekey(tls_ctx, darg->skb);
> > +	if (err < 0)
> > +		return err;
> 
> Sorry if I already asked this, is this 100% safe to error out from here
> after we decrypted the record? Normally once we successfully decrypted
> and pulled the message header / trailer we always call tls_rx_rec_done()

This is the same thing tls_rx_one_record does when tls_decrypt_sw
fails. Return <0 immediately, let the caller deal with the fallout. In
the case where tls_padding_length fails, tls_decrypt_sw has an extra
consume_skb though.

Returning an error here will make tls_rx_one_record() also return an
error, and when that happens we always call tls_err_abort(). It's a
big hammer, but it should be safe.

> The only reason the check_pending_rekey() can fail is if the message is
> mis-formatted, I wonder if we are better off ignoring mis-formatted
> rekeys? User space will see them and break the connection, anyway.
> Alternatively - we could add a selftest for this.


Going back to tls_check_pending_rekey():

> > +	if (rxm->full_len < 1)
> > +		return -EINVAL;

There's no real reason to fail here, we should probably just ignore
it. It's not a rekey, and it's not a valid handshake message, but one
could say that's not the kernel's problem. I'll make that return 0
unless you want to keep -EINVAL.

Hard to write a selftest for because we'd have to do a sendmsg with
len=0, or do the crypto in the selftest.

> > +	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> > +	if (err < 0)
> > +		return err;

This probably means that the skb we got from the parser was broken. If
we can't read 1B with full_len >= 1, something's wrong. Maybe worth a
DEBUG_NET_WARN_ON_ONCE?

> > +	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {

Here I don't actually check if it's a correct KeyUpdate message [1],
we pause decryption and let userspace decide what to do (probably
break the connection as you said).

[1] https://datatracker.ietf.org/doc/html/rfc8446#page-25
    https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

> > +		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
> > +
> > +		WRITE_ONCE(rx_ctx->key_update_pending, true);
> > +	}
> > +
> > +	return 0;
> > +}

-- 
Sabrina

