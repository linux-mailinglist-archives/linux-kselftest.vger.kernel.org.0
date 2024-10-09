Return-Path: <linux-kselftest+bounces-19377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A18E997204
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6191C2209E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1E1E3DC0;
	Wed,  9 Oct 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HXM85HWM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26E1E2857;
	Wed,  9 Oct 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491958; cv=fail; b=QtpmD3Qup1w+khwSaSkR/WLBr3VUPbOjTm9hxpdJ9IbiE4S7v6QdpHnYo4MOTnKUW5K5ODi6SRt218XwdA+1FXQkPCcldDSXLhRA4VNEYA5HkqfMaeopBvo5nMjeZgHJ05RJ+fOW2hcCzYtCZ0IVRx7Fq1eroFIOgbCNOvU6uxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491958; c=relaxed/simple;
	bh=1iXt9S78gzBFj3/ne0bk/6zXz+6Wxdn/0lr3znhbikY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWicNS2XBPi56QCCKK1Y6LXkk2JwSW5bLjajHLelU56EYVcsTRX/WakebpUw8i2M939RaEeXUcpuD3/r5gETeec721+o+N5lSXHf0jtoSnNlrD315wE9JLAYgo5zQ4zeqiawQlmWCm0dH8cMgA49gc3Ow2M79IufJJjMprJL/gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HXM85HWM; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNfagPiEKfCkBnpbP3xpAUFzLjYWdfNGHJwWs0EY5mJeV7/z8Y3W1lWgZwmGM7XT7bAV//9eAfhx3zuRe8MVdVdt2v/9ZXjUVLNnNDeq+HqfT/KolIFAKcnz95wP12kLlazdk1boVXGkVdSVnmFCGqF7dXCSnuVtz4arOtYVwB67GgGL+MEKGQL9BvJ/urZwhJLa0znOOjNtl0boNMKYSSodKTMH+t40RNEuwF8ebxDBJVeu6PCyMu/Oec1a9X7CAISIsr7ihkQPHhuGpA2snpbW1xhaz6AAPPQ/RbMraTaWkKCd1D1f7dP8jWcACPsFRcYWUAJiyYKKGSWk/wCPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jA11bv8t/1NmA3vYGVqYtdoZIwtXJymgG7aJf9h0vY=;
 b=GGrQnkCeF86MKl7vwnDEHOo2wrYhvBmFRM3DvpjdfcgZcZVJObaHXYZz5x8R6BOp0wUEboWzK/D271l0JB+4S+FF7ucDGIEQiw2T02AQZO5ZOhZkSh61Ilwy32rMxuIW89LGoRUNqQQ+sI0zX55OxvZW6SKDDHeaNcv5yXjcFtKYaamTh/nTo1waxNJ4ZOJMTZQuYBCfc12HD2B96q34NydBbVKsB/gGv9CnBTU0zwMzMmXgblPVxCstF5BedUKlaoHY3/96mZjsymfOtGHSBiEzSNUce4WBAxpR3NqTogzQyaF9TMs7oY/NVP5BOKmHRbKt+efHmQ/gwLsZn/1Asw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jA11bv8t/1NmA3vYGVqYtdoZIwtXJymgG7aJf9h0vY=;
 b=HXM85HWMsFb9HUj0ncyvpXgbp+9hAcNoy3bhusMgzMHV2+t0ei53ReUe62/h59wtPB+3N8gOl6yTDstBeOJ1QU3iTG13pSt4l+AzegUW7gIAcZEGP0IjbeKXo5sMj/hvhPJY2GbE7ldIgzOtMtHg2BAceOPnk71jIc7vGIus0MvPbs0aF9juggwCP2Hf4ZJ+dYhV6tKxBUdVVHklaRxexnEzXZspwRHq0SRLDOH5MZp3gee9htGI5D8EPWR5fRpikJ9xhGMRnwfyBqbkcdTZvRJWfpqfOF4yLbWrb2tZluLC90j1q0l/Si3p8LJkORh4K72cnzYqJUZXvFfkRFwPVw==
Received: from SA9PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:6e::35)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:39:07 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::43) by SA9PR11CA0030.outlook.office365.com
 (2603:10b6:806:6e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 03/16] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
