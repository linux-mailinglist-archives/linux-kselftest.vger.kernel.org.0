Return-Path: <linux-kselftest+bounces-25142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D5A1BFB5
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9830818895E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9F182B4;
	Sat, 25 Jan 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sGSpnhsW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B020C148;
	Sat, 25 Jan 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765076; cv=fail; b=fq6VPngouZ1XAeR3Nt58i/CupSam7mfQML4OsMjrMTW46TbYao6be7ZWp/OCDFfz+mWUGIopHu3Rdca15Ku8Sx/9xbfwn3UwtrCKZr/hSKyC2e4yYCmiYb+2UR2WZZg+wNObo7uNlxiwc4DII/B8/WpyThIx3c9eRCPidvuJkmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765076; c=relaxed/simple;
	bh=K+5L3HSdgIfiT/YMZGM1NRRJ+WNYbPntlxZb6t9GOh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYBFfZGo+VHQZcM3M3UyPdpXrThUaQR/j+Nw8c9lDdDAkOqZrwJomkBhiBBPdrCUmK+taPvDuLUZu8ZIhNQJDgKZej4n3hlVum9Ama1PgXHvyHAGoAJYd7x8PJedGsaUChCwZ6o9+84thibZjZybGDmMCZ5Ln/f8sFtrxoMlkVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sGSpnhsW; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkZPO6fiJijkq1+QultCejnQOEdM2j9IoQpBRKHHkTgX7kbMBy06vR/Mn6z4EfoL5Y8tS3s1RZYSJITgAQlAXSJZBYj7VdanI9QbbVtzdRQk24Px0kBgmZBULWw6k0E2pc3bpkq6QDm2h2oH3GsJX/S/7Jp8xBbzEzbwOXm9SvtcSggDwrQebbbMNflYVRy5lmnmYcVLKdoi4wf//rYdzjZRPitxst2WJdkgEpvuW4n+r1lwBln8AXy2IyHFk9+7pXLCHZBFfgnX97FBgZy+N5lH2IQugcUBzbU0F/dAQEgt3SfxBnkq82zc0tq3FCIUu1amdT+FmxKUSkcrSDM1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=lg3h8NknDufKS1etZsLRGu49AfS8mTEMtCKWEtFtuen8fWya405O2EgXGujInXNEQKl0Z2d+jdwsDleqWtIrTabOsmEkszI4edTJP4yndBuQ+bt5cTqL24PH9+eKDwIIfo2bUJhauKz/Mnk1/tD/y2ZUL6K7w6F7eO/BiSQy75nQVqkEVDQAyC6cJPha2UIbLA8c2aRh3z44iMTMKFQFYuAnbZNgIKW7xyqFInCilj6iVTRUycE84DErjK9zPLKytQYOod19x4MakipfhxvmdxqwWWXRJ7IHuiDMCCTA0/vFJJRKgQ/veM9xPKTs72t6ES8TLhSkhjpZriNrpjetrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=sGSpnhsWH7+bnN02dvtxfNalM3GOEjxJ0MBUTEwQ88GTjoCau2xbzxeCDkcnO4REZ82cpxK9DvfwJsxXwJYxwd14HIpxD6VbAkp/HEmxuWpKsviMJgNxanCSRTreBmXbcsDOg2IpQ8ziMHUCDakaLcthBQ1rBNQNsfK66YQGakXlYDkJd/EZZi6zdrzx9MQwmsHna1VXdygvDUFMosLGRqKkUpeHL5ZhAK8+VYfx0j5e51aX/WORdKMNN2FHiHe0LceDDY2i6T0siICLhKQErhWHG+Fr5SEcKQ2VuJDWN+cOUaW+XteyrqDQj7qxe68sWuhqoetZiIbFnH9O0Umc7A==
Received: from IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::15)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 00:31:10 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::e2) by IA1P220CA0001.outlook.office365.com
 (2603:10b6:208:461::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Sat,
 25 Jan 2025 00:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:30:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:30:57 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:30:56 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v6 04/14] iommufd: Rename fault.c to eventq.c
