Return-Path: <linux-kselftest+bounces-36907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC08AFF8BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D707BA8D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997F28751B;
	Thu, 10 Jul 2025 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYdHe2oe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A59287259;
	Thu, 10 Jul 2025 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127210; cv=fail; b=UrlFj9W8dx+94FJT1k+6eM2GUH1ajqiRBBsR7rYl14FOCLkuNPPvvuxLv55kp+D9+4ug69TFRJv9i7eGfocMka8MCJKuTGmMP3UpMqVC3rPxUE5BgGGnsT5Pd5SYTTvoJgvznfIJ1rk0XlOx4GyNm8he7QtbBoocRBOX8KNO/LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127210; c=relaxed/simple;
	bh=vsJQQ1U1gBqFEw3Usbmfy248PJxjSOd1Vm1U4/K0o/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQkcD4MnTVTJKCGyV5d9EEcOpy3nWxcPs/L4G3GDsPknVtXGF2sNrzPCypc1eCMDhELRGX8GG1Pwlm9wVMjggIthqEKOoAQnIi7Wl6rWEJbVam8V6XBeUtG1cNTVkFhhTw69CzEs4SF/dsbR7KVuaZmCZQ8b5JO+9NSLfTIzryk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYdHe2oe; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmbq9qs60FIPGpeSxQXdgA5wrCI+X40bfkbve93xCVT0SswL4T9g4nS3i8I8RD1+m7T5DyCoF7qoGZex6FxDHkteZy17b6c01AQaE0h4hKHfOMthSqVYIaHhl1a7oXTSh0M/YcNWKY9PIh1LDrEvELvvmDyEeVCQmtzt0Q2jb08KYxatZ/QbvIZVNNzS6j/QuewZRWqAN3twNhB/C1e+iHE6EkvcA9lNpuHOs01kM357ukGwOT7AqgHcUJJK7PcOqMxI7xcy5huYKiYyxnBCdlHPE+VZo9rUoz/zP/ixeH5pGmz5ttZRu4/5lSFdtrKBYmJGP5Ka7TD1bFyv/shVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALRYPsjcnNFBrPxFPw8Ad6bI4nH8YWMmbQCVRmZMbuc=;
 b=a+1sepC7T+uKiBUuL4Yy0EdFHarBwa1r3wHYn49W0N9x7RgjjYFKsBO9cAXEd8GWV9Uvgm/hUjEZNaHpQ5HeWnNJ4BQ44J4r2TO8IOYb7/dWylMf5kRdqei8kNQv0XbHF1hnpBIA4HiWK8lxE7Wbbx5FysEBxbypA3yXpS7Y6v1N6LQyhyRwu7ABc3u9rXSmrp7DNkOryA1MP5zdkpnKoKJv1Qv5CarBHaUygNRNkOJq6cr55IALhcVkDnIyoe9azBXl7aFjxzqLzUBNlUfGAeTXfYwuiN0z31nbU0SREx6J6QvAk9YsM60lTLtpaka4XdHB4fbzY3Kmu1pwWXca9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALRYPsjcnNFBrPxFPw8Ad6bI4nH8YWMmbQCVRmZMbuc=;
 b=tYdHe2oe6LqB0Tr50sWpsXReB0/8fCS8ULeIONYSPMNZXyG8x4v7LODfITSXBhesm8YN6zmUUQh7SJuGHq2WKc1l3A3ftnzvwXkuemyhA1pRUFPnt4E503WmtZCIxBaM93THjrXnuUu1jZy/gsNh7eQUffT7Zv2KSEGw9wUO5j4hFOS0ipgnhDTs4p8RF/d7lKWaLeNyFDKprDEpGrxaRrJ0ocQVrKz7HVmexDz3DW4WbqGb/2NWiHSPMH79uBjmEBIEYNyg0jFI5Sh6KH3lOYxIt/y8DnBu7ZchRKo1/gaJIc1K6D9dojCZclbHHwCUQVap00tjJNGrkhWs2LpSug==
