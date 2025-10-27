Return-Path: <linux-kselftest+bounces-44124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A223FC0FA60
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55005427CA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FD5316182;
	Mon, 27 Oct 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qufrWM4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BF3128A9;
	Mon, 27 Oct 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586276; cv=fail; b=JOMPycgP6ZBtkzKRXG0izn9LIVIL5lWffnygJpmTvEwPsME/eC05YKwrE7d/FfdAoD77PHCuQBEWKP/4VWQnztHl+LBgOint99KPUhxlLytt9njThCju5Q3IRaowZ/mFjo9sp3NDkTF/6z+oG8mH/AiSnRyG1UCmVErVukA4hlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586276; c=relaxed/simple;
	bh=/iWG3gSyum0wm2IOFYKhEvOmKbxKTRP9XNKHxMtj0JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OjTdnJYOK8QMDJAK+pGyT8UuDJ+3EDTs33gCzwPEPDhUsqH6/5DzRpylqJ+sxGSis9abAHO/7AA3soVi8hGchaHUHIIZXC1BqxFVEvdibwZCmaNRkewXvOJRfqbwFa+KnoxA1n5IZPlHISqP/2N6VxzQDLE2dXilkW+oEVeUPN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qufrWM4Y; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO2KQhpKTxGHiq52glcQwcRfLT42gCE8lLWB7pyV/8OGN1gW6YmnSLK9r2btDpJOq34iA6o/q6M7/53qsOA+XFIpwKTu5K4Z+2JHXYhyWenx5aJF/EY47Uc0wy/Zan6IFQJcqddYjgJVXRoUeg6SCvevmXCIdgmxRFD7klo1qWHBc1KFR9G5BWBIQosuEGhDRzTBdNA2fmUdkmBpwnW40zf7agObUvAEW5s15G/Bo+eC1dL93/agWrP7v4WjeZIkwyTZZw2TKOQbWKzCW17k5Ae3J7HJN/JDCa3LEpx1nf/ZKaQbHwC9tOhACYGmfrS1d+I2Ff+dV1JMlWl3JkySiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqwdIFLVSsAuF7vfxfbTsGcmITz5iIXdTSKOQpHvoGQ=;
 b=kdCiQMeh00Kv+v9ldKUE4ogkto+Pr9bwdPMtCraBlE4QDp92QuWeCkq/P99xcZwAlWD1iPgS5c9BBBDSc5Sr//y1vSUjdWceCkte+3A57TxeKgkoo/RXUJ34RXym0ZB8nq2JldUIlzbeIS6s6p6JXW8wWPHP6ExZ9FmK0td+Pm15PPv84AKLTSkIayJfW4Chd4VZWAwD7lbk0zjtslAMHOyE1YhbU6Ekpd0rUKRd5FV0pMUjqlbtEqFVuQSi3jyx4aK2Zny2Bd0j3NvEM2v0Yjui1zHc9S84gMaSkpwzl/dx+CbNELvrzN3/IPUYikXAnDFj0g/eTwd5se4CE4DaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqwdIFLVSsAuF7vfxfbTsGcmITz5iIXdTSKOQpHvoGQ=;
 b=qufrWM4YmZkexHPJWxhdTsT6iTfZojR9WXWQSPoBPL+QGlbz34xJOWLkTiAnmDLtynd+bAFTBIIbXyAENOEIeeUh3hRkre2Gu0nSqd0Ulr7TObrfgJNGqb4dSat2RWVHvML7fqoUM48q9F9SphEsV34xoe/CsI82SC5g8bnGchza66WpiWlV1+F0iK+TgCh1AyvSrmSdyugATSdo/uR3V2K6g7dKcfbWovgm0wbHVOT3aGAzuvdSy3oWqJf0y+Z+1iBO7eJfPm4blIOeUGCx7AUvTvi5olTj3ePWx8s0ziJKSaxXPY/x9+vDIdCMloXlj57MhZQGylM4gwyxU8m1lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:31:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:31:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 2/8] iommufd: Do not map/unmap revoked DMABUFs