Date: Fri, 24 Jan 2025 16:30:33 -0800
Message-ID: <2f6add816628a12ff138ac9836b6945bfc78e88a.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: d004d791-dfa7-4039-114f-08dd3cd790f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVC4MOE96p6VYE9X49Cg7z/RvRYxN7vcmLHxejWvUmOO/VtPwCms4HQiRUIu?=
 =?us-ascii?Q?dPOpFEMyw0mOSE6CS7e9PwikHTHOudo5Ow51li3qEcJJWq71G7fXuYYfI5qr?=
 =?us-ascii?Q?uV8R6uBrJcSInlk3Jqya7yEQj+6IqPvS2jU3oDuwQakw6+vY8p4dkDM4wRFW?=
 =?us-ascii?Q?WfpYmclkp2TK6/77I+NCCgkLWINPkAQLhp/f5jChUzR3lplDakeAUtEbEjR0?=
 =?us-ascii?Q?KAKFGcWteejTsYoELCAGZ4Wwp4r9Pj/HcvFmO8IGvOLnLNgF2+n0TCrta/NF?=
 =?us-ascii?Q?DzdgnQzY9y3I82tNi6r11KDHnh6DUxSOPQpCqZcG6yPVbD6h6GIvTXzpFP8a?=
 =?us-ascii?Q?/DUwyH0eKRZegBTZKPzjZFRzW1vsYXs8O4CBaq/Y6xk8cXdNSB1d1yjgc9Da?=
 =?us-ascii?Q?oRPTA5Kiv494W8ZuwsPhnwo40DymlRpA0b7f1XOStPL65yjPRDhPdBtOi+zM?=
 =?us-ascii?Q?d19+Z6XDX5GVg2UgMnt9w+6j6vcc/VQs01KrHv++jrCY9u2K3F8fhDL3OK6o?=
 =?us-ascii?Q?Zf2xykXPsBLi8+I4ekPRgdYYg61npInztUVvT6HvL89FZeDClUI5eXSBN0Z4?=
 =?us-ascii?Q?1MIflMPXmqIlTtAeNe9P0LXjIbCZwPOdLSKBoJ3volEJHr5Z+77P+FYnwQoD?=
 =?us-ascii?Q?LFu7KlVtAVyeEVZL2fITShqTeqoZ+oV+WWRtqf2J4adjn807zCfdtBxz9qZG?=
 =?us-ascii?Q?WEzZQ018pXdmQjJY6sD06jcIpvULFIiARWG7ubvzOK+3qe01LlMPOo6lt4+l?=
 =?us-ascii?Q?9JqIItRKb4VlZ0VyXuRMXFWpbn+vAynfqTg3KF+pTPzLuIISWaLMyJtOTQ7o?=
 =?us-ascii?Q?R7spzAlODzlQ6xUTcUF/c0UHpHtUMu04wyiuLtnccAA/MmKAwJS0x/6cbkul?=
 =?us-ascii?Q?cX9WFsnc+pgbdefMsj4SYEgWcOl9IiBxg27BFWnw84NHV92Bsev0jGowD1pJ?=
 =?us-ascii?Q?i3x2v5LpeIMZjyfQ/Kg2SPPxHbgsSxpIcVLn0UFWSGPrdCAgZR5XysLfGRNS?=
 =?us-ascii?Q?IzyB0GiQ/mykLkTQcF6MYRUMioZ97Yr9UrlwBncvYDYx1F9VpVap+XK9OCy+?=
 =?us-ascii?Q?bSdpzQRA89lKZYQW9umZqf6pvdwnQ/s2iVRBWIQsJ8CH5Jq2pkjlVNg+anHL?=
 =?us-ascii?Q?t9PPK1GnyPdag7yZiWy9qzomNskGHM+G/vMGySK2c4fBhwtS9mA9eI+ZaZtM?=
 =?us-ascii?Q?N4EseIKP9RM/3WAyUXcxXKuJf/26WuRV6PsZi11FGhm5v2iVnmNAIQUaMXjq?=
 =?us-ascii?Q?wRUM0i70aicJTRb0GKTm5ZTWC/WxqSPJy9H7a6FzEJ39wx3p9l9iB6+0ts9P?=
 =?us-ascii?Q?IIAMu+jcq/s8VQPkV0QUT36uVvIE3LEx3uhBP0AMKfGzMU8a5FgJettbOdnx?=
 =?us-ascii?Q?h0vie8aB0el20qB94KNYmWNTYApL12ZDYN33QQlkj+OjK+aXkoFez1JdVp5I?=
 =?us-ascii?Q?hr3iiXzSFfWDPdyjds/Zt07NI0hYaVfr5Kq362JFG88+ivniCYZFUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:10.1800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d004d791-dfa7-4039-114f-08dd3cd790f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

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


