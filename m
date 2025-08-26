Return-Path: <linux-kselftest+bounces-39983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F9B3712A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BE58E4444
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECBE2F49FF;
	Tue, 26 Aug 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7b4vCt0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F02FD1D6;
	Tue, 26 Aug 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228737; cv=fail; b=b1V/1FhFTP//r3nIUZW3n/am2CTCRVrKuJ2i1dseEAso0fb2IqZTNLG425WZVe6ozX86BfXZjU8H+z3yJUQFstd1hG5AcH77zvIgV2mF/oiNfxzRIrLy/X1q6edlr6jIA3kYI6/h1GrHO6MWZzbIXJSNn6DqcIGJ7cRVRSTae60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228737; c=relaxed/simple;
	bh=m9wVUvkm60E2E0VCESkd/Fhv/pU8YaYDpXTo5DLpPOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpZ2Q6yFuHegSskIQ6R40Ujb2cfmnpsz7xGPDhpEGFijxCCWUgIkgmW6oIQXWXZOSHeFYEcSMqrNHZ8T+UnOCEi4gHLYsAvzlk6xKs8t1HQ6oK6Tu+iOFEQT+2H0kUHLtLOmNGGx8EHijB/v4hvii3E7wUbQZTMhQC1YVtuUOxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7b4vCt0; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI9dPw9mskQYDReBtJfh8uNEV9kurHkuLae6kPp55v/HutmZcWlrSBb84RYviCryD+EANxF7FmP23tXll4zlsLGdv0GdMDZkH/CkDQKYaqJBQtIhwTFWlg+N+FdskB+sJQbvGCLL3nKoH3RHs4yn3y0STOvIhDQtqMaq6ZLCTfQTwgvaF9+DbbKIRmo8EAlHMRwc47o2Z/UqJonzydMiyPSBM4iKzDVJhv8MPCmq+pc+yKOg2E/QO82mMPOXQ/A0pWFmOIfZ2C2/w9/Iyg+tzPFFDPX7YCt1fB78s4KQe+GLm+PwmUPDTyjAzrNYOzIl1sH0FA4M3Pl91oMDvb8wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm6pdJA4qyF/e+e5jE82efs+7Lv6Yf3eJ6UP/btbhQs=;
 b=DZIEWKsT5+eF+4MlXOXUO3xhm/Zk55aZcd5KJCwLtdLaxf8v0TandmX9fj26xYe6tcou7AJYFtlp5+AxS+F+g2eZYyG7nG+f+iQAyfy76cIkHvMiDxHBe9wQc/jN97q6MbYPmAsfMPEBxTZYKfICmrEoLoJUJ2j2chUgtSzYqjccFdHSvA5KHFN7GSxxf5OYZI/79ym750zjfjPl28AoTS3I1wxnrOI5e6FMkvDLPK2r0Ikf/Oo1Ky/vv3S9IOcjV9ObuTZSdwGHzyOARv58JBQwGeR8Llf2OZU8PUK6I+j13/Wwez2UcHyh8e7MHrFjzmmISjsDYSK+Gu1puRxX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm6pdJA4qyF/e+e5jE82efs+7Lv6Yf3eJ6UP/btbhQs=;
 b=D7b4vCt0lwrpaoT2ldBRVk1VqAfVGDvVVgSUvvcNb4sI4K7kaLDipjoPutGOH/At11O3G2bBZSwapNxtKSkYDD471RNjUK1t1M8/mK6GDCaxT/nJknbWKRW4W+OHdUx6IW08GbaD1GK8dZAeUAmNLW11KVWFZzRF+h22DnXLcajm8Q2uYsM4qASQHBjfKTE/rfjgqFW+LljVWYbYwjlhB7MjwSr2nqNBAol3RIFI7cXsX2VAAH/2NzGybcPvz/6D6Kh/FgjKNcQu3nC2Ov1JUDq5bZKor10Wi1SysBubg23FPivHKZeKdraBHgCMW0oP049QSeMMB8o4feArj0HxFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:41 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:41 +0000
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
Subject: [PATCH v4 13/15] iommu/amd: Use the generic iommu page table
Date: Tue, 26 Aug 2025 14:18:34 -0300
Message-ID: <13-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e756b7-1385-4374-3094-08dde4c49971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+c1VoiPghSHq4F88u3fbuNY1oqWkBioP2ngsWtGpb62GR+QjjTjUPKHhoX8?=
 =?us-ascii?Q?jPMTt5tCY+lXJFbVxkW+bMBXm/wQlFlGfVnAdjobbOY84RuYCA6DY41viQpH?=
 =?us-ascii?Q?qZmGzoyMofLo0TpdMxA95TH9KXYOr6Z9kBF4Lz/RWhJKnL3DCcV5auzN9Z2c?=
 =?us-ascii?Q?WINXtaR6edvHQMGTd58K7wjsTGbVEzLfeTfqBbDY+zMqxU5wQp1OzEEqiar+?=
 =?us-ascii?Q?kSIWO6AGs2DXMr6yat2DpWvmrlplanXqgePNurva4npO29K6GNbnp0/GZuQI?=
 =?us-ascii?Q?rFsiNrH4IxAS/QOHUxwgrSpjBiowjkPoSEIXwtmcQYNbnOPxnanPvl+3rkW6?=
 =?us-ascii?Q?DsDZmkWs6AeIFA0tgNh6EiAWXV9K/rbZm0NULV7OnUWBvQsWd6CvywZaHhMj?=
 =?us-ascii?Q?T4nA3n5CFrau9bfcyCoP6JA81s8u97mTJiDAJ4B7y3J0ha6023aj4t/q9ArX?=
 =?us-ascii?Q?1smeHTv72hRmpD/GgtdRit1Wpr5j1jVgzP95QL+qTZ1ZEZMwR1W43EiRf8yL?=
 =?us-ascii?Q?9iYvNJMeRUJ124fbt0L9yK5XuwVjS2sEQfcnu/QbWFELhVsbFxD6SGGQNjga?=
 =?us-ascii?Q?pFbdJeyaabpOqeRoupCiqvzZa1sOR4RdZYqful8FDbPwm8ohqj5DRXU7SFZO?=
 =?us-ascii?Q?H1jlXQ/Du5WUAzoaFJKCWyH8Hq+j0ed/ZcyvH5jM8gK7ZkjrP3+BM6VBNM7W?=
 =?us-ascii?Q?lgwiDuDK9Z5X3biRFiJ9Nl7tToGd0wgimCt+nhmrPqhsG+BRRr3P4yvj0tKE?=
 =?us-ascii?Q?+RqqQVRhmtpsot1u0m4dCw9GBD1pShs6rjJFiehZ7AIxTkxmCrnPYTSNgYbS?=
 =?us-ascii?Q?w4RAqoWi4Vdt30Gx5O8JuR1i2OveVhklcOLyNoIDqhp5Q/ioHIyBVlAJGIc+?=
 =?us-ascii?Q?dMXqegEv1ulU+haoLv/EvbxIjodGn9yPtoacwHcOCyJI1CeT9T7/4tpbQcSL?=
 =?us-ascii?Q?6Opgr+eATKsgWhX2OTfxgcuArkRTYwFxKXHuPgYHxsB/equnYSqpogPrSu6V?=
 =?us-ascii?Q?aUvZyrU624OrVN80LRE/zPfvQBIFaiI4Xb/85gy9smrO7L9jXbv7DnUD1rpg?=
 =?us-ascii?Q?pEgeLUydUFsDdc+0tlUmPz7XsV4fNWPotPjnLYHxYaLwcLyGGHVeKsVyf1bd?=
 =?us-ascii?Q?jg8XLZ5H/YU1ePJgUKtLl9cid4rKa0UbHwYT/GvSzom0z5WDn+yhxDWu3Nhv?=
 =?us-ascii?Q?b0/w6s6SqL6oyVr+MpzoQ7sMAkrwPlvctgQD6nKDZGQ18lxb+FobGUH+jmJx?=
 =?us-ascii?Q?cG6hAQQ/tUiydithcfJR2ncZGYOdTxSccjq5LX5kcsrYMx5XmJq2YRJtLDnx?=
 =?us-ascii?Q?i7uxNXAVbEwCvmlap6EmMjhNrr70LAmpIvLvIqwTUqgePCf1K/DS8vjlxzAW?=
 =?us-ascii?Q?ytN+HL4mWopTsrMCW/Gt9P0qTxqJSnQvg4/LdqJm/GC6Y3lXSLZKmND552sr?=
 =?us-ascii?Q?RGLJmfnmzyztJZ1B7l9hrhQBZMme8jwLmbQ6xKuQl2H4jTGrjBJHDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/j+WF6HIS6HpDPYVjHxQQURmR2K6X1sPbvHNEzAuIPHcYY/bsG/A9XlfGql?=
 =?us-ascii?Q?hHSMrQNaVBeJumMvS9ef0ODGwLFlrxsyAcuychgzGU8iP15aJ8v4K5o1rXsC?=
 =?us-ascii?Q?+yLBnEmGcmMmcVBYKnIL0jktQWHW6u0Obw6x/SADMBeZAIpBhMInqH9jMiHb?=
 =?us-ascii?Q?6KMdHiGPQo5byD+nTeeG89F87mCpAJaJhJvMUAiN8PpUevl/Exo8LLBXU5ux?=
 =?us-ascii?Q?4LsEImhWAtg2zUf8s8jqK86aENlpHmFllp86I/XArPXypN9qPe3zYhV07ssY?=
 =?us-ascii?Q?FIkrUAbe0yQABhbxI0w4F/YtjqklVgpnYFeYoUQmfK3Mudd6iOCurGZoGOZy?=
 =?us-ascii?Q?HWmllncsQvgiJQBB3n4dPVNdsQRiR+5SVsL9rS/5am8b9k0qeZkvkPwQI/E1?=
 =?us-ascii?Q?W1gAEBfXiEwMMAa1IujmvL1ZKjhWW3z75Xt9shRAJL8A8sOdolV7KOyDfa85?=
 =?us-ascii?Q?94tWwbYGriYTtnPXGPsCoR4ELFzCb2fYE27k2kvxGElWeLB5XHYANPPEBkT3?=
 =?us-ascii?Q?CML6mcsMtGOVNV5xZnQJMHIJkJVLuvPn/4VizBVjJ/SxrCsfS1R7O5AMMR3s?=
 =?us-ascii?Q?4/i4q7RWzc+uyfyxoMcRhxDlqGFiRbkxIe14cftsRzMUYTJeLpMYYLz+TCtm?=
 =?us-ascii?Q?/BZU3QordQaz+XiOkGycbdGlyXVTm6PBdVdpCFNMsp9lDjeu7wfJZ5nMZc+Q?=
 =?us-ascii?Q?XB1cSjrcjM87z2OIrRjXfKIjYZ0hnHGpW7IZUMhQ2X1tOIapCQroaV9pfDfL?=
 =?us-ascii?Q?LKJQzF70P4PKDDq7aEcu6uSgKeFIIJOfR3iUL2d8SXjhamAoJqnRXfAQYPYb?=
 =?us-ascii?Q?ltJYnFgnnkkF7FIBeI2rqD6vaEZ2rHjIbaRmY3RJVLXwDthHs8ZgT+sVxS4d?=
 =?us-ascii?Q?Ys+Q5j3GsxugPkVHjeB1CkH71SM/vCYntxjM3KGU2VEif419hFj2AUsgU+WJ?=
 =?us-ascii?Q?FQjFrpZQGIFSceegjuAF/ZMtq8AIWZKa3d+wmByzTS2qM3LdFJEW2DI5hrO5?=
 =?us-ascii?Q?XZ8G90ihnXRveOodf7YtDFsOPJNV/7Zb8vHFLnKVB/X9ZCHtjke4y08/o3yT?=
 =?us-ascii?Q?1B3KnURwClDnOd4vSaEegoKtD5Mf48nqx4GYfgAtCsZ+VxvtPcORqR7zlJLx?=
 =?us-ascii?Q?T7yHzl3d69rti0MBTYMDKL1WzKsHHI462vLhwq8n1LzXSzJu2hLK/P1j8VUM?=
 =?us-ascii?Q?kgF+QueGOfMRJ6xDulPuh4lst7aw79gbhzyX4QJ+leg1FnQUe15pIZdzqKtN?=
 =?us-ascii?Q?+BRDzKrQVEiNdiWyQJgenhRJCmIUqqgoBySOAyj7+BbV8BUm2SVOFE2nAQK4?=
 =?us-ascii?Q?wkQ6qTf2ElNdW7a6dJvlma/CFd79NI4cSGK/AJPoFK7I76R1iYSzNpizByoE?=
 =?us-ascii?Q?BRyZNujZM/RwYdSQirpCxSjLTfegcvFJR/fHAsBU37TXDOph/tPf3r/mbIrd?=
 =?us-ascii?Q?rTiDIQKjA4gDh/JRb1WOTaHYSt7LaSgDe6Jf89fKO+Oshgde6uZf+vOujTPf?=
 =?us-ascii?Q?0StL6V9iPrqYkg0OiYkdtksYL6CcG+RbQnKKeoGOypjKf1yspLkHmYt32y1Q?=
 =?us-ascii?Q?40s/+neRQJspsyS3wgILfHtgkmqTOfmVRiyGR9gY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e756b7-1385-4374-3094-08dde4c49971
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:40.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBPhwakXuCoHiyqBLsbbl1WfAzWIAanYR8o93f4vU+DebvRd9RoYP4fM3ldksFA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Replace the io_pgtable versions with pt_iommu versions. The v2 page table
uses the x86 implementation that will be eventually shared with VT-D.

