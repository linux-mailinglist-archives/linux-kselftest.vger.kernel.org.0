Return-Path: <linux-kselftest+bounces-16166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179BE95D371
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA551F21916
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6C18A6DA;
	Fri, 23 Aug 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eu7QoXHC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947C188A31
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430600; cv=fail; b=SBdbkdTOoSADNMIT6hwG4hcQPC+fPnR8pL0+rYpdzeV7pTMoecnNhiucL3/W2nFh9AoZPuhgp93p9I8cqImwwAyOPQrz8FfLczucP3wlQxhL5K0y9gh1VokkaUHO/7fmNgHxQIzvI7hyeIxv2oDbIKPIZuRjJW6oJtstNvdyfds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430600; c=relaxed/simple;
	bh=iGnM1mSb5zI0P4OChHv06HLAH9sRDAOq+9/UcvPiSCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh7W7dvQgvBkA+cZ9OwbMC2Ylj/iQVIvTOF+Yhwm46j4feev3svyQEPGLn8TcSLeWFnKqdSRONUF56GRQQ6gH27ykqMDf/M6IYTPjGL6cQFxEJyisCVuktWaRBa7/NgIBagqAkwJ4MyoWCOD5F6KGhSfRDswV+LZqBKKcU/eYYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eu7QoXHC; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDYv7TD27pxxVjI2do2OwIrrYgcd+QKIWqgLcDOU1XGoyaPB3T9oMrvEgWK1xn3wNCkbRbeui0ELbThDea2P+69DMtP5JEaEW29oH2AXSusvvl4nT5h4x4B0fny1dhbtTuYtU64e57ERtjrlRN0bFRCi6KVntnIjRLbwOxpM00j9DdFGL3KZ2aAJIPctnlPLkuK3SgS3lQCN5zPR8Trtli+wo9JLGWgOCJ1luZ2mrUJJR/55y0ExcrWrzl4Fo8nhJCJ+3IhXKusEgdqP2kFgn2pJ8mvehlJpqHuZApUA43esvGLHVSLpLy3qZFOpfxHlkHdnTEgGMENyDBoL2rfJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zbNR9oRln4sjy3i+6mGN8H4/ABGzLMHl881jNNwnLY=;
 b=u0G26iOlfoNUKB3KPY6X29N9CRE6gaC3kj6MEbUI1ps+E1m/5aSpOljTHpvTbz4/BT7oyrZJTjBe5WRcm0BJugVD+aOXjAU6z9arW11tbuaD1vBA7IdvoWsdddmYjCvOsMF8k9tpVrEXtRmEONH+iYHe1x2lxF2HBRiiO+sVBhl0RxrAbV/9ct4y2FcQkgMriitM7Ao4Hj/QLbmiNIqKMYpPIuBA4esAPRoQdePNFkW1bRFqf2cHWPMOtRsDXXHE1z3hH5VsvbhxZlUt0Phw7VcrOaZS5lU/ojbT/qg+KNVXpOsnBIME1gbRWD1pEFohN/l8kC9tH7DI7nZx7+mY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbNR9oRln4sjy3i+6mGN8H4/ABGzLMHl881jNNwnLY=;
 b=eu7QoXHCJ3Z37L/hwO/mJu/4+cOjdTJ2MvEYh/KKlf/H4EtY5wEEAgoDZe/6E17B/HhRgREgDKORYq4e9n6U9nosnAwrCunbV7VwoUkWeT6n8nBchZZfHwJ/NzYEUVcZFaVFZkQakfDRVgs4eUJsog9gMqwxSRY7hIBbEiS6/AC8+QrVTo3ir+s/WgqPBj0eL1OMhh7g5RPMWh7TiUOEXYiBz5oHfvhoBKvGNg/n0kSDmmgmWrAYLKlr12XcWSipMvFGY9uFpqhTQ8IqvEgbshyhR7kGt6c8bAGnaLXlkbvaKbuC0nGQIydi6yAK4BbL4LA8w84+nIxsyNVEcF5mEA==
Received: from MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::33)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 16:29:53 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::59) by MW4P222CA0028.outlook.office365.com
 (2603:10b6:303:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Fri, 23 Aug 2024 16:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Fri, 23 Aug 2024 16:29:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 09:29:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 09:29:36 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 09:29:34 -0700
Date: Fri, 23 Aug 2024 09:29:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alyssa Rosenzweig <alyssa@rosenzweig.io>, <asahi@lists.linux.dev>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Will
 Deacon" <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, Janne Grunau
	<j@jannau.net>, Joerg Roedel <jroedel@suse.de>, Kevin Tian
	<kevin.tian@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lixiao Yang <lixiao.yang@intel.com>, Hector Martin <marcan@marcan.st>,
	Matthew Rosato <mjrosato@linux.ibm.com>, <patches@lists.linux.dev>, "Sven
 Peter" <sven@svenpeter.dev>, Will Deacon <will.deacon@arm.com>, Yi Liu
	<yi.l.liu@intel.com>, Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH rc 1/2] iommufd: Do not allow creating areas without READ
 or WRITE
