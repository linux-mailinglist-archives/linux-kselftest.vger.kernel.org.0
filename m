Return-Path: <linux-kselftest+bounces-16445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73739961506
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982DB1C20E78
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4121D2789;
	Tue, 27 Aug 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eAZQ3GLE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B251D1F4C;
	Tue, 27 Aug 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778169; cv=fail; b=omyqpk59hvTb0ZikEiuAl7+F/fnforXxRelrwd2+pY41zUjTxkqlIxA2uwEKMHM4clB18lt99R0D+jMAX9lerfsd0LulzD4emx+Wz/ixR2Z4jJuijrzPDJIYLi4wJd1I8Sgmm8DvDbQoz5YDEkMnu7DkplRRP/Zn4SnmSfpkzl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778169; c=relaxed/simple;
	bh=t9eY1fyHXhxf9JCtl/32utwMYMPkSXolXy5AWxwRSzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svou7dI9cI+xeEQbJ3d1G3q6Jfj7F4nNYtKlUrGNkHGHe6mVuJmULdWHeRFJKjwROx7+YejfIawDckmKEvaJii3zBxuF9ujrs1aa90edRCTczGXSosxWLslnYl6X803X0rlYCcqDZCGiiJHSUZIenn5R+4LsjOu7LVWAO/4R18U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eAZQ3GLE; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG6gUCLsfXABb1Hat6fJOAuvcHXltuvbglX3dYr86NDUgefuzH+nQjR7v599ZM7IKrpAKdgYY9wZqgF9HjyEclgjGycp2HrKa2BukevbAFeG5+1lCupGbi6ETJXbtnwDhBtZOs+6fRFoRGvacpGXwKcyRofH4AtKVI70szDuRQQC2pKchbQ0LUv5m0+FANemZ5Dz0JxApoGBERwET9v0xbqMVxv9aYoabOjQb1hr9oK17p1p6qKU1EyDi3B7WoIfWR0YHkP7mCv8z5pZuRzMf5Cr6tYsllzMooXksxBeKz584Vb0NgbhFK4SvhZytpGnHtq7weZ3OEKpvZNt7PwDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aF/ljdpojKR5leSVeKttvQG1lVuwPWEwGdFW9et8EY=;
 b=J57Ct1DwT4QHzU6YdtJ3QWfUyhghMh7dOOk+JAGJ11NACmHQiWtNgDIw7Jz7P5FfbjarKuGkN5QxTti12IW1SBzQVpqXAcmcYZF/NKwvvoVq5nHEeypEa8gt9CPfKoms03CakyluG9n4yaQdqrs07k/vHBLw4negnGgfuzH0LbWjsToMagBan8R6S7xL9tdJMnGLIUawLn6UGVz3efLHzbBIdPleX9xuIbDrJkDBM70YuLDbasEd1FEqpuHy2WK23r+nnGMUm13F2LL42+VZQc09GaoWb0phKFyTZE/IiakiJmrZD2ZeHy0lAlRsgjI7NfhM7m50mb7k017SuZgNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aF/ljdpojKR5leSVeKttvQG1lVuwPWEwGdFW9et8EY=;
 b=eAZQ3GLEdXLN0X27Dof6CCluoJBBN0qeQ4lKm2tUjKt3+geCKOPjPQeCsBN0HsePiXtnTdxhlHfCAskcuVXVrhWo7ohb3mPj40Lzqj0/JzTEyQrapLa02WKMtrgfEB146HzfNcNJ/PcIIunrXEE67RtYDplLGrtAmzWa8oHhvjBZM1COjSDNdki8rCHGE20fy5B4C7o5toy4S/iSVoRA/2VwmhVD8ww/4bj8MNvowc9SGgS1lUq2vFLijmX1EkTxs+RwAL6pfdorbrC1Ud/2q5JJBbiWW6paIobHd/C8UfoAiZ6UNc9DdlHvk44ma5v8G8j128OoZfojzJ6QwiVC9w==
Received: from CH2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:610:38::40)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:02:42 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::ac) by CH2PR05CA0063.outlook.office365.com
 (2603:10b6:610:38::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 02/10] iommufd: Rename fault.c to event.c
