Return-Path: <linux-kselftest+bounces-33280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7BBABAD88
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86581580293
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2E231C91;
	Sun, 18 May 2025 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAPmB9Fl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C2230BD4;
	Sun, 18 May 2025 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538582; cv=fail; b=ECjKVRb29MUg4bX3lyBb9ELdEI3Ep2UAfKe+mTQF/yh6FCgX7FI3M//D0JbEjWzn6Shfx+/xwEynOAJk8PgIeA2gUzpwhxs6VDPz23zPOGig9k2k1+NDq0stN58YUrFQftAcVaJe80LC04T9OVTRzErb3K02QauF1Rhri3I3suQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538582; c=relaxed/simple;
	bh=RgTt//w0Aa258Jd6p6y41K5Ak6ceIvKnbHdK9u9qB2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1oOQ2foCWF+F/xLDiXVYVnqUwbVj7y2fXtQjy9bEFBrWAbgg7HtY3uu2t8OzbHlCaIXVssGyWpS+GXBQxBdY8x0McMDkY71/NTz2tX7nANoKjUc1S1plOvXkHixe1OhmenQ3fwxCvImHTPo+GrlVgC3HM44bpJY+wuPdfq1Igc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAPmB9Fl; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsHQt8fv7xszoaECqT4BhpiMdMez5wENK7Gl2ckjJ6in+0qUg2sUnWWkvopinwfwglYXCnPs/5v9mHhY2qYX55V/hOcQfVrSyrv06Tb/gvvqAQJMTHw3PH0jGmy9c7nOYH3T+T7uTeC/hWEM44Fbj/zyJ8LPUJGRg/5cdXHh1S2Vf8FdGRfDIgHc/6WqACkXYCuyNbMBdgV3C2CrF/Upwe0oyDRnExWEdAgwv+MAcNSH0AFAIICg6itW0m3qbyZIXXdQOJZsARkFRaE61jir4s2habRkUuA1r2S93Q/MT3Uxm1M+7wfY1sThdOkZ7kCaPqHTVi0L1oWD0dkyyeZo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=fSI2nrIZi/UoHD70zTdY0VGCdqxOcx7sqc8R7tPTozrbdKpZCWjCkVRyD3tENfB8g+hEu8SWIQTrIdRLaAAKSzkpESDeGaOu1ahHZeFHLW8VM1wyl1LXnI74R8Rjrmi+U8e0lM89z1aPbD/jbcmLVmULRvXNpJSqIdBw2GEFo5EdCfB8x6Fx8t5W1LmJ5BRPXngUpccBjyIUgVIQVUXXlN4pqu8c+Xvy+LEg4E0Ku7fPRwQFqJnB5GfYQHdfUyeYLuD3JYCidnCv2fN9jkUNJ/xOMn9Qr5nkBTJbC3B4m8gLcwTBQaCYl0yMSIow3LH+kl0trzb5uHGHGXU1fBhWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=HAPmB9FlO4rhADv9hdlv/ttcOjtw/f7DOQlLnWkixiux6XVVnyofBgkdxhRf0incG/JJp/TNv39/+F4rolVJW4QyW4oDcGcMDRx7WEAVplSKtgI1jhHORMiJ3VWXssX9fJpmCWyMF0yhZzhOYxnbqcLboZqrViayD+WwdwK0VlUS10dj8nACoxLIoGvJ6zH9e4EyxfUNukPZ+k840UQdEaWJzNTBc73OTCkKvT6tPNp33F70TVA3niPw4CxByDVpo6J5UhtjWpUBSu6dSc6PAcPSgh+r+kz1hjqBae06DV1LUUSDBGlXB2GF++0VhCuqDA8Shic5bIf73XnVuofkwA==
