Return-Path: <linux-kselftest+bounces-43931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E986C02E0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073DF1AA6AE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0326980F;
	Thu, 23 Oct 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gB8Zbish"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7EF26E16C;
	Thu, 23 Oct 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243663; cv=fail; b=D9WFv4Z8NvPSdBVtxiVR/zjD7fTORuDldUokf32Fnl27fB28i0trwpvRMxM4WyFRRMyk6erfzFTE3MV95dAhnxxCYWPsmKoVajg4fmRW8OBTwpxPC2RcsLD1nkXvXjCBcAmfcLT/e26rLnzm2bhuNURdIO8wbrFSbJR2zLH5NUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243663; c=relaxed/simple;
	bh=ALrV7F5f9oDKQbNaTYobaopx76onoTp/gklXtbgtwmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEV3SLmfhUDg84jR5PqD06T9HW+4sm9T+WiLpj8p4pwYCg99RGpVoWHxTGyrbBcMtHGb9qQSyXxCrw8bwLRv1j8xzTwLXGrU72WjS2c2h+sxBOi7uY6nayRMpvG4vDeGBrU1e7o8HR8+2iDLpNcpu5tPQI9UfJJFw9eQhNxYwhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gB8Zbish; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMlbfL/Bg04FXnnSPJ5esz7frg9awgzYrw6oLUrg0ZezvDbsm0ub5RS6A1ogkQtT1sBw9NGmMqTj27YZCKlDPvax82AloUCF7Y5Q7CF1WcipyoYv1xMyU+cC4FMzKg56MYfxLTvg8JvRTidJbADuym7ArErWqUEAhpY5Tx1UNa6D/tN+SEKLhbpx402rfwKJXnKB0VzqnfMKjxM+NUbYQDDsS0Whyt/IPcT2zFIvl3bPQq60ZNxixoMgJW3EUJErrQvtW8rq/bWwxUSR4PgwUGHyugJPiwlwh4hbiQs+ln+3pAhIoVewjYvXSLC32fJ0LZnJ3U1SzqudExfl2s3UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M23QQ9lP6kvEHrTi0zwlHXb3i3+MvJlQnSDbPOzXQs=;
 b=HZv3QL/ikh0fsqriRdtaKfCxW6ipS/X2xUUtX65Ap9EvOJFMlc27+8rmDEywlDQCGeccdOpopjx6jxuWDuAa5HGfZ50Fx0MKzUNRDCgdq30f/RZwoP7PkuldSf4N6plqlNl3gxlC0q7uaNzTxO5IJHPd82rs3hA352j2qUzzlzNbUUksZ6GpvXppXwKITuW0rS9ujv15fIMqQGnEtyDb92cItVnJRdPaX5aacMevBPLqUdVlw8Ludwg0W+2v19ubioilSigXmUrOe7cPl2hJvE/Ql39aOg1WBLoSSl3K8wacw5x+8u/YpDEfHj7oT75VPk/c3eLM++V8vWhTX123yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M23QQ9lP6kvEHrTi0zwlHXb3i3+MvJlQnSDbPOzXQs=;
 b=gB8ZbishR2zh13Zz26GBko5NOFYcoW8mOXVQHlkSHuWP5F4z33uDJ7WUPCZ2gEbeYpDt6i/831EWx0mt6mv30TPIge775FGL48pRTjX4NVAo+hzk61S8kZ03fXf85h/h/bZiLh9bUibcwmqwYzRp2XmgxoP5NMaL/+PSPDAJq5gQvcSQ2SkkYqmhXkqLcY5IfGK+mzcGHOdfGGaeMEvS52QPPn6tIN/laKvaopZSUUhy1r6E7vhXnIzdRsdSjlTVOKFzMTxJQ+DamEwzqAP9X104lZhDu9cVb6n7buD1IecJ0afRwvO5u2HIjR4iYjMub+xcInJ05i2Z0K/wrotzvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:20:55 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:20:55 +0000
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
Subject: [PATCH v7 04/15] iommupt: Add the AMD IOMMU v1 page table format
Date: Thu, 23 Oct 2025 15:20:34 -0300
Message-ID: <4-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ab2973-7c07-44db-0f12-08de1260e5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNXBGNdvCXnzlWyb1+eSCQ3PTYWG/c0g24kyPHk9xoj+Fv9xt4ChK40j+DBP?=
 =?us-ascii?Q?aOcHasNWuMvHfXxsh+YpJ0xFGebmhHz76jN8VzHpAgepY1jRGvf1cDREVhFu?=
 =?us-ascii?Q?MsvVj2dgQrylZQWBR75cDLRnLQfdbcPhs8SlKJSHluFZLJZLdFwfsMb9UaA8?=
 =?us-ascii?Q?sUo50M+XNoQ7jgZrTanLRRXgLe+PfQCVlQgA2+2iPgLwI2UBjdFfTazplHQV?=
 =?us-ascii?Q?99Q55zayQmB5g/3segiVNLb58H4Bg7n51xE1xUhiKCGMUlk0v1t6lv8OLNHL?=
 =?us-ascii?Q?mVVyl1QpSn7fVHU/svQV7GorPir0AmF+w44PJKmDzpsyi1BZwvILQlPzc1nd?=
 =?us-ascii?Q?kyc88FTMtV7997fO/6NrVe3atfvk9lZaE/U/v3BbBav4Lo5/G1pAGQrziyTq?=
 =?us-ascii?Q?XoT25VVh5Ut8+AZsbbu5oamzwwQIYf2bhnXu93uETT2GYLel1WVnsshQ7/tP?=
 =?us-ascii?Q?2rk+X2nkLwLzw0/l4HJL4hbaFc4BxdSBtG6xdQ9BMFLDlvKhj/xMJUSApclY?=
 =?us-ascii?Q?SaWucO3KG4lxD4QoOJZJn+t30zcIKob2LxKLyqoMsCUJv5ZDcC3qie/MMqP+?=
 =?us-ascii?Q?RUXfB4m4QeYz7Za2oImdYBixMyijJKx9tChHV04Q7SfBMAnP8eNs+kPhdOhn?=
 =?us-ascii?Q?3yhJXsKSN1UtkCZlvrLqg5cfKE1dZ0yl0ma7O8I4hW3tG4cblinzTWUqHvyC?=
 =?us-ascii?Q?qRpNnEOmq2CMUXRzOvlXIZEOJ8WbNjspdTduRSkekmdglpOxaRpinMch8HTI?=
 =?us-ascii?Q?jUCR5P0KeaoHWn9Gd5FT7wVtcnfNBQVZlRm6Z9m338qfFx8x+/AZWhJPSWCK?=
 =?us-ascii?Q?QH0LqwKZz4mvztV0LDL0DDP5/JLvoyvKUTqJrWn/FbzM3VUx54h4LHSAXnAU?=
 =?us-ascii?Q?0B8KEqbc8rEje7HSWHmlSaQimoR2A/14fK8JbKE0zKdbbS2886dBRIyzksVp?=
 =?us-ascii?Q?PU7eIjoTq6kBohQsn+4c9i2ksFxyVst/ud+cmZkkRLGVi+M1t0nq6HhDZ7OK?=
 =?us-ascii?Q?pk2gQMRVqBA5BTtF9vGmABIcY6tw7K/52DUlH36JHLL6+i6a8RdVZYa+ZAqz?=
 =?us-ascii?Q?1KpxK5Xm76/I7ucme3hdQWOu1Sgda5xqbWsdDQB1+z7JR/qLGRRvyC1XLwIl?=
 =?us-ascii?Q?8G/YGSoqPsBieZLR7yL1d3Ib0zmPMBZ4BEZI2ofYxMB+WUYlJrmbd1dFgcAe?=
 =?us-ascii?Q?68JbUPBr5XnUPkD8+jREUsFEGsd8oD0PWYVQv0Hzsr4lN4MimxJhxD9BAyV9?=
 =?us-ascii?Q?af5hESpodr0+03hohxVlTUAytofwboMc9jj1AspQ09Kaqm6ULck5Uog8qNiL?=
 =?us-ascii?Q?pv4gC4hAsPtm/Xzhq2dbZLhrjbR9URqRRh9WaygtBTuMIc73wOMVeOOPiFbv?=
 =?us-ascii?Q?LUhs1pyDMhMa8k1i9DJhbgXO5ejGPgRWv5amqiFYYa317lkc2COEhdIFWtL9?=
 =?us-ascii?Q?nVjs+z684GjyZdBRQovNNLeqWMRgGD21ltaDcUfMw5VwhKrxywp6K/IV9iLM?=
 =?us-ascii?Q?qmAjnS49Lfp9FKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yq6zYzxtg/lC/g9GzlsAyvTwHmgMJSjL6mzboSpCaUZ49Xv3PG5d3sWP5153?=
 =?us-ascii?Q?8X/9y9pK5bY+yki9cXJvqYey3XbOCSAllCrbL14ERtsLwd/i3yNDmWcKjNis?=
 =?us-ascii?Q?9B9XSlzQPRcyazKJUjoFAS929ckFHuguxSSxnZVwRfpWuI1uVQLzHajO9LoC?=
 =?us-ascii?Q?skeJpxmTlQNKBvII3nmhN1TQ3Vzr5D0SmQdKj/sG9R3zheX6GAV7Mb+IKBPH?=
 =?us-ascii?Q?NuniXfKcAHBuQTP5NCIppopi/gTJv0/gWcWBUxTgpiSlQeQu5A5oyY7WCmw0?=
 =?us-ascii?Q?vVmIOFu6VMDTVMl0OZtbPrewZK+fGrsYR1dg+nfYbkxLCqFdNx3z09TkmCRZ?=
 =?us-ascii?Q?oKruIXDeEXWonL3mvwxbdcFYgb/NxVm6XtG4+fLjMnL2Qd5B21bT5SOTzZhC?=
 =?us-ascii?Q?g+r+hXikkaosa0MeyHkWbxD4ORKfHaS3vKB6Iw8IHgdRvJzzHPgzLGHNN4Ej?=
 =?us-ascii?Q?U8LJzC6CTAMUL0HGnp5xinCVuC3SNwsHQTd1y2bX8jvs0QCkVmgA0NXSK++G?=
 =?us-ascii?Q?al5VxWtuwdQ4CVDUIxWRVgUf7W3tC5UHDSD+IVkROeNlSlVXW4s8v0E2CCis?=
 =?us-ascii?Q?3Q/ULfsKTAlg1zOdHwhLCQ3HPD94nVPavE4N9hxvrbGwjPgreY68rj+pM6YG?=
 =?us-ascii?Q?QPziUFXN4p137GAqbCAHPb8Ax9KGi3DsNx5zGRJuW/V4RgMEofwJUYOUB+W+?=
 =?us-ascii?Q?za0GiYRJHVoj4G0dJh2IDNnnwSMv2VpHre4aDK0coKf510bnvs4O/0eY5WQL?=
 =?us-ascii?Q?nxceN5Y+jInE9cv1VFD/lClUV8aZhzR21xfvB1VD8JN6RQPZPoigFW/x46XW?=
 =?us-ascii?Q?P3oLGd33qK1AuMReylIrI7BjLjeekikGVc5cJXpIC+8htRP12DjhcQTmEBqx?=
 =?us-ascii?Q?WjdbINKK0mzfpCcYGVmbb8Mf4O+Mnf0CHd95DlJnkAX7slcc1ZmLATCJIVjU?=
 =?us-ascii?Q?7MSoIl0pjZqV32kbX/8BxBlAELQQ7ckwU9vRM0fUwKhQkD1NPfeJ85VDaP+x?=
 =?us-ascii?Q?9iNUMhI+0pkkgEW6b9QGTCgGzk2JTbs5+eZ2t/ooE40BE2EQgQG33zwY8CV0?=
 =?us-ascii?Q?HhLwznYgNHhLvIYby8sM1w3SeH+Ek7hzyO+ItyyFrfrmPCvr4mMG+43/CayF?=
 =?us-ascii?Q?5gGaax0jbKI+HZNdobsaR7t8Jm3IgjJVxCzq6PxrStadjBVUuAXUBzseCWKf?=
 =?us-ascii?Q?uMC00lYUj57dygVjvMvIWPcUrarAmvt9buKx24seLEaTlJZe40hAKiFgC7hZ?=
 =?us-ascii?Q?o189MVmR87JjTpR+USlbpKw1rakFSROsKfrxSMHG5XQdZQ+h/acYibHv9lxC?=
 =?us-ascii?Q?e/QtR5EiHuvPmvbq4oXvDwR8YGXFB58bHkvWMCTSJ1skYse89ayrGih+rqcE?=
 =?us-ascii?Q?vOLu0utDvcQGDYlSDZ+IRVc0HAUrUCnCQA09zQRtDH5N247LVc4u6IxdotaK?=
 =?us-ascii?Q?vjYvmoQrWqTYhdlpmCL59zOIsh8zww1dJXHgMQnw4IoHFUWkwCUZR5xziT8f?=
 =?us-ascii?Q?rbmVRpbDj++bleRxPwfZsO5vjpEQBBawVJuGlTUNuAawU8xc7uQulxR5a0aC?=
 =?us-ascii?Q?L4bQY+rAXNbzXGZc4zWVJOO1cDlVGuD3M66MHCU+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ab2973-7c07-44db-0f12-08de1260e5b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:52.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l68tGOkb0yD5eS9RmJF5M5CFvY5THd2UN3DYWtxKTDFQO6I5davBuVRsLyCZ258
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
and it can decode the full 64 bit VA space. Unlike other x86 page tables
this explicitly does not do sign extension as part of allowing the entire
64 bit VA space to be supported.

