Return-Path: <linux-kselftest+bounces-44736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4022AC32A61
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991DE18C3BA7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF032D0F6;
	Tue,  4 Nov 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDxMTY/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F01338900;
	Tue,  4 Nov 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281032; cv=fail; b=mGrAstP1zRCUI6dsSSie3CgYxdzbx2wcZXiVlbT+IJm6h3c9qLsbuOQjhKgJY+2qtYyCucXbdJTerupFDyIT6Km1KOO9iTitkRk6FadV+9X9Awg3JyTU36Yc1zOPD6SkUD1Tnhn0AkC0abjhvEjNLpSvfpY0LCAO4l+jO9mLK1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281032; c=relaxed/simple;
	bh=zIrjkLBoMULfW2Gi7/E8nYKM1XUS9H9XF6TgmKfv7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3YPXLafNE1GnRZmpcFCUwdC5fsuABK3xyICqlHMbLZ6+LoTv0uBtZHH0N32trMQW6a/tlgr3lutdLzNVIFh4gX6+zw21vnuYgKRCDaxm3KW6iSwLyQrXhM18vOtLFitH/UdIShqwvaaRZI8dLNW3JxT4hqL4YFWQPZlrO//ejs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDxMTY/K; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY0FCfTxzgq+zOxQsLKDurwq0Ip80A/NJfRvAvADyitJhGSDD8pmvoJoPaD7e7JffpNbupJiu+VfJTF7YVcmCevEmvhgJnrD1+z8Ns05+Q8PeEsU5dWMBjdq8/KRZCy9QpPATwQjqbUdMTrrs5TmRcEKnfZFFK27Ts5l64a6+cnlUW4ByfS4p6QR16e6A7MU+TTFe1SP3EyjJGvs3FI0sIl7vJzyoRMZz0dsH0B0R7R9F6qWstgPLUTf3i/8yTWTcBpKJn6u4vWt/GMMs7J7JI/pGunFLe7G0Ilpd1Hf19OUv605cuYw5fY77pX+dACjWWjn0eBRBM63k4p8iTkKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxSq3wkaZErT/zMhGqRRlW8eJQs0tRj91BwVumgDg3E=;
 b=c9egNnr8dmLWNjBhVXmM+ZjDZESM7ICmXlqL8sQq10x/8LwreU1R0E7YVo4kSZv4dPZv3XRrCyDA/sAJsfmypluI+jPmL5KOvLCB0g/IAG6QeeU5pPM/kTD3fkntxnJ1+V9dV94hXzHLdleBGeR4FGa8Gqy33PmoHe6REG78hq1ZEe8VAvBxHi99GOeSy1w50WLTQJTmzCGXH1Ynd4MSqSiBWuCxyAYKq45JkSosUEIX/EqUS30i6yFWAkdBAzHERkqVrQurayq+Av0hoRk6U+CUBUo9sQ3ew04gFOwZWVx26JG9I5Lipe+Q9Y9yFn5786NIK/knUz7r++zPAM7bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxSq3wkaZErT/zMhGqRRlW8eJQs0tRj91BwVumgDg3E=;
 b=cDxMTY/KVMBzQG6I3elPoauSoArHAZ9Tqs6AGGwx3rkiyviakQ6YQbUOA98AUJETsUPt85PR2DHEYTl9/z1WvyZ9y62U3/M9GRvFOcCLUq46ZbNNb0kkDT2K5L++5ZDU+DGCOnyAIkYDh9Aanh7tF4kWRYHZuAHiox7/xzhKSTQwKqVLXzlV3Ozd9+rpRvjEa9DwDlD381S7M91lWVY5/Y48ArtYlyvwATKjk7LnBW7TI3P2YTjbcJ5jZwhznXJHXhJcDoI8Xrg+Keucbj2TqZEYX4pHkDXOkypEJeIlMxE77hON1e4ljjmOqk6WkjFSgwdySVQwl9IAMrdai6CwNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 12/15] iommupt: Add the x86 64 bit page table format
