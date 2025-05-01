Return-Path: <linux-kselftest+bounces-32127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2536AA6724
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF5A9A3C85
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A7B27CB26;
	Thu,  1 May 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4FuNfPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95D21CA0F;
	Thu,  1 May 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140554; cv=fail; b=JQByMQnfATyIwGl/Uw8v2AHbSEJKe9T8MdUt7eg1fDeNVonfgo+LrcVKrsUZru3oSrqxuVFToiWP8jO8L7cUHRaJmWxYbj9obugNvatbhdXGkR5iCo0JHUgTReyFm0BDMrrO0kRmn2xFmJ7yWXbO6jpTBuvoOGKMMZUIRScBXZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140554; c=relaxed/simple;
	bh=aQTHpxWBuipHlo0UQk/86pezvt1xjHA2s+KdjbmeR5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ov9wEGCpaiHVkpk9BWEeWRUXOYSrwBoyzHjxLVDMIL37CjA7sjeuYxsibs/59PewUuQZtqjUSoH2OqCPXbXmqUDistf2ydZ6ypkPryLvpxXEMW4U84kPCZQ4TU4EpUvnCe2AJYqGCKrCGv53qj1r1mRCCM1peDJQjPKBE0RSfEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4FuNfPZ; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoqpq2S+tHIdCXEZhGG9eskkEgx6eVOMWbmRiKlhWBcqhbC+omHdRfcGSOllv+5KuJWQyR+/5Je86OQnOZc7AuMYCbAEqp8AumsyjgLii4+ePpGJX4xuIxnEJpvYUQVO1odsHkwsVMu4BJIEZr/i5ruMRxiQkzxx7j0PXnDveLeRfAVGyqlOW0PcfxK8vVdP/9pDLKYRJIj6m1VprDt2hI+qEGVdP/4LWVokWRveZhXrsqHQuj/tsvYl3GzRYXX1c/ffBUcY7VVZ515/IWGZGhz4LzxxoxmHksobuOoyVqlkUN0KVpKB8RPSRJU9zViAnhXBOCGQwexmgrXOX/kU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF2FUsYuFmlbFr46eoQeIQ0QTXGOKgMuyt6czLv8fcw=;
 b=JlPH7M2EhugGzAdXCLaBXZVFPrebRRGUMzYiDmFHnvWpq1RLK0Gj5TQFfAqtjEej0c3E/1S8M4sarf98KjIdTSEJ7tLBqmQTS3BeI5SF6EVzdilP0j90PZD+zoF6LAfhP4CizFrOvsy3+Dfkhx7e+Uho7OnsNti697qusjR3ri6hT3BucBNfzZnLNbbNIx52kDlXFtqgS0FEca1M9R57Q7NNjTqskUzGiZr/yzKAiqdgAFksEkyIAfTZFDFrR0mZBMGDBdOWOIGQElwtZwC+ZwpECvSUeLKrzSthrH739YN++aSaiGrh9IVITh8+tyX3WdyMXg00DHFLsnrkFTY/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF2FUsYuFmlbFr46eoQeIQ0QTXGOKgMuyt6czLv8fcw=;
 b=A4FuNfPZ5pD5uqltT3LslKlwU4POJ992pZLMLR7abOnEzojNaaFVt/0NvJKUqloPQkBw0ASjSjExJFJtzCrWAESn5dKmIHJ2XAUACRFIhidgFE+De6Z0Qhcc46kCOTjEzLGN6ilKr6WbF6pw95hTnwcw0DL7XcKf/rPLx7DeoZSYFVlAcj8fVfwfxVz04jjV+cWisyeIAWHIN3u5nPH8nIoiev8HS5AH5RhBzwZwxNYN6wO8Gy+FaYl8DjD9Q6VhVDNrMfZepIyqp60rxI2THcxUmhaIYSpUUSJOefh8oGWbap8ufh/1w7kDX0HTjPshOGlNtHrtzeS2FNuGbZn4jg==
Received: from CH0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:610:77::21)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 23:02:28 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::aa) by CH0PR04CA0046.outlook.office365.com
 (2603:10b6:610:77::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:11 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 16/23] Documentation: userspace-api: iommufd: Update vQUEUE
