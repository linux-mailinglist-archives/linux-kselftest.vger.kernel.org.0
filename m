Return-Path: <linux-kselftest+bounces-23480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B59F5DFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798AF189007C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9805155359;
	Wed, 18 Dec 2024 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XriLG+rJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16270155303;
	Wed, 18 Dec 2024 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498103; cv=fail; b=WysHVlZ/Yv/5MSR0rD1CFbYa2BxZ/cX553niFqQsT+aB+57BCi+vpi7xV554ZGjzAGI8M7bXFEFpElBBRkOz/uc9CNybTqGCNpuCR53y3LuJS6F48E0HpRvOjHPfB7FkolbTck/mmuQetTcGXV3nkMavpjgnTIPpKAsSOMiJNXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498103; c=relaxed/simple;
	bh=cHBvoQoghhhqZjxW5b+ZpNopV06cFh2jIHPAH8MoZG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIvtVrG4rEVvFLS8fhgFjdBaqPkxhqniwmCqFgnBBvufV4n0Aox64PMkh+qUi9Lboo366HrVnsKYz8y98ccSyyCVBn4xYS8Y5GbqVm0yk7WSMf5bPtnWVenu8yAGMf0U7kcNk9E38ZoeS37ykkyblUgreC3/2WPqDzWeOH3Xzb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XriLG+rJ; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHixZb6Nd2vb9rzPQ/CvFI8l44XToEOZuf2DWbrnoOQrfwT0/WyFYbdZCUM5hVDw2U6N3EEmo1YxC5d42DSWTg0WaJMzp8OcAQ9NT4JgXh7c/uAsASkyW3SJdje+mJGDMhuoBj+8y/lSldJpfh3ckxbjx6u8ExYWV+gfDDj2srR3hIQkBm1WcPOWClev+PrZOpM4Qb5nNTjnjnzKLrDiiLVg+VJizzJB/VIL6hMoy2pE4KygSJkD1MSkiIEoauxuAHsQtIkNHrCxbe824d9f+fCQGte7k5GMEovwN0ryMSEY+InaFsyWB2Kv4GC+sQiK4rVUfTyEueCyBrRfg0ejnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WDuiufp77aVXOl4PuOLDm0qTfoWH7sFIXEOcsXwyaA=;
 b=GC5cPVl1nbcf9UoW9IIwesHLixRr1NwCL06gpnFt8k+j8ouYPmuJWvcxi+5bUQDEC1sQITqAz53KgrgBhOHpdLCgS/XEuBFM+U2CwcfStgZDBOn6AEa27szD2VHPQ4+8pEsYnJnb75aeAkznZfIBqY+QPHNcYfgUEp9nWFcbQRUgecGmK2L7ZZCwYJ/K3YpPJ5h0zELGKUXzVG0EI56k1xzTeb2IN95fTmmUODu5P0Q7r5MhPMgsBRlyWVQMYvNwY8/TG/lkFJlnOzXDqAOxi1S6ogn0hzvjuYjiSEMJanag6d9I2zUSMIdKsg0Oj8o/UaP3Hdoa3O/1J4fILZDn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WDuiufp77aVXOl4PuOLDm0qTfoWH7sFIXEOcsXwyaA=;
 b=XriLG+rJ4nzH/8vtNUu5AQpMq3XPvVt3IrN3JvlVvB+ZEXoNEPEvEe9H/FKfSHF1wqD53LL/eGn7qujzg6xuh2v5Q0FtlzovmVtu+g7m+xF1w76rhhkLdg/TVg/0iVHi74QEMRKKaeYgnJOnjW5vGEhdZMdrvtHxx95Kv/eQDf+D5pJqozFMtnDAflMnZjgAEe6Leh1bYp6eTLOEqpPO93E6jDRKo7k8Ud8ta5TdESbm6x01a1bGzlouiBS426USRRF3jxoluZLAPaZBRMbPjeZMNuWewleE0cdSd1GuDaxCVcCOnFEXCc5YIL5ovHsNMsXuK0OL810n0EyDF248Tw==
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Wed, 18 Dec
 2024 05:01:36 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::f7) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 05:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 03/14] iommufd/fault: Move iommufd_fault_iopf_handler() to header
