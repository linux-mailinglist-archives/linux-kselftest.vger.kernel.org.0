Return-Path: <linux-kselftest+bounces-24286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5886AA0A085
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AA2188E312
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F121187858;
	Sat, 11 Jan 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a4rD7UKe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF017E45B;
	Sat, 11 Jan 2025 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566385; cv=fail; b=e84TnhK/fmmoUZYWQDjqWW1D3FPdpf+9El3erX4Rf1ZAKlJryvXVmoKLfebNUsRFTL8i8+AgyBclXu1q7aJAVGUxUXNvNBJ3e/moT6ObamZZw4KWSPnCnbhyc0eT5+ZHVlBmvtGv92Q2f4nd0n/fZgpM8VC4fpETWg3kigYg7ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566385; c=relaxed/simple;
	bh=AzwGaeuQ3+okXwH4czRUJyQ/pRYT6FOMjFxLBitewdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHWks7P1EZZVcJ4qYJSQNOYFoofFnPdajDSi8H22/r/0IyZG+DGAnnC5s5CAzUw0Dk/+XYxJoogMA+m8aQhEdN6U4qhdIlx9xYcHFzahp15esL/6Qm42lmOP5jbPvvm/Vav1Rt9GeC9dxncPhQ6juNTnCGNrxnzXbFfPIHBRVU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a4rD7UKe; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMx4OrSFYszAktIk36GwJ2giA9p7LvYt+7kp/Enevx7FnPhJyPHLMgaG4eyru9N6tKCRC9O+6pqd96TnPYlHq2ho+uoCxNaUuBQwccBNKv+79q3KjPdkH6DADk/94vzJkKkJxKEXijxznWEoQOfro8MyXZDpr2cm2/tIMnrJKcDxyrpsWQQG5WvD6SH654fTK9C2oFiJKkuD3YK5RG7Do6JQ8RPjxgQelrZPV4x6mOkSixFeGqjbatSsFFnPiE2a59ZL+fQS/v78PAsgrI3S5Hd0ST5jnL4fMMk8GiXIesrbwn25vL78ysyjUVLHmdJsmDsm9BkToFEnMjk7y5JyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yGT4PBfP8IziXdC1BTCznCK0CW517Rv5EMczDSW+vk=;
 b=sz4HYrt/+Plyxjdz21LPSE3Zc/pOePUaVOoi6Wuv3+4HnBqdUIIEnDNTOvmBnQmcoHAhzcVmu+HojbdqDZKGAqKXncegs39CO5n541uYF8D4px0fNMzwSBFeKxd3InCNKVLohBlgvF5ej0dfMOlRQmFpkH002k/QqM6RlnFZmIvcieq+xg8eafFLU00a3Od/9CHRAGqtC3XH0Jp59uBZ6TWDp+Ocv7sCrfWtddZ4Y1Xo7NaUtY5d9hkYw9VTl76//hdAu0Pf/A/nXQXXBseWTjDrWRNFgRY5Tc9ySPaEqlrytk/aCjaK3qjSDe1mPzIY3V6xThiN5ctC8YCpfXpU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yGT4PBfP8IziXdC1BTCznCK0CW517Rv5EMczDSW+vk=;
 b=a4rD7UKeyrORZkL5XczDUP5QH37NfyhPrZ09bfV58Q+U1jzHhXgO+cJKLu9Qz4U4ScUZ5GwNyjkNbLE21Wqj3NUNvMefQF/8e0JwjB4n6CHn12Da0SRSyOZy+6Mu+dnQn54zbi7kKwy+ymA4jhpe3JPt/7DpeofWxPWIJiCdmmzHzn9vscDFMz1TtSY0XYYIbLh4HUNZo/gSrrD4OUGiP/q/e6VTvzxBFJD7TrwJfmWRxxSpOMEws++7iOrs0XYlhUjs9yC6BIdUFsU/nG5uN62X5iB0090Yi/4enO1cfdNoR4xODWuOjGZ75kUul2vlsrK1Zw1b/eqLwi2UJwMNAQ==
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 03:33:00 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::26) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Sat,
 11 Jan 2025 03:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:32:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:32:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:32:59 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:57 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 05/13] iommu: Turn fault_data to iommufd private pointer
