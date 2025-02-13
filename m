Return-Path: <linux-kselftest+bounces-26589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F2A34FE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944F91890B8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5720766C;
	Thu, 13 Feb 2025 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1iIQcau"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297912222D4;
	Thu, 13 Feb 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479663; cv=fail; b=EJsVKrEvCm67aP9znV1k7a7mnvX2JwA5cR/BrSxwmaFx17WbNaKhAsY3AVTDOCCr76k74pMuOlHhIvAQksIWrwPUD761ftdQVQ/6KFotCfRpmjbAaJePpUmYkQCMXA/oNgF19KfHlGBhV776eRuX5H1Q0M6CXeO9Xf8gd/+LnVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479663; c=relaxed/simple;
	bh=bBv/cHJoWP30EeIo3Bfq/0+joOKT/muTuW4K2Rodfdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ffjbVPnJIo5ZHRpY63L48air0fdFdLcQnnM8Df+vxHWlz9GUSB2vgXqVJk1jv+yT/1p1Mxa4A2PbqakVxAb08Bs3aPPqdDicsKv/0n6KXdNY0FzFWwlVDXlmH+wqgDr+S/mCCd46nDJzC82524xhgGIRseCRbquy6ZazK8ziK28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1iIQcau; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saM+HHQBoLltppBWq4Jg8Fh9AcwIZu3NMkI8KvT7qffXNxLhjDBygMm9hhsmB8kDvdR7aCXX+kFC+jbAb8TNNzPZLAcZotcwEDCLlv0dLYAnKbEsCofEaCFvex/bKSvwIg0nXRAvVKOUoxQmvZGbD3wEVPpzTGPlc+ULxt3byaA3EuAfd68phn6YGh5DDA6gmu9eOXqHUES/D0gvEEj8+HGCCePaP2w/s4NkyxyXjF4tT+YLNSDG9mHE56OTmqsUiAR5WQd7BU+ZmzUNRgcz0tWw2eGB9NWk0jccMsTJw8F1C3zUJRhb+wGOCh26L+MvV4sFbkXXBmGmbyY5SY/cAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHqB7Db86HzeGpGgd+sEDolcgHdCq2uqF5v4s5Y2x8c=;
 b=qN63Jvmo08jjAHKWIoWJfDJ+O+NxZwOU9ze9wK4+pYgj0edRhUfeewHNSFWXb6XH/mxrzKB20NxzbjoJwQcbo6riiMgYJ0KaAwKGeFMEqEwafWLZ9WCvJNDTiJ3yV/SeLM1dypUC7qTBY1htn7ePbE86nwQvnP8UNa9gAUWjinWuLRvK8Dwf1uSG2anB1tCaSk4JwNJ/3tNqH1t8iGRZVTiJCrx+KpLYR0fnCSCeejvlxGGkbyeezstx9KvbaszEvniQEBsITFBIGtvcpIjDaGMExLKhWyHXgBQEuN2ZcNVYzSCH9iOexCmlfrqV3hT6WqSZO6RKwtp7esAHo6Aznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHqB7Db86HzeGpGgd+sEDolcgHdCq2uqF5v4s5Y2x8c=;
 b=K1iIQcauTvDj7ADDp0IvudpZH+XJKX8HmqaaECGUltBBsiVcurc7qR9usfchR/CUTHjYvoQnbm9HRN4464beameoPld6BxRSm3S71UC3g2498ngknm5TklNp/+ZMjRO+CB4qtYTDRRvO4LJvzO/Ki0/Y42l7p377HcCW+dyGpdFkjlMqH3Q+JZnwzSyBgY24gWmvEiNwkgr40S4Vebst89zCgO6EwmBeoIjzt5LffAqngqvIgi6hLvxqV0T0u5sanRNt0+8KUFOCm2P9d/Dqz83DTrHjBHaNZ/E7g3SCnwoUQrvQrGJpJN4FdafiwDouGDpDcv/SqpBcXpEpPoExcQ==
