Return-Path: <linux-kselftest+bounces-24294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED7A0A0A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DA716B8D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209861A238D;
	Sat, 11 Jan 2025 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOrPawZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8F1632F6;
	Sat, 11 Jan 2025 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566422; cv=fail; b=I5g6dzHzj0x1kwGS43C4qK3rBMLct6wOZLIabV3zskI1OPUO6enId+Kq7U92Jf4DdN0f1Jfcckk5tjT0qSHGU2PQfmtXtf6waSUQIV4W1ScyQ7E3PEHqJgMpuSQa05nquwo5Hn+71j7Yv2eTw4n2EOn/Ik5Qw8s0hMQeBpY8IKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566422; c=relaxed/simple;
	bh=CpICmkVyy/ovYcRg0oXpQLpMERRABe6nQkq2X/QAah4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saw8hPifRkpZYfhAXKCWc2rlWyIn//POg6WYuKnq4uPFDcTn/3xG0S3Ts/MF5ny6ZCgF9+4cOpgFmoZhIxqfRVqeyC0dZDfNNubUKpPFUMw45Ee9OmOrqyflbMUIDB0uloV4UcxRyFfX/0SUdGFgwgSSpt2ejQniTxonTg0F990=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOrPawZs; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqZQ3gOafsKPnEmHH5rxSFZaOls1XO9KSE6yAH3YFJyXmdk/wcsA6XIbIhFY1ftsy9BxXkm8MApKxakpalFWuT6IgXvsHKN7IQ+7kssL3oIylMJx9CqqkKD0H5FTO+1fJf9mFl25O3+yvXbNc5uR6zqRg36v3YYWQ46wgNqiVVLXZPgovDjlbzv6RhePja4730VNDHdVwntEmHCkDpHGjC8NcLIrsIB8wxfcXvkDlwVnWJfv+goZABfjVaQFr9k95o6hlPOmENyUK2P2/CfX53fr2P1n8RPTXyeBTt1tbxIuRorpmFCxRSMeHLNFUiDLr8S6YW92TLTjKcFRF/ZU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+cYuVWoTFkp7rL+GzblKSnvY9PzSqXeL4iPuXRfwgg=;
 b=IEM+/2kT1e9U2gTGMRb18Qf5T8QegN54l/Phd4MmhztSG63z41D3j82aoajl/ycM/Krb7PZwRMVSLN0Muz4WJ8c39T+f/5DjJnfa3kn8dg7kY9RyTKDM5DCkKZGqmIQa/EIVVsh/Zx332x0xt1YJMZuWGjWUwF7Xx1bLiFcPy810BjQdXhbOl2VZJEcLvWlkliDhEaA8TxOfXxDvwL2U28rXpXa3fEhPdHPcX5XeBed3RjVfhmq9smquLHPBIQz6CPFjv5AQ3EUVk6pzSY3X23qXcxYOSy28d2DcHHOIQRERdR1COTGwZ0hz4BonedWYIB79p2YMekhFiNf+tNwkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+cYuVWoTFkp7rL+GzblKSnvY9PzSqXeL4iPuXRfwgg=;
 b=WOrPawZsZjyrYEceKrO1eDJEB3TRg0nvqZU1o8octRy0ctoWq0zYXclv4XwrXLN8pBG9+CMuOYzPVmyJnyN7Um4MDJ+iigNFBQpb6bltsuwWgLWvIGucvuevOzAPUAdYsVWRWKOy9gXm80smBlMB1FhqgxiFd/MQDs/lxMvOHKnaicoLFPmhBFPkuQSyy5m2sLbY50bv+pO8GT0A9YhHBBYLsfm5RN3WQPeNcBG/dUMoPlfrOv3mGhK9a5+YtipByaCcdnI+G5PIvQGdXNqDVj3gPp7xoz9LEDQtKkg4aFCFdp/lsOgEHcuZkmUsZHMoNAWQW0vjzLI8LbpTKr8SOg==
