Return-Path: <linux-kselftest+bounces-16450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C291961511
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670F2288A62
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991801D6C46;
	Tue, 27 Aug 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2kcGZBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE71D679E;
	Tue, 27 Aug 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778177; cv=fail; b=H5v0b/6RcIirgSDGouEwto157IJDTqOGLTiFLYmQZqY8dphLLWBsJNjtwqiBV/udo2i+06H8FA56lJPXiVvACa2gJtONXarVLDxxk5ZgbKTh4OGLXDBT3Glx4VGvpiGgGmX8K8IK8sCHDn/y2w/IzKHy2PVP9GanBRdtiSUK6OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778177; c=relaxed/simple;
	bh=ei76KASfS+q2DZPwT6fLWG1kg1vwhwsxqn0jC+tCcrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lo+9mR2+HaiinukWV70jtCGY5ojh9EVgC0iBr2DhC99DpLUSBx7PNcWzub2nc2Xz+YClYd9HSwMs8qTxhHl6b8qQSYVY1tHbAqiWPpXPJQIrhsBd5xJMrcquHOAuECa4NBjx2Km57BNBHudQG1B1dHXf0av6n6mPp5dqjbuXs4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L2kcGZBA; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWv215DdRpuqTGMl12cHUvIC4B9vum1S28AN3vQMyON1DgiDhTJLA9GZh/lU6Qra0xs6kZ6ipzlS/9b51gAN8NvbOlJ9lHXn0uvK4If5VcmxyW48PXVeBpE94ySIIWgz7qtj5YYhc6qe97l6Ng4CXL8eG1RdB++3xR0qDhoCtzC4bys1CA42g8hwgOg/d6/52y1l9ODJG7i2sbZG0T2BxD7Ia/cM3Lnh62RyYD+hJvWpgfKImJGP1aSWFW6KZAMManoEq4Get6uTOH1+4hfhzxEjFP+68T6TyhDe8OAP7Zkqm7f9ABYLaEc3gF/wtL2gR1c6yS+M4KYA5t8kJczRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqNoTNQDmPlpgS4R12z/JOVoGPAsGQcRbzQLY45kVFI=;
 b=J0aaF0tvPmzvguiLOduqL2ozJ90OGnbJ3U6VSiM9tkIJL5Dl/ng3CrI+9smr2lbuJx+LslEKeXf0LPmn2lpR3h7lx7Y9izjOD7zRosbtwKqoKd8jwcB4ihXYnDsr8IuAD/MgTsB0z4ESyWn7sucZFmQb0zFHj0wu4kv0liGoLi0oONwwponC8IunUxQAh68OntMDKd7oWVKq6+2pIKLIGbwh/i4Af3U35YZuLXzLdJ1AiPSoSzuwrWmpm0KQ6W5VF+36Wz36/JKssQ/tuGqIjKSXx6UAvAQwYdwGWJidpw+ZfoJeXf03Fsr+RpFd6bJHQuxonn2PfIkiOkaVzVGV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqNoTNQDmPlpgS4R12z/JOVoGPAsGQcRbzQLY45kVFI=;
 b=L2kcGZBAkG9h9IxVkO/lViTr8s4/rOvnYtq9a08NIy6QXQzdOvN+X4M50Qyxwx0nj7i2tWF4m0BOcN5Ql7GJNrFvb705LjTNXj2B0P3yz2f+BJqH31FIof4rZvo2Z6sOLWNpvje+YkEOnnwLAwsDkXEZRJYbmloAidsMp7eVlbpvFvEJ3fwjuSSscghBYcoRptVHFdecVFyQjeYmMwceGPAaaTBQwe9RBzBN0SzWZWCExSq4OiVhNPdfH5kZGGZK1iWQoHh+h55C+oORXKq0r000ww1iMyMZB7NFpmpaO5CnSZULrT7hOPuppT98B8Rz3kHGDQiOhWnZMCQCl1c8Fg==
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 17:02:50 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::c) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 06/10] iommufd/viommu: Add iommufd_viommu_report_irq helper
Date: Tue, 27 Aug 2024 10:02:08 -0700
Message-ID: <d34b6aaec455338932f9d8a4784af646f2f92fb9.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 22aeff60-07be-4c56-6cf1-08dcc6ba1552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FueWfNkpaLTT3oZRfgsg/jb2QAltrWqXkZGeix4+fsZH5qP/hiJDZaTrnIV?=
 =?us-ascii?Q?9L2/ewB9HxreIdu9RQEH+aQy0TapYX8rdP3T92aYL4RxA6xm9nL96ESKhKtN?=
 =?us-ascii?Q?sKc32w6PD03rSrWGi57jBXvYY0NYvmaoDY4SNsj9kkehr/x50oSC9n/1vSbb?=
 =?us-ascii?Q?j0glWAP5oZS2wxJuMQNLRmOFkRPTUOoW0g5Wy7nAOQTpbi1uybflQlG0bmzA?=
 =?us-ascii?Q?EOZq8BVPpc3fTugG21xQRyzf+c7r6fxT+SMXxx61CvOUr584xT1/UhpbOOO9?=
 =?us-ascii?Q?cJWYXj2gFozA+WAP0bqoaD2zwNYFwDdYEFLNSHfXlw1MpZVcWLuABm+wox1/?=
 =?us-ascii?Q?eWRGBsTbxXm0SkoBFXjr6mT0hMsf4gH47sb4pQmM/EYxnf03RfjLfqk+kNmp?=
 =?us-ascii?Q?fglzOHu4/YNJxXNDl0P/9dVo6XIrQ+wB9ER1zN8NddNzRmJveuMDI29sdUsd?=
 =?us-ascii?Q?dHA+lu4KpF/OhNNinpMzViP77w7oAHe74zhmdcxY+fiJ+TVy2Rijc2PI3WHE?=
 =?us-ascii?Q?uNbMr+xzOpechkLI/8SA4/TMU57OBlkG46106+hQPqfr8NM6H1rnysbsXWTk?=
 =?us-ascii?Q?WJjW0xplQ7FBxgiiUcnsD0sEhnskyXIKp9DPLjfAtP/FKj4B24zQl5usNHBu?=
 =?us-ascii?Q?taRXKhdWnXZgEnSSzq3t6jziptAMquxb/jfO7z3wRItBuWKjDbNaxkN+TBTl?=
 =?us-ascii?Q?GfES+HhZbs6oRzm4JPn09iv0nLT+G8em8wNlYZ9rK17mtQWN44CoEYAElu7p?=
 =?us-ascii?Q?A1Lb0AjyhdXtmfBcVnTyc+jg8Ay2YpjquBIS6QJyfyft3+7HWOKIfhs8+8af?=
 =?us-ascii?Q?zEu6McDBEOvY18+gUx2+A3XlFrIYnb8WDKcmzDUv0Gb2i8M1CnFcTm7UHChj?=
 =?us-ascii?Q?Xwg9y3K95PRbXW5ZqLI7VjpNenAJs3m6YP1Orn1Qoow6fElbMe9uzTLhH80U?=
 =?us-ascii?Q?47zBrrZ+wVMIz0ZOV/niwul5R6M3NyzA70NdT4VLspdye7UG/7Rrciv/oRxw?=
 =?us-ascii?Q?s5cpXw/iHRnAHbBahf6FTPQDxSWEB45yf2Uw+nT5TE6obRaZCsDOU/Kz2QRZ?=
 =?us-ascii?Q?vo35FI5mYWoQcnS7tHuT8bCsH/V5RekyKMDcqTkQLrQpN+nlt0cnt10btv7J?=
 =?us-ascii?Q?YRCN6qXPXxMf16K5kXaPDONQZKGuMzy6+h2LxcYUqruUG2Jbppqiaf7beirj?=
 =?us-ascii?Q?2zP+JZPXJHEqK1zS6KnlFISUtC0kpKghY1qXexBo2QvzasUJv/lfVr5z1enU?=
 =?us-ascii?Q?V1aRHl9I1Wb9Q7fsRmkMaofNTXB9BbqD8dZyS8xRNvd4wFuZDixj5eubEhHh?=
 =?us-ascii?Q?6eZO/u6BK1uE6/T0GK6SqKRHZWy4Z4k58CvQL8mmQwGnA7rjVbbD30EJl0gv?=
 =?us-ascii?Q?wHmcIjcqN2JlJW0cLYAQd6Szt1HWdHK4CW7MrAIToaedLhUqrZUFYChxkyEw?=
 =?us-ascii?Q?V94z2Bk3/sSRJfkoIXWOa07bd0eybr+y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:50.2301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22aeff60-07be-4c56-6cf1-08dcc6ba1552
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

