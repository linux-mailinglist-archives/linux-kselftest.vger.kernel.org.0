Return-Path: <linux-kselftest+bounces-19361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E79971E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0A72823CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5F1A0BFF;
	Wed,  9 Oct 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTX4Jg95"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F619ABAA;
	Wed,  9 Oct 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491937; cv=fail; b=AbCem4lr4tb371rDh1/PtTukjdxhW/X4CiTIdeCqeRYxSlf3LCLd5J3noaqV9TPpGDRQiJStSXsciWyJeQg3XK5PLdBQoIIeviUej4jVrn0i/l0oqXd6KIixiUK5E5aOT/htANXipFG9vKs2r4inBcNQ55kl7eRk/tnhTblkFOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491937; c=relaxed/simple;
	bh=UvWI0394vooWvsUuZplY8uwr+HULWKWcJWGyAwm0vKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=taq5tPG87RaV1zozOQmBNJaP8IHq3189DqCUsLSWh/x1Tahq4kkzqIAOf5ZXJR0kWkRAZrv+QPjiv5FbEY/M/EVvK3XIwAtnRWK2KzB+jHtCXj0ez+AGZvn8gOxuhqUMCqN43xK86JQi7vZjNh+TuDUL77hz9xRj24FotQQq4cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LTX4Jg95; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC/qEfta8N4ufRmSpuUix0taH6fG9KZPE0U9L4NmngSXwfHpPH/fhJYygmQqNPbTMrIuLBdMpMo31OPWRlmylKMRAFw2y4lpkE9/fjyfU8LEPADElXZQuHGUXJPeoyeGHcD8nN5EvVoBvMomXmaiexe7z9Dp3T9dbvkp4V6wU0ivjgL0lEPPLo3Sp33BYFcM37RlrEA2Kf4Ft7tdUAGgl1/FTjvxCdjHKW9YfBxQUSvs+33eBOhYfqHtDwyWOgrnEgZd6AZ1MsuuZDl2d455BMQDwXAG+MZiCtROLUoa7noO8cJDFnv1OIDLyh/E953lEur5t7kgPPaQM3vTQ/F1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGJ4V8UYgbzKd3l4LMALl5R2XXSuLLVzJ4inHJnX19s=;
 b=GmwHvG7Hp3s7VkZvMVoKJjwwf5YaiVl8bjdU7SRMGKXZJcgJu/yV23KEnsjFjhjo4soT8qfMbXWHM1tvvUDflJm/ERm5KJqxk0UgMRxErHs19Jb9JM+IZQgKIeamDw678cdPK9tfmfthlLWd6KOlvLvBx7j4jliDXkzGLFZI0bASuWsdQk/uOaPl9oqMJoFTOtFTjkldY8EIES/ZANHMSLSVqfZ5RNYGyC0ZTojOApyp/v0HReXoIwZpUg3kNINCQf0A9ocpqT/ZiQ1ZP1lw7V1Hm2kJMoAkJwJ37Q9xwfeslYXdsA1LWoS6BsBQwUdvrxDkVw/Pa8DqTgcA7NsUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGJ4V8UYgbzKd3l4LMALl5R2XXSuLLVzJ4inHJnX19s=;
 b=LTX4Jg957nvuQcbHo+l8kZfiqiunXLLda58YvgMK5+VdjpPy81AKbSD9tFY53OyBQEYr64x6Pa/7AdUFcN4TCGuCbvMslS5Ef+TMJTr8IxmzOl0yUH5Q1pAeb6CSqW0VZGuv/Qj4YJp7lvpUcd/pcL51FsNgHnB7R66XiRK6ahqmYya1pcwP2CqTcpVQfvnEbP70t1u7R9ibI96j4g14w1SEkBfcSjJiUJuU332mnSr83UAv/EDMgDFcTnIZJ5jJzvVWvb/q45cdhDpTxLNVyYabPmJ9l+kpJdq46kO9yFamWb1O3TflcSB3sgPRIdy15xWMHySSushTx6T+/RY8JQ==
