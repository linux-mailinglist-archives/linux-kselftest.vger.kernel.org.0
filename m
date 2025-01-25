Return-Path: <linux-kselftest+bounces-25140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A44A1BFB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E3F3AC406
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E865CB8;
	Sat, 25 Jan 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PwvE4QU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D925A63F;
	Sat, 25 Jan 2025 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765073; cv=fail; b=cJDh53Hi9cfhykpxJfDddqVIPcFDIriPUqGvoEC+M3ao1zZmWQaW5yP7kF6qh29HyTf2j4EI4KUYmzJ6yPcYarvElMp/KurLsDC5uJDkE3TjRifZaugK32ZM72Tzh6PDBDF5hjekfKTY1nA9rAs3bkGBQszhqgOHdrrRC2dfDwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765073; c=relaxed/simple;
	bh=aSLnp/Ky/R6LcVB23x7JB5v1s2s3Ibsd9+mThKnTXPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aYJzxaCBSxswLTZNQNqSxYvIlvIrGQ8lfp1dvdcszQ6W9qT7BX2onXU4nKUzJbNZln6ElEBTrHZRAogddTIYxBkz8iKDjv19R2rCK1OlHOLn+nlvweqGiJbU0js4u4QR74UbeXiSPxsdI8OyQ96YrQfxbDH3xpN9w3XcZdGsbJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PwvE4QU7; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzDBwjXpywsafpLJW3CRcYW7Ahy0ENneJJj9hepcbDFb1pz+xx3hYDE8uQgjpcjlJXA+6CHQseOLfe559qVC98CtjpJqCqh/dS41X2DZh/cm8Vt6cxF9/FAcVTY0vf/mk3qIaxQsJKvch5dP9M3GQJ4/hqQMptekeFX3d6BduN6zSv4PJoRK2TFZguwCQyV+rEHh7YxA4AVbhRle508wMaJyBulKxp6fqKI/2JSH2UxvcDB2X+BEZEGFESEdv3ubhY5Jm/ekC03HgSckTjXoUfRNQlJ/I6MlaGymm7K7gihWT2OdNe7m+xKHuV0f1MQ1ZQMiv8EmbmW9RN5U7GSW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcQHNm7vjUnDLo9glyQKwAJRH1ODoqabL3lrwBonExQ=;
 b=dY9Axn5CKKmefA2IF8Nkk1S2azji7xFKAbBJz4rqcfStt83cSKpw/poS49+axjCOKxfsdlOKvCDsxCnZuC445TUZ/tLDdWyfRQgBPKzTXpsyiLCCYGWiWRcuC5F/uprQrNz00NyNzpjaQRkFktePIfnqFwJ84kBjZsa64WKVRleCgCb6+almvPxKqOqHPRtMVYX+zt4AXJHzYreSQt27dUetSLpHraKTaAgkgZ0DEv3u5dzKr83APaJDK4euoo3VpGIz+QTErDGULbK/Db1scSipZRZiOKubPAbh6g7vFvkJjCcgtCZv8ii7nFwP/1JTtRd0suO8dGd6a6mcZPrz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcQHNm7vjUnDLo9glyQKwAJRH1ODoqabL3lrwBonExQ=;
 b=PwvE4QU7pR8UbH1gn4wWWZBMxVndd60i3/jcFCgz4Gs5PabsN5Gs9zUPBfKqCzDbpaaZdMM0CvTXM8fqZvxo9Idw43/0HkHUXzGlrM0WcPn69mjaKmI1/yu+aM2Qzy+hUZ1+01zMH2amJp1ZwKiUvPYzxJkHe+CA6QOUO0vOSkIYzM7OHkAJp717NA45MNWEWx6GuZg2jouXPpnswR+4OA19S7c67hWBUlPmSmeQg5GCiBjV83HELxlXWNOT+NgszmWHpELIQ8DLdZo8KQncmLQjR2QWrHtWdvYT3f43/fRx/MvVSxA0ZhMb1pTdMPM43azVaJW/VvZMPZcu3fESkw==
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 00:31:04 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::6e) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Sat,
 25 Jan 2025 00:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:30:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:30:52 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:30:51 -0800
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
Subject: [PATCH v6 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
Date: Fri, 24 Jan 2025 16:30:29 -0800
Message-ID: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: ad74637a-3bba-4b2c-c422-08dd3cd78d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lj0m59dNbp45cQJx7AjcyPY625VhWBzINiKod9LCp9EOb56fgFJ+LwUCmzut?=
 =?us-ascii?Q?n4luyQVMKPYFpY/HwDKEWXN0GHYVxkdKeEkMrDje7kIH2YyFUyUc11OC/+kF?=
 =?us-ascii?Q?sUkJqI8t06JaXwu4LRuuJcSvu/ipjm1uA2EsGTuoic97ws1jAaVVu+E5Zz+r?=
 =?us-ascii?Q?qlAA5z3d7ULuqL0aCE6EPEs9um5gHhu0t1vywG1EDfjMfVD1579uvSS9mRK1?=
 =?us-ascii?Q?8h4Tla/V6nOOlxV6ebEg3Xn8HteT8lCYpQcTWCxXrXnb1AGdAlYnx5a5beZk?=
 =?us-ascii?Q?UKhWAQFp64HCjEvUuAVXe+wr5mzqDz7Frv/Z5WSf7OYlwyLfCSsaWJ/tb+jb?=
 =?us-ascii?Q?fiEeTyRxdMrWpbnRTZJz5z1U6Zv+5r2ck9fErN+8mBCMvEzBjk69zeNrVg2Y?=
 =?us-ascii?Q?DvfDCNL/wsuEBbE03A/WmoJbC0GQIfjFWXKYDkRpaC64AZxNcHHyxWzM6Sfy?=
 =?us-ascii?Q?TUB+3e+rJbn0sUTbYHO7pIIZe8Ay7Hnz8xtHCyFpXJzFq5iX3bSfplUIZP9F?=
 =?us-ascii?Q?U9CW0uKZf/EnJnzhqQ/uHFmtkUriIHMQyv26zuyN47dZCi+gLJO7ckZpteIX?=
 =?us-ascii?Q?louPTGARSjeL2QmrsS7UxVL4zgsaLWFMwmo1TJups5+2KU2L8MAmp8eTn5II?=
 =?us-ascii?Q?MxDa9WlWUTzUfKThHc1fJhK+ufizSjAFlXI4ObCvqQfYolJ1fm14nqvaQjU1?=
 =?us-ascii?Q?/KHUCrSsA8FDT5f+e0860IJQh1aJKUgdrHYEH4xN1/gJD7yknFjGbhDMoTC5?=
 =?us-ascii?Q?pPG6fMpWnwoPH+Bt+WLGlhQ8K15nApQBFYwcwLMSJI98QQrliL6sVtTARfTU?=
 =?us-ascii?Q?Sl9aHcJohF1hy2lOtvZNhkPng1KTRo/mnrDNYvbzTi87hGCzBmstYfUv9WAc?=
 =?us-ascii?Q?7x7Oi71aYHQDRioK40RhjwU8GXDyvE9Y28NN5oYSAz6sjp+ow5hfiUVXrnbs?=
 =?us-ascii?Q?ojJwoMM0FK3XmpWmaoqqb99icSv085wsBEdYBmzYOsD3mWFMTLgUIIqK9M48?=
 =?us-ascii?Q?A7vaUNwsxxUOPO1Omq/6xIG5uSC7LrT86y5nFfQzQLDvxZt73F86zimFZHbK?=
 =?us-ascii?Q?F+E1w/PSukAXtFeRijjwlL9NxhM/VCwpGCoAZbwntZI4Gp+t1qO3ww86ekh0?=
 =?us-ascii?Q?CSZjiaxPBY7T2IeaQtDUV6KYXq38sF8xJvcagilOFmchbX+3FU9+wf5KWydR?=
 =?us-ascii?Q?cwJo/nhPrUhz2qO6EhuhT9su9pdn5ivrWTB0Ee5RsouKTHZ/zM1ql+N8WhCW?=
 =?us-ascii?Q?HO4QEiurXFQSWyLlp8qP9NUTTcnDXKreghSNhSlbguMXiWFlm9Az5UZVMtWh?=
 =?us-ascii?Q?L7x7poYYtZGBEs5qNZBqhXX9otO/gvm63Wkx6W5ZceopCgqy7QxrOAgoHA3w?=
 =?us-ascii?Q?GwGDT8rXr7wHFArjACHhc23NvdhPim66CBMfIs6VskPyios4VFz6X2JlSVI1?=
 =?us-ascii?Q?BktXPhmEu3irebZR7V7dNF6rbQwIMfbD1Wdh6DTE4Pi6mnXQLp1QxaK6Qh+0?=
 =?us-ascii?Q?wQvSozSVNBaMKL8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:04.2026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74637a-3bba-4b2c-c422-08dd3cd78d65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

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
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v6

Testing with RMR patches for MSI:
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v6-with-rmr
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v6

Changelog
v6
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  31 ++
 drivers/iommu/iommufd/iommufd_private.h       | 141 +++++--
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 include/linux/iommufd.h                       |  23 ++
 include/uapi/linux/iommufd.h                  | 100 +++++
 tools/testing/selftests/iommu/iommufd_utils.h | 115 ++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  62 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  94 +++--
 drivers/iommu/iommufd/driver.c                |  69 ++++
 drivers/iommu/iommufd/{fault.c => eventq.c}   | 364 +++++++++++++++---
 drivers/iommu/iommufd/hw_pagetable.c          |   6 +-
 drivers/iommu/iommufd/main.c                  |   7 +
 drivers/iommu/iommufd/selftest.c              |  54 +++
 drivers/iommu/iommufd/viommu.c                |   2 +
 tools/testing/selftests/iommu/iommufd.c       |  36 ++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 +
 Documentation/userspace-api/iommufd.rst       |  17 +
 18 files changed, 1018 insertions(+), 122 deletions(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (50%)


base-commit: e94dc6ddda8dd3770879a132d577accd2cce25f9
prerequisite-patch-id: bc39b89c8e2b8298a337943610e1cfd84d9b7d7d
prerequisite-patch-id: 5cd371c3fddec696510e3e9c4f449dc60bd7c2ae
prerequisite-patch-id: adbc6b7916b03f56eff01a9f1b33a7832fe0884e
prerequisite-patch-id: c62d01dcfe8faeb928847fb4e51f82eebafe6ae3
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.43.0


