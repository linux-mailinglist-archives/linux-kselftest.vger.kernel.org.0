Return-Path: <linux-kselftest+bounces-35910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62266AEA6E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D410F7B5A93
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602FA2FCFDF;
	Thu, 26 Jun 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X/vvP4QY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389072FCE08;
	Thu, 26 Jun 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966565; cv=fail; b=SCCm2s1uzumdRz42RcY4hhoSazsL79B62qqEkOk6tlVG9ZgBHRlzPAxLSs0LNwXh8j1+d2udC8dW2W2BOtaU3gRpoT+XEYJj7+DJmOp3S/fFy9f3/nsegJ+ecaaq3FbZbptHTRfpcpGUzFClRO5isUo00w6p3vmg76SJuxsosVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966565; c=relaxed/simple;
	bh=+uK2P4l/Nn8YbEUAgGImF1oImu/1IUfTVdUVtpGoVy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnLgPsq4ZzU3bNMN1aqGyLQc4ZDQeZgIbRd60lopokh1evUdVhmnl2pF4zVDyDomS32TnuR3pQDQCMnvXf5UBk2DVSwzYBJdLF+PTQYYzE28vihXrhcXw+7VnJVW3fb/bgTdM6jCQzTuTzd6XVdWeECDIAQ5Rs31MK9LpGVf19U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X/vvP4QY; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9VwVRogdXPeSVK6IRg9JK7QO28FVEiJuLNO6EXjvYHalvi09SCu0oohCY4u+EZ9y+9WwbVjcbYqv1BaI1wu7utKjST2RqoH5P67NgjtgsOZSfe820vCRWZb39mUjHpxZv16D1DqaeRvEt7UEqFrw6WJdKdW92hKZ5ltXQv6woz6ZW8WaaWydwx9QrgtEHf/EbU5bcGQ2RNObFeGc1dVhmg/CQY/8xMr7URE4OlovgDAVAoMooluFvdlKYSGDvqy5j5DcwUe4zaZIBd4QJiOUmQ0th/0hHw4hkhuCw0Yranlbp7F4YxRFNbTXkM8ANqiaLeltdT8mxKPotcbry0mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=cP0OfzGLrqZFZColOUNnfd6TYrhmbWqfzCYI5LPibvYenW2wovSPurkhbdfGYPJKVwxjoXMVY4GmNrKDikMp7L8kxl5EdSYRwez6tkj6MqXiqlG/ZHH9NmY+gwEKqL0Jd62cHdgxaYL3hWT8XcsIQZBUyRsiSPyZJsQO/YKEixDgP/8RPRPqHC+tKJi++qaIo4uQuWkczcyRRja1uAsOsu/CbneS4W9AfHZDli2Qiwd3f0csv861BoHIoP/sI5BTDfpwLaZ1sMHpHvdMQO0M8ax1nViXdBwFORBiufB2/aRPQpf6HdsLG4G+Ea6GPEl0dLpdAPBpqL63NejfkRVcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=X/vvP4QYWh9Mh/9FZ1pEFfmVlzBFsx46WBSWiZMprDLTxf4FsWN2xmSZido3sYgTZNlRfHpSSvR9A5WXdmVwNDwQQq33U0IJjGWf9vu2g8qFSRvFFMHfvyaz46BjBqzta60JIlVHLG3AIADNS1KpN7RGi9vtg3+jvghc64BjbhCXmUQV+ru+7rQwhB0q3fme3Z29qS48lTimBs5gx7G7nDeAjcKAkIJQ8SC8lympVWhtGubIupaPOrrgDCB6JsBQmcu3YiFnnOPn95juPmI2oT6R5+4eeSuO5QixtymZo/w0XCvusQqMygjT32a9moDsA7pj2k+w0feoEOn3NkSihA==
Received: from BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 19:36:00 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::19) by BYAPR03CA0012.outlook.office365.com
 (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:36:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:41 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 25/28] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Thu, 26 Jun 2025 12:34:56 -0700
