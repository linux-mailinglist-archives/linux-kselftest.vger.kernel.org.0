Return-Path: <linux-kselftest+bounces-26134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADEA2DFD2
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C85B3A5885
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236A1E1A2B;
	Sun,  9 Feb 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U69LezBj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7E1E0E13;
	Sun,  9 Feb 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124553; cv=fail; b=gMDfLNaJwyUn96R2px6cVMLkxh23T5eFI89N4ilwGoTu4bLbCPR0Xxg0VSxW0cFRe+R8IUMUs5m+BcYJLDVEuitobo7xIdd0DmlNh8sGltqkKmt+w3/qPVaiQ8IwbyhM73Pp+8C3l2Qkgyu8IoPRl/gXDed1UVeRgtSpadWMltk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124553; c=relaxed/simple;
	bh=LFmrktfpZrEIqee0Q3K8/g30ar3TV2Or0nTqoJBfA1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QUZCe5ndqdMpjILy53WGgwg+oC/F3G3NSV31d+K/jBK1MV5XXr0FePXG05X/wXGGhnW6vNM9qumNyYEXnutyGjpPfsprLPeqSwk8Nr3X5B+ci+3MJA05SIdSfOD2axbPW/EYbwbeYWwsuT7JU3QQ3IOYBFlvs/QMsz43H5OmiDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U69LezBj; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSvj+QHyo7TePlpkUM4IzY4O53oF17a4GDsIGRLLfA1ixyIqqfrIHzvljYv2rWcA5g33tnJht9AMrGRqM6M2yMiS0qChAVH8dFnIcdabPoXl2KpZk79f42+h5R5diHUHN65hz4akqk0nraBgaXcPhshernkNS4WbcVsDZQ7Scm2VjWhvFMTq+kOOTpLUqzjASuxIvOJyjG1DwhGpcXip98DQloAUpZlKNmeZu+3cGDDugOWJQ7ryXVfcRWRQzGqXMRYIj9UNQf7MCNmoDfmHEbZrLn0UZcM1Kblht5XFP3sOsEFttFEZnWNimueVZAYdnlobFAexkcefhInYc625mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDwjT4ULXGqJr98wR7tt3ay7EjO8FGkvowpJmrFY/Kk=;
 b=i0rv4LZM31C+PXLt5sc3lSxYvry8Snm9SI8HCWE4gBjY7GOO0vACGjDJBKjpFF2nfztDAVBPkgCfH9jWxJPr45TSpUIdMs/llJBKgdpAP5RoY+V9GK+eEJIzHDOfiHLDadlPTAOhmL9B8cjASC6o/aMicfAwbzDycBe2QOfVZJ5OzqiRVkj8gnNKh41Rc520DPsa3xP7zRe5FM5ir4j3JWmiSkcJqN9shodhGEoz7d3FkWtHscy5zokAxIcuXjzM8u3Mme74ImrU+tYCb12+zlA/hcowpW1o4+Tn1NJe8MFkOTrcoP98Q1R+X0L5/4hH148677nooKLBn7jVeE7g7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDwjT4ULXGqJr98wR7tt3ay7EjO8FGkvowpJmrFY/Kk=;
 b=U69LezBjeyC1UNUHjP6PYLR314xai5GQty1zr0sQe+IZ2/+QuX+WpP1OSI1hZ6LLIgFGw5bGwNr7FTzlqLirZ0qZk/KMioLNO2vRW5lZvh9YKKDfbH4pO0ylt1JWu1ZFllahmoMgM95h5FOSa+7OFWnviiKx3QJUBB3UkreKl5WyelHlc++nq2TLMJBQPWipUnI1w8EKKDgJrf300MYcvtW1N/xOD8Qtr1XG7wRBe7Nxd0CUrC8jHVtBVNYcue7Jgo3hLy2HXe/EoDqypBwb0P65wYqCV1vQwbL9m1N4I0ON2uzJNRkU8VL+qz7ml94bw2z3BaZBrDHvenD9/SLdqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 18:09:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 18:09:07 +0000
