Return-Path: <linux-kselftest+bounces-43152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB89BDBEC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2020B192339A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1DA215F7D;
	Wed, 15 Oct 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ewf5glbt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BF205AB6;
	Wed, 15 Oct 2025 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488291; cv=fail; b=pUw+7npld1q1QxY+KbDvS9CZbUh55jOezFmPgEmAedFpsKjd269BZGuTCBt8Ret87vrm4X4L8wgd6ohdl4Qiqej60F+C3PI9bmlcqBQdopRlQv/tKQXBIPIrFg6GWxOEBFJT8WMYeR5VK3F9gYoYov32xK6XktK7yDLWHi3BZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488291; c=relaxed/simple;
	bh=fwHA6L03D4xF5+3XlxIzkrORwKBmC6fNsHg3TqB97mI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6Q+SlQbMZYzlV35YPgXKwVhiIbnwJtxaLI4ioswmoVj1asu878Yp4rPg4mLcvSaSuj6MjWkl27yr6HgT2rDR0knAk/aIL01CNXTBKDUySR8wdWV5u5smYZOxsRGQ/gumDyLGWMburjXpaWj6yJa41x1IR3LqR0+YF28ZpABb2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ewf5glbt; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ej1wHjB7FG1gj7URr+d1/Si5OPT/tYxthFssQh4IVwlQSQx95lhtbHK28kYP45G62rXit1Ruk6yt6DJG5rFaKNCiGSEDi/rGVhzbn4kKQJtBhtyzxgfExUzgp7LgUmxM1X7+8al5vQVAHD5jKgJ4wKett6JaTMQcuQSgkv5pRWOABW7tR3o1IwtnQVtF1NsN5otSlZZOHPGbPwxpl3gOHDIKc8son09toIr/lg8IJ6/Q9rxyXlNKn2cGGUszzxfN5spRHVy++8R7lfmtCxeF77rrzuUY9PGPzhO2Ui0lvZVu+MvEJvQ8FdNTFHjzOCkDsnrpm5DDMeEDukr0A3mdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CuQHj3ij8OAIENXgliN87ownSVTR3DlGmLlInvMnQY=;
 b=weJ4d7IgW36zD/OgZPmsyo0txJbX8ypmAevu8hy+4xCXa8FMQT8SrwxAO6cBKBhGUIyeNmziHM0vG3nAzKGR0UJcqbS5b5cw80D1X0H9JvWZJgs47FiQq6ZDj04oL61P47DfQvwc4bdXQDURzKVCGpDLIlEizT30DSWuY6fDW4YmyPySJ57UdwYTCZ7pJVglqCsK3PlwG7m8bf8FckSbHnmab49l+LqWjrpfr9Q6haaUbE6FNGbQg+2c+bOECYNkMHJvU219fccWZ/1VayMfcCJOyg/3k7nlmQ6gIDMDyhzwL5QZ085uFUSmQirbf4/9StOkb+wHGH40kRcK344Leg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CuQHj3ij8OAIENXgliN87ownSVTR3DlGmLlInvMnQY=;
 b=ewf5glbt8Cerp4GtyTmhyiBQ4a/IWY6e0fRWfSs4aDbNEc28UdDXkGXb85T+AUrgzQKZ9x3MYi27I1KY9ivCyby/uF7htERbyuQYQMrKDUoN2JWDqgZPpB/KPEDHr5v7OWCcM4bWiXeWXijU8vDs+f9nhwB2zd7AKfE+8LzsvlEAeC5++b5kQXgbbqL9xdqrsp3uQO4cPhM1sAEI4jdw8+6Gz53KVJs2/fRb/87dUam8FcD6jsspU2DbclT+vQcMbA3zcUtYN53ktjwVQW0riejpyxsDKkBWzxiRneVPCeBtjCqxqOTPJ4zq9pelk2I3cCNtlib3TmOP999I0RZvwA==
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 00:31:23 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::3c) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 00:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 00:31:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 14 Oct
 2025 17:31:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 5/7] iommufd/selftest: Add MOCK_FLAGS_DEVICE_NO_ATTACH
