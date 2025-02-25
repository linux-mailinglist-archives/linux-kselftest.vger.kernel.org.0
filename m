Return-Path: <linux-kselftest+bounces-27498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB39A448AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CA48840F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B219CC0E;
	Tue, 25 Feb 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hImp3Hyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C217B418;
	Tue, 25 Feb 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504378; cv=fail; b=MMJSbT0+IfAqMg3e1jBOze6KvXcsa1oFtcwpoqsKhIzJIXBz9tKKP0aOJVyDMOH7YJO6gYyfpQea9aG3alB7HTJkwlyW2A1TSbo3n8mqwhignAqnf76m2wsJa5JSAd8VW6FnCeV+EepPuRuBNIWKLVHg+t79JA98pfxiPV42xTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504378; c=relaxed/simple;
	bh=K+5L3HSdgIfiT/YMZGM1NRRJ+WNYbPntlxZb6t9GOh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed3NHszQUH3nYRkZ1niaz+FmlfwW/5rY2O2erhJ7390aRilCuIi7m/SjFZK81IQ9REODqoePJvZabxTxBt8gVKrEss5gQEone6BXFmxwneGJzz+PBPfbF5MkSKrwmnt8u4B1AOwwf/DV75BkzyQ4Dr6mViDUWraxcuVSEoHlu1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hImp3Hyj; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B26IWHQ00EhVcilWx6dDlfFR36QSZObhLbSo1hRnf3Hj+PnFlRUTx9V7LOyHXVm9b5kodoZcUy5s8gj6eRnsJXz2osB77IZ1GhvYiA7dWYqc4OoE/WCcdrxMvvQqhFS1rSGrfJ9pSRjvwD3nuFhShi4xLzZke3+Hvd8ACCpVq7pxa1YBpOe7YF1BYs6SLbgcUZe88PMJOa3nvpsQsWiTvq6vIzYkGAbUJnWWOdHUGv2Z54fGYlGqCobWbtkZoLMPg+Uwdof/YQay/kT/G9yyH3aS2q8dMxvl4rCC1ZXlp0iUNn9V73kfKYDSwJTlQ2gKomkKcgeVoHcNRc6PkvJNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=q8K79Hvk61aAsaMtHV75NnkSpUGZdcZyJXxpytHo6KBfZe4s4mtZcUiezUdDog7su+dmwUQHPsmhKM4QH19+BH/zstehW5MnpVjQeSfdh5Pfq+S0TKfTcQncW9awCyL1dLlW5zE9LcQu/mDsV85+A0fyPZQqdWM5thk8F8zzesIhJMtSn6KSedZ2R23D8aKiz/CwId88fmteOIr2RSJ0b9FeBhAfOUhg/jPYFgDdOFOAvIvKd6KqmZ+S2XDqw2UHiBqLBmH5ypR8jwxY+7BjMrtyPPrdHMqBScTb8PwYD/husvg4V6lbUpUbFMY4sWgOWa7H2FcRzQXi7lH18SnSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=hImp3Hyjkv8Y3/o9pqUMoWDF5FneDX/9LV3CwrVwNLzI67mu6u7mpwI/qhtVSwFrQIBYOwwEA32PS2Rd10j/VpZjlEUn1hc/s17D9jfbdvBe1lBN5sei5ZrVV5LxaeGNtNyLqpXr1IOhIcf34oKBwngYWGguej8h6yXOtHPyoY/j0YJo/TMlYjpW7YLgPPBM+S9iNq8MrwmyyBuZkEpqR8/DlQGMStHKe2haEh5zwobuuJF8DZ8SnMUHq8YJIB9QVFbnWQnJZogvJNa8Z5xz3jkw5F9brkFT4+T23P3KXFKm9+xQ8XtYsNm1Z5yG0mW9CIZTSLwHNftr8tJVZJ0EwQ==
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 17:26:13 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::93) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 17:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:25:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:25:59 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:25:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 04/14] iommufd: Rename fault.c to eventq.c
Date: Tue, 25 Feb 2025 09:25:32 -0800
Message-ID: <60b7038bcccb7b5a3937784441da8459f5e4fa10.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9155a70c-453e-423c-f78f-08dd55c1809a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QbagbZUVsq2qidoEH8PTRs0CKeq+N9KBuPnTSBpGCpjMYg93Q/VyUMI8aA3?=
 =?us-ascii?Q?1FsSlhuJg7JMwgWu2IbpOiSOu+4BKxx456N06KpuZ3J4JrmOVnC4YWdnFoQ+?=
 =?us-ascii?Q?GbajIh7AkrW1OCn1BEwWUvUHrSZzlJLoYGFGDmDLdKJXUm5deoxoTA6xxlFE?=
 =?us-ascii?Q?+Sfp0bBL0wiOIerdltU0miNqSyo7SLdIMnis1x8ojydO1rlbVcMjDXKgdYLk?=
 =?us-ascii?Q?8XUpD6n54zCHKQGBtIh3yC2POUaWv4i1S8Y+2xcJA0UKqU3pm1wra8mtMisd?=
 =?us-ascii?Q?cu501xo+tIJNt7vmb1WZSqJGFdRLPqzKRHYMEs6NFW23cuFnzta5RQQQ5OjY?=
 =?us-ascii?Q?XaqaZhCEXjbq3+EDOqy8QifP8W4pOzcOjDPf5hb8xpCxfQlILAWtCs5MFEcO?=
 =?us-ascii?Q?rZIggyuRqFBG9KHgcOpYe2bD53MIOPbsHlaCwrFiCMPf7ihfCD97dX8Tf7AD?=
 =?us-ascii?Q?NUTunSeZZi3yvTlCvVmMlK692r4kVXH7panFW85y/rcu9pcqsV5FZOgScN/m?=
 =?us-ascii?Q?GbLTCte8rDZUM+KJiOSJMFPxA/PBYJmcFpY3YJunHHW0oV1mUXSu72arRimv?=
 =?us-ascii?Q?7KTTYbJekFoOTcA0M4PY+qn8/VTyY6DDv9mgFVSYT3clr+NgRcc/arq7BPeo?=
 =?us-ascii?Q?HUMZSn+oAy7hc9IoUxRC3ak+HeZOSBMCYjnDSHaHTjzOTwp8cBOugzOWeq1B?=
 =?us-ascii?Q?vVZmePidNaa8NzqzlL7/NU+2yB67i1vxlWPMBdm9hxOO9W4CqvIQihT412dZ?=
 =?us-ascii?Q?18oPCIZ6f/Ym7WH66j8IY8bdHvsOLogBhKdw57QELdS3oPUn7ZN7I8XwVihl?=
 =?us-ascii?Q?xgkRPMnMTmBWgl1Cbgx//ZtnsPXUULtcScrr/dqP4hpu1OeSSSwgLYUTZb9C?=
 =?us-ascii?Q?Yun7XiF4tQYwOrwuFqmlL2udhBVo/hTDSd24bk8ToKaAN3dCn/PAbPRNqr00?=
 =?us-ascii?Q?bZbSyEVzgYi6oIXxv5a3KQ6G1rUdIQTtTQk428J8M45jpGTwA3gSxwlnSDfH?=
 =?us-ascii?Q?N8tKwbHHQACu5ozk001EEYhwlcRPVcBibZ2FZoBmiBqjugiUYX9isWlH1Auj?=
 =?us-ascii?Q?w1Ycw3I/W1pKpjwCdy1Mg2CSfF2l1kgQAoljOdM7e52QWS+4zSwsyBn0FuoQ?=
 =?us-ascii?Q?TZd2uHmSKjgHaBcOiBmq0+vwgHOpb58z19dQdOrZOxTnHGIg5o5nzRlWrTLU?=
 =?us-ascii?Q?B9rSk7bngUAkTjfUaciIWWPq1/JT8LCuwPQgy3482lkAC65B8OiqS5uUAb3x?=
 =?us-ascii?Q?odI2KmMm4SCkBD0viIz/yzX32jyRKgcZ8YzeVhss0DlLv4qZLzc5wYHp87AC?=
 =?us-ascii?Q?44Iy2U5y9G3EJxQXZ47iHvQ2PYvtwPzGFzSMV6TszHz4Aa39dgyoC7ZZQi3/?=
 =?us-ascii?Q?QpVanf1ItNLh+v+vUom+42v5zNXp096+N4oKn1YClVtvbhH+vxXbcHmb5RhE?=
 =?us-ascii?Q?xFc2DqIiq9oX3IlC051WPOgXJOD9M/RzeXE04STbjx8YgYhlZTpvJXbNuSzV?=
 =?us-ascii?Q?adZ7z/A1jxxai8M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:12.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9155a70c-453e-423c-f78f-08dd55c1809a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Rename the file, aligning with the new eventq object.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile              | 2 +-
 drivers/iommu/iommufd/{fault.c => eventq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..71d692c9a8f4 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	device.o \
-	fault.o \
+	eventq.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/eventq.c
similarity index 100%
rename from drivers/iommu/iommufd/fault.c
rename to drivers/iommu/iommufd/eventq.c
-- 
2.43.0


