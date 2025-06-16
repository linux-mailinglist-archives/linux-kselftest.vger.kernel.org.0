Return-Path: <linux-kselftest+bounces-35131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A81ADB86A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ABD3A901F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB7289351;
	Mon, 16 Jun 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SmQndk4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3D289355;
	Mon, 16 Jun 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097194; cv=fail; b=tACyX0dZXM1Xg4Ulwa6TZhVAq3dsQ0C9Vu9EP4vCAwFpiRnqTyhwuUlaPjKAFvdKLHsXD9iNaN3uQBy5J5dYECqin/AzwPQARBMOa6bUpJmWBRJolTrrlrAmfzW/1JfahIaHkepBOtE3CSwZ+16QMDJQjmEZvlDYa8CKnVVg1uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097194; c=relaxed/simple;
	bh=EIpMQr92Om+3mS0ln22lbDlPOQND3qkKZyiKBmIa5tU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jrJWshWDxVN4sHDt8Cw+XL694H3TgdlWzZ1o0sSZfaZDGpwHSVE9t3czHZbW5kOSymIgZR6UG8MHZQftiLJdh9fX/mAKs7mF4DYr4Rq2t+JgJjdkSXB/y+50SK+FqMuXJWqU5vqUTax9sY9meyFWSI03rp3C2yYmlFedQTR0TXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SmQndk4L; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzotTx2r/4VZJdWYRajXmJlr3H7/ZLdl7KdnEUX6UjekGipgAg9jRTNtGDwJPY1Gt/bgwMFBP3WGUOLJ8+ZAosHsfNJy2YMG0n9yOHdQBSmqt5k5gAK7Rr/U6bLgO7ZwzidsNZY1MyXR/cS9U7c7otUtSAZr+LHNsYCIHPZzeJTEcBuP2HLSjEbvq1OuAUdXjL9s4LFl3i8OOAbVgbwJnZ5cOSbbdk3JFAIVGHugupjXagBnR59kW6aGNR7nmJN/Vaq7+BOXlJCf5tmbtEmKVhbr/7nMViLSwJTwdGq7buoy/1qyM9MxU83PiwozRS9NUkjZzFVMukHKwdTsinumRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8M5Nv+5c0JvUe8QIOGPRFDWPV5X7Bmo4uAt5XEQJms=;
 b=aq0MFhu/adcLaE+3Bvd642n9LPqVSgooe3fkD5e5nlonjOyDIbnzQosIypmwCNPoZx8znrVSmK3UHrTYbdHhHFdhHe9uMBRh+oWFGU1aYc+6VHYQsszqXmlaLFwOTu3SbOsT7Q0vo+oz7MdkquVmCv0pEyQFo37vRCLVejOzscH4SDEQDOiUEUrXaeYhhYZYmsp2H4hnAyqi/MK1WdXXTfwgPAVDdCB7VH8OwpD6N3uGjkL/s6x57mPWwtoU/lqfnaW8vgpS3wqttJbJzBcCgcL/trHPCKcRNM5MwBrAhH8JoVrR5+Fxu32iICEI1XBo5nk+v9heyzXGNS/S/BQaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8M5Nv+5c0JvUe8QIOGPRFDWPV5X7Bmo4uAt5XEQJms=;
 b=SmQndk4LCBtY9Hl3VcYHBvPFm+zVyE04YzuxlC0sXPPtnNF33RMo4+ORkvq0bDLHcDPoo02W6pXcVGNW6CIRche2dxjGrHIdYhCmyOBJZoOBU06Lk91xtNfwY+LRXFrI3Y23CoJPFAAjzEqbwlEzywyQVvo4gHqQEUmnuh9YsWJN6f8CcTvN8dFHF2knKGHjYA8kV0CFDfZWSOo3dyIKzHnSVuITCltVF0FBbRpyg5WXYqql9gbeUfnjMiPqsOiNh1cnTfz6a7/B2agU/zsvoyRqTgx1ygYOsTLvB8TQ8/VFVIEl+2KfDG7+KuG3orVOI/QiUnfPgxBN0C4xQQvqiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:24 +0000
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
Subject: [PATCH v3 00/15] Consolidate iommu page table implementations (AMD)
Date: Mon, 16 Jun 2025 15:06:03 -0300
Message-ID: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:8:54::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cb9164-acc4-4496-923a-08ddad007fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EkqwBPmCim0GKOI7B8/GzLQZfV69HlSHld7cSp4lx4yACwFGQkGf81GzJQhp?=
 =?us-ascii?Q?NH6euFj3Olt7E2Zy2C9TCK9zn/ieYiwQwQVO4POivnVZzWsGUfHjT0yodSEQ?=
 =?us-ascii?Q?179guhjkCKfAb8pRyFT0UFfY8INotcgKN8urxPcopf+4YupRdmGNaDJyH5M0?=
 =?us-ascii?Q?H8qN5jFq0aTI7cXzy5eEPX0Xj1eWyC9Bww46TxQnwqLJftQRTvuZTiOE72HC?=
 =?us-ascii?Q?UGWUO4kkX8EEcZ2V3hBtRwexfte0pKjUYQ65VDKhc1mgRhn/nqH2kObiIang?=
 =?us-ascii?Q?Rn5KNHLKPlhVpwKf+YEdnTfqi2ZEmROGsmepv6JSbgV2MYYvz0Rf1IVWEvZN?=
 =?us-ascii?Q?6cvZjyWFzaAx3WIbxPoOeRiLh9ZXdRf3H5Lp3Qo5mqSUJQigx/ZFCFi/eMM6?=
 =?us-ascii?Q?fegVP6hBRW52hzOF/87Bv5IolUo8gx6i8ec+Zdwrl3JywYle0a4klJArWasl?=
 =?us-ascii?Q?gbAOFkB04BTURxOdrxNd997ti9kpcaCUghRPUPQqx5pSDS5vEWeHctNm3aQa?=
 =?us-ascii?Q?+vfc2zYvxLEBHYheJhSE2RnlNhoHjFsKxTuPjwZY46rPmAlNsR1Tl9mE2SXa?=
 =?us-ascii?Q?HMmhkj4cb8PzAGhzjjDthnTR5muVFRn/sOq5i9TyKpPJ2Z6I4lh+aA6pRgGv?=
 =?us-ascii?Q?JueDWIBR4wwU8QhI2hlznaIXBqDk9SM2Tt90UYM8oaoz77oWHALjRVyOUFLc?=
 =?us-ascii?Q?7gQm7RiT6tnUamqDSg+YYszJgwq2svWCNJ3mu3gVnSqUIkFIno2h0rdOxOvD?=
 =?us-ascii?Q?Csb+9qMvJGoARIk7E241pF5wihFX+Jb1fcDnuVQlB0LWWX0hdhYqWzJrFW2p?=
 =?us-ascii?Q?RjCqmrJv8pni4WbCxCEiYswBoZgGWEKtyaXOgPfD9BCmN22Y4B946oK8x8MF?=
 =?us-ascii?Q?zFZsJDiNJ6Cf+PcJLx2335Jj+ukGNUwZFHNMVai3FGlIRLJcrdwATA441KRf?=
 =?us-ascii?Q?c3n0QohJ2MAl4GnuA2NqnXiegMX//38CnaCD61zydoua7+Elfo51Kj2eHkt4?=
 =?us-ascii?Q?HAnoiPs2WeDnxXC3CgYIEn9R4LmHGquVn4DDuv94pAmKpZArd/rwD1qaYfOc?=
 =?us-ascii?Q?ZKgBb6jK/iGgdXhYt8Iv6/f+IU5AUV0dGoHeSgZ+Ro4fP1mbUq/+resq8DQr?=
 =?us-ascii?Q?iUNLnm4SJhT1FIjFvFVTPj2dSunFJg2TYmgXNhnkxZwn8Z37TA2sv5Il/lo9?=
 =?us-ascii?Q?fi3q4hGeKpVJTXvzPvMFpSR0ERghuvgk5R0vqA3CeISqvjtOzjxq7Sk99BTK?=
 =?us-ascii?Q?HUXG3YOuUL65HhPmNuMG2poKlZUDN5jPDGRRLsheuLbotUbKm2bTXaE+HzP3?=
 =?us-ascii?Q?nA9xmT/lbiL54/xyy9tSb2pqGrIh6YitQKsse4E/W6MzaoJkskbBEYDYVVrH?=
 =?us-ascii?Q?0NEcRVNcapKqEyemkTHxP4kYuVeHUUUJMsOcCh381P0ogRPa2KqmJoy2g+LS?=
 =?us-ascii?Q?LotgNKgYWg0jUbUSkxT8//AnndEAZ1m1OVul587EiU3nHjggMaS1CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qA+8v1KIuKpTqZpwIINYEPW3iwG7lCN2wLjqvBFPwqlSHTrS/ksYxGT+K+4F?=
 =?us-ascii?Q?qmZGNNribfacJk1uQBID4gItwMtYgY2YHVXjCGEbef728ly8D7ELUm1rrJHO?=
 =?us-ascii?Q?dexnibCYzdckuGE3d6wKSAk/FzvbLE/IOlzACiJNTi2T7Gvz8ungXvVWroku?=
 =?us-ascii?Q?uXV4/9N9Ufxe1ihbAvbmVJIus8NpOdflzq3WCadMUTiKTC5wRieqH/d3VCPq?=
 =?us-ascii?Q?eTwQ1dn0F/YVKtyAqfIlqJdN0Yojds+XAAdeiPODQPa1IREWj5Sy6PL5kH0A?=
 =?us-ascii?Q?G/zf6jwaJHdgTwABO8Yr2syr6D8n5hqyN7Jcr839Rikk+ecv+zgm4BjbmWXd?=
 =?us-ascii?Q?UFFuqbikzL1f3tkN5Y8dlVKjv4ZuyruzHWcVa7nnomacWqhSznfgEJMQQjDd?=
 =?us-ascii?Q?0FsKu6+dc2QAmSyl2isVDN7vE6vEyK+EvJvLBYe599ut3FRJle/W0pq8YGeB?=
 =?us-ascii?Q?9I0Kolry+7TKRbicKTu/LWhKapkWwNppbNdG+sOaneqr8CykYAfNMikbue4d?=
 =?us-ascii?Q?YR/UrZxLooMqy7RIQJHUM6S67obd1NRGjitwic/UtmLA2ZcnhBhuDwI0Pbwy?=
 =?us-ascii?Q?f1kdBUahDdtaOqGOGknSBE1sqrrvw+JZSSdcld7Y1kCoIhEqYntboK2DStAN?=
 =?us-ascii?Q?gxUJvM0xeUm8rL3eXkZ3Q1pCDnLUfVqx8Sgrfilj8ewlucsr9hX8SJruhGsY?=
 =?us-ascii?Q?IM8uT0Zn8G5vstJ7KGoSR8cpcJPMKt3h9JEX6c2FdAcBm7zC8JBmiIcl4xWx?=
 =?us-ascii?Q?qEKOHc3LxLe0WPBhI7Nh+MvNSGQ9Ew0+Vc+PozhKLhEZJsajEmqkFx+4jZlP?=
 =?us-ascii?Q?rJzJysq5E4awJ4YRF3Vhfd79Ov0h/fo1RrI/XTh/IKAz7UYN8UqY+w0iuqpo?=
 =?us-ascii?Q?9ZrGl7/NGknWWPkdeQbjfQ5sWsi5FYYu8zdjyUiKgHjaU+M5knrFbSEqoY3L?=
 =?us-ascii?Q?wwkfz0e5CWiWaURIgmFIDwQPA7QQ3P4+Ex9DOX3kOAvOR+hoZUXiYrh6MyBE?=
 =?us-ascii?Q?KNhGPlnEgphIJGv92199Fh6ffRLsdFrTJbMl5cdXcEly6cn4Z4kZ73G+hmoj?=
 =?us-ascii?Q?qlHAvyZecyXvkAI13oeUJPDYUBukGoCm5n8get8bxf5jC6dU1ovgJZfiLh7h?=
 =?us-ascii?Q?zMLZ9eOSuz5LYEQu/fZWEctKtEGanR5KkfcZF+RuHp37hq86rBm6q/VMgOBo?=
 =?us-ascii?Q?PK3GwRXGoFgxPLHF/PYoCGLUWOXdhN1Y85w31BnLtb6C18M2915eaurP4Kdl?=
 =?us-ascii?Q?RfaqRtnBHzPs0lP0yaVr8SBUz7rr7gCYc4WrdUS0FJAPg1hA35poz6EowsZy?=
 =?us-ascii?Q?7U9518lji8mpfcluYdNwQTW4MFlBfIXc1rzzBGsHeTlA74zfWnqd64nzlDuo?=
 =?us-ascii?Q?pnihpsOvQDMSVzOvccrLFzMyZ3L091iAUwXoGyPhZPO0qCapkLnc9nrSzMS5?=
 =?us-ascii?Q?dJ4Z5QdR4rTa0vBmhj2SGX/aBW4Ft89Omgz752li1hzhu4eLE7G5iM4LpYRb?=
 =?us-ascii?Q?L2XfRXS1zMGnzXXDlh+DVFRitLFFghyo0blyPxU+S5Ef0mj/6kn/UrUA+zov?=
 =?us-ascii?Q?wk6R1kDOnnhZbadxUZtv6GBvy3J70EJGU4BTl9hS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cb9164-acc4-4496-923a-08ddad007fa9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:21.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQkWPb3CjD858eWrwVuvX3tZer2xSjWZhm+U8FJIvU3KQ2KyjVncXFCXyMYsPfkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

