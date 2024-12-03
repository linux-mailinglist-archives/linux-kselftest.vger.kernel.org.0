Return-Path: <linux-kselftest+bounces-22783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B09E2F21
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFADB4360A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068120ADCE;
	Tue,  3 Dec 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gCR8vFH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351720A5D4;
	Tue,  3 Dec 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263864; cv=fail; b=KaMUsq/YsDZ9NIhRwd0x//nCevN9xhl24W3cXmNsVntuw3tvBw5WCUDjKOONkRA4UFL9z6TKSljIvWQS5/N0bB7vY4RY8b63fmF1OyHpHVcGMUbmb8N5Va6bj/9YMRFj0DL+RzCcwpXTRgjHgDPa38z1Bi7/NemT2ZVY9UyGQrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263864; c=relaxed/simple;
	bh=HCRB99QAkZ1K7y1148EjmSAEQoBd9W96RAMSUUboBFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoXrisobAYIBBGuHCnzgapenDpXy7AUbKy96rLvtp79AmItOx6yXPd03nevunB0kXJrXXBEwUVYdM2ka2AlnzxJUNK6UXSzm92RHQXALw7p2YoH+QsDwTKbgQGn4yqSfxcPcXEV1wwN1os1o/AGG2+FYLdhj4XUoBRqMuNZY9VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gCR8vFH5; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOPWdwJmBencW9/CAsDxruxIo4ZqKRzqlB8opWP3VcugMhKDnHpmqKYweH5PpAPob6YRlLp6phM+v+3b7spiqjXqEJu4gm/OI73AUTaKa2qUMIFItc6m6Jjni/kePQmArk1voSctbhffKK05ZGVtLaxoj5UUQAmYpkpgAnpCGOIxGQVh9ObGKdayqezJ2S84akVP7ngBf02fantNijt2rn4Aa26CvnjBFwZ935KBSNN494KkvtkCKXcz6T0nmlVCieDrARQQmOVSTCiVdCQ1aRbLTt8KF//1txvBU6AF3S4EpDeZC26KYMAvHsE7Z5FiGLl2/Kast5RTS+ZYc0bqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw2NtZj6iEimVhBoDkU0gUCqYdMiFNJwnKjemaTIpcc=;
 b=c3h14luBGym47H6rIkz/u0DyaLbK2x9M1ClI2z0WkJQNCihm3s57NOuxXth9tm0Ag/OBLtY2vMxV44n/a693uyauQiFom9941BA3LxL5ZTx7W+k0i2w36YihLfHken6uMkwXbmeDjwrx2D2jrhTBYudaJu5C8rrautfD4SLILfn5OtayCtsCM+YQJEeYgvBkNicj2Qb9KtDXwDLUtfjVdUOO5R48oq2nckRXCq8hUgwQGS2SubnIcGnC7IXq9RRxrQGB6GcAWVLzt/CGjMq8SqI3FXNMOzkIkCENoIv98JK83y5P6F7NvL0p4ZauUXgJt+G33T16jlJhKMDgIwsqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw2NtZj6iEimVhBoDkU0gUCqYdMiFNJwnKjemaTIpcc=;
 b=gCR8vFH5bJ6UiCvLExxGUAxU8zrEpG/p0HEjLjq2T3UArJCzz5HjGd/VZoJFGz35in4lTDtOloMX8fgAL5D09QR66MYwyDavouNOjokC0Ggu9ddvaSufBIuavF1G6lLoWULU3WBqlkTdQv+bXdvGdG1kVdfjcK839cwqs49wA4IRddRDJR2g+VjNMMdR4Kht9f4H2bgyDdF9VNninef5Wh9p7W38FARkmj1O4OBxAWUfrV9Zta3MoMlyBHyLKk/Z46muxzHUilIrbpUT02DOQHnViLOcrW9qJ/OTNTf7h8HOd9UfrDUtj+1YbTzZTsP6zECPV5YukV8ZC18YcbtX2g==
Received: from BL1PR13CA0187.namprd13.prod.outlook.com (2603:10b6:208:2be::12)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 22:10:57 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::6f) by BL1PR13CA0187.outlook.office365.com
 (2603:10b6:208:2be::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:10:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:40 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 05/13] iommufd: Add IOMMUFD_OBJ_EVENTQ_VIRQ and IOMMUFD_CMD_VIRQ_ALLOC
