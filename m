Return-Path: <linux-kselftest+bounces-23885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03BA00E77
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4C3A3078
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A031AF0DB;
	Fri,  3 Jan 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmlvDXTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5D1AF0D5;
	Fri,  3 Jan 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933467; cv=fail; b=tpsasKSa2YDX+yA39bAy3lC1n7lqhw2rfu9wSgJ5n5yIiEpdUczm4knlK0hKSiv0jkZbJgyjxhv8JjXyGPbKkr2CkJtlV6qCwYakyQxxNCvtH0YvLv1vLdvMgdR2Dd7n/0T6TCPBFwBACGi1k3ecSrVCjPXarCP7ry+VZvdY6D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933467; c=relaxed/simple;
	bh=gWjnQ4gus/ytcmphRyCBDuJu3VI18zJc6+6wnmQW8Yo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/Crawxt3beLkw7P4ZNa/N+WQVCqBEkGqsBLNMK2uSBQx/Qwt9qOsPmxY736KSNl8OMrGJsIp3t4YP6RVzMa9+uXZR7+ia4DlBkbSaBIc7J0tfHhXDdvqFgxufTnDDKi0NFBzI1WC+u8dQ7PWJkhMCf5g3hOTzgnoZ1sHBMmTr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmlvDXTK; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1wPVSPSzlxlsY3z9H0K96gDiAMwPGvcdcbUzaP7gtYfh0FdP6gjatdBS7H3uGCmIecw2LliFTF7oLuSiChXi9EEVnQj9wuZSdkioBweYERq13Ft4+/GVK7Li4M+6NUC4yAC5dyVDJjZehQSJEJN6OT6BZPo0vOpiOBnqS2ldsD1CfU1EPd1meX0svENEpd2/Pd7vabpEpTH0M+Cu+0Yb6yvDvkV1+drtLUcXONYPT4YpwICS4P6A/kKJvlwxE5VRhmYCPJuSE8zq/0bN/IzJksoxALeTOYuI8hfqWD1qkUxOjudI/7quY7jCtEt6rEar4hme+xgCeOlCzsXfopgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b83NO+KZl3X5fhR6a6NwtYFQy0mr1SphLuyvgUCACww=;
 b=lYFs1dFg8HR5QMynR5VFHNfe7U7N8a1rsJ2ejnm4zYxa4EkmZq0OTvGIp6NuxO9gUVBvlI61FMVCCSMxPnoMyJz5HPuIyJOuA3eIzZSJ53IuxZ/QFDqMvVNJXdd96tvhNIOLL6jCBuWurN25IIZUIGutXQtAKKmlyzaS0tUVDLMJCP7eJRnFSHVlCbIeorn1yy0BNsO+m4S7xvJbb4l6GOvqIjYRXS2YTk/fdgyvXrcUb9/WWc/ZYCKqmc5pvj8MUjH2YkDPlJQwfuUKUuA3Vsk9UwXG1fMZK5Fi4wsnx20XgiOgT90VVRydfaaErxMU4tlsZE0OZgK22fZir2tIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b83NO+KZl3X5fhR6a6NwtYFQy0mr1SphLuyvgUCACww=;
 b=jmlvDXTKe6h97VjRgpa5oePdBYFQgA+hqZtJqQB84LOj6tOPHGVFKQ5YG+u/MAr+cBYk+2cRv6vD3pPYVuMetWLykQpF8i7mf9G/4kql23yo9Rzub0ELpKIcwFqKAGza3SGZ/cyh+hQ+CEUFgnJxJMOkuFk/Tb+fdR8F6drgFzECe7zdDEe0jWFvVPN65aX/QgD5qAvSRH0shqdY16ge94/yP1Wgv7L55uEJwYeMIqqPdJxPHp33ZZ/eOKeaOye+7GeDbp5RCq1mnKKkVJC1tgfiqtsW8g0lyOVrgGqpMpBMY+bSskTcDftTAJOFc++UVKxbLzFdusNzazLqlvCldg==
