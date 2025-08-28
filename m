Return-Path: <linux-kselftest+bounces-40201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD5B3A72D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 18:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0283BA013FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9732C31A;
	Thu, 28 Aug 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="BNTapcJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTtRoiGN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECD3314B3;
	Thu, 28 Aug 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400366; cv=none; b=NxWpTEw5SK1Z8xZNORNvCtLRIbR6rP7naa1gfs3Jje/X3LU4YAF2IVqBWkHIkKfaeokAzOOu8w7OyqgKij/smfxZYl9mlhodhPJ2LaVKbbG9VlTWrzEUv1fJQgbqjqw6NMwDiefqxYZSe/TrGKAdYkAlhFF7+rt0CoAvEcOGhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400366; c=relaxed/simple;
	bh=kYfylJecqyv+6vnymFsdtqLi9AgdgemVenjyBUyVBK8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dH1aBWKPZ4vV1EKqcZgV6CO4AXG0hqeq3uXU5qknJyxMmjE8mcX57vJJI3gSc6yWijaJyeIH11g77Y7tv1pfeUkyGNh3UrcnVX4+x7JO4oSpsbHx/WEpXRoXGodYBscmZGcyG35IRMiGcR+egx/VbQN4v7P0iGWtmx2vo9WQAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=BNTapcJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTtRoiGN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8466D7A0198;
	Thu, 28 Aug 2025 12:59:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 28 Aug 2025 12:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756400362; x=
	1756486762; bh=WjgDdX5WvSEXp8OZHfzER7hnYaOdtStf4MrinPrBgwo=; b=B
	NTapcJXizy+DV9xdGrxlv9f3W2suBvFOB2We0AkP4v3szAvJR9qTOaP/8EfNX/xt
	MA6frokrgs6sxFU7nMC7D0b+RlEAleub6ys1+eREvj9IZ8XYT6o/dxZRW6WuRFiA
	Ka2vLXlxDvmp6SfdCNol0znPoGFX2QwcCums2scwWfGeOfOWi1ESdbJIY22bs3Ua
	i6jUPUm9NHsGepNetpcLMqC3LWRaYxPaj+6PsaZFOASBbjW9OU1cX+cXi8BOtnx3
	F4MHWRsZr22svYV3KwmVepRkj6FR8J2S5+o0Te8w76s3Yu0fhMH8+26BJvop8UTh
	RpwO1WEZkDuoaSY8dJbZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756400362; x=1756486762; bh=W
	jgDdX5WvSEXp8OZHfzER7hnYaOdtStf4MrinPrBgwo=; b=MTtRoiGNL+tDZmTXQ
	5AylfAVZuT/G9agZbPgmErTgmcSJ8l2dh9QPtTGBj+IK0BLH4u/kMA97SiTKipW8
	mNRUkeAyJ0eR8Vu1sNnWZiSTFzqKJTiJ1cjnTpKzo2a/O6ZzPoftJReO73vk3fYM
	u2h8MexOZ8/oVzAcrGgO/fd1RVj06kRRQycbr8OmuvHALhTugu4xDkQViCmDVQt6
	GYYSWdjo+Xj53x92XCEfkcl5GQODUKrPkH20KBkf41BQ9eSe0b6JRCwGHMHhXgbF
	hDsew9KWLcttHFLJjV882gPFytdBU5Ss1cHaalp/mn/lPQFIBAyHZeDvZGMu1d7C
	8cDTA==
X-ME-Sender: <xms:6YqwaCle6lfhsLU9TMofEypoFj-4KHxYl_UrdtlsFLHzynsVd0GF9Q>
    <xme:6YqwaAb31HDF24PluNtHeG_lqcPpkCOQWTVZa9bdAe6uQggW_gd4y6fcTg4YNDAdL
    aCHojs58wcPSVSQ2I0>
