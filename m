Return-Path: <linux-kselftest+bounces-38485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98798B1DC2E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A754B726F29
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE223815D;
	Thu,  7 Aug 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phZL2UTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54026A1BE;
	Thu,  7 Aug 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586162; cv=fail; b=SKpLKk/3JreIe2Oat7ZRhfgSipEOGZvefKaoTmj9+iP6Z1aiUDWgdAEoaJH8+qe21dcE/xUetdQG8VHL4pKb/vQ/BmD9yuHJlgbjL5IeMh6aqKXhnm3pwRP7nDbwK0LBx50vCqJMJ6ZZLk5Aekr9QhZDLxB3/e96eioNu/vvSeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586162; c=relaxed/simple;
	bh=619jnH7Y4Ku6nbph4+/5BO8EdoaD0JTqP8Uw4a7mF54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zf4cGPGgK2HhHJbfWRW4phlOoIueEF2QhaocltffS4qEC72uzNxUnO9BbwwVSrHeVPZzoaSYfEH/CkTfhZFTIQHfxR9DYJwkBZE0ps+Z9LfC/QhtmvpLMip1TiAbCjQEx2jbY9ewH6m97BMJ2TfTccPO7rg4PeUL8pRcRe+vMvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phZL2UTK; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7iHmULboGQ3CIZJlnaiSfg66iLvdfmPBU3dR5Y5u+7HGgT4labQbvoHXqNJKInsp4M3Qbqff39id8ROSnlLu0bsUC+gFBgEZwAOwbg9y2V/V8EP27Wvq0IFuzQvRDThMr8Cd6bT1L9JAGhPiY8Zltmxq5CE6+iUIhM7vKxD+qInxJvCgeH8SsNcY3TR7bGa2F0hftDj6aPTNkSZBporUz/YO+8wJkaip9bYFVQssLz0Vhpz/Qfinp7jd3GOYhNfATe+4UpHSDKyX+ywtMweBaVcvPlta59ir1jzdLW9UAbX3Q/I1dI+OvE4yC6rlnEZlQkrnots9LbpqHO0z8VfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpGoIJs7rUC9IK7WzjGH7rQqrnD8R92iJ7efBvY9rZU=;
 b=pFuUXx2Rf+v5rXAn9c0vXTt2gXTiTU9rJRxmhWRq+rXtekE4BMDBIwWAA0aHUJqqm1w1QA5XF/67Nx9LDX04y0Dcu1rpY9K/4nIngEwVYwg3vgklfxMFpnIrMXat8Hs4u8Hfb73/OqhPfP0/YCSMZC2DUfwNWutffUASEPkVudn/FpKiF85Eb+qo1KwyWZbZdOgb4D5RxD+pLBP+NEDEzZ5mZ0YGCfiiju4+zeus6lcHtTEoUKPEnGJ3/kZ2Yhv7HOltMi1no0aRhEFkrLvqdZePEQrZlGLXuQDTamSLou/vnuY4Y/+zI7he/aLi/+PuP9dTRh1qNnDDdiEOcLusqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpGoIJs7rUC9IK7WzjGH7rQqrnD8R92iJ7efBvY9rZU=;
 b=phZL2UTK0NKLI79J5nIM2o5UrbHUI3HXcWB8KSnNpPzSIc/lfxDEG96R99mmljA7/HTSGfAd5fnD6Ba+ct6r8MszGb8MJxHNXop3aKl3a52SmUJ3ksGfzOFFeITnYWX/e7FUqqXXhQerA/T8vXqaNNPP0sq4RHqnaNWElLostutxzqbv/9juyJG9JG+DSKPcIBYFCu1nGcRUXD/1kw00bqF08Mt5V8yjdwt75pG71w1Ru6eiVj13ysLwBg8072DNEJTgkNFybeSzlaODLUwo96aWl7AFcheykO+q8Ayp/9mTFzL5HHYHwx+279PkqmD2PgAswBTGmCktNnquFFhWUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 17:02:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 17:02:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/mm: add check_folio_orders() helper.
