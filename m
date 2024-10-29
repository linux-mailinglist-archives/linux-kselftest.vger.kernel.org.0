Return-Path: <linux-kselftest+bounces-20984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E019B4ED8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50CC1F23A29
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E866196455;
	Tue, 29 Oct 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MoofQmUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD9191F66;
	Tue, 29 Oct 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217906; cv=fail; b=MwiDD51JCoPkYpQkXwCA7fv6iaRIUfrnDT6w1ppk8OcPo6XIPDtAi312E/ZnQgL4XWfpfAc9Ekr4JeZoqu54A1AoaNoM4l556CN675mK1uRBO3sCw0Mu3F40H3fnaGeMnrVRVhhgt1Z0IeHMTUVYlCjW+atxj2yA7A3SZgD7MaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217906; c=relaxed/simple;
	bh=fT4uG0t0OOCAk50L9Z6zc+wI1p167Z/Ovbz+sI1aTX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxAW/OAdk54eZNBjDjcspdmKcPbQ5pz5kvjmCDDvKop6BeXpOvWvFQF2U+NIjz0v7VbTGUi/HZpVVYU7n2mPMSOA7e7xhguKfYp/I4AxuaIELHFfmQ/27hGJT17CiUEWfBuCvRQD7eLUWDaWwVR6BdYQ4ukboTivdtlBHlz3xpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MoofQmUV; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se3IYcs8q+BZMWYHlFGCqCcM13cBs+3V6L3Jc1Gzg4+qEbbvyp3VcwvcC09pMLaGPoj39Rki6NkxO3k+ZLhkLHHuKwILYfF1MDFWsQDCpUd8KLtBMm1lVf+aUC2k7B/+35OOC7r500C9Hae3QtYB8afQUsTwYbg0GEBudJaF8a0BVTeGTxt9QxEj0P8rgbky1FqElHmSfcSwU9cYogKNBQGL8K6qkzjbY2TiOEIUijRn0ldxa2W6kUnY/mmytbKpHxFldOuf04XhubdM0A3BiWB6Bob/DQdTvJDKogwelPQ2EcxJOSCuDBEwVJOdorqxG6aI1IsXXaS1gpYJ/RXRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7KMGgQ2HHla8xIWt+EwnHYluEsTA5tubyklMDtXzQg=;
 b=rfIe4WP8vJhIP8DVdHNX6Wl0Rq9UxhYbR+DmV3fAoxpJrhLN6oB3KjVfAdPkoC6ST+UI5PMB/7hC0gWnbwTybW23ajiMi9LPPJFdCkK0lzArIUZXCmpgwBy+hIkGc9wO8Hc2e2AHqvZUOrXCMdG0i73irToN+jApOJDsKBSzIP5FGBRSdAeCpslEyoaol8tx609S6fjISk1ae7TPzflXylIIe/ehh4rmm66aqL4xTcAASZ7tDR2J0HrJHjQxpCbG+zgBO8oGeyn42EA1I3GAuUVhE48UYslqd2NU8HRKwV+saISmiFVetRa52dCRHPpZLoh2OZDJlGqI2jQokjHOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7KMGgQ2HHla8xIWt+EwnHYluEsTA5tubyklMDtXzQg=;
 b=MoofQmUVOWtZXp+KKpiABYeiSe2+b9FKBeA01+Az5Xe++TBQUE6CaJx5N0B9ewVtKci4Xg9Djy0yPf5xd1aQaWcv3j9sNkOMjkDt1RCPpfKmXjEnXFj9vnTSwcaWb4L87UWdB+b2PMBBHvRt2mBQXLsdKp0oNzn7CXFwC0lkJ+T+Z++LBZHgaqiB8sPtuJaqyMY/tp+Gk8YKFIC6Iy41Nzn4g52VXsmvw9ayiVhkP2uhi+H1Ur4FddsAQRcHbfrvSO2ADbnO1+ZtXdFdUzJbfLUwHds0vRUNmj+6tnmS+2xQLoki/p5Xnr4rY8dnxbw1m7pRLZZAVVVwrwK4vKG1fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:05:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 16:05:00 +0000
Date: Tue, 29 Oct 2024 13:04:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com" <aik@amd.com>,
	"zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op
 on vIOMMU-based hwpt_nested
