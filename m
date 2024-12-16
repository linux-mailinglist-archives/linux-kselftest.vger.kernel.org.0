Return-Path: <linux-kselftest+bounces-23418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6059F32FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09AD37A0F82
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9A2063DE;
	Mon, 16 Dec 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MdbDjr+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImPBvDgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979181EEE0;
	Mon, 16 Dec 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358820; cv=none; b=EW7N/wrC3rzw+4MQhARPbTIucjEc/BzdItr50bkEP+7MFvEZAPmzrbnirU4RwkLGndYXZoCVEITRaSVg9XJr0dIG+rC/q4C8/ze7j/rQ4ALlgYSAsJsBHZa5BIbvgc4+tvednOOCKeOL4PjsyYQO4c9fUZptHjgRiPnc4B+E9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358820; c=relaxed/simple;
	bh=DiNO7ZEC5VhBtUmKt82m13UNWtY4Er6cyNS6EBMMG+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ8BlBdmzcrPTCiwsR9rWRQIsQDHGH4yUvX5Y13B1bxS4naviRD6JPm1e3Vit4hj7dyiNrYjtTnZQz3bm+Hk1/oROfk3C6Szww+GdBuE1BFcYyyIKoc+KERb4QWmVH9CtRN62+hOLbfG4BO0Kac44hQSKWNDcFNqE0wUENhpFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MdbDjr+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImPBvDgG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C3A72540162;
	Mon, 16 Dec 2024 09:20:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 09:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734358817; x=
	1734445217; bh=CAm8nZ8BxFh89NT49SvI5hcKSsCVvB55Sxe8NB2C+h4=; b=M
	dbDjr+gbmrB1JJ0yoVqd4HhKJd2PFvLSfuvBPU37pRCAHrc1FFVAUBkLeD2YGqJL
	cmKORMeaqiemd36eShdR0Ug/MFqGhHzX/fE/2ofXpseyJFmgS8w0Np6BD3RQ0jrA
	+1KOCCL/lVOFlLzTgP3oh5vLu4IKnhdkQfqBU9eChMbUdLzjJsSG1b0MkSg6/c/G
	Y3fvzRT2aRJordQt3dktHZpW2LT04Yaz+sYT4oBaeUKqW3jFdYk2hDGWC3XaV9Nf
	/8PUJ6CwSO2q2SVp6GVZDEUcOQjCnlGNibY+4pJHMgDlAltW903f2XwLIpR542Fk
	xDuZID/6K1r1LXHb7Iybw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734358817; x=1734445217; bh=CAm8nZ8BxFh89NT49SvI5hcKSsCVvB55Sxe
	8NB2C+h4=; b=ImPBvDgGOY/+nqLx02EVxWR+mqzpZ6eh7Rv7vwPXVyg4rfbWjXT
	SioSxSwVWw1b95zv0HlULdsKQsJe3xrdIgkgPVzkhqA/UTpw+6Rso6uWMSG69xzb
	4+lrMs4wWVq7380iqo+uLvP05qZQpnXehi0zXoJrgwp88/k+y1pymXq8DN///3U/
	rbe/8DdtULx63JK+l8XrCUqEOzkXkVcUcLSIi1O2Y111tMVd/BjSbspwnTDpcuBU
	xZcZy+LD7T7+14o7Erm/zcePCkTyJYaEufmDWCiZxFWiQbJkfoxRc1MNqj01+Yeq
	GeWx714bzE13+wf8dwJDrdz6LaJehIpLcwQ==
X-ME-Sender: <xms:IDdgZ8-_wpLLcBYFjazj2HDjJOlaOO_JlLZZ1K1TcMtxRGPl9Qsz_Q>
    <xme:IDdgZ0vBCRJ6eofGx3K3Slntyx2gX5sfnz0FaZ6oVaxM05cyECQ2bLqZdvSA4inh0
    QIoGGVAXLqqpD30MaE>
X-ME-Received: <xmr:IDdgZyAHVaT54v2_XxuCZpqOpSZRAU8trZ9k9HQy2t00GMz7UeA8JTgb1lBv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:ITdgZ8c0_vK1T_6bIo4_ZGVfYrcoEQaL4yWq0gCgVqiufF1KT5Ab2g>
    <xmx:ITdgZxMHX0_syCYxCryszSISdBlyxgHYgsrBpnziaDgEKBlA7B9WMQ>
    <xmx:ITdgZ2mxO6y9wJHhJ2VUc94pbo9yXNqSFN6XeG5JwZQ5huA9KIF_tQ>
    <xmx:ITdgZztxOARzaxc0ZJtOOgLhtv3-xlv0QHz8nrXyIAaAJET3zfUYLA>
    <xmx:ITdgZ3uVC7lm5ay2EG5nBWemhBOj7D-F0PCVTaqdGk3hheKmsOLIoRFU>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 09:20:16 -0500 (EST)
Date: Mon, 16 Dec 2024 15:20:15 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v15 10/22] ovpn: store tunnel and transport
 statistics
Message-ID: <Z2A3H6ynvrJ45Avy@hog>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-10-314e2cad0618@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-b4-ovpn-v15-10-314e2cad0618@openvpn.net>

2024-12-11, 22:15:14 +0100, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index 1b427870df2cf972e0f572e046452378358f245a..61c54fb864d990ff3d746f18c9a06d4c950bd1ac 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -13,6 +13,7 @@
>  #include <net/dst_cache.h>
>  
>  #include "crypto.h"
> +#include "stats.h"
>  
>  /**
>   * struct ovpn_peer - the main remote peer object
> @@ -25,6 +26,8 @@
>   * @crypto: the crypto configuration (ciphers, keys, etc..)
>   * @dst_cache: cache for dst_entry used to send to peer
>   * @bind: remote peer binding
> + * @vpn_stats: per-peer in-VPN TX/RX stays

nit: s/stays/stats/

-- 
Sabrina

