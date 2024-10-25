Return-Path: <linux-kselftest+bounces-20720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA79B1366
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BEC1F21BDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88C1FCC6E;
	Fri, 25 Oct 2024 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hgzEq0XU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70561D9324;
	Fri, 25 Oct 2024 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900211; cv=fail; b=tUFGLrc5NQYuRzRgTTE05opmXbEmCTlGNiRDrr6O4bn6WQBk+ZgrblMst7m6Rm59EaGrGAGPYlVZob4BnAlBOf8CaZpGkHaQ5MkPwyrhsV26DGTMeYxxF8au6gCjbqZBkyWRv080Z+8s8HAPuYq8+L6SYq9wVqt7Y1MtHmq6fEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900211; c=relaxed/simple;
	bh=GraDk5j/aB5hssqSOcqf+pNL2+BTfXqa1WbRP9fLHVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5KCgPx5tyTCh9Ux5Wbwys9xI4pFmI9RPuTw3d65JguWt+ordXW/QKbx8c/3wAGeT5efA+ELkXzCUACJsZbstUcRb2ZFMnYNMbYZ2YJJ10v1bS+w4ExSQ33MzOlnLBZJzw1ROICe8m60RGaZZtoQbV700J8IgDSFgxjOdZmQGkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hgzEq0XU; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2AgUYlFTbA1rHY6tM3wlGuqpjSiycMhZgFWNWXIQP75AGs1fo4qbKruae/VlIbRqQT4KsYG6Erp1Gp3ZE95x2PgM/DcdbHHBnet0tDDNIMarb4lnk/VU4IUH3eC5aB48wbYvBjuzdXsjwfcoMvd7ijwoSqh4NEO47H5MxOZyCkjLn7ZHrb6anpqNxQcj7JYWiF9bWkvjdF+UMxybPtmvwcuFP9podFPPk5IRajBnRH7Io8+JfANyhoD8Vln1X9qwI7YbmtwbZKaXlkE/QfEnGHAcsxeR+f+X2AUNiIuU8+4H6xcWRu4pDNF2BHsOYDYrb8iab5fGPuHdePDfBNlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=angSK+U7aosRCjU3l8r+v/K1Wb89gaQMBz/bgw9d1as=;
 b=LZ+OQxUP0cifeaJlTvOlQ8OF7Nb1OqZh05yz6gwO3FsdKBYkwLWYMg3JP1x0vmajPk6r9zivssT3Lfcfgc4uVfqrlPZwscUIlrp5t7nz7jxtBMuRKcjXjC4N0u4NM1ejSH/QGu05SPHNk6TpedkwfBSQLsMKB+Zq4e0yCoj7SFJLUb93eCxc787xG8zDt38ADJXZoPmk0MZqFALgKR6wrh6pAqqLfZP0ocsYL1gaojJim0LUjAO+6xBrIMcZRJtUO9KlaIgpMBYZTbe6crMB33FczdALp4S3ZO5SPoJ3eqXyeYJq6vNyQ6pH22K9AZMO615MWr7XZX8psA2IJpV8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=angSK+U7aosRCjU3l8r+v/K1Wb89gaQMBz/bgw9d1as=;
 b=hgzEq0XUVrQf1gCiD7l8mgsKAQmo+U/niBOg1Kkujp3wvdvfYhAfEbT+Q2o6ssIptFM14LfS1Lx1J622yQB9stSX1V6afIeJgLWDTVirGEzrr3KN5pGcbPoCLkdhzU9sW9T5EDUsfmDW7IOO9sTAO57Gdny/GHCcbmAKMqvvDrXw+WClUSzOrb2meWnXe+Mh7BFFwtvbxxXotLZd0Qj/xlkvyxtMhQmY5UEksdMMHa9G5rXxg2NUdV2w3uFnSyif2buySU8N6fzyUFFnlnWhu9/II9xPZpvUIYTapkaB5+a7CD4agnbmp0IWyDWIAbT48XcuhIUsyEFHf3XX8zSwng==
Received: from BYAPR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:e0::19)
 by CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 23:50:04 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::d5) by BYAPR05CA0078.outlook.office365.com
 (2603:10b6:a03:e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-1)