Date: Tue,  4 Nov 2025 14:30:10 -0400
Message-ID: <12-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5056dd-c3b8-4248-058f-08de1bd032fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XryoJGs4o4SXWg/RxF2tNpLcuv+ATqYfEiUtvZKhejyECqbDQWXpSRuB4GQt?=
 =?us-ascii?Q?D01vHNNS8G5tDfFGqw0gmEGlMnEClZUnCIpBctUO+amnb86jmm0wHx54dwpu?=
 =?us-ascii?Q?usJR+pCHnR9WC7ahCri7qrgDe0gdBzdbeiTeBj7wXr3NT0Ytx1B0rZTMEdsE?=
 =?us-ascii?Q?KdZNW/NSNx72QiHSmMBWswFw/O719XVAP34s+E/sLRM3jVzQ6XdU6xnKLnrZ?=
 =?us-ascii?Q?Z8EDHzK7WVrklL5jZDzuM2Ukn9ZpKkfiCNB9ZZh0f1OiEpvceRkXy2dql//R?=
 =?us-ascii?Q?E5S9ZEM8srgTG7pDmNxX1/lzWL8gCzqqHfscWX1oiOiGAYE2lTLxy27wCpdj?=
 =?us-ascii?Q?SSTwxmXDhROdeaawF6BgX9eigOu3UJ/X9Y1K8jIn/zFTZyV4GdX3zY/M3xFr?=
 =?us-ascii?Q?o+D6kVUvP7EbtsXp5j1HXa97xn+MzTOu5ra99BaI5fY+2saEwu/RurAx6V+Q?=
 =?us-ascii?Q?vhYKBsSq8w45FY0lctz0yHul3QBf0oIpvqaLXzZtNFOv8zlU5BSOMNXdLKJz?=
 =?us-ascii?Q?EIY9pOAw5LhsSY5FYOBOFQYR14zJy6MKCfqgm7ypy8vfURr7yUcpYChjm3nZ?=
 =?us-ascii?Q?tIk3zFU6flim5/ocRFXTUnEacDQdYPTgOG3xLRNYTPuM/lFhoYYLkrtGK/36?=
 =?us-ascii?Q?jhkNXn1elQ7ZSvQfN8TZhUMf+qGKFN1qpS+g4Omaoyw/YqymyHc9qZBKyoP5?=
 =?us-ascii?Q?5C5azo1oWSoFBX4TXrg6wAnSfH2XbvLGgq2j8paxT1Hnobhle/WggoYNPQ6u?=
 =?us-ascii?Q?6HqVpmgmgBrTrAwwLlJ1tOiupLhJ3N3PxeBzH3sWvepMGQCftu8EEtevlQyD?=
 =?us-ascii?Q?DllK36GWRNEUASYHqs3l0K0gMUvGlj3b1YO07DeVehI2+fxQ+0ph9haTTd7u?=
 =?us-ascii?Q?ayCuIhZgmCvwx14qptvfR79lwhhbJZP2Bxrhh2pMh86YQHm0coTjZXrRDXdH?=
 =?us-ascii?Q?/2mstBVnADIvFG9MShlB4KcSHJYkMr7m1MsHlgTNVqhK4nR+5pbLYCnjUXWq?=
 =?us-ascii?Q?gpyxkl9+fd+OmJIXMHSsxC4/RY4J+0P5x5Gm9MhpAAmlBeBcbNVqVL6XhuFT?=
 =?us-ascii?Q?SDh/lLxNgFqVZkeVpsg0YZ9jyKM1M0WRPccNAs6WpBMJb+PNweEmWPFF8BRJ?=
 =?us-ascii?Q?oqgsfFLOmRRGVhB02o5kZfj0dryHASIsz1sqi8gZJ6BXim31/6N7bktN2xt1?=
 =?us-ascii?Q?BdhN+4Ow9m2uTcIvJ0T6qlm7iuAKnO79fDozPBVhQ7BTT8ruYOX6kAjMHihf?=
 =?us-ascii?Q?0RJMguovNe4RhLhiTv+xLieWvudpX60kbxv8U3PwVF91xvWjOxxE8Lan2xY4?=
 =?us-ascii?Q?S6JbO2Bui9fMKYmzIzK9TOT/Yz3rhNDaEvEm6Hx2jzo0ahnEtPcwOCSJje86?=
 =?us-ascii?Q?L7E56HsfP0dposUeIXfek4DCJ4GtQzSkaV7Du3XWANq5NpA4CNBHi1exZrlt?=
 =?us-ascii?Q?++hZwpSJp12gJgaYq/etWHZs/ZiEH9gQtWEmvLrgy+RCr4eVr50Pf9n82VB9?=
 =?us-ascii?Q?ZYOPdiHrKhy/hEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6/dO9ZM9x17ppYVVVmJNnUk4HN4yNzCKeSic8U6Yf6I+GLfPnvFJ1wq3llG?=
 =?us-ascii?Q?/QY8gWUzI70AkTWwkgVntdJCwh0Jw2iTTfA/cE6x5KkhvCtHJqO8b+d6ViNt?=
 =?us-ascii?Q?KoHcSML9m5+yMmZZFTAD2W84c8h+dWXjTT2ehXZy1dq1DAXGZIj4xmunzC2T?=
 =?us-ascii?Q?cV5fECqwJF/UyBoEA8UvmuJMbONDRCuMl3XVQdlpa9mFthBFhrsffW0roXo0?=
 =?us-ascii?Q?SoN7v1O3Cs5L0rV54GELu6EOndONc2exAtZFbBckJrXFUD5ol4fpKQ4c+wIc?=
 =?us-ascii?Q?NmOEqqWENr4GxtLoIkgcpbEaxDITdfNJV/9UKCP/ipfLvA22JZur/+V1le2x?=
 =?us-ascii?Q?R0ILS4ayf/9gAMmbhDcw0kKpzFkm0s+RNNgC399M0P9EHCXu1VkR5nIYUujh?=
 =?us-ascii?Q?7SZUlJbXVCWVH64+6IeTgsuITuRUkPsAZSCVYDKq/EC8RwU9RHokjYKnJTMt?=
 =?us-ascii?Q?m4F1TcQfXn1Wi3FKI32aTuq/w3ONP/3B+EnjZmcTg2P+Ewcx4T78U7FsHlKc?=
 =?us-ascii?Q?1GBnD92aWA+WrIIVQ/TtXES2jqp03qW6O0F6k1RRjSclOC8eLN55gGoTo7I7?=
 =?us-ascii?Q?YdUVioxGalpVd8/LBovykcNn3kfvPkFp+RMw/eYuVLc+1MZ1aE97nRqs7jT8?=
 =?us-ascii?Q?5PNX13RaWqXTevRpHJbOiwvg1nGybfFzqmuCTbhkpPW5LblAp/GbiAPnNx54?=
 =?us-ascii?Q?DJc1hpPbj8tMYT7cjy0ywgwf2CfR446PXzMFaq2wtRW/Yc21d0q5kYmvpHQ9?=
 =?us-ascii?Q?9QWrwd2+n7gnaDyT32tTdspIr9y5GWXJCa1Y6NwByGA3sAwGMqAIgBsyKcDw?=
 =?us-ascii?Q?oT/TjD92wCPkOh7MiIpQhBkfTAaGHdMwpvfh8B5MqwlZ/0mwMvFdNyEkb3w6?=
 =?us-ascii?Q?z1vEc55abNoAyCfxqNIuL9gPWkddP4yc8H63u/VPS+axJ1fhqAG2GD/VMjE5?=
 =?us-ascii?Q?hwXoc4gERS+47PnHvpHyh1qUmZgNJMGVyWlsn3/Ezy6L8IGry0HkpHTaQvAA?=
 =?us-ascii?Q?I1w1hmGWayHHtHiSW4Bi4sFGWG5SVkPhG4hFQrC4byn2LLlkIs/u7oTYnUHy?=
 =?us-ascii?Q?t4+SGwL2wdCBSFCvspPL4ZK/E68omoHNX3st8dNhCvvSrHW0bY+0D+A+iMZH?=
 =?us-ascii?Q?KYdwvzsyO0Yak7kTumWx7o1SwN2mv+Pe5mrHkwxDNzf59zPpgJtlKq6C4TiF?=
 =?us-ascii?Q?dTdwd44kosC536kSxqm6LQGyLg/mNM4iQJHGaPQkXHslFRiEVCiPcZ5g+WbU?=
 =?us-ascii?Q?8Q97MKI8ckzvsPzN0kgF6gSQ5WbNMWU0MmXUXJ3wN1761H6AAm7BenELo3O0?=
 =?us-ascii?Q?dqjNlB6fWq/Q1npcoeoh7NLEno5iDZispOHQOsHZ8fzoSSfVm31jgAhst2E0?=
 =?us-ascii?Q?Wt9PacppoG+3u+Gu9lhvIpflVAzRDb7BsVUeRQDei5BnGIymNsju4ApEd7OQ?=
 =?us-ascii?Q?UJIHjbehvvupGMGpbJXQt4g03PxOHCmBFAQXgQ4LK8Y18t+X0h35lCOTvZiY?=
 =?us-ascii?Q?BQjKOqkr63wV3lVer3pa7DIZ0TCRNcTzO+IHx/qIFmvKgwrbH3lLajUmFyAj?=
 =?us-ascii?Q?dN7gH2fsPYu55s3pW3I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5056dd-c3b8-4248-058f-08de1bd032fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:15.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9j9RxQWjVDuIrsh5E0Ae0/8X0o5y2XSXuFyC52kT4xO+5sOOuGeQZWixmVBuu8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

