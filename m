Return-Path: <linux-kselftest+bounces-25981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30341A2BF4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 10:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A763AA448
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190C1DC9A3;
	Fri,  7 Feb 2025 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz61CqcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC5481B6;
	Fri,  7 Feb 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920578; cv=none; b=sHW73ci2mKwfwgIiCQQ6nwOxu2/ENBgfJupiQ3UL09oBRz0bkY9s5Akv76nGMUG4Ufsgfy1DMGpHuHKW0T1RSD4A0Bg2aTvFf9eVy2UYK4R8wXImIHeAHe5BegHpdsiaRl3DBK4RXYxJWdVKidlRvKUF+klBprn/MGN/50Iyfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920578; c=relaxed/simple;
	bh=dfOP+js9MTUthZ5JWu9V2/exKIAlnX2g+AD6S133BCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY2R+pzwkFQ3J4u7OgbsbTDmlQQb5SDVr2KAAQNLvdti4Ldkbj6w48lbYbknKPVfA9Q/hlkDAnRMiJzvNQ4rGaus+VyzFD5H0M7P0u6kNWxB1apcU9hCOmBVM3oUjzxALDPtpvsLWXsHD9zfgSURVyeRpqhIHtjq0pg97cyzIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz61CqcX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166f1e589cso46922535ad.3;
        Fri, 07 Feb 2025 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738920575; x=1739525375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWhHNqBEeVRcUMT/7WLFMbNhfoPA1GtleSijtLJVN4=;
        b=Qz61CqcXZoKHKAC2Z6P9CWywmb1V4nCRYGKxY8SUe6gK3FxxTOaFglryIETKdJkZzi
         Ix60jQ7OhamwX+wXpWIphsgfazh77TCCT5zYKO2ww6dZNwujd5awR7BQiIwqp5dd0quo
         UjjyImuPcKzlGGJsKqPvqiLar5Hh+lhzAScWDiCYLWg6wLHGQXOJLpFdwh3w3o/2gpsc
         RZ+rd6b3USsDTp+bco20S00tNpMvkyfVdModZVfYTcUaMCSIJHYMtUZa4UrC36ar5jwj
         Mji7BL1nq8PegwIkttOOXqSlrUVRR2I3re2a5MCLCDzo/O3srLPEUxieaO0KDTKcWs5e
         uF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920575; x=1739525375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KWhHNqBEeVRcUMT/7WLFMbNhfoPA1GtleSijtLJVN4=;
        b=nk4ez6vfGCzXuNagScnroUy4w3Pv+n2lAG9WDX0+9vzW7H24aVPtNwdRTnTtrPp1Tb
         u6jLYihwaig1yLfWPzBWGJrP4KZTMt32f9b+Wp+bOyMu2JE7rckKQz6g9aF2lfW9/Fg7
         qNgZdDor1YvZgEush5qchVCXDTkoeB9Z+8tE2sTxG0YmvodvCQSDxi+9pY/dTlL5wmuC
         rK+H/6K+Jca2GC4RVdBkbZcN2zE+JKue5uWN4B09crk8HLawnh9GrF8p+U3XwZxzoW3C
         Fc6Q0EvQlW/HTFqZ6oYmuYHdY/u/3RAvAvPplFtXLls1piGa14rtRQzZsNPbXvL1OkHY
         Bkxg==
X-Forwarded-Encrypted: i=1; AJvYcCVscy2puYHgQZ99t1pp+had1N4PMpPX7AlSIO3ivTB4JfP7ODUDvzlLtntfbg9JMDURZDO1+3zSVbVP1Fw=@vger.kernel.org, AJvYcCXv9nmSVaV+bgCDKPLXQiBcgWPjmTQq9iS/Povf8WyuqaBj7k7HC46zEM8IH+3GbVN2scBC+mj+kw7IW2EP5Kx5@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRY1p5JUxjAO1VGxrF/eCJdWKFWO+8l/P0H3ya/2glwH1YYET
	ddcb3IzXEoL96OczOQxWTXeC+fIusZCwEnQoivMmTG7V03haWG4qE9rQ6UEn6EI=
X-Gm-Gg: ASbGnctiJCfaQ5PiDN1qxby7NnoHTcNCPtska8HhiMqPSZe9/N3LJzVop4U6TywVbv7
	syY6P8uH1c1EqZIOpm2WbMRkJc9UK8U21JwPXQy/hvNmtTbtwDDNv1+buhKY2rUNOLyUGg6FPyW
	5JNDCZT19oTUW4pxnP3QQI/iiphLY0zwnWJvkXKnrFDQz2yUX9E3+IlKIzSn7gcYv+rvZqg/46A
	pRBIjROwVNDh1QEN0c5/FIH5SNDqNG0Abfc9TtOK4/gyzXzRMkiL6oV9GcYhygb6rHYAz1qVDl8
	ZoeNHgQP6iGsVGAgEL5Zia68d0sSCMbZq6w=
