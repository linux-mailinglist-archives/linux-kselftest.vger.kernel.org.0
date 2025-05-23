Return-Path: <linux-kselftest+bounces-33685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E9AC2B6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE03A8292
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81531FF1CF;
	Fri, 23 May 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rr22k/P8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9A2DCBE6;
	Fri, 23 May 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036331; cv=fail; b=Zemjkz/IjxAjGReFTNGSjBpPbLcHH5FtN/0OXYndbPghzqkRFPyIZIcXhgQ0NF8qoWtDgZfMPGCvt077wG8cQJJDp3Em1G4he7gD5jYDTjkz0Hk3m/Foyat3DTk3iPrrvxgbt7cYN56n6/SE8nKDnyBj3cWeqplBxviBAi4R/O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036331; c=relaxed/simple;
	bh=2QLCKtbX2vlZ/4kOPz8KlIJo0y5Egs/NN2+qUewcFrw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5MgztJmPNPVAl52wYWmYqYpbwzy0hEw3bpH11+J0MkjaDehMiBJk+tAsAwJbw0kWx4uwwo70kB3hqCvt+2UF+6hxQT3xe+KA5ngKX4zgCu6ElRvqGnVpjdWnf/xHM9f/E6TwDImMktKteLArTig4iyjKobvYpWeXFSa502R5V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rr22k/P8; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjAMII08X+NWbN2Ciqwhaj/Oimr31/8jKHelu2fOEYlLWL6Y3L3LEzkFpAcxGwxUsj9ZFL3ab2avV0s4Lt9BmA/mMxt+CHEBxeY1Ucomb7KnlxCFRaiq6yCjLL0kEHT2URAhcDIXx4G0/n3cvc19e6o85UIe6ViFztpwHga5lT0iEPcjrnpoEHGCxobH2ifAQeQnDOL7SsnVgV5qaUg4bEB9hXEOUDca0RNVP6moWucxsxHAJlZ0iOIZyJBDDalqazrDRx9sTyFM2vQlOhJoEEsG/0Ap3uepsfsVD+szLAYBHeK8hdFiYGdYfeEDl/LHlN9RF5v0Zl+9gJcz7kf+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdsTgf2ig//aHH2GxUEG4W4gPkprtjhrjxNuohg+uYA=;
 b=MztpU1xAL+VimybCCO5dQT1BZIbX0egUC02I0/UxakLlPqyN2ScLSm+8LBG1JMAsoacmlq4lMSTCrspuwSPHuMpvRDCmOJlQPAqEA+NUweFppKEk5erMGStL+VQodIGnOTF8BZ0uCwdc2NM6R0Jp/2JTa0ZdfwqafqOfVB0Qt9471VhEdYZBL+M/LtNMQRg70XEvKZHSgYj4Dl/uHKALWcZmK3OaxVt/m7B6Kd3Ff5+KWqWhC5BJJCmZBM9GKRrqvlm4OUyuLQfURx08C9Fy4g0BfDl88+BVvFigc5YiAwHZF8dSh/MYXJhu6qca1pymKKiAWbBNlSYTl2qOBy1a3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdsTgf2ig//aHH2GxUEG4W4gPkprtjhrjxNuohg+uYA=;
 b=Rr22k/P89srh+gTEtxtc9A1VgeB6VK/BCziYepht4ON4NcRivr4dLLIU5XhdF2aELj2WGavFnw0cWCF5+XL24p9JBV7dxEywXan0BaYa1PXVN2A/OO5o6o3nheeMT8btL38XxaY+VKlqO4lM8uAUVj3A/6tvJf8ebzGFT5l07/lr4vkSOiRIUBOOp1LEnJcAA6BEELjeaeTkjFa13GbuF+Znlxp9azWJ9Fnpu4q/9rjogK2cnovnpK/cl8OdQq4vgOhHQ+hDFNTbOIianlKUowUZ8VfAJPX5Q88i07DM8r1MTdN0gtCRjaiLjIU9UxsfdAl09jWUaaQBeSb6M2ruZg==