This supports the same special features as the original code:
 - increase_top for the v1 format to allow scaling from 3 to 6 levels
 - non-present flushing
 - Dirty tracking for v1 only
 - __sme_set() to adjust the PTEs for CC
 - Optimization for flushing with virtualization to minimize the range
 - amd_iommu_pgsize_bitmap override of the native page sizes
 - page tables allocate from the device's NUMA node

Rework the domain ops so that v1/v2 get their own ops. Make dedicated
allocation functions for v1 and v2. Hook up invalidation for a top change
to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
that becomes unused in this patch. The next patch will delete the rest of
it.

This fixes a race bug in AMD's increase_address_space() implementation. It
stores the top level and top pointer in different memory, which prevents
other threads from reading a coherent version:

   increase_address_space()   alloc_pte()
                                level = pgtable->mode - 1;
	pgtable->root  = pte;
	pgtable->mode += 1;
                                pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];

The iommupt version is careful to put mode and root under a single
READ_ONCE and then is careful to only READ_ONCE a single time per
walk.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig           |   5 +-
 drivers/iommu/amd/amd_iommu.h       |   1 -
 drivers/iommu/amd/amd_iommu_types.h |  12 +-
 drivers/iommu/amd/io_pgtable.c      |   1 -
 drivers/iommu/amd/iommu.c           | 538 ++++++++++++++--------------
 5 files changed, 282 insertions(+), 275 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index ecef69c11144db..f2acf471cb5d9f 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -11,10 +11,13 @@ config AMD_IOMMU
 	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