X-Google-Smtp-Source: AGHT+IEuqI33Lh+gA0WhrrV5PrS/uFI+HdmpsSWto8QLTbFAhv2zT9jerEq221WC9mGLBvgdbqf4oA==
X-Received: by 2002:a05:6a20:c6c6:b0:1db:dfc0:d342 with SMTP id adf61e73a8af0-1ee03a247admr5518975637.7.1738920575472;
        Fri, 07 Feb 2025 01:29:35 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f84sm2591586b3a.80.2025.02.07.01.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:29:34 -0800 (PST)
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
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 1/2] bonding: fix incorrect MAC address setting to receive NS messages
Date: Fri,  7 Feb 2025 09:29:19 +0000
Message-ID: <20250207092920.543458-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validation on the backup slave is enabled, we need to validate the
Neighbor Solicitation (NS) messages received on the backup slave. To
receive these messages, the correct destination MAC address must be added
to the slave. However, the target in bonding is a unicast address, which
we cannot use directly. Instead, we should first convert it to a
Solicited-Node Multicast Address and then derive the corresponding MAC
address.

Fix the incorrect MAC address setting on both slave_set_ns_maddr() and
slave_set_ns_maddrs(). Since the two function names are similar. Add
some description for the functions. Also only use one mac_addr variable
in slave_set_ns_maddr() to save some code and logic.

Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_options.c | 55 +++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 327b6ecdc77e..d1b095af253b 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1242,10 +1242,28 @@ static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *sla
 	       slave->dev->flags & IFF_MULTICAST;
 }
 
+/**
+ * slave_set_ns_maddrs - add/del all NS mac addresses for slave
+ * @bond: bond device
+ * @slave: slave device
+ * @add: add or remove all the NS mac addresses
+ *
+ * This function tries to add or delete all the NS mac addresses on the slave
+ *
+ * Note, the IPv6 NS target address is the unicast address in Neighbor
+ * Solicitation (NS) message. The dest address of NS message should be
+ * solicited-node multicast address of the target. The dest mac of NS message
+ * is converted from the solicited-node multicast address.
+ *
+ * This function is called when
+ *   * arp_validate changes
+ *   * enslaving, releasing new slaves
+ */
 static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
 {
 	struct in6_addr *targets = bond->params.ns_targets;
 	char slot_maddr[MAX_ADDR_LEN];
+	struct in6_addr mcaddr;
 	int i;
 
 	if (!slave_can_set_ns_maddr(bond, slave))
@@ -1255,7 +1273,8 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
 		if (ipv6_addr_any(&targets[i]))
 			break;
 
-		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
+		addrconf_addr_solict_mult(&targets[i], &mcaddr);
+		if (!ndisc_mc_map(&mcaddr, slot_maddr, slave->dev, 0)) {
 			if (add)
 				dev_mc_add(slave->dev, slot_maddr);
 			else
@@ -1278,23 +1297,43 @@ void bond_slave_ns_maddrs_del(struct bonding *bond, struct slave *slave)
 	slave_set_ns_maddrs(bond, slave, false);
 }
 
+/**
+ * slave_set_ns_maddr - set new NS mac address for slave
+ * @bond: bond device
+ * @slave: slave device
+ * @target: the new IPv6 target
+ * @slot: the old IPv6 target in the slot
+ *
+ * This function tries to replace the old mac address to new one on the slave.
+ *
+ * Note, the target/slot IPv6 address is the unicast address in Neighbor
+ * Solicitation (NS) message. The dest address of NS message should be
+ * solicited-node multicast address of the target. The dest mac of NS message
+ * is converted from the solicited-node multicast address.
+ *
+ * This function is called when
+ *   * An IPv6 NS target is added or removed.
+ */
 static void slave_set_ns_maddr(struct bonding *bond, struct slave *slave,
 			       struct in6_addr *target, struct in6_addr *slot)
 {
-	char target_maddr[MAX_ADDR_LEN], slot_maddr[MAX_ADDR_LEN];
+	char mac_addr[MAX_ADDR_LEN];
+	struct in6_addr mcast_addr;
 
 	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
 		return;
 
-	/* remove the previous maddr from slave */
+	/* remove the previous mac addr from slave */
+	addrconf_addr_solict_mult(slot, &mcast_addr);
 	if (!ipv6_addr_any(slot) &&
-	    !ndisc_mc_map(slot, slot_maddr, slave->dev, 0))
-		dev_mc_del(slave->dev, slot_maddr);
+	    !ndisc_mc_map(&mcast_addr, mac_addr, slave->dev, 0))
+		dev_mc_del(slave->dev, mac_addr);
 
-	/* add new maddr on slave if target is set */
+	/* add new mac addr on slave if target is set */
+	addrconf_addr_solict_mult(target, &mcast_addr);
 	if (!ipv6_addr_any(target) &&
-	    !ndisc_mc_map(target, target_maddr, slave->dev, 0))
-		dev_mc_add(slave->dev, target_maddr);
+	    !ndisc_mc_map(&mcast_addr, mac_addr, slave->dev, 0))
+		dev_mc_add(slave->dev, mac_addr);
 }
 
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
-- 
2.46.0


