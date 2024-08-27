Return-Path: <linux-kselftest+bounces-16452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB870961515
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AD228858B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE731D6DA7;
	Tue, 27 Aug 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eAGYtIT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1921D2F47;
	Tue, 27 Aug 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778186; cv=fail; b=jG1Sv1GOuW9Rdw2Van6Ct9K+4zLg5FMwQ3CcemxDZRwdOy+ahJiN9ppbjDzU6xqZafk3grn8RAA5P+JpZZreXs9qV70je8vmKe74jeGyKqNZmIyuZK1MAxBbn4Fpe22T/uwmsjbRqhvhleUw8fOrlWARMY30GcC5AQkLJVOa6aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778186; c=relaxed/simple;
	bh=kMBFcdMGUueNekjXuBl7uvwPc3VA5Ct1+yDOhIu95pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmcRpcIncQdC3TtQ/niGj1iiQ0SN0lMFiFcGWnoFdUI7Lc4hzFc74VP5BNY2XLzsmL+RDKs7xUcLegKIH73DJ5o9xS0dTxU1AkjjPFR5ZjrTWRzhQwwcqgEog589CvCuhwXTiNvY/rZloaH4jVo2O7xvGvqY9o4pgSiJeAuk2Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eAGYtIT3; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOuQEKkAwRbJz1kOrgEXATEcSeKAHgP+wTf2g8sJ9Mhp+JeWPT9MgMVFcCHMd2flqbpVKqnaubA5wmOJK/yAoaw85SgYDYxHS+KVZDNbJDNKOrP7kZeXr+VLFyHGfHiGj0L2s6+06E/FCJvppyy3ig5uZDRbOibwZaUvufHX2w2x9kAgGNkWU92p+pYBigcRnyo0A06qr/luCAw7Ewjclcjz7tCpfTMJW5GTzqyv4SqUvdYLaPPKgyHGLmHu7FRF2MK50DbtpLn1B3Oug5lv9FlqKY9p/bNL5lXH9vwg8I+SLz4HW7TnxR+tRv3u1+tbINslksn1mTW004U9vJUITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djhiKFapha2IGC376NNMAO6nQe96ek7Qii9YLPHngBw=;
 b=HN1wjnwvcgBYdJ8BJ1vkkgCHC9MtT7Qc6t231v73dardQMdIBvDGLIOT2TASCAVPBnVyJ60q8vSGfHxn7lyCWjMaMVFt8NSC14/DO/slWE7G1ITfGScZdiOiMeMkf5mSnuSwDWKtulUCF9vzLHLu195RDL7zBvuiO8SMWWQlWcVubC2Wx2Hj6zoxpAVKj2sCN5aNsFP2YoPQS3a7YgaFJGv2Xf1A4JB4ajileDisqBF6h7BpR7UgUYNgKO8HVqwIymMDx25ddbk/6cxZX1nliocwZerzyCEkmNJDYuGVJcoOas3P+Lkfd6grK9p3p27mZ3G3WJkLic6nY/ss4WXeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djhiKFapha2IGC376NNMAO6nQe96ek7Qii9YLPHngBw=;
 b=eAGYtIT3//qW6R4YJhpzbXDScmyPskKL+p/NUpVQRqa+mt4k/h/26W7aliP8ygv7N0mDfe9BXvjXCMwJGJotAnKvbXt8VnMYoHofw/y6jvCWscb7MFi/eYvOWMlMnCRhhsMrU0/oKIeIHv7O4hGSbbc8l0jxmTIoX9HlewcOdcelJNeczoEBSyaYfDwM8ZZC+UlCGsHxU3gyjV7A55qO1MeD9fvxe74ifDtlRuqAnrPyTZmAVPeJfae2EbW0eu7GW0q/DUjkgUKwVqI/QtGhoTAJapHg4msKBESUFZ6ZfaAZcani64kjBbFrEJNDl6XVCZ5+hma0XlWrOT3fNm0DAw==
Received: from CH2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:610:38::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:02:56 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::8b) by CH2PR05CA0054.outlook.office365.com
 (2603:10b6:610:38::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 09/10] iommufd/selftest: Add EVENT_VIRQ test coverage
