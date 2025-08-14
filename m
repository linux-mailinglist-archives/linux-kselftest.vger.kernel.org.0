Return-Path: <linux-kselftest+bounces-39000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B5B26DF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 19:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A81BC1E41
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854130E848;
	Thu, 14 Aug 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6ea0Hug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BD30E83F;
	Thu, 14 Aug 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193809; cv=fail; b=ZQCYzNganQwS2D2Bt5sDFGVhutjyzC/eLtvlS1wDPSaCJrM17kc31AvL+3qzWjaKrUzZxi5DEJLfQtwxVmvIYRx9Oe22hE5vT1g/QPu4tyHeuSXfANEMZzSFdkj2xaZo1y/2ZDSSpVOOYiTJ7XA+OZRj2StBIeKyLzyskfSZzks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193809; c=relaxed/simple;
	bh=BAlOloI8UTxlsavGEZVst/gelSCeGanARBuJR4D+IOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMzPuzMBb3Xu5P96FoBvo0+Xn2l8Lh8NqTSZliaMlupI/O4eceQ1O7ZXXxnGZ6R8ovOJTzHa0gDa7rHZIbrsHKAielv9+sRR2NGGFgZjgw48wZ/cpK6B55JeQYNbNp+X/JxrM9c+fKtQIjCM59KMXmpQXy9LoNlJK6idAv4hWk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6ea0Hug; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EP2Z/E0oqrfZLqlIZgzp6V+mnRzz2gbfKUCzWVZJBQyqohD2IYUhmmHJVRq5SzjjZ13cCWFclatwds/1cyr/Ax3OcNOiBC0RxbYJ59ttPmuLpqasoUF22aTbuMIPHOojFhHLNWOZzpxiDmOxBXWhzoOP48ln7ifQlCjTYNJ1wK3umkAkDhIy9iJ/9N5n74cLC8pQZwf5OZxx0/2le8j3Hx0JB8x/7G0b5WjsD+OgdPP4NBFpVMlxfmC23CtQKUTHqwCFdizyOg5P4GmOIgn1p17PHUa43GyZ2UUMkrQHVRakjgzNlAieuamRMr3ayrEKStn7+B23huQQflSYCovXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhlyGSOr13pqKa21IM6Xom4cjmnpuXhgS9eOMgdcovE=;
 b=Nxf0W5yX57YqNKITVQhB/ey42bMZH2jvU4CkfKs4VaDWnmNVD/eCqC7K/2aDPShrpA2NaTuUqv4N2JIR6C44JLibQahV4KZGSayV3Xt2ark4G8WlcxSwKSyf5LmLMqzz4yG2GR3WphbxUzcZuZQGXP+L8IRK2b/M1DBv6Dz0pKLHwgDNqY2y+jPfMiOF+db64gpkikKl2R/JqCttOV4EsSzbXk1Vc7EDwzUHAVCd3Nl3St55jcG7AvXphv7wEqR0tFC0me6oJaBDZg/sC6HcHb0FL7PKljNiYwjgbdTsQD1sZ1H1njLIqkjm870CEI3u2D7vyoMVoezjKEReEJcUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhlyGSOr13pqKa21IM6Xom4cjmnpuXhgS9eOMgdcovE=;
 b=B6ea0Hug7VEon4IFsJ/ISsuIvSEhKA3SFToAUTcJlYQEnbWS0lGUpb/CA89+UdtqNuG5WdB3jnvfNZzFE5z+pZuwCdRDwg6ieYK+bn641KHW1jixFfypLgJAdgjeGSAYnjXQNzwY95ziAPH1Cm5ufP33nJFVBqS0jl5vxq/k7R21H4Y/OC6M3eZ+uebSBVCFs0bJ3WRKWrOc8bxvUSpzrLF/Huvr41hP2EMtAeAHcuVeVLiPt5MluJCS8gb038PPKa8J/3oin6yIAsqh0lJQnKyu27M0MvbdbKPcqllsJudd9ZYRtsdwrBh0CuUOffHFpJhNz1fitigiz639Dxm1Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 17:50:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 17:50:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
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
Date: Thu, 14 Aug 2025 13:50:00 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D669F967-AB2E-496F-87E4-56E624D3D6B1@nvidia.com>
In-Reply-To: <DB5B4E8A-3CE9-4F15-A52F-BA75E9BDA4FF@gmail.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-3-ziy@nvidia.com>
 <DB5B4E8A-3CE9-4F15-A52F-BA75E9BDA4FF@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 56148619-1351-4b3a-71bc-08dddb5afeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbPYvVKt4wB1oOjVSQ3UWwR65TqjBoezdYTf8NUAKxla6OQj4szAHGkhIodh?=
 =?us-ascii?Q?6t+a3wkwJT29OCvWi41DMDttGm6bWTvYeeslkzCrHXpie0kclvGEb0biPQ5C?=
 =?us-ascii?Q?sScNmqDFEAdssjtdO+B3qtxM/95SqLsbbYE3PjFsidD/WwkQNNJHgbmYg+us?=
 =?us-ascii?Q?4JY6rXr/UoKXZtM8vyxlnQyvP9sorGwi2nJ8IKWwAwD80PKQTERdsZcPUa8T?=
 =?us-ascii?Q?3/pf46zdKCKX18rdB/9zHZ0ye5FU/aDbfNiBf2TdohPu5gZKwr583GjYitmw?=
 =?us-ascii?Q?B9W0WAiMDzMsAUt0boEb31fohOl98q1bGqwMjMW+7FXicnowA3ZY0t0us2R6?=
 =?us-ascii?Q?qil89t6GIXr8sWxIRm+zaoYbbsyfpV2e+Iwnwlii9FzCknQiqHTfFJL8XkRO?=
 =?us-ascii?Q?3K0LXD4iuyWTGqLVGHr4gm5DjFNbu56FB6YNaSSox2xwrLf8Dc9LflgsxDng?=
 =?us-ascii?Q?F2qHbw21c9LtmmPf2yTUGPpl64Q1RfCbhioNVy3apeWlX5mFUP4iXo+BpjMz?=
 =?us-ascii?Q?XBrJFhoWOWBUI5NSmLabdPVjB1SBIoE4U4554MyJ6WuCMUT2l2bGwj57iFd4?=
 =?us-ascii?Q?LP7v9Ml+qSpUL2p3WOj/Qi9qAzWnDH1Y2qL3Jzv6CfUzm2cWfW/MVdZDLylF?=
 =?us-ascii?Q?keqdCfUq4IW6mlZQ6TnCO3mpPWBLSqI1SADgF44RSSu/rHvjYYuHxRZD7lFR?=
 =?us-ascii?Q?A6RbABWc63M2pqC2SxH+ZVucG6jF+uNHpM13AYL0azK3xLPm8VQ3EYbZE41T?=
 =?us-ascii?Q?hW34xitJSl/VlSx2fo3cto+uEG9mT5NSlEAvn5a4wzC/YqwZppri4dMd77wa?=
 =?us-ascii?Q?EjCW+g5GK85lj87D9ZiEYso7lZea6sWtQ42Onead0fU7wt4pPUK/dlqKTjgA?=
 =?us-ascii?Q?afp0BriMh47ArOetSnpcCqsBpiCnkUfjAz3sI98scBU640DcJdBz3lrk3Zvp?=
 =?us-ascii?Q?jB0F8eZaGrkqQPVAyI2ys9GD3mnJyo/mLNduUhv/kkNd08tISxadzSF6YMpY?=
 =?us-ascii?Q?p65ja/jcZE7B7mJTFxbTosJCANlES89/nQDERCjISatN4exdupkqF63slBBx?=
 =?us-ascii?Q?BmJ552Qr+DiX+mFMtssfcDF0hFb+L0NIlpFF3yuH1SeNLEAoaRqfIMGxevtA?=
 =?us-ascii?Q?OCjc1KlU0zFyKZJts29qzFc0iFgGQ+yg7lfiNZeM2WuYjnMlN1ZMDjjvd406?=
 =?us-ascii?Q?qJx0i9kHdyDPRe+6GFZvxtf3xFW24U+4z4X4STVxshTR+EdsgnIauW093knP?=
 =?us-ascii?Q?z8GTmb5gxJ5Ac053qABi1Bg4QLF/OZZo9wSjc1bBvPXhUpAF+F86teHtUHt1?=
 =?us-ascii?Q?ONpsGl0DVjLw4hgrDtrtHOygh5KIhg5zMKHiMQ8XakGT9KeAvXPup5kXld1n?=
 =?us-ascii?Q?sHuBgvyZvgJmSUYlCMwYxafkJ+krQZ92vj4+RicfgDXJMSOZndmvgfTTC9PR?=
 =?us-ascii?Q?UUT4GYr3n9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbvOKuabSjEJtL/LtJoRbkzzPihhmsaVRr30Vg4y1odZNsuCIJ4uUetXAPhu?=
 =?us-ascii?Q?gPUAAPU7WdTPS+EZ2wLg2AbNbfmGS9B1fJX8v7V4PnXDxFwKrhuAiegWyMpS?=
 =?us-ascii?Q?BeNhMwEVuUHCVFXfHl3fKtCxzYciFVqJSn1huTvcLXXFGQv2/eB6lsMmeVIk?=
 =?us-ascii?Q?4DhQklTUQrAd2eA4oVqxYWP5FizNZ8r6mpt67wrT8XmerhObjqrVWHJ1ciWc?=
 =?us-ascii?Q?m1ggC6dsSKeocnICj3uM75kuAC+8mpGeUtCY1NHsn2Ay9XSEVETXMr8Ur3qo?=
 =?us-ascii?Q?pCZnpgt18SdVTx3fa20JK5ks+IiM2AjS89bFPnj7TtXD4OTAC6VW1HARvpuw?=
 =?us-ascii?Q?c4G0lQm2rmpsuoVqHw7QgB6NcTvULRfbk77lO0P5ASWQJWfkkBC5q5nHAWo3?=
 =?us-ascii?Q?1tKplX1GslVOfNX2SlTnaF78mEPPT/skJqCy9qeTGRZiAQ7ZI10sJxBrqsyZ?=
 =?us-ascii?Q?5iRJSzZ5mqsWDpdzLRll2WkM7b8hjDsX/ua0kU25kQOh8jsapsHMPkjx6xVE?=
 =?us-ascii?Q?imApFyhBbMdX6cpyywy/5bu/SNVKNjomNND43QMoE65mVdvj6D5OJfYAvsPg?=
 =?us-ascii?Q?eNRdXE16zGAq2WJCg9NqPaMvENipUZOs5IMj1w6c/+NP/vctszyKIg8t3N5l?=
 =?us-ascii?Q?jVGWMqLpzuM35KuT6qmnoDTOpiybc3fQ+EfsklR+ZktUBEI9fI2T2dmKxmc3?=
 =?us-ascii?Q?l2pKPL51V3HnxRGDD5gCg7aurfpVwCNl1Ws4A1k50Q0f3pOXSuf88A2TbXsZ?=
 =?us-ascii?Q?GF2zGjkoGrAZS2WMAvjDF7mvJ0qxNprV4LY2SLN2jqQkBBXoSTM7obW0weQG?=
 =?us-ascii?Q?vARA4LKBieGWHOdS+q9i0KRvvoBRrxt3muIoabYVqTWg0VNCbRlPzEa/O/+G?=
 =?us-ascii?Q?RWhxkE6FBTS7QsDuBg+qHIzwWLqAEvOcqtp8c7JlpINDA7MbpqpFo1NQO31a?=
 =?us-ascii?Q?qw5okHgMlm+/w4XZ9rgGiYXQerTSaSbgPwzIKrtyS/Mq23w+6fuVf3++fYzn?=
 =?us-ascii?Q?wlyYRlw96zI18rWB18kBnjoT4UtZWo6YcFur4xgSmKnPcJPC1SeWiR6KyxYL?=
 =?us-ascii?Q?IQDziHov3bmCciVh7DrldnhEyQ6UpU+P+EVEumhqYPAtyNGopag21A2R4QVp?=
 =?us-ascii?Q?1OuVW8eJ0NPW5n30hU7kVI/37ApAiOJj83b5o0VNow7L/tadbXCVAQMF2okC?=
 =?us-ascii?Q?TNw8Mk+gvrJM9KGiiqSoBttrrJ5J8ccmOgDk+Yn1cMeo32o6lQG6fjhDe9aG?=
 =?us-ascii?Q?XvAR75G4hy6DV3wfAfF7sq6BppEjkev+akh6wjiZvzQ/V8sq0+cZNZ436rZJ?=
 =?us-ascii?Q?1JNpL+F4K+m2UlznRhhpbMIlZoDE0Zp0/ln0vp+kycE7M+vHWu8yz8aiPrV6?=
 =?us-ascii?Q?Y62I6dqEu2vZCf44o+3eTrAb+E8xpAbQFfhCZr6g8jTPdguh5cy5jycHf7vO?=
 =?us-ascii?Q?XvwMhIMKNbrJvX7G9yMjse/UzmEs4nMlr82JfMZLA3WHll57Hbm4ETR3Q8Ar?=
 =?us-ascii?Q?HPa2mZ3hGpg75uYtTbdH8PQv9/iZhQyKHrQUSNhBPLzuPCHHKVkX6YWQyqEa?=
 =?us-ascii?Q?mU6qcFqLA/NMC8TN2d9l923As8GnnzO1AB31mxOS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56148619-1351-4b3a-71bc-08dddb5afeea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:50:02.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBdqjdn9kRxgpGXvVdKC1HxmdsSjeR0zcPhU1gwDaxN2fImTmr+nnlk+BMIO6Yy/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

