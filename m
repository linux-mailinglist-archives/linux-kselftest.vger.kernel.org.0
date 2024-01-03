Return-Path: <linux-kselftest+bounces-2621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B918231CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEFFB2325C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC951C287;
	Wed,  3 Jan 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbkZivnA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7111C284;
	Wed,  3 Jan 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+7Mq2TNnULWw/a0nw2ob5+AGD/DCluICwcn0HZ7TyR3hwOWmyW/DR6ucwwquFxsWqfD2E2Y3sbzgPkG2FW76UeRIJdenK0W2F+JCeO5CTh6gp6AuV1lU/UQNsgNmMIXKplyDl4FzZ4QakYDW1eFaI/dTK2ChaTKYu8kcOuTJ/IAnwgcv8DVvgOpNnZXia8Yq1IhWFxrUCduxTmlnZKyiqpCNejVEl2KahbX/N3GgSc24BEVNCcvFsQY1J5/ytBDcfRlngJeiqWCoZ04qtwoi18FcqWQFN1+6Bc5mOIfz1c9aXYNj6MmBbrC9WmdI+a/fCxEjHMKn5WraZ2o7pt6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iahUVfs7nqtXLaY2d7gyMDavVvIZJdGIhOyqYFA6R88=;
 b=fSzhoZ1wHyXGXgypPlP4/j8oUT1A2WE0/RVS9y2vHXL95CvvjsrVADy1Mgic8kTLeGA0MdVMpwYiiYqwPBWr3cnJhheispGf85q2lZplzjRRRYzOO8cszHjrq/alMWh/sBJEWQEoJdVVAU/3qCJyIV/t1FgVT6vKzSP+PQ0uqskv6DqH3AW884INI32930X4ZI9Rc4a4ct4Lp6+ixPjbROej0/zKJuTyocG4JoIOe2qBq4tO7HIOmnVAR4L5JA/Z/IKfI+f/xZOH1fbzlAT6bbIMmBYYj2kUKMuCC5kmSqIiKv3PHEZZaMS70nC+6GwHLgZ7XuClwA1p5688SUYWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iahUVfs7nqtXLaY2d7gyMDavVvIZJdGIhOyqYFA6R88=;
 b=fbkZivnAF3FJw+YCxowZ+pgdMvFExhNNyjF5z7EBVJ3xqkNhIatrHwUBeViLYyx9t0DgYMOOOz5kD9wsdWP0Dmu4MX7p/Q37y1jvb5UKnkjZl2NFIMHq2Jmdt5B/SSJzUhbHL7mv996tSQWod2J8PTF7fl6J1dOgdZx9p9mnanOgULfOlFqcW61595YUAIAUuCxyLGHas5pZjURlWh4MTAKAqdVdURET2OjdqGTZqfZt1kLa5Orw1nresks9MxYoXOS0Ylc4zySZnoaz5TBv6U3AsUS0miy+X5i4Xbi0uUvDmVf5wtZl6+GvBPpUi6Pu+NuK4SXEWrxb5u5+/7Cb3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 16:58:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 16:58:49 +0000
