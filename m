Return-Path: <linux-kselftest+bounces-21162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058869B6F28
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285A91C222D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6C217908;
	Wed, 30 Oct 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmbAYfm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAB1CF287;
	Wed, 30 Oct 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324103; cv=fail; b=I5POxrGomkDvI9xHeahCazUMiUGOaNn1q5DrEjVWo19RaDndsU5P7u0vdsGHoS+Ta478yr5KI/Q5e2x0FhOH89LYrF9A/mNJF8GuuG4Ot/a6bQQo9NYjlUohXNFezp0V3PT32+IXWAbj0jVvm3qMOtwh/PJRj6sfDQiMzWdvjj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324103; c=relaxed/simple;
	bh=GgxP5QZnb+za+GKeZ2WIUS9VmQDQ28qYvU1ozVAN1Es=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVbrNqZQmDstPJWBlmtjD+lBZuoXweOE9jkYSeuS+fsoi+WDFkobwrLWT7Verq1zQjC0XJIJPgbRf7RXk3v/FC5iRI7cS6h+Pw3itbtPVaF+R7q2WwNV4nv+4wBDA4E0RqI4aFi3XWg15liI3cnsuJHr43DbjGLrUlGInykbD1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmbAYfm4; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyZgYeTlbDckYZJGJgUJNT6qahxQTcZL2grcIq+VsxwZvbD5r39FTI/mJENRccpXeQYL9qOpYEZLGtLOk7VXTFEN+WWTyU1pN1pOOf6R70m2aEm3U1E24Rfe8VJePNHBN914QbdOut8QGe1i3yiNHQZDbqHdf20HREZ47JldlcH4aY5U2oqJHSL1gXbxbEJ38Hb1Dz3iLr4RxWlmCkh8ULKhXlnmIPduxbadbw8PWH+NGun8dGwzWKmDS9i+qlnNz6jCcUfAz3P6iUrdajCkRki/BI/Mr+JS2KDSktSqFm31PP2IssUGICUM7nlmkU6FCcbij+5E5laNoAIa+tAoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5mSFMPufLdriZvu+a1U9ZnctavkysWAFNr/G2FucSU=;
 b=eABjpS+BjLv4bmsbh9rhzBJlr5cveLmLFC6UvMH9xrx3Euraw5RyEFh24jr3D6SXn4+CBts/fASgXpkyn2stpWS2UVISeAIO0KDPZ2qF3+86NwqTVohBRICY21/gs+TjdTroWjXHMwmS+aFy6F1SRX3k20/tymCVBujFJ5Vj4I9+mLSKgYpcn3+Ksx72j19iCNhfGfdgpnwz1ro3VTccYiB3ETVhYXy/IzyM7697c0wcR2ffCJP/R4DEhYG1yRL3zhaJZ+6jLYngDVkdOyToH5W92tUwXYgWQb/b8dUAMxzSZD+/h+q5hq3toTlp458wrfDitGtZza8us4/YIdzqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5mSFMPufLdriZvu+a1U9ZnctavkysWAFNr/G2FucSU=;
 b=DmbAYfm4UCB4wJ0WFeRb1UXFN1nY9sjgl47jl12lUUeZDc7scGuq6dUx/fHVBsYP7pG/joAbq4YORNZuXlGjXaEyrmOFkgNi8lfzshRfyxlAN5lzxewFkKHJdKN+ugJ6JDYkJMxzSSxG5bPZnw4Xe6KwjwnDtzOVPcX5EgGd4zZFf2ejBCUvRXJ2ggENQmD3rZl6QbmQWiDm/aeRS1TzPDiD+VGjGaTfS4giSoV7Z0Rav02YA7GukJH1kZ1To3ElxmUbWpAj0/QHEIluM3DyKatdSdFVSij0JySPkPoRotRDSY9b0+vcXiICS9FMtNEAAlaA4wUf4TKyoJW2qVn9Lg==