-	select IOMMU_IO_PGTABLE
 	select IOMMU_SVA
 	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_AMDV1
+	select IOMMU_PT_X86_64
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9b4b589a54b57e..25044d28f28a8d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -88,7 +88,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * the IOMMU used by this driver.
  */
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5219d7ddfdaa8b..90cf2bc4e14528 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
+#include <linux/generic_pt/iommu.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -588,9 +589,13 @@ struct pdom_iommu_info {
  * independent of their use.
  */
 struct protection_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+		struct pt_iommu_x86_64 amdv2;
+	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct iommu_domain domain; /* generic domain handle used by
-				       iommu core code */
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
@@ -601,6 +606,9 @@ struct protection_domain {
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
 /*
  * This structure contains information about one PCI segment in the system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index a91e71f981efb9..ba61869b23857a 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -132,7 +132,6 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	pgtable->root  = pte;
 	pgtable->mode += 1;
-	amd_iommu_update_and_flush_device_table(domain);
 
 	pte = NULL;
 	ret = true;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d096..97e9b4df340a08 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -29,7 +29,6 @@
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
-#include <linux/io-pgtable.h>
 #include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
@@ -40,9 +39,9 @@
 #include <asm/gart.h>
 #include <asm/dma.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
-#include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -59,7 +58,6 @@ LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
-static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
@@ -73,11 +71,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data);
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level);
+
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level);
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
 static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
+static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
+					bool enable);
 
 /****************************************************************************
  *
@@ -1755,42 +1760,6 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 					CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
-/* Flush the not present cache if it exists */
-static void domain_flush_np_cache(struct protection_domain *domain,
-		dma_addr_t iova, size_t size)
-{
-	if (unlikely(amd_iommu_np_cache)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&domain->lock, flags);
-		amd_iommu_domain_flush_pages(domain, iova, size);
-		spin_unlock_irqrestore(&domain->lock, flags);
-	}
-}
-
-
-/*
- * This function flushes the DTEs for all devices in domain
- */
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	lockdep_assert_held(&domain->lock);
-
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
-
-		set_dte_entry(iommu, dev_data);
-		clone_aliases(iommu, dev_data->dev);
-	}
-
-	list_for_each_entry(dev_data, &domain->dev_list, list)
-		device_flush_dte(dev_data);
-
-	domain_flush_complete(domain);
-}
-
 int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
