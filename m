Return-Path: <linux-kselftest+bounces-15668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE02957236
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDA41F2119F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6A186E2A;
	Mon, 19 Aug 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQqUFXFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D4175D53;
	Mon, 19 Aug 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088818; cv=fail; b=ZdXcFiqJsYupSMvK+GRrDCygTXghM726mu/yrvi2uXO8CypzkJr7nD7bTFMBuX6ImR5cF2BGsiIhLaRH2jy57velWiFRsqiB9YSbdGmI3J3v6wJoLi+zYnl9sr1xV7zrOVE1ci45pOr/EZR7MSYs2gupltmeGUkodqq17n4pucE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088818; c=relaxed/simple;
	bh=wrKPQCQFeZNR3Gt03BrvjOxXZgQSNdJf5+u8iLhddfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zwh/e9KIMUPDi3ZDW3JeEd3Gz4FTzqw1NVEsiABfXSPRxdJty2m2r3+CaL6PCUvipRymW8a7unES3EYAWsTEtojz5iFXZ0eiUAotKa0PLOTyx7Z5VrU1IohqyrlR/a98y8r1MFGb6vxUjY8c0SNADQ98ksix9OQwDuntBcCF5WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQqUFXFL; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1JYu4q6Kh+Mr4NxmUpDcDxTeHsCTP+Ipcb3KB+DqIhZ/iqD4yq81ean+grp89KI6RZWmLywgeEkdC64LeKP5VpO7IaMCFCJuzheU6/Gj5yS76zk+SUA3/M/rygMC2Nf323G65UA7NlYjqhsJznd0fIJpPfRr9bEYYWIddLbB6jJ1IamPvQjgM//4aaweOupDLc4e1bsuH4L+Hvzgrtxqk1w8fo5CpUNqXLWEaXbiR+blxRdiwCKPVeprwutaAv5bapBhxCxcs4Ypclqp9Qtjp0dR+MdOpzRlNYnD9A9AUfTYQJvu0/sEPq3cEbBqmxd1tykKwuu3GCLUu6nlXv8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRzfyWvDrrrnpGnqN8DzmcSrIQXcw1jHGAFbwSRK1t0=;
 b=iw7TP2psoXr0kAey4HXntjizS/Y4sLqQr2W/wQ2aHoTfy3m810nwgQaH1V8/eETTZXvwonx4k2d+nYyd5uTn/WrXoNivaKq4YG0LW5dEqEcN0mqZQoWO5+APTKUWOeMC57/Uxhmhju1FBeffTjKMry46Dh/n3WrhXuK4IW/+IpToPbFj4Sr1BoGLuPkYMtbklGD4qKzr+r2vz/dNAWPJbqf0YA+LGjjp0GjNy9dJPo2qjTw8jPcl+hghcqUoCIqLjJDjXhEHhK8YRGGGmLozmr7IwY4xrpo5yFEr4OBezMT0yLWtFN3Gdzshe1LqzNIW8UnT1EFdolneBjIUBdRMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRzfyWvDrrrnpGnqN8DzmcSrIQXcw1jHGAFbwSRK1t0=;
 b=OQqUFXFLa/ZysOIOrhO2mi1uj4e4zP5IqRcjjg79VzIDEMZoVHrstAGbUQax+LzLmI1389agboG0gIeNQmlhnR7BfHVurJBZ58Xu2TrwpiIS4J029tjUyfsPDb7ZHbiIDm/Ns0qRCi0IfCpCl36DjlAO+rIf2N2C37jBj2NDsyIH51+22ZBGokIY0QyBo7z02HfFBEXlGOW1QA3/WlRxYDX6P7+ie8pFkYYaGPpMMfVche3IgtdR9G9gTVNb2jwkfKIOncfRrtsZMAz3AmKgFJMahG7Wf3t06YYlB5wBM69WHo8dAVR6frockNpUkFk3xBdeTqRfjwCyJvb9hjrk4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:33:33 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:33:33 +0000
