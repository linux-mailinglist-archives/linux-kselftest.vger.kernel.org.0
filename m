Return-Path: <linux-kselftest+bounces-11274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC08FDA09
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDCB24864
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BF161900;
	Wed,  5 Jun 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JLRiyFDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147E15FA76;
	Wed,  5 Jun 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627577; cv=fail; b=S9K/LJU3VRBlJXlBEkga2cCQtlKZ2/zhb6fx2MkmoWNrNjg7UmbG49cOqS5XcDSyuNnrgM3P2rftBAdhDUfriRJN43f+tEUBU6HjWqYuNNkcbpRtohrmgyjr5mMtwDepwm6seoGpdKncbbw7nYliP14f6pi41V3bX3CayucTVf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627577; c=relaxed/simple;
	bh=tOKNDuf+n2P8XvLQ+Vohkrl3qY/OtOIaZrox2fiLgjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+oaUttdfmdEkRyuXtqIHcH+x+g/7X4kvKbHGg3rtmAi8l29JejApL0oFv3NWf/eexiVjGL1JqtYgpxdCuqoK0iOxwccYtfLWXhXtk6JScoQ4QI7g4R4ar1bVhBF4nOv4bopnwbGlDkjREeRj92P6EiwBu1BM/lb9NRkh6VKWlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JLRiyFDL; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeFV+E8Nq3c3uQhskTv4RmIDJ/Lx9wRrKakNy4chEN0/044NuwrlozewzfzjIFPe9x6HtNa4E2UBMRzSm53qmLiridS7GaqpoqGPLiq5OYjcomrhrO7n49f0JPv2Dz70PQnDosGCbxrQ+pDEoLVCCnzSwNo9PVxDKo3SF48Bq0iD7a4Qlh5E68NaOQhiY3O0wcAICem4rw1PFhsr8CUzZUnGb5YVL2gXfVntdNwo5UR+Cw8Bq+/X+rw68xLQm9cApcGWJF/Szh6KqNkmyUe5YEko/ZowZsscpmEo4IgRwQXaON/FcTWRYDr0zgEuoWBh8rhFWz+8421GHIhUbC9Mcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isEMcKyCzuZaivTl3Guoszin1uQ4GyzYUQM2cCX1b2E=;
 b=Svba4eh/jOc2EtyONUGvzDXtozbTjdxGNQQTqJkpQyL8MuprQDvhryi40I5Mkinbp3JUUCUqX6aP7WcljmGUQqkKU5paA1E8yv77LZWokgSwWkkNtaQCRU3ItEmKfsla1TBetrXXFWAUtMx1L88atuhHXTBItMe6/1GghAK+PcCoVnLQcpGmWz6aTbZlikuiOgjv1Rsen79S9JhG86dLxEK7XE0pc1eyVW4HdT2jNlsgJyYFwFaNtkOksXwjjS6pbYhfgEFzG/E9EnPsBmFnxJSXx4hJ2ycFqVnGYOgfuKIZcmFtm2wATu3TXD4ENOAjzc9hcUkg6Zh8vJjMMmILUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isEMcKyCzuZaivTl3Guoszin1uQ4GyzYUQM2cCX1b2E=;
 b=JLRiyFDLzKKObY26E1BGKV54fVUszPMHg0+ace5vGBZcArg+8qI6v7CZ7t9GuPDU5mQmpvz6nMknvLm8b/LsNBX42I1VbvsvhntOfyUz8TbBXIWx5ku0hrbC/gkfABjpHWXaHNoaMsKDA8dDkGYxYIQXBiYgpiVbu7Abc1EFwhg=
