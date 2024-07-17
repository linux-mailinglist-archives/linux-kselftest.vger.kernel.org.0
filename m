Return-Path: <linux-kselftest+bounces-13850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B049343BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93171C21FC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907B184124;
	Wed, 17 Jul 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1jF9nTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCE1CD26;
	Wed, 17 Jul 2024 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251014; cv=fail; b=EbEGxPP0C9FLUhjO8ocnQ4dmZi+7zetDtAbcPz5uPeK/bL7H1M/DbP5p/tkjzNytpmcTpkIEHTxXtgUByEGY8+dcaIdHzcut1E/oI4bEA3EKVb2waPvCBPUHw5jArhp87scTwcNU5RHq4AjzqZcQuXnSKdSZWswe7ZBxE3Xulvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251014; c=relaxed/simple;
	bh=c2Y5+izUQNZ/22R9H3XP3aYUHoYtanVZKkJ7mfpYW2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TPjyH8JJX1JuuMMhUqrZgxdaCMWBzRgN0sv3gA6vIjrsIsU2v2vakG5iRowflxUb0W2/z2rzDPsNFuo4e0FciVveG8BcTyuR/h1E/aPru0HfH4nSApE1+ZQ0ZpLIn9eJkFM1Gf5gz0QbfQfpcbUXJpIKK+FWVxij8jtsss2N5XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1jF9nTT; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npikMYvo+ikB4hkY9QsxjzU6KOvpOCV/S8obucdHuPieskVhLfWihF7gtBYQABOuNuMJfqolHIjGasR89JmP6Sl4A8yzKSomTlQV40dYgLnWaX/8tyLvoMfAdIbp+iHM0pnUZZa00mfH9UohUppcOcjW+ixXeUnZPHFy6+mSpbsnhpk6T6G4go987kOoKLUZwclNAEkNN/sw12ETcF0dlDr9QdWx8qqyicR+ekMglZ1kgHSlSKAlHihRlhB234glrf18pezW8oSHJ0ceV2Pjh+/+ja+U7wbrnegpDy2q3ORfWdBwUyYRL3HVm91d88a2Ve+RLafXwbii7kboFr0d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFTxA26qxX0LEsqL2b/GEilvfnN7opf8orVNozHUTvs=;
 b=LwnQHcwVlFxSZS88/tlNk3t0WPTtG/prgHLSlsY+wjIsSdAevXneB4WA9WJdzRNTn+kZ08w8Z7xs++0CKJTixF303pmuBlrNWbdSNkxPY+2jUgGBquCm+SKek9eFP+QFw7h44iHjpYOnfBtngAplCUg0QzFTkajcxjjvyNs5U8jFPoNb+IB4vefPpEloJq7OLnJhAaRlFu43OOKZ0p9bN/PA07ikhBLnNdTtIcmh5wG54pPnMlE0bAVUDlB/IU7/colu1AvpCk+rKDv2thVi9WMXf3JqXD7BFdm9BnFFheDvtd0ZPk0n6fXkS98C4xu0wl6G6owl+ms7/LbFSpZjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFTxA26qxX0LEsqL2b/GEilvfnN7opf8orVNozHUTvs=;
 b=m1jF9nTTWaorLf46Fd7O6/cWu4X19EmLvo1zt5dSYHjmsFg4Sw231L0tweCWuy010eQ/8YbZfbg2b4KAU/BSzH92txofpjPmY5BBktzychvTbLyoMJp/Ty1GULWfIt9uFyv5FGRxJrZGAdQ38FOh6t6hiTFqZoM5Q8xn1cKZ4ZMovBbmQ+THNA3wzmUyi3t9g0IvSNaXIDU61uvev6xpGG1r9QNxb0OX7bFdvC1AUN0mgj0uTL92KoEhJOcT36N8BJ0Xqv9kJtY4cgQhN03cARfW38iw+ZF9RUQbIsKS32R9PT0WeJr/I+490ds2M/FiL12WkbPoaPCMbr758MXwxQ==
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Wed, 17 Jul
 2024 21:16:48 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::50) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Wed, 17 Jul 2024 21:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 21:16:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 14:16:32 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 14:16:31 -0700
