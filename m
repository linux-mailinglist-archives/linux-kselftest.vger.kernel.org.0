Return-Path: <linux-kselftest+bounces-34989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4674AD9AC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6287AF4AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618E5211711;
	Sat, 14 Jun 2025 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4/gfryd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74820E716;
	Sat, 14 Jun 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885343; cv=fail; b=XqHqVzAeRlLPUqwhlDruExd3MXzdOUe/rg5gxsZCHf5hy9qfl1f1gMgytOlEd5IsZRlS/JV0CRopLyKLhcxJPl+YC3BPTpiNTaXklfFWKprwVtQzn4UVpbrjaKYMfwIoeZuCBJosn9zjlXUvSGd9Ao+IA7S76wyB/AzjHJxH77U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885343; c=relaxed/simple;
	bh=7dBL3qYmG5fhfCzf9NXmcOb4eEr8qphIowR7vAFa0cY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O47ODRRJu/Dto6whghugg1HBdNA0KaERw6HTwgQW73/IqALTa87Y5J3oNNEY4eRAwJUBD19dYj3NOgGy10jcXwOtWAqxoEsFkloB4SLNsiI7g4NwQBuXEe0YnNvwWo8kVc33sIP56m4pWSXElbcch+O7HrLrjiY0CV/fnDuXjMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4/gfryd; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXshaR+PQHvqv+q+QTYLbXlDzt9W52geoZsD7aVz0P6m/FBYNyTCL2zRUv5gEQyOzgqOMgHpUX2OjJHstMScVd/wdu7Q01h6w45P7HbWJ93wuxhQdbIBwlSYl4FcQTWchgTaxJL/Ht5EZi9X8QTaPum0eT00l8P4P1nFC17wf4tNdls3TLJ7YzX/kbWkFuyDEgHWH9EPI+lXRBicS8lxDCDna5lg9e+/l/xQmmB1+VbNuHMxUqzTk/7w9g30F++2B9A26jcUGQUdVRDI8x8aTlUbcAa5yXsyCsp0GetZoVdlJuj2wRbO9c2/DlPDxI4KOrubinXtb7gXIKuUd4vkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tasJ5EWB8uH5qWW9xf+t+zHAycYQrfq4hcFkluTy/qw=;
 b=Olys8g+7uNwXGF381JPHHz+rxdCuvnUAk5JCU8c7SU+N65bmXcnK7mMAxs8K8+AtBslyMEFUYUFbSdq/9OhygpT9eL/YzlRLJJYKt7gdkboLlcOjr6FPHeVEKzSrJoeysLlo1pUaTkkLOU+jFeOAlwmEsAVbERsrWQpl++rYJAf/zKfVj7/yHcK/kPR1XX0vKV9silKU5XA2fSlVHzOqYjrL7KJyeVsGQUaoCgJxInfuUHRGiAI+4iykHtiVZEAiwep83+rywqwoBGdSbxzANj1ZhKVR7Toy1gb6m/vOBP23dbDZXKnQ50i66F0ihgMlEAky0Fa7U9kzt7eT+btqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tasJ5EWB8uH5qWW9xf+t+zHAycYQrfq4hcFkluTy/qw=;
 b=A4/gfrydUukkJ0cH3FMGiBBePUAs+rpWCA3vAPPXFZiJzksG5vSuoPGeq/O2r4RijdsqmH1vuHc9PnfUrskSpU7+gskkgt5kBwOF2k6ZM+hBbQCfnagznOEiM1qq3XOSwCtPcvcfMc7Eq9qigi1G+2Fo7GA72P8w2rC3zgyRjLDbxlTG422Q/TkeCmREmi2wt565c4mXoD2YEjs2IZhKM/SHHKKYOlqp+L7KoAa2YRY8kR6IYCXaTX1IKXubXLEHQlhPaTVBYMDU3DTEQTLpIePf3Rin2UYpBTYyGfI2plgm8T/jKKnMjMmr68R05CUJI4525Oil0a7rppHIeYNQbA==
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Sat, 14 Jun
 2025 07:15:37 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0::4) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Sat,
 14 Jun 2025 07:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:22 -0700
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
Subject: [PATCH v6 14/25] iommufd/selftest: Add coverage for the new mmap interface
Date: Sat, 14 Jun 2025 00:14:39 -0700
Message-ID: <8f08d7e5e1fee1ece113501d76edd345ae26b5ca.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9bbc76-a0a8-4c2b-66bb-08ddab134312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Axg370Dts0mENavqPn1sLG+XJmA2oXhdB731xCPMqrCb6UkMHLH/WMwVh4LF?=
 =?us-ascii?Q?WxWtrk4S2nBfDcJzCW0wECEWDeVRqG22ZyV8Kx/4ilZ2xmQHq0f67Ppx+XQt?=
 =?us-ascii?Q?qZnu2lmGteVpZrccBnKcpTSviHPoVphDxce3clyPfMyBUnnggGiZrnZYqpag?=
 =?us-ascii?Q?vaN0wkapjywf6wgzEYVUN0wTpnURKkxcSH0Cd6hnY7eFx/hxGM58jxiK3PbE?=
 =?us-ascii?Q?tdi1VYiNN9rPuBP9ZQlkmZPv3afxBX3OsFT3aSSwmgkytZmPOHS1QHmArtdN?=
 =?us-ascii?Q?SO//zEmhoeDblW3OYUMUPIQiFX3BBIb7CF6xvnajSIBh1FzX7UVkTDWWCZVi?=
 =?us-ascii?Q?RudxHBKq4EK3Q4+0eDO4AxX2RP0+gph/Bu/2ZKs+n7T9aDkf5AxZEw4jrJCl?=
 =?us-ascii?Q?JA6mn0Imue0mL0JCAX6UzI3ijosTqU5qszhtpCF+gF0C2AkdmMiisV0k/Has?=
 =?us-ascii?Q?TkXoSX+S6Eg7w9YK5ALx4pCBckem/mvuzXbuu2ESdm+g0vKJSs62s7sloCWa?=
 =?us-ascii?Q?orSUGB5daXWFHfI6xCkO5TXp+qAhuJndY/tmDC9Yr1rPcbtCni28S//FOYSX?=
 =?us-ascii?Q?RL+miopNNGABNLXIik4tQ85zWcs6hi9+gaG677WmS3kabg1FnLKbPzvuHduk?=
 =?us-ascii?Q?6KHEtQDk2bk2ufCLXwvaYnv/q6gSur6+YNmtpzZ3u3CLxRknOrTwV+Dzv1y1?=
 =?us-ascii?Q?zFzO/9jfgO6T8d8r6dDAoZw5xHE2SD4qyAXpHClOIFcJv/QvUP43rlngH5Iw?=
 =?us-ascii?Q?RviKlJuRTL92pHxyl/tgIcIR8M4y2D10QaltqvhIy8H9Ai89d7PtAQmyWgzG?=
 =?us-ascii?Q?4/pChjgYfNY5cfBUPL0S8glyDiRFtbHoQd00yfEsAqNYo2o6uDlkvScGJzwB?=
 =?us-ascii?Q?xSnOsZDqI1ekrfCLWMo3KNF4b9R+ZXq1dTe68ZlTx+0G3K7WgB1Z+vf7d0Rd?=
 =?us-ascii?Q?vDAnE88k6iLrRMToJLQ5IXIrPJ3yuJ4JOswmecBULymK1/0+T7qvyplW8Bab?=
 =?us-ascii?Q?QnEN318ffzTLnAHaETUEt7pkbcVqqqdta20lh7x2K1iwRR8B/E4r+IEXsGD2?=
 =?us-ascii?Q?b6yszACKJL5g65nGwkkuIAFN7TmUiHNXuLFHwlxQULl6zB+lm0E63qZDJZBl?=
 =?us-ascii?Q?gVFuWEproL9TaATbx7JQ5PeopfZZbmA5cDSJom3DFLA0+q0LBPU86qlp6CHh?=
 =?us-ascii?Q?0wLGPvvUPMRSe17FfiboL91DHm+xX9w7jsFMbHX2/t7WQ9cI43B3cxiNoOxe?=
 =?us-ascii?Q?cM6GmYmPQWsM++uK1DgE1KAsGkCLw17vwMW+D7TE9BfVheBkoZYTnkCYCVdK?=
 =?us-ascii?Q?ZXPwBM4JKeAnWP+NHrko7cUmJQv6osUrFftw0w1lerDi3CdsWYfXnb6rG+1N?=
 =?us-ascii?Q?o/fZkiwB+SGkUwhqlbN99PyU01j1hfoyETXB/36JHBS+xrm1+WL3PfiugwTM?=
 =?us-ascii?Q?30YR0M8RoJEohHADs1VxsUflwZOWfhpds8iQKH4QuReZ+xxibl7a82NlaqTw?=
 =?us-ascii?Q?kb5WTLxc4dwnBC9WMDGF0T/YTwGLI2r2qNrt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:37.3527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9bbc76-a0a8-4c2b-66bb-08ddab134312
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

