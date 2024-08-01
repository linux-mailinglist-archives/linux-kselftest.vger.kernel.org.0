Return-Path: <linux-kselftest+bounces-14662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06994507D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E40281E2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06F1B3F38;
	Thu,  1 Aug 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YoztbcGd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B641B3742;
	Thu,  1 Aug 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529520; cv=fail; b=qaiZV1BlPAT1I9wRuFO56+tE6vi3aWdtwbb9S9JGw1oXYERBUFK5u395XGqYE5aPLDyKVOf0BmdRvr7XYn3QjW0mUeSA7OhwZlQPQCoekfAS0/i8Af96fAQXd5sgI/jqQEEWwAEINmVU1YW5slM+bw9WhAbWUSrWupcW7XMzzSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529520; c=relaxed/simple;
	bh=2pGCJWyiqC0QBQ2fAxEs0sQHMwX2/s0wo+M5GXZVuT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoB0cl113txKXl5YfMgQImAZx9K2D8Gy8jFuKnfeNZvLyojH6wSh7VAqGIQNroxnpYDVnmaBH6CjOOEgGlPiwHINPE9iMT9y5pq7DG+Yxgs3gvvnIQRAhYm+bbbtfmz+IBGbWVywKe6PJqvHaTCzar49wYU0lI/OmD5oFUv4Gbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YoztbcGd; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySxsA/n5Upn04hpw6yFwTKV0PwncEowhPL3pwDUr13VB6kbvaLLn5g2ewxJpYj72MSnWZvxzH/YPIDsyE8Z60e8BTTBHNEvJ6zW2uyiG2iZNIErh52v6nird/CQ3J26vkn8j2jaBOxQ+8K8E1SQPb35dZfgSAir03/IZjIVFyvFRlhvVC5YfjCrwAlxf/qOtZULvlnjx2Ok/KB/x1nLb3u7S5F0HipvAnxITnABm1jXE9fEM+KEtilbt78XwgcLcdaCJlrQIBc+Khj+Wz3c9b+bWUOcvq+To/Hx3sAGb9YMvRkaPz8RvriykB9rfwXcuaGbxTsRM3mCY+R1BCcaxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt7A39m/g2wA4s+2utowuXDlgRp/tzcbPSdFdKbNH+s=;
 b=Gj10V9R0AzD6+R5LyDTB+1pEi4aCa8kJ/WbEn0UDpylE98khKTSFzqP4V8a3/Y+uc6xW1j42fmXj6rBcXUF0vGa8wxN0/CSt/+mV2QMD2GcqMEuwkXQkQcP1dqOAohkRMYSl9Pl7dJB71VMN0TFKTyomPNELKPAiiP/+E54+5w0bz7To1A/Oy9i3LJutzX4N94LN4lMO35gwKuEdfFUzP2yWqXEo7jogHtJYOsThgX3l6E7Cx60Tqysnp5CANhPBB+6RVLY3jVFaRVp1dlg0wA6LRFvZN8W4Xuk4xLTJ/z2wLRyeJopjofnVrW9k+c7AQCcrz1E6k1GrOeoNMV+g+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt7A39m/g2wA4s+2utowuXDlgRp/tzcbPSdFdKbNH+s=;
 b=YoztbcGdGNGJPRvkVZ7viYgYoBx0lIYKeSW8m0tglZdDzWJbbz2tyUPH/+5SgOHTIhR5vXUu30amWEwrnAR8/hGzKVl5M3805XSwzVAMbkcJnMXfs5pUbea8tc5r+N9Ax4/vVqX1cUDGqI2AmRYjcZ1Wb8ePFv3UsJsWms9VkUeEsB+1dcesTZyQc5EmTMh9iEzHmKNv2mv6P4cQwy+19rYrPjO1109L3c7Gsoik7BaZbL1OHzACW37YpA38bi3GeINcfrlbftVg2oPQ0jvM8NiWKXDPuBh0twsoOJ+QhTk1DRkhEQAi31MaWRXXcbq7pHnyrrhN+0U3ldy3YvVcFg==
