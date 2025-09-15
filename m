Return-Path: <linux-kselftest+bounces-41508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409DB5810D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF444E2252
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C08217F56;
	Mon, 15 Sep 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLvV3nKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3551F37D3;
	Mon, 15 Sep 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950991; cv=fail; b=cbBT9pPsKDW1JhOcJTopCNpR+LhyNzJLO15hix8gFyEvgkxBR3Q1RpCfZ/pSYKD+2JNM6/iw6v5Z2SZWTC17KiNNJsSElq6KFPUZyBXCFUOy0L1m6MTXkeoeUrFJpjSZbBFl8MpYjLEy+f3ehisYQzLdPixfLd/x0W8ywy0eVAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950991; c=relaxed/simple;
	bh=drCie79hy0KSrNPeeywHo4KnbkvUaW+yC0QZje/ZMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9nRl1LAHvfM2gHu/psmu1Q2Boglawu8jiuyBnXsWp2VzjpDGz0gactg75FKykbWazOePjSUYftpN3Q8ZtUUycBGATuLVQ3PQP6yk3k0Izgyu5NSmIH1rvEKo9+XWEtA9aQIe9EcMD9q+qMvAqGY74Nixve1rhpAQwnwLiZBBGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QLvV3nKk; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnLIOuSgh7A9MMD72ON8nB1XF31uqeX5v88D/facbEw1ylGTvybW80Dn5hwdPrh8tG2/cVmRe8uOivhDGpgbsLQqA25p0hzVJyOGnib6RWoxU4wODBSX5kQOTK/H3Tv1B9cH6PGSwdDxRP3bJ8DjaGX8xQSwO/FY8kI6PySoLt5tORUQ9V3t1dsE+5MqoyIUxFjK33Bjh12bRgSXO8jb1HshBE2jt1IxSKolKNMA26ZGsIzdI+Osquqylwy5JjrP435EBtDP59knZMptsAQK7gGARc9HkiAnLWhgHsLsP8YPoGKtxxxtFFHRWb7eEfluMfcM1+/Uu9hC8CEkRBBMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqN1cuflBe1KfAsjSmv5jFx3bnWan+yMBJmBafZpYYQ=;
 b=A1Y4wBWfrZLDFsKscgvm2STw9WvmkCxMToD/mPW7+iClXWgsWugpXJYheQcEioOF141gWN2oPKM2FVfGLMzSv3QgaH395dmyd7jAoNZJGaI9Uacl4PaxjAQEVx8t4N2lFtNnJpEI6tFSZjT7IJFRtyN4sAibIohG43svGB7YnKs+pLoAM3K/xj6yVvvZ7uZzCN/+ypihOijXmGUWcIXRgUsdeRY0QwqHh6W2qnlYzQUy+Up5ObPQ2nc2wLpx4J+2+VqjGAFcRQoWZSCUgTR96gOVNUmISuPT2HDwob6w0BV1c+g756+nQaJ4CppHiNuqTT5mUFYBBBloD9mozYw2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqN1cuflBe1KfAsjSmv5jFx3bnWan+yMBJmBafZpYYQ=;
 b=QLvV3nKkAMwgcG1UnzInpq3GPy8zuY72abECrNdRrKlcr+3MbpgUaBzIaPj798+N6rx3wfTaOFV7f2fICPAe8QJElktqDAHuIOB92EGfVbwRvUIEn2t0aEYBusXNSrTgWgUUWoV+qWYgNWBU/o77gDR8IoHAYagF3mQpMWLfRrk0pvdw0UkCG2fqdFylz02JS7fkbLwqYhBs1P6t2eDaK/OnM+u1Y4yYDfWUz7yv1FCmscsCDPnZ0QE2sVD+tGj9zs10fpSHUr0OIEw6xoDutGWnUrehhITG2LyOC/3uapKOQvEdyHVhZiKWhYKfk7dtgESqmYkjMBEtEsPWZ4JTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:43:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:43:06 +0000
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
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 2/2] selftests/mm: protection_keys: Fix dead code
Date: Mon, 15 Sep 2025 11:43:03 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <8BE96B0B-01DB-4629-A671-044E74680F1E@nvidia.com>
In-Reply-To: <20250912123025.1271051-3-usama.anjum@collabora.com>
References: <20250912123025.1271051-1-usama.anjum@collabora.com>
 <20250912123025.1271051-3-usama.anjum@collabora.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b3a4f9-5a20-46c4-3d2d-08ddf46e903a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VmIZzO036roLYCaIWPt8iWsFxge06w793UZxknSNMXNt30T7pFH/u5bV2Cr?=
 =?us-ascii?Q?bGVZiAJ6PwXZGEejjqE6pP8DkZ0/jBbZZBcAmYz5zMJWz75hDUZScfFpScdQ?=
 =?us-ascii?Q?kC6qRxejamN4kSXYdDiNQ8CoG2SvUE3O17WBczZw5IY8KBK4Gicg+O2qfQeD?=
 =?us-ascii?Q?U/lQ2Tr9TvuAOKKyv3xS9yhxYhFnOURbJ+jaUuIQkO4kJtQuxlRrZonqk0v/?=
 =?us-ascii?Q?5wV6oAlhttFn+sbsUiG2ng82kBrkzfOJKKbXigeGnzJaVflHbKTcyCPZrdRj?=
 =?us-ascii?Q?/LjNDjONYPqrKTGX7LgQAK1tn8L1aNUZbhzoLSGHIou4lbieDKs517hElroN?=
 =?us-ascii?Q?yzDIHR/g0MQHqvUHG0ezOLjZYhWduJDB5VWbFwIyo5rhbuI4kgN/yv3QMAY5?=
 =?us-ascii?Q?tzq/RflD/g12bvyZEuW7L2GwqO4GKeN+UjVIEIz6ookl6xBaQ0t+gVsdwh1T?=
 =?us-ascii?Q?bCJ7pi7Xf5cBKeQmuS6Esit5N6qFcX2Cyg/bE+R4gEXT3u+sNksJyq3M4zmS?=
 =?us-ascii?Q?n4RlAmrp1SZgOvEaG0oWBIKh2taTvlH1gLNgC9AFjEVXtH+UG+kniLMEHYJE?=
 =?us-ascii?Q?elWmALU8RpXxSjgTcG0kYsJsMcPoWzBSS++ySEQiSXqXwceBGy4L+XjOGlJ7?=
 =?us-ascii?Q?wmtrb9phQgdqXkACuuPWNId4poq+CwLa6O+oURM3hl4K+BapBSr5bE8aWc7Y?=
 =?us-ascii?Q?xi2KExpkSRoEPDLEI75V5P4Cf/bZTyLxbB8QMwFSF09xUPh6FsjmQ2Yw+CiW?=
 =?us-ascii?Q?ieCDO138pYdwkWph0leFg2CWAq90ha5Z+WEQjcN/45G/6GwNoFqnxg715Zrd?=
 =?us-ascii?Q?QNzJuMmtcxJSBKuBmRzP/ayHJbwmBtA3PVZ0Yom/OLTUa8/uwMEeDdcMk4Cq?=
 =?us-ascii?Q?WBHfdwULd9IYBiy3RaA9Qp1Z/+F8XtW7+Vyd/fttagRoI4zHjN0sAXi0YQ5n?=
 =?us-ascii?Q?Whr7AE2RhwNgoN/DbV8enQGJ+EXLwhvHUJzVegL6n1qrRCA7SYzJ4MBQ2fEI?=
 =?us-ascii?Q?xSENDuGXNYYKzEcYKCiEEkqaomfZaCAc6EmvrnaYp4a47gtPySlMkij1E7j7?=
 =?us-ascii?Q?dkYcfOeaujjurEeGWxiPkkntBjWJXaVBFTRE7kyOA9LdVtv16DBkL3Hxv2LU?=
 =?us-ascii?Q?0mOBZ/LF9aehG2l8pL3/aAjEHiCZH5aljjAZ7plYe24/sH9+B9FOj3ZhVzL4?=
 =?us-ascii?Q?VAyPDlHAm/Q5oCW2Xhz+FdFyW0tl1si9mdw06f+3Fd5UBv+1TUwCYFOeonD0?=
 =?us-ascii?Q?fsN8Ukfk29o4agupcyDdSHuG4au5S9sbtHLFdAb0WFbNARi3F0eRZqR+7OXx?=
 =?us-ascii?Q?roMg4shvJXdtmh384NQtTuxjQYWZRdh6Y2X6A1smwbDI9m+9K6bCi8LwAtVJ?=
 =?us-ascii?Q?pZBGdVlydw4PLT9RNK+CNSSCAonw13MKVe0BHa9po475uQ3Fj5HaL6A/5ghQ?=
 =?us-ascii?Q?GlAs2Tf+mIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXAfmOrBygkC67Uqbhgqrg1B9TAy9N3a3Y7RwscabHSYGvmDwUAkMZ3OoX3h?=
 =?us-ascii?Q?YwiTAGG+UA0usrO4uczKKFDgpNatlzGHoW5O3+Ye3Vjb/YBvLZ703caHlNzf?=
 =?us-ascii?Q?S74VsPZ1AuQ9pP1QzxBMTwwONVR6m84R6C6EZ2Ag3amG2vWEm7R1Gn12Jniw?=
 =?us-ascii?Q?PSDiGHhBwVqN7MC3Mk0UgtfHDq9Oey2014h3b50yJ7FrGUopPJ1YDbZA+rHl?=
 =?us-ascii?Q?jkFXkGJ3AeayYInp7bmHytYvCgBYYef45nPY6JM4AB6AD+BUlwXmBTjHmcaa?=
 =?us-ascii?Q?ioQBSd5wZgl12xZZTjdNhKLBFHhi2jz5jmHt8hxf3iNJF6j+nGL5Askjca8c?=
 =?us-ascii?Q?kjEKeSohLCxqqVnyOK6HquphlgyiUsmghWuf920rMeP0loe+1pr3g8REzqpf?=
 =?us-ascii?Q?ZmycMXwWIKFOMrrnKHqWTiOxtDg/8g1V1kU/bLSRgmbnQwb940jPBKNX9I6h?=
 =?us-ascii?Q?HVIDaBBjQ0cqb6FvpqU588dt3D1Al6NRE24MKHmxX9k1nUhPRiyruxRpM34s?=
 =?us-ascii?Q?0DE1wxhaKCJBoVJzkp/HM42rWWiDVLoGC2wZhc1RAVGhGjjSttiwXvTx+6Fy?=
 =?us-ascii?Q?ktASSQ0LnWP1UT+qjP8pGEQ9haD3MK+VejMLNhNrQEPkpkEAKAxKWN1S6fGL?=
 =?us-ascii?Q?F01URq+lfhJrreie8n84J/ixNSecUV3itGDGX6SnI41Vzustg0NltP3IH8f2?=
 =?us-ascii?Q?2k51gW4oqRSLCabJGwiaM2zdZeSenjZi+YVxU/erEFhKR8mocEJieRfVJKbk?=
 =?us-ascii?Q?hwlR4xNTrj9r29rvxxPh18R4EJ1c3iiSth/SkIj4NI//TbXjnJE6ZiNj8vt3?=
 =?us-ascii?Q?d/MqVN145GOd72AkErAHDJRA4EdFGB1GEBz9zAcZBFEX1/o5fGf6MLqddoKn?=
 =?us-ascii?Q?f/DhJqob1w83/DNjBuT0UsLD0BkwAJ84nKX1brGXTSY6eJISmRaUmgAY9MT/?=
 =?us-ascii?Q?yRsamnfIk/eyttA4l97Lik72XKjzXLvCehqjKqnaQZoaM6dcErf0ZfzidwnG?=
 =?us-ascii?Q?rFa/8Zp78iUjcwsVwbEZFY/mr0BR6mG4OjZ3bBJJD+4FIyduLmOlN8BflkpI?=
 =?us-ascii?Q?4RZWkgA+AuqzmO3nsXNhTicCBDOXEEx9fdxzMuFbF6AWbsEtNH4YNuLKjaHr?=
 =?us-ascii?Q?z+lhWAzERAun0XZUlSHRLVRR3nM1byxCmTGtqcKrp6MydBscXXH+XpPlGDZR?=
 =?us-ascii?Q?mv5KkwaXlFEK2wz8T5v4gTdkS+Q4DUll1g2iDdhN9qUs2i7kuUsnMSwlZ5gY?=
 =?us-ascii?Q?yTO4OmDpocBD0nCo4BA7XEDXpfRjb7fGylbrDUmF8/6Mzwzycp04kALhP3bQ?=
 =?us-ascii?Q?+yiufaF83/UnVrsF7k7fGi2tbl4flTTuRZeVRoMXsetiGdGqzR8aX7QDSX3v?=
 =?us-ascii?Q?jL+TyFax2cqN26tRlMhi52qKUjouJrdpEMT4MjHcfuF9pqO2bOmCn8gyJBog?=
 =?us-ascii?Q?8f5RqB+qB4LXe6PQ00gZvh3KLX9fR3UtKoxY5/uHMDnn5Exc9TME5XEEZFYE?=
 =?us-ascii?Q?7bdr7fD4PFbaD9Yk6OfM945vtsQX70iBsOAMJUA2CVo5Y9cizwEQ+UVCSlC4?=
 =?us-ascii?Q?QngQ7uVRioeoqttJEcs9k5cExxD+JntJuyix0iiO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3a4f9-5a20-46c4-3d2d-08ddf46e903a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:43:06.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5SVs7e+0PRGctUkXB29Bu5xCXqcaqYcYbSIdiuIhLtdET6htcl85jqkg9Is8bQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On 12 Sep 2025, at 8:30, Muhammad Usama Anjum wrote:

> The while loop doesn't execute and following warning gets generated:
>
> protection_keys.c:561:15: warning: code will never be executed
> [-Wunreachable-code]
>                 int rpkey = alloc_random_pkey();
>
> Let's enable the while loop such that it gets executed nr_iterations
> times. Simplify the code a bit as well.
>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/protection_keys.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