The general design is quite similar to the x86 PAE format, except with a
6th level and quite different PTE encoding.

This format is the only one that uses the PT_FEAT_DYNAMIC_TOP feature in
the existing code as the existing AMDv1 code starts out with a 3 level
table and adds levels on the fly if more IOVA is needed.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     65,64    ,      62,61      ,  -1.01
     2^13,     70,66    ,      67,62      ,  -8.08
     2^14,     73,69    ,      71,65      ,  -9.09
     2^15,     78,75    ,      75,71      ,  -5.05
     2^16,     89,89    ,      86,84      ,  -2.02
     2^17,    128,121   ,     124,112     , -10.10
     2^18,    175,175   ,     170,163     ,  -4.04
     2^19,    264,306   ,     261,279     ,   6.06
     2^20,    444,525   ,     438,489     ,  10.10
     2^21,     60,62    ,      58,59      ,   1.01
 256*2^12,    381,1833  ,     367,1795    ,  79.79
 256*2^21,    375,1623  ,     356,1555    ,  77.77
 256*2^30,    356,1338  ,     349,1277    ,  72.72

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     76,89    ,      71,86      ,  17.17
     2^13,     79,89    ,      75,86      ,  12.12
     2^14,     78,90    ,      74,86      ,  13.13
     2^15,     82,89    ,      74,86      ,  13.13
     2^16,     79,89    ,      74,86      ,  13.13
     2^17,     81,89    ,      77,87      ,  11.11
     2^18,     90,92    ,      87,89      ,   2.02
     2^19,     91,93    ,      88,90      ,   2.02
     2^20,     96,95    ,      91,92      ,   1.01
     2^21,     72,88    ,      68,85      ,  20.20
 256*2^12,    372,6583  ,     364,6251    ,  94.94
 256*2^21,    398,6032  ,     392,5758    ,  93.93
 256*2^30,    396,5665  ,     389,5258    ,  92.92

