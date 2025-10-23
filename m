Return-Path: <linux-kselftest+bounces-43937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE39C02E27
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1584EE55D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C6271469;
	Thu, 23 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tkoi0u91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5AB270EDE;
	Thu, 23 Oct 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243675; cv=fail; b=YMy0PzklFwk/BPrgEqeaLHGGeeYN8YUU1RbAzTwkwDJjffcbneeDNu5np2Bkm0ynkMi7gAKcGruCx9qFFprfm7pwZUI0oJCyY8xaMhkqjsNha0EANtv+wxx7aSMRT4QGxo/kSzdLt5LK6AUyHEpybZi9UmIf+vPKG55x/1zZJOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243675; c=relaxed/simple;
	bh=d5TaMyVkDLJT+Vk0cT2IMZfit+AL+5HpABfkW0AGW5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bvkcqp47oESHhWEiPOkXmyrfLafgknjh782eZCT3dBKq1DZvEJ3f4BPnKslTZ8v1ZTbGMWVMPy/ZG6jn/E0eG1s0I16VukJgbakVqG46RmrZkfEwlHH0RwC0+dxnx+Xp/hzlG45uIFAHqni9o3eDtaxI0hbQ7k83downjs7bFGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tkoi0u91; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz29j9JZZGHu0rhONFUg1v2T6GS7Qhd+GZCbQX6vztwtzvJasZMRB1Fd05pchTjIxzHoYon3lwlL9he6PmXzmerQoYtAixvOLleEois4LtN3C1cuauFIWK+jYlDcKhUFDDFqumr4UbXp9r5NDE4zaSp1Gt5kFOhBXP4UGjf91jvHbUuxTsA1wGbqIBSgN9FLoQk5cnFfA8ycGQvr74VbDpYBnGxwDsO2YIRmefMqoTj6yn17b5X/8IbYvZsOxXiYWe75/iD+tcgQtdnuLVrSBdLFHC2W54ZfzdyjBwYxP4FpB59inktgx4wZAXfgCp2SyiUudim6zKC80P1hI/nMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py8AjfWjKCQhVOPCkXyzAXWuVC7hwT+poffB9489xCk=;
 b=JsW+zlBJAy4dt2dkwq7Hh6gkpi9e0Om3MDGP/N/sG74qOXTaenlU5mTx88fsMqCxMS/SupfvmbQk14aYqe/tlT5f5gtI1b0g+ShyaxhMRiFOLDoa+zaO5x+5n23H3/kKmf+tfquwdEXdjH+Yk6dZR0UakJ2M50BfmPjhvS9ffv1q26ZusVTdzU8U9B6WDPprv4ZC8g21tncsjFzllw5YUiMH8zlRLWX7vtPGD7GnOcjjpRhUXE3JpEs9AwoVbPKlimPL7DssRZ9bNvZ2FiJxiFTrPHDttVCrUV3deKo1rQapcqUhxBd/LgWR8q7/xHv5+lq74I1XsKCggTs4zm88dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py8AjfWjKCQhVOPCkXyzAXWuVC7hwT+poffB9489xCk=;
 b=Tkoi0u91Dmah/1/gAdXoW3CEqv1hZ7bJUWDqtBmrMLR0W0+vH4Cx+lyReLnTOHN+25PSBkJ6U4NG1PzOdSEXUZ8ZVfKlHG8xNJJIDdoeLfsk2oD5a/0OHhRLiqvjGfdHgxV3ZUhgPdasuW+i8Y2BxQNAYi3/A38/XZdGXMPs9v1bUhyXmfv3XMhlxpo1VtiZFhY0xnc5zQB6thOAju32o1fRAg2tm0ryBOJy5Z4pquEt/X7gA+MMeNKwVZdqzBWP5gK0ESaRvgEqWhTd0rDo79EDRZb43CWFy+QByCYG/q7/yecWE8lCLsAHWbE17b9+V0qBCD/TW4Z/EneCOFpjqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:21:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:01 +0000
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
	patches@lists.linux.dev
