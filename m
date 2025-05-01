Return-Path: <linux-kselftest+bounces-32124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D5AA670C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75847B860A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A3D27A934;
	Thu,  1 May 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pphzdq0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDA27A472;
	Thu,  1 May 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140545; cv=fail; b=chap0nT7H8u8twUSi/QqJKoj+E8hzc4R5sAR089kvkzZI2Z2cablzvyqdVs+UHab1QD9pKdLPtJU8FDMsHh4kDpMHuTgkZ/S9lml52E8x3subuibxo6aTsYwsuCvwzfNtJhRjwdU2Qp5wnm1wnN3fG/9OQi3L3Lb+zeJSn/u01Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140545; c=relaxed/simple;
	bh=kvCV7JHbhKP27voT9qJhaysefCRbo6/LziNZ2OiLY00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jELdBT7FXriRLBTx5jl8+7EwZKVHMBbYhuj/y6uMSRqmkdDpr3MNQbxRTo4uEeyQ86LoMV0K/q54yDNphUT3jVXVTHIWWAC/ihvvh8da6e1pvPV3WWQVCSwgUVpdgHtcPtyh+0LhaH0z1rPJ2Zcw29txPTGm/ryD+nENCTHmI68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pphzdq0k; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpZQ5MvS91wdUorfSamj/13Ftc0DEH8NgK9y6SsK1/l38+l7aP9tqTZ912TFoJqcByq8FafRG79UQu6l+gp/vkGfpNQlu4ws3YgAJxgOfKDBktiOid9tWIZvIT0wjem0RsfkVGtFquwJ+KpsQ20+qeFKMgqHo0uFuHkfMdI0ZYscLWBDGIVoIVDKpnflVx1xSoygBUhf+2MKeNZ5EDOGGwu7r3/2E4mLEF+TuVwlxvKxdJ3pgnLkO1GhozqxMQ+np8gZBRpUAzjAmV1aiW4vPBoeL9cixcaQhONHXPDEuxI7xuKwbt7iGOss2J1GzqokQ5X1YTI/QoruQ9/6PQXCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yng9RMRST8TPNoH2JubQlc0nsTCgJtD2WthgNrIvAdo=;
 b=GuHak97JCAm/LBVGUbYAbVYq5/8wbO9GdigX8fBG6Hsf/m+zjR1ZwnwdiRU+WikhwtB++O9gkkALQYV0htmCHL8cnKu21fNLxHoJ6xJkS1VF3qaejzB6ECyfNEnKDB8rpVCQbhIqLk7n2h/0dfUsjDHAwt4+/OdFqof6OCn+GkNrwa5IguItxPw4ShwfKP3M942Qck55Wvq0cRYIzb0q7FfQmbZ4kIOOqlHRSFNHuSPCCWI2y4jgOTkxdl5n6LWGSyu+55oxeERHHqVvK5gXm8qHOj679beuk+r7bc2owa4eZFRQ4QtR87F48WBqMoIWeTUagt021gHPVIWN6apvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yng9RMRST8TPNoH2JubQlc0nsTCgJtD2WthgNrIvAdo=;
 b=pphzdq0kjmnimbQnRDC3ej5Cu8/VtVj/J+N4EGHAozkNtOzZaHwpof+zoEwx8Zm7In1EN7opq4yaMDHbfoLC2BViHjqj4TPmbejjOKisMLBUFJpwyv12xbo3wUfVVrW5a0ptviU79lsKEF0HCdAPKOcNdBEOny3vm6wyQFMVs6EvcyI6vT9oyNCyTGw25uftEFxIVCZsem1TNGVNf/3JSS1HRLnDqgQ4ryrk6dsM2UCuPDnigeLDOAUfzsDl4HVXfnDOhSbsMm5IJj25E3ur9/aUDpDZ1MVusRBMYAtsXdbB36BcNE92moFfhNA6hsAXXrsSTXrp04jVx166XCzbGw==
Received: from SA1P222CA0087.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::20)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 23:02:19 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::f6) by SA1P222CA0087.outlook.office365.com
 (2603:10b6:806:35e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Thu,
 1 May 2025 23:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:03 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 13/23] iommufd/selftest: Add coverage for IOMMUFD_CMD_VQUEUE_ALLOC
