Return-Path: <linux-kselftest+bounces-32704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E35AB083D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E8D17D778
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2382417C8;
	Fri,  9 May 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zacq6w9o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5D23C8CD;
	Fri,  9 May 2025 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759808; cv=fail; b=gnIsked0odtr2pw6TVU0E5j0QVa7FyY9PkTK4/qpeSUA5Nph8sPKw/T+TSIld7ImHp5LIFhKuxQOSoFI7BwRU8lJ6SLEeRacoOVi9aTD6RTUdJQbKa2T+/4BXFsJBTls8dC91T3/tZmUbvc6YUBspweyuIUBZSJkpNWVOK9CZf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759808; c=relaxed/simple;
	bh=ToHSytlFR+WYfvH2b/lx8XzwvlqLOC/8wRX+SgYblqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrxFGP9CtjEHPTi/OlBQsOwmWVEJtE7vTxRD4OsXLahWAfU+FLOHSOEeEItkXEoxi52fWzrSXavKXP1MbgYgDx47TtnQWUE7Jspggr5+czDptmC4u4H6vm1M50k/ZRHg/kKuhml0es8h2p67bnlBCJwrAp2fao2V+8o1tkF4K3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zacq6w9o; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhqvhBE77Nw6uJRkHDhT+wvuNjePNBZAX7BFquuael8hwuR7tP+S0Nt3ZpCD4dR6RFPPw3FQ/Hy4PEIuPs+49tkhYyPXVej5feSphrkCTQSroeBOvzwdl7AzmNnKjeDlXLp2pb4e0Jou6IHwSQN9NzvkMsRPBrjIyRZcUKUybDe+XrO9DgC4N8g/VECXkHJzKvm7pnL4kPZA0IokWLcrLoHdlYqy3uZ3+R8VqC9ZYpIdi1nDBytDs8ArZOA6CTSivprumjksvO4R4KhejKy93Wf00Af6gbsAZ4wSWR23tkCfPH6I0tkuZZcVQUhiGSjZ7K3JUCEqWXH4bZVpfn2oPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSJQWa/2Z6c75YJU/11syyISuOMPfndvDnHYH5c9jyU=;
 b=bFJqdSEyRRGE68Gd2e0wOzEHGuFm1BmUyVlZ/0KH5jcls2FdCcCtqfeAea4FjlMxqS3o9fRaPb/o38IQoNlNeNrYkRVpJNYmPmZ9ufWkwb7RGgjKcC2H7p2is53K5TAuaV3VOa9kKDf3gq3Xb6ajitHqi1LNos0+ClxNTrgOoAHUDs5JGGqdKpzzoY9yIlBzJjD4gi3m14zFULIWvLvmDtrbPv0vzZzIY/45IcHvlGKPGspEJj9CdC1eQxwzzoCgQGr4kouWMZnbImpGQz0trRa1se4rxLnhUy5ysRvJxn+pK55mCG08ezHHgUtu/4IwxMzD9PqpsMD3447Yt7yMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSJQWa/2Z6c75YJU/11syyISuOMPfndvDnHYH5c9jyU=;
 b=Zacq6w9o9wK044J3Gn68PLQDgfyAuPUdtt0NF9AReo8uvqN9hxS+u8aKlS0Xh2G+q8J+KxQVhQ5uQy3UZsfH+CmMFzVBG+2nXm1uAg6XsVDhzW/OjRwylxnhr4wGjU4cpM4BM3ZhoAU1HI2a8PlmnpcFzPRjQxhYglUeAfE5U4ga9NfSpZAC7hJtI3oBrXdEK3UGtvv0E1KKYU4nrMBHPIb8K2fX8QcAfkdiW6wQbr2r+++0o1Dbf0b98ja8T17tRnpMDvV1MjVOMvI6OarR6YgZKKew3u741lNIoMJSvoXeNKsYKl3frygq5z5IKXjhuTbd/2E/FSeI2ESiG11JZQ==
