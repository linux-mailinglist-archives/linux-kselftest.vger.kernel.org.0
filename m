Return-Path: <linux-kselftest+bounces-20359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB39A94D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB4A2833D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DB1FF7AA;
	Tue, 22 Oct 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G4IoHB0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E2200120;
	Tue, 22 Oct 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556471; cv=fail; b=RjiVy5siD+6pfoI/DlU5jqZjQ+UWHF21NTBc4CFvQv/X8+Iae6Rm4eDAXaZUGIsUiS8lfw3lJ56cfV4BDbPkspIoTtM6P/tsYEcrqcXFRM7F6XtmISw4oKkOVmI9gMfWSrAXRmdBBuR+/DYn1Jvx9NqAV0XhJ/1IJGWjckQ2fRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556471; c=relaxed/simple;
	bh=oiSEkzSztiLGHdM8oDZQhh185jupsr7i2cKe5Xb9PoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhTII+Lhcfr12h463yyxhCY2woY0pBDy3dXduSS06iBZ+uas+Ck+Rm7i7OmA41MmhlSrwF9/7dVKIccxBYXvam8FUBBgYdrF0bjNAaBeoF3Yy0NEiC5h3/oASleZoZ146axQI6vZd4sAnrfddGBzs4i8yJmWGpu8WOyj7oHcjzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G4IoHB0i; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2RaF37CzIp0Rsfrz2l1MRpfX3T+qmB0awhBNyHBk+aibgadkcA+nDXwSKyW32nzhxOSdyRvBiKrc2wzytzlpF8dTDdrQijgF28oO08fkYI3tcSIwlbxGTR4UqLpdtn0lxLRu3rPBmy9D9qZj5qOtyQNtB12iXJ88nEjrlglS3u0ESpEgRIMOr20w8GpNTkVNRXRW0/AhExGQMez1BFsa6yWj1qdvktrfXk6FkWbCnwRNw/+zSY9nuiCimUiPGZogJeslvdPFgrTkAXccXsS37R8j9QlpnR+pHpxRe3nn+1pUDhHIk9f+hYeI90TvmuvQI92bjSycomSK35mC6jOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP5SUkpFOyldAeG64DkAlgp/ANrr0ntMTe2WM/Kl4FI=;
 b=UgHE7mkM5WMTLX3XBRPWLA+1bUFJZhNSzjS+X4Q3zWfu/+Jw3gxNfoyRQMe5W88y2t26b9jzWvGtuNgRb5nVpHBVayAionDfffgXlgNFmmB4kpURwXrsdg+YpUh/XpWVBMT1deaqImxuJhuE8c0S89o5PjLRK/NU71cYr2RfI/5jOycfk6oBgEG/YbZN8w2CUuTYjrPsxaFH0ozVXG7kAHWUrMkOWbgqU/IAPGq9eaDlgEhav1+u/fRkb/DYeudqjJ5f461pR0oJewjGgJxHiC0kwqDXAD7Uga5jLvkEcCd6sZFZZO0b3oKnG5QsrgqLPC6VUD/MnasH0zhEapno2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP5SUkpFOyldAeG64DkAlgp/ANrr0ntMTe2WM/Kl4FI=;
 b=G4IoHB0imq+X8OBmuUMnZCk6LNLA8R3jJfGxAwnyV2ynMiNyIGI/to48zS2X+4OyXsuiUNGHU49c+6lC8cyZpvft/JZGwHon1ibTX8iMUsfJOR+PRL/Fua5/9fuAyg/pBPP3Heyi99WaYbptCu4CCWjlu+pBYG+xSowOziTPM/ieTvYUw5BzVfeMfyNmSox+8klPoLAFk3D+nD8o9lf+/+OHJrWe5FnGU3gqI2NaSDU+mBdMiQPsUzkuojASrF/qm03v0yjDCD4sFDP60E94k5rVio3BcrN6ywmvpezcLYWcKkqp90sfZd9CR6RBKfwAXtFmhjpUNrpYVLL6eqzffQ==
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 00:21:02 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::87) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Tue, 22 Oct 2024 00:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:21:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:42 -0700
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
Subject: [PATCH v4 11/14] iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Mon, 21 Oct 2024 17:20:20 -0700
Message-ID: <ad0421769b8673ff715e4e31b33c37a796aba5ab.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c06d3a-d393-4194-4cf4-08dcf22f68ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVBlAhdsJlKqp7mbBTSF5+8IvOcz2aCJIQhCvhuS9ZzyMX/gisZISE+S/yN1?=
 =?us-ascii?Q?xAeFo5O9QkzjJX8ypDUOci1hMi8zNVmzthZbdkRy52piEfTPLX3xer2nO92k?=
 =?us-ascii?Q?g7oy2kcVGSyxXseWh2mUsWTLQ7GWUvOwt4284u3RnY3U44Mp1KWATplOzoTU?=
 =?us-ascii?Q?FjJVPnLHyMumvZaOe7lS1fHMfGIPHcaIC6K+FwXm0IPkhDHyzPEMJo8mifWn?=
 =?us-ascii?Q?FpQ8a7ZLL+LxM+MbuF53gd+CHvNSkyPTuHbZmrKhigl4bDdgbIcpe6g91ln+?=
 =?us-ascii?Q?RUXX1WjxBqON8dPpDrg776MeyXwSlvHrvSHdZ+9NuDeYdTPiMICvLuc1y3+J?=
 =?us-ascii?Q?22vyBv6ySUZeSWRaqavmdCVh2HEDuiNt0pcSssTuIB1H7OT5w2WfUxZZQ6ig?=
 =?us-ascii?Q?ZGneEv52mVTC2tLyFBHaPkNS4yrVwXhsC3dc7IIiVBO2bDr3hEOq1ts5KodH?=
 =?us-ascii?Q?Xtxh8W1ehs9oaib2yw/QPWXwc88QygG/WPCWdP9Om0OqHubXKuETwzU0RDS+?=
 =?us-ascii?Q?LRtrqIBt2VX7w5iqW+PixPxvC1BfWft8O3iL//tBqLjD73by4AJaxoNdZvcR?=
 =?us-ascii?Q?qywQukRz2B8QEGyD5mT4jBNqRcAaTDxA/ZCBzAQDJWdq4Y4LP1Ge5S+neWfo?=
 =?us-ascii?Q?28Vy6oBtfbuBeHuBR9tpT1HQ5ueYQWzram4vJ9Gni/QSj/V3fAeYiJszFaag?=
 =?us-ascii?Q?d7ykrVkQj6n/LDG3fKPF6iEBbTMNctgJqw/M+B88glDiUd2iu3u2HpwHjNWw?=
 =?us-ascii?Q?aHn0CJOC+okmlpCeqKiUMlovofNxNPcgDoPXBIJglqi8YiDwVB7mzM84ZYgB?=
 =?us-ascii?Q?DVm4QmoiQMrseOa8425LxiuOfvL0h1AUyfFCe7bZostrBNA93u7Ghra+aRfo?=
 =?us-ascii?Q?sZaL8cUo2CUifA/gtJAbE1yqbnZun88ivjM1oszLK8gk9hQNzprlzDQuU6C6?=
 =?us-ascii?Q?kF5B8MoufLRMRwIOPTloVxSTI+OQp79u+uwH1qwhmuGXSTdKPc5O6CDbma9c?=
 =?us-ascii?Q?Mb/GX86mHa/5HKLxz9wYyt0sFCPnmwAux2yKeNwrn5MC1hSYr/S2DrvfA8q3?=
 =?us-ascii?Q?Gy1GGVDvG29RYA3mbyrBFJI98WvB5+naZGP2PYUFCuUv/bPCJq69Q6Uezfom?=
 =?us-ascii?Q?yqLc6ijxD36ht0zhSNM06jWjtU3qIkiQXY7Ns8IFW/6TTkQEo88KDKoRad6Z?=
 =?us-ascii?Q?rPAArk35IalnKqOUZ2tI+qCDoX+/dqHSl0EjT13QDbNgp9W4MCdxwfLN1J+k?=
 =?us-ascii?Q?I0DkHnQG2q9MwlVd142kzaz8HGdisIRr0wsDTorRZISP2UkD0dAUmS0cfxFI?=
 =?us-ascii?Q?+glmPovvgQPIGvx0dHOVQV6Y/evOBlgDsirvV3i90aQNiDPXF+yTfRzR/6g/?=
 =?us-ascii?Q?36qE+EhYrX3sinVUQEDqxYLIfI4D985xO6nahqPaO9n/sxLFJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:21:01.5634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c06d3a-d393-4194-4cf4-08dcf22f68ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