Date: Mon, 27 Oct 2025 14:31:01 -0300
Message-ID: <2-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016412.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:a) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 619539a6-ff88-4e46-0830-08de157e9d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3ITHAAJhSgh14h2t/TjdvuxttAWpch5Pv9QGkYh15296/M+eKd+Na3CasUO?=
 =?us-ascii?Q?bnRaK7Jshec7Sdmit9aqYH2vlVNwt6gbDikSLOINqgvz5oSN57WUWamjm4xX?=
 =?us-ascii?Q?Ql2x3T7p1fEU7Im45tt+Q5BXZFF055tO0Mu5gOEuJ2WZxL8Bn8f6xgNRviHA?=
 =?us-ascii?Q?LlAmyCBeDzYP+PjHX3moJ10DcAl91QSuFwoex+IKD7wiNFOxnUvfdXuuE1fa?=
 =?us-ascii?Q?K7/U8O9wbIvhRiNMopx3AK5e8xOf7b04wpOOab67c8LyDgIZdhqnIL16agt9?=
 =?us-ascii?Q?yyCBZK2KTpx7rO2QTYSSVl7zExGXwnFeO3rGgkCjnQ1lIDoqJMPnlxGHfjhO?=
 =?us-ascii?Q?Oj9PVKkWo4JrFFDavQ7t5MdEIYpaUQ0HMKGGPJ664BMdOXW3isd8n0iy5YXh?=
 =?us-ascii?Q?u3aDqqxN0DEaVtXJr75BnkLou5WzVFLUYtUDHMCI73u9fn+b3hoTEhSbEz6/?=
 =?us-ascii?Q?J15pbCCRw8T9MLV4ZSM8JuaQcUEIEjTJvAbePriXQOKvKIlZ6/AGvQPPjyze?=
 =?us-ascii?Q?0dmKf+IO+UGLHrHG8L9ZFrmNbDG8njc58PxpSCVPOF4ZvMRJPETqTmxqK1SS?=
 =?us-ascii?Q?H2HmvVn8hwYWmt47XE7/bOvKBNIaxpyYm9CZLeBDYYP6fRFMFB4UDn8gE+uV?=
 =?us-ascii?Q?LYaEOxFTtEXuOTHnjcn97L3aKq1/KzWfmW6k3LCyve/iS5KV8XnJmV9xl+QA?=
 =?us-ascii?Q?BIAON2+rEQHeAT9f1X+ZPjhyWZGEgSoORFLrAolK/YhLuoUsYMoSo1WKz1fn?=
 =?us-ascii?Q?qQsT+31P8DxkcC0NXllL6iMPWDuXXjD/pKGwBLm5s1RULZCOLdKI3gbHQ0Rt?=
 =?us-ascii?Q?n30aOBxY+Ggvxh5Mcd8ogRIaN/o2jjUgmZPxVjC0rKsosvXebM7F+odEE/cZ?=
 =?us-ascii?Q?ELcNFSpZfjEVu4cgptMq0icavCISVd1DF8diicjpOZRHaZMKJoWfi9eMD2bP?=
 =?us-ascii?Q?wESCVpJ2PiR6thScTPDpEE9mO2knfyZ9VoaYY+Z34kYUaf3oe6wK5IEELhpt?=
 =?us-ascii?Q?wOgh/17PChBorO91Ftk/RfImkxCX17a6h7TxEnbMETJfloeh1/eJ2FRD8vtR?=
 =?us-ascii?Q?WAN+36TO2x8JPYqBDIo7BfWxnwtjQ73foBIhMn0jefz4sHyNyJX0dTOrTyVT?=
 =?us-ascii?Q?zpIn9E/3Mk32TQGT+IZikdDEs44rodPLPMULAsUT3Ak5dpbMMT7293ORSs1S?=
 =?us-ascii?Q?emwa7iCYEkdpaV+XBR2cBLKbN/HYpwdtafomAS1khFfIQgcs7EKl2d9gjPav?=
 =?us-ascii?Q?fhzx1e6diNBHNtMccahZXJXInuc/cFpLspJ9RbOCqRvtJP69v+HoTSZ2HVd2?=
 =?us-ascii?Q?tnLsHCrWedOhzI6YOdx4hvs/f1Y4hb4N9GrFV1NlppX3IS+yl5YNkeiNtl1T?=
 =?us-ascii?Q?0/OgFkJn7mAXmNfb1sPh0aXNifPMkDDw7B8xsMKBcpGnOCzZLFbbdCPlfw+/?=
 =?us-ascii?Q?ypZ/zdJEi+jVGQeWrwd861HjEdXwUE4G4wqLSymDwPprezndW0NcT0Q8+asv?=
 =?us-ascii?Q?nMflYErepoOB7qA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pRe/a04VmoTE35VCLJCj8H/zUn192QtTyPA3k9lLbLYXw1uA71svMYLR5JeS?=
 =?us-ascii?Q?1xeJ/8yPNZvZGUy0ZDpqmgFZTu+XGkLQU9H2X7bsv65zvstkiT9wWRs8KpxC?=
 =?us-ascii?Q?XyBYzc8+EoEgCBOVriN1w7pj5y30y+WSU4EvWJom7v8iRdl/W08NqzsZUi8M?=
 =?us-ascii?Q?euZe4VHZon0p5FH9Oh1A0cXKTC12RLwKuEra3ZOR89s3Y83Ip4lXYbI4l7O/?=
 =?us-ascii?Q?Kc6fZukcDAud0ytmDNzxlMiTcU3nStojHunqqkbGZ7jRApU/gMRITvKelMDX?=
 =?us-ascii?Q?ZxZ6eND2jQ/z4A/16L2lRSE/NK0EYoVUcCJuBaufII5yrPY6+N4EVJnbhtQa?=
 =?us-ascii?Q?kDLpluE1HBFi9+h3tsxgyjBw01UEuLWRlxsZRcBrRbZN26BRYfscgfD0o8G2?=
 =?us-ascii?Q?ldN9nmNN8MNboCr5hZQRiqtW8RsB2XNuj7lJoiFPkqPsxmG9U/02QK3RU9ri?=
 =?us-ascii?Q?D8825up3s/o4gfyvPpdHOl/UOGZFEn1OA+FQoI1ew7ixu5dEq18yRBMRDaTj?=
 =?us-ascii?Q?k2rAjMx/lE03ugMo5CbbY2m3AmDuWAAX4Pcd//QPzQBPx5iPiDW+OhFWJpv1?=
 =?us-ascii?Q?3GEiHz3XyTDg7V2vIpcX+ubXmqGQNe6lB4y3DHH41K6O3bAXNFvHQbNGhZ8v?=
 =?us-ascii?Q?OXfxGsNTqO8fEf7w4YBiNulJjtHSw69PTAcno2V8q0dDEASNv5QzgC1TfuXn?=
 =?us-ascii?Q?reVGb7fNk5u6qH2iUQ6VsEyEeXcn9FQKhMWMpsoekvMi5jC7AOvae/ey4jfv?=
 =?us-ascii?Q?N5yy7ZNp7xlPGXXC+jKQzJ+dmsxUDHGsEYgV140TT7rB4SMdkx2OBM7sSqaF?=
 =?us-ascii?Q?jaDwRZ+rnt+3gIIjnWVJ0RfAMona2JXtGOBeUDybntVyQcLhXG9e23GojNtc?=
 =?us-ascii?Q?BRSk4JSSMBJtjVvO60sC14YS99mS3vuOvJmwSIMx2f1Ht8XXjczwpvO+69ML?=
 =?us-ascii?Q?hU27/S/swEzU9sNb8HKXxmhR9470nuF/qzgRrou+dxiAL5Z28v3oAzly3oDS?=
 =?us-ascii?Q?4nUteeYfVlMN6XNpZy4DMLZeQdYMgoUXWPLUPAc51jM27yIqpArXC8OC/MDX?=
 =?us-ascii?Q?nOGnPhc7ImxHDwD1JG3+oy+g50IrCTT1Ll65O0cGHZHVbXGjk5cISRGwoQJj?=
 =?us-ascii?Q?ZyHACw4Q1BCYZmqyc0KAP/68CBsKOyd+DsnrAhOvFMWu6NlQ78/T6J9FMVL5?=
 =?us-ascii?Q?K6WxCdPq9mS3FksAmaDDz7Fdl89HCzcQ4jx0+DDcb5JbPc0yV+msqUlBB+l7?=
 =?us-ascii?Q?EZqWuK28jj5k8iLJcfwjU4ST00m+p424YEF1buT0hHioQN2ssjThLU64y2gy?=
 =?us-ascii?Q?VAN3slrm172Ty02CqjOCETQbZvoApVekyVs90pCBWNoXJcnPnYecCzi6JLx0?=
 =?us-ascii?Q?2IfQNPrBbRqaUSspvRnYSUp8fG5mJ/xTiSuIfEuDfD0kDWIrc3iA1u7knVQw?=
 =?us-ascii?Q?c++pstqnVMcicBV3A2c6iaBFO4nLpFXVfG0PwFBQwFKAlEPPBeyh43Coo+m6?=
 =?us-ascii?Q?jWeR1bzuhkixhz2MU01uIRgeycZrSf2IP61AJZOZ7baeX+ErpqSFaYKAq26s?=
 =?us-ascii?Q?PxlF58FIlMCWbRLUcjc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619539a6-ff88-4e46-0830-08de157e9d66
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:09.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVQgVvROiUtXaU0cttO7dkF8s1vUOD/tUgXg1JSemzBkTWQAG4UpWAuEbWd9DSvW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

