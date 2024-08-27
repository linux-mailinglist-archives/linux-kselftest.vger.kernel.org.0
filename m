Return-Path: <linux-kselftest+bounces-16443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F093961503
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561F1287A84
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44BE45025;
	Tue, 27 Aug 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ICsFCj0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406851CF299;
	Tue, 27 Aug 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778164; cv=fail; b=Y41Esbjav8NV50gzA+jA0H+NW8PPH2BA3IBgj+AIjq+HEsSYHieGdiDz1uI5KB2l76vVdXNM5fvzJ1x1f4b1EyrnPH4q1VV2nHZhwwv2gaH9ut+ziGPzRmnB2BQujIS+4cdhlAmH+20z96CzsleRfuIPRik2qtXQ59pzoZPD4UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778164; c=relaxed/simple;
	bh=to0MmPnxJr3jW//MFKp8OtsVuv/pjvgVqq5GCKo5BwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AmGP19ijRJpunc6Ow57zga6mS/jDmCP/VZ+YMviAFTWef0AGTzt7LOY/L763AxLyv9cg9tJKuBUE8keGeNqImb8oKvQusQ+aLfPO0Er+qfjKEvIO9sRoBY+FeP16woA6KE98BjZ5R3OEUEHDTdzYI8nLLc2EbWpz3HSbPHL8D98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ICsFCj0r; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8qXS6WTVKjCQ9ucvQ+3iHtt+la5tkUNChJ6GgTn+A37VC9u0HVIkW0UK8XpRM8TT695D6cCqacNbnCdSCm13O60e3AOZhVC6uFTfRXTk9v4uOVr1dw/+Kf54skBBZit/9RdiBKTSnyAx38SgLN0YBWwR7H/kzAXCAIvNPQqDIbuAzJMVzJUs9Hwi8QYtJlsXPdF4Zkb3CX6jaIEZpTEQD/uoiC1vrpCfqLqICGxboP3vBRLWVBF55LMciMxAz5qbVz+h7ULjPYHV7FTu2XeGNb2SCV2Fee82iyspL8EJFbstzwsUTkNjcsKdKuldJK2le3hxKIsr+6vQjRJS/U8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K1UNFhxs53UztpWWuS6R9k3rRi74RBo2NE9m1fH74M=;
 b=yOMKiHPxS1+CifWqVYVAIgXxocvZD6bULPukKVTH391EjrfbfWp9KY18eeEk6CkWUzAXQRjJB1T1+heptEbhkfmeZtOI4PKnlJ0jn4Sfr+R1IhjptP3FiCZvRGIkrs5t/BmcMxd43wJ+6zuBUStfMmJzrdmeEAnfzvEj5CHg1m9DFj6wMkE9vH34HiDp2vKKgwAB/RLlCWhQZHd0vYpOx3umkQ/qJMGSjio0l46ooWxnkI+BVbSwTu7eC7tYrCcYg1oDua3AgfWV5h2bfEpjcfTTiSmY3vl8iZ2w8layXj/wmcn5RMi8lvngPRi/TE7Bnz+Rlz+0zHmv21B5zItsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K1UNFhxs53UztpWWuS6R9k3rRi74RBo2NE9m1fH74M=;
 b=ICsFCj0rI7ivwEWn7L1A2umz9YczqAIHoZSS2VfsV5OPbSUntEBwSDDnKiGTNvKcsaoIx9+r0fxMxD6vEmu3LqziY0Lj7kL7TruTYlQ540qY90Wl8MItgZQIR6Kim29goNu96/Nhsx4h0Bp1D9BtyqVjzBi0oLzycoaTDWysghCP3oxdgLffdTioowA2pojn9YLtvDmyGX3syUyMTvGxykxvn1VZ7SU68/+ugnGiLrYs7W+6ARvlA3fv26w2mekK18l9mJOahzazZ+R6oEbHK234AOJ8Dpaafe+K15YifvRGP//yRdhCrOPMl1tnLxf0DBFXXAogSkxn4BQIOAHpKg==
