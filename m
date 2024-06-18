Return-Path: <linux-kselftest+bounces-12169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2B90DD1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FDD1C2218E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50016EB78;
	Tue, 18 Jun 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENYMfO1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E469156F25;
	Tue, 18 Jun 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741663; cv=fail; b=gYHwk/NEVhK/FAsJqXK8TavFDkoZW7zHfBcBxN63PYmLSWb3xTEITTplCGIYdrK+RNmhmkcUhHdJ7pSilc0N2KAd3BfFvJBzpikeRJnAOVmH6wQQ9KPwrJp7ZP8HxCrEFz9VUxPScUJgjjx2jYYWcl2smQfP1dWeUgFIeeHtOCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741663; c=relaxed/simple;
	bh=9Mi2A01YJndftjBrCp8Dy3LGPcw7VGkuDcP8GWEcEJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mqeHwBJvLA9WLP+lyCF5XolBIocYdHeWIJTjNctDpEHLJ/5MI+KqNcy1BVV/3l9d8uezC6iZKcmjhJ32UTuhUvYrQpP6of3nGJYRvRhbf+EmOk7rODmnnTj6uAFv8ceWHxmaQ4b9ER7L2rkBXUy0Hyz5I3Tup7jsL8y7X8sbioE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ENYMfO1Y; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHVt8dYueFD5HnamqXrSssi2pd5vllFgslBfl03hGGyq9PUV8cla8VyTxBk7KTkbJ5gKw4NHDDGme+4J+O+XvQKl3Drenm1wqOou0AG0YDp+uXLLkHZwc/HW3Xv8IFAarBLYNCku4JeeHwl+nJ9qk+L/T/4zr5T9ostjQWEUH2T2XtotApcH7+Qgsj6NFfj7ddWfjJTBBK1fqevR8QVT1NABgjkrDGyIOWD3DEjjQClnrdjZku84S7AaIKkB05dq2XbVUfGkUZos/CIisjzuN/hLgakSsYgdSJwBuX/cAEhr+ZN4jHkopuWw2YDuRGaPcDCqbTESux4tJ5sEqWiqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANFJbhWFT9hCZ6ZWUkGbNvpfG/z/lMrP8b4fhljEpxI=;
 b=f/5mTVJjHv1s4HTXrkr2DgzpPvxDBrekHwFD6tDvTJlsNwB4Z1DSsJfjs0E3dSp5nX5L4Qsji9d6lAXkOaU05nRV2zIdmuo/Qab+abzqxYC6P8wTr10N5kNGbjMJ3HFQaYKkT58rbeTXXCnICuckkDtjruamyAiangUErCBrrFqVbbsAHvUu6Mj6ocG3l2SwdQ9AfGjm1bBoEpMkuqKw2aWIxXcy7p9RK3GgOMyFS21CYu+ks/UZHEcWYD/UFhjNFWcA6LZJwsiWC8QDym1m77ebRyqq/2AZ8aAHTBpMF15CjWioWROy2+w8ffSu4Za43VMjHJyzUm6ZM8I7tyNfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANFJbhWFT9hCZ6ZWUkGbNvpfG/z/lMrP8b4fhljEpxI=;
 b=ENYMfO1YQAzvJZbZqBH6j43VMl9iX7jm6FiV7cjg/ssq5i58EdBNoUR1ujnTM1Jh0sZW/cGAsKWBkUEmLUBllkecdUNFDenk0GEFxzMnnhCEJV45UyqQsq7R/E8lP0lPuIkB114lRQxta7oNyz1svsxb/u1o5QauTBDxkOb1mu1kEz84D9hqJQltrH1Lq4UxGIQ3Ed9JB34KUNmg3dU7VmbgSMvOgbNKyM/EgYz4yKLCYiSMbzueaBgfzIIOdTdv++f9FX/Q5JPagMO2r77d24GAEID8lDQ/DarEmtqx+e3AcDT6PYgjTX94+56r3cq9VyfrjA1/BV4EADNee9A8iQ==
