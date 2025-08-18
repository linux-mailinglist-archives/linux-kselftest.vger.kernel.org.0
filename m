Return-Path: <linux-kselftest+bounces-39228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7AB2ABAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052455A21C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E835A297;
	Mon, 18 Aug 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b57NoXVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3A35A288;
	Mon, 18 Aug 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528266; cv=fail; b=N03qaa/zPKmI6JnJ0XqUTaCgxwyPfpN2qQCktbVx+6fuga+Lx0lyNtFU/oiAbWnUDmobVESI/hqwpi32GZKLDPpAiOCJmU1TxxdYuaRbnaaCxHpzUpXHqlz8rTo/zYuhkkZ0xbZJv8LNY28iCRnfGuIfD9fMB3+ZfgUt3ZeN9B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528266; c=relaxed/simple;
	bh=HRSRvopB9QPISRItWkClljBm8fdsdxLy8cQuqR2N/9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCiBAOM/ir4ezXWHWxMi7+snz9j7jQSQjc1+Gb1/fKbkOfMxdeI42476lk5MJHZSUUp2g/ZsfIDf/aP8zrE3d6YE3alGTNa+qGotroHvkpul1o1mzUi9s8sbbuaIj9JyojPDHZsVBzhga7sb6vkMPIPwOui9EqzsN7w8ontQtnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b57NoXVC; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5XDPRfi7jziRBnSnKQjtiFAMg+IT7zN9urWDphQywe9KNkwzryaNK0gLmGiqLxmmIu6yiUFp1jgYu6I7UaEjk5OGAQlfepbzW8EeUQdeWuQqrw9W9D+R9vKpYtDwIk4mLz3uQ9l6vJ84RE8yInLZqjn6wsV6Y+IzR67mpdCXyG41Ooo09YfcxQJ04kw3fpDvmDz0J0Dm+YKPg4vVt8YqjK9D8u58E9Djjgj9S8wO36TSNOdqe56yqa7RDe9lDb22QwayF2ElCsFZsHVA8CLiCBpvi2Gj4NrIQRaP0KJe0mlIxEVbg3JlPXNW3z/JAymfGBrXG/hmHKrrxq1ovg9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeEr9urFS6kZ5lWwhYxZRHHzVVikAGvIEaGZA7PEyRs=;
 b=BP6P05p9DKjE0oFqZAP1+PBhYHHNTb4CdMdqWNNcRenfUSkgo9P7Gpo82XuWIEvdjc5E+/rEkfN2MDtolHjn010vaQX9E58HZsccbyeVbkcGFhQulokYHqxADi5XjP5NVdyijppD8ghFelnp9D0uJtI6DkXfm2xCbVqpshdy4OCOk6FESTSNobcRFGs6HMTBoMP/vTcPhyvh4qeXok0xGMisg2PKXIraJKFrrxASP4MBGFCgHLd52BJpLjMSxB5bubCFPcy4PrqA9wUmCGgS5MJR7Ez7lNyNFEuAzzIjje2VlejEDjASoM9MceH6UFRfu9ucYVdXuYv+pnoguj+dmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeEr9urFS6kZ5lWwhYxZRHHzVVikAGvIEaGZA7PEyRs=;
 b=b57NoXVCzXqkOHHdSambRtIy037nbvWMomHXA9vpoilaGrFMVn1YaZPzZVt0iSBtFctzMhhhyTnfRomqIrtgajKM9aDaqmtWDjSfbA5zf7MONjGnOUNiRAWWIwSb0A44jBT+XYPIfCfJvhTsHNFhKemHj0U5gNDpn1RcH+rZ+g5F+7cfMJKxORo0oZJfsIQ7d6zmEGZ2IOQmINzo0Er+EpjSep9yFgazm12mW7QGUK6mPDC+oVe+xkyjfKJ9wvyRUMREMK68hhTPnBwPMZiPPehh2gFshoZRUC7uR4RrId585MEhR6coBSs5iJg6JyhFpZHIJ5USNyJB38Z1S/W+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 14:44:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 14:44:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Date: Mon, 18 Aug 2025 10:44:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <02BE8434-25B0-4FD6-B1DD-0156FD5DCA1C@nvidia.com>
