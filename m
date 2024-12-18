Return-Path: <linux-kselftest+bounces-23479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1E9F5DFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6D8188FBB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A91552E7;
	Wed, 18 Dec 2024 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6mh6kmm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124681547DC;
	Wed, 18 Dec 2024 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498101; cv=fail; b=ZZCyZMYdN3qDGK6iUx+ARKbLt4TWGtIXEW2EJjXA1f0BuJFAt9O8XTLvGJjflLJddLve3YOpjRglP3W7pJf8hoLhNhkoHJh1VP7MMyaYSGD4uTqoktoXpAAGzxmeMDpUSFBBOub6pRgzFT1xnZR0Z987GC6RplOm6WqRp4nJV6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498101; c=relaxed/simple;
	bh=ynah6AewLTm9xMSmY8zbOxmEFS1fl7Fan9nTbYqfxqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emWXGg8t2BhgXdcvdvhucYmXzloRaUH5YKfl1KAjCoeGPsiGGBCF0SToAtZu4CDxw0MrsThkBmdrSTXeDOjbmc4LuA027WWgEJJPQvqW1OcmbnCF4AGmvJs/wLSKpopZPKKn8B2gRPQiYzGJJUeiGEJt+MM4elsLgbsL//FiGFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F6mh6kmm; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeVDEqhDrP8rAtkaAxFxkf6saHSzRyh5S+zk8/L4Qm9GX3qoqn+Sj2g/+g4ahLOeJNGzOROJ5CkvbPxLDztaWplEbZAlXJV8H26ZWEUZ6bY8uXGyjhcjphWN/fbp4RxSemprUwrFpv7lo3eKi4M0sIkGBebvSyYq6K+m/8li8AvRmWgSWwHq7DnfOiWmnszKR7NqfH9i67DulvOQWMDka0dU1ZeR4/PFFIEPBiAau5rd8y1bApGBfsA+Pt1Eg7YaB/TZzQGONd56ne5QcTrLLPZPJ3uPGf/m+rab/MJwEkTUARmOcpDteERnbzLnHWuZXaNlpu6gAjBjudTjfdeykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKsOVkMNUvLCihOCVwuPVlXwQQcHGCq7GnUo0gQ4YPk=;
 b=NaGygaD/oF5kxCzTyQrMwoLDfSeldntK15yJMrTB1/PJulMmElK8wHpymTynz27AfWnigRrgjch20fgtz+4k9CHh+n85OIfhtDCANj+PtVNLuNUzezu4g0jby1c9Oe64kYQsrsH5wWx6tLi1s+Ec3/AExZhXk74dWjaoBa8S4xhdJCRUfLr4cPw9AOL3CaEK/mgldeG/dCI0QCZHj5U3h9nsAQ6bBZLZNJrVJSH4FZ+ELE1DHnqwCrd6YH812Uv3QFEhnmv/PKdIg5ShaduhknGc+hGz2O4yLSBNgeTNFNu6/GxHf44LhD2glAiKKZFYSDZ0FMF3yxwaO/nsoekeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKsOVkMNUvLCihOCVwuPVlXwQQcHGCq7GnUo0gQ4YPk=;
 b=F6mh6kmmMImNOCUgd9K7S5aksNAl6ZF3Kn9jvH3ZdtF+U1pV9v531iX/12SYXg7BCX5scV1kp+LlWdey99XNOt9X08ciXEpEFH1S3BnSeQWHKFeP0be1l8pdnCG2UEyOdgwnVMmAa3xmbRtD8b2SYoGlZ9wwlAueUSKzvrLnznz10QUivNR65A1wIDtfHfWtUK7Ww9HkKpQnFiU6ZNOlFvpbLiCL/i8hSNQV9s2ViliI2JPCDSmeVk1+FpzAfS37GT1Dnv8HT2ItDp/il59pNUsx9WErYP24wETQg941FwYf37RZLSZLwqfcOPNuk3A2vTn6O+Lgrdxtk+uPHajxkw==
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 05:01:35 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::b5) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 05:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:20 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:18 -0800
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
Subject: [PATCH v3 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vIRQ)
Date: Tue, 17 Dec 2024 21:00:13 -0800
Message-ID: <cover.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f8a877-c5d6-449f-205f-08dd1f210bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SjJS1S+6KIUEWoQEXACdd40lRyFAWgbRMBImAowj/Qx23RHR5deKfjDgCDb?=
 =?us-ascii?Q?F07/0itpAerpNdcY2nZurtcnHe0CbAe3EepuGWPuJgNAtXeegtJqBXjqyHl0?=
 =?us-ascii?Q?IZwe4Ce5bKHKC7kYGs30zetkREHL1kwbsosgjFNnO/63g/SeBKgsI8sh6KED?=
 =?us-ascii?Q?AK639ZM0hnmHEC1546+MPS0UYMWpzMmoKabmBa5nZ8U8nfB8gc5L6aSp9t4T?=
 =?us-ascii?Q?WLHvIhWcaXK3MXkKivDxw92XLcWeZ9VpeVUpvaytFZnPbOeENYun9NOrHxAT?=
 =?us-ascii?Q?ov7/Q/Oqsgh1Fobigzg7pzObrT+imYD9/v1StQFUwJjj0nRLxkdhwqPRMejF?=
 =?us-ascii?Q?FuZJdunw9BZnglfYjKHyqcOXkTYeExPOVzto80jrR1piPrCSoUvmuQEX/4Ma?=
 =?us-ascii?Q?LHq46YBEhSCIqjCQJyvBKUwVMSOQEOxVsxu2TJ1FCcUO/PcjxW2opKOrISxf?=
 =?us-ascii?Q?BLRZsjigyDghI6mPRuEMavp6jUZbZqW9e4vYzbe+yQL3AGUwWr+txeMAvxb7?=
 =?us-ascii?Q?qyUxOcASMUpcmJgbVvFHg3MidOKIczLAH3btkD/MSGyb6kX8U7ZnF7Be+8h1?=
 =?us-ascii?Q?T+9rR8vqihTSGj1PUtoXY6m/p93kHBW8+vILhN5CnneQHG2iWnSQJ7k9mY56?=
 =?us-ascii?Q?knGuIgMVZQi5nEapCM06VW2hDfgc5+o/7ccuwMhZcMxEEVm6lUbWQBtOt8Zi?=
 =?us-ascii?Q?m6CBOKwI5YWJ+SQuXAEEcicu+O0YQbe/Ayu8nlTYnkkMdQeZUsSlTgPPM04Z?=
 =?us-ascii?Q?Q2CGYeHBYfVrE/ROKitYwj4HGBnytGy9IjKf7VGBRQ6Jfn2Vx604ECXeW5/M?=
 =?us-ascii?Q?uDeVyGOUmP8DifNWm0AXsId/SV/DV833SyB8tlypl/YVw78sivSh79dcbML+?=
 =?us-ascii?Q?cn0WZX0+95chCvcO/x3QvkBmY2z/MaY87dBAUbCTntpnR+zzt5aqjne9G+in?=
 =?us-ascii?Q?bF7jRTWybFZAZHW/DLXo7tSLc6KvS7u+1Ag3bN5QdBrvDi2RHlAQvzJYCFa8?=
 =?us-ascii?Q?M1xIviQUBJuZl1DgtNQnB5jq3Rilqc5zKoWKVT/Jxxh5XCup7LsK46OKmEH9?=
 =?us-ascii?Q?mPBg1QDbheU6SRhzu/x+PZRPSXCqOAUPJDWiHJe8xirZPbfWG6EslSPR2r1c?=
 =?us-ascii?Q?JuT+gWUiaoOyOI3SonZjj+jSYmhCgQ4onFedrR1X/ZOT4Tnjwe0d5in3/Kbm?=
 =?us-ascii?Q?/aUUcyQFxc/pwURE+QbLQanUxcHog/2yIfWgAJRZ71FWo6XwyjYyOr+XjgID?=
 =?us-ascii?Q?copw0aZU8Ta5yvVWXHF1DFKxNvGGMXfMy2rv9nmv4jNt0CW6l8TS9i+CLlF+?=
 =?us-ascii?Q?TEaq7pbb+S0u4bB0LBg9uYRTbXFvHJkXdDW7JGz5XimJvcKWCcR71b19MwJd?=
 =?us-ascii?Q?9Wjh+cMg6ONS22bsDzRWIzoPK7W7p7qACOKVqv48kiZ4XHSQsXJNxV+1ymDv?=
 =?us-ascii?Q?KUQICeqyvL7CnrfcjAKjbtW655Ko7jvGg9FFljFcfVrH+nWvT1nEIxGw6SvG?=
 =?us-ascii?Q?PIFgFvc65h6UQxo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:35.0567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f8a877-c5d6-449f-205f-08dd1f210bff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

