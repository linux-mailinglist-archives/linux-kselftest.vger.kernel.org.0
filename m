Return-Path: <linux-kselftest+bounces-20344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B19A94B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C71F239C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71E13D50C;
	Tue, 22 Oct 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tkkg9mwd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753D1BDE6;
	Tue, 22 Oct 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556437; cv=fail; b=J7WkJe/tUQjjOPeuZUMm3U0AoQsqmaZJ6s+GpO3mcUj5sWcg3Kex8kBRy42CyLBZLDS1u2h+dOsdpDByG3jTNTTvyR8tJbH0s0g7+PmzgEsc7Dh/MHUD9/YyZcIAshJGZccDz2R3yVKYde8/GO8CHui+O6+LQJb6JrNueTq97P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556437; c=relaxed/simple;
	bh=bAHQMRu8mLYF9KBY0J9JT4A9MMilnR3viW+FyxgkGlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaaoP1vkJ2XJs7mgaSXy/wKXMzgPzJO/baF1UuAJWBVtZESCcb1xuTv8FW9Y5GzBtpciP/90ymP/F0uG5k94tc6N5A9jImIuJJ4XoEY2+XeRjV4IH6fQdRsZycVaXlKGpNTdencN8yWt0ZgC/nGof6eEoFHZmE6EsdPTY+yeMZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tkkg9mwd; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbR8x8RUAxCKXB6yLESvAfldG3pV+O9vq9xklBsJuKA5W8wL15ugMZDNZzoGmGZ4aIdjGoqedgT1v/tpxIvVBvbRi88ARygVDjdmXVe1c0zvF/OG/T+hSMfL62y4S090ASLnvTi8uukL2flRRhlW9nR8xJxKwtyQrAYVpE/fKsNBHLu1274Skzu85JzPZKWPs1ayHH4fv9r8A+9u9OlsFay2p9qXuAh3Y9oQqcc3ljpRdPFPe8ktPGSj30wqwLp8MijdPjAG9hvLEI3wPfemkm6WUK3X5HFNQ62FyCjbV7TJR+0gFeLHBE9hy26JpNv8E8SDITyRHVJ4AXaIltK/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HZwjpIcQWA45svpjL3PR/AIV9ID24JUqVTbg8hBq6A=;
 b=KL7uu4tyC/OBy8LO4odQnQIQIN+tq1BxZmDdVpYt42llJPWAjASH8/W6O+tgeMuYDnJHE034UZVhmnobNk7kEFAEtqc29YTyK2QiIslmnZvbt9FJGf7X0RDq+Z9HzSLnyeq6xyFLWHAGtSTMftG7B+c8gwPmxMno7EzjF9mNC4UEM7C9pzSUbCVSe4z4KOu6pNIE3XTJVB88Mo5zfCLY8xszUtc61sURakFYZZ7BcZtV0/kbuLAhgxIPKUd2i6yG6yo6SPB4qoVlKWEkh9U8iktHlPlrtN6lJGNyOP6R83rjq7ft+WrGg0j5LQz5jx8ogdPMNabEdBp/X+yYOUKENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HZwjpIcQWA45svpjL3PR/AIV9ID24JUqVTbg8hBq6A=;
 b=tkkg9mwd/1b12qblthkVpwqkrF7NRvDS9mSZlb3R7o21ZCXhBmhGrusJsc1jMmdTfmBWINqJR9n7OBHyOahFAbWfTCBqY1VSxRGOWXP1GggbZRPko3vLJFJ8vFNx6P9zTP8XnFv+Us8gyeR+WbZ1ZPe298KGWaC4QNLNGwIl2vo32/FdCy8MaYR+I9Re99ZevSm8WLUSm/WWLbup5ZHj92FgfgMQ5lbcA3I/OIy9Fbq3qFG8UHeHgNqimXCYHmjigYJyGHI2iW/oLT7pK9cN9VT65uUHQwe/IW0LypSh9t/0EQa202Sx0uHwVlpkpvc0LtkU7hA7EGbI93eJX+N8bw==
