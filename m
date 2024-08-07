Return-Path: <linux-kselftest+bounces-14954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECAC94B0EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150E52837A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E86145FFA;
	Wed,  7 Aug 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEKX/NdK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CA145B25;
	Wed,  7 Aug 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061493; cv=fail; b=bBkqMxfB/itiURN1cSG9SQHsK75fElHE1oFswgoJEiUOssRz4lGuGJFHKxU2r7oOLTHV+K5co+Sxsy3ZNMNWPCI0vyXz7TlyJe/Vs/EeNyRUmujdqiFapC9v7Y1lsupcoPNyayB8ZRlNoV8iVLLOpO+Cg075lJfuX+SNHM9kAtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061493; c=relaxed/simple;
	bh=iQk5pwRIvV3WUIirLYhay0n1VvdIk8ABKCZtEfcrjOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ypoa40wyD16dBHA0NR5c6j3W7D7mdCidKCVqIJrdNb8qrF3B52DtN9az19s9H3JiLyG9vQ/sgw4E8VbL+4/uBy0bkHCT5ZbAoRZcow5E8inYoPUWf70+ODgvpoEqxgVR12DdIjybx0JcE9NI0OwvAdQV0ovzCF+YIH0LHHtJ9QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEKX/NdK; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW0ahweNLGWb6vwCLbkRHMunii5oMOpmeEyu4nuSaAYzeqEXRIkP9Fup3nKnM8BNPsKJkMTZlJVISD2FPQ7eqS4BqL1MYRlBlj16nwCQkxVGJD0a8z21jPKzf507FuLErtFC1Nd/AMEU6hV93LvZDBZbTZJvZKIdMidL18QXFRiUw7+U1ziJNYXSQHRuZvkKXxzmM9RqZSJTs2I+ogPIUdT9XkQcLFDit5tr+JMoi4YeY3AFgr5aS37JMmhITkY/UTjfPBe+YSAIJcXyGcMP910otGDA9B60EW983/8FUKYmuUftqJudH2X6RkZ3gjJWCjUIryhF7eNR7dLJPc1qYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztlI29zpHxKZeb82NIMRhiRfkuDoLAKoSoT28lOiyBs=;
 b=PSSrNo9jSVm30KJ1QBSkDb+8JUD+ZtAat7OtHfNVGnTeLkp4xoAHYgJbWSVZ9kTvrsc+HIBWgMct1s+Mfqo57MLjE/BNdVTeAULJhObAjx19f4U43UQH7oPrpvc9JizWDAgmfMyTiggjjK/co/ASdX5ICEVGSQtC4CQuVNUTxaptMEMTGq4MCVnQ5m2x7992WVYWuJ9uRQnHdxqKLAmzP89lFOjtZrXrpaMFs2n6m/10FdTG3aTw6V26Fq9VgSQBIeIZSdlmO0XC0DvjF1Zm44QuVxpttwollrXJEHqilUB4/b31d+OZP66374lw5yh9QkINPEvTf3MPVO7j20ByCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztlI29zpHxKZeb82NIMRhiRfkuDoLAKoSoT28lOiyBs=;
 b=AEKX/NdKDDXlP7ttWYxlQyGtPAQhQLn8ilR3YQVHJ9YjNGNE2MBUzwIz8ltxbG86FH5pvA+yd5K8TyB9We0wrw9ZRaCioWUVj8doh/deZpVu5v+iMewde9rTYM7eWTBJAvSdhv2TND8j+q6WiJbfILc7S+wXalslNKJCB4REUIHxHaCWuTraeNRFf3uoLqg4I+TG25XavDvyzYL6GFrypZ5Q7wmraAM4MYQUmynhF3UcuWIyHBs933OC8WdQajj2LQNw8vFZoasBK5+3cadgIF2GhWO+QK8zIfCmMsQQg+Su2mgDQaMSCrQz6a4fXSNPp8ZXdar6heeyXmsi48D30w==
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 20:11:27 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::2) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 04/16] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Wed, 7 Aug 2024 13:10:45 -0700
Message-ID: <f89e188589bd961ce15f66a635fdbde40fca5c2e.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0b893c-4e5f-4c01-5121-08dcb71d1e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awWw7lDXuN26WLfACyYwFuM5IrFvr/RPBhdQzfIT5SOVXlHsi1/6zU4UIEdc?=
 =?us-ascii?Q?4fJjfQVdfJA9CYd0uXGFld5SnvalykA3g9tUr1G/dekp4sR4xJMn1ObRBt9r?=
 =?us-ascii?Q?JXFDHBYf2K4pnnBE/8yjmLMCH3At6gqVA/Cy44guG8iJDoDGp5eSVrNCoaEW?=
 =?us-ascii?Q?wA/CqoXBUzbqUUzwN8J5ngicqD/VvtKkYqFha8H/YqC0ILYz62uIdNutK1ku?=
 =?us-ascii?Q?BSXGFni6qt/PDCHMfyXy+5guV717jVe7QlrtaObv8Ny2x9zecoRPrrYi/ESn?=
 =?us-ascii?Q?K3SdGCfJ8lLmezpvUCFSOJoRmMDA5TlJsVqXRuYe8v/MNMNe0xcMAQihfDNN?=
 =?us-ascii?Q?0v74btBP8Q4SJXGUuKreF8zkdYuCAaZp1RMNHEBT5kswcHpPG3Ej4+4AJ3YN?=
 =?us-ascii?Q?C2nArhGrJ98iYBD5pAHIV3Q6Jtl5yQopcyViViNdh1XjOCKymvUluJQqONee?=
 =?us-ascii?Q?YMhqYIfB6ZR04sjbMdHROlcQ+75wNuVg8T5OG4dt6X4YoZMxOKj5Yz4zTet/?=
 =?us-ascii?Q?yVcWwSj826xiabiytXq5pG0soQfp/nYIV3KtzCLxaaXoUkq2ZE5qx0mBksi4?=
 =?us-ascii?Q?/3nHW44pt0paRkYEpPkixOTOY9yA5Ab4L0wucgYTge7xw+y/+dhEwEz3NceG?=
 =?us-ascii?Q?lW98jKoVGNxdu6D28z3fBO2VNxgdwJZZ9FW6le2+/62zfd56dU2RYjRIbBQX?=
 =?us-ascii?Q?imfs7PZCyAX9afLgXj9ReFHhftZJ1VP28+KG+9+7MpuwXVmmpcj+2q1jl173?=
 =?us-ascii?Q?hO5qDmmgY3pDINJBwk+p36zX4FBRzDEiVIuJ4hyF1U7skDPHRdV3gAMNFm/R?=
 =?us-ascii?Q?CmOrpejD04KHdptalImrtDrkVA+yu5jHDif+stSNHDhMja/lRAT/gO9ePQwm?=
 =?us-ascii?Q?nKtnCr0tWrWnqaaEcI3LrW7RJvH7LlytB2mUZ06z/k/PxQWbJwfi9svnUIIb?=
 =?us-ascii?Q?Hv+GoxWCljfluSUV4eZLBVJgdXZeACNIo57sCK8TbIjFkPi/SST5051+c5Vg?=
 =?us-ascii?Q?1H0PlqFaDZZWAeTT7Q3xWpI4Zg5v9iaJcC/HxODqf5k4e3X5z++qyr2TGo/Z?=
 =?us-ascii?Q?VNaLIcX6q9s8FTajHIU33d/j7hrAe2wdfPow6w5BzPzZOfe/iKwFc7kwEgeu?=
 =?us-ascii?Q?cH4v6R8LBMYGiS2XF1jkQ3cVhZJjOVNWd1O3QwpgitEF/5vyEchyPaELlLNm?=
 =?us-ascii?Q?Xm3HLR+yXBnPTrdEpvmVp+PIjDiQUw5KIK4A1qGrU+Jp/L9bBGVGdfuSRCFE?=
 =?us-ascii?Q?CYDwuyELh4Bp4UY6RkEXwEJVZDmt9fCLHREsEYoBZgERgVnswIJCv7tcVLVW?=
 =?us-ascii?Q?QlhvXBKkpWFz6DoNZXqWmSyt2om/Gn67ytvbfVlWlEmuVYdKY+eEZLMG8lFI?=
 =?us-ascii?Q?QcCrinfwmn/7SCE68KHz4+l7xtMou+3vC/8scZnv4Wns5/ZjDc4sCe5noPuO?=
 =?us-ascii?Q?8oEEAWwIOsSCO5ZUix+p8eVAGD+V0r6i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:26.7726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0b893c-4e5f-4c01-5121-08dcb71d1e48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

