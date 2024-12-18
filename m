Return-Path: <linux-kselftest+bounces-23490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEEF9F5E22
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE490169B5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A718A956;
	Wed, 18 Dec 2024 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KaSUh3a+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69569184545;
	Wed, 18 Dec 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498120; cv=fail; b=K9lWPCuQURFIUx9UDdKEacDdbRjWGwifohRVzDGW0jOY5xhpvhqY2UTBsFfiqQgbgjyZ/f2aQ5wFcVM9xGkFP/xJhIiuLFbEUxbhxJoG30ZDpiND/VaNrn+WoNfbLFzqT2Cvr8uFO7V7siyJUxmMla/T4g51snT+gZnnMD2SOIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498120; c=relaxed/simple;
	bh=qi8b2hUWa2DAYwDJBOjJb/6IkURCGj4mWZTWrRs26d8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDJvKmZ9niV/vKbZ+1qrehyQxQuFxFQirTrj1F4ZRYZynw7OeSH40JD51ykbc3aLkBfSA98IoRABWrFx9oQUxWwO404pYZyk5wMfKgmmORWCr/L2NZczuUmmrOFvLG4r+aRNDqNY3jGP5a5/QPTxUsCTx5c5Ciye8YgtZkBYPNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KaSUh3a+; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsOyqtGQLb5IRJ43Bv4TrLL2bPMmqJDG+DCSsznpsMaeuTrG5TIH/3WTFm5wSE7Z/hpeZeRi71UR/L56+YVYZb7EAg4eXnjL45JHL2KbmB4VsUOjki+MOPDNNYfCklT4IbbngkOEAb5y8gSJ+vBSEn4knEl/DUs1+yKdhoZfrrlDxDQlxEMB+RyKepsTQwmF0HbuNHMrfdYYxsk9az3FOVwsB7DgKgx42O2t8V70YUXEehe11gno+pBwjmZUh4G/BqbAM7P0WY7vAogDMs5wRKzUCtFGHTS0DyRMjxgivLuY2xp8s6v2jY0KHE12o8zSzPqiPfQn3jQWDB08jrNUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG5nlfWKfMmKb/gvqCFCJfCXwm4BIDxeLahO6rvhpqM=;
 b=fVF4PNEqm3LXzNCg+PhkczTcIDOQq7qea6967TJjjk/7xuPCykRbVxRKqoFulN9noeb0Df9Y54umwQZxLAmj0s7sUZD4zODHY3sRcsa39fu6go4z+IxLfl90TLg0g9rfzljvq0256pv+yk1VqvMdqJRvIrIk55mKjkxkXldn8axj7PJvrzhi85w7KFl/f1I6lFzS9n8GYm3Vtcj2tUjBT7FLApSr7MuF1nepIlkkqv0yfdfBLhPDZJvJ3l2gDO0cN07aSTw+1r5RItGloE9epRZ7Kdk7qyiQc4lOgPWZnGoUXT8heKQ3X9nMy9QPXZP5uZ6q9Xe01NqoqGjC8SfgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG5nlfWKfMmKb/gvqCFCJfCXwm4BIDxeLahO6rvhpqM=;
 b=KaSUh3a+lmrvW08j+S+nfx1n4l6ApM9u5E9zwuNlrQfywwZMU/GJLyMDh8dx57Rvq0ayXZVikSIyBA9QJLhqgh6nt/6PG1DKUESc6otlACVGpFZntJ8xMrDFWJQjfV0XAbnhoBCs9vbJyUHXCXLAfQXjpGnC3jn1p/tk3lqSISnJESyJqdql8BZlKhbN9zWu62w7aVdsOF/yP1/ULkGWxuLjFTFdKkmBBT8R9SW8pYO2FcUyKxY96J/1lBiBLRsqJxpHeeot+fDw4V+TlhCva4eIJwsi5hKvLTXpUaE1LCRasvRKSgnQBGkBOjsURp7ei2+FgXHX9QKOGUeeVlO+9A==
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Wed, 18 Dec
 2024 05:01:54 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::91) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 05:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:40 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:40 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 11/14] iommufd/selftest: Add IOMMU_VIRQ_ALLOC test coverage
