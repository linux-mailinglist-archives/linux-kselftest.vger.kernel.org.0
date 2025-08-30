Return-Path: <linux-kselftest+bounces-40349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976DFB3C61A
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 02:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0DF7B2FC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDA35947;
	Sat, 30 Aug 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="guPES3y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2Rbfovr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D81388;
	Sat, 30 Aug 2025 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513362; cv=none; b=NhtZRNmdu3OC1Vowv7Xp8fAAuKIDWL3BRE5S70b3hi6MnX5G82Hjw8UzeZL/f4j3rjb+OkCFc4oyJzbKV6dlReZ4cVnRrKV4mVPbGmGzpXXvdbpzmSglbG6nPaU0pXQOtMmHJTvx6SdnQXPJSSZAxcWTCY2PdhC2nP4Lw3iKvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513362; c=relaxed/simple;
	bh=stzrgabvcibymTZ8mI7kt97HgUfiuUQfNM7AZ4wn4gM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=omQpWVpcDHYEso/dmqkwjx3IhxhYpv80vl6gFW8WSDrMLjwkfal1TnfWY7QdMFDWYwwWq1gwmXgiZT7XjU2G/8K4zDWPCqAzjx+51ZuDmpuAvtfJrRSxBYqYud9/f7OhlLzNKpTcpT/a46lCR8L+1I1A7zP8uGqSRCZwmJDLGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=guPES3y2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2Rbfovr; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 140581D00088;
	Fri, 29 Aug 2025 20:22:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 29 Aug 2025 20:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1756513358; x=1756599758; bh=YlmA1YBwHD5DdyJUDL/CD
	YNeLkqKO+0jIAPnsFLgqfM=; b=guPES3y2oIhJex99y9VGxoYqFA9NP5OdDjWGV
	mZyVKuixLWMKtJ4BGVvkL0D3dpjfuvvzvpQQuQ4Psja3LGgTDj+bdSNiU8uCiZn2
	vh2TSo9rQ+0ggrricYA+1ROcs0uu2Va8QaWex4AJ8pzllqrvsQOj5idzNfyfXyXx
	MF40hSH9ePukfSM8AIDmZtKAd1IWTXKzoYNyJZBrUoA3Nusz9Jqf4LM9M2sA3Sbc
	WFWUxbkagRx8J5Nm4g9uHrb9DvlbYhLSJNDEUITlqIfC+bkqRKrIXXxypVZGe/dU
	bV1eK5xnmHEowoL0oUn5gaqFgFX8nS/7DbwVcKYaP7ztJQQaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756513358; x=1756599758; bh=YlmA1YBwHD5DdyJUDL/CDYNeLkqKO+0jIAP
	nsFLgqfM=; b=f2RbfovrdBPYqwEdiQ3U6tTO2/p33fuA7vicEGYHLK0LdwNUZB1
	4UqSlxOSc46u0Ne3BXvpm8xT5yUKRVVzhNrt8HVmmAsCOQuYSgNBXqMEJ7r9k5gN
	IGG0k1+6BCyS7nYSjrRRtPhB5Jv7yw+mGW3UIjAEeQtg6Opb9Ijv3Vbe9mxiHtFN
	PxGKq8nmwS9K43BeH/2kuhSlf1BSQ6ZegiPzS2qgZQnq20iJ3K/ooFCMT2bnhqxl
	B29A4LxW3cY2XZ1caS5+CL4O4+WKqLxjQhT2mj9HpoW2uiu3jyHS2Br1pjTjI2Kg
	76OZwBYDObazwnBDt0zXfCD7v3RGmED7FDA==
X-ME-Sender: <xms:TUSyaOMz4krXgnNQtYe1hIe96MBkPHPXcDH9h78krCKO8HN3x0PirQ>
    <xme:TUSyaDgT2OESr9_FKqB5mCcKHsV-Z712LWzD6Q-CgG_W3lIOEIchVj45irDQnoQIv
    YrxkJpX76j2KnPC7qo>
