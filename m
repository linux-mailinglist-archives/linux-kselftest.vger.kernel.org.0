Return-Path: <linux-kselftest+bounces-21887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAA9C5EEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BB4284230
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6B212D16;
	Tue, 12 Nov 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VOt3XJDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOGec7Zy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9192101A9;
	Tue, 12 Nov 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432495; cv=none; b=HLlUFi5r3ShisdVObU3q9ftvQ6rS/Ny8/ZffwPkWSbSqG6Hyea0FmosAw0j8iQrgWlnwQQTXuabH5p6d1vz4uOZRQ+3A2rPVT+VnTlKb8zpkhTrcXErnj1TXyFfxnP8UklZxqsmb3XNT5xPeE5fGwwZCoec7ZzoO1RUNmCftyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432495; c=relaxed/simple;
	bh=Yj+jvWwQRa4Ssk3kPK/9T3xPTVSRmlrCHJKydBYYUbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoaQK7hHfDNlRvQz/Y3uU1YWhMynKpc0doTHYdXpVBGXnXNsutlHXxJsVxgYPuNzEwtcFH3tdfZThFv1OwLDs/2zQcdup4WRS3jokUFwcb4gCLQwMQG9e6c64BlEttOJC8TLtkA394faX692Z1Ocf6Y/+TVjM5RQg4q1U1ZqVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VOt3XJDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOGec7Zy; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 10B8E1D4038E;
	Tue, 12 Nov 2024 12:28:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 12 Nov 2024 12:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731432490; x=
	1731436090; bh=o1+HpOSf0pvwVmkS/ACXVJ+8V0VJ7ttlb7CCUALgPvE=; b=V
	Ot3XJDEArKHlYIVmRr4Y4zcYCCqjwYgntmJ2nRx8d0f9CVC0pyCdJYTk4ae/+a5Z
	I6erhXpfx8EMQb3wkjW/GS9Fkyv1bfbPoOmNOmiTeONYHdGz2aOBvQox/lh3XU5v
	N0eUeUcN4uZwfsTDw11//U6ro3FTnBydZh1in6S3gX6Qufm2cYqnpiCMPLik6pRA
	2LS7qmGMGFy8rTkOFlkSBD3UHNBTriYKQGMbkyeK/N6qiFpD78ULmScSfE004GHJ
	Rd3alaEhSW+JTvisGQVA4iyZghuROMGINVXilKm2jhq+W4APQSMzON+eKHq46b8E
	/qBuO52BD2zeb6q7yd1mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731432490; x=1731436090; bh=o1+HpOSf0pvwVmkS/ACXVJ+8V0VJ7ttlb7C
	CUALgPvE=; b=cOGec7ZyjaUKZBkwrESsGlT6Yye4kzTWbwXTY2SvbarAm67zpQe
	KckOpLNZ17QtfP0gyhMp6PaqhQ8fCWO8c2oyCmCX7bL7RoOBy4I4TRZpV24eNPJs
	YbuBYLQwDpJ+qFff4suWMaXIDCK1mU1wci27iBpWNWzYojeBxpXSMCbn9Ay5Oq7e
	9eJMuWMA085icjFM0TW/wKpbUOuRkC5xU79UcjP6ebcOCSD3pydUwQMBPel/TTmb
	Bu/m5i2Zbg8UL/D18RnI4gsLqIUjcXODTXAa9qTFIG31q29NiuEMO2ukqoWgFuOg
	V5Efxr87YNUwHp0Y2OLsoK48R/StkVUgbow==
X-ME-Sender: <xms:KpAzZ2_yHsAIOlPurRebXRyLTjJW0Fovqkx9gsrMNrc449nSOIij1g>
    <xme:KpAzZ2sPR6MW3d_X_FIeqnbw0WRp2ZwZKOG7U6PKymllBF3XbtwNRjuEWg-fQyI4M
    oBdE9eDQ5ZXHByuT24>
X-ME-Received: <xmr:KpAzZ8AKIFXDKX8KwuF30QjWgNwLwgfokv80_jW7IJAEGzlfncplsSGMrSOt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrhigriigrnh
    hovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhtohhnihhosehophgv
    nhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KpAzZ-d_MLZltDajcFgRoRSUIjTuBYqyarwY4qmPSGCY4JBWLtiMfg>
    <xmx:KpAzZ7PDx5yTfmMaYQC5Qm1swClcRtROBABbjPcECUeZZdU2oSNkVQ>
    <xmx:KpAzZ4nBy159I_Vk0QMNbGfTPcc_jcyAvh6Sc8HkpOLWSXQjmHj93Q>
    <xmx:KpAzZ9sOjBdfu3LD-Twr8GTr3laKwVnZqmGR_kWvfq1gkkSbN_oFOw>
    <xmx:KpAzZ0gj5_Mq0NtzaVjbNwVZTnh_65gyDVdTUmwvmtfIoh6nK4j1v2Rj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:28:10 -0500 (EST)
Date: Tue, 12 Nov 2024 18:28:08 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
Message-ID: <ZzOQKPHjWsG9TNEU@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
 <85858c63-4dc5-468e-8335-6ac77f314e33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85858c63-4dc5-468e-8335-6ac77f314e33@gmail.com>

2024-11-11, 00:32:51 +0200, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
> > +static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> > +{
> > +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> > +
> > +	if (unlikely(ret < 0))
> > +		goto err;
> > +
> > +	skb_mark_not_on_list(skb);
> > +
> > +	switch (peer->sock->sock->sk->sk_protocol) {
> > +	case IPPROTO_UDP:
> > +		ovpn_udp_send_skb(peer->ovpn, peer, skb);
> > +		break;
> > +	default:
> > +		/* no transport configured yet */
> > +		goto err;
> > +	}
> 
> Did you consider calling protocol specific sending function indirectly?
> E.g.:
> 
>         peer->sock->send(peer, skb);

In a case where
 - only 2 implementations exist
 - no other implementation is likely to be added in the future
 - both implementations are part of the same module

I don't think indirect calls are beneficial (especially after the
meltdown/etc mitigations, see for example 4f24ed77dec9 ("udp: use
indirect call wrappers for GRO socket lookup"), 0e219ae48c3b ("net:
use indirect calls helpers for L3 handler hooks"), and many others
similar patches).


[...]
> > +	ovpn_send(ovpn, skb_list.next, NULL);
> > +
> > +	return NETDEV_TX_OK;
> > +
> > +drop:
> >   	skb_tx_error(skb);
> > -	kfree_skb(skb);
> > +	kfree_skb_list(skb);
> >   	return NET_XMIT_DROP;
> >   }
> > diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> > index d9788a0cc99b5839c466c35d1b2266cc6b95fb72..aff3e9e99b7d2dd2fa68484d9a396d43f75a6d0b 100644
> > --- a/drivers/net/ovpn/peer.c
> > +++ b/drivers/net/ovpn/peer.c

[very long chunk of Antonio's patch quoted without comments]

Please trim your replies to only the necessary context.

-- 
Sabrina