Received: from BN8PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:94::44)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:25:15 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::2) by BN8PR03CA0031.outlook.office365.com
 (2603:10b6:408:94::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 16:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:25:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:57 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 4/6] selftests: router_mpath_nh: Test 16-bit next hop weights
Date: Thu, 1 Aug 2024 18:24:00 +0200
Message-ID: <9dcd5a4ff9583591c746d14eef4923e6deb5520a.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd42e4a-a474-4f0f-ff23-08dcb24685fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lLcSUeMhCUK40A4gFKyCdwOv+8u468ESIyBSjpeGtyvod/CNSjWpTqMRavo?=
 =?us-ascii?Q?OHpzmtsLNN/Tkq8fHVfoWh9HzqUmI6KCdcX0frikt1d+4sr6pwG5U5bPPMdm?=
 =?us-ascii?Q?WfcxfCk72jpOcrNibgkEGYhQj9tRbMCCVV3mXLwInBQ72HQuG8BqywKdyxpO?=
 =?us-ascii?Q?hCJ4h8VpLKHyXx4dnjCIHYEU7R+PNkxP9clsNZIS0pjerUuQ5DRWe7E8A77o?=
 =?us-ascii?Q?8PahN0jajNl36yZNplBeFHjw4SFmmKMiecM+KIlWzBLjWe79lT/UtJRR5x8E?=
 =?us-ascii?Q?uaheBIIguOnn/ypn4i83LvaL9QuG2Wqu5KG5d5sb4ubpKsbfxMTnz/v0i4Iu?=
 =?us-ascii?Q?7A4zpa/VAGolvnaqybldtNKE7e1XSeNUWO28dd6Hn8YrvqAP5PMXThSMN8d4?=
 =?us-ascii?Q?dWZSjfAXVytgkCAiJVuhsy6SI+9EERWBgsaEYvaFYTJ2IUZk79hYfU8od8Y7?=
 =?us-ascii?Q?o3lfmFGqVz9To6OzQn/Rg9Sndp0ZdK1uQgzLps8oz7KVf0OzhNvYwjLk2c7i?=
 =?us-ascii?Q?4NJvME9LBIo4wdErG+Jqs6/nys9VNXR+zFePLdn/TcjnV0KwJeBtYO0JvTsV?=
 =?us-ascii?Q?azfPLwJQr8fABEgTa8RkwfB1BqSkNFxWP49spFgMPQQQiaVy0qsRYUaAHEWg?=
 =?us-ascii?Q?X3hc9JGnI75K/70X4wHmBOhU1W7COjxRRhTl5KprugHcBlDrK47b1y9jK2H3?=
 =?us-ascii?Q?6mkazyF/DSWnxmiQnqwiF4aUoN6jILMHBOo5y2dX8K4g05VhZmX0dDNAQBXv?=
 =?us-ascii?Q?SYJY0MbwWPhCkYZvT72b52/wgoLODAfuV+fSYTrbDhsRmTL6vW2pfVf4VmzJ?=
 =?us-ascii?Q?AdLvRD1h0Xq3hkhqGDGZQenWFLq/EgevbLrDzXAhnjqBy4pD+IiBn9jeLFk8?=
 =?us-ascii?Q?dBLn0120qu8eyjoAWt7HM1NG7x5tWyTfDgMV2V2cofg5Yz/4uAgNfiBovnbJ?=
 =?us-ascii?Q?o28z07OsHz1ZKZAUUNiBvGlzB1E80EeFxoFh+Az9EoGjp84X2maFIiHffw6o?=
 =?us-ascii?Q?MUy7UDXKtZMwtw4cmIxpX+4/2CR0xMj+oak/V2RCP/F3GThlWmokWN9q0iUm?=
 =?us-ascii?Q?TGYq4g+CdlrZpwH7CsO+JXS6qGaR1IzJUck50/Z6WHvU5GzKi8MnlNctN94K?=
 =?us-ascii?Q?83tz2pzMvmNfrp+S35xKlHzO4mYYoiOX8JmTTrxbWU83p16PRgWJYaX+ko9W?=
 =?us-ascii?Q?Q136dBZyENXZTJLZUV8YB/v5DP3a5wTMG7xXRMQ3Iq7YGOdCQFy0FhLPkwe3?=
 =?us-ascii?Q?RiI1zf0edpDWyjsW/0vtVBZX1T4LMx5AJPNiKsUBmuWc+x6yAkodwXtb4pwT?=
 =?us-ascii?Q?1vqXeNgIN7XKsyib27vgdfu2sr4cQVd4Zp5brSYJdCbKL1jx5EunEOKOekFo?=
 =?us-ascii?Q?d8zvtO5d4oSVsFxVLTmJ4p6qYKuf3zrxb2k2jSXVgxtpp9v4Xk/0VF1AFSA2?=
 =?us-ascii?Q?Jog6qjfB6mR8LYv6h/EFH66jY55nWsOh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:25:14.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd42e4a-a474-4f0f-ff23-08dcb24685fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149