Date: Tue, 3 Dec 2024 14:10:10 -0800
Message-ID: <7f5f7adc2493c7bca7edf76ca15b377c8dc0d397.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 82520c3a-470e-427b-ab18-08dd13e75ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFGgXg2xS+AVIV4XsUg/DCdDJuijDiGAU4Jv5M9YR1kyrcf6saZ4+C8XAd5X?=
 =?us-ascii?Q?vAp105UGgl60yzjqk6gD+bhe0U4xge1SjPqqJatX97xeJJjWb5LDt5SkiR5A?=
 =?us-ascii?Q?l6hCOfZgiLtIJ/V+BPL0YrOFY0fV10FtC1nW0PvP8hwtaZRVkiGwGBcFmZc8?=
 =?us-ascii?Q?nYmGPBRkMT4Kk3w/OkrQuXf064Q2mA82Civ0onIyRO1yUFuX4lcqpN1MzrIT?=
 =?us-ascii?Q?3tmiMazjJweWCSkaTgEYaCt1sbepUYTKnJPzh+YJaPhVedRCGbvKdO/hdDkl?=
 =?us-ascii?Q?8cwnMPp7rxzXpcNpSm403YGSwRagZ7t9ZqCixU0hnLW+2kDHTVt3f5zIzdCI?=
 =?us-ascii?Q?B3+ZZNi+taXSX2MxcPy97428W+zH8XAYbr1Wrtwqd01pMKUd257NOW46olNC?=
 =?us-ascii?Q?wxKJwZcFcGkLItjpTgABU4heDpHwlWjG8+DDwQXlVPV0SaitZ7t9fx62PGHl?=
 =?us-ascii?Q?QaXiSVDTH5oNou16e0O1NsNsfnmA4UCeGd0CnMzO+CCrEBFWhSqBWXBGFDFc?=
 =?us-ascii?Q?gT92PqTcQhRxFC1TeHHVUk0mTwp567KMqY9Lhnu76L2ChhC+ZPOPOfYQibYS?=
 =?us-ascii?Q?CPQf39y+PeBNMsvendafGbttmd6kD4uOqA0evCM6Z1gOiiSQCNrba3XbxjWz?=
 =?us-ascii?Q?tnhff2LNsTsAQxB1rAuvfeXMnUX8C0a/yf9A9Y48A8cgPGR7MdSbjnrZvNSB?=
 =?us-ascii?Q?AaoUvR2KlVghRephgyx+fYeAr3CfOleGmB2Z7tS7lGzz4cppyi9kug5EA92A?=
 =?us-ascii?Q?tkFZKUmVpyiFGUa3pcqQkepihWAzyQH9x3K2AXK95A/X00AdKM7lhJIpYb9O?=
 =?us-ascii?Q?C0U+CxfwBdQMSVi4ZgQPiDZ/SJEPkJRDFJPdFIaTvf2maxh+v6bJiZ6MyLNC?=
 =?us-ascii?Q?cmDJDLVwx++I3x4C1BDOirzHKu/DoHYOx3i7v7A+fc2iKuXD7wgHT59Y0ELj?=
 =?us-ascii?Q?xtJI08HEM+FXc7heqbMYxLu6uuxJWCfjdje5GIqnbkBU8BxmT5dpXRnVTpew?=
 =?us-ascii?Q?rQPuPaLyvU0RkporsQP6M+185WladaBBktrUnApcaFEhFmXsvly0B+D8Tps4?=
 =?us-ascii?Q?rAbvbY/nv83V8ieS7k62gDCCze2bzo+eh+kGkLjyI6hVrny3mzZMIKPrNFgl?=
 =?us-ascii?Q?xWBA2bn3cg3WaNObNcUuMF6UyG4JjhDmmYzXN1F9HEJCK2PcDsTNP8UkGS1g?=
 =?us-ascii?Q?GcGEalNHRNgau/RuGNrWyFIqxFHM4giPXl+wpoNaTohJDRWFreeRlBdFHEGe?=
 =?us-ascii?Q?ZZV4Ct4hjN9uJ8BXlMWx2Y6xg7RphxErm1HE7ICaFpQtgC7InpU4q4ON0XSR?=
 =?us-ascii?Q?7b4lCTCtwmSdlxMphjEd9wIJdfT3EQvhbOF8q26X3lo5uzcvNS5/jQOhmquQ?=
 =?us-ascii?Q?djkodFZedVw/hv5KLIAHeH+NQsvyn9jvCbMBpbcrXYYVkfcsGYVjWekwvQOV?=
 =?us-ascii?Q?Hk3voXUqEJuSk6XNob6dyyDp//giNPdO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:10:57.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82520c3a-470e-427b-ab18-08dd13e75ced
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

