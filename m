Return-Path: <linux-kselftest+bounces-21452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAED9BCA7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30BF1F2232A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17211D14E3;
	Tue,  5 Nov 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TFqPGglE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtPLr8LC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80741632DD;
	Tue,  5 Nov 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802801; cv=none; b=KYQFlzLRv8B6y4iQ+v4SgIQEhnMIv8VMdr14wpdbm/kz3bfPw4u/R/lgfU8MSH/nhba2cttDHM5bLpqMYKWDotwRjI/fAJKmZo+3kcOBe7xn8UERVTiubFGxqGt9S4dMPVQaYthsmFTCgsastT2yXR44bKUtTUwYGLdjaRGr24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802801; c=relaxed/simple;
	bh=8zZZLjRfm/EdGYhe+YUGmH7O4JMoaDWxEd4r1qZBABs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL2sHK3fXVYI8uBjM/XMcWA2llNSHChKnSqx80h0FCTlysGYk2JjViAmBavvcRFmKkRwpGpMfwgYuImm+CgA6GF2KZtOERFI4I6hNspK3i+MNpENFAMNoA1+vhcv3bWEmpAkSu6SYWFKHsPFwKTaFioo6wtAllre6aXzqLlblyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TFqPGglE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtPLr8LC; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 754A91D40249;
	Tue,  5 Nov 2024 05:33:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730802796; x=
	1730806396; bh=ksrPtv1cn0BDMYImo1s38QTqZWd8KN7XrbzNCEBCLxE=; b=T
	FqPGglErQDyr0p5ZVVxB8UWRGJZzVgEI7dSVMdaNTF0As/fzf0QbehdD09ZXYGnL
	/C2ZeadHsHiV/IPNx7PSwwVBqyNF0qhd0bMy2HBZE0V+6f3pNA7iq8HUb2KthsTC
	Rwz+0Z1fDUwFuA+4niUmD3ctgcW5Kw67bqIilrpn6ijGw6Hoalkr8Kr8Ikrfcwu3
	3wS6RpBxqbU0lkZvgYES2LGQb+zbZhwEza/LVKc1mN3qorOuaLFqr9ga28rLE5bN
	ney41gYtfmYvLjYHjIXyg5Bkk218gR9EUim494PD71lsqpdd+pja9hkULpitnt9Y
	SD3yEgV7JJfn+l6SHKVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730802796; x=1730806396; bh=ksrPtv1cn0BDMYImo1s38QTqZWd8KN7Xrbz
	NCEBCLxE=; b=CtPLr8LCR8ikr7dexppx3bsbUINzfoAtn77FiU0XjYnjTF6+5aU
	eVpHEyeSjMTN87lTN+Bz+5STceKkPRQ1LQrP0pARvlq+7NrMCCEDjMrvJ0WYQm1Z
	zGXA3FZwm/ve11fDPvkVFsbmkuxbdQjId1vk1l1s0gd0RuVnjJ7PCI+w9+qOzOqT
	hi6SO1f5OfB1j21pbNFVyL00sfAubaO01kn00+z7jQOxtZhnNSKVb3Fs1m9kBbcT
	RDRsskv+9WSMEAfzdnbVi3vwUtwxQ+CvLo8rX1d/wvc6UASjaZz772nBS53rrazt
	cp3aSdSs8NDVtZS5pvaFAjVhG3FV5ug+vdg==
X-ME-Sender: <xms:a_QpZ-qwHNgvwEmwf2E-jbglVfzrqlkfR2dR31HE-l1_nE2HWnHfVA>
    <xme:a_QpZ8qr1xb7EQiWmJkRpcHeOMmceHAwjKsOiwu9L9dgTINiPlhblxAWPE3_NfTHS
    40qtx9zEcENqpBIknI>
X-ME-Received: <xmr:a_QpZzP5w__pBpiibWXen8l4jMf6QA6HjJoMbY0DSR0pNpeYBjEx8-b0CnSK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhh
    uhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a_QpZ95YPDJtFYxd3b57wAP2R6H7ILDGpsIy-uxcDjcu59zCLVVWiw>
    <xmx:a_QpZ94OdUjhDZkMDczs9rTRiF9ZpXxGiY_6HIOzrLcEDdpofncLLA>
    <xmx:a_QpZ9hkwb5n-GHdSJzVOrulLOrLw5Oug5kpcbPAtHlyHL6VU2l8kA>
    <xmx:a_QpZ36Rr7J917ydWWbVwFC0J5IzbPRecknMZ-Q0z0M055_ENYdnWQ>
    <xmx:bPQpZ3uUf7vgecT1p7JbNZUSKeoetUzK2Yt6CEflq63FVlcAxbwUhCxq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 05:33:15 -0500 (EST)
Date: Tue, 5 Nov 2024 11:33:13 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 20/23] ovpn: kill key and notify userspace
 in case of IV exhaustion
Message-ID: <Zyn0aYyPVaaQJg3r@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-20-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-20-de4698c73a25@openvpn.net>

2024-10-29, 11:47:33 +0100, Antonio Quartulli wrote:
> +int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
> +{
[...]
> +
> +	nla_nest_end(msg, k_attr);
> +	genlmsg_end(msg, hdr);
> +
> +	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
> +				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
> +

Is openvpn meant to support moving the device to a different netns? In
that case I'm not sure the netns the ovpn netdevice is in is the right
one, the userspace client will be in the encap socket's netns instead
of the netdevice's?

(same thing in the next patch)

-- 
Sabrina

