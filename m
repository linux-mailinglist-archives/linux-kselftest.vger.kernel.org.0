Return-Path: <linux-kselftest+bounces-37119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AFB01EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DA3B093C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA52E3371;
	Fri, 11 Jul 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BUtzh2xI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029D2D97A7;
	Fri, 11 Jul 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243549; cv=fail; b=CxBSNh0zul4CbdLIgIQ4YP6rI4/W1hWXoImQQLCv2CcRwIgM9KOw8txo8aocqzjlx2w5JBPk7g9wcHLUz5mdMtleGSJm10vxuvLs8czSM4uiKnalxNKKXCtKIVfoR82Z5soz0jEw+UK6VMrTDflqAwL2pHX6UTvz8AtKiwrwkNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243549; c=relaxed/simple;
	bh=UHfYYNGJX8c4UBrOPnc7aGvbDfZ1atyBQSF8hWz85vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXEkcz9IN0h+689soRRZIgxRR1hpB4ppJiq1VJjTzT1Q5zR8wgMBo1L74ryOdyyJqKuKzZPUqifEubj82gOczkbMOZ40eKn2LaIgp3aNL+aF/A7L7HRrKhgq5gP4DoIIIszOZnL8sR7lECJN5h41R3rnU7BrFX9gkKEToe1lYtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BUtzh2xI; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZIlZkE40+EGc/subd0ExFi9B148PWJdKRBLG6raDER/bQRLC0x+KktAoIHBzDIEOMISSjYuet9uB/5Ip+unSfaFPjpeOZ/U+CBlqZUUuB9+R9GlVkGHRCa3YJSMHMdT5oSV1MMF5KtbthHIgijBHny445+Zie20BBZS02uG9tToTDFL8ZCmHDCBNIKgRL/cM5gogLqyPNERKNwrowQv06WpgHrfSNce5WTP4H0RvkBb3I6Nk/07mhntk5RNEQSPsZQ1SiINpfnlma+aUbmt5fieqF5h2mq1CYFsSrOt3tchWnjj7O+mC1Xe3HfIrqpqWwbJZfrk0VjW2G9rHJ9glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N91tPAH9RsdhXn/3epfQ9OvWvCvq2wDCpkUmMcFjOuQ=;
 b=xsM0p5+HBRfm3PfJQqg0U1r+lLzknM9tOw5HuQmKisCLFYy3GkAv2PMDiSHqn3f/6fG28FyvLKRcM41YE+hf3wF0NfPX/HY0JgHJFpCc9riepElTn46fXMC9SlmXm3cu9wU6pp75WdHJYUDeA3m82hjPdzWYEU+aqMue1yTPx16uBKHMjELKbX88zd9QTXKQJTdDo2Qr4CsugJbO/X6mBwwHq8OJM+y+5O62ElL0DtO5tEKl1qzMcGGSlowyN4ThO8yqvPkbqaydauEz0ciQT1xdbnDXRgdChC2RbWNpiqkJRdM7aSFuuGtj6j4k8CMmrjIxfaEDMvZe7QjkDW29hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N91tPAH9RsdhXn/3epfQ9OvWvCvq2wDCpkUmMcFjOuQ=;
 b=BUtzh2xIAHdKm6lzKLt7I5z16NVOtqQJy/8Mt8CHtAbB9mu3giAX6NscKn8HJSkMP0S7FmMR4NHnFigTzU51Bg20tOf3FuGAB5k3SazZGYPKkfDQh6kIHYfu4kLInFqa7KXuupZRPBwdPWKXUiTTo5ivIdChPEMDECR8MkXUih2kMFrkimMRw5Whch5Nw6D6kGDPlu/38POq62X2GIbIPSrpkhDgxgh9MusPm1nJ2Rxp6ltlj1xlBjLUwz0ke8D5gSULCNelKLFdyZcML1qWkvPbdP6OQgqsJrMSa99pvOAFHkLuH0N6l8IYE3diTJ7uWzvP26+Gqc1RfJiLxYBCyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Fri, 11 Jul 2025 14:19:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 14:19:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix split_huge_page_test for folio_split()
 tests.
