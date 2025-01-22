Return-Path: <linux-kselftest+bounces-24974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B425CA19B0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 23:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9022B188D286
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322C1CB332;
	Wed, 22 Jan 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwuWDTR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44A1CAA97;
	Wed, 22 Jan 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585905; cv=none; b=FnyPSyWca42E8QWwU5OBOQGk7i7QVNAd0sES7PTbBusy3TsxoCiIf3m62nPbqSGAmWJEydaXqXbkg/ssyy3hzs7NzGgkq6rj1ijPraAODnBZiJ8TECcjezKKrHAm87EGXWW+EGShcJPQAcCh9I0dCZoNfR4YGaOWWlJpP1e0v7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585905; c=relaxed/simple;
	bh=7c6cXhCmpp9gWaPJR1+MwcOY6hlnrr321kgjCgKyzag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vjs+w+HrEVH4K7xSi7wUOtkeoHhtkN5MsTqIig3X2LUIfNw8VxHi9BxASj4bs3my5jTdXXR+5KvYlzJM2JDw1zxk8hChi4prYdl63cj9wkHgevwrEZKRMV3LPqI0iVv59vCpwoMu0ovtW/G/OTJBfAAeugkPzHw33zU3CP5ItlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwuWDTR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E6C4CEE0;
	Wed, 22 Jan 2025 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737585905;
	bh=7c6cXhCmpp9gWaPJR1+MwcOY6hlnrr321kgjCgKyzag=;
	h=From:To:Cc:Subject:Date:From;
	b=kwuWDTR7VtCf8F+Jq63ha95IHrfWOt+C6+sMaLNtYYvPt9NAfsd7jYtPEWxZ1TDZ2
	 /8Iqw9ry7ALCDmNKWevVACmYmYIf/DLSRFfMlmh6FbLUxkDB4LeI5JRetsKcZkpMu9
	 N9BeAW1FPHepRY8faY1Nav9D1ENmaTiFIPX8sq98TAFGq5U+bMJfNbeftReMk0f/73
	 Dm9XDNDFHcrwUJULr9G47LrkdgkCJlSdInrHHf6Ab59tMlTQ+c7bIN1XNNhWjUjEje
	 qFm5so9AYFlPvnPFs/AWpAXBNUvSTNihYLlC0I9gcpFdzHTBP1XZKiVrPVEBCrmidE
	 L1lResQDwu40g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] net: netdevsim: try to close UDP port harness races
Date: Wed, 22 Jan 2025 14:45:03 -0800
Message-ID: <20250122224503.762705-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot discovered that we remove the debugfs files after we free
the netdev. Try to clean up the relevant dir while the device
is still around.

