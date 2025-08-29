Return-Path: <linux-kselftest+bounces-40335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E134EB3C2CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B9E7C1D51
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929D221FA0;
	Fri, 29 Aug 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EX7p/3fb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B530CD95;
	Fri, 29 Aug 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494337; cv=fail; b=GsGp6SbVnbYMxEqpQGpCUU9lDTsadVv7Wy1MYkoI2vLPuUnOXLx/XaBRMF1q5qJuRwMf5zrbfmQ8FdLXRoRC1pTCzNneEh9KgGeMGM2tUNNzAAgszmMufb/AZHoqPPzykhPLWgvzERpC7wepCP/1USbm7qVZgaWZQvYApj0hwg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494337; c=relaxed/simple;
	bh=g+INksvCo73jspZc9zSLv7A65zMfJr/ujRKjKVwmuV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dp44CFYDrdARQRyqdxsdpmAkdIg1v7c35xRV86ih6AaIDoYF+5gHeRw6r9uTF5OF3uUU7h948u5JlWCzt39YuTav+3HgbqMAZv8a4XZ8QLqFSg3pfbhnv1hcOZu1xAi11bvD2gNFq0qvb43toVPaglGBfH8u166C85KKhwsIf6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EX7p/3fb; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLrJAHoi+rokpyCCqf1KXV/LDY8r9vkMKjSHY4MUeLtdfd8nOP8rgfybQdkhU3rWHk93x3TtBcwQSNY6y1jDV30qKfIKgitFXV6SC/C7w/1JXsQHAJIkbD0KelFSLvSb6mRrLILVRCmdd85lB/YIDMsfmajoVm0zsfwJCmyV0JrMbHjPrYhOQxvzP9gvD8aRPmQZx7qQ11oIutDUYC63uja01O14GCVLq6ZzTgaDJoIU8Uwo3uttz+wi9tKHNVgqvU3U+X18g6dM6Ec/ey+VgX9cQp/Jacw5LpkQlWyDA6njiWJEsmvVZqHdHnK65ffq0520WE8qVEXxI+ZLt7wdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKxc17VyFRkAhSMHj2EPw7lyLShKxwMzNji7BNuGQ2w=;
 b=j4T2WAgVWcLQGNG2Jc6t75d+UdWWcJi9GT+xx4wMYQFsvohD2kTjS+PbyFRooY1Tkt+Eg4z65Jc2oEuF6F8bCWfZc6tjToRYfOnXR9kmWaOMPo06xyxyQBityEKGnhIxbx1zlnxVTDZOk596gcDDvApXC3TztteG01FqQ4TRZslZRkGl9J+0esaeF7Ha8icmjy2wBjHH/cPHbvI7wOjke120tCAmMTlTfSxgII6o2HmF4PftBkRGPK1Np6r1M6qIyACYjdJIHwLJ3ZIUMd79ceWBCBMsUnY6/sgchcE7U9BUrGhMod8RGxPyXzMCXNbDG3enp4TErLJsT1Fy0x1E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKxc17VyFRkAhSMHj2EPw7lyLShKxwMzNji7BNuGQ2w=;
 b=EX7p/3fbfzPWRilmCN9JA2TcU1eYc25yqAhmw1hQRvoOXZOYhCXOW2OLVi4p034AFoAXbm2W9j4ZB4peTB8gvt9ayXexopz6PCzFNM6Qekk3dcVh+lWEhsQEW0BY4EtWJg8R0DDs3KuH4/dY9G5j1vHjtaMU7/Xs3N17Zgk17BaRCVWQgkQrM1Va7/9n+DB+5A1UYQfWTlIufRNffC8yhujIMavsiMZ5d+9cu925vKxRhg8tppdYNtE/jnqVG5AWez4AFY8W/l9xqOmdcGujHZbx5xPzKl9AjSOQqVMsakWUmpVGEk8eDxhZyEZZ3JLrrWX7M5wPieE3hUqmOP2+aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 19:05:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 19:05:28 +0000