As the part-3 of the vIOMMU infrastructure, this series introduces a vIRQ
object. The existing FAULT object provides a nice notification pathway to
the user space already, so let vIRQ reuse the infrastructure.

Mimicing the HWPT structure, add a common EVENTQ structure to support its
derivatives: IOMMUFD_OBJ_FAULT (existing) and IOMMUFD_OBJ_VIRQ (new).

IOMMUFD_CMD_VIRQ_ALLOC is introduced to allocate vIRQ objects for vIOMMUs.
One vIOMMU can have multiple vIRQs in different types but can not support
multiple vIRQs with the same types.

The forwarding part is fairly simple but might need to replace a physical
device ID with a virtual device ID in a driver-level IRQ data structure.
So, this comes with some helpers for drivers to use.

As usual, this series comes with the selftest coverage for this new vIRQ,
and with a real world use case in the ARM SMMUv3 driver.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_virq-v3

Testing with RMR patches for MSI:
https://github.com/nicolinc/iommufd/commits/iommufd_virq-v3-with-rmr
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_virq-v3

Changelog
v3
 * Rebase on Will's for-joerg/arm-smmu/updates for arm_smmu_event series
 * Add "Reviewed-by" lines from Kevin
 * Fix typos in comments, kdocs, and jump tags
 * Add a patch to sort struct iommufd_ioctl_op
 * Update iommufd's userpsace-api documentation
 * Update uAPI kdoc to quote SMMUv3 offical spec
 * Drop the unused workqueue in struct iommufd_virq
 * Drop might_sleep() in iommufd_viommu_report_irq() helper
 * Add missing "break" in iommufd_viommu_get_vdev_id() helper
 * Shrink the scope of the vmaster's read lock in SMMUv3 driver
 * Pass in two arguments to iommufd_eventq_virq_handler() helper
 * Move "!ops || !ops->read" validation into iommufd_eventq_init()
 * Move "fault->ictx = ictx" closer to iommufd_ctx_get(fault->ictx)
 * Update commit message for arm_smmu_attach_prepare/commit_vmaster()
 * Keep "iommufd_fault" as-is and rename "iommufd_eventq_virq" to just
   "iommufd_virq"
