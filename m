Return-Path: <linux-kselftest+bounces-28765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A47A5CFAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C3189D787
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11F263F39;
	Tue, 11 Mar 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ueMu1GLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C355211C;
	Tue, 11 Mar 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722332; cv=fail; b=kRDAD1fytvr0ltTcSzgvWvCfqyiJLNRp0/2k847R1r0W3oak2vxWb2Kuj6bNo9hcPuJX4JZYWC74HOkEXm8xqXBRsDwrABkLeE53eFzin19INurFGILNTNgvP38pKen8zVNu9gS8LpCXlOQkwK/2vR6uiG6caJ3zYp8HHx0C0go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722332; c=relaxed/simple;
	bh=vyiUz/bVDcVp+jEOcxNoAlFz8GrWYkqWUZqd6sAlZRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FXUvm02n09wL+XBftV2M+6+aTXN/Hl9aGiV9fTb0+MUNDaxZZeC/2L0a+nNV22KRCwID9QJw2D+LHp5Uj/Piv6ry7kUNibbkEJVZUeW2aCjF5Nh7i0WvwenNOmortdkCJxNG7Hjx5alf0jgeTrQUBhZXc41G70qYQXjfMUI4P24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ueMu1GLc; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOb8rpQfOnl4iEoNWkZbe4+szI4ubdwl/yYWmgLDgWlniGDKkwC5ldAS+lN//nA7qHGwoOM1Yv+vUOJweAH3+UKytWewUJe9pezY5nVvOC4rT6OYQvIatZ6xyNUUdTYnTWAcsAN96Eag1JuOLcc6XDY9pVUu7GbfLynZs57d/6ye/LFZbDTokjc7QJj+3B0bhIs4gkMmFG8hG54lrOiNtjM8za733MDk0vgzZGKUZoTCD2aZGQyrj7rnSDbkuEqRr2gN8W7bkW9IT5NuHFqSuwfntQQfWmPDyRC6WDhxEoFHwisAKUkVLNYgRp2xlwIGiOic66Eeb/0/+6GQUGXf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFgeupadb0WB4uGvGjV6daltoC/nGGEiYRixPCXRx/g=;
 b=j+HfUCi2AeX/yYOJ+buOCw00Odezt/XQ3EuGXHcJgC6waLB6Vip4Yif/fc4LMwd1K/hMtjATRlfXJyhVMaWGaSxnhJENtw4f5/ztEowJS8MX2/izjvjFTBuxZe5qMgHtdsUTxMbCrsA1wvbGyjUwmMSxw78ij14ehDQqN7EsoS6mBK5XlA0TOnI0o4Up/qxKDtjYAU8kPwMfAzdJm7oHzJstkQ0lgHzTSeXzSiD35KRl0pzQPRRkyD4u/qLPE5iLIg31GT28QSWNoIpYuWDslENTcAtYkL0D7ZSN91F5ID/68Rmdo36ZgVFofhaLxO05Y/8pdc3YTgJI+mC+TsQyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFgeupadb0WB4uGvGjV6daltoC/nGGEiYRixPCXRx/g=;
 b=ueMu1GLcURzb6jsQCnlOVwENQPQYKN9YyRxgfYkZWw3O+kJDlMOUBQyMTGq0DBoJELT9FkJyxXfW5QyuDalYEw+51kDbOPVbligEkfzQH18UwbnVaKrTtc4L5l85sdp3EXiEjc+IdBVVMFHvRrWjTGBft5wrFXqye8FWNv1dhzAUTErD1B/gz6hmBxt0LW4gOzb/RBd2AUF73AOoSCarO89q0iixZtEWSUmO/c5Zo6umtmXQmtqbK5H08W+iLzMpAprdBNToLTgO0VYDWDumUNJmQ6nUXB9BKL526vACQCGo4p5cwr2aNVw30polU8OtQcKxMS0BVc1n/Er+Kb/YKA==
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:22 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::dc) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 19:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:04 -0700
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
Subject: [PATCH v9 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
Date: Tue, 11 Mar 2025 12:44:18 -0700
Message-ID: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdcc08c-d024-4745-4158-08dd60d54288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?huJ5or4Tiym/yQjziATCPL93WjRJ34Pvdf5U/6vL2SPbpWO4L+JmaumBjb+4?=
 =?us-ascii?Q?8QCH+stpjB5gZn2e9vwLtZZj59hynto/ibWkmDWEh5xIkK9F/QyknDDZVKMo?=
 =?us-ascii?Q?Zc80hILEoKsKZDubbczxnPi2K0mgolWn9WAuA2AtgxboqMygRnw6XaHN+nuY?=
 =?us-ascii?Q?dLsYvHrXw3gINcBYt72kSIuBeMorb3CEI4bbGwTYee4Zz0yZ9SNBQga1azLs?=
 =?us-ascii?Q?W8HkFW3KySnESJWBcUnzxgdNuS9+jKX4LiqO87y+UwPya4SXfg0JzKsCSGEr?=
 =?us-ascii?Q?qWA0tXZtzYxJA2CAz5grF67+k70Vf6GgXRh47gkJ5vmwPDjYvw8te757EMQ6?=
 =?us-ascii?Q?PnPBknK1SdAW9u0usu2xjbZ1yYam4rmp4rhsKnFfda9ozDvBxO3gUbtrqS1W?=
 =?us-ascii?Q?tKvOSjxeyWmpJs2oZmvhmiHSp5Z5OhTFx8UgTJcZKZ/UfwmXdorq6N0EpmJq?=
 =?us-ascii?Q?QVKFNOuHuoBaJe2NOPe1lQWxKIpY8eJTEOkK5zjhDmq4EQWlSv1GipJclWl0?=
 =?us-ascii?Q?y77OIA59rRsuvfzev5ysoY0VzHweXQjJjYcEVVUZKls1eXZF1cd/nGbbohty?=
 =?us-ascii?Q?OQT4GJsJgoEVy1xAWvO0mhS4PTZaLOS0VCPmlRjGOu+D2raXJg7LYPUB6KGs?=
 =?us-ascii?Q?iexFSkkZxorJiGapl3kexZc/E8OLQgBg5ngakUHRkvRIWIIAxN3OcLpkLXoV?=
 =?us-ascii?Q?LNalhzVZupkr+5Pavg2wKpLD9uYhBasynBz9ww2X6EQplDqm11P7licrwXWn?=
 =?us-ascii?Q?jALeZMNgTWP4D7utWiml+szc449bJySAgaurVOvlMCa5wBFp6MDE7Alxl8d2?=
 =?us-ascii?Q?2exZdN+TTigB6OSNMV6yWD+OuDq1mgOZMLV6VX0cFHzfAudrYY39ONsjRlXb?=
 =?us-ascii?Q?YwgCfeHwJUrAEEIZUsTWsKdxm+s4sHkG6MbtaWlXf5tKGqmpUXTkBY6adLuf?=
 =?us-ascii?Q?znQEmHkw33SjKbkoA8oHvX4FVf+w8MDyx101g/REU2mkM0bX83k+Q2JO83XY?=
 =?us-ascii?Q?qMxJX6FUdMIia1XeLzMzbvFlOw7C4EfATfmqC30GN7M1dsKgkW8rXD3qx3lg?=
 =?us-ascii?Q?HXTwNMAy1Hq7u1sY0gXB9EjIXHE25IEQ8HNPeol8JVy4hpyV9navbwNG229w?=
 =?us-ascii?Q?bz2aKDOgdAK5FiQ4xDRFftR4UeuQ7j9w2THQCdttX+Z5BWVaHwCtzP++5ozG?=
 =?us-ascii?Q?avbKwRvqfr6eSrmLRBqSIWtD638s5kcs4kk9FJX5rJMWg1iAP+yIkPTWxI6K?=
 =?us-ascii?Q?27O8yCW3OeH8K47BeGQe6poyfyO92K3AZ5dzS9WEjJSUe0vmWtGdOd6F2wu7?=
 =?us-ascii?Q?5c5ddAE9oC16/WLBLom+KsASLhyuqAqg8V+vRJsy08kR4ZlRBEgGn+04LAo1?=
 =?us-ascii?Q?i8f2zLWfE5cu83m92Bo4FmI9inpFj0wzvOpJlBco1cJI8UIdoxSsIg7WrMcZ?=
 =?us-ascii?Q?yoRCaX/UI+j/gxPqbvWmRfYfqLJBs7Fvh0mdwyx4FaNZT8Q5QgqBVJEuxoRY?=
 =?us-ascii?Q?hFz8V8CIHEuwiWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:21.6848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdcc08c-d024-4745-4158-08dd60d54288
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636

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
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v9
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v9

Changelog
v9
 * Add Acked-by from Will
 * Fix typo in commit logs and reviewer name
 * Allow invaid nested STE for C_BAD_STE report
 * Drop extra indentation in arm_smmu_handle_event()
 * Drop comments in arm_smmu_attach_prepare_vmaster()
v8
 https://lore.kernel.org/all/cover.1740504232.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Jason and Pranjal
 * Fix errno returned in arm_smmu_handle_event()
 * Validate domain->type outside of arm_smmu_attach_prepare_vmaster()
 * Drop unnecessary vmaster comparison in arm_smmu_attach_commit_vmaster()
v7
 https://lore.kernel.org/all/cover.1740238876.git.nicolinc@nvidia.com/
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  36 ++
 drivers/iommu/iommufd/iommufd_private.h       | 135 +++-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 include/linux/iommufd.h                       |  23 +
 include/uapi/linux/iommufd.h                  | 105 +++
 tools/testing/selftests/iommu/iommufd_utils.h | 115 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  60 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  80 ++-
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
 19 files changed, 1298 insertions(+), 408 deletions(-)
 create mode 100644 drivers/iommu/iommufd/eventq.c
 delete mode 100644 drivers/iommu/iommufd/fault.c


base-commit: a05df03a88bc1088be8e9d958f208d6484691e43
-- 
2.43.0