Reported-by: syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com
Fixes: 424be63ad831 ("netdevsim: add UDP tunnel port offload support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 drivers/net/netdevsim/netdevsim.h             |  1 +
 drivers/net/netdevsim/udp_tunnels.c           | 23 +++++++++++--------
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 16 ++++++-------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index dcf073bc4802..96d54c08043d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -134,6 +134,7 @@ struct netdevsim {
 		u32 sleep;
 		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
 		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
+		struct dentry *ddir;
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 02dc3123eb6c..640b4983a9a0 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -112,9 +112,11 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
 	struct net_device *dev = file->private_data;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
 	rtnl_lock();
-	udp_tunnel_nic_reset_ntf(dev);
+	if (dev->reg_state == NETREG_REGISTERED) {
+		memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
+		udp_tunnel_nic_reset_ntf(dev);
+	}
 	rtnl_unlock();
 
 	return count;
@@ -144,23 +146,23 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 	else
 		ns->udp_ports.ports = nsim_dev->udp_ports.__ports;
 
-	debugfs_create_u32("udp_ports_inject_error", 0600,
-			   ns->nsim_dev_port->ddir,
+	ns->udp_ports.ddir = debugfs_create_dir("udp_ports",
+						ns->nsim_dev_port->ddir);
+
+	debugfs_create_u32("inject_error", 0600, ns->udp_ports.ddir,
 			   &ns->udp_ports.inject_error);
 
 	ns->udp_ports.dfs_ports[0].array = ns->udp_ports.ports[0];
 	ns->udp_ports.dfs_ports[0].n_elements = NSIM_UDP_TUNNEL_N_PORTS;
-	debugfs_create_u32_array("udp_ports_table0", 0400,
-				 ns->nsim_dev_port->ddir,
+	debugfs_create_u32_array("table0", 0400, ns->udp_ports.ddir,
 				 &ns->udp_ports.dfs_ports[0]);
 
 	ns->udp_ports.dfs_ports[1].array = ns->udp_ports.ports[1];
 	ns->udp_ports.dfs_ports[1].n_elements = NSIM_UDP_TUNNEL_N_PORTS;
-	debugfs_create_u32_array("udp_ports_table1", 0400,
-				 ns->nsim_dev_port->ddir,
+	debugfs_create_u32_array("table1", 0400, ns->udp_ports.ddir,
 				 &ns->udp_ports.dfs_ports[1]);
 
-	debugfs_create_file("udp_ports_reset", 0200, ns->nsim_dev_port->ddir,
+	debugfs_create_file("reset", 0200, ns->udp_ports.ddir,
 			    dev, &nsim_udp_tunnels_info_reset_fops);
 
 	/* Note: it's not normal to allocate the info struct like this!
@@ -196,6 +198,9 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 
 void nsim_udp_tunnels_info_destroy(struct net_device *dev)
 {
+	struct netdevsim *ns = netdev_priv(dev);
+
+	debugfs_remove_recursive(ns->udp_ports.ddir);
 	kfree(dev->udp_tunnel_nic_info);
 	dev->udp_tunnel_nic_info = NULL;
 }
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 384cfa3d38a6..92c2f0376c08 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -142,7 +142,7 @@ function pre_ethtool {
 }
 
 function check_table {
-    local path=$NSIM_DEV_DFS/ports/$port/udp_ports_table$1
+    local path=$NSIM_DEV_DFS/ports/$port/udp_ports/table$1
     local -n expected=$2
     local last=$3
 
@@ -212,7 +212,7 @@ function check_tables {
 }
 
 function print_table {
-    local path=$NSIM_DEV_DFS/ports/$port/udp_ports_table$1
+    local path=$NSIM_DEV_DFS/ports/$port/udp_ports/table$1
     read -a have < $path
 
     tree $NSIM_DEV_DFS/
@@ -641,7 +641,7 @@ for port in 0 1; do
     NSIM_NETDEV=`get_netdev_name old_netdevs`
     ip link set dev $NSIM_NETDEV up
 
-    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
+    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
 
     msg="1 - create VxLANs v6"
     exp0=( 0 0 0 0 )
@@ -663,7 +663,7 @@ for port in 0 1; do
     new_geneve gnv0 20000
 
     msg="2 - destroy GENEVE"
-    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
+    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
     exp1=( `mke 20000 2` 0 0 0 )
     del_dev gnv0
 
@@ -764,7 +764,7 @@ for port in 0 1; do
     msg="create VxLANs v4"
     new_vxlan vxlan0 10000 $NSIM_NETDEV
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="NIC device goes down"
@@ -775,7 +775,7 @@ for port in 0 1; do
     fi
     check_tables
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="NIC device goes up again"
@@ -789,7 +789,7 @@ for port in 0 1; do
     del_dev vxlan0
     check_tables
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="destroy NIC"
@@ -896,7 +896,7 @@ msg="vacate VxLAN in overflow table"
 exp0=( `mke 10000 1` `mke 10004 1` 0 `mke 10003 1` )
 del_dev vxlan2
 
-echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
 check_tables
 
 msg="tunnels destroyed 2"
-- 
2.48.1