Received: from DM6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:5:bc::16) by
 BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 17:02:37 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::49) by DM6PR13CA0003.outlook.office365.com
 (2603:10b6:5:bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 00/10] iommufd: Add VIOMMU infrastructure (Part-2 VIRQ)
Date: Tue, 27 Aug 2024 10:02:02 -0700
Message-ID: <cover.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4078a907-a454-489f-3e55-08dcc6ba0d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0w8gemh2XrW8460yzo/Sl1ctH7iuiUFZz2RfDSssxrTpe/xmNMS6sg5m4Iep?=
 =?us-ascii?Q?PUEUW+wH4qjMUikKKiP315kLATZkDI+K9zDnUpWO/OXfwJXb2dTP5bXyoaoG?=
 =?us-ascii?Q?1qxVVuRw9rDOm4m5PsZ/64MQKhbcvPnP/UHukXXK9HBwy16ZWtT8gZSz3a/k?=
 =?us-ascii?Q?vXAwh7TI2/2Rh3CZqwFVvwWsw6mrYUsc/07yVOBUyt4OZpIVqJcsSg0Hflov?=
 =?us-ascii?Q?jFiMRmUk2S/JSemVxLFf8JoPQGyzGvX56lq8dK9kGIcX6m0GpERrEu3kWQ9M?=
 =?us-ascii?Q?Gz/6I9kF2t9TDAqTHunv8BdjCWQye84lkdTd88f8ACRrsPPWxp1KANjM+Mgf?=
 =?us-ascii?Q?KOcba64yBpngE8xlM/KhLGdWC+2nnkqcqDdryz1UszA+xjYiprEbA4bMPvDt?=
 =?us-ascii?Q?uy3gsahrWoshgQIagEFfv9xYl10Jro4MrkdPu4W6hn+ILml9sTQnV2S6Ovm4?=
 =?us-ascii?Q?CntngfSLq30+N8jtfW0wdL4RUL3ZIUv8LaGclSF6KB5Mjy03/Caro9CBCIeL?=
 =?us-ascii?Q?M7OIcWPaB+wxkq6kMDMQDHtpOdny98FWU7l/S90+SG7/UeW0z4zl13nd57+M?=
 =?us-ascii?Q?SSx9HFOnrJ3NkMCSue2fRPuKnUaA66h0zU9Ln9AdwAky682faq/mB1L0ls1K?=
 =?us-ascii?Q?unGExq86r4pPk+uKpByq/p9AkNeToi0S1PVnn+1KHNRTQUWg31SxL53Tlh4m?=
 =?us-ascii?Q?Ce++WjEdYDuklqH+HsgzBBfBgE8pISxPtjc/K0zdM3ig0aquef+FvLSdyzXJ?=
 =?us-ascii?Q?BRxTiZmt/kkGlx9etbFBnXdWE67JhxRbemGVq+b160WYWlGtWJ/Uvu/iMSk7?=
 =?us-ascii?Q?Fx23JmBahhtJQBkGUlD+vt0PiTKTOYlxrKkFt3LCGx63Tss7BXc5Ts9FBTDa?=
 =?us-ascii?Q?FAY67VTrDPBfXhVBTh10Pc3g3UjvznoFQiUt/+iqA7LQCD3JqSY7Pu613tmQ?=
 =?us-ascii?Q?bLzfzs1TnY/wRoMoZeApRbEKkteYGaS7zowGbjRXK29ognvZYHwcwcVLIGn0?=
 =?us-ascii?Q?a/K/tXfSN1yg9XcF63vb89gpC1vo5s9Er4bncyq4Lqygqckv1fd9CJOksv+N?=
 =?us-ascii?Q?4Z5izA3XR921vlZzUiiGvhdl5fLBrfowqpMtOgKeY/ybGsp301/uatXcCcHH?=
 =?us-ascii?Q?7n/YHPH3CG5nybXLJYB659DdYUJQATWF0JL5kxHiLb2+o0oiSG2cvsPrwEZn?=
 =?us-ascii?Q?AaMetqOisYsfdMKGGAmtgew/3ExQrTIv7cFxgdB2lQIgAJuf1H21drYiwOKu?=
 =?us-ascii?Q?oP++x0TtZa46ESCFxbOcZg/uY+ff3l6dlJ0f6Y2ss6X2qj6AjN3iqjDgt4LT?=
 =?us-ascii?Q?mqVsPJnf9NauMey5ZAfzr9BKWeJ3l1PTDMF66KvlD+ixJVAMefgaPqaYLsAm?=
 =?us-ascii?Q?q8p4VIXi44nW97lnTg3bj856/1gDWGTRx8J7SL7u8Jy3APd5cUqTCCVXIP7a?=
 =?us-ascii?Q?gO/dbczK+OhcHaHWGrwYmpBrS0JeeKYI240TIZ1vcI+c7DZOwUcE9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:36.5475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4078a907-a454-489f-3e55-08dcc6ba0d28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241

