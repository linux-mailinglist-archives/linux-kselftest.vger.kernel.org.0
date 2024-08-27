Return-Path: <linux-kselftest+bounces-16424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F258E9614DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234861C20E38
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115091CFED9;
	Tue, 27 Aug 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8BkJEuR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD591CF298;
	Tue, 27 Aug 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778112; cv=fail; b=p2XlbDRzz/+d4Oorh+WxvvpSWo12Ij8neFDe/fjPapX79kp/NOETrkvRTJGxYxTdP+0qBkV36R8LokNSwF7AmHQ6irrFhCV/iHB3feCU1tl+LwK+Vb5/Tz2C1nH0vcsgrNv67PwcY0TqWfySW0kzdwCg26hFeq2T1WUrZjalDoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778112; c=relaxed/simple;
	bh=kRFbTaiChsxVIhRxZ7KGCox8Q6SkULwzCZgRsrFBFSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdPsHS7JcLuBnGLUAukwI5V5NeTgQC1/47lSlVr5uq8nCwIZoFO4ARBbUuVegZUekFFVEb2dDT30d3HMDjDcEUWMySZH1j8nHkGZSZd4iXNKPNsHgaABEF2OJsjnFZsnBGCJ7L8QxLFc9jRsZNIKLOHvlM/hgeyOq8z8Z1tslz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8BkJEuR; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0T0QLzwQjyxn0zRpPUDeMq6QYouYQKusfo0VgvsoL+R4G05JzuPY3sMVrJCDj6aSUUDkisAlMygpCA0GzeZrWlnNg1D+gLOXnq9eHvzCDslSlLAJd5TDd6OCA6OhrMUTjDvZk3JWGKTWUh5rgfwROssLKkRarL+/uxwdBGIHFcXf5bIFQ3OA0ahL8wrKf5l/wdrZ2auQgsSzveLbj/OHri5qnMD9riMu+Jpw/8JRUxsyfLACUiVpk2KlzYYmbdldjgcHRIyn4yj+dbcmcxqupzwn3fuwWt+uHDJ8dY+5yGlAJHt7osmtNwcSRIsJijN/inwpk9CFlEoVqoFkoxj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV+bBiFmbtQmzC/TL6Ent3fVUs1+ONbtJSJX9z7T9b0=;
 b=C56Jj96VnzufXzKiZcMPUDJlp9okgsTyBZeENIuSZ7meSZlxmm3qZiYyYYZRl8JRYKoqAFeYM0KUb+qrfh6S9Q+DfQ7luYeHWXWUFw7qrjYrPTegCoFO16cDwtouqfWrFZ0EhIqCPpn4EF+pCBjX6QZ4GVmXGc6fUvcXIYSKOSrOHcgEA/JSeHNzpkoRtu3u3sYntgUVaOxe/Rot/OWSY8glefYPdP3Qd8q2mruTjU4jMzjUb8UMHX7t1L8DqLObXIwlz7/ri7MgeP5mGFc8izYVLGMj5HP2NBJdq67uhi8Uj7JSO2Luuov1X14X7wRJJQG3Y+UXd8R2up+vmJnHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV+bBiFmbtQmzC/TL6Ent3fVUs1+ONbtJSJX9z7T9b0=;
 b=f8BkJEuR2rGLEy/qnckredNPKWXMlj6kKVxZr7cmTsE10w/aEBQIcdZUTIRAUi0zvVQJZBN6tNUEnSyw58xw8+YNoisE7BkDDfPsjoGpCn25XmCridzR+/lEiCuVL4JQgZ3gCos6h0w/3a+sO8s+uyfdBG2XN2WrtOA0PJRkzG+IMjH/9vQFHKLILss4Y6nHkzoWcQj6DNJ9eEUn3ddZ/fhHjBIYT7XUrmnH25CAeTPKVgVKyBZDnOVazoiffAQeGN4RGcEclk1UbjU+QSmiw+cTcoStT3HWwVogmuFP/L/HHywzg5+8MgfIQpoFnKh4Q3H7zo1UWFADZDlqFYt04A==
Received: from PH8PR21CA0001.namprd21.prod.outlook.com (2603:10b6:510:2ce::25)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:44 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::91) by PH8PR21CA0001.outlook.office365.com
 (2603:10b6:510:2ce::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:01:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 01/19] iommufd: Reorder struct forward declarations