Date: Mon, 19 Aug 2024 14:33:32 -0300
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
Message-ID: <20240819173332.GM2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
 <20240815234119.GX2032816@nvidia.com>
 <Zr6bpbc0HZ8xLVZw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr6bpbc0HZ8xLVZw@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:408:e5::6) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfe3609-7784-40fb-47fe-08dcc0750c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nrnKJajFqupARJ1/4v87HVKYRsFTV5w4qAVDAMUACmNahpYPLbhJanpMFJUF?=
 =?us-ascii?Q?bNSPqC3bmLBnJnrLRL1mD/QqDbLlkSeMpisbeFrGxqqBD/fUsFVlH1HMLQ2G?=
 =?us-ascii?Q?noH/QdWc0yTu128IaNZO93lN5edMD5ft69IDwTnxZvyJyiJ0KBA2xOiPxTUt?=
 =?us-ascii?Q?1AtZvadnis9I3X/UwZF9T9+taMaQIh4O++AFY7HccqIbyQH+3lPX1xeEX/QO?=
 =?us-ascii?Q?e3A9rCi1th6fWvzHQooej9OUBqaH7eL4BxQgPawvvq1vEMr1rGZgoMFcEyHm?=
 =?us-ascii?Q?OccR8+VTTdKXuQVc/mbnmrrUpcQsE3ObAMStJnxVmgzX4pP0eH/E9kYvjxxO?=
 =?us-ascii?Q?ZMmE0DxMPAVUx7kdW754o/cqO5Ff+/7CLbi9pTby0Jo5puiRFRlLVAEaX9mS?=
 =?us-ascii?Q?mxol2nJBPNdHWQRUKbVg9wAYJvueVBCAUeMxuWQNiyK9T3A4m9wp0Pa16bSJ?=
 =?us-ascii?Q?nZYx7vK916lmfnpLaDl6+HmhQFPQeMXC3u7iJTnz0nS/C3ZHNAwYv5WQuzu/?=
 =?us-ascii?Q?ArK9yScGiJc8u8cl6Xc4IMAYA56DIMWsRDIl4xlh635Yht8lp7FCDncyrSy9?=
 =?us-ascii?Q?aeeBiEtekw4xRz71DzAZ8QiKISrCVEGg0BZpD7oJjZhqcixZGhQjw05jsfxs?=
 =?us-ascii?Q?vqxaSeEbuxGk42+izDLBRFgKwYUl260RNsDeWArEzTuWB/Bob5o3R0h+AHeb?=
 =?us-ascii?Q?lijRUxuQWznPqyc7nMlYdcLYhrwQ4ZSYpGltatTUYV7eR4nDD5/qCaaReksi?=
 =?us-ascii?Q?y2BRpEwvk+du1ght42KeA2yhN63AK1cYXaNJ2BBUij22RMkK1bLg/r+yd93p?=
 =?us-ascii?Q?bAmVWV28VHccD4EvVhAjQ5rHKr51KU+YGQJSTKuD2D7JSH1R0f14I56bSp8p?=
 =?us-ascii?Q?+bBFpWBecFMUyGH22jYLYoGL6p2Vb2IdlaBijoSYYL5wZDgIbZ+4yM7lOGz7?=
 =?us-ascii?Q?rrGrN+/i39G+FiNcznviqqWAjphMMmqvJTFAoLoNo5klXrOfC7HjMorSmt7d?=
 =?us-ascii?Q?TPkBIQQU4IMBSFyONawXKUmsz3zPpnv2i0sA+h5Mu1AvVcBVdwilHuXXlLtA?=
 =?us-ascii?Q?svlMrTJHLUJhupmJ3OY1rXjdilrqtaWGmgTs9GGjvicTduReVU36KxWcBc4s?=
 =?us-ascii?Q?jT1XYw32a50+jpceJyMUrrjxRkZI8AARUoksn7r4BTDowNgR+W1F0MrMGlnp?=
 =?us-ascii?Q?31HhZ/sEsHQXT8n3VCqM2O9fDxvWiNgQc7lDizQ73xFXdrVkePQCFainA9zN?=
 =?us-ascii?Q?CT13Op2Rhs8Js8P0g2DsZWGD5DdoMqFyajw9dChIqacjwP6qaHIf3awaHpZT?=
 =?us-ascii?Q?BQK1X6nuJn/l0m7I4fFZFFpEn5f/Id2soueBAu0C9Qp5Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwAl+bi5rB6QshA2sVqrsokDfJMaoxyMeGb3JvO8E0dEYW3GL9pqM+ltP+d1?=
 =?us-ascii?Q?CqGCLMZNcowFbDbTJsPoldWQydY2HNJo8TcUEqOBimzI7bO2GnR0BO0NnYFy?=
 =?us-ascii?Q?8LGK9UsGWli4qSk/v1JIGhy6SLqXxroSVPgMRWpSpP7bMhOWFMehDl2VaDz5?=
 =?us-ascii?Q?dMYW3DmdJLvFEwtql62H2nCbU2tlUWZx3R8++hnRTRat4j6b51hhk8By2EJ9?=
 =?us-ascii?Q?bk/+rcz3CUmR8MfWlonuggOIN/+aoXF2KHb+xxuIZvBnHjbhfxJXw73xftD5?=
 =?us-ascii?Q?6yXlUC0GCLBkf3IY7YtD1/tH1ovsDCBTzG+zQJVhCJHuk+aNZiDiSDVaN+t0?=
 =?us-ascii?Q?zoKZKlz22cQwCqG8IlEvJXQgdWJQBi83FEwhV6B/N4tLvzvXhaSpYlA2lyD9?=
 =?us-ascii?Q?WxaHjVOly9LZMCOMfcHtyzpO09sJq3nBHzcFa+i6AC487MyHseOoyQOWUJeF?=
 =?us-ascii?Q?Zvux/Ywq19H4LgrWFHzZJpYtyqm5dVDjCV9PThSvAG7BruqQYnGesRcANa/g?=
 =?us-ascii?Q?VtCb/HTfiYehkTrLXXTYGDr0UQzXFGLSavIlH9Sk6pWtHVEgWf/TpvO1XkTF?=
 =?us-ascii?Q?TUCqC41VKLIOyzO5gWiJCKY3sjS6BdumB03eTQkcwJJl8ANXUFdC6mdZ3Sb2?=
 =?us-ascii?Q?wVZsr+YMjkPIs0uGjAzIZH9WqmF03C+0YQRb5OhbFWl+cUwgKiMDGb2kocmn?=
 =?us-ascii?Q?g6hdUKBtTQjQLPPWSgi9naMPuRKpLuR87M13PQo2mGk0YqKQSftHYQG0zTtQ?=
 =?us-ascii?Q?B/QkYPPGgEXSJtrXAHBQKLn2KlXzQSAsfcl1r+pfmT1kSbdIQyc+jOw1p3YS?=
 =?us-ascii?Q?ca+lQ9sUmOMawUktEhN0qdaLgPV4hrEB0KTCNRS6kJuEAl4BTcTSCsaP/Baz?=
 =?us-ascii?Q?kDCnfo13bVbdOYuGx/PshFH3CkyllyktcIV4hcMdSS+KFzhWNZOZT17A8cKT?=
 =?us-ascii?Q?QAB9+nCPwDtn+ol7gmpvlwYA5dTvY4LdQZRzn8/92CWYcI7oNJr1wUIw/2sc?=
 =?us-ascii?Q?Y3kTCTMxxLfau3Hx5GVcW20mDyFkvELAyODSlSJF+9l119+d4l/q+XAZn8pj?=
 =?us-ascii?Q?owYv2pTTslP8Zi4EyEuij2KLg3CLy7cw2uNPqOwsFD6nk0KZMsZD7DvXEINQ?=
 =?us-ascii?Q?WQP60MVafOKphEQEVrkb1MX7lfEmgDkG8TDLSgnwNhYJOZZfNmtc6o7PUb9O?=
 =?us-ascii?Q?M2j7RmqLbaMaojjpHkWZwHcq7VGcs/wACbXXlEX5NO9WsP1me71feOfi+jdq?=
 =?us-ascii?Q?ccwzqD4bm41JzKXGS2erwJU+ImMut21aFr+oq8uq4YrnPWxY3BpKZhqhVQY7?=
 =?us-ascii?Q?m41DnYHAkfvKT6N8XctXDw8h5yu8ZTYDTSRMghHzmBleQl4tfZD/Psi4C/Wt?=
 =?us-ascii?Q?NSk+Q/SnoSneRo1AU07TNAQmdqd/z9DI53K7RQ6sjunLBCSFUTPTb4kW8brc?=
 =?us-ascii?Q?V2sqwO7h+vT+ImROYCadCUDXgFs4+G2//ThkbTkE6959C9aRIkFrl9RZdK6s?=
 =?us-ascii?Q?JEXgh09HvdV/SxRXxTMuYaVTcCkcUqMdb9mc9cJuYffnBqXzDjZghKBnqneE?=
 =?us-ascii?Q?AmlY7QB0KVetc3onCnnx2+e68KFt13EF98e3VFL4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfe3609-7784-40fb-47fe-08dcc0750c5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:33:33.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bsBOq1fvIXCdHpe35zAMz0fNQxWBGoPXV4UMRpcoZd/1ReopedCu/NU1DsqHs9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

