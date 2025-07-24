Return-Path: <linux-kselftest+bounces-37932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BFB10330
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6047AB0AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8574274B37;
	Thu, 24 Jul 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf6pOeWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D620127B;
	Thu, 24 Jul 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345030; cv=none; b=H3jvqYpN3rv6AICyuYJqEQYOoYNjpEltf0VVByVe2Kl9LdVLW6MxJPPuV7L3WL3Ej1Zl6mFJ12E6EbUIWaaGXp7WsWacL7sxY4BpkeSXg07bIiSFwpvjgnAAMhajg6Ko0w9VOF8ZpkpwBwVsjp7YIcG7MdC9prv6jdcvLbv/fIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345030; c=relaxed/simple;
	bh=Xl0w1IpxiSoHGG+zVHXmZ/2nRC2G/Xtt3KJMC/MMALo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PziwqQiRaJKP9oBLyR/4BV5g7eyTD3RfSZiLZ3QfoYyPVWiM9++1uM3B525aENja6qzSq9QRB+1BAfHZ/NIMXiDTvo5Ccv6oOe+/ZtAmESkRmTfMFkdLkFHCBYRMjGGaD762xnIQHvsOsoJLMXJIwaD679Iw1/+oM+I9kJnDbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf6pOeWY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1fd59851baso576437a12.0;
        Thu, 24 Jul 2025 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753345028; x=1753949828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7cWMJvMn47eS4XEI88F/UAG7iToiVpJXFUIoi55Q00=;
        b=Hf6pOeWYpoRzC4QPUBNU3DJ5wmdxg3TFNOlfMKChcGqvfV29jwJY+lJaxaP/XtuFuA
         NigIxLCMXONAHGCqlY3rfNPsiRtEQZz+pAcO/b7ca6AmrhNOjMqvPW9aI24LTnA3yQOi
         HKG9TH5f5fXJq0DhN677G6C5amIA+Z13aTPAd7CPv76WMptafupYia4SB4sYYGOpEHVv
         PH8/d/mUgvJMXeLig9f1QFQ/rgKwJtv/vBbcBTQ60aPsWDuYAAYEmVwni9/Cq1sCJBvZ
         bpjqRX1F/mGcgn0IKYInqtfDEOeYXLbKQYed/2jTQGxKFfxlA8+cnDXBdIVsRW6MsD+Z
         USsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345028; x=1753949828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7cWMJvMn47eS4XEI88F/UAG7iToiVpJXFUIoi55Q00=;
        b=vCx4pBHImER1zHcOUtm9r17yGvSCwJ5pbSbSVBLyM8cmRaVnS0/iOHXlwf47hNxQ5R
         lqBmIKzPrbN4FX52x6yMDJTb10YJD3WjAJw/Vt7szKnsMeOdY+YRc8fN1aJslOUcgo3Q
         kWLpx2mBVD2tamrLEvBrNs8DW+Yqa4T79venrQ/Hlc3PugpQKWhJYhEWY5Wvq9BCVJlc
         A6m3XJ79W8I0DZiAnUL/s1Q7TAH1DDGwqsk6HN8ICr1KV6kUjI7lb+1gbiRpsQtcb8hE
         QH4i7+Kos61FSk/jhw+kTOJiq5zqVJZtaRvMvijE6dTpSDvFUArtJbMMSJeOUrtHbqx4
         VmFw==
X-Forwarded-Encrypted: i=1; AJvYcCU7BssCENU/M0lwe4qwGsKq5uR32PSvH6KmXjKnzpG2cFkkFh5HADTw61o44gGmdNFcKQ74lgyZQmw=@vger.kernel.org, AJvYcCUG71aT8fh+faSB5dws8o8E08sjZRw4AFUQvMxA25uEAH7aUAAf/nkQtoA7f067zp7EmUdBGgzuYTfdtMc1vSeg@vger.kernel.org, AJvYcCWayfHZVwZDzRR+1SW1cln3sWNEIpRmfaJHLP26FAiOX5gNvK4MdjcYX2l3RdLyAZ5QzMc2aX1VgfhC/8tD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PZNrp2c4Q27zghTr0mngNywJf+QzNXViKetL1gR3J8Iv9tTh
	nk6tZB7HxEzjoLunTj43UyYPkjMYXq5Z1/r68KsMnLX0TA/PSxxleiTx7aaWOd5X
X-Gm-Gg: ASbGncsptwaBjeudNKwwirYKKylL5dC1FCYJrjJStOSQpyd35P2/y0Ubnf5fziAphmw
	H3c/YyyLfWjre9WZ7UgrXDwyjNXr3omgn4OWzOjyMNAAxNNGtC4rli/lWYn7pX6j0sXmS5mv0Ib
	8E2SCgfvsXdsEiHorIcPAnw/Lt73GHuU/xvan41Uy1LauEY9MyFy46yhdFqiHpoHnb2OJD+8Rdw
	Z+F7xheen6d7YhWcam8rrkuRtkWha8u9qxgtrQVrNnhZc8oPTgv/rOC9nDPfw0O4AElA88Fj9Gt
	jdZs+I71TZXZccUnyfXZJwR3F/qmxinbMEu40UYbYzXxcu4zsCTfsFke7AquTql3Toc8hiQRDTX
	wL6BAi2SjMrxG6M5b0Xri6ua28JPRnE1osF7FJTolp+ZaYdw=