Date: Tue, 27 Aug 2024 10:02:11 -0700
Message-ID: <0320b797787b8c314171b915660e6366d92da3bf.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 61852039-ad32-494a-faf2-08dcc6ba18a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M+0+Dn+T7/DD1x8hOL7GhbLNSjOj4c4H5mtsO25a6TFYgsH2pZ4QzfGXpHyP?=
 =?us-ascii?Q?kMYUyJnE2HM8GJ3e9ifsFzjbm8g97xUKUBi2jjN5d15Hw1c2UBV7qav+PVF9?=
 =?us-ascii?Q?ZFAKbmQv7J+QZWkzJDL1RVASo4HE3rToxvhCtebmJ1EbOGedpMkUB6YO0/Yh?=
 =?us-ascii?Q?0rXPbfLEQsYbeKhHOBumf57nVteoSZbk8eU4yN7CjvaWPVeJtQVEPvIdoTSU?=
 =?us-ascii?Q?6eQkbsEuIBKh7MUMVElMbGMxZPJdh1jQiITMyJcrEPd4X5gvW7efF3O+DHD9?=
 =?us-ascii?Q?r6kMtBYwKQ3c4/MIfT14H8OIdYWvXd2G09oi7BxyveAvrf4vPzsYArPV0OXQ?=
 =?us-ascii?Q?EGgkQfqacXCYX1vKGtywMi6RGeam8QmyLy2O9NIBjwYrTWYL5AUnGUgaL6G6?=
 =?us-ascii?Q?khS8Ntg8rY5ytt9ltTWtioFqSn0E19IGexJFOUvILC8VDravGLm/qP+JNIzW?=
 =?us-ascii?Q?f/jDqeZWQSLJ8oxrDTEsmHjyL6HthuCF2oFflZDNFLaHUThUoCfH2/1Nm270?=
 =?us-ascii?Q?AqsSwzU2ZxC/yGcRyhICSTiVemB4i4j3UV328paEWicpuerZUkdDm9vW+JuN?=
 =?us-ascii?Q?Zqpm/6VvR/3d0t902ZXcBO+klhy1uo/0Y6AtD2+efBFUiyQ1OKcrYVQmVdgY?=
 =?us-ascii?Q?4R3muVzy2c6c5PmqJRaGBd2Tsenvr9TZ+CftVYWUeZfOc/BF2zRMYHyV+MPr?=
 =?us-ascii?Q?jrJaF5VWWI/Oa3kvdrMkUfnVC4DgA+fiuNkMdAsmALrJQ2Z4Lu4gI8EOTEX5?=
 =?us-ascii?Q?li5FTEWKSEiEXsyJE0ccOGUeHliRBXbYfp0fd95vSB+lcpsHSllGYBfVifOT?=
 =?us-ascii?Q?3VbjFqS9WZ+K+dyj07+bd/ezDz2wBkzIvyFbTyUzP9KbjwXRpf6tEMA/ZKM4?=
 =?us-ascii?Q?8hYC1nYlxc1bsNd7fwMT9HhsFY4RILJpPMzJCi2UeyUPxl6Si6a5yT8rnrir?=
 =?us-ascii?Q?sELYwhtvSw945M7sQEks5s6TWvAaSbqVUNqAG025L/rkPoDlS8MWVYb4x9X6?=
 =?us-ascii?Q?QualtzHZFc4tuwDHRTAgXuLD8x7tz6ieb7pmszgCxQ9CU7+0DQ0n/kBzWyl6?=
 =?us-ascii?Q?UaSeDifjl48Pn+reib04upw0Ry69hnGSb5iFfu5gY84POMINvnWRPpcUhBhC?=
 =?us-ascii?Q?0B4cEQetj4sDSOtO8cYYPHs2eciPJ+D+OpttJcAMWA1IdtxLEHoxQt7gdDC8?=
 =?us-ascii?Q?IkMcuKuwJSAX7ltf56DjhzHb6/XxglKXZnd6Ng+ltJOpdccU8nA+BccIbCIP?=
 =?us-ascii?Q?kW+Uc7Xzj0r5FhLVz0B6ce9k4e67Mnyb0QpzeKYupsc3nlEPOGyJj3AReKsY?=
 =?us-ascii?Q?IxHJmSe+VFU0xxQ758hlogbvMMogFENruOOVQQI49g5bGGMDwKwvPioQt8P0?=
 =?us-ascii?Q?mhqoyX3TlXfH4K3L9qjQuz+tNkwJb/yBogj7JDzQAOJFSsZvNmTgcf+IM85W?=
 =?us-ascii?Q?oG/VUOCiLeiRi29d/RxToVithrE1mQLO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:55.7821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61852039-ad32-494a-faf2-08dcc6ba18a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

