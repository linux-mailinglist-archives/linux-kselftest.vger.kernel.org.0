Return-Path: <linux-kselftest+bounces-20397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4839AB176
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E8D1C224F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E451A2562;
	Tue, 22 Oct 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZta4UsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D871A0BE0;
	Tue, 22 Oct 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608727; cv=fail; b=K/lF5FSr4uernpvplyxpJ/gyWLThO95SfGqDFzR4Z2igKDlc9h4Ve0C2cIAJSxmtnt4fI8BWgpeRy88CvQTVEd/uVPWGo0/u2vp6SVFhXYHwkhPef2RPORLuz+Tfynjzs/wyMvAbe11bj/JjW6cbAdP7CM6nyH4Y2UvEYZuCVgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608727; c=relaxed/simple;
	bh=w6vLrNc06EtXLU0weol+DYdC4k1JkQaPnfFHKrgNuj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDoYaiHNuOIVAdENCJAsyFJUATng3oVAHQtFASVy6wORD2C8xoia16AaCfHmUwzsIJfuoCdrWdVWceL75t9P3Fe9Kf/5NtbHQfYg7Es9JPytQIVjIEeqW6Ph7hAw6CiESQigudyfs0GtMW7wiAQYYhb15ThNynLbi5cgaITf5ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZta4UsD; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKjtbDN/qlKt7reKNei9Yi1LCnXy3yy/in3+3B76jCDKu+MVYT+mHyPWHmZ8jHfVrS7fVIOUbMKqugZInFsmbE8S8dv9/lOn6ZPNsBbHU1Dgl++Ofih4gsDhA6iiCzfhuyod/RaZThsOfn3epfD8dwejnLjU6I4jEexefH4nWOzeMfZpkN3upkVdTE5PI6A2XVcuLzOXjJIzE8Gx267mBI3S0RswOGgY9nUafoA++8Uz1f5CguBDEOc5dJA8lQzd4hkyQiIntR2xBDENo/BycSmAr3m3eKieNAxerJETRadknFlCpCn2gDsoSwClMLitcERJwpt58IM8ADGXMY7qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yO46m1wrD3vR22LA5vKZnXRrx/Xfxf/OgkDidzy+B4=;
 b=mQCCx8dV2TNpqEh/47bbYJqvVmM+RqM0EW8gD1O0olnH5ly41P3uN2Ax+QY+XIFQj8Ieq+IgH0dcWkO3HzCzwXwPLEUGFCsYFlVew5OKNy+5R5jhT/JPOa+Jr3wFFABzvm11W1o9lvFoJ9GL0Vi5L1GQVXze1NSEUKAzH3Wn33iLAL/QY/fYLnYYlU8rKMgL1sf3dzQjQmn52CBeV5aY5HWe5+AgqXKhrEMXP3iqm8cZZy6N5oXaPFJmvpiul8WsRujNco8OTgFdPipHIjNEveCWcnW59soQxABDz8zbNyUZqC5l+M/uaj7aHjZfrTrJt3V2XW+/hOBAogg64KYv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yO46m1wrD3vR22LA5vKZnXRrx/Xfxf/OgkDidzy+B4=;
 b=rZta4UsDtqzkcEsGAWMq6WXBGD8R1uKcFW2bEhQG1KMJJIkgKeuB/+38ZFpbixjI5LJvpQIagx77/T9fCEhGUmzBQz0Sf1aZ0hqlijycqQqU10XQScPMCxQOLALnWPOGsUGi8+GtSTSX0zldqDytxPJFttClAvSy4K9Ij1tzpKIuC6C1WrtluQlX2d8yVg2ER2fXQAP3S5J93Fwc4fvA/0mkhIYpLfFybuh52FmOHjPzx+KATLGr1LvLd9CCZ9GPUNBfS4dPb9hX0SukncL1YYCfCI3XKvI1REMdkQr/HiHhlSYQEE7Hr+MojryYklzSjo9eHJrgncsyjtj4og/8VA==
Received: from BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:52:00 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:117:cafe::7e) by BYAPR08CA0063.outlook.office365.com
 (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 14:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Tue, 22 Oct 2024 14:51:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:46 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next 7/8] selftests: net: lib: Add kill_process