Date: Wed, 9 Oct 2024 09:38:15 -0700
Message-ID: <df942c216c0e5d1740ba5add73375becf0713dfd.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f1f6b5-af7b-4f63-2b08-08dce880e502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gPdF+C2WtwMvliRKQDJ0LoTT2isXYldq7xVHwhlL7W73qNG2vANo9FI3EHxj?=
 =?us-ascii?Q?Q6Dw0myytNRRBzdv1h7d1uhJw+ard/bnbiI0zFlcub7J81Wnt4vI7v24ZICX?=
 =?us-ascii?Q?/YtJj2bFJ+8v1uWpglRJTmFmoBrmgHzBPvqbY8vQrW6x/nIze5ClouVYU/bw?=
 =?us-ascii?Q?nENc9yhoq+Tx86SNBv+ehm7F9zEOUEb7af8Pkt3P7t+dpHTQMLoNhtfQommu?=
 =?us-ascii?Q?hevbTcgqLu3Ea9ePUZYIoS7N0IY1D3+zaJrNDY6jwhrp+fJuNOrEP8jLbFdg?=
 =?us-ascii?Q?VIARAMZHn89UbIyLtF4jx38uwKeGrS/6zzUpR8t2st8IeBZlAhMrBeEujT+K?=
 =?us-ascii?Q?gwlY3V3pZqNAOHSapS218zsWtT+FXt1IeYyvcUOmH6mHbmr3SBH/jIByuokk?=
 =?us-ascii?Q?bs2bfu9T7XhbBcVpW8TCwQ/DcVoTbPVpJl3jA59A7dUx5RY7tY7Wyfi24dHp?=
 =?us-ascii?Q?rckHkUVe51T3sEFZULtR2B15Stu0CsEfatwjTY2ahAOm6RcCb+yxkGGMZiqT?=
 =?us-ascii?Q?VbnTgfSM4oCvIA+2JIIh4hw14wopOy8Kugqxou79W9j6Bk3wdUjVZCGTyhAU?=
 =?us-ascii?Q?eXsNAPG6Uz9VUatGiB6RHA/BcfYFracaknsTMRb1mPcEEMTUO9yiVnGhuoIh?=
 =?us-ascii?Q?RpP9edxA7HNe2DTzOe1TeZWP0UrxVY9Xw7n48JCReIB2craxB9PtZ2PJ+r9j?=
 =?us-ascii?Q?Q/SDuXc9RwlSu5DwiG6pxHCic8NB+G/3+DASQ2Lvz0Ggb/FMcFhAxQpqZpOl?=
 =?us-ascii?Q?fxJkaD1ECX0h5W4o8yDU0oBGINE7kaPKHf+OagmX5FgsFU8sBJcaYySVP5aQ?=
 =?us-ascii?Q?VAVZoH0xc8vqqkkDWsgbzaS6VPhtGB0V17MuPDSEdKlZTMZpOK1aK+WxQ6sr?=
 =?us-ascii?Q?ln2gFIGfxTAhi8USnKd6/mhtY4b++eFYTS/QmIJAB9QOa9atLKSz7D1C1ldX?=
 =?us-ascii?Q?KZcTLkeN19qy35sxWA3nxPXbwlQF254oOlc6oP0AQIqn76Dt/UbjuIZpVZBv?=
 =?us-ascii?Q?+aBTu3GeE/JoxaeMaPZG/1kaLvt7Glnwwd0sPvCVmASvfPnOxKJv2zZ0T6hu?=
 =?us-ascii?Q?elALL/kbsc5+N7QTkFZEQcJGxC+2n4OQimmXwnYyy7LmSXfyeU003FQu3EBe?=
 =?us-ascii?Q?xHvJ16d+bvGOTyHS1bT1OH30Mau7njwogcC4iZtV2GCKB2cw+/r/ViNxHM3o?=
 =?us-ascii?Q?6LRiqbrX3HHmNY3qM73a5/I2bHF4abdy6x2S/aRD+o6N601Nk4+t4KWSH/+R?=
 =?us-ascii?Q?D6vtu6bm+L09dDasSZseBOohOwvXSmTSLHk4Fb0hRK2+7EDWCsZTrAeAUioR?=
 =?us-ascii?Q?2Q6ab885D4QabtvqrM2rFpdUcwQM8auiFNwv41owlZusEfePpR/zWkvCYpCm?=
 =?us-ascii?Q?tuq9dcj+oZBKZa6dMqig94hkyknP?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:07.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f1f6b5-af7b-4f63-2b08-08dce880e502
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

