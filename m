Return-Path: <linux-kselftest+bounces-21482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD09BD69E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8619282B18
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E6216E1E;
	Tue,  5 Nov 2024 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FM4pZHyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D041216DF5;
	Tue,  5 Nov 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837121; cv=fail; b=LC7UB8sJeMsBkLJu6/L0v7+QR9mZhNlj7wTcDVf7tL/Heedyx2dKnAOuABS1ae/9CzCDzlZAYiuaLkN8qWqYxUNEwL5h6YbqC+JkSdQgmC9nxN6ZekPtDFUIKXY3PKsFS/tW1fyCnteugz6KzIgzBWFMiMgVAwvo59NkbgqpANc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837121; c=relaxed/simple;
	bh=Bc7irgx/6rjjEyhgYWm5e4HG/xlq3Zz6q1tfakfeWrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFzIVlHs8ykTqSVv5YWMxWfCrrtJUY6ai30Nu5UntpECDbNR5TrjnWpLDOlR2Gun3wLKn2nph/5mMHMmHo7l4klx6VuzHHSI0nD1ZUVOF/t6WkLL2pRNEGCz2i2Gy72r/X8S1Qk9+kKJaWOTd4Gt//Z7EjPRJevPTpkhwxUAFCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FM4pZHyt; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW/DybCJ8WyO1gMd47FZcieCRvS+xh5RZsxlKOQYCIX7wyr15W6df+6OLw4rK2N+bshlaQEhXD0aem/z1W3naKVfs1cmZJpfFhbLAgrfUFdLw0WY8muMrykn81+ptzU8p7gvX8j1/x/y7K2pnei+OcqZCikNB7zMf37mlc/ZekQeULaYRqO7Hp5f++o7eE5/bVBy3mJef4/J7qlAopVUsLhd2DeFTmTrlBZDxg6b+S3n25cnubyq7zP9VwNxr23NQyrKIZWFOIMJMmdY5S8Fsdeo9goAp0LvCUeJlO6q39/K/I0D5ODS+Lnb5TA37bOZgrqZ9lSUWOGHoUy89KvESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEMmgACXamRJHRJ8k8PHyMQpZBwcJXQxMazWsnOea9A=;
 b=jsUg87QzWLC/Rt3wJKsNMNrHiPv7i4+AvmuRwWGTjANU2cfImAVD65H2MCbdvfFekPRuWsJtXXsjBJGpkeU0ektVhIVqz5Sxc3zZZZF7ZcJey023qK1TxJGys/aR23CWhp6BZYGmIS3fTPqBqTE1SqPuuTk4ItzdHQqRxGkh9fZjPp3M860Wtu/vKTTfPR370MupmQXuH+luOTEka/faipAd4Bh9E5miscmfiIG8vJXH93skMvuS61tFiwaJs8ATaxWtnlbS7m45+IyKwVtQK8RvU3HuNo7X0MFBKGgHaDdtECRjHzuNd2DpMdrxn184NfjMATiBSddY8bhVFI16LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEMmgACXamRJHRJ8k8PHyMQpZBwcJXQxMazWsnOea9A=;
 b=FM4pZHyt9mpAxXsMJ/Z2Fp/Ixto6XRmnPfDYgNt4BiiG5I1Z66eOp9PRrN5Iu4n9PVaxJs9LL+FYRXLl9Kz5Ouuol6DECciYAV/4QRIMbkVfkUoNcrY8WeMP+cgrkuDH0HjlNsRKBOdPzRxBHuPQgCdvy7fYLTFa15XzLtId9Guv/Y36SXWl+S3s2FBMBh2kNRj3+j0EyaOLbEp1/y+T07kZVRnkZ0T1MF9Tm6x+x+rFCSdQI0BfIMinxfJIgssHKF8F73cYhSP3uH3FFyC850zi8JNLXOH6R/0uaH7j7uptXAOyog0P0HuvTtUJCmLzI2D8hQnPhFM3wlcTyAt+Vg==
