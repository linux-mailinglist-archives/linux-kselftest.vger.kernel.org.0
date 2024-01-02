Return-Path: <linux-kselftest+bounces-2589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CB822141
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 19:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39AE2828E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5815AD0;
	Tue,  2 Jan 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KTxc8KMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DE15ACB;
	Tue,  2 Jan 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6fkUj+9EDtvsfWws0J31vX15KHRD+6hu4gv8bKBbK48AvMewpOHpRBZ//YnHSsPslyKF650EyQLKCpCDL7+vXnIOtfXyg0k8sU0paxGYFNH8W+194IllrP/QOAEXIAZD3lwQ120UZ4xzbtSbIjs/NC/Wk2p7PXRt5D1tqQ9Mxfu6L5EBzKWDepxCo1lbriDSTlqvGDAyD4QOvSDRk9sL2cZh09CwvvXfHShEec8tbiHspGSZX1dsgiqzJxH3IPoOvZflIlJb1Ncxy8hh+yW5KgCOWn/Ut+hgfgTZEHJwz1loDzDM4hGStwcodqPwepUDuoZVrKtB+tPEd7efWmGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS1qXdzGqiJ4kmKkfzgpjT+ZRSt7TMK5z2sLTFbYoNA=;
 b=cxGBN8uGl8d9c30u/QUPZ8vWI37JtRAsO3LYJAiQVTovA1JhFISVS8K4tDvpTsrUpJWCqmkpJKHR+6lQjxzpgrz6OB/0biZnpRHjazu7/mf5lJUNnLCXiAkl827wjtj0gkz8b5tlV5QJkfMLjfBBAtnXKVXio9CxTFwqbCu8Y+UOzWHD9EedGFGMniJai3W+8FRHiZgNTsFaDG+81pP9KDis1FmjYAceQ7wpiuAxFDF1qD6rzqP8Q8BLzmXDOqOFB1HA29JizP1+y+PY7H5QWxEHZs3btJQPI2MfGfwlgBt+pjWp3/bqD6+AUwzGzPPlO2SN8P5iJ6AAYo6yqHaq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS1qXdzGqiJ4kmKkfzgpjT+ZRSt7TMK5z2sLTFbYoNA=;
 b=KTxc8KMF+8KhUI4kIqr9AgDQJomIyMZyiItuGmfvB7qrpaQjcXRnh6uNDUNFNdNjnNtLRgGiSMwmn/nhOzq6FjmcyWqzU2L7aVV6Jb8rOD5+6XWJKwRtFX/HfMcQmEEfOW0fb2obalCS3x/imH6oPsDcAtGsC+oSNn9cK7SO+a4Js2bJPSHvpY5Lf8bVbMwb/eNpIc+o2FBSLmPOPAyU8fa8Rq9tIGZuqiOChtHZToWMG6dVHJ7t61RuHvIi3WbN/asHIn5teehFGIZybSciLEaTLa42rC2E4ZXMcwNe4gXBCfx5Zv7mgmq4RqHbgW5mBE19Mo089sQhd13WnXkwhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 18:44:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 18:44:23 +0000
