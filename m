Return-Path: <linux-kselftest+bounces-21179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30329B6F61
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4412B1F20F3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97B22ADB1;
	Wed, 30 Oct 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7b/xJFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7856218D7C;
	Wed, 30 Oct 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324174; cv=fail; b=diG6/n3eihjPad2q2nImjDkAPByFM2EDkp2NDZy4lhRQcbRmsf1rccKvorE+Fcv3WjWCtOoWMJYj5t68WbaBm1UY/ToihTLrinUY1tb28tSvBP6uinqDj0PWvZ1erPycP7b/a4lgz25dOWCw78nrQg99IAFAJSEL0fSROEdAzfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324174; c=relaxed/simple;
	bh=8VJiLmQmCz4ZE3kvF3zmgZoKiVTStOnF3CiN4kgnwWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkZvMWftuBrcVG14OdjFKonhNLyplu+Urxs/ng/Xe+3FoISRLfCR4IbC0I1JM0nbvh2HmM0ifmllhJLITlQlfR1TpcbuV755iChIQk2etcKy24z/RCekBxZZvG87RX+Ez4lmliED732nYxufhGTPaJ5qZeM8FTjf5WxGDl6/NPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7b/xJFe; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdp41euHfi849nAMup77+Mfs51H3oYU6P5KJUG2r1lLibiFFBqYX1O1T9AvCBrT0B1VY22SWWvOWkDU/mUAItuYMwmuaZtzywsJ3G/s3uHA3Lrsl/H6MnHKSjw2AmdKaDZNK/WPeQCpwkYXe8ea9QQvMNgwwjJURtoC/xWZQGLO5zd267fHJ6gKqx468QgFlgs4+XiWLutR6iJqMBhCt+qBH+1AhhjW9Yabo5YVly44PhFryJqTX6+OoMy2FHVLHdRqIsUUQ7VN8tvObMoDDPZuP2bSmzgzWIp/FwSu4SDHxTtQL3Mvur6ljfi+jckrEUMutp4e/VJXt9PWlFsshdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13i1+p919anq5dlWH3sCXAfiC2XOnL52N5AvbGSMcwc=;
 b=Zg8C7lOxRLn14+TPsNrOBS5EzjjYgBH9tq+JilukSbc5rYfqIvbjz642Z+vhY9tYJzP+5ACAVNsuzJuhGcaB3g9jzNMPcrV8poMOE7j8qNraF8Xiyp1OyPRJTcMbDZsIcdSIeM/VqvWS8mgT4WFMS/NvFFqQ7DfJhsT14928tjjztFowOEScjqE2Mg6U08tyZ2fGAvwVdexWkQVBppk+PYs0UlpaiWg7JfeEtdyLAY+cdYbdi7mlKYwA94Pk4+SzkIaxkN4Ru7SQB/8ul3DuZFaMveQIMO3VH/NYAuGf+0vQxXz2KLv82zUoYiZMXQtoTuWZSqkjfvkSOoEkeNX85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13i1+p919anq5dlWH3sCXAfiC2XOnL52N5AvbGSMcwc=;
 b=m7b/xJFeX71Xz/jcQQSz9pVov4vr75DWO0Q54pWZjycZ8pTx4RIuhkYWvMUB6cJe7rxj/2rIf/9N3rEz/x/+xJg5BvCGhwuaIsPsSL9yUiStkmhSEvGQNbON4TGt7IHfB19ID2ObkmwVtxk0IvyKeBrAn8elphHgQIxXzzPwcgztiNrgdOZV4GK300KRH7w2j0dLY8XeH0EwGwdxlRY3v6CPIuBcV2CbotaGcCRG2OLCFISPkih2/sFx9+PbmWhMoS8TopABJullsH/sEHCBa5marzi+fIK1nUcFEUJiFEMf+I7Vxi0OP0WDCP8mwFBhn44ztXmBVD7dPq9J6KzH4Q==
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:36:08 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::a5) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 03/10] iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
Date: Wed, 30 Oct 2024 14:35:29 -0700
Message-ID: <c798df8385e83eae70f5a4849fb2d0ffe6a7ec93.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: c5666e3e-509c-4f25-5f7a-08dcf92add84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FgsllLXBwFwLYoM2WIpjqUP0Vaix8QEQwkvIkIXHknRMSqd3MmEaJ0k6jO6T?=
 =?us-ascii?Q?yLlw/LxVxPvLRKaVC3cULIazwHKKz14ZOeHlMcJPhz7hiUNEJW/iD8pbnQJv?=
 =?us-ascii?Q?EKBPDS81ebyZ7CTXYVbZvV9+nZrf1FZarICEmOWzByGp3lM+vnbatX1xmQW5?=
 =?us-ascii?Q?NElu5k/iKD4vf4AcTJv3CJ/+x8vY+qv5ZPaejXulysCnr6FaGu9qzmhQUDrc?=
 =?us-ascii?Q?GT1pnVCQ69FAnC6mhCtQDApjrdeSlhKnFgyJYDcwhKR3QkC6g/djeN3KLEBY?=
 =?us-ascii?Q?umri0o6GaLERgGO2UH+V97MjK04nxnid6kk7AFEEsjqK2Mu6dD82K+fEXASy?=
 =?us-ascii?Q?wcKE+3NgfRH/Stz5/dMJ9f7eV9+WINWKSBx1H6S5eEWJjXKILUGMW4FB5/eX?=
 =?us-ascii?Q?zAUsDorPmB/VwUoIM84K4GBOjRQSrxWbUbqT3+DXnJwqjB/D0jXvmCG30/8n?=
 =?us-ascii?Q?zOH3kjk32K6IAyhAQSh3oCGK0KrmXQyNn3YnE8Y5gV+g3Bibw5KBW+XRbL1K?=
 =?us-ascii?Q?FM3B7QdLRtP+IYYfOT53Mjtxn25OrAZH0PrintQYl1ALU6fVrA3UReMq0l9e?=
 =?us-ascii?Q?bDLPlqJHgBti7h46ccgF+tPDCZZo5BiyvILLhHjEGxL01sKCOFlK0cqbvQfZ?=
 =?us-ascii?Q?TMaM0a626Mop0bWA7MM/YnycdAdHjwEanvDw6MKOy8/keDLnzOUSpnm44QaA?=
 =?us-ascii?Q?lm7JMAggqhofEvPPIy69J5pNbn9NF/IngurEbbH9tApYLtUlrYMbVol0Xw9r?=
 =?us-ascii?Q?EdjU7MnkRxgfkAp+hoqxWzBt/vY7Y1V9g148QY0UntFn/mSmaWlPJa48Uz+U?=
 =?us-ascii?Q?YmVrY/JUIgJq4Ycxc3WEQpQ9220Laepskzh9Ggm8GDLhBOrO+dz9k7a61fak?=
 =?us-ascii?Q?3CkqyV1Ku3RCxI1lzYBqTMPNK1XG2nu3Y2+fN9hkL1K9md8WgitnJz5um5Qz?=
 =?us-ascii?Q?nS/rxUV0/D4R59zM691NHy65K1x/7xPphwHJizrmQOox1qbISQHmfDWsfyom?=
 =?us-ascii?Q?8vkvXh9K+TD3M3BpdOcvUCmWnFomBnMp4UtJwH3wwV99EJIQ3Tiz0sqWklUT?=
 =?us-ascii?Q?ijsDjCoqoJh9YM3/FmgtfxURVnyLYl4yFfqMq6sF8LSHNv9oPJrL5rZMsiKr?=
 =?us-ascii?Q?GOVHq7W9GStgWU5CVtKRsKv2wVsNv99lzmbU8M1jeGLJW0IHPwbGIVBjbWfN?=
 =?us-ascii?Q?0qO8OglDQbOzHZJk8xIKM/hqltlR04otT8WzEEiz6lrwPbxfUKnsRdMhZTMm?=
 =?us-ascii?Q?0fW0uuhgXDnCM6kpAGklF3t7l4tAnvJNv+F7lOZT4guaHNOeukhlrNNLmUqq?=
 =?us-ascii?Q?+dyIj7H+owVDtvEz+ctneU/HwP0LXGqQgaPhyFigKymkPk60fb1qXADzl2r3?=
 =?us-ascii?Q?jlyzJtLytO/5vLxld88Jdeh/0utBKgQ4w83/wey8Qv7ORbs0rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:07.9212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5666e3e-509c-4f25-5f7a-08dcf92add84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137

