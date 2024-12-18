Return-Path: <linux-kselftest+bounces-23484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCACF9F5E11
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222FA166761
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18628157A72;
	Wed, 18 Dec 2024 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WQuYpMHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F3156677;
	Wed, 18 Dec 2024 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498109; cv=fail; b=H99m34iL8tPSwBre9ibSyb2nHa3WXqM/dbBCa/7OVTzthY3Rix9dkM/BbOH3yLVTbfSE5dugRjdzjgJS2T6hzo7jtXd4c2n75OCnESohlyV4OhZzbgBSIa1692DCYYFX2QRFPdCTQDLbwJjEkO3LUjCmmytKPrVthkAIlKcg3dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498109; c=relaxed/simple;
	bh=k+hU8VowibDqh80DmOoUoFRHkC/Fr17xmj2DnZ0vwwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjNb5rGVghU4bqEEISD/GHKqgK6LheLypB/Q9/NQsMSAMXLTyMVpwxW9hhjT8SN3mJsVhrCEBjuWlxBeWMB1WM0mCm+YmZ5Cau1eAFvsTozFkUT/hy6aQYRpFYGxhp8bPfVcXcIxetPe7RA/mFMp2oPS8rNOEId1UXUTqnSCzMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WQuYpMHl; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0Zb79EoVMkABMf+D5Eva4YUOuGcM3iOOD82s9tVgPfnSoBO0npFc8z3VD/E1bg+iz6j9ru5hulbCoVrmhLPydHvI04eLMpkDm05mlvHr6Pw2EpvHsOLJP/Qj60d10GcRqITUepYugemcWBu/UktzAayHHmoEgy2BBYpK4uDP1uWer4XxJPToMgIUK3kiAqLb59qNyl1aKHHX4o093pQ1NPPMDl7qZpcXwO3EpqGvSMDmgJ3WR1OgRIrZAy+C/KWNdmLu7tVQYgasdv39IlS5TQ8XDL07JjYkrek7pZIXyUPDCkNOrEyAsH4GUZNSl/QRaZTJi90ASuyB5Wngr/2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA/USBIswKivPJoyrLoes1ILT0s67ea3m+VK6I1p650=;
 b=ZXdyjAwf49Qq68HWTsnK3O8Caa4QopfS2LqM5NJKElkGDK2zhLlrE/5fh8nqSNqCWWjX3JH/i2TNLtobJ/Fa6A74oYf9DE3MKbBDgh8EkRX1/1Akvx3ORt26nqktOpx13iEif8XiyhRCVVz8RtReVKzdrbLWJuJPfuJhNBqxGD0wDJIeQAs9H3eLjZu9YwhUVn/4hfhrpfOlzzs4XUG75bWHdxPnkhCX5QdFxRDPM+2TsHTjCALK3A1MA53KNvH4ankDNcXn5KwDdaf92vAxksEosUuECHOeHvlcLIKfDf3zPvQa6vfwlJt9mBzbj4YvFGFdWTcLUhHIiq5TBkJ7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA/USBIswKivPJoyrLoes1ILT0s67ea3m+VK6I1p650=;
 b=WQuYpMHlkR8jvNsdlEfE9gV7GmXFolKyZw5cbTbnZqZh8aYqXjVxIcC5p2xxy68T/ZYqiwergjkBk+Pyh3b0UINBIVWL/LYZh2+CW2iuWQYvVPvyAOrFNrh6W619CY2+K8Q9ddtHn9zAISH2kTD5n4tMKCgqbpCrUevLNMkqLmtHtIC17WfTFQcbeuZ2bLIrEQou5OWMyLOwh5dKsFQ5pCLSuDQtqiXUj7SwuC7oDXwemH6PKWpSFKw//T88q6nqjFDcJE3BaU3AeKKU3nTqJieFp6IfOxMMOMVhocZybLSDhNKn29kx8VsPZAoEliFFyeZwUrTIfC2ACN2NXFzc7g==