Date: Wed, 3 Jan 2024 12:58:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240103165848.GR50406@nvidia.com>
References: <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 56feeb23-eadd-4d04-d221-08dc0c7d41cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7g/6WzMXcromMsWOLiswSsuYYQjEbzMMMlmPESBFUwEt/jxz125wVOcbTZ6UQzTdZDWxuCRityr7bUPTne6yMtU/EZnm03n8rmZDKtiG3/OHtyq2DNF890/3F3ykM7adWWhl/Ocjj7cVDMqjJaP3iG7CK1DPg8WpFOd1G5j1d1lEel7C3xlxKJFLkTLOcMRoi6h7wd/EcdgvH3G7JU752YFH/TiD9zfm6AdGC350uTBRuxf87lOlu9F/YIfHTAceEDxpNA5+aDBpSE//m2YRpnhKlUtI1r4NTb/n23UQn17HoDCKXQ6LZyhtq9U/P6qsy/Tn9taQ6ACyOWLYZUsYwi68vgpD1LODQG/fDVINZ7SnD6O21xZrzRHwOzZo5n+AFV/a1L4EDoxyVpspbvDcjetDbBIc6ls08pIDeyo7LaeATfZ16rva2YWFRBsYAkp/G5A+KYDqq/Sd4tt3smcl63XuzBzQ1+vwDqDwYB5iW28/d9EvVnwdlO8nF4ao6CIH6jmqU7Y/icw1Ns1M+djgvuzMK19/io8iHr6mRePDN8D2pV/7s3wcGwN2amrfV6jn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(33656002)(36756003)(6506007)(66556008)(6512007)(66476007)(66946007)(6486002)(86362001)(38100700002)(2906002)(26005)(2616005)(83380400001)(1076003)(41300700001)(4744005)(478600001)(54906003)(5660300002)(6636002)(4326008)(37006003)(316002)(7416002)(6862004)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlFiXEHJhRDSZ1yZ40zBvj+WQ/ikjfHaBETXBg0bmkZr8FzQcEdAQWA6Q3CY?=
 =?us-ascii?Q?psEvWdSkMcs5VVfomC0Q8c/NbhIKuMhQYUDaoBKEvYAC/29C1etZIlvAn2MK?=
 =?us-ascii?Q?ocCh4FyF3sAYUV9Kr/HO03Gl23eqPhUxZoWcvgTGZc6zdQiS92dQENdQ+Ncy?=
 =?us-ascii?Q?4KI2/EJvxCx+aWMWYibJu+A6yaGgfqtiiZIlXFd6wRqFDrs4NKvQMNJZv1uM?=
 =?us-ascii?Q?utYmRxLpKuCL3wiKQSl2ngitzfD3OhoyJY5KLQmoOwA2JFZS1nUPMoiQ6pg+?=
 =?us-ascii?Q?ociXoJ2TMuWG5g4ZMefeQ6Qv5w6ThWgC6qHNOExqyEzoS0kCL9OR47aXccMw?=
 =?us-ascii?Q?2D5q8JFuJDKCVKvvS6nNtpr7HyRQ3RxhpCiqC6IVSik9AKWrBeLFnPXI5WvO?=
 =?us-ascii?Q?tnIwD0ahYzBnNMl931Uo+kQvnxfLe2EVP2NFaDF8fz5MMWs0gp/YEfESmeC3?=
 =?us-ascii?Q?LtM4WITHwVgRAqlvZHwE2+5Hk/UxgAMMHp1hvXHdGp47CqIFfZtjH/7D2wqt?=
 =?us-ascii?Q?EiJSif2GYOsb0Ib96PtE9EeAtDfJj0w6ryUcZoP6DRZZdgfwGIWuI1WYGM2D?=
 =?us-ascii?Q?d5LevYpHQZUEarS3uf6B9YhG+Nk49h6W9ULkBrrV78ZAh82Q9zNFnLc62Dle?=
 =?us-ascii?Q?wMpdbd7EAZU0Jv/+GoADw9izuGE/pGdsVI8wrmuamw1bOMiwLLpJDh4nxWzH?=
 =?us-ascii?Q?m9eSiAXq9xBS6o+veS99hHYTWYLJBoNG6po76k51SWNiqpiaw7MeMzC7Rf3t?=
 =?us-ascii?Q?X020sB1AAfKj4lebHpZ+vsY8TTg06iParEYANmKfkEnLVvuA9HBTKguIIvNH?=
 =?us-ascii?Q?9nqoFNkpn9AxMYlNK+7BD4jkJfP2DaQi08R3VRIQaHo/v+m/wO50WMrd3mc4?=
 =?us-ascii?Q?uqppZZJZ4hQTVPZVr8J4K9MZWMWW/mIFrdOXWtb3HIpDvM7zioLsXet2kAqj?=
 =?us-ascii?Q?PP17WzfsXzAqH+LeGYDJx0A1qwikJAnRQaUWle14SKeEgvYPmrLftMVRIBPE?=
 =?us-ascii?Q?aauqP4sAM8ASLqoWt/GtaS+cOC/CvGOVvgwARvKOxMH44zIR2JejGQ3QulXl?=
 =?us-ascii?Q?u1Hvk/2Z2Joeh/JNLKFSYzVoczKpmq9LVi+TfFCvAIyrLIoBKs7Q/0WcrOEG?=
 =?us-ascii?Q?fxIKgT3s/0QNw1DC3JePsVN6VYqyKS/qbwPMWgqhXimngLAn1GEbgPWJIF2v?=
 =?us-ascii?Q?2x9GaRxy2lqbGE+jr2eSznuXIRkasg7to7FgWTaeVl3bhH1WV5T5eWFMFSos?=
 =?us-ascii?Q?wzY72z6CIxTv2cirB8FgOpXzgeKx+Ok00hJdAD+56dv/MWwqTPNq51GTuCmj?=
 =?us-ascii?Q?/atGZJf9/h7Ulm430m5ZaLCovFLaAxgaBjukmKYvyxyg94jdqzRqlhwAM98K?=
 =?us-ascii?Q?0lEliTZc1EDkaq5MbWXZDLf4lG6Iywp4CV3dUxRCNnOu/oxGH9MuBmHQHXDC?=
 =?us-ascii?Q?v2tvmE1yrW0DX42K6kK1fm9qenEKGWFy4iiEAaMCCP/gz8SD832YI/jWaIm4?=
 =?us-ascii?Q?VG5M9YKlFe5vNnxq2Qt+FXzit6HcMtnqvm6/R6wSfrJl1O/7TlNYWWrwEJxl?=
 =?us-ascii?Q?jW3PDj5vUA7jukEivAe0Qq846OM9VTuvyNg9n/Tz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56feeb23-eadd-4d04-d221-08dc0c7d41cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:58:49.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzjB9SJ1au1ql5mlOwj8jUGvH0Vphpxxw62i9OARBz6CiKiTdIQViyb109hM0rPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489

On Wed, Jan 03, 2024 at 08:48:46AM -0800, Nicolin Chen wrote:
> > You can pass the ctx to the invalidate op, it is already implied
> > because the passed iommu_domain is linked to a single iommufd ctx.
> 
> The device virtual id lookup API needs something similar, yet it
> likely needs a viommu pointer (or its id) instead? As the table
> is attached to a viommu while an ictx can have multiple viommus,
> right?

Yes, when we get to an API for that it will have to be some op
'invalidate_viommu(..)' and it can get the necessary pointers.

The viommu object will have to be some driver object like the
iommu_domain.

Jason

