Return-Path: <linux-kselftest+bounces-38602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6410B1ECBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8EB58570E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C3280305;
	Fri,  8 Aug 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rF/ZuVz/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F619DF9A
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668917; cv=fail; b=gEO0wP5/ry+4cpQcNlOA3wtkesaLplSRQ+44D6DcRcBR3uCJ0yvp97aHK1YzA2f3+3GLdyUNVLA+Wgg+Uf/+vfDnmEh85W3nT3mu9V1AirC7SJDox8PLVBoIuNpProB2vXpJTt7gAMKCM8+w4kUlzOai+4eZLa6Y6sc0gE3MM9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668917; c=relaxed/simple;
	bh=bg6SWBJf48nFO5jadWQYJPzmraLGhBB5s+193wyvkOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XemhIPedUPPnGeUekAVT+3eRhvTi25oRDp/+JCX6uZ4K5YisPOSqxO9a1O6s5T4Ruek0QnTMOaVwIfzcjC/lFbUIyAd6hp6WJoooMYHvvkIMn0PAEdu1nfBh3UctbaN2QxxtkDgqR5Kjy+gbKfHQ6dEu+j8RTdOwSTcub2zHyA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rF/ZuVz/; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5yP/fuWBFWRuqsRNzzH0COlVkmr8atHTe7SALc0mQbH6AO4me4ksS/jTeCcAuZFHvZkEa1vdff/ac1WAUlNSCC8nmGnQnvRplU37u8uH9rXWi19IPQ9MHrPVcHyN/skYRBbPPE4fNMxe5QtkT141CDUJ6atc64maay1iPPqpb0FFiVRwZjYLKG2eBFw8k5bNy2XAo5n3I33SXdKX57xZBiuvtzZqnDX1yM9U9rTaDMUJ1s0OP1xUwnx4zLAziXQnn0xOzoQ+CjOIMZxRfabG6CcxidmAVXf6K7422+JoPYlgUkG8xDQLB9DgbzxY6Z+8CkjfxjUHsd/otAf59buwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Oda9w8kA7GWDhc2tUWpjQ2bzULUNTYeKKbAthP7v34=;
 b=urvi2ci1d3XFvIX2kY4HqkscylMVYdILoYSNv02PscHHTnUNYfM2j0yX/1F6kCNvyigo73PjZpTTr/HkTYTPXuF6g0P5Hf4yTOhixTukBRvA4c7egOkaX1jQwuegdBcolcFYePhx/bGux7xdIc39odAzSfgD/iuJNzxWkpxl+o7U+tXKS13PA5IdmpxR6/IJXvdBVYAzqjMo8FI1wG31ZSihhmfhslt28svnAovbMjv0c5YAsDBdL7N14eq00YNWCroiEpZxXUZZNoRB/WDoJsjNh5IYt7qe0850598BYjeFEIrX8SOjx1eKVU5eX3ftr7azbsFR80FSRsGzPka1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oda9w8kA7GWDhc2tUWpjQ2bzULUNTYeKKbAthP7v34=;
 b=rF/ZuVz/kiuTLYf2zuRFQfzcVsgCzoIAvl21IXZ6kXxNKwI04FBkUxgiKU2r2yCiNmGxiJPTNk8KUacd7ZHc2cln5Chy1DsatE5BNg2XMYSmFY7QesYINWJ9+EoFyYJ2umDHQMDycZW5fAO/9DrmDRDEYzPCB9kUNHlPMWp+qqV74tuNpheBL/GwhRPo8HeQWdXJ6aRG3eYkhIOXrZ9Egfacml/WlGBMTfxHLlh0r7YkFOtwpYCzRrCclcVovBuZ0zj7OF62Pr/a/Yb40aEjrfU9UDlpI11g+g/Kklv/s0QbYzi9Ib9QJ6byrZTsyS/5th7rpIjvIN7nn7jCagapqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 16:01:49 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 16:01:49 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>, <akpm@linux-foundation.org>
