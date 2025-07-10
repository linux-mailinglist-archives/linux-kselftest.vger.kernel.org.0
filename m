Return-Path: <linux-kselftest+bounces-36921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181EAAFF8F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917CF17CCD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F728CF75;
	Thu, 10 Jul 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qwG5tQFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC528C5B5;
	Thu, 10 Jul 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127245; cv=fail; b=uUtRDkoYBdZcq8vfVwSEAELcUTvz3eVO5NLudYqIx4FIHC7DfDiO0vXvoruQ+Rwpwojy+Z2nwNGE81iD5LNlF13C1qY7ED8ucbArwCr4aSFVFyUrmFRirFqoqqTYOzI9JZ7ZozuUg/OBagqhk2WdZc83TuJzg5AP5MJlgDkQEsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127245; c=relaxed/simple;
	bh=CqJWr2bPFjYQzUV2BeQ5bPnkZuEVXEDQvmEYfsC3/h4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVyLOE1A0FFAmA9qz32iuIHo42EsCuuAl6hqEoqhOdHUu/ab4TOy9xKq4hSWUrBTQWF/MwTci8p//n4Ar7l7XPuaa9gAO/s1H+x4I4pSzZ+chsvlF0id0VT/Ey5bpXkJJbOcEosTmnFHUStKDZsb3sIbZkUPdLGPHquxi6Cd9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qwG5tQFS; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awzGbNkUE3qg8RaqpcOneh2oBdvY3AHaH6r1Vo5mRCQnkk4BLcQCasqWS9vO/21YbzoS3IvTDjSlgdx7SonHapk0UW2Yq8Xgi6Lw7HOf16SYIIJjT6jjJFMbAT/77DkOGkkCpY6/61kriDcIf3PycOUVZ5V/szmVyCYBz6m1LkoFVmKWQjwEfdJvdfNs0zVRxLIuREMrG3SrOaYg5MlcmfHnFdF0T86rzwgh+itWFIDiHh661Mimi2x80BiyJm0mM7RI0o3BxgROnaO/BwK+e1tOoegLd9P7O4KdbVkP0zuRwyDGbU+BQQkFeALO+GnUkhb9z45Yz1e4CmKyDYEWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9ez1cM927HtdfpjHOuFWrBF21azBzEX7ND11bIp830=;
 b=HEQ4q0cbpvIQgM8Q3tbKQfq9sGp/+SOb9I248upkbGvlecFTZHnlT1nYgUC4vRgosRyt5FNqQuK9DYgKvbwh7LzUInVO7FN69Tlda0Q/t5uaqEhukvTjkkC6FcAy1mv336M9asrsKbJDwgPc2oIbbyOOtknEOxOT4T2dImpSyB26G8GSKVyvQ6rVx26z7HxSO9ZZ23ohfiGzQ0sDWqzRLZeXGfIp7KiZMIxiMqSqjPsOx6tCvfN3DTzdXh6ISVIH8OV2dVgMCSNm5hrt0gCxo31ESC+w+W8VWTreyjqL3Ud9xHGTKLOD6GHo9TKD9syz/Fh0wZALAqHqWOTS8pjJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ez1cM927HtdfpjHOuFWrBF21azBzEX7ND11bIp830=;
 b=qwG5tQFS5Ird1HKI5PKAIuPBZciSTQTt8dAKrxuiNbpOfjjsVP0nxYwrsZzCPlId1T0vnVQoeb/BEVip3mLVknKHKS8KAJia0aiIKSXCRP2lLV1YDvuRM2MVRZjr3faGIzaNNghLUj33PK2SPByn9PUijJADgxvCwgDaEB2RK1C9xE4qlpEgNuYvTkMLpUNFMaFPeUgzsvh1mmapbJfPCGmBvUepm8XaKodpDonU4U0T00gPnV9iHZFjZ82ibN9K7IcfTWk4vcFLD7z3JuFWneMlD/7E+3MFQlRVaqfshCUDIKqTG3d8PZKHZebJYiO5KTpjzyaE6ppgEk04M+K7jQ==
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 10 Jul
 2025 06:00:36 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::9f) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 16/29] iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
