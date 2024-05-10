Return-Path: <linux-kselftest+bounces-10018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56498C2700
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84E61C214E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797A170891;
	Fri, 10 May 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZYCSRI7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF412C526;
	Fri, 10 May 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351856; cv=none; b=MUzpAFqgd+R7Msxwr+wW2thWyF47Fg6F61Hb+pNZbVctxG7Vt54t47vwbbv1DSZ/GA63ghQfclGOMEdXESTYlcitgcr9J3KOIn5qrm3EyS3PFuHsqNdv6swn6q0AgBug9MT6SY0v9S8S+00QVPH7qgBH6D4tWTOluAdwSG6XRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351856; c=relaxed/simple;
	bh=Rs8unjHuGUxifVY/9+LC+KIT6hLlUWyGTvZnyD5tKSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioGODtkzXU5uiO9h5ZkU8Nx66tIUQQivomZ0aC2dszG/XYW2laIUhFSJl3HdMdiWbWihR3ehC7J64DsjbECaX8pnuyCCw2U2n1qiz6yVr7OWbFyNZYDiFyKBTAYsIkOGQgulnGvcvc8oy4dFbNjOsbX79Vln4m5PYRl7JKe2tbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZYCSRI7v; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 36EF688122;
	Fri, 10 May 2024 16:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715351846;
	bh=jOpOKeXB26MZGG5tc6iWhny1B4Ybi73lxsddx0Swstw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZYCSRI7vYaB9EJXXMJidQqjnmSwNoVkIWGX4FrOSw/9Re8XKPS0fZTBUMumBo/BdT
	 JRGLaqKHk30YJZBbsU1veZ4D7yeJwn4AGPqLSlADSbKED+7L765V7aoaMP//g5dkmw
	 UhavJevqRi+k4JszuQEWCS5oPf8IuxJhVgnQvmzc27QrmKdJCOHil92PqC0pd48hnL
	 acAagRV3kTW1V7vL86Fh30wRxcjO0/eyr7myB4EjBye5MEafwP7dqQXcqNxGy1bMqj
	 RyQx7GJOmlU8RsYhQGnj3lL1a4YwxHwLCM99zPGFYA/9BZth6FoRMOjCp/5bqM+5LZ
	 pdIXc9cMimREA==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next PATCH] test: hsr: Extend the hsr_redbox.sh to have more SAN devices connected
Date: Fri, 10 May 2024 16:37:10 +0200
Message-Id: <20240510143710.3916631-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

After this change the single SAN device (ns3eth1) is now replaced with
two SAN devices - respectively ns4eth1 and ns5eth1.

