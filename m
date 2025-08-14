Return-Path: <linux-kselftest+bounces-38956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30AFB2630C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D447B629C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4332FA0F8;
	Thu, 14 Aug 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8s1Ozct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BD2EE29B;
	Thu, 14 Aug 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168206; cv=none; b=kcQav/QUmlKaoxTeedtbHTMHvfax6NaJQ5BHDEBoR2ll/RidIaXu3diyC57eV1NFGaJSoA7sCoZPhL5OBqo8E7guhNNdkRxHGw3OXvbZqkBUw3fH0HWrLhBxGdcG91LassrcDfB1hTRrnxW/iZfpD6PpLKVBQFA/ny9KbARlH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168206; c=relaxed/simple;
	bh=gsD1DRUm3p6sGvP+fEtcX0s4QJep1TM+RIq/6NL8ec4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=molkZzJHu7d02bgrTUQ5zGM5h+GisP3CTJWdikX8BqBBOLVRQHCsOT3WOsbZKMdDKhhCVNRGoWBUH02EXSRkKYuCp+2MSF87qlx8oEK/Vg8CNkVRM5BJ0b2z/L2olEa37mbF+w6F/IH3OWw/4V7LvFSvF0h/xtgoo1kpu48kLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8s1Ozct; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4717553041so570846a12.3;
        Thu, 14 Aug 2025 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168203; x=1755773003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIvZsgH7uk2NC6ii9Hr2pFZCkna5eOxAa3S5GUypue8=;
        b=U8s1Ozct3RUhDWrwNBwmiyha4EARGz3T+bcOUTZqAKckKw8a21Nu2R1UWHK2i8MAOu
         VIRrLMqDc46deJBAFxBPfX1De01KbPeX6/tc2REzcycZNdGbsdv8hnXs/F37TfbffhfZ
         5reznXbD26tOXCarSA56e2UrKLQFn6Lu8n3Dwq7jSPL9APvu6DCWSzURMBxQLPrWIc3U
         x9XQZ2ut0YwkewKLOSMrExPOuLDbCu/m8FUdFkhWLB0rZtxwKsX2cEk0QPzR0RqVzsG2
         cPe53D478lBnmyVmC7KsB1kIwUTShby6kZPj/dYWG3czuCOZMBYcHQsm+GqsRt5TjaWt
         d8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168203; x=1755773003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIvZsgH7uk2NC6ii9Hr2pFZCkna5eOxAa3S5GUypue8=;
        b=RaRbbMhDim98qCrKKGx1EKk/qgWw59uT+gmfnlwNzQmyYUsnmnVVt3BnWMHWSv17w2
         t97NVRlQKHLpyHYfnGunhyxKeEBWLdvOyM91Kb6y6gEkPygsr6QuV9nU3jCSpN5/CLzG
         fOs75girTNiODFw7N7VnYD9AvW0c8tbcCQklbe+n+TPYW30j6474Ci5GFoSo0oBEju+l
         xJfQ7jgd+ZrfU85S76BVT0ml4gUG4lPK5CCXPpi3CLiRTZOYU1XiVFE1NSJUxG0LnKAy
         Yrk8sCm1krePb3scaG/4HxgAbbz1dMwGPhUIy82mQYjev6AtDGnvuUQPsHEgb0xf77vT
         KIrw==
X-Forwarded-Encrypted: i=1; AJvYcCVi5OrSE8wcxtdFNjz7T8IF0iFLi9U0r44cVk0uQfd/pnGKrxtRvR7B69LD6Hs04WbH3e6ZPIoA1J0=@vger.kernel.org, AJvYcCXv/QhXitcDkrD7PSJgs0sAyLePzEDxi0epbRhUkw5ckoLnXd7mDghYzMup5s0gXT0nf1Nl8rRS0WbTXClVOFUz@vger.kernel.org
X-Gm-Message-State: AOJu0YzmO23t/Qp5KBrVSLrhYz7tBrw7ZbaoHOsqRFYb8/w+JpSA/LVZ
	Y64PY7fVIjwkSeDzA+yNtBJJk4uEN0jE91ZCAi6giW4DgAeabSOtWbSOrAFphC2u
