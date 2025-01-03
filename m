Return-Path: <linux-kselftest+bounces-23890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72778A00E84
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8431884A50
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4D1BEF71;
	Fri,  3 Jan 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hos+yd34"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BF1BEF61;
	Fri,  3 Jan 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933482; cv=fail; b=XT1XYaOsS9v97ckvYIBZyxcOnLA/6NrxQKgTweaxYYEwn3FFfbd1fuB1P29hJa2oPKJk+JrLshOMF8h2EMwRMaiPiyPYk8HTtpRmjESAde2y+Ydy48MiODkGiDJLtg660iBpucKpZKbLKJkUzQF0DrjHa8dPu/8ETjB5KcdgoR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933482; c=relaxed/simple;
	bh=HgR9pU/WYVnlKuA56Ld27vYEISxXQMA9ljs3drkM3dI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVN7ItaADmdjFGs7HtJTsJ1yQLfJheuzBEu3ZTC+dZNXR6innEoGWkbfmAHC2Bkbs1k4rWceQi2Lj+hFLiZJ5GqmX2rIsCQ5R2HsAlsGxHFLwet22JV6zElWJgZMLaISWmwf2xJP4nx1cA9Pq/+gdYt++JMr19KuYAA+eavd9gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hos+yd34; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e60CFnQhclrA9b/GnrCWXaBIeK5PmPOP8dzioMEO9X54kLhmbp/KHG6viHI2Zke8S+uGFEkoqx/PR3P3h9y0gjpk7mllIBmmWhLf732jrTt0GbZc79wiPeG1Kfu75O/ibTiWw7dOQZa3+IoYi63kRRslF70XXKy4jY4d1GqWUUVFTZgbmC/P7t8NwAwbo66Inmu5mflzvj5EnUfVpj9idlIPtJ4401n9yeZsmVFvQ1klF/D0OM/djlDs4L27W/1PZ5OWzJAVCmxd0EeYtvgV0Vk6fWG3qlgkCTaDZw3+JNBWGC3fi57GkQRGOdgzo+v///AmKt/Hvkz7TtUepZAzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixi5UWHGVXrm7JunzOhhOYqV4e1PUcbjLjBcYtc6OZE=;
 b=jJ/jmhWXul0sj/BerzACJp0j9FNsXlqOg7/Z/pTgHoHMrtgFGXNtngPIh9f3HqS54rO3XHJKEYHrM1PauCEwnA0iIXhxETgkV09yA4+TLiC9Hl0PXM2HThrlKcwMYUABSNJmI0SPYunyiL9fTmM9doBc1G80hM9rT3b66DEQXkIb8gFl2OqEd/mQrgzaLvbWF/TdEcqtIKKGL7LeYgJ07HqqgmTc3tlmZ9TPgP+u4DgfejDsp3jDUyORHGdY3kKc8OwxNU3xcL5e0LyX5Vip6j1rbisFFOE3voYfG8l3G5MEi7lrmbfdeoRJVKJ9hV+duDc7KtW7ZlKepBRmvG89cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixi5UWHGVXrm7JunzOhhOYqV4e1PUcbjLjBcYtc6OZE=;
 b=hos+yd34q5P6+Pxcfm9IzlGcRNBSHqMVznPxu9FdLy6gaCsRctrJM6VMpwuzFBUApNG+7D2ZkJZCXntsYx9V+57DOXnXLAtQQ9qR7vDH682VIX1v3VY6g4YlbydQ2ETzmRcYTR/SGsyT7nTOcSLtquxT2yzAE2NY83gaDg+zAYQ9/KCC3TsJLKO+V/GpTR1hLhZvtza+dFgKQVLnmJ+o0zysX3h7iqnwueAFy6bLVjQmNCXcwrbevStE8fLZiwAatyG+7b+iq9Gi6hm4R43EyeRlzcz4RC7Gl6q24z2I4/Wui2uIrjj6FtrniZaygEIv/WJ2tTT3G7SDrQz/4cqFcQ==
