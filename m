Return-Path: <linux-kselftest+bounces-28677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655FA5A747
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 23:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7B31893E3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08B1D9A50;
	Mon, 10 Mar 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fVKfboNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RsVy2VGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69940BF5;
	Mon, 10 Mar 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645960; cv=none; b=J4uuUTeZdGU/y64tZb8m72/t+6sgkt3aWmUKdYtEGomOXFPgyPgLQdO7FZXKl81UQ9j6Rc6/jawaSE2zhqXH40zmPyBm97jRcMtgqRotlpFtHFZAW74G5Vrc+67yizCdY4JmCJ8h5YLeLxXwpK81nSm7ry9m4tjfiYdAchDSJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645960; c=relaxed/simple;
	bh=HGT4Z0B8QctB4CWCG8b6bsqmVMvIGjJoJnW2q9VU7pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQVGzJtc8E7kAxHcwEOz1jC0Ov2wSegXkM4Edod+oKllgexwIPz97jfzs313IScp49h/SMvKKGFD0hEkKnWiEkCd13yLKAHNgvNMpuEfJ5bQt0ChUxHXs6CD0iUVCq6p31GH2NTOjswYXxOBGbgbGikRFNx0bwyK/gd6AI9BUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fVKfboNb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsVy2VGH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24F692540229;
	Mon, 10 Mar 2025 18:32:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 18:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741645955; x=
	1741732355; bh=ZS7KjdNn6YCnHyzV5gWSXkChiezZSEiD9Qt9aZfbXgA=; b=f
	VKfboNbhpKmgcgkJVmECI0w4wEX515YHOkEl5EeuFNqxOouo1aJULT0J+OWmB4rV
	HAdl4NOKsFaI8kp7x2j4ML+L6wD30CALhUc2kUu8WUiZ7cmHTE093alPMjtHBIVh
	0TdHULpElenWNZuHHTZCgcNP61LTaFKIMGpp8XyYhjT98BebTPI1C0YHM4pDHblk
	a4z8e3dLqMet7y3nGDipYDycmlQMs+THjAKIjMvmwfkk6xe7mN/AAgeTYWsPVHBY
	mhMZf9gNG035VL8BYJJCdZO+JKg6n15REoLvcOUjx4NyznDqZQTZhqbrpJ3NjRkj
	BJGoxVsXuNK7bg0TatuqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741645955; x=1741732355; bh=ZS7KjdNn6YCnHyzV5gWSXkChiezZSEiD9Qt
	9aZfbXgA=; b=RsVy2VGHF08+q2w3fw6Nud/PipsMCj5tiakVyuytIWeXgI1TC9Y
	OtVOmBOr+aEw0kWO+RUV4h8MNBIpXFa8goiGN5TA8jB3GPA4p0V+S5WhFNejFvpe
	sT33Ltdu0gO5DlcTmVK2Xeaugr/6Tb01J8WDGodiBQgkipI8HSCIVfguUpH4/BJm
	2dLdPC5MxzrVjmMkNgmZC37BDam31+dlrQJEnaFsvAdoAeoL7uPTcbWFL+Rep89l
	DegBUN646h1/1/YAlVrXegSuauUFEdkChFANr7WkC5aPBMG3Y9548ckEGI2FbXoD
	oYHUq+oTtqF6ljmEYBCawlgmrfEEWXFVOFA==
X-ME-Sender: <xms:g2jPZxnkWERzK0-9Zx1H2GO9L-cQb0_OR_dAebHboAxxdoKX380Tdg>
    <xme:g2jPZ82wyTMHqkRo50_8EFPU78QEdI7WoKQRi0g7bzqWpPnrwaEA3TpglKU_S2y5F
    7FvLjfiRUwmLh-emFw>
X-ME-Received: <xmr:g2jPZ3rNFPzR3qV7UkdSrZAS6OmAvWUHTBhYyO2VDgT2y0_QkbDR7rNcuCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:g2jPZxmF0oL4L-kqA2-JiLdY5z2voHI_198IMkbp7P6nNYKCE3zZcQ>
    <xmx:g2jPZ_3lhnQyZKDuqx6eZP9S3upxn0BL33jBs9ZPTK0f2ERco1We7g>
    <xmx:g2jPZwvXM7ySX3htQTDgwTmKhsVvpXp-aLghAxR6NFLNTmX7l4UWsw>
    <xmx:g2jPZzUDCPAQ-W6FK_jx236Sd1du9Vg0PgVx7vD-uVd_f3qUWZtfKw>
    <xmx:g2jPZ20ZKwsk6u1XvL7w1QfVO2uJqZxZccpjFtQX6GcsbxbGAHCEz6XY>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 18:32:34 -0400 (EDT)
