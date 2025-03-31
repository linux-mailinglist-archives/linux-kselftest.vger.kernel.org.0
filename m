Return-Path: <linux-kselftest+bounces-29952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3826A76953
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 17:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C03AFA25
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D42221DAD;
	Mon, 31 Mar 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bFaJhGk1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpFJh1rX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589F2163BD;
	Mon, 31 Mar 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432440; cv=none; b=H7YpeBQ5vWyPltedFFrbTj/z6IEOQoVbSpEv4/TJ0vPBU/wdHTsV0O5NSNbXr7ektqT/7+BKuHuuU6tcyRtcSPTNaXX3BahXz+INmEedSbTIGj/LifcXagl5PB82TmGzXP/vRNs0W+LnWxsnOqPQq1/L4Eu0lBX5Eg/EygebQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432440; c=relaxed/simple;
	bh=O/9fTspNTdIHvOEANop/UpL0WNKbeSl7SXNAq+SBv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPqzIT3Wj84r3HU+9rsLiI0E8XSlKwL5tS4xAEtlbDFgZhJhUuAQ8m+Eosadp53Zfg+NeyiRCV5Q30hD0ZtAJRkBpynayJClh6oSgroSWaaz7L4o2bVq9w8nD8WuO5FrbTTBqFVzMtrwIy+aRz0ukRAYADqoxmWc8etp8TdciPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bFaJhGk1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpFJh1rX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F419911400CE;
	Mon, 31 Mar 2025 10:47:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Mar 2025 10:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743432435; x=
	1743518835; bh=OFdJhOTwQCjtFW79ikh9RA6LiABUkfS8zj5b9DPqql4=; b=b
	FaJhGk1gZiFCmGRkYhco9D+iccIKGCgqHX/elzeUpvKPsqyDfhGfVlMgCmTAtMtt
	j8Xd6U6DPugsyuz7abv6PWfvnxrUQ9Ns2JdWF40WBmoxx7QpQrW7+ZcyUHQ3l8fK
	jSLe1kx+wYJtzFTQ/lZqbC3o31Vr2zvlkYqmcTRYfDVLHEKesNFTYX0iqYnfYLea
	8wd7ZNFKmMQK1H9Fcdsoow/1hQM8bI//gbFwYv2RgtOM2K+W6Nhi8Qrxcp8BZZoR
	sNidzXeNSjNqZ7fOTbe2yJrigjyjav3tgZYllZdRlv/yR39D8q/oF/eHKlPC/LYU
	tzSfBcm15FO0UqYD3k2HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743432435; x=1743518835; bh=OFdJhOTwQCjtFW79ikh9RA6LiABUkfS8zj5
	b9DPqql4=; b=GpFJh1rXy8WkOfA6zJgStrzEWqctmdccAN57Og2s4x8pp1vK01E
	ueu0cII/Kp8nV1M8AHGMarIv4jSZ2fkPEZDeNMi/lDyNSfgHQOxzoO6dTGvS6tJN
	13pGtJsaIYoldf56vAj1gpisHEbot6atzTED2MAfP47tProAiVAJg1/AwsgwnCkU
	aFoY1nVywJF4ywo3qOvQNVtVCqUR/TwLcu/PPYfvr/fszajGv1QEKwRbRt1hhk1A
	ngqNKR7mGBv1B3Qdl6fPHUF60vvtMKRib/Lm1XxvAKuVisSe0pYc94KneHKaSq89
	HWidXfM6Nd1By8hGYmlKKOPmej+cZO2Nxvw==
X-ME-Sender: <xms:86rqZ3iXvxTLML56UriXPkMcH6t7BdmCBlVD15UIiNuj_z0Pk0xgYA>
    <xme:86rqZ0BqP_LOZ_qkYpFEb0orFnsU9X44nI9j1xsJqwRlUPEE8M2PWYaL7r30kECNW
    oarqOJLeYegQIpJmnw>
X-ME-Received: <xmr:86rqZ3EV1ohOvphqIkgf0WE8f1gq9g-FH-qeL5ius8rWmMTQcpjPfA9UG0TU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehhohhrmhhssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhrgifrdhlvghonhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdr
    tghomhdprhgtphhtthhopegrnhhtohhnhidrrghnthhonhihsehsvggtuhhnvghtrdgtoh
    hmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:86rqZ0QTeqHpyLmXavyJ0Ma9h1mXiuo1TArAJ1Rc1_ebVv3NHzwAdg>
    <xmx:86rqZ0wQPWVrMo1lmgfo8hqofzglGBEGfK8JrpF_UQ7kxsFTOMfPuA>
    <xmx:86rqZ67UmmbqNbmuuvIUrkeliSvEXiUw9umC9K61z3fnKidkApZXaw>
    <xmx:86rqZ5xzBjIdX5RgEv3llwe686u4N7LH0IdzaINNb4N2fh4Wji3HkA>
    <xmx:86rqZxHw-VS_6bRV1GBIRr5ZtjVoyHZ_FZUzH1UGregcnmXowCj6zZqx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 10:47:14 -0400 (EDT)
Date: Mon, 31 Mar 2025 16:47:13 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	steffen.klassert@secunet.com, antony.antony@secunet.com,
	willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v24 00/23] Introducing OpenVPN Data Channel
 Offload
Message-ID: <Z-qq8WeQr84M5s7A@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <8e64c910-ee4d-4875-8034-927e1073ae4b@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e64c910-ee4d-4875-8034-927e1073ae4b@openvpn.net>

2025-03-28, 10:14:27 +0100, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> do you plan to drop more comments at the patchset at this point?

Yes, I had a couple of small comments here and there that I didn't
think strictly required a respin, but I'll send them out now since
there'll be more iteration. I'll try to have them all out by tomorrow
evening.

-- 
Sabrina

