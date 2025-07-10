Return-Path: <linux-kselftest+bounces-36910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422BDAFF8C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CFC562CEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC15289344;
	Thu, 10 Jul 2025 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jLSlJ+z3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC6224256;
	Thu, 10 Jul 2025 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127216; cv=fail; b=i3xo/LOJZ868XTX9KS82xoyEfY7vQZyfAxUykspZFsOW4xBwH5Y3hDYpP4KDTHK43yBSB3JjzLxZfwQ5udmJyzj2EGWHWjZkF/CyQxrLaAIKgt/n/hCzkxppMFKpSCvOhUt5Qq3PUfY7bX+LZeRcQSzGumwABs2p5M/2Cei4sOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127216; c=relaxed/simple;
	bh=xtgOta9W+ACqgtXngaPajMS9RIw88Si3sBl21lue4Bc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT+QJcy7O8u1e8CNQZL2vssSNyciMeTkYgTqre0AUGg02YcHFHYLrPxhPSGmKdw9qniD/j5fYu8hwy/C74lnba1u0et1pTV6CpUHGsiB4vVG1PqwkmHAB5rer3q5VdZ/gcYTVFJGqbAnVSrjxQvBTurJKWwUU7cF0tVY0va7fI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jLSlJ+z3; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrqE33i4AITFaDAGZqVpZIVEWOzL2Q4MAZutFqdLIiUuNNuBnwvILvGlZw6dmaPP785Ydh55FEPbSo/cnfwDX+XnVVUFf2obC2Qe8ZPJwMuCrp7l6EtVaFvhZFc21KiMvQhOsQU0F402lSyPeuC6RbsF8Nqppee5TuGarVXy+WhHBbvhSLDGcvXkehvtrq8Vs35b3BQj3etOFXqLJpNOZW+3xl2yfh0sVURlRij+RQp53uvPY7EXtLmYNVVbMISI0HulUQK1VS04rnwteTo/Ce4oMibKnh6+kc8qMxF3m7cYfg4+0x7NMWjruZK8BLOeijjqu9/47cMTXdjmLZDsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPX5OLpcfsjCdI3t+nTw3w4HEXttKkhit5rWu1qXvCQ=;
 b=IIsVX5JxYQQnOy4/RuG403/7wDPC38KvnneZSX+xBwd70dPIaAvcWTw4RKLepk4Eq/26jyMei7rGB61YpP/lMVvkoB9CQNFr9VIoIAHW5XcN9NGcOBNrPa07/p25wdJK3XRK9LBpbDk5HEJI8PhQzXod2YnQaYLjf7XyXmv/Te5DMEBqX0Krr877QQJVmoTOHEzbS8FCbR0oxu87/7Dw/aXT0yqPuv4v+1ZysiuoyASXXIJOiw1TVCESAZ8lhlRpa6Mv4YrlDNLUQCXoST98NGPXueOiUDQ+ZUkX1Y6ROVGvfDkFlr7MrHTKOxbeYcLl32L73zIz0EMX9ncmD8HFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPX5OLpcfsjCdI3t+nTw3w4HEXttKkhit5rWu1qXvCQ=;
 b=jLSlJ+z3DrGgRvhoSVlcunopqKkxNkmP7kdggRQF1/MTf9btcJ1mSICg9isst+Z/8Acq/luMSy00WeOWrOzeZkKkyb9j12fXAF01hpULURH49TJ8pL3TuF4N15Qdud2UphJOOme6eWm9Ux19EjJO3fGL5l3OYUDZVHQ5zlSLDVjpHYhuX/s636+E9oVEDOzWMCzy9On9ImvgQRmwfBj9O4GXglRjewBfSf66XgesuNZJc5gyCiAYpejAN93hS92uHl7rD4KsBg2TTuCNNSdK6x6pa3TVtOjQUauBbt1Xgg0wWLrRL9IVHQGY5gCNeROaUaz4OHgjek8Ysi+GI7j5Aw==
