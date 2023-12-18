Return-Path: <linux-kselftest+bounces-2146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D845D816FAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86873289526
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26D4FF63;
	Mon, 18 Dec 2023 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB9O7qYw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CE498BC;
	Mon, 18 Dec 2023 12:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC3C433CA;
	Mon, 18 Dec 2023 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702904128;
	bh=Nlq9ZlGI1tQi8HuukcBJ/b6ytj5WozuimYpYe3B7rRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZB9O7qYw5yxkLok9FIbfsmwEukMZ5Rk3UBf41P0VuQ607NPnHc4eIZbz24HhxJCqC
	 AvctlAxmX25myiNaQlPzCrbXthUNq7zGNSaeHE11q8W8QAD4hRpywY/50mZAysAhnY
	 lR37uB60CuqkKIgMjAonR4NHMjKcgG1w5VeHU00uvI+DGs2iG74ibRPfvM6azhQC+4
	 a8nIdGFDaNX1Km4IQW6a8aQWV9UO1IfyBQwt90vRHURlqigY7aWAHTSD+QQFI9XQDO
	 SEYvzD7K7o4ech/FHBmzXd18yoqgS1UrJByv6cs/WqsLAIbvi053LuI5cpJSPyv6Ej
	 LSdwuP0tzPtLA==
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
Subject: [PATCH net-next v10 02/10] selftests: forwarding: ethtool_mm: fall back to aggregate if device does not report pMAC stats
Date: Mon, 18 Dec 2023 14:55:05 +0200
Message-Id: <20231218125513.52337-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218125513.52337-1-rogerq@kernel.org>
References: <20231218125513.52337-1-rogerq@kernel.org>
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
v10: Fix check_ethtool_pmac_std_stats_support() logic.
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
index e3740163c384..69ef2a40df21 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -155,6 +155,15 @@ check_ethtool_counter_group_support()
 	fi
 }
 
+check_ethtool_pmac_std_stats_support()
+{
+	local dev=$1; shift
+	local grp=$1; shift
+
+	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
+		| jq ".[].\"$grp\" | length") ]
+}
+
 check_locked_port_support()
 {
 	if ! bridge -d link show | grep -q " locked"; then
-- 
2.34.1