Subject: [PATCH v7 00/15] Consolidate iommu page table implementations (AMD)
Date: Thu, 23 Oct 2025 15:20:30 -0300
Message-ID: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 571da2cc-795e-40d6-3126-08de1260e6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBCpy16qJ39QPA2QoqnjiLvuWgjO8R1xzk/P4fmggSStSfl3Awl9XRL5uhf5?=
 =?us-ascii?Q?k2XC83nkF+Q6qMbV1Bw5SxomtXNzVEz746LzG3I2xIkcfTe5wjREIwzcZOSy?=
 =?us-ascii?Q?Zt7BGPbb1kDRYnwKiWhl6FNs84o4QAhR4EsiNjfFMtHTNY1jYbMFNjffmqyP?=
 =?us-ascii?Q?GRjsHDjrwEn/DRhUUrJL9/UNs31gHf0Id9NN9B9h7UUBeDoYoc/xZ85RzOZE?=
 =?us-ascii?Q?Kl95J7T7+AcyidcmEY7Xo6wHhCFxfXYu7oF1tQZ/Q02HQAUyobidvHJJUpPI?=
 =?us-ascii?Q?yxDSaoY7OVSfoJM1d+RPXaQsjukVZPMqcmPtOm818XXWd/z4lNEDyb6001s8?=
 =?us-ascii?Q?wcu4bBC/XM615jtikBq8EcCe9P5IDrsJ1I2cTQ4zpFCBTs03egmje0jG0djP?=
 =?us-ascii?Q?WCa/JPrhstGi+GCEieRJLJqpLVG8yJMpRL2TFHZfIcQ+dtPHtiI1AwlPrLA3?=
 =?us-ascii?Q?t5mHYbDr3ymKJ++tg8c3AErv2NDdUcnei6wuF2U4aiTt1IqQ/I8wS0BaHY7G?=
 =?us-ascii?Q?i76Cvt4UUAaQOyFSaOdDSMNDramssOM5enbCDLos2BcDWs+gZUPxCm44H/U5?=
 =?us-ascii?Q?F7JfUo1dFGT42ZRc/doc/U4MwZcqK0wt8Pdw/uCKHiRbeyGnXzgujfci0pyV?=
 =?us-ascii?Q?uthV+JFsO/h9VLrHTKe3pYuWoDMDdOVZgrD7HnoF4jlrO3So6DSC+ayswSvB?=
 =?us-ascii?Q?Jb1Mm/jtiGOqUukqxYVoAd5QTkYN9fu+CbD9Se3Ry5uEKxD+/iwAgT2JMxF2?=
 =?us-ascii?Q?mY+5++vxA2P37Nn/oTO3kQ0bfIc3NSZtH+jSb/ZPQeeB3SknOO6BQU3S6BK6?=
 =?us-ascii?Q?FKEQ4tOMnxUwiEaVOy7UF7fSjarOFuLC/eTTMpyvCV6spADJI04BLIuOS24V?=
 =?us-ascii?Q?fBa0xHla3zypfNU0FcjR90wwdzvJzOmUfgQImsyI8sy7izmvc7sqMRbUZ4hh?=
 =?us-ascii?Q?AW81++VjevkYX7Npx+i3gkdEMyXsDkcqiuIV4lRmj/Hknx4g06ZBGUMdFxZh?=
 =?us-ascii?Q?Jdl1mQidFNLdeFgOLxuz/QhauIB9a8ovDu4GHeRXv7Q89rFYfjLMcgAtxBUe?=
 =?us-ascii?Q?3FGnMgxEv+a6t2+fCgJ4qbEtu0/tdybmRbNrPO8xqCVC3cMOCfIwKiWTl9Av?=
 =?us-ascii?Q?rq+NzE1nmLbK1aW/1joc5aad/k14lt4newN/DZqqbgTonEwC/FthoCfpo83+?=
 =?us-ascii?Q?i6mhWGA+KyMWtqVFN3kR/l18oJ+ryfR6lKcMOZw84i4m0PP0wqCHukQbPCea?=
 =?us-ascii?Q?/W55MX55yAFUvAcSrbbhJCRZwXYIC7xWxWLd5e+yU9H5BcfM66mvHsfHA2CF?=
 =?us-ascii?Q?D0Egppp0en7MGgCwu+bw93seMTFPJR+V6LM6DVNc6GT2xf4t4Lr8zkfbqD7x?=
 =?us-ascii?Q?Um/jR6S1jzbceRtvm8/s/3ElBLrYCicFP6THFgj/WgHZZqZO1d0cw2ZiIEz7?=
 =?us-ascii?Q?gdRYoS6rdo8mquIySC6qUgArzPDEo8c5FDVNah/C66pFD73JK9ZXa42fOhmU?=
 =?us-ascii?Q?uK0mQeJSkaIgFNH7Q0TWwDTNkxfGOje08miI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jey/MhBYs6eEZd9msc9ZE7RaAn1FnFvr5so2zQrsUs6gQ193uoTl/JBOxlMl?=
 =?us-ascii?Q?7o5712WqR0l91B/qCUnrVIyGiqhbbKMSbw3sMDlF79zdhDFZnQ9OvDPOCjYy?=
 =?us-ascii?Q?aRyob4wPRusfulRmgTb5WP4Xg7UNstk/EUWoAVFLPAEjdpubM8d7uRM1MfPV?=
 =?us-ascii?Q?ICfCdhLpnziOzbecJKUci7fgsD98vRCNA5ZU4hwbizWGnCUG01ZZTYWcJtIz?=
 =?us-ascii?Q?c6azwtvhlhGdTAFgBDHLqIgz1UKSDbhKv0FO/pFDLee45bxI0xfzwyvGGXIV?=
 =?us-ascii?Q?H7BsxLIb8/RfdM3BIK2Tm40BvUg9qPdX410TYgvqvudtR69fD7fvqtk8wdJb?=
 =?us-ascii?Q?i3NHbjhHxNHeq++c4YYxE6JcFPpCSBaKkp0F7RLjh0yy2ziTezrssLvBRjjP?=
 =?us-ascii?Q?EE9NPxG1yWy/56KJNRN12W8riieyePE1RB4Refgry2ErmP6HM2l0GvkmqJCo?=
 =?us-ascii?Q?eLufQRD6rBxa5+po52d6N6vAHnFRGJlRN7Om14LaGbDuIRj9Q6rTKGpdolyx?=
 =?us-ascii?Q?JgPlQ7S7ousfpS0pE/TgHJ+KrVMqqN0AwacPRYzIVx3fkHB/GG1foBhuoaj2?=
 =?us-ascii?Q?KK2fzgSDc+35hMm78PCzzZgtLZqyenHC4ZZBltzGN0cDsnh4nEQxPRMZfSrf?=
 =?us-ascii?Q?IYhe2bTzqCz/kAD+NawiGprPGfNJysWe4l/An9FxglXW3ULVmowXRZiUrP/y?=
 =?us-ascii?Q?kl4aLcywoLRZ7mcBQl8kwHHRLtbUXkwhXDaVGUi7dGtNwv2RX47LbmdEWKmy?=
 =?us-ascii?Q?v8zX/C1UZur/O3f7KpfNLExLBiMGP7t0B/2DFfTWQVH4FNjmPc22sLulaN5a?=
 =?us-ascii?Q?Cr3YOUqzA5K7qk2IEccT0mCC4OgeaHfilBjA3P1MIGo6t4W9+L1pxf8x2w5D?=
 =?us-ascii?Q?2b5HnNtTHU2f21h7i8AZedSmxe8SqnhDYwTsnL6NhVsWFU/xIHwzqjCkQdeh?=
 =?us-ascii?Q?rI9zrsJ5jABrWLpefQyBqvtRMOxBPK2KvtDktVmPvRtZzCPMkHFQXsbxprdM?=
 =?us-ascii?Q?HU+RwcZuiAIWib1yTnvc0DLxWNSABy+lnQKE3kMo76k5yGSQLgY6lGw3BJHe?=
 =?us-ascii?Q?NNyjX4NbDY5VGdvSW6iGiXvZg0gfU6SWuedmNj8+XKhRYV3GvnSJXH3HwYuP?=
 =?us-ascii?Q?8S6ZIovcEST9WJNHQXNVP97WBX5avxuYeloMP27BSexbKxB+vyRV31FzeLGJ?=
 =?us-ascii?Q?7mltmybfBaSVyydwDiGKmdU9UQ+zNTwZuFn9HqGkpyzx4BJcsZagKrwWv12q?=
 =?us-ascii?Q?FJ9wGJe76oT7YZRsZrrxwTO30LpgE0Cdy7JnrNwyk/1uIFzTvZLUU1RWwye+?=
 =?us-ascii?Q?ggTskjp1DugthVl/43v0/zMQKzmy49F/vf8iNheuooymv8/Fy9r+WeRCSspt?=
 =?us-ascii?Q?JbQ9jsb30aTh/kwbmdtq841KkMD2g9zucAp5Goq1ca0C+2hSkbGx2zSlzHyn?=
 =?us-ascii?Q?WCDk85gzFdiJIOWoVMdRuoAq8xpyqT+kdZo+jRLI4r4p6zyXpBZKvDymjiv0?=
 =?us-ascii?Q?4fh6DA3icHN13sm34nsAJQedGGGM73qMmvrZaE2HSvkK93kwSPEwQKskRCNH?=
 =?us-ascii?Q?l8scSnFMxiZ2EZLmjpA4gsoWfMsBFwvoMdMxQgEe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571da2cc-795e-40d6-3126-08de1260e6e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:53.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGpkO841IDNAfAgFTt6J0nL18/w317WsoLyBRQxN9hXmewCGZ1AR0bbJ0FEzgq78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

