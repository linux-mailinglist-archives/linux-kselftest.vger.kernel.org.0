Return-Path: <linux-kselftest+bounces-19343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3749969A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED506282ECE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015FE193064;
	Wed,  9 Oct 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Btu8ZoTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58D193419;
	Wed,  9 Oct 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475811; cv=fail; b=hlPVQa1Ae7c74QYkVFZDjGkst0EnbhOl0U3+c4caIYPkXYn96EWBqpsmJEVh/lCLN8Km9nfl25f0zuQkDhAyKAkTNPMCy1aliyrrf0uXSAWYRfcbegN/pPk+MS1b6hCymi0R6hoSqwtTqadd33LF2phqZ3dGMa68O89u3dvdS+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475811; c=relaxed/simple;
	bh=9XZWsVsdy78ua9m+mpDUI5r/ZCBzuBv9qeHo1cyy37U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP4btKkhsICU/idikjLnIymaaIoDLlExS8/7VSyAuY2y1O1vCEAwWtqThnqUNkZKQDNCfomxfQn9VEKn+y9yZCuEErXiFlbMmJ8pYPFXfvD8o1Ml8iF8NOa7glxqg2u+bQqfXNfkpZI8qx74U1fkY2SpPeB1h9++AJ9QT8TADCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Btu8ZoTy; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0lJ+p2E82iL4c8ZpOqxVd8KUgKDxyZxyFphlJ1sBNVEyhkY95QOyxxHj885TmVkRKTKnrtWnjtHcgDys56RLW6wLiJy3NnCM5HeB8D8Emjc7sHrWNYvxP2Lq5qzRwjudCSjqCIJr6gQG4lvuq6mZjaWY7lHacRsoIo2w/iqURYfXeXQnZzjepUHbCUnVdDpl9BCyefI+LBqH2EHqz03lZWUpySEAjI53k+NACFGaJO62ehpWPgy/0MOWyEcbIrmqvhPPAfp19020DwYA7lGs3zMYMCR5bOkhACHLgNZeq736f6WCOHd6jNccuqA6Dj+xABDdtVRBk2OnGLmNyL+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSOfF2v7ewPViEBuf2+/sSDQpyGmcSLnmmrk3nLHXeQ=;
 b=VLd5SboJo3KR0f1SbSxksCtqrokrhZL0FTRn10fkMy6w1Pr+wTMyzCW/JIL+b/1GLUkUh0lFufnM+EW30sxKoVXOo50d05Cd1/kywxQJ15sxW99Qga/sPnKcz9JXGz3TunsxL7eD2lSwgIDpnI9WonXEw+J1kW5pepmo18apj7cg2MYnZtZaMXD9cu1IOQMhuVKDiSZlD0GGrapRwawhdckCsTYbKiUJAfDrCDx02PQX63u7fmoMsTxFJ1EXJc/NZVW3x3ETL6JOuL2GJWRXIVY3+IsxkRkSDgj7btatrJLh6f16V28IrB1jmFQoLcphqppTNFnH8louFWuhi7Vv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSOfF2v7ewPViEBuf2+/sSDQpyGmcSLnmmrk3nLHXeQ=;
 b=Btu8ZoTytpPrIlVnSBnmsxYMkMpZDxQsd+5tMjmFAb9VRY22eolFT/L1rR/Q+R3oZix01+Lh3qXiywE67eJZRxwFF1jNFA+NSm4Z3U5PcjygLxZJmP8vMiz81XNcQBLOuoZ1YvqcSR4yDQ/YTZ62AgvJZ3D/z90j0jYG9758GbViknt0a15HjbqM3Qs/TuHlADhQ0k1RCSb3nstx7X7kD5YNGuzvg3adIPt5IMeVX/7cMAKTMFNRGgWzTI4NFSufnagSvCLfHV/wpWpvxStf2hCYpcQb5GK+HwhHGYEhq+77SYkvIv5cW0ZNwjFU1SbEh6qU2l6RcQp3F+vfX2wCqA==
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:10:05 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::14) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 12:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:10:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:50 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/10] selftests: TBF: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:23 +0200
Message-ID: <dda188e0d7674466f6d8bfaa6be48ebe02b66c73.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728473602.git.petrm@nvidia.com>
References: <cover.1728473602.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 906ce7f4-398a-41f9-8b13-08dce85b4f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rxcsz2iWmkTE0IlunWgoI/2c2AwFTg2TpxO3qafX9XwB8PSMlZdsH6yA1591?=
 =?us-ascii?Q?H2Pc1TVcZx7RyEYgoNVKH85whZOD1GhSu68fvUwZp42XXFHG2K3IutvPvOIl?=
 =?us-ascii?Q?5caYOlq62AtkIoUj20pJqBtuH13oLFTHrnujVhMaSwVEgUVoVmPL4CPvQE6U?=
 =?us-ascii?Q?dhEudbythvplhzgSmE99wLVlIhY+8CqHQZtED8dKHf6V8e8+v5hCrailU/b9?=
 =?us-ascii?Q?NgLCViA/F5TKrnzZjMPoFK8q2K0jllBWqOhfNrgnSiJYEzsuantEvbs9UWFR?=
 =?us-ascii?Q?ZWxbqUxpPjed1216fPDEGy2KgOr+1qxukfIi+VuT8h+KuMlCyqTMLG+8coVJ?=
 =?us-ascii?Q?vYGoSCkotTUDSz7xqlD1A7Ow/bTa0CmGm5Jg4mMLA00wlbdoWbJj2onYkOZT?=
 =?us-ascii?Q?wmKr/8Fm/XkXDpIXbAD/pEM/jT9SkSwYTaVv9lelAJB6SXk669Str7yQ1Dfq?=
 =?us-ascii?Q?P0nfl5C+z8XFoY7jI0np8WMzgLzfAk19y2blL+UxBw3IgrMgQpPJ8SgVOZRg?=
 =?us-ascii?Q?HYUliwwrm01u9lWcTKfkQ7mKO9zAtQ2qo2xUKHLwa1F3jGxoF4E45jJqkV9G?=
 =?us-ascii?Q?QSsVREu+oXHnyIgYv1TaOaZ7vB/U0UpMH8bKt1tiLMuOnipXJKBCWk46IoRC?=
 =?us-ascii?Q?u0X0XjJ7jURKng7IAdbJgR2MTqjoEza4zmAo7Wr3Rtri1KRfj13xRBSfPxpP?=
 =?us-ascii?Q?hUPOM3fsYafeDoDXAf6bsAat0NTUIgPyLVKQGExkCHz0GCDWMFT+jddEh6QV?=
 =?us-ascii?Q?XLzeWK9+F8QhPa0GL9GAP00VLRlb5CNXl8jTzwlSX7P6oD8ZNyCJsviYfM86?=
 =?us-ascii?Q?KEln/CkVOjWmZMoBj7A02UN06P0irrl7gURN7nw1sBg51NCma6MgRcjNkpho?=
 =?us-ascii?Q?O4zxZ45HJuaX3M/qjqlxer0KDS3fOcLp8n4MHz3IHyv0o/OUVlzcPWP/H42j?=
 =?us-ascii?Q?97lUN0qbcNzlfZQzXCJkhJWYpkzOWMcOJ/BUnmnLKzCbQbck/cxWhf7U9XnF?=
 =?us-ascii?Q?anFCR9QnE6Opj+vE4GfA5LYhbfg3jquA8X8AJKBbUMZ3dqFkuQVkEl1ikowo?=
 =?us-ascii?Q?uvQ87nc7MiKlPRFzMfsKnmAZvAkGbV9a/CnZJovixKkQTbiTgZAxOM3uzIRu?=
 =?us-ascii?Q?Bm3ZKkYNukq/DZrIeTHg8lqjtgjRCuws/MoW0mSmQMYvv2u2xx7vQeghmYQ1?=
 =?us-ascii?Q?k+7/SdYdbuSUWcDBonMVJYqWBJxNIH17g18thgtjTW39OgfNWDTIt1QdQhbs?=
 =?us-ascii?Q?cuasSFkk+mJoLVNosqDcTsK/Hn78Auw2HNVnjlq4b1kRIqFT5oAyZDNLyilI?=
 =?us-ascii?Q?HnWGxBLsSxTRjIFQYxCYm6cUxfwr95KJR6/gc291JEQev9M/jNFuiJRFZgJZ?=
 =?us-ascii?Q?Nrplyr4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:10:04.8839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ce7f4-398a-41f9-8b13-08dce85b4f52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/sch_tbf_core.sh  | 91 ++++++-------------
 .../net/forwarding/sch_tbf_etsprio.sh         |  7 +-
 .../selftests/net/forwarding/sch_tbf_root.sh  |  3 +-
 3 files changed, 36 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
