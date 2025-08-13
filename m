Return-Path: <linux-kselftest+bounces-38913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C3B25606
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794947B8BB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C582D0C6F;
	Wed, 13 Aug 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrhYP55k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFF21638A;
	Wed, 13 Aug 2025 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122216; cv=fail; b=i8Cw8veeBnjAw3bNhJLKALBoleZFZhvfE0fq8p7+aTUpiNyQQOOwjo9UzYkbu+26cHNbY5KmPu2WgXxvXuAgIfV456XKQe+ICWURqBvrq4Lh/AMZ4wVnLCWfxC69QiZOPpfZDTH8Rvi/xb+sNgk72sNoJIhMtI5Bc92F/8vk51U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122216; c=relaxed/simple;
	bh=FSN1QtSkTxn1laIvSFXnthdl8Rk/pYhFk0OA0zdQ1/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPZ5WWPGFXt1LNoXOd7dgKo/2EnGQ0OxyZIy5bq09ikZXlifE60/IwaVaPf3S9t3ZMeB4R0YYnohe+i/UrFRt9Wvy4pXlKLyv8m6/tJChGOAgackQH0PwOULO2TKdphXo/KjrfMF3Sq0YQQi4ouMYZnNaHOpQ86/ST2Xtl0dMak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrhYP55k; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELlilat6oo0SKAje2Vlie58FDSUhuyM77GI/QhEmVCU0hqgRzoWE+IhjKhD7kv3t191+2hDpfOFsgGAfpQtruV8dtGdDrFgLiAnIUJzvpyaVoA081EHiluujH7V0b7kzrQMTxayOSSvy4FHsH0mfdxUZh4+voLkZl1u1KXFLqCBEQ+GwYdfvywTKDgSTKfO2S4shvmfY/CGlqgnZcsNg9oQW5aQjUBEkg6uurIFXd6kdlgivD5HgGMfhozZGVgW/Iu3lBhR/nDC8O05ne8AqKgE2WNpybjRH6v70SayDjTY8bb74gSWVtdAQW6eZMFcOX7o0D70jC9JYCqDlG4DdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NFaaHeBSCwGycNUC4KYXF0Di7uzRnMibfcQfZT4laQ=;
 b=IyP3DDm9YVjbPslzSAIvfnrZB5lopCKCF2vOsm/K1rrp0ARcV0V6Qx85NscKSXPNoLSmZ3O1YXIv8ZT5YdTqrrEP4bPODDG9aRbUNS53FsbgiKdF5U+csMWRiCP5leo8TmnpT49qLdYsk0SIgiSCIuXGAD9OqVKm6CUVuE0ayuVOglBHz6IMpQcX9rgBH/XNDGwBvw4gQgKt/ry1rqplPT8EN3xV9PHrsdRaEK2eUwxKt7DX/2ZS10YLgDiALwjBEES4TzUfGKS+jvC5e2SyXrBGuCfuUwhnpFh/hsrRd/oEe8xwoEU/1npt4ZsQv6DnrSerjXMsktvMExhw2UWKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NFaaHeBSCwGycNUC4KYXF0Di7uzRnMibfcQfZT4laQ=;
 b=UrhYP55ksXZYQAADHFgQbq/IZqimwIoZaTMHT0WoEXh69aokzO9ZRCCaIocq/Ru9ioucEwBOYl87XaI7rpiU9Ijvc2hvN0VfEyzXi/AfhiY7Rt3FH7LRksVR4DDmLtoEMIfgZx3mH+H+r9f8ZrVbJ1QktfdJUhTkAL3jvaFgdjFxHmE2WP9meWSEXng61vRrUIpJ1/VBhjkENW+MJOHVQ43xcwyAdS5MV3VmE9L9UMtHZ6YT/JNJ4eqVMbv9jwOiu3gsp03SvYTDtPS3YFl4QoeYiQjQqkcGAU5YPtNTukyFAe1lttF+PoPLTwmUsqtR8CXspIEMees0F76Z5JVPjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 21:56:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Wed, 13 Aug 2025
 21:56:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/4] selftests/mm: add check_folio_orders() helper.