Received: from SN6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:805:66::40)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:38:47 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::de) by SN6PR08CA0027.outlook.office365.com
 (2603:10b6:805:66::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 00/11] cover-letter: iommufd: Add vIOMMU infrastructure (Part-1)
Date: Wed, 9 Oct 2024 09:38:00 -0700
Message-ID: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: dfed2bdc-5743-4bc8-5782-08dce880d8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mK1nzOtfaw1G0tJU+ikeYO2gy1AtZyn/tDDBURIoHBXtFs6uC6gbOyRsUzJf?=
 =?us-ascii?Q?AcpyMlHKfRyIJEhgpb18K9fiwRENGfKfJRwOdZJ0HOUGCW/NH1+cizse04Z8?=
 =?us-ascii?Q?ZkD5RSn6j0CvRlKdyH14vD0a5ER0M2Jenpyv+Xdaw+/+sHTqPiLbj0QCOtUE?=
 =?us-ascii?Q?I0ubIcaLxTnwnsBHEgCQA0WOLpxMjP6a+8LJ2IAe3IoeqS1OSAfb38Rad111?=
 =?us-ascii?Q?9pw5p1NaswM9eDMeeF+YNtSTq1gL5AllQolq1/FJ2EhPQBVTA8liIEnTvw97?=
 =?us-ascii?Q?su+CA5BaBu7JJvQusXb5aeQszz2g0YEQP4+FA6Whqf0evozhCYzWOQZCmyCz?=
 =?us-ascii?Q?Et3k96NNls0HEQi7obXpq4hQCRCR0uNSbJ/vxxETHZ93lxeR8WkCKoDE7dIk?=
 =?us-ascii?Q?ay8qIgLwK/OLaznlwK874NCLPVPsGLUzs+qqy5RrVtX2dCkN8bvH7DriQOC9?=
 =?us-ascii?Q?IEV1j2jxo0E8mmPUoxfJhhGwb1OUSlEPDFDdP7W3riA3Jozesej+gAx6EBQy?=
 =?us-ascii?Q?HiO2FCzK11UXrIkVxwIoG76X79IoaYSDdINvGVVamSK8baIAxEviD+XmPseo?=
 =?us-ascii?Q?eW0WDiVzP7L01qE33rp3YgrJLgzo+E2h0XRwM83zyPkiQp8IdtFNNYmsa75u?=
 =?us-ascii?Q?hCxtDE0RCtPuz1dmrOKNMr91gAuNxoPrgAjhcHw0EBuCYm8dzQ4gtUz1Qk+Z?=
 =?us-ascii?Q?6152kMz2pNk0QD1TSJRjJpb1VcDdU4J5sDu5/1PtPeMsbfLy3PLy6z9Smraa?=
 =?us-ascii?Q?igKXpfPnhOlaJusEA/gAODe3Z75RizL3o+nsS5aFuIh+vcJZlBuvumBNFmki?=
 =?us-ascii?Q?orLRcUkcf7eNxafJAcFSMPfGPRLzElihkOQo8YIIbAby8Zl9gggrR+OcYo0u?=
 =?us-ascii?Q?Py8fH+kwkJjN/LOHEIB7SvRngXdSduvcYBxJEzGMEIb0bXT9IIiex3EMD3zh?=
 =?us-ascii?Q?qLclfRzjimUzYNb78qwN+RiG6OzPqshw/QmhK5lG0cgFLOakWq46Gxf+YQzU?=
 =?us-ascii?Q?k/mxOyDXQEAHzlHqMZYBR0lHQHGmA3lYQLihn91C21A3BET+oSw7ZIljBr5S?=
 =?us-ascii?Q?fY/FVEcR48G3iRSevokOmsJqBG1h4jxNPJMnDc9sizhJ+2SUQT3UU0ZLI2Ge?=
 =?us-ascii?Q?ueVDgHjqJJXshoHlsw1EK/LbfKX08uw3x2AHHxmeMrczXoPoH87JseV4RP2p?=
 =?us-ascii?Q?Dr9DVSZEkJ9KY+YtftWEjSsg8IYqquX7rBov5T21TsVjUIW+i2Q7jaBF/SYU?=
 =?us-ascii?Q?hcYeLqtvFHyftIQBg5UAXCodNEpVa86y7SbEvvByit3KT6sS1oi0sm/uFSXp?=
 =?us-ascii?Q?jLNodE/CO4rMwKaksnzQP5iNAkCItMXMaXBllyCOBlwMUGJLgJXI27WgNw83?=
 =?us-ascii?Q?iuZGG2gajgeqr698P6SZbdGrFGgd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:46.9089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed2bdc-5743-4bc8-5782-08dce880d8cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

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
 |        [1]            |    vIOMMU   |          [4]             [2]    |
 |  ________________     |             |     _____________     ________  |
 | |                |    |     [3]     |    |             |   |        | |
 | |      IOAS      |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
 | |________________|    |_____________|    |_____________|   |________| |
 |         |                    |                  |               |     |
 |_________|____________________|__________________|_______________|_____|
           |                    |                  |               |
           |              ______v_____       ______v_____       ___v__
           | PFN storage |  (paging)  |     |  (nested)  |     |struct|
           |------------>|iommu_domain|<----|iommu_domain|<----|device|
                         |____________|     |____________|     |______|

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
only. Later series will add more data structures and their ioctls.

