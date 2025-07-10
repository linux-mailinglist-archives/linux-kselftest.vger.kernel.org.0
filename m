Return-Path: <linux-kselftest+bounces-36906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A0AFF8B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC27E1C80024
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126F2874F6;
	Thu, 10 Jul 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D2gbFogA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A8224256;
	Thu, 10 Jul 2025 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127209; cv=fail; b=DP3vwUVnxqeYAboTbtE7owhxmrcix2nj2x9fs1F3PX8MoFuA8GcfLAxfZbr+tHLxx93C2VHnKvZqNlw00/lcQcSvU5JpZ24qMEIRSB8iu1ImxbqLXLP8taUsH2Xb0/QORXXs1XUFVlXkn6jMohd2RQSXQkkrWkZPu8MkN9sMwcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127209; c=relaxed/simple;
	bh=mVbfs4A3PfkFD7Mj3imA8Fa+Bc2ATv8znEhKbkdHlqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aj8jTsMgQAIuLDUcfE+8B4b7OtGv5I1EGqmpMYlDZTLC8DTl2tG14DAEJsMD3Ny+lk616WkHqLj0Kb4XF0uWMzZHECRW5kqpdhTUhywFgxyjO+Y+JI71R2yy6ygcPu5uSJFH7UffyKM5xvrl5yktwbNNr7rLwMZouIUqlaJXJxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D2gbFogA; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrAh77bs2Ow20PJfr6EqNIEXM1bOn0RYOi7pYAeg5cGxcaElTp9hoiO8E71UDaQlGNJWWGNDfMF6qN9jqlDMwVIa3Cw6FQgAkcZbAtWtmU0C1bleYLcfwmAkp02BqorOxHw/+v19/BhTMubsu2HGgZb19L2hTmxq/qv1BD0QaUPWcpTnnjKm1yYqQDK6pU6Y7EX+bOjQpu31dq48uP5B/Q6F/f190c6nHXUlCct/K7XfhwHX8jC1f6h9W3o9wopuzi6RoXTWDUWmETdROYIRa3fI6vXjL/WqD5V5k4f+Sk/wERXbKqKV+vRDRQPoFLz6Qh/QgAlYaFdaDXN2VfQ3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuQuBJklB5Nu3RNQ1AqV3nSBbHg8uNfKvlxaY9qt4FQ=;
 b=cSpGhwn5OBdXZxZTdfLajlCVV9meoyF0JeWQW01XE2lg8Y765OSv8XhXyVAjwnvQ7TGMDa+4j1evzYAR2m8oK3Mc8FRZW1KLeCfyN3ir4PS0NR6+3ukAevmFTzoPr7iRnu50BvsfMFXkqnPQGNO909LctSc8yA5bAOUGBd1QM4Je4/8VEpE8nsuSvmtWaVEwR6qkLDDR6+C5CoFjVAnuwPOo4vqqT3ZBGfVeHI9TDxqxbgbJIXTT9foOfHKMGrouOD5D1udU6TBNG0G9LQo1+iM3SX1WHLIagMHgZ0iXa60sKqCYBVmBY7uMCF+vSx0HCC495DwcN8uwXeiMeCWsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuQuBJklB5Nu3RNQ1AqV3nSBbHg8uNfKvlxaY9qt4FQ=;
 b=D2gbFogAFPWrwwXFQpNzA1MDy1LTJVKYDO+qgqmsx186loa83fx9VAqEDTz35kbonMtZSxNwdYgQ4uH+QnUkSVq6vbVFpfqbv6kDsDbevSEYPPj842MDkske/rH8PLIEU/H07lFD8iOR2PyBZe9agE4vTSRXHM8a8UKjPz+6ahTGWIGswUOHlKKG8WhnBFrToboj/iZ8NVoVCSyTT+9NShnrMScDZjYnRvDYA2pyXXzo/kscDsUujs0ln28XDSGG3qkKFS1h2kz+pjjIusEMK0w6Sy9k0swuzcO64bGD4zYzkfPiGLtGeMI/QAa0YLAXR3ArzBajL2EhWSZXrL1oaA==
