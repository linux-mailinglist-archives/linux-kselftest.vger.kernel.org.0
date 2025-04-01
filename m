Return-Path: <linux-kselftest+bounces-29976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BE7A77819
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE573A9D42
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3431EFFA5;
	Tue,  1 Apr 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="el+KQqGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVPxvNOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A431EBA18;
	Tue,  1 Apr 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500862; cv=none; b=fDOSHYtwWmNkP6qJEZfBr0c+wGwfN3KzZhiZTGogeAyR4I1dhl1pIT1XprCpTEIttRiy90AKE+fq4Im9aiX8QPFfXiUDpxrXhEeQvF00vw+2mmPXVRtnFWAgW01oIiJZbil7+6uklRlBc0aNZjYFsjA8i1e6GIJ8cNRfa8REU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500862; c=relaxed/simple;
	bh=Oq4UD7M7rpIz1JOt7t/Ky6BCVrtOWkTD4VAymSw+Zzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntqrFZBk4tcUXS+cMMvXXAZFFsNyxhNR4Aook6QzmYLLYwsgeZORhVFZCz6OUDGkWnT81OdhwNRRLTcdo3NVIev4swAUrbZUYZR9sUX/ZPPWXLYHPwvF5zKQEU/F7+/vTIZvfibVoU75KUPvE4Td/CHPGPBN3+rTxjpveQDfgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=el+KQqGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rVPxvNOK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7A3225400FC;
	Tue,  1 Apr 2025 05:47:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Apr 2025 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743500857; x=
	1743587257; bh=LX2VOa6a+rqcrVDRdHAUo6T6ZWLPchkpoYAJ/v3LLHQ=; b=e
	l+KQqGBBgubJbYPXMJcTPCuL8peOuasooTRfP124GoTCPfCFetlH84QplV/QRXty
	f3rOvX0z9HYBQdgO9scKTtyET+lnRIbnxGVHVzISacjg3OQwwyQ4ZJMvfPArni4S
	koNVHo25SwMZUSpYPz1ADY8l1yxqnGJmHT5Y3FL/iM4mDNIUDV8L8DgXHihGm248
	/KJJXUVGy69cRDM8He/hDZPVVbCw8Ruv2b1fwMGlxJYRf4jKeKiVCB7U+s4YVSsQ
	EA/nVAK3WpqtNImy9SGGZiRB7HSp3/BimPGMSN4Du0/KtKglLTboLFRbpIlXxnqc
	0smk+l9vcdkU9aBprYgmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743500857; x=1743587257; bh=LX2VOa6a+rqcrVDRdHAUo6T6ZWLPchkpoYA
	J/v3LLHQ=; b=rVPxvNOKOJ5BQWy82PVDruR/6JDCePlIW271jRPhyJxvBN/vVW9
	LwLT8kiAGQKo2rIoTNeoGK/K0zjOq79m+xXcMZEuuOMFour4epxKHkWHKtc/VaDK
	H/MAqfBTaiLWg0CrfugZt0EVDaKDnaCbzmlGjp6ISX7oKYbjGN+t8sSo/Yih+ppa
	e1c30oBTilgpmEeJAS34b6i+2OVb/pcDWtu26+GPkllYYisHNdMggojIbaSwSB7k
	FBzmSvAXlNT24b2piyM6z66BpIS4dGb0q4r0lHJSZ+9CZSc0EfJ5RlOajKMCmOIO
	tVjDFtrGMkD8aqzmhTkL0+j9TmEiKtwjl6w==
X-ME-Sender: <xms:OLbrZ-8FltgnLSgnUcrXT1iuwilvO4ZzjYEwX9YbUUu5OZhoV3iI9g>
    <xme:OLbrZ-tcfwMlRv9aAV8Vkbtq3Jp_q69FQ_xK3GviU3mjRzkSH5K0C6LdXZJ1yfVEf
    lJWJ-JDers5ufUDb1o>
X-ME-Received: <xmr:OLbrZ0AKulR1iQ--pYb8XRZW8YM7VtzQGAfVIJ8DtiO7tlVaDdihtXoDLziE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvgeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OLbrZ2dJT3CQ5B-nZ8o_i1VW2PcfDfEqMAUaIOTM65qbjrkBHWq89g>
    <xmx:OLbrZzOP7EazZ4o9I65YgueeibTNDUNNWA9FB7tciQzlZ6B-RLvoYA>
    <xmx:OLbrZwlnS3lk-H9FWrrmFSTGMBxeWPZ3YHqmIyU0QKDg5240oc7HWA>
    <xmx:OLbrZ1uGlqDTVoMGqlD_89LeG5SMb0HC67pjgRU645D8PECci686gQ>
    <xmx:ObbrZxs8AqTtRy5em0Dca_8BZMZWtSGMI1ujgNljGm25PHBWR9LFE9VQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 05:47:36 -0400 (EDT)
Date: Tue, 1 Apr 2025 11:47:34 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 08/23] ovpn: implement basic RX path (UDP)
Message-ID: <Z-u2NqykODnOrEgl@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-8-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-8-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:43 +0100, Antonio Quartulli wrote:
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 024458ef163c9e24dfb37aea2690b2030f6a0fbc..b30175e34230d3dbf5d253838df894f0625c705c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1933,6 +1933,7 @@ struct proto udpv6_prot = {
>  	.h.udp_table		= NULL,
>  	.diag_destroy		= udp_abort,
>  };
> +EXPORT_SYMBOL_GPL(udpv6_prot);

This is not needed anymore.

-- 
Sabrina

