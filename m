Return-Path: <linux-kselftest+bounces-36277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B9AF0E01
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07518487C9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9923BCF7;
	Wed,  2 Jul 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LNodZ4nY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89799238C16;
	Wed,  2 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444906; cv=none; b=Vn26NhkSxOEoJv9QL1Xu+lchCF++Y+VrvQk3HXOjWBtvjnztElhznQYRWBnqTCsonV2u2+JV4VfOtxqCvUpfsOpFUBS0Rmxi5PGu/ERhM+nb6kHtzXQgPGf0f+4hrn4D4PnjOot7wHohJQgcQhnThcikaKUgktIfSE0f8JvXPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444906; c=relaxed/simple;
	bh=qHk9m++LBoQx3yiAbc9n1ih8ke/7OTNO0TG9b0fRLmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAXsEaF+gz1Z2mmNW0zA4FDNh/szBqpBtIlTyyhXU4f6kkBf2nuGqnxdQNJ9ui+npLkUkuv6e7APsXTIz0LmhMcM3SFqoUqZ6vc1AkgrvxVG/rR4IZ5komPHOhMn1DX8EIiwXVNAUQ2ylSWfqsavttDqtr5nzImAE3RmLB6dIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LNodZ4nY; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE9A443184;
	Wed,  2 Jul 2025 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751444895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tj6eZS5+WFS158/nz+Vj1Mv/y1Y7UeIf31eukYPIixI=;
	b=LNodZ4nYYCUz4vO99K3G5/Cmr5ybFCmpiOy0Jc23cyvaeK9ygWD1kTx30M+LZ5M0m4lx0x
	lNoTTvr8Q/4TXRSgFhDen7kfv4xJJnSaiuL11bvIVL54Lzwaje3lT4Pkt8rNBiFhYn+GYk
	nWLR+ngRCeuz19zN/P+YcnvAbn5v8U89ZUjcoxU8UiFaxjDp4mDli1n/OQruLgglV91jyA
	xMxrcWHC9ovBMVjzx7n/wNTkMi5ik1phKh4Kd109SCLEUqNPtDzHpUT086/iyqbPlOZFBx
	x6YLiDnhlA6YNs95nUd7sPdIqusr+LkYmxlS3l0Xaj0R9sF7hsc1JY74tBMgIw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: ethtool: Introduce ethernet PHY selftests on netdevsim
Date: Wed,  2 Jul 2025 10:28:05 +0200
Message-ID: <20250702082806.706973-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh

Now that netdevsim supports PHY device simulation, we can start writing
some tests to cover a little bit all PHY-related ethtool commands.

So far we only test the basic use of "ethtool --show-phys", with :
 - A simple command to get a PHY we just added
 - A DUMP command listing PHYs on multiple netdevsim instances
 - A Filtered DUMP command listing all PHYs on a netdevsim

Introduce some helpers to create netdevsim PHYs, and a new test file.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../selftests/drivers/net/netdevsim/config    |  1 +
 .../drivers/net/netdevsim/ethtool-common.sh   | 15 +++++
 .../drivers/net/netdevsim/ethtool-phy.sh      | 64 +++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/config b/tools/testing/selftests/drivers/net/netdevsim/config
index 5117c78ddf0a..223e82cb7759 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/config
+++ b/tools/testing/selftests/drivers/net/netdevsim/config
@@ -6,6 +6,7 @@ CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_MQPRIO=y
 CONFIG_NET_SCH_MULTIQ=y
 CONFIG_NET_SCH_PRIO=y
+CONFIG_PHYLIB=m
 CONFIG_PSAMPLE=y
 CONFIG_PTP_1588_CLOCK_MOCK=y
 CONFIG_VXLAN=m
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
index d9c7a3d397a9..1bd0ac5e7bba 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
@@ -53,3 +53,18 @@ function make_netdev {
     # get new device name
     ls /sys/bus/netdevsim/devices/netdevsim${NSIM_ID}/net/
 }
+
+function make_phydev_on_netdev {
+    local parent_ndev_nsim_id=$1
+    local parent=$2
+
+    local ndev_dfs=/sys/kernel/debug/netdevsim/netdevsim$parent_ndev_nsim_id/ports/0
+
+    old_dev_dfs=$(find $ndev_dfs -type d)
+    echo $parent > $ndev_dfs/phy_add
+    new_dev_dfs=$(find $ndev_dfs -type d)
+
+    # The new phydev name corresponds to the new file that was created. Its
+    # name isn't predictable.
+    echo $old_dev_dfs $new_dev_dfs | xargs -n1 | sort  | uniq -u
+}
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh
new file mode 100755
index 000000000000..7b740a3fda1d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source ethtool-common.sh
+
+# Bail if ethtool is too old
+if ! ethtool -h | grep show-phys 2>&1 >/dev/null; then
+    echo "SKIP: No --show-phys support in ethtool"
+    exit 4
+fi
+
+function make_netdev_from_id {
+    local new_nsim_id="$1"
+    # Make a netdevsim
+    echo $new_nsim_id > /sys/bus/netdevsim/new_device
+    udevadm settle
+    # get new device name
+    ls /sys/bus/netdevsim/devices/netdevsim${new_nsim_id}/net/
+}
+
+function cleanup_netdev_from_id {
+    local to_del_nsim_id="$1"
+    echo $to_del_nsim_id > /sys/bus/netdevsim/del_device
+}
+
+NSIM_NETDEV=$(make_netdev)
+
+set -o pipefail
+
+# Check simple PHY addition and listing
+
+# Parent == 0 means that the PHY's parent is the netdev
+PHY_DFS=$(make_phydev_on_netdev $NSIM_ID 0)
+
+# First PHY gets index 1
+index=$(ethtool --show-phys $NSIM_NETDEV | grep "PHY index" | cut -d ' ' -f 3)
+check $? "$index" "1"
+
+# Insert a second PHY, same parent. It gets index 2.
+PHY2_DFS=$(make_phydev_on_netdev $NSIM_ID 0)
+
+# Create another netdev
+NSIM_ID2=$((RANDOM % 1024))
+NSIM_NETDEV_2=$(make_netdev_from_id "$NSIM_ID2")
+
+PHY3_DFS=$(make_phydev_on_netdev $NSIM_ID2 0);
+
+# Check unfiltered PHY Dump
+n_phy=$(ethtool --show-phys '*' | grep "PHY index" | wc -l)
+check $? "$n_phy" "3"
+
+# Check filtered Dump
+n_phy=$(ethtool --show-phys $NSIM_NETDEV | grep "PHY index" | wc -l)
+check $? "$n_phy" "2"
+
+cleanup_netdev_from_id $NSIM_ID2
+
+if [ $num_errors -eq 0 ]; then
+    echo "PASSED all $((num_passes)) checks"
+    exit 0
+else
+    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
+    exit 1
+fi
-- 
2.49.0


