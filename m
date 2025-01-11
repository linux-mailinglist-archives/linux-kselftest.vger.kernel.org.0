Return-Path: <linux-kselftest+bounces-24292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D1A0A097
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013963AB44C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB99193425;
	Sat, 11 Jan 2025 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N8X8JdwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35ED192B81;
	Sat, 11 Jan 2025 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566414; cv=fail; b=pkPvUWLqpQ4gT+qZhIAb26Vv0nYX3y8pD/Vddo2mO87E2hpLVLN/aWjZjPMEk0Z+4ymvAsQi3YS4ZDE5+yd2QgDW5IWyFLtpWh8mF9wEGHC7ds+xHuBL50sQxkiXhiiWR80keIFzySLSZWR64omxGTp9dJXdzdRwzdqJTsfotxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566414; c=relaxed/simple;
	bh=UskgHOP+W2UFkAmijsQsNGTZoLVcqxz8C4rynW+9FxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT2FgCSearNCRd7joOqicLMh04sG95H9WeNdqgYG2jrvmo94o3xIPuB2aZ06/3A5QmmFce+coX1rywFRnrL9LyoCNAIxNRjaPsNBNDb1rdoYLSn06cyPCqp4KZgHUxml63X9SXbkHorxlJTerxjorbtSoQ/8VCXMA5ODGp3oZuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N8X8JdwG; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVjsCqQM4rpFeW9uRxU7WSYZ23Lsk7T434gU7ZbyBB1srhm3TuNCKf30pYxfBYR7q1aOh26ZTAwVLAJcIPKS5pOk7n4T1k7znllPKQL60BwK2iwrq2aGhp6zGC10KFCXoihugK3H1LHO7+EfkdLYDiZ08HWDni1yyypKb/lUXMSClXXqp3FkYFlxqxx+UWWJpRxkkCpfn6yqiNWWbSu+g87cNCZYQJhH1Lc45XCbKQOCRh/hAWW9mZ+a9SiWmCKCPBvOOGmkwXfAorVe+m90uDbuYUBWSJySndByVG55Qq08b7Pd40DGNgKbmvlnyH4WcWjsN797+2SKkwBQ/WpjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axLq/uDPamtzcl3qQKLL0xAsiBbv+AHRmUrODi9ly6A=;
 b=KODfjTAuNmfcdYWLCbiANCrrm/Btda40GXFnHItycmsrEyLvkXhKbOUC63AajxBSyUvvteK7HMppEqLzA6+bGoA3ZoXYxMUWRfGZOjrHRT1sx6ftVaZIDCa6jrqbt4ONhEj1TNahusU/dO4AzO7UIIfOTczHd7xphHlIV8MwBwMoz67g1W0pCqxIXJGE8KlDP4mon5vykbYY86Z6JgdpgrrCAdlggObj1bg2i9q/coMXTvByEurqpbGp5/VwkE5q9rEvERvpeXo89SYGZT+txkeasO5SUIpTANd+OWp9zJIb5XXLt6JcqyJAygYLhRlQSfsr7ZKALlGqNehqSY5mWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axLq/uDPamtzcl3qQKLL0xAsiBbv+AHRmUrODi9ly6A=;
 b=N8X8JdwGxmoJjWe3y2RJrGalxRv/eYNA213PBzk0zjVHBcR9zyQKoeTUx3zc9ocZyZrftGTL9mCOrBn3fTshJVxTdpbttZLDRtYA20ljBmgYRoXg18SHYJ+TytGVg/TqDkDKdXNjbqY70VKlIFsE6SQpME5VfiZXe14nUM5pE/CCYoIzVkHxBUJ46GCpwzhFKozVHM+P4eC22eEBL6N92QLowA8uR/DHCqVKSnmigNfoPkiSZh3z+ig/177SP2Sr3yPsjq8ftuw4VlXsnxVH1iZnLODdXEyZfVrCWEmWo62s83H0avjdIu9C8W2BYOEOn0Xby8kFBnalzCift/zyrA==
