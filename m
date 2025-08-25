Return-Path: <linux-kselftest+bounces-39821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D192B336A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 08:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C713BD397
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AE283CB0;
	Mon, 25 Aug 2025 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHgReZF8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632227FD76;
	Mon, 25 Aug 2025 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104337; cv=none; b=BbfzW+HoinUg4Z71kqt7IO9CSc/LlVD2e9jC3uIXW0IWqp+0SPB/3EIJXdn9QdmK7HuKVVP5gy2DjR6iZKm9n/edwHi6mLFv7QWXaC6HUNnQflow9qP38yWb97c3m3NxCLoK+0VKbgXcR6r2l9BNKNPfd7hbXvF4wDHCuFCykr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104337; c=relaxed/simple;
	bh=AkXB3gS4M+sSLpB5BUe8NC1jjjU5fbDSQHYjijLuV1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP4z7L3m83zFxypiCV5rlL6+9Hvnad1LmvdlSyou4JbxjpEZgN4y9i63jByC+jpOIHHYLNPqmPDTu2Jb/q2pGOr9cAsP7WROtc0UPLVNQ/dVZERQUCmF7fefRrEfEPnHUfC0DvS4GexB87SgSqArmcnHI1cmr9wI1Bm4qWQdzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHgReZF8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49cf21320aso1664368a12.1;
        Sun, 24 Aug 2025 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104335; x=1756709135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGfb+6S+dxMKBkiPmtd8j0OA0OCsATPuQRhq784o9Xg=;
        b=nHgReZF8DMkNou7h+hvZGa8LGt5n/XsZAmRthMMVBIAqUgrrAv7NqSY8hA9p09ZtTZ
         VNVFLfyPR46mOBXqHDvZuP+ONR6rlbkDYaK6voRPTdxZD1kSJ8svnUCFcRKse7RHhN+1
         PLNa1Xw1JSycbH1kyG+LuJ/n/VnZzX9zT8tIk3IyvwS0oYeCz2Ey0Vt0EILeM9URpPrn
         fWTPTnqbxkk2IQtGIx80Ho5wlZaJEBKV68Wfb+D7IInYqo+bO5jDrGomPnJgtIKXze1n
         mLd532o2HjULhD7+gPcBUcwZjeyHnrzlFHehvPYLByfpT+p4BHFnZA1+CQd/fwwZumCV
         OX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104335; x=1756709135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGfb+6S+dxMKBkiPmtd8j0OA0OCsATPuQRhq784o9Xg=;
        b=PI40rdpnKO40dQs/V+lPLfUbvVRxvhfjuIHt4hpR3Yrc/ezGKUSnIYTNvtqYlhbpuw
         rY3nhr3GPucb2S9GKsmOIDTAR7+ZVCbIaNbkUvMNPz6hBj5qhP28VbZcOnh6Jx6myiNN
         ENXfza0rf8ile47R9r+0BHY8rmOsh2fsfLCmIUFlSY40uPqBTBMKe4FrimIEMmS9NAzW
         /CULxbweUKNZ+8XNHnlLHP2KQmzYDXW16Fto6XJJjvlVRgz7PCBk1kg2XJtKiExBVA7+
         Yg+pjmD+KOCytQe1q2e9doIbvYAdgV7yrg5kVf4csT/BRpL3MCya+ZUFHCy3PQYZ+u/h
         N38g==
X-Forwarded-Encrypted: i=1; AJvYcCUVPUZO+4YlZKnxks6bEYM7nip1BrTn3mjT5CTplhm7TPf1R50rEJg4k/QMmTyO7cc8I2v3mpcTRafmx9mgnS8l@vger.kernel.org, AJvYcCXxo4I+z5a+aG7ZbRE+sahJcPVwEXMeNplxMZP+9TKd/lGQDpkkSTPwS3z+qbPyxtWHDn2Vnw7bkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztM3oPFYqRH6lia5uffal8HUMHUmXfnXgrgl5L3EUZHto3STV1
	0hdUtlyTXvLl8WjgFGt/rGHCaLCEnLmBgd87NTsAnNMSNN9Vk5Aqq1KfreZi/ogs