Message-ID: <a5005f1e-5bbc-49f2-bd1f-4c4878b98d26@nvidia.com>
Date: Wed, 17 Jul 2024 14:16:30 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: KUnit: Update filename best practices
To: Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>
CC: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240717210047.work.412-kees@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240717210047.work.412-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: d9113c80-0376-4134-50be-08dca6a5c50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N28yRFZuWnJWOU94d1l1TkYyNzlkaXhCc1VqbnlxVkM0N3M0SHRMTzdpUlhQ?=
 =?utf-8?B?WXc0amNjY1hXMUhlcHFjdWJTcUNkSVdRZFdSN25YVDYrc2JuRnRjNG5NTXE5?=
 =?utf-8?B?VnVkcThkWkhaeFo0d3lJYmQ5TTJtcEdjNWZqM3JuZ2ZjbWQxcE1YYXhRalFh?=
 =?utf-8?B?TkZmWEU5RDh4Nys4UG1aN2lQREJGaTdFanpiNE5CR0NhRUg4SXlSQ21SMk9S?=
 =?utf-8?B?VENnWVMyUnA2WlJVRWtWeHYrYjZ3cUZNWjQwUnczYmE0TmtKWlprY0tVb1ZW?=
 =?utf-8?B?YUo3c05rVjkzMm9XaEFaRTluZUFDZ3RFTTYrMWg2MklkNjMvOGVxVk1FNVAx?=
 =?utf-8?B?Z3dyWEFYRU5kbkJXVVpFaXBOVldkdFVnRGZkYTA3Mi9Mb291UmxvenNTRTE4?=
 =?utf-8?B?NGdRYU9Qc3dra2drTUoyUWNzMDZKWnhTN0xjRExqcUg3TFF4QmtMcjVOV2da?=
 =?utf-8?B?dndSRVNUOGJYc1lYVHJ0aGYraVJBZi9nSGlRY1I1NXpSS29JUGFtRjN0d1pq?=
 =?utf-8?B?WlpLS2prS2NrM2hpY3dxUTZjMUZCdjB3V1FSYzlPLzVZOEMrQVlKcU1qUTF1?=
 =?utf-8?B?NTRWa3VHakVQN1VHcEtiQ0EzV05yQ1ZRdHFQa2ZTVXZjdHl3ZFQxVU9sMERk?=
 =?utf-8?B?dG1QcnhUTE9mYlR1ZUptd2VUTWZnd1ZmMCtEa2RwM3BObmJ1T1JuL3A5YTNT?=
 =?utf-8?B?QW5pS1h6amZLZXplMk9GMmI5R1AvTjFaQis4cmlsNHhmL2VWREhvOG15dWlp?=
 =?utf-8?B?SVN6eTlBYXBscUlONWFFWXAwSGJoN2cyY3Uzd3F0U3UwRXkxcW9iVjFMVHdZ?=
 =?utf-8?B?MENwTGp4RzhwMHlzMHNScHlkRGVPUlVwenlBb0JzYXRpejJxTFlqVWpmUVY1?=
 =?utf-8?B?L0dqSXdCNUxNczNpc0x1dW1relE2T0NvOXBjVm9ySlRaeXR6TWg5WStIN1Mv?=
 =?utf-8?B?a0NRa0pteVdVVC9xMTNUb1JvZTVhRnNvK1UxRGNvY2pkZEY1T3VyODJDZXRS?=
 =?utf-8?B?OWxuakFJUVMrSVRRZXJ1MkxkRC94M2JUdUw2clNrRXJlVFZVSEd4NGdxTktk?=
 =?utf-8?B?dmZXc09zTEI5b2JXdEMwbWNRakJrb3phK3A5UmpMWmJZRnl0eGJ5bHp5VGZu?=
 =?utf-8?B?RVZsQnZ2MFI0b3AxUWQ4c1B0UWJmayszdU5SbjFRTStGSTBXQzZIc3hzT25C?=
 =?utf-8?B?bTFJTXJiLzZacXZOWU8rOTA5QzhmOG1aQUh6V29OZGVzcGlVd3FaM015RjJW?=
 =?utf-8?B?OHNmbWozVE5KMTYyamRpWGdjd1lpZzBNTGo4Vm9ZSW5IVEEzdjdFMm1lZ2dY?=
 =?utf-8?B?R3NOU1RUMGFtSGQ2VlFFZnVUMnc4Z0c2NVUrQW9WOG5OM1hGWk5tQ3hZUjAr?=
 =?utf-8?B?Z21aZUxkSXBabHhMZVNTQmQwNittU1hQcGFBQTNNNHhucnFLbkhHMEtyOTln?=
 =?utf-8?B?YW96b0t0RzFUZUJIWGE1SUNDWktRNmhEb05tZFlhbjRwM2J6M1VuU3hYbFlQ?=
 =?utf-8?B?VmZuT1ZSS1JkOUlJWXpxUnJPUS9TVFFqVWsySk9wQVh4Qlk1ZDY3WWc3VkNE?=
 =?utf-8?B?Rm1SQ3hWMUljN3EvNTFQVnlNZis5bEMveXZranNUV3djMWpwaUh5VDBrYVhi?=
 =?utf-8?B?QTBtUEV2eXJkdENqTzBJc2RSNDBacnQwcjFXMlhXZzU1ZWxaOXd2OU14QU1I?=
 =?utf-8?B?NjFpaGF1Z0NDVTQ1eFB0eU10OUNRekpaaDlHODNJQXpSRTJRdTlRc1lNenMw?=
 =?utf-8?B?NGhQaGlYQ2t1cWVBVUthNzFPS3A1SnJCVlIxWStSNUtwRjY5M2pUdExJNUMw?=
 =?utf-8?B?c1gxNzZ1RmpkeTZTaVRvYlZ3d21jMUo4WmtBRTF3SVU0VU1UWVhUcHpQai9H?=
 =?utf-8?B?Y2ZaZkpDRytiSDNSR20ySlBKbXF0Ym0xbE9tU0VDL0h4UGxTUS9SNVF5dHBy?=
 =?utf-8?Q?AkkwON0jtcOllnXiphfq7boo+FcJG4F0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:16:48.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9113c80-0376-4134-50be-08dca6a5c50f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767