Date: Thu, 07 Aug 2025 13:02:31 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <898EC7C6-8AFE-4CED-AED7-C59C5CC03EB6@nvidia.com>
In-Reply-To: <dd2118cd-9209-43d5-9c73-8e3989931841@linux.alibaba.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-4-ziy@nvidia.com>
 <dd2118cd-9209-43d5-9c73-8e3989931841@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: c752f727-d047-4abc-ec05-08ddd5d433e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcct5+RmU7/Xd9UqaCtOnnLTIwbeofMv948H+OR48fpsgBArq57oziz6tGR+?=
 =?us-ascii?Q?AQzGTVGf/l4J/UlKCSD/HTECfyD0IsmCkMdYO/E9y0j3AdC12+5OrwJpi3U9?=
 =?us-ascii?Q?MMSyf+uxmpPQJ3fPtvyd0xXbF4n0qARDvcVv2vHslKc3U/9OeTuoe3f/fXWU?=
 =?us-ascii?Q?AUt961s2cO9ahf3w4s2aKUY2EZ56b6BR5xvu61Vzufp2jYyMH8b7IGSZUBqo?=
 =?us-ascii?Q?Z1frJqwcicFluWHT4md9UwbDvKCCrjcigevQjdBuyGijkBzKBQrHCK0075WK?=
 =?us-ascii?Q?M2ofyw+dAi2e4wDPHjZkzDZW7P3C3R0qqjTaDN8XNGVa7xzMAh2XJ9aRmc8U?=
 =?us-ascii?Q?cZGyFW/K+ZUmEFdQ9zm+CKhROlgUZrZUC/1h3ap4jEOfDfrJ85Iuq2AQww3t?=
 =?us-ascii?Q?sILToaWHDgmkhQGpMl4+pmIJ3tI0lstpC8ozZOgjKEydLFQrEJ30fg1Yiv6P?=
 =?us-ascii?Q?fsVQj4ln4x4glw1JhqJvH0983FEEBO5ZbicBN7D8Iv98k8JXpPZ1PF4QlTab?=
 =?us-ascii?Q?gsCf/aP30438vLg6I9QXxy0RqbO+ztuJ8UZ8pLS7tJrQ3objkC83Sx0W0LWv?=
 =?us-ascii?Q?Nz9W5QMP0r63hKvgXEJ2Sb1EkjW/CIBxV/jU1rZX3yh1BXSBqtUfZDEml3f/?=
 =?us-ascii?Q?RAaRm5uQuaqUsjsbmI32W/AI1PuaYbk7q/120joEFXn40+4SCkoAEyNejGrb?=
 =?us-ascii?Q?YbzSondIOU8fbQo0/BsWSFcELIOSV5T4sHue29KcgRXViNzAKnGf6mpvOzSG?=
 =?us-ascii?Q?TtKMXg3kp8rcrIVtOulu0fKL6o+TPmMk0US4UfRzJB9YPz6VdLlDKT2IR97g?=
 =?us-ascii?Q?DqzmMtI9y2HfCKE48wv7G2ZK8JR2X+iLe3Q+Ga9itRqAhYhs4UqkSlZj/Lp1?=
 =?us-ascii?Q?rjz/jI2KNCYy7u9kSGVlYjXDA7fQY8vwApuYozWKMazXTjq4W9boy46rameW?=
 =?us-ascii?Q?uiVZYX01QD1iOAV9MJBiWy26x3oquoOtfn903H+UabLUlTHN6Q41RnQNog45?=
 =?us-ascii?Q?AYLI1IEc0oZDBmDK2e6m65XKyxzrRBFFEp6Y+QC613Td8oa2sody3hem/9Cy?=
 =?us-ascii?Q?nDlTKXT0xHP3Ryz9PO8UMoWgUjW8E5rQJQbZnWGUT9+A8LAfTGlukzjXYLfH?=
 =?us-ascii?Q?zP9Dn45zR7NzZdD1nQRAhODILhvXEpQobBufZaS/lJcqUBEs/ZcUr7KbKJlR?=
 =?us-ascii?Q?P1LTs1xq+t1Rb1B/UmMI2n6bJVzX7vMpntsMbT6MN+GMTpI/Az1kYlPmoBQ8?=
 =?us-ascii?Q?2HTDRX0U8VeDGFMnSvJmSlK9rs/xFLauD/gKtqyHyVFpznoqyL+UBlxXkQsD?=
 =?us-ascii?Q?1f1DGW1to/3tq1JIWAlh3zEJcQGuFpJ8D0ATYvLR8vc/eDrIRpRNUHrpfc2d?=
 =?us-ascii?Q?qJEpZmedtv88hIu1b7cIxFK8LoCYKu4p/TrdS+3qMJcIk9ykQapjsL+XQYTw?=
 =?us-ascii?Q?CdmIugwcSYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pqf8UqoUUoJCCOEwuiJ0GaZhuOlgXhyhTZxmIsITfWi+54m8NWNlFOJvGorR?=
 =?us-ascii?Q?u7YUWfyj9GniS9RSEioUhcOWk0tz9OlTakcC0O5osmHt2pCEeRlJ1v9UhUNJ?=
 =?us-ascii?Q?TsC4EZctu/okFzxMKx8J9X3gGBdInGxQwR3FO2Qfls5+Xc7RJJHK5VPjzJNO?=
 =?us-ascii?Q?U16oDFFIEZ5VD22F8g12V9/TRlKJk8g6jOPX41BPWVrKVnFQnGlYQHXhMLoA?=
 =?us-ascii?Q?fpYZzq7Eyp2VQF+aslAgRjzMoNl8FFGRc2AVOspUUlFwhrD5E4E35j2yqCzf?=
 =?us-ascii?Q?DXBWVN2wCQ/dPKkvCqtceCEz8zk+SO835jpmHUl3b71LUNr6k732sw8SrAEK?=
 =?us-ascii?Q?eULDeXtrVociNMYcCMnDYVs5SLUX5EZ1wPrMnSO5rYm1Od7sRPFy/4xp16Cg?=
 =?us-ascii?Q?uzwoaCg+TL+bNn1DiJt9CwCjmcFe8JIXiHGieLOr7rHtkNcV8bpPHVrDHEFt?=
 =?us-ascii?Q?Ri2RhphoruL9dUzzc+Z2CEhah+FSKHKA0vO/lqAXuujEKAn+Wo04rA6NrQQH?=
 =?us-ascii?Q?CD8GwoBbdGEh0942XgX0vcAvgfXUrxOKrQhjBImASkgel2NWT3WqgBawrwAq?=
 =?us-ascii?Q?12yqF4Nau6/vF5HGSptIwo6u8Do/PUXFFuUPx8nBo3TvVVkWuT/zIiYwcdqX?=
 =?us-ascii?Q?ANOFKthaF3hUuOYrKl/FtD68pIZNhJkkmV832MmM6tOt5tkjsAyo3Xiw9OcB?=
 =?us-ascii?Q?hFPwxmkwwp+vwBlWUm/ZZoSwuBL8tfiMqyAiPCIYknQIhUANowd50EmQA4+r?=
 =?us-ascii?Q?ikB9NDvbrttEFqOgtZUQqHqJlhk3Eh5acNkzS0fjR/t+QjYaqtUMfefnbGj2?=
 =?us-ascii?Q?1GFJl2pURQlIIoObXKSr8N4v/6sB2j4u+Ed9OEUOYY2/kl+bXt/JGKM9F4SO?=
 =?us-ascii?Q?janmLkhbGuBJ4CyQjrHd52/AN5IXsi2HtG6XnAMPMbiwZD+25LyIJ0gBFUsg?=
 =?us-ascii?Q?mUogA8l/+11VGIov8Excf+k38i6T0dLPLjyksIw2cMLFn/Ixa0sUL8PkyiZ8?=
 =?us-ascii?Q?M9vfujTzFDnkfos8n6uaoK7chMrJcv4c0oeyfeD1TkOF75vnAOnDOEK9jloT?=
 =?us-ascii?Q?etVcrFCfNak1NoDUMzyowO3nCRW07cit4VXkZgMVu2Hj8sboTK9VRovHRdfL?=
 =?us-ascii?Q?BdIcZ61b9UP2AVseFJzRI8IPDtvxzuLZrnRwLA0I4PkK5Qo1W22ykIx6RNqZ?=
 =?us-ascii?Q?t7T+3x2J4YRAxES8Asj72xnGLShECrAmwkd2J5fe+n6qTRDHAvmkA+Jahi07?=
 =?us-ascii?Q?LR8nFP6gR+k5k/nSw38ldS6ud0kztrMKu4S/I3ZoQc1TpH7IK2C3j2eHHnz5?=
 =?us-ascii?Q?4+xwYklFR7xHP1OFaf9b/BXXB0PxVakwUM9DPECoF4nF6uZ+UXmvagF5mn8x?=
 =?us-ascii?Q?QbiASE+t49yxEfbKvreS1gxOaszZ+jikdjTh0tnYp6DXfkNRWHcRnnD9kyWd?=
 =?us-ascii?Q?2nW6WE9SZ8srx3RYwNsUvoLTpWAI3LEu+lDiZMPbWA6ARF29e9AEQ2CRI+sb?=
 =?us-ascii?Q?ZOGCDwVeHUGPV+bAU1NVB0gKCSse4d/Mqob6W2wkBJEri5xjjlWvfjW5H2aZ?=
 =?us-ascii?Q?hvKSdmHNX8gKsXIaV02dv7zI4QjzfHTvDnCdUZhH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c752f727-d047-4abc-ec05-08ddd5d433e5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 17:02:33.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB08rKstu1ecP8uOyH4IbW2bEqOas2dVWr5PI0RuVdSshmj8GA5bN3D7j9uTwKxg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482

