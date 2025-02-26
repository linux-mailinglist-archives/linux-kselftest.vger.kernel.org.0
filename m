Return-Path: <linux-kselftest+bounces-27660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97592A46CDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108577A88ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC52586CD;
	Wed, 26 Feb 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BiuixxKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4E224247;
	Wed, 26 Feb 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603650; cv=fail; b=GQ8ZGhFkO1JDhP2WmpJamzyP4r5JFliE3fAVG2dxQy70fSCAWQr6JETosWaoptOqZA/eIGe0DobeZwBfFShw2rXEIVrkjlavTThLCtrUIMF9ZRhz0YAePH/9mowBHkZN9hMMQ/aySTohu92aLTqYMEEi2hz5t4Q2mILlmAgGLRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603650; c=relaxed/simple;
	bh=S0A1mKJlR9A+AyVUpwtF6CBskgwEYXk7nsd/HmLtLns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ds8LU5q8UkrCRxGJ2rHUbOAk8tJRPNksp39nPrS705CdlzsTlDDif4vRFjRQku1B72kVep5UEKZh4T1V3VeMnVeWzhSI2hq6L6YzgyqVOmxm0MlZj2rqgutGLaepHf9asZQnzB2qmLVbK3uvjgaqkIbnRFOZT2DX3velRLe9luM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BiuixxKV; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VS0jcmOys00bdh31wnTFXvQc/lYTEaFwVgt8JEZf3nMaSYaAJOPKBvIaVOVb6RkxBtGhklRjhgG3q4eSK0EBZECg/uUDjh4gGB0x6nCVAgVQlO/H0dDSxJ0doyhEgaIoP+ak7jp086Qhy9ZZZR4XS4y37j0L1uO5vpY8u7wDnjC3G28GW80ZXo+9jzJvk2Ray2PgNdHkoPKkGo9r0UQmZIXfUjh7WtnZgeW/L1Ow/k5hSZRZyVSB1Gt+NZ4g0OqNf3LASARCT1qz8RS2ZCszVjAqMMwSiOrVYHUJkLMlR7Ch4x92T8m1x3H7SMxIRBcgs+a2KqUoxXkw6jL6kUCOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOPgE9Bitq6BAAMBDm/Zco3K6CauSloQGubTWAbltjc=;
 b=Gaxt9iBC1id7gtd1G80dKxzCsjvWGdfKWQYuLTILE4ogrjm/XPr3PRLGoQZ3Knf6jwIlCnicE8QLDp6uDTYoyXHKe6S0hNy9VDeVS3bJK4NbCc5QY9bcmPwwzFtTX50BsAjmHwNNhuwNIFr2pMeYREbdA7SjtWtWfbjhVNa8WagldX1VGqWZcnyanRhz0TeBDuYtBrEH+KCVCHFIoYNirC4LfpjVLkX4FQc2CJz0BoH9EzWT0ojGnR57TLqKMwPeTBT131u3xwLC5do2zIY+Gr5/2f00tpsRa1W04Y+V2+9d9CMtAZhaWj4mLY4WpW52wb+Nz1PQ+encQ07O3alQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOPgE9Bitq6BAAMBDm/Zco3K6CauSloQGubTWAbltjc=;
 b=BiuixxKV7pfVHohjJyK15+puCM7/oZZzfYBDdRgSiHixMDv3yOuU+lbIPefbbUmRbR2EJDdafF9wQWsEvKz9QsCOZaIlpoVmsWUzoxU9cY/zZYCwZAgCUzZPVdIxjLJegbdMATXeuON1NaeDOjrpy9I6BwFJQYWd6LUoj8nQd3Wau37l9sNcEdHNl3ZINo2ILkVGXwS4sH2uJ9GbVVKNEnTil0S9W10+4A3LP4gteV+Uk+GOcEPp1aGflV6MZMiWugSHHRyCZSmMM3UlB+d7T5dEygu6sg3z1QoMv0An6thu6CAt0w8vwL0CzpcUqAnrmljITPqw+1Z9Tew4subK/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v9 1/8] xarray: add xas_try_split() to split a multi-index entry
