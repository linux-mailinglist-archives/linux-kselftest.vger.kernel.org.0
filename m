Return-Path: <linux-kselftest+bounces-2016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F68148FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4E51F23932
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B62D7B6;
	Fri, 15 Dec 2023 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQDvHcYi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FF2E62B;
	Fri, 15 Dec 2023 13:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADA4C433C8;
	Fri, 15 Dec 2023 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646462;
	bh=glwQUbZej9xPHHx7W0zMnqG4yuuk1wNalrDhBBFRPnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQDvHcYi3V4aMF5bwJg1UGxS4x4Iuk/FTTudklABc3whggNVpuqJv/dJcdaTMWL4q
	 sq8XbDvi2/WBE93+M2cf8+0Y+uP2ZEx+rGrJRgzw4IBCzNBLshi8lBh+VaiEgmQ5QQ
	 Zco/EIFABt5BpR8Fw8vJy+J+WMPsKV2i0Xap+W1bwyzS7PPEAczl2IEcrz6tXddaGR
	 ICNlLs2yCE0ydZ08XrgsjEeiSU5dJrFL9lGQah7IFcPZTzsVSDpORc7f7ktDcn4DZq
	 M4wVIZ1leHhZyf1/qzL9jkh153TB2/py4vVnlhfIT72Pz9r+TCDr4Yeeoi5N80QR6u
	 Xow6QHrbYSXhQ==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v9 02/10] selftests: forwarding: ethtool_mm: fall back to aggregate if device does not report pMAC stats
Date: Fri, 15 Dec 2023 15:20:40 +0200
Message-Id: <20231215132048.43727-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215132048.43727-1-rogerq@kernel.org>
References: <20231215132048.43727-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Some devices do not support individual 'pmac' and 'emac' stats.
For such devices, resort to 'aggregate' stats.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 tools/testing/selftests/net/forwarding/ethtool_mm.sh | 11 +++++++++++
 tools/testing/selftests/net/forwarding/lib.sh        |  9 +++++++++
 2 files changed, 20 insertions(+)

Changelog:

v9: no code change. Added Kselftest maintainer in Cc.
v8: initial commit

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 6212913f4ad1..50d5bfb17ef1 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -25,6 +25,10 @@ traffic_test()
 	local after=
 	local delta=
 
+	if [ ${has_pmac_stats[$if]} = false ]; then
+		src="aggregate"
+	fi
+
 	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
 
 	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
@@ -317,6 +321,13 @@ for netif in ${NETIFS[@]}; do
 		echo "SKIP: $netif does not support MAC Merge"
 		exit $ksft_skip
 	fi
+
+	if check_ethtool_pmac_std_stats_support $netif eth-mac; then
+		has_pmac_stats[$netif]=true
+	else
+		has_pmac_stats[$netif]=false
+		echo "$netif does not report pMAC statistics, falling back to aggregate"
+	fi
 done
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..763c262a3453 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -146,6 +146,15 @@ check_ethtool_mm_support()
 	fi
 }
 
+check_ethtool_pmac_std_stats_support()
+{
+	local dev=$1; shift
+	local grp=$1; shift
+
+	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
+		| jq '.[]."$grp" | length') ]
+}
+
 check_locked_port_support()
 {
 	if ! bridge -d link show | grep -q " locked"; then
-- 
2.34.1