Date: Thu, 1 May 2025 16:01:22 -0700
Message-ID: <0beddeaaa4a8a7a45ce93ff21c543ae58be64908.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edaf2bf-e0a9-4a28-e1ac-08dd89043ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AoeDm6P/t+RkpRaCuqa3IWJdMtTuSiwwl5jxgOGGft/hS5cFtsTCr/zgtCaq?=
 =?us-ascii?Q?foGIvRNWOqdBhiGFiKoJb8rELYWj7dALuctX7ky3/ulguhsmKO68TBkFfaJ9?=
 =?us-ascii?Q?h0b5h2VY/k+Ija8Fcc9PFYRsgFlFiPG8aPk3t4IADvj4+eLjJm0hLNsGSK6F?=
 =?us-ascii?Q?ifla1/06cnguZ8xtludDitb/xkydcKxXe7L6Ms3e/nuPvyGPgHyMA1HMgxPI?=
 =?us-ascii?Q?yL1adpLZyC9C9RxMXVyjLqD5QEQRbXwyvlD8kO78stJn+FumC9rFsaIseejz?=
 =?us-ascii?Q?WsWhe1h4BJMLUoOsa3Pan/vcaHMKlwuV/sArNHmR+y+aNkzPEH37EF1w4h4c?=
 =?us-ascii?Q?TqS6SSvrQcMM5vki1yaCbs4kJfIv+jUFhuUnXy0oAKgcky+wn4Gyq3M6juDR?=
 =?us-ascii?Q?bq59ApgN6pAdP8pJzPQGEMEcvH47iHDfnqgAVeySprrs2p6EoijXX23EG2mE?=
 =?us-ascii?Q?fBoeShWS16WZsrjr+8Mz5aDiham6zp2OAhlKEtnex+gZQtpwt+Xg5GhoSczj?=
 =?us-ascii?Q?5yLcUx86jpC22XOljWCe7j0i9aJ8uUYH+TGuxOi5FTVfNlyZTLbbzSV9kVSU?=
 =?us-ascii?Q?jXg4ZIdLqH5StK3SUoujtWNv2r2IddEGP3HW019cpVcasoMrlfXvuy1Y52Sr?=
 =?us-ascii?Q?hbM/c7PY8qxP8b5CVhqT9ZLBmIUMpjQIA29hypjWQeMJLiSW/mpxKlyKqsp6?=
 =?us-ascii?Q?+bTMBNnBUiLmvkKIsKijlICeBI1qHhKmaT8kcpyuBfPKutXDTu15Vkp/Uzx7?=
 =?us-ascii?Q?2xo/j/KTgFTqUEEuwRQ3ZDK1D0GRQBJLiygoUNwxcbKgIHfrKp9X298qXa5D?=
 =?us-ascii?Q?EYpj+RjnMcnrQ0K+bWso+zxDpuo2cJFFOUQxT8B97HIrgwUY3WrmACs1WKEa?=
 =?us-ascii?Q?En2WSDmyTBGOd86FoczKYmia+HSJoBYMltEv4B1IRHT7vq8ky6I/9VypFKmw?=
 =?us-ascii?Q?MN+gkycCzCH/NuP1k6kUq48AsKYdWKgMW82xnyzVuRHZTMS1XXxATATRI9QA?=
 =?us-ascii?Q?tyZ+UfkKkKsgVUBXifahEnkM4JNTcUPY7UOSWR6+annEGPik5XIp4uLPAQtD?=
 =?us-ascii?Q?9KCF0ixvi5E2VDZ658niAuQOaB54VyJL6hqxj64jTIUlWqp3e8a27NNsFsSC?=
 =?us-ascii?Q?KhAmXauTFClLcHGPHbzhPRs0RbfapuHsQ5dMPSNTOyFZDPOVZRGEkyBzRv0S?=
 =?us-ascii?Q?4c/is1iOX3vnLVqr77ON/q3BhUjccDp/HN3wZFyrhSpA7fGMVlOwiwNzc/i+?=
 =?us-ascii?Q?aS+lHa9RPitSRzjWIh5fFSwZ9nguXQRkbo5TQEu8+5Nyqe9dGiwkdSStKG4Y?=
 =?us-ascii?Q?3s3e7cIRuVoBVdQ9zXvxl8pD9TqHVnjNvg+qY9nqhuaUay+7FmGDA2TWyeXy?=
 =?us-ascii?Q?h7WKXLRXDzi0MlOuWq7IOCedYGdWb68JUbyyV51HPHgMPMm7PEj3LKo/v19K?=
 =?us-ascii?Q?cOBTgWhOv0/KOacfkZOxFsI333nNTdag/5QnAzdShU7sb7tWR++9Jdf9r5zH?=
 =?us-ascii?Q?XW3M0Bz6IaFQhV8aHoniVd2Im0gobQwiByPY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:27.9072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edaf2bf-e0a9-4a28-e1ac-08dd89043ea7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

With the introduction of the new object and its infrastructure, update the
doc to reflect that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index b0df15865dec..ed32713a97a3 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -124,6 +124,20 @@ Following IOMMUFD objects are exposed to userspace:
   used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
   but is confined to one vEVENTQ per vEVENTQ type.
 
+- IOMMUFD_OBJ_VQUEUE, representing a hardware accelerated virtual queue, as a
+  subset of IOMMU's virtualization features, for the IOMMU HW to directly read
+  or write the virtual queue memory owned by a guest OS. This HW-acceleration
+  allows VM to work with the IOMMU HW directly without a VM Exit, i.e. reducing
+  overhead from the hypercalls. Along with this vQUEUE object, iommufd provides
+  user space an mmap interface for VMM to mmap a physical MMIO region from the
+  host physical address space to the guest physical address space, allowing the
+  guest OS to control the allocated vQUEUE HW. Thus, when allocating a vQUEUE,
+  the VMM must request a pair of VMA info (vm_pgoff/size) for an mmap syscall.
+  The length argument of an mmap syscall can be smaller than the given size for
+  a partial mmap, but the addr argument of the mmap syscall should never offset
+  from the returned vm_pgoff, which implies that an mmap will always start from
+  the beginning of the physical MMIO region.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -270,6 +284,7 @@ User visible objects are backed by following datastructures:
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
 - iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
+- iommufd_vqueue for IOMMUFD_OBJ_VQUEUE.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


