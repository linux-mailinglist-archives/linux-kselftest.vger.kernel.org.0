Return-Path: <linux-kselftest+bounces-22781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDD9E2EBF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68A016582F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9F20A5C8;
	Tue,  3 Dec 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nMxAcnz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C051DF27E;
	Tue,  3 Dec 2024 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263861; cv=fail; b=GgWRjhjz9aMB86K1dbimmIas7V3os2wsjM5e2SdbOtUzDyZJdf2UoVrGqymTlP/JTBb7EXqvFzLobZ5eDx/JqzwaopEVIEU+v9GpEDn6KRcct1ALwoKK+iAaAD8EPRnnba2I7ePcGWTZKmIW7DCGxXg/NSJvXAR+cstDGZcTPWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263861; c=relaxed/simple;
	bh=pMxFHTf0j2twpCDHDDsiqVu+FMmvpPSlFfLEovtqtv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nio1uUyMmtwyuB8h+WsnYxqKEgxFRyNFjrLVy4304RNJGsxHt2uK+WfKsj0Lbb6MOFwqWpEc4Eq2d9dPN+hEOjlXprzosp5A20hRmVyKHPXkg3Ne+J/4SCmhGFLZEGC2HGVAsYV75k20GJrIFJEhmB2DgSPvWrZFoLB9k9a+lGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nMxAcnz2; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEmBtV3i3NaVYNjrm/YYdFYJKXXO1HqMApdgT0nGJHMosVyI/fEse3I2Wt7NB02SfWzMb1dAVDXbuohNQrDUyVu51Rqf10J2Q4+Bj+raUYbRvLtJ86KnWezEvHczYnuX0qp6pmdp86xCuubUJTI2roIpwgLTgfMmXGneZl3dOFPS5nYlMpbu/jyxIVTx1HO8aM5tJucNbEmtmeWjBYxJSRcysoLikayAkW5h1rqaYrFnWD+wjNZ5QdvVephecCLFhi/yCEqJpz9IBCyYW7jzaSAya7uyIreA1wnTwMDY4oa2wQuPM3Hvy1Q92ctD+lAR9DEwW4SSAlm0TLPRh1mJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph+GJt+zDR7jitOy7Mc9T0fRmELWyhFVLN6UN79xO34=;
 b=MnmkW0NVIHOCW0RAdmypGm9eTCYZww6MLhQGrWrXbz1VkRC5uvbjnOFmhIFFOX155FWz8m9hkR11HV7itIndm4RT/IDFuliU3tMupG8fu71/jzX54eprI38dMRoNHrsn2word3lAsZpLiFQmZAbYFdixRK9No1496NmjasnX6BuvgHiNy3KRHFi8/McmOgak+D8KXwOEz2icEwiSVZXA8glGoylLaCfcWAKQxb3on7ski4FnjY3o2amgm16ezuTqKsSIs0Gph+ANnKTA6pYuEVcD8Dh0ndMFOa78sxQxpbC7qjnhAd6uaAR3yZ4v2o6hDTSrqbOQZZffOI26reRc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph+GJt+zDR7jitOy7Mc9T0fRmELWyhFVLN6UN79xO34=;
 b=nMxAcnz2MDC2Dr0cL2gKuU8S0anbdKc1BMW+VxfhkpJ+gbee+UrSq9gv4d629Km+58msc8a/4a7woKSzbY8WprDzJOQciIGD28I7+LA7UslKqLoJlSegk/4e6pE/n7HxVAJQf/amtNWKnwyxOjl2TQmO/IseURBfNQA/SWMaIwTFG/Rfg6UVDAwDqyjVfCJ2wsGBdF8Xu0L/3yh0ia/hrrd2JgjUcvB7VwTZEoTv+aMQHDslKVJ+kYQh+mu96dzaVcZ8WuXYKUfmDyMQuDPJFAjlph+kwZebgh64v1k7O30sd/f7at2mKsuqn7BluCp5AF6OIwJNuTnMMLwrYVPahQ==
Received: from BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:10:55 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::32) by BL1PR13CA0192.outlook.office365.com
 (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:10:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 02/13] iommufd/fault: Move iommufd_fault_iopf_handler() to header
