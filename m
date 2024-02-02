Return-Path: <linux-kselftest+bounces-3962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3C8464ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 01:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D13F1C23F5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A81382;
	Fri,  2 Feb 2024 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5ic5DpY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E811110B;
	Fri,  2 Feb 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832720; cv=none; b=IuY4kYXJYjCTaQF166uqNLLoaGhkK0l+5wJ2ZUuHilU/7gq/4xzFBeKaKXbgc8A3l+qhFmD5CNEIisxO4tMmTuP5KuikxW2nRP5jq5O8Nqh0now1ik2VTtVp2zKvluYVycM9gsfIdUMQeLU1a+f25SMk5tfNDebxZYs4vnxy7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832720; c=relaxed/simple;
	bh=liSPO8tflE3qr1uximZeCncYsczutRNkJJKNFWF0+zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlNpjjWUsKC2U0CAeaL+XHYed45VT77D2C3fd4/iCeI/XAP87pSZrnd8hB45pRhYgZmvjoknU+Nc5DZcM4+ISc1zNlxp/qWHIGQBO1limFdLqEpaPDsTnYz+Aza+DP65ovCGOHM7zpr2q7jzcuQkmaeuMCcH268XZGdZggR+ZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5ic5DpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2194C433F1;
	Fri,  2 Feb 2024 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706832719;
	bh=liSPO8tflE3qr1uximZeCncYsczutRNkJJKNFWF0+zs=;
	h=From:To:Cc:Subject:Date:From;
	b=N5ic5DpYYSas+3qCk0tYHCRjQpGcqrJ2c14dZhdH1CUn3dW74bPyS4r4v59spNMgl
	 e/+gOBx8mqFXuzUxZTbOq61CK03AMHQAE4ccEwQikmFVbE+oWV/8BqjC9NQn/Te06d
	 U5gTjfAuxCEOGzwkHH0vSm8WZAPxargk79K4nlodyrl0XzXFtTGfytSLz8/K956Y2B
	 mZsGn92mhNL3FEu8cR57w4bdy4Ae3REyDNYOtGjk97Ari+I86Tb98xNbhNIr434MKi
	 08OWUWBNlZNxzOdD7nvXNcjT33V4DOxCXWLaPtohdotfKLn5fZVOFxzVeJSiwYGfA4
	 qWEbydyePu/OQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: netdevsim: stop using ifconfig
Date: Thu,  1 Feb 2024 16:11:54 -0800
Message-ID: <20240202001154.414386-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo points out that ifconfig is legacy and we should not use it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: horms@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index f98435c502f6..384cfa3d38a6 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -270,7 +270,7 @@ for port in 0 1; do
 	echo 1 > $NSIM_DEV_SYS/new_port
     fi
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     msg="new NIC device created"
     exp0=( 0 0 0 0 )
@@ -284,8 +284,8 @@ for port in 0 1; do
 
     msg="VxLAN v4 devices go down"
     exp0=( 0 0 0 0 )
-    ifconfig vxlan1 down
-    ifconfig vxlan0 down
+    ip link set dev vxlan1 down
+    ip link set dev vxlan0 down
     check_tables
 
     msg="VxLAN v6 devices"
@@ -293,7 +293,7 @@ for port in 0 1; do
     new_vxlan vxlanA 4789 $NSIM_NETDEV 6
 
     for ifc in vxlan0 vxlan1; do
-	ifconfig $ifc up
+	ip link set dev $ifc up
     done
 
     new_vxlan vxlanB 4789 $NSIM_NETDEV 6
@@ -307,14 +307,14 @@ for port in 0 1; do
     new_geneve gnv0 6081
 
     msg="NIC device goes down"
-    ifconfig $NSIM_NETDEV down
+    ip link set dev $NSIM_NETDEV down
     if [ $port -eq 1 ]; then
 	exp0=( 0 0 0 0 )
 	exp1=( 0 0 0 0 )
     fi
     check_tables
     msg="NIC device goes up again"
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
     exp0=( `mke 4789 1` `mke 4790 1` 0 0 )
     exp1=( `mke 6081 2` 0 0 0 )
     check_tables
@@ -433,7 +433,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
     overflow_table1 "overflow NIC table"
@@ -491,7 +491,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
     overflow_table1 "overflow NIC table"
@@ -548,7 +548,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     overflow_table0 "destroy NIC"
     overflow_table1 "destroy NIC"
@@ -578,7 +578,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     msg="create VxLANs v6"
     new_vxlan vxlanA0 10000 $NSIM_NETDEV 6
@@ -639,7 +639,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
 
@@ -695,7 +695,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     msg="create VxLANs v6"
     exp0=( `mke 10000 1` 0 0 0 )
@@ -755,7 +755,7 @@ for port in 0 1; do
 
     echo $port > $NSIM_DEV_SYS/new_port
     NSIM_NETDEV=`get_netdev_name old_netdevs`
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
 
     msg="create VxLANs v6"
     exp0=( `mke 10000 1` 0 0 0 )
@@ -768,7 +768,7 @@ for port in 0 1; do
     check_tables
 
     msg="NIC device goes down"
-    ifconfig $NSIM_NETDEV down
+    ip link set dev $NSIM_NETDEV down
     if [ $port -eq 1 ]; then
 	exp0=( 0 0 0 0 )
 	exp1=( 0 0 0 0 )
@@ -779,7 +779,7 @@ for port in 0 1; do
     check_tables
 
     msg="NIC device goes up again"
-    ifconfig $NSIM_NETDEV up
+    ip link set dev $NSIM_NETDEV up
     exp0=( `mke 10000 1` 0 0 0 )
     check_tables
 
@@ -827,12 +827,12 @@ new_vxlan vxlan1 4789 $NSIM_NETDEV2
 
 msg="VxLAN v4 devices go down"
 exp0=( 0 0 0 0 )
-ifconfig vxlan1 down
-ifconfig vxlan0 down
+ip link set dev vxlan1 down
+ip link set dev vxlan0 down
 check_tables
 
 for ifc in vxlan0 vxlan1; do
-    ifconfig $ifc up
+    ip link set dev $ifc up
 done
 
 msg="VxLAN v6 device"
@@ -844,11 +844,11 @@ exp1=( `mke 6081 2` 0 0 0 )
 new_geneve gnv0 6081
 
 msg="NIC device goes down"
-ifconfig $NSIM_NETDEV down
+ip link set dev $NSIM_NETDEV down
 check_tables
 
 msg="NIC device goes up again"
-ifconfig $NSIM_NETDEV up
+ip link set dev $NSIM_NETDEV up
 check_tables
 
 for i in `seq 2`; do
-- 
2.43.0


