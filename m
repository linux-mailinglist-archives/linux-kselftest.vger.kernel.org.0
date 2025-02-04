Return-Path: <linux-kselftest+bounces-25703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843CA276FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD1F3A3EE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85020214A67;
	Tue,  4 Feb 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Qo6/z2r2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ed0z7Tqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2B3232;
	Tue,  4 Feb 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685906; cv=none; b=IGyapO0KiSeLvZAfFoXeEEEAqylTszgTfV3dqUldzXBBqsUceu3xs51Mu/U+iE99sm9T6oshD2rBPwvx6mO7Tj2HV1Aul82Hjh3dwEXucV0WQxvLGvBr5L6fkHZ093Hu/Pzdm2nCPwsmxmmY0uH51NcFQzYfWDyOzNf4YQIg7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685906; c=relaxed/simple;
	bh=DKTIL9GERuc5VnQAC6xaTgLBDniJCbeGoOMmXtCvH5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG0PiMqeaxVfyLMxIca3UFv0On5+13UsvJRb6bzNOXyqURU16UjyGSDB49repKk64NiXyVR1Jy7dacjCajBHLZRL9yAavRbXC+4wgDr1MWd6KrX4ExqGiluBJTXR0lo8/h9GDnzaXDKhaOvaEXp/z1hl2oDoULXbfWrkbLUfXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Qo6/z2r2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ed0z7Tqn; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D85C11400DD;
	Tue,  4 Feb 2025 11:18:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 04 Feb 2025 11:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738685901; x=
	1738772301; bh=Hstw0ccrll9JlVqF+ADPlMurrFIjkYXqn+Q5Hs2OIUM=; b=Q
	o6/z2r2cVTp/1eWT6xSJUGvmj4ocZkuWBpjK4tcAI6RWbYK0qdbJq1hjSNxluVIG
	2ZkdyVW0h5kFqLDnbJBSMOaOf6VBLai2iL0qtPvzBRdC1clfG30/elsRLGAHMWDo
	UD1iO6FCUp71ls0qlrmmg0R5n9sIZZokZu512AUDKxVfXeJkQbWtuuEfQY4vMOoK
	/DOhLPsCLWHC/WNNaowT5S/kyuR4U0GanIKM8bx9HWqHoA41cSrZbS/u1yCzh9Xs
	NDTWFzUh/233fES4EpnxVCD2aHWeoztg2N44S7bdI+QF+ajObfE4wENhWDYT7tm+
	0Q+5jmtP6QBaysnliRAUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738685901; x=1738772301; bh=Hstw0ccrll9JlVqF+ADPlMurrFIjkYXqn+Q
	5Hs2OIUM=; b=Ed0z7Tqni7+xPwM1mHFVV/8woWiulLl56mCOloGBn1YcRMCjeBz
	N3TbRvSkOqC+JoLnsl/KPqqys61u3UfVaD8kHPPFsjoejdW+SE3mhFS+5WYcIKkt
	JZo6zCy8leZA6z002/o/zv0Z9cQQEp4+Bn0q7nwz6K5+2Voh6anVXKgPNQoPAd4F
	PgWQw8K2Y954JikOE4upbCfZbXkhlKLIwi1VRXnWpBk4TcFYG6/BqX15oQvyhOz7
	nYBROioJVxq2pGimrE6oS7KNHEigDGfTOPGnDKRcmWLpwC/Ya2tEyJuLYJwbumZh
	jBji/NZQn6XEYseEBgjNqJqkQaP9DbTomGQ==
X-ME-Sender: <xms:zD2iZ1TXI5TLj3xLqLiwpeLaRHMOs2VQ_73_7XX8H_TQkdCdVkRSKg>
    <xme:zD2iZ-xCHuiiE-ASzJr3HN_a3UlmkepkwcgiFSheixCShuE5dY5286Qfie5lF8p4W
    CD6oCyHcz2ss5VW9oA>
X-ME-Received: <xmr:zD2iZ63e8lXi6Ifcv86aQVqQYeYnagGvi-FwHx1BQ_sIDkXUeUnwYztFZq-N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:zD2iZ9Cp115umxV5rSRkBw4Wmk_iuM_5-cYBvc3Nd8AcQlPd8ADB5w>
    <xmx:zD2iZ-jxZ0zlJK5o7kkEytQorPI7oRaXX0L6RBrXQgZHkFy_-fWuVA>
    <xmx:zD2iZxoMX57E1EvgvZ_dYicmJLkP1HPNl08MePG8K8w2aai-1JAt5g>
    <xmx:zD2iZ5gU7fmrHZaKLn48hBmDeZpNSXgrmMmqI6JbwFjrod6p_SjDnA>
    <xmx:zT2iZ1QKyyeHNi_akJQPrHBcBIRNIV12AUKOROKZFvt1pzJvxZTz4w25>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 11:18:20 -0500 (EST)
Date: Tue, 4 Feb 2025 17:18:18 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 07/25] ovpn: implement basic TX path (UDP)
Message-ID: <Z6I9yn3Nh-9Ebvv9@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-7-1f00db9c2bd6@openvpn.net>
 <Z6CR6QGVrMqauP2H@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6CR6QGVrMqauP2H@hog>

2025-02-03, 10:52:41 +0100, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:26 +0100, Antonio Quartulli wrote:
> > +static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> > +{
> > +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> > +
> > +	if (unlikely(ret < 0))
> > +		goto err;
> > +
> > +	skb_mark_not_on_list(skb);
> > +
> > +	switch (peer->sock->sock->sk->sk_protocol) {
> 
> We have a ref on the peer, but not on the ovpn_sock. DEL_PEER could
> have detached the sock by the time the crypto completes.
> 
> (unfortunately I don't have any idea to fix this yet)

Maybe an idea:

Since ovpn_sock itself lives under RCU (because of sk_user_data),
peer->sock should be an RCU pointer and also follow RCU rules. For
most parts (io.c, netlink.c) the conversion is not too
problematic. TCP is more difficult.

I still need to think about whether this works, and whether this is
worth the complexity, or if we could solve this in another way.

-- 
Sabrina

