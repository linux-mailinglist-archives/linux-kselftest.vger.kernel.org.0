Return-Path: <linux-kselftest+bounces-22725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3599E152C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57735280C57
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5171DE4C5;
	Tue,  3 Dec 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="km+v0T3q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FD1D9A6E;
	Tue,  3 Dec 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213022; cv=fail; b=lBYonE0pKLYZmuiKq4zH8kad7Dhx3k3JNFGBHvig7HTme/+oeMtI/+AiI52lVz0dnA0eI4xWKralSrMopOgiRI8j8awIilq5MKQez7t50YO7eB/WfbYRMdy3XzZAxiAiHuICNxSe3k+MoreTGXJra3IqaLXQsLxV7THV33WZl/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213022; c=relaxed/simple;
	bh=zy4bTzBSxz1aCB1+ZvhkRtbSJfygbF6Ul+C3r4MBToo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWI60t/4s7mGC0f1t8rhIDS4Mm38ec7v02Ni/3tA1vWhulRhFpLX6uT0ppOpfRGGc6Zx730RoXdvlQ30iR9oc/lcz5laoRDisNmclVXPX/ppQ9MwA72ZA1tJMvyPqs8JzOr1Ds+X3HANXINtMFtxf3dNyw/+e+K2w5yz1UPdvq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=km+v0T3q; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI+QqPdVod0P/Z7dsIlAbTXxuK9BnSEpedmD9cQNIIiUTlefX2EZ+ce3bu1mUzoqCVbyqDAdTQcwiHUX1CxSvLxtk3zkHlLSAF4oSBiacEIe/ocuwhurkUo5oIC7lFso5ymOu7FEDG40B4rtjnwcBOmJ9MjYkEpujuPJ4Qxtz8tK8Kj5NiQIcd1X6ztq3A4Zr3LlRQ7bevr9cup/12uXCZ50ieT/jCWawZBiPltzDs6GpIviWWdcvmvhN75+zO+AALP5rthflk5kQ1qAZUP4q9BRgYpv587dSoKfrFGRgCohnyZmvFWO5FiqI1mMVaeCHj/MY0+w/F76XsYUQZ1JTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loN+9i3xoXWWUgRkbU0w0tHQjTNmvMrObiM8SFYwXqg=;
 b=wVcMXSqEx34Fq78O53on4kPik0G947AitPUCM69tQ0as21lQwLKgzcMXpoFRLLmILv/332k2BUv85ST57ZIeFY6V8KIdoofAcEHp5qzuY0j/MRJTfYRyVF+LMwfa3I77c6yBhSnuKPfQfpxrvNI7N5VXhH2eR3eUX82uAXHuFltUIiJ6FvTzgb0nv/Ips1TCCCGYRGA1tuwWu/q69WlzF4SI4ihALLqQOqRfnUkTDEBUwbSf5bQd40JPYbFAFTq/VeNpWjp9tf+j9yyX+uNU+UO/bPzvdarRkDqXDHlkZTPDb/cErZyOSk7Ecw+EoOCO6DJZsCKi94qrl6HXsa4ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loN+9i3xoXWWUgRkbU0w0tHQjTNmvMrObiM8SFYwXqg=;
 b=km+v0T3qqAW98ZlZXILF7ijUMqe3pAp4C6mA2FWan64wTCFSaULxWWUt9NL84RClbaNCo6yZrNDKrHzRJcKo092uvEXb4OyB5thzv7outzeubyM3/CSqkcOAPtyiv1ugaWbg+NBuBboaQBs2MH5IheZvZ0ppzGka9dRSA2+fxRbbNHdsTJ6Ft52cl0eRFIEcL40YGMQ3O9VX6xL42KZMiH4THKbcyHYTYMVvtz/OQaQgmlerE6EYVXBi7aAdRzB4pF3aw00njzhlC+tDOlROSDvaUriBmMiPpghsktPDsyzgOPu/h+/vXBvZSvNFy73OZVz/XfS4qCwg5pn3LZpcMg==