X-Gm-Gg: ASbGncv7V9HtgWYaUUwkTDeNP+YGYB96zBxH7+NY6LDLVGNZLaw95EiBzDWtnON/wvI
	xsdKac8lycnBTt89tsKg5iuLdZ7gY3gy5g4M9xGjQ36+4W8A8qgOyMYolYvYFTvH0FgdKGlOsoL
	LPoOMndAYDXZ5IXJ8wpu93Tg56N7Jbz97rR/18l6sAwq5gPS36Ilwl89ZgdF/y5TwUf24FfT2pl
	XHFW6fG5VIE5GItLn9AZ8fnKikUX2Bzg5xMjlcnRL1s7VPSh2ShOaf0uHPnDFIKXXN1DpXz81f8
	iysdhzzi9glvYjf8qpyl0yqoioL7XcRpLaZyQGF6z08/c0HGpeQKoNfS1rCL+j6Gg5RPJ8pl8ec
	REdjJAQgBrt8iqWUiTBTVLTj2YuyQMjxnOyC0LpNqTg==
X-Google-Smtp-Source: AGHT+IEIKl4T0FcsNbItlURfZv58Jc02sDYCiPExPolug/cqNu5QI7mgziIJauhDniJw9zo2l+e+GA==
X-Received: by 2002:a05:6a21:998e:b0:243:7617:7fbb with SMTP id adf61e73a8af0-2437617847bmr3259110637.43.1756104334700;
        Sun, 24 Aug 2025 23:45:34 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm5978118a91.18.2025.08.24.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:45:34 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 1/3] bonding: add support for per-port LACP actor priority
Date: Mon, 25 Aug 2025 06:45:14 +0000
Message-ID: <20250825064516.421275-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825064516.421275-1-liuhangbin@gmail.com>
References: <20250825064516.421275-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new netlink attribute 'actor_port_prio' to allow setting
the LACP actor port priority on a per-slave basis. This extends the
existing bonding infrastructure to support more granular control over
LACP negotiations.

The priority value is embedded in LACPDU packets and will be used by
subsequent patches to influence aggregator selection policies.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst |  9 +++++++
 drivers/net/bonding/bond_3ad.c       |  4 ++++
 drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
 drivers/net/bonding/bond_options.c   | 36 ++++++++++++++++++++++++++++
 include/net/bond_3ad.h               |  1 +
 include/net/bond_options.h           |  1 +
 include/uapi/linux/if_link.h         |  1 +
 7 files changed, 68 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f8f5766703d4..1ca7830c24ea 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -193,6 +193,15 @@ ad_actor_sys_prio
 	This parameter has effect only in 802.3ad mode and is available through
 	SysFs interface.
 
+actor_port_prio
+
+	In an AD system, this specifies the port priority. The allowed range
+	is 1 - 65535. If the value is not specified, it takes 255 as the
+	default value.
+
+	This parameter has effect only in 802.3ad mode and is available through
+	netlink interface.
+
 ad_actor_system
 
 	In an AD system, this specifies the mac-address for the actor in
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..67ca78923b04 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
 
 	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
 	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
+	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
 }
 
 /* Conversions */
@@ -2209,6 +2210,9 @@ void bond_3ad_bind_slave(struct slave *slave)
 
 		ad_initialize_port(port, &bond->params);
 