Date: Tue, 22 Oct 2024 16:50:18 +0200
Message-ID: <53b69a578d52e69c5cecb897140523560a72a514.1729607879.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729607879.git.petrm@nvidia.com>
References: <cover.1729607879.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: d2660e60-f5ba-4afb-a9d3-08dcf2a91541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2HCEf/NhrCSR4TUR8+/BipjGO9s0LI5EuZihLnp8gFpMEGkmklYyK3rFIjoG?=
 =?us-ascii?Q?s/QEwLU3yw5iySsIsav8XQSrIev15R0ICMQpPnTl9DnAihzampUDhJcH2ShZ?=
 =?us-ascii?Q?NHr6c6FTGePkRv+WMdLiE8OF6NECOOeNOGOHhMPScM747OxcDTJGMe0Xk44v?=
 =?us-ascii?Q?3ngYhzW3Q1QdNHkiZuEl44ZRNQ9/Dk6Xq/3RAqM6mSa90JKOL3HZSyE89PND?=
 =?us-ascii?Q?euL/4Z4CYC1eGZ7ESPRYzv1ChE4A4ZUT8JomxC3TPEGiefX0mb3DsoU1ceEG?=
 =?us-ascii?Q?Bpgobhr93BRs9Unq6tPebHQq9ToFKgFNdplLgv1bd/ff2RhoUDQEGAUMZQN0?=
 =?us-ascii?Q?nDopoayNS41ICCVljPNZNuiHng5v155Q2M5KIFvKBQB6rXh/ISV71MFuCh1Y?=
 =?us-ascii?Q?6I82IEcjG2Z8x6P16prqcZQEGn/R1ETfo0qER/i1gTxRNvnWotOiH/H9VrS0?=
 =?us-ascii?Q?hFUqWnW6fKG8INQpltXBcIgZps/6pkd7kwfJflEclz0PjKHnspjiVUsXGlxy?=
 =?us-ascii?Q?TNPyr5q7rgmpJ2FnmnxW4vigIbKI3WXkhI34ADrddCeZW34n/ty1pfgn1+ow?=
 =?us-ascii?Q?aygpYO3fEC7UgYc7MLBveP1MtMS8sLDnc/K79pOStVxInyWbGfmf2P+h1s27?=
 =?us-ascii?Q?wS0SgOnoxtidph0ma4j8D3RY4TRg8VwJ4It5z4tnqZhjjLhEye6+HHS+MgGZ?=
 =?us-ascii?Q?nXvx6Kcfv9HNwEU8OBGB2Dbo6NZEM+i433YPw8LWwV4VBLEpwbz6TCYCUA6a?=
 =?us-ascii?Q?kdqgZ7eur/CQeP+PhA71P60724PJdRdJT3us5bt7P/sy57CuMSjSgJE0cf6M?=
 =?us-ascii?Q?j1dOtO8ulGcU+wuIFG1R4xvuwIpJGwD98M/Rv+ptR8RZhPYK1SFn0CBx15B3?=
 =?us-ascii?Q?pILmh9CVkuTTVoPlpB+mRp7s0YR6Ykuxcu+Q/DTjb9XnUbySziYUWIJ9n8QY?=
 =?us-ascii?Q?4ZCsvdLWe1aAxIDUfB07yCqSAVAGMEmYrt7/Bup9SCIOZSo6mR6hVB9OdKy8?=
 =?us-ascii?Q?tbhMClcfwtEWY5E4NS6QcIT7zUgm4qgtDAoNLbXqwC0Gq/LPYSV26AKjMhGS?=
 =?us-ascii?Q?QNEH6VvAAFpSwQnUliSMHrZmi/26bMCiwF2e05pKWyr8Ema5jBKpKL19Cix1?=
 =?us-ascii?Q?y86YTt7L7HtS1QE/qeXjxU63mGTJ5PTB/NeHUI1NhbdZoTjGzhTpAJxTfweZ?=
 =?us-ascii?Q?cOYwuJlQDItBls00MVIXjIZh7qGOlCgqHFwbEDLYYpyfiCicTOdEFmCRJOLp?=
 =?us-ascii?Q?zE2LiCKQ8ZQRH54JHme+JGG6ZdtGqtqPHWr3mEylQ/c00f3/KiJikChsAZS8?=
 =?us-ascii?Q?Ligk0sb0g0VIK0RT3MLikh01sl9kX73IqAbhWh3GbNB9GYDYhdCrbPqwwebK?=
 =?us-ascii?Q?YQX2cVrVGJM+Qd72VlUbTnIY2381WIZGZJef6S9DFNPVQWlhcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:51:59.8381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2660e60-f5ba-4afb-a9d3-08dcf2a91541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698

