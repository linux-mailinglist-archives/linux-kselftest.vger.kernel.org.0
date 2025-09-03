Return-Path: <linux-kselftest+bounces-40692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A26B4282A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5215666DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35257324B2E;
	Wed,  3 Sep 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FR11XCfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B861324B01;
	Wed,  3 Sep 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921612; cv=fail; b=CjDaYVLZANnLcUpL3A2Wz9TV/kZ+QqMO/5qYu0Nl0CNgssH/uffkSws5HIIjz9WzCWCskLHUobe09QCLY61ZRF43ycUAKJEHlbmzixNxKz1ph+zaqbx6eCwi6rEaQUhLL3VXw+O/vALUF/cEvv+ITsgzflKf2Nug0ZCa2VODFCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921612; c=relaxed/simple;
	bh=RL0NsY0RxrEb5Q1jf58nrmYNIELO/rULkPcoacSq0GI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gav+xY6lfyD9hhsa1CYMVfed5NIH9hGmhyrVxBKf58wCyUMG9+N5LS1b3P4ghqXYmQN6hxKQUxi41w57LS/Ilie7ZfkF0GUBzLoDjwDW540vLwldmaDYEKH0U8WfrEk4/XFbwWsyAKbVSC0P18s38+9djlxwrBR+I55R3VcLTgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FR11XCfK; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkjUtOK2DZ6fqPvrAJWus6/n0eWcsCuhIKWR9O3eLbBUvE7OYebXQtj4ezCdSzGeel5SGqwlXKf5N/ERIR53Vb7M4JiLBrCy785GgQ6+deUXu4W8YR4LVwjiBUbcyaX9n2hfsFRcpZ1lPw25XLWn53qyxbw6MliUVCMLsrYtKpU+0n/TuOxkFr/n0bRpQ4UYvBLCpDHQXV0J5zBhpNLIMG3rZB23gn7ZtVaGfg2LQBDGwp9942CgSpc8NT6AA/1UrYK3I+lgZTFAbAvzgzQoK5bP/uwICeYgAipvZdHmmEGkloGUV6+3gCmKffKhCXnXQrZ1ShKune3tMWAxNiaDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiOqe6TSlNZfVpfCukda+uanfdF0WsEhHzLsmiFDEwQ=;
 b=p+ooULOMqquUbRjOO1+4L9GIc091ihoiblvUdhdj7bkJWwqQP7GCEya+JemTXQI8nXpdZJM5Ueqz9zjMFy1Xl0qgTGZFitLfUzT9h/GLRQOATIzm0d2NuKPjwrrkFR7WcFLmfB4/3lpCO6zDzjh5G0FRhIyhA5clfgYpd3JdJF0swaKMzIHCNvt2Sh76iE1S6FdYN3HCYONVIMusdoH4keUCwNE6maiRlrRLgkNmwYfSSktaTuX8kJ0XCN88uXJcuax7ChbELKkDYB+TGJIwj5uamSK2duyyV6RQP51MQ1f13K/1NSM9+ZeBV+s9fuTGtB1CRF7JmLNF89rT0VxD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiOqe6TSlNZfVpfCukda+uanfdF0WsEhHzLsmiFDEwQ=;
 b=FR11XCfKKXeWrDzFe3ariIECej2c/MYi+PPKJooERzLVmURLNtH7qgLwslzrJyNxDAmfmuSw5ghz0oOhR+M1Y9j3iQwO7Hy0xLeN9Fgq8UaeKYIIHGt8wZHMLv35t3vMoJWG+e3qNE3neVwMsv8zf4DPIOxg1MkmYUsqFjlpk1G8DUUCci0JZxlR7+4b3NqD7zInnDAVyUxwiiIw+LEgb684+HJE8bjYIkqQq37519STvmkP3PM2eteOcY531ytFNhmeqWC0I1K+TdI6Idws6QYq/wpGJJm63vNF+zaEL6XleIbq6hocymy9z5f+jZF5xio8iKmoHaxZ1xvz/yoNoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:45 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:45 +0000
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
Subject: [PATCH v5 00/15] Consolidate iommu page table implementations (AMD)
Date: Wed,  3 Sep 2025 14:46:27 -0300
Message-ID: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d97a12-a0dc-45c8-2fc2-08ddeb11d8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V2xM1XyLENp/SoyyPie0bHsRVXZqfgZw6RMNnNx5I9kraXR1U55W+hDKxpH+?=
 =?us-ascii?Q?NQvSPDZK3IA4GIs+s/bNekamPT8H47VkzWfzpKGf36DvqTuxubqln8wWm3zF?=
 =?us-ascii?Q?IrH4BWVEIbZlHpaEjtd3sIj1QJlloC+eAXAa/fMwuziXwXTFSyJvtN7nzxlK?=
 =?us-ascii?Q?wrmLgnLjJFEo8L6Mxce4vN+2YvpTNUu1UflOHBXTA2gNV50EMa2npU2RCf/v?=
 =?us-ascii?Q?OhfI9OWCVVawb/SZ/XZA6qsjVwtzPdlA8agbgz9pnyNO1NgEqfbFOxAe8xxQ?=
 =?us-ascii?Q?h2QQeg9CusikOeY7YefKmR72FpM1zVoYVbQ/yRxYQWJUf4mQZM08KcqS5bc1?=
 =?us-ascii?Q?E4LNSO/e9HlyZbbj2pRZl1QwV4Hrk+E7aSDndyP380fX44Qc3Hr1NbwBHvVb?=
 =?us-ascii?Q?A14D63dqvPtDNH2K6IqY5MNqH9cVQ/k83oyhiKyd6tfbFXn2gx08LmjcSY1k?=
 =?us-ascii?Q?DE+89IfECxcY2ynqA+lGdHDhfEqaBUj5CuAlJtCmo7zVl52ycx0DWTVpbvBn?=
 =?us-ascii?Q?JsyAftKluwfYNhXfRIZFYju6CbvwcdMMLhEAl+m1ItZIg80QHLNTIDjRsMCT?=
 =?us-ascii?Q?uQIewTYxZC/1STf7JrOfadEe3eR2Pec4OBsk2UFPTPe6hZ6aZ1rc67FGUkfN?=
 =?us-ascii?Q?wa1Xk4IK9Xghww9/02VbUgJlBiT4ZEerdpL4XCNP/OLokxVrPnToKoONlVPI?=
 =?us-ascii?Q?p41ZLHPg0VqQJNYA6U7MK4iFUWEnZ5TxUcZyGyWb/mR16lp6KKZ08Sxc+jWc?=
 =?us-ascii?Q?vwwDkUabOOlENMmQeYfCWUDv9qNU9IDsB53zh8SJZPo0/kXCU1esuuXQ7itx?=
 =?us-ascii?Q?gWe2uu5TettIrQA8N6XG13xi6fQ6TPK+msjbt0yBEmcUF/mczOtL/DkVrOCj?=
 =?us-ascii?Q?t3+n9kUz9627Y5Ai1nSkDwNJzyL0sQMwcHosqIvPhDCSDI3Gfm1fCO2lw6SL?=
 =?us-ascii?Q?q4sz8q8ZGVL9t67ZvI1qY0NlBMvBcGeMiv4YEOrxtKKhV7xa7XhIM+mMlFvW?=
 =?us-ascii?Q?pw+Er2ZjhR2eFeGzBZ/akU3LTnr8t/8DO37J+2SMvveyVUS14/FESQrHyJCe?=
 =?us-ascii?Q?4JZnKmkIN0YYigH9s1zDa+/eB8WhlsCUpSlw5BC/prD9cKdrpYZF/Qa9WofV?=
 =?us-ascii?Q?uLKHAUW+fNjT8qC6D4S1mytKohFpbA0S95Xt/jwBftJc5XlI8GJH2fqA6uT1?=
 =?us-ascii?Q?8hBDrVGwio6goox8/GD/PhuE6KDa4jVAziSBjTtxV7VxoaOcBLNKA4NmYwIH?=
 =?us-ascii?Q?DTWVXUDpn0Sn/dHqd6eyYKvNy21nl4K1fmJkv+nn8aCqWq9Ufy5eaIFu2Or1?=
 =?us-ascii?Q?HpS/g1PMNpHVC8+ASAFMZcMKCau+LqyF7y0Xhpr/p6dEphpFL5AsGTnU8GvI?=
 =?us-ascii?Q?+JT6QMD9oJfA5OfBLwZpbLxHyxjyQhzaVJWLpOiuRfzeFTz2U3RnF8jMCLmJ?=
 =?us-ascii?Q?IFhmhEBx15Qmj8CK6CJLxA21Nv4yEEZRapuyZ1tXURr78uAIB3KpEAJ96rcy?=
 =?us-ascii?Q?u2jVDH9ux1F1uuM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gSwdkSACX9uiUgn629QmYhl35yiYli1S8wsTXGhSxtha6s1EX33HUNUMzOty?=
 =?us-ascii?Q?pBOrebrr5Mur3f1r5Vk1XntcSPDaYxsaTcxaL/WwoZGugFWfgI+ATdrvmujV?=
 =?us-ascii?Q?Ev8669ESCK7obY6r9Oz1MbCDYkZkR5jaXlMXhrnNvqm9B03RUUILqkRUg/O+?=
 =?us-ascii?Q?PuD5P04LlisFdl/7ufTMn/Iez+qfg9cqF5s8hSwNK7c9+PR9mog9/p2lblJD?=
 =?us-ascii?Q?L6DsC5iqYl0Wa9Gmxx1UfUY1G0pD6xudKmfgfNKzQN3ILAk/u3iOvVPaZp7R?=
 =?us-ascii?Q?XP/xyWmJ0RNpLejRclefh72tig+bBYfmP7c5s5Wbsgf9LSH4FkRchsd6+Y5Y?=
 =?us-ascii?Q?M4D5p5TQkIkE/w76U9NEglyfdP/sQ+y11Guunwxuqu/v+Adb55R9+hB41sQD?=
 =?us-ascii?Q?FBKoWNqw9jUUWUQ+xnAT3f5iEsDVAZ1NNno6ZyfstnadTDqNDFXeZPoPEj1f?=
 =?us-ascii?Q?vyAn1TlelVxw97s5e+tmyHXs92JnliG9kt/C2aH45HcjeGxejr/nj763RExk?=
 =?us-ascii?Q?enfMrvZvHLg51E8bnK8m7PpROv9nO2BJwfs2ZxQnPc1CYZT7q9qP1XkEzuPF?=
 =?us-ascii?Q?JlGAfXKY79YztbTyU5LKCUlkhyMi3cgigDv1W4iM/TvXCAqD3bFJWEs0jPU9?=
 =?us-ascii?Q?BSeGieSkjwifb5xdiQ4vp2yN9sGhf6cGE7tUqgXSoXVqwAPWcSyeryzA1umL?=
 =?us-ascii?Q?wiN8fI5A/NvLAIovddM4UMVPVqR66BZLDgPvyF0ifsoeTqUdXuymaUnhOuQn?=
 =?us-ascii?Q?+yrUp5CMmwnnuwOS0b/5d+9k+yH1sIbhQ8nm0gzNAtdLTcY+m18/L6+KmquW?=
 =?us-ascii?Q?9Luju9TIlK6QbClp1vaGsHF/I2DleSUdw01bJoyB7WleXLUFOZBtfx3DSyWS?=
 =?us-ascii?Q?oTxOzYdI/wmTgGZMqadeiltic+IaUDXHsP5M8Rk6ImgGYPA25y2RQW3i+OE9?=
 =?us-ascii?Q?JrnS8amMjYjyo8EG6tC7QBwZOsEu0ImC97ts6CaTxztlk+4Mzk+EDngOeZbC?=
 =?us-ascii?Q?wm+CVTWHJYFCds9mKiTxUKzyAxB8ZLYlk6JLiSTP2pQsdQNqxLNc9pofjjx3?=
 =?us-ascii?Q?cwVO6MkzQaU6XYB/nSSHsLb1YKGx4ka4ikEy7n4efmRmCDEucMWnRQJ1VS6J?=
 =?us-ascii?Q?ghEVTTy8LYx1m+mQngPtbB6YpmKBF+kwvDD/UjRs8j4DkFpURQgoQRjQhkBy?=
 =?us-ascii?Q?Z1QXPSMA43VYhkFP8bNg+TKBmnpH1Fdo+G053rc1dxackHlXGaRoAcHSQZ72?=
 =?us-ascii?Q?I/VHg/YlvTf/J/hKHfE2/O/mmfAvV8NLjnJzJMYJMnwPo2U18lnXnJ5zz2mD?=
 =?us-ascii?Q?fV/grJiKtADmlCowOl/cwJsdz9zQPFiykYh4mPrTXQI051DWPrTrT06rmX57?=
 =?us-ascii?Q?bz4L/sDMtY3WtLqcIlS08yfW9RjldCBqPy4Ayx2kqy5BLDqAbjJ19BYkIKfE?=
 =?us-ascii?Q?FsWnv/AmSPRyC3fL2MuhO7otrTSAmL297YZt18HJlUyuG9UPf5McIN0+77MU?=
 =?us-ascii?Q?QNZlCXNBQKr0nN1FYDtBCobDAi9KzmtciBC7RGaEMlODoiHdwg3NlGIP/LZc?=
 =?us-ascii?Q?jPYRZ8DQgJ9enedcK0o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d97a12-a0dc-45c8-2fc2-08ddeb11d8c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS+nnXCCpEyZWXIV4oAmV5EtymC7BkI0/THg5xYR4uhVU7y4cjJoIZuqB/+relzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