Date: Mon, 10 Mar 2025 23:32:28 +0100
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
Message-ID: <Z89ofEgYznYavrx8@krikkit>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net>
 <Z8dIXjwZ3QmiEcd-@hog>
 <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
 <Z8gzbz6YjdeGPqgu@hog>
 <cd9df084-8633-49f0-a851-ed2b1c9946d3@openvpn.net>
 <Z8iCKvIfFaskshlz@hog>
 <e3def5b5-3450-4ad0-aced-fd80af943c31@openvpn.net>
 <Z8rGnTaRE_mph_tD@hog>
 <431c7b94-87ba-4aba-9bc7-e255241dbbdf@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <431c7b94-87ba-4aba-9bc7-e255241dbbdf@openvpn.net>

Note: as I tried to say at the end of my previous reply, feel free to
ignore this or save it for later. dst_cache_reset on float and change
of remote via netlink peer_modify is the important thing, and I'm not
sure the "local address change on float" can or can't happen.


2025-03-10, 13:57:09 +0100, Antonio Quartulli wrote:
> On 07/03/2025 11:12, Sabrina Dubroca wrote:
> > 2025-03-06, 11:02:50 +0100, Antonio Quartulli wrote:
> > > On 05/03/2025 17:56, Sabrina Dubroca wrote:
> > > > 2025-03-05, 14:14:36 +0100, Antonio Quartulli wrote:
> > > > > On 05/03/2025 12:20, Sabrina Dubroca wrote:
> > > > > > 2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
> > > > > > > On 04/03/2025 19:37, Sabrina Dubroca wrote:
> > > > > > > > 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
> > > > > > > > > +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> > > > > > > > > +{
> > > > > > > > > +	struct hlist_nulls_head *nhead;
> > > > > > > > > +	struct sockaddr_storage ss;
> > > > > > > > > +	const u8 *local_ip = NULL;
> > > > > > > > > +	struct sockaddr_in6 *sa6;
> > > > > > > > > +	struct sockaddr_in *sa;
> > > > > > > > > +	struct ovpn_bind *bind;
> > > > > > > > > +	size_t salen = 0;
> > > > > > > > > +
> > > > > > > > > +	spin_lock_bh(&peer->lock);
> > > > > > > > > +	bind = rcu_dereference_protected(peer->bind,
> > > > > > > > > +					 lockdep_is_held(&peer->lock));
> > > > > > > > > +	if (unlikely(!bind))
> > > > > > > > > +		goto unlock;
> > > > > > > > > +
> > > > > > > > > +	switch (skb->protocol) {
> > > > > > > > > +	case htons(ETH_P_IP):
> > > > > > > > > +		/* float check */
> > > > > > > > > +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
> > > > > > > > > +			if (bind->remote.in4.sin_family == AF_INET)
> > > > > > > > > +				local_ip = (u8 *)&bind->local;
> > > > > > > > 
> > > > > > > > If I'm reading this correctly, we always reuse the existing local
> > > > > > > > address when we have to re-create the bind, even if it doesn't match
> > > > > > > > the skb? The "local endpoint update" chunk below is doing that, but
> > > > > > > > only if we're keeping the same remote? It'll get updated the next time
> > > > > > > > we receive a packet and call ovpn_peer_endpoints_update.
> > > > > > > > 
> > > > > > > > That might irritate the RPF check on the other side, if we still use
> > > > > > > > our "old" source to talk to the new dest?
> > > > > > > > 
> > > > > > > > > +			sa = (struct sockaddr_in *)&ss;
> > > > > > > > > +			sa->sin_family = AF_INET;
> > > > > > > > > +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> > > > > > > > > +			sa->sin_port = udp_hdr(skb)->source;
> > > > > > > > > +			salen = sizeof(*sa);
> > > > > > > > > +			break;
> > > > > > > 
> > > > > > > I think the issue is simply this 'break' above - by removing it, everything
> > > > > > > should work as expected.
> > > > > > 
> > > > > > Only if the bind was of the correct family? Checking an IPv4 local
> > > > > > address (in the bind) against an IPv6 source address in the packet (or
> > > > > > the other way around) isn't going to work well.
> > > > > 
> > > > > Ah I understand what you mean.
> > > > > 
> > > > > The purpose of "local_ip" is to provide a working local endpoint to be used
> > > > > with the new remote address.
> > > > > However, if the float is switching family we can't re-use the same old local
> > > > > endpoint (hence the check).
> > > > > In this case we'll learn the "new" local address later.
> > > > > 
> > > > > Does it make sense?
> > > > 
> > > > Sure, but we could have learned it immediately from the packet we just
> > > > got, whether we're changing family or not. No need to wait for the
> > > > next RX packet to also learn the new local address.
> > > 
> > > Indeed.
> > > 
> > > > 
> > > > But if we now do a dst_cache_reset with the peer float,
> > > > ovpn_udp*_output will have to do a new route/local address lookup and
> > > > I guess that should clean up the local address stored in the bind, and
> > > > then update the dst_cache with the local address we just found.
> > > 
> > > Right and this may not truly be what we want.
> > > 
> > > If peer X is sending packets to our IP1, we should at least try to reply
> > > from the same address.
> > > 
> > > If we have two IPs, IP1 and IP2, and both can be used to reach peer X, we
> > > should always try to use the one where we received traffic from X in the
> > > first place.
> > 
> > I had a thought that it might not be our prefered address to talk to
> > X, but it would probably be, since we decided to use it (and thus X
> > used it as remote to talk to us).
> 
> I am not sure I follow this sentence: I think you are just confirming what I
> said above (please correct me if I am wrong)?

Yes. This may turn out to be incorrect (see the "some corner cases"
bit below), but let's wait for examples of that.

> > > OTOH hand it is also true that with floating detection on both sides, the
> > > situation will converge quickly, but there might be a reason why X chose IP1
> > > as destination, therefore we should do our best to respect that.
> > 
> > And I guess the primary reason for X to choose IP1 would be "we sent
> > packets to X from IP1".
> 
> Probably. It truly depends on who initiated the connection.
> 
> > 
> > > So, even in case of float, we should still store the local endpoint and
> > > attempt fetching a route that takes that into consideration.
> > > Which I think is what is happening (assuming we reset the dst_cache on
> > > float).
> > 
> > Not at the same time as float, unless ovpn_peer_endpoints_update sets
> > local_ip = ip_hdr(skb)->daddr unconditionally on float?
> > 
> > Otherwise the next route lookup in ovpn_udpX_output will pick whatever
> > source address it wants (which would likely match what's in the
> > received skb during float, so probably fine anyway).
> > 
> 
> But that's what the code just below in ovpn_peer_endpoints_update() does,
> no?

I think this is going a bit in circles :) And possibly completely
irrelevant.

The /* local endpoint update */ is (correctly) skipped in case of
float [because the family may not be right so we can't compare
addresses].

In case of float, I think setting local_ip to the packet's header
would do the right thing is all cases:
- if it matches what's in the old bind, great, we didn't change our
  local IP, just the remote and we could have kept local_ip = &bind->local
- if it doesn't match, we learn it (but that brings the question: why
  did the peer think our address was IP2 and we thought it was IP1? --
  which may be an irrelevant corner case)


> 
>  223                 /* local endpoint update */
>  224                 if (unlikely(bind->local.ipv4.s_addr !=
> ip_hdr(skb)->daddr)) {
> 
> ...
> 
>  229                         bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
> 
> 
> > > ovpn_udpX_output() will:
> > > * get no rt from the cache
> > > * possibly confirm that saddr is ok
> > > * fetch the new rt using the provided saddr and daddr
> > > * update the cache.
> > > 
> > > That makes sense to me.
> > > Would you agree?
> > 
> > With dst_cache reset on float, yes. As long as we have that, the main
> > behavior seems correct to me. (maybe some corner cases will not be
> > handled optimally, but that can be improved later - which is most
> > likely what I've been discussing in these emails :))
> 
> Yeah :)
> > 
> > [this could be a useful counter to add in the future: number of floats
> > and local address updates - so the user can check if that's increasing
> > "too often", which would indicate something weird is happening]
> 
> ACK, good idea!
> 
> Thanks!
> 
> Ok, I'll probably wait a little more and then prepare v22.

I won't be able to look at it until the week-end. But if you're ready,
you can go ahead and post it anyway.

-- 
Sabrina

