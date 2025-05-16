Return-Path: <linux-kselftest+bounces-33233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790AABA688
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5742A25044
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 23:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD48280320;
	Fri, 16 May 2025 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEHv7Z1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BF27FD71;
	Fri, 16 May 2025 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437729; cv=none; b=WvRa29D/uCJzKRRpNu4QZXxRIcJeQml/kP2SpDe68BrgY+uC/mmM7aBleQ/RvdOJLrm39ZemA+RKjgMDSfkarEiT+zpklxhQ05bs4gggAuJnOPRhSmZH+jXORk4ROG5k5j7EyiYPmSZvwOfp95Abvh8+qZygVTmfZeAQxCzTqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437729; c=relaxed/simple;
	bh=omyiBN9CVpzxRF+YaRFnHa1UxZdu58NwQocHXX6hruQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsfN4B10fnyN5ugBVF1d0h4jywQpgtOmktyYe10FHFrR+j0TeHfQbVj7GpWXCa0KLtWdqYg9As+wgacHKSTN9Vi1IqxuJPOxDB7pmZul4h/SsN//BuV8a6wTejNm+tXBEMXSNGzVzjm0X1/vzgsp30QW/1xePdMa/MfQ1jOvJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEHv7Z1P; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso2824717b3a.2;
        Fri, 16 May 2025 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747437726; x=1748042526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RBRW+BDhhR5QWYvsH1webo+qjc0apKgnSK3fhSjcVE=;
        b=OEHv7Z1PVKqY2N2BvVABjlKKGPnmtN8E7GuKG+3HlhQQsTIVDpANWsPk8H/5/b0EDv
         NZiejrgD13NRQZjS1d31LRn9Bf4RC62aGPk+4O8hVODtqM9ZWGkZUMidPZ6d45fkzOe/
         5yqJDNMyy6i4JdGYEQCnEPscMNXOw3f+jrDrp+Hng3x/YXw0g2ILEpdCNwxKvUgX47NS
         DjvNq9zTBDwuEkIJpLPVEzuGIWd10rbV5Uh4X2094YT2M+XTuaIfVHOlBIEEI4IgWQmy
         /9oX+7bBkXOEMimh2dMXamsSKUMrozaap78cwC8bc5YTUw9+lDclhOMFFj8jXLaX1RHx
         Yd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747437726; x=1748042526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RBRW+BDhhR5QWYvsH1webo+qjc0apKgnSK3fhSjcVE=;
        b=fqvwOYT/r6RSCsOpyGxiJWUOHhXDn6lBdYio9WiUbMb5f9nMMBJzOkd7FKqpulmZ+L
         bFYp4E0G2kwF6FV6Tdt2YOChOYSg9wrwpm62IIQKhmLUELjLPmgMC1p4tUzGoGcWJuyX
         x1OqiqZfwHXV8j1cRPtzNolagCsRSus5eWkCPRR9EtjVQE3cihPgqXxSIsrvgHgd+ges
         WpqIsBTbj6MgcMjvjYLeq3QP2cKmq3ay5AZqOuHvOXWhy25T4VFUyTlETfG3TJUPOukb
         B/GR2E7eQUoQn8H2thjbCIPIMG9sqco86L7fxgM7cB74NT1iJPS4fAYyXbyoj4Pj88/D
         gI+A==
X-Forwarded-Encrypted: i=1; AJvYcCUfxEKa4kI/jL+rlra2V23blWEVKZpDbmCDCzniRtulIxlpo0R5fJYJl2NzMAFzr3QkMYpSw5f2HRm7+kILAZle@vger.kernel.org, AJvYcCXooH2JP/J61XTONnyx4n5mKIcNJBuLW59C2ZRdhHppk1FkFddsgA/fr1uxQ5cLTyFRLzct2K3ECXvBtn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5L7pwd3Ffq4PpmKlUlBavWplgdW1FLpX4/lRaNM8tM4ZHRcK
	BnWZDR+WhiCdyuZH6MwCVfGSfFgiijn5PYHAmNA9oq5CJ8FSxk44SYWl8jp/hQU=
X-Gm-Gg: ASbGncvaQtFhIgSR1RKJBfntmqfyNpIe+2SgTmed0GH1uXpjZT3pBspC5R9vlatKJPo
	6fly2KFA4kFLkHFZQNLx2MgDquV0Ulne6f1fwzthMYjYRR/N3Kz+h53G6jR0d73xxdN9/kWIuDr
	gMM6mbQPjBh6RoFhTXHdoASeBDyvt09gvdHuruEIzppeaI3MGXra5D1849BIyNWwU665o6w3Lm1
	pW0UhwrDMuBbY1EzZgPvK0zVQDSjqz1Ah0Wrf1aXOHMfYtOPQSdifbB9lAnmEamrqzgUFqdvw13
	xGounyL50+OYw0KtM2c5rGb6doLxWSW7axaTUnaToD8k4ek85veELlhEjs1PCRYPjHeFsyyh37A
	Mw35agdA8jKHY9fm6ivfOqks=
X-Google-Smtp-Source: AGHT+IHO//0EqEc7AdSy3HOjDEMiPF4k0UYR10/bdF7j6q/cjrIDSgjLD6NXd4/l6YDSJO91wQyowQ==
X-Received: by 2002:a05:6a21:710a:b0:201:8a13:f392 with SMTP id adf61e73a8af0-2170ccb38e2mr6079231637.20.1747437726407;
        Fri, 16 May 2025 16:22:06 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eaf6dc3csm2097088a12.24.2025.05.16.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 16:22:05 -0700 (PDT)
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
Subject: [PATCH net v2] selftests: net: validate team flags propagation
Date: Fri, 16 May 2025 16:22:05 -0700
Message-ID: <20250516232205.539266-1-stfomichev@gmail.com>
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
v2: fix cleanup and wrong exit code (Jakub)
---
 drivers/net/netdevsim/netdev.c                |  2 +
 net/core/dev.c                                | 10 ++-
 .../selftests/drivers/net/team/Makefile       |  2 +-
 .../testing/selftests/drivers/net/team/config |  1 +
 .../selftests/drivers/net/team/propagation.sh | 80 +++++++++++++++++++
 5 files changed, 93 insertions(+), 2 deletions(-)
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
index 000000000000..4bea75b79878
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/propagation.sh
@@ -0,0 +1,80 @@
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
+	set +e
+	ip link del dummyteam &>/dev/null
+	ip link del team0 &>/dev/null
+	echo $NSIM_LRO_ID > $NSIM_DEV_SYS_DEL
+	modprobe -r netdevsim
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
-- 
2.49.0