[Kevin has a done a great job to get through reviews on all these, and
Vasant/Ankit have been looking at it on AMD systems, I think we are close to
being done now!]

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
PAE / AMDv1 / VT-d SS / RISCV)

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

     2^12,     55,65    ,      53,62      ,  14.14 (VT-d second stage)
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

     2^12,     69,87    ,      65,82      ,  20.20 (VT-d second stage)
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
 - VT-d second stage format and VT-d conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd
 - DART v1 & v2 format
 - Draft of a iommufd 'cut' operation to break down huge pages
 - A compare test that checks the iommupt formats against the iopgtable
   interface, including updating AMD to have a working iopgtable and patches
   to make VT-d have an iopgtable for testing.
 - A performance test to micro-benchmark map and unmap against iogptable

My strategy is to go one by one for the drivers:
 - AMD driver conversion
 - RISCV page table and driver
 - Intel VT-d driver and VTDSS page table
 - Flushing improvements for RISCV
 - ARM SMMUv3

And concurrently work on the algorithm side:
 - debugfs content dump, like VT-d has
 - Cut support
 - Increase/Decrease page size support
 - map/unmap batching
 - KHO

As we make more algorithm improvements the value to convert the drivers
increases.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt

v7:
 - Rebase to v6.18-rc2
 - Improve comments and documentation
 - Add a few missed __sme_sets() for AMD CC
 - Rename pt_iommu_flush_ops -> pt_iommu_driver_ops
          VT-D -> VT-d
          pt_clear_entry -> pt_clear_entries
          pt_entry_write_is_dirty -> pt_entry_is_write_dirty
          pt_entry_set_write_clean -> pt_entry_make_write_clean
 - Tidy some of the map flow into a new function do_map()
 - Fix ffz64()
