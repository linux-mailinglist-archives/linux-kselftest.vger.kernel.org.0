Return-Path: <linux-kselftest+bounces-20340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A189A94AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA841F23484
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E82131BDD;
	Tue, 22 Oct 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAEG8GDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFD126C14;
	Tue, 22 Oct 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556431; cv=fail; b=ZCbgpjy9u6G/GvRy+fHfjFNbp4WMKqSaNyOtYooC+L9O0Y61ciuY1H9eqOwn9+vdXceCSvOqjVqNw+xtlx4+WT7DJvBQ/eZmT1trrLWJ2Zror+n8i40NxPlo3AK9VuZj7eil7FwAJMJPTtCLSgFlRAeWZtKLgfsD4sWyQeoz+nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556431; c=relaxed/simple;
	bh=zU5dBdo9PnKtkWU30oLHIfo9nGpGuSSi/oenS6hyH2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHy7abde/Wc5HqC6iSKxJIar38ge6JkjXdvTM4WPzZhxgtq8sqMZMD91oLR0xazwrAU9oW0yRG1a5K9E/AlynROB5PzxcI864shy9fuh3HevBaJ8DHKAfiojwhM1bMRN6d7468UHL7mr57OAhrXeki47j1Az8glSJkX6JWsVfUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAEG8GDQ; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUxPb7KgR0RyLdtjKD4ejGUe1NVcNaS3Z9AKyig9OFUTvWe7m0hm2P0VHJEsSGd0GhmQ7+PrGQEaYnxG5PZtzL0nU6wN5ccMx++qT9nvtheJwLHzfTp/3mbn8enpHInUuRfpBHlbiguMA4PT8wKOKpej+sl0B+rSDWlGmopqt539uE1W9ItIs6rkmRIRe+ySfNPaagp889kDg6S++pYSZJLWsXA5raQrwsZsvkXyUQXWR/ixb9aI7+b5tjoMgOHp7ZLmzC3jtWCt006yXU+7ydZoADBn2fD+dBxYPGrD7EsHdzNaCNYpmdUpssH6Iy/5YbI+lOsPzXNW3Cjmj29AjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDOVpruPVHaeXX/yLPhF82POkqZ88LWPXhGzJ+rlYmE=;
 b=LJuGxXMxWLm3MbVXKzhmAWEGYUUITCo+4gNQtgythCWtT18XISfYIAB88TiHpd4K2MUIDwNXp3GmgRdGU+nXZ0J5BPWNU3clV9vh4WO87UB9icx3uzedY5VpFuEcxfUMYBrSPgkO+fGShNjWIr7hqNkfKGWOQJhmkiEUVv7aS6v579kZ7TKZha9clj8ikNc/sEwnmP+EeCG3Uwdp1vOcOrX9Pb0fKnhLiEoEk2bDCYGJU9HjN1yP/QmYXijbYhECoMaxItSKpOoqsxOI8gJRz1VuSvrnBU/ND1JeKX+ey8rppeNykLpsYeWNVjDqYqrdAxrxp6rebnzaYif8D6+wEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDOVpruPVHaeXX/yLPhF82POkqZ88LWPXhGzJ+rlYmE=;
 b=XAEG8GDQ9+iwgz5QYBnxgNSUH3oM2sF8DzOQshaET8uir9lmjT68JtpbtZHzTVFUWYwurCAFZnxgN8cXdnkPQQDjv6I+eGXLNJXP70PNEgdDSidaCiYRNGhk5M0RkZfy3AVoPjtjeHcf7ww31EN++Ar7K6oZDEStxeKiXAA5Ej7ZwHl3lq00M8/E4RadX5DvTePFY/+CYPsETi2BtWGKNjVPI6rvnNfFXgNdO7F0rZGizsQTEK7N3t7Llui3UDdqAlpoDGSn9HU4ip6/CXa28hWxt4Tv99zrTBbErDw6wDOF5dXblO0MyV6J4ID/zYwye/XInAmm9vygaE7xIgZ4sg==
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:24 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::90) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 05/11] iommufd: Add domain_alloc_nested op to iommufd_viommu_ops
Date: Mon, 21 Oct 2024 17:19:27 -0700
Message-ID: <1314e12b76edd84a8c9d0f14a6598538c8eeb50e.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b40a788-fb50-44e1-d181-08dcf22f52f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JR1dMC1sNuD2TLCQbudjDLiT0eN10ofKJzXldxfMRfN6CdAtACMnK8URBamb?=
 =?us-ascii?Q?AgJU/cnGhzN2le1hS4JVzFdmOkn6mNZAH9X58LYh99PyO961PhahkbJTCGWh?=
 =?us-ascii?Q?cxmlj7GtYd2n+X4LoStpU41mn99xccqO+2kte5JklDY1AP25YBsjjgvw8zmj?=
 =?us-ascii?Q?Gq/6IqexII23T8Dde+et9wDYivCCl3yiDzlxfogH++rdahAE/wdXpo8omD38?=
 =?us-ascii?Q?KKTfna+ZbVQGisjN7SXk5Bf6RuUN4Gg4+SlFyvmgd/Mm9Q1Uqa/sw3kJ4tJx?=
 =?us-ascii?Q?w1Q2fDTYctym+dCNQQQxxE+12aMgzTWDWOsH2YloGe6hA7T/0wwJJpRcXkIS?=
 =?us-ascii?Q?Y/bGPDyHFpPKgjtlvAq/TkZETRPNRbg+OiiXaSJwsrkJb8kz2tez1oaVXTGF?=
 =?us-ascii?Q?U/L0O4+y52zSG8VuCqalCOLJwVtux/aeTxfLueXESDZdCibMHJD2aREUW8Lm?=
 =?us-ascii?Q?7Y/QJhEfJQwZD+RazwjQ5G4Dub7KV+nmpN6QG+6MbSEDXfAjEJt9gwa0EO72?=
 =?us-ascii?Q?Mdh0ZOCLESyeg0gSaYnUds17LiVf1JeAaLDSV0KT+eeIgPO256utBsl77kis?=
 =?us-ascii?Q?Akz+6AvA45BAop4iYUM7nq/a4/tCPS8XJIFB5tMoKlbphicaSaJ3oQDaf6ZM?=
 =?us-ascii?Q?wF/7kW6o0z1gLTU2EvywCPQHRQTRYHxV2amn/JTV3itrSUXs5/A4zIsGFtZo?=
 =?us-ascii?Q?Nw1nCA5bHqU7ShOtBwygDK3Sx+SbFdH4ylLVTXokitRVEGnL00nF8dCnZVO2?=
 =?us-ascii?Q?pY5tBZhzyJwMilxt4IQ43Z7bYo69eoCHd0u7DaWgIV3nXyPjLO9H2V+2ChhD?=
 =?us-ascii?Q?Y4def0FG0vqgH9QkXMrOylzhnN2rl5UGLgu420S2OLqFmNg6/wvsFcLeumnE?=
 =?us-ascii?Q?BT+V7nsjgsCWq7+p3BGad4kFwIvTt85pu2XAwtkqYA1g5JCl09796sPPVRyz?=
 =?us-ascii?Q?2Q36sLFG5bPzM3sBDDkIV79SB7YN6X5x5YdpAqLCASWRDg5x+i6tu321FODH?=
 =?us-ascii?Q?iffZcaEtafKP9CQCFjpJvpwuY1QOM3v9Sk9iYMMVh2kWyWujPLL/7Wd8dDgy?=
 =?us-ascii?Q?8uPDx1ih3tdkwlISGw3/ajvSN4u5PqAxPADHBvSePvcVKup71h1Pkwau2VX4?=
 =?us-ascii?Q?07clh5l7LhkoCMbhZWSoibfgPquXjEozJNFTq+Mq8hr4+P9thxAFOdZWqD94?=
 =?us-ascii?Q?0hRdoAbk0LiQXZDiERIQhQTAXXARSjiSGioaE9V0u4XLZQG2rsBThyfCNVoS?=
 =?us-ascii?Q?FHhcqvrCpvQNZbX6voLm6JS1kaPLVpZE8NE1Zms6TZ7QA3D72j0VO6yOuj0v?=
 =?us-ascii?Q?mK9wke1AnewyPWYxezHbEGQol7Jji1kLIkijVo00Nrdz33CACDt1ZZ2TeYYC?=
 =?us-ascii?Q?zSW8fswRRA93lMtkp/fD5+9jn+mQvNQFLO+7mRNdyKQf4rBQVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:24.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b40a788-fb50-44e1-d181-08dcf22f52f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

Allow IOMMU driver to use a vIOMMU object that holds a nesting parent
hwpt/domain to allocate a nested domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 55054fbc793c..5c13c35952d8 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -14,6 +14,7 @@
 struct device;
 struct file;
 struct iommu_group;
+struct iommu_user_data;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -95,9 +96,17 @@ struct iommufd_viommu {
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @free: Free all driver-specific parts of an iommufd_viommu. The memory of the
  *        vIOMMU will be free-ed by iommufd core after calling this free op.
+ * @domain_alloc_nested: Allocate a IOMMU_DOMAIN_NESTED on a vIOMMU that holds a
+ *                       nesting parent domain (IOMMU_DOMAIN_PAGING). @user_data
+ *                       must be defined in include/uapi/linux/iommufd.h.
+ *                       It must fully initialize the new iommu_domain before
+ *                       returning. Upon failure, ERR_PTR must be returned.
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
+	struct iommu_domain *(*domain_alloc_nested)(
+		struct iommufd_viommu *viommu,
+		const struct iommu_user_data *user_data);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


