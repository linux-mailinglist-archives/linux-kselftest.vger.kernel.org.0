Return-Path: <linux-kselftest+bounces-32352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E45AA9562
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2E17A7E13
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC625C82C;
	Mon,  5 May 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjtFFnyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43B25C6F7;
	Mon,  5 May 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454740; cv=fail; b=JuSt/470+GGWmZ5gcx6lUtBxBSUTFglU3BilbSqqDVd84/82bNb07WI6Uzf5yJocmKQPTMZZPpJPuV7nAXD6QYFbYCmmhpoKmgKik8Nxufa9XsdobDU/aoNLiRNyWk0saOACPx+iQswbXUWIvG6jOQLgnpO8I+0c90WFW6Nh+h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454740; c=relaxed/simple;
	bh=rsh028qZG3NYkNjLYQEOKB1kwA2c+fcN5ECJ41+NGCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRT3snknUKRc9/2LlOtbchIqrYqusohnx+c9OIFnL3/G6Aj26R7CjV6pHeY3uBsOV0iTokIph1QDSIpPQBtX4GTTECI3ZMrNjNZT2F/0s88wexfxM+S5ffKhn+uA6lAmv8NcM9EdkOPiQ5DdMWfOQQ/Cnk3/sgb7qDvJuR6OVRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjtFFnyF; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0DEwfYLRNs7YuK8dfgr6JN3XQTRy45YR7Xg2+vsDtWU5c88i1TZT+iAVhiF6YvX3Fb9SIg8nad4MQHdIgtV6c7yexrrOqvzq13fdpUQhCKtQBjWkegtCtKiZfrqIG6Ikhkl1dm9n6BAQxu/34w0+cknVmGHWVGG7be0BgORuPq3FFZ6pS70tpYLTJQS4f0P8NvmfLl6xVbn3VHXWDnGJQzAYZ7hI2eUMiB8k6rgk+zhnsgSWwLLOhjZ7kLJEpJAiJgoKPpTd0/V+al2T5yddO3VqhBIIKbwLbQKd2h0roqg0UpWkuf++n+p0YUYQ4FLyy/lx5BvivDvqFun2V6rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf5Smn/w2vtkX0tP831qki51PUJXoMq2EQJU34k0iEM=;
 b=jcPqj962V/XDO/SUiA3GeWuN7cRaMUykuoy7iO2vl4uBhFMVQDcRdA131I8cuOiOerBd0pO7HENrNJfHDx2kIVkyj98Y+l5Dlp6coYq/qzhIamQSTlXeruOueQ4KOJ8CJfQBFW+ggl4jbA1anGhVk+JgfOEGPo/T11l1KRitURHcf2NLpzFwHrfHmLBCnTXqjHtmOidhE4v2C5t3cHigRlz0pQKRZw0d+7ykVPpWI7gt4vUWg92hpKbj0JWEeH6gTG8vchKJ87A2gH9Jgd/gDp0Q1jgwsIrAa0jGoNHlmMC73VokTMOn0axK5VfLBwPUxoK2zul2IeSHLDrH6LVFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf5Smn/w2vtkX0tP831qki51PUJXoMq2EQJU34k0iEM=;
 b=jjtFFnyFWsGrjeGVQz46KG1wMlUJcmaZUO7KFYvCJtEGUpjj0wm8jyW0Ko7dfL9PHFW0RcMvqvHs5xiaee+kIN/xtWSUcYB3UTW7D7F6XjWAMf3JD92foMyPv+QckTv38gdS3nwPp+c1PMbOpsEkgzKPfmDRdxCVRAIg5t6KQBo6+/jYcGm+CJlUuJa+rmIPDiy6u9fLMECrAdxg7Q5bMhV30h6GTpiT7Vg3nurYNOjOSrFaUOH3XxFGEkWXi3cWTPRQeQGMYoYpe9HcVpFFtx2sx3WuIDpl73RWpJ+nbEow/6mt8QZBU/dcUa111oftntOJgUkr27lSwNmgtQG3Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:18:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:53 +0000
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
Subject: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Mon,  5 May 2025 11:18:33 -0300
Message-ID: <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:408:ea::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc0292d-5b00-45e0-6d3f-08dd8bdfc15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kAgCLQyUbXLCv00rUT36YBe7YFgZg7HkETkSEve9IF+vgo5AGuvRotFFZWZN?=
 =?us-ascii?Q?Cv74IXWKmQrA/EyAReJChaDL29vso6Sq+y22c+7b9XQLs9oiV/+oQlrUlnnI?=
 =?us-ascii?Q?ULGTMRHSS8nqvI6WtncxT238H/J2t5BAciTcU4vu745EL/CkN01fdPPgiGOo?=
 =?us-ascii?Q?TgFsYElGWHnDNEAyuyVDm73aQut45F2dxpWUhd9VrZOzI4Tsq/sRqd6Mi/GH?=
 =?us-ascii?Q?S4PBIchtLbDNpjsvpJMLX7PFmMzdgWOcVnKZu56GSXnWmKOQggcdhUb+AtfM?=
 =?us-ascii?Q?suPT6KcVkgWxHl1VfVsjfyW1Iq75hoY7am0ljUgtaZ+9UHWdTQ1ght9Pmpug?=
 =?us-ascii?Q?VFOymINljyldHji1PG1/lgmjQsHOwv6p2+40AJGhWsAHsUBELgxzjaBAGtSf?=
 =?us-ascii?Q?/WU6z1Q6MYm7PMy/FH3knbzMvDl1EWDIvsQjRcw789uijNX/bFKFNKpoWJcX?=
 =?us-ascii?Q?lADtFTGKUF+vQPbZo0EqhbqfmkqK5Ss8Vrfg3JbNFT/CIuIkxIt07ms0N7j7?=
 =?us-ascii?Q?+5Ot6veXe+3DvSoQO79jsPMdF27buymTCTi/gb+kBmj446JGuAr5mQ96+UZ6?=
 =?us-ascii?Q?23eV37zgDeCxs3JAPop2LZBRvsPe44eXIXpRftgO2K0Hm82CN7K1eqNP3JKs?=
 =?us-ascii?Q?QjKkb0do8HkiUzuO7n732fvQ9r7i10C/utTTzj9M2EkElaIBhqhLlpTr3P3n?=
 =?us-ascii?Q?T1YKSsEbWdu54Qcl9rUeZuP+xOgNAf/QGf2sGwvutlRc0d9yC5gbseo0Eb19?=
 =?us-ascii?Q?zjjy6Zs0ySM50FEXOZHgYR/ScCbhs75ViZj/cJqra1DLw8iLlBwzFt9PBfq4?=
 =?us-ascii?Q?tQswLki8XzA4MKHzTAQWYlwuDpRugojteRCZQ40yzKgemrz/lzB5P2wbrHAp?=
 =?us-ascii?Q?RO6TMivx2pDfC8jUX08OEiQAp1ezpe+bkl1YAAUu1yNnvsUCjkyYIfkPZ6Dl?=
 =?us-ascii?Q?3l2z2j4XvKeHom0uPdiTWa2R1MHHLYPDY0j5EMR5sp6zaVITM4++e3I8ipum?=
 =?us-ascii?Q?JrNYI2PbmNxf0/9ZIiF9PlMSStZQhEi7bMjZWzaFXvV9R7PJGwqwSEXy+fAw?=
 =?us-ascii?Q?BHUNnAHGOVI8Shhln8pEB9kIkLTX0gxcvyRmbuJmHKva0lGJr7AYZMkBSNtl?=
 =?us-ascii?Q?yowYZuHugknCJp+J1I1+yE5Ot3peRJ712EYXrXTxSZKNplGzlaztCwRokh6c?=
 =?us-ascii?Q?+goSnppYu9VBUqk5/iB6Z5IHoeVnqXEsxX8yKWwX7OL9Me3AK3EuD0XlnyiL?=
 =?us-ascii?Q?5zH1fl4BThnNKPt+tMXl07rcrzeEHDdOjbVNYkU5yHpv8bJaYEkYu91ZwyMa?=
 =?us-ascii?Q?tBC45/9bOVp6gsX3c/9UphuOHHJzB5cmyBQ54//8YpwZ93DTO5cAlfQeZydH?=
 =?us-ascii?Q?uF/wPFRGBWsgEU1qWAY2UOJtSqCP68nh4weQ30blRNfdNZ+BH8/ci7kEBGAu?=
 =?us-ascii?Q?zayE9zSbmq8wjWV04Gq754xwSfozhtl8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KaqsGLZqg02Ir0n4e/ftIB4XhHG5Zku92Rn/0j95xpjeJyk2L8iR1oN97XEn?=
 =?us-ascii?Q?eJUQqy9DQlzCXvok2cFxfHByQ9hRl7dAi7aGlD7DLrAhvNsmZO7RMIGW9pn6?=
 =?us-ascii?Q?p4nwlru5QRJTza5b3FdKExaDHHfxZQM801Nuxq0iTNN+Hr+e0OVKhpubsnah?=
 =?us-ascii?Q?mYfE2Hf5r1JlXt7/G/s9QM0CQddDg+IKbmwEmLJUUa1+ORJ436TKtaSDeam1?=
 =?us-ascii?Q?5Lced4gUBC+6s0bycTaV+EsSs5rJZVH+Q3fwhSbjv297RP1MX+i9f0e6HG1i?=
 =?us-ascii?Q?hpFMWE5R7Ka3ddplsmP2NQEGO1uP7Lr17WDaRlWR5FwrGCeGYlDEm/cbs6td?=
 =?us-ascii?Q?wPIVvxEabkIXMxVQxCAmjjVcf2kzui+afEeP6TM8JxMHicThNVk/KzDDTEAh?=
 =?us-ascii?Q?9As2mh87vtUntgmabyzRqwyxyuysMinRWythqLzg26NCm/hibaAma8EhrjVc?=
 =?us-ascii?Q?aPYX5AfhaP5HuUvi4kwvk9ornYAsO+RpwCXFXOfch3NQhROHXhyYrbP4OD9X?=
 =?us-ascii?Q?/n2AVfk0tjCJKa2eQ14+pqQk2kwTxSI+xk+Bm8r//FdnZppEUM2JgkVS18ze?=
 =?us-ascii?Q?SSH+ImjyjhcxPSUD0p7vK31fOM98BObKxiZiselCjhfCCOxxowHLyNv2W3Xx?=
 =?us-ascii?Q?hkY2KCvLSnHECafAOqHMpoZ7cE4dzRzIN4nFcPqNFJq9qhhy02zdkllM6ORA?=
 =?us-ascii?Q?qwii01qelfj10w/mHvtOiwVWT5/52vhZ0yEooKG73O5y0A/LT2Ey7C6XpvGX?=
 =?us-ascii?Q?mp/4juTJK+OzPbQwJzL2wWLAq5huOLMNDJnp4jr/m9gGUCp5zfI4yApgG/u4?=
 =?us-ascii?Q?daHouadzqvHLJ0nOGy3GfW62VipC90odtdmNwVVaVsw4U3Xm8+6yEy/j7U2x?=
 =?us-ascii?Q?TDXpg8mxQsd3btxoqxZZeyOhJzBh5G+q/wlvuldX9pb+XgJlh37Rsh9fZ0w1?=
 =?us-ascii?Q?NpKNG6/cEbatXeB3XZIKu7jKnU+rBFHEDXx58yQrdaOXlHDFtaF2rcHhMpcQ?=
 =?us-ascii?Q?p8SNrlcpj2kdhilqZ5+tlO16o5DCiMkgyHCBCBohIcSQ629VuWIW1ofkcOxP?=
 =?us-ascii?Q?LR6j59Iy0AAXvbuEvjaqjwitiqf7dXSs0L+GlFKb3pnnHsFEk/QFd4XF8Uo6?=
 =?us-ascii?Q?4vAHhsGL0y8CYM9Nk1dtJaFB7mg0DcrugsZvwCwm8hcSTWYCaQmu8RxanWUb?=
 =?us-ascii?Q?z3xFe2jzCJI4IBft2grWwmB8VPxsEnn8o29whcqTDA3uQ2vXe3wz4irNfvxq?=
 =?us-ascii?Q?vbIgImuq1hilSf9cHIJi+w/RZRaNB470aPNFY3LgbP1mvLr9KXOJjmF7qHsd?=
 =?us-ascii?Q?NAhKSBQlogj8RL71oYMHha6tHOAKz3kODNr/avF9nymYZYJIuE6VXPfPAN75?=
 =?us-ascii?Q?nAGysNTPlf+CC3gGJYAP/zSSLykIClrF2SY3OdqHuc/noeIXeTDc3zD5aiSH?=
 =?us-ascii?Q?ORhh6CTpy3KyahUq/ugty8XAC4awyJBYcswrlF9lLMMB09Qe7QN1vv9VwdCn?=
 =?us-ascii?Q?u5lQ4FDtqrzZJOHjE0dBfIHy+Sk4f7UlFDmHVpGFE8DU5AD++ps6PEYwE3Mh?=
 =?us-ascii?Q?Sdwi498YVsVRTScsxXfBB0vfx1ozLrYAMIQYT/wm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc0292d-5b00-45e0-6d3f-08dd8bdfc15d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:49.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utJM9+KGoWdIDcIS0tvqv5ODWRmxBCUTvAr2w8egP/XgS5UboRqZqKCB4L2fD/RS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

