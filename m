Return-Path: <linux-kselftest+bounces-20335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0389A94A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE54B2231E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF3156CF;
	Tue, 22 Oct 2024 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I16Nc4ZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D9323D;
	Tue, 22 Oct 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556421; cv=fail; b=YXQvMB14GIsmmIaRDKBgdqwpiJTBaptFiQjeYUHCeiNlC5PB4Btg08xNoVI/TpqKzuyLNf5deMGPWIFo3nIDun4SS1n0+nw28dpyLrffZAgvFq2kiQ2xt1/c3zhsXuRngbdMIVO0Wt70r7fAab3miP23l9dvCAp6/VzIHClIUjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556421; c=relaxed/simple;
	bh=zQAXK3mVr/M0qyfLyzgKny5JdYXCCq3jcdYRYWS/0xs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4CFDRtjZ5Di6nmfDdEhza28a5+H80bDKUWpZjadV5bTHP+2r7rB46dTk359lBp8YyBQe0XckpGXBcMpB6Q/TRpc+6p37Q1nB0C+demhdNSytJ+4raXuXy0RvRDiZANqb5GwAjpfVkGBmLZvmDOXJs8zbZwP9j+oK8Ur8ej2KRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I16Nc4ZE; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBGz7wV9QG/xkCIvYm7VZM7zNq6uIfGn47y/rmmZxZaJBdxCsTzHlMtGz/ZXm8qmM2AnhG529YPTb0ad2d4IVtfB0BlhAhFymTZ2Uv8ZIx7rEhWQAgNHY7DvmwL6ifNuShvr5zYNfbe58f8HQvkxNbHAhxDaScQQ5PjHHDF6b4OguAm18NTaag4OxfUOiLqbOf1W54QKhRVCU8cfEBveuYr7J+TwPLQ2KrQB8pXsWFnE7bEJ6ATt+8dslyjDBf1xWVrZWGpCtOsGixND2ExxAbS8ZJXMuf8G23Nd0an451Br4PcmSQr4RJiXWYiWV6rodkpWm+UNGoj4HDSkfPZzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhqKB7K1z9CPsLCHn2CXDS8+Dc8MItvHKfnslmf2bmc=;
 b=XCw52wqtUoeU5ehLSNm+f//Jltpu3zq+NN7E3icDGMe8oqAH5NJ9cyoTITW36YUyH7v8tpmZ6ApF7TDRCEVvPGm1Xok1vWgQ6dT7kw2vaGhnMM/V9UYlEyP6ObkyKu9FmmBCR99j5jcmpZQ4UU/XYmvKWryumE84k2nkKOHUuTR12iK1Lxg6UNkrIN0A5CITWt2jqhX9H3V36O1dmkeqj3jUHiJuRQwcHV2HisH6GfNgFdJV298LDhUNbnG1RZ8F0o8aNwOMlSOwYDn6ECIWbRsOGSUj24s0ieA9t21gxVNURhgshLwkO3f5r1IsRmiOowOOycUPPHNvHgG9hxwjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhqKB7K1z9CPsLCHn2CXDS8+Dc8MItvHKfnslmf2bmc=;
 b=I16Nc4ZELmsBwAwTfW+1EmU2WLKmXYUUM2n0iU6oFUI1iJmngmez/hAEZHM3/SJNcY9wNE1U9zRf2HZIFBArCFuooaiAKvRkFnDDgT5I+IOYMKW+qUtx1x9qgNTmP98LA2rZheDW2+xfviJziqXKXblqolKUTYaNEzfOH5e6AIMGE4jDyTwLA5GToV5z3uZSmRf4wS7RB5f17xYE+NSEx8YtXLEM0vs3TIKL/jO5PL1B1vyGH0XlkJiuiiyHmmxl2KT0ILHwp4hou23rtykONyll6FTR3UD8ncsoIE0lcj+L5Yv20W2AE3lwfJA64mxHl1EQTZmo4YuXRrGQuxxqSw==
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:14 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::71) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:19:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:19:58 -0700
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
Subject: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Date: Mon, 21 Oct 2024 17:19:22 -0700
Message-ID: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a629e3e-10fe-49bf-e071-08dcf22f4c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nrc2hic/f1YqP7wJ3G2ToUY/jNE+iJme9Ayqt9flekwrFz3/s9/wy/ZHlnVe?=
 =?us-ascii?Q?OJUjh0jVGCc7Jk887J3Z3E14L9l0NfkRW4U/uqQofxxjrClRLuDbEYkuO1ZN?=
 =?us-ascii?Q?whrI+3ESvCqYaitRHDY9MuDG3oP7Mq1yPiNhOsdej36naxRAe4+4XRYq2g7c?=
 =?us-ascii?Q?WR6dIOz51pG5sRT9S9npTLt8bCLzGxEP72rdAOC7oUHliEiwKrU5EUhJ9pvk?=
 =?us-ascii?Q?Q1paid86peNvRd/kRnDgiudB5Dm/5U+CYKHCS5V/rDyhR7IRrmhfeXxBPRkK?=
 =?us-ascii?Q?Ko0PhICd/bv8jvdjJAP3RNY8DRm5XQaz7HyiN8qk8zKhPxrFz9Vvr3GJv8N+?=
 =?us-ascii?Q?sMPS8/5LjmrqoTkawBd0kqKKibP1I4R+DzJ9lzPpt8fv4CYvx4E8S1cf/feh?=
 =?us-ascii?Q?lZao/r/yCsZxUf8mufjwcYj6upflBLSUiKZnvV51AoxJJo5S7Qf96TG2rVCm?=
 =?us-ascii?Q?wzt8de7tKLmGMVnTsVBNhpiQWLeJsgzxzsCw825BF1g9aBxZ6etmQKaJwyNV?=
 =?us-ascii?Q?zPJYIHTYCJnw2zn4ZclDxyQXgbl86AaCnhdLYTQIg5bPujAiO0LfvcMsn/SX?=
 =?us-ascii?Q?chlDA6trLpqBQwVSYZ4XOO5LMWjnXU/z1pMCpaDWAStLMaW47mZNUXgtzvRC?=
 =?us-ascii?Q?nI7OV+EA7HaAOn3TPb+mgnEaqEH7shCWSRhWeI6+4etpVlHSc4J7N3WngcH/?=
 =?us-ascii?Q?hPoi71M0DzKSWj5oxB7szuDuD+8DD2nwpgiBEjarx8VxIg3hlYDiL4sqdjob?=
 =?us-ascii?Q?YasWOP6fC/UyltN5lSxm8bBa6k9bx13c1LuNcLnlQIbNVVVs9+ryVAgN3AGF?=
 =?us-ascii?Q?OJp+/uJlRtLhyiADj1KCSqafdUhIq/m4VQPJ+m4NdqZ0+AakIE8y6C0/n0hi?=
 =?us-ascii?Q?8mNkTCItsXcSNhZCcIhR18FfvQjFyA8yPE9KcMZjDpoQYI1KeN+brNDAjRf1?=
 =?us-ascii?Q?PrC8KZwOsb20XF7x4VEEt0yrnRlqOQc3M5IhnenxJd4ZZtFaX46oxrIH6pel?=
 =?us-ascii?Q?UurBO1IAfxw4AYvwH/s73xQKId2aK5J5Ee4+cEvwyOMZ/XDHDODhtKB0i1rp?=
 =?us-ascii?Q?vxUvyG7wd5LZqSLZjjWEMz4SdNnnRSvYA5dVhFMGbxtSzZsJMleCOHdgHTE5?=
 =?us-ascii?Q?lLpK5PCow1OsFD8PNGqmIvVgxbWtCTni88YR7PXNjcOof2yA1TCSNim2LbSs?=
 =?us-ascii?Q?n3644GD1ncZkQJ0yzsx9EhdOergd5Qeq4RTTCCbW0CrNoQtfcAkAEncDujjG?=
 =?us-ascii?Q?AZZukLIQPJMN9U27egdfaP6uHCcgYskJpy/L001vY54tfJ4mIBVm+Y9HQgu0?=
 =?us-ascii?Q?BsTk9azc4lOVl4sgGMI8rFn8YaNYZ8pPH7sNrsV7n1umQzAJc+zpyiGPTjtn?=
 =?us-ascii?Q?8nJIpxgjwKX9daPWG7SYA/tO4ssSrDKWo5hDfdBoFyC8/PrPeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:13.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a629e3e-10fe-49bf-e071-08dcf22f4c30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802

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
ID that's available.

