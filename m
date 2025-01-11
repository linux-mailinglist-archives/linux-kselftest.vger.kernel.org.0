Return-Path: <linux-kselftest+bounces-24288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCBCA0A08B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C79F1883391
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22F154423;
	Sat, 11 Jan 2025 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzdsDzOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81318FC92;
	Sat, 11 Jan 2025 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566397; cv=fail; b=Pwgcn9pSnui1igNajSgeCSBj6igfQZPOK7VE9WI/78NluZi5yChJKxZHYLwDEj+v/4sRku3w+BppXwl4SO6vi+g4m3SN22Ts+O4O5TukaL9RdOzp1oxd0BarBZZQKvVkH5rQWMgZIZvPFPWuBplGbcRq4Ao+8KFnHii7blgi70w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566397; c=relaxed/simple;
	bh=Ba9H3ncdOkU998RzKnlIxH6ZSXVVvjicT2bclldyy7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=na8NmZxUGz8BjSsNIVywjgXkWN/zg7YGMLTdcnsbFnbARag9TmWBd+BbBdJn/xNFWGaQOkiBLVDh+4eo7KVA4hp05HGhGACYGMU4ONHwXlBr/JXms/P9dGtLh+H1uMOKokhnlJx9PC6wQts4Tmiws7A5s8EV87YZzH30vWsc1Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzdsDzOr; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL3a3H5b2vRNTV8xFXZ/vJHDXjAlHsfiAhlBkz/0pRXWV2mhoCglH71qcYNlkdZ1TJB/4hoy+vxZ3QbHbtVbN3K9xCP/kwhnfEUmiD5Vm+X24XJGrYW3SDHz5m4HZUM3kaFmB/rfDT39iMg093mX84Qs1S1zoRqz0kgB9eZ9gdrmheBC/kSUa4C0eUu0GVEIV1S+mDfxGVBUUoyhMCsW0UHmy2sX2tu5KYQM5R4DBOzfoKT6aw5dzbxCCFsIpIQnVQZRZCkgC7UjFuCS2nXRyr2IwDA/syCGlUd73r4sPmjutVC8GVTF03YqC7MeUzjMWqpJ2pcMMFhGVHTjwD2ZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW6Pq5BvBZxpZfbTA763N6VG9QhIse02tukp7etJk50=;
 b=dWwiGjlECsk9WPYb0WU7GXoX760ayOfCpT4FjU/Cfy0qRuMRAb9EWm/ypyzrfQTAcdjx355n0m/TfQ/wRcS0ICdSlMPU0+rOKM+9xWJmQC4WFs62XWVDTmQLiiOkUIC8O+ZExcJ35sc3ctZofRlTJaK9uVN78eAcKDXm5Q1egVmxgJzSRT1k+2Pp15HkYE4FBFmLhv7+eSZicZfBMz4wL9gfET8j4dlvEBr6LXbmdDSCshfOMt7CSzHWElA6VuUTJ9HmZXrguzqUb+Se6Sg356bIpsOTge+iDRJOJAqFyaBY7oMuE0P4demGMrJyJaYT6LXl2qC5PB+WCsb5wto4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW6Pq5BvBZxpZfbTA763N6VG9QhIse02tukp7etJk50=;
 b=nzdsDzOrSEsxnidomxeL3GKOhNbWD1S0rKdSY2QGYSHQFGA0GyT8vm/jvfNgLGQUWRB0pErCBOJ5I8qUIugZe1OgpS05oxzgE/D+GFHJi/Y6xKKMjw621PZLFZjlpwZ2x6P57n878G++17EDM6sMybN7ad8cS7DbRKAROoubso6kDjwKFQFwLHk5IF08Fjpx1bMFINSFOAiZ0Ffipoe2AlH9ENf0Y0hhHX2R93yBJYCmdmXzPkYy6ptdXkIdnXEk26S/vYJSMhb64ObWxucA6/cHRSqId/kLp5lbvwfC9KyxMmebAlKkIkyUnITsdhJZBlgreYScjfzCx9JeawSakA==
Received: from CH2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:610:57::35)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Sat, 11 Jan
 2025 03:33:11 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::1b) by CH2PR12CA0025.outlook.office365.com
 (2603:10b6:610:57::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Sat,
 11 Jan 2025 03:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:06 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:33:04 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 08/13] iommu: Turn iova_cookie to dma-iommu private pointer
