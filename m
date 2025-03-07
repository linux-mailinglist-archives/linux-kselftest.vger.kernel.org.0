Return-Path: <linux-kselftest+bounces-28471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F92A564DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE150175EFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D120DD7F;
	Fri,  7 Mar 2025 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LVQ6ggg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkuUJvPY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AF20CCF5;
	Fri,  7 Mar 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342374; cv=none; b=BGyz/VTrGXD08Cz48brJPdPNmO+buZKcTZ3uvwMN3gb4cH3/1HP0HU7GxJv9QT60YwyzjXdsJf0AGnJiYXfgJPcPmcT4uwsi78qE9Paupj0mAIDwz/mLKc/kyi+CecXE9tJJF6U8iy7nZxpwPeURqLx3QBhl+EnWyPc7GLPBMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342374; c=relaxed/simple;
	bh=9uIC5gZH8Qm7HDH6SwlK89APamrJxmZZP5bnWb+3pf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu4MM/Er6mIur1hgmH90e7J0AQOrGjslztTNgPA7HCTQNYXDBk78ya53jrJuDGdV+ajYif+VGM3cnQWnVvrvUWzMzEm1rwbqrDS6G84QWgCqhrvNeryvE8c0miXCdiXcdA4/r7AwcUi5gX6vR5p3OLhJUadOzAWSy6nK+Ae5oTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LVQ6ggg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkuUJvPY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB8AB25401C3;
	Fri,  7 Mar 2025 05:12:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 05:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741342368; x=
	1741428768; bh=qHQnYT/Qyj9dWXE+hev7Uqrdhl7JEOFfEEcRNdgyx2I=; b=L
	VQ6ggg1uTqb7YhLEiEMuTCpkK6J55k/cUrCgcDcZmZJHAHOtvN132XlQsAQ7W4oy
	LmoqRVYLPCFly8nZeAfgfURXgDq+Ve3HH/r/I49tCaPIG0JIn2dZNjB34cJ3GJsm
	NPW1bSJYNlOHfNVdUAWof91qI+FnIfYNK24G803Mbx08IQcVz6QUrZTFGTRE1P45
	E6So1mIh1SiI4CsixBroogl+W1095Ca5Nd0gWD8HSp8BiuIx+1YbuuGleCm87yn5
	6U2XXprRVYJA7D6jwFUtjWrdtc9iFxmRosqt4X8blJDLVS6fHPxoDgOKDa8A+XqU
	xTot1fJBJQbSkCbvO/jAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741342368; x=1741428768; bh=qHQnYT/Qyj9dWXE+hev7Uqrdhl7JEOFfEEc
	RNdgyx2I=; b=mkuUJvPY3b/cGMcdym4n2sD7Xv1vEn0e8Gs87hz2tOMnK7GQj5o
	eWPiTsxA3YVQ0DahT/J4fE+w9J+ryVSacNudMd5BdDuP+NSYJtDmchKo/2BxXzei
	ZDLBXHDjuLmR/EJABKRRpGJoTDWv/pwBcIEx+mcoL3XBaFsgNk00TIFDW1DpmF5e
	ZwlR476pH25wAKEbgGEhZOVlAU9i6zewHxUtIPP0wNLKVUgytcXM3jyEYfFNxUsC
	OZRhEIzLykOkz099FEb7/hur4m/cY48Bd0wAMJ8a5OuUn7nGWjx4fCvHHuHkdSxm
	XXT2Pd4mRqzVmuCeN8HIoAYBk/uJY8Ypnpw==
X-ME-Sender: <xms:oMbKZw6R9jVOMyg5qNb_fS5q0ppeisHdSYlDhBygyBaDekNnNIzDbg>
    <xme:oMbKZx5zLKVwuBZcD7xi4VA80aBonb0Y2oU1b3U3yy8NLoR9wtiwriR4cruLMlsHU
    1_lu3_M-bgLxWiNQIM>
X-ME-Received: <xmr:oMbKZ_dPYl73KXtjaC1fceRhcAFqBiDkFxBP7kg5xbmKtz6HuGNp5G8M4ck8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtfeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oMbKZ1JiS7ItpmdrVIHsUgCb54-z7hIekeGvw22wtrIS0WKV1qw30Q>
    <xmx:oMbKZ0JNSqDPSYZ2CaElrCP3cOf2xJ5xb7XaMBgXaExrNsH4CFxnCg>
    <xmx:oMbKZ2zNyvY2IKWNs08SBicNxeS7NdABDXIkf6ZZrMkxMlG4SDCbQg>
    <xmx:oMbKZ4IQFsPSi8H6GHOdf9G23jMTvUithDaNPgvTXgjcsRLQmKLHQg>
    <xmx:oMbKZ3Z1jwjygpZeMHxzIoxnZwuWTdjf0zZE_eeoy1aVrRroofwts9vr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 05:12:47 -0500 (EST)
Date: Fri, 7 Mar 2025 11:12:45 +0100
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
Message-ID: <Z8rGnTaRE_mph_tD@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net>
 <Z8dIXjwZ3QmiEcd-@hog>
 <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
 <Z8gzbz6YjdeGPqgu@hog>
 <cd9df084-8633-49f0-a851-ed2b1c9946d3@openvpn.net>
 <Z8iCKvIfFaskshlz@hog>
 <e3def5b5-3450-4ad0-aced-fd80af943c31@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3def5b5-3450-4ad0-aced-fd80af943c31@openvpn.net>

