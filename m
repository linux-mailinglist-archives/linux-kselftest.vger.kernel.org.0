Return-Path: <linux-kselftest+bounces-32346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4ACAA9554
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6ADC7A3841
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA38259C85;
	Mon,  5 May 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bp5OXcPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AC259C80;
	Mon,  5 May 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454734; cv=fail; b=ieLXo54NPhb5oH9HYu2VERASwXulZ85WXcwRXAzvcLmlH/+omRwgQIOdtxZ8CzocpsqXad7VI0vLTohQ7yLZkzO12pVClJ/SrPDpNXF6/INcBlym9tTe/vrn600CMDmXbiz26WITF81AdJ0Om4EukoiXuVJ63Mx+eUPwGTE5mLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454734; c=relaxed/simple;
	bh=F//Gj6GDMPky53N8iH8tJHN3djtoHIJCjy5MZg+89Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CguS9jOhSR2iWbDEPky/9kToJrxmooWjPQ6okM+XLrsRD3or6m9xU5x1iddiNqQbtKvuJTNVpYUT8ellQiLr9/nIEklKtRboI31FJCx3qQz2NmodyHjSPIoWJHBCO6XHAJI5ybom2hW6K32enExFGbrmnZDgi3zh7juSkHH3uEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bp5OXcPs; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoYyXbmSOIOCaLJVpvFBtmIg70D4PoBipIsLB+XFgeJatr7+CGnWSBJmstR5zMNBFOvBe3IAVo+aQfY6zWfcP6Jj9OzoCYFxds2fXWo53bxx4TRa4CL936PFwBh/xkgE/Y2vXYWL4/XXk2BHfFmCPbmcX3icXjLE6kC+UvPHKLZtWl8nTqAvs0fuJ5S24lhvBkwUxtoDbnDrK2cvNWsQw7lKDmr+CJ0Fk8ZCz8UxKIaK9+Xx6ndZVgegEJhZd+uenltZKEiSmsbD7fL1jHB8pckDI4cRlRr53buWMI/9HzGRZnNZ98k5yCzH3d+veLPF8pUMrN+JiDA+4UI79x5XbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h01+zx7bVwx+plWyYqNLteqVyifcR558OB99cYkFbuU=;
 b=db6aEK75EGuIs4lDt9ctz8ccTUREsfUPBH1DzKYyXWsS+rjsrU9u2Rju50HTKyjksGXOuHUF3EQdjzBHc6wTQDmcUnkF8IGL77F09KezI4yCx5bQocSJ7P/QwabwZDQaHSjOABrVgJ0GOhjtnxhnymYtCiLEINXjRssqJdfRG9SXUV+hfPGn4xKmmGirIhieQIu4WDdIiu3n4nejGSjjf2S//YVx16TVdbGXAanw50JAu88m+ZGpIaVRVJG+gsnqECzaU25QWbzJaUrpOZCrEKgw6vOW/mBLuSQKTRvNQmYH+c4etRSw8Bd1rqiseivUZPKVOVQeF5/RGIzdHhYRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h01+zx7bVwx+plWyYqNLteqVyifcR558OB99cYkFbuU=;
 b=bp5OXcPs6eaThVS4Fl2NXA08EbXibhXs2MMXirxHrcjUHlx9OxDx4scjSHHDbQA2gk/vVsuJ3yZiVBV1dGzzcGE8YwWDlZZueUhuzwYtBVhSdXMkH4NahjWXhLibI3pxhwpt2hzRMP3sm3ii3p1ctIAo2oAcxAwk/8Ynzl4IwD0z1wESgPhRrnKOmanoyLk0j3JRtNjcnphb4TsJLR4xCaWkNiTVQA475KcS8q+SKAnHIueKAl6iNxVACuG+Rjzkb8wmofu37vPsZ9vyxZxAa782/zVDEVLOcji4czjxciVjXwACASyM11ux+1HOFNLcY3dwIXLMnP3ASin7HMQJ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 00/15] Consolidate iommu page table implementations (AMD)
