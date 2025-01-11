Return-Path: <linux-kselftest+bounces-24293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43EBA0A09B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B37E188B5CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8294B199234;
	Sat, 11 Jan 2025 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fjwWFYRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55D192B63;
	Sat, 11 Jan 2025 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566417; cv=fail; b=en+7WWIK3bakLeKqcz5Todf0xZ16iFzAumxdqD4wunnFsQxTaOCDCbf7vRROHrqm+PB/0WbTrMIm8vzNHWaEru4tKR5XstT1Lw3Z2tTCCA/Stj2uGakiTRw5pVANy7aOCrtv/cJxsrmdOC6xL7Flnzu1mSQN1XPGTmCcnEwzsZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566417; c=relaxed/simple;
	bh=ZuD1wxNMJSgXgta/yAbUeLhhTo8tfg4PjTjupG7QKS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7qcfWJEk2o6lGtbIG+zWE2q+JvdBRVzRREpHhGUs10RrJAhmCpf+W5wjJ7wRCpT3sFGVXZgtYxzgmVrTVEbGYJLJrHpR4TgKNYj4NnAkLQk7mghTxLc31KemDPcYBxGGMp9acizCEU+Th2c5TCPyFtrkjFc80QMu4mauTcwUOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fjwWFYRS; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5JHs7B6MtqyveclGR19DhLC1KNopmPh6LzJNyQUOGF1ikjhGFtTffNY+eSVJfNBO1brJp7B53QvbttIfR3N1FHKQcZa3IJyYd3sMVruw8vRjEOPpa3N2S0lcXfcd9NKfRh8mpbGemwmo8vdA4Acdn4XP+KX47D9C8f1ojSptYAKlDdTtmYL42BCn1lmB3t3Wr+gPXe2P1Ayj3q5uiaQm6Yhvq50p5fYeN+b6l07zL4blfH+OPXuByVwfSf36cKMzH557AhNKh+Q1inBKfkyKdl7sj50ODayHRFwsSVa/yIUYeBkGpMf/MfcsfFtffgvlPbuPHeZY7xhC+xlhnX5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3OuRMyWRZ4vump7DhyVSCF2/jP2PM5yuTjXtTnbCac=;
 b=qUsJStILeNOnyPrp7OtQ8BGFTdbAgLwr4nmyvxxa20tDvurGlRVAv6nZ9XGO9tPBPm8OVMORZJHlDSIarfmFTtWETH58mauau7ZlIx+X22v5qccMrW7WZsEhS1f9wZaGS0JUAjfBBRYyPx5BKnjCZ0Hi6ogUpJdLRANaZnf3QGl94jm6e+ilRpFdCi+l3nj8wpmw3Gr+7HqWocTwFxAcYK75nN+YTeqr8CWu+Rq4hGx9umIKFl5XLzdtaSyDdRXIUrkpRYLCyeWcVnVkVW6vHhqzm3bcsT8UL1pIoFsZel10C2l1D5E76EtMXSYyWHooApVf0grkBOH1OAeBwRcJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3OuRMyWRZ4vump7DhyVSCF2/jP2PM5yuTjXtTnbCac=;
 b=fjwWFYRS+P/QTfj3qVvGmH4fjn/Zt5q+W7Nm8gIG13zYio+vIQLsQ1FoCROnUtP7KKWZsSoI8b8JPzkrnsfWLa1ifXd4sxYAH9vbE7rZyw+7gqEeC5dauiDXImhstkZfdt9WDNzNg1FUgDdkiEIhVBnzo0t2fUK+dBGIHaji6fcfunI5WoswAKJPJK+pqwcK4D/DEqQGEYIeTn7uZHjIVn9Eeyz37/NoVHaRaRM2kMDGzpkzdj/tfrZ/LdulrbJ/hXw3BAA4N/2vpqscwKbbxle8lX6NfZr6v9FgBNEvRlSybqstIjIykn4IfR3KfJnQjRZNOxmqSVoSCW4dMVFNtQ==
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Sat, 11 Jan 2025 03:33:31 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::76) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Sat,
 11 Jan 2025 03:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:33:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 12/13] vfio-iommufd: Provide another layer of msi_iova helpers
