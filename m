Return-Path: <linux-kselftest+bounces-26665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C83A362DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1871C3A93D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FA2676D9;
	Fri, 14 Feb 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UBltOYl9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF62676CD;
	Fri, 14 Feb 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549967; cv=fail; b=Mz3afn0MQvc89eyFmK19W02qA1ZVXPTAyNtMhgiHeW1UcaI+RVrSSghlP05BeAEFyulYF8G7InWpuUB9aP6ooWVcA7TskVUFeidRD0txUPXfR+UfKshhPJp01sgSI4MRWa8IB1vaO10v92fyiPctASFyDQzfZ3GE+JIH28LmE4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549967; c=relaxed/simple;
	bh=KDlBNGscFqhHj5Akip6PuuUtcr2xGUYlnTdwl5CJJsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0nhbl3UFHaEH6mdDpgPwanqQU/W6p1fhu08/A71qCaFKACmkVUSb4lHq9VYKXwmIGUY6Vs7Esjs+fsMnxDbBcQeTe+KUn/qiXL9B8XI7qNTEhhzzq96EfD8Nxlc5xzypm9AXcicAVsp+FvG51Tjz9NQp7fcfhuTIPZ0srq7bo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UBltOYl9; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPBXYL8l/S1oEYeTnLiupqVjFJhjTEO8RUJ5VmkQMV4BCDUhP+j2e8DOpiR1mnvkG+HGIqP7zPMpApe2S7fy+H12jtH8hfJevSH9G7gvbEsmKCck5dk3bKF69PhxiyT/2bCmavf7uYvYhDwCUK2M09CfC2phSCSsej0Nq00bCatQc98qW/bVohiWl2mTA9CWitesdEFwBdSmr9cjQpr/Uim+BhAI4gkxAIwhb5qSdYAXzgjZeDm1itZ1hYS3J3KIPKamIqPO+anDeBMyFB1tCc6BkfGsLY/ZcvIUElMcUcUPOaoMHvIWxOUtExvrl2qZ1YjHlMZbkl6AP+TS/A3dSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlkE5zVQk6F2H1Rkl177/CHBtGiLSSvmAtSSyKAnwh8=;
 b=VbkU+s5fwTn80m/lvMEhkk2iqv5+CrnQMD2XpPqiezYpe9DtV5yk0AoqcPGNdweIWh9DcbpCxLtcZ4vdgP+WcYv+vqROVvO7irzdX8xhjUXQcDNtJXuHIcfU+UZrHFe+yvvat4pOoBxGlaPMJE7f9tXKbbMHNoizX2m1B81s952btXE156CdISRJGsVIeqobNzmOIVUcCn9c0AYGOQ2p9xdDi9enFlkcX2RACFzOOHrPW0+ga1SPSEDp1zdHxY6WDbH0d5U6Ak8AuJgiSBJVk2OyjFODAlUrXm5y0I6od6auj2wdKFHbcaYhF1ETTxosIc1vi8eAp+x5F1R+VQBc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlkE5zVQk6F2H1Rkl177/CHBtGiLSSvmAtSSyKAnwh8=;
 b=UBltOYl9WlooMr2Wv2pbjowgvEk+6rYJToMn05UgxpM8z/LTrwCOyLIb3R5/8DYlgf8MQ8xG/owVtJqXlDcr+FkiHCRIZbvUJdYhLgq+9Badw7dbYbdYYoq42MarkMGLPUsZdXcSPLj2IiOI/XVyuhxexdW8J88IhHyIW6Is+Vm1zWeOX0HuqWu+7kcMlwfF3Uj80CcSJ6+/jTWRpgBm3R+KaAsEUqhQcCNS4UQg5p+q7G3Wlb0iblMEZuN8Es84wB7ST2fsEvdwGhCI0prWVzbdsHya1b2GrvUiuzml/lKyLmWkfQg+jsv6yKqMA+jStkViC0hcPFqDPixedNndoQ==
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 16:19:20 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::63) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 16:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 16:19:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Feb
 2025 08:19:10 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 08:19:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 3/5] selftests: forwarding: lib: Move require_command to net, generalize
