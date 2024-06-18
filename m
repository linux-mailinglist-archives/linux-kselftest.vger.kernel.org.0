Return-Path: <linux-kselftest+bounces-12170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1790DD23
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9DAB221BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4C16630B;
	Tue, 18 Jun 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujafPQ6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10439AEC;
	Tue, 18 Jun 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741897; cv=fail; b=suUqY5muNIMOAv8GSzOgj20WVL/tEEQoULi7aFK8VEhMkcApSqwMAtJAm4Cukh7BWZ5inzXUOJ3f6zw+xKbfzvjd1VNfdJjjjdI4dkdzYD+sTVDo3n981t8JgZpcxc+mxX5CSgQAuaL3p+Rj6j5AZ3rhTCl7PxkapByfxyyOc/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741897; c=relaxed/simple;
	bh=QMACK3j7zvKFZENZ050wFltHghVR5bhMIf4vdCFVqNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UuUgm7YEFo1e3ysh34hN3MXvjGawN9N2Ia85+tzdG8VYLaQ5GmD+/iAdsTu6I9GRrHkefe9zqWuUgK5SOY6b41hBG8tjPqpwoh0kZQjGHJnMpRYDHhFkJIEq81xLhVTmigjQ1hz6jOov3HNvO6tSMB6aeepsGlWiU9JYzjIEfns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ujafPQ6l; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol9OMKezxjhWGgcy+o1xZLeH3dbf6a9P5FV3DT2NJ6ESHrXR0tBDkW+0j3Q9rRrlkefctf03qw3XsSvlsU7uUqstn6fUTuYkQPx/A20ue/fH74t89Hk8rOAWH1/dy+t9wXb46YnAUU1bopAcaOcRPii6v/n293jt2qI6eMTVDYzohjv+NNFUyg1nIQvlTtycyv4mUjMkPXoIrswgxt9YMKr4v8p3Jn+XxJRAkkvGnGEJUXUyMYptC5FXnxj+29iUBKhvSgMwnUfW0ipkDUxXb90BFkzp0zzynPSGhj6m5ktHEv7mIpzS+mwRMfA6XxMV0ELj9ejsN8zXudcz0idmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVDHdYuFP+kqsUn27U7YfO/tGnwP1lh1X+8L4cX0UW0=;
 b=blhMt8dT/OOyKDkAbKMHxqjJw2Ty+tpitkzoCWCUjjGD35m74+57BozYYj/ur1winx1YrBdP371no2iUiZcTsU+s+x0Mu3zk+vPue5477YcfMYzCDbVXToIr80lLbN1ZRc1jUDd3Wsr97btgZZk3PTUNmoIFr5/Dsl8x/9DN9JrWPcSTms1l4bSd0WU5K+NTkR+KrLYJjwmsEZkDdgK9az9Z1igA7rJuL/b47kjbYHjH/oEaaT01z6jMFOyjnSho+EI89EfAcfOZz8jrYuNBov9JAinWnRD4SX/JWRxRg9bQen/shV+opikRIrFKP6GCXy7vCOkdZF3bbvkA5TwUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVDHdYuFP+kqsUn27U7YfO/tGnwP1lh1X+8L4cX0UW0=;
 b=ujafPQ6ltkp1opyZ1GQr1CFJl+AZ4LaZHPezRT1YW2OqJSg1eSgWAze8maSw68rjynIRoUZE9UMEO1rcafYpl6uUCjiiDNUiqgWclFOlNDUMzvDTH56sQBpVOFeojtKhlJR8iF65rhNu4TVpIUBi03CnWaBOhGnoxRBjE9WzLVVapFjL2yh7v7A89WBUg1wDTqlUpdjgZ+pnk/92nJRJJYf426R6GPfMAz5JFTGUgW5DEeNGT4dSIiDJ1VxQhAKFi1A8F2qDtqsc2Q55uceMEL+IhYS6X4mGIy/yLa7ghiTFVBNG8YsefBuAxISZhCLXewXnaB7Kv8CrkcHjCHzwwg==
