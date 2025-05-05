Return-Path: <linux-kselftest+bounces-32358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB815AA9570
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F1D7A9383
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407A25D1E5;
	Mon,  5 May 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HY5GtlQ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625425CC58;
	Mon,  5 May 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454747; cv=fail; b=cWjoaTZWFtDEsZAdFqZUTo7uypzM46Bsj/03xYRRmA9voeGSqTc0rtWRBmyWmZDB+x0XUC6ULqz47AEnVVxId5SbwINY52rdE6CYEzIBzYNrDsIEaL/GYNgXRKbHdFVeCCZMeHWk3jTNjRzP1ZWlnP4JL/bB13IVB7GmQnTadww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454747; c=relaxed/simple;
	bh=fOuez6sk1rCnMF5MPQFdnuPXmXirJgPGqcjiBLMrwGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keeforuFLi2/8kkatziKaMZwPgS0y3OoP3SeNgAwXKy3ATv1viMUjanzQaQ/J6Nhj/hvvHHbXfGJslFOFQw7CFnAPuP95RihjvG9Mzx6RLcpjcHghRdyfqzODBENHrRpa/dWKlvlIr8nWvYw1gNBSWfC3xENlvfF/lc67yVP0SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HY5GtlQ0; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjKTpMTzI6nAehZLogKfKMtk1i9VWZUXED267X6kF2o6Mydom6jyG1esS59aHOBM931fVzjTZsjfm7CfOVr7Tu5skRTLshBp6gEGAuDLsbKaCHP+fG73l5zNFR+9ZO3cXEjYGJhAZAEN1jqz3A+xeuev7+HNIiechLO328+5RwSesVYEt6SiIAvC496vKkdvTucqebXpmvVXdBW9kXGkvykvLJzUzb/5oA0TvWG3O4CBKBR+2EsOxUdNHZc7r4xCiMOQy/POGJLo3hvdsg7e7JODizImgIY+uvJ3yc3vxf7JuxDRslDJ2XKdGoAsKe1CaZrcsm99RHelg6kAb8Nh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gL/AsOciexrs0WlawQFo2rfbnWAIpMNjIJIJ+NvRNg=;
 b=Wpn/9jaNAyYN2SnSENmdzCy9ABwore8/kZhUW+agO1IWGss7fyk0FWtNvLn6nOEPO22dFaXSKecEFhxAL7KIrZZ+GF0ihwQyU1pxFps7dc5pIl1XQ0pCUI7g9DMNjhl2vu9rdG6cVoIiv+jBpyu/g1YtZ9gMhcq3/1JhEgX9h7O2fqhWsdmX3GDiF5t7i+RsNA3b/mkfnPfCodCZs7EQ0maUshtg+DMsJUaKXwHyev+pPo/+wulp+caysQA2VWkdOQ77eKBMwWEPyrbdkibVaxIfLWRNbK7wU6/nobEP3691wvk0Q13k0eg8Eitrbh4idJ03As3lfSH0dhHWAG/SaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gL/AsOciexrs0WlawQFo2rfbnWAIpMNjIJIJ+NvRNg=;
 b=HY5GtlQ055sl2BtO+DAe9IlnDg4IIfHFaYKAxRvk840bDfnt3Klxe+7B86dwn10Y1+BHYNmWo2fO5A510esmU8Tm9utf4zOPsOv2xsnkn+d0mz892Dg9lp261fcYscKkTRoG98tXBPCb0HCJbHkeEqC4r4Z0Dxua4sanu1B8VUenlZaL2wBqWZXscruxw2BEzd8PbYOyeGDZhB74efvVhe9tQTZsroa5U+rEJQmJ4FY/lC3OAWNgraSD0+S+8piMLb7GPv3YNzz5OLTWzXoUNMeVXoE7MdAwj+HeOELIStlalz3y1yRwm9wUxq0LAE3aCYkDyo0sUs4+4OqrbTn/bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:50 +0000
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
Subject: [PATCH v2 09/15] iommupt: Add a kunit test for Generic Page Table
Date: Mon,  5 May 2025 11:18:39 -0300
Message-ID: <9-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:408:141::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: e2039c6d-3b3a-43c4-a937-08dd8bdfc02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yn5zreCt+qFaxltlEqhs1NrjTj/8CREsZ7Bvv6vT1k7yoadq8Z8B5TibDCbT?=
 =?us-ascii?Q?L5r0m2c5MclL5W9Hs2CqrLLytTxHrn628IBfyKza2xrc35Sf0W5t3tiYkUJu?=
 =?us-ascii?Q?/pYYxKbv/1s48nc9ipaZ78kleUUu0y4bEdIKG8/G89tEFko3JwzJGc2NYTcb?=
 =?us-ascii?Q?dXyo1GICDSpm96Lm/g2DoCPWctVHyhM10hvLDeY2D/kPOw5Y8pcxSI4nJPuC?=
 =?us-ascii?Q?uSgHmr8c9iQ4g1chCx2j/vDF2lSACtcHxBImAiN0L3s/JpQyoEdaV/CSuia9?=
 =?us-ascii?Q?zzvDE0f5Et4UIVgEJUtNzjza08hdJiaVXVwBV5v7ZTuXdF13U7pKt7r0tFxo?=
 =?us-ascii?Q?NrWusXrbcEUzESDEyYSykYKfB6dOaEBNbnXGM9eM2aWqeIIZg0PjqnzBkJGj?=
 =?us-ascii?Q?O5PcDu8LB4JaoxX6SV2cMOqyxyAHlHUYH4etwu5dWs/8BYr5pCuF+oV4/ck4?=
 =?us-ascii?Q?Mz8dAN5UwAcSI4u1n03iEzZ4B+oRMHDcC/F/EUlfyDUPwkSIYXzxyabdqDgw?=
 =?us-ascii?Q?lYLicLQ/sxiMf0D3hBbwwcVIQ5RdlyIIW2OcUInfEak/10enHKmrb7/044Do?=
 =?us-ascii?Q?ITL0B0IQltutc0fCAiBnz54qa5VZzbl2Mb01mcmjEpF74Uh/qLT0s/mukVNR?=
 =?us-ascii?Q?tsgMVQoJVVy1mB9HOmWhrxU4bxYwHZwfp/bH8LfVDxO0/ZoculAs9o66KmEZ?=
 =?us-ascii?Q?aVRObN/IpDtKJX1N7ZznsyCXogrJKVU8b4YTccE20bjF/PeS78hr3wC9+x/x?=
 =?us-ascii?Q?i8AAVESlz/K5yCrIp0zQvaBn1bowGVVBmSmLGq3A2tL8P8CVNXJAYSHGZlBc?=
 =?us-ascii?Q?pvsXBXZ8YyM/4CQ1012KRYiD7fI1zH6EExpXvv3gMJihQ3TOnrB7uwbUwKaB?=
 =?us-ascii?Q?9dyFpQmfZR/jE7lA3PygzDraEfhIFvDgjLX7IQCVQulRTXCC3mckE4jJWlkK?=
 =?us-ascii?Q?QudZ+BAhUsJ9H62Gz+ANwBVTlLm7EqR/lKQFXkmNq+US9PyjTq9dDc3Oofvv?=
 =?us-ascii?Q?Op/XEv+efxDeMX7FW+Hs5noWc9A3c7AmRWpubIArtQAzTA2ATjBk87eHB95T?=
 =?us-ascii?Q?bZM5fLShfpgg9F9LJMCWzHACkL5nDKJgThP0S3Sxmzzs8ygA4vNhqoH7A+C+?=
 =?us-ascii?Q?wxRpQeqYuSZjk3vxXiT07WlOLjHCwxKkgSkr8F1cTcA4EKaLUYmJmI/PotQk?=
 =?us-ascii?Q?AvDprr2xI55EUjeswRTlTjdXRUt6JuAlcOVCj5ObnqLabwCwMlelml9vRpRZ?=
 =?us-ascii?Q?EX4krrfb3ip+ddgjFVLczzp032UHNYSOXYh6moyIGegX90nIfdruJD9ixRY2?=
 =?us-ascii?Q?2fKBtq7CTV6wHBXxeJRc5OfGcQLFaV3Uyqj6zkNWUyaxwhuLy+OCCxbotPn8?=
 =?us-ascii?Q?+V7nmo2SiLNnmqbHSrGN+aHnYz8nXt46NpSHNfckDFUu5qZiATi2pJSjuWix?=
 =?us-ascii?Q?mNOQmXqwxfS0nMA6ppQ7V0ZLmZBswW/Ycgu/CQgYWqYXdZGzy9jvqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0S0fZXHiw0nJCd+wBUfm/3pmL7jErm1ggyFdOjF5Kr0FJkHdBHldYBtSDOM?=
 =?us-ascii?Q?hxcR6MoCam7DY8CQyj0jULuL3DSjE3DyfB7QfsIan9Hm6zbP3cAc4ohJLhHR?=
 =?us-ascii?Q?EVDYPA200RxWjUlUtX/zn9mqw2hS56tLkhe/mgsLEs0e96NddLAeHeJp5ZPr?=
 =?us-ascii?Q?s+NifzFfnFYKz0nTQMrgYL6GLu9ZdYQ+wU0X6c4NcFQmOj9zT5GPPCu9awO1?=
 =?us-ascii?Q?V+ZT/S7GBYdmjQbMuYpXCW0ZVSrJKe7wTgtLkazC2oDB3eskcuy8cowEEdfv?=
 =?us-ascii?Q?0TR8QKSl4uQ0njcrajqZRolsWo/1BJFewDXd0KSL9cQZqQMtwPJvv6YNdNGy?=
 =?us-ascii?Q?QzFtM06oMj1eHtnCSqU9WDWaRVlvzIHyljaseg1Zi7kNHntQ8lre+hWaoJu7?=
 =?us-ascii?Q?WuDAb6O0gTj273FjFyb5PGaGsyKLKzpbVCFE3KHyRvkf9oS2vVBizckiZP0r?=
 =?us-ascii?Q?US5TFDhsLpTnw9iv+alu5RARYrmPgbduRhhL2yVBTAuSqXmlTpapZvmaxN8i?=
 =?us-ascii?Q?9EN6iGNtxdViAgUuxJdKlA9iB0mx1dDmQMt6ft9xetlFlymPt/iTnidH3S7o?=
 =?us-ascii?Q?3iFlW48ZFdhh8XUjkAL5+fJVGaqGGx8mOYQQxxiUNJHjApD01somgzgju2t9?=
 =?us-ascii?Q?WT1hJXON9PGZbkPB9xo/TAplj/ESQu8dB2y5URAddCwjEiWbTL2oSZnyw8T6?=
 =?us-ascii?Q?B3pk+6lLwbZisCqY9spctllg+7NPfjAHMvpD1fp0Zsnoumb79Simy1n25YUH?=
 =?us-ascii?Q?NHrXapBcgW1DWOMuRqFQZ9Kpy1OT1JbMokXFz88gRXzQPQtwiRe0E7DFZkDy?=
 =?us-ascii?Q?IrdGlKYJczDbaqHWncZibmO7p8e3aUqngw+xDg4bhkjX9NLXWWxYGluHzpVY?=
 =?us-ascii?Q?io2/drMExl767XB+rc6NJrbVAyVqK/I3aWlnUrKVNk8wetJi/Rub+RnxHQKy?=
 =?us-ascii?Q?kzq+3kTVGUYPTVMftIN89mN35p0PXysiOSz2Q40Kc1lSe6aXvBbQf6O9zqje?=
 =?us-ascii?Q?FQPwD77KN6gPsPsmJBZzVNOAt/n9Z/EAOztOTH+PZutsFURS8d2hxjnyQG7P?=
 =?us-ascii?Q?SV2UeLJ1+MlqtDDXw0vl79/HcFpfyV1bQpsQw9qySdRTOTiuWazC+e1vKoOE?=
 =?us-ascii?Q?PF1O9PC9YVpQvojFKmNMh76f5hQXIshWDElD5+DmV2BUVkh5aFSzS4g8jnpO?=
 =?us-ascii?Q?FWKyuDgWRc7SYoqNAm0A8ktUAzPzAoSrna6jldv/8ecuGvT/dFJ1aylGg3Qb?=
 =?us-ascii?Q?nWFVuUaLaK5zIuYpMRl5r+8dVwwyQHiIWv7gc/RVvOvb/tnFuXtBWtkgIlxc?=
 =?us-ascii?Q?wgeZ/6DRjhoaZZvomt1UXEqvq+o5/uT2rJXfBcAxHwpgwBvz+wT4wUvrgUAX?=
 =?us-ascii?Q?ZwXJOVTD27WlgHUmJyxS2+bF+XtMCjtHFHX46UwYhBkydLScfG6GJrxr5HiD?=
 =?us-ascii?Q?1LmKMq9HIK01bqNfEHeIEuIwtxRbVRI2zR6Yi5n9vN+DmzGxrgItb9LPSHqe?=
 =?us-ascii?Q?dxcYIUdUJYAKkzutKu/w1j8XW5DCHNjstkaBfXf7pdUWfy7Jq4Vp2mnx6QFQ?=
 =?us-ascii?Q?lJ/8CdSbrlVr8nluxE8pFlQtWLPdWSULHt399E4Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2039c6d-3b3a-43c4-a937-08dd8bdfc02d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:47.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5G7CKKM07SNPHVcbA8Z6UTss3LI2frw3jd3zvCZTLwbXPf8UQP3jnxohH+ntgMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