Date: Fri, 11 Jul 2025 10:19:01 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F9C3F0B9-7A83-4CE5-945E-6BBC3F16B149@nvidia.com>
In-Reply-To: <e2f32bdb-e4a4-447c-867c-31405cbba151@redhat.com>
References: <20250709012800.3225727-1-ziy@nvidia.com>
 <e2f32bdb-e4a4-447c-867c-31405cbba151@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF00013E04.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: a861d14f-6493-4588-a536-08ddc085e444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfrY3vMnQdGuhNgUB20MHUu40R1BYXWUF6z7Mvlk7x3ZYe8gc5c2O5NJaHho?=
 =?us-ascii?Q?mb9UlNXhGo1UBn+qr4ioKAxyvg2KhLdux7W0UZan70HvIMwnBGBQM6SIuGbL?=
 =?us-ascii?Q?a7rbIrnZHhj9FmljUQ7BklgTNYy3EOY+D4TeKfx10mglxmuJfPfwWvQ8bPnr?=
 =?us-ascii?Q?lCoVFfQu8DzRd5xOJK7Xtw+joT09j0ywnLDhCWd+9yYTE8jNkv4prGTamhwF?=
 =?us-ascii?Q?QQiCzitwPuAT6tZJwSydAFcsYG74zr8ULwxs2I6d61cksxkihwArCsHBelGX?=
 =?us-ascii?Q?1SQ2AxrKmtX7Thutqd26E8cnR3sZ6V3RrpSww+PgdylPLcXRHp6zyEKW2Iej?=
 =?us-ascii?Q?EOh6eam575XAd3IjLg9dywbkiCC/nrQNZCHEy18eAa+ub/Ai0w7TaeZ3QEuT?=
 =?us-ascii?Q?lRwRD6fZ7tL5eXNUXaMelyC4BnNo2KjwCZiaTI7swhzIcqsdgl/VYf2vc+X0?=
 =?us-ascii?Q?1wHOUIVuJscxeHf77wsc+fpdagPBEQOJimeoZsOXFCDrY9gNQ/rj7cnHoKAd?=
 =?us-ascii?Q?iFjPcrshuOSl5rQv6KPH8aGRKg0HuR6MNYNZTISfFeF0ZRCt0j8b7olJR0NA?=
 =?us-ascii?Q?zCBFg/at+JHhF4dZvjN2fd+Ll5u3Ibx2cbdq+hFlZ9jIXSgH0yYuzNfnP5uh?=
 =?us-ascii?Q?Agu0RkqJE6QFOH0OAYr99MGn0oA48j9VQpWsyFkrZnzAMYxsK/ioTtSw8Yn2?=
 =?us-ascii?Q?IvQI4Yc/SrdoQBxjh5jPi0DGyP3KF0T9JLgDcMDu+v1/3Ooz5aN+75sOhY6p?=
 =?us-ascii?Q?eeboQlPb1aoljsE7PveYVXSavSLb08PPUvblKMam6uZCJDRAtyGygd2rdM1V?=
 =?us-ascii?Q?NgvsGlaiV+L7JGskIhpAutndddM+UcF2t3APfVonI49Ujv6BjMMUfgy7MCJl?=
 =?us-ascii?Q?D/hh4eZujx4jXYSLuykAiAI/TXuZwa1E1gUflStcYz+RAw9+8mtc6SdyOF9b?=
 =?us-ascii?Q?kF7y8xk36JqMKg4YbrdAoBUeFtuSUqtbP1BNU2b5BjC1AwBT1pjmL6P9D4sT?=
 =?us-ascii?Q?BN3VJBCrfmQAVEdLxPPFOmzMe1znkyBFe9xpRHr2eLHRUF8SW6kVqTrnxHP/?=
 =?us-ascii?Q?7skLChG2vzit4nSolTj9/XGVb+ClnxDju72WuT6DWtLMkkO4v+kGGUkU86uj?=
 =?us-ascii?Q?Ij9Cj5+7SY6mkotHbxaviZS5urbQ57Y7dDiSWU5Iup1UmLlanU6r5gAA6Z4Q?=
 =?us-ascii?Q?kuh6aT9V4pM7YRVBXKd5iNYLmskNL61qgk1bFskJEJfHLcjPjAJ9uKUJLRKx?=
 =?us-ascii?Q?w3dpO1JWrWCTspXfcmno7dVJdIuKqviMYLZGC1EerPFP9e8PhjhEHk3Wkdw8?=
 =?us-ascii?Q?ywiR87RVYSZGUQ3bWGMOMrCCPPdC2CHux2HmnbN/0BIMb/pk9BFjzUigilHf?=
 =?us-ascii?Q?dIhISfYl7ofRpv2PBhn/jLuuHpwSrWeCr3rF4X+LmENGAIpvbMs8aF/uZqTO?=
 =?us-ascii?Q?FMSslfW9ZjA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4dw/WR7//NH/9cHSbWsw3PgTXUGBFKztt/Rbku2Ukzx/dz3FJhE9fs5BvrQ?=
 =?us-ascii?Q?JwuYIM1x2k5HEOF3sOKnkfN0xmGejXeree0CD2i3XIaLGNdGnXL0tyWiX5oi?=
 =?us-ascii?Q?xZr+0XcYAG6BqLwcMfl2ioZs7VVLs/KaUTXRNnBxLPPD5/vdp92VpJiXNZ+N?=
 =?us-ascii?Q?OICWVBDPbArC3Vkrf8zUYjffwuFqZfjtK4hEqCPwhrPwNZ9MsK9xhnn7UFUN?=
 =?us-ascii?Q?CwEzly+8OB+OKuENjGNHdVUQ9Lkfotlv1Z4kRTuj1Ou5QeTyjRqqfAPj33cu?=
 =?us-ascii?Q?iI7DyNuEbqAb8QJg/N9mfJYeqUKmIt1uWJ2Ht3o7drPWCp77XGVieB4e3i2J?=
 =?us-ascii?Q?X5MePiPRRk18thsC2GbZlS7Yq4D94o8hE4jB0QZb/7VRooxVd5TswIqc8+WO?=
 =?us-ascii?Q?4i+rsPU2vkw2TTWXXYUyJUJ5hZSzWGvSXXlRi6ACJMxxaABtlzHQiQnV6GZ3?=
 =?us-ascii?Q?u3TtRQtEdsZ9Q5smUpzKZJ3tDfiwHotCDKgUFqVwo+cfd90u4v04bU3rBU3a?=
 =?us-ascii?Q?+GU9y6Bx0s6xYLLANhuyjeajwS+U7sqEeJdbAKNzbg2pG71FgMUG8A79s2I4?=
 =?us-ascii?Q?Y/KbPw8KcgCM5rneomkXnD1XPK/MvZ+hP6YpsEbYIO5EbKOVi7/3Oa9DLz+d?=
 =?us-ascii?Q?R1y2Whndgtxghyqz2Qb9RwLzyF0bCxZaQTH0cINtyz4o/FJoFI+OTKbRg11u?=
 =?us-ascii?Q?kYxMrMuqNLGRtHOKjhPD5nDfL9MKKLVaBbSF1jv06xkJe1CeqJVvUuvS3d+J?=
 =?us-ascii?Q?02/dcUdZpOJY6PrNqWL5SEldU3u/Dh46q7RhDOUN/VEGcMy8b+1TUX3pa7IG?=
 =?us-ascii?Q?jqcvQzvWaGF8o2Smh3QFUozVzOeZk8+HdIxMqNtGmMcYjvMSOm+fbmvNgxYR?=
 =?us-ascii?Q?odJc2QMcsGc9q94RJFjwylysCQDxebHfKTbQ+fY83M9zwhBgIy0JPrcnNjw/?=
 =?us-ascii?Q?HobO5iu1xTQdVVFNMwl8pdr5SvaNnX/NGEWMulxeEglogHPlrhgZEmxwXAVj?=
 =?us-ascii?Q?7dCN+eEqEmD/8Sym77uc5sIbScRek9T4rmTbriq112dYYWaIWWi8v6LG1oFc?=
 =?us-ascii?Q?HhFxKe09UIKj+C4jCkxfJfRE94Lxl0ro1xtw6Esej5AS6pLc8OD6mK5JphFJ?=
 =?us-ascii?Q?UPe9d6YY7LeHJ45UWDQugS2tUDVyqRD+axsd6sf3j9vD1CIp2/hQDIWM1Z5J?=
 =?us-ascii?Q?9FntiheQxSulhSXQibQ3lmSUeAf3a3btdF+k4Wpk7OZyY9shyutOwxOKgz8b?=
 =?us-ascii?Q?EC5uDun+fcHiaWOjM5DDd8s84vCc8lIk36mn/HozyLbPekdTqN5j54u2QTyu?=
 =?us-ascii?Q?USXIZKdyIPmKCCsvxdQhwAjVizyi8EjSw+uhv+qdls86LdH/4uvvNE50DJ+l?=
 =?us-ascii?Q?IAH2Te4UTnA+ToQEONaMYN/z0q33RkNocZEAJ/Hsc/gkQRORoddUz0vkV1Cr?=
 =?us-ascii?Q?3ECN8xivetsl4K8wTVwzN2kITmO4KepIcPtPWjpXz8T3E3W2jxtDuJ/59YIG?=
 =?us-ascii?Q?2oMbDKF7PGpcH++oecbRmeR2sJYh1yHjVE1Fd/2daX1YCb+w4bdNaaLQRSZH?=
 =?us-ascii?Q?tkvWIfwu73+G5tEMdpMCCWKADRpKGrPwTyDIvOoj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a861d14f-6493-4588-a536-08ddc085e444
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:19:05.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/rIVN2drxoBUQw3dgPr1QDA9uNNmt2U47kZueU00E8IKuRtuYtZS6Gfd9OFOND7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