Received: from CH3P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::12)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 05:01:43 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::65) by CH3P220CA0013.outlook.office365.com
 (2603:10b6:610:1e8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 05:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:30 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:29 -0800
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
Subject: [PATCH v3 06/14] iommufd: Add IOMMUFD_OBJ_VIRQ and IOMMUFD_CMD_VIRQ_ALLOC
Date: Tue, 17 Dec 2024 21:00:19 -0800
Message-ID: <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4be66a-6770-481f-21e4-08dd1f211067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPFKlAZ7uDv2Dr4CSvjGvqNtsVE5GnaocftY30li3oiqYvPEJZyUkbxkdOOn?=
 =?us-ascii?Q?Afr/flhTdW7Jhqctll6EBhWtgLQ57kKwj8JXY9jaKCJFFzn8ebCAD9ZkiyEh?=
 =?us-ascii?Q?/r7nL1Qyc9KAsUMiUqy77iB/ggfSgdroFCCnsJpFzw9bdcjI9ZP14QqRs+9V?=
 =?us-ascii?Q?N8fY1yEA8XF3xo5/tIz88/kHTTvF70DFItKNupyIm3hwn+6DAG3iJdYFzHDp?=
 =?us-ascii?Q?nvNwTlgSL6CSE7TBLvlHkLp+0l1KE9kqwssUaXK2WNEIRCbqUMaU6Kfeavjt?=
 =?us-ascii?Q?fPamDHlyHK7MBsALzIm4veIA6tMryTaidwifLFIIKHPJdTbqM3dY24epS2CE?=
 =?us-ascii?Q?Wfm+/OiPeT8d5ZyiixnPlmtHfTTt4xXlvPpCes3Z3Z5szrYYB5qYAbEkG9X+?=
 =?us-ascii?Q?c6XJg+7A99kkX8VWB3Y0CdHwrOkcKlaj3+hUoCikded0NhDJh/NSrQm00Whf?=
 =?us-ascii?Q?7Kd+qy1TJp2F+553/tLGDZUUMbRkNCH7kzeX2px6eJsC86SpkU1yEULqaZdW?=
 =?us-ascii?Q?6b0LNYPS5mWbwUtZHFtGaJnRiZHVwaSW/rhDYbYqAU/JhMpHiPjEw9+V35G6?=
 =?us-ascii?Q?BsvyxN3PTvT2E8HNUnxbixgUSZ3dPTHXcQyZRQK1EGD3sZCUkZrBSu9lXGS6?=
 =?us-ascii?Q?5deunZuhXKg1gx0f6QRCTwp/n/yB+yuHM/8/ITsA1PO1DtKxV81d7L8C150q?=
 =?us-ascii?Q?+1N7OYEAhE1h5N09SFIP+pz/8SXp2kJkE8GOEe0twMRtKgpB6DGbIaiZ9CaC?=
 =?us-ascii?Q?+i1e08mv4TBLIDOV0M7QhvQxUwpUUPzh3o8qxW8a0SEDUm6sVEbe5tBcqw6/?=
 =?us-ascii?Q?bvD2Xy72cXBny6CvQ5Q04BMCR/LQW0aIu2pKZkHreySipKfA9JsB8oFTanJv?=
 =?us-ascii?Q?yelbrKTqbfFKF0D5HdZtrn6d6kpHzZe0cZ+eJ78K57jdV9Qjvl3shM4+TtM/?=
 =?us-ascii?Q?qEb72CNQxkusnp3rjlRdItbgYbnTSQLYw1PrQO2HQyh8qoNQAbs3CbN4oWji?=
 =?us-ascii?Q?dLbLrT20V2aEomeUUQmV4LyD2vqIFiZefpDKOAVEv9MuSBWxpCgRiSmmkBGq?=
 =?us-ascii?Q?svQ68HCiw3JMEy5ZwlSFLBm1iEwujoo5rC+lFiqZKRV032Q9Tr9+9lV4ZF0e?=
 =?us-ascii?Q?/jEnXz45KB+oIvHv0VmgISwZf1vUP7fIl5kPYFm9gQHjKzzS4iQLGtKxChcj?=
 =?us-ascii?Q?RVE4+UxrVpYc+cVjMFeBsB5z72+oY25xnDaaWegP4/Np9pYbE938/+1CwAuL?=
 =?us-ascii?Q?/ZLRVVIylDlCxaT76v35H+80hjgHulBPSjjRq0omohVW04WauSxrT7nybwGf?=
 =?us-ascii?Q?AOjBygfDSuMvhSp2wHd9GJpbxcSnDkmi760ks/2ewE4l02v4VjLJSMqh4Rt6?=
 =?us-ascii?Q?KucjmtD5DnTAAXK2579gQJ4D1CDN826NR8MLOhNReQjux2sKVyqbMPFmUCRR?=
 =?us-ascii?Q?GjnJoUej2LRw+k2CVDeH6n2woplHxHMHdMuXcqt3SzC0daz508SwZ7Bie3r6?=
 =?us-ascii?Q?WGs1myFZ6vX3AUM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:42.4648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4be66a-6770-481f-21e4-08dd1f211067
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736

Allow a vIOMMU object to allocate vIRQ Event Queues, with a condition that
each vIOMMU can only have one single vIRQ event queue per type.

Add iommufd_eventq_virq_alloc with an iommufd_eventq_virq_ops for this new
ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  57 +++++++++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  31 ++++++
 drivers/iommu/iommufd/eventq.c          | 129 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 228 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dfbc5cfbd164..fab3b21ac687 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -547,6 +547,49 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+/*
+ * An iommufd_virq object represents an interface to deliver vIOMMU interrupts
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with vIOMMU object(s) during the allocations.
+ */
+struct iommufd_virq {
+	struct iommufd_eventq common;
+	struct iommufd_viommu *viommu;
+	struct list_head node;
+
+	unsigned int type;
+};
+
+static inline struct iommufd_virq *eventq_to_virq(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_virq, common);
+}
+
+static inline struct iommufd_virq *iommufd_get_virq(struct iommufd_ucmd *ucmd,
+						    u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIRQ),
+			    struct iommufd_virq, common.obj);
+}
+
+int iommufd_virq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_virq_destroy(struct iommufd_object *obj);
+void iommufd_virq_abort(struct iommufd_object *obj);
+
+/* An iommufd_virq_header packs a vIOMMU interrupt in an iommufd_virq queue */
+struct iommufd_virq_header {
+	struct list_head node;
+	ssize_t irq_len;
+	void *irq_data;
+};
+
+static inline int iommufd_virq_handler(struct iommufd_virq *virq,
+				       struct iommufd_virq_header *virq_header)
+{
+	return iommufd_eventq_notify(&virq->common, &virq_header->node);
+}
+
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
@@ -555,6 +598,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_virq *
+iommufd_viommu_find_virq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_virq *virq, *next;
+
+	lockdep_assert_held(&viommu->virqs_rwsem);
+
+	list_for_each_entry_safe(virq, next, &viommu->virqs, node) {
+		if (virq->type == type)
+			return virq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..b082676c9e43 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -34,6 +34,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
+	IOMMUFD_OBJ_VIRQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -93,6 +94,8 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	struct xarray vdevs;
+	struct list_head virqs;
+	struct rw_semaphore virqs_rwsem;
 
 	unsigned int type;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 34810f6ae2b5..cdf2dba28d4a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -55,6 +55,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VIRQ_ALLOC = 0x93,
 };
 
 /**
@@ -1012,4 +1013,34 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+/**
+ * enum iommu_virq_type - Virtual IRQ Type
+ * @IOMMU_VIRQ_TYPE_NONE: INVALID type
+ */
+enum iommu_virq_type {
+	IOMMU_VIRQ_TYPE_NONE = 0,
+};
+
+/**
+ * struct iommu_virq_alloc - ioctl(IOMMU_VIRQ_ALLOC)
+ * @size: sizeof(struct iommu_virq_alloc)
+ * @flags: Must be 0
+ * @viommu: virtual IOMMU ID to associate the virtual IRQ with
+ * @type: Type of the virtual IRQ. Must be defined in enum iommu_virq_type
+ * @out_virq_id: The ID of the new virtual IRQ
+ * @out_virq_fd: The fd of the new virtual IRQ. User space must close the
+ *               successfully returned fd after using it
+ *
+ * Explicitly allocate a virtual IRQ interface for a vIOMMU. A vIOMMU can have
+ * multiple FDs for different @type, but is confined to one FD per @type.
+ */
+struct iommu_virq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 out_virq_id;
+	__u32 out_virq_fd;
+};
+#define IOMMU_VIRQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIRQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index e386b6c3e6ab..a8921c745d36 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -346,6 +346,73 @@ static const struct iommufd_eventq_ops iommufd_fault_ops = {
 	.write = &iommufd_fault_fops_write,
 };
 
