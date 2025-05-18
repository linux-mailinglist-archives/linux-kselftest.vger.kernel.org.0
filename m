Return-Path: <linux-kselftest+bounces-33273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F4ABAD71
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A91317C3E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295A221D3C6;
	Sun, 18 May 2025 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKNzjS/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B2221D92;
	Sun, 18 May 2025 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538573; cv=fail; b=JJecpvPdfa6+DxyRdKxofXjWA1Mj7BCBnM9dtwlBRFc7QeaRsQFj/d5vRzHHp82bxPu8AFHt99iujkCDqFyf/WS4udxfZ59tMSBXjjlaUNDM/FY4drFnesdvOhIG092wUkdexwqVQox36SUOFIPA28KSNmNaN6uUgVHtkXQwrEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538573; c=relaxed/simple;
	bh=J1l93UY3oyvNl5K/nIEGMCQdYQNWaLtykTssbsLZHOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcBg4hwNT1k16AY/fgaFoJvzLLVZ01APx2WMjowGETYpEGq+VFVRAU3XG8L9/nZbc+IN0QfQPBR3hMMmr0pX56/TQ8qL+XESzaTPKiDUiN34VpO7RRc8gOta0wuiUSyH/zRlISiMOnMyqbkcqOssEuJzXLXSILJjmQZChD7vMn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKNzjS/2; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeV4wlgAcstX5KJlQFizi0CDimVyidL6/b9QBynySAyLM0d7poeugKKISalXBjvzFwpa9mum5WTparXUqUypC19SAvCkiD+eBLYZX6QXoimpPuEDk6SZ38HviMF0Gy12CV829BFSuN2PDbKXDZUCXuc61kW8vIojCD9wpxMxU7QkCkech5umMnyXngRCX7cNSi6iLEfgT1Nvih/4AZvcFDfCTGP1MZE30UEZ8jvskzxwP+m20N6dOl5Yl7x3CPujDw7HL2b93UuikNqrfHTA+7vZiPvZHzZ3S0cYs27F7LHb+FJJnuiMuUsz24Yy5qoOU7N28qoQmmZa0LEaMYqyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfuSCPAFipnNiIKPqrIeNdMBqGD3KuZfFkoxsL/jVm8=;
 b=LxbM6XcP92KAbDGlhUUlfVGNejtBDUpECnzDlh1fPcOkSt9C78R+sg55XvgnhfGMh35Nzm1CSYjuuWZPNu/VpCeMUxhGOln1qzr1JjxIjjTexGCvanEPesAJk5NVDWhOldGZLytE2yfsGBCupU9lhoVTsgNh9sP9nlFMOM7OCAO3pbaz/7BeegfrtyAUrOvDEzK0m5utDrPAc3UvZTCM5JNuuviUKWaQ/sQWs4vQmG1NCzKGoI7uYSqD2oFIkR/BwkSkMxFg3/28JQMH2AEJwzAJKg7oLk7lF9VXPyMjUDa4PDNtp7Cg6m2WToO9uxEKepqLQTL0MpIvd83uRyXMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfuSCPAFipnNiIKPqrIeNdMBqGD3KuZfFkoxsL/jVm8=;
 b=iKNzjS/2E1vlspAyV/2uRuBLcOdpHJrUcq1f1w4EkGc625Y+jQxNgqLdy0IsJWrJBcP4IuxArWR24pimbB/msyvzvxHtLyvHhhKDKhL+ylVW8pW8BCtxr0OZZWGvoFWIuQmDkKcqP24h5VRaDy05XhCaKNMtcMuBFagb0V1g5p+OVdbmWyIvD4ZqhZMRjy0yjRClxjkP8+thDMPV7mjQrFW1ZvR+kHOwpmN9dBrq6C5chU91zGMz1eTNr8wKBXnQxopkY6lk5ucJRyJ67MYCPbdUq1k0Re+RVkiAUJRfd7N6SdAEVtEuoDTHfiPtvdzGAKhtDbAFX9CVk17W9meSYA==
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:44 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f5) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:23 -0700
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
Subject: [PATCH v5 16/29] iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
Date: Sat, 17 May 2025 20:21:33 -0700
Message-ID: <d0a1b4a21043aabe75242a0f8a9ab78b47b49edb.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb569e9-64d7-40fc-7c9d-08dd95bb4120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1XhMjjvLrTocKnMnBirMnScjDA5dPzPx/hLMoXmNJwjhzcftQ7uhPipAzwu?=
 =?us-ascii?Q?UWGZuWVy0FMOmV+ftULUGIrmE+GruWfh6dzRGN9h1ZpHEip5dHYcPdNqvtcR?=
 =?us-ascii?Q?dAK08OuXl+KudwqvQFnwoFTqPYfw0N+cll4JuuKlntdhc2fMX5YPMQmtzTn9?=
 =?us-ascii?Q?JN5Cw1D+GtEDaPAotGvRgd3ZO00jumWPGI0EDCZNp5bcNd845kK0p8s8Hwn5?=
 =?us-ascii?Q?jqdXjZ0yy9bcjA5IrWIUZ2QpyL8VVhiW2UPLypMt6jxEBoOfgCVck2xF5mdW?=
 =?us-ascii?Q?5etF3QVxvNZZVBKB6G6lZ37QEX7OeVAMcaMr2prFY51HzBp+BGrKW/77cRL/?=
 =?us-ascii?Q?4pDyY84z4QXiQJ5HMQ6yQwl8NthkZ1B4XwGgvY/SMzUtH0clYy6E8iUk8m80?=
 =?us-ascii?Q?EehqxMLKHmEtg42xxqyPRDFKgSTkryb/opxWvuZRPHRJPofL5fgFzOSugHTp?=
 =?us-ascii?Q?YhknSoDIepAGfwqxjsj2gzfhJIKp1aawq0e3qM4wZhkYZimgxFwKGAtti2Pn?=
 =?us-ascii?Q?dCAC9TrL+36/I5/7ERLeRM7xupFtZbrgjwqsphbpQJcDxKZuvzg7TErfVmC3?=
 =?us-ascii?Q?oVIOwoW1JUylbOOaIAIQ/zELZ9BqUye1pV97KJcIKPzxQ6KbVn9MLUNDRa5J?=
 =?us-ascii?Q?p2oAaYb+JWhJxKONP6XPMbOMLQrnZBVYkuIJAr4VSnh1qjefw6c1cxeUo9GZ?=
 =?us-ascii?Q?uBuL456EEDRcreXxecu2SPEqi6MHPrpYhrdyG3veJshSviFe1K6bLuqvGVtA?=
 =?us-ascii?Q?scY5QfyQ4IjD0xVCQqN4d6EDdud0GDanE9hgYOCEz1q5t0djJ9IexAvNFWdd?=
 =?us-ascii?Q?9DxPHuODkq5Z7tQw7qNnQVF1Za2dCusMpGyN64bPMvAaF0qHgZkUui6T0eo0?=
 =?us-ascii?Q?7OpTI6BG3918RDJRTfaIYTwqpvzVh2Rgl7jGJSNKdunSnXnMCu9h2U7dOJt9?=
 =?us-ascii?Q?8Q6k4hFcFivCFphhgtjHpXdoC43uxuXJhKIuz7L1DrsxNMx4bCKw3pn1tO8Z?=
 =?us-ascii?Q?qvcSdSxMNQhusJ2WPbYSwx9BvU8pL7JWLSKZDpiYWl8Grpe3S0JDK3jZt1Qd?=
 =?us-ascii?Q?UhmedX48lyJxCN2rZvEXCYbx/nXMZY8vw/Ckbo+qlrt8FPJDuNNIpXZKIRcj?=
 =?us-ascii?Q?w+XldOJcdtKe8HFXNkR4NiTejAs/Ne5dRhhJYS8o5gY1pOPRpogmqq308+re?=
 =?us-ascii?Q?2qjwicdxR6yRDCGY4WhbM+Rk1ACwKiQXCmeURrXNB21O3vG0OoC/5viqsDjf?=
 =?us-ascii?Q?HtLDjxnfCt8k44uV6c7JZK0+Suy8ERw8j/Phs8pFfurJPuY6YfSSK9SBWVOg?=
 =?us-ascii?Q?SMatws+SxEjezTghmeFErP8xwkN8lCwlHwmd/TL3w5xPj2kWMImkP3Em1IQA?=
 =?us-ascii?Q?O5Li9q9ZHbJxrhPYxFkS1GmDY90xn1QN+chIycrExe3FUSsUR49jHxVWRBCv?=
 =?us-ascii?Q?tJnUPrlu58TOf8GZ9Z3nCBz2ptcXP97QdHLlx1fKDrPpFgCJxlDOm6Ts2wxW?=
 =?us-ascii?Q?S3fKCH9Vh7g9saGf9aO6C3nOiubWYWNpQJlc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:43.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb569e9-64d7-40fc-7c9d-08dd95bb4120
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

