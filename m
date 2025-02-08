Return-Path: <linux-kselftest+bounces-26085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE84A2D501
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC60D188310F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2A1B4158;
	Sat,  8 Feb 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMsmvueE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201971B0F18;
	Sat,  8 Feb 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005410; cv=fail; b=derieRIe630JlqZVL6ziVDXsPSKj8xh4oQWpgjRPzYhe8iCUDjGLbYtz3EXezRwadXfdN41teKVhofnuVvnUo0KrmXa6aFJMpTTr538BEkXHg7nL8fdWIc8hc7RnL/kBbVjw48xWYv6n8piUBD3H5ODn9jt77RUhS8FO8lV4R2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005410; c=relaxed/simple;
	bh=O00i3Os6v/VLiAdfxgTUQMko40QeAiupyl52Ji91FQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGb763VwHgJrWQiHXB1kI9eRFgZfgngW+KrAG1Ff4dkputs1GC6mdjn7gadJu4eDFJqd8PNbcUIMCcX9GqPT7U/rv19BRWFT196DKdgvNeXiJKP4aOa7GI1uGnAp8miOlUNU3vaqF1tLvCCUMeHZizX+G4gnH+TgqMu/BqCsxc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMsmvueE; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtDdvIardcFT/HIHg0m42JHSN8eMCh4DYwpB4ugeWt/VXB9tSnEeR9hvM1U3Jt5jMXh7XRE9gk7MFc7N1jAgB2/FscmLKuh0ZT58/lPfPJ+ToyNWPpJDMEMXauVMOrnYg+UxcDnkOTQRXtnvKaL6menPnFCt54J4j/AZOJsCBfFMO2e2DqqiZnUhMvVuYayZ47NilgIlCi5Ra4RuslIazGrtse0Ebl813EUap0tN+f/kL0jvuDvkAoa4G9yOGjOZxRv7T0mWZq/7UxJlwyGP2R4eI3czCc/nd96xtJKd9lhGBuDFdHGPsTUqfJjo+tU51L0zTNkzA26VWiqbqsxibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtyYcfARc1BFgKEbovuSMr8RNTNvaa4H4rMbnUKlesI=;
 b=pvQoAKq8d6NMWGoTmHXhp9nWcAWKEYeov76VgLGJFrSsv92NpzDNdd5lSxsy2i9L62x95PGqdanIrPGbmBa++pu++mQXbbl+WNaVV7IvNcO9WRpfi6lQahkKeLvinju5V00lpmcYyLE+hELFOAB2uq3YKxmiGAT1K5p9kWCf2rS0H9GKQ04AVP7PKEXITEVK9XLMI+yJjZbMFvXnj7eYwC/LjBYzRU3ThW7SlFh3jZA6za7xxLAMgShlSUknMD3v6OSnDlESGOxe/sskNok5BA8bHRKtMfaV1UlffJyz9RJVn4/FNF3mGG+A8LsgTmAa6Y+1I8/GKrpcPojfWLECXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtyYcfARc1BFgKEbovuSMr8RNTNvaa4H4rMbnUKlesI=;
 b=YMsmvueEzmXrJvRwVAUvVyZFbnwQ6aoI1QeinEzJ77N+bKGs/QPcdpiVrxbfXSOOlxR6VXXWG1Xrg9n+v2uYi30f6xuD7dUMAUM6Qa8W4qAcp6BGxcYJJ2rArb1FlQuidl1mRX7LQlG9Nws3lqBeuGwwLFq0Z26SzpAxtxn1NmDaY6N+taoXDIjv1bK2dWP/X7rwoMPzOJ6kNoPrZqr43ZSgAXlfhDYt5VSrI4YwxQJPdDDw97B/+/wLTRtBHGm/WDChU+wNZeZnIXQgioZU2nXi/A3r6v5YZ8PafxHtkfJF06tadFX8lekBsfeczYBgXi9I5du4pekwh5EtXBpEjw==
Received: from CH2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:5a::16)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 09:03:24 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::d6) by CH2PR08CA0006.outlook.office365.com
 (2603:10b6:610:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sat,
 8 Feb 2025 09:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:15 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:15 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 07/13] iommu: Turn iova_cookie to dma-iommu private pointer
