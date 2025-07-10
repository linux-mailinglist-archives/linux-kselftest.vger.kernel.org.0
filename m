Return-Path: <linux-kselftest+bounces-36930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10882AFF916
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C1D562EFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C029550C;
	Thu, 10 Jul 2025 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cquBS8Ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF73293C50;
	Thu, 10 Jul 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127257; cv=fail; b=W/uR6wG259c2ucIOrd0B/x/BzWPyAdpWo5mIcbUw/IWOxPynOSC+wNaoGJxs1zM5CGcpZzwsx2r6ODlKtcTXnTHOtuqAWDQJmL4jG2Q7FIKi+xbgKvj1bznmI6sGaITOLfR1SN8x8qzVExdPQtK91hMdJ7DKfNClctKmJNEwdAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127257; c=relaxed/simple;
	bh=+uK2P4l/Nn8YbEUAgGImF1oImu/1IUfTVdUVtpGoVy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szfYNGvxwdGn7wl64RB8EuwFf+2t0umWoboeplZN6j7RuzglwUYEJhaJgRdUizb393Wbm/qI1rl0LsGei1xB45gSbU2x05So/nwP7Igm1PAAM1TKP+kLVnxD6W43KM1/ECXG22TMfggoJcQ3TO4fuQdfzBc6Abs/6q0zuR8TmBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cquBS8Ho; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsUPieYuxBC06gqZvAKGGdHQGLUPPNaH5GfNc4oZGBhenX3ETMpYusknvMm8Og4qgZ83w+JXooHuc379CN9dVmpwCdlSyGGWuzzG0dwZLhhH52JJvpVRIrOmmWF2TQWW1C4QW/EbGzkq5gOpVC0gWveAV8lQcyHp9a4YSeA6mWf3Kwn+L1bTa6pwz4DsSSLE0apsDQmffQ3G8pLnxiKyieDUi6yxVgFHisc7uZBaZawe7ENHG4Zj1oSLpR2zUhHZZFPLmv0745XWTJuYpH90rUuUNHTJllU1xK4V/oLsQk4Y50w8HulyGUhq53SUTVZ73GzfL8nUNwDxS5CrVAR/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=gBWMeyS0CBjG30NwjLA7ytf0iBzokFo1jXvpu0rxY7h3d6HWAcBRMiE1GdfrtMNsgQGQ73oIqgE915erHMpL8+JQM2rD2L1u+CIzuiry9a/4OICzDtl+23yaX7N0zmQbOKUGNb1nqhdik9zfcDNOBeovaFSEugGIlnzlAeQwqsWTl8CG7n0kfl8hLGXtOIQxkZmZwqu4On55F02LrVvlCQxIQEEHEyM+n4C4zw3QPsiO6uiqdLpQ+ii8UTxpshBJO5FPcxAk5tGorhemQ8xYWBwsZnz4ACDeTi5Tun8PZnLK4ZFDrSIu+Yfg+WEgS9f7S8VEkSQtv39QMpzR0GvFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=cquBS8HooGn6/Oqgcj0Htd6/wTSskSbAh/c4U8h59w7CXaDzzLmkYhWw6gY0tnZHnFffVg+goeSmlCjKcDTmQFK/KjpG860bddSe5KpckBvsuk3DGRTZ/AICyUYOrul8LVyiPuioESmW94FXgL7HKZKdirtH4pgn/Hwdntnw/qMbxKe9+JqNI+uTuskARUcV429bticsFcv3qp3PGKmVyKj7prhFh4GTEodOGiTNbeZS2DuqDTQMy+Wyr0ZsCZGTYcDHI4fOa12jsaIgquDDTSmx39UDMjRWwGW6/C8jsFm0a/GUcN94p1Oh82m0UFA95rC+KMPyu8gm9zH43XFN7g==
Received: from CH0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:610:77::29)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:52 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::db) by CH0PR04CA0054.outlook.office365.com
 (2603:10b6:610:77::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 26/29] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Wed, 9 Jul 2025 22:59:18 -0700
