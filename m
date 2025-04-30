Return-Path: <linux-kselftest+bounces-32047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D39AA5568
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 22:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACBF9C199B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D0227A91F;
	Wed, 30 Apr 2025 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCkxg9GY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADB20C47B;
	Wed, 30 Apr 2025 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746044121; cv=fail; b=bIKq5Tyeybe+3RfsRLfd2LrffL+LMsj2nhfCuTQbrzEJkZ1pVDJYuhycBsCRLNTNOgs1VIpgxEbGqBc8aRElLoBDmKGNrPq7RcqaBMM+yDJYz7xjjA5I5Kmo0KWCU8grpo3AdCU0cwfMzio2VMUmXAIXKoSfDh5oGz/5NzEfPZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746044121; c=relaxed/simple;
	bh=5KogXWTYC2tdghUArA6BvrKsm0s6SjbJ5/PhqzNjOE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gteuq84Z2VtcZaXIO0oZcBQ7xZKR/PW70O+L6nRsQqa8oAoVdZ7nCTwOJsnRJ6Nl7rMNIIkChS3WC2DN5shHnEKm1W+ugwOy6bbe4ptuusM96M0F8M68RydvtrI+SOI7rkobi2sinHjK6GYmKUO32StjrfDwoke8W+L82HpDdLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tCkxg9GY; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCBX1NINjc6RmC/7Qxmf1jVffa4I5tJAL8ct7ZIZQ9Gg4wZrynpjWCvyPwm8etkmzSihx+fTdBOzGiiuuac6/zHthjNazSW7zV5hDUFEU+/h8uR7JXtD+kLOCqHcix/v7cxWnYFU2RrpT7tgnI0kFaalvDU4A5+v20aM1HcV6+CAEm6GwTCj97BhS3Gw7GlxINWQsFUp9ZY72VNSRTe+bzYixrrpkwJo2WCNPWltVqY3sxXVTcpf0oiUwZy17MTwFJdzhQSq/zuKxWoPciU/gcvMcVMnPil9iwrgdmdi5FxJfgUmbf0bD6Mf0p2WcMmxAISnK9HHhPDKwQfD/0pRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApeMSxGFcFJyUVDmj3o8f/THIAERWJDCsxWcRR9wXjQ=;
 b=QVKNqGQwYE8NtMcRhaTdndt6zcBWOj+Lj0GV+QRHk9M6CBKT/6RQEzkxu4yzUZFyh6FV0jhWfVdhtZeTZOYGPeXJcP4xFc2XKLAqNYI4aM/6n5yFrxIQfQBUUqz62L5Ne0dm450jqNCMQO/wYerTeIUUT9RPioubUXzXwRVMRL2QGuYPSQd6N9Ps4ydvpXfEkm7toSkYZWQIC9Op/BGYgHxU67x8zBbQ1CFs5K75CpKo/4QAyqOg9fuVns6MfthN8eadrLu5xth+XYrUNvfeyW8/PgE4ghxVgyC/U6lonJ9+u3dNxsq8TuBRgDkK/tQ6isqmwZQo9vKGrtZmkkz36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApeMSxGFcFJyUVDmj3o8f/THIAERWJDCsxWcRR9wXjQ=;
 b=tCkxg9GYdvxn46hvMXLC79GUzwMDbakywUb/11REOxTOn8YwIkeu7ZPxitwXO6RbHvMWTi4Yot7jCvhOt8gfnustDU5aq7p3Xf1rE+IImwYuCzyRGv7a3HLRnJq7z6zKxylJCDZ/SJOV6fgB+WNxRDM8enwRfEO6yCdL44ZOPmT111IIWoamDbI88IcJxBvNrABznRQNrUwUHcIrE1sAOR/yIhFblEHjly05scFIMWh5GcFAbOjXESrZO1daD1N5SmBgYweilJa6H/m1TG5AgR0RRwaIqmnx3bCpprhtWkMZ+fVKuzBP1rN/ytkokoNyTJ5bzI4RPU+FyzVjc++kmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 20:15:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 20:15:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, shuah@kernel.org,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, hannes@cmpxchg.org,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 2/4] mm: document (m)THP defer usage
