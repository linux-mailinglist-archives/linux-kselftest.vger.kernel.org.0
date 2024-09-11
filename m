Return-Path: <linux-kselftest+bounces-17768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD7975C36
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 23:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86701B23D96
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698F1AE870;
	Wed, 11 Sep 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="coS9hoO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2E143C5A;
	Wed, 11 Sep 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088921; cv=fail; b=WkvhniG0W67kh+w32oahi6TxJsR/H0lH628std0jV9JR6oRipDOZxGFpr/40CAljo9XQYHSWy6A2GpNxle9zR4JOLmSeGvHTQCXW9nh2tkXuCiWzO/nWPObtSMVhuHA9gHPvrbpesHPEzfZo9I/006suDVJRQTiKOC7vuLmuw44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088921; c=relaxed/simple;
	bh=eZ6OWxDgQipcG2D7kGt7KfVKulD5T2ZiSA+umoj9uzo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upey4mMLo/voEsN6dpEJlzkaPvUYJlxS238nNZkmGq5X9bXn+1tkDWkK76AUYudTf9vbLAS4EOl5hJzM47iqZvK1WBhyA20AJa8lX9x1w7gnAVzdq0Gw21JyZxNGM1jb8Zuy8cxdHG3w8MFXoqpdMaIiYdCL3hdz2V1z/hCY9IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=coS9hoO/; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH7dK6yXzwU+3EEo9Rp+1jsWhT8+2j34jcRfMd7ww2GNnG7aCEqAQdwO1DWimkA7OF36blxagSONHqP7DsH+lrrHzYbwEFq9v1Y21IGkmmFsLQjggaM+aTlo0xfDfLKV9ALHA6hEA6tFDUMLLpB+wLB6bUgtJnKw4ZHIO/jb1n73rV+j6+QoVTQG6iW8KxJtmpeV3iRPc3c9HJuTsNSJ4xefVvAfKePsrBEXO/oAMtx64zqYn+IZ/Pv/qQpnlH1sF5jc4sPcr3Zt+uN/xLVSNqplP+u8HlP4IXYm4NAQzE9DJCzS0s6SbDgVXp7pjHYAXMdh3loO3F+g6ULxgxhp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpD6n3lkLClOVnXLCTISPPV0VfB/VRaVBhPu8gg/EOU=;
 b=faYB4YamdNuqJh01zV7fnWeJoBG8lb7D8iDcpqSPAL+Ye4JC+s+t8Wczi5ykk3Q9XvlBFhtlaIS4VSmu50SXdXb7Dj4Dn7OjQwT7YZPPFpuem1CmffkIWoUQlnyV4ebTGgJ+butPCAfUhufchsNrDmSPfAwVY5F8F6wgL9hGhvRrknpkGc6lusgEANgAjNYsKxi3e9P/Ed4O5Fzkt2GFI7AZX5Jv3ZGPbtUExS8NCfIt4O7TVHQDfGDyjMvjYtb5y1epmXJ9Bd6v6F0mUGIlJ08PsjK4Gm6ZxPutNm0YY+uptyxOCV35W8rYjAXsMC9ow1lUr4B2IsmoMOVKBIr8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpD6n3lkLClOVnXLCTISPPV0VfB/VRaVBhPu8gg/EOU=;
 b=coS9hoO/TQgbf/Oqe2kbQXW1vkVnXVCAyGgHntCHnLo2IOwbinnxswstQvoT395jhb7pHly6lK7k+koLMDZk+OrbiybI7yftUhrjToRnBKcJ3tsW2Wcq4LTsPuZhZJGz/cjop56He4AF42X8EetGd4WJHIggM+8KszmgBNy31/9oZzym/GtvxR89cguwBgZgAnMJhxIyX27+JGEc5ph4c6oxWeoCFCsbw1n0rgpM92gCMOKcf0tQ0B096jRewyh7I9tLowrAowgXGdJVcDn5q1WzCRH76lgAdFEofh90GORfiG0WhH9TGXTFHiu3ttxnqRHVFPUx+s+Nah9HU6KHEw==
