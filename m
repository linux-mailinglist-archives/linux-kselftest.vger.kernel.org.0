Return-Path: <linux-kselftest+bounces-21488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625AE9BD6AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22770281FA1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0B21732F;
	Tue,  5 Nov 2024 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHTNW3YY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A63217323;
	Tue,  5 Nov 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837161; cv=fail; b=pwGC2Pg3HEeetk6ePw3bk1hsNae9U1/rkqc7aBfQXhfCOUfX9aMkgqn89m+O1OLJH9rndjpZULWzPMgDnP8os6LNWBzsObo7Fih4rlsX4xwpGx+3iekFVnOZVfXDcNGvGmQQ13UnB1i3/BO4l/E9P53m8iGQH2bAaLEjGL8m+IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837161; c=relaxed/simple;
	bh=0iR2TvCKTXy+tSNdWlmMYthPMioAWJBa39mZuPN6hnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOyaTCogelnWGhXP1nbmraj+ArXQxHWrgmgv0ePB0bC44kHOl5ckKSU0011hlA36HIlAi3hEKWb87NAylewJA67AWrPu/UjMfYybfAryk/AJKMaNuIrzn2fbAZXaSJIZZTermQr9klSD6YaizwLFj1YeRNJ+HJtCG9dTMd9ojWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHTNW3YY; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNJ4UOW1viY9XoyfkYZmd9j/hj3AUuPc1TnaahQZir7MyJMl8E0pjbwbDZQp+h5zg8FXOWCymyM+ozwfZzRssABAXi8tBPfhIBbgHsI1/DNNp7b4JJIgIzmrsfdExtISaVinUW2PGWsfulNYFyrnTX2dmsblA2fEwIhb+pTnn/sccTdJM25x3a+8rU7jxdV09ZjPxJezy6ZNTNAlEj8od7AF1YdeT83JBiq4/trqdJ0z5ieZJXaCTRXQ21GdKbufJ6g0sfKi/KXoFO8wJJPYpcSnIiVjPjI0IufEW92ubp/B6t5NPkXZUpbBS5I+KB94oCZATwPIjudOABwRPDdiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh7X63HoEWtSrpjXbyuBXHc6XnMpmqYyiOYTC2fnRrA=;
 b=Rxr/0KyJGjPWHnqnwjgAQCVtoQv9sx/fVHzTknsAxdSqbQ6uBEbCR0WVyjjsNtDOFqIhZicOuvlMD6i0u+c1vw6Lrdon/lSMRY/APtOrkPas+fMHqIl680sQGGqFdUTNhesGQDYm9HX16T91i7T682yQXvlTgj1j1RHzMo2J1cI9x/spPdZb6q01aAFyUcwHKbr5hCeY9c9kvXE+i8wzqXLkFjw5mGn5HHvx2zwXo4tO8t4uIAlTdw5klSM6luZTiDuV7zKuOkAXjENok8pZf5BSwq+S0j3kYD7vA1AUD2QW7qn63DNPaNEhRMZG2N2CuRSBnwcTkAWLEHGcpLt5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh7X63HoEWtSrpjXbyuBXHc6XnMpmqYyiOYTC2fnRrA=;
 b=FHTNW3YY+gYvqEEQEhpsUqHhRGsLvHIqqCZu38zGzlriEuJ4aU9EgTB30+geGqDfuJTeN6EcAX+xb16tPydwMsiOSCstKnAuom6KZvX2rkAeGLSo1SLRDD7s6pn53E09K+j4HWpQF73he/Vh1459iu1shU/tlYQe97d87CTHKjNK6EK5Dj3peICVxEnk98T3YeucdC4ntBd4jlC2GFG8vFbhTvZPY49d6uT4wW87/J1Jm9207NEVeLNeG0x6sHCrc2WJR91nsN9jdFxR2ydw6g0uUFx6FBy00SHUsPCMI8ieivxmGBKfohOLL3HkT5tkffU3Vz6HKchnWc7TdR3OAg==