Once a DMABUF is revoked the domain will be unmapped under the pages
mutex. Double unmapping will trigger a WARN, and mapping while revoked
will fail.

Check for revoked DMABUFs along all the map and unmap paths to resolve
this. Ensure that map/unmap is always done under the pages mutex so it is
synchronized with the revoke notifier.

If a revoke happens between allocating the iopt_pages and the population
to a domain then the population will succeed, and leave things unmapped as
though revoke had happened immediately after.

Currently there is no way to repopulate the domains. Userspace is expected
to know if it is going to do something that would trigger revoke (eg if it
is about to do a FLR) then it should go and remove the DMABUF mappings
before and put the back after. The revoke is only to protect the kernel
from mis-behaving userspace.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 11 +++++-
 drivers/iommu/iommufd/io_pagetable.h |  8 +++++
 drivers/iommu/iommufd/pages.c        | 54 +++++++++++++++++-----------
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index b3cf3825a88c7f..38c5fdc6c82128 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -970,9 +970,14 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 				WARN_ON(!area->storage_domain);
 			if (area->storage_domain == domain)
 				area->storage_domain = storage_domain;
+			if (iopt_is_dmabuf(pages)) {
+				if (!iopt_dmabuf_revoked(pages))
+					iopt_area_unmap_domain(area, domain);
+			}
 			mutex_unlock(&pages->mutex);
 