+/* IOMMUFD_OBJ_VIRQ Functions */
+
+void iommufd_virq_abort(struct iommufd_object *obj)
+{
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_virq *virq = eventq_to_virq(eventq);
+	struct iommufd_viommu *viommu = virq->viommu;
+	struct iommufd_virq_header *cur, *next;
+
+	lockdep_assert_held_write(&viommu->virqs_rwsem);
+
+	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
+		list_del(&cur->node);
+		kfree(cur);
+	}
+
+	refcount_dec(&viommu->obj.users);
+	mutex_destroy(&eventq->mutex);
+	list_del(&virq->node);
+}
+
+void iommufd_virq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_virq *virq =
+		eventq_to_virq(container_of(obj, struct iommufd_eventq, obj));
+
+	down_write(&virq->viommu->virqs_rwsem);
+	iommufd_virq_abort(obj);
+	up_write(&virq->viommu->virqs_rwsem);
+}
+
+static ssize_t iommufd_virq_fops_read(struct iommufd_eventq *eventq,
+				      char __user *buf, size_t count,
+				      loff_t *ppos)
+{
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	mutex_lock(&eventq->mutex);
+	while (!list_empty(&eventq->deliver) && count > done) {
+		struct iommufd_virq_header *cur = list_first_entry(
+			&eventq->deliver, struct iommufd_virq_header, node);
+
+		if (cur->irq_len > count - done)
+			break;
+
+		if (copy_to_user(buf + done, cur->irq_data, cur->irq_len)) {
+			rc = -EFAULT;
+			break;
+		}
+		done += cur->irq_len;
+		list_del(&cur->node);
+		kfree(cur);
+	}
+	mutex_unlock(&eventq->mutex);
+
+	return done == 0 ? rc : done;
+}
+
+static const struct iommufd_eventq_ops iommufd_virq_ops = {
+	.read = &iommufd_virq_fops_read,
+};
+
 /* Common Event Queue Functions */
 
 static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user *buf,