Date: Wed, 26 Feb 2025 16:00:24 -0500
Message-ID: <20250226210032.2044041-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 111195e7-01ca-42c1-b294-08dd56a8a086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpcPqn0vCxysF55ReFDrFUg1X16tAcOrGU8VVgrUXIezys3okCWjDsoWBYZB?=
 =?us-ascii?Q?Bytk3j/vp8Khs1+pVKmkaMXAAdF+zayVAcz9oQPb1lBtIB/qcEnRU0eIWg/K?=
 =?us-ascii?Q?uyCFjve3TGVkYPeMpvunP3ZL6JQdKR3soBlPlWAazvmAxI1buO6G2rxSOBKo?=
 =?us-ascii?Q?y8uFMevqNaxfYtAWLpjLP9p3yAoH0830CJmL/PkiC3K0/6d3fh1qRewNZr8+?=
 =?us-ascii?Q?u4HV4jnf3yJ+bA8RwsMj/U3Trkqarh9IoNsY/lHkUNs0hadPZHszgQ/0SmyB?=
 =?us-ascii?Q?xhd+mT9PyKZb0Grb8n1KO8p7xPJlIpQJY7OOCi1a0VOwtcmHV98J9zVLpl5v?=
 =?us-ascii?Q?2cYzT4qEHb1d5G2IujqXwcj6clEbUcVuCJjRol4RPvcSvZf+q1vXkXgoU510?=
 =?us-ascii?Q?DsTaIeOwLv15a0HH+odUtZHKw608bW/ac8sOStcdpdVvsrCJAAM4V1Z/GgF2?=
 =?us-ascii?Q?5eXByofA6RBoBWURxkEk7jL2x/e4KuZo5XBPpkb7nNvuR+p5wO0k+h7UxfLM?=
 =?us-ascii?Q?2t//FPeLrfetburg7RNhDLDY0RZ6HyhmEyqoN7G9MoQPZowA216qZUPxSVq6?=
 =?us-ascii?Q?dL7qjMUCkrV61pBGjs1GkQiv4bZlKfH+yxb3eDC6h0SiqKYYwYbGhadWw+Ld?=
 =?us-ascii?Q?yzW83fwFeYQOYf/ocp19c0cNad2oMm1oHtvTS+8f6khC8hDmglg1iNbWcETy?=
 =?us-ascii?Q?5syjCjGT3U+ZFcH9z3BL/Xqu32v0gYq7sMvCkamX9ojdI1NwM8gNYXgWG/he?=
 =?us-ascii?Q?U4CwtXiZrfn7RzxBkwAhGlyMxC8GBgfF7hpV6P4YL17cBdg4pTJmjYVwQKOM?=
 =?us-ascii?Q?+YPamf7bZ2Hp+JGJlPT6W+f8JbP0Q1pZ4+9MVAVNmkf5k3/zDaxu6mJC99r7?=
 =?us-ascii?Q?PX89z1Ijzv9pKYl9S/8Y+XmFn8L3O2nv/qOxMeTKxgZ5uuMggdw/lTtxttGt?=
 =?us-ascii?Q?whVY0ltCuiOxcxgHotrb1M2hvJhUEdvREbJldAy0jVCsoK6JtYAIsrXJ/ESQ?=
 =?us-ascii?Q?hx2LLvpkFMy5ciJEPLgF/6GbvMIg3FNVDdXPOGxRvIpbu+uH+iNrFvK9PskP?=
 =?us-ascii?Q?JCYKmUk373PCtka6JHlxNhsULLKb7ZpP8jsHSVkZ2p5yhoXHtB3uoWtpLbcJ?=
 =?us-ascii?Q?5ML9X/wQSxC9CCScbcVtI0But6cOoa4h4bPWLk3PH2k/ZF7gnk2zXZhUuLya?=
 =?us-ascii?Q?vtQRKmTHfFuVD/SCz8M7F+dqCR0Q30k5vRZuhdiT3+/zGATB6kN3iJlGt+Ip?=
 =?us-ascii?Q?+eaSvKvIculuF3HT6Q5c/qqFU9VNl41pFWUCRs0MeA7LiPX3wxZcyuV6jtvR?=
 =?us-ascii?Q?flR7XQTbkrs3LAp7uVjM98ojHMeDvLXv0e9EUYLCtwEwK/sjK+1ZMbvxJxHQ?=
 =?us-ascii?Q?6aAiIfpGCFgYSB/NXZioQ1DhP6kr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OqFSmD+A8Vnn+RC1+ejOcDe4wrUriK0keVZK3T1hgpaybaNS/1v5qiACn4c?=
 =?us-ascii?Q?jW1bVz9ICFkoEcl1C61tA+kRdxoweyAaSgezdKnFalb1DfvId6ypdUR2ANZi?=
 =?us-ascii?Q?4exhCZ1Pny6MVh+rCUA00dI+WGemasUG7hcFR9mor4Q/CQQZxe5hUN2M4xXH?=
 =?us-ascii?Q?nPR0PRp9kaNlOW37HhkbEVJq9BQMwsmXU3sJif0zoIbYrIuJ+lKMkhG1Zidv?=
 =?us-ascii?Q?OjY2KJL/BcFN8hjb+4bT6stgfSEpMf9V6T9j5SHoBK5YrpYPUX3gqASe+wAK?=
 =?us-ascii?Q?EZov7ncjrbHomz2KyLTnKtLoC7EDRhIN8W7TJU4Msm612Irw9NJpuUzR2bkp?=
 =?us-ascii?Q?8wTAqdkNdgKYQ2TB0DI9mYg8K6ik15rkJo7IYTMzHwxA2QsiH2B2YPBjFkKE?=
 =?us-ascii?Q?0lxoBqNIhye3t5qFNlwJXOUWGcpSHQ5hHjsWq7LkjASUqRMEtbCTBV9JvIlq?=
 =?us-ascii?Q?uonvMOYzY5EFFBsD+6GXu8kbo6K+TqiAxJvH0NZm4SOC8dciZorvl1tTd/kF?=
 =?us-ascii?Q?NGaKkH0QHcqYPgTZoduhNqpbfgh/aF2TcPehLaC8JNaMKjABUq1FLpNW++WC?=
 =?us-ascii?Q?pAVRRKDAMOq4W2eq4GcgTzrtZjkXajC6KhCZLlhTsEkB8MqavriSjaRZIQ+3?=
 =?us-ascii?Q?2FU8BYXBebPZ3zxxvqr+EPJ7fqwpDwg/S+NWdx2rnqRT1zSUB+jNK3tsaq3H?=
 =?us-ascii?Q?E9hx946WjBfCwX5K7ka/T2mlAQ8k7mUWmQF89QwvjCcAc4qMeXPyD0kaxHBd?=
 =?us-ascii?Q?zlPADGZbXXCvxD6KJrWJfqWF46gcu1HxXIZL9yfXKKcytmLQyhqVNaNqP9eK?=
 =?us-ascii?Q?UCO9tfzE8KLRqPv0G1VgGXRMySqXQSC6DLleH0on2q6dOK1KwRRvX14I9fW5?=
 =?us-ascii?Q?HWVV8oFyMUuEuyH3OOdkneMkfYMhAEpgXieZBfTV9pE0CjqhXtsfYPkoB7Wi?=
 =?us-ascii?Q?pbJq7U8s3y/LRtadqs1qOIs7SWK1sDI5LHn3Z63Q804h5U8pL/9DQ/gmEAxr?=
 =?us-ascii?Q?Av2F4Kfn1uspUep7ErOjL+x0QZUGEJcV4+V1LnQZW3/VmBehxRtKg9SzIj+y?=
 =?us-ascii?Q?T5y2FdQ0lJagdvGk4pxALw4NdBYtSPqNVXa0EpytXwvuiPmCgjN14ALyR1mg?=
 =?us-ascii?Q?ZRMeCMc3smqg+EcpiPJpdubxqpWlcjyha8jCArP2AW4+jKYlyo2PyR5pTYlV?=
 =?us-ascii?Q?IPFv0YGtZBGyQMclYZzHvYXDreDJUVbKRKA/KWCk1d8JoOvfvoaZDy1ULZ9m?=
 =?us-ascii?Q?V8pov4YTGa+Mba5n/HgOP9hmWbR0uyL6HujFRbAXi/Rv+vX5IvfpjneGRCpB?=
 =?us-ascii?Q?uMd6K+rbAIVx2e4q0cPqlEPrr4BJSBit1DRLZbS5QwKd+0y6ubIenZQgHD1S?=
 =?us-ascii?Q?6/IhAVkk8m6Qq9yh1czTAJ8HfUsgMApQrWfRlwXy0fAQEXIRbBejxEF4vzvj?=
 =?us-ascii?Q?2VrhBkI2atCML17sCassDlUY7oOfn5C3NF1Wbto7LOESUIcTp1eVYPqVkCZD?=
 =?us-ascii?Q?G+Tzfdx8NaFaBuZXqSUXnAC2hfDuyEnh9JValzvAnZnDTf9XmV02SMpp6/Ll?=
 =?us-ascii?Q?sgDtoBeXTWqBDyn8zyU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111195e7-01ca-42c1-b294-08dd56a8a086
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:40.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0NXQM392VabD6TIXj+ClVwutt0Vj7ntzLljv3U/IE7cx4tiz1r+nmuHhNRafIq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

