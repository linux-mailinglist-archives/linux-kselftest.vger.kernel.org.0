Return-Path: <linux-kselftest+bounces-24742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD2A1557F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45113A1A18
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9D1A00FA;
	Fri, 17 Jan 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="z+yYSnOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqIP7LZa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF719D098;
	Fri, 17 Jan 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133975; cv=none; b=B4rWuqv/5OMPXZwFcoUPlpZL0s9JkIoxcow3BbuPzFZbyVIVqg/sAdBb4NxAXNyqdU5Z4jPfqDr0mThSn116CPeud3K6aStKOwMZJyRX38LKi5H4Z8lSiJ8S2fJCPR/GbwsjPF1Bra9JGzU2u21EWWpU3gSZPoWZmgrKEwC+9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133975; c=relaxed/simple;
	bh=W5wGK/Y8ktpn6/aur6KV/qLNQ4ace4+kf2KM30SWmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKb2DL22ht5SsEWYn4vnvAOly6uM7az9eMMR7pdAbU8OjT5DK3jWRMJleqwgEXa5ZCj6ljwaBrRMN++RrhKYX+ciieGEA5hUCj+L5c7Raht8baVCSzR25VuMWhbVdZ7Rbr4HS/E4t2Qe2yBoBjQQrgqn5Oel9epq80PSq+2Jn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=z+yYSnOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqIP7LZa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0979D254019B;
	Fri, 17 Jan 2025 12:12:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jan 2025 12:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1737133969; x=
	1737220369; bh=Sj5SokLTzsfLlMMuekU52yIDWRRKGO0rNyAhA8UBRMA=; b=z
	+yYSnOi7dCuc8WUp+Bor2BXMoDZXM0ZyiYAjZi2w78hn19vTCXLLQAnJ9nxIFLbt
	TfVbiGswicQoHKXzscjZ2/KI/vYadIKLahYWQuZofnRPQXV+Nkjj3tFBRMMvQZMD
	S8G1YJfjI5r9ft6MbFOjMKOavJB/sdwPKonTZg6+b8h+K0/n59JvCWv7KCHsIwPL
	llBycDF82AkWdrX6RxXWKkokXrCfm6K4oESbEvMd9JTQARTkxbsnIXXIVdkAdEBl
	IsyIug1SXo2eN5vH0L3vbFaxYyuyzBSso5ztvVDHNXltm3WEApwCnT3LAQxbbfp8
	QGPIE8qUlgGud8spcsoZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737133969; x=1737220369; bh=Sj5SokLTzsfLlMMuekU52yIDWRRKGO0rNyA
	hA8UBRMA=; b=mqIP7LZaxYNoDPWwl6h2e/L6IwIPKOX14Q/fkN6pt2htWRfMSM3
	OfAZY5CCgKBuk5HG+slobUtmR4YKAZ72Vn3RxDAY6k43XCVG4wwGXxnsPDEZPhtx
	eU7a7Rc2V4AkJto4rZSNDK/r8hBYuMLLvQAXDIAQkk3V/9zPKnmjf9uwLbO2ApF6
	myQdF0hTNPK3qFnEos7hSK9AM2b558Nx6D6qW1miy1RgF2z/yu1nq3J/haZ8LNqn
	D7i2tLiTWYQ/4BgJGL/xAK6gteP5jVDSJloqQZsfKHovG0txXQfIogdTtZuRLGz/
	liMEjbOpqovn0if4s5N0An8mSkNpqwdJsjA==
X-ME-Sender: <xms:kY-KZ87CqiarEEaW8L8RLU5DBvbFki_Wmts0svouj2lrej8g6_X6Hg>
    <xme:kY-KZ94hmGMx_5sivs82ehWEPPS7nug0r7m9Tvc3m7TKr77zNnvADnq0b852TotxQ
    hzRuraK41qmuuAwhGk>
X-ME-Received: <xmr:kY-KZ7c3PMo1RpD5C9H4VcD82dhURMaNiLmSxA3mIYDjg1ujVHBihD8HHX20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfet
    ffeffefghedvvefhjeejvdekfeelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    peguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhes
    lhhunhhnrdgthh
