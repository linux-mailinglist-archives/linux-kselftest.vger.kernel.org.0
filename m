Return-Path: <linux-kselftest+bounces-21557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882639BF9C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5301C2188A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622D20E03C;
	Wed,  6 Nov 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cL16yMcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpnuEVb7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5B20D505;
	Wed,  6 Nov 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934850; cv=none; b=fd+AntL76fncQo1hAbAfTWlt2vhTb19GpKJjVqmRgXDVfrJI6lOjNZpoZ1Z+fgWx6h0bA4IkTVtSsZiaDL8unFxJUBEkkeZhI4Cx5hweLbixR+ynQ0ADuUt2IqaSTcyGqeUU7lPgey9K+siZlwx+0jDWOY4HMjyhgRX7SCr7SlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934850; c=relaxed/simple;
	bh=TeFPeFLi5Tt/94eHktgSv/lbWA4rJzUnvvXruI8ePgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stOr7y895APDHBXcryk7hlh5n21YFPgtoxUwtx5q6/Lv9rqfSlb2JePAPkIllfKl0agsR2AfhBsNr7KDXNKBql6n68AZFy7r0gBw470/fZhb8iZ5i31iiio6Y5YnW7n5CWeCKLXtdbkDRqOQt/ygM1IHsbGVDZrSZPyVoY2xaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cL16yMcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DpnuEVb7; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 231491D402D4;
	Wed,  6 Nov 2024 18:14:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Nov 2024 18:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934847; x=
	1730938447; bh=1K1u5yZrgUawg3JHCN30kwMQUq4N6wCZA6xeGjQP1LI=; b=c
	L16yMcvD4aIIltzBS2/i0XGnQXqfEWv7TOmfU5T8/pcttuaa7mIOmTe491bUmtWq
	MBnEl3yP0HMoiYiV0aeB+92CHwwj0H064IXx56md/pRWU0f2D5ZRyQeuQn8w8Pu9
	bYd3j69ynfJ60Tv17hGsPU78aVGxeyQDbNqw5rCAF4+WjfBWGnkahx/dFxLfEtMw
	sQLbQzcH+j0/RGvPnlFoIoU5l5xUqIcy8B3cd1nkoqLdcfAeC0v9RLt537u//Wew
	NxD6Rbu09JrPNWRUD6Ps07e+PVtYEejQp8A/DO2crlfcPpqOsoJ20pRk3B2v7YKB
	qNEy87i+a12yGSCk7YAtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934847; x=1730938447; bh=1
	K1u5yZrgUawg3JHCN30kwMQUq4N6wCZA6xeGjQP1LI=; b=DpnuEVb7Uj8xKMy6I
	ZReiBojJYiuScGHLawgkSz8aPX5ymZ7doOZb9+2osVq7EWU3NAOr8Snh9y9474Bb
	vECJXETMdzicB1HHU9ktLCdT1nT/YN5FgKOXA7LNPXe+yoR8hD2d9CaQ6VzNE0Oy
	ueF5LeHEdwsk4CU2ADBBNa5PpisKUa9ntIqMzTgIYmHHTsVYWSOpKLZ7q3oigN/q
	1SLzBF7L0yj47exejNRaO60Ng1dBIlt0L+mRnQoRus4R153XIRO6Ptml7W5rqGe1
	sQeLGWaZuRRPCQm9yVkUYvd+ORh/wCY6eqSyYUX8s+Cj0HU0HB7DIANYB/1cwqc3
	4lFWQ==
X-ME-Sender: <xms:P_grZ75bQXzeRlLqFJ1PG65KM5isNgQJcMSYnhIQwBK41-7z5CGe9Q>
    <xme:P_grZw7gXj-HWSX4-KSj1EK4MRLEpC3NusjeogAgL_WrpEtv4iNMiZQvPosRlUBy1
    UTdPZsbZeCotaUiPDk>
X-ME-Received: <xmr:P_grZydS-uCgLDN36Yj-yVzD8wJq6A2pcufK4bH57vR3Is5URDqw_NeipMRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P_grZ8JwO4OzJ8VonfYVFnLrtL9zPTEQ_XSiZZv3KnBw1XfhlfxuJQ>
    <xmx:P_grZ_ISubJnX6N2gMXyOydWCN6vR1cJZlSHVe0f-Ivk2NjOhg9uNQ>
    <xmx:P_grZ1wZ0TNuT6bA4SsLpz910xmiftdqv4T6Ak8vX_sFMGuDD9Cd_g>
    <xmx:P_grZ7IFPoiskrPvnVgJd0B68DKE_6WbaEvQBKAhW_ryIPXN39LEAQ>
    <xmx:P_grZ2XMZMTxf5ms3_rVZ-9l5I_dwVlUvr8CC2-Q_bwldLEf2J8B-sAP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:14:07 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 6/8] selftests: move macsec offload tests from net/rtnetlink to drivers/net/netdvesim
Date: Thu,  7 Nov 2024 00:13:32 +0100
Message-ID: <a1f92c250cc129b4bb111a206c4b560bab4e24a5.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
References: <cover.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to expand this test, and macsec offload is only lightly
related to rtnetlink.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 .../selftests/drivers/net/netdevsim/Makefile  |  1 +
 .../selftests/drivers/net/netdevsim/config    |  1 +
 .../drivers/net/netdevsim/macsec-offload.sh   | 63 +++++++++++++++++
 tools/testing/selftests/net/rtnetlink.sh      | 68 -------------------
 4 files changed, 65 insertions(+), 68 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index df167c637af9..07b7c46d3311 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS = devlink.sh \
 	fib.sh \
 	fib_notifications.sh \
 	hw_stats_l3.sh \
