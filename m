Return-Path: <linux-kselftest+bounces-21953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73749C7964
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C53B2834B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE51E1037;
	Wed, 13 Nov 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="r0AXdNlU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iF6RUUFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C314F114;
	Wed, 13 Nov 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517004; cv=none; b=bFbmPzbLBfa35V9/dyEr9dZ7dqo2pM4dIIZfqWGotLkn7BfqwzNf49goRZekfV/TBB8Z9JbCx99MCjSp+PKYoow3YnnZgHWsZnY0DYEhp3p8T2CikSYf9+lBY+mnvsJFbhdJzGhX7c9H5Q7Teu/XvL3M5GxBsQWnb+6fl3sJeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517004; c=relaxed/simple;
	bh=Gln7f93bMjVMGM8xqXr/FHKCuVM+DsDKYRfLO5thCqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t36AS9YfkIGvxmmbKYxZ5BJgi1/xfLnkZnX+XfFoMYLzs2f/w4H37ESIHH8SUw2rvVowObvSun+lEGcq47wKrpyjzCV+EW4dAdrX57a5BPM5LmLUAAkaLUrQ7U0YlQMxYuky/29KCnARaEtuv1FvwznIjVSxRO1a7sfh0AZBic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=r0AXdNlU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iF6RUUFg; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 5DC3F202C79;
	Wed, 13 Nov 2024 11:56:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 11:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731516999; x=
	1731520599; bh=SP9rlrFBpcmQ6qKKULiRCZbz8BEPn3pzFUcaZuEaIt8=; b=r
	0AXdNlU0anIB8CPrpnEyAD2XxZrL1kCJqpecobCcuaQzJeASnNO0cZyZeKVL/nqo
	2zLl3T96oxzDPJA75HkVwFpzbRYudsWrImuquUSKdgPxl0u3rJdJMUlawqR24IKR
	XOAg181QzkYWaFftZWToq6rRQStcfC+pSUicW5nQLoGFxE17y+FWTl6d3hDXLUNT
	tDqxqTk1zT/jQ0UK5Iq5MrzOSImWBECPDgTtJ77rmrJ3qV9DB3cGzFsSX7/72fZJ
	D+QvKPOfGfDXciwvG23NaVOZyWgA3lw5M3Q5PtzK6wz2MdtQN3Os4+2Mvvc+jPQF
	TvSpcSPS5GFrYSk/QP5Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731516999; x=1731520599; bh=SP9rlrFBpcmQ6qKKULiRCZbz8BEPn3pzFUc
	aZuEaIt8=; b=iF6RUUFgdferwXcDgGkd09QsXwqMEaoT8HoltP6UFq4Ujunj0QV
	hsSjJNocVn0587t52oIsnrsDfBDy5hXWEgXSFKOkVK0xMudAmR9/EiWi4Jqk4fyM
	DFOSmoRlgxOyXtx7iV8XSY/Ql7vbr8GhWWvAl1lGd0ik/L1pTgGNDD56X5Cv0cZI
	YyKHCOBXYDqq1CtvpnXY2UDf/wOrFgqHu2ksJ/NsuX3z5WMIWatxbzidXRDQaCNa
	hXQMG8wnJ1rLf1HQsVPYnMN6dyRljhlJ2TA0Zuyux5ugbhA0tEZriQ7+2JfrbJwx
	EQfHTakD/BdB3dHqB6f0BPc7LW9yhMBpKSg==
X-ME-Sender: <xms:Rto0Z5fL_VdDY9UywVksG2h2QXlviah0MpCQPVQDzHMv5qsxLq1poQ>
    <xme:Rto0Z3N1I2UDCMZu0wxPATkC0lvu7x7pEOqYx9-4_Ns5LTDdved5cCi29QdEtGzc6
    X4EnK8PPQYhq6AuRoM>
X-ME-Received: <xmr:Rto0ZyisAuMpR9ch-_EmqCmM5dxoQqdSjawn2rozLu3K1eyh8rzeYiTp2ezx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhu
    nhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Rto0Zy-pkriPlH_BMJvCH8carHqd_rn0lz0RZ46T_giYfIQk1LTZ1g>
    <xmx:Rto0Z1sHClCbXPfAVpaB9ryK3SqsjT0JfYpdDToTf0J4nmzb-43EQg>
    <xmx:Rto0ZxGAq0lJade3WxcBFG_tTPbXz3EAbvnh35z3QPxUGpRNSHl6sg>
    <xmx:Rto0Z8NeXrN8tO1_5N6mSGf0j3kxSafTgQz2J1Z0PbA8qaUgwtfxeg>
    <xmx:R9o0Z7Du1OK8x-SwQljn3rHODjsLBQeqGwS1xaWY8GTR4s8kKEu1PfT->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 11:56:38 -0500 (EST)
