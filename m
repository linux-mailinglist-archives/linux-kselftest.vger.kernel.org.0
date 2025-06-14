Return-Path: <linux-kselftest+bounces-34990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2B1AD9ACD
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F5E189DCD3
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2792139B5;
	Sat, 14 Jun 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0OkZyfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54141F4624;
	Sat, 14 Jun 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885344; cv=fail; b=CyOBse7V78kDhGqOuaG8l8Pi4L2CkUJm3Xr07G9TOnXG8WIQo14xHIM4C9OSIMLBLzjtEEXhB0f9iE6+i2tkgyRr0JlDdtkLshFle3JfTZ6uZ0ReDUsPBOrFxYo5K3WaujyvZmthxilreMxdWSmPz2rc/wDoCSzsLR6ugGX1ds8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885344; c=relaxed/simple;
	bh=P+6X57NyMs4o82Lqu9oeClAO5835749LfPrY4uuOoxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSSXUbzIEc4d8RoSkvKM6g6ngrxwKHqO7j6Svx8Akh9m4wqx0+MxyTHArXEIg/5SC5pg6tTgu5Fzk6SC5VXL13NzP2buwnOcIwn4EewDD4HFwjrWRLLTDffKOLeotD3lA69FXh+uaJU8QjsATnMyQsLqNkd/QC/UHiDf7WTX2cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0OkZyfK; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+5e30qm3Ej2p9M0S2eHZL9MXiRMv+DLyxXkOQsXLcNnfw1I2+zzWgbiKowrKIFMgB6h5qzd8btQ/ubFSYeK8H3dTcP00gz8l9HXZ6jEI87egfiRh+pnybs9kZcmYJWac3qqP2Cub2VzxrVoHRJQQLn2x1ikZcZM5eSwQWgpAMu5q+aXtanl0a184yQGuxE/IOg+KW8V6MZNi4mbMULYfEUP7A3p/C6/M/NLN6uOxPptaWIIDasS6jkpKzHsI39l9OCykxASVYsovzPFXBNJB6ZPewOtWVG9bllycqNJqu4Uy6Ig50FRrmJOgCzQFkXR/4Nmk7AI9tFEJ10JfG2UGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OecU0hBtmjIg9hWAB2OUgbUNiEoaVet+tHjpxOZhmVE=;
 b=TeOz5a0HD6/yKobI+5lecstK296DSBaUg0YguTiI4Tz71PVtPEorTIkk2/VV9ZoiA8y1F2GxHA+Lb8V4MMbDWNVbbeBOWAbcbBMCCmnksS2yLPUIwBoB5QmLSCzZ87qVJ+UeCLQS6KmwX2JmGaDn/Ku0hCk3wpx7CcGQb5G9r6uIMGTxpsJmDgHK0INGwH2IoOXJQLd4fEDDnNWrtg9nm8omMsnZAf21Sv5TiN98tDU0W6dJ/Tie/iXcOAkzM7gQnmaP7Udq8XPbVSVnRBXVbuJ7kiRl6+niBwYPDZRI6/qgaDkL8HqddlVRV96Xx1GC3fqdFRz46tyBGX4DS7iIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OecU0hBtmjIg9hWAB2OUgbUNiEoaVet+tHjpxOZhmVE=;
 b=h0OkZyfKrarbDXR2mxD3nI3JT2Uz7Licu8BeIB2sK/tF7P1paZlls9LEjEDDu5DCuNu5bgVI1fkSEYpSosEJyO1G7Mv9OtWt95vU5yvBaN9XceLFUVGVjC9W6l4dbQQSfsxkjDWkwAxhfogCR9n8zgoF8dCTn9d+kr+xJGd1aGYR69/h565NGU0E4o8rRHD+367iMRZyFL2kjNCDYVR3ZvGtHfzFyeta9WP2qPpGjrGPK+fniKzZC20mX6Y451d5y5t90oNOLzfP2ZPAmw8LnO4mX9ry8a1QSGx4Uax/7pk4H11eTDiuDUptM2P5sOaS4IbwdW8woHCABnM4pJoH2w==
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:35 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::9f) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 14 Jun 2025 07:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:18 -0700
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
Subject: [PATCH v6 12/25] iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
Date: Sat, 14 Jun 2025 00:14:37 -0700
Message-ID: <7ccfbb8db3f2ec73f1f81e991a4a4601b0326c14.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 960d95f5-5ecf-4bdf-d718-08ddab1341de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EerVWCxb5jLEj3wUuLzF+ntHThxte6nZLu7H8noPF+xoifzxMPQtjIxtmQRM?=
 =?us-ascii?Q?+GIs3IMl4TyJaNefRhUZ0I0ZSSr/UYV3mxL7cejlUDdnRONxX/1gq/AfJagx?=
 =?us-ascii?Q?FdrPM5MEHbmkG8Jq1CHFOFhGSB5Q/mCHUT9dQP4qtJ0+7BvXhDgP72tZ+ush?=
 =?us-ascii?Q?2jIymRY/oNeT4zVJvka9e4rxgatRx5Q7O/3yQKlXJN1kKlVZm6e1Rgq/z3M+?=
 =?us-ascii?Q?7QD2sWVawoCNn1nID5LutAXp0GZqO8fftYknOiVDXq7sFW1025K0Q4etOXPr?=
 =?us-ascii?Q?ZZzxKEXh4Q4Y+EfuM+e0bw/0ULzv9Fi0SmFai9ga1OE/bOw5dLsPAWtU8fAJ?=
 =?us-ascii?Q?6+mwxslQ1Hc3m/fODa1gvlNOgwtcJZXDGNKtmTpOWiazzSdiXtnW6qu8opCH?=
 =?us-ascii?Q?/eT707d6Bo0xtLKseqygqOi1M4aqmz5mcDU048q2Tvk54ZKb79ojp35achTD?=
 =?us-ascii?Q?ekGFH0PpKnvvozZSqHH3C3km/2ppW8zAr2r9A5Ut3eO6vEnDtmoO7xY/0mAN?=
 =?us-ascii?Q?vJFFVyeqxkK7693VsDjV+aH4qL6VRzCudGWbhmPTUNMyr+qvfJoMq9efI9+G?=
 =?us-ascii?Q?wj+sWtV+91KP+vl8zGyyMtePw88VYF0O3SmzqE4kSvkCu+5nVg6U/nR9eG3i?=
 =?us-ascii?Q?6ST7K7/Kj2Ye1G9fJJmi/bN6bIwlpayTVolZrxTSOU4mJZa9Q3eXFZbNiw65?=
 =?us-ascii?Q?suchip6uiS+HyEVNk2J0v55NgFMQpTShG0uvHUFFgiM6y/ofafwSMDl8POjr?=
 =?us-ascii?Q?am0FeXqE4L8vnPpYYEUDS9aWfNmywo/T+/Go7bWqF1mHaQBB6d1zXr7L92wz?=
 =?us-ascii?Q?1QBcnTz1GU1cGjecZ+bRltA8ObMD/1zK0hW6iGxlJc5F/thJVcamme7Xb+a5?=
 =?us-ascii?Q?fYFiXYjWCXtCE0DCim1iqgtTqahqxj8rmBrqmO18Oi1h70WyPGDxbBJ+uLvY?=
 =?us-ascii?Q?2vvuRoVaEJBKIHqVBDRY86ScgvGBgLJjKhcrzq4tkjwKdyg6T7V83EGx+n5z?=
 =?us-ascii?Q?q5xjyzzcYP/2pZHgDhcc2QAUxw/vxCA5cylnH1FCdw62vx359ezRfH/Aaskh?=
 =?us-ascii?Q?8u8HhfqLgX3t6oN3A7UcKXqfGNkDCQ+SgrwrM/iQr4kklfn/bq1wr6BQqluc?=
 =?us-ascii?Q?O/tLidXegUfIsprL9OBTZ62Ohm6i8qGt/gDcZ5KKva4OUt3OEQo2R9eQiP9q?=
 =?us-ascii?Q?4s1BFF83asfxK2SbjQSd8/i7u+1lNGAjw2KCQVHyGO0D8I6khCt1yDnlCQCE?=
 =?us-ascii?Q?RnoCktOExzdRxK9qqCk+jweWc332EdYuoUP9mRphAjDyIqjGn6Bxeg3ejQeL?=
 =?us-ascii?Q?t0ghgby5+AjH5iMJCzz9LwGHVZKRln1tgqA2yqSA6ek0DyR5ekNxLO8ZUwLY?=
 =?us-ascii?Q?Rw8LulQhyAhnFAhTK6w/ZMWxFX2lHD2LFWXM7oqegQ32iCiHaqOUWFBQ32tV?=
 =?us-ascii?Q?KitKrN7hgVkVtq/s+yfsgCUdpsWYLyLbLMPa8QrAPnp4kJYIy1BlEGG8x9/d?=
 =?us-ascii?Q?AuA6g+Ob04y1FXH5/zMqn6Elw1/BD2uYYRsN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:35.3408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960d95f5-5ecf-4bdf-d718-08ddab1341de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

