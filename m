Return-Path: <linux-kselftest+bounces-27274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B3A409AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3FF7004BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357620B7F9;
	Sat, 22 Feb 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXxka8i4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5A207A35;
	Sat, 22 Feb 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239694; cv=fail; b=j2Ae4ex7R8ksKhkjjoMYevrlYNFppFW8G74Ytwry52t8lYdhLXp6CjbxtMSjZJU8btV892YXMk+DruuMkUyyfo4a0+beGjXkpE4Cc8rpL6c0HfXTlwu5cTfZQGcmT/3YZgyWM/zYqGP/6YXakOIuR4esPTDxtz/e7MddONHDvjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239694; c=relaxed/simple;
	bh=y9EwuhnZ4+htKahcyfG7QKERsMxBHRmJhcDtCf5qHZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8AeYqPfZqi/j1og7DYP2aL4ALvFZOXS1CBbEE8yy1QH2hai3/HLp3ZUT2h1JcRrxqhE62bq7kWpapAaKVLuf8vtrPn8TydGM3B5HZaK/uQlukF6h7pumeZW4iZ8fkU5SFeYtbqFOZSlsOId/rFSYC4RWK06+DW5kbZY7zBixR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXxka8i4; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRn8EyLHSlWh6BKT4dpVVo4HzVbgDPYVa+ERBdbtlYcLIzMtpII2VDMXM7NC65agJ2FhlvjAOFORckmO/oy+wd62oEi3N2kchDVoUEDmBWnQsGl6ml4CiF0QsiFWjIkdmiuegS9ljoK340EXCFwpgirHVf0imWozwUcQgKYyGX9X+jinE6Gr2SraNHnmQuNBrjOgLmiT78adEu/kkyGdX+9RtAm9aAxMcykgeuTkYbex8aZrxadmj7IjTCPzpd0giGsZYGTWU7p/cDvCo7mlGlwrvDsKcSwgaG2k5eVEsQEC7mfl75s88UCoxo3wupyjv2NfOcvnOiPz72mbeNc5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1PBtA0nWPMf1GqEAuJn+ZSwJlfKukhl+iKUn1Pwuzk=;
 b=KY964QZuDJV9WuQhOZI0ywpkLjtH/da9Whau3Ytc7dTuLZtbduHfzEp8EcDbYeyEFOROsm49KZVcZgZzK0n5R0fIak93MQs7+wxrdmCbJB2Uqv6Bz1x97dACaHbscFKQ5BSYVMqPkrCpR4rQbE66/dCwIGJr+wp5D4z9jfSj5Eq4/YGUa0DFw3DYwh63xYIhsjfzE46IjE/KY0Obp4jTF355M5Ecop7z8R4j/YTr7hSA0wNNA8Sl/nOuzYA3HMJNVsJ73ic6eVwwBDH4a4HOsVfejhkgRNMBKG0woP4HgpQs85BcAtUJcT0Z85thhygp5RGDQL4il1kmI8VyaXaxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1PBtA0nWPMf1GqEAuJn+ZSwJlfKukhl+iKUn1Pwuzk=;
 b=eXxka8i4mzv1j2zf24IjOBRAwz3LiM0rVozpADteb+RLEI/BJ4UmNOXw+xIhbSY7f/mUWkp5XWDKWXNJBgXl4QMySeWzChR67ujkNwx73v2JJORQwTi+zRjeKxdM6N5Nrt0+CxNvGFQakVd4duWTiRjRoOS0ZfTpwDhHN36GzUEbG//izG8ujSKwG8UhTi1uTUU5yA+x/toUZdSEztBKx6i7ssqRnn2CgpHPHAfIiYNhL1mWtMJxsRKY3Ep7g7PLfTltQKwd4fK6MMSKapTDc4IRXLjwTBuJZ7kP7iiB1E3qg5Cx7UDxWUyFhBqDloBqjrtDDNjUhl6BwTzTrz5dxg==
Received: from PH7P220CA0136.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::8)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 15:54:44 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::ba) by PH7P220CA0136.outlook.office365.com
 (2603:10b6:510:327::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 08/14] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Sat, 22 Feb 2025 07:54:05 -0800