A preparation patch for non-uniform folio split, which always split a
folio into half iteratively, and minimal xarray entry split.

Currently, xas_split_alloc() and xas_split() always split all slots from a
multi-index entry.  They cost the same number of xa_node as the
to-be-split slots.  For example, to split an order-9 entry, which takes
2^(9-6)=8 slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8
xa_node are needed.  Instead xas_try_split() is intended to be used
iteratively to split the order-9 entry into 2 order-8 entries, then split
one order-8 entry, based on the given index, to 2 order-7 entries, ...,
and split one order-1 entry to 2 order-0 entries.  When splitting the
order-6 entry and a new xa_node is needed, xas_try_split() will try to
allocate one if possible.  As a result, xas_try_split() would only need
one xa_node instead of 8.

When a new xa_node is needed during the split, xas_try_split() can try to
allocate one but no more.  -ENOMEM will be return if a node cannot be
allocated.  -EINVAL will be return if a sibling node is split or cascade
split happens, where two or more new nodes are needed, and these are not
supported by xas_try_split().

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kairui Song <kasong@tencent.com>
---
 Documentation/core-api/xarray.rst |  14 +++-
 include/linux/xarray.h            |   6 ++
 lib/test_xarray.c                 |  52 ++++++++++++
 lib/xarray.c                      | 131 +++++++++++++++++++++++++++---
 tools/testing/radix-tree/Makefile |   1 +
 5 files changed, 191 insertions(+), 13 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index f6a3eef4fe7f..c6c91cbd0c3c 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index entry will set the
 entry at every index to ``NULL`` and dissolve the tie.  A multi-index
 entry can be split into entries occupying smaller ranges by calling
 xas_split_alloc() without the xa_lock held, followed by taking the lock