Received: from DS0PR17CA0020.namprd17.prod.outlook.com (2603:10b6:8:191::27)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 20:18:10 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::2) by DS0PR17CA0020.outlook.office365.com
 (2603:10b6:8:191::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 20:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 20:18:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 13:17:46 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 13:17:45 -0700
Message-ID: <01685978-f6b1-4c24-8397-22cd3c24b91a@nvidia.com>
Date: Tue, 18 Jun 2024 13:17:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] selftests/mm: mseal, self_elf: factor out test
 macros and other duplicated items
To: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
CC: Andrei Vagin <avagin@google.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, Kees Cook <kees@kernel.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu
	<peterx@redhat.com>, Rich Felker <dalias@libc.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-3-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240618022422.804305-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: c627987e-0283-4c9b-d14b-08dc8fd3c4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUNvMVg5Zy9UZ2k3enJGV2FwV0VpM3lDTHdSN3g2QUlZVlV6OWo0QWJ0VDhM?=
 =?utf-8?B?cmdFNGQyeDRYejNWNEV6NG5uOVIya1ROUVBUSzFEUUdBZnp6alM3a3k0SEly?=
 =?utf-8?B?SEtGckVncXRBTlhDRmFDSVhFZWZzMy8rQVVHd3p4UEVKUkNiS3RobElRUnlq?=
 =?utf-8?B?cDdTeWtWWVU1MXg3T0NWSEEwQUZnMzJIUVZzMG5Tb0h2VjRPMG1ZaEV5bWJQ?=
 =?utf-8?B?L05oTGIzcXdqYnVTS29HaFN4c1ExYjZGb3cwN01KS01ubmpuVC8vWldaU2pO?=
 =?utf-8?B?aWN2RXpJZjhySGpNMG5lYytZQzNGNjlqZGpta2RPU28xczNBWXBUTHZEZjIv?=
 =?utf-8?B?c00vMC82MlR2YVVaeFo3YjdLaEk3S3RIcW1uTHY4d3IybHU1amtPMnN0VEpz?=
 =?utf-8?B?NHpCZlhZSzkxNU1rcy9SRjZzN1NSK3pkZDdNdVJBVUx2YnRReHcvd3g2dmdL?=
 =?utf-8?B?dTdOMnBKczEwdFFBV0JYNTBBZldOSWV5a3hUTnZFYzhtVlhyL3F0eDdzMXVJ?=
 =?utf-8?B?MmJjUnZkNEFpMzI3cG44L2VEMkdKNy9ZZVdBQk4zMkhGZUxhZmFDSnh6SUxT?=
 =?utf-8?B?YnFSeUZwcXpjUTUva0hxSXN0L0tsUGF6VnlKTkJhTTJLRDBCMnpIUCs0dEV6?=
 =?utf-8?B?YndPTWFvOSttdDIrM2JEQVN1TDRkWUxLRjVVcmtHVysyYzNXWXFGVHU2R2Nz?=
 =?utf-8?B?c1RjaU91WWI2TjBCa0RiQURvN1F6ZE5xSlg3aXhpNVd3b0FTTmhQS0hmVXNr?=
 =?utf-8?B?NWlYTXJ3M09VOGRkQUYxSFRnNytSdFdyRUVldnlwSnZDNTlEV0VwcVVzSHg5?=
 =?utf-8?B?TmkwRFdHd3duOUNLYktBNzB3VXRjMHlzOWk1MEdBZVM1SVRhRzFlTWg0Qkkz?=
 =?utf-8?B?QTU3OWczREZHdk1DVEFLSFJMVGx5enFodTFWT1luWkx1ZXRzT3RvZE85dC9y?=
 =?utf-8?B?TzVHbXJ0MDRDMmcvUzNhc0xnL0NNWkg3QnFGY0krN3k1ejlGMk4rMGVucUVJ?=
 =?utf-8?B?aWtENmlDQk1aVFcwL2Q5cWtyUEZtMEZSZ2Q4LzhxWlc5aEJ4RkQvazZkYnhB?=
 =?utf-8?B?MVdPbzlGdnpTQXpOa1d0bnNyaDl0VHNsRENIVmJqQjB1YUtZTkdXZEg4ZVV0?=
 =?utf-8?B?R1Z6RDZoY1lCSFFzVGsxUUtjOGZNMU5CUUdpaGQyM3dEVFUvaWVPK0lXR0dF?=
 =?utf-8?B?SUYvU0pXaUFiNHI4WHZsTS9kWStCckt4Wm9TeDIxWUFXbVVRVzB2cE52Lzlt?=
 =?utf-8?B?d0hDeHIvNFhXemU0TkRvc0pmOXBJVnZia0VuSnZLbEhlN1hLVkNCcytKRWd3?=
 =?utf-8?B?UU80cmlsN0xMTzhlZ2VZTm5qNnlEV3p1WW80SHpRSjQzSVVFK0ZhVU9QZ09J?=
 =?utf-8?B?YmY1UzVKSGc1WXRYTDY1dUZiekpocnF6N2dQN3FqdFc5b2NPbFhpbk5XK3JC?=
 =?utf-8?B?ZFdTQXJwcHQyTEF0ZmJwS0dSZUl3VmRtZ0hBeDFaU2tXSkFqQWV1c2ZxMXJX?=
 =?utf-8?B?MytYYVlUVldqRlhqOHpBdE1rT3dzSXpQclJRM3hORGl6aGZuTHpiaVo4K3po?=
 =?utf-8?B?U2ZPZy93Nm9ZOVAvMFU2ZDgvMTBpcDFSQnVQbE1TOWlOZkw4ZUFRY0ZJOHR6?=
 =?utf-8?B?bGFFZ2RxNTE2THNCcm5SWWRHdURHek9xY0hyVEdJcGhhMmhFRUZ4djU1NWJ0?=
 =?utf-8?B?N3pUYW55WHhLaDUxQ2tLOFhVdFhSeEhFZnd4MmxtU0Q3UWlIZ3E1RG9rdEdI?=
 =?utf-8?B?WTJqdEE3SGFoUkVDOWZTejg1WCtVOG1wYjU3UUZzR1dxMUxzWVJic0VNcXpD?=
 =?utf-8?B?Tmw0ZzBDNFE5ZVk5TkdmYW0xb3hnNHBaQWJvQ1VwbnJsSkI4ODB4YW1jTlJS?=
 =?utf-8?B?L1h5Y2RGOFBua2swNmVLZGFNa1dZc3ZEQmVyajRhT0xZSlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:18:08.0193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c627987e-0283-4c9b-d14b-08dc8fd3c4c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