On 12 Aug 2025, at 23:38, wang lian wrote:

>> On Aug 12, 2025, at 23:55, Zi Yan <ziy@nvidia.com> wrote:
>>
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
>> .../selftests/mm/split_huge_page_test.c       |   4 +-
>> tools/testing/selftests/mm/vm_util.c          | 173 ++++++++++++++++++=

>> tools/testing/selftests/mm/vm_util.h          |   7 +
>> 3 files changed, 181 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 5d07b0b89226..63ac82f0b9e0 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -34,8 +34,6 @@ uint64_t pmd_pagesize;
>> #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>> #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>>
>> -#define PFN_MASK     ((1UL<<55)-1)
>> -#define KPF_THP      (1UL<<22)
>> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>
>> int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_fil=
e)
>> @@ -49,7 +47,7 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, =
int kpageflags_file)
>>
>> 		if (kpageflags_file) {
>> 			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>> -				(paddr & PFN_MASK) * sizeof(page_flags));
>> +				PAGEMAP_PFN(paddr) * sizeof(page_flags));
>>
>> 			return !!(page_flags & KPF_THP);
>> 		}
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/self=
tests/mm/vm_util.c
>> index 6a239aa413e2..4d952d1bc96d 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -338,6 +338,179 @@ int detect_hugetlb_page_sizes(size_t sizes[], in=
t max)
>> 	return count;
>> }
>>
>> +static int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64=
_t *flags)
>> +{
>> +	size_t count;
>> +
>> +	count =3D pread(kpageflags_fd, flags, sizeof(*flags),
>> +		      pfn * sizeof(*flags));
>> +
>> +	if (count !=3D sizeof(*flags))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_page_flags(char *vaddr, int pagemap_fd, int kpageflags=
_fd,
>> +			  uint64_t *flags)
>> +{
>> +	unsigned long pfn;
>> +
>> +	pfn =3D pagemap_get_pfn(pagemap_fd, vaddr);
>> +	/*
>> +	 * Treat non-present page as a page without any flag, so that
>> +	 * gather_folio_orders() just record the current folio order.
>> +	 */
>> +	if (pfn =3D=3D -1UL) {
>> +		*flags =3D 0;
>> +		return 1;
>> +	}
>> +
>> +	if (get_pfn_flags(pfn, kpageflags_fd, flags))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
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
>> +	if (nr_orders <=3D 0)
>> +		return -1;
>> +
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
>> +
>> +			vaddr +=3D psize();
>> +			continue;
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
>> +		}
>> +
>> +		if (status < 0)
>> +			return status;
>> +	}
>> +	if (cur_order > 0 && cur_order < nr_orders)
>> +		orders[cur_order]++;
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
>
> Nit.
> It seems redundant.
> Would you consider removing it for a bit more conciseness?
> This doesn't block my approval, of course.
> Reviewed-by: wang lian <lianux.mm@gmail.com>

Sure. Thanks.

Best Regards,
Yan, Zi

