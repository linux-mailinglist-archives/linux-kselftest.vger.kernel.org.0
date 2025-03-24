Return-Path: <linux-kselftest+bounces-29633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3DA6D8D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CBC16C0AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D4186E54;
	Mon, 24 Mar 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="d5wk2Bnp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lIu38uaB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5402C80;
	Mon, 24 Mar 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814168; cv=none; b=CQkpgTQevKcKEnQboEYDvOdd6abO696xLJ2Nj0xyLbEdW72s/1qx+setYWOEarKx0m0c37dV0FGjrND1iWaWgUhanYXLMjf2e+B1Y0tBe9xCnJGesogec3qsF+tefoqoXjjwfI3xfUT6ShoZDkIuLenhcGv9rU24ZsufVCXJFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814168; c=relaxed/simple;
	bh=VI/QlYUCAaTIIpXrXll+ObIf2vvUK8jQbyoXVdBsOiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp1p3Qm/kRXiJqHY4bPZA61bd9nxa5RCZiiyp39e/laNDfffhQ6WwzDCGWqb2yOrwTI0Aw0AfoqAdPhsLCiflMv1IzTxKwvEZ/ufI00n83pUSNvGuZ0ZReHYTAfxkb9JSJNe8kVoCyLy1webFgvzyvPAO6WyhPbyuGA/Sl50bnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=d5wk2Bnp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lIu38uaB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AA3BF1382C51;
	Mon, 24 Mar 2025 07:02:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 24 Mar 2025 07:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742814164; x=
	1742900564; bh=1GVyjF+cNaK2a06PURQAqI3y445XU6p/QCUMWiHbhbo=; b=d
	5wk2BnpTz5X25NvlwevUNay0dltJ+FFvhGLrDwhA7SbD7b+MvpflpluDer2dmhFI
	5yyXB+hK6dgpX3t/wl9GEp2GuJmYjtPYy8QZaxI/EwhqM8cfBGSow2D11MuQtes6
	zv7OD1UGSR4ut6lRPCcqBTEgAMW0A32b0j4qifjRn/gwkmooyTuubLPZEnsTPdu0
	mPoYWXc0L7k9f2/gIyDWWHP3vNtSNMqbF/MnVFokXPOztnI43yY1rNCI+DaOBH6w
	bgtHclXyCZYoBVZZ4oVPeIDPMKvcf7yFqlvid1yM76abFs5HYIj1gQRAqGafVnib
	ZvmCIP4SdgcDlDykF/lfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742814164; x=1742900564; bh=1GVyjF+cNaK2a06PURQAqI3y445XU6p/QCU
	MWiHbhbo=; b=lIu38uaBFHX0MD8YVZPmymdDQ5nm82hH1+hygQkL8ljmtd7zl9l
	JwSzzFC3PIasKLgFmXMFs/d3v/npOotk0SVwP9xmA4rJGNrYcMtKDnxH42ESKjeM
	M4HiWO3YlkZVRQwpupOzLMn/SMagkNrq+OF4Bwvap35AKdJCNso16r9Cy1saoXdK
	9UNtw7EWbqOgGPLZRDeYekpVit0AAUdoenbiLrerZMF0/b5dtYvnDTvJmBocS36I
	LIrAYQbD6+HSFP/E1zKpCyKBhClguBpklC8x8Qym93/oq8hnkelT8SRM3XOe5SGG
	/pV/I+4OfZbXsH6cErpISa9rnr93pLXuo/Q==
X-ME-Sender: <xms:1DvhZypm_hsm_tmGgrJDraeIM5qMGyraOsqrtVP_QIXI_fEHFIORYw>
    <xme:1DvhZwpYyV3zxPHOk_dUf0FWC0H0SwntVcovZTHq0m3y8t792BT_WGC8hRe2GzSim
    91lJBp0xjSJy-6yb4Q>
X-ME-Received: <xmr:1DvhZ3PQa6DmFzusnE0ece4DzKI2Icf3Hu8biNvIo7_xRpAWQYMAbFP1XCXa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1DvhZx5_FlQIkINyk4uEb_pU0xy_a0Y4D9DIStB5_4bwCZMvq9Y1-A>
    <xmx:1DvhZx7YtHO3AD3zyukaiNn2Ou8mTW_G1vWeFT-vXd7sbjBJPGs60Q>
    <xmx:1DvhZxiVuX7b_bM0P5R5EPrQOzDQ9N-DVwab0uQJVtRqMGjajLv42A>
    <xmx:1DvhZ76ctWUyquiOwhCFe6DCUc7XRnS3T7uS8HXwk2f5NH79h098Lg>
    <xmx:1DvhZwKOnpmyQTByuHlWE2tlOwHPGIwF5dNuvd0gg4sAD3L38X68NZq_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 07:02:43 -0400 (EDT)
Date: Mon, 24 Mar 2025 12:02:42 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
Message-ID: <Z-E70n1tkzKdepTo@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:44 +0100, Antonio Quartulli wrote:
> +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
> +			    const struct ovpn_peer_key_reset *pkr)
> +{
> +	struct ovpn_crypto_key_slot *old = NULL, *new;
> +	u8 idx;
> +
> +	if (pkr->slot != OVPN_KEY_SLOT_PRIMARY &&
> +	    pkr->slot != OVPN_KEY_SLOT_SECONDARY)
> +		return -EINVAL;
> +
> +	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +
> +	spin_lock_bh(&cs->lock);

At this point, should there be a check that we're not installing 2
keys with the same key_id at the same time? I expect a well-behaved
userspace never does that, but it would confuse
ovpn_crypto_key_id_to_slot if it ever happened.

["well, then the tunnel is broken. if userspace sets up a broken
config that's not the kernel's problem." is an acceptable answer]

-- 
Sabrina

