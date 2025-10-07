Return-Path: <linux-kselftest+bounces-42832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E45BC20D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9393BA0A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A92DCF78;
	Tue,  7 Oct 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfEf1Ryb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC531E835D;
	Tue,  7 Oct 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853539; cv=fail; b=Jv3M19CUvQv9HZfvwyjpCtYgildwVU6bSuSY/ZKHmL+gbKj4Lkcc1CVjVkRFjxbbpbZl1WtQUexDLoOuEUMZWFH9K7Nqy/50eUgTxTpo/YNAl0jb2vdxNniVP86tNsmn469NdVOfH9RPtTyNeqHaF6rrZAYmrLu15cLZbDv7AOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853539; c=relaxed/simple;
	bh=rSJJ1PL9x6Qfm4qSjr0p0lskLObKij/YX+21Iq2oqzU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EItdsjnHPTEpHjwg5y2jLOBIaRhDbXCtBT4VwD/z3n8IlOvMLPKe6YGcMevKFB6PayfzFehVnB2cUOBa9DLt3K6dK+X+WxrlDULhbWTf37SYnCdkp7Plb1VWeljIsSWGKY9RV1DoB69aD7wzqf5wUvfl2NgGC8rjvqfgZ0lujd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XfEf1Ryb; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r87Sca+TKFxK7Q7UYDiguGCXxCgoUY2TGFRoO8NelfY8te9ufKBlKv3/XsSslj5q4/efZEeAGWOTH+C0Qvl2yXksmp3wLMUOfdiFsqRgvCMNea5X3ivR9zsCU3EzSxcYPtJUsL4l3Z7OfN4zvYWZGvuBV3nYimJyfvWQp5prtO0n47tZ1hW2GwYbSEtO+0XWKZadqIw9rd3A6VA51nFMwgH1d93PK9CGHlnSQ+sK34Phpq4EW7ySxvHbhqBemcNq1xOSny5D3x2VDBZ6Pdud25DA9zMloyl4JQC6G6rngunwRhmFxNN2W3vO2mWEff/RfAz0SYGkUzHfWQbUTdU58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCJnmBSR5UFUr10r4EM+OJ+Icc604y7553lKNu0yrhw=;
 b=drAZjGUuaEaFjh4tCOXMw8In8ATKiy0gSPzOC1ZB9ucPZOGptiU84Zm/d23E/+jvufIjv+k7C2c7y+o35Ogvb0gLnVTO1zjL8fm5pIOU60fCZeEZ0mIQ8N2jxvpA0a+n1mJG8I+PCXuOpseWNpkfIaa/l+/VxPj0a4O1tVBFUYAyxglZ8qpRsMrKRSBL0FQopE6RMgD5WyXpoAZU34GpuRamuNsxZ3IYjdskV4+03m89f1HpLPxnjksQZ/rrNyUdkIASKzKNZtvF3JzzP8HlUofpek7z49HSa5WrKahD1pTroc8HMPz7RgFA627GVVjyFnxhCLol1g34CNclNFpn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCJnmBSR5UFUr10r4EM+OJ+Icc604y7553lKNu0yrhw=;
 b=XfEf1Ryb1T0BYJ0N3+0lJ1Jyi2S80w/0KJsjM2tx+MGJYyyCR2Cp26FcUTjuE+kXQ/UvVdi9Ks/sjcUU8Q9yG+3g8ymR00eGfSfVoMmjFM17FXlNzcfJVmJICpTU+EzkF/aCgSNg/2w7VXQXhGoHJQ+bfg9P51K7ocWZGWwY7iIeP7yD8okKiBg7qFECdiHrorx353j7JUFCebJ9svwaR503ptcZwiOgznNzKaF6C2MjcwZ6irgxfzAGXJmlNpdGYBkCTvUVGiaCSqADnx02Sb8BSV+jW/PLJMX48+58ScINVHSgdga6Fy0yS/qVdNn2OAg+VF7xqCfv17ali+P/VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:12:04 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:12:03 +0000
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
Subject: [PATCH v6 00/15] Consolidate iommu page table implementations (AMD)
Date: Tue,  7 Oct 2025 13:11:45 -0300
Message-ID: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0387.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 68064bac-39c9-4105-77ab-08de05bc406a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vpy8gaISGTE1gwkoJ+CReZ9VEOF45LdJHjHTFyXkRlHVEsi8fJ4GGcwD+Wzt?=
 =?us-ascii?Q?Q150WgC77YTYo8mGZs72hkxUlluS2wFbsV51Z+LOI7K6NIQgu4CfNmzhZPc+?=
 =?us-ascii?Q?Q4n0vaGeAm3Xt0I1C32pTROf78fULzTQ7ts+ETSY5PKKpFI3ibhWbG5HhQ2/?=
 =?us-ascii?Q?0pVys8q2nQXhf91OSjyCVfScKLO1P6HhQqcbpBl9Fr9O9qhEKfoQnaHWilYr?=
 =?us-ascii?Q?8GUCXF1DMjcqOwJ1ys23F/MWvg6H+nhrmrJ2DX9aFBH896e8ESNDwf+LsPPJ?=
 =?us-ascii?Q?cawzfToFq0Edw8fXpSnFjWb8wKJkD/MsjARk1iiDJXzGKfc/jS3YNPeP6RVb?=
 =?us-ascii?Q?nTqdvoUO7xUQX6LGS/Rgwf35w0o53xt29JTWbuqx3tf0yq7DrNWoLTge2kR1?=
 =?us-ascii?Q?Zlfq47wTho0QHxwKTxXK5y64BzHYVDpUJgyZED8Go7twYLMDZBU/zIVKe8K6?=
 =?us-ascii?Q?ql6LOvTykFl1AXyeSh1JZsSB9rTqfnqqYWTInioCjlU1jc6vUIPEphEygTRq?=
 =?us-ascii?Q?l2MdYd5DHwTDoR5uqGWbTAebHal/gWzJ3FE5Ug9lYgPVlGZfOhQL8Q9oezPA?=
 =?us-ascii?Q?qpG2H/C+AWlkQG4AFWZ8qQbdqMYjWjVgQplsg93fLFz3boeLgoLpxESSYICJ?=
 =?us-ascii?Q?1uacV7DZsBw9MQADoUopBqanrFSfgkKA+45T9lEOhn0tvwDvphnx6u4LSI1/?=
 =?us-ascii?Q?YYoKnOzJ8OM4VYkBvoVX1KbrLzcci6es9haLQPtDMH0qe+WlP23mSnjgiRiw?=
 =?us-ascii?Q?dlTTNkm+gQilXw6caZdKBB74nLSnEdQCop1HOeaFB4sRhI+Z1rOE7Znc2M+K?=
 =?us-ascii?Q?U1OmzkgyXvhLAP3SjGKl1Wsaot1udwO2+j2JXA1z4EaB30M6nQbCWaY8xz8s?=
 =?us-ascii?Q?3mPSTjzr/2wqaCFc8WLB0Oy+itRo9cnydR0w6yz2oZeKEPBv+Z2hqGc0nFvc?=
 =?us-ascii?Q?kr4wyUmB9NNVCxtnqGXyqqFh/oNEtWqU1d23b9abxS+wGjKEbya109VUD5kT?=
 =?us-ascii?Q?52Qu5i1oywdlg/GEb2k80sbzsvR+2Ae0i5BBPwrFmEGV076l3oHQ4Vr1BFJi?=
 =?us-ascii?Q?5OigeGwVf6nzI5HvffGyuPjqh9jti8N+zxViW2xtBoHne0xON7KcjKnmRP4V?=
 =?us-ascii?Q?vBlTdGnFaEZjt/Hpx2+0rszMyl7aA5vYbASI2G+bdk6BmFyIs8KqrRCpCFaS?=
 =?us-ascii?Q?k0BxQ6MsiRdMHiXiPZCrHo2CPBfFdAKzs9jUrO3dLerB0uSoqdoYXIdZU0Xs?=
 =?us-ascii?Q?cDcZEWdozlhivy4rpxfX0XYE4j8jQO+RJh0OSUApS06PbztxUqlvjOj3M7pe?=
 =?us-ascii?Q?6VIDxRlvGc/e3lP1INDGi21qsOxFz6M6UnkbbfF+fA3frXV2hUxjD63a/ZGQ?=
 =?us-ascii?Q?evXldZZnvPu4ep4qTeH4h4D3j3Moucw1/4Fxy0McKRxa+VHrL1kLtiJ++v/m?=
 =?us-ascii?Q?MUQNFVa1s1ajJ31kVnanbGM+oP5pmCYfqBQEy/o7APSonffY1woQQ7n19aeW?=
 =?us-ascii?Q?fx6IJk9oEIH/kIHy97Vm14ZFR6CUonyDJ3Qo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lf9FxoQF/GJLpAlLe2C0JIa/XfZhJGZ+SJJtVPEjWyu0ZllyDqK/ZtKPXmvl?=
 =?us-ascii?Q?QwDNFAbVnzxjUyLy1qKt7UWYqNJV0d1Xf7M+9lY3M9o0W3WZJDGJyWJp1/Io?=
 =?us-ascii?Q?CnV0Oqu01eC3kcQVZSd1otH2UOxWViTusMdwRM02EljYXIRsLNA/gInmeRas?=
 =?us-ascii?Q?pa4ES5EKKN/tzCwJN581a/i+XHgEPC6g/jV3KK6CAtLrXt8zLLGe5m7hozlL?=
 =?us-ascii?Q?rQWRlt2BLH9Sjp+qeb85ePCePAcqq0pULAoKAeoWRbaPiwse0eGpP6U663pj?=
 =?us-ascii?Q?09Imv9PPU+xGcIgWx5vmZ/yywtygPy3Ib5tc0w9g5NguRs19MYLTNyxRVPiZ?=
 =?us-ascii?Q?D8JG2WnMM+wtjJ6jJJ3/k/sAlNqQxJYIRZzGcL1bu19OwX4BA510L8UrqX7U?=
 =?us-ascii?Q?wc6H7P8AyrqJiPnKJ0BhBSnIIHROVOhbPKBLFfGgs/Jo6GBpV3PG/fiZchrh?=
 =?us-ascii?Q?yRpdIq6d5b1gOYfYkowc1EiX/zYhL53pzcVMDdLyHcUKeMpa4WW4IGnuwwAT?=
 =?us-ascii?Q?V+E/iKi1rmWabWgdUSgSS8anU/PECB4sus6UAmXRWnFdVyGMMx4KW5y0QPVy?=
 =?us-ascii?Q?jvBxfhpuAh7tirUI7XbGRe15txneSEyhphBZByjW7qZOb1B5gN9biVqg//Wk?=
 =?us-ascii?Q?R+Bzx3BGveVQxZ0iEA9V0/CW31ssVKJ+BAN1pirN35r2MWXkxyhM7vdpnCfo?=
 =?us-ascii?Q?goaaweiwG8AkaZlfXSwtGg3iPD9Fi4otljtQBHpSNqj8aQliPsUDaQgXYxSr?=
 =?us-ascii?Q?f3JZQFGDKLLK1hr7Iu97T0XtD0wtP9go2qe2kGViGFJcjqnX5AxNO1huuUrn?=
 =?us-ascii?Q?8beXuQBrkfSnFj7MXLnwV/WJN6s4X2zLigHCTmwc1iWeFBuhYHSoOTB4roP+?=
 =?us-ascii?Q?uYDbBBq6ol6vfh1zY9R9/yYaqwIQ/zXg7/jF06uwxluePLdmEdJxQXkgMbTH?=
 =?us-ascii?Q?Cwtxs5D5pS8RCYyQ6P545NymV1X10jWYDsL3Xcut5xOFU6iaFxkE4QlscXbT?=
 =?us-ascii?Q?dCvshHMPw/r/E+M0kaYAPeUPU0gfYUTj83xv0c+bpcMrx8ztYSmFV8YBRwJP?=
 =?us-ascii?Q?waKHy5kLBQAxuK712GRqEiyMS/SQHnKKR1NSOJoDnk4E+5On31+NG1oBVD6W?=
 =?us-ascii?Q?AQxQ243WPY3vU2I7WLIkWkzAGsXNTBU6iYbDfPzEW9VAqSt9RPvPissS2wJK?=
 =?us-ascii?Q?IBBv/O1I2+lJ4bNTyUax208Q3bbi/V7zyQuW01h4JcfcEW4Y0BRjjEmqUMV+?=
 =?us-ascii?Q?naYlRrXFzqy2J6hoGlRCnluAINrApiWBo1zT5QD/Xeh6QNuB+rQZJqFCjPo4?=
 =?us-ascii?Q?ktnnwKdY7shBJWL7WYoID+rr2yO03eBhaIGgibblwnAoqajJqoMd9L78weOA?=
 =?us-ascii?Q?9a2Vq8XhxdB57L7pkAbpbCbIcYTSwL/MAlgNdePWbEK9I9c6Kokxk0RUlPKA?=
 =?us-ascii?Q?x2lR0Gm2BuAv5JXd2iw0Zn/4MYoRbrxUfyEEyAEh8uk2BUBl9QTFXVBrhCEs?=
 =?us-ascii?Q?sj4q6947jo8/Q9CW7PbKu7MCT7TuLIKSk528UH70OcBtRcC1CCr2DyoIBAWj?=
 =?us-ascii?Q?FQjVJN4Jk+73L6pVp68=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68064bac-39c9-4105-77ab-08de05bc406a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:12:03.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7sE+h255zEVEiMkEM1TrddlPiUHD2DyMWPtBG/n9p4uEPfu9PcJzIU2in+j2rBK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

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

v6:
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
 drivers/iommu/generic_pt/Kconfig              |   67 +
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  408 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   11 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  251 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1157 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  713 ++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  182 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  486 +++++++
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
 include/linux/generic_pt/iommu.h              |  270 ++++
 include/linux/io-pgtable.h                    |    2 -
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 41 files changed, 6212 insertions(+), 1610 deletions(-)
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


base-commit: cc1d7df505790fe734117b41455f1fe82ebf5ae5
-- 
2.43.0