The existing IOMMU page table implementations duplicate all of the working
algorithms for each format. By using the generic page table API a single C
version of the IOMMU algorithms can be created and re-used for all of the
different formats used in the drivers. The implementation will provide a
single C version of the iommu domain operations: iova_to_phys, map, unmap,
and read_and_clear_dirty.

Further, adding new algorithms and techniques becomes easy to do across
the entire fleet of drivers and formats.

The C functions are drop in compatible with the existing iommu_domain_ops
using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
compilation unit will produce exported symbols following the pattern
pt_iommu_FMT_map_pages() which the macro directly maps to the
iommu_domain_ops members. This avoids the additional function pointer
indirection like io-pgtable has.

The top level struct used by the drivers is pt_iommu_table_FMT. It
contains the other structs to allow container_of() to move between the
driver, iommu page table, generic page table, and generic format layers.

   struct pt_iommu_table_amdv1 {
       struct pt_iommu {
	      struct iommu_domain domain;
       } iommu;
       struct pt_amdv1 {
	      struct pt_common {
	      } common;
       } amdpt;
   };

The driver is expected to union the pt_iommu_table_FMT with it's own
existing domain struct:

   struct driver_domain {
       union {
	       struct iommu_domain domain;
	       struct pt_iommu_table_amdv1 amdv1;
       };
   };
   PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);

