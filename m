Return-Path: <linux-kselftest+bounces-33267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B7ABAD4C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464BB189BB3C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002502144D5;
	Sun, 18 May 2025 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZ0NIxij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAE2080C1;
	Sun, 18 May 2025 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538557; cv=fail; b=IqAA8WAU8friKNFa7WNfqbvy8YhDX+4TVRMHZtlQXo/v25rof6rdc1kD2HF2iNGs1HOETZzHs/68RvuTNt6Mpsl7B3Nf1tccFEK3DI82D0vQmV9mG+pkCc7TIoD9nqq3EmRoy6srdYpgcAp7J/Yz0FkfMjGOShPOLKrRw4kJ+uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538557; c=relaxed/simple;
	bh=RagqoaRJ2l2NrRx3ZqLb8ooqWGvWefNVHkHd+mj3iT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVxOTBuZGmCDpq9PEp52kBpHtwYWZYNzIf0ag33A3VLZt7xpJQnYVYvOceupxk4KiWhsBYtBxjTshdWfo4wpnQmAWSmh3mum0y9W8DbQT0gepfOMIGxoLmBoJd9J2p4kkZVZkqX3NZN4FqCQVCpaOI6iiKTsDJmkXi1CJtsSqE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hZ0NIxij; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSxLDO/YSuHt/bVai6w+BbuK9XwQduTkxl5Sd8Df95NZoJdxLtRi4dqKEpnj0SK1VGeNhdpHdmnW8K7UPwIxzUEHxpvXWKRqesVWtDh+YQbW9+zKP4hKDTW8ZwTRW/J/FTGjZwFmtCsDCEPvAxYOlHdyPZ97cjlQdjwTT+Qm1ttDm9LrNRf6bl4UcdKWLPegTlJ1LqdF1qXG7kaiqnQa54bWS8K/LPHEgEu5x9PlI7NPavjApZ+8RAaOGDEU9XdPUsVmqyCCcEhg2qVdQ+5ARmKDufH98lTx3nhAWYxAWz71dwLPI8daVLSx7DbRnpIcCpO1S2V1eRvxtGuXlTaFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luSoR0zid8+QDGSuEZ4qdW8/Yp//lRFYB/zs7aXYTLA=;
 b=NdXHIil1ctsy3Nx4HK6vNmrlAQa6aNcKIhwdE6SqFDhTf8igTKGzspFcBuBxzXRCbiJhelNK6tNJBFxSZaL4X7Jo/ak0FncS28TdEh0N71QoEVOSCu65N7hQo1KR/5YgJy7qQ7fh+hOPhgJ1V+daJ006eKBfGaltY1nd4g9DnXYsk3lipcK7Yy0t/h7ggOh8RRTrtNQwjQN4A1sYxkdgp4SsxXrarIgKpzVG5vZ6B8VX8OPN/I8IRc8Nwjg1IPQwrJIpKuyDBGG0nUmQfFgXn0NJV3+9Krw+bI/g/oIHNAI5ZBUHDnoB+CRAD9eygIiG0go4D6W7HHJQZfA8H0b9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luSoR0zid8+QDGSuEZ4qdW8/Yp//lRFYB/zs7aXYTLA=;
 b=hZ0NIxijT8oSddte7WRMkQOWdDr8WCkPxGgLavkxmEs+MYxGBDgd3WxIsmmtnsgtlg3CTp9G+epX50/tWPFgIXm4YrWKFqRD+x7R1qn9tUKP2U4vnk1hamjadg2PYqi8OCxajFols0X09LTcub7Wb5IsyuVDwAl9gNLwzKN09ACRU0WRzpKerII3l40jAjiSt3hDO+dC12Sn1o4qZJdqYQpBY2gKYjYix32ahBOTWetAa4KPoZiDZq8gkgVMaVWW1snLXUOPFdVoZyWxuG8vEaq/Tg54HOebPJ9in2f/1zht1hUAs9cqNsz840n4PsJryotSAu5GrHBWfrn/CKf32g==