Use IOMMU_VIOMMU_TYPE_DEFAULT to cover the new IOMMU_VIOMMU_ALLOC ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 35 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6343f4053bd4..5c770e94f299 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -554,6 +554,41 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 	}
 }
 
+TEST_F(iommufd_ioas, viommu_default)
+{
+	uint32_t dev_id = self->device_id;
+	uint32_t viommu_id = 0;
+	uint32_t hwpt_id = 0;
+
+	if (dev_id) {
+		/* Negative test -- invalid hwpt */
+		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+
+		/* Negative test -- not a nested parent hwpt */
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id, 0, &hwpt_id);
+		test_err_viommu_alloc(EINVAL, dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_ioctl_destroy(hwpt_id);
+
+		/* Allocate a nested parent HWP */
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &hwpt_id);
+		/* Negative test -- unsupported viommu type */
+		test_err_viommu_alloc(EOPNOTSUPP, dev_id, hwpt_id,
+				      0xdead, &viommu_id);
+		/* Allocate a default type of viommu */
+		test_cmd_viommu_alloc(dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_ioctl_destroy(viommu_id);
+		test_ioctl_destroy(hwpt_id);
+	} else {
+		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index bc4556a48d82..810783d31ca5 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -771,3 +771,31 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
 
 #define test_cmd_trigger_iopf(device_id, fault_fd) \
 	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
+
+static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
+				  __u32 type, __u32 flags, __u32 *viommu_id)
+{
+	struct iommu_viommu_alloc cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.type = type,
+		.dev_id = device_id,
+		.hwpt_id = hwpt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (viommu_id)
+		*viommu_id = cmd.out_viommu_id;
+	return 0;
+}
+
+#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
+	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
+					    type, 0, viommu_id))
+#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id,   \
+						    hwpt_id, type, 0,      \
+						    viommu_id))
-- 
2.43.0


