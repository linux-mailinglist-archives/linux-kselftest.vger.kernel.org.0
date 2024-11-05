Return-Path: <linux-kselftest+bounces-21470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133779BD67A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FCA1C22870
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB461FF7B4;
	Tue,  5 Nov 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVJOwfWH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AD20E030;
	Tue,  5 Nov 2024 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837097; cv=fail; b=TO1CojijgkxuuVITyaPF/bC/TcMKNINWwWGHjmYCRRlw5L+jCP7l/Sw9xJIHfpp+ROrD9yNAJygkilAwHWONiUIKsCXnpsCDNKMeqIWk+GJ6sz0YKLK15aJ1epKbmIsGGTnUZ6t1bzUVVuhFLRFuGj0+k8p3izq20nCMDfcm9GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837097; c=relaxed/simple;
	bh=aozNjopQdAVKVZBSQwYElUPgBSgD+kAXfb5Gj/h4KUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hLVeOFV+g97pK4FnOQGNmLb61wjEzYQVECep+LKNndDd9PQ+UvHZpNUhs0EPFHlHuVvPJ9Oi9Zw/B9Qixg9GnctTTaO/Oomr4NDOH3fEn7Il1jrZsgml7AJ5YOkB7f/8qItSq8uVpHp1UxDDslQQ8BLlPxk25xxr1auQPDei5A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVJOwfWH; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efcOt1Z8Cev7CrTDCHuHLazBf3EtReG/UPINzWhq8LJbxuOIXmkfbbiIB1kB8Pl3bkWzngf1EqU2HyAAG0dtRcYsecW9p5zhLxczHG2gN+Em/kiNqEOyKYxEq1bZYXN3IX3tM9qX2dfaD8NZhnIVDWyDEOvSoSfl4HuZ0IH6yhh9HXDANJ2bl8uSdIqjGYZbRQx75IC3h0p1zSPMDl1sZVqpT5/SfCFhg2K+J5kurAmjM3Zd540k8aJe4vOOrHpmYFjjy5zGv05zIOIO4CF6LIL5og/GoV6zyXvGE5u0DkvPOJT20JcslIUzqNPODjynfUMI80fNW5nKHxmHdknEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5g8NE0lp38+tyIg9NVVhn5vE1FBYPVmV6ble4GRXo4=;
 b=KQ0Hk78QvyqP0hu3P0Lg1mHbyUnkyy3yspHGoTvLPVqMs7PgARn0CghUjobKE1UxH1bqGw2Fax+bVTkMXMHaouqHrIebY8PmNSRZGt78ZawJgfsSOBxubgragQsKr9gyzqONtPV9AECvZ8awZcSiZW9qwEUUAmPs8FXT5Z9oaKxFd883xabbSQTx19XvNfmLgB5Wv7aGrSc2ipAsPwy6CagHlcOGRYSJ7nzbX9RO3nIzjQhyQbLY5V4hzPukRI6Hwn/A+pti6q4krkotAkGow0Hk+dPZF2J5yt90f3L1RbgJL7NIN9UlbwiJ2LoI2zDIJKJ2UwtnzeB1rreuPYMBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5g8NE0lp38+tyIg9NVVhn5vE1FBYPVmV6ble4GRXo4=;
 b=PVJOwfWHnCdo3/YfggzKirXlC9ZH3ZOEfmrT55bvh6XeTWgBrBR4ojcjG9SGG8vheZGt/iymCyq+TP7OtYMFi3G+bVhrz4p0tKbp+uls6tD+2VwPNlB5G+knNKsK0LXgH0XI5sDugOBBDtcjlwIrDj13V5V67j9Al2XYWOQJtkb12pP7E+Z+rcgW8YwW2H35ocGvoW1y9t79mP0RNAiYwEoBb5dUCBBkymMOz2LYDfgLaZYo6mtL8KPMdUTdt6CPxd4BVJS1AH6zKLVQ3Ll6GQRGtQ+f6CyK4xaQMvwSJh5tBI39UFu84rlLdao4xtRPfxhu6EEYcLDTAlSLMiuBHw==
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:04:51 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::3) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:04:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:37 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:35 -0800
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
Subject: [PATCH v7 00/13] iommufd: Add vIOMMU infrastructure (Part-1)
Date: Tue, 5 Nov 2024 12:04:16 -0800
Message-ID: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: cba53aa5-16f3-41ea-02e4-08dcfdd51bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBevg043Wbk6BoTqe+xt8R45MHvZJh1pIUo2XaFgmMPVHnsVRUvVGKbOcFW5?=
 =?us-ascii?Q?2Dk7noG/DXNjhmmagOjEF5VPX+iieQaYWAvsWKl7JCG/aDu3de9W85XZ8IKi?=
 =?us-ascii?Q?4+OtEvyo5ewS0iPJh3L0QCpicljZxAdq8iKG+P5S+pAR0xQ7Dlq/dvLvSnia?=
 =?us-ascii?Q?oEP3bEVreh5xEmC6R6AhgITnEGrW+qSlTy0aB34hn/xG0oEklPL97wlLY/b8?=
 =?us-ascii?Q?ktl60SRger5C8S2JJAgIFXr8R765tFhHHXPTWYT8af+ZLyPqaEeJ2DTDssHv?=
 =?us-ascii?Q?/EbSfHr5eX2zsu4B8VCyTlQ5kaFVGBXuf7DhVw4gihcqPQcjf6KSGacT2e7v?=
 =?us-ascii?Q?WAIAfKUfX5r68zYDTDUhbGq7F4BkfFUwrDarIgMGc/cJG2G1hfmozI66L2Jt?=
 =?us-ascii?Q?KwWYzicchVtOnFE2T9/XN4QRO1SJN+ETeogX8VqYzJAwbSCzPaSDFLNQ/4Yh?=
 =?us-ascii?Q?i5QoBzANzG/6v1POuUZGoc171FsBQbX6H8+kEfwOan9Ey6NDpeQ8YZXup712?=
 =?us-ascii?Q?8gPGf8Pz/fueC/+yvYqV2TOg8UfarIQvrY4W9ZdEOJo2HKw71Vq26rivB8tn?=
 =?us-ascii?Q?+QDd/RuGdRbm0mgMe7Q23Y5SR70ICIKM9KFfA4Ga+7IU6AyTdFC2ni1p3Mwn?=
 =?us-ascii?Q?v+86v+2sUb3rRUBqbMN/tPjzIANDpPOheniIG6YwC2Y6kWmLhsXJJPVbcn5+?=
 =?us-ascii?Q?7lnUpsuYl/O30dYuk3cTf+uv5yXROAjqBY4bvdiJ/ITPSaIMA1iwymTLJCef?=
 =?us-ascii?Q?UaKax5gq4g/pFeY1f4/m4H0ccUJw2aUsrNrqny5g1AHVrqN7RHicUYiOMto9?=
 =?us-ascii?Q?sLdrOkJPIkmHycBjQte+KkzvDO0Sg26r60dy1smuPXx9HnG+pabie4qQG4Xw?=
 =?us-ascii?Q?7G3nluftxNAJW+5WQtoJ2t9nlgrFq4mG0oj/wSDSn2Sd8NSHKcSjE0KqrzhS?=
 =?us-ascii?Q?mR7X/YU0v340HQMedh6wA/ywj7d25q3LTm1iO4c/Sj2IcZZ+7Du6mmvhQkul?=
 =?us-ascii?Q?tG1R6Mj58bNLWc+Rb3TnvZTFl9M7uzgrsC0Vd7QdzSSA6mcXb/GhlgOm8eaB?=
 =?us-ascii?Q?UFbDEyiceFzK8/62slXmbR7Jdf/EZqNJpJ3EeXfuAaBJba9QCSxQpQbK7bcH?=
 =?us-ascii?Q?V77GHkHKOPLfe3FP4WXMOVPFQDUivl1fvvt96dWiOf2AarLckSDxIRrPd1AR?=
 =?us-ascii?Q?+5FIAiyha1YiosiucculraPwkLShOuWi2g2f7I484oTaWuMcheTjbXW2bpUu?=
 =?us-ascii?Q?LfnZ/ck23jKSHW/rFnDt5ogl5oWX9fN9tLxuImTvCMsX0GzJ5y3y1gZ9kvHo?=
 =?us-ascii?Q?c9kmQxU7y5APuhJZNp3KieexrQokCNvzc/IzQ23ca/CUPSPYKqVkYqDo0Aig?=
 =?us-ascii?Q?duvt++ZFy9F4B8Iz1B8/ctWCC5inG8QID/1yxa96tL8jROfGAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:04:51.2228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba53aa5-16f3-41ea-02e4-08dcfdd51bc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v7
