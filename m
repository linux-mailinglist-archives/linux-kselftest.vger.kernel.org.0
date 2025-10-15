Return-Path: <linux-kselftest+bounces-43151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C07BDBEBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FBA192303D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2291214A94;
	Wed, 15 Oct 2025 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hr9ubzJ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E6201033;
	Wed, 15 Oct 2025 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488290; cv=fail; b=WFLROVMvcra87Cp87uaaDU/d/PBfIAQ6QhgAHh5AbsaTvAtOAHrWlefmyXmwRtjdrB8qhStjKKUOrR2S8xGuMYrUzz9sM31AMqmHyWxjrO63GYgRMvsVmzKNFWT9NGjt3G4SHm197rm5ajCXG6xkLIIB42jk4rQGmsgprc2jqpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488290; c=relaxed/simple;
	bh=meNkPuOjzHKtKSpmvNBLQVVb5WidcvBOhKZJeiDvah0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IatyUXKEevha/hadbVA52FbxK1LqDo5jcXisUpv4+UqUeRQHfFj7iS+T4u9BGtTK2KeDcFEOF3BzHviOP8yevvIKsp6KaJ31ogOxQ4zvHErhVLl+gWtWMbDTt3GpqKAc7vgz3Id09OfT9NmiWgT5kHSFXcGjeYG+YgOvDQXM+NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hr9ubzJ2; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO/u1o4kuIaMVJtMNcweh6fgSFs1U9lkdlmgfmDsQJ0sEwi71a8O0JsZbcWFXM2duq7JOcSxk6blRnG/4eyp8kdxVfFVazC8l+A+vVhYo91ocxvTw/B9dPgOCAo4v4xG3z6rwVthxXlX6yJ/8azYEOL8ovdMyy9bF72SvGJCxJ71G0X1jeHwr+mD5wp/ddsVBydRORcPlaxrFJOoban+qnzfjyn/cjA6h0omXlj7yIWzS5J3lfIEIkPl2w1EXoehs3i1TtM1TcuGx7t8DOILBOYwhaMJSqhs3GvtRuQoTkKJPLKRJuHqSuL6FkCoG0srJeuKjYzetfz6lq7t4R+wAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMt1fmsbq10GHWwA8AYIGSPyYpyKl/YTi5b+cilkY4Y=;
 b=HkbFsGa8d+dbJQYWD/POIVzb7s8b5ogW6AVAGmuEClx76XC61uFKp/lJCei1gqcJNPgnjKBGs603Wf0tHZbzX+B+IbeBbhBMiXh2SPM2UHRxwl591Hvw87h3wb+CvyFwSu74tT/Ks3DdLNujnxUCYA35TUbWwKS4X3Ki+0LVLIlhy2EolEDMyIWlP7PlpuQITibxeJGvk68+I/+zefODMdRZC1pB7yQg0JrgOLgHTiO2D2vxiPO/e0iB6uFAwreqFWT/BuMRHR5ws0tMiDk7Tvh/pEP8QrwOAlo59V0JCDVKFjUAuZY2iluez6gJPbNej3svH9tf7rWVOmBvsOYUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMt1fmsbq10GHWwA8AYIGSPyYpyKl/YTi5b+cilkY4Y=;
 b=Hr9ubzJ2PNNx/oTCE/I/p8YTz6DigfF8x2MBC14V8c+FROGXBY2LM8Ibco7Ge1lEsRoaCGyynk+LNbPYUSfp/M068H7mvi+y/URhyb2zp4Qw43TYZjYIxEJFMzj2XykAL6MxaBZkkl8bJooec3GubhqOreemQL8iU2G4QDs6VTC8FSKFUPO4ayhLf0aF1eAZ5p2Gd2WELJFAPOn0FcyKew23NCPEktVclJzoTjLixyIDvo7sfabHume21TxKJfTXFeAt4ftY0Th8t8DCUaE731v13tCWPG6XzeK4gOFKY3N6YiysJZWJpBfFqk5sF8r9dESqMQizVLUUuPbkplkFDA==
Received: from SJ0PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:33f::19)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 00:31:23 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::e) by SJ0PR05CA0044.outlook.office365.com
 (2603:10b6:a03:33f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Wed,
 15 Oct 2025 00:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 00:31:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 17:31:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 7/7] iommufd/selftest: Add coverage for IOMMU_OPTION_SW_MSI_START/SIZE