Date: Wed, 30 Apr 2025 16:15:12 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <C7A07691-E8D8-436F-AEED-8825608880CE@nvidia.com>
In-Reply-To: <20250428182904.93989-3-npache@redhat.com>
References: <20250428182904.93989-1-npache@redhat.com>
 <20250428182904.93989-3-npache@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:208:32f::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: ed59946f-59ed-4ec6-7911-08dd8823b899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2z4Hc7FtPiYqmOKgpbCJKbSwIKATfgVKsaTFhOFpQOvuDiSm6VfiQPEL53M?=
 =?us-ascii?Q?X2CUq7YTblgy+UXvO8Xz1u4v1vT6YMXnbK/YmDYR6jFQpdGHY9nWM5kfmJV+?=
 =?us-ascii?Q?7+Wi2UcYlY5Lam614JYTFpDLJXl3oGyO2DPcUPFrJCz7SLReVyjSTT6geK5A?=
 =?us-ascii?Q?YrCKs0wfLSQ9eqHTimvzEjxi2k3QwjNj30NGhzeR3rGjq153hpr2nbs6+6PB?=
 =?us-ascii?Q?ZjeWgJ1heSDMD32raRM4erjcR1Duz62w4j7nAMmw6icTfVid4KHhJsse721d?=
 =?us-ascii?Q?XNPP+ooGI5K2AAcefIVI5yQ7g36yIKdBxyFj06rDLoNo6/cNKQ1XowWiihbt?=
 =?us-ascii?Q?izw0PTrRoB66Mn9joxeKiNliud/Qr2YHqS+xi3Oud6zjfim2zpMkUvEwMRJi?=
 =?us-ascii?Q?H+v4xJc0IYakmOCSs7J9Tr4THF3zhlnwEGY0xMQ26ATGJrzdOceklr3qeAJK?=
 =?us-ascii?Q?zxnHeL/psQjV/WUShPE4j94ORSwbgQySCDwr0w2wOmI/kvw9d7PqXRn80FPb?=
 =?us-ascii?Q?PxVDNMUI9W1AD4dmSzSHxTaUK3GMK/ffYCfxthkw0ObJwePlvlkPuQx1J2gL?=
 =?us-ascii?Q?haAE5NGjhqe25ALVnXHePgPbJbfoo4rfQZXyvmbMgNYIxf2tvne8x95XsycO?=
 =?us-ascii?Q?ecKIx85DEJaSOOCLzAsIJHfY0xG3ENocwsYwloNAB172orrwGFIyUGiB+x2z?=
 =?us-ascii?Q?St6lATInf2JfGVZTt1vxK5F5j7hUAXWLwLcPybpx/iQxN6g+iMJJfH6UePIN?=
 =?us-ascii?Q?gqefdt+10dvAmOqp/Q4QCydilEXP2v8KFkNlmlHLY7oO3vskinVRBfDKWohB?=
 =?us-ascii?Q?Ie673a4f6hTtYHWP7B5ArfoUB+WWJvvRo+EXnY+L2gWzr54rtNvSHwbZwb7g?=
 =?us-ascii?Q?PqvASxXZfltbWKVFup6WywmT6TaGPbw6bdCLh70hxzympL43uNJdPF177bSH?=
 =?us-ascii?Q?HqQYwGv60JD07+RUr8ESHJafmXS/ddCTitggbMsDMC2iVUrVhYd7gcIzUGcg?=
 =?us-ascii?Q?1SP2psutTh5XMt7g6Xv85QCZr+xabNxGv7wvfiIHPkjYk8fPwKc2oC7KuDvW?=
 =?us-ascii?Q?dufv/GgaWYdHohZ3KdXJN9INGDir3uvMYNqHj3Yzue8V4GmVEjBYini9Y2cB?=
 =?us-ascii?Q?mkLIjCObe4zAFb5IVH4HCijIv1sAYgBypEXWdTdt/ll4qYkBebXanj+W2HZH?=
 =?us-ascii?Q?5QhpMEYDrLoWw+MpI3x6cVMwZnQeM5xxxx1JN1y9ClfIju+wde2P3PB3bFmH?=
 =?us-ascii?Q?v0v4tKKMJx8GHXwUzzSUF+BfLTs71h+Ukqjr79UDskxrAfGVOcgupyH5DVgd?=
 =?us-ascii?Q?j9fXTOljGPPF2k4u9mRhL5dzA/X7WqjlN/CjN5k4FbwMGsIYy4mvl7VraeNn?=
 =?us-ascii?Q?1Ga55GYrabTiQARXxeYwGv1l5lxeqZ/xIQH3K9ptXLgMs+BWXnJS4qwoVAQL?=
 =?us-ascii?Q?SgbGvDeHz6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5rseGkCBujDosb1A5RBpz9NdZ/DaS09Q7L9Mn4Jj75pXkz7h9/gBG6GLtED?=
 =?us-ascii?Q?Q8iPcTm6RzwI+Jpmopa6ZckepsZaG9XGqh8itN1XM3T8+BciLD9S6o8bDR10?=
 =?us-ascii?Q?PXpBrJ2WdmCeamZ7uqcZBRb5QNo9UuTtAWgwmUtgbGO9bRcEs3i2rx4Bsqr3?=
 =?us-ascii?Q?9XwENNJRTpXz4IS3voCN4Po89vw3CKERXAR7xbPGHe5p495oO4Tq3ThvxLhu?=
 =?us-ascii?Q?6+LTWudLrpOO769g9YNjiSFSzOhSebkc00u0HsX3NPMMJyaUvBm6WpCMYJ+i?=
 =?us-ascii?Q?1rf81Woh5U6kpKvAFYQ/9X73LX7BRiHQ9oW4UjiIhWQSxwuhJva4DwqHxdnL?=
 =?us-ascii?Q?ToSMUTnokCtdfY5+jrspfkqjbFxjFwx5lNUPe5L+6X2LI7lT4/7hnfThg/xI?=
 =?us-ascii?Q?Q5VXBtX7z8T5uwjH2nXvvyuRTu925w95pYFN8Wr/1zW7DkQHVLCoWNbdLVlf?=
 =?us-ascii?Q?HFibz8wyg16JndUje72XrIfSSrHhF0ftsITbzObWwdDDqZaq0XYxpW5XwElx?=
 =?us-ascii?Q?KXPEEnVN2IAH6PjUW25tMbLESD7JVfWGSh9lCBk13f2tOOjaVj1PTMo/T4Y3?=
 =?us-ascii?Q?i5JSDxkeLWC7V2bnEhndIUVQmptKeTRvvxzfoPme0jBzPl/k6NFKhyV2441c?=
 =?us-ascii?Q?lJILKJLaE53qCz0/LPiJvye869fF4aFWrPmTljGhKNlnOIMvCKrrPjbGZVdQ?=
 =?us-ascii?Q?sIZWZO8XFJ+n0X/Q3RZWg0VpF6rG5zV3xWmg6mvGbBd0m07jjVnpNtxvlWsU?=
 =?us-ascii?Q?fOohcensoJ9kMbTEQU+BVpBxt1yTpqng/mwFGEAY5Dq1acUmFYHzEkRYPIgC?=
 =?us-ascii?Q?LNF2Oky2yuHHbqr8sm7PYm0BsCwGIvml1uJPUiItOVxAu08g02MfO9bIxLEQ?=
 =?us-ascii?Q?sDroGb+6tLvpHW9v3t0c2OYgzkJ/ca30l0qd3U9I9CAwBkMcjcooNa6/doKb?=
 =?us-ascii?Q?zmUjv0EKdhOOdRwt97PpgMJ8B0V5wJvVpT7G3Vbp2xFDM2TCwSG3pTIYATVY?=
 =?us-ascii?Q?AtvsbSugfCpTOvLvK7RNwG9oJbzTLf4CwwP3yyUnCZZlJheDbhb2ncvEIs5D?=
 =?us-ascii?Q?mBMqDOKsdKfO480pUVLj/ZsiGJ7eNuT+x6FwdFLDUhsNBsSdnZcM43mnj1IR?=
 =?us-ascii?Q?Etf6E87PKB0NET7buNISPTO6WhFkqIbZLdCsl//aLIkTEKI4BoGQItDcWDsY?=
 =?us-ascii?Q?YGuZU4/SpyDHNvcRIZbhw4Jf3wit9zhECdN/b8aaYY2L+O2ogyvow//h34T1?=
 =?us-ascii?Q?Dnlh5CRxKZzQbiF3OufI1Qi7JOwrZWp5v7w/U4qoRKBk04CG8SD83UI09DKV?=
 =?us-ascii?Q?2y8oQm/rljIragNoVm4D1SDHaSo9+6qEphOlYnnUrwcdmvrZBCo5Fmfu5AVH?=
 =?us-ascii?Q?sZLwe14s4qatXka3Fcz9Z839SDynFz7AmnXbx+qR/ZOllWIzRhWF7FRjMbyT?=
 =?us-ascii?Q?763EhyQJBExo8Ni/oRg/G3qbaAe4dUfafgqP+qh30HxibaCbas5S0FtS0PGr?=
 =?us-ascii?Q?CS2N9Uo6zBGy11o36nJZGV6PhxbWXIKFlEVuIfGB1ihSn570oIh9lSv1PVan?=
 =?us-ascii?Q?Q3mMPsXT1Ffk2GD9eoSpTvJOsHaGayywevDH+2LY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed59946f-59ed-4ec6-7911-08dd8823b899
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:15:16.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqqDQwghdwhG3+n4Tbn7/qP4RFkyRtI/QDRiiGmc+fDIAV8X+eTyj0C5CJ4Sj0f5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