This intends to have high coverage of the page table format functions, it
uses the IOMMU implementation to create a tree which it then walks through
and directly calls the generic page table functions to test them.

It is a good starting point to test a new format header as it is often
able to find typos and inconsistencies much more directly, rather than
with an obscure failure in the iommu implementation.

The tests can be run with commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=1 --make_options LLVM_SUFFIX=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n
tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y

There are several interesting corner cases on the 32 bit platforms that
need checking.

The format can declare a list of configurations that generate different
configurations the initialize the page table, for instance with different
top levels or other parameters. The kunit will turn these into "params"
which cause each test to run multiple times.

The tests are repeated to run at every table level to check that all the
item encoding formats work.

The following are checked:
 - Basic init works for each configuration
 - The various log2 functions have the expected behavior at the limits
 - pt_compute_best_pgsize() works
 - pt_table_pa() reads back what pt_install_table() writes
 - range.max_vasz_lg2 works properly
 - pt_table_oa_lg2sz() and pt_table_item_lg2sz() use a contiguous
   non-overlapping set of bits from the VA up to the defined max_va
 - pt_possible_sizes() and pt_can_have_leaf() produces a sensible layout
 - pt_item_oa(), pt_entry_oa(), and pt_entry_num_contig_lg2() read back
   what pt_install_leaf_entry() writes
 - pt_clear_entry() works
 - pt_attr_from_entry() reads back what pt_iommu_set_prot() &
   pt_install_leaf_entry() writes
 - pt_entry_set_write_clean(), pt_entry_make_write_dirty(), and
   pt_entry_write_is_dirty() work

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/.kunitconfig         |  12 +
 drivers/iommu/generic_pt/Kconfig              |  12 +
 drivers/iommu/generic_pt/fmt/Makefile         |  12 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   8 +
 drivers/iommu/generic_pt/kunit_generic_pt.h   | 721 ++++++++++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        | 181 +++++
 7 files changed, 956 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/.kunitconfig
 create mode 100644 drivers/iommu/generic_pt/kunit_generic_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu.h

diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
new file mode 100644
index 00000000000000..936c327f0661cf
--- /dev/null
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -0,0 +1,12 @@
+CONFIG_KUNIT=y
+CONFIG_GENERIC_PT=y
+CONFIG_DEBUG_GENERIC_PT=y
+CONFIG_IOMMU_PT=y
+CONFIG_IOMMU_PT_AMDV1=y
+CONFIG_IOMMU_PT_KUNIT_TEST=y
+
+CONFIG_IOMMUFD=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_RUNTIME_TESTING_MENU=y
+CONFIG_IOMMUFD_TEST=y
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 887c585a66699a..835aab50dde374 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -44,5 +44,17 @@ config IOMMU_PT_AMDV1
 	  power of 2 and decodes an full 64 bit IOVA space.
 
 	  Selected automatically by an IOMMU driver that uses this format.
+
+config IOMMU_PT_KUNIT_TEST
+	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
+	default KUNIT_ALL_TESTS
+	help
+	  Enable kunit tests for GENERIC_PT and IOMMU_PT that covers all the
+	  enabled page table formats. The test covers most of the GENERIC_PT
+	  functions provided by the page table format, as well as covering the
+	  iommu_domain related functions.
+
 endif
 endif
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index a4d83b7e0cf691..32f3956c7509f8 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -2,10 +2,22 @@
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 
+IOMMU_PT_KUNIT_TEST :=
 define create_format
 obj-$(2) += iommu_$(1).o
+iommu_pt_kunit_test-y += kunit_iommu_$(1).o
+CFLAGS_kunit_iommu_$(1).o += -DGENERIC_PT_KUNIT=1
+IOMMU_PT_KUNIT_TEST := iommu_pt_kunit_test.o
 
 endef
 
 $(eval $(foreach fmt,$(iommu_pt_fmt-y),$(call create_format,$(fmt),y)))
 $(eval $(foreach fmt,$(iommu_pt_fmt-m),$(call create_format,$(fmt),m)))
+
+# The kunit objects are constructed by compiling the main source
+# with -DGENERIC_PT_KUNIT
+$(obj)/kunit_iommu_%.o: $(src)/iommu_%.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+obj-$(CONFIG_IOMMU_PT_KUNIT_TEST) += $(IOMMU_PT_KUNIT_TEST)
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index 0f445ab59c8495..c108ca97aa4ec5 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -380,4 +380,14 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+
+#if defined(GENERIC_PT_KUNIT)
+static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
+	/* Matches what io_pgtable does */
+	[0] = { .starting_level = 2 },
+};
+#define kunit_fmt_cfgs amdv1_kunit_fmt_cfgs
+enum { KUNIT_FMT_FEATURES = 0 };
+#endif
+
 #endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
index 5b631bc07cbc16..11e85106ae302e 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_template.h
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -36,4 +36,12 @@
 #include PT_FMT_H
 #include "../pt_common.h"
 
+#ifndef GENERIC_PT_KUNIT
 #include "../iommu_pt.h"