On 11 Jul 2025, at 9:29, David Hildenbrand wrote:

> On 09.07.25 03:27, Zi Yan wrote:
>> PID_FMT does not have an offset field, so folio_split() tests are not
>> performed. Add PID_FMT_OFFSET with an offset field and use it to perfo=
rm
>> folio_split() tests.
>>
>> Fixes: 80a5c494c89f ("selftests/mm: add tests for folio_split(), buddy=
 allocator like split")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index aa7400ed0e99..f0d9c035641d 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
>>   #define INPUT_MAX 80
>>    #define PID_FMT "%d,0x%lx,0x%lx,%d"
>> +#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>>    #define PFN_MASK     ((1UL<<55)-1)
>> @@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_=
size, const char *fs_loc,
>>   		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>>   			      (uint64_t)addr + fd_size, order);
>>   	else
>> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>> +		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>>   			      (uint64_t)addr + fd_size, order, offset);
>>    	for (i =3D 0; i < fd_size; i++)
>
> So I assume the tests still passed. Would there be a way to have made t=
hem fail? (IOW, detect that the wrong kind-of split was performed)

Only if the initial PMD page is not split. To detect whether all after-sp=
lit
folios are the size we expect, additional code that reads kpageflags
is needed. I will put it in my TODO to make this test more robust.

>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

Best Regards,
Yan, Zi

