Return-Path: <linux-kselftest+bounces-23478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B69F5DF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD1D161F9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D80149C6A;
	Wed, 18 Dec 2024 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQvYoJLj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCE3224;
	Wed, 18 Dec 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498097; cv=fail; b=i6+x1u/BxFH2oFquYZXn2ekze6Inb0vqdawTNzDupFXaJFnh14LuVmw05xeP9wZ0GmG7ygfzOdUo9usjNg/zz4jHoMbaRIV4qQIa8FRzJQLPysQ3gz/SHfADdS5LRZEviIaA1sSuGQD3JjuM2HqXTPOcQUvM6ug5rnufQ5/lmg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498097; c=relaxed/simple;
	bh=eds1NSD6WKdzRltBaU+L9jFE8CCpNqeUdmDKd1I6RYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv5M1BKXCa/ba/U68xk9pi+JUQTx2rVQcxmXvvLu48G80iadjnOjh1KZTM860eOwhQN3sb4goT3xWkjNmVado5i0S2dNUwHuP8N9ld+PjfnI1XUkNJHCOEYsOkOMmBaqZlaAq4aK27z8N+5nxDxCidyhK/ApthvC9cwgLgBy4FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQvYoJLj; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbsVeBv7FNVAxaY+qGjfDHhr2U6S/N2+n47R+jxjT6iBoVKdY0lw/5/pekPCTDtxCcx9K/lBpK2in4S0upOequYjifoG8hf4qlmqqsDcQnHcXsiL6tVSQPuGUVkzpU4MTN1zV4vvki20eMX9sFJBISIsJirs1tUIk5tN9qL0hCubCaYrcZlv4zbMyThmbSbyemzquiWPmkFRR/PlG4F06Jfd575UneIswU5FJMY3nnR3RvtbZIKi+LH4h6eVtZy3zUkQNgwRbZr/u4RPf1yE7H8y0Ka0CB55agKbwYPs60CO5FjC9UOKoyV3SxSirvX5djwl6sWRaIN+sCZioF1KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvJ5yxzr+3FVoVIkxd1H88sCacDZYwifbvXW+vRvIq8=;
 b=EpdJkdfyv9Ebcjy01rsCBGSTJtXmQXkhJSYVSHBp2qcFWkKKvlPAz5/AOvhxdVvjKNdPgJqY5f+5vEQjOIRBfRK3qjrvgCIhazgeHrRT0qdPDfJljLDoJH0q3erpI1zyQ6RTBzRUGxh260SZBkdQt48/c+3JroMHBjOvCRYvtcZrXetlpA1KRWhkx2TPJLrutzXpvreWkra0G9dCYXd16oKDcZ1DxoyeXV2I8HmErH5Tv3QFxguf13F/i+CYSccm6eOB1CQcj8y/FhmGQ1snOhbWBRxnV0hEXe9fomdqXgM53c5NOZPfksRg0gH7tE9L0XMTANmMVZ7aY3Vccd0fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvJ5yxzr+3FVoVIkxd1H88sCacDZYwifbvXW+vRvIq8=;
 b=iQvYoJLjME5E7LytT1udCPB8JEyhMmA8cONxtapr802cRCVFNF5pbsADmsDJDuFV1/X/07QZAaQWAxaqymrzUuLFcF0r4L1t1+ydqUyW9IVrAlBNCwXq4HIka8tnqt/nNsnN0c9COV/SInpk0x6tNSWtruEz9b2oPwKhyomvTBbD44VJzLJRhMv9pUn8ccq0YPIT7EsNuA7jTe0j28fzw/uLyYFJqDEyy5wStxUSe+v8X1jsRSg4eHN1/wn3SPchJaN4dSUED9n5oWY5aiQt0TI/hc1RA1Ombs92Ji2cBVXWDl1+Ewn7dCvHhiNdINN61qjPzU21zVbCrOXZYotNWA==
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Wed, 18 Dec 2024 05:01:32 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::92) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 05:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 01/14] iommufd: Keep IOCTL list in an alphabetical order
Date: Tue, 17 Dec 2024 21:00:14 -0800
Message-ID: <0bdb04c6dc32f428a7f181471a0d78642e80d3b8.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ca05da-10d6-4690-5b63-08dd1f210a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uR6lgqKyrq26auakH1R6zKHTPytUpTUNt5VImeZNyhCtoju8MKiR06dPi1l2?=
 =?us-ascii?Q?mvAp9wKRnxlBT+RDKiSUKXAmnQU8Y/x6hCEuR1ezBc/NRLxxTUdUvui+OqJJ?=
 =?us-ascii?Q?pb1Q0ewH4RSEWGPAuDbgP5oTYigV8f7O7yld2UU6BG8KXOfPhKBVsH7T6vMC?=
 =?us-ascii?Q?TyEG7UUOCHeJSDw1VF1U8szh9ihHE2Fzzdwq2IAulsH0i9W6x8mYeIRFHXee?=
 =?us-ascii?Q?XdiLxzvqob/F03t5dqk9M5tqpx9GgQYeE1qt0j5KO/AzODtFm0XSpcAdE/Bk?=
 =?us-ascii?Q?BBHdcaQHoG9bleYGFEy2OOkm1NdKDe2etN/ZGFZgKmFowuXiPmQB5qsWllbu?=
 =?us-ascii?Q?bawCj1SrX36WvrIlrjwXE9ikZH7QhmzemBnwhEVXILBeDexbEld8jKYLEhOq?=
 =?us-ascii?Q?9lH/g9Dpf8wJfedyvepqI6OIkqz19GelU33WIUjSzX1AoWtPPEp0+9/5FoVv?=
 =?us-ascii?Q?As2umll6dp9PGZ+5iq1wCyQ4ul7b6GHi4n15xlY7c6YVah3ZenxEUOGWVOIR?=
 =?us-ascii?Q?RJYPD2GhE0y+jkf/8CUbLJ9vK7Jhk8KpwmXwdRv2AX5yBgjQ+aGAJp7DtD7u?=
 =?us-ascii?Q?XOU6kkCbdCb9oXgxukZJrbHM0K93a03lIrRhW4WScmciruRzPlnnQGQkdPBK?=
 =?us-ascii?Q?BVkE2XFW7lqGYWFOICL+ZPdxghb80oLB1Bn9kYoJiOe3kDJ0abNRBhTVGvHb?=
 =?us-ascii?Q?j/aPqO04hR6wiZCgzv0fZD4vmkvDcz9EuhbKZEb2KVn3JwGGKqDUTx0Hytd1?=
 =?us-ascii?Q?XKaVlRf5X+8g4Y4F1HmGacTG92ro+at7bg9ah+HHjabSBFEqaNt+I0xzxRPB?=
 =?us-ascii?Q?G1OSSHXU0Uqf/GVtENEE10CzTNMPOaJU8Hmu1W2Y7rHGT6s+l1pHEPGEC8Xg?=
 =?us-ascii?Q?54ApRg+NyOaV/IkQgMxA4Yj8af13D55gCSV6cgMa3UFsTSDfNWqMxG76NUH5?=
 =?us-ascii?Q?0Yc2zsyR6w1OyGBuOH4ddWw0tfo0Yc51TenGq4g/vc8V5LbGpJwp7lfALpP8?=
 =?us-ascii?Q?YfzwkBaIDDgCPa1OuTR0ezfay/yD4pKI3en8m2w2j1Kk0Nao3pkyROaWo2dk?=
 =?us-ascii?Q?7ZOcfdCkJ/IqgIaTpq5CC1BsqTRWF6sG2MwbbwV734zzIAbhWTOfpdlOjMIl?=
 =?us-ascii?Q?7Ge8Cs8tALxPEQmxdq6xams+oYapV0yI+GaEaeL1Z1DOsbv86eyvOCbYRLhE?=
 =?us-ascii?Q?39fjitdNXPSh+QyCbZ7e2kg3StX5fDMey1zikv33P1E4DdR0oZvY6b5QGSlk?=
 =?us-ascii?Q?a/MkImHxhiDrmQWL+D2c8SglpY2aKU2XcBM2G98vj7ZFREOHKMMB98EZB50L?=
 =?us-ascii?Q?enoBt5+0az16KFsmeS2hEFo1zMPl7Lsx43/MRWD8HBhvDX3GB9YUm6a5FDgY?=
 =?us-ascii?Q?Sn+ofsOo+dM+8aDykeF09poqp/77EADjUnzSqErpW487vunQmAz/pvJ7NLlD?=
 =?us-ascii?Q?KFEZq/vnNpkYt56RzsR82fssgRQVJ+Pux5/sYmYkqADOvRh/V4rKL7J0YkUn?=
 =?us-ascii?Q?1JF5g4Usj8bv0vA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:32.3868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ca05da-10d6-4690-5b63-08dd1f210a65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666

Move VDEVICE upward to keep the order. Also run clang-format keep the same
coding style at line wrappings. No functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 97c5e3567d33..cfbdf7b0e3c1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -333,8 +333,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
-	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
-		 out_fault_fd),
+	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc,
+		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
@@ -355,20 +355,18 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 src_iova),
 	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
 		 struct iommu_ioas_iova_ranges, out_iova_alignment),
-	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
-		 iova),
+	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map, iova),
 	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
 		 struct iommu_ioas_map_file, iova),
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
-	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
-		 val64),
+	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, virt_id),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
-	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
-		 struct iommu_vdevice_alloc, virt_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
-- 
2.43.0


