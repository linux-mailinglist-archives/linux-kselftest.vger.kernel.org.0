Return-Path: <linux-kselftest+bounces-17281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94E96DF1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24AC1C21B76
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF619DF75;
	Thu,  5 Sep 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryjZAvHi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8919AA63;
	Thu,  5 Sep 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552310; cv=fail; b=bZhAU03ygOcULUlJpohRr+2iC7OJRfs25nW3AkPAX0ou52wBDP9IhXVTG2RJglAzp8KAXagUgnQo75T//UCyGmD22m4+p5LArxxE0NZHQZWs9DRjFtUNO0BZ2vOrnWhrNUZNKARWywCtdKeEEJl3U0xPac1b21WdDrdBJUarneM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552310; c=relaxed/simple;
	bh=bsWX2CGjjsAZzOtx5FWlLYxgCXLpJgUOjeq8ziJHIbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vkm/9p3aGfU7E8IGs8uV//MstYzTcaxp6O7vgpJ5aPVouMjtWhCUBFTQqxp4Z973aq4bYNm+rAnO5ge2SUvIscfT0O0oOP37Ws3GX9dxcRynx+AlPZPj2G5ax3TCyFJVdkwGwxgVQRBiQRZ7iWlup9dyg6W5sOsig8vxaJYWGR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryjZAvHi; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK0G8KdP2HveFm7T4fBRUUuI+Ko7jiXZsVGeSGPuGAb1V/FcDmbO1c3wFua4IwpqMo3S9EYi15+2v/G28EOcFBvJ0P+QRspLTcw4LyDYNL3zBfbra5tAAnGDkmZ1c668pMqRx0nZaPliK4zSKpC45ZMbRpBAV9yu20rZyvTh17kEzwbHQtQTcQZ/QE5Uy0mgBrHiId7oMm2lz3nA4Ap2gtkJv51KL1ofPpm+weUB4WrtwNuuaxamQDLkrcT9GVERtX5bNC90qtdycQXo3hlhocZF4kQCvMUPrg86RAIY7QD6Cfn5Aa198vJ3yL0Qaztng8/qSfuPtvBb5kEX+Xowvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3uLjvYVv9caHuZIpGX+LlN6v5j5cnAToY46Jsu1S5c=;
 b=tro1uANV+5Yt8uRdVxoR1qtyyg9jwrbbvPxEUJ6G9h6tgXye+wfQB/ESye3ddWXvsKiYUvpoT429hNhS7OJZkahOgbHxwXtqXje7KXiwpuqujwdzBuTi4wxAfivQfVWifiltE70Z5wwDj+ZvcX6o8PtP8vU+GipsItswbBZcMroeeIo5qnUMRN+fnEa60mPJkL+I6FxACnicqdtSzAtgD/MX279MNDJ8DIHQmCQaqr7jpiJkS4TkG1Zzm5NmPg0UVMpHHO8jqbOu4f6D3xtpsf+dJa5VZIfx+d/PcMun3twbdltK80bOrrr0jNWRz/61roAbMYiIpbwBTDtVEzAS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3uLjvYVv9caHuZIpGX+LlN6v5j5cnAToY46Jsu1S5c=;
 b=ryjZAvHiiJtkZ418c92grpez3V7Y5EhjlfEt3LbDoum/SN7M7Ub0r/gZHaAk6/+atm1D13889uhXAd7O6qvQpRc9r75ddERTDu9GxNYFcnWve7/BRuW4kivuPj6QPvWOjxXq0N+3AinQ3GmpgTh03BLK/87iFvSVdCHtKRSrCm6YKAVANV+edNBdelrB/d1jv5YiY6x/IRZkm44mwK6jZanj6TEkEVFPtUAPwBfiohiKZNUO5b6XgBVtQRptOABijaan0mAVDBF4slAhNOGzXv39IjvMXFjHi7p/nvAntxf5zuZQIo/X5ThVVU7e+lCKBulmF0TErlATPGoq1FiHBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:05:05 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:05:05 +0000
Date: Thu, 5 Sep 2024 13:05:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 08/19] iommufd/viommu: Add cache_invalidate for
 IOMMU_VIOMMU_TYPE_DEFAULT
