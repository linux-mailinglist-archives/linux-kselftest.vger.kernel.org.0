Return-Path: <linux-kselftest+bounces-14958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2B94B0F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93D0281168
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7ED1482FE;
	Wed,  7 Aug 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YFp2WAi2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDF146586;
	Wed,  7 Aug 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061497; cv=fail; b=KeSCjIkOe/338VIlPBsfLAKsV+l70qqhiZKfkyC3EQgbqkLLKIjDuIScG1sTfqQgA6sgFYFlHwF2ScTOU8JHJTN3s1xmYb9Lxn/L7caRkUXex8JlFYhGRVwm0Qbk7Tkjwm6lGJYJYLeaA3nHA7aj3OWca7LISlKU//8OLL9VCSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061497; c=relaxed/simple;
	bh=JNq5xAA1aTuYEcGcaGNKNfB02XGkt+JQDXbk9tQnkQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wfc8T0R+HJ9E5/+AJsecMRVsH592H32luWGMEgTvRywXWrpzto+5VkCnFogeeUjqSP8Q/ML8VgSsSZqvduTsvLhksP+t1QqyCHlWdJOn5QMapYjoN2xa4+S0Yvhbnsr7P52LsyoaEaj3cMdmjxUU6a88w6r6I2pViGD02cyVJ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YFp2WAi2; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnKKgSqGkfO3C5upxt74X82SdAhuT5NZVz6GVT4RtgOT3TGePDBZeYR5t7hULeluY4JYI5+/Z20Db3oWDzODtickG8VRnmk4X2LgwIC3cgHSxkHiGGKHwsWug2wEsBZ/44TBMTBXkLssUKKmuaHXJ+b2YfxBRH0KcS3BN91ars2KyxR4IxbAj9XxRUge89AYPNVyWzoHxpKNEpLeHSeHW1O9MXISe2s1xKhZ6wo++2Wpgpsmim5OmbtpSBaDT5eW6uRSy2AlqPyETMy8UxDFq6R40RFmTsIFiKgn80CC36S0cWLGa+/q/8ZD6JwCi5C6OMVbKMGRHf+zrJUQs8JLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e65jdJJhhANst2moupxW83W9dVMktWBZ9575fT6Mh1I=;
 b=ILF6tyPPtgnQCEcR7Xr339KaP+e5KPHuckjeIly5NEEMY8qMb4P89GPqrtuFqnSxMjzogYRDGa69bSx86CZuSIBySinfXKOXz1FIgagGiNFS+lGko6xAdYiK+3cNcx3dWuQlAg59DWz/0axb/x/znvao5L/llDRuYu0WuUX6WyIgviYQXeJpDh/T3jyN0SxiZcu7p2gnZjaK7rdyV4Go0yEDNIm/CbQnHLwaUmgCUICikGWDG+fIxZiCBeNoqDyTP3h8w9OtKOvB91oNX7Ic9/x/bzPplWfBdtL9eGY/gnAVGnnXJ9yRKa6NF1afaxOawPa6WrYV/SVUcCVBufcsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e65jdJJhhANst2moupxW83W9dVMktWBZ9575fT6Mh1I=;
 b=YFp2WAi2Qq4tApfwTzxN8vGh8YjiM258/7pZpzBuGYMJskQlEy8pwaOPGyour1JK5+NqkyZSgwa45qVRxB0p6/1xfWRpk7CgyhS/Y8GfOqOt4nhGjWgLSgyizGlE9OOMQHMz+kLxIISYQK2EbbVY6uKM/XBBKfVWN3KkY6AtBSkBqdsNl79ilrRNrpMgESYddK2XMrFSDcUmUPPoSwysOBPRqbc1NUkANI6CwhelFFCW24GU1w3tO7BJmbwWgINqOzZ/N3CLK32uUDtlUXTu+/ffigrOD58ZBcjWg1KwqDwX+Gpx8R3ry6Xf28nK/YKdFGECgFuWyHzsfQBxdeyq8w==
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 20:11:30 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::55) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 06/16] iommufd/selftest: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID test coverage
Date: Wed, 7 Aug 2024 13:10:47 -0700
Message-ID: <4e7303c6dc2cd585c3855be9cf9d032f23c66b9e.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 3673dbe2-88ef-48a0-0484-08dcb71d205b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SYoj9I5aXLpPTNna8cLGYRpB+PUenBe3Oh3BhTqKBkMF/NZVo9q7Ww+5ngeZ?=
 =?us-ascii?Q?fA0iuA45oYPr3Fi/VMoL5O4oX8Soku6wwIIol9PJEPAzEkvu5AHiQTe4H2nV?=
 =?us-ascii?Q?zvtBjggXje5q+EbQ5gglO9YaPGcvZ3b3MOYZhgn16wPAtD4CraTWTXPy1qOt?=
 =?us-ascii?Q?ROBDDzw4C3PNfICgdsfFf6OEG0M6T8Hu1z5wUE1Od+LL8JMWyysPNsP5Gskm?=
 =?us-ascii?Q?dC4DV1V7AK3iW/zJV0FEsYfkRQCzMhvHrPK02IbcZqwYgMBWvn5Ii0twGbT0?=
 =?us-ascii?Q?kjvcdFIdHQbvk4VeSiRo39FAFWoqhfaAn2/E7e97mPC61OCQkAUFlyDv385D?=
 =?us-ascii?Q?h2KVB6Mbb/nlx1554NEe6nyyeWcwJVeXFkC7l3vKjHeitBQsJ/kKc2C1imVD?=
 =?us-ascii?Q?qu2rDC8umFHSuEtaKgODWLi98cCzXeEBs42aMoOPvWAOA+cg39WXaqD+9qrM?=
 =?us-ascii?Q?w0dqaJFzSbY35Uj20l7BOv70TMsNbNUXkyKpG0tEqATjG7RhbrBaCb/vEx6o?=
 =?us-ascii?Q?cvLgOucJv157eQBIIIPCcZDxtv8Hoube4gOmJ+kLeBUdLanS2yzGovKcCNLS?=
 =?us-ascii?Q?Ocd650yQ3vsGnZ8OtsadBFXCvejcqVJznvy7HUbLrb9VCLk+N01l9ouCOo1n?=
 =?us-ascii?Q?Qvvg0NU2hZrCj/LPYpYkVGzaz0gzzv6NAwAmwhXQJ50xiSZ+1vJohz7HtpHC?=
 =?us-ascii?Q?VaU6ilGWfrXdOSN9eXBsU8NAipEEvagMK+APonm/DWX8bZxykdmy9pdSIQL5?=
 =?us-ascii?Q?8OjEYpQAHCBIT+N99744gYHM0XdXLqa1rxSffQibiJwXrTfDaVo93ZF3Y4v3?=
 =?us-ascii?Q?TrB2mgQztwYh7ZIfK4fTt33Jfwg96axSDuNsQyW+LLPDgTAZ73ScHQK+X76d?=
 =?us-ascii?Q?63g+SDJl4eff2zhTSDDncHx0o2byZWYMA+hiWDlCzeBPY+U6po6kvFJNae3s?=
 =?us-ascii?Q?+MtzlChkBlE579jHgSFQDDdN7UExgeqvoBvmLDDfeXKp50MmlteOrXb8NlC1?=
 =?us-ascii?Q?suVyKdAPldOlm9XvpN9hK91W42FffBQAIIVV8J3LMt4/XX67NgiR6NTmZnfC?=
 =?us-ascii?Q?t5sI4/ZaEQ4MVgeeH2y0aM+TMfOxeJ+823kSp5wbPw3uqe2ZNkxh8miYwwcI?=
 =?us-ascii?Q?KiOHlsK/VsBWdNVakHJxFcd0a6jiUxy+jNG00O9fhBOyXaMO6rkZvlbbY7pp?=
 =?us-ascii?Q?kdmPuSUzOpeYFSpbWtylJrD/7W7jOrGukxA1bEWROKlzqlMa4UifDNaAzrRY?=
 =?us-ascii?Q?3N7r369rmMIOQKmDCHO9K8oyM15jXzE4d3Tv+yY1zU/NJlC56/lBLePIDxz0?=
 =?us-ascii?Q?nRCPGVt7ZKNcbVvob3CKxZs+dQxCZ7y/YVmQ4IQycwxEM6wMQhnEAa67hZbY?=
 =?us-ascii?Q?FRCFeepsAVei++drI3MT6NC38CBlHto+fWI7PtC7dDCMgSolIq+m+ue7F86V?=
 =?us-ascii?Q?VLfkdJOuI97QGfNwexN6gyqHY8wSBNXj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:30.2506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3673dbe2-88ef-48a0-0484-08dcb71d205b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909

