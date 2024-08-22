Return-Path: <linux-kselftest+bounces-16067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34095B7BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDBBBB24036
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0B1CE70B;
	Thu, 22 Aug 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eS/c0CA5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8EE1CB15E;
	Thu, 22 Aug 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334771; cv=fail; b=UiVIAjLm2/UGwSfUkRTABdpqsNRG6eO5f1QTC2lubofbzF/PnI+gPwEmrMgDIfLvDvdVHdXfvaI0VflXqo+dSVy4ZGU6YONALrF2CJjCPzqKx4pg0vt4uMv0JzkEI/VhJ42PhUuo0mrjHv/kanylyw2n900KKSsDsfScjCIsbvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334771; c=relaxed/simple;
	bh=CRrJJh98wkJ/3eHjWu1bO6fuVKjaUIGf7VJGUauhJko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kReqcsoak0Z8gCEmr0zrpDlkFdLunu6oXttlqayMKtmkYYExJBICdFFWm2LVEsJuWhhOkKfGrmIYNEGvJhylI6uyUbi50JTCZ890K59PJJiQE4IlO3nj6WZkrL3Ri7xtUc7qlSR3oDQDXU9G/cUudNMnxOc/BarBvzx445y7PEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eS/c0CA5; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiAIHGkTWSr/ILEQfMh9tlkA7OknDQWDOXj5w8nI4LikwMfeMhsXlAs/lqtjllDqehuuhjYFzmIrC/Y5uOP39IJxXeBeNCEqJB/ZcjkLR2xUDW+4idr5x3Nqfjx0XM518oKEDPKz33bZehBHpg0uU0TUTC6QnVwKrGh0dfPAg5MyEQiwcs5cQ0oaUr+wG2tHexur2b9un/HiMZh+xWtKkAWnzMKRm6xrWIFnvDLM4C3NYSkyk4sl7xo5Gy9PPrgO1YUj9y4eYc1CtaPaF0ijGDqaBzFBppWYYvIO0YG+xL3rg4EEYfLcIyt0Np6WoZDA7T/IKwZ/tnIKSJo56YT7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyxpSu9rOP+p/e5CbVuuJqxBVVJ4oLn92fsUgwnA6pI=;
 b=EwQuxnAz6m4uJOI7Q8sdb1QY6pijGUsV6/aUIi8alDjiCOBhdiRvRH0IQhg1hD3s6sqnZlQkjsMmnJh0qR7qYHidTi2F3vp822MW4rBxILhhtzbqlGAlmcucfB3KFyASaiGCqMOyVoWkJcnGAizCstFQ0BvDo6rQsxlm/TTsZYjaBdHzUJz/XeM1iEiffB1YdDqyKfkiWfGYIeQeeRNJ5NrruoWYhhnSmTD9QwOfxtI0CX2YDkUUrpknBQuwyJ70puCdyIxYoYGmRWivIsIc4qO72FY2VroZDPeak22y/bJF5t45cHV+62TsGycsWYLpqAYdO67W1mbVQp4xytqVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyxpSu9rOP+p/e5CbVuuJqxBVVJ4oLn92fsUgwnA6pI=;
 b=eS/c0CA5ZO6EXV3dcWlYh5g5HAyJPingzfUvNbC6MCKEYA+jEhDJ/B3dvxjwZB4uwJ6rz82Vg95wenj8zPPwY8Vjer0f1vFG8xWQ7zzZxS7nrkvU+GjESyyiCWPCa1eih24hhwWBYYzsz2ASZMMKkd32ONlCC0QXtFGnj+SEsCfPq0VdcB8y7AEyPQsTHNw7MkL8taszW96xtmgxSWXa8aJ0zMCXPUrtI3dVoDb7g8CTyRuNr/DiVv7X4N6CbUCcEvFlmBFDlrGMzMEVquoZMFI6irno2St2oo8+5+/LEufJxd/XDKIFkep94Hftbg1+lopemUI2BLkIqvOce+l6sg==
Received: from BN9PR03CA0942.namprd03.prod.outlook.com (2603:10b6:408:108::17)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 13:52:45 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::6d) by BN9PR03CA0942.outlook.office365.com
 (2603:10b6:408:108::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Thu, 22 Aug 2024 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:52:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:33 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 5/5] selftests: sch_tbf_core: Use defer for stopping traffic
