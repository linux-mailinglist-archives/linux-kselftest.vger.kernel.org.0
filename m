Return-Path: <linux-kselftest+bounces-22347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E09D3A50
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 13:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA5E285DF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F95119F46D;
	Wed, 20 Nov 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="EOQfnWS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frPbeIEM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772017BB2E;
	Wed, 20 Nov 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104636; cv=none; b=dry1NBUnB7G2DNtk2/qVFnwdI1l2JixyvLqMi+GjtjV8tGZYZl627MX0z4PK1D8i2pumbNurcca6FLWQDqDXQL/N8jIbdru9JIraqGvyZvhMwiKGnJys7dcORvTQyi8EeTAZgUvfBs2V2hOtT+kUYkRvPkdopLYP0u0VZMN1OIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104636; c=relaxed/simple;
	bh=arYIs0WI2oFKiwqfwGGuHB9wHDdg/L8Vdn0NmUU4MC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpNs5mk7sF+LAIaliJCIpkYFEtmN4+C/+1YgF9iAGyoMcDuOiIBXCyue3J6wJeifgrLZ/2wP/ezjx3G1vkBk8myc3UG5sJIMtocQCG0skmwfC2OJcm6qfltsSl2Vf5Ds6EOJm9atMGRt4y2ol1S7+KK5yDoRyAdsSNorED0FkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=EOQfnWS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frPbeIEM; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 2F6D320061A;
	Wed, 20 Nov 2024 07:10:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 07:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732104632; x=
	1732108232; bh=ftenL7oXDAIby6AH0oNGjJ9lCyrSb5vjQey2CE6xdwI=; b=E
	OQfnWS4IfJENlhhrSXx20lz9puimusp69bwZuplk3Aykj9kFCpAYV3gcj6O9NmPq
	p2F0QPaDInpyNQsGD+lCLS9/QKtyXrdb7JGJP3QI6qudJl08buIQVQoDScz+T8lz
	rR4f3Zf93pBEs9oZU66rMdz4gnB3haVwkUzvygZizRFL29P+QObPOM/JRuPHCOAY
	db50KFUME+vLQG/fnoRzq7TscQesOe8zbe9Qjl5eLpYFz+UIbOx8qmqp/DX5B2eb
	z3abfq6IuqfM0VhKJE4MH74tPPhvBRWDAfizDkvkzuaL8UFMmLADDphRF+VxsOZc
	8X4d/dOD33t9MP/VBMYXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732104632; x=1732108232; bh=ftenL7oXDAIby6AH0oNGjJ9lCyrSb5vjQey
	2CE6xdwI=; b=frPbeIEMu/o8pmfNNkdgx+20pbQAb/cbBjKdAm4WwbgMuvYTYLP
	SaTrLJsMiKCesA5a2dHuyZRD0b4Dj5EsJxk7B1iaoWJOMltwQ+l7Ckf+lrsp2NRq
	sst7x66T5J0+Y/CzT4pQsBIjCr5gXhiLPlUx+m8QVevOqLCm5wTmHImT7/JcK/VA
	Bzf14M3YGOuwNmJo9CoDjj1w6jDhj1e8D+one088CkQ/6G2Vn8KJNzGsbuBbZaim
	9duN74OeFJVkmdn1dq03FdgbWdkZrY8mX9pe9RagJ8A2h78CGGPFm9Qh7aPc5P61
	ujUYPAk41IaLw4QY6pt459zAc7HjwPABlaQ==
X-ME-Sender: <xms:t9E9ZyttSRIWM8Uk4tBhDnZorN20OEU4TBsBpNvZpoZKNeJijd5xlg>
    <xme:t9E9Z3c58vYLXx5NpT03TMYCCJE0-S7MB7hFI0n4bvqpLbnOpcNDrkp6TUvBB4taE
    ehrU3mgBMI2iBS3w1I>
X-ME-Received: <xmr:t9E9Z9y51-coP26pvdOkYZ4KGhLgAUbYdCqdt-iKQPqwxeTrTPkxHwnCaij->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdefjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:t9E9Z9M2ietY6q1NJRbn8EGIwIiaenDxpxUuxc38Yo9wRT2lClBGdQ>
    <xmx:t9E9Zy-udVEJ8tXspghFboEVbdKOs8x4Oj6lXppKYezNtke6MuZpAg>
    <xmx:t9E9Z1UA1D9B8gGRg1gk8ukdEYVPMKJJtJz5Bl6SosXrnt0X2zJNcw>
    <xmx:t9E9Z7cTihydfJsJJhUUqIoMsNn7QtXCE8cxZrqiMO9XBA4pkSK9VA>
    <xmx:t9E9Z2TRmHz4V6ktC0l4Af-O5zWaPPhKTuvgGof7fFK9MJrfYYYRwzdq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:10:31 -0500 (EST)
