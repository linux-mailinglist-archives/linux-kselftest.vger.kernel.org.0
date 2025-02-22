Return-Path: <linux-kselftest+bounces-27265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE15A40999
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00413AC7A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2741C863C;
	Sat, 22 Feb 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VoreCx0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56335949;
	Sat, 22 Feb 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239672; cv=fail; b=HtV19fcrauChFsJuszQgpD30+D7+JgWexbr2ZpZOyJi6WbbepgcFjQnbesQLyz5xLPVo3J4moaHt52zm+IzN6AITNcm6bf8sDGtw8tIFPgofhzBtlAEYri+OLS/PI7OS9uAfAx4+2kPiN9ZqBN92FKXBjrek/vZySIYxIKC2uNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239672; c=relaxed/simple;
	bh=T8a9K7n1KMnoJdD20I32gGZ9sE2ItK+9ekHCKpprEY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jFcYS5Pfngd2r5Fxdn5gvspPgK+YWqkkV32AxxsOywJDxXooOH+1napy1Kco7VtqO31NAqUOAdH/PAbnFGu93uiPfX1N94j1iLttlL9BLK5SFXbbWfK4P8KGM/Y43GDnhr4VV5tbh7jg8FFq5zRK3wUUuLAeiAS7Lw0zttAnmh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VoreCx0y; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6/HNJ33NcwdaYXdfBL9ykhcVwVzbft4ZRJeSGcXeQTsqw3BCvNC71/SLwaZjLCgyD76Jqy9VDPlwDcrMw6Me2ijSdzjqUoEiSutV8qw7ssRy85g6/VD94UNWU7NysmPPv1758siA8EpBT04FgbXCV4DiIf1mEpBnCx2FWSxbDfPukP0fbb8cKwIcPNMcq3zO2+SvqlShTuWf3AIrBsMAtYdsNDsKje/rV/dV1f7VbSWqEx0Qu58pW7H6O99iHK8pWNyHmC4g39xpdxI8yTFNez/sTwH2moUo9LhUNxVm0cJxnPRLjKHiU2Ta2wKeYYehy9O38aKSxHICAmqgNsbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqHhr6qb3dQoGTrmvUxHDgQ/LYLjjHsAatNDOWF7doI=;
 b=sOHsjWKg/JOzy5KN14/U9nHaLtloR4LGYsU1coGek8FYr6yRWSUdKXwX/sEyqHFChgL3X/FVKsoVri1OdFLIJRM6MhtkUet6rNeaQMzCBFIigIgSaDAVH9Fu9Q3oZE+8nDiZ7yvwB4IVbuqEWcLm6EnRpEV1PSNNZbYmsTvSzJgZOLmKkJo2+FE1bKSlFQZRnHMsdAy6jBIReXZjG7pmA9VoYd8SsC1khebe266WAoP6SdwAO1VXEFDD25cMd0xv47rzzB2U0UZMm91ZFDcXVVdHAJ0ODclJgjWmo65CqBwQsUHLh2xGQOT9fLzcgWXlWmryy6xb/W/ydlRDwR34Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqHhr6qb3dQoGTrmvUxHDgQ/LYLjjHsAatNDOWF7doI=;
 b=VoreCx0y5WXYehyhaDd5Q1JivFLz5e8vguRegvdUBPq42Yl3S6xWReSzwJnsVVE8i1y16+PYPHiVzHFWYw3ebBlSy46jSTS7CZZVDXtCx20mVNrsl4ufxU+jHmUm1ZvyJM0TwSk+aGuyZ9cWtuffI4Cjfz51hxZ5eI1K6mYTy73O+Xf9ejo9CSj9zBZZ54y/y7JB5Zurx8uEl611ZlXkpWwFRwaMPmaHJYbLpr3JEP9q50JDVdP2Jzpeb6H4hSncl/2JPhxc/xD398PD4NLPdW0nvo4EQRCuFJHW/oZ3aPxXluSmEJjmBWQH87GVfmFkhYInT0lN0l9dQJ8rYJzwqw==