Allow a vIOMMU object to allocate vIRQ Event Queues, with a condition that
each vIOMMU can only have one single vIRQ event queue per type.

Add iommufd_eventq_virq_alloc with an iommufd_eventq_virq_ops for this new
ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  59 ++++++++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  31 ++++++
 drivers/iommu/iommufd/eventq.c          | 138 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 239 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1c9a101cc435..fd0b87707967 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -548,6 +548,51 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+/*
+ * An iommufd_eventq_virq object represents a queue to deliver vIOMMU interrupts
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with vIOMMU object(s) during the allocations.
+ */
+struct iommufd_eventq_virq {
+	struct iommufd_eventq common;
+	struct iommufd_viommu *viommu;
+	struct workqueue_struct *irq_wq;
+	struct list_head node;
+
+	unsigned int type;
+};
+
+static inline struct iommufd_eventq_virq *
+to_eventq_virq(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_eventq_virq, common);
+}
+
+static inline struct iommufd_eventq_virq *
+iommufd_get_eventq_virq(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_EVENTQ_VIRQ),
+			    struct iommufd_eventq_virq, common.obj);
+}
+
+int iommufd_eventq_virq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_eventq_virq_destroy(struct iommufd_object *obj);
+void iommufd_eventq_virq_abort(struct iommufd_object *obj);
+
+/* An iommufd_virq represents a vIOMMU interrupt in an eventq_virq queue */
+struct iommufd_virq {
+	struct iommufd_eventq_virq *eventq_virq;
+	struct list_head node;
+	ssize_t irq_len;
+	void *irq_data;
+};
+
+static inline int iommufd_eventq_virq_handler(struct iommufd_virq *virq)
+{
+	return iommufd_eventq_notify(&virq->eventq_virq->common, &virq->node);
+}
+
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
@@ -556,6 +601,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_eventq_virq *
+iommufd_viommu_find_eventq_virq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_eventq_virq *eventq_virq, *next;
+
+	lockdep_assert_held(&viommu->virqs_rwsem);
+
+	list_for_each_entry_safe(eventq_virq, next, &viommu->virqs, node) {
+		if (eventq_virq->type == type)
+			return eventq_virq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 7ad105ab8090..40cc9bbb1d24 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -32,6 +32,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_EVENTQ_IOPF,
+	IOMMUFD_OBJ_EVENTQ_VIRQ,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
@@ -93,6 +94,8 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	struct xarray vdevs;
+	struct list_head virqs;
+	struct rw_semaphore virqs_rwsem;
 
 	unsigned int type;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 34810f6ae2b5..d9319f5b7c69 100644
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
+ * @out_fault_fd: The fd of the new virtual IRQ. User space must close the
+ *                successfully returned fd after using it
+ *
+ * Explicitly allocate a virtual IRQ handler for a vIOMMU. A vIOMMU can have
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
index 3674961a45c2..cf07b3c21f1e 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -346,6 +346,75 @@ static const struct iommufd_eventq_ops iommufd_eventq_iopf_ops = {
 	.write = &iommufd_eventq_iopf_fops_write,
 };
 
+/* IOMMUFD_OBJ_EVENTQ_VIRQ Functions */
+
+void iommufd_eventq_virq_abort(struct iommufd_object *obj)
+{
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_eventq_virq *eventq_virq = to_eventq_virq(eventq);
+	struct iommufd_viommu *viommu = eventq_virq->viommu;
+	struct iommufd_virq *virq, *next;
+
+	lockdep_assert_held_write(&viommu->virqs_rwsem);
+
+	list_for_each_entry_safe(virq, next, &eventq->deliver, node) {
+		list_del(&virq->node);
+		kfree(virq);
+	}
+
+	if (eventq_virq->irq_wq)
+		destroy_workqueue(eventq_virq->irq_wq);
+	refcount_dec(&viommu->obj.users);
+	mutex_destroy(&eventq->mutex);
+	list_del(&eventq_virq->node);
+}
+
+void iommufd_eventq_virq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_eventq_virq *eventq_virq =
+		to_eventq_virq(container_of(obj, struct iommufd_eventq, obj));
+
+	down_write(&eventq_virq->viommu->virqs_rwsem);
+	iommufd_eventq_virq_abort(obj);
+	up_write(&eventq_virq->viommu->virqs_rwsem);
+}
+
+static ssize_t iommufd_eventq_virq_fops_read(struct iommufd_eventq *eventq,
+					     char __user *buf, size_t count,
+					     loff_t *ppos)
+{
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	mutex_lock(&eventq->mutex);
+	while (!list_empty(&eventq->deliver) && count > done) {
+		struct iommufd_virq *virq = list_first_entry(
+			&eventq->deliver, struct iommufd_virq, node);
+
+		if (virq->irq_len > count - done)
+			break;
+
+		if (copy_to_user(buf + done, virq->irq_data, virq->irq_len)) {
+			rc = -EFAULT;
+			break;
+		}
+		done += virq->irq_len;
+		list_del(&virq->node);
+		kfree(virq);
+	}
+	mutex_unlock(&eventq->mutex);
+
+	return done == 0 ? rc : done;
+}
+
+static const struct iommufd_eventq_ops iommufd_eventq_virq_ops = {
+	.read = &iommufd_eventq_virq_fops_read,
+};
+
 /* Common Event Queue Functions */
 
 static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user *buf,