Date: Tue, 14 Oct 2025 17:29:37 -0700
Message-ID: <fe2398e920a8b85e7f695b25392c63210bdefa03.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: be1813ca-ee66-48b7-24be-08de0b822b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?inSXV8/mXpmV8Adtbj+bjIE62IL3jiLQPZUJQdIjzZx58aDdoLD3ETfGAbAI?=
 =?us-ascii?Q?oXpig3ChjFnOEfVjpgH+Vg1oEGIBspSQqeju+AFZRaAgSaIjQs3b086Fo5Hv?=
 =?us-ascii?Q?sD9D8WAPF8E0gwgAnemozDVGM6fWwSGzYZwTaRWQr7eyVRb2h66vTehuQ2xt?=
 =?us-ascii?Q?xZbKDDn0kBN5VNsFtsHUFVFdekwLOTmvwug1IqIukLHazXYy1jQCrRUYoIa4?=
 =?us-ascii?Q?8n0ObERVzvYybKP3ic9/KFcJBcuHLj3/4riwxjYAOfaC6nrt4bSy5YzIdAU+?=
 =?us-ascii?Q?XOoo7ly/r3ULF576thuOLx8Gw5A3n8ir0UpOSsQDf800cxL4XnYtQ+SN9ofA?=
 =?us-ascii?Q?JfKKag3OjAOn/JU1WdD7NRgqkxmC+qqn3fEd3Fqc/3CNiqn1l38tnUCnbUpr?=
 =?us-ascii?Q?WyFdVqUSEDvVL7ZLZulxZ/oA6v0a38i0vWC40KFEjpmaQIvou8y0uSXTvghk?=
 =?us-ascii?Q?h2rLJjNrA7r0S+TEeVQGDA8crsj+gd6QZxOtTb3/JW1MVXCYuyrmEJlzTqYJ?=
 =?us-ascii?Q?WAuw9/KbhREgzPebAUcPSm2Q2lWjR9dF2kOR+KVNznrVOEfMaZ6v/QaM6x3V?=
 =?us-ascii?Q?+nSMNCywkAvRqG/VpF5fBhdtecNXxi8ujP82u+fLz+bzod4K512dprmZ5DwF?=
 =?us-ascii?Q?jg/Xbdf2Fh64YbZ1sP8Kf2njD56w2CIAKRRn60RRQ9ar3pzs4yc15sovCgk4?=
 =?us-ascii?Q?sj+MzzbFE4oXW73NKQsdgGwXpGnP+++tnuL6mF3WMXOluYEN6z/f8OPa8Yjb?=
 =?us-ascii?Q?wOZU4Ikup1WXSkHoq65Do/9gveZtJY6OeqkAnTAN8xkYqQ0X4FQdnJmQoY52?=
 =?us-ascii?Q?MfrbLKfSLvHvjgi+W2a2kDhOIptSW5XccX/LU+MOdNNW8ufrMciQcpSunlQ8?=
 =?us-ascii?Q?Wvumyd30kiXxHo/YV2v6JkasMbWgz7Wf+UidTXuX0SrPadVOeX99jDkHAWHA?=
 =?us-ascii?Q?GDcMfyN7W88AI+8RsaEflGS4gH1gYN/9ZVZx/ia4xgLl0zuOyv7oUg3FFO7q?=
 =?us-ascii?Q?3yPPBQ/UE8Mvs6gNChoYzzdtsw3hS+xeeOlENoR+s+cw3rs5n7FNvw4kDsdV?=
 =?us-ascii?Q?jUOuHEhNkdC+t4OaWURj+4T/nkK6QYJvVtS1169bKFZWA98CItgi6V2Mib0m?=
 =?us-ascii?Q?PEWw34x2H1rfijoG9cTXUoDITxgzcheinYt4D+3k+pwSy+PUjK/dy7CwAIfh?=
 =?us-ascii?Q?Vjo0oTFE+A5sgKzPA5RzGnGJ/NKvtkd+D68oJJD2KbxP43WNClpEo8oKdn/2?=
 =?us-ascii?Q?DBvZ5cyvBrbR3MRr1Twc8xwi4fGlBOQ68Vtkr08wq/yukYqn+QruUVO5iB9M?=
 =?us-ascii?Q?kg1QBmTweypT75zu7a/+LLci2rt/FZpQ5gt8tU1N5WkP5/xZJB5acCT0mb8Y?=
 =?us-ascii?Q?xA8EXFipm4+gt14+ho/+IoM9jZ4q7VHnzZVhqo1pbZpL8jN/ShbdBBOwfv6n?=
 =?us-ascii?Q?oCYvvXnlVxQf2zPGdQHaamde8nFCQh2/YtK3noXneN7UzSx8dd3udIv8jMCN?=
 =?us-ascii?Q?5z7zdWojIz+xuzGqt5JQHY66O1yMs3FEy4uMXqA1cww2rlm9LvZG7TkMG6ka?=
 =?us-ascii?Q?zZ5wWVc/UqaQXQi9EZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:22.7993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1813ca-ee66-48b7-24be-08de0b822b11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615

