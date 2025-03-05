Return-Path: <linux-kselftest+bounces-28337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7418A50D0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65E5188F209
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D601F5845;
	Wed,  5 Mar 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s5OpZnv9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D11EE7AD;
	Wed,  5 Mar 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208895; cv=fail; b=EIZxtMzV+3Df52aDGt3uKy9EbPLvC5yIqtjlK//i+xadGcBBRnsR/Kw15NKQD840qzC7wD+frJ8TtkcHV/8HvdQYZ8J0SHUt2cmxBaRO5WKgQkjFRMit4sk8T5y3je1aDVmh8jiHqbbCFkG0C5p3jtylaXsuEjYyLcS/Gyt8RzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208895; c=relaxed/simple;
	bh=xFeMDmyv14l+O15f0k62Q2e4W/ULVHijDj6cC5LX0Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCfSm/Kc4VdYTMX0ro6n9zS7tnnIUqdrwv5c8bShMIxmmndCKHwZetYoRyzQnPeI1GamIqEoEE9YF+3pqMBG5tYVARBSMhh9vS5qhw961aGnT9W6YrWrPwrE/SYBXO4l3c44BSWTN6D+EU/iJ3VTF+uzPleyn0gu48zB8ZW+0QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s5OpZnv9; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEdgB6azp5IZiWeGV46m61q77FcU1nmfCXJffjT+vYCBZjcVLwEqfrrDCkR7Zvn0BZ1FISO6PibM1Gs8NG/VaOTf2qOQadXbwNxt5t8j9EWbWEgaE3mMxq4QmAIf332kNW0GkjOqcdoq34usxVjX7KZrHWgW3ZWNarXNXahTysx2JqmNVpiHnk3ELsjntr/88oz012ybv4EXNEz1WpXo0yKjz5O0uh0LtO4QZQM1h/EKdnr8vvnzCFwJalmhSw3McQaFRqwDwCpczYNSerewZ4CMpgR+qZJ2WkZN3ggVGGnVPjPvy3hLb9Wsq3PEFWYlvg5HvVQtKRSc8jf9tC3VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFuSZXbmc8APE4wrOzdBdMzELWP5V2p3sNY3S4ztZHw=;
 b=Zduwb6qmhYq05vsrLVyaPvEIBHz+M7zp/PElAQIFyDS8DrO+E6KRXn54B4GDHd9YtaZtWZymzZFEVzcivWItBgRL3SAMiCCrKdPncTIIEuJpl0dI7kjdsQwpbpBuVNudRWqptZ/5IW8hTseeIWwTlmvC3gguCddwNyJPFNb6k8MVLviJ3K9rCEJefqdQOTklk3pjlYku2cL5camMGvqc7e1YpYjbw+s2X3Rsi+761fwZ0EfbwF+d42F7ZYyPdn2TZLEPlFImOaVBHX0qdLeWkcZnWbLF65hT6I8p/tPAjzeh9d/t+pYQOOQaLn/txn5+S6noRNHJmAKdaiiEidIzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFuSZXbmc8APE4wrOzdBdMzELWP5V2p3sNY3S4ztZHw=;
 b=s5OpZnv9q1EcJ7PVnXdRjnb7sA5AAwSFN9zRx7SBhen6I1m27fozblgUHuNo2Ikj75iFK+VHdDqr+aJ7HicCSqxbGSaeiYN9Nkg6LVAlNBKHL6q51ZOc1EDmd9w7WFbaigQcl2Jhk8x+DDXVmnQj9POinnxhiaY9CJiYclXhOnX8lLwbV8nS7/hOEO7BZ0Uhsy17RdU88S80j0nkpxHTGbmhlgXS7vGS/1MVPflsusBaQ5jDr7E3PKk/F5CILR8m4SW6Rav7NgooWL5VLVlNVTX2tmH2perjy/dPtIMstF6xt+i1PNM9IY6x1IJkLdEwhm8drI8xffQ22aKcmE6uXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:08:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 21:08:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Wed, 05 Mar 2025 16:08:04 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