A core-managed VIOMMU maintains an xarray to store a list of virtual ids
to mock_devs.

Add test cases to cover the new IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctls.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 35 +++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 42 +++++++++++++++++++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 5c770e94f299..2c11525ae754 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -556,9 +556,15 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 
 TEST_F(iommufd_ioas, viommu_default)
 {
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id = 0, hwpt_id = 0;
 	uint32_t dev_id = self->device_id;
 	uint32_t viommu_id = 0;
-	uint32_t hwpt_id = 0;
+	uint32_t device2;
+	uint32_t stdev2;
+	uint32_t hwpt2;
 
 	if (dev_id) {
 		/* Negative test -- invalid hwpt */
@@ -575,17 +581,42 @@ TEST_F(iommufd_ioas, viommu_default)
 		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
 				    &hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
+
 		/* Negative test -- unsupported viommu type */
 		test_err_viommu_alloc(EOPNOTSUPP, dev_id, hwpt_id,
 				      0xdead, &viommu_id);
-		/* Allocate a default type of viommu */
+
+		/* Allocate a default type of viommu and a nested hwpt on top */
 		test_cmd_viommu_alloc(dev_id, hwpt_id,
 				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_cmd_hwpt_alloc_nested(self->device_id, viommu_id, 0,
+					   &nested_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id);
+
+		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
+		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x99);
+		test_err_viommu_set_vdev_id(EBUSY, viommu_id, dev_id, 0x99);
+		test_err_viommu_unset_vdev_id(EINVAL, viommu_id, dev_id, 0x88);
+		test_cmd_viommu_unset_vdev_id(viommu_id, dev_id, 0x99);
+		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x88);
+
+		/* Negative test -- a device attached to a different HWPT */
+		test_cmd_mock_domain(self->ioas_id, &stdev2, &hwpt2, &device2);
+		test_err_viommu_set_vdev_id(EINVAL, viommu_id, device2, 0xaa);
+		test_ioctl_destroy(stdev2);
+
+		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(viommu_id);
 		test_ioctl_destroy(hwpt_id);
 	} else {
 		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id,
 				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_err_viommu_set_vdev_id(ENOENT, viommu_id, dev_id, 0x99);
 	}
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 810783d31ca5..1b494752a87f 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -799,3 +799,45 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id,   \
 						    hwpt_id, type, 0,      \
 						    viommu_id))