Received: from SN7PR04CA0115.namprd04.prod.outlook.com (2603:10b6:806:122::30)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:34:57 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::b2) by SN7PR04CA0115.outlook.office365.com
 (2603:10b6:806:122::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Wed, 30 Oct 2024 21:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:34:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:34:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:34:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:34:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 00/13] iommufd: Add vIOMMU infrastructure (Part-1)
Date: Wed, 30 Oct 2024 14:34:26 -0700
Message-ID: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f2fff6-8e72-4d87-bf5b-08dcf92ab343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jKzd1KS0Iev/Rb/pZwigdbVHjliZTIkWsyGE05JCDUMw6mJA2wZrBXt+gtCC?=
 =?us-ascii?Q?HsYibbUAKo46vuHuNXVOCQ9yhZFwI4O7H3v8BfSiy6ZyUYswPmGE7TkHzWu9?=
 =?us-ascii?Q?F5D/3UZmxNpX0kOKKKEct0S0iXk5Pk3aRXxEjrjD+OnEen3DI/fg6+Llozac?=
 =?us-ascii?Q?d7QLyB2UMPyDb8F/idwwG1v1PnsAibsJ477odBi1pzVgo8QBNJ/x0TQXkIjy?=
 =?us-ascii?Q?6tPDXMhzICMWVK2/0bzoT1T7rtqI19MhYClTITiKY4Aj69GjP1CEModQ6Dyb?=
 =?us-ascii?Q?DoH7cI+FQGd3r2+hbuZ17pxaMrGkGqh78iZvQP/ERvfmoeBYJsTZKOwueG7g?=
 =?us-ascii?Q?ZWeQ8sVIDHDWfAjFlC4O0yUUdvTZ5KYffvBXqxnfMaC4nFILS5h8aP6T5K1i?=
 =?us-ascii?Q?tWh2Gy/8HiJMN5u3d9fUHrJ8q5IYQuRZKCU+IXeq73Kn0mIeU+dwPWaxKy5A?=
 =?us-ascii?Q?g7E7H8JLY8zhcGMZywTDcJOLJ635AeSzVeA7lCHMwNsq7I8lZ5YoBvOEdvm9?=
 =?us-ascii?Q?0Hjlm0YYiLcE6UErfliPWWKbhfWWr+IzG2692tOQ/MVfQIG/74nq+FMOBBjz?=
 =?us-ascii?Q?42j5gRrJj8dmdBmO0LU9FAXidUO/MvB5+2Qsit5Ox47/HWjFPiXWMEmoXZOf?=
 =?us-ascii?Q?svnOfp86GxeE/3u/ra6/mpH/HtUC7VqtpIDjj1v0tLDV13Xu4T6srKfMiNcc?=
 =?us-ascii?Q?ARZ5cRKdtwM2YSamlRZKqTMF5a4Oo5BnQ6BePwgRsLxDeZzBgw7Ud4tUMeye?=
 =?us-ascii?Q?VfCdV0UxJJMLQDoFWAkbZrfNCtZEvizpkurzuBqKI4FMC67etje/sfrQPOoN?=
 =?us-ascii?Q?sPUAjGBniXP42IbBN9R1Hx/X3v4mPv91GbAhmO1NywmXmymhq0haIHoWtESv?=
 =?us-ascii?Q?fyJHsDDKaFcjMFxtk7cM5HoS1kmZqCufN09E2dwAbxZVmaeTe7PkiWozsSCD?=
 =?us-ascii?Q?/y1m0JwKiAqgcDzQElaj45riA7D8uEHovKHnh6oHrl0fkfapTOGQ7ZDe9sYC?=
 =?us-ascii?Q?usHy8mxLSrWjsJB/PiSlnLP7mgzM7xA5mUtT6qyhx73RByMJwUuNbEuGi5An?=
 =?us-ascii?Q?HiUViChAH3ZDgOHfA5YuBaDmRpvx2tKa0eW1Fn/72W6NR2mVqSlklGcibb9X?=
 =?us-ascii?Q?UuR6eHwp2mxGaTBsnayomMjPR20L+uSKblWEBF8Do80BQXuIKbu5FVbb3KKH?=
 =?us-ascii?Q?gwwMHzB9F2UTNR1EA5Ba6ZM4T4eIbmI2xOW2wXDtHCDc28WW0oRc9BCLVV6u?=
 =?us-ascii?Q?mbjPAzCEN6oohb8dlCIERbx99y1jIQpi+U3PHqsbWK8M9jtzoYS4tL5wpijl?=
 =?us-ascii?Q?fHwxbe9RMvYbqU5v6ZNgd0/hth7ZoqvLk24tCQvChlFOJP+FWU/6IoW2Hogb?=
 =?us-ascii?Q?muJmsQlAXEvjS0Z57n6TkH3ZxNsi5dG7IedhOBjnEt0ZpwTdaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:57.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f2fff6-8e72-4d87-bf5b-08dcf92ab343
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

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
 - Non-device-affiliated event reporting, e.g. invalidation queue errors
 - Access to a sharable nesting parent pagetable across physical IOMMUs
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
only.