Received: from BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::28)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 13 Feb
 2025 20:47:38 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::26) by BLAP220CA0023.outlook.office365.com
 (2603:10b6:208:32c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 20:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 20:47:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 12:47:21 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 12:47:20 -0800
Message-ID: <f2d3c4c4-0d5a-418b-9da0-f6f64f2c60ee@nvidia.com>
Date: Thu, 13 Feb 2025 12:47:20 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] selftests/mm: remove local __NR_* definitions
To: Li Wang <liwang@redhat.com>, Nico Pache <npache@redhat.com>
CC: Dave Hansen <dave.hansen@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, Shuah Khan
	<shuah@kernel.org>, Andrei Vagin <avagin@google.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, Kees Cook <kees@kernel.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu
	<peterx@redhat.com>, Rich Felker <dalias@libc.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-7-jhubbard@nvidia.com>
 <dc585017-6740-4cab-a536-b12b37a7582d@intel.com>
 <12502c05-be51-4c9d-9cb7-5a40ba1fe307@nvidia.com>
 <CAEemH2eW=UMu9+turT2jRie7+6ewUazXmA6kL+VBo3cGDGU6RA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAEemH2eW=UMu9+turT2jRie7+6ewUazXmA6kL+VBo3cGDGU6RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5ec42b-545d-4a8a-094b-08dd4c6fa705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0hpV2Z0WlQ4WFZsRWJ6UkxteklXWlFCcEZhUmFKU21tUWhYd0JJS1Z1OWZ5?=
 =?utf-8?B?NFJ5cm5iQVFSVUR1WDdDaHdzWTdaczlMU3VTcmNOeXltSmZNWDM2TlNrbk53?=
 =?utf-8?B?ZjI2NjVHTkRoTHdWaWh2RGswR0xXOWpDaUV6SkRtTEg0OWZKRXhKamluRjRV?=
 =?utf-8?B?SWxWR0xpR0R3ZCtTNDhpQi9LUlMxMWtDREtLMDZpQ21GcEpxQVNTS3dqTUJQ?=
 =?utf-8?B?TERON1dmU3RoQW1wSEdNVVNrL0w1ZVFaQlNqY0NOaEhFc2xmV1hMd1JXWGFV?=
 =?utf-8?B?MG1vRStHSjJPUWtVQ21HcEdIR3h6QzdPNkF1MmQrYmlvVm1zd3JoeG16NkQ5?=
 =?utf-8?B?U1daNXIxRkdRNzV5UU9KdzJxUmVRWGpaQWlVbmRoeGx3US9ocGt5UUk0VlVU?=
 =?utf-8?B?VFJpOXhBVXBMMFAzWDBHK1dDQi95NjlJa0Y1bGNjZCtzTURrZy9NWmF0K3hy?=
 =?utf-8?B?bld5V2QyMk4yUDFxWlVFdGlxMjRvZnpDckVhKzVESVBLWGcwS21XT1o0cVVX?=
 =?utf-8?B?UVN2Y1FhR2VrVVhtODR2aTBod1A0NnBRTzVWMnFuZFQ4MzdUaTJGVlFSN3JC?=
 =?utf-8?B?azJ5L3dKY0llNG9va0tZV1k2MkFlUk4wM0R2TU50eEFaaFkwQWpsMzYrczJk?=
 =?utf-8?B?WXUvaStHWlI3VDVQS2tJWlZkdFZxY1JJMHhMbklKWmVXUnJKWlFwOUthWXNQ?=
 =?utf-8?B?N3dIaUg5YUFNbzNsWFZyekNJSkd1Z05qeEx0MC9HRTBpMHNWNlZsaytScHoy?=
 =?utf-8?B?NnUycnkraWllNDE5aklOc3dLOFFUZ1BHbVJnL01QMDI5YnlmSTJFMlg2QkxJ?=
 =?utf-8?B?WnJvUUFzV2ZScHltYWFmeXNJeFhVcTlQcDJMOVJBVjFJcWxHRkFMQkUzZXlq?=
 =?utf-8?B?UWxwZGtHcUVFV1FhZ24xTDhDeERYNnZjT1M0NlBMNkwxZGE5c29KT2NMWDlD?=
 =?utf-8?B?cjdNakszKzhtVUx5RkxaWFk4Y0svdTluTnhRU2R6am1KVzhtbGpaNFFWTjFU?=
 =?utf-8?B?SUVxS1hXU0ZnWTR4VDhzbUJHR2lia09ZbFpoY0poM280enhnNVNLRitVSjdQ?=
 =?utf-8?B?YzhNc0diUDBoYm1GS3kwNldERHVGT01hTTVsZ0tGNThFZFZNWjlZUDRTdVIv?=
 =?utf-8?B?N00vdUZQb3FLVXI5RlVURXQ1Znl6V0N4Mks5UndOem9qZWY5RWhpMUp6STdC?=
 =?utf-8?B?NVBZTWNJSndLSHZRS3J5QlR1ZVZQV2oyN0xjcFhxZE9XV3k2Wk5kLzc4K3Z5?=
 =?utf-8?B?d0lPQjE0bkpVcjRmbERzcEU3ZkNGRUVWZURWNEVIMzhwY0xsK0ltdkMybDZX?=
 =?utf-8?B?eTArUVpKV2F5aFQ5bEU1Nk9uR1FyUjAvRWxJUVRhbVBUMFNhQ2FHVEFCOTg2?=
 =?utf-8?B?WmdqYjdYTzNLSUgvZnptRjFPdFdyenROZmhTTzVBYkMwMFFxNHI5aGFrYWdD?=
 =?utf-8?B?SmR3YjN5dENPWXhWVldyL0FicUZVT0VlOUtsL3NvbDRSd3pvZzQ0OHk1aHBD?=
 =?utf-8?B?Ynh6RW85WjNsd2dlSy9oZUg5REkxcCt4OEppNGtHODcwcUNzWkZyeFplME81?=
 =?utf-8?B?b3RNSWFJUUprRW5xaXVxY0ZQVnM0YytUTVJxVzl1d2h1WS9wamdkelRjTlV5?=
 =?utf-8?B?NGhGTWV5L1N1Z0NVUCtpN1VnaHAreGhUY0Nhek9hL0hYWkd4YVE5anFRQVBq?=
 =?utf-8?B?TEtuUXNSS2kzVWVLMjdqRE5teFBFd2t4Z2d6eEh4L0JTTVF2NUdycmVpcW4v?=
 =?utf-8?B?SmNFZGU1K041SCszWjlUNSs3YUh1enlRUHNtc2tUbDdoNStqZXNjUE94MnFD?=
 =?utf-8?B?V29iWFdPWW9uSkxOaCtlczBlVytpai9obHcvNXNhZ0pUTmxJaWYvalh1eUxp?=
 =?utf-8?B?dWpRQmorRUoyNW1teEhFYjkrRHBCdUNhMVJhWE9sZFBWdEIyRFh6WGhsNjdq?=
 =?utf-8?B?YmZlRWVEdUZMQWtJM3puVzlQQUw3TzFvK0hPUU1VcmN0NEJZT042OGJ1TDha?=
 =?utf-8?Q?R0Ub9wlQS04UKwN8ebgYdW4Djeo0wc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 20:47:38.1496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5ec42b-545d-4a8a-094b-08dd4c6fa705
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