+#else
+/*
+ * The makefile will compile the .c file twice, once with GENERIC_PT_KUNIT set
+ * which means we are building the kunit modle.
+ */
+#include "../kunit_generic_pt.h"
+#endif
diff --git a/drivers/iommu/generic_pt/kunit_generic_pt.h b/drivers/iommu/generic_pt/kunit_generic_pt.h
new file mode 100644
index 00000000000000..61fff73d7cccf0
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_generic_pt.h
@@ -0,0 +1,721 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Test the format API directly.
+ *
+ */
+#include "kunit_iommu.h"
+#include "pt_iter.h"
+
+static void do_map(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		   pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, len, (size_t)len);
+
+	ret = iommu_map(&priv->domain, va, pa, len, IOMMU_READ | IOMMU_WRITE,
+			GFP_KERNEL);
+	KUNIT_ASSERT_NO_ERRNO_FN(test, "map_pages", ret);
+}
+
+#define KUNIT_ASSERT_PT_LOAD(test, pts, entry)             \
+	({                                                 \
+		pt_load_entry(pts);                        \
+		KUNIT_ASSERT_EQ(test, (pts)->type, entry); \
+	})
+
+struct check_levels_arg {
+	struct kunit *test;
+	void *fn_arg;
+	void (*fn)(struct kunit *test, struct pt_state *pts, void *arg);
+};
+
+static int __check_all_levels(struct pt_range *range, void *arg,
+			      unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct check_levels_arg *chk = arg;
+	struct kunit *test = chk->test;
+	int ret;
+
+	_pt_iter_first(&pts);
+
+
+	/*
+	 * If we were able to use the full VA space this should always be the
+	 * last index in each table.
+	 */
+	if (!(IS_32BIT && range->max_vasz_lg2 > 32)) {
+		if (pt_feature(range->common, PT_FEAT_SIGN_EXTEND) &&
+		    pts.level == pts.range->top_level)
+			KUNIT_ASSERT_EQ(test, pts.index,
+					log2_to_int(range->max_vasz_lg2 - 1 -
+						    pt_table_item_lg2sz(&pts)) -
+						1);
+		else
+			KUNIT_ASSERT_EQ(test, pts.index,
+					log2_to_int(pt_table_oa_lg2sz(&pts) -
+						    pt_table_item_lg2sz(&pts)) -
+						1);
+	}
+
+	if (pt_can_have_table(&pts)) {
+		pt_load_single_entry(&pts);
+		KUNIT_ASSERT_EQ(test, pts.type, PT_ENTRY_TABLE);
+		ret = pt_descend(&pts, arg, __check_all_levels);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		/* Index 0 is used by the test */
+		if (IS_32BIT && !pts.index)
+			return 0;
+		KUNIT_ASSERT_NE(chk->test, pts.index, 0);
+	}
+
+	/*
+	 * A format should not create a table with only one entry, at least this
+	 * test approach won't work.
+	 */
+	KUNIT_ASSERT_GT(chk->test, pts.end_index, 1);
+
+	/*
+	 * For increase top we end up using index 0 for the original top's tree,
+	 * so use index 1 for testing instead.
+	 */
+	pts.index = 0;
+	pt_index_to_va(&pts);
+	pt_load_single_entry(&pts);
+	if (pts.type == PT_ENTRY_TABLE && pts.end_index > 2) {
+		pts.index = 1;
+		pt_index_to_va(&pts);
+	}
+	(*chk->fn)(chk->test, &pts, chk->fn_arg);
+	return 0;
+}
+
+/*
+ * Call fn for each level in the table with a pts setup to index 0 in a table
+ * for that level. This allows writing tests that run on every level.
+ * The test can use every index in the table except the last one.
+ */
+static void check_all_levels(struct kunit *test,
+			     void (*fn)(struct kunit *test,
+					struct pt_state *pts, void *arg),
+			     void *fn_arg)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct check_levels_arg chk = {
+		.test = test,
+		.fn = fn,
+		.fn_arg = fn_arg,
+	};
+	int ret;
+
+	if (pt_feature(priv->common, PT_FEAT_DYNAMIC_TOP) &&
+	    priv->common->max_vasz_lg2 > range.max_vasz_lg2)
+		range.last_va = fvalog2_set_mod_max(range.va,
+						    priv->common->max_vasz_lg2);
+
+	/*
+	 * Map a page at the highest VA, this will populate all the levels so we
+	 * can then iterate over them. Index 0 will be used for testing.
+	 */
+	if (IS_32BIT && range.max_vasz_lg2 > 32)
+		range.last_va = (u32)range.last_va;
+	range.va = range.last_va - (priv->smallest_pgsz - 1);
+	do_map(test, range.va, 0, priv->smallest_pgsz);
+
+	range = pt_make_range(priv->common, range.va, range.last_va);
+	ret = pt_walk_range(&range, __check_all_levels, &chk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+}
+
+static void test_init(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	/* Fixture does the setup */
+	KUNIT_ASSERT_NE(test, priv->info.pgsize_bitmap, 0);
+}
+
+/*
+ * Basic check that the log2_* functions are working, especially at the integer
+ * limits.
+ */
+static void test_bitops(struct kunit *test)
+{
+	int i;
+
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u32, 0), 0);
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u32, 1), 1);
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u32, BIT(2)), 3);
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u32, U32_MAX), 32);
+
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u64, 0), 0);
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u64, 1), 1);
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u64, BIT(2)), 3);
+	KUNIT_ASSERT_EQ(test, log2_fls_t(u64, U64_MAX), 64);
+
+	KUNIT_ASSERT_EQ(test, log2_ffs_t(u32, 1), 0);
+	KUNIT_ASSERT_EQ(test, log2_ffs_t(u32, BIT(2)), 2);
+	KUNIT_ASSERT_EQ(test, log2_ffs_t(u32, BIT(31)), 31);
+
+	KUNIT_ASSERT_EQ(test, log2_ffs_t(u64, 1), 0);
+	KUNIT_ASSERT_EQ(test, log2_ffs_t(u64, BIT(2)), 2);
+	KUNIT_ASSERT_EQ(test, log2_ffs_t(u64, BIT_ULL(63)), 63);
+
+	for (i = 0; i != 31; i++)
+		KUNIT_ASSERT_EQ(test, log2_ffz_t(u64, BIT_ULL(i) - 1), i);
+
+	for (i = 0; i != 63; i++)
+		KUNIT_ASSERT_EQ(test, log2_ffz_t(u64, BIT_ULL(i) - 1), i);
+
+	for (i = 0; i != 32; i++) {
+		u64 val = get_random_u64();
+
+		KUNIT_ASSERT_EQ(test,
+				log2_mod_t(u32, val, log2_ffs_t(u32, val)), 0);
+		KUNIT_ASSERT_EQ(test,
+				log2_mod_t(u64, val, log2_ffs_t(u64, val)), 0);
+
+		KUNIT_ASSERT_EQ(test,
+				log2_mod_t(u32, val, log2_ffz_t(u32, val)),
+				log2_to_max_int_t(u32, log2_ffz_t(u32, val)));
+		KUNIT_ASSERT_EQ(test,
+				log2_mod_t(u64, val, log2_ffz_t(u64, val)),
+				log2_to_max_int_t(u64, log2_ffz_t(u64, val)));
+	}
+}
+
+static unsigned int ref_best_pgsize(pt_vaddr_t pgsz_bitmap, pt_vaddr_t va,
+				    pt_vaddr_t last_va, pt_oaddr_t oa)
+{
+	pt_vaddr_t pgsz_lg2;
+
+	/* Brute force the constraints described in pt_compute_best_pgsize() */
+	for (pgsz_lg2 = PT_VADDR_MAX_LG2 - 1; pgsz_lg2 != 0; pgsz_lg2--) {
+		if ((pgsz_bitmap & log2_to_int(pgsz_lg2)) &&
+		    log2_mod(va, pgsz_lg2) == 0 &&
+		    oalog2_mod(oa, pgsz_lg2) == 0 &&
+		    va + log2_to_int(pgsz_lg2) - 1 <= last_va &&
+		    log2_div_eq(va, va + log2_to_int(pgsz_lg2) - 1, pgsz_lg2) &&
+		    oalog2_div_eq(oa, oa + log2_to_int(pgsz_lg2) - 1, pgsz_lg2))
+			return pgsz_lg2;
+	}
+	return 0;
+}
+
+/* Check that the bit logic in pt_compute_best_pgsize() works. */
+static void test_best_pgsize(struct kunit *test)
+{
+	unsigned int a_lg2;
+	unsigned int b_lg2;
+	unsigned int c_lg2;
+
+	/* Try random prefixes with every suffix combination */
+	for (a_lg2 = 1; a_lg2 != 10; a_lg2++) {
+		for (b_lg2 = 1; b_lg2 != 10; b_lg2++) {
+			for (c_lg2 = 1; c_lg2 != 10; c_lg2++) {
+				pt_vaddr_t pgsz_bitmap = get_random_u64();
+				pt_vaddr_t va = get_random_u64() << a_lg2;
+				pt_oaddr_t oa = get_random_u64() << b_lg2;
+				pt_vaddr_t last_va = log2_set_mod_max(
+					get_random_u64(), c_lg2);
+
+				if (va > last_va)
+					swap(va, last_va);
+				KUNIT_ASSERT_EQ(
+					test,
+					pt_compute_best_pgsize(pgsz_bitmap, va,
+							       last_va, oa),
+					ref_best_pgsize(pgsz_bitmap, va,
+							last_va, oa));
+			}
+		}
+	}
+
+	/* 0 prefix, every suffix */
+	for (c_lg2 = 1; c_lg2 != PT_VADDR_MAX_LG2 - 1; c_lg2++) {
+		pt_vaddr_t pgsz_bitmap = get_random_u64();
+		pt_vaddr_t va = 0;
+		pt_oaddr_t oa = 0;
+		pt_vaddr_t last_va = log2_set_mod_max(0, c_lg2);
+
+		KUNIT_ASSERT_EQ(test,
+				pt_compute_best_pgsize(pgsz_bitmap, va, last_va,
+						       oa),
+				ref_best_pgsize(pgsz_bitmap, va, last_va, oa));
+	}
+
+	/* 1's prefix, every suffix */
+	for (a_lg2 = 1; a_lg2 != 10; a_lg2++) {
+		for (b_lg2 = 1; b_lg2 != 10; b_lg2++) {
+			for (c_lg2 = 1; c_lg2 != 10; c_lg2++) {
+				pt_vaddr_t pgsz_bitmap = get_random_u64();
+				pt_vaddr_t va = PT_VADDR_MAX << a_lg2;
+				pt_oaddr_t oa = PT_VADDR_MAX << b_lg2;
+				pt_vaddr_t last_va = PT_VADDR_MAX;
+
+				KUNIT_ASSERT_EQ(
+					test,
+					pt_compute_best_pgsize(pgsz_bitmap, va,
+							       last_va, oa),
+					ref_best_pgsize(pgsz_bitmap, va,
+							last_va, oa));
+			}
+		}
+	}
+
+	/* pgsize_bitmap is always 0 */
+	for (a_lg2 = 1; a_lg2 != 10; a_lg2++) {
+		for (b_lg2 = 1; b_lg2 != 10; b_lg2++) {
+			for (c_lg2 = 1; c_lg2 != 10; c_lg2++) {
+				pt_vaddr_t pgsz_bitmap = 0;
+				pt_vaddr_t va = get_random_u64() << a_lg2;
+				pt_oaddr_t oa = get_random_u64() << b_lg2;
+				pt_vaddr_t last_va = log2_set_mod_max(
+					get_random_u64(), c_lg2);
+
+				if (va > last_va)
+					swap(va, last_va);
+				KUNIT_ASSERT_EQ(
+					test,
+					pt_compute_best_pgsize(pgsz_bitmap, va,
+							       last_va, oa),
+					0);
+			}
+		}
+	}
+
+	if (sizeof(pt_vaddr_t) <= 4)
+		return;
+
+	/* over 32 bit page sizes */
+	for (a_lg2 = 32; a_lg2 != 42; a_lg2++) {
+		for (b_lg2 = 32; b_lg2 != 42; b_lg2++) {
+			for (c_lg2 = 32; c_lg2 != 42; c_lg2++) {
+				pt_vaddr_t pgsz_bitmap = get_random_u64();
+				pt_vaddr_t va = get_random_u64() << a_lg2;
+				pt_oaddr_t oa = get_random_u64() << b_lg2;
+				pt_vaddr_t last_va = log2_set_mod_max(
+					get_random_u64(), c_lg2);
+
+				if (va > last_va)
+					swap(va, last_va);
+				KUNIT_ASSERT_EQ(
+					test,
+					pt_compute_best_pgsize(pgsz_bitmap, va,
+							       last_va, oa),
+					ref_best_pgsize(pgsz_bitmap, va,
+							last_va, oa));
+			}
+		}
+	}
+}
+
+/*
+ * Check that pt_install_table() and pt_table_pa() match
+ */
+static void test_lvl_table_ptr(struct kunit *test, struct pt_state *pts,
+			       void *arg)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_oaddr_t paddr =
+		log2_set_mod(priv->test_oa, 0, priv->smallest_pgsz_lg2);
+	struct pt_write_attrs attrs = {};
+
+	if (!pt_can_have_table(pts))
+		return;
+
+	KUNIT_ASSERT_NO_ERRNO_FN(test, "pt_iommu_set_prot",
+				 pt_iommu_set_prot(pts->range->common, &attrs,
+						   IOMMU_READ));
+
+	pt_load_single_entry(pts);
+	KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_EMPTY);
+
+	KUNIT_ASSERT_TRUE(test, pt_install_table(pts, paddr, &attrs));
+
+	/*
+	 * A second install should fail because install does not update
+	 * pts->entry. So the expected entry is empty but the above installed,
+	 * this we must fail with a cmxchg collision.
+	 */
+	KUNIT_ASSERT_EQ(test, pt_install_table(pts, paddr, &attrs), false);
+
+	KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_TABLE);
+	KUNIT_ASSERT_EQ(test, pt_table_pa(pts), paddr);
+
+	pt_clear_entry(pts, ilog2(1));
+	KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_EMPTY);
+}
+
+static void test_table_ptr(struct kunit *test)
+{
+	check_all_levels(test, test_lvl_table_ptr, NULL);
+}
+
+struct lvl_radix_arg {
+	pt_vaddr_t vbits;
+};
+
+/*
+ * Check pt_table_oa_lg2sz() and pt_table_item_lg2sz() they need to decode a
+ * continuous list of VA across all the levels that covers the entire advertised
+ * VA space.
+ */
+static void test_lvl_radix(struct kunit *test, struct pt_state *pts, void *arg)
+{
+	unsigned int table_lg2sz = pt_table_oa_lg2sz(pts);
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	struct lvl_radix_arg *radix = arg;
+
+	/* Every bit below us is decoded */
+	KUNIT_ASSERT_EQ(test, log2_set_mod_max(0, isz_lg2), radix->vbits);
+
+	/* We are not decoding bits someone else is */
+	KUNIT_ASSERT_EQ(test, log2_div(radix->vbits, isz_lg2), 0);
+
+	/* Can't decode past the pt_vaddr_t size */
+	KUNIT_ASSERT_LE(test, table_lg2sz, PT_VADDR_MAX_LG2);
+	KUNIT_ASSERT_EQ(test, fvalog2_div(table_lg2sz, PT_MAX_VA_ADDRESS_LG2),
+			0);
+
+	radix->vbits = fvalog2_set_mod_max(0, table_lg2sz);
+}
+
+static void test_max_va(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+
+	KUNIT_ASSERT_GE(test, priv->common->max_vasz_lg2, range.max_vasz_lg2);
+}
+
+static void test_table_radix(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct lvl_radix_arg radix = { .vbits = priv->smallest_pgsz - 1 };
+	struct pt_range range;
+
+	check_all_levels(test, test_lvl_radix, &radix);
+
+	range = pt_top_range(priv->common);
+	if (range.max_vasz_lg2 == PT_VADDR_MAX_LG2) {
+		KUNIT_ASSERT_EQ(test, radix.vbits, PT_VADDR_MAX);
+	} else {
+		if (!IS_32BIT)
+			KUNIT_ASSERT_EQ(test,
+					log2_set_mod_max(0, range.max_vasz_lg2),
+					radix.vbits);
+		KUNIT_ASSERT_EQ(test, log2_div(radix.vbits, range.max_vasz_lg2),
+				0);
+	}
+}
+
+static unsigned int safe_pt_num_items_lg2(const struct pt_state *pts)
+{
+	struct pt_range top_range = pt_top_range(pts->range->common);
+	struct pt_state top_pts = pt_init_top(&top_range);
+
+	/*
+	 * Avoid calling pt_num_items_lg2() on the top, instead we can derive
+	 * the size of the top table from the top range.
+	 */
+	if (pts->level == top_range.top_level)
+		return ilog2(pt_range_to_end_index(&top_pts));
+	return pt_num_items_lg2(pts);
+}
+
+static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
+				    void *arg)
+{
+	unsigned int num_items_lg2 = safe_pt_num_items_lg2(pts);
+	pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+
+	if (!pt_can_have_leaf(pts)) {
+		KUNIT_ASSERT_EQ(test, pgsize_bitmap, 0);
+		return;
+	}
+
+	/* No bits for sizes that would be outside this table */
+	KUNIT_ASSERT_EQ(test, log2_mod(pgsize_bitmap, isz_lg2), 0);
+	KUNIT_ASSERT_EQ(
+		test, fvalog2_div(pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
+
+	/*
+	 * Non contiguous must be supported. AMDv1 has a HW bug where it does
+	 * not support it on one of the levels.
+	 */
+	if ((u64)pgsize_bitmap != 0xff0000000000ULL ||
+	    strcmp(__stringify(PTPFX_RAW), "amdv1") != 0)
+		KUNIT_ASSERT_TRUE(test, pgsize_bitmap & log2_to_int(isz_lg2));
+	else
+		KUNIT_ASSERT_NE(test, pgsize_bitmap, 0);
+
+	/* A contiguous entry should not span the whole table */
+	if (num_items_lg2 + isz_lg2 != PT_VADDR_MAX_LG2)
+		KUNIT_ASSERT_FALSE(
+			test,
+			pgsize_bitmap & log2_to_int(num_items_lg2 + isz_lg2));
+}
+
+static void test_entry_possible_sizes(struct kunit *test)
+{
+	check_all_levels(test, test_lvl_possible_sizes, NULL);
+}
+
+static void sweep_all_pgsizes(struct kunit *test, struct pt_state *pts,
+			      struct pt_write_attrs *attrs,
+			      pt_oaddr_t test_oaddr)
+{
+	pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	unsigned int len_lg2;
+
+	if (pts->index != 0)
+		return;
+
+	for (len_lg2 = 0; len_lg2 < PT_VADDR_MAX_LG2 - 1; len_lg2++) {
+		struct pt_state sub_pts = *pts;
+		pt_oaddr_t oaddr;
+
+		if (!(pgsize_bitmap & log2_to_int(len_lg2)))
+			continue;
+
+		oaddr = log2_set_mod(test_oaddr, 0, len_lg2);
+		pt_install_leaf_entry(pts, oaddr, len_lg2, attrs);
+		/* Verify that every contiguous item translates correctly */
+		for (sub_pts.index = 0;
+		     sub_pts.index != log2_to_int(len_lg2 - isz_lg2);
+		     sub_pts.index++) {
+			KUNIT_ASSERT_PT_LOAD(test, &sub_pts, PT_ENTRY_OA);
+			KUNIT_ASSERT_EQ(test, pt_item_oa(&sub_pts),
+					oaddr + sub_pts.index *
+							oalog2_mul(1, isz_lg2));
+			KUNIT_ASSERT_EQ(test, pt_entry_oa(&sub_pts), oaddr);
+			KUNIT_ASSERT_EQ(test, pt_entry_num_contig_lg2(&sub_pts),
+					len_lg2 - isz_lg2);
+		}
+
+		pt_clear_entry(pts, len_lg2 - isz_lg2);
+		KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_EMPTY);
+	}
+}
+
+/*
+ * Check that pt_install_leaf_entry() and pt_entry_oa() match.
+ * Check that pt_clear_entry() works.
+ */
+static void test_lvl_entry_oa(struct kunit *test, struct pt_state *pts,
+			      void *arg)
+{
+	unsigned int max_oa_lg2 = pts->range->common->max_oasz_lg2;
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_write_attrs attrs = {};
+
+	if (!pt_can_have_leaf(pts))
+		return;
+
+	KUNIT_ASSERT_NO_ERRNO_FN(test, "pt_iommu_set_prot",
+				 pt_iommu_set_prot(pts->range->common, &attrs,
+						   IOMMU_READ));
+
+	sweep_all_pgsizes(test, pts, &attrs, priv->test_oa);
+
+	/* Check that the table can store the boundary OAs */
+	sweep_all_pgsizes(test, pts, &attrs, 0);
+	if (max_oa_lg2 == PT_OADDR_MAX_LG2)
+		sweep_all_pgsizes(test, pts, &attrs, PT_OADDR_MAX);
+	else
+		sweep_all_pgsizes(test, pts, &attrs,
+				  oalog2_to_max_int(max_oa_lg2));
+}
+
+static void test_entry_oa(struct kunit *test)
+{
+	check_all_levels(test, test_lvl_entry_oa, NULL);
+}
+
+/* Test pt_attr_from_entry() */
+static void test_lvl_attr_from_entry(struct kunit *test, struct pt_state *pts,
+				     void *arg)
+{
+	pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	struct kunit_iommu_priv *priv = test->priv;
+	unsigned int len_lg2;
+	unsigned int prot;
+
+	if (!pt_can_have_leaf(pts))
+		return;
+
+	for (len_lg2 = 0; len_lg2 < PT_VADDR_MAX_LG2; len_lg2++) {
+		if (!(pgsize_bitmap & log2_to_int(len_lg2)))
+			continue;
+		for (prot = 0; prot <= (IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE |
+					IOMMU_NOEXEC | IOMMU_MMIO);
+		     prot++) {
+			pt_oaddr_t oaddr;
+			struct pt_write_attrs attrs = {};
+			u64 good_entry;
+
+			/*
+			 * If the format doesn't support this combination of
+			 * prot bits skip it
+			 */
+			if (pt_iommu_set_prot(pts->range->common, &attrs,
+					      prot)) {
+				/* But RW has to be supported */
+				KUNIT_ASSERT_NE(test, prot,
+						IOMMU_READ | IOMMU_WRITE);
+				continue;
+			}
+
+			oaddr = log2_set_mod(priv->test_oa, 0, len_lg2);
+			pt_install_leaf_entry(pts, oaddr, len_lg2, &attrs);
+			KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_OA);
+
+			good_entry = pts->entry;
+
+			memset(&attrs, 0, sizeof(attrs));
+			pt_attr_from_entry(pts, &attrs);
+
+			pt_clear_entry(pts, len_lg2 - isz_lg2);
+			KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_EMPTY);
+
+			pt_install_leaf_entry(pts, oaddr, len_lg2, &attrs);
+			KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_OA);
+
+			/*
+			 * The descriptor produced by pt_attr_from_entry()
+			 * produce an identical entry value when re-written
+			 */
+			KUNIT_ASSERT_EQ(test, good_entry, pts->entry);
+
+			pt_clear_entry(pts, len_lg2 - isz_lg2);
+		}
+	}
+}
+
+static void test_attr_from_entry(struct kunit *test)
+{
+	check_all_levels(test, test_lvl_attr_from_entry, NULL);
+}
+
+static void test_lvl_dirty(struct kunit *test, struct pt_state *pts, void *arg)
+{
+	pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	struct kunit_iommu_priv *priv = test->priv;
+	unsigned int start_idx = pts->index;
+	struct pt_write_attrs attrs = {};
+	unsigned int len_lg2;
+
+	if (!pt_can_have_leaf(pts))
+		return;
+
+	KUNIT_ASSERT_NO_ERRNO_FN(test, "pt_iommu_set_prot",
+				 pt_iommu_set_prot(pts->range->common, &attrs,
+						   IOMMU_READ | IOMMU_WRITE));
+
+	for (len_lg2 = 0; len_lg2 < PT_VADDR_MAX_LG2; len_lg2++) {
+		pt_oaddr_t oaddr;
+		unsigned int i;
+
+		if (!(pgsize_bitmap & log2_to_int(len_lg2)))
+			continue;
+
+		oaddr = log2_set_mod(priv->test_oa, 0, len_lg2);
+		pt_install_leaf_entry(pts, oaddr, len_lg2, &attrs);
+		KUNIT_ASSERT_PT_LOAD(test, pts, PT_ENTRY_OA);
+
+		pt_load_entry(pts);
+		pt_entry_set_write_clean(pts);
+		pt_load_entry(pts);
+		KUNIT_ASSERT_FALSE(test, pt_entry_write_is_dirty(pts));
+
+		for (i = 0; i != log2_to_int(len_lg2 - isz_lg2); i++) {
+			/* dirty every contiguous entry */
+			pts->index = start_idx + i;
+			pt_load_entry(pts);
+			KUNIT_ASSERT_TRUE(test, pt_entry_make_write_dirty(pts));
+			pts->index = start_idx;
+			pt_load_entry(pts);
+			KUNIT_ASSERT_TRUE(test, pt_entry_write_is_dirty(pts));
+
+			pt_entry_set_write_clean(pts);
+			pt_load_entry(pts);
+			KUNIT_ASSERT_FALSE(test, pt_entry_write_is_dirty(pts));
+		}
+
+		pt_clear_entry(pts, len_lg2 - isz_lg2);
+	}
+}
+
+static __maybe_unused void test_dirty(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (!pt_dirty_supported(priv->common))
+		kunit_skip(test,
+			   "Page table features do not support dirty tracking");
+
+	check_all_levels(test, test_lvl_dirty, NULL);
+}
+
+static struct kunit_case generic_pt_test_cases[] = {
+	KUNIT_CASE_FMT(test_init),
+	KUNIT_CASE_FMT(test_bitops),
+	KUNIT_CASE_FMT(test_best_pgsize),
+	KUNIT_CASE_FMT(test_table_ptr),
+	KUNIT_CASE_FMT(test_max_va),
+	KUNIT_CASE_FMT(test_table_radix),
+	KUNIT_CASE_FMT(test_entry_possible_sizes),
+	KUNIT_CASE_FMT(test_entry_oa),
+	KUNIT_CASE_FMT(test_attr_from_entry),
+#ifdef pt_entry_write_is_dirty
+	KUNIT_CASE_FMT(test_dirty),
+#endif
+	{},
+};
+
+static int pt_kunit_generic_pt_init(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	ret = pt_kunit_priv_init(test, priv);
+	if (ret) {
+		kunit_kfree(test, priv);
+		return ret;
+	}
+	test->priv = priv;
+	return 0;
+}
+
+static void pt_kunit_generic_pt_exit(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (!test->priv)
+		return;
+
+	pt_iommu_deinit(priv->iommu);
+	kunit_kfree(test, test->priv);
+}
+
+static struct kunit_suite NS(generic_pt_suite) = {
+	.name = __stringify(NS(fmt_test)),
+	.init = pt_kunit_generic_pt_init,
+	.exit = pt_kunit_generic_pt_exit,
+	.test_cases = generic_pt_test_cases,
+};
+kunit_test_suites(&NS(generic_pt_suite));
diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
new file mode 100644
index 00000000000000..8a53b1d772ca9d
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_KUNIT_IOMMU_H
+#define __GENERIC_PT_KUNIT_IOMMU_H
+
+#define GENERIC_PT_KUNIT 1
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <../../iommu-pages.h>
+#include "pt_iter.h"
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp);
+
+/* The format can provide a list of configurations it would like to test */
+#ifdef kunit_fmt_cfgs
+static const void *kunit_pt_gen_params_cfg(const void *prev, char *desc)
+{
+	uintptr_t cfg_id = (uintptr_t)prev;
+
+	cfg_id++;
+	if (cfg_id >= ARRAY_SIZE(kunit_fmt_cfgs) + 1)
+		return NULL;
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s_cfg_%u",
+		 __stringify(PTPFX_RAW), (unsigned int)(cfg_id - 1));
+	return (void *)cfg_id;
+}
+#define KUNIT_CASE_FMT(test_name) \
+	KUNIT_CASE_PARAM(test_name, kunit_pt_gen_params_cfg)
+#else
+#define KUNIT_CASE_FMT(test_name) KUNIT_CASE(test_name)
+#endif
+
+#define KUNIT_ASSERT_NO_ERRNO(test, ret)                                       \
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, KUNIT_SUBSUBTEST_INDENT "errno %pe", \
+			    ERR_PTR(ret))
+
+#define KUNIT_ASSERT_NO_ERRNO_FN(test, fn, ret)                          \
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0,                                \
+			    KUNIT_SUBSUBTEST_INDENT "errno %pe from %s", \
+			    ERR_PTR(ret), fn)
+
+/*
+ * When the test is run on a 32 bit system unsigned long can be 32 bits. This
+ * cause the iommu op signatures to be restricted to 32 bits. Meaning the test
+ * has to be mindful not to create any VA's over the 32 bit limit. Reduce the
+ * scope of the testing as the main purpose of checking on full 32 bit is to
+ * look for 32bitism in the core code. Run the test on i386 with X86_PAE=y to
+ * get the full coverage when dma_addr_t & phys_addr_t are 8 bytes
+ */
+#define IS_32BIT (sizeof(unsigned long) == 4)
+
+struct kunit_iommu_priv {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu_table fmt_table;
+	};
+	spinlock_t top_lock;
+	struct device *dummy_dev;
+	struct pt_iommu *iommu;
+	struct pt_common *common;
+	struct pt_iommu_table_cfg cfg;
+	struct pt_iommu_info info;
+	unsigned int smallest_pgsz_lg2;
+	pt_vaddr_t smallest_pgsz;
+	unsigned int largest_pgsz_lg2;
+	pt_oaddr_t test_oa;
+	pt_vaddr_t safe_pgsize_bitmap;
+};
+PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
+
+static void pt_kunit_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *gather)
+{
+	iommu_put_pages_list(&gather->freelist);
+}
+
+#define IOMMU_PT_DOMAIN_OPS1(x) IOMMU_PT_DOMAIN_OPS(x)
+static const struct iommu_domain_ops kunit_pt_ops = {
+	IOMMU_PT_DOMAIN_OPS1(PTPFX_RAW),
+	.iotlb_sync = &pt_kunit_iotlb_sync,
+};
+
+static void pt_kunit_change_top(struct pt_iommu *iommu_table,
+				phys_addr_t top_paddr, unsigned int top_level)
+{
+}
+
+static spinlock_t *pt_kunit_get_top_lock(struct pt_iommu *iommu_table)
+{
+	struct kunit_iommu_priv *priv = container_of(
+		iommu_table, struct kunit_iommu_priv, fmt_table.iommu);
+
+	return &priv->top_lock;
+}
+
+static const struct pt_iommu_flush_ops pt_kunit_flush_ops = {
+	.change_top = &pt_kunit_change_top,
+	.get_top_lock = &pt_kunit_get_top_lock,
+};
+
+static int pt_kunit_priv_init(struct kunit *test, struct kunit_iommu_priv *priv)
+{
+	unsigned int va_lg2sz;
+	int ret;
+
+	/* Enough so the memory allocator works */
+	priv->dummy_dev = kunit_device_register(test, "pt_kunit_dev");
+	if (IS_ERR(priv->dummy_dev))
+		return PTR_ERR(priv->dummy_dev);
+	set_dev_node(priv->dummy_dev, NUMA_NO_NODE);
+
+	spin_lock_init(&priv->top_lock);
+
+#ifdef kunit_fmt_cfgs
+	priv->cfg = kunit_fmt_cfgs[((uintptr_t)test->param_value) - 1];
+	/*
+	 * The format can set a list of features that the kunit_fmt_cfgs
+	 * controls, other features are default to on.
+	 */
+	priv->cfg.common.features |= PT_SUPPORTED_FEATURES &
+				     (~KUNIT_FMT_FEATURES);
+#else
+	priv->cfg.common.features = PT_SUPPORTED_FEATURES;
+#endif
+
+	/* Defaults, for the kunit */
+	if (!priv->cfg.common.hw_max_vasz_lg2)
+		priv->cfg.common.hw_max_vasz_lg2 = PT_MAX_VA_ADDRESS_LG2;
+	if (!priv->cfg.common.hw_max_oasz_lg2)
+		priv->cfg.common.hw_max_oasz_lg2 =
+			pt_max_output_address_lg2(NULL);
+
+	priv->fmt_table.iommu.nid = NUMA_NO_NODE;
+	priv->fmt_table.iommu.hw_flush_ops = &pt_kunit_flush_ops;
+	priv->domain.ops = &kunit_pt_ops;
+	ret = pt_iommu_init(&priv->fmt_table, &priv->cfg, GFP_KERNEL);
+	if (ret) {
+		if (ret == -EOVERFLOW)
+			kunit_skip(
+				test,
+				"This configuration cannot be tested on 32 bit");
+		return ret;
+	}
+
+	priv->iommu = &priv->fmt_table.iommu;
+	priv->common = common_from_iommu(&priv->fmt_table.iommu);
+	priv->iommu->ops->get_info(priv->iommu, &priv->info);
+
+	/*
+	 * size_t is used to pass the mapping length, it can be 32 bit, truncate
+	 * the pagesizes so we don't use large sizes.
+	 */
+	priv->info.pgsize_bitmap = (size_t)priv->info.pgsize_bitmap;
+
+	priv->smallest_pgsz_lg2 = log2_ffs(priv->info.pgsize_bitmap);
+	priv->smallest_pgsz = log2_to_int(priv->smallest_pgsz_lg2);
+	priv->largest_pgsz_lg2 =
+		log2_fls((dma_addr_t)priv->info.pgsize_bitmap) - 1;
+
+	priv->test_oa =
+		oalog2_mod(0x74a71445deadbeef, priv->common->max_oasz_lg2);
+
+	/*
+	 * We run out of VA space if the mappings get too big, make something
+	 * smaller that can safely pass through dma_addr_t API.
+	 */
+	va_lg2sz = priv->common->max_vasz_lg2;
+	if (IS_32BIT && va_lg2sz > 32)
+		va_lg2sz = 32;
+	priv->safe_pgsize_bitmap =
+		log2_mod(priv->info.pgsize_bitmap, va_lg2sz - 1);
+
+	return 0;
+}
+
+#endif
-- 
2.43.0


