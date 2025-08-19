Return-Path: <linux-kselftest+bounces-39324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E739EB2CA31
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DF81BC7818
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9622C15A3;
	Tue, 19 Aug 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJopYymw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80920B1F4;
	Tue, 19 Aug 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622742; cv=fail; b=QnoFQSi91+GY0Ofv8+BcHk1uyIlOPCc8wEpO7XJL83SEpdkPNI0Fgdxjd/0RfISP5OoLiQd0bH1J+KaBJ8+05aaDj/FQ/VoAXN78V0njf3uhmYAmf4W/ZtHVlUMhGt88ly2XB2kXXbuRH1UV4sgL11nYe1uA93NSZO3xbRTQfnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622742; c=relaxed/simple;
	bh=7zrEBVnNc5H5IddzJmd9syJf/+mdxnN23m8BB3rgzLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhDWKbvwjrqheOK2AEAH6JN5Ok2Y0YxcMyzhaFdJyvm+OI2L4gMXKllQmQO74d+QW3RjoUFzj6D5quWZrpaMTzgdQJtDqNu/0+MGmFcvGHf4+GwF88a3w69/kInk3QL+7Ai0oZ3oS5UZuArLSm3dkoWFziY/ROP3oqPjgQgLweo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJopYymw; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV/hzHdG4j2jedl3gap3tfXC3ehfNYtzklM6UHhjqI0q0QIsDEZqqXcGgg/InUBbMTDu/KN4slwmbh+yx6kHB8Quv8tZ3InqlGA52++KiqsDzr6dxZ4XuQT0tcC71gw1VJgbp0d/pZ5u5uufby+27mfx/DiuyCOBeGIJ4Q+QZYtIh2cs3XWhAkcJNR6AtXi38q1V9c8TwqhSdqmm+JS173aleBP4MhTlOu67bMrhavTseZzSqg+kgpgo7Rpteiz9R2riXYjSVRR0cOgGB9s6QKt9AF9ehAN55pGparY82qbE6YlMVd2cct1w3kPdOfj1u9lQ/mfYy7be87LhE30huA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/9u5c7kD2RKessEz0yD+d7L3sQj3ofhJ2KqHiviyGs=;
 b=ofYnqMAH+sK5RogJ0hVmkHoKsmzCwyYYf9qoi9xsf0pdkcBI8IjcGCNVLgBHUWYkerm1HtIFGbZrL00bb/rFgbTNyzhkPoyDThpG70m/sK3E57vI4I2LY1VeAwK6vTtxbpGye4r4kxaqVBTeM1m0IefhvRPBvmdBuakEZgO8onDLZmj2fhudMPB2yv/Bt0J1o2Rp5OkuWsgpdWQPPRN12yTqyuqGdHTFjwVPW7nd6C1ays18D2Wyta1t3hewsC2rfglibbEOAiqOSO1sXujeCa0TZjbBjgitxxndjMAM+u8XiKof8z+3ODom3yfPxC6SdOv3xo9rw/GTfV3dsl8UPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/9u5c7kD2RKessEz0yD+d7L3sQj3ofhJ2KqHiviyGs=;
 b=ZJopYymwKbZ1vADHsT1OeC6oJZoTjhupjIFopcCdlnGTs+BxaaLnUmjaHR/AagXuQdtKve34CnWRYhkbSW1EI6iC5BqAIeR6orAI1tHYWZ3WiHy1DaFT/28VVk7896uiKvJYuoogjpA0wN3gVoxdx52p7ZNaAtA85HRS7w/hwxnFjqBmabjwrRe6CbhPiey3Zp3N+hRFnd8KaHAP2Y9Xs9USlE8IUndym5y1b+4HbCc4E9SpFw0ObJTfJjDCoFjRJAknV8pYh3NxeFOyaGm5lMkBSeeJQZGqkud4JUkfwDD0MQnTUUzrnLCVa4NiZzkgDipyaifoOQkLauLvCLqzyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 19 Aug
 2025 16:58:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 16:58:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Date: Tue, 19 Aug 2025 12:58:51 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F54782D6-65A3-4D35-AE03-8ADE636EE258@nvidia.com>