Date: Thu, 22 Aug 2024 15:49:44 +0200
Message-ID: <7dac3bd8f776741a9816efb03c672c4887765ad4.1724324945.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 234e8a43-31b4-4f4a-b326-08dcc2b1b369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4PnpTAe/Hf0kZf4uzcq/vdYXsNQAxsixtC7/bXPjc22m+LV3WVQvA2pnYi81?=
 =?us-ascii?Q?s4Kv/WY2yoCzsceOz5KaSQiqAYP2g068rBJGzuQCJbiJW6mR4wK3Ex2yNWNk?=
 =?us-ascii?Q?VPeT5+Xp0ygy1rmWNZVqq/2CQFxaegAXlKvOqUN+5FjE30i2bdA0tQ/AmlFE?=
 =?us-ascii?Q?GALQY7I8zA2Op/O8aVaquVfjHhey2zJCki7TAj5vMMKWBc0fpI79lQ+G7hUy?=
 =?us-ascii?Q?hSCuKpEnXFGHvTQv/2RvEfdzPL+XGUPNNZxcrYETzsiujY+y5kFQvI0ZsUkC?=
 =?us-ascii?Q?x2DrwQElsQ7XvXW/GCZfhvAbB4qNDdn/pe7mVOQdwKryYTYdVRaJEAzLo5Io?=
 =?us-ascii?Q?ovdQTYhJGrbJwej12cnNF9sMnRQ+HhqVhY943o/NA+7ilBZg6zuhpUQBNaiZ?=
 =?us-ascii?Q?C6dCbjjVP3crvAc3clMee0N2Ga8lcrFNvXYgKj6jFtx7opelVar2lUid5RQe?=
 =?us-ascii?Q?riV5tfxNCRI979zVFwujAvQJVzU1SfQ2UMbQNsr8vuZX9hMhiUbtAk4C5+AD?=
 =?us-ascii?Q?i44cCYvZ4f9kK52AvPkZ5EbdGbkh4RkKb6Ca2ry9irmlLGDBfflVC04sikfX?=
 =?us-ascii?Q?NUWt3BFPafRP3L4yijm7NwY7Ig/GzkesCXhLIrtWBo97SAxX8QshPWm98ef0?=
 =?us-ascii?Q?IHTCRbX1ft8W18YDTJaX0+ijMN20fJUMbdJmLsM71ctbmDlLlsyorYlEgqo7?=
 =?us-ascii?Q?fcrB/a0I6fAIO/EqjuUqHHnJW4eGabr/VrENk4QSNI5A4KwYW1lHLkOEUlF6?=
 =?us-ascii?Q?tR8qXTdMJWQWwtG4VuNo5VvsXaPm/5Mqd1Ny7dEmpESW7H7Ch8FSL+7+d5l3?=
 =?us-ascii?Q?3dpGQMRPsPJn1fXqYOodfRmukmTqZxRopfaSVUfpmWdbw2/nKpRXYhZe1rwH?=
 =?us-ascii?Q?OgutBx00TC/0zNCf4AtpJhPaTju0uxfzVj972sncJbtriQBpxpOgWBEUshgS?=
 =?us-ascii?Q?QK0cbHdFnGLXu3QyUBzQrvCTyuJt5hen7loxBfRfDQHQ2ce3tNATVUql3ps6?=
 =?us-ascii?Q?AMVB0hEEttqTbveN6Ug1dDTWSfuAIYE4XSSmffq7eZqFUZQk/Y7fnWuqOV6m?=
 =?us-ascii?Q?rw0NQ0+wWMtXHO04AYJ6awXMLu6+j5v4ZkbjvhvIiVC7Cv6l5UpvkiSClncW?=
 =?us-ascii?Q?Vr4l8l6TFfTf4CLyq2VV55JxAj1ojCvkCxiwfbwf+SKQGngA50YC8LkE9YpP?=
 =?us-ascii?Q?mzhxy8nMJhRTIlf2zWAfuKhvv9QB6tS1DrVRNOSEsb2lATxIQAiolOtqrC29?=
 =?us-ascii?Q?rLKiQjz3eWDFP6oMUpxXLThVDEtFbv3ottfN2Q3Fd6hRgHnvgkGZj1qOrzg7?=
 =?us-ascii?Q?waudr3miYyu9VrGihwZ06EW+kwUFpBZ27vt8RsbiGxiekOktRzshxxlLs+5S?=
 =?us-ascii?Q?MsHmQjrDgrfvHKLVhKep6l7Ei7fSpqpfWyoFlmdpXpCg0Q3FBUgblGNlQDzu?=
 =?us-ascii?Q?ICl4T9onleLwFJEpik7A++2Th+UXwyWy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:52:45.2785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e8a43-31b4-4f4a-b326-08dcc2b1b369
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

Tests interrupted part-way through leave behind a running mausezahn. Use
defer to schedule a traffic stop after traffic is started.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/sch_tbf_core.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
index 9cd884d4a5de..5d58c04e055c 100644
--- a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
@@ -213,12 +213,12 @@ do_tbf_test()
 	local mbit=$1; shift
 
 	start_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 2 $vlan) $h2_mac
+	defer stop_traffic
 	sleep 5 # Wait for the burst to dwindle
 
 	local t2=$(busywait_for_counter 1000 +1 tbf_get_counter $vlan)
 	sleep 10
 	local t3=$(tbf_get_counter $vlan)
-	stop_traffic
 
 	RET=0
 
@@ -231,3 +231,4 @@ do_tbf_test()
 
 	log_test "TC $((vlan - 10)): TBF rate ${mbit}Mbit"
 }
+defer_scoped_fn do_tbf_test
-- 
2.45.0