Received: from CH0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:610:77::16)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 06:00:01 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::86) by CH0PR04CA0041.outlook.office365.com
 (2603:10b6:610:77::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:48 -0700
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
Subject: [PATCH v9 02/29] iommufd: Correct virt_id kdoc at struct iommu_vdevice_alloc
Date: Wed, 9 Jul 2025 22:58:54 -0700
Message-ID: <2cdcecaf2babee16fda7545ccad4e5bed7a5032d.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b88a65-485d-4e41-d05f-08ddbf770249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EWtxGd8WsIDNFIzqysB35/5ppgzHLwfa7JmhKf/zsD2R+5UDjsTqyx2jpJr9?=
 =?us-ascii?Q?b47Rn90CX7fL2/MIeWkhiI8ouDhzhO9ckpiZc+2H2gSHpq5MD3Kr4P1Gtc3n?=
 =?us-ascii?Q?zqWF2VhUtnJD3KwChvsjxmJz9+LRxT+DCiowBDBdjOZCmOthrVjJ7cRvlbUA?=
 =?us-ascii?Q?S4Q3PzfSiXHKjHa4yIUzPyKbP/x7ADsxwziD3dshiANy22oG4DS0TeERjJvZ?=
 =?us-ascii?Q?J5S/qrfWb9LFdT4+gk02nbKWKo0Rjy8m6jocrvyCn4x9GTaenAnoXkXfXY8y?=
 =?us-ascii?Q?kruaLfL46Z7z4TGEWpot9MuMsLgnzBw6NDqT2OHvr6mn7HbzNyBvtpoQXu2X?=
 =?us-ascii?Q?vhzDrAs7ckayEi6IhhknEymc8Ew9c/Tt0xk+jsA5rriLlDWwOf5LVkLai2yY?=
 =?us-ascii?Q?+EII4sCf+KKnyZs7uuRD+O5eJYdskfmG3LYrpy84uVpFg54T6FGFTqIv6eLN?=
 =?us-ascii?Q?MPt1OuYRnEWxCYBUUXU4byYMsOAhrS/FTnKt0m6XBLQ6Bd7KHWXxX9rz9PW+?=
 =?us-ascii?Q?yQUCZYg+jRUKQ1hkDz6Fg38XqC9cad9YRdqAVTnyk2M1uKCHULXBWP7RVgul?=
 =?us-ascii?Q?CQ23upmSEvyQOflJqJOLGwvl4Kej5jFaVFNpr6/Kmd99f71N+nNiJICA0Hzc?=
 =?us-ascii?Q?MGj5J05V04dxH/So4WlIUGOwQ0gyToG/s0amFscAGa+D1H1uPeOqh9opruf+?=
 =?us-ascii?Q?LEHgjkE39FhwmgfgP/GrhG1ey59MHDflKb+9obptEM5kyTjC5UZ/od1rKqss?=
 =?us-ascii?Q?4ugMfs0D+sRrrKhmkhJL7JU1bH+lKv4ZAMGDdxpO+p5N9I+6Wms9I1JUROGr?=
 =?us-ascii?Q?JtAt+rsTZCZC0sdGEoZjOKlNsDaTaBoiwjRCSNZ+BwcUI9GBbCnNH/NUVMe3?=
 =?us-ascii?Q?t6jVR3lrROdw9xfMbl1LibgXnzPMlRwriRXt58Hmgr9Hg3u0YC7LdHOWyR+1?=
 =?us-ascii?Q?Z21log6p6SfghrDDaALPQPT8/5Eb6/g8rL+WxLp9FV8FWo+gWPz5q+oP567k?=
 =?us-ascii?Q?MiqjJamfwVOmO9ku/pDffNH9sYH+S2JsymX2UJuB1pkZtbe3iIS2vZQlq/3m?=
 =?us-ascii?Q?ofIluw6r6naJ45ip/vq1SMLHq1tBsfYxO/O+lJu0dFBwsSKt50CGlsK9yUjJ?=
 =?us-ascii?Q?zQGCDKKTdbImP1j2l9U0YFG1xWZjr8RRLNYUMoNvuZzYxW4F6ZVfWxnTQuP3?=
 =?us-ascii?Q?3BSwQHeB0Wvx0zGObEpSKEwitSb9tAoZQMGaHwjQEhwZmwVgnycmnfRVoovc?=
 =?us-ascii?Q?lk31j6Be6dXIZLHAchF9j2UILg3OzXWAIrNN2K3tf4NdLUWx1aBBGuIToAk5?=
 =?us-ascii?Q?J3ZNPWlaV7C9m+VuMVMaGJtb/GAWG4Oypr439efwbB6cD3wZe++Wt1TZoZ2z?=
 =?us-ascii?Q?fjGnY3gIrr4hFw8nOvWp6/uJGKF/OGHd4nHsVlUAVlBKFAa/TPaj3xgZm4wE?=
 =?us-ascii?Q?wOKqTEwO3WV37LkTKWgzlSfoFiG/Z9atvLP7FsElcLxtKhhBFciB20qpKQVh?=
 =?us-ascii?Q?qyGNVHJ4Gp0xzk18qT4rNfly/u3jLFdbArqN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:01.5578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b88a65-485d-4e41-d05f-08ddbf770249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

The userspace-api iommufd.rst has described it correctly but the uAPI doc
was remained uncorrected. Thus, fix it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..4bc05e4621c1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -995,7 +995,7 @@ struct iommu_viommu_alloc {
  * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
  * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
  * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
- *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+ *           of AMD IOMMU, and vRID of Intel VT-d
  *
  * Allocate a virtual device instance (for a physical device) against a vIOMMU.
  * This instance holds the device's information (related to its vIOMMU) in a VM.
-- 
2.43.0


