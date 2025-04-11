Return-Path: <linux-kselftest+bounces-30512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE7A8545A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C31B9C0C39
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE206280CC2;
	Fri, 11 Apr 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XozmCHO+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFC27F4F8;
	Fri, 11 Apr 2025 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353523; cv=fail; b=pizeekgZiTnQluaIKPoNR+1lX+RioBZKK377JTBOVpIoQcrQUhNkj3zWzvRGvLwys6NV+gYSPUTJKwAhq0WeHHt/xxdJf1aeVKWeww0Csw6KvHTDyP1ZtJowZ5B/yEU4+yrLMu8FmMzu8yfwswWVeOOcCDabDSW36k/M+0KZZTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353523; c=relaxed/simple;
	bh=qDPBk7iBhP4NzNv1Vf8C5EUudX8yEi+FOGLhLDv/8Mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kapW7vxVhCtDWI8F6UuwkjrDmGCf3L+P4l0leFpJPAYfbSYI6hDbxbONQy82mKEB+N8+SgM3U882cE/EXen7smm1rUgROd9ibSjj8Ea2Q9r0rQKMkTVrot30ES8upKWtvjKNFfZ4gfCcuigNPewgHOcg78VYDby1Csu46AARQOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XozmCHO+; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByYD6MDb869XC7BL3doVq7HeHNKtoC8hufWUU1KMbYjt3BkyGiHoXiRuHXWDltVFUZESx0JVKAph6cHltQI33a83HBoWB8TqS/nC188oZsY/TmbaGPh2HaxqdR+2KC74jBsl594g/ycl61Rh9atglTOwHuGr9isgl/V2zdpIVGkUFkxIzG0XCjxhZL0FqELxCKwEdobFpaplRD3sbaKG15pWq0zT/dEnGiPa3s7BubnrvHWWonwZsW8l0nNpZC5A/Qd3FoqNuFKAgk2cDO0gRf99nv7ldI/EUm03RtcJAqkjzRukQhTAo+GrKnJTegG6N+9Dn53aPYiLR4N59f5YcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw7FhyMnLZ7X1nN+jxulfpmQwgu2NZLbUsJpYinZ/vw=;
 b=q8WNLhThKEQU+MrXqaYa0Jp9Gcnmr+lV/74m2ufbu/6bX5lCUU9vEEDOxLxdUJ/xtgC44NRxZmNCDOGI5nE9OmFr3zabNWF/X/yZZkYN8oplRf5HC+s+btMllgJCFpNW+k9Iaup14htniQdHvTethLLDWMkd6vvApzP/DABmBNCmz1XieZPTvu6D5oJgLZbjJ9I5ZIlNxrBHzzpPtXVvXe+R08dA/ZwKPbxXwvecmw2CnlQzJojWoS3ue4PjNF90Tn5oV0q3W1UAJQWpeXsqwBCHJal7kqKX1M8w8HVGKHSnQfvA9hvnEUAunqqixd2gUO7m/p3U13nv62aeWnuPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw7FhyMnLZ7X1nN+jxulfpmQwgu2NZLbUsJpYinZ/vw=;
 b=XozmCHO+FTWJHrUT3g+EqZCEpSQ/1yG6jzjRIdI5pwkup+nrcYrWYfB5S2TpqRKS25TCNyWPdD3Qs4xQcRLRIe4aUPkG4YirHq4mLUWEaRR12l6mvElhLkkzkmVy+jCq/iuXmJ8r+vpfDKyxmfURHEBwfs5TwCqndyher6CWhpo9kWl5nvkU7xOl8u+0Y8A/4reqAMH/9Cmzayi48q4qvqbvy/fZI4cp0cQg5fRo7WD2J1zFy/JdpEb1Gi2uy3Y03Fms8dNziR4WwdgUdwWz9PvzYIiFksWeS8T62sTifffbG06CZZVwakkBF+WaJP1PGceLj1a8TrntrQBIvWkdZw==
