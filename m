Return-Path: <linux-kselftest+bounces-40702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25DB42840
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9943A1B28468
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849032A81A;
	Wed,  3 Sep 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ep4nBqNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB04334712;
	Wed,  3 Sep 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921629; cv=fail; b=qn8MeRzYOEB3wsQHglO9HJEjcWHvtVzadN+jYJh16GtCsqZsqZFuxULhWLJ3Vum7S+jA7hLOVp57HvYaZGPUriXMffXRHjQaGsyKKcMHazxNzXzewvAlUajUkVppCJ+f85C8s3Rh6Lh7pyzJFwvZ6s/0Icgv3lNbm8LJf5F699s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921629; c=relaxed/simple;
	bh=fa0swX+GmU0yGvj9nJm+IstKazESajGC0zd2LqMDscI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHWEUmx9XNPU4yYrvN5UpIewbmAg18607+V6h4Ukb5qnxT3xKLlcLvjYkU0t/2PnFfgOWcrdYlaoFu47cv/M7GSH/5OWOlzF2xQCRyGJvNQLpzmIe2NjnLxUOiZgw6pU/DgQ9cgmnhzPZAJXYcRtlqDD+1cU4S54LteuTmU/R5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ep4nBqNB; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKuHIzoTGn7+VnYrJEsyPTPWB4B5i087Cyi/oWlScB6qCxn4aRoyy273oBW5G1g4VbODykZ3VRn7tExOQKcBlyYQ2As/7pz9CuFa6dwaJgA5f9ZO5//yAtFmyASJEhT9qjlUpuMxVteMdUxqxA/bu1K+mZFx+S+ZYvLFYGngvTH1dbduO7n0T4NxbWWn/nmVJ4aW6H0yHSZg1kiq27Kry+gqpExUenZ2SCZ2cw24khlEGnRaxXZPuWsa3B8RLZvQJjB7QFy0+wDeFwFzrhzNCCpv4e6ZckVMsFjKTcZ5oJnh11gEi3a2MHWFf+4H3AUhXJ6dWHHfNh/wjoIlJ0S6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP7+p8k72HXvc8xzDfxGqX1uQmskX9tsDWRFy6zQAQw=;
 b=NnpGIky5YXjQydZ2LCfhkO3pBXzspo1LYDJwBPQFBh7zPZlHN4mWvhtWRQCJQoLcijpnhF96emM4UE4CYsEkVTbbLMhlXzqhgn9NbwV7Y8FzDTjiO8YTbrmujQ8tGil7p3lVLVLnfZhg1sLe6pzD8Muz1I62zEx3+0oqjygABOuklf6FNPaUGOmGCfFcmI8U+/caz459OT873LBADkePTW3OhjtNF7AXjwsN1B1j2b0nQQygK4I1YUp/zV6xHlX4FWm1dSA8tKC0VaDO+JO69mOQaxx1YGUQ3rgJ9E0lb7jODiVqpuxq13wm8L6VFJPqlKQBUsj6hghPXX2+QEBlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP7+p8k72HXvc8xzDfxGqX1uQmskX9tsDWRFy6zQAQw=;
 b=Ep4nBqNB7JxasLGTBw0tXnl2aIcPstUhJxb/1eZLF6QQChjdYcre36wOz5IMqA30KkTuGAOdu3mOE2h3q851WGAKjIRY3Xoby0d1DvfV89G3q4Fn0tOIrmLjl/ERcHDEwuHuaJMbLJapuoDNVfAwXpXvddPqCdGS0Dcp1WJTJ7s/Ijlgk6v5LtcXlAEwMd5qAvVssmRQmoH8YtbCDXSJJJ8wOpQWq4m0b3kZXigZRdbg2MQYre3N6ktMPB4j7L4r+1ja0+BGiWHZZaydklLnrfjXk/ENzxZx3pijf4rB8SsRnL9XRApg754sk+NY0hGgbnz9c++31dAGbuuji00MBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:52 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:52 +0000
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
Subject: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Date: Wed,  3 Sep 2025 14:46:31 -0300
Message-ID: <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::24) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a134f79-fd97-4bc2-4bd0-08ddeb11d9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VQ/zPMNZa5s89QbAN706OcHh16PP9T4f3p3ZTlTd3G8+Kk06L03dMhpvP5x?=
 =?us-ascii?Q?hwBBIxERqOMq3Qw4y9DHwI3QU1j7erSnnb9I5Czrz7gUO5mo9i2Z2ah3fHtX?=
 =?us-ascii?Q?tCKJXrn5P6O5kGp6IwylRQWFOF1pARWaBV14G25KO2VTYb1CnBVOZvZw12vd?=
 =?us-ascii?Q?/DLmtLwBb3fADGAnXW3xgsXhxaG8AnnMw6wXQSFpvuAgIkFogdFDfaLyvTOT?=
 =?us-ascii?Q?WzXmgOAkb0eneoBkPkdrwHSbcNPcjVYjfwKYAijrMuLIMdbXu9KS+scolNHi?=
 =?us-ascii?Q?TJOi5hrNMy0QktrkUqXeh+Utmh0AlSjsG0zpB3BpMc2uuOeZhKq/o4e16M80?=
 =?us-ascii?Q?1j1S5L3yoeEyfHfbotDnELFm3X+im5N7ojGw5jDG9+uTan9KZwqCxEnx+GRV?=
 =?us-ascii?Q?j3/uTcq5OGpt2mTzEMarUpmqiRwyKmKTQEeSL0E0fT4bGe5Pfx+Rwg/fTqoD?=
 =?us-ascii?Q?OhGB48HtiGgkv00UGzShesR1ylbnMDhRsSHBPxa8Fe9vNSeoKpkJOIh/02dt?=
 =?us-ascii?Q?VnpgzbjGXyA49GZmNrRlBhzy/zRuILtulbtuHIZVKg/SlVAxbtpRfw8VdBoE?=
 =?us-ascii?Q?r++zAHw+hK0nNdGEELZ/9DLYfsYUV0wHsq9czhRGx5Nrr52V+or3QlvB+zj4?=
 =?us-ascii?Q?4j8qy7L9Ir+DsMUEW2yidRgRX2dqMcZivZgNs88A5zb9KDPQlbDdyNFrhVUH?=
 =?us-ascii?Q?2hMEYTL5NbdCN0AOEIoeQ4MiJUE8bnLvzBvGuRAhQY5lUqqY5m4i4CE4F4Gk?=
 =?us-ascii?Q?Ku7R1UdrdX26m5+2Vr+61exU3ilg+FfkblEkaCPVf/eaKV6veFprGy+MyiJk?=
 =?us-ascii?Q?7AHVIOfI0R60GZ36TfJGL8jYZMN+dw9qrJb9quqqjaX61K6zTLoFhG6sKvja?=
 =?us-ascii?Q?QKQakcHqUqfeuT9/9eiCsdANinJt0e9C3ERLhrECgjRbd1ZiDxMP3pFT+90w?=
 =?us-ascii?Q?bTMaKnuEF9BUTFSuQJzP82vn80TI0DMufSi0CryifxFNVZXA5zVzxtP8iZMu?=
 =?us-ascii?Q?0KLqS40QFNbw5aosD1SOEhhcnyomSUTYiZKId3YJHDkC+sFfLZcpEZnwhNub?=
 =?us-ascii?Q?damaSYqx3mXO8feNtHOr5d6ntE8cvv6VmO/T5AWS2sSY9HJBI3BlgstiTXmn?=
 =?us-ascii?Q?oJbB0ib5whq1k2PVd5lD0hdQ+24MD/BwsoJFJzqJNHHrpC9OqqXxNU0piQWi?=
 =?us-ascii?Q?ODRv3hPhHn//wiTZk8hccQw6kqKT0VPMS3fdBC9Xa9ysnU43iGe6rivckANN?=
 =?us-ascii?Q?WqI9VMfcIpMPOiXLP+XIP9jdVV1QYj1g/tMr7Vo9GHethnaJanj42nKuD2qV?=
 =?us-ascii?Q?gFWhVSp/hmxov7crPweBU9S55L1FC646885quUOhL4t9+lhx+sllimz2kDdD?=
 =?us-ascii?Q?wvOC+Q3Ioo2BfThUZ7DRA44reIOS7KjUkm57hF7cWYu/Mqa/ba89Lpd7RPQd?=
 =?us-ascii?Q?7mFfW3xMtA4xuEz7rDzjscB/Mg2orZt/adjnCVqErHharaGmQz5CEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cU348fh6AlBXNfOLm6/G/+PUJSBiFh7VcD9fDyt4Bmbuh+eL6zKz1GX8GjXI?=
 =?us-ascii?Q?w9sQmCI4VTq5PhZKVtrI39TU6olgYmOWMAgr5/1UMQmtElq6fe5uBPFl1ljZ?=
 =?us-ascii?Q?Mph0XSGXhFtlQwNCDyLDirOsGfRfmbfshCHfBiTErOGeLIh0yLLXS2zNIQZb?=
 =?us-ascii?Q?W9j/ZlBOZpq1ZpuZVLm/PRte3yZ3hL+ft1BQKlBFHqaVZaDyGqvSmV6Yv8n+?=
 =?us-ascii?Q?H2WaSv5ebP/JoVCFIJzigz8lNQ2E7tNKXvtzhWnHDthlYeFQufptWGK9A1Uh?=
 =?us-ascii?Q?FEgHIeqMPIE1SFp35Kk2XKCPLSnCtFVNX7hWhoYG+Pwh+02e4WfMLka6zbH4?=
 =?us-ascii?Q?/YHlB67F9m+iVQCN9KVd6+B/38F6pVMecL20V7XlW2b5jTs2OAHtVd3m34+I?=
 =?us-ascii?Q?HJeHsh2sfR1NrkZcZziVCUR7BjKjaH7IEhCyVDBZs1WzKcXGrfpGAealpGTA?=
 =?us-ascii?Q?6p1B2exB0iyFFx8tuyp2NjaJ4xSLGNhO5+g7ohoKR5psyLxr0M12ugP9cE88?=
 =?us-ascii?Q?i6jtWrja9z3AzjjAfX4mLWN3qVL2TONIcpoaOLzgP9yEUOfgHqYRgBUrEPtQ?=
 =?us-ascii?Q?Rh4JhEk+Y5TJCuHOthDi7YjFBGQJwd1osHqqAgXVtMXj90LAO3ZsAlWkRqbs?=
 =?us-ascii?Q?L8gxktGaxTHPXXXe8c/I8acE5HbNlhK368drH/cTJG6SEU4sa79sqgW5A9fu?=
 =?us-ascii?Q?2cA9bvv2nmFFhteMQvqhnlUrRgj/9sDfufnSkxgK6aZgK48ImvkfniQdfkoO?=
 =?us-ascii?Q?OX5uVl7a2IwOjZeOXkCuCrXGRBfJyu3RowNTik+q7QtTDmkYgxZR2LUcnE2t?=
 =?us-ascii?Q?/wbR/g/87tC7ajiAYg5xOdrNJvtPbd/1xzUQjGpIRdvakAi3g9SjMvN5OdH/?=
 =?us-ascii?Q?Z+NdEpKYACXs72LylDZJ5NkW6dUm7/6qlAYKryJvzzwl/xyXxvupqHxMGuZ1?=
 =?us-ascii?Q?Fm9O4fVv7h8IcLzIZri4hfk/VNc/lLpx8zoMksId4aiZFc1g8qGXqzbQvLNd?=
 =?us-ascii?Q?2lq8VCM9VcQceh+4JQmPFESNZUrPyrLl57cD5o2lF/2sAGn82m/YQJQGLrj4?=
 =?us-ascii?Q?ygnmZClBd9cebeuu7hDuxwxG4hg68miDY8KNVTPPXa8S8G9dkMhIMmsUdKCg?=
 =?us-ascii?Q?H97ptQKJQIrcEcbbFv66M+ckEBYMBrj9q7sdaVivjLN8p61V5nIjjYM0HS0t?=
 =?us-ascii?Q?HRzqa9Ta8H7M/YWdJFhc0IzQGaaqjjZ9FTT8ZI8/ZXxDWt9lKo5XKzrL37GS?=
 =?us-ascii?Q?nF/kt/T7VMjBhIZh2ED3EdX+Lc0KHnH+yK+odPIa9NfhfH7DF5mJalVX632m?=
 =?us-ascii?Q?ZYaYefXWVzd+LwpLwMcT0MpkbAqwbKYn0pWubBSMYwjasg4HSpUribY1DX5c?=
 =?us-ascii?Q?KdLiFF4M9uI6iIPFgCzPuJ45fH7/uX34a8b1j2CsR9/A/G1rxnoQ3gfZ3w5b?=
 =?us-ascii?Q?ULpfRvRohbskilxQ/67HW/E1gzBAY7fT8nl+MVin/7ZCO+4D6lE72qLH0rxy?=
 =?us-ascii?Q?TYTKpKKYWzp7ejweHAeO4PT9kmjvu9yuSnEWjhjqQBAChng6sIFZ6k+jMgwU?=
 =?us-ascii?Q?Ywwqp5E/ChYAU5WKSkA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a134f79-fd97-4bc2-4bd0-08ddeb11d9cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:46.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HzG3qU6mgOEAlthzZ+zDd+z07HTwL0+/d0NxJzGA3YVLF9nSixF5qK9ie11YqAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/Makefile                     |   1 +
 drivers/iommu/generic_pt/Kconfig           |  12 +
 drivers/iommu/generic_pt/fmt/Makefile      |  11 +
 drivers/iommu/generic_pt/fmt/amdv1.h       | 385 +++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  15 +
 include/linux/generic_pt/common.h          |  19 +
 include/linux/generic_pt/iommu.h           |  29 ++
 8 files changed, 493 insertions(+)
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
index c35ddc7c827e92..208c8178d5dbd2 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -29,4 +29,16 @@ config IOMMU_PT
 	  IOMMU_PT provides an implementation of the page table operations
 	  related struct iommu_domain using GENERIC_PT to abstract the page
 	  table format.
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
index 00000000000000..901fc4a80e9a83
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -0,0 +1,385 @@
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
+	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, pts->entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_table_pa amdv1pt_table_pa
+
+/* Returns the oa for the start of the contiguous entry */
+static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+{
+	pt_oaddr_t oa = FIELD_GET(AMDV1PT_FMT_OA, pts->entry);
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
+	    AMDV1PT_FMT_NL_SIZE) {
+		unsigned int sz_bits = oalog2_ffz(oa);
+
+		oa = oalog2_set_mod(oa, 0, sz_bits);
+	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
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
+static inline unsigned int amdv1pt_table_item_lg2sz(const struct pt_state *pts)
+{
+	return PT_GRANULE_LG2SZ +
+	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE)) * pts->level;
+}
+#define pt_table_item_lg2sz amdv1pt_table_item_lg2sz
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
+	return log2_ffz_t(u32, code);
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
+		/* See amdv1pt_clear_entry() */
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
+static inline void amdv1pt_clear_entry(struct pt_state *pts,
+				       unsigned int num_contig_lg2)
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
+#define pt_clear_entry amdv1pt_clear_entry
+
+static inline bool amdv1pt_entry_write_is_dirty(const struct pt_state *pts)
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
+#define pt_entry_write_is_dirty amdv1pt_entry_write_is_dirty
+
+static inline void amdv1pt_entry_set_write_clean(struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, READ_ONCE(*tablep) & ~(u64)AMDV1PT_FMT_D);
+}
+#define pt_entry_set_write_clean amdv1pt_entry_set_write_clean
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
index a29bdd7b244de6..ff4da1ae95087b 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -131,4 +131,23 @@ enum pt_features {
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
index 182d5db2530a3a..58f365d0cc418b 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -115,4 +115,33 @@ struct pt_iommu_cfg {
 	u8 hw_max_oasz_lg2;
 };
 
+/* Generate the exported function signatures from iommu_pt.h */
+#define IOMMU_PROTOTYPES(fmt)                                             \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
+				  const struct pt_iommu_##fmt##_cfg *cfg, \
+				  gfp_t gfp);                             \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+				      struct pt_iommu_##fmt##_hw_info *info)
+#define IOMMU_FORMAT(fmt, member)       \
+	struct pt_iommu_##fmt {         \
+		struct pt_iommu iommu;  \
+		struct pt_##fmt member; \
+	};                              \
+	IOMMU_PROTOTYPES(fmt)
+
+
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
+#undef IOMMU_PROTOTYPES
+#undef IOMMU_FORMAT
 #endif
-- 
2.43.0


