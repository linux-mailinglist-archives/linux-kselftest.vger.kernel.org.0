Return-Path: <linux-kselftest+bounces-41509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD8B58135
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6F618942F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6421767C;
	Mon, 15 Sep 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXRC3H0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092219066B;
	Mon, 15 Sep 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951039; cv=fail; b=HPtbl3mtMf32Es07+b5U+3nhp7ztBznl+T1Ui69kqmefkUtRZjxYChZDLMTOWt1IQx11M4+SfCw63j4qbbYBGMg0Ug66L19lRGooezj00KnE0XJnQLE4pr7qMUA4+aco9HhiLfib+AW06jvinrmXDnvpcu4dxjHjbNqSW4hq2oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951039; c=relaxed/simple;
	bh=gQ+jGr5UX0fR7GFbsQS2HCssHEtldabWn6feCCrpyWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sw5F6cE5yAVlMfUcoaSKXRJK//18oINEVK5K7tmmzImV8l6Qzimimi5GLg196mxCYX/TzQbv7eKrqxdv5Rjittmrn/0GBuefaSBdK3CxEfEn/aWY7L9PtuKMRGGIsyJvHXVnAiv5LpGxbxhv4PNJmJXjVAObLKdNMK0AQ9IlxoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXRC3H0i; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBb8jUdCdgixBJdgIgWMc7YNMX+HIApKaYtQpB/yP6cAIELdm0tKnMdrMBm2Gaff+pW7wn4fPKYlWzYNag2SCpvCwgCyAgwiG6iKCCPRYxgrKBddZM3Q+nzHfzwlXASzOTtAfktZs9D3Wz0l7A8dLBIFRCYA5DjXQ/mHbU27Uv7Zcf3Rp3VZ6a1o/fFQZaiSfRChdLjUEO6gA/iB2ERQrRMcGyRVdEBuAmc9d0cwESgyZURXP5ck3mwxWffYnfPua2rfnxF3vhRjglu98DUaf1OJLKuyq4cUMukg5HjxnwXiJhwVz7Tq0k4nGWbQprY9vwZ5hPSKZ/SX77Fm025cNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5tcBY4ur9/6leYKkUjbpVldqBwxy8tCTajwneT4R/s=;
 b=QwDrZAqARSAm2t5U10NwOAIVx1Eyo6h5RpvGyHCcgwquG7PEaehBXbjL1UgFpkjgopoDQvhHyXXcRoX6+GeQoFCLZsP31Kciln1zld95n7mNEeRAH6OslY0hAEAw4loGCoo9mOYaRIKkvp3VaME76/BzaOpdD7ZhTTHh1bN08guK2nE12N3QMQNqxWSVNwJtn62VrYx9RFQV5RMOWv3MMpwyRRprLu1Ut8EV/6bFi+Gi36A4PYdbCDNDhf9ZdLJPLg48Ay4QL5/8srfgYdorqdv2oIR29xRQwTu6UWlDCqmtmUpZ3C/Vk2uyFLmlIHahHvwHXBk1DyAQ81KHf/U/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5tcBY4ur9/6leYKkUjbpVldqBwxy8tCTajwneT4R/s=;
 b=oXRC3H0indyBDqMci720adwFJ4j8RjIeZh/xRMKYtFfbZGMp3FMV7kNTVVHAzxKZbVoToT21tW6hc64gwQjK2f0SelW78XWwfhFgYdq4CIxkJffllHjxUiwzchP6lUB9DxKVqffv4JomFWJRSJrr/Gax1bM7N2R9VGPkSqDEMXEBVi+HBdz70sEhyETOkrI71UkE6nA4v8ALAznVnSbJhA7/MoHFwmEvtyZUu94IVLm8GIaeuuroTeWH9cQomMkAoYmiwWxkMVbEsl9IuBahVRLnS2/SLrY+Dfh6aUhR+9bpScKc/++cRYFWzmZn3XRBpkF1Iqfjt1uu2n+WLkZIbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:43:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:43:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH 1/2] selftests/mm: Add -Wunreachable-code and fix warnings
