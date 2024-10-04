Return-Path: <linux-kselftest+bounces-19059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA4990F59
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007BA1C2288C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E311B4F2F;
	Fri,  4 Oct 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mr8WF9Vx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40A1B4F12;
	Fri,  4 Oct 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067827; cv=fail; b=ZtQebCXlbLZwr8XuogaKR31v17uS3S/zJxARUF+CLU09wa7d27M3C3P2008hb1XMxrVpdRqgwWmss8DLLNsvKNEm3F6kT/ya32iOXR7dB26RfT4gwMlVqc8PxZTi1UFMT7Smt2aF39ZMYpPHNCAB6pm7NyBGHOTbG5KIA1Bcv44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067827; c=relaxed/simple;
	bh=1SyTTg5DPMXgjqPx156yOOEwaHJ44ryu0k1NOs7A43A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W99CDb8oN5WHc1ZCioGkz/2fsz8vnYw4aAXjWdA22gZQLSF2Ph7vaRSPS301eTmxiUgc705TIXMbaHMN9R/FUP6csBgiUEEl3+DTuv3ptIm4iFczMa2uNUCYd7FDRN9IiMA55OSLIvK0oP2JqjcFMv2EDC52LgPiYfkYeKuOArc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mr8WF9Vx; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcSNahv41H/QuUtvGjOoXTvxVfl5KebfdtPIZ5qrvmDyGAnE5aWlJw7fGfSemR/xfzwPKFWcs1GbidHKC2F+yNJA93yIHbQjtGqpNA8RpAoXU8x8+iiy7GyWelI1b30wd3OkCyigKHMP3ORep31ghsJ0aZvazIJ/iwoyWNXU6Ayr/dBfF4O0UQ2f6IlyDwlAnfwi6g0sJqzj2P8stac7OujSK+/cGFev2pY9kDodiCN514H685GxVM7gOsCD4SEZIDrHoOtNMuZ9G1U8mmoNgT+EwmqoPIKpzzdhNDck9Do3nEGnNqd8CmoTE+4kjSyF+AGYQ59cccqEGtYEXKPW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ROC5D8GhhQMAXC9VI0ME8iIZv+OPlC30xMyskAAk2E=;
 b=pHBdUshyLBtMdKrFwhDLfL26DBUFE4m3U4Txr/KneecBNUYCgThHV6jcpoZ02UDoVcbs+9EWxRX+TsWDHE4712mQp6ixwD2im7j443o31vcs7azklsspzVCRXhgzORSmBi3kCMmppVUdYXhoUgNdj0vvl7FYfwDRGA1u7+HCcu4JyGiRXpgDXafy1TrGQbUvBIso3AUw+TWZgV03Qrw0m4uDtFgNdkM+M0b/371R++uhhPOPu/YPzpMDxM5mWaX+uXg82iUKA6sOUVwC8QJRFPn05y5vRHaEY5qY10OHVV/95RAsDp7epiXODy2jVdaX68qtZ+DuelqagdiiO9zmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ROC5D8GhhQMAXC9VI0ME8iIZv+OPlC30xMyskAAk2E=;
 b=mr8WF9Vx8zqIP9+BDJxdwj56EYRMS43FNDcfkOV2PEFyX9eF70jJkAwSHYMIAR9Zph9oERjHFRNgmW/aDhlg4UgFP6u9hj7UeEV4akiLFu71yFyPWG4oS5KIfqlnKSkj7+Rgw+ZainrwYTTWrVBHFRDivPkuIDLmkIKyGFQN8D5zPuI7i8YBlVeOeCRACtYUMGaqfvrHKSqYO/djSs/fXtiqNEY3Hvc0Ar/omOhlfb4ogLAuqOMi7JzqlgmPdDwMaCP1q+s8ekTPrZU65Rj3vcqPEbo3Z2dRdCUo3euauZ/CjA621cPKwmIsDw0v/8GfDa1QN3b6ggo6yu8Daqin3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:50:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:50:20 +0000
