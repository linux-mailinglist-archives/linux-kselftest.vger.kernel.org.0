Return-Path: <linux-kselftest+bounces-23892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D404A00E8B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DF518849BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C751C1AA9;
	Fri,  3 Jan 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+XnqttY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C11C07FA;
	Fri,  3 Jan 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933488; cv=fail; b=XmJzApOk4IrZDAyIvMgJd+uaJxxYBnCFnX1Tu+rqCe+3FuVJ0EBPNv+g8wC6HzoB0GHCFkeFjM5nCb/EE5CPuASWU0C4jAS6L+VbSeDlfVuML2h1sEkTeSq+w9wR34vfkpAwnzkAA5GljhBlOS8zPyp3CpOGdyU+L6aAQgK9P68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933488; c=relaxed/simple;
	bh=YkenH78tOCC6SUgR979itYHRNLbUNPbjFXTJe5WouaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMnzseyj5dwXOPkAtfQ/LQ5M8Uy0rXGPOOLPG7T24+HaHMR1TYGc5CKUzjMBF+MocjWejqxcwNTAdrGE0HCL5ld2NVTqUt/s5MkMbw+ruzZiptSx8u0k/88Oh4OJZNs3XDO43l21YE3UEcuCSCejnDBJsNf8osaehdP5+z3tSn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+XnqttY; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXlG2YU4BBeEmSVJxRK/6h0QVC0Q+hO785WTI/zU5Pvf/WNzeKColp2Tu6P4yZvoNHGvgAclT8dfCwhtk6QUorbCtSNv17rLBmNm3ZYnJ7FeGVDDIJOmBRsBzyhjByrRYtC5Kj/Idbe1+YWvD+VYX+gtz2o6ULX7JewVCGyJjgSEI33zUt1AuqPo9bXIiP47vHZ/cJtLNI2kRAgj0i9uM/4kQzO/6ATMV5EEOpNkULdik9d+YYFoaGEGX/vEWwbkPjuMiJXqG7DcvW9uuyGjCXgamn2vqBPmpOHZBDblyU4xscqgjJWuHHTKHNA0gwk7jH29QYHBEcC+JNPv21XhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owksryRUWHVUTKc9EwdqafuNcbtKA7Z/YWtyFiy6EL4=;
 b=zGvquuxxoJjFesvvx2FqkJu5LyMK9SKhzhBT4RLl62GrrkZxfF4jwLg+XMzUp+b8COhjeyA2jAPd6/BMdiyzIIKCX5ZDdSq15YCr2FVIvdOcKpZZsmJLzLyxrRPKZmrw5T584jVk4AdYeX04PO69B5iWMusXgfSkrnGlZ+ILz63HK9dVsvN+uBLM8/Kwt5zkjAP+ZKCVY9Ik+AGAaai+Xnak+DkWN4O7CgQEUO8WHMNcjgpRefJ8oD+C+7Oe4BdqsLRT3/Vuon7yKsesl4kGrSoin7X6davPb2dtqQ1ZnhTqAiDr9ekLARHqOtCIGyk2UmPyCxjUMVselG8xET/9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owksryRUWHVUTKc9EwdqafuNcbtKA7Z/YWtyFiy6EL4=;
 b=t+XnqttYdALSWCrzHsjfBbDHbKOBhFpehZo5pCB7Icsj8S4NFOR6RlYV1A61SU0hKL2/ohj9vlfr0FscNgT59BDN9dqfboPot4IoK8lr+lCpI0qmTj4aW9a+1UY0hr/WJhjzXcuIDE0fed21Hw6vILqTd7yIcgwr/VQlE3hdEL3VesNMqJme581DJlVAHCpcbJU+W6i6T8+vfdf4kT277wF65gG972fxhXdVNT78v4jNX4pbsYTIXKz+1opp/M9lqpFlzmWOJ8p7/rtgjtCzfKr/IQty5KgNznyBuHNP4JQTC0KRVnxZGRgtxVzm3LYwzgSym1najD/Rge8cJwWqiw==
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Fri, 3 Jan
 2025 19:44:39 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::7e) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 3 Jan 2025 19:44:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:27 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 11/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
