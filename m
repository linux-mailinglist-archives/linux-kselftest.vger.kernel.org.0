Return-Path: <linux-kselftest+bounces-39988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CACB37133
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931238E4778
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EF2E371F;
	Tue, 26 Aug 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PBGE6QnN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D172E54B2;
	Tue, 26 Aug 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228743; cv=fail; b=uoQquJJLnZOt4AZMfBOanwjDGVDg1oYdQm3jQQplEZsPqOa5XECzYcEwnSZl2DYTJ/T1xCTOEqs+M+6SJMnSaAjqGyplMycAc9Zl+QXRUVDt806jy2aiLlLX6ns3Yxv/n3B5+qzqXP1G3m0Bcnigi7o6TKANWeB4B20OQvTNgVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228743; c=relaxed/simple;
	bh=vmcIgeO7nYh/xa+2RO9DJBAeWex3kv0S4xlbB1Ba+xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tY5s+5tBPSd7gkNWy0VOgPkZTxohWY1/RXLXWZBENBKrznUXpq2mNcjQYnEpS2q1x4NmfJLyCdfiosjN8EkzGYoUYb8GT54oDpDntSLEwJ58+Ga3cN0QchULLE3TVOZ+WAIv/YkavJrYaXWERROFaHX2I/FMIDKulzDlJ39lYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PBGE6QnN; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDwkDGy72HJ8Z1dfFq0e9sWvJSAx4UF2MbsizIgxn0p53vU1h2wpbwBtt8Wxp330QU9vE+Uf/UCtVpP4y7hZIa8puK5FiMXv1j7OHgticFjraIirx7XoYj4TKPKIcqJtXnSLhu6jq3f6D8ubSfcb5NqodaZjAuI0cEEHfmbAjrZDwblsJjDAe8+CnbkUho7LeCSAtAHihQ04UPyDydF5camJJm194w6GN965zcDdhqWEPAcF5wDhEVvUT+14TkO17aDn/1m5JbBFFU/0xKAD41oiN4bMwTxNz+5CJF9iJ9SM2vTWLOusMMlSDXInjuiIDwGr3N5eZDVDp38dYspimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBZShgO04Jr/NtOnzYuFoOKcw76pMyXm3UGNw32MGoc=;
 b=IkNcoeBGzJzIuGLz+FsR/ohOPwdzoGw/gTzIMn982dYoMExavfRv6fv8aXpUrF4LMInk5LpQTY0vWInq3lNOdt5Rt6ttgijIQH54TuPMqQaoWFueVq5VKniPxp9IL12j1R84hXMixiTUmU6M3N7t7ss1RYRG1xl2jgl6eb9aBqUbiajFPm0jMNmQGUYsFuqCGBZbT5dW3ZvUyYOSvng3/I6RDkEGDoMViIfk51bQt/9LzcBNEqbFPVftcKCNNLcWCG7SWNa1q7MxxR3ZZhbzHw8VaN93rnzcZTgQJymb1mIV23ZFEUS6gkJhEpU5/Los/Aer4U0hxUxVsh+bs1TEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBZShgO04Jr/NtOnzYuFoOKcw76pMyXm3UGNw32MGoc=;
 b=PBGE6QnNahrT0jB8pT74z9vAPKrY81C86eaEsjRVprDsl5NVC+MlV8qSHFjVaAKemnDMKlD0EEFepY4UjymxYfxCgP/gZcRMzRz+CZx0fpgQQ4epQpbcs1V+m8DoMQ4JnCmjpABTSwrWGglChaQnQW/zzpCjEABnqIzpkEdYMwHcP7kShVmjPY4nAJNW9MB0ycoEDkNEpiEq8yrKcaG1AL81orlNB2J+6jzscf7DWiJydrO4qMMx2/aNbJV+synrU0IM5b8C3SOZtE0+EhweL+EjIzXtuytHbWQPp2iDeNaBTGktD8WAVt/URfh9AXCI7q25Az6B3pcpdtg05YCnyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:44 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:44 +0000
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
Subject: [PATCH v4 01/15] genpt: Generic Page Table base API
Date: Tue, 26 Aug 2025 14:18:22 -0300
Message-ID: <1-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 590eab59-44fe-4164-f0b3-08dde4c49a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p20V10602/D1s3+8Y+yVXtE/lsW+B7PFf0Ddsg673udWM5LLUUss52IPISRg?=
 =?us-ascii?Q?E9Qzv9YuDpPRpEhTGN+9EOR7N45VJJ5HM0ZrS16SL1F3Kf0cdxZPYzPeaGK6?=
 =?us-ascii?Q?f+5LzUUf+RoBcG3zHkfBAQhd4Q5BzJvx8TUShbjwhjizkUR5hje1Xi3VrfWg?=
 =?us-ascii?Q?ZzcCtcu6gC76TsAYp5rRHKxp94ue1rLFEW7mbaHLTltrO/MjVEPPp0fgeAvY?=
 =?us-ascii?Q?5jDHpJjlB19w5QtxuxyNJ4SWerUfM5UyQNZ3/TUJSgorJWRJ+jJ4WOxD17gc?=
 =?us-ascii?Q?bY/QsLwG+mJ9GQC3amLoIUuDcaJe0QxGzMRS0zW3HMfo8zR1W6iFtZweBUxM?=
 =?us-ascii?Q?MsbEhLSw9xqaGv+LKHv6iHUX8S3pgsshrxBT6BhiXSszetUC8nuxqeG3z2QG?=
 =?us-ascii?Q?is3gfzgReHjxnP3cGWvF9uai+4NXmT0hlDbTth2IXa3yV2QVtZA7vksTdsca?=
 =?us-ascii?Q?wE0QYbjZ6iCVWtri6tpiTi0o8ptkqGp1NOVQTr0k7vpWJ6pYGTTczPp8xNGt?=
 =?us-ascii?Q?jomlNn5d0KWYOnq8MtKkofULPIRO8eVWJx1sjIdrfkLZa9ztQfwirzjhD1FS?=
 =?us-ascii?Q?Rb0DXiYhdu6hUA+vuX06/n46OOEFPG3EirpVy+g4tIYo/esnEmXjqMpIJsF6?=
 =?us-ascii?Q?VwhSwXKMyP9SX6gTm7kE6imaE4rXKj2tW1sykm4bvz9GFV3dZrMCBzEn1M5I?=
 =?us-ascii?Q?d1tPALA/zcup0R/Appsl3fIjn1etfDINorpsQwptV2KNvDfRYmEyTVkl0Cro?=
 =?us-ascii?Q?GoqPpE7egI1+gRYKSAqEjB/9/2aQZi7KyH3Tb0XOUkXVjQgYdv8L+repD0Dg?=
 =?us-ascii?Q?1Jfh7li01K9nfO4johT/CSvhq0ZRhV4AKz1aCjwu9P3kNHjVThMnOkR5nDop?=
 =?us-ascii?Q?aYs92SShGmWY/wOo/vl4n2nt3R2KJBeZ5pS+fl0lloQx4h6RDjo+ric/bpka?=
 =?us-ascii?Q?4t/PK0d9rEWoGQs+pAztXJj+YjQTpI+IfFH+bQL6MruNG04cotpdNHEM7SP1?=
 =?us-ascii?Q?YSGqra/IUS/QVm54cbhTeSAQ7J2H2IqwXsouuu9e9/U7ZblbsljaaOT6pcgi?=
 =?us-ascii?Q?5Lc4J1BT2Q/T6YhjkWp3xzcs/P6+KYVWqsVU2Aouda8UPjmKEuY/CQKwQnEl?=
 =?us-ascii?Q?6vIzMQXD2VPxtEVmKgbFxN1d08tnQ8D+D5SsXP1vTbUgX/V0N/O1KS/tFSxb?=
 =?us-ascii?Q?VR1flkJsesF9Kx40iGZuAxJxuP8II3IVloeQ4fbmD7mUC/h8AI3dvOiM7GBT?=
 =?us-ascii?Q?+hvuaGlQ37qVWKy/W44nLkPzFpahLheZMITQafBBZqNxik4o5j0wB7jjj2ic?=
 =?us-ascii?Q?iDaafwmNAUkCKeoKLouODYQGlUO2Yi5wSs6bVa0mfUOjWMQiii17bwY3FjhU?=
 =?us-ascii?Q?LhOlWxEwqnDgajmih5WoZLhAtm04+v9SEcUOoDCnHXqVJsUsd8qrr18wFJ8I?=
 =?us-ascii?Q?MFLgGkrLX84XqVZA+GM0WXWb3srzLBzpGvHDcNvIOz1LswVW13czRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z6gerLAKBBIJc0WVFiSxTi7mXmqcd49htT56dzJOZcUco7O/EK9GKF5dcQUr?=
 =?us-ascii?Q?JbdWrE1MV/+jKXgiolR87RbTuY2RdOOY1c8hjvWgdVtoKGYHtsu4MGm8lNMo?=
 =?us-ascii?Q?nfrSsasJ6jeD3zpYU8E3EuhPGkpodEzERePWdrl6mJzu0P44VNEiYHon1etc?=
 =?us-ascii?Q?Y+MYWJtuvqoh2jp04G4SHOYaNer/hbaP6Vq4HGsyX98DcW2EY3wfceHYZgEc?=
 =?us-ascii?Q?eLbNErjXXSQhPOrhBNU6RGVOWa4Vy2tq4Xxo+jWK1XWkNKEWefunZEEXmvfw?=
 =?us-ascii?Q?d/rn0xsvj1A1xhKMu2zu8/yg5oYMmNV4i+Z31KErU/hJZcGu36o5rcT8tp1M?=
 =?us-ascii?Q?SepQWZh7LswQKb2VIt2dikNgcgguWRMXEWQjYbOdHFSVJEXZy8T5przYDznC?=
 =?us-ascii?Q?JyrdUBhXOK0mEkW/N1xINx950x4W2KPJWCq5IP6ZitKDENYJQ5eelLlPiwaV?=
 =?us-ascii?Q?VTmZwupCNRvBj8CC6FohTpJw6Zhp9G+1intzIn9g0hSx1mNiMTgPAra4dtmj?=
 =?us-ascii?Q?PiyegEuK9DT0MdDPnkRgQNUf4xgiQKFJ3xNAgJprdo35J4EIjS/+R1b7nuzT?=
 =?us-ascii?Q?2c8YcurLG4u3oT27bGPTiTZQJ7+YaDXDr5SPfI2KaexPqsNhXb/1pHdMutiP?=
 =?us-ascii?Q?482kzxk1DId+BguPf51SRwtBnYdbFewkrizb/EOv5YCPyZji4nheWyApXwI4?=
 =?us-ascii?Q?heRT/BVa9NoeiVx258v6qiuOuG6nYLc8g7DcZrCW4jvhjj3E6M7NBUQX8DQ4?=
 =?us-ascii?Q?XN01xpyg3Q8+l1Rp5yZe+Zi8C+z8V6LQj74T3GuCUQUFhHjb2Eqc9jkoBYqg?=
 =?us-ascii?Q?47iL9IZBNZDA6HE81Ko924uq3kUv5mAiRnl+tYQ4Rwd+7c7ip0/xdwjozjHx?=
 =?us-ascii?Q?4Z7d3spzcpWw6Sre6z/hQvac+cNe+fAfRT7qMtDRNvGyQOTekWdjjMon0v9m?=
 =?us-ascii?Q?LhmQ0lzFJxP3zKrqcZLpQTtNk2ZSrIEavjMgoXfjzXB8d0V+R+vlITIMZqzK?=
 =?us-ascii?Q?7RNs7GaGaWC/Eph3H4v6brSj+kYl4NKRctimIK4ULWtLdqsCjpXSqS+SbTDZ?=
 =?us-ascii?Q?C2OAyPXTjJBBP6adyE2oPSvsNc9gCW3CU5c6xDoZju2y05Dh9Nw2ogNk5Pdx?=
 =?us-ascii?Q?YzXzcrSmcqGQsp9uXzqs5eXFzV2GVlxoiNyzFzX/BPyO+P4UHrpW27LH8HMg?=
 =?us-ascii?Q?DBrz+WuWCdqUVZ15rBM5s7Z3WCE6j77u4ahQ/6m/lvPx6oABl/L4hlkVAiPm?=
 =?us-ascii?Q?vUO3sKXWX40A4M3Rg5uekoM6yWcOMtPngzi9WfVPXU2wku/T9EFdLD82hjnv?=
 =?us-ascii?Q?KmduCLv7cL7zYM28miMRmOhMl1sS29bBqRYmXfXHDs4NYPtWkdTjJUDoQcAQ?=
 =?us-ascii?Q?TQvdgF6XO0wavddVZIjRpnSL2F0XUuoKm/e8+BT1eHhVRyK7ySFTm6SL7Zjr?=
 =?us-ascii?Q?3jW06VFWEG3+hwL5snHcMcY7C7QOXm/paD/hCzYt1m/0t3JMAEFe1Xc3mxQc?=
 =?us-ascii?Q?vzwh9u/ApwxkQYXjb1BjVH+pOaW4JLWxVfXJt6RM/oaI5+0EwajV1Q32W6W5?=
 =?us-ascii?Q?HewgTBbTA5nbkaV8aOc9+Z12IZ4BHkOwegE22ayw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590eab59-44fe-4164-f0b3-08dde4c49a96
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:41.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvhs7ve5JpaW2jspGzZnmt4vCkJNKqNbbPaDKxeMRFujiafwAHsYfuYkEfpJXnqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

