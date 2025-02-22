Return-Path: <linux-kselftest+bounces-27272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2EA409A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A3B3AEAC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB220AF63;
	Sat, 22 Feb 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsiYooea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A6207DFB;
	Sat, 22 Feb 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239692; cv=fail; b=cAv5alkhZ9JXqQZW0syQWVaY4Lh4jNElwzpPo1IfCd4lu4YH51K2EWXycIv0MIrsLXx6MBFEAMagGrU8+OsoSb99VhY14o3es8ZQ4ColBSMncmMaChOi+1nASNQBIESpsq9wzYGDD1C7/mdc0A5/VmjVInM6DY9ea5xCxGQ0OQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239692; c=relaxed/simple;
	bh=2Q+la1Vr7KdS12V/vYxQZgWA60+Htge+0ih7MtG1OTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMSN7q+FmlXsE4xC8fshS3wVEM8ShZ0KxFt+LZCGOoEuW+iz9eIv7QCVv7SxTnweB1hC2LVwQrkUQfeZQXbNTmLpNbho0S/jHqLt+QowWkiEbzJzWxrYneFQo42EyvT1YAO8S53F8pS6/nwx1NPXZSNAZHLQ4793DU9919Lp0n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsiYooea; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlWNzZwufwfHY/y7NLECJ3FHIEWtcZXbPZKx6qyBsWHvVjqiFyDRKjybAjg+4WL4EoJD/+b4/733WtTBR5w1I/9pt534JhZvnQMxl7GZnu53Dxc+Cz3eWMrJ7Cm7d/1SZJmTLjL6ZlqIWZDElPpqaJlSXuvCwuSredAariiRgRsiQ4NVfVGd9A3drpJT0rmsffYIb2MloI47sZpBH42vsv6rOvycLrl4Yon6WtfF5EAZ41TZGEP0wJ9n0fHQKaoyVT+07UOYSyHjDj5ERWYyPlTY5DXt0Q178WEa2Ma6FIVvwm/6ivhOEnfbKep7qMaUDDNiSnLkvzH0eEh/ciaLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NYHNYHk4Eskt64jA06hjjLb7nD8fIqO7zbe3QJ7OYY=;
 b=sG4y+QQVAipEjPvzu15zWrV6QUYIJkfglLVRth4flAtn1Z3/y2Z+TJjWXhwa2iUxXQLgvSkF+iBlbvilyfcTuntyIrHtT5XBtoieGT6gv4CYawQjlXJLxihhgr8L1ZvY3IVSrPTjnFaeeaD00QMhQSC+SN7glKccBP7ApNWl/IkQ9FCdIQ96ibr0z2NefoS4d17X/udYK9C3c73QxHKcdED9d0Fcvjd9mv1zbsDy8KyZhl0rVgwAkhqrX5J4I1mUhdIlS2BkpcQAVz0iKojDvm1ZZ/CkTs2JknzV3NhoRbPCjQhp1t3DWd4BAhkBTBNbcAID4xW2F0zMeXqs6Ubz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NYHNYHk4Eskt64jA06hjjLb7nD8fIqO7zbe3QJ7OYY=;
 b=JsiYooeahFcupWKMU/WDEBGgPOIVSw35IMrzpubmkV0Bi2sfmLNQhvpLXWxVl6Ey5BrwHbyqx28z5Earr6FX2u2NV3dnYk5UAAv/l1cAFXSPNuCPw5PW2+HyeSySPL+gfu0QQLO0JWMt/6Ma09c43bh88zk+cuz3OwcFk2dgEEPaYVeCClG4G5V/EmeAyHh7ixuxJ+vIoQMu2MmOyTxiRgdupXQFnk/dOPvaO63A5uBeejAs8K0vurBrdzOCIYxRrsbRFOH9/sOEQRPMTKibiHT3GZnknXVExIbvCM+LY6cTKKuUgHLLz8NAXh/3kLZ+mUDbsJaYxNDGUfZ8MZSR+Q==