Date: Wed, 13 Aug 2025 17:56:48 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <80395DD4-9A79-461C-8F53-C9770BC10A6E@nvidia.com>
In-Reply-To: <20250813211244.ikequq4kvgs65mpp@master>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-3-ziy@nvidia.com>
 <20250813211244.ikequq4kvgs65mpp@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:36e::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f0aee2-845b-4f2d-dd1a-08dddab44f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GDjq5IIceimx7SuFfW0irgdFqpk9Ti3ZtzTi7PeQ4XyWkKakP8jyV1yxQhM?=
 =?us-ascii?Q?pY5oFEmkExbspaJJ7Hq45FG3fI+bXzL8M1WyLixjNdCQkQzhp+XElQdj5irt?=
 =?us-ascii?Q?sedDd9J50mPdJVVdZLOoioxfs4SLlzsjMavj4j3V0dp3mS1KXAy/URwEJomi?=
 =?us-ascii?Q?VTPwBx8+IFj8VLz45HG76V4Gh4WZtvufUJPcnY06jfHZJPY3AvPAbSgdqpe5?=
 =?us-ascii?Q?HwVFF4OF/OtUK1ckoDacuBGLWg6JuEslyKfNzMzOT/dVzkfDYUxYaobX6HpW?=
 =?us-ascii?Q?RF/HZTGFA8lhQRREbBFnKajVlYD+RbMDiCvGScpwZp341bjm13KWtvZjWSVo?=
 =?us-ascii?Q?NM1U9sQS4nJPvJAGXVubkafJpgV1bT7DyPPq1wuGj35Ragb8tCVlTwjP93J0?=
 =?us-ascii?Q?prLpBuUdn3QTvZ4Bee1IbaKLDROQWmp1pfP+agYdSuuU2wDdFOrnJ8rG5tj1?=
 =?us-ascii?Q?UCCvQ6iSMrL83cHJVdR6+4CGJCsIWtPAOzMmMsMbmH4jrwptI5AU2HPQw2l2?=
 =?us-ascii?Q?9Pj97tfkSpouYPOFtycI2rohl7gpkc8zmo//ijWUVeC0T3TQ4V1D/R2i/hVl?=
 =?us-ascii?Q?KpYCdwJcgwnPHrq2FPt8UVf1tzsPXCPjpub4dXBk7RzDLc2zC/Uq5y2MjFqv?=
 =?us-ascii?Q?DYf2BKmGiD2UTxXQV8/DyOLsBx+Hf7zUPltasjMdKxkSVPGlBDz1II5FabX+?=
 =?us-ascii?Q?zyZm4U7ADOtUUdrHJVzLpkZk2A6LdoSgLnLxTrJhqE/S5a/F4Fr1w0XD9I88?=
 =?us-ascii?Q?zjTyhYSQUlM15FwUxEDaTeHBbV3MriAN9tlNpDR8r13fyTWZQabdmnGxQnKg?=
 =?us-ascii?Q?xy54lZb+loZeexHJbm8yJ83lue2czyX7V2wOtJFTXMfFEiw2NbrtcgU41uef?=
 =?us-ascii?Q?Dhs1wKE0Z2/EdCX+5kAFQiJETdT6a4H/vesrNt009fXgDFksvFIYax2qLS4Z?=
 =?us-ascii?Q?nJ+8tMhrT65MiI9B/eGDMOLiYQj3AnfRima/PXIoS8yMaXYM3E7sCAqZIwd8?=
 =?us-ascii?Q?wpe/ItSmrQgvGlqkf9IPIIAQSUDEOwVSBKhFYaJ8hV2dbgOLPwSs6mrdqYOz?=
 =?us-ascii?Q?YjbPlrWF0+6GKLqplA50PzW2/HpKYMj70AiCTztXhRFRkU/+97l7Tdm121gU?=
 =?us-ascii?Q?/njNsURzuu7ta8QNu9LDYtrBEFQLTTRcSu8XM63qCQt81xLijmELmkmaoBxm?=
 =?us-ascii?Q?odYnA8g0b3RjvPYrLG80P04Kq1Gn+X31qvQvCSKSbJwpNacMy3dj68sxIZWM?=
 =?us-ascii?Q?t9j5Zb01ez9WXDsAWxTXTNtgK0nd/DuAVrn0+p79fctkPt8XsXuzhGBgzmmh?=
 =?us-ascii?Q?9CiKf3kEz+4uUDhr1DzfYXsjSidixnVmGo3vgEfQWGkriHoPfdTEVrDRV6DR?=
 =?us-ascii?Q?1nIyA/AvvSbbc9XsgwrVoIdqfvdwVt7InNEny5D/ZbTahlumwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eRXrwcCVrD1694o8tCgxJW+k/yflJFfGepw8zQU5rSiimkT7sdY90rEBPvtv?=
 =?us-ascii?Q?Q3UpG9oVba3iwmFJArpZVtTZvMe6L3mt1FCmhvmi9UURqmVdp6Cn+3028RXc?=
 =?us-ascii?Q?0vVVLAdVBv2+/NSkIBIT6QgK18kJID8YGPH1xo8qN46HxXX89XZQcblMh9n0?=
 =?us-ascii?Q?thrqjeUJiIkoKXT9/bJhs958nx6uvghJZgjKwFc3oPN0RZNykQGkla9oVz71?=
 =?us-ascii?Q?kHL1lY8IGAXHq6iKnhpRJ8+gzOSmpraWmloNx+b2aRtflnryBQsewRJidQG/?=
 =?us-ascii?Q?7uokAnYr57bqCEFGj1ogazej08rOLnczNpC9Tl6l6b1ZXmKV8ou8o+FZ79gT?=
 =?us-ascii?Q?xAskLexqIIIqGIUoUjEwvc1a5UjDqYaXsnPuV1enfbhPx5vg8ENzzEK+tE+5?=
 =?us-ascii?Q?oYy/a9+Id5U7TsI+hoAkFa7x4dSKj8CJE6eBX1iFP9oupthjwiNPjAUp1coJ?=
 =?us-ascii?Q?ouoylpmsNPSE8I8LaTvKXV/gojr/ExFRpsEJvpugjh/qMl6SSkRX+q4OgYJn?=
 =?us-ascii?Q?BKanw6bBgYKHgnEXyWbt14ycrLfZxsFV11UBCEyYIKhg5S0ngwGkJ22vTCOh?=
 =?us-ascii?Q?0e9FLiS0lbfbZhBusaT841zd5T3Wmdluhx8IjnNcREEIIs5oaexOp2Vucoqw?=
 =?us-ascii?Q?5f0nSZhM+P7x463ipVNssPcHma+0H3QsziCDrFH0J+LyXO6d848/TWeo55NS?=
 =?us-ascii?Q?TTwc7LZjPwEUDjXPAzo6VxMqlfFe73RXb8VZ3RX5IfWROesU2oEW3lzIWch6?=
 =?us-ascii?Q?7Wl4sG7WtTBnFBu5MpRrzZ5va20VT12HZ9qR+qyh7zYzoMNJgKKyhkG//I3R?=
 =?us-ascii?Q?MvYsYRSXuAcL2k7oK6QrxsLgaW9aQl8nW0XiSgnLOyad1mfvYcVQf6OU+D2P?=
 =?us-ascii?Q?jiRCLniqs2HCiHO4okMFQFqRCOOro9LQi8TmTv4qTWKA6rG+naTCchqhT3ZL?=
 =?us-ascii?Q?9sCO13993UqJ/n6/M7hsA12L/FoWMps8KDXBl+Rbu2jJRqyRzz/XIpQ7BLQd?=
 =?us-ascii?Q?YsNobCalOCNeK2NwUFUDPYMCSmUqEjPwN9M2cA757lNV+3DCegibMtd9mUVm?=
 =?us-ascii?Q?4XuHFnr460/vP0/Y4UzrOcjvgN8CnphVSOh1NuKE2i+1TD6TMmyZhq1jWqpM?=
 =?us-ascii?Q?2p74YTzkHIeSvVBgaxfX9kxcTjVhZ+rI0OegGSQO3HRgCtgJ4CVM2ykmmc8k?=
 =?us-ascii?Q?hFNTcaIQzdqI1cGb7VEuOMov0EqPUxjPsX52tDyjs8w25Vrh4P8kKgLx53jH?=
 =?us-ascii?Q?5uIiVPMpTMrI46TvVjuTfA/y5UreCfsNNF7Hwe2bOpGV20ZsIbydg8zTA36E?=
 =?us-ascii?Q?eDxvhhTDBiGWtO3t5UmJ6I54N4QLEHyWI/IaqKGPPoG0ifXR5amKlfEfQ/wS?=
 =?us-ascii?Q?6MTu135+L4k3ef7/BtNgWNWaG2eMiJy2szBpJRjy2iPvNtQxZSjk3AmdzOPP?=
 =?us-ascii?Q?TCCKNM/13gsozSmJ0BkSbqSpRVqMNTFhe2cE1d1Wl4d9AcgRhLAHZlUIaTRi?=
 =?us-ascii?Q?26KsnZYYNGUcnABrm4EH6alBixi6XBY/1c+ibl248Qt6BT/Us9bsEueYczKL?=
 =?us-ascii?Q?DPdmuD4LS9xIlQKjM6o9jHbU+jWVb/w338CoSRc0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f0aee2-845b-4f2d-dd1a-08dddab44f16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:56:51.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RS8237+fMuLUzT4P0hNTFXqbVZ/rG7v7ulr4gPgPlntwq7R6lfh0llpCE/gG/MQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

