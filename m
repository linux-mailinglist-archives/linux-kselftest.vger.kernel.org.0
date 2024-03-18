Return-Path: <linux-kselftest+bounces-6392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2BB87EE05
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 17:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FEA281D44
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8754BCB;
	Mon, 18 Mar 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Om1KTh9r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26154BC4;
	Mon, 18 Mar 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780773; cv=fail; b=Icr62kgpvwDf8GXKEWnGYOup/JM74brHkvZPrGE8OqPKWeg/ctGDL+knLVz/eCiVZ5wgrBaVcoxjURORThUqRA30ElUpRQJOyFVc+qU16OemX1piTPyz0TPqHjJnpjDl0yXgmYzjcLS+rOolq8rMrdd7Jhdu7jv9ovRxpT47nz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780773; c=relaxed/simple;
	bh=hu4kaamYARxpag8T9MTVyXGBogmVdUbQ0hFsnhYppzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U9EpWWpS3BMKiKEKwSFojllFWC2OtXlvkXahtfvNxPJ9vGj8HDKgWzkmXswYSoNmUIrKP9j7z0QeZ0UkVs6qMux9zgrlwAkJ1KPaiBuC2SXDwfBWVexCFBUnpTFZ3UBEfQ2IySu6vNBm3zerWrPSzGjJRC8+PWE11VQqyZoPSKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Om1KTh9r; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzhlg/Qpu5DEaj+DPsTk+DDdw8769bbWvYxd1kdkxTyF7HF9Bc1M/t4BShx5xz3Y8qvs7OluAWctlfF4LFiJhgvhi8G6p0lNZWUBMwGdjYrgmf9Tbb9cml2EtMjC9oKNnVG+8kdFVQZWlfrkWZi43uLXJARpcB+OfY9eO1/yuKXJPnev+8f58DPZe7LlSq7YRJsF7DMBc5o+q7S8knDExCSL52xi2LHSVyAm7LUagjE41KHLtzZysOqlfDTd7F13qSUqSsXs5GyatH9E+Cb+WldHIC866ZcdmT/6RJwp1nEvnp57M7ULvlSwaHzztdhjfVXkB1A9SNfnUdjB7JjEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu4kaamYARxpag8T9MTVyXGBogmVdUbQ0hFsnhYppzA=;
 b=XQMj+dDfHRTvZVP5lpNRwRvI9nsbQj1K13PDdtzgqUWzfO7FBOdIAh1oOmslRIcTr5m2mdMN8y/JDwMo0OXfzPdKW2fb91SSFSFIbXKXknxWiUCl2TE/MVCLJJwcrZ81IkcBRY1Y47qKD/uKnjuFrekJLnl9KO7t3FGOukC7rsb4RMzmd4V78udRXGnOit6YfRjTk9mM3YZmLsQJXsvegUBGbnad99Q1p9n7ac7nFhMNTr3vGVfI6xMX3vl0xdgnFg0BseYmdRJeGm4zP34eaiptpJs3kO+9UvBrsUV1Wjy5/KGowG/iavFtN+aP8dBaRXu9YJswNs7jOPLq67FrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu4kaamYARxpag8T9MTVyXGBogmVdUbQ0hFsnhYppzA=;
 b=Om1KTh9rOITYi66q5UgSUIwGF7LIbdYhiHH/d7WUpTf2VGcnCvsNqhWU4Vp2vKo6pO8msIdiYi0xHqaY1xjei7yoDC1RoMrZ2zq8K6vflCEyiMOb1xnj8l6q40X0rdUtcVpz8WXLOTMU6h4KSmkSQg7IN43kA08kBzUj/oGt7lfiF/0CdyU1POpxe7UqhmCE9R+czgdIg4p+yJF1A+gFsQRkOO7M/2RBxnpT2liUzjwFU81ICuo5zo9/9Mv/7v3dK6VJG6h9TeQvXit7IqG+s2GnKrqzivSK24yrEPa+jr1ZBw/YIwc6SGPBq2AIOaU31rHLekGd1GGVYHmZrfFBUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:52:49 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:52:49 +0000
Date: Mon, 18 Mar 2024 13:52:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Message-ID: <20240318165247.GD5825@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
 <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