X-ME-Received: <xmr:6YqwaCXvB2MT2mrQ1nTkfhfc0kxM8ZnRVb3LEF7aijegbVe2-GGmHYpXOU3w53WuSUFh_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgffkfesthdtredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeejvdfghfetvedvudefvdejgeelteevkeevgedthfdukeevieejueehkeegffejuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgv
    rhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrshdrghhorhhskhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6YqwaABjR4kPKLbPBJfXpJ4-Rk0PHUlf9GaekkJNYNXwwSTrx9WDsQ>
    <xmx:6YqwaBxfDf8Z-9VEXWCAkEbFBjviDxUVcnm5F9XM-fARyPBliArJUA>
    <xmx:6YqwaGabU6xHrrm4_dUUpDJ9ZGxSltR4B4VLW3-kZpjeJUMxqXiIIQ>
    <xmx:6YqwaOSlELAxs0a_097SCu3nTe6pvgs0GA4_CtYSXRHMEXfYNhvP2w>
    <xmx:6oqwaPzPEKhgCr0S-MhzZZBBnQErT0FPz4OyhLv048ErE5RNxuMGn-Zo>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 12:59:21 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 33CB39FCA0; Thu, 28 Aug 2025 09:59:20 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 306E29FB65;
	Thu, 28 Aug 2025 09:59:20 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
    Amit Cohen <amcohen@nvidia.com>,
    Vladimir Oltean <vladimir.oltean@nxp.com>,
    Stephen Hemminger <stephen@networkplumber.org>,
    David Ahern <dsahern@gmail.com>,
    Jonas Gorski <jonas.gorski@gmail.com>, linux-doc@vger.kernel.org,
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 iproute2-next] iplink: bond_slave: add support for
 actor_port_prio
In-reply-to: <aK_MB7ikY0hUhGqn@fedora>
References: <20250825070528.421434-1-liuhangbin@gmail.com>
 <1859262.1756320199@famine> <aK_MB7ikY0hUhGqn@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 28 Aug 2025 03:24:55 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1918693.1756400360.1@famine>
Date: Thu, 28 Aug 2025 09:59:20 -0700
Message-ID: <1918694.1756400360@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Wed, Aug 27, 2025 at 11:43:19AM -0700, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>> 
>> >Add support for the actor_port_prio option for bond slaves.
>> >This per-port priority can be used by the bonding driver in ad_select to
>> >choose the higher-priority aggregator during failover.
>> >
>> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> >---
>> >v4: no update
>> >v3: rename ad_actor_port_prio to actor_port_prio
>> >v2: no update
>> >---
>> > ip/iplink_bond.c       |  1 +
>> > ip/iplink_bond_slave.c | 18 ++++++++++++++++--
>> > man/man8/ip-link.8.in  |  6 ++++++
>> > 3 files changed, 23 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
>> >index d6960f6d9b03..1a2c1b3042a0 100644
>> >--- a/ip/iplink_bond.c
>> >+++ b/ip/iplink_bond.c
>> >@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] = {
>> > 	"stable",
>> > 	"bandwidth",
>> > 	"count",
>> >+	"prio",
>> 
>> 	Should this be actor_port_prio?
>
>hmm, actor_port_prio correspond to the ip link option name, which is also
>acceptable.

	Isn't this the text of the ip link option name right here (in
the sense of what goes on the "ip link" command line)?

>While in kernel, we defined the select policy as
>
>        { "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
>        { "bandwidth", BOND_AD_BANDWIDTH, 0},
>        { "count",     BOND_AD_COUNT,     0},
>+       { "prio",      BOND_AD_PRIO,      0},

	Maybe my memory is starting to go, but I thought in a prior
discussion we'd agreed to change this as well for consistency.

>So I think the prio here should also be OK.
>
>You can decide which one to use.

	I would prefer that the two options have discrete names, or,
really, that we not repeat "prio" as it's already used elsewhere.  Plus,
who knows, maybe in the future we'll have another priority option.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