On 28 Apr 2025, at 14:29, Nico Pache wrote:

> The new defer option for (m)THPs allows for a more conservative
> approach to (m)THPs. Document its usage in the transhuge admin-guide.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 31 ++++++++++++++++------=

>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> index 5c63fe51b3ad..c50253357793 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wi=
de, application
>  may end up allocating more memory resources. An application may mmap a=

>  large region but only touch 1 byte of it, in that case a 2M page might=

>  be allocated instead of a 4k page for no good. This is why it's
> -possible to disable hugepages system-wide and to only have them inside=

> -MADV_HUGEPAGE madvise regions.
> +possible to disable hugepages system-wide, only have them inside
> +MADV_HUGEPAGE madvise regions, or defer them away from the page fault
> +handler to khugepaged.
>
>  Embedded systems should enable hugepages only inside madvise regions
>  to eliminate any risk of wasting any precious byte of memory and to
> @@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepa=
ges and that don't
>  risk to lose memory by using hugepages, should use
>  madvise(MADV_HUGEPAGE) on their critical mmapped regions.
>
> +Applications that would like to benefit from THPs but would still like=
 a
> +more memory conservative approach can choose 'defer'. This avoids
> +inserting THPs at the page fault handler unless they are MADV_HUGEPAGE=
=2E
> +Khugepaged will then scan the mappings for potential collapses into (m=
)THP