Date: Fri, 25 Oct 2024 16:49:40 -0700
Message-ID: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3f6de4-5109-4531-a788-08dcf54fbf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4WE+Sto4VOB5cM4N2IUmHKEduH1avCXudD6UHcmPW0z9UkyZKXWcGvkRYD0?=
 =?us-ascii?Q?UFDT0zanLPAFeVOIIQULXbtpF5/9xUoPPytGQkMJzpmgJRIda2yKWymNk2cB?=
 =?us-ascii?Q?HyFrVyztZCK/SGyM+sCCxWN1yIoRj84VTr4BgjMgu64I+2aCa+Pl5c7aQK2E?=
 =?us-ascii?Q?DZZmuX36jvuBhB68xcHNacCtha+v0qXHTrELL2TgdsVUoaiI9DtdTIfqrx2H?=
 =?us-ascii?Q?MUJ9JxRO0p+lJYh8ij7SQzHVCGlQqjELPJ46bpJXXmoStQEmwzOAgl2USWc9?=
 =?us-ascii?Q?GWRhL4k2JomwFBquJhzNWq93Wbkhmwe+fSSgWgmU1MhfQqycxwmBjqKQz5N3?=
 =?us-ascii?Q?wlDmgsNZod7T9bcFzkbWmdcW18O1BpjKsHZXpaUZKVAkRUAr0r7v6ygfLLie?=
 =?us-ascii?Q?/DL07aKW4dFKuIIOvp8BDrPKAj6lt5kozs5aK7z08xDHLHIr0Nmd6h4vVLM1?=
 =?us-ascii?Q?ZacjZodjyhPHpQ4h9oC+iE1swQKtX2xgFDX6mHFBUNvtHT1ddnE4aUC6fNCV?=
 =?us-ascii?Q?QYMqhnpdRpI+9E6ITMwwASLfJ/YdR7nQFB66yYld9DydQkzFyzTXvlvK277j?=
 =?us-ascii?Q?pLKPQ3vkbpoBTuEsD3lijaOZArgSSLUGrTfpc8JuQoGIYtOUOmKvIXuXX/2E?=
 =?us-ascii?Q?gpoRNIqWw+1smO5TVWVGMk+tURaZ/iAENtDRKPAy35DBITPV9NUNV9EtihsG?=
 =?us-ascii?Q?EZzO+qTo+r1vEm0wflD63dIaGacO+NTyCb7fcwDl5NXESXId9K2ewnDJK2j9?=
 =?us-ascii?Q?7u0TdOqt5Gmy31VmHjh9fsul71G3fwxr/eB6Cr+W74++fpXjY9bBiXBoVzPh?=
 =?us-ascii?Q?edqgH4NU+GwUDkN3SFd+djo8ULvACb4qcz6Fyg8lgO+IG4BvlVjaqZ+x5qya?=
 =?us-ascii?Q?5O4TC9SHFZ+ihroLGy0ciJVNE+3fNmMs12nZFnI6dJigVWxXRf1VW0Ch5WEC?=
 =?us-ascii?Q?NTkIBgQXhqpaFrHRM0J+LAxGLKdznnHEas075pIZedGJoJ8BUeAC+0eo2WjD?=
 =?us-ascii?Q?4D2pD2pnVLsYiSimB0S8oTRX5A+zDOAOgiN8wkRPwg3WUR8JeTNP7fTqyqae?=
 =?us-ascii?Q?rbSZ7E7l/JQZoqQb1GUPRtbwVY78m6RAtg4JYGm6ttbhUsvE+jYQPJPEEulw?=
 =?us-ascii?Q?AlMXKlHnNXb8kQ2+dp3+i6BRVwx34OhPCVn3NEeHxII8nR47VAP0IA4mClQA?=
 =?us-ascii?Q?9Y+KKVnZi8MbN8DVIQ3vBSBUdgL47M4pEuV8SRb4qWSL6UqRB3ojoowhJH/J?=
 =?us-ascii?Q?1K4qyAaSWf31j//HoX36GmRr5LB3SDVslq1Au4BjPmYVmAq24DeITlMr32Rq?=
 =?us-ascii?Q?KV1bN4swEvrYop2qChYFradpPbFSqcG/o2I3zWjqf377P6BaEvEqhYGtxw7Y?=
 =?us-ascii?Q?chBmYM0SH7Q5ifvCsvXR6Ul92SZ1b5ObkebdutF84fF9Hw6Z6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:04.4252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3f6de4-5109-4531-a788-08dcf54fbf8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518