Date: Fri, 3 Jan 2025 11:43:34 -0800
Message-ID: <4ce5fe8c59a40fff27b27d7e81fd5d80941f2909.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b49972-e3f6-4ffd-42ae-08dd2c2f0f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXEj2iDSGj4PyBzDAAsUoEOk7MzP8pSTDrMNyNm1PhY9dvIGqW8/kS3NDZ0F?=
 =?us-ascii?Q?+Ym2hJCZIqK+sdXa97sphZQhm7TCc3MDSv2LycBZ0PIyrFkPEtVpjnqmwlLE?=
 =?us-ascii?Q?JXpWooCJh1MQ3qLTUq/2Ohd08YmgUB/6KDggU8Vb/hdZreHYCD+RFSAGD8k8?=
 =?us-ascii?Q?NDljq56m+7Trxeo69D5Dd3WjZNPGfq/sAfsaxyNyqf18RV1f1GMu4O2m+5zk?=
 =?us-ascii?Q?qsTRjaIRmSRhmn64hf0OgeH4KclVVoZwhuQipgGlIn82t1PNUFnSARvORUcB?=
 =?us-ascii?Q?1cV5hpOeIs+2zLZD71/oHbMYdGbYE4JFY0LdcXGndCE1a4MDasGslEAf4R14?=
 =?us-ascii?Q?cDrnYajdhM4KcGzPPfTmNbj2ZCcYOnAtOlYbJv5WK6xa+LsIitvEeo/VrmHf?=
 =?us-ascii?Q?yX+Cy2t+w7/Xpm/I3GH2piF+IULdoHOdEXQZJFIthQ9N1nJuYg2MFyeFxLpm?=
 =?us-ascii?Q?iZJZZH3dvd3nUFC9C8vNU+CTxaEjvmrJf7eIrXcVVc+THSJFwe09F3aipZjT?=
 =?us-ascii?Q?qoEGuD9nclxRH2pbsfsN70kOloe17wt7Js6J9JplKa5/9CRnM/C4PCfwjH1z?=
 =?us-ascii?Q?jRoaBGxrPXkyHObGyDOQI7wSzf4y3R4eWAWUrYSywfKVsaOqTXIFCfBmY4On?=
 =?us-ascii?Q?MoHLjWFD7v+v6hC9U2TWTcWmO2SxGVrIojEXrEpmZfijL1oeDPIvdi/Oae+V?=
 =?us-ascii?Q?vBRzGRsbNkaLZba3Z6jKy/z1HWA9xSg90YSpS7IEsYuvPe3oxcBRlOaoJO50?=
 =?us-ascii?Q?+X30RZcuxtLVzTEJrklu9j22zh5rLHp/uudeZb+JmXuIIWEOYwcPt7fhNLML?=
 =?us-ascii?Q?bif2bwq9sWNSB5DxjXuIjKcXd6DOupqxA/cMZKw6z4xSHHjSnlktyto8piRw?=
 =?us-ascii?Q?1eiVDSYR3B+Q5HlRrxDMDNi9hPN0JftcvqfCRjoaXfFLOnVyZzEa7tg3RL/D?=
 =?us-ascii?Q?FDlR0/7HqbJYTt/Pc3QYhvz7bMIf9T4acRVSv7nHTP6iGz6GNXYgfHvDPboB?=
 =?us-ascii?Q?SpDfPhnNs52yaP6zfCcEMCEFcahTMEOLfCvvnXSx7JliHdvna7m2dHak4QaC?=
 =?us-ascii?Q?YrwZ7HNShVwwspZTklc+qw30i9RtQaqcWKFTwWgmXmXDKAvklsimXqxZH8mi?=
 =?us-ascii?Q?/erLEeYKC9W0KQXzZcZkWlqYQdmeEBJjK2VT4Xt8IAYFbedB4R4ElMzPL8om?=
 =?us-ascii?Q?gc0uyBVt+SQq6otB35GHDh8xpy+EAAd1o9GlLexDla987PbnGvxnaSfJsET6?=
 =?us-ascii?Q?7ao47/IGrbZ23hToDqD3irpJFIyRaGJEAjYSpp42Cf3swaccXFTmNpyiSibB?=
 =?us-ascii?Q?Yv7diIXXLnTj0nuzHVfztD5Rnp1VHKvIEEgwP9eCcVQF18Uw/V05Xiz/ywLL?=
 =?us-ascii?Q?WMRSYul9cjR5JxEJt4eU5LSu8Qe4j0qEG93z7eK5L9TlmvT+ZACGe2c1vNPl?=
 =?us-ascii?Q?UsssLoQwuOWGLmuoq7n/3LHhkRn99EjHOz2d5TClQXw7H30OH0BJJ6wue4bs?=
 =?us-ascii?Q?oPtvy9qvNDBN6Mg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:38.8360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b49972-e3f6-4ffd-42ae-08dd2c2f0f66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

