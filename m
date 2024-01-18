Return-Path: <linux-kselftest+bounces-3199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7F831AB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4677B2109D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A902555C;
	Thu, 18 Jan 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJtXqLfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03E224A0B;
	Thu, 18 Jan 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585146; cv=fail; b=ES3WAVL50lqPz0sUNPCfiVHlkKmYHjvBeHRgQAjqg9dCOh4aCJT1TMILG/FqdKjCL48UWxAbSP2+NTXzNlzZMiZ24bCIfo9V2Ekjsr/G5FBHYoT3TND0i2CqiI8l80IaXSo3o8QG6IVSQQybDxyO9UgZk5RUdDDvltcJuYesx5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585146; c=relaxed/simple;
	bh=gKBhwESUlvwISQPJEqAffvAIPKDwfZpjdnVffAE6evY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=tBmYEvqz1kS282gmQ1J3kwVva9ZKLj+JNCCZxzEaMqU6VciUqCyEeolL9dq6R9uOAqWWvqN2RY1D04fz4gWcC2OcP1tPG0Plq+2nNQOZkkwAWEcCP8D0if2eLowxdkSjUvHBLkqzYZypWN+Z+3rKwkJYzxyEIV9oV46zvWn1jYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJtXqLfG; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqJcQn2mQdO/BxubneKI2rHtrTSF2tyIRf7P7mHe4Q8oSlAkq8pj4D1r84y47vZb2/vhlzheGOsS3xygneQNfaR83yK8FZm72u1NvFFCpCqPQoSyvfUwxV7hbNEijd1YGRmrT1IZfbtz6N9GLYpeMGERNNHArEoCI68DeTR/LYA1jIhV5jN8VjSPFX5FdQOb0EPu9KC1U/lWyXvfXIfmruHBv21hua4HdeJryFiBIw/kGRlZaWh25Gfi7G6x7VRgxHNBtNRW+Z5nfDqSb0VaM+6LROrLr02M2gvADSHE2dk1dOgPxFXXxoQQJCMe65+bDHolH9EH7t9vg3r1v8Cklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwmONdVFu7N6vk8TQP9vS0tPUqnwvIPQ0EK9idtzBAE=;
 b=mAHDCNuaXQDDydjQ1qyU0YaKTbHcjwsIM2Pttg4f4+dvG1QVe5iS4jUvxuSwUr1kNCp3qR1rAd4WkyaAri+LyYjZXJzbUS8QNfIrJEUSTlEkKVk8Z4NQxnfHLrUHrhIPAfBHdZkhZ6u+QKl8CJwD4W4aVzcgNHMOHjYcjk6SOTYjtVdgJvptGx7bImm4/W5No7j+qyWbHYqwqz0M+PX7U9fuM0vLzFqunlcaY/n3tav/XebsJx1ZsFiyyPjf7okJaNr3JB1fn8lq6aD1j9xuNcNeqK9sGrs8EYkD3XPb+L97B7gaA1p2Th7l5CV0M3jpqoEPCsHaeXW0xCuT85CZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwmONdVFu7N6vk8TQP9vS0tPUqnwvIPQ0EK9idtzBAE=;
 b=LJtXqLfG64hO+aWpZvHy+msTylu1DePlW716AtwyZ8aBAe5Ov8aCzJPMG2GO7l4HFcNs8KzjzewC8FL+8CgF+6I3Fq3RjjcXu8ynWJ5fmsjh1ijM4R47qh2DruBTDjn93A3jgZgHSC7Umrp6hrDJujxaADGyWwJzG19EB55J/YlpofEyqr7rh1SbxEg5KXaDMSBY4My9WVwf0AOSQ6fxcR0LoftqBe51BvKuMlw3S+gFi0Pt/QULIM7fopSnF3syVCECQ3hkA24CFA3I1wumJUp+2TGpFPuRQO2Y2ZLLCcbI4h1chJ1vrm88Ixu0JmkIaTEbPPh4jLzDg3dKbM6jxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 13:38:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:38:59 +0000
Date: Thu, 18 Jan 2024 09:38:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Message-ID: <20240118133857.GK734935@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240116125756.GB734935@nvidia.com>
 <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
 <88e46f6c-4d64-4357-be2a-833797e6de15@intel.com>
 <20240117125625.GF734935@nvidia.com>
 <459d6a3a-0ad9-4980-be37-103211e927c2@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459d6a3a-0ad9-4980-be37-103211e927c2@intel.com>
