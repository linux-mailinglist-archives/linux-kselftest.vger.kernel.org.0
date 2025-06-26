Return-Path: <linux-kselftest+bounces-35893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE8AEA6A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7791E5674C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FA2F236B;
	Thu, 26 Jun 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ErH3H5ZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82B2F2344;
	Thu, 26 Jun 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966536; cv=fail; b=aX/BVABHBMeeRNxFqk6ezNRdUDN0JurJv0E2B940XjBGAnNq72aGQlhv0VyLEjnqnvVYnvIOjYTSDH/tpXSa2dqRtVwN1/N6+nzzRdmLMLjfJahosu/yO9azpegiKrFYevAqHIaGk7AIoZ4eesFuHlZDdfjnQI6egS1qFtNFguU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966536; c=relaxed/simple;
	bh=px7BcfSoMnFdPt4EUc86fBOuM3g86Mvxl9z4vKOwhzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doNeBvDqDcOOvvIj8xZDME7D2bveLITJ3MZJ+1R1fWlycqPYg7fmMqekUS8Sg8LP0eyCxOKjHt6DtaW7m5ODT2QAVoA+K+/XmOaQfpSBqMOhLxBZyXb+j4e/3vWmRTVqOjq2r6+pZ79ZXp9MJ3Bwcuw2DO25nUVeZB5jBC7/IXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ErH3H5ZK; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oITPN6eRYPNTC3vywi1/Rga9ZdNVjVbSIQ1eFFAbqWbWBdc+MLVRPKcw0Xz1WvNfIus1nzzxG8EJV1z/WOAksYfp917amKxlftKAqm9EwKain7G5ZEbNQaojGmDrNxOoIO5JSaZnw/2kFscM8brhfb5v4gbv1R+5qs9mmbyhXPja4rwbk4NyAwU+a36lZ0nxLQBOjKwQulm6zqEKjxctRiFcmhfFCFEAZ4O/+3xuH73lnFAeIcbsq/agF0mhrxHAp5NshOM/yjObDvF/CuVVPdeyn+G4HGf7/39p1YVVALcRMUn5esvD8w53DgcUUgySy1e1f6f3RmgjlDQwznq2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccZVjVbJQ05DMr3ua/2nFgUlB6YmUBD5893V/grJ2RQ=;
 b=RVCEyUMA2LJSTkZphLbyoWMr6qr6jTb9x6iCukoxuJ99TpQT2Thm50wo4mC8g5K2urXjZ0jVYebcfA/c6Yk/92hwMdKnT1NUtUox9dlO7Uad2k+W/+O98NHsssSp6CDsOtRxWANLwPGvXi8h985a8tMIzk9VsGEFnmnjc3ObqzmVg6Fs8xv9rl+vjtZdmv39acoDtSXvoCkztmhvbFn1jVujDAbM7kv8Ul8qiG2JiIxv8cqux+NeqQDAYHwuNSUqiTnZYF7XpKiIBs+4qOy9GeeIa49VpJCRO/WUXoyx5i/RCcGaHGun8nWNXqY0w9YaaJzv7QZhFrKueNk2OhLhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccZVjVbJQ05DMr3ua/2nFgUlB6YmUBD5893V/grJ2RQ=;
 b=ErH3H5ZKB62OyN6doTundZtijLf9TcOrdv6mSmM4Hc4uQYt0rOyW6f3WewCZmr0NFs2PwpQtvMg9eQbuqx4wf5+FnghZ8/6gG91Fc9wY6A+ZlKnErjwj0uAyEaFB0IZt0Xro5RwBNfb6W7elXG/nmfKo3fiMivXR+eT8lH2B7BIiZfy5TQXzwjoo1PIfBRpRcqMLsfYTFVoJIo0kgqpLQb/yiKjYXYHsLvMbzSJQOxmZyTn6epwxrEoSoO2ytPyn7UXyXmjeUF9QuiqM5VG9j+cwuKk7abHjo70g3kn9upBR3FnOZ5FWQgt2YJ12gMLrnm1dw0Lw/YViCnTgbnCc8Q==