In-Reply-To: <c31e9dfd-019a-4d54-8237-8c3501c730a7@redhat.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-4-ziy@nvidia.com>
 <c31e9dfd-019a-4d54-8237-8c3501c730a7@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0693.namprd03.prod.outlook.com
 (2603:10b6:408:ef::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: b96eaeda-f6b2-4425-944e-08ddde65b7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwbvQJs0rMfvvnLFTaRWtuhW7lzqeG0YtAq111QCDvF7E6cR/2rkBBo/0ln9?=
 =?us-ascii?Q?qIHhTLpHUYSM/m3RUwKPWIP9uOzE5gVnfgGKPzOy46yIxwz0E+isWI4zCr+Z?=
 =?us-ascii?Q?da43+hstryivtnd+vFsMstKBUYVy9C2wX4Id4TzQowQGQNT5auViGYt9RTBc?=
 =?us-ascii?Q?1rsylByQAIQr2BoF5JxjtOdxsqVzODlCujiu3Sq/alNibeh6Lcn07UkfMmRM?=
 =?us-ascii?Q?JIIJArb+NiX+pvW3E3amZPuvOKU60xdT1mCYXYIoX0Krc9YVseU4GZqQmD0B?=
 =?us-ascii?Q?J/vNFw7a0OfkAbZDcAwkIIuqWF1x47P1bSaTQK4PS7Tejp8anj1szKOna1su?=
 =?us-ascii?Q?g4iDobm2aGKb2YpDEAMcH+KsbcWzRcd+pIDR/33JNKtaf8h4TZLi6UL/xdW+?=
 =?us-ascii?Q?DIBMcd3oVrdUWUEEO5bCMiaDR61x8ofBD5g5ZrdwhESKSQet2ZvmQu8Vd3sQ?=
 =?us-ascii?Q?vQeO34aq8lxkXk6S3gHCK0KcMG4qiUvtfRJF1XGP87eKaJ7CTufp+sO+5q5/?=
 =?us-ascii?Q?vysf39JYLWIzPdb2SScYIj6B2ey46z27eePDcqZY6LfNznmqMyJxffeU+fSB?=
 =?us-ascii?Q?21+xHQflEytopWR+V+F2MeNgFODrC8WHEIR8521ANi7E0+W/GQRakYno1iVL?=
 =?us-ascii?Q?qmYYyUPRPtDAv0FY2SbhSoR82g8kWEkiRiNNZkW1LDoJFOau/yEwwJMv8gjW?=
 =?us-ascii?Q?Cd6GL0rv9qtwv1wtOljw1UQ2Sij5QLPmNZ4/6qAL1watsdRAhzgJW0vlsi/u?=
 =?us-ascii?Q?7AXj21eg4AuJfMxKcYcNR46LRn7jYF3Yhg9IZFKF6WE9HgOjLh7c1TyI4mDG?=
 =?us-ascii?Q?aDBVSkUybvRjpFZWqAcUBB0YJrI5iJmrAni26l4UsP7v2+fh8xjm0K/V6R2n?=
 =?us-ascii?Q?sZNp2bFu95F2NQpK9kSzxO7O5Lnl0n4HcaDwbPOL0biNo1uyKpnuBu50EMuk?=
 =?us-ascii?Q?WDe1v/bj+Yh17iySZ1rgfA+R++kpWVU65J2lTKVRfHA/5ZdxLvB2PeMTQULV?=
 =?us-ascii?Q?dLGbYYI943kYOBti7UqDB0R921LQENdIiG4riWIn0bep+cBJ51DkCV/wG+wk?=
 =?us-ascii?Q?Qog4vLkMTlZD1y0vojG7562BiBh8Rs+9giFyFzL7L2xlJFCzc/BL4Jdaatq6?=
 =?us-ascii?Q?FAvCpkC+eKuHJafeDsVR4modRtCCMhfbZjLgfTBkjo6TrA4eKT8O6JQDvGId?=
 =?us-ascii?Q?CDBTSTjlTZJApuBCkxX6wkM+8TqOlWDrUOjdG2C2cYVi5kmTYMkRlElerWEi?=
 =?us-ascii?Q?rMxzc42VHIVF+156e8uUVLFMcQKWkH1gECi+cODjMMZC+z7sZm5VVeLMmcPI?=
 =?us-ascii?Q?N5SLiLZKDBghc2KHZHtwW+KQbX5lserF2JpZW3SO+KhEUJ7uwr6EAC/zLrrm?=
 =?us-ascii?Q?akmPw6CKts2IIHZg/Te95ynIvb3cJ2I6NjeoWhmtBGyEb7JCeiVl3Hh/RDBp?=
 =?us-ascii?Q?jOCMXI5YntQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7w+tlH5to4hqstoKbcMZMQ0BV7uFqy1gvttGWlOsa4ZijITiSLHY6o1A6MjM?=
 =?us-ascii?Q?M2lVpk4igPZw8sTT6CWrnKnQoYr9vHCVz7/e/JZtvVrwIVuC8B+XQ+nraBY/?=
 =?us-ascii?Q?t4Z/dmpjjayKqeT+5garB2ucM7l+688KKgT1j4OJc19KZ21rrHD0nT9VVni5?=
 =?us-ascii?Q?1Jl1TFRt5rqRcm8qfmtiguHUu3VWdOMzcw6ASYGgRpHkx50tMtAxJRemswjU?=
 =?us-ascii?Q?yfB+tKN/fyQelCTLjy/iQtmSNC1BoA+Zxi8JFIuka2f8N9laoKy67oeyzJDk?=
 =?us-ascii?Q?HlF9MczcMtpX5a90vNNC8kUzgdVb3mlNndH33ncmwfWNaTAAuk0NnizRG0Y4?=
 =?us-ascii?Q?No86Dmmq72vi6BgD+ZQ5Qub+dUDfX26VZhha8yx5aEhcHave29JUBw9qtdSO?=
 =?us-ascii?Q?+xqDKXhynYAyIAMwTLaWaBQ1nxr3bp3Xs1EkPglVq6+WJTSzp+wMaRp0U03x?=
 =?us-ascii?Q?U2/imK6PkottYkf9THfSG07oO2ukA/DPnauuHsi5fATEg8cWavz/rQjxNJwZ?=
 =?us-ascii?Q?xPn/pbFfiJQpJvbiO14m0T5aWmp4iP4MQcOvEEv5aLgxwvc6j5mLQr7hUgd7?=
 =?us-ascii?Q?8aTl5gr3Rkz4qhFFAHp/oKSBqVBLBc1BlBVGFoXskSOjVSfwUWBePxKXeAcz?=
 =?us-ascii?Q?8zUzdg4+uGf0kD2YY59tbshDrN1YeTweIpHy4R2TzhJrxc8Z5UngpQU1bzwg?=
 =?us-ascii?Q?ZKm1Xvk6Yf9uBtZvfwfbFvc1waZjW3LTmptktHukxXOZHSWtbL4p5ExUyAn8?=
 =?us-ascii?Q?l9zXlBZrZap0LjEr7TEaxzNGYhwif5CgEmOmnaa1iZiF+5XecGgy9Xy74UR1?=
 =?us-ascii?Q?7bNsOgadytHrtz6HofuUXrZt1XgO5uxV/JvRtGKkQAAjki5LJKE6zVt9pm2Q?=
 =?us-ascii?Q?cCWvecXSrKR/+Ha6xheraLdiNYwUREqtfsBtdF/+4b2KsVAv+aMCrm6hPdCa?=
 =?us-ascii?Q?7z2ol+tEPb7yysqpABrSwd9dIxCdH5kUv/19YCOZjPJJhmg1mIg2AedeYvAn?=
 =?us-ascii?Q?Bvp6SLQsBrJOup3WncQtNNFEJbjL9RUB8jixFGJSIPWy8fZ6kzEIykTNMIiI?=
 =?us-ascii?Q?PKpYxX012qJixpbLAZHEY6P31SsWyUZTcwTx/ag5Hin6oGgeMK0gUTe1j9A5?=
 =?us-ascii?Q?2sNQ2Tmi3eb45rEgH6ofyfnSzQTmBDDTRPjFkXsiDNSBN/t1tuyJTf3xpqzG?=
 =?us-ascii?Q?AnaF9IcuVBVgqkAuPH2m7YoADh8eLdzSjLf5Gztzwd7z2VewNEQlqxMqtiiP?=
 =?us-ascii?Q?vIxfsjFl1HhjxXnCmHLiDHl0TgSNdGg1ci5GvRqoxyUIV+z5V/F2ufp/gMlr?=
 =?us-ascii?Q?h+AVb11xPTE1hQWFtG2DyyMKYq5azjQKvZqaz5ld5MmNtv8M6IDDRFpkOfzH?=
 =?us-ascii?Q?xpd+glVLL/sPe+yqfx2VHiHduQdK7kAc3St+HSKVZjC5q3fCxCVaj2KjGSV1?=
 =?us-ascii?Q?bQ2RNI3FN/cAHxj4A8I5oIGtT08w8g73XDwLuwbMvxfBWEWrMnz10UrDdKUx?=
 =?us-ascii?Q?PY0HJtkmVBE1AH0uyDBBAmxPReNP3TPeiJVLAhAOKweEIUFZskERPZ5Hj1SV?=
 =?us-ascii?Q?GHzigEKsVuRWS8giip44stma4ArkyIXsHdDwZ/3E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96eaeda-f6b2-4425-944e-08ddde65b7d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:44:21.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1swv49ziBXoXKjirrTeTPzqMg0Go8OT+ykrSpHclG5BCTMFM+SGwTND091IJf2ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

On 18 Aug 2025, at 4:33, David Hildenbrand wrote:

> On 15.08.25 04:39, Zi Yan wrote:
>> and rename it to is_backed_by_folio().
>>
>> is_backed_by_folio() checks if the given vaddr is backed a folio with
>> a given order. It does so by:
>> 1. getting the pfn of the vaddr;
>> 2. checking kpageflags of the pfn;
>>
>> if order is greater than 0:
>> 3. checking kpageflags of the head pfn;
>> 4. checking kpageflags of all tail pfns.
>>
>> pmd_order is added to split_huge_page_test.c and replaces max_order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       | 90 ++++++++++++++---=
--
>>   tools/testing/selftests/mm/vm_util.c          | 13 +++
>>   tools/testing/selftests/mm/vm_util.h          |  4 +
>>   3 files changed, 84 insertions(+), 23 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 89d3dc08fe4c..80f718ca21c7 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -25,6 +25,7 @@
>>   uint64_t pagesize;
>>   unsigned int pageshift;
>>   uint64_t pmd_pagesize;
>> +unsigned int pmd_order;
>>    #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>>   #define SMAP_PATH "/proc/self/smaps"
>> @@ -34,27 +35,71 @@ uint64_t pmd_pagesize;
>>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>>  -#define PFN_MASK     ((1UL<<55)-1)
>> -#define KPF_THP      (1UL<<22)
>>   #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>  -static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpage=
flags_file)
>> +static int is_backed_by_folio(char *vaddr, int order, int pagemap_fd,=

>> +		int kpageflags_fd)
>
> Could we convert this into a bool and simply return "false" on error in=
stead of "-"? These tristate returns for a "is_*" function are a bit unfo=
rtunate.