-and calling xas_split().
+and calling xas_split() or calling xas_try_split() with xa_lock. The
+difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
+that xas_split_alloc() + xas_split() split the entry from the original
+order to the new order in one shot uniformly, whereas xas_try_split()
+iteratively splits the entry containing the index non-uniformly.
+For example, to split an order-9 entry, which takes 2^(9-6)=8 slots,
+assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() need
+8 xa_node. xas_try_split() splits the order-9 entry into
+2 order-8 entries, then split one order-8 entry, based on the given index,
+to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 entries.
+When splitting the order-6 entry and a new xa_node is needed, xas_try_split()
+will try to allocate one if possible. As a result, xas_try_split() would only
+need 1 xa_node instead of 8.
 
 Functions and structures
 ========================
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..4010195201c9 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1555,6 +1555,7 @@ int xa_get_order(struct xarray *, unsigned long index);
 int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1576,6 +1577,11 @@ static inline void xas_split_alloc(struct xa_state *xas, void *entry,
 		unsigned int order, gfp_t gfp)
 {
 }
+
+static inline void xas_try_split(struct xa_state *xas, void *entry,
+		unsigned int order)
+{
+}
 #endif
 
 /**
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0e865bab4a10..080a39d22e73 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1858,6 +1858,54 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xa_destroy(xa);
 }
 
+static void check_split_2(struct xarray *xa, unsigned long index,
+				unsigned int order, unsigned int new_order)
+{
+	XA_STATE_ORDER(xas, xa, index, new_order);
+	unsigned int i, found;
+	void *entry;
+
+	xa_store_order(xa, index, order, xa, GFP_KERNEL);
+	xa_set_mark(xa, index, XA_MARK_1);
+
+	/* allocate a node for xas_try_split() */
+	xas_set_err(&xas, -ENOMEM);
+	XA_BUG_ON(xa, !xas_nomem(&xas, GFP_KERNEL));
+
+	xas_lock(&xas);
+	xas_try_split(&xas, xa, order);
+	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
+	    new_order < order - 1) {
+		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) != -EINVAL);
+		xas_unlock(&xas);
+		goto out;
+	}
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	xas_unlock(&xas);
+
+	for (i = 0; i < (1 << order); i++) {
+		unsigned int val = index + (i & ~((1 << new_order) - 1));
+		XA_BUG_ON(xa, xa_load(xa, index + i) != xa_mk_index(val));
+	}
+
+	xa_set_mark(xa, index, XA_MARK_0);
+	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
+
+	xas_set_order(&xas, index, 0);
+	found = 0;
+	rcu_read_lock();
+	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
+		found++;
+		XA_BUG_ON(xa, xa_is_internal(entry));
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, found != 1 << (order - new_order));
+out:
+	xas_destroy(&xas);
+	xa_destroy(xa);
+}
+
 static noinline void check_split(struct xarray *xa)
 {
 	unsigned int order, new_order;
@@ -1869,6 +1917,10 @@ static noinline void check_split(struct xarray *xa)
 			check_split_1(xa, 0, order, new_order);
 			check_split_1(xa, 1UL << order, order, new_order);
 			check_split_1(xa, 3UL << order, order, new_order);
+
+			check_split_2(xa, 0, order, new_order);
+			check_split_2(xa, 1UL << order, order, new_order);
+			check_split_2(xa, 3UL << order, order, new_order);
 		}
 	}
 }