Date: Sat, 8 Feb 2025 01:02:40 -0800
Message-ID: <11fc21d52f4121250c682a3c1178100ec8ca0547.1739005085.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: c346c939-2e41-4dbb-4898-08dd481f719d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rdXUawtUS/1s1vAgEAmfdah/DmfwINpFpK/sR2yJeGGHgYBD277XzYZSCvvR?=
 =?us-ascii?Q?fDT9nlXeaiToeuNXnLBp3ahN5OHnkpodVRV6V50vZZN9mVU0e+xaoZyARqYH?=
 =?us-ascii?Q?6V7i48+ceZ9UZlsMg5fc69jGY9LUfM6WT0v03/brPPtJhWR3Ajdqsay9aLdv?=
 =?us-ascii?Q?ZmedJHrKISsIk6ldY4c/kwgJ0LBjpUjcolLlH6lhokdNZexI1ZgaS1XsZVDC?=
 =?us-ascii?Q?3nxJSHCcF3nZkqybzN66a9e0W3Z3bhP+Sy2rzDLFpSQpDHEF81/YWXvTvGk0?=
 =?us-ascii?Q?BV74Ud77lmVXjRM/EEWEcQJuv/f6PILQ+WQizrkwkX17KU63L2RZFMitQsma?=
 =?us-ascii?Q?yy1BsK6Gu+VW7ZfiqaIjMkSNL1bZNi6n4dZEMS3x/7a9IidxMhchvmuyCx/e?=
 =?us-ascii?Q?tpokxpQ6H1g5IfhQmtgOaEzqmfFgfPTjoFH35hd/fJkN0IQ5rkSZLrOp/jRt?=
 =?us-ascii?Q?K3f9NktGwDV1yGGyCOzwmSoYdfDcI9ft39+2laGuiX229fgFHT2o1M7m528J?=
 =?us-ascii?Q?KvN6GttJjHMLPx1o7XJFk62bkdRROo4wWuiVTc5kh3rGXA9XmMJ57uRhe/pN?=
 =?us-ascii?Q?Li9YLg6H+kX8ISps2hNxdZBMtbTNqYVEQ0HEwUUl1zOussYCnZUhBGI0Aiiy?=
 =?us-ascii?Q?xNjZnxetCa9aSu/qbfvyI5J7F5zR0ITMKnNZVWD6+4oIu0iB7ZMeZcTh2o7y?=
 =?us-ascii?Q?ThF1gyikP3ApF95idTnf0Pgg2vamC3r5PuLjQG3O4y86XZbx8xbHn/2sHp+c?=
 =?us-ascii?Q?jJxK/nL7JkpOd1+nymLCBjaRHa9IK2C79kbcyw2QnC+bHBjCIgFk8DRCAt5y?=
 =?us-ascii?Q?BqIPXuylvSUZ+fYgMvKuYf0akU45irnxAIppxa/xtl74uRdpweVjUkGRftS0?=
 =?us-ascii?Q?ju53xuBE1+QcS2MwwdfqMFB65dS698PUB5qW8H6PGBZ8yCKgNy11NqIwXyU9?=
 =?us-ascii?Q?/0bXVtBVLZQOgaHgj5RElI0R1/F/ogQ9EbL3GVrvqVH9Zpx1alCHcaBP6ZL4?=
 =?us-ascii?Q?Db0+dHw6RpDgHj+QhAqGe3Bl0EgrkHTu4fu/4W6IhSNKFQWcRkisztL+xeVM?=
 =?us-ascii?Q?Nc2+2xpSwmq6nGxyAhUsL8X9FgKrwH7PSVstkF9or3S+3SI58O6Ko3VzfdOc?=
 =?us-ascii?Q?BX0XXdCV4s06PaAl4CJqNwTdkAod0RThE8SMYsX17fkvFLrstI9roH70sf39?=
 =?us-ascii?Q?guIff3KiWcWFSgV+H00gSkSWgA4Lbi4J6NCqlyEmRtbnAWiSDl7w7JgqQofM?=
 =?us-ascii?Q?yU1YNnMmpBIKP3tC2b0W3Qz+2r/4vwbOorWAGsr/wjkgD3plRvxAKH1QhXkV?=
 =?us-ascii?Q?o130RX7bpy+GoJ2gyRfe1swFsxL1gpYPDk2KEa4NEplyKu6B37sfHlm6vJ5P?=
 =?us-ascii?Q?6QzjGqCAHvaSmTewrgeU2UW8iCc1dt8esmrWYVjX3JiqTu+W/6JIxVtrd4xO?=
 =?us-ascii?Q?OgXzfy6um3bzKHqcUfgvk2zwZEML8jrEtgyX0hfDEW65DnSLhZHrYpYZOlwU?=
 =?us-ascii?Q?A0LO3L3sbzmHnyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:24.2391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c346c939-2e41-4dbb-4898-08dd481f719d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

Now that iommufd does not rely on dma-iommu.c for any purpose we can
combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the
same union. This union is effectively 'owner data' can be used by the
entity that allocated the domain. Note that legacy vfio type1 flows
continue to use dma-iommu.c for sw_msi and still need iova_cookie.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e93d2e918599..99dd72998cb7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -216,7 +216,6 @@ struct iommu_domain {
 	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
-	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
 
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
@@ -225,6 +224,7 @@ struct iommu_domain {
 #endif
 
 	union { /* Pointer usable by owner of the domain */
+		struct iommu_dma_cookie *iova_cookie; /* dma-iommu */
 		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
 	};
 	union { /* Fault handler */
-- 
2.43.0


