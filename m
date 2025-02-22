Return-Path: <linux-kselftest+bounces-27267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44563A409A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806A817AF37
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625D1F239B;
	Sat, 22 Feb 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fhs5MnS8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4580C02;
	Sat, 22 Feb 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239678; cv=fail; b=eW4EPypYfMMhZ8u6T6apd52MKYj/KKKUEl41XITklKj/6pcBm40CiWEjXTsIJcJuAkDwTyhGvSMXRp4v5QUgte9G/heAxg8EW2Bm/V8D770DNtoPaQ2T/RLZ+A8Vbm3JPRh+5pt/x0Z9ldw5V2+zQsDlwa11R0HbNxbHkCSFd6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239678; c=relaxed/simple;
	bh=K+5L3HSdgIfiT/YMZGM1NRRJ+WNYbPntlxZb6t9GOh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i93mTcHIHA39JE9ARXhiZxEh2waBh2mtzCrugFoGQXgWSW1ofvMN7uohAXR3vy63jYo/81C98VGFjj+IjicZ01FH08K04IN6cUz7HkCRqzjXbflfdncf59PC68GOl1RDTu+0zP6VP+58xWyZ14xiKiOXYd4N9snvavbn9hRBHGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fhs5MnS8; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugBRyIgx7cHjqRP1SDfEIwJR8aMaZ7LqztYUKRyYiI3cN2DgUUc8QyX3BdPTaRjYZdKuu65WNLrmfyJEmbsoTtp9za9uOonS4yvW8yWG7s+nsz2o6SWwcBgRIIt5hMLjlX7vBmjZ02P23zWcKbvnNnLjlp5SzS+nKe8DT5Tjw2YmCWFbZj3ptYvmO2PdKASsi+CDr3zg32wTUiHfI2BjfNekEekLQgxtTwKkAh0T8wHo4Wg1+DH6Uwo56vX6wLp2fupMII09/bNC1fpKO3PHSJM7HqeIPIkMrAfOFi9JH/SvtHx7tpWehZTS8xBciGMCC5bw7WHSDs6NTWRWzkM0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=aUkjY4Oo151RRfezWkyEcWan6th+rAvOdFvf8ymNN2EgEzI+DlMwyrUSJLb/hAtVlui2v9WqRc3mFBmsu8mfGnnUmRgWnYhII13XINxs04ALl3Zgmiyx8KwXIeLoenlqHeAIN/Hyd6eHi3+DbDzZ8ydd6zA7Ys/Au8GRo2l42fzUOunKDfKZL0hy2q8f9GBwRZEZydjjfIaTpT3f2iEQX+38CyJyb7R+/vGq4be8zIG3QZaivqDfycQmYDQrwUKM05MuZX9lbPpGg7J3nuadevjOEmNiRR+r4wArGEwXDbQcfbVLw0kCEEoDSKVF8aK6J0NM+owzV2v5h4qG74C1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=fhs5MnS8FmNpiKh0HfAL95fY8r9IXHsZg72dMoRoDD0pavn2kda53zjeESNE6fjgANd+z2mUjSuq2kqDrDdIw8NJiNjk0GXkY8sOcrZfxtoiwqzeF16cAKvP9mY9UhBXuppgepRv/p4aijN8y4wNEMRGLQM0ADO5NzXkx3hc5hcxhkk/grbJ/sUthwRAApyXwOTBFotQ6eQVU501LvoC0MhBh1Ys3H1CX3av+JMcmbRzc2wVpJdJ/Z3hXcrUsef69j9vCdMmJ/ReozjwOqa1SiTaQjOF44w+xZxI4ud2i4hxe9+imxEooaaE3mQtjYfZG4D6NbFnzrnX6WxXzvPFjA==
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:30 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::e1) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 15:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 04/14] iommufd: Rename fault.c to eventq.c
Date: Sat, 22 Feb 2025 07:54:01 -0800
Message-ID: <0455dad035c7eaa1218658377c20c77da2e72e1d.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 62656368-a1a5-410c-29d6-08dd53593179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GP1SK+rJB/KTOh6FSwBjb4YnasKjtqMAye0/ZUHE3LTTGeUI5QoNjpLaTW3Q?=
 =?us-ascii?Q?VmeO24wjrkNKVDUZChS/Cu9TPaVbx1eChWiJi8D96qYtVkgAt330T9D10TI0?=
 =?us-ascii?Q?7kJtNrnVbNnNStW7IQ+o73OPIzxSHWrfmEEA/ktzdbl5UV/mgYegbPs5Tjs7?=
 =?us-ascii?Q?x4tqg8VYtRZeaZFm6Zm9KipZtGw42WAQthLvBuTJit+/abus6x33aMmPhXEy?=
 =?us-ascii?Q?PDEP9entnAzp2oBjoQpumJWN0vA5CtnCbQgwK78Q31V2VQj0kwKb28GFJC4B?=
 =?us-ascii?Q?CopqTW1SwC1TSPeRGiBeWJSnzaza4ur+rOyPQaoTrg99AOIXIdyMKxh6Dikh?=
 =?us-ascii?Q?jq3WNK8H9uuRrSLTTsq2Hi2mogwEJbhsSN9fwI2UJkxi+9QHquNDl+CjshzN?=
 =?us-ascii?Q?ohwlQzNUJ1mzEQ80kywnhdGcWPnLRiYlCfATYXT+q/MYtK2St+EIJCzq0h+Y?=
 =?us-ascii?Q?7RqfKKP0kdcW+9zoGErQHYdglgcTSs6dgndpLXH3++0KbTk+y+4o7RXYUpwf?=
 =?us-ascii?Q?wCXiR6jxOQckmiJIYx2w3Dl2rTdSDY3I6rm7apAV77RKkpqjGhhIRlgrw0tQ?=
 =?us-ascii?Q?HH7TKmg/3tsdhNqSrCGJHy++wuChhHMHAa4a7uBus0e4fOdJbfpT2BSV+8xY?=
 =?us-ascii?Q?Yd7DHZOgyGTZMUltwnuBJ7bPydP7ZFtFC6N3wBfrP4h0vfOI3LqZ4H4r/zuv?=
 =?us-ascii?Q?X9/NaYn0Irsfx+kZ9kumSBfSa8CMg+QtqIgDFStwB4+2vb/G2apz/34gTqHp?=
 =?us-ascii?Q?uEUL8jZaCmYcZ8hAIg6ep767hOJ2UcfFS2waWj5VdBsYQCjwBNMiSlxJHmwX?=
 =?us-ascii?Q?zV2b6S5L7l/tLmRHPz1hrg12kP8GFHC02f+7lgWQ/cJ6W4J/CTbXYjlSLguT?=
 =?us-ascii?Q?8jTkpTIXDmr7nIIH4UqnRykKaEu1c29Ww7aEVFp7BKNV5mCcp89NiFTwUgUy?=
 =?us-ascii?Q?fdvur7p+wAf3RaZcwK2xKRFGZQ77OXpsgU3FY0YkQfEYx+LagX5EPALqR4mi?=
 =?us-ascii?Q?82MGue4e6RB98xv6rJu8IB1DP4KM04HJ4WkXvAhERX/VrX02I8Z8x1kdzqk/?=
 =?us-ascii?Q?limBtSxGHo55qi9myAsjedOJ/2pdC3sCJz2FEkdzNbOKK7r+kAokAn39jO8C?=
 =?us-ascii?Q?wYA14vuUazF8NXr9TMZc33UwqMjGsbBvRMr1HTYHrQXuxVYEzK/kVPcKqTvp?=
 =?us-ascii?Q?aC7FJ3ZQmiDiahLzocSk1lXeYEpc6BF8eGwlinZ0Nuo3WEJrySZyRyH+8PUP?=
 =?us-ascii?Q?AwHHglJirvJ1iBZ8ph+JAzepLg2OG4L4zxPhFuC6fCQJdax8gq/Q6EBfsFBa?=
 =?us-ascii?Q?XWhhLf9uyuHbh1QFWHlhfrsfUw5wVBVc33Y9Isi08TxRAs28qiIvlht5vooJ?=
 =?us-ascii?Q?0OT7kIzLhBnik7PnJRkDGqgqshx2i2lHZHcEwxxN83SCSrMztN3IElMFiRH5?=
 =?us-ascii?Q?chTZY32U9P1tRsEaEppDeuUAJP6zqlLuq7k/qrBmJB81KSz1jJdeoxpjfdtB?=
 =?us-ascii?Q?qUhDEWPxJIW9eqk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:30.2603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62656368-a1a5-410c-29d6-08dd53593179
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

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