A number of selftests run processes in the background and need to kill them
afterwards. Instead for everyone to open-code the kill / wait / redirect
mantra, add a helper in net/lib.sh. Convert existing open-code sites.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
---
 .../selftests/drivers/net/mlxsw/devlink_trap.sh      |  2 +-
 .../drivers/net/mlxsw/devlink_trap_l3_drops.sh       |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_l3_exceptions.sh  | 12 ++++++------
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh    |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh   |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh   |  4 ++--
 .../net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh      |  4 ++--
 .../testing/selftests/drivers/net/mlxsw/tc_sample.sh |  4 ++--
 .../drivers/net/netdevsim/fib_notifications.sh       |  6 +++---
 tools/testing/selftests/net/drop_monitor_tests.sh    |  2 +-
 tools/testing/selftests/net/fib_tests.sh             |  8 ++++----
 .../testing/selftests/net/forwarding/devlink_lib.sh  |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh        |  3 +--
 tools/testing/selftests/net/forwarding/tc_police.sh  |  8 ++++----
 tools/testing/selftests/net/lib.sh                   |  8 ++++++++
 15 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
index 89b55e946eed..36055279ba92 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
@@ -116,7 +116,7 @@ dev_del_test()
 
 	log_test "Device delete"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
index 160891dcb4bc..db5806d189bb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
@@ -595,7 +595,7 @@ irif_disabled_test()
 
 	log_test "Ingress RIF disabled"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	ip link set dev $rp1 nomaster
 	__addr_add_del $rp1 add 192.0.2.2/24 2001:db8:1::2/64
 	ip link del dev br0 type bridge
@@ -645,7 +645,7 @@ erif_disabled_test()
 
 	log_test "Egress RIF disabled"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	__addr_add_del $rp1 add 192.0.2.2/24 2001:db8:1::2/64
 	ip link del dev br0 type bridge
 	devlink_trap_action_set $trap_name "drop"
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
index 190c1b6b5365..5d6d88b600f0 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
@@ -202,7 +202,7 @@ mtu_value_is_too_small_test()
 
 	mtu_restore $rp2
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $h1 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -235,7 +235,7 @@ __ttl_value_is_too_small_test()
 
 	log_test "TTL value is too small: TTL=$ttl_val"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $h1 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -299,7 +299,7 @@ __mc_reverse_path_forwarding_test()
 
 	log_test "Multicast reverse path forwarding: $desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $rp2 egress protocol $proto pref 1 handle 101 flower
 }
 
@@ -347,7 +347,7 @@ __reject_route_test()
 
 	log_test "Reject route: $desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	ip route del unreachable $unreachable
 	tc filter del dev $h1 ingress protocol $proto pref 1 handle 101 flower
 }
@@ -542,7 +542,7 @@ ipv4_lpm_miss_test()
 
 	log_test "LPM miss: IPv4"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	vrf_without_routes_destroy
 }
 
@@ -569,7 +569,7 @@ ipv6_lpm_miss_test()
 
 	log_test "LPM miss: IPv6"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	vrf_without_routes_destroy
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
index e9a82cae8c9a..4ac1dae92d0f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
@@ -176,7 +176,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
@@ -207,7 +207,7 @@ no_matching_tunnel_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
index 878125041fc3..fce885184404 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
@@ -176,7 +176,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
@@ -207,7 +207,7 @@ no_matching_tunnel_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
index 5f6eb965cfd1..7aca8e5922cf 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
@@ -183,7 +183,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
@@ -253,7 +253,7 @@ corrupted_packet_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
index f6c16cbb6cf7..4599c331240b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
@@ -188,7 +188,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
@@ -262,7 +262,7 @@ corrupted_packet_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh b/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
index 83a0210e7544..bc7ea2df49fb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
@@ -218,7 +218,7 @@ psample_capture_start()
 
 psample_capture_stop()
 {
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 }
 
 __tc_sample_rate_test()