(QEMU branch for testing will be provided in Jason's nesting series)

Changelog
v7
 * Added "Reviewed-by" from Jason
 * Dropped "select IOMMUFD_DRIVER_CORE" in Kconfig
 * Decoupled IOMMUFD_DRIVER from IOMMUFD_DRIVER_CORE
 * Moved vIOMMU negative tests out of FIXTURE_SETUP to a TEST_F
 * Dropped the "flags" check in iommufd_viommu_alloc_hwpt_nested
 * Added the kdoc for "flags" in iommufd_viommu_alloc_hwpt_nested
v6
 https://lore.kernel.org/all/cover.1730313237.git.nicolinc@nvidia.com/
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

 drivers/iommu/iommufd/Kconfig                 |   4 +
 drivers/iommu/iommufd/Makefile                |   4 +-
 drivers/iommu/iommufd/iommufd_private.h       |  33 +--
 drivers/iommu/iommufd/iommufd_test.h          |   2 +
 include/linux/iommu.h                         |  14 +
 include/linux/iommufd.h                       |  86 ++++++
 include/uapi/linux/iommufd.h                  |  54 +++-
 tools/testing/selftests/iommu/iommufd_utils.h |  28 ++
 drivers/iommu/iommufd/driver.c                |  40 +++
 drivers/iommu/iommufd/hw_pagetable.c          |  73 ++++-
 drivers/iommu/iommufd/main.c                  |  54 ++--
 drivers/iommu/iommufd/selftest.c              | 266 +++++++++++++-----
 drivers/iommu/iommufd/viommu.c                |  81 ++++++
 tools/testing/selftests/iommu/iommufd.c       | 137 +++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  11 +
 Documentation/userspace-api/iommufd.rst       |  69 ++++-
 16 files changed, 804 insertions(+), 152 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c
 create mode 100644 drivers/iommu/iommufd/viommu.c


base-commit: 0bcceb1f51c77f6b98a7aab00847ed340bf36e35
-- 
2.43.0