v2
 https://lore.kernel.org/all/cover.1733263737.git.nicolinc@nvidia.com/
 * Rebase on v6.13-rc1
 * Add IOPF and vIRQ in iommufd.rst (userspace-api)
 * Add a proper locking in iommufd_event_virq_destroy
 * Add iommufd_event_virq_abort with a lockdep_assert_held
 * Rename "EVENT_*" to "EVENTQ_*" to describe the objects better
 * Reorganize flows in iommufd_eventq_virq_alloc for abort() to work
 * Adde struct arm_smmu_vmaster to store vSID upon attaching to a nested
   domain, calling a newly added iommufd_viommu_get_vdev_id helper
 * Adde an arm_vmaster_report_event helper in arm-smmu-v3-iommufd file
   to simplify the routine in arm_smmu_handle_evt() of the main driver
v1
 https://lore.kernel.org/all/cover.1724777091.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Nicolin Chen (14):
  iommufd: Keep IOCTL list in an alphabetical order
  iommufd/fault: Add an iommufd_fault_init() helper
  iommufd/fault: Move iommufd_fault_iopf_handler() to header
  iommufd: Abstract an iommufd_eventq from iommufd_fault
  iommufd: Rename fault.c to eventq.c
  iommufd: Add IOMMUFD_OBJ_VIRQ and IOMMUFD_CMD_VIRQ_ALLOC
  iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
  iommufd/viommu: Add iommufd_viommu_report_irq helper
  iommufd/selftest: Require vdev_id when attaching to a nested domain
  iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VIRQ for vIRQ coverage
  iommufd/selftest: Add IOMMU_VIRQ_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update FAULT and VIRQ
  iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
  iommu/arm-smmu-v3: Report IRQs that belong to devices attached to
    vIOMMU

 drivers/iommu/iommufd/Makefile                |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  30 ++
 drivers/iommu/iommufd/iommufd_private.h       | 115 ++++++-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 include/linux/iommufd.h                       |  20 ++
 include/uapi/linux/iommufd.h                  |  46 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  63 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  65 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  90 ++++--
 drivers/iommu/iommufd/driver.c                |  57 ++++
 drivers/iommu/iommufd/{fault.c => eventq.c}   | 298 ++++++++++++++----
 drivers/iommu/iommufd/hw_pagetable.c          |   6 +-
 drivers/iommu/iommufd/main.c                  |  20 +-
 drivers/iommu/iommufd/selftest.c              |  53 ++++
 drivers/iommu/iommufd/viommu.c                |   2 +
 tools/testing/selftests/iommu/iommufd.c       |  27 ++
 .../selftests/iommu/iommufd_fail_nth.c        |   6 +
 Documentation/userspace-api/iommufd.rst       |  16 +
 18 files changed, 809 insertions(+), 117 deletions(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (55%)


base-commit: 376ce8b35ed15d5deee57bdecd8449f6a4df4c42
-- 
2.43.0