2025-03-06, 11:02:50 +0100, Antonio Quartulli wrote:
> On 05/03/2025 17:56, Sabrina Dubroca wrote:
> > 2025-03-05, 14:14:36 +0100, Antonio Quartulli wrote:
> > > On 05/03/2025 12:20, Sabrina Dubroca wrote:
> > > > 2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
> > > > > On 04/03/2025 19:37, Sabrina Dubroca wrote:
> > > > > > 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
> > > > > > > +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> > > > > > > +{
> > > > > > > +	struct hlist_nulls_head *nhead;
> > > > > > > +	struct sockaddr_storage ss;
> > > > > > > +	const u8 *local_ip = NULL;
> > > > > > > +	struct sockaddr_in6 *sa6;
> > > > > > > +	struct sockaddr_in *sa;
> > > > > > > +	struct ovpn_bind *bind;
> > > > > > > +	size_t salen = 0;
> > > > > > > +
> > > > > > > +	spin_lock_bh(&peer->lock);
> > > > > > > +	bind = rcu_dereference_protected(peer->bind,
> > > > > > > +					 lockdep_is_held(&peer->lock));
> > > > > > > +	if (unlikely(!bind))
> > > > > > > +		goto unlock;
> > > > > > > +
> > > > > > > +	switch (skb->protocol) {
> > > > > > > +	case htons(ETH_P_IP):
> > > > > > > +		/* float check */
> > > > > > > +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
> > > > > > > +			if (bind->remote.in4.sin_family == AF_INET)
> > > > > > > +				local_ip = (u8 *)&bind->local;
> > > > > > 
> > > > > > If I'm reading this correctly, we always reuse the existing local
> > > > > > address when we have to re-create the bind, even if it doesn't match
> > > > > > the skb? The "local endpoint update" chunk below is doing that, but
> > > > > > only if we're keeping the same remote? It'll get updated the next time
> > > > > > we receive a packet and call ovpn_peer_endpoints_update.
> > > > > > 
> > > > > > That might irritate the RPF check on the other side, if we still use
> > > > > > our "old" source to talk to the new dest?
> > > > > > 
> > > > > > > +			sa = (struct sockaddr_in *)&ss;
> > > > > > > +			sa->sin_family = AF_INET;
> > > > > > > +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> > > > > > > +			sa->sin_port = udp_hdr(skb)->source;
> > > > > > > +			salen = sizeof(*sa);
> > > > > > > +			break;
> > > > > 
> > > > > I think the issue is simply this 'break' above - by removing it, everything
> > > > > should work as expected.
> > > > 
> > > > Only if the bind was of the correct family? Checking an IPv4 local
> > > > address (in the bind) against an IPv6 source address in the packet (or
> > > > the other way around) isn't going to work well.
> > > 
> > > Ah I understand what you mean.
> > > 
> > > The purpose of "local_ip" is to provide a working local endpoint to be used
> > > with the new remote address.
> > > However, if the float is switching family we can't re-use the same old local
> > > endpoint (hence the check).
> > > In this case we'll learn the "new" local address later.
> > > 
> > > Does it make sense?
> > 
> > Sure, but we could have learned it immediately from the packet we just
> > got, whether we're changing family or not. No need to wait for the
> > next RX packet to also learn the new local address.
> 
> Indeed.
> 
> > 
> > But if we now do a dst_cache_reset with the peer float,
> > ovpn_udp*_output will have to do a new route/local address lookup and
> > I guess that should clean up the local address stored in the bind, and
> > then update the dst_cache with the local address we just found.
> 
> Right and this may not truly be what we want.
> 
> If peer X is sending packets to our IP1, we should at least try to reply
> from the same address.
>
> If we have two IPs, IP1 and IP2, and both can be used to reach peer X, we
> should always try to use the one where we received traffic from X in the
> first place.

I had a thought that it might not be our prefered address to talk to
X, but it would probably be, since we decided to use it (and thus X
used it as remote to talk to us).

> OTOH hand it is also true that with floating detection on both sides, the
> situation will converge quickly, but there might be a reason why X chose IP1
> as destination, therefore we should do our best to respect that.

And I guess the primary reason for X to choose IP1 would be "we sent
packets to X from IP1".

> So, even in case of float, we should still store the local endpoint and
> attempt fetching a route that takes that into consideration.
> Which I think is what is happening (assuming we reset the dst_cache on
> float).

Not at the same time as float, unless ovpn_peer_endpoints_update sets
local_ip = ip_hdr(skb)->daddr unconditionally on float?

Otherwise the next route lookup in ovpn_udpX_output will pick whatever
source address it wants (which would likely match what's in the
received skb during float, so probably fine anyway).

> ovpn_udpX_output() will:
> * get no rt from the cache
> * possibly confirm that saddr is ok
> * fetch the new rt using the provided saddr and daddr
> * update the cache.
> 
> That makes sense to me.
> Would you agree?

With dst_cache reset on float, yes. As long as we have that, the main
behavior seems correct to me. (maybe some corner cases will not be
handled optimally, but that can be improved later - which is most
likely what I've been discussing in these emails :))

[this could be a useful counter to add in the future: number of floats
and local address updates - so the user can check if that's increasing
"too often", which would indicate something weird is happening]

-- 
Sabrina

