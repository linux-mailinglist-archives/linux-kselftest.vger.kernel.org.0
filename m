Return-Path: <linux-kselftest+bounces-28366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1ACA540C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 03:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C43AEFA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 02:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71CC192D8F;
	Thu,  6 Mar 2025 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9dVS6rO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFC18E34A;
	Thu,  6 Mar 2025 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228781; cv=none; b=E/JIToy7vaJ+FjVKdyAWNKdXSdQTAyerZ4kyT0UHE3DznPjsT1K6/G85+Ps8Jr97VrywtG3udLBhmzhmVT+/Ae29RqzbXWKmPjuDaqcotlr9BFJLYmovBCID64y5XmOHFGcY/OgjB79qMDrGYZFc/lGBadWyLVl7Fl+Bi6Sqw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228781; c=relaxed/simple;
	bh=BJXzdWArLpbeZokglwULd5q6HYfWgnddpoPrgyYlMpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPrRqSIVKhGr59SskG1ukMUrEoP+47cjagMu3MLOJdg3aT2l0nfRqLOjoUPNcxC6QrWzVOBtGgrBzdZWpDkdvta+ACMss2k0KNUqwO7NtWrlslY7h2ESpOllwkYTzR+C6nB/SxYA1V8cSGV/HgM9q8DulRIf1x98tcg+pxNYN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9dVS6rO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso3294905ad.1;
        Wed, 05 Mar 2025 18:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741228779; x=1741833579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmQJX858+XR+QkKFlvo/tyMTjx7b3MENDWnGfwSdcmY=;
        b=j9dVS6rOlUW2xQxXFa5VeshbdoYl205+DmLOH0IToYw+QDbYHR0OKZxupVLiFWmBKz
         A4q8VTBW6VdbUoNalQLJdAoiH6Vl8BoG3+xTgxoQEr9hhpGwEBEDSrciYUHk2U7LrcUE
         i7BHEuvZUiPrXaXhvfe6VP3plJ8Vop1YH9fP72fFM7hAXkVVuFDg6oPBfsRNi8r0XjZv
         aL3KRLpNw0O5y7pc0KohjRbY9paShXvLoRvT84NPtYGyzHlnbUhoRF7YQ+JMIv0fWfnf
         bm6uWfyah7qc/wbKQrkfZ5atmC6AD9gQsJsivGOWiO6OKqUN09R3la0pFbiO83uqZtoB
         phOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741228779; x=1741833579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmQJX858+XR+QkKFlvo/tyMTjx7b3MENDWnGfwSdcmY=;
        b=NITDVRLVGJjnIC27b/P91kmB6RGFEqr7tgj5Y/CpMkx5oHPvwcQDoQtrmRmbRJyjde
         CoR5zM0g4gCeKb+BohF22l0naZVm7q0dB3qhK1SQ5F7bql6jBh8JQioU+1AFAt4XAN/F
         yoHDx6p++M/93CXQDejktI+zjDV2LzteyXC/sevvg1zRL5iNtI9L7eZIXpmnX93o3fQ9
         /aQQjqJCUWIH2otjs6LPsgeNrONULnTaiud+QauXBWVzlKNnJgHFjEY2dJWcHsOktT1v
         Cr6OfmBODfUK5/DY6Wwl7SmSJTWFU3zoNN9+KovFCuwRERM/fzY0/m7nO0V29kR69Rme
         0v9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+TzX19dI2CHJKVJxVwUfAlERTIEp9Hg/IUmAn6j9Pjt2+qBGD4YjZ381O2nxvAUf+uvrBm1HAv+4mtKgOm0FA@vger.kernel.org, AJvYcCVcMF42uL5Li47ZBkms0GDPUpnvyfSXQ+KQk/QwXZ+oFG2skD3QNZFCrQVioszoEXar1ZX4swgqIyJyReE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1QD4iXc6P8hQQcOOEFAVPhoJayGHT4ULkf/JpObBU/ZTydEt
	Ile36f9gJN7EnxPLiF3ntxYyopV0lRRru+FOx3TABH90uDbq/sxtXsGfwaAvEB1+rA==
X-Gm-Gg: ASbGncvItPCWo0Rg7xnw05SQU7ia9DvWyBBW4MzPa0vnwaXW9mkI3YJ0S+bDeDeaaO/
	539FEJT6RorRi0G3H1+9t3LWLufEKag3aQEfWK4jyU6CK0d5of6MtSU8gbvu6pjhm+SEdbmvj/5
	srfBcsjnF2Tq2xP4vndSe6ezuBtXozSrc/pBMcc79gimp095ObtXdga15D5rHndMwYKHLou5guH
	QCZahKZcny4eqE1wKdtn03uUIKNwMZuDDXclF8rd1/qed2LSCAzI+/8Yox8kHzqDszMD2Pe5+BB
	NQ6LJOmC93L82TdY02D+4iN69Ngdcb/6HIEC+lG53jzJBGUNAwTYxpxjXyO8ONpW
X-Google-Smtp-Source: AGHT+IEWNLZSeD4cIqQGUneHJeoQLuyVGzFvCccx8E2K3TOZhbq8AXlQTEL6yquIaljRFXdPnSERXA==
X-Received: by 2002:a17:902:cf0b:b0:223:3eed:f680 with SMTP id d9443c01a7336-22409477568mr24572845ad.18.1741228778880;
        Wed, 05 Mar 2025 18:39:38 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm1292185ad.243.2025.03.05.18.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:39:38 -0800 (PST)
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
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 1/2] bonding: fix incorrect MAC address setting to receive NS messages
Date: Thu,  6 Mar 2025 02:39:22 +0000
Message-ID: <20250306023923.38777-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250306023923.38777-1-liuhangbin@gmail.com>
References: <20250306023923.38777-1-liuhangbin@gmail.com>
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
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


