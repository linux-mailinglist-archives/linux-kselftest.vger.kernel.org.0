Return-Path: <linux-kselftest+bounces-26666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E3BA362E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A838318900FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B542676EC;
	Fri, 14 Feb 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vk8hCOQq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF12676CD;
	Fri, 14 Feb 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549979; cv=fail; b=Y+MH40D6RBnQJ5YZ4QQiWzJ0oBpdqUSrgxfZ5oLkTCqC/oUk2/4QYQeaXQJH0ZdFvMc0qm/+y5cKKT8jS6KtFsqpJqFgYwpnKV0JypzvxhiJk0rgxy+449SocL3qVPNFgMsxw+h2Hn0ptmwJfkLSicMjkE3hy/0ZeNCOgxQ4zDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549979; c=relaxed/simple;
	bh=FErlX1RMbmxusG3Jd5/UOdTKdnEFR0Vvy5cuZxkRsm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLd5tuKqYq7MPzrdExr5T7QawS4/8c7PJb89BCzynb5q7Mc7H+a0e2WUsK3B8Uj+6OhEcIx1Rai0s/R0oqLs0UJcTDtb8ggDo0Ou5j1vPNINwH0hlHmoQGZEWJFnxPxdOWEya3YWRl3SshGusRJtJgY0zXv+593Q+9FzMkdPm4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vk8hCOQq; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isy0I03GYosMs03NBXTAv8tuOix54WbF2eXjZCqyzxPpd1lcULG+QZk+6bTb67b4DNDARxGQl9Rp/f7mcMzeLNQls1SPLElVtYHFnDROoOfbuohlUkb15L4oxOPv2/Muiz6BszRzBoP7Ro8kuyLX+dWEaW7Fpb6hJV1KLEm7+YGwcnDVW3m1azRhJwUm+3X0/5QS5oDtijbDaD96aeTxbvVXippyBhHxCQk+jCrSOuiJVk/bLgJGaglMo3oJM/SbR6pmIJhEQIdtBGnrpBXgT+mQQcxsmhtHSExd9kFJZF7E/L/BhzL51ihZphkPhM5Pfsh+imRDed9UTqOVrzjkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCSKERS2mQwbMjcbxMx22ExK2cMFq15Hq9GUrnZl9JI=;
 b=egzOxLVaTIBhRwOL4yqeWIdfHdDgWF4EDkbBnIH4zLqTRKdSy69nnZlNCpjqXdO2VH1DSdq49kapykAiu9WJJgTzlEG0ihMB4n/YdhHUyeZ1aoEXHf3tE5kKNxqkAH0ypcAcZHgfV67LzQ9ErH14JUhHgf4alp3FZPwQG6XdAZuonchDr8f7yTj88qvOUAjD0haVLTEQOVgwl9NAAAcNHcTneTQE2MRF3AanpWB+aVff+FOqvjmNYmZY0CpdHwzSLO2mcBA/6OGMrT8nd6AoEqUsn4pD4S33oQIJQQ4UYwuWen/OiH1/AzlaCL2A1mCakXlzZmf8+S/FTYudZBNadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCSKERS2mQwbMjcbxMx22ExK2cMFq15Hq9GUrnZl9JI=;
 b=Vk8hCOQqRn4Ir5Fq9emCLnlHInLT8TbziQCLCvkPgUdoG/N5uoxg0Q6pro+HF5ze62QExliY+SXeQFioTjuXfOAXb811Vn5Uy2mY1b9yTVWZugIicxF4z6TgbFYhIQKH3jmhU50xeRVew5/2L7iTtWq/27EFGAp8nyp8I1CR1ncdNMYyC4eAuRkFUuffC/FvDjHt7wPchh+S6g+xBqtHolg0Yq0m0KlWEf6zBH8UdiDperE1gbyaXLoHpxhy5LJAL8eJi9OBih8bOgzTfgHrLVKS7SvkVrTKRK0lMsZ0spIvaU9cgfhQfru8lNaDQQz2KGoXdWTKs4ia4UyyYeU7pQ==
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.22; Fri, 14 Feb
 2025 16:19:31 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::4e) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 16:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 16:19:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Feb
 2025 08:19:15 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 08:19:10 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 4/5] selftests: test_vxlan_fdb_changelink: Convert to lib.sh