Received: from BLAPR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:36e::27)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 20:05:50 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::94) by BLAPR05CA0022.outlook.office365.com
 (2603:10b6:208:36e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:28 -0800
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
Subject: [PATCH v7 02/10] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
Date: Tue, 5 Nov 2024 12:05:10 -0800
Message-ID: <4b9607e5b86726c8baa7b89bd48123fb44104a23.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: be148b4b-014b-4160-a349-08dcfdd53d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uYXMDrKRs0nufFj01KiAXv2lIbJub2niqfCvfagWAUH0C/er0ELyXmhsl+n3?=
 =?us-ascii?Q?b/VaPKWCWd/esVpWMU9S6kfs0uk/gVl80CupckG0CNcm+Jws39AGAcLc48Ol?=
 =?us-ascii?Q?YyN2mC3Ub0NDAmPY+8L79EnDyJblExGbfJG8GF3vqwvg/pn+brbk+spFcOpR?=
 =?us-ascii?Q?0KjpyqPzzb40SWpLKhq8tT4ys4iFq4ai0JZd3pcmsyWV42TLhVjmZ9CITVr8?=
 =?us-ascii?Q?moI/y8asUfv7E3RzoobTR/Cd/qMqnKOpYU3sn4gwKND2CpWI6+SfxUMDK+Yc?=
 =?us-ascii?Q?88FLb2xose6aDif/fwg28U6AFAkhgC4PMeZdbjSluKQffg8BjaUTRE9rFeY2?=
 =?us-ascii?Q?DByjgujJo0YDASEiBUidcrjv8DuEtRM8VTna7mg0nG8YIFyYeyMzf4oDq412?=
 =?us-ascii?Q?BWueP02gX3VrUHcbFm1whrAk005R3t26ev+sby07BQxd0LpgY9ku7OqrAbFS?=
 =?us-ascii?Q?Deb1yB0liZgN5E6Ljxob7YOtqtdZtJkcjoT9kBvD596Pahu0nyE0GqiJ8gmj?=
 =?us-ascii?Q?Xv4gmETWN2L6j+cONSupeWQtqGNQ3afZnwvX1Po6ME2NlMv8fP5dmWXB0U4L?=
 =?us-ascii?Q?2hDgKgqC4BCyw2gojDipPma2vriCEG8joGkzruCCY6P4xO7TfauzldUP5/Li?=
 =?us-ascii?Q?iwq8/aC4MzBEgn8naD3k72A8yOUMk0a7E3OsS2XH1S0tttKozw8U2ykW3aZX?=
 =?us-ascii?Q?UKr9Vqf5/6aWeRmPcQDJkU4+Vkw7NC0/SD/cq9j/zc85NWRZRmTM21LlBisl?=
 =?us-ascii?Q?+0u+uEKVLFphc1PhQY4W51hiT4UmzyqKnOzr2kTPunGDrUcFvd2D/Sk2II3f?=
 =?us-ascii?Q?wg94n41U7jGN9mmdw9CasYcIJvSa1/YWbA8bNug+HchROy54Mbm21OrUq3Nz?=
 =?us-ascii?Q?/nH3Do3gDg1qe1UA7sLqg/BrzAeTNrf8VPTEuss5gQs0l+ClQ2DIbjGdkPtM?=
 =?us-ascii?Q?/wxHAh/MeWsY9H1GqWJw5azy+v4pCzhASw/EuBkYpx5wQ1shqhZp2wzf6efs?=
 =?us-ascii?Q?bw5nRjt0bhyEsOWeXnq1OaX3qydCao7IN0QPY5ZIDrltlKuKVRDvVVfkZuIn?=
 =?us-ascii?Q?oIhnI/bM+TPrJGKpKSvHXW8Iw9xvVMtaa5xyJvj864pqR9p60X88r9tjIZLQ?=
 =?us-ascii?Q?h5bWjI9t+oVS1iAuPsecuGpW1y7xR6VJj4lIDwAUCTIIY+0Fri0syKHMHyIi?=
 =?us-ascii?Q?K0dUmDdBbDk7RjUGZ8MjJEipbnUSTjqVfqJEGYZpFaWCmioZNG/I0R4kLHcL?=
 =?us-ascii?Q?QQxDbyo1IwWqEtmfOJpCf76JkznqMRO36G4wr7VMFjOF6vwwqrLxX4jCU50S?=
 =?us-ascii?Q?U/HmsaNmXo2wGhmqFCplSt4tp4vstqcgnKBYxt9jDSzHL19t9m62RZUfg3A/?=
 =?us-ascii?Q?HWZbIPnySlWDo9h8rTCFYgXp3hkojhvwZpPM7f075qjRwsTCoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:47.5047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be148b4b-014b-4160-a349-08dcfdd53d3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

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
index 37c7da283824..f3cb628753c9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -134,6 +134,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
 	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
+	TEST_LENGTH(iommu_vdevice_alloc, IOMMU_VDEVICE_ALLOC, virt_id);
 #undef TEST_LENGTH
 }
 
@@ -2617,4 +2618,23 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
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