As the part-2 of the VIOMMU infrastructure, this series introduces a VIRQ
object after repurposing the existing FAULT object, which provides a nice
notification pathway to the user space already. So, the first thing to do
is reworking the FAULT object.

Mimicing the HWPT structures, add a common EVENT structure to support its
derivatives: EVENT_IOPF (the prior FAULT object) and EVENT_VIRQ (new one).
IOMMUFD_CMD_VIRQ_ALLOC is introduced to allocate EVENT_VIRQ for a VIOMMU.
One VIOMMU can have multiple VIRQs in different types but can not support
multiple VIRQs with the same types.

Drivers might need the VIOMMU's vdev_id list or the exact vdev_id link of
the passthrough device's to forward IRQs/events via the VIOMMU framework.
Thus, extend the set/unset_vdev_id ioctls down to the driver using VIOMMU
ops. This allows drivers to take the control of a vdev_id's lifecycle.

The forwarding part is fairly simple but might need to replace a physical
device ID with a virtual device ID. So, there comes with some helpers for
drivers to use.

As usual, this series comes with the selftest coverage for this new VIRQ,
and with a real world use case in the ARM SMMUv3 driver.

This must be based on the VIOMMU Part-1 series. It's on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_virq-v1
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_virq-v1

Thanks!
Nicolin

Nicolin Chen (10):
  iommufd: Rename IOMMUFD_OBJ_FAULT to IOMMUFD_OBJ_EVENT_IOPF
  iommufd: Rename fault.c to event.c
  iommufd: Add IOMMUFD_OBJ_EVENT_VIRQ and IOMMUFD_CMD_VIRQ_ALLOC
  iommufd/viommu: Allow drivers to control vdev_id lifecycle
  iommufd/viommu: Add iommufd_vdev_id_to_dev helper
  iommufd/viommu: Add iommufd_viommu_report_irq helper
  iommufd/selftest: Implement mock_viommu_set/unset_vdev_id
  iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VIRQ for VIRQ coverage
  iommufd/selftest: Add EVENT_VIRQ test coverage
  iommu/arm-smmu-v3: Report virtual IRQ for device in user space

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 109 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +
 drivers/iommu/iommufd/Makefile                |   2 +-
 drivers/iommu/iommufd/device.c                |   2 +
 drivers/iommu/iommufd/event.c                 | 613 ++++++++++++++++++
 drivers/iommu/iommufd/fault.c                 | 443 -------------
 drivers/iommu/iommufd/hw_pagetable.c          |  12 +-
 drivers/iommu/iommufd/iommufd_private.h       | 147 ++++-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 drivers/iommu/iommufd/main.c                  |  13 +-
 drivers/iommu/iommufd/selftest.c              |  66 ++
 drivers/iommu/iommufd/viommu.c                |  25 +-
 drivers/iommu/iommufd/viommu_api.c            |  54 ++
 include/linux/iommufd.h                       |  28 +
 include/uapi/linux/iommufd.h                  |  46 ++
 tools/testing/selftests/iommu/iommufd.c       |  11 +
 tools/testing/selftests/iommu/iommufd_utils.h |  64 ++
 17 files changed, 1130 insertions(+), 517 deletions(-)
 create mode 100644 drivers/iommu/iommufd/event.c
 delete mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.43.0


