Return-Path: <linux-kselftest+bounces-22130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659F9CFBBB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 01:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173EA285FF3
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9CF2F22;
	Sat, 16 Nov 2024 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvEUR1mI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E074A1A;
	Sat, 16 Nov 2024 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717291; cv=fail; b=Dca22XNqQOUVfd058ZlIQ4i+9bOlqHbCgU/IJVhYn/tpqVf0EcsgjM4Ad+uv5yU0dJgehXIz8Qdyb6GL37YApuMvRKtz0kwTVc9cB8Oed2GtpEs8fnmhaASjO75jGsTokDRabjr/7hMt4baauk/nZ7o9mqV0wi12IWaR2DGrul8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717291; c=relaxed/simple;
	bh=v/4KT7qb2V0SH7BFvDqmS297OlxUQ9dHsWUriQW6p9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeosKb3YwTFlTirHlnzX6kheUzMubnyY//YQfF6K2S6wmJ3zrOtqt92M+JgBukhzRodyB8TegYwk79aEnMvYRcAduFO5j0cxJKD4uxgNCzbCYjvRCjz0mjNVS5lyk09EYszjmJJrG6kYcaSqxDMlS0R6hwGKzdBEd2PIzMrlP8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CvEUR1mI; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdtDIfz+T9uTKYHyW2E0pwU+GGmOsLaeN1sV96fE7lWUak5pIJ5nyps4hd+LhDuR+EX5kLDq/EYX4u4mkje7/tfEjGZIbMYYzNW5E6Xzx6+pnSYIom7B1LMb+goFITmE4ffpNnZvQ8jV68VtdO8XukUsd7Ki3UunoPVka5y4n2h1yIc3uoEdtb5w7zuKmNoYddvip1jMUMeI8garX4bo42p8y2lPd8sijwSKe6UfOgM96/ys4+AJ4BiIp52BbsRfKEult5c5D/wyg1egFYkjB+1kkcf45IMeb0svkYWCo1NG8LkkmEnOlvIEMahnSfhdv5ms/Wz9plgS7k2osCjIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6PLva+zgpCMfgD2pZWa9BG5tEjmT+rQIaB2spTPo9Q=;
 b=GNTx47aMSZf3NFIKQLg3w3LgTXz5g2W/K/+aZVRoarUJLBvBoNSpnh39/v442T4A9lAdgpGiwfFMrwOpP400hlXxfxJm/TIEIgV/eXQ6zcMkgGtn8a4hBcQ2QupRAIJ7xsc48UDHajMZmRUkAbbHoU4ntrRE5sgNHFWCrjPBjTUvCwM/5lm2+fObdyAk0VVdVFVaZXeABzGwdbXJq6f8i4neg6pcDgN0yz3WgItk5LTBzPcSPqA5Rxa4fxGuZHbw4TOlES+9LgDp/0a5TeIs/WnNqlpzwQDcbeLlx/q7KutyfM73la9U3rcETrTaRwihVqXnUduhlThMLodEfeMMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6PLva+zgpCMfgD2pZWa9BG5tEjmT+rQIaB2spTPo9Q=;
 b=CvEUR1mIqPAOK1Y89Qg+rDNJAX/QBQ3tWlu+7EJpl5yZROwUuF/Grv6WDjotsrZWdl5leV/1P9wmXLVROPW0yWEjWRhbfvsqpUhOVCQUi9uXPkRWF5xm+HLVYiPrUDz/6u8W2TLnWbrs4SVUkE6Bw+52rTtQJBz6LSV2h2mcx8hzlgUcqGDmNFG51VZEFBy5WvM2XGFv8UB0xE9wV7aZKGnvIYN/Jh+r1afSV05yNC0LT2nawHpSwJDqRGAUbCGbwAc8oISRV6H721WlCQPzoTcgZk1D/JycD7kmT5+iKRGp68QxIAjNh3/eWK55k3abtcY5t+3Ntbr8O8CrFFET+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Sat, 16 Nov
 2024 00:34:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Sat, 16 Nov 2024
 00:34:44 +0000