Message-ID: <f2a76c9d232409ede58e624d3459061c548a6105.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edd6284-1c39-43a2-48c5-08ddb4e8ae30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5OXJdReYVoT7kShFm451WRE0GFGHwT3qhPpoNC0UlTG6LhlgU7lDwPEnwwZ?=
 =?us-ascii?Q?GoKfsNS/IXp8sz1UEy9x1jF6FRScN3P2dvMderDAmK5iDgUCGxudtlXr/qcl?=
 =?us-ascii?Q?MoK8Vhx4cbqsimRDakZjMmMJyLeyMip4N9kdHKU17BqbT7vfW6dRysPrNQxz?=
 =?us-ascii?Q?7UPbOyavyImdwZvBhDfgoF9zaC1lLH8MXaJfvoyKOE/am7c8AgHdMX/D9dOA?=
 =?us-ascii?Q?Rr8AsqaHNNUyVk+PSPDrSebFPDhJKVmucc5kszraeLjSyESoVwgz+u2W7hVv?=
 =?us-ascii?Q?2g1TMbRbDdcFTo8I4fP1xBGarUt+Y146QsavL7lEJDbjmQbrZ1FzQ3tDY4GI?=
 =?us-ascii?Q?MZGgq2RF/7if67GbUlo0CwSTAx2OV8g2Suq51ZCQI4/IWTfHKMNC8eENbbAW?=
 =?us-ascii?Q?1aB3tbDxsM8k9voFIx2aeYMGCdX/Zh0ZyUJGx+yp3ryc9qn+8w4HaD+mPr0a?=
 =?us-ascii?Q?hidbXu23QXz8ojyc3yjYr9sp2mkI3M+6gsAhcJ2If6i2RpZOtDMGy7vEjS8H?=
 =?us-ascii?Q?TDaesAEoywv7fXkNABPfY65WtHsBg3X4wAP/jHDgpqWvHaSTPD93D6aNRQWs?=
 =?us-ascii?Q?qjNQjbgrDN324qoFTuvXwPfbjyH/sm3SfbR8MmuxqRe4ae1Xf/eYBO+5Stty?=
 =?us-ascii?Q?WrXBL1L8ru6M8nHLwX+ANyGgeqePsTk72F/rRR4fpUyobkl8nuX6Ucn4Hmim?=
 =?us-ascii?Q?jbm8pcuGA0zaMFMLNkoqC/ZzzVywYvmiozw+9vwGgq52XQ7fhP3pqOQIVX0j?=
 =?us-ascii?Q?czdDSE6aIBX33luQEaFwi6LwBbt4nvjCv+tYTaSxRHAtbKwnMuT7cN/s3sg4?=
 =?us-ascii?Q?cWMWJYbhVxGjOEojEnWVr9oaPGywJ/Y01amQR0VOjYFFPrVXjHbfs+ITWmia?=
 =?us-ascii?Q?lgN+e6SsxoVETJE8We0LUup+S1Mm1JO01VZ0q+vaHgUPMr3vtPblOame+SDF?=
 =?us-ascii?Q?fAyt9GDOpd8YTErE/G43kjz87Ub4BaEYD5HkThsm8OqencrOjpCGf0H1B/H0?=
 =?us-ascii?Q?+bjYsLJCNOkEKGgf6a9XoAxjia4u+G5rwCXsPccF5JdTzwkz7Zzj6/VnAxdk?=
 =?us-ascii?Q?qK30y15zLoPPzdP7GY1XceB2YhWgwCoQi7YEsKJ2/e5FLzuk/xs3k1uSrYMH?=
 =?us-ascii?Q?v5bgIZMMu0QLDhrLqNv5DYVmPzlmT+gUGk0fROis+UgsmmsldGiRUU7CSijV?=
 =?us-ascii?Q?aNgAZEdzRXnFMY0eM2+tKbcXhUkk0+GNEUxTl9y8rNyAwbMD04q+k19tVOS+?=
 =?us-ascii?Q?TjctGpZP8KZIyFLmDFFyyp5hQb5Ftmm8ekoG0Q9lw0hPBEJyT6SLVY+CP61Z?=
 =?us-ascii?Q?ARvZElEY+Wa7KI8AaxAjU7Piyi5f0FtsD40RRzv9Ih3Rw21AAPutnqc6cUNa?=
 =?us-ascii?Q?TUnLT/z6Qxz+vTQ1R9goEhZWBwiaJJUZOsxLGNMsqIbj/TROt1lcgJZNlqJr?=
 =?us-ascii?Q?syGK84x2jsXZUBurJQ1a0d/gryfwdXqV+wYu+5lZ3eWjb8qZsaU4UOmBJmAp?=
 =?us-ascii?Q?GruNN7P7Q5tulbxTvEnex1zV9Wn32ywE5VoS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:36:00.3621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edd6284-1c39-43a2-48c5-08ddb4e8ae30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