Date: Mon,  5 May 2025 11:18:30 -0300
Message-ID: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:408:141::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fb8fa3-8aac-4da9-0254-08dd8bdfbf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+DrR5xq5dUSfgWvk8OamLJz9sZS1Ojy4c0izGhZTWAhevdqDDtnAl+NhB4K?=
 =?us-ascii?Q?AbrP8P9jswFKPEG5Zznv6lFAronXTGlVcbOL34uc5yreqn16gX//wZSMG+ov?=
 =?us-ascii?Q?PU4TYJbZxpP9kuhS6UHm3rhovk9g39A2V27nV4DlfzyDKk8hCG1uGwICvPnc?=
 =?us-ascii?Q?uOf+GvBlqgtpq5nb0/X3I5uhGQUKD18L1IgnxEbUP9O+melU0lRGYZeY+mN+?=
 =?us-ascii?Q?05bHUiQj2RHMxNRWaycqihmj3LzHs9Nz6MM8JYUYZavlr0rMXrv4iUmzpISM?=
 =?us-ascii?Q?F+IGuDO8XyXVL26n4/KAEplSgC6OqQsM7779zlZZhZ4NOsyawqBGzbqX/6C2?=
 =?us-ascii?Q?GaF60+oN4twLm/XmL+tMj5WXhI98t/lBxpIGUgWGZ7Rjpeqs1BsRZQxRrppF?=
 =?us-ascii?Q?5MguSqQmCFQylSdFNRs1tQu9zaTU/6PKSbrOFlEt1OUkQx+VrAQ8ekCtux11?=
 =?us-ascii?Q?HEQT1PYSj0Y4smG595tAXejrpA+TTUjDi41U4FAdb0zdKIHrH7kXp+wEoZUu?=
 =?us-ascii?Q?cguLKUw85RUbKvt8CqYA4MlF8RVC5TGPd5EAp7Ff6NxAyqlJidOk4W275D/F?=
 =?us-ascii?Q?6usBbRFbmntCcK284EM7SNzAYIYX5Yb+19PAAQi5JXRBjhJbUQOal6y+x+fU?=
 =?us-ascii?Q?vjXnslCl+XluQNxDZeHVFZLv6p8deJXjH9KU1HFS06/+KlxTg1TDzZFkLsHt?=
 =?us-ascii?Q?d4J3E6hX3DaRzB/d1IUHP5sLHrYIjX2vb5woaH/1glmZhRZS+L4BtudQGygh?=
 =?us-ascii?Q?tPJn7IQITKPEDP87YADaV6dBS/ZDnv+Z8P6h52N4r6rQRDuD0ds2QO4Ijokj?=
 =?us-ascii?Q?jY20N/8zZJMVdhSQQeBWbnchxnYFWbAVW7wPbS3wNbelLtaFgQz4+m0IQufx?=
 =?us-ascii?Q?sCycqOOwBxuVtHVrJ6hBwi4wuI8BXhO+e3UDZOVlZLHUIEGP/p4jAafd6+yN?=
 =?us-ascii?Q?AlQfSNkft50H5YGiDsRYcHNKZ0+Ujjv614XFrSRqo6I6o5DGDKCde2p7PzxY?=
 =?us-ascii?Q?TNjHjrOsCf2Y78xbqvanAuaEiexdrrYdPcFoJak20MuuqIBctJL4G8XQ8WDb?=
 =?us-ascii?Q?R1otK0F6g0atcSogMkIUnYSJ2WB1StE0oovl01zV5vuN1IitIEXzFyQ8dVKm?=
 =?us-ascii?Q?9RwLWaf0Q5PJp/F5xVxwOLZY3qdAZyjmevLr/cb5z8NWqiH4zpUmh+xmx5tM?=
 =?us-ascii?Q?xTVU4veiLsarOmbJGMbQXD3W0R4VLhFCo6Ted848DKVcB4sG8VOFLfG4ffeP?=
 =?us-ascii?Q?zTjtvX4OfiCpf/gisIR71Zc+VUnIDEKxOq6xDqq0y+drdSD8uuO0YBFW6hpn?=
 =?us-ascii?Q?GcwMf/uea+sx3lMcdPwf1aa/s7WdlRhJTNxmF3XlhRcc1gEr6oVeol/pZZ7q?=
 =?us-ascii?Q?Fv0qJXaLAU+MNyLNKihi+UOqT+vGcF168atgRgrA9Suyl/c7nXRR1WP9IOXr?=
 =?us-ascii?Q?DXOkRyd4W9W/E9ZkrPtoDBZF8n3k9hz4k8SmXaKn5+jqJB1ihTTMha7R4q4k?=
 =?us-ascii?Q?jBdTcm7rdLx5hhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFLxNqXZjx8ZKvjIn5t6/jm/IVZw99JQsC1R+ABc9PUsbcz2JOofQwvyp3WL?=
 =?us-ascii?Q?9uxAzVKge8puBlbmAgdkzMrl8XNoywEaCJTuDRAeFd0TrPB8uTT6/Cyf+/Ja?=
 =?us-ascii?Q?CjawLX9isaHCjdmoLHV1KSDRu7WR7EYIYmdhhB/zXfMcYaX11Y4rsyxyr2N8?=
 =?us-ascii?Q?Oodox+D6rH1XUdGQ7zttnmcxKnLrXQE+ndFOclvsf6ZXSongqCtRzRO6lzS7?=
 =?us-ascii?Q?m1IOnAuaXeWkOdsTAgAtyWF5vxC/4bufyQulCFhdLdQg3ydOQhvIacy6BsI9?=
 =?us-ascii?Q?7nOdFSYIRx+5JYTN6HOsYZxcXLeAKM5xNVwWJxY+FL9sRsFbJTkHDIqzHRNb?=
 =?us-ascii?Q?5UR3V1EF3fj7Bi+netLL2sWifRnOJl0VgRZ5tHgfW26TRnAs53+vmD409vjk?=
 =?us-ascii?Q?rQUiPKZ0DePH31ns6B1/DYIT5foti+BUOA3OAkTd3QALDrU6cIMvV5TPmv3w?=
 =?us-ascii?Q?4B8mzhGWyhmPc90Qd6GYYqw5Th0KgGBSJb9vMlDdnpjUiAVXcgq/xkmaLtab?=
 =?us-ascii?Q?5C8sSgQs5LkLMlPy4L2HLyl7UBH4fHhK2HWSJtRWxwnY1sd58rsX/VV2trpj?=
 =?us-ascii?Q?rfBkHTmTh6U/dek2eEkMZDkKZnhEbplQYMR/UI7P2to+4O9SCf0dTNdrCzlX?=
 =?us-ascii?Q?6AVhWDYmTjvEXHnQ2Cv6NOGw/SvnL/jcZh/6+0nyoSsrGBGeIT75MF11d3L+?=
 =?us-ascii?Q?AEqN5dIrATgQKzxgYpvnE1+3y6srqEQNMSz2C+man1s+hec5pIoXJNXYFjCL?=
 =?us-ascii?Q?wi/OY1s3w7nq2Gh66NA0PWE6+Nyg4Qx66OpqJ2yWDAoY0Yh/Z8nRjl5MKD+J?=
 =?us-ascii?Q?zg6QBV+OhVSUI0SoGtAnXu2fao0A3SfrL+1vnpqmH4F5czRpIWwPrKJXEl2+?=
 =?us-ascii?Q?Ge0tQz/3xo5yxmS0aCS2wPJj3noM4Wh+fal4L96uYTevQEReozApDSX/cz0k?=
 =?us-ascii?Q?wPh6e4i80bMNXT9RxQgvxHRQgJZx0NZdp0WRbGl6GzwNayj0lqQm+YO0LSc8?=
 =?us-ascii?Q?3W96XzOU6ac97cuD18Vy92LF8GIc8gYeHsVm/5q7zM4H+fnb624D519Gmhu7?=
 =?us-ascii?Q?C9epkL74Gn843TD+76miI4mer08brRkJIkQ+dRrnylgH1EwoInZl/wHWBrBA?=
 =?us-ascii?Q?5459WNwrFNw8bL0QGEjaF0D8svVz2a/LTMCyyWhKLWpSrrptmc6TjSipus6l?=
 =?us-ascii?Q?v4AmgoEfb/lqn9nAdHYqCasTFGjZqUSGgYQ9nbbuGloc5HB+QoklnMLJHRGu?=
 =?us-ascii?Q?pXXk/9U469W5syozCgOiREPgkm7vU8/XSl1O75EcwFpbKJCz5melf+sKzQG4?=
 =?us-ascii?Q?+l3G0IrGZzvFB961HL0YQeciMWLdRARJaq9CbMN73SPvxq0WTgNoP2LQ+rgW?=
 =?us-ascii?Q?G+cCtTazF6zBZI7TOZJuCdU81nEeD9dxO9yE99IM7SRl6DCdwIhkkAkPwTML?=
 =?us-ascii?Q?gwlQZCH83JdjwoOujUY8xx6v6APmn3lEPQ4WvnRUpJHxt3bkAUBwpmZFtXl5?=
 =?us-ascii?Q?Brt8VZ9VdnNnlvlKAadtfXp48UfQopbRGg577mAp25dmgGxSjo0tX4u6UhCg?=
 =?us-ascii?Q?vRg/qUPH72XeNwkSaTmXe06qjDWL3Y/7pmbIE2Dl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fb8fa3-8aac-4da9-0254-08dd8bdfbf75
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:46.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQIyUYGIVcY51z1+lL214fyZi+JLL5+WJof9KsUGSPr5hDPazu/ZpICMctskdflM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