Date: Fri, 4 Oct 2024 15:50:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20241004185019.GJ1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:208:237::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: cb187749-45c4-4b6c-47f3-08dce4a56536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xn0Y4DmgnOzxcaR0c14hUzzSG15pDaFqcVvZximRUthhDZqiLUxKlHhw8Lkl?=
 =?us-ascii?Q?Bca/0DH2zFu1JfdiM0kY6PhbXZq4RCUhDSeroSDMpudvVbNBxvALnPxn4C5R?=
 =?us-ascii?Q?oFSPXltfIytrWQ5jg2iXEdD/So6NBV6FAu5zjBlOfqsrzQIcFT312aQRwLHa?=
 =?us-ascii?Q?mylXHZCyH7tJa87p289CrG9YkUC2Z+TsK7J8HTuweytbQo1GzMX++VfTae34?=
 =?us-ascii?Q?P1gOFgiTJeuFAgGwL+levlE0IHORO//pa0zeUMVNc6OOI2DcS7gV9RHWdy4+?=
 =?us-ascii?Q?A2euV+TxFYrgeAI/K7DEK7YGW854D4K/hAEdfGPo7p9+Ne95Nyx+oQXzQbTx?=
 =?us-ascii?Q?v1+BrCn/7NH/OEWphFvh4i4ZoucSj1J+XggRC1z52WfiruA63wJ2cT11+egV?=
 =?us-ascii?Q?uCO/MdZMo4qhYjsN/kYfMQSAlBNqq4pbh7WSq7nYWEmcWmUen4PH5szkS2ip?=
 =?us-ascii?Q?axbNz2wnXfpQ1Cn13LisL/uC011KnDfrOpow4ofGIN8BeYGLL4kILb/wCz2n?=
 =?us-ascii?Q?K5yAZaVENukSYy2nFvlM2lJFXfnf0P8a3vAGhEAPcpeOywzKLkZq+NsbCpMg?=
 =?us-ascii?Q?hB2DKVjP7SkHmv8NH1HuAZ5LTyRvYK8HoUiUXOb9h9+IjtHNfjr+tWwksR8M?=
 =?us-ascii?Q?LSzfQ8ZfSkt9iO5MtkCsh0IuTgAT/8jDq0s8LVW11YafKXMxKnraFuZYARZ3?=
 =?us-ascii?Q?6ba/AE3P7zCyeSuf1qp0lKhwqcz/lWIPiYGeZs9lRaKqo1W3VMQNSS80a8/1?=
 =?us-ascii?Q?l/MnCoX3yUh4ZMurhrwaA6dTw+79PGboa7Lu8KO1dp1MLrqsY3avfB0hqPrC?=
 =?us-ascii?Q?ODvF9CnyYwhP63UqwyqXPmlD3gdrTVLk4dJdLARSIZXYv3LrVjnq/UGl5g8d?=
 =?us-ascii?Q?veSTyGznh6tVY95/flRMHf0xlMDklvaXHlrnEe75y21IpEqG+WKxZ+jfUxdz?=
 =?us-ascii?Q?ZuTXpbQt3MI8iDdHTMzcyNUN+iX+4zN2bsbDowuIbYCHD7N7FcvV1PMqt6Hc?=
 =?us-ascii?Q?V7weO0sE/d6xZYDqXLlXwKHVxKaZkLia+kBfJ80jLyu1j67Ue18F0Iv8Rv6X?=
 =?us-ascii?Q?Mbk68mXvV/RimsbXTGBybRVRRfEDjhuKvuKV4w55w/MFpEHc2YEPkWsGB2xg?=
 =?us-ascii?Q?scVcymtDoCXn40tfXvAV0Elu9kYdPjkdCzLYB7/uWv49KK2I4fqIeuph9HjQ?=
 =?us-ascii?Q?PkmXDHm6OYYPGYmzAz9gHQmi9J9BZDR3EJx0/kBF2PeJd7184nzPhtX5jxhB?=
 =?us-ascii?Q?5OZlOovLADyWpxGqqfpuTOtZe20O2PImX8EW8bB38Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOwfmdT9dyYfohxb7ZGxeGmHkmoIXy2exIg2brI5X8zwwlHvae/pDEmQ0WRv?=
 =?us-ascii?Q?ODOhgyNittuEFSlxll6RvetGEEhh4gTeC0dbbzGRb1Ui0wQ+f2S/boWzi42K?=
 =?us-ascii?Q?diho74LyDva6TpV1Woe15qNapRqTdWrGOFBHG2BlR43krbS/vVT+JRtoA571?=
 =?us-ascii?Q?bgMfHGBt86o95uYXQZ8c+qAYeIB7Amw5XwU/JeO47xhQFrDS6LTbCExPCkXG?=
 =?us-ascii?Q?Pi7shulGu71RO33JL4PYPj4dywwHP/SLpRBJdsKDTpTmGMEHYhyz2rnTF8Qr?=
 =?us-ascii?Q?nnRMdLhiVX3YDhOl3hZHG/rP+TnsCWs3vm6R4+uHwOnZ0IUlEET/oglx4b2o?=
 =?us-ascii?Q?UjdZmjI6Q1C8RJ/G0vKj8jR5a+EXSvltqY/kx64o0GrvVPyMyP9Nlr/MiyqM?=
 =?us-ascii?Q?Sylugkt+SdPRqxKJ48JZVD8iEvwyzLLJboUdK1XyPPVLVRAdhOJWi6Y6JpRu?=
 =?us-ascii?Q?nUp0P7CRgkckgVPYIKTAntkisMSNypPMuo/vJ+i6ZO9wpQlrmFq5twWrhZIn?=
 =?us-ascii?Q?tn6UitwIJCVbDjC/LW4dFg1Fk3m6LXkXmOLuPTldfc+yxEUT+tDhLB6dBj8M?=
 =?us-ascii?Q?ghfJzK36AzGDc/hYXKTn582PE28ok6nFQYsicnzhPEvEYa/bViOEb5MpPGZ3?=
 =?us-ascii?Q?POiKAsri4o0/eRZrbT4qF23W+lXwj6pQtogPdBLr84xW5yaMXqxsUyDindAL?=
 =?us-ascii?Q?uHCWedFsWMtjC8YGnxCMYVSnJ/hnY+xn0sQ8k0D7a2rBPQcqIHjfKBUNXthT?=
 =?us-ascii?Q?c8ZVrPSQ6nUm918pJHnqyORTxPTTbI2Ky+GDxUbU2pZD8ZF28oQOZKca//T0?=
 =?us-ascii?Q?32+EySSPeQgT0/ZckRJNwX3v8S35TsBijK65MLJjDSzg6tkFVT5++8p9x1zM?=
 =?us-ascii?Q?F1QdbUFG/sKKUdJgaCniV3O2RJJPcmBGOr4eyftByGwJKOlYUr92hnjNLUMH?=
 =?us-ascii?Q?9QzxANqvnGMs5mTQ2yw6GLtoXdzaPNbcs6FM9Oi6VqdjV+LScIbzgNgEMnVk?=
 =?us-ascii?Q?ueLnmeGpKvSgT/H2yHY3x4PaFJZWSiGKMpE7hk+OvVwA3Z+BofWxioMWOLaN?=
 =?us-ascii?Q?gQts281VzU/AAJFPkKo1bMiPpOlm1vlglnSwprclbj3F/yoHgTb9Oldr/lPW?=
 =?us-ascii?Q?pb5Ijo0MMAA9lxQDQ/A+atf/+XfAL+ECDFIhXhsWsOHFChk0KG45uWeZ7zyV?=
 =?us-ascii?Q?5zTccEmqzLKvyJZaVYV0V1KG+5J7cYYZuak6YJCPI5gylUlwyXgokN4AHbYh?=
 =?us-ascii?Q?3ZhNtfSbisD4p7/moFXpGdjaNd1Ks+pzl8KRT0PNKekhsF1PZmLoPyhza6Nx?=
 =?us-ascii?Q?G64uTTDUWXYZja+UF7PTSwzLzFnn4ivdIYYuCj+u+4isiNM6BD4PsYxQfu+t?=
 =?us-ascii?Q?w7FGbItDuPjs3hqgt//ZF8ryL0WseCcdmddNe41QeSyhF26MoRMZcp8WCOtS?=
 =?us-ascii?Q?6KQheGM+J0n8MQxaQEawd3Z4Zhouc78hsJdRNWErvoAn3+zx1ObTL/8jbETA?=
 =?us-ascii?Q?vb5/ZrHLRBoTxG9ROnf9BjI1Ul/ggYSLRFnWqPF9a2j3BIBkQFsOhQqdLiFL?=
 =?us-ascii?Q?tkRiiwIX0e0/jApPdfQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb187749-45c4-4b6c-47f3-08dce4a56536
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:50:19.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt7rgVui5Aw4bMO0W2abS/ECXa23+l33LHlf7s9Kfqmf9a+fS+qWtSE9AApx3JNg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