Date: Thu, 1 May 2025 16:01:19 -0700
Message-ID: <4010e56fbe89dbc73c3cad2933c46012774a82d8.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c9e143-ce50-4fdf-c408-08dd89043952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEePWOJceMqE9hogP+W1fpaZyBK9CvVUAmig59K0tFgf3ZLC9N07b64dddMR?=
 =?us-ascii?Q?V8SGZtnQZvoQYjlHyeQapCQcE69gfzdrEp1lTjv0tAivQIJbbl16NNIrxkS3?=
 =?us-ascii?Q?yZpRY7rqZcts2fi3yJombhcyD24nNGYuHgU0Q/jZCsVPriwo9/Qa9FKVFese?=
 =?us-ascii?Q?EUayzUF7L/H2mnv+SPNwAlZQ55Pu1hlW/DXOjT4QEHyxmZAv+D121pIyJ7Of?=
 =?us-ascii?Q?UVwXYEr1g0p+uff86wCSlAOCNuMHMz8LcNLcGYbTdZMcbPICvLVvEK6vU4tM?=
 =?us-ascii?Q?VluAePk6QJnY7OQ35iLgyW3M+bgdRohi+zMNhkmNh8+cGqi5gmPLhXob6arE?=
 =?us-ascii?Q?Ivslht0sksgp5QqaGHiBlXoyZCpbevZAGFYISpSup5yC+uxsOc9v4Z6NCI+7?=
 =?us-ascii?Q?64zAk4cj6w8oK9gYLUlTozC8kd56C+zanX3y/MyjSUNFDkd2ove8XeI7zTs9?=
 =?us-ascii?Q?dVbdPwWPQGCMXBx5s4cFtAhPvE5PpG985tCjFLNcRfHptDstjL8KDp06CHP0?=
 =?us-ascii?Q?lPEFnimspvHCKYsDTsyF219BB2uhpcMMTJFzU0QpT80aLv/9rc9O3T9Y37Oo?=
 =?us-ascii?Q?VSveY7noFdWAWykW7iwcGPVQOWPtkim09UnJL1pJBnkIB4ae0jJpgsh8HvBR?=
 =?us-ascii?Q?f7SDT1pIM/tKA4eiEZZGbQws6EWyAsn+ZrFlY+Pe4MQVJZ4XmvF8IZ2Xekv5?=
 =?us-ascii?Q?KZNkABk6ZNRroVLIYqikzXw/hknkvCDuiXXPwGl9ZPbp7LchbaaTgV9DA+ZA?=
 =?us-ascii?Q?+CdHFvwbOEB/k78kanj08oyEw7KArq0bmHyoQbd0a0+bfyeQ/BqZTnNQu9Aq?=
 =?us-ascii?Q?GFLBzt29eCkAZbQNCF45+1Uz/G5JJcn0WA6+iU/IA9buYd076cWAkLMAds4U?=
 =?us-ascii?Q?f93EdQ6XyPCz1+mF1HyJ/wqWEM0DqbubUCBrhAWUIumTOD/r+T2Azdh+nKGH?=
 =?us-ascii?Q?mpVXL/3/QTr+gjpLfRcu3le59Rlg5JIhy+8INDbILCdDjDoAewopatNNMpb+?=
 =?us-ascii?Q?d6kNODRlsuk3BTbnX2q+E7dLe802hM0OZ2xbwMYZFjIxs2fIhYUX1drvnzMS?=
 =?us-ascii?Q?pSvWBRxM5V+cpd2OR8VxJF74RXSvRmDAlnLsZv2C+pofCwJO8QZcgfp3mHxd?=
 =?us-ascii?Q?Nhp0RAqjqYWZZdwrAUnqzysb5fFegdPENkWCOjUncd0XKF8M1IsV7HYMphA4?=
 =?us-ascii?Q?N+bWuZ63x/5vWnReghpy1Jh1NRqDSvOFWvd1eSqmeYWguPW7Q5xItZc+IhqF?=
 =?us-ascii?Q?tmj6nIuBTjFqWqwedCx8SJV3/jZaF0OEJf884XEZFCd4/SKpCFvgwKBYeQ57?=
 =?us-ascii?Q?u51uZUH88NRTm8S812oX/dJAL1ZWJgah6drAWTuOyV4CMp4RIcqu/njEH7lB?=
 =?us-ascii?Q?0cAyQZb88Wp6/mOkWwNld9pQrjVpxEPuE4m7jP1UYSKBuXIhYVKUg2Z9uz5F?=
 =?us-ascii?Q?CwpMO8o5SDzQDTowJf3+JgtZoSCM7MuUPnpAP50M0TpCzS9KATPCSBPfj2wq?=
 =?us-ascii?Q?MQ9lg0aRovSYs2u721SD6au4LM859lvYaPNo?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:18.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c9e143-ce50-4fdf-c408-08dd89043952
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

