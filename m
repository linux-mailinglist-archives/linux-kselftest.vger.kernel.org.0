Return-Path: <linux-kselftest+bounces-26860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89DA3A10B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515B116D370
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B726B95C;
	Tue, 18 Feb 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zwe44Inx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C926B946;
	Tue, 18 Feb 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892194; cv=fail; b=j9sNn53A4WcvygT6hM/iIgNEC5V/8zzVeODvB8TrBHtMIJicgA6M2mkuCYWfcAPfVAukjkDcFGRrXM8gwDfmVfCR8NI7WpfoFsnU2Px6oeb/38YeAcsHN3OcDaZDzdnNtt35ggs1kjf3N3ZiamuSWLpQCWqqGRcrsViVp0F1i5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892194; c=relaxed/simple;
	bh=jPmWK24Qpjh3OhPpo5kGacyQjoS74z+4DHRUO5E28M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlHn53JaDfRKYhHG0FHwsMfXiGpnNJj4VvqXikBhJ4CvRjrykmyPcApD2SuBx/4KOcw7ZzyO8ic2WUf89vaVHDiRbvNZ3Kwj+PKVArksy2SGpbiv/SUXFszfZn75wwktkqtCqcC6UICAi4g+MmsHpqvB/6zmhr7qTBK9sOl99Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zwe44Inx; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrFSplJ/LQxXOmrAnpQcnHt97VVBqTwazl38pENUhJpW64JHtDT/4dy4NqkY7hWizsNNf9ZZoOAdi47d5daCuvyDmRvEYuUp7EPcMYJLc9Mu6Mx5V8o2RVUlAcKDaGu0Fu0r7Qt65C8rPmrpEAz7vx+KSEHG+KkZ2LTnfrea4RsFoYtGln5zCGucSDbn9eDjOCJQ8LRujEo2cAu3KPFmcZqICp1Qkf1FwnN9kEnfRJtfzo220FnJC6hkEnayf1ManG2nNA0iQw726FAT35gE9VtwBtdRlzUZaWTBhChdLCStHwqKab5yOvDX1M0DVZEeWHodmjNPDmAWUmpqQyZWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLp3FaSrk0HaF3d0S4c7U91ensuBuHJZrOOjUlSM1zQ=;
 b=s07WOPbzJPRThZLegXXgNHy+KIFaGCW+uu8IaGnXmU15SL0G8iyq3pjp2KviM6dHG6yZY+1NlVzrKKcj811sNFl1a/tkpP2z7OE7Vycj8KG6cNaecU8cDdwje+YX6tcdH5WwJV/friLJAcTHfH3K0A9/qVHYYYZi8MgJWAgMKTTskhNLe34OWiGnPxQny89Ci9OiTQHmXuRZmdNinrhc8KIzEfEZhzisC7QFzmdU42fnvxDLIwRZ8VozW/HwjdSaNMLZfPvwHqIaiQ/vCCKwypeDoxCeNw8HM8d1Oqu5sMMbjkzMckeGgjW1g/ymKMon+dTesfKARII+8RR+ueLXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLp3FaSrk0HaF3d0S4c7U91ensuBuHJZrOOjUlSM1zQ=;
 b=Zwe44InxBA59F7dq3urRUreQeUcemNBX7n0Xa+mYouO1WTAy+uLRyStaBYlFc30vtJsAX6qYvsN5DfaT2ZRGnupRPaN7+PYz+yYFNni6v0Nx270pw+259eVZTO6NgoW5UsJFKxiMcYkEDjaaZBeUC7utgBVOTGdevLeRFo+W4L8LuWEOinga12A8IQj7QPV0QB6/3tywAzh03h8L6duF9derUZ+Z1luLsRDKwQp7rN5dtFh9HiOl94g+lLdcVGXbBjq4pobQtaJrE1G9WYx2nB0Xa/h8WHMg7kV5z5kU1nYlxtCL6nhmuGFawxhuxay7qlic2r9QEkxArMytXB1RLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 15:23:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:23:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] mm/huge_memory: add buddy allocator like
 (non-uniform) folio_split()
