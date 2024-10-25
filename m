Return-Path: <linux-kselftest+bounces-20731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018C9B137B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8765283C54
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A42217666;
	Fri, 25 Oct 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hpXkMjqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003621765C;
	Fri, 25 Oct 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900239; cv=fail; b=tT9G+txIgL2Ad98NfrmPEwJk6/BZsDvGjcfNIb0BL2GNYGzd4yCq53Zbh9xa5JtlwBRLbC7zHPAcmm+v/6z800Jo9Pi4Tna3OMtbi58N59IyH4yvjhdWFAvL3viu2IVGlqs6fIC4IMSBTA+7c7YHCNJbIsYyfaFKzPB4rvn8+h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900239; c=relaxed/simple;
	bh=B9AXtm46v2L6IQaz+LoQmbqz+m1e9lAlrTyrHDH6/ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h12TD/9z9EOW7lIU9Xyid2tHoeqvPLAp1a/IWqKZZJQESnnG7RN80oNNKmSVCmtVyPmwJKftAx2a6rj4bWfXziJlJ4VJwzNJd6tghFxVfjvzUmq0Dm4M95QEvBDKEGqYa8L3U3Rzl9gyYfzTqOCKPSH0hgJ3xEHAgUMdhJ9vaVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hpXkMjqg; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKdOTOZjH3AMrP0KxMdkA6grLJOBongWcSRwdNf2SpwkilCZ+TpnqZRiKKZvShVywWPTD6ZNjJuxC4TG00xIx5Q76lhLYkCEbUacYIjfV5/atfqY9ld4snYRM7DcB5RVHOnJ9G0Q/cz3Oev4yq7IbrHtkVhayXzheQMmMH68hk8iYhUUHBcEr9IFoc1FOWWfBpJ/zjV6q+bAoPjr39z2xl4oqYXu8cRgsjcvGfNKR1zW2QybfUI3Y1386Ut18DfBOz2vNopAwqa5KoP+RNrFfth1CpzR90hHv/uJeTpLdOOyVCHkEFEJM/OQ1hUj8dohl3qN3BUaEQe1lpQjRvzDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj5Y8HVhvhXrFlgsslTpOPlASp/J9iNm4OG6ATXQhdw=;
 b=ipylv2PxYj893a9ACSSyFC2YLJO0gxna2QGJRdIXfYAlk4+gASH95jiH1Cpij0mcZlcC0aq2EdgXtsF3woiLykkLsow7AfKN6ptmnAmU2tC6u4eHHv9+j9xsFJLqGsDSqPTCI6XThmVKhAEk1RXog1OXR2oFfaMJjhByXse8drlGOYP36UeS2MR6Aa6Dp/o/eRM2Jkc2tKuTrId/fjRGS77373XyEQrCNeOn9/bpT/IQpBMdT/qqf6E5NCG0mhXl2DMfZ5/lPak+PnHs/E5X6j22ekCAS94zksJdlqvng14WT4JHkw9GiL3Frl5H1Jx0cCk/zbM0BrpyQBNDY7o+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj5Y8HVhvhXrFlgsslTpOPlASp/J9iNm4OG6ATXQhdw=;
 b=hpXkMjqgQDmpeK1GtbgWVec6jzgcugbouTXPwsu8c6mr99/AaVIaK9LGRLQww3V4q5bJywePxBKyx0YzzfP/Nyhi/jReo6PqFaqD5/PrKupDgnGhoprTiZguy5F5cFSkOCYs1bSBAVPjuOlUsAKD/2ilnFx6369AQVQakzH15P1bWd6WeWXKJodN5lcYK/v5+Zz/QuMRM7lztG/ucmk6taatJC1qvakma9SuYSAS8BC/u/J9prM26h7GDNIsj3ggViWUiZbmTOvJlhty4nNBC4QdDmaUOZwbJBE5gzN0D3RAw+K8p1v5XSE5VBuPTHKv+O4jREmLMqCSmV6fv4A0Mg==
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 23:50:33 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::78) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:18 -0700
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
Subject: [PATCH v5 12/13] Documentation: userspace-api: iommufd: Update vIOMMU
Date: Fri, 25 Oct 2024 16:49:52 -0700
Message-ID: <82a05ca8880c3613120fcf6875d083b25c5478be.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 67734da2-223c-471a-e8d6-08dcf54fd07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mx3nQ0F+r4+rbuBPFZoUr+QQeWnvoJ9mHKmqSoInICTxlQ8+b34HiVR354mm?=
 =?us-ascii?Q?LjGl4qEG9KKVGcJmhRL4/theYvJgx8iEbeP832B7Fam0TvcLnuTmOppmAuPV?=
 =?us-ascii?Q?4KDSEL/vuBj1IOWSwblKIDQ88No07LFHN3T7ZSC8q+2nQRI7jGz/mMqQrPUa?=
 =?us-ascii?Q?DPYSkCCheQGvqurDixSZRYpKWXICd+AVrFTpTeXgcObXheI9YItJ+i18O1pc?=
 =?us-ascii?Q?weU0Wsugdb9Pqa9PGYeme9Zs/zKLuCovnd4kivXO44kOGV5Q2+LT/3hcZKBz?=
 =?us-ascii?Q?YeFOEyc8tBsl8p9msQsWE5UUzHo58M0Y4Ipa3BJ3Xt8lB25ha7lkOUkTYXDq?=
 =?us-ascii?Q?PKWH/7obAdMGqKe9/IlXUw43zw9B+BuVbpjuyTR1Sy0nJajK1LlzXBVY11P4?=
 =?us-ascii?Q?dCRy5Sd/nhqpldOOgnMo4CdymDZLzvYoF/lJAryYnnT+e1tEevD71OZTpyWz?=
 =?us-ascii?Q?gocm32lmqN3YysXFieX/vRGgUep4eO6Q0bmjs3lmRtpC1xUqhRgFVKX5cTLo?=
 =?us-ascii?Q?C+PuMVhvDJ0Tdwsbt80AYst76VrqVnga2hJxx2F82G/nHoGo3csJya29k8Kd?=
 =?us-ascii?Q?gcdusR1wV80K6KoEM4PXcGnOgIAYI4i1UDlwGYhGtq3LUKK4m0/h919/Wztt?=
 =?us-ascii?Q?lh83uthRMIi/OddS1k85BsAPLyGjNaVk78nRJ7N799qkX9MjIxR5qqFnkbuu?=
 =?us-ascii?Q?KBQNJDEyK+nzXR4WH4nWESofN84o2UrLOhYMFcl/DWpDKWABXsD3Hlw5NQEP?=
 =?us-ascii?Q?nV39GoLGUpkOEt23S+MJiFmyTPrSuuy36H2pk9RZZxHtUZfCPvDWdgY5Xkdl?=
 =?us-ascii?Q?wBCc5fhVxQM/0p13liDqe1FJXbapaMLQNM0v5nfUaNJ0R/n/crW6W9YZVeFS?=
 =?us-ascii?Q?4UgA3wPagA8BF1udhqQurXSPQFuRJnZoennE6gPgfcZS/cRo1FCDYq2d8vRa?=
 =?us-ascii?Q?xfhg2gsorGyfrpBS4Qcz7OFMoiQ/BFqp3AkXnvIoAuyEFTuAnpVQw3R56tVq?=
 =?us-ascii?Q?QoDnNUFuFxQvEtxMymEBKbQ8em2e4EgSAHBRqECEGHL/+OUDmrK0O80pz/7G?=
 =?us-ascii?Q?UoFINz1688W15ev0HV/qQGEM47Q4x1wGJuv8KJD3i7hcFTAOm15UJ919/T4W?=
 =?us-ascii?Q?BZooo3+yNHJo73oflAM2O5PDFe3R9mSUVXsQtPJiJi0T5wERv6ryaIgR1fJ6?=
 =?us-ascii?Q?8svJ86dXM7SQrvEo2CZo2TVgYm09szHO7BxVEyVk0ObbPYQYS/+wQVSf+boW?=
 =?us-ascii?Q?aGImtNDbqpDAolGBentbbCH7+2NDmVKNOOGRyq8y8gZlQdVJeEsAOcJFkljv?=
 =?us-ascii?Q?T1y+rZrpTt2DMOSF8g3Nh5NhaP997ZqYspilY2O1eoc2Rgu3f4NtzZ5aPHQ1?=
 =?us-ascii?Q?vXa6F9p93NCOcqI3UeloUW3B4rO29qT769lV9cNTGza2xq/wRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:32.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67734da2-223c-471a-e8d6-08dcf54fd07e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

With the introduction of the new object and its infrastructure, update the
doc to reflect that and add a new graph.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