In-Reply-To: <B8ADCDEA-DB05-4843-983E-A66DE78AD1D6@nvidia.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
 <20250818184622.1521620-4-ziy@nvidia.com>
 <268d9c9b-4c48-449c-97c7-33534fb23fa3@redhat.com>
 <B8ADCDEA-DB05-4843-983E-A66DE78AD1D6@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0931.namprd03.prod.outlook.com
 (2603:10b6:408:108::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f1e291-efd2-436b-8d8d-08dddf41ae4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sl2wr47sM9KYWkxEWyiI87v8u0FUt2xwpgpzVKiT1pYbN/GpNJTn8HdsHyP+?=
 =?us-ascii?Q?ho87agibBjNNPZRrAyg6sQqL0VdR9mM4vXvEtp0gwyXsvo6+Gg3kt3UnOBFZ?=
 =?us-ascii?Q?KdBmjOI7KYgqcYFon46N/XXtt97PBsWwc39VeVZYGn0LeXLWYCYzgNA9lTTO?=
 =?us-ascii?Q?6gYTibtw5pfTswXfxk0y+WgT+dRFTuxrvlJOybWMiXe+GGOSfE0jY3zldh1V?=
 =?us-ascii?Q?641wcaUTlCWsqUZLmDDO7tj9NL6oop7LD63ZEEp8/iuMMCAdFlrpS62BhxfA?=
 =?us-ascii?Q?S5JWTws2ooIGOCZp8EFbJ00VpCvT/+tRNLHW1vko0euGS0PqgixipWek1bgy?=
 =?us-ascii?Q?hEs7JGUU5+KcclpuQbNXrxaBBFrM3oGmYnNomzAgzTqGaXX+MKQC+ueic0I9?=
 =?us-ascii?Q?VmLc+j1xnt3rgCV1PYKzzdCIcXlUADMv2UzeR0yFj9rRfUTyfiFVi6V9h7H+?=
 =?us-ascii?Q?efb7ZPUbJYxwwms4+96hyOFMOurTQ83EGcqIABU5bKAJCCCXQtLlE2kF5OGC?=
 =?us-ascii?Q?ycPmixmVAl/YpeaGA7F6p8S+v+W6MaZdkedqO0pQl3orLKxW+Vnn2aI+86vi?=
 =?us-ascii?Q?T1Kl8X/xFceg8HgNamKvDL6f+D3yxckci9kMCbkuXb+hS5uxsbIv41rVjLmW?=
 =?us-ascii?Q?Fe9bFuwXlqtPO3wIzqq3QnH6iAxDJzQQZMRibJ6FO6/emDUtLI3JwJuPwWQt?=
 =?us-ascii?Q?tWzMm1yWHSt3CKzXSeiwa8rFkNCZsH9R4Fh7j9rz6xUThLmCZUeTwuMDEX+u?=
 =?us-ascii?Q?NMMm+Lv9wMazRNrFXDebfLLfuIICIFAVBnbFvLl84dRxsOlt3JYgR59RFqAR?=
 =?us-ascii?Q?2gm7mJyMChJJG2ZF5TSqcvTY1T623f0wqqJQ3uQzTGpy8SxqIplEx+DuTM/p?=
 =?us-ascii?Q?h8BZBR6OZNIk8E1hd4lcXKYSItBrQb/hn/DBTf7oCEJB6qjPNWEK9Krag+Pw?=
 =?us-ascii?Q?7xftbU5tYPlVRoufdkAcRdJkud2aF8i4arDzmeAWAL/8xcLgJXHwTDghOTVE?=
 =?us-ascii?Q?SKx5RLNzBn85HiG7CIcn8ANwjpxjjtznFTYtIeXwhXFUX6scJ95cyBcMF+hu?=
 =?us-ascii?Q?A+suieT1Lvzap+C4FFbAAVoCXR2iaaiyCYfcQ+2a7Qgr0L3gSZCRcM3CJ97D?=
 =?us-ascii?Q?R0JfQBaVACBPVcwcMrD8xdZ+uK/LfTjDixZcNsZZj5hcHOTAv1gxCQryxQ+q?=
 =?us-ascii?Q?5cXO7GA+MgNe+QdCoh0sID2TgzCqJ7IP9czhyVPy6cOw/3Vs/0ujZH4zn7N8?=
 =?us-ascii?Q?bpvkhxpPDkvZ+g7HrobCkK7uvranStMMnPf0bxKojF2rLzQSo4tSajsJJSKj?=
 =?us-ascii?Q?fSXdCCk0Tk9UDi1KBby3jKSaWjZchdgv/0yZZeDz+PlItrXT7OBUlGAFjzDV?=
 =?us-ascii?Q?dAps36oSzg2KvJk2q3em1GGGMQ+x9p3pKajDu62R7OTgaqXrpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjIdqqsz4G6A3aJ/7iDLJPcaHrmb6CNAiAVxBlfZsiOu5ufshWEJhIs84dCR?=
 =?us-ascii?Q?WGPXCL+8RReXegM5vtebLzqefO5ptMR1GBqIbc2YumyyHzj/ouYiInuz+j2u?=
 =?us-ascii?Q?yhe9aAyS6bUvI0fhXlB9mR0qmFb0DxDEnFQf23A9cyJGur/zxKVZAZnq7TTZ?=
 =?us-ascii?Q?fOseHcf7EnUraHh4kz8x2P/6A1w2ouTN41zrFJlPfBXp+KhpGQybp0gpslsc?=
 =?us-ascii?Q?Ghr4Bqh7rr/Z0dQgsN5Ya4N/1S0+XVk6986JHDoNGiZlgYkToIk/6VvwBWRR?=
 =?us-ascii?Q?hPLNemhhnJauyDwak5ErQXPiLi9IZ653b0zllri8k3WAUavVlxFg0tRPPiWi?=
 =?us-ascii?Q?bAR4VgKAgKm2iCO0VzI+uA7BR57dPeTZ4nRexfTF9AxNK9InklP48qZD1PNF?=
 =?us-ascii?Q?f1BVLukI0g72z+ZD5wso0ineNB/y6iHSxMH8lX8NbitFmmLpcjGqjpp6zAW9?=
 =?us-ascii?Q?dTpSBWt4yzVpjNZ9DuToFQrg+FD+/5de9othOfmFrK/6f5DjUKt6A0Ku4dLK?=
 =?us-ascii?Q?JnqmTMQ9WWaZtUPm5N5N1i+/a4at2xCN6Xz/odveaK/Te7yeUw0tcnVCVrTb?=
 =?us-ascii?Q?98gSCvegTx3qTrCr7Db/H8o2ZZG2JGcOWhrZb0rNHpBEjKCCI0FlbrOtBC+Q?=
 =?us-ascii?Q?hrZyMvGWN97R2T74Q1IAFz1qGi6j7Kspm/f3veqv/gSaa88zzIVT4p8flkVv?=
 =?us-ascii?Q?XiEVZpFAMZr5fWw/V8CSEcSrBAu4tjVKrjx/NShUaiJlsPvPD05uzFflQNUE?=
 =?us-ascii?Q?TCI/15cgby/qdGKseYhgY5N7k+iSDNTZYkc3I4QUxffudc+IWeA25O12Nfox?=
 =?us-ascii?Q?selZQvm+LT63veGL/ECn8f/H4qrInbBdLMLg3NwZBPdEFDr54E8tEzy4tT7/?=
 =?us-ascii?Q?sWRYRWBoUv1dtxStQl22nwAhNVbU6RzDckpl8n8mG7mZwnh3K9mkURIkdaAH?=
 =?us-ascii?Q?AlxxpIsC4S8K8nHMTBij5BHQKqt8ytfYpdWPyfg1wwkKhzR+ARd853KzpIvM?=
 =?us-ascii?Q?i4yn8rUYQx8rHM4hU3YGYLLAsNjeaPBRPyFxVFjtcXLI/5XJoAzFHNZXUh1s?=
 =?us-ascii?Q?D/Wd2a2d1nxoAPki/vU4QlA4Z1rDWOMn7I62q/I3DzXx89M0d0kWNVsrjpNE?=
 =?us-ascii?Q?mZnsBqEjuTcccN5s2/ZEmISa85ZRn42i4rlaQ1/2CeDSzatFF6tYDslw5Uoc?=
 =?us-ascii?Q?nf38oi15xEnWfCpPxQ589Xqu6HsApzLCJiK/ZVYWsRwHPash0/PwKVEygyhv?=
 =?us-ascii?Q?e9U1t6oZ1i0w6abfdL+Yvyrkxjwmb0wX2luldhHmMzEpj3BCcEctvzmVafyu?=
 =?us-ascii?Q?WTiF2WP6Uzb7woVO6T1noKghYtzeZEZaf47oWaLuhDnb/6qKmWw5dald+4ri?=
 =?us-ascii?Q?3ek9K/cqi1Mxy/HV/H3ILYAHbJBKrGiyse1KzqWTK76mpeqJDEGHIT8yxaqz?=
 =?us-ascii?Q?Q9gE3C8/2Dy0j/dS9QbJE3gUK1xtuoKXyFmJiHco9DiwALG1CQgjkgjilDFf?=
 =?us-ascii?Q?NtUubOVyq1mscgPy72mFtq+P9R0SKHIRUhY1gnC6EWqGO/XvdE6ACBOaYL4V?=
 =?us-ascii?Q?GoPBj7zWkalQ6TbYcdKK/+XpAbSdnM4rMbJ32PS5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f1e291-efd2-436b-8d8d-08dddf41ae4a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:58:54.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cwl+hsTp47B6clH1XCBj/TVf5zf9+E0s0BAs0HmhagKd67PkkON/NybmnI3nVcGc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

On 19 Aug 2025, at 12:50, Zi Yan wrote:

> On 19 Aug 2025, at 4:54, David Hildenbrand wrote:
>
>> On 18.08.25 20:46, Zi Yan wrote:
>>> and rename it to is_backed_by_folio().
>>>
>>> is_backed_by_folio() checks if the given vaddr is backed a folio with=

>>> a given order. It does so by:
>>> 1. getting the pfn of the vaddr;
>>> 2. checking kpageflags of the pfn;
>>>
>>> if order is greater than 0:
>>> 3. checking kpageflags of the head pfn;
>>> 4. checking kpageflags of all tail pfns.
>>>
>>> pmd_order is added to split_huge_page_test.c and replaces max_order.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>>> Reviewed-by: wang lian <lianux.mm@gmail.com>
>>> ---
>>>   .../selftests/mm/split_huge_page_test.c       | 88 ++++++++++++++--=
---
>>>   tools/testing/selftests/mm/vm_util.c          | 13 +++
>>>   tools/testing/selftests/mm/vm_util.h          |  4 +
>>>   3 files changed, 81 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tool=
s/testing/selftests/mm/split_huge_page_test.c
>>> index 089e146efeab..56d1eaf9a860 100644
>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>> @@ -25,6 +25,7 @@
>>>   uint64_t pagesize;
>>>   unsigned int pageshift;
>>>   uint64_t pmd_pagesize;
>>> +unsigned int pmd_order;
>>>    #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>>>   #define SMAP_PATH "/proc/self/smaps"
>>> @@ -34,26 +35,66 @@ uint64_t pmd_pagesize;
>>>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>>>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>>>  -#define PFN_MASK     ((1UL<<55)-1)
>>> -#define KPF_THP      (1UL<<22)
>>> -
>>> -static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpage=
flags_file)
>>> +static bool is_backed_by_folio(char *vaddr, int order, int pagemap_f=
d,
>>> +		int kpageflags_fd)
>>>   {
>>> -	uint64_t paddr;
>>> -	uint64_t page_flags;
>>> +	unsigned long pfn_head;
>>> +	uint64_t pfn_flags;
>>> +	unsigned long pfn;
>>> +	unsigned long i;
>>
>> Final nit (sorry!) :)
>>
>> const unsigned long nr_pages =3D 1ul << order;
>>
>> so you can make some of the code below easier to read.
>
> Sure. Will send a fixup.
>
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
> Thanks.

