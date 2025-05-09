Return-Path: <linux-kselftest+bounces-32806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE8AB1FA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 00:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6B1BC7A95
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086426138F;
	Fri,  9 May 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nv5lGJAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37C2609D5;
	Fri,  9 May 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746828443; cv=fail; b=U9W7WyoMQZzPbafzIfakHiGP5/YgQzfALdeYmu93a7p99dENQQ3iiojn823tXqgWz2f403PYGFKuhG98J2a0C49sYZqekjVqBVMNo+wPiAvQWglkTDSJ4vtGYi9zz6R7WMCexitTod5SQWdrBeFHLe8SuiA4UeI61KjVHO0R6+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746828443; c=relaxed/simple;
	bh=nxWzk6N7ssG/0jKhchipP4nMzAxpQDl346ZaS455rcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5gyhOkofOBZyYhq/yM5DfYx2aJYi+4Ugu3wx1MR64u0GJu3G5DB0iHEbtSWelhWQj2NKoC2EXG4HLO4jfuXdOmtQKC6I6dmW16wmqUBIBNXSKCyx4i9v4RARKxx2yROATDUr/7Au9EhdO4hzY/3ie3CcuzhG/yaJKmsF3yqPSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nv5lGJAm; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AI/EXRQ1ViiIQczPi9AQui7dufKeFd5/AMa7ubs6wZ5p39vsXnLfIKNipXMIVm3GaeL+oSGeoL7HZXzdGiSzqAnuy/VPnSo/Px4H7NXYjbGiKODLGK42WzVJ+7863MElUZe7jsEYGApgMwC3f7XmHQlRf3TWz8//ZVJ255erUiVCUaO4ih12ZiDzKwlSSADzxIDcLcJns4PCOgn1L+f9x2/FhhgLWLM6pfK1Kcp0I+pI16x3ywN4InwocfhKjPe4NJWC9IePEvbZ0o4I7u1wp5KeUKonN0u0RUbWGo40U8xpc9mIyUIIcOQNCAVHAXcy3L0JeeJd41DbIXVTdt8wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcEKC+GmMt1sA92ZlUAbjlKWy2+velCNTcKXFTAOLKE=;
 b=P7jQAWIqA3IE2h1N71eCjWwVJ6bX9jUBnnVDpCU0AVdTgYNma4Rzb79npQFJuQtctJEyv/WMdQ0lZ35pGQawVTCn6g7Xfj0TPc3NIviRyAVgB0IWJRPfrPp9JwWZsXWZ6JvL1u2bwM29ePxNVnkSo+DJslceDPH5IfxY7+vgfrs04BHzdoSNRH08SNL58nzQp6l34zdo5WMn5mOvvwtipaMWOu9K5pAUuMApe+4d2IqscXQTEfGEx8XdAjYFujpE0xPvUe57oqJTQp1czBt0em3Nd3prGxBlm9ck971Vq13bMQC8EvRFTPf+9ul/K2tMzp+2XwRJqDwRcj9Es0130w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcEKC+GmMt1sA92ZlUAbjlKWy2+velCNTcKXFTAOLKE=;
 b=nv5lGJAmIB1/UK92WJscaqsXo+XJcHT3zhn1JwjWDKVia2bws1rO8lXlYnbvH77KkBchYXO6/D/OtFWA0RujhbvHa0M5PP6qmStvjYmeerIJbUIRHkB7oehsqAtgJAtpGFm4TNSlsn8D7/F4s/l9bsumKkBX8gM+YINUBFpozsMFmBcco8gHc4ZcZhFGQ75TJm+btbSkTzSAjDlMuF+okyyEpsvTwQZcouhIrHdj3Myfy+RuEFuQIyht7z62IFamf83p7b5cNEZhCQI7EpKQ9TwtTV5xItOtf6WyJ8Tgv/gk5+0XQly5uGkfLN9F5PQKOowvB1MtELsYfMtCY7NwIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 22:07:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 22:07:18 +0000
Date: Fri, 9 May 2025 19:07:17 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20250509220717.GE5657@nvidia.com>
References: <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
 <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com>
 <20250506125847.GA2260709@nvidia.com>
 <8e0182b9-7a8b-4388-9f22-c39bfbaf3df1@amd.com>
 <20250507122411.GA90261@nvidia.com>
 <76ac7908-45d7-4821-b34c-a5d2ee49c7d7@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ac7908-45d7-4821-b34c-a5d2ee49c7d7@amd.com>