Message-ID: <Zsi47Ek88/f42hDd@Asurada-Nvidia>
References: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
 <1-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ce5f87-4f12-4fdf-0fab-08dcc390d0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Inmg3XNRv/LzxdcsgMLGDHHNIUS9IO/qpKWiIS3QJYUDLeqGK+ZoAN1fhuAW?=
 =?us-ascii?Q?B0bgO5kzCV4uq8pg2BPgaykXqH6W8B6Vt1l38X5JrSNXzxbGAQGwmTgYBHvm?=
 =?us-ascii?Q?faOlcy8H+uEFs/5m137FKv6OlqTzbxKnQmsGg/JNhi0taNaebW8kgjYu65Rw?=
 =?us-ascii?Q?Kr8ONUbuuTO7s5dr7S2jcTidNEP08fpI6UnikwKuA7LyLjs3b5Nk9v+OBVN7?=
 =?us-ascii?Q?ylCkh/A/9yOh4DEBbnTvwXaE/7UtCGDZtgX6HnaniWBO6eB82XVJVSIKaY0+?=
 =?us-ascii?Q?11PebbPb3zKWinuHv/ueYKJsYWue6BKkpGKJt1ItddCDuIM2c3k4svBbyQRu?=
 =?us-ascii?Q?6D8LhPOqvTzqJ6DY/aO6vZWK3BLubFMF13nqBNtjw5oV5o5AeZg1inAADP89?=
 =?us-ascii?Q?mINeHbdo1jTJXXkBuClAkl5ko71uLjbMz/Y02a4JIXQqZXwkVizvNL1ijFSJ?=
 =?us-ascii?Q?jkIQZWdm48tYi7tXk3hLfSaCV1KAL6SvbntyVJ2xA9Ao7GuLkdM5RUg8zySu?=
 =?us-ascii?Q?uzfVIBBeb+wWHblNhwAxVZWX1molYv31DFgoNkQYIN7YZBdcOaNz4kAjEsmq?=
 =?us-ascii?Q?l1HmrF2qdQgSb0xpSacCUjF/P2rh89v3SBsNHHd7u3RfRMEtNNHshop+dfsL?=
 =?us-ascii?Q?+QTD1EDg3MbaS9jeBS/LQE38dVbGe/s3zRotHlinr1wwM+UmHbemo5NFh4vd?=
 =?us-ascii?Q?yhqIcyDirdwE/VLGkgOoRXp6BUZ6uTv6G+fmsDT5Fhk2Y+Xaa0shuKazPMeN?=
 =?us-ascii?Q?retk6An/YNMhImGyhbiXayyHk4EUAQwE9TABqNOtvJ60ptvLhVWzWQ7Sc05d?=
 =?us-ascii?Q?X3mKuhkX/hVVRvHGXl7A92U5xP+UrDhBT+YL1kIiLp/jgBzxg1FU4/DY/iNP?=
 =?us-ascii?Q?f6KXK9/7FU10Vo/eKOiqst77w/nqdbATIMPoNUK5swU5ZQvPEzx2SIB/pyoT?=
 =?us-ascii?Q?0HBrbKciPw93isLf+4nC7hgmi3U4sQMIkN7kbRJ3hwNVMdGmgoyvHY0FNklP?=
 =?us-ascii?Q?QRWoOoNnphLa7lc3l+RC0XRaRXl4WGtk5WiE7UGLs7scoTxJKLxVZTNkl79C?=
 =?us-ascii?Q?+YmiTAkNYIVXSPKSZABjo/ClAL8FXKxE2Q+BdKNJp8hqCuRKuKxqtGXqHEkr?=
 =?us-ascii?Q?58uMmVz2+zaCnLogf8FWhNYYcF0gnp/yFNWLuLkL3OBKUtUsy3wX1Vh2LwAV?=
 =?us-ascii?Q?EFr5HAfzb/HKT4Ii3mIWRI764zRyoGv6sAWUHHiELgxUqQcsr9NesipRS/yj?=
 =?us-ascii?Q?qDkPFbtPm1OKgtN7CzDtGMIHzL1Bmk6yCvMBWXN7iZdCsENq9oaLetSoR5bJ?=
 =?us-ascii?Q?ZPeh1zH7iYHY87WHBDhietQ58EdCXgzBzrlzqgRF9OgwI7be9h3tKQQdwKCA?=
 =?us-ascii?Q?vNFWpyg2OpVGYbAObVhYh3H4iCYX8gMjgYAHFEGud2YiLLqFTWjD7oVkS9ae?=
 =?us-ascii?Q?5K3AEfUb/hgmg1j4rBM0E2avveaDjj1j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:29:52.4470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ce5f87-4f12-4fdf-0fab-08dcc390d0d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

On Thu, Aug 22, 2024 at 11:45:54AM -0300, Jason Gunthorpe wrote:
> This results in passing 0 or just IOMMU_CACHE to iommu_map(). Most of
> the page table formats don't like this:
> 
>   amdv1 - -EINVAL
>   armv7s - returns 0, doesn't update mapped
>   arm-lpae - returns 0 doesn't update mapped
>   dart - returns 0, doesn't update mapped
>   VT-D - returns -EINVAL
> 
> Unfortunately the three formats that return 0 cause serious problems:
> 
>  - Returning ret = but not uppdating mapped from domain->map_pages()
>    causes an infinite loop in __iommu_map()
> 
>  - Not writing ioptes means that VFIO/iommufd have no way to recover them
>    and we will have memory leaks and worse during unmap
> 
> Since almost nothing can support this, and it is a useless thing to do,
> block it early in iommufd.
> 
> Cc: stable@kernel.org
> Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

I also tried both patches with io-pgtable-arm and didn't see any
issue, since they tends to fix a corner case I think.

Nicolin

