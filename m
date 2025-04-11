Return-Path: <linux-kselftest+bounces-30513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EE8A85474
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51714C1F2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5783281364;
	Fri, 11 Apr 2025 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZSjV9Wu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407D280CDE;
	Fri, 11 Apr 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353526; cv=fail; b=gl31R3NKpMgcq8M1f3HNP/oTjyvrWMsdGTmBq2EEuP6Kx2f+OnWYbRZ5GhS/k/j9E6sJ/qbv8Csek0d3LQRtwDohUNqbyPIezx/cKXNBo5Pxy7cabs6n5qQX2elt7/g+XIecP+jnusNH4gDLP//kSVvKKHqeGLJ779MLImEL00Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353526; c=relaxed/simple;
	bh=3V/VvZg0o7gFWSAa18qc1kRSoOIdvMzu0wovC5Sz/xI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KME8prjiE1zIfmj9BJeGnirBCw0/PkrZFiSsogHEhnq8mTZTsgzIifieiHPbLJrPF6bZfDLp+29NQRJp5dQxYnmvft52xSZgZEga1OUz11C3xyHwZXoRbO8Q3fXWFSgxxmD5OhQlVM+vtXf6HM78Hbk/VoZTA6iZjknDgMBQi3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZSjV9Wu; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdWlCvtBrKCxGML/N1aSI8sPK3MSUk39E7qENng6KGYuYUT7gJkaa2hiUvGgArOUXz+fBnogZ7q6TNFHXrN0d4VcvgfRKCtrUQ86VM4KkT4oMP2Jh2EZ6g0qbeNgfTO7StRNR3sKSk9noT6pHYFO1WrrcJlOyeg5NGoHDbrvQ2WUhfboLMYFi8PU6JIS69LLK8tiLOrxxnN8QMDWVkW6G5NDrRu3mGoyNUPjaCELc8Dyflnfp7AXcloI812HmOVN2bDVc9XgWmb0dk+1qRt71Uo72Jp5rms3cqBZUdRpwN/aso9dgE9KzhR+kvKV0XkUVEFC+wKZc/A2OlpXHg++qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns33MTGPE7nilXexh6DDQCvQ9KgbRxu82R2esO3i03Q=;
 b=KV6oEoVNJNTEyvghw+k6jc0maTM7qqApraK2oFq0YIvqsSReosbqr3jSOZRpqCJ4K4r6OUbui8KPwFAHggAyWoC4xYAOnCg9V9hAxDGt7hhvJz7ZDVM/w8Lkw3bAxdufq7tQvLtQJ42yYw4Xc5inVbgZmlGerKq1g1YMZuSriCedPUyeaL3LJwByfwyxI8BE2/TOEzBt5YHoaUqiWeljCg5GzgsQXIxDWYr0nYxk8jffaIz7yzWoZ5XDKGuY2tweUr/0F23Dn0qzBi0IAz2LoS33727cQ1knFNWdnkJQbOvsefW4GdqBWXq4Ily7id7E4yedxsIjq721+emRKIFW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns33MTGPE7nilXexh6DDQCvQ9KgbRxu82R2esO3i03Q=;
 b=kZSjV9Wu/wMjB5lbtokrWnzVkvhPxekaKhyYoYlibubfDjP2/glf/hV/nZnhY1UONgRIk5OCJH74Lruqksr15/hjENDCT87UWUZ7+n5H9t4w+lpbjpQTAMKHZ18EE1myO12CEqka5+le3IZhtvstFkCgZnloQkrpdDKlOAUNfTkL3yM4cyGTvbtJ4265ajkhVBU9Ozilowvx8NUYTMWCE2wQhFuTwdV6ibZRuF9/dKOwWAVUKc0rWRRcZzwV2zJthsVD8zorIujRBEiYNQ5VgTpPARKmZ5icqAssmBT/JMLHfvRJTVMp99AF2kq7tiZkOjErcT+yHk1E5b4FRMZLQw==
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 06:38:40 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::42) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Fri,
 11 Apr 2025 06:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 12/16] Documentation: userspace-api: iommufd: Update vCMDQ
