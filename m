Return-Path: <linux-kselftest+bounces-40507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0553B3F5CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE82205D69
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D182E54A8;
	Tue,  2 Sep 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9BJMawX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCC11CBA;
	Tue,  2 Sep 2025 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795527; cv=none; b=Xzwcgdn5IDjLGju294uT7Z3XdMZYKLd/qCoA1XJgq2cXFRSvwIEO0Dta0vzPPhOtXm4QATSbXZ0RoqflYNkeGukD6Eu2tDLgRdeCEzUnrAbkTQt7zE9bHX/cnxX/3X2AP6QptiLWVsoeq+Sf8I9hso7dHIzN/6HRdBFu6VaVkJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795527; c=relaxed/simple;
	bh=AkXB3gS4M+sSLpB5BUe8NC1jjjU5fbDSQHYjijLuV1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLMI2kjPJvr8lTagopZJ4I9DPNsNVkXwjESZnpTsMptYha5ePwsD+bfPlmxpyN4Rny0CIPn8PexpJ9GXblgpA+TVV1zUe1gX2daN7cFeS8pH7Af5VNXPI/W/Ev9Uqr62Ci74PyD4j1u1oRDuBFlE8d+RkuZSXmqjqAKYg1bTNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9BJMawX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4102347b3a.2;
        Mon, 01 Sep 2025 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756795525; x=1757400325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGfb+6S+dxMKBkiPmtd8j0OA0OCsATPuQRhq784o9Xg=;
        b=W9BJMawXYHSbdbXy8zbfzwdbGBeOvu3MwGCxS2ANVlzpkNBzjFtLBBcO2umasx9BuG
         qE9M4hneM1zuB4uIBMUehtRQo2ZafFBYeQ6rTczVc4hAegGgNWI4pKmYw6YKQshHTbqM
         TyO3lfolbFGKDu0MTjPsurxrOez59mLzgaBm65lF2iQkG9onQqNYSkv2gAPqqiIIwJjL
         Z7Tgdqp+Z3YQlwc56lt1kgcVQreRdzEDky8MYVta9Mz1mhj/zI45HRqFoPBCPVa0uX2J
         Hr2vsyNuONrLaW9mmM2JEUN/rh5PMTo+ul6XVe5VmddiNj8Pbm6MphLzneXX/0cvlMFP
         DucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756795525; x=1757400325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGfb+6S+dxMKBkiPmtd8j0OA0OCsATPuQRhq784o9Xg=;
        b=IPnznwrblC5dyrqEl8ujTOQ0BAZ8l/5KXNP/gyXMVOB+q1RaPzuL93ULCVnkHdz7Sg
         sA4jctCqT53O1cUweKWePIxrwc+nmzXxZ4J0eSSMQVBN1O3nUOz4Upm5No1vImPkBHBa
         lCaktbQ/XucVbsh+WJDmEgnpO+YT4U/T6SA/+0fG8k5LahqfU+v3rkUe0YA/reS/UzLm
         811GKmdsW4oJUPcbVy+QwKzGUJQz1UDbv5r+oGj40R9NlxglrnWtMQ/36c9k6jnsPrVB
         EQt4Bq8WDpfifiWcWds/5sSneKZtEikQBZaqveaLt8NWz+6kM9NFFuFjvB3Hyh5yKm4q
         f2eg==
X-Forwarded-Encrypted: i=1; AJvYcCUzj0cp8B90fkDSy8bTnEzrU+yMrxIKUQeDAjN0elvRKp1DU6apgRcDApxDJF3qiUbI5RGuythnldblNbm50785@vger.kernel.org, AJvYcCViFisQCFti3Btc88N65nl0X9UFfCK8fBo6tEpYgeQGrWZyxOOEPiGmr5+N4VW1FsREJE9KkvMQm7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcxW7GQvaSjR8aXo8V6M8TmjcJJxeLytpVeHdEw+XKmWfS1Ru
	boI2J612jqdwRPjpbL8gop9AsJ6qPHH8vX3+q5A3aVizF8dOARER4ooEoZNcuQ9lM0E=
X-Gm-Gg: ASbGncuGZxNJsHD31oAfq2PTME3lMAAH4n7/FRDo7DXJJnzlz5PZzDCFHBoYkNkLsIM
	TcU6SXRcHt66mRe5AXBsEIeb8nj8n+UjmLiyD7eLD/fQT4aFirqEVwKlTRwi1m9PqKK+j7APq8h
	0RVz+xRcADjGGpCueVG9/VDeQj8qOjBe9evzaQ4bP6atsFIcWtubS4UOmF0lNenceinb3TUd4OF
	J9vxoWEUZhpnOVs/jqSRmC/HOMLAYuE1G6xqCt7ZcpFhzupjLPQ5O8VAvLefgd0+w0s/RamXuIe
	Ofj2yEZU8HEiKnPEPpF1cGm/KBfFs7RBY4RrQ7gRUrHZTnxu1BXR5cUHK4x1Uu5ZcZWaaHa8klW
	cEDnJdhgFxk0cVCKBnnwpiGugbNOvWWP8DzlOwpTaZw==
X-Google-Smtp-Source: AGHT+IGzHRTRvaFAbPxiMnP0xKgawW+7XjkEUWxNWcCGGSPTkE3rYz4pUUt7qH/HLRRF52DhdAOQbQ==
X-Received: by 2002:a05:6a20:9389:b0:243:c8df:b557 with SMTP id adf61e73a8af0-243d6dd7ac4mr14301495637.12.1756795524954;
        Mon, 01 Sep 2025 23:45:24 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd2ea3a04sm10936681a12.38.2025.09.01.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:45:24 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCHv5 net-next 1/3] bonding: add support for per-port LACP actor priority
Date: Tue,  2 Sep 2025 06:44:59 +0000
Message-ID: <20250902064501.360822-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902064501.360822-1-liuhangbin@gmail.com>
References: <20250902064501.360822-1-liuhangbin@gmail.com>
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


