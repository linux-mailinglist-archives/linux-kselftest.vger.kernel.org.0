Return-Path: <linux-kselftest+bounces-22457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F297B9D61F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05076161106
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCE1DEFD4;
	Fri, 22 Nov 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="pW+7vYAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6nOjx4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFC13B58C;
	Fri, 22 Nov 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292293; cv=none; b=MQbrxvyKZWH3x1pGXutORjSKHwXHJpFiE8OdwVq3vUnn0MJMvhINvR7ANC1nmgLh3OGZrLvmr5slsehHiSTKJa+n0OphyM8kDeKuyFe7v8TYa7/YSpb3cAnQ1E1pb+pSund5Nm1lgkdKbd8KJDanA+UuFgD4Mc84C07w88iFUV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292293; c=relaxed/simple;
	bh=no21xQCcRKk7Kdw5IG63yislTkKktUX5bASibhmwctM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+gbnn5NzXlUOIJjuEezsBeMvaeC2bKhEy4nq4s4LAI4TDRP8+HsLpt8c6hzAn1FFGVVqqFEz2yex5Hk7QLLbOmb3ubYvhN9yNTLgCX6lyDuq1yjhF5iVwOQWJTy5nBaJPnrFyUQPkCKByOqtRlNfiHkOUwb3UNpM1wY7A06C4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=pW+7vYAx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6nOjx4T; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 4297D200629;
	Fri, 22 Nov 2024 11:18:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 22 Nov 2024 11:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1732292288; x=1732295888; bh=7MiFj9DQfkB0qD8w4IFwQBW5mbSAECz1
	magA6LgRv3Y=; b=pW+7vYAxDEVrg8ZGCam7IHEA/Pdj6g703iK4WFDWrNT0e0CZ
	LgKtBGb3j8S+1NGMnXWxKGtUCkxJUg3Rj4q/+O4D645sB0vinkArfZmT8kg4mM+l
	qq8APzCUMb7XpU5LIweIq+aZNQX3Wcu5kMt4/Ae+4kwql6Wj9pXJWzip0KPcjIhy
	Cre+AQYpV2kSEzPKGOM1iv74W7Y+tzMrYuRuRzBG+pgSwJhUE35IYzYP8JbbofnL
	V1rR+CLu9zpJJvsHxXTkR2rY6rhdzIvgQ0LylZXWuxSPy2d0gFC86jbYep42IUih
	lpDC9+oB9sX3fLp2oeWIb0KMeCOL1M8z/p5qZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732292288; x=
	1732295888; bh=7MiFj9DQfkB0qD8w4IFwQBW5mbSAECz1magA6LgRv3Y=; b=h
	6nOjx4Teqc4jkdxqjROVQEfbgZonEbsr3jiDm2SNBNkKbQ0U8muG05l6ziYAz3GP
	DOHqlP5G3oo73cclUfmu6OLv49d+emgF1yKKSdKJz83QCI76ATqEbS6FCJ+Lzrhl
	zBH8xjOSOUt7A1eZeJRVR8TtF3ylN8QjtCshDfvnI0h13H0Kuo3MTWBqu3VJYIH8
	QHGc+ANz4AYros8U1JOe4z1tMyAcO5PLDi3VLpEwKifY9hGdlR1Iu4G7d94Tm2NY
	tnWxl1EDF/lloQnZ6PETiNQxz8L6pUPlMXwgpfMqsNWMUeOruuyOWkjBRtIyV27G
	+sw1z9faC9Ihi6NF8ApaA==
X-ME-Sender: <xms:v65AZ1BbhHvZc-idTCQPgKoGHOgoLcs7qrCZ9_CLg3nFjEY3CxIb2Q>
    <xme:v65AZzjdGlfhgStRjbG6CgrtZF8H6s2H8z4md8EyI70a_9jQp07GMe9XXqXKll-sk
    ww9P5LRIM_r2LM95uI>
X-ME-Received: <xmr:v65AZwnZMLCJofYhxLl26pYYsOL40PycM_ZH0clMGNcC8EKdN3CKxkdF_nd->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfeg
    ueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhh
    uhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v65AZ_zq-Q45cwsX2RTau0_TKAv559Fjnfxshhpgr5ZZuw2eDKM_IA>
    <xmx:v65AZ6Q5G07WKCKpcHW-UuQLrOjgiQSrYsODfkQZFyZ4mJlETWu4-g>
    <xmx:v65AZyZ_d5PFogG-t4BAjS2DMuFAmlqlS2r2pbHFIGhyWl8VEGcGvw>
    <xmx:v65AZ7TYwsO0QizIX4GnWUvf2ETVLYizmoa60IQ8pVVki65Qrv9nPg>
    <xmx:wK5AZ9EV3A2-rrahA0z-nxuoyoxiF6E86ePyeAIiJRY4KwNofeTNKo1X>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 11:18:07 -0500 (EST)
Date: Fri, 22 Nov 2024 17:18:05 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
Message-ID: <Z0CuvYH_ZZMYtDcW@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net>
 <ZypfnyfToF1b6YAZ@hog>
 <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
 <5eaf74fb-ad13-4371-95b8-7a5f1f3a9cda@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eaf74fb-ad13-4371-95b8-7a5f1f3a9cda@openvpn.net>

2024-11-22, 10:41:26 +0100, Antonio Quartulli wrote:
> On 12/11/2024 14:20, Antonio Quartulli wrote:
> [...]
> > > > +static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
> > > > +                enum ovpn_del_peer_reason reason)
> > > > +{
> > > > +    switch (peer->ovpn->mode) {
> > > > +    case OVPN_MODE_MP:
> > > 
> > > I think it would be nice to add
> > > 
> > >      lockdep_assert_held(&peer->ovpn->peers->lock);
> 
> Sabrina, in other places I have used the sparse notation __must_hold()
> instead.
> Is there any preference in regards to lockdep vs sparse?
> 
> I could switch them all to lockdep_assert_held if needed.

__must_hold has the advantage of being checked at compile time (though
I'm not sure it's that reliable [1]), so you don't need to run a test
that actually hits that particular code path.

In this case I see lockdep_assert_held as mainly documenting that the
locking that makes ovpn_peer_del_nolock safe (as safe as
ovpn_peer_del) is provided by its caller. The splat for incorrect use
on debug kernels is a bonus. Sprinkling lockdep_assert_held all over
ovpn might be bloating the code too much, but I'm not opposed to
adding them if it helps.

[1] I ran sparse on drivers/net/ovpn/peer.c before/after removing the
locking from ovpn_peer_del and didn't get any warnings. sparse is good
to detect imbalances (function that locks without unlocking), but
maybe don't trust __must_hold for more than documenting expectations.

[note: if you end up merging ovpn->peers->lock with ovpn->lock as
we've discussed somewhere else, the locking around keepalive and
ovpn_peer_del becomes a bit less hairy]

-- 
Sabrina