diff --git a/lib/xarray.c b/lib/xarray.c
index 116e9286c64e..bc197c96d171 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1007,6 +1007,26 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
 	}
 }
 
+static void __xas_init_node_for_split(struct xa_state *xas,
+		struct xa_node *node, void *entry)
+{
+	unsigned int i;
+	void *sibling = NULL;
+	unsigned int mask = xas->xa_sibs;
+
+	if (!node)
+		return;
+	node->array = xas->xa;
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		if ((i & mask) == 0) {
+			RCU_INIT_POINTER(node->slots[i], entry);
+			sibling = xa_mk_sibling(i);
+		} else {
+			RCU_INIT_POINTER(node->slots[i], sibling);
+		}
+	}
+}
+
 /**
  * xas_split_alloc() - Allocate memory for splitting an entry.
  * @xas: XArray operation state.
@@ -1025,7 +1045,6 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
-	unsigned int mask = xas->xa_sibs;
 
 	/* XXX: no support for splitting really large entries yet */
 	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
@@ -1034,22 +1053,13 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		return;
 
 	do {
-		unsigned int i;
-		void *sibling = NULL;
 		struct xa_node *node;
 
 		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node)
 			goto nomem;
-		node->array = xas->xa;
-		for (i = 0; i < XA_CHUNK_SIZE; i++) {
-			if ((i & mask) == 0) {
-				RCU_INIT_POINTER(node->slots[i], entry);
-				sibling = xa_mk_sibling(i);
-			} else {
-				RCU_INIT_POINTER(node->slots[i], sibling);
-			}
-		}
+
+		__xas_init_node_for_split(xas, node, entry);
 		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
 		xas->xa_alloc = node;
 	} while (sibs-- > 0);
