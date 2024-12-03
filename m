Return-Path: <linux-kselftest+bounces-22790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C259E2ED0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5005167074
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0E20C039;
	Tue,  3 Dec 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5vGL3jh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EF20B21D;
	Tue,  3 Dec 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263869; cv=fail; b=LVsxjDoWdYeBtII7WkUuJQMuJDmxyAmVpLWkteKIDu0BErbvz4xERb2rNYZHkM2SmsYr6YEfSjmyBoW8MLLd6RNfv96efkhJaaYTHk52arPs8+pqMP2p7w8Hg6bsdSHpeJP0A663jcBMW8U4OYyDV1N9smBqh9ChUtF+ozQ/AQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263869; c=relaxed/simple;
	bh=GQSOfuvCeMFKqXB+f2pmSDLmGIZ2V/k/uR7UsZzk9SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJ54O4tjMyFvhbPUCIasf0b7DyK9OQS7aaVCDg0/MiSvRtw7R8fpPjle0jBjIj18iLyZMUjxTNG6VXdIxfLY2Cvw6/MIfqMIZgvnoOjUanbudFFRiIAByvPeuTowHKn9QtA4Vf8B9Cuo2xG3DIqEOhQ9hPsYWMq8sMB2Z4WSvOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5vGL3jh; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cap9eBn58r7t7gDo83IOTZk9qKZjjhMGlA5hlmvN+7pYtWfxLGjJXSokSgvuMZd2qm+UVsNA+i2fvhkPVT2nftZ9K+7VdWCIkN8C/eetoN1/GVbCBumMtuaTv6TMYPdJ3GoB3p/phTZn8r6pkkyjA/ro7sOl8r4AE1L9uBL8ex+5WFyLB3MuMAJtMRWOMWNoDDC8rI8710FFZMVE0jFTWsJCQo25NkqHtt87Vpsw5LwyUyBpIuN4IqhnDItsOtYgCTMLa7DfsU4AteAPTL/FroZfiHu+oixkoWR9whUfROKcsV4Hyge4gQZmhyZv/PK/iPKOjZnG4dg+jvitcQcK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tPMlsnsiNxkxqZsUMBt+pn+Y4xE0q86l8X7m+9ezis=;
 b=RHpfEXqxyhv9ecOTdkv2mrziChoL9QNoqOHXxMYRzvQyP8Ecujy3aJNd56P3vssvTKb7y30FlxAdbRd18sPuEksYslPWw2eX6m2EAfkYiFTCflE00MttZVdAByD+B2BPxvs+acrjBt/m2vIIUglr2CsFB82RJH6ONe9rFgBxxN+crdccfQF8ZT8ZZOFHpnNw++0RbEOuHgAFIG9fh6ekG2rjMJjMLvFuHmOkrF2MUTs7v+yeQy3lhi7B7ERaTxkXzqFcUWKV3C9TfNRb9dkdIWsbE1jLb6hPdq6mEcwxJSv+VZn0WdmsS6gBx0MJA1xl3qHCDUn9zOMd3E3ZY3x8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tPMlsnsiNxkxqZsUMBt+pn+Y4xE0q86l8X7m+9ezis=;
 b=X5vGL3jhYhreo6Nuhp7L6bIP2D9Vh+QfCOu5GCHVLrx9TiYU5IUuTxaDylZlYo0TvJVHKXzq1bTADWd7AjcHYPKGStQD2zLB7g8xc6AzANl78hkngaSnqyvAce691PXCiA5ExNvj70z0gHYmSLICv/aBS/dkFQqyu+lpFK4hGxRJ7mfMgeaVzMM57WUCOD8bNW2mH5c2FLLgK5s8sRvnxUSqi6VkFHb+2FdJl+SLraD0FlV8xSaq4aAFHDOC3F3Pg8ztW2fyaaUSbyAIf1xHrOuuZeBywhflDVsBlWazuLUwLeKOperX4t/rVmCKFHJyNppSDh7BojmTJKZ9mdZaAg==
Received: from BLAPR03CA0136.namprd03.prod.outlook.com (2603:10b6:208:32e::21)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:11:00 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::36) by BLAPR03CA0136.outlook.office365.com
 (2603:10b6:208:32e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 22:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:11:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:47 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 10/13] iommufd/selftest: Add EVENT_VIRQ test coverage