This per-vIOMMU cache_invalidate op is like the cache_invalidate_user op
in struct iommu_domain_ops, but wider, supporting device cache (e.g. PCI
ATC invaldiations).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ee58c5c573ec..4e59af87a524 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -16,6 +16,7 @@ struct device;
 struct file;
 struct iommu_group;
 struct iommu_user_data;
+struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -105,12 +106,21 @@ struct iommufd_viommu {
  *                       must be defined in include/uapi/linux/iommufd.h.
  *                       It must fully initialize the new iommu_domain before
  *                       returning. Upon failure, ERR_PTR must be returned.
+ * @cache_invalidate: Flush hardware cache used by a vIOMMU. It can be used for
+ *                    any IOMMU hardware specific cache: TLB and device cache.
+ *                    The @array passes in the cache invalidation requests, in
+ *                    form of a driver data structure. A driver must update the
+ *                    array->entry_num to report the number of handled requests.
+ *                    The data structure of the array entry must be defined in
+ *                    include/uapi/linux/iommufd.h
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
 	struct iommu_domain *(*alloc_domain_nested)(
 		struct iommufd_viommu *viommu, u32 flags,
 		const struct iommu_user_data *user_data);
+	int (*cache_invalidate)(struct iommufd_viommu *viommu,
+				struct iommu_user_data_array *array);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


