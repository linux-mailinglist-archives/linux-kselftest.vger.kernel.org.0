Return-Path: <linux-kselftest+bounces-40073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A0B389CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 20:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E12A4E2155
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AEF2E1746;
	Wed, 27 Aug 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="AHs9yi/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIgzQPTB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13A278143;
	Wed, 27 Aug 2025 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320206; cv=none; b=fp0wZDn9YwE0H1unFb6oF7uz4C7xr+XUBtQQWb41hqbDD0AU/66W7xe9ONh2OOKOZBVgsVtJ66xa9gvuTGnhTa5EkaajV/RWx0ncjPyMoyMYliFBMeE8MPGCnahJR9JpY7fKUDGDoqu7WxHJpk9KULZSxuTQIZtwz5HO74ynTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320206; c=relaxed/simple;
	bh=h8R3EcV+NTP5wjjJ9QQ4JoR9KQy94BQW0jO4jadhGIc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=GPQTzXHNlUBQ9YwvHplmVI7EOf3bwcIrqXjWsj3P3Grwo1UUS+AWL8EU51zZ1AeFsgviaAbhACNLmg5mBFyuiTO5DeOepSUpinG/kDGTNeJ1G3T884psSG2cv8sxitX0NEtHfIVqoe8zob8Lhq0SOaGkdcgldUs47Av3AfQXTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=AHs9yi/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIgzQPTB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E6327A0155;
	Wed, 27 Aug 2025 14:43:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 27 Aug 2025 14:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1756320202; x=1756406602; bh=120xnupGH9jAY3geWFsvU
	BOMtx3MkVkNw/aGxou3pYQ=; b=AHs9yi/7DPpE9MJswFzP5r5pI/Qh9c9RhOD1R
	gnMwsnIin1rY6cRAyk9EUhJuwGRCZARzNvmUCnJ9NGGqmNoT++grx+pwNin91Lh2
	qgeuvxgOibq0hDjPxQ3Y6ISpmTlb0VIB0sdxyKfYpKkhay8hXNIStaf4+41oMr1Z
	EIWOqpBDO4YghRlh12siWa4J/pnzOnMXSPy69kWA9H3Tynj2oySigxqWzbxD/ILq
	fC5cWG+vWm82dDgWqGwJRgChazf/pSRa9/d8MtfcgzrrpatQHVMTLYkp0y8MpCH3
	BdLlsJ1ZK8gjFubW7fZiib0UXzKcGfbudyJ/0hNqvl/wRg4HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756320202; x=1756406602; bh=120xnupGH9jAY3geWFsvUBOMtx3MkVkNw/a
	Gxou3pYQ=; b=LIgzQPTBzsYf1g/3Hdr2XToOQ22Jg6Akl6WTsL9UXRv4Pgu9a9f
	NyWlTewvH/jVeHv7/Ny+qgIFEYw6cLwBuMXw/QovPY2yYhEOx1YiFGZ68qbYtkNY
	p0IpcgBHDm0oH9FvUaS9l1FkYs3Tvz96avjgJdpyp1CkTjOQFmbhcYugzu7AE0OT
	n8V1WWaJ+5dlg20ItMqBM/DVdOs5RMuPnpQK3+IhbZXkrtx9xPk8I6FbNsXpwt3w
	PcqzR7INvDxnXnSExzxgh+HISFa6Q1zXNqVJGk65D7X67j5rH7KDzFkbpVgqmSyw
	Knrj06tIv3PUNoWqwyCzr0VVeGkrcrDoQfA==
X-ME-Sender: <xms:yVGvaBsdrtExvt8Bucl-ysKFPAUexVzZUv73IcWQ2iiXVTH8MVZ6DA>
    <xme:yVGvaBCw0glzd8mQJTtOpIstKqNfNIZxmffJMbzNF5eqWqtksBf_ILXrskZIflMUQ
    kVTBDqcnYooLVhXGRI>
