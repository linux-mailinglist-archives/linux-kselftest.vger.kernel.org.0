Return-Path: <linux-kselftest+bounces-19342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FC99699E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33C3B217F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4C192D6A;
	Wed,  9 Oct 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rgxxqW/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B683190072;
	Wed,  9 Oct 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475806; cv=fail; b=OkOQaU8WqBL6vLP3nCcaART8Opy743k+VTaXUac9dIwPA2CM13nZIoK5GbUMgPcQ7oip1/j//d+01kndTC6L51snRTrvk/LcUvHvDNLpB4MqRY3lo9odyFznbvwdKtnq8avcYJIclEMjwL5rzMhP5ngKdLUilMI4KBMgi+HVSJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475806; c=relaxed/simple;
	bh=8FeHgnu8XPZFIQPh46hfO1wL67MoXO2GmCilOZvv0hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilVTGILufsbby6tuOJtGauktIOvRDLsk35Tf5fN95XwpONJPhFR9OYzsTMn5KsT18EcT0Npx5sl9A1Ka4Y2Yk6xQADYtuBds9S758MEdUXE5YC0UANOKiHP3pvjcXHotUTAKSQoDgR76XUdQJJOL8HlFfKHP0pUKd6dwcnPYKTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rgxxqW/1; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVh63GZAa/ev0fo2fJ3go4WmTISbtsuP/rb0+RTG0X5L/pe9a8Klib1K8DC2cYfltp0+T6iJLkiJuisliP0RM8BEf/os/Ek9SHDmgUp0U9j+wgW8EG1LzS9VmqegGKpm2lpYeKGY66NNdwnKK6P7+YIK4axJNvKzO/KTDbQUkM7cQQikD5TWcHx91dzZM7oRRsCvoUrIxNcNMDyk0kpObzaWdcMth5qApia1YMgb1pCjfuwXkhhbOfHhFa3rRUtS/fjn4UREL7/W8btwaC0ivdfGLkBOCqXbDbdIgd3kguN21fDpwDqW4gbKg+/AwOINF9OCQCgXLFkyqBK02Wfj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdTTnlYBHQlQHID0X87dRqC1r0FasPlp7JtQZQzKR4s=;
 b=YqI1I+w5GNoOWIZvw6++clP9dMRQJ0GveQFw3Uk9Wt3qFmMsoJ/Dk8ujbguGTmtwxsrzLvBIR3M+sLuOBYJTXrwW2GRxixEyCvYR7XPVuACx1fz7O5d3CV5M2zain2Q0gP9uH/ouDMzL3mq8/Ty07XqjyAsThYGii4nViEYmts4GJLiWSWWLoa2MozKwohXPj7r88a3kLQMTXMnRvGUixJuLK9VNUMBOa2uSSkDXKRbrdA9hT7G3lT/rYXGJmyESgg9MFYtnTR4WU1x+O4lMvVp+Zt4mSUO0ExEYDgxsNonzm7B3B/It+VF/UjeYgVBoa3FUSRwFKCeNRcHyOHDH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdTTnlYBHQlQHID0X87dRqC1r0FasPlp7JtQZQzKR4s=;
 b=rgxxqW/1Cvz1l61g9Q75kALM935eDq711a1cef3Yf2iZhJY1p08z1Ke1gOzYXPiO4KoAeMZFvdB2f7nP2Nc1NixKk67G2gE3ombf3BzXWdiLXG+Tybm2Sid2yGclvNOwLhaaCq3nza9MPzXiE8CZyYyInckiMAP6FuKxMmyMLod4zm57tRzSbIwdqokx+ADndiPgnrmZCVttFnyc3SDNG/3N5e3+Hnrls6yGTDONBf1DYgrgCSVOYaedzGQ17obsHwcsbep04j/quO4cstWfeGI4I6bVdto1tiBemASuDHKkRS/BuNyNdKBdYN/Rk1rQ97MSU4qtAwcBY5swyI47uw==
Received: from CH3P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::28)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:09:57 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::15) by CH3P221CA0027.outlook.office365.com
 (2603:10b6:610:1e7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:09:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:43 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/10] selftests: RED: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:22 +0200
