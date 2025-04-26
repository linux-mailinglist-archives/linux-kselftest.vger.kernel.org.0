Return-Path: <linux-kselftest+bounces-31677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672BA9D7CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 07:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7FE9C3682
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A11E7640;
	Sat, 26 Apr 2025 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FUreFp+j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F01DE2D8;
	Sat, 26 Apr 2025 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647142; cv=fail; b=E7NP/GxMFT5b6Q0vzlUJAIX15dEr1i75XP1zmmcej9Bv4jQ1HByOrVQpFBDSBsjHgnHVkd3GrwvVIv/fdScEF3Mvow5OJzN2oZzUZYlRjwbAk5OR6V0hWQjTXWbicVXr9tupfvrflotuCfuBG70UeTlUk104calaObW29jwvvjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647142; c=relaxed/simple;
	bh=dxuAa4S10mQwlyOKUnPhKK9/mhQFLlhVoj2SW74FJKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpN18S6ed00i8Q6lwU3tJR/K9q70nxgmD8BTrFMD3kvDNEFydSrl+XNSXYpj+PUzJM7TaW59UIq0+6A72bvKjrXZUj0bLPCHDGl7358cFP8+pXtSaVuhMrd0B4Xn5wp5fW8KLCB3TGnoJN38cBKF6buNuLghjU/ntJLRK5ku0nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FUreFp+j; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBcC3jVAk75tnz3ZOdj2CTSq6icYEC2REeQJ/gl7dyEI6skcgAiEfRGHVJ1qdghxDpFXcmD/viNhZuqvxEW32q6IHOW8dCa2yeLNQdUcgijD8fTDA2iy0IYcsDQ18GCWNQ9G6+VlBKQx076XY1LpUr+lb39m/+AbIPgVbV6CUwRxHdzs0pJXJ7eTl+hawxo1I5C/w617k0A33HlGLpXrkQ8+QqnGT9Pk80R4IB7hhsyIx8eTdVUyVM3IDD/iYfigh/JIYJWItlwbZSPAyU7jrisAwGhhPoIN+LUf3UrEMgdL4m0OsDrq4Uo6PpT70URRtJp6bpLu53dXjJSh1CPDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgPZFVVU4Y1/17gwJAsNNC/A58dRuorCbpYgah611d4=;
 b=GADbLbVdcgzA023IQ0+i8/Wz54bCo5CjFsSnkcTLYJ1xIGEEbs7gHnviDY7Hrt4l10WFUKtgOnsSPrCWjyevTJlc172zHVVQaC97Hdq5FJboRDiGZl0EidxS/+m2Cy9k60EtA8T+EfBfyeFs+5RPeYe9uagqV3jCQtrZJ/wRIpQm6bqwdN8c+aeXGRK/rlcW2q41clY5lBxe2VXWhysI5ivJ45qR9N+Nxjzi89UTdZl7oRRsko/uaQUYH0dmtg9ZYdZMBxvkxd/564bs2su/s5fPGPw+TvGuMDbD/+8CtfQL2sRryBd8ecJAIlCAFGbbwAhSbaPr3mW4Z1ns/tzrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgPZFVVU4Y1/17gwJAsNNC/A58dRuorCbpYgah611d4=;
 b=FUreFp+jC2eABKfQclnZ0uEyVcVNx0EYtdd+jTgi31yYI/gHE08Rv8VHShT5frA/fI9fliDvohSYRa4aQQugV1xzF3Q7zNyanDDIRgF+FpuSe2+xIuOWu48RtcRxFYJfD6d0wAHNsv+dlp3bipZg44zLX2vHZtib40pJNJ2zTfmvYWmPu9NPQVe/ttnb6e0ryfhLNnrW0olrb4qkpU+bGTdnHwuvQuKsdWAU37h/og62BtP8s11x421QhgAJfgjfjqnWxmkSNMif15Xdq3cC/LW4iES0ILK12HepfgAWXDfb6iVcfDGi2TALGKo8pVSCYtcfrnnzpfytFnE8PUMS+g==