X-ClientProxiedBy: SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a89a60-47a2-46b3-7dea-08dc182ad337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g20uboAKcV+PKdIfzws/0bKm4iIJEtqBL6euzy6uIev40oJ93bAv/AJCYQBL+S7JqSLS9VWhHHt5OaOmTIfB1y2E6LvsE+imOiyonNqOz2AwSGG3LnvRIMATs3wWGV7fgQ4wXNCvJ3D2ceLs+eKwPR3bNSnr61NbfWkVs1zimtEMA9WdPH4OL6qSiFh/Bhw66DIyrc8JEmJy8VGtk3wxLrBFDTyQ4FJLUUvsEiemte0f4H5Da241FlXRAiDW1e4CQkh3g7qX4+JWx/MQM64iP/9kDYBuNNBKMWdGRIlJgAX2mKt13wYosXX8XbR+EJ8/BApIUp3AkJhj8OGo+fMI0AD1aIZJcvP4XgUUW9TlDlkTevloil1955LLF5PQYkGYnFWIt0D830dha5+TgHMrg1O0LL4MwhH6uVP/IJEEXeTC8DLmh1gRPcU39h/B5T+rIw25DVdUQ5fr0nH/kkzvu82DRXHFYs9DYMgBqxJ9ShOR0BqUG5ZEfGg1IWlkt+qaKgIfnFjse3vRaqNuRR69ALIzfe3WYIpg6yRCe40n6C6Bn6iqg3peS/hgTBTUyxEFU0d8r7EAbqob59gp4unOyFSvI6QQubEWaZgZAijohy7gmEwa8Pi0Aj3XPtV3uBJA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(36756003)(86362001)(2616005)(1076003)(83380400001)(26005)(54906003)(6486002)(66476007)(66946007)(8936002)(478600001)(6512007)(6506007)(53546011)(316002)(66556008)(8676002)(6916009)(33656002)(2906002)(5660300002)(7416002)(4326008)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0+sbh6bRhFXqlOWvZh0LDHFK1o2HEyH+X7jDy7zN5rlZURnB8j/E684fccz?=
 =?us-ascii?Q?AlQv0y9m58XjSIDu9G9W3L6bAA8oS7uddM5R9ffyJ3jIXV3owtLIl2s57DT2?=
 =?us-ascii?Q?2jpylfnk2p+8te5pApmVz4KzgIwnB3JvroNPR+ojR8zuP3RBnB18urpy0V1N?=
 =?us-ascii?Q?4Gl8CgDBRpKKAGgYCcz22xDvnhTKswBDSMbIB97wgwD2eyM+QEo9z1oM1weV?=
 =?us-ascii?Q?gQ7vlm7jBxGqkK7ClAwPqKsb1v2XICdVOF39AvaiGb7qR7vljlsq7TcAhv4I?=
 =?us-ascii?Q?o5vDo5cAu7bYg19DiBlN5RIuCSUjD73I9w0pzZvkS9bkcAHuEiisYIz4AJKb?=
 =?us-ascii?Q?kVwTZGNDnGKXiGwMvdspgE3L3v93s5ubRmBC9bKxha9eRIHT2v8TsPH1qco/?=
 =?us-ascii?Q?PolKovq+cvsnancmehaC16nJIctbFSI/Y9dCp9TxFkRDszXwYwSQqA0GftI0?=
 =?us-ascii?Q?EN/UbM/5zuOfQmmde6wRlUVbuXFmI0fbLud2Rh/WuRcFYBsxa+YuG/YINNG9?=
 =?us-ascii?Q?CzBygWpErbU4IjjwmLCVpO81/nn156rfc70SJCl98ApXWCwFKwGr9A30eLir?=
 =?us-ascii?Q?Rq4dCnQT0IjWes/gQCX4K6PREmG8HJaevVnzgClneXos41CIjTfHOSq/bFQS?=
 =?us-ascii?Q?8q0LiPu8FwK2TSbhps6P4iKqlq45LqujDhI021qylIn/unGGcQ1NBObrIeUI?=
 =?us-ascii?Q?RigyphcPPYw/fDYa+BuWLXYHlDzmtUJ+3GZZnOQa+ODmHl4NsMKvSKVtrBR6?=
 =?us-ascii?Q?9orLG9jToqmGInRDFfjGDwuCdmWrVqLHUoHUg+Wf07YeUd4u2VssJ2r0mSXI?=
 =?us-ascii?Q?gMMAkGGtOttWL83S9Tzf+tw+worqAe/OtLxHkVNyAV2aJ4sI3jnDFNIk9vFX?=
 =?us-ascii?Q?IoIEa98jRDxF7XB5rch8a/nKkzjgrAPyZfw0QL7eiAgaFoCb88P78ZHpsI8L?=
 =?us-ascii?Q?gclV5nos3afkDZPl5WYowUv7k7+kkDRj5G00CtV4w0Brps8x2ajFelT9VRD/?=
 =?us-ascii?Q?AA5BO8jd0Gtfvvb7GUqoabIJ0//XNAf2yiJlGO6oQqcjJinrvbBOp5nYEq/M?=
 =?us-ascii?Q?q9oD/Z3BrBSwq3pi3V67TdpxAivofTtuDVvUcvwBks2VZGYqJ1kLdpHknq6c?=
 =?us-ascii?Q?UJCRFXTQw6j2BH6PUHjD0rJqPSisyPCk68XMT+2ft8K44eCehULVm3v/gvV9?=
 =?us-ascii?Q?8r2qAeM3rlOv3K03M0EcHYxxUXAHxD8eonsYeGhuwZSJWaDuaV2hratsMxsn?=
 =?us-ascii?Q?G5j1XZ5Cyx367a6ktOhV2hVSMDlVw0zFLn+C+2JjcjM5Bz2BfSmaGncNbvhn?=
 =?us-ascii?Q?fibKCzt/rXAnrcMKqIpHMlLh0I24vCUqCaSjbAmgUthAU3g3+myyG3kSoLY7?=
 =?us-ascii?Q?ddEwQIKoOdN/YsFuHmIiRY3BiBWylylXZbNbQxBBVHfB24wVG61/bHaSKI4A?=
 =?us-ascii?Q?ahllO4PLJs4RNpHayLyWLCag8RxngbTJdzqIkK9DHrAptabgtdhN+2TCcGcI?=
 =?us-ascii?Q?ElaKtnIRcIFgb0xDugOfsLbwOWlp8BONV5Nqwjw1UHhzKp5Wmzcas4xqqg51?=
 =?us-ascii?Q?XNQHnlOEkQ8CpK/eMZM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a89a60-47a2-46b3-7dea-08dc182ad337
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:38:59.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4cFMC4kOvlsnw3/UHHioj1Atsq8oRgtb4+8toLs3TaEsx1E+Ut5sg1Yoh3BurX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062

