Return-Path: <linux-kselftest+bounces-20257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C59A6806
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C525E1C219EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1C1F470D;
	Mon, 21 Oct 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AG+bn5DC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85E1F12FF;
	Mon, 21 Oct 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513191; cv=fail; b=nw2f4Ek0hmlzgnAAvWdz7oCbgqHKWS5KbfYAhtQLURI9EJjpxTnJt7HSP/Sj0d5fLu+yEeW1qbE7cAlPkV+I50DcLb8nZmMNUd72lQv/0H4IYuWeqaaUAUMyzsUEwyMib5T5mz3uj9PH2PDNBPGOQLdu0MDa9HoIFVk7T3ww518=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513191; c=relaxed/simple;
	bh=jzC75Y/5pwyhW9c+oG0kvZ84Oz5YAYTz6NAo9hT8dy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRbggokktAvD4o99urGD1Zrz4g07xlj2IXyAP33j8r3I2u/SH9ZhPJ8rmFTY/zsj055QbTtopmuSt/Oxa4Thb9dlnAZEMEMtjOvdK6eR0r9nEIbtpg88uG7TlBjqdfCgnRy6Ud3wdgFaJcLPsnilQsZ8iTdMhr+c8WI1x/y7SmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AG+bn5DC; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy5aLdcGNVkJYOmLHmXxlpfxg8LEm9Yd2vf9Z+dYzh/91CkJQI5K1f9D5HzE9jjnRr+PDWrKSPCuQl9jqKFHz3VbvOQ0N1hTKEW3Id0XZ2WQPUKSSw5v/2+fF/eSesgaNup8+Q0d/3m27c3BkqR+i3Gl+umiaYhKoGjDIRnIp+/PplHENIAW66duISmwujmMxmDssKUDkoIa0MyDXdnG5+o1TQIq1ogBhJGhZ/XZx0+R6Ulm1xUn+7A1v9u/gRoxszNZte/XWdqmL4ntdMy2dJpi6my5tHa8dInHh9kucTb3pOGkO/P4TOE+HOVCel97Yiqq4H5eZ5vZOIoIa2RPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdjrtzGLgZdk4EwLCel+pbj0Hx5uPBJSPrxHKjnpFQU=;
 b=WsdMliSeGRM3fdDanzLPizRBqDt5E2owqAuZSvW9kYOm9rC0glNf+8FIODh5TivxATrsrby3HIvjFwry3evftEbKLSCQGV0NYvrUCQw0FxT0NQyEkf/xHgTnN81lXnwYwrxtzoj978KEupTj6NKS3bRJa8Hb+mOhVTCgdmTfNSwSaFk0wAAMamsAnKPZZNR1pPm1mNUs5wqf36WDu9gLywiRT+Rd3HIdRcHhUXOlptqY7xD2Tob01Z+3cAqQdf1SMXD9gWPPvv9FdsUKVo3URTJtzM4tSfIyssI1DQAlKt4rauym5qL4keNdumvY5J3NoDWFwRq0NpAMbBZohWGJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdjrtzGLgZdk4EwLCel+pbj0Hx5uPBJSPrxHKjnpFQU=;
 b=AG+bn5DCdU5OdQdVMryRKLJezXDQO75ooBJHqz3TTD3v63vrCtQatkLYLTQvcL6BlXeNgrYEJauH1m0YGAQfOBOdq0fL/4SRHKvNSLBrHd9HKSumVCNbsZbPmKKH4F1TJZYF4HBMEr4Fj0FJ+0OSdiYjazVqCt/KNtZWdqB7SEszrxyu0sax/LnmNP2G/a9uOnZiXdQwMrqa5IynurvPWZQPexHe9D7u9cTmKDkt/LObps3sUlM9fiiZZbigAMLPRwFGQdXzpFemn67y7bHfGIgcXVeqLEWI6ULtrfCV3iKJG1eSe1SD3zi8wpuc8ae5++73j0vBkouvtbY8N9DDyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 12:19:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:19:45 +0000
Date: Mon, 21 Oct 2024 09:19:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20241021121944.GO3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
 <6ac9e666-75c3-4cc3-beed-03295368294c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac9e666-75c3-4cc3-beed-03295368294c@amd.com>