Date: Tue, 14 Oct 2025 17:29:39 -0700
Message-ID: <e5a7dcca743633cd12114ac6c8fadc217277164b.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 99617328-c7c6-4718-3588-08de0b822b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXn7Pxeo5S4v5RINR/tKIO3GCV73KI6mc+JsXNn4E3tw2IkwsIVFJGVnsEEf?=
 =?us-ascii?Q?o0VZn3qwsu00igjVP901xbJebfl/gRp2XgBmtJBlV/XADoh2feOzpS2unt9C?=
 =?us-ascii?Q?PjUcva+BEqN65tF2fACEQmjrkhYACs9YUOAsBgaTPDp62qI5QU+TUqocULVL?=
 =?us-ascii?Q?aw3nHEm/kgZJJvjS6bp0+5sDKEMgXEwdbqzeZXZVUZcJ/lln8f+dUheIGm0I?=
 =?us-ascii?Q?ZSoXPBlaw4kOAhnBSYdizkmf+l9YSpwbr7vsjeFiu9taF4hFljSXy5lw7wYd?=
 =?us-ascii?Q?dX+OG3Dofi/FVr2RhdhhqGbLo9t+fhWgaTNjLgXafHxP0ilI1RSu1cQqUs8D?=
 =?us-ascii?Q?GnXMI/eQyge+juTVkqgNK8199PBA1UeIuAyA/AENSt0o/bKDj0tOsDsRqGhU?=
 =?us-ascii?Q?UbV2F9o1wvyqNrdSuWLu5W3jtGoDfiDYe1OY8JGDIy1uc3ebKe93Mv3Yo6BB?=
 =?us-ascii?Q?VoXY9ujeSzKkXGhgQvrzMzCc9afpmnHIqSc/bLfkCPp9eRxORhQya3+/eYCB?=
 =?us-ascii?Q?icv+wX9buT+siRZ+brXcjGS0J3aenEA1hI6zLlQ9lYj+CkSeVHRz7gXAeMld?=
 =?us-ascii?Q?iOLmllYybUr1ktiShHOWTTCc++y/k3ufBZeXA0/AGNteaqac2HdYHgacHEv1?=
 =?us-ascii?Q?DdDJZhVL4bTF8hiv+Q8zwL57nWhCWXPb4gDU7UeHhXDPgoeYVp70lh5+rsKF?=
 =?us-ascii?Q?qZdBeqt6Kpl9nohLcpGm+/eg0VTW7Rbi5Pe/1/JLECaCLEr/0Vb1ICPrzF8x?=
 =?us-ascii?Q?/tTurIxMFhGMLcGU8iHfkMQQQssyR+HOYfj2AvgyMMosRy+lACEKZXmWpRge?=
 =?us-ascii?Q?tH+6ePCVpWd7saQMisSVURvworzEDQYpPXnSjE0sby3IQ2P4FRplF/O349kZ?=
 =?us-ascii?Q?efKCELlm8gudSNiQYnv5sFeJUepuitvYMCCMNMWIfikl7JAju20vhnn4lk9Y?=
 =?us-ascii?Q?4BHO4TMwFvDq/aMxkhebtTKJpP30p5MWtJZLjMIQARINUDW2h4i31ngIWZ3j?=
 =?us-ascii?Q?dhjLxJRkUdVl2u/JnAf+kDEzx5cYAjR140AsDF5pJtBAso6OKcUl7pQquFNe?=
 =?us-ascii?Q?7JAXnk0ndxu0f+HfxaYuXBP8CKYK/gK9k9na/Gzq2M1lznb+jlhC1LBNB7q/?=
 =?us-ascii?Q?UdXKpEczeUXbDOiVRzbPi6YoFwz4lMJ+HgxVxkcw33FU9DUBvlwg//w6TUby?=
 =?us-ascii?Q?rqdqjFLVZvONas40zF4+dIN3knAP786hHcVj2LYNllaOwVt/7LCCh7SIKHMx?=
 =?us-ascii?Q?mk85Dz8DT88pefIN17XOOy2UG9t7PONIwS+kUTSCCPv26DJZAwpq48OC58eR?=
 =?us-ascii?Q?O2FnA7KmFb3wJ6qrpG7W88JX3HCyfwX1edYtVz4rFMK9nbMSE7IVrR7fzhy/?=
 =?us-ascii?Q?eSWL675kItGz/niOTbLwbA1Z5GCYQ0KJ61MrcgfKdPg7IX0AarHtsrEBsei/?=
 =?us-ascii?Q?vOJ1W2sqxasA/CNmsFm7Z4xmunGsDfzvwU8gdgRLG4fnoTgi3BprUlu4EPSf?=
 =?us-ascii?Q?EC/rHEvmselUiuvHOA0PiWtK0BJIBx5iRj28EB/fGE7/pL9mQeVda5kpeMVT?=
 =?us-ascii?Q?oV10aCglqQsbfwRnP3U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:22.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99617328-c7c6-4718-3588-08de0b822b0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Also add fail_nth coverage too.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 105 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  21 ++++
 2 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 3eebf5e3b974f..d67b1ac3e60a6 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -336,6 +336,111 @@ TEST_F(change_process, basic)
 	ASSERT_EQ(child, waitpid(child, NULL, 0));
 }
 