+		/* Port priority is initialized. Update it to slave's ad info */
+		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;
+
 		port->slave = slave;
 		port->actor_port_number = SLAVE_AD_INFO(slave)->id;
 		/* key is determined according to the link speed, duplex and
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 57fff2421f1b..16ef13ddcf22 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -28,6 +28,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
+		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
 		0;
 }
 
@@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 					ad_port->partner_oper.port_state))
 				goto nla_put_failure;
 		}
+
+		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+				SLAVE_AD_INFO(slave)->port_priority))
+			goto nla_put_failure;
 	}
 
 	return 0;
@@ -130,6 +135,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
 	[IFLA_BOND_SLAVE_QUEUE_ID]	= { .type = NLA_U16 },
 	[IFLA_BOND_SLAVE_PRIO]		= { .type = NLA_S32 },
+	[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]	= { .type = NLA_U16 },
 };
 
 static int bond_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -180,6 +186,16 @@ static int bond_slave_changelink(struct net_device *bond_dev,
 			return err;
 	}
 
+	if (data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]) {
+		u16 ad_prio = nla_get_u16(data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]);
+
+		bond_opt_slave_initval(&newval, &slave_dev, ad_prio);
+		err = __bond_opt_set(bond, BOND_OPT_ACTOR_PORT_PRIO, &newval,
+				     data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 3b6f815c55ff..7cc9b033095b 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -79,6 +79,8 @@ static int bond_option_tlb_dynamic_lb_set(struct bonding *bond,
 				  const struct bond_opt_value *newval);
 static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 					     const struct bond_opt_value *newval);
+static int bond_option_actor_port_prio_set(struct bonding *bond,
+					   const struct bond_opt_value *newval);
 static int bond_option_ad_actor_system_set(struct bonding *bond,
 					   const struct bond_opt_value *newval);
 static int bond_option_ad_user_port_key_set(struct bonding *bond,
@@ -223,6 +225,13 @@ static const struct bond_opt_value bond_ad_actor_sys_prio_tbl[] = {
 	{ NULL,      -1,    0},
 };
 
+static const struct bond_opt_value bond_actor_port_prio_tbl[] = {
+	{ "minval",  0,     BOND_VALFLAG_MIN},
+	{ "maxval",  65535, BOND_VALFLAG_MAX},
+	{ "default", 255,   BOND_VALFLAG_DEFAULT},
+	{ NULL,      -1,    0},
+};
+
 static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
@@ -484,6 +493,13 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.values = bond_ad_actor_sys_prio_tbl,
 		.set = bond_option_ad_actor_sys_prio_set,
 	},
+	[BOND_OPT_ACTOR_PORT_PRIO] = {
+		.id = BOND_OPT_ACTOR_PORT_PRIO,
+		.name = "actor_port_prio",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_actor_port_prio_tbl,
+		.set = bond_option_actor_port_prio_set,
+	},
 	[BOND_OPT_AD_ACTOR_SYSTEM] = {
 		.id = BOND_OPT_AD_ACTOR_SYSTEM,
 		.name = "ad_actor_system",
@@ -1817,6 +1833,26 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 	return 0;
 }
 
+static int bond_option_actor_port_prio_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	struct slave *slave;
+
+	slave = bond_slave_get_rtnl(newval->slave_dev);
+	if (!slave) {
+		netdev_dbg(bond->dev, "%s called on NULL slave\n", __func__);
+		return -ENODEV;
+	}
+
+	netdev_dbg(newval->slave_dev, "Setting actor_port_prio to %llu\n",
+		   newval->value);
+
+	SLAVE_AD_INFO(slave)->port_priority = newval->value;
+	bond_3ad_update_ad_actor_settings(bond);
+
+	return 0;
+}
+
 static int bond_option_ad_actor_system_set(struct bonding *bond,
 					   const struct bond_opt_value *newval)
 {
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index dba369a2cf27..e9188646e22e 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -274,6 +274,7 @@ struct ad_slave_info {
 	struct port port;		/* 802.3ad port structure */
 	struct bond_3ad_stats stats;
 	u16 id;
+	u16 port_priority;
 };
 
 static inline const char *bond_3ad_churn_desc(churn_state_t state)
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 022b122a9fb6..e6eedf23aea1 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -78,6 +78,7 @@ enum {
 	BOND_OPT_PRIO,
 	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_BROADCAST_NEIGH,
+	BOND_OPT_ACTOR_PORT_PRIO,
 	BOND_OPT_LAST
 };
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 784ace3a519c..45f56c9f95d9 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1564,6 +1564,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
+	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.50.1


