Return-Path: <linux-kselftest+bounces-27496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD218A44834
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BF842767E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F6199230;
	Tue, 25 Feb 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K75H/bnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A9195B1A;
	Tue, 25 Feb 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504377; cv=fail; b=B1eIjl8un2k4wzoU0cvRugENY0xs9r4BOx33ApsN/NA5G3oMlg8QaX2JUex5PDv2A2DOqfR3XVcx6tYZBdB6fiZREQk2l821T28z2brMSmGUTANHbqDsqL8qL8Bl+61H1yV1Sv6jJvo5p1t6CvhjDNBuoAk9dEPZcwnkqt5ksmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504377; c=relaxed/simple;
	bh=EmKJXhMpWM07yNt88qWXrtt6UFt+Y8EiJxZm7IMAoQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cJ3/wHQWWs7+HJMcfuyPsDBz8cZy0FGyVFkpwvrNnO8NKCGZBsXLScYTmXHrSOJoxgwZZLpZSn4WRwXkd/ny5diV+bYoeZtTZs9F3cag/MFX0Ku3f3yffx3wkuNdshyej/53fr4l0jPCbUSFCPvIw/Zk90oDHOwXQ4kuV7wRiq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K75H/bnm; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+DgWuuoFcxz9NQ+joS3aYJdJX4GBG3vMdLkfFvOJuBl5gIgb411QXUNWedOwQJ1VX3b/JroALoE8/JqUGt+wkuGxvFa1DFmbc4Xhubt2Vp/C83LQXGmGzxiq2VvgghVzN5rp3HdOyYdIg3/sDrmptMhW9i2U5Jh6BqHIscXhXrW1vDDOggQjfk2YZJW8wx9qVHOxVgU8V+4pIUFlIyjMvgpSkp7UvFLwE3D4saTTMYDcAgT62HnVOS+coaWBsRQkJZKIik8zmLRibtku+M29wLScQrWVqecZZf/CJA47oCn5TOSopDq/YB7PbTEINchC1+rJ78gmE4L7f1qzQULjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdt/ZjubCWEz4qP4bwNqY+aEwSOO6ZQpIUTHskIWEQ4=;
 b=lvdtvcjrO17riyHpnpEJAcbM8TPjzNxIvKh3DrKKypHlkDfzWRsrQkBohcZitTxniTIrF+PZvhYJlhOfG/Q7wacQNeTwnOMIHQRZrvP+NJUfb7nZuyK+0+U8IUX9UP2dDvj1a3mSDkZk9OQI0SrBQAxBmhJDNymPXSKI3kyxJowPhVYmA694b/mwnmtJO99CL6P8SX6HrFZ9l3tV2nu+kI+J6PhTprWHhwxlYu/Q6WEJUQbsbaJAzzScMRqUcnlViIS2+WBzwP1opnbduKLpyQwscD1wTseHgUW2elpQJ2sgsASfI44s6G7UfnxbMl+uxzipgPiekapxwpkvA0cUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdt/ZjubCWEz4qP4bwNqY+aEwSOO6ZQpIUTHskIWEQ4=;
 b=K75H/bnmdJpBP2FP0Gk6MN7tspPYtspng9PyJ6NpPSUln+pUGjctPcZonH/IrX3hlD8jwj1ElVfPDeGA+egiij8NCq3moAxcAVRjTPiFfiMNjdaCsWY6i7yccYgPpmqOdJjHIWIsxoJqeq4cwoVSs3iN2+QQNMn5c6E0CuL8bCAVn/EfFj2ApzbwtMrRAwMAuLc3lzG++T+z6JkxWSZK600SDtGPAiqWGxmhvZWxPYVipoPQj/CLmQgKWeqxXGTUMjxffHsNhyKEvYL4ajN4pBz3t+P4VuplgaLThjjUExNOzEFgcKcH4x2HKsDmKXFp+3AM1VBDDU/Vf7mXPgte1Q==
