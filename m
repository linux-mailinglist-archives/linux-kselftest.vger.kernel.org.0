Return-Path: <linux-kselftest+bounces-31898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094AAA0DD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4691B60381
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B42D190C;
	Tue, 29 Apr 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfmP+qIZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7702D029B;
	Tue, 29 Apr 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934583; cv=fail; b=YPfmxcMp1elYzOeu/pXhFwQMKcLtaB7xriVQDQgGJvUBgTtefqbZ38CKCeXTK+vhQvZeMxbwPbmIVir9o011rYpHTQ8TeeXPjt2+21lS35wTAd8QfOC4WnO6B6f4JM7xr+sAUNv2AstTYYd6YjQlma8c3TQ/VRSEXQcICdfvmqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934583; c=relaxed/simple;
	bh=KJw0OgTISmp3eKbnKCgNpUWa2BVc99DkN9xwtlaN7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVukv76sTEdWg83WP5VUCag+LNIlQhoEFOOzpS42f+IwWzrmUaeTnMcf9xhLHBHe/YmItHweiSuu25Nq5MXkSEZUCHdqGDcQ8/JU4huIKq5pm4wZfUwdxmnCZbQXuR+ECl0SrDE6BaJpIzejJ8RojDNCVYN/3eIY6Ccpw4OD89s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfmP+qIZ; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYcHl65/p7vDyIuYEmN0lQGWZKwAKTf9tKA0zJP8XSj+jKLnWCqp6xx37C7VC/izbn9aLe+HX5/16ugCHzge3GdW8PIq4YnRnlbJK7VGXWah9ZcVV2XkI53GyM6zXoHWkP87tsAzY+aynGie2Pas6c3X1/5fdMuSXwvsT9wtnL80MFJsMaZfTtSawNSdM3Xu6yAiTrvfakbZc3MH6TokSiUUlBy89/g9+un/ccvaMpZAvC0xHxLgxtnQKD9ARWoXtZxhDrSs03YDF9X6Y3IqQeyUaTT3cN7nmTF52yGdlFIx3SAHTri9YTyQd6vzwh7Bod/WfH653NzDZrq+XxA5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMEppG/BbwMIIeOH7IlK996d8QMwyiGVGOxCoF9kthw=;
 b=FYgEklIKUO3gXkhZigaweAN84v7McRWDlnGnurhZHy+Lkx0roebIoJKP41hqWh9Eh1EKs3mkbbC+RL+yQvmzFrgF4tFY2IEQIHvimDxIYsyczwxslgqkSgf986cZmd3TFFPMXHO5I62sVEfvoYQZKXqY5ew+YBsV11rPYTrKjXws5YEaeypKz1ykighaaYEoQJCcmgR4KLXP2Xv2BwEf9/okKorXnkuTRn7fUO0Fom9KNYk57yDdQrGXEJDP0SG7lk/UsP/PhpvWB38sZ2Ky+CXagQNodZfhj7Ywb826lil04XetqSqqes4CcGr/v5SobVunJMUJ5wQbdoV3v3NDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMEppG/BbwMIIeOH7IlK996d8QMwyiGVGOxCoF9kthw=;
 b=UfmP+qIZ3PaLZePN/WpIjCh9vfsfa35yv78w2OnBAMqv9Bko7c+HgqME+M9NzEJ6MjpEupHBfhZ/M+8ONtLQfETBLPXGyF5woAzY+MvzNn1q9Y3lIfVjFAnkzihPh2cF7a/C1M1tTgDS6E5lgCKUYa0tQj3oHaABgBwnquWEw/CRQFm5GpBW4WgOu7Wt6fKrZi3YXbdSmQnyDrbLHpQSEE3DVLK/kESG8EdK014ZANoTllQCGYOAdEGPy455dEUAcpJX86jMeLSJPCRDmm8ZdkE0KxqZy0CUuhmLKFZZzVZs5cWDKA8amJ0c492x4wsZQ2pCJzrm6KEWmaACjuRxHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Tue, 29 Apr 2025 13:49:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:49:38 +0000
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
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 1/4] mm: defer THP insertion to khugepaged
Date: Tue, 29 Apr 2025 09:49:32 -0400
X-Mailer: MailMate (2.0r6245)
Message-ID: <B76CC5A1-D4DC-4E8B-BF5A-DFBEF13E02F5@nvidia.com>
In-Reply-To: <20250428182904.93989-2-npache@redhat.com>
References: <20250428182904.93989-1-npache@redhat.com>
 <20250428182904.93989-2-npache@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: ab998842-563a-43df-ee50-08dd8724af06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kG41l9mnYme0l40VPfuosUaQC/Xm+0tqi1/Sg5U5QEdlefhvnrfIb8WRtVO1?=
 =?us-ascii?Q?5RRNG+8/x3Ct9wXTJ1dHvSINkXjad2FET1sAR8DnnirpIA1ctZoOtHHtyLd0?=
 =?us-ascii?Q?YnPCKgGK9+QCrYo3GRUSdMoRKBq9cDWUDcIWZNmY9ePc/KJEVra8tVTj0RL/?=
 =?us-ascii?Q?HKQ+YF+LWlRJdVNNh/rveNhcywoZC1k2R4759leX/NHUokRQIkxcpiSuKcm2?=
 =?us-ascii?Q?9KsrYCRryeyziMJ2L2Iki3vQh5BZBAYthQckyxmn/FaTgr6yqoRpskTYOQKL?=
 =?us-ascii?Q?Q3luoDAGxYbpLQhhI93PDfvqjQZIcnQU+hegRHMTjNIHjRmwY9zu++t3s/WA?=
 =?us-ascii?Q?D7LJAqD60BqlpU6L4A6BHiiCzwTPjPhRwIbd5d6+rrGI+Z4Qob3nOB7F/p9Q?=
 =?us-ascii?Q?gW8lOs1qWnwbmYlUnWjDimzKWHRIHC8U7bauLALRtYL85eMAAsWdgz5Knufm?=
 =?us-ascii?Q?972tqUU5mSHsz1sI9ZhWJbJtocakLeupe6YZH3Vh7iXXSWFZD+F24BnjV52e?=
 =?us-ascii?Q?dPvuFc8m1X8nWuMqOy4fCl4eDHTGKT0EKiFZrsEPY14NmY0+AFdUE5vgFMlQ?=
 =?us-ascii?Q?PdiRJfl/lEdfWdXtZr6R0Yo/WKUhoOfQytggGFBouuWGPL7818v8f/tMUmHe?=
 =?us-ascii?Q?jK7D9S3KQIDX+CQLT894NB7WQj2pHVIsgHr0Y8j0j76R7KfBNNNeXZBUaKn4?=
 =?us-ascii?Q?QheFXxt6oLeMjSNy6AxBOrcnq/LgGcdacx93+M/X+BTekhAmxZiVjq0712mf?=
 =?us-ascii?Q?brutLdCeL1FE6DA/6f3gn4Ob5tajg/vVFDnDRz5FwcVdxFnQuCe8baw9GRre?=
 =?us-ascii?Q?mft+flq5/C3g0FFqGNmbUmb3LYjvB9y2eggtHLLVCbmfGWoniTgHIHhiVBt7?=
 =?us-ascii?Q?JtwUIxE39I/P7Y1cLF1vEtRDSRw1fFXga8ZhS0ZtIW/LhThtgtYqgLn+h0jl?=
 =?us-ascii?Q?D5mA9fj4ppjvrnI4+nIthjJLoMlWA1DyXh4/VCoQpOkcop+aSyI70JXPA45m?=
 =?us-ascii?Q?DML9zntqlUbiTVjgUC3wDpf1HfQ9TZaB1yfacKq6l67TD+yd0nPz2f2wWn+M?=
 =?us-ascii?Q?pExbuuXS2g7TJYXAnw7mW+dcmNaPHWLhReUQ6bhJIVFItSJ81Uhb948ebV6S?=
 =?us-ascii?Q?w/y6/v9QngeDABFdVsoiMYb7n1mQKItxr6NzA07cyXGPvqr+Pn0ndfgZHuD3?=
 =?us-ascii?Q?U5rarNi3eK7vcGwZsL3hStwE7uHwAmsCQ48gkohbp1wpnJ1rVK3wkRfg2xcf?=
 =?us-ascii?Q?gpWngFkPTr9YywkP01R/QaSgQ+y6OLebSwDfkBxe3QNPG88RTrsNOl00zELu?=
 =?us-ascii?Q?LSHkrEc+XfCN+BPnXNxVpwsKeP1nH5DMYMSvIRul0igaT28pdsY8NKjDo/yX?=
 =?us-ascii?Q?AAypFtl2eOK7jdhXJsOVUxOOQOvC7ng8UXHXy5Pgd3LTkZDp2wguRWkWQ4Oc?=
 =?us-ascii?Q?A+45LJG5VvY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/td9BcIVnmc/TFDeg6/TfyZvkVbIpn+Hl+BhlNsRuQQDqGiyvccVYTPWZgql?=
 =?us-ascii?Q?a7ZSVxcWJc2Zavo97yc4dDjkKPhhLfbN96C+xQt3cvEMHY1p8vIr1PqJL9Wk?=
 =?us-ascii?Q?zvt0DcBFxS3oPceFJpmnNQGZRvLqX0+Plp2FnozUAHh5hQInizjbyUMRw9KF?=
 =?us-ascii?Q?QSaYVHoBiiydAu4CmpZMTaugIXaOpbGp0oAcZJsa8i5l6Wmr2b+nHphj0ZRA?=
 =?us-ascii?Q?caxM7ZhKkrfPKdeJwdH+EmLuclHlAIH5rKZX0eZRwrkDFriRgf5O6teiQk3f?=
 =?us-ascii?Q?3v7tj2pa5l0mgfPJEoFhgjepr8t7OhjQwNibgwUQpcG5mvpMbxkByVCeoOpV?=
 =?us-ascii?Q?C21VJwgZ+VOgRVk2+uvHAOMc+TEQ9Xt6pxx0Vggv2gc2kAn6FIcIZ7le6T/I?=
 =?us-ascii?Q?R479qRMvDz+2APnRU9qQ0GEZNmLJUrPqKQziWKJgMo561x3BWFBi96zR6CwB?=
 =?us-ascii?Q?k1VsRY9SVHAPxRp7nss4VMxgF7+9D/HmAKjnS69tG+2/zBEinPBWHEbKebzC?=
 =?us-ascii?Q?tnA6e3KFvuYZv6exgPfF2kVqR5zBuT4VUW4soOyvhe5KmDckHQ0HNCX2NIVb?=
 =?us-ascii?Q?eTBgvj7nfkeSuBNON2Pk7SZa6Jr6GsaDhCVIIaJopEPKjzpucw1eu9+GZhaX?=
 =?us-ascii?Q?A2l2/+0ufxZMBB8g48ojdtHRvoy3apzGlIKMt65lE7REOrIWE85psCkpA+hO?=
 =?us-ascii?Q?MIcXs802p7Jq/j8RCC9yaX/qtq4w4yspEPkp4mGOSXnGFSLP/sKC/fmlZFXu?=
 =?us-ascii?Q?hSiTY+lDyHYJ+Lbpw4Row7PBjqCWVZXQn9qi6PEbOLeGIqgbVPTFXeJ5S2/9?=
 =?us-ascii?Q?3HnTnZFk6TIkum9XZYla8Xt+CcNFNRbsaMBN4PpgIJvxuR3XEcJKobnGxpx2?=
 =?us-ascii?Q?CkSPH4XbVm4V0XQq1COrQJdQ5DV36kjJbFn8vvcsWExtpajPoIfA4y7LemIV?=
 =?us-ascii?Q?zipIpsVtplGrJpwyUvf8jUYhKgMOjERVzcB1WEh5VZ8CJ+5YmBGGakzYGC+T?=
 =?us-ascii?Q?I0pPQfALkf0/8rh9mpbq690Q1MUQLDE4oyaMTUmES9ohgHMtaTOFXmmm98HV?=
 =?us-ascii?Q?7E+A5LZwSJaAkK3jXxWp6WwUOk0uxoQxxKNN3TyZQp/fpwaRAyBJcK8foEyF?=
 =?us-ascii?Q?9Y2k9TaGLEOzyV/U8UDKJlFzpH4D15Q/hPzA95JJFg6wt5mrZ70DZkfhHO/r?=
 =?us-ascii?Q?uR5yv8YAN++uyrtV96RKJ7tgeyV/JoeVcrVfE+AGMzlwDgWSf+9JpG2P3Mjr?=
 =?us-ascii?Q?Dl2XiT+iepm1EzKIDa5tM1s9lvpGhUE6k+AHgqcZx8tUco1ocF/YaPCwFz2O?=
 =?us-ascii?Q?d8T8aeARnbGDjQ5xzfMKJj+0tiFBN+LBEEQXJqCiMrQXKFQ5xDF1BBpbKB3X?=
 =?us-ascii?Q?doDjZgrviZ1LksEJaWKGtrGneFXRcXc2zq6gzLHz9YnahuiqycWSDXZSTvMu?=
 =?us-ascii?Q?HuwquW+f1MUwGdTQFvaPpgvEG5wWC9Wi/CbDf9HIJxTAh+p2eMAikbbOnVAp?=
 =?us-ascii?Q?8ykv4ojkw7tEwqA6HahwptwUIg23bgC2+xbXlj+4xYNjhEc6qwSLv+ZXdTNS?=
 =?us-ascii?Q?SAy4GojFxouxuD2zT23m/EoOC6Jb99jkiRmDhAlX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab998842-563a-43df-ee50-08dd8724af06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:49:38.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go68Y736Tu/vhYEoZdsDTD0E4Hl1KqoEdBqPdJcZFkc8hTTY2Jix3N2FT28/vThP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561

