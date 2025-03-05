Return-Path: <linux-kselftest+bounces-28322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D951FA505C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A9D168848
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3F1A5BB5;
	Wed,  5 Mar 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Yzct7SQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dR6TGgq+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A719F121;
	Wed,  5 Mar 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193778; cv=none; b=lGJU9khOsmbCHB40JxmWMEywycsINmknZv/LxVBeRiBvnwkDN2cEDpy71PHPbQhs2LTzLDEhPkHNQIEVDyINgxdr6KT2q1myPuB24rpWdWnVnp8k26/yaQOl5N8Nzh9bQ/fy8n2Td0oF8VwoTcgiCDUNWNHUjFiZz3Opq2zQr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193778; c=relaxed/simple;
	bh=pFjGlaUijoqPn1Kmc47+HhxkWegOEgp2VbTb7ZtNzVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbLX4PhWsQfGPXD1l3eZl1lUUllsxRfvr2O2z1ay4wbuzMdVqNfZ3HRvrSF6XuopOs7XAPNi23wfxWwlm9bX6pRoKKnbnpY6/wVNZOXWwVk/ILscVK+ynt4fa8p8GIZEDRq8kCHV8+F1EQtHTmChIZwi03H1DSLBWbomRFxZRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Yzct7SQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dR6TGgq+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 608601382772;
	Wed,  5 Mar 2025 11:56:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Mar 2025 11:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741193773; x=
	1741280173; bh=dvRtmvDZ8uVLZFz1wO6ModhsZOqhq2/vvtE8LfNaqVw=; b=Y
	zct7SQRhPYK9aUCRlSXWyM3ay/lThP1Fqjbgz4RFWWGBtgv3hSD0o1gwS4pPTg/K
	8CeQ9PIOFBrMPBeE0ADg2cIWseM8Jk3I/YZg7C8SZ/hLAw9D7FlSIZ2MW2xNTL43
	0IYtolECdYCfzHS7hA2we0jztsRrSGLaIAkQIyTtZtcpaEjfR0zLGv5t2hrMoip3
	WNppa2WrBB0Xo7x5ID0/bd9p88QqXt+EYlVVo+Ift3H1GnU4CeV4OdDFNcdLkQOY
	b6Zh1KYr2pNbSaVJ9nRq6Q8j7B8Hw5KtNeobocFpbygR5nPdjpYVKd97y3W5OeLE
	IBwvBYBRXhYbHuxUXdm0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741193773; x=1741280173; bh=dvRtmvDZ8uVLZFz1wO6ModhsZOqhq2/vvtE
	8LfNaqVw=; b=dR6TGgq+uuIK13VRZVMmd1mJUEmg8aeIky/FpOx4AJVEZ3N5Nfu
	AdU0JAjYH+2PV39pq3/ryDcKkzWbWmdh8vQKNfhulMQv8laxccDK+UGJ7vL6aACj
	BKC9td/RRNnQ2eqZZhnfCVMVM6ULADrm672TkAIYJXVDXC1D7UT2YlA4Dlpt6kf4
	rzMIurOHObveQI7Ju9IQMGqbAnPdgUELQ1yj/x/gGTxEtcHGynboChAHdvUXM6Sw
	S3RqKN5COP8+kNBBC3QBk18divbzcL1h0j5S2BwIQdBQGHHznbnzn6SV4G/vJ7xO
	ekVPHoI9hHpRVKA4ctNavTgNrfXRt3Dbs3w==
X-ME-Sender: <xms:LILIZ2BIkp7Yv9wO9eSFfv7ocOOXmzuSTNVx0Hb-aktPS0oPT1do4g>
    <xme:LILIZwgtxTEyjGbgHZefffO6qC6Acw4WKW8HoJhO6llG2Azoei51o2Qgndrvar7NH
    ThgAXxvljkLQlAL2cY>
X-ME-Received: <xmr:LILIZ5m0KcJUqxcb-Nszp31M7t49qYxLl16vecy5djlXziCcS_rbEAFEcAds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehfeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LYLIZ0zH8pM7HJtjgVCz1eJ4hljheABm4oJSzAHXJD6seq-fBsTIug>
    <xmx:LYLIZ7TnwPvNvDYOTwRVrMxU6hK1CJaNXsd3iYF-cLRHyiw9HTDU6g>
    <xmx:LYLIZ_b7JLRBPbn_dYpfXbdtwIA8Y-X9AJOfHHYAQbWTBHVOyZEFZA>
    <xmx:LYLIZ0Tdg_v5BDTiK3O9DIlqyAbDNh0DMHJYpA8a_PTPxhxUAmCVqg>
    <xmx:LYLIZ5DKeQIBdV-8gXN2Osc-r9wGkOq42FupaBwE8C445zVIsN1lMNS->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 11:56:12 -0500 (EST)
Date: Wed, 5 Mar 2025 17:56:10 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH v21 18/24] ovpn: add support for peer floating
Message-ID: <Z8iCKvIfFaskshlz@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net>
 <Z8dIXjwZ3QmiEcd-@hog>
 <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
 <Z8gzbz6YjdeGPqgu@hog>
 <cd9df084-8633-49f0-a851-ed2b1c9946d3@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd9df084-8633-49f0-a851-ed2b1c9946d3@openvpn.net>