Received: from SA9PR13CA0049.namprd13.prod.outlook.com (2603:10b6:806:22::24)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Sat, 26 Apr
 2025 05:58:54 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::d0) by SA9PR13CA0049.outlook.office365.com
 (2603:10b6:806:22::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Sat,
 26 Apr 2025 05:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:58:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:45 -0700
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
Subject: [PATCH v2 05/22] iommufd: Add iommufd_struct_destroy to revert iommufd_viommu_alloc
Date: Fri, 25 Apr 2025 22:58:00 -0700
Message-ID: <3d8c60fe9f1cdaecd59ce3e395eb6ca029ca8ded.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c19fa9f-1c3e-4cb2-12f7-08dd84876d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WwGpu3HsWydahVt4GFnilo0Tn6MVSPp7ilyyiV9/DvMLGS1Y8f9wEQRPgfPb?=
 =?us-ascii?Q?tMPgzCSGnseyjUF+9TzS9UDe/6ZzGlAZkwETTZ4xONc/Nie6YVniUCPTVnDu?=
 =?us-ascii?Q?sqz+CLhY5l5ahRpJ6zqJLbqafKaLFO2IIKXJ3QST+U14mkJucGVMEu5OAM1U?=
 =?us-ascii?Q?3bRNkd4KEv2fogEitGqgNmfCt7QccgPDBtW0ANoctTiSamIqLlrniHHOp5OV?=
 =?us-ascii?Q?MdCK4UnXYWvo+56ipyfcTOkituaWf4qPepOjOYc6hur5t5OYOuoidx2lbSEo?=
 =?us-ascii?Q?u3qhBdH72xZlxeyjFa3dKLXgNLGWpVzD5gaGSt4SZ4sH6SzcGHt3YowCR0Zt?=
 =?us-ascii?Q?9PYq2/uZLucBJdMdjOK2ck1LUs7HSwQeSq+DomeWv5O2iGPVCDYS0eY1fawU?=
 =?us-ascii?Q?92s7FLRexPdDNsyWvUW+XcuY8rxmM5cAV7YI8gEhNVdFD1AWcgZDCGyCMpEm?=
 =?us-ascii?Q?YuqYekWD7AF0xS3hPF/Qp4Us5JsrkRD7LcAqUuZ/TwTk50tvurnvrb3E7Klf?=
 =?us-ascii?Q?edbJXrRcY0MLe9tM17sZXtu4tj9wYld98NeTlWHCGRAtdtnASAQeycxqXaue?=
 =?us-ascii?Q?VGTgMIrrRfZ0Fiwn5DZkdXYdRdsJ/9zE20jHcvZQQm87uxj41QvKqWekLpNv?=
 =?us-ascii?Q?pQQTBWSER8Mr9GKQzTJhqO4mfMcasTdcUQS8fjISlsGWEip/x1uSYEUOMdvT?=
 =?us-ascii?Q?myVUv1ba2WvEsM19EgVLEPMFEqIZ2nRnYPMFyvkf8g/lKl1qW7sbhyPwHey9?=
 =?us-ascii?Q?UpF7cQcaEqb40MBwm3AyvpoJv305eymJg3ydhe0q6wLL2+0eiQvwQgOzKbX7?=
 =?us-ascii?Q?GBnKq4LemXV7xKZ21ffvduC5ApF0im3AcTLDD+eNyIAZf2A3WQfz+qySufue?=
 =?us-ascii?Q?clbuD3p0NMSUNbyxUDKXLVx/RU2L2Xc0SXvwkuVgHhBHI/yazD0ak2samxHZ?=
 =?us-ascii?Q?Z95+NCrvOVEqFMid88hxPXaXrP8ZZy+dT3hUjk+ADJev/05uJ/9oaG1wTH04?=
 =?us-ascii?Q?gvqZn7gCbREjsL4vIOkgnyJh/W13XirUftoPC3eys+QFEY03ZPxcprPqE44S?=
 =?us-ascii?Q?KIHQ0dHVwvrGJFHDbX9weuSPZmcN05fKFYYroPIX402lQkfcsAlnCVTk1lfY?=
 =?us-ascii?Q?f+QfHy5Q7HgeWldOVMH1E2CjQKO6KuC+PcEP+bF1BumWWdm/j4lZoJpdh4zt?=
 =?us-ascii?Q?97IUFY8kdBG/97tnI3GFYc6ytlvD30ZOT3o636lTcgnvqEWCIzRamMbxFVto?=
 =?us-ascii?Q?7CUnebnfaRlUHvhkkhCkzm1mDthPMhCp+fip7LW1J3AyeYqC0SGsouHj47lh?=
 =?us-ascii?Q?gJ/Q2zHgGP8Z9PFB1BZUyJuhZ8IGDNvnni8zdrD1jNE4yRUkrOFMZP6FW+zj?=
 =?us-ascii?Q?mrM+QeW2W1W/4hrvsszvQDzMe77kKP8HOBhyNiw7rPkJ+Bl5WzYESNbD2V99?=
 =?us-ascii?Q?o8TnnjJuewUxBVwJRmCVm25zUQnaROV4XEpD21Dd95krAWB/MWKkf3b3yJk1?=
 =?us-ascii?Q?aUBzIau1b9bbG9w/Xi8uvL1SYJ2IHeHkGP+k?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:58:54.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c19fa9f-1c3e-4cb2-12f7-08dd84876d39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
if it encounters an internal error after the allocation. So, there needs a
destroy helper for drivers to use.

Move iommufd_object_abort() to the driver.c file and the public header, to
introduce common iommufd_struct_destroy() helper that will abort all kinds
of driver structures, not confined to iommufd_viommu but also the new ones
being added in the future.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 -
 include/linux/iommufd.h                 | 15 +++++++++++++++
 drivers/iommu/iommufd/driver.c          | 14 ++++++++++++++
 drivers/iommu/iommufd/main.c            | 13 -------------
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5c69ac05c029..8d96aa514033 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -180,7 +180,6 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
-void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 83e5c4dff121..ef0d3c4765cf 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -211,6 +211,7 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -226,6 +227,11 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
+					struct iommufd_object *obj)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -279,4 +285,13 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 			ret->member.viommu = viommu;                           \
 		ret;                                                           \
 	})
