Return-Path: <linux-kselftest+bounces-29740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01830A6EE4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7767516D174
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE82528E3;
	Tue, 25 Mar 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Osp+HnJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ErIcmw+O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E71EA7E7;
	Tue, 25 Mar 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900222; cv=none; b=AjPrB8HbuOFCndEelrVCAVrDqDdRK1OvTD9VGsb/2KV91ABlFait7y2G9NkA8fpND80HaDT0bHEb0fWgZJuTSHpBh6NOFAMejVWxLQy/eIX149dkoMDi9d5u3Z0trp1HmnTZ+D+TmRE1xS0amesa1eqqjqIEz1uknBTO+fHlm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900222; c=relaxed/simple;
	bh=VGuEs9GAhR2VAUZreWgSBdsNx10WltKzgPwRtTmiljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4h+xl8i6SWzs4+v/dvDx8pB9Qo4LGpC3LerLNSuTOimRfCn6p1rDZM/Eo2GpQzFa+vg/A1wcM+FoZB2UHsYV/3lBcCYyHS3CJxyEFcM07rdBVk/KUhSORiB6IEDRnTk6SmOBcBwYwOWUIaDfIAXZSdxYhHUsJGoLfvYnMyMLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Osp+HnJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ErIcmw+O; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C4EFE13835F4;
	Tue, 25 Mar 2025 06:56:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 25 Mar 2025 06:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742900217; x=
	1742986617; bh=Ka5a/lmh7xXbALpsnZjARVQPNtw4y0XXkg0IjNB40d0=; b=O
	sp+HnJ2Ox6Mm9fRvEChYVntBL0NkW3spAm6ZHLU1uuqHIRpQlAOLovqEYaCVVN4v
	eLN+WBsM8F8Iqme4n43IBct+N2rCw+L6lFK2QZAbYaNdatzE3GeoQaE8eWYxzb02
	pg7rFbDURHGuqogd8LQkt+LBe6i4H5aotykizKAwl8pDi/ri2oa/ff1KiisNozko
	/9PmTJnKZ+lTxH5fhLquwfXDcZ4hXB/Uv6ryHvlYNSMoTi7DpNFEGs4Y1hEwOaIs
	E6Lii6n1GmjN1zDZqGWz/B/d22s5OJKGqylvDMadljIpH2MlDiJXpvKPkG00YmGq
	I2qqzAz2on6rhR/6ZPJJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742900217; x=1742986617; bh=Ka5a/lmh7xXbALpsnZjARVQPNtw4y0XXkg0
	IjNB40d0=; b=ErIcmw+OPGSkLSqUV/ng4pqMZ+clg26bokn7XVWqsPlieC4cfDO
	BIfB3KqgM8RnluD2r9fEDSkl9ioxp05yVGhdcOzKBBKdysWkFSbZWtrWGoJ2gdWB
	SEEX/IXiqwQQOlHdcsBBk9bmvDYdvCW4g34gdrhD08pUZGr2CAnuhnhU8lH2spVK
	6tG5CmLrcz1iKU3I8ZYqrjlRSymmcxlJBPYGmntPiQRc5rx3NbpP+hM0q7pzGrZ0
	n4fJsYJNfTgt6zTEIM4twEQNDRtCbXRucBCHMGN6jr7l9tspKTIY9N4ngwx9R+Mf
	xtHErfFLk7lYrbsE5fP6WcMiiUlZeGT/1TQ==
X-ME-Sender: <xms:-YviZ5e7RxdEeFgcNGvRlDMbctsvCslNvKr_xKnBXFA0Vh3PnHU9mA>
    <xme:-YviZ3OlPoVDeJjr5pbnys10xdiNZtmCxDfGnk_cMiakQQw-WBlxF7AisR64c3Tdb
    -FjSOssj7IXDTUwQm8>
X-ME-Received: <xmr:-YviZygctju4dGYFDr1SdpeI3exKEjf1alO7a4-PFLKdlyeCrWlgu9646RYh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvgeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:-YviZy9ZmfP4HIfW51hKQ7KE2deTUmbghQxX1TXe4e9kDaGBUn5HVg>
    <xmx:-YviZ1v3ArQlVz00bk4jSIWWU1GwmAsBOqfs71u3RaOz5qfuBH4uLA>
    <xmx:-YviZxGwScItnx89jPhiizSpp4sYgyzB4CBFKRPQvg8yk1FXQ_rhiw>
    <xmx:-YviZ8PO2G3jCexmB6Fe3W2s2RQr8SJI13GnLrKRwB8J0wnBnZqIVQ>
    <xmx:-YviZ2Mi4kzkrGyhDR6E6IFOT2hXANJNbkfo9GFqb55vbJGaKuJJqxsu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 06:56:56 -0400 (EDT)