Received: from BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 19:44:32 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::60) by BLAPR03CA0109.outlook.office365.com
 (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:12 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:09 -0800
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
Subject: [PATCH v4 05/14] iommufd: Rename fault.c to eventq.c
Date: Fri, 3 Jan 2025 11:43:28 -0800
Message-ID: <de1a507d2393edc25395242d1c9b704a36f02296.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: c34ddaa3-f501-4183-7dde-08dd2c2f0b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?au7EldK3wXo92ZhhlgfVutacs5TMzhF4qO0BSdWvrhuK4goCz4KJrhIY0MFy?=
 =?us-ascii?Q?3jdBuJgUEXXrRBG8hQJKQmQiUsfW4SlIAMBcI4baOUrOORITGz31HsHbYzkx?=
 =?us-ascii?Q?emXISe89ALiw5vEdBxC7Bre1uTtIUQZOTeBU6zddJDbYxu0cHd4Vb46yKaUr?=
 =?us-ascii?Q?aT5fns2EbhPu3s+OzTgskdo+ppgULlLSc0crERA6KZv2Nr00q33x9ozk8cXu?=
 =?us-ascii?Q?DItSN+ZJIReyLjHdSHD8NU8k0xPaO5tB22Ox2O++s4kYagUhqatSc85LyszI?=
 =?us-ascii?Q?sYbULrwbZg3vzO1fuLiSYDDWP1f90+YAQT81CuXwGQ6a2E1gNIL55px4r7ap?=
 =?us-ascii?Q?a3voi7kfs0HS2N0k9QBl8CwSoXU4YwTFSSZObyrdi6+Cypi7WHCZJEQAt8Qn?=
 =?us-ascii?Q?4H3tDMXdU6R7Wsa+dhPKakIHX7tEleI9MI75MMsDpwe9VOsbipYrq19CJdp0?=
 =?us-ascii?Q?sHZ2GmgrMg5BpH3E5NliL/6AdRsQ8gA++Mf+gq5ajH71ctABYBbIQzzFRQmk?=
 =?us-ascii?Q?Erb09QBK4Q0gOkA0dSUr6/G8536PTsh1Qhsb26yRhlsCyz0LfKmSPcJvAbLV?=
 =?us-ascii?Q?6UrMMqwQ8EKWEcPw1tXOltWrEHToS1LLZJpYBfmxvsaqda5NkXIlRq0OLdP7?=
 =?us-ascii?Q?Y+yrb6dMw0uIjGHJgiQ6rNDb3atnTNbCFnr9iBg+6zTqAkdngIOgQBMfOu6m?=
 =?us-ascii?Q?7lAD+XYNe5MyN8dCUdcBtdJmn4IIeUf87/RjPTM5BWmSWP8jov9kodDPaBT0?=
 =?us-ascii?Q?Oh2qnBmbr/92AjYFMD98ToPCY7jQitOONfwlQradpjdLzHrscBemA5RE/fEo?=
 =?us-ascii?Q?cLUSpgKhMHADqYg3tGKQv+5imTZPs+4CPeR6y4Xl7YbboggN+LLuBxXCpvrU?=
 =?us-ascii?Q?vi/2zl4yx0bdzqzMAyAlDgoy5BIxSbiJXHHkmZZL2UExTqr9wX6FdvQqtpUy?=
 =?us-ascii?Q?mS7jIuGwzR0tB0xKaD2m1howieI10oe5eT8uXgz1HN5Bot1cm++oECEnxpvK?=
 =?us-ascii?Q?eRfCgUYQkbn2BV2WA8oprh8C/tKtUTf5/Ue0AdWd0aKG0vSBW3q3HLDPIdia?=
 =?us-ascii?Q?7i69Kxu2be4Hr6gW0O+U7c4IM4m2uwwlHVkcOX1k2AP5XBv5dMVavBx7++Be?=
 =?us-ascii?Q?1Ogs/pbkYbKsAgQC7iWC6yKfwanA7HZFcuW3twAeNhL8F63zJ0zMjnDntPrg?=
 =?us-ascii?Q?UzF8/z4Lso/21wjH25yubjTalEw9RjWg6RMF9u9AZ2hpAiKb8zkyBYve+VIp?=
 =?us-ascii?Q?OZC0ypl8SXVfGrk6sjcB463rwnu1XRJMBdbOSMJV2gX5WsGN6q8vB9JsXord?=
 =?us-ascii?Q?tu1a31ik6wPDjvjy38PAFLDwFWwes4QQTRwpLPEco07Ovp6uEe9bokp/l6PA?=
 =?us-ascii?Q?OEvW5xdgO5+a/9GEtao6MWxkt4tdYnq7Wjcov0LOcrvfgBmSRIoZ7uqHbIk3?=
 =?us-ascii?Q?MZ8s7xJn33Q8XObcdicxQ4Bul2ZcrdFMSVlA7fwNICvBmKT07/ewHGXQuLtE?=
 =?us-ascii?Q?J/+MtdMgY3A7Ls8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:31.5490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ddaa3-f501-4183-7dde-08dd2c2f0b15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369

Rename the file, aligning with the new eventq object.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