In-Reply-To: <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
 <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c08d10-85ca-49b4-fc0e-08dd5c29d4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQ5TKV7cwWSC/R0rckTBReA2yy6eWH2iyRC28D0PadxdF23nH7kTlqOotfKq?=
 =?us-ascii?Q?Lqr248zHAW9/ugM7UskE7Jtbk9AyeAXHlekm2r08XPsDT7hKcrlMaxJWQg+9?=
 =?us-ascii?Q?pwEd0Qjch2diGZQwXY1oVNnQkwbCIj0JzkKhAFBJqbrUlXSpn02t9pbHoohh?=
 =?us-ascii?Q?6BRMm4V3CDULYzAiVm2vDkcC7YPXP2pENG241OVz90wJ0IjkItAPsNIbGwrM?=
 =?us-ascii?Q?5vLb/t0Rt732CUtIqIWmI/u7Bgc0JSiVf579wiSgQ9W++J/RYWfd1uKOE89g?=
 =?us-ascii?Q?DmY1SNo7WP1NaENJ+xA3X7B15ItWlf4MyGbGZJlfz4QDRJg9ZBTbizjjFFB4?=
 =?us-ascii?Q?DFUK32Gj1w0F5SXTgyulQDRUJ4xl3vZMYhMPm2dxNNfwm6FFb0Z4W+UIxogB?=
 =?us-ascii?Q?u0DT2bpgaKe0+etz2dxR1Lmh5fVI0JXJigoakLCLfwd2yUj5F52Toxg+mHno?=
 =?us-ascii?Q?PFOju9wgDVqIyuujBbU1jsm547yW22t4TECCVGPWbdmLy1+KRp9ZUV1QnOzt?=
 =?us-ascii?Q?FnS6FEPu7d4qIDJ59Q+OmAOTpkSEX/RzQeZwwLQiq1tZDPGKIPcJ9zAAMRW5?=
 =?us-ascii?Q?iKGaK2bir0xQp9ZzpZNcTZv6TZqHJukQ05/w+JlNcjxy5Yyy1ZYWxznHMgPb?=
 =?us-ascii?Q?9y4afh4JH1dY9XjDporfYLuBnz2D4FwpqBkKeZbT3w4VGBrw5uX9ZjSe9/rJ?=
 =?us-ascii?Q?mtRDSwqx98kSxFQbIlam1ywdS3DeDp0PncmeLOEy/R203IWC+1MaHA19vuSK?=
 =?us-ascii?Q?AtI+3CkQSXOLRAWab/n7JccEyTl7s4BvrdEcTMbWEiKCMu/w92PryoM0o0mz?=
 =?us-ascii?Q?Ri0sbza1Hkde9Ho2RS+7Tpja5WpEeuaXid4C5iAGog/mtxdrwrzedhbqV8Il?=
 =?us-ascii?Q?leB2kMtaFE7rHdS8QYQXOtcyXz+V7FdzPpjXZ7yrRWAydNw2/Tp5C3bumNHP?=
 =?us-ascii?Q?Mbs4L0ZEgF0LyqNh3FDSysX7EsI06fXmbVbcsbm/EJRMKnnxtSn68zG3fdpd?=
 =?us-ascii?Q?1LFiQX6ebbZoF/U+fI851uPWP5L/4Rc7PR0qHcuS12/pcT93+yJSEbd4p3w7?=
 =?us-ascii?Q?1mShUPBOSihpRJq/KxEjbrITPee5jbFDykm5xD9jDKLY5DRsxUmbE+OHpdZs?=
 =?us-ascii?Q?VFnlL7wNawP+qe/0e3V52x3Je0qBIEg/he5oBtAiC/zqIPTZjM17CUMJH3fy?=
 =?us-ascii?Q?96PqQaJJ92JusU0vpnOqgQeyMIEXgy3/e0LlogBcAbvP/AnKC/LYWAdkwFWk?=
 =?us-ascii?Q?d+77hg6urmfDz2zqUbqrY18tBz10jC8wWyUBO56pMTV93hiUHzjrGCbl6SZX?=
 =?us-ascii?Q?1KCng/bAD7trnW/Ism00OAZw4pFXpX1upjuPLYqX+S/go4UIZI7K94GWcKBI?=
 =?us-ascii?Q?+CwNWs7NSymlyp6XztczKAtJVhGF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4d3/7JUvGi8E1faxTAusLSUaMd7C3NiErtdK8GJL56Y7efQ+9YMr7kWzHvx?=
 =?us-ascii?Q?pgfrpFwYOVBQ6SJwu439sCbX/blLQp4flneRYzgzC8KlKDZfsMFWBAA4lZsZ?=
 =?us-ascii?Q?c2PqLSk6VJTv6VD5bIXQBOdHvccfVJhA1WXrGmrqeBDP5ns6FUZubgLSNYlM?=
 =?us-ascii?Q?BGas8DzGpROhzG48BHp2ij0zr4yXkVC5rUw6YyyQU/2WMH2xQfJIkPm2SRfQ?=
 =?us-ascii?Q?fO/c23QuEIoA2FyHdNTcG36l2AAkml2OnfOA0CUeTi+ipPwvq6ggc1+maoYd?=
 =?us-ascii?Q?HrFDRIPbTaThWP6iwn1Sd26Bz18xdfRSl/OAdPjVwCfNayW56z7RzH89eDGN?=
 =?us-ascii?Q?anrO14U7cfQPDUayxKH5yNxa6ykTxd+heNktLxi1U5Gmj5ImUhITnBYdGJCh?=
 =?us-ascii?Q?zaHdCGs9nLYRj3VZezR66mO3pzBV8ztSxeFDdWjNGHd7jUYXteZGVn4IYBk+?=
 =?us-ascii?Q?uxFS2t9ZQipRxp/b+5TTtJV6C+eMzl1BTIWGaEQPVqJrQ78HrynIVFl88f6+?=
 =?us-ascii?Q?MSa8ZKzm/bRkLRFCUEctQ1hqUSVOxLBBSnkuC75kpDm3GlGLd+Tw/A89NtLB?=
 =?us-ascii?Q?FL9RxVsOxpfL/qg3b7MQiB02qdtf7DCFlHSwY/uGdPJerWO7//gkemadQ8GQ?=
 =?us-ascii?Q?zIPZxXoQ9ha/S24vrt6jTVbVFfgRNYGTnMky/V7pN99FVefScq6QegB4AhuH?=
 =?us-ascii?Q?WImo2aZ/Nc1+xcyJ/iQGPhNj69JSG9Oz6aIf0a0sITxcY+vbZEMk0zIw4EC2?=
 =?us-ascii?Q?ydoEUMCIk43kRLrcj8+Ggt6gVXrWvL8ZGkEKnFhfWuHNnYyttAridXSJ8qZ2?=
 =?us-ascii?Q?PncriiMaMi4ROOJcKZaRkDLorjEAbp40Nbjq4EuoO6T0V02jyRwt3lUZGLDu?=
 =?us-ascii?Q?44qFwF+BYvDy0EDF3Kbqk7voZes+bmmyaga17PiGomtuKPThwybgbXggjDWL?=
 =?us-ascii?Q?DVnZwBw/om199iwv4V/0cbcQYdGBUbnGjf4YmsY/gapvPKh8iHJWnxCs09u0?=
 =?us-ascii?Q?lMDRidr4II4bUN2u/3BPTUrNb+t83IhHwKkqyigziVVUFFxai8mDoiLXKUWh?=
 =?us-ascii?Q?BzEItpmOhJwSwU7htypwaWf7LaTUF13vtvw+2t1LselDgi5n5GYuubSwapRd?=
 =?us-ascii?Q?EEyePJREzFdYRVsnA5PRCEPJymkbOmjcyZ7FqznX865R2iGIyupyA+vfwyo8?=
 =?us-ascii?Q?3uP6OtI884ahd3CWje+rm/31KaYUqa3olOkavxlvu6Zi2hpv+dwE+zYErC2K?=
 =?us-ascii?Q?AcEpFA4lkWeqH8gQl0MtONhnSEhRXz/ETzuhdwtiUDQ+Wc56d0bA3ObG63MX?=
 =?us-ascii?Q?woa3nB6ntf1K/XrNQlGheVw81kNC7AibR67jmMuW7Z7Rok3rd9ZFFVKSm0Bh?=
 =?us-ascii?Q?nSzOa8tkXs2gawHw17RNvPLVvJ+NuzkOfXY3MZQMoh0mE0Ej1NsdoBb7JuQm?=
 =?us-ascii?Q?snpcb78h7B59GyTiTNVP69z0qvbhrPZE7rjffyIQRXh6W01xmbLHUlhnRJow?=
 =?us-ascii?Q?lgL5Xu5eXH7fMf2v48JH+1n/mCvUGtEXE7N/2KQaL+yK1DiAecNQmxl/KLbJ?=
 =?us-ascii?Q?azrNya460xKNQ5iLJEs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c08d10-85ca-49b4-fc0e-08dd5c29d4b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:08:08.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhRtwYHhQuoynK+Frfu7QrXSG3g5gxcLpJ+/Jy0Ok42smtLm71DHE+c7WOfSmQ/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