Trigger an IRQ giving an idev ID, to test the loopback whether receiving
or not the vdev_id that was set to the idev by the line above.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 11 ++++
 tools/testing/selftests/iommu/iommufd_utils.h | 64 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6f1014cc208b..11208f53fdce 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -564,6 +564,8 @@ TEST_F(iommufd_ioas, viommu_default)
 	uint32_t nested_hwpt_id = 0, hwpt_id = 0;
 	uint32_t dev_id = self->device_id;
 	uint32_t viommu_id = 0;
+	uint32_t virq_id;
+	uint32_t virq_fd;
 
 	if (dev_id) {
 		/* Negative test -- invalid hwpt */
@@ -595,16 +597,25 @@ TEST_F(iommufd_ioas, viommu_default)
 					   sizeof(data));
 		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id);
 
+		test_cmd_virq_alloc(viommu_id, IOMMU_VIRQ_TYPE_SELFTEST,
+				    &virq_id, &virq_fd);
+		test_err_virq_alloc(EEXIST, viommu_id, IOMMU_VIRQ_TYPE_SELFTEST,
+				    &virq_id, &virq_fd);
+
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x99);
+		test_cmd_trigger_virq(dev_id, virq_fd, 0x99);
 		test_err_viommu_set_vdev_id(EEXIST, viommu_id, dev_id, 0x99);
 		test_err_viommu_unset_vdev_id(EINVAL, viommu_id, dev_id, 0x88);
 		test_cmd_viommu_unset_vdev_id(viommu_id, dev_id, 0x99);
 		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x88);
+		test_cmd_trigger_virq(dev_id, virq_fd, 0x88);
+		close(virq_fd);
 
 		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
 		test_ioctl_destroy(nested_hwpt_id);
 		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(virq_id);
 		test_ioctl_destroy(viommu_id);
 		test_ioctl_destroy(hwpt_id);
 	} else {
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 0a81827b903f..9fec38f45e0e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <stdint.h>
 #include <assert.h>
+#include <poll.h>
 
 #include "../kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
@@ -888,3 +889,66 @@ static int _test_cmd_viommu_unset_vdev_id(int fd, __u32 viommu_id,
 	EXPECT_ERRNO(_errno,                                               \
 		     _test_cmd_viommu_unset_vdev_id(self->fd, viommu_id,   \
 						    idev_id, vdev_id))
+
+static int _test_ioctl_virq_alloc(int fd, __u32 viommu_id, __u32 type,
+				  __u32 *virq_id, __u32 *virq_fd)
+{
+	struct iommu_virq_alloc cmd = {
+		.size = sizeof(cmd),
+		.type = type,
+		.viommu_id = viommu_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VIRQ_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (virq_id)
+		*virq_id = cmd.out_virq_id;
+	if (virq_fd)
+		*virq_fd = cmd.out_virq_fd;
+	return 0;
+}
+
+#define test_cmd_virq_alloc(viommu_id, type, virq_id, virq_fd)         \
+	ASSERT_EQ(0, _test_ioctl_virq_alloc(self->fd, viommu_id, type, \
+					    virq_id, virq_fd))
+#define test_err_virq_alloc(_errno, viommu_id, type, virq_id, virq_fd) \
+	EXPECT_ERRNO(_errno,                                           \
+		     _test_ioctl_virq_alloc(self->fd, viommu_id, type, \
+					    virq_id, virq_fd))
+
+static int _test_cmd_trigger_virq(int fd, __u32 dev_id,
+				  __u32 event_fd, __u32 vdev_id)
+{
+	struct iommu_test_cmd trigger_virq_cmd = {
+		.size = sizeof(trigger_virq_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_VIRQ,
+		.trigger_virq = {
+			.dev_id = dev_id,
+		},
+	};
+	struct pollfd pollfd = { .fd = event_fd, .events = POLLIN };
+	struct iommu_viommu_irq_selftest irq;
+	ssize_t bytes;
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VIRQ),
+		    &trigger_virq_cmd);
+	if (ret)
+		return ret;
+
+	ret = poll(&pollfd, 1, 1000);
+	if (ret < 0)
+		return ret;
+
+	bytes = read(event_fd, &irq, sizeof(irq));
+	if (bytes <= 0)
+		return -EIO;
+
+	return irq.vdev_id == vdev_id ? 0 : -EINVAL;
+}
+
+#define test_cmd_trigger_virq(dev_id, event_fd, vdev_id)      \
+	ASSERT_EQ(0, _test_cmd_trigger_virq(self->fd, dev_id, \
+					    event_fd, vdev_id))
-- 
2.43.0