Received: from BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 22:46:14 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:207:3c:cafe::dc) by BL0PR02CA0026.outlook.office365.com
 (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 22:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 22:46:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 17:46:13 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v3 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
Date: Wed, 5 Jun 2024 17:45:34 -0500
Message-ID: <24ac6e8dba1b42aec8c33bd3c26f58344dad34f1.1717626661.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717626661.git.babu.moger@amd.com>
References: <cover.1717626661.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d0ba00-acb3-4bcc-40e2-08dc85b14def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzJ4IJkJ10J1Y7FtDfa9uzvHDGPzBIzIGR7Sec/WfYjkZ092ZEpsidSQfkbZ?=
 =?us-ascii?Q?U2eGPxAUfr1xQ7wVBU2QKMHu66cg8+8SY4N5gqVrLGXn3mcuMWQ5UxuUJzqE?=
 =?us-ascii?Q?et5p0LycHi8jn0tbCkYkaN2NOyA1X8xW0n05V3J/G1lFGNIHJl3Z9mZ6b5Wb?=
 =?us-ascii?Q?+lyra/Gohur89Drh9Sx2LotCq2Zmq6CNmuymfit5EAbrmL2QnD0XC5TcJQU5?=
 =?us-ascii?Q?wvNrTjpQHzWD2zFca+6QOXCX+pi50txO0mXxUr0lU0ie+TB4bs0GezdS9VSe?=
 =?us-ascii?Q?B/7IgChwouy3X0JOmzaWvEp/n4TuYjrlSctAj86a/dV6AjjqP9gCBHgxFfKQ?=
 =?us-ascii?Q?ECCd42XBAQmrrHhKgw0/9Ziv97zJxP5XkXxu3SydxRPhu3vQ+ddjSF3KSfbG?=
 =?us-ascii?Q?ilZsjkg+8EDurVRR2eLMXrSRKvkHhiyjCNUqjoZNAQkklJoeDiJrBizuQUbl?=
 =?us-ascii?Q?GKWtUu2ctGkeZsPxmCy13gpfoKBInZph6pcan2Fs1ttWABYBeqKBmjzz8AMx?=
 =?us-ascii?Q?Qh1sMWI5p1FE6uUOUPEbErVcyLMXyix4UPlT6vF62Qv5lNNNRqzn2zLV446w?=
 =?us-ascii?Q?0rWD0YujRn8kbUm/u4Mm4cTE8d0VpcQ7t946xrR8BBdhFoYIaEcGVi6AyzPz?=
 =?us-ascii?Q?M0Yk2FBERFFxhe9MUZWi6nPvstJl5temXiWkSUdKkvRBa606+ov7ViVY93CS?=
 =?us-ascii?Q?LZF/Qu0jfrpOdMQP5SX2ksp0rb26ytM0KXs+ZljIACDhBEXnHJoI8wZgCGBF?=
 =?us-ascii?Q?AfRW6/YzoH9CQc0Zx9I6fGB/PrOV9Y0Cq6odmMX4fH/sf98ZxPxUJBargP4Y?=
 =?us-ascii?Q?ArbYfZs6FipvTuVRSnO/N+APtJ4yvIW3QQMiWg/mR1dlcsQFeOYA7qVaxgX3?=
 =?us-ascii?Q?hQBX8DkazxUa0YIPSm5UFFc7pnJ2DUVt+Wsur8r+hXyWR6QXBHC7o8Dd1qBT?=
 =?us-ascii?Q?7VK4U3Zeg/YAqaaUSwnAG4HGUFFhy6tg9llTsS6zQC8EvKkrtd+EFKZNLL6z?=
 =?us-ascii?Q?ooa6Y3qJylzqJoZwlOTYVjNhO8NyAHPAP2ZGYFMqKdALT/aWY+C/g4BSormH?=
 =?us-ascii?Q?k4s4g+L2vX9AIqUu3zxtcbtkNIiicbxwNt0bqgW8TXUt3n6S61oSU0XuP3lO?=
 =?us-ascii?Q?DB6jDpnYl3Ee3drULzPKwAyCFZRzstGw94FVItGsLs8oD69xf4epYS1W5HLQ?=
 =?us-ascii?Q?v3w9rDL3FC+/b6h5YoPKKvaBwnXeeMqG9Ep+YxC3nL9cDJ7KnNhxK9toc0Rw?=
 =?us-ascii?Q?vLUAnO8PYHjr/A0Y2Nn7SY9a0H4kL0WWm1++ck0VVG4behU2zWajzPDLvJ6W?=
 =?us-ascii?Q?28sj+lO09BdYxWvxuL9CUkyZk0LrhW36UtjcHhuz53aaPLQx6pUxltFhww+t?=
 =?us-ascii?Q?2niLdbuIUe2gOAN49tSGbb9XePcDiTvdckBhMzm9MvlfIJ+v+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:46:14.2217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d0ba00-acb3-4bcc-40e2-08dc85b14def
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
available on the system. Tests will be skipped otherwise.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: Separated fix as another patch.
    https://lore.kernel.org/lkml/3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com/

v2: No changes.
---
 tools/testing/selftests/resctrl/mba_test.c | 1 -
 tools/testing/selftests/resctrl/mbm_test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 394bbfd8a93e..5702bb1d6a98 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -192,7 +192,6 @@ static bool mba_feature_check(const struct resctrl_test *test)
 struct resctrl_test mba_test = {
 	.name = "MBA",
 	.resource = "MB",
-	.vendor_specific = ARCH_INTEL,
 	.feature_check = mba_feature_check,
 	.run_test = mba_run_test,
 	.cleanup = mba_test_cleanup,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 9b6f7f162282..dbdb1b490df8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -162,7 +162,6 @@ static bool mbm_feature_check(const struct resctrl_test *test)
 struct resctrl_test mbm_test = {
 	.name = "MBM",
 	.resource = "MB",
-	.vendor_specific = ARCH_INTEL,
 	.feature_check = mbm_feature_check,
 	.run_test = mbm_run_test,
 	.cleanup = mbm_test_cleanup,
-- 
2.34.1


