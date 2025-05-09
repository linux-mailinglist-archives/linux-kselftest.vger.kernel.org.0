Return-Path: <linux-kselftest+bounces-32711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E866AB0862
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3ED750769A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD1246796;
	Fri,  9 May 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="op1+KiBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE42459FA;
	Fri,  9 May 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759826; cv=fail; b=KSzgDdwlcKjg/BuFiAQU86hRtLY4JbYJgZr/FYYIuWiSFv8qwVpKH/N0l/tDok1yclgfvdvPUhyZksQsK1aePECEtHRGtPRin4bH1qH1JqUUJTrumjS99C0XiscjeolUahwTqjDaxONaPgqEikMGWjWZ7j00VWTrFLrH4eqqhGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759826; c=relaxed/simple;
	bh=vymrp6oiLPadhtEQvQtDzeizMfVUU2lGLufuu7n6mfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyH5OmKsAHdhCuORTRiXpX/MqEK6V297EJyPM0erYqUy2yEYoubis35en+leZ/8IzWjOCHj5QUgqtzvP55FITbwFx1DUAlvxBEfWWYjv23ohAcJr4FC/Nl+brW32oz2MV9T2RRfcKq6KxH9cK1wj1xoL4/bM3iXs+ar4GQEd5fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=op1+KiBo; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCA9J5f8n1An/4/5Q3iH5bgY8I5dbMf8+6aEC8UZiopr11hojWO5wKiGzRVabsflzV2FYZtiz8X69BjSNFzXfKFkmtyp9vcnBtWkxKgMmge12JQeW9YvQylv88kw9bBss2x2Ff2PQqVbRYOmiPLfgHM/FaykYuflSZdW+BXTMsPrkXE2Z6TV13BQb/ZAJCt2CDIeR/q4LHpUOqSfw551KdqE5jN67ELnbhkrpJDHP8aNj5WZ4IbHhoT32W74B27a60GG3djmh01X47O8uqLLz1CZJZcoMuEa0cNJkwrRNuROobxbDc2QpGjSHkqBVh/h4HXd47X1FuQxNegKdU0WGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT6ww6KWIByryhwz9GHkk1sJlapaxo4wfAKXpzGIAVk=;
 b=JP9kU3MjuyduySFnRdQ/z5mQfEiXCxYV/5r6j3KeW1vhC/fhH7sgcRh3lPiPBsirb9pr8tHTESEiJIUL/lkcCTdV5Qhd2qTGpSv6CZxiOuWZQmKPJFn699i1qjwLsu58WBBEfjYjzPnnV8+oZs5APxCWJPMt23mbRSTACztJP8yy40EUSIzVnAVmVGzYu1K05/BSY25KBGWyPvDcJD8+bbPwK5cG9bhIiFHb8kDW+kNXGRr3TmPOQLOCmMZTKx9r+4FKAXN+4NzLexNHIpJl7ukWNDkpETpxAjNd9Mz9gMdkTFhjl/nSIRNhFDYE61WURieCONN6tVrv4VZS0bnoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT6ww6KWIByryhwz9GHkk1sJlapaxo4wfAKXpzGIAVk=;
 b=op1+KiBoIc0YIRkte4m6GZMZqxyxty1iBe+66Db8Uy6u0XamfvHJRmIt0n/rvEBOsdjQvzV0weAivR8iUwVT5lNo9R0xaAhdn+/TITqeQ6L/ts2WEltw5xs3wL0Dty15lwE7RL8DsYdlFeRlOUfJJ/vsz3sozB92Q+I21Y/j5Uknwef5ldjX2377sIu/cE3Tcp2iHiSTi73bW8EKrRvY8gcNjpxAavuss3KkSkRZqsDlq/ZISQtSdXMlcaEM0VxsbTWciXKfxBAXl77vPvdFDSd1Lg4T0d9JNpzLl4wv55CXnxnslNfjnbcM9RHHLYkXEHcGW3FEBXpVWkOo90HLKw==