On Thu, Aug 15, 2024 at 05:21:57PM -0700, Nicolin Chen wrote:

> > Why not? The idev becomes linked to the viommu when the dev id is set
> 
> > Unless we are also going to enforce the idev is always attached to a
> > nested then I don't think we need to check it here.
> > 
> > Things will definately not entirely work as expected if the vdev is
> > directly attached to the s2 or a blocking, but it won't harm anything.
> 
> My view is that, the moment there is a VIOMMU object, that must
> be a nested IOMMU case, so there must be a nested hwpt. Blocking
> domain would be a hwpt_nested too (vSTE=Abort) as we previously
> concluded.

I'm not sure other vendors can do that vSTE=Abort/Bypass thing though
yet..

> Then, in a nested case, it feels odd that an idev is attached to
> an S2 hwpt..
>
> That being said, I think we can still do that with validations:
>  If idev->hwpt is nested, compare input viommu v.s idev->hwpt->viommu.
>  If idev->hwpt is paging, compare input viommu->hwpt v.s idev->hwpt.

But again, if you don't contiguously validate those invariants in all
the other attach paths it is sort of pointless to check them since the
userspace can still violate things.

> This complicates things overall especially with the VIRQ that has
> involved interrupt context polling vdev_id, where semaphore/mutex
> won't fit very well. Perhaps it would need a driver-level bottom
> half routine to call those helpers with locks. I am glad that you
> noticed the problem early.

I think you have to show the xarray to the driver and the driver can
use the spinlock to access it safely. Keeping it hidden in the core
code is causing all these locking problems.

Jason

