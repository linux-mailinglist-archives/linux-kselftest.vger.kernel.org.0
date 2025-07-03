Return-Path: <linux-kselftest+bounces-36447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2554AF77D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393804A3F26
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD94B2ED85E;
	Thu,  3 Jul 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHAGd0z9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367D2DE6E5;
	Thu,  3 Jul 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553815; cv=fail; b=Aqt2SdOhhiGsf34q7jOSEe4SxBobY9TzbfLo7Beyo1GPRwWpIXHJ5XPJIn7Mbgwv9hzvL5LXqsW4ZetE/+h/0aPehTe+FhmGTGtmuh74I9SKTMqdJiDPXSekykp37Gcvog1zNw4+yHPFMdPrpL8fKgK9mBCRYCXNXbJS5PNPb8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553815; c=relaxed/simple;
	bh=H9959enRF6MuRiu0KftsH2+SiKogjvC9AdQYJ+maCko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvQM2A28MkNDjldAa/VLaxZsUxlFldN0fZl1+TkWZufxACLZysxtBvru1aSDz4qAnY/LaIw5O+XWkEyWvtimnTlI+0gp1NoOOQznmcZQvdRqouLSiW4k5ys7QcBsUAibYQCj5M56NqrI2h63+IhEttQUVuJwhpIsYUc6qAKrIqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHAGd0z9; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp4C67+wBpEiYKqLJ0jZErQo0XwUm/vw7gF0ROXlkEOqjc+djRQMjyZspKuWnXwxc6kYyiSXFdxdQth9VD9ozuqiclLqO5rLEmMmW8f6lZ1IcMsLqrkRFdJp6whG/1bPZGRdqwMO6F8FypEpGf/JTyXqwDTBlr9c9G7N3IjO9MEsI2BsazAPI18UQi8KnbSb5LVUQV5n2yGC5GuEFnPzxEI/OrGUbMN207XRgXDQDFnQ1SbErjVu2kXVZoeeVcMkCx4vRYItn4TMfyjsSeLFQFVEuom2rsWN50shP7woNjgWV0Uf2j3Q3286fXOyYzaDkFh5MrwFvw0GysNYR5ZIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGsQSod0GJzDyFrztcKm1GkH3FxD2c/qUmxOb4VcRf4=;
 b=IjNHDn0PZ8Xs0yPtj0/PldelJ7JITMFIsSEn6nJ/eLbd7X6JsTUZlIZIFnLQzgxzHbfNybQ8vBQegRooMVhN0gfWFaezPIoAM4MOVHf8rX8H7aNnRoBOU7EkhGBgCCmgfzVOZRQvhT804GQ7xBx1rTmqK9dDN3WAQk67tV4aUeF1fUPgHWdnod7a0Nw2AX+3YQMqPWKdZW5+u5lKzh+FqnO1q5KMNLmeWsVjbT/apKCGrPPgSMQT8w4eaaeAMsN26aEnEJinxDWbWwvYzvz2h+3Ehg+nWHwDsCqEGLCBCxopbRcUEB+4WMz2PFSrI5eyRPSXQ7DpHvB5n0Db3yZPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGsQSod0GJzDyFrztcKm1GkH3FxD2c/qUmxOb4VcRf4=;
 b=BHAGd0z9+AmuMdO4FPQlxdx7wu1I6WdleKP0Mh2zu3k47m0NaTETIKLfr88IE0H3JYNjSQexl/HmPiFfxyexvQWQLH2EeoWSrsPlf/63CcXsssJZs4nOOb2iiy/IB15RcgQnmGlc6/E74uG2pYKS/LKr3a0SVpaJJPVdImuvuoUFjepUuCVybXmqS/ntFQ/3/fP60uB0r5chWTxoUfV2+0AO8mJRLzF6I+SWXEkTSj1tHttp0gJvOKfGQ3faRm4Kp5bazUsKlhjpzAVY1Y2Mi9U1JawyTTBPp/d2Oz9zSRxHWbHcQBldgRg/mPe+tmvmLDcNsp5uvPHIHzlKItT58A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:43:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:43:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2 6/7] selftests/mm: Skip thuge-gen if shmmax is too
 small or no 1G huge pages