Date: Wed, 13 Nov 2024 17:56:36 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <ZzTaRNeZjo48ArsR@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
 <Zyjk781vOqV4kXhJ@hog>
 <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net>

2024-11-12, 15:19:50 +0100, Antonio Quartulli wrote:
> On 04/11/2024 16:14, Sabrina Dubroca wrote:
> > 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> > > +static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
> > > +				 struct genl_info *info,
> > > +				 struct nlattr **attrs)
> > > +{
> > > +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> > > +			      OVPN_A_PEER_ID))
> > > +		return -EINVAL;
> > > +
> > > +	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
> > > +		NL_SET_ERR_MSG_MOD(info->extack,
> > > +				   "cannot specify both remote IPv4 or IPv6 address");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> > > +	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
> > > +		NL_SET_ERR_MSG_MOD(info->extack,
> > > +				   "cannot specify remote port without IP address");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> > > +	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
> > > +		NL_SET_ERR_MSG_MOD(info->extack,
> > > +				   "cannot specify local IPv4 address without remote");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
> > > +	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {
> > 
> > I think these consistency checks should account for v4mapped
> > addresses. With remote=v4mapped and local=v6 we'll end up with an
> > incorrect ipv4 "local" address (taken out of the ipv6 address's first
> > 4B by ovpn_peer_reset_sockaddr). With remote=ipv6 and local=v4mapped,
> > we'll pass the last 4B of OVPN_A_PEER_LOCAL_IPV6 to
> > ovpn_peer_reset_sockaddr and try to read 16B (the full ipv6 address)
> > out of that.
> 
> Right, a v4mapped address would fool this check.
> How about checking if both or none addresses are v4mapped? This way we
> should prevent such cases.

I don't know when userspace would use v4mapped addresses, but treating
a v4mapped address as a "proper" ipv4 address should work with the
rest of the code, since you already have the conversion in
ovpn_nl_attr_local_ip and ovpn_nl_attr_sockaddr_remote. So maybe you
could do something like (rough idea and completely untested):

    static int get_family(attr_v4, attr_v6)
    {
       if (attr_v4)
           return AF_INET;
       if (attr_v6) {
           if (ipv6_addr_v4mapped(attr_v6)
               return AF_INET;
           return AF_INET6;
       }
       return AF_UNSPEC;
    }


    // in _precheck:
    // keep the   attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]  check
    // maybe add a similar one for   LOCAL_IPV4 && LOCAL_IPV6

    remote_family = get_family(attrs[OVPN_A_PEER_REMOTE_IPV4], attrs[OVPN_A_PEER_REMOTE_IPV6]);
    local_family = get_family(attrs[OVPN_A_PEER_LOCAL_IPV4], attrs[OVPN_A_PEER_LOCAL_IPV6]);
    if (remote_family != local_family) {
        extack "incompatible address families";
        return -EINVAL;
    }

That would mirror the conversion that
ovpn_nl_attr_local_ip/ovpn_nl_attr_sockaddr_remote do.

> > >   int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > >   {
> > [...]
> > > +	} else {
> > > +		rcu_read_lock();
> > > +		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer,
> > > +				  hash_entry_id) {
> > > +			/* skip already dumped peers that were dumped by
> > > +			 * previous invocations
> > > +			 */
> > > +			if (last_idx > 0) {
> > > +				last_idx--;
> > > +				continue;
> > > +			}
> > 
> > If a peer that was dumped during a previous invocation is removed in
> > between, we'll miss one that's still present in the overall dump. I
> > don't know how much it matters (I guses it depends on how the results
> > of this dump are used by userspace), so I'll let you decide if this
> > needs to be fixed immediately or if it can be ignored for now.
> 
> True, this is a risk I assumed.
> Not extremely important if you ask me, but do you have any suggestion how to
> avoid this in an elegant and lockless way?

No, inconsistent dumps are an old problem with netlink, so I'm just
mentioning it as something to be aware of. You can add
genl_dump_check_consistent to let userspace know that it may have
gotten incorrect information (you'll need to keep a counter and
increment it when a peer is added/removed). On a very busy server you
may never manage to get a consistent dump, if peers are going up and
down very fast.

There's been some progress for dumping netdevices in commit
759ab1edb56c ("net: store netdevs in an xarray"), but that can still
return incorrect data.

-- 
Sabrina