Date: Fri, 15 Nov 2024 20:34:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, corbet@lwn.net,
	joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	aik@amd.com, zhangfei.gao@linaro.org, patches@lists.linux.dev
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <20241116003443.GB35230@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
 <ZzVB7Fun48rGztuV@Asurada-Nvidia>
 <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
 <ZzVsEmzc1UyDdi//@Asurada-Nvidia>
 <20241114162010.GP35230@nvidia.com>
 <ZzfGLdgykZ0M3jy5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzfGLdgykZ0M3jy5@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0537.namprd03.prod.outlook.com
 (2603:10b6:408:131::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e077bd-5589-4d5f-704c-08dd05d6777c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?en9hJERrMUWPu2M5wTSYbYi0NZIukMtBoV+WS3PJoXYCFVcyKHBS5+ui8m+g?=
 =?us-ascii?Q?xD6/2devJXmICIKu9xf30E35pC3edzyU0S8gsLZp63LgTrJDsFcC/Jj3ZScc?=
 =?us-ascii?Q?XSsh8DUwTqFGBpFac9beuCKdpUjVRH+HmjTAVk0KI7ewYsEDMuUEgcvmu9a+?=
 =?us-ascii?Q?JrjJF/1u4osqCF6NHhnbQSJUgwyHpCMvVKZj/vLPYI/EvuTXX3YUVPy2L1sm?=
 =?us-ascii?Q?oiZGRa9vY7qsb1I1sV+AKV9pjbMpQnN6Wg1+zlds74hAzJBOZ/abiUATKF/Q?=
 =?us-ascii?Q?mRRany443zIU+0aNWGxGFgVCxFk/wU0E2GvKpyAmkyJ8qb9xGpiZ/ZkhrsSn?=
 =?us-ascii?Q?g4NtAr53E5vEdych+Cfz0AftWa+gHqE6CGpMt4cpj4udqNa+aSNGoSdxeZkP?=
 =?us-ascii?Q?DH3qdXjjbUNdtQzvddTMVJgAQjrPKMkh1ZzoRjPDsbAuvFPfzvRaGsHmPjk/?=
 =?us-ascii?Q?GtN5ypLgEjNzO4FavFJQQKY2LTcEvE457SHGoq8Rq5rwMQQxh1Y3VLUZ6Ycp?=
 =?us-ascii?Q?pdQ2/p0S8tg/kUKAXA1QhqXEuJnmGBJdh5UiCUaz8rVdlYWAkAGaJN0n/Hi3?=
 =?us-ascii?Q?y2tld5r2GBw+edGgaILHtd8JMNSDoGOr2PYP5JPpODUvPOuJhaXH1BqR4BqJ?=
 =?us-ascii?Q?kt7SB4r+vW+Hcr8OqfICrASZD01IWJWGqOB36egg7jcNFVVuR73zPHUSFARz?=
 =?us-ascii?Q?7XALNsMbvT6Na+UE1Htfia3EczKlWsxF067sPZ11h3cMsv6R/nCVc2kczMiB?=
 =?us-ascii?Q?AfG/jf+TMdjSKj+fk5rWc/W1Y9RqU1JeXn230CFXgHDYY+WEG7vbFEIqhHoL?=
 =?us-ascii?Q?17JBNUskckU90qW4MxFopV0MBTR4JSYo59icn20AjiN9VFNFTJR39lE4vVFu?=
 =?us-ascii?Q?h6v5ieQpI4z6ji3KDbMkUbGDs2hDSuwNBE8Zp4uKaW7SVowX9uyH8KrgK2XZ?=
 =?us-ascii?Q?aQz5Wmn3hN6afLCYGy+FW1RVShL99ZTj++dDtsthcoEhy+N7Q9Jov7yJ7xAe?=
 =?us-ascii?Q?mghsE6BtVcHUxgaEiUFzcML42zT1VNucBaDS0411wwQC364Ov0hKQB95H9N/?=
 =?us-ascii?Q?j8hvZ7TfgyzcSGhjsiSh0kqy8H72RkRLhtwvcRo9Xzg2reh9lCUS8aROKTus?=
 =?us-ascii?Q?tQrTU9nFOeBvSG1afHMR5MKVY0akzn7ke5PyqVkGYPY9XL93yDU9yKfw/Fc1?=
 =?us-ascii?Q?/sU08pw7lYVe8aTFAIPt22bbt2aXEQeAJKiDOiMQO0kSiTZ8O4NkOsU37VFp?=
 =?us-ascii?Q?7OVVLEbmbSmjz1UYt83y6smos4bKI2pA1IeeccMi8LS56u9Ptb+wZD8wtfOA?=
 =?us-ascii?Q?WSO1Hrsp8c/dy0XxwSkhI14F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yu4nMlNb/Cwb52ZnIEeNdjQqwilMcUve37e7ZHWXlYaTtASkWzP5R2dizjb0?=
 =?us-ascii?Q?xsWPXGkUn+ZQseUilxleX6WPvBtNXEak+5CItpixeGHvaTU+szzT6E3Wt/UT?=
 =?us-ascii?Q?Ggu/WI/OMnsmjm0GihgtYu8kCUhhRavTj71ll5iWAoZSCW+oPA0XOZXaNX65?=
 =?us-ascii?Q?mX4DbDD3h2LCQqNuRaxa/OACv2K1E6qj4+WiAm8sSUTIXxPu0+DcbzY5NFe6?=
 =?us-ascii?Q?s1CMZJnNwx/pynDPfW8TmAWJoQb/SgEmKWBlF7SQA5JyxFTVtM6RP0nqut95?=
 =?us-ascii?Q?FQpCoYlpgkfSRNMm/+C8GfTnKhDUbp3bfxCyIVAnucUsIKKrz3lQsgEDByRY?=
 =?us-ascii?Q?nmmhifLG7aQVHh+GgAC8tBC2QXqT1XoU9YitTdLTC2HnZ+gYTedxv5orCKWh?=
 =?us-ascii?Q?gR5Cl9rJoI6e3y87vSgzi8L+670DhKhjx7qFhJO7vbJVoKDATi7ysQrMStjr?=
 =?us-ascii?Q?d2Zhw//xF96mFfVObcbqYU22kmHcIfLbzhD7WWsGpej8PRsighTEB5bmIoW6?=
 =?us-ascii?Q?9Md7QVhBW/fRFWhZR5CMIr/r6ndr87WXJoSIZ3pEkexsDsGHrUK3FEoIXuo9?=
 =?us-ascii?Q?7rXQn7/P0zLv3LJftkDgcGxh5osmOCPqQbVwHJiR46ZGb5Li1jgnQq0AvvbB?=
 =?us-ascii?Q?acJdnxvVCgImp6p128ifS610ZDgWH2vuRlbY2sByXSHyrKQb4BFnkzN8qXZg?=
 =?us-ascii?Q?7wgQpiXOedjKMB23prmmkrZBtEJNl96bhnHjdyc/ZrTHTzyWC5H/xx49ywAN?=
 =?us-ascii?Q?sccZyMd2Zx3QDZX6qEu2IaZljXM/DY0/nroSfDpjSRvMhdr+XBo9qw9Y937N?=
 =?us-ascii?Q?QZrC7aVV4zOcr50x2dQ1eabRwAv+Li49JCJ4DXXSKWprK3mhg5qIpPofKVqP?=
 =?us-ascii?Q?xHxBWCR3gCAqALxTfbqt3JUq3u8aNN0WVNAXpuNvPHi2ssr/NxIl6ikipf+W?=
 =?us-ascii?Q?XO0Xt8gEpUOn/TlikN3NOf/5HobQ1dAbvNmNYdSq0tKfgp5MUcJNzCooroMl?=
 =?us-ascii?Q?opyqUiLABCNZmTzE4wV6PDioQb9HrUMJrlLfLrtiAltt8DkX3Zj9vG5SZJwL?=
 =?us-ascii?Q?fjO2n91Aw0Tb7NNSVE//TKjifilmXFguuNomfploTZEr9D+CT1kqE0uIrtD2?=
 =?us-ascii?Q?SqQkcitXhC8LaapP+SI+SzmDt4we1DD+FUGHEq0Pfnu6eGBBOLwkp03SBsSE?=
 =?us-ascii?Q?a2izDxQeXVU2rma8cqDyoJ7Rc/YR7dPX9JFFAG6Nx90tSxLS9+yDcNRYU9s6?=
 =?us-ascii?Q?b9IPag+5czCD8F9xJJ+RLCJNcoe4lsdMG26hGzk4RYLGpl3VQWJXM/Ov/jbT?=
 =?us-ascii?Q?m+v6ildJ+R358TXQenwhvjkbgJEIgvX6sd18WxeWoNBpOvsmIz8D2pu8RWRj?=
 =?us-ascii?Q?XNxCXSt7OjzdIbZT2KsMlp9ar1WeOWklB4xMoj0Jvjs+NcUUB9I7axmyJpUq?=
 =?us-ascii?Q?lYcteaFsNTDElE4TTFDizvz0Ks50HhlM3W6rezKk9PwVsG4WHe+rsrqXd1IC?=
 =?us-ascii?Q?dUWxBa//E/s1OmBjfgxlQ5fIIixkmMLBFRyl0HxCu+nzfU0Za5cTTUkLBGF+?=
 =?us-ascii?Q?ioqGsMoa7YsPJ1Iyrkk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e077bd-5589-4d5f-704c-08dd05d6777c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:34:44.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYAlgQepD3sdIa39f5/HtE2tWvmYlTJcVCXtHQX1u25BqE1kXGA1NBzwL4MF7mK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

On Fri, Nov 15, 2024 at 02:07:41PM -0800, Nicolin Chen wrote:
> On Thu, Nov 14, 2024 at 12:20:10PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 13, 2024 at 07:18:42PM -0800, Nicolin Chen wrote:
> > > > so the user would try to create vDevices with a given viommu_obj until
> > > > failure, then it would allocate another viommu_obj for the failed device.
> > > > is it? sounds reasonable.
> > > 
> > > Yes. It is the same as previously dealing with a nesting parent:
> > > test and allocate if fails. The virtual IOMMU driver in VMM can
> > > keep a list of the vIOMMU objects for each device to test.
> > 
> > The viommu object should be tied to the VMM's vIOMMU vHW object that
> > it is paravirtualizing toward the VM.
> > 
> > So we shouldn't be creating viommu objects on demand, it should be
> > created when the vIOMMU is created, and the presumably the qemu
> > command line will describe how to link vPCI/VFIO functions to vIOMMU
> > instances. If they kernel won't allow the user's configuration then it
> > should fail, IMHO.
> 
> Intel's virtual IOMMU in QEMU has one instance but could create
> two vIOMMU objects for devices behind two different pIOMMUs. So,
> in this case, it does the on-demand (or try-and-fail) approach?

I suspect Intel does need viommu at all, and if it ever does it will
not be able to have one instance..

> One corner case that Yi reminded me of was that VMM having two
> virtual IOMMUs for two devices that are behind the same pIOMMU,
> then these two virtual IOMMUs don't necessarily share the same
> vIOMMU object, i.e. VMM is allowed to allocate two vIOMMU objs?

Yes this is allowed
 
> > Some try-and-fail might be interesting to auto-provision vIOMMU's and
> > provision vPCI functions. Though I suspect we will be providing
> > information in other ioctls so something like libvirt can construct
> > the correct configuration directly.
> 
> By "auto-provision", you mean libvirt assigning devices to the
> correct virtual IOMMUs corresponding to the physical instances?
> If so, we can just match the "iommu" sysfs node of devices with
> the iommu node(s) under /sys/class/iommu/, right?

Yes

Jason