Received: from PH7PR17CA0034.namprd17.prod.outlook.com (2603:10b6:510:323::12)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 06:38:38 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::8d) by PH7PR17CA0034.outlook.office365.com
 (2603:10b6:510:323::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 06:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:38:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 09/16] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC ioctl
Date: Thu, 10 Apr 2025 23:37:48 -0700
Message-ID: <5cd2c7c4d92c79baf0cfc59e2a6b3e1db4e86ab8.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cee890-1170-42bc-9218-08dd78c37db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+zt0zlH7AN9Q+hfra3xUZ1OzoZISaxOOum2rJRkCh5mc32TVW4hzMfjp1p9?=
 =?us-ascii?Q?5E5xSSxBwT0HHIGeECNZs4WglZ6LyAvNLKKOSEsQ2LU9pZKcZI3/C6mPETwm?=
 =?us-ascii?Q?A3f64IC3qxGaLb0c4h2gZ86vE5nUjEq73N26cvEh9EzSdyIInm8kZ3CxeobL?=
 =?us-ascii?Q?R0/Idrn9BgadbmGjEL6rqa+c7Qo9MbtqqiYMhHqJuF9XkFsGgBdZumBFftDB?=
 =?us-ascii?Q?VNckxucv5BcechsdTGoSvfDZbNvXiasWLtk+HyA4ZT3TI1Rg77o9rhxKXOnP?=
 =?us-ascii?Q?rLDRRPUdQBUL0lezwCj8xlgcQ2sfVMDjtQLY4EjkbB60L0w0eBX5koNwdjRt?=
 =?us-ascii?Q?Y4dlt9KkIfYobF7rokgC5vpmCHDHjC8YgAgkxmCOaS6krZvYghxfUPOkFK2R?=
 =?us-ascii?Q?thydxKeJMkIvFfZnbFdJRDCLK9wIKLq4gGpRwnplO8BZXyMp7b4vr+71NiAv?=
 =?us-ascii?Q?tlN5H58mUmPabmVZqZB2rLRZ0+lbznoFHl4IHkcwhZErgCOuMWRVlCQcJYoa?=
 =?us-ascii?Q?rzUA5qmVjA+VsRBHpAzXSFFJof//r6uikHqIKWqSXfWrVOrBk1Wjjbh/Llh0?=
 =?us-ascii?Q?6YaVqmEdWWEwz83J0RkFxSQ39cvfRTQw3FDn9d07+SlB6x+C25igx/bk/xWL?=
 =?us-ascii?Q?BdQAZ2EI46+nWShAC/0lPhsZmLXmejpfUytWF8DuP9Y4GRUCdtJzNaohmSag?=
 =?us-ascii?Q?07OeMOCk7ovYddc76tOGTMv+HL2zWIfpaqYcvwcCX0D7iE+Lms0J3dahA57b?=
 =?us-ascii?Q?Dhh4QhmeI5DAsvIRGvF0H6goe6o4hRDAiuL5FVVC2B7vrB6U25dszGAbmmLW?=
 =?us-ascii?Q?qR4Mbk+kHpilsDR/ILf7+osiZCwX1pIKukbVM+c6v2GrOBKn7xhyH1RQfHKG?=
 =?us-ascii?Q?+Qub2nmba6H2dK2ChXDTUpIRbECR3p2E9gkZN/1n47M4xYWGvrVGsbWixA+M?=
 =?us-ascii?Q?dmMEXRiZzSb13ACEm9XTSbyM+WcPYajeDVvfpOtHEnDq42sNql1GxpoyIbwp?=
 =?us-ascii?Q?CCpIwn9JU/BFx8xY4pLDy+vXAC2zGYfk2avkBK+2lvaLcvXm6loxoHlumBgN?=
 =?us-ascii?Q?/7cIswpIicqo8sXRB8dRYF9+Ed7C5FpNeooHVfi8JFyLkIyRHw2rL0PbE2Pj?=
 =?us-ascii?Q?KJkwDfoQgz7f6Lvj2/X1+PhnuC8tuAx1TVY6+9/bYOux/QlCXelQzG/V2oGr?=
 =?us-ascii?Q?5GR/ZQMzQaHG61CPYASds0GDE2zchqNo9YRlizdYP13PAteh5OIOKJbK84qA?=
 =?us-ascii?Q?9R804EQMRo97G8yybk4+vA6EbNJcyW3A9hM9YgBKBqSQtULNOWD338SVxOcm?=
 =?us-ascii?Q?vpeOwE6H6cBFBz2c7N2dszInwHgGUk74P+E2K8MUfWK+OKjWRo25CKmwL4tQ?=
 =?us-ascii?Q?at3Uz8pcT7RV8cfs3lZKXZ8YJGOUTwaKWlZrPFiJZ6Mxz196y1+MfD/TdMPU?=
 =?us-ascii?Q?6oI7QX7Oqqp6+YlTL8F1FYmI06E0wGLDtSB1t5FjFG8ita/euL82+dWdbRfJ?=
 =?us-ascii?Q?fnOQdPN6NrgkOQHi65Q7omepFMuO+qIoa2o+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:37.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cee890-1170-42bc-9218-08dd78c37db8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

