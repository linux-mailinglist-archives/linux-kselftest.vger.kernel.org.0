Return-Path: <linux-kselftest+bounces-33141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880BAB92B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 01:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373541BA8474
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683D28A708;
	Thu, 15 May 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1/VX6hA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEC19FA93;
	Thu, 15 May 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747350816; cv=none; b=ZH4Tu33epPVYbseC3az5yomyh093bQWPE+2RZHNinygEEQjBVOVC1fzpiuDhkA5LcmpubV5dkq4tVFixk6Pp1uOY7JPJEORA3G99RvxqNOY3+Msqg187w4cXnxule3qGSI9RMmty7V7yRZtXfwB2huU2w/V/8sdF+vXH2UzWIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747350816; c=relaxed/simple;
	bh=rMGTe2f0xjfvVRMXuNW1byFydKvdBVL6wOaiad7a4jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3RpnOw6fMhUEEXjgEK8ELJ5Spq2A5d1hMrV0Hcn4ycFibIHnWNBwmqcfs7ztBWd36SVKaRYKBYTxEazqOFTB4IBQg5MIpMbBsoMR7uHBZ0jZFJdv8rKbbAS9n0dukdVfrRBvloLcf+OhI07oxEBVjlIjU/1O//I21zwBYAphZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1/VX6hA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so1112449a12.2;
        Thu, 15 May 2025 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747350813; x=1747955613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZLtSoPTWIDXtlzB5/eV7RAMuqxvAneOk4mPIHABE40=;
        b=h1/VX6hAvltAHSf0TqQeMK3+pJ41W1he583GUGEMqS1ldBRaoI4+1gMVlBQkOwbzNY
         LL2NUOPJYtGJgUPYktafQRwhTkJuv42tLrdBIzskBdZuxFJoL6TXlwZQyVYTArT/QbUE
         TPtXi6xlh1n8//n4Ruby+8/Obs75F5QjkrnENu6Z9spr4Lubhy0L4lTxc2KGDY4WMK2H
         H97i1XfoiWR8QgnQNHhMHTkD5Et9xmdapmG+u8ZnO0WXq3KYNSP1DkTSUszjBQ1+idVZ
         2cEgTapIgVczRJyKgZKmzRL3ka4gJjlUIM4zq/5vbQCMB9HTvUiM8KegFqwDbxTkAMsk
         qKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747350813; x=1747955613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZLtSoPTWIDXtlzB5/eV7RAMuqxvAneOk4mPIHABE40=;
        b=bj0HfCcMGtG7w+hwe19h3wBUcjvEcHqHUk+KrNEoc5GSvQ07vPnzj1aICfTYwDmFKt
         yiVeTXMGS8ogSvN5FFQd6VcqrBK4wyasHCHEBdu4H8ZgT+O1FWUGsniHCITzaSxALn+M
         WaXMi5kRMS10hKdkB0KLyhEylqjHxub3WZSh9zlWfnYZpjGO5qX4VwCYxfNiiAyL7pRd
         sb53U461E+A3R/Gh1sgl7kqo4leFJbREct3bob//YVe/DJ2cyFV36/kejsGVEeHwTQ2T
         oTxS3M1rL/DHwEICaZfNfySRkEGYSopfa6bUvbK82tJYNlfi4f28zRunC5eu6ib5FGfG
         x+rg==
X-Forwarded-Encrypted: i=1; AJvYcCUXIWwSn4AtegDXy3s+dRlhu+CWII7mOL7pwwYa8Z36dfwU0oSBsofXBIj+0nc/Yi3LAZB4qz8zb/VlklU=@vger.kernel.org, AJvYcCW+Xf0fHNIpwRVVjNQNPhUWczufdFnYBwjQ1lUGR+m0o0mstK/RDJsbVp++7Bch/vRmvtjh4+jo5/ID1Chk8Iz8@vger.kernel.org
X-Gm-Message-State: AOJu0YzED66OXzUlbHJfEe8wl3shNEjcWorBUvFj0LNsB8/M8t6lZg6C
	eEziTITaXCnYx2ZwkGvCzgwh/jxW8WoRRgFedAO28N0AVw5ORZqQhEavUktM
X-Gm-Gg: ASbGncsRG2VtRA+Fzp80d956UTVHuV2KsGRnbMu8X4YzW2Sq1Ck0IhhLBwIx7OXKGbO
	JF5aC8CCgZ3PZz9nZA46t3sCgu32F4Qs/pNNKgeKA1gO33JmRiOK+MyD5P3REyVC2egPGskL7ZX
	UvFPytNAYgV0Gz8+fpyfLy0ndvHKqj/WLqtmErD2kRKuLo5Ot3+cw/coNNigp1TAalQilovBZ8E
	2FGyrDaDdCauqjas+2dsW49Lg2ZEsOs9cFZhqzC5OYPiGooqKCMeVYVmB0oNRBQt10dL+9caH2j
	0YZKRmZSpC/73o182iVJLjuiTr1LofzIBPWNtukfh9Uy/ZkM8+XU3WSqhNsFTARQt6H6uGV3r+4
	zQETGpS2TtqBH
X-Google-Smtp-Source: AGHT+IEMWAyLw9og40QZUUd+RwjdVaZHBVBVptNM65YbRcHC1wud+bnH5LoJ2EJNeTB+z/GNtESxkA==
X-Received: by 2002:a17:903:2449:b0:223:619e:71da with SMTP id d9443c01a7336-231d455d993mr14362505ad.49.1747350813449;
        Thu, 15 May 2025 16:13:33 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e980c0sm2966485ad.126.2025.05.15.16.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 16:13:32 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiri@resnulli.us,
	shuah@kernel.org,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: validate team flags propagation