Message-ID: <4a9b24fa7e582bdf457b550bb27bb1e227f05b48.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: ba746ed9-b426-47b9-8c1f-08dce85b4a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7/bEZrdwDhBGiq7pP4pT1O1v4EF8kPI9XnQ3MAd+7mcDMmHngoksOFH6wpf?=
 =?us-ascii?Q?DQNmeHdmCydgJ0xzK7ChOFIlukh5LlkX84F1qd2x7hw4s0FwWg5ZNMz/QRxA?=
 =?us-ascii?Q?x7WhkQkLa02f4Ze1DHnbWsQvv3OkBANjebsCAJGOjbOpUqXrcNzrZ5GjWYq1?=
 =?us-ascii?Q?eFdt3PLpf0vjbhNb9xCqMWZWefGe4XQEfiW0M16iWQc3vbWoqVm9wReaWZZC?=
 =?us-ascii?Q?JotYFqUT5qTIH3btRW/vf0Oe+IJFo7EQJl0K1M0KR4T+Xl9SWI4D5yHkiEVX?=
 =?us-ascii?Q?v08tE8BKgEFk7KUQg9G0feo1vRSrZc66fo958CQblmKbqvGsco35pT427hIE?=
 =?us-ascii?Q?ptk5o7fvkbZAfI0B5nlrtwaTF9AJwftHnIhrCRa0lqa6Efoy+rXXdaayS3EF?=
 =?us-ascii?Q?Sni9SHZrabIPW8gcNgQ/1k5ByQ2BTT6WqNB/E0di74/sNU8UW9DPFQnfiudw?=
 =?us-ascii?Q?MdEwnBAwYotsvIzgyqY8oyA88q054m6zK9c9kaPobo3lv4fxDa218PkKG6iM?=
 =?us-ascii?Q?WQMbEvrZR+lkA63XJ9VSRfnJ7+QanVJv6ecu22gSkQzwWvE1BWtdkmIvQrSk?=
 =?us-ascii?Q?Czx41KP/U+3XrhJyPpztdm++8uCsoFE3y8ozJiNQgrinwauGYivhyvafJWVO?=
 =?us-ascii?Q?x96jwBzoDIcsYbk/JuNpgf1FVdjw1GWdNtxHr7R5ZszyluXqxgHvT9mH3oa3?=
 =?us-ascii?Q?HTIkgjNst8EKihmELws9xieNeJYfo8xkgD5n4BRzkezxD8xLMnRKEQJdEqRU?=
 =?us-ascii?Q?BzaFrVD9O061NcNis76GKVBOAw7ecEab5faYWENa00d2u7DSt7kzSECrXv8H?=
 =?us-ascii?Q?NAcezdzIfhocFFkEL41vDdc9tq8fovhDVg1W+Ul4xrkSiioXVx+RTTgcsM4B?=
 =?us-ascii?Q?WaAqyapESn+3SL0N2bWRbq7q+1GWMUkv2ZlHweaSrfH+4MtWOt7yFOqLHd+k?=
 =?us-ascii?Q?QLM4G1X7I3d5Nn79SmAXsz0zOQhwHQGa2/mYCo6rJKwE9X+e2Ea2TaGmOCOo?=
 =?us-ascii?Q?vjQdPTeWlC/ZDO4gLNfp/OHFcJDkA1T8E19JO8ZuP2aRbUw/UZvSyaO/eD0V?=
 =?us-ascii?Q?uIWURF6KuygGQ7PEMp/EJhEQw92z6IRhCsbP5N6mMmSH0ZTojjtxBL7tlQU1?=
 =?us-ascii?Q?/lqDZtXYhgr037NMw3MzjN5FuOEvSKeEa7MYwYMCsZXuAGupt0BdqR0UuT9v?=
 =?us-ascii?Q?w4/+KYtme3yKdCtCvKcQKG/RsSyu6mTJ5x82LbygX06YAnJfVGkNOiM2WC/E?=
 =?us-ascii?Q?kKXgMdJ4JbrJF+456a2Rc8Jv9mfcUXOC5no4123QN8qoiyCor4nmlh/C2UN2?=
 =?us-ascii?Q?l/LlSW1DGIY+QIomv+u8xVtrzYVFO+2YYMOZZawZ9vqA2M8qvvHIuATsPGq2?=
 =?us-ascii?Q?cT5Q1nmfxbd3Vsg+znVpm/k2WHo1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:09:56.7902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba746ed9-b426-47b9-8c1f-08dce85b4a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

