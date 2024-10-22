Return-Path: <linux-kselftest+bounces-20348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7749A94C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952E4284B4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A36614A4D1;
	Tue, 22 Oct 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0RamxVS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90549652;
	Tue, 22 Oct 2024 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556453; cv=fail; b=mEmKN8QNm9b6blRyRSdWbhGmG4LzBB7+cgHBUI2HfJFE0ek7A7S55PKUS9n06kSrW4LMlYwvIbhwyVajrD1WWdy/QarRlZ9D9jeHdAyyrz4aPDnyhccko3jnVZlodXZfj6HWUj7eNTWeFvEor+JlJMAKjbM6DSeHREcmPyxaz4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556453; c=relaxed/simple;
	bh=qb/+FK3ztSgG3sjdrVMGdsgZchuJLDyUZPsDr2HP8zA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n23t7AjgvU380dkOfJS9xEi6Z2b/sXfrRDfOj7HxKuyRu+iEMoi7aEw53hwR9i7a1wKfv1fueD7Z2oKiWcjHXemHYxi89Ur2YM8Vtio1BcM1HyNfAhYaIkmwTusSmo1dOPfqstPYa3w1kUIllSdnW3LOGuBRc2qAhgjNExUZzo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0RamxVS; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7W9SCmD/8aW4zWta4sr3o+LPxPAA+PweKkfBwGpBOCx4MviBviDn9ivcWUnh9l7HHZ6UYiml+seZPsmk3n5lwXaDCmeDG/En3e8OHF9mErRy8613vajZQLJyD7EDHq9M7udwRAZRFvkHDOMqA4UxPuDZjJAlnKyrkLjAi6+2sOlYsZMP774Hqz4M+XGQrgv9nosQ6UidtmQtmhle4lA4G9DfuSMeBs7xNmZLGcygcq7CoVqmg9KEqG+OWf8r8Okyktv4Iw2yxLN5yqbHY8GacxulsbvYXyDDRp04jL6MQjokXrqylP1vr56/Z/Dp8unEXLcfUivs6ve/bgEUcb8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmoYv5BXmCe+AYwmJbXz6MBwe1Btk5MIZJr1HGNZ+QM=;
 b=j2M1onr9sXrw+we/+qN+6GH7AS9bL3ClHvnZQd0D5km4kXtIojPdc5mztBWbOBfLUrA7MemQ45REHCLMS0IKA10Jq6HqegSRv5n8N1YIUV5yezSl04qwtq4o9tf5/ter2zDTizXixv8Vp8whbcv4zJ5UcW4hynYI/H1ko9nCJIacxVoVxvrcJybDyKcvSNvmMVpGsM2YI6Zi+Hlhp1h2+VZAS5gPYszVyZ56cCOtC9oS6CXBLkugLs4WV2pVKmI1ZMbgBw2uHxCGNW7TNhsN68TiwwUl28r4fJ+QIJIGPpf8qi5opNiUFNxxKz8/JAxapZr4V6W/KYXh5GIUDPk5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmoYv5BXmCe+AYwmJbXz6MBwe1Btk5MIZJr1HGNZ+QM=;
 b=C0RamxVS8akGoIyCSAv7kFyX/Eimhw7V3wd8zl+TJnJfc3PxUT5NMNcPskmfEeW2LsSIdZM6hTgy6dA44TVUlO8CIj8hOpPczeyRddOS/pdCpXILv2KVLMDcqyR+kYXpzsVl7FwBLPQ6B6y9bnQ6eIOpsfEZhdFJutS/afTdesD1MDSiIgFo6T9kD3AZf7jzJ0sYu7VWHYhCfiaQK67xdSZk6Ym3mPQjLPgfo+rnhKZdK8/oJdo4VgPnWaKnvOWQ9BBZPkmvk7uKT3AyoE74XFsV3BGDV8MgryZXbttASu+vvGfR/Q3GAY/PbHIfpH8RKwK3TpYjdFf08O8zP8FsGA==
