Return-Path: <linux-kselftest+bounces-16068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A935195B7B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3D11C23C0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C21CE717;
	Thu, 22 Aug 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdZHo/Rm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB791CBEA9;
	Thu, 22 Aug 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334772; cv=fail; b=u5/CZSmQMSIZ54OsvWOoLNASyXDvPkkd7+rxH4BfSX41SPNTe3joXzb4HAL82U9e54UigZn3izG8lugOgMKKG6rjrPJxSeXQVeHW0j7Gi9FGYiUJOQ1d5k5qmCepl8ofDXXmiwsXJe8M9foHJoUWnFMTATvbFKwHuqnz+AJBhL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334772; c=relaxed/simple;
	bh=VC7wVbHkdziK2MFGhHW/f0rp8dFw/s9/v8lHnj7t3a0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOOjR6DJeWjD1ir7r4zp1iqHecaCpw32jBq1xZ5LvsPyxDS/yDSkl+BiF6HzqoVz4zg8QpkMjA4anQVEZWZNx8EQt3//SZQ+fCLx0ORO5Snkbv9MRDztJlKlCkiu8ghM8tVKpjPIr9/YAvwmWrxsYvJoHFSbJfMQtn2rRqETNxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdZHo/Rm; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbmCOcrBv9IigbW48HPyIHyx3fGmoPiTy5+NHeUMUdzzZMcsbn6ZAUEjWifPJm+ZqCs9wLy+IdSh0sTmks5m/JYqKzC6x1gnFLFXzRuADnfpJ9Qka89KcxnUd2YiN7Ljs5mj1YyBQSVPK+9Qu6V+CVPVGOt3ax04NL9ipKpMl58sNLKWzXc669XrQSG/W1hpRH0EplbxhzLAFsWbc/PrgPf7SwXGXh4fKjNuMDHTIWgLhl7CCvzFTJ1vtSm2/U7hb8I/xgwP0RQGzwhbpzjpFZaoOWRiK+LnGzf54vOZ9JahB+GWueQyvVll4BkFGjnb1vYosN8E+pa/NFMHF2FUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTr6B/82sRFS7ugHht5hr0b30v2oZ5qEj+8riV9jFvg=;
 b=rOB879buzBRY1Gex3CiKUx0idaSjw6hQ+Db/4hvMToQIiYhD0s36MTpTO0J+QKabPzL/ZMTsfWwaMV2UPGmC80VK9BmMqXkVyoBIGep7qASnzZAgls29MXjdQhv9UAjQyWDqmDjK+QkXmHyTbN17QmUuTkSIO1yzSUmrDg1d+JgXKn/eDpQ2j4ZbTQQ9U/XbN8nUAkzYHO5+bZ6lZ34c6pxIMewnIirIbqetPksNCfS28zXAbHCnr5/k4pIFFTnmclmnoykkujDIrdHXhq3j0YZXlszSwzXG+BGEbvGy/zkcOjpWbiWonITtDlafzcmaqDlhHJx+uhaBe/Ky8gX3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTr6B/82sRFS7ugHht5hr0b30v2oZ5qEj+8riV9jFvg=;
 b=tdZHo/RmUlZLoEL4FpwJgnTt9ko/tp9+hfDC87AtY6G8n8KVY1UzpmdFrSQI67f5HGuQdq1MdH5BsObfLvmBzd52m5HRwQTt4zH3b7hnr6Q76gUi6cIgVHpqW79jSoYmaedeacSA4DRHpJ6G4r43NSiLgWXLqXJw2CR+i4Vc/eSXAjIDpEkKgFQmclXLqc9VloTHtNEeZysxR8ANEQHemiUleNhjGCCkCTd0aUMLYUcQjqqYzTSmtVtV2Muh3PKp7Kk30qmPnyHaRZ8Qk1wPnEeQy284/PM8ASdp5JWxS0Pge3eUv0BSP/+NibRfhkqU0VBONCeaslrsOxfo8UmkNw==