Received: from BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 21:38:41 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:117:cafe::9) by BYAPR08CA0063.outlook.office365.com
 (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 21:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.0 via Frontend Transport; Fri, 23 May 2025 21:38:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 14:38:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 23 May
 2025 14:38:24 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 14:38:23 -0700
Date: Fri, 23 May 2025 14:38:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Message-ID: <aDDqzeHfq8RtYCnJ@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A0EDB2CAF2C333372FA28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A0EDB2CAF2C333372FA28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c2f724-290e-4810-aa36-08dd9a422f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oBx+NtOUqRSgwAmYE1jDDqxBtaGIvQ1PFOyEtvjzAQfdNiQvCXh/qx/yvbeG?=
 =?us-ascii?Q?ElxuSr3hYozczUlG+Y836RDqkUb66CK0nksg0QMPxGgi5TkHEsr6e2MoBcyV?=
 =?us-ascii?Q?pKIpWAv4Czt8EkeDhV9fXTWPZaINTMEoFP+FHQJUCchtaE3K6HdRnMNs5U5F?=
 =?us-ascii?Q?6XK1voJT8ZqHa9sX6vvSw7QxJn9Y5OwHK2Pcwo7agu8nksASbpozDSGzX+Jr?=
 =?us-ascii?Q?NuYUVnFEf5h+6ZPy4Q5LkEhG+C44OQReOOeN8wxUgLubu0eO+Cs03POuN2VQ?=
 =?us-ascii?Q?oC2S1SrZBcP+4xVA3XF8/LlwubJ3XiFiT3Y88RNH8P0eYNE/psUtEqfEVZ2k?=
 =?us-ascii?Q?wjdlx8a6hYLGJJbhd/bvaYzjH4jcE7rzFQbXPUtcY60C5hR3X2GnzwUSJyr3?=
 =?us-ascii?Q?Tb2SVfyzJTbtaCpr9BbWNZ05MeE48SE/rVfj3ha32tpzUf+mxc5ZZR/ntLL+?=
 =?us-ascii?Q?oNDQnMnc2JmLHpaCxrvgwPEdsFwJHjLmMLS8tB4+tueMaukt+j/cxzKhUMMi?=
 =?us-ascii?Q?B+4YuX21omoyCK71yjCYjS/NO8WBKyrC5/RvNXYp16/YmFf67HiQ4d+7Za+c?=
 =?us-ascii?Q?Ng9Onqo8cidS/1UnkXMygCwD8EMC1sEhysBdNTeiX0rNrzDm3XVhHuztVN2d?=
 =?us-ascii?Q?BBgoRurSnI9GUrKRjHzJ0lpKY5aY6w0r4Wqowe0jDLXh9gx1CAls3HGK+zB+?=
 =?us-ascii?Q?ZVNm9aisNQZmY8KfkUQSVaxsNXfGrrTvhaAw6cjUaZgyw5w+x16msHF5oyVp?=
 =?us-ascii?Q?R+JYfZU9cu64nAleL05oGrDNfM7sZ15pe3bfDPHSZoWqCSD/IbfHJlgP5ueK?=
 =?us-ascii?Q?QQbtUxQfRAeum2fL/t5d42jDdkvmFi0O2DSHALr33iadNuf2l/azW0AQLiEl?=
 =?us-ascii?Q?gM6qY2A2+Jc05kWVX4E5UQHa7gENsF6MPFlRPl1ynevP5teXjf5ZY0Wv90lg?=
 =?us-ascii?Q?ENdBSn7Bwo5aHjoDrBfublk568COq5K+4V88fy+Mu4PcFRwnr/xl8Tppzzph?=
 =?us-ascii?Q?m5vwXLnfTd1jbONnv+hpS5YE131pxTa6z8MvnUrRuqzZA/oDNfNYglgm7fsD?=
 =?us-ascii?Q?xxUCjOMIEDLJHsN71wZ1dsHB5DAjDlrM0uvVOnkiGzrmcO5PZVsN3OLVC9Aa?=
 =?us-ascii?Q?ZK1awLNGBoxRV0HpGJutpjD0GhUVFdTHC7Tq3P2xy8TOUtQf7CwJOZ0a4UrT?=
 =?us-ascii?Q?0qRrupWQXRBipcKAvIawr0AO26pn+c2YJ7mYIVEp7B2NtRy57Kq+VqIvIEvv?=
 =?us-ascii?Q?6zKXOniWde4OCV4ArxivnCkSDPQdJJ5aaU0BxoebqnO6b8MXSmxkI5hM4SnT?=
 =?us-ascii?Q?feIr9tPazlw4N8u7RgpbTJMohUc7+I2Vh9GfdUYtQTKflqvQP9tPd5XAUnFD?=
 =?us-ascii?Q?L5vpqKQPH9yBXsiaFyAKyGW7fWNOwhWrjDEvaBAbc6s1X5p/t99Q4c/BbICN?=
 =?us-ascii?Q?/w3JfQuvWfnRsupmaLf59ykIC+g5tt8o9jMacWLBtqBYSpGLzFlRGf7HH7Za?=
 =?us-ascii?Q?OI/v86m6aIjbihUBsNSswQVKha+P05f/4Clu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:38:40.5784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c2f724-290e-4810-aa36-08dd9a422f38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

On Fri, May 23, 2025 at 07:53:37AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, May 18, 2025 11:21 AM
> > 
> > @@ -48,6 +48,7 @@ struct iopt_area {
> >  	int iommu_prot;
> >  	bool prevent_access : 1;
> >  	unsigned int num_accesses;
> > +	unsigned int num_owners;
> 
> What about 'num_locked' to directly mark out that this area
> is locked hence cannot be removed? 

Yea. That sounds more straightforward to me. I will keep it plural
"num_locks". And "is_owner" can be just "locks_area".

Thanks
Nicolin

