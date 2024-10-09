Return-Path: <linux-kselftest+bounces-19346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B5F9969AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8F0281AC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC4192D97;
	Wed,  9 Oct 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="flTHLlHb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393A190072;
	Wed,  9 Oct 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475832; cv=fail; b=X0VUmVU/JqIK1+XF78sqgZvduxowvAyVsHMowkpe91kS6kYhu1jCL4T5/n1E7OyPL2GY0GqvuWuniSsKx4Y/P4xYJNP2R1KsNlGpsvPQo0c7zEzugBC9TcZWqXCr/+qtJ+25cBi6sRB+O72SH/KqTzcicLgJYyMGEeRoxk/pQXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475832; c=relaxed/simple;
	bh=rpy+x0vc78lZ4LbaVLMTj0KPKBxawl7m5ERl5vdien8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBR+L3R/1Dk3zfgIkpN/A0pEruape+uOAreGP5qFr78EoJrma9hKSOGP+fdcy9Cn6d3aiLMGMa2AMzk5sFL6u/TLlwOcZzLyJ2/pR49kpHygp2yoCO7d1BhVhBibIgTzrrfRyzNmvMfuBM6nd/QtDGU5HbiInKSAKI0/RDN5AAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=flTHLlHb; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asVgra5A2OJW2k5FW4dcxTREy+HzfNXs5SgnlJhOFnJdm1zQ0jJXhg5cJZUiV2+DMpSusjRwj9Mk4qDKKGAopfpdHT/RNHhtlNbe+ITU0XgYF0CSoJmGT1sN8aPAaMvqv6mpyy5dYrZvPWHrMBj32qzpJD56Mn6w+6iK9sUkV/4dJpMF/vGQHXxOVDWQFbD5s5lVSLdUxQ09wSlnz1UKH9kFPCNIlNgw/TFHMxsLhRvzGefiqCauAX//inKjcVXxu4MgGtQkU2bBjj+o7N7N/HqDFiqui4x4V7X5gKLEMeQZLzRm2e/rfyoxCpCsyIdbor3h4iSl2SwVJYK5HtiULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0UuiXORT+ug6c0oBl32NLkP0UqjlEWaC7OnNoaxuUE=;
 b=F/2s+yivFLmRHKWb7EBIzsdBskNRtpigEDewaZJyExH+lLwkjUzkPF3kc2xf4ZVAF7ciHASSpflX7s+E3V/RHrMGMWKoFfjHxmYcEFoJHdOCurLcYenJHgSUswDXrOVXtrI/soIAhrW24uZ2LFLH3F+afcASWVBmxpgnCOvntexPGKwVaCV0i7l9yyJvBzBWKFA9s3iQGU5cOINSPcpqZjH1GsMdJIBt1g5PZU3dXq1y/2ldgYEnakMCiw9+4ohtZYqr/9QjcFtftUyb+SUIK1WdokBtQcvHPYW7RoM6EteC21NbtMCmuilv4xthnlxSlVu189XlPYBEV+HjlhF4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0UuiXORT+ug6c0oBl32NLkP0UqjlEWaC7OnNoaxuUE=;
 b=flTHLlHb0tj5WFtv6flS9eGGNPLfVE8I9X9rHtaEcAe91GV17PGBrh5rj/V6uk1DAlAxkQGPZWAK2BJDWyh4WI11ZjnnMT6sVL8gGSNSYpQqMRWD+bAYEzSqB3Cbz7COrbqdzbm6YPkleBHXY3Kf98cpQaqfFQWNWu/ZRVzmFaI5m2epYBpKd28L4IhrnAGdDIEU3N+A6RHnRctaK9s4+1Cp/yp4E31Mz2GdfZir4I57D4xZ303SSFrEEhaqETodW78fZk8X3lVk9aTk3msiU+61XiP0j/rhIK4P8Lkj1D1Ch2ueWLZ0c7cL4mBhCTiEk1U2ydvplUkoQl/d/dTmbw==
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 12:10:26 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::9f) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:10:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:11 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/10] selftests: mlxsw: qos_ets_strict: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:26 +0200
Message-ID: <2c6f94b03d019ee4244459bb0829fcd70134c91c.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: f25e14c8-cb95-401a-aaa2-08dce85b5bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6R6fiCP5jcHnwBNTsbf3P6azc3TlYuFC8UpFgoXr/C4lSfRFsqK/2ZQS7aqt?=
 =?us-ascii?Q?ZVvBgAknxOsNHBfrsslJ6udoD+hxyBNFEfadPcnqRK1f9zrlOoM3iAWK7XcJ?=
 =?us-ascii?Q?3ojkpsCMEK0b0ZBGWrutxc3dYOPNtslo/oXM19gPnSNJ3tjn04OEtnLsmP4M?=
 =?us-ascii?Q?BaNBfsWmyfcyWr+9lj5BK7gpN6MD5cKahCvMdzlLGJaJIm+vmWV1P62l14X3?=
 =?us-ascii?Q?5Vhil397jLs8jVZCpEEt4RXbNg5gX9dwNMFAce6VE1xe20ljqS9eFny0j70O?=
 =?us-ascii?Q?1mn7Ocm+dYip6iABJ3mB9hhoowhqzjnT2m3eF9an2Sf4P3bfgopCeaznRBx3?=
 =?us-ascii?Q?VfccfqUcDMgfLDV4cnLvfSCzFOudAxOUvoYgYnZZnuTlUZ8kZdL5uRnMc6vo?=
 =?us-ascii?Q?UfgImJa175hlbK0HEyNxiV9Q9eZrBnzbEiHY9gZtsuQdAbqXrkhrmUqx4sO9?=
 =?us-ascii?Q?vDcnD6fkUVG3Q0lQW3nrDNgywfYpCYdnTZGejcfnhhgPUa9A/BoAYr1ZTYuZ?=
 =?us-ascii?Q?u534rY8Tm8eFuBvJkc7N0uhSlZRBnKSScgUXKVYdtlHUP1w6eU83o1S9Es7J?=
 =?us-ascii?Q?whogZoogh4EVG/5xAQoWS+ug8ztQa072fH7OYRwmQ55s32a16CEAwRA/8L9i?=
 =?us-ascii?Q?2yTMRverSkYdfpQElLDG7YFJ4gypqfWn/RvqqtQErva8ujP2pI7Dd8RCm9I/?=
 =?us-ascii?Q?GBMiR1wG3GUgLadktSFYL05c5hjWkKsbJSXt3kIyhpiMmt/In/cCblwkY/Sf?=
 =?us-ascii?Q?+y0I4iMLx1S6fcqS9LKOpkvUMd4f3/wkw6Cin0bBQjTFQow7Jc/6V01eZEPt?=
 =?us-ascii?Q?8ssW7fk3QZ0804+LkVVOmxXyRODao3PtINPXStRz5LaIeg4ssbHnAZR9INTe?=
 =?us-ascii?Q?MFG1gIJoGWkot8cYvmuOQHPG10H4MGHriI1EANV+fuAVRVI6jn1gUDO0T3OC?=
 =?us-ascii?Q?cwvTY3wl+09HWZpUfTZm9Iep6RsiJ4l6zZNlZvdpAXlZBtWLE5lHyWW80A2E?=
 =?us-ascii?Q?gLtpbZuHLzJRvJjFRTUjZkvmvNVo7g3MM48eGvj/85BVc49kmEmGcR9Z7ZBN?=
 =?us-ascii?Q?/aeAdRC56RqrV2td9ndYAPm2x7rUYjJ47JmqNrzGLdY8eEVf9108t95Fk0/C?=
 =?us-ascii?Q?Ykb9teKJqoA236SOVmh87rCd5Wm8MUhy4Cdx1XD9Lu2skdks1WS23TNtmaym?=
 =?us-ascii?Q?PWa5z2vyelCI5FhKYyYFrqhExzS8FYvzvNSWToEF4124Z2IINB/jhwC32on2?=
 =?us-ascii?Q?HXHSDXnMl7i8MFLz95CKAQLdLMgma560Qmqh0MT/+ydHpNGZzTgqKVDLg5b9?=
 =?us-ascii?Q?yJLX54A2uLoY2yLW5PFE2DZ9EVP4K6i86oDtKtkuye/yW0vwrk21KpFWqao6?=
 =?us-ascii?Q?ck6KxGw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:10:25.7775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25e14c8-cb95-401a-aaa2-08dce85b5bc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/qos_ets_strict.sh       | 167 +++++++++---------
 1 file changed, 85 insertions(+), 82 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