Message-ID: <86c97c8c4ee9ca192e7e7fa3007c10399d792ce6.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: d353a2ff-9695-4a1b-eaa7-08ddbf772096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZRwSUotnTciH76fs9h+wzgwFPV7v2ci03AWjV333J+09Tfn0A5sNJhSul3vJ?=
 =?us-ascii?Q?dS/O5EgKT7XhHAySZZmMup6x9bERqQ3OP5nTmy/1IPoRhiXwkR3g9e1qe1xe?=
 =?us-ascii?Q?0P0c482ryx5ZKhR4CYxZW9yJ5vD+qLD7Ad+3lZX5FUP5bE+YYyN4XBL4aIxm?=
 =?us-ascii?Q?YSyipGFYe3Y80ID9g3aGvGy8GSRl6l/Fa60euat9SuxEBmdrJL3ZHoD6cbYr?=
 =?us-ascii?Q?IcPp6XZa6aXssh0gzx3aOJEfRxiA2h0GNBanfhylLbfOaK53n8HwuYtblp6Y?=
 =?us-ascii?Q?h/J6xbIaX49/0l642+YXizWF2l+hHJC/aY1zYBp5qwAlebPqYHPS5eVSz65F?=
 =?us-ascii?Q?sGogzDbz+YTWA5pVeoedEoCyNEgL84sni9dssBnQPPR34AKmgpw9fAQ+8Qwe?=
 =?us-ascii?Q?DDNlrh47VDwyfU1eRnBZB6yrTyhu/Uz62cyRmTGF7oLPhInTLGCOwaNfDqYq?=
 =?us-ascii?Q?pZOuKiJ7CR8PGDJM9JQvAIzRQVzpNNhg1bviYrPivgEgFwyBNHwsrIC2ZevN?=
 =?us-ascii?Q?9y5yZlHbO26Mn2AJ5ZrJHs+6tXcndDhp5nesiUAvVAsIdBtmHDMzc39mSlkc?=
 =?us-ascii?Q?axS6wifMK6OSORyNZx4DUC/UWhNfsCH9guvSVbyLkUx8bsgyaBCmpIfAGfb9?=
 =?us-ascii?Q?9pHT35CeBAPeGdCW5JEkFeqfalfkpVlPOwUCesfppYsaD/VDCnZCQjPgao3S?=
 =?us-ascii?Q?1zAIzCmFQweumt+Mc4qtL/DSzTQljUrgZHc+4KYIhyDsESSmbSWoUcaiuVsv?=
 =?us-ascii?Q?XMRU340cOQh04D+Vguv8O/TLsZSBYQMQw5MoTyaHWbbdkgc7y7HD3536MNFU?=
 =?us-ascii?Q?jD/ByhpRhGnuwUZAE0qVi2dVcCtC3LTAKHQ+3QWDak8M+eIxi7ywJN8xKf9l?=
 =?us-ascii?Q?yDUcZxMcTwfZOevgP22gi31XTyzupsZND0RpXRsgK6sM5MYriYh2Ps3CQu1L?=
 =?us-ascii?Q?HHA3agLzyYs+Qpq7qVnwoBbYMwmDQeCrsG9xCBwEkj9F8AjMOvucfPWG8zAj?=
 =?us-ascii?Q?a0qL2ZvVXfHccdvtdrVOsvsGicwGUJiaZirh12U+46snhldIx4bPxNWoarig?=
 =?us-ascii?Q?I144p1toPNjwsDjyn6+MamlFvaR207DyLx68VKCOqDgqMbYer1lCrFF+yp0b?=
 =?us-ascii?Q?jUqhlaJy4proAa43SBgAjVsw32+oBe8i2csok4pFGHu8GcczLs0Ab3Zt+w0y?=
 =?us-ascii?Q?e+tAbqOK5kTNsQp22fYG2i2K6FFfeCicv4D/vEtJTq7su0cWT697/9pwaawI?=
 =?us-ascii?Q?ga3k7K4sG+F6MvCvvrRF0hdGpvAI5nAtz5lKMI7zgRrA9KoUG75j10Bu8X4S?=
 =?us-ascii?Q?0JN9yWmw2kPXB00X/ZewuXXWbost1zSXHHcDDUAuN/jskOJLK7B8ia/AIcu3?=
 =?us-ascii?Q?9zqtwjUoD2FgMs9K9TG94/JsuT5k0chr0P7YqqA0J33SlVtKpemBqWmaZKdw?=
 =?us-ascii?Q?c8EMKPG8rvyUsxqn78A5drLwD5mO6yxyvXr0QT0mnbll7OK4Q4KuQLpTUVaT?=
 =?us-ascii?Q?0EnzgKBWh0s/hGPsk/JEgxs5X3AkfFTx5KAK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:52.3649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d353a2ff-9695-4a1b-eaa7-08ddbf772096
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

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


