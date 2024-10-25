Return-Path: <linux-kselftest+bounces-20667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471E9B0408
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A5D2825F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3FB70827;
	Fri, 25 Oct 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeKfToFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC2212182;
	Fri, 25 Oct 2024 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862963; cv=fail; b=H4EgsPxp6t4q+xw0l/q9CWwkphnAUnWxbr10cGXBTXq++rXZjLM3mxlNuhH17XRifvC/BXeeIMFA3I1Zel/tAx64p/9CMPCnFCCegzv4WavZOaKR28SPWEDK+maTOJswyfHZSKK791vw4FoeOIVsmOSaH3vHWscjinmeKp+GXkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862963; c=relaxed/simple;
	bh=L/LIX0bhABW+Ao6KxwW5pcUfPx4e5T/PbnAbMCgWmb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHAAkeo39adA3Dys2cQCbk03B+COX9/GBvhdTFB7qIEq53691xYlrUbSlfmJaLn77mzWwO5cOcchkYZZKrDyGinNwelYSVoJZENh9EaLWwvusyMswjKRYPvjndMZ0Cry3lpViN0ihKytwu1iGKFY+78/8CDSS5k1IVwJ5nEm8G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JeKfToFK; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thJVvEPK1dCJiUIHEleC7DspZDREGUCEGKIDonbWrtDDS1JEg+Mbn3ODtXVUBuG/qRAI/KydFduJL78ne0jRU6Cy/TFR/35/ntF4A5IWi3FzW0pKiZpOgImUDXVMe0d6YMM9vRaqqCYQoGjr6lf5MTQ93WxB35ewPKid+7WfS2H8IzWc3kKAlH6K43VCRaNpmefLx79uMGx2meH+/l0IK/qJiPEkSgU4VuZ/uGJx3XcvaDcaA76QFs8dQZMxuJJlY1j44dRCZIL91OEz98MFUJCztZ6KBMcA4JHTOzhwwfPKnwQ1woXZk+JUaq948vCIvkCxBM9d2goIgdnKNclrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exiL0L+NzLOl+byWnm22t6x3lknipDO8fZDtdQnnlp8=;
 b=GRw/Dk7VBTxsaeazwAg4sQvZmNU6PtC4Fy1JmIU0XaH6Yd7xU8vlz5RnpocRZyUbsRbL0MJdQev4fMBeLz40blNQ2Fy98ktvEvOB2wGQz+0i9i5D7++kzExctpjzvwOFq6TeFFnEhkvF1zlOa9EgdO7reOYx9mcpWLuMjJp2r85b4cK9BJ9l7Vq+6BAyW68A93FGS2O1LG4BfRJGlH0vzyiG/BWG72j6d97LplSd96vb2wcKajva+xFFAsXjQ0DEenDmH01V4O97lFKHTzVsb90Pfl0W7xDX63E8vdvi7uHACnIaRV1KmWdl7dYs2Nc0mWpz+eD+IB+gKosmKnFqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exiL0L+NzLOl+byWnm22t6x3lknipDO8fZDtdQnnlp8=;
 b=JeKfToFKNhhiVUIWy+hDFcKifgHbMUSNMqZhx9/3H1+JSrBndnYW3GbH3TPnTX4Ctqd/XXMhYHTY7pnu88sVPFpQ9nqqO1py8VFDzWLLB0eQaGvwRMm05S4rOyVMjXVLAUpNxz1KTi6xc3QvQcdh6sUV3BNq70xllhWJ02crKpL2Tp0NkNqKUPiSFoKwpKagWYIEGNFrYwEEYaz3CAuttKqOB8xIwt+ZHtqYOZyw7xDgtTcn5MvFb8NZ7HBjKOrmcK6FjvhOLmcAOuXh0xnMWivuiNAb4iZL6s+5vz/fQTtt6JopTJdPRlg+46X3otTz6qkfQShSugiuhza2m6xkqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.33; Fri, 25 Oct
 2024 13:29:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:29:17 +0000
