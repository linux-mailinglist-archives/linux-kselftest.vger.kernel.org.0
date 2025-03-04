Return-Path: <linux-kselftest+bounces-28209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471EA4E126
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44087A31E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE425D215;
	Tue,  4 Mar 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VuNzS7MB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uhv181ey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C226E169;
	Tue,  4 Mar 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098932; cv=none; b=XpD0Eahmcgp4BgJPPqL/Fba5xMe3lOdTs194SU4eaTHq8ZLOX4XWGqx4D/L7nqeBRsLZZpzKBBLpa6RfX4Mz5tcjecolr22rJWFEXIymgOkLMFCwh9R5vQBuSdTCHrTCbDKhcQXoBV6zeiWNGHOG5EPmHsHwCUk2+uMtFvl+44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098932; c=relaxed/simple;
	bh=YMy5gkaueEQktqoKVHPtEIDeqrmLdBspWegegQlhlwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVJkfK9I6myaU27z/BpAvz7MLYFXiMVIZhosNsRT0P65VDbLpMKw9qzgH79JZM7UEmBTBuZj79st8UZiyjwqnLy23wuUkNUrRH9fRdxi+2gI3cFVqplBSeM35WTeIGU4ZnPOvVYTdrxP6WwrzbrfGXI/DV4pHA75ygrH2YJ/N98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VuNzS7MB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uhv181ey; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3253B11400BC;
	Tue,  4 Mar 2025 09:35:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 04 Mar 2025 09:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741098928; x=
	1741185328; bh=wRZRNLutIoBb8oF0ngDTZPa0vNaZ5AVJbj6GM4zyYs0=; b=V
	uNzS7MBwuIfKhW8lgt3WmAlh/dEDeB9BAEpXZA0kq/kFyXTEQ6e3Eb0OYf4sbv6j
	1XQ5JUrSGlkB28TpkUxvizOi1rwa3CSZeoxTPiGLtltlmk6DbpaVaCsH761tWRvy
	64PByEuc4xFsKng3HBimzgv0xeTIGQ1RyqsJslnlRwCihmW6uzw22sMPgbD5BUdI
	EwMvaf/uMGhP0Yfu6VMZcLGezNlE0r8W3yBweAJmDVr0FT5m/DJ/fVTqGnMMuh+J
	P/6/I5QQCVJWUhwPOAiYhdggrTgYu3aowRT/n1vtWTLTyp4fuDe2Z0A+ybjSDR7w
	oGPnBTKUz7rZexUCPWMqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741098928; x=1741185328; bh=wRZRNLutIoBb8oF0ngDTZPa0vNaZ5AVJbj6
	GM4zyYs0=; b=uhv181eyF6LArvZTYb+QgVT4sGvPPkZCDqtMihzV3VZ1ZXhhGyV
	p4YSj6jJ9XamrqG+UFCxH0oaL9qc2gw7vHZElq9Yue6TRERldW6pLnVGuDGpHb0i
	fKYs8We9FotWJdvw/CoWosjlT3I/gieIGVQ4/Eq8O8TIDmiTuSyiTNR02n/jcD0s
	VRb/EE36pJwO8LzBgTiQgXcA501/7tDDa1/PRoKRyhD+dfoAZfWVIOK6nQTrwWiW
	1FINh9L1G6i9vox5bpO0vPzNBVsdLZ+XuirVPvn0Ekr7nfsQ6qnFgdn1BgUFYhDz
	3KhrX2MiQSHKfpSTbPO4oVgdEjp3LCF0uaA==
X-ME-Sender: <xms:rw_HZ0yOSUDvbujyVfQwEGipbyNwKEa-3YlwR4nAaZKQf6SNKDAcPQ>
    <xme:rw_HZ4T6L9OyXdwzg29l8jZayeMWhr_wqyhMtNVWZ9S7mJojGka83Mtzb3sQPl687
    dIYXMZNzOm2AdghMiw>
X-ME-Received: <xmr:rw_HZ2WakGeJ-7hOIfr5eiL_vUYvmz1lK-d1_9Qld-U7PU1Wm8vz4ryZw9Ol>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvfedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rw_HZyjnRzMpCPET0Wf_HyOZ7PAV7OQyX2bABphrYL7SiS0-uaAn1A>
    <xmx:rw_HZ2Agb3RXYN6qnR7-G0xL2-kTG2msyZxIup5-PvdhJZVpypoozA>
    <xmx:rw_HZzKlzQPdAt8Rbp9jcErn-vs5qMD8RAIubDGwCCZwCXaCW-jOFw>
    <xmx:rw_HZ9DTr3nx2qlyFXlQdZ0m9Br1gKwapkEoKGpg2bjO-snTP11DgQ>
    <xmx:sA_HZywrZwyOiY_19rSz2RZ2nE-bBI55aqdOZKkchKu2upcW8fp1Z7t0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 09:35:27 -0500 (EST)
Date: Tue, 4 Mar 2025 15:35:25 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH v21 19/24] ovpn: implement peer add/get/dump/delete via
 netlink
Message-ID: <Z8cPrYs0TuQfLlKX@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-19-d3cbb74bb581@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-b4-ovpn-tmp-v21-19-d3cbb74bb581@openvpn.net>

2025-03-04, 01:33:49 +0100, Antonio Quartulli wrote:
> @@ -1317,11 +1336,16 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>  
>  	/* prevent rearming if the interface is being destroyed */
>  	if (next_run > 0 && ovpn->registered) {
> +		time64_t delta = next_run - now;
> +
>  		netdev_dbg(ovpn->dev,
>  			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
> -			   next_run, now, next_run - now);
> +			   next_run, now, delta > 0 ? delta : 0);
> +		/* due to the waiting above, the next_run deadline may have
> +		 * passed: in this case we reschedule the worker immediately
> +		 */

I don't understand this bit. I don't see what waiting you're refering
to (in particular within this patch), and I don't see how we could get
next_run < now based on how next_run is computed in
ovpn_peer_keepalive_work_single (next_run1/next_run2 is always set to
now + X or something that we just tested to be > now).

Am I missing something?

>  		schedule_delayed_work(&ovpn->keepalive_work,
> -				      (next_run - now) * HZ);
> +				      delta * HZ > 0 ? delta * HZ : 0);
>  	}
>  	unlock_ovpn(ovpn, &release_list);
>  }

-- 
Sabrina

