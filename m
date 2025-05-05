Return-Path: <linux-kselftest+bounces-32357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6DAA9576
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F41F3B5446
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B225CC77;
	Mon,  5 May 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyLlPH5b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAC258CCB;
	Mon,  5 May 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454747; cv=fail; b=Nr9BaBIQxxMJUmdOvE6bXEz6l7i3D9eOWbUgNLE+QFfWmIQ5w4xKwqKsbB+axltQU/pg0Mr8e+b3kaq/3O/+BXCpQMnC/FmEOkmyBHb4uAFFs45brFCk5gREQxGl7K02UiGOQcm0PknJx8N4o68aQnTAputUHBmkDmveyGd8y7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454747; c=relaxed/simple;
	bh=MBNfDhZP5UCvw0yRrLZGEUM8hIBlYePpU416BLsvPl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqwuJPclhU9TeF2MnLxYCpEoW6djLHMr8U/7Lfdw4boUO1muBJb8rvDQGr3aaZcgx/DoIiJsXy9rASfQSvprcTdQ+0tBhTbVUSWSqlVWLWlYtvtAncIkG8q7WpsjCevT3tKAb7JqlGQRkB3dGV7fsJIZX4kfXCF4AY4BDSyjmx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyLlPH5b; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHd1VZNBZg+oN+sNGIFrv/DhhyQd5LIIXSq0Vb3+kmP272H/ejcoBDYuLeGnzWU94I7aREthuf7IzLMxnE8Z7eUu4fC8vOf2TZ5e8v5BSE7+T3YjMVx1Iw39e00KRAMMyu09AmyRBpbXKlMNBKqpsldsEdAvIGZxaZs0yhl7PUR0hyrn8Rl320A5XhmI9lgvEeTGl8AMANPbAkl/vsdlTKgO3MbU1iycBBpXZnPzCQqo3fB6ZbdSJT4JxS8b0ZFHcKGKoAPUwpEVCewD+abxgn2+kmRUWqvgRkQATr3zi1u6joamS6LulDDqX/LdIUHN3acVdReyhw4n2WNF7r0syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU2bkfZsjYT+X5HeKXM74+ODYmfm552FSGWXZM+47Qw=;
 b=W/IfSqHriemd9Qm1TPJs08OCTe/3fy2/PJJK8IzFMDNYArXMefnaNpA/+kNH0PIQ9+0mqfnuvGwTtRdrhSvEjV1FhRh3V0aHfLemhW1uCftWrxpjIUa9H+E+cXity2NosejNO4l25x/jqGkRStq/srAANeq78SrLMdbXgPkfVQpu3KEosWnC6JmU/oHyDNP8jTcPppyGhuL00uautWGxgDjVAK1OnAXeYKDn2bEnLfHXp2sHjwVtpf3nR/Tp7LnWMlh2ZZgxLpl4szy/rwgT4Lvpq9KMa3WKuaJTCOLAMZjKaq4312SZfQE5yrBz/VV6j63TQ4dwJAd8t3PlECk37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU2bkfZsjYT+X5HeKXM74+ODYmfm552FSGWXZM+47Qw=;
 b=dyLlPH5bKZ1MphVgNJ+ZnMR1yBFASkBdpx295hORoftVklkFz2lQLVrkaf1/rFKQ5Q3w0Az+HMneUjm470isfsqU+q9xJXaV55nNmEhLyXjw7XeuPIOFQlvxo1aG1gkFgCkN3vVBds3dLE7HcQKjg1TgSiVYzH1lwBD5X3LnhneUfUm7nof4grLJQTh26Fz9BJFujdG0HT2218e9Q8JwxzMPoSP9e2d96uPeR7oK/+rMHTd6I4Upt5fgaqkcw7alSNLv/PMm/jzY7lTlvO1/5CSAHkMQk1f0MS2p/7/kY1iKFuT0BxSCsf5lvDxh6/1r7uu5IkMSY2Ve/px3yihicg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:18:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:52 +0000
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
Subject: [PATCH v2 07/15] iommupt: Add map_pages op
Date: Mon,  5 May 2025 11:18:37 -0300
Message-ID: <7-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0477.namprd03.prod.outlook.com
 (2603:10b6:408:139::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1d9f82-514c-43e8-df1b-08dd8bdfc0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFgV9TDEBwBU5ZhMfwo5T5wtnVrEY0+LNJax7Bh1TlnEN7/wJsLfGwj5PJvb?=
 =?us-ascii?Q?YyWtI3IBz4NvKtEQuUdfcnFndkFoNtiNPr/DyKHn8/YV174Rq4OERxrxr6kv?=
 =?us-ascii?Q?ou6Xh2bGtN87Bv1+/pzRt2sCWUjaCsOMzA8ttIrRc9owA9LD6A/4VS0RzEDx?=
 =?us-ascii?Q?Og/cotLSzehYR0bcaDqgx/cDgaJAdhQhmdxqft0DrplWOTyvEbyFGn3ymXMP?=
 =?us-ascii?Q?Aml3mNpLf/6ijFMq0Gxv/OVvorQRkISa6e8O8dYjTVXuZbsGc9rlhipFXGBk?=
 =?us-ascii?Q?yhVLwmDLsK0VuGgcKYaGIvzdPf4T1WtMMVSwcLCHj/BWZ6Me9qDWXoxBfz0M?=
 =?us-ascii?Q?HBAaHUiY/Dnl0lSh5euUCMFSIodv1RSPY16xlZz7w3nvKS1lD7CI/wgvXUbO?=
 =?us-ascii?Q?DeOPmXYMy3/JuFSpHGB4MjMvMQq7Fx8BUCNbZrnv4Sv6lCospQyqr6qvhQJM?=
 =?us-ascii?Q?KzmOf8vIh1wxry92x8uR+Ln2dYJEDgMK3AK0uR3TvW2dGH0UUqAPJ0GKo+Bc?=
 =?us-ascii?Q?xl5EPEODhG6HGVTIP+u9HhO5WU+9NdJUzmn45dn8wdg32esxvR5fnhoonEhP?=
 =?us-ascii?Q?nVLq+x871ZA6CDZBLliwKbguVZjGTBFjY8d0DPtlXFLAHBBO/flmdBTi4JfU?=
 =?us-ascii?Q?4djZoaB0zIWb7NTCN8VV7mV+c8rZEoKlXLk73ddjHL7QY5PlNffA2StqR9Ah?=
 =?us-ascii?Q?kzXovAhVJ2R1guEfW1EjssjEqYsnC2/xpBUDrOwS66L8UfIknj/aIa5LCuqW?=
 =?us-ascii?Q?WNSaSFoZv7GB9biKYyP5uMd0CrZCyWAfdDCTSleS/x/xqqee+7WNd14ncVQ0?=
 =?us-ascii?Q?lcNfcphYiHGAb4YYLWQ8Owl3TGpKGJsTlVWYQMSffRkWsIy3Ocrz2UQu9GKt?=
 =?us-ascii?Q?PtIOOm+t28VrjhoUQU4j+Z1XiIJ9J+n8vr0g0GimOjtzggqXm/tqu8J1dNva?=
 =?us-ascii?Q?EFUp3F+a7A9XvIGpdLLk2phnOkhlLn/qlPH8MnmexzT4eIR+e0QAD1TlTXMz?=
 =?us-ascii?Q?veJnUV7dSqAMDH0AcmtAKyx17hgAamJAn+cJDkLTSWzUqZ2x+UT8xF0aAqDx?=
 =?us-ascii?Q?F6YbL5dWDHlwjYZns5j9eyWfGTO1fNE5BbOSkdzRKETFZD8AxwvSawe9mxUV?=
 =?us-ascii?Q?BoaPF4pu7wmDENzGXqJ34Sav0TPRH4JKSI+TRPvEMoGr7dsk8s4Gp1F2EZuX?=
 =?us-ascii?Q?uiC3QwjrAVg0+LGmN3VEdU/FxQ8Z4Nux0EplubmY4EJGC7+WgoQhrdzejln+?=
 =?us-ascii?Q?90R+9z6b1swdZLsjqGztmD8gBfHDpUOGvmvNcsmFrWcp8r5rqlrmMItD1T0o?=
 =?us-ascii?Q?Sn/fxJeVPfL23bSDnpCf89143FJIBj+7FNQ6LOaBHPN0u9F8qa9gdOVytjRt?=
 =?us-ascii?Q?mv1T39HqRtpqMKrwuSBckpKVzNrMQh9O+ejGMj4QSvD+mdlJ1HHY9sqIYqM8?=
 =?us-ascii?Q?Z0XkRDr98iEQ/6tvymQhtAmr2ES3pdFjt1CP0IbJmH0ZneE7C46PxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NK0MBALv2y2A+tfwf9HS4TaEVtEhSApDI7rQZm9qm2U4kFnSE/vsoGGkLHXm?=
 =?us-ascii?Q?yTopuLetuzIuneWmrwG2162yyaebendyS82rYLg8ZYaVYr1SwLyx2rvZN5HM?=
 =?us-ascii?Q?tR/ulKDmdpQjCOCaHF4gmjJr+cQYwyqkZVz89F83hViLCw1nG2txYFzhU/TM?=
 =?us-ascii?Q?s2yveXpgkxE4CXvD+BwwKzNsbqfHDiL/ddMlHwh5tHVdqRjHOdlXbwX78wfU?=
 =?us-ascii?Q?gSYvwAD4tkOi4zs2yipS3TNouEBfoYlbBTqiJEEaysBUecClW/DCGg5bca6Z?=
 =?us-ascii?Q?aw8u6SsPduhW5FzTHU+Wj0ejYoPgquxLPmdTpIXHJygtHqxCMliDd+AWkgbY?=
 =?us-ascii?Q?IUbdG7TiPoN19Bv3fbnQPX+/vhIrU5aN7Thg5xZ/wlmHrUfYGBs09YYHQK5w?=
 =?us-ascii?Q?yxHy/Ja2/ntTtcwvvgDEvco9gq2v3fKZmxk0ddOEGArPSgs2iFplkHUlWQdD?=
 =?us-ascii?Q?6NRbxjRGrXP14lEBBR6XiUt4J3K+8tvXlgmxijO0muatVtvHxv/zVN2E7+w1?=
 =?us-ascii?Q?5t2z2zFwbXEAyTYN1Ctgdk9jimfcb3hKxUTGpG/BJGBAV0TJJIR1vLcaBz3D?=
 =?us-ascii?Q?1sY7fOAQcEFfrSRc08OLNXfhsR2gUDfMyqEFuPJV6aDCzYUg6W6INamK6Dbm?=
 =?us-ascii?Q?Gmw9AJNF7apag9ePIdHavC252sQXR3PjFqbwsim2d2iCelnkGKBcfA2HzON9?=
 =?us-ascii?Q?1qbICGF0zZa2e54opCqV6aUL7g/rUcjO1J0P0GUvSiu28Zbaxv0RZiYn1ME1?=
 =?us-ascii?Q?DYi1diIeLcIxeDr3cISRt4F4770bEqUqOhRuSoWJqR5jR8+PUiWxz+BiTLHJ?=
 =?us-ascii?Q?ptoOqe/EnbzJVQrjHU2RJFBdU5eV2cRsdY62pNFbUdn12Kal/f97qAn6E9L8?=
 =?us-ascii?Q?iddyg2m8w+4JFh5W4gXiTUyevBwr0r9kh/QuzpTSTcoSsbsC82wnQL/eJfEV?=
 =?us-ascii?Q?iBY6SgMBMN/v/YU5nw80rRrCCSWwyJK/z0StzOF7Z6keDaIFFZ0z5LCfXUAq?=
 =?us-ascii?Q?Fvkatn8XHUoS8xQM0qKJ2DNHGFrcVuRjU0aREzrJr95cjYvkFm4RkNLt7Ir+?=
 =?us-ascii?Q?Lgs5bfee+fkQ6qmbfuX0xaz5HXGMcQnEHTmWl3j/agSykKQRSFfPwKrKFqwf?=
 =?us-ascii?Q?/VYmhsbGPZjto0Mmmf3+d+OKJF3xdxYAdAqymTZJk1+yBHxt4txcgOC3DbOg?=
 =?us-ascii?Q?mON1dAnlYEwa96nKaGTDtp+LgdUtcbTrG4Fu+Z+jBUCnJJzaprnVpRiKEm/3?=
 =?us-ascii?Q?eOTVT53GX7sncrslhDTpauE74Sevylqr2s1pSgvWcPZ2nqJ4zTOmUlcOwkNO?=
 =?us-ascii?Q?J+vEkMo6QFkHMuA5kw8goy8YGMFiBPKQjo/WvAjSHPga0kyx8s51Pcjazwf/?=
 =?us-ascii?Q?xpLuVhxXiwOjtnzM+yTIUcbMxlWNJMn+/A7nqBCbJYoo3D3xSpoKfh2tqGZm?=
 =?us-ascii?Q?UeFk3qF1oT5kbPmFh0EDnfEhHs6eklgvH7pv3FQvPh5FQCN9/G7xgl/tJK6L?=
 =?us-ascii?Q?A9za0ETP0LAEEhbSJBu/ADhqFMsImAbCTea9qPNYJEJv4pY9YPGAs1UiRcSt?=
 =?us-ascii?Q?pAbJukZLAVTHUKw7LoCnO2L2TqfMdoI9VTlqb37X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1d9f82-514c-43e8-df1b-08dd8bdfc0ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:48.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zUYFiKruimyT4SJKDCrgzClYXFVG+EoT460vl4FKlMVWDjB0cY/JDajBpYt+OCo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

map is slightly complicated because it has to handle a number of special
edge cases:
 - Overmapping a previously shared table with an OA - requries validating
   and freeing the possibly empty tables
 - Doing the above across an entire to-be-created contiguous entry
 - Installing a new shared table level concurrently with another thread
 - Expanding the table by adding more top levels

Table expansion is a unique feature of AMDv1, this version is quite
similar except we handle racing concurrent lockless map. The table top
pointer and starting level are encoded in a single uintptr_t which ensures
we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
that fixed point as its starting point. Concurrent expansion is handled
with a table global spinlock.

When inserting a new table entry map checks that the entire portion of the
table is empty. This includes freeing any empty lower tables that will be
overwritten by an OA. A separate free list is used while checking and
collecting all the empty lower tables so that writing the new entry is
uninterrupted, either the new entry fully writes or nothing changes.

A special fast path for PAGE_SIZE is implemented that does a direct walk
to the leaf level and installs a single entry. This gives ~15% improvement
for iommu_map() when mapping lists of single pages.

This version sits under the iommu_domain_ops as map_pages() but does not
require the external page size calculation. The implementation is actually
map_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize iommu_map() to take advantage of this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 481 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  58 ++++
 2 files changed, 539 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index aa15fb79abf24a..7a680017f35bff 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -90,6 +90,23 @@ static __maybe_unused int make_range_u64(struct pt_common *common,
 		ret;                                                     \
 	})
 