On 7 Aug 2025, at 2:49, Baolin Wang wrote:

> On 2025/8/6 10:20, Zi Yan wrote:
>> The helper gathers an folio order statistics of folios within a virtua=
l
>> address range and checks it against a given order list. It aims to pro=
vide
>> a more precise folio order check instead of just checking the existenc=
e of
>> PMD folios.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/vm_util.c | 139 +++++++++++++++++++++++++=
++
>>   tools/testing/selftests/mm/vm_util.h |   2 +
>>   2 files changed, 141 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/self=
tests/mm/vm_util.c
>> index 9dafa7669ef9..373621145b2a 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -17,6 +17,12 @@
>>   #define STATUS_FILE_PATH "/proc/self/status"
>>   #define MAX_LINE_LENGTH 500
>>  +#define PGMAP_PRESENT		(1UL << 63)
>> +#define KPF_COMPOUND_HEAD	(1UL << 15)
>> +#define KPF_COMPOUND_TAIL	(1UL << 16)
>> +#define KPF_THP			(1UL << 22)
>> +#define PFN_MASK     ((1UL<<55)-1)
>> +
>>   unsigned int __page_size;
>>   unsigned int __page_shift;
>>  @@ -338,6 +344,139 @@ int detect_hugetlb_page_sizes(size_t sizes[], i=
nt max)
>>   	return count;
>>   }
>>  +static int get_page_flags(uint64_t vpn, int pagemap_file, int kpagef=
lags_file,
>> +			  uint64_t *flags)
>> +{
>> +	uint64_t pfn;
>> +	size_t count;
>> +
>> +	count =3D pread(pagemap_file, &pfn, sizeof(pfn),
>> +		      vpn * sizeof(pfn));
>> +
>> +	if (count !=3D sizeof(pfn))
>> +		return -1;
>> +
>> +	/*
>> +	 * Treat non-present page as a page without any flag, so that
>> +	 * gather_folio_orders() just record the current folio order.
>> +	 */
>> +	if (!(pfn & PGMAP_PRESENT)) {
>> +		*flags =3D 0;
>> +		return 0;
>> +	}
>
> It looks like you can reuse the helper pagemap_get_pfn() in this file?

Sure.

>
>> +
>> +	count =3D pread(kpageflags_file, flags, sizeof(*flags),
>> +		      (pfn & PFN_MASK) * sizeof(*flags));
>> +
>> +	if (count !=3D sizeof(*flags))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int gather_folio_orders(uint64_t vpn_start, size_t nr_pages,
>
> In this file, other helper functions use userspace virtual address as p=
arameters, so can we consistently use virtual address for calculations in=
stead of the 'vpn_start'?
>

Sure.

>> +			       int pagemap_file, int kpageflags_file,
>> +			       int orders[], int nr_orders)
>> +{
>> +	uint64_t page_flags =3D 0;
>> +	int cur_order =3D -1;
>> +	uint64_t vpn;
>> +
>> +	if (!pagemap_file || !kpageflags_file)
>> +		return -1;
>> +	if (nr_orders <=3D 0)
>> +		return -1;
>> +
>> +	for (vpn =3D vpn_start; vpn < vpn_start + nr_pages; ) {
>> +		uint64_t next_folio_vpn;
>> +		int status;
>> +
>> +		if (get_page_flags(vpn, pagemap_file, kpageflags_file, &page_flags)=
)
>> +			return -1;
>> +
>> +		/* all order-0 pages with possible false postive (non folio) */
>> +		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>> +			orders[0]++;
>> +			vpn++;
>> +			continue;
>> +		}
>> +
>> +		/* skip non thp compound pages */
>> +		if (!(page_flags & KPF_THP)) {
>> +			vpn++;
>> +			continue;
>> +		}
>> +
>> +		/* vpn points to part of a THP at this point */
>> +		if (page_flags & KPF_COMPOUND_HEAD)
>> +			cur_order =3D 1;
>> +		else {
>> +			/* not a head nor a tail in a THP? */
>> +			if (!(page_flags & KPF_COMPOUND_TAIL))
>> +				return -1;
>> +			continue;
>> +		}
>> +
>> +		next_folio_vpn =3D vpn + (1 << cur_order);
>> +
>> +		if (next_folio_vpn >=3D vpn_start + nr_pages)
>> +			break;
>> +
>> +		while (!(status =3D get_page_flags(next_folio_vpn, pagemap_file,
>> +						 kpageflags_file,
>> +						 &page_flags))) {
>> +			/* next compound head page or order-0 page */
>> +			if ((page_flags & KPF_COMPOUND_HEAD) ||
>> +			    !(page_flags & (KPF_COMPOUND_HEAD |
>> +			      KPF_COMPOUND_TAIL))) {
>> +				if (cur_order < nr_orders) {
>> +					orders[cur_order]++;
>> +					cur_order =3D -1;
>> +					vpn =3D next_folio_vpn;
>> +				}
>> +				break;
>> +			}
>> +
>> +			/* not a head nor a tail in a THP? */
>> +			if (!(page_flags & KPF_COMPOUND_TAIL))
>> +				return -1;
>> +
>> +			cur_order++;
>> +			next_folio_vpn =3D vpn + (1 << cur_order);
>> +		}
>> +
>> +		if (status)
>> +			return status;
>> +	}
>> +	if (cur_order > 0 && cur_order < nr_orders)
>> +		orders[cur_order]++;
>> +	return 0;
>> +}
>> +
>> +int check_folio_orders(uint64_t vpn_start, size_t nr_pages, int pagem=
ap_file,
>> +			int kpageflags_file, int orders[], int nr_orders)
>> +{
>> +	int vpn_orders[nr_orders];
>
> IIRC, we should avoid using VLA (variable length arrays)?

OK. I can change it to malloc.

Thanks.

>
>> +	int status;
>> +	int i;
>> +
>> +	memset(vpn_orders, 0, sizeof(int) * nr_orders);
>> +	status =3D gather_folio_orders(vpn_start, nr_pages, pagemap_file,
>> +				     kpageflags_file, vpn_orders, nr_orders);
>> +	if (status)
>> +		return status;
>> +
>> +	status =3D 0;
>> +	for (i =3D 0; i < nr_orders; i++)
>> +		if (vpn_orders[i] !=3D orders[i]) {
>> +			ksft_print_msg("order %d: expected: %d got %d\n", i,
>> +				       orders[i], vpn_orders[i]);
>> +			status =3D -1;
>> +		}
>> +
>> +	return status;
>> +}
>> +
>>   /* If `ioctls' non-NULL, the allowed ioctls will be returned into th=
e var */
>>   int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>>   			      bool miss, bool wp, bool minor, uint64_t *ioctls)
>> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/self=
tests/mm/vm_util.h
>> index b55d1809debc..dee9504a6129 100644
>> --- a/tools/testing/selftests/mm/vm_util.h
>> +++ b/tools/testing/selftests/mm/vm_util.h
>> @@ -85,6 +85,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uin=
t64_t hpage_size);
>>   int64_t allocate_transhuge(void *ptr, int pagemap_fd);
>>   unsigned long default_huge_page_size(void);
>>   int detect_hugetlb_page_sizes(size_t sizes[], int max);
>> +int check_folio_orders(uint64_t vpn_start, size_t nr_pages, int pagem=
ap_file,
>> +			int kpageflags_file, int orders[], int nr_orders);
>>    int uffd_register(int uffd, void *addr, uint64_t len,
>>   		  bool miss, bool wp, bool minor);


--
Best Regards,
Yan, Zi