Date: Tue, 2 Jan 2024 14:44:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com, j.granados@samsung.com
Subject: Re: [PATCH v10 10/10] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <20240102184422.GI50406@nvidia.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
 <20240102143834.146165-11-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102143834.146165-11-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: aa461738-ed0f-4a01-0336-08dc0bc2d693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5SS3qygKH/5yjSoeHYFM3zOgeOAUQyOFjG1gYQWPWDn3PZuhSngD05pdQ8/jKdqSpQhvT1f7Gs5coTyhJ6ivknu6iGrjph7N92AnydySKLBKhw71tPeeN9kv5Cz+1PpJazR1w1M4C8Mdaq5viOmNQv4wuerFopzeIsFr6RnWCct73CM3NKydveEey4LjaNWtNrx7c0D9wJDOB6PIH4MUihxOkXaEGOR4kyE/QpxOJarjC/p/U+THU+IAv7lsa7GEInDpWp0cvt2NyW5iIO2lWUsQHg5RHN7nGzieJ9XwEEn2Ku7K0K+i7hvWFzU35LIVj3Q96PHmAuKCwSGHlrMrBv5Xh6PoTRTKfYeek9/BWSt58EqBxEM0allEa3eIrjCd23bobT7INitleTeF47q0s5aF/Ep5LzLudlQ7cA3SHFSiiXkT80C5HI8iJ3/yo24G+TcYWlz9Qf/Lz59IecQlq7P8VLmTOiCn9EbZ3RQbP5Z4pestAw71KBUaWx+PsSJ8sYR4Tj6q4vx2XJt0S4BPgjt3K3UpOjpZYEb83luE/AzkBItyiSMR/cxb91inh/E1bqEXPWJhklRjKBbWIxEhFFTmnMv+g77XaBFLp6D9hNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(26005)(1076003)(33656002)(36756003)(86362001)(38100700002)(8676002)(4326008)(4744005)(41300700001)(7416002)(8936002)(5660300002)(2616005)(6506007)(6512007)(66476007)(66946007)(316002)(66556008)(6916009)(478600001)(6486002)(2906002)(2304002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dj1DT6kWlSjz4pzIVcaZTv7bX8aoyqMDADeSg1uTcEXwEcw8ZWXDyrBI5VXa?=
 =?us-ascii?Q?qPu/BkKPQU0X7RWH9tuVTFzA8mBo7eNVxl+59b7BiFfIw/Q5OCeKCAE3Bttf?=
 =?us-ascii?Q?br9XJusAqvh1NQW592EBKbPwwA3oYUBIIiU+u2aGWAcGLXVlIeDu5YAXucXr?=
 =?us-ascii?Q?kXCPDz2cO9qdMaWFojMh7ph6ZEbLNUyXMR4YthMn8MpsXLbSc0dm6X4iiuBP?=
 =?us-ascii?Q?/iNXfPp6q/0M1oNNGbhpvpMG5BrOamgQVxMcYOD/SRACVmBr/Kp6MyiMCfd0?=
 =?us-ascii?Q?wpxT7lzPcRbUoRTOuCxmiHbVyE8zuoAe9zz5VfUZMeZJWyFK318eoBn5aWAG?=
 =?us-ascii?Q?Ts26c4m+/W1RxlADLu5UEath0qdzMZYRnYidJJEHLlJxwL5t2MY/dYPamb8b?=
 =?us-ascii?Q?bUzF61SHuWRzlG7PQLYJloLTjKT7PRdNpT7oAooKAXGNmcRnWjZNP3Jsqr4x?=
 =?us-ascii?Q?Sd7wl0FolsuZJ23rb/tkHChY4RWVhGTTtQScihItEgn+/ipOtjoBCqMxc4K+?=
 =?us-ascii?Q?4DF4Cpz+fE+3oXvssMjKiNPjD77FXy1Y7usFgHMQKBMb+DOsjhaPcc92ja+8?=
 =?us-ascii?Q?87/Mz359088n5bvJtA7BxHUOpOWTk3O3ueK7hX2WEU8CXO/1H1gge3m8+MKJ?=
 =?us-ascii?Q?nIN0J8QhfJ1fFX3/smI2x5qOsgRboW7V89Q8jpzhRLq/f92mp5wVb6ZzlAt2?=
 =?us-ascii?Q?okgAn617S1A3olJ8fq9Q2Fohwy/QuCMrWqiI0lrE6WLvIUDnWueE8CdVqCD2?=
 =?us-ascii?Q?K9DmmAfP8thcxBM55dJzRF65ijssnMA4qPdCONFNXaSoO63rrgkTpUvDV65G?=
 =?us-ascii?Q?8YfIlbEwUdu8jA34E9vmV7aTAw+gQK0T1u9b6tusawqO1efzsaehU89u6wGy?=
 =?us-ascii?Q?YwpHktvNVMP2eW2DaG7K+EpBcEyLEz3rPnU6BvD21yIFEzMhMU4/vp7emufw?=
 =?us-ascii?Q?pgcBTF3ofi5GJSnOLlH2f6wrjXOVSHBHrKjxXUMGBuPq8J5e9P5lS0JO9LRL?=
 =?us-ascii?Q?9XqqDqbF2/pzQZ9eeBE6dlbpyu8B/QVnsb3n7YN+8f46pKgfNBWnO7ZXhh2l?=
 =?us-ascii?Q?8SedaMb3ar3izXKq8GsJ9cs7ROcS7xJqyOdyuMQjPmNfHduDNAil+Hyi8kCz?=
 =?us-ascii?Q?Ae84XfIWJzY1bC2gbavo6ncC4er+ZXDyeCzMHhPIJ9EcfCj9dhMiEYqmosXm?=
 =?us-ascii?Q?G8J9phzbAau4tyPE9Q/LVNaLtcUFWixY73o5QKp/xE4kgJ51X3MwsrYpQk9Z?=
 =?us-ascii?Q?WfLFXjOkcb2giCoiLK4HKPcy2HzWovpWKi+MXZw66cA9ROvLIJGH2YGjC2tm?=
 =?us-ascii?Q?JoaN//hb8OdGAofSVJo9cGOUPkWhsihHcaHp3hLX1bIqnjuZaPODMDWCIptm?=
 =?us-ascii?Q?Gyx2L4KwXfT7xKoFjec9QSWqQu5aqaNOZ+FYErv40bFtWb0ETkk8UF0L4li0?=
 =?us-ascii?Q?1KPGDxgKVFhfzmXjNJsKIFjEU56NNxKD9Q2zs0zpm/8oJlS3PtFCf5BzDjqJ?=
 =?us-ascii?Q?zyMVTa9fEOENl2CmxYCO8nigWd5hrtejadbJGmX1vcvsWp823NHOKXsgm8La?=
 =?us-ascii?Q?GE1QzVGHaVD4dPatpe0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa461738-ed0f-4a01-0336-08dc0bc2d693
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 18:44:23.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z94V1Tht54g9MrOUXZFey1OuECFS1lqEQYPfDy2KrulGo11dVOl8ifWkzfv1Xych
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

On Tue, Jan 02, 2024 at 06:38:34AM -0800, Yi Liu wrote:

> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
> +				     unsigned long npages, bool ih, u32 *error)
> +{
> +	struct iommu_domain_info *info;
> +	unsigned long i;
> +	unsigned mask;
> +	u32 fault;
> +
> +	xa_for_each(&domain->iommu_array, i, info)
> +		qi_flush_piotlb(info->iommu,
> +				domain_id_iommu(domain, info->iommu),
> +				IOMMU_NO_PASID, addr, npages, ih, NULL);

This locking on the xarray is messed up throughout the driver. There
could be a concurrent detach at this point which will free info and
UAF this.

This seems to be systemic issue, so I'm going to ignore it here, but
please make a series to fix it completely.

xarray is probably a bad data structure to manage attachment, a linked
list is going to use less memory in most cases and you need a mutex
lock anyhow.

Jason