Date: Tue, 27 Aug 2024 09:59:38 -0700
Message-ID: <c5dd87100f6f01389b838c63237e28c5dd373358.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2755daa3-2d4c-4174-0a13-08dcc6b9ed78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GXnzoiJOUABPQfrRGAhZW+SfhLuSFNLDfgdb0kfqSLb3pRXqYu40nVhorhwf?=
 =?us-ascii?Q?0ll+7hPBD19EkArk3ayV9st45uH3QZyCJAIgw2lAkvx8zNSGoql6BnIJjb4+?=
 =?us-ascii?Q?R5RfVhK9CRYdXwQgrTGxq26pWYbmgOH3BFAufnffdZVxQ7C7pKaayyHNbsr9?=
 =?us-ascii?Q?VceBaQsXPRcmgnjMwP//WVdWsPcMHWtmf+eqXcamaftRpvrB11lmJvQle3Zb?=
 =?us-ascii?Q?AH0RTKoa8RbVLdulp2yxlJbWVKpkM0XP9bQDmgYtiKAe9/da7FBU1P0derdu?=
 =?us-ascii?Q?3j+/8/aWvaRQAx6vTkCyZjG53DzPIMABoqJCy1sCdmOVcFgj5YTIVuFX8qcY?=
 =?us-ascii?Q?d94mofhImr68NAjDPsu9J/qxExcKK6g/Yte30tqfjVxNC9z9czuEdTLR17Sq?=
 =?us-ascii?Q?cmDZX6tJ9tIeg1VWowL8Y7+2+/5+fg5Uq7oogLTKhcODfoSMC0hry4vhaDn2?=
 =?us-ascii?Q?YtF7O022JyGP10t0TGI6JEB5iIwA2a1lksx06j6HAWgPL2wCxoG8ofY/CsMe?=
 =?us-ascii?Q?guL5Bx5HhRJpJFR2vzm20pbcAU1aOUmVU0kTT175LhOsRVuZRsa3lky4gGnG?=
 =?us-ascii?Q?haDKGq2OhgVCtTYWp6ijX8p+8+Ym5Izhf8HOaF2Re16TjNe6bF2Tzjq2BT4P?=
 =?us-ascii?Q?f03jnP2QWkiqQmESFHYHMsmQMUUODjw+lN23BjexUTGSOR3oSo4/Cc+vQyQQ?=
 =?us-ascii?Q?5Eqb4a11EDJVyz2Oha4Y/3WCvPp7l1fdBhSw+iWBMrDNF3S3E0GO4c/ejm/i?=
 =?us-ascii?Q?DTCwh8aoOIft+/U79OW/rIZBCRSiJQZyo55wv8zRqijmzZ+gPmDulrmDdoyk?=
 =?us-ascii?Q?pb10huciTHuG+d3pNusvvZ8b7rmB0RjOKTBtkShHtpBLXBNGvIXEZPeqTwad?=
 =?us-ascii?Q?jQVqrt1mSw+YSKPtHcMLVoh4e+pR0tEghPCScrAIog9hkreeHK1FPh53/2cA?=
 =?us-ascii?Q?k5PQGCS9BjCD+5bbGQOkrKtaht3X5esP/+QbO+5Zvop+KrrblL5GBtWG681/?=
 =?us-ascii?Q?iyPIqTiTEp3xnO6xa2XfE4XbNdQfyqjerksb0QLd6lGJ4T1kvtzypRaHooAD?=
 =?us-ascii?Q?Pfk0Noo8v8NkJZxt2mA8Gox1y6aE6SFeGRm2Bq5g/yvgurST9vMB2ggYTTb9?=
 =?us-ascii?Q?ER6X5WPfneTrLAcvWizz6I/7pcBDPDjBp40sIKlhSsrWBur75/afK/R6JbK6?=
 =?us-ascii?Q?7lPLoV1K8nKxh5HUynpj/FAn6AriNqBwMW00Tv3L3ZhktwDFvTMi8vzLkpCj?=
 =?us-ascii?Q?VF7eSblsEeZYUPSTPg3qlvkKnxDrBMuah0NwJZpVDB1SjH0WlUukIzLnDa6d?=
 =?us-ascii?Q?svgD9ONsi3m08exmBlCB2g10OUbbm5+iMJAcw0kCYrGBkFxShyK2oSfX7wsU?=
 =?us-ascii?Q?g2C5Gx609MGwJeRFiVgOmImSB4RBxJMCiFO2xjwSNm7dLk4KAOO1Oo5vb2H7?=
 =?us-ascii?Q?wOhjIRbjUwoMIUoWu5ctmMbKKaDVGBqK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:43.4146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2755daa3-2d4c-4174-0a13-08dcc6b9ed78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

Reorder struct forward declarations to alphabetic order to simplify
maintenance, as upcoming patches will add more to the list.

No functional change intended.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c2f2f6b9148e..30f832a60ccb 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -11,12 +11,12 @@
 #include <linux/types.h>
 
 struct device;
-struct iommufd_device;
-struct page;
-struct iommufd_ctx;
-struct iommufd_access;
 struct file;
 struct iommu_group;
+struct iommufd_access;
+struct iommufd_ctx;
+struct iommufd_device;
+struct page;
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
-- 
2.43.0