For this "different container", add vIOMMU, an additional layer to hold
extra virtualization information:
  _______________________________________________________________________
 |                      iommufd (with vIOMMU)                            |
 |                                                                       |
 |                             [5]                                       |
 |                        _____________                                  |
 |                       |             |                                 |
 |      |----------------|    vIOMMU   |                                 |
 |      |                |             |                                 |
 |      |                |             |                                 |
 |      |      [1]       |             |          [4]             [2]    |
 |      |     ______     |             |     _____________     ________  |
 |      |    |      |    |     [3]     |    |             |   |        | |
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
 - Virtualization of various platforms IDs, e.g. RIDs and others
 - Delivery of paravirtualized invalidation
 - Direct assigned invalidation queues
 - Direct assigned interrupts
 - Non-affiliated event reporting

On a multi-IOMMU system, the vIOMMU object must be instanced to the number
of the physical IOMMUs that are passed to (via devices) a guest VM, while
being able to hold the shareable parent HWPT. Each vIOMMU then just needs
to allocate its own individual ID to tag its own cache:
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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v4
(paring QEMU branch for testing will be provided with the part2 series)

Changelog
v4
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

Nicolin Chen (11):
  iommufd: Move struct iommufd_object to public iommufd header
  iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
  iommufd: Add iommufd_verify_unfinalized_object
  iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
  iommufd: Add domain_alloc_nested op to iommufd_viommu_ops
  iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
  iommufd/selftest: Add refcount to mock_iommu_device
  iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update vIOMMU
  iommu/arm-smmu-v3: Add IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support

 drivers/iommu/iommufd/Makefile                |  5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 26 +++---
 drivers/iommu/iommufd/iommufd_private.h       | 36 ++------
 drivers/iommu/iommufd/iommufd_test.h          |  2 +
 include/linux/iommu.h                         | 14 +++
 include/linux/iommufd.h                       | 89 +++++++++++++++++++
 include/uapi/linux/iommufd.h                  | 56 ++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h | 28 ++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 79 ++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +-
 drivers/iommu/iommufd/driver.c                | 38 ++++++++
 drivers/iommu/iommufd/hw_pagetable.c          | 69 +++++++++++++-
 drivers/iommu/iommufd/main.c                  | 58 ++++++------
 drivers/iommu/iommufd/selftest.c              | 73 +++++++++++++--
 drivers/iommu/iommufd/viommu.c                | 85 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 78 ++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++
 Documentation/userspace-api/iommufd.rst       | 69 +++++++++++++-
 18 files changed, 701 insertions(+), 124 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c
 create mode 100644 drivers/iommu/iommufd/viommu.c

-- 
2.43.0