More vIOMMU-based structs and ioctls will be introduced in the follow-up
series to support vDEVICE, vIRQ (vEVENT) and vQUEUE objects. Although we
repurposed the vIOMMU object from an earlier RFC, just for a referece:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

This series is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v6
(QEMU branch for testing will be provided in Jason's nesting series)

Changelog
v6
 * Improved comment lines
 * Added a TEST_F for IO page fault
 * Fixed indentations in iommufd.rst
 * Revised kdoc of the viommu_alloc op
 * Added "Reviewed-by" from Kevin and Jason
 * Passed in "flags" to ->alloc_domain_nested
 * Renamed "free" op to "destroy" in viommu_ops
 * Skipped SMMUv3 driver changes (to post in a separate series)
 * Fixed "flags" validation in iommufd_viommu_alloc_hwpt_nested
 * Added CONFIG_IOMMUFD_DRIVER_CORE for sharing between iommufd
   core and IOMMU dirvers
 * Replaced iommufd_verify_unfinalized_object with xa_cmpxchg in
   iommufd_object_finalize/abort functions
v5
 https://lore.kernel.org/all/cover.1729897352.git.nicolinc@nvidia.com/
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
  iommufd: Move _iommufd_object_alloc helper to a sharable file
  iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
  iommufd: Verify object in iommufd_object_finalize/abort()
  iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
  iommufd: Add alloc_domain_nested op to iommufd_viommu_ops
  iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
  iommufd/selftest: Add container_of helpers
  iommufd/selftest: Prepare for mock_viommu_alloc_domain_nested()
  iommufd/selftest: Add refcount to mock_iommu_device
  iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  Documentation: userspace-api: iommufd: Update vIOMMU

 drivers/iommu/iommufd/Kconfig                 |   5 +
 drivers/iommu/iommufd/Makefile                |   8 +-
 drivers/iommu/iommufd/iommufd_private.h       |  33 +--
 drivers/iommu/iommufd/iommufd_test.h          |   2 +
 include/linux/iommu.h                         |  14 +
 include/linux/iommufd.h                       |  83 ++++++
 include/uapi/linux/iommufd.h                  |  54 +++-
 tools/testing/selftests/iommu/iommufd_utils.h |  28 ++
 drivers/iommu/iommufd/driver.c                |  40 +++
 drivers/iommu/iommufd/hw_pagetable.c          |  72 ++++-
 drivers/iommu/iommufd/main.c                  |  54 ++--
 drivers/iommu/iommufd/selftest.c              | 266 +++++++++++++-----
 drivers/iommu/iommufd/viommu.c                |  81 ++++++
 tools/testing/selftests/iommu/iommufd.c       | 128 +++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  11 +
 Documentation/userspace-api/iommufd.rst       |  69 ++++-
 16 files changed, 795 insertions(+), 153 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c
 create mode 100644 drivers/iommu/iommufd/viommu.c

-- 
2.43.0