Date: Mon, 15 Sep 2025 11:43:51 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <DFA3B46F-F29B-4A74-9684-51A10692B97A@nvidia.com>
In-Reply-To: <20250912123025.1271051-2-usama.anjum@collabora.com>
References: <20250912123025.1271051-1-usama.anjum@collabora.com>
 <20250912123025.1271051-2-usama.anjum@collabora.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 11949a40-9178-49ff-0467-08ddf46eacf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBM2rn5pcRYpyM0PgWP+rSwsLsTLjnHxqTtAXTXoiIIOzklW1J7Yx2TZxOAj?=
 =?us-ascii?Q?lP4iz0oahHyozQdLvjXW6agrkPRN/gcEEkahtkV79DNZIA8M8Q6nUDhODs8C?=
 =?us-ascii?Q?UjPlVHlRUxpqqjIpEMdilOG4i4v4pHbb5PvtO3wb9EZf4VnEr+DUBHINE7Jx?=
 =?us-ascii?Q?L8YJCxnMwAUM/dQtpEomQzRAzNIyZO2Jbhg4RLuhR+vnTi1brmzWThNI3Ysc?=
 =?us-ascii?Q?ZkScz7ckiInE1v/5XaEAZ+OMzDMRM3NItdv+i5RRNIuOKynxP4XsasDbPF2D?=
 =?us-ascii?Q?OHEfKVN99U9Lqpe1hH36YgcG9/jFpWKziCNFTbrCtlww+uTptg2A5EqhP2Ky?=
 =?us-ascii?Q?o3T1zFPxvMQNmts/U4FY6Lw6JX3lgZuXEf/tLMUK2ShGfPFuK842yfhSsfgv?=
 =?us-ascii?Q?8sCDIiHkQabEh0810wrvBFwawJ0c/amnnTfDuiRFYFGNQzC5eTu4adzy3xnz?=
 =?us-ascii?Q?5IhVyP5apivPYXl8CWG+LCdDC5mYi/seGLlomoYK/LP3k4OL2XFOR1Gaf8lr?=
 =?us-ascii?Q?Vw9NFFVLU1UoCzbuaslwGponPVKAQfvoqlXI5LdI7cdT9Sv0hy0J6fWugoLM?=
 =?us-ascii?Q?q5rNeTUT2i5BWRVkZQQxDDqkiPwk0wB5O4F+F/etarZ338vCsOM7AlQPtLRs?=
 =?us-ascii?Q?CTNTREIqIIhksjsHIERVxjJkKGe6cNUZVUG3KiVfKRMGeQr4ncpDeXKJuuHJ?=
 =?us-ascii?Q?3EXDsLS4+uAbogrVbjzoGS9PJ+DBtPDogRMED3gCHcnqsnouo3gl83X0hGQ5?=
 =?us-ascii?Q?lTLav8SkBEtHNYpFR6sG6pvqJ8tyPY8TragHlaeritTjEGb0Iw+rrOAChz6l?=
 =?us-ascii?Q?RdXBk8fP0wNLN60I7FxzRhpM+lAg4sOUzjL4pySTIvnWK/AygnPS0iuSWpMd?=
 =?us-ascii?Q?jvFGvN32E8nz63tFb+WkIlYBmwVSfSkOwvZe3as6wSHP8ca3lSYFgZZjx3zw?=
 =?us-ascii?Q?7DZfXI8/70ekeD9JBrcTWqoX9J/lwQ0Pnznh66UQkF63mmCeJ8alZ1IWjSgo?=
 =?us-ascii?Q?zxuJ7gclmZGqTfuX7Bb5UCJO4+7HkaL0kpToC1g27v7a7bsTL/mQbLL3GXkq?=
 =?us-ascii?Q?i1GAGfaEiZF0EwjlnuwEyWr6IxpE3ZKgl1zqTYllfFgka/aEz9crVYQ1ayOx?=
 =?us-ascii?Q?n/+m6bsXyLOhCHUHYlIvJf1kLtcxU4blPIbQR3jHsL9r3BFwJ4giEuTEDNVu?=
 =?us-ascii?Q?Nzmv0mC/ut0Zl/SEDuurNwe5SutY+5D56hLalEr4AGXYDV/5Ni3V3WPlL/kU?=
 =?us-ascii?Q?tjiuIFT7lHzVVkRhyXOmkLVefz1N1PeYm3+34r+Y+WksxQ8wZRrb/Bk0WNQV?=
 =?us-ascii?Q?WzB1r5LogKDziMGxJrK6c8eCKBZxOLjPcDTD2QEGuMCCIePvoM2dKiheokqp?=
 =?us-ascii?Q?QeFkPTYSC1SVgiZd1zTfbtvt+/Tv3OlQV1eEayyKDwO5pjTuEKLNbtonZvcq?=
 =?us-ascii?Q?rwYdwDP1qbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dD0b5iHTPU0WVo98AIJFvpXFVHd+s1TIIxEa581nyHMl5FIPWOdBoNaYtenL?=
 =?us-ascii?Q?xUeEUbyDW966CTSwtcD+48k6vuTnYp+vA4vNUYhJH6RfLDRKLur3NBjgrlqr?=
 =?us-ascii?Q?JcmNspTwFM6qN8QNk19BBnCMY3NzZtwv/ydbzJNYYX7l57Ili5E64U8S6VpX?=
 =?us-ascii?Q?pFbQ2AKJnNCMoyk8cW2D3vL0sYH5KBs/ySnXIQuMJD1BAbOWT1xgff3fq2ML?=
 =?us-ascii?Q?4x6WqS8EQCIx2MyEiZG2DgI7lv4ZSP8eYZKVzlkfCB8XF0HX4Dvb2BHJEf9u?=
 =?us-ascii?Q?sowY5ckXe6d67XJIGfgH+Qsw5lN8an9EvMbXLyezgEnq43idmlurw60YOeax?=
 =?us-ascii?Q?oNCJg7i3gSEA0x+k6Vgg/xsoUyFiuHpcYCLCLxIcYop/WVhU3GlL6YTCKi5V?=
 =?us-ascii?Q?timVoPnsi/ufwi24Igr8AeeJvBgFQOesbUdopOsyKHcOvnl+MNrk6Zduq1H5?=
 =?us-ascii?Q?goIVHV2kkAOa8R5vnIXWxu2QdzRhV3lkZH5SUzDJgOZL8weYDbPGX2swvP8h?=
 =?us-ascii?Q?pNcYBe+CtBz7/XAvoiFG9B2L7nm5H+P4xDgjqfWtY4pZEoD/ukOtKB1d/Z+y?=
 =?us-ascii?Q?v7YTmWARYc2u79UnJMSGb8sjYZinevrzzBVva/Xps/Lxh/nHY9B9OE3bWaC1?=
 =?us-ascii?Q?OkgFUDu2easKrj86LciFdYCa6o9jGtUfZw0VGwf+7n5OeyKoSqdv9ZkUWyk/?=
 =?us-ascii?Q?T44/j93qxwVDjbma4xsBMQyRwkjLlcDyfYCCvjnBUyNymMOnkC63NyHD7Lde?=
 =?us-ascii?Q?XeJYwmDaveB2pd/hxEQ2eruzJ1hwgKAjR9Pm04A+Hok4PRQgRvpr32+NhvB4?=
 =?us-ascii?Q?b6dfGFLaPfN4khFlZoc9vyxazHRC1xitwNd3ZW4VW0G/Um56falWiY+DasFr?=
 =?us-ascii?Q?l2arMEzH0rGrFlHKfvaTNPVyJtCLosF0MTSYOG8zB53QRNlRnrwPszY9HZLR?=
 =?us-ascii?Q?OyFlP9mDkGGmHxFN4CQ5wgen1ENkWQX2hsaRBDJHCc24ce5orr114OkO7kXk?=
 =?us-ascii?Q?i+wSI18Pq/4HCJ7bZ3pc1lV7UsZLbBqlzxdWHv7h0qvDaUFKJgn/oWvb81mm?=
 =?us-ascii?Q?tkIx9hrZEV6JJHKdEfpkPC+LH3jlI19uo6U1Ok3VOeYF7anvPOysR2v+laZq?=
 =?us-ascii?Q?E8te0vbakwrvJo1FIdTbdwGz+yazjjGrN/Nelp+9CcmzOnwZvy7G2oohz+A1?=
 =?us-ascii?Q?HlRvFpcHGwgcfFN1Vdj7vICcpKBSn35e0TisltkQsu9B6krFagHH6bEgIORO?=
 =?us-ascii?Q?TMIQmF+GkG0dtAF0HhaaUnmyWJSM6PJeSYx7LLphJh6QYpRpIm/xDuXeoXyU?=
 =?us-ascii?Q?AuvG3P+QkFsla821Ov7yI/WFKNQMX+Y3Qvu2gVTsKIlN2hZifo7kBc5wZ/A6?=
 =?us-ascii?Q?qru3lDCwS4/KnzKXEKIb5XYKkx2uZhTSCOwCRD1+7r54QO1VgccwkZ1RyLTA?=
 =?us-ascii?Q?nTWUZhRLnRyLVFTqhrtlF296XgMtUe6WBs+uy0Wc9H0xW/v6ejeQfizPKRe1?=
 =?us-ascii?Q?pbcZvMrIT1QW9iqFkzwoEnearukxh64u4sVsIyZDUyndsk7T03hlaVgWSUvb?=
 =?us-ascii?Q?ToQip6T29zoZA/Sq45p4Qn0+OZY3adc6svpnC9Vm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11949a40-9178-49ff-0467-08ddf46eacf4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:43:54.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLh6q4rNLdwqgPIYGUwaS62eVFBFst62fb4xwo5UV571mzyELLzFPov42kAXi6dy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On 12 Sep 2025, at 8:30, Muhammad Usama Anjum wrote:

> Enable -Wunreachable-code flag to catch dead code and fix them.
>
> 1. Remove the dead code and write a comment instead:
> hmm-tests.c:2033:3: warning: code will never be executed
> [-Wunreachable-code]
>                 perror("Should not reach this\n");
>                 ^~~~~~
>
> 2. ksft_exit_fail_msg() calls exit(). So cleanup isn't done. Replace it
>    with ksft_print_msg().
> split_huge_page_test.c:301:3: warning: code will never be executed
> [-Wunreachable-code]
>                 goto cleanup;
>                 ^~~~~~~~~~~~
>
> 3. Remove duplicate inline.
> pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
> specifier [-Wduplicate-decl-specifier]
> static inline __always_inline
>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/Makefile                | 1 +
>  tools/testing/selftests/mm/hmm-tests.c             | 5 ++---
>  tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
>  tools/testing/selftests/mm/split_huge_page_test.c  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

