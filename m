Return-Path: <linux-kselftest+bounces-27030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05AA3CEC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C97A81A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E611D5AB8;
	Thu, 20 Feb 2025 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2fvnOKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5401CAA6F;
	Thu, 20 Feb 2025 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015182; cv=fail; b=gtEVuAkPglL1k5Aq1J8YFwG+GE5WMudGK6h+2q8GVziuZqlcdnWlJ2PK2xaF2AWXM9PgoY950fZAQlBtO3KVhbqtPgpMy9VDQxccJ+3JXp0IkpGFS+FpOKT2UuMqiWBbQg/3mcWDt1h6JuoDoe4ZKcYLbNhYzu2eOhalhrlp1dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015182; c=relaxed/simple;
	bh=sYRon+/HJrCTzBWccWuy+WNpa7mhaidtjbrQ0x056Ms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1ts5lOkfV2ry+2VZQ4vI6/Y06ZDdr2rTBhgW+Y65UUJFYUwjSpqU95/L9SKJf6jsDDQ3yCxJFtE48ORk/kN4F1KO+Vxsno1SRFEXdFDdpJURZF+To4y7h+QVaNAewokGi2NpAOTnMuEXIyEXdLGuD0Uj77pkL/sbAuB0va4iJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2fvnOKX; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8xGvXkhxinM4NColIwmBhHU/bAcd1yuk8tiiKgQC/3EyHTXxKryEy4yA23Okltv0GA/aK5JNTPMQBQGdeAm0Rxjlk/TzWAV8aHbWzi+4pKzwkjpOHzcg1E3JYYY57HrMGn40DEUcOp0mMXVgvG9UrONSJelnbKwQRNgTTD5gN8oCr0dqhS19WtISMQLBtWMF3+MAHJRbWiNfd2A/mGVwiCXDTaFi9/Ch+Oa1h98w+dN3NEY2bodk3XHdvjZZYymg3rDOm/Q2lIIzBL4LMNT+NdwA24uOYUDN9coIX8IyDaVh+eznYCpLt5FKlWoe1yjTyXjuCaXZscLwAGwMGfovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLCYXYtRpKzkJpu6B+1wKidLkHriacc5RI2TkcrDdlo=;
 b=HAZaUR1Xtl7S1ZhDlxGELTJGx5xrBqIc0nZmKH5wk7CbvypFnue87AZOtKkdhBX+Cdv7GylCHKd+pE5mHJtx6j2w+U4t+QBs/Ix9EJcGITsnKp7Y0yRNMfCuaXBxyCdilFvpzszd5U3ur6WB9f0CsuoWEudoT7l1L9MFvATvT+liT2JRDZE+QKV7cCM++xa8t9IZzxoCJhAzk0qvyfd5elAyDWC5Zj/g0+rW3A9RqjAMVITfCbOHPiK37hKwKdWf2zwSsgOJEh+15P61z1eca2y5LjkSMgXXLnE5M9pibrDh1gim+u+Yb5MMYRjglINcLHvm7/6EpE/VDa7RZ/J0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLCYXYtRpKzkJpu6B+1wKidLkHriacc5RI2TkcrDdlo=;
 b=Z2fvnOKXGQq0A6CPle13karERBa26cSjG8GNJV8j87Vk3GNgk2T92eSa963WPdL5Ckjj1MQI51fG5DbX/LQM28yF1p6PFHdsZRAUiXt+23FlTzYjLMKAX031CkMcDHfns01nz1sXY7Sth7stwuMPnbcsYOrpLg7lD5/tG66bJvdnikMqu3yQ40QyMt8szslVJMp2MB5uuD+ubH+2GDzksS9B9w2THis9JAnx/JCSp4RhNtr4muzqrVrc8uyfuntjTHzWUxxtaUkNeJC6qMtVQqh+RcLjZ1NcBP7Zdz5Q7juRR9Kp9LcFEC2vCZ0WLaC3cprkjALM6fWori+Wba7KVQ==
Received: from BN8PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:94::38)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 01:32:44 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::8f) by BN8PR03CA0025.outlook.office365.com
 (2603:10b6:408:94::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 01:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:32 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 5/7] iommu: Turn fault_data to iommufd private pointer