This series introduces a new vIOMMU infrastructure and related ioctls.

IOMMUFD has been using the HWPT infrastructure for all cases, including a
nested IO page table support. Yet, there're limitations for an HWPT-based
structure to support some advanced HW-accelerated features, such as CMDQV
on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
environment, it is not straightforward for nested HWPTs to share the same
parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone: a
parent HWPT typically hold one stage-2 IO pagetable and tag it with only
one ID in the cache entries. When sharing one large stage-2 IO pagetable
across physical IOMMU instances, that one ID may not always be available
across all the IOMMU instances. In other word, it's ideal for SW to have
a different container for the stage-2 IO pagetable so it can hold another
ID that's available. And this container will be able to hold some advanced
feature too.

For this "different container", add vIOMMU, an additional layer to hold
extra virtualization information:
  _______________________________________________________________________
 |                      iommufd (with vIOMMU)                            |
 |                        _____________                                  |
 |                       |             |                                 |
 |      |----------------|    vIOMMU   |                                 |
 |      |     ______     |             |     _____________     ________  |
 |      |    |      |    |             |    |             |   |        | |
 |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
 |      |    |______|    |_____________|    |_____________|   |________| |
 |      |        |              |                  |               |     |
 |______|________|______________|__________________|_______________|_____|
        |        |              |                  |               |
  ______v_____   |        ______v_____       ______v_____       ___v__
 |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
 |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
 |____________|   storage|____________|     |____________|     |______|

The vIOMMU object should be seen as a slice of a physical IOMMU instance
that is passed to or shared with a VM. That can be some HW/SW resources:
 - Security namespace for guest owned ID, e.g. guest-controlled cache tags
 - Access to a sharable nesting parent pagetable across physical IOMMUs
 - Non-affiliated event reporting (e.g. an invalidation queue error)
 - Virtualization of various platforms IDs, e.g. RIDs and others
 - Delivery of paravirtualized invalidation
 - Direct assigned invalidation queues
 - Direct assigned interrupts

On a multi-IOMMU system, the vIOMMU object must be instanced to the number
of the physical IOMMUs that have a slice passed to (via device) a guest VM,
while being able to hold the shareable parent HWPT. Each vIOMMU then just
needs to allocate its own individual ID to tag its own cache:
                     ----------------------------
 ----------------    |         |  paging_hwpt0  |
 | hwpt_nested0 |--->| viommu0 ------------------
 ----------------    |         |      IDx       |
                     ----------------------------
                     ----------------------------
 ----------------    |         |  paging_hwpt0  |
 | hwpt_nested1 |--->| viommu1 ------------------
 ----------------    |         |      IDy       |
                     ----------------------------

As an initial part-1, add IOMMUFD_CMD_VIOMMU_ALLOC ioctl for an allocation
only. And implement it in arm-smmu-v3 driver as a real world use case.

More vIOMMU-based structs and ioctls will be introduced in the follow-up
series to support vDEVICE, vIRQ (vEVENT) and vQUEUE objects. Although we
repurposed the vIOMMU object from an earlier RFC, just for a referece:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

This series is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v5
(paring QEMU branch for testing will be provided with the part2 series)

Changelog
v5
 * Added "Reviewed-by" from Kevin
 * Reworked iommufd_viommu_alloc helper
 * Revised the uAPI kdoc for vIOMMU object
 * Revised comments for pluggable iommu_dev
 * Added a couple of cleanup patches for selftest
 * Renamed domain_alloc_nested op to alloc_domain_nested
 * Updated a few commit messages to reflect the latest series
 * Renamed iommufd_hwpt_nested_alloc_for_viommu to
   iommufd_viommu_alloc_hwpt_nested, and added flag validation
