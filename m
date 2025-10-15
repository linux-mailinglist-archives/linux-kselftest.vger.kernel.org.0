Return-Path: <linux-kselftest+bounces-43148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5362BDBEAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A3234E5E69
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20CB1F418D;
	Wed, 15 Oct 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAueNliw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C81EDA2C;
	Wed, 15 Oct 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488285; cv=fail; b=CrJ0P890xBbV4sUIP/sWkutvnFNpLKdnHCjcnjNVqaYPjF4rqYezmZjrqv6u8C/7lLZTHs9H6nms2Znu9oXgp9ibc4qQP7zKgHlsm2PS41ive2w7Swf6fyqFTAuD8bnZv6h2k+J5qdDo34zEIKrmLzO2jaBlBwFH6+J79JlIeQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488285; c=relaxed/simple;
	bh=xlAuFtmvkgwhOog0+m/nr0opECnbMqJJpQY0/PGJXN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdJOXZ/1MkTA+QW9n56F6V2wNyyMlLJZ6C58XjoCCInfq1apjSd/axSw2Tfh0TAf8BbcGyOzJWai1ka7x/XoJpHpsVf2WVhdhivCuX9Vrbg59bGdCp/hc6zN1Om4D3H1t9Ux2jnbGNZpI0h2nKtyGuHeOUDmTsF7OaIayq8hFJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAueNliw; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZyxrogPrOYdl0VQvgITnCQp7rm2H842I4u/N7AYHhZ1jCStlfOsL/xAik75wiU4m+XdGgaErYjSAeU2VnIdYwt7REnaNhhDzAvBKjYN6YGC/qGyZHoQCTwqUWXAxP2LpaNZ9tr+Qip/ejNE0edQM2xXQhooihKHQGFz/RIywxP/C8FzOAeVJsUfDJUaFenG5uyjTH93Q+QGa/G6XYkOycjvaFld0DewwmGaMzH4v7UVZp/OqMgBpvTrqwsVbyJAX0R60ZAWVNFV2QLgyQZTyMBJNZ/7yBUuqoiumuwe5bsDM3E1BEIk1eLY+l7rZ4t/1/phvDNCuVObRk9atcTDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB/H91IlLxrM3JfXG7zGlDA+h24kTxU3OWonmnnuc+M=;
 b=YmQ5viZpLnE9D1UkTAd6OkcvN8eHWe6DaJQ+9jQ7+Bm/4qgLBNnGqbN2gUgEER0xapWhfD+Ax7CriU9qFR6Ic6wr8PaQH36eG2krg3bB1E3ClYU9FCojazJ4qZVDQy9VOYqC5ppvhoAeyHw+LWphCoGOvBRHqdqgJiJSo3g6J2ankLSKwmA3pu+d6yUewIcKv6iwDKp1FjgZP04xCxj5vPxfbdkLACq9RhRiPwEX8g4VfMT4qRyulNT4jz5+9rdsofYsAZQ2emfD8vumf1I0k9gG2a4FhSKwO0QdXkWvUF/PCHAZqwMMNBVrxf73G9tXRkb3ud27X3xyYvZalP9Yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB/H91IlLxrM3JfXG7zGlDA+h24kTxU3OWonmnnuc+M=;
 b=gAueNliw23mT/KMSk5peWN6Mbsb/5Kp11v7u93U35v7sUOq4qxwaqqiHrKAcHOhmvyrex477wbmM4/qbxadBriNsmCjXMcCBQ5NQIfuYdfWosqUIwC0ffzAeHng+L6XcP9kMpbl5AuwgBDXr8fnzRPrtE1tI1gOrm1f7JjDABo9/ONAHcGK1ac2uDncTgSMlNt53PbsU27bA59k6OABavTFum7NGrOlsR/9yC9HYBgR10YT9zu4HtxlIbDk7VTyM1wgm2DwPrYm9+KkzmNHfDlvSFcIXd0enfstrggsLLmpBZC4PeZlQ1qaMdJDP9w3CmaAYGU+WBgK+w3lCT+4a3g==
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 00:31:19 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 00:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 00:31:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 17:31:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 3/7] iommufd/device: Make iommufd_device_is_attached non-static
Date: Tue, 14 Oct 2025 17:29:35 -0700
Message-ID: <dbe30ea6ba1122a96c515ab14c34eb98fdf5c6af.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4952d1a6-d422-467b-ab03-08de0b8228d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hmkxlpX7TdIVclha7sukldlxBy8GNsoQmKEPJn3Hv4Mu+lpFmPSMsFpQ4w35?=
 =?us-ascii?Q?Fe8I8MJ9ZT1EczpeqN4GxmtNHE32J3cnQ3iPNzY3VQrDAIN/G08l2cG19vzT?=
 =?us-ascii?Q?wtYVv1MpmjYKRyuq7Zr+vmHK/7dVNkAzPlJm8mz9gKuiRUj031wQTa/Clo0W?=
 =?us-ascii?Q?ZMjiy2X1QN2a2eTfW0kh18QELUEoGDk5pHcdFsvRXZQZR8Nms+1n1acUpgov?=
 =?us-ascii?Q?km5UtBtgiIwlOcCQnc8WVizHwre84dO8uZEAJiZqv2duW5RUYXEqH8VhpizW?=
 =?us-ascii?Q?LG403Zf8tFjGTd+3wWgS0lFAeYaD7msuaG7jytyzeif41QT4I1xg82cmXjQ+?=
 =?us-ascii?Q?4SMfYcr0Yax5K4qRlfGmeyX+0Xtezob1JEKCorQ9g5ag19o/pseYSeFoanLX?=
 =?us-ascii?Q?M9b4l/fDeRc8vkov9LfJrgD4uRIv3EIQrNkxqLEqSpmp8oW27IWkPfDCa5/c?=
 =?us-ascii?Q?r4Y4ePdLP5cQBlekcR5RFI5Ni/PD4xlaRHbWReo94Nn1FERfbpEvv/dS6xHt?=
 =?us-ascii?Q?fWaQ8JyaEbgOWqxr2kiH2qHnPLY2DcvyofNzBOZqad+HXQ0SdHBintp2kmiO?=
 =?us-ascii?Q?a43lpc+P5ILuuZsyCaFXserTWmf0XcAjJLzV4y0ITIkELQa0pWTSEhbeEQUX?=
 =?us-ascii?Q?rZeI/ZaXYnH/VUg9zv/rGBAfiWGGmBJ0KZ6aEKis4/Jku9d1Fd3XO/vmr343?=
 =?us-ascii?Q?Yi15Q2NrthVJ/msltC9owmvBhtDfsptNkFuWebubbZL4m8/mQzuvfRIBXnz3?=
 =?us-ascii?Q?jH8LL4f079MNv5f7BGQOja0llli/WAs69ndWIcb02Dfu0AXx0npFrhaIWJHs?=
 =?us-ascii?Q?CNMzfN3W9ZhUWPQzycIwGDZe6NtXs5ChYG3QTv5D8StiATC/mcWxkm3mhcF4?=
 =?us-ascii?Q?Xk2VYS3vraYbENL6e0oy5OGUhWxbzPwrfY9jYEH+9RVZZ3IujIxhLDJX18aw?=
 =?us-ascii?Q?FodAj46u1EhKZcfSfFt0V7tZK1GtQiCU23GC2eZxglYsXFcao/Uu/OkjPSRC?=
 =?us-ascii?Q?eE+Fkkjo/ZUyMCfnaHQJcqnEKkgKPixrm1gDMxVKXHVT1tJgW1obXzTdiw1e?=
 =?us-ascii?Q?ZXCMSVSKOGVVFVm4xsGUmFvRVSjsd15gRGedRlMaZxozHRzLSUoQOhHyV8Jl?=
 =?us-ascii?Q?kTV75RLFd3tTVctf61LIrgwuco2R+6Fb+0kk+NwAlsbTz6NYOfvdX9OZo89p?=
 =?us-ascii?Q?ifpKp/0zQZN5IRzhUVH5tzJhVqtQeINCPQv0rzMp+8NQ7Y9SUIeyY0R7ItEX?=
 =?us-ascii?Q?2USRzx1h+YwXYDo00GuI8a3SBbsxH9vnMRa1QjeY1OLZpaclEIMslmOB0WMc?=
 =?us-ascii?Q?FTR/pOTIvM4GXXvwE75DiWzAtkLSGDUU8zf224Rg6sjSbdhNv9IhJlJKg34u?=
 =?us-ascii?Q?VJUX8pqJfcMc3+NfRMC5TLZ7V0h2DLpiw9TJKeGrpF6JQkpGM8E3pRQ7V4vh?=
 =?us-ascii?Q?93JHfTPdo7Uzfj97gMxsTe77uvqqrYEZ1o4bMhzNIFvDGZezHOBz+8uVG1qA?=
 =?us-ascii?Q?FlZvnJ4VzIxmv6ZAHepGnI84nLGG/WEMREh8h6QrZFTGCQcYyrcYb0k3RWtm?=
 =?us-ascii?Q?+svXiEoBjY0NcGn96XU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:19.1566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4952d1a6-d422-467b-ab03-08de0b8228d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

A new SET_OPTION will reuse this helper for a sanity check before setting
a per-idev property.

Given that the attach handle can be NULL if device is not attached, add a
pointer check prior to the xa_load(). This is not a problem currently, as
the only caller iommufd_device_do_replace() verifies the attach handle.

Also, add lockdep_assert_held on igroup's mutex;

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 1 +
 drivers/iommu/iommufd/device.c          | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cc758610b9f7c..c458ab16736b6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -502,6 +502,7 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 
 void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
+bool iommufd_device_is_attached(struct iommufd_device *idev, ioasid_t pasid);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
 struct iommufd_access {
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2a816533dc10e..45a1d1603c009 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -436,13 +436,14 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
-static bool iommufd_device_is_attached(struct iommufd_device *idev,
-				       ioasid_t pasid)
+bool iommufd_device_is_attached(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_attach *attach;
 
+	lockdep_assert_held(&idev->igroup->lock);
+
 	attach = xa_load(&idev->igroup->pasid_attach, pasid);
-	return xa_load(&attach->device_array, idev->obj.id);
+	return attach && xa_load(&attach->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
-- 
2.43.0


