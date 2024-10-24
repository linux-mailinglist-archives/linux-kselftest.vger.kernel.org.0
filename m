Return-Path: <linux-kselftest+bounces-20561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D69AECFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFF41F22B56
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913721FBF59;
	Thu, 24 Oct 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0YEB8BV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075E1FAF1F;
	Thu, 24 Oct 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789157; cv=fail; b=ZPDyq4bzS5cc6oC6PYhD/djdhvFEohGivvvuZrDBfRFrKhUgGNGtISa7I3uzeeaSKo7CycPnSo/s3Yqiovsp/hN2jfRYjOd4PN0tyVKsm943f11q3bJLzH1Ykklcbspgm+MqdtCk+Nxg2CY00BzwPTSokLg0QXqBFSj0n4V9Cmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789157; c=relaxed/simple;
	bh=SqmKoOyxJbusXs1HirNMeqT8OSxn4yExkFS3AOQdfTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucqerTteI5GGcE0ILdaJ99D0B7mFeJGT5W4J+GJlH9FNtP96L8RObwfOunrgv11kSQkcyOgl3q8hf58/9P273lBnwn+SoOG8CHQnYBP05dKQuEOjsW1YrhLzhEnfwT387sIf1AuxebO47M01FraSA1XvjKF00n1bG7gJK368skM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0YEB8BV; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYZDf7fuYz0trcu86/mXHQZvljI3VY5P+++EACyFzA9R8Me0BJgci7RkSmy6UBVPo3rdpnQAcegDeDRgDWs0Ob6sSSF9q7o+qizl7UtvXPEMkqO3CsYyTuYWTM5YtB8lnoPoHwDirypXXpHYv6Cj9cvR4huO6I8BuMjZjEO4fKDWgsYAMHcOnfGubLcxy4Jfm8zSyDNjyqioUtsCAwATZXLnPz9PbdsaJ4vhfGzASSCSv/60iEJFg9j7NKu0qAmyd4ES2KzHZT7rf8WEP4qO7aRr6tEj4466oirVmQ2bFLn9C833wdQImQ3Vj4a4r/rwq5Uify5APrP0dMf391eUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzHXYOyqnaDXp8RSPJk72+eqZOrffk/t6kNw6CHFUIg=;
 b=OSbuXzzb7zBcMhdjUgtOm79JFzqFSGK0otAHZuoVTsABFDHLKPDKmf4RVuIGzw5F0w1+r0jMtjxfuW4oH2dRWfBDyTnsnuRVFWbPkTOEQRIiBJu8T1am2LzaenZ0Ms1JzhDVU/DrP8VvOE8vLj3jUb3Abary0iut6je3jKU7iXuwd/5rvuCjRcUU5EXQzBGx6teGd4OuF7coTFIMzTw0ok0jjtVD8zMT6ReVQ49KYhvFTTnBLBm4FNIohu+qWdiIlfYFrXR80AJOUCDa8vKzSsIClzmUzaxbBWJtuLX84D00qGgGsB/m+KwsCQ/dVGynbFuiBzr6UfJtAcbDcjSP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzHXYOyqnaDXp8RSPJk72+eqZOrffk/t6kNw6CHFUIg=;
 b=C0YEB8BVTHlbOHDfZjDfPsb6bmVWhid2XO4OLTauoicF5nE46rHzOz32jy4JuXErSKAgQlz2IWZ4cLr4FWeEULPuB+IqOpiVIOlfx4Y7N4GdiN1i74/15/cYQN5iKg8moOtuptFgkxHuvFxyTT6xXqVsRoBPAe2o3Kao2bpi+Udt+ZaBY92+56N2jwCprgNcQNaX0GFIrnkbX4nlYdF7b1Fdyg/X8UY3zCyvlLRutCjZEJrlZyW44lEp1/pUi/J8u2VoNKmvFjOzQMPSIje6dh5592Kl9qsvpJOZ8FcaeLCYGXcc/O9qBzXS6Nzovt+TYso6dQy6cxBQWlHXV9AjNg==
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 16:59:10 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::ba) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 16:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:59:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:57 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v2 8/8] selftests: net: fdb_notify: Add a test for FDB notifications
Date: Thu, 24 Oct 2024 18:57:43 +0200
Message-ID: <4920232d77e781b563cc477b56495c3cca2ea1d1.1729786087.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729786087.git.petrm@nvidia.com>
References: <cover.1729786087.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 293cd9e3-f5bb-4069-b065-08dcf44d2ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KPQR2qjJy7X3AAFtvM34EbdG9EOQcUgABBCmghBAyRjC2UgiSPgCzNH8FHmh?=
 =?us-ascii?Q?sHLBUvMLjTv7zBetWICkVfJMsDDHZSgw9Am2hNX2UUHIsPZcshI2m1mimkW7?=
 =?us-ascii?Q?4sa891kz1pkbGPpPchVOqVI+hQKCwb+3Q5Z41n2lFqTkvNG8eAeqAFauVele?=
 =?us-ascii?Q?NDS4TWlwZSdLn2jTtQNvkmSCodKDxYlACbBQNy3lwwfIj60LnkpWrUwL1Ugv?=
 =?us-ascii?Q?6rIXOu7DNnmIU7rOGKzr0bJjdNufNKDeZIx+z4cO4aH37PnnDf4ybSQFV+xM?=
 =?us-ascii?Q?GWLA7xjf8dDrjYnmmaTVEtmW27QEMesRQIPRshBmQDdYM0LQcZYWXwXIK6dE?=
 =?us-ascii?Q?JvEA0c+yZQsjHpqzFqmWfz6i0WrbUKNlTPE83ahALHjgNzkUcmXGmRLjCV+W?=
 =?us-ascii?Q?KQcMRJVxrD/dYTMC1H6gVYHV7iQb906aoI7P4PSThzZZamq+bctI3O7NrABG?=
 =?us-ascii?Q?vyAXHd/yQ1c5wvA9DpTs/tR//Cn6ULWG8/N1nm6D6lWN6MSQmuDVj1a3HaoG?=
 =?us-ascii?Q?4mPe4rLfT7EuiZLLY68f4ROCbrKVDD8JnzGuZoEltznhsVVkrQJyTDoxWFMM?=
 =?us-ascii?Q?beG+dA0uhR6AwPKL5DPYjH3djn7hcb6+p8b27TC7+1HXfJFg3Xm7H1RuXlEQ?=
 =?us-ascii?Q?oFhNEuxEXWVelEUXSkVoOR7o9gwZDrJFknmcWEEc1X+a798R8pVWqwDzJgQM?=
 =?us-ascii?Q?FHZvLuyTNtZau3cTDgj19MhHieeDCxG29ZZa4HNfQAtJOUVj4Xt/nGU6YFVa?=
 =?us-ascii?Q?V2/SAEAISg3NICDlMsWpvfnZhQTy4GKwY6OIOn027rC8qa3iW0R65D8bnVti?=
 =?us-ascii?Q?TSd7+I7oF6/GW3Pw9R3rlbAukY2hoyBCKTA5pssADp8hkhH3eFLCsWFKOqdy?=
 =?us-ascii?Q?OtA8ntMsdEp+0MSfHBoFXHgXd7HDPWmHd27+V6qvY4kOQMb4WgpxZQEJCZns?=
 =?us-ascii?Q?U4vHgalhNdVY/MWsi1L8mN3ok7IFMw3jsON4cSPMSyxGZW3/NafPS2KuM/S6?=
 =?us-ascii?Q?rMRIL2yvEnt4KNjKm9Tum9vH0oduTeqnPHjQ3lQGC8TRZDiWZs91cfUKSGwL?=
 =?us-ascii?Q?Va/G737fpChRk2l6iA4nsJFZFu9eGTT7bh6FzgDbten9h8/N10eHwhW91W9U?=
 =?us-ascii?Q?wY4AZgobtQglGFpSbfpx+V6C9oeM43ex90/LoOs4rkZDLbAwt8P6++VpaDEm?=
 =?us-ascii?Q?gQk05fodaBm7+oOuihjvUBYArkZei2NXbUSIcV3StHDXxhw1wUSbtLQ/tDty?=
 =?us-ascii?Q?RvTBnqxn8YXuIlvcDplkT0eduhDwqU6snk0VjcNei3Pqx6mTEWg434vBWsyv?=
 =?us-ascii?Q?ZOZNxNnbUIHYBKalJAtTEak46w0DIHH0iKYy+PYozeJ+qVEAm4csI1BJLVxe?=
 =?us-ascii?Q?zNg+7IgN8LZ0lQTuMOdMFlAjFrfZ5UBS28pPSu8Hhuh9wA155A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:59:09.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293cd9e3-f5bb-4069-b065-08dcf44d2ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

