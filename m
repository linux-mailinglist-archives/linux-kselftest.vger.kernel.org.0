Return-Path: <linux-kselftest+bounces-12109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31BC90C1A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 03:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FC1F22C45
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F817740;
	Tue, 18 Jun 2024 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKbFDW+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2717550;
	Tue, 18 Jun 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675554; cv=fail; b=Eukcaz9vUTgmiYFdgXOj7MncuNyUl+clH8oLI5gj3AmmPRLi63xUI5RBkr53VW5TGZOWwS+D3ouKjMVT10ewfCP2vqCGByQyuuzMuquC49VxqZ0/yvTQ9kfeAMl2dEDJBzyckwEolsc+2KrZ3hH1S8oDn6QZm4ao2kHGk3OOA2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675554; c=relaxed/simple;
	bh=7QWDMj+YpOAgsKlk41VDWFOt2Lh1AgQxqPdxB71dlAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rWVv9radlgjnsPf5u1JBjBmNstpq4rDivY/KswLfX89HI9d58yGykwett6AfaMDyIZhiCzzQj0AZnQ2Y7ruttQez2SEGhZmnBPpjoYm8wQD7HNKMgzjZh+IFyXSTxLzdnwSqwPM13uzb8XKbjyKtF9GTe4ZnVCaAAeZh0hVVYcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKbFDW+k; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3Qo0x8RIJzrduBNM3su//iS1O720mKHAtmaOw2UXyMsPeCxdWJbFo0xLf2vYUmy5vkafJlduMiEtUzGr8v1BNN/OutZhLEbPbWs7QNuT7Pu3jt9Yyk/pc2LcpDiu158ECH3DSf5xCgbUU+8S29uarO5mlZ5FFmpk7cMIJgZjtt3MTzTOLPcBTEFn4dzefxw9Y0bdcAG2tQOBObaMXnXkza2DI7z77bnYt60yRJo+z6W/vi90sN5lGbrTFhg9+42MgLj0yLf8xJZ4kNHJw4Y4nxp/g3Cz0IEQRNLp+WYylojAa6571sBlFLdXqhoEJl0l1RaGWiJssRmjXEEcK8sFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n2tG9hn23PyDCM7ELNIvQSYRBR+ymHJoyigc4JIJMU=;
 b=HHYfc4WTgSx2HEhbyygSvVtU51OL/ABwA2k09whWpBBr5u85bxb8Q/2lEMt26VQ1GzepxgqVnBOxl4YDaK9ALxKxBlnH+bb2YwSSeYWtGl/8Ee7d/cT3Vt/yQGcEEyn1F8SADEoCNbPKxONOg05t94D+JBbNdssm6nn3nsmxOsuy0ivXS9tIGn7WJqP74BKTKwtNrejlqJ9l8dWM0xDjcSn5oVXBj1LRboJZEpN8zazif370DYx7AJJl/qmJkZdUxZkP28zQHC+OuVti7qhc3/+XxtwKQLxLSGEWd1WN0XKvKk7S2G5vNsC657u2lgjLlJFe+XZDUTmaVHGdR+fjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n2tG9hn23PyDCM7ELNIvQSYRBR+ymHJoyigc4JIJMU=;
 b=EKbFDW+kaR7eJipu3I4H0pZ9EKX9L56YqIl+d/rAKkn2ZoOtC/3mZstmvijh98d48o62kSqJbWr5qyx55JIpFYlJWtwWTa6XWExrx2Fqqwz8wDwPSkeokVoQYCg0jFmKzLSfaZqK3ghoyns5Tfo3PXzdt6s4AwajvtvKNnf125udw1JL+etwsVW6svL+KfT7mU/ycqwlSV/P0mbxndeI8voeRYlDN+fHMKd9HICWOcyDa59MhGaRZWzyHs63RCdVwybYmertrrmcaXfXMEx4CszU4DzbJjNEI9n/NRn88GZZvooh2tWJNZ+FsXPsLtvmQIfFzwzMcZ2LCx6GrWHrlA==