+
+/* Helper for IOMMU driver to destroy structures created by allocators above */
+#define iommufd_struct_destroy(ictx, drv_struct, member)                       \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_object,               \
+					  drv_struct->member.obj));            \
+		static_assert(offsetof(typeof(*drv_struct), member.obj) == 0); \
+		iommufd_object_abort(ictx, &drv_struct->member.obj);           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 922cd1fe7ec2..7980a09761c2 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,6 +36,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, "IOMMUFD");
 
+/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
+{
+	XA_STATE(xas, &ictx->objects, obj->id);
+	void *old;
+
+	xa_lock(&ictx->objects);
+	old = xas_store(&xas, NULL);
+	xa_unlock(&ictx->objects);
+	WARN_ON(old != XA_ZERO_ENTRY);
+	kfree(obj);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..2b9ee9b4a424 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -51,19 +51,6 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 	WARN_ON(old != XA_ZERO_ENTRY);
 }
 
-/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
-void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
-{
-	XA_STATE(xas, &ictx->objects, obj->id);
-	void *old;
-
-	xa_lock(&ictx->objects);
-	old = xas_store(&xas, NULL);
-	xa_unlock(&ictx->objects);
-	WARN_ON(old != XA_ZERO_ENTRY);
-	kfree(obj);
-}
-
 /*
  * Abort an object that has been fully initialized and needs destroy, but has
  * not been finalized.
-- 
2.43.0