Instead of having a suite of dedicated cleanup functions, use the defer
framework to schedule cleanups right as their setup functions are run.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/sch_red_core.sh         | 171 +++++++++---------
 .../drivers/net/mlxsw/sch_red_ets.sh          |  24 +--
 .../drivers/net/mlxsw/sch_red_root.sh         |  18 +-
 .../selftests/net/forwarding/sch_red.sh       | 103 ++++-------
 4 files changed, 141 insertions(+), 175 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index f4c324957dcc..4282142c8eca 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -89,39 +89,31 @@ host_create()
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
+
 	tc qdisc add dev $h2 clsact
+	defer tc qdisc del dev $h2 clsact
 
 	# Some of the tests in this suite use multicast traffic. As this traffic
 	# enters BR2_10 resp. BR2_11, it is flooded to all other ports. Thus
@@ -139,13 +131,7 @@ h2_create()
 
 	tc qdisc replace dev $h2 root handle 10: tbf rate 200mbit \
 		burst 128K limit 1G
-}
-
-h2_destroy()
-{
-	tc qdisc del dev $h2 root handle 10:
-	tc qdisc del dev $h2 clsact
-	host_destroy $h2
+	defer tc qdisc del dev $h2 root handle 10:
 }
 
 h3_create()
@@ -153,40 +139,54 @@ h3_create()
 	host_create $h3 3
 }
 
-h3_destroy()
-{
-	host_destroy $h3
-}
-
 switch_create()
 {
 	local intf
 	local vlan
 
 	ip link add dev br1_10 type bridge
+	defer ip link del dev br1_10
+
 	ip link add dev br1_11 type bridge
+	defer ip link del dev br1_11
 
 	ip link add dev br2_10 type bridge
+	defer ip link del dev br2_10
+
 	ip link add dev br2_11 type bridge
+	defer ip link del dev br2_11
 
 	for intf in $swp1 $swp2 $swp3 $swp4 $swp5; do
 		ip link set dev $intf up
+		defer ip link set dev $intf down
+
 		mtu_set $intf 10000
+		defer mtu_restore $intf
 	done
 
 	for intf in $swp1 $swp4; do
 		for vlan in 10 11; do
 			vlan_create $intf $vlan
+			defer vlan_destroy $intf $vlan
+
 			ip link set dev $intf.$vlan master br1_$vlan
+			defer ip link set dev $intf.$vlan nomaster
+
 			ip link set dev $intf.$vlan up
+			defer ip link set dev $intf.$vlan up
 		done
 	done
 
 	for intf in $swp2 $swp3 $swp5; do
 		for vlan in 10 11; do
 			vlan_create $intf $vlan
+			defer vlan_destroy $intf $vlan
+
 			ip link set dev $intf.$vlan master br2_$vlan
+			defer ip link set dev $intf.$vlan nomaster
+
 			ip link set dev $intf.$vlan up
+			defer ip link set dev $intf.$vlan up
 		done
 	done
 
@@ -201,49 +201,25 @@ switch_create()
 	for intf in $swp3 $swp4; do
 		tc qdisc replace dev $intf root handle 1: tbf rate 200mbit \
 			burst 128K limit 1G
+		defer tc qdisc del dev $intf root handle 1:
 	done
 
 	ip link set dev br1_10 up
+	defer ip link set dev br1_10 down
+
 	ip link set dev br1_11 up
+	defer ip link set dev br1_11 down
+
 	ip link set dev br2_10 up
+	defer ip link set dev br2_10 down
+
 	ip link set dev br2_11 up
+	defer ip link set dev br2_11 down
 
 	local size=$(devlink_pool_size_thtype 0 | cut -d' ' -f 1)
 	devlink_port_pool_th_save $swp3 8
 	devlink_port_pool_th_set $swp3 8 $size
-}
-
-switch_destroy()
-{
-	local intf
-	local vlan
-
-	devlink_port_pool_th_restore $swp3 8
-
-	ip link set dev br2_11 down
-	ip link set dev br2_10 down
-	ip link set dev br1_11 down
-	ip link set dev br1_10 down
-
-	for intf in $swp4 $swp3; do
-		tc qdisc del dev $intf root handle 1:
-	done
-
-	for intf in $swp5 $swp3 $swp2 $swp4 $swp1; do
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
-	ip link del dev br2_11
-	ip link del dev br2_10
-	ip link del dev br1_11
-	ip link del dev br1_10
+	defer devlink_port_pool_th_restore $swp3 8
 }
 
 setup_prepare()
