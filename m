Return-Path: <linux-kselftest+bounces-36912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF7AFF8D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CFF3BCACD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2728A704;
	Thu, 10 Jul 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ck06COoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0808289E24;
	Thu, 10 Jul 2025 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127220; cv=fail; b=pswpOGgiceIFdCU1/eo4gOOtA9aDcPcyEU46hMI+xpCPzgSavoUblRGwJ6jC8BfwrExwyI4IoafxTCROB2ZpnLPOVzv7LbFYHgGJv1wA4WU/edP7gWjlFJ19WE8wg/RqiiSzBg2N1TRvE6T2i9WA68ZnBiQtfTSOj9+z3mgiDNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127220; c=relaxed/simple;
	bh=aB6x2cTkammXxTwzxaIZkocB4xgvJzt0D5BTHso0Jgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcIRMGqSwCq3ueX7di5dxN5ctvg31lrkYCpsUyrGdBbNrZqq5gHIZ/0kMfyl2u3O1HAvNQN+PQfxI97kH1/onpRwDg9sutKCmTtvaShy/euwPnNmbtGvBtW1qTSC+BMMzCqg58VfA8DE/WSwloXBQqo01dx0UeAMQmaFfFiRKbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ck06COoG; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcZY8xXuihmdf+fmJC03uiqJO9JnUZSyG4B8JiU81UKnBy2LQl+af6sq/9ITiR1ci9D5CqHOn0L3Wa4t5eqZg35L0i7UuVUx9RrGHUmzZ+MZC0RcJanW+uEe8XZgmD9FGBwlfblJUpFHydw97WZPBC+7p8v7NDdf5t0wmdqxpAVUicqgw9xMmevypOSTZVG9GO94pfNyx56u8+Xg65B4k+qO5B9b379yHKHUr0ag7TF94/98aA6YRX8gqRp1RkT7kR/PqAuuoI4OtVJLsYrg5g409WN6UM7guqtH9g4W08qM3GfiN2cLgKDh0X9SAxtIsanN1B7IB+RVgt/4uHXG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LQZ4o5THKUYZ174sLtrAPZYklS36tvZS1bH0HtCo4E=;
 b=RxtRdz1uo64gqIzySodp+TkziFegVPhttJDnrMyAGYvxCsKSNqikg6mBmhnMX4wxaQWTDzzNi34/KVrr7K7/HEeWQ1r9drVOlm97BXjVwuIVlG8LuTeVfbFy1pXJsf9JNsVnE8kjlz1Pltin0gCv2PaJg/aEOhqmL2Yn8t5o6TRnqWH5pPaVUXxhEuXErSHu4zxbQAdEqNVSERaBOe/crVD6jfG/WzXF+azkGVujdVQiiPf0qu6XubASEeX2xifeZUYEov/x7nJxFD9xKFI7zodUdUUn/+JJUN5o/+D8JUQURSTuJo0vOdNY+W40XE4Ab2yslUkFGHj+iQiqikJH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LQZ4o5THKUYZ174sLtrAPZYklS36tvZS1bH0HtCo4E=;
 b=Ck06COoG0/+Le99uHtWEjwFyKC6eiqz6UuGE1Iq8h2F3JqqOuC+UNUZexv1YJzftpc5nuGrARFzHWcDhKtK/cQmrKZnWLttrO1+deI1377gUdL0L67SIBvXV4k0NPyj6j8QlGAihdA3z4vu0hRgGHYWj7+SNxV8NmE+hsD8SEn7tPRj5jF6ZrUeWBIBDwmSxaFyByx/NMw7MV3iAJlEYLK5Ire5jyM3LuFHU3TfN8LU+o85gUgv3+FhmDQ3LaI9QnFQfm2wVnNv5WnaUYqjp9SQPNinerm4JDGgEDzsgR9whWh1TKXuA3JI9XxWaciYigAd1NVZVx7wSPPzXni9F4Q==
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 06:00:13 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::23) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 06:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:57 -0700
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
Subject: [PATCH v9 07/29] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Wed, 9 Jul 2025 22:58:59 -0700
Message-ID: <2315b0e164b355746387e960745ac9154caec124.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 222f9bba-835a-4a77-464c-08ddbf77095d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgmduDdlVtnhScGfe2Zc66Nc/PZOpFFULJ+QiJUA5iloHCIr3PpBBw82+vwe?=
 =?us-ascii?Q?Bg9ddjvieuqC1JqKxA5MIVW4WHlXonGrkcxsbpI8/qjOTjpuH6OKNJbiQWpN?=
 =?us-ascii?Q?Irrs/AA0YsHlcI3vE+XfA8LL1p1jeeowPIJ4qLOvLh3dz4XRUEXSrpB34v1i?=
 =?us-ascii?Q?h+UIJDHjUR6o/WPh2BEPCGYfMCO/RE8uaIHSkEnzQqCnAeqePzx3xxIEg92z?=
 =?us-ascii?Q?5waQR7Nt5564KIqi28acDVRSJU3xg4utE3LvOWzqHjbp61PbSVOqP7M9eucy?=
 =?us-ascii?Q?lu0nrDXp6LE6tf23yeH6itA1G5Z2BiWqO1k/Ftgv5IWgvfzmuzuUb7hdQSli?=
 =?us-ascii?Q?esBmZaaFxFTksBO2EvTwDWbwuk2CVt8WLWXnMe2Me9i/qOGZAkzW+PSg2Wgh?=
 =?us-ascii?Q?EV8dkZFuPFPfhm8lnwxG9gE/rEl8JsOKkt+iafVO/4gLFh0qUpDwXVkAOGwx?=
 =?us-ascii?Q?8llOnXBStIrq8BjflgXM4YCGXNVtZlB76WwhdcQsxi6aX0OnHlPURrgbcSDD?=
 =?us-ascii?Q?Hh2sqfzOq7RwHnYUj2Fi4+M/z0n5UwoyV+AjKqs5fSVLwlr15oERjg3Cv8g4?=
 =?us-ascii?Q?ySulnOFGcHKvY4Ez9U3f9Y7G5YMbzD2deHbLLQqROjus8wo0yOTEiw7oibQL?=
 =?us-ascii?Q?FgYDZZNQ++S4j3B+C4Q8QETud5y//fQbsZDrFsgJF1OkwVw4BseZDLRCmB+i?=
 =?us-ascii?Q?a1NkDwOfaP1PJPgDitnwWJJ9hoq7FfVykrYZACSCOaikPDSSazN7USZVNs8f?=
 =?us-ascii?Q?XGO11xFBzYnCD/3BeGMTeihgXYdCgoCvjATVRbHDSALF3zEDMLi2D6zRpuqf?=
 =?us-ascii?Q?V38i6xbLoH4usa5QIDYmJpIo1tv04/SPMiyP4v5047j76Udw/sQlH9F9cXz6?=
 =?us-ascii?Q?pM8PRxvtGENF+fo6Bj+dmtjO4P3EoA4WNfYDOuKYUxpsCNu1YtSEP72FiR/y?=
 =?us-ascii?Q?ZZAF4TrQwN+rksLq4XrobkiuiN2M7pmdEXZ0Wqi+0YDmJOkwFNKzu9xOCMhT?=
 =?us-ascii?Q?cRnJY5oQmdsu2p4bOUN9AXOrFTeZDs8zIQsVt6JyR++5Nk4Byb1oFOgFCMgE?=
 =?us-ascii?Q?uaMcNCL+sJ1ycRQM3qhkLjJ49tPBJv968WPzHPo3hpnuVTtUTmOet8t6yYbj?=
 =?us-ascii?Q?Ni2ZOoZWdqKqpn8oILDTbFnlPV9M30aI2uMzf3CvgH2lvO5jLMt1OtYnqdmI?=
 =?us-ascii?Q?7ygPUE4cqMFGJclSh9WjZkUkJypl60pg/0P4X//x2fGa8sMA52tEpGuJUyll?=
 =?us-ascii?Q?V5eA9fj65GlOscAn5ncg54cMjPvsJTBurS/MEBn1b1C3KQZOl4q5Kvpl85Y+?=
 =?us-ascii?Q?dP4jOCP36cF0CCqzhVfKjnPsyyYNDTVA8Z4UBH+Pc0VNivA6db736HlHc7ic?=
 =?us-ascii?Q?wPhu+cW9FtYoqpwFe4BZANxX6xRLtsQoTnO1612QZenpc2k2y1Vd4TW6rCTy?=
 =?us-ascii?Q?OLAE6FGCAcKSTv9N3qQg631j5dMQ755TkeSojFhKqlLZR5JV+0Oyf3vPDdwe?=
 =?us-ascii?Q?99DSpbq0M9LJogbs+MJQJzM5CGSHWLFY3bRN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:13.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f9bba-835a-4a77-464c-08ddbf77095d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
it in via the viommu_init iommu op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 6 ++++++
 drivers/iommu/iommufd/viommu.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4bc05e4621c1..04eee77335cf 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -965,6 +965,9 @@ enum iommu_viommu_type {
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
  * @hwpt_id: ID of a nesting parent HWPT to associate to
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ * @data_len: Length of the type specific data
+ * @__reserved: Must be 0
+ * @data_uptr: User pointer to a driver-specific virtual IOMMU data
  *
  * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
  * virtualization support that is a security-isolated slice of the real IOMMU HW
@@ -985,6 +988,9 @@ struct iommu_viommu_alloc {
 	__u32 dev_id;
 	__u32 hwpt_id;
 	__u32 out_viommu_id;
+	__u32 data_len;
+	__u32 __reserved;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 2009a421efae..c0365849f849 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -17,6 +17,11 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
@@ -84,7 +89,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain, NULL);
+	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
+			      user_data.len ? &user_data : NULL);
 	if (rc)
 		goto out_put_hwpt;
 
-- 
2.43.0