X-Google-Smtp-Source: AGHT+IHXcLv2NnmgB7Lyqg/CA9F/BVNQ5fO2HiaSvawtrYEm9cplDWfhJeb2KgMlBinDg3EAVERjmg==
X-Received: by 2002:a05:6a20:7349:b0:232:3141:5879 with SMTP id adf61e73a8af0-23d4912949amr8688192637.33.1753345027967;
        Thu, 24 Jul 2025 01:17:07 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7bbeesm1074704b3a.24.2025.07.24.01.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:17:07 -0700 (PDT)
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
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/3] bonding: add support for per-port LACP actor priority
Date: Thu, 24 Jul 2025 08:16:30 +0000
Message-ID: <20250724081632.12921-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250724081632.12921-1-liuhangbin@gmail.com>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new option ad_actor_port_prio, allowing users to set the actor
port priority on a per-port basis in LACPDU.

This priority can be used in future enhancements to influence aggregator
selection via ad_select policy.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst |  9 +++++++
 drivers/net/bonding/bond_3ad.c       |  2 ++
 drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
 drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++++++
 include/net/bond_3ad.h               |  1 +
 include/net/bond_options.h           |  1 +
 include/uapi/linux/if_link.h         |  1 +
 7 files changed, 65 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index a4c1291d2561..5e105e7ac8e6 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -193,6 +193,15 @@ ad_actor_sys_prio
 	This parameter has effect only in 802.3ad mode and is available through
 	SysFs interface.
 
+ad_actor_port_prio
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
index c6807e473ab7..4a1b2f01fe37 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
 
 	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
 	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
+	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
 }
 
 /* Conversions */
@@ -2197,6 +2198,7 @@ void bond_3ad_bind_slave(struct slave *slave)
 		port->actor_admin_port_key = bond->params.ad_user_port_key << 6;
 		ad_update_actor_keys(port, false);
 		/* actor system is the bond's system */
+		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;
 		__ad_actor_update_port(port);
 		/* tx timer(to verify that no more than MAX_TX_IN_SECOND
 		 * lacpdu's are sent in one second)
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ac5e402c34bc..ad91b93cbdac 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -28,6 +28,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
+		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO */
 		0;
 }
 
@@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 					ad_port->partner_oper.port_state))
 				goto nla_put_failure;
 		}
+
+		if (nla_put_u16(skb, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
+				SLAVE_AD_INFO(slave)->port_priority))
+			goto nla_put_failure;
 	}
 
 	return 0;
@@ -129,6 +134,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
 	[IFLA_BOND_SLAVE_QUEUE_ID]	= { .type = NLA_U16 },
 	[IFLA_BOND_SLAVE_PRIO]		= { .type = NLA_S32 },
+	[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]	= { .type = NLA_U16 },
 };
 
 static int bond_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -179,6 +185,16 @@ static int bond_slave_changelink(struct net_device *bond_dev,
 			return err;
 	}
 
+	if (data[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]) {
+		u16 ad_prio = nla_get_u16(data[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]);
+
+		bond_opt_slave_initval(&newval, &slave_dev, ad_prio);
+		err = __bond_opt_set(bond, BOND_OPT_AD_ACTOR_PORT_PRIO, &newval,
+				     data[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91893c29b899..2b8606b4e4f5 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -79,6 +79,8 @@ static int bond_option_tlb_dynamic_lb_set(struct bonding *bond,
 				  const struct bond_opt_value *newval);
 static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 					     const struct bond_opt_value *newval);
+static int bond_option_ad_actor_port_prio_set(struct bonding *bond,
+					      const struct bond_opt_value *newval);
 static int bond_option_ad_actor_system_set(struct bonding *bond,
 					   const struct bond_opt_value *newval);
 static int bond_option_ad_user_port_key_set(struct bonding *bond,
@@ -221,6 +223,12 @@ static const struct bond_opt_value bond_ad_actor_sys_prio_tbl[] = {
 	{ NULL,      -1,    0},
 };
 
+static const struct bond_opt_value bond_ad_actor_port_prio_tbl[] = {
+	{ "minval",  1,     BOND_VALFLAG_MIN},
+	{ "maxval",  65535, BOND_VALFLAG_MAX},
+	{ NULL,      -1,    0},
+};
+
 static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
@@ -476,6 +484,13 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.values = bond_ad_actor_sys_prio_tbl,
 		.set = bond_option_ad_actor_sys_prio_set,
 	},
+	[BOND_OPT_AD_ACTOR_PORT_PRIO] = {
+		.id = BOND_OPT_AD_ACTOR_PORT_PRIO,
+		.name = "ad_actor_port_prio",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_ad_actor_port_prio_tbl,
+		.set = bond_option_ad_actor_port_prio_set,
+	},
 	[BOND_OPT_AD_ACTOR_SYSTEM] = {
 		.id = BOND_OPT_AD_ACTOR_SYSTEM,
 		.name = "ad_actor_system",
@@ -1793,6 +1808,26 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 	return 0;
 }
 
+static int bond_option_ad_actor_port_prio_set(struct bonding *bond,
+					      const struct bond_opt_value *newval)
+{
+	struct slave *slave;
+
+	slave = bond_slave_get_rtnl(newval->slave_dev);
+	if (!slave) {
+		netdev_dbg(bond->dev, "%s called on NULL slave\n", __func__);
+		return -ENODEV;
+	}
+
+	netdev_dbg(newval->slave_dev, "Setting ad_actor_port_prio to %llu\n",
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
index 2053cd8e788a..bf551ca70359 100644
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
index 18687ccf0638..4aee1935e0e7 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -77,6 +77,7 @@ enum {
 	BOND_OPT_NS_TARGETS,
 	BOND_OPT_PRIO,
 	BOND_OPT_COUPLED_CONTROL,
+	BOND_OPT_AD_ACTOR_PORT_PRIO,
 	BOND_OPT_LAST
 };
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3ad2d5d98034..79bcbbc264a7 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1562,6 +1562,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
+	IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.46.0