Received: from BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:56 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::91) by BL0PR02CA0033.outlook.office365.com
 (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:41 -0700
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
Subject: [PATCH v5 25/29] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Sat, 17 May 2025 20:21:42 -0700
Message-ID: <d806a2ca0a9061684a0b93a07784bcfd83c98ddb.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: e195e496-4ae1-4834-179d-08dd95bb4892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2amqm59nhTzOnOFss2C5H5GyXXOX67AG8QyeIm2YOO2rTRrpnHICmkJqDgB?=
 =?us-ascii?Q?laeWfNnw/rygrHq4X3BJYWw9h9P48rCuFqAV95sOYTR9vUL1Tug9XfeiySl4?=
 =?us-ascii?Q?FGRbAEao34ctJekSI0KcPwbeUU086bnByKYIAfEz9c21gSHVMrc3FQgyOcbd?=
 =?us-ascii?Q?ia5jg9HJ4iDPUALykluw/GVdDUa/MOHgprqmO/LSGokp1Qo8UjNz3ScSVPIn?=
 =?us-ascii?Q?ay7KoIM3dThyP4i1BrwckSs7QneYlhowWf9AnKd/Nk/OdAZn7mW49MCdIgyA?=
 =?us-ascii?Q?YBSM/kwltqg6/7lIETomvtCjh5fENvePPgUDjrQdDj7K4ymM5/4nkTypSmGQ?=
 =?us-ascii?Q?t/DURzsmWLokf3Y+ZfEikB3TBXcQRQzWPW0gzRmr1vHei5NzCA8ENz8NWIhT?=
 =?us-ascii?Q?cWomZCBjtKse5n4CMguo43aZH/5zyO45vs6XYPuPuFujxBNdtFL4cJjEddmG?=
 =?us-ascii?Q?grPl25j3vFMtHrC/MY4//nEVNIUll4MmFE2tlnarL37JWXLGk/CtkRj3pRQM?=
 =?us-ascii?Q?N2WZ2Zbja2AW4zVE0F3/mRBJk+Kwz4Nle9g/QYD1qEBiBCjUWr/dqTkZp6/Z?=
 =?us-ascii?Q?nHSXbiY4Xp+LjkKnlgb3UoEwNnOTkWmRgxch70FoxPjB2bJB6hEHyGuGIQHN?=
 =?us-ascii?Q?gzZVECgxB8deAiHKg1UmTftpLsOqtBUeXWS7itOa3Ls5V4ja34pPPjNNxmxp?=
 =?us-ascii?Q?jL6xHINsaaPUHSima2eM9PB7rRVbi8kq2yGt1y8f9rnym2Ie10ZAvJA0qpGp?=
 =?us-ascii?Q?21iwMf5FjSAdAki0ELRvLtGiALn0knIsW33YblLy5zGljkpdlX6RkwP0jsOY?=
 =?us-ascii?Q?/9Zg3CcgC09Ba+PQyc5FWnSefn/hxo+lhwFcSrKK1WOAwUq5g9Kk3ZmnjTdm?=
 =?us-ascii?Q?XTvfG1U+kFRXZM4nEmEjyPK538zIMiPxVQAd0cAaCKjL/T3Zid09oL3S60tI?=
 =?us-ascii?Q?nDzgk/tP8BEu+AWBUhuNE/27JOu2Q7ABaULCNRpZvI2wh/DUkrTPbiy3IUXR?=
 =?us-ascii?Q?GShP+J2TxvuatSyrHyGns3ffYwi9SnRGpHjU9U3Ceu+tCCbfv+179LVNhySr?=
 =?us-ascii?Q?Eo3vTfCRrzDvcHXfFUQ8w7yawm1D20ti/6yRxe7aNXpjae2cE1emju3kbASU?=
 =?us-ascii?Q?jt/IoJrPNtf0+IU8ZqB3fYzoxvFrzyuLXU5Y+6ntCePVflxwH/S2v+XQwxFP?=
 =?us-ascii?Q?U0hJlZi1EzIsekfsylXAkCxQP/is11bJyxs9vpJBuO8FMupGga07rpqfDCyf?=
 =?us-ascii?Q?MiPVtjGgEPaycEWp2fS4n0JzQZrlPFSKYf8A5a30CE44qK8bwVPSF2NO56no?=
 =?us-ascii?Q?8Nr3QcAY0RcBZaqU4VOzxJ4RWn6K8tCplf8N6ZauHnJJCYEBAiQDuNU2YUcI?=
 =?us-ascii?Q?STS37iTOhF0XeMoYYmdx1w0tZvOuMswoWSpEZV419TGdNwlO/65EiIYZYRkI?=
 =?us-ascii?Q?gCoY9uqwdvYWnVGug2LoAMZZghmjg1h+1ohhOA5XWkVgsl6OpnXZnKknluSc?=
 =?us-ascii?Q?8ni1Aj673AL3tVlqbqCC4xXw8RokJOIC9L+c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:56.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e195e496-4ae1-4834-179d-08dd95bb4892
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

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