On Fri, Oct 04, 2024 at 11:13:46AM -0700, Nicolin Chen wrote:
> On Fri, Oct 04, 2024 at 08:41:47AM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 04, 2024 at 02:32:28PM +1000, Alexey Kardashevskiy wrote:
> > > For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel interface
> > > to pass the guest's BDFs for a specific host device (which is passed
> > > through) and nothing in the kernel has any knowledge of it atm, is this the
> > > right place, or another ioctl() is needed here?
> > 
> > We probably need to add the vRID as well to this struct for that
> > reason.
> 
> "vRID"/"vBDF" doesn't sound very generic to me to put in this
> structure, though PCI devices are and very likely will be the
> only users of this Virtual Device for a while. Any good idea?

It isn't necessarily bad to have a pci field as long as we can
somehow understand when it is used.

> Also, I am wondering if the uAPI structure of Virtual Device
> should have a driver-specific data structure. And the vdev_id
> should be in the driver-specific struct. So, it could stay in
> corresponding naming, "Stream ID", "Device ID" or "Context ID"
> v.s. a generic "Virtual ID" in the top-level structure? Then,
> other info like CCA can be put in the driver-level structure
> of SMMU's.

I'd to avoid a iommu-driver specific structure here, but I fear we
will have a "lowervisor" (sigh) specific structure for the widely
varied CC/pkvm/etc world.

> Agreed. That also implies that a vRID is quite independent to
> the IOMMU right? So, I think that the reason of adding a vRID
> to the virtual deivce uAPI/structure should be IOMMU requiring
> it?

I would like to use this API to link in the CC/pkvm/etc world, and use
it to create not just the vIOMMU components but link up to the
"lowervisor" components as well, since it is all the same stuff
basically.

Jason