Cc: <david@redhat.com>, <lorenzo.stoakes@oracle.com>, <dev.jain@arm.com>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
Date: Fri, 08 Aug 2025 12:01:47 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <13D32FD8-FAC8-468A-9C92-23A1B61610C3@nvidia.com>
In-Reply-To: <207BD61A-5561-4E8C-B867-D1CFCAD37509@nvidia.com>
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
 <0467FDBA-A2CF-4CF0-ACCD-760ECD30BA8A@nvidia.com>
 <207BD61A-5561-4E8C-B867-D1CFCAD37509@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0037.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfb068c-adbc-4a79-800b-08ddd694e218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfgbBdJsaxruQcUtE4WHcb0eugnOrOt57soBI0MfdfVSLQtTtH0gs8j+L2D0?=
 =?us-ascii?Q?2f25VlwIqjlgPuscWmCsRPScB6odzH9cMsqD93U3PUgR4mK0tksdFPJcwmDS?=
 =?us-ascii?Q?G5U0iu2uHW8bznWazYHn0gAlRXk+1gAsir1pe/xP0RwnX2I2shkV8Qjuk/sX?=
 =?us-ascii?Q?nwimiZmqAccyb6B5Fru8oCxuLtwIsvuR0RfFeh9Kd7sjMAAWCgHe0pRKkFrA?=
 =?us-ascii?Q?beskYnNfXek9jWDBpCnw3G/slCCbU49MFl/9EhJ1ZQ5bkVU4yHqc9uRIkRcw?=
 =?us-ascii?Q?oTLY8WVuRSvM53045A775RqHBwqbT7TmGXbCdk5COqpynP9A7lQ4roIf1tOn?=
 =?us-ascii?Q?JbEWgHPCw2/d4XMQqGlKq6NFK5wFW5+eDxYrzdKvLbGMkCOZg4wwLbVz7JAP?=
 =?us-ascii?Q?YHHxHmhoQ8djZoLvEsnuW83qM+IPkcrR8U3tdyiEUcAGssdFSV3PRXUy3rwt?=
 =?us-ascii?Q?9slLtqUgesYTJqMvdqBwwogAL1S3Uzh/+v+BRL819lhU2nRmr49WMKK0pYEB?=
 =?us-ascii?Q?Ro2GFbhec0t40KOup0sQGqv+WwUomMcMrzoA03cf2/w1Z+A6PWUx59OVIqhA?=
 =?us-ascii?Q?tNHUBnNMGaBiGAaXE48wNKtwJqPe8PgUJMIGAqiJteuPKxuxWER1JcsTKBY1?=
 =?us-ascii?Q?Ky/ztTw+f1JnoerB5ojw0tRfwVMlqPTnFv2mls/2DIa56Uat5KbgrlXj8Mti?=
 =?us-ascii?Q?Ut9ShOMKQRiiGmSQCKEdGWVoDk/9MUeDpJezz6UCJYwzbmfw/vzGOGP87pbS?=
 =?us-ascii?Q?glkGtN46/6CigGuKfbKPWi5sUe+7wD+N9PepY6AiRVOEABU9KpYRvZmFlsTy?=
 =?us-ascii?Q?g/IVZY24NEG6Yezl/itUrkZjBRb/RZ0xPyq41IZe9vQgrFNksVEDk8ZG4bnv?=
 =?us-ascii?Q?LPBh0v3Azaob84PtpkyidIJEGWINHVg9EZYL8qXmzmS94J9G5Ca1TeTnOsxq?=
 =?us-ascii?Q?l3Zx7JPTjjNpWmqZErENlVk9IwLiZ5m7xIXzcbXwnn537TXRQxPrYlZBstNw?=
 =?us-ascii?Q?OqmHLfEdRbGa6PsG3AJX+RTnK+co61ltQheQuc70ZO/4rmynDpQC4uc5KrSn?=
 =?us-ascii?Q?RQA4cg9cPF8ic0zjomB3HROlk9DwuHiW2/Teue0RYYwJLNCOsal9u4AAjET6?=
 =?us-ascii?Q?3Y76A/dBAqV4i1mwMEimWCFT1adQSPGHVNG9hcwwWtJ3UVGHMD6q0aiQHtOj?=
 =?us-ascii?Q?pAuWNz8lEPdUQRHxVK+nJcGpo4KFeUS14t1e8OV6a7/bLy3XzKl4M/Ta8cOz?=
 =?us-ascii?Q?E48Ykrn7dTTWOup4DDV3yQomjqVpxVWhrIxJGibzTV0XKL7S/qec9vQHFN2F?=
 =?us-ascii?Q?dqLxLhQ5AGw+P3S5oPpuReC/lHooYWtQEjgezYrVh/thnaZgdfu7N15ziOqL?=
 =?us-ascii?Q?0rdvWStQkSD9q+/cNicZtjqtkHpa/zJd4hXdRfGl5x5PmgSSDGB7blvpq7hH?=
 =?us-ascii?Q?OYsvk1LvMSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3SImCmPTt9oQvTdRpkJ15VH5RoNh9ZMma2fJdwu9KdJduDN9o+pTzlBpK5u7?=
 =?us-ascii?Q?mXD6QoWYPUykGlLL5VKKugow6OhOwk5EK4XPxbZykHMNBKdqNKf+9be+WJIc?=
 =?us-ascii?Q?FXuFIuzZS/yheCSNZifL6Ampi5cz9bfZY8BqlcepO7nqk1qN81gq43LfRLa6?=
 =?us-ascii?Q?zdFLGpkUNEchrzYxX9PZs18S7eMs631/cFPnD2+55rnQroLmZi7rUiYTumKa?=
 =?us-ascii?Q?6fV3d9LXsxSXn5WIv7kz5ptum8Kay+LxLTh8a2REzbEOOvnJO8JOlEP6a8hh?=
 =?us-ascii?Q?UDRoiZ9/YlvuM2YreQED817JAqU7N8s0fH/EqAVqrTDU0QyXBGN9CWqm+nA1?=
 =?us-ascii?Q?dxdgJkfUUSQUNChlflsXdsPigJCHfDdSaB852VgUOWw08uCt5Z5yw29fzStc?=
 =?us-ascii?Q?VcZ4ecvUuCNCB8d0qJX37O3Zs8NY148uqboxSbUvTL1MN/go0/ZXs3dGOoi9?=
 =?us-ascii?Q?V/hZ76sHbINStZE4HL6F14QBQIqcpX6TAMng0pli9HEOoWVKU+Ty0NI066bF?=
 =?us-ascii?Q?1KJaOpe/aihaZZ8TvHJ2R0oLRCuPoD8E5sclsT3026w8ScprGxLFPbFBUynb?=
 =?us-ascii?Q?udxx6hZltYa4ltZjIfF1XhCOfUFBRqY0bi0jVCv1tj8rUWBZHWEiElIZhbY8?=
 =?us-ascii?Q?g6L60xi021mNAzUxZUh/eEVI0qiBVmmk2DrtZksuPncfzGODl/JkloE7QLmW?=
 =?us-ascii?Q?ZhDrwP79OmCQ6WUmlgpgHLXpAFqXSVX8kPMFz27g8xkTnmBiD6ILFDT8MuxW?=
 =?us-ascii?Q?iWmIzIPoI/2PanFpTZdCbra1Y7sRfTXJpe4iNT4hORO0suJJM5dmSF3PMnsa?=
 =?us-ascii?Q?stEIaeFWJJOfzpsfSGm1t9c+RGOW9le5iffuSYFByzBg+OWa+JtEwUXcfdbg?=
 =?us-ascii?Q?vvytNTV68W7P2KfYhP46oU2KTr/5OF/3GeCFRby/EXs+FJuUSyqVvJw8fjkU?=
 =?us-ascii?Q?WhOs6k1ZRHL0CRS/o0l4+3GYrNXnBg7cEvEV06wDz5VhuiObmqocvEQoXiA7?=
 =?us-ascii?Q?5vpIpPkPBo+OxeMf3JXrcPmTP21jwuPWEXFuZ51x4QxVxoS6/O/4dRzxyUWl?=
 =?us-ascii?Q?iGFy8oKWGb5O1cwFHbqHZWU1C5grBwwJrguRNcEISs2ktwbby0VoA4os9aEn?=
 =?us-ascii?Q?KiOYTQ9bcUcjZDmd3WzxbLHb6EsPupJhz78jxtGhTIoyfQiBbbxx5+j++qQA?=
 =?us-ascii?Q?OkDKySXhfcmAw0DCWumeIggf1eh1GW9Ox1S7nEbrntBNUfSD42YHttXBfzdB?=
 =?us-ascii?Q?Za3hiM8seXU7IsMeRquPM2t+40ECi6/JePVtHKTdjMl4V4AEFvAF9EnckoZZ?=
 =?us-ascii?Q?wlmpazj6HqlLVqjZJTmKGCo6jE1HMvP+gvQ/99rPyrD4TzfUBBbvDMjDxzjp?=
 =?us-ascii?Q?rCpv2VBlMnZ9y4NzTBMGC158vQ80bOjmfCNupFnWZQbPDiFrhZb1HgPc935i?=
 =?us-ascii?Q?GAre9QCPegPOvujQQCrFkDXHRuRPMq2WI91c6XyLgIwUfsf5r60M189RdwwZ?=
 =?us-ascii?Q?0+r2O3VOPi6LEhGwSrn9eN9aGEq7Zvh5eGMYng1ZfV3pM5ThoifNAUPGQk7F?=
 =?us-ascii?Q?8D4eeM241gp7wMHE/1f5okHFcIvb8motA5bqFg3g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb068c-adbc-4a79-800b-08ddd694e218
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 16:01:49.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zkyl9G5IDyUnSUERMzmRWikln82EJ6Ft4/COR2hRk4VWlrJA/DDgPE4CqsoPiXpX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