Extend the loopback test to a new mmap page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  4 +++
 drivers/iommu/iommufd/selftest.c              | 33 ++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 51cd744a354f..8fc618b2bcf9 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -232,12 +232,16 @@ struct iommu_hwpt_invalidate_selftest {
  *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
  * @in_data: Input random data from user space
  * @out_data: Output data (matching @in_data) to user space
+ * @out_mmap_offset: The offset argument for mmap syscall
+ * @out_mmap_length: The length argument for mmap syscall
  *
  * Simply set @out_data=@in_data for a loopback test
  */
 struct iommu_viommu_selftest {
 	__u32 in_data;
 	__u32 out_data;
+	__aligned_u64 out_mmap_offset;
+	__aligned_u64 out_mmap_length;
 };
 
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9a556f99d992..4a1b2bade018 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -56,6 +56,10 @@ static unsigned long PAGE_SIZE;
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
 
+#define test_err_mmap(_errno, length, offset)                                 \
+	EXPECT_ERRNO(_errno, (long)mmap(NULL, length, PROT_READ | PROT_WRITE, \
+					MAP_SHARED, self->fd, offset))
+
 static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
 {
 	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 3260fde5f920..d100ba27f205 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -152,6 +152,9 @@ struct mock_viommu {
 	struct mock_iommu_domain *s2_parent;
 	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
 	struct mutex queue_mutex;
+
+	unsigned long mmap_offset;
+	u32 *page; /* Mmap page to test u32 type of in_data */
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -688,6 +691,10 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	if (mock_viommu->mmap_offset)
+		iommufd_viommu_destroy_mmap(&mock_viommu->core,
+					    mock_viommu->mmap_offset);
+	free_page((unsigned long)mock_viommu->page);
 	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
@@ -886,11 +893,28 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 		if (rc)
 			return rc;
 
+		/* Allocate two pages */
+		mock_viommu->page =
+			(u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+		if (!mock_viommu->page)
+			return -ENOMEM;
+
+		rc = iommufd_viommu_alloc_mmap(&mock_viommu->core,
+					       __pa(mock_viommu->page),
+					       PAGE_SIZE * 2,
+					       &mock_viommu->mmap_offset);
+		if (rc)
+			goto err_free_page;
+
+		/* For loopback tests on both the page and out_data */
+		*mock_viommu->page = data.in_data;
 		data.out_data = data.in_data;
+		data.out_mmap_length = PAGE_SIZE * 2;
+		data.out_mmap_offset = mock_viommu->mmap_offset;
 		rc = iommu_copy_struct_to_user(
 			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
 		if (rc)
-			return rc;
+			goto err_destroy_mmap;
 	}
 
 	refcount_inc(&mock_iommu->users);
@@ -899,6 +923,13 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 
 	viommu->ops = &mock_viommu_ops;
 	return 0;
+
+err_destroy_mmap:
+	iommufd_viommu_destroy_mmap(&mock_viommu->core,
+				    mock_viommu->mmap_offset);
+err_free_page:
+	free_page((unsigned long)mock_viommu->page);
+	return rc;
 }
 
 static const struct iommu_ops mock_ops = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 0da72a2388e9..235504ee05e3 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2799,12 +2799,34 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 	struct iommu_viommu_selftest data = {
 		.in_data = 0xbeef,
 	};
+	uint32_t *test;
 
 	if (self->device_id) {
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
 				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
 				      sizeof(data), &self->viommu_id);
 		ASSERT_EQ(data.out_data, data.in_data);
+
+		/* Negative mmap tests -- offset and length cannot be changed */
+		test_err_mmap(ENXIO, data.out_mmap_length,
+			      data.out_mmap_offset + PAGE_SIZE);
+		test_err_mmap(ENXIO, data.out_mmap_length,
+			      data.out_mmap_offset + PAGE_SIZE * 2);
+		test_err_mmap(ENXIO, data.out_mmap_length / 2,
+			      data.out_mmap_offset);
+		test_err_mmap(ENXIO, data.out_mmap_length * 2,
+			      data.out_mmap_offset);
+
+		/* Now do a correct mmap for a loopback test */
+		test = mmap(NULL, data.out_mmap_length, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, self->fd, data.out_mmap_offset);
+		ASSERT_NE(MAP_FAILED, test);
+		ASSERT_EQ(data.in_data, *test);
+
+		/* The owner of the mmap region should be blocked */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->viommu_id));
+		munmap(test, data.out_mmap_length);
 	}
 }
 
-- 
2.43.0


