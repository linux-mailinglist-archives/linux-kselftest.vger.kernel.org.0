Return-Path: <linux-kselftest+bounces-28304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10FA4FD73
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E65188E557
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03247221F0B;
	Wed,  5 Mar 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="guL9p3Nm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYpz4kEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8A1EB5D4;
	Wed,  5 Mar 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173622; cv=none; b=ICYZgpTAVNgtdhJEtAn57xIBCvNrPdb7Cqw1WPHpizV76JLKFkQVYRx8Dnazs641rOmIqr6aL/Wy3HYPh3jX4YuLSsWU3+e6Ob5J5YNxlAP+y7pSS7oKG3GHdo+cT8/Nt3BXylZFjuU27ZJ+7iE48xjF/jWU9FoE82zV+L7rmWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173622; c=relaxed/simple;
	bh=L1qAVFH/iTFiWBOyWb7WHytxG7ubOnnnrKNbi36vgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWWoUNx8swI3Dc9Jw8i+77bMcsdtOX7jOpaxMrxFVtNJdZwGg6FBjg2rgP/rr/soksqn+pWxU4t8SlwTnWA32bIpmJEw0Xxvv+1AkylSyoILeyR1aOPir92rsdVedIy65QX7aFaFlIE/10kvDd4GslDgtWaS8+sLXHL3sIZeyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=guL9p3Nm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYpz4kEB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BB5D11401D2;
	Wed,  5 Mar 2025 06:20:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 05 Mar 2025 06:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741173618; x=
	1741260018; bh=m9HbCY2L3S5nAunrxuRVcqEEHI+VNwMfOGb54zQ0t8w=; b=g
	uL9p3NmZC49Iq1rS5nC0DNipVrTO/BlmXdrBVljz6vbijYTCsoXlCE3yMhT9xjxI
	XPUthMM620bbbJcKSMoyP5vMDay7u8z9F5eg+pIW4v6/7UxVPWBzgX9BBB4Ll1Sk
	WYLbKXzyhkWobXSgD6R4xmeAyj6ckVuTTBAVG3zhZQThfUvl5/uw/Igwl8Vwg9z8
	kRUCYstG0OEIxybb87inRwGowhBTLT0cMCV6d6A7TjvWr+UiMsPU+57D35GoB4bG
	8LKfBOj8hHB+Jd6WipM5kZHKXxNNyZExKRu6DVBk/pAb+r/g/TbgWRt0vCelW1Q+
	pHTpP37uD/59lDatYErqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741173618; x=1741260018; bh=m9HbCY2L3S5nAunrxuRVcqEEHI+VNwMfOGb
	54zQ0t8w=; b=mYpz4kEBxfivzaIzdSg33W/OiX2BmZI6sVuepoZcu0MNrZoU05u
	nsAXGdNk+PDhEOFRLGrBT4U4y1gEMoauWWrR8MD3O4z2bWHsdkNpfxGuxMpNPEOM
	scloyk5sqQ7cJ5MaRB+GheCmji409dJxCoAoTjJhj6JSNI/uvk6ECcRx7zMYoI5I
	ZcZtba3Yl8ebTmlrQvYgXKPsg5g003LtXV4HIhiiIxU4cGGV6Uov/g6gcH5Xsw6D
	C4lqumLu0l+aHObS0RfPXKuzZxAFR+WVVG3RdRs+IVbI55+zOyye4MG3KiwgEs2K
	VnZjy+9K/54zxrsrZ3j9F3b5G2uAkcHdw0w==
X-ME-Sender: <xms:cTPIZ5RQaa0f9PzNBI69zoihWF8dVk6XYAW3U-xklbx2ToIk4pdOxA>
    <xme:cTPIZyxjolyffy7RN2bR2r91ebhgePRRH_ggc448Rf58arp7esxAMkJ0_p9qARAYY
    Kfgmb_hJy8OBU0w6R4>
X-ME-Received: <xmr:cTPIZ-0ZLuKsw_tyP3qfCu4_I-9yTNa2EDqRP92bZHTCuhIl9aQVG1XQlqu6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegieekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cTPIZxBkS2oJ8aB86E8abOdtJQ46KNPx4PHo6P7Wy-LTm37urYe4gQ>
    <xmx:cTPIZyi_A1nTfZpoP2_4hy_-EKNe3jF7rlX4FOaXiKwRtegNzPQXRw>
    <xmx:cTPIZ1rwHK6hiL0D09-AwPh4ymo9GLQTgcD7DaRmF2owRZ3K4NYnPQ>
    <xmx:cTPIZ9jD2DPBGQt0GNv6aQ9Z58zDGslWK5yitOu5bxqP2BRmY49h8A>
    <xmx:cjPIZ5Q4HOJcfeGqCDZpxZ3B_J0P4PjdaIuiFaSTcyxLNUmG9IinpyyJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 06:20:16 -0500 (EST)
