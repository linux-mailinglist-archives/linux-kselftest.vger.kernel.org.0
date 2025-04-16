Return-Path: <linux-kselftest+bounces-30956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF91A90839
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D17D3B1D11
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04680204F8A;
	Wed, 16 Apr 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PCBqdYjf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7FVybia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910817B4EC;
	Wed, 16 Apr 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819452; cv=none; b=q3+GzqvTfYl0kG21e9oz1YMwZ1oxsM3niJKxxTB+ENEpSPHWUTjLKEpFVXvOJlcLQyILPqIbyt1HKfkMa/o++pLPYA9lRaJpoN0FnmYOG//i9OULz5wpv4Vg2S/JKp0wmNXIGrFLZ/H+b0rud94/nVUp4EaLYLJ9szyH3vwJP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819452; c=relaxed/simple;
	bh=ExV+qopSCx6nEjSSIXQgiSqYOJWKXQsUnO9DDfAoE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHau9VYRNUSStqcgaUsQmbYtm0thqmVD/W9iAYOxkEOtibMs3oBJyB9Q+lYTjMbdGHQClMjKpAjCpvWwhCyYub7gE7ci2vbB60wzGL8l/DS3benTp6YR9zrlL5407yd8XxwWkaqPdpJ5C3+fTAXzA7AnTlInxAKNByQm0RoU97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PCBqdYjf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7FVybia; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E5DA11402AB;
	Wed, 16 Apr 2025 12:04:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 16 Apr 2025 12:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744819447; x=
	1744905847; bh=dSpHFaLh+ehYJd+pg1fhaXxmbL6V+XvmhHymYCZ3B8A=; b=P
	CBqdYjfWtkj3twvlhVkyTK4M71TdsCxiTecsKHEfC/jROKiCKa1n1rbPbaNUQCnB
	hYz3YQj3uzTq/9t22PCT2daTfF7q/aeDxFeak1vAKy8CjRLEBrmo+AUH8mzvXsNP
	oKcU8nXK13MwgltwEps3zHoaEOWD5xgiMTfTbBUYhya5dESLGyR32dPiQ5kP1ALo
	KpJgyScwXxAGgJK164+KOdw+ThRI0RxKZTGY6dngfh89b2wBdKUJKN0wQax9vu6T
	H+AfZ9PbHLs6ZJImDVOV55lop3JabaJQT+v2mUeFjXRSbDjWYGi4J0LEA1TPHD34
	mHJ/MdW5s7QdziC0Df8gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744819447; x=1744905847; bh=dSpHFaLh+ehYJd+pg1fhaXxmbL6V+XvmhHy
	mYCZ3B8A=; b=L7FVybiaP4ytSd4jTXYyGatuZ6hh8KjMRfXuCAfdqp8TuM/3AjB
	5iDS2u2jJw2YBpIhp+Kas8zryJCRGHetH8uLEU+5MheXWIpwHxtb1oWjCge1iyna
	4GT1M1GweeOKLQcyQ3g9pgzdHtwBPEnL6f4rtCw4ayHcS9FcpQ+hIZNrDUgRIHOC
	c2kLUPR7eocVTfQMEpiDKh1iPhLYNm8UXAGcr7G6f7yvmu1rJNyW6mGHoWabP8kD
	2C8Bb9Bxa+JUSKP0G+N681tQqOIcHEep18B4C3CX5Jr9QuB+nY5VJQpLN5O48oES
	gCeA4+7OuXlZRGzMGOrJaEGphDS97BawlPw==
X-ME-Sender: <xms:9tT_Z5GoC386dAT-X9zwKmW00wMglb8EO7kAHO1qKxgpQmgxrhsVGg>
    <xme:9tT_Z-UnC_3cIhz4I1fCi6oyJS4eOx_7kx5EDVvxssgI7_1Rcq8xUg2_vxYLPIykQ
    E-rB-UYVne9tShN68Q>
X-ME-Received: <xmr:9tT_Z7ISFBhAQSrsvLsTZ5p--02jmNsJqWFJ1ZfmkbyKlQfXK_K-wVDwMk4v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeikedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheptddvhffhhfdugfegvdejfeetuddt
    tdejteehfeejvdeugeffkefhgfffheeuudffnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudelpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvght
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrgiirghnoh
    hvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggv
    vheslhhunhhnrdgthh
X-ME-Proxy: <xmx:9tT_Z_FNUybtwEEHxjdgESv01hFeFCTFiehIwm86rWwE9woo_VyWMw>
    <xmx:9tT_Z_V57j3zUI-tZmgTnQiQQ38f_MMis7B0QV9didZs_2y_bGnqIQ>
    <xmx:9tT_Z6On3gSY0v0VNqiiSQqwECh5-CNauMDNGbQ3mDUdCXpwI1RILg>
    <xmx:9tT_Z-1jS3SPPmy0zf44EuIb2G3PSk5gnsd66tVSVptke69GASGEhA>
    <xmx:99T_Zy2SxRHfqeyDJMj5GB8sf8P-xfhI5uilZHoNfgX-pn3whEzVnaLA>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 12:04:05 -0400 (EDT)
Date: Wed, 16 Apr 2025 18:04:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	steffen.klassert@secunet.com, antony.antony@secunet.com,
	willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
Message-ID: <Z__U881z4XdlkMHW@krikkit>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>

2025-04-15, 13:17:17 +0200, Antonio Quartulli wrote:
> Notable changes since v25:
> * removed netdev notifier (was only used for our own devices)
> * added .dellink implementation to address what was previously
>   done in notifier
> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
> * fixed author in MODULE_AUTHOR()
> * properly indented checks in ovpn.yaml
> * switched from TSTATS to DSTATS
> * removed obsolete comment in ovpn_socket_new()
> * removed unrelated hunk in ovpn_socket_new()
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/ovpn-net-next
> 
> Thanks a lot!
> Best Regards,
> 
> Antonio Quartulli
> OpenVPN Inc.
> 
> ---
> Antonio Quartulli (23):
>       net: introduce OpenVPN Data Channel Offload (ovpn)
>       ovpn: add basic netlink support
>       ovpn: add basic interface creation/destruction/management routines
>       ovpn: keep carrier always on for MP interfaces
>       ovpn: introduce the ovpn_peer object
>       ovpn: introduce the ovpn_socket object
>       ovpn: implement basic TX path (UDP)
>       ovpn: implement basic RX path (UDP)
>       ovpn: implement packet processing
>       ovpn: store tunnel and transport statistics
>       ovpn: implement TCP transport
>       skb: implement skb_send_sock_locked_with_flags()
>       ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
>       ovpn: implement multi-peer support
>       ovpn: implement peer lookup logic
>       ovpn: implement keepalive mechanism
>       ovpn: add support for updating local or remote UDP endpoint
>       ovpn: implement peer add/get/dump/delete via netlink
>       ovpn: implement key add/get/del/swap via netlink
>       ovpn: kill key and notify userspace in case of IV exhaustion
>       ovpn: notify userspace when a peer is deleted
>       ovpn: add basic ethtool support
>       testing/selftests: add test tool and scripts for ovpn module

The changes since v25 lgtm:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