v6: https://patch.msgid.link/r/0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com
 - Improve comments and documentation
 - Rename pt_entry_oa_full -> pt_entry_oa_exact
          pt_has_system_page -> pt_has_system_page_size
          pt_max_output_address_lg2 -> pt_max_oa_lg2
          log2_f*() -> vaf* / oaf* / f*_t
          pt_item_fully_covered -> pt_entry_fully_covered
 - Fix missed constant propogation causing division
 - Consolidate debugging checks to pt_check_install_leaf_args()
 - Change collect->ignore_mapped to check_mapped
 - Shuffle some hunks around to more appropriate patches
 - Two new mini kunit tests
v5: https://patch.msgid.link/r/0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com
 - Text grammar updates and kdoc fixes
v4: https://patch.msgid.link/r/0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com
 - Rebase on v6.16-rc3
 - Integrate the HATS/HATDis changes
 - Remove 'default n' from kconfig
 - Remove unused 'PT_FIXED_TOP_LEVEL'
 - Improve comments and documentation
 - Fix some compile warnings from kbuild robots
v3: https://patch.msgid.link/r/0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com
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
v2: https://patch.msgid.link/r/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com
 - AMD driver only, many code changes
RFC: https://lore.kernel.org/all/0-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com/

Cc: Michael Roth <michael.roth@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: James Gowans <jgowans@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

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
 Documentation/driver-api/generic_pt.rst       |  142 ++
 Documentation/driver-api/index.rst            |    1 +
 drivers/iommu/Kconfig                         |    2 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/amd/Kconfig                     |    5 +-
 drivers/iommu/amd/Makefile                    |    2 +-
 drivers/iommu/amd/amd_iommu.h                 |    1 -
 drivers/iommu/amd/amd_iommu_types.h           |  110 +-
 drivers/iommu/amd/io_pgtable.c                |  577 --------
 drivers/iommu/amd/io_pgtable_v2.c             |  370 ------
 drivers/iommu/amd/iommu.c                     |  538 ++++----
 drivers/iommu/generic_pt/.kunitconfig         |   13 +
 drivers/iommu/generic_pt/Kconfig              |   68 +
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  415 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   11 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  259 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1162 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  713 ++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  487 +++++++
 drivers/iommu/generic_pt/pt_common.h          |  358 +++++
 drivers/iommu/generic_pt/pt_defs.h            |  329 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h    |  233 ++++
 drivers/iommu/generic_pt/pt_iter.h            |  636 +++++++++
 drivers/iommu/generic_pt/pt_log2.h            |  122 ++
 drivers/iommu/io-pgtable.c                    |    4 -
 drivers/iommu/iommufd/Kconfig                 |    1 +
 drivers/iommu/iommufd/iommufd_test.h          |   11 +-
 drivers/iommu/iommufd/selftest.c              |  438 +++----
 include/linux/generic_pt/common.h             |  167 +++
 include/linux/generic_pt/iommu.h              |  271 ++++
 include/linux/io-pgtable.h                    |    2 -
 include/linux/irqchip/riscv-imsic.h           |    3 +-
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 42 files changed, 6237 insertions(+), 1612 deletions(-)
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


base-commit: bf3db0366052dcdf7dea89a07929b690aac59b15
-- 
2.43.0