X-ME-Proxy: <xmx:kY-KZxKPSYlyALeCxvMbftJsAkrHi0xnM6y-Cjb9-UaNqMqv4NlU9w>
    <xmx:kY-KZwLbt0fJ9bE0ng-L_mZ4VZ9BubSBIUWtdkqgH6Dh9fgx4ap4sg>
    <xmx:kY-KZyyoytqgXE5IXeVlhyYqw1GjWYV7kA2XlITaFIrIsdz_DA3D6w>
    <xmx:kY-KZ0K0jt55yLG99Ju9UuyrFbkXtZoHliCBo0Eu3jjxs0zgorevfA>
    <xmx:kY-KZzZei-E2mWfYlcmF96D9ECa4KVXge4khHHkZuTMkBajplN5EUU8k>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 12:12:48 -0500 (EST)
Date: Fri, 17 Jan 2025 18:12:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z4qPjuK3_fQUYLJi@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net>

2025-01-17, 13:59:35 +0100, Antonio Quartulli wrote:
> On 17/01/2025 12:48, Sabrina Dubroca wrote:
> > 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
> > >   int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
> > >   {
> > > -	return -EOPNOTSUPP;
> > > +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> > > +	struct ovpn_priv *ovpn = info->user_ptr[0];
> > > +	struct ovpn_socket *ovpn_sock;
> > > +	struct socket *sock = NULL;
> > > +	struct ovpn_peer *peer;
> > > +	u32 sockfd, peer_id;
> > > +	int ret;
> > > +
> > > +	/* peers can only be added when the interface is up and running */
> > > +	if (!netif_running(ovpn->dev))
> > > +		return -ENETDOWN;
> > 
> > Since we're not under rtnl_lock here, the device could go down while
> > we're creating this peer, and we may end up with a down device that
> > has a peer anyway.
> 
> hmm, indeed. This means we must hold the rtnl_lock to prevent ending up in
> an inconsistent state.
> 
> > 
> > I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
> > trying to accomplish. Is it a problem to keep peers when the netdevice
> > is down?
> 
> This is the result of my discussion with Sergey that started in v23 5/23:
> 
> https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/
> 
> The idea was to match operational state with actual connectivity to peer(s).
> 
> Originally I wanted to simply kee the carrier always on, but after further
> discussion (including the meaning of the openvpn option --persist-tun) we
> agreed on following the logic where an UP device has a peer connected (logic
> is slightly different between MP and P2P).
> 
> I am not extremely happy with the resulting complexity, but it seemed to be
> blocker for Sergey.

[after re-reading that discussion with Sergey]

I don't understand why "admin does 'ip link set tun0 down'" means "we
should get rid of all peers. For me the carrier situation goes the
other way: no peer, no carrier (as if I unplugged the cable from my
ethernet card), and it's independent of what the user does (ip link
set XXX up/down). You have that with netif_carrier_{on,off}, but
flushing peers when the admin does "ip link set tun0 down" is separate
IMO.

[...]
> > >   int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
> > >   {
> > > -	return -EOPNOTSUPP;
> > > +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> > > +	struct ovpn_priv *ovpn = info->user_ptr[0];
> > > +	struct ovpn_peer *peer;
> > > +	u32 peer_id;
> > > +	int ret;
> > > +
> > > +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
> > > +		return -EINVAL;
> > > +
> > > +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
> > > +			       ovpn_peer_nl_policy, info->extack);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> > > +			      OVPN_A_PEER_ID))
> > > +		return -EINVAL;
> > > +
> > > +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
> > > +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
> > > +	if (!peer) {
> > > +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +				       "cannot find peer with id %u", peer_id);
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
> > > +	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
> > 
> > With the delayed socket release (which is similar to what was in v11,
> > but now with refcounting on the netdevice which should make
> > rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
> > userspace as if the peer was gone, but the socket hasn't been detached
> > yet.
> > 
> > A userspace application that tries to remove the peer and immediately
> > re-create it with the same socket could get EBUSY if the workqueue
> > hasn't done its job yet. That would be quite confusing to the
> > application.
> 
> This may happen only for TCP, because in the UDP case we would increase the
> refcounter and keep the socket attached.

Not if we're re-attaching to a different ovpn instance/netdevice.

> 
> However, re-attaching the same TCP socket is hardly going to happen (in TCP
> we have one socket per peer, therefore if the peer is going away, we're most
> likely killing the socket too).
> 
> This said, the complexity added by the completion seems quite tiny,
> therefore I'll add the code you are suggesting below.

Ok.

-- 
Sabrina