Date: Tue, 25 Mar 2025 11:56:54 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z-KL9jKHNayqDLi2@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-18-3ec4ab5c4a77@openvpn.net>
 <Z-E4i587M54Os5Yo@krikkit>
 <86fea40c-6b8b-4ac3-bb14-4a24c63cf167@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86fea40c-6b8b-4ac3-bb14-4a24c63cf167@openvpn.net>

2025-03-25, 00:15:48 +0100, Antonio Quartulli wrote:
> On 24/03/2025 11:48, Sabrina Dubroca wrote:
> > Hello Antonio,
> > 
> > A few questions wrt the API:
> > 
> > 2025-03-18, 02:40:53 +0100, Antonio Quartulli wrote:
> > > +static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
> > > +					 struct sockaddr_storage *ss)
> > > +{
> > > +	struct sockaddr_in6 *sin6;
> > > +	struct sockaddr_in *sin;
> > > +	struct in6_addr *in6;
> > > +	__be16 port = 0;
> > > +	__be32 *in;
> > > +
> > > +	ss->ss_family = AF_UNSPEC;
> > > +
> > > +	if (attrs[OVPN_A_PEER_REMOTE_PORT])
> > > +		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);
> > 
> > What's the expected behavior if REMOTE_PORT isn't provided? We'll send
> > packets do port 0 (which I'm guessing will get dropped on the other
> > side) until we get a message from the peer and float sets the correct
> > port/address?
> 
> I have never seen a packet going out with port 0 :)

It will if you hack into ovpn-cli to skip OVPN_A_PEER_REMOTE_PORT.
I don't know how networks/admins react to such packets.

> But being dropped is most likely what's going to happen.
> 
> I'd say this is not something that we expect the user to do:
> if the remote address if specified, the user should specify a non-zero port
> too.
> 
> We could add a check to ensure that a port is always specified if the remote
> address is there too, just to avoid the user to shoot himself in the foot.
> But we expect the user to pass an addr:port where the peer is listening to
> (and that can't be a 0 port).

If we expect that (even if a well-behaved userspace would never do
it), I have a preference for enforcing that expectation. Since there's
already a policy rejecting OVPN_A_PEER_REMOTE_PORT == 0, this would be
more consistent IMO.

An alternative would be to select a default (non-zero) port if none is
provided.

> > 
> > 
> > > +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
> > > +			       struct nlattr **attrs)
> > > +{
> > [...]
> > > +	/* when setting the keepalive, both parameters have to be configured */
> > > +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
> > > +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
> > > +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
> > > +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
> > > +		ovpn_peer_keepalive_set(peer, interv, timeout);
> > 
> > Should we interpret OVPN_A_PEER_KEEPALIVE_INTERVAL = 0 &&
> > OVPN_A_PEER_KEEPALIVE_TIMEOUT == 0 as "disable keepalive/timeout" on
> > an active peer?  And maybe "one set to 0, the other set to some
> > non-zero value" as invalid?  Setting either value to 0 doesn't seem
> > very useful (timeout = 0 will probably kill the peer immediately, and
> > I suspect interval = 0 would be quite spammy).
> > 
> 
> Considering "0" as "disable keepalive" is the current intention.
> 
> In ovpn_peer_keepalive_work_single() you can see that if either one if 0, we
> just skip the peer:
> 
> 1217         /* we expect both timers to be configured at the same time,
> 1218          * therefore bail out if either is not set
> 1219          */
> 1220         if (!peer->keepalive_timeout || !peer->keepalive_interval) {
> 1221                 spin_unlock_bh(&peer->lock);
> 1222                 return 0;
> 1223         }
> 
> does it make sense?

Ah, true. Sorry, I forgot about that.  So after _NEW/_SET we'll run
the work once, and that peer will be ignored. And if there's no other
peer requiring keepalive, next_run will be 0 and we don't
reschedule. That's good, thanks.

-- 
Sabrina