Received: from CH2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:20::37)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 01:52:30 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::b3) by CH2PR07CA0024.outlook.office365.com
 (2603:10b6:610:20::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 01:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 01:52:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 18:52:16 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 18:52:15 -0700
Message-ID: <766a0820-b62e-4b2d-be56-44ff479f962d@nvidia.com>
Date: Mon, 17 Jun 2024 18:52:15 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] selftests/mm: mseal, self_elf: fix missing
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
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-2-jhubbard@nvidia.com>
 <1ea35568-bfe5-430e-9f4b-edef17f0b22b@redhat.com>
 <e6378446-6087-4ffc-9ce9-320c5e128bd6@redhat.com>
 <9f3d50b9-6acf-4bab-b6ff-cd524ad0a2c8@nvidia.com>
 <984d4e18-5e85-4751-b101-8bc7c559f440@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <984d4e18-5e85-4751-b101-8bc7c559f440@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c724bb-ab07-4201-d32b-08dc8f395006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejYyQ2ZrbzhhWThRTnE2YThIS080SE8wd1NXdXJndWFTQjBpQmVLTnNvMVEv?=
 =?utf-8?B?dFlmSy8zSkFSaG5ETlVRMGNCU2NVT0JVOEU4VG4zNVNTMm92STNnZy9vNGll?=
 =?utf-8?B?Rm1OaThobmZ0VzRZbkJpQzFlYlRPTVF6YnBMaWVmNjFZOW1zNWZhTGx3aGxZ?=
 =?utf-8?B?UFNtSjhya2NLbE4wL29nUEJLalhxc0FKa0FpNWJTZUtVRjZPbmk5b1NDL2Fr?=
 =?utf-8?B?MklQRzZaOVRKQ0x3RTdsMzRJdFVyVEEyeFlsRGMzS1pRYUNnVGQwUU1aQlNy?=
 =?utf-8?B?blNreDQzUnFWbVdiUUJUUk1ZM3pWS2pwWHJWaFNaZzZBMSs1Qmd6cVRPR1Y3?=
 =?utf-8?B?bE1BblUybEhVQjZwZ0pmTUJvSFM4Q1R5akh1UnFwWWxHL253OEQvM2VNaHE2?=
 =?utf-8?B?U0RqMG9zSVU1MzVOVUZiSHVEZHAwWGhvUnUwYWFkbm9ndEc4VU5rOVdDb2p2?=
 =?utf-8?B?dW5LSWFjZnJvS0dLdUZ2Vk81Y3phaTJpQ0VqZTM5N1lzRHdBdWJENXBQN3hz?=
 =?utf-8?B?VmdkSDJIdE82ZTRGQWtqZTI3TVlWdjVsYzZ5My9iK2hpQks2SGJlRU9IS0lq?=
 =?utf-8?B?RGFIQzZEM1B3RzhraDJnR3RiRThKN01jYjRBQldvakpwRGUxRXFwS2NpSDMr?=
 =?utf-8?B?UktYTWVjQ1JkeTlBbDNDYkNINlZQc3k4SEVCUG9nVFNEWG95UUFyVDFQUTFB?=
 =?utf-8?B?Qlo4VkhBOEJhNkVIYUJmemlyZEw0WEtadGVNMFBHRkhKR0VLOE1oblBqSHdj?=
 =?utf-8?B?VUlKRFNwU1ZjV0NZUThVWnNUSGkzajloODZ4Unhidmt1cWFIZ09Jb04yUXd5?=
 =?utf-8?B?QjZrTnlsd2I3elZMRkpET3hBUVVhQUUrampaMmdMc0ZQYlBqZjdQdXlSdVNx?=
 =?utf-8?B?VW9oWkxLR1lINmQ1WWYwaXE5c2xSeUxKMUhUSXh1c0dBZEsxOWMxN1dmMURD?=
 =?utf-8?B?dytVUHNGV05RUTd0M2pSbi9kaEdkdmgvR2QvK0N5SHR2MHNvMUNQcTBER2sr?=
 =?utf-8?B?S2QrblRXaFd0Zk5CMWRmRWRMMnlDajJscmdaVENFc3lhcFo1RFFoSCszVWVJ?=
 =?utf-8?B?ZElXSCtjVzQvaGg1WHdLN1ViRURWQ0RISzFBZlRaV2oxWTNzMUtNdE4wQXk2?=
 =?utf-8?B?eDdQMEFQZk0rNXVDalRKZmlBVTAyMGJ1V2NXVS8wRTErVWE3Mno2bjl5OEl2?=
 =?utf-8?B?OTZVZUlKZFMzeTBkcVZ5THZFOWZiazI4OWJKcC84N3pRczR6MUpLSmFmMklp?=
 =?utf-8?B?djNwSVdHT0FvbjkwUDloNjE0MWl6ZDljZjNwck0xK0dQMXpVSVdxaThvM0ow?=
 =?utf-8?B?RXlRL0VZeDFzMDd0T3BSb0NFMWdtZVY0cXo0UHlGdFNPUkRid1d1UnVTMlNI?=
 =?utf-8?B?SWIwS3R1amR5bjMyUDhiVVVFbEV5N0prNVdmcmxQVVkyVlM1RzBsMGplTDBZ?=
 =?utf-8?B?QldIeWhqQUVHQUdDTm9CdVdEeFN5OWdsa0JOUitwMEZzYUFJdGVRUTUrYmxm?=
 =?utf-8?B?NVZqVXNFNmkrNTV3SHhhMWdYRTdNSUJqUFJGL1pRRFVBTWJQMXA3ZjljbnZR?=
 =?utf-8?B?SWRSd3ZMN3lNcWxXODV1OUVGMTlwajQrQ2MxQ1VRdWlSVXJRTmZzWU56Rjhy?=
 =?utf-8?B?eEJJTEtXbk1pQnkrMWh4UVJ2Qk95T0xkS015MUMzMnV3RXhnWmV3MzRUckMx?=
 =?utf-8?B?N0R5ZXNjV0x5UWdkRDRoUE94TkcrQlk5QXlYMElqcnlaa2c1Vm5OZHAzek1S?=
 =?utf-8?B?N00zT1JHdWpMUUdKNHhGT1NFSlpFUnZzejNCdjd0YW5iUGJaVHdhQXR6SHdC?=
 =?utf-8?B?V0s2TFY1THcvcGlIZk9qZG42VVllbW5OQitTUHFKeGN2WThBNkxIc1ZxMSt0?=
 =?utf-8?B?Y0ozaTNINnVVQ3B4UlVXQnVhRS82clg1WHVyMXowNDdwclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 01:52:29.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c724bb-ab07-4201-d32b-08dc8f395006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832