Date: Tue, 18 Feb 2025 10:23:05 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <4F24EDA7-BC4D-4ECD-941D-596AB6845570@nvidia.com>
In-Reply-To: <20250217201242.798583040111ddc019f68438@linux-foundation.org>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-5-ziy@nvidia.com>
 <f1198e22-3358-4f82-8227-49b0e779302f@redhat.com>
 <4483B46A-FEAF-46D9-AFF4-F0DF34864633@nvidia.com>
 <A6E3A545-D2CD-46B6-A532-64BBBED42914@nvidia.com>
 <20250217201242.798583040111ddc019f68438@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c14689c-4096-4d1e-0c43-08dd50302723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GbUZuxPxONwA5zuym7GRDp7zqbW7jl60mdBNBSpVVKVQsMd2z5UK7tCGhcvW?=
 =?us-ascii?Q?AAgb1nvjdns6WA3w20wH2dLfgLjGp0H2crBL66p/jDRl8KZwMXm/BO1rahRp?=
 =?us-ascii?Q?A0JmlmWXzW2UEYkVhU64ZvOwYSwbRuzUNE5BfHFqV5X9IbV0aLPMK9ZUWCAJ?=
 =?us-ascii?Q?Ad4XDSKmrc5N00VfO/lUdEzxijnM2YwaL+K/i9ogcOquJtirxx6fjlQQ1g/A?=
 =?us-ascii?Q?egSGHuES3S1EEYMtJ+r3nStkPm2gbG4qd7jU5EaJB5IDqj2Mck1fle64klZh?=
 =?us-ascii?Q?4Tp3rEWOaFYQxbOCXF4t1+DpIxDZaBI8sdNhorjAd8rWk5EcIODd3LS/atqk?=
 =?us-ascii?Q?YLViWDIZv6FAIxWfk9klibfzjODTO1qvPfJaMacTPN99O/bL61LC1fmOvF0B?=
 =?us-ascii?Q?P6w1Tlp//lKIGtWTeTK5g8ja/Fb/cuUWyuegNG8kiLiZT0BCJQ1XGIX4HdC1?=
 =?us-ascii?Q?tJGmbit5qn+tik9E3lMJAnx7fQIhUWcqwvGAt/mxxh3rRfqoHUaf/zAy98Kj?=
 =?us-ascii?Q?LgmvPzO3IPjCBcqzB92QPTjsLtY4lK/l3p5S9sOIH5hnx8oqMBhiAnQG//1Z?=
 =?us-ascii?Q?nL2wlN1SrjqePHJiRoyjSYqogXC7wTD5ArGzK+0bTIe+cbX3tfOsFg4NOKoJ?=
 =?us-ascii?Q?Cjflpee+qZyaN5q1Wpld1VxdeOEioI0T188K3SaJrx7CySz5rtmmKEl2e0w6?=
 =?us-ascii?Q?XznJR8bO9S2U2oDLap6FoKs97cYOsbz3BuqOIVfzAicrSnwtNOEA4dRKKg04?=
 =?us-ascii?Q?Z1rDO6yR8Z6Kte3GuW0O8e46j0c37OgP9w8vvKsZ56Q6JqXHXb48KzC5rBdl?=
 =?us-ascii?Q?9ZY8JnNfme8kFwlX+UnpVTxvJRPoeF1XczPqr67QdJoup/6Ler4abbjBG1Xc?=
 =?us-ascii?Q?oieDP4MronxAO3zGeelA8yjlC7T1qMwKuqOkRVtud2/gYiz43NbyiaxzIB1b?=
 =?us-ascii?Q?7Up84YoMIkaJfyBIWyFDu+ArU5einqxIV0sZ2mw4GVk/Kv24UC6rRVA309nv?=
 =?us-ascii?Q?wxrNOUKBC+ypiaaPA27iqrdXcdr0D7pU4qtiLNv+lkSzwNip79w1RchD/ncy?=
 =?us-ascii?Q?eiYxrwlnPefhGsJWDY7BzpwdtAHH5b7WUwj3mxXK+TVdFtJFl1LR1UUUskRQ?=
 =?us-ascii?Q?TwLsk2t3bAlDjswMr5dK5eHedR31Q4fC7TYrFBaUiVC2MSBA9UnvHTsYEY+3?=
 =?us-ascii?Q?3J8TwZDXz+0jt5MUrXFcCZD0lwoOlTwfJk4xGDZqxn7zD3NYARhheq3+g1u8?=
 =?us-ascii?Q?kBkTSg+8/tE4tRYxvuBaNR860gfMvJvRnDvbpWCuoeQvvJouaMN6UCnJvB0K?=
 =?us-ascii?Q?55UIVFYnvEJmoqFE2kr3hn0R2aqoYaCrXLBYVwuzp0tAfB8irYLp5OAy2QGy?=
 =?us-ascii?Q?W4JWyz/FwZPzhKl3MlpdXRl424gp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6sRL1gDNHK4HaG30kWa8Mwl+Y0we8VbEv9JRi1lrh7eFrAW259o8woMuJsmJ?=
 =?us-ascii?Q?kjiQyizLTKLLx+OGScxn9jfJApSEyQewrLZNk3DTuZWN3Xov1pAeKE1WPuKi?=
 =?us-ascii?Q?jNKEFc9Y6I/8huH/PQqNCf7fQqeSFgfmMaaeF4pXsCS8ZlbWRkeQLRJZJCFB?=
 =?us-ascii?Q?GOv1nlASSC7QQoVhf14fYxYhulBPSy6wOYICrYs3Vsiaip2PaCgjxLGubeuj?=
 =?us-ascii?Q?QJn8d1vhSGfkeYhjAbfZv03PikIOnT40G11BJ7CkHyfSDtpAY2A9TRkO8Jg6?=
 =?us-ascii?Q?I9mfzNqYze3XKigdb4vrblgFkiHHRroiMFkpyvARMwlbMfS7l6zt63Y0j22a?=
 =?us-ascii?Q?baTgeRe0rKvP+8TpXdpjdWeReKgpUebA0zL56rKLsIJ9Xl8xOIyL1jf/gE8v?=
 =?us-ascii?Q?2mZeEKOjG7dREnDCQa1etX+8L0AI9a/plvT4RDHvIQy8nUE7l8zK5xZvY9sF?=
 =?us-ascii?Q?qNYx2B9UV1vI4nY0YlAci0i+oHOeP+gDRMnoiOLH426zRXdIE0kvxMhl/H2y?=
 =?us-ascii?Q?ML+FpbX1P9chkWnTikGFIetjdwryAtHA5CFrDo9bybZBCh/8QssqyZwqFNTu?=
 =?us-ascii?Q?BOpdHNHWECTxJE/bXV318dJsesPBwrE7xS9AkDWEBfNrXEwUyyka6vDlXPcZ?=
 =?us-ascii?Q?/DQF7/+C+sPsqJK4EsFQxRAW8aYf4Dtbrz9tt2eb96eD8nD8c1x6xOilrZ4v?=
 =?us-ascii?Q?un/2roZGRb5nCdXP2+KBFBxFmK1m6r+0WKsjDMje+ueDZ0/bHK4tdyc9n7cE?=
 =?us-ascii?Q?2unTcb40qQxe+E+CBPHYSQyJvdil0WK4/yhocQSBWAz0cvTLEo4n2SnsIF+n?=
 =?us-ascii?Q?O+5yqx1+zm0EXd2UFiOwIEYQyQWUUvHy1jzT8TtoiX4G/b9rNkOrb4WZWVkm?=
 =?us-ascii?Q?MvmqD6m81NNbRGrKI4kXP6HdJ2EG65XPIDguPhvGAUd2MzM2cZsS63LaPeWc?=
 =?us-ascii?Q?2MawrXCw/B9HtuL/LI6MBc7c/wL1xyhvuBR2k8GBPOuGX0uc0ysQLUn8iI/a?=
 =?us-ascii?Q?e/49i02yIVtsfQo0LUWryphqc8AOkVdYbnhYihqCikSri7enjPOqmD+Bq0zJ?=
 =?us-ascii?Q?05WKp00ZcP4/fAmglUdaVobDeen9PnYOs9//xxXgryD5xMZ+QQ8Uedbwo0Y5?=
 =?us-ascii?Q?Y/MQH/oUQPqlY6aknxWMp1krbwSxu3/XSFbaNHykDNDMig98FoOeHuqrOD0a?=
 =?us-ascii?Q?IvLARqqfLAZVzu+DkM5E3W4xRfU4QQnDsdVX90lneaXXuIYa0ngg3EIk0sNJ?=
 =?us-ascii?Q?N3qYjIWrdjiJ/72EChZfS4ApFSVZKx+WfVnS3B+svhOo57YxVAJzmTJrck4m?=
 =?us-ascii?Q?XfAuI17KVcc9VstKEBupHjA9tZPHDIajwnykgXETTeFn/j4CikXdo0NV3Ue4?=
 =?us-ascii?Q?TakqH4YYZRG7Sj2KIuAmRgZk4f7bFanOCTkXOoTAzu1dBUVd1z+Z5nqRxSki?=
 =?us-ascii?Q?prSrm0WBD3nGtYj4Twt9IcpSLiEfOVBS16svyqqeypa3M/2LiadFFpy7RQGQ?=
 =?us-ascii?Q?UDDNWliOpoRmhMoYLGG6wteWg713rCS08Xzpz4KX2kc7QtGQWRxaKU0u+c/1?=
 =?us-ascii?Q?jEz5anKu5Ptj8ne1yUU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c14689c-4096-4d1e-0c43-08dd50302723
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:23:10.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/8X3SNVd/l6tzbqel1LntUmsmHhetWFcVbbBQYx/PDB44mvtAMY0r16agH6xZyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