Date: Fri, 14 Feb 2025 17:18:23 +0100
Message-ID: <e1a49e3fc8663b08e5d5bdee5049d25484f2ce7f.1739548836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739548836.git.petrm@nvidia.com>
References: <cover.1739548836.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2574ab-561a-4b7e-047c-08dd4d135c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93IrwUERwyjnLQqGyEl5JAR9I9ledCRdeSOWHhlE1EWSCraof/09kjHFNhUn?=
 =?us-ascii?Q?VPCrZ2dSHOET6nlyDR4V4cVnxS9RXv7OUoMzQNODG7mNZzdMIyZV19sKU6pa?=
 =?us-ascii?Q?rKlf6bItOBMkrOgG5gzrqsYG7noamyqN0AJCCbEJevAOQu0XJ2/lf4Du4gVv?=
 =?us-ascii?Q?zWDpNpnMeYJN5pr+U9LepIrs14tNk71LBbaPFuxTqzDN1macoR2QfjP4udIW?=
 =?us-ascii?Q?NG0XUCAyxCUXKd5VhR2B1edRX6gx6P0g7ha/nZfTq8UPPc6RLAQru6dWMa3U?=
 =?us-ascii?Q?rhxtg2Hu02ppBVfTPoDpOXJ9zcqyqhc2LsSecQ/+cUlKS10FHj1d6JDayTKw?=
 =?us-ascii?Q?G/p/4Y3FTSK36BbUbDutNi10W4+wg5xpdA++nt/p8Cqf+zPuAKKlMR9vPgLy?=
 =?us-ascii?Q?7Whf+38CiEiL3niCiD5D1RVRxgva8BRbS64/uw97ft74jUI0ihtddNjVEbjJ?=
 =?us-ascii?Q?NW/wJkntUZEXojXUbPXn6V0q2+tvJtGlkE72gNdBJLKGIPnN0MnrksKQMe/j?=
 =?us-ascii?Q?kYl6qTVGCNoIqCdmmpGiP7O9ggiGvUXhvulk0JWUUch0R5aSo0RYcEwoVuzm?=
 =?us-ascii?Q?vkgW7x4Zi3TUbwGesvn7fw3rlcDKxmbqySN+V8EsrCHK/vV86cH9adf0wHjL?=
 =?us-ascii?Q?3eqQ0EYlKCEgrXh+nQItEnjZXbZbkirBzG057brQBhhky1hAe0ZuEsPiJwNw?=
 =?us-ascii?Q?n7BntAUQX5bQTKwQzm6PIhI1B1DpZaZwMcBA2GVN043/D6FWWt8FarTI85tp?=
 =?us-ascii?Q?YQwuLYm1VC+rl7jyXypbxCbNhfAEa8Q+Rqp25bNUYm93T3UDHh5CAcq9S4EY?=
 =?us-ascii?Q?kektI3OBi5QyfuebIjWTNZt1QvTEW0ejHUnrvxmBPakdDXzdjkPp2YcCo+OF?=
 =?us-ascii?Q?9i9Pj69YkGHPhCjeVnUGKvgw1YB+JmcU4f4eMSxdSKlr1uzo7au0sLkfXnZ4?=
 =?us-ascii?Q?gZdgcd4A9dvh+qbmQTxRefMvRSshpYubxw5k9gBlbHOsikNuVQJyn84S9AGj?=
 =?us-ascii?Q?zlJyOQ+Vkn19jZPviGRd+CPAKMzRw6PvoFjjYD6mw5Vy+el3QgdNeuo6K3eh?=
 =?us-ascii?Q?VAKttRu7guSXKwgvHlOhiw+BQnqDEP8sY24yG5U6/auvsidEn4eyKmapMfpu?=
 =?us-ascii?Q?3G2smlKEbpE7FBiI/PxGtdM4nQq2vqkBZuPbxqV09Qg3JaLCExh4L8kbob+1?=
 =?us-ascii?Q?VqCFb7ya/8yj47o5gesc8fqk5X0B2+PO6KKUjPP9KWo3KKVbuYEn+DtTp7M4?=
 =?us-ascii?Q?ZLoRsVFUOgXR7IKqo7z2xtu3s5hruvk+umrmX5RR+TqAO3VUn4hPpNxTt3l1?=
 =?us-ascii?Q?DBf0d7R2zri8AuKOQFP5ooqN2SSGXyR/PGu8DT1pfmj6bg4TIcI7URh1V4rr?=
 =?us-ascii?Q?Vxvy7WV1NwlQ3gkqr9gLi+8A3OCIoBvN62HwwbZfDWsWQ0or1kxcFB1fLS0i?=
 =?us-ascii?Q?pr+/+WrnL5FmoHuhaqWC/jt0c/6lruenctAwrQvzo+uhO2nlrq0CjJJoWCVW?=
 =?us-ascii?Q?z9t1qqM10XgO4bg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:30.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2574ab-561a-4b7e-047c-08dd4d135c98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

Instead of inlining equivalents, use lib.sh-provided primitives.
Use defer to manage vx lifetime.

This will make it easier to extend the test in the next patch.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC: Simon Horman <horms@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../net/test_vxlan_fdb_changelink.sh          | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
index 2d442cdab11e..6f2bca4b346c 100755
--- a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
+++ b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
@@ -1,29 +1,38 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Check FDB default-remote handling across "ip link set".
+ALL_TESTS="
+	test_set_remote
+"
+source lib.sh
 
 check_remotes()
 {
 	local what=$1; shift
 	local N=$(bridge fdb sh dev vx | grep 00:00:00:00:00:00 | wc -l)
 
-	echo -ne "expected two remotes after $what\t"
-	if [[ $N != 2 ]]; then
-		echo "[FAIL]"
-		EXIT_STATUS=1
-	else
-		echo "[ OK ]"
-	fi
+	((N == 2))
+	check_err $? "expected 2 remotes after $what, got $N"
 }
 
-ip link add name vx up type vxlan id 2000 dstport 4789
-bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.20 self permanent
-bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.30 self permanent
-check_remotes "fdb append"
+# Check FDB default-remote handling across "ip link set".
+test_set_remote()
+{
+	RET=0
 
-ip link set dev vx type vxlan remote 192.0.2.30
-check_remotes "link set"
+	ip_link_add vx up type vxlan id 2000 dstport 4789
+	bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.20 self permanent
+	bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.30 self permanent
+	check_remotes "fdb append"
+
+	ip link set dev vx type vxlan remote 192.0.2.30
+	check_remotes "link set"
+
+	log_test 'FDB default-remote handling across "ip link set"'
+}
+
+trap defer_scopes_cleanup EXIT
+
+tests_run
 
-ip link del dev vx
 exit $EXIT_STATUS
-- 
2.47.0


