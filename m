Return-Path: <linux-kselftest+bounces-19370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4659971F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063571C23545
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333A1E133D;
	Wed,  9 Oct 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzJdJRro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40611A38EC;
	Wed,  9 Oct 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491950; cv=fail; b=OxHIrOcVUFLo6oAa7PKO5lFqCHVZchGF6VEso/ujSo5ueIlk7nED559IMGu2rNq5ENAdpLHogqAOetiII9P5+kz45QxcKVxeArBd83tNZR1BaEuRcAa2Ms1+WJUGPHSXztNe44eq78ShM8TwoRYSllaGAmKVbajvzZs5+uerjEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491950; c=relaxed/simple;
	bh=ZxaBtIOsfIZyVGYBXZ8TiHSV3SO1kdwr/w2u8jpqUQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYfW06qeG9tBepyf8zO47Dilw7yIGMFuuPtyvcxwGy7vSTTx3OceZbM3/sO6Xwx9iwn0Tf1VeLKSma0GrdxzBTEwxc1Tvs8LWvnBdwrpQqiSGGPfSG7UTt/6b4TKIHf0236CF6NOyLqDVwwgioUOvOypL9Ldkflt1HvFh/UELI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzJdJRro; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFaBata6HgYBlgF7nl8JpcD/xsMddlsHC2PmjYa0qO/+H7DqOWyjAfxrULnP+HjdvnNdwqZlr5UwpL6gxuHZpXzO9PbXU7W7CMvOj2pegPNVqTojPsSqtVE5KZo7KtBchfzjAnN0nC4/847YUIloUMczhthuIcLgkZuM07kHdC0vLSZ/ayb2zwGENbAg8yWEteS5sLOyeIes4MoX6bjlcHv/zgdqZjicZlVwL9uazWucgNCGewxM4+DJjN5zvFC7UoBKq2e6nGz52PL4RP0EWZWd1u7Xb/JzoTru1+uYYp5DoXMv8r+2uUswEzhUijHOJgQ3wocrq5RjdLB2M3lIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b7sTfaxkeFhFQvsfFXyHKJRoDnIiXMiZ3S983XHnTc=;
 b=GiqFNOKYKkxo1ZX4y2KYkNYNc5o65yyLUj2jlgN1CssVW/JJ+1r5PPXiOxVoZj1BJnbVc4y2UsyG0qCwZfUDkOBj+Ssh9/tP9qMlwNd5mb0ZJUCRh9kdPPNKeicAZD0etm3CCJzlcvAfIOCaTDrACVmAztySAiwRpvt+yyhmAaZ/Vswzd9oh1ItoFhfyQvCf0yz9q6wJuLreYt7I6tKvBbjlQD0Jl6Gs22ZfVfN41pl/qWbnpWCykIcIM4JpS0uzq1dMrtTIVfSaXa90pkdWhxd249OJRqqdXdUppTGbTIk9+A5tNXnlwQ0+El/1lX2RDLVlzrgpIuq6BKwQJp6r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b7sTfaxkeFhFQvsfFXyHKJRoDnIiXMiZ3S983XHnTc=;
 b=nzJdJRroivAYIBgKw7FU7rt3Cylkn/VyfsDdQvg5wEN2U3OqjelcMsSErJ80gVLDfDIUjhmC0jgFTwI8wMGKBIxb3mDhijqpmIwDFqGUBLqbUh/x2An098XbZFIvKhBFx+i8j1oahX3xDcT3JR5w64P7wlNq+j4eVc1jORO2SeWJZWN+ezcK476tOKDTgWaKkhae3f1ZbvM6dWhQxo6mV0LBEak/evlPWFW/s67cghRZLMntfTsGcshHcieGaRvSb9u1rTojPWWuMPkYM452kdnczGLfQCUrG+w9Sp+G0whGYfxABLDrfFbi/Lm0Mn4uEborXmP16pdt/LklrYe3wg==
