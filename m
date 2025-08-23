Return-Path: <linux-kselftest+bounces-39772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A8B325FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 02:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91EB178D3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC417333F;
	Sat, 23 Aug 2025 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="S6eCvlXK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/R4Dkn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D1FBF6;
	Sat, 23 Aug 2025 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909228; cv=none; b=rlLOGrGCk+nqBZeRWPb87zuvVFLoj7Z1hqr8U7c+jPANhXyhfNfZQn1lim7sEeJDk43YEIZUKhw2E20m2jwwnnpkHdLUV/DIAFr2m1KTI2La17kqcIXSdIrdlmmGWuo3AJgRMm9xRviJcI1qqHc8VB4wB+BTPl7wUxFj4/X3fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909228; c=relaxed/simple;
	bh=Zm2Z4PlnTUt404jNYgIlEpT+uymlkprFDgIqLuarUek=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=t+VwF3Sk/PiPdc+IpVR0q//bqSrDpFpl+YmY6gsqLQi+qwsypzXABDvUwXzUg5qhYG4liEufJ61WXUpAB4rxPlQ/8u5aasBRoivTVxEk4tfusGi0TOmuw9rerEkbUxRz7V3E5934+gNiNXG/dtROHFuDw5Gy3WxT8UikkUNcF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=S6eCvlXK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/R4Dkn8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 179797A012E;
	Fri, 22 Aug 2025 20:33:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 22 Aug 2025 20:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1755909224; x=1755995624; bh=Qh5mlyZKssnD5G2L0e+JE
	M+BgdVFFXm1Mw0oddgGe9E=; b=S6eCvlXK6PGGSXsu7Mrz96ONrpmHFVPjBEhdn
	e4Edq2H0TLqzHuAkFuHhHpYEgioX76MoDtEXyN4tJQ4pUN1hmmpfO/XW+LgUlTf6
	2oTwgejy6g+Q3KGpOsQj9Cidr9+Zc10/nJlmXQXeScx+Vjn5goOmlFF7zQ2O1bWk
	2uxVPS+8kzRfhlV20sxmilVXsUGNG0W9fNBrVo7DTkaiBYN+QVc/0GL/KPT0+dos
	5U+dj/XDpS1gdniJUcM55NbDKVLYRx0l1NeTc5zcJLVIyx08FfqPS21ZAR3wS6T0
	pnYG08xJoWTPQGgt8UuFDuii3bQaFjPq9q61s+HbcqyqdghWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755909224; x=1755995624; bh=Qh5mlyZKssnD5G2L0e+JEM+BgdVFFXm1Mw0
	oddgGe9E=; b=g/R4Dkn8VokD4+JtDUbQ3wUg0OgP98MiKEFedh0Td2DkvvVTBXp
	/yf2vuwqnDsdKoPF8p/FLRybLkOZLnD8rFWU2l61H5QWMkrBDvrKsNY2U2Mb+wra
	HwmLH2ceIgOleRrWA9ejildRKib9yVVSpl3nviNU3sLPKIzGGQfXiMHubgNcpmU+
	rrYysxsleJcCnEcrEWn5nymMFkhEg1DjD/cl+i5bvQHEHWoa9NGb5gEK8q5Ccglg
	P/UywCazHCHXi+Vdz489OdwsBAeaO4Mza2b0ySQkDPcdQ25DKNAEEBbMBorbA3Rv
	hp6LmcdCHyOiLCa6kxoYmwADJscAxt5QwKA==
X-ME-Sender: <xms:aAypaHFNLfZ5sLiSsI2WL8KxjXrqE7rAHuG3YC4oj1vRmvPLzujcpA>
    <xme:aAypaK6Ir_yDGXA5Ghsal1AaCVrn1h2lhlKwo4gpWnOOlrA2ki1qehAmQQ_d2oVP2
    Tgn2lc5wI54n03YUkA>
X-ME-Received: <xmr:aAypaK3j1EQ99ws8DPfcxAIlWc04FW783QJrY6asEq7t6Jnwg-MRFoV4MsgQzre8xvwDWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aAypaOiwnS6wFSbkmyYtprcIMYcmSIcLxYICGaqqkRFUZXUjjTNPaA>
    <xmx:aAypaOT6qvBJPryaxhljkM-9t44T5vxQ3d-5QPq-bok7cxY1WYVmmw>
    <xmx:aAypaI6fxDJ8XQC5yIPz97z30HdVC_LeGdn94TGE5gzvXnpHTmtKFA>
    <xmx:aAypaOxay_xU2QBdTdaCBbruifBU_kIczRZ4XSVG7c4OGTeBdHLzkQ>
    <xmx:aAypaCRpk5EyvFq0R0gY3uJ0rKYBTMUpmA3aph5ImFoAwU1J0xIf2OY3>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 20:33:44 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 48DC29FCA6; Fri, 22 Aug 2025 17:33:43 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 47CD59FC83;
	Fri, 22 Aug 2025 17:33:43 -0700 (PDT)
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
Subject: Re: [PATCHv3 net-next 1/3] bonding: add support for per-port LACP
 actor priority