@@ -263,6 +239,7 @@ setup_prepare()
 	h3_mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -270,18 +247,6 @@ setup_prepare()
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
 	ping_test $h1.10 $(ipaddr 3 10) " from host 1, vlan 10"
@@ -450,6 +415,7 @@ __do_ecn_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic $!
 	sleep 1
 
 	ecn_test_common "$name" "$get_nmarked" $vlan $limit
@@ -462,7 +428,6 @@ __do_ecn_test()
 	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
 	log_test "TC $((vlan - 10)): $name backlog > limit: UDP early-dropped"
 
-	stop_traffic
 	sleep 1
 }
 
@@ -471,7 +436,8 @@ do_ecn_test()
 	local vlan=$1; shift
 	local limit=$1; shift
 
-	__do_ecn_test get_nmarked "$vlan" "$limit"
+	in_defer_scope \
+		__do_ecn_test get_nmarked "$vlan" "$limit"
 }
 
 do_ecn_test_perband()
@@ -480,10 +446,11 @@ do_ecn_test_perband()
 	local limit=$1; shift
 
 	mlxsw_only_on_spectrum 3+ || return
-	__do_ecn_test get_qdisc_nmarked "$vlan" "$limit" "per-band ECN"
+	in_defer_scope \
+		__do_ecn_test get_qdisc_nmarked "$vlan" "$limit" "per-band ECN"
 }
 
-do_ecn_nodrop_test()
+__do_ecn_nodrop_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -491,6 +458,7 @@ do_ecn_nodrop_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic $!
 	sleep 1
 
 	ecn_test_common "$name" get_nmarked $vlan $limit
@@ -503,11 +471,16 @@ do_ecn_nodrop_test()
 	check_err $? "UDP traffic was early-dropped instead of getting into backlog"
 	log_test "TC $((vlan - 10)): $name backlog > limit: UDP not dropped"
 
-	stop_traffic
 	sleep 1
 }
 
-do_red_test()
+do_ecn_nodrop_test()
+{
+	in_defer_scope \
+		__do_ecn_nodrop_test "$@"
+}
+
+__do_red_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -518,6 +491,7 @@ do_red_test()
 	# is above limit.
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic $!
 
 	# Pushing below the queue limit should work.
 	RET=0
@@ -540,11 +514,16 @@ do_red_test()
 	check_err $? "backlog $backlog / $limit expected <= 15% distance"
 	log_test "TC $((vlan - 10)): RED backlog > limit"
 
-	stop_traffic
 	sleep 1
 }
 
-do_mc_backlog_test()
+do_red_test()
+{
+	in_defer_scope \
+		__do_red_test "$@"
+}
+
+__do_mc_backlog_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -554,7 +533,10 @@ do_mc_backlog_test()
 	RET=0
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) bc
+	defer stop_traffic $!
+
 	start_tcp_traffic $h2.$vlan $(ipaddr 2 $vlan) $(ipaddr 3 $vlan) bc
+	defer stop_traffic $!
 
 	qbl=$(busywait 5000 until_counter_is ">= 500000" \
 		       get_qdisc_backlog $vlan)
@@ -567,13 +549,16 @@ do_mc_backlog_test()
 		       get_mc_transmit_queue $vlan)
 	check_err $? "MC backlog reported by qdisc not visible in ethtool"
 
-	stop_traffic
-	stop_traffic
-
 	log_test "TC $((vlan - 10)): Qdisc reports MC backlog"
 }
 
-do_mark_test()
+do_mc_backlog_test()
+{
+	in_defer_scope \
+		__do_mc_backlog_test "$@"
+}
+
+__do_mark_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -588,6 +573,7 @@ do_mark_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic $!
 
 	# Create a bit of a backlog and observe no mirroring due to marks.
 	qevent_rule_install_$subtest
@@ -618,11 +604,16 @@ do_mark_test()
 		log_test "TC $((vlan - 10)): marked packets $subtest'd"
 	fi
 
-	stop_traffic
 	sleep 1
 }
 
-do_drop_test()
+do_mark_test()
+{
+	in_defer_scope \
+		__do_mark_test "$@"
+}
+
+__do_drop_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -637,6 +628,7 @@ do_drop_test()
 	RET=0
 
 	start_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) $h3_mac
+	defer stop_traffic $!
 
 	# Create a bit of a backlog and observe no mirroring due to drops.
 	qevent_rule_install_$subtest
