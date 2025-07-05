Return-Path: <linux-kselftest+bounces-36628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E223AF9D60
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CCC1CA1394
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9921B9D6;
	Sat,  5 Jul 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TgmDvR7k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C421ABC9;
	Sat,  5 Jul 2025 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678086; cv=fail; b=K+Pb/hd1itC3qzrTPqMBouVqhiUzKM2pR4zLUHSsdFVtnGFHH2xHCIzGw665Z+I7MH7QE2XFccufj6rpCFiT22YuIXTc1QS+fjt1rcJmYOwt6xCwxJqkrp8OZR9vQsRurd/he2DWSGLiZVg/sNzre9/CrHHtl/M+3BqDrsPuDSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678086; c=relaxed/simple;
	bh=D/6G8y8On+326gHYmip5Eq8Yhgz4Vss/ixHGuIOjq7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKW8c49Pu5gOqPU2CTzOsNcwgGx0nwd4nqyOx+GUllUFZgfJ2/7dPNCwRkopLifjuQ44aaUbOKVqxxpVH3dE0vxx4DyIC8OiBG9tjK+Hl1hIY2mgWznFt9mNaAad8bFiiLZTVmWKQU/SPCngwr03PByKosBgVAuf3dNmCBjvoXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TgmDvR7k; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkqFGlS1mTXTjk5UiQuLRYSXuOAG5RTZoq9LkTpaUzGMR1gyY1f9UbltvJNVPnE5rf9qfxZpkT75GuUFBh837MJjAo/L/iYzKxViVbOhohx26TlffZrEmuYHz0a3ZsYH52c3vEdbLo9yQ6qf6OULGQCoYBWDzn8TOxwm4xdgL6nqv0qJ6KHly/mtmBuatOVyUJegoxvKDQ4tKqGnImLL3FJ+srH8vioG+/ksAxWRmi5SgGKazenonJ6e++tDH3HR7zd5e917WcYnlQqHUZbn1pCZE7mWLFWj/4osn/Af3mu27a+nReGodW6U5wn3adJ42rQd8RoNOhakJ2/2qqNmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP4++gMVso6NJgCf4yKAKkzqkAKXxdKz2sTcPjJo/tU=;
 b=TE/wJKBiiA7/zFqbjxjuezWnrprZ/a8a4jn+9VXYdHjG8fwt+uzpH68lyPrDxD85ALlgqaeHzUcVpTny//WOYsuWwFXXHEdPJqtGjh0uQkmhVgOyR5X094o4J/QCEhVQ295Uw5GdrHhOQih6MrDekQllWiP/xnE9QMCGq0fJKLGF+BcGeReDNV2ZMENh/N8heQd7SVfd11AMgGw6Z2gETuGGvSO+MlFWYlcNlBmIrouovMsZ9Fvd2DXvV8YLk8UakAMfb1S3aLSDXHZyWvVRaKhVcn6xnwCzDZypnwKe/nvLzaFO3yNH99031zOfB3KQezGm01vQJ2ntgyG/OENhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP4++gMVso6NJgCf4yKAKkzqkAKXxdKz2sTcPjJo/tU=;
 b=TgmDvR7kXd/a5kR2dumKcOP8SGwx/Eqm5ri6GukRCJcU9hHLzzFHH+afZc7RcpNKLPgOS/B1MbtwjT9L+Gtk2yXIGEJqFshjV7g8MbdQCbw5p/iOUEzoCGr8fFxLA7Rf+asrg5cCs9t3ds/S7gemL9SmhAiwFYBPj+9QarXuCicrvG8+c4Sq4x4+5zSvBm56a7nZicLE8r2ugXWbEPcufst4Ip15XgIybm3omT9OO5t8jdKVCTMS/h3Yu4RZOjlOIjoyHJj8UiTnOhvpG//6h+olcLV1F8vqhs2vfHHX3uGLWhlfeDdtFfMCyjQzzs1eq/bObNFEATI67Z4r7mQbLw==
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sat, 5 Jul
 2025 01:14:41 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::41) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.24 via Frontend Transport; Sat,
 5 Jul 2025 01:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Sat, 5 Jul 2025 01:14:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v8 19/29] Documentation: userspace-api: iommufd: Update HW QUEUE