On 13 Aug 2025, at 17:12, Wei Yang wrote:

> On Tue, Aug 12, 2025 at 11:55:10AM -0400, Zi Yan wrote:
> [...]
>> +/*
>> + * gather_folio_orders - scan through [vaddr_start, len) and record f=
olio orders
>> + * @vaddr_start: start vaddr
>> + * @len: range length
>> + * @pagemap_fd: file descriptor to /proc/<pid>/pagemap
>> + * @kpageflags_fd: file descriptor to /proc/kpageflags
>> + * @orders: output folio order array
>> + * @nr_orders: folio order array size
>> + *
>> + * gather_folio_orders() scan through [vaddr_start, len) and check al=
l folios
>> + * within the range and record their orders. All order-0 pages will b=
e recorded.
>
> I feel a little confused about the description here. Especially on the
> behavior when the range is not aligned on folio boundary.

I was too ambitious on this function. It is intended to just check after
split folio orders. I will move the function to split_huge_page_test.c
and rename it to gather_after_split_folio_orders() and
check_after_split_folio_orders().

>
> See following code at 1) and 2).
>
>> + * Non-present vaddr is skipped.
>> + *
>> + *
>> + * Return: 0 - no error, -1 - unhandled cases
>> + */
>> +static int gather_folio_orders(char *vaddr_start, size_t len,
>> +			       int pagemap_fd, int kpageflags_fd,
>> +			       int orders[], int nr_orders)
>> +{
>> +	uint64_t page_flags =3D 0;
>> +	int cur_order =3D -1;
>> +	char *vaddr;
>> +
>> +	if (!pagemap_fd || !kpageflags_fd)
>> +		return -1;
>
> If my understanding is correct, we use open() to get a file descriptor.=

>
> On error it returns -1. And 0 is a possible valid value, but usually us=
ed by
> stdin. The code may work in most cases, but seems not right.

Will fix it to

if (pagemap_fd =3D=3D -1 || kpageflags_fd =3D=3D -1)

>
>> +	if (nr_orders <=3D 0)
>> +		return -1;
>> +
>
> Maybe we want to check orders[] here too?
>
>> +	for (vaddr =3D vaddr_start; vaddr < vaddr_start + len;) {
>> +		char *next_folio_vaddr;
>> +		int status;
>> +
>> +		status =3D get_page_flags(vaddr, pagemap_fd, kpageflags_fd,
>> +					&page_flags);
>> +		if (status < 0)
>> +			return -1;
>> +
>> +		/* skip non present vaddr */
>> +		if (status =3D=3D 1) {
>> +			vaddr +=3D psize();
>> +			continue;
>> +		}
>> +
>> +		/* all order-0 pages with possible false postive (non folio) */
>
> Do we still false positive case? Non-present page returns 1, which is h=
andled
> above.

Any order-0 non folio will be counted, like GFP_KERNEL pages.

>
>> +		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>> +			orders[0]++;
>> +			vaddr +=3D psize();
>> +			continue;
>> +		}
>> +
>> +		/* skip non thp compound pages */
>> +		if (!(page_flags & KPF_THP)) {
>> +			vaddr +=3D psize();
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
>
> When reaches here, we know (page_flags & (KPF_COMPOUND_HEAD | KPF_COMPO=
UND_TAIL)).
> So we have at least one of it set.
>
> Looks not possible to hit it?

Will remove it.
>
>> +
>> +			vaddr +=3D psize();
>> +			continue;
>
> 1)
>
> In case vaddr points to the middle of a large folio, this will skip thi=
s folio
> and count from next one.
>
>> +		}
>> +
>> +		next_folio_vaddr =3D vaddr + (1UL << (cur_order + pshift()));
>> +
>> +		if (next_folio_vaddr >=3D vaddr_start + len)
>> +			break;
>> +
>> +		while ((status =3D get_page_flags(next_folio_vaddr, pagemap_fd,
>> +						 kpageflags_fd,
>> +						 &page_flags)) >=3D 0) {
>> +			/*
>> +			 * non present vaddr, next compound head page, or
>> +			 * order-0 page
>> +			 */
>> +			if (status =3D=3D 1 ||
>> +			    (page_flags & KPF_COMPOUND_HEAD) ||
>> +			    !(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>> +				if (cur_order < nr_orders) {
>> +					orders[cur_order]++;
>> +					cur_order =3D -1;
>> +					vaddr =3D next_folio_vaddr;
>> +				}
>> +				break;
>> +			}
>> +
>> +			/* not a head nor a tail in a THP? */
>> +			if (!(page_flags & KPF_COMPOUND_TAIL))
>> +				return -1;
>> +
>> +			cur_order++;
>> +			next_folio_vaddr =3D vaddr + (1UL << (cur_order + pshift()));
>
> 2)
>
> If (vaddr_start + len) points to the middle of a large folio and folio =
is more
> than order 1 size, we may continue the loop and still count this last f=
olio.
> Because we don't check next_folio_vaddr and (vaddr_start + len).
>
> A simple chart of these case.
>
>           vaddr_start                   +     len
>                |                               |
>                v                               v
>      +---------------------+              +-----------------+
>      |folio 1              |              |folio 2          |
>      +---------------------+              +-----------------+
>
> folio 1 is not counted, but folio 2 is counted.
>
> So at 1) and 2) handles the boundary differently. Not sure this is desi=
gned
> behavior. If so I think it would be better to record in document, other=
wise
> the behavior is not obvious to user.