Received: from DM6PR12CA0015.namprd12.prod.outlook.com (2603:10b6:5:1c0::28)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:30 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f9) by DM6PR12CA0015.outlook.office365.com
 (2603:10b6:5:1c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Sun,
 18 May 2025 03:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:17 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
Date: Sat, 17 May 2025 20:21:30 -0700
Message-ID: <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c20839-d9fd-47bc-e85d-08dd95bb38f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMuWDeQA89bdSgN2QC7DwXGSUdwcGbQw6GodtEqRm5fb4mjuGnkR9li+Hy88?=
 =?us-ascii?Q?RP85EhTTyYr8umN3Y0OoXT72JhyEBhXLGolDOZ5rWH1mKX2PmzPR/xn58nEr?=
 =?us-ascii?Q?Jrf+8SWRc9suj7xQNsw8QzemrQVaPjgcGwd3ID9grEe+4b2OJD1wMTqzQEak?=
 =?us-ascii?Q?X0Sm3WlFsYSxPBOdHuywOt6h8Oepyi+Z72S67bf5SQVjHGKC6azESrXiUAGA?=
 =?us-ascii?Q?5Pr6++vkhuETRL/RtxY3X2YTO18zXpMF71urq4jT/KGdDN94MZV4KtUp5b2o?=
 =?us-ascii?Q?/cAZeEu7BYTddqDFKbHBJKqNGRXJPfz0tgTJM7CuJfW+L24dtptZlHGAKn7W?=
 =?us-ascii?Q?doWQnETK3R32N/64SUTf/QykXJ1Eh5AhO9Wvo5wt/wR/QsGgD2efX7il+CvS?=
 =?us-ascii?Q?EcZC0iy/E4Fq+XTOBPNzT2+d1t8MP608+sXVtb3QUadmnJe9bT98SE/0LesN?=
 =?us-ascii?Q?Ng6Lh37GHLgpCv6otiLNeSKW1B0ruddlgGFyhtG0YwBqUi+HPUPnhFywXTiE?=
 =?us-ascii?Q?9nBd74yjNy2Xzh6aLfj1LA5vdpmgepKlzvfs+sDiu7+vBpx+Bp2G6qfFwUdY?=
 =?us-ascii?Q?CD+IgTx4zN59HkdaRAnppTLpiC87WEJ4nOqivltc2hfExyVml97OQVeBOjid?=
 =?us-ascii?Q?9PPIPivaOO1YpXduAKWD9EVAh9lAJcs1K0KfuH8uS09CpyX9kECidpshGW/d?=
 =?us-ascii?Q?AgU6mc7X2qCHJi26wrSA+jNSBlaOA3JYXfED1fWhYqlaU0lsB50AhPtSDagp?=
 =?us-ascii?Q?q9aiQiWqjVMqhTxw7cDmDJHVvpAiw8HoQ3dvp4wWn4Ymx4t4tSN9DET8/Pki?=
 =?us-ascii?Q?5VoJiUS8TE+tq5+QdPmCU/VJnHmZYUSLAvi4OpofDkBUljkFeoVWCPTDJi1w?=
 =?us-ascii?Q?sqqj9kN8bMWnTkuiFewrZuzfOHSuDujYv1kqzOePqI7VEXChjBKNdB/YtG3s?=
 =?us-ascii?Q?xCPXRrLth+5moIPMnyvDZF2P3vdlgNucs55ku7LWUI0zDWgQz1D/04ZF4xdJ?=
 =?us-ascii?Q?tSA8gHKHdHml5zVnsaOzAWBy0wd0jCs+JceLoiDiMNux2OJYSg0I0d6RR/mq?=
 =?us-ascii?Q?6VZeIQl59BHWu1LRA7FOZObA+qGZ+8JaitxWbGztmyL7RgFDktSE/il+wFyS?=
 =?us-ascii?Q?C0PHtdIsrmHgXaWh+Y+FTNV/H1pcg4uEeQaD2PhG++3Nb1nopRAo060+z9yq?=
 =?us-ascii?Q?OgV1PsmyvT4IiiA+wbY7fnnhep2As9FqEHwjcU7FaC3SJYJDDUL9LjiXErpB?=
 =?us-ascii?Q?niWOAXrXUhMt1e42EGRoBnxea3swBlu1qKhbczDWMOu9QkVx96raVlxcq8Dy?=
 =?us-ascii?Q?DsZyJTtFZyF38GGKRXbJAN3dVwK2FxxbaE1KEiyOL7xNmKNkcpm+aUR+u5E5?=
 =?us-ascii?Q?VS0vZKTghlyg528F7OhOnReYF9RnFL9akkW0s49EHQhAPA52y7IXe91lUKWz?=
 =?us-ascii?Q?BQ5TQwz/H+Gm4BwNORHkocdKdbYRDFcX7Qmf4HfyAE0NPCFr8fsvxDiFd3mr?=
 =?us-ascii?Q?dfAh0yL+BwuDBf+ghfY41TWpi3GQxkyC8mQz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:30.2211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c20839-d9fd-47bc-e85d-08dd95bb38f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

Add IOMMUFD_OBJ_HW_QUEUE with an iommufd_hw_queue structure, representing
a HW-accelerated queue type of IOMMU's physical queue that can be passed
through to a user space VM for direct hardware control, such as:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer

Introduce an allocator iommufd_hw_queue_alloc(). And add a pair of viommu
ops for iommufd to forward user space ioctls to IOMMU drivers.

Given that the first user of this HW QUEUE (tegra241-cmdqv) will need to
ensure the queue memory to be physically contiguous, add a flag property
in iommufd_viommu_ops and IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA to allow
driver to flag it so that the core will validate the physical pages of a
given guest queue.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 266ac6805213..923c66ccc15a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -38,6 +38,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 	IOMMUFD_OBJ_VEVENTQ,
+	IOMMUFD_OBJ_HW_QUEUE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -133,6 +134,24 @@ struct iommufd_vdevice {
 	u64 id; /* per-vIOMMU virtual ID */
 };
 
+struct iommufd_hw_queue {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	u64 base_addr; /* in guest physical address space */
+	size_t length;
+};
+
+enum iommufd_viommu_flags {
+	/*
+	 * The HW does not go through an address translation table but reads the
+	 * physical address space directly: iommufd core should pin the physical
+	 * pages backing the queue memory that's allocated for the HW QUEUE, and
+	 * ensure those physical pages are contiguous in the physical space.
+	 */
+	IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA = 1 << 0,
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -158,8 +177,18 @@ struct iommufd_vdevice {
  * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
  *                   The memory of the vDEVICE will be free-ed by iommufd core
  *                   after calling this op
+ * @hw_queue_alloc: Allocate a HW QUEUE object for a HW-accelerated queue given
+ *                  the @type (must be defined in include/uapi/linux/iommufd.h)
+ *                  for the @viommu. @index carries the logical HW QUEUE ID per
+ *                  @viommu in a guest VM, for a multi-queue model; @base_addr
+ *                  carries the guest physical base address of the queue memory;
+ *                  @length carries the size of the queue
+ * @hw_queue_destroy: Clean up all driver-specific parts of an iommufd_hw_queue.
+ *                    The memory of the HW QUEUE will be free-ed by iommufd core
+ *                    after calling this op
  */
 struct iommufd_viommu_ops {
+	u32 flags;
 	void (*destroy)(struct iommufd_viommu *viommu);
 	struct iommu_domain *(*alloc_domain_nested)(
 		struct iommufd_viommu *viommu, u32 flags,
@@ -171,6 +200,10 @@ struct iommufd_viommu_ops {
 						 struct device *dev,
 						 u64 virt_id);
 	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
+	struct iommufd_hw_queue *(*hw_queue_alloc)(
+		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
+		unsigned int type, u32 index, u64 base_addr, size_t length);
+	void (*hw_queue_destroy)(struct iommufd_hw_queue *hw_queue);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -312,4 +345,18 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		}                                                              \
 		ret;                                                           \
 	})
+
+#define iommufd_hw_queue_alloc(ucmd, viommu, drv_struct, member)               \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		ret = (drv_struct *)__iommufd_object_alloc_ucmd(               \
+			ucmd, ret, IOMMUFD_OBJ_HW_QUEUE, member.obj);          \
+		if (!IS_ERR(ret)) {                                            \
+			ret->member.viommu = viommu;                           \
+			ret->member.ictx = viommu->ictx;                       \
+		}                                                              \
+		ret;                                                           \
+	})
 #endif
-- 
2.43.0