index fee74f215cec..d5b6f2cc9a29 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
@@ -58,65 +58,62 @@ source qos_lib.sh
 h1_create()
 {
 	simple_if_init $h1
+	defer simple_if_fini $h1
+
 	mtu_set $h1 10000
+	defer mtu_restore $h1
 
 	vlan_create $h1 111 v$h1 192.0.2.33/28
+	defer vlan_destroy $h1 111
 	ip link set dev $h1.111 type vlan egress-qos-map 0:1
 }
 
-h1_destroy()
-{
-	vlan_destroy $h1 111
-
-	mtu_restore $h1
-	simple_if_fini $h1
-}
-
 h2_create()
 {
 	simple_if_init $h2
+	defer simple_if_fini $h2
+
 	mtu_set $h2 10000
+	defer mtu_restore $h2
 
 	vlan_create $h2 222 v$h2 192.0.2.65/28
+	defer vlan_destroy $h2 222
 	ip link set dev $h2.222 type vlan egress-qos-map 0:2
 }
 
-h2_destroy()
-{
-	vlan_destroy $h2 222
-
-	mtu_restore $h2
-	simple_if_fini $h2
-}
-
 h3_create()
 {
 	simple_if_init $h3
+	defer simple_if_fini $h3
+
 	mtu_set $h3 10000
+	defer mtu_restore $h3
 
 	vlan_create $h3 111 v$h3 192.0.2.34/28
+	defer vlan_destroy $h3 111
+
 	vlan_create $h3 222 v$h3 192.0.2.66/28
-}
-
-h3_destroy()
-{
-	vlan_destroy $h3 222
-	vlan_destroy $h3 111
-
-	mtu_restore $h3
-	simple_if_fini $h3
+	defer vlan_destroy $h3 222
 }
 
 switch_create()
 {
 	ip link set dev $swp1 up
+	defer ip link set dev $swp1 down
+
 	mtu_set $swp1 10000
+	defer mtu_restore $swp1
 
 	ip link set dev $swp2 up
+	defer ip link set dev $swp2 down
+
 	mtu_set $swp2 10000
+	defer mtu_restore $swp2
 
 	# prio n -> TC n, strict scheduling
 	lldptool -T -i $swp3 -V ETS-CFG up2tc=0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7
+	defer lldptool -T -i $swp3 -V ETS-CFG up2tc=0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0
+
 	lldptool -T -i $swp3 -V ETS-CFG tsa=$(
 			)"0:strict,"$(
 			)"1:strict,"$(
@@ -129,85 +126,90 @@ switch_create()
 	sleep 1
 
 	ip link set dev $swp3 up
+	defer ip link set dev $swp3 down
+
 	mtu_set $swp3 10000
+	defer mtu_restore $swp3
+
 	tc qdisc replace dev $swp3 root handle 101: tbf rate 1gbit \
 		burst 128K limit 1G
+	defer tc qdisc del dev $swp3 root handle 101:
 
 	vlan_create $swp1 111
+	defer vlan_destroy $swp1 111
+
 	vlan_create $swp2 222
+	defer vlan_destroy $swp2 222
+
 	vlan_create $swp3 111
+	defer vlan_destroy $swp3 111
+
 	vlan_create $swp3 222
+	defer vlan_destroy $swp3 222
 
 	ip link add name br111 type bridge vlan_filtering 0
+	defer ip link del dev br111
 	ip link set dev br111 addrgenmode none
+
 	ip link set dev br111 up
+	defer ip link set dev br111 down
+
 	ip link set dev $swp1.111 master br111
+	defer ip link set dev $swp1.111 nomaster
+
 	ip link set dev $swp3.111 master br111
+	defer ip link set dev $swp3.111 nomaster
 
 	ip link add name br222 type bridge vlan_filtering 0
+	defer ip link del dev br222
 	ip link set dev br222 addrgenmode none
+
 	ip link set dev br222 up
+	defer ip link set dev br222 down
+
 	ip link set dev $swp2.222 master br222
+	defer ip link set dev $swp2.222 nomaster
+
 	ip link set dev $swp3.222 master br222
+	defer ip link set dev $swp3.222 nomaster
 
 	# Make sure that ingress quotas are smaller than egress so that there is
 	# room for both streams of traffic to be admitted to shared buffer.
 	devlink_pool_size_thtype_save 0
 	devlink_pool_size_thtype_set 0 dynamic 10000000
+	defer devlink_pool_size_thtype_restore 0
+
 	devlink_pool_size_thtype_save 4
 	devlink_pool_size_thtype_set 4 dynamic 10000000
+	defer devlink_pool_size_thtype_restore 4
 
 	devlink_port_pool_th_save $swp1 0
 	devlink_port_pool_th_set $swp1 0 6
+	defer devlink_port_pool_th_restore $swp1 0
+
 	devlink_tc_bind_pool_th_save $swp1 1 ingress
 	devlink_tc_bind_pool_th_set $swp1 1 ingress 0 6
+	defer devlink_tc_bind_pool_th_restore $swp1 1 ingress
 
 	devlink_port_pool_th_save $swp2 0
 	devlink_port_pool_th_set $swp2 0 6
+	defer devlink_port_pool_th_restore $swp2 0
+
 	devlink_tc_bind_pool_th_save $swp2 2 ingress
 	devlink_tc_bind_pool_th_set $swp2 2 ingress 0 6
+	defer devlink_tc_bind_pool_th_restore $swp2 2 ingress
 
 	devlink_tc_bind_pool_th_save $swp3 1 egress
 	devlink_tc_bind_pool_th_set $swp3 1 egress 4 7
+	defer devlink_tc_bind_pool_th_restore $swp3 1 egress
+
 	devlink_tc_bind_pool_th_save $swp3 2 egress
 	devlink_tc_bind_pool_th_set $swp3 2 egress 4 7
+	defer devlink_tc_bind_pool_th_restore $swp3 2 egress
+
 	devlink_port_pool_th_save $swp3 4
 	devlink_port_pool_th_set $swp3 4 7
-}
-
-switch_destroy()
-{
-	devlink_port_pool_th_restore $swp3 4
-	devlink_tc_bind_pool_th_restore $swp3 2 egress
-	devlink_tc_bind_pool_th_restore $swp3 1 egress
-
-	devlink_tc_bind_pool_th_restore $swp2 2 ingress
-	devlink_port_pool_th_restore $swp2 0
-
-	devlink_tc_bind_pool_th_restore $swp1 1 ingress
-	devlink_port_pool_th_restore $swp1 0
-
-	devlink_pool_size_thtype_restore 4
-	devlink_pool_size_thtype_restore 0
-
-	ip link del dev br222
-	ip link del dev br111
-
-	vlan_destroy $swp3 222
-	vlan_destroy $swp3 111
-	vlan_destroy $swp2 222
-	vlan_destroy $swp1 111
-
-	tc qdisc del dev $swp3 root handle 101:
-	mtu_restore $swp3
-	ip link set dev $swp3 down
-	lldptool -T -i $swp3 -V ETS-CFG up2tc=0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0
-
-	mtu_restore $swp2
-	ip link set dev $swp2 down
-
-	mtu_restore $swp1
-	ip link set dev $swp1 down
+	defer devlink_port_pool_th_restore $swp3 4
 }
 
 setup_prepare()
@@ -224,6 +226,7 @@ setup_prepare()
 	h3mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -231,18 +234,6 @@ setup_prepare()
 	switch_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	switch_destroy
-	h3_destroy
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-}
-
 ping_ipv4()
 {
 	ping_test $h1 192.0.2.34 " from H1"
@@ -261,21 +252,38 @@ rel()
 	"
 }
 
