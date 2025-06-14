Return-Path: <linux-kselftest+bounces-34980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C59AD9AA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457BB189BD5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9911F5849;
	Sat, 14 Jun 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bf7UMksm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB41F4C92;
	Sat, 14 Jun 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885320; cv=fail; b=rs9A+dtNykb4n9Q9XmiNupLisIj6QZR1n+0xIxTULlEkhlqXyI0hlpyo/XQqXQzFOOMAHe4S7o+rZ2IY0a7ub9c3Mgp+Qss6Gl7cjpXlFNJA2a5lrr+dEbFqcuWFBYo4wJyqs354sZp571o402l3fkSn4E7ggqgyrBHe+tlGJR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885320; c=relaxed/simple;
	bh=908rv3XmbzCrLQgwpozwB8bpaeg56wcZiTVMCusD9jE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iy7gOmUVwtxFujvKW+Vc6omkPRgTe1ZdRO+83ahO+fBzzPMpg6ECutoKvywTcOAdn9ODFisiISOQkGo5y6yu3y/G1cS+3bpfHKkSevK0WbpRDFzb8V+UNUAg1r60gcI/Drl+/QU7pTFw4bojXJVkmiLIWUa6daM7rkT+Ujayi+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bf7UMksm; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Wx6osTSkhwy6M7LBiyN5uUoM9BFPOHO2IpcRvw+5XC2ghIQCS8qQYkIFlM6bytQKYCNa5D8dGhwEZrzRw6/UZ1xHXvdvwtMsgzQ9tB3JAmk2F4IX+s57i+/JJqav1pPLD5Xl7Wa6mcLkCqBOrqVadeIYC13IURjinaYJrKAWZTpxn+7IJHveVMOZTe5Fm340SxxmreAryLQV7XG9TihixvMrrsQlkPxZUpzyS9bC21u5f9fud4XkWSJJ36/V8o1tFB7uR29Q90fERK7KF9Tuk3cl4/yJ8ir5hMZoSunO0FVGxAMF2mvo/N0cTAmGSii+ttKDPYdXQJwXS2+psURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q2Kn0tQ2WEcdl1ky29Rml0NtaEPou866TZF/WPqEO0=;
 b=umRPIPl301mZ/WX6HEYlVQlyBTh7jj3sdm6g74t+H9ZkH7affjDj12KV9kzwNsdnoPgVL6bbjBPhWzU+Un8Riu2ueeNflgTZfnMUUWMThTLUF6MriWxeTNVKP7c1Gdc6Oa98d58zLo787GRKItjH1RLL3wsD0lMvWZQX65jpyWgdFoGrPUr4cXav1h3S6HwxxpSdwjdQLM+DeybTiAKkxsEsVSdvkVTXwscyIbpGqvlhdkW7/YhSbCAV4y22T6Tb2kzWmvTUKnAPTWaFrYz5AXGXgyChuKNNosfgpwzWgpT0FpNsxgOMrtKLMogGgBzbRr58Pdee8T225CZ9L+qJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q2Kn0tQ2WEcdl1ky29Rml0NtaEPou866TZF/WPqEO0=;
 b=Bf7UMksm0Aqj0e2PJWKturhi7OddPLGyJESDRgnzQxp9zDRxiIVQkgwu7UY74PtbMdUI1+WrQqYUOJv9I/34r5+vqmIpj1mtBDgDzED3JMt1iONjbTLRTZkxERtk3ycqJm8T6lv8Om4viUMNcxOu7iZ99yYJk+Ak0aErpHWnhpVvzQSNbDkbU9PIPQ8kSdaMMpdp/xXToiEIR3Wvf/GfzgFWFxeQD68mybt2yx9dR2lipZtii7B/OkVmZE2AVvvVD6QyCwdYREEXxsfCVcXoJ5JIl2Ex4GPG7WWPr3MMCayMrRzua3jk7ourHttJ74Hzf0bT6Ms50NVcgdlpnjOikw==
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 14 Jun
 2025 07:15:11 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::65) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Sat,
 14 Jun 2025 07:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:14:59 -0700
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
Subject: [PATCH v6 03/25] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Sat, 14 Jun 2025 00:14:28 -0700
Message-ID: <4560262a8c1ddb3def127417f1dc59bff5bff9fa.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: c7672e61-6ef0-4329-df00-08ddab133385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UwlQ+64WmyPCGTywbZd3qBUQ5WS8M9gfvneCZW8KZlA8P667rd4VbemCBgry?=
 =?us-ascii?Q?bqdVFJ9eHSjLVsjI9XNHCFg4W4vehECUQBE4PZFpP9ScY6Eod5FqNGxoumV0?=
 =?us-ascii?Q?3Dgn/YU/tMB6F8a4Vd9RzM50Z/VwGSDh0TayDVRYruTdvgbjzEsbM5+lupQq?=
 =?us-ascii?Q?D6iP6Z4XfX9TgvvL6vn/A0MQaNK5wjvky2qmHMxyn6ktj6sxk8LP/XfVrws+?=
 =?us-ascii?Q?kPUIoUEOlZprAT3URfmT3+AoroWzn/PUDMKBkvYDueHPl1vn5ZiCbQaTcKwi?=
 =?us-ascii?Q?eKDZwogiDNtjjO/VTC9h5/YG5jvvf1axRBtWT59XTs1J1cMjouraQhBg2/Tl?=
 =?us-ascii?Q?EI6LEsS3bQ5GlbjzO/gyoDbpbJftGEkTKkmuddqApk3gRPr1hbp+KvjK/PiU?=
 =?us-ascii?Q?DnvyLPaMvCsCRHKmdwl6cQtfCT3krdZHtNOD6ySB5553P8G1XQRmUqVpj6Ti?=
 =?us-ascii?Q?8qt7o634BzZco1rHq5lIh4D+zByP62TyMXBBi9QduZX4pCmdd2sPxNJRwXbh?=
 =?us-ascii?Q?62A72V5mRThVBk+w195Qi1fP3elojCH0d4HQaGKzt57LEACfpqpK2+0iGV5I?=
 =?us-ascii?Q?IKPf5BZ1ZFhqnvio1DUMcffKha/LSkvblrRit59TSVIWFukOPmYbfVNXazpZ?=
 =?us-ascii?Q?T9ThMXQvPpXUjhseTqi0bBLEJroIo2ZTalA+M95fQClG3BK8CAiZ0kvnwnN6?=
 =?us-ascii?Q?iD/KMcDt6XnDD2EuyCUZ335fLG+6I1LGLJEEiC+DUF7/6IF2bYt66WTLJjSB?=
 =?us-ascii?Q?fTmz0H/tZDGFBF8pcFC3nlB3yt9jZif1kTe/wBfIBkuWOVdEtYGwHNpb6tr8?=
 =?us-ascii?Q?9K2EfN63ByqPmf7W9+pYh3Eq50XggqOkWNNG/2UzburXdlhoHEjyd1VpfJ6v?=
 =?us-ascii?Q?EJdyu2wEcePm8HCnjcS1HO7EEHrVm1cM3jBZrqZMgK43XLts4Pzub+1yfUQs?=
 =?us-ascii?Q?GDwxe9pHal35R2xXOWaN32YCB6MFn0kvarPu1y6sBN9BXcwK50wnMTP7CTa5?=
 =?us-ascii?Q?OGxa64EOI5b1yrcI7NRJVxoU62v6Lk6hSDxsCRTpbN2QrhRPn4N5dy1Qh1/k?=
 =?us-ascii?Q?+6DVHHcz5IbRuIBER8Do3NkDzjhagIBU9OqSRQMYDAF9DMFs1uAsPB3VvpEK?=
 =?us-ascii?Q?lRJK96wAhxNnuV+Mc6HsrBKSNah2bVwHdFwNyrPu1YkItKdXH09NFgMZb4lc?=
 =?us-ascii?Q?ldM9+wl2K6f+M0vEpzbwIUYFmIjIzek4LKiDFnxh64wFnw/DMsiEmmA6iTZo?=
 =?us-ascii?Q?3dZn0QVhU2iFgEMcwf2ir0N5QwwA5NbhoiCX5LZM/oXUCkkw5KrgZw0G33SI?=
 =?us-ascii?Q?I/OThgtlDOKJsx/Hs0iCF7jYXHn2wJ7271iMILaYGcA3LPrF2lMomKK65pqq?=
 =?us-ascii?Q?ATLH0RYodbe0squRw10sPM3vS6/JtF6vF3MXe8IBkk4rI1UTXYiqhazQj/WU?=
 =?us-ascii?Q?zelI+2RMUYIiXfj1HfRZ+1KV/EXEVYp3hlxRu3jIFaacmKZv6qMd3OdqXp3G?=
 =?us-ascii?Q?csHoU9fTivMg3X14JynVeKw88rMJs9RfIU6s?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:11.2696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7672e61-6ef0-4329-df00-08ddab133385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351

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
index d1f80a03e3dc..c5eea9900c54 100644
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