+
+static int _test_cmd_viommu_set_vdev_id(int fd, __u32 viommu_id,
+					__u32 idev_id, __u64 vdev_id)
+{
+	struct iommu_viommu_set_vdev_id cmd = {
+		.size = sizeof(cmd),
+		.dev_id = idev_id,
+		.viommu_id = viommu_id,
+		.vdev_id = vdev_id,
+	};
+
+	return ioctl(fd, IOMMU_VIOMMU_SET_VDEV_ID, &cmd);
+}
+
+#define test_cmd_viommu_set_vdev_id(viommu_id, idev_id, vdev_id)       \
+	ASSERT_EQ(0, _test_cmd_viommu_set_vdev_id(self->fd, viommu_id, \
+						  idev_id, vdev_id))
+#define test_err_viommu_set_vdev_id(_errno, viommu_id, idev_id, vdev_id) \
+	EXPECT_ERRNO(_errno,                                             \
+		     _test_cmd_viommu_set_vdev_id(self->fd, viommu_id,   \
+						  idev_id, vdev_id))
+
+static int _test_cmd_viommu_unset_vdev_id(int fd, __u32 viommu_id,
+					  __u32 idev_id, __u64 vdev_id)
+{
+	struct iommu_viommu_unset_vdev_id cmd = {
+		.size = sizeof(cmd),
+		.dev_id = idev_id,
+		.viommu_id = viommu_id,
+		.vdev_id = vdev_id,
+	};
+
+	return ioctl(fd, IOMMU_VIOMMU_UNSET_VDEV_ID, &cmd);
+}
+
+#define test_cmd_viommu_unset_vdev_id(viommu_id, idev_id, vdev_id)       \
+	ASSERT_EQ(0, _test_cmd_viommu_unset_vdev_id(self->fd, viommu_id, \
+						    idev_id, vdev_id))
+#define test_err_viommu_unset_vdev_id(_errno, viommu_id, idev_id, vdev_id) \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_cmd_viommu_unset_vdev_id(self->fd, viommu_id,   \
+						    idev_id, vdev_id))
-- 
2.43.0


