Return-Path: <linux-kselftest+bounces-20736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DF9B1386
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F6C1C20A39
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D0921B876;
	Fri, 25 Oct 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GI2Na+ua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C41218955;
	Fri, 25 Oct 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900266; cv=fail; b=e4JdjBQJ3kz5VyzYmcAVcjNnb8XAKKYWqQzMVWbkwR2wsI++XlZKayQxjajGB64U+7SMUjcYYyOzemOyaROH8OLAcnmxsVT1YQoQEyN/Bo4k64v7XrMVo3wSl19ay/tvCLxZXqFuEHWobfSQjvtCkT8eVB/mDcht2RhJ5C2bipM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900266; c=relaxed/simple;
	bh=Lri1otdXvKxp0kKq+HmoBK6cX2c+jINqrCYIy8o9GDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6YVkOBWGNqG4YJAvyNWjh1gxqDn1USllr7s7sI4ugcFW5dGeZA+WbnRJFONqhLHe16o6X/FrH3k/kac34pMAmcAeG+qf9LjhI5A6csT19U3MQvi/lKRcPDjjqQYyFwG+d4U4EC4kXHgNdSsALeAgc+bnWQDrmpfdLzi7mPYMhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GI2Na+ua; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1A9fMuZhQdvXhjSGciCLlsH6ebMFdwgsrsbTHtob7AwtG2S7e1/jT9tJaFNpjPdxpkAFkRkZBpmxT8VkTLjMbkcFiubhOlr/yy6mGv0XI33YKqg2qzjbxOBerTwBBw8uJ4KVKSKr9/eUBEQQ9IwSLIwkK1z+NOhzYPnhWnKNIf8tBjO9ghE5WuSQgVY1pMFC8D65hm99NPMAS/uAbrQAOFZs+5gb4dRRIhQGb/AI9NHErFL1aQTHbGWAagbcsP4aXCtLk0DfaOi3mGPrx8tNzGtKXmKhgNjsiExoM7wCHbyrGWLajusAqqDBd5Z9BCYB5sNJ7oh7pd2lB3wI3b/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOVbhKjzMHtKwFiz7VIxmXTimA3jrruMi1sombXt4SM=;
 b=cqm3LXRtDGjRUh5OMjn4qP9d8NUi8ajTRBEceF+aezrFDS/nPUk8hvGwRuj58Ycu/5tb6cdYcB3PhEZcVac4pGRqs/7660NCIjA4iR/qyEA2g3wuPGN3FgtGNOMProVPRCXa5iSqkEzcElbCrbaIpaAHsU2ThP0oGB2Lb7ZkFmpptxPnOFpuU9rdO+0dyxPejqP30oqwpjcBtlhOq7SaS1a5jkS7se19bD0F9Wkx+NHRYDZP3uOsaRwp45Jhk9ndDcVLNmUYqywpzb3P4HocZhXDxO10s6Uis+ajPeOro0d12dMbSThyoduRMnIvm2wzHwGUduxyNhyw7kzoBOxqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOVbhKjzMHtKwFiz7VIxmXTimA3jrruMi1sombXt4SM=;
 b=GI2Na+ualkab/6ReDdOnIV2ffM3DNoj4iBSsBsNNi4XRwajNrPDITmbCUFBS1dVZai9M3n2tW63GFx1RpLNGYi+DLR+kn6cWdhKLbfbiR1oRskgzh9NWnSab4gj8Z9R4rIYB3qVvC5+Oo2ofmHNV8wIxZ3ElPxlu6eLcUhQz0wvLSlCsGR/i66ieZhjGH6ryhV7lFCufjensB8eOtA6h/6pbLtef+FZJVDuSYR4i7TDPiAmKCBOy6QAwIllXUNeivieKnwGTK4YsAP3uKwdVGr2TFcmeb6aXVJDTqucQdj25exMnSkDgAI0wdgNKNojgKg8povP5HEEALlErlEbVdg==
Received: from MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::29)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:50:59 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::29) by MW4P222CA0024.outlook.office365.com
 (2603:10b6:303:114::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 02/13] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