Received: from CH2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:610:53::38)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 06:00:05 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::21) by CH2PR17CA0028.outlook.office365.com
 (2603:10b6:610:53::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:50 -0700
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
Subject: [PATCH v9 03/29] iommufd/viommu: Explicitly define vdev->virt_id
Date: Wed, 9 Jul 2025 22:58:55 -0700
Message-ID: <1fac22d645e6ee555675726faf3798a68315b044.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: e36bf977-ac7c-499c-9a45-08ddbf77046a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3HKkpXEhGVv9NoQ0/a0XzvvA329EPxreD25bb+9xXU7te8lXPFPestLm6Q6l?=
 =?us-ascii?Q?My6fG1ZKlme1Ean0rDgem86xa7TNB/UcpOR87KzBEV4fLVEKWyfFYfH03lTo?=
 =?us-ascii?Q?OfS6DjIgCtvXlIRqruCSSknGu8lk46Q52l+Z6gP4ah9tFxWP98RVxoD7GYaJ?=
 =?us-ascii?Q?MvQgHzka8uaxjh+vnDyc1nz1sSt/qIi6g3Gk6TBaxslIohXJHaCYy//kzRPt?=
 =?us-ascii?Q?o9iQ21269/mOMAIiRekBkOkwds/WI4p6Kutoaa6pMeBX5gqAXbKmBejyyxOK?=
 =?us-ascii?Q?FqDbP3PimmLuKzIOp7Bd7FTRAS+HfqzjOq+z50hWixT/sw+Rr7l27fDGwYzD?=
 =?us-ascii?Q?i0lNhlBAxg8yuOBxIClIa+694O2pUZhodx7YxoWLbGCenwl1L4ghc3FvC3dV?=
 =?us-ascii?Q?8g/2cNKfeByZLI9Pt9qkwOlBJ96SDZOA0yR+Xca/Mf08ML2s4+sct6Da78FB?=
 =?us-ascii?Q?3ODFS4KlWu8HxCSUguObKPkZjxJxLIBuiiK+p1kjA5nuzpkg9g6yCMHmJG5t?=
 =?us-ascii?Q?jyIzAuNcwtOSFloMX5rub8iJf7lAwoUnc98005cqtrRfXGclVL6L5w4HX/SI?=
 =?us-ascii?Q?KwCkVJ4wMvM9pH0gnb29Hbomu4+W14my65n5MvaAjbwmR3YxFojsys1g9vm5?=
 =?us-ascii?Q?bsxpy53p0jo6cJWhwo6jZ0Snn9oN5izAkjLfCErHeR1vttfL5vuj8FuOnTRa?=
 =?us-ascii?Q?GM+LZexuREWKbJzsYqOsHR6YUwZ+0gfzSo9CMxlkgRs2dUdOOexsu79Lz/W3?=
 =?us-ascii?Q?8/kou4Xnkh4mfcioGhSxzkfQxGxMArpWTmLeDs4KWTtsIn6Dz+uhjWkDWg9d?=
 =?us-ascii?Q?qWh+rPkH0NWK3+2DS/fKyKleUOPV6Yl/W/uooJZddi0ZsATQdHwDrvUEMjIE?=
 =?us-ascii?Q?c5QYh460Z5VXVWwalRyBGZwzSfDtJnJxqqDl3gRkTvkCOPNfCrjLl4sG/wW2?=
 =?us-ascii?Q?DtoT6orZzLvUvMDuf9huBCPw7rtlIVjJ3iICiZMREHNKaK2apGoYZZ111vKy?=
 =?us-ascii?Q?q81W+gFDoP/vjY7bKCpSHI7Aq0TPH/YkSi9KzhbXz8EWiJ3e5kiiq6HerKA+?=
 =?us-ascii?Q?G8Dz8D8ki2UtQkF8y3aEIZPtQMSUR69LU0k+rXs4RtKnHIUUyzjKnHhQUeQ+?=
 =?us-ascii?Q?p8xwSB0DsdwVcMIRdoXXi+I4UJitA5cmezhjQy4RQPTsht2kuB/rGS3nQmTs?=
 =?us-ascii?Q?WwKHKXTAxDsc/8Tl9oFkpGq86U8vf8WwiVmYwaVyoovmdlLWkcW3khPRkbVS?=
 =?us-ascii?Q?9CTgG2q9cnIZZIJKLdB8QF200ghJiN1hiRDpMd64ETpTQwxQtUbE+vLcinwt?=
 =?us-ascii?Q?tc9yqVYR6eIWaAhUWWrY39uUU2hCh0vrTi9NBO1TuGKzm3arxbFq7i+YqBsh?=
 =?us-ascii?Q?BHCuxps8JL6uF6HKM/QQkWnoxv9bXJmy6aROuFxDgy4hjkKj++qldE42tQcy?=
 =?us-ascii?Q?xyDy7lMdRgIuRrJTchI10qz6fp7v36zVMf3ewX9Qzdd2l8QvduRDTOja8Ssl?=
 =?us-ascii?Q?YpUAcxBfu4Bc6+z7NPWe08MwHb+9dgSvhBCe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:05.0483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36bf977-ac7c-499c-9a45-08ddbf77046a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156

The "id" is too general to get its meaning easily. Rename it explicitly to
"virt_id" and update the kdocs for readability. No functional changes.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 7 ++++++-
 drivers/iommu/iommufd/driver.c          | 2 +-
 drivers/iommu/iommufd/viommu.c          | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4f5e8cd99c96..320635a177b7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -634,7 +634,12 @@ struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
 	struct device *dev;
-	u64 id; /* per-vIOMMU virtual ID */
+
+	/*
+	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
+	 * AMD IOMMU, and vRID of Intel VT-d
+	 */
+	u64 virt_id;
 };
 
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2fee399a148e..887719016804 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -30,7 +30,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
 		if (vdev->dev == dev) {
-			*vdev_id = vdev->id;
+			*vdev_id = vdev->virt_id;
 			rc = 0;
 			break;
 		}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 25ac08fbb52a..bc8796e6684e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -111,7 +111,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 	struct iommufd_viommu *viommu = vdev->viommu;
 
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
-	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
 	put_device(vdev->dev);
 }
@@ -150,7 +150,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev->id = virt_id;
+	vdev->virt_id = virt_id;
 	vdev->dev = idev->dev;
 	get_device(idev->dev);
 	vdev->viommu = viommu;
-- 
2.43.0