Date: Fri, 10 Jan 2025 19:32:28 -0800
Message-ID: <02a1e86d551fa1660d3e64be33bed4d7d5b8ab94.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6fdd93-2332-4100-ddf9-08dd31f0b858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccagOI0OhmH6ciat5nm6Y3Z7M7F+RmxbUdIgFDUPRxMK9froonoL0EV+JeS3?=
 =?us-ascii?Q?sf+dLn1dyjIM/qfwPfLFya9jfdfpiN7LouYr7PLUUKy3n30HgkivF8+ObSJm?=
 =?us-ascii?Q?1CKjwUHELkwnlDtCy1daPn51G+zKRSkXZ6cATdmRv8j8BgDz5N/zk56AH7AI?=
 =?us-ascii?Q?cXLcj7zjH4C3RUMYwoOOSaxaHNzHsBLSCj15PAJ+4/iRVO7mJZzzehABGeZP?=
 =?us-ascii?Q?w8z0sEg7/y/gJMGcbwyIsKRREODT74lJkObssQ4pZUW8gjP3jnI58jownlKK?=
 =?us-ascii?Q?pGGtPQ6iVdRDfgvPcEs7mOJa+kcR65RmzzLWNxN30jHv5TSVexd6E5sqAeP2?=
 =?us-ascii?Q?3egtJHZ4xkrvaJ36OnuxldJRsl1oI23d2kzNMPQJc5gcuqReUidqXAfbAsdl?=
 =?us-ascii?Q?SAw9hd5kjOUgLswV4hKs22WV940evZ8VCHLD1AC3q9nXAmQeDdXsxnLdZF8B?=
 =?us-ascii?Q?fkQb91eJ/T3y3QVkVXFbdo4uVpxn42Ybk+hrsfU0/TILdYn+15T26R3x7Toy?=
 =?us-ascii?Q?10UrCxwoYZ0ysZpLXdIMqKvqf7qW6kyO8nbji7vnonI6JBMxrDuaJSWhXGJs?=
 =?us-ascii?Q?2HjzxXf1EIS47n6LMmxoatBSQmxWabBS8Byj0QfxNrJLOZlKmCQ2UAvHeLGU?=
 =?us-ascii?Q?NwaWRhELyleYtFDL2aYBncxcPbseijX2iYHknHrEm2wSt0/aW8uet7QUtRhQ?=
 =?us-ascii?Q?wYc88uOklGn+jg1tVjYYNEBR2dOYQI6Ti+/MPhmtx1I5nkQ3Tn6JpmkWcLQv?=
 =?us-ascii?Q?/bQTt4zWSdA3jVXFzmucIq+XD+GjihZ2F+wHPm2+RBCecVAqagakA4VgbxI9?=
 =?us-ascii?Q?+4FwpCMbaIRDELg/w/4pI9Q5NAV1nHBOq6/gsk8onCR1CSG4FDs5d3TTKh8i?=
 =?us-ascii?Q?y0FQezW2PJBnvQ0fA7h53SIyXJMStTfW/dSXn1WnoU0QZnHgTB5rJ0oXh2bA?=
 =?us-ascii?Q?82HC1gJ3BX6o5eZExs9mmFmx6HZb6hytFUgCyWix824eHuazwSesHnWzcZV1?=
 =?us-ascii?Q?PLTMRx44Re2iRLJTsG9CD1pzxQ22ypXBhF/gnTi5OfTAu2MDMpl/YKnQ8Y1Z?=
 =?us-ascii?Q?VTwsdfZNChlBuJLnK5HxHoc0BhnT5VrhZDKAbMkXdegt/w5MKvfwqWdBgMS7?=
 =?us-ascii?Q?sKa93yb1WY2RNafpiowvkHXJsz8yrxOucTX2v3uTspaI9hzNtRtzLuaOEYyE?=
 =?us-ascii?Q?Gtgz1TADWB/NspQowx4xLkAOzpAtnD3SH32yPXkcY5Kz8Icyg1GF0VvwOb/k?=
 =?us-ascii?Q?1/5iANbotd97hRvtgPdfgkAs5qzetem4wxWDH8KgIvfWNp9rw0m7xdyPDEgy?=
 =?us-ascii?Q?HoZuQPDYrAcALLIrYinzDe75rYKRD/kS42uAuU9GPFtK/ncI6rPQi2YriVp2?=
 =?us-ascii?Q?xL11MrBtDcAqKm4RY8yy2gEcsKWBWlyDy8twjegnAOJTNovwvoI7lBSpJxwb?=
 =?us-ascii?Q?dFlDLh9rDJxsYZpfWlbM2S8oWs2gVVgzrHjbORBhumYzWrfMhvoUURYWiBxd?=
 =?us-ascii?Q?tavr+ZtDuB0RC7k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:30.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6fdd93-2332-4100-ddf9-08dd31f0b858
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

