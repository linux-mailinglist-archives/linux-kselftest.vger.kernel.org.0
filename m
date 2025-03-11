Return-Path: <linux-kselftest+bounces-28774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31CEA5CFC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B53D3ABA64
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B6266185;
	Tue, 11 Mar 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9T/D2pP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98C26563F;
	Tue, 11 Mar 2025 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722344; cv=fail; b=hseDUeZPl5ddzEqXjdhlo6vhqn4UuruclPLmi2ANFOSFZsZhavwTT8hbTiZ/b+t1t5CXTJL/ecnAyOPHr6h+mb2zQPex9D/94cwt03i+gbWYurJwYOh/L39Ny9VpkOH0Pk9TZxY6WTrt5eexx1KFkATuLkCjQrXS/MyLDeNoySo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722344; c=relaxed/simple;
	bh=tRYJCCFvhIacHXjGdlPeItjHV65D5D1UCvosSO79buM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaAWyH1NnYoFaJxDAyj0MxFL9Gd4GX2I+ed28lmTjEBSwXd7/SEEbA4O94GS6jnYVysAhHJ2v+x4V7hvz40mrIqiap/p2jP2nWAdY09W5rtm1hh8NwAFYtR1qKxTMw9IgsIL69z0WMRxpnjxs8olf86breFIiuSOQjs0rQoPoh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9T/D2pP; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVw9bvyUJ2U/biJKV0wPYGgADjpKLzsc4EObgNFxoF7D8fuHUvWu+Baw/8Bj14GN9dp/V4yBKU6Bu2QHeUGmImDES/tHTDLO4wVt2HykfribSJ8PvscXZ7zpm9P/SWjcu+oss633NFLWL03Yvd5hbvLNdCRZOU/AIoUs0gUppeLXAM+hSbGv4UKfQMnBfP6fhDZXktsyIzt+5BSl35zgz3ef+v6VzpBG52cO/QXEvDnCSX3TTSprtr7tUENR/DxONSrMl+PIpX1R6crqExH03vZzOVgblrNFDLstK1p9sxrdtr9ViRwZKkSTFya0TMRPtiK4jZm9LBCTrKoCVvs7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw8rSg19CPvQqWMnLhEZewZ9Znz6mXPmTLN1e7/ARog=;
 b=lVjAy91IqMKeB2d4ZXiijxCBvBaFDaPLMH41jOqoTPHjhuU5h1H4HtDyme9Fple+b8OrfYGyYC5df656V7G4Y5myXwn91UrOv/E61SG1h1UfiYJzeGhXkMWZ75VhDesmeDhuY+RjASmfhVlyYtoqcen7nXSFNve7VYcARpLt6AtbioWCSfm5EolFNR6ZwsGuQ3fUI9QIaMRMxSptp0SWVEG14DSCiOcmyPxvNX7A/v9JObrY1TJjTKa3EH90WA+TeR7cAuQ7ojHFiBEbvot/h9G2pPKqh+1neoLEJj6YPy+zPs9jCfCooUBLJJ5wEp/ngpbNtGIBDj1pImRe389x1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw8rSg19CPvQqWMnLhEZewZ9Znz6mXPmTLN1e7/ARog=;
 b=K9T/D2pPvnZD2eF4sek3I7iionTDWXnjgilV8A8ZchO77D7Ac/T57u36/H3l/e7lll3tUPNx64Pz7cACcc/7gDH2cJ9QNR0k6z8rSzXwr81T4vgrfQOIA7TcbkQ8OAp8B+ePxJxzXEk22HZhtxIoD4HXXfgMlPXLSWXSUCkDUcgr5h6aTsW4Ri6/CEQVW6c5u8y5/seREfXiqaSON7FBr1H7LOxSr4mUm0vNZiEqLi938CcOXsTX+7dQpmbMPxtoYNYd7pHlwX+z4TuhfVOrPRold1eXKU7kUBJ4oYQ+OMVnLsFzboyYkQzR4Ax+ygbjkSJYUArV5dkdP1gRswJHvQ==
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:36 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::c9) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Tue,
 11 Mar 2025 19:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 10/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