Date: Thu, 15 May 2025 16:13:32 -0700
Message-ID: <20250515231332.4120071-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover three recent cases:
1. missing ops locking for the lowers during netdev_sync_lower_features
2. missing locking for dev_set_promiscuity (plus netdev_ops_assert_locked
   with a comment on why/when it's needed)
3. rcu lock during team_change_rx_flags

Verified that each one triggers when the respective fix is reverted.
Not sure about the placement, but since it all relies on teaming,
added to the teaming directory.

One ugly bit is that I add NETIF_F_LRO to netdevsim; there is no way
to trigger netdev_sync_lower_features without it.

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/netdevsim/netdev.c                |  2 +
 net/core/dev.c                                | 10 ++-
 .../selftests/drivers/net/team/Makefile       |  2 +-
 .../testing/selftests/drivers/net/team/config |  1 +
 .../selftests/drivers/net/team/propagation.sh | 79 +++++++++++++++++++
 5 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/propagation.sh

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0e0321a7ddd7..3bd1f8cffee8 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -879,11 +879,13 @@ static void nsim_setup(struct net_device *dev)
 			 NETIF_F_SG |
 			 NETIF_F_FRAGLIST |
 			 NETIF_F_HW_CSUM |
+			 NETIF_F_LRO |
 			 NETIF_F_TSO;
 	dev->hw_features |= NETIF_F_HW_TC |
 			    NETIF_F_SG |
 			    NETIF_F_FRAGLIST |
 			    NETIF_F_HW_CSUM |
+			    NETIF_F_LRO |
 			    NETIF_F_TSO;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d891634c692..4debd4b8e0f5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9188,8 +9188,16 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 
 		dev_change_rx_flags(dev, IFF_PROMISC);
 	}
-	if (notify)
+	if (notify) {
+		/* The ops lock is only required to ensure consistent locking
+		 * for `NETDEV_CHANGE` notifiers. This function is sometimes
+		 * called without the lock, even for devices that are ops
+		 * locked, such as in `dev_uc_sync_multiple` when using
+		 * bonding or teaming.
+		 */
+		netdev_ops_assert_locked(dev);
 		__dev_notify_flags(dev, old_flags, IFF_PROMISC, 0, NULL);
+	}
 	return 0;
 }
 
diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 2d5a76d99181..eaf6938f100e 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for net selftests
 
-TEST_PROGS := dev_addr_lists.sh
+TEST_PROGS := dev_addr_lists.sh propagation.sh
 
 TEST_INCLUDES := \
 	../bonding/lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
index b5e3a3aad4bf..636b3525b679 100644
--- a/tools/testing/selftests/drivers/net/team/config
+++ b/tools/testing/selftests/drivers/net/team/config
@@ -1,5 +1,6 @@
 CONFIG_DUMMY=y
 CONFIG_IPV6=y
 CONFIG_MACVLAN=y
+CONFIG_NETDEVSIM=m
 CONFIG_NET_TEAM=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
diff --git a/tools/testing/selftests/drivers/net/team/propagation.sh b/tools/testing/selftests/drivers/net/team/propagation.sh
new file mode 100755
index 000000000000..849a5f2cb3a7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/propagation.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+NSIM_LRO_ID=$((256 + RANDOM % 256))
+NSIM_LRO_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_LRO_ID
+
+NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
+
+cleanup()
+{
+	ip link del dummyteam &>/dev/null
+	ip link del team0 &>/dev/null
+	echo $NSIM_LRO_ID > $NSIM_DEV_SYS_DEL
+}
+
+# Trigger LRO propagation to the lower.
+# https://lore.kernel.org/netdev/aBvOpkIoxcr9PfDg@mini-arch/
+team_lro()
+{
+	# using netdevsim because it supports NETIF_F_LRO
+	NSIM_LRO_NAME=$(find $NSIM_LRO_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_LRO_SYS/net -exec basename {} \;)
+
+	ip link add name team0 type team
+	ip link set $NSIM_LRO_NAME down
+	ip link set dev $NSIM_LRO_NAME master team0
+	ip link set team0 up
+	ethtool -K team0 large-receive-offload off
+
+	ip link del team0
+}
+
+# Trigger promisc propagation to the lower during IFLA_MASTER.
+# https://lore.kernel.org/netdev/20250506032328.3003050-1-sdf@fomichev.me/
+team_promisc()
+{
+	ip link add name dummyteam type dummy
+	ip link add name team0 type team
+	ip link set dummyteam down
+	ip link set team0 promisc on
+	ip link set dev dummyteam master team0
+	ip link set team0 up
+
+	ip link del team0
+	ip link del dummyteam
+}
+
+# Trigger promisc propagation to the lower via netif_change_flags (aka
+# ndo_change_rx_flags).
+# https://lore.kernel.org/netdev/20250514220319.3505158-1-stfomichev@gmail.com/
+team_change_flags()
+{
+	ip link add name dummyteam type dummy
+	ip link add name team0 type team
+	ip link set dummyteam down
+	ip link set dev dummyteam master team0
+	ip link set team0 up
+	ip link set team0 promisc on
+
+	# Make sure we can add more L2 addresses without any issues.
+	ip link add link team0 address 00:00:00:00:00:01 team0.1 type macvlan
+	ip link set team0.1 up
+
+	ip link del team0.1
+	ip link del team0
+	ip link del dummyteam
+}
+
+trap cleanup EXIT
+modprobe netdevsim || :
+echo $NSIM_LRO_ID > $NSIM_DEV_SYS_NEW
+udevadm settle
+team_lro
+team_promisc
+team_change_flags
+modprobe -r netdevsim || :
-- 
2.49.0


