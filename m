Return-Path: <linux-kselftest+bounces-36633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E0BAF9D81
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83454547857
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C7A22A1D5;
	Sat,  5 Jul 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pIp0VA0T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0932264B0;
	Sat,  5 Jul 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678092; cv=fail; b=LqjKn6AKsG7YeqixjoEkv3jHS/XagWBVb062Eu4uSW+x1aFW1azKb5/NBaELWc65ZrhXmRtzPL4NaiMysw9LXF+shvgsTBGZcrY4EZAPX4nmB48roN0VbjI2Ge6lLiYGRzy1kW9HXey63zZAOJqDMxygiZOkeifdnPNssF/kQd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678092; c=relaxed/simple;
	bh=RgTt//w0Aa258Jd6p6y41K5Ak6ceIvKnbHdK9u9qB2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4yaQqqcEdGN6lJNMmLgQu25i+qyH3UQC+ziVr9yD/IkLY1fW9LNgND5633LwqDOScEdvwH5BCW0JsvtTtEpRmBqNv77d1dbMB+69HW53qUiJ7UyfBIOWIou6ms7otpfDRBhr4ATFHclESNIgdMkzbSeRCYnYN1QBtBBcprtujk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pIp0VA0T; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2Ne6/iv77cjgftKPR6JRpUmH3NhBoEpEZVrgIAHsQjN3LEyYRjDYwuDUVr4QwMXNkGudEOOiHPTPWFD0KlPLgAf9BOnEUwFTuT+X0gvi8E28yDVVrxkt2QEiiDdXUBjnFuG135AgByaiJvTcuAEFPB/hQO33WYVH1b1hQxRA7yowNhKfgM/cd7IbznuZ44m5YdNDAOiqoH51b06Rxxh16RtJ2/v/VQMjF/Oay7VUM+ISD+316Cw+si8LFTIEeDUJ0UeI8tJWVWjprKktseOjTCaHfLi77eaAkTMNSDYINqufoziNYXwhpC5tEuvOL3W2ScBfnk19LGynZvOrNV77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=WMOrIImmT+ZsW/gf63KH3cIRFgGnCXbLixsqM/c2KBM6ZhxA+XcOzoKZKbr5B9z+vfpdTr82w2Z5umf1o89q1PQYPYiSY6vAexPZRU7FZs5sUAE+uvMRlV2UIvEsEvHAujN7ZDfJ0THCLj9FYB5sETrJs4NgTH8gSibTMiBMqMLr6VBUTlIecJNc/m/2119fK2P8btA1cxlQx3Y7QzaYAV9N0N6a1sPVpUteI+9hYyNZd+6emm3Du82ZztXk2aR/sNZMKPgkCJovnSKFMPOAIwUTCwxIEPCQCPJuzsKoQYgPtpIkn97gR+pt3CJuSEFlykN/rg20Q0UODCKk+fTo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=pIp0VA0TN5hGRpkWIproxhvVWaZLWwDjD/7+yBE7AL8rw6w+EHG2E3Km1svSF/KndyM3RiE1tiC153syxmNe5G7ILBuJqFJ0Dufv35DUrl/tHKg7B1jRcxDg9rOsGWCZ6PK4+XkbO5Yi3WojZfnTnALEPPY5AbVio3LoKJ1LZX5HYhue6QQIOIhmEI9c+E9bx800QPsvgX20aWy1SVBnY8UckBx7uSXUM4d37LSr9A/OHoYeFa3O8GqD7WUohmr7qI7eIuCpod4ItGpflwM7VHqZHcyh78zeAPiKQeTy0e2EZyIBxg5xePOhHRkaG3HYA0UC6i27Gx7DF3gAZEDkOg==
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 01:14:46 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::62) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.24 via Frontend Transport; Sat,
 5 Jul 2025 01:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Sat, 5 Jul 2025 01:14:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:33 -0700
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
Subject: [PATCH v8 25/29] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Fri, 4 Jul 2025 18:13:41 -0700
Message-ID: <d8524048c23fd8384c003a2ed79489f75d55f792.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf637ea-cdaf-4ff9-4415-08ddbb61546f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7gfdeflDBPZCTGJ2+eQ8kgh4+qY2H3CUw/d9KRLqv9IhM1C79o36S+/nvnP8?=
 =?us-ascii?Q?tadcJ6HKgqHoFbDRQZGsvKSuh3V87XiPGwLv2AZifXTAJvHPOhLvUntNtj4E?=
 =?us-ascii?Q?ZldJewpdODGsGXTPYjRjAllJW/qAby+l5hVvdKFwOPyj5i3720B39X2o6s2T?=
 =?us-ascii?Q?ZyI4a1uyM6M4MHyUcXyckNZY3VkMz7FOXD2m3WvnWNvNhHi+pyiyPQl3PqOz?=
 =?us-ascii?Q?uLLs9ffhe8UPyjKf/WkkTR+k+xYBsyceSP845BpK8/RbQPq0mBrbPLQRwdhC?=
 =?us-ascii?Q?AbUn1JdS0Id4hPgSORYUYQy4PSfNgjLRo2ZD9O4U3LTHufUmkFG0ged//3jt?=
 =?us-ascii?Q?zdTuC/UbmkBmae7X12BgXN88Yq2A826ZNFr41MO0L9dPoBzVBqm2qdldACIf?=
 =?us-ascii?Q?Suxn8SBSlfajqfbR3gHwHBos7LpMIcZZuhXguNXzxVo6TX13eXoD2lNaH3dR?=
 =?us-ascii?Q?3Pcmbu5FUka6bAyt8vQzz1h8TKBoy5T21jfKL5ZtPRdho2nU5O6YvzpIba9U?=
 =?us-ascii?Q?Bu7xhFoODqIYFf4uhJ4/EufU26/I/K5ABbZ87S+VOoa881zBhzj9qJt3i9/K?=
 =?us-ascii?Q?0IFh2ig6LjbgslZgh07ORCyQLzWNlqo5tAZecj2Ecvlx0mJ++4IhekmsRdne?=
 =?us-ascii?Q?MoC5CdUxUE6PljbL32c5DkRFbO1yxmvuTxHPeJfQbm8UQwsNIZrWCqcKwkNA?=
 =?us-ascii?Q?z+tDya3fEmvhwZFUU41oAn2byVRCNpqDlYYwiMj1Yu2vXCIuTxyAe1J4myCT?=
 =?us-ascii?Q?TER8cS+mode/UX+ojPFBKvcosfzkrUA8Re78fytT/jPRftLq20b/00GW7/3Y?=
 =?us-ascii?Q?W2P+n0UyAulXDu4Zzbkgc3UxUYtzd6F3/u2p/8nGsaWu/KOwMdZRaKD1mH0h?=
 =?us-ascii?Q?0QpsTKcubMTbBr1X4gZKufi4/7Zsbb4Lro6liwOXG7+ADCBNdh8/Zd+bSSJM?=
 =?us-ascii?Q?VBK6ivVVgnp9+jPQHyRwSVoxEcLZy5gSw6ZaARK6ECChiyW+itCrzy9m1qXG?=
 =?us-ascii?Q?njUhrWxzFLwgTsWuFMDZZICKi9HekcbPXH9xraUGuN5AdBlKLtc5tNSf8T6n?=
 =?us-ascii?Q?LhKnFI/CQtaozduTdgW2A59MPGgqtFF2tMRgGWRpzO5d49FDn4KSptdrH9XV?=
 =?us-ascii?Q?i2/ZBEixcxEBLXQES5dP72RyJWYx+SX91hN3xM+FBug1bD9+SKN4pQqJ2BmQ?=
 =?us-ascii?Q?uXJdA0fiwsL06TboAq8YxIdOv1maFygVLKGAI4X1b6ztyz02+S+YFEtKc6d8?=
 =?us-ascii?Q?8xX3fdXDZPZSSINETedj4I6ZGb3qO5mOx5HAHoXg4LIxdSZ03KxRrpagqA8g?=
 =?us-ascii?Q?B7p0ATAf8x1E6/VVl5DD5pkCuyIk0ZvrEmuLvMUEhTXjG9LqQaugosEdB88Z?=
 =?us-ascii?Q?jhb1IazNzZfiZ45JO/t2JEQAwmmzMKkM47jMCCg8c1wPyohU0BgWTExPu5b2?=
 =?us-ascii?Q?42ntDddwXB3YEa76ULoQvEJMKA/oKqzETFW8iIMfkq0/UmFQzgg556KUaXSV?=
 =?us-ascii?Q?jHRmJ4JN3uXUR0TVIxCv8+sZR7O0ltjLswnX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:45.8155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf637ea-cdaf-4ff9-4415-08ddbb61546f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072

A vEVENT can be reported only from a threaded IRQ context. Change to using
request_threaded_irq to support that.

Acked-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index dd7d030d2e89..ba029f7d24ce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -824,8 +824,9 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->dev = smmu->impl_dev;
 
 	if (cmdqv->irq > 0) {
-		ret = request_irq(irq, tegra241_cmdqv_isr, 0, "tegra241-cmdqv",
-				  cmdqv);
+		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
+					   IRQF_ONESHOT, "tegra241-cmdqv",
+					   cmdqv);
 		if (ret) {
 			dev_err(cmdqv->dev, "failed to request irq (%d): %d\n",
 				cmdqv->irq, ret);
-- 
2.43.0