To create an alias to avoid renaming 'domain' in a lot of driver code.

This allows all the layers to access all the necessary functions to
implement their different roles with no change to any of the existing
iommu core code.

Implement the basic starting point: pt_iommu_init(), get_info() and
deinit().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  13 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 265 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 112 ++++++++
 4 files changed, 429 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 775a3afb563f72..73b7a54375f9bd 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -19,4 +19,17 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
+	default n
+	help
+	  Generic library for building IOMMU page tables
+
+	  IOMMU_PT provides an implementation of the page table operations
+	  related struct iommu_domain using GENERIC_PT to abstract the page
+	  table format.
 endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
new file mode 100644
index 00000000000000..5b631bc07cbc16
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Template to build the iommu module and kunit from the format and
+ * implementation headers.
+ *
+ * The format should have:
+ *  #define PT_FMT <name>
+ *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
+ * And optionally:
+ *  #define PT_FORCE_ENABLED_FEATURES ..
+ *  #define PT_FMT_VARIANT <suffix>
+ */
+#include <linux/args.h>
+#include <linux/stringify.h>
+
+#ifdef PT_FMT_VARIANT
+#define PTPFX_RAW \
+	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
+#else
+#define PTPFX_RAW PT_FMT
+#endif
+
+#define PTPFX CONCATENATE(PTPFX_RAW, _)
+
+#define _PT_FMT_H PT_FMT.h
+#define PT_FMT_H __stringify(_PT_FMT_H)
+
+#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
+#define PT_DEFS_H __stringify(_PT_DEFS_H)
+
+#include <linux/generic_pt/common.h>
+#include PT_DEFS_H
+#include "../pt_defs.h"
+#include PT_FMT_H
+#include "../pt_common.h"
+
+#include "../iommu_pt.h"
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
new file mode 100644
index 00000000000000..4c228689b0a3d0
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * "Templated C code" for implementing the iommu operations for page tables.
+ * This is compiled multiple times, over all the page table formats to pick up
+ * the per-format definitions.
+ */
+#ifndef __GENERIC_PT_IOMMU_PT_H
+#define __GENERIC_PT_IOMMU_PT_H
+
+#include "pt_iter.h"
+
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+#include <linux/export.h>
+
+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
+
+struct pt_iommu_collect_args {
+	struct iommu_pages_list free_list;
+	u8 ignore_mapped : 1;
+};
+
+static int __collect_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_collect_args *collect = arg;
+	int ret;
+
+	if (collect->ignore_mapped && !pt_can_have_table(&pts))
+		return 0;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_pages_list_add(&collect->free_list, pts.table_lower);
+			ret = pt_descend(&pts, arg, __collect_tables);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && !collect->ignore_mapped)
+			return -EADDRINUSE;
+	}
+	return 0;
+}
+
+static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
+						 uintptr_t top_of_table,
+						 gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(common);
+
+	/*
+	 * Top doesn't need the free list or otherwise, so it technically
+	 * doesn't need to use iommu pages. Use the API anyhow as the top is
+	 * usually not smaller than PAGE_SIZE to keep things simple.
+	 */
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
+}
+
+static void NS(get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_top_range(common);
+	struct pt_state pts = pt_init_top(&range);
+	pt_vaddr_t pgsize_bitmap = 0;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
+		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
+		     pts.level++) {
+			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
+				break;
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+		}
+	} else {
+		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+	}
+
+	/* Hide page sizes larger than the maximum OA */
+	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+		.ignore_mapped = true,
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	/*
+	 * The driver has to already have fenced the HW access to the page table
+	 * and invalidated any caching referring to this memory.
+	 */
+	iommu_put_pages_list(&collect.free_list);
+}
+
+static const struct pt_iommu_ops NS(ops) = {
+	.get_info = NS(get_info),
+	.deinit = NS(deinit),
+};
+
+static int pt_init_common(struct pt_common *common)
+{
+	struct pt_range top_range = pt_top_range(common);
+
+	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
+		return -EINVAL;
+
+	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
+	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
+		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
+
+	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
+		common->features |= BIT(PT_FEAT_FULL_VA);
+
+	/* Requested features must match features compiled into this format */
+	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
+	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
+	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
+		     PT_FORCE_ENABLED_FEATURES))
+		return -EOPNOTSUPP;
+
+	if (common->max_oasz_lg2 == 0)
+		common->max_oasz_lg2 = pt_max_output_address_lg2(common);
+	else
+		common->max_oasz_lg2 = min(common->max_oasz_lg2,
+					   pt_max_output_address_lg2(common));
+	return 0;
+}
+
+static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
+				struct iommu_domain *domain)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_iommu_info info;
+	struct pt_range range;
+
+	NS(get_info)(iommu_table, &info);
+
+	domain->type = __IOMMU_DOMAIN_PAGING;
+	domain->pgsize_bitmap = info.pgsize_bitmap;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		range = _pt_top_range(common,
+				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
+	else
+		range = pt_top_range(common);
+
+	/*
+	 * A 64 bit high address space table on a 32 bit system cannot work.
+	 */
+	domain->geometry.aperture_start = (unsigned long)range.va;
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va ||
+	    range.va > ULONG_MAX)
+		return -EOVERFLOW;
+
+	/*
+	 * The aperture is limited to what the API can do after considering all
+	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
+	 * to store a VA. Set the aperture to something that is valid for all
+	 * cases. Saturate instead of truncate the end if the types are smaller
+	 * than the top range. aperture_end is a last.
+	 */
+	domain->geometry.aperture_end = (unsigned long)range.last_va;
+	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
+		domain->geometry.aperture_end = ULONG_MAX;
+		domain->pgsize_bitmap &= ULONG_MAX;
+	}
+
+	return 0;
+}
+
+static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_iommu cfg = *iommu_table;
+
+	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
+	memset_after(fmt_table, 0, iommu.domain);
+
+	/* The caller can initialize some of these values */
+	iommu_table->nid = cfg.nid;
+}
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_table_p *table_mem;
+	int ret;
+
+	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
+	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
+		return -EINVAL;
+
+	pt_iommu_zero(fmt_table);
+	common->features = cfg->common.features;
+	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
+#ifdef PT_FIXED_TOP_LEVEL
+	pt_top_set_level(common, PT_FIXED_TOP_LEVEL);
+#endif
+	ret = pt_iommu_fmt_init(fmt_table, cfg);
+	if (ret)
+		return ret;
+
+	if (cfg->common.hw_max_oasz_lg2 > pt_max_output_address_lg2(common))
+		return -EINVAL;
+
+	ret = pt_init_common(common);
+	if (ret)
+		return ret;
+
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
+	    (pt_feature(common, PT_FEAT_FULL_VA) ||
+	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
+		return -EINVAL;
+
+	iommu_table->ops = &NS(ops);
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
+
+#ifdef pt_iommu_fmt_hw_info
+#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
+#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
+void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
+		      struct pt_iommu_table_hw_info *info)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range top_range = pt_top_range(common);
+
+	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));
+MODULE_IMPORT_NS("GENERIC_PT");
+
+#endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
new file mode 100644
index 00000000000000..636f856cc5fdcc
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_IOMMU_H
+#define __GENERIC_PT_IOMMU_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+struct pt_iommu_ops;
+
+/**
+ * DOC: IOMMU Radix Page Table
+ *
+ * The iommu implementation of the Generic Page Table provides an ops struct
+ * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
+ * the generic map/unmap interface.
+ *
+ * This interface uses a caller provided locking approach. The caller must have
+ * a VA range lock concept that prevents concurrent threads from calling ops on
+ * the same VA. Generally the range lock must be at least as large as a single
+ * map call.
+ */
+
+/**
+ * struct pt_iommu - Base structure for iommu page tables
+ *
+ * The format specific struct will include this as the first member.
+ */
+struct pt_iommu {
+	/**
+	 * @domain - The core iommu domain. The driver should use a union to
+	 * overlay this memory with its previously existing domain struct to
+	 * create an alias.
+	 */
+	struct iommu_domain domain;
+
+	/**
+	 * @ops - Function pointers to access the API
+	 */
+	const struct pt_iommu_ops *ops;
+
+	/**
+	 * @nid - Node ID to use for table memory allocations. The iommu driver
+	 * may want to set the NID to the device's NID, if there are multiple
+	 * table walkers.
+	 */
+	int nid;
+};
+
+/**
+ * struct pt_iommu_info - Details about the iommu page table
+ *
+ * Returned from pt_iommu_ops->get_info()
+ */
+struct pt_iommu_info {
+	/**
+	 * @pgsize_bitmap - A bitmask where each set bit indicates
+	 * a page size that can be natively stored in the page table.
+	 */
+	u64 pgsize_bitmap;
+};
+
+struct pt_iommu_ops {
+	/**
+	 * get_info() - Return the pt_iommu_info structure
+	 * @iommu_table: Table to query
+	 *
+	 * Return some basic static information about the page table.
+	 */
+	void (*get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info);
+
+	/**
+	 * deinit() - Undo a format specific init operation
+	 * @iommu_table: Table to destroy
+	 *
+	 * Release all of the memory. The caller must have already removed the
+	 * table from all HW access and all caches.
+	 */
+	void (*deinit)(struct pt_iommu *iommu_table);
+};
+
+static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
+{
+	iommu_table->ops->deinit(iommu_table);
+}
+
+/**
+ * struct pt_iommu_cfg - Common configuration values for all formats
+ */
+struct pt_iommu_cfg {
+	/**
+	 * @features - Features required. Only these features will be turned on.
+	 * The feature list should reflect what the IOMMU HW is capable of.
+	 */
+	unsigned int features;
+	/**
+	 * @hw_max_vasz_lg2 - Maximum VA the IOMMU HW can support. This will
+	 * imply the top level of the table.
+	 */
+	u8 hw_max_vasz_lg2;
+	/**
+	 * @hw_max_oasz_lg2 - Maximum OA the IOMMU HW can support. The format
+	 * might select a lower maximum OA.
+	 */
+	u8 hw_max_oasz_lg2;
+};
+
+#endif
-- 
2.43.0