Received: from MW4PR03CA0309.namprd03.prod.outlook.com (2603:10b6:303:dd::14)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 03:03:19 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::a7) by MW4PR03CA0309.outlook.office365.com
 (2603:10b6:303:dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Fri,
 9 May 2025 03:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:07 -0700
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
Subject: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper save ictx to viommu->ictx
Date: Thu, 8 May 2025 20:02:26 -0700
Message-ID: <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe71881-68c0-451e-a1a5-08dd8ea60d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrDtxpvqMyjyhQYloI4dnyyk6dzt3X/9+fsbxDNluLbYNgtMp1cZKuP7TK7v?=
 =?us-ascii?Q?Ep+pK1SuZ+79AOXH+o5LhX79HvKqMAnkRWWfhWxdcOV2MEvOXFni5LJAoLki?=
 =?us-ascii?Q?hyJL8rdXVUfeCeWEG+BU95mwpUdNA82m2+wLJD7UauBDP9dEVGW/NGV9I2t5?=
 =?us-ascii?Q?R6Kb4+lvNEO8yOlS4EV7yRkgGoAxt8JwNU5ZkIWf0AayOyKnauz1vNMFb2cu?=
 =?us-ascii?Q?5QyzYW4IiWLKCq08/OROP9nnn77PH3PH1JHfY6RNHZQ83Cr++n6+yWhbvY5Q?=
 =?us-ascii?Q?c3oDJJ41nwWf88mxKDgk5rp6d7R8A6z8PwaOtlUvY/ice42WulnIQq05dXuI?=
 =?us-ascii?Q?PdvJFnm2oy7TDwn4ujOaJNeraHKi+Hm0ctKBiy+/bSQzi9ceyEEx9xFCNIkK?=
 =?us-ascii?Q?/1RvNNMrxml/rrxEsNCRzH3i7/REDklAoDF2WyzMdXm2UVZmfIesWEhb2SyL?=
 =?us-ascii?Q?sMRmTnwX/Baa/mWgG3uyAkAYiBLX3E9sBr3iJhMCwZvO73VVfJ7UUD8l9MxY?=
 =?us-ascii?Q?fueMFmGbIKHFRiib/9DD6UYtfPht6qEgzUhAchia6eDtXyIkrQJMVM24kZF3?=
 =?us-ascii?Q?UMSzVJmGFBVOsmdpZz0/MxAd+w9eSppRmT2S8aA8125OXHxrizzG7itENJA1?=
 =?us-ascii?Q?BcD3/DyWA5we04ZmpoLbOlnNdbz3Ky6baQ59lzfeJn+5rW8V9ZP4CDEfWZln?=
 =?us-ascii?Q?dXN4DzlSyJZsRHm8xAzuXT5vV9nqII8s+nxgm23NANG2bHIbAMWpKMARuie0?=
 =?us-ascii?Q?NYQKfdB6F3xkB6MP70hArA2C80go+jBFtkfKt0j02feUGYydDv+lqIgDgLED?=
 =?us-ascii?Q?xLWaPUKrmDCXQ8xWsb1CwEYs3Y2o86qFb0Ny3MiBbTwbJLX7RyvYCHOSnSlR?=
 =?us-ascii?Q?v76CYxBTy/ebKhclCQ/lKZx/EZ1egZNlsF4RNrVRTrT35IYtFXNti7xoOtcK?=
 =?us-ascii?Q?zJFJZy/OOGq4bV0XU4pPYfqW3BxskCaPzpsvT58ONcifdfaSItC1cTvNIlq/?=
 =?us-ascii?Q?Tsz7FafkFdFtjddET9oZTLt+yKEBVAuFBFkK4GBcNBMZKLrvf0dl5JqCLs5v?=
 =?us-ascii?Q?bneBKgiGSnl9T1qVzUhDB5oQ69IxHRKZjYJGdx3dNI7yMHRPI7ryr3k8BbH3?=
 =?us-ascii?Q?WNhNekBDtQoyw6znayNVMOAM+EkKQSe/D6oUVlcJ8jiL0IDaPg83fW44N/qO?=
 =?us-ascii?Q?5SXk5zaxskFYOUQFHrdgPDbfDXEFo7f2f2idE2hQVMN2ciSpMukUDhac01ZQ?=
 =?us-ascii?Q?YmMhUe8BZGIr9TY2sqI/elp2yOF3YClFRzf7HU5zcBpLMoJqzHDbYk95aEz5?=
 =?us-ascii?Q?W3dcCmr80WHpaS86WMdxXVUGUi9dC6VwcJd1G5s3pYXwDNwLyPghYHbRPHk1?=
 =?us-ascii?Q?EwItAyt9pvgUEKvtulEOYsO6WrVzMuAo5uADHZam2aOVx0CAAljY1wEJ1VKS?=
 =?us-ascii?Q?25tfQcQtzE/+2RaXnhwsb2aYNW/Uo5dI+i4IVLT1jtUfiL+pvVq7bdE7stdV?=
 =?us-ascii?Q?HXFtUPNAPtN8rejPoPSUsk/gWD2DOowQDxVj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:19.0906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe71881-68c0-451e-a1a5-08dd8ea60d16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

When an IOMMU driver calls iommufd_viommu_alloc(), it must pass in an ictx
pointer as the underlying _iommufd_object_alloc() helper function requires
that to allocate a new object. However, neither the iommufd_viommu_alloc()
nor its underlying _iommufd_object_alloc() saves the ictx in the allocated
viommu object, although viommu could hold an ictx pointer.

When the IOMMU driver wants to use another iommufd function passing in the
allocated viommu, it could have avoided passing in the ictx pointer again,
if viommu->ictx is valid.

Save ictx to viommu->ictx in the iommufd_viommu_alloc(), in order to ease
a new vIOMMU-based helper that would then get the ictx from viommu->ictx.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 422eda95d19e..dc6535e848df 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -262,8 +262,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		static_assert(offsetof(drv_struct, member.obj) == 0);          \
 		ret = (drv_struct *)_iommufd_object_alloc(                     \
 			ictx, sizeof(drv_struct), IOMMUFD_OBJ_VIOMMU);         \
-		if (!IS_ERR(ret))                                              \
+		if (!IS_ERR(ret)) {                                            \
 			ret->member.ops = viommu_ops;                          \
+			ret->member.ictx = ictx;                               \
+		}                                                              \
 		ret;                                                           \
 	})
 
-- 
2.43.0


