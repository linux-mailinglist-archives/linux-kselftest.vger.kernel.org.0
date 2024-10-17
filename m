Return-Path: <linux-kselftest+bounces-19941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297019A1ED4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320D31C20830
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D981D9665;
	Thu, 17 Oct 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eQKT5h74"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA601D47A3;
	Thu, 17 Oct 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158460; cv=fail; b=LRPqWZrEBsiyj5wYInukwbeimOWTHqkaeHwlpmuuqCgiTJ2h2NXQy/mTJtXFJXjJH2Nl4iKEzWWm1QioXezy5Kmj98FhSGV5pQcmuIqswmHesyGkSugJuwQy0sD6PkVpIg8BKh2x/87A4P8ovaGG/yoa+btN8hjAxaQjS94OevM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158460; c=relaxed/simple;
	bh=9XZWsVsdy78ua9m+mpDUI5r/ZCBzuBv9qeHo1cyy37U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzcUPKBb4LEUYhHu94yzrsIIBU+w+gfypYHwKZ31RvL5GWDjGChyJdMsG2qWZCzoaNVZXUjak9hhV6vzRXLzWnMly4AuOXj+TO1oP5BkMRRRnVHeF2vPDmqZVrnBtPVFDDWSPgb0iIV2kjpkROdXyxGbhcTPUUqm3/8PWQEehNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eQKT5h74; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkPgBPyoPxKbH8EhdJGrBH7vazysxIfbnIZ2RSVM/1xWKgGlinBtGksBSN2l41scabPanAybhbjz1TnAgX75vSqPyT3p4IX79Rfhpc5evS83TI9Qu7z3eCqYynQSxhZYbptmwYvDZ9pAt9p3/TOwiKH/NlHXLLhqqPh3KItlYOHzecdacnBbVFGnKnxNVCZh+3ijRc4hFGm4i+UEGJGaHkdBQOqFQOXAVljUdUs29gkFhCLIXm0Rm3FRfq0JsmJn62sMWKHyDUQDFAWbtqhXO7xHmmssXhld4fZ9DtTr1JvlqMC5Ua2vPHAAQ3qKWI+m0rk3TIA1wqBhxLagLYwyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSOfF2v7ewPViEBuf2+/sSDQpyGmcSLnmmrk3nLHXeQ=;
 b=f8RLvd/Kt/5pb2/IIunlwDJ/N7I3FcSfkP45xHcQ4ZUbgLVdKvrFrCSvzwzLKdx8tANA2bcVHxYzruCQKSMDYuY5VLnt/NxpOAHCDTR/AyyFpc8D4NpT9NS3SPz9fnjK82VoVN+kT2Fmxrzn3GXRoNRzinwdWT1RHFoAyPmYwTobiSc1BECQReqUu2raNRKrSI2P9eYAmIk1ZE6uFZJQOKgIDOxCxsxhY4pIMwbznYCmMDmtEr+GyfSa/5X9oM//zMcz/ghz7IH6MyM/WHtLFYkFqw18lK2hEcfg9Vnj9i8SNCCYkTIJ3XS231OmZEbqJhMNvvLWUQrhsdnTKl/lFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSOfF2v7ewPViEBuf2+/sSDQpyGmcSLnmmrk3nLHXeQ=;
 b=eQKT5h74FvYnkyLG1L95fOzw/oO9h69Y8QDts3wjNCxvUbfsF6IhaZzzA5HpMi/fNvhxg4suMvVjNEzQdplTYRt/nWVKZ+bLsNxDAoO3wjDknTF0lYgDJ+P0f7gAt32MGjwkJOm+gst+Wt/izSMcFzHZ0qelfuFB4f+XdrTR+mwQwCHWEKbf0aNiwzSyu8a6gB7G4iQbyBhm6Bq86sliPorfHPz8yqBhxYiOdPQHXqk10OheHCt9yhJYl2FlNvU4JU6ds42MXiSH2ZtjUPVt+H58q9xp32PsxBWIu4laNpO2w8HTZFZN4KYWkn+goBEhQbQ8o/IZqQvPxNz5pbVeAg==
Received: from SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::22)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:47:30 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::1a) by SN7P220CA0017.outlook.office365.com
 (2603:10b6:806:123::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:24 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 05/10] selftests: TBF: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:47 +0200