+static inline unsigned int compute_best_pgsize(struct pt_state *pts,
+					       pt_oaddr_t oa)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(pts->range->common);
+
+	if (!pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * The page size is limited by the domain's bitmap. This allows the core
+	 * code to reduce the supported page sizes by changing the bitmap.
+	 */
+	return pt_compute_best_pgsize(pt_possible_sizes(pts) &
+					      iommu_table->domain.pgsize_bitmap,
+				      pts->range->va, pts->range->last_va, oa);
+}
+
 static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 					     unsigned int level,
 					     struct pt_table_p *table,
@@ -189,6 +206,463 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+/* Allocate an interior table */
+static inline struct pt_table_p *table_alloc(const struct pt_state *parent_pts,
+					     gfp_t gfp)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(parent_pts->range->common);
+	struct pt_state child_pts =
+		pt_init(parent_pts->range, parent_pts->level - 1, NULL);
+
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_num_items_lg2(&child_pts) +
+			    ilog2(PT_ENTRY_WORD_SIZE)));
+}
+
+static inline int pt_iommu_new_table(struct pt_state *pts,
+				     struct pt_write_attrs *attrs)
+{
+	struct pt_table_p *table_mem;
+	phys_addr_t phys;
+
+	/* Given PA/VA/length can't be represented */
+	if (unlikely(!pt_can_have_table(pts)))
+		return -ENXIO;
+
+	table_mem = table_alloc(pts, attrs->gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+
+	phys = virt_to_phys(table_mem);
+	if (!pt_install_table(pts, phys, attrs)) {
+		iommu_free_pages(table_mem);
+		return -EAGAIN;
+	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+		/*
+		 * The underlying table can't store the physical table address.
+		 * This happens when kunit testing tables outside their normal
+		 * environment where a CPU might be limited.
+		 */
+		pt_load_single_entry(pts);
+		if (PT_WARN_ON(pt_table_pa(pts) != phys)) {
+			pt_clear_entry(pts, ilog2(1));
+			iommu_free_pages(table_mem);
+			return -EINVAL;
+		}
+	}
+
+	pts->table_lower = table_mem;
+	return 0;
+}
+
+struct pt_iommu_map_args {
+	struct iommu_iotlb_gather *iotlb_gather;
+	struct pt_write_attrs attrs;
+	pt_oaddr_t oa;
+	unsigned int leaf_pgsize_lg2;
+	unsigned int leaf_level;
+};
+
+/*
+ * Check that the items in a contiguous block are all empty. This will
+ * recursively check any tables in the block to validate they are empty and
+ * accumulate them on the free list. Makes no change on failure. On success
+ * caller must fill the items.
+ */
+static int clear_contig(const struct pt_state *start_pts,
+			struct iommu_iotlb_gather *iotlb_gather,
+			unsigned int step, unsigned int pgsize_lg2)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(start_pts->range->common);
+	struct pt_range range = *start_pts->range;
+	struct pt_state pts =
+		pt_init(&range, start_pts->level, start_pts->table);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+	pt_vaddr_t start_va = range.va;
+	int ret;
+
+	pts.index = start_pts->index;
+	pts.end_index = start_pts->index + step;
+	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			ret = pt_walk_descend_all(&pts, __collect_tables,
+						  &collect);
+			if (ret)
+				return ret;
+
+			iommu_pages_list_add(&collect.free_list,
+					     pt_table_ptr(&pts));
+		} else if (pts.type != PT_ENTRY_EMPTY) {
+			return -EADDRINUSE;
+		}
+	}
+
+	if (!iommu_pages_list_empty(&collect.free_list)) {
+		gather_range(iotlb_gather, iommu_table, start_va,
+			     range.va - start_va);
+		iommu_pages_list_splice(&collect.free_list,
+					&iotlb_gather->freelist);
+	}
+	return 0;
+}
+
+static int __map_range_leaf(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
+	unsigned int start_index;
+	pt_oaddr_t oa = map->oa;
+	unsigned int step;
+	bool need_contig;
+
+	PT_WARN_ON(map->leaf_level != level);
+	PT_WARN_ON(!pt_can_have_leaf(&pts));
+
+	step = log2_to_int_t(unsigned int,
+			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
+	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
+			int ret;
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			ret = clear_contig(&pts, map->iotlb_gather, step,
+					   leaf_pgsize_lg2);
+			if (ret) {
+				map->oa = oa;
+				return ret;
+			}
+		}
+
+		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);
+
+		pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->attrs);
+
+		oa += log2_to_int(leaf_pgsize_lg2);
+		pts.index += step;
+	} while (pts.index < pts.end_index);
+
+	map->oa = oa;
+	return 0;
+}
+
+static int __map_range(struct pt_range *range, void *arg, unsigned int level,
+		       struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	int ret;
+
+	PT_WARN_ON(map->leaf_level == level);
+	PT_WARN_ON(!pt_can_have_table(&pts));
+
+	_pt_iter_first(&pts);
+
+	/* Descend to a child table */
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+
+		if (pts.type != PT_ENTRY_TABLE) {
+			if (pts.type != PT_ENTRY_EMPTY)
+				return -EADDRINUSE;
+			ret = pt_iommu_new_table(&pts, &map->attrs);
+			if (ret) {
+				/*
+				 * Racing with another thread installing a table
+				 */
+				if (ret == -EAGAIN)
+					continue;
+				return ret;
+			}
+		} else {
+			pts.table_lower = pt_table_ptr(&pts);
+		}
+
+		/*
+		 * The already present table can possibly be shared with another
+		 * concurrent map.
+		 */
+		if (map->leaf_level == level - 1)
+			ret = pt_descend(&pts, arg, __map_range_leaf);
+		else
+			ret = pt_descend(&pts, arg, __map_range);
+		if (ret)
+			return ret;
+
+		pts.index++;
+		pt_index_to_va(&pts);
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+	return 0;
+}
+
+static __always_inline int __do_map_single_page(struct pt_range *range,
+						void *arg, unsigned int level,
+						struct pt_table_p *table,
+						pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+
+	pts.type = pt_load_single_entry(&pts);
+	if (level == 0) {
+		if (pts.type != PT_ENTRY_EMPTY)
+			return -EADDRINUSE;
+		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
+				      &map->attrs);
+		map->oa += PAGE_SIZE;
+		return 0;
+	}
+	if (pts.type != PT_ENTRY_TABLE)
+		return -EAGAIN;
+	return pt_descend(&pts, arg, descend_fn);
+}
+PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
+
+/*
+ * Add a table to the top, increasing the top level as much as necessary to
+ * encompass range.
+ */
+static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
+			struct pt_iommu_map_args *map)
+{
+	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
+	uintptr_t new_top_of_table = top_of_table;
+	struct pt_table_p *table_mem;
+	unsigned int new_level;
+	spinlock_t *domain_lock;
+	unsigned long flags;
+	int ret;
+
+	while (true) {
+		struct pt_range top_range =
+			_pt_top_range(common, new_top_of_table);
+		struct pt_state pts = pt_init_top(&top_range);
+
+		top_range.va = range->va;
+		top_range.last_va = range->last_va;
+
+		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
+			break;
+
+		pts.level++;
+		if (pts.level > PT_MAX_TOP_LEVEL ||
+		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
+			ret = -ERANGE;
+			goto err_free;
+		}
+
+		new_level = pts.level;
+		table_mem = table_alloc_top(
+			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
+		if (IS_ERR(table_mem))
+			return PTR_ERR(table_mem);
+		iommu_pages_list_add(&free_list, table_mem);
+
+		/* The new table links to the lower table always at index 0 */
+		top_range.va = 0;
+		top_range.top_level = new_level;
+		pts.table_lower = pts.table;
+		pts.table = table_mem;
+		pt_load_single_entry(&pts);
+		PT_WARN_ON(pts.index != 0);
+		pt_install_table(&pts, virt_to_phys(pts.table_lower),
+				 &map->attrs);
+		new_top_of_table = _pt_top_set(pts.table, pts.level);
+	}
+
+	/*
+	 * top_of_table is write locked by the spinlock, but readers can use
+	 * READ_ONCE() to get the value. Since we encode both the level and the
+	 * pointer in one quanta the lockless reader will always see something
+	 * valid. The HW must be updated to the new level under the spinlock
+	 * before top_of_table is updated so that concurrent readers don't map
+	 * into the new level until it is fully functional. If another thread
+	 * already updated it while we were working then throw everything away
+	 * and try again.
+	 */
+	domain_lock = iommu_table->hw_flush_ops->get_top_lock(iommu_table);
+	spin_lock_irqsave(domain_lock, flags);
+	if (common->top_of_table != top_of_table) {
+		spin_unlock_irqrestore(domain_lock, flags);
+		ret = -EAGAIN;
+		goto err_free;
+	}
+
+	/*
+	 * We do not issue any flushes for change_top on the expectation that
+	 * any walk cache will not become a problem by adding another layer to
+	 * the tree. Misses will rewalk from the updated top pointer, hits
+	 * continue to be correct. Negative caching is fine too since all the
+	 * new IOVA added by the new top is non-present.
+	 */
+	iommu_table->hw_flush_ops->change_top(
+		iommu_table, virt_to_phys(table_mem), new_level);
+	WRITE_ONCE(common->top_of_table, new_top_of_table);
+	spin_unlock_irqrestore(domain_lock, flags);
+	return 0;
+
+err_free:
+	iommu_put_pages_list(&free_list);
+	return ret;
+}
+
+static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
+			   struct pt_iommu_map_args *map)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	int ret;
+
+	do {
+		ret = pt_check_range(range);
+		if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+			return ret;
+
+		if (!ret && map->leaf_level <= range->top_level)
+			break;
+
+		ret = increase_top(iommu_table, range, map);
+		if (ret && ret != -EAGAIN)
+			return ret;
+
+		/* Reload the new top */
+		*range = pt_make_range(common, range->va, range->last_va);
+	} while (ret);
+	PT_WARN_ON(pt_check_range(range));
+	return 0;
+}
+
+/**
+ * map_range() - Install translation for an IOVA range
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @paddr: Physical/Output address to start
+ * @len: Length of the range starting from @iova
+ * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
+ * @gfp: GFP flags for any memory allocations
+ * @gather: Gather struct that must be flushed on return
+ *
+ * The range starting at IOVA will have paddr installed into it. The rage is
+ * automatically segmented into optimally sized table entries, and can have any
+ * valid alignment.
+ *
+ * On error the caller will probably want to invoke unmap on the range from iova
+ * up to the amount indicated by @mapped to return the table back to an
+ * unchanged state.
+ *
+ * Context: The caller must hold a write range lock that includes the whole
+ * range.
+ *
+ * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
+ * mapped are added to @mapped, @mapped is not zerod first.
+ */
+int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	pt_vaddr_t pgsize_bitmap = iommu_table->domain.pgsize_bitmap;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct iommu_iotlb_gather iotlb_gather;
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_iommu_map_args map = {
+		.iotlb_gather = &iotlb_gather,
+		.oa = paddr,
+		.leaf_pgsize_lg2 = log2_ffs(pgsize),
+	};
+	bool single_page = false;
+	struct pt_range range;
+	int ret;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+
+	if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
+		return -EINVAL;
+
+	/* Check the paddr doesn't exceed what the table can store */
+	if ((sizeof(pt_oaddr_t) > sizeof(paddr) && paddr > PT_VADDR_MAX) ||
+	    (common->max_oasz_lg2 != PT_VADDR_MAX_LG2 &&
+	     oalog2_div(paddr, common->max_oasz_lg2)))
+		return -ERANGE;
+
+	ret = pt_iommu_set_prot(common, &map.attrs, prot);
+	if (ret)
+		return ret;
+	map.attrs.gfp = gfp;
+
+	ret = make_range_no_check(common, &range, iova, len);
+	if (ret)
+		return ret;
+
+	/* Calculate target page size and level for the leaves */
+	if (pt_has_system_page(common) && pgsize == PAGE_SIZE && pgcount == 1) {
+		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
+		if (log2_mod(iova | paddr, PAGE_SHIFT))
+			return -ENXIO;
+		map.leaf_pgsize_lg2 = PAGE_SHIFT;
+		map.leaf_level = 0;
+		single_page = true;
+	} else {
+		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
+			pgsize_bitmap, range.va, range.last_va, paddr);
+		if (!map.leaf_pgsize_lg2)
+			return -ENXIO;
+		map.leaf_level =
+			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
+	}
+
+	ret = check_map_range(iommu_table, &range, &map);
+	if (ret)
+		return ret;
+
+	PT_WARN_ON(map.leaf_level > range.top_level);
+
+	do {
+		if (single_page) {
+			ret = pt_walk_range(&range, __map_single_page, &map);
+			if (ret != -EAGAIN)
+				break;
+		}
+
+		if (map.leaf_level == range.top_level)
+			ret = pt_walk_range(&range, __map_range_leaf, &map);
+		else
+			ret = pt_walk_range(&range, __map_range, &map);
+	} while (false);
+
+	/*
+	 * Table levels were freed and replaced with large items, flush any walk
+	 * cache that may refer to the freed levels.
+	 */
+	if (!iommu_pages_list_empty(&iotlb_gather.freelist))
+		iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
+
+	/* Bytes successfully mapped */
+	PT_WARN_ON(!ret && map.oa - paddr != len);
+	*mapped += map.oa - paddr;
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -448,6 +922,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
 	memset_after(fmt_table, 0, iommu.domain);
 
 	/* The caller can initialize some of these values */