Some simple tests for IOMMUFD_CMD_HW_QUEUE_ALLOC infrastructure covering
the new iommufd_hw_queue_depend/undepend() helpers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 31 ++++++
 drivers/iommu/iommufd/selftest.c              | 97 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 59 +++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 5 files changed, 196 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index fbf9ecb35a13..51cd744a354f 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -265,4 +265,7 @@ struct iommu_viommu_event_selftest {
 	__u32 virt_id;
 };
 
+#define IOMMU_HW_QUEUE_TYPE_SELFTEST 0xdeadbeef
+#define IOMMU_TEST_HW_QUEUE_MAX 2
+
 #endif
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index a5d4cbd089ba..9a556f99d992 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -956,6 +956,37 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
 
+static int _test_cmd_hw_queue_alloc(int fd, __u32 viommu_id, __u32 type,
+				    __u32 idx, __u64 base_addr, __u64 length,
+				    __u32 *hw_queue_id)
+{
+	struct iommu_hw_queue_alloc cmd = {
+		.size = sizeof(cmd),
+		.viommu_id = viommu_id,
+		.type = type,
+		.index = idx,
+		.nesting_parent_iova = base_addr,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HW_QUEUE_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hw_queue_id)
+		*hw_queue_id = cmd.out_hw_queue_id;
+	return 0;
+}
+
+#define test_cmd_hw_queue_alloc(viommu_id, type, idx, base_addr, len, out_qid) \
+	ASSERT_EQ(0, _test_cmd_hw_queue_alloc(self->fd, viommu_id, type, idx,  \
+					      base_addr, len, out_qid))
+#define test_err_hw_queue_alloc(_errno, viommu_id, type, idx, base_addr, len, \
+				out_qid)                                      \
+	EXPECT_ERRNO(_errno,                                                  \
+		     _test_cmd_hw_queue_alloc(self->fd, viommu_id, type, idx, \
+					      base_addr, len, out_qid))
+
 static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
 				   __u32 *veventq_id, __u32 *veventq_fd)
 {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 6bd1816e0794..3260fde5f920 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -150,6 +150,8 @@ to_mock_nested(struct iommu_domain *domain)
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
+	struct mutex queue_mutex;
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -157,6 +159,19 @@ static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
 	return container_of(viommu, struct mock_viommu, core);
 }
 