Received: from PH7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:510:33d::20)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.38; Fri, 9 May
 2025 03:03:36 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::df) by PH7PR02CA0022.outlook.office365.com
 (2603:10b6:510:33d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 03:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:26 -0700
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
Subject: [PATCH v4 13/23] iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
Date: Thu, 8 May 2025 20:02:34 -0700
Message-ID: <639bbb47885e0fcca30f85e40f702dc18ea71d7b.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: f34b4692-91d1-46b2-a9af-08dd8ea6175a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V0j0HGKr2r98FEIBG1cE2863WUi8LS63KSuWhU1cSQgfWGeEH764c3kMseZ8?=
 =?us-ascii?Q?r7j7zXSijFYKkipGxh+BBQqxY+EidWGuxsf/j/vjdmKyLg2ELwNj091nGt0M?=
 =?us-ascii?Q?u7ebQDSneIMzDoFzxeIMLtJRuF/IsYRIgu9Xm10gAovxmbuSxWHmMrbd8x5o?=
 =?us-ascii?Q?16J4Xwp1wkV37YtSBnLhFrDfMz7pKfMCJJPGqnjps2mFbceNUKmSet2HlMSM?=
 =?us-ascii?Q?AZJPn7GssvhQjGntZO2Z15fxcF7N95jZbeiQNH47SUWDWI4U0lZZg2ke0/gk?=
 =?us-ascii?Q?E3+GEPwtGF5lvDbNEqxrUVh9nYY++pyFdXfB1wqqwy4mhosB0KKPogwyCxI7?=
 =?us-ascii?Q?M/HRBBKq5P1uihRNB/vhoI09FVlppBEWxuWyzaMkKUv4yJUZT9FbItx/RAVm?=
 =?us-ascii?Q?bj1NWAvdCFU/2JmQGXTFQTaFgJqjUwsEazZVs4JDL+UC3mwjIZ7R5Zihck3V?=
 =?us-ascii?Q?uarVHIhWa6aSHOMZ8tHmfGi3NMYDATyp/zar+uRu4D397jgs9+WTbUX0BYwO?=
 =?us-ascii?Q?29f7d8Xj5SOz5Ii/PhRfhuuP/gx/qpypqoYytKNLUoQPZ3CWSK7P3DFZwvFh?=
 =?us-ascii?Q?MnWmqUxclDtadpTHsoFXfveWUMg6dnDdlFDmePy1oyUeO/HzF5Raqj2oimA3?=
 =?us-ascii?Q?vuLliVYhj4mtgE3V/SVv3hBre6AWbYsoFjgLXVXhbxIjSOIc4W7q6QdhwTVt?=
 =?us-ascii?Q?8VBLNYz6zLXpk0Pi4PYTJuRfwhOQkovS/VRxkOKTeq7JCDzSbRUmh/pGDFoI?=
 =?us-ascii?Q?rT7X5xvb+5FI1TMjuCFCKgT4CNq36FXjAQfBJmiO9WNdaJHTerupwVjXIy9Q?=
 =?us-ascii?Q?Q+V90k+jX6/Avf7M1fUaw789PFIc/u7Fgu7MnBRLFY9AFEBM7rL4HVqxgc5e?=
 =?us-ascii?Q?31tG4Mln4TO4UYF/5jtA4calcTdLfAT2P4zLQC7ExJwiDD+HvhPU34Vrcxxj?=
 =?us-ascii?Q?OOX/DrxY5/IF8Fe/HaOa5YEdCFZekswAVMBaPu2dvj8jUwiUBNvk1kL+kIAv?=
 =?us-ascii?Q?yU7+J7OIGAwFc8/f/mUvd2jvl0tyhxwurw+nHUfQu34qCgun3238LaIVueeJ?=
 =?us-ascii?Q?EtRNOPrJUwqTLi3fqCMJpY3p0w0AzfKyycg/JfUvTl/kim5BtxTuUUiUeHDk?=
 =?us-ascii?Q?qOBMVW0YfTY7AVK7TJfjxOV+l1PiUKtEuEtSd+wMSr20OZXrD7B44X0Z35ku?=
 =?us-ascii?Q?lEgSfJaGnkx9ZgNbuhK+BLKYY3jpivAyV7lsAERC+uBDBavzxPW1OYE7SEF6?=
 =?us-ascii?Q?yTxg7oayZjnbFbpjoz+tHsCFFliKx04HcpnrXwDfLM7GhoggK9BAW8RjtZDj?=
 =?us-ascii?Q?jumEVlRzfHOPhPm/XMr0DCxLBSJeRRKtfzd4BXmOqfn5nNWY72ElmLWTLwc4?=
 =?us-ascii?Q?6RW67s+AnAUAr7yY+F6N0SxmVc990nBURaKrkDVfi7SAcroBOzfq+i1YbOIK?=
 =?us-ascii?Q?JE88wxcV/rGxw7pnYNIqnbUpVPx9Ad+hFKy6ntDhi8DwxT4ycAWYMj+hjGwp?=
 =?us-ascii?Q?P56WHHKEUoPQVIoHf42gXWLpZm3MhdRS8N4r?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:36.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34b4692-91d1-46b2-a9af-08dd8ea6175a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

Some simple tests for IOMMUFD_CMD_HW_QUEUE_ALLOC infrastructure covering
the new iommufd_hw_queue_depend/undepend() helpers.

Since the iommufd_hw_queue_alloc_ioctl() will call iommu_iova_to_phys(),
for input address validation. It might intentionally pass in a bad input
for a negative test. So drop the WARN_ON() in mock_domain_iova_to_phys().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 31 ++++++++
 drivers/iommu/iommufd/selftest.c              | 73 ++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 60 +++++++++++++++
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
index a5d4cbd089ba..463116fcfa9c 100644
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
+		.base_addr = base_addr,
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
index 033345f81df9..692c29ccdc46 100644
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
 
@@ -727,10 +742,66 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	return rc;
 }
 
+/* Test iommufd_hw_queue_depend/undepend() */
+static struct iommufd_hw_queue *
+mock_hw_queue_alloc(struct iommufd_viommu *viommu, unsigned int type, u32 index,
+		    u64 base_addr, size_t length)
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
+	mock_hw_queue =
+		iommufd_hw_queue_alloc(viommu, struct mock_hw_queue, core);
+	if (IS_ERR(mock_hw_queue))
+		return ERR_CAST(mock_hw_queue);
+
+	if (prev) {
+		rc = iommufd_hw_queue_depend(mock_hw_queue, prev, core);
+		if (rc)
+			goto free_hw_queue;
+	}
+	mock_hw_queue->prev = prev;
+	mock_hw_queue->mock_viommu = mock_viommu;
+	mock_viommu->hw_queue[index] = mock_hw_queue;
+
+	return &mock_hw_queue->core;
+free_hw_queue:
+	iommufd_struct_destroy(mock_hw_queue, core);
+	return ERR_PTR(rc);
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
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
+	.hw_queue_alloc = mock_hw_queue_alloc,
+	.hw_queue_destroy = mock_hw_queue_destroy,
 };
 
 static struct iommufd_viommu *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 666a91d53195..bfdb3a3f1d23 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3031,6 +3031,66 @@ TEST_F(iommufd_viommu, vdevice_cache)
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
+		test_err_hw_queue_alloc(ENXIO, viommu_id,
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
+		/* Allocate index=0 */
+		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					0, iova, PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail duplicate */
+		test_err_hw_queue_alloc(EEXIST, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
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


