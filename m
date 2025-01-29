Return-Path: <linux-kselftest+bounces-25371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3CA21FD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AB3A561D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23941B4257;
	Wed, 29 Jan 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dHyutCl7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099E7E9;
	Wed, 29 Jan 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162690; cv=fail; b=lA6K07W1T0/hhTajF1lAnpJCMtYLStiy5MP1/TzpUBiXvCSqL4pTqXxxI3lmQNDzSd5UvOemq+P0uejFwtqzNfJlRycZWxxOl7ZQa+c6teDSJnKHoZg5dIP8ryxoO0TwtRzP5xsr8D6PFk12LUvJlIqPKYJR30y0S5CjOROyj50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162690; c=relaxed/simple;
	bh=cXDK4OpvtytR0NSKUbv7VbXxMkdl8ZIpAhRyKDoHvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MaLMlwz9QGg7/U+9vGYpob9QMfAwi5Rj2VSHWR0VGuoxJhysgEqkx/0DLcGy1ktsP4A/o9sZ+bVK0Z/jeWUfeLr58MUMQZCXGUE4nUadtVyA8ikeC0bvFWqP4hq2r9WIZnkrL7MASErdGpDV1nEhzuELTrzxzqIa1KcI/qCCGmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dHyutCl7; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJVGJg02uB+iA45SHbNTJhfSmdK3gOpv79GrWNT65M5Lb5N1zqtlapGXoXx6V8BAKc7TpsRAw509XMu8MOYBXx5H6Y3Vfa/5S0BwfQaeuD45SoYcOhSJxnBpbdenZO5f/TMNnN4vbkBwUgS1n0JHbNMeR1jT94VMl799bb5ProFdz+/YAbk7wl1kgbNL929pD+iATWL72XjppLZ4Pj2qxeeXjSwC6ZLl1hDZe2w+YlXQwzg3llULJWf6CVj3ZA15UlnV5Z0yA9jB4sekVqSJ3TDNdJpQ5Zqy1I3Jfb8qslV42/LL7JCR4PYPusS+uRz/89b2EGU8wfoQXo4wSyHI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFQ89FOWChVF28LHSvaVAzztV0S8z2Xh7koKtCjF0Ug=;
 b=hrTCAraD7n+qn82AWy3gqo+tyULGYKk6/VggqlhjlEecW9a2vTmobAFvOKkFt/npXGsUoPhrZOevCZ5jLsboCnqZVp5EivWQoeTogzsjUe20G/YZmnt3Q5N7b7bZp4itmZkZcYIMwvGzpZPdbQbRdR0zSJdRq93T2Ovijlw0+WcG4TxkSM9wfHDxD+8gZ5nbN8/o7rKxRCVQbPteGErtmiBsQaBlKSTegrjpDY+cO484DfoZUYY0YxeimnfjRJIy4Bj7slMC+d++51glMUOtAw0qewIKY0SvZ2Q91qgr3q65FBB1Pf3DeGvH2fzABUyQeYFsGKohjlE0wqkOxyrwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFQ89FOWChVF28LHSvaVAzztV0S8z2Xh7koKtCjF0Ug=;
 b=dHyutCl7Qt40P2hliL+Wn6ShiHj/MEhODcsKjsy59NNwVB4lpKa6lB86O3+A32touacIv0a3++sL5/JUEjYrPWQUdH/1gTmYPRWRPQ6yG+HMI9AaEnS3Auh3WfvBjMeKOY/8TlxbV1Xc4I/uK2bmZjVFi45DsBznM2yPQPyUGet8H2VRjZBDaoLrkx/N8gPVlJgPp5cOODN1kQ54uLs0D0S/iY83ZxS/lgutBYgNgN8iFtgr7yAOUALb8pytf5L05XrICpgxhMt3CCevImFEDOdvay6IW3kEFg5sqrxzY/af8bGyCs1GH8m4gs/6WbxFwi+eJZ9OTn558Z7EeVZzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 14:58:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 14:58:01 +0000