X-Gm-Gg: ASbGncvz0z8lnZ21cj3w7Thwak0r5X+uPO5AbStFMEa6SbA6TcF8tzVBhtCkriMt8Or
	l6VVwxrPVkFHKBcNxpTSpJPZvINMIA6l+9qEpgbOyN9OaZd+XlcVOCYBOjV8kTewrM/D2r11KAO
	kPBuBDIxnMS88yZf2ZJBfKCvrckwxEcRquycBJRSmdKp0ATavNihK0cCJF+5nnLJhVE3RulyK9t
	2a3E5bjScXfrBV3LhKcxHBQL/Fx+kvDAWPdu4omUCmmdIai1EloHK675D4+5KrrN/5vSXIAxjVc
	ITMvKpOPTTuZl32yzGH7k+LqdjHpW+4brtjCHvatjzAQnf9HD/Z19LLxFv0PEfVsjmrG7peY9Xl
	LsHFymGdz+2RpABs9UFcs+UFgdOx3AWjBbqJ+9qWTzQ==
X-Google-Smtp-Source: AGHT+IGG/w2rHJCR0aysbOEV9U0bZNyPiybRxnlXWQhGKW0/6GG0t1xKA1juwwpvjc56LQTX7+3rlg==
X-Received: by 2002:a17:903:2f05:b0:240:bf59:26ae with SMTP id d9443c01a7336-2445868ee6dmr43754055ad.36.1755168203241;
        Thu, 14 Aug 2025 03:43:23 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a1csm351796225ad.78.2025.08.14.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:43:22 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/3] bonding: add support for per-port LACP actor priority
Date: Thu, 14 Aug 2025 10:42:54 +0000
Message-ID: <20250814104256.18372-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814104256.18372-1-liuhangbin@gmail.com>
References: <20250814104256.18372-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new netlink attribute 'ad_actor_port_prio' to allow setting
the LACP actor port priority on a per-slave basis. This extends the
existing bonding infrastructure to support more granular control over
LACP negotiations.

The priority value is embedded in LACPDU packets and will be used by
subsequent patches to influence aggregator selection policies.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst |  9 +++++++
 drivers/net/bonding/bond_3ad.c       |  2 ++
 drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
 drivers/net/bonding/bond_options.c   | 36 ++++++++++++++++++++++++++++
 include/net/bond_3ad.h               |  1 +
 include/net/bond_options.h           |  1 +
 include/uapi/linux/if_link.h         |  1 +
 7 files changed, 66 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f8f5766703d4..874d8a4681ec 100644
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
index 2fca8e84ab10..19b389b81600 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
 
 	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
 	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
+	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
 }
 
 /* Conversions */
@@ -2211,6 +2212,7 @@ void bond_3ad_bind_slave(struct slave *slave)
 		port->actor_admin_port_key = bond->params.ad_user_port_key << 6;
 		ad_update_actor_keys(port, false);
 		/* actor system is the bond's system */
+		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;
 		__ad_actor_update_port(port);
 		/* tx timer(to verify that no more than MAX_TX_IN_SECOND
 		 * lacpdu's are sent in one second)
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 57fff2421f1b..3a37298583ed 100644
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
@@ -130,6 +135,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
 	[IFLA_BOND_SLAVE_QUEUE_ID]	= { .type = NLA_U16 },
 	[IFLA_BOND_SLAVE_PRIO]		= { .type = NLA_S32 },
+	[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]	= { .type = NLA_U16 },
 };
 
 static int bond_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -180,6 +186,16 @@ static int bond_slave_changelink(struct net_device *bond_dev,
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
index 1d639a3be6ba..5b58326dd24c 100644
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
@@ -223,6 +225,13 @@ static const struct bond_opt_value bond_ad_actor_sys_prio_tbl[] = {
 	{ NULL,      -1,    0},
 };
 
+static const struct bond_opt_value bond_ad_actor_port_prio_tbl[] = {
+	{ "minval",  1,     BOND_VALFLAG_MIN},
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
@@ -1816,6 +1832,26 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
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
index 022b122a9fb6..a2e20d4e03bb 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -78,6 +78,7 @@ enum {
 	BOND_OPT_PRIO,
 	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_BROADCAST_NEIGH,
+	BOND_OPT_AD_ACTOR_PORT_PRIO,
 	BOND_OPT_LAST
 };
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 784ace3a519c..ea39df311a6e 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1564,6 +1564,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
+	IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.50.1