Check that only one notification is produced for various FDB edit
operations.

Regarding the ip_link_add() and ip_link_master() helpers. This pattern of
action plus corresponding defer is bound to come up often, and a dedicated
vocabulary to capture it will be handy. tunnel_create() and vlan_create()
from forwarding/lib.sh are somewhat opaque and perhaps too kitchen-sinky,
so I tried to go in the opposite direction with these ones, and wrapped
only the bare minimum to schedule a corresponding cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
---

 tools/testing/selftests/net/Makefile      |  2 +-
 tools/testing/selftests/net/fdb_notify.sh | 95 +++++++++++++++++++++++
 tools/testing/selftests/net/lib.sh        | 17 ++++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 26a4883a65c9..ab0e8f30bfe7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -92,7 +92,7 @@ TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
-TEST_PROGS += fdb_flush.sh
+TEST_PROGS += fdb_flush.sh fdb_notify.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
new file mode 100755
index 000000000000..a98047361988
--- /dev/null
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+ALL_TESTS="
+	test_dup_bridge
+	test_dup_vxlan_self
+	test_dup_vxlan_master
+	test_dup_macvlan_self
+	test_dup_macvlan_master
+"
+
+do_test_dup()
+{
+	local op=$1; shift
+	local what=$1; shift
+	local tmpf
+
+	RET=0
+
+	tmpf=$(mktemp)
+	defer rm "$tmpf"
+
+	defer_scope_push
+		bridge monitor fdb &> "$tmpf" &
+		defer kill_process $!
+
+		bridge fdb "$op" 00:11:22:33:44:55 vlan 1 "$@"
+		sleep 0.2
+	defer_scope_pop
+
+	local count=$(grep -c -e 00:11:22:33:44:55 $tmpf)
+	((count == 1))
+	check_err $? "Got $count notifications, expected 1"
+
+	log_test "$what $op: Duplicate notifications"
+}
+
+test_dup_bridge()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	do_test_dup add "bridge" dev br self
+	do_test_dup del "bridge" dev br self
+}
+
+test_dup_vxlan_self()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	ip_link_add vx up type vxlan id 2000 dstport 4789
+	ip_link_master vx br
+
+	do_test_dup add "vxlan" dev vx self dst 192.0.2.1
+	do_test_dup del "vxlan" dev vx self dst 192.0.2.1
+}
+
+test_dup_vxlan_master()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	ip_link_add vx up type vxlan id 2000 dstport 4789
+	ip_link_master vx br
+
+	do_test_dup add "vxlan master" dev vx master
+	do_test_dup del "vxlan master" dev vx master
+}
+
+test_dup_macvlan_self()
+{
+	ip_link_add dd up type dummy
+	ip_link_add mv up link dd type macvlan mode passthru
+
+	do_test_dup add "macvlan self" dev mv self
+	do_test_dup del "macvlan self" dev mv self
+}
+
+test_dup_macvlan_master()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	ip_link_add dd up type dummy
+	ip_link_add mv up link dd type macvlan mode passthru
+	ip_link_master mv br
+
+	do_test_dup add "macvlan master" dev mv self
+	do_test_dup del "macvlan master" dev mv self
+}
+
+cleanup()
+{
+	defer_scopes_cleanup
+}
+
+trap cleanup EXIT
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 24f63e45735d..8994fec1c38f 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -442,3 +442,20 @@ kill_process()
 	# Suppress noise from killing the process.
 	{ kill $pid && wait $pid; } 2>/dev/null
 }
+
+ip_link_add()
+{
+	local name=$1; shift
+
+	ip link add name "$name" "$@"
+	defer ip link del dev "$name"
+}
+
+ip_link_master()
+{
+	local member=$1; shift
+	local master=$1; shift
+
+	ip link set dev "$member" master "$master"
+	defer ip link set dev "$member" nomaster
+}
-- 
2.45.0