This is used by x86 CPUs and can be used in AMD/VT-d x86 IOMMUs. When a
x86 IOMMU is running SVA the MM will be using this format.

This implementation follows the AMD v2 io-pgtable version.

There is nothing remarkable here, the format can have 4 or 5 levels and
limited support for different page sizes. No contiguous pages support.

x86 uses a sign extension mechanism where the top bits of the VA must
match the sign bit. The core code supports this through
PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
new operations will work correctly in both spaces, however currently there
is no way to report the upper space to other layers. Future patches can
improve that.

In principle this can support 3 page tables levels matching the 32 bit PAE
table format, but no iommu driver needs this. The focus is on the modern
64 bit 4 and 5 level formats.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     71,61    ,      66,58      , -13.13
     2^21,     66,60    ,      61,55      , -10.10
     2^30,     59,56    ,      56,54      ,  -3.03
 256*2^12,    392,1360  ,     345,1289    ,  73.73
 256*2^21,    383,1159  ,     335,1145    ,  70.70
 256*2^30,    378,965   ,     331,892     ,  62.62

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     77,71    ,      73,68      ,  -7.07
     2^21,     76,70    ,      70,66      ,  -6.06
     2^30,     69,66    ,      66,63      ,  -4.04
 256*2^12,    225,899   ,     210,870     ,  75.75
 256*2^21,    262,722   ,     248,710     ,  65.65
 256*2^30,    251,643   ,     244,634     ,  61.61

