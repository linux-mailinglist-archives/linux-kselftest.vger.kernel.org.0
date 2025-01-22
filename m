Return-Path: <linux-kselftest+bounces-24915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD2A18DD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182031885447
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4DF1F7569;
	Wed, 22 Jan 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="F0XHcuRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tk4gqp1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFE1C3054;
	Wed, 22 Jan 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535883; cv=none; b=jCMVfgeD3qeF+pbLkqTNhYJs7kwa+j/EigxHYlwoZQqJmjHxUfhYTEhzOIG+jId3MOTLOaYJLjE2X5JOnD62NkR90WtqSaVKrTn38Fg5YsfY6OivonXBs2V+VqzLxm57VptfMA5Xi0va9lIXHbEg8Q5bCIHF7qH7vegwNKccyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535883; c=relaxed/simple;
	bh=hWlYXABuUcI7o3NyRkYYfuKRKV0wz6MxZWw+GNrJsaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIUSndvSGQv1BdESXTw2/0dh3cMOcd3MoT575BiwGqcBKH2YmHLnaVydi2Jez1g3Pw32YGoLp4lz/NPVn4s/0adFUri7kSQ70u6COIxvIF+wzJyDQN0RZbxRkT2PxO9/KEx6flR1OTCy/YeywUK3PlJu8/qqXGyi2zlGCf3YZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=F0XHcuRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tk4gqp1P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7294311400F7;
	Wed, 22 Jan 2025 03:51:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 22 Jan 2025 03:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737535880; x=
	1737622280; bh=q9RIIU9orrQqDOu9BUD+ZkkaeTQezs2a+gMpnm2U348=; b=F
	0XHcuRjWu9m5mWPTayJK/t3LH85IZoYplkqqgfi1BZMbS0rwNo1VZVXyrzBHpIvl
	0jVx5CK4L+dhCYGUxMJud+KnRN1+Zdc9fWwwyHLF3oCvatuKJYZFmb2EtUfYj7nd
	EJ7oAbMsO4ZUxl4/+nhVEOsqCDymDOFRc16FSNsGW5KTZ2gKqUGLARAzGVYHFb3H
	7MDDtXY/LzWZS6T0PMd+/UlEI9xrUltp/HxCibgpg5xKFDbCIqdRdoaCYcsRY6zd
	ZrnDLZ9UxH17bmEUy3l35xNgbRma9MdBVP8/XOn6wp7WLHDtjVz3iEy3/IVhN1wb
	E5xxaBp56cMNnOD/WlKTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737535880; x=1737622280; bh=q9RIIU9orrQqDOu9BUD+ZkkaeTQezs2a+gM
	pnm2U348=; b=Tk4gqp1PiPB7+AjG9hTetK+mlvXqMFD7sIqRz2fp/50BfGvvoV7
	g4BYBjGtvLfHAMukxaP3zDkZs1kxnzovj/jCLV0pd8savINAK2vcFbFiDxx8NoPX
	f20zyxyEdTGsQM4GjzAxlSSVSQLsvsx/OoEnonszDac86w1mxuy9jc6fxFqHrwqz
	AFvgv7bNxjtica0P0nRB8sxzmVir22WtB3V+T8xD7UGi+miyhnTGVBp0cJmd/FBO
	4AjRL55SWYar2mqCMbda07610qtFtLqhJ2NMYYgGada6eVx8NTBuliJyGjChzMbu
	22L9185vrNJU4AYPR/57Jkq2Gq206PBjmAA==
X-ME-Sender: <xms:h7GQZzheBb7h4L9lvNmapqpQ784vzc6QroqMwRzkv-02QjysRphjJQ>
    <xme:h7GQZwCKhW4lYgjmprCcKrsuD7CYbe61Z3uPgxc4upuFTv4igelbaEczuWbP8g6Nl
    FWW4VmGJaetUwzaZqc>
X-ME-Received: <xmr:h7GQZzEaODg0GqFRq1DwfnZ9aKZR7Ed4iP2L-7lenRUfNo6rixWXqokgPOwH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:h7GQZwSZej9zz2C3z7oXZPj2KdqyHEHyEpbtlKrtZW6TS81HYz4TsA>
    <xmx:iLGQZwyDoPDsdsqW7jKlBV8BheG-v3S-C3XpMC-wltbOE6miq8yzSg>
    <xmx:iLGQZ24wC2KoZLXBEPGcPuXTZx6FsxpTgNH1N84t5UnGJdUn8H8JWA>
    <xmx:iLGQZ1wETEiZ_u-GzREtOho9tLZaHNf_yuQtjE4M8m9_uwAcii4eNA>
    <xmx:iLGQZ8i9yQwjXGOOHbUhZQPnrc6qVys4aQ8qwn3kBZMeY3i7BKFJQtoN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 03:51:19 -0500 (EST)
Date: Wed, 22 Jan 2025 09:51:17 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z5CxhYdNHKMMljx5@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z4pDpqN2hCc-7DGt@hog>
 <6f907895-4f5f-450f-8aa7-709625e4bb25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f907895-4f5f-450f-8aa7-709625e4bb25@openvpn.net>

2025-01-22, 01:40:47 +0100, Antonio Quartulli wrote:
> On 17/01/2025 12:48, Sabrina Dubroca wrote:
> [...]
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
> > 
> > So I would add a completion to wait here until the socket has been
> > fully detached. Something like below.
> > 
> > [*] I don't think the current refcounting fully protects against that,
> > I'll comment on 05/25
> 
> Sabrina, after the other changes I acknowledged, do you still have comments
> for 5/25?

The call_rcu vs _put was all I had for this.

Note that you have to wait until ~Feb 4th before you can resubmit
(since net-next is currently closed). I'll take another look at this
revision next week, since I've only checked a few specific things
(mainly related to peer and socket destruction) so far.

Thanks.

-- 
Sabrina