Date: Fri, 25 Oct 2024 10:29:15 -0300
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
	yi.l.liu@intel.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <20241025132915.GF6956@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
 <ZxslrakslZbphayO@Asurada-Nvidia>
 <487ebe2c-718f-405c-8f20-213eab59ca0f@amd.com>
 <ZxsvofcC9xSSEMHi@Asurada-Nvidia>
 <607d019e-25b7-45b8-8c85-3829d4b53a82@amd.com>
 <Zxs3PYVLzmRfBf+/@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxs3PYVLzmRfBf+/@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:408:fd::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dfeacd-4a06-45ec-78ca-08dcf4f9063f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQvAeciq5T70wNt+mLuKjKTlPRuRRsuS6d6tV84uWhdtEzbnq9P0qX6H4M9K?=
 =?us-ascii?Q?GBdcaCnJ3uPWg/IL4SrotKwA1rMM1jNK5UMWHXqIyZLgqTxkbrryhoMCnerm?=
 =?us-ascii?Q?tVtWy2CgBMwq6LSheeeM6pcGnthTwAUVbc5xd1n6yT2GJMHHPQN9WVK4/hGv?=
 =?us-ascii?Q?NV1MMPiZ8A5SovPyb1G9qaplofYOmZ0pTwVAS33zW2+jkyw0iHNM0vW1fNdl?=
 =?us-ascii?Q?ccWliEG1jvJYGMs7guYCTEE/w8Xc8rbiyI6fG5mItXh7E+kLm/AvgzignWom?=
 =?us-ascii?Q?nIV82mRUDZ44bFb9h5Pl/RGpioUQvFOFWtYzN0zYjW8PN+bd9T0DHIGPn+0/?=
 =?us-ascii?Q?oIWh9wjUmlEh6a+LBazNbhKdQSUpmTEXsmw/f22Ua8QZnqVD20Btndh4eoEb?=
 =?us-ascii?Q?7UZcprht0LftjNETXcqlvhPiFV7eg3tJVH80tQMERqDREfouIagRz7D5WIiQ?=
 =?us-ascii?Q?QG3GFHvQJA59fIG4wXG8M2ls+s2u7LHDA2Kbmvmkk+MND4ygwpwfJQawCpfy?=
 =?us-ascii?Q?mU02cod7Z54c8tYeO+AJ916rE61aGpa/mNWHismY1bUq4pmFrw37JUoS9/jm?=
 =?us-ascii?Q?X8Yz37JOMEmEJ9KFAimtn+PeQCRYcmFcLKiCKnaLGqiz9FUCZfBhP+YHo2jg?=
 =?us-ascii?Q?s31SaKgX/8vqSbWEZQVPNTN1CFTWv2rZs+KpdSZfkDWfgh7WkD+oull+GQbV?=
 =?us-ascii?Q?+BwBPvT98VznAue7xyx3rl4qlmEKMqbxQ+uoa46qj+wMkSkdpqdHCczwOlVj?=
 =?us-ascii?Q?pRSS+43uMedJ1O8AWacBFUgGnikJnTJIOyncDMyBsg+/UGC5oCHDok4wOgMA?=
 =?us-ascii?Q?v38AAd9xVxUJTwO2b36P2mbcSe/0NuMAMB9+PDjY05kqi9wN0H1l8QRoVTiZ?=
 =?us-ascii?Q?4D/z5AXFT1tW4FDaa4qJi9K4WTf4wKmzQ7bzuCCRLIp6lb7gIXo6458+SP1N?=
 =?us-ascii?Q?Wk4uwYmN6YCJaF6EH1TPbuv0bugTsexiQ95pNhq94djiywNExrAqWShb3RHY?=
 =?us-ascii?Q?S/q/4FVcy+V3eR7+dG2iuSDdg3Gs+s5Hx/okDGYFyoXsF2TbjpYPBPdt1Vws?=
 =?us-ascii?Q?Lm3hzl4c1/57lgPuIDzNV6I3Oko0ORJKVx6pe4Xb4ydfZYbx8CZuOMbBAzp0?=
 =?us-ascii?Q?4AiNAN1j5+6Zpgs3SlclMVHH1FzccMdBE2WRB/WpON5rWqHbVfpGqVQ34ZMi?=
 =?us-ascii?Q?RQjJy4EM/SacGUVNFrIARvBe+xVsQ69PIAulPOQiyPjQ8R0N8Ve70zQVCT9u?=
 =?us-ascii?Q?uxjr/bW7K16Nm4yo0iArL7RG8wNh77CxcoTL9IYFWNu6/0pCwSJa7CJjVoZg?=
 =?us-ascii?Q?8d/W2di54vSYj/J6tH4+wujh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AxAZv221AiNf4dFCj9Dk0yQOY4pcCouHZyo7eqaz5YE2mrsxjwvn6gk5GVEj?=
 =?us-ascii?Q?Cu/D1CfjRCOinDsi/OsFYtReG52IUlF9hvrPN3PMAxCwnZX6kOQimxp+lhRf?=
 =?us-ascii?Q?WWSyCS+Yrf1GPL8Cr6j+o2H6cYWpQyOUbzCWzYG0eFSz+wyjKnLgOHGMG85A?=
 =?us-ascii?Q?gy2xhje0J8hUNv9O19Ni7eAZv4ya/RCmSGEPoyoCiZ3egYSFmljKpHMPUWb2?=
 =?us-ascii?Q?rXmvTFn+NTqgOeE9y2fh/MyDdj9RwrN8FgnR1czp7i0SGEwVDCiA1frqC58r?=
 =?us-ascii?Q?taG0JbfRO3+MpXv8bPBtTWFgzJsLHFG3fsdzpdDEifFDJ1jaI4KFer7fgO40?=
 =?us-ascii?Q?ddP3CkuvhhlVOeevhidYQvWjz7PYBMbfdwKlzAcaLnfy4FfZEGQNlX6KYDNV?=
 =?us-ascii?Q?ardDMkuCFDl3tetKB8ihc19msemjpJX7aKvtZKpS9c5g4ya6PFsLqPjjgdsx?=
 =?us-ascii?Q?Ymg6jViwBIgFngdZrBJqMGjaP7NNeVimQnrvb8LtlnMvnOUwPe1sUCS+oW6p?=
 =?us-ascii?Q?160x8O3wkwmVzpmNWI8I1Gv54QtyNjCnNgOr97CPNJ47kU7nn7yJ0eBrE0rf?=
 =?us-ascii?Q?7k0uopE5YVWnBWqTPuhBag8H83e3XN3ybo8kL9t5Ti3GKnhb0UnfzaiKJLu7?=
 =?us-ascii?Q?+c+j03SHYLS6FXNXYlemquH1d6slrNn+JC+pAWWRZUKgSr+qAzEqaIDv1Mbv?=
 =?us-ascii?Q?LOuxPkX9zsAGdDxQYLCLPxkisr1IK4rPhN1PYdF4Zu/ptKgDsQIsfGykcAGz?=
 =?us-ascii?Q?isYqiCtopASOyKaSxaR+JQ5tvPdJH5CpMEcYKyuCR87PqVphnDI1rIFJQasg?=
 =?us-ascii?Q?TR9PsrrIcWGHBmFxa6d7vz17cCWuoNxRgRXDgAhwFnaKClnx20xdEIOMozXv?=
 =?us-ascii?Q?ZuBAjITh1dhDkNkcP8bBDPzsLbx+m24hEeOVWto99b3PsXHnzS3gMJWVoR33?=
 =?us-ascii?Q?X3EWSex/HvDN6xQw0k0cYYI97nh7Sf+z17o9QIkY4QQalesz2fY/G7C9EtJK?=
 =?us-ascii?Q?HSBnHKXc/BM9KgUo8lyZvLjIOaEy9JQQAJJUVEAmoDze6UjISUaqlS6yFS8d?=
 =?us-ascii?Q?TpDdJe6MO5ueCW5IJD0Z05Tty+6f/VWiUQWKLLXlooQ+orTLTNjoea7A8NJw?=
 =?us-ascii?Q?IPsU58D4pysmi5qfoyZlPfi2nMYDdrirT54JcETfFdhRgHKLsu89HQ54ozos?=
 =?us-ascii?Q?dKef1dl/X9OtX6vF43fqSbKrIBsveXiXRzgZ/WAVPBibxiZ3iLUsjDBvlJrH?=
 =?us-ascii?Q?N5mtkGuFCH+IMrAkPS+MPdAbnUaZSFnPH97S/g5O6J3ZcPSck43sy8G5krDJ?=
 =?us-ascii?Q?vMOBqiG+tAORlva1uBAIssYD3WBZ/oV2UC4pl/60Fi+a9iCxblMjhi8c7s+a?=
 =?us-ascii?Q?OG3Br3SFlw7PJK98ryaGgoZ2jGlCdy9BJcWhOVj7hzpf3XuK1tYhQ0CEYEEM?=
 =?us-ascii?Q?ddHFio7uscsk8f2AoN8nDwhXrYlRZ9oHYw8+WJRRwYAIHhEf48e7iJWkBMye?=
 =?us-ascii?Q?V3sCwtJSjYgyaTEN/LkNnmHX9gi+0VI8ct4cuIQPkXubaXmFzUNM6FiPqmUE?=
 =?us-ascii?Q?Uz9nL7aH8rp8Ppa/cv0q3LMEv3hA4fizgQl8Lhzl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dfeacd-4a06-45ec-78ca-08dcf4f9063f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:29:17.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH7c+2kanbmyKaDkqb0y9+ClSbEIKJPz4JF50W++WEhx9rwR3aHLD1UspLo1EciK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