On 8 Aug 2025, at 11:59, Zi Yan wrote:

> On 8 Aug 2025, at 11:56, Zi Yan wrote:
>
>> On 7 Aug 2025, at 4:27, Wei Yang wrote:
>>
>>> Currently it hard coded the number of hugepage to check for
>>> check_huge_anon(), but we already have the number passed in.
>>>
>>> Do the check based on the number of hugepage passed in is more
>>> reasonable.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> ---
>>>  tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tool=
s/testing/selftests/mm/split_huge_page_test.c
>>> index 44a3f8a58806..bf40e6b121ab 100644
>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>> @@ -111,7 +111,7 @@ static void verify_rss_anon_split_huge_page_all_z=
eroes(char *one_page, int nr_hp
>>>  	unsigned long rss_anon_before, rss_anon_after;
>>>  	size_t i;
>>>
>>> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>>> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>>>  		ksft_exit_fail_msg("No THP is allocated\n");
>>>
>>>  	rss_anon_before =3D rss_anon();
>>
>> Which commit is this patch based on?
>>
>> In mm-new[1], verify_rss_anon_split_huge_page_all_zeroes() accepts
>> char *one_page and size_t len but no nr_hpages. This breaks
>> split_huge_page_test.c compilation.
>>
>> Are you forgetting some cleanup patches before this one?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/t=
ools/testing/selftests/mm/split_huge_page_test.c?h=3Dmm-new#n110
>>
>>
>> Hi Andrew,
>>
>> Can you drop this one for now? Thanks.
>
> Wait. It seems that mm-new is different from Linus' tree[1]. I wonder
> what is going on.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/testing/selftests/mm/split_huge_page_test.c?h=3Dv6.16#n109

Wei, it seems that you lost the race to Muhammad Usama Anjum's cleanup pa=
tch[1].
You might need to add nr_hpages back.

[1] https://lore.kernel.org/all/20250731160132.1795351-6-usama.anjum@coll=
abora.com/T/#u

--
Best Regards,
Yan, Zi