X-ME-Received: <xmr:TUSyaG_cx6ZO6du4oxAR_1dlWxiQWAG1fmSeYAd8fodoyUduxzCTdf4A3mXADEFDhbcmdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiioh
    hrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhonhgrshdrghhorhhskhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    lhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivg
    htsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TkSyaILnZ72VR8hj31iLxrF9M7rInrnVFbgARdIPhi1f3YF5KU8hMw>
    <xmx:TkSyaHaWykukEtPWhS22392ch08GTR5eoRkbWA94HGkgFBp7NJlJdg>
    <xmx:TkSyaLgIl2tW9fHNL1CjfaD0Naiwbt9F_qLOm36YmtKq8h5Rva6zFg>
    <xmx:TkSyaM7dlZcRkGlHc3trf3v9MYaMGiKlMXxSsjtQTryyUWdhkZ_CXg>
    <xmx:TkSyaI57BtcELYsKzAewRUzV6JTST0zW6Adi6nFAMzMHzWQgcOdFxngG>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 20:22:37 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id EB2189FCA0; Fri, 29 Aug 2025 17:22:36 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id E79769FC95;
	Fri, 29 Aug 2025 17:22:36 -0700 (PDT)
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
In-reply-to: <aLD8l9xPd2nnl_gt@fedora>
References: <20250825070528.421434-1-liuhangbin@gmail.com>
 <1859262.1756320199@famine> <aK_MB7ikY0hUhGqn@fedora>
 <1918694.1756400360@famine> <aLD8l9xPd2nnl_gt@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 29 Aug 2025 01:04:23 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2030136.1756513356.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Aug 2025 17:22:36 -0700
Message-ID: <2030137.1756513356@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Aug 28, 2025 at 09:59:20AM -0700, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>> =

>> >On Wed, Aug 27, 2025 at 11:43:19AM -0700, Jay Vosburgh wrote:
>> >> Hangbin Liu <liuhangbin@gmail.com> wrote:
>> >> =

>> >> >Add support for the actor_port_prio option for bond slaves.
>> >> >This per-port priority can be used by the bonding driver in ad_sele=
ct to
>> >> >choose the higher-priority aggregator during failover.
>> >> >
>> >> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> >> >---
>> >> >v4: no update
>> >> >v3: rename ad_actor_port_prio to actor_port_prio
>> >> >v2: no update
>> >> >---
>> >> > ip/iplink_bond.c       |  1 +
>> >> > ip/iplink_bond_slave.c | 18 ++++++++++++++++--
>> >> > man/man8/ip-link.8.in  |  6 ++++++
>> >> > 3 files changed, 23 insertions(+), 2 deletions(-)
>> >> >
>> >> >diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
>> >> >index d6960f6d9b03..1a2c1b3042a0 100644
>> >> >--- a/ip/iplink_bond.c
>> >> >+++ b/ip/iplink_bond.c
>> >> >@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] =3D {
>> >> > 	"stable",
>> >> > 	"bandwidth",
>> >> > 	"count",
>> >> >+	"prio",
>> >> =

>> >> 	Should this be actor_port_prio?
>> >
>> >hmm, actor_port_prio correspond to the ip link option name, which is a=
lso
>> >acceptable.
>> =

>> 	Isn't this the text of the ip link option name right here (in
>> the sense of what goes on the "ip link" command line)?
>
>"stable", "bandwidth", "count" are not ip link parameters, and same with
>kernel names, so I also used the kernel name "prio" here.

	Perhaps I wasn't explaining sufficiently; I mean that the text
in ad_select_tbl[] is where the name of the option settings comes from
for ip link whatever commands.  E.g., If I do something like

ip link add dev bond0 type bond [...] ad_select rutabaga

	The "rutabaga" text is being compared to the elements of
ad_select_tbl[], correct?

	Anyway, what I meant is that I think setting this new priority
option should look something like:

ip link add dev bond0 type bond [...] ad_select actor_port_prio

	So that it's called the same thing everwhere, and it matches the
nomenclature used in the standard.

	-J

>> >While in kernel, we defined the select policy as
>> >
>> >        { "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
>> >        { "bandwidth", BOND_AD_BANDWIDTH, 0},
>> >        { "count",     BOND_AD_COUNT,     0},
>> >+       { "prio",      BOND_AD_PRIO,      0},
>> =

>> 	Maybe my memory is starting to go, but I thought in a prior
>> discussion we'd agreed to change this as well for consistency.
>
>Maybe I didn't get your comment[1] correctly. I only changed
>`ad_actor_port_prio` to `actor_port_prio` last time.
>
>> =

>> >So I think the prio here should also be OK.
>> >
>> >You can decide which one to use.
>> =

>> 	I would prefer that the two options have discrete names, or,
>> really, that we not repeat "prio" as it's already used elsewhere.  Plus=
,
>> who knows, maybe in the future we'll have another priority option.
>
>OK, do not use same name for different usage. I will also change the "pri=
o"
>to "actor_port_prio" in next patch.
>
>[1] https://lore.kernel.org/netdev/1109153.1755380673@famine/
>
>Thanks
>Hangbin

---
	-Jay Vosburgh, jv@jvosburgh.net

