Return-Path: <linux-kselftest+bounces-36928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00CAFF90C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA49562510
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B929291C;
	Thu, 10 Jul 2025 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZ5PKTo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFB2877F1;
	Thu, 10 Jul 2025 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127254; cv=fail; b=tYn1I2uKIrfDbLtOn7+OuzBdAMvUCOMGPWP6Dqv6Qpd9k5Rsfis0zQTYOEnj8Z/5BAl5dU5PdIKCKVFyegr94AUtfpildEuVfD7DVagsUakH7grozEOQi0FOx+Z9wQujVwz83Ix6jR4tEwnpc4sbCQ2SzSkXLCAB1KD/LKsz5hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127254; c=relaxed/simple;
	bh=RgTt//w0Aa258Jd6p6y41K5Ak6ceIvKnbHdK9u9qB2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifv0Cr8+0DfLOEmwvPsaD5aAiG3v/97EBZoqj06W43eQ8OdMmbeQEPCrAoPxEp9+A5U1A7KfeM1Skg0yOQJkejZf9u+GFCyODC144CQ9CodqBgSDiyk+rA5sLMBZsDZ/bo3EJtRLE/lmKttZmYsg4GEyhUgH1P3o5bsovizS5Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZ5PKTo4; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjENpdp/dUZHwhKuWpIHF3f7dmox496ruVhGpJQZYTE5q/qSBfB4rZzqHntxtDsxj6oQ5q7o9qgVQgJqX7jMiJXAn7pkyz4+vPOuKPaNkX7HrKMcukl+pYYhmRHhfsgYLsvqpY+1XW8LKMSMbfETLu4VKDAqnFHvisbUc3+SNbZch42qCoh5fYUpsLbpEE9FYCSVyg0fH9JOFdWC4gteZY55vgFnDA+cwjKFoT/IzHuUnszAMk/k3Ma1ZDS48DYpz5MEqKO5judeq6XjDZ0d9EyFPx8ex4dGWkGK+btiaTAVfAT2NsBOdZVcKIj9x79QUEBq09milzQ5No7xvk+rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=pPqULjksmM3qj+DR3c9c2/cSEdYgpAsiEJjWXLZD4ArwQDAenhfd5E+m2gMw9s0750niqJ/X/42wtEHpBf/bbDNtVvrF1mcEqF2bHZFP8UKV4a5vNwEoH2ymeqQqmZbcxik+3iyVRQoMp9U5RVkzXdqRQui3WQEa0+DHSrDj0Nd9BQHPtqt/isUjQiOFkO0YqXF4nJuym1oPWYiX0eqDPs6Pff6v1QnEZrRz9GAeRHnusG8eCttr5uv3gbScLxGyfcUR21Wnp/A2XUN2b524Are+JlVw9ZCko9tl2GQIz8HV1M06DbVi2419nggp++Bi4IH3jFzc54Y050WbEoPSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=FZ5PKTo4dFEnM5/OIx8yFvCN13YwLmQ+H6YumIf5O5TVhMbGwHTwMd1WBjPMTEDUuF3ISUsKR3yZRz+4BAC8bLomvHPsKhB3VcfFquIjubRl3QQsssHGgKaWwFWPLed+woLhLPpmaVfW02Dymw8YXf+STyA2LlrwAuoKp4gFrIEW+VezY7JTniVUyBVSxcKkLi7GgXiG8o0O6J1bChnqtfS5n7UxWfcqlaWRa+rlJn0qr42LmYkcEd6JTUkylcQwt530I6B32AxjlTT2JPxloCYjTXXEM+bZMFYI8GuYataTQvvFd2uJ+v3UknOtDd35RnUAz3xVwRfOpLCThtjzJQ==
Received: from CH2PR14CA0047.namprd14.prod.outlook.com (2603:10b6:610:56::27)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 06:00:49 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::a5) by CH2PR14CA0047.outlook.office365.com
 (2603:10b6:610:56::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 25/29] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Wed, 9 Jul 2025 22:59:17 -0700