Some simple tests for IOMMUFD_CMD_VQUEUE_ALLOC infrastructure covering the
new iommufd_vqueue_depend/undepend() helpers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 31 +++++++++
 drivers/iommu/iommufd/selftest.c              | 67 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 59 ++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 5 files changed, 166 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index fbf9ecb35a13..5c5d425243bb 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -265,4 +265,7 @@ struct iommu_viommu_event_selftest {
 	__u32 virt_id;
 };
 
+#define IOMMU_VQUEUE_TYPE_SELFTEST 0xdeadbeef
+#define IOMMU_TEST_VQUEUE_MAX 2
+
 #endif
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index a5d4cbd089ba..f8b52c76a166 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -956,6 +956,37 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
 
+static int _test_cmd_vqueue_alloc(int fd, __u32 viommu_id, __u32 type,
+				  __u32 idx, __u64 addr, __u64 length,
+				  __u32 *vqueue_id)
+{
+	struct iommu_vqueue_alloc cmd = {
+		.size = sizeof(cmd),
+		.viommu_id = viommu_id,
+		.type = type,
+		.index = idx,
+		.addr = addr,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VQUEUE_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (vqueue_id)
+		*vqueue_id = cmd.out_vqueue_id;
+	return 0;
+}
+
+#define test_cmd_vqueue_alloc(viommu_id, type, idx, addr, len, vqueue_id)   \
+	ASSERT_EQ(0, _test_cmd_vqueue_alloc(self->fd, viommu_id, type, idx, \
+					    addr, len, vqueue_id))
+#define test_err_vqueue_alloc(_errno, viommu_id, type, idx, addr, len,      \
+			      vqueue_id)                                    \
+	EXPECT_ERRNO(_errno,                                                \
+		     _test_cmd_vqueue_alloc(self->fd, viommu_id, type, idx, \
+					    addr, len, vqueue_id))
+
 static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
 				   __u32 *veventq_id, __u32 *veventq_fd)
 {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 033345f81df9..58ce1f6e50ba 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -148,6 +148,7 @@ to_mock_nested(struct iommu_domain *domain)
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+	struct mock_vqueue *mock_vqueue[IOMMU_TEST_VQUEUE_MAX];
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -155,6 +156,18 @@ static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
 	return container_of(viommu, struct mock_viommu, core);
 }
 
+struct mock_vqueue {
+	struct iommufd_vqueue core;
+	struct mock_viommu *mock_viommu;
+	struct mock_vqueue *prev;
+	u16 index;
+};
+
+static inline struct mock_vqueue *to_mock_vqueue(struct iommufd_vqueue *vqueue)
+{
+	return container_of(vqueue, struct mock_vqueue, core);
+}
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -727,10 +740,64 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	return rc;
 }
 
+/* Test iommufd_vqueue_depend/undepend() */
+static struct iommufd_vqueue *mock_vqueue_alloc(struct iommufd_viommu *viommu,
+						unsigned int type, u32 index,
+						dma_addr_t addr, size_t length)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
+	struct mock_vqueue *mock_vqueue, *prev = NULL;
+	int rc;
+
+	if (type != IOMMU_VQUEUE_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (index >= IOMMU_TEST_VQUEUE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (mock_viommu->mock_vqueue[index])
+		return ERR_PTR(-EEXIST);
+	if (index) {
+		prev = mock_viommu->mock_vqueue[index - 1];
+		if (!prev)
+			return ERR_PTR(-EIO);
+	}
+
+	mock_vqueue = iommufd_vqueue_alloc(viommu, struct mock_vqueue, core);
+	if (IS_ERR(mock_vqueue))
+		return ERR_CAST(mock_vqueue);
+
+	if (prev) {
+		rc = iommufd_vqueue_depend(mock_vqueue, prev, core);
+		if (rc)
+			goto free_vqueue;
+	}
+	mock_vqueue->prev = prev;
+	mock_vqueue->mock_viommu = mock_viommu;
+	mock_viommu->mock_vqueue[index] = mock_vqueue;
+
+	return &mock_vqueue->core;
+free_vqueue:
+	iommufd_struct_destroy(mock_vqueue, core);
+	return ERR_PTR(rc);
+}
+
+static void mock_vqueue_destroy(struct iommufd_vqueue *vqueue)
+{
+	struct mock_vqueue *mock_vqueue = to_mock_vqueue(vqueue);
+	struct mock_viommu *mock_viommu = mock_vqueue->mock_viommu;
+
+	mock_viommu->mock_vqueue[mock_vqueue->index] = NULL;
+	if (mock_vqueue->prev)
+		iommufd_vqueue_undepend(mock_vqueue, mock_vqueue->prev, core);
+
+	/* iommufd core frees mock_vqueue and vqueue */
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
+	.vqueue_alloc = mock_vqueue_alloc,
+	.vqueue_destroy = mock_vqueue_destroy,
 };
 
 static struct iommufd_viommu *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 666a91d53195..5e81ccafd155 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3031,6 +3031,65 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, vqueue)