Add tests that exercise full 16 bits of NH weight.

To test the 255:65535, it is necessary to run more packets than for the
other tests. On a debug kernel, the test can take up to a minute, therefore
avoid the test when KSFT_MACHINE_SLOW.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh |  7 ++++
 .../net/forwarding/router_mpath_nh.sh         | 38 +++++++++++++++----
 .../net/forwarding/router_mpath_nh_lib.sh     | 13 +++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ff96bb7535ff..cb0fcd6f0293 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -509,6 +509,13 @@ xfail_on_slow()
 	fi
 }
 
+omit_on_slow()
+{
+	if [[ $KSFT_MACHINE_SLOW != yes ]]; then
+		"$@"
+	fi
+}
+
 xfail_on_veth()
 {
 	local dev=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index c5a30f8f55b5..a7d8399c8d4f 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -40,6 +40,7 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 	multipath_test
+	multipath16_test
 	ping_ipv4_blackhole
 	ping_ipv6_blackhole
 	nh_stats_test_v4
@@ -226,9 +227,11 @@ routing_nh_obj()
 
 multipath4_test()
 {
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
+	local desc=$1; shift
+	local weight_rp12=$1; shift
+	local weight_rp13=$1; shift
+	local ports=${1-sp=1024,dp=0-32768}; shift
+
 	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
 	local packets_rp12 packets_rp13
 
@@ -242,7 +245,7 @@ multipath4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -259,9 +262,11 @@ multipath4_test()
 
 multipath6_test()
 {
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
+	local desc=$1; shift
+	local weight_rp12=$1; shift
+	local weight_rp13=$1; shift
+	local ports=${1-sp=1024,dp=0-32768}; shift
+
 	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
 	local packets_rp12 packets_rp13
 
@@ -276,7 +281,7 @@ multipath6_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -315,6 +320,23 @@ multipath_test()
 	multipath6_test "Weighted MP 11:45" 11 45
 }
 
+multipath16_test()
+{
+	check_nhgw16 104 || return
+
+	log_info "Running 16-bit IPv4 multipath tests"
+	multipath4_test "65535:65535" 65535 65535
+	multipath4_test "128:512" 128 512
+	omit_on_slow \
+		multipath4_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+
+	log_info "Running 16-bit IPv6 multipath tests"
+	multipath6_test "65535:65535" 65535 65535
+	multipath6_test "128:512" 128 512
+	omit_on_slow \
+		multipath6_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+}
+
 ping_ipv4_blackhole()
 {
 	RET=0
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index 2903294d8bca..507b2852dabe 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -117,3 +117,16 @@ __nh_stats_test_v6()
 			       $MZ -6 $h1 -A 2001:db8:1::2 -B 2001:db8:2::2
 	sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
+
+check_nhgw16()
+{
+	local nhid=$1; shift
+
+	ip nexthop replace id 9999 group "$nhid,65535" &>/dev/null
+	if (( $? )); then
+		log_test_skip "16-bit multipath tests" \
+			      "iproute2 or the kernel do not support 16-bit next hop weights"
+		return 1
+	fi
+	ip nexthop del id 9999 ||:
+}
-- 
2.45.0