Add a new MOCK_FLAGS_DEVICE_NO_ATTACH flag to allow the mock_domain cmd to
bypass the attach step, as IOMMU_OPTION_SW_MSI_START/SIZE only allow users
to set prior to an IOAS/HWPT attachment.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  1 +
 drivers/iommu/iommufd/selftest.c     | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 8fc618b2bcf96..7f7ffe5d670bb 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -54,6 +54,7 @@ enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
 	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
 	MOCK_FLAGS_DEVICE_PASID = 1 << 2,
+	MOCK_FLAGS_DEVICE_NO_ATTACH = 1 << 3,
 };
 
 enum {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index de178827a078a..ee5671d7e55d8 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1088,6 +1088,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		{},
 	};
 	const u32 valid_flags = MOCK_FLAGS_DEVICE_NO_DIRTY |
+				MOCK_FLAGS_DEVICE_NO_ATTACH |
 				MOCK_FLAGS_DEVICE_HUGE_IOVA |
 				MOCK_FLAGS_DEVICE_PASID;
 	struct mock_dev *mdev;
@@ -1181,9 +1182,13 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.idev = idev;
 
-	rc = iommufd_device_attach(idev, IOMMU_NO_PASID, &pt_id);
-	if (rc)
-		goto out_unbind;
+	if (dev_flags & MOCK_FLAGS_DEVICE_NO_ATTACH) {
+		pt_id = 0;
+	} else {
+		rc = iommufd_device_attach(idev, IOMMU_NO_PASID, &pt_id);
+		if (rc)
+			goto out_unbind;
+	}
 
 	/* Userspace must destroy the device_id to destroy the object */
 	cmd->mock_domain.out_hwpt_id = pt_id;
@@ -1196,7 +1201,8 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return 0;
 
 out_detach:
-	iommufd_device_detach(idev, IOMMU_NO_PASID);
+	if (!(dev_flags & MOCK_FLAGS_DEVICE_NO_ATTACH))
+		iommufd_device_detach(idev, IOMMU_NO_PASID);
 out_unbind:
 	iommufd_device_unbind(idev);
 out_mdev:
@@ -2024,7 +2030,8 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
-		iommufd_device_detach(sobj->idev.idev, IOMMU_NO_PASID);
+		if (!(sobj->idev.mock_dev->flags & MOCK_FLAGS_DEVICE_NO_ATTACH))
+			iommufd_device_detach(sobj->idev.idev, IOMMU_NO_PASID);
 		iommufd_device_unbind(sobj->idev.idev);
 		mock_dev_destroy(sobj->idev.mock_dev);
 		break;
-- 
2.43.0