Message-ID: <20241029160458.GM209124@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
 <BN9PR11MB5276EC0C0CBA3AAF700B57238C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EC0C0CBA3AAF700B57238C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0424.namprd03.prod.outlook.com
 (2603:10b6:408:113::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b2ee38-9d84-41ce-bdd7-08dcf83370b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nzH2EN00Ryh9PNOJv0CtbaFY0fKmI80Z69eTplcfyM0brCtIqFlmJlTq+82?=
 =?us-ascii?Q?yubynOC2+Dq0NirudW3okWfXD1VQkJI9y9+RT2OPwDZsSoifiLDmSSbb/ylN?=
 =?us-ascii?Q?86lyQ7dpDjJhznFZWTsJYwfS9Oq69MkWakncaVnjpoK6+fGOu7OCW6GEBDCo?=
 =?us-ascii?Q?mb49y5XFiLyaAKo+r+DgXFJ81IWxUU9OcXq6R6y3arcenku6f0DBcY87bcZE?=
 =?us-ascii?Q?cKxpHhFPH7GqWEOsha6TzxAxYTgxvDZx1SclkFlKTAS9xP+LiO2LGSyJ26+E?=
 =?us-ascii?Q?UGcgoOpA4NvLGTBu0NpDBqmJbbr8SFEngQld/+usBU02lJ8AVJMgYwSX9dOg?=
 =?us-ascii?Q?BaTWUlVFdQR/rn25IgFTgtZGNmMKHrrrHSeGLRLVAjP1kd2F53Gj4NF5SUuC?=
 =?us-ascii?Q?6pUY4XV7siPHQqRgqsbtLg/SJ1W5vJ6qAaOOZzTfjquS/u1sqLZCSeWCaDXm?=
 =?us-ascii?Q?slADgJom/Y5wpXH38HrB32UxzDNGgpCtaZC1KqzJQGsF6dBXy3w1+1GjV7//?=
 =?us-ascii?Q?092G+Ab9zpkUvcD7MKINFZ9Yo6pw6fw+luxL1UB/9Fkw5QpfEAu4K73sdmK4?=
 =?us-ascii?Q?Y2kIQMf1nfpyQw5HGa+NhStPUHtwwZIHjC8yEPD3l++glzo5wRz4R3G9fiCn?=
 =?us-ascii?Q?XqSoQA8KCR+qMTgWrgqoybYzDqSulw1a4wRcSSrz6ERmSKwDxBWXnQ+cP2Ya?=
 =?us-ascii?Q?MGByMYgbwW3/8/CvAFe/m6fhjCUpaJKCEyFg800OFYVT9UxM0kdyWnJfCbDT?=
 =?us-ascii?Q?AXXuFRVPl0YeDziLwesLDRgqcIy5lAsgxUYrVbrxvmhxj1pN1pP2uR/YRYJn?=
 =?us-ascii?Q?V5w1JjQiagh9fYFTzrLqrdB+uZRTkKjfI+nVKNRbmMpts8kP3KoXfOnacejU?=
 =?us-ascii?Q?My6pvERdaiGYKF4UqbdDWoEZKMyV7l2uye1pPggxsUL0qE6ndJHt/szfhnAD?=
 =?us-ascii?Q?PBfT1ylGTD1oDe4tblx0lx7DllWIPdS04nzsivqeshQGewQP2at+uwfpSLOP?=
 =?us-ascii?Q?mD6nRnB/s1UVMvYKJaOvRUJjyK2SJ1TlfVWnmd2z+saA8H5qpyQTxT6jd+JN?=
 =?us-ascii?Q?4Dl/O5Zaox/TxhjMGtx+S29BEC15wvpfwN392FSguFLU0u/NYOwoudLwGO3p?=
 =?us-ascii?Q?18RQt7YM3Wrk12/Y94D0g20GDaeYJHaHsN/nAcOvMD9cp6jI1DMSolNlW6H3?=
 =?us-ascii?Q?HHlIaABYrGm5crGAC3Smya3HeFmIFPUQt+df9226McfTYwkqM0wWfMgoOv1m?=
 =?us-ascii?Q?iR2W74O1ikfkSL65esZlfytskWkTmm6x99BxZ+4rCsn9SpKZA0S+66wHB5Dm?=
 =?us-ascii?Q?nV89sWQ2lcdHr/ycV2tVvvOW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgQ9JDPhqh56Zorsv8kqN7UHwHnZ3lYQ0191guE9wsek6+5/eoj4XVj+aBr+?=
 =?us-ascii?Q?zr7UtBJhGjMRFztjfT8JyMD4K0WQnTZC7E+M9PYyWle20cs3wrk+mbibkZ1B?=
 =?us-ascii?Q?zfEWTcwCvz8N+AescPeuE0UZbrZ/fVx5e8Ons4B0VsWfFzMxiCQdpQx9Gm29?=
 =?us-ascii?Q?rAJIOGu0KjDza5zu2EjqZLormEpSKAeHnhYMOr7s4tC1C1qkrV3z1hcLJttR?=
 =?us-ascii?Q?tGfhm18UXywPFGuVn1GP6/bDIzB14TQmHejlIkL8XR4QTC2gq3pW03C63QRV?=
 =?us-ascii?Q?5HEoQLcA6OHlKVORZuk6ohH5JS2FX+EvzsVjUd8wJ0Ut9cIEadronI+HFxKX?=
 =?us-ascii?Q?ZIkkEQoM6EVMQSINjDeGLiz/LIRTm4VEUsJ76HcucCwHpdF07mN0UoxO66A/?=
 =?us-ascii?Q?1QrMT/HdO/8nq0GqNnyTMtcC0/bDmgs4Vv2gOud8ikRkQ9DMRbxsQ+4V/Zxe?=
 =?us-ascii?Q?XEsqsFOQrpgVXpdQf+GLS4B3OeWWW/RYV6Ys6tcAnbmy+x8dFEMjOnXQBsFY?=
 =?us-ascii?Q?D+p/E4ZfsHTwh3wXIAU6R+1m4nxPuLNnUagR4zWjXtLiR+fzjBm6CEo63PnE?=
 =?us-ascii?Q?DmN1ND3oKxH/YhLfUQZrfaj/H7Uc/Ev4woHzThyC1fVrqphYCBn5V8c4Gsre?=
 =?us-ascii?Q?EIpVJNxKg3BLvSU+OE3FRyBqfBzWK92nVhPDqqG+6Fk3VYD7Oq3w6xVXWHhT?=
 =?us-ascii?Q?5fZgt5+FagR2YpWoPyXP32ZIzhisFQfzjGczkHkAwKaQrHeShDIhNkTm4BLZ?=
 =?us-ascii?Q?jZsD3Y8DhjDkaiFx66yDIxTEX7zK4k5Mp0wmjFvv82RBbWCzQBsaiRoHjikb?=
 =?us-ascii?Q?okYWB2FzSqum1saBj7EwJuuUlOxapcqDLUtIwwLWE3wQ1x1hPdPFFCLQKHYo?=
 =?us-ascii?Q?wbx3US+5akshDgT9Ym0RaaQweGMLcEzJfParbj2wQoJlPv0Rw1qmsT+aFJL5?=
 =?us-ascii?Q?d9fqyJZX7xZylRxlMG144LP3OonCsN57yB4nyGHesC0bcQ7wGwYIapLR3Vgd?=
 =?us-ascii?Q?9lGQ6ine7P3Pv+YImdYxxty7Ui03lTnLLMknJx1CS0zTD9Ol7AoOcW+tWLW1?=
 =?us-ascii?Q?7T1yNDZgmjkwL0YSh5V4lFfiI4Zv7mff6CTz+yGqEBJCCZPHZEP7BTm2JCQ9?=
 =?us-ascii?Q?LDVwN/KeINzDaItvecISMao50ETjNOBGgJWPt3nCoKhc3eJlJjzRq3+Wco9i?=
 =?us-ascii?Q?Tf7+36d/XPUHo9/wtuivpXG7+mqTPwoYp2mwwX4kiG+J2djz84TRrr+a4Jxm?=
 =?us-ascii?Q?R1nF0rdBrKiYplic7v2tRVJYv2R4TPWbUo89ODZwl2kWwG715L8eAcyxh09X?=
 =?us-ascii?Q?u+lDLC70lXqIs0AN4iQy4lZjHm0pH+tZUx/9y17TZdHLhuygbOIWqn16ESte?=
 =?us-ascii?Q?zKlWN/rf/czLrxGRZm0W2OsfyA1dBLimyOJ5njSkwhNB9Mp4qWlMthmXx6kt?=
 =?us-ascii?Q?McLRAUwudve3UnjCuefzVfGhQ6y/nnNOSIh0v8d87t2q38IQY+yLvrexLoUu?=
 =?us-ascii?Q?Iw6Zo7HDMerKdIfioXXzYzec28oH+lpe4hm8u4hs1Cq65fiqMrPnkgUmTBUv?=
 =?us-ascii?Q?DEmPpYq0bhXGLpQegEw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b2ee38-9d84-41ce-bdd7-08dcf83370b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:04:59.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4iZk98DBTGM/hA0p/jBjGmPEdvWfQbCSFTa909tttRTAuAUqwREXVKEOGlUbmDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

On Tue, Oct 29, 2024 at 08:22:43AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, October 26, 2024 7:51 AM
> > 
> > @@ -302,7 +302,9 @@ iommufd_viommu_alloc_hwpt_nested(struct
> > iommufd_viommu *viommu, u32 flags,
> >  	}
> >  	hwpt->domain->owner = viommu->iommu_dev->ops;
> > 
> > -	if (WARN_ON_ONCE(hwpt->domain->type !=
> > IOMMU_DOMAIN_NESTED)) {
> > +	if (WARN_ON_ONCE(hwpt->domain->type !=
> > IOMMU_DOMAIN_NESTED ||
> > +			 (!viommu->ops->cache_invalidate &&
> > +			  !hwpt->domain->ops->cache_invalidate_user))) {
> >  		rc = -EINVAL;
> >  		goto out_abort;
> >  	}
> 
> According to patch5, cache invalidate in viommu only uses
> viommu->ops->cache_invalidate. Is here intended to allow
> nested hwpt created via viommu to still support the old
> method?

I think that is reasonable?

Jason

