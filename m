Return-Path: <linux-kselftest+bounces-40928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A1B488A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A3E3C449D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864AB2E9ED4;
	Mon,  8 Sep 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dyJGfsHt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIoj4X1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190029ACD7;
	Mon,  8 Sep 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324188; cv=none; b=oqOAPAcdGHWgZ/JxbR81xuGCWaX0LwXurmwxLKEcMuwbEWdjQXvDxOSfMjQeEVkWStL49265fV9wzeR7fxq0tInHZ83iN8Fy0D/zheMElQOSGveAO4NNVH9uTtz3AzdrsEt1jVU1C2zSWKpUfJyUVz27ZR93HUPlGcDdnVeR68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324188; c=relaxed/simple;
	bh=L35F8WHY9n0Vw/BUZevuTaPBgflUiN58uOkSnItcneo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGdYtn7HShybqHtihEIaytS/W1VHSYZ3eTHwhWz5ylATp1uUf3EWJ6q6PUZ0Zb3ZTRBxiB+AsksHV1dRxQW3EJME6+DOk++Fqh3eIxidNS3eRsaM1WksVXVOxHDTnKOSdhH891fIo5UTqyZ1IarV1inuEMhdxf+c3x/ETAUOE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dyJGfsHt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIoj4X1e; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DA937A0114;
	Mon,  8 Sep 2025 05:36:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 05:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757324184; x=
	1757410584; bh=yvL6Q1QOGKfSbFNCoqV7sDTrCKni+M0gmt9O7GiKe9Q=; b=d
	yJGfsHtohz/M4X30wK5ItG9Xg31T4XKM6mAKy3dYTwjekjAz2s5Nr4qDcMz5R3vW
	1UMu5wlW/RZ8/3AGqkjmX7RlzipeAVu07A6bDd7TBUPRtJnh5IgksIMCo9bgVg3M
	ZVckP6boNZOm8YBdgspxlIDW7BpwVhqv1dWyrSI8VTfc+flhYoJ1hko2QyW0Hrt0
	cf7X9crD2ChfdzPvvC5uoQcdn+q0BSBe3PbVEd9oHMCY050/md/Dly8kvIaVvOSV
	C9VGxVluebv3QGg5TirkX2qQDLMNO1/PJ4fbVHxA19unKIHeFutdDsylVuUPURYl
	YkH+CEhE/psg+g4lMvR5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757324184; x=1757410584; bh=yvL6Q1QOGKfSbFNCoqV7sDTrCKni+M0gmt9
	O7GiKe9Q=; b=NIoj4X1eN40WQ3NiJMvwmtT502t7TG+E9WOmMS0Rr3qxGuSOig7
	1iBsCJuA4EMj0k3XISF3g8vQ+o2cmojwia59XWQZSCWn2gP0PeAjNcRkgcnZprxc
	ruv/4W833+RoCnZz65wNjbS7abak9L3D0C/DyZ+ddOZrl5goOg7/iVG35zNgeFbF
	+myZocoM7jHrHqugk/2s2yil4WoZtoRW2mrf8UeLEwP/HP2KxoCwI+ZVcVh6CYTo
	7EE+XVY/gvTSWnmaxnNd2yetStHGdNpeS0kHMycSMQMNlp3BHE+NFwayZHcIWt0M
	h8xubIvAnAWmStY5ydZZi/uDT9rS0BVWoGA==
X-ME-Sender: <xms:l6O-aIHOQDmRl3YMOaICkkXYQQWL_xVFM8Iu6qxvBj45LncQ-3ACPg>
    <xme:l6O-aLmFy-M-wDlaw1AGX9IBKEX2HCix2O-in35fJqxQLN9RnzIYSgMalTGtpj5m6
    VZWQGZguU_peMcsm8Q>
X-ME-Received: <xmr:l6O-aHnBgCk5eUAcZQwbWaQArMDK0bCYRHnIFk4KwS9P4NkEydPfxjiflzmf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvhesjhhvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruh
    hs