As for the implementation of the series, add an IOMMU_VIOMMU_TYPE_DEFAULT
type for a core-allocated-core-managed vIOMMU object, allowing drivers to
simply hook a default viommu ops for viommu-based invalidation alone. And
add support for driver-specific type of vIOMMU allocation, and implement
that in the ARM SMMUv3 driver for a real world use case.

More vIOMMU-based structs and ioctls will be introduced in the follow-up
series to support vDEVICE, vIRQ (vEVENT) and VQUEUE objects. Although we
repurposed the vIOMMU object from an earlier RFC, just for a referece:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

This series is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v3
(paring QEMU branch for testing will be provided with the part2 series)

Changelog
v3
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
  iommufd: Rename _iommufd_object_alloc to iommufd_object_alloc_elm
  iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
  iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
  iommu: Pass in a viommu pointer to domain_alloc_user op
  iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
  iommufd/selftest: Add refcount to mock_iommu_device
  iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update vIOMMU
  iommu/arm-smmu-v3: Add IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support

 drivers/iommu/iommufd/Makefile                |  5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++++
 drivers/iommu/iommufd/iommufd_private.h       | 23 ++---
 drivers/iommu/iommufd/iommufd_test.h          |  2 +
 include/linux/iommu.h                         | 15 +++
 include/linux/iommufd.h                       | 52 +++++++++++
 include/uapi/linux/iommufd.h                  | 54 +++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h | 28 ++++++
 drivers/iommu/amd/iommu.c                     |  1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  2 +
 drivers/iommu/intel/iommu.c                   |  1 +
 drivers/iommu/iommufd/hw_pagetable.c          | 27 +++++-
 drivers/iommu/iommufd/main.c                  | 38 ++------
 drivers/iommu/iommufd/selftest.c              | 79 ++++++++++++++--
 drivers/iommu/iommufd/viommu.c                | 91 +++++++++++++++++++
 drivers/iommu/iommufd/viommu_api.c            | 57 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 84 +++++++++++++++++
 Documentation/userspace-api/iommufd.rst       | 66 +++++++++++++-
 19 files changed, 602 insertions(+), 65 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c
 create mode 100644 drivers/iommu/iommufd/viommu_api.c

-- 
2.43.0