Date: Wed, 29 Jan 2025 10:58:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
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
Message-ID: <20250129145800.GG5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
X-ClientProxiedBy: BN9PR03CA0806.namprd03.prod.outlook.com
 (2603:10b6:408:13f::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf25d85-daa1-4a0d-c845-08dd40755373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWOzK87M1b8cwsfukvz8O1tG1WcANaKIXhn+tACyQMeBL3PdHGDm5nP9kUWJ?=
 =?us-ascii?Q?ajpMCNe4mxSHuJKeSkn8LCTDKQ4hS3ADDvYQxOUOwFzVxoBqkwyGU5KHTR9I?=
 =?us-ascii?Q?3b5VwdGaok5YQXhLxLzOd64Dj3CiEz6/sdFBbTbjOXN7yDYz2N5AjdgfBqvG?=
 =?us-ascii?Q?fTjpuZZYpSyWFTh1Zg6qzzrv8evpAbyLHrOkUrMGbjUUu3cO+zQcxddbNSjL?=
 =?us-ascii?Q?YTZ6RhJ13b2EOdL5dpaY9xhwOiKUQJDxo7k1WdyigHPK409aXrY6AXI0L2wx?=
 =?us-ascii?Q?jzCxh2jgRu/E3Bn2JCZqWWh+xD5gcQGcFyf6yyzMiE29Fn/6urW+yLgjE8mu?=
 =?us-ascii?Q?z5TipyLS97EOmRo82cX0/HvW0ugNaqU4tjD83u+rTDJN8C966evZbsoDJRBF?=
 =?us-ascii?Q?WX4+a3E5G6dpJN8xdT6KkuA2apRhVxlN7uGyr1UpfmHAEO2QXApnpsmWmAAq?=
 =?us-ascii?Q?K8OM1Ku0Ac5kekMSrNP7f/M1vSVB6/INU0ADRBLo87Uh2i0D6uZ5pH4mFH3Y?=
 =?us-ascii?Q?vU4cJse5wU1oQ/dDlltfwXOK5lRnUIYkI8wDgXlPiwDT1kSK/TPT/HZxZdv9?=
 =?us-ascii?Q?pfK7IjmunC7kzWiIvEgAuTjKis6kmtn9TCZvsP4b28A+s75TLoOOTvPbqZoq?=
 =?us-ascii?Q?Q93vC/RHDpYoDTbounlt0Ghm2zTtaL6OtF0q/XCO5dti2SiILB9fPwvdaiO7?=
 =?us-ascii?Q?cuE+XBjHN4MTIsQcc48tjBwXqPgfQdUg9HDh/3/er0aVPtZqSegw4txM8uNv?=
 =?us-ascii?Q?eRnz/pWRhCX/LolKkcGaU2KkPiYwvmqsTwZmHAeKaTSpQzTH+bkD8/L+ma0Q?=
 =?us-ascii?Q?0sdJf3eER3+PF/DZt0QrRk9UFMpHrptAJRYnFfya42b3yfOFCV+3Csg1YzgE?=
 =?us-ascii?Q?WKPb9boNbt8L6e7bspcU36XbWnAEJH/SkgHTJdh3FH3daYWo+ko7K0erMWe6?=
 =?us-ascii?Q?kLQvMeY28VpwO9XUR/XXREZ7aoC8xqf8VjF6AYf3G1ijtfp0JmdsNMpnEo3v?=
 =?us-ascii?Q?8zaC5mjqFUwpDedgFo0tIHopdcG/m8onLfYWo83LU8Nd+0fzrlRBsqdl4os4?=
 =?us-ascii?Q?8UIUFWrxaEe6j50q3uggDE3+DfUVFPPApB6/ICTxleU6bk3SEjEUt+1v9I2Y?=
 =?us-ascii?Q?QbsXPZnGMCchagwqk16iaLjKWaf1jFC9aIeOZAkqPx/hnU9XO9YN9tZD+iIj?=
 =?us-ascii?Q?DA58fLO5Iva0kizYPB/dGLDQRxbZjrv5qw5gJ7rgOBbkBz+i5PCBfYrAlk3q?=
 =?us-ascii?Q?sszK7AvsswWGA9HKsIjaP0+pM3kXeCA6Fbyv8Ixp6ch06S+0YugPewrldquH?=
 =?us-ascii?Q?bEtI5+LnSLWwVQzJ0Lm/DESUwn9xQZ6fVnGKh3NpZM05atFjaOFtEFum81vX?=
 =?us-ascii?Q?T+lzJwlutOFtCAq0Sz2BE9+RoPfQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CCra0dnOUWz8CQxc81GkR2kfQ1Q2PZTUd1O6+0p4+IZRtXBbvUxz8Oy0RObf?=
 =?us-ascii?Q?Gr8i8RXOBuOw7dzEV5RIy+4RIn480EaFceU41r9p453/hhnNLdlHn4nuXnY1?=
 =?us-ascii?Q?uy5q/Mny/nc8vWRqJf1VAXmZ3/6zAD+GdF86KuLOVdKQ1TKmKKmq2E6Pi9vD?=
 =?us-ascii?Q?qOeWWEob3BxrOJ3oM7m0z4ox4oDAVS8BibjIBPL9/RAYUvBP466II7N57ajO?=
 =?us-ascii?Q?T4/5tdwgwVGk0ueGQd9gv1JfGnzOF4BjelWELCRjqIREsGER8l5zTPZPEaON?=
 =?us-ascii?Q?G5SC6O0urnfT3o3oTD2pR7Ac+IIOTCOE9wQMguKBVtuJ5cZ0SXr3nv95RuuI?=
 =?us-ascii?Q?uRc/sQRcHozJxrDsKt2mnHm7jFcsUDXoDIUn+406GOo7NKH8ZDeIhzSQS/fe?=
 =?us-ascii?Q?zr69t16CpD2IkT+5UL3nCYigvVE1sgYiHOX1ZarQqAVW72MxeZ1lRR3m90H2?=
 =?us-ascii?Q?wHKheeO38ymRxbsbUMHUQEP1lYYikZFV1QknKZhHSlWVe6ci5yo4Hh16gTm8?=
 =?us-ascii?Q?8df5xFD4JtMwjUPldtiNbvngRPr/MwvHQxg5BU+zDt351CTBBq3Ym76mIukK?=
 =?us-ascii?Q?SbnZODE68oGbeMC31hvKq9g2yId6VcBpm5tTVmNiw64O9RmP6csx4Mx1dr7z?=
 =?us-ascii?Q?84WMJ7fOM2oytD1YFhZ5jcAA3v4O17d4UMCfOzJ7jz/AANjD9F3jUBhJ71bq?=
 =?us-ascii?Q?UaCnF8/x4BrdsJsWYdXd2yrptytv0KI89+CF4qx3KnyIPkI2gB9l8B3W/8jB?=
 =?us-ascii?Q?c11dN12whaNOaQsdOjZZ35irJsSaNWqYFEujXna950JmxVxVJu5l55D0SpA3?=
 =?us-ascii?Q?Zfz4QbCfIWCzkL7d2dtuF9h+tj+8TeIB5ZwNvWiHlHzGLA3Hk8DjvxgbxdCB?=
 =?us-ascii?Q?SIfqLJ+KjkxlfQ5wC2gXvkkJxMrNtdsEfO/6AYIjhPb18ya5lKzrV2D84GV3?=
 =?us-ascii?Q?2/kugnGPr9I5FB+jHX8GwOBmy2yeloXej+L9GSVRz1WPszGs7atPEvzOR6Ek?=
 =?us-ascii?Q?VorGPy5lze3KI0jBqAkWddmENIIEa4UtHdbnyKF8j2UIqJf4vRoqkH5WX1kH?=
 =?us-ascii?Q?T2846m934TKDJe+/z8G+qpwKsTo4GFyC7JQdPkAA6v+eQeNEd7jNRiTRsed7?=
 =?us-ascii?Q?cATvH/8kZqLYOArK2bCKkLjD7kZQ3WkJkJMEK7kijZJVbPc7PfCqAY/O+F4f?=
 =?us-ascii?Q?B2QebJOdLI+6BX6kPixnLm8m3iYvcy5bdFmIuexvXMXMiQRNqIz3t/i3ceW/?=
 =?us-ascii?Q?CYBsjR6L97NrMfLd0keSHI6tkVz29Xx6wLBa+Lo9W72ceMcqj9IPg4weWqHw?=
 =?us-ascii?Q?ZawN9A/ynNpND3XHNCVyGctXIN3nqJWMWL/aZaKkg9WmLXV8R/tbVIK1W56j?=
 =?us-ascii?Q?ZxkbQDlLVyAyGPY8Wqpy1uQY4CutoBoVyXuue8hMJUgFJPuGIo3uvZY0hK+S?=
 =?us-ascii?Q?dqpLbXaZR3Jn8mpsXmLcbfYwWw2Kn8bkN1/c4bA/HTwyq6k/xtxDKdadMloV?=
 =?us-ascii?Q?1aF9R3FkhGBU6qRujkFr+CvTsQ62e77IWggTRtWEiDBbsj0xngoDoExWgdwo?=
 =?us-ascii?Q?wHyKtpMDjFHazjSxXtrpfi/hZktyXLIKGANfmgYD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf25d85-daa1-4a0d-c845-08dd40755373
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:58:01.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CrPs+kQttUJM2LUcjZlchk/u1rVuHCATR6lJQEWUqpIvPAsrt8uWIaV7mi7DHV8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601

On Wed, Jan 29, 2025 at 02:44:12PM +0100, Eric Auger wrote:
> Hi,
> 
> 
> On 1/11/25 4:32 AM, Nicolin Chen wrote:
> > For systems that require MSI pages to be mapped into the IOMMU translation
> > the IOMMU driver provides an IOMMU_RESV_SW_MSI range, which is the default
> > recommended IOVA window to place these mappings. However, there is nothing
> > special about this address. And to support the RMR trick in VMM for nested
> well at least it shall not overlap VMM's RAM. So it was not random either.
> > translation, the VMM needs to know what sw_msi window the kernel is using.
> > As there is no particular reason to force VMM to adopt the kernel default,
> > provide a simple IOMMU_OPTION_SW_MSI_START/SIZE ioctl that the VMM can use
> > to directly specify the sw_msi window that it wants to use, which replaces
> > and disables the default IOMMU_RESV_SW_MSI from the driver to avoid having
> > to build an API to discover the default IOMMU_RESV_SW_MSI.
> IIUC the MSI window will then be different when using legacy VFIO
> assignment and iommufd backend.

? They use the same, iommufd can have userspace override it. Then it
will ignore the reserved region.

> MSI reserved regions are exposed in
> /sys/kernel/iommu_groups/<n>/reserved_regions
> 0x0000000008000000 0x00000000080fffff msi
 
> Is that configurability reflected accordingly?

?

Nothing using iommufd should parse that sysfs file.
 
> How do you make sure it does not collide with other resv regions? I
> don't see any check here.

Yes this does need to be checked, it does look missing. It still needs
to create a reserved region in the ioas when attaching to keep the
areas safe and it has to intersect with the incoming reserved
regions from the driver.

> > + * @IOMMU_OPTION_SW_MSI_START:
> > + *    Change the base address of the IOMMU mapping region for MSI doorbell(s).
> > + *    It must be set this before attaching a device to an IOAS/HWPT, otherwise
> > + *    this option will be not effective on that IOAS/HWPT. User can choose to
> > + *    let kernel pick a base address, by simply ignoring this option or setting
> > + *    a value 0 to IOMMU_OPTION_SW_MSI_SIZE. Global option, object_id must be 0

> I think we should document it cannot be put at a random place either.

It can be put at any place a map can be placed.

That also needs to be checked when creating a domain, it can't be
outside the geometry.

Jason