As the bridge between iommufd core and vfio core, add a set of msi_iova
helpers to call the new msi_iova helpers from the iommufd_device level.

The next patch will use this bridging helpers in vfio-pci code.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/vfio.h   | 25 +++++++++++++++++++++++++
 drivers/vfio/iommufd.c | 27 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 000a6cab2d31..f38a1e910a2f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -133,6 +133,12 @@ struct vfio_device_ops {
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *vfio_iommufd_device_ictx(struct vfio_device *vdev);
+int vfio_iommufd_device_set_num_msi_iovas(struct vfio_device *vdev,
+					  unsigned int num);
+int vfio_iommufd_device_set_msi_iova(struct vfio_device *vdev,
+				     unsigned int index, dma_addr_t iova);
+void vfio_iommufd_device_unset_msi_iova(struct vfio_device *vdev,
+					unsigned int index);
 int vfio_iommufd_get_dev_id(struct vfio_device *vdev, struct iommufd_ctx *ictx);
 int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 			       struct iommufd_ctx *ictx, u32 *out_device_id);
@@ -151,6 +157,25 @@ vfio_iommufd_device_ictx(struct vfio_device *vdev)
 	return NULL;
 }
 
+static inline int
+vfio_iommufd_device_set_num_msi_iovas(struct vfio_device *vdev,
+				      unsigned int num)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int vfio_iommufd_device_set_msi_iova(struct vfio_device *vdev,
+						   unsigned int index,
+						   dma_addr_t iova)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void vfio_iommufd_device_unset_msi_iova(struct vfio_device *vdev,
+						      unsigned int index)
+{
+}
+
 static inline int
 vfio_iommufd_get_dev_id(struct vfio_device *vdev, struct iommufd_ctx *ictx)
 {
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 516294fd901b..805efdbccc97 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -69,6 +69,33 @@ struct iommufd_ctx *vfio_iommufd_device_ictx(struct vfio_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_device_ictx);
 
+int vfio_iommufd_device_set_num_msi_iovas(struct vfio_device *vdev,
+					  unsigned int num)
+{
+	if (!vdev->iommufd_device)
+		return -ENODEV;
+	return iommufd_device_set_num_msi_iovas(vdev->iommufd_device, num);
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_device_set_num_msi_iovas);
+
+int vfio_iommufd_device_set_msi_iova(struct vfio_device *vdev,
+				     unsigned int index, dma_addr_t iova)
+{
+	if (!vdev->iommufd_device)
+		return -ENODEV;
+	return iommufd_device_set_msi_iova(vdev->iommufd_device, index, iova);
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_device_set_msi_iova);
+
+void vfio_iommufd_device_unset_msi_iova(struct vfio_device *vdev,
+					unsigned int index)
+{
+	if (!vdev->iommufd_device)
+		return;
+	iommufd_device_unset_msi_iova(vdev->iommufd_device, index);
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_device_unset_msi_iova);
+
 static int vfio_iommufd_device_id(struct vfio_device *vdev)
 {
 	if (vdev->iommufd_device)
-- 
2.43.0