Currently each of the iommu page table formats duplicates all of the logic
to maintain the page table and perform map/unmap/etc operations. There are
several different versions of the algorithms between all the different
formats. The io-pgtable system provides an interface to help isolate the
page table code from the iommu driver, but doesn't provide tools to
implement the common algorithms.

This makes it very hard to improve the state of the pagetable code under
the iommu domains as any proposed improvement needs to alter a large
number of different driver code paths. Combined with a lack of software
based testing this makes improvement in this area very hard.

iommufd wants several new page table operations:
 - More efficient map/unmap operations, using iommufd's batching logic
 - unmap that returns the physical addresses into a batch as it progresses
 - cut that allows splitting areas so large pages can have holes
   poked in them dynamically (ie guestmemfd hitless shared/private
   transitions)
 - More agressive freeing of table memory to avoid waste
 - Fragmenting large pages so that dirty tracking can be more granular
 - Reassembling large pages so that VMs can run at full IO performance
   in migration/dirty tracking error flows
 - KHO integration for kernel live upgrade

Together these are algorithmically complex enough to be a very significant
task to go and implement in all the page table formats we support. Just
the "server" focused drivers use almost all the formats (ARMv8 S1&S2 / x86
PAE / AMDv1 / VT-D SS / RISCV)

Instead of doing the duplicated work, this series takes the first step to
consolidate the algorithms into one places. In spirit it is similar to the
work Christoph did a few years back to pull the redundant get_user_pages()
implementations out of the arch code into core MM. This unlocked a great
deal of improvement in that space in the following years. I would like to
see the same benefit in iommu as well.