Date: Tue, 11 Mar 2025 12:44:28 -0700
Message-ID: <e829532ec0a3927d61161b7674b20e731ecd495b.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: afce3cea-024e-4c86-d3b5-08dd60d54b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HSSjdSBs32MHJATQtMLPP34y/T7CEB6X+DVjr63IjwR1iWzlH2zh6u5lO+wH?=
 =?us-ascii?Q?yJCfit9EEGfY+qmQQjNNKQh19ZiKi+oVGQjPcUcsb3qsxY7rqX11U/uA5kaX?=
 =?us-ascii?Q?uBC97jGF56yvddKaU7KdUZ8PWzoIiMgXapq4+2uaGLErb+7qhyTYPs1fVDJ7?=
 =?us-ascii?Q?tiRR/R8TKHSF/CYCjGXnL5bW1/VAF9Uiqmijqp2mjFkc3BzLVqh9qdgIwKmj?=
 =?us-ascii?Q?6ntPl74FI8VkUarIlsm2aXrah0U4qfyA04g4JssfrxA2brDiGLVljHbKPqEv?=
 =?us-ascii?Q?w81cYcFhIfStss+Q9aG0hMbgE8vOGMPM6rdc7QizVCydUNXFSmTI1LjUYzlO?=
 =?us-ascii?Q?hz5a6kmZHsmWbIqj4vIVpKDOVWumeJzSPjeGL12Wmsz4lNodxU0AhCypufVr?=
 =?us-ascii?Q?+ilSTEhugimoFMYK+U27aI9p6SGCVH5xOlXz5Mgd/I+wXctJyAjR03BJbwGF?=
 =?us-ascii?Q?66zZQbIIBIBk9krqFBXHDE6glVCu3QmbAy9LnhHwNSY//4I/W6rfj3pwkIPq?=
 =?us-ascii?Q?f2gPOB2PEJ4qxqegtLX4SZ0vslG24K7FE3izg1QpO19pQVdvUnUaK59Kqscx?=
 =?us-ascii?Q?wgo6btOhekl+hdm4QJaTrbcT0A0HMp/uAMJTIBgAxc3v+DSYrDGwYNWacZQz?=
 =?us-ascii?Q?7t9lMBPpMZq9FJgv+lhSiUKyj6AsKzT+zzqybXHebH4THgsq+4taPXCaQ1IB?=
 =?us-ascii?Q?0FUooeQJz+86Fqw8AcvsN99rjOgY2qbgC4F4euKODIvngrbk8Hnuxi4hP38V?=
 =?us-ascii?Q?8EyK3OwEoPofJhDzI2huabBa6WY54il+mtmX7T6tGDObJr+9xTeUIHJmig/B?=
 =?us-ascii?Q?bhKlbEDviOFYiubSL+eDNEXtOknxI8SkCRe0dtlOXSPfG8oo/0AMPsrab1JG?=
 =?us-ascii?Q?DglL2palegMQbbyAv13XDPfA58CDBmNhzlB8utV9oRi4Ftcv2vGZBP8NXNep?=
 =?us-ascii?Q?NJSTawGCsJugh7QNhEVxofMiVEs5mpe/oZB8/MAfEDig4m/5oI1+pGFMGgYt?=
 =?us-ascii?Q?z1lfLdJYA14ZQr67JK5knLzqz2AGm9VKPFm+LCixy7KHWTrJhpZL/HJpAtWI?=
 =?us-ascii?Q?20P6a6Oj8RDldsHVWRyIe/21ANzDOJZ/SnWnAOqNtVno3DpyI0XizStojzer?=
 =?us-ascii?Q?04aI2QBkttWHfw6vKdUx91j8eir5Cfe5RAuuXsQtVB7a9beZ4rbzB+LBUKj2?=
 =?us-ascii?Q?nowDjSwD8WJSAuZNxRDQwZZ8of7Y/2XsW2YElESScJOc5QumZ7NyDbrAUVFw?=
 =?us-ascii?Q?7ckEGyQOUDvusfUfzt+C0U8XRJma4y49Rs/WLYeTHZLQ+W2OiwJtuvbq6/H4?=
 =?us-ascii?Q?bgdMdBO/A0vkOxysqCq83rIxb2cb3ZIWx4GM2A1TDhGRyEfIJBovu2a2iXEl?=
 =?us-ascii?Q?9Xtgo20tM9ZB0hItxrIImcnvFDGZF0D2buYq4A8cXdZfN31FahzuXIExbopr?=
 =?us-ascii?Q?66/Rk8de5m4ofZpeTGryUHlSYkV4DA7P8T0a56ZARZ45CA3+eTL/JVhQjAul?=
 =?us-ascii?Q?hz/5DwX2T4FvviE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:36.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afce3cea-024e-4c86-d3b5-08dd60d54b2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

Trigger vEVENTs by feeding an idev ID and validating the returned output
virt_ids whether they equal to the value that was set to the vDEVICE.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 115 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  31 +++++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 ++
 3 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..6f2ba2fa8f76 100644
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
+		if (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS ||
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
index 6a050a1d64ed..156c74da53cd 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2778,15 +2778,46 @@ TEST_F(iommufd_viommu, vdevice_alloc)
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