Received: from SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) by
 CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 16:38:58 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::84) by SA9P223CA0004.outlook.office365.com
 (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:52 -0700
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
Subject: [PATCH v3 10/11] Documentation: userspace-api: iommufd: Update vIOMMU
Date: Wed, 9 Oct 2024 09:38:10 -0700
Message-ID: <0b56b2a4e38e8f4cf3a96c4fb2ccbbf4b5c67da8.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: befb1da4-36ef-418f-152d-08dce880df8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?98Q2kuiK4k+ZPF3rzNWlgw7JnMeLM3oMnXpR1b9wwHoIBGxSN+D5gh6rkCM0?=
 =?us-ascii?Q?O95Isg2qnWJcFfEx46kmGZ+wLmdKeUid+K2uQfs1E2zby7pMmpE9PLkhM3qS?=
 =?us-ascii?Q?gWDHXCCxICEyeOOPuSOIfRHZAJb9vBYaUCiBGFo/HlL5oEm9HOjeSVVf6rtJ?=
 =?us-ascii?Q?yDwgcGqRYnbQXAGwA/LNVf+rhlme4x88qOGPiAO3KLqB5GgX26JW1CROqK7Y?=
 =?us-ascii?Q?zpjx40OsiVfbgZQimlf6AOnF3YfNDX1A11RuTWv/mFvRr2gGNSZwBao1s+gx?=
 =?us-ascii?Q?f7QkjMeIQUTeKKIRutL7z02nvNX8r94Z9RDdhxLujqf4yIfndQq947kEr/0D?=
 =?us-ascii?Q?8gU0v5ZoMUGZybU6xR0Yt4wWXgxBDGTjafOsHIFCiL01IK4yG7KwG4XrcRGe?=
 =?us-ascii?Q?ghVrVZEQMrEkeX052i0w3nY3eWeys+B8nJwop4fLm037NIipXrq4EGrmAPgV?=
 =?us-ascii?Q?IsHr7/mruWCX2oeo8ivnRIL6c1DxU3S4uaH7wQ/BRF6a9WkFC0TzwEPr38gE?=
 =?us-ascii?Q?dSuJhFA7uAWRdh5Q0WtApD5uXWDNwLmRWoBHWk+6aH/07BbHbPehazRQwegy?=
 =?us-ascii?Q?tiOf5q02mI6LktZ9hq9TlDOWMgF3sJXcyvdB/VU45PdvwyYEi73ujPVMxeNe?=
 =?us-ascii?Q?JdIzD2yhwHUx3topQVCmCdeeVMXb0yaP1FrICb/QfbpXgIBrIb1i3Ptn7lFB?=
 =?us-ascii?Q?ynmPWaI9UNenVl9rdiXNaSyj8WbgXQkmXxi7ra0i6FIU3s61Rz/z4t81Yhu5?=
 =?us-ascii?Q?KI5i6Ns/qLfCwT7fWe1GkPGEvWis/qk2lYJA8IlfPyfKI5lfFn3dVtdxIDYH?=
 =?us-ascii?Q?o2h/P9qlqedA0U79mrd2TkXPlZvakZHRdAbYvV7aJgJKIitWxWqv2mdbovjb?=
 =?us-ascii?Q?TcLIPZr9j6wLmnETPFsUCpNM83OTD0KNjVMkNzUakwFzQ6ofj2t50zkr1B3K?=
 =?us-ascii?Q?yiQFh6vQdJ9/3pJ2qtqzJ/RAs1URgnK2dHpRdj3oapLpcIzxEXAEOZRRSmkl?=
 =?us-ascii?Q?lF0Dawb5fME/0LxoOEjaFBIeEoeQZpRKgZa4atR7zw0dYfm9SdQOPhSPRYAF?=
 =?us-ascii?Q?JRQhirqcryABawaaDW+xi9+V97dzdHJ5NqXjjvd4vgiE0OSXOXbmF9MnrT5m?=
 =?us-ascii?Q?Gn//O56cFuzpu9CDstZ9HthgSU9O/ludQBfmWvyT9Wjgi5wjIO2jMigHHtR8?=
 =?us-ascii?Q?AQh+bEt6Zwo0sVmbLzjj8EnWy7OaBrvcBdsHfjcZm24fPXkhgaCJqDqAJMXO?=
 =?us-ascii?Q?Bni25I9fCElPZ1BqvrfSTSoxWGs+n9MoL1UcfYBkqXWtqmui0DQCrtmjlmsC?=
 =?us-ascii?Q?HzS0mxkzU/R3Bpb41NKcTRW5SLaCRF9kLlUEAUyuQeVnv7XV8qMUtCuEv/cc?=
 =?us-ascii?Q?9gnb59QOGi1g/oFqwBA48IIPiVmM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:58.2671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: befb1da4-36ef-418f-152d-08dce880df8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585

With the introduction of the new object and its infrastructure, update the
doc to reflect that and add a new graph.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 66 ++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 2deba93bf159..37eb1adda57b 100644
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
@@ -101,6 +132,25 @@ creating the objects and links::
            |------------>|iommu_domain|<----|iommu_domain|<----|device|
                          |____________|     |____________|     |______|
 
+  _______________________________________________________________________
+ |                      iommufd (with vIOMMU)                            |
+ |                                                                       |
+ |                             [5]                                       |
+ |                        _____________                                  |
+ |                       |             |                                 |
+ |        [1]            |    vIOMMU   |          [4]             [2]    |
+ |  ________________     |             |     _____________     ________  |
+ | |                |    |     [3]     |    |             |   |        | |
+ | |      IOAS      |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
+ | |________________|    |_____________|    |_____________|   |________| |
+ |         |                    |                  |               |     |
+ |_________|____________________|__________________|_______________|_____|
+           |                    |                  |               |
+           |              ______v_____       ______v_____       ___v__
+           | PFN storage |  (paging)  |     |  (nested)  |     |struct|
+           |------------>|iommu_domain|<----|iommu_domain|<----|device|
+                         |____________|     |____________|     |______|
+
 1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
    hold multiple IOAS objects. IOAS is the most generic object and does not
    expose interfaces that are specific to single IOMMU drivers. All operations
@@ -132,7 +182,8 @@ creating the objects and links::
      flag is set.
 
 4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
-   uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
+   uAPI, provided an hwpt_id or a viommu_id of a vIOMMU object encapsulating a
+   nesting parent HWPT_PAGING via @pt_id to associate the new HWPT_NESTED object
    to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
    must be a nesting parent manually allocated via the same uAPI previously with
    an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
@@ -149,6 +200,18 @@ creating the objects and links::
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
 
@@ -161,6 +224,7 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


