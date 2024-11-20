Return-Path: <linux-kselftest+bounces-22343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4579D3941
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 12:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC82B2E190
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89719EED6;
	Wed, 20 Nov 2024 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Y/rDaiDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5y1mmt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064EB18660C;
	Wed, 20 Nov 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101147; cv=none; b=p5KC9Ph+fENcIXA23zMvFHgnI5idE4MCLsaIZ735eYb5V9ZvCO5N9dSK+4Eptbvd+dq93OHFiSL19dNasNZeKUkBaTOycp0yIUyt8QfT/hHnTONc3UqKOkv/aQtWlpq0hsVGOMxMOthprruwH9uiMXCrVw0Erfxsr4395Xz6oCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101147; c=relaxed/simple;
	bh=3KHS//OY/HIA0qzFt0DX5aKhWCemKs4JD8VNmLjn0dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNMczLpIxget6dYHgS/n3X6gDFx4OIaS2oTFGayHSmdi6/jp8SubT2DCXTo8a0WPKIW2aDJX2/7hLeYkNk7hufI6AZzZiZqUYnhhfUvPO1/41p2x3f87QiXMH5cQK2DmnpdkB0hvemNvSJMHdmBXGUseQQtxUBY3NQNur5k75ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Y/rDaiDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5y1mmt8; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 80E3D1D40620;
	Wed, 20 Nov 2024 06:12:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 06:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732101141; x=
	1732104741; bh=DApLaSVM4QKDiwTBCrt3VEL8I5Jx9sguAKIR2PFbkXM=; b=Y
	/rDaiDeTo2O35FAoBXtaVBVgN3CqBWhJk5nNgdscdvP2wBzK+Zjhxunb9H8M1WqG
	6H3NAI+LuvSSyFBtwXtDkg28qZA1rEe6mAPnYuFQQviApqOzXKFEMBzrVnGmOakV
	BJNgIgOG79nzJ+KOJpluAUiEgLYGtzBQ6EwhAFtkItkkpN+g9SWcbIAqI1bGOkGY
	tEtzoua8F3/ymO4kW/Qt593V72MiTB361aTr1zDzdkjjAFyjo+AVoWlHhGzgK2L0
	KuWe/5KVaEZxRgNZ4tBcigoFlOnUpX547RBoGoiY7Jz2abcZfee50LMwIPlSYyhA
	7H8uoSbwXDbc+g+RidUbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732101141; x=1732104741; bh=DApLaSVM4QKDiwTBCrt3VEL8I5Jx9sguAKI
	R2PFbkXM=; b=e5y1mmt8GPoXZDT7wyG7K/THb4GUrfZBRFUUBA0cTjGLqnnkuqD
	aGzRksZWx2UPjZmke4VlGpB7RQ95ZIRasdJ3JOSv4kXSaOiz7XomSrPyc8qg7n1N
	Civ4rl4rcBtQiqWb9Vd/VKc7smNurBnzp2ugMKklkKUmcjLZ47Wbf19UGTQq6UWC
	2MqUoyvdPqCb/vtW9eNDODGz8QMw1k/2YT5ohT2b8Btw+O2A4tji5e99JnN6ZclO
	IbMXxMow2IziocvSwcaFfRX45ot0jK+VsHxSAJdy2B6up4zTlqrZNP8JLtZtRncd
	77L3PjSdnypw/0pzgp4olh43EXkmOcvue0A==
X-ME-Sender: <xms:FMQ9Z7-FHYqPpFYtlwonyv-0bgiAmsa7Yc9jaB_tVNiC3c5FbMbeZA>
    <xme:FMQ9Z3uoxYp9LYEpclXlUDsWiC7MvPKad__Yqw76NYLRdDdknKSqbofYfeV_D4-TY
    hq_PGS9BoUZJJj1Epw>
X-ME-Received: <xmr:FMQ9Z5CWS54YWriSKekgp5s9Z5lWD432JECdi0r9LiJqAtXI6Gi2s5BwucNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggddvhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:FMQ9Z3fnF0GSKWCy84ti6WMJ7SuzmLHa9h_Pgint9-8q9SLKshRLCw>
    <xmx:FMQ9ZwM8GgFoJ_pXG5bSUfVJpmD4ogWix2tC-ms6LjUrv7ELxaYe0Q>
    <xmx:FMQ9Z5nbwHc9UMZIt_ojAQxxdPgbKtAz8hOdwLlEGfDVj8MdxGTPBQ>
    <xmx:FMQ9Z6uHEtSKXCJEP5lghMrDxWALdp59v9FMx88Noj7kHShwU9zmTA>
    <xmx:FcQ9ZxhDTTlmdZVuhbE0ROmxnI57lViz85ghqBTaQTnGUxqp5Vf5LLRb>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 06:12:20 -0500 (EST)
Date: Wed, 20 Nov 2024 12:12:18 +0100
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
Message-ID: <Zz3EEl0diYofGkIC@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
 <Zyjk781vOqV4kXhJ@hog>
 <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net>
 <ZzTaRNeZjo48ArsR@hog>
 <e11c5f81-cbc8-43a3-b275-7004efdcb358@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e11c5f81-cbc8-43a3-b275-7004efdcb358@openvpn.net>