Message-ID: <f160193980e3b273afbd1d9cfc3e360084c05ba6.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eddbdc7-0701-4079-56c6-08ddbf771e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VAuvWdPFDDUiPW/nCxf71Z/BXx7CrZzQURuXt4riAS5QSEsohVfzZ+ST783k?=
 =?us-ascii?Q?mNxm8ObCPaFBbPMUBZvTn+5ZRYi4BLQzD106X3WtNC/zTsfmzU1safNDw4X1?=
 =?us-ascii?Q?7uIV3mjfCElW3yx8d/CkMnxImU2UHOveP66lXEHcprVHtsJf/8d9etaArLJn?=
 =?us-ascii?Q?uBguO1De/vdLFNvKpB+7+3OneOtco/iNuMEsr0B65KEFPWiv2eyWOVjlLTqb?=
 =?us-ascii?Q?gzsQwe0UWoyTt5RUa3qBffT8SmXTbKmeEUo0Jsto6+8hs87u+QSXh6krCz1O?=
 =?us-ascii?Q?oMi6yo6NB/Hsya1d+PqXbNn0B+GKVLTYy4Gw3k/yCv9/Ow+ZpBSPD0o4aNsp?=
 =?us-ascii?Q?hw/US7ttiWuKew7DswTk49EeqvhMOK+qd5Jd14H65XCk4PVSJI5LaV4jZYMc?=
 =?us-ascii?Q?aEUhBn0FJzFjRQkrFaFGOsySCjmd2O9gRxn8uFj55cj9+7D9Oll+esEgdarc?=
 =?us-ascii?Q?LxYFWps/Y4Onn/RoD7q8XH0rq5rroXCeM1Fc6xguXuW80KELTvHERpvg6BQr?=
 =?us-ascii?Q?dbJ2jZY2qbhKtfEKKOgIugPyyOHIkH3nQEKzMXTzj+M7kUZK79K0AEnM9GQH?=
 =?us-ascii?Q?sHctrZppLLjCIfb72+KnK0eH02cy0PqDcpxJKBO2LjcOdcMm3wbQKubJF1jL?=
 =?us-ascii?Q?lvNVIELZglxMioJ1zFZlo/mRu20McAkCdeR/AcCJKigVX5YfrJxBV/NLN+Zq?=
 =?us-ascii?Q?98ZtTGrMRVUzwUPqsfHxBGRxXkl0wnruY3GPYkUFKg1AJuSbx9qr63ptsVrJ?=
 =?us-ascii?Q?E0GLpjGXd5Gimloz0H4glu123b6fQ7B7TGe+wvFrybIh8r20RL6D9fFimcMy?=
 =?us-ascii?Q?RBauddgHK7LS6kCbxrAgcfnMQcYFd8rKk7P/1XuzDT3wl+WKbJjkher+RnZk?=
 =?us-ascii?Q?wgiTLGY3IlLpfeq3mFnvXTQHBgQ2qmXDQXY2wUpVfk5rKzh6g+IgHmV5E1ti?=
 =?us-ascii?Q?q3VcH2I+ZmzHLLrxebBPTYF3iJ/d4ku/aAkFAH3/dxwzO1myPDngwxn1x3ap?=
 =?us-ascii?Q?Bg9qTuFGP7SpUR38tsCRlBZjnBZGR/jJge14ItzzUVB7uYia30L6qGkCCp7H?=
 =?us-ascii?Q?+CKE572yOSCYflDP8b+b74L0Iar35JWkqPCq6YHc8akDp0cQGwk48yChrpyW?=
 =?us-ascii?Q?zjcSjwBZomFcTCMfTBxW9H2N8AZRuXY4/VZyEkqd54xMa8+x9NV0fLptqxyp?=
 =?us-ascii?Q?NzkA+xEmZZ+sR0AGcTNQ3iNp1q3y65J63/7ToPKbEFk+zkRXiz0MZImMakoI?=
 =?us-ascii?Q?940DvufF3yWicEsz5JGClZ0BZLcSx5mV/ZiSyoT2YnQCAyqQpILbpL/8OiiX?=
 =?us-ascii?Q?E5ZszoRFLltYiRPUzw+GP+NCJN+RoAEJZLxlbVs3BDMYIB3hRYr4+Ct18tkx?=
 =?us-ascii?Q?bj4/kgKKH3lOG1p38v5TNvHRIX1x/SlJi2U29j3Acz41AjeuOw6NOZrTlhAI?=
 =?us-ascii?Q?QUybJzypYOtv4SbkLzuyXfZN60eWepxVYIzHFlFhJcA/7+SKRtKEjtnIZXS4?=
 =?us-ascii?Q?bNtv07UOXrxyJYvbxC/Jig+piMt+HCgJ64IE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:48.8656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eddbdc7-0701-4079-56c6-08ddbf771e81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094

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