[Lots of changes in comments thanks to Randy]

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
 - RISCV format and RISCV conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_riscv
 - Support for a DMA incoherent HW page table walker
 - VT-D second stage format and VT-D conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd
 - DART v1 & v2 format
 - Draft of a iommufd 'cut' operation to break down huge pages
 - A compare test that checks the iommupt formats against the iopgtable
   interface, including updating AMD to have a working iopgtable and patches
   to make VT-D have an iopgtable for testing.
 - A performance test to micro-benchmark map and unmap against iogptable

My strategy is to go one by one for the drivers:
 - AMD driver conversion
 - RISCV page table and driver
 - Intel VT-D driver and VTDSS page table
 - Flushing improvements for RISCV
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

v4:
 - Text grammar updates and kdoc fixes
v3: https://patch.msgid.link/r/0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com
 - Rebase on v6.16-rc3
 - Integrate the HATS/HATDis changes
 - Remove 'default n' from kconfig
 - Remove unused 'PT_FIXED_TOP_LEVEL'
 - Improve comments and coumentation
 - Fix some compile warnings from kbuild robots
v2: https://patch.msgid.link/r/0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com
 - Rebase on v6.16-rc2
 - s/PT_ENTRY_WORD_SIZE/PT_ITEM_WORD_SIZE/s to follow the language better
 - Comment and documentation updates
 - Add PT_TOP_PHYS_MASK to help manage alignment restrictions on the top
   pointer
 - Add missed force_aperture = true
 - Make pt_iommu_deinit() take care of the not-yet-inited error case
   internally as AMD/RISCV/VTD all shared this logic
 - Change gather_range() into gather_range_pages() so it also deals with
   the page list. This makes the following cache flushing series simpler
 - Fix missed update of unmap->unmapped in some error cases
 - Change clear_contig() to order the gather more logically
 - Remove goto from the error handling in __map_range_leaf()
 - s/log2_/oalog2_/ in places where the argument is an oaddr_t
 - Pass the pts to pt_table_install64/32()
 - Do not use SIGN_EXTEND for the AMDv2 page table because of Vasant's
   information on how PASID 0 works.