2025-03-05, 14:14:36 +0100, Antonio Quartulli wrote:
> On 05/03/2025 12:20, Sabrina Dubroca wrote:
> > 2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
> > > On 04/03/2025 19:37, Sabrina Dubroca wrote:
> > > > 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
> > > > > A peer connected via UDP may change its IP address without reconnecting
> > > > > (float).
> > > > 
> > > > Should that trigger a reset of the peer->dst_cache? And same when
> > > > userspace updates the remote address? Otherwise it seems we could be
> > > > stuck with a cached dst that cannot reach the peer.
> > > 
> > > Yeah, that make sense, otherwise ovpn_udpX_output would just try over and
> > > over to re-use the cached source address (unless it becomes unavailable).
> > 
> > Not just the source address, the routing entry too. I'm more concerned
> > about that: trying to reuse a a cached routing entry that was good for
> > the previous remote address, but not for the new one.
> > 
> > 
> > [adding your next email]
> > > I spent some more time thinking about this.
> > > It makes sense to reset the dst cache when the local address changes, but
> > > not in case of float (remote address changed).
> > > 
> > > That's because we always want to first attempt sending packets using the
> > > address where the remote peer sent the traffic to.
> > > Should that not work (quite rare), then we have code in ovpn_udpX_output
> > > that will reset the cache and attempt a different address.
> > 
> > I don't think the code in ovpn_udpX_output will reset the cache unless
> > it was made invalid by a system-wide routing table update (see
> > dst_cache_per_cpu_get).
> > 
> > 	rt = dst_cache_get_ip4(cache, &fl.saddr);
> > 	if (rt)
> > 		goto transmit;
> > ...
> > transmit:
> > 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
> > 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
> > 			    fl.fl4_dport, false, sk->sk_no_check_tx);
> > 
> > 
> > So it seems that as long as dst_cache_get_ip4 gets us a dst (which
> > AFAIU will happen, unless we did a dst_cache_reset or something else
> > made the cached dst invalid -- and ovpn's floating/endpoint update
> > doesn't do that), we'll just use it.
> 
> Mh yeah, you're right.
> Then I'll reset the cache also when a float is detected.

Ok, thanks.

> > 
> > 
> > > > > +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> > > > > +{
> > > > > +	struct hlist_nulls_head *nhead;
> > > > > +	struct sockaddr_storage ss;
> > > > > +	const u8 *local_ip = NULL;
> > > > > +	struct sockaddr_in6 *sa6;
> > > > > +	struct sockaddr_in *sa;
> > > > > +	struct ovpn_bind *bind;
> > > > > +	size_t salen = 0;
> > > > > +
> > > > > +	spin_lock_bh(&peer->lock);
> > > > > +	bind = rcu_dereference_protected(peer->bind,
> > > > > +					 lockdep_is_held(&peer->lock));
> > > > > +	if (unlikely(!bind))
> > > > > +		goto unlock;
> > > > > +
> > > > > +	switch (skb->protocol) {
> > > > > +	case htons(ETH_P_IP):
> > > > > +		/* float check */
> > > > > +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
> > > > > +			if (bind->remote.in4.sin_family == AF_INET)
> > > > > +				local_ip = (u8 *)&bind->local;
> > > > 
> > > > If I'm reading this correctly, we always reuse the existing local
> > > > address when we have to re-create the bind, even if it doesn't match
> > > > the skb? The "local endpoint update" chunk below is doing that, but
> > > > only if we're keeping the same remote? It'll get updated the next time
> > > > we receive a packet and call ovpn_peer_endpoints_update.
> > > > 
> > > > That might irritate the RPF check on the other side, if we still use
> > > > our "old" source to talk to the new dest?
> > > > 
> > > > > +			sa = (struct sockaddr_in *)&ss;
> > > > > +			sa->sin_family = AF_INET;
> > > > > +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> > > > > +			sa->sin_port = udp_hdr(skb)->source;
> > > > > +			salen = sizeof(*sa);
> > > > > +			break;
> > > 
> > > I think the issue is simply this 'break' above - by removing it, everything
> > > should work as expected.
> > 
> > Only if the bind was of the correct family? Checking an IPv4 local
> > address (in the bind) against an IPv6 source address in the packet (or
> > the other way around) isn't going to work well.
> 
> Ah I understand what you mean.
> 
> The purpose of "local_ip" is to provide a working local endpoint to be used
> with the new remote address.
> However, if the float is switching family we can't re-use the same old local
> endpoint (hence the check).
> In this case we'll learn the "new" local address later.
>
> Does it make sense?

Sure, but we could have learned it immediately from the packet we just
got, whether we're changing family or not. No need to wait for the
next RX packet to also learn the new local address.

But if we now do a dst_cache_reset with the peer float,
ovpn_udp*_output will have to do a new route/local address lookup and
I guess that should clean up the local address stored in the bind, and
then update the dst_cache with the local address we just found.

-- 
Sabrina

