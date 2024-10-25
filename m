Return-Path: <linux-kselftest+bounces-20683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D663B9B09EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 18:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F114A1C21022
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AA170854;
	Fri, 25 Oct 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpaOZlYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364C70815;
	Fri, 25 Oct 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873714; cv=fail; b=U0ZpNAr8Vp/m9ozS9lAs36aY2CWoP8FLMhmBftOb1qH7M4jyG2cL+fFx/q3OyWCAt15wRm0glM8DX8czcWPfXifZhAWo7qazIVprAIvldq02gSnVzlxREC5242Il8mIMWxMWb86tPHpkutaGjrgBg2CO893SGKd/c/Jvq1anYWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873714; c=relaxed/simple;
	bh=I3TBuQEsOH3BdOdQpy00XfdptmY79c9RB/xKoxUbM18=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=injCXPJc5C7RUw6SOVmaf03ZnZ/kUaLXLmMesCrRo8/7MxObLk/HcLBQ6PrRJ/9/2UP3N89Hxdc+tPwxui/zgQS+dIhstM/zIjT9UJYe82g/EUJIeLRz52o9RNQE2DX0CZn1eWiFSUpJEBq8WJ54ucprYSwOWtTYwMORwVE+jT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpaOZlYk; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD9MND3H59OLyX7sAx77VVP0y/xnk3XguVffF3QqUuAEcSiSxLk61lLkFYvY6F/haUWz6vxuJRbvM3Vgc9Sb9WO48rKsoRfQY/77q0gmw5ZBa2RP8qlRqnjnJtdajUNoWphyJmf0fN1hy1rDVjVBhEzfzGfvMSU6yn8ChSqUaSrqaysONcPi+R0UevlSGD/Y0pHJKhVFrfSlGBKBv7RmBYF8Rcm3c4mcQzxKNwXhesEtxlpPPr3EfttiKFsz+YRnVuxm2sbT2x/xkfSF73qavv9+foG36Do3aQTqQL/eNvrO+we0fZcXmf16JG6QU3dS01Pu4QwFVrL8ArgvDpOZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+vuOyjAyfh+gyZ5c2kkaOJzZWcoiWY3PF+sBxz/IwA=;
 b=yP2HwsQO+CxABbcnokBL2D+Bg5dwNzGP15X+M/XUeifgD5tHtbX3qI6asAUi68fcBf1farhJYeDY6BOa1zQo/I7MnWC5iWPzlq4Nx74ZYo30MmewvnEQ1e5HGVOKWQLRlMCFzOdL6nru6x3EIkQaPK35lfy9r4FUbwsHrnPI6BQusZXI0E1FhCI2ofoNgPKM8yu88hdemkuTNsu7MN4I2bIxLKskdXogv3fEBUsDOykHNm88BN68ast2r7Ozkp62Je6PBDkqGvEbX9LT2infhu61oT1TMVmKe2a3E5KngJ0/UfSTmroYTg1oShKkvt8eg1dPnPPoSSByqpGvTeNsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+vuOyjAyfh+gyZ5c2kkaOJzZWcoiWY3PF+sBxz/IwA=;
 b=GpaOZlYkfQGyQxJ9d7mYT9QCMvtuh7aO5S4aMWo1zxuTQYxSN0iOPhfQv8zrx/cIP0kOeN0EgLgL7NW4pZFcyyyJCOab4R9AyvdhrccjtDpSyFdob7+spHNHImnu27ge16aYIa/BlIcrKUSSLeNhzQlxFDSThgke6NCHjeGRy4oNYDS7zrPv+Hj5Z4UoFY+RTCUdQf6elzmFc7eYPXxodR+ICRYYChvoWlzzIdHxn0gV04s9+ThRLm45M+RwHU0/rRhF0DWt3pSjZO24tsxy73JixdLXEnxYN4YPt7ctquTD8VWv4B4GdLdUfJlQa3lmgjstAQ3M36VQ2NDptniGqw==
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 16:28:22 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::97) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 16:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Fri, 25 Oct 2024 16:28:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 09:28:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 09:28:11 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 09:28:10 -0700
Date: Fri, 25 Oct 2024 09:28:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Message-ID: <ZxvHGQJW65H+/zpy@Asurada-Nvidia>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <BN9PR11MB52769BCEED1DC36DBCA75AF98C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52769BCEED1DC36DBCA75AF98C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6118042f-0535-4ed5-6018-08dcf5120a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxoS21BeGwzQkZTdkZWOGIySGZYeFBFbmV4UDdhUFNqTkFSMEdJd243Zksr?=
 =?utf-8?B?NTZzM0hKOEtVUEFENjRYdHVxb1A5dEk3TjllQndab2VxWWFuYmpJbkxFUkhG?=
 =?utf-8?B?K1JPcW5vNFNpdGtSQTJEOTJFc2JhdHk5RHNZS1VFSmhlSkFOb0YxbCszV2Qw?=
 =?utf-8?B?OHlnaDNsWDI1UEpEeTlnb1ZCRXk2OGFTcmhkNncyTmFHUlhodlpOSWF5alNP?=
 =?utf-8?B?emhZOEFnSW54em5aNy9LK3pLTGhKTWdiQ1M1T2QrbzNMNHpwV1haRHplZlFJ?=
 =?utf-8?B?b3hXQ0xiVDYyRjQrcDJLRWllbSsvK2JuaWVZUXVFY3pncE9pVTlMaTZSVWRT?=
 =?utf-8?B?T2V5MWNiZS9QakNCS0tiQ0Nwa3FQeXpjSnJGejhhWWYyV0E1L2pieVpCVGJG?=
 =?utf-8?B?ekZScUtTc3c5TGNwSzZJdjhhcHdaTkx5ZkkwMWlVeXFsSHIyQUdNdU1LRjYw?=
 =?utf-8?B?em14cTliNFZkZWEwbkJhVkkyU2hidG8rU0JUelhaRXV2c3ppTElFaGRNTEFM?=
 =?utf-8?B?S2oycTVNN3owZDhjbzVBbERYdWxIK0FteEtzQ2NXOVY5dWxPV0VPVVU2OXpL?=
 =?utf-8?B?ZFE1alRYdkhlUlNZRldVUGJvWWpBZkdwdW1MOU80cGtMWGpHZjhFT2FqOVQv?=
 =?utf-8?B?a1F5ZlE3ZjRxNmN1cGtNdVVWVThaZzRQcjR4YVZvdzFrWnVvNExTcXNJRE43?=
 =?utf-8?B?YmRTUnRqRy9Pcm1tR3FiUFNUd2Q4ZkNsM2dGSEJRMUpXSlhaQk15YmR0a0hV?=
 =?utf-8?B?WlZyTGtzclpnYjNFOERDYkdWS1BJMkJoSFl6V3FZeFphZkg0VGxCcGhzRmp5?=
 =?utf-8?B?ZmpieXRPOHQ3MU4rTkthYXBqZVJPYnhTVmpDY0pScnVod01MWWtSWThpUEVx?=
 =?utf-8?B?MkVJZGZtZGQ0MVpBM2UxVVZuMEdJVnFBRDZ5NWg0MTNhb29NeXYzN3VoMkhP?=
 =?utf-8?B?d3BMbzY3bHB3WEZaenJFclM2dmJ4WGtNeDhuRDI4RDMzWDcxdStIVjNqMCto?=
 =?utf-8?B?OUJpaUl0TDV2K1R3aXdQZkk5emhQZFVpVGxJQmJWV3l0UlJzZEZoRitNRVpu?=
 =?utf-8?B?SERXL3JlMEFFQUhhMkpCNmRGSEp0cnRPVU5IOW9maXRNZVFCSnMrV0tGWVFX?=
 =?utf-8?B?YjFmSkVMblFDVnJTL2xTOW1DZ0Z6L0hHaWJ4RGRGUDRWdE5wdGFrYnFaSGdD?=
 =?utf-8?B?MmorN3d1Q3Bza1VpM1RaeG84a290TXFRejdnOGVxNTJXbjJCVUczRmpOb3FN?=
 =?utf-8?B?QkpPRjlHMmpXb01WUXpidXRQNkRkSmNaRjRLdFRVV05PMFJZYUthQmNEWWtS?=
 =?utf-8?B?SGVoWmltUzRIcjNERkpXZjZjRFd5em9IcnV3U2JGR2kzZ1pOMTBPWUZFcHBY?=
 =?utf-8?B?M2xxMkN5ckVEMFRwRCszYWx2Z0xVZmtHUm9xY042Zm1iM0thQVJHMVJ3czd6?=
 =?utf-8?B?SDFSOHhuRHpDdjBvWng4dXBsRkJrUDlKakZtaVE4M1ZITU5JMGNSbjdXWVdQ?=
 =?utf-8?B?TExhS1VVMzNaeEJKeXE5UmtyQnlWUDRaYWRVK0ZYTk11QjExcnVrUG0vUExz?=
 =?utf-8?B?MTl6V1krMUc1N3lCUDlEaWVFSlg3REUxOE1BNTVWNlFHTWJ4OE92YW5lc0xt?=
 =?utf-8?B?UFdrR05ZRURtRjFYTytoMlJsbFFKV1NZbGpjNHRuODRRZnJBOWVJVU5Wdlgv?=
 =?utf-8?B?WDhnOWJOVUtrbzhGemVDQUFxRVVleHBPWi9XazI4VkViREpXSWEyQlFJMFQ3?=
 =?utf-8?B?MUxMNy9YUng3Z2NpaGN1TURQWTNKem1uakc1blFsT3V6S25sZ1Z1U2RYMGlJ?=
 =?utf-8?B?ZUsrU0svTFBJbTdpMmYxN1dKODVWOXJvbjB1RjlFSStZWHhYWi81TWZ3QU5o?=
 =?utf-8?B?T2hBakx5WTY5N3ZWVWtSSlErRGFTZ0ZTbDFmb2VpdTBZelE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:28:21.5692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6118042f-0535-4ed5-6018-08dcf5120a9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991

