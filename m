Return-Path: <linux-kselftest+bounces-39982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA6B37127
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B791BA6FBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABEB2FD7D5;
	Tue, 26 Aug 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQiMIq+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588C2E7F21;
	Tue, 26 Aug 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228737; cv=fail; b=QFbxp0jWlwAxPRbVGANnn4DSSjfdr8FK7Qo994DCpP92KJL7TIJBGcdo1AxLIAZG7HXXBBuNgRCCbmRVH8yPeKSbLhGogVrERP7XMJofVAnlrgYgrmATDU9bR42uI7UZ310Hy7KU/QNIsf2ahCHAJLV6/0JOUJl9t4XpyDLlGzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228737; c=relaxed/simple;
	bh=2KXXlEFot/No/Q42oCduw4v7qH0PrCBQTfpLYB0SWw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUTBuQvJp91YyVTjbk5buQhDhzxuPUNUDGF0cIAGYkmM1mKeoRqy3jokEiyG196RbByuTU5PEhnl0NQ2TQNwGYMCwbD37aAYW6e03jKX0XXuzwhGYkCfr4P+Uw46hGVa9GYnozzxb0U/Ucc2jFcA3q/Yvnhnr3iGu4sGAJhlHsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQiMIq+q; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxBrK3W5Yi8Ybj+ONeqwRcAlEOZDz7jdmwuK/Hq1l0cZHoioRKJut8aI0Pvsky/9Ju9Z3w42kdECp39k+c+lZaU0AnYFtGHOgwH7AsWmRQVw15skFfVzKTtPuPaHSlFoUYpyygI/Z2d4Xpqh1SfJVwwv0G9HK592mGsFIBjEQsTeB6VvvcyYvrnPNTfDBEJttOM9x4hXBz84UDfDBO8gX+Fbi6iNt0JYBicdxO/zPKxAR6UT4hQs4uhB2OYkVK07HcINGGIhBp5KqVoqVZPvTs1LFJemSiJJs2qYC62PrZIvUZw4kALXoSbcZ2m9Hck+aUjC90wTJes8YPWDXb1KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d65esHy3QqvSEyHvZ+khQyxGcs7eK56dcMMwKCd98GY=;
 b=jgf0ss6Urya7hT0EqtJfpXBTISzpSVhL+51NVSmgyyV3RSxFz1HuOnntGKgnqqOSxoLVhqWf730Ul/ehBcaMPiEjfkm8GYJJeDfYZLKYQ+ag9yeA0OXzI0TupFqp2EKEgZT7ShScv/z9eEnAjzIZkfVqgKb8DhuD8G7DZGCvWTKL6jQWAZraXXOOVPqCsvIvAnNT3+Ep7fqOS3mlXX4FiJAG9qosmmDRl/o8osY3ydDj8lXGaWqAmVDRjZeyFc6OvBGrNDV4iUo6xhUNq+FThq2qmCAokI05MsbN1Nm66y5NG6PTnbg5GlK1Day1mM9RYnZxv5QY8+L2EXLFslfPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d65esHy3QqvSEyHvZ+khQyxGcs7eK56dcMMwKCd98GY=;
 b=hQiMIq+qGcBsr5rzPqySix/jY6eFJqc4dODhKzdzkpj0Hvhg0bpcg465V2h6j7L+wdB5RypRyACZYOQroNn4O7VcUBOMTJ62k5yX03hQf7FPMTZYLFP2E0iRfJPP1B9wuZ5YNmmZ4sLC1es8lkkB4qwSraElYDz3X7qquvV3bNGKR/JQV/7dEaZfHOFcqQ270NNrzjyHtd65rGT3urRZKT4xi1c6ymV5ZYjJ9RFYOVrfHCNdqPtDX+9D0GX7zPIgWYBeBi2r9oJYIcaTBvCzFW9wxqa6Nx2/37MPxZGu/prvmnZvviCnD8GKnoYidg6ZDePCSIZwRO3WvtjeLnTCow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:43 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:43 +0000
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
Subject: [PATCH v4 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Tue, 26 Aug 2025 14:18:24 -0300
Message-ID: <3-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e2b699-a093-498a-4256-08dde4c499cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTW3a1vIalmDlh8KywF64ZJUel7Ub+89QHOCSZVM7O6cq0Q+g1gYrOGqt9hs?=
 =?us-ascii?Q?jKonCKEDfYOcA3Nv8OAGw4zVrWnZpYmyUwQUXLtoCT3QbY1NjeGkf341tPee?=
 =?us-ascii?Q?xe28I7zC4wxulggDisSSUloWYjpTFvGRfvo6GIEjIvyF2e0jvhYZsFucOPvx?=
 =?us-ascii?Q?n4Z4oLv5iY1qXZVqtGi32naX7uoFVZ5oxJfTau2YYFAec7kg1T6IaHlPCds2?=
 =?us-ascii?Q?Tt/ZUiEJWwF+ZKCTqzHRDGn7u1m9YT6ejJhDmoyaT8YVjOgLHiIK7npNstD5?=
 =?us-ascii?Q?HE9okG4vhEufTYhIbknWLaxR0h1cmTZC8WdR/fWPAzb24KMmrLHMdm9WDPld?=
 =?us-ascii?Q?KylgF/F9om2AfaJwTAricQAthFoCuaE3h6SLWpY6p1X14RwdObofA+MVQzRe?=
 =?us-ascii?Q?nweBvyZ1zrecuKOVwO/7rume9B1vcpSfkPIrckMJImK1lzFlPJtTkcU13Zmx?=
 =?us-ascii?Q?Aq88wU1q3ZjQIH/4fWPA+Lu/i4Py+/qDJ54oxnd5ds9UwiTSxWiObdINoc4y?=
 =?us-ascii?Q?7A1h4nlh+cqHdtvGqueXdSaRiFjthZBHV+r781sV1cfGLNrCOKYW5zV3vJLI?=
 =?us-ascii?Q?/4UFxrtG8k362PYJ8kuntBSVu81vhtT68Url5zbi3SMiKBlDDEfEcHBGVOPn?=
 =?us-ascii?Q?cIF4wLHQCsl0of93m8LAt38zgjeuw5cvr0nLCzSI5BAhoCkp+XVZBdJxh2sl?=
 =?us-ascii?Q?ECOM2OC99a7rjm5i+VsxEKvY1W9OIaPYib9vvEQs2+a2t0/mBJYb8A7uGt/n?=
 =?us-ascii?Q?XLdQeY8iLwM8k0Bf/0SVv8Bnsv0poXwBKvZ9YsOlI/I6jfomQfxPmrZSvcpe?=
 =?us-ascii?Q?soqiaBIPIoCPCmgloUx5dq8/USVEld10Wke1hdr9ADewNH1bNxYZkg7zDI/4?=
 =?us-ascii?Q?h4j5NcKC0ZdKqIb9NE1pLw7aAUcjgGVH559XDQWcEZ6tttRC5NOTBwgsIpws?=
 =?us-ascii?Q?F0jOSnk9se5qv6n/WD11H+kuL/3WxIiPjtzFi75w1VrwEvmqozAIMY5DsZBG?=
 =?us-ascii?Q?TR1I5T+mC5/PwoDkqXWAzJOh9xp42/uXKM3du0xkyxxDMJ0dkvGbyk+9U++H?=
 =?us-ascii?Q?HRNDXat99L3NP6e1hhvE12vdWvfxbPSWD4A7P25gLnIu5LPUBKoS2h1Jg1Or?=
 =?us-ascii?Q?KU9LZl8Jk87s8rImLRopLRu8asUnxvxYOaL0dzcXQizjXwI6yabcfH6Vnr2X?=
 =?us-ascii?Q?Sl8NZUmwN1ytlJt52vFgIWBnNjsifN+K3doDrOmrSRixo/oViFNI/OKGkYko?=
 =?us-ascii?Q?2ZOa0s4SnZ/B2m1P3ihedhOy68aifqfn3XtPaTwc5CxBTMJeFNeC6z9kMR4T?=
 =?us-ascii?Q?mgYOtPqvkzzOxA92vyA9KPSZYPrkg4LBf+Jmv9FL3sdG4K+vtjn7F8GdaVB5?=
 =?us-ascii?Q?nDuakybotYuwQnyMg2pMrrjNlUi/9HRnn94Me3GpxOyaYjrs7cZ5P8oj69XP?=
 =?us-ascii?Q?3iLaeb61UDFLqIC1iBRV+w5aRxmfuc0c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTABIZbbp0ayZpPl81ssS7GH9CxHoDSAt1tVWRHJl/DbfUQfFvjCN+9t25LT?=
 =?us-ascii?Q?je9ZDzD+lUDs86L7JTh84ZtuJcFrq08PMQwvnILjzJMW+DKx4Cdz6seZJHXM?=
 =?us-ascii?Q?qAbCEktJMeDqWViwzuB+rWKraptpSTwsMY4J7POJ59JTcy7cpc2yN6p5Xhx2?=
 =?us-ascii?Q?2j8ALpj0IAlM3oJWywtq+CHncsASWvpGerjQ2296k2LZW1/Esf7aBCNpUniF?=
 =?us-ascii?Q?WnGDuKf20/UjO6hpYiRJ6rcdXRYHiqir7yW72Ew0WIEBRkKHq7UuA+Es9fTe?=
 =?us-ascii?Q?ISzBoZXpxmTWLGWrIGbpL/kASkS0/Uyy8vBdXnDvSSwtdLlmwIi1E+4ObZfm?=
 =?us-ascii?Q?NcKVchpSgGSY2wb678Ju6P7zbKoP/lfkHBC29NZqPDvRZ/Pm24Rs6qw949K9?=
 =?us-ascii?Q?yoQqOCJrB5nOYZyAUg7Ki2qZkNwmmz3qj2bATDodO4+vWLpwiU6MB+MsfRf8?=
 =?us-ascii?Q?bNiNrnk1m2XOr00H+1ZY3DP4dTZnW3hXJZgs1kipUd0nnYDRnI3MHdA2RKCz?=
 =?us-ascii?Q?bEfeC35gwd8eg8YClCR2i4/SlFdTzDhPRknmDnsKWE1bGmTAKyWLe6gmcO1A?=
 =?us-ascii?Q?Qp/hQDjPgq/QSJdZDiEaVYBUJY+jrfDfBNeaXlxJctjuYhCMJc+yNBaq8o+C?=
 =?us-ascii?Q?Hx3GSeWLRIdfdtlNM07QUabW0P+HjdVnVDDb248vtSCYeqHdcFq7pvXpl+YD?=
 =?us-ascii?Q?wSwyUV38W9o12M+qDFyloP6hyjoQo7djaHU1hgLfZdWnSG58qb66ivpUYH3c?=
 =?us-ascii?Q?LKVyNiPm7xtaBvvofRV2IsU61qBga7omXw3AWh60koLV0+7aAHeLX0B6t8qB?=
 =?us-ascii?Q?hPoeGkaaqGfr01xudcutq4e6NgNlUkXg6v37ya7e052yuLfmsCGFMfRVQf7f?=
 =?us-ascii?Q?Lh0R0bVztCJ/C9LZgh/awgwHTdwpLR5PWCtCCimBrI/PjDC6GdBHYPifGlV+?=
 =?us-ascii?Q?ZhJQA3cJbA7ZyoBXJpIJrPRt1gh8X40/BwXCzWg+Z6oURJn/b5TKVe+2apEF?=
 =?us-ascii?Q?ziW6/I999nZNJaqrKw7sdAUEx6IRxDsv+C3IhASie6L7e43BCdUg/4969xLQ?=
 =?us-ascii?Q?c9r1YV7z8NjckTvn7WHZrs7+zWtYMjMbF3zccRBxeUw5UJYpmZYHB19o+do5?=
 =?us-ascii?Q?aaIegxcBkl6jtuCG/3ckODm1lmbCkXSzIWxj2x/qDPSDYmEHvVz1w4u/sFFc?=
 =?us-ascii?Q?u1z+m2fq4O2S75FXXAAhSxipUKFSh+E+ymyQBX9aBzI23TkV9Igp0y20bxmF?=
 =?us-ascii?Q?T2wJshirYVDIeWi4/AcgqbJTEwb+OHlwKpJMQY03c/PZB+7X/QJKQtC+13yW?=
 =?us-ascii?Q?aAqJmNN+Pwx4S44lQvgpp4mOhNW4kxKwb6JmdtocGuColQi9R3IeG2ULzwB3?=
 =?us-ascii?Q?8rQoZKt5PipKr9xK4H4iRsnDaQNcBnwAf0mMnUkb3g6yWXQXXnVVH18YvFkz?=
 =?us-ascii?Q?0931LrwMKZ9Ec7vTD4ZwuyFN7i17GFqYm/7Oa5nxjLTfpRlEkpT0WiaRf5T4?=
 =?us-ascii?Q?1SbsdebqsB5fOgzhO59EZ5XXWGHs+QGp9B9ypwUMOydgtFb857S1gqZs+cTr?=
 =?us-ascii?Q?vT0v4tA8ldDVQzFxF2xhqzFsqYuoHy+bMXekd+AB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e2b699-a093-498a-4256-08dde4c499cf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:40.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2gtawO1OmQWcIymIDARp3BoowLyXDifMX1NzkxOxXvzq0v6VTOk0u/ym78cb9Dp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

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

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  12 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 264 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 118 ++++++++
 4 files changed, 433 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index fb0f431ddba0a8..c35ddc7c827e92 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -17,4 +17,16 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
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
index 00000000000000..03e1f3daa7a2ef
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,264 @@
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
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va)
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
+	domain->geometry.force_aperture = true;
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
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+
+	/* Must be last, see pt_iommu_deinit() */
+	iommu_table->ops = &NS(ops);
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
index 00000000000000..9d2152bc64c0d6
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,118 @@
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
+	/*
+	 * It is safe to call pt_iommu_deinit() before an init, or if init
+	 * fails. The ops pointer will only become non-NUL if deinit needs to be
+	 * run.
+	 */
+	if (iommu_table->ops)
+		iommu_table->ops->deinit(iommu_table);
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