Hi Andrew,

The fixup below replaced 1 << order with nr_pages based on David's
suggestion. Do you mind folding it in?

Thanks.


=46rom c07eb882465b938a70acb84e4cdc5b6598536322 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 19 Aug 2025 12:52:13 -0400
Subject: [PATCH] fixup: selftests/mm: use nr_pages instead of 1UL << orde=
r.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/te=
sting/selftests/mm/split_huge_page_test.c
index 56d1eaf9a860..f2882cfab568 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -38,6 +38,7 @@ unsigned int pmd_order;
 static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		int kpageflags_fd)
 {
+	const unsigned long nr_pages =3D 1UL << order;
 	unsigned long pfn_head;
 	uint64_t pfn_flags;
 	unsigned long pfn;
@@ -63,7 +64,7 @@ static bool is_backed_by_folio(char *vaddr, int order, =
int pagemap_fd,
 	if (!(pfn_flags & KPF_THP))
 		return false;

-	pfn_head =3D pfn & ~((1 << order) - 1);
+	pfn_head =3D pfn & ~(nr_pages - 1);

 	if (pageflags_get(pfn_head, kpageflags_fd, &pfn_flags))
 		goto fail;
@@ -73,7 +74,7 @@ static bool is_backed_by_folio(char *vaddr, int order, =
int pagemap_fd,
 		return false;

 	/* check all tail PFN flags */
-	for (i =3D 1; i < 1UL << order; i++) {
+	for (i =3D 1; i < nr_pages; i++) {
 		if (pageflags_get(pfn_head + i, kpageflags_fd, &pfn_flags))
 			goto fail;
 		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
@@ -84,7 +85,7 @@ static bool is_backed_by_folio(char *vaddr, int order, =
int pagemap_fd,
 	 * check the PFN after this folio, but if its flags cannot be obtained,=

 	 * assume this folio has the expected order
 	 */
-	if (pageflags_get(pfn_head + (1UL << order), kpageflags_fd, &pfn_flags)=
)
+	if (pageflags_get(pfn_head + nr_pages, kpageflags_fd, &pfn_flags))
 		return true;

 	/* this folio is bigger than the given order */
-- =

2.50.1




--
Best Regards,
Yan, Zi