Received: from DM6PR06CA0009.namprd06.prod.outlook.com (2603:10b6:5:120::22)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 20:14:19 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::21) by DM6PR06CA0009.outlook.office365.com
 (2603:10b6:5:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 20:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 20:14:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 13:14:06 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 13:14:05 -0700
Message-ID: <9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
Date: Tue, 18 Jun 2024 13:14:05 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, Shuah Khan
	<shuah@kernel.org>
CC: Andrei Vagin <avagin@google.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, Kees Cook
	<kees@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, "Liam R .
 Howlett" <Liam.Howlett@oracle.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, Rich Felker
	<dalias@libc.org>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-2-jhubbard@nvidia.com>
 <0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: e193a25b-d43f-4802-be59-08dc8fd33c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1AzWEVLaWJtbXNCWGIrK2hxeXMxUlcxaVp1U3RUTGpJbFZTQXVWTkU5Si9s?=
 =?utf-8?B?Y2dyblFsU2JaL1Zrb0toWHN0SzdXdEsrN0w4M0s3bi9pZDF2Ymw1ZXVYeFJI?=
 =?utf-8?B?dGdrYjJVcHpyazlVZDAwWG4wK0xoUnlhUFdBNml2Qi9sTFR1OE0zY0Z0MjhI?=
 =?utf-8?B?NjRKclFtcWVCQ0tqbUQ5VC9XVHBLQ3FKUExGeUlrUThESTU0cmtnU3FHZGp5?=
 =?utf-8?B?Z2hGaUtsR0xqMHpSaFA1Sm9ic0xBUzN4dHpXdDRnWFZxRHNVT0JocWRJT2pQ?=
 =?utf-8?B?cnFlL3VyR3NSbzFyek9xVXRhOTlLRGV4MDM2QjMxd3NsNDB6WnhUSjFIbEU2?=
 =?utf-8?B?MzhMb3hhbGFNdS9uNmw3QU8raVlDTU5tRXZzb0hpQUs2ejJIb3RLdVlPZkxl?=
 =?utf-8?B?VWRtMEM4ZGFvbGJGMFYwRGpjZjFvN2FNSW9GRXYwVGQ1OGFNeGJoajRpcnJz?=
 =?utf-8?B?dkNITGw4Z29kTTR4YWh0WUNmUmxQc2w2QWhxN1BKOGZZVlMwVTVMbDY2dkRw?=
 =?utf-8?B?cFN4bnR1Q2ZudFUwb2dlRXA0cmUxVHR1dHlid1J1amJaWlJzVHNxWXBLaXlO?=
 =?utf-8?B?WVV2VW5sVVFGRVZFV3h4bEpIODNWamx1SkhWNGw3RjNIMEVNTkdoKzgxSk1z?=
 =?utf-8?B?QzF3YjJWVjVwM3RNamZKNUhLR1pFTFo3cWo4Z28vekN3M2hGRk43WUw2dlJs?=
 =?utf-8?B?ekZVLzlURlNDZXhzTTNPaTJEQ0t6cUxqUFZ4R1dLSUZ2WlJoaUpINlFNcVUv?=
 =?utf-8?B?citzcVJ6R1pVOE8zOGxQYkUvSjNnZVFhZ2luYXNUandqWHpvSVdYdE84enJn?=
 =?utf-8?B?V1BraFRGS0NqeWNwK3JySElNVE85U0NyRWRLVHhZT2hIZFdYdlBWSmlEQVlK?=
 =?utf-8?B?MFIrS1NVamZqUms1R05LRDNBaGNnbGplY3pSVmF0WTN0UGpndzJQTUp6Y3ZN?=
 =?utf-8?B?TWRCclU4eDdGSGVpS0dGK0hKRTExaVoyV2ZDUjU0M2ZqVm11cFBHNWdQZmhQ?=
 =?utf-8?B?cFJBQ1JqRzZzcWJKbmVabGxzeFBWKzV1RFhmRlE1UlJxd1VyWVNGL25TTlVE?=
 =?utf-8?B?MUJaNHdVV1FzY3FQWks3Q0xoT25DUlF6cHN4NFVORk5xK0hFY2xQVDVManhB?=
 =?utf-8?B?aFQ0RTErQXpMREdTVzU2UTN6SnJuNWhHNU5sR1dRTjJFQlZFVXlkeVpTYWtS?=
 =?utf-8?B?VTAxeHlBdzI0OUxFUHBYdWtmdXBJd0xIbDVsOGdZd29FSUhwN2xmL0hVNnRH?=
 =?utf-8?B?M0s4Qm1uOW4wT0VYa1Z6enFENFBmRmtmQTExak9sdXoxTi83aUN2MXVsdW5p?=
 =?utf-8?B?ZFBoMWc1WDl2aDdxSXVUUFNHQjMzZ2pGTGcrY0RkWHZ5WGoyQmZiM1dnTWIy?=
 =?utf-8?B?bGdLODdOZWlmMWxDK25UYzZYNUorcFJyTkYyNHk0T3QwUlhjWUo5c0h6WXY3?=
 =?utf-8?B?R2k3MTFOQzhXcWtoeVZ3YzltaE16dnpidWJNSjZYQ29DYVFlaXMyTnhGTjlZ?=
 =?utf-8?B?ZDFQRXdrdFAzZGszeVBxdDkySGRIak1haitJMEcwTWR6RWQ0dkpxVXptSHhh?=
 =?utf-8?B?MVgzbE5ubW5waU44b2NBcURjL0ZybnA4SmZ0NU0zNVYrdzhOb1hjQllDRS93?=
 =?utf-8?B?d0RiYXB2OW51cFB5RGVMQTlMaGUrVG5QcUp2WmsvaUZ6U3JhdkRpSExlZHFo?=
 =?utf-8?B?S0hFdDl4T2luUndFOHE5M1NrT0MrbldiWEVTbEU3NXpRYVR2Q1ZrT1pQTG9s?=
 =?utf-8?B?QTUyc1lLNC80WkFDS1EwVTNpV1JQK1FQeHAySytFY1E3SVl1Q1h2eTdGL094?=
 =?utf-8?B?WEFieThrQ0QyUzBmSUoreXAyVndTVHBwL2JsQWg1ZktKWTlEbG5ORUpkM1JO?=
 =?utf-8?B?dlFBUGF4OXpGSGFwT2pEa1BSTmVISG8reVNlWmhwbkFlTnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:14:19.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e193a25b-d43f-4802-be59-08dc8fd33c3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

On 6/17/24 11:56 PM, David Hildenbrand wrote:
> On 18.06.24 04:24, John Hubbard wrote:
...
>> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
>> index f2babec79bb6..27bf2f84231d 100644
>> --- a/tools/testing/selftests/mm/seal_elf.c
>> +++ b/tools/testing/selftests/mm/seal_elf.c
>> @@ -2,7 +2,7 @@
>>   #define _GNU_SOURCE
>>   #include <sys/mman.h>
>>   #include <stdint.h>
>> -#include <unistd.h>
>> +#include <asm-generic/unistd.h>
>>   #include <string.h>
>>   #include <sys/time.h>
>>   #include <sys/resource.h>
> 
> Still confused. Let's take a look at "microblaze".
> 
> arch/microblaze/include/asm/unistd.h
>   -> #include <uapi/asm/unistd.h>
> 
> arch/microblaze/include/uapi/asm/unistd.h
>   -> #include <asm/unistd_32.h>
>    -> Generated during "make headers"
> 
> usr/include/asm/unistd_32.h is generated via
> arch/microblaze/kernel/syscalls/Makefile with the syshdr command.
> 
> So we never end up including asm-generic/unistd.h directly on microblaze, but rather converts it (IIUC) to something else.
>

Yes.
  
> That will work as expected here?
> 

No. :)

The problem, and the source of confusion here, is that for most user
space programs, the header file inclusion behaves as you've mentioned
above. However, those programs are installed on a single computer that
has a single set of asm and kernel headers installed.

We are quite special here, because we are building a set of user space
programs that:

     a) Mostly avoids using the installed (distro) system header files.

     b) Must build (and run) on all supported CPU architectures

     c) Must occasionally use symbols that have so new that they have not
        yet been included in the distro's header files.

Doing (a) creates a new problem: how to get a set of cross-platform
headers that works in all cases.

Fortunately, asm-generic headers solve that one. Which is why we need to
use them here.

The reason this hasn't really come up yet, is that until now, the
kselftests requirement (which I'm trying to remove) was that "make
headers" must first be run. That allowed the selftests to get a snapshot
of sufficiently new header files that looked just like (and conflict
with) the installed system headers.

I can update the commit description with some of the above, if it helps.

thanks,
-- 
John Hubbard
NVIDIA