Received: from BN6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:405:75::23)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 19:44:16 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:405:75:cafe::20) by BN6PR17CA0034.outlook.office365.com
 (2603:10b6:405:75::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:43:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:43:58 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:43:56 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
Date: Fri, 3 Jan 2025 11:43:23 -0800
Message-ID: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b7bd37-f9a5-4b9b-ebd5-08dd2c2f01c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XMQjy0vlfEeOfqHCvqV1H0ZITQ75uALshJq0+mhQ5hLtbMbCq1pJM7ieyTHB?=
 =?us-ascii?Q?HOUivyoC7xATPAb5ORk2miF/KwIHbBSjSWo4jE5MPjrt7IJ6qG6tuQ77zENI?=
 =?us-ascii?Q?6utb7SKl5V3DWJjE6ZZ3A0BvlpStwUAmk3GQHOib4NYxC5Tqd6JbC36ma0qf?=
 =?us-ascii?Q?9etLfINYIDwxE0Jbk08ecr8xgM6thUlqvhIjSisnyl6lfyZdf8y6zE2mj0qC?=
 =?us-ascii?Q?fmGk5hJyrC6rSRB50YxgTxRrGZIDdC1V9/LXZiZ3UYtRNi7UJf6/g5lf/mqs?=
 =?us-ascii?Q?mRCF6RZpdAeoYZIksepeEVmF1XgzC8O558o2AKO66ZdF87gP2eGCaxchN2LW?=
 =?us-ascii?Q?ze1HhXbbIYLBL55L7unbdrxeaQ12TjDTPPHRGsKkR9YVm5/WueAXw6sFLpkw?=
 =?us-ascii?Q?/Cgyi4v3FKJ4Xs0aOLNsZLcNXmRZTWemrV934zoqzqhyDW0oewPXDQDiw3xd?=
 =?us-ascii?Q?SLCflq/epvjdRyLps9XJtJ2cG7K9MznbFw6dquWHFINMuyUOnP+lxHMsdF3T?=
 =?us-ascii?Q?6lFKW8O4igQj8kbzSAWgM+oHizV/YcjNCX7ua/9ZHI/y2tsi3T9cwUjhuiCK?=
 =?us-ascii?Q?cBcU3lZBS09J4B4tMVrKh7raa25MPW/bST3aOqtPI2/mVQgODl/cppyxvRiB?=
 =?us-ascii?Q?yvMcsa8e6Rua6zeHduCgkSwGH0WRU84pV+JeV4gSRPQLuZhxL8ofoqFLWw1L?=
 =?us-ascii?Q?y5tZlxc9SKkGXkaaeOjRZD/RU4nbyWBrKJWq8IaJx+eiBmM9wwHkd7iR/aD8?=
 =?us-ascii?Q?yhv/z4sszph3NfeOLNO0l1D5EWLgB1t6+0HbzpuGaay21EwYwJeKesOMrxqf?=
 =?us-ascii?Q?k49j/olK4eB3zgcI2qUBwVykriXd1ySzs2yDAY3+TWdGTRfQz6QYnqK25pUY?=
 =?us-ascii?Q?kh3vqSMsOk2ip/FMCKrVe4LTHdSGaWUxQclK8ntkJ2uJsEYQtwedbuqKN+od?=
 =?us-ascii?Q?xOS+vfO2Jvm6igvyYfMU9dvuZdSB3Kl56hZT3iy/LQOeR8yTI5iWqPKZhIjx?=
 =?us-ascii?Q?rlk27qTsNwMhELQP8pbN5qv3YmfL99D9amrqQLxpDnw7JxJxN0QnsIWwcamM?=
 =?us-ascii?Q?yj0IQCctaUJj1vQULcojBFxMFUU/yZqY/YjbfDJSbmqTIxbVitHGZMVs72Fl?=
 =?us-ascii?Q?Ee4oSeFdUFcAb/OvtDiRxfJzgBPtrTy6TRCh4pnRsTjQar0nAqZ4VTO+JgsM?=
 =?us-ascii?Q?ubNQWGVVQLuwonBXSZ/FBLKCM4LXbQe34LOhlH1acVe6mCufGpptOfNZ3Jpm?=
 =?us-ascii?Q?Kvb0eMIBJ/MKCJ1b86FDApldWeYtk/HNNlGC4SIgc2n96byP0zQVpGvQeaBh?=
 =?us-ascii?Q?mms05GSaDE4VXwvY2lWXd6sU72n+ptuWeDcNrhUdQiw3sayXVdUbtKTl7tF6?=
 =?us-ascii?Q?ci9y4NZm17UuWkdMHG2styR6MciPJNnwv6VoStU5VspYDgmNd4PIOEUZ8y68?=
 =?us-ascii?Q?QLaYPZP1VAJCCH9stknNwpDM8PXZjkBx6YEmhSdgdcm3qMluiMLBFeHF+6WH?=
 =?us-ascii?Q?drenD7H5XoBexdDhjjTNRQW/isOe526TiAVS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:15.9149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b7bd37-f9a5-4b9b-ebd5-08dd2c2f01c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

As the vIOMMU infrastructure series part-3, this introduces a new vEVENTQ
object. The existing FAULT object provides a nice notification pathway to
the user space with a queue already, so let vEVENTQ reuse that.

Mimicing the HWPT structure, add a common EVENTQ structure to support its
derivatives: IOMMUFD_OBJ_FAULT (existing) and IOMMUFD_OBJ_VEVENTQ (new).

An IOMMUFD_CMD_VEVENTQ_ALLOC is introduced to allocate vEVENTQ object for
vIOMMUs. One vIOMMU can have multiple vEVENTQs in different types but can
not support multiple vEVENTQs in the same type.

The forwarding part is fairly simple but might need to replace a physical
device ID with a virtual device ID in a driver-level event data structure.
So, this also adds some helpers for drivers to use.

As usual, this series comes with the selftest coverage for this new ioctl
and with a real world use case in the ARM SMMUv3 driver.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v4

Testing with RMR patches for MSI:
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v4-with-rmr
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v4

Changelog
v4
 * Rename "vIRQ" to "vEVENTQ"
 * Use flexible array in struct iommufd_vevent
 * Add the new ioctl command to union ucmd_buffer
 * Fix the alphabetical order in union ucmd_buffer too
 * Rename _TYPE_NONE to _TYPE_DEFAULT aligning with vIOMMU naming
v3
 https://lore.kernel.org/all/cover.1734477608.git.nicolinc@nvidia.com/
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
  iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
  iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
  iommufd/viommu: Add iommufd_viommu_report_event helper
  iommufd/selftest: Require vdev_id when attaching to a nested domain
  iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ
    coverage
  iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
  iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
  iommu/arm-smmu-v3: Report events that belong to devices attached to
    vIOMMU

 drivers/iommu/iommufd/Makefile                |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  30 ++
 drivers/iommu/iommufd/iommufd_private.h       | 116 ++++++-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 include/linux/iommufd.h                       |  22 ++
 include/uapi/linux/iommufd.h                  |  46 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  65 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  65 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  90 ++++--
 drivers/iommu/iommufd/driver.c                |  60 ++++
 drivers/iommu/iommufd/{fault.c => eventq.c}   | 298 ++++++++++++++----
 drivers/iommu/iommufd/hw_pagetable.c          |   6 +-
 drivers/iommu/iommufd/main.c                  |  23 +-
 drivers/iommu/iommufd/selftest.c              |  53 ++++
 drivers/iommu/iommufd/viommu.c                |   2 +
 tools/testing/selftests/iommu/iommufd.c       |  27 ++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 +
 Documentation/userspace-api/iommufd.rst       |  16 +
 18 files changed, 820 insertions(+), 118 deletions(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (55%)


base-commit: e94dc6ddda8dd3770879a132d577accd2cce25f9
-- 
2.43.0