Received: from DS7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::16) by
 PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 17:26:08 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::27) by DS7P220CA0072.outlook.office365.com
 (2603:10b6:8:224::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 17:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:25:54 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:25:54 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:25:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
Date: Tue, 25 Feb 2025 09:25:28 -0800
Message-ID: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd05ad2-27ad-4d7c-fd7f-08dd55c17dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/iWSlmXcl9uvFfMNV2LBCzIMKWVLkwWBe1Tb7RsiWD37V40NqVZfktP54ZQ6?=
 =?us-ascii?Q?9SQmPI2j+63uO8ZrcF9P4rsiaGHoWunlc3TpKkJOkaSy3YK9rkBB4+9PUHd6?=
 =?us-ascii?Q?PIgWiBeHpxWFZz3cibsihpvc6N8ZJ0yMXTwoaEyFdWb4CUdYBNjJF6qhDe4T?=
 =?us-ascii?Q?b/vPF2t0kZgRFDdyCqfK2/YUqrtGTgXhlNUD2CSwJDlYeF9inWGNuJv2Beb6?=
 =?us-ascii?Q?lX/efWJSMpJt1MK6kl16oF7JtIixDFVHyNa4OI07PPmV/E26Ym5DONS7q3ug?=
 =?us-ascii?Q?MrGxRyTbRO8/cjOJq6grGp82lt1zb1YXWGOqGtBToaZtLKLXzTRhlRkq/a0h?=
 =?us-ascii?Q?7RsQM7mRVbU29lnVR/GJ/gZdQnbytxCDv6nBGucjsc5NaSbFwfMqoeqsTPPc?=
 =?us-ascii?Q?UiYG8e6ublJNLp1gkrwQY71y9xO9aj/FXsmJsylCdteMz4AJ7fQdzJuQT7iZ?=
 =?us-ascii?Q?CR1HpJjX0FWNYxmukAZox3XDeyxU5ozmTXA0Yg2Nc+PAhyz5BgcsmLeN9Mqh?=
 =?us-ascii?Q?IvqLhFpxLyB11FSEgrUAQj0M2xWArAarWu2/Pbq0Y4JR6FK3vDemcAX0GM69?=
 =?us-ascii?Q?VJZrCCVvGEqx2QK7JPFqhaY+ZLDw83rNclhdJsmiZoO1TgWr9X04pknxWHA6?=
 =?us-ascii?Q?mvN16awbHW0mpBNz2JEmay440x4bwX6M6Cwsbd+eX5vnONYsnAb3UyMQCmUA?=
 =?us-ascii?Q?sWpmSlxyJDn+d9TPoEAUIoY0FQbNI+l8dJYbIm0zcd5evB2Kg+Xg1XzZ2mOy?=
 =?us-ascii?Q?9XCzsVuMEKwclPRxB7dZczUwzIrEBHxYIN58hJywZ2G2hKQumxKcp/d26EBp?=
 =?us-ascii?Q?U6yLxtZtx/asNrmbleH1KYPXLouRNh+/OFPMbGnpysnidqNsJSIGrkbwC+LG?=
 =?us-ascii?Q?nbOOdqyLlIzX2eDWyazWmHwv3d2cHXyfHVn6XJxtpPtB05fq/obCzg3oDi/p?=
 =?us-ascii?Q?pybfe69D/xb2ajc7qNVx6zKOyTahStXlkQ64ZV8+dKfxl7vULrWxIKKOCYse?=
 =?us-ascii?Q?sgLuYXRxq5L5xjawoH6o/bFkNDdY0sXvmlZSzBdotW3MLCeSfzCF7KLwVO23?=
 =?us-ascii?Q?e/TSBV3Rbwo88oM1vE1durAXa103vZFBNRGTrcyRPkiJ4oEESiuxS9BtznbT?=
 =?us-ascii?Q?h537hKgXprsy3hcXFUPmMJJnx1kMw0G3CWCOOe2es5A+FqVlg3H4kaQLUNSj?=
 =?us-ascii?Q?gI+bpEIwFVTKKJLESz40PXBvl3GeUcEnLibX1Na25z+V+haGt1l2FnxEF6gW?=
 =?us-ascii?Q?7XwJeEjPbLSvDm9tvHUIGoPnC4W3uqtJbJkU/sXoh0ZxZ+xmWIk9VXHHs/92?=
 =?us-ascii?Q?0kZ2UC0IFIUllskEXV+D/+9oB8/npmSj/L0gVZfB2EsaBANAmIV6aFz7BlAY?=
 =?us-ascii?Q?iwpYujs7eluPRCxBwbvv7iSgVrypsG4EJ6J8/nxBQt9VgG91n/2FyN7D0WLq?=
 =?us-ascii?Q?leu32y/H48JBV4uLvpwOrLAmgeXvIaV15jjxSBhQEvHuEKuEppIzIE0p2CFx?=
 =?us-ascii?Q?U82iMUKr4XDjpF8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:08.2354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd05ad2-27ad-4d7c-fd7f-08dd55c17dc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

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
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v8
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v8

Changelog
v8
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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  64 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  82 ++-
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
 19 files changed, 1304 insertions(+), 408 deletions(-)
 create mode 100644 drivers/iommu/iommufd/eventq.c
 delete mode 100644 drivers/iommu/iommufd/fault.c


base-commit: 598749522d4254afb33b8a6c1bea614a95896868
-- 
2.43.0