@@ -2050,7 +2019,8 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;
 	u32 old_domid;
@@ -2059,19 +2029,36 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
-
-	if (gcr3_info && gcr3_info->gcr3_tbl)
-		domid = dev_data->gcr3_info.domid;
-	else
-		domid = domain->id;
+	struct pt_iommu_amdv1_hw_info pt_info;
 
 	make_clear_dte(dev_data, dte, &new);
 
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		domid = dev_data->gcr3_info.domid;
+	else {
+		domid = domain->id;
 
-	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
-		    << DEV_ENTRY_MODE_SHIFT;
+		if (domain->domain.type & __IOMMU_DOMAIN_PAGING) {
+			/*
+			 * When updating the IO pagetable, the new top and level
+			 * are provided as parameters. For other operations i.e.
+			 * device attach, retrieve the current pagetable info
+			 * via the IOMMU PT API.
+			 */
+			if (top_paddr) {
+				pt_info.host_pt_root = top_paddr;
+				pt_info.mode = top_level + 1;
+			} else {
+				WARN_ON(top_paddr || top_level);
+				pt_iommu_amdv1_hw_info(&domain->amdv1,
+						       &pt_info);
+			}
+
+			new.data[0] |= pt_info.host_pt_root |
+				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
+					       << DEV_ENTRY_MODE_SHIFT;
+		}
+	}
 
 	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
 