Message-ID: <b1fdf9a4576ef44b06947ecde56a662c02d6fe5c.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
References: <cover.1729157566.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eecb860-5e58-44ab-6b30-08dcee90b7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4OrxnmOXMNDgwEVySey8ZInd8xPXb/Zvc6Nt0H3JvXIX8hZSoISsv32ioPj?=
 =?us-ascii?Q?3ewbVYwhm9aU3OKj6FPaYU6y7KoG1tLRn+0R8q9v6ZG5nFt5uN5cK3qYTdsW?=
 =?us-ascii?Q?dKOULkZFIyDHqbzXjdBcLhEaUstQt/SNPaMXkElEnf0XyYsbS7Cnr6XQQKxQ?=
 =?us-ascii?Q?KriIFfPtFIgFC/I9UqV5cMQOpAW/GlwDVYyqdK+DurM19NFqb66IjNgXVyTq?=
 =?us-ascii?Q?HudD5NeKdODfgY7aMEtbS/aK4v+e4pY0pnW30a2iOG2r8fSQDQgsb2ITlCTb?=
 =?us-ascii?Q?qIaxEX3ivYAGqs/aoaDAs9pec7ug3/Q71TR05/ofLThN0nyXmLwWDCRKSXYi?=
 =?us-ascii?Q?sN+HMYchYN0tFzHgtT7YUowWPAhWd6DcOYwOzSWx6RKDrfN79gOkrjwNlGtM?=
 =?us-ascii?Q?j9ezhse1IrXfVzvu7bpan8Ur1/ascIqIA95NBnSoOw5PyMl7ifOOjpWdpudl?=
 =?us-ascii?Q?MgbWD2jMGLa4IFvxm0lpM8zlbud2D+OI4GFdbpfGK0i6H8p7TLNZs/zIqUNC?=
 =?us-ascii?Q?ifiuPxpKXCxs8pvvciw3uxYxnJ2TwzmKMFwP6LIKgy5oZX/HOaNBfZaOqU5f?=
 =?us-ascii?Q?sr6hfy+RIENZiygigKodHzrptlox7yEu7YsjIXGPu0LYC6IAF/46Tm/K2co1?=
 =?us-ascii?Q?0FEYeVjxijaDRfCCnb7uhJ0lsxKdkx0O+cN0nOfB3sQpXfAdCVcb+ORT6zpj?=
 =?us-ascii?Q?6VDtioIA1mZ4m+HorzSafQoyNq13IuTrXq4JqcX+q3SlTYDAWVdyJuu0ZYQ/?=
 =?us-ascii?Q?xFfrdZvbkbmzEMw7xlkE03eMmS8I70UDw/vW/vQmph+G5lqUPOwfQNoRcgXn?=
 =?us-ascii?Q?6cr9OPwN+dqDdgbjE7hNXTaraonQJ/DzgKpEMYkIRJz3+cWWbD8UuI1FwQBM?=
 =?us-ascii?Q?ZvuUJHor1ll4c8Cs1vaOQT/iqx/fnALMmSXYV8UEEh8igOF03YyLAc2TzTZA?=
 =?us-ascii?Q?1HpOzWLodEbmT17jMBSHkcv3wThzRDJUpec8TQ2h2K3C91qmeAk0ohtken5c?=
 =?us-ascii?Q?BmlM0dBimcFdJWhWNJRGO3iRaDVfEhVz6zv/NKroag1F2o7116NJV6iGZfCU?=
 =?us-ascii?Q?UVpVgFW3QtLu6pxen+4ROAsztLepfBVPr5kcoaJ6O+NDIYmqe2uEDhjcgfRJ?=
 =?us-ascii?Q?4zVB8Zfmxi4AoKdB+ZFFDKx5s+yJuCsL2ZvmEgjdfLbdPBgfO22DTewmgD/4?=
 =?us-ascii?Q?YsG1upy6QEaR3+m5KwKYzLeBVx8/57cDyDXq/gQzMfQKDL2mwV4T8JT+K4d7?=
 =?us-ascii?Q?n9lKt6Bp8cVMBvijK6lbRSEVtGtskBSpXuvC5EcY1Xv+plmzsxNvMrH7n1Ax?=
 =?us-ascii?Q?l6mfKzy1mpLabdwFfomnfem0HiQyEKnvsrZrXleJy6LM2gPaQwOVwzFzNien?=
 =?us-ascii?Q?xnT8srN48N0VbpA3SAWrksfbVrkLwJmbKTr7/Yr595RAsbEqwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:30.2961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eecb860-5e58-44ab-6b30-08dcee90b7b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

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