In-reply-to: <20250818092311.383181-2-liuhangbin@gmail.com>
References: <20250818092311.383181-1-liuhangbin@gmail.com>
 <20250818092311.383181-2-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 18 Aug 2025 09:23:09 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1547621.1755909223.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Aug 2025 17:33:43 -0700
Message-ID: <1547622.1755909223@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Introduce a new netlink attribute 'ad_actor_port_prio' to allow setting

	Nit here "actor_port_prio"?

	One more comment below ...

>the LACP actor port priority on a per-slave basis. This extends the
>existing bonding infrastructure to support more granular control over
>LACP negotiations.
>
>The priority value is embedded in LACPDU packets and will be used by
>subsequent patches to influence aggregator selection policies.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> Documentation/networking/bonding.rst |  9 +++++++
> drivers/net/bonding/bond_3ad.c       |  4 ++++
> drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
> drivers/net/bonding/bond_options.c   | 36 ++++++++++++++++++++++++++++
> include/net/bond_3ad.h               |  1 +
> include/net/bond_options.h           |  1 +
> include/uapi/linux/if_link.h         |  1 +
> 7 files changed, 68 insertions(+)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index f8f5766703d4..1ca7830c24ea 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -193,6 +193,15 @@ ad_actor_sys_prio
> 	This parameter has effect only in 802.3ad mode and is available through
> 	SysFs interface.
> =

>+actor_port_prio
>+
>+	In an AD system, this specifies the port priority. The allowed range
>+	is 1 - 65535. If the value is not specified, it takes 255 as the
>+	default value.
>+
>+	This parameter has effect only in 802.3ad mode and is available through
>+	netlink interface.
>+
> ad_actor_system
> =

> 	In an AD system, this specifies the mac-address for the actor in
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 2fca8e84ab10..eb0fb7374391 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
> =

> 	port->actor_system =3D BOND_AD_INFO(bond).system.sys_mac_addr;
> 	port->actor_system_priority =3D BOND_AD_INFO(bond).system.sys_priority;
>+	port->actor_port_priority =3D SLAVE_AD_INFO(port->slave)->port_priority=
;
> }
> =

> /* Conversions */
>@@ -2203,6 +2204,9 @@ void bond_3ad_bind_slave(struct slave *slave)
> =

> 		ad_initialize_port(port, bond->params.lacp_fast);
> =

>+		/* Port priority is initialized. Update it to slave's ad info */
>+		SLAVE_AD_INFO(slave)->port_priority =3D port->actor_port_priority;
>+
> 		port->slave =3D slave;
> 		port->actor_port_number =3D SLAVE_AD_INFO(slave)->id;
> 		/* key is determined according to the link speed, duplex and
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index 57fff2421f1b..16ef13ddcf22 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -28,6 +28,7 @@ static size_t bond_get_slave_size(const struct net_devi=
ce *bond_dev,
> 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STA=
TE */
> 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_=
STATE */
> 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
>+		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
> 		0;
> }
> =

>@@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
> 					ad_port->partner_oper.port_state))
> 				goto nla_put_failure;
> 		}
>+
>+		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
>+				SLAVE_AD_INFO(slave)->port_priority))
>+			goto nla_put_failure;
> 	}
> =

> 	return 0;
>@@ -130,6 +135,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_=
MAX + 1] =3D {
> static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1=
] =3D {
> 	[IFLA_BOND_SLAVE_QUEUE_ID]	=3D { .type =3D NLA_U16 },
> 	[IFLA_BOND_SLAVE_PRIO]		=3D { .type =3D NLA_S32 },
>+	[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]	=3D { .type =3D NLA_U16 },
> };
> =

> static int bond_validate(struct nlattr *tb[], struct nlattr *data[],
>@@ -180,6 +186,16 @@ static int bond_slave_changelink(struct net_device *=
bond_dev,
> 			return err;
> 	}
> =

>+	if (data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]) {
>+		u16 ad_prio =3D nla_get_u16(data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]);
>+
>+		bond_opt_slave_initval(&newval, &slave_dev, ad_prio);
>+		err =3D __bond_opt_set(bond, BOND_OPT_ACTOR_PORT_PRIO, &newval,
>+				     data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO], extack);
>+		if (err)
>+			return err;
>+	}
>+
> 	return 0;
> }
> =