+	iommu_table->hw_flush_ops = cfg.hw_flush_ops;
 	iommu_table->nid = cfg.nid;
 }
 
@@ -483,6 +958,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
 	if (ret)
 		return ret;
 
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
+	    WARN_ON(!iommu_table->hw_flush_ops ||
+		    !iommu_table->hw_flush_ops->change_top ||
+		    !iommu_table->hw_flush_ops->get_top_lock))
+		return -EINVAL;
+
 	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
 	    (pt_feature(common, PT_FEAT_FULL_VA) ||
 	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 862d224c59281e..fd0c598526ce57 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -11,6 +11,7 @@
 
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
+struct pt_iommu_flush_ops;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -43,6 +44,12 @@ struct pt_iommu {
 	 */
 	const struct pt_iommu_ops *ops;
 
+	/**
+	 * @hw_flush_ops - Function pointers provided by the HW driver to flush
+	 * HW caches after changes to the page table.
+	 */
+	const struct pt_iommu_flush_ops *hw_flush_ops;
+
 	/**
 	 * @nid - Node ID to use for table memory allocations. The iommu driver
 	 * may want to set the NID to the device's NID, if there are multiple
@@ -84,6 +91,52 @@ struct pt_iommu_ops {
 	void (*deinit)(struct pt_iommu *iommu_table);
 };
 
+/**
+ * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
+ *
+ * The IOMMU driver should implement these using container_of(iommu_table) to
+ * get to it's iommu_domain dervied structure. All ops can be called in atomic
+ * contexts as they are buried under DMA API calls.
+ */
+struct pt_iommu_flush_ops {
+	/**
+	 * change_top() - Update the top of table pointer
+	 * @iommu_table: Table to operate on
+	 * @top_paddr: New CPU physical address of the top pointer
+	 * @top_level: IOMMU PT level of the new top
+	 *
+	 * Called under the get_top_lock() spinlock. The driver must update all
+	 * HW references to this domain with a new top address and
+	 * configuration. On return mappings placed in the new top must be
+	 * reachable by the HW.
+	 *
+	 * top_level encodes the level in IOMMU PT format, level 0 is the
+	 * smallest page size increasing from there. This has to be translated
+	 * to any HW specific format. During this call the new top will not be
+	 * visible to any other API.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
+			   unsigned int top_level);
+
+	/**
+	 * get_top_lock() - Return a lock to hold when changing the table top
+	 * @iommu_table: Table to operate on
+	 *
+	 * page table from being stored in HW. The lock will be held prior
+	 * to calling change_top() and released once the top is fully visible.
+	 *
+	 * Typically this would be a lock that protects the iommu_domain's
+	 * attachment list.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
+};
+
 static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
 {
 	iommu_table->ops->deinit(iommu_table);
@@ -114,6 +167,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,            \
+				       unsigned long iova, phys_addr_t paddr,  \
+				       size_t pgsize, size_t pgcount,          \
+				       int prot, gfp_t gfp, size_t *mapped);   \
 	size_t pt_iommu_##fmt##_unmap_pages(                                   \
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
@@ -136,6 +193,7 @@ struct pt_iommu_cfg {
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
-- 
2.43.0


