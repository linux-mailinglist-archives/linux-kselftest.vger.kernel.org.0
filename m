Return-Path: <linux-kselftest+bounces-26014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F6DA2CA40
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E39616AF82
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAA19992D;
	Fri,  7 Feb 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNy3QPAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBA1885A1;
	Fri,  7 Feb 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949718; cv=fail; b=LQwIX2odx3T1ek2y836/xMfruQyl7jgZikP9pj/IwzdUegzHPq8IGX9EQG3S5XjNqZMuClbIBs4k13Nc0xesTWjQqfWjZFcebS8XC3a56eoPVu6ODSgKCysF/8dvYdPng14rPzZc8YRnhvdhEB2nZn+LVGdA8sobc9qo6y9t1QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949718; c=relaxed/simple;
	bh=NXDKJfrQVxM1vV+sa1qjdASmNH0UhLg+ToJCPmwQ7ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbtE8HKD/YlksUJyXA2jOiBYAv7ULvjPwBNgMYVzSWAE8L0BKZnMcT6hRJKg9E74/20KqYmTwpKmG/QgoQcKPS8Ju/U7+3xXDmvD41u069GgW7XnN6U6DldqqIN01aD+4PY1gStc5n7wzCS7NLSU3H6+u7pV2OyOKeMwEGq2baw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MNy3QPAA; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpKRvQWYD9+E6pqxTIKZddLMJ2x3QLiwpDrfC8y/wzgOZalXyjWTpYsEhBlFRo/9X9QFQLbv+QwLQAbMK/Y+JOi21gtDVJjZb6NSgKOlzsVyvk2FjVHRzoE4OJa+bfm0Eg18K4Luv5wZZN7BB5dBCe73mEtKMQB0oTPT/weVFybqhqomLWe0p0C0jV8GbI8xIS16Kya/EJ02c+59jU9HN/UK2BixTD5ZfOoqX1/2L8J9adiM5fmd7KXmCweMqwSPYlU8MgxLcKLThBYUqVxDwSiJucB/BXU/WoBvxRKAOCfyqFj3JLSLVY3JutvvpKMuiUzQlzsPlXo3Jk3RiByjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep1PpbVu2zBiqJXFSzuYw7/ZttPxx1HVDEGMVSjJFuU=;
 b=ed70GFCdFhRdxiSVpBv8CGA3uq3JY57LeMJealqZHn1O5zfallG16dLQF7uHatBZeofORY6ya9B9Fa1c7dJlKj8xCh8E/5/OoV27W/wDXyFMlaZ97av8L1DKNenLeAW0ngKm6/OR8zZyKq+ZBX1eXgFFxkZxMrBOQ8HI+rM6kTYRdid82nM1rIDAKoDs9Fn56syldVo7/CdkOjja3XEz98TgrSqEeGGYN47SXbP51TZVIludQ9Z9MifaNQONaCe9yyHTucZCamMgaEqSi1Y004Mo2DwsEDogrbbegjBaXRKGJq8XmArqC02/19GajLv2x9G6PrU6E/Qf6lTSWXyN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep1PpbVu2zBiqJXFSzuYw7/ZttPxx1HVDEGMVSjJFuU=;
 b=MNy3QPAArlYnVFHB+f/FwWx9VqtDJRBL9ghLyhC/Lr89DBDvQGQPZ0TvpJ9ATM/v4HV5Yr1La7trw6zO3Xo0tsibPFUD9cuS7a+lVLaYF4SWqSqLkhyGNcmtPoYhe6aIy1PIeYasnBuB1VBiQnVFV6XRa2TxhJV5xuiDU03vHi2uRi51F8NlIP8Wz50YU8jjsAfjkf1orEi+sZSGk3i3L34XLHh1eKfeGWbIN6y8v2OFTUH6j+5GakW84J65pzuWWkuJAFbdnnttUJwMtXoT8SiRhg5f5sM7VubpOg+DUN5at/laLvnNi1koateA62KmxW7wVZGdHemXzKlOKETwEg==
Received: from CH2PR14CA0038.namprd14.prod.outlook.com (2603:10b6:610:56::18)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 17:35:10 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::dc) by CH2PR14CA0038.outlook.office365.com
 (2603:10b6:610:56::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 17:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 17:35:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 09:34:55 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Feb
 2025 09:34:51 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 2/4] selftests: forwarding: lib: Move require_command to net, generalize