Received: from CH0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:610:119::6)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 13:52:42 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:610:119:cafe::1d) by CH0PR03CA0379.outlook.office365.com
 (2603:10b6:610:119::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26 via Frontend
 Transport; Thu, 22 Aug 2024 13:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:52:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:28 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:23 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 4/5] selftests: mlxsw: sch_red_*: Use defer for qdisc management
Date: Thu, 22 Aug 2024 15:49:43 +0200
Message-ID: <86f5621c15804eddd7563d0ead0cf3c75c08fac0.1724324945.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724324945.git.petrm@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dc6401-d979-4898-dd66-08dcc2b1b19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lAMbvTxonfzo0J0mkVLOlzaRMQE0Ros60/j3FpYEmQw0BTuHaAVW4TzZkgQ?=
 =?us-ascii?Q?uj3NQrqyxGVHpkYtrSGQiRIopmFQl24hEarRmBn8SjpvLBnY2AcfgDdRPJjK?=
 =?us-ascii?Q?/bIhIuj4q+OToTbE/ufyWnIkz6ll3NBpWvPBYthYNtY8X1PPO5ASnCEmjmB9?=
 =?us-ascii?Q?G2/G7W7ropVzBa7XEXbmLvfL9H3pgd0p8lmyKEeyoTwVVaF8vnjIWYT2rmFQ?=
 =?us-ascii?Q?bxuZ7tHdGVg+4paF/lUrywfL2EnXM7wlI/EJ6ClAkTxjni6HzCCAf8Pwzwvq?=
 =?us-ascii?Q?mPBMlGJY8sdifImCAAPlkadagfLem7BrhVgcmKhWb9+bUqZF3x4XXiqC7bmp?=
 =?us-ascii?Q?pJ5YkkKEwLhVxqd7PhDMaJDRWFZXTDRFdv4qxy1GaH5vpuAh0btJUt8VNbd/?=
 =?us-ascii?Q?xoLRXTRwE/CrFpP8NshMG9xPeURarMfsZkrxZlJM5tA7Cw4q9jTeOpgY5qi+?=
 =?us-ascii?Q?yiPjt/QOyXkU6nmFr9l6I0zAq75Hk30QdYK3Mkq5CF5k5VKf3RfCdC1bsKA3?=
 =?us-ascii?Q?iO5EVY5xWeopXGyW/R4L/M19XPCHE7cml+JQvVd5E8IdmijRUxfpkx4CKV/p?=
 =?us-ascii?Q?4eIe9iMMyv5aco6pfhSVLkBC59iirFa0iruYyjEhOdCKGNHWoRTsxUynA5HS?=
 =?us-ascii?Q?8fH0zirbwbEeQA8Tx3rXktfprkQkY7cJ+h/bbmsrOLDbV0PplzhzUkcIF3rD?=
 =?us-ascii?Q?yj+Uqpq1In2ktqehBwjxh/hwlFkWIiJZorb4zWsJKK+W3U+LU5qwCqJLpy52?=
 =?us-ascii?Q?GEYlmEgU+aa6TnKt6KrPyKLAT84zYf+1wvnhdGUX9pGvOjx7393MTJzxaJod?=
 =?us-ascii?Q?abaXyAlrnlr/jPQKON0/z1ZdDD149bUqkPhrquD08Mv7OLfAn2Ki1tFZXlCS?=
 =?us-ascii?Q?fGicjaF7Mm84+y0eR10jLpFW0GP6UYbBafBGnPhX8Gw2wByhkgHuJ90BQeIG?=
 =?us-ascii?Q?+kEDx/R6n4QJF+KUfXli+RdTVEQDvzm2J+/8NgI/L7ElMfK4nPRlbiRIZ6zk?=
 =?us-ascii?Q?q2C2IczdeRPerBnaJK8sbe2MNao2JhErcHTBDRKUC4uQKtBTqkHYckeKwZZ6?=
 =?us-ascii?Q?RFD5qXcjJ9COz0CPhrkKYhukFI7TWF2q5Y+azvIA6PeBPryuJJkRYRfPotGu?=
 =?us-ascii?Q?HrwzNe8JfkXLUPXvRM9CS/oZ0PjL2cvwN8TpdyiJB9oOr+/AxpN6iQSf2syI?=
 =?us-ascii?Q?3WnBRy7NWwEb+kPKCxevUhpPDtmCnLQvXqhFlq+EngNTd01W2cU4ut13taf8?=
 =?us-ascii?Q?zUroaDAdgkjCxkeZOKpsBkmkVer4tOcLV1luBxkiAkTtf+IcQ7nKe/mLYiuh?=
 =?us-ascii?Q?GhIWnEneAIVUy4aevoqrJM4WAK3F0Oie4azsfzb3EMLtUachpQjcW5SNShjS?=
 =?us-ascii?Q?203VgvU8kDuQt+3DLHy1Eh+0m0seq6d8zBU4BinGbPZghM2i0Yx/idkV8pK4?=
 =?us-ascii?Q?nKrhKZDahmcZE7iWruqfPwRl0kHcPOIl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:52:42.2518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dc6401-d979-4898-dd66-08dcc2b1b19b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