The ~5-17x speedup when working with mutli-PTE map/unmaps is because the
AMD implementation rewalks the entire table on every new PTE while this
version retains its position. The same speedup will be seen with dirtys as
well.

The old implementation triggers a compiler optimization that ends up
generating a "rep stos" memset for contiguous PTEs. Since AMD can have
contiguous PTEs that span 2Kbytes of table this is a huge win compared to
a normal movq loop. It is why the unmap side has a fairly flat runtime as
the contiguous PTE sides increases. This version makes it explicit with a
memset64() call.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/Makefile                     |   1 +
 drivers/iommu/generic_pt/Kconfig           |  12 +
 drivers/iommu/generic_pt/fmt/Makefile      |  11 +
 drivers/iommu/generic_pt/fmt/amdv1.h       | 391 +++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  15 +
 include/linux/generic_pt/common.h          |  19 +
 include/linux/generic_pt/iommu.h           |  12 +
 8 files changed, 482 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033f3..b17ef9818759be 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,6 +3,7 @@ obj-y += arm/ iommufd/
 obj-$(CONFIG_AMD_IOMMU) += amd/
 obj-$(CONFIG_INTEL_IOMMU) += intel/
 obj-$(CONFIG_RISCV_IOMMU) += riscv/
+obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index a81dfdd72ca016..cbdad222923b26 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -30,4 +30,16 @@ config IOMMU_PT
 	  related to struct iommu_domain using GENERIC_PT. It provides a single
 	  implementation of the page table operations that can be shared by
 	  multiple drivers.
