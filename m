Return-Path: <linux-kselftest+bounces-34991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC030AD9AD3
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA5C3B6CB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E2215075;
	Sat, 14 Jun 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IxYStd/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2331F463C;
	Sat, 14 Jun 2025 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885347; cv=fail; b=a8FbqcomfecgtnylRBXHe5fY+Ae1H8/p+edJT8iMy5yHgxvZ17Inx1hqNoHYreRn0yX083a6iiMMODOIHyI4D7W18yEUlETlWTnG4pQAfyfF5TMzVG81sJPcsDDVgSwd3css7S+oOeIVWhx5SsJ6SDUY9lo0h3gQ4vfXTnlUd9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885347; c=relaxed/simple;
	bh=VIhwPqsq52m1f6G62870cOSeTmlM8Uss8DavRKqqauY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPv9yli0E+yNB0g7YJB373AigwfsfGEWokvL0fAwagX3M6IlJnS/cgtsmKWY5ki2Ds2gVf3FM5oaX8SJmTrenx3Zi2LYCyBdGOIHyciY+zMMyewdsIZXgzYtKXo15jBsF9g04XMBbaElJNe9m/zMopOcR1zwWPWdA5ahClVOtZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IxYStd/i; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq3rO+MDkV5rhtY6Z2XLFyF+WxmzY7q66XnL4H5fBzGFHI+xNW9EWkFoA2QLqsoKHF6yLOrssQ2M7QfWKHS3qAhBUW8OlLbXc/7NqCjILeXVv7EbMqY77RL0QPBp4hjBw2CFVVcTlRypJQXYCce2XM91Pskn0I9c7+CoNxlYBnU09+zOlBROV1Vzkt/GJ33cJLmMxptSUegttoNrqxc4y/Pqd5ivvPlKRmVNJd5GjEH3EF5WOrQximq+n4i2qOfUI24W0v9FOyrrGYs3VBjXBnHRcqXpz0BV6QErzKYFN0jsfkkynqSr/LMTSgUYuLekpfnunHl4cCUw8B4LfOIiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZLdAwqVR1NZBp6GexekNNnUXiB8SjLeEcqHxvbXSQE=;
 b=pVmOLWmFCUS+pPF1EGz+f3oSVQYVPIsElZs3UFsXdFDoGCsTFGtYKH9ItFfEiQpR0v/BwJYx76GOZDTqhNLkG2wKRlCc5LzYPMFyhbXyHP+OCK/JQpSyTxjvq8LMWuUNVg44HwMB9JAk7SvcZBoXBNWm+kd/JNzvMHWo5kJr9S2FXW8W/zeDAeFXjI3wIoZGCje2kIfLHXuls/re4MQztLFS5FLy/o7IjjoEcwyTjjGM6rOXfWCfFB+VyTYfIQjvRDDmiYliJUaTtZYAzWidWJBNaEGtfjEZBrenlrVRj/jV1kpZYQ1xLgDe43p1Gg++lgpDNRS+I3K1uQ3FhyEwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZLdAwqVR1NZBp6GexekNNnUXiB8SjLeEcqHxvbXSQE=;
 b=IxYStd/iHFBQKGTZhKM75+ysGcQo2A0fCnfa9ESTIcOWIP4Vwq2uBnC3Xq5pgd/LA2eh5lry6GFLljKeD6x0JyasLldgG19l/iXKmkxMLKdCHfNaiP2vbMOd+07z/8MqFUjnIK2Dc6yyFfReDOmtIm9KHDSYgQV+3Hq3MFJuqN8bCR2lMtUQ/6Bx/mPyuii/ElV9F5oRjru66QBF1R9iiG2Qw0vAUpmVU5SYjRvUk4OsbWSRfOJGakaqJRz/KYy57q5T06PAUfgEZhp/xsyZ9vdKI69Etei+tsHuInNUnpi5jxZzB3MYLwgyuDCZSO0IQR5HjYArgMXShen5FPsnKQ==
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:40 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::2c) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sat,
 14 Jun 2025 07:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:24 -0700
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
Subject: [PATCH v6 15/25] Documentation: userspace-api: iommufd: Update HW QUEUE
Date: Sat, 14 Jun 2025 00:14:40 -0700
Message-ID: <e6931ee1643d717f13bdc30e7dfd9eeb9fd0fafa.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 145e60f5-8ab8-43cb-5ef3-08ddab1344bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mYzDkdgslTi97Gft/dfnO9e0SL1tI5ovNS4eE3wHgsD2IkXmNwcwFD5C5lo9?=
 =?us-ascii?Q?H3ZdUW4nzAAsoeJ1WB0E1tz25thfM+osgKqtvdgbiJm+EQcNoRRD5BuFiLoj?=
 =?us-ascii?Q?sUxRt9PRawoC3HqLeVW1m6SPQD6Qa1Rb4JlbxGqAJgeYEvRY/eil+8TGOmGA?=
 =?us-ascii?Q?3o5pCT3OQ+Lsris1XplX9qYWsk4NSorJV/R5/RyRrYeZkol4YV+p3564jkpj?=
 =?us-ascii?Q?tn1gNmArV9BtFfc59iSpbvO5UKFLau+d1vcE3b4CppieS3q0wlk77yi+xU7n?=
 =?us-ascii?Q?Pd2h+b98No6b2i97VV+pjYj4qebdZsszbbqhaFgSxsvTy45gCApRtTjh9yhD?=
 =?us-ascii?Q?WKJP9I/k+xRwBNfYVmGzwAjB01gotA1MWTI6/JhzVo7x93Y1Jl+iKpIqM5d3?=
 =?us-ascii?Q?CJvXivvAhqPrQ/sGYD/NvTi9Drr/QwG/01G1mitisyXKqlsLEQaI4S+tFrj+?=
 =?us-ascii?Q?gH83g3N7ugELvUtUg0N4RrZCscFuonKH8Pd8mmQb4eWefGGQphUhUWbEo7bE?=
 =?us-ascii?Q?SFtbSxPANTJef3X0eUhKixCk6vhK4eyXwYo3J9eM6WFYJFhJUaXnmQnebqNp?=
 =?us-ascii?Q?8TOWnNQD11hvemEBgIqUNf9UBjgolNIPFZs8dioKQgymOvC1lg7CJdzls4x7?=
 =?us-ascii?Q?BXexKi77L/nsx8VQwlEPPmXURyy7yAqfXLVzcVxLiHYPlKiHpwSmoxJTJXWY?=
 =?us-ascii?Q?Q5GU2cMYuXkpV7nDVAsKSL/BcAvdRc3ZCBYnxfAr1/0Z1DDREt98MlDiv6X2?=
 =?us-ascii?Q?0uX9AXcOXZpf2QvXY74K0tJZCSJ/HdwWoYA98BPUL2ofVOM7zXQuxG52WI7s?=
 =?us-ascii?Q?Ofh4sO+wH0qe7FmbrG8KD8I6tZUYNWoc/iuom86rgpspr/M4o8EPauXCzX5k?=
 =?us-ascii?Q?BVXy5RIBnINyzjJUkyh/XNnRFj36xMacW5d9fiNd3IDbaTGY4AaVdBFlycvh?=
 =?us-ascii?Q?dV9EAmtMtWLWHCTum1c8AFZRifEvT1LpeX8fyzLlow7zlvumJHl5O0yuIvbs?=
 =?us-ascii?Q?3TYX+83D13dX4IiJSA28ijM6XwLwrzQ/Tvrc9KO/IebvZAH+1aA0X67VnwI5?=
 =?us-ascii?Q?wkTKE/F7lCi3hYHNX+oVOHJVoFwOb8CCsAIM1QZwE9yFTxwqGi4gDS6L/g7I?=
 =?us-ascii?Q?mMQQmhJ4yVnVNa5F2E4f6WcBMQDJZW7XtgZodOozUkfmh2/rPWiDeY914zpo?=
 =?us-ascii?Q?lLOiYLCobnGYXNyL/E3ttkGo/Srv0+fWWprOZb5GCqY9DUZsMmyfOQG6WKVo?=
 =?us-ascii?Q?mqswNwccnNhNU0WUuv7njxk7xeDa+hnkr46NEB9TZzK0XY0Jyjn+BteKb4GD?=
 =?us-ascii?Q?8Ed+IvCMgEYPeBEcXJaohoj203YzTWzo56Z/bvDxJLMy3ryCo8SSw7QFDTh6?=
 =?us-ascii?Q?A3zBzufQQ+eO9OH+YhU0SL5r6qTodhVCLVWGoVg2iyLv4wrhmG2zFmMddCDo?=
 =?us-ascii?Q?mhM0cYzrhwxJ+D8XLXNhePRn4B0HuPtl6Jawl3toXR+9oId91FwuoTmNlxMD?=
 =?us-ascii?Q?XtgjojNBy8LOl4j7CNt1B5WGjoDjEyjv5oSz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:40.1527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145e60f5-8ab8-43cb-5ef3-08ddab1344bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

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