Date: Fri, 4 Jul 2025 18:13:35 -0700
Message-ID: <e295f071bd5c51e72103532f5eca92c04653daa8.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e550b2-082c-4766-c096-08ddbb615159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrWzIKKMy1685a7I4Yh2NVWXAmlqdYKEBjVEUJzc0r/09gpO3+TBe3YZs32S?=
 =?us-ascii?Q?PbRaM5vV1K1eBtiX5PYksmOOyWxt7IhmYKWF/uJT5TPcQUzpwYiRrMmT9V0R?=
 =?us-ascii?Q?n2RobhDVWw45djyrNVRDVJezH3lRHGrs363jNnn2bptk27VR1Jk1PdHr2W/t?=
 =?us-ascii?Q?0M2yo9synTlTWQk6TW93yx5Q8DOTKctcflnXnIk//PhdipIlK3/kzEC+AcZ3?=
 =?us-ascii?Q?kIASleQ7wXgHrV9kPzFcs5kUasGSZzqzfAbjWuiPuwU7L3aVytworoBofs4/?=
 =?us-ascii?Q?tRdPh8J9sJcRnCALv63Rx/8ilPZdpHNgRBQcK3ct2yBZ2/eNIthAPS57ZYAU?=
 =?us-ascii?Q?Zd/eH2WRPbpXrehd1WQf9CLhX60LHPrS/W1QhnstAox5I3+0TAn95CHwEk0X?=
 =?us-ascii?Q?riXodsTccP5arnHhO6goZHktALzQHoiulIvJb4HuquU2dCEUw5hH0MF4zPxf?=
 =?us-ascii?Q?reouXkl39Im+jXOCfy/pbLAGTgGbnr0MF9+2sj19E1anSs+esyB9mZ1rqGkz?=
 =?us-ascii?Q?sWbK0/orkwQ8xlqBn8RrJlCsbaRVZjOkUXPwKcZH05bxc86ZBY7IyAqQZMrr?=
 =?us-ascii?Q?C36PSvpyGw78dndHdE8qly2VCE2u2GXaYy7WMdmJnejic6jNwt7qyl7NMStL?=
 =?us-ascii?Q?zM8rfBxGIGr2WiJVuyHphBkgn7c1jsA58TMjSLTZCUarv0dOwwqy8HBhFM36?=
 =?us-ascii?Q?+eUY8IdrApaDZc8GuB8nFNx9/ftG/tJhiIBinxlWVElpbDyf3NSuJ4v18jD2?=
 =?us-ascii?Q?cEWXKWj3FduCbit66YUx5dEoVJyF4pHTToUq6B7Sce3iXqJwDlIcPuLj1qbA?=
 =?us-ascii?Q?GECkvpUu+BFB0f+EJGxi41h5NHXKB7D3SQTtqF7C5iwy4D8FfmyxbBOhWHVs?=
 =?us-ascii?Q?ji8T7ZMVYGZdlMFmF7m5gy9MHdTT1KypLyWKu9lBAo2nIcFR5RljbM4S+JCY?=
 =?us-ascii?Q?x+pkE6jRzK/ikoR76p/RSo90ooZKT20IwB6Xvz4czIEJIpAA3l+gYDT3CZ6C?=
 =?us-ascii?Q?aGz3eHyJmlSs081ahJEpyCZLLOQFvUUUw0VYKNU/IzKH2RAu6Sw6CBXv65OK?=
 =?us-ascii?Q?7iW8JBWiVOcJXm06mLYVKBpRk1/pONbZHBBUEOjTrP4KjGt1VDiDZw0+JkcK?=
 =?us-ascii?Q?OIv4A1HULyNs2v7O3AkydfMt7M3HmBYROcZ4RuwuUheATeFsdAPWNPBTLpZH?=
 =?us-ascii?Q?jJ1558uSfNT/ljljZcgvTQIQ63uQYQbaYD7qS+SCQKAA7fJ7JEdhSYrFzmve?=
 =?us-ascii?Q?DB1WTdHBmOa9t0A0abkbmFWtDuiIwfwPxUcwX46JQiAH9h9YNUNYONw/aw6K?=
 =?us-ascii?Q?n2Gt3Ycgcv8cgA2GR9x+4PDin8LsYbrAdkITilMpyRzUPbyMrm1P5Va8/hkj?=
 =?us-ascii?Q?5Ji16HEJPLepWKYEO+wDKtOlpje/MxPrQr0rIy2wmQhRWVMHvP2qf+GBUmWJ?=
 =?us-ascii?Q?XJpFbYsEwB80bXsL+8T13cP0+jLnrAaI6dN5yym1Yp+G6y/eoiF1faNVOnnK?=
 =?us-ascii?Q?dELM/Z63OZ5ZwcbotIFcxqIIajdBYfE9ILMc?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:40.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e550b2-082c-4766-c096-08ddbb615159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

With the introduction of the new object and its infrastructure, update the
doc to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index b0df15865dec..03f7510384d2 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -124,6 +124,17 @@ Following IOMMUFD objects are exposed to userspace:
   used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
   but is confined to one vEVENTQ per vEVENTQ type.
 
+- IOMMUFD_OBJ_HW_QUEUE, representing a hardware accelerated queue, as a subset
+  of IOMMU's virtualization features, for the IOMMU HW to directly read or write
+  the virtual queue memory owned by a guest OS. This HW-acceleration feature can
+  allow VM to work with the IOMMU HW directly without a VM Exit, so as to reduce
+  overhead from the hypercalls. Along with the HW QUEUE object, iommufd provides
+  user space an mmap interface for VMM to mmap a physical MMIO region from the
+  host physical address space to the guest physical address space, allowing the
+  guest OS to directly control the allocated HW QUEUE. Thus, when allocating a
+  HW QUEUE, the VMM must request a pair of mmap info (offset/length) and pass in
+  exactly to an mmap syscall via its offset and length arguments.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -270,6 +281,7 @@ User visible objects are backed by following datastructures:
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
 - iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
+- iommufd_hw_queue for IOMMUFD_OBJ_HW_QUEUE.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