Received: from CH0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:b0::11)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:46 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::af) by CH0PR03CA0006.outlook.office365.com
 (2603:10b6:610:b0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:30 -0700
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
Subject: [PATCH v4 03/14] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
Date: Mon, 21 Oct 2024 17:20:12 -0700
Message-ID: <80162ab41c302ac7f624161cc78a5bf1524f60e2.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d22fe15-e77c-4e58-6ba4-08dcf22f5fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n+KjiEZ7JGg+h0WTVNkH9K9/Iy1n3Ly13uJFQgk4obh4JPBMIlVteJlnUg6g?=
 =?us-ascii?Q?giZUSsgshb4uESNAYRx7El6jeakYiWJEL1iC3dIs/pkcwsRHsCTo5c4XDbtk?=
 =?us-ascii?Q?IfrpYGTLpS1OU+yVDsNAKp7jbeTnoZCzqtYBRN5ZZdTgjzu2MDjX8RQRGGbo?=
 =?us-ascii?Q?J/S+LZRd2rILCNa3w4HXAHCUt/ZaxNE4PxHJKqOauARicHQd+UHHR/XIBY20?=
 =?us-ascii?Q?roMNmlhWjYGgkNoK9hSB9WODOlzg86Z76WdzYj40wonpNLLclB8nmFwWeJpW?=
 =?us-ascii?Q?U+PZkwOBYywB2286kADify0Czwu1QJmFNc6Lb0c7fv6KfP0/vgdN9apD0+jU?=
 =?us-ascii?Q?9V7rDDHPCKFgtPadvbNYuVh1qe+nAevaXQGvO6oAhg7ZUv4yiphNqZ5BxAAC?=
 =?us-ascii?Q?x8SgevLmQ9Q7T5vdXJl7/foGeP6/er1mIchqCFoEV5UG/RZ7DPHA/WK9w8zI?=
 =?us-ascii?Q?eixzGtxWfU+F12eN92/1P8y3IAJsqvcKP6meyY1b63NmVnnDyTEty8iz8QMt?=
 =?us-ascii?Q?D8qEavNT6XDwMfbEzwomMwW0tE8am9+hISptLvPSStk/ag2wZIJj955rE3yl?=
 =?us-ascii?Q?KIP0a32Wui/RDaK7LRMAhipuh96UZliyvBKw++nEi7GjZfzydX6jBh60eQp4?=
 =?us-ascii?Q?kQaiCcA/gOTecQgh9uz3tL+g+GmCqmgaxNLTXV9MWDT/Fs1O07FQP9c+2Xc7?=
 =?us-ascii?Q?xw1SqOMY7b17q12d4A6Pgysh2bYEukWKtDsDSpgBScxDs11nsRDkYofj9vFe?=
 =?us-ascii?Q?kqnNByoA5QJXFbOcdPRxmaPFPWzEArjEllMCHh6dFn/ObjpZTVV8wLssmeCU?=
 =?us-ascii?Q?+OOZVdjKZvXCJsXlNEVeXuT8wnC3+VqDB4c9jZOUaNtR0rDRA0LP6E8JDNQ6?=
 =?us-ascii?Q?FRS5b8K6DKsTJYzouwImGYbj2zcgwFC9nZxl3XVbT5rgIdtArioHiaoaBR2G?=
 =?us-ascii?Q?ixwVPhAjXKEweWxHBJekS/XGKlAK4OM60321Ox6HJSp4qzKurhRo5lyO17do?=
 =?us-ascii?Q?XKUM1I80AVNzI6Hwfff6dxayDy9GdujgJ2HO3T42OS2bFc7z95q5nqJ5Lg/U?=
 =?us-ascii?Q?F06QffFJnwIxOU7c5iOV+EsJ/fU/jpOrD6vZfppzcloI00PLGkwmg9Vzw3IR?=
 =?us-ascii?Q?OBdJFQJwMsgsOFdolHD/cyx4f0Lcugp2L7H3qSFvTe583wIvaq6F5wrko19m?=
 =?us-ascii?Q?dRlltHWGS7BQo1QHnTcCm+VSPBdd6+wcSxlsYrrj+XOp/GeVSnyoq+G0tjpN?=
 =?us-ascii?Q?I9kxrblijlN31WCfR8ZaUt7+L1Kr8x8piVvP+IZ1Xn89eQHQI//yJUINMTQ5?=
 =?us-ascii?Q?XMqCPHzK/GetfpFhsowYDlg0k77zwEjmILY6801IGDkJlpsPLbwIxoy7lO87?=
 =?us-ascii?Q?U19Z4bMlCxMyZGzxG5P4YXPvo4kfr0lcTbnT+egL+i2WAAitPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:46.0004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d22fe15-e77c-4e58-6ba4-08dcf22f5fa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

Add a vdevice_alloc op to the viommu mock_viommu_ops for the coverage of
IOMMU_VIOMMU_TYPE_SELFTEST allocations. Then, add a vdevice_alloc TEST_F
to cover the IOMMU_VDEVICE_ALLOC ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 27 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 17 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 20 ++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +++
 4 files changed, 68 insertions(+)

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
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 04dd95fe24ca..f401c565143f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -136,6 +136,10 @@ struct mock_viommu {
 	struct iommufd_viommu core;
 };
 
+struct mock_vdevice {
+	struct iommufd_vdevice core;
+};
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -558,8 +562,21 @@ static void mock_viommu_free(struct iommufd_viommu *viommu)
 	/* iommufd core frees mock_viommu and viommu */
 }
 
+static struct iommufd_vdevice *mock_vdevice_alloc(struct iommufd_viommu *viommu,
+						  struct device *dev, u64 id)
+{
+	struct mock_vdevice *mock_vdev;
+
+	mock_vdev = iommufd_vdevice_alloc(viommu->ictx, mock_vdevice, core);
+	if (IS_ERR(mock_vdev))
+		return ERR_CAST(mock_vdev);
+
+	return &mock_vdev->core;
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.free = mock_viommu_free,
+	.vdevice_alloc = mock_vdevice_alloc,
 };
 
 static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 49ac144cf5a4..a8c6bdf64825 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -129,6 +129,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
+	TEST_LENGTH(iommu_vdevice_alloc, IOMMU_VDEVICE_ALLOC, __reserved2);
 #undef TEST_LENGTH
 }
 
@@ -2464,4 +2465,23 @@ TEST_F(iommufd_viommu, viommu_auto_destroy)
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
+		test_err_vdevice_alloc(EEXIST,
+				       viommu_id, dev_id, 0x99, &vdev_id);
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