Date: Thu, 03 Jul 2025 10:43:24 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <31D5CD80-4154-4997-AAD3-E6EBE244688D@nvidia.com>
In-Reply-To: <20250703060656.54345-7-aboorvad@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-7-aboorvad@linux.ibm.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: be58b59f-4081-4b52-5607-08ddba3ff989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApXeJLwKsBWUmHt514SF687DP8CrqGsu353dtHnF27TTJ3758oymljo5Lqlo?=
 =?us-ascii?Q?vAKK1waVF9x39TT52qWn6q5y3sHFk3Epxylc2SMGCx99Ju8qx9aEYkf/De/9?=
 =?us-ascii?Q?l4tyhFvdpSR5l9IBRPKwHKEpOPgs1HqpY3k0OwsJ0VYgWOodD696VuQhJ6t7?=
 =?us-ascii?Q?dIc5/EqW2SZ4Mwn1ajRADpbkUmSr6qWOwPkFId6Jygb8T7ZsS1+wsPdgh085?=
 =?us-ascii?Q?ZqjERDn7U/Jr4RVSmL08mFFglDKgLPSFURxaVOniu1eqQSwg0d8oDjR35BgD?=
 =?us-ascii?Q?LzciarLSct+HwaPTRQ+CwpUwP4qvBpc97jMakSAMuoOR1w46s8X+ut7AAuO1?=
 =?us-ascii?Q?FvvozNJZYkJIOcNxjRic9CHl3bti2cyTTx4xX4LCgP1p/Cr2TVlAZFX4SofE?=
 =?us-ascii?Q?qWP9j4qTTJFJiCyY1AAX3lI/H+0XnRbfMZX6dQEr/NPmZjyS/vOz2Iuzsj4X?=
 =?us-ascii?Q?NU8O4bTqzJa3+exgtsY3uFv4RavJWnTB+RQbFslxj/lkWDew2fPjTXQ4s8dc?=
 =?us-ascii?Q?4ZI5CbzkCsGuF/tq4pRaOQFOen4QYN2PGaLc6+ro4Y/pqxzUgZaNy8//JeAF?=
 =?us-ascii?Q?S3a3LCmsXe/L3cF+OZqASLW1T0DH6Iyo50hv5d97Mq/0c+WTtPPmyedXDJE1?=
 =?us-ascii?Q?s3x3vWW7I/WSerZsWF0KeEY9+lR9KjvrDDxIT0NNx1Kp9Y7GhVzrwe53VBAH?=
 =?us-ascii?Q?MSuY8y/MD9s7mCGXcSk6WZavndjKWGpEjEZS8gHKCO/i+pfT8dHuc1t57dEl?=
 =?us-ascii?Q?tCClVpHidWwXRmJjXgXLM6rMQGS5zjPcnQfRZAPVSkm4t/A/Rj8+1iYwvZAg?=
 =?us-ascii?Q?xz3/R16A4aoxDUqzONI/LKzL3mDPeM3ANS7oTa4o/PO+1Q27dbO4SnydOuXu?=
 =?us-ascii?Q?kczTRhMsLmzJc7re+XAAb7QTkuVII51JBU7br4z3nDFLD/+SQQnZ1b5afo1Y?=
 =?us-ascii?Q?ORQyQAClYuL2BLy7EOS1wey8oOv5uqN4HsxPtvOAuZ8K1BFPnsA2ZxYAATca?=
 =?us-ascii?Q?y6BRhs7vpPAl/OsTac4I/usCKG+jAvyXvKrap3shHyj//QC2wSFwE6H5ENCY?=
 =?us-ascii?Q?0T2xY4QqlfFFQ/AmC0Je5SHD88RxOI0FcnGvcO1HU0o69d/TmWJ862khgksP?=
 =?us-ascii?Q?e7ydZBmokhOUl3BO5go/FokULLCLQMTsK60tT5SLS5x5iI8znlEH9VwlV+2i?=
 =?us-ascii?Q?75x6Yg9RMq5WjhbMbnOC5iZTYTZ0czz7ywHLFSyJryMhbQPqeTE1SWwat61H?=
 =?us-ascii?Q?HJLTdspfBlcfsyjZImK+Gsh+ydrok0qjhCfpxLbJzeeciUrt2VLfW4X9UNrq?=
 =?us-ascii?Q?gaM/2r4POyHqDj9Sd1I2QBTbtIwlCRzZsW7yOWIfjumeL2f866f7/cFN7fIr?=
 =?us-ascii?Q?hCDR6SONSoFDPiXaM6WR1uyRZsYRD2ibuGYtICR7AxclQmG1wOMqDoenE/yn?=
 =?us-ascii?Q?6Xk18ui6Spc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAkJiUxHwCONqCE4nYtBio2FzzlZsNcwM698QqyUWcqt9qrewSS8rhVQfFv6?=
 =?us-ascii?Q?OicUJqCG6zLZoLIYzTcInvGde8PRsQVdlgKid+kTjciaCrU4SgOEo9N9GRRI?=
 =?us-ascii?Q?uuUXj/fIebE9mGlOkx0IUOuBM9i6E1GFNrBwJVqdYPlyisqFjv6J67J/yAIf?=
 =?us-ascii?Q?iDh8BfNa6X8UZKXxYw5mC/rOJaBHIorTvSlUO08FnnDdJvmRXQP3vM9QCgew?=
 =?us-ascii?Q?W4W/zZwy9i/p6wCJf2HsHEqbJXMEcrCmpq4LYaOJ8/6Y3/SV5NVvCzmqkzty?=
 =?us-ascii?Q?SgVLrpxvmjC5m1FKOimwqppFR4TJCZTZs6ELpjPk8FOBpGnPTAmofa2rfIc9?=
 =?us-ascii?Q?0lTuSDxaHBPcL41Zr2Vcha72jqm6JlRvPVzNvjk/G/2jszvnjDQvM75zVaRZ?=
 =?us-ascii?Q?mQgenOXSt3JFu66JBRIjA7hViZ1ysCpaHfiSApQJk8gg6avlHFg/n0guP0H0?=
 =?us-ascii?Q?lEhLB96VlfP1BeK+l8J9AVOx+H5f1FDHJs3O9MlY5jy04XWNNcJXyXj8IKnz?=
 =?us-ascii?Q?lz+y5a5AwZZxL08M/y/3G/dVbpxMyd+SFe0J7XV2HWBLyuOQAk6WW05DnX54?=
 =?us-ascii?Q?r14WH2w/Ac5iQZaZiJA7tlX2Te+qfFj13FKmRsDA1NXcYGIj4n0TyhENaPIg?=
 =?us-ascii?Q?iiOktnoMwsXm5BJIYcFvTxNj8xFtX8iFWbQWFOLqaVvvTQI2cWLQvBBY4dtr?=
 =?us-ascii?Q?qKxBSJ15UQRGS9lnqXJgLeAj/AKKulInZzed/A++7i8/lwTofdGUrwv1ryHa?=
 =?us-ascii?Q?xBSRw3La6DzTfjscDZRbgQWbxvSOg+Pdf6uj5m5dmsUzxMhjkGaN0Ax6hkdX?=
 =?us-ascii?Q?Z3iVx8ZLBLHMJ2x6WQq0IXPabHYXRXNxZPOQm5RuqDUBLXiyMwHZ+SkDa0HG?=
 =?us-ascii?Q?HAAxAEOjl0wDMra4ytED8ttjkFDV3PgGBkn8ve+H3Br4Yzclk5skKCdIy0Ks?=
 =?us-ascii?Q?zYiqny2jkD7j/j8ujU5GnalrRUJoT7QprMDJ8ZqkUczXPulpI4xEIsd9MRk/?=
 =?us-ascii?Q?DKajAvY8YdwK1vllmroHaEF3C47LUwMePcHW1RpZk5ejF4Yjg2GL5WB/jHfP?=
 =?us-ascii?Q?ZeIXc5CRurAlK2cGSfl+2JX0Q7bHaMo8vekDaSk/09fbLnXUs0EBWEyyJSD8?=
 =?us-ascii?Q?PaAVUbh1i94UH7tBPsb4AL6aLjM79mWTZN1I3WBm2WNhOkqA4jtNp2ajyAEf?=
 =?us-ascii?Q?ST/K5BkudEFD2iSckCJxm2tTIKMr5OHD8LGq4eLamAnsP22qvAC3v8lELgy9?=
 =?us-ascii?Q?TVXIQLKKbyDMh8XOcJzgXLvukPcJ44ZjnfqVHRhfUBvrJZ/t4go+9zYS4hQH?=
 =?us-ascii?Q?QFhlYUEOr52cKreAQxm9QInQkrlmIaiGU8CX9sGI4i1mVilOX+TSvMvX4jid?=
 =?us-ascii?Q?HrMvYv3faTFaBEGd5oWdCRGrTQK9x3Vmw30VXZaqWXOgMoWz9U4VLuIYMXVQ?=
 =?us-ascii?Q?HW7HeJuNjroNovRgGdjhCB2Krm+n1yVogD4eQciHlF5LZo8CkwYN4Zi++na6?=
 =?us-ascii?Q?XoLFuaJqnzQ79e4da68meLpjXK0ZHnChnQ9DDiUNpPROtU8KDn8SfPwdFeBL?=
 =?us-ascii?Q?9KNLTpqzperhHzx0OLiaaoy11OprXw1HD+f2iEMR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be58b59f-4081-4b52-5607-08ddba3ff989
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:43:28.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B8lv+JQtrT63nRi4ts/XVpz3dy1F8Z+nIiEvs3/YnvLiBqQ/JId+GgZ3H3yn/Yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:

> Make thuge-gen skip instead of fail when it can't run due to system
> settings. If shmmax is too small or no 1G huge pages are available,
> the test now prints a warning and is marked as skipped.
>
> -------------------
> Before Patch:
> -------------------
> ~ running ./thuge-gen
> ~ Bail out! Please do echo 262144 > /proc/sys/kernel/shmmax
> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> ~ [FAIL]
> not ok 28 thuge-gen ~ exit=1
>
> -------------------
> After Patch:
> -------------------
> ~ running ./thuge-gen
> ~ ~ WARNING: shmmax is too small to run this test.
> ~ ~ Please run the following command to increase shmmax:
> ~ ~ echo 262144 > /proc/sys/kernel/shmmax
> ~ 1..0 ~ SKIP Test skipped due to insufficient shmmax value.
> ~ [SKIP]
> ok 29 thuge-gen ~ SKIP
>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

