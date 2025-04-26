Return-Path: <linux-kselftest+bounces-31680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3FA9D7DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340EC9C4B83
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93551F5619;
	Sat, 26 Apr 2025 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PaKUdnKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74521C84DF;
	Sat, 26 Apr 2025 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647156; cv=fail; b=RIH4QyX6qjf4o8F5RV2MHdKRBc074OAVDgR0I0aFGuW650YWxoAs7psby8wNRDDsj/2SAmUimBAjpacoLU9YskoOb9reX8kFkHsMimHUkFqDGzS36Ebca1A+dkV5IPTorHxR6bR4Cs5c8liKN9MZ61OgXJVhPJSxP2eCHo0pv6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647156; c=relaxed/simple;
	bh=VgaGOu1DzmfBIh8hweiGzngBrqWpOxaEDAKCNO7FqsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVShztspqnYD5IBGd58TmDGurVbUGCCmCQzzdMAN4bXkQlgngCFxadvmB5qP2QL8qVHyFnVcKtlb1Zqk68tGqy1stDsTImFE5ibeiO1M1WJhsPqpto7GPZZSi5/20ubP89sygG0ps7o0t94QptfgCx5QFiu0Xqq3JgPKxPQGnl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PaKUdnKw; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJFQIQFw12f1HODYBSQ2sY7vNWVgXjVrZeUFcPZYJFutcx+TnZB+aAzFsIHkbRvT3KxtvIjFN2kiUXfSaRPfZB1HXSZdu+EIeJIL/8TasP9tPZkvKBhVR6Bdtla4rnnQ8xO0jJm2DbWpHsIY46ZsByql1W6u7j/OdXq5iQonH0xs7Jjy4SBKVtsEHt8y/w4ve6Zq7jvIjyB5JX4rvUDtf0SI8SGfsOOy+LqGiPvH8ZGmVMYTdbXDIvhJwU8G3tfTLQzFzyUqQetbAneIqlOR0msoq+wO2wmATJGybKQKsSASZdjkmDt500lq8Uk0XOxt/Ik9MiPmQD956c8gnWpndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzGVk+RHEZSbqHf5Q85dP62QEgMuWYXJyTF7PY73O7Y=;
 b=VRaKd/PlYOaAgrNL51batKlRDFnUoJfhif3UsJGm95P5BQey3PL592cjJK0k3Bt3zMaks6NigNqWeBWubn8wT9371SwBkSooC9flBlxjr/Ld8eRMseZWNwdgEAOzYSM0+hI49J4LEMQj3L+o/Q3iID5u7hYYcRtiBGnvz2jC3+JINWjfDkElMIoZLMdVZ5o9NI5EzrpJ+Y+tUjeEK7ovw8w5bKEupPWL8u8pEOPXfsfO5YTlpctc4GW2Z8igU8CsIKNF8z8GlDI9wCsieq3ZlQeAQOuDI+vjOoj2FhWuJ9CcO0VF8m/v+m9bk+AZhDeiZ1n4E+iXLd1eTxU2t0HELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzGVk+RHEZSbqHf5Q85dP62QEgMuWYXJyTF7PY73O7Y=;
 b=PaKUdnKw1+s5rNGjsT6Z1ZMoW9k92BX+Ljro7BXp3tAHglQ11UNfZC1IrNc7R81hZ4gqkva0RsOxQuJDMjoQlO66+Rapf8k9TUOb9jLgQRULwPbFgNR5mgKPJEpWRL3wwTIu15ovC3uvayijUs2C6Ebivu2Y5T2nldfDfhM5PCCHRA3sdViO15GwTnDiL0BaIyvxFXx3uN31aTcYzumn604hqYSceab3iOFh8zI8pu0HdIlgL4uM/E+/lJH6NobkXh+f2MJzns2f4eYDF1s2dZW8o/itpgtQSPBHo3J3blg07ATrOeuodgD0+57KD9VKrB/v3JWw6fVk/cKOwpm9aA==