X-ME-Received: <xmr:yVGvaGe0hrz_NhishCEg0woqIJLoBYCbYbBkEyyKRHi8gDuU9coBQ_WW7QwCfMDHQN3naA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepughsrghh
    vghrnhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghsrdhgohhrshhkihesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yVGvaBqsUp4uHoPzNp24AtplX1Xgfw5K9hRwNsPCFxsbmN4uOQBaDA>
    <xmx:yVGvaC7bgAhofa95Mbw2CeIcOeNt7lt8dmfaa-h5E1CwnIG46o6cJw>
    <xmx:yVGvaBCbj3DAnO4mUXMcLPtBd_x1b56D81fP4n7cFcJ8rBwUvUTvfw>
    <xmx:yVGvaEY9B0IzyeF4VOX8rLwV3jhRL8ZQhQOq09jiajpPF-0K2dwvqg>
    <xmx:ylGvaOZIOXJvNZUX2PBLK2vnZKPx_W-FdoxGrhKlJNBpkxw6pFMR8t-G>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 14:43:20 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id DE7F39FCA0; Wed, 27 Aug 2025 11:43:19 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id DD5279FB9F;
	Wed, 27 Aug 2025 11:43:19 -0700 (PDT)
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
In-reply-to: <20250825070528.421434-1-liuhangbin@gmail.com>
References: <20250825070528.421434-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 25 Aug 2025 07:05:28 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1859261.1756320199.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Aug 2025 11:43:19 -0700
Message-ID: <1859262.1756320199@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Add support for the actor_port_prio option for bond slaves.
>This per-port priority can be used by the bonding driver in ad_select to
>choose the higher-priority aggregator during failover.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
>v4: no update
>v3: rename ad_actor_port_prio to actor_port_prio
>v2: no update
>---
> ip/iplink_bond.c       |  1 +
> ip/iplink_bond_slave.c | 18 ++++++++++++++++--
> man/man8/ip-link.8.in  |  6 ++++++
> 3 files changed, 23 insertions(+), 2 deletions(-)
>
>diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
>index d6960f6d9b03..1a2c1b3042a0 100644
>--- a/ip/iplink_bond.c
>+++ b/ip/iplink_bond.c
>@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] =3D {
> 	"stable",
> 	"bandwidth",
> 	"count",
>+	"prio",

	Should this be actor_port_prio?

	-J

> 	NULL,
> };
> =

>diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
>index ad6875006950..c88100e248dd 100644
>--- a/ip/iplink_bond_slave.c
>+++ b/ip/iplink_bond_slave.c
>@@ -15,7 +15,9 @@
> =

> static void print_explain(FILE *f)
> {
>-	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n")=
;
>+	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n"
>+		   "                      [ actor_port_prio PRIORITY ]\n"
>+	);
> }
> =

> static void explain(void)
>@@ -145,12 +147,18 @@ static void bond_slave_print_opt(struct link_util *=
lu, FILE *f, struct rtattr *t
> 			  state);
> 		print_slave_oper_state(f, "ad_partner_oper_port_state_str", state);
> 	}
>+
>+	if (tb[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO])
>+		print_int(PRINT_ANY,
>+			  "actor_port_prio",
>+			  "actor_port_prio %d ",
>+			  rta_getattr_u16(tb[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]));
> }
> =

> static int bond_slave_parse_opt(struct link_util *lu, int argc, char **a=
rgv,
> 				struct nlmsghdr *n)
> {
>-	__u16 queue_id;
>+	__u16 queue_id, actor_port_prio;
> 	int prio;
> =

> 	while (argc > 0) {
>@@ -164,6 +172,12 @@ static int bond_slave_parse_opt(struct link_util *lu=
, int argc, char **argv,
> 			if (get_s32(&prio, *argv, 0))
> 				invarg("prio is invalid", *argv);
> 			addattr32(n, 1024, IFLA_BOND_SLAVE_PRIO, prio);
>+		} else if (strcmp(*argv, "actor_port_prio") =3D=3D 0) {
>+			NEXT_ARG();
>+			if (get_u16(&actor_port_prio, *argv, 0))
>+				invarg("actor prio is invalid", *argv);
>+			addattr16(n, 1024, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
>+				  actor_port_prio);
> 		} else {
> 			if (matches(*argv, "help") !=3D 0)
> 				fprintf(stderr,
>diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
>index e3297c577152..7995943ab11f 100644
>--- a/man/man8/ip-link.8.in
>+++ b/man/man8/ip-link.8.in
>@@ -2846,6 +2846,12 @@ the following additional arguments are supported:
> (a 32bit signed value). This option only valid for active-backup(1),
> balance-tlb (5) and balance-alb (6) mode.
> =

>+.sp
>+.BI actor_port_prio " PRIORITY"
>+- set the slave's ad actor port priority for 802.3ad aggregation selecti=
on
>+logic during failover (a 16bit unsigned value). This option only valid f=
or
>+802.3ad (4) mode.
>+
> .in -8
> =

> .TP
>-- =

>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