X-ME-Proxy: <xmx:l6O-aAU20O1tcsBm3zjV4GMERzUrVsyhsyxCufGu9KwapblEr3wG8g>
    <xmx:l6O-aF8V5tZkEDNKUA0dc0WxnH7VG5qFfMGH_kcr7OvaCgEdcZKmgA>
    <xmx:l6O-aNoydeg66V0NWnaqy1kfrPSJVX-arwQnf2Uveo2TCHgY6ShviA>
    <xmx:l6O-aHk5hTZVAPIcUuXt3hxiJKeI6P3VYNzDHq9DPFSIcHXon5E2ww>
    <xmx:mKO-aO6NuqyEoCod_csBglj9FSy_T6wGLhuVL13WC8_WL5FlcGYjwgxO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:36:22 -0400 (EDT)
Date: Mon, 8 Sep 2025 11:36:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aL6jlYPhsPfDKT8C@krikkit>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
 <aL5YamjbZB5gsL30@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aL5YamjbZB5gsL30@fedora>

2025-09-08, 04:15:38 +0000, Hangbin Liu wrote:
> On Sat, Sep 06, 2025 at 11:30:58PM +0200, Sabrina Dubroca wrote:
> > > +check_xfrm()
> > > +{
> > > +	local dev=$1
> > > +	local src=192.0.2.1
> > > +	local dst=192.0.2.2
> > > +	local key="0x3132333435363738393031323334353664636261"
> > > +
> > > +	RET=0
> > > +
> > > +	ip -n "$ns" xfrm state flush
> > > +	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
> > > +		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
> > > +		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out
> > 
> > It's maybe not something you would expect, but this codepath will not
> > check that NETIF_F_HW_ESP is set on $dev (you can verify that by
> > running "ip xfrm state add ... offload ..." on the same bond+netdevsim
> > combination before/after toggling esp-hw-offload on/off for the
> > bond). Why not use __check_offload again for this feature?
> 
> The esp-hw-offload is fixed on netdevsim
> 
> # ethtool -k eni0np1 | grep -i esp-hw-offload
> esp-hw-offload: on [fixed]
> 
> There is no way to disable it.

I don't think this is intentional. nsim_ipsec_init only adds
NSIM_ESP_FEATURES to ->features but not to ->hw_features, but I think
it was just forgotten. I added a few in 494bd83bb519 ("netdevsim: add
more hw_features"), extending nsim_ipsec_init (and nsim_macsec_init
since I made the same mistake) to also add features to ->hw_features
would make sense to me.


> After we add the netdevsim to bond,
> the bond also shows "esp-hw-offload off" as the flag is inherit
> in dev->hw_enc_features, not dev->features.

Did you mean dev->hw_features?

> It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
> is try set xfrm offload. As

Was this test meant to check hw_enc_features?

To check hw_enc_features, I think the only way would be sending GSO
packets, since it's only used in those situations.


> static int xfrm_api_check(struct net_device *dev)
> {

But this doesn't get called when creating a new xfrm state. Trying to
create a new offloaded xfrm state doesn't look at any of the
netdev->*features (and we can't change that behavior anymore).

xfrm_api_check only gets called for NETDEV_REGISTER/NETDEV_FEAT_CHANGE
to validate whether the netdevice is set up correctly.

> #ifdef CONFIG_XFRM_OFFLOAD
>         if ((dev->features & NETIF_F_HW_ESP_TX_CSUM) &&
>             !(dev->features & NETIF_F_HW_ESP))
>                 return NOTIFY_BAD;
> 
>         if ((dev->features & NETIF_F_HW_ESP) &&
>             (!(dev->xfrmdev_ops &&
>                dev->xfrmdev_ops->xdo_dev_state_add &&
>                dev->xfrmdev_ops->xdo_dev_state_delete)))
>                 return NOTIFY_BAD;
> 
> Please correct me if I made any mistake.
> 
> Thanks
> Hangbin

-- 
Sabrina