Date: Tue, 3 Dec 2024 14:10:07 -0800
Message-ID: <137e3357f00b30a08c2b49c00b968a88af8cb5d1.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: bd23e13f-549a-4f2c-94ab-08dd13e75b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A6bjSb9AgjXCF6UxTP0/rJSWArrQCx1Wvxyc0u9kgr4oZmhzMPTjZpT98Uqp?=
 =?us-ascii?Q?7Rouf9n7WcDY2ShFeKP9iZfBHz7fGPSz6ODuAAXqhltUIDIPQyFh7o3f0NG3?=
 =?us-ascii?Q?zjGuao4/ALDnuEKTS9EKZca0CmK+ep3WRoTOqMswDTmgHiXekBTr2uFLlk5H?=
 =?us-ascii?Q?RQ5lXxyJOR5iFciPO0Nathp/Vz+GuxDhO6is8YmmLuI8hhhDctshNJJCDPPF?=
 =?us-ascii?Q?WtVDWmmYtQf3TG202rlppO1w9vfdagiL5Q7VauhYjf6bl1r6VXR298YZ5cjB?=
 =?us-ascii?Q?jdJwxmnyhxqckNe6ybKAeJ1RNgG+HBZptRfDPYC31iLIGRNXK7UUL4lCIqcS?=
 =?us-ascii?Q?gxQ9wGoOhEYt+W0B8hdf36l/xc/mOe1tRBzbePw99gcfMMFub2LpVmXRmQOv?=
 =?us-ascii?Q?9bTeTF0Y8BStOap2CoVXNp1sOuJrEqTpqoHRY5L4eFWjd/uF7uXHXrNtynek?=
 =?us-ascii?Q?WDnHtop7qxcwGVQfSsc1MOuXQZOJIVdS3jXxKdtlHjgPji9//qmLGgIurbJQ?=
 =?us-ascii?Q?GXsQbPp7JvVsoArFJsYyzX+JEkgZoCZm2VBWMA7XZNunkKtqX/h7J/gb/VdG?=
 =?us-ascii?Q?TPfs9lEsZB3ET5xOkuSq3HHJAEYucfKZkUWAK22XqkOqiZR0DHEbIfV4izdJ?=
 =?us-ascii?Q?W4KHxujR8ip/kGaaWNLj0QFKSjBDVPUJyvDRhnfRJUDEAYrx1UAdi6LZl5yg?=
 =?us-ascii?Q?qrWok5RS1tkhpXNpFfAS/lsX5EqMc3J0i1RygfsYeno0h7tzXRPEn9JntpYd?=
 =?us-ascii?Q?YtqCNgC35H5Zqdsuu6srerX/Md8aGyHbR9ChmlszuPOvyFzenvQLPbQ0gbgb?=
 =?us-ascii?Q?WmvZWWyG+2phyJQg+11EJz3TLd7nS3rcPbEhSaeAdjF42WzOzu11vGrs/O0H?=
 =?us-ascii?Q?ngrF9ZNkiglwCpx0f7zWptbOJ0qAYaOR09ZiUXp0BZ1XW0TRSg/wv0qyhyML?=
 =?us-ascii?Q?MCFHvTUVw+h8xyVWtQFrmYKARDwhtwkaMw4Yf7pKlB9Pxldc9bv080JMJljT?=
 =?us-ascii?Q?7ZiLH53eVgydziF6H1TYyALT1kgWBW6hINkuUgoPjnQFY6vi31g23uCqMhxF?=
 =?us-ascii?Q?5RunZA0wMcoUaGMzFsWZ3WkE9MW75Ga7qt87vFbnW/iuenzNLW4Ab+qSft0E?=
 =?us-ascii?Q?6eQX8hVYpQMsdH3fYrFK6NFbIfFmaeLvbUCHQKnKw7R/WD+NEqPg6JMVd9OX?=
 =?us-ascii?Q?75q3eL/W4/RCveX87WGYdU7NC4dAu9+ymLm4GA7qTzA+VtKqV7q+zNFO5HzA?=
 =?us-ascii?Q?y90DB8kCA1umQVYzPWIoO0618QxTUPrFi+wO457RZWsKqy7eg7PUiq7GKSRC?=
 =?us-ascii?Q?8uMmmypx9/D4vDQMxnYTllYOtMTlEbypUFI8t4fqQTtWTqu9anmRbGKUixa/?=
 =?us-ascii?Q?EQoNGM1yDvaIHDY3pQtHFk62lf/s4MAN81vovZc78l2qXMtVR2iJI1UVk8nC?=
 =?us-ascii?Q?pkEM156y7l4xFuQfrv28HiUOiSnlk4GR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:10:54.5180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd23e13f-549a-4f2c-94ab-08dd13e75b53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369

The new vIRQ object will need a similar function for drivers to report the
vIOMMU related interrupts. Split the common part out to a smaller helper,
and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can include
that in the driver.c file for drivers to use.

Then keep iommufd_fault_iopf_handler() in the header too, since it's quite
simple after all.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 20 +++++++++++++++++++-
 drivers/iommu/iommufd/fault.c           | 17 -----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..8b378705ee71 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -451,6 +451,17 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
+static inline int iommufd_fault_notify(struct iommufd_fault *fault,
+				       struct list_head *new_fault)
+{
+	mutex_lock(&fault->mutex);
+	list_add_tail(new_fault, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+	return 0;
+}
+
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
@@ -469,7 +480,14 @@ iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
-int iommufd_fault_iopf_handler(struct iopf_group *group);
+
+static inline int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		group->attach_handle->domain->fault_data;
+
+	return iommufd_fault_notify(hwpt->fault, &group->node);
+}
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev);
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 87c811b9c0d0..5694b04a48bd 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -433,20 +433,3 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
-
-int iommufd_fault_iopf_handler(struct iopf_group *group)
-{
-	struct iommufd_hw_pagetable *hwpt;
-	struct iommufd_fault *fault;
-
-	hwpt = group->attach_handle->domain->fault_data;
-	fault = hwpt->fault;
-
-	mutex_lock(&fault->mutex);
-	list_add_tail(&group->node, &fault->deliver);
-	mutex_unlock(&fault->mutex);
-
-	wake_up_interruptible(&fault->wait_queue);
-
-	return 0;
-}
-- 
2.43.0


