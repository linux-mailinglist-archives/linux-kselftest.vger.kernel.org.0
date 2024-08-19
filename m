Return-Path: <linux-kselftest+bounces-15676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B095732B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788BD1C22E6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC61891CF;
	Mon, 19 Aug 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ouas+eb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8D3B1A4;
	Mon, 19 Aug 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092026; cv=fail; b=iVfvCZ6sgA7yAF+ExsEoh+YNIvbbjYfG4m+jPExmALrDPOwHbcQy1QhNa2JZTPhCYvOKAkjniWFANNkiTHRqa6X17nl/HiuR643qPcZ5HZO1yb2xf4+Zjs4SdKjdGiDBeI4unpyu/ByzPUcofwgsjqaBVyqVWMH6I67yJB4lUvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092026; c=relaxed/simple;
	bh=9WJw8zmxKmicnnsMfz3zH62ApG4Fj82QbZhr5ys4zWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBrKTO6fkYyi/imBKe5zucF5JE/BJ7GzJYlMSVZYzCQzWsNDL1+lMQ2Ps71Lik4ntEp6/2o8kjpY3W82XZoKnpiuSvNydL+dsyksBN0/RNpB4YI45ILlnqMqri4yr5YPfbnqKkgrSfk0hWSR2bHIhsDjVVuUP6RmSeGCBoOo/fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ouas+eb5; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUyhid4Fl8FOIyI+IfSM7uIKVWPGhZ7C/XVCBvHBtZZkRXdGJY/S1ULyGDIob3HfNEt0Vqu60v8Hf9yXPwcXESEqTjl/02U+hwkhz8yQlaJk8SoNOVxVax4caWH+A5UzznekZ6YjoQmDmTCzEV0CEFnlqABYWGAOUyi/DyrKs5XYjC4+DmquDyW3GF7OVcFJcQo2FUWQLAYdDzeRgNWs/+/nAsF17opdt9F4mRlcLCBsuLdk5FZEuwIqb/EidIYhtWIBD3JW1U5UXEVEjd3icVm8rt78B4bmf0b+LilyMN6UOqI91lmpFFjElbE/er9mRRLEOziMjZkNJYTEyhnNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xx+nd4EdhtKYoNUjI7hB7ZkXTebECTmeqSBCRdX9Os=;
 b=TcjOabPrC7PxzU38sqhch8xjopacMNXXHQKh9JR4swg0pDDx2UnxaqXKtYfbWfWP943CPlAL1YYmhtN5pnD1oCpmPbzw7cBJ9bHNqQBv/G/XeXZeIQMQ4w9YGXRm7hdxOv0priXTz65jdg95If1zB3DnHxHQoQbVEONNCQhSVect3rfql7O7JsI0ABo7lD0pOkM8ZxqIh3d4QQevakQLoVUj3VKrRt/xsE5dgNW7/qOeskGvD02wyDRFuiOnCGr9T/e06tgyRad8rLAa/UvWmCdO+0wdZbefO2tdcmS7g6a709bgQgNEeJ2n7yeQDQK5+Rhe1wi39oMAypG+XO4A+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xx+nd4EdhtKYoNUjI7hB7ZkXTebECTmeqSBCRdX9Os=;
 b=Ouas+eb5WeCoH4AqPi7VKVNRH13ZeFHvolHq/duEXFxJPHvS8FM8Q+UvM+KoAxzVbIrMSt+DIvkn4BlBruT4OszxZtsdcYT1pxNRFHeb0gITcOy3GHzykdzAO3F4ysBHgCETsDmxFpAukHegymglLCPNZWQDiO4+Imit2ch1cVNral8QxzwFWzH8zwmN9F/H/XD6k4TgW0jAPyEv8L7Ah4KxfxpPCQFnkjAYrVzeFdvbuDs/HDpyf76edJgA46YdvRRc8vYDrC0IRMhq9mUOYVRlMH+MDK3yUznExtoXhRr6KISydVycqqLQaGtfPNOseyVUiE0YmaMGsCYWX4Dq1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:27:00 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:27:00 +0000