@@ -2137,7 +2124,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (set)
-		set_dte_entry(iommu, dev_data);
+		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
 
@@ -2155,6 +2142,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int max_pasids = dev_data->max_pasids;
+	struct pt_iommu_x86_64_hw_info pt_info;
 	int ret = 0;
 
 	 /*
@@ -2177,7 +2165,8 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 	if (!pdom_is_v2_pgtbl_mode(pdom))
 		return ret;
 
-	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
+	ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
@@ -2499,54 +2488,6 @@ struct protection_domain *protection_domain_alloc(void)
 	return domain;
 }
 
-static int pdom_setup_pgtable(struct protection_domain *domain,
-			      struct device *dev)
-{
-	struct io_pgtable_ops *pgtbl_ops;
-	enum io_pgtable_fmt fmt;
-
-	switch (domain->pd_mode) {
-	case PD_MODE_V1:
-		fmt = AMD_IOMMU_V1;
-		break;
-	case PD_MODE_V2:
-		fmt = AMD_IOMMU_V2;
-		break;
-	case PD_MODE_NONE:
-		WARN_ON_ONCE(1);
-		return -EPERM;
-	}
-
-	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &domain->iop.pgtbl.cfg, domain);
-	if (!pgtbl_ops)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static inline u64 dma_max_address(enum protection_domain_mode pgtable)
-{
-	if (pgtable == PD_MODE_V1)
-		return PM_LEVEL_SIZE(amd_iommu_hpt_level);
-
-	/*
-	 * V2 with 4/5 level page table. Note that "2.2.6.5 AMD64 4-Kbyte Page
-	 * Translation" shows that the V2 table sign extends the top of the
-	 * address space creating a reserved region in the middle of the
-	 * translation, just like the CPU does. Further Vasant says the docs are
-	 * incomplete and this only applies to non-zero PASIDs. If the AMDv2
-	 * page table is assigned to the 0 PASID then there is no sign extension
-	 * check.
-	 *
-	 * Since the IOMMU must have a fixed geometry, and the core code does
-	 * not understand sign extended addressing, we have to chop off the high
-	 * bit to get consistent behavior with attachments of the domain to any
-	 * PASID.
-	 */
-	return ((1ULL << (PM_LEVEL_SHIFT(amd_iommu_gpt_level) - 1)) - 1);
-}
-
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 {
 	if (amd_iommu_hatdis)
@@ -2555,38 +2496,229 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-static struct iommu_domain *
-do_iommu_domain_alloc(struct device *dev, u32 flags,
-		      enum protection_domain_mode pgtable)
+static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
 {
-	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct protection_domain *pdom =
+		container_of(iommupt, struct protection_domain, iommu);
+
+	return &pdom->lock;
+}
+
+/*
+ * Update all HW references to the domain with a new pgtable configuration.
+ */
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level)
+{
+	struct protection_domain *pdom =
+		container_of(iommu_table, struct protection_domain, iommu);
+	struct iommu_dev_data *dev_data;
+
+	lockdep_assert_held(&pdom->lock);
+
+	/* Update the DTE for all devices attached to this domain */
+	list_for_each_entry(dev_data, &pdom->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		/* Update the HW references with the new level and top ptr */
+		set_dte_entry(iommu, dev_data, top_paddr, top_level);
+		clone_aliases(iommu, dev_data->dev);
+	}
+
+	list_for_each_entry(dev_data, &pdom->dev_list, list)
+		device_flush_dte(dev_data);
+
+	domain_flush_complete(pdom);
+}
+
+/*
+ * amd_iommu_iotlb_sync_map() is used to generate flushes for non-present to
+ * present (ie mapping) operations. It is a NOP if the IOMMU doesn't have non
+ * present caching (like hypervisor shadowing).
+ */
+static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				    unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
+
+	if (likely(!amd_iommu_np_cache))
+		return 0;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	amd_iommu_domain_flush_pages(domain, iova, size);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	return 0;
+}
+
+static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_all(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
+}
+
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_pages(dom, gather->start,
+				     gather->end - gather->start + 1);
+	spin_unlock_irqrestore(&dom->lock, flags);
+	iommu_put_pages_list(&gather->freelist);
+}
+
+static const struct pt_iommu_flush_ops amd_hw_flush_ops_v1 = {
+	.get_top_lock = amd_iommu_get_top_lock,
+	.change_top = amd_iommu_change_top,
+};
+
+static const struct iommu_domain_ops amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
+
+static const struct iommu_dirty_ops amdv1_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1),
+	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
+};
+
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
 	int ret;
 