+struct mock_hw_queue {
+	struct iommufd_hw_queue core;
+	struct mock_viommu *mock_viommu;
+	struct mock_hw_queue *prev;
+	u16 index;
+};
+
+static inline struct mock_hw_queue *
+to_mock_hw_queue(struct iommufd_hw_queue *hw_queue)
+{
+	return container_of(hw_queue, struct mock_hw_queue, core);
+}
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -669,9 +684,11 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
 }
@@ -763,10 +780,86 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	return rc;
 }
 
+static size_t mock_viommu_get_hw_queue_size(struct iommufd_viommu *viommu,
+					    enum iommu_hw_queue_type queue_type)
+{
+	if (queue_type != IOMMU_HW_QUEUE_TYPE_SELFTEST)
+		return 0;
+	return HW_QUEUE_STRUCT_SIZE(struct mock_hw_queue, core);
+}
+
+static void mock_hw_queue_destroy(struct iommufd_hw_queue *hw_queue)
+{
+	struct mock_hw_queue *mock_hw_queue = to_mock_hw_queue(hw_queue);
+	struct mock_viommu *mock_viommu = mock_hw_queue->mock_viommu;
+
+	mutex_lock(&mock_viommu->queue_mutex);
+	mock_viommu->hw_queue[mock_hw_queue->index] = NULL;
+	if (mock_hw_queue->prev)
+		iommufd_hw_queue_undepend(mock_hw_queue, mock_hw_queue->prev,
+					  core);
+	mutex_unlock(&mock_viommu->queue_mutex);
+}
+
+/* Test iommufd_hw_queue_depend/undepend() */
+static int mock_hw_queue_init_phys(struct iommufd_hw_queue *hw_queue, u32 index,
+				   phys_addr_t base_addr_pa)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(hw_queue->viommu);
+	struct mock_hw_queue *mock_hw_queue = to_mock_hw_queue(hw_queue);
+	struct mock_hw_queue *prev = NULL;
+	int rc = 0;
+
+	if (index >= IOMMU_TEST_HW_QUEUE_MAX)
+		return -EINVAL;
+
+	mutex_lock(&mock_viommu->queue_mutex);
+
+	if (mock_viommu->hw_queue[index]) {
+		rc = -EEXIST;
+		goto unlock;
+	}
+
+	if (index) {
+		prev = mock_viommu->hw_queue[index - 1];
+		if (!prev) {
+			rc = -EIO;
+			goto unlock;
+		}
+	}
+
+	/*
+	 * Test to catch a kernel bug if the core converted the physical address
+	 * incorrectly. Let mock_domain_iova_to_phys() WARN_ON if it fails.
+	 */
+	if (base_addr_pa != iommu_iova_to_phys(&mock_viommu->s2_parent->domain,
+					       hw_queue->base_addr)) {
+		rc = -EFAULT;
+		goto unlock;
+	}
+
+	if (prev) {
+		rc = iommufd_hw_queue_depend(mock_hw_queue, prev, core);
+		if (rc)
+			goto unlock;
+	}
+
+	mock_hw_queue->prev = prev;
+	mock_hw_queue->mock_viommu = mock_viommu;
+	mock_viommu->hw_queue[index] = mock_hw_queue;
+
+	hw_queue->destroy = &mock_hw_queue_destroy;
+unlock:
+	mutex_unlock(&mock_viommu->queue_mutex);
+	return rc;
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
+	.get_hw_queue_size = mock_viommu_get_hw_queue_size,
+	.hw_queue_init_phys = mock_hw_queue_init_phys,
 };
 
 static size_t mock_get_viommu_size(struct device *dev,
@@ -783,6 +876,7 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct iommu_viommu_selftest data;
 	int rc;
 
@@ -800,6 +894,9 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 	}
 
 	refcount_inc(&mock_iommu->users);