OK.

>
>>   {
>> -	uint64_t paddr;
>> -	uint64_t page_flags;
>> +	unsigned long pfn_head;
>> +	uint64_t pfn_flags;
>> +	unsigned long pfn;
>> +	unsigned long i;
>>  -	if (pagemap_file) {
>> -		pread(pagemap_file, &paddr, sizeof(paddr),
>> -			((long)vaddr >> pageshift) * sizeof(paddr));
>> +	if (pagemap_fd =3D=3D -1 || kpageflags_fd =3D=3D -1)
>> +		goto fail;
>
> Should we rather expect that callers make sure these are valid? In part=
icular, because split_pte_mapped_thp() seems to ksft_exit_fail_msg() alre=
ady.

Sure.

>
>>  -		if (kpageflags_file) {
>> -			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>> -				(paddr & PFN_MASK) * sizeof(page_flags));
>> +	pfn =3D pagemap_get_pfn(pagemap_fd, vaddr);
>
> Hm, if it's swapped out we would get intermittent errors, but that just=
 seems hard to avoid. The caller could mock to avoid swapout.
>
> Memory migration is another possible problem ...
>
> But this is nothing new regarding your patch, so no need to worry for n=
ow.

Right. The function is only used by PTE-mapped THP split and I assume swa=
pping
and migration would not happen. If this function is used more broadly, it=

will need to take care of cases.

>
> [...]
>
>>  +int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *fl=
ags)
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
>
> I would have called this function "pageflags_get()" to resemble "pagema=
p_get"

OK. Will rename it.

Thanks.

--
Best Regards,
Yan, Zi

