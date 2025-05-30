Return-Path: <linux-kselftest+bounces-34089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7EBAC9596
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 20:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E03A1BA3A87
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA326562C;
	Fri, 30 May 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oB82RCRt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F12367CF;
	Fri, 30 May 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629525; cv=fail; b=OYFbk8VOlW3h4eDdLf1sXKw6pGA590EPoDA78UB94MOzC5IeK9FZoqnxVlgjuclGvhm51NJu1WOMrZ5CvTYZ0CL7GYzCEsEpTDhmFrB/0TPSLzUt39CMZ111WgAuhSq/TPx33HM27mhBoJECUklMIvAF39gFNDQzxPGxeyDJKZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629525; c=relaxed/simple;
	bh=DUTNJXS5jNY9hJQ05AJwRqmJiLyQl0/Esu4qW2duJsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJV2QsfWhuS9h9i/V8WU1QVfaumQb3AmowIZiHia/C3GRLI9+F8aMyVsQtjNNgbC4wLW2DyBw8hTNvhSBlQ2CrMcjIzBwRhUM+Lm7OvYb6ydmOTil5Pj2NKuBjAVExGm+nf+uAGxdlPWSXpKkQYp6Qzfdxj1A3vl708SXCIvKGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oB82RCRt; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExpJ0z3vSI37YykQ2/MMcbkJn8dsY+NpjExXAkEEjHIFCotsoeyDKM0eBlMlc5evQSZY7wybRfsPUhAWOzGmuchZ6PK9BGKundEEDI2vnJoTjm/igNje9Ymwr1CepYzulOzrL+ob0DNtNej8uZwpDp+ZpTShf4q1/6efL4eaz+/8rlDUX8jMyKBBzcvcMoan7D8dtq23IiwYXVqCpGnYVPpAYJT8TjTrhU2spX8jg0lYJFLld42eP/zNedrk0dxfhZAF4Jt3S0iVJ57ZNi9h+8My8mDU6CbsCq5JILliCpP+GEoNjkkipo85wbQ6Gmbj/CbGsytdxIXQauCgxMgWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u7PS+whMGKKwHMdPZMRa89/kNtJEMVIFeGHho86PrA=;
 b=XwL8ly7WNMbrphKSZyqJUHfnjhjFh4qk1By7PkV3NbrjnY86VPeiOGl04bnBNTt5T3qc1hDkRXxMmnrNHEBuG6KosFDyR5dl/478PoI9ugr2X1DVtmrPWZeIFM6z4anteFy9nrSeA0HGTgPeFmuduhajNVb/JHjISHm0ppCI4p1d/AKNIufuyvEFtKmICQWlaL1wcs4bQhpiANth21UmQLqRFRPyWzCHyLe/4yU58dNrLguXZyRDrQmFe6o3a/ZF8yL7SuJOunTHUnV4imVrVqsqyXjtSsZTKsFDqzLPWZLcW8NUPN8a5t9yVaWtCQKg2blFTaKo74cuXfRQ4c0Z4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u7PS+whMGKKwHMdPZMRa89/kNtJEMVIFeGHho86PrA=;
 b=oB82RCRtpCtxBPP8ZP7ncmsr43UW+Hz0VkZCMFpRwDZ6AUs4VhX1+7Ik+1tB8nkcB1/iwnTlEK4vIb1D95huAEKtpQzOF8VkXFSqJOjU1BPWoYz6KaBG9ZSHPFga/D4AzCyM13sM94/rovJhSdicGG/PFC9KbmJVMSb9FLya4JIPnrf1MJwMieq9+ew1rjm/3zOEUDumAaJaOF+gcn8tx1Zt1+mf37q/tXM8gd93F+DFDv2TlZHZMKLrB2glfLtoo+bWDCqeL26WexDn/6YS/I/I4up+uweGc+0ZhtP3vjraYsdIgDqIXvkzrgdI8usEfBQFIuaaNMEgFvZsrtPMiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 18:25:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 18:25:20 +0000
