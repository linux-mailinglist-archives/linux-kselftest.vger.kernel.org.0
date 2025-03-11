Return-Path: <linux-kselftest+bounces-28772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05CA5CFBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6027B189DAC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF3264FB6;
	Tue, 11 Mar 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uP+74oQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91015264A99;
	Tue, 11 Mar 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722340; cv=fail; b=eNVptVOTWJ/mrJXBj4aYQXz2AxV93jhgOWDARV3OlcenfO0rZWj/3QTRwXCQJVvRpj8VJD0J2SGFtlv4MiMai3FlYJaTNSnOfnZyjNhQVNkRwZeAJ61FYYCslnRTlSxPYmmxeushBhggOfS78xYm+tT/F+AaVmzd1bUiSs+Dxx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722340; c=relaxed/simple;
	bh=6x/KeI+hQAe1q8vMFdGBH7dX0qIPhY+HRMENnw95uWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKMY2A/qYCKjyuguDcmP9JEVTRKj1mMYh1qd3kt/dKui8/XSWYhuaKqMCarIrpA1s0Sk8Z7Ft0QZ1l0gYrJKJxdJA8IM38Si4rHK1EYeohvLePzh63pwgUl+2rFFXkd73BT/sz8WMzYsB7I2uCUABhi0DKvihs10X9eVFxNjq+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uP+74oQr; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYXxhT0hDb99ssGF6RQfcLDtq/ZqhyYaSlO9S9qLr413U0Jl1jNSVvMSnKKfL2TJ4OkehzWpClQwQQHfI7Pt+jSt5TDUIKWQm3qh9nC3qNg/9A/a0ny3HLcz3sX99Kh4BaVKM44ZWrGANMj1q6sw7xtokFrzt/62Fv3YUZjfo4swsEkE4+QyH97+UKV5Z8HJ3iqzY1NmDd9VVvUFhPzAxeyTkaLz6VgIG1Z2VoWR/vKdqAFmmQH+sO9F93aW/JFFXn3PojhX8CgTYD8frpszykmyPP6PApUV8gVs85l61I0uyqK+m4ux65kfHvucPxOQRzB6u9xTLrIylNaCc2hAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cW7iuMpA9M1wRCn/9vI/CPEQZIaqOV0nHMfDByIeBw=;
 b=KHg2lJ+ql+nCRRMdI92lRfWxZVXRwilL+8AX9x0EtFgYglLKpppX6doFle2Onia+vG6qmKyBWvYeGlpd6lNRP2r63uMEcIBahnOVjk4nnirr92sUd0WWv3LERGAWcDNFCAwGxRt30v96KirOFL1IMJbdWamAz3b6S/M6xtel1EbxX/Tap4nfsMkqBmOZARI4boOTz280luxUxwO9tgcUnZcBF/LwBqrG0l2Bbu3c6xnxVuS6EnhJ0HOvB4ngfvA+mTEi3zXBzLTNEsZ5XRHQFZttUZvsmtWFQPkCR+42Uii3sQu1WrNQ4dz1GBGMPIWHZtcuZB0GlxRXH092wTp08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cW7iuMpA9M1wRCn/9vI/CPEQZIaqOV0nHMfDByIeBw=;
 b=uP+74oQrn7AqXRWym1YxKQi7R7qpshURbcybJfJLM8EMEMGpJJVS5s4ZkzPkLfqgz53U3FArQHL2lcw5CtiMwwl+PwZKWxmBnVOmzrYqlJSn9jolVxaaWHm2wh4OumM7glrHpllZFdujcVuzH5nl6sqX1at1NbFGh4BNuu4LD3A+KzsNKX2i1s4vtib3rJfTp+99U5O01gM7gdz5Lp556qupRY31AMi5piV0cCCAZNW5EYBDpnJhLU0aJFge4TupciahzOsidDXIXXiGWn7/bwczbrPdfyrPiTtI285S/3jYjaIcVA9vbQgrtgdBTaRXwaOMeQ9/YLkAMY9fJqu0PA==
Received: from BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::22)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:32 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::b) by BN9P222CA0017.outlook.office365.com
 (2603:10b6:408:10c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 19:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 08/14] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Tue, 11 Mar 2025 12:44:26 -0700