+	if (amd_iommu_hatdis)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	domain = protection_domain_alloc();
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->pd_mode = pgtable;
-	ret = pdom_setup_pgtable(domain, dev);
+	domain->pd_mode = PD_MODE_V1;
+	domain->iommu.hw_flush_ops = &amd_hw_flush_ops_v1;
+	domain->iommu.nid = dev_to_node(dev);
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		domain->domain.dirty_ops = &amdv1_dirty_ops;
+
+	/*
+	 * Someday FORCE_COHERENCE should be set by
+	 * amd_iommu_enforce_cache_coherency() like VT-D does.
+	 */
+	cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+			      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+			      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+
+	/*
+	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
+	 * Unless we run in a virtual machine, which can be inferred according
+	 * to whether "non-present cache" is on, it is probably best to prefer
+	 * (potentially) too extensive TLB flushing (i.e., more misses) over
+	 * multiple TLB flushes (i.e., more flushes). For virtual machines the
+	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
+	 * the guest, and the trade-off is different: unnecessary TLB flushes
+	 * should be avoided.
+	 */
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	cfg.common.hw_max_vasz_lg2 =
+		max(64, (amd_iommu_hpt_level - 1) * 9 + 21);
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.starting_level = 2;
+	domain->domain.ops = &amdv1_ops;
+
+	ret = pt_iommu_amdv1_init(&domain->amdv1, &cfg, GFP_KERNEL);
 	if (ret) {
-		pdom_id_free(domain->id);
-		kfree(domain);
+		amd_iommu_domain_free(&domain->domain);
 		return ERR_PTR(ret);
 	}
 