Date: Tue, 17 Dec 2024 21:00:16 -0800
Message-ID: <298800fb1997fb9106600d0f5531cdebb0fa3871.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9303208a-e45a-48e0-dac1-08dd1f210cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIeJILXhxFWEjbFa+Sx7LJu99Rw5W4El1G2wblNpVPCv62SBi2sCXgfNLdm9?=
 =?us-ascii?Q?LycO6iaxhhT5y3IcY2BrifzFzsf/jpx6apyjJCRUONrjRWSfOsmaxxOYUekJ?=
 =?us-ascii?Q?Bhl3gJNrC4avSSBQaXL2MF5jA3OkTIcTr0AYwqf5JqstQX0Awo0XJZNXZSq7?=
 =?us-ascii?Q?DdmoPKhVQjKYc2AuS13TXqR1P7pIOT/uafauGn0vke64Ki6qv4cJBa5JCSVY?=
 =?us-ascii?Q?H5IxHnHRbG1i4j4P4w4w3RTLIXGAwZiSGpDTSls0Og00Ya+rQaaXfj6HO3CB?=
 =?us-ascii?Q?0UXSWjEtkKdGH+pctTMYc0+ny3DXeOYygpn5oYgimDKgh4zkhYOkjbWzt4IS?=
 =?us-ascii?Q?j268GIiHpZFQmwYwM0pV7fZ1UMtcIYgYqxFPL0q/2DapnpqdaEJDaC5/QYLY?=
 =?us-ascii?Q?LG7dJNWKPxCGOlPSf0IrnzqbTGDUFmc0uxY1I5pbISUu2yncgoAs4cPOqByp?=
 =?us-ascii?Q?21Tq+Y078g111Rtnw//4ohq4jtqewyUNgisaRLedXHLxWaIfKEc9VOHaOhoZ?=
 =?us-ascii?Q?jiZB/3OlKvB4qLA/0d0mZwEuFEg1JtD3hcDchVjoBj60U7OPoPz5JrO0+FFm?=
 =?us-ascii?Q?ZaOxpaJnEUl2PnOnx/AHmdqFD3UAE+7BLkNmHh57koDOnAvA9SAZGybX5kD0?=
 =?us-ascii?Q?evXSr9id6CMHrMDUy87A9OLXEDutEhGEk7anQYwJPp21oFLA25gYdwPf8dA2?=
 =?us-ascii?Q?hBjF62nUfhbYK8KmPaINHALxCG0FwJCb6eYNI/NXvHp0iU5C53NL/5ucmP/R?=
 =?us-ascii?Q?i9UzVEN2Kb6w09rHOnK+/868NIUYenJcxu78TiR90eOd4pO0iwAaZcjenPiF?=
 =?us-ascii?Q?VKgND2OebgQoJWqyZnG5p1DpRvgGzDh+cmxHdcybkJNY0lFzOB5B1g2s4Zg7?=
 =?us-ascii?Q?8dkXztmuWPx+xYHzK3I9IKDJaJSYI4erfM93gZ8E3UDdmHVABA3mwgETrWZE?=
 =?us-ascii?Q?1Dmu4QpVMWvlBatZQ2vzMlvqn4XJOmuDFNM+4X1zCggHJmIy1W5DAQ6fSP5D?=
 =?us-ascii?Q?BB1mTf9RSqOaMxCN38k/q+IIUon0s1xSIfOilSVT8X+DXIweyv7tdAt1HfID?=
 =?us-ascii?Q?YQJjF8LnsVq6mYlX6VHESTo7/pr14ZtnivOiYARNnMxiXgKd4RILKz47vU1h?=
 =?us-ascii?Q?XqW4J3R12LZZnP0zZc8/MWQoj+BCTuuDfFszUeXIfn8DIwi1u57LgYZORDvd?=
 =?us-ascii?Q?iFiApuodxkDYZwvOqxndaRPGxcJ1bqz6Tqo6Sc614GD9SnvfINUXJmU1ytNF?=
 =?us-ascii?Q?bY2bgw9T6QjmKEDVXsES8YDPd39419Cgloj4nEEz8ASgVplctSMwBhgKG1BR?=
 =?us-ascii?Q?3qd++KIDz4fr4PRJMm4hdErLBJJ1AKfZ8ee59/sDoUskaZYvGR+dfK4mvkkH?=
 =?us-ascii?Q?mIjbWuMMam0o7Ba2IP3ngl7C4JzQSzRCmVemPziBAhjpeV2Sg45cjrAXfoeW?=
 =?us-ascii?Q?uL1SbB/dwwaW4ZALpzRHk8dUijmIX8Kyux2dTnctGzKtq9LJ51DaOiHdIiS/?=
 =?us-ascii?Q?7JFVVftc5MCsiSc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:36.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9303208a-e45a-48e0-dac1-08dd1f210cce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

The new vIRQ object will need a similar function for drivers to report the
vIOMMU related interrupts. Split the common part out to a smaller helper,
and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can include
that in the driver.c file for drivers to use.

Then keep iommufd_fault_iopf_handler() in the header too, since it's quite
simple after all.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index 1d1095fc8224..d188994e4e84 100644
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


