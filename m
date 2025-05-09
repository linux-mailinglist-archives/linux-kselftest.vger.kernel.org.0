Return-Path: <linux-kselftest+bounces-32720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C0AB0880
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC62166D94
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660792512D1;
	Fri,  9 May 2025 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxDZ+575"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A82505CE;
	Fri,  9 May 2025 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759845; cv=fail; b=P9aH60Yo6ioCA6GjM0G6+Qf9mwtlozTvde8M4mV7MNL04fGxOIiF5d3/fer+S9AkNQ10PweuZSnyIUG9oh/Td41jOZSoIgfFCXHbYY12lJnE4F6iAQ+ec0MkldB7TNWBdxf/OeVOEaAtD6/e65h4vG5ETYXZ9ntlMQxiJT8kAxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759845; c=relaxed/simple;
	bh=h/TJtMK+QaU20NZlaQRxNLR+WBub2ZUTg3gTBrv7Tic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aP0MCwABiQkqk+fSDR7C7VGVao2Uk1+SRmqez7pso3xrGY/ODOyvNffuD0i8JbZpjb1KTeehJ5TIpN4LlEY1qpk1DBCNJY8rYU4UZ0pUYcMFLwZI8YBK2a3mQfKKCZPjRsDEZiVUKQVm2Zxb/LhqIEMSpOFqUw7w1weWezKQvxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxDZ+575; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HunV7SAd0ZZY0ouuavJf4WYy0A98Yoh2CEhJpGGA38Y8s6719qxOg0Igcd9WH5jtDmjddtHIZz2wU7CdZG4lU7f3bpchKzBzOTgUuCnbNYHhLMQ4PRmG56J6aWij58en5hD6to7t501v5pBWqF3xQcXHYv1K/RrA4k/LhI+1CFMfCitp8Ix+MaWapn/nyMVhh7zKzeQ4d1tBAlTgj/ZxDmMybYhPo4/Cv6P7dhg+040xG8KF0sDHTwGn1Rvg5+bvTDLSTFNki6s6Aay4KIGQ+mOiZjz1YONkyHfoEVjwhbkYZ4RIpxivzS3TIzyAtTs7j9Yy3JHpEQkS9oieBBX7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HddP0HhF4xzgeFJWHv4I6iAgtw4GC2FHhJ1cnTJYrkg=;
 b=pVorbbAVfh7uIDEI4F/WD44EdEXKO7yD1Jp0niHVizBMar/ssX/12EQf4JDvtB39N5khZBa9m4nsFMCqnIW7oGkAPc5wyRhjsdY8bv4usywQou8+ILxyiUuJdW34adDwnk87n1g5kYhw6F9lPn3gGyETOMiMUmhEs+Q1cEXOBlNf+bGz1zl4eslS0295GneYq61lo4YQUeWSxOvUWC8aT3Gug7AUQZLof0nuzjf9zyHspsF69hDY6CcU6zAFoMUNhDVvNzo27OAqGvsGMm68mg+2DBz+usr6zElbbcJ2GIGKg6Rwa9uGWCPZzyN2lfjpDqIYOUMHd9ljI/iEHCmfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HddP0HhF4xzgeFJWHv4I6iAgtw4GC2FHhJ1cnTJYrkg=;
 b=bxDZ+575XMBdPpNBLmb56UAb/2H56RHB6sDMehJ+LXJHPSReBZsch3jJa6M9ab858gQyN/vbjENz9NXD9MNwQ7rB+8mUepXV/Z60djVGmSPzclKzujXa2Wv+xAXZEISY5xwA7Xc+2Bprn9VbGe4FolptcsJ8JMDjd38L93pePXnuWvGZx1bH13LCgZYkdA3ZFXcsX4HQuz7qtHYxjWFsyoH74gxeRlqWI51p8uRLVYWUfDL11pr18lIIVJT/87+d58zzva4KAyn5hK6Z8kbWoT95U5DkzJ7KjFXwfFFZ5/Hab/poTmuD9zxUzn28HxoiFoD2RH5fLi8HzhO4+O8abA==
Received: from SN7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::15)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.38; Fri, 9 May
 2025 03:03:55 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::ff) by SN7P220CA0010.outlook.office365.com
 (2603:10b6:806:123::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 03:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 20/23] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Thu, 8 May 2025 20:02:41 -0700