Date: Fri, 14 Feb 2025 17:18:22 +0100
Message-ID: <fa7860318b5150b705f2d42b08d3fe17b28a85a9.1739548836.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2763c842-535c-4030-008a-08dd4d13567d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gi6IkTX6vXUeWBeq5DiEZ2EBIv2OV6m+hNAj5NCmDCfbcvI+F19v3Y8oZIyo?=
 =?us-ascii?Q?yKvjnCMerdaYlobWRff6/rVplGpO5/1qmnJ3QZm04AMxYAtqZ1c8YQr2cNY7?=
 =?us-ascii?Q?bvnmvExZ4vzDZJYdo9mYxF6EOG1hhPKCSA+ix2B9GlrAIUOQoMu9oXwnxeK0?=
 =?us-ascii?Q?18qAO1k25C8wOPrHGilwUzotMH9ZJ6JcD4iQCKeWnkm1pEwocS12p4S39Waj?=
 =?us-ascii?Q?kqTVnPJZrpTpnqrTGyuPum24Z5IzxydAXN6D5pNsl7hXqTPYPSKTfDzzfatZ?=
 =?us-ascii?Q?5kRVc7WJWUzOkblL55KGYxcIH7cGMlo/DdbAoufncQ4iV0NC1hfLyndeoqHI?=
 =?us-ascii?Q?KlOBnzXGlK11ERgjYEI3K0Xxdsvazy6rTl6vPWhRPeUcb1W2RvrFJjDA9VtO?=
 =?us-ascii?Q?eAZSCeyx5FuWPuHOVfpZGUnbXgltB+2R9rOaF56Ts0vSap2uAzuVI3VxBc+G?=
 =?us-ascii?Q?kWbSEbnS8MVPS4qH1tFWTIUX4nkiE4y4mBt0N0QvUITH1j8n96PsOf0Ly/vF?=
 =?us-ascii?Q?mxGPPRoJHXhjQTv60iIIu63ur4JqKs/UDSm4ZzFf6yCeaHCYNMNhtPon6mdC?=
 =?us-ascii?Q?NMJtWvVFdgohQ6aZN3ogkS9Ezjw5hWGJ7BdsjOiROF0vJfM8yaoKm7PZiOx0?=
 =?us-ascii?Q?UySUV9rhjCJK2sgrDuWjlQLboTuOYiQgS/ZIYucYyl9+eAeU80rhbEKFbfTG?=
 =?us-ascii?Q?yK+6gsPyYgw/8TqjBvsTqcklBD9D3GaWoCap+1tN6YJK2pVkFbJL1wdktdDN?=
 =?us-ascii?Q?JSS8pXOon5GcEvloIN5EfaED2qeeYsYInW7VIYNX69rr3V6t9DQiRAg9HU0f?=
 =?us-ascii?Q?aB6e8qvdtmhWyUk7U3XIwnztQ6n0E79ENc5exPzHIA5gtbTZwygPmDBCd/6L?=
 =?us-ascii?Q?JBFvq4BTgB3bR3OVfYrs2H0SMM4ynsIHPd1IMR2r/ftIT7VfHlNA6R4gHOK/?=
 =?us-ascii?Q?zM1+C1byepWlnRojh4OCmCwKijS1lVZhsTgwSJaqvAdXWmVm2sSofPWxD+e9?=
 =?us-ascii?Q?UKXdHUOkDCqrHmjvaaUNga5ZK0MIfRvOP50GwLru73yTECi3SxuQvPLIq7tH?=
 =?us-ascii?Q?KznipliAFJScCqG37yhLJRR9o60QJuYg7aU+tqBo8U800zzlHY6wo3hmHBlz?=
 =?us-ascii?Q?MxQkr09LvYbNks/lXQviQWTwlt50AcLGxLT5oz8yN+qoFbxMKJqriZqzgkiH?=
 =?us-ascii?Q?AJdzlF9oa9DpMmceIPLws0w2U+7+sKj/IFUdyWDDgUDn9n3iAqr86NxvPWBt?=
 =?us-ascii?Q?WUAqv3PMNC6oD+xkvRz7Tt8JQhLRXL5KSgp9GnLl3nqlXL/xQ2iEpnVmYBNF?=
 =?us-ascii?Q?iOo5Sa505WHFewPysvMkBQ//lf10AOfHoOcddoJJ3ha55fGbEOc3Cut67l40?=
 =?us-ascii?Q?7stmzfEXS0XTjukYIAk38d1z69i+ISMYyC5eckvajfkny0a/O4cxmCj9mDCt?=
 =?us-ascii?Q?FvHZQNjdbVi4DaRSTmUZY45f719CS/IMlP0AAO0BpICSpyhp9+PiMBkEsvEe?=
 =?us-ascii?Q?LzBVcc1ZbjojN4g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:20.5666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2763c842-535c-4030-008a-08dd4d13567d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

This helper could be useful to more than just forwarding tests.
Move it upstairs and port over to log_test_skip().

Split the function into two parts: the bit that actually checks and
reports skip, which is in a new function check_command(). And a bit
that exits the test script if the check fails. This allows users
consistent checking behavior while giving an option to bail out from
a single test without bailing out of the whole script.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


