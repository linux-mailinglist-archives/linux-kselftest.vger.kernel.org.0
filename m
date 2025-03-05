Return-Path: <linux-kselftest+bounces-28300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7FA4FB2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C2A165404
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090A20550C;
	Wed,  5 Mar 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hJpocj7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u/NHKT/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148F1F3D30;
	Wed,  5 Mar 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169213; cv=none; b=b+Z46M0y7ABTWQfbCXYgepex/lMonMvCwGse1QPmDHUqNzqsj/eESJbosZGVo3Y2qYGLNhdLki5SqXN/NEqS3jt3SVsXQPqSsKGhjhMLs+SfJHLcxSZyimdqiZOUfBOgMOqJVzSDMx1FUqL0h3o3zzOv5mzobCBB830n6BIgGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169213; c=relaxed/simple;
	bh=POFkgzO8rm1oQNp6ytUtiiNRXbGm7AOdYqXhxPgh4sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8olgLNdYNl3XCAPUdKGnx0EiDEIPYB9vMsqnrNQPQi4m937oyZFQ7Ft9bl2xI6Vo9VVUH6bYMpJ4BXOaBcdhqFgo+32glCdx2HGKwi3qWcCGFXHqm5PMq0qrByPiuJ9Tl6JcwMYpeCs28qxndG+K6vNlx4kGhOcdlq4Ksfn8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hJpocj7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u/NHKT/Z; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C036025401EA;
	Wed,  5 Mar 2025 05:06:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Mar 2025 05:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741169208; x=
	1741255608; bh=OV22lrFV3DQBTGcw06CXISDEH3SxqJT8NlQedF2+oH8=; b=h
	Jpocj7vtNqNLdr/VV90HwI4omf9lvjbPmLOfpwnKOH6B7DiFJld7FF9oKKoHZTbN
	l+ELUcNjW7/sa3MguXc5X2c6axxaNzrMAzSF5o9uP5haAgGogOvVHA8M9CLxcWoH
	xIQSt0GkHsqaxorzOMT9UF3cIN2by8apiQd4df5JzJALX35BqlHw5CTDROBuHwrA
	l3JW8pngLevn7peJbN/2cob+O4Jdfk8PQNzaH4550AvAiE0K6+P+cq/czxcgXeno
	oFYBW4OXOln3ARE6Aw6zctlNOchroRZPJ9L/gq+LJzORNuq0PqbNg8FabrQhipxR
	+0UBXkK3JQbq3/CjHT92w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741169208; x=1741255608; bh=OV22lrFV3DQBTGcw06CXISDEH3SxqJT8NlQ
	edF2+oH8=; b=u/NHKT/ZQpVgl5aBzzP59XVl/aCDb4nvJ2ZY5LWWM5PurauNq6/
	W8Q91FenyD/jdrEEVIlO59jQG5OzxQ6fBt4kBfX9rYkggrEAFPcHs6cZrcd/R+Vy
	wynEPhKFHqHtBn3e5cZwXvs68QC+l3K8BpacUCE3Y+JjsHK9rkAxZg3VaEwxyVoe
	YJBBrdCgLrxBsg+IrdufdIPyE+UCZrmi9dYzrvSL8yd0Ud2sbxoSPVNv+5JoZQlv
	cb1p/prCwrzwJAXESNJTtvT0g5Q6je/eBK4bPq0rHhQe9hu3SuqUUeYhYDLaUtIH
	2/Dl/Q8rqBhG1/aqMI8lfltciwE3+kXzfaA==
X-ME-Sender: <xms:NyLIZ-MYNr-jPlNECyHoRQo8x3eET31MTCVcp3Rnoky1eaWR5NZ7fg>
    <xme:NyLIZ8-mnhcmeDFjLUUAi0Z4pIECapTlB-TrXy8ob69K4qxPPDl-UGtB3mJyJ7yaG
    -Gp1zhI4uwsqUFZXII>
X-ME-Received: <xmr:NyLIZ1RYn9jL2cyfIOWhBijdan2Z6qfoQXWZTpuZaopB8o5cedW7mJ1cuUDS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:OCLIZ-t_h-9lFtez33rBhZBpt-3v6dALYDF2d7_Mm2mxSQStfF_VIQ>
    <xmx:OCLIZ2ddhqzYJbEY-MnrzkuBFVDrL0gqPjro7dOdCFxIkUAsNiWHZA>
    <xmx:OCLIZy3r-hp_mMMb_0tAGapuBE-PDYZpWp3zLlhaRBsXQZ26wqAPDQ>
    <xmx:OCLIZ68hOjID9-T7dJuLvtMLrY3Q_NZdNAHaBMdpLPtlsggfh8RPMQ>
    <xmx:OCLIZ98PVQUB5BNVcHQeXGESQtEWdNuRxrhAlZyFDCv3qG5U9wEl9KON>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 05:06:47 -0500 (EST)
Date: Wed, 5 Mar 2025 11:06:45 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH v21 09/24] ovpn: implement packet processing
Message-ID: <Z8giNYKBWzQEtZJu@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-9-d3cbb74bb581@openvpn.net>
 <Z8dOOy9tSpJ1UCiR@hog>
 <8abd4290-cef5-4ea3-bdfc-b872c16efb8a@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8abd4290-cef5-4ea3-bdfc-b872c16efb8a@openvpn.net>

2025-03-05, 00:35:09 +0100, Antonio Quartulli wrote:
> On 04/03/2025 20:02, Sabrina Dubroca wrote:
> > 2025-03-04, 01:33:39 +0100, Antonio Quartulli wrote:
> > [...]
> > > +static inline struct ovpn_crypto_key_slot *
> > > +ovpn_crypto_key_id_to_slot(const struct ovpn_crypto_state *cs, u8 key_id)
> > > +{
> > > +	struct ovpn_crypto_key_slot *ks;
> > > +	u8 idx;
> > > +
> > > +	if (unlikely(!cs))
> > > +		return NULL;
> > > +
> > > +	rcu_read_lock();
> > > +	idx = cs->primary_idx;
> > 
> > I'd go with slots[0] and slots[1], since it doesn't really matter
> > whether we check the primary or secondary first. It would avoid a
> > possible reload of cs->primary_idx (which might be updated
> > concurrently by a key swap and cause us to look into the same slot
> > twice) -- a READ_ONCE would also prevent that.
> 
> Reason for looking into primary first is that we will most likely need the
> primary key to decrypt the incoming traffic.
> 
> Secondary is used only during a small (if at all) time window where we moved
> to a new key, but our peer was still sending traffic encrypted with the old
> (secondary) key.
> 
> Therefore optimizing for primary-first may make a non-negligible difference
> under heavy load.
> 
> Code doesn't get more complex due to this logic, therefore I'd keep this
> version (with READ_ONCE(cs->primary_idx)), unless there is a strong argument
> against it.

Ok, sounds reasonable.

-- 
Sabrina

