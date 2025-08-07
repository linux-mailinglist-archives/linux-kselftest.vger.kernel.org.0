Return-Path: <linux-kselftest+bounces-38484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CEB1DC0D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE313B3F8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAC27055D;
	Thu,  7 Aug 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkYTb2HX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75427281D;
	Thu,  7 Aug 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586012; cv=fail; b=ijp0ZUvsnmSViuQOdDMUJpQwUt14MMopWMhUb3kW5Ji149h+zcJ4BfBx549kuUM6FzEQcoyaMLBIbiIzdCcTGFU9c0bnuY/OY++6XmDlk9eomHKmxsHjbpwl9KHd8A/BeUI+7V7LWqRt5xphvs8TSkw7umjKsz63yKLW+6hPidY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586012; c=relaxed/simple;
	bh=rQA2aGpyUWONsC/whrOp2cHgU5M87+dSKk2UMiiQJDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DadI9oYs5qvIBetEiLHTbKuMm6c0v9IFVNVsfX7pboZyBXeb1cTB8Nb3wEV9Ngwt7TVkqYaBcNKrKqkkS14clCPM3aSJlM3BLMg6imWu0OXKqr/NmwR69rgjeKNiiIKdg80RjER5uA9hyCj9z4q9XQfNQIvQ0aBWZGGhAh/7R0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkYTb2HX; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNOzH19LJzGWBhze34siyjuqNdFMCde670Hc6C06QoJe/MABEO5mR/pB/6GZfF2H1U+FhK9G9MqltpOzzvkyb+lt6AyY6QOc99rzDQGgZg1Yo//ROtNScu0BJFB51lAQJF1p8ui3qRpqQEH9jPv+a0IU/IQplVIp4IkXjJFhV/v25WImXAdwsLAs3zUqyp1DqaUN2LWhqPMYVQyZ2qiW+F8DzTkEF7fXOHB7t4/emorOZ9rsVp36BnplNVmUgQvgZ27gyI79QBODl/RVr/v+y0JTi9He7yZ6V8Uleyn2GEQTiC7xFEMQxPT6ij3uPL7TiFAI114OaUSecdr8k6q/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hENgWQa+SIlxDusf3vX8v1UG62hK+qaFvkJCjOC3WlU=;
 b=rMdFM280tCsHO3aoOamt6t1zTsTJOx6edALHky+1IEd0WDqZr86R5FgUSLbQCMha9o3YX+wrebump4Abvh2BsTPmvZhv3Qdobrlp+RIbtsGQJsiK06QquWZ4mHdizTakvwXPHF/4h2O7tWq452ak2IzQSJm8DBw+6TZuDCG/Z6euZOtPRC7rskX2z7mBIcOQP5d5mVAg+2LWUzOE46eoA8z//04Kp010kBmqtXWYMUb+5zcbBlZfQaMDw6iI7opvvBCzKPepXUyW4Wb2r0/n2ygef/oEFqUrA1ZPl+vbme5MD0CAFgapyynFP2oAqn2aRI1+7gF8W760ofHk4wbL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hENgWQa+SIlxDusf3vX8v1UG62hK+qaFvkJCjOC3WlU=;
 b=VkYTb2HX9ORJXR3R7lZFdcs2NR3oVTg/PSrKJslIZQ4E1OuLgL5Ej6D5LWVHiLU+16PaaILs8gaC7M/nmi8QpJnuLP/KEcmVc/E+TayTaCccSHNpOZ96oEOvZfBGEXMXkikZt8ZyVISlqqeB0GShlbUE5SH6P8ijYoAXiuIdcTVpwQ5JX3h/J8ICawfHC2MwwmGZJW4wI8UknddlZoVlnulkrmqxB9lcsmLbI7QeZ91ls0y5jxakMF1dssHVS4ZDrxFcDK3/InP0ZoPgE+pmtFetv8Va0vlksycrD8sSAp3JRGMPs13ZBvJjwFOq7af/gvu1z10idTtQIlnZnV0yAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Thu, 7 Aug 2025 17:00:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 17:00:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, david@redhat.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
 npache@redhat.com, rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
 surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH 3/4] selftests/mm: add check_folio_orders() helper.