Will document it.

>
>> +		}
>> +
>> +		if (status < 0)
>> +			return status;
>> +	}
>> +	if (cur_order > 0 && cur_order < nr_orders)
>> +		orders[cur_order]++;
>
> Another boundary case here.
>
> If we come here because (next_folio_vaddr >=3D vaddr_start + len) in th=
e for
> loop instead of the while loop. This means we found the folio head at v=
addr,
> but the left range (vaddr_start + len - vaddr) is less than or equal to=
 order
> 1 page size.
>
> But we haven't detected the real end of this folio. If this folio is mo=
re than
> order 1 size, we still count it an order 1 folio.

Yes. Will document it.

Thanks for the review.

>
>> +	return 0;
>> +}
>> +
>> +int check_folio_orders(char *vaddr_start, size_t len, int pagemap_fd,=

>> +			int kpageflags_fd, int orders[], int nr_orders)
>> +{
>> +	int *vaddr_orders;
>> +	int status;
>> +	int i;
>> +
>> +	vaddr_orders =3D (int *)malloc(sizeof(int) * nr_orders);
>> +
>> +	if (!vaddr_orders)
>> +		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
>> +
>> +	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
>> +	status =3D gather_folio_orders(vaddr_start, len, pagemap_fd,
>> +				     kpageflags_fd, vaddr_orders, nr_orders);
>> +	if (status)
>> +		goto out;
>> +
>> +	status =3D 0;
>> +	for (i =3D 0; i < nr_orders; i++)
>> +		if (vaddr_orders[i] !=3D orders[i]) {
>> +			ksft_print_msg("order %d: expected: %d got %d\n", i,
>> +				       orders[i], vaddr_orders[i]);
>> +			status =3D -1;
>> +		}
>> +
>> +out:
>> +	free(vaddr_orders);
>> +	return status;
>> +}
>
> -- =

> Wei Yang
> Help you, Help me


Best Regards,
Yan, Zi