On 6/17/24 7:24 PM, John Hubbard wrote:
> Clean up and move some copy-pasted items into a new mseal_helpers.h.
> 
> 1. The test macros can be made safer and simpler, by observing that they
> are invariably called when about to return. This means that the macros
> do not need an intrusive label to goto; they can simply return.
> 
> 2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best we
> can do is to factor out these few items into mseal_helpers.h.
> 
> 3. These tests still need their own definition of u64, so also move that
> to the header file.

And I just noticed that I left out this one:

4. Be sure to include the new mseal_helpers.h in the Makefile dependencies.

In other words, this hunk is also needed:

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 3b49bc3d0a3b..23daa097d5b7 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -2,6 +2,7 @@
  # Makefile for mm selftests
  
  LOCAL_HDRS += $(selfdir)/mm/local_config.h $(top_srcdir)/mm/gup_test.h
+LOCAL_HDRS += $(selfdir)/mm/mseal_helpers.h
  
  include local_config.mk


I'll send out a v4 with that, once we resolve the discussion around patch 1/6.


thanks,
-- 
John Hubbard
NVIDIA

> 
> Cc: Jeff Xu <jeffxu@chromium.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/mseal_helpers.h | 41 ++++++++++++++++++
>   tools/testing/selftests/mm/mseal_test.c    | 49 +---------------------
>   tools/testing/selftests/mm/seal_elf.c      | 33 +--------------
>   3 files changed, 43 insertions(+), 80 deletions(-)
>   create mode 100644 tools/testing/selftests/mm/mseal_helpers.h
> 
> diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
> new file mode 100644
> index 000000000000..108d3fd0becb
> --- /dev/null
> +++ b/tools/testing/selftests/mm/mseal_helpers.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define FAIL_TEST_IF_FALSE(test_passed)					\
> +	do {								\
> +		if (!(test_passed)) {					\
> +			ksft_test_result_fail("%s: line:%d\n",		\
> +						__func__, __LINE__);	\
> +			return;						\
> +		}							\
> +	} while (0)
> +
> +#define SKIP_TEST_IF_FALSE(test_passed)					\
> +	do {								\
> +		if (!(test_passed)) {					\
> +			ksft_test_result_skip("%s: line:%d\n",		\
> +						__func__, __LINE__);	\
> +			return;						\
> +		}							\
> +	} while (0)
> +
> +#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
> +
> +#ifndef PKEY_DISABLE_ACCESS
> +#define PKEY_DISABLE_ACCESS	0x1
> +#endif
> +
> +#ifndef PKEY_DISABLE_WRITE
> +#define PKEY_DISABLE_WRITE	0x2
> +#endif
> +
> +#ifndef PKEY_BITS_PER_PKEY
> +#define PKEY_BITS_PER_PKEY	2
> +#endif
> +
> +#ifndef PKEY_MASK
> +#define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
> +#endif
> +
> +#ifndef u64
> +#define u64 unsigned long long
> +#endif
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 58c888529f42..d4d6ae42f502 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -17,54 +17,7 @@
>   #include <sys/ioctl.h>
>   #include <sys/vfs.h>
>   #include <sys/stat.h>
> -
> -/*
> - * need those definition for manually build using gcc.
> - * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_test.c -o mseal_test
> - */
> -#ifndef PKEY_DISABLE_ACCESS
> -# define PKEY_DISABLE_ACCESS    0x1
> -#endif
> -
> -#ifndef PKEY_DISABLE_WRITE
> -# define PKEY_DISABLE_WRITE     0x2
> -#endif
> -
> -#ifndef PKEY_BITS_PER_PKEY
> -#define PKEY_BITS_PER_PKEY      2
> -#endif
> -
> -#ifndef PKEY_MASK
> -#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
> -#endif
> -
> -#define FAIL_TEST_IF_FALSE(c) do {\
> -		if (!(c)) {\
> -			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
> -			goto test_end;\
> -		} \
> -	} \
> -	while (0)
> -
> -#define SKIP_TEST_IF_FALSE(c) do {\
> -		if (!(c)) {\
> -			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
> -			goto test_end;\
> -		} \
> -	} \
> -	while (0)
> -
> -
> -#define TEST_END_CHECK() {\
> -		ksft_test_result_pass("%s\n", __func__);\
> -		return;\
> -test_end:\
> -		return;\
> -}
> -
> -#ifndef u64
> -#define u64 unsigned long long
> -#endif
> +#include "mseal_helpers.h"
>   
>   static unsigned long get_vma_size(void *addr, int *prot)
>   {
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
> index 27bf2f84231d..45c73213775b 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -16,38 +16,7 @@
>   #include <sys/ioctl.h>
>   #include <sys/vfs.h>
>   #include <sys/stat.h>
> -
> -/*
> - * need those definition for manually build using gcc.
> - * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 seal_elf.c -o seal_elf
> - */
> -#define FAIL_TEST_IF_FALSE(c) do {\
> -		if (!(c)) {\
> -			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
> -			goto test_end;\
> -		} \
> -	} \
> -	while (0)
> -
> -#define SKIP_TEST_IF_FALSE(c) do {\
> -		if (!(c)) {\
> -			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
> -			goto test_end;\
> -		} \
> -	} \
> -	while (0)
> -
> -
> -#define TEST_END_CHECK() {\
> -		ksft_test_result_pass("%s\n", __func__);\
> -		return;\
> -test_end:\
> -		return;\
> -}
> -
> -#ifndef u64
> -#define u64 unsigned long long
> -#endif
> +#include "mseal_helpers.h"
>   
>   /*
>    * define sys_xyx to call syscall directly.