v1: https://patch.msgid.link/r/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com
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
 Documentation/driver-api/generic_pt.rst       |  140 ++
 Documentation/driver-api/index.rst            |    1 +
 drivers/iommu/Kconfig                         |    2 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/amd/Kconfig                     |    5 +-
 drivers/iommu/amd/Makefile                    |    2 +-
 drivers/iommu/amd/amd_iommu.h                 |    1 -
 drivers/iommu/amd/amd_iommu_types.h           |  109 +-
 drivers/iommu/amd/io_pgtable.c                |  560 --------
 drivers/iommu/amd/io_pgtable_v2.c             |  370 ------
 drivers/iommu/amd/iommu.c                     |  538 ++++----
 drivers/iommu/generic_pt/.kunitconfig         |   13 +
 drivers/iommu/generic_pt/Kconfig              |   67 +
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  409 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   11 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  248 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1149 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  717 ++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  451 +++++++
 drivers/iommu/generic_pt/pt_common.h          |  355 +++++
 drivers/iommu/generic_pt/pt_defs.h            |  323 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h    |  193 +++
 drivers/iommu/generic_pt/pt_iter.h            |  636 +++++++++
 drivers/iommu/generic_pt/pt_log2.h            |  130 ++
 drivers/iommu/io-pgtable.c                    |    4 -
 drivers/iommu/iommufd/Kconfig                 |    1 +
 drivers/iommu/iommufd/iommufd_test.h          |   11 +-
 drivers/iommu/iommufd/selftest.c              |  438 +++----
 include/linux/generic_pt/common.h             |  166 +++
 include/linux/generic_pt/iommu.h              |  270 ++++
 include/linux/io-pgtable.h                    |    2 -
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 41 files changed, 6128 insertions(+), 1592 deletions(-)
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


base-commit: 8da0d63bd5726ff656bfa1eacb45d6f5cce65616
-- 
2.43.0