Add a viommu_cache test function to cover vIOMMU invalidations using the
updated IOMMU_HWPT_INVALIDATE ioctl, which now allows passing in a vIOMMU
via its hwpt_id field.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h |  32 ++++
 tools/testing/selftests/iommu/iommufd.c       | 173 ++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3ae6cb5eed7d..aa458c80ad30 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -289,6 +289,38 @@ static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
 					     data_type, lreq, nreqs));   \
 	})
 
+static int _test_cmd_viommu_invalidate(int fd, __u32 viommu_id, void *reqs,
+				       uint32_t data_type, uint32_t lreq,
+				       uint32_t *nreqs)
+{
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = viommu_id,
+		.data_type = data_type,
+		.data_uptr = (uint64_t)reqs,
+		.entry_len = lreq,
+		.entry_num = *nreqs,
+	};
+	int rc = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+	*nreqs = cmd.entry_num;
+	return rc;
+}
+
+#define test_cmd_viommu_invalidate(viommu, reqs, lreq, nreqs)                  \
+	({                                                                     \
+		ASSERT_EQ(0,                                                   \
+			  _test_cmd_viommu_invalidate(self->fd, viommu, reqs,  \
+					IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, \
+					lreq, nreqs));                         \
+	})
+#define test_err_viommu_invalidate(_errno, viommu_id, reqs, data_type, lreq,   \
+				 nreqs)                                        \
+	({                                                                     \
+		EXPECT_ERRNO(_errno, _test_cmd_viommu_invalidate(              \
+					     self->fd, viommu_id, reqs,        \
+					     data_type, lreq, nreqs));         \
+	})
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 79b0739d586b..00f08f79b0d9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2489,4 +2489,177 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	}
 }
 
