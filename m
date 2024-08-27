Return-Path: <linux-kselftest+bounces-16447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6C96150A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3248287FCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C81D61A6;
	Tue, 27 Aug 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOTxo1T8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA41D4142;
	Tue, 27 Aug 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778172; cv=fail; b=SC51pkKBvwWEdQByK7dty2abZiDM9ztCehRGv5nkaIX08VpJD+unOZgEg3NZtYpitMJOqBA7TT6pa4IvCaggdV7HjP20OVPS5aJ3nXHPAgD+RTi24Z/DjGDMQ/6yN9xy9GG2XpoA7AU0pNZ6v2WpctgQ5HWJE9+TDFeZ1C8TOs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778172; c=relaxed/simple;
	bh=tn3OZnD55oCB4nvsOABWOGDJHPUP9Bbp/ZRBukOfSdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzwdc4iTqJ57jgRWhb1l/93vjjQjltxLtI5KQRKv5Fdvy6Qn+yy94HTaTGQt5mhfR0HJbXwNXNbyLf2posR3X550RnUTc9X9r8ZFYneaRnrUkTznHU5a+KNDBa5X8KGMLYZ6Kpj+r/INiSG7yeVcg8MwHLR4ckFd/VdGjaY7uJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOTxo1T8; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jlk/AaLW33cWx8MwaKJSvcdYr8nz4rJ4qWIT2AlcIw3quU/aXbXU+dt8BLNzxsDWns4wL0Fu9WOB5j/GBPBxjQxnI8SplgMASNT2F6IP5NK8kAN2YtiM+NYuqomyL4k/0cCGsWsOkOA2YxW+1mViHRUcNs6MoI1CwEA4HHYlw/9Ub+2zuGVtkHkrJC6BtUgZZXyyj9fq+FzvsTEwp/J2TYRMVedtiuLH3A/QjV/ube/hWoyimmmTaMki0vY/VHrHpcyZykQh+iZfEvqjR/DJ6exVm3dL+F/ga4Y/sd3r9U+lgDP31l+yQuTy/ZeVtJcldJmB+bA+s5vLscDzSvILHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7uJzBWU3ug9HE5spQDfc2A+knb9ed9B5xzddhVFhvw=;
 b=JxRp6h8mvZmVU3RUBV+iPe1bdzgD1DIVfM651pI2aBYfABS33Q5xIffbKb+mg3VqW1LENhR5mafqlkpAzHdcjDu8KDtkSkIE1cZW8txwJFb4ptlErGVtr21TzImz7+PJgNKnDmj6cLYbN+ETT8jQmYFiiq4tBZ0x8BRQ6VLG+9JD5FS8VZrJrMflJfdk6Q5JHZxzEREa4r5IBfysICI3BDHrHS5bk9xncIQ1eRNs0KarFmaJAXf9SWePvGL9kWzNymAJ5rKEkYLdi4npVXk4trfuvqq9yYpplGzB+Zqtgi863KT5GsmRxw49jVWpJ8I8fGpkrzvImQwXxtN0mo0s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7uJzBWU3ug9HE5spQDfc2A+knb9ed9B5xzddhVFhvw=;
 b=VOTxo1T8553etDr7d1k/LjNrvSThdNbcXuMHySpqW1ycfT7iG1rJqcrnKZrpNueO2doC8ZFJwoj2GG8dF+YJWabWkrbVvyBylFgJBqgTpEZq6kHMrrA7AI6L5CGhc6q8ygr3YAgaeTPR5mgIdzlGM2nUnRcPXuhkWUGceVFjsdUXO+wksw7scJVzvM/hZb52f9cSfMCa21yzikknIB9fVLmudxdqWZ7QzGrkYr5Dm+MjdRhavA5sZ2sJsy6WyzIdV3ocOChrJzfmH6cR48UcZuklwB5nmKtY7aCsedSWJBczL7ktsr0Jdf2UqqRmp6jZ8pdtpm+nutBeSEK5W1LwFg==
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 17:02:47 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::a3) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 05/10] iommufd/viommu: Add iommufd_vdev_id_to_dev helper
Date: Tue, 27 Aug 2024 10:02:07 -0700
Message-ID: <0079015047db9981c111f09414a863b644c038ef.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1c7aa8-3382-4c97-35b9-08dcc6ba1335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7QiIVEhn2lsOKpdwRxa97VcN46YjMOgZFoKR5ON6V+/gAucKWs8oMw64oFL?=
 =?us-ascii?Q?HZdPX2Ilp9lPpvB4Uf4WC6hKzw7JhP4LkVErtpAW/gBlI0DruFpbY5WpLhUB?=
 =?us-ascii?Q?GpGKwArV/BApHJUcibfD2fTgFO0pzm4agmIlwIoB9ZGIBzh05838i2CebyQv?=
 =?us-ascii?Q?SvGz1SC16TUlKjoWA6LOg8H+0i+NfSSJY5yJ9P8O+CCX4Y+zknNQrRl5FXgN?=
 =?us-ascii?Q?8Qy65jH66iKkAitzUbP2kLBhSEtijOHH0PeGXPNq+/swl9sPGGfg9wmBwW1S?=
 =?us-ascii?Q?7bBR+jVJPUrrWsTFpp3LKDy8/x8xuy5RW+7s2vo4hVT8lOgc78ginix4vXts?=
 =?us-ascii?Q?qrV6FbZM9ipiJ0UU7TI+haKHObiHLtcZ4aiXVIHUQJ+yBOKn9KiQuzPGXHC9?=
 =?us-ascii?Q?TruYUeyde6vxx17g2dqHW+qiV2ENLMEd9N0FfY5ghqAirjf3oeD4FmosOdXb?=
 =?us-ascii?Q?8XzQJdD2Hqlpt+Irh7kS1gt93MKbciy2qzZdxkBry0DCAUJc/8tmGSs8bi0/?=
 =?us-ascii?Q?sF/hODAU7iOU/QPA53+ShVDVk2p545tltcMUdSBsldaqkwqTkq5l2G/dF5JB?=
 =?us-ascii?Q?20ao6l/9NEc0ugQpX96xPGJUp76mde502bRPVjPQadHSMopbimWiqa6ujGp6?=
 =?us-ascii?Q?jEFvnr9Y+N/ZcR8c/18YiNdPYW1q7h2A8lZ2LSLytGOx93K7+178bKtLbcqk?=
 =?us-ascii?Q?Pd3/s2u9NMji335zRMChNdeXHs6ZbY/HT7sp9wLDAb5EUbmjAxB3fWYGGLQn?=
 =?us-ascii?Q?MLt0UQHemJ4wtbfI13Rs+++YdDIh5bTdXRVxiDeGmkdRz31MfxAtJ1M6VRzP?=
 =?us-ascii?Q?vPznrIVcBJWh14C29WFadN/GFT4ohrX0UhrE9jD14lgcVe9Zo3om2jGZt9J0?=
 =?us-ascii?Q?snmhw1J70hNLcWvZ2viIYVni1ogfHMoUAK2JTeCLmTTw/vXh4NhPZpUKEpD3?=
 =?us-ascii?Q?1bRLNxUfWQxLv7C+u0KhAMmaRmXwzQdlJQCiTOYTk839L9rJPHQI/Sdom8H+?=
 =?us-ascii?Q?BcaLzR9HK3MmwsUGsL03Gwfq8AEOQPRlvARpw0hgBnYuCEt731T85zcna6KJ?=
 =?us-ascii?Q?r4+Ws6EA5VZwekIujVcp68SJ3H2wH+KfWaz33YBsz8Jv1FkvQ5U4tYtAJ2vi?=
 =?us-ascii?Q?IgohBQQjZvdblD2rX7PoB96V+Qk7PjTRvpbyXAGnEN9GfAxT8xQH08jiOguP?=
 =?us-ascii?Q?tit2X6yiThKOJYjH9pe1JOEc7RjV0Ffke0H9du7KObjQg5C204oJ2mR/OUtV?=
 =?us-ascii?Q?Z3yO+jGwEo6TOPNSoqAY1Xk8/gyQy2m5016f9WWTRlGzi2dsxIVL3D1R3FWm?=
 =?us-ascii?Q?zeR1iqZizdCp+aNEg39Mdbx0ueLTgTuUSnHpOQxfM2nnXEK/1yxM612xwjau?=
 =?us-ascii?Q?JLf61wwh9yi1rT5PI3S2AD4FbaWdJlnKuQnaaAB8lyW3nV5yP/ZYhDofLJVJ?=
 =?us-ascii?Q?2tpym1iTJRY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:46.6519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c7aa8-3382-4c97-35b9-08dcc6ba1335
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387