Introduce a new IOMMUFD_CMD_VCMDQ_ALLOC ioctl for user space to allocate
a vCMDQ for a vIOMMU object. Simply increase the refcount of the vIOMMU.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 include/uapi/linux/iommufd.h            | 32 +++++++++++++
 drivers/iommu/iommufd/main.c            |  6 +++
 drivers/iommu/iommufd/viommu.c          | 61 +++++++++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8d96aa514033..da35ffcc212b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -605,6 +605,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vcmdq_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cc90299a08d9..428f1e9e6239 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,7 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_VCMDQ_ALLOC = 0x94,
 };
 
 /**
@@ -1147,4 +1148,35 @@ struct iommu_veventq_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
+
+/**
+ * enum iommu_vcmdq_type - Virtual Queue Type
+ * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_vcmdq_data_type {
+	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
+ * @size: sizeof(struct iommu_vcmdq_alloc)
+ * @flags: Must be 0
+ * @viommu_id: viommu ID to associate the virtual queue with
+ * @type: One of enum iommu_vcmdq_type
+ * @out_vcmdq_id: The ID of the new virtual queue
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
+ *
+ * Allocate a virtual queue object for vIOMMU-specific HW-accelerated queue
+ */
+struct iommu_vcmdq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 out_vcmdq_id;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
+};
+#define IOMMU_VCMDQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VCMDQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 2b9ee9b4a424..27473aff150f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -303,6 +303,7 @@ union ucmd_buffer {
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
+	struct iommu_vcmdq_alloc vcmdq;
 	struct iommu_vdevice_alloc vdev;
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
@@ -358,6 +359,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
+	IOCTL_OP(IOMMU_VCMDQ_ALLOC, iommufd_vcmdq_alloc_ioctl,
+		 struct iommu_vcmdq_alloc, data_uptr),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
 	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
@@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
+	[IOMMUFD_OBJ_VCMDQ] = {
+		.destroy = iommufd_vcmdq_destroy,
+	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index a65153458a26..c5a0db132e03 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -170,3 +170,64 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+void iommufd_vcmdq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vcmdq *vcmdq =
+		container_of(obj, struct iommufd_vcmdq, obj);
+	struct iommufd_viommu *viommu = vcmdq->viommu;
+
+	if (viommu->ops->vcmdq_free)
+		viommu->ops->vcmdq_free(vcmdq);
+	refcount_dec(&viommu->obj.users);
+}
+
+int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
+	struct iommufd_vcmdq *vcmdq;
+	struct iommufd_viommu *viommu;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->data_len)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->vcmdq_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	vcmdq = viommu->ops->vcmdq_alloc(viommu,
+					 user_data.len ? &user_data : NULL);
+	if (IS_ERR(vcmdq)) {
+		rc = PTR_ERR(vcmdq);
+		goto out_put_viommu;
+	}
+
+	vcmdq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	vcmdq->ictx = ucmd->ictx;
+	cmd->out_vcmdq_id = vcmdq->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vcmdq->obj);
+	goto out_put_viommu;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vcmdq->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