+	mutex_init(&mock_viommu->queue_mutex);
+	mock_viommu->s2_parent = to_mock_domain(parent_domain);
+
 	viommu->ops = &mock_viommu_ops;
 	return 0;
 }
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index f22388dfacad..0da72a2388e9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3031,6 +3031,65 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, hw_queue)
+{
+	uint32_t viommu_id = self->viommu_id;
+	__u64 iova = MOCK_APERTURE_START;
+	uint32_t hw_queue_id[2];
+
+	if (viommu_id) {
+		/* Fail IOMMU_HW_QUEUE_TYPE_DEFAULT */
+		test_err_hw_queue_alloc(EOPNOTSUPP, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_DEFAULT, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail queue addr and length */
+		test_err_hw_queue_alloc(EINVAL, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					0, &hw_queue_id[0]);
+		test_err_hw_queue_alloc(EOVERFLOW, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
+					~(uint64_t)0, PAGE_SIZE,
+					&hw_queue_id[0]);
+		/* Fail missing iova */
+		test_err_hw_queue_alloc(ENOENT, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+
+		/* Map iova */
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+
+		/* Fail index=1 and =MAX; must start from index=0 */
+		test_err_hw_queue_alloc(EIO, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 1, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+		test_err_hw_queue_alloc(EINVAL, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					IOMMU_TEST_HW_QUEUE_MAX, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+
+		/* Allocate index=0, declare ownership of the iova */
+		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					0, iova, PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail duplicate */
+		test_err_hw_queue_alloc(EEXIST, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail unmap, due to iova ownership */
+		test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
+
+		/* Allocate index=1 */
+		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					1, iova, PAGE_SIZE, &hw_queue_id[1]);
+		/* Fail to destroy, due to dependency */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, hw_queue_id[0]));
+
+		/* Destroy in descending order */
+		test_ioctl_destroy(hw_queue_id[1]);
+		test_ioctl_destroy(hw_queue_id[0]);
+	}
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f7ccf1822108..41c685bbd252 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -634,6 +634,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
+	uint32_t hw_queue_id;
 	uint32_t vdev_id;
 	__u64 iova;
 
@@ -696,6 +697,11 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
 		return -1;
 
+	if (_test_cmd_hw_queue_alloc(self->fd, viommu_id,
+				     IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+				     PAGE_SIZE, &hw_queue_id))
+		return -1;
+
 	if (_test_ioctl_fault_alloc(self->fd, &fault_id, &fault_fd))
 		return -1;
 	close(fault_fd);
-- 
2.43.0