Use defer scopes to manage qdisc lifetime.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/sch_red_ets.sh          | 32 +++++++++----------
 .../drivers/net/mlxsw/sch_red_root.sh         | 24 ++++++++++----
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
index 576067b207a8..87b4dc509896 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
@@ -80,36 +80,37 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 
 	do_ecn_test 10 $BACKLOG1
 	do_ecn_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_test
 
 ecn_test_perband()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 
 	do_ecn_test_perband 10 $BACKLOG1
 	do_ecn_test_perband 11 $BACKLOG2
-
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_test_perband
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
 
 	do_ecn_nodrop_test 10 $BACKLOG1
 	do_ecn_nodrop_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_nodrop_test
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 
 	# Make sure that we get the non-zero value if there is any.
 	local cur=$(busywait 1100 until_counter_is "> 0" \
@@ -120,51 +121,50 @@ red_test()
 
 	do_red_test 10 $BACKLOG1
 	do_red_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
+defer_scoped_fn red_test
 
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
+defer_scoped_fn mc_backlog_test
 
 red_mirror_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 
 	do_drop_mirror_test 10 $BACKLOG1 early_drop
 	do_drop_mirror_test 11 $BACKLOG2 early_drop
-
-	uninstall_qdisc
 }
+defer_scoped_fn red_mirror_test
 
 red_trap_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 
 	do_drop_trap_test 10 $BACKLOG1 early_drop
 	do_drop_trap_test 11 $BACKLOG2 early_drop
-
-	uninstall_qdisc
 }
+defer_scoped_fn red_trap_test
 
 ecn_mirror_test()
 {
 	install_qdisc ecn qevent mark block 10
+	defer uninstall_qdisc
 
 	do_mark_mirror_test 10 $BACKLOG1
 	do_mark_mirror_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_mirror_test
 
 bail_on_lldpad "configure DCB" "configure Qdiscs"
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
index 159108d02895..1777b79b1190 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
@@ -32,46 +32,58 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
+
 	do_ecn_test 10 $BACKLOG
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_test
 
 ecn_test_perband()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
+
 	do_ecn_test_perband 10 $BACKLOG
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_test_perband
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
+
 	do_ecn_nodrop_test 10 $BACKLOG
-	uninstall_qdisc
 }
+defer_scoped_fn ecn_nodrop_test
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
+
 	do_red_test 10 $BACKLOG
-	uninstall_qdisc
 }
+defer_scoped_fn red_test
 
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
+defer_scoped_fn mc_backlog_test
 
 red_mirror_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
+
 	do_drop_mirror_test 10 $BACKLOG
-	uninstall_qdisc
 }
+defer_scoped_fn red_mirror_test
 
 bail_on_lldpad "configure DCB" "configure Qdiscs"
 
-- 
2.45.0