Date: Tue, 17 Dec 2024 21:00:24 -0800
Message-ID: <6421cf753e6084c872e337e8c5df8a5acb20f050.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ba5c72-562e-4bf2-8d98-08dd1f21173f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ij8iO7IUxzOwKRji/nWatYTZVfYTcFXD0RPBYvie9Pe/skPYwc8wClChiJ36?=
 =?us-ascii?Q?yUKW7Ik8w/9J330JyfUZcg2Z03aeaH8qCfQT/RhuSnSaNhn5Q95hDq7IP5CW?=
 =?us-ascii?Q?OWHvllryyp3vz/w3xLDBKuO5Jy1uyGfClv5WgffNHku0jZd9tVfVjUmv9zXo?=
 =?us-ascii?Q?uSkJXn9LiMOCiiQ9RAVXtr6H6mba5wCyRFd3VtWh+G1USkBAk72AAAJQqkhX?=
 =?us-ascii?Q?IX4uw/MB9GJBCPEhtpg3f75Bu8UOKUUwMG//ziknuVIwUYeLNOGfLnWKVJJ7?=
 =?us-ascii?Q?3ToyQiAMVsjfK4vgJPj7dCKKs1BSv7pb8LUJvV0b7mWMcrAH6LzbFDMGlzjq?=
 =?us-ascii?Q?HnGjMs9rqk3perxLfvNYoGGSz2JBH5vyXHMfZlIqW+9K+TfWqwljxL3nP+Us?=
 =?us-ascii?Q?amE/bDl2qu2MNw1DpgSfuaq/DFYzkwE4+CaTPYh6/s72tVnsgyv2FIGKXrq5?=
 =?us-ascii?Q?VyeK/yIDvNWLdWJJqc3xMQuAJZRhTMGAOgbqZFAynH2UtQPdJLW/+zFC7w8a?=
 =?us-ascii?Q?1yO8ow7r8pbXMhznhXvLuFVtMwZ/5C0hhXJOi7mKl0BoW0OwrnGZxdQuw6uB?=
 =?us-ascii?Q?NIAfU17vrdBdajwe67NcElVo+zwsRNlJQV+EA+vEaynQPzFl9bhRg024ZkxU?=
 =?us-ascii?Q?asKfG5gVsX/zRtKkeBmw4LpdqAYi3fEm3iAwFNLdczslmVsfPKT/tyLixk8Q?=
 =?us-ascii?Q?iFJIkThxEnVtQrjVjgpV56bLcVIwHtOwl+I9xhvqML4RSOL48TAvBSiAtHPA?=
 =?us-ascii?Q?7zs9kGihhbJgxPudnyEWInhmiWpHsWV4e920uy0xMq6nO2FvfV3mbZxAjbyM?=
 =?us-ascii?Q?EwlnEB9RH2zbrWip/R7GZpw+vUDvz33zZqiyNTUPXnMD9bB6/AX+QFoJi/oQ?=
 =?us-ascii?Q?JCtgB4nO2kFXPHA63rPo4Y7aOADDlSeEOHstZkHqmFODTbcZPsOJfI50qvkZ?=
 =?us-ascii?Q?odTG+JMpcq6TaWrcVKX41tyWxTZRS3JX8frK5zZoouHEjwclbjSluA3K7yg+?=
 =?us-ascii?Q?wjSotN63FagwKbGXrKT6/57MykcQZQblIPFjwmuem6CR5UPiG0soGvjzFWry?=
 =?us-ascii?Q?t6D+YdYF+IGxhXiGDC4HpEPn+svXfx0mV5I4YXMYouC7lD0CW0HwPZb0jsFG?=
 =?us-ascii?Q?BAQn+we5nDhXLn6ZWsjAd6+l3NJnA96QQD7VfHfOwQmq9affH/p2fr9JOnVw?=
 =?us-ascii?Q?YHfi4AAa/SCsj+UNhusswEQiimlY7n5Ygamr45ugVPHGPrfjf4bBkgm0Vipn?=
 =?us-ascii?Q?hdFgPx41eqgVVPU40XqehQZIhQdvucKzYMK9pwaCUQMmm04AWUhv61vM0mBI?=
 =?us-ascii?Q?3FnFogh3ssc8Dn5Bb+OPHQ/DRWrChigbTupB+xtYSC4sbMMS48GyYKXCxxYl?=
 =?us-ascii?Q?zXAbWCkYOqiLGc9tqkidhKnpMmz3r0jGs4IHPj6Mo17LmjuOYbtLS/WWOqLR?=
 =?us-ascii?Q?02VsKVNmKIbwGHu+NIXvLZmWgeKVuZ++45ujLi2C6cHLfEEWDKeaChqD/Vbg?=
 =?us-ascii?Q?baYmaIbnT2VhsEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:53.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba5c72-562e-4bf2-8d98-08dd1f21173f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