@@ -1122,6 +1132,103 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 	xas_update(xas, node);
 }
 EXPORT_SYMBOL_GPL(xas_split);
+
+/**
+ * xas_try_split() - Try to split a multi-index entry.
+ * @xas: XArray operation state.
+ * @entry: New entry to store in the array.
+ * @order: Current entry order.
+ *
+ * The size of the new entries is set in @xas.  The value in @entry is
+ * copied to all the replacement entries. If and only if one new xa_node is
+ * needed, the function will use GFP_NOWAIT to get one if xas->xa_alloc is
+ * NULL. If more new xa_node are needed, the function gives EINVAL error.
+ *
+ * Context: Any context.  The caller should hold the xa_lock.
+ */
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order)
+{
+	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	unsigned int offset, marks;
+	struct xa_node *node;
+	void *curr = xas_load(xas);
+	int values = 0;
+	gfp_t gfp = GFP_NOWAIT;
+
+	node = xas->xa_node;
+	if (xas_top(node))
+		return;
+
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+
+	marks = node_get_marks(node, xas->xa_offset);
+
+	offset = xas->xa_offset + sibs;
+
+	if (xas->xa_shift < node->shift) {
+		struct xa_node *child = xas->xa_alloc;
+		unsigned int expected_sibs =
+			(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
+
+		/*
+		 * No support for splitting sibling entries
+		 * (horizontally) or cascade split (vertically), which
+		 * requires two or more new xa_nodes.
+		 * Since if one xa_node allocation fails,
+		 * it is hard to free the prior allocations.
+		 */
+		if (sibs || xas->xa_sibs != expected_sibs) {
+			xas_destroy(xas);
+			xas_set_err(xas, -EINVAL);
+			return;
+		}
+
+		if (!child) {
+			child = kmem_cache_alloc_lru(radix_tree_node_cachep,
+						     xas->xa_lru, gfp);
+			if (!child) {
+				xas_destroy(xas);
+				xas_set_err(xas, -ENOMEM);
+				return;
+			}
+			RCU_INIT_POINTER(child->parent, xas->xa_alloc);
+		}
+		__xas_init_node_for_split(xas, child, entry);
+
+		xas->xa_alloc = rcu_dereference_raw(child->parent);
+		child->shift = node->shift - XA_CHUNK_SHIFT;
+		child->offset = offset;
+		child->count = XA_CHUNK_SIZE;
+		child->nr_values = xa_is_value(entry) ?
+				XA_CHUNK_SIZE : 0;
+		RCU_INIT_POINTER(child->parent, node);
+		node_set_marks(node, offset, child, xas->xa_sibs,
+				marks);
+		rcu_assign_pointer(node->slots[offset],
+				xa_mk_node(child));
+		if (xa_is_value(curr))
+			values--;
+		xas_update(xas, child);
+
+	} else {
+		do {
+			unsigned int canon = offset - xas->xa_sibs;
+
+			node_set_marks(node, canon, NULL, 0, marks);
+			rcu_assign_pointer(node->slots[canon], entry);
+			while (offset > canon)
+				rcu_assign_pointer(node->slots[offset--],
+						xa_mk_sibling(canon));
+			values += (xa_is_value(entry) - xa_is_value(curr)) *
+					(xas->xa_sibs + 1);
+		} while (offset-- > xas->xa_offset);
+	}
+
+	node->nr_values += values;
+	xas_update(xas, node);
+}
+EXPORT_SYMBOL_GPL(xas_try_split);
 #endif
 
 /**
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 8b3591a51e1f..b2a6660bbd92 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -14,6 +14,7 @@ include ../shared/shared.mk
 
 main:	$(OFILES)
 
+xarray.o: ../../../lib/test_xarray.c
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-- 
2.47.2


