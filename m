Return-Path: <linux-kselftest+bounces-21794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB449C4349
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C61F21BF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9161A4F2D;
	Mon, 11 Nov 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YmsOxvmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67425184556;
	Mon, 11 Nov 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345149; cv=fail; b=eLU8QKQzEmzi55Tl9nKpI2EGk3vG1qfkcgObB36RLJ4SVxpSHUSGtD0vf1b+dd2c8tXgv1N2Mp4w2xopYThQcjrHX1jGc9jB+Gpun6+sNLtohgKNVNZqV2ZlfHzKamsFcnG/B+zHmbCuIKVw4C/Th6s+Vux0eAPd3NU2O/Y3TBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345149; c=relaxed/simple;
	bh=792cE3F7FT7Q8JnDuxa7P2ra7m8ilj9UEgxnE1f0haE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZmhnP2SNnxtJLCQwOIo8K1Qq41zSji0aBRIaGXhvXdus8AB4E7pZGEbjt6n/IoucgtVv5Wk2tr9FvR8oRJI00PwKQnSCU5NsVBJxUChMA6+jy064o+Dh4XWatN5HVBnhpw068dqV/PQBZSCp5W63S5TZ7Ev8pED52kdSY36D70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YmsOxvmn; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiMjB1r0o7o7/khb4Wzh+/thlMTVSGXc+Wjdferil+Ttmk47yIb0ud8orXFBJkZp2dH/a3Yynrm/J/YQBOBbofgEl2p6XWBjdDlgew9xDvr5653JQlFM97nXxge39wSSDYW91xvMg4bwYtlFeokq7BfLW8P1t80GbnKVYQTGhIIIgYaBz06+nKFrCGmoNZ02cC64ctRn9E5i4OkdMnOopBlXxU14CdHqdf/PJhoPMMBP//ddDh62HvGE7KE4yUG9lvKrvgmPHu19ApDFwm/RN2jhRsre+OH2oENrlekVS8FBOhSAGUTDF9I4JUMVqTkQCPuv381ZS+mju5FyP1DQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+M7JV+EJfAv5VX8yUMf1PJm9BEK/oRTXDHcSdWSh5E=;
 b=qjd5o9hShX8u59hE0KDwcDtGPaP+agAf4TWT317kmjVahduyYep9ZJAuUZTEVF0bYvwcLdzLxQH5f2R/KqHhjpGqbEO86fm+hKxFKwUQD87Gh3syePMImKZIsevIvwA1ennZR1y8BhG+eTQyerL1P5qOKOIOz0b8TRZuKJH8sWNsnmo2i6FZm+Sch1473pT/kbNlMr7LteYBmmIOpZNGhL51N3diJHlTPtiRxxjnfLHiJakAVUsNfHHXP5VC/vFcoeOr5yMZ9oSUhDDcIQwi6/y/b8K6KLOJkTzuLEZkYOFPIq4gZUXxRk/CmDJ/R8V7GsRtnM29aFp3LA8QkNTJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+M7JV+EJfAv5VX8yUMf1PJm9BEK/oRTXDHcSdWSh5E=;
 b=YmsOxvmn3KgNlWs+bTCzv6lTgruBueSvsVacjiebruf79P/gvjsxIgmatTogmMRrsTAGKdNNK8QDCSNGwCAvqP/FPYii44Kl4yQITzT9FRu7pOPkch6nuc4OSDiuhvesHZa33IFAeke5b2dg/r4DTj8LcY+svZRhPn9UldPfnYqSNs5zYhcfkti0AaXtIC80uyIYuFr1rqwi16irzkDd0KWpt9q+AjU6NAF4Ipv2RhwKE+lTPlyHU5sN1ZcRDMFIDOmwlS5ml7o2ecnj/YVDzI5lunKxUDb7RaJnlLfmVqsaA/7juTj/Jyiq95QXkWTVxrrdm4F8WkLexAJFAuvexg==
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:12:22 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::62) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 17:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:12:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:12:05 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 6/7] selftests: net: lib: Add kill_process
Date: Mon, 11 Nov 2024 18:09:00 +0100
Message-ID: <3adabd35bb82aa363eb85ea2f5d2be9a16da607c.1731342342.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731342342.git.petrm@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 709938a4-36ca-4e1c-2aa3-08dd027401c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quKX6RSSl7QbgQ0iRfvec+pLaM/m7c7Kzc0neGVD5pDWqh7WiPA3J39cT/c4?=
 =?us-ascii?Q?p0PX3UP/BAkp/msUp+ZKgPyYH2cnsPBv4C2/v2xehPxsdOfmnDIravxVjhFU?=
 =?us-ascii?Q?babydLbb5XQqCvWuhs2h9NO5o3I2vpX0LYIyhugonye8hvscMRJq7Utdtat9?=
 =?us-ascii?Q?UZWlKrn8CHrWvXLyuP5U7mJnz1IcSOfTecEb2UHW/ioqQsK+hJ3A1NagSMpr?=
 =?us-ascii?Q?qEU4FYzKxYri1FNLgdgvBoXyy8RcHnT0NixdVb3Zw+4U5OCVTDIAnt0Dq/Ph?=
 =?us-ascii?Q?x0pEjMBtW+TH6PdhlglFYObZJ4rKcXFNtjkB1Gem7dU5IlJ2HNIXekPgupHV?=
 =?us-ascii?Q?mH2k/BoJOaO/ySBIUg+rCCBilBd8Zw9zgGkYgfzldaLzOBNqX4swReYWl61d?=
 =?us-ascii?Q?4bTBOUc/TrXD5nBeWooZj+mfkiEIwcCvbgIb+YQlc9mn3lIBWTonBRpQyB2z?=
 =?us-ascii?Q?CgrD7QGbtjswq7zr73OS2c4/fgASw2dsPg31ZdxyHl2CSlujU/Rtg5rXaIlz?=
 =?us-ascii?Q?OgTLewZ0/WztkFrw+0JUEgDLiYYFEF1F9+PFbDh2SlHFOqfuJ0iF6oOqtaqO?=
 =?us-ascii?Q?WRyrLoDbCW7n5QhLaX8UI4GVxKzoDlHfo5MgYXzoPYdc7+fDe91INqdzEBZi?=
 =?us-ascii?Q?cdGSeut6jOk0u2kov2kSfw7o2STOmofEDOenkKpIL1sLHESYIXf0x/T8duKe?=
 =?us-ascii?Q?o2UeVwtnV3C5frhV8eev5Ju7xmxOZJfB5XoZKlmjJPmZ3hZL6O0t693Dzm5x?=
 =?us-ascii?Q?SbADAGfIt+KqeEX3n+5zvtqrXGqTYjeZHvo3IgJAqEWjYjLHiUghKrG65ftt?=
 =?us-ascii?Q?Q8wx2FJFgXzHQpXuac8bp1BNdWp9zpx/ZZQMnBF7qm0q0V81oE/Z2W9UblMV?=
 =?us-ascii?Q?bpyn8o9muTGWQxnHsbxFTKTi9ITtdy7Byl3/6rpJyJybxQvwYnY+rBj5OrdS?=
 =?us-ascii?Q?nEUc8r6GoMywR4YCNxAfT7rVI/w68OKQtAOY04ocjQTf1H/4q+Q3uG7+kD8S?=
 =?us-ascii?Q?hbb0LaWHip9TFVHsNcvNnPdUXqMFMxMZtYVpiY+vVL3bFOV0Nipzaaya0AOr?=
 =?us-ascii?Q?t3u1pHMi4ZKSzjkprZAKSFr9SYKy+SBnzPttlM+ePseas5WAy0C24qJ/0uyi?=
 =?us-ascii?Q?gYP7lIiXfHzHTfMxVIV0PZ/fgetEwG5Y5INNkJqnwb5PLppioZthfdrIvbId?=
 =?us-ascii?Q?ERGSDQbit0O2kO0pLlLew7N7RH1j6ptQd8c0nJmFouXCVCn6BfTcDnG1Peeg?=
 =?us-ascii?Q?aH24qRgSM0JgZfSa+XhEFsV1ej3/3Oi9ywHeGZYRdnBbsqmjrN6uKT3KiJ/Q?=
 =?us-ascii?Q?1A77AXdDEYO/e+/hRK3OaE1hDZ8G049sFuupmcEdoqN7JuTuWpFEOZY0kzK3?=
 =?us-ascii?Q?2CH5EOeYyD9u8rhrJMyXTVqSBhN4bAzyCKp49vbejMqLhv1E4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:12:22.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709938a4-36ca-4e1c-2aa3-08dd027401c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973

A number of selftests run processes in the background and need to kill them
afterwards. Instead for everyone to open-code the kill / wait / redirect
mantra, add a helper in net/lib.sh. Convert existing open-code sites.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
CC: Andrew Lunn <andrew+netdev@lunn.ch>

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


