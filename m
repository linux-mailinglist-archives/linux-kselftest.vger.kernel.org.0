Return-Path: <linux-kselftest+bounces-21178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DFD9B6F5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83E21C21BF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19D219C84;
	Wed, 30 Oct 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fifKoVfj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF921767F;
	Wed, 30 Oct 2024 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324173; cv=fail; b=NpvFwi5geHrvuo9M73eAU0GauWlcdcG/EV60p3Va8MJvYrD7pOj6lGF2Diw82YN2aQBLUy3VAoHfTthTpE9MtBl45wrw1hqd102IJfJE4gLp0nF5PsJ+g1r3ZapvHNYmaSheEH35YWt49mpMzl0tDEI/AUd+km8MhtxYKjWwK/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324173; c=relaxed/simple;
	bh=YHGmDud+TqvthV1uszns7XQZC4eQ+icwRQHgxyP7jv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pi1k8yfoc4ImAvuFdgYkXCp+78wEXdHaq9vY3D/JiEJLq006LjzvOv0LNGmWQAkvDp/aiKCf0bgRtotVEoRw1wWkiG8ijsFMyJ/t9cDfLqC1LFrnIv91wDE3/87mz+iEXOHkDXL1lWsEQBUkjAJQT1L+aHUXXH6kmKBnhKbMs10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fifKoVfj; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHeAzVXWV3Y3E0kviai6fN7zefF7LY5+mR3p6/i6Y6fd8zUPuhoevoYIZ8i25wfnVTwsmBQpPL8wefK7iNBCs/C1gZbynmTGVM0gKhGDEkjBYT/grk+hAH6I5xWD03NT7GG+rysQw0dNWiVD8AVD2cL9K6HM4lPCJSyO4g6cYSirGX95BwBX+84ZGIau4q9WCuH2QK3UrqW62FYvLD4PWiReiCFBLsQttHbHDIRzc4MDRetsshB6P/9arBSNfAXbaOuuaGDN8Uxs9y6g9RR1ISF+qjT8k4iROM7ylOB8DQG/M4QkrxvII8NwWfKaeEv0y9AI+KXMXCiuh8JxirsZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl3HiL2UQvzMT/LUxdZgvGhsNYL6H49i9i0It8L1l9k=;
 b=fP5+4AnO/bXQ5ZORFfCoGcDKX8li+BPQ8KBXJZffR80i5mD2FqgLRwSva3PlFxKYSxUXa9aol5Z++RacZ7+e4/+7lV4W628/b4VBDKWrH6xTF9myTbbueyEuPgQpORIGa8sGnKEeO4ihXaRKQMyXFkyxioWYY1sYAan9XgkVrFYt/vTGL3ufMubuBskgMyzRO8KiqB8IDztmxJF9IPNAhNQraiI6+NVhw6LmMWPVsw1eVPx8FAkxGS4nE+l6EOO78/7V+guBMC0+4Pu5YRNswCJsr35aAbFQ7pYlHXJ+xp+0Z5EXi0mVkXAI7jG6a4FgP6Me0fFlPcSh7cvv/XaHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl3HiL2UQvzMT/LUxdZgvGhsNYL6H49i9i0It8L1l9k=;
 b=fifKoVfjYNfFKYkMnEafzGUxuUk1/pJxvzZF4jpoY6C3lb1KH4TrI7+9EFk03Pua9h+0JEYjB9lYldoCQrZhcnPwKNrxD/aQqTinVGiWH1nsCr/TECi1+fJFab7tPN95NrNLLm4fOT+0/0cJBicXAfkYRwxkoKHF7/U1axzrsn59tdfaUz2ai9OyPNRt9j8sIKik9Gbq0jMCvChiiZTN667eGpbZO4q3QmxaP0FLe9hL8ZZUnGrI7jSTpb2SQwvYDivp6MZuOF8bLac9c8TWA9Ma3rknPyTYjSBmaBVMtuM/Zknv4hTiExvhp7874dbax50o11a0FaALLppti76b6Q==
Received: from BN8PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:d4::18)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 21:36:07 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::94) by BN8PR04CA0044.outlook.office365.com
 (2603:10b6:408:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 02/10] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