Date: Mon, 19 Aug 2024 15:26:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240819182659.GQ2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
 <20240815234119.GX2032816@nvidia.com>
 <Zr6bpbc0HZ8xLVZw@Asurada-Nvidia>
 <20240819173332.GM2032816@nvidia.com>
 <ZsOKe10cOTCcHOIP@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsOKe10cOTCcHOIP@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:236::12) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: ede14a26-b312-4d52-51ba-08dcc07c8409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phckFsIVKRzV/SBRmgafqiShFFFjsJBQzf5EjGPIpzd+h9+j78XrRmRK2zlu?=
 =?us-ascii?Q?HYXQ7RGE1vrt0+Ku3MwML7Xuxgq8ObPcCe6d9cnkCNWKLcJ0y53Ur+d7D/f5?=
 =?us-ascii?Q?7hmBkJ5fQM3HerETPOJF5HxkgwhIp/cI7Sae62vwEBTqaYKajDur7mD5fX3Z?=
 =?us-ascii?Q?oztyDPhYc/wOquBaQPkpl9IiiqhqKckThpy5Hc2yPcK1mQEH0ARIbR7c8ckk?=
 =?us-ascii?Q?5z5Uzf2Hb8JoLb0Oez0ReP8HYCtK90caER1DdJpX1tXpUZySe38BI4toJkre?=
 =?us-ascii?Q?7MSdsD2DwRvZCZLmJBOAEHLPgY1Na+CFUV/gdpv9B5p3Oyp24X9hFxd/kQQT?=
 =?us-ascii?Q?c6I5NDaCiG+D/1xRZ3NfxHLYIsUOAiljpol7kVHc/BUf9ssrwbFBtRWrqPGf?=
 =?us-ascii?Q?BsZ9QeGwoT8+m/wf6qs3S3vYDASFL1kABYG3YJ5B1oR9tcg01SAx7A5mmPCD?=
 =?us-ascii?Q?/lHCeoSjZjK/VFpxEywxXgzuhqxtoKQfhBfbzQWZ2A37pDEhYXXrbgMC2XcV?=
 =?us-ascii?Q?pRUdq4HuRlUZSdgfzDufrlXRn8WWwx0r+59Mwxafw4kxLl9A2xevAVN9lalv?=
 =?us-ascii?Q?YFt4feedmW1yN2HnbY8fLzaz4PnmlYo+7zN2sdcGzgP5vG+RVlPOu9yzkEh+?=
 =?us-ascii?Q?5QeaFXVM2DYOEnzXd5DG/CvvnTr6usZlvz3ho4cEQIl2wLYjHIwVHRiaZ+/y?=
 =?us-ascii?Q?ZoyM+oeWQEeV07WkFpP9quFrnlYw26MZN1Q631va5ERwJ5lb5iAnaNtUJEyG?=
 =?us-ascii?Q?C78dQkvh1tnnBwgEE9NC/5n9U+MEjvgIuI8LPp6ONMsWd8L5/nfBL2aQ/FnA?=
 =?us-ascii?Q?26zG11FWuI7L16VS7koOtsu0jCIOIGXpICrSRCjnhDErZ6n27uMAGJ9t+Wze?=
 =?us-ascii?Q?unNI6bkKqrIkraAnLZ5Kn7Xxd6SkAmNLfKmXTV8AQu0rp5ayPryWtmmYslVL?=
 =?us-ascii?Q?+H6fEiiUKh0VAMdlUfkEbtVLdmRCaRSdwD9/heNScPLz8lTP3prz0BSlpQdP?=
 =?us-ascii?Q?F/qswgkHrCNBR7V41/1HQXX7+70eiGPx5Yj5v9kJ95RS9J8ZAZUoZwWPVo1e?=
 =?us-ascii?Q?fGJxXB9QMLHBZapzjljOBOpDiOjuK5bzqczuqqwKJiUw9vbE6sBS9bH1V63a?=
 =?us-ascii?Q?TFF9YCopSe+WZ3mB8MRgfgzUdSWiRzkX5AX9BXF3DBeHsuYYaALYzMMJ32cX?=
 =?us-ascii?Q?Um4OjD5FqYVJNs+oOxZdg+rX8XYafiPTWI0pgV9kiC0TPIN/x/Na/RYk2ik4?=
 =?us-ascii?Q?OA96AHpGXxcxVmR7qZ/3qncXTdkQ7+KPfkab+jLtWpPnKhU5rh9NUmdufYtO?=
 =?us-ascii?Q?AcU7q5gwmkm3ZXmaGG3xS+e/YAHcf0PQ/MS/0KWWBE5Nrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3BoVs+yDeA24ClJgCkkZaULWT8pQqFKYddN1qqBNNZOsvI6bGGceE2XsfzHT?=
 =?us-ascii?Q?ECEaOEIkMH1oOEZyyJGKWATogoNrsIVCo7sk+pOo98i6C4E+uoBQwjlLkjJK?=
 =?us-ascii?Q?9wAqQvwaM37+5pv+yQwc2lkb6mlyqUZo1FcmTV9jKlWDbDsrBvZ80H/XIu4O?=
 =?us-ascii?Q?jzByMp94eI5Wmyef0H8EjJSFzso/FIxTC/rKuCmtxhdVYSWQ5lWFUuKZTwRh?=
 =?us-ascii?Q?Ss7DTiOiIuufWZodoMvM+FP4bcpNMNEaPe9BMP3NtEUgx9dvFBIM4j1kGgE/?=
 =?us-ascii?Q?3COaZx+G8KdcUwrF4YnvIVrLavL7dke3/9QuvIc5Z9AJT9OMvO4SLXuXlhgd?=
 =?us-ascii?Q?zE8MuYlfJ4RSPzDGujEPug4fNHIC6AeJ9Xv/jzbRaAAR4n6F14OnOxX0ZrX7?=
 =?us-ascii?Q?IlKuBjmjyYe/mexRLP+KQWZFvALVudb0rPuEzjoAFEdpuy5/nAq6LaQ3duOU?=
 =?us-ascii?Q?7YfCPPVe0sRgNanv2LEgDg0BycZHR4r+R9LYW5j7IyDTShwXTEmLA3lgMr8W?=
 =?us-ascii?Q?4X7nGC8ppXeIw943bEOTrwfbY3csdV/P0CKnT9HDSZIDIFCMmh337bHSVjcC?=
 =?us-ascii?Q?nng0Wpq07RenaxjwjNKH4qUUyyElO4ed9OggYCp5C3v9zBQIMHHzFgmX+5yN?=
 =?us-ascii?Q?GvbV4t3v/qCMwNC8jCEXoiBs1ackBLJv0AtV5z+OJrsb4+IqNZ1hg7qaApDH?=
 =?us-ascii?Q?M5kjhf6W0JopAJTnvlOWVr0Y8Q+Dn2aiLllygIu5HNMqQiUZU+u1dof9aATm?=
 =?us-ascii?Q?yGvxu5kCMLwawzA9+vIXjuoR2ae3QlrCRiRQaH33fF4AeVwOJc2kuLlCAWrA?=
 =?us-ascii?Q?uysU0l2ANxTNnmPck0gLONoZu41+lHcoAE2QWGOJ0Btz4ZpUtNJDbyRNZoKX?=
 =?us-ascii?Q?edEOJzM5kujHLVBjxorurt/jTOuzyLHljHCerPmTIIuMzjF6b6bI+MBwlFwM?=
 =?us-ascii?Q?PpVLnQOG/E0we4AdxRFHZliHd7FZhnVS5oAyWqYVjtbqE2O6azaq8J1FirYf?=
 =?us-ascii?Q?3mBsmYUuVvbWaYEOAzOrLEQiaNx9oHeLXGU4CE3LX4KqSCYl/St6JOsconou?=
 =?us-ascii?Q?VFbF0eVHUvMLZw+Gce3yE8nOLfXgERrRyilA6uBv/PDuTSZgFtJX+5+eOPGO?=
 =?us-ascii?Q?4myW5dTX9rmOcOOm++2w7jWMwnatNyebwxci9nOkbOT+JQ1kTpQ2x3CY2OlY?=
 =?us-ascii?Q?xJmgxeZQRPxglFidwFstNsn5m8+rPY64mhi+qx8BLdw5a+Zi9uW4XpDk7cwk?=
 =?us-ascii?Q?5luHNT7R1ZG6j/xhDIoWXKocTyjHEfmtSUDPSw6FuLP+cJSDw4Up3n9kHWBQ?=
 =?us-ascii?Q?VsL9H4Pxq7Oy5/XLM5VkxKP5frNiNQ/gewJJuSDY0VUOpBl/ro8cRReBKZyx?=
 =?us-ascii?Q?+bsze14xLbkSfneHT/l0gAlONweY1/Hej1sljvWqWNUtCWvZGbX5Wq1/f9SP?=
 =?us-ascii?Q?1jRfy4MhhREmqsnUhlDnAUWhDB6cmzribcHb9kxrt230a64Hp720dbu5a7Qe?=
 =?us-ascii?Q?nErPlZrDfYfde/SFWbFO64WnCKtyr0C4YkVfG3UVkNws9AMJzvMKXgKYZ1Zp?=
 =?us-ascii?Q?b7PvRZ1ttaTI8h9eG/llNZCDa1HETSLPpKDJ8GHn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede14a26-b312-4d52-51ba-08dcc07c8409
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:27:00.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iF0DnUPV1xXTmWl4FeUMobcdcVf61megFeKBnIo5bv9kxYRpA3y/wMLDXZvkeH4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992