Received: from DM5PR08CA0048.namprd08.prod.outlook.com (2603:10b6:4:60::37) by
 DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Sat, 11 Jan 2025 03:33:34 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::e) by DM5PR08CA0048.outlook.office365.com
 (2603:10b6:4:60::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Sat,
 11 Jan 2025 03:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:19 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:33:17 -0800
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
Subject: [PATCH RFCv2 13/13] vfio/pci: Allow preset MSI IOVAs via VFIO_IRQ_SET_ACTION_PREPARE
Date: Fri, 10 Jan 2025 19:32:29 -0800
Message-ID: <d8b285b10bb888c3687330c529516b415d466686.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: da8246e0-122f-481e-6345-08dd31f0ba46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5fGGaafnLtwGvDwL86dbuDTk2bl9wEFvuCAiudRKrwTe7QPTSLkpnBMaVe5c?=
 =?us-ascii?Q?0RW+MLb1GZKVkHgnfqnE209jgfPeUo7LiE+8vuGOkj4GfN0uO5ajq1aQxg/R?=
 =?us-ascii?Q?IjoG3FxfLDG7JbJoQ31BUTixjqW/4SdXhaGbO4quaEBmar78i+zQCC1CHk/q?=
 =?us-ascii?Q?lFNjLhieQcJ673BtJKyokKWcpQeFnXZDGX/9B+JfonHyBNGGZXk/w9OIGoq0?=
 =?us-ascii?Q?SBdy372vNMFFNm+RBipIciQSG1Q8aIXHSw005yqpj71cdTN3R5CaVewntkAT?=
 =?us-ascii?Q?fgGWU2xlkcKRIlR6y47Q21vQVgbUqX5CRaISuveeZa3EYRTq6FNoOHFAgpmp?=
 =?us-ascii?Q?FzIt7U5CcGMEIqhvdIco0esoa3nzUIBMuA0zCJJyqGlM3kEVs/SuQoEDdgku?=
 =?us-ascii?Q?ewlPv0Vkq6Ib3LJecorkoEebNmlANaJ/50qxUvhzQ5CaW4jJS5uGJo4EksX7?=
 =?us-ascii?Q?IhP4/UJO+uGJsd2zab6HI0z4FHKUWzhqZKsQ0/ogXCQwjbZWT0A2KGMvYDk0?=
 =?us-ascii?Q?fODwuG/R4XRrIh8gAROAV7SOiZ1pMHBdHh7S8ttz0bAqyrB+DCTGT0ApPyMw?=
 =?us-ascii?Q?2PxLwCRJDKhUrGOs4kjlPmg78MLVt9ttApUwWo5PPHJgMh9w+FfWR6+Qjach?=
 =?us-ascii?Q?U+t+MfbhA1igaUXDMYxB0N16wg2TMEMudI8KamO1GGS3BBTn3wRLT9YeCZV5?=
 =?us-ascii?Q?6M8BL4oIHhH9JmZU0REmGruj8SbgAkhbKXUaceLUaGcELIV9bqJRwAW4lXVi?=
 =?us-ascii?Q?0mmYzpCWoc+9pDT25G+cyO0hmBGgft1AO4A6TsbWBOaOYdaWZ0NMV1XNul3z?=
 =?us-ascii?Q?8PsR4P4v7fV/0gqqY6kIaiMM0iK7USnwmh4NG7WQXJ/rWbfcnLP2r7RfsBbt?=
 =?us-ascii?Q?85OIKTJWjy+Ofzc6SOYAmdQP0NxgVso37qXc/SyL9y5MJ/21/OZph/3qy5ZS?=
 =?us-ascii?Q?UlZ3fRFUAsl05oAy45dGp/VMUOxPnPdCno+rXIfS6iRYj3jC0Zq4U/n4XYB6?=
 =?us-ascii?Q?+fZPnB1ZqH00D0Gvxwdtg6bkQP6IRMY3WMwh9oV2tsfDonRgodjGdvn53UTe?=
 =?us-ascii?Q?7ZblBi/JP9z3d2rH8WNLKX7hkOi0p1GiCHj83rCnCbFJjFNX7SPvmIA8lTYx?=
 =?us-ascii?Q?quWDe4sSydwz3v9QWtCEQ1pNUKWFFC3ifS+qOaxv/pCtSlBq+6JHNpUcv7dG?=
 =?us-ascii?Q?W/iUdV6DOMNVQyXFMBJBLIm5gSEfmRgQdViqDTbsyp+5uDTYiupFbZEjiQIu?=
 =?us-ascii?Q?SvFhuKwX3qd35v8fJCpY+UJJw1e1XABGUo+aNY/i1Z0zYDpbtc946sQ2fKDz?=
 =?us-ascii?Q?n6kUId9WVRCgDE+kJM01DvKGh3WXwptv4C177diRlmvAnK/vkm/zXtXtXbbM?=
 =?us-ascii?Q?iqyIzCkKQ/7rDvp13wtSgWKXzzxbrvyJrzViQbHLxwBO8O8Fe/rJbx4GJaY8?=
 =?us-ascii?Q?lS79xEUbfRD0rMSTo/wybKh4RVmiuFT1o0JmVOJLXsbo+aUTxzdvZCaw/DtN?=
 =?us-ascii?Q?i2xYIbr1VHfWruY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:34.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8246e0-122f-481e-6345-08dd31f0ba46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

Add a new VFIO_IRQ_SET_ACTION_PREPARE to set VFIO_IRQ_SET_DATA_MSI_IOVA,
giving user space an interface to forward to kernel the stage-1 IOVA (of
a 2-stage translation: IOVA->IPA->PA) for an MSI doorbell address, since
the ITS hardware needs to be programmed with the top level IOVA address,
in order to work with the IOMMU on ARM64.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/vfio.h         |  8 ++++--
 drivers/vfio/pci/vfio_pci_intrs.c | 46 +++++++++++++++++++++++++++++++
 drivers/vfio/vfio_main.c          |  3 ++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c8dbf8219c4f..85095e59a3c6 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -590,6 +590,8 @@ struct vfio_irq_set {
 #define VFIO_IRQ_SET_ACTION_MASK	(1 << 3) /* Mask interrupt */
 #define VFIO_IRQ_SET_ACTION_UNMASK	(1 << 4) /* Unmask interrupt */
 #define VFIO_IRQ_SET_ACTION_TRIGGER	(1 << 5) /* Trigger interrupt */
+#define VFIO_IRQ_SET_DATA_MSI_IOVA	(1 << 6) /* Data is MSI IOVA (u64) */
+#define VFIO_IRQ_SET_ACTION_PREPARE	(1 << 7) /* Prepare interrupt */
 	__u32	index;
 	__u32	start;
 	__u32	count;
@@ -599,10 +601,12 @@ struct vfio_irq_set {
 
 #define VFIO_IRQ_SET_DATA_TYPE_MASK	(VFIO_IRQ_SET_DATA_NONE | \
 					 VFIO_IRQ_SET_DATA_BOOL | \
-					 VFIO_IRQ_SET_DATA_EVENTFD)
+					 VFIO_IRQ_SET_DATA_EVENTFD | \
+					 VFIO_IRQ_SET_DATA_MSI_IOVA)
 #define VFIO_IRQ_SET_ACTION_TYPE_MASK	(VFIO_IRQ_SET_ACTION_MASK | \
 					 VFIO_IRQ_SET_ACTION_UNMASK | \
-					 VFIO_IRQ_SET_ACTION_TRIGGER)
+					 VFIO_IRQ_SET_ACTION_TRIGGER | \
+					 VFIO_IRQ_SET_ACTION_PREPARE)
 /**
  * VFIO_DEVICE_RESET - _IO(VFIO_TYPE, VFIO_BASE + 11)
  *
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 8382c5834335..80ea6bc1941f 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -685,6 +685,8 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
 
 	if (irq_is(vdev, index) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
 		vfio_msi_disable(vdev, msix);
+		for (i = start; i < start + count; i++)
+			vfio_iommufd_device_unset_msi_iova(&vdev->vdev, i);
 		return 0;
 	}
 
@@ -728,6 +730,47 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_set_msi_prepare(struct vfio_pci_core_device *vdev,
+				    unsigned int index, unsigned int start,
+				    unsigned int count, uint32_t flags,
+				    void *data)
+{
+	struct vfio_device *core = &vdev->vdev;
+	uint64_t *iovas = data;
+	unsigned int i;
+	int ret;
+
+	if (!vfio_iommufd_device_ictx(core))
+		return -EOPNOTSUPP;
+	if (!(irq_is(vdev, index) || is_irq_none(vdev)))
+		return -EINVAL;
+
+	if (flags & VFIO_IRQ_SET_DATA_NONE) {
+		if (!count)
+			return -EINVAL;
+		for (i = start; i < start + count; i++)
+			vfio_iommufd_device_unset_msi_iova(core, i);
+		return 0;
+	}
+
+	if (!(flags & VFIO_IRQ_SET_DATA_MSI_IOVA))
+		return -EOPNOTSUPP;
+	if (!IS_ENABLED(CONFIG_IRQ_MSI_IOMMU))
+		return -EOPNOTSUPP;
+
+	ret = vfio_iommufd_device_set_num_msi_iovas(core, start + count);
+	if (ret)
+		return ret;
+
+	for (i = start; i < start + count; i++) {
+		ret = vfio_iommufd_device_set_msi_iova(core, i, iovas[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
 					   unsigned int count, uint32_t flags,
 					   void *data)
@@ -837,6 +880,9 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
 			func = vfio_pci_set_msi_trigger;
 			break;
+		case VFIO_IRQ_SET_ACTION_PREPARE:
+			func = vfio_pci_set_msi_prepare;
+			break;
 		}
 		break;
 	case VFIO_PCI_ERR_IRQ_INDEX:
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1fd261efc582..ad11c8e7da7b 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1554,6 +1554,9 @@ int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr, int num_irqs,
 	case VFIO_IRQ_SET_DATA_EVENTFD:
 		size = sizeof(int32_t);
 		break;
+	case VFIO_IRQ_SET_DATA_MSI_IOVA:
+		size = sizeof(uint64_t);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