On 5 Mar 2025, at 15:50, Hugh Dickins wrote:

> On Wed, 5 Mar 2025, Zi Yan wrote:
>> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
>>>
>>> I think (might be wrong, I'm in a rush) my mods are all to this
>>> "add two new (not yet used) functions for folio_split()" patch:
>>> please merge them in if you agree.
>>>
>>> 1. From source inspection, it looks like a folio_set_order() was missed.
>>
>> Actually no. folio_set_order(folio, new_order) is called multiple times
>> in the for loop above. It is duplicated but not missing.
>
> I was about to disagree with you, when at last I saw that, yes,
> it is doing that on "folio" at the time of setting up "new_folio".
>
> That is confusing: in all other respects, that loop is reading folio
> to set up new_folio.  Do you have a reason for doing it there?

No. I agree your fix is better. Just point out folio_set_order() should
not trigger a bug.

>
> The transient "nested folio" situation is anomalous either way.
> I'd certainly prefer it to be done at the point where you
> ClearPageCompound when !new_order; but if you think there's an issue
> with racing isolate_migratepages_block() or something like that, which
> your current placement handles better, then please add a line of comment
> both where you do it and where I expected to find it - thanks.

Sure. I will use your patch unless I find some racing issue.

>
> (Historically, there was quite a lot of difficulty in getting the order
> of events in __split_huge_page_tail() to be safe: I wonder whether we
> shall see a crop of new weird bugs from these changes. I note that your
> loops advance forwards, whereas the old ones went backwards: but I don't
> have anything to say you're wrong.  I think it's mainly a matter of how
> the first tail or two gets handled: which might be why you want to
> folio_set_order(folio, new_order) at the earliest opportunity.)

I am worried about that too. In addition, in __split_huge_page_tail(),
page refcount is restored right after new tail folio split is done,
whereas I needed to delay them until all new after-split folios
are done, since non-uniform split is iterative and only the after-split
folios NOT containing the split_at page will be released. These
folios are locked and frozen after __split_folio_to_order() like
the original folio. Maybe because there are more such locked frozen
folios than before?


>>
>>>
>>> 2. Why is swapcache only checked when folio_test_anon? I can see that
>>>    you've just copied that over from the old __split_huge_page(), but
>>>    it seems wrong to me here and there - I guess a relic from before
>>>    shmem could swap out a huge page.
>>
>> Yes, it is a relic, but it is still right before I change another relic
>> in __folio_split() or split_huge_page_to_list_to_order() from mainline,
>> if (!mapping) { ret = -EBUSY; goto out; }. It excludes the shmem in swap
>> cache case. I probably will leave it as is in my next folio_split() version
>> to avoid adding more potential bugs, but will come back later in another
>> patch.
>
> I agree.  The "Truncated ?" check.  Good.  But I do prefer that you use
> that part of my patch, referring to mapping and swap_cache instead of anon,
> rather than rely on that accident of what's done at the higher level.

Definitely.


Best Regards,
Yan, Zi