My first RFC showed a bigger picture with all most all formats and more
algorithms. This series reorganizes that to be narrowly focused on just
enough to convert the AMD driver to use the new mechanism.

kunit tests are provided that allow good testing of the algorithms and all
formats on x86, nothing is arch specific.

AMD is one of the simpler options as the HW is quite uniform with few
different options/bugs while still requiring the complicated contiguous
pages support. The HW also has a very simple range based invalidation
approach that is easy to implement.

The AMD v1 and AMD v2 page table formats are implemented bit for bit
identical to the current code, tested using a compare kunit test that
checks against the io-pgtable version (on github, see below).

Updating the AMD driver to replace the io-pgtable layer with the new stuff
is fairly straightforward now. The layering is fixed up in the new version
so that all the invalidation goes through function pointers.

Several small fixing patches have come out of this as I've been fixing the
problems that the test suite uncovers in the current code, and
implementing the fixed version in iommupt.

On performance, there is a quite wide variety of implementation designs
across all the drivers. Looking at some key performance across
the main formats:

iommu_map():
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     53,66    ,      51,63      ,  19.19 (AMDV1)
 256*2^12,    386,1909  ,     367,1795    ,  79.79
 256*2^21,    362,1633  ,     355,1556    ,  77.77

     2^12,     56,62    ,      52,59      ,  11.11 (AMDv2)
 256*2^12,    405,1355  ,     357,1292    ,  72.72
 256*2^21,    393,1160  ,     358,1114    ,  67.67

     2^12,     55,65    ,      53,62      ,  14.14 (VTD second stage)
 256*2^12,    391,518   ,     332,512     ,  35.35
 256*2^21,    383,635   ,     336,624     ,  46.46

     2^12,     57,65    ,      55,63      ,  12.12 (ARM 64 bit)
 256*2^12,    380,389   ,     361,369     ,   2.02
 256*2^21,    358,419   ,     345,400     ,  13.13

iommu_unmap():
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     69,88    ,      65,85      ,  23.23 (AMDv1)
 256*2^12,    353,6498  ,     331,6029    ,  94.94
 256*2^21,    373,6014  ,     360,5706    ,  93.93

     2^12,     71,72    ,      66,69      ,   4.04 (AMDv2)
 256*2^12,    228,891   ,     206,871     ,  76.76
 256*2^21,    254,721   ,     245,711     ,  65.65

     2^12,     69,87    ,      65,82      ,  20.20 (VTD second stage)
 256*2^12,    210,321   ,     200,315     ,  36.36
 256*2^21,    255,349   ,     238,342     ,  30.30

     2^12,     72,77    ,      68,74      ,   8.08 (ARM 64 bit)
 256*2^12,    521,357   ,     447,346     , -29.29
 256*2^21,    489,358   ,     433,345     , -25.25

  * Above numbers include additional patches to remove the iommu_pgsize()
    overheads. gcc 13.3.0, i7-12700

This version provides fairly consistent performance across formats. ARM
unmap performance is quite different because this version supports
contiguous pages and uses a very different algorithm for unmapping. Though
why it is so worse compared to AMDv1 I haven't figured out yet.