How about the text below? It explicitly states khugepaged behavior.

Khugepaged will then scan all mappings, even those not explicitly marked
with MADV_HUGEPAGE, for potential collapses into (m)THPs.

> +pages. Admins using this the 'defer' setting should consider
> +tweaking khugepaged/max_ptes_none. The current default of 511 may
> +aggressively collapse your PTEs into PMDs. Lower this value to conserv=
e
> +more memory (i.e., max_ptes_none=3D64).
> +
>  .. _thp_sysfs:
>
>  sysfs
> @@ -109,11 +119,14 @@ Global THP controls
>
>  Transparent Hugepage Support for anonymous memory can be entirely disa=
bled
>  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> -regions (to avoid the risk of consuming more memory resources) or enab=
led
> -system wide. This can be achieved per-supported-THP-size with one of::=

> +regions (to avoid the risk of consuming more memory resources), deferr=
ed to
> +khugepaged, or enabled system wide.
> +
> +This can be achieved per-supported-THP-size with one of::
>
>  	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/e=
nabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/=
enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/en=
abled
>  	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/en=
abled
>
>  where <size> is the hugepage size being addressed, the available sizes=

> @@ -136,6 +149,7 @@ The top-level setting (for use with "inherit") can =
be set by issuing
>  one of the following commands::
>
>  	echo always >/sys/kernel/mm/transparent_hugepage/enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/enabled
>
> @@ -286,7 +300,8 @@ of small pages into one large page::
>  A higher value leads to use additional memory for programs.
>  A lower value leads to gain less thp performance. Value of
>  max_ptes_none can waste cpu time very little, you can
> -ignore it.
> +ignore it. Consider lowering this value when using
> +``transparent_hugepage=3Ddefer``
>
>  ``max_ptes_swap`` specifies how many pages can be brought in from
>  swap when collapsing a group of pages into a transparent huge page::
> @@ -311,14 +326,14 @@ Boot parameters
>
>  You can change the sysfs boot time default for the top-level "enabled"=

>  control by passing the parameter ``transparent_hugepage=3Dalways`` or
> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever``=
 to the
> -kernel command line.
> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Ddefer``=
 or
> +``transparent_hugepage=3Dnever`` to the kernel command line.
>
>  Alternatively, each supported anonymous THP size can be controlled by
>  passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size=
>[KMG]:<state>``,
>  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE an=
d
>  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madv=
ise``,
> -``never`` or ``inherit``.
> +``defer``, ``never`` or ``inherit``.
>
>  For example, the following will set 16K, 32K, 64K THP to ``always``,
>  set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M

Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