Date: Wed, 20 Nov 2024 13:10:29 +0100
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
Message-ID: <Zz3Rta7DjZoJb15y@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
 <Zyjk781vOqV4kXhJ@hog>
 <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net>
 <ZzTaRNeZjo48ArsR@hog>
 <e11c5f81-cbc8-43a3-b275-7004efdcb358@openvpn.net>
 <Zz3EEl0diYofGkIC@hog>
 <28447817-028e-4c5c-ae7e-3ffa86de9bf1@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28447817-028e-4c5c-ae7e-3ffa86de9bf1@openvpn.net>

2024-11-20, 12:34:08 +0100, Antonio Quartulli wrote:
> On 20/11/2024 12:12, Sabrina Dubroca wrote:
[...]
> > > > I don't know when userspace would use v4mapped addresses,
> > > 
> > > It happens when listening on [::] with a v6 socket that has no "IPV6_V6ONLY"
> > > set to true (you can check ipv6(7) for more details).
> > > This socket can receive IPv4 connections, which are implemented using
> > > v4mapped addresses. In this case both remote and local are going to be
> > > v4mapped.
> > 
> > I'm familiar with v4mapped addresses, but I wasn't sure the userspace
> > part would actually passed them as peer. But I guess it would when the
> > peer connects over ipv4 on an ipv6 socket.
> > 
> > So the combination of PEER_IPV4 with LOCAL_IPV6(v4mapped) should never
> > happen? In that case I guess we just need to check that we got 2
> > attributes of the same type (both _IPV4 or both _IPV6) and if we got
> > _IPV6, that they're either both v4mapped or both not. Might be a tiny
> > bit simpler than what I was suggesting below.
> 
> Exactly - this is what I was originally suggesting, but your solution is
> just a bit cleaner imho.

Ok.

> > > However, the sanity check should make sure nobody can inject bogus
> > > combinations.
> > > 
> > > > but treating
> > > > a v4mapped address as a "proper" ipv4 address should work with the
> > > > rest of the code, since you already have the conversion in
> > > > ovpn_nl_attr_local_ip and ovpn_nl_attr_sockaddr_remote. So maybe you
> > > > could do something like (rough idea and completely untested):
> > > > 
> > > >       static int get_family(attr_v4, attr_v6)
> > > >       {
> > > >          if (attr_v4)
> > > >              return AF_INET;
> > > >          if (attr_v6) {
> > > >              if (ipv6_addr_v4mapped(attr_v6)
> > > >                  return AF_INET;
> > > >              return AF_INET6;
> > > >          }
> > > >          return AF_UNSPEC;
> > > >       }
> > > > 
> > > > 
> > > >       // in _precheck:
> > > >       // keep the   attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]  check
> > > >       // maybe add a similar one for   LOCAL_IPV4 && LOCAL_IPV6
> > > 
> > > the latter is already covered by:
> > > 
> > >   192         if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> > >   193             attrs[OVPN_A_PEER_LOCAL_IPV4]) {
> > >   194                 NL_SET_ERR_MSG_MOD(info->extack,
> > >   195                                    "cannot specify local IPv4 address
> > > without remote");
> > >   196                 return -EINVAL;
> > >   197         }
> > >   198
> > >   199         if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
> > >   200             attrs[OVPN_A_PEER_LOCAL_IPV6]) {
> > >   201                 NL_SET_ERR_MSG_MOD(info->extack,
> > >   202                                    "cannot specify local IPV6 address
> > > without remote");
> > >   203                 return -EINVAL;
> > >   204         }
> > 
> > LOCAL_IPV4 combined with REMOTE_IPV6 should be fine if the remote is
> > v4mapped. And conversely, LOCAL_IPV6 combined with REMOTE_IPV6 isn't
> > ok if remote is v4mapped. So those checks should go away and be
> > replaced with the "get_family" thing, but that requires at most one of
> > the _IPV4/_IPV6 attributes to be present to behave consistently.
> 
> I don't expect to receive a mix of _IPV4 and _IPV6, because the assumption
> is that either both addresses are v4mapped or none.
> 
> Userspace fetches the addresses from the received packet, so I presume they
> will both be exposed as v4mapped if we are in this special case.
> 
> Hence, I don't truly want to allow combining them.
> 
> Does it make sense?

Yup, thanks.

-- 
Sabrina