Received: from DM5PR08CA0058.namprd08.prod.outlook.com (2603:10b6:4:60::47) by
 DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Sat, 11 Jan 2025 03:33:28 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::28) by DM5PR08CA0058.outlook.office365.com
 (2603:10b6:4:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Sat,
 11 Jan 2025 03:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:14 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:33:12 -0800
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
Subject: [PATCH RFCv2 11/13] iommufd/device: Allow setting IOVAs for MSI(x) vectors
Date: Fri, 10 Jan 2025 19:32:27 -0800
Message-ID: <1ef64bea7c025edf11867a94dad996f0f5398d63.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb26e94-2893-4524-2973-08dd31f0b6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o2Xk7nonwwB0ekZIFILp32NMPL7coljD4aV2shpllldlVdohn5QMOUtiW9EM?=
 =?us-ascii?Q?4lyR3Du+Kdgk8EaOxhXRkKhoYpuWibFOoF9VPjNuN8DBdBhnpVuz8UsJ2NTP?=
 =?us-ascii?Q?uZLiBFlX8DMr4NGyy7tSqbFj5Q0Hl+JaiYnLK8umN6oKVWFYB9kaDmXhQ7E7?=
 =?us-ascii?Q?p0zMKT66efcuo3rA5hii8/6lR6y6faYyfsXclcJffc13k9Ded/NRb0tyaghC?=
 =?us-ascii?Q?CV6BQ9ciLzM+D07Fuu2iTG5cUyGVpOLEVisLIveXv7zpvpGJPOkPi7Zhmz2O?=
 =?us-ascii?Q?VnHR63UN0GSpLWnxoDNoDB/NtQJ2D+UKk0aKNb5SAbDwz5tM/FVEK5tS27B6?=
 =?us-ascii?Q?AcfY51q7VflyT45lek5N1jnN+Bc4OcrBvSkhWqylw/cY86SevEXOdJ1a+Pk+?=
 =?us-ascii?Q?t9BAv6n9dtrw5GrKGXffjaJzycg2isFumy4cbWGswh00PYKQ8vkXt/piuXk7?=
 =?us-ascii?Q?c9GQi90Upct9eBD89GF3lbomSjZTy3rEMkcShmL8B9Mh4nSOz3frISaMsFBt?=
 =?us-ascii?Q?gSLDlVtpV6RhaBi/SB9ujvwOY2lWCf1cTkRkRcxIlLwHgiV2loH24xGFcHEm?=
 =?us-ascii?Q?zik5DIDxhoKVjO/v955YeG+wIsVPcBz820mzKRG3hncTyep5MKTRwLVmmMhr?=
 =?us-ascii?Q?N0mnSTTOafssDnJmN0EyHGYydTOzsB+pG2QWShP5xSvXi15XygiJAKggSJvP?=
 =?us-ascii?Q?DlOeP3EYpafMat93KaiNdth7AVl6cCXx4Ls3gkWfJoz0ex5adg7uae5aqXSK?=
 =?us-ascii?Q?ARZbJO+8XSN7S9AAcbNRCvexqZoOj29DbToArKIxlPjlB9fKT3qCZA95mmgn?=
 =?us-ascii?Q?lHCc5LbIl+TmLt+MDXVX5XQJPiYdKQ7Gcz0PdIKyNMnxte1EZwI5amKwtR3V?=
 =?us-ascii?Q?cS/FpvMNXIGp8M9gCoqn6IchWG6Hb3vB765smLCn8h4puJspB5wMr4nr5M5K?=
 =?us-ascii?Q?jid5H7q9xh7qGfOIHJ4issQcBnirvwy2eOfbSq3wJfZ8SMqsVP5bVtzXGcO5?=
 =?us-ascii?Q?RXsu46tiSUqUYUoevVuakcIPWT4zHBpfw6RjCU8bOEa5rmKsMoTk8J3KaTsQ?=
 =?us-ascii?Q?08H4HM6wvYUJmWEiEDKoqkS9XmKo+mOjM6gUE0KV7KS68eg2yrKwEt8UdZBo?=
 =?us-ascii?Q?SrkVpbiIXXEdhgAbw6m57XqhQV8b6BnUyVIpqtt6a5EwOhMUotIpcbx1Xa1M?=
 =?us-ascii?Q?+l2ruC7fYeycvo/hgGDdZrr3bWt+8ZoknIMvGjsEfh8WlkEiZUiQiZsViph+?=
 =?us-ascii?Q?xNc9thXaQ2jsOgoddiwYQw3j5/Zo86JzLWhCF8pT6TpkqADlA3+vUXqheLWZ?=
 =?us-ascii?Q?FWcYrhzGMOUbFuOEDV4kB2+vo1MZhThLPUPsTWBzKBBCJTwuGOAw2bDSwdXy?=
 =?us-ascii?Q?Tj8wTA3Gv2VxG7BIvFuESUMJFTdS1L/iv98q2Yptg2BgL8f00v2oMy5kZ0TF?=
 =?us-ascii?Q?kFIiE0JNFOZDgl/Xf+/V3VNgCUuYg+BDg34fJLhFHM0xp6xhC7PLpmcw0s0l?=
 =?us-ascii?Q?l+shS1BgSCEgAeY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:28.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb26e94-2893-4524-2973-08dd31f0b6ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

Add a resizable array "msi_iovas" to store the user space IOVAs for its
vMSI(x) vectors. And use the corresponding IOVA for set the msi_desc in
the iommufd_sw_msi(). This allows irqchip driver to program the correct
MSI doorbell addresses (in case of requiring IOMMU translations).

Provide a set of helpers to allocate/set/unset the resizable array. The
next patch will call them from the vfio code.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 include/linux/iommufd.h                 |  6 ++++
 drivers/iommu/iommufd/device.c          | 47 ++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9f071609f00b..81ff46d630dc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -427,6 +427,8 @@ struct iommufd_device {
 	/* protect iopf_enabled counter */
 	struct mutex iopf_lock;
 	unsigned int iopf_enabled;
+	dma_addr_t *msi_iovas;
+	unsigned int num_msi_iovas;
 };
 
 static inline struct iommufd_device *
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..787dcdcb9b3b 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -58,6 +58,12 @@ void iommufd_device_detach(struct iommufd_device *idev);
 
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
+int iommufd_device_set_num_msi_iovas(struct iommufd_device *idev,
+				     unsigned int num);
+int iommufd_device_set_msi_iova(struct iommufd_device *idev, unsigned int index,
+				dma_addr_t iova);
+void iommufd_device_unset_msi_iova(struct iommufd_device *idev,
+				   unsigned int index);
 
 struct iommufd_access_ops {
 	u8 needs_pin_pages : 1;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 093a3bd798db..3d16967146cc 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -137,6 +137,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	if (idev->num_msi_iovas)
+		kfree(idev->msi_iovas);
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
@@ -294,6 +296,45 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+int iommufd_device_set_num_msi_iovas(struct iommufd_device *idev,
+				     unsigned int num)
+{
+	dma_addr_t *msi_iovas;
+	int i;
+
+	msi_iovas = krealloc(idev->msi_iovas, sizeof(*idev->msi_iovas) * num,
+			     GFP_KERNEL);
+	if (!msi_iovas)
+		return -ENOMEM;
+
+	for (i = idev->num_msi_iovas; i < num; i++)
+		msi_iovas[i] = PHYS_ADDR_MAX;
+
+	idev->msi_iovas = msi_iovas;
+	idev->num_msi_iovas = num;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_set_num_msi_iovas, "IOMMUFD");
+
+int iommufd_device_set_msi_iova(struct iommufd_device *idev, unsigned int index,
+				dma_addr_t iova)
+{
+	if (index >= idev->num_msi_iovas)
+		return -EINVAL;
+	idev->msi_iovas[index] = iova;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_set_msi_iova, "IOMMUFD");
+
+void iommufd_device_unset_msi_iova(struct iommufd_device *idev,
+				   unsigned int index)
+{
+	if (index >= idev->num_msi_iovas)
+		return;
+	idev->msi_iovas[index] = PHYS_ADDR_MAX;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unset_msi_iova, "IOMMUFD");
+
 /*
  * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
  * layer. The mapping to IOVA is global to the iommufd file descriptor, every
@@ -403,7 +444,11 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 		return rc;
 	set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
 
-	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	if (desc->msi_index < handle->idev->num_msi_iovas &&
+	    handle->idev->msi_iovas[desc->msi_index] != PHYS_ADDR_MAX)
+		iova = handle->idev->msi_iovas[desc->msi_index];
+	else
+		iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
 	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
 	return 0;
 }
-- 
2.43.0