The per-format commits include a more detailed chart.

There is a second branch:
   https://github.com/jgunthorpe/linux/commits/iommu_pt_all
Containing supporting work and future steps:
 - ARM short descriptor (32 bit), ARM long descriptor (64 bit) formats
 - VT-D second stage format
 - DART v1 & v2 format
 - Draft of a iommufd 'cut' operation to break down huge pages
 - Draft of support for a DMA incoherent HW page table walker
 - A compare test that checks the iommupt formats against the iopgtable
   interface, including updating AMD to have a working iopgtable and patches
   to make VT-D have an iopgtable for testing.
 - A performance test to micro-benchmark map and unmap against iogptable

My strategy is to go one by one for the drivers:
 - AMD driver conversion
 - RISCV page table and driver
 - Intel VT-D driver and VTDSS page table
 - ARM SMMUv3

And concurrently work on the algorithm side:
 - debugfs content dump, like VT-D has
 - Cut support
 - Increase/Decrease page size support
 - map/unmap batching
 - KHO

As we make more algorithm improvements the value to convert the drivers
increases.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt

v1:
 - AMD driver only, many code changes
RFC: https://lore.kernel.org/all/0-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com/

Alejandro Jimenez (1):
  iommu/amd: Use the generic iommu page table

Jason Gunthorpe (14):
  genpt: Generic Page Table base API
  genpt: Add Documentation/ files
  iommupt: Add the basic structure of the iommu implementation
  iommupt: Add the AMD IOMMU v1 page table format
  iommupt: Add iova_to_phys op
  iommupt: Add unmap_pages op
  iommupt: Add map_pages op
  iommupt: Add read_and_clear_dirty op
  iommupt: Add a kunit test for Generic Page Table
  iommupt: Add a mock pagetable format for iommufd selftest to use
  iommufd: Change the selftest to use iommupt instead of xarray
  iommupt: Add the x86 64 bit page table format
  iommu/amd: Remove AMD io_pgtable support
  iommupt: Add a kunit test for the IOMMU implementation

 .clang-format                                 |    1 +
 Documentation/driver-api/generic_pt.rst       |  105 ++
 Documentation/driver-api/index.rst            |    1 +
 drivers/iommu/Kconfig                         |    2 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/amd/Kconfig                     |    5 +-
 drivers/iommu/amd/Makefile                    |    2 +-
 drivers/iommu/amd/amd_iommu.h                 |    1 -
 drivers/iommu/amd/amd_iommu_types.h           |  109 +-
 drivers/iommu/amd/io_pgtable.c                |  560 --------
 drivers/iommu/amd/io_pgtable_v2.c             |  370 ------
 drivers/iommu/amd/iommu.c                     |  493 ++++---
 drivers/iommu/generic_pt/.kunitconfig         |   13 +
 drivers/iommu/generic_pt/Kconfig              |   72 ++
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  407 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   12 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  241 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1146 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  721 +++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  451 +++++++
 drivers/iommu/generic_pt/pt_common.h          |  351 +++++
 drivers/iommu/generic_pt/pt_defs.h            |  312 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h    |  193 +++
 drivers/iommu/generic_pt/pt_iter.h            |  638 +++++++++
 drivers/iommu/generic_pt/pt_log2.h            |  130 ++
 drivers/iommu/io-pgtable.c                    |    4 -
 drivers/iommu/iommufd/Kconfig                 |    1 +
 drivers/iommu/iommufd/iommufd_test.h          |   11 +-
 drivers/iommu/iommufd/selftest.c              |  439 +++----
 include/linux/generic_pt/common.h             |  166 +++
 include/linux/generic_pt/iommu.h              |  264 ++++
 include/linux/io-pgtable.h                    |    2 -
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 41 files changed, 6046 insertions(+), 1574 deletions(-)
 create mode 100644 Documentation/driver-api/generic_pt.rst
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c
 create mode 100644 drivers/iommu/generic_pt/.kunitconfig
 create mode 100644 drivers/iommu/generic_pt/Kconfig
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_generic_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/pt_common.h
 create mode 100644 drivers/iommu/generic_pt/pt_defs.h
 create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
 create mode 100644 drivers/iommu/generic_pt/pt_iter.h
 create mode 100644 drivers/iommu/generic_pt/pt_log2.h
 create mode 100644 include/linux/generic_pt/common.h
 create mode 100644 include/linux/generic_pt/iommu.h


base-commit: db37090502f67e46541e53b91f00bbd565c96bd0
-- 
2.43.0