Received: from SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::24)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:08 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::db) by SA9P223CA0019.outlook.office365.com
 (2603:10b6:806:26::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Sat,
 26 Apr 2025 05:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:54 -0700
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
Subject: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
Date: Fri, 25 Apr 2025 22:58:03 -0700
Message-ID: <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 87272f91-d96e-46f4-5674-08dd8487757a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeS9Je2l6XcF1CHNhfScSreVl9rQ7+QmtkDyqH9VJrmAUuK4fb04z2IaFohg?=
 =?us-ascii?Q?rXGbjDn+ItUUDbIZYslkuKf/3NA60yMEkPrwanfCMrK8cFWsaWXrI0VgTP2s?=
 =?us-ascii?Q?t9dUcex36hR0Yb53TjVk6hf0TqqtfEHzxgmC+6xJROmOfKONMeyo8ryiMpgL?=
 =?us-ascii?Q?bUQDoZ04oSd4La+K4noRWYMM/ETarNf5fYWPgy9Zldp5+LthwL5owS9itQ5C?=
 =?us-ascii?Q?tqsh8kO7HjvtNHQWDfuXocB/zxf1Lmy2h86i8ZES+nhzcUpSd6RevzIePZK/?=
 =?us-ascii?Q?2+nYp8EW8jyMfnvyYhnDUTwUkj03Ci72kAtNzOv14470obYpHvne0QzTUbyy?=
 =?us-ascii?Q?UecXcBAFyT4DMZeTyz21THvJ4ajFwZxXO/7Gd9qTmevEiBHx17R3DnwtNHGj?=
 =?us-ascii?Q?v/Lag8D9GMAeNMFPYMhDp7SDGYa/UAuiedsfx2l8xTrc7coLiMcf+Kxz3HNF?=
 =?us-ascii?Q?+Sof0JeuHI002rKqjXHZtjTLHq4dDS1UjSHSPSj4KSW7oiosp6na9foLptbg?=
 =?us-ascii?Q?FLae8mYIklE5712ULRiH3fKrnLoCDYVt4AYtWgbGPIXzPuwqufLL83h/Ltjw?=
 =?us-ascii?Q?akC7TtlK3LzB9C9EytwqtvOHVAUi0vz+CikmrNEZkFhEqTarTpcqti+/ywo3?=
 =?us-ascii?Q?D3iT9mzdNzofxKojPGh6H386IxMHz8ZH7dC+q8Akd3jrth+2oiSOuyG+h8Fn?=
 =?us-ascii?Q?5sIkpyoFw4Tolgr7OIfgvQisSzOy5dMhD6aG1QI5iAYtoFSaFQBvKE80r6pU?=
 =?us-ascii?Q?LO0ppY0AeweooewL/UThqYnL3evB1VxdHR+pLmX97w1udUSr1SEtHm2PB9mT?=
 =?us-ascii?Q?MJNwQupmV9NQqcaTu6yTxGnKcbwxISL3uJoLfj+ZORvODrUfOO6CcVtW/PBe?=
 =?us-ascii?Q?4qyEoUjtz1lxoXHXgtKDadyWE4lH2116CtLzuLjqgqn8PhkG02lAbBiPNohu?=
 =?us-ascii?Q?Gb1TDzJez4mwI9WuxxMUpEKW65ZK7ZpchmtbmVFKOoPgu5tidLChkUwGpo+U?=
 =?us-ascii?Q?F6J/Gv6R9emLx5R3UMi0AeFlgcqJ9UC+8dDZCygafItF/MirsvyZXEXiM3Rp?=
 =?us-ascii?Q?sNKvST75RD6wcEMcGO5J52zf6GAck45HSOjO9LKl8bUS0V3Y8qrK6vSs+IEZ?=
 =?us-ascii?Q?2PU4JHkRZTITAkzM6giFeeEJ8hxoCjRBqyrhyV+zNMNgjlSSvdmVldV8wLzD?=
 =?us-ascii?Q?HJ0nUKXSTvn+uw8zEyohaq08B8dTuFfVvXoByP+4GxDrnjwBTR/oVUSqMB+T?=
 =?us-ascii?Q?+BkJqDHQdS3EolbfF9CYJ+4uYDwBAVbOgt8DnwBXSyqLtWcjHSzP330qjQXS?=
 =?us-ascii?Q?WsNI4UPoIahhoU3QA6lM9FC4wLZQRsrejJiF9FVOzXavS3gCQczPClgOPXOp?=
 =?us-ascii?Q?dDyl487j6uIeuiKgKWgWPGImt4ogeb/MtGuMXP9jvnopAzDBSv172LRzubG8?=
 =?us-ascii?Q?/78Sryvt1FCP12TYPdpk4hevtl6QkhiGFSuCuwe3a9spFDPfVzILYFMHOzx7?=
 =?us-ascii?Q?k9xsqMbxSROJ/idmYK+wpqta6/nLaeqEUDki?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:08.1319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87272f91-d96e-46f4-5674-08dd8487757a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

The new vCMDQ object will be added for HW to access the guest memory for a
HW-accelerated virtualization feature. It needs to ensure the guest memory
pages are pinned when HW accesses them and they are contiguous in physical
address space.

This is very like the existing iommufd_access_pin_pages() that outputs the
pinned page list for the caller to test its contiguity.

Move those code from iommufd_access_pin/unpin_pages() and related function
for a pair of iopt helpers that can be shared with the vCMDQ allocator. As
the vCMDQ allocator will be a user-space triggered ioctl function, WARN_ON
would not be a good fit in the new iopt_unpin_pages(), thus change them to
use WARN_ON_ONCE instead.

Rename check_area_prot() to align with the existing iopt_area helpers, and
inline it to the header since iommufd_access_rw() still uses it.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |   8 ++
 drivers/iommu/iommufd/iommufd_private.h |   6 ++
 drivers/iommu/iommufd/device.c          | 117 ++----------------------
 drivers/iommu/iommufd/io_pagetable.c    |  95 +++++++++++++++++++
 4 files changed, 117 insertions(+), 109 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 10c928a9a463..4288a2b1a90f 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -114,6 +114,14 @@ static inline unsigned long iopt_area_iova_to_index(struct iopt_area *area,
 	return iopt_area_start_byte(area, iova) / PAGE_SIZE;
 }
 
+static inline bool iopt_area_check_prot(struct iopt_area *area,
+					unsigned int flags)
+{
+	if (flags & IOMMUFD_ACCESS_RW_WRITE)
+		return area->iommu_prot & IOMMU_WRITE;
+	return area->iommu_prot & IOMMU_READ;
+}
+
 #define __make_iopt_iter(name)                                                 \
 	static inline struct iopt_##name *iopt_##name##_iter_first(            \
 		struct io_pagetable *iopt, unsigned long start,                \
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8d96aa514033..79160b039bc7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -130,6 +130,12 @@ int iopt_cut_iova(struct io_pagetable *iopt, unsigned long *iovas,
 void iopt_enable_large_pages(struct io_pagetable *iopt);
 int iopt_disable_large_pages(struct io_pagetable *iopt);
 
+int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct page **out_pages,
+		   unsigned int flags);
+void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
+		      unsigned long length);
+
 struct iommufd_ucmd {
 	struct iommufd_ctx *ictx;
 	void __user *ubuffer;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c72..a5c6be164254 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1240,58 +1240,17 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
-	struct iopt_area_contig_iter iter;
-	struct io_pagetable *iopt;
-	unsigned long last_iova;
-	struct iopt_area *area;
-
-	if (WARN_ON(!length) ||
-	    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
-		return;
-
-	mutex_lock(&access->ioas_lock);
+	guard(mutex)(&access->ioas_lock);
 	/*
 	 * The driver must be doing something wrong if it calls this before an
 	 * iommufd_access_attach() or after an iommufd_access_detach().
 	 */
-	if (WARN_ON(!access->ioas_unpin)) {
-		mutex_unlock(&access->ioas_lock);
+	if (WARN_ON(!access->ioas_unpin))
 		return;
-	}
-	iopt = &access->ioas_unpin->iopt;
-
-	down_read(&iopt->iova_rwsem);
-	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
-		iopt_area_remove_access(
-			area, iopt_area_iova_to_index(area, iter.cur_iova),
-			iopt_area_iova_to_index(
-				area,
-				min(last_iova, iopt_area_last_iova(area))));
-	WARN_ON(!iopt_area_contig_done(&iter));
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
+	iopt_unpin_pages(&access->ioas_unpin->iopt, iova, length);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, "IOMMUFD");
 
-static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter)
-{
-	if (iopt_area_start_byte(iter->area, iter->cur_iova) % PAGE_SIZE)
-		return false;
-
-	if (!iopt_area_contig_done(iter) &&
-	    (iopt_area_start_byte(iter->area, iopt_area_last_iova(iter->area)) %
-	     PAGE_SIZE) != (PAGE_SIZE - 1))
-		return false;
-	return true;
-}
-
-static bool check_area_prot(struct iopt_area *area, unsigned int flags)
-{
-	if (flags & IOMMUFD_ACCESS_RW_WRITE)
-		return area->iommu_prot & IOMMU_WRITE;
-	return area->iommu_prot & IOMMU_READ;
-}
-
 /**
  * iommufd_access_pin_pages() - Return a list of pages under the iova
  * @access: IOAS access to act on
@@ -1315,76 +1274,16 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
-	struct iopt_area_contig_iter iter;
-	struct io_pagetable *iopt;
-	unsigned long last_iova;
-	struct iopt_area *area;
-	int rc;
-
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
 	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
 		return -EINVAL;
 
-	if (!length)
-		return -EINVAL;
-	if (check_add_overflow(iova, length - 1, &last_iova))
-		return -EOVERFLOW;
-
-	mutex_lock(&access->ioas_lock);
-	if (!access->ioas) {
-		mutex_unlock(&access->ioas_lock);
+	guard(mutex)(&access->ioas_lock);
+	if (!access->ioas)
 		return -ENOENT;
-	}
-	iopt = &access->ioas->iopt;
-
-	down_read(&iopt->iova_rwsem);
-	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
-		unsigned long last = min(last_iova, iopt_area_last_iova(area));
-		unsigned long last_index = iopt_area_iova_to_index(area, last);
-		unsigned long index =
-			iopt_area_iova_to_index(area, iter.cur_iova);
-
-		if (area->prevent_access ||
-		    !iopt_area_contig_is_aligned(&iter)) {
-			rc = -EINVAL;
-			goto err_remove;
-		}
-
-		if (!check_area_prot(area, flags)) {
-			rc = -EPERM;
-			goto err_remove;
-		}
-
-		rc = iopt_area_add_access(area, index, last_index, out_pages,
-					  flags);
-		if (rc)
-			goto err_remove;
-		out_pages += last_index - index + 1;
-	}
-	if (!iopt_area_contig_done(&iter)) {
-		rc = -ENOENT;
-		goto err_remove;
-	}
-
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
-	return 0;
-
-err_remove:
-	if (iova < iter.cur_iova) {
-		last_iova = iter.cur_iova - 1;
-		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
-			iopt_area_remove_access(
-				area,
-				iopt_area_iova_to_index(area, iter.cur_iova),
-				iopt_area_iova_to_index(
-					area, min(last_iova,
-						  iopt_area_last_iova(area))));
-	}
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
-	return rc;
+	return iopt_pin_pages(&access->ioas->iopt, iova, length, out_pages,
+			      flags);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, "IOMMUFD");
 
@@ -1431,7 +1330,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 			goto err_out;
 		}
 
-		if (!check_area_prot(area, flags)) {
+		if (!iopt_area_check_prot(area, flags)) {
 			rc = -EPERM;
 			goto err_out;
 		}
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 8a790e597e12..160eec49af1b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1472,3 +1472,98 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	up_write(&iopt->iova_rwsem);
 	return rc;
 }
+
+static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter)
+{
+	if (iopt_area_start_byte(iter->area, iter->cur_iova) % PAGE_SIZE)
+		return false;
+
+	if (!iopt_area_contig_done(iter) &&
+	    (iopt_area_start_byte(iter->area, iopt_area_last_iova(iter->area)) %
+	     PAGE_SIZE) != (PAGE_SIZE - 1))
+		return false;
+	return true;
+}
+
+int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct page **out_pages,
+		   unsigned int flags)
+{
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+	int rc;
+
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(iova, length - 1, &last_iova))
+		return -EOVERFLOW;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
+		unsigned long last = min(last_iova, iopt_area_last_iova(area));
+		unsigned long last_index = iopt_area_iova_to_index(area, last);
+		unsigned long index =
+			iopt_area_iova_to_index(area, iter.cur_iova);
+
+		if (area->prevent_access ||
+		    !iopt_area_contig_is_aligned(&iter)) {
+			rc = -EINVAL;
+			goto err_remove;
+		}
+
+		if (!iopt_area_check_prot(area, flags)) {
+			rc = -EPERM;
+			goto err_remove;
+		}
+
+		rc = iopt_area_add_access(area, index, last_index, out_pages,
+					  flags);
+		if (rc)
+			goto err_remove;
+		out_pages += last_index - index + 1;
+	}
+	if (!iopt_area_contig_done(&iter)) {
+		rc = -ENOENT;
+		goto err_remove;
+	}
+
+	up_read(&iopt->iova_rwsem);
+	return 0;
+
+err_remove:
+	if (iova < iter.cur_iova) {
+		last_iova = iter.cur_iova - 1;
+		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+			iopt_area_remove_access(
+				area,
+				iopt_area_iova_to_index(area, iter.cur_iova),
+				iopt_area_iova_to_index(
+					area, min(last_iova,
+						  iopt_area_last_iova(area))));
+	}
+	up_read(&iopt->iova_rwsem);
+	return rc;
+}
+
+void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
+		      unsigned long length)
+{
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+
+	if (WARN_ON_ONCE(!length) ||
+	    WARN_ON_ONCE(check_add_overflow(iova, length - 1, &last_iova)))
+		return;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+		iopt_area_remove_access(
+			area, iopt_area_iova_to_index(area, iter.cur_iova),
+			iopt_area_iova_to_index(
+				area,
+				min(last_iova, iopt_area_last_iova(area))));
+	WARN_ON_ONCE(!iopt_area_contig_done(&iter));
+	up_read(&iopt->iova_rwsem);
+}
-- 
2.43.0