On 7/17/24 2:00 PM, Kees Cook wrote:
> Based on feedback from Linus[1], change the suggested file naming for
> KUnit tests.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/dev-tools/kunit/style.rst | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> index b6d0d7359f00..761dee3f89ca 100644
> --- a/Documentation/dev-tools/kunit/style.rst
> +++ b/Documentation/dev-tools/kunit/style.rst
> @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
>   Test File and Module Names
>   ==========================
>   
> -KUnit tests can often be compiled as a module. These modules should be named
> -after the test suite, followed by ``_test``. If this is likely to conflict with
> -non-KUnit tests, the suffix ``_kunit`` can also be used.
> -
> -The easiest way of achieving this is to name the file containing the test suite
> -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> -placed next to the code under test.
> +Whether a KUnit test is compiled as a separate module or via an
> +``#include`` in a core kernel source file, the files should be named
> +after the test suite, followed by ``_test``, and live in a ``tests``

I read the previous discussion in the other thread and thought about it.
And ran some kunit tests on baremetal. Delightful! I love this approach.

However! It is rather distinct and not just any old test module. Kunit
has clear conventions and behavior.

As such, I have quickly become convinced that distinct naming is
required here. So I'd like to suggest going with the the suffix:

     _kunit

...unconditionally. After all, sometimes you'll end up with that
anyway, so clearly, the _test suffix isn't strictly required.

And given that we are putting these in tests/ , a _test suffix is
redundant.

Yes?

> +subdirectory to avoid conflicting with regular modules or the core kernel
> +source file names (e.g. for tab-completion). If this would conflict with
> +non-KUnit tests, the suffix ``_kunit`` can be used instead.
> +
> +So for the common case, name the file containing the test suite
> +``tests/<suite>_test.c`` (or, if needed, ``tests/<suite>_kunit.c``). The
> +``tests`` directory should be placed at the same level as the
> +code under test. For example, tests for ``lib/string.c`` live in
> +``lib/tests/string_test.c``.
>   
>   If the suite name contains some or all of the name of the test's parent
>   directory, it may make sense to modify the source filename to reduce redundancy.
> -For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> +For example, a ``foo_firmware`` suite could be in the ``tests/foo/firmware_test.c``
>   file.

thanks,
-- 
John Hubbard
NVIDIA