Received: from DM6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:5:1b3::24)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:42 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::16) by DM6PR17CA0011.outlook.office365.com
 (2603:10b6:5:1b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 15:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:33 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:31 -0800
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
Subject: [PATCH v7 11/14] Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
Date: Sat, 22 Feb 2025 07:54:08 -0800
Message-ID: <ef93cc6c6ccf876afdec43aefc1dbfb0e03e8ec1.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c72a2b-ffab-430c-bc98-08dd535938c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WACB6bGbm+NVljmJfWACJrWFCHTxhkuw1gXWPrURlJi5tCG6FTpYwc/7jQO?=
 =?us-ascii?Q?o9wpsiyW2vXN+e/1+a9XxjQDhEDWa7fA7gygsfxldVUrQzLhq9S6eJX++bf0?=
 =?us-ascii?Q?vAny3oGMwIbaB8520IxqPtio/xKob5XgQN7xfYIwNiOMkZNTsK/kIaC1JvLh?=
 =?us-ascii?Q?TQp/BsFR6gNVWv4FDtO8MWsmaQbYqCFKD6owcva8q3u2UV+5PGBGzLRkvq60?=
 =?us-ascii?Q?eqWgBTjkFN06IHJ/QsB+QaUJFoHdpNpPnkq8cDQhna+sRgwUAcrX93XjuIkz?=
 =?us-ascii?Q?nkapw0K89LbErnXTPxo1TOg5e49z0TXFQAKgidExfVbbU7M5mZuDJhcKErPS?=
 =?us-ascii?Q?eVW0WSkvkJ5IYwgvWClU4smDYzkFEd9giJlYUGXNODxjGMR83BzDoTHqdU9x?=
 =?us-ascii?Q?ih+b2lS5TWULGd7EAAJliV/cFjYNiMFu/r8cv0XRGah//zThW1SmwfGnrn4T?=
 =?us-ascii?Q?90D3QU/hkjt1gUtVimSEGKt7WPKA2SWoR/anxK+9dnXBpO1IJRs+9aWzlGQZ?=
 =?us-ascii?Q?KYkxcGo+gRDavTVHgqYgefkGTJoMIt6sBo+pRxbuT5v9zxhOtk/+Dg1rRKU2?=
 =?us-ascii?Q?8ty8LTqe3czfMDOEjiMzu8VusPaqHIjzh6An6EJJOXtT07erbgnbCvRetnhD?=
 =?us-ascii?Q?61e6XowdaIP8JXacr7FH1usd+J/M6Tj6FSFPZIX1r4NCcyB7QIzwCYo4HK7/?=
 =?us-ascii?Q?Rzwy1KyVzu2CL4xcb6QPnXn0taaKJNU9b0fhrk/KUCP5dDZT5q0ObQHjnYzU?=
 =?us-ascii?Q?bmPJJA3ReYsuRjF+5o9Ld9qCRcrnODEvah85kk2XVsm2QSO7E0V2/KGyZRpr?=
 =?us-ascii?Q?9U0IKZNw4Fqp05lAzs4EUklqK65RwBaNyxPr9YGskNb+lHUqWwX37lDxaaPy?=
 =?us-ascii?Q?Suzs4YQocRlB8v+/nLAgAvG27bIqVwB4JN9pNJ3R9+dYfR5wTU7h7q0Dy5nC?=
 =?us-ascii?Q?wfdTIsGnbNpIaM3XPmNHZwuSIJFzvE1N46/BJBYGgI4363rBAa4yboadY5tj?=
 =?us-ascii?Q?gOWuQ+4Fl153gpd9wVyRbPAwKEvQTII6zNwIvSx1aLSjhtUkqot9q71nc54g?=
 =?us-ascii?Q?za78HSxLEK4lPTo4Sb+VYX4x3B6T/et2DSNEPaW/q98LNVCIhv1Fb4ddrYUa?=
 =?us-ascii?Q?YCJwa83LUx1wesu7JEzCNV0PSVy9is3fTYEtUls1SZg2AwsshRm9y0RpnNKr?=
 =?us-ascii?Q?ufNenkytDIHiB6Gb52Kf8m5Qk1Xy6e1JlAoDlwWyNLKY8MKsF9+jauv+wqae?=
 =?us-ascii?Q?RLqs3gUTtHS9XK4v60Eny6nQe7Bq/o0BYiBAWmBjfj7AtWoTDTqhEnnS5QJ3?=
 =?us-ascii?Q?Vky9Th8Lm4QHOaJH/pekjXK6YSGKZGCZSzEGIpO/vpY2GdU/Qzxizn+XanuS?=
 =?us-ascii?Q?iGAHYCx3nqL0rwleYilE2brCIqvS90E0R16jCGz9gSEP58fZMzX82YjoWSFx?=
 =?us-ascii?Q?iQtdxLmwLxvTvOpT9lTXTCJBftSBKQ8uI9JaLWf0k26C7/EHaKYQjy/oVIxZ?=
 =?us-ascii?Q?0wcbqktGDvEPmkE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:42.4790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c72a2b-ffab-430c-bc98-08dd535938c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563

With the introduction of the new objects, update the doc to reflect that.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..b0df15865dec 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,13 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+- IOMMUFD_FAULT, representing a software queue for an HWPT reporting IO page
+  faults using the IOMMU HW's PRI (Page Request Interface). This queue object
+  provides user space an FD to poll the page fault events and also to respond
+  to those events. A FAULT object must be created first to get a fault_id that
+  could be then used to allocate a fault-enabled HWPT via the IOMMU_HWPT_ALLOC
+  command by setting the IOMMU_HWPT_FAULT_ID_VALID bit in its flags field.
+
 - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
   passed to or shared with a VM. It may be some HW-accelerated virtualization
   features and some SW resources used by the VM. For examples:
@@ -109,6 +116,14 @@ Following IOMMUFD objects are exposed to userspace:
   vIOMMU, which is a separate ioctl call from attaching the same device to an
   HWPT_PAGING that the vIOMMU holds.
 
+- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to report its
+  events such as translation faults occurred to a nested stage-1 (excluding I/O
+  page faults that should go through IOMMUFD_OBJ_FAULT) and HW-specific events.
+  This queue object provides user space an FD to poll/read the vIOMMU events. A
+  vIOMMU object must be created first to get its viommu_id, which could be then
+  used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
+  but is confined to one vEVENTQ per vEVENTQ type.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -251,8 +266,10 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_fault for IOMMUFD_OBJ_FAULT.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
+- iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