On Thu, Jan 18, 2024 at 05:28:01PM +0800, Yi Liu wrote:
> On 2024/1/17 20:56, Jason Gunthorpe wrote:
> > On Wed, Jan 17, 2024 at 04:24:24PM +0800, Yi Liu wrote:
> > > Above indeed makes more sense if there can be concurrent attach/replace/detach
> > > on a single pasid. Just have one doubt should we add lock to protect the
> > > whole attach/replace/detach paths. In the attach/replace path[1] [2], the
> > > xarray entry is verified firstly, and then updated after returning from
> > > iommu attach/replace API. It is uneasy to protect the xarray operations only
> > > with xa_lock as a detach path can acquire xa_lock right after attach/replace
> > > path checks the xarray. To avoid it, may need a mutex to protect the whole
> > > attach/replace/detach path to avoid race. Or maybe the attach/replace path
> > > should mark the corresponding entry as a special state that can block the
> > > other path like detach until the attach/replace path update the final hwpt to
> > > the xarray. Is there such state in xarray?
> > 
> > If the caller is not allowed to make concurrent attaches/detaches to
> > the same pasid then you can document that in a comment,
> 
> yes. I can document it. Otherwise, we may need a mutex for pasid to allow
> concurrent attaches/detaches.
> 
> > but it is
> > still better to use xarray in a self-consistent way.
> 
> sure. I'll try. At least in the detach path, xarray should be what you've
> suggested in prior email. Currently in the attach path, the logic is as
> below. Perhaps I can skip the check on old_hwpt since
> iommu_attach_device_pasid() should fail if there is an existing domain
> attached on the pasid. Then the xarray should be more consistent. what
> about your opinion?
> 
> 	old_hwpt = xa_load(&idev->pasid_hwpts, pasid);
> 	if (old_hwpt) {
> 		/* Attach does not allow overwrite */
> 		if (old_hwpt == hwpt)
> 			return NULL;
> 		else
> 			return ERR_PTR(-EINVAL);
> 	}
> 
> 	rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid);
> 	if (rc)
> 		return ERR_PTR(rc);
> 
> 	refcount_inc(&hwpt->obj.users);
> 	xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);

Use xa_cmpxchg()

Jason