Received: from BLAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:36e::18)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:05:13 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::37) by BLAPR05CA0014.outlook.office365.com
 (2603:10b6:208:36e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:01 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:59 -0800
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
Subject: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update vIOMMU
Date: Tue, 5 Nov 2024 12:04:29 -0800
Message-ID: <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 563c5146-2f93-483b-e013-08dcfdd52897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ImQ5HBOh/WqiW8iecn03QkosyRHVdFRNrUaM0r8OuTjX9NI565/JTqgnxxCh?=
 =?us-ascii?Q?8OeX3yH0xtUxRAg38r7C1HOpEiFnRKhKH9SNGrbdcS9YU6L8mcFBKAyoGO21?=
 =?us-ascii?Q?Gwtp+kvlUb4fRsYP7WZwzc5/FOrnBHYRaqDgh2I2kgNamZ98pzLKscZcH4Vd?=
 =?us-ascii?Q?Uakf4lbajv/v1sSJIWI+b3l1DiZ73IkUsAVDwKUtn898D0ujzm5rP7kVRG9G?=
 =?us-ascii?Q?JphBw+6jd5M9T2qghtGkGzzVrUt9gkxEBUw+v3B61zHDhsGy63zpnpJ9yC46?=
 =?us-ascii?Q?wVBefmi63GI8w407erP1ssNY1RBPLPyeM5KDli93LMxA3NLeduoZfqwAcvcT?=
 =?us-ascii?Q?yw/XG10JE5vwhYTTxATu7JI6qi6rYzfc+mgZ1JZZRZOZidgASGPmcI46JH8w?=
 =?us-ascii?Q?JVWYlGhNrr0Izu5xAq7HlZHLTM11KmdnM+scq6+xjaH+MN5oXeE0F+8xurm6?=
 =?us-ascii?Q?34DFhE26WpAfeJQSLQZvXD0fylW0ZdfIRzBTzE70x2nv8GLjBu2BzT0iBRpG?=
 =?us-ascii?Q?lJNFUYyxirS+Ip1Nsn1HoKuYWdqTGIRxtWYnMnVVYh5pflR5pQjHzGscftxy?=
 =?us-ascii?Q?PoFNxoyITvEW+ibmNFSNxeiHdqFpm1oZ90/lMvPXivPho5OoPe5ZuSjcGW9G?=
 =?us-ascii?Q?WLGK+3MKw7O9YQe4L27VzOzEzeo9LMhNkwKuIiLg0fNv91dgifwWqZywfS3P?=
 =?us-ascii?Q?p09xjst8kLue34pBSFDdDhTlXdLaAeu7Cq5WYfejBK9plOl9rPsBQzrY7FwP?=
 =?us-ascii?Q?9pHkuJL7OA3hoancF5Yf5BkZnkErxuKfMQGDbrQaytJ3QWtL02VekTIov8Rv?=
 =?us-ascii?Q?ziOUAw1bMsqICw1SvE2MXxwwbyZG5t4Ti1zpmMt/0OfPtPOjEafsVgdvvRWx?=
 =?us-ascii?Q?lYto4GEORkudN5pMUHx7gp0aqHp5o12EJflBZancvMytBhpx3B6E0mz2H3Er?=
 =?us-ascii?Q?fWfv+cYzZqlT9AwfdK8qj6XL7AOo5QohTaKM/s9NQJvXwpk9b+X18CZRfHvs?=
 =?us-ascii?Q?PSgp9zJ3UqVVOVe/MMmSq7L11axrhvMQU7uemrIXgC5mulhoQteq8z+Be68q?=
 =?us-ascii?Q?LX7DOZ+8Am24Hh4lx+dK1rgd+A45/bppt6NaMmKzbZlXCXIxmn7EBQlt/Gkq?=
 =?us-ascii?Q?+2NKnN4BpCXgDwU5wZ3y2Kz18j+9Sp3ICKGpgdSEZNffXMYZSMP1b3ELYvuq?=
 =?us-ascii?Q?9js1UD567wIGjVO9GYjUikhQTRvtAe0knUZ2gaJKcywywxd1LokF5el4Lcg6?=
 =?us-ascii?Q?N/dSzxYXtg0OquMeNfcciqSJHTHyQvTrGJxgjUzxFKZcuOQJHDmRByvZNgTU?=
 =?us-ascii?Q?H3Y02ov7Lt6ZNWKcvc94aJNkYafKV0mS1FXkkbcOTJElO6PiRQeP4j0q0i/x?=
 =?us-ascii?Q?1JRxAb6s2672m3jK3+q1qo3bCkE1PgGAarW/ZVORVJj+2tEJ4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:12.8639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563c5146-2f93-483b-e013-08dcfdd52897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

With the introduction of the new object and its infrastructure, update the
doc to reflect that and add a new graph.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 2deba93bf159..a8b7766c2849 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
+  passed to or shared with a VM. It may be some HW-accelerated virtualization
+  features and some SW resources used by the VM. For examples:
+  * Security namespace for guest owned ID, e.g. guest-controlled cache tags
+  * Non-device-affiliated event reporting, e.g. invalidation queue errors
+  * Access to a sharable nesting parent pagetable across physical IOMMUs
+  * Virtualization of various platforms IDs, e.g. RIDs and others
+  * Delivery of paravirtualized invalidation
+  * Direct assigned invalidation queues
+  * Direct assigned interrupts
+  Such a vIOMMU object generally has the access to a nesting parent pagetable
+  to support some HW-accelerated virtualization features. So, a vIOMMU object
+  must be created given a nesting parent HWPT_PAGING object, and then it would
+  encapsulate that HWPT_PAGING object. Therefore, a vIOMMU object can be used
+  to allocate an HWPT_NESTED object in place of the encapsulated HWPT_PAGING.
+
+  .. note::
+
+     The name "vIOMMU" isn't necessarily identical to a virtualized IOMMU in a
+     VM. A VM can have one giant virtualized IOMMU running on a machine having
+     multiple physical IOMMUs, in which case the VMM will dispatch the requests
+     or configurations from this single virtualized IOMMU instance to multiple
+     vIOMMU objects created for individual slices of different physical IOMMUs.
+     In other words, a vIOMMU object is always a representation of one physical
+     IOMMU, not necessarily of a virtualized IOMMU. For VMMs that want the full
+     virtualization features from physical IOMMUs, it is suggested to build the
+     same number of virtualized IOMMUs as the number of physical IOMMUs, so the
+     passed-through devices would be connected to their own virtualized IOMMUs
+     backed by corresponding vIOMMU objects, in which case a guest OS would do
+     the "dispatch" naturally instead of VMM trappings.
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