Received: from PH8PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:2d0::28)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:03:36 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:2d0::4) by PH8PR02CA0021.outlook.office365.com
 (2603:10b6:510:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Tue,
 3 Dec 2024 08:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 08:03:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 00:03:20 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 00:03:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 00:03:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
Subject: [PATCH v1 2/2] iommufd/selftest: Cover IOMMU_FAULT_QUEUE_ALLOC in iommufd_fail_nth
Date: Tue, 3 Dec 2024 00:02:55 -0800
Message-ID: <d61b9b7f73276cc8f1aef9602bd35c486917506e.1733212723.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733212723.git.nicolinc@nvidia.com>
References: <cover.1733212723.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7906291c-5051-48d8-9f38-08dd1370fd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TrfgldeHoBh6+w+PVgxbpFuigRos9e7LqL3+YkOafZSIlc30fVvJxPPpeNM8?=
 =?us-ascii?Q?9AKlLL3k2v0pjHS/ZB6yFqzWG91429tbm4mMCuKPGC9h5sbrUSH8e0MtHEfW?=
 =?us-ascii?Q?QsCJyNuBoTSRITgSih0hrj0rMSuZTbinZUMMHWko/1dguTrl0/UcsFyvEV60?=
 =?us-ascii?Q?mGD2/FGZQigwrPwHkQ8SmLyrcStyptg5Q5K/gQgzmmtEGiaO+0DctuaWUR7r?=
 =?us-ascii?Q?7BurQo+ROfaIszAa8UbS3nm5EvKC9RoIaLN4p3A21N96VtbaDjyEYjSAjORy?=
 =?us-ascii?Q?5W3UvQBhxz0fshdNNPd/JH6r2HIF1dF+ypKU9fqdSBqeTxOl8j9XvxCablR2?=
 =?us-ascii?Q?a/BDCxy4JA5T8d+VD7XZHNLrhMnyBiC/E10/eni1l5bSETAhxLyX0vzBts1Q?=
 =?us-ascii?Q?2NolyXb3YzOZmIIvSjjevmsQfPtD8ozDVJtz/CexMJ3k+NNsoqQ713YEmKK7?=
 =?us-ascii?Q?A7cwfxM0IBsOiWpMcM+KmOwNGd6CIDNALO7Cuq/LqKEgtrRV9mCnfjrLbQk7?=
 =?us-ascii?Q?MpsrA+/wEP6PU1jj05zSRUkF6yHm6QqgGbZhOdSj4LeA5LqJ0gOdu4d6EkpY?=
 =?us-ascii?Q?ladJtYRbcRCmsv0BWHkRs6YzGAKP5gNHqle9qKs8XJR5cWq3uCiIew2LxXMU?=
 =?us-ascii?Q?7M/8b3JJvBa27wP/obRxWre2geuW9vO543287bTcStzx1NC8MzT1K+HWag63?=
 =?us-ascii?Q?veMfhI/ZN+8t61pFAqxSAybQc2ZuXMeWou2OwBVCXaJAUuk8qd2tss1jqDGw?=
 =?us-ascii?Q?Dgz4AFxdQr+Uh7IcH682C3vd/IVByVuXMRSIuOF0V/h/r60tzqoaYRAzrZNw?=
 =?us-ascii?Q?i6GqGoQ8VlXj2K43zQdC1YpKyi15TKa0jmTXpcMlFk2RTncNhcT9CaAT/RJ0?=
 =?us-ascii?Q?4qWiNyA1p8kb9z4OAne055v/arVYFwvp2QKjGyziKHJm0dcdRFOuF7if/zo4?=
 =?us-ascii?Q?twXmgu4h03CHH1/wge21A5Q5+pBjSXlv1o3unvnpYc7wdg2L1zo2TJ7Ywbym?=
 =?us-ascii?Q?0raxyNDOKHxs+be+UphH6NhqXuTu4G9t23UDdxPDRNTXqCfCw9j6HPvIYxWI?=
 =?us-ascii?Q?i6I1BdSjk3gB4tCOZENuF4TmRX8torO0Tx7oyLb8fFTa1TWwvt43vGBicOjg?=
 =?us-ascii?Q?Yrx/cAeYHqeVjz3TWKHvpo1ZTCHBNoW1FTbjuxtIjsntcywtWOXYbeuwHlUB?=
 =?us-ascii?Q?Gk2ceUCCJfQ7etmu8uy74zen/7mBh+MiZPmPI67iOZC6x7229J8G7i5LI2Qk?=
 =?us-ascii?Q?NHENl75invn3O0XOl+N11OhD75kZ4dD9BURK++HSTrg4WRylDhfz/KUDny3p?=
 =?us-ascii?Q?Pa6xTI6q1Rb6LHjbnaD1LLN85DxPfDcfukSk/wOoiKcje9Zj96airtaRUl5x?=
 =?us-ascii?Q?unw2mwUtM+sb/7HoVLZgYlPwxkQ1H6RyTakHgwi5+aYxA9gLznR1Fu5c0/Xm?=
 =?us-ascii?Q?ec4bDr27oGuo3RtMWmibfO1F6/95Ku7h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:03:35.8273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7906291c-5051-48d8-9f38-08dd1370fd18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

This was missing in the series introducing the fault object. Thus, add it.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_fail_nth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 22f6fd5f0f74..64b1f8e1b0cf 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,7 +615,12 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 /* device.c */
 TEST_FAIL_NTH(basic_fail_nth, device)
 {
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
 	struct iommu_test_hw_info info;
+	uint32_t fault_id, fault_fd;
+	uint32_t fault_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
@@ -678,6 +683,15 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
 		return -1;
 
+	if (_test_ioctl_fault_alloc(self->fd, &fault_id, &fault_fd))
+		return -1;
+	close(fault_fd);
+
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, hwpt_id, fault_id,
+				 IOMMU_HWPT_FAULT_ID_VALID, &fault_hwpt_id,
+				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
+		return -1;
+
 	return 0;
 }
 
-- 
2.43.0