This allows IOMMU drivers to report to user space hypervisors IRQs/events
that belong to a viommu.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu_api.c | 40 ++++++++++++++++++++++++++++++
 include/linux/iommufd.h            |  8 ++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
index 82eb33e047cf..d075727a1b38 100644
--- a/drivers/iommu/iommufd/viommu_api.c
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -65,3 +65,43 @@ struct device *iommufd_vdev_id_to_dev(struct iommufd_vdev_id *vdev_id)
 	return vdev_id->idev->dev;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_vdev_id_to_dev, IOMMUFD);
+
+/**
+ * IOMMU drivers can call this helper to report a per-VIOMMU virtual IRQ. Caller
+ * must ensure the lifecycle of the viommu object, likely by passing it from a
+ * vdev_id structure that was set via a set_vdev_id callback and by holding the
+ * same driver-level lock to protect the passed-in vdev_id from any race against
+ * a potential unset_vdev_id callback.
+ */
+void iommufd_viommu_report_irq(struct iommufd_viommu *viommu, unsigned int type,
+			       void *irq_ptr, size_t irq_len)
+{
+	struct iommufd_event_virq *event_virq;
+	struct iommufd_viommu_irq *virq;
+	void *irq_data;
+
+	might_sleep();
+
+	if (!viommu)
+		return;
+
+	down_read(&viommu->virqs_rwsem);
+
+	event_virq = iommufd_viommu_find_event_virq(viommu, type);
+	if (!event_virq)
+		goto out_unlock_vdev_ids;
+
+	virq = kzalloc(sizeof(*virq) + irq_len, GFP_KERNEL);
+	if (!virq)
+		goto out_unlock_vdev_ids;
+	irq_data = (void *)virq + sizeof(*virq);
+	memcpy(irq_data, irq_ptr, irq_len);
+
+	virq->event_virq = event_virq;
+	virq->irq_len = irq_len;
+
+	iommufd_event_virq_handler(virq);
+out_unlock_vdev_ids:
+	up_read(&viommu->virqs_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_irq, IOMMUFD);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 88d6586a424f..346a6257ed0c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -108,6 +108,8 @@ void iommufd_viommu_unlock_vdev_id(struct iommufd_viommu *viommu);
 struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id);
 struct iommu_domain *
 iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu);
+void iommufd_viommu_report_irq(struct iommufd_viommu *viommu, unsigned int type,
+			       void *irq_ptr, size_t irq_len);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -173,5 +175,11 @@ iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
 {
 	return NULL;
 }
+
+static inline void
+iommufd_viommu_report_irq(struct iommufd_viommu *viommu, unsigned int type,
+			  void *irq_ptr, size_t irq_len)
+{
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
-- 
2.43.0