This helps drivers to get the dev pointer held by the vdev_id structure.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu_api.c | 14 ++++++++++++++
 include/linux/iommufd.h            |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
index 3772a5892a6c..82eb33e047cf 100644
--- a/drivers/iommu/iommufd/viommu_api.c
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -51,3 +51,17 @@ iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
 	return viommu->hwpt->common.domain;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_to_parent_domain, IOMMUFD);
+
+/*
+ * Fetch the dev pointer in the vdev_id structure. Caller must make ensure the
+ * lifecycle of the vdev_id structure, likely by adding a driver-level lock to
+ * protect the passed-in vdev_id for any race against a potential unset_vdev_id
+ * callback.
+ */
+struct device *iommufd_vdev_id_to_dev(struct iommufd_vdev_id *vdev_id)
+{
+	if (!vdev_id || !vdev_id->viommu)
+		return NULL;
+	return vdev_id->idev->dev;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdev_id_to_dev, IOMMUFD);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c89583c7c792..88d6586a424f 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -99,6 +99,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length);
 int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		      void *data, size_t len, unsigned int flags);
+struct device *iommufd_vdev_id_to_dev(struct iommufd_vdev_id *vdev_id);
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
@@ -138,6 +139,12 @@ static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long
 	return -EOPNOTSUPP;
 }
 
+static inline struct device *
+iommufd_vdev_id_to_dev(struct iommufd_vdev_id *vdev_id)
+{
+	return NULL;
+}
+
 static inline int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