>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 1d639a3be6ba..8f78f83fb29c 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -79,6 +79,8 @@ static int bond_option_tlb_dynamic_lb_set(struct bondin=
g *bond,
> 				  const struct bond_opt_value *newval);
> static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
> 					     const struct bond_opt_value *newval);
>+static int bond_option_actor_port_prio_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval);
> static int bond_option_ad_actor_system_set(struct bonding *bond,
> 					   const struct bond_opt_value *newval);
> static int bond_option_ad_user_port_key_set(struct bonding *bond,
>@@ -223,6 +225,13 @@ static const struct bond_opt_value bond_ad_actor_sys=
_prio_tbl[] =3D {
> 	{ NULL,      -1,    0},
> };
> =

>+static const struct bond_opt_value bond_actor_port_prio_tbl[] =3D {
>+	{ "minval",  1,     BOND_VALFLAG_MIN},
>+	{ "maxval",  65535, BOND_VALFLAG_MAX},
>+	{ "default", 255,   BOND_VALFLAG_DEFAULT},
>+	{ NULL,      -1,    0},

	Does the standard forbid actor_port_prio being set to zero?  The
description I'm finding says only that it's an unsigned integer and two
octets in size (802.1AX-2014 6.4.2.3 LACPDU structure).

	-J

>+};
>+
> static const struct bond_opt_value bond_ad_user_port_key_tbl[] =3D {
> 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
> 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
>@@ -484,6 +493,13 @@ static const struct bond_option bond_opts[BOND_OPT_L=
AST] =3D {
> 		.values =3D bond_ad_actor_sys_prio_tbl,
> 		.set =3D bond_option_ad_actor_sys_prio_set,
> 	},
>+	[BOND_OPT_ACTOR_PORT_PRIO] =3D {
>+		.id =3D BOND_OPT_ACTOR_PORT_PRIO,
>+		.name =3D "actor_port_prio",
>+		.unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>+		.values =3D bond_actor_port_prio_tbl,
>+		.set =3D bond_option_actor_port_prio_set,
>+	},
> 	[BOND_OPT_AD_ACTOR_SYSTEM] =3D {
> 		.id =3D BOND_OPT_AD_ACTOR_SYSTEM,
> 		.name =3D "ad_actor_system",
>@@ -1816,6 +1832,26 @@ static int bond_option_ad_actor_sys_prio_set(struc=
t bonding *bond,
> 	return 0;
> }
> =

>+static int bond_option_actor_port_prio_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval)
>+{
>+	struct slave *slave;
>+
>+	slave =3D bond_slave_get_rtnl(newval->slave_dev);
>+	if (!slave) {
>+		netdev_dbg(bond->dev, "%s called on NULL slave\n", __func__);
>+		return -ENODEV;
>+	}
>+
>+	netdev_dbg(newval->slave_dev, "Setting actor_port_prio to %llu\n",
>+		   newval->value);
>+
>+	SLAVE_AD_INFO(slave)->port_priority =3D newval->value;
>+	bond_3ad_update_ad_actor_settings(bond);
>+
>+	return 0;
>+}
>+
> static int bond_option_ad_actor_system_set(struct bonding *bond,
> 					   const struct bond_opt_value *newval)
> {
>diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>index 2053cd8e788a..bf551ca70359 100644
>--- a/include/net/bond_3ad.h
>+++ b/include/net/bond_3ad.h
>@@ -274,6 +274,7 @@ struct ad_slave_info {
> 	struct port port;		/* 802.3ad port structure */
> 	struct bond_3ad_stats stats;
> 	u16 id;
>+	u16 port_priority;
> };
> =

> static inline const char *bond_3ad_churn_desc(churn_state_t state)
>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index 022b122a9fb6..e6eedf23aea1 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -78,6 +78,7 @@ enum {
> 	BOND_OPT_PRIO,
> 	BOND_OPT_COUPLED_CONTROL,
> 	BOND_OPT_BROADCAST_NEIGH,
>+	BOND_OPT_ACTOR_PORT_PRIO,
> 	BOND_OPT_LAST
> };
> =

>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>index 784ace3a519c..45f56c9f95d9 100644
>--- a/include/uapi/linux/if_link.h
>+++ b/include/uapi/linux/if_link.h
>@@ -1564,6 +1564,7 @@ enum {
> 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
> 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
> 	IFLA_BOND_SLAVE_PRIO,
>+	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
> 	__IFLA_BOND_SLAVE_MAX,
> };
> =

>-- =

>2.50.1

---
	-Jay Vosburgh, jv@jvosburgh.net