+
+if IOMMU_PT
+config IOMMU_PT_AMDV1
+	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	help
+	  iommu_domain implementation for the AMD v1 page table. AMDv1 is the
+	  "host" page table. It supports granular page sizes of almost every
+	  power of 2 and decodes an full 64-bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+endif
 endif
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
new file mode 100644
index 00000000000000..a4d83b7e0cf691
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+
+define create_format
+obj-$(2) += iommu_$(1).o
+
+endef
+
+$(eval $(foreach fmt,$(iommu_pt_fmt-y),$(call create_format,$(fmt),y)))
+$(eval $(foreach fmt,$(iommu_pt_fmt-m),$(call create_format,$(fmt),m)))
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
new file mode 100644
index 00000000000000..1f46e4ab4aea51
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -0,0 +1,391 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * AMD IOMMU v1 page table
+ *
+ * This is described in Section "2.2.3 I/O Page Tables for Host Translations"
+ * of the "AMD I/O Virtualization Technology (IOMMU) Specification"
+ *
+ * Note the level numbering here matches the core code, so level 0 is the same
+ * as mode 1.
+ *
+ */
+#ifndef __GENERIC_PT_FMT_AMDV1_H
+#define __GENERIC_PT_FMT_AMDV1_H
+
+#include "defs_amdv1.h"
+#include "../pt_defs.h"
+
+#include <asm/page.h>
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/mem_encrypt.h>
+#include <linux/minmax.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_ITEM_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 5,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+
+	/* The DTE only has these bits for the top phyiscal address */
+	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
+};
+
+/* PTE bits */
+enum {
+	AMDV1PT_FMT_PR = BIT(0),
+	AMDV1PT_FMT_D = BIT(6),
+	AMDV1PT_FMT_NEXT_LEVEL = GENMASK_ULL(11, 9),
+	AMDV1PT_FMT_OA = GENMASK_ULL(51, 12),
+	AMDV1PT_FMT_FC = BIT_ULL(60),
+	AMDV1PT_FMT_IR = BIT_ULL(61),
+	AMDV1PT_FMT_IW = BIT_ULL(62),
+};
+
+/*
+ * gcc 13 has a bug where it thinks the output of FIELD_GET() is an enum, make
+ * these defines to avoid it.
+ */
+#define AMDV1PT_FMT_NL_DEFAULT 0
+#define AMDV1PT_FMT_NL_SIZE 7
+
+#define common_to_amdv1pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_amdv1, common)
+#define to_amdv1pt(pts) common_to_amdv1pt((pts)->range->common)
+
+static inline pt_oaddr_t amdv1pt_table_pa(const struct pt_state *pts)
+{
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, entry), PT_GRANULE_LG2SZ);
+}
+#define pt_table_pa amdv1pt_table_pa
+
+/* Returns the oa for the start of the contiguous entry */
+static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+{
+	u64 entry = pts->entry;
+	pt_oaddr_t oa;
+
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	oa = FIELD_GET(AMDV1PT_FMT_OA, entry);
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, entry) == AMDV1PT_FMT_NL_SIZE) {
+		unsigned int sz_bits = oaffz(oa);
+
+		oa = oalog2_set_mod(oa, 0, sz_bits);
+	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, entry) !=
+			      AMDV1PT_FMT_NL_DEFAULT))
+		return 0;
+	return oalog2_mul(oa, PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa amdv1pt_entry_oa
+
+static inline bool amdv1pt_can_have_leaf(const struct pt_state *pts)
+{
+	/*
+	 * Table 15: Page Table Level Parameters
+	 * The top most level cannot have translation entries
+	 */
+	return pts->level < PT_MAX_TOP_LEVEL;
+}
+#define pt_can_have_leaf amdv1pt_can_have_leaf
+
+/* Body in pt_fmt_defaults.h */
+static inline unsigned int pt_table_item_lg2sz(const struct pt_state *pts);
+
+static inline unsigned int
+amdv1pt_entry_num_contig_lg2(const struct pt_state *pts)
+{
+	u32 code;
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
+	    AMDV1PT_FMT_NL_DEFAULT)
+		return ilog2(1);
+
+	PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
+		   AMDV1PT_FMT_NL_SIZE);
+
+	/*
+	 * The contiguous size is encoded in the length of a string of 1's in
+	 * the low bits of the OA. Reverse the equation:
+	 *  code = log2_to_int(num_contig_lg2 + item_lg2sz -
+	 *              PT_GRANULE_LG2SZ - 1) - 1
+	 * Which can be expressed as:
+	 *  num_contig_lg2 = oalog2_ffz(code) + 1 -
+	 *              item_lg2sz - PT_GRANULE_LG2SZ
+	 *
+	 * Assume the bit layout is correct and remove the masking. Reorganize
+	 * the equation to move all the arithmetic before the ffz.
+	 */
+	code = pts->entry >> (__bf_shf(AMDV1PT_FMT_OA) - 1 +
+			      pt_table_item_lg2sz(pts) - PT_GRANULE_LG2SZ);
+	return ffz_t(u32, code);
+}
+#define pt_entry_num_contig_lg2 amdv1pt_entry_num_contig_lg2
+
+static inline unsigned int amdv1pt_num_items_lg2(const struct pt_state *pts)
+{
+	/*
+	 * Top entry covers bits [63:57] only, this is handled through
+	 * max_vasz_lg2.
+	 */
+	if (PT_WARN_ON(pts->level == 5))
+		return 7;
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 amdv1pt_num_items_lg2
+
+static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+
+	if (!amdv1pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * Table 14: Example Page Size Encodings
+	 * Address bits 51:32 can be used to encode page sizes greater than 4
+	 * Gbytes. Address bits 63:52 are zero-extended.
+	 *
+	 * 512GB Pages are not supported due to a hardware bug.
+	 * Otherwise every power of two size is supported.
+	 */
+	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
+			   isz_lg2) & ~SZ_512G;
+}
+#define pt_possible_sizes amdv1pt_possible_sizes
+
+static inline enum pt_entry_type amdv1pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	unsigned int next_level;
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(*tablep);
+	if (!(entry & AMDV1PT_FMT_PR))
+		return PT_ENTRY_EMPTY;
+
+	next_level = FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry);
+	if (pts->level == 0 || next_level == AMDV1PT_FMT_NL_DEFAULT ||
+	    next_level == AMDV1PT_FMT_NL_SIZE)
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw amdv1pt_load_entry_raw
+
+static inline void
+amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			   unsigned int oasz_lg2,
+			   const struct pt_write_attrs *attrs)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 entry;
+
+	if (!pt_check_install_leaf_args(pts, oa, oasz_lg2))
+		return;
+
+	entry = AMDV1PT_FMT_PR |
+		FIELD_PREP(AMDV1PT_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+
+	if (oasz_lg2 == isz_lg2) {
+		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
+				    AMDV1PT_FMT_NL_DEFAULT);
+		WRITE_ONCE(*tablep, entry);
+	} else {
+		unsigned int num_contig_lg2 = oasz_lg2 - isz_lg2;
+		u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
+				    AMDV1PT_FMT_NL_SIZE) |
+			 FIELD_PREP(AMDV1PT_FMT_OA,
+				    oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ -
+						  1) -
+					    1);
+
+		/* See amdv1pt_clear_entries() */
+		if (num_contig_lg2 <= ilog2(32)) {
+			for (; tablep != end; tablep++)
+				WRITE_ONCE(*tablep, entry);
+		} else {
+			memset64(tablep, entry, log2_to_int(num_contig_lg2));
+		}
+	}
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry amdv1pt_install_leaf_entry
+
+static inline bool amdv1pt_install_table(struct pt_state *pts,
+					 pt_oaddr_t table_pa,
+					 const struct pt_write_attrs *attrs)
+{
+	u64 entry;
+
+	/*
+	 * IR and IW are ANDed from the table levels along with the PTE. We
+	 * always control permissions from the PTE, so always set IR and IW for
+	 * tables.
+	 */
+	entry = AMDV1PT_FMT_PR |
+		FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL, pts->level) |
+		FIELD_PREP(AMDV1PT_FMT_OA,
+			   log2_div(table_pa, PT_GRANULE_LG2SZ)) |
+		AMDV1PT_FMT_IR | AMDV1PT_FMT_IW;
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(pts, entry);
+}
+#define pt_install_table amdv1pt_install_table
+
+static inline void amdv1pt_attr_from_entry(const struct pt_state *pts,
+					   struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits =
+		pts->entry & (AMDV1PT_FMT_FC | AMDV1PT_FMT_IR | AMDV1PT_FMT_IW);
+}
+#define pt_attr_from_entry amdv1pt_attr_from_entry
+
+static inline void amdv1pt_clear_entries(struct pt_state *pts,
+					 unsigned int num_contig_lg2)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	/*
+	 * gcc generates rep stos for the io-pgtable code, and this difference
+	 * can show in microbenchmarks with larger contiguous page sizes.
+	 * rep is slower for small cases.
+	 */
+	if (num_contig_lg2 <= ilog2(32)) {
+		for (; tablep != end; tablep++)
+			WRITE_ONCE(*tablep, 0);
+	} else {
+		memset64(tablep, 0, log2_to_int(num_contig_lg2));
+	}
+}
+#define pt_clear_entries amdv1pt_clear_entries
+
+static inline bool amdv1pt_entry_is_write_dirty(const struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		if (READ_ONCE(*tablep) & AMDV1PT_FMT_D)
+			return true;
+	return false;
+}
+#define pt_entry_is_write_dirty amdv1pt_entry_is_write_dirty
+
+static inline void amdv1pt_entry_make_write_clean(struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, READ_ONCE(*tablep) & ~(u64)AMDV1PT_FMT_D);
+}
+#define pt_entry_make_write_clean amdv1pt_entry_make_write_clean
+
+static inline bool amdv1pt_entry_make_write_dirty(struct pt_state *pts)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 new = pts->entry | AMDV1PT_FMT_D;
+
+	return try_cmpxchg64(tablep, &pts->entry, new);
+}
+#define pt_entry_make_write_dirty amdv1pt_entry_make_write_dirty
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_amdv1
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_amdv1, iommu)
+			->amdpt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_amdv1, amdpt.common)->iommu;
+}
+
+static inline int amdv1pt_iommu_set_prot(struct pt_common *common,
+					 struct pt_write_attrs *attrs,
+					 unsigned int iommu_prot)
+{
+	u64 pte = 0;
+
+	if (pt_feature(common, PT_FEAT_AMDV1_FORCE_COHERENCE))
+		pte |= AMDV1PT_FMT_FC;
+	if (iommu_prot & IOMMU_READ)
+		pte |= AMDV1PT_FMT_IR;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= AMDV1PT_FMT_IW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot amdv1pt_iommu_set_prot
+
+static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
+					 const struct pt_iommu_amdv1_cfg *cfg)
+{
+	struct pt_amdv1 *table = &iommu_table->amdpt;
+	unsigned int max_vasz_lg2 = PT_MAX_VA_ADDRESS_LG2;
+
+	if (cfg->starting_level == 0 || cfg->starting_level > PT_MAX_TOP_LEVEL)
+		return -EINVAL;
+
+	if (!pt_feature(&table->common, PT_FEAT_DYNAMIC_TOP) &&
+	    cfg->starting_level != PT_MAX_TOP_LEVEL)
+		max_vasz_lg2 = PT_GRANULE_LG2SZ +
+			       (PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64))) *
+				       (cfg->starting_level + 1);
+
+	table->common.max_vasz_lg2 =
+		min(max_vasz_lg2, cfg->common.hw_max_vasz_lg2);
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	pt_top_set_level(&table->common, cfg->starting_level);
+	return 0;
+}
+#define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
+
+static inline void
+amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
+			  const struct pt_range *top_range,
+			  struct pt_iommu_amdv1_hw_info *info)
+{
+	info->host_pt_root = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(info->host_pt_root & ~PT_TOP_PHYS_MASK);
+	info->mode = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/defs_amdv1.h b/drivers/iommu/generic_pt/fmt/defs_amdv1.h
new file mode 100644
index 00000000000000..0b9614ca6d103c
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_amdv1.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_AMDV1_H
+#define __GENERIC_PT_FMT_DEFS_AMDV1_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct amdv1pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs amdv1pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
new file mode 100644
index 00000000000000..72a2337d0c5510
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT amdv1
+#define PT_SUPPORTED_FEATURES                                          \
+	(BIT(PT_FEAT_FULL_VA) | BIT(PT_FEAT_DYNAMIC_TOP) |             \
+	 BIT(PT_FEAT_FLUSH_RANGE) | BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) | \
+	 BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |                           \
+	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
+#define PT_FORCE_ENABLED_FEATURES                                       \
+	(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) | \
+	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index e69a75511313cb..21e33489cbf20d 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -132,4 +132,23 @@ enum pt_features {
 	PT_FEAT_FMT_START,
 };
 
+struct pt_amdv1 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_AMDV1_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+	/*
+	 * The PTEs are set to prevent cache incoherent traffic, such as PCI no
+	 * snoop. This is set either at creation time or before the first map
+	 * operation.
+	 */
+	PT_FEAT_AMDV1_FORCE_COHERENCE,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index defa96abc49781..dc731fe003d153 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -145,6 +145,18 @@ struct pt_iommu_cfg {
 	static_assert(offsetof(s, pt_iommu_memb.domain) ==   \
 		      offsetof(s, domain_memb))
 
+struct pt_iommu_amdv1_cfg {
+	struct pt_iommu_cfg common;
+	unsigned int starting_level;
+};
+
+struct pt_iommu_amdv1_hw_info {
+	u64 host_pt_root;
+	u8 mode;
+};
+
+IOMMU_FORMAT(amdv1, amdpt);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