v4
 https://lore.kernel.org/all/cover.1729553811.git.nicolinc@nvidia.com/
 * Added "Reviewed-by" from Jason
 * Dropped IOMMU_VIOMMU_TYPE_DEFAULT support
 * Dropped iommufd_object_alloc_elm renamings
 * Renamed iommufd's viommu_api.c to driver.c
 * Reworked iommufd_viommu_alloc helper
 * Added a separate iommufd_hwpt_nested_alloc_for_viommu function for
   hwpt_nested allocations on a vIOMMU, and added comparison between
   viommu->iommu_dev->ops and dev_iommu_ops(idev->dev)
 * Replaced s2_parent with vsmmu in arm_smmu_nested_domain
 * Replaced domain_alloc_user in iommu_ops with domain_alloc_nested in
   viommu_ops
 * Replaced wait_queue_head_t with a completion, to delay the unplug of
   mock_iommu_dev
 * Corrected documentation graph that was missing struct iommu_device
 * Added an iommufd_verify_unfinalized_object helper to verify driver-
   allocated vIOMMU/vDEVICE objects
 * Added missing test cases for TEST_LENGTH and fail_nth
v3
 https://lore.kernel.org/all/cover.1728491453.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's nesting v3 series
   https://lore.kernel.org/all/0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com/
 * Split the series into smaller parts
 * Added Jason's Reviewed-by
 * Added back viommu->iommu_dev
 * Added support for driver-allocated vIOMMU v.s. core-allocated
 * Dropped arm_smmu_cache_invalidate_user
 * Added an iommufd_test_wait_for_users() in selftest
 * Reworked test code to make viommu an individual FIXTURE
 * Added missing TEST_LENGTH case for the new ioctl command
v2
 https://lore.kernel.org/all/cover.1724776335.git.nicolinc@nvidia.com/
 * Limited vdev_id to one per idev
 * Added a rw_sem to protect the vdev_id list
 * Reworked driver-level APIs with proper lockings
 * Added a new viommu_api file for IOMMUFD_DRIVER config
 * Dropped useless iommu_dev point from the viommu structure
 * Added missing index numnbers to new types in the uAPI header
 * Dropped IOMMU_VIOMMU_INVALIDATE uAPI; Instead, reuse the HWPT one
 * Reworked mock_viommu_cache_invalidate() using the new iommu helper
 * Reordered details of set/unset_vdev_id handlers for proper lockings
v1
 https://lore.kernel.org/all/cover.1723061377.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Nicolin Chen (13):
  iommufd: Move struct iommufd_object to public iommufd header
  iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
  iommufd: Add iommufd_verify_unfinalized_object
  iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
  iommufd: Add alloc_domain_nested op to iommufd_viommu_ops
  iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
  iommufd/selftest: Add container_of helpers
  iommufd/selftest: Prepare for mock_viommu_alloc_domain_nested()
  iommufd/selftest: Add refcount to mock_iommu_device
  iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update vIOMMU
  iommu/arm-smmu-v3: Add IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support

 drivers/iommu/iommufd/Makefile                |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  26 +-
 drivers/iommu/iommufd/iommufd_private.h       |  36 +--
 drivers/iommu/iommufd/iommufd_test.h          |   2 +
 include/linux/iommu.h                         |  14 +
 include/linux/iommufd.h                       |  86 ++++++
 include/uapi/linux/iommufd.h                  |  56 +++-
 tools/testing/selftests/iommu/iommufd_utils.h |  28 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  80 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   9 +-
 drivers/iommu/iommufd/driver.c                |  38 +++
 drivers/iommu/iommufd/hw_pagetable.c          |  71 ++++-
 drivers/iommu/iommufd/main.c                  |  58 ++--
 drivers/iommu/iommufd/selftest.c              | 256 ++++++++++++------
 drivers/iommu/iommufd/viommu.c                |  89 ++++++
 tools/testing/selftests/iommu/iommufd.c       |  87 ++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  11 +
 Documentation/userspace-api/iommufd.rst       |  69 ++++-
 18 files changed, 827 insertions(+), 194 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c
 create mode 100644 drivers/iommu/iommufd/viommu.c

-- 
2.43.0