@@ -499,7 +499,7 @@ tc_sample_md_out_tc_occ_test()
 	backlog=$(tc -j -p -s qdisc show dev $rp2 | jq '.[0]["backlog"]')
 
 	# Kill mausezahn.
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	psample_capture_stop
 
diff --git a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
index 8d91191a098c..9896580c3d85 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
@@ -94,7 +94,7 @@ route_addition_check()
 	sleep 1
 	$IP route add $route dev dummy1
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications $offload_failed
 	rm -f $outfile
@@ -148,7 +148,7 @@ route_deletion_check()
 	sleep 1
 	$IP route del $route dev dummy1
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications
 	rm -f $outfile
@@ -191,7 +191,7 @@ route_replacement_check()
 	sleep 1
 	$IP route replace $route dev dummy2
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications
 	rm -f $outfile
diff --git a/tools/testing/selftests/net/drop_monitor_tests.sh b/tools/testing/selftests/net/drop_monitor_tests.sh
index 7c4818c971fc..507d0a82f5f0 100755
--- a/tools/testing/selftests/net/drop_monitor_tests.sh
+++ b/tools/testing/selftests/net/drop_monitor_tests.sh
@@ -77,7 +77,7 @@ sw_drops_test()
 
 	rm ${dir}/packets.pcap
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	timeout 5 dwdump -o sw -w ${dir}/packets.pcap
 	(( $(tshark -r ${dir}/packets.pcap \
 		-Y 'ip.dst == 192.0.2.10' 2> /dev/null | wc -l) == 0))
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 5f3c28fc8624..3ea6f886a210 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -689,7 +689,7 @@ fib6_notify_test()
 
 	log_test $ret 0 "ipv6 route add notify"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	#rm errors.txt
 
@@ -736,7 +736,7 @@ fib_notify_test()
 
 	log_test $ret 0 "ipv4 route add notify"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	rm  errors.txt
 
@@ -2328,7 +2328,7 @@ ipv4_mangle_test()
 	$IP route del table 123 172.16.101.0/24 dev veth1
 	$IP rule del pref 100
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	rm $tmp_file
 
 	route_cleanup
@@ -2386,7 +2386,7 @@ ipv6_mangle_test()
 	$IP -6 route del table 123 2001:db8:101::/64 dev veth1
 	$IP -6 rule del pref 100
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	rm $tmp_file
 
 	route_cleanup
diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 62a05bca1e82..18afa89ebbcc 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -501,7 +501,7 @@ devlink_trap_drop_cleanup()
 	local pref=$1; shift
 	local handle=$1; shift
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $dev egress protocol $proto pref $pref handle $handle flower
 }
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8625e3c99f55..7337f398f9cc 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1574,8 +1574,7 @@ stop_traffic()
 {
 	local pid=${1-%%}; shift
 
-	# Suppress noise from killing mausezahn.
-	{ kill $pid && wait $pid; } 2>/dev/null
+	kill_process "$pid"
 }
 
 declare -A cappid
diff --git a/tools/testing/selftests/net/forwarding/tc_police.sh b/tools/testing/selftests/net/forwarding/tc_police.sh
index 5103f64a71d6..509fdedfcfa1 100755
--- a/tools/testing/selftests/net/forwarding/tc_police.sh
+++ b/tools/testing/selftests/net/forwarding/tc_police.sh
@@ -148,7 +148,7 @@ police_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -198,7 +198,7 @@ police_shared_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 }
 
 police_shared_test()
@@ -278,7 +278,7 @@ police_mirror_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $pol_if $dir protocol ip pref 1 handle 101 flower
 	tc filter del dev $h3 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
@@ -320,7 +320,7 @@ police_pps_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 6bcf5d13879d..24f63e45735d 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -434,3 +434,11 @@ xfail_on_veth()
 		"$@"
 	fi
 }
+
+kill_process()
+{
+	local pid=$1; shift
+
+	# Suppress noise from killing the process.
+	{ kill $pid && wait $pid; } 2>/dev/null
+}
-- 
2.45.0


