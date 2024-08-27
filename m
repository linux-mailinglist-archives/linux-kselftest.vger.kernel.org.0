Return-Path: <linux-kselftest+bounces-16437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B039614F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773151F216E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BC1D414C;
	Tue, 27 Aug 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="td+QZvF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A51D0DC4;
	Tue, 27 Aug 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778128; cv=fail; b=QtUZtTznCoO0XP+rhCKY7jZ9CaJX8h0o3LRkeDlRkw3Guf605yg4lqPIWEuWaQTZpZ+DuP2RzHy6Fb0SNGTGipDOEYwg5EBBBHhGX/jJ1KE5RsA89Q9krysGizwrsBLvTuzyeRcsgJcp7vcrP8pbFrWwT44ejkJjBkc4FdkcfJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778128; c=relaxed/simple;
	bh=Nzaa0D+x+oEh/dLYkiiVM59gJ9x122X7ZJntP7gSbfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+I4JFM8WOwPLovrHU5HjvmafKgQPlOX2fUw1ONSMRriUi3ad8nBQJjNuFC9ZLeDlY+ouS0sHCKMWiiTlfk13vCUEUAzZBz2USKB0JmI6RyWIKRtrE6436eWnhxJ35PbKSKdP6KHSGYQBXSupEZHENsrd+A6aTM9WD6qBV5PqyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=td+QZvF6; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIh8QKf8eD8oWf63R5gfNbqlHNqwdxlBQLE56nfVZBjpprod3npfs2sGX0AZITiwZOgnvwJUUS3xmXPCsAyGjXdnkcXKb4KW2cTDBteOF2NjUP3IQDEkCMuFC/wjW/u4XmzqA3hxJbK7lEjFqoEXi2V6i3AAkTW0G9nqcDQ486F11KJTuZZQZoqFILAHnGCMPja7EFB2geTpZD8bEeNACiIP3HpPoqSOUTYgNS7bgjo4GBvtyHtksC+/WmC5MwwFqoJTku+k6QEW3neb4FwuzjU/ntA8NdgKi9I10Gxb5AWpoWdRXXfIdgG7SNsS3HyxjGGSY/l8rlg0qKLSifz6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nk4Q0eDsD7jjc1TKGB5/bX01umEaSqa3c7SrbgA4KE=;
 b=j/ARjGVWVPSp/rq6FsLtxOvVbc0KJ0d0UWkT3Xg807BTwQAySSGJgP8JAtOvwKnrzjZu/O2mWeOIwMOwmeWUqfPTWOoDhsiYpV8ojJHiFbOMs78kAEUZZV35MSTyivEoiUIuE2Wi8UVlaSHACt6ebfG9jTEJlOoDGT7up9wXAAkre0IiGHpa4IQEOewnTXizgoixWtjtw2v89ZAiEIfSOuDaWbuiJqMDhVOs2Qqt5cugk41itW3doI1mKgFBivkX79d7uBIPRLwamUbONYdQmyAVlti/KsXAwIY4DfERNcbbEZ/RakaGEu33O+l+nnAaj6ualtEp/bykYyPatBSVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nk4Q0eDsD7jjc1TKGB5/bX01umEaSqa3c7SrbgA4KE=;
 b=td+QZvF6mcF8b5QlgYF6JWHS8ICr0/B8obcoebx9QtBNklo5D0wNu6nl4/E3l4ngn/xgC4gfSbeK0iBXoFdLw7uRoZXaytSjCl6bu0po4H/RdrT2+fhQbZsTsFL7SxR7WxxdqQRrgdJRjPJ/DqBz5ZasQwxco56H0wJVyihx9lctR0o2fSFGG046eurk1UgyPdh+3cLBGycGtShQil/cuWpYZQFOCJ+z8c9FF9Xt4XZ9FbL6J1vmGSAPNkogqNhNHuYbJ48egHJDqPGnW/1em/NG2YYmHaoGTRB4lmegm/muSiB09jT+j6PCJE3Oj/RkI1oglsahXfdY5JoimbEStg==
Received: from SN6PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:805:106::25) by DS0PR12MB8563.namprd12.prod.outlook.com
 (2603:10b6:8:165::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:02:00 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::ec) by SN6PR2101CA0015.outlook.office365.com
 (2603:10b6:805:106::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 14/19] iommufd/selftest: Add VIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Tue, 27 Aug 2024 09:59:51 -0700