Received: from CH0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:b0::20)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 22 Oct
 2024 00:20:31 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::4f) by CH0PR03CA0015.outlook.office365.com
 (2603:10b6:610:b0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:13 -0700
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
Subject: [PATCH v4 10/11] Documentation: userspace-api: iommufd: Update vIOMMU
Date: Mon, 21 Oct 2024 17:19:32 -0700
Message-ID: <97fa87a511f0132ee0e233cadf09af075e4404c5.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5753aaa6-d689-456a-1dd8-08dcf22f56d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXaZzaMFAshM9D7x+YzPaXSHkWzmgl8lr4CU9YenGgd77eYoZmx8n2YsdBIA?=
 =?us-ascii?Q?CtpC39j5U0Yfgaq7pm4db6X85UmxyLfiTkd895cvAs3iJ/AcCLrtMzgeKubV?=
 =?us-ascii?Q?yiQKA5vsjgkNITYexHVbEK/gsz0TfGiJOFkS1japfTjTVe7fW0C2mlG2Nmik?=
 =?us-ascii?Q?8vI4ZOYksSVf0FC3UWJ4ERbSjwpew4xeiXHP908fz8IRq+LI2sbEA4ifLCFt?=
 =?us-ascii?Q?5yvwBiSA05RAjetAsYMJJedxOQc+3+44TxJpio5PIv96rQLMf/TnAcJ7fAI2?=
 =?us-ascii?Q?5Dw+rL0isY88uQUSTxLG1NwBqUAlxdwNILjoOlDuOB3GibIPkSiHiGEqV/FJ?=
 =?us-ascii?Q?YBPYpOZoJIW8tdfdDhYP6HG5pcLYnh4h2CzCGROJasJAY3dorBX23dCxgquj?=
 =?us-ascii?Q?7ScdgnUflCefwskPBf+RS5+1oYBpsrNtoprlTiKNHLqM4JjVVOqscyW4ZnEN?=
 =?us-ascii?Q?YSEjJrUhgko41TLZgmoBHfMAvvqAxMJuNBNjCePEsa/O3pG/V7egL2RxyjMp?=
 =?us-ascii?Q?tuzld4Jf+wFFIWhzqOPYCVUqwdRjx6LH0Zs9uPCdl38PS452IwTM8CFkFzlj?=
 =?us-ascii?Q?nWQlgY4R2yU6UzuRbh+6Ira/bgQXal6HVhH2IeGKS2ONe6w9xLLKg02wFyu1?=
 =?us-ascii?Q?1//YEubh17C6VyVz16YrGlgAycbNtjWIurlxG5Pm9NOvq2kCPSbDTAk3DDnP?=
 =?us-ascii?Q?083A0oc26tjXkAVspWPfBb4Qebu31uS/SDwdV41FtMW+q160YScBxas0XaAQ?=
 =?us-ascii?Q?8AgYHbNeJVvFINGwGYvIPj1La47smcE+DOY2AsIhTIzbO34oiydrPnfT+z5l?=
 =?us-ascii?Q?JeRNQbUKQHgjUrIwO94pmZfMMxs7wIkAGx5rjvaIVQNVF5xcP5G2UI66p7L5?=
 =?us-ascii?Q?M4mn/SRr5vX7CCzLH5KKILkPqb4VzzI7icO6zQ0w5wqK79LOUSc1p8fDD9iC?=
 =?us-ascii?Q?nZTzfzp5n9M4MXjIYVa1A7nmIMKo/m54rD5IAjW33PAsqSO4uIzsL5VmIqPk?=
 =?us-ascii?Q?NXF/s1IhXBo34uBBOe2zkNLn5omFSRhdK8DJvhzzna9wx5lCt3bOLYhoirD3?=
 =?us-ascii?Q?/ZoL9SKQy8GQbCV6f5NrI0319vcpe+wlFkn8XkEfawB+zS0pXV54fyQxxPuo?=
 =?us-ascii?Q?S+bsJbD0YYiGZ0zJWhSJeNr/1WIYw9Q8aL61w0Qaftc9CwPX64EA7E9M3G+o?=
 =?us-ascii?Q?JQMVdYmCtRU8MIiqXdfKCrhqP7K6MyP1RJHpbHqpHNdvdT//TDJsSQnXos/i?=
 =?us-ascii?Q?VGoMPpRG7kbWIQ/6Qo97Y+LQATH6dfNcmRJ7zQgs1tlII13JkHBBy+WOYWYz?=
 =?us-ascii?Q?Y/QX+ooh/FUqEefL8ZFuy0UiNOJG+KU4hjPgYWg0D8b4whupwSBfSQNeA2tr?=
 =?us-ascii?Q?1JYoT9iouElWynT+lrsR6/+s8o8wNXTk9hpCpAJyMgmFnozwpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:31.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5753aaa6-d689-456a-1dd8-08dcf22f56d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

With the introduction of the new object and its infrastructure, update the
doc to reflect that and add a new graph.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 2deba93bf159..92d16efad5b0 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+ - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
+   passed to or shared with a VM. It may be some HW-accelerated virtualization
+   features and some SW resources used by the VM. For examples:
+   * Security namespace for guest owned ID, e.g. guest-controlled cache tags
+   * Access to a sharable nesting parent pagetable across physical IOMMUs
+   * Virtualization of various platforms IDs, e.g. RIDs and others
+   * Delivery of paravirtualized invalidation
+   * Direct assigned invalidation queues
+   * Direct assigned interrupts
+   * Non-affiliated event reporting
+   Such a vIOMMU object generally has the access to a nesting parent pagetable
+   to support some HW-accelerated virtualization features. So, a vIOMMU object
+   must be created given a nesting parent HWPT_PAGING object, and then it would
+   encapsulate that HWPT_PAGING object. Therefore, a vIOMMU object can be used
+   to allocate an HWPT_NESTED object in place of the encapsulated HWPT_PAGING.
+
+   .. note::
+
+      The name "vIOMMU" isn't necessarily identical to a virtualized IOMMU in a
+      VM. A VM can have one giant virtualized IOMMU running on a machine having
+      multiple physical IOMMUs, in which case the VMM will dispatch the requests
+      or configurations from this single virtualized IOMMU instance to multiple
+      vIOMMU objects created for individual slices of different physical IOMMUs.
+      In other words, a vIOMMU object is always a representation of one physical
+      IOMMU, not necessarily of a virtualized IOMMU. For VMMs that want the full
+      virtualization features from physical IOMMUs, it is suggested to build the
+      same number of virtualized IOMMUs as the number of physical IOMMUs, so the
+      passed-through devices would be connected to their own virtualized IOMMUs
+      backed by corresponding vIOMMU objects, in which case a guest OS would do
+      the "dispatch" naturally instead of VMM trappings.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -101,6 +132,28 @@ creating the objects and links::
            |------------>|iommu_domain|<----|iommu_domain|<----|device|
                          |____________|     |____________|     |______|
 
+  _______________________________________________________________________
+ |                      iommufd (with vIOMMU)                            |
+ |                                                                       |
+ |                             [5]                                       |
+ |                        _____________                                  |
+ |                       |             |                                 |
+ |      |----------------|    vIOMMU   |                                 |
+ |      |                |             |                                 |
+ |      |                |             |                                 |
+ |      |      [1]       |             |          [4]             [2]    |
+ |      |     ______     |             |     _____________     ________  |
+ |      |    |      |    |     [3]     |    |             |   |        | |
+ |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
+ |      |    |______|    |_____________|    |_____________|   |________| |
+ |      |        |              |                  |               |     |
+ |______|________|______________|__________________|_______________|_____|
+        |        |              |                  |               |
+  ______v_____   |        ______v_____       ______v_____       ___v__
+ |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
+ |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
+ |____________|   storage|____________|     |____________|     |______|
+
 1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
    hold multiple IOAS objects. IOAS is the most generic object and does not
    expose interfaces that are specific to single IOMMU drivers. All operations
@@ -132,7 +185,8 @@ creating the objects and links::
      flag is set.
 
 4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
-   uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
+   uAPI, provided an hwpt_id or a viommu_id of a vIOMMU object encapsulating a
+   nesting parent HWPT_PAGING via @pt_id to associate the new HWPT_NESTED object
    to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
    must be a nesting parent manually allocated via the same uAPI previously with
    an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
@@ -149,6 +203,18 @@ creating the objects and links::
       created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
       of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
 
+5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
+   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
+   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
+   iommufd core will link the vIOMMU object to the struct iommu_device that the
+   struct device is behind. And an IOMMU driver can implement a viommu_alloc op
+   to allocate its own vIOMMU data structure embedding the core-level structure
+   iommufd_viommu and some driver-specific data. If necessary, the driver can
+   also configure its HW virtualization feature for that vIOMMU (and thus for
+   the VM). Successful completion of this operation sets up the linkages between
+   the vIOMMU object and the HWPT_PAGING, then this vIOMMU object can be used
+   as a nesting parent object to allocate an HWPT_NESTED object described above.
+
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
 
@@ -161,6 +227,7 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


