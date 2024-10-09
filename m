Return-Path: <linux-kselftest+bounces-19384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C7997214
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB4A281E13
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D518BBAE;
	Wed,  9 Oct 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mcNDv7s+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9391E7C3E;
	Wed,  9 Oct 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491971; cv=fail; b=C+/LEwEcmsHsLjGXhS2HdahJqtT06VI6S6kwr1/2P+roQ3SszBl+ussN0c7SccixS3+uNEE4HjvqjMgI5cNA/LBysj0OH3K4/TnqoFp/N625IJEZDBeXnlbASbCG2AVxVT4bIN4ZUibof0dK7tjy9+ICdA6k9JvvenUE+EEZsAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491971; c=relaxed/simple;
	bh=/3VetMUVyReTVig9gi7E/jCflgECvad+8OFiEd61dYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5OoWi4dQz1936aouaIlZh2I+uaauZHXUHapC1vB/V1qC/61HUkJ5YPsbj4AoMyzB4ahnT5nsWbZ/teNY9iRHuI6RPw3+f/WzFKCqWznmcqLVXcDQublGGs8keP0n0e4nAXTaQ1fJI/mvXJf/b1jN5E/0tz1dJc5G1m2D/wB9uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mcNDv7s+; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRvFDZ/0TyEaagc6SIJMHgniMDEiuxE6vbHWaKw19bKXMMTyhFQgpuwgfGj38vESn8q2Sk+KZbAel64Tx51bt/M3Q25g1ZznjQf6zBbl3wJHURIG3OE0WNizHWXcG2SZ+i+8bLQLGsQ2TLCj1iiKp012fxF9e8JKe8xHsM3Ae1lNhkvBVCMOe7Bzb6TE6PF7lvq6RrvBkZK9np/rFcU2tCD5TeSsxpRN+VWYHQu6RDGrL5AMzEysmS0xK2msaaBNiHE748znV94MSIeLJA1YVSne+f5D1s46pw9CxB9h3iT7XBLuNxLQwueJdEwDbeZ3gzelKT8PKBQiK1VRVPLsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OodBFEyxwxkpxrU3O1vgTk+R9PWLfXORshgxazPXvZ4=;
 b=JPA5TzOT54r4NyXMTiBEZdKRVcs15DPMSGYEje92zsgKix3q80FOIm6jErxhzUEghucRAuEwPLQHzVd7FSfpgYvcgtJBsxwQJlg33PbWWYIlpfQHf8QVEmaj2Mu6AUUm1A7J3N1XxXXUsugo77035Zfte3rUtw5I5C3x/0JmZw5VKLg3jIybXZipfX/WYWsVsH6oCLiLH3Wc3rd1AIf0YECikY6i3C76QNhWAASpYKn1bBB9zTK2hra2FwM/Zt41oFK6JxomeSjtPKxNnZztLrLQro+VDCCeqyhOElzMpZW3dE056jZFeUtLnt7KcJLW6o7w/1Z269k77rSS54WRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OodBFEyxwxkpxrU3O1vgTk+R9PWLfXORshgxazPXvZ4=;
 b=mcNDv7s+Px+D3C6FBcux3JBQntKe1RirC4Xy6M6ZBznU5iQ246cEnZmvEToz9/Gp3sMBFEemWyPzRSNAbw2tN8uA2nSAyTCo+kHSDEubhpLcgOv+wTkXQ+oJMoI6RkIK3KmOjM+Pw7nAm9Gjzw8/NqPZX46vTCj2oauRzXyuz3TEqdW6p/nC49LAftSOeUSNsKitVSqEXgQ0UgbLyk+NZLZ6Pb9iUxMUy1GCaXspP8gJS84EhnRdUTenWyZBYXyg82WOSZHy7zfMg+2XuRaqL/rinTxPTkSCGwW6Oce6Q8zhmup6SBixtkCpUqUy7vts3MhFnFzmtNMhTT3GhlE1zg==
