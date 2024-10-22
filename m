Return-Path: <linux-kselftest+bounces-20357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803939A94D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F702837CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BD1FF7BE;
	Tue, 22 Oct 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQCTvXHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071C5EE97;
	Tue, 22 Oct 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556466; cv=fail; b=u/aYVMS0vgIyhD/lhsbaGdgcpmmAWILtdv+oS3xjqtWjeHJ6VJC6ZxOjCTGtmjzRSBuc0wQGX47KxCTvp5nGSGDoowcyMnW03MqNFG42MkV6nh8ohyKR/ABT7iK68EjhpGmsTeP3S/PwbTmMXjldhRi7DAmDTlooER7kX2NoJ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556466; c=relaxed/simple;
	bh=cC0jz4bcpNdkQAMS+QyStdtWW6QC3eJ5+coK2iC9kcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlwX33SInnNIwK8IvFKN73Je/y9dickLXkVlzwqA9q46AHE3E654GO6g7Z3Krjp9WugifXqtYFaCjr7FghZ4y4SvomJ4V0yjZs3zwDK2+PAoCZSCF4gqE62X/Fv+aTYk0gbbRmvcPKXIxcMKZD78m/BWJmv70w5yeT8lTYuXWKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQCTvXHa; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zj7S3bdVQlLbmVXHJa3mf1xLhpVnlIAAIl39U9C96+2R/dXdjtLkjz5Yv6NEbQyc26YE50WTUtHOUk/lMd48Te4M2iWRnPRilKJm9JLVnwpjlkAuuHW2+EwiD6Fw4TOuNJiTZYMmxF5hk20tcn2E3WDcieuYD4BHMLYyLaJSilCA9gN14xCiuLdmSnCnGZAcM35r5jccjF+5DQqAVlmCnbNYd1LLvygQ7zx3dK/1TrmoFDSW/YOMaKNQdDzlT1hGEZe5FV50lM2cpO7icYy9kf/h8GTy+on1K4J0oZ7+vXOoGEEbLAmF9oRuqbdfYP7emY7tsc6bVBNz7T/ux/D6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiC5SOn5wx3+AyofS3XSFjYoRsquGrqqghEx28hfyWA=;
 b=m8ql4LxQRFa5O56oT4Qweobf5zbjo/aL6UJlDJxKQSmAdoIHWMR06FC90Z6nxtmSihZXT70VIyXY/CC53K5/IhLCKGE2/nqdfudiarYivcPfOj/NzdEghZEOgJFqV2YJXAKvup84ExPp6EcGt9RvWX5k3j1F3iUKAK9fCsB3dWDWoFyDvJZNnmWWYkyKvtDkB6X+kVtXVVwgPdWow/6mE27SQq6IFy808jBblSTalUuU/DidwpVtfXNx2XmgWJ903kjLsU9EH2cuOg93EH/B82Eki1tooyZ7z/+zk8jZEFRarAk2t99nW1rpFsRjM9nEg8d44ktcGCtuIkXwBlvB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiC5SOn5wx3+AyofS3XSFjYoRsquGrqqghEx28hfyWA=;
 b=lQCTvXHaTt54/4HsQ21wGVDmVIcMf9CBdkm/9rSzZehUSYxwulLPI4tzJw8AQn9wFRmEBYv6VqHindiSTuMF+hhNkUwG1gm6AL3fTAvzcEkeVYlR6F8W6QRGCh/plGMHsHsJiOjPUtcrQbHzGl3c6X1u2cDG52KGavTJzOKCHBQcw3FZcRWCLAj3QtTQnxUjMQvhkikM4/SGMxzbFAvdp6dkVqTUEZK+Em1CW6yD5eBuy8WGA9E1yybdX7pKcDD4htr38utcDYfaRe1qmu74StbyZUOl+Wmwj+M4oa8YIWui9MrQBcPF+n+Lh87MKWwc9WWkkSjc/zR/xLHur+hr2w==
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:59 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com (2603:10b6:610:b0::4)
 by CH0PR03CA0016.outlook.office365.com (2603:10b6:610:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28 via Frontend Transport; Tue, 22 Oct 2024 00:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:43 -0700
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
Subject: [PATCH v4 12/14] Documentation: userspace-api: iommufd: Update vDEVICE
Date: Mon, 21 Oct 2024 17:20:21 -0700
Message-ID: <b4de809fdd8c045cb6a421096caf27ff4edf4ae7.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: a8071401-7851-46f8-2ad6-08dcf22f6717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBfzJHcddq0cpfJdzKaBtBT/5zlt11VOvr8gVX9SloQdnnmxWQgptcMug9Dv?=
 =?us-ascii?Q?7UwJEdff5gKjn8zv54H0AOPfHsmHnJqEsGQWm84Ad2ku00nn+wd6t4NOvdzN?=
 =?us-ascii?Q?1dcq6R5VpX3fNRhou8mXndxDlPV8FmCv8OUlVD17pKK/u6u0gocBDmp0SDky?=
 =?us-ascii?Q?yHUV5nj1moTRoYN+oTep3uYYqBl42vn+V8M9zkduBI6d3zBveM2RG78i6cLN?=
 =?us-ascii?Q?OoWc1kpdvxV/xPS0s6fSsjpDGxkKNfnd+zOqbX1Ub1jsxDHC8omgIri+FC/y?=
 =?us-ascii?Q?DFHWHkQnQyI/tsQV6RhQOgvFhivfbCoZe26yTgBr0OzUJYLztCYI03hF/uAU?=
 =?us-ascii?Q?z3m0qulc7BquiAdQeWz4qEiV39CIKSD+E7+cVazaB4klFl0MqBJ6Mst35KJ2?=
 =?us-ascii?Q?FxB0+7/dW68FbfuZBsaEPXp1eqHQ6eSz+kgjY8YzahW1Q0zO44h1BFTKlO2A?=
 =?us-ascii?Q?IoRZJ5yIdy7yTdCZbGBbolaD628FqjNtknAv0EkjVZMb8byQt3Je/vm+EhvS?=
 =?us-ascii?Q?8KBShXVXKx2KX1OUSUorCO7FuZPdRvuTb9MngGrwHETkEp7ZTAZvLXuMvKVE?=
 =?us-ascii?Q?QudKvxfwN4hy/QYO3kafM4KfC4dv9wYk9bUFBytt9FLQtbE5MVXR6EkL7aPy?=
 =?us-ascii?Q?97x/mfVS0QQD+tkg+kI2vrhdFJwc+S26piFHORN7zam4Fi0uAMeyKMVC4/RR?=
 =?us-ascii?Q?EQ4vwO1G3cKOYEQgYfJW+sAW6pGR8/D96dL7GIbFR5TL13OC8WS4VIKO9DgZ?=
 =?us-ascii?Q?OnhF6VihUX63QcRCCVwdQiSntOyzmXqVj540wOy9uoYPE5545rrNn1BGko4o?=
 =?us-ascii?Q?tnWvHTb5GPQptjNfx8HKZKof8ogIrXWT3xb5u8fsf4kf+f8Q2CLgOxTOdvVf?=
 =?us-ascii?Q?rdd9TDclrh6EcmIRDCmHvb8lE8YqAyKO14jJQ1LZkyKKu0Z20bQdfpmbdffC?=
 =?us-ascii?Q?TzHv2/O7zadG+IZyTZw0Rsxpo/ip4ahCKuBZHyRPPFWtMWOOXAodyNRY2v13?=
 =?us-ascii?Q?3J4gdZ+1rJIA6ezj+cP5shOC0Cz794c0xc+9S//HzeJxo079/yV0HFP1gc4D?=
 =?us-ascii?Q?Ofyc6ajESzrC6ZmBuMpfk0hCYWBYBYMbWlkOv5YLSi4lPD5ajtCO8mYXCc6J?=
 =?us-ascii?Q?er1VnXIzd2oXSP95MZBw+/4/jYlxWcZf9gVVgxppto8WSTMTXJqYGfmRSzSV?=
 =?us-ascii?Q?4KoqPj/7Nanu8dp6GqmfbMQDb5dYHQlgmgGFfNTiNStuLbMz8slY1wVe9YS7?=
 =?us-ascii?Q?Qty05zuP4VFyivrZ4BYP3NCxoBnQHIgxB9QUaLn7WSFl3hRCl2xQRQRS2+DU?=
 =?us-ascii?Q?Oi/IaLSkhwk29WO99X85lUHCeYuXnnnTYolJwDEsJUO4KnhVMiT4Seq3CrjE?=
 =?us-ascii?Q?tsEM+aL0N4h28iX4RrC3Ob+xyWZpFyVoTEX8f8qBgpADVx0K/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:58.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8071401-7851-46f8-2ad6-08dcf22f6717
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

With the introduction of the new object and its infrastructure, update the
doc and the vIOMMU graph to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 41 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 92d16efad5b0..3c27cc92c2cb 100644
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
@@ -133,16 +146,16 @@ creating the objects and links::
                          |____________|     |____________|     |______|
 
   _______________________________________________________________________
- |                      iommufd (with vIOMMU)                            |
+ |                      iommufd (with vIOMMU/vDEVICE)                    |
  |                                                                       |
- |                             [5]                                       |
- |                        _____________                                  |
- |                       |             |                                 |
- |      |----------------|    vIOMMU   |                                 |
- |      |                |             |                                 |
- |      |                |             |                                 |
- |      |      [1]       |             |          [4]             [2]    |
- |      |     ______     |             |     _____________     ________  |
+ |                             [5]                [6]                    |
+ |                        _____________      _____________               |
+ |                       |             |    |             |              |
+ |      |----------------|    vIOMMU   |<---|   vDEVICE   |<----|        |
+ |      |                |             |    |_____________|     |        |
+ |      |                |             |                        |        |
+ |      |      [1]       |             |          [4]           | [2]    |
+ |      |     ______     |             |     _____________     _|______  |
  |      |    |      |    |     [3]     |    |             |   |        | |
  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
  |      |    |______|    |_____________|    |_____________|   |________| |
@@ -215,6 +228,15 @@ creating the objects and links::
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
 
@@ -228,6 +250,7 @@ User visible objects are backed by following datastructures:
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
+- iommufd_vdevice for IOMMUFD_OBJ_VDEVICE
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