On 2/13/25 3:32 AM, Li Wang wrote:
> Hi John,
> 
> On Thu, Feb 13, 2025 at 6:31 AM John Hubbard <jhubbard@nvidia.com <mailto:jhubbard@nvidia.com>> wrote:
> 
>     On 2/12/25 12:34 PM, Dave Hansen wrote:
>      > Hi John,
>      >
>      > On 6/13/24 19:30, John Hubbard wrote:
>      >> --- a/tools/testing/selftests/mm/protection_keys.c
>      >> +++ b/tools/testing/selftests/mm/protection_keys.c
>      >> @@ -42,7 +42,7 @@
>      >>   #include <sys/wait.h>
>      >>   #include <sys/stat.h>
>      >>   #include <fcntl.h>
>      >> -#include <unistd.h>
>      >> +#include <linux/unistd.h>
>      >>   #include <sys/ptrace.h>
>      >>   #include <setjmp.h>
>      >
>      > I'm not quite sure how but this broke the protection_keys.c selftest for
>      > me. Before this commit (a5c6bc590094a1a73cf6fa3f505e1945d2bf2461) things
>      > are fine.  But after, I get:
>      >
>      >       running PKEY tests for unsupported CPU/OS
>      >
>      > The "unsupported" test just makes a pkey_alloc() syscall. It's probably
>      > calling the wrong syscall number or something.
>      >
>      > I think it's still broken in mainline. What's the right fix?
> 
>     omg I think this is an asm-generic include mistake, I'll check
>     on it in an hour or so, in more depth.
> 
> 
> I just found that mlock2_() return a wrong valuein mlock2-test,
> I guess that was caused by including the wrong header file
> <asm-generic/unistd.h>,which might define a different syscall
> number than what the kernel uses on the test system.

Agreed.

> 
> Shouldn't we make use of <unistd.h> directly?

Well, yes and no. For now, there appear to be two commits involved
in causing these problems, and the __NR_* parts need to be reverted.

I'll explain more when I post later today, but for the moment, the
first, mseal- related commit below has some hints about how we got
here:

504d8a5e0fd4 selftests/mm: mseal, self_elf: fix missing __NR_mseal
a5c6bc590094 selftests/mm: remove local __NR_* definitions


thanks,
-- 
John Hubbard