Message-ID: <20240905160504.GQ1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <224732696abf91f220585bb26fa44314d7d2f425.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224732696abf91f220585bb26fa44314d7d2f425.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:208:32d::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: a610e0c3-21f0-43b7-7310-08dccdc48175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7eVEXbID3xhEfKCCW1FbMiLzr7+jf4W22nG/hASP4IFCsQe/zuzwBHg/FZbJ?=
 =?us-ascii?Q?GoKQaOtIQemiqDE5PvGhWYPsY89HGWWnaeqXU5bkhrz1DOMO1AGnOhAgYSAN?=
 =?us-ascii?Q?1WJRU7eMzhRHk4P+DoEcZp6S4kqAr8UuMCFwmzjScexpRR6XEZPctj+MCuWa?=
 =?us-ascii?Q?aNqAk4HXlPBGF9kIj4EERPpKRcgKidfoK8+je5Hp34FtQS9uXISvJ87jUPp6?=
 =?us-ascii?Q?6gq+pPSWgGfpc/h/++Zhp+p+7672y82/SteRHd8GV1FFaRSx4eXw8AKwH1aQ?=
 =?us-ascii?Q?+RWXFo1NZBgOyvOY0Rjobj/YTqD8x8NaT8Bd38GUdG/T38qL79xVgJqwfLTt?=
 =?us-ascii?Q?rbgJY8qCztwXXgODexT24efw6f81+nBGYHeWIvv26vcdeIUNRT+WGQFp2dmW?=
 =?us-ascii?Q?VklHKluiXnMCF1QWoOpuam3dM/Fs4U1vlELdlVrZhTTHHvXdt38ZXkExZD1H?=
 =?us-ascii?Q?w+81V62vRGYH1vI4heijVWleNsu7D/gaHClXFuAtWMJmNpv69A5iSBLSeR9X?=
 =?us-ascii?Q?RbfgckryprCBmoD1ixSGyr6xVZ3/1zy6SW8jmO4f8+vTgf/yAtq3K33FTULH?=
 =?us-ascii?Q?EnfSpGbyca3IWvr8jlCqLathaO6yQ1LHbpC6joNSw9PLP0ODxEgYErGMN8T7?=
 =?us-ascii?Q?+89rHHdMztLl3m2uMVOS9qsd2rJjRGhNJMy0vcYL+eSyt4ELjVQhrBNXmc0j?=
 =?us-ascii?Q?Mo0TcLQ7UG+LFsJtY1Btu2OYW/oAYZiHP0oiwlcfYJWEPuiQB8x5DhasNa9p?=
 =?us-ascii?Q?Ne7MWRAw4UGkls7lHR5F5WBz91xIvtKNX6bNZ+tcJJcYJixVMaxtLxMgrExw?=
 =?us-ascii?Q?/N1RZLe+L6PTdkYKCypDOs9kFEL6FNwPugLElc0dPlQVw2/pOZzFJ9UKz9ZR?=
 =?us-ascii?Q?LMrGS4JwagUwDjfB4ZZFlX8JRmlAjhvcPVYO4P5GZncSfMsuUp363/CV4Lys?=
 =?us-ascii?Q?X5GZvgswHRBg/EzgVwm604GY9oRHyXyeRTTyyuY/iL/E8q/UwNmNehwVAQOF?=
 =?us-ascii?Q?K64U7r+gldf9NGnKaKlwEupXVWpul3WlqcRIqNoPx0hfBQGRJ4XHnbir0frV?=
 =?us-ascii?Q?OR906orqQR8XKQxcpVjDDCGyfMYwOte/3mDF7BLs7D9LXEjmcPcTxYJ9HU7/?=
 =?us-ascii?Q?cOVQ/oEFOk7VqnTM9JVUhxtfxjN6B2mmr9kx5vaVsd9S7mYoa4y6F/Mdmyvu?=
 =?us-ascii?Q?EdJ1w13X/qcZtAA2ISDlAyD5KuYteoL3O8U4/UDo31P26fIHjQPzLfuxavF0?=
 =?us-ascii?Q?12x+K6ywNsN64yVBU9dZQ/sgNiUQx6cu0DB23rQVq4A2EIzGf4jt5eeTMy53?=
 =?us-ascii?Q?7GjoPn7ZVNGyIwSNTdoIeia9R03Mf1Ri2S0O2Xmv4AQSCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSOlPZod70XQWO9U8BX8sEkjiHF8Gc7/pYMXNmuKeXN/Ja04d/SWAt+WkLzy?=
 =?us-ascii?Q?W/eJ0mrcSJVwDK+vUlFc+Vld81aG7znBf1Lhfoq1aRHZk/0bmrI9K17t7aYz?=
 =?us-ascii?Q?ozE4pcOB2wIh/bifAO757VyE3nj3ZhWcl9ciHcgxKgjYt1BplT+7siYArU1A?=
 =?us-ascii?Q?K5Nbrz9rsGijw9vNXNVSMzQAMXZqo+fgwiso5hi+7aXBNgwgJQw8xyVcFyCF?=
 =?us-ascii?Q?jc2x6jRweSiGny2elTTnmjtzrY3qc18iu5PKKQs/vON4qKN8eCQHWk6WRIXE?=
 =?us-ascii?Q?dFq8mAi4B2EeFHWUnlBmQq6R3U25lsjbISegYu8MSvaSUe35/MDJWvDntURp?=
 =?us-ascii?Q?Zn9BHpIj2lw5DZ6cNkU+xr8IGzVh5BijXDGio0ybusG2EhWxiabLJJdK7CZY?=
 =?us-ascii?Q?W8EubfchtrK85Txd5ey3j6QMfJ22a4WIeTCeL8zplQVey8UxkcktMiRn/4Xx?=
 =?us-ascii?Q?r35l3fIWxpFuL0U/dUh3P9bMZM8qDAf/XhLd+vokvF5u4wl+kXHU0lvNkSo6?=
 =?us-ascii?Q?wlpF0C4IeJLC0YIEB4rpO14c0HulV8/lPfr3NBConEVahUfXJWOqG8FBOg3p?=
 =?us-ascii?Q?QgjCNg6n50K5i5+U50TrebHYdJlI/hG2lenzO+LQ3mKHL790y8s4oKeW9DK1?=
 =?us-ascii?Q?u9UC/adlZlRsNU5K1Jxk2MsGCyX7wpdp+2Cj3KxHP7onKpAFCnjo9rYkbdME?=
 =?us-ascii?Q?s2WLhmM/YWkq5XYTWBRHCiq5DapfuGEgM3BoHdZcZOdYTfiZuKmvQrEAIhoZ?=
 =?us-ascii?Q?+VFQkAO8q+WzGdv+YWjg4Pr4TwiGRxbVt+SZSd9YuxDR3MVOJoZ0+G834nts?=
 =?us-ascii?Q?mQU5/u0L+H6dSEjJMjV28EglY+ZMrZvhpGkSQZL0vGiKCOUY80BGCGtWl+O/?=
 =?us-ascii?Q?trME/gdk6oYGmIZ1Z4AU60u+eHkx2YFDG6IXbMNNMnuPU/EUzq9AjwmMjetI?=
 =?us-ascii?Q?1/6sO2UKWeTbPuQwuTKy4NZgFfMeHReU4Qimhrw2Fa0tOmtYTiKoaSqF6NXF?=
 =?us-ascii?Q?d2UbCqbjc3YrZHo+2cwJxL1JUswEmcwqRirq5fFUiDAIs8d9hsLL58A14SEs?=
 =?us-ascii?Q?1im9ctrG1heUkSZPCf4V1IB+plxMc88kHaVZYxaUU24N29hEi0DWyvr0iJer?=
 =?us-ascii?Q?mP1leEnrEGdvIAvCo4rVsui8bULDK0ZU84curaZFlGBl+gN3fX/IlIPUH9B+?=
 =?us-ascii?Q?I8umgVii46/F7Ze+4xEfNLGcxRLutf6zp2cqeLHLVhLnlvJxRQwLrouCPMWU?=
 =?us-ascii?Q?zrMz30PEmdg5c28fdq1OYOXfP2y8z+Hvwj70FOpZdQoL14KBqqJ8gmHpZF/k?=
 =?us-ascii?Q?bOP1x5mFknmX5kx5Pyc5318OHdpp7XA/6Zfaed2IOWQErI9usGHgRl6+Exzv?=
 =?us-ascii?Q?CrHP668u0S+axUVbLAEfwPre2zfFGDNs6DNnsSmFQ6kbDWz65NT6FdgGMlpJ?=
 =?us-ascii?Q?ByYekk/75mJYdfMcTBGeX9mNGDxMbEY7FbUQEYK0oWVEheuoaqghtBXo8Hnq?=
 =?us-ascii?Q?vieQuBDVdCBhS/16Mp564BfieS0i1pklR+mq2wJ7lkviyA0/Fzdmum29lOL2?=
 =?us-ascii?Q?pnRT2sMrkVeO/7GZe7+v50n/629jxipdkdQpFNnN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a610e0c3-21f0-43b7-7310-08dccdc48175
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:05:05.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMEPEHP8i6sRo9mAiJp5cqSX/m7Dnrg+7cHd6U8SMh4Hpw5cW6q0cwelBzGAskKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825

On Tue, Aug 27, 2024 at 09:59:45AM -0700, Nicolin Chen wrote:
> Add a default_viommu_ops with a new op for cache invaldiation, similar to
> the cache_invalidate_user op in structure iommu_domain_ops, but wider. An
> IOMMU driver that allocated a nested domain with a core-managed viommu is
> able to use the same viommu pointer for this cache invalidation API.
> 
> ARM SMMUv3 for example supports IOTLB and ATC device cache invaldiations.
> The IOTLB invalidation is per-VMID, held currently by a parent S2 domain.
> The ATC invalidation is per device (Stream ID) that should be tranlsated
> by a virtual device ID lookup table. Either case fits the viommu context.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  3 +++
>  drivers/iommu/iommufd/viommu.c          |  3 +++
>  include/linux/iommu.h                   |  5 +++++
>  include/linux/iommufd.h                 | 19 +++++++++++++++++++
>  4 files changed, 30 insertions(+)

It looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