It is possible to extend this script to have more SAN devices connected
by adding them to ns3br1 bridge.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 71 +++++++++++++------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
index db69be95ecb3..1f36785347c0 100755
--- a/tools/testing/selftests/net/hsr/hsr_redbox.sh
+++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
@@ -8,12 +8,19 @@ source ./hsr_common.sh
 do_complete_ping_test()
 {
 	echo "INFO: Initial validation ping (HSR-SAN/RedBox)."
-	# Each node has to be able each one.
+	# Each node has to be able to reach each one.
 	do_ping "${ns1}" 100.64.0.2
 	do_ping "${ns2}" 100.64.0.1
-	# Ping from SAN to hsr1 (via hsr2)
+	# Ping between SANs (test bridge)
+	do_ping "${ns4}" 100.64.0.51
+	do_ping "${ns5}" 100.64.0.41
+	# Ping from SANs to hsr1 (via hsr2) (and opposite)
 	do_ping "${ns3}" 100.64.0.1
 	do_ping "${ns1}" 100.64.0.3
+	do_ping "${ns1}" 100.64.0.41
+	do_ping "${ns4}" 100.64.0.1
+	do_ping "${ns1}" 100.64.0.51
+	do_ping "${ns5}" 100.64.0.1
 	stop_if_error "Initial validation failed."
 
 	# Wait for MGNT HSR frames being received and nodes being
@@ -23,8 +30,12 @@ do_complete_ping_test()
 	echo "INFO: Longer ping test (HSR-SAN/RedBox)."
 	# Ping from SAN to hsr1 (via hsr2)
 	do_ping_long "${ns3}" 100.64.0.1
-	# Ping from hsr1 (via hsr2) to SAN
+	# Ping from hsr1 (via hsr2) to SANs (and opposite)
 	do_ping_long "${ns1}" 100.64.0.3
+	do_ping_long "${ns1}" 100.64.0.41
+	do_ping_long "${ns4}" 100.64.0.1
+	do_ping_long "${ns1}" 100.64.0.51
+	do_ping_long "${ns5}" 100.64.0.1
 	stop_if_error "Longer ping test failed."
 
 	echo "INFO: All good."
@@ -35,22 +46,26 @@ setup_hsr_interfaces()
 	local HSRv="$1"
 
 	echo "INFO: preparing interfaces for HSRv${HSRv} (HSR-SAN/RedBox)."
-
-#       |NS1                     |
-#       |                        |
-#       |    /-- hsr1 --\        |
-#       | ns1eth1     ns1eth2    |
-#       |------------------------|
-#            |            |
-#            |            |
-#            |            |
-#       |------------------------|        |-----------|
-#       | ns2eth1     ns2eth2    |        |           |
-#       |    \-- hsr2 --/        |        |           |
-#       |            \           |        |           |
-#       |             ns2eth3    |--------| ns3eth1   |
-#       |             (interlink)|        |           |
-#       |NS2 (RedBOX)            |        |NS3 (SAN)  |
+#
+# IPv4 addresses (100.64.X.Y/24), and [X.Y] is presented on below diagram:
+#
+#
+# |NS1                     |               |NS4                |
+# |       [0.1]            |               |                   |
+# |    /-- hsr1 --\        |               |    [0.41]         |
+# | ns1eth1     ns1eth2    |               |    ns4eth1 (SAN)  |
+# |------------------------|               |-------------------|
+#      |            |                                |
+#      |            |                                |
+#      |            |                                |
+# |------------------------|   |-------------------------------|
+# | ns2eth1     ns2eth2    |   |                  ns3eth2      |
+# |    \-- hsr2 --/        |   |                 /             |
+# |      [0.2] \           |   |                /              |  |------------|
+# |             ns2eth3    |---| ns3eth1 -- ns3br1 -- ns3eth3--|--| ns5eth1    |
+# |             (interlink)|   | [0.3]      [0.11]             |  | [0.51]     |
+# |NS2 (RedBOX)            |   |NS3 (BR)                       |  | NS5 (SAN)  |
+#
 #
 	# Check if iproute2 supports adding interlink port to hsrX device
 	ip link help hsr | grep -q INTERLINK
@@ -59,7 +74,9 @@ setup_hsr_interfaces()
 	# Create interfaces for name spaces
 	ip link add ns1eth1 netns "${ns1}" type veth peer name ns2eth1 netns "${ns2}"
 	ip link add ns1eth2 netns "${ns1}" type veth peer name ns2eth2 netns "${ns2}"
-	ip link add ns3eth1 netns "${ns3}" type veth peer name ns2eth3 netns "${ns2}"
+	ip link add ns2eth3 netns "${ns2}" type veth peer name ns3eth1 netns "${ns3}"
+	ip link add ns3eth2 netns "${ns3}" type veth peer name ns4eth1 netns "${ns4}"
+	ip link add ns3eth3 netns "${ns3}" type veth peer name ns5eth1 netns "${ns5}"
 
 	sleep 1
 
@@ -70,21 +87,31 @@ setup_hsr_interfaces()
 	ip -n "${ns2}" link set ns2eth2 up
 	ip -n "${ns2}" link set ns2eth3 up
 
-	ip -n "${ns3}" link set ns3eth1 up
+	ip -n "${ns3}" link add name ns3br1 type bridge
+	ip -n "${ns3}" link set ns3br1 up
+	ip -n "${ns3}" link set ns3eth1 master ns3br1 up
+	ip -n "${ns3}" link set ns3eth2 master ns3br1 up
+	ip -n "${ns3}" link set ns3eth3 master ns3br1 up
+
+	ip -n "${ns4}" link set ns4eth1 up
+	ip -n "${ns5}" link set ns5eth1 up
 
 	ip -net "${ns1}" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 supervision 45 version ${HSRv} proto 0
 	ip -net "${ns2}" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 interlink ns2eth3 supervision 45 version ${HSRv} proto 0
 
 	ip -n "${ns1}" addr add 100.64.0.1/24 dev hsr1
 	ip -n "${ns2}" addr add 100.64.0.2/24 dev hsr2
+	ip -n "${ns3}" addr add 100.64.0.11/24 dev ns3br1
 	ip -n "${ns3}" addr add 100.64.0.3/24 dev ns3eth1
+	ip -n "${ns4}" addr add 100.64.0.41/24 dev ns4eth1
+	ip -n "${ns5}" addr add 100.64.0.51/24 dev ns5eth1
 
 	ip -n "${ns1}" link set hsr1 up
 	ip -n "${ns2}" link set hsr2 up
 }
 
 check_prerequisites
-setup_ns ns1 ns2 ns3
+setup_ns ns1 ns2 ns3 ns4 ns5
 
 trap cleanup_all_ns EXIT
 
-- 
2.20.1