@@ -473,3 +540,65 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_virq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_virq_alloc *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu;
+	struct iommufd_virq *virq;
+	int fdno;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VIRQ_TYPE_NONE)
+		return -EOPNOTSUPP;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+	down_write(&viommu->virqs_rwsem);
+
+	if (iommufd_viommu_find_virq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_virqs;
+	}
+
+	virq = __iommufd_object_alloc(ucmd->ictx, virq, IOMMUFD_OBJ_VIRQ,
+				      common.obj);
+	if (IS_ERR(virq)) {
+		rc = PTR_ERR(virq);
+		goto out_unlock_virqs;
+	}
+
+	virq->type = cmd->type;
+	virq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	list_add_tail(&virq->node, &viommu->virqs);
+
+	fdno = iommufd_eventq_init(&virq->common, "[iommufd-viommu-irq]",
+				   ucmd->ictx, &iommufd_virq_ops);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_abort;
+	}
+
+	cmd->out_virq_id = virq->common.obj.id;
+	cmd->out_virq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+
+	iommufd_object_finalize(ucmd->ictx, &virq->common.obj);
+	fd_install(fdno, virq->common.filep);
+	goto out_unlock_virqs;
+
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(virq->common.filep);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &virq->common.obj);
+out_unlock_virqs:
+	up_write(&viommu->virqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index cfbdf7b0e3c1..9d15978ef882 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -367,6 +367,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VIRQ_ALLOC, iommufd_virq_alloc, struct iommu_virq_alloc,
+		 out_virq_fd),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -502,6 +504,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_VIRQ] = {
+		.destroy = iommufd_virq_destroy,
+		.abort = iommufd_virq_abort,
+	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 69b88e8c7c26..075b6aed79bc 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -59,6 +59,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
+	INIT_LIST_HEAD(&viommu->virqs);
+	init_rwsem(&viommu->virqs_rwsem);
 	/*
 	 * It is the most likely case that a physical IOMMU is unpluggable. A
 	 * pluggable IOMMU instance (if exists) is responsible for refcounting
-- 
2.43.0