+TEST_F(iommufd_viommu, vdevice_cache)
+{
+	struct iommu_viommu_invalidate_selftest inv_reqs[2] = {};
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+	uint32_t num_inv;
+
+	if (dev_id) {
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+
+		test_cmd_dev_check_cache_all(dev_id,
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Check data_type by passing zero-length array */
+		num_inv = 0;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: Invalid data_type */
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: structure size sanity */
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs) + 1, &num_inv);
+		assert(!num_inv);
+
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   1, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid flag is passed */
+		num_inv = 1;
+		inv_reqs[0].flags = 0xffffffff;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid data_uptr when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid entry_len when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   0, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid cache_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid vdev_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x9;
+		inv_reqs[0].cache_id = 0;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/*
+		 * Invalidate the 1st cache entry but fail the 2nd request
+		 * due to invalid flags configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 0;
+		inv_reqs[1].flags = 0xffffffff;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = 1;
+		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/*
+		 * Invalidate the 1st cache entry but fail the 2nd request
+		 * due to invalid cache_id configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 0;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Invalidate the 2nd cache entry and verify */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 1;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1, 0);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Invalidate the 3rd and 4th cache entries and verify */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 2;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = 3;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 2);
+		test_cmd_dev_check_cache_all(dev_id, 0);
+
+		/* Invalidate all cache entries for nested_dev_id[1] and verify */
+		num_inv = 1;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache_all(dev_id, 0);
+		test_ioctl_destroy(vdev_id);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