Date: Tue, 3 Dec 2024 14:10:15 -0800
Message-ID: <20abd6d02d07f2d53ed75c2a55fc055859d0ce9e.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cabbedd-ae63-4bb0-1365-08dd13e75ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQUzvI5oI7NXakJLANTyMu3a/MJHYtAZCGf/5E4KXCk7BZzGKtlMmWcw2KGt?=
 =?us-ascii?Q?zkClvFq851YXGnuJpJCPhwACez2vugb4ly+0Yh3pW4O14oxa6F0KgAy2E+Jg?=
 =?us-ascii?Q?dNlW3x0qOzb0LsU6+6iLQlEwQHFhOcmNpFcTbyGd5NCGV0v8u7c0X02TXJS6?=
 =?us-ascii?Q?Sxs22IGMEdU4c55TBS48YEpsRqiQg0ExdsdeLH2oY0QW43qZwGU2RSEjGnaf?=
 =?us-ascii?Q?v2iJVMMzi+bBo5hAlYRGWf7ZxQHUD4Pt9Mm9TaOgfHcwqp9o2Q1QzGlQ7mCq?=
 =?us-ascii?Q?kybvDU+TDAND49iWovy77ecQFJZyfCAUYAeprkX8Kt0GJpAj1IKz7u5GL22v?=
 =?us-ascii?Q?RpllI8zFnKlPjY+v2otwAuD+JwlEi3BpX7R79yVKVJh16Ti2978pdqUuIStj?=
 =?us-ascii?Q?mVw4troKQoVSf6SRIx0aqspuinQnmj3CdHxWTgYTn0I5uJtqwlVgEFJoXC5i?=
 =?us-ascii?Q?Z2tI/xjKZX/dX8Q3tzzG6TFAX8JnF/tx378I1kQoZRvXyd9aGBm/rLIOnr+Q?=
 =?us-ascii?Q?L52PaD9WmXP/6uHuknVXHEAZstL1//ftTmMddazVoI8Kc4oqJ9XH1HUgv15W?=
 =?us-ascii?Q?ckfgpZct3/NzRVn2PYqDLfQ1uKsyVtH+Eo+6UfjzsxDYvUM8+QotOmdYPo9d?=
 =?us-ascii?Q?lfxtplPGoG6Iu8BsOxPLiq0xOF43nq41K5/4cIysjxCAxtwfkpjZdY9Fz4J8?=
 =?us-ascii?Q?O5q7TSjsZOc45/cO2rkpdBrt9a1HyzyGuZ1/XJvqX+dIVdsYguGkLMt+fQNV?=
 =?us-ascii?Q?Agz0eDiRA/6Q/RJ5b3ieobF0sv3tSsbVSPXNSpVAJLMg9D0hBZq5BEMGhqcD?=
 =?us-ascii?Q?FnjAL2yczVb5eZYlGpLPVhrHNx20MSsc5jL4DEpXwi5VE3vvx9N2KhbtU0Cv?=
 =?us-ascii?Q?55GAipwJa+13ZcYKefbc6WhHcHgMNvWnb4UNMJFJlavbgiVz78Sh5sdzvjLM?=
 =?us-ascii?Q?bVtvvFfmADl+s6FbDOoWmSPHcmfpFMS/40AkExP7XbfnRf3CVovbBy2gcXW5?=
 =?us-ascii?Q?8PrtukUGPiD4ACIxAg01qcAI1UE/Hyv8Z0AoK74f6WVTs1buEO/Vcu6zjLv/?=
 =?us-ascii?Q?qPlozhSXmjJiNlxn7bLecQT1nzr25h8F7tHfFQyeFY92eAeQe8qqxkmfwU30?=
 =?us-ascii?Q?ES4zqCxuDL5l0HDLndZ2jv5C4X6DepU29cTYhNErk33tW1nSnm1DDnCQAxJX?=
 =?us-ascii?Q?z1XwqQm6Aakd6jc2LoM4fUEPSuKoVmyPwynVbdORjP030lWu3t1/AlXYEyBK?=
 =?us-ascii?Q?jRdq0DP7CSu2eQrHk02C5IVGAdT6qcCzIA+ax5oTUwVfN/6Dgc6Nkpk0QQ5f?=
 =?us-ascii?Q?uuXf4q4RI1cWEOqAsL2ZELJz4RNktu3Ky/xP0bjZnv32CElVpLwuQzIs6AB/?=
 =?us-ascii?Q?3LGMp3CHHIxItPsHJiyXH0yWhtUAt37QrVsHdeJNhDCSOgpO/J1rchCoKxNG?=
 =?us-ascii?Q?4Gc2/cDiuY526v7Knlbj9MrWPvBUOm+r?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:11:00.2859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cabbedd-ae63-4bb0-1365-08dd13e75ec6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

Trigger an IRQ giving an idev ID, to test the loopback whether receiving
or not the vdev_id that was set to the idev by the line above.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 63 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 3 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..7e3e07c943cc 100644
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
+#define test_cmd_virq_alloc(viommu_id, type, virq_id, virq_fd)       \
+	ASSERT_EQ(0, _test_cmd_virq_alloc(self->fd, viommu_id, type, \
+					    virq_id, virq_fd))
+#define test_err_virq_alloc(_errno, viommu_id, type, virq_id, virq_fd)       \
+	EXPECT_ERRNO(_errno, _test_cmd_virq_alloc(self->fd, viommu_id, type, \
+						    virq_id, virq_fd))
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