+{
+	uint32_t viommu_id = self->viommu_id;
+	__u64 iova = MOCK_APERTURE_START;
+	uint32_t vqueue_id[2];
+
+	if (viommu_id) {
+		/* Fail IOMMU_VQUEUE_TYPE_DEFAULT */
+		test_err_vqueue_alloc(EOPNOTSUPP, viommu_id,
+				      IOMMU_VQUEUE_TYPE_DEFAULT, 0, iova,
+				      PAGE_SIZE, &vqueue_id[0]);
+		/* Fail queue addr and length */
+		test_err_vqueue_alloc(EINVAL, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST, 0, 0,
+				      PAGE_SIZE, &vqueue_id[0]);
+		test_err_vqueue_alloc(EINVAL, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST, 0, iova, 0,
+				      &vqueue_id[0]);
+		test_err_vqueue_alloc(EOVERFLOW, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST, 0,
+				      ~(uint64_t)0, PAGE_SIZE, &vqueue_id[0]);
+		/* Fail missing iova */
+		test_err_vqueue_alloc(ENXIO, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST, 0, iova,
+				      PAGE_SIZE, &vqueue_id[0]);
+
+		/* Map iova */
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+
+		/* Fail index=1 and =MAX; must start from index=0 */
+		test_err_vqueue_alloc(EIO, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST, 1, iova,
+				      PAGE_SIZE, &vqueue_id[0]);
+		test_err_vqueue_alloc(EINVAL, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST,
+				      IOMMU_TEST_VQUEUE_MAX, iova, PAGE_SIZE,
+				      &vqueue_id[0]);
+
+		/* Allocate index=0 */
+		test_cmd_vqueue_alloc(viommu_id, IOMMU_VQUEUE_TYPE_SELFTEST, 0,
+				      iova, PAGE_SIZE, &vqueue_id[0]);
+		/* Fail duplicate */
+		test_err_vqueue_alloc(EEXIST, viommu_id,
+				      IOMMU_VQUEUE_TYPE_SELFTEST, 0, iova,
+				      PAGE_SIZE, &vqueue_id[0]);
+
+		/* Allocate index=1 */
+		test_cmd_vqueue_alloc(viommu_id, IOMMU_VQUEUE_TYPE_SELFTEST, 1,
+				      iova, PAGE_SIZE, &vqueue_id[1]);
+		/* Fail to destroy, due to dependency */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, vqueue_id[0]));
+
+		/* Destroy in descending order */
+		test_ioctl_destroy(vqueue_id[1]);
+		test_ioctl_destroy(vqueue_id[0]);
+	}
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f7ccf1822108..9b0ca43d7829 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -634,6 +634,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
+	uint32_t vqueue_id;
 	uint32_t vdev_id;
 	__u64 iova;
 
@@ -696,6 +697,11 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
 		return -1;
 
+	if (_test_cmd_vqueue_alloc(self->fd, viommu_id,
+				   IOMMU_VQUEUE_TYPE_SELFTEST, 0, iova,
+				   PAGE_SIZE, &vqueue_id))
+		return -1;
+
 	if (_test_ioctl_fault_alloc(self->fd, &fault_id, &fault_fd))
 		return -1;
 	close(fault_fd);
-- 
2.43.0