X-ClientProxiedBy: MN0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:52f::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 668550c8-a283-411c-9869-08dd8f45dd23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVAm/sNcP4eKuOGdFEYmdUyytTpxb9/5KGUs69/3+X4GXuLmfLe6KrMXRIC/?=
 =?us-ascii?Q?O3+t50XbqoKswNqlQTv5ajIXriE9M+7vASAd5ivbAfugMloeOhUoO+WPcG8B?=
 =?us-ascii?Q?Y7jcBNvobxjCewhzNWlLtZN0Flo2mc+H0jHvb7zBCsbEV2Kt5hQRHpSk+Dpz?=
 =?us-ascii?Q?a/2v8d05H9onCWTGskGoJBtOg8STpogg5bK1ZuTTzDCtbD4JT1+v5p4LUoDT?=
 =?us-ascii?Q?SPnjmET9jhpdXHuzj7xCYn/jfEPKwE+bI/kiXq6ZUowoE0kqYT8geiWt5ozn?=
 =?us-ascii?Q?fk+EAyQxzmPLELZ33XiPO9uiIxXyP7Cy3TkVxFM6UlNNS/zMl1CKeSQqvFO7?=
 =?us-ascii?Q?anssAn5c7vY3OeV+R+HtNt9zDe+vtzPQrXgRQMCBul4PGoPmHhcsBIAc1vlP?=
 =?us-ascii?Q?dpJosSOevDXztxzcL1FLOuBFw9GEop7uGK4ftyNwNxSq4JoBD34M8Xa+iimf?=
 =?us-ascii?Q?16fQyQT741ukD6RW0YCzw7OeHjmyna0EJwtYBvxvv+u6mlweUBR1vpXZABQH?=
 =?us-ascii?Q?R8HBHzOQjj+WOEFNDYFrPTdSMAInmTmYWJUYedsJfjPuMGW6w0nUz1MBYkBt?=
 =?us-ascii?Q?F23X+2PpHjHGgeNz/5RRA7XzQkSNvKnzSkwynzNyVj/PSma9oY/a90KAjpuG?=
 =?us-ascii?Q?nJUYaB9S9jqflpsEN7IhrCzgxvmRWdYZ2Re9nCNx/Minq1W2vVyOPBYOWDKp?=
 =?us-ascii?Q?o8JkfyBIjJJi0yEmMKwnTDNtgPTtC/TFdg7dSFW8k/qCBWDZpOxUcBwPmw2k?=
 =?us-ascii?Q?oU/HwX6s6fpmSCcEanYOmS6pOITjcpQuOXHKi1USUC5jfo4pEwVjHqWjuE0g?=
 =?us-ascii?Q?MVwSkddWqJr5W144BRPGQhbefdQs9PWi8lhz29Yvgl/DlxRKCofgL6m7RaBW?=
 =?us-ascii?Q?M6vjTYnr0q/uWw4PSHcB0WDFlRwXx/FWnIsAprqcpCb0viC482cbczpXQXd1?=
 =?us-ascii?Q?Wa2MbptY0yV2QjkbFqDYno38HQdTP7/zsHfk1bpy+ZohRGWc7jKKkP9hVS4s?=
 =?us-ascii?Q?YIZHfnSHvnhev1JVGAkQfPo/rQ+zKt0bTV3yzHa21Vtce+IwCJ/3duqH6NGJ?=
 =?us-ascii?Q?JUtOi5jRh4mclZET1GmtIcJ7FMyi/fDUweeTpzXp9+58lY8O/Dw4MLjMkvwz?=
 =?us-ascii?Q?C9Q6y4J28WqPrY8wMEnaplovvl2O/K3u9gI02jc5hV9n7bxg8oWDkgty5Cs+?=
 =?us-ascii?Q?novBIH2P1tMK8aAO5mbtnqje0BqQGiQ/9RhLS6y3pFuZZkIgFmTxIDaJE0l8?=
 =?us-ascii?Q?HrWZz6C6bhmXwKryh9a22mf0XQaGq12QcdipCNG+3IyO6naRDogO94KL4ADo?=
 =?us-ascii?Q?Y6BCC954aeXKMemkD+E7f+AQXqvdaa7frsOAQICzEW1NnsXCmaoaYIO8wo26?=
 =?us-ascii?Q?eKDnMd1zlP7vgkk8V1MKZHSEPMqUeWRQ2Nzz7wjlkIt0vtvY1n+2vebY6cjX?=
 =?us-ascii?Q?Mijl+yyh4xE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F8Uc1cB2hkXbHQHCWdAOFefqU3S8CseE5CZGFYLLXHpe2TQ9crR0U13W9FKM?=
 =?us-ascii?Q?CMFz2l+kDoRoq4Rz9KgUu5gq9kGt6uPqStzLZdtpzRAr7nwhwZ+q0yA/1V14?=
 =?us-ascii?Q?ZGSyQUob/cA6dzxjtdW8GVDYa9fT6lRHQX1OXa1bLefdZS+jDhriUNGnSVGj?=
 =?us-ascii?Q?VjGieZ9QtqxzuWV4ig5pcR8wRYkYd6gL2u0yd9QGOhpQcDuo3xVOFFJiDpeT?=
 =?us-ascii?Q?xSezXaNVwe6xETvWth/wciirjmMnGyF3soxrZanJpVmqcVPSsE3CgAt3u9pv?=
 =?us-ascii?Q?CLEu1ltks7+zQW3G0xkouTFp1DbwjQkHy9jlRea571tOeMZ63224Vvs8a4WH?=
 =?us-ascii?Q?G6iz0adfVHf3zcH3DDU39LXPfd1T8paj882ZP/Lpgkmu3PNj+QyrNwRawonv?=
 =?us-ascii?Q?t0BnM4kSzW2MeXuCncHKhb2/cUbhR5ZbCrSDJbs7pFStLm+gFYzgTpxzx52x?=
 =?us-ascii?Q?fabdituDAFgk3msSX3Nhd5vVnc6fTDlmi3mjkw2iOicR+huvawuyKUsP74zX?=
 =?us-ascii?Q?O8QXgDx1L2fE9a5S5UsxFv6Wl9lTJuhN9lDV4QhCbL0zrWlwclmvVgJt/T3y?=
 =?us-ascii?Q?8gRrLKBHSCJCE1DN4fbpNBHoBiRoqfHMqOOpRxQjFu4rjYgAGvxMuVNR1L4B?=
 =?us-ascii?Q?WNezaMX0oDt6UCIFc9f3Esd2BGTDVSzV0sU0sJm1JHGaZrXboHoUdE2Fv7Yb?=
 =?us-ascii?Q?I55/kDWThEl3Lvzx/++oK7nqL7XrPDo7dxDC9T818H//TT0zXWNHovxhxsdC?=
 =?us-ascii?Q?Uw62gwpF7uKg/ug3p0vynix2EMGVGJFNFBgS9SZwuKPA6j1OxAESY5ae3Q/c?=
 =?us-ascii?Q?AcDHH1+tOZvZBJ6gpTIYo7Qe2BfpN73mwB6la/SFa0EmJ/Sh6aWuMXYYbrPE?=
 =?us-ascii?Q?wSd2em9PVJQwbJNHygKF5sMPRPp4HkD296HP1QGqfP4OQHTZ4178h5+2WYlv?=
 =?us-ascii?Q?lHkaw7Hs9geMBT/9PJ0MzhWXAqXYTDoUKWImskBYSw065+WF3MN1CgCYsVKr?=
 =?us-ascii?Q?Sighg/mKOpgdmI67TyLEyWxB2VL1OJtZxTMzo6d98HNdyuGL5XdIUH1bt1ZU?=
 =?us-ascii?Q?VJnBRJFMemUiSJCCOAcyp5u68FihpS40fe3WOJY0aPAhKwtiwXuJtGTN8GP6?=
 =?us-ascii?Q?/BYfN9BeO9s4H1CeplnTosz/ET1BPGIfsFiHVK4HBg8WsfCgte5dDiCDEAAd?=
 =?us-ascii?Q?3sxavvuMOFFsj19N90/SttlUqobq42fsiSNSf1tI+SHaOzPV3cAPHMpNLN2Y?=
 =?us-ascii?Q?xU59EX56ONgUxMJ90CaajXoXmAdvUCF0l7j7ZWYgyrK1+xyHOCDY8EfrVex7?=
 =?us-ascii?Q?XVzD0JLEyxRa44USdZgZirKzxw5v/PcXOmiFxIuXnarClxhDOP5vLP6Bus0E?=
 =?us-ascii?Q?R4p/rTA98cTb8HJLUlL5DO16GGPYKI8wFhOpn8bl35rcPNF6OmxFq8U0CRb3?=
 =?us-ascii?Q?9NizFFzlea0rEui+AjeKNBPCOn038SeTNQL1w5sVEL/gjTG4xJBhD7w4Ry4L?=
 =?us-ascii?Q?QgVtNbgMYRzto1zzIAZdrLcTa+kyWJpzcnixy8/t+wQDdtScB+dgKI7AL5OQ?=
 =?us-ascii?Q?jfbWriZYs9kBU6slsQELs0v9MXBcmzKWO2GvQFgE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668550c8-a283-411c-9869-08dd8f45dd23
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 22:07:18.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWUqNSHOEIurndicdl5zAlMUQT1B2N9MiJBRyEZngfhTtCz2S6D2dvpGKh4K/7VU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

On Fri, May 09, 2025 at 12:57:18PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 7/5/25 22:24, Jason Gunthorpe wrote:
> > On Wed, May 07, 2025 at 09:18:29PM +1000, Alexey Kardashevskiy wrote:
> > 
> > > > We should not destroy the vdevice for something like that. In a CC
> > > > case that would unplug it from the VM which is not right.
> > > 
> > > vdevice is not directly seen by the guest, is not it? The guest will
> > > see, for example, an "AMD IOMMU" and assume there is device table
> > > for all 64K devices, and so on, it is QEMU which will be
> > > reallocating vdevice in the host's IOMMUFD. Did I miss something
> > > here? Thanks,
> > 
> > I imagined the vdevice would trigger the CC call to create the vPCI
> > function in the guest attached to the secure iommu.
> 
> What is this vPCI going to look like inside the guest? There still
> be AMD IOMMU PCI function and passed through to-be-trusted PCI
> function.

However the VMM tells it to look using the arguments to the create
vdevice ioctl?

I don't understand the question?

Jason