+	macsec-offload.sh \
 	nexthop.sh \
 	peer.sh \
 	psample.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/config b/tools/testing/selftests/drivers/net/netdevsim/config
index adf45a3a78b4..5117c78ddf0a 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/config
+++ b/tools/testing/selftests/drivers/net/netdevsim/config
@@ -1,6 +1,7 @@
 CONFIG_DUMMY=y
 CONFIG_GENEVE=m
 CONFIG_IPV6=y
+CONFIG_MACSEC=m
 CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_MQPRIO=y
 CONFIG_NET_SCH_MULTIQ=y
diff --git a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
new file mode 100755
index 000000000000..7babcfd76b22
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source ethtool-common.sh
+
+NSIM_NETDEV=$(make_netdev)
+MACSEC_NETDEV=macsec_nsim
+
+set -o pipefail
+
+if ! ethtool -k $NSIM_NETDEV | grep -q 'macsec-hw-offload: on'; then
+    echo "SKIP: netdevsim doesn't support MACsec offload"
+    exit 4
+fi
+
+if ! ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec offload mac 2>/dev/null; then
+    echo "SKIP: couldn't create macsec device"
+    exit 4
+fi
+ip link del $MACSEC_NETDEV
+
+#
+# test macsec offload API
+#
+
+ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}" type macsec port 4 offload mac
+check $?
+
+ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}2" type macsec address "aa:bb:cc:dd:ee:ff" port 5 offload mac
+check $?
+
+ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}3" type macsec sci abbacdde01020304 offload mac
+check $?
+
+ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}4" type macsec port 8 offload mac 2> /dev/null
+check $? '' '' 1
+
+ip macsec add "${MACSEC_NETDEV}" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
+check $?
+
+ip macsec add "${MACSEC_NETDEV}" rx port 1234 address "1c:ed:de:ad:be:ef"
+check $?
+
+ip macsec add "${MACSEC_NETDEV}" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on \
+    key 00 0123456789abcdef0123456789abcdef
+check $?
+
+ip macsec add "${MACSEC_NETDEV}" rx port 1235 address "1c:ed:de:ad:be:ef" 2> /dev/null
+check $? '' '' 1
+
+for dev in ${MACSEC_NETDEV}{,2,3} ; do
+    ip link del $dev
+    check $?
+done
+
+
+if [ $num_errors -eq 0 ]; then
+    echo "PASSED all $((num_passes)) checks"
+    exit 0
+else
+    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
+    exit 1
+fi
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 87dce3efe31e..d28b7e0ca205 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -21,7 +21,6 @@ ALL_TESTS="
 	kci_test_vrf
 	kci_test_encap
 	kci_test_macsec
-	kci_test_macsec_offload
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -559,73 +558,6 @@ kci_test_macsec()
 	end_test "PASS: macsec"
 }
 
-kci_test_macsec_offload()
-{
-	sysfsd=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/
-	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
-	probed=false
-	local ret=0
-	run_cmd_grep "^Usage: ip macsec" ip macsec help
-	if [ $? -ne 0 ]; then
-		end_test "SKIP: macsec: iproute2 too old"
-		return $ksft_skip
-	fi
-
-	if ! mount | grep -q debugfs; then
-		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
-	fi
-
-	# setup netdevsim since dummydev doesn't have offload support
-	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
-		run_cmd modprobe -q netdevsim
-
-		if [ $ret -ne 0 ]; then
-			end_test "SKIP: macsec_offload can't load netdevsim"
-			return $ksft_skip
-		fi
-		probed=true
-	fi
-
-	echo "0" > /sys/bus/netdevsim/new_device
-	while [ ! -d $sysfsnet ] ; do :; done
-	udevadm settle
-	dev=`ls $sysfsnet`
-
-	ip link set $dev up
-	if [ ! -d $sysfsd ] ; then
-		end_test "FAIL: macsec_offload can't create device $dev"
-		return 1
-	fi
-	run_cmd_grep 'macsec-hw-offload: on' ethtool -k $dev
-	if [ $? -eq 1 ] ; then
-		end_test "FAIL: macsec_offload netdevsim doesn't support MACsec offload"
-		return 1
-	fi
-	run_cmd ip link add link $dev kci_macsec1 type macsec port 4 offload mac
-	run_cmd ip link add link $dev kci_macsec2 type macsec address "aa:bb:cc:dd:ee:ff" port 5 offload mac
-	run_cmd ip link add link $dev kci_macsec3 type macsec sci abbacdde01020304 offload mac
-	run_cmd_fail ip link add link $dev kci_macsec4 type macsec port 8 offload mac
-
-	msname=kci_macsec1
-	run_cmd ip macsec add "$msname" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
-	run_cmd ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
-	run_cmd ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on \
-		key 00 0123456789abcdef0123456789abcdef
-	run_cmd_fail ip macsec add "$msname" rx port 1235 address "1c:ed:de:ad:be:ef"
-	# clean up any leftovers
-	for msdev in kci_macsec{1,2,3,4} ; do
-	    ip link del $msdev 2> /dev/null
-	done
-	echo 0 > /sys/bus/netdevsim/del_device
-	$probed && rmmod netdevsim
-
-	if [ $ret -ne 0 ]; then
-		end_test "FAIL: macsec_offload"
-		return 1
-	fi
-	end_test "PASS: macsec_offload"
-}
-
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.47.0


