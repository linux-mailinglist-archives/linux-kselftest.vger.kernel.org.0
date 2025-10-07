Return-Path: <linux-kselftest+bounces-42844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D505CBC216B
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 565473492F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE72E7BBB;
	Tue,  7 Oct 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="URhFVNED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240A2E7F00;
	Tue,  7 Oct 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853956; cv=fail; b=uuFOBcCk4P65ekvdWokycP7QEL2vW3rOS5c14RVjxz8uCr45qw9xN8+QiEP0UP109hpKINcr0KJOoTxo6KBoyooyspIGtvJFmuxgmD+a6PV0fshPfGQ7rqCY1dn/l1qgxDJPfjNQfDa027jbVPlvZFyvfDbTEE1FrgbwKOgFBjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853956; c=relaxed/simple;
	bh=RuUwFsJcbnsE+O2d3y7Py54r/EdV85WLqZQy2YBu1b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtWTCOT4FIqsAbNxlnTKa2ejnJ6eaLJp9znEZREAeFZlfxdmaL/KCMB6lz2MVckvY+cBcFVr58ru3zuBtdv9mdoyt6Wc08JPXin7OZpBNTDRFupUUeOQ1wqO1WYnqdRnxgU+1Yisd/YTVLCAOkQ6jfdVaeLDTHYGpsaMLjFIdy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=URhFVNED; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUhQC0IojEUZtFAx76ONsyko0KdBzsodOHJuI7nUm4aNNvAOWkLQqCDfBZcalKwFaMAtCXD7IULaWjp3OcWJTef0zpbf+zo7+FZHYtEDJUeU7yhRObAykwuaXjclruCSkVupQVe+DsXYp8TOht4z9Sh06IaxQVOUqe5q0OfmaTgdqW9Dfnr+RRwdNHfDyn2GT/k9qn4k5gotThow/yghxo5a38M/GkNtU95dWFv943czP6v9z5C+Et0gskMPZi3Mt4UQNf4OfXFEL7Be/pg2RHzrYVuxnw9E26aKFM7Gd43w5tpINxTQzlCLd66RHDfr0hKfegLr9MG1AhH2xdMcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwArjeb27ONenmGlL4x5K1CCTvLLZ+fG0x5pjUMRm7I=;
 b=pyVaBqX7yOV8oeeUEZfIdgtJtMthVWTdbLw1olKwlyzIxzFOA9ao07Bnx5pBat2xKmAo7OZioQyP5YQ8fAbia3fMqZMt+IhUyhPCyjWbA+qqK3IQg2blxS3iA+wpkLaWZgFGQh/NwDkImWh5pSo5xJe34lb6CrgtxXPa5TQBcyPAyrt/+CiU0uoswxPU1oHlsu+mgGvkjfMjtBwFnou9Sk1LUV5GC09NBof6DFx5VkRAWwWb3iu0xJJyY/dWvnMMnKr3HYjQqEKi9IZC0DVDbWGYBp4jfZ6i2PSGGp/hJtsxRwAav5VcrwNlemQTEZ+Z4f7CG3XJHiehwtEFxVYi6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwArjeb27ONenmGlL4x5K1CCTvLLZ+fG0x5pjUMRm7I=;
 b=URhFVNEDRtaRbk0WGKqTjGpdyQ6VygJDQtwEVWHMmbJaOlHMJvlVzidS4einHzkdTfoFK2B4W89kTjzOIXbfgONw76T+VI9aBWN+GJBKEUhiKWdqarpeZTygFXvwK9YcaN2+o3fQc1SJLRXt8FhqDstIu8ybIPE7EErpAa48T/uhH/kiiK+jTvDLDAt4DpStcwDLFVDKrFxrAOh9lTZwhNjCwGm7cFwHuH04YYXuwFiL2s6nthuhXZmIQXvBG71Kvsi+XE8+OVX2rinCnppGoiz+CMEmp5zABXO785VRwtZlSsaeBcQt1GT2zcjLPT/bIjBgOCgVnRwGNKaWpezgzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:19:03 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:19:02 +0000
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
Subject: [PATCH v6 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Tue,  7 Oct 2025 13:11:55 -0300
Message-ID: <10-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8136e247-4747-4337-d200-08de05bd3adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RzvUmaKgheliXW9czYPG9D0jg/V/B4/7gPOdgijxaCvLlqEl13pxTh9X+V8A?=
 =?us-ascii?Q?dAQLd7hPUeG7dxhJkp9aZvKDL/FA/Aj+83E0OsiPwwAC4AK07ZhUdWFwVs+d?=
 =?us-ascii?Q?uXyKgDbPQ1DNv/YC5tF06p/k1HUK/6YghddA+LsPShQPYI1RcGRcqoeh4HMb?=
 =?us-ascii?Q?DCs5qovryCHOeCvLGQvLzMOSs4GA7ka7GDbmLNkn7hPsJh7jDQ2iBDWqpJja?=
 =?us-ascii?Q?zSzSHIIzaEV5okLq1biXu9nC3l6KH4TWfkvxOip1gL6g3XdUAnik0NDpS3rD?=
 =?us-ascii?Q?iU7YeWXxo9pHer8VkO4epypeSBGYHvx4BfGj+iMjDSCqqRid0eK0+rn573Vj?=
 =?us-ascii?Q?FLlBQ44JM/ofc1ObmAXQprP0NTDP8NC3mKXSl5lDmVlhgFdDMFCCkkUbzGup?=
 =?us-ascii?Q?DpI/9YXSSfG3/cBn5dev0KqMsUQQ/BRtNa6GUR8X8HEQQro256ci+ysISqqC?=
 =?us-ascii?Q?nQf2yE4dZXrGccVlkyufl5Ao4RHneZ28bYJUCuBEd3+97jPAVOvviLTJHbK5?=
 =?us-ascii?Q?plo3LQMfczJ5EP7ceQL0VCdecCXNSxMbAIQQt2AMs/Uy7f88FQUqjZzhqVXp?=
 =?us-ascii?Q?LhgAzyLeJLbhxCCobjgPQByr6WN95tKm0aM07RyxVOYHPFH1O/SnZP/nGDrh?=
 =?us-ascii?Q?jFFl+cZOD9QxC9Cx7pQku3BNgYakz72bNka12aTH0xLWLaVB6eRwtUgN0/oc?=
 =?us-ascii?Q?08WHUFZNmVMs9wOkvY+Tve7wrq3nUml4DwkxMvEF9Nh16IWhAmZ5KGw5iAQV?=
 =?us-ascii?Q?9hMvwn+Ff7ZTQC6c0g+RZ4POO/x1rBrKRWo4dzQ5KxENtraZxuXwB6QgA9tB?=
 =?us-ascii?Q?V1vNLIVE5Qjxs/xjK2a04f9bR9ayRLmDsFmk5/v4g/2WSIyEl5fU9ZFzmZpv?=
 =?us-ascii?Q?iTmPAsrsAfp6Rw/FOz6jYygM5r7pemZ2ZvNgm+GFwjHsCMUDMFgG3cANTgnY?=
 =?us-ascii?Q?l1L1ysuDvGXwJ/h11Ke//ruGDGDydxA9EHOO3exHI9HezK8tFjd3OdG42QN2?=
 =?us-ascii?Q?t7aHLqN58DDi2h/EyZ9VcPOaIWrwT7mQRRCCx0i6xO0jVxA0qkKOGveXAoun?=
 =?us-ascii?Q?b5jIq5USyG26wqD+VNUJHdR2PuqW3xeRbZxWd918/1vqBrGscQoFL17dzUOx?=
 =?us-ascii?Q?rH9iCLFoDB+dJcbK4g0WSGLZIvBhQgTfKOOhzU01SVrLRHdzafiuexTFfsnp?=
 =?us-ascii?Q?9GyxqHN0f3Mfkdd+eX5nt/KzHYYK5/5qJK2wJWQ7r8VnL+yBVYj28Qh2E5CP?=
 =?us-ascii?Q?qnGB2dE3ya5r3Bavine+pOslj5q8hdCgM84UAEQf18RUnGc54nF1g5TKY/kX?=
 =?us-ascii?Q?/NxqcXN+YA+rD7YUa01HNx+QIZ3Wsv2cSG0rtNhna+bzzLiQ1uNqkoAPHLko?=
 =?us-ascii?Q?Mu56PyV65Ml7nDXvgN1mXDGGrX+Z3/R8W72fT5urKLHa/XrW8HvlXHA2caG6?=
 =?us-ascii?Q?mjNBcLAY7JwWLHSnZggBLzb5jw7I0BsSmnrwbBj0id9V6uUaLOSjMgP22B9e?=
 =?us-ascii?Q?eiyP+q3kJjPMeX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8kfau1FipctiHWddiI1SkRypZ5sNeQeKrvAorIgl59Gu6bVw1Moe4/lKLO9O?=
 =?us-ascii?Q?8OtuWWb4KbXbkq9y9kfI7ENcvwIekUaow0OQkOdrehSg91UN6dWs6GFp01GG?=
 =?us-ascii?Q?PjS1XECmwDbVHeT4fbjOC58v9HHk52s3u1PnChClEYvwua5C6baFxATn725P?=
 =?us-ascii?Q?P7t7Yp9/EHBAeI4cVxaqujjD4w8gOVhnyXs7jksdFr05fli/WmLCtxx+tTRq?=
 =?us-ascii?Q?IsC3ucJjtrm4ITVAdCntMegLa9xadm3I963JyOR+YccIgBtvfEhQAp/c2WJB?=
 =?us-ascii?Q?PiKu6fMx9ej8x9B2z49EHxG3Fz6iWr2CTDvoYXG4tSj3MXo7jZeghmqDmxpL?=
 =?us-ascii?Q?syKCS+x9F1d8PvahIIK0p0EOFRFpMAsUG2YoESWl6rv0LsD3HU2P4FW6ZvzQ?=
 =?us-ascii?Q?yF7eGPpaadOKx/mqUyYEymHpOS2xhm5j7ySyqtZ0/tn4XwAyzs1IAn3p2FZ/?=
 =?us-ascii?Q?V8DW1ut+xBg+bpxy7rVxaEfDWeRKPeLo4UWOgQMQ/fSrFG/IefNrkewTCGDa?=
 =?us-ascii?Q?Ou9iWY++9MhlvuZaxRFUtNwQcmR27Ey3HxmGuhubihoo/cq+UibYjymUgvpH?=
 =?us-ascii?Q?pzzNum3XyRJCpk33KXswWuXaSwx0vA6L8d7x0GTAjRKZ775L3BmQbizinmGw?=
 =?us-ascii?Q?QzhB+NqAhjNXbXkb3uJKrQevcfHbI38Lxtr7vit0AxCaw6W+ZPOiC2mtoq+l?=
 =?us-ascii?Q?x/TZFSqqqxgsg4qHgyDtuPr8fnvXpVE4UHP7OJXVcQ4o8jcAHAdOO2UDgtJs?=
 =?us-ascii?Q?6weqxpLleoikfuYyBBvuUW2GxNSBfSXao1wnPxCuJw8Ge5PIhW8PGRc0WGbZ?=
 =?us-ascii?Q?Lyec/6+0l7SlFfLxaev6kLPQyRE7l5+ejgIrni/79iwOVICqUmK24RfmVVQv?=
 =?us-ascii?Q?QxBtd4UFXnAI0sUM1OatIE2TZLFTVpK5MY2gcAEfM9EJXx5qSAaAzyCSmBRU?=
 =?us-ascii?Q?Pms669NBonJOLBPwehlWv+cpNTrpEluU5x27UI4gZN2u52qoytU2cFOB0UFl?=
 =?us-ascii?Q?6cvFB57IT18VkQZAQcNP3EVhTQ9xiEPJQMsQtTd5YfEyzjVXmCWhMlnL0PG5?=
 =?us-ascii?Q?YvQAAvYYlIwWSb1TIGfi9rohyZ4f0bbnVtwBvvLcwBjKJ1bu/+ydJvge04/N?=
 =?us-ascii?Q?l8gwcz2LmTiYOoX5BAUnKiu2kPQhSY8vL2irBXoAy/jVTy3uQ9GnRPi21BYl?=
 =?us-ascii?Q?vcnKzjoPALmNNQv26LdwgWlHm64GjHZt2UB9AbdnGXUJ9GYT9O+ZVEijSuS4?=
 =?us-ascii?Q?zOG+ln4STi+Z3a67ySnngeHvx7WjErnBMXrXE8FB8FuI/23mu6m2o+Qo5dqQ?=
 =?us-ascii?Q?9sMd93UKGRJcsFG4UElv8qVOVy7LcUwUmXp4Tp4CLPs/WXNPebKZe5dlC4he?=
 =?us-ascii?Q?9+ZazgJwN/yEjewiQBjjadKwU0q/CoEEwRIHGHWZSI0e460o/X44ldRAEh/7?=
 =?us-ascii?Q?MqfckUgfTusi0gzajnQQ9P4Qvfp7WHylw5UKXSIKBUg84jsMzJM7wU0Saqk9?=
 =?us-ascii?Q?LEbyClUP7xUOwFSqC59eZS7HT0bbBAfhW1pWZM+xVAwN4sBiAyDX0D5Kk+Bs?=
 =?us-ascii?Q?CIe0DxJsMBiJsFF+hOk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8136e247-4747-4337-d200-08de05bd3adf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:19:02.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5L2HtCQktneMaqsMV+cm17BNiMeh5XaMvK3BMNvtDT+T0pDg3FzESSHmkZ6dRi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Slightly modify the amdv1 page table to create a
real page table that has similar properties:

 - 2k base granule to simulate something like a 4k page table on a 64K
   PAGE_SIZE ARM system
 - Contiguous page support for every PFN order
 - Dirty tracking

AMDv1 is the closest format, as it is the only one that already supports
every page size. Tweak it to have only 5 levels and an 11 bit base granule
and compile it separately as a format variant.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/Makefile     |  1 +
 drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
 drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h          |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 32f3956c7509f8..f0c22cf5f7bee6 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
 IOMMU_PT_KUNIT_TEST :=
 define create_format
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index d0299b9c7b9071..06583233bb3159 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ITEM_WORD_SIZE = sizeof(u64),
+	/*
+	 * The IOMMUFD selftest uses the AMDv1 format with some alterations It
+	 * uses a 2k page size to test cases where the CPU page size is not the
+	 * same.
+	 */
+#ifdef AMDV1_IOMMUFD_SELFTEST
+	PT_MAX_VA_ADDRESS_LG2 = 56,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 51,
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 11,
+#else
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
 	PT_MAX_TOP_LEVEL = 5,
 	PT_GRANULE_LG2SZ = 12,
+#endif
 	PT_TABLEMEM_LG2SZ = 12,
 
 	/* The DTE only has these bits for the top phyiscal address */
@@ -371,6 +383,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -381,6 +394,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/generic_pt/fmt/iommu_mock.c
new file mode 100644
index 00000000000000..74e597cba9d9cd
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define AMDV1_IOMMUFD_SELFTEST 1
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT mock
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 3a7885eb2e2099..76db2abe3a97cf 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -236,6 +236,12 @@ struct pt_iommu_amdv1_hw_info {
 
 IOMMU_FORMAT(amdv1, amdpt);
 
+/* amdv1_mock is used by the iommufd selftest */
+#define pt_iommu_amdv1_mock pt_iommu_amdv1
+#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_mock_hw_info;
+IOMMU_PROTOTYPES(amdv1_mock);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