Received: from CH0PR03CA0398.namprd03.prod.outlook.com (2603:10b6:610:11b::29)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:00:10 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::47) by CH0PR03CA0398.outlook.office365.com
 (2603:10b6:610:11b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:59 -0700
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
Subject: [PATCH v9 08/29] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Wed, 9 Jul 2025 22:59:00 -0700
Message-ID: <cae4632bb3d98a1efb3b77488fbf81814f2041c6.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fa8432-db46-4fb4-d40f-08ddbf770783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bR71X8/8r0/i1Tv1LvFk5+fYujo08LrsrJmw0xB/Qs+HA2XHCT90FQyj/yGb?=
 =?us-ascii?Q?1yOphy9Fpl9ULtfmJAKZa+0719Rrn29Xg8ytf71GPu8qFXKqg1o5Atyyp9Q4?=
 =?us-ascii?Q?LnrrYVu7sza8VjCHzmIjUybJMGE/EE6faRPr+ny1fRzwJS8M5Xp62hoQ+reK?=
 =?us-ascii?Q?oPPAMY8dUKnUu1PXPBkSFtbw26d0+64WpC1L+C+zbqN+eaGUPcKvRjAI1piY?=
 =?us-ascii?Q?ZjAAFmVLl7iyhkGbI4qCAV4k6z1/I496OdcTiVRzdCnPbLJqGf0qyKuU84ls?=
 =?us-ascii?Q?oBoXVHYtQfFFNsJAN1ZFfveMFXDLIwNvjHTi+WvBkR5rHZy8cNwoKw3xL0NM?=
 =?us-ascii?Q?AGiAYlMJXyuY70YP1t6XQCzilRUla6Qv5vt0gjCUIFXjAnX0p4/3O8QhzI/j?=
 =?us-ascii?Q?MYWbfY8YMQD6SxV7DOlhwYjh/HmnLz9mDUoFvaqR6t6wZH1KM8Rm3IbXNjOk?=
 =?us-ascii?Q?Q7WvU9BoWy0gn/OIp9PHfpbP/tw2F4xf86uGiOhAcP27xPoUv+9O0+FAUQ7N?=
 =?us-ascii?Q?FVS0P7VL5+yh1kROsraVvs+1P6nfHMQZuR9soVWvGuagglimLVxMcZ8WRDGa?=
 =?us-ascii?Q?MrDTGpZoazLavM6U95HqBc5+tatz4+Yj7R2ju/MHCcuIFEKugwIqGQgFCmAp?=
 =?us-ascii?Q?o3nzN6xRfE4T7psCdxxFDiTryoo/INDIOHrSzjARVEq12XI3oldf54ocKwbZ?=
 =?us-ascii?Q?3KD1exM6EUMQ526dRMm87gKKNz11S/6nLufsECrq+xBMrhaoKpXkp4rHYWwf?=
 =?us-ascii?Q?zZvTq+BdwBZgfLwYYCc83sLBTB5/Ofz7WD8t+pLZCK8kC0FUgwMincBFAqYT?=
 =?us-ascii?Q?YOzqI4FbXsnl6+R2vTjcbqZgph7jmUSJbRFTCwAu5ptxdPV/ZbuITG4SeTvS?=
 =?us-ascii?Q?u9PgeR8JFnuxuXQntxmbVhUZGyEDowiZvRKDeQteI0oJXU6rdL0smh5aLANX?=
 =?us-ascii?Q?UIx31/LlCe/8mPI1eGuhXpeVLQ2QpMG6YDyyaw+cJkqYqZNlr3v09+hRXz9g?=
 =?us-ascii?Q?oj3GRPPEPjvGDuxr4AKZDXPX5jV2cHznizaaQ3Yq2RGxZvfH7K8zhYaIqtd6?=
 =?us-ascii?Q?qy88i4U8/oJD5+1+oIP0oQ/xyLfT3zrFlj/sAVWAW78VD0biQgwJgIg3cPy1?=
 =?us-ascii?Q?pfRrBpXMvQlYhyW9xmPB2QaxagZ/zS4hy82UADUuNHSIeESEHui9Ki3ujU4p?=
 =?us-ascii?Q?sTPY6Zdn1U6ZpQzhOq9SFvSVJL0z7FeWCRjX1orlfJRarFCJHX/EqlKTVqYl?=
 =?us-ascii?Q?rRZRm0gcDDER5f1zF4gaZcBsyv1HBMf+qnXmjDn0SuXILWntF3Vk7Cea97po?=
 =?us-ascii?Q?ajkqyvY6vMRenVF7LfFEjaOxMhAH/G75ciF5cCIfvHu/prM0INaQLcj+xVy/?=
 =?us-ascii?Q?JTI5uU71p5dTeuS0Qre4fr2rmIxejcPVqKGv94o0s+hdaGXoabQDu00V8jo2?=
 =?us-ascii?Q?/DSvhiBWztzBV3szYrG2XogLfly9VRfLNcO4bgaoxdBOWVpdGogFUSeyfZnR?=
 =?us-ascii?Q?ZxDhD7XM7ep9YkRBN8W4h4eVplwZIzx0CepB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:10.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fa8432-db46-4fb4-d40f-08ddbf770783
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

Add a simple user_data for an input-to-output loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
 drivers/iommu/iommufd/selftest.c     | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1cd7e8394129..fbf9ecb35a13 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -227,6 +227,19 @@ struct iommu_hwpt_invalidate_selftest {
 
 #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
 
+/**
+ * struct iommu_viommu_selftest - vIOMMU data for Mock driver
+ *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
+ * @in_data: Input random data from user space
+ * @out_data: Output data (matching @in_data) to user space
+ *
+ * Simply set @out_data=@in_data for a loopback test
+ */
+struct iommu_viommu_selftest {
+	__u32 in_data;
+	__u32 out_data;
+};
+
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 0d896a89ace7..38066dfeb2e7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -784,6 +784,21 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct iommu_viommu_selftest data;
+	int rc;
+
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return rc;
+
+		data.out_data = data.in_data;
+		rc = iommu_copy_struct_to_user(
+			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return rc;
+	}
 
 	refcount_inc(&mock_iommu->users);
 	viommu->ops = &mock_viommu_ops;
-- 
2.43.0