Received: from SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::9)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25; Wed, 9 Oct
 2024 16:39:24 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::9) by SA1P222CA0121.outlook.office365.com
 (2603:10b6:806:3c5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:12 -0700
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
Subject: [PATCH v3 13/16] Documentation: userspace-api: iommufd: Update vDEVICE
Date: Wed, 9 Oct 2024 09:38:25 -0700
Message-ID: <d00b9f9e4af1c656ad18d74d40f397d7459e2c68.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d69071-26c0-4b60-b679-08dce880eeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ept51ItioDuIg4wBzv79WSFxk5016dRRfCeIcdHt0XM/NMrWer0hBP2Ggbo?=
 =?us-ascii?Q?W268npaAFHZykiK0d4MLkmaxaYHzTtU4IhiopPUKk+608lMZJZeNR0jiCjfv?=
 =?us-ascii?Q?p4x6HzH6ndwkCy0QXCK7zFcDaA4+6JwDXvDWEAoL4SxOk7w9ZQye8eVD7Iuq?=
 =?us-ascii?Q?yUJxShZPz/HxYcMe2DgJ0mhuiqT9qmQM70oPZsAoC5IP9+EJlSsdMrEKHR14?=
 =?us-ascii?Q?7CnbSUaGwyQ8h+H+LfLGuxRaWX1a562r46eR50xEPIhuRs4A3ZNZFe0AVCuU?=
 =?us-ascii?Q?NXIXidi6o524Kz9ULYpjhYqqJaRMRlF5bskm03wX8PMGFeS+sApXCfcTglDi?=
 =?us-ascii?Q?yzNvhoC1KG4sB+ffK4iDxx4Y5STErVvFua6PTG1tv1WATvKE/26kDMjeYLGU?=
 =?us-ascii?Q?UsTWH6zD0ErLYxHUYVCL5mq89bVm3CX0WsA0UCfwY4IGACZDpXUOowCgpzQB?=
 =?us-ascii?Q?N0DW+h5AJjR/iqJyu05DuJYpekpVK02/r9UJ7m68fP/xdtKXpKVMANhIJo1e?=
 =?us-ascii?Q?DiYpwUTgWR82zo3TKl0WQGCJddmFoVXOUNLAZK6F4ug2tGjWtj3Qr1vcRnPU?=
 =?us-ascii?Q?Bnafptw7ztU7INw5btfKi3xDJR9ulWsZhWUiYyniz8BI3i7aGhQgYasi/Kdt?=
 =?us-ascii?Q?uc8VMd4mk+5oF5iI4dgVEsN7eIVLPW1vBh4NtR+3mZ5Ked3vnw29TK8vN55H?=
 =?us-ascii?Q?rxE6z27ozMYzV5C2ipCwi7ikD6eaDhsGkPuFdmVGlZabo4QjKiVf4DJ46CDk?=
 =?us-ascii?Q?16eAtz8RxOd/DdbFFCLW28LIIn0+R7PJyJvnlZG6gqYV1PV0Ep56GKRlYEfP?=
 =?us-ascii?Q?YwWYDFDFCzSz7rEEeeLrwGTlpAIEPAh5be3tdIKxoaojGrUOm5WeII2yFNmG?=
 =?us-ascii?Q?vZY4EqGIyiL7P0trcacmQAbtM+SgAmHYJyf9U6uEy2Udgpq01v9Xub7iLFga?=
 =?us-ascii?Q?ANZ6S7V+Qmn7xvKegF8L997rIpVMPB2IWCNkeFOGarveRZDMf7GLkN8k2Aw8?=
 =?us-ascii?Q?pgNlTLd5vx8l0xirvtMwP/0s2ClS2xt6VfmjWUUyUlWkk+mgGoQXgGrsKDqC?=
 =?us-ascii?Q?L/vP5RCYc2cL3Nl0oXYzZFW6zGGtGCGKnaaEsKxLn64NnQ+SZ3DHdUuv/atY?=
 =?us-ascii?Q?tEJrIKCRXffuwshdotfFHJDmBm+5+LjmPkAfiqg6NBRYzbao9Bm+U2GEeZ/u?=
 =?us-ascii?Q?ICmd2LDG+YRUb33BZ/E337EoYhDYWyKbY+bYwCw8mgWv+nVu9yO42K4dyxpv?=
 =?us-ascii?Q?/xzRTgfoGVoZo3wNSn7lMs/x9hYTUVox1f8YGvLjjtHE1S1bE0BmP5x45q6s?=
 =?us-ascii?Q?PC8zEmUEJi58fAMPllKY48/679KWxQ37Z7VrpCAs0rxPZVFMRH8r0h7eCFc7?=
 =?us-ascii?Q?/UjLgPF5ln+GqeRHaO+yt9iCTQIF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:24.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d69071-26c0-4b60-b679-08dce880eeff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

With the introduction of the new object and its infrastructure, update the
doc and the vIOMMU graph to reflect that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 58 ++++++++++++++++++-------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 37eb1adda57b..3c27cc92c2cb 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -94,6 +94,19 @@ Following IOMMUFD objects are exposed to userspace:
       backed by corresponding vIOMMU objects, in which case a guest OS would do
       the "dispatch" naturally instead of VMM trappings.
 
+ - IOMMUFD_OBJ_VDEVICE, representing a virtual device for an IOMMUFD_OBJ_DEVICE
+   against an IOMMUFD_OBJ_VIOMMU. This virtual device holds the device's virtual
+   information or attributes (related to the vIOMMU) in a VM. An immediate vDATA
+   example can be the virtual ID of the device on a vIOMMU, which is a unique ID
+   that VMM assigns to the device for a translation channel/port of the vIOMMU,
+   e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to a
+   Context Table. Potential use cases of some advanced security information can
+   be forwarded via this object too, such as security level or realm information
+   in a Confidential Compute Architecture. A VMM should create a vDEVICE object
+   to forward all the device information in a VM, when it connects a device to a
+   vIOMMU, which is a separate ioctl call from attaching the same device to an
+   HWPT_PAGING that the vIOMMU holds.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -133,23 +146,26 @@ creating the objects and links::
                          |____________|     |____________|     |______|
 
   _______________________________________________________________________
- |                      iommufd (with vIOMMU)                            |
+ |                      iommufd (with vIOMMU/vDEVICE)                    |
  |                                                                       |
- |                             [5]                                       |
- |                        _____________                                  |
- |                       |             |                                 |
- |        [1]            |    vIOMMU   |          [4]             [2]    |
- |  ________________     |             |     _____________     ________  |
- | |                |    |     [3]     |    |             |   |        | |
- | |      IOAS      |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
- | |________________|    |_____________|    |_____________|   |________| |
- |         |                    |                  |               |     |
- |_________|____________________|__________________|_______________|_____|
-           |                    |                  |               |
-           |              ______v_____       ______v_____       ___v__
-           | PFN storage |  (paging)  |     |  (nested)  |     |struct|
-           |------------>|iommu_domain|<----|iommu_domain|<----|device|
-                         |____________|     |____________|     |______|
+ |                             [5]                [6]                    |
+ |                        _____________      _____________               |
+ |                       |             |    |             |              |
+ |      |----------------|    vIOMMU   |<---|   vDEVICE   |<----|        |
+ |      |                |             |    |_____________|     |        |
+ |      |                |             |                        |        |
+ |      |      [1]       |             |          [4]           | [2]    |
+ |      |     ______     |             |     _____________     _|______  |
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
 
 1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
    hold multiple IOAS objects. IOAS is the most generic object and does not
@@ -212,6 +228,15 @@ creating the objects and links::
    the vIOMMU object and the HWPT_PAGING, then this vIOMMU object can be used
    as a nesting parent object to allocate an HWPT_NESTED object described above.
 
+6. IOMMUFD_OBJ_VDEVICE can be only manually created via the IOMMU_VDEVICE_ALLOC
+   uAPI, provided a viommu_id for an iommufd_viommu object and a dev_id for an
+   iommufd_device object. The vDEVICE object will be the binding between these
+   two parent objects. Another @virt_id will be also set via the uAPI providing
+   the iommufd core an index to store the vDEVICE object to a vDEVICE array per
+   vIOMMU. If necessary, the IOMMU driver may choose to implement a vdevce_alloc
+   op to init its HW for virtualization feature related to a vDEVICE. Successful
+   completion of this operation sets up the linkages between vIOMMU and device.
+
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
 
@@ -225,6 +250,7 @@ User visible objects are backed by following datastructures:
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
+- iommufd_vdevice for IOMMUFD_OBJ_VDEVICE
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