Date: Wed, 30 Oct 2024 14:35:28 -0700
Message-ID: <b25e34336321d1e314c9f9034902fbed16de375b.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 058ef9ca-4b1e-4185-d600-08dcf92adcff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tlUJ7SRzCMKvEGCEwx4PlZQXkci4DjYSKrFJfcT04jxP3PYh4Eeclp4vf7L9?=
 =?us-ascii?Q?tkQ/oyl14uF+01idtiu9oyMetrNhQY+9wgFEbta6H3KiMOCPOVdOuwdgcme5?=
 =?us-ascii?Q?cmSd5Lh/zE8A5skJZ0ZeRfU4x5Lc7OERJCv45LELvz91sq7EEwItA26aFUh1?=
 =?us-ascii?Q?jxLwMqq1jQtQjdjdz3cT2yOkVwIyJCSA0WlF4WMVMub5ZZcYIUjh8XyG23ob?=
 =?us-ascii?Q?JStBsj104GxB9aGd0QnF1erUgbD8EyM4ggxdvABbjdDYehWw+CbFI9x2Ag3w?=
 =?us-ascii?Q?TuTEnByQ+XOBoysboVKZeVYEDImEFecyyd/okPHnYu20w5IFfzh++H9eCTgM?=
 =?us-ascii?Q?HUfyZMJ22/hm3ZI5dNArW75h7RLHUPdIcukHralx54ZBryJmn0N+/LLmSZgb?=
 =?us-ascii?Q?WNYnkP0zjALlw1+11k+x2SKKHTq9O2vl67mJ110F0dKtP989N3YPK/B4d+ed?=
 =?us-ascii?Q?1TROUH0T3YPSi6/jFxfwgArOlUeV6Orm8WH4OrW/tfRUd4+N4UdoRB1ltX0S?=
 =?us-ascii?Q?MhXGDunLM7VMEew+I21um4sGEf5COZMHoZbGxbxHoE26OABOm1F8P29iTTvS?=
 =?us-ascii?Q?dcEHikZFtkGbV/7yu9WwIOBYcAre7TPx7/ike94NFSryZHxJnqM2hc7TVui0?=
 =?us-ascii?Q?IIjwIUMe1IKdIpFxF2qEDk+rxV0DWh47oVIuW1Bn9X9IlgeNnbihpMjcP/LD?=
 =?us-ascii?Q?cCypeGQlI1Scw5t/ANmt+7viYViX4PCAz0C0fwVTVA0x4lo+cZBuoNh9byta?=
 =?us-ascii?Q?GoAkwuheLF/uw05bD4+p1QmQzUYivGwSawQwbtMBvyRWSPIRHeBjaYejaBy7?=
 =?us-ascii?Q?03C1e2aR+6qwHk74n6Dl0kQXnJRLA6qkCiIXbz7RWUQN13ELxvyIE8CDGxIt?=
 =?us-ascii?Q?p2l7+1GIld5HB5ZJXYfdw7qh/U06zJ3OXLb6woEODPj6SBzg1IAC3uBTnIUt?=
 =?us-ascii?Q?GrP9mtOg9wY6KBIVaZW3peaQKhKbD9RlzaqEkV13M0fIdmBPdO5h0iokNB0j?=
 =?us-ascii?Q?LaFy3yZPFodYVGmGLetlY0FB0BwXZGRhUOFukXeS9Uf2ZvYB0ElyiCyn6tFn?=
 =?us-ascii?Q?JfY8qonXH/nTewXjzXEJEzVq+HqWiwywvnXnAarU5qIorUDDrM2LHCekGsXW?=
 =?us-ascii?Q?xIoaIBBraGuVq8Kw974X+ZS6ANESBDWFxlIYG2ehou5Q236f3iuSmbH3lU2Y?=
 =?us-ascii?Q?UwXEsl4qkLxhOwRR1F1uSK1xCNhXUAJqKp8jf598/O4bgbKYF2tjk2OwO7HZ?=
 =?us-ascii?Q?4ve1p0jo9nWx9uRrLeOPFuTWaPDvOMk8Pdw4oQZfrVgIPxM2h0qEs0sUtU4o?=
 =?us-ascii?Q?p7u/7eJDys8RtvGW/TyHT3UQC5ztO6qkycOFf9VaBlkAMJYydeKqh6R47MGL?=
 =?us-ascii?Q?nZ1dQSf0qxO7C6RbNAsHhcFJMJCx6lkK6sw7b7hRkeG1gw+r0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:06.9276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058ef9ca-4b1e-4185-d600-08dcf92adcff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

Add a vdevice_alloc op to the viommu mock_viommu_ops for the coverage of
IOMMU_VIOMMU_TYPE_SELFTEST allocations. Then, add a vdevice_alloc TEST_F
to cover the IOMMU_VDEVICE_ALLOC ioctl.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 27 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 20 ++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +++
 3 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 7dabc261fae2..7fe905924d72 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -847,3 +847,30 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 	EXPECT_ERRNO(_errno,                                               \
 		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id,  \
 					    type, 0, viommu_id))
+
+static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
+				   __u64 virt_id, __u32 *vdev_id)
+{
+	struct iommu_vdevice_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = idev_id,
+		.viommu_id = viommu_id,
+		.virt_id = virt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VDEVICE_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (vdev_id)
+		*vdev_id = cmd.out_vdevice_id;
+	return 0;
+}
+
+#define test_cmd_vdevice_alloc(viommu_id, idev_id, virt_id, vdev_id)       \
+	ASSERT_EQ(0, _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, \
+					     virt_id, vdev_id))
+#define test_err_vdevice_alloc(_errno, viommu_id, idev_id, virt_id, vdev_id) \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
+					     virt_id, vdev_id))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 3142819cc26d..2610117cb39e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -134,6 +134,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
 	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
+	TEST_LENGTH(iommu_vdevice_alloc, IOMMU_VDEVICE_ALLOC, virt_id);
 #undef TEST_LENGTH
 }
 
@@ -2608,4 +2609,23 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	}
 }
 
+TEST_F(iommufd_viommu, vdevice_alloc)
+{
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+
+	if (dev_id) {
+		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
+				       &vdev_id);
+		test_ioctl_destroy(vdev_id);
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_ioctl_destroy(vdev_id);
+	} else {
+		test_err_vdevice_alloc(ENOENT, viommu_id, dev_id, 0x99, NULL);
+	}
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index fb618485d7ca..22f6fd5f0f74 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -622,6 +622,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
+	uint32_t vdev_id;
 	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
@@ -674,6 +675,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				   IOMMU_VIOMMU_TYPE_SELFTEST, 0, &viommu_id))
 		return -1;
 
+	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
+		return -1;
+
 	return 0;
 }
 
-- 
2.43.0