Date: Sun, 9 Feb 2025 14:09:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
	apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
	bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
	nipun.gupta@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Message-ID: <20250209180905.GI3660748@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <Z6WLXTiYVzuN368E@Asurada-Nvidia>
 <20250207143020.GR2960738@nvidia.com>
 <20250207152801.GV2960738@nvidia.com>
 <Z6ZYJAjYTKGqEbxB@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ZYJAjYTKGqEbxB@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0851.namprd03.prod.outlook.com
 (2603:10b6:408:13d::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c78d0f-7b60-4110-c7e9-08dd4934d81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lGFgpBl0xo+tRDrnT44SL+kHSOH3h/s7in/utbQF20WAz9OB6gxlAxGBVhKU?=
 =?us-ascii?Q?Yma5/BnUG0/6nu3f+2Er38Hyks0BkJj2BWZSMu5NnByBY2ChE3sYWTuoT8qV?=
 =?us-ascii?Q?kV6Nzyz9fqRHj+3k1x9T/S7TKDbOGpqZP5hrlaOxqFE2hGPXvC/dzivBmgIl?=
 =?us-ascii?Q?sN5FPllmXgFRyqM8K10I9JwfgiHz+I/Bspt2lRcVv8qsDvHrtHjn2sswTgVC?=
 =?us-ascii?Q?e87AXZ8UPgzCiNkRxXHOBzEhMix0R057VuFK3CHqSoXcjvGSITCeyurQpPZT?=
 =?us-ascii?Q?mrfGqwleQtojBrVV6QbM4TguyCuF5DfUBN7PDYmeCPL6lN0X7C2tWmBPIMhw?=
 =?us-ascii?Q?YZudDl8nowGwAHPp7l4FSPz0UzlCJqCpRuoMYYb3b3hEDlXuHi7aPEcXn5oN?=
 =?us-ascii?Q?dIxn2mJr26nsvQg4t/llIx0F9bhBCREABMtx5n+g+dZM6QhPOxpTMFtpaf1s?=
 =?us-ascii?Q?qaALFDMKLtcbjxtFIU2jQBzrG2zlYVydRu/f2QHLWnDNtPNsUukYWNnvFp2h?=
 =?us-ascii?Q?xX8ZK8UPwM+2VgT1/sJbWLhSR6HiZT9w/MPWdDedAyWXxLGSRKbY1Rtlk8Ec?=
 =?us-ascii?Q?UEYl9a9xNAEjJqrFFXLzWBszZsdhO96TLPobmGx0066WlpAj9ogwck20xnug?=
 =?us-ascii?Q?/7HR4MOyDmxpMHEEnzBvb0Q7B5QPEUtaTUVWPf6mlmXPMQX5euG7MxcRBm83?=
 =?us-ascii?Q?1F6eM3FtyoQmkHKdTmxb064cbY3DtvUJJMw17Tg61LmZxix1jLeCWsAu4zmf?=
 =?us-ascii?Q?wW3sXkfARU86xFLm+BvAT6drN66z0a4XE7hsKvb25pqiAwbMJqWoXSzx/1gI?=
 =?us-ascii?Q?k1Gp/8I0RM7hbw0pm6iHJTjFDXFAjRmZEsHmR+Qn37o+nSP9i8XmETnZxcAi?=
 =?us-ascii?Q?FZLBICath1K2z+IhaWn6mFS+oXtNhVrcVkpGxkbvnWmvskdXpV5NU6J4OiEd?=
 =?us-ascii?Q?KsJa8wAsyJb0n3iPgUr0CNRLdqEOWgIiDpgDhJuqYqvHNwAMZ4HA9jngCuj7?=
 =?us-ascii?Q?yz3SKA7MLP6T8YmA6/cVNEYqyw1OdnAl1rVbZ5xVDtFuUHmxRwK5WbrbNIP9?=
 =?us-ascii?Q?2mNIjgmPEvGS/gnPCFvoh+PKJ9LbNkHeNT/bGrJ+ARiBXYiOLS4VugDqYDr0?=
 =?us-ascii?Q?LIkOu3Ndjg/Mar+O20DplXQEPp8aW2LYsSAgjFSWI8lE0YJPUsfBHf6oOZ0k?=
 =?us-ascii?Q?N+VRbnCPdVzX2Vgo3jnmK8u4zWF5JPca1SyWLjXOtucgWrkW1508xK6c3OyM?=
 =?us-ascii?Q?qxj7fgSQ+gx1DIoXC6TuGJ0YQu+Uv13d21igM/u6rPEbutEID//NkJl3+XaW?=
 =?us-ascii?Q?O4ylgdVYiZIkYW/Bo1POgCR6WLDhQKzwM4Dm2yGiQtfkgUqx/p6VeNAnS5yj?=
 =?us-ascii?Q?z33rB5v7/B+/6bR5+CGUgvg7m9Kq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRQLEmDYrTt9ZvlIFx3OiGJPC27WOlnZVbcjeYZ7GqGikF6Hl/HZjmjqxCmy?=
 =?us-ascii?Q?ho2Km+L6S15PnRy6BQmhhafQ/iSs9fNEMtHL4lsQSR78X1Q7+m6Thxjzb6cb?=
 =?us-ascii?Q?4B/qbvtN9eWvRWyxWzDiFk5GJpvtKYLcb/AB7CfBx95Uly7Nf+flRbF8JPMi?=
 =?us-ascii?Q?NS+7CKI38SdOHJk+qcWcgbg0iEAsBxgeR9oRwjnqI64L3sccKq82JMRP9LA1?=
 =?us-ascii?Q?IwFdmVIj0OOfANaL894F1QPtOPFN7lwDRamyQdy0UkPztf5880IMLxd/aIxq?=
 =?us-ascii?Q?3vVc+H3/pTzWW2Z3GrKzycSZ2shyLLbZdh37xgC48f5d61CLD+GYV2h36Wg7?=
 =?us-ascii?Q?5tgtj8nGRJefkVswPWjXkuuIPQsF49SFGhyzaZchC1Ix0l21RBn60OG3n96R?=
 =?us-ascii?Q?U28Z6lnPcXxgxUi0Mqy2XaiX4anh6178mOAOlZUaaEv+05hZHUGuX+Vjexk/?=
 =?us-ascii?Q?jc50VvFXXz/1x7uvQYm/ddJlnaWgqieMfb+pE7f4rnZ87n64nvv8vyLXfTsW?=
 =?us-ascii?Q?mBAmq/w1QyXpMoolM4uFTr2Yu2VMdnQCckXowWOsetelpw2uS5E5v/InJv8/?=
 =?us-ascii?Q?KMwQHPT6ZexvGCaiqUvxsKE52kf53wqUJmOEV8fRSVO+07UMdn8exsBm7lI+?=
 =?us-ascii?Q?KMN9cK4jLx+E84A4grujPJpTSHa9cSS1PFHN+vdBTwx/6AbB2PDcHU887uxC?=
 =?us-ascii?Q?I1rvDg21OWYtOttjCUzSJ7W/Lp4pzsFjBWh2aTlO1xEKhNydSTOyFzJgFAoQ?=
 =?us-ascii?Q?+mA/By0GdshvpbR0TeB6YMwMEljv3neIm3QIzUmSlcivVDDHA793F4xyG4Kh?=
 =?us-ascii?Q?rhaA2DnMu0L+zHbpw+k6Rdra5QpByEHSYfdAtMAIXsQmQMOzYcXy7fm0CKZd?=
 =?us-ascii?Q?QMm39NUzlyKDPxpS3XaoHhKmgbOGGhLNxZpDr2jp0V0b2pgPZ8xvODpBPKaY?=
 =?us-ascii?Q?+bwsBaQJakNC85skABTFJA2t/T0GuPIj9LpIW28Ddh7OxFDUHFsNKlo4RBco?=
 =?us-ascii?Q?GaFsluO9Fp1eDBa+mOFYzERUS/a+gHsn0+1BMI+anfsp6epmVlJtJNErPMPU?=
 =?us-ascii?Q?HSjFu4H1V6RYfiIUFyQ5DQYffS/Bg3skmE9WespwdReKJEjj/WhNhtroAKgG?=
 =?us-ascii?Q?YOxmkuDL1bZqrawa6gVqonXrxKDZ+SZcSJMKCGLb/uh3wNL543C91jlEnPjU?=
 =?us-ascii?Q?2+agSmPn9Zcv2+EFmeDqE/vPkctB0zLVPBUPhrUUkphnuKbVHygwKgd6WDLQ?=
 =?us-ascii?Q?3gtH2PDa+srgD9W3mYyA9msgkjwnBrGNze7nhY+MQuPsq8IHTr2IenjVzryd?=
 =?us-ascii?Q?yY/gDbejwHngKKjgGBZ+Vf5Sh95FiC+MIhtq0Yn+Gnn95f84WPLyXjH2Ygeu?=
 =?us-ascii?Q?6qcnYzZCp1VXSTQyTQ3XVJj/osSz3yISrE4dRsWBY8LqewaW3abhPis6hfoS?=
 =?us-ascii?Q?O0mJ2+a0LX1VmqtASSbHIKFGIBfrA3FOZkakWGIQV0KDuu6wztbd6+9GYx9b?=
 =?us-ascii?Q?mfv13Qjce38XJmSzDMiDXYeg4bdsfXDQzWrv7x7Nky7rpGjK84n+wJ2xJOEy?=
 =?us-ascii?Q?dJCqOgwwTKmq7qAKhWo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c78d0f-7b60-4110-c7e9-08dd4934d81f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 18:09:07.1330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crdjbK+baQ8S9AKTtPgIwa+UfekPcGx79lN6KtB568uVMGo/2p+x7c9f3UFez3B5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

On Fri, Feb 07, 2025 at 10:59:48AM -0800, Nicolin Chen wrote:
> On Fri, Feb 07, 2025 at 11:28:01AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 07, 2025 at 10:30:20AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 06, 2025 at 08:26:05PM -0800, Nicolin Chen wrote:
> > > > Yea, I found iopt_reserve_iova() is actually missed entirely...
> > > > 
> > > > While fixing this, I see a way to turn the OPTIONs back to per-
> > > > idev, if you still prefer them to be per-idev(?). Then, we can
> > > > check a given input in the set_option() against the device's
> > > > reserved region list from the driver, prior to device attaching
> > > > to any HWPT.
> > > 
> > > I didn't have a strong opinion, if the idev works without complexity
> > > then I'd stick with that on the basis of narrower scope is usually
> > > better.

On reflection I don't think a per-idev is going to work very
well.. Part of the design was to keep track of a bitmap of already
mapped pages in the single hpwt that unions all of the devices. If it
is per-device then that basic thing doesn't work and it becomes much
more complicated

> I could imagine. The caller initiating a SET_OPTION call in VMM
> will have to know what vITS page for what device. So, this info
> has to go through the KVM/IRQ module to get processed and then
> forwarded to the caller (vSMMU module at this moment)..

Ultimately, as we saw in the other conversation, the qemu command line
will need to describe the GIC(s) and all their ITS pages directly,
somehow.

Jason