On Fri, Oct 25, 2024 at 08:34:05AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, October 22, 2024 8:19 AM
> >
> > This series introduces a new vIOMMU infrastructure and related ioctls.
> >
> > IOMMUFD has been using the HWPT infrastructure for all cases, including a
> > nested IO page table support. Yet, there're limitations for an HWPT-based
> > structure to support some advanced HW-accelerated features, such as
> > CMDQV
> > on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-
> > IOMMU
> > environment, it is not straightforward for nested HWPTs to share the same
> > parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone: a
> > parent HWPT typically hold one stage-2 IO pagetable and tag it with only
> > one ID in the cache entries. When sharing one large stage-2 IO pagetable
> > across physical IOMMU instances, that one ID may not always be available
> > across all the IOMMU instances. In other word, it's ideal for SW to have
> > a different container for the stage-2 IO pagetable so it can hold another
> > ID that's available.
> 
> Just holding multiple IDs doesn't require a different container. This is
> just a side effect when vIOMMU will be required for other said reasons.
> 
> If we have to put more words here I'd prefer to adding a bit more for
> CMDQV which is more compelling. not a big deal though. 😊

Ack.

> > For this "different container", add vIOMMU, an additional layer to hold
> > extra virtualization information:
> >
> > ________________________________________________________________
> > _______
> >  |                      iommufd (with vIOMMU)                            |
> >  |                                                                       |
> >  |                             [5]                                       |
> >  |                        _____________                                  |
> >  |                       |             |                                 |
> >  |      |----------------|    vIOMMU   |                                 |
> >  |      |                |             |                                 |
> >  |      |                |             |                                 |
> >  |      |      [1]       |             |          [4]             [2]    |
> >  |      |     ______     |             |     _____________     ________  |
> >  |      |    |      |    |     [3]     |    |             |   |        | |
> >  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
> >  |      |    |______|    |_____________|    |_____________|   |________| |
> >  |      |        |              |                  |               |     |
> >
> > |______|________|______________|__________________|_____________
> > __|_____|
> >         |        |              |                  |               |
> >   ______v_____   |        ______v_____       ______v_____       ___v__
> >  |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
> >  |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----
> > |device|
> >  |____________|   storage|____________|     |____________|     |______|
> >
> 
> nit - [1] ... [5] can be removed.

They are copied from the Documentation where numbers are needed.
I will take all the numbers out in the cover-letters.

> > The vIOMMU object should be seen as a slice of a physical IOMMU instance
> > that is passed to or shared with a VM. That can be some HW/SW resources:
> >  - Security namespace for guest owned ID, e.g. guest-controlled cache tags
> >  - Access to a sharable nesting parent pagetable across physical IOMMUs
> >  - Virtualization of various platforms IDs, e.g. RIDs and others
> >  - Delivery of paravirtualized invalidation
> >  - Direct assigned invalidation queues
> >  - Direct assigned interrupts
> >  - Non-affiliated event reporting
> 
> sorry no idea about 'non-affiliated event'. Can you elaborate?

I'll put an "e.g.".

> > On a multi-IOMMU system, the vIOMMU object must be instanced to the
> > number
> > of the physical IOMMUs that are passed to (via devices) a guest VM, while
> 
> 'to the number of the physical IOMMUs that have a slice passed to ..."

Ack.

Thanks
Nicolin