Date: Fri, 7 Feb 2025 18:34:22 +0100
Message-ID: <954a4485f597183598da02de5d6178d8354a8285.1738949252.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738949252.git.petrm@nvidia.com>
References: <cover.1738949252.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af018d2-b833-4527-5b87-08dd479dc56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6hdGPixuD+hzxwDPUemxIKETeMNES1XRTBxQVPDP1X5yjrSgbIYyXy61lD8m?=
 =?us-ascii?Q?rWMv/F6XTGJ5rfjZwXQh4UJGtRuUGLeGqdhqtsZ5u10l2a6GqfHCaXE7A2zb?=
 =?us-ascii?Q?1uA1vOtDOljyZdpgz6R9C0O54/Lgadd0bBlWEclEhj3GGZ2dzPLiDLPNh53q?=
 =?us-ascii?Q?BkViyosLJrQ/+m94jOgnq+4yYX7CFMl7eIZ6thE7VkJlOm880OJfRwJqtAOl?=
 =?us-ascii?Q?tkvyIb6kFkqa2EbF02J/5mvHDmsKfq1KpgGFIZuVx3wjyEzuDS3fumH2JIvV?=
 =?us-ascii?Q?E8qVeHp0XUisKfsfw7Qi+iSjF+GP7tLTpiJRdAGM52b7+61C7MRsnh9H/M0I?=
 =?us-ascii?Q?mTlWghCdfhNpZtO6n5urWVuMS8JdZVXGoWhNvHddiRuUM5SQ+fVDCEs0NOL0?=
 =?us-ascii?Q?VktgbK8etQx/rUO+pFW41ffY1ScvLxG9dvIjuTKKS5DW/T2Xot+CBvfkOhxq?=
 =?us-ascii?Q?dQGJTNMEh3cTlKPJky6yWh2fqZJJkKkSy0EdXcx2ytz5UuuvZPVg6xV4ymPF?=
 =?us-ascii?Q?d7TtAZlcPBLkficqfWq7eWbQnwBxxKbRLvNLy/8knfG4oNwhsdksEFfF4OP7?=
 =?us-ascii?Q?I+0cE1OuEL83IZBryu6nLwtpbxrdGk87e5vZWxKqpMOBi1oPkiJbjFLykBes?=
 =?us-ascii?Q?XvaisQ53F1IBr/hRFNtOgcZ4ENfWoIL3RN22FZMmOnxExKD8Q5CSJIVoAF8n?=
 =?us-ascii?Q?rfCa26fZl1apw0ltVhiu+F4TuW0khOi4hGRtdmFCyYzZTJahbwFCHCpRDTJV?=
 =?us-ascii?Q?f+5ZFH94GeNm5PwXJcHdqNXp5YyjDkTVCc+MUEmectl0X8x0EySLqIs2r512?=
 =?us-ascii?Q?EGsMd72Wq0aTRWpL+0iXpMnX6+3zecGd0+7jKbqr5JjjW3QNz4fsRSpBC1F7?=
 =?us-ascii?Q?EvzC9USnzJrw9pKkpzUqVOY096Qc3R2Ja5B5qvMWhVb3VAYVlZ1Y5kI7NWXw?=
 =?us-ascii?Q?fFY3Y8Beyf1my8p5GfcL49uLOhLEq2RYfRY88hOHusGacqWuwdR3VPcV3hCQ?=
 =?us-ascii?Q?gbf0DgQ49BecwZk8IqvBmqID/Bpvyc2tKcTQrdvmJZU8dloM8TPIfsvpxPak?=
 =?us-ascii?Q?fRIQRVpKKlZvjFORx/k1VGhp/lnSFoRJLAdX+2v6I3amAWBos65DD1fKb6PV?=
 =?us-ascii?Q?EhXEXikdToxiswrah9NuQgsW3vAjpAVT8vf3Zd0pcn27G6nb9T+c5+ezhZs8?=
 =?us-ascii?Q?4hiIfmAq+M8qIUh/OAHCc4se1JVrGOOyq8042O4i8+MkhN9j5hfL2qfm4ZqT?=
 =?us-ascii?Q?NojyPksdv7cyav0nQjz8XcIJ7t2y+L2XUdGX4ojdQtec5jgNoaT+d8EkYJGk?=
 =?us-ascii?Q?EICFbaUXryhagozsUMws+KmJ6qKFJHluD6hMbjDVR5EvUOaYTE0QsZmbmlje?=
 =?us-ascii?Q?+GsEngOmcrJWvhaDa5O47oqJLyqaouXQeUuShD0Z44owltN33/gaNo3tX029?=
 =?us-ascii?Q?ga/CD+irLlF3RwuqK9on+pO+aYCrnBAXQ1v+JPMyDFKKv6hqgFup5O6wpmZA?=
 =?us-ascii?Q?hFs1yHKUeNkodPo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:35:10.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af018d2-b833-4527-5b87-08dd479dc56e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

This helper could be useful to more than just forwarding tests.
Move it upstairs and port over to log_test_skip().

Split the function into two parts: the bit that actually checks and
reports skip, which is in a new function check_command(). And a bit
that exits the test script if the check fails. This allows users
consistent checking behavior while giving an option to bail out from
a single test without bailing out of the whole script.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Simon Horman <horms@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 10 ----------
 tools/testing/selftests/net/lib.sh            | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8de80acf249e..508f3c700d71 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -291,16 +291,6 @@ if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
 
-require_command()
-{
-	local cmd=$1; shift
-
-	if [[ ! -x "$(command -v "$cmd")" ]]; then
-		echo "SKIP: $cmd not installed"
-		exit $ksft_skip
-	fi
-}
-
 # IPv6 support was added in v3.0
 check_mtools_version()
 {
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 0bd9a038a1f0..975be4fdbcdb 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -450,6 +450,25 @@ kill_process()
 	{ kill $pid && wait $pid; } 2>/dev/null
 }
 
+check_command()
+{
+	local cmd=$1; shift
+
+	if [[ ! -x "$(command -v "$cmd")" ]]; then
+		log_test_skip "$cmd not installed"
+		return $EXIT_STATUS
+	fi
+}
+
+require_command()
+{
+	local cmd=$1; shift
+
+	if ! check_command "$cmd"; then
+		exit $EXIT_STATUS
+	fi
+}
+
 ip_link_add()
 {
 	local name=$1; shift
-- 
2.47.0