-			iopt_area_unmap_domain(area, domain);
+			if (!iopt_is_dmabuf(pages))
+				iopt_area_unmap_domain(area, domain);
 		}
 		return;
 	}
@@ -1261,6 +1266,10 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
 	if (!pages || area->prevent_access)
 		return -EBUSY;
 
+	/* Maintaining the domains_itree below is a bit complicated */
+	if (iopt_is_dmabuf(pages))
+		return -EOPNOTSUPP;
+
 	if (new_start & (alignment - 1) ||
 	    iopt_area_start_byte(area, new_start) & (alignment - 1))
 		return -EINVAL;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 26a7cb1668e8db..759ebf66265df5 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -237,6 +237,14 @@ static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
 	return pages->type == IOPT_ADDRESS_DMABUF;
 }
 
+static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
+{
+	lockdep_assert_held(&pages->mutex);
+	if (iopt_is_dmabuf(pages))
+		return pages->dmabuf.phys.len == 0;
+	return false;
+}
+
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 4468ef3510dbee..ca27ad3a3168e5 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1650,6 +1650,9 @@ void iopt_area_unmap_domain(struct iopt_area *area, struct iommu_domain *domain)
 void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 			     struct iommu_domain *domain)
 {
+	if (iopt_dmabuf_revoked(pages))
+		return;
+
 	__iopt_area_unfill_domain(area, pages, domain,
 				  iopt_area_last_index(area));
 }