Date: Wed, 9 Jul 2025 22:59:08 -0700
Message-ID: <e8a194d187d7ef445f43e4a3c04fb39472050afd.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: c60657cd-6a6e-4175-ee7e-08ddbf771705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zc5u4+jhhhQvW2vtYgE5V901j0faBJfx1UkmdQbaYbrz6nrnk/3ZDl6cvX7v?=
 =?us-ascii?Q?qy4DIXK2Vvls//bKPM0KCRMkQhRmUw0dBlPRAOskF6ufOpYRUw5TeGs6+SfE?=
 =?us-ascii?Q?x+UgKu7j6GO8IIDWRapy3kdb2WGH2wbPpsRsMgeCwOB8iHr3JmJPlzDhoZ5D?=
 =?us-ascii?Q?8GRaex/OY/DOup5negPwsnme42wHQRJy4AQ8KwBwLNgAHlcgsySAmwuVcKnY?=
 =?us-ascii?Q?Yj+i3zInZEtIuGtL77VLx23ZhbfoYVIA6ptxtToE8ovSfWNb00PU5/EVi1wb?=
 =?us-ascii?Q?wR4CHxv5o39/giIdFQBDOS2YQGwJokAK3C1YiXZyr7Kjl87+c2oBNseJ483C?=
 =?us-ascii?Q?7g8Bqff0Us8tb+mE1smiYC9CjAW+5eLN7vKbu5bNU9oxsYlxB6CDBMP8wsd3?=
 =?us-ascii?Q?ZKUuAS3KS7qsjbBG+G7/RG2NlxRzkLbZVc/tT17y2S4/L4FOlDSa42Ruc0mk?=
 =?us-ascii?Q?0nzRhGSZiOO1PgKRCNfXXWk1cYN/4Su9vOFOBbO3knbO9UU3GZBPngcl/Q4A?=
 =?us-ascii?Q?USdtMmuBP7Ag42kbQPOhiiuMKYAeH9xp9ze6F8AAkZd7DskgbXxTxjYGwNtv?=
 =?us-ascii?Q?sXytnIZ1i6fo0qbU4NcORrHNEDRx9wxJMDup1O+5LJWSliSwfUcDV/mY3lB0?=
 =?us-ascii?Q?bpIH3zWCI7EIq3pTfuSYmX/htje5nxMpLTU8qTcGnk+8jbuxrHj8PopLYViK?=
 =?us-ascii?Q?08lOD6tWzQiLGJ2RgLTVhNYgSyIrx14lL9Qx4ZmplnhMetiDQZaVZiQ6yCAf?=
 =?us-ascii?Q?S+nrkB/rKO92889KMGQ1WKhojW2bCtZpfeH+i5V27KN5R74EQZPmP+OHVV2J?=
 =?us-ascii?Q?knFz3P/gyd+q/uccqOe/kNEW/XC6D8khNye4F+f3J7eip+jAMzP1NG+2Y7uM?=
 =?us-ascii?Q?Hpk6GSFWdnV6xpzHjaKG3CZ1cO8J4dMhbZpO/+k4RpDtKRboXV+HUiTWCbuS?=
 =?us-ascii?Q?POByH72KaZGHRb+eyDwoz45brFrH/MiVICRPdr541PtcG5d/PmC50oyXjUVF?=
 =?us-ascii?Q?YUDqg3TUx+7qcMTly8Nf85c5Ap7hGs1OlpCaQMOI33Evut7tbhcAo3XghdDo?=
 =?us-ascii?Q?pPDpsLFpRuMLgSriBISA9i4XDyBe//iNMIm+Z3VGeSSv+mPDmKLMyyVzyiFh?=
 =?us-ascii?Q?jHgssb248RfM5SA0soR+AKgG3r96cUNn6Qk6h3GIZnwYobrh4Ro9xnlHfBFp?=
 =?us-ascii?Q?wO/09lVJQLt4uPaECkKtTO1tDib7Qo3RLZPwJbcFg9Rq4hbZFJSedUlNmE24?=
 =?us-ascii?Q?gegU0Fx0b9V6/6jOJgpq+l6z0WVWcJIQGLVnnA1FTrOpCMPyCEbIO0H/a6Np?=
 =?us-ascii?Q?0DCOyIo0n6zaoFlgbNkCtG+tib8AVXq3LmDLdd69R/eZ5ATniK5XclzSicVm?=
 =?us-ascii?Q?7aKU248+XhCMqx0s9oG2huOJp9FfNH0ARGT7XJAlE+MbQ5TbjTsepodsGR4E?=
 =?us-ascii?Q?TGxwqgR1ScN56vbgA4k8TR7G0+aBM4czpOqrld3ojTufApcCG921f1/wG1qp?=
 =?us-ascii?Q?CWVkrH2HTOamXKOyde0Z1RjJN4PCYAyJNBdB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:36.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c60657cd-6a6e-4175-ee7e-08ddbf771705
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

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
index 38066dfeb2e7..2189e9b119ee 100644
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
@@ -670,9 +685,11 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
 }