Introduce a new ioctl to allocate a vDEVICE object. Since a vDEVICE object
is a connection of an iommufd_iommufd object and an iommufd_viommu object,
require both as the ioctl inputs and take refcounts in the ioctl handler.

Add to the vIOMMU object a "vdevs" xarray, indexed by a per-vIOMMU virtual
device ID, which can be:
 - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
 - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
 - Virtual ID on a nested Intel VT-D IOMMU, an index to a Context Table

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 11 +++
 include/linux/iommufd.h                 |  2 +
 include/uapi/linux/iommufd.h            | 26 +++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 91 +++++++++++++++++++++++++
 5 files changed, 136 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0c56a467e440..e160edb22b67 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -409,6 +409,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
+	struct iommufd_vdevice *vdev;
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
@@ -523,8 +524,18 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+static inline struct iommufd_viommu *
+iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIOMMU),
+			    struct iommufd_viommu, obj);
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 510fc961a9ad..5a630952150d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -72,6 +72,8 @@ struct iommufd_viommu {
 
 	const struct iommufd_viommu_ops *ops;
 
+	struct xarray vdevs;
+
 	unsigned int type;
 };
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 6ee841a8c79b..3039519d71b7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
+	IOMMUFD_CMD_VDEVICE_ALLOC = 0x90,
 };
 
 /**
@@ -894,4 +895,29 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
+ * @size: sizeof(struct iommu_vdevice_alloc)
+ * @viommu_id: vIOMMU ID to associate with the virtual device
+ * @dev_id: The pyhsical device to allocate a virtual instance on the vIOMMU
+ * @__reserved: Must be 0
+ * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
+ *           of AMD IOMMU, and vID of a nested Intel VT-d to a Context Table.
+ * @out_vdevice_id: Output virtual instance ID for the allocated object
+ * @__reserved2: Must be 0
+ *
+ * Allocate a virtual device instance (for a physical device) against a vIOMMU.
+ * This instance holds the device's information (related to its vIOMMU) in a VM.
+ */
+struct iommu_vdevice_alloc {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 virt_id;
+	__u32 out_vdevice_id;
+	__u32 __reserved2;
+};
+#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index cbd0a80b2d67..9a8c3cbecc11 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -302,6 +302,7 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_alloc vdev;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -355,6 +356,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, __reserved2),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -493,6 +496,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
+	[IOMMUFD_OBJ_VDEVICE] = {
+		.destroy = iommufd_vdevice_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f512dfb535fd..eb78c928c60f 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -9,6 +9,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	struct iommufd_viommu *viommu =
 		container_of(obj, struct iommufd_viommu, obj);
 
+	xa_destroy(&viommu->vdevs);
+
 	if (viommu->ops && viommu->ops->free)
 		viommu->ops->free(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
@@ -72,6 +74,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
 
+	xa_init(&viommu->vdevs);
+
 	refcount_inc(&viommu->hwpt->common.obj.users);
 
 	cmd->out_viommu_id = viommu->obj.id;
@@ -89,3 +93,90 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *old, *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	if (viommu->ops && viommu->ops->vdevice_free)
+		viommu->ops->vdevice_free(vdev);
+
+	old = xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	if (old)
+		WARN_ON(old != vdev);
+
+	refcount_dec(&viommu->obj.users);
+	refcount_dec(&idev->obj.users);
+	idev->vdev = NULL;
+}
+
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev, *curr;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	u64 virt_id = cmd->virt_id;
+	int rc = 0;
+
+	if (virt_id > ULONG_MAX)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
+	if (viommu->ops && viommu->ops->vdevice_alloc)
+		vdev = viommu->ops->vdevice_alloc(viommu, idev->dev, virt_id);
+	else
+		vdev = __iommufd_vdevice_alloc(ucmd->ictx, sizeof(*vdev));
+	if (IS_ERR(vdev)) {
+		rc = PTR_ERR(vdev);
+		goto out_unlock_igroup;
+	}
+
+	vdev->idev = idev;
+	vdev->id = virt_id;
+	vdev->viommu = viommu;
+
+	idev->vdev = vdev;
+	refcount_inc(&idev->obj.users);
+	refcount_inc(&viommu->obj.users);
+
+	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ? : -EBUSY;
+		goto out_abort;
+	}
+
+	cmd->out_vdevice_id = vdev->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_unlock_igroup;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


