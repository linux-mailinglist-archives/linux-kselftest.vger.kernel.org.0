Return-Path: <linux-kselftest+bounces-25149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA5A1BFCD
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5426A3A6101
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93838635C;
	Sat, 25 Jan 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rqh7bQzN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A38F77;
	Sat, 25 Jan 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765085; cv=fail; b=T9VboUhZ0f9qa10+L9DxW85uSPpHp9Pd5MmV0AS1V8E00HHmHloMSuQpoYjJUkDxxN9IZGyEjH/RSpr2KuPfDCVhCY8d991DeyHLgb62PKcNHlLLFR1ySHsKuoaqz0miAHuP1T/XTiXwpHhWOUADOUhbZiHv1JqQaCxeoSISml8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765085; c=relaxed/simple;
	bh=1n+P4yQvLw3bdGD8igYXySUogi0tvQjXiXvb4XEfXCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pjqf1ArYzGKl2X6TugCgoDNOR+g4ujUSqcutghe5mb3NldUiIQAFUyfFBY27nPlpNEI7Cmv/zsDzDjQvrS+QOXRIE6IT9KTBWFpuqQIbt5xxbyuHxfZKksOWZUNwa5wuUUywTeXZ7fbrI/AMGggOWaDr6uh5NFsnFZNKKfjDmAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rqh7bQzN; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh3XL7KiyEzCKDNwItcPYL0Ydd9LmRHieqfSK7AUVFL0zR7R0ojhUJBBg5qh+mVXI3jB3EcnJnTIrimF6Sdumi9vJNLAws8mIFcnIcLZMCebn5Ty6ddVTKmHocxm3jsEAxSVS1Hrnhoc6+R/KEgbqMx8aXFPZSp5hT1sBTbF9TPfkCZv09HyhONJJV71ed+GECS4QuuYIJWYr20dFDJTNQNJg+0FAuqkgo45JRWDvAIhF9enkA8t6vgaDZpiPcr9DWcl4N4UjKqIkCgFL5Nt0RnugB9IC88jfNOsaeqXRVsfmjAjv98XXADKI57MWeHIALBzCUTfUHTHNFv0EdG+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw1IO+TYfzptlpL6FpQu1TMULrbX73SNmd4ZMADYXVI=;
 b=vWuQP5J4kIYZUc28evSTGR11HDB2raxP+eGU5Uy3iv9b81whxDflar303gN1QKkZjMnmOeqLGLXuCdHts1waMRo02pvoLYuRTjkIE4r+YJstgG+ObY8tTlGgBrIRUIZd0AcsZnJ/XYiTlRyCQli+V+tevgwue3Q8WELn8Hap8sFPlsWZFDaIv0OPBi7vVaklUbDOngSz6QGR75O+0ylM/QQAkoR+XXYlFFM5AsjtL3euR1NHOMJra3hDCZggyqzNQR+60IXwwPwuoMeltAqMjMSZAfGnp8ih68AgN20PVWqDMUT1JOSO6N9qJ8/CHb+CWhwaaAHAJmDy/NTPWUASfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw1IO+TYfzptlpL6FpQu1TMULrbX73SNmd4ZMADYXVI=;
 b=Rqh7bQzNAJgbOlp4wsvPRMzxnkXx4k3qnrJLc0RoHY/JTWAiMmLTglqw3HQH3NsBzTj87lquiRQzOMcTet4p0Mx9d75pm7rjef4je4TstpyLi2CljLowK5RTQdft0GODt89MM4qjwY2XG6sqnlQ1mJgG83LjXYsm2NtizRPv8YelLohOzH7T0O03lwXJ1LSM0pG4150EwQLDhAyD2lx4PH8L1gKfnSaYvioSdr7tR1EePBDXn+hDX3lXwnMEzB2l+4kJeWNgmHueWT3SwTs6q/3Y4gT4mzq7bHI/6zTA6nYGrKg85mkrkaY0d2uB5mu85IsDMrOoCVUmOMp8ubsqag==
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 00:31:19 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f6) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Sat,
 25 Jan 2025 00:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:05 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:04 -0800
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
Subject: [PATCH v6 10/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
Date: Fri, 24 Jan 2025 16:30:39 -0800
Message-ID: <272642fc50cef2799ed3a11244bff382696e690c.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d661fb4-c4b7-425d-78a3-08dd3cd795de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8zfm5iEZXqCMEwOwB0SjbJhQCyh/3otV46fQwVP/JpDTfNem3xRoDvHBto9?=
 =?us-ascii?Q?Biq1Y7y4KYVjM1HuWZ6snJZGivwmfLPzRdIAWEC2z0mCfmm/JJj6vlofDKmx?=
 =?us-ascii?Q?zcNuQgwM3UVJxQ/YzlNk+bRloZv3duBQ3xsecp0oyK6HSEeSecMTsmVhDMT5?=
 =?us-ascii?Q?qgv1f/WxRByZT8362XG6pXKboQbUlJa7jiAP3wLv+GR19ZVRC2GSTioi6mGF?=
 =?us-ascii?Q?PgNPmLcUV3Cs6hPzvbCWvVend3oC4LsUt96y0dfWxUtihdwdEmr8zFCM0aVq?=
 =?us-ascii?Q?Bp4pz0JBV5+1EU4WfbzlNi6wWjEj2/tIW5U785M3bmjzM0VfRf2IieFwwyAM?=
 =?us-ascii?Q?3pefkZvMTBfPISn9LtxnLCjvh1VmEPR5ZySWOK+1gcFZ89bVKXsCAX4YvVYS?=
 =?us-ascii?Q?bUdVxCo875zKEaXi3ZtZQrdqvy2kUlUfpX6RKzDf1gWUdSg06FFZv654UjmQ?=
 =?us-ascii?Q?S5eNXzJXNezCZVxWiDJxCkUv4mKNeDT8Z2DqtgISLZNqiZ7U/2+S5IhpN03L?=
 =?us-ascii?Q?swDoDrm52NRO2rNw3hXsdpLXdZsWms1LXBoTKIRiezci3BAuRUGis98d+PkU?=
 =?us-ascii?Q?NA01s20/l03YC5uZ/B78B7fZeb1dGmqGOz0I0RnGgs7adk7XV2DQWFp9PiOd?=
 =?us-ascii?Q?oLH1JeuVeXl/m0lHjNgeohRC8GJ/2W4ZvR9r84AXZvF72vjeUwlfhUY/+hK5?=
 =?us-ascii?Q?NmCUxgrIm+h3ms6l+ZxVUzRlngBZmS6LlAx/3iXFRC27+hx/3d1u+65rceeu?=
 =?us-ascii?Q?Jp298HA6i31e9cOvwlNSsvu3NDHRBkDTGgjDfHpwFsRy1EiMkM9ko67FuW69?=
 =?us-ascii?Q?3pyRZvQGSZNi+Xc028TmHVBiZmEq44Yhj+/u4oa/noFVPLtHFqErhdUqgxzT?=
 =?us-ascii?Q?946l7tyAz0o9AL+dk3pNhcSSaFeDyMqeEZZHmC9Ycvl52NOsTrrGcWmHGLph?=
 =?us-ascii?Q?6rK7PBlGJZcAakHmRZAfzzKnB9F/TxQFAeKx4Kyk6ocbm/jq261i+jn8dzzh?=
 =?us-ascii?Q?Pp5k84ETf+97+fakSaJQjz/ODm0oe8lOzUOv+7GD6F092peyiT5hyGsR9ZLp?=
 =?us-ascii?Q?4MwDOLUOMx9m4/PjBuisrXU0oxzkaVTmtxOn8LQMkGfkWKwW16Tk/33A9f93?=
 =?us-ascii?Q?x/Wts058b5YN+zgqA/IMmW5CRW74AhtS87rS3uZ6scge+xZoBvtCYdpv8Quh?=
 =?us-ascii?Q?HC/yU3+2qjcxTN4iieI2osSjcWHjiTDSRZ6po8euKQbjxPMW4L6T02drIbwA?=
 =?us-ascii?Q?OReCQsAXtxWqxRX5ZRT5Y9MEV4Sio5MlkU+sFsSSkCqhbUJWPEoPJpwdzRpQ?=
 =?us-ascii?Q?8qZ+g0gppXZsbRPjNezhrMmO/qk5ZAREOai/HJJPIS1lmDl9L7tHI90G2lpg?=
 =?us-ascii?Q?tY6fh4Zh+g9Nf9lvxohPQNvz7CjIaZKeAZJhmnWNN002ub/7S5sOhzv56Epk?=
 =?us-ascii?Q?EJBpnFsXIDIkMKWObjyKMHx4ul2LtHBZx2I/Qfr4gMNMgE2FxCaXIjfkEMqC?=
 =?us-ascii?Q?kXhKWpZJBDCnFGs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:18.6342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d661fb4-c4b7-425d-78a3-08dd3cd795de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

Trigger vEVENTs by feeding an idev ID and validating the returned output
virt_ids whether they equal to the value that was set to the vDEVICE.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 115 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  31 +++++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 ++
 3 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..38ff1c51dd97 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <stdint.h>
 #include <assert.h>
+#include <poll.h>
 
 #include "../kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
@@ -936,3 +937,117 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
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
+		.veventq_depth = 2,
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
+static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
+{
+	struct iommu_test_cmd trigger_vevent_cmd = {
+		.size = sizeof(trigger_vevent_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_VEVENT,
+		.trigger_vevent = {
+			.dev_id = dev_id,
+		},
+	};
+	int ret;
+
+	while (nvevents--) {
+		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+			    &trigger_vevent_cmd);
+		if (ret < 0)
+			return -1;
+	}
+	return ret;
+}
+
+#define test_cmd_trigger_vevents(dev_id, nvevents) \
+	ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id, nvevents))
+
+static int _test_cmd_read_vevents(int fd, __u32 event_fd, __u32 nvevents,
+				  __u32 virt_id, int *prev_seq)
+{
+	struct pollfd pollfd = { .fd = event_fd, .events = POLLIN };
+	struct iommu_viommu_event_selftest *event;
+	struct iommufd_vevent_header *hdr;
+	ssize_t bytes;
+	void *data;
+	int ret, i;
+
+	ret = poll(&pollfd, 1, 1000);
+	if (ret < 0)
+		return -1;
+
+	data = calloc(nvevents, sizeof(*hdr) + sizeof(*event));
+	if (!data) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	bytes = read(event_fd, data,
+		     nvevents * (sizeof(*hdr) + sizeof(*event)));
+	if (bytes <= 0) {
+		errno = EFAULT;
+		ret = -1;
+		goto out_free;
+	}
+
+	for (i = 0; i < nvevents; i++) {
+		hdr = data + i * (sizeof(*hdr) + sizeof(*event));
+
+		if (hdr->flags & IOMMU_VEVENTQ_FLAG_OVERFLOW ||
+		    hdr->sequence - *prev_seq > 1) {
+			*prev_seq = hdr->sequence;
+			errno = EOVERFLOW;
+			ret = -1;
+			goto out_free;
+		}
+		*prev_seq = hdr->sequence;
+		event = data + sizeof(*hdr);
+		if (event->virt_id != virt_id) {
+			errno = EINVAL;
+			ret = -1;
+			goto out_free;
+		}
+	}
+
+	ret = 0;
+out_free:
+	free(data);
+	return ret;
+}
+
+#define test_cmd_read_vevents(event_fd, nvevents, virt_id, prev_seq)      \
+	ASSERT_EQ(0, _test_cmd_read_vevents(self->fd, event_fd, nvevents, \
+					    virt_id, prev_seq))
+#define test_err_read_vevents(_errno, event_fd, nvevents, virt_id, prev_seq) \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_read_vevents(self->fd, event_fd, nvevents,    \
+					    virt_id, prev_seq))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 212e5d62e13d..dd453aae8fed 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2774,15 +2774,46 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	uint32_t viommu_id = self->viommu_id;
 	uint32_t dev_id = self->device_id;
 	uint32_t vdev_id = 0;
+	uint32_t veventq_id;
+	uint32_t veventq_fd;
+	int prev_seq = -1;
 
 	if (dev_id) {
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     self->nested_hwpt_id);
+
+		/* Allocate a vEVENTQ with veventq_depth=2 */
+		test_cmd_veventq_alloc(viommu_id, IOMMU_VEVENTQ_TYPE_SELFTEST,
+				       &veventq_id, &veventq_fd);
+		test_err_veventq_alloc(EEXIST, viommu_id,
+				       IOMMU_VEVENTQ_TYPE_SELFTEST, NULL, NULL);
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_vevents(dev_id, 1);
+		test_cmd_read_vevents(veventq_fd, 1, 0x99, &prev_seq);
 		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
 				       &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+
+		/* Try again with 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		/* Trigger an overflow with three events */
+		test_cmd_trigger_vevents(dev_id, 3);
+		test_err_read_vevents(EOVERFLOW, veventq_fd, 3, 0x88,
+				      &prev_seq);
+		/* Overflow must be gone after the previous reads */
+		test_cmd_trigger_vevents(dev_id, 1);
+		test_cmd_read_vevents(veventq_fd, 1, 0x88, &prev_seq);
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