Message-ID: <4051ca8a819e51cb30de6b4fe9e4d94d956afe3d.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edbc4bf-77ed-48e8-9a86-08dd60d548e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XuBNV09aKVg+fAmsuLRD97lNbeNY649E+/urIf7rSOt6rHwn0u708RffFnVW?=
 =?us-ascii?Q?g6S/6hXSX5BPMAZMl8Dht9avSKjrzAobS4txFFATr9xNlKA5yQFY4VyEqJMT?=
 =?us-ascii?Q?QnWg3errX9n869qhU3WYxy1Xa14Lq+Z5+MoVF9Q2Kspfav07JcyaTHiNBm1v?=
 =?us-ascii?Q?ZppAlLhpyCB0akU2cRqD5T4/6vEXrvA/rivw26yg9YeQmTXeOkWZImBFuoXl?=
 =?us-ascii?Q?znRubtRj3ov1ZsUVfDn1HFt/pEYRTuAGZjOkAPa1RCnndO+lYXxi6wROjcTX?=
 =?us-ascii?Q?QIAzFnv5SAHaSvvDnQMnkSun693Q+9bI6DkoBustwtQ6q5BlSkzRy6tqtkhz?=
 =?us-ascii?Q?lEhbp/NtJvxKurt4NU/Qtzewx0rl4HYLDv1nDBASvuasaB9hEwWgPGYmq6KC?=
 =?us-ascii?Q?Zsoo+xNzv30v8iiMGD0FZwNur2AMjNAcMDL0wVFzUFR0u1Z/ZpcCo8pzFBgv?=
 =?us-ascii?Q?wJ2A9JC1iTB554MKCIAQVsl6Ly5xKkSPRYX7QJqP9WRvKirXaf8w2vwRnupI?=
 =?us-ascii?Q?/MsMWRVhFcaQd9wV0K7eEQfReOYyaHaOpuPsF/gMWiw8Ic/SDjZXgy7TZjWp?=
 =?us-ascii?Q?iBLw+W9QoCiFst06gQOYMTujrb9Zsq9npWwnk2meYJpg7g1oP4MO6I1OKnbn?=
 =?us-ascii?Q?4bGS5ANiJaOYNks/MiIcpDzrZ0tRfV3eV1VXPGWwL8rC3OOziPXzMrVJyyME?=
 =?us-ascii?Q?Wye1wJWiej2jF76gfVTVJYdRTE4mJvYHQgpE0nfm4VIj+F8yaJL72E2tS2Mf?=
 =?us-ascii?Q?FULfEl/r510taiZ0llsk6X3CIMwgGkJVnRpf/MbAr2EuEMpZ3gcwfDDT09kL?=
 =?us-ascii?Q?iB8Ku4BiwI2TiRwdekI3NROx1bq3HW026R+7zo8FsvEjf1MPVxbSsxLSxwwa?=
 =?us-ascii?Q?JYOZKxYwj+cvSKYV5r8iEpDze6iKyBKRwz2jD+YOhBc/Q96NuYl7zseS3MIO?=
 =?us-ascii?Q?OwRQv3/VQ84rpBCP0AWpwDLcYvC1DezgfDqDXSaKyhpIa7dKx4YS8btvsY9v?=
 =?us-ascii?Q?ElNNCqa6npJLTW1yG4izKPf3PAC0gNovjcIjWkaLe42LnRl4WiYdHr7G5H/t?=
 =?us-ascii?Q?QN2Dl8/lWVGY0JmhYr/H99/iuPLH/2k8otKMKCvbxU3bPsclBNfHTnQ1insJ?=
 =?us-ascii?Q?3bhH9lwC7T4AuEnJcf8hyU55hVZTodsHJ7WNYKLueHQrXTVsCSZt0SO37Fw+?=
 =?us-ascii?Q?etARg62e9gCy7UiZ3H5gDQKrcgVPjo5YQ5cQK1z406DhS0lL4/CGSSQMiq0f?=
 =?us-ascii?Q?J8yM+zyvX+OC4SUyjDPvXPBbHyadWe2DanWdHpVahmuOO5GcvS+XIBpBU8Yd?=
 =?us-ascii?Q?km5WamIbmCjaW8zyVOhxAEAYP2AacOugoszaFPiQ7PzMD2Rteo7eNeUc06ln?=
 =?us-ascii?Q?w76Fcpcx2gLwgnn1eyGLN61XwW677L0BA3esOPY5xxe7XiaUrgoJEoRNV97Z?=
 =?us-ascii?Q?P3MANge8ZwURHLDZASh5z/7Vq+a4MLXPBenftcNZHxeqykk9QeK3GHBVBaMW?=
 =?us-ascii?Q?yy3vm8g6M1upukE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:32.1023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edbc4bf-77ed-48e8-9a86-08dd60d548e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

When attaching a device to a vIOMMU-based nested domain, vdev_id must be
present. Add a piece of code hard-requesting it, preparing for a vEVENTQ
support in the following patch. Then, update the TEST_F.

A HWPT-based nested domain will return a NULL new_viommu, thus no such a
vDEVICE requirement.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c        | 24 ++++++++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..ba84bacbce2e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -161,7 +161,10 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	struct mock_viommu *viommu;
+	struct rw_semaphore viommu_rwsem;
 	unsigned long flags;
+	unsigned long vdev_id;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
 };
@@ -193,10 +196,30 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	struct mock_viommu *new_viommu = NULL;
+	unsigned long vdev_id = 0;
+	int rc;
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	iommu_group_mutex_assert(dev);
+	if (domain->type == IOMMU_DOMAIN_NESTED) {
+		new_viommu = to_mock_nested(domain)->mock_viommu;
+		if (new_viommu) {
+			rc = iommufd_viommu_get_vdev_id(&new_viommu->core, dev,
+							&vdev_id);
+			if (rc)
+				return rc;
+		}
+	}
+	if (new_viommu != mdev->viommu) {
+		down_write(&mdev->viommu_rwsem);
+		mdev->viommu = new_viommu;
+		mdev->vdev_id = vdev_id;
+		up_write(&mdev->viommu_rwsem);
+	}
+
 	return 0;
 }
 
@@ -850,6 +873,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
+	init_rwsem(&mdev->viommu_rwsem);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 618c03bb6509..6a050a1d64ed 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2740,6 +2740,7 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	uint32_t iopf_hwpt_id;
 	uint32_t fault_id;
 	uint32_t fault_fd;
+	uint32_t vdev_id;
 
 	if (self->device_id) {
 		test_ioctl_fault_alloc(&fault_id, &fault_fd);
@@ -2756,6 +2757,10 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 			&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
 			sizeof(data));
 
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     iopf_hwpt_id);
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
 		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
-- 
2.43.0