[All the precursor patches are merged now and AMD/RISCV/VTD conversions
are written]

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

v2:
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
 drivers/iommu/amd/iommu.c                     |  516 ++++----
 drivers/iommu/generic_pt/.kunitconfig         |   13 +
 drivers/iommu/generic_pt/Kconfig              |   72 ++
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  409 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   11 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  248 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1150 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  717 ++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  451 +++++++
 drivers/iommu/generic_pt/pt_common.h          |  354 +++++
 drivers/iommu/generic_pt/pt_defs.h            |  323 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h    |  193 +++
 drivers/iommu/generic_pt/pt_iter.h            |  640 +++++++++
 drivers/iommu/generic_pt/pt_log2.h            |  130 ++
 drivers/iommu/io-pgtable.c                    |    4 -
 drivers/iommu/iommufd/Kconfig                 |    1 +
 drivers/iommu/iommufd/iommufd_test.h          |   11 +-
 drivers/iommu/iommufd/selftest.c              |  439 +++----
 include/linux/generic_pt/common.h             |  166 +++
 include/linux/generic_pt/iommu.h              |  270 ++++
 include/linux/io-pgtable.h                    |    2 -
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 41 files changed, 6119 insertions(+), 1589 deletions(-)
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


base-commit: cd76b0248a38645a3e3f8ca4a48bffc591e9da19
-- 
2.43.0