@@ -1670,6 +1673,9 @@ int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
 
 	lockdep_assert_held(&area->pages->mutex);
 
+	if (iopt_dmabuf_revoked(area->pages))
+		return 0;
+
 	rc = pfn_reader_first(&pfns, area->pages, iopt_area_index(area),
 			      iopt_area_last_index(area));
 	if (rc)
@@ -1729,33 +1735,38 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		return 0;
 
 	mutex_lock(&pages->mutex);
-	rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
-			      iopt_area_last_index(area));
-	if (rc)
-		goto out_unlock;
+	if (!iopt_dmabuf_revoked(pages)) {
+		rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
+				      iopt_area_last_index(area));
+		if (rc)
+			goto out_unlock;
 
-	while (!pfn_reader_done(&pfns)) {
-		done_first_end_index = pfns.batch_end_index;
-		done_all_end_index = pfns.batch_start_index;
-		xa_for_each(&area->iopt->domains, index, domain) {
-			rc = batch_to_domain(&pfns.batch, domain, area,
-					     pfns.batch_start_index);
+		while (!pfn_reader_done(&pfns)) {
+			done_first_end_index = pfns.batch_end_index;
+			done_all_end_index = pfns.batch_start_index;
+			xa_for_each(&area->iopt->domains, index, domain) {
+				rc = batch_to_domain(&pfns.batch, domain, area,
+						     pfns.batch_start_index);
+				if (rc)
+					goto out_unmap;
+			}
+			done_all_end_index = done_first_end_index;
+
+			rc = pfn_reader_next(&pfns);
 			if (rc)
 				goto out_unmap;
 		}
-		done_all_end_index = done_first_end_index;
-
-		rc = pfn_reader_next(&pfns);
+		rc = pfn_reader_update_pinned(&pfns);
 		if (rc)
 			goto out_unmap;
+
+		pfn_reader_destroy(&pfns);
 	}
-	rc = pfn_reader_update_pinned(&pfns);
-	if (rc)
-		goto out_unmap;
 
 	area->storage_domain = xa_load(&area->iopt->domains, 0);
 	interval_tree_insert(&area->pages_node, &pages->domains_itree);
-	goto out_destroy;
+	mutex_unlock(&pages->mutex);
+	return 0;
 
 out_unmap:
 	pfn_reader_release_pins(&pfns);
@@ -1782,7 +1793,6 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 							end_index);
 		}
 	}
-out_destroy:
 	pfn_reader_destroy(&pfns);
 out_unlock:
 	mutex_unlock(&pages->mutex);
@@ -1809,11 +1819,15 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 	if (!area->storage_domain)
 		goto out_unlock;
 
-	xa_for_each(&iopt->domains, index, domain)
-		if (domain != area->storage_domain)
+	xa_for_each(&iopt->domains, index, domain) {
+		if (domain == area->storage_domain)
+			continue;
+
+		if (!iopt_dmabuf_revoked(pages))
 			iopt_area_unmap_domain_range(
 				area, domain, iopt_area_index(area),
 				iopt_area_last_index(area));
+	}
 
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
 		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
-- 
2.43.0


