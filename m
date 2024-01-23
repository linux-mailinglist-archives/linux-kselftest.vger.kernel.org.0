Return-Path: <linux-kselftest+bounces-3387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFAB838711
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB4D1C22F3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 06:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94645009;
	Tue, 23 Jan 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae5730Jr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B773FB0F;
	Tue, 23 Jan 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705989939; cv=none; b=bljRgiu5bEFiAYFzqohPW68rvEYhtidkcAZegNEt+UbJo/+A07y3vyT8f5j89qv9bG3LhO41upDShE+vFSB9P2gJMDHy4JvgiThgEIpl60VvXftLRu+LQsypXxkx+ozBso8uFiCGYq/UDIhJjJ3RlGvrHGhse0wzxj1pl35MR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705989939; c=relaxed/simple;
	bh=+sdw0hQDgpmOLRPB+xoe+83u7va8ZAEDwpSm9bv1KYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyOys41X1QAy6pNanfuEqh3BHkih7aHQBuhijsV5h4jYgvgRuZ3Y2aks8v8efmlE4abRLyeAa33VzAxhrNdjnd4dnFVt5NG3ZFaagPoW16EqTASJJIRlWJExpfwZap9VqLCuabq+Z4dhHmgUNk0G9A0ily2heWIIUzx5NCo+a5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae5730Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD59C433C7;
	Tue, 23 Jan 2024 06:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705989938;
	bh=+sdw0hQDgpmOLRPB+xoe+83u7va8ZAEDwpSm9bv1KYY=;
	h=From:To:Cc:Subject:Date:From;
	b=ae5730JreJ+lZAgla1kVVMvrTZFqwkhMrzqpLeHcNbtf8jf1BBpXX9/rwOwF61rL1
	 5sUgmxtIw3qvKcVMZPuO5+U8BnaomDFuh+aAVzobh6powFpy3dJV8cWMl4fQbTT4/u
	 +ABPIf/Od9Bj0isFuVrFGuxR1o6xQfdalQ88MXSKD9AzGkMfn9SlUCpjKExpx+Lobm
	 UZXViz0GfwZgC1zIXWkTcTPTSCJQD2vz7AyEho2Chy3XjbpnIFJ+5bVAW4qEmOcdY+
	 DAObi3rfZsK06Uj5F0j1rli+ryA41Dg3nxh+JPOiUmUF2rtWQarrlSHoqs6F3bgGYn
	 yOrc0dl9sQlgg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: netdevsim: fix the udp_tunnel_nic test
Date: Mon, 22 Jan 2024 22:05:29 -0800
Message-ID: <20240123060529.1033912-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is missing a whole bunch of checks for interface
renaming and one ifup. Presumably it was only used on a system
with renaming disabled and NetworkManager running.

Fixes: 91f430b2c49d ("selftests: net: add a test for UDP tunnel info infra")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: horms@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/netdevsim/udp_tunnel_nic.sh    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 4855ef597a15..f98435c502f6 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -270,6 +270,7 @@ for port in 0 1; do
 	echo 1 > $NSIM_DEV_SYS/new_port
     fi
     NSIM_NETDEV=`get_netdev_name old_netdevs`
+    ifconfig $NSIM_NETDEV up
 
     msg="new NIC device created"
     exp0=( 0 0 0 0 )
@@ -431,6 +432,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -488,6 +490,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -544,6 +547,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "destroy NIC"
@@ -573,6 +577,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -633,6 +638,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
@@ -688,6 +694,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -747,6 +754,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -877,6 +885,7 @@ msg="re-add a port"
 
 echo 2 > $NSIM_DEV_SYS/del_port
 echo 2 > $NSIM_DEV_SYS/new_port
+NSIM_NETDEV=`get_netdev_name old_netdevs`
 check_tables
 
 msg="replace VxLAN in overflow table"
-- 
2.43.0


