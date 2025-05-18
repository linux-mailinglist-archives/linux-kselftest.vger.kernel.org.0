Return-Path: <linux-kselftest+bounces-33271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE91CABAD60
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6403BD2FE
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41A2206B8;
	Sun, 18 May 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZfIuwal"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E91D88A4;
	Sun, 18 May 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538568; cv=fail; b=Z7pVyI5yuMDUfTSukImIa0kbxs+hIqZhJcCugmy8x1Ha2N2psXadbqMObIGHYgskT2VOUhlfZcY19klsVJY4PUyDdB9a3C1AwG3ifBbtUP2sBmDcEeD210qm1KJbf2zyXcwsOGwPxQ8ZTAXkv9NcnfJMO19J1GWkct91gwyU4R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538568; c=relaxed/simple;
	bh=VIhwPqsq52m1f6G62870cOSeTmlM8Uss8DavRKqqauY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVxZ7NFLXxYBRxyG8axGUuYMv4OujKjZB/G9ih63u3mJBzK+naWYj1ig03RCdFWvZtCf7hrdWE/py1IpmZ1DbVRhiUfpA7zaKgqxf5TH+eawqeotlLVTTlmlbBCR+nBkVmvz6SUYCKpUxfhDRPb/TWH4JDZN73jbcG7cnKa91II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZfIuwal; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6RDUNpij0yBJWxwWCZHvMZMdLak0IAzSol4kdYjoMufGX1HvrQbn0/xFgQ5PR7FPBtHzRubK5/pIIyDt771ydFGZSvIaBxg6shqrWOe1b0BKhYNSv+IN9c5R8YSrY4ASYZlnRm/ACD46pEL4WeKcZigTU9jW8ZXSG7+APax12EzvmznKZbjwT3w6AsqWOhN+o6a5TaeVEUDa3QvZSfmVqO0X1ZO/ccVzzxhIFbR5uNBfnmiB2uXAzT/MIukq0oETKA1bIjidZ07hHBun1ke4bQqBOPmrz7CGNBfBlP+C85hzPEo9BXRcQOOD9hBDtXLWpWWvpQprO0LDyamLZfh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZLdAwqVR1NZBp6GexekNNnUXiB8SjLeEcqHxvbXSQE=;
 b=V52ZhoMbXKZl6F3Xz2Vj+j26wDI4YK4DrZOE9/bxQcizYf/u7TmDCXmMItOaXt8nGeK+HyMedM9W91ASM3UjOKn+zxwrJ4PfjjuxL78ixilyup7m4gZ5wuTW5/CogEcX519mP16ZVktvE/JDab7UWxhJDxTN1nTln+BxPqm1R1F+Ipxfp69Hs9Rzbg0sUnFNyUzYnJf4axVfgHvpAFLTqeKF1za7UL3GlBg76YatJsj4JfCtnxnzTUDK4m+YMGo92Gcj2tIXw/Wheh4ApRKdRFxAYBKTFeXPpxbh65oSjUPhcqoyk8eqCmu0yt6msnD1NRRbji0tnniT1zdKagwvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZLdAwqVR1NZBp6GexekNNnUXiB8SjLeEcqHxvbXSQE=;
 b=gZfIuwalI1/m12jVe8VLtkQVUhQnOOMgckt+DqrGqGH9s9/2rOKxRsO90yjfvSNdsNcHTSstLG5KgpQMx0A2QaT6gcLE0Dissq7LSCUdz7tEj0dHvUC8c3VeBYtaX/HlJtulEucVvc38ogwy8loZAWFoMHLW11aIIOdad3TJpypvPfhyyYSUdayQV4JELs1dyOK5ma0QMu8Q6+Dv6A3oy/bbrfBztX1od+eLojmUYl1ijSb2YZwg4C3MTeSXdexynkOiBXOYQ8rncMJP/jpz5oz1BjYjxzc0hc//TTlRAVUE/a8YngSvjaZrTXRNiezLaXOA7xE6Qdm32qkp3oSx6w==