index 9cd884d4a5de..ec309a5086bc 100644
--- a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
@@ -60,68 +60,65 @@ host_create()
 	local host=$1; shift
 
 	simple_if_init $dev
+	defer simple_if_fini $dev
+
 	mtu_set $dev 10000
+	defer mtu_restore $dev
 
 	vlan_create $dev 10 v$dev $(ipaddr $host 10)/28
+	defer vlan_destroy $dev 10
 	ip link set dev $dev.10 type vlan egress 0:0
 
 	vlan_create $dev 11 v$dev $(ipaddr $host 11)/28
+	defer vlan_destroy $dev 11
 	ip link set dev $dev.11 type vlan egress 0:1
 }
 
-host_destroy()
-{
-	local dev=$1; shift
-
-	vlan_destroy $dev 11
-	vlan_destroy $dev 10
-	mtu_restore $dev
-	simple_if_fini $dev
-}
-
 h1_create()
 {
 	host_create $h1 1
 }
 
-h1_destroy()
-{
-	host_destroy $h1
-}
-
 h2_create()
 {
 	host_create $h2 2
 
 	tc qdisc add dev $h2 clsact
+	defer tc qdisc del dev $h2 clsact
+
 	tc filter add dev $h2 ingress pref 1010 prot 802.1q \
 	   flower $TCFLAGS vlan_id 10 action pass
 	tc filter add dev $h2 ingress pref 1011 prot 802.1q \
 	   flower $TCFLAGS vlan_id 11 action pass
 }
 