Received: from BYAPR06CA0067.namprd06.prod.outlook.com (2603:10b6:a03:14b::44)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 19:35:32 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::c0) by BYAPR06CA0067.outlook.office365.com
 (2603:10b6:a03:14b::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:12 -0700
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
Subject: [PATCH v7 06/28] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Thu, 26 Jun 2025 12:34:37 -0700
Message-ID: <eb95d6dd2b107c0cb9120df2a013fb2f4140f6a0.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d5b7be-fda6-4b26-daaf-08ddb4e89d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZGn2hfuZdvSletqyi5JWZxF5Mm8ImTG/Ro5RzCbim/gZyQEC+SnIE5J45S1?=
 =?us-ascii?Q?PZt5s6gTZDFsHiD4P1CdwPunpp00T4A5hnjsdpnsfOIMKj/kEoTNb/gyYtJM?=
 =?us-ascii?Q?g0kPDX8nlq7HGplG+zfqQO/yp+qn2a4rTgUfhMs9dQSQH00XBcNvSUcwxhHY?=
 =?us-ascii?Q?OWMhcDDW4g3HLw6DlNq+ffb2wO5KqjpI7Mzwfr4Ud9Bwylx1oErQJFmH9yhW?=
 =?us-ascii?Q?7F5/f8XAHeG1Yqyw9jQuRSKi8LfWGq5utp5fUFFu2ikq34JJLGl9QgCGda6p?=
 =?us-ascii?Q?sNe99PKuti63FvNCloTcr8MI92HUq0oxAGpq0VmEdcUlr5S7Rpn1bDOMhV0U?=
 =?us-ascii?Q?TvCVxNX45BPC8px13VWG6g4XFoC3XzQ32LcIp88rC2dRVUo0incHWQORGE+2?=
 =?us-ascii?Q?349Hi7V5iW1TruenQ/uqDGh6Eoml6FpqHj4drGEKzS2+ABbUvcoBd14Q7Y95?=
 =?us-ascii?Q?eLZhfgKczJ9lPyiRPlnG8zHSsdc9Zn7Imkbc1lBPtm5knHpDR4Snns/C3vW4?=
 =?us-ascii?Q?FCm2NC3wH8dTjPMRZELB7UWSXDLKNtIPEjjfcOymm0FSiH/DSkyN6haJixCZ?=
 =?us-ascii?Q?IFRiqP4DrdNdI/J0o2pswe84W53eHtEc1x9bLBEM3yhTPb0tpflLeMIYkeXR?=
 =?us-ascii?Q?3gEKzAQX0vPQ9jg/78r39JBVK1+SOrn4gft+1BvCag0cE7HnKpxYUa9J+kh/?=
 =?us-ascii?Q?OBRV907pS4NXha0K1z5kcC6y6UVbZSBVJbMXdr16/vNJQkRECShSD/PtqHXX?=
 =?us-ascii?Q?DgHVj3r4uvFJxQGbQf0NynOtToRanhH2OD3bf6WTWo+fbZzjcAMCHF3nOo7i?=
 =?us-ascii?Q?d0GJIrc39hVMhYqMTGxqqOVPRzeuPmXArWxeDuADf+xZ8PxBaadJKJhpBEl0?=
 =?us-ascii?Q?4n2l5OfTtATj9rRRGFZfeZqG8e4TrRYhX7zBoDePzojpPJLWgCSGi4T8DCaZ?=
 =?us-ascii?Q?uv4tXZDq6g/AOPx9KN2RBbhGX4NnrsoDGOdp6kj3aDVASZb4A6NXhdGuwi9D?=
 =?us-ascii?Q?6GrxmKN0ty9cNzXFEFoCKWw6GZGsN1PjpIt+tu+lsu1hxkB6LVqHCMPpIb2h?=
 =?us-ascii?Q?qXJD8AElhvW4h7QawNIfBLpxoa+pb/TEP2gJmFgUKlVIS4nlzbcSdjFuF5kH?=
 =?us-ascii?Q?8bjCYLNwO+dCBEEYRGFoCV1zpafE6vB21C8G9zJvY1MVp8WjN4KH1eswZSH6?=
 =?us-ascii?Q?niHaKzmAGnN2PiWRbZLIA9Ap3dTagBrKpPlK8ExnbODxXT1yCW3PkFSjkWyM?=
 =?us-ascii?Q?RykHbR9HivRSV/SslVBwYaqZHR70nzZ0tfJgI2V0yS6L2O3rgTWQGfTOjR5C?=
 =?us-ascii?Q?/OqoqNbkp8PIzVdIFKcEFvik6nJkC++Uc0Pc8DNjPxmLEOzttVla1dGxFByI?=
 =?us-ascii?Q?EN0CIgRmxx7hoovJ671Z0aJ+WHleVrIaRtTUQ+4tZHBFzzcXM0T3dxD95J6h?=
 =?us-ascii?Q?yQAFGO6UxWffrTsF5zE+GEYE0XxwVao6tuDzjwwpBGQQBtHLYH7cXYAdws+O?=
 =?us-ascii?Q?fgUtvBmblydAxCFRR3iTYTfx8gXKCYAmF0Yr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:31.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d5b7be-fda6-4b26-daaf-08ddb4e89d25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

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
index f29b6c44655e..272da7324a2b 100644
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