@@ -672,10 +664,15 @@ do_drop_test()
 
 	log_test "TC $((vlan - 10)): ${trigger}ped packets $subtest'd"
 
-	stop_traffic
 	sleep 1
 }
 
+do_drop_test()
+{
+	in_defer_scope \
+		__do_drop_test "$@"
+}
+
 qevent_rule_install_mirror()
 {
 	tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
index 576067b207a8..8902a115d9cd 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
@@ -80,36 +80,34 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 
 	do_ecn_test 10 $BACKLOG1
 	do_ecn_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 ecn_test_perband()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 
 	do_ecn_test_perband 10 $BACKLOG1
 	do_ecn_test_perband 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
 
 	do_ecn_nodrop_test 10 $BACKLOG1
 	do_ecn_nodrop_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 
 	# Make sure that we get the non-zero value if there is any.
 	local cur=$(busywait 1100 until_counter_is "> 0" \
@@ -120,50 +118,44 @@ red_test()
 
 	do_red_test 10 $BACKLOG1
 	do_red_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 mc_backlog_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 
 	# Note that the backlog numbers here do not correspond to RED
 	# configuration, but are arbitrary.
 	do_mc_backlog_test 10 $BACKLOG1
 	do_mc_backlog_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 red_mirror_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 
 	do_drop_mirror_test 10 $BACKLOG1 early_drop
 	do_drop_mirror_test 11 $BACKLOG2 early_drop
-
-	uninstall_qdisc
 }
 
 red_trap_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 
 	do_drop_trap_test 10 $BACKLOG1 early_drop
 	do_drop_trap_test 11 $BACKLOG2 early_drop
-
-	uninstall_qdisc
 }
 
 ecn_mirror_test()
 {
 	install_qdisc ecn qevent mark block 10
+	defer uninstall_qdisc
 
 	do_mark_mirror_test 10 $BACKLOG1
 	do_mark_mirror_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 bail_on_lldpad "configure DCB" "configure Qdiscs"
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
index 159108d02895..e9043771787b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
@@ -32,45 +32,51 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
+
 	do_ecn_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_test_perband()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
+
 	do_ecn_test_perband 10 $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
+
 	do_ecn_nodrop_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
+
 	do_red_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 mc_backlog_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
+
 	# Note that the backlog value here does not correspond to RED
 	# configuration, but is arbitrary.
 	do_mc_backlog_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 red_mirror_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
+
 	do_drop_mirror_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 bail_on_lldpad "configure DCB" "configure Qdiscs"
diff --git a/tools/testing/selftests/net/forwarding/sch_red.sh b/tools/testing/selftests/net/forwarding/sch_red.sh
index 17f28644568e..af166662b78a 100755
--- a/tools/testing/selftests/net/forwarding/sch_red.sh
+++ b/tools/testing/selftests/net/forwarding/sch_red.sh
@@ -53,71 +53,63 @@ PKTSZ=1400
 h1_create()
 {
 	simple_if_init $h1 192.0.2.1/28
+	defer simple_if_fini $h1 192.0.2.1/28
+
 	mtu_set $h1 10000
+	defer mtu_restore $h1
+
 	tc qdisc replace dev $h1 root handle 1: tbf \
 	   rate 10Mbit burst 10K limit 1M
-}
-
-h1_destroy()
-{
-	tc qdisc del dev $h1 root
-	mtu_restore $h1
-	simple_if_fini $h1 192.0.2.1/28
+	defer tc qdisc del dev $h1 root
 }
 
 h2_create()
 {
 	simple_if_init $h2 192.0.2.2/28
+	defer simple_if_fini $h2 192.0.2.2/28
+
 	mtu_set $h2 10000
-}
-
-h2_destroy()
-{
-	mtu_restore $h2
-	simple_if_fini $h2 192.0.2.2/28
+	defer mtu_restore $h2
 }
 
 h3_create()
 {
 	simple_if_init $h3 192.0.2.3/28
+	defer simple_if_fini $h3 192.0.2.3/28
+
 	mtu_set $h3 10000
-}
-
-h3_destroy()
-{
-	mtu_restore $h3
-	simple_if_fini $h3 192.0.2.3/28
+	defer mtu_restore $h3
 }
 
 switch_create()
 {
 	ip link add dev br up type bridge
+	defer ip link del dev br
+
 	ip link set dev $swp1 up master br
+	defer ip link set dev $swp1 down nomaster
+
 	ip link set dev $swp2 up master br
+	defer ip link set dev $swp2 down nomaster
+
 	ip link set dev $swp3 up master br
+	defer ip link set dev $swp3 down nomaster
 
 	mtu_set $swp1 10000
+	defer mtu_restore $h1
+
 	mtu_set $swp2 10000
+	defer mtu_restore $h2
+
 	mtu_set $swp3 10000
+	defer mtu_restore $h3
 
 	tc qdisc replace dev $swp3 root handle 1: tbf \
 	   rate 10Mbit burst 10K limit 1M
+	defer tc qdisc del dev $swp3 root
+
 	ip link add name _drop_test up type dummy
-}
-
-switch_destroy()
-{
-	ip link del dev _drop_test
-	tc qdisc del dev $swp3 root
-
-	mtu_restore $h3
-	mtu_restore $h2
-	mtu_restore $h1
-
-	ip link set dev $swp3 down nomaster
-	ip link set dev $swp2 down nomaster
-	ip link set dev $swp1 down nomaster
-	ip link del dev br
+	defer ip link del dev _drop_test
 }
 
 setup_prepare()
@@ -134,6 +126,7 @@ setup_prepare()
 	h3_mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -141,18 +134,6 @@ setup_prepare()
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
 	ping_test $h1 192.0.2.3 " from host 1"
@@ -287,6 +268,7 @@ do_ecn_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 	sleep 1
 
 	ecn_test_common "$name" $limit
@@ -298,9 +280,6 @@ do_ecn_test()
 	build_backlog $((2 * limit)) udp >/dev/null
 	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
 	log_test "$name backlog > limit: UDP early-dropped"
-
-	stop_traffic
-	sleep 1
 }
 
 do_ecn_nodrop_test()
