Return-Path: <linux-kselftest+bounces-29985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2ECA77BA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 15:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F09C3ABD25
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB02036E1;
	Tue,  1 Apr 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="b+nHgLwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6p8nPEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C520127D;
	Tue,  1 Apr 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512733; cv=none; b=sm1NxuFlrpQzFGYz8wTvvbRhanXwZZ0dJR5nkf8v5NcdeWDDhRA239jz7UjAbix7edB7psr9CKDIzasaG/gicd5ehUA2JX9o52GACnV1HMKj5OcNhQiYqVs7P5V+ec10V3o7juCp1W64BEtKggAJ2lJSiJdY1dUwfj0EUBdY3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512733; c=relaxed/simple;
	bh=68g1dwxubK/qOagQYfmF+/7yRupBhMvJ/WhIYkafHTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWIesTXhWkkCpvgNr6lUtp2nGpPL0N+a03hLR8Vk9lRmA1DaoWFPXy30TgHjJ08sUHp59ecdCoXkfRGtfwKS/xDl6eAwyDMui2k7Ko+L5zLjZrKJUxzYLO/CsgHNKbSHAGVOqRTvunTLaZhJFsZpVeARN8UoTz7vN1wCtLeq1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=b+nHgLwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6p8nPEH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id E803811401B2;
	Tue,  1 Apr 2025 09:05:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Tue, 01 Apr 2025 09:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743512729; x=
	1743599129; bh=7dX1gNT+/GJ5Ayv5rUNeFUzBzq39S0of/HzEkJa1y/g=; b=b
	+nHgLwZ6xWFlhNWUsHfjvlTv60SHG/XB1HA/l1REtXULj23c19fQfmUBMSqqwwP5
	Ye9o8WdxvirZdvtVF96RJZt3rXnFilT4pwFr3IGMipn7qmohD7siKLkUAzEgaflA
	LdHW0+ZbAZB+XrAC6Gb+iLRjLNAEnCJAE2OOWtMEeFjheSZk7fYbWYKRZHL5Xk+C
	EKJXAtSgMYNIGuqiywRfO/Xy15MItymOC2PN9Uv7lInl/t1w/y/9Un/ig+kKBPPF
	F8QCVyVk/5f10QVJQXeQjtA85drV3DCAHlQneFZr02va1D7MJ3JhfOHItKwt+AYB
	EZEpwLkzgdjb6EbPkFFHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743512729; x=1743599129; bh=7dX1gNT+/GJ5Ayv5rUNeFUzBzq39S0of/Hz
	EkJa1y/g=; b=F6p8nPEHR5UXbZ40y7SPpxMiS2jUW5unEFtP3wrwKy2WNCWdFH9
	o+EjG1jjWsGP9cH3Pe4ELRpSLa8t/DPK3X8f+UmaGxSvtHHqNgEPn6bPJ/1zUyVT
	1EOFMrRMVKmBWqQJFHrZYe15sSfk7WNk9kaqBfa7D6+QwNUFf0EUEc4TLjx/B8u4
	em+aUv4aaciqbLxTOirPovTAXEG1a8x6SFW+9nkNFnvnB272AMPpxl76R/pifvjd
	rwuQiNfS/qNEhPRLTlFFwuefgwD6GlH2SBGBzxVf8cWEWXNEqGjxtU0+gu2WndPX
	9oYlpGRbaq/Cp8Uiv+Si0SUsp3LLp+kEfMQ==
X-ME-Sender: <xms:meTrZ0VdFfDtmGdHbQ3kCC9QOvAWp8k6HK1Ku_iUKfV_J9jM2hAzEw>
    <xme:meTrZ4nQdoRh2fdUTskeBPsv0kQubBAANvw7n-8Qceq1evdd6u7sbZHEcmeU3QU1F
    o5cp8gIvoELLGvJADg>
X-ME-Received: <xmr:meTrZ4Y4nilMhRYVyjDNFQIC6SEDcL5Xq1lJecgHd4wJJf8ugqfc5zdW7x_R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:meTrZzXhkXPrl5iRUPISqDTst60Zo5F4z2ll2ZjHG1mKL5sZm1yupQ>
    <xmx:meTrZ-lFkhS6wNkpGWyfHTMy8gmlvQBxauToBVV2CUrldJ0ohl9xmw>
    <xmx:meTrZ4e2yS6VcRZAjicLAYOIeS47ZytIWhcXVg4OvYhHjpMpRnNjdA>
    <xmx:meTrZwGT8e6Na3qC6Ruq7-2zH9wUvgfU57pI7pe-feixhWoCQd_EmQ>
    <xmx:meTrZ6mW5ufr7w-ukq-jpGEbP-qTXLaA0HEbVLaiXsHiXUaw0n_udppE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 09:05:28 -0400 (EDT)
Date: Tue, 1 Apr 2025 15:05:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v24 06/23] ovpn: introduce the ovpn_socket object
Message-ID: <Z-vkl4NqfrkoJn-l@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-6-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-6-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:41 +0100, Antonio Quartulli wrote:
> +void ovpn_socket_release(struct ovpn_peer *peer)
> +{
> +	struct ovpn_socket *sock;
> +
> +	might_sleep();
> +
> +	/* release may be invoked after socket was detached */
> +	rcu_read_lock();
> +	sock = rcu_dereference_protected(peer->sock, true);
> +	if (!sock) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	rcu_assign_pointer(peer->sock, NULL);

minor nit: that could be rcu_replace_pointer instead of rcu_deref + rcu_assign_pointer

(and I don't think the rcu_read_lock does much here)

-- 
Sabrina