Date: Fri, 25 Oct 2024 16:50:31 -0700
Message-ID: <fab524b7054fc38d71b6d7a46f90e1f97538d2eb.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faf49b8-196b-49a8-6d10-08dcf54fe01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X3AyOBWUvZhMSOHmPhaEqE0XMs4n2n/tPdVw4Hy8NA4EJ47JRbP71+W+Qvzm?=
 =?us-ascii?Q?YUOIloIUnauWEFIm9ksDu9Q9B1MQWXrzK/Khz2VbpliTV1sUsqTi2YFUYQo6?=
 =?us-ascii?Q?NZDnfxe8YGTQzCmQXr9cIlDw+dg+Je555tHwy/JY+Z64fiNEUk6h0BfC6f4c?=
 =?us-ascii?Q?ZSJ9FY+8SDbqftjqCBNuzsFWk1YaenHuppe0uU0ebUwreS6bBFphjXzLH8SA?=
 =?us-ascii?Q?aCzmtjqAQl5xhwampW0gJ2G/VRksfj6kTmQOU957MBJG/B7bnkqc3SfmgMAS?=
 =?us-ascii?Q?eIEafJhSJRnC8GT1CflSEHsZIgtUZYvW5DydlbV1BvJmAR/vAMBMAQQKZjXr?=
 =?us-ascii?Q?wP5PzyMXl9HCoVXeEGUD28msr9mSYFD2vFMHnsjRWtledfbLFBxZKyGivsUt?=
 =?us-ascii?Q?cO0BDo41vdR0PTm1wMUj4/UTApm1tgPpJOwhmm+6Km9qomQf9A+zXi/6IEh7?=
 =?us-ascii?Q?yU2S1SStSMUhgH418TloFXES94vt6SzRtwDrPK/FmBcHxSCxHSZFXtW6mNgM?=
 =?us-ascii?Q?59CN01s8gqNPYKJzCvxerDTCfGuxZfdMSiMq7w2lHUHx3oJaTvMg3fXEcVLH?=
 =?us-ascii?Q?G8D2p9s/EjUiirst5lP4nrfVTl1IJhGYCN3SpbcoYRtT9rUPRg9tH2KKFgd4?=
 =?us-ascii?Q?lACJODTU9qdOcgGeLNAozXlSU+s9gwc6l2UqMvIMKNekgsPdyFzYoNWvLKdt?=
 =?us-ascii?Q?RNmsJDjn5cXsmT8l1nvEZXA0Wx0+NAVCCylQIaSQvJ3N9TSlVGPm5JY7SQXM?=
 =?us-ascii?Q?5uxTIfTht9YPKpJrR6MYzsO2sn5f5GrMENBjVRJQvvaCyDS1XOhG40HSK3Yp?=
 =?us-ascii?Q?KuC3RMpNmns8H0tx2Fu27biIhar6eWOMuOxtHdfh6Ryq0wVFQyCpbF7Y1OzF?=
 =?us-ascii?Q?WNIZGfcPm2ovlwik1Fr3ED6nAPUhHBxQuSXcoQSto9dSEnPdORVHh60Apd5r?=
 =?us-ascii?Q?BHmJc3+PLnll9nj/44ZPH4FwSf0VNQoqWfhjER7+G1vNNoTMNIPXCZEh+Gvl?=
 =?us-ascii?Q?JEyXqt6Cwszk2S6S9EsjdXINDe+YxxjAhniZ7dKqvX654qFh9sK4wRG4BpE2?=
 =?us-ascii?Q?kPnZPpXi8ckuVjeVGJKgp+dp+fJvoRglc0XPtk++AeYN+yqPFW3asqptRlf7?=
 =?us-ascii?Q?T09S+2faU8jGhLWZUFCofjJU47sU7cpGfm01bipiRJVT4hRlVZQjI2aFSQ5I?=
 =?us-ascii?Q?VSBRFIbdPy1RASLVbFTYt4iZFHC90v3iGoDiXpbsCSH4z8wwzP4CRArfHXC9?=
 =?us-ascii?Q?wlvKP58Ixvky/e6oIg/3F3Nv5oVF+ja+Dxdyhd5vXMozpm9nmzCaVl7zUSgU?=
 =?us-ascii?Q?yRXDHAIV+KzHI9Plw7vNuGeeWSogeiO4u/Vzg9Qe30Lsf8IwbMJ6tCA1UiS5?=
 =?us-ascii?Q?F8QGPnvwDhbf4go4BeX4j/VA4lc/SKmskXAadEVnIR//I/yejw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:59.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faf49b8-196b-49a8-6d10-08dcf54fe01b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

Add a vdevice_alloc op to the viommu mock_viommu_ops for the coverage of
IOMMU_VIOMMU_TYPE_SELFTEST allocations. Then, add a vdevice_alloc TEST_F
to cover the IOMMU_VDEVICE_ALLOC ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 27 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 20 ++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +++
 3 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index ca09308dad6a..5b17d7b2ac5c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -790,3 +790,30 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
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
index b48b22d33ad4..93255403dee4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -129,6 +129,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
+	TEST_LENGTH(iommu_vdevice_alloc, IOMMU_VDEVICE_ALLOC, __reserved2);
 #undef TEST_LENGTH
 }
 
@@ -2473,4 +2474,23 @@ TEST_F(iommufd_viommu, viommu_auto_destroy)
 {
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
index e9a980b7729b..28f11b26f836 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -583,6 +583,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
+	uint32_t vdev_id;
 	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
@@ -635,6 +636,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				   IOMMU_VIOMMU_TYPE_SELFTEST, 0, &viommu_id))
 		return -1;
 
+	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
+		return -1;
+
 	return 0;
 }
 
-- 
2.43.0