Date: Tue, 27 Aug 2024 10:02:04 -0700
Message-ID: <2c9a3339e9aa633993428d4ad41ed2f0d268dbbc.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: f36e27fb-2170-4892-23d7-08dcc6ba0ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MYX2jriCnQQEK8QtOEMi9nhLDwUkbKm24tlvxIkzPHwEN05Hd6SUvPBlkVTe?=
 =?us-ascii?Q?nVzzL1AFCPMd7XZ1TmwkS4W4aoaKv++hV4X1lzu9IiOY0sj+WZPzAtBG6hil?=
 =?us-ascii?Q?P/MavsKrEZHJC/hphHqCCtShqVOA9aRvYD0w1ZwGFzFTsVN/a4OuN8pr0qwi?=
 =?us-ascii?Q?M9PhmpqkjAL++rj2rBf+Tg3euaSBcnk6MCzEVAVKYGXMxMAlGsgl4rWX/F5P?=
 =?us-ascii?Q?0cm1/CsZVGRJsrG0cb8Daf4VVCg2ssoAaZ+H4l8OLyTpDGZWW5rsTL2gyDvJ?=
 =?us-ascii?Q?Thtp94AWR4+CkQPiRw/hGx4nLglIlrKIs3V5exgaO33Suv6pcLSigyKTStHx?=
 =?us-ascii?Q?+NvlKAvA4gmdBT2GwqjKx785ywiIhM/0tQVM8AX34uYayzmliHRogdFhffoS?=
 =?us-ascii?Q?+CcPoJCYSqBsDc49V3T4NdiJCUJF1TLffCCmc8jxhN67kIlx+slfUCqAHVqo?=
 =?us-ascii?Q?31A8MQSFEHJ2zDc/XYEItmd+2g5DwVtfrBg1U4aCKzwVk+JY3MCAiXT8D7kB?=
 =?us-ascii?Q?da4+RmgjWtFwO9fBR2H9WgQkyeUAM/sLcKX7b9sMXq0zIwxkSE9hOl8NVvo2?=
 =?us-ascii?Q?e3du6EWH8RroGyHne11lG/3BCJnctmEMqaClhNcDhpZxfKkLHwjuj3bVl61b?=
 =?us-ascii?Q?KaWOt1cCupbJOEZ8T38d3y+pHhaFRuoUVjX/igZw9Ddm9jyOIoLdOeBDhYV5?=
 =?us-ascii?Q?vB4SpLlLGP9XCWjgiV16M3CjGqGfIcfODTWe9XQFdHGIvRfPmCJUQsyxfdbO?=
 =?us-ascii?Q?3opaNWwR+0XqexdwMk8dqq4tZ9rs7nqcrCdXzlRu0tZZN22/hoBX89+xwF14?=
 =?us-ascii?Q?w9FytnYjsIddvi4o2ksANLxGxVnYs6s3iw27niNNBvpxxC5wFV00+9jcRBcp?=
 =?us-ascii?Q?Dnqe/ZpR7/IwwahTKe+ggo38SHOeU+NFc29QxiHkTO9sV/NFvaeuXQvtTCoq?=
 =?us-ascii?Q?b/ixm335b/IO9yJVodRNz97e3w0Ofmmdf+vLT2nycCG7qmkL/cI+TxdY2oe+?=
 =?us-ascii?Q?7wQWWzD8Aflc7XwH9GKFb0cHTRJoJcbfM3F+7pH6In9/faQquyzro1VWrf/T?=
 =?us-ascii?Q?bC2zcMI0VJf+nh1FMpzwRCE4ZhtLLLZNcGiSowhL+5vkqg0K+lDDJiIqiZyy?=
 =?us-ascii?Q?JagCCs5XbvGTaDezOpBRSLU+Nk4kvBEGqXKT1fwAEkyYn4HEoQ4f3OCuuFFx?=
 =?us-ascii?Q?/Hiudbo13Q81UJN+14GgD/00fW55OdVpO2dkqoum+GerBz+mU0oIDaAxrJNP?=
 =?us-ascii?Q?JxrHWUKhcPPRby6peAdovf6COgzUv1VrAFP8VCwebtuzrXc/xI13wQQmbuSf?=
 =?us-ascii?Q?EW+HyDzaEk7OIVO35BtC1di7iRjhVlj6Rfvn451EyGPpcWDU7th0m6xrTNVe?=
 =?us-ascii?Q?eD6cr2gaWMnXrOFlmI8dvG/06KHSbXEvNkyCdiYCS2bhT5hKSJpSEmn4QegX?=
 =?us-ascii?Q?17QDjMgUA4GjgN9DS40qm31dFjxGK4uB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:41.1883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36e27fb-2170-4892-23d7-08dcc6ba0ff1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

Rename the file, aligning with the new event object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile             | 2 +-
 drivers/iommu/iommufd/{fault.c => event.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/iommu/iommufd/{fault.c => event.c} (100%)

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 288ef3e895e3..baabb714b56c 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	device.o \
-	fault.o \
+	event.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/event.c
similarity index 100%
rename from drivers/iommu/iommufd/fault.c
rename to drivers/iommu/iommufd/event.c
-- 
2.43.0