Trigger a vIRQ giving an idev ID, to test the loopback whether receiving
or not the vdev_id that was set to the idev by the line above.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 63 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 3 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..9f03955cb198 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <stdint.h>
 #include <assert.h>
+#include <poll.h>
 
 #include "../kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
@@ -936,3 +937,65 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
+
+static int _test_cmd_virq_alloc(int fd, __u32 viommu_id, __u32 type,
+				__u32 *virq_id, __u32 *virq_fd)
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
+#define test_cmd_virq_alloc(viommu_id, type, virq_id, virq_fd)                \
+	ASSERT_EQ(0, _test_cmd_virq_alloc(self->fd, viommu_id, type, virq_id, \
+					  virq_fd))
+#define test_err_virq_alloc(_errno, viommu_id, type, virq_id, virq_fd)       \
+	EXPECT_ERRNO(_errno, _test_cmd_virq_alloc(self->fd, viommu_id, type, \
+						  virq_id, virq_fd))
+
+static int _test_cmd_trigger_virq(int fd, __u32 dev_id, __u32 event_fd,
+				  __u32 virt_id)
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
+	return irq.virt_id == virt_id ? 0 : -EINVAL;
+}
+
+#define test_cmd_trigger_virq(dev_id, event_fd, vdev_id) \
+	ASSERT_EQ(0,                                     \
+		  _test_cmd_trigger_virq(self->fd, dev_id, event_fd, vdev_id))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 212e5d62e13d..b15ebc963e56 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2774,15 +2774,37 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	uint32_t viommu_id = self->viommu_id;
 	uint32_t dev_id = self->device_id;
 	uint32_t vdev_id = 0;
+	uint32_t virq_id;
+	uint32_t virq_fd;
 
 	if (dev_id) {
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     self->nested_hwpt_id);
+
+		test_cmd_virq_alloc(viommu_id, IOMMU_VIRQ_TYPE_SELFTEST,
+				    &virq_id, &virq_fd);
+		test_err_virq_alloc(EEXIST, viommu_id, IOMMU_VIRQ_TYPE_SELFTEST,
+				    NULL, NULL);
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_virq(dev_id, virq_fd, 0x99);
 		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
 				       &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+
+		/* Try again with 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_virq(dev_id, virq_fd, 0x88);
+		close(virq_fd);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+		test_ioctl_destroy(virq_id);
 	} else {
 		test_err_vdevice_alloc(ENOENT, viommu_id, dev_id, 0x99, NULL);
 	}
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..442442de3a75 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -620,6 +620,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	};
 	struct iommu_test_hw_info info;
 	uint32_t fault_id, fault_fd;
+	uint32_t virq_id, virq_fd;
 	uint32_t fault_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
@@ -692,6 +693,11 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
 		return -1;
 
+	if (_test_cmd_virq_alloc(self->fd, viommu_id, IOMMU_VIRQ_TYPE_SELFTEST,
+				 &virq_id, &virq_fd))
+		return -1;
+	close(virq_fd);
+
 	return 0;
 }
 
-- 
2.43.0