-h2_destroy()
-{
-	tc qdisc del dev $h2 clsact
-	host_destroy $h2
-}
-
 switch_create()
 {
 	local intf
 	local vlan
 
 	ip link add dev br10 type bridge
+	defer ip link del dev br10
+
 	ip link add dev br11 type bridge
+	defer ip link del dev br11
 
 	for intf in $swp1 $swp2; do
 		ip link set dev $intf up
+		defer ip link set dev $intf down
+
 		mtu_set $intf 10000
+		defer mtu_restore $intf
 
 		for vlan in 10 11; do
 			vlan_create $intf $vlan
+			defer vlan_destroy $intf $vlan
+
 			ip link set dev $intf.$vlan master br$vlan
+			defer ip link set dev $intf.$vlan nomaster
+
 			ip link set dev $intf.$vlan up
+			defer ip link set dev $intf.$vlan down
 		done
 	done
 
@@ -130,34 +127,10 @@ switch_create()
 	done
 
 	ip link set dev br10 up
+	defer ip link set dev br10 down
+
 	ip link set dev br11 up
-}
-
-switch_destroy()
-{
-	local intf
-	local vlan
-
-	# A test may have been interrupted mid-run, with Qdisc installed. Delete
-	# it here.
-	tc qdisc del dev $swp2 root 2>/dev/null
-
-	ip link set dev br11 down
-	ip link set dev br10 down
-
-	for intf in $swp2 $swp1; do
-		for vlan in 11 10; do
-			ip link set dev $intf.$vlan down
-			ip link set dev $intf.$vlan nomaster
-			vlan_destroy $intf $vlan
-		done
-
-		mtu_restore $intf
-		ip link set dev $intf down
-	done
-
-	ip link del dev br11
-	ip link del dev br10
+	defer ip link set dev br11 down
 }
 
 setup_prepare()