Received: from SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) by SN7PR12MB7130.namprd12.prod.outlook.com
 (2603:10b6:806:2a2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 21:08:34 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::4) by SN4PR0501CA0128.outlook.office365.com
 (2603:10b6:803:42::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20 via Frontend
 Transport; Wed, 11 Sep 2024 21:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 21:08:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 14:08:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 14:08:25 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 14:08:22 -0700
Date: Wed, 11 Sep 2024 14:08:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <ZuIGxlUXIh7HL+dz@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <bf0a3891-f7b5-4a19-a86d-c115ab2d6b88@linux.intel.com>
 <BN9PR11MB527623483A2C981ABCFEEFB38C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527623483A2C981ABCFEEFB38C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 46918080-2380-480b-cc3d-08dcd2a5e5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NrP051bCaJhN4zi0X7VioUlLbg0VzOeTvjWnakxQKJ5U47chh2Pj6xErEfep?=
 =?us-ascii?Q?FbO5Et9QuZjaHn0VvtxjBkgI+vofL3SsqggsMe8XJkPiLBOj+3kYu25vY5+S?=
 =?us-ascii?Q?lUH8fTR/kG0vDwtH11Ooswyzlix0OWEqNtS0gLLi2IyUbe8pIMTRDN1HQ0dC?=
 =?us-ascii?Q?2G6RMWAtmPv3994gIwt7ixljMZa1sF6xPbcMZ2kbhMpOaIZ66rlOq7Z5DYYh?=
 =?us-ascii?Q?79VrgLpPmyLos1B3XWpcYzQlCRnQoxDzBZeOd9tjhmifAb7x71vlCLpBvPGZ?=
 =?us-ascii?Q?9iauos3/8mqC46MlcFTrQSnNe9nAPuND8bWHK7sNh4SUapCklGs9xUNTASic?=
 =?us-ascii?Q?ZUlnqdNBSBIzwMdYF4Z99xGoPPusEPIk5LDAms0zgMPsNYf8xs7nenad0pXw?=
 =?us-ascii?Q?kL97/rTITV6wKgY9pUqv5F0JKISNXQfop9DWPL6lOyQ8ghEikjU4Q1H00dJ7?=
 =?us-ascii?Q?LKXl70Lj1GOaGdZZdRA3kZ9ujAW2Dflyy5SH6nwwVDgl3O1ImjN/2nnM79Rn?=
 =?us-ascii?Q?zopJScataMGrwp/NwJpnB7GJlp80KjHUrHS1CmglqVhmsWQSI7whzsv5tf/k?=
 =?us-ascii?Q?14tY3BbgTQ6C6LX1H9h610okm06QgpNdRAaxnltMTepz0JfGijqTlK8EchV/?=
 =?us-ascii?Q?PjeFbaCB+S9dixOwRWOdwAyfZUKt9zAD7q4ZjiT8qoN5cGMpjHOkupyRgYNK?=
 =?us-ascii?Q?yUaVN+G3z1herdBxY7GTk/SegDQvhQitjzOao7Nkd+LWnVxK/0rySPpLO1Bo?=
 =?us-ascii?Q?uPWejM8mXNTLFvuB6FefVC+Z5Zl6epEecGlpNkvTVm3xqptkjJBwW+b5PcUP?=
 =?us-ascii?Q?aASZGgw6Ns87ekCDkMDbwfrpQJstjLM5uvRHq0S1kGpt71kuNtJJaqDZFTgR?=
 =?us-ascii?Q?vOMWUly+Bs3PRsmi45kQjRHReopc4oKCQMzydECrIkgjP2A8Rk8jOR2c7jUb?=
 =?us-ascii?Q?eT9cJ4mRaUs+zYi+BhfqndSuMOebQWtN73EsHGLGtiKMZNeiAM1BAF9qfPO4?=
 =?us-ascii?Q?o98V6bEepX/iQJH01c4OQ83VgG2kqzCRvGp/QqseajxMCOHHLATI+NHP4VCm?=
 =?us-ascii?Q?I1s1bFY1g4vl5er8bVuPjzunEi9yy/Hte/SBIx7AvMpoeu3NtuNGpRl24/hZ?=
 =?us-ascii?Q?zFYNOzb3DcJxBH+A8031ufmDaL1thTjyCICzyBUVseAusA3NICY/li3lzPBp?=
 =?us-ascii?Q?glZd1GmnzS/7K+fLfcsqhOAm8QYUKZaLXcSkVw8WP3ZCjqK6SPBBsx5Vh8n7?=
 =?us-ascii?Q?QZmITBkVaYQXukL1l4CG6VPUkE4Q9mybGKcqLAPiob6cGCK7dmEbaNZFv6dQ?=
 =?us-ascii?Q?KeQRkNOhm4aqCnVxN+Gvh5cKMQifgBRmkAezW9yxdcM7NgFkxIOBymywY3dW?=
 =?us-ascii?Q?GOW0VV7RfgtqY9eFrqZaVPV4x5RhtfyvRrKB/prTfqbIkwKzN+5cNjvUPAwn?=
 =?us-ascii?Q?y2zMr2xYjXolP8P9hxmJnZAbLAwfAyil?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 21:08:34.6644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46918080-2380-480b-cc3d-08dcd2a5e5e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

On Wed, Sep 11, 2024 at 08:17:23AM +0000, Tian, Kevin wrote:

> > My understanding of VMID is something like domain id in x86 arch's. Is
> > my understanding correct?
> 
> yes
> 
> >
> > If a VMID for an S2 hwpt is valid on physical IOMMU A but has already
> > been allocated for another purpose on physical IOMMU B, how can it be
> > shared across both IOMMUs? Or the VMID is allocated globally?
> >
> 
> I'm not sure that's a problem. The point is that each vIOMMU object
> will get a VMID from the SMMU which it's associated to (assume
> one vIOMMU cannot span multiple SMMU). Whether that VMID
> is globally allocated or per-SMMU is the policy in the SMMU driver.
> 
> It's the driver's responsibility to ensure not using a conflicting VMID
> when creating an vIOMMU instance.

It can happen to be the same VMID across all physical SMMUs, but
not necessary to be the same, i.e. two SMMUs might have two VMIDs
with different ID values, allocated from the their own VMID pools,
since cache entries in their own TLB can be tagged with their own
VMIDs.

Does domain id for intel-iommu have to be the same? I recall there
is only one iommu instance on intel chips at this moment?

Thanks
Nicolin