The generic API is intended to be separated from the implementation of
page table algorithms. It contains only accessors for walking and
manipulating the table and helpers that are useful for building an
implementation. Memory management is not in the generic API, but part of
the implementation.

Using a multi-compilation approach the implementation module would include
headers in this order:

  common.h
  defs_FMT.h
  pt_defs.h
  FMT.h
  pt_common.h
  IMPLEMENTATION.h

Where each compilation unit would have a combination of FMT and
IMPLEMENTATION to produce a per-format per-implementation module.

The API is designed so that the format headers have minimal logic, and
default implementations are provided if the format doesn't include one.

Generally formats provide their code via an inline function using the
pattern:

  static inline FMTpt_XX(..) {}
  #define pt_XX FMTpt_XX

The common code then enforces a function signature so that there is no
drift in function arguments, or accidental polymorphic functions (as has
been slightly troublesome in mm). Use of function-like #defines are
avoided in the format even though many of the functions are small enough.

Provide kdocs for the API surface.

This is enough to implement the 8 initial format variations with all of
their features:
 * Entries comprised of contiguous blocks of IO PTEs for larger page
   sizes (AMDv1, ARMv8)
 * Multi-level tables, up to 6 levels. Runtime selected top level
 * Runtime variable table level size (ARM's concatenated tables)
 * Expandable top level (AMDv1)
 * Optional leaf entries at any level
 * 32 bit/64 bit virtual and output addresses, using every bit
 * Sign extended addressing (x86)
 * Dirty tracking

A basic simple format takes about 200 lines to declare the require inline
functions.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format                              |   1 +
 drivers/iommu/Kconfig                      |   2 +
 drivers/iommu/generic_pt/Kconfig           |  20 +
 drivers/iommu/generic_pt/pt_common.h       | 354 ++++++++++++
 drivers/iommu/generic_pt/pt_defs.h         | 323 +++++++++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h | 193 +++++++
 drivers/iommu/generic_pt/pt_iter.h         | 636 +++++++++++++++++++++
 drivers/iommu/generic_pt/pt_log2.h         | 130 +++++
 include/linux/generic_pt/common.h          | 134 +++++
 9 files changed, 1793 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/Kconfig
 create mode 100644 drivers/iommu/generic_pt/pt_common.h
 create mode 100644 drivers/iommu/generic_pt/pt_defs.h
 create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
 create mode 100644 drivers/iommu/generic_pt/pt_iter.h
 create mode 100644 drivers/iommu/generic_pt/pt_log2.h
 create mode 100644 include/linux/generic_pt/common.h

diff --git a/.clang-format b/.clang-format
index 48405c54ef271e..43fd61dd2e2092 100644
--- a/.clang-format
+++ b/.clang-format
@@ -416,6 +416,7 @@ ForEachMacros:
   - 'for_each_prop_dlc_cpus'
   - 'for_each_prop_dlc_platforms'
   - 'for_each_property_of_node'
+  - 'for_each_pt_level_entry'
   - 'for_each_rdt_resource'
   - 'for_each_reg'
   - 'for_each_reg_filtered'
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d85196..c9ae3221cd6f50 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -384,3 +384,5 @@ config SPRD_IOMMU
 	  Say Y here if you want to use the multimedia devices listed above.
 
 endif # IOMMU_SUPPORT
+
+source "drivers/iommu/generic_pt/Kconfig"
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
new file mode 100644
index 00000000000000..fb0f431ddba0a8
--- /dev/null
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menuconfig GENERIC_PT
+	bool "Generic Radix Page Table"
+	help
+	  Generic library for building radix tree page tables.
+
+	  Generic PT provides a set of HW page table formats and a common
+	  set of APIs to work with them.
+
+if GENERIC_PT
+config DEBUG_GENERIC_PT
+	bool "Extra debugging checks for GENERIC_PT"
+	help
+	  Enable extra run time debugging checks for GENERIC_PT code. This
+	  incurs a runtime cost and should not be enabled for production
+	  kernels.
+
+	  The kunit tests require this to be enabled to get full coverage.
+endif
diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
new file mode 100644
index 00000000000000..5ed06104d38b45
--- /dev/null
+++ b/drivers/iommu/generic_pt/pt_common.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * This header is included after the format. It contains definitions
+ * that build on the format definitions to create the basic format API.
+ *
+ * The format API is listed here, with kdocs, in alphabetical order. The
+ * functions without bodies are implemented in the format using the pattern:
+ *     static inline FMTpt_XXX(..) {..}
+ *     #define pt_XXX FMTpt_XXX
+ *
+ * The routines marked "@pts: Entry to query" operate on the entire contiguous
+ * entry and can be called with a pts->index pointing to any sub item that makes
+ * up that entry.
+ *
+ * The header order is:
+ *  pt_defs.h
+ *  fmt_XX.h
+ *  pt_common.h
+ */
+#ifndef __GENERIC_PT_PT_COMMON_H
+#define __GENERIC_PT_PT_COMMON_H
+
+#include "pt_defs.h"
+#include "pt_fmt_defaults.h"
+
+/**
+ * pt_attr_from_entry() - Convert the permission bits back to attrs
+ * @pts: Entry to convert from
+ * @attrs: Resulting attrs
+ *
+ * Fill in the attrs with the permission bits encoded in the current leaf entry.
+ * The attrs should be usable with pt_install_leaf_entry() to reconstruct the
+ * same entry.
+ */
+static inline void pt_attr_from_entry(const struct pt_state *pts,
+				      struct pt_write_attrs *attrs);
+
+/**
+ * pt_can_have_leaf() - True if the current level can have an OA entry
+ * @pts: The current level
+ *
+ * True if the current level can support pt_install_leaf_entry(). A leaf
+ * entry produce an OA.
+ */
+static inline bool pt_can_have_leaf(const struct pt_state *pts);
+
+/**
+ * pt_can_have_table() - True if the current level can have a lower table
+ * @pts: The current level
+ *
+ * Every level except 0 is allowed to have a lower table.
+ */
+static inline bool pt_can_have_table(const struct pt_state *pts)
+{
+	/* No further tables at level 0 */
+	return pts->level > 0;
+}
+
+/**
+ * pt_clear_entry() - Make entries empty (non-present)
+ * @pts: Starting table index
+ * @num_contig_lg2: Number of contiguous items to clear
+ *
+ * Clear a run of entries. A cleared entry will load back as PT_ENTRY_EMPTY
+ * and does not have any effect on table walking. The starting index must be
+ * aligned to num_contig_lg2.
+ */
+static inline void pt_clear_entry(struct pt_state *pts,
+				  unsigned int num_contig_lg2);
+
+/**
+ * pt_entry_make_write_dirty() - Make an entry dirty
+ * @pts: Table index to change
+ *
+ * Make pt_entry_write_is_dirty() return true for this entry. This can be called
+ * asynchronously with any other table manipulation under a RCU lock and must
+ * not corrupt the table.
+ */
+static inline bool pt_entry_make_write_dirty(struct pt_state *pts);
+
+/**
+ * pt_dirty_supported() - True if the page table supports dirty tracking
+ * @common: Page table to query
+ */
+static inline bool pt_dirty_supported(struct pt_common *common);
+
+/**
+ * pt_entry_num_contig_lg2() - Number of contiguous items for this leaf entry
+ * @pts: Entry to query
+ *
+ * Returns the number of contiguous items this leaf entry spans. If the entry is
+ * single item it returns ilog2(1).
+ */
+static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state *pts);
+
+/**
+ * pt_entry_oa() - Output Address for this leaf entry
+ * @pts: Entry to query
+ *
+ * Return the output address for the start of the entry. If the entry
+ * is contigous this returns the same value for each sub-item. Ie::
+ *
+ *    log2_mod(pt_entry_oa(), pt_entry_oa_lg2sz()) == 0
+ *
+ * See pt_item_oa(). The format should implement one of these two functions
+ * depending on how it stores the OA's in the table.
+ */
+static inline pt_oaddr_t pt_entry_oa(const struct pt_state *pts);
+
+/**
+ * pt_entry_oa_lg2sz() - Return the size of a OA entry
+ * @pts: Entry to query
+ *
+ * If the entry is not contigous this returns pt_table_item_lg2sz(), otherwise
+ * it returns the total VA/OA size of the entire contiguous entry.
+ */
+static inline unsigned int pt_entry_oa_lg2sz(const struct pt_state *pts)
+{
+	return pt_entry_num_contig_lg2(pts) + pt_table_item_lg2sz(pts);
+}
+
+/**
+ * pt_entry_oa_full() - Return the full OA for an entry
+ * @pts: Entry to query
+ *
+ * During iteration the first entry could have a VA with an offset from the
+ * natural start of the entry. Return the true full OA considering the pts's VA
+ * offset.
+ */
+static inline pt_oaddr_t pt_entry_oa_full(const struct pt_state *pts)
+{
+	return _pt_entry_oa_fast(pts) |
+	       log2_mod(pts->range->va, pt_entry_oa_lg2sz(pts));
+}
+
+/**
+ * pt_entry_set_write_clean() - Make the entry write clean
+ * @pts: Table index to change
+ *
+ * Modify the entry so that pt_entry_write_is_dirty() == false. The HW will
+ * eventually be notified of this change via a TLB flush, which is the point
+ * that the HW must become synchronized. Any "write dirty" prior to the TLB
+ * flush can be lost, but once the TLB flush completes all writes must make
+ * their entries write dirty.
+ *
+ * The format should alter the entry in a way that is compatible with any
+ * concurrent update from HW. The entire contiguous entry is changed.
+ */
+static inline void pt_entry_set_write_clean(struct pt_state *pts);
+
+/**
+ * pt_entry_write_is_dirty() - True if the entry has been written to
+ * @pts: Entry to query
+ *
+ * "write dirty" means that the HW has written to the OA translated
+ * by this entry. If the entry is contiguous then the consolidated
+ * "write dirty" for all the items must be returned.
+ */
+static inline bool pt_entry_write_is_dirty(const struct pt_state *pts);
+
+/**
+ * pt_full_va_prefix() - The top bits of the VA
+ * @common: Page table to query
+ *
+ * This is usually 0, but some formats have their VA space going downward from
+ * PT_VADDR_MAX, and will return that instead. This value must always be
+ * adjusted by struct pt_common max_vasz_lg2.
+ */
+static inline pt_vaddr_t pt_full_va_prefix(const struct pt_common *common);
+
+/**
+ * pt_has_system_page() - True if level 0 can install a PAGE_SHIFT entry
+ * @common: Page table to query
+ *
+ * If true the caller use at level 0 pt_install_leaf_entry(PAGE_SHIFT). This is
+ * useful to create optimized paths for common cases of PAGE_SIZE mappings.
+ */
+static inline bool pt_has_system_page(const struct pt_common *common);
+
+/**
+ * pt_install_leaf_entry() - Write a leaf entry to the table
+ * @pts: Table index to change
+ * @oa: Output Address for this leaf
+ * @oasz_lg2: Size in VA for this leaf
+ * @attrs: Attributes to modify the entry
+ *
+ * A leaf OA entry will return PT_ENTRY_OA from pt_load_entry(). It translates
+ * the VA indicated by pts to the given OA.
+ *
+ * For a single item non-contiguous entry oasz_lg2 is pt_table_item_lg2sz().
+ * For contiguous it is pt_table_item_lg2sz() + num_contig_lg2.
+ *
+ * This must not be called if pt_can_have_leaf() == false. Contigous sizes
+ * not indicated by pt_possible_sizes() must not be specified.
+ */
+static inline void pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+					 unsigned int oasz_lg2,
+					 const struct pt_write_attrs *attrs);
+
+/**
+ * pt_install_table() - Write a table entry to the table
+ * @pts: Table index to change
+ * @table_pa: CPU physical address of the lower table's memory
+ * @attrs: Attributes to modify the table index
+ *
+ * A table entry will return PT_ENTRY_TABLE from pt_load_entry(). The table_pa
+ * is the table at pts->level - 1. This is done by cmpxchg so pts must have the
+ * current entry loaded. The pts is updated with the installed entry.
+ *
+ * This must not be called if pt_can_have_table() == false.
+ *
+ * Returns true if the table was installed successfully.
+ */
+static inline bool pt_install_table(struct pt_state *pts, pt_oaddr_t table_pa,
+				    const struct pt_write_attrs *attrs);
+
+/**
+ * pt_item_oa() - Output Address for this leaf item
+ * @pts: Item to query
+ *
+ * Return the output address for this item. If the item is part of a contiguous
+ * entry it returns the value of the OA for this individual sub item.
+ *
+ * See pt_entry_oa(). The format should implement one of these two functions
+ * depending on how it stores the OA's in the table.
+ */
+static inline pt_oaddr_t pt_item_oa(const struct pt_state *pts);
+
+/**
+ * pt_load_entry_raw() - Read from the location pts points at into the pts
+ * @pts: Table index to load
+ *
+ * Return the type of entry that was loaded. pts->entry will be filled in with
+ * the entry's content. See pt_load_entry()
+ */
+static inline enum pt_entry_type pt_load_entry_raw(struct pt_state *pts);
+
+/**
+ * pt_max_output_address_lg2() - Return the maximum OA the table format can hold
+ * @common: Page table to query
+ *
+ * The value oalog2_to_max_int(pt_max_output_address_lg2()) is the MAX for the
+ * OA. This is the absolute maximum address the table can hold. struct pt_common
+ * max_oasz_lg2 sets a lower dynamic maximum based on HW capability.
+ */
+static inline unsigned int
+pt_max_output_address_lg2(const struct pt_common *common);
+
+/**
+ * pt_num_items_lg2() - Return the number of items in this table level
+ * @pts: The current level
+ *
+ * The number of items in a table level defines the number of bits this level
+ * decodes from the VA. This function is not called for the top level,
+ * so it does not need to compute a special value for the top case. The
+ * result for the top is based on pt_common max_vasz_lg2.
+ *
+ * The value is used as part if determining the table indexes via the
+ * equation::
+ *
+ *   log2_mod(log2_div(VA, pt_table_item_lg2sz()), pt_num_items_lg2())
+ */
+static inline unsigned int pt_num_items_lg2(const struct pt_state *pts);
+
+/**
+ * pt_pgsz_lg2_to_level - Return the level that maps the page size
+ * @common: Page table to query
+ * @pgsize_lg2: Log2 page size
+ *
+ * Returns the table level that will map the given page size. The page
+ * size must be part of the pt_possible_sizes() for some level.
+ */
+static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common,
+						unsigned int pgsize_lg2);
+
+/**
+ * pt_possible_sizes() - Return a bitmap of possible output sizes at this level
+ * @pts: The current level
+ *
+ * Each level has a list of possible output sizes that can be installed as
+ * leaf entries. If pt_can_have_leaf() is false returns zero.
+ *
+ * Otherwise the bit in position pt_table_item_lg2sz() should be set indicating
+ * that a non-contigous singe item leaf entry is supported. The following
+ * pt_num_items_lg2() number of bits can be set indicating contiguous entries
+ * are supported. Bit pt_table_item_lg2sz() + pt_num_items_lg2() must not be
+ * set, contiguous entries cannot span the entire table.
+ *
+ * The OR of pt_possible_sizes() of all levels is the typical bitmask of all
+ * supported sizes in the entire table.
+ */
+static inline pt_vaddr_t pt_possible_sizes(const struct pt_state *pts);
+
+/**
+ * pt_table_item_lg2sz() - Size of a single item entry in this table level
+ * @pts: The current level
+ *
+ * The size of the item specifies how much VA and OA a single item occupies.
+ *
+ * See pt_entry_oa_lg2sz() for the same value including the effect of contiguous
+ * entries.
+ */
+static inline unsigned int pt_table_item_lg2sz(const struct pt_state *pts);
+
+/**
+ * pt_table_oa_lg2sz() - Return the VA/OA size of the entire table
+ * @pts: The current level
+ *
+ * Return the size of VA decoded by the entire table level.
+ */
+static inline unsigned int pt_table_oa_lg2sz(const struct pt_state *pts)
+{
+	if (pts->range->top_level == pts->level)
+		return pts->range->max_vasz_lg2;
+	return min_t(unsigned int, pts->range->common->max_vasz_lg2,
+		     pt_num_items_lg2(pts) + pt_table_item_lg2sz(pts));
+}
+
+/**
+ * pt_table_pa() - Return the CPU physical address of the table entry
+ * @pts: Entry to query
+ *
+ * This is only ever called on PT_ENTRY_TABLE entries. Must return the same
+ * value passed to pt_install_table().
+ */
+static inline pt_oaddr_t pt_table_pa(const struct pt_state *pts);
+
+/**
+ * pt_table_ptr() - Return a CPU pointer for a table item
+ * @pts: Entry to query
+ *
+ * Same as pt_table_pa() but returns a CPU pointer.
+ */
+static inline struct pt_table_p *pt_table_ptr(const struct pt_state *pts)
+{
+	return __va(pt_table_pa(pts));
+}
+
+/**
+ * pt_load_entry() - Read from the location pts points at into the pts
+ * @pts: Table index to load
+ *
+ * Set the type of entry that was loaded. pts->entry and pts->table_lower
+ * will be filled in with the entry's content.
+ */
+static inline void pt_load_entry(struct pt_state *pts)
+{
+	pts->type = pt_load_entry_raw(pts);
+	if (pts->type == PT_ENTRY_TABLE)
+		pts->table_lower = pt_table_ptr(pts);
+}
+#endif
diff --git a/drivers/iommu/generic_pt/pt_defs.h b/drivers/iommu/generic_pt/pt_defs.h
new file mode 100644
index 00000000000000..3673566708495d
--- /dev/null
+++ b/drivers/iommu/generic_pt/pt_defs.h
@@ -0,0 +1,323 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * This header is included before the format. It contains definitions
+ * that are required to compile the format. The header order is:
+ *  pt_defs.h
+ *  fmt_XX.h
+ *  pt_common.h
+ */
+#ifndef __GENERIC_PT_DEFS_H
+#define __GENERIC_PT_DEFS_H
+
+#include <linux/generic_pt/common.h>
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/limits.h>
+#include <linux/bug.h>
+#include <linux/kconfig.h>
+#include "pt_log2.h"
+
+/* Header self-compile default defines */
+#ifndef pt_write_attrs
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+#endif
+
+struct pt_table_p;
+
+enum {
+	PT_VADDR_MAX = sizeof(pt_vaddr_t) == 8 ? U64_MAX : U32_MAX,
+	PT_VADDR_MAX_LG2 = sizeof(pt_vaddr_t) == 8 ? 64 : 32,
+	PT_OADDR_MAX = sizeof(pt_oaddr_t) == 8 ? U64_MAX : U32_MAX,
+	PT_OADDR_MAX_LG2 = sizeof(pt_oaddr_t) == 8 ? 64 : 32,
+};
+
+/*
+ * The format instantiation can have features wired off or on to optimize the
+ * code gen. Supported features are just a reflection of what the current set of
+ * kernel users want to use.
+ */
+#ifndef PT_SUPPORTED_FEATURES
+#define PT_SUPPORTED_FEATURES 0
+#endif
+
+/*
+ * When in debug mode we compile all formats with all features. This allows the
+ * kunit to test the full matrix. SIGN_EXTEND can't co-exist with DYNAMIC_TOP or
+ * FULL_VA.
+ */
+#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
+enum {
+	PT_ORIG_SUPPORTED_FEATURES = PT_SUPPORTED_FEATURES,
+	PT_DEBUG_SUPPORTED_FEATURES =
+		UINT_MAX &
+		~((PT_ORIG_SUPPORTED_FEATURES & BIT(PT_FEAT_SIGN_EXTEND)) ?
+			  BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_FULL_VA) :
+			  BIT(PT_FEAT_SIGN_EXTEND)),
+};
+#undef PT_SUPPORTED_FEATURES
+#define PT_SUPPORTED_FEATURES PT_DEBUG_SUPPORTED_FEATURES
+#endif
+
+#ifndef PT_FORCE_ENABLED_FEATURES
+#define PT_FORCE_ENABLED_FEATURES 0
+#endif
+
+/**
+ * DOC: Generic Page Table Language
+ *
+ * Language used in Generic Page Table
+ *  va
+ *     The input address to the page table, often the virtual address.
+ *  oa
+ *     The output address from the page table, often the physical address.
+ *  leaf
+ *     An entry that results in an output address. Ie a physical memory addr
+ *  start/end
+ *     An open range, eg [0,0) refers to no VA.
+ *  start/last
+ *     An inclusive closed range, eg [0,0] refers to the VA 0
+ *  common
+ *     The generic page table container struct pt_common
+ *  level
+ *     The number of table hops from the lowest leaf. Level 0
+ *     is always a table of only leaves of the least significant VA bits. The
+ *     labels used by HW descriptions are never used.
+ *  top_level
+ *     The inclusive highest level of the table. A two level table
+ *     has a top level of 1.
+ *  table
+ *     A linear array of entries representing the translation items for that
+ *     level.
+ *  index
+ *     The position in a table of an element: item = table[index]
+ *  item
+ *     A single position in a table
+ *  entry
+ *     A single logical element in a table. If contiguous pages are not
+ *     supported then item and entry are the same thing, otherwise entry refers
+ *     to the all the items that comprise a single contiguous translation.
+ *  item/entry_size
+ *     The number of bytes of VA the table translates for.
+ *     If the item is a table entry then the next table covers
+ *     this size. If the entry is an output address then the
+ *     full OA is: OA | (VA % entry_size)
+ *  contig_count
+ *     The number of consecutive items fused into a single entry.
+ *     item_size * contig_count is the size of that entry's translation.
+ *  lg2
+ *     Indicates the value is encoded as log2, ie 1<<x is the actual value.
+ *     Normally the compiler is fine to optimize divide and mod with log2 values
+ *     automatically when inlining, however if the values are not constant
+ *     expressions it can't. So we do it by hand, we want to avoid 64 bit
+ *     divmod.
+ */
+
+/* Returned by pt_load_entry() and for_each_pt_level_entry() */
+enum pt_entry_type {
+	PT_ENTRY_EMPTY,
+	PT_ENTRY_TABLE,
+	/* Entry is valid and returns an output address */
+	PT_ENTRY_OA,
+};
+
+struct pt_range {
+	struct pt_common *common;
+	struct pt_table_p *top_table;
+	pt_vaddr_t va;
+	pt_vaddr_t last_va;
+	u8 top_level;
+	u8 max_vasz_lg2;
+};
+
+/*
+ * Similar to xa_state, this records information about an in progress parse at a
+ * single level.
+ */
+struct pt_state {
+	struct pt_range *range;
+	struct pt_table_p *table;
+	struct pt_table_p *table_lower;
+	u64 entry;
+	enum pt_entry_type type;
+	unsigned short index;
+	unsigned short end_index;
+	u8 level;
+};
+
+#define pt_cur_table(pts, type) ((type *)((pts)->table))
+
+/*
+ * Try to install a new table pointer. The locking methodology requires this to
+ * be atomic, multiple threads can race to install a pointer, the losing threads
+ * will fail the atomic and return false. They should free any memory and
+ * reparse the table level again.
+ */
+#if !IS_ENABLED(CONFIG_GENERIC_ATOMIC64)
+static inline bool pt_table_install64(struct pt_state *pts, u64 table_entry)
+{
+	u64 *entryp = pt_cur_table(pts, u64) + pts->index;
+	u64 old_entry = pts->entry;
+	bool ret;
+
+	/*
+	 * Ensure the zero'd table content itself is visible before its PTE can
+	 * be. release is a NOP on !SMP, but the HW is still doing an acquire.
+	 */
+	if (!IS_ENABLED(CONFIG_SMP))
+		dma_wmb();
+	ret = try_cmpxchg64_release(entryp, &old_entry, table_entry);
+	if (ret)
+		pts->entry = table_entry;
+	return ret;
+}
+#endif
+
+static inline bool pt_table_install32(struct pt_state *pts, u32 table_entry)
+{
+	u32 *entryp = pt_cur_table(pts, u32) + pts->index;
+	u32 old_entry = pts->entry;
+	bool ret;
+
+	/*
+	 * Ensure the zero'd table content itself is visible before its PTE can
+	 * be. release is a NOP on !SMP, but the HW is still doing an acquire.
+	 */
+	if (!IS_ENABLED(CONFIG_SMP))
+		dma_wmb();
+	ret = try_cmpxchg_release(entryp, &old_entry, table_entry);
+	if (ret)
+		pts->entry = table_entry;
+	return ret;
+}
+
+#define PT_SUPPORTED_FEATURE(feature_nr) (PT_SUPPORTED_FEATURES & BIT(feature_nr))
+
+static inline bool pt_feature(const struct pt_common *common,
+			      unsigned int feature_nr)
+{
+	if (PT_FORCE_ENABLED_FEATURES & BIT(feature_nr))
+		return true;
+	if (!PT_SUPPORTED_FEATURE(feature_nr))
+		return false;
+	return common->features & BIT(feature_nr);
+}
+
+static inline bool pts_feature(const struct pt_state *pts,
+			       unsigned int feature_nr)
+{
+	return pt_feature(pts->range->common, feature_nr);
+}
+
+/*
+ * PT_WARN_ON is used for invariants that the kunit should be checking can't
+ * happen.
+ */
+#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
+#define PT_WARN_ON WARN_ON
+#else
+static inline bool PT_WARN_ON(bool condition)
+{
+	return false;
+}
+#endif
+
+/* These all work on the VA type */
+#define log2_to_int(a_lg2) log2_to_int_t(pt_vaddr_t, a_lg2)
+#define log2_to_max_int(a_lg2) log2_to_max_int_t(pt_vaddr_t, a_lg2)
+#define log2_div(a, b_lg2) log2_div_t(pt_vaddr_t, a, b_lg2)
+#define log2_div_eq(a, b, c_lg2) log2_div_eq_t(pt_vaddr_t, a, b, c_lg2)
+#define log2_mod(a, b_lg2) log2_mod_t(pt_vaddr_t, a, b_lg2)
+#define log2_mod_eq_max(a, b_lg2) log2_mod_eq_max_t(pt_vaddr_t, a, b_lg2)
+#define log2_set_mod(a, val, b_lg2) log2_set_mod_t(pt_vaddr_t, a, val, b_lg2)
+#define log2_set_mod_max(a, b_lg2) log2_set_mod_max_t(pt_vaddr_t, a, b_lg2)
+#define log2_mul(a, b_lg2) log2_mul_t(pt_vaddr_t, a, b_lg2)
+#define log2_ffs(a) log2_ffs_t(pt_vaddr_t, a)
+#define log2_fls(a) log2_fls_t(pt_vaddr_t, a)
+#define log2_ffz(a) log2_ffz_t(pt_vaddr_t, a)
+
+/*
+ * The full va (fva) versions permit the lg2 value to be == PT_VADDR_MAX_LG2 and
+ * generate a useful defined result. The non fva versions will malfunction at
+ * this extreme.
+ */
+static inline pt_vaddr_t fvalog2_div(pt_vaddr_t a, unsigned int b_lg2)
+{
+	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
+		return 0;
+	return log2_div_t(pt_vaddr_t, a, b_lg2);
+}
+
+static inline pt_vaddr_t fvalog2_mod(pt_vaddr_t a, unsigned int b_lg2)
+{
+	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
+		return a;
+	return log2_mod_t(pt_vaddr_t, a, b_lg2);
+}
+
+static inline bool fvalog2_div_eq(pt_vaddr_t a, pt_vaddr_t b,
+				  unsigned int c_lg2)
+{
+	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && c_lg2 == PT_VADDR_MAX_LG2)
+		return true;
+	return log2_div_eq_t(pt_vaddr_t, a, b, c_lg2);
+}
+
+static inline pt_vaddr_t fvalog2_set_mod(pt_vaddr_t a, pt_vaddr_t val,
+					 unsigned int b_lg2)
+{
+	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
+		return val;
+	return log2_set_mod_t(pt_vaddr_t, a, val, b_lg2);
+}
+
+static inline pt_vaddr_t fvalog2_set_mod_max(pt_vaddr_t a, unsigned int b_lg2)
+{
+	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
+		return PT_VADDR_MAX;
+	return log2_set_mod_max_t(pt_vaddr_t, a, b_lg2);
+}
+
+/* These all work on the OA type */
+#define oalog2_to_int(a_lg2) log2_to_int_t(pt_oaddr_t, a_lg2)
+#define oalog2_to_max_int(a_lg2) log2_to_max_int_t(pt_oaddr_t, a_lg2)
+#define oalog2_div(a, b_lg2) log2_div_t(pt_oaddr_t, a, b_lg2)
+#define oalog2_div_eq(a, b, c_lg2) log2_div_eq_t(pt_oaddr_t, a, b, c_lg2)
+#define oalog2_mod(a, b_lg2) log2_mod_t(pt_oaddr_t, a, b_lg2)
+#define oalog2_mod_eq_max(a, b_lg2) log2_mod_eq_max_t(pt_oaddr_t, a, b_lg2)
+#define oalog2_set_mod(a, val, b_lg2) log2_set_mod_t(pt_oaddr_t, a, val, b_lg2)
+#define oalog2_set_mod_max(a, b_lg2) log2_set_mod_max_t(pt_oaddr_t, a, b_lg2)
+#define oalog2_mul(a, b_lg2) log2_mul_t(pt_oaddr_t, a, b_lg2)
+#define oalog2_ffs(a) log2_ffs_t(pt_oaddr_t, a)
+#define oalog2_fls(a) log2_fls_t(pt_oaddr_t, a)
+#define oalog2_ffz(a) log2_ffz_t(pt_oaddr_t, a)
+
+static inline uintptr_t _pt_top_set(struct pt_table_p *table_mem,
+				    unsigned int top_level)
+{
+	return top_level | (uintptr_t)table_mem;
+}
+
+static inline void pt_top_set(struct pt_common *common,
+			      struct pt_table_p *table_mem,
+			      unsigned int top_level)
+{
+	WRITE_ONCE(common->top_of_table, _pt_top_set(table_mem, top_level));
+}
+
+static inline void pt_top_set_level(struct pt_common *common,
+				    unsigned int top_level)
+{
+	pt_top_set(common, NULL, top_level);
+}
+
+static inline unsigned int pt_top_get_level(const struct pt_common *common)
+{
+	return READ_ONCE(common->top_of_table) % (1 << PT_TOP_LEVEL_BITS);
+}
+
+#endif
diff --git a/drivers/iommu/generic_pt/pt_fmt_defaults.h b/drivers/iommu/generic_pt/pt_fmt_defaults.h
new file mode 100644
index 00000000000000..8738008d024b0b
--- /dev/null
+++ b/drivers/iommu/generic_pt/pt_fmt_defaults.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Default definitions for formats that don't define these functions.
+ */
+#ifndef __GENERIC_PT_PT_FMT_DEFAULTS_H
+#define __GENERIC_PT_PT_FMT_DEFAULTS_H
+
+#include "pt_defs.h"
+#include <linux/log2.h>
+
+/* Header self-compile default defines */
+#ifndef pt_load_entry_raw
+#include "fmt/amdv1.h"
+#endif
+
+/*
+ * The format must provide PT_GRANULE_LG2SZ, PT_TABLEMEM_LG2SZ, and
+ * PT_ITEM_WORD_SIZE. The must be the same at every level excluding the top.
+ */
+#ifndef pt_table_item_lg2sz
+static inline unsigned int pt_table_item_lg2sz(const struct pt_state *pts)
+{
+	return PT_GRANULE_LG2SZ +
+	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE)) * pts->level;
+}
+#endif
+
+#ifndef pt_pgsz_lg2_to_level
+static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common,
+						unsigned int pgsize_lg2)
+{
+	return (pgsize_lg2 - PT_GRANULE_LG2SZ) /
+	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE));
+	return 0;
+}
+#endif
+
+/* If not supplied by the format then contiguous pages are not supported */
+#ifndef pt_entry_num_contig_lg2
+static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state *pts)
+{
+	return ilog2(1);
+}
+
+static inline unsigned short pt_contig_count_lg2(const struct pt_state *pts)
+{
+	return ilog2(1);
+}
+#endif
+
+/* If not supplied by the format then dirty tracking is not supported */
+#ifndef pt_entry_write_is_dirty
+static inline bool pt_entry_write_is_dirty(const struct pt_state *pts)
+{
+	return false;
+}
+
+static inline void pt_entry_set_write_clean(struct pt_state *pts)
+{
+}
+
+static inline bool pt_dirty_supported(struct pt_common *common)
+{
+	return true;
+}
+#else
+/* If not supplied then dirty tracking is always enabled */
+#ifndef pt_dirty_supported
+static inline bool pt_dirty_supported(struct pt_common *common)
+{
+	return true;
+}
+#endif
+#endif
+
+#ifndef pt_entry_make_write_dirty
+static inline bool pt_entry_make_write_dirty(struct pt_state *pts)
+{
+	return false;
+}
+#endif
+
+/*
+ * Format supplies either:
+ *   pt_entry_oa - OA is at the start of a contiguous entry
+ * or
+ *   pt_item_oa  - OA is correct for every item in a contiguous entry
+ *
+ * Build the missing one
+ */
+#ifdef pt_entry_oa
+static inline pt_oaddr_t pt_item_oa(const struct pt_state *pts)
+{
+	return pt_entry_oa(pts) |
+	       log2_mul(pts->index, pt_table_item_lg2sz(pts));
+}
+#define _pt_entry_oa_fast pt_entry_oa
+#endif
+
+#ifdef pt_item_oa
+static inline pt_oaddr_t pt_entry_oa(const struct pt_state *pts)
+{
+	return log2_set_mod(pt_item_oa(pts), 0,
+			    pt_entry_num_contig_lg2(pts) +
+				    pt_table_item_lg2sz(pts));
+}
+#define _pt_entry_oa_fast pt_item_oa
+#endif
+
+/*
+ * If not supplied by the format then use the constant
+ * PT_MAX_OUTPUT_ADDRESS_LG2.
+ */
+#ifndef pt_max_output_address_lg2
+static inline unsigned int
+pt_max_output_address_lg2(const struct pt_common *common)
+{
+	return PT_MAX_OUTPUT_ADDRESS_LG2;
+}
+#endif
+
+#ifndef pt_has_system_page
+static inline bool pt_has_system_page(const struct pt_common *common)
+{
+	return PT_GRANULE_LG2SZ == PAGE_SHIFT;
+}
+#endif
+
+/*
+ * If not supplied by the format then assume only one contiguous size determined
+ * by pt_contig_count_lg2()
+ */
+#ifndef pt_possible_sizes
+static inline unsigned short pt_contig_count_lg2(const struct pt_state *pts);
+
+/* Return a bitmap of possible leaf page sizes at this level */
+static inline pt_vaddr_t pt_possible_sizes(const struct pt_state *pts)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+
+	if (!pt_can_have_leaf(pts))
+		return 0;
+	return log2_to_int(isz_lg2) |
+	       log2_to_int(pt_contig_count_lg2(pts) + isz_lg2);
+}
+#endif
+
+/* If not supplied by the format then use 0. */
+#ifndef pt_full_va_prefix
+static inline pt_vaddr_t pt_full_va_prefix(const struct pt_common *common)
+{
+	return 0;
+}
+#endif
+
+/* If not supplied by the format then zero fill using PT_ITEM_WORD_SIZE */
+#ifndef pt_clear_entry
+static inline void pt_clear_entry64(struct pt_state *pts,
+				    unsigned int num_contig_lg2)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	PT_WARN_ON(log2_mod(pts->index, num_contig_lg2));
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, 0);
+}
+
+static inline void pt_clear_entry32(struct pt_state *pts,
+				    unsigned int num_contig_lg2)
+{
+	u32 *tablep = pt_cur_table(pts, u32) + pts->index;
+	u32 *end = tablep + log2_to_int(num_contig_lg2);
+
+	PT_WARN_ON(log2_mod(pts->index, num_contig_lg2));
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, 0);
+}
+
+static inline void pt_clear_entry(struct pt_state *pts,
+				  unsigned int num_contig_lg2)
+{
+	if (PT_ITEM_WORD_SIZE == sizeof(u32))
+		pt_clear_entry32(pts, num_contig_lg2);
+	else
+		pt_clear_entry64(pts, num_contig_lg2);
+}
+#define pt_clear_entry pt_clear_entry
+#endif
+
+#endif
diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_pt/pt_iter.h
new file mode 100644
index 00000000000000..abbd243f10d879
--- /dev/null
+++ b/drivers/iommu/generic_pt/pt_iter.h
@@ -0,0 +1,636 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Iterators for Generic Page Table
+ */
+#ifndef __GENERIC_PT_PT_ITER_H
+#define __GENERIC_PT_PT_ITER_H
+
+#include "pt_common.h"
+
+#include <linux/errno.h>
+
+/*
+ * Use to mangle symbols so that backtraces and the symbol table are
+ * understandable. Any non-inlined function should get mangled like this.
+ */
+#define NS(fn) CONCATENATE(PTPFX, fn)
+
+/**
+ * pt_check_range() - Validate the range can be iterated
+ * @range: Range to validate
+ *
+ * Check that va and last_va fall within the permitted range of VAs. If the
+ * format is using PT_FEAT_SIGN_EXTEND then this also checks the sign extension
+ * is correct.
+ */
+static inline int pt_check_range(struct pt_range *range)
+{
+	pt_vaddr_t prefix;
+
+	PT_WARN_ON(!range->max_vasz_lg2);
+
+	if (pt_feature(range->common, PT_FEAT_SIGN_EXTEND)) {
+		PT_WARN_ON(range->common->max_vasz_lg2 != range->max_vasz_lg2);
+		prefix = fvalog2_div(range->va, range->max_vasz_lg2 - 1) ?
+				 PT_VADDR_MAX :
+				 0;
+	} else {
+		prefix = pt_full_va_prefix(range->common);
+	}
+
+	if (!fvalog2_div_eq(range->va, prefix, range->max_vasz_lg2) ||
+	    !fvalog2_div_eq(range->last_va, prefix, range->max_vasz_lg2))
+		return -ERANGE;
+	return 0;
+}
+
+/**
+ * pt_index_to_va() - Update range->va to the current pts->index
+ * @pts: Iteration State
+ *
+ * Adjust range->va to match the current index. This is done in a lazy manner
+ * since computing the VA takes several instructions and is rarely required.
+ */
+static inline void pt_index_to_va(struct pt_state *pts)
+{
+	pt_vaddr_t lower_va;
+
+	lower_va = log2_mul(pts->index, pt_table_item_lg2sz(pts));
+	pts->range->va = fvalog2_set_mod(pts->range->va, lower_va,
+					 pt_table_oa_lg2sz(pts));
+}
+
+/*
+ * Add index_count_lg2 number of entries to pts's VA and index. The va will be
+ * adjusted to the end of the contiguous block if it is currently in the middle.
+ */
+static inline void _pt_advance(struct pt_state *pts,
+			       unsigned int index_count_lg2)
+{
+	pts->index = log2_set_mod(pts->index + log2_to_int(index_count_lg2), 0,
+				  index_count_lg2);
+}
+
+/**
+ * pt_item_fully_covered() - Check if the item or entry is entirely contained
+ *                           within pts->range
+ * @pts: Iteration State
+ * @oasz_lg2: The size of the item to check, pt_table_item_lg2sz() or
+ *            pt_entry_oa_lg2sz()
+ *
+ * True if the item is fully enclosed by the pts->range.
+ */
+static inline bool pt_item_fully_covered(const struct pt_state *pts,
+					 unsigned int oasz_lg2)
+{
+	struct pt_range *range = pts->range;
+
+	/* Range begins at the start of the entry */
+	if (log2_mod(pts->range->va, oasz_lg2))
+		return false;
+
+	/* Range ends past the end of the entry */
+	if (!log2_div_eq(range->va, range->last_va, oasz_lg2))
+		return true;
+
+	/* Range ends at the end of the entry */
+	return log2_mod_eq_max(range->last_va, oasz_lg2);
+}
+
+/**
+ * pt_range_to_index() - Starting index for an iteration
+ * @pts: Iteration State
+ *
+ * Return the starting index for the iteration in pts.
+ */
+static inline unsigned int pt_range_to_index(const struct pt_state *pts)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+
+	PT_WARN_ON(pts->level > pts->range->top_level);
+	if (pts->range->top_level == pts->level)
+		return log2_div(fvalog2_mod(pts->range->va,
+					    pts->range->max_vasz_lg2),
+				isz_lg2);
+	return log2_mod(log2_div(pts->range->va, isz_lg2),
+			pt_num_items_lg2(pts));
+}
+
+/**
+ * pt_range_to_end_index() - Ending index iteration
+ * @pts: Iteration State
+ *
+ * Return the last index for the iteration in pts.
+ */
+static inline unsigned int pt_range_to_end_index(const struct pt_state *pts)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	struct pt_range *range = pts->range;
+	unsigned int num_entries_lg2;
+
+	if (range->va == range->last_va)
+		return pts->index + 1;
+
+	if (pts->range->top_level == pts->level)
+		return log2_div(fvalog2_mod(pts->range->last_va,
+					    pts->range->max_vasz_lg2),
+				isz_lg2) +
+		       1;
+
+	num_entries_lg2 = pt_num_items_lg2(pts);
+
+	/* last_va falls within this table */
+	if (log2_div_eq(range->va, range->last_va, num_entries_lg2 + isz_lg2))
+		return log2_mod(log2_div(pts->range->last_va, isz_lg2),
+				num_entries_lg2) +
+		       1;
+
+	return log2_to_int(num_entries_lg2);
+}
+
+static inline void _pt_iter_first(struct pt_state *pts)
+{
+	pts->index = pt_range_to_index(pts);
+	pts->end_index = pt_range_to_end_index(pts);
+	PT_WARN_ON(pts->index > pts->end_index);
+}
+
+static inline bool _pt_iter_load(struct pt_state *pts)
+{
+	if (pts->index >= pts->end_index)
+		return false;
+	pt_load_entry(pts);
+	return true;
+}
+
+/**
+ * pt_next_entry() - Advance pts to the next entry
+ * @pts: Iteration State
+ *
+ * Update pts to go to the next index at this level. If pts is pointing at a
+ * contiguous entry then the index may advance my more than one.
+ */
+static inline void pt_next_entry(struct pt_state *pts)
+{
+	if (pts->type == PT_ENTRY_OA &&
+	    !__builtin_constant_p(pt_entry_num_contig_lg2(pts) == 0))
+		_pt_advance(pts, pt_entry_num_contig_lg2(pts));
+	else
+		pts->index++;
+	pt_index_to_va(pts);
+}
+
+/**
+ * for_each_pt_level_entry() - For loop wrapper over entries in the range
+ * @pts: Iteration State
+ *
+ * This is the basic iteration primitive, it iterates over all the entries in
+ * pts->range that fall within the pts's current table level. Each step does
+ * pt_load_entry(pts).
+ */
+#define for_each_pt_level_entry(pts) \
+	for (_pt_iter_first(pts); _pt_iter_load(pts); pt_next_entry(pts))
+
+/**
+ * pt_load_single_entry() - Version of pt_load_entry() usable within a walker
+ * @pts: Iteration State
+ *
+ * Alternative to for_each_pt_level_entry() if the walker function uses only a
+ * single entry.
+ */
+static inline enum pt_entry_type pt_load_single_entry(struct pt_state *pts)
+{
+	pts->index = pt_range_to_index(pts);
+	pt_load_entry(pts);
+	return pts->type;
+}
+
+static __always_inline struct pt_range _pt_top_range(struct pt_common *common,
+						     uintptr_t top_of_table)
+{
+	struct pt_range range = {
+		.common = common,
+		.top_table =
+			(struct pt_table_p *)(top_of_table &
+					      ~(uintptr_t)PT_TOP_LEVEL_MASK),
+		.top_level = top_of_table % (1 << PT_TOP_LEVEL_BITS),
+	};
+	struct pt_state pts = { .range = &range, .level = range.top_level };
+	unsigned int max_vasz_lg2;
+
+	max_vasz_lg2 = common->max_vasz_lg2;
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
+	    pts.level != PT_MAX_TOP_LEVEL)
+		max_vasz_lg2 = min_t(unsigned int, common->max_vasz_lg2,
+				     pt_num_items_lg2(&pts) +
+					     pt_table_item_lg2sz(&pts));
+
+	/*
+	 * The top range will default to the lower region only with sign extend.
+	 */
+	range.max_vasz_lg2 = max_vasz_lg2;
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND))
+		max_vasz_lg2--;
+
+	range.va = fvalog2_set_mod(pt_full_va_prefix(common), 0, max_vasz_lg2);
+	range.last_va =
+		fvalog2_set_mod_max(pt_full_va_prefix(common), max_vasz_lg2);
+	return range;
+}
+
+/**
+ * pt_top_range() - Return a range that spans part of the top level
+ * @common: Table
+ *
+ * For PT_FEAT_SIGN_EXTEND this will return the lower range, and cover half the
+ * total page table. Otherwise it returns the entire page table.
+ */
+static __always_inline struct pt_range pt_top_range(struct pt_common *common)
+{
+	/*
+	 * The top pointer can change without locking. We capture the value and
+	 * it's level here and are safe to walk it so long as both values are
+	 * captured without tearing.
+	 */
+	return _pt_top_range(common, READ_ONCE(common->top_of_table));
+}
+
+/**
+ * pt_all_range() - Return a range that spans the entire page table
+ * @common: Table
+ *
+ * The returned range spans the whole page table. Due to how PT_FEAT_SIGN_EXTEND
+ * is supported range->va and range->last_va will be incorrect during the
+ * iteration and must not be accessed.
+ */
+static inline struct pt_range pt_all_range(struct pt_common *common)
+{
+	struct pt_range range = pt_top_range(common);
+
+	if (!pt_feature(common, PT_FEAT_SIGN_EXTEND))
+		return range;
+
+	/*
+	 * Pretend the table is linear from 0 without a sign extension. This
+	 * generates the correct indexes for iteration.
+	 */
+	range.last_va = fvalog2_set_mod_max(0, range.max_vasz_lg2);
+	return range;
+}
+
+/**
+ * pt_upper_range() - Return a range that spans part of the top level
+ * @common: Table
+ *
+ * For PT_FEAT_SIGN_EXTEND this will return the upper range, and cover half the
+ * total page table. Otherwise it returns the entire page table.
+ */
+static inline struct pt_range pt_upper_range(struct pt_common *common)
+{
+	struct pt_range range = pt_top_range(common);
+
+	if (!pt_feature(common, PT_FEAT_SIGN_EXTEND))
+		return range;
+
+	range.va = fvalog2_set_mod(PT_VADDR_MAX, 0, range.max_vasz_lg2 - 1);
+	range.last_va = PT_VADDR_MAX;
+	return range;
+}
+
+/**
+ * pt_make_range() - Return a range that spans part of the table
+ * @common: Table
+ * @va: Start address
+ * @last_va: Last address
+ *
+ * The caller must validate the range with pt_check_range() before using it.
+ */
+static __always_inline struct pt_range
+pt_make_range(struct pt_common *common, pt_vaddr_t va, pt_vaddr_t last_va)
+{
+	struct pt_range range =
+		_pt_top_range(common, READ_ONCE(common->top_of_table));
+
+	range.va = va;
+	range.last_va = last_va;
+
+	return range;
+}
+
+/*
+ * Span a slice of the table starting at a lower table level from an active
+ * walk.
+ */
+static __always_inline struct pt_range
+pt_make_child_range(const struct pt_range *parent, pt_vaddr_t va,
+		    pt_vaddr_t last_va)
+{
+	struct pt_range range = *parent;
+
+	range.va = va;
+	range.last_va = last_va;
+
+	PT_WARN_ON(last_va < va);
+	PT_WARN_ON(pt_check_range(&range));
+
+	return range;
+}
+
+/**
+ * pt_init() - Initialize a pt_state on the stack
+ * @range: Range pointer to embed in the state
+ * @level: Table level for the state
+ * @table: Pointer to the table memory at level
+ *
+ * Helper to initialize the on-stack pt_state from walker arguments.
+ */
+static __always_inline struct pt_state
+pt_init(struct pt_range *range, unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = {
+		.range = range,
+		.table = table,
+		.level = level,
+	};
+	return pts;
+}
+
+/**
+ * pt_init_top() - Initialize a pt_state on the stack
+ * @range: Range pointer to embed in the state
+ *
+ * The pt_state points to the top most level.
+ */
+static __always_inline struct pt_state pt_init_top(struct pt_range *range)
+{
+	return pt_init(range, range->top_level, range->top_table);
+}
+
+typedef int (*pt_level_fn_t)(struct pt_range *range, void *arg,
+			     unsigned int level, struct pt_table_p *table);
+
+/**
+ * pt_descend() - Recursively invoke the walker for the lower level
+ * @pts: Iteration State
+ * @arg: Value to pass to the function
+ * @fn: Walker function to call
+ *
+ * pts must point to a table item. Invoke fn as a walker on the table
+ * pts points to.
+ */
+static __always_inline int pt_descend(struct pt_state *pts, void *arg,
+				      pt_level_fn_t fn)
+{
+	int ret;
+
+	if (PT_WARN_ON(!pts->table_lower))
+		return -EINVAL;
+
+	ret = (*fn)(pts->range, arg, pts->level - 1, pts->table_lower);
+	return ret;
+}
+
+/**
+ * pt_walk_range() - Walk over a VA range
+ * @range: Range pointer
+ * @fn: Walker function to call
+ * @arg: Value to pass to the function
+ *
+ * Walk over a VA range. The caller should have done a validity check, at
+ * least calling pt_check_range(), when building range. The walk will
+ * start at the top most table.
+ */
+static __always_inline int pt_walk_range(struct pt_range *range,
+					 pt_level_fn_t fn, void *arg)
+{
+	return fn(range, arg, range->top_level, range->top_table);
+}
+
+/*
+ * pt_walk_descend() - Recursively invoke the walker for a slice of a lower
+ *                     level
+ * @pts: Iteration State
+ * @va: Start address
+ * @last_va: Last address
+ * @fn: Walker function to call
+ * @arg: Value to pass to the function
+ *
+ * With pts pointing at a table item this will descend and over a slice of the
+ * lower table. The caller must ensure that va/last_va are within the table
+ * item. This creates a new walk and does not alter pts or pts->range.
+ */
+static __always_inline int pt_walk_descend(const struct pt_state *pts,
+					   pt_vaddr_t va, pt_vaddr_t last_va,
+					   pt_level_fn_t fn, void *arg)
+{
+	struct pt_range range = pt_make_child_range(pts->range, va, last_va);
+
+	if (PT_WARN_ON(!pt_can_have_table(pts)) ||
+	    PT_WARN_ON(!pts->table_lower))
+		return -EINVAL;
+
+	return fn(&range, arg, pts->level - 1, pts->table_lower);
+}
+
+/*
+ * pt_walk_descend_all() - Recursively invoke the walker for a table item
+ * @pts: Iteration State
+ * @fn: Walker function to call
+ * @arg: Value to pass to the function
+ *
+ * With pts pointing at a table item this will descend and over the entire lower
+ * table. This creates a new walk and does not alter pts or pts->range.
+ */
+static __always_inline int
+pt_walk_descend_all(const struct pt_state *parent_pts, pt_level_fn_t fn,
+		    void *arg)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(parent_pts);
+
+	return pt_walk_descend(parent_pts,
+			       log2_set_mod(parent_pts->range->va, 0, isz_lg2),
+			       log2_set_mod_max(parent_pts->range->va, isz_lg2),
+			       fn, arg);
+}
+
+/**
+ * pt_range_slice() - Return a range that spans indexes
+ * @pts: Iteration State
+ * @start_index: Starting index within pts
+ * @end_index: Ending index within pts
+ *
+ * Create a range than spans an index range of the current table level
+ * pt_state points at.
+ */
+static inline struct pt_range pt_range_slice(const struct pt_state *pts,
+					     unsigned int start_index,
+					     unsigned int end_index)
+{
+	unsigned int table_lg2sz = pt_table_oa_lg2sz(pts);
+	pt_vaddr_t last_va;
+	pt_vaddr_t va;
+
+	va = fvalog2_set_mod(pts->range->va,
+			     log2_mul(start_index, pt_table_item_lg2sz(pts)),
+			     table_lg2sz);
+	last_va = fvalog2_set_mod(
+		pts->range->va,
+		log2_mul(end_index, pt_table_item_lg2sz(pts)) - 1, table_lg2sz);
+	return pt_make_child_range(pts->range, va, last_va);
+}
+
+/**
+ * pt_top_memsize_lg2()
+ * @common: Table
+ * @top_of_table: Top of table value from _pt_top_set()
+ *
+ * Compute the allocation size of the top table. For PT_FEAT_DYNAMIC_TOP this
+ * will compute the top size assuming the table will grow.
+ */
+static inline unsigned int pt_top_memsize_lg2(struct pt_common *common,
+					      uintptr_t top_of_table)
+{
+	struct pt_range range = _pt_top_range(common, top_of_table);
+	struct pt_state pts = pt_init_top(&range);
+	unsigned int num_items_lg2;
+
+	num_items_lg2 = common->max_vasz_lg2 - pt_table_item_lg2sz(&pts);
+	if (range.top_level != PT_MAX_TOP_LEVEL &&
+	    pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		num_items_lg2 = min(num_items_lg2, pt_num_items_lg2(&pts));
+
+	/* Round up the allocation size to the minimum alignment */
+	return max(log2_ffs_t(u64, PT_TOP_PHYS_MASK),
+		   num_items_lg2 + ilog2(PT_ITEM_WORD_SIZE));
+}
+
+/**
+ * pt_compute_best_pgsize() - Determine the best page size for leaf entries
+ * @pgsz_bitmap: Permitted page sizes
+ * @va: Starting virtual address for the leaf entry
+ * @last_va: Last virtual address for the leaf entry, sets the max page size
+ * @oa: Starting output address for the leaf entry
+ *
+ * Compute the largest page size for va, last_va, and oa together and return it
+ * in lg2. The largest page size depends on the format's supported page sizes at
+ * this level, and the relative alignment of the VA and OA addresses. 0 means
+ * the OA cannot be stored with the provided pgsz_bitmap.
+ */
+static inline unsigned int pt_compute_best_pgsize(pt_vaddr_t pgsz_bitmap,
+						  pt_vaddr_t va,
+						  pt_vaddr_t last_va,
+						  pt_oaddr_t oa)
+{
+	unsigned int best_pgsz_lg2;
+	unsigned int pgsz_lg2;
+	pt_vaddr_t len = last_va - va + 1;
+	pt_vaddr_t mask;
+
+	if (PT_WARN_ON(va >= last_va))
+		return 0;
+
+	/*
+	 * Given a VA/OA pair the best page size is the largest page side
+	 * where:
+	 *
+	 * 1) VA and OA start at the page. Bitwise this is the count of least
+	 *    significant 0 bits.
+	 *    This also implies that last_va/oa has the same prefix as va/oa.
+	 */
+	mask = va | oa;
+
+	/*
+	 * 2) The page size is not larger than the last_va (length). Since page
+	 *    sizes are always power of two this can't be larger than the
+	 *    largest power of two factor of the length.
+	 */
+	mask |= log2_to_int(log2_fls(len) - 1);
+
+	best_pgsz_lg2 = log2_ffs(mask);
+
+	/* Choose the higest bit <= best_pgsz_lg2 */
+	if (best_pgsz_lg2 < PT_VADDR_MAX_LG2 - 1)
+		pgsz_bitmap = log2_mod(pgsz_bitmap, best_pgsz_lg2 + 1);
+
+	pgsz_lg2 = log2_fls(pgsz_bitmap);
+	if (!pgsz_lg2)
+		return 0;
+
+	pgsz_lg2--;
+
+	PT_WARN_ON(log2_mod(va, pgsz_lg2) != 0);
+	PT_WARN_ON(oalog2_mod(oa, pgsz_lg2) != 0);
+	PT_WARN_ON(va + log2_to_int(pgsz_lg2) - 1 > last_va);
+	PT_WARN_ON(!log2_div_eq(va, va + log2_to_int(pgsz_lg2) - 1, pgsz_lg2));
+	PT_WARN_ON(
+		!oalog2_div_eq(oa, oa + log2_to_int(pgsz_lg2) - 1, pgsz_lg2));
+	return pgsz_lg2;
+}
+
+#define _PT_MAKE_CALL_LEVEL(fn)                                          \
+	static __always_inline int fn(struct pt_range *range, void *arg, \
+				      unsigned int level,                \
+				      struct pt_table_p *table)          \
+	{                                                                \
+		static_assert(PT_MAX_TOP_LEVEL <= 5);                    \
+		if (level == 0)                                          \
+			return CONCATENATE(fn, 0)(range, arg, 0, table); \
+		if (level == 1 || PT_MAX_TOP_LEVEL == 1)                 \
+			return CONCATENATE(fn, 1)(range, arg, 1, table); \
+		if (level == 2 || PT_MAX_TOP_LEVEL == 2)                 \
+			return CONCATENATE(fn, 2)(range, arg, 2, table); \
+		if (level == 3 || PT_MAX_TOP_LEVEL == 3)                 \
+			return CONCATENATE(fn, 3)(range, arg, 3, table); \
+		if (level == 4 || PT_MAX_TOP_LEVEL == 4)                 \
+			return CONCATENATE(fn, 4)(range, arg, 4, table); \
+		return CONCATENATE(fn, 5)(range, arg, 5, table);         \
+	}
+
+static inline int __pt_make_level_fn_err(struct pt_range *range, void *arg,
+					 unsigned int unused_level,
+					 struct pt_table_p *table)
+{
+	static_assert(PT_MAX_TOP_LEVEL <= 5);
+	return -EPROTOTYPE;
+}
+
+#define __PT_MAKE_LEVEL_FN(fn, level, descend_fn, do_fn)            \
+	static inline int fn(struct pt_range *range, void *arg,     \
+			     unsigned int unused_level,             \
+			     struct pt_table_p *table)              \
+	{                                                           \
+		return do_fn(range, arg, level, table, descend_fn); \
+	}
+
+/**
+ * PT_MAKE_LEVELS() - Build an unwound walker
+ * @fn: Name of the walker function
+ * @do_fn: Function to call at each level
+ *
+ * This builds a function call tree that can be fully inlined,
+ * The caller must provide a function body in an __always_inline function::
+ *
+ *  static __always_inline int do(struct pt_range *range, void *arg,
+ *         unsigned int level, struct pt_table_p *table,
+ *         pt_level_fn_t descend_fn)
+ *
+ * An inline function will be created for each table level that calls do_fn with
+ * a compile time constant for level and a pointer to the next lower function.
+ * This generates an optimally inlined walk where each of the functions sees a
+ * constant level and can codegen the exact constants/etc for that level.
+ *
+ * Note this can produce a lot of code!
+ */
+#define PT_MAKE_LEVELS(fn, do_fn)                                             \
+	__PT_MAKE_LEVEL_FN(CONCATENATE(fn, 0), 0, __pt_make_level_fn_err,     \
+			   do_fn);                                            \
+	__PT_MAKE_LEVEL_FN(CONCATENATE(fn, 1), 1, CONCATENATE(fn, 0), do_fn); \
+	__PT_MAKE_LEVEL_FN(CONCATENATE(fn, 2), 2, CONCATENATE(fn, 1), do_fn); \
+	__PT_MAKE_LEVEL_FN(CONCATENATE(fn, 3), 3, CONCATENATE(fn, 2), do_fn); \
+	__PT_MAKE_LEVEL_FN(CONCATENATE(fn, 4), 4, CONCATENATE(fn, 3), do_fn); \
+	__PT_MAKE_LEVEL_FN(CONCATENATE(fn, 5), 5, CONCATENATE(fn, 4), do_fn); \
+	_PT_MAKE_CALL_LEVEL(fn)
+
+#endif
diff --git a/drivers/iommu/generic_pt/pt_log2.h b/drivers/iommu/generic_pt/pt_log2.h
new file mode 100644
index 00000000000000..70d40fbfd7a7b6
--- /dev/null
+++ b/drivers/iommu/generic_pt/pt_log2.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Helper macros for working with log2 values
+ *
+ */
+#ifndef __GENERIC_PT_LOG2_H
+#define __GENERIC_PT_LOG2_H
+#include <linux/bitops.h>
+#include <linux/limits.h>
+
+/* Compute a */
+#define log2_to_int_t(type, a_lg2) ((type)(((type)1) << (a_lg2)))
+static_assert(log2_to_int_t(unsigned int, 0) == 1);
+
+/* Compute a - 1 (aka all low bits set) */
+#define log2_to_max_int_t(type, a_lg2) ((type)(log2_to_int_t(type, a_lg2) - 1))
+
+/* Compute a / b */
+#define log2_div_t(type, a, b_lg2) ((type)(((type)a) >> (b_lg2)))
+static_assert(log2_div_t(unsigned int, 4, 2) == 1);
+
+/*
+ * Compute:
+ *   a / c == b / c
+ * aka the high bits are equal
+ */
+#define log2_div_eq_t(type, a, b, c_lg2) \
+	(log2_div_t(type, (a) ^ (b), c_lg2) == 0)
+static_assert(log2_div_eq_t(unsigned int, 1, 1, 2));
+
+/* Compute a % b */
+#define log2_mod_t(type, a, b_lg2) \
+	((type)(((type)a) & log2_to_max_int_t(type, b_lg2)))
+static_assert(log2_mod_t(unsigned int, 1, 2) == 1);
+
+/*
+ * Compute:
+ *   a % b == b - 1
+ * aka the low bits are all 1s
+ */
+#define log2_mod_eq_max_t(type, a, b_lg2) \
+	(log2_mod_t(type, a, b_lg2) == log2_to_max_int_t(type, b_lg2))
+static_assert(log2_mod_eq_max_t(unsigned int, 3, 2));
+
+/*
+ * Return a value such that:
+ *    a / b == ret / b
+ *    ret % b == val
+ * aka set the low bits to val. val must be < b
+ */
+#define log2_set_mod_t(type, a, val, b_lg2) \
+	((((type)(a)) & (~log2_to_max_int_t(type, b_lg2))) | ((type)(val)))
+static_assert(log2_set_mod_t(unsigned int, 3, 1, 2) == 1);
+
+/* Return a value such that:
+ *    a / b == ret / b
+ *    ret % b == b - 1
+ * aka set the low bits to all 1s
+ */
+#define log2_set_mod_max_t(type, a, b_lg2) \
+	(((type)(a)) | log2_to_max_int_t(type, b_lg2))
+static_assert(log2_set_mod_max_t(unsigned int, 2, 2) == 3);
+
+/* Compute a * b */
+#define log2_mul_t(type, a, b_lg2) ((type)(((type)a) << (b_lg2)))
+static_assert(log2_mul_t(unsigned int, 2, 2) == 8);
+
+#define _dispatch_sz(type, fn, a) \
+	(sizeof(type) == 4 ? fn##32((u32)a) : fn##64(a))
+
+/*
+ * Return the highest value such that:
+ *    log2_fls(0) == 0
+ *    log2_fls(1) == 1
+ *    a >= log2_to_int(ret - 1)
+ * aka find last set bit
+ */
+static inline unsigned int log2_fls32(u32 a)
+{
+	return fls(a);
+}
+static inline unsigned int log2_fls64(u64 a)
+{
+	return fls64(a);
+}
+#define log2_fls_t(type, a) _dispatch_sz(type, log2_fls, a)
+
+/*
+ * Return the highest value such that:
+ *    log2_ffs(0) == UNDEFINED
+ *    log2_ffs(1) == 0
+ *    log_mod(a, ret) == 0
+ * aka find first set bit
+ */
+static inline unsigned int log2_ffs32(u32 a)
+{
+	return __ffs(a);
+}
+static inline unsigned int log2_ffs64(u64 a)
+{
+	return __ffs64(a);
+}
+#define log2_ffs_t(type, a) _dispatch_sz(type, log2_ffs, a)
+
+/*
+ * Return the highest value such that:
+ *    log2_ffz(MAX) == UNDEFINED
+ *    log2_ffz(0) == 0
+ *    log2_ffz(1) == 1
+ *    log_mod(a, ret) == log_to_max_int(ret)
+ * aka find first zero bit
+ */
+static inline unsigned int log2_ffz32(u32 a)
+{
+	return ffz(a);
+}
+static inline unsigned int log2_ffz64(u64 a)
+{
+	if (sizeof(u64) == sizeof(unsigned long))
+		return ffz(a);
+
+	if ((u32)a == U32_MAX)
+		return log2_ffz32(a >> 32) + 32;
+	return log2_ffz32(a);
+}
+#define log2_ffz_t(type, a) _dispatch_sz(type, log2_ffz, a)
+
+#endif
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
new file mode 100644
index 00000000000000..91869fad33fbdf
--- /dev/null
+++ b/include/linux/generic_pt/common.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_COMMON_H
+#define __GENERIC_PT_COMMON_H
+
+#include <linux/types.h>
+#include <linux/build_bug.h>
+#include <linux/bits.h>
+
+/**
+ * DOC: Generic Radix Page Table
+ *
+ * Generic Radix Page Table is a set of functions and helpers to efficiently
+ * parse radix style page tables typically seen in HW implementations. The
+ * interface is built to deliver similar code generation as the mm's pte/pmd/etc
+ * system by fully inlining the exact code required to handle each table level.
+ *
+ * Like the MM each format contributes its parsing implementation under common
+ * names and the common code implements the required algorithms.
+ *
+ * The system is divided into three logical levels:
+ *
+ *  - The page table format and its manipulation functions
+ *  - Generic helpers to give a consistent API regardless of underlying format
+ *  - An algorithm implementation (eg IOMMU/DRM/KVM/MM)
+ *
+ * Multiple implementations are supported, the intention is to have the generic
+ * format code be re-usable for whatever specalized implementation is required.
+ * The generic code is solely about the format of the radix tree, it does not
+ * include memory allocation or higher level decisions that are left for the
+ * implementation.
+ *
+ * The generic framework supports a superset of functions across many HW
+ * implementations:
+ *
+ *  - Entries comprised of contiguous blocks of IO PTEs for larger page sizes
+ *  - Multi-level tables, up to 6 levels. Runtime selected top level
+ *  - Runtime variable table level size (ARM's concatenated tables)
+ *  - Expandable top level allowing dynamic sizing of table levels
+ *  - Optional leaf entries at any level
+ *  - 32 bit/64 bit virtual and output addresses, using every address bit
+ *  - Dirty tracking
+ */
+
+/**
+ * struct pt_common
+ */
+struct pt_common {
+	/**
+	 * @top_of_table: Encodes the table top pointer and the top level in a
+	 * single value. Must use READ_ONCE/WRITE_ONCE to access it. The lower
+	 * bits of the aligned table pointer are used for the level.
+	 */
+	uintptr_t top_of_table;
+	/**
+	 * @max_oasz_lg2: Maximum number of bits the OA can contain. Upper bits
+	 * must be zero. This may be less than what the page table format
+	 * supports, but must not be more.
+	 */
+	u8 max_oasz_lg2;
+	/**
+	 * @max_vasz_lg2: Maximum number of bits the VA can contain. Upper bits
+	 * are 0 or 1 depending on pt_full_va_prefix(). This may be less than
+	 * what the page table format supports, but must not be more. When
+	 * PT_FEAT_DYNAMIC_TOP this reflects the maximum VA capability.
+	 */
+	u8 max_vasz_lg2;
+	/**
+	 * @features: Bitmap of `enum pt_features`
+	 */
+	unsigned int features;
+};
+
+/* Encoding parameters for top_of_table */
+enum {
+	PT_TOP_LEVEL_BITS = 3,
+	PT_TOP_LEVEL_MASK = GENMASK(PT_TOP_LEVEL_BITS - 1, 0),
+};
+
+/**
+ * enum pt_features - Features turned on in the table. Each symbol is a bit
+ * position.
+ */
+enum pt_features {
+	/**
+	 * @PT_FEAT_FULL_VA: The table can span the full VA range from 0 to
+	 * PT_VADDR_MAX.
+	 */
+	PT_FEAT_FULL_VA,
+	/**
+	 * @PT_FEAT_DYNAMIC_TOP: The table's top level can be increased
+	 * dynamically during map. This requires HW support for atomically
+	 * setting both the table top pointer and the starting table level.
+	 */
+	PT_FEAT_DYNAMIC_TOP,
+	/**
+	 * @PT_FEAT_SIGN_EXTEND: The top most bit of the valid VA range sign
+	 * extends up to the full pt_vaddr_t. This divides the page table into
+	 * three VA ranges::
+	 *
+	 *   0         -> 2^N - 1             Lower
+	 *   2^N       -> (MAX - 2^N - 1)     Non-Canonical
+	 *   MAX - 2^N -> MAX                 Upper
+	 *
+	 * In this mode pt_common::max_vasz_lg2 includes the sign bit and the
+	 * upper bits that don't fall within the translation are just validated.
+	 *
+	 * If not set there is no sign extension and valid VA goes from 0 to 2^N
+	 * - 1.
+	 */
+	PT_FEAT_SIGN_EXTEND,
+	/**
+	 * @PT_FEAT_FLUSH_RANGE: IOTLB maintenance is done by flushing IOVA
+	 * ranges which will clean out any walk cache or any IOPTE fully
+	 * contained by the range. The optimization objective is to minimize the
+	 * number of flushes even if ranges include IOVA gaps that do not need
+	 * to be flushed.
+	 */
+	PT_FEAT_FLUSH_RANGE,
+	/**
+	 * @PT_FEAT_FLUSH_RANGE_NO_GAPS: Like PT_FEAT_FLUSH_RANGE except that
+	 * the optimization objective is to only flush IOVA that has been
+	 * changed. This mode is suitable for cases like hypervisor shadowing
+	 * where flushing unchanged ranges may cause the hypervisor to reparse
+	 * significant amount of page table.
+	 */
+	PT_FEAT_FLUSH_RANGE_NO_GAPS,
+	/* private: */
+	PT_FEAT_FMT_START,
+};
+
+#endif
-- 
2.43.0