Received: from DS7PR03CA0297.namprd03.prod.outlook.com (2603:10b6:5:3ad::32)
 by DS4PR12MB9705.namprd12.prod.outlook.com (2603:10b6:8:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:41 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::bd) by DS7PR03CA0297.outlook.office365.com
 (2603:10b6:5:3ad::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.18 via Frontend Transport; Sun,
 18 May 2025 03:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:29 -0700
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
Subject: [PATCH v5 19/29] Documentation: userspace-api: iommufd: Update HW QUEUE
Date: Sat, 17 May 2025 20:21:36 -0700
Message-ID: <852461f70d6ff3bc1c3c25bd67d3598091dc80ce.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS4PR12MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: e8586bb6-232d-480f-f539-08dd95bb3fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpp2CBq7llO+AEu1M0ZDhgQ/uApCZ26Q7BJXYXWmAvNshGumsEgk3yXvJ2uj?=
 =?us-ascii?Q?WxtQig9gBZY1fjypq2zoq1LC/+A9Ll89rD6y11gXsXEc06yhJSOC+p5p0msR?=
 =?us-ascii?Q?Hbx6zQX5znFdjDVBxI6thMfJ4Z0L3UZJEo5rgZb+70rrJ/5mc4da4aurAz+e?=
 =?us-ascii?Q?xospTQ9Oh/zh0Dle/LXGMceXvVC7Sb17tejL3nZP2iGKCSMl7lJ1brpW/Jz3?=
 =?us-ascii?Q?FYmb8doCJeZiGd7kHivBsl17XUB2H3K57TKQ5U14Rs10DhSlUgdcrtB/7/mI?=
 =?us-ascii?Q?M4laaeVcGKn78ckRJGXlIdTMqroTAFl+GEvRHQ0RsZhcOIeLr1cgdfYIPXBT?=
 =?us-ascii?Q?4m/ECM8/A79jldDWFNbe++XTnv8lYIoFmEOlsi55+vUTV411x1gxAfbu4RbW?=
 =?us-ascii?Q?0AR4aG8RM9ThocO9e75zEXG5YmMYMRa7FS2HnKwDdcgoZReNqOA0I4zYfOlC?=
 =?us-ascii?Q?lTR4y7L4qq33IAVUfitwoVPe1Va9Dfk/OuFqMQbIHn+Uh1E4DU8rAFHKDeV5?=
 =?us-ascii?Q?z2sOv9/9jFCIzF340ZaLkfxIUl+nrzXhr9Xowzx6gMNkmEu4W5XUScB8SFXQ?=
 =?us-ascii?Q?cMh1ysM+81SyYfCPWf0Qx4ofvfO9pdwhHqxMxS/hzcy0P8dCfcCCd+uZgwPj?=
 =?us-ascii?Q?XTS1nGZzEGul6u5a4UYnlkyQUHpvD77XKK5vankHWK30/J6dut60Z/sQzmi0?=
 =?us-ascii?Q?P8YxPXbwR8ZcinIuRz2iZq4jkJokcxDcudtSw4fbWQBExKHpXqXVIrJHws/C?=
 =?us-ascii?Q?sxzUzAvgxPgGfepCALc+wZVTAdLEfyx4mksyAKEEemrqLG+s6q/D7JTxuTHX?=
 =?us-ascii?Q?nXeSz433Um69Nu4rJMf3fLZbuJTDoDPqXkXh8QNUz8VBN0t0lSrJa6bSxgzV?=
 =?us-ascii?Q?jvRV/VoKWQscM5W1eU0+phJbV2aC3kATBAiigWfIlmqRQZOxRFImFHNhWAB2?=
 =?us-ascii?Q?R3mCCs85X+V/STNO1stjC9VEOp0kkTpjIv/pOMMfBhC24RjwSQRG4T/2Pgh3?=
 =?us-ascii?Q?aQOwvHQNkZjZiNbKVasuMbbfYLgisReh4/EniKZlOIYjQJ3gor1ZnBPZdDav?=
 =?us-ascii?Q?fhGcPAetcT7CjSgO/pu6OkhVuyQX2sFfbeEuRWVKjXVu8jkpIzt5uJ7Zl7XT?=
 =?us-ascii?Q?QvJ6CHcfDJfVUDpRyOSeLoLigOqnVEjhNbjQ3r6toS7wvdCl6UbcpzDhDHQW?=
 =?us-ascii?Q?s/vVksegcU+zFzDOc4rJiCh26XvgeMuCDkYro8PfK0u33Z8JZW6dtPC5kgHf?=
 =?us-ascii?Q?qcVT9RL2KQOUNScVfM5OpFcfCivYj3PAwmQZDZLx4FOKeaezLqQu2LijOK+0?=
 =?us-ascii?Q?1V8nLwWjqnW+iY7RtMWXmy1W/Y97GxjABIyOxYn9cQJ309NPwELX+7KbCTTO?=
 =?us-ascii?Q?mixbh4acON2tOVudn+gfSv/jiwP+kHTnHnyi+LUziVU4d36zGqWXK1veSG9+?=
 =?us-ascii?Q?WhJ3b6FZeTjQK7HMXegyz4ExsY2XzbkkZ97ov44VJBNGZpyTGVAslbYZboxf?=
 =?us-ascii?Q?0EoMFSunSnm6uHB1WiX+ZapgTPJI9J7A7Vbh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:41.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8586bb6-232d-480f-f539-08dd95bb3fba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705

With the introduction of the new object and its infrastructure, update the
doc to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