Received: from DM6PR17CA0007.namprd17.prod.outlook.com (2603:10b6:5:1b3::20)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sat, 22 Feb
 2025 15:54:23 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::89) by DM6PR17CA0007.outlook.office365.com
 (2603:10b6:5:1b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Sat,
 22 Feb 2025 15:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:13 -0800
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
Subject: [PATCH v7 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
Date: Sat, 22 Feb 2025 07:53:57 -0800
Message-ID: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: aca29b55-b04c-4e04-fcc0-08dd53592d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMIT347b28nw/E7BmOZzZw9b42pTNG5tWyAw+lQNko6pqHmed5DmWa3LSYu+?=
 =?us-ascii?Q?kkqxSkuzBlzCuXxzvtHwlPo4y3BfphJBQWZhokIjWv7t4kPwItWEbEl6rxew?=
 =?us-ascii?Q?yevOmyrAZ0GbJlCmJnhH8YwHJE6LKsLP3NNRJNXg3zFsbBMpSV0YsCyr6BYh?=
 =?us-ascii?Q?58vCXyO8SJmGcT74Xj4RtkBf8znz9QXDXFLBAS0zzSfE+mLHcGJ6Bwd7oQUm?=
 =?us-ascii?Q?GHUPEs2Bx+61CNtZFM26gWoagagZrAfKp4tmpTWWQoZUF0rMB8Kx4niitBpr?=
 =?us-ascii?Q?iwyHtaf4wGyFZB1byda5LgySQjFKozLZnNnobp0upqqHvrtsWAFyJJw2lq06?=
 =?us-ascii?Q?bOyNHP+jLNpvYKNdPrR13ZxLO2ZyZer/+vgu56Z9twGn2o6xk4Z2TQhd4KDr?=
 =?us-ascii?Q?VI5rnNwdEy1wejfForEH0m9+f8ng94bnJYTN+4WSZggi8+RBQUx3+X2hj0k6?=
 =?us-ascii?Q?F2mppcY3qsGgCGbLv3kcF70umlowHb/PdX/1N35T8IADJLdbYxnPD0cvlSta?=
 =?us-ascii?Q?pB0xOXy/kLQ68kXhJm5QkignKlOt8OLcM9WObn+j0uoRd4R5vw4E+zjPmsGf?=
 =?us-ascii?Q?/Rfo22b9PJs173oMHMGsMXIlO6L0QLp24mCbwgPAqI87eKyN3YPBt5KklaUQ?=
 =?us-ascii?Q?arE3qFW6xdAQZsOF6vAcc92FsZ0lbexb3p2cIgJtlVu4vzWUK6udtBiNUPcx?=
 =?us-ascii?Q?kH4WoqnfPoV7PFRqW7FWHRkotGDgaI461iRp3v9TG83EzMI9w84fB/21W/kj?=
 =?us-ascii?Q?96cE7sWqWIyKRMUPtlUaDD32Ivj4Bjas+VI5rqAW33q0GXbOouiFACV5ei2P?=
 =?us-ascii?Q?PEJ72quOzTRmpF2RIhJK89PI5PBMNII3JZh960UBZLctrduYGj5euG/eYI2/?=
 =?us-ascii?Q?IAZsTEFiFHEbIBduWRri6OwEHxA/pscjmQ2EOD8myDS39tp1cNdf82dUODcZ?=
 =?us-ascii?Q?gDQEBqry/dkw3iNc2KKRJe1S+/2kHSdOOyw/duQ/kz0RGE4V7Km0yXe4T/PS?=
 =?us-ascii?Q?fzatrnMCdZ/1mctA/BFFMzqLGF3GM03Zus3As/uSravSLSfxSuvneXvyz162?=
 =?us-ascii?Q?sxgZA2HO6bzC/opP09uU/nveIbk/EJOjuKgpn5usQfFUH9r42boERVohNlz5?=
 =?us-ascii?Q?4WuWicSSE6N0yyGNfuNB7TxnSVQfCI6QSGsQwS7zbKsbZM+/pvUhqWUMdZ/1?=
 =?us-ascii?Q?u6/KLIOyTxAa8z6F9vsfLXVOwJUtnuVEq2TZ+Q0mek6hgFEfdYtjeRWycoMp?=
 =?us-ascii?Q?naOXUBt1SaIH6kF/ittDDNm02Zov7PHPdmL2IMq26geRqY0ofFohbt9tCbfv?=
 =?us-ascii?Q?ObgfpWS9stL30PjjFnujFMU91g71bGUmFsMtttAr0jr1sEGW9GTkUBveB3Bg?=
 =?us-ascii?Q?yWdfha1kMKx4VXmHuAtX3+eUGSCFGeXVNYXHAVDniVxEOX4HhuqIKlCAp7yw?=
 =?us-ascii?Q?odNm1IXPXgBCKnY7xS7YG7VS8aAU3Wy4JdWAASCuCHZsH9LJJjINDZcw3tNQ?=
 =?us-ascii?Q?7jDrN8QkE6oLKhg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:22.9322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca29b55-b04c-4e04-fcc0-08dd53592d1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

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
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v7
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v7

Changelog
v7
 * Rebase on Jason's for-next tree for latest fault.c
 * Add Reviewed-by
 * Update commit logs
 * Add __reserved field sanity
 * Skip kfree() on the static header
 * Replace "bool on_list" with list_is_last()
 * Use u32 for flags in iommufd_vevent_header
 * Drop casting in iommufd_viommu_get_vdev_id()
 * Update the bounding logic to veventq->sequence
 * Add missing cpu_to_le64() around STRTAB_STE_1_MEV
 * Reuse veventq->common.lock to fence sequence and num_events
 * Rename overflow to lost_events and log it in upon kmalloc failure
 * Correct the error handling part in iommufd_veventq_deliver_fetch()
 * Add an arm_smmu_clear_vmaster() to simplify identity/blocked domain
   attach ops
 * Add additional four event records to forward to user space VM, and
   update the uAPI doc
 * Reuse the existing smmu->streams_mutex lock to fence master->vmaster
   pointer, instead of adding a new rwsem
v6
 https://lore.kernel.org/all/cover.1737754129.git.nicolinc@nvidia.com/
 * Drop supports_veventq viommu op
 * Split bug/cosmetics fixes out of the series
 * Drop the blocking mutex around copy_to_user()
 * Add veventq_depth in uAPI to limit vEVENTQ size
 * Revise the documentation for a clear description
 * Fix sparse warnings in arm_vmaster_report_event()
 * Rework iommufd_viommu_get_vdev_id() to return -ENOENT v.s. 0
 * Allow Abort/Bypass STEs to allocate vEVENTQ and set STE.MEV for DoS
   mitigations
v5
 https://lore.kernel.org/all/cover.1736237481.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Baolu
 * Reorder the OBJ list as well
 * Fix alphabetical order after renaming in v4
 * Add supports_veventq viommu op for vEVENTQ type validation
v4
 https://lore.kernel.org/all/cover.1735933254.git.nicolinc@nvidia.com/
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
  iommufd/fault: Move two fault functions out of the header
  iommufd/fault: Add an iommufd_fault_init() helper
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
  iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations

 drivers/iommu/iommufd/Makefile                |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  35 +
 drivers/iommu/iommufd/iommufd_private.h       | 135 +++-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 include/linux/iommufd.h                       |  23 +
 include/uapi/linux/iommufd.h                  | 105 +++
 tools/testing/selftests/iommu/iommufd_utils.h | 115 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  72 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  79 ++-
 drivers/iommu/iommufd/driver.c                |  72 +++
 drivers/iommu/iommufd/eventq.c                | 597 ++++++++++++++++++
 drivers/iommu/iommufd/fault.c                 | 342 ----------
 drivers/iommu/iommufd/hw_pagetable.c          |   6 +-
 drivers/iommu/iommufd/main.c                  |   7 +
 drivers/iommu/iommufd/selftest.c              |  54 ++
 drivers/iommu/iommufd/viommu.c                |   2 +
 tools/testing/selftests/iommu/iommufd.c       |  36 ++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 +
 Documentation/userspace-api/iommufd.rst       |  17 +
 19 files changed, 1308 insertions(+), 408 deletions(-)
 create mode 100644 drivers/iommu/iommufd/eventq.c
 delete mode 100644 drivers/iommu/iommufd/fault.c


base-commit: 598749522d4254afb33b8a6c1bea614a95896868
-- 
2.43.0