+__run_hi_measure_rate()
+{
+	local what=$1; shift
+	local -a uc_rate
+
+	start_traffic $h2.222 192.0.2.65 192.0.2.66 $h3mac
+	defer stop_traffic $!
+
+	uc_rate=($(measure_rate $swp2 $h3 rx_octets_prio_2 "$what"))
+	check_err $? "Could not get high enough $what ingress rate"
+
+	echo ${uc_rate[@]}
+}
+
+run_hi_measure_rate()
+{
+	in_defer_scope __run_hi_measure_rate "$@"
+}
+
 test_ets_strict()
 {
 	RET=0
 
 	# Run high-prio traffic on its own.
-	start_traffic $h2.222 192.0.2.65 192.0.2.66 $h3mac
 	local -a rate_2
-	rate_2=($(measure_rate $swp2 $h3 rx_octets_prio_2 "prio 2"))
-	check_err $? "Could not get high enough prio-2 ingress rate"
+	rate_2=($(run_hi_measure_rate "prio 2"))
 	local rate_2_in=${rate_2[0]}
 	local rate_2_eg=${rate_2[1]}
-	stop_traffic # $h2.222
 
 	# Start low-prio stream.
 	start_traffic $h1.111 192.0.2.33 192.0.2.34 $h3mac
+	defer stop_traffic $!
 
 	local -a rate_1
 	rate_1=($(measure_rate $swp1 $h3 rx_octets_prio_1 "prio 1"))
@@ -290,14 +298,9 @@ test_ets_strict()
 	check_err $(bc <<< "$rel21 > 105")
 
 	# Start the high-prio stream--now both streams run.
-	start_traffic $h2.222 192.0.2.65 192.0.2.66 $h3mac
-	rate_3=($(measure_rate $swp2 $h3 rx_octets_prio_2 "prio 2 w/ 1"))
-	check_err $? "Could not get high enough prio-2 ingress rate with prio-1"
+	rate_3=($(run_hi_measure_rate "prio 2+1"))
 	local rate_3_in=${rate_3[0]}
 	local rate_3_eg=${rate_3[1]}
-	stop_traffic # $h2.222
-
-	stop_traffic # $h1.111
 
 	# High-prio should have about the same throughput whether or not
 	# low-prio is in the system.
-- 
2.45.0