Message-ID: <295464f7f635a4fde7e772674136901662f74f4b.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b28863-0889-483c-87de-08dd535939a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qcOceyzv/sPR8RIJETX1TK6CuUQwCPBFYRC2voSIpFRZd3IPbXMWlQwu2UGj?=
 =?us-ascii?Q?u+6t6xvzXsGIf+jiYrePT2Z/QJNCSBw0hjdErDNPioD+vF3u36vNIFYqtAmo?=
 =?us-ascii?Q?U0zPq6XBfx2xJSyhlyIFBCXZPlep+epbeaW4Om93mNEGL810kaqRYQWtvb33?=
 =?us-ascii?Q?5+S3HcsIuf0hATo++FoMg28MrPxfpL6iUdGkn4Xzbl2iO8tvTY7H9mOeIvyw?=
 =?us-ascii?Q?89rh7sm8VC0RXOw1I67ek12dZLNSZsFdYz1d44XgYVTkhe9C7Sl/HSWH/f+f?=
 =?us-ascii?Q?LWKxd7WbbXN3v86jp4PuJ8N/mZHQo+9NIQFsTzYBSjqgu3FTV+2UzKvBNm50?=
 =?us-ascii?Q?0SQ53Lyh4bjLGpU/o0s1HexZOjO9TJSM10nMr1wvWiyNYz6dJpgvgfFGferf?=
 =?us-ascii?Q?EWSxjehOZQ8xxokmROR88TM9my4YlBgfHycED79MfTjCqy0k3T9T4haWkIuV?=
 =?us-ascii?Q?YVEhH+DpBI/TuhGqrtSAJOCReuV+Ju48eW8sYr0tCxKhPUCaRzRIO2FUimVP?=
 =?us-ascii?Q?lZX489RahVtGKDxD90fpWJ9V3K232kt7kqM+cMOeWnW2XBpoRhRhG9qEf51i?=
 =?us-ascii?Q?YGI5ipr6qndnF5EInveZi+TULXxaSqtjR7b+xMY1A3Ak8C8fSCXgxAhF8kli?=
 =?us-ascii?Q?i2cOQWhcAXR8op/dUrWFEPAZJwm99qd4R2HLOENVveC09i3JEWtjkIJPumNf?=
 =?us-ascii?Q?EcXaAQEjrAiDN2LxpBNDXyqWMxkhK8FoY4KVbnRNP/HX2XeHPxrNhUJzXmLC?=
 =?us-ascii?Q?1FGPsVedQp0yXSawpFwFOYGkt58MuSSOdJG3ZXAmV6PCkBWVlX+HakbMZ8MQ?=
 =?us-ascii?Q?5SvF3OGElZ9nLTQKOkWvt1iOWoL1CeozkhpL7nbl2sp6C7fitfwtt34eTg9z?=
 =?us-ascii?Q?erRWnpuSYw8CheR1/Bxpa+8EZVo7NxeCFuQ3ZGD+GSdLftaK5yYpMGVfSyCz?=
 =?us-ascii?Q?xThdRZVGf71yGVhcbv/2WQmzkS8wqd/5fe3doZn2rzTgzJLntl+Ud7kaLhkW?=
 =?us-ascii?Q?3fR/ljiMiFvJoGudd43ASxmC8HkFsdLhRWWtvLcJaLz8oY0xm5h3yz1E/pKK?=
 =?us-ascii?Q?o89gft5u2ugvOcMkuQK/nIPfEILwP6zXFSfUVPfiQBRgkg5ZiK/oTUeEhUgB?=
 =?us-ascii?Q?Sb0752YWI2muROYmfTqBWxnzqQmRBrn47A8rbf5x3T7mURqmZB5UvnFzw4Ev?=
 =?us-ascii?Q?EMcQeBCkrQSGET539CVHsWImr7plmcVjs7/vy+Qyj/hSPp9tadJcS07knZU5?=
 =?us-ascii?Q?XsIw16y5uLldPcbhPMkQkgQiepPfOCSld4jU5bBGpRu2VF0vciW6UWDWsGzz?=
 =?us-ascii?Q?HA73DwuvttDWnKk8i0OEpUXAlhPtDb5I7e/WrM+JzP1C4/wqbBwqzL8kL1AH?=
 =?us-ascii?Q?G7Go5ARR2u/m0zhTp3KjXGNIdvyvu/axBSj6pIu94dEy/+fFWXcCRAHkLSwG?=
 =?us-ascii?Q?GQEmSynrSgfRo6o184lxk0KkJXRYJ/GJqyp+YX6Z2XpswEq1DBBx36ojwDay?=
 =?us-ascii?Q?q8FpeL1VrXvOJC4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:43.9572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b28863-0889-483c-87de-08dd535939a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

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
index a1b2b657999d..212e5d62e13d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2736,6 +2736,7 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	uint32_t iopf_hwpt_id;
 	uint32_t fault_id;
 	uint32_t fault_fd;
+	uint32_t vdev_id;
 
 	if (self->device_id) {
 		test_ioctl_fault_alloc(&fault_id, &fault_fd);
@@ -2752,6 +2753,10 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
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