Date: Thu, 10 Apr 2025 23:37:51 -0700
Message-ID: <b31572a5171b6cdcc6822ca8c100512c8bf88858.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2580f8e4-3a6b-4b8e-303e-08dd78c37ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psknnQyVzVI6+1coq7tzfh1mP1fhjJAqdLi3zEBAmsyTdm1IPW6HqYockVuZ?=
 =?us-ascii?Q?cpevqL90RJZe0Xysj1zN3tpF2PzsrE//CLIdNFWPWwAuS+C4bfXBXM0Nxrp9?=
 =?us-ascii?Q?+5je2lAyZZzKnClJ11lcGbmRYUrUUrXz21E6zgE3j1kJrlbXNG2XrrcBiOaH?=
 =?us-ascii?Q?pes3A48zm7yWZmjqvwETSMDI0xPemfcPPi4SkXKxbxSbgG4kOTZ7EolYLPGm?=
 =?us-ascii?Q?ZNk6F+jPE/zSK4e88IHvx65tTeafiI6w2xiPdFEn+CNGdIxy+79LKjKc2kk9?=
 =?us-ascii?Q?751gmrBRP/93EN4vgOxNSCcc63ef5BCRvCTymR5tWqp80pr54nA0AkJIDxdl?=
 =?us-ascii?Q?rFvRObCXFLpRIHDe5CLfTgaE4+81CvxAeTNrVJL3vOczi1buHvot9yPDmAWk?=
 =?us-ascii?Q?h1xW4aGjSKy1NK5/UU70b1+7/3nJzjaHpO0M/gMHoGzMn3dTKcVX0I91wDzD?=
 =?us-ascii?Q?bIfvYNx+9TyBwZceFWH8Xb3HM7p3hY259TQWCAhLYWE9uWsv2MxHvemtX2oz?=
 =?us-ascii?Q?LDjzYsOsCGsKfMUHkN6e62W0wshsGmJC5KUlqY7o8nGww7CUqGPSmNlMi+1/?=
 =?us-ascii?Q?zlw7sSpruSx16OEtE7XVMerrzNuKhEXriw/gFAYHvPs3Qtl23X3yYvJf3Xeg?=
 =?us-ascii?Q?Zj3Kr0cRe6gZUW1OTzJpuTxmD0IG97iWFDikoHv0IwENK+J5L12VDCbdTmeS?=
 =?us-ascii?Q?dt1YQIZ1uR0KyB3mGdPnU3PTxzHomNcmKWlIpK88KZdFmgZ4USSGdVStU6+B?=
 =?us-ascii?Q?jJezErYCmgFhRui7Q9ZUu4OhS1F74I92KrvUMm0hTgjpzbzfelgDcUKyQXnc?=
 =?us-ascii?Q?aqMFH7M20cRpqc6HOAcMnTcO6qkhfBnzcwEKgBOTUlt0+53RTUJ5EIcz2FBg?=
 =?us-ascii?Q?X7Pun+P2i8TN/KI8580Q0hjX5S1vrzgiAotbcWfOxuWTyHQIWGfzpDxNjsft?=
 =?us-ascii?Q?4Cc70pqH6Eb29DJxMCfh6JL3fxa3jDmgYvxZJ3poYrNGJOYReeUiYac6+OhN?=
 =?us-ascii?Q?FTVJ+kr3uiqwvcG0zIHR4aJDsoFmF877KQz9iG7qvqfU7sYsvXCmbZTDHzEi?=
 =?us-ascii?Q?0lQn9NUuCtfJsSRAyRnz2Ws5dHS6MYKeZvn6aZiK9i9qr45L1QXfclXO9DUl?=
 =?us-ascii?Q?KKf0EBbr1pKI8vJHzoE/F+fJRJvmswjlqYxXhuifQT2nCUHGP1xkYmsqsCMU?=
 =?us-ascii?Q?8RiqUrYIX0h4Dgsk28PFSDvXeP4LZFDA6TXux9SYgkYAn1DCzHEzUnCN2x6B?=
 =?us-ascii?Q?XjgWCQsaSXD0RHJlyQT4cHiuwcABT0/9n6MMU1vKCHDUDMt0ZhLU9ty3k9bO?=
 =?us-ascii?Q?go/Sr2nSz3pMiGC0jcGl0Nf8hejGM/4of5xL30qcE8hwkVB6KxXIcgppvxnq?=
 =?us-ascii?Q?1R8Rn6izAs2O/o7Yz/YKyzlB1P7S1sABIil0FBpTRq/gfOtihGOKDuESjUym?=
 =?us-ascii?Q?gBTwWgpiNj/4CoC95yTzr+0z6pBFLGkuIK63peM2XruX0YZqoY3NW9MR7sma?=
 =?us-ascii?Q?Qo0xpHpZYrlrwE8CwrZc8kQ5ZGhgMwzVqdu9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:39.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2580f8e4-3a6b-4b8e-303e-08dd78c37ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

With the introduction of the new object and its infrastructure, update the
doc to reflect that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index b0df15865dec..ace0579432d5 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -124,6 +124,16 @@ Following IOMMUFD objects are exposed to userspace:
   used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
   but is confined to one vEVENTQ per vEVENTQ type.
 
+- IOMMUFD_OBJ_VCMDQ, representing a hardware queue as a subset of a vIOMMU's
+  virtualization feature for a VM to directly execute guest-issued commands to
+  invalidate HW cache entries holding the mappings or translations of a guest-
+  owned stage-1 page table. Along with this queue object, iommufd provides the
+  user space a new mmap interface that the VMM can mmap a physical MMIO region
+  from the host physical address space to a guest physical address space. To use
+  this mmap interface, the VMM must define an IOMMU specific driver structure
+  to ask for a pair of VMA info (vm_pgoff/size) to do mmap after a vCMDQ gets
+  allocated.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -270,6 +280,7 @@ User visible objects are backed by following datastructures:
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
 - iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
+- iommufd_vcmdq for IOMMUFD_OBJ_VCMDQ.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