Date: Wed, 5 Mar 2025 12:20:15 +0100
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
Message-ID: <Z8gzbz6YjdeGPqgu@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net>
 <Z8dIXjwZ3QmiEcd-@hog>
 <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>

2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
> On 04/03/2025 19:37, Sabrina Dubroca wrote:
> > 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
> > > A peer connected via UDP may change its IP address without reconnecting
> > > (float).
> > 
> > Should that trigger a reset of the peer->dst_cache? And same when
> > userspace updates the remote address? Otherwise it seems we could be
> > stuck with a cached dst that cannot reach the peer.
> 
> Yeah, that make sense, otherwise ovpn_udpX_output would just try over and
> over to re-use the cached source address (unless it becomes unavailable).

Not just the source address, the routing entry too. I'm more concerned
about that: trying to reuse a a cached routing entry that was good for
the previous remote address, but not for the new one.


[adding your next email]
> I spent some more time thinking about this.
> It makes sense to reset the dst cache when the local address changes, but
> not in case of float (remote address changed).
> 
> That's because we always want to first attempt sending packets using the
> address where the remote peer sent the traffic to.
> Should that not work (quite rare), then we have code in ovpn_udpX_output
> that will reset the cache and attempt a different address.

I don't think the code in ovpn_udpX_output will reset the cache unless
it was made invalid by a system-wide routing table update (see
dst_cache_per_cpu_get).

	rt = dst_cache_get_ip4(cache, &fl.saddr);
	if (rt)
		goto transmit;
...
transmit:
	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
			    fl.fl4_dport, false, sk->sk_no_check_tx);


So it seems that as long as dst_cache_get_ip4 gets us a dst (which
AFAIU will happen, unless we did a dst_cache_reset or something else
made the cached dst invalid -- and ovpn's floating/endpoint update
doesn't do that), we'll just use it.


> > > +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> > > +{
> > > +	struct hlist_nulls_head *nhead;
> > > +	struct sockaddr_storage ss;
> > > +	const u8 *local_ip = NULL;
> > > +	struct sockaddr_in6 *sa6;
> > > +	struct sockaddr_in *sa;
> > > +	struct ovpn_bind *bind;
> > > +	size_t salen = 0;
> > > +
> > > +	spin_lock_bh(&peer->lock);
> > > +	bind = rcu_dereference_protected(peer->bind,
> > > +					 lockdep_is_held(&peer->lock));
> > > +	if (unlikely(!bind))
> > > +		goto unlock;
> > > +
> > > +	switch (skb->protocol) {
> > > +	case htons(ETH_P_IP):
> > > +		/* float check */
> > > +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
> > > +			if (bind->remote.in4.sin_family == AF_INET)
> > > +				local_ip = (u8 *)&bind->local;
> > 
> > If I'm reading this correctly, we always reuse the existing local
> > address when we have to re-create the bind, even if it doesn't match
> > the skb? The "local endpoint update" chunk below is doing that, but
> > only if we're keeping the same remote? It'll get updated the next time
> > we receive a packet and call ovpn_peer_endpoints_update.
> > 
> > That might irritate the RPF check on the other side, if we still use
> > our "old" source to talk to the new dest?
> > 
> > > +			sa = (struct sockaddr_in *)&ss;
> > > +			sa->sin_family = AF_INET;
> > > +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> > > +			sa->sin_port = udp_hdr(skb)->source;
> > > +			salen = sizeof(*sa);
> > > +			break;
> 
> I think the issue is simply this 'break' above - by removing it, everything
> should work as expected.

Only if the bind was of the correct family? Checking an IPv4 local
address (in the bind) against an IPv6 source address in the packet (or
the other way around) isn't going to work well.


> I thin this is a leftover from when float check and endpoint update were two
> different functions/switch blocks.
> 
> > > +		}
> > > +
> > > +		/* local endpoint update */
> > > +		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
> > > +			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
> > > +					    netdev_name(peer->ovpn->dev),
> > > +					    peer->id, &bind->local.ipv4.s_addr,
> > > +					    &ip_hdr(skb)->daddr);
> > > +			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
> > > +		}
> > > +		break;

-- 
Sabrina