@@ -310,6 +289,7 @@ do_ecn_nodrop_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 	sleep 1
 
 	ecn_test_common "$name" $limit
@@ -321,9 +301,6 @@ do_ecn_nodrop_test()
 	build_backlog $((2 * limit)) udp >/dev/null
 	check_err $? "UDP traffic was early-dropped instead of getting into backlog"
 	log_test "$name backlog > limit: UDP not dropped"
-
-	stop_traffic
-	sleep 1
 }
 
 do_red_test()
@@ -336,6 +313,7 @@ do_red_test()
 	# is above limit.
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 
 	# Pushing below the queue limit should work.
 	RET=0
@@ -352,9 +330,6 @@ do_red_test()
 	pct=$(check_marking "== 0")
 	check_err $? "backlog $backlog / $limit Got $pct% marked packets, expected == 0."
 	log_test "RED backlog > limit"
-
-	stop_traffic
-	sleep 1
 }
 
 do_red_qevent_test()
@@ -369,6 +344,7 @@ do_red_qevent_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t udp -q &
+	defer stop_traffic $!
 	sleep 1
 
 	tc filter add block 10 pref 1234 handle 102 matchall skip_hw \
@@ -396,9 +372,6 @@ do_red_qevent_test()
 	check_err $? "Dropped packets still observed: 0 expected, $((now - base)) seen"
 
 	log_test "RED early_dropped packets mirrored"
-
-	stop_traffic
-	sleep 1
 }
 
 do_ecn_qevent_test()
@@ -410,6 +383,7 @@ do_ecn_qevent_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 	sleep 1
 
 	tc filter add block 10 pref 1234 handle 102 matchall skip_hw \
@@ -428,9 +402,6 @@ do_ecn_qevent_test()
 	tc filter del block 10 pref 1234 handle 102 matchall
 
 	log_test "ECN marked packets mirrored"
-
-	stop_traffic
-	sleep 1
 }
 
 install_qdisc()
@@ -451,36 +422,36 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 	xfail_on_slow do_ecn_test $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
 	xfail_on_slow do_ecn_nodrop_test $BACKLOG
-	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 	xfail_on_slow do_red_test $BACKLOG
-	uninstall_qdisc
 }
 
 red_qevent_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 	xfail_on_slow do_red_qevent_test $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_qevent_test()
 {
 	install_qdisc ecn qevent mark block 10
+	defer uninstall_qdisc
 	xfail_on_slow do_ecn_qevent_test $BACKLOG
-	uninstall_qdisc
 }
 
 trap cleanup EXIT
-- 
2.45.0


