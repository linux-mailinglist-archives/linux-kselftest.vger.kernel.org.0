Return-Path: <linux-kselftest+bounces-46653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C869C8EC66
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E053ABA9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A03328B73;
	Thu, 27 Nov 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bLzEP1Xp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OeWgNI6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95411CBA;
	Thu, 27 Nov 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254076; cv=none; b=pirjLS5bQVnlFAHjC65e0GE9VLuqQXW513FnzVizF+vPCtc5sIJuB7AJjMSXIUAsd7pZwlBT3Tygj0kiGmrfpbhu1k/tzxlfHVErhWiLZiiAPq82i8sXYe5K+hYyNN2ooOMgSy6neyPpVI2Ilr1vPfDMDZDCcWDuLkQynlPPwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254076; c=relaxed/simple;
	bh=/ADRS2Syjol7k1tms1MXqhOe7X8+moGHAlbEFE5n85o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnfeMxO60viymTT4aKbIW2PZYyZIfMoJaoM1y6qKQEo4jGPisacSEGurfQ3G1Kmto5JgHJDIvqKpZ498sG/z3RUO88ZVdUhUKJh6+CXeCoDRHbyGtzgt3mPxxrSqlvNkVQer2cUuNdEA0RVWw9n2rIdyNoU8M/ZQEMrUCPv6v+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bLzEP1Xp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OeWgNI6O; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48C8414001DA;
	Thu, 27 Nov 2025 09:34:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 09:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764254072; x=
	1764340472; bh=XVCU+8u6WBdn6tCaDdY+B4uGVoYEEaJVi7u1cDaBD7w=; b=b
	LzEP1XpFNQGBxcjcvWfb4u5CBzusR6Okcfy84e4OsXmUTqfWDQ5T3z6bcayVQYgD
	uDyFIAQUh2P8Q+Q8iFdZB0QLcajYFOw12z3f8I1/Ytd3pUGFP5WaUInc9rUalrE5
	WYQ92ju2tjh5SJAqxugm1Z48NwTifcbFV0NHsBIO6Ec2l9HCn+pifngcvxpwkQvW
	wcQHX9jCo9Jn9z1OcmdQtnBAFKq23PfUIsx23rFG+H3ZMp1iR87bdoDY8bEMZwUx
	2hzVJcoNtzK5pEnofahSJanw0fw/ud/HK6hwSNJ0tmRwk0cdUW5CcC3JWpnt+/Lx
	QQzEhFMhDxhwXOjZJ6NvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764254072; x=1764340472; bh=XVCU+8u6WBdn6tCaDdY+B4uGVoYEEaJVi7u
	1cDaBD7w=; b=OeWgNI6OTYGehnLJjrf6pFS0xmCP7ZcxPXToOWdt/irsh8fxoOV
	f20akD0+zDOd/ViMBhSOCfcTkBllo3O2eQW1dMYO618WRxJDheC78mV0vVh8AGx2
	bu6jxoZACVkRRYL58xbEe/Tarf7J6U4JT5qgOgWgDJMXtNoaKvgl6ndNBa4bpYNr
	F3Lu4DQGu0q2sryEebEfVZ9sOklS4HoT5j7VjhEnRWl7Y0rQ1b6VzSODz+X8hTBY
	g8iOXVUeK1nXp7Pw15fWoMsmeDhfAfPg9Tf2+QjnnJbuiIsoWiyMrQDe5yLXTW0g
	eV5Qh0m1q0VI4rPuCwTylg3OGeX4ipCv04A==
X-ME-Sender: <xms:d2EoaQ6tHJ-E-fGaI24KJxMHN8CLrsmdblv1BnE-ZhEOn3YggAlfUA>
    <xme:d2EoabOyhRORhGwefl_xFRBSFute_ico9hCZ75KI9QVX82UWMiXBCj_pHzxPa9lrt
    S1H-ceCxc5Pgv0-Pv0S5TxRuOEtBLwoxM_NUYRJnt3gRYWSIrWLUmM>
X-ME-Received: <xmr:d2EoaWu388tGh5b4Pb14VWDjHifl_VLKf2u7kgP9jxTsZHxqkoIySdijYzgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:d2EoaWZZYz12e28m_a7hCERZsE0Kp8VI-aRVVjsLNIJRu0Ed_AiQQA>
    <xmx:d2EoaQwrr1H6jlmCklfYSurevS5zn9GDdRGc1kMJJQRyUObXQUnOng>
    <xmx:d2EoaWggID6wW1OJynHwPWHXO2fW-5hXKbmRHWw6RFDdIXBw128A8A>
    <xmx:d2EoaUkY70uvFPQpmxtMfDP8B5W-UBh2h6JfkUefldzDDaeufAsw4w>
    <xmx:eGEoafxG5Y08_oUhFXky9SPmoJDdntczFrI-xh0xPxIomwg_KUau1KN9>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 09:34:31 -0500 (EST)
Date: Thu, 27 Nov 2025 15:34:29 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC net-next 13/13] selftests: ovpn: add test for bound address
Message-ID: <aShhdULYMt58e2_B@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-14-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121002044.16071-14-antonio@openvpn.net>

2025-11-21, 01:20:44 +0100, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> Add a selftest to verify that when a socket is bound to a local address,
> UDP traffic from ovpn is correctly routed through that address.
> 
> This test extends test-bind.sh by binding to the addresses on each veth
> pair and uses tcpdump to confirm that traffic flows as expected.

Same as the other bind scenario, the test works even if we don't bind
to that address.


A few small comments on the implementation:

> @@ -547,45 +518,83 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
>  		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx->bind_dev,
>  			       strlen(ctx->bind_dev) + 1) != 0) {
>  			perror("setsockopt for SO_BINDTODEVICE");
> -			return -1;
> +			goto close;

ret isn't reset here, ovpn_socket will return a stale value.

>  		}
>  	}
>  
> -	ret = bind(s, (struct sockaddr *)&local_sock, sock_len);
> -	if (ret < 0) {
> -		perror("cannot bind socket");
> -		goto err_socket;
> +	return s;
> +close:
> +	close(s);
> +	return ret;
> +}
> +
[...]
> @@ -2221,6 +2228,9 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
>  
>  		ovpn->sa_family = AF_INET;
>  
> +		ovpn->laddr = NULL;
> +		ovpn->lport = "1";

Why do we want lport=1 on the CONNECT side now?

> +
>  		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5], argv[6],
>  					  NULL);
>  		if (ret < 0) {

-- 
Sabrina