-	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
-	domain->domain.geometry.force_aperture = true;
-	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
+	/*
+	 * Narrow the supported page sizes to those selected by the kernel
+	 * command line.
+	 */
+	domain->domain.pgsize_bitmap &= amd_iommu_pgsize_bitmap;
+	return &domain->domain;
+}
 
-	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	domain->domain.ops = iommu->iommu.ops->default_domain_ops;
+static const struct iommu_domain_ops amdv2_ops = {
+	IOMMU_PT_DOMAIN_OPS(x86_64),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	/*
+	 * Note the AMDv2 page table format does not support a Force Coherency
+	 * bit, so enforce_cache_coherency should not be set. However VFIO is
+	 * not prepared to handle a case where some domains will support
+	 * enforcement and others do not. VFIO and iommufd will have to be fixed
+	 * before it can fully use the V2 page table. See the comment in
+	 * iommufd_hwpt_paging_alloc(). For now leave things as they have
+	 * historically been and lie about enforce_cache_coherencey.
+	 */
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
 
-	if (dirty_tracking)
-		domain->domain.dirty_ops = &amd_dirty_ops;
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_x86_64_cfg cfg = {};
+	struct protection_domain *domain;
+	int ret;
 
+	if (!amd_iommu_v2_pgtbl_supported())
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = protection_domain_alloc();
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	domain->pd_mode = PD_MODE_V2;
+	domain->iommu.nid = dev_to_node(dev);
+
+	cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	/*
+	 * The v2 table behaves differently if it is attached to PASID 0 vs a
+	 * non-zero PASID. On PASID 0 it has no sign extension and the full
+	 * 57/48 bits decode the lower addresses. Otherwise it behaves like a
+	 * normal sign extended x86 page table. Since we want the domain to work
+	 * in both modes the top bit is removed and PT_FEAT_SIGN_EXTEND is not
+	 * set which creates a table that is compatible in both modes.
+	 */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		cfg.common.hw_max_vasz_lg2 = 56;
+	else
+		cfg.common.hw_max_vasz_lg2 = 47;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	domain->domain.ops = &amdv2_ops;
+
+	ret = pt_iommu_x86_64_init(&domain->amdv2, &cfg, GFP_KERNEL);
+	if (ret) {
+		amd_iommu_domain_free(&domain->domain);
+		return ERR_PTR(ret);
+	}
 	return &domain->domain;
 }
 
@@ -2607,15 +2739,27 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		/* Allocate domain with v1 page table for dirty tracking */
 		if (!amd_iommu_hd_support(iommu))
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
 		if (!amd_iommu_pasid_supported())
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
-	case 0:
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
+	case 0: {
+		struct iommu_domain *ret;
+
 		/* If nothing specific is required use the kernel commandline default */
-		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		if (amd_iommu_pgtable == PD_MODE_V1) {
+			ret = amd_iommu_domain_alloc_paging_v1(dev, flags);
+			if (ret != ERR_PTR(-EOPNOTSUPP))
+				return ret;
+			return amd_iommu_domain_alloc_paging_v2(dev, flags);
+		}
+		ret = amd_iommu_domain_alloc_paging_v2(dev, flags);
+		if (ret != ERR_PTR(-EOPNOTSUPP))
+			return ret;
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
+	}
 	default:
 		break;
 	}