Date: Fri, 29 Aug 2025 16:05:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v4 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20250829190525.GG79520@nvidia.com>
References: <3-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <cc96baee-2be5-433f-9902-a160765e2fae@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc96baee-2be5-433f-9902-a160765e2fae@infradead.org>
X-ClientProxiedBy: SA0PR11CA0204.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c86c07-cd69-459b-4414-08dde72f040f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pcT4WyonzfTls2OrOKac0v8pTugWMffdvxv0nVWpZzM5NpJuErPOP1Q6vsr8?=
 =?us-ascii?Q?O31mhxBaPvg9E4RSGZQe76Dc5y+B9VTMtEocG6XjaaEiW2rV7NGk+fr9LYqV?=
 =?us-ascii?Q?OTqkFCfuTlHZM0R2npLHaa4P8/KlnKbbDhiLr11gSiuWFAfkf32iXe8Krnpq?=
 =?us-ascii?Q?kkmifuDcQdDrAgC5OC8EjKO4UMRYY1usbtLc7NHxCO9htzXFk+MqRmwXkkS9?=
 =?us-ascii?Q?8xEA/9LX/emsSb6qvk3eB6kEsYjQxg69wpMHOmenWgCD+01WmEfuneUDkazW?=
 =?us-ascii?Q?4LqTC5v4Aq4bcTMa5VjjcvRz+63eaRzJ5VRgDxZ6Yt3gYGTXSssVzjFD3Y7t?=
 =?us-ascii?Q?sfcIgJwwiKMSaK+dqsyMYgSvi3frioD4afCmFLuMlsVxRZn2MWsBZU16FDdg?=
 =?us-ascii?Q?8vXuZvFhsvl+kHH7ovkGRNgVhBMcvpdfykGNma1bqJqfTdtW6kY4yxjO8Oys?=
 =?us-ascii?Q?aXo51knqXnL+34/fh59EqjczOX6xcmC8CKJZE1oSCm1Z4shu+DWllOzbfzy0?=
 =?us-ascii?Q?z38abdLxNZoXXwO1cXfqjKGolXaweE31Uk4jd0Fbj67ywF1DwMePac9dTwaW?=
 =?us-ascii?Q?nuEkrtNNor7sNrfr+PIGTnLk8kooCLnnXumnXseqKEyuCHWnxhm+1P0JRLA2?=
 =?us-ascii?Q?uNHAyvyGk9jzRGpqPIJcpIAB9mwtmjm+58tZg6B4f7ygBMe/ulPudz39c7ei?=
 =?us-ascii?Q?wvEAMaqxGfftNNHF6taJ9ZIc6YMBsV9SLkWRpTX+ZluvxSNIPBzF8uDovqbm?=
 =?us-ascii?Q?TSN9GtM4yoBwnAah5a9QZ8AjBFiLuEDdsh6XDhiQDRBQ/PTJiJjud+OE5XbN?=
 =?us-ascii?Q?1Y1y/WRQiT2GZ8b3qJsskz3R4Adr+7Ya5kynpvwv/Funm1ZmqJ7R0/bNgCxP?=
 =?us-ascii?Q?puJPLWsvvweZZJbocHfKQxsHss15S0QXm+8jLFqUd87Hv3VTk4huS7rdxzzM?=
 =?us-ascii?Q?0OtNgacNAyxTchFTzjzo5XjOAkXzd4AtDik2Lj913imU1/QD4LE0Jzev2IYZ?=
 =?us-ascii?Q?FQWXdceqMcv0IZhkrfVhNiMVty4x81gOXwTY16r8khnIE+5aD/I89Vhg7MEZ?=
 =?us-ascii?Q?9HkbAuvd/5TC0CBIJqwN28vlxNG0jMymcEXQG7Bqdtb6ffSK0QwjzABvE4Ww?=
 =?us-ascii?Q?Gyc1JSz6JMwrJ298K9aX79LgoUiCc9ADE18n+epJZvuW7fNoGuNr0L8c0QJ8?=
 =?us-ascii?Q?+BX8FsArE+DzHuCse44xJZOzNoxCl1X/hAF6h7iuhxksZqKSiYrhOAefVkxP?=
 =?us-ascii?Q?xjRcvf6Lu+M3/oceZP3LqNharnvuzipCEE8EwOIiSnnVQN1REPkh2aRpIPkS?=
 =?us-ascii?Q?XwiYGjCVsghThZ8vlJh5+z4PjubBcnZgFKtQxUiUoFQ90+KcLTUaHIZBICyc?=
 =?us-ascii?Q?ow8cHTaXDTHuxXeYpe09HxmCBFL43Jb7QBsx49mNY59sUJIYNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?668A8sIv/N8002JMc2o68+uFknZtZ57iAnLCMMtpu7BSUNt4Kva21P8PcXqY?=
 =?us-ascii?Q?NxH1GeB6//IdLjp4UdKjz2atap0p+z7A2tZbNep+JX/Bc86N4em5hiaKjdRx?=
 =?us-ascii?Q?JO/NjLNGQh2WklB5oEM2DhjjCNHCohRAqp6eClauNQ1DlKzYH5P/2AMjJGLk?=
 =?us-ascii?Q?cTrJco7otvi4G/kDf94V5S5ufOO8EFXcbIfNl3M5eHcHVzD4en9Y7XC8Wil4?=
 =?us-ascii?Q?33Tr1R2wOr4LpGvzxAro0ym4gbPev4Wmt2KPo6kLoo61SCkJQ3HdTp3aRMvd?=
 =?us-ascii?Q?tEmUaYfiJdeuK5JgMq+PhoBbKbfFjspNopSDsy5zEeENJtoHxsHzBAKhnjyE?=
 =?us-ascii?Q?IBsncqj1mXbbzF7mkVRO7j9CfYNcZ54LaHaiW9IcUvY6mklWOxkg41R3uHRz?=
 =?us-ascii?Q?opvWZezvIkoL3c1mV8VLocWa7sR77KlpMDK3y+zIPFqXPiGUhb1xmk7T82aP?=
 =?us-ascii?Q?7pO6WCRB/asAHW4fd67AiI1WnGxaYSoaRIPfIzzckseniGPx022BDaFX3Ve8?=
 =?us-ascii?Q?JjEuH3rdnSxPUWDBPlnC7GsjkiDMPEDEvW3tftTnhaXfOr5J49L6dG1hYkVT?=
 =?us-ascii?Q?Hfw3YM/q9niX7c7Mr9PRUpL337FMtMNRrzP7hPvhqlamLdjM4tW7PeRwJA9j?=
 =?us-ascii?Q?B7drNYXE5Xo/+Sl1CuhYgHaGe2K5JH/MwMzOprXnMR6vB0gUi5+UdGZLrval?=
 =?us-ascii?Q?3cIKnOv6OxfChHJ2A+wGiYUdf6H5Qps9lYhX2u9gx5Ek6qI98ot8Psl32Y7O?=
 =?us-ascii?Q?ZbxGQlUsr2E5PcoEIyrVPPT9jia8VWYpJW/01Fc31myi/4LkoZA4q9bNTvou?=
 =?us-ascii?Q?jo1lIt9X4d51IpAgI+wYdA2mUR9Gm/YMzhaQ+MztIsspixWoaAqx30E6wuU1?=
 =?us-ascii?Q?TqA2xRdDKnutAbjoOFUe1GVjwETUoI9A5HZ50HnNZOp3KnVC9SS5YT0Yp+8V?=
 =?us-ascii?Q?Ceh1TCHlBVNOQMJMfHbIKWqPSHN9NB4qy8RTrj9cA7KmS5MB3VuBLmLCNuA9?=
 =?us-ascii?Q?stx5Mtq3Rq5aauSyjK8r8XzgX45MAb1HMln1vtbikONGUWBqQdplVLo8FXXu?=
 =?us-ascii?Q?m5lXxZNW2M30yjsvAiqF4BZ1pt1oRx24881YH1tnM0gUZYWApIT/0CWJ+d+V?=
 =?us-ascii?Q?IJ714mCalvnavawP1+ReAbv1ZxkCRjnqTQ716BrfPuF8cU65ibj3UXo/O/iT?=
 =?us-ascii?Q?4VkFQ9KFymymkJ8Su2yMjTMmDG6FiSDIzsi/31qJ/sNeD33MWfP7yUWBAX63?=
 =?us-ascii?Q?UxuBPbd7Rc3Jv2Tk7PMapKk1EymHVw6AwCpOFvZR7nHpgkMEWavL4BhkAqLl?=
 =?us-ascii?Q?cUyfN1KwBRAV8IgPGQqTkDxnjbwQdmybtIxGZcwibVJciau3kQ2O1kvZmgfJ?=
 =?us-ascii?Q?V7KuyrxAKDJWvboWdONfjUvW7/996ZK76D59o0UYUYbAkNSoLssA6ATxDp9A?=
 =?us-ascii?Q?AD9gnulJ1DsCNJlIGQ5v5YiVgY0pwoEBqrZ4jOztGFUGPGHY7GTsyYuIBhvp?=
 =?us-ascii?Q?koCRXfkIHGaCg2J4FGAt6wI5xdUZhISFI0hHUCvNCf7NYb79U0E9K+bN0Ser?=
 =?us-ascii?Q?H1skYalEojxAqESiYMGcTz8QiRyFDLr8D8xEUQZF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c86c07-cd69-459b-4414-08dde72f040f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 19:05:28.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSVyUYD94V+nCVc5/Lb4FFKOG9lAfhwyj5GbsXIvhQanz2rx9k0/NXUSmQqD5ePH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489