Date: Fri, 10 Jan 2025 19:32:24 -0800
Message-ID: <42c6ff3090636146a86501528eb03df99f83381c.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: e27f3bc0-32d3-4dfa-9fd3-08dd31f0ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p/7aD+KdzgB12mQvC2Sxvfow+QtR3y/tPgA9Ucqob9ECHIBQcQP8DlBGIChG?=
 =?us-ascii?Q?ylVc/0KmrcbB5PNIUIlUMQo2ges7QudHo/bT5V+KUFjSRyfBdK1N0Rs95o7P?=
 =?us-ascii?Q?OOt1fVNAfbE///+aZnnoPuV8ENLQVnySlRLeZJo3XPUKSE0/Y8bnqkbzGzVs?=
 =?us-ascii?Q?GQSip+fsXridSDhe6c6Nq/ziW59cLdY7xzHQWEup5C2mKify0Nv1jmH8mYUy?=
 =?us-ascii?Q?o7BwQo3eCeDnFjU8SttnFV+Or06kI/KxDTI0WRJTBVYO+MDA2fbOm22qPnyB?=
 =?us-ascii?Q?aUXwxa6bhVF6DNVBUzzYGihx0kcroONVtvKEDZPjC7taU30yIhvfqU6DA909?=
 =?us-ascii?Q?2k0/ImE9QiZ6iXWSd0N5ZYC8TFBniQga1oXwKA141b8znIYRNHMcklZ1okPd?=
 =?us-ascii?Q?TUU4nojxV+r+wJ9Jsy3n8PBjN+SWcn5iZITHy65fN7GCOYjojfgKNjpnNTei?=
 =?us-ascii?Q?zgQ+OwL35OVM9fah1ihE9zbWsa0D4e/be4S7vTTK3nU4UttSbob8KpvR/mMs?=
 =?us-ascii?Q?BlbUyDfMh2eDRLjQbo1iYyewfALvt9cg2KL7xkt4dR4CFkKoXBgqi3AIWAt/?=
 =?us-ascii?Q?OtdXiJaA4VGhN4RoPQ5Ztgf/24fzeSnr9CrNwsPNJru5TEsJm8ABkqPtGO52?=
 =?us-ascii?Q?jLMlEHSwmz1sn6hY294dYHYR7rOleNkncYpoffz1PmjK0Gvh5pD55D5bF/Cu?=
 =?us-ascii?Q?6Uv8H45/hNGzVfzP3VrYQDNNWIPuvZiUTNdCnsbdiVrap6mnNDlqfsg0brsk?=
 =?us-ascii?Q?RNscjapSBFdPyizRQlIHMdREx/lQpZZ9rXGC/HFxJqly61qJ5UltH8e814jm?=
 =?us-ascii?Q?EyuTaTer1rt7VMUFJiz74arcnfD7flfoUimW/bDOPRVH2o+PpTQ8DbuTqpma?=
 =?us-ascii?Q?0mgp4fEF7HP5LEW3YhaRcrqxp0HWy+H3BuTfoYq8fll3SS7Bo3E20MpdC4HB?=
 =?us-ascii?Q?hCqohRBmzwBLxPDmzvkNyJwoZ8aO1MoqmVP+L2SexuF0T53ZNkliE+3pqbol?=
 =?us-ascii?Q?au5cgKgj0dbEQRk/us+2b2OW7pOb3LIHo+nmKhj8+kTfdWd+IndFOwMLKntB?=
 =?us-ascii?Q?hD0GUbGJx776vvlvLkZ221qDGPV1NxaAbd/Im1fXvONdPTHQgerJJYQWIGMs?=
 =?us-ascii?Q?m8RVcw3Km1DvC21zqQlZVCCizueVxWvJaksxI4oHA+PQZRWl6NBiAJLHuhYa?=
 =?us-ascii?Q?ZGI0XMlSYVkMQO/FsTanJV7vZUoSdVp60q1cR1jbewg9Sjh/W+LIXpTfa2Mv?=
 =?us-ascii?Q?P7qBRIVUYO4TMUS+d49jTF3omu0fR2gMR9mzCzWDeDvigOVgOA5AI8z//eXT?=
 =?us-ascii?Q?8+q9MWLuf7WZrlXLcLyl6Al6ZRAa0hjPsB3PJ5uK25pxvwxVu7JO5yIrx+jx?=
 =?us-ascii?Q?vlvQdN9Cc44pJ5Ble8lONHhHqgQZK6kATjjdmFVQkLKV/+zEx3anxpiz+Cuf?=
 =?us-ascii?Q?U+tZq1ni4ONENO1mTVRfUUQZURBCQecXlYEm+ImagJam0XxWFjM1xjBprkIY?=
 =?us-ascii?Q?ReUMlUAPeNe2CRw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:10.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27f3bc0-32d3-4dfa-9fd3-08dd31f0ac23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

Now, iommufd has its own iommufd_sw_msi using iommufd_hwpt, the iommufd
owned domain's private pointer. Similarly, iova_cookie can be seen as a
dma-iommu owned domain's private pointer. So, move iova_cookie into the
union.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b6526d734f30..284c40fe0e12 100644
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