On 6/17/24 11:11 AM, David Hildenbrand wrote:
> On 14.06.24 20:02, John Hubbard wrote:
>> On 6/14/24 5:41 AM, David Hildenbrand wrote:
>>> On 14.06.24 14:28, David Hildenbrand wrote:
>>>> On 14.06.24 04:30, John Hubbard wrote:
...
>>> ... thinking again, are some of these headers arch-specific (IOW,
>>> generating them per-arch would result in something slightly different)?
>>
>> Oh wow, yes they are. I'm guilty of x86-centric thinking (again).
>>
>> hmm, this is going to make it really a lot of trouble to do this
>> approach. But there's no point in turning back now, so I guess I'd
>> better fire up the cross-compilers and generate for all the arches.
>>
> 
> Cross compilers might not be required.
> 
> At least for me, at simple
> 
> rm -rf usr/include
> export ARCH=s390
> make headers
> make headers_install
> 
> Installed the proper s390 headers, and "usr/include/asm" would contain the s390 specifics.

Yes.

> 
> Some scripting would be required to make this much easier to generate+wire up for all archs semi-automatically.

After exploring this, and eventually re-inventing the concept of asm-generic,
I now understand What To Do.
  
>>>
>>> In tools/include/uapi/asm-generic/unistd.h, we already do have
>>> __NR_mseal ...
>>
>> Yes, but it doesn't get used in selftests/mm, with the way headers are
>> set up right now.
> 
> Right
> 

...it turns out that the right answer is to simply include asm-generic/unistd.h.
That is the only way to safely use system call numbers across CPU architectures,
and we already have it. So the entire patch simplifies back down to two lines
of diff:

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 41998cf1dcf5..58c888529f42 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -3,7 +3,7 @@
  #include <linux/mman.h>
  #include <sys/mman.h>
  #include <stdint.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
  #include <string.h>
  #include <sys/time.h>
  #include <sys/resource.h>
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index f2babec79bb6..27bf2f84231d 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -2,7 +2,7 @@
  #define _GNU_SOURCE
  #include <sys/mman.h>
  #include <stdint.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
  #include <string.h>
  #include <sys/time.h>
  #include <sys/resource.h>


Which is a little embarrassing, after all this churn, but it's not always
clear how these headers are meant to be used, at first. Now it's clear.
I think. :)

I'll post a v3 shortly

thanks,
-- 
John Hubbard
NVIDIA