@@ -177,23 +150,13 @@ setup_prepare()
 	h2_mac=$(mac_get $h2)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
 	switch_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	switch_destroy
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-}
-
 ping_ipv4()
 {
 	ping_test $h1.10 $(ipaddr 2 10) " vlan 10"
@@ -207,18 +170,18 @@ tbf_get_counter()
 	tc_rule_stats_get $h2 10$vlan ingress .bytes
 }
 
-do_tbf_test()
+__tbf_test()
 {
 	local vlan=$1; shift
 	local mbit=$1; shift
 
 	start_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 2 $vlan) $h2_mac
+	defer stop_traffic $!
 	sleep 5 # Wait for the burst to dwindle
 
 	local t2=$(busywait_for_counter 1000 +1 tbf_get_counter $vlan)
 	sleep 10
 	local t3=$(tbf_get_counter $vlan)
-	stop_traffic
 
 	RET=0
 
@@ -231,3 +194,9 @@ do_tbf_test()
 
 	log_test "TC $((vlan - 10)): TBF rate ${mbit}Mbit"
 }
+
+do_tbf_test()
+{
+	in_defer_scope \
+		__tbf_test "$@"
+}
diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_etsprio.sh b/tools/testing/selftests/net/forwarding/sch_tbf_etsprio.sh
index df9bcd6a811a..c182a04282bc 100644
--- a/tools/testing/selftests/net/forwarding/sch_tbf_etsprio.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_etsprio.sh
@@ -30,8 +30,9 @@ tbf_test()
 	# This test is used for both ETS and PRIO. Even though we only need two
 	# bands, PRIO demands a minimum of three.
 	tc qdisc add dev $swp2 root handle 10: $QDISC 3 priomap 2 1 0
+	defer tc qdisc del dev $swp2 root
+
 	tbf_test_one 128K
-	tc qdisc del dev $swp2 root
 }
 
 tbf_root_test()
@@ -42,6 +43,8 @@ tbf_root_test()
 
 	tc qdisc replace dev $swp2 root handle 1: \
 		tbf rate 400Mbit burst $bs limit 1M
+	defer tc qdisc del dev $swp2 root
+
 	tc qdisc replace dev $swp2 parent 1:1 handle 10: \
 		$QDISC 3 priomap 2 1 0
 	tc qdisc replace dev $swp2 parent 10:3 handle 103: \
@@ -53,8 +56,6 @@ tbf_root_test()
 
 	do_tbf_test 10 400 $bs
 	do_tbf_test 11 400 $bs
-
-	tc qdisc del dev $swp2 root
 }
 
 if type -t sch_tbf_pre_hook >/dev/null; then
diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_root.sh b/tools/testing/selftests/net/forwarding/sch_tbf_root.sh
index 96c997be0d03..9f20320f8d84 100755
--- a/tools/testing/selftests/net/forwarding/sch_tbf_root.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_root.sh
@@ -14,13 +14,14 @@ tbf_test_one()
 
 	tc qdisc replace dev $swp2 root handle 108: tbf \
 	   rate 400Mbit burst $bs limit 1M
+	defer tc qdisc del dev $swp2 root
+
 	do_tbf_test 10 400 $bs
 }
 
 tbf_test()
 {
 	tbf_test_one 128K
-	tc qdisc del dev $swp2 root
 }
 
 if type -t sch_tbf_pre_hook >/dev/null; then
-- 
2.45.0