Date: Wed, 19 Feb 2025 17:31:40 -0800
Message-ID: <ee5039503f28a16590916e9eef28b917e2d1607a.1740014950.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740014950.git.nicolinc@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 888e6fcd-1e64-4f86-a00b-08dd514e7952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65nnL/2MVEFAuerb8IQjn2bi4fxsxNUxYpbvm/7FlaNDu2C0egEQNBvCMt00?=
 =?us-ascii?Q?1Mgrlnxmdy8eoxA3PBeqD4/qS1S0yzi/Ug/SaH18Jhh5P1qqX1c0n8ssx+Au?=
 =?us-ascii?Q?o18iJJMeE+ygnJ5XhP2LIn6EraCQ+gzfP/DaG65bUPUt2+nzLlsY8ovNeecS?=
 =?us-ascii?Q?MfgDEocxsnhfTmOmBnIz0iEuSVfrM0kJ0XlToZUu9iOfm3YjFtXIR2P33O7q?=
 =?us-ascii?Q?jvjhPX29RNnQ38jdSVwq7KdwzIOBFE432sFONYzIZrSqGEnKPMAs54KAa8Qt?=
 =?us-ascii?Q?nk4oCsjOvtLqrCbcoQjSCLe1Yx5Eg26cs9kMbROmxJ3HQSy9korA1AB2InAk?=
 =?us-ascii?Q?LQXyRLqfuzEenut/SpoxUpF6CnJ+qV4S7SCFgD5TuC2lMxWo+joitLXryokx?=
 =?us-ascii?Q?w9DDeZ/4WN5IMYjouBKkZVLPxxKtTDk8+jICX3JeB0ZtgVHze/Je/Py/oW40?=
 =?us-ascii?Q?wpEx962dq916e7PlIWKdJgZtyZ9C33I4l42x3TZ13QSnYeExhghyumT1fKT0?=
 =?us-ascii?Q?tVueC2qtUlDtRb8gmY9ZW1b1hw9P9O5fy7fkgIqT0ZOx9unrg1i25YVEpmI6?=
 =?us-ascii?Q?8ZdcPYPRaPWLz7bxDU007/+89FR/QJdG0K4MOG+tPvqfCaz0ZaYvJj95zAi4?=
 =?us-ascii?Q?K1l4TvzyAKu4z1y5AXxtRcD9w+v6UZpUk5UWJJ1qncCP+Tn1ofWFGFhJgAG3?=
 =?us-ascii?Q?/iuwxItywTtctVHHnR4Ba32lUFXkdVFAec8NjaXqnNObcsuekgQQjhPyw8aV?=
 =?us-ascii?Q?nPiCfsa1YTBkzWoHlJnruIkNTtdqGiQB1OCGssfJdqj9dBkrOIJDAZyn9z/N?=
 =?us-ascii?Q?2tgMGmZArBrCP7EVmSX094VA2owYXjnNGq4Nj2G3l3zGQOGehzRXuv88XSAL?=
 =?us-ascii?Q?k2JdyEYg6Lkjr4Xxuh/3Zy9LpXfPN8hWmEgxxnfYnYV5LYYVlyV6eE0CCMd0?=
 =?us-ascii?Q?mUsuqTENdYvgdVaKeX7TWvRB599sfI7AzRHTbLx89z0ELD9UeDkKSC5HTyUo?=
 =?us-ascii?Q?t6flWArpkzkVLbmXopuX3VS2dHW0P5p22Ynt7djXXRmkxtR1t6oFWbVII2BN?=
 =?us-ascii?Q?bKWliVigbUilhfXdAR9W1fJTjjFZK6NOfCPFiZwppCxR397UFggYJV+CCilv?=
 =?us-ascii?Q?+4Gf77w1tQ+nNS++3/PD2QTPXi8jmcO/svkeqWukJB49s/gM8LudYd1xIHvA?=
 =?us-ascii?Q?oNnxsDaGkteDRO0Zk2q59MPEqdbdgIvUlpLsrMThpVVu1G4NLfLwQV1vyQUt?=
 =?us-ascii?Q?xW58Bnjigm/jB3qN1sda4GgHY+hXAOQZ6DpAJVQnsp7kQAHwIxYqd02BCkRo?=
 =?us-ascii?Q?lZLX4eKC1Q0Pw7N5n7IuapTSf/tNUmm4YbKl4bQ6HJ6nFEydZ2z3jxPfq02p?=
 =?us-ascii?Q?+nT5ryurLSIIKdhjQBUUNyOSRGZ7TfoVm5I/Cp1uVIShHBMVr18gE8Bq//qC?=
 =?us-ascii?Q?sGaHFF+lI2AVE51wUChzPqRMK6Ef3+ew/XTWnDp1ubwF8lfniPS3gL4qbKUV?=
 =?us-ascii?Q?IWW9Aaqpr3i9szk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:43.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888e6fcd-1e64-4f86-a00b-08dd514e7952
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

A "fault_data" was added exclusively for the iommufd_fault_iopf_handler()
used by IOPF/PRI use cases, along with the attach_handle. Now, the iommufd
version of the sw_msi function will reuse the attach_handle and fault_data
for a non-fault case.

Rename "fault_data" to "iommufd_hwpt" so as not to confine it to a "fault"
case. Move it into a union to be the iommufd private pointer. A following
patch will move the iova_cookie to the union for dma-iommu too after the
iommufd_sw_msi implementation is added.

Since we have two unions now, add some simple comments for readability.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                | 6 ++++--
 drivers/iommu/iommufd/fault.c        | 2 +-
 drivers/iommu/iommufd/hw_pagetable.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 761c5e186de9..e93d2e918599 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -224,8 +224,10 @@ struct iommu_domain {
 		      phys_addr_t msi_addr);
 #endif
 
-	void *fault_data;
-	union {
+	union { /* Pointer usable by owner of the domain */
+		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
+	};
+	union { /* Fault handler */
 		struct {
 			iommu_fault_handler_t handler;
 			void *handler_token;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 931a3fbe6e32..c48d72c9668c 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -329,7 +329,7 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_fault *fault;
 
-	hwpt = group->attach_handle->domain->fault_data;
+	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
 	spin_lock(&fault->lock);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 598be26a14e2..2641d50f46cf 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -406,10 +406,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		}
 		hwpt->fault = fault;
 		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
-		hwpt->domain->fault_data = hwpt;
 		refcount_inc(&fault->obj.users);
 		iommufd_put_object(ucmd->ictx, &fault->obj);
 	}
+	hwpt->domain->iommufd_hwpt = hwpt;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-- 
2.43.0