Trigger a vEVENT by feeding an idev ID and validating the returned output
virt_id whether it equals to the value that was set to the vDEVICE.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 65 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  7 ++
 3 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..15cf28b88332 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <stdint.h>
 #include <assert.h>
+#include <poll.h>
 
 #include "../kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
@@ -936,3 +937,67 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
+
+static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
+				   __u32 *veventq_id, __u32 *veventq_fd)
+{
+	struct iommu_veventq_alloc cmd = {
+		.size = sizeof(cmd),
+		.type = type,
+		.viommu_id = viommu_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VEVENTQ_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (veventq_id)
+		*veventq_id = cmd.out_veventq_id;
+	if (veventq_fd)
+		*veventq_fd = cmd.out_veventq_fd;
+	return 0;
+}
+
+#define test_cmd_veventq_alloc(viommu_id, type, veventq_id, veventq_fd) \
+	ASSERT_EQ(0, _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+					     veventq_id, veventq_fd))
+#define test_err_veventq_alloc(_errno, viommu_id, type, veventq_id,     \
+			       veventq_fd)                              \
+	EXPECT_ERRNO(_errno,                                            \
+		     _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+					     veventq_id, veventq_fd))
+
+static int _test_cmd_trigger_vevent(int fd, __u32 dev_id, __u32 event_fd,
+				    __u32 virt_id)
+{
+	struct iommu_test_cmd trigger_vevent_cmd = {
+		.size = sizeof(trigger_vevent_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_VEVENT,
+		.trigger_vevent = {
+			.dev_id = dev_id,
+		},
+	};
+	struct pollfd pollfd = { .fd = event_fd, .events = POLLIN };
+	struct iommu_viommu_event_selftest event;
+	ssize_t bytes;
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+		    &trigger_vevent_cmd);
+	if (ret)
+		return ret;
+
+	ret = poll(&pollfd, 1, 1000);
+	if (ret < 0)
+		return ret;
+
+	bytes = read(event_fd, &event, sizeof(event));
+	if (bytes <= 0)
+		return -EIO;
+
+	return event.virt_id == virt_id ? 0 : -EINVAL;
+}
+
+#define test_cmd_trigger_vevent(dev_id, event_fd, virt_id)                \
+	ASSERT_EQ(0, _test_cmd_trigger_vevent(self->fd, dev_id, event_fd, \
+					      virt_id))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 212e5d62e13d..c225f6e5108d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2774,15 +2774,37 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	uint32_t viommu_id = self->viommu_id;
 	uint32_t dev_id = self->device_id;
 	uint32_t vdev_id = 0;
+	uint32_t veventq_id;
+	uint32_t veventq_fd;
 
 	if (dev_id) {
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     self->nested_hwpt_id);
+
+		test_cmd_veventq_alloc(viommu_id, IOMMU_VEVENTQ_TYPE_SELFTEST,
+				       &veventq_id, &veventq_fd);
+		test_err_veventq_alloc(EEXIST, viommu_id,
+				       IOMMU_VEVENTQ_TYPE_SELFTEST, NULL, NULL);
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_vevent(dev_id, veventq_fd, 0x99);
 		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
 				       &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+
+		/* Try again with 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_vevent(dev_id, veventq_fd, 0x88);
+		close(veventq_fd);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+		test_ioctl_destroy(veventq_id);
 	} else {
 		test_err_vdevice_alloc(ENOENT, viommu_id, dev_id, 0x99, NULL);
 	}
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..99a7f7897bb2 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -620,6 +620,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	};
 	struct iommu_test_hw_info info;
 	uint32_t fault_id, fault_fd;
+	uint32_t veventq_id, veventq_fd;
 	uint32_t fault_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
@@ -692,6 +693,12 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
 		return -1;
 
+	if (_test_cmd_veventq_alloc(self->fd, viommu_id,
+				    IOMMU_VEVENTQ_TYPE_SELFTEST, &veventq_id,
+				    &veventq_fd))
+		return -1;
+	close(veventq_fd);
+
 	return 0;
 }
 
-- 
2.43.0