X-ClientProxiedBy: SA9PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:6e::10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf7d8d9-f7d3-4a3d-5ca1-08dc476bd806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e137eC/KURWKfYfMNY8jlcdP30HXzg/9Akpm3PNtzjmqCwyBv3s4+cADxSv1qzCN9sde0WzmSzYEnTA4H5FIDylCohWqNpUbO2EMg0G1ZA3SVjkEDrK45p9K4Qvbz2HFxWKb/G95qosglvLr7KEOqF3aOa9aefd7l1LGR4IDn78AM8oo8WPiM17CoAvTwtp3oKVjhqvSJW3ZJzouYkPx/Dle89QzTrxr7IjwftFag1AuPgPQt04o3oud3osmlbhL61jI7PharnCbY2xADve3uFSrrwfWbWqJhCp+cjBkYJ2nvBuujoCBgV0nKKsKtHcRF0RWIVYnFMpld0WfrwixX6i0M2DNF49gbZbEXNqRCBtg1NawC5ufeQeaGOIkwGegziz2hKrEvm4eknjbahnI3UyOk+x57qOnafBoeLjw1uHuEyqQq2dApQ4b37lycsm1IpuD1QcpG0b0r93R7DB/B8fpk5eq3wKSLD0VQrPGVnk1eUCWa3UsAJsrkv18f3LoMviOR+bONJwE/wL4RwRyh16iSrJakw+0Ltn6wqjKOS6+nOMhye8n8cXesvZ+UT9BHTgm9XGSi4uSKght50XHGXXNhaLZQrnRpn2wFuI2AxuU9ZVap4Nt5WGtsMkh39ZeMax+IzAEh0hhfPjFdAsHKCnShm+X5l40qnx6MupkIw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gx2eKSpQVBLE7ZcFhg3eK87MKLmEzI1QqYXJz9/PbprV7uCyE6PdBw0dfp1V?=
 =?us-ascii?Q?Z4OSzz2SwK+PbirAJGqqJaxHXmgZuJ52xWo3iox3V7ubfjdspWgsUk4Fa4mo?=
 =?us-ascii?Q?treFl7wBrzRqnb7igBS4NJvBBtNFzdcrB4Si7Q3y3TmCGiM3+hPAS/jUg43C?=
 =?us-ascii?Q?lzTVb/aBH4y9oyKdIRkk1V3UrPv/NyJ/mWy86jYIFU2Loe2AM5qLxvNMF4KG?=
 =?us-ascii?Q?FIiU6XtmKRRkODyPdiS5rIymwu1wP3rKI42zCU4+k+7lOAvU+yOlpEorushU?=
 =?us-ascii?Q?x101URgQXJnGBeEHjejQavyu7Qz5wFnOr2VLOtsu5O/U3f/wJKzIqIF4tFHl?=
 =?us-ascii?Q?O3uXkgfp1yqTwSTyiIWpCNfNAXdJP5cHbFcxnTop64pXv5wRuvwG9te4Hz1Z?=
 =?us-ascii?Q?TzhBtLVpRz+A+bITcNB13UTB6HhFP0j7/+YGijucNRjXkd9crO+nIgX6hs/7?=
 =?us-ascii?Q?DN3+4vwXdD/7zT/9+9tCUeECMEaNVMZXb0kyEQrp7KP+7IPZ/BG41wYPkGdy?=
 =?us-ascii?Q?QMRly4yWNyIZIpn7KcrAL+f2qHz0BJ4Qxl6o+y5/uImdbkqDvaxbM8M8HBzW?=
 =?us-ascii?Q?M5I1ywcVwt67OKd3o+6LHqMa8TwucppLwaj7oegRRrASkg9n0diMORYqkLAp?=
 =?us-ascii?Q?hGEUjomkSYgOiVEwKoWxu1TYUeHMi6RONNLVqqAjAL2Qtezi9TGw1WZ1lIfZ?=
 =?us-ascii?Q?cNKIr94UWSxCPwGDVMJ9jJDwvlrXHzq+9P2Xhl/VLPmDOwAX9bBimVG/iEEh?=
 =?us-ascii?Q?CzRGd0Ftkrfxl7o3NU/zRGYB9UonvbKYbgDdYrKtwDIL8+Kjm2rA+k7h4adn?=
 =?us-ascii?Q?gP7dGT3HADYgXB+d8vy4IyCfc6IjdgX1IbQ3riBq0cvmCIzERD+j0s1fdhBJ?=
 =?us-ascii?Q?hA2AWXrEkjGRsTN+OtsslZ2OU6gXz3CfyWJvUMtyE9UTikIEExf6s2VFJElP?=
 =?us-ascii?Q?+GEukTcwkoWF4q3CdollasjfExDz/WP67wpdNfZQQUowxzcRrfOn6UtCofAa?=
 =?us-ascii?Q?sEGE8oPGRwLONbvU6PscVYcTnPzjr9LDzitpuuGDNHpK69vAZihdplvWK9RV?=
 =?us-ascii?Q?84OyChefbairpXq2iN93X+CaWQoBgBKpkYDFp214o62Z/sSWQlQORdHHbKHq?=
 =?us-ascii?Q?CZk9BKhQQo0tNozOxeNhukrsGH/KKSSupHJDNXR4PpmXFV82mxK3ZWtiwUb7?=
 =?us-ascii?Q?Ht+CWATCqGdOkBYO0pO78QTeKrlFmzMNvVaMP1bNd+OHgyouX2xk+DpyAVVn?=
 =?us-ascii?Q?v8o3UZFHnim+j7XSjig9dC2HMzf095ShSyYuDcx4EuQh2fwbGYhEsYOnKsXR?=
 =?us-ascii?Q?AEvRdCIz6iRIIycjtI3dXaDmbiJQcChcmLLCH+FXaLmf+1zPd487bZNacuDm?=
 =?us-ascii?Q?KD6TTSxpR/piwbDywu4K4A1eUrjORsazqc3QBtCs5IO0coAUKJm2CuL8hbmw?=
 =?us-ascii?Q?+mb6BoGC66saag7tCmbiD8t/wWj0fTjfXlkX6ZcIj1zLKS6qSdc0018HQw01?=
 =?us-ascii?Q?ts6BL4mgE00aI0/mmlsQyDf4Qab85Z9IOjwZl8+xDub3BqOXNUCCHqNsJ//K?=
 =?us-ascii?Q?rgsQHsGeNTQjd4iGsic=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf7d8d9-f7d3-4a3d-5ca1-08dc476bd806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:52:49.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QvpoKhpLVGMngN7qGUEaBK0XN0oW1ZVhQQuWECLBvnF0FzBrNGC/HL3C/+dVpcM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

On Wed, Mar 13, 2024 at 04:11:41PM +0800, Yi Liu wrote:

> yes. how about your opinion? @Jason. I noticed the set_dev_pasid callback
> and pasid_array update is under the group->lock, so update it should be
> fine to adjust the order to update pasid_array after set_dev_pasid returns.

Yes, it makes some sense

But, also I would like it very much if we just have the core pass in
the actual old domain as a an addition function argument.

I think we have some small mistakes in multi-device group error
unwinding for remove because the global xarray can't isn't actually
going to be correct in all scenarios.

Jason