+FIXTURE(iommufd_sw_msi)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t idev_id[2];
+};
+
+FIXTURE_SETUP(iommufd_sw_msi)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, &self->idev_id[0]);
+	test_cmd_mock_domain_flags(self->ioas_id, MOCK_FLAGS_DEVICE_NO_ATTACH,
+				   NULL, NULL, &self->idev_id[1]);
+}
+
+FIXTURE_TEARDOWN(iommufd_sw_msi)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd_sw_msi, basic)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_OPTION_OP_SET,
+	};
+
+	/* Negative case: object_id must be a device id */
+	cmd.object_id = self->ioas_id;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0x70000000;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.object_id = 0;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Negative case: device must not be attached already */
+	if (self->idev_id[0]) {
+		cmd.object_id = self->idev_id[0];
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x70000000;
+		EXPECT_ERRNO(EBUSY, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	}
+
+	/* Device isn't attached yet */
+	if (self->idev_id[1]) {
+		/* Negative case: alignment failures */
+		cmd.object_id = self->idev_id[1];
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x7fffffff;
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x7fffff00;
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x7fff0000;
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Negative case: overlap against [0x80000000, 0x80ffffff] */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x80000000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x80400000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x80800000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x80c00000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		/* Though an address that starts 1MB below will be okay ... */
+		cmd.val64 = 0x7ff00000;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		/* ... but not with a 2MB size */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		cmd.val64 = 2;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Negative case: overflows with the 2MB size */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = UINT64_MAX - 1 * 1024 * 1024 + 1;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		cmd.val64 = 2;
+		EXPECT_ERRNO(EOVERFLOW, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Set a safe 2MB window */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x70000000;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		cmd.val64 = 2;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Read them back to verify */
+		cmd.op = IOMMU_OPTION_OP_GET;
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		ASSERT_EQ(cmd.val64, 0x70000000);
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		ASSERT_EQ(cmd.val64, 2);
+	}
+}
+
 FIXTURE(iommufd_ioas)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 45c14323a6183..19f23519b7914 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -621,6 +621,10 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 /* device.c */
 TEST_FAIL_NTH(basic_fail_nth, device)
 {
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_OPTION_OP_SET,
+	};
 	struct iommu_hwpt_selftest data = {
 		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
 	};
@@ -632,6 +636,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t idev_id;
+	uint32_t idev_id2;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
 	uint32_t hw_queue_id;
@@ -742,6 +747,22 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	self->pasid = 0;
 
+	if (_test_cmd_mock_domain_flags(self->fd, ioas_id,
+					MOCK_FLAGS_DEVICE_NO_ATTACH, NULL, NULL,
+					&idev_id2))
+		return -1;
+
+	cmd.object_id = idev_id2;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0x70000000;
+	if (ioctl(self->fd, IOMMU_OPTION, &cmd))
+		return -1;
+
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	if (ioctl(self->fd, IOMMU_OPTION, &cmd))
+		return -1;
+
 	return 0;
 }
 
-- 
2.43.0