The small -ve values in the iommu_unmap() are due to the core code calling
iommu_pgsize() before invoking the domain op. This is unncessary with this
implementation. Future work optimizes this and gets to 2%, 4%, 3%.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/.kunitconfig       |   1 +
 drivers/iommu/generic_pt/Kconfig            |  11 +
 drivers/iommu/generic_pt/fmt/Makefile       |   2 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  11 +
 drivers/iommu/generic_pt/fmt/x86_64.h       | 255 ++++++++++++++++++++
 include/linux/generic_pt/common.h           |  13 +
 include/linux/generic_pt/iommu.h            |  11 +
 8 files changed, 325 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h

diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
index 936c327f0661cf..2016c5e5ac0fe9 100644
--- a/drivers/iommu/generic_pt/.kunitconfig
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -3,6 +3,7 @@ CONFIG_GENERIC_PT=y
 CONFIG_DEBUG_GENERIC_PT=y
 CONFIG_IOMMU_PT=y
 CONFIG_IOMMU_PT_AMDV1=y
+CONFIG_IOMMU_PT_X86_64=y
 CONFIG_IOMMU_PT_KUNIT_TEST=y
 
 CONFIG_IOMMUFD=y
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 81652cd9c69fe8..6dcb771b3c582a 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -42,10 +42,21 @@ config IOMMU_PT_AMDV1
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_X86_64
+	tristate "IOMMU page table for x86 64-bit, 4/5 levels"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	help
+	  iommu_domain implementation for the x86 64-bit 4/5 level page table.
+	  It supports 4K/2M/1G page sizes and can decode a sign-extended
+	  portion of the 64-bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+
 config IOMMU_PT_KUNIT_TEST
 	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
+	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
 	default KUNIT_ALL_TESTS
 	help
 	  Enable kunit tests for GENERIC_PT and IOMMU_PT that covers all the
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index f0c22cf5f7bee6..5a3379107999f5 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -3,6 +3,8 @@
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_X86_64) += x86_64
+
 IOMMU_PT_KUNIT_TEST :=
 define create_format
 obj-$(2) += iommu_$(1).o