On 17 Feb 2025, at 23:12, Andrew Morton wrote:

> On Mon, 17 Feb 2025 10:22:44 -0500 Zi Yan <ziy@nvidia.com> wrote:
>
>>>
>>> Thanks. The patch below should fix it.
>>>
>>> I am going to send V8, since
>>> 1. there have been 4 fixes so far for V7, a new series would help people
>>> review;
>>>
>>> 2.  based on the discussion with you in THP cabal meeting, to
>>> convert split_huge_page*() to use __folio_split(), the current
>>> __folio_split() interface becomes awkward. Two changes are needed:
>>>    a) use in folio offset instead of struct page, since even in
>>>      truncate_inode_partial_folio() I needed to convert in folio offset
>>>      struct page to use my current interface;
>>>    b) split_huge_page*()'s caller might hold the page lock at a non-head
>>>      page, so an additional keep_lock_at_in_folio_offset is needed
>>>      to indicate which after-split folio should be kept locked after
>>>      split is done.
>>>
>>
>> Hi Andrew,
>>
>> I am planing to send V8 to collect all fixup patches I have so far plus
>> the one below and change folio_split() interface and some of the code.
>> What is your preferred method?
>>
>> 1. you can pick up the fixup below and I send a new set of patches to
>> change folio_split();
>>
>> 2. I collect a new V8 with all fixup patches and folio_split() change.
>>
>> For 1, the commit history might be messy due to my new folio_split()
>> change. For 2, Minimize xa_node allocation during xarry split [1]
>> patchset depends on patch 1 of this series, which adds some extra work
>> for you to collect V8 (alternatively, I can send V8 without patch 1).
>
> We're only at -rc3, so I'll remove both series from mm.git.  Please
> fully resend both series against mm-unstable?

Got it.

Best Regards,
Yan, Zi