On Mon, Aug 19, 2024 at 11:10:03AM -0700, Nicolin Chen wrote:
> On Mon, Aug 19, 2024 at 02:33:32PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2024 at 05:21:57PM -0700, Nicolin Chen wrote:
> > 
> > > > Why not? The idev becomes linked to the viommu when the dev id is set
> > > 
> > > > Unless we are also going to enforce the idev is always attached to a
> > > > nested then I don't think we need to check it here.
> > > > 
> > > > Things will definately not entirely work as expected if the vdev is
> > > > directly attached to the s2 or a blocking, but it won't harm anything.
> > > 
> > > My view is that, the moment there is a VIOMMU object, that must
> > > be a nested IOMMU case, so there must be a nested hwpt. Blocking
> > > domain would be a hwpt_nested too (vSTE=Abort) as we previously
> > > concluded.
> > 
> > I'm not sure other vendors can do that vSTE=Abort/Bypass thing though
> > yet..
> > 
> > > Then, in a nested case, it feels odd that an idev is attached to
> > > an S2 hwpt..
> > >
> > > That being said, I think we can still do that with validations:
> > >  If idev->hwpt is nested, compare input viommu v.s idev->hwpt->viommu.
> > >  If idev->hwpt is paging, compare input viommu->hwpt v.s idev->hwpt.
> > 
> > But again, if you don't contiguously validate those invariants in all
> > the other attach paths it is sort of pointless to check them since the
> > userspace can still violate things.
> 
> Hmm, would that be unsafe? I start to wonder if we should allow an
> attach to viommu and put validations on that?

I don't think it is unsafe to mismatch things, if a device is
disconnected from it's VIOMMU then the HW should isolate it the same
as anything else

It doesn't matter if the VIOMMU has a devid mapping for the device
when it is not currently part of the viommu configuration.

IOW it is not the devid ioctl that causes the device to join the
VIOMMU, it is the attach of the nest.

Jason