Message-ID: <9c79e722a0bae7d266d0dfebf19f9586f4f725e9.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2224753e-51a6-48a1-772d-08dcc6b9f779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZ1FUvynkK2cRLOwaCDiFtppi6w6nBpGm1qCfoI/bJ4Xb4uIibX+g0Lml5M0?=
 =?us-ascii?Q?j0NUnhyaN8F3UbiNtrJlZ2utAkChhWnprN64zBI1rGkltclUlzHcSdMk3afg?=
 =?us-ascii?Q?+E5QtsOMsuI6PvyGNAhHa72M3sVl3tT0DfSbxOhvsrnWH3MZBWRuxRKyEagN?=
 =?us-ascii?Q?+OvZ1knMERQ8dXa8IzhRh7Jdla3Z8GZgAGgWx+D2sp5uszSvAZj+IVxtVSC2?=
 =?us-ascii?Q?56uDSn+gzZL0AviN+chDlU0F5JP5T5fRjWae8U862/obSWYYvnFZIEHHw3l5?=
 =?us-ascii?Q?IQi6b0dy7YyKhvEljdQ66GS3NIqkVdmCr8xQPMKv0vBI+JIIkTVJ5UC47MoL?=
 =?us-ascii?Q?eevQ1WklvSjGYdyhiimQwPNvbjNUrxfK/WK7SebqpZTLxOyJH6wM7EajYcPV?=
 =?us-ascii?Q?f9yBLtQjoYosHG4NmCYHZO4LL1DBgyWqIrxDRPNXHg1RFQHzEw4NOTjecAAu?=
 =?us-ascii?Q?PsrSisI+9fSgg5cjN4/lSMUIR458E3FcKpIbqMHzopBvceoU9sn5b4RfaUjU?=
 =?us-ascii?Q?QnNesyMNdVrThEp15tCi3DKtF8K6xxQwP8TywxvjUKY1+ZH1Shi6uWq6it+X?=
 =?us-ascii?Q?eVeZFvWowHSx+/JSv98sVEQNu46CFVuBzokqIvfJeQ8slM7ell+BNYDjrUp3?=
 =?us-ascii?Q?m0wikdW07rk9GL4oYMUWr6dNmIhhnA5/rTCtZibm3Ow04YJQUp7YO3VSaZLL?=
 =?us-ascii?Q?+31XeJ0bnZYCHQz+Xv0hj0X6Wqho56/GLwChTXzPOvqU7tDu8gm7nGI9mlCv?=
 =?us-ascii?Q?AKo0b0EJeXy/oQSPd7C6iOIc/7eMIxqaeZnFkyNPq9P7nlVq3N3vSrvx8pcp?=
 =?us-ascii?Q?3l79s3VJ8utA9nY+suwc7apHKS1RYoSWLzyOEWSbrudMRUeKKs1n4DTKuGkj?=
 =?us-ascii?Q?gqP0pMi4xnqiNH9FQmuEO0A5TpUEGMJfTf9Q4VyiYkMAySud5Rvcsby1wj7P?=
 =?us-ascii?Q?6XTCNEVub2pA45t3mJ1+6X8exm5AYyPfX+jUlfD6LvxxGuE7wpDNG/RMQA8H?=
 =?us-ascii?Q?cpvRYePXgRk3pkQHNmJ8nHLUcdUyD/+guJ+LOoM26uhKgovRJNbK9MSfaQMX?=
 =?us-ascii?Q?x7PkxQPl3fwS89lgBhP2jfkPXjFKvHP21YiU8ghwmsOD1GbSgVoq5EyzPwZM?=
 =?us-ascii?Q?jJXzaG2PIZRKByMy+5A6N4S4DlqJqvgn9DpsPcW0tk4p5NirPHUtlpyNeh30?=
 =?us-ascii?Q?tEsoi4a/MFxKSGhvk+JVPsVSLEngAqV57iV9UltVagqZQvPRC3Rnprmf5/AP?=
 =?us-ascii?Q?eVLn4xiB4D57jca8ULbreTWT07Xa3Awp3iUzsXLexeEiAXY2wIqfbpmk0lk3?=
 =?us-ascii?Q?Xg+7dtslzAlH75slVd+kVqucT2qwdgdsw7VT1n+eZ20Yx/RG4rvDCpC9gzjJ?=
 =?us-ascii?Q?PC85GFPb5pqIzLM8nBvpm5rgxpneoZViyvfQiSWcqWuNgwlOkzEw5tvvxy1o?=
 =?us-ascii?Q?5ViSRPqccTUM48GliqW4KSSsaCRkFan9?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:00.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2224753e-51a6-48a1-772d-08dcc6b9f779
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

Add a viommu_cache test function to cover VIOMMU invalidations using the
updated IOMMU_VIOMMU_INVALIDATE ioctl, with similar postive and negative
cases to the existing iotlb ones.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 190 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  32 +++
 2 files changed, 222 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1b45445dbd53..6f1014cc208b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -614,6 +614,196 @@ TEST_F(iommufd_ioas, viommu_default)
 	}
 }
 
+TEST_F(iommufd_ioas, viommu_dev_cache)
+{
+	struct iommu_viommu_invalidate_selftest inv_reqs[2] = {};
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id = 0, hwpt_id = 0;
+	uint32_t dev_id = self->device_id;
+	uint32_t viommu_id = 0;
+	uint32_t num_inv;
+
+	if (dev_id) {
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id);
+		test_cmd_viommu_alloc(dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_cmd_hwpt_alloc_nested(self->device_id, viommu_id, 0,
+					   &nested_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id);
+		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x99);
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
+
+		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(viommu_id);
+		test_ioctl_destroy(hwpt_id);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d697a7aa55c9..0a81827b903f 100644
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
-- 
2.43.0