Date: Thu, 07 Aug 2025 13:00:04 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6A8E4E50-88AD-482F-811C-8707027B1E1C@nvidia.com>
In-Reply-To: <20250807030000.33303-1-lianux.mm@gmail.com>
References: <20250806022045.342824-4-ziy@nvidia.com>
 <20250807030000.33303-1-lianux.mm@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: dc302143-9e38-496b-d7aa-08ddd5d3dc95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Yr5J+YbJejVjtgDofMOn35rBqFGCw9ZtKumD83Den4AnxXQSlz2B4/Ax7AM?=
 =?us-ascii?Q?Cw3Nnr3pkBSmQjsZvaSgsokonsCsz/MQhQAR7ncuFmzeEb34mKP0Z9xd9rE6?=
 =?us-ascii?Q?qIMucYgZE8Qu/XwZ4AmbgTWdPL2IyAvV3xhiptVaMEJe09eZw3gnpTzq5GnP?=
 =?us-ascii?Q?A0uAU9nqBK0MkJsx3tb6YospUep+MAbBdWP1cvWpHs3/HfMG8xiUFR2Wy4oE?=
 =?us-ascii?Q?cEqgqVJtEOhjM4TxQmfxia2YFfixyjjALQA4hWnh8/tJcY5ytGEVNBGR9gIe?=
 =?us-ascii?Q?fgyaFGvbVL/gTCwqCMA1Rk9M9uhNfUZB3HHm5f8nzgXtztOeTRXb8dES9FPV?=
 =?us-ascii?Q?KFLqgwyVcjcXOeFJGmxiAYLs4e5zj/rWY8y+qpfgU9SLSkhvQyYd/Z+Te+nc?=
 =?us-ascii?Q?IhJSfxakl1l4MI4oucGKt8kVFsbCSD4kywPGtWLZdNT9aibPk7++xug85rDA?=
 =?us-ascii?Q?uvGDMmZszGn6QKbJWYtwnXn1EKAOEjjIXmyD0F1b7Sl6GPT05juNTetRzwEl?=
 =?us-ascii?Q?3a3370yxa+PVjC+7E0Ce40M+0LJoI6Tok5XtpXf6L4zcO7yRDNyxHe3jZnAz?=
 =?us-ascii?Q?mJEwxNsL3/LLp4xj5ldjoW+iNaGIGJVfzpcyktzE5miKrgq3x37ou4pw2DAI?=
 =?us-ascii?Q?1ERLboPvFFbDYRxNVINLOMrndftdqVCuNg4kFb6XtUoaQaui7M33SGmqGPdv?=
 =?us-ascii?Q?9KVwU2gftc3kGEihdZlPmNpPa4VFpirMwhMb9k8vi9qz7uuSUPcOMZxNdkyt?=
 =?us-ascii?Q?D0Yg3Y0wgat1ErEM/IxJ5N6t8eCl3x9HrFme0kkhsZ7WMjKs8xvjYV9ESfNq?=
 =?us-ascii?Q?ztwmBZwLYeNmiDZpuGg9relr5Wk4k1oG2MWCYdFVMRK5ZCfa7ihj/FvO4KAd?=
 =?us-ascii?Q?f7+f2invatYeswsyeWkw/mVhxa0a1YIyuXDHZAl31yvfZMtBekw+sY98iM3o?=
 =?us-ascii?Q?DrnGb3nacF0w1lK31S9nMcNntNYV6MAGLnW5BvMGNsE8w3rs8Np5eRR1ivKf?=
 =?us-ascii?Q?ZIufKro22Q2L2kCtAz1LA5R+TZluR66yqAvJX5nqLV3ZZb2boTIIWYMjJbt5?=
 =?us-ascii?Q?iPXXTXHlM19V9aoVpzzCJUeVtarQprtJbvi66QADneEymBJ2upNyDFhbTeKj?=
 =?us-ascii?Q?419HLpuYnQn5eC3we8M7HVSgqiov0QjkgppNxSR70jHnUqVb0K1pKieeQTSH?=
 =?us-ascii?Q?kDbUMmnzBxRUEmYiU4CCc59pQ9V1Cgism1sgRSXEs3RAj6T3lccT4Gna42G+?=
 =?us-ascii?Q?5C6QXlepPR878Jc7xjEYg9dU1Eb1GQ5/xSLQLNI/JYw6KqQcOCqF3CuDGZdq?=
 =?us-ascii?Q?pOyP06PB1Rk+XYnb6jxFq7dugBpMSREbt2Lm4jNA2iDfVR/1uftDiUCUdfD6?=
 =?us-ascii?Q?pwKTl0aELp7lphUK3xDA4fw/qvqJpaAbKFvVuEwYEeUXZ9ozVw5DBAz4phgv?=
 =?us-ascii?Q?E67tbNl+Q74=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/oQPF3MTiUdE0rcF6FzudjUIuqX1AjtxmSbF9sV5qcmSbk01rbkuIPQOJqvw?=
 =?us-ascii?Q?XRQ/a+WmgnnebB543iDZanE4iMMwgZKIK3RqlITtiUpBMdvAFk0yeubNR8qT?=
 =?us-ascii?Q?mk07IBcXkLXj7YIBblQRSLB7MGZTaHJ4zftCdwitGs5cxgvuN1Svb9gCeER8?=
 =?us-ascii?Q?RdxiZ1Y2kFau18o5eU2n6yHY0DEVxqk1LTQ9KjgocgAYF4lFRRGg/C1JSjJy?=
 =?us-ascii?Q?/gJ/RnloiuyhlJLyn/NihvNrgJzNBNl0jmllzVlIO2aGzbGqGUPSgvqx3T7T?=
 =?us-ascii?Q?F3+p4kkH8apGq7oKiyDtywF/6kVE9XZC9F3HVhR1XhTW+NQCp3d4StrNktsV?=
 =?us-ascii?Q?JfM38E0HKWeRj6TYaQsl3KyyIf0T9F3XhL83yxt07zvvrvHxwvFxeyAe07yo?=
 =?us-ascii?Q?CRHsT91gYztuwZHRw5fgCmC0NBBv2KgknS1nYUzVn/DKxmpEcW5K8pXyE4Rx?=
 =?us-ascii?Q?8TVctXKwxK92DQNPvFtvpRL7TBq8owqrwKe6d4B5Luf1CsM86pdfkZKsqZ59?=
 =?us-ascii?Q?siwQC3fDeWppYLE3x6k7LEM8mK6r7ALhLdfn3BVP5Fa/vfBb4Jdv7dXZkc26?=
 =?us-ascii?Q?bW3D6GAM8lARLLBsRo3m/yvvH6U8y0aCWPfV6JmVlXGZmbt+87rvBLpH4y0B?=
 =?us-ascii?Q?bCVEdLQQSe/zHJBVtfIKngUnYrOgSt+Jz6sMJkLoGfiAI/ezo6NOyNengdFK?=
 =?us-ascii?Q?KlvrABlXgt73Vlef8w1PmGD4C0XqRbMRd79x6mVQouUBJ3efkhcUDmEGUEfe?=
 =?us-ascii?Q?meG/V28/7xqLy24AeEYtn1Gp4Fie5OmxHMva5agzahPptF/BNkRZ6IvKAmwE?=
 =?us-ascii?Q?ghlEkFixzgzR2Ns+5GbAr1f+Yl+NZBfyzMwGLt6Kkj6AHhRTx8LU5JNPhErC?=
 =?us-ascii?Q?QsEmY7KOablHcUQyKKYtNSU9NZ4WhqHVQtfrvwfewicbuV5aF+Xd0YyH9XnN?=
 =?us-ascii?Q?x1dvuTx3bj2++wqdAmziRv67tML2rdLPCoVE+VSzxW6wpzvHsXn0sWJC3oss?=
 =?us-ascii?Q?6ktmoGjFIhIzrsKatqfI1cRKEvVGha1CdKFolgkS33rWz7TlTSjC31ELIHtS?=
 =?us-ascii?Q?MlI6acDu7PLB4pIRHKjQ8+QuuTf4T1PCashXfkw8mLaIUrSyMcFDf/5kzZ5W?=
 =?us-ascii?Q?q6yiAL4ssh4kpU0pTlykR6jktp3KVF/tU0u0kAxCQn9kwmNcj3+YBMKoTZ4a?=
 =?us-ascii?Q?oC49c+I8VNUulpbMeUzaoF7ChCj+hugVUPzbSZJ1Q6kGpS/wopRUnMxDKbMR?=
 =?us-ascii?Q?vg4UkfDsIM1YWMoEpx2IBUv5n8LJqCkoYKFViRjnSDFsP4p6zwPhrlKvJfmc?=
 =?us-ascii?Q?lk7k7DvJEQSDKuAxdxalG0Bp5MoXdGmIOze283te+iDtDiSPIB3UpJl4Sqmo?=
 =?us-ascii?Q?LtUtJCKTNlx+wHtYCqUgNJvjmDG2HNO4hRdNECQmLeRa4CP+/cYpZGOxxTNP?=
 =?us-ascii?Q?LNrEDyZq996koGhuvFXygEVnLtrFW7OmHZzmQJN1S3yQA4W3/TSUXIKFhy92?=
 =?us-ascii?Q?pCYVvMV570OIqMqfINy7csZolSJlP6Cib3V6mDMmCOw7aU+QFGsWuF7kSBCK?=
 =?us-ascii?Q?vsRzBjnqs8VRStLtoR5ssumkQt2xM7ZIyDMqBAfJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc302143-9e38-496b-d7aa-08ddd5d3dc95
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 17:00:07.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgpLxZEHDLmcO7T8n5c153XuCI8Rwb2JYPIPCnQ5D+62Xdr7b0ltcanQgrd4LOUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081