On 28 Apr 2025, at 14:29, Nico Pache wrote:

> setting /transparent_hugepages/enabled=3Dalways allows applications
> to benefit from THPs without having to madvise. However, the pf handler=


s/pf/page fault

> takes very few considerations to decide weather or not to actually use =
a

s/weather/whether

> THP. This can lead to a lot of wasted memory. khugepaged only operates
> on memory that was either allocated with enabled=3Dalways or MADV_HUGEP=
AGE.
>
> Introduce the ability to set enabled=3Ddefer, which will prevent THPs f=
rom
> being allocated by the page fault handler unless madvise is set,
> leaving it up to khugepaged to decide which allocations will collapse t=
o a
> THP. This should allow applications to benefits from THPs, while curbin=
g
> some of the memory waste.
>
> Co-developed-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/huge_mm.h | 15 +++++++++++++--
>  mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e3d15c737008..57e6c962afb1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -48,6 +48,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>  	TRANSPARENT_HUGEPAGE_FLAG,
>  	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> +	TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,

What does INST mean here? Can you add one sentence on this new flag
in the commit log to explain what it is short for?


>  	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
> @@ -186,6 +187,7 @@ static inline bool hugepage_global_enabled(void)
>  {
>  	return transparent_hugepage_flags &
>  			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
> +			(1<<TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG) |
>  			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
>  }
>
> @@ -195,6 +197,12 @@ static inline bool hugepage_global_always(void)
>  			(1<<TRANSPARENT_HUGEPAGE_FLAG);
>  }
>
> +static inline bool hugepage_global_defer(void)
> +{
> +	return transparent_hugepage_flags &
> +			(1<<TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG);
> +}
> +
>  static inline int highest_order(unsigned long orders)
>  {
>  	return fls_long(orders) - 1;
> @@ -291,13 +299,16 @@ unsigned long thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>  				       unsigned long tva_flags,
>  				       unsigned long orders)
>  {
> +	if ((tva_flags & TVA_IN_PF) && hugepage_global_defer() &&
> +			!(vm_flags & VM_HUGEPAGE))
> +		return 0;
> +
>  	/* Optimization to check if required orders are enabled early. */
>  	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>  		unsigned long mask =3D READ_ONCE(huge_anon_orders_always);
> -

This newline should stay, right?

The rest looks good to me. Thanks. Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