2024-11-14, 10:21:18 +0100, Antonio Quartulli wrote:
> On 13/11/2024 17:56, Sabrina Dubroca wrote:
> > 2024-11-12, 15:19:50 +0100, Antonio Quartulli wrote:
> > > On 04/11/2024 16:14, Sabrina Dubroca wrote:
> > > > 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> > > > > +static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
> > > > > +				 struct genl_info *info,
> > > > > +				 struct nlattr **attrs)
> > > > > +{
> > > > > +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> > > > > +			      OVPN_A_PEER_ID))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
> > > > > +		NL_SET_ERR_MSG_MOD(info->extack,
> > > > > +				   "cannot specify both remote IPv4 or IPv6 address");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> > > > > +	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
> > > > > +		NL_SET_ERR_MSG_MOD(info->extack,
> > > > > +				   "cannot specify remote port without IP address");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> > > > > +	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
> > > > > +		NL_SET_ERR_MSG_MOD(info->extack,
> > > > > +				   "cannot specify local IPv4 address without remote");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
> > > > > +	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {
> > > > 
> > > > I think these consistency checks should account for v4mapped
> > > > addresses. With remote=v4mapped and local=v6 we'll end up with an
> > > > incorrect ipv4 "local" address (taken out of the ipv6 address's first
> > > > 4B by ovpn_peer_reset_sockaddr). With remote=ipv6 and local=v4mapped,
> > > > we'll pass the last 4B of OVPN_A_PEER_LOCAL_IPV6 to
> > > > ovpn_peer_reset_sockaddr and try to read 16B (the full ipv6 address)
> > > > out of that.
> > > 
> > > Right, a v4mapped address would fool this check.
> > > How about checking if both or none addresses are v4mapped? This way we
> > > should prevent such cases.
> > 
> > I don't know when userspace would use v4mapped addresses,
> 
> It happens when listening on [::] with a v6 socket that has no "IPV6_V6ONLY"
> set to true (you can check ipv6(7) for more details).
> This socket can receive IPv4 connections, which are implemented using
> v4mapped addresses. In this case both remote and local are going to be
> v4mapped.

I'm familiar with v4mapped addresses, but I wasn't sure the userspace
part would actually passed them as peer. But I guess it would when the
peer connects over ipv4 on an ipv6 socket.

So the combination of PEER_IPV4 with LOCAL_IPV6(v4mapped) should never
happen? In that case I guess we just need to check that we got 2
attributes of the same type (both _IPV4 or both _IPV6) and if we got
_IPV6, that they're either both v4mapped or both not. Might be a tiny
bit simpler than what I was suggesting below.

> However, the sanity check should make sure nobody can inject bogus
> combinations.
>
> > but treating
> > a v4mapped address as a "proper" ipv4 address should work with the
> > rest of the code, since you already have the conversion in
> > ovpn_nl_attr_local_ip and ovpn_nl_attr_sockaddr_remote. So maybe you
> > could do something like (rough idea and completely untested):
> > 
> >      static int get_family(attr_v4, attr_v6)
> >      {
> >         if (attr_v4)
> >             return AF_INET;
> >         if (attr_v6) {
> >             if (ipv6_addr_v4mapped(attr_v6)
> >                 return AF_INET;
> >             return AF_INET6;
> >         }
> >         return AF_UNSPEC;
> >      }
> > 
> > 
> >      // in _precheck:
> >      // keep the   attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]  check
> >      // maybe add a similar one for   LOCAL_IPV4 && LOCAL_IPV6
> 
> the latter is already covered by:
> 
>  192         if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>  193             attrs[OVPN_A_PEER_LOCAL_IPV4]) {
>  194                 NL_SET_ERR_MSG_MOD(info->extack,
>  195                                    "cannot specify local IPv4 address
> without remote");
>  196                 return -EINVAL;
>  197         }
>  198
>  199         if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
>  200             attrs[OVPN_A_PEER_LOCAL_IPV6]) {
>  201                 NL_SET_ERR_MSG_MOD(info->extack,
>  202                                    "cannot specify local IPV6 address
> without remote");
>  203                 return -EINVAL;
>  204         }

LOCAL_IPV4 combined with REMOTE_IPV6 should be fine if the remote is
v4mapped. And conversely, LOCAL_IPV6 combined with REMOTE_IPV6 isn't
ok if remote is v4mapped. So those checks should go away and be
replaced with the "get_family" thing, but that requires at most one of
the _IPV4/_IPV6 attributes to be present to behave consistently.


> > 
> >      remote_family = get_family(attrs[OVPN_A_PEER_REMOTE_IPV4], attrs[OVPN_A_PEER_REMOTE_IPV6]);
> >      local_family = get_family(attrs[OVPN_A_PEER_LOCAL_IPV4], attrs[OVPN_A_PEER_LOCAL_IPV6]);
> >      if (remote_family != local_family) {
> >          extack "incompatible address families";
> >          return -EINVAL;
> >      }
> > 
> > That would mirror the conversion that
> > ovpn_nl_attr_local_ip/ovpn_nl_attr_sockaddr_remote do.
> 
> Yeah, pretty much what I was suggested, but in a more explicit manner.
> I like it.

Cool.

BTW, I guess scope_id should only be used when it's not a v4mapped address?
So the "cannot specify scope id without remote IPv6 address" check
should probably use:

    if (remote_family != AF_INET6)

(or split it into !attrs[OVPN_A_PEER_REMOTE_IPV6] and remote_family !=
AF_INET6 to have a fully specific extack message, but maybe that's
overkill)

-- 
Sabrina