On 6 Aug 2025, at 23:00, wang lian wrote:

> Hi Zi,
>
> Thanks for the patch.
>
> I have a nit suggestion to centralize some of the macro definitions
> for better consistency and reusability.
>
> On [Date of patch], Zi Yan wrote:
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/self=
tests/mm/vm_util.c
>> ...
>> +#define PGMAP_PRESENT		(1UL << 63)
>> +#define KPF_COMPOUND_HEAD	(1UL << 15)
>> +#define KPF_COMPOUND_TAIL	(1UL << 16)
>> +#define KPF_THP			(1UL << 22)
>> +#define PFN_MASK		((1UL<<55)-1)
>
> Currently, these macros and `PGMAP_PRESENT` are defined locally in
> `vm_util.c`. It would be cleaner to move them to the shared header
> `vm_util.h`.
>
> This would also allow us to consistently use `PM_PRESENT` (from the
> header) instead of the local `PGMAP_PRESENT` duplicate. I noticed the
> patch is already moving in this direction, and we can complete this
> cleanup.
>
> How about a change like this?

I did not know about PM_PRESENT. Sure, will move the code like you
did below. Thanks.

>
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -17,17 +17,6 @@
>  #define STATUS_FILE_PATH "/proc/self/status"
>  #define MAX_LINE_LENGTH 500
>
> -#define PGMAP_PRESENT          (1UL << 63)
> -#define KPF_COMPOUND_HEAD      (1UL << 15)
> -#define KPF_COMPOUND_TAIL      (1UL << 16)
> -#define KPF_THP                        (1UL << 22)
> -#define PFN_MASK     ((1UL<<55)-1)
> -
>  unsigned int __page_size;
>  unsigned int __page_shift;
>
> @@ -360,7 +349,7 @@ static int get_page_flags(uint64_t vpn, int pagemap=
_file, int kpageflags_file,
>  	 * Treat non-present page as a page without any flag, so that
>  	 * gather_folio_orders() just record the current folio order.
>  	 */
> -	if (!(pfn & PGMAP_PRESENT)) {
> +	if (!(pfn & PM_PRESENT)) {
>  		*flags =3D 0;
>  		return 0;
>  	}
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -17,6 +17,11 @@
>  #define PM_FILE                        BIT_ULL(61)
>  #define PM_SWAP                        BIT_ULL(62)
>  #define PM_PRESENT             BIT_ULL(63)
> +#define KPF_COMPOUND_HEAD      (1UL << 15)
> +#define KPF_COMPOUND_TAIL      (1UL << 16)
> +#define KPF_THP                        (1UL << 22)
> +#define PFN_MASK     ((1UL<<55)-1)
>
>  extern unsigned int __page_size;
>  extern unsigned int __page_shift;
>
>
> Best regards,
> wang lian


--
Best Regards,
Yan, Zi