X-ClientProxiedBy: BN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:408:e6::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 198fffee-67a0-4446-0ce3-08dcf1caa648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W00DtiPv670q91EF+/JzyvbhTqjVpX/b6oqoUBpszkxK9A2siR1aag6M5nNk?=
 =?us-ascii?Q?cd1Hj3hsch0OlVoGjtqIKhhdivXBoJyBn4aitN6PhpwtLDW9mLwb0au9WwGL?=
 =?us-ascii?Q?5VPjA32rQ5FtIYD2mdJqyt5w2r4HWTSoiBkscoL/vx8wvXQGpRPVTVYvm5q7?=
 =?us-ascii?Q?/HxKDNOOlAn14KqyxT3NUSsITC/bZL0W20O8WKaWT/OTIq5j/gGSGVaCfh1Z?=
 =?us-ascii?Q?/MwR8CoR0m0N9i2LgeatZe0LMaEDH6nJ8kMcD+OdWjquS9GB7lclwb8xI2dS?=
 =?us-ascii?Q?YihU2456saJtFiVvlehTWRT1V4eZo4Xm+e5eR+2VtJz27e1Fk9/2KdiCzqfv?=
 =?us-ascii?Q?lufa8icM0V0IFFZlOYLhr1zosV71IdsvG/v8Wi62XhoFE9KycErQsfcJIobv?=
 =?us-ascii?Q?1s0iJtuJ1760BvnudH2PUkMEF/cK7Lhjh6aQ47JrkZJPUhQqXuh+wNOfZeVt?=
 =?us-ascii?Q?Wnswx1TH6FLiPFsrsjbveDht0uMNI/ic5MWFEbSi3oAjdY9gjNdR5LCWgcnq?=
 =?us-ascii?Q?kceUeYW02HhYcRANJCl/zAgEZUFljYBG13K4CM7kJTvgc8QoB3wtIIDUQjbL?=
 =?us-ascii?Q?8L1RyPIqLPFvkM2sy/1M7aYO1ADkMDE4gbQz8gHgQYdQ1xuX6TdQDkqNGac2?=
 =?us-ascii?Q?v61CYpTcHj6jHhi0AX2iEQ4vIqr07PXfjK1B1ivwZP547vL4wBjbTQVcWw65?=
 =?us-ascii?Q?gmxjMDnI4zPD1nq1u3Oi4FKiO9NV/1KDCWOsWQDzd4yl56X9d4BAe3rUpToN?=
 =?us-ascii?Q?XeuTI7F6wsLU5npNsunOy2uJJ/TSdqps6f6CVMnY1DScmVdUmiNiCapIzRFl?=
 =?us-ascii?Q?RoVzzlAdTJ+KeLh8KB6qsTjVj5APlqJ6y1ro87ZvpkRMgLSNblsh7/9Ofh+W?=
 =?us-ascii?Q?RVClVIrZWOvWWixFgpsFj4k/Wkm7w4ftZJVLaZTAmZysgKTpLUsy6QWRvxyS?=
 =?us-ascii?Q?SmqcM8DCOewqDciWN5KHMwp05y1wM7O3IVTSCvQjucgxj9d4GzJwgw79NWrL?=
 =?us-ascii?Q?Cqk2dytlVAnv9EuTNb8AURoYzY1EKq24/3yp8rxuvS5UA433eYDBugVpjxGO?=
 =?us-ascii?Q?+kr2VTL8pfANbFO78Msls6eMpro8yaAmPAbfHe0z+Ozz2Vy6w9knM6pjsE85?=
 =?us-ascii?Q?CyoSih66LCAwFYggGTS83JK31FAW8LpE2gNVlI7sQ29T/ZfTbAKQKxNhcqtX?=
 =?us-ascii?Q?5t2aGfAvXB87h19gByiw/Ytwn5teR4O5XDBWTJotw04jpqnR8afTmEXu3+o7?=
 =?us-ascii?Q?5TfmNP2KOQrJhRHZ83zLpB+DFb4mNxmBI6MMRQzUHg0OEAPRc6NelncPWwgx?=
 =?us-ascii?Q?iF9mq4E+HsG5/czSWOvftWtR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6ymwlQheFC4AWsII/ZmSRf0ZUr/pUsPph4LcBgoD+c8PXcV6gEcIzMH5O0v?=
 =?us-ascii?Q?9mBJZydp5Z+gbELttSbW3XJDxDFely9+ZhiiC+u4K2nqzpKInJBy+pp34vfR?=
 =?us-ascii?Q?fBa0dSXTLM8Zhy1TdQN9MvGcUF+WKjCl4lEnS1K1q+0/UIpWsWjeQDDABiMQ?=
 =?us-ascii?Q?N4KPYBWeBG0YoC4aia0mIohtDDQ2qfRgMBsu234Ph+ia6aV8vir1hIlImBLw?=
 =?us-ascii?Q?pZh/5sGLedHH1qcYC6YPAsY0hucua/CUBKcIjEplUBYHKxwmgEH9zFEOedmz?=
 =?us-ascii?Q?NDi/TRH7A93h2KPyreFEHZdYBwhBkWdYre7jbPUOuSBfD+M/cKHw/Vtl+zOd?=
 =?us-ascii?Q?suRlNJ1cpAxWB8gTPJdzI1NqQZ8zjgLTZEoXGZAmcv+52hTlC7FULge2K7Lk?=
 =?us-ascii?Q?DTLY0ZRWLT4Z9q5qqPNBHks+wuMzbQLBiSIspGQ5Q46V+hyhcmR9fWrVsXYR?=
 =?us-ascii?Q?Y8QS2WvbeREDGHLkxMAO/G823F7jXweBUUr0aJw0WefudPhIiacHYT1aaCiV?=
 =?us-ascii?Q?65dzmG9PapHBD7DX6hQjPCQYzjqJ0VzndI6F+bdSMMOl9ywyk59C3DkGJWLn?=
 =?us-ascii?Q?zGqM1eWG5mJUgKhK1elIKdGwBumUa2Gn+NnDqufD6uPPAI/dAxnq3xSXSShd?=
 =?us-ascii?Q?YcLOdB/fSMr6QIgzvkBbmLpZDPH1ky4QmxKlNpkUHH8CVoJo6oiYxLjcJ2oR?=
 =?us-ascii?Q?SS3rT9X5rOptrD5+Erjw2ygZJ5BUf/1h3seOS+tnCpsJU0qkCqp4tPyALzgn?=
 =?us-ascii?Q?B3twAQGJLBnL3I82tSkbbKpnqAyscpddZMVf2pYjkpBbutN2w/5pFlEkeTl2?=
 =?us-ascii?Q?14kcyqEaORoOcmMsU27pVEQQsrd7eEU7rMwGu43wr/Xtt36YIluC0i3GZzRf?=
 =?us-ascii?Q?K5yZNNf3F/DaQwfvNR4acqMOCrs/+eOVuAQ0I47L7OQMABu0VAnUKdVIpU5I?=
 =?us-ascii?Q?2G4DMls3LjGF6hr3R/hWJf90dt8YB3W4NSBiC6cxRJMg+gXPKViXjZ/k/cuf?=
 =?us-ascii?Q?Sqx7vsJzUQMbSQlBQbN5fQ5wcMwzO6HBp4uA1GDir8WtQivVZvwPcF9ljiOS?=
 =?us-ascii?Q?b3JHTRFXU4dUSdEAQ8wu1qqJy2c4h7R8JsuR+wfb7ecUDXEkX5Ca/1bdVPhz?=
 =?us-ascii?Q?zHDov8jXZpNWoEScpTY7mzteWLGLFKO+5dGM3/VkyV7wQBupX1ZZ6bTGjNuz?=
 =?us-ascii?Q?QpJF4QmA2DO1qem44JF8DHg7u4prfy47Mb0gu1DkPRKJ2rKBCgqi60TSVJFn?=
 =?us-ascii?Q?B9OZy/oCwcdFl16X+oIoKrrJY2ukJG+XErOWMd4TAPA/Jlte3o+KKWJCzdgY?=
 =?us-ascii?Q?R/y5rGEWDCj0QJEIWrGD7ALZ0xZq6T3J7is+3C2w2tsH7HyG8LsmHiEQmsFN?=
 =?us-ascii?Q?RfFkI2wbUdkHnmtcsWLFieid5uacWRUbj0iLf+SR3oNsu5ENmNlUrspUqgPF?=
 =?us-ascii?Q?1plPexeoGRbGaixtDyrJCcXql1UTMnmWxGcwYG3kArpDg1c7dmGYODMcEWsF?=
 =?us-ascii?Q?aaD3zO+0VvKdhYkdVw+iwRpYalR7Ule9k8t9jB023T2M6Ef0LTIBYhI4/xPY?=
 =?us-ascii?Q?ui7fLRq3aiMbqUarmsg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198fffee-67a0-4446-0ce3-08dcf1caa648
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 12:19:45.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3blUBTXuIfv3an/ySpe+EfqCoqvHBNYIT00aZDHCmdYTJcC4jjYsJ2+4QVhOCJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On Mon, Oct 21, 2024 at 07:11:47PM +1100, Alexey Kardashevskiy wrote:
> > +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> > +	if (IS_ERR(hwpt_paging)) {
> > +		rc = PTR_ERR(hwpt_paging);
> 
> 
> iommufd_get_hwpt_paging() is container_of() which does not test for the
> value and just does a simple math so the actual error value from
> iommufd_get_object() is ... lost?
> 
> Oh well, not really lost, as "obj" and "common.obj" seem to be forced to be
> at the beginning of iommufd object structs so container_of() is no-op or is
> not it?

Yes, it is just a type check, the revised code I suggested doesn't
rely on this. Jonathon remarked on the same for fwctl and we came up
with something different.

> If something needs to be guaranteed to stay alive, may be just call
> device_get(viommu->dev), with the comment above? Or it is some different
> refcounting which is missing? Thanks,

device_get is different, it just makes sure the struct device memory
is around, it doesn't prevent iommu unplug

Jason