On Thu, Oct 24, 2024 at 11:14:21PM -0700, Nicolin Chen wrote:
> On Fri, Oct 25, 2024 at 04:58:33PM +1100, Alexey Kardashevskiy wrote:
> > > > > > Is there any real example of a .vdevice_alloc hook, besides the
> > > > > > selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the
> > > > > > question. I am trying to sketch something with this new machinery and
> > > > > > less guessing would be nice. Thanks,
> > > > > 
> > > > > No, I am actually dropping that one, and moving the vdevice struct
> > > > > to the private header, as there seems to be no use case:
> > > > 
> > > > Why keep it then?
> > > 
> > > We need that structure to store per-vIOMMU virtual ID. Hiding it
> > > in the core only means we need to provide another vIOMMU APIs for
> > > drivers to look up the ID, v.s. exposing it for drivers to access
> > > directly.
> > 
> > Sorry I lost you here. If we need it, then there should be an example of
> > .vdevice_alloc() somewhere but you say they is not one. How do you test
> > this, with just selftests? :) Thanks,
> 
> A vDEVICE object will be core-allocated and core-managed, while the
> vdevice_alloc is for driver-allocated purpose for which there is no
> use case (at least with this series). You can check the vdev ioctl
> in this version that has two pathways to allocate a vDEVICE object.
> 
> A vdev_id is used to index viommu's xarray for a driver to convert
> the id to a dev pointer via a vIOMMU API. Dropping .vdevice_alloc
> just means the driver only lost its direct access.

I think the point here is this has to go in stages at the present
moment the iommu drivers don't need to hook the vdevice object, so
Nicolin should take it out of this series.

I would expect CC to need to be in this path, so we should bring it
back in the CC series.

For CC I'm broadly expecting that creating the CC type vIOMMU will
call a CC implementation, and then creating a vdevice against the
vIOMMU will also call the CC implementation. The two callbacks would
ask the secure world to create the relevant VM visible objects.

Jason

