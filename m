Return-Path: <linux-kselftest+bounces-39219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD667B29DA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE8917EB45
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773012D8382;
	Mon, 18 Aug 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPOQUy35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DA2367DA;
	Mon, 18 Aug 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509036; cv=none; b=kiook+neUCod97XC1Fqohjd3VqH2fa3Ja7xC+H81N6cyGzccViBoHbZcWij5zpoCjb0u8FZXL5IGXImYrY2cZLIgcK7tCSEKPYfUZBC3krjp9k0cSTDfxTmdPIiFPEaouQqlL9A9O139D4Xwu9bfkwokzhkaCzSc1HtyBuHnC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509036; c=relaxed/simple;
	bh=WA8lRCNGpB1vPXrqatDyLcXtbpX4Pc/tawqFRAmgP4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbnKZwLd4jbHf8u71mZhiTdszgOEucKYKj23a6zTwb9k1MCzoZLQavh/Mp23jZKTfHfYBjhqhe0jYgXLNwbuj5B3iv3QxobWxvb2ivXycRoBZhQp1OzyQQeB/GZmzQ7Fdkpo7eC6MZl5TtteAIHAh2W67cQuhRVL9SxpowIrhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPOQUy35; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e614b84so3621252b3a.0;
        Mon, 18 Aug 2025 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509034; x=1756113834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN8WWagQcL8HoYeOoP6e8dwOu0GSO3Ao2FmKKFnXYQo=;
        b=ZPOQUy35PenGqDVvtsmGJ7TI8KHvDuYyokk9bxh9FNVoRTFqXc4KiVQ75W8Lp2/MMn
         szvPkkvZBibnGLDIdYecz6G1YcCtsnQhTre9fWSVYEO22tZlrYy0JvCfM/C161lJiMPl
         uv39wmXMV9gx1evFZFg2+DUb5W4zRz1RZYSP++Fc4YN3sSYvyclbRp7IFvAGT9LYLNLs
         vq5DS3gfxvr5fnhtKCWjp5RzRJ8033WAHGMyG91M0fwth1TbqxEEaD/UYhOrPh3wBT+P
         UAbBA13oPnUnqrBuaE/RPcfAYud2qKRLNypqC1PbWYnZgjmYXlaUtGHzKf94qHTse0Fs
         bGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509034; x=1756113834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN8WWagQcL8HoYeOoP6e8dwOu0GSO3Ao2FmKKFnXYQo=;
        b=uW1IwZvxx1OH+5DbKTfW0zXF6IGPHCI1U94VU9QVtJdRWyZAztVGicyYIN7suil8cC
         NrpL372eDiqFe8RYucAKZA+Ifv6ARJu3S85/vAdgcljoTRJFK+kOEKcb3ouvnjiGmKEj
         Mz3VHPhnYPD+EFR5X5zcTtSG+SIIYin8xaARTu64M/wzAPDRc+ZQGRgYE/rRJEU+RFLj
         eUQ+SHPIz8g+21we1sKKyxovSmNq65LRSFOp9hfQ9k6fOC8CkjanWp+L0rHAUUHBD6V/
         cVlpMdxjxZF0DcaL8gp5eGiaPeJto0e6TD2B1yPNH07yh5ehJ1OIdJlxaAs8/2uJxzGB
         XvJg==
X-Forwarded-Encrypted: i=1; AJvYcCV7oxs18i6FiO46mxeEztgAh9ikdTK65PhlxcfRMZeeb1GzW8ggrkpj8Mq2nKnbcvfImGsNbNMGsg4=@vger.kernel.org, AJvYcCVA/C5WMqmznxhKnhi060WAuzsO0U+3b1dwrjF2XmCB+AM+sbs34i9Ci+HwsJ0aziu/YAlqXGSfe31efpr8F4zP@vger.kernel.org
X-Gm-Message-State: AOJu0YwdViisq4nTje/OOKX2DLmEyJmFB4FfBk1iZqHKGbDd13uZhzKM
	4p4h768I9rsIBgVJAD7d4Wdy8MoKA74Q2WFCiuJ3S1k4BWG+dP99gJOrdaprjulLIU4=
X-Gm-Gg: ASbGncsEv+7b+x1qm9yk/zTDt13Eyhi7MrJv699SF96egp9g8JLbVhmoIV99wkjIbdE
	f3hcjLX/d8XCBxmSgBKH0QJ+5PqmLJ157TpeKZT92nhK5FArIN//Fjqi5QePyVXG/E/gsNiBN5t
	ut4/lryUUnv8csiij1TeqeHpiWnxl4PTCiH7zpewHrPUjGWlGtx/guHWUrKD1Y1AiZQn2QOx+xI
	aflmxxN8mz/mdstXcETyeFmKLnh3QEc2Bs+Le5vm57DXKrWqo60UOMij+9Pf2qGJ4BfcfQT8g/1
	a4NHoqcvHk2bzTUIhVUCrkvAleYYIyHy2bsRoi84vqU/CmCBk1GYaJTbltiTZEJmOeQkhW4/f6A
	LZ/PHBk6jgZjNkeBuqYVsxSqZ8n5D8KHsizp6mq0qvg==
X-Google-Smtp-Source: AGHT+IGRnl3fmrFlW6+TUMs6wKKUvxuSsYfmHpoDxkOa0xbZ22DrXsv9NOWg75l5Jgm2GpcsyS8UiA==
X-Received: by 2002:a05:6a21:6da0:b0:240:1d4f:720b with SMTP id adf61e73a8af0-240d2fbf46amr17439257637.23.1755509033732;
        Mon, 18 Aug 2025 02:23:53 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45592eeesm6604976b3a.104.2025.08.18.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:23:53 -0700 (PDT)
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
Subject: [PATCHv3 net-next 1/3] bonding: add support for per-port LACP actor priority
Date: Mon, 18 Aug 2025 09:23:09 +0000
Message-ID: <20250818092311.383181-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818092311.383181-1-liuhangbin@gmail.com>
References: <20250818092311.383181-1-liuhangbin@gmail.com>
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
index 2fca8e84ab10..eb0fb7374391 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
 
 	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
 	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
+	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
 }
 
 /* Conversions */
@@ -2203,6 +2204,9 @@ void bond_3ad_bind_slave(struct slave *slave)
 
 		ad_initialize_port(port, bond->params.lacp_fast);
 
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
index 1d639a3be6ba..8f78f83fb29c 100644
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
@@ -1816,6 +1832,26 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
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