On Tue, Aug 26, 2025 at 10:03:40PM -0700, Randy Dunlap wrote:
> > +#include <linux/iommu.h>
> > +#include "../iommu-pages.h"
> > +#include <linux/export.h>
> 
> Could you put <linux/export.h> before <linux/iommu.h?
> Does something prevent that?

Sure

> > +	/*
> > +	 * The aperture is limited to what the API can do after considering all
> > +	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
> > +	 * to store a VA. Set the aperture to something that is valid for all
> > +	 * cases. Saturate instead of truncate the end if the types are smaller
> > +	 * than the top range. aperture_end is a last.
> 
> Does "is a last" have something to do with terminating loop iteration?
> Is it inclusive or exclusive?

It is intended to refer back to the definitions:

 *  start/end
 *     An half-open range, e.g. [0,0) refers to no VA.
 *  start/last
 *     An inclusive closed range, e.g. [0,0] refers to the VA 0

Where aperture_start/aperture_end doesn't follow that standard.

	 * cases. Saturate instead of truncate the end if the types are smaller
	 * than the top range. aperture_end should be called aperture_last.
	 */

Maybe?

> > +/**
> > + * DOC: IOMMU Radix Page Table
> > + *
> > + * The iommu implementation of the Generic Page Table provides an ops struct
> 
> s/iommu/IOMMU/ in text (not functions/structs/etc.) where possible.

Sure

Got the rest, thanks

Jason