@@ -2627,8 +2771,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	struct protection_domain *domain = to_pdomain(dom);
 
 	WARN_ON(!list_empty(&domain->dev_list));
-	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
-		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+	pt_iommu_deinit(&domain->iommu);
 	pdom_id_free(domain->id);
 	kfree(domain);
 }
@@ -2733,93 +2876,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
-				    unsigned long iova, size_t size)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	if (ops->map_pages)
-		domain_flush_np_cache(domain, iova, size);
-	return 0;
-}
-
-static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
-			       phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			       int iommu_prot, gfp_t gfp, size_t *mapped)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	int prot = 0;
-	int ret = -EINVAL;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return -EINVAL;
-
-	if (iommu_prot & IOMMU_READ)
-		prot |= IOMMU_PROT_IR;
-	if (iommu_prot & IOMMU_WRITE)
-		prot |= IOMMU_PROT_IW;
-
-	if (ops->map_pages) {
-		ret = ops->map_pages(ops, iova, paddr, pgsize,
-				     pgcount, prot, gfp, mapped);
-	}
-
-	return ret;
-}
-
-static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
-					    struct iommu_iotlb_gather *gather,
-					    unsigned long iova, size_t size)
-{
-	/*
-	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
-	 * Unless we run in a virtual machine, which can be inferred according
-	 * to whether "non-present cache" is on, it is probably best to prefer
-	 * (potentially) too extensive TLB flushing (i.e., more misses) over
-	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
-	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
-	 * the guest, and the trade-off is different: unnecessary TLB flushes
-	 * should be avoided.
-	 */
-	if (amd_iommu_np_cache &&
-	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
-		iommu_iotlb_sync(domain, gather);
-
-	iommu_iotlb_gather_add_range(gather, iova, size);
-}
-
-static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova,
-				    size_t pgsize, size_t pgcount,
-				    struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	size_t r;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return 0;
-
-	r = (ops->unmap_pages) ? ops->unmap_pages(ops, iova, pgsize, pgcount, NULL) : 0;
-
-	if (r)
-		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
-
-	return r;
-}
-
-static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-					  dma_addr_t iova)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	return ops->iova_to_phys(ops, iova);
-}
-
 static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
@@ -2886,28 +2942,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
-					  unsigned long iova, size_t size,
-					  unsigned long flags,
-					  struct iommu_dirty_bitmap *dirty)
-{
-	struct protection_domain *pdomain = to_pdomain(domain);
-	struct io_pgtable_ops *ops = &pdomain->iop.pgtbl.ops;
-	unsigned long lflags;
-
-	if (!ops || !ops->read_and_clear_dirty)
-		return -EOPNOTSUPP;
-
-	spin_lock_irqsave(&pdomain->lock, lflags);
-	if (!pdomain->dirty_tracking && dirty->bitmap) {
-		spin_unlock_irqrestore(&pdomain->lock, lflags);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&pdomain->lock, lflags);
-
-	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
-}
-
 static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
@@ -2977,28 +3011,6 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 	return dev_data->defer_attach;
 }
 
-static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_all(dom);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
-static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
-				 struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_pages(dom, gather->start,
-				     gather->end - gather->start + 1);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
 static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -3033,11 +3045,6 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
-static const struct iommu_dirty_ops amd_dirty_ops = {
-	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
-	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
-};
-
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
@@ -3052,17 +3059,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.page_response = amd_iommu_page_response,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= amd_iommu_attach_device,
-		.map_pages	= amd_iommu_map_pages,
-		.unmap_pages	= amd_iommu_unmap_pages,
-		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-		.iova_to_phys	= amd_iommu_iova_to_phys,
-		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-		.iotlb_sync	= amd_iommu_iotlb_sync,
-		.free		= amd_iommu_domain_free,
-		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
-	}
 };
 
 #ifdef CONFIG_IRQ_REMAP
@@ -4071,3 +4067,5 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	return 0;
 }
 #endif
+
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