Date: Fri, 10 Jan 2025 19:32:21 -0800
Message-ID: <3b26ce04e8ecb5e47f028fe5cae48e5235e68420.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4aff49-7262-4fba-5a92-08dd31f0a5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wM6SLx8wjS7zoGNVsT0ruDUvDk6tq3JCZMyLp+TOxbwPJ8+nrhiN6xanJ9m7?=
 =?us-ascii?Q?YFSW48BOaUEPw2ZkR/iw3NDRGlV4KuOzdjCC3GKfhx+ktv54HZWmieyMoWW2?=
 =?us-ascii?Q?Iw+Ki88YmvTIqs9Js4WLRPjx6oBTYongRoYtCaDoR3y3B4XagsS4Ls1YI0sl?=
 =?us-ascii?Q?xD5U7pqrFvsJ2Qaut/4E59Jc7fL+OTWvATd9JTcfS4AJ2gviiC7bqZLJSjPm?=
 =?us-ascii?Q?4PGBTcigA3S89QNLHRvl/n/Io32iOs5MCOscrreFr6Fdp+s46aBxW29Y/HXk?=
 =?us-ascii?Q?rk8F1BD/M8v8LVdupVeuWkVHrr190I/hpX6FqmPz6T8IJcAjzlFcGpRbMtGh?=
 =?us-ascii?Q?SokS9oj43GvjUSxNhDTlGeiO0i4A7s/QPWYz2fvFJDRuTBaQr9ZG/QFPtVyU?=
 =?us-ascii?Q?VBMDa5oM/eVo0nfW437BI73aYjyES4h3O9QGnEBJZ8k9ZZsZBu/oY0XCG7+U?=
 =?us-ascii?Q?WJ8F7TA1b5UIvbOAglI4Rk3y/WcNDIVOVxfe3BZxpgF0IKNAMOuDBA6eXaWp?=
 =?us-ascii?Q?VsrsPcLKUDQVt7WB9vj2GO4XtLNQYCOvwLeh/ua50RFL8suMSZ/slUiYYPDu?=
 =?us-ascii?Q?ENfzmzVAk20cfbe9N80PYKhJmlzpj+uq+j/R3CHVcwscAdTybDeXAPJuHUtG?=
 =?us-ascii?Q?1Xi82xLE5KAqzi516kSgncJbL0EvCUOU0irniNwQBeak2QhHM751YWrRzZOQ?=
 =?us-ascii?Q?Im0RJ600QqcmrIyy/blXoUCQ85k9pOXMAcyKR7xgdh+gvIKlHnonsqcRrHBC?=
 =?us-ascii?Q?1OrX7yQ0wpTe7Sye2YnVcVtgbCMmXHlf6KUcyMFEonx1PjvlMD++pfNdgkzK?=
 =?us-ascii?Q?KVu6D8wYkK/t7bI7tKI9ouN1t8aEHbGLjxT4gbr2WjBlCe2p8N60dIL4q3kr?=
 =?us-ascii?Q?nySkHF1n5E4lncqST/lNCS61UKT2n39bTgy+XoZwfaHP4E7Bcp9WepcbLAwT?=
 =?us-ascii?Q?YA/OVLW9j6Y+F04WaGA9DtjtzVYBBOzOwYY6FiOum6W7nhci/x0laciHM6AL?=
 =?us-ascii?Q?vI5Ga6XNymg7kk6RzW7rFgz02G406Ln1Ak0+dcNpv078CLWIHc1YVMDaVAfq?=
 =?us-ascii?Q?W8ZCg3Frbm/rN/K+nwRBA+2QSEeZpAQNJKpCzP990RW89ipIDoQ6wGF4QFDF?=
 =?us-ascii?Q?dE1RdzsJZo7kPIjkynw19dEJK11oALt9Auw/SKOJnASo8d4EIEl0qFSJaYXM?=
 =?us-ascii?Q?LL+0KZqS2XpQvyukJR+FZxwLt0+66MHbMDD0tMpd24aUDvKs9Zb91BYPwnLt?=
 =?us-ascii?Q?173Cmk71B6n1YDqf72ij0tax/eTcHDhCrEoBznM7Vsevv4igSsJ3cMeUfZ2F?=
 =?us-ascii?Q?IGb2xLaepcEhqSrUUZ1RPpmmxPGBKExU1eXrSvBnxwz51pJoRMZlnz8zQajU?=
 =?us-ascii?Q?Mw1wty/BZXKxzJwy0aIjsuth5LDzUen5Yys0a0pWyDzQyi1VfR2bps3jfuxE?=
 =?us-ascii?Q?Xz6UGBocSKEQD7UcSvrAivdTt87hphbymgIjIXVpA6xsbQigt7CedyFsXE/t?=
 =?us-ascii?Q?zgGFuDtK6VAkuY0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:32:59.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4aff49-7262-4fba-5a92-08dd31f0a5d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

A "fault_data" was added exclusively for the iommufd_fault_iopf_handler()
used by IOPF/PRI use cases, along with the attach_handle. Now, the iommufd
version of sw_msi function will resue the attach_handle and fault_data for
a non-fault case.

Rename "fault_data" to "iommufd_hwpt" so as not to confine it to a "fault"
case. Move it into a union to be the iommufd private pointer. A following
patch will move the iova_cookie to the union for dma-iommu too, after the
iommufd_sw_msi implementation is added.

Since we have two unions now, add some simple comments for readability.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                | 6 ++++--
 drivers/iommu/iommufd/fault.c        | 2 +-
 drivers/iommu/iommufd/hw_pagetable.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 423fdfa6b3bb..b6526d734f30 100644
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
index 1fe804e28a86..06aa83a75e94 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -431,7 +431,7 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_fault *fault;
 
-	hwpt = group->attach_handle->domain->fault_data;
+	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
 	mutex_lock(&fault->mutex);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ce03c3804651..f7c0d7b214b6 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -402,10 +402,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
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


