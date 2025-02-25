Return-Path: <linux-kselftest+bounces-27504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1423AA44833
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32E81898B53
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912620F087;
	Tue, 25 Feb 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kx6C7yS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21E1A01CC;
	Tue, 25 Feb 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504391; cv=fail; b=IlpyIv+UsR3JWFp8RsQAth0aSPx53cRZC31HVI0PLfhXxifwyHGlENSmLQ5j5I6RdjcQfw4f6gfSRNqXwKMVIQwCRGDY5DdcoKQXvOecL853RKNrDvR8uGHx8SMB50avx+pM1iV7Dc5g+0oZrmRggd5JWaWmOuaCIdq0NYXEB9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504391; c=relaxed/simple;
	bh=yJvub6Tg6pAbLvjjlP9rJ+GPjEemqPPrDlsYUpAU7Zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwzO/gULHbxBy0EEGjvWVFiVhHw+uD5rmZyQrKpOUOi8ID9PpWmkFOA/319U+2pjbEmPG7Ziq4B72VTdYt34KLa+G+TtPtj9583t+KsU1fJy2BcZqYiWL9m+nKffaO1NbkebWDYrFdn/oU2OzAPSGOZhZ0UMxUw8P4l5x9XX/lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kx6C7yS3; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuwbvznDRpT7i+HroDogqFq2ZxwZ8bjhdcpUqBSjnR0E9GUFzDb4dilVS0AWNX1HbXmM1nIRn9TaTS4ccbiXV7wiN7R+p+ZnIctMh6Mw68+I3KYDHtvbFeniP3N81t03Abwi+HX+b0uemm0tkeqk8HhanODUoUZMyG6Gyp9nmCgFwwx5SF0Py9i8OvQJcjfWnW7FtBYbs0ua4YmI/HTyjPVXmKoHhXtWuEzv3bXqtkiPB3XEfxUH3rIlSaQ/GmnrLE0AgDk+r1vh4VQZP38pgsyzt7GObPZXCykcPlpS+IyHs/q7SyplltzUFD/96nIQitzvi6ikVzFOSD+O2bRSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0kbEzCCBCwfliZYSwakktJXjjge9xvLJvx1Yf2MNKE=;
 b=NoiF9IPl8TDXJEH2OccCBT/2OcDhpNN5wrmjKnFdsupJkueclqQWKXqSWsFVltHWJuTFpGrXfPrxo7ORfnrR/wiqhmpKXjdKCQUI2kQ+6SUP9YYS0+wRNFU0meNi6YuLRLaeETkwbAl/0x7ATFVInrZ/shJ5kMTlDKLKXRaYyxTE6gf8zzG5ob0mcVDqEkV4k+gCjO/1twOjQ/UKlggP8ESsliMUOMKQmYSHqmLAzmSYHiyS7Xgk7SZtEqxgFkPJaA76AeiFFElBPe/sIO136ZPDE08GZJgmVZCf7pYDmnDgq8z4SvMaUv2txtXd+L9brhmq2I54+4Oa0Xk47j1KfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0kbEzCCBCwfliZYSwakktJXjjge9xvLJvx1Yf2MNKE=;
 b=Kx6C7yS3TPhrvaopyXuWWkOnOC3es51zP9nS5LISw2CTFqVtRl97xSBLNgmZ6jc8N7PaNb5yCFIklGUS+VzpZCqlCpjOXG9blBXr22KKlqMLYihWup1YzanQBoMm3A0lIqIcbc+xR4ywU0wD0pOc5W6t9msqCnwCVSMT3QQr+QVA+kq5LHNTfb0FZSEau/n1i3UkHTWn670WGF8mZS98wBcJjcpHrqEEjL2AKpdiQwqX3fy2vWHSFUuv4ggs1Ntl7ij3Muolv3ECoh/nmUu25zNBBUPYaF0jJj7cE9wmSY4YEuDnN+XCGiWHz+qr0gy/WVBbk6bHdwElhPX8ddjpKA==
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 17:26:21 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::cf) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 17:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 10/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
Date: Tue, 25 Feb 2025 09:25:38 -0800
Message-ID: <88aec1b97268ad9edfeced1567c61bf8fda69a90.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f984ed8-09f9-432b-c58a-08dd55c18583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EGY0RTkYd7K8VZDiPc/VCUBCVmLagx58W00QN3YdcU/d1m3vXTKAiq/BDakO?=
 =?us-ascii?Q?nNet4be93HVs5fMICju5VQ3Xue5Eq3p02eP5YGty66ZDAkC/lAGzSwT8FQPh?=
 =?us-ascii?Q?zl9kgITJrDHaPYWMUiePp3e+ivIXCpn+HNJWD6z/d6fngQwT1upKpGRczWBe?=
 =?us-ascii?Q?aH1+lH3fkD78XZ3SQKpjXRxfGx/l+BrhEmVu0qtTxDKCrqva3qub2xB2NnbN?=
 =?us-ascii?Q?ubXctIHIZnOitN/T0H3aAkerOeoFbvfBhjUB75EgrYeAY5paNg9O7jyhQCKR?=
 =?us-ascii?Q?CoHoE/wHYlxEd8AUQniXODq5/eyI6F+1nWExDRuwzPDWkftvNY66zTEvaT5Q?=
 =?us-ascii?Q?kDH4ruHLE3N8esJqOUH2x2cXK9pCSMvPKpgKsLb3nF8qub/LkeQfAQZw016n?=
 =?us-ascii?Q?ZVrcecWw3nz4mJnhFVUF60Jqu5JwlFovoWctePeOO1B2T7VbZ/Jw+fb8u3lT?=
 =?us-ascii?Q?nsEjdByVBQ8aaGaZIUbSOv+CM+lbOlsvhRNsgeFjsFdwmAp2cmqsMMKwAUNz?=
 =?us-ascii?Q?lAwo9I/chKvQQxHKqtAqMy4bx/0RJEFGPtIxV0GjLJNbsVY4yNAZuLDoo95V?=
 =?us-ascii?Q?davOHY35QDd0ZomCnh8M2QeJdPObKW4r9KKBmTDLtgD78GBWuLGvVJr8wPee?=
 =?us-ascii?Q?k+Z2yqQzRejGANWiv1Kd91GthQgAfEHadNRcm2wZ40E1jKbYpYBk95IfZmOd?=
 =?us-ascii?Q?WoF3loysp1LOaRQAOV0eBrGGnmpAPcmIIdO3XLUPxXAih2lgzI6XwrwYwBRM?=
 =?us-ascii?Q?63ziFvgxGz5jGDZ1xIw39Oryb4ObC3ZEpomdC3wjlRsvWxGCbE1bFBV1GcG3?=
 =?us-ascii?Q?tOfDIOAsQ89BiGLIkcLvcB3K6CWbYxUyKpDi5iOaLWPk71EJ0GGPte8cQn93?=
 =?us-ascii?Q?UwYvJ/r216opG7n9ivpoIwxYSRC2xDeN3EJIvsv9XzfvX5eiQV2/A0kJnok4?=
 =?us-ascii?Q?yGv7ze65ls+WsVLPUyg/by0zJToH+lIREtYJ8OURUx4h0a50Skkut0sktBbh?=
 =?us-ascii?Q?xGfzncaG7sq38PFeInKSZ5af0k68F4HnezCBmQ17lzVQwD+zCPxN5gkkMNYc?=
 =?us-ascii?Q?JRgHjov9Zt24hHQexC2fKqu8Qd79XRw3J0ffF6mCJNyAC14/peof50X9XtSj?=
 =?us-ascii?Q?lsktAYA/OTLH1eRbImXvApXDWm+6RsTY9gXe3dijb30esQwxXAgXZg0i2j5I?=
 =?us-ascii?Q?qdenJlJe86g8/l9iYj8sCfe7R9sVXq0xv/rMCxmBOgjVCYuax/D73YGUuHP6?=
 =?us-ascii?Q?lZBuHUob+LrwaxONsHpKwozq+YL3Y2aS/fNpQrN2M6UfbW/wW6hBlyd6OY8V?=
 =?us-ascii?Q?pNLv8rbrajGSgVCAoPMvJh+s03Hr+79YakK/1vF0y1a+otaGmY6SA2CtCcuG?=
 =?us-ascii?Q?KTXSBJKZMfGroiwqXBQCTGzp8A+g7AT43bqnZ+T5F67tc/mX/WGxpckcu7sa?=
 =?us-ascii?Q?qFqzkpN4Cy4dYR6haLJhFFrIN6mhCKZHY3OGbuK8WNjWMe2GsoUJmd3SCimB?=
 =?us-ascii?Q?Cwf0CpIZPsPBPRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:21.1814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f984ed8-09f9-432b-c58a-08dd55c18583
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

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