@@ -764,10 +781,86 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
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
@@ -784,6 +877,7 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct iommu_viommu_selftest data;
 	int rc;
 
@@ -801,6 +895,9 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 	}
 
 	refcount_inc(&mock_iommu->users);
+	mutex_init(&mock_viommu->queue_mutex);
+	mock_viommu->s2_parent = to_mock_domain(parent_domain);
+
 	viommu->ops = &mock_viommu_ops;
 	return 0;
 }
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a9dfcce5e1b2..73426de77675 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3032,6 +3032,65 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, hw_queue)
+{
+	__u64 iova = MOCK_APERTURE_START, iova2;
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t hw_queue_id[2];
+
+	if (!viommu_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	/* Fail IOMMU_HW_QUEUE_TYPE_DEFAULT */
+	test_err_hw_queue_alloc(EOPNOTSUPP, viommu_id,
+				IOMMU_HW_QUEUE_TYPE_DEFAULT, 0, iova, PAGE_SIZE,
+				&hw_queue_id[0]);
+	/* Fail queue addr and length */
+	test_err_hw_queue_alloc(EINVAL, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, 0, &hw_queue_id[0]);
+	test_err_hw_queue_alloc(EOVERFLOW, viommu_id,
+				IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, ~(uint64_t)0,
+				PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail missing iova */
+	test_err_hw_queue_alloc(ENOENT, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, PAGE_SIZE, &hw_queue_id[0]);
+
+	/* Map iova */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	test_ioctl_ioas_map(buffer + PAGE_SIZE, PAGE_SIZE, &iova2);
+
+	/* Fail index=1 and =MAX; must start from index=0 */
+	test_err_hw_queue_alloc(EIO, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
+				iova, PAGE_SIZE, &hw_queue_id[0]);
+	test_err_hw_queue_alloc(EINVAL, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				IOMMU_TEST_HW_QUEUE_MAX, iova, PAGE_SIZE,
+				&hw_queue_id[0]);
+
+	/* Allocate index=0, declare ownership of the iova */
+	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
+				iova, PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail duplicated index */
+	test_err_hw_queue_alloc(EEXIST, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail unmap, due to iova ownership */
+	test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
+	/* The 2nd page is not pinned, so it can be unmmap */
+	test_ioctl_ioas_unmap(iova2, PAGE_SIZE);
+
+	/* Allocate index=1, with an unaligned case */
+	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
+				iova + PAGE_SIZE / 2, PAGE_SIZE / 2,
+				&hw_queue_id[1]);
+	/* Fail to destroy, due to dependency */
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hw_queue_id[0]));
+
+	/* Destroy in descending order */
+	test_ioctl_destroy(hw_queue_id[1]);
+	test_ioctl_destroy(hw_queue_id[0]);
+	/* Now it can unmap the first page */
+	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
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