@@ -472,3 +541,72 @@ int iommufd_eventq_iopf_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_eventq_virq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_virq_alloc *cmd = ucmd->cmd;
+	struct iommufd_eventq_virq *eventq_virq;
+	struct iommufd_viommu *viommu;
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
+	if (iommufd_viommu_find_eventq_virq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_virqs;
+	}
+
+	eventq_virq = __iommufd_object_alloc(
+		ucmd->ictx, eventq_virq, IOMMUFD_OBJ_EVENTQ_VIRQ, common.obj);
+	if (IS_ERR(eventq_virq)) {
+		rc = PTR_ERR(eventq_virq);
+		goto out_unlock_virqs;
+	}
+
+	eventq_virq->type = cmd->type;
+	eventq_virq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	list_add_tail(&eventq_virq->node, &viommu->virqs);
+
+	fdno = iommufd_eventq_init(&eventq_virq->common, "[iommufd-viommu-irq]",
+				 ucmd->ictx, &iommufd_eventq_virq_ops);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_abort;
+	}
+
+	eventq_virq->irq_wq = alloc_workqueue("viommu_irq/%d", WQ_UNBOUND, 0,
+					      eventq_virq->common.obj.id);
+	if (!eventq_virq->irq_wq) {
+		rc = -ENOMEM;
+		goto out_put_fdno;
+	}
+
+	cmd->out_virq_id = eventq_virq->common.obj.id;
+	cmd->out_virq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+
+	iommufd_object_finalize(ucmd->ictx, &eventq_virq->common.obj);
+	fd_install(fdno, eventq_virq->common.filep);
+	goto out_unlock_virqs;
+
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(eventq_virq->common.filep);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &eventq_virq->common.obj);
+out_unlock_virqs:
+	up_write(&viommu->virqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 539c24ada6d0..89e8ac56f4ce 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -335,6 +335,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_eventq_iopf_alloc,
 		 struct iommu_fault_alloc, out_fault_fd),
+	IOCTL_OP(IOMMU_VIRQ_ALLOC, iommufd_eventq_virq_alloc,
+		 struct iommu_virq_alloc, out_virq_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
@@ -504,6 +506,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_EVENTQ_IOPF] = {
 		.destroy = iommufd_eventq_iopf_destroy,
 	},
+	[IOMMUFD_OBJ_EVENTQ_VIRQ] = {
+		.destroy = iommufd_eventq_virq_destroy,
+		.abort = iommufd_eventq_virq_abort,
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