Some simple tests for IOMMUFD_CMD_HW_QUEUE_ALLOC infrastructure covering
the new iommufd_hw_queue_depend/undepend() helpers.

Since the iommufd_hw_queue_alloc_ioctl() will call iommu_iova_to_phys(),
for input address validation. It might intentionally pass in a bad input
for a negative test. So drop the WARN_ON() in mock_domain_iova_to_phys().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 31 ++++++++
 drivers/iommu/iommufd/selftest.c              | 71 ++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 62 ++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 5 files changed, 172 insertions(+), 1 deletion(-)

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
index ea2e4c626ad5..eca1a66fefed 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -148,6 +148,7 @@ to_mock_nested(struct iommu_domain *domain)
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -155,6 +156,19 @@ static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
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
@@ -570,7 +584,8 @@ static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
 
 	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
 	ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-	WARN_ON(!ent);
+	if (!ent)
+		return 0;
 	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
 }
 
@@ -727,10 +742,64 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	return rc;
 }
 
+/* Test iommufd_hw_queue_depend/undepend() */
+static struct iommufd_hw_queue *
+mock_hw_queue_alloc(struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
+		    unsigned int type, u32 index, u64 base_addr, size_t length)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
+	struct mock_hw_queue *mock_hw_queue, *prev = NULL;
+	int rc;
+
+	if (type != IOMMU_HW_QUEUE_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (index >= IOMMU_TEST_HW_QUEUE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (mock_viommu->hw_queue[index])
+		return ERR_PTR(-EEXIST);
+	if (index) {
+		prev = mock_viommu->hw_queue[index - 1];
+		if (!prev)
+			return ERR_PTR(-EIO);
+	}
+
+	mock_hw_queue = iommufd_hw_queue_alloc(ucmd, viommu,
+					       struct mock_hw_queue, core);
+	if (IS_ERR(mock_hw_queue))
+		return ERR_CAST(mock_hw_queue);
+
+	if (prev) {
+		rc = iommufd_hw_queue_depend(mock_hw_queue, prev, core);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+	mock_hw_queue->prev = prev;
+	mock_hw_queue->mock_viommu = mock_viommu;
+	mock_viommu->hw_queue[index] = mock_hw_queue;
+
+	return &mock_hw_queue->core;
+}
+
+static void mock_hw_queue_destroy(struct iommufd_hw_queue *hw_queue)
+{
+	struct mock_hw_queue *mock_hw_queue = to_mock_hw_queue(hw_queue);
+	struct mock_viommu *mock_viommu = mock_hw_queue->mock_viommu;
+
+	mock_viommu->hw_queue[mock_hw_queue->index] = NULL;
+	if (mock_hw_queue->prev)
+		iommufd_hw_queue_undepend(mock_hw_queue, mock_hw_queue->prev,
+					  core);
+
+	/* iommufd core frees mock_hw_queue and hw_queue */
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
+	.flags = IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA,
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
+	.hw_queue_alloc = mock_hw_queue_alloc,
+	.hw_queue_destroy = mock_hw_queue_destroy,
 };
 
 static struct iommufd_viommu *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index f22388dfacad..fabec1b551c6 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3031,6 +3031,68 @@ TEST_F(iommufd_viommu, vdevice_cache)
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
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, 0,
+					PAGE_SIZE, &hw_queue_id[0]);
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