Message-ID: <9d4d85724f872033157ceb576bbfe92102261248.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf56793-031f-46f3-8f0c-08dd8ea622a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxMGPsVpCKS5AdfApx99n2lrBaZ+44T/9PETrUDl6Ds77LKTLQzhhCawacXf?=
 =?us-ascii?Q?M2cnfKzffB/iO+nMQ58SqpGmTY7uPziDyDkc3g8wEhYzb7ofhyq5oeAJHHEr?=
 =?us-ascii?Q?q6xttQ/8G7uEGt5/Ee4hhPFs4rUsL+u3CSd3th84Pb50NxtmVP7qfqmQFpVe?=
 =?us-ascii?Q?ts9zIMTN0VgLQTnrpfX+L3KPC+8RJiM25mR6BfYA0hnYkti18s9KTZWptjDA?=
 =?us-ascii?Q?N8J8uciqNgjUGM3EzmaFMuqe0MUzX1QoX0TV+hzGDiOxMHhr1ll5C2r1cG48?=
 =?us-ascii?Q?7oFZ2UXlVQAfpkuV3J2oLxbWG2G9jZeFZi+GMj4BS/QGcus7aKLliYUvMLYG?=
 =?us-ascii?Q?/cShXdCwcUI7SngHsald91PZpCnVl6B4q45MXWjZdJcr0/Hb4ISyGDcMSf5q?=
 =?us-ascii?Q?wpmq+dVimKJhUmlNSc7o/R+F/TCyV7YmpDQVVM5kYOAhlfo32Af0eYGg/01B?=
 =?us-ascii?Q?TIjSTX84khfumeO/qAt1fLBY5myicnxrOy9khRAyDSmOw22b7f4NRzV9/gsa?=
 =?us-ascii?Q?hLN8PM82SfgU+aO/85NBqy9lq5ws3z3NELDGeEkmgIRF3fZgsdMAVAK4hG3h?=
 =?us-ascii?Q?o69M+BmPtC0OpcwP7seTdL0rSau+1h0lrDwmz271I1IP5D6okfStqSXC+Vnc?=
 =?us-ascii?Q?1fdBg8LuOOfeHogiH//fs13y6opP93cE8xeJqq5d2JZRZkTz0claRWjZYYMh?=
 =?us-ascii?Q?c0qxI8sl+vPUwl/5JnH1IVNcPygRORa2i1AsQcCxb6tL1XMnl1fV8HjOgFXh?=
 =?us-ascii?Q?pDk7nzLVTLsWZxm8wq0GlNVj/Hrvit6fGxD+MnDPx3xsJlEk2+vnhX4+zoNz?=
 =?us-ascii?Q?gIs157l7ysEwmTuIIaIZBZGp5fiXQy4vqu9X7D9RPCYX4+XrU/8iOtpFPSPw?=
 =?us-ascii?Q?eaHXXPZtpRJwXh8f0fMJE/R7KjCwwthu0E71X5Gn4G7GwkDOjQEALV4uTakM?=
 =?us-ascii?Q?klJG000sYNyyyVHQiyhG1WPVgyHdWlWdTjqkvMzQkxnBbfZypYZ1R+mKEJ12?=
 =?us-ascii?Q?F8HDXxL6xedvNIki0z0l2tr0aFIbSe5t1IzzfOIanBSRMa2dJbOd7/mWBlk+?=
 =?us-ascii?Q?BZFo4PzL84AZ8M3mky1V8Emj2/27tQuCkVEijQzx3AH9kpP84r++VVqbISS1?=
 =?us-ascii?Q?+N8+Fru3aioiyWjh/nvpg2fiIKv1CRDVsytLqDX9L7zsCG1BT9w9wk/5tI81?=
 =?us-ascii?Q?FRExVIIeSU6+ujsYkOt+84DfWZEE9oVG2vAHIjB7Eq7AM7TCCkjrfzcD3JgM?=
 =?us-ascii?Q?IxYSx5Y3qV3uCpT3QzbNdWjIOenszniGeHJ4dKS3DlKzZblftOWIzBOLGQAk?=
 =?us-ascii?Q?5YqkHvjRBUwLaQItlf1XkJ3Ntde5HHZm+us2aUzf6U7SDUr0gpgOlHwCgDex?=
 =?us-ascii?Q?NIsOg3mZe3lVcTpStwBrMiuIEkxOKS6rlMeMPRAOxBNxwr9yuAIfpP/zh429?=
 =?us-ascii?Q?Gl4fDJwEHYMz++/Gotc6qKHrRkuf72Jbmj6WGMwT5kciN3+ela+83VhvZe7D?=
 =?us-ascii?Q?2yh499pyZsSBGZSqHiU5KpeaPQs5bUbI1FLj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:55.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf56793-031f-46f3-8f0c-08dd8ea622a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

The current flow of tegra241_cmdqv_remove_vintf() is:
 1. For each LVCMDQ, tegra241_vintf_remove_lvcmdq():
    a. Disable the LVCMDQ HW
    b. Release the LVCMDQ SW resource
 2. For current VINTF, tegra241_vintf_hw_deinit():
    c. Disable all LVCMDQ HWs
    d. Disable VINTF HW

Obviously, the step 1.a and the step 2.c are redundant.

Since tegra241_vintf_hw_deinit() disables all of its LVCMDQ HWs, it could
simplify the flow in tegra241_cmdqv_remove_vintf() by calling that first:
 1. For current VINTF, tegra241_vintf_hw_deinit():
    a. Disable all LVCMDQ HWs
    b. Disable VINTF HW
 2. Release all LVCMDQ SW resources

Drop tegra241_vintf_remove_lvcmdq(), and move tegra241_vintf_free_lvcmdq()
as the new step 2.

Acked-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index ba029f7d24ce..8d418c131b1b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -628,24 +628,17 @@ static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
 
 /* Remove Helpers */
 
-static void tegra241_vintf_remove_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
-{
-	tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
-	tegra241_vintf_free_lvcmdq(vintf, lidx);
-}
-
 static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 {
 	struct tegra241_vintf *vintf = cmdqv->vintfs[idx];
 	u16 lidx;
 
+	tegra241_vintf_hw_deinit(vintf);
+
 	/* Remove LVCMDQ resources */
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
 		if (vintf->lvcmdqs[lidx])
-			tegra241_vintf_remove_lvcmdq(vintf, lidx);
-
-	/* Remove VINTF resources */
-	tegra241_vintf_hw_deinit(vintf);
+			tegra241_vintf_free_lvcmdq(vintf, lidx);
 
 	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
 	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
-- 
2.43.0