Date: Fri, 30 May 2025 15:25:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250530182519.GV233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <20250530161455.GE233377@nvidia.com>
 <aDntEDywhsgMoZwc@Asurada-Nvidia>
 <20250530174037.GR233377@nvidia.com>
 <aDn3hueUhGKWFIkn@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDn3hueUhGKWFIkn@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:52d::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a31a3e5-c9c9-42fc-ee14-08dd9fa755ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gY+3G8YfbaYApG+rN+TwY0qqIOGPlcrkGoBbf0ItoiZWjUgjIOidZbmqi+tV?=
 =?us-ascii?Q?hkX7c1X3/+yIO+6iy6xn8WoFN3vm54/52F9ROPRoAWtDtikrOkeuT018dsN7?=
 =?us-ascii?Q?KEJGzeKMFzrm59/SGITHAJ/TwKafS+JLW5VuIcMw0P9FHNlNWX1Fj7hfm3wT?=
 =?us-ascii?Q?bQVFV9AjBAt4u5+BsL0sk81X310d7DpnFwtTnE0se67gwMzCnz9TarMUgzu0?=
 =?us-ascii?Q?JdcWycRQspSRFosF49Vm6UZz+j0cnZEaMq+yrppsg6M3Rpt8oXXyXYgjAnlq?=
 =?us-ascii?Q?HMDBKDE7cMo4A7zC7dgw+bsiGfe5qdKCsgYeXLYSjLUZe8KTbVu3lFX5SCkA?=
 =?us-ascii?Q?oJbu1iUUqnNdc7kF85ZhLZ4CuJWIUw+jb4nPaQG/YmRgxbaSSpmvzmE3DIwa?=
 =?us-ascii?Q?DhfxXTUSz0ikE5apmJd93nBw9u8aSNt3SWg7S8qjq88okWIFZiTIHos+Yfb9?=
 =?us-ascii?Q?9JKeThtyHbwPgh1qYGxfKwseEnx9AT13DCVv8PZ5HfJKf0Cy3RpVlVQkWeQJ?=
 =?us-ascii?Q?Khn3E/3ycSIs6cUE7NG8pBnCwsvffUxaoPEh7vQaYkOBDzEwkcp1yi3mY928?=
 =?us-ascii?Q?IZwOaoJ6DGf+1jQjkT0zwg5xnCTFJaAK2e8AnB2gCee8OsYUXOzcQJ3PT+Uj?=
 =?us-ascii?Q?fecsX29fYebmhLEUl+huIrgq6mguyr2V25kMPpEB07PPkUIIjEvW8PSOE087?=
 =?us-ascii?Q?gNJJo0ygm0RyMhb2dgjqakeL7h/rjwCWwewxavOyqmWzFdDsfOOlIJIMA0tP?=
 =?us-ascii?Q?2FtBUVUDv6lL/RF2cx7j7RWpWFJX/fgJvjkXtn3+BOdrCuQEowuTkmdFsHxZ?=
 =?us-ascii?Q?+sVD4oKZAgDqXdK5/jp4My+I/3CsT//qPszrc3RUd+W1nOWS9lkgTqInG+l6?=
 =?us-ascii?Q?4vHzw1GSQ3Tms/MFqlYHRYpvhOV5/Tw7vIlVMNvL5+NWZowQjhhx+1cFOid9?=
 =?us-ascii?Q?yvR6j2wLRLMceJbq8Q2lm4T1RZSJ9bmC4VpR5h+rWexVxNFIygad4xuPPItG?=
 =?us-ascii?Q?nER6AB+lA0I9oQd08e9EjGwtjjmGBs3GGRnj1fKXwzllDUYssVve8Gjmo3oI?=
 =?us-ascii?Q?yoHtxLvTA27xba52kSlOBqYlbG3nNoHczRgyBL/+dBDXelI5il020p7Zn2qg?=
 =?us-ascii?Q?sMGsnqewHW7XPUyhZcrqivlv32TBW4kPMo431W62kPcNJnAEMCFMj+KLjc4F?=
 =?us-ascii?Q?RxsnuEeNAkGM5oPcM7JGmarketfG4FGAu0BdCcjGz4ZqelgZPM5u3JqebR0W?=
 =?us-ascii?Q?mNK7Z2LDc33rO3oihRLmHnj8Q1tXWRLoYJEEtsUfBev0TOeMUb/34lzdMEkZ?=
 =?us-ascii?Q?9uhoerwTWRENmrXhCSkCQPT2re/0VIUYN8cwsoQNR2bVX0Y2v7jDRUbM5hcH?=
 =?us-ascii?Q?sa3JXX1RFQ9JBl4oqAZbtvPoHzaUho6EWBQlOKeEWHRb9Mj/DoOzy5sPxCl8?=
 =?us-ascii?Q?SlDmxMm29R0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKAK3SywD6+AONxlM44WEaAt5u5b73OFjSVMldezcmm3rHr1BgRNXkoy1q0N?=
 =?us-ascii?Q?Rd6dHepgW2pRZO/qfbr46liGZCFRlhJbyQxduaUUkJtPLrqbPdTSDh/U1/0o?=
 =?us-ascii?Q?TZIF13bYN5+PKPLYf8A20Z81RUOvRWaRTFryUXk5SkOrPrKmPIi++Bkzu1+7?=
 =?us-ascii?Q?s3ttYfyXUwrZZ6cHA2uspu4EgGkVBOZH5Vu/bgsQYbCpzedS/zAbuyMXVcu4?=
 =?us-ascii?Q?gROqPpzXCKk7HclTUEILZ886WKKwTR9WyxEDlMtzquThXKnyXEmpwJTuXJIN?=
 =?us-ascii?Q?Q2RHWC88BUEnfVjHfhMwA7qiNAgrA4Kgv89uOUCVtjGo6hBpe9GneI83LnRU?=
 =?us-ascii?Q?t9imhJOXvHobDRkvVKtnv4mmJnG3kEf1h50e0bL04aoaGEtyKceqS9BU3Qkq?=
 =?us-ascii?Q?yuAWAKdU0lSU6vkSxT4fpGcUr95ZbQ3gJHtGgJagRdNgrhoXv0kGGsx2oAYh?=
 =?us-ascii?Q?6nVN3JQVmJ8iBN7RUAi+GVnrqH63DgPFqJdz6ONJT9AdLkpBZaHtiIwE05oq?=
 =?us-ascii?Q?FaUl6UPWyBetKSyBR1NYkfuZzA3/rqs9Fijw4A6MVgDt6p/MhcdCJbEJxyyR?=
 =?us-ascii?Q?UfYE+iAS29Qp6nT3TtHOygNV5SgkXE3lFrEygnJiXq9JjVni08o28tir/GF2?=
 =?us-ascii?Q?zqGoHmix9BTGcXCkpRnMw00UTX2lxfO0gkpq5vIcIXdK+t/DdqpXFo6zId5o?=
 =?us-ascii?Q?wpUqq3kBmM8degVfjSxQwaBvDzjfhNT9zmaPMLjbVx3dsvNyxXP2aRyInck6?=
 =?us-ascii?Q?2TnbQjQhp9IXTGkWEdBMIaa8ksqTfjwOB8nKFi4TsX1x0rogJJkcPmkncEL4?=
 =?us-ascii?Q?Xfsmp9wjZ60rtDNWiYWAvPHEdRNR9gYHzWI0Vb2GS61kpfwDS21t7uO718+v?=
 =?us-ascii?Q?OeB6DrB9P3uZ8IHvRVjtYaAJJqeKPi9Fb6/UTjWHbkQx3oJcxatSdM8PfVAk?=
 =?us-ascii?Q?Gm8J2IhPCzjxgehrjvE+VqbXtaEANbf3rT9/du+jTACdfqyq5ll0hK/Ffue7?=
 =?us-ascii?Q?+CGto8nCzNGNNlZ3/ZihX/GEkBxfZWWgJb38gyA5mKteCVuJpkQtmtZCA29o?=
 =?us-ascii?Q?W+m2NynLlJ/NV0OEbXyeI+/6hvhix59ncVEnQungWA6M27Za+VpYHj5bcSyx?=
 =?us-ascii?Q?Rggd09vaww7IeAFYLa/rEnu897w/JxosDi634xSUr5zd6fUgWOLFjOMt9f+O?=
 =?us-ascii?Q?G4ZRwYQr6MaTjzvDLOCKzyIhKQPoFAXBOBzFpqLUlMpyR48qWqR9DTjfRFtB?=
 =?us-ascii?Q?3ay4vGe3gYS9w+B7vx34qUUsya4SgWfLbp5Bf/t/nIvrF9PZ4QXdQArRiDAf?=
 =?us-ascii?Q?9gNRqirdCwGzUnfWNYebzrWOET5ZwnzJZc3GL+ZVOQmT6oA61woNJ2rVvKpA?=
 =?us-ascii?Q?P6DLwt+y5Lfv7FxkEsVcozNCwm8adAhBvy5XfgtTKbGLhy35H6hFl3FFODRQ?=
 =?us-ascii?Q?4e037GgwQHGHrQ5rWOKk4UDcrcuAItqpRybINV+NHVqRXrtPl3dsT1EWC78c?=
 =?us-ascii?Q?N5go1ke9hXfIQhWXvPZZQJrnYQsMoB0Ue8xSXJtiDfQb1JyM9wHuTvPwIA98?=
 =?us-ascii?Q?DHTif8fQTAsGsaLlCyX9ux2mSBytrXm4mlbD+Uf8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a31a3e5-c9c9-42fc-ee14-08dd9fa755ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 18:25:20.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTKG/tb5OEJ1aAVXLMuMhfK/+w7hEKwxJzqS7fXkHkj9548ss93oj54+GigC8IYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

On Fri, May 30, 2025 at 11:23:02AM -0700, Nicolin Chen wrote:
> On Fri, May 30, 2025 at 02:40:37PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 30, 2025 at 10:38:24AM -0700, Nicolin Chen wrote:
> > > On Fri, May 30, 2025 at 01:14:55PM -0300, Jason Gunthorpe wrote:
> > > > On Sat, May 17, 2025 at 08:21:31PM -0700, Nicolin Chen wrote:
> > > > > +	offset =
> > > > > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> > > > > +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> > > > 
> > > > This should probably be capped to PAGE_SIZE/sizeof(void *), return
> > > > EINVAL if not
> > > 
> > > Hmm, mind elaborating where this PAGE_SIZE/sizeof comes from?
> > 
> > We can usually allocate up to a PAGE_SIZE without too much
> > trouble. Beyond that it gets more likely to fail.
> 
> If PAGE_SIZE=4096, the upper limit for max_npages is 512, i.e. the
> max size of a guest queue is 2MB? It seems to be too small, as the
> VMM can use a larger huge page size to back the guest queue?

May need to make a new API that returns a bio_vec or something else
more efficient then :\

Jason