diff --git a/drivers/iommu/generic_pt/fmt/defs_x86_64.h b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
new file mode 100644
index 00000000000000..6f589e1f55d35a
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_X86_64_H
+#define __GENERIC_PT_FMT_DEFS_X86_64_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct x86_64_pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs x86_64_pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_x86_64.c b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
new file mode 100644
index 00000000000000..5c5960d871a32f
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT x86_64
+#define PT_SUPPORTED_FEATURES                                  \
+	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
+	 BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) |                    \
+	 BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+
+#include "iommu_template.h"
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
new file mode 100644
index 00000000000000..18d736d14b2d0d
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -0,0 +1,255 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * x86 page table. Supports the 4 and 5 level variations.
+ *
+ * The 4 and 5 level version is described in:
+ *   Section "4.4 4-Level Paging and 5-Level Paging" of the Intel Software
+ *   Developer's Manual Volume 3
+ *
+ *   Section "9.7 First-Stage Paging Entries" of the "Intel Virtualization
+ *   Technology for Directed I/O Architecture Specification"
+ *
+ *   Section "2.2.6 I/O Page Tables for Guest Translations" of the "AMD I/O
+ *   Virtualization Technology (IOMMU) Specification"
+ *
+ * It is used by x86 CPUs, AMD and VT-d IOMMU HW.
+ *
+ * Note the 3 level format is very similar and almost implemented here. The
+ * reserved/ignored layout is different and there are functional bit
+ * differences.
+ *
+ * This format uses PT_FEAT_SIGN_EXTEND to have a upper/non-canonical/lower
+ * split. PT_FEAT_SIGN_EXTEND is optional as AMD IOMMU sometimes uses non-sign
+ * extended addressing with this page table format.
+ *
+ * The named levels in the spec map to the pts->level as:
+ *   Table/PTE - 0
+ *   Directory/PDE - 1
+ *   Directory Ptr/PDPTE - 2
+ *   PML4/PML4E - 3
+ *   PML5/PML5E - 4
+ */
+#ifndef __GENERIC_PT_FMT_X86_64_H
+#define __GENERIC_PT_FMT_X86_64_H
+
+#include "defs_x86_64.h"
+#include "../pt_defs.h"
+
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/log2.h>
+#include <linux/mem_encrypt.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 57,
+	PT_ITEM_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+
+	/*
+	 * For AMD the GCR3 Base only has these bits. For VT-d FSPTPTR is 4k
+	 * aligned and is limited by the architected HAW
+	 */
+	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
+};
+
+/* Shared descriptor bits */
+enum {
+	X86_64_FMT_P = BIT(0),
+	X86_64_FMT_RW = BIT(1),
+	X86_64_FMT_U = BIT(2),
+	X86_64_FMT_A = BIT(5),
+	X86_64_FMT_D = BIT(6),
+	X86_64_FMT_OA = GENMASK_ULL(51, 12),
+	X86_64_FMT_XD = BIT_ULL(63),
+};
+
+/* PDPTE/PDE */
+enum {
+	X86_64_FMT_PS = BIT(7),
+};
+
+static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
+{
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
+			  PT_TABLEMEM_LG2SZ);
+}
+#define pt_table_pa x86_64_pt_table_pa
+
+static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
+{
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa x86_64_pt_entry_oa
+
+static inline bool x86_64_pt_can_have_leaf(const struct pt_state *pts)
+{
+	return pts->level <= 2;
+}
+#define pt_can_have_leaf x86_64_pt_can_have_leaf
+
+static inline unsigned int x86_64_pt_num_items_lg2(const struct pt_state *pts)
+{
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 x86_64_pt_num_items_lg2
+
+static inline enum pt_entry_type x86_64_pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(tablep[pts->index]);
+	if (!(entry & X86_64_FMT_P))
+		return PT_ENTRY_EMPTY;
+	if (pts->level == 0 ||
+	    (x86_64_pt_can_have_leaf(pts) && (entry & X86_64_FMT_PS)))
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw x86_64_pt_load_entry_raw
+
+static inline void
+x86_64_pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			     unsigned int oasz_lg2,
+			     const struct pt_write_attrs *attrs)
+{
+	u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	if (!pt_check_install_leaf_args(pts, oa, oasz_lg2))
+		return;
+
+	entry = X86_64_FMT_P |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+	if (pts->level != 0)
+		entry |= X86_64_FMT_PS;
+
+	WRITE_ONCE(tablep[pts->index], entry);
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry x86_64_pt_install_leaf_entry
+
+static inline bool x86_64_pt_install_table(struct pt_state *pts,
+					   pt_oaddr_t table_pa,
+					   const struct pt_write_attrs *attrs)
+{
+	u64 entry;
+
+	entry = X86_64_FMT_P | X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(table_pa, PT_GRANULE_LG2SZ));
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(pts, entry);
+}
+#define pt_install_table x86_64_pt_install_table
+
+static inline void x86_64_pt_attr_from_entry(const struct pt_state *pts,
+					     struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits = pts->entry &
+				 (X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+				  X86_64_FMT_D | X86_64_FMT_XD);
+}
+#define pt_attr_from_entry x86_64_pt_attr_from_entry
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_x86_64
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_table, iommu)
+			->x86_64_pt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_table, x86_64_pt.common)
+			->iommu;
+}
+
+static inline int x86_64_pt_iommu_set_prot(struct pt_common *common,
+					   struct pt_write_attrs *attrs,
+					   unsigned int iommu_prot)
+{
+	u64 pte;
+
+	pte = X86_64_FMT_U | X86_64_FMT_A | X86_64_FMT_D;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= X86_64_FMT_RW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot x86_64_pt_iommu_set_prot
+
+static inline int
+x86_64_pt_iommu_fmt_init(struct pt_iommu_x86_64 *iommu_table,
+			 const struct pt_iommu_x86_64_cfg *cfg)
+{
+	struct pt_x86_64 *table = &iommu_table->x86_64_pt;
+
+	if (cfg->common.hw_max_vasz_lg2 < 31 ||
+	    cfg->common.hw_max_vasz_lg2 > 57)
+		return -EINVAL;
+
+	/* Top of 2, 3, 4 */
+	pt_top_set_level(&table->common,
+			 (cfg->common.hw_max_vasz_lg2 - 31) / 9 + 2);
+
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	return 0;
+}
+#define pt_iommu_fmt_init x86_64_pt_iommu_fmt_init
+
+static inline void
+x86_64_pt_iommu_fmt_hw_info(struct pt_iommu_x86_64 *table,
+			    const struct pt_range *top_range,
+			    struct pt_iommu_x86_64_hw_info *info)
+{
+	info->gcr3_pt = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(info->gcr3_pt & ~PT_TOP_PHYS_MASK);
+	info->levels = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info x86_64_pt_iommu_fmt_hw_info
+
+#if defined(GENERIC_PT_KUNIT)
+static const struct pt_iommu_x86_64_cfg x86_64_kunit_fmt_cfgs[] = {
+	[0] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
+		.common.hw_max_vasz_lg2 = 48 },
+	[1] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
+		.common.hw_max_vasz_lg2 = 57 },
+	/* AMD IOMMU PASID 0 formats with no SIGN_EXTEND */
+	[2] = { .common.hw_max_vasz_lg2 = 47 },
+	[3] = { .common.hw_max_vasz_lg2 = 56 },
+};
+#define kunit_fmt_cfgs x86_64_kunit_fmt_cfgs
+enum { KUNIT_FMT_FEATURES =  BIT(PT_FEAT_SIGN_EXTEND)};
+#endif
+#endif
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 21e33489cbf20d..96f8a6a7d60e10 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -151,4 +151,17 @@ enum {
 	PT_FEAT_AMDV1_FORCE_COHERENCE,
 };
 
+struct pt_x86_64 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_X86_64_AMD_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index f2a763aba08846..fde7ccf007c50c 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -255,6 +255,17 @@ IOMMU_FORMAT(amdv1, amdpt);
 struct pt_iommu_amdv1_mock_hw_info;
 IOMMU_PROTOTYPES(amdv1_mock);
 
+struct pt_iommu_x86_64_cfg {
+	struct pt_iommu_cfg common;
+};
+
+struct pt_iommu_x86_64_hw_info {
+	u64 gcr3_pt;
+	u8 levels;
+};
+
+IOMMU_FORMAT(x86_64, x86_64_pt);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


