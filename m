Return-Path: <linux-kselftest+bounces-12174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CAF90DE6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 23:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9491C21A1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F3179647;
	Tue, 18 Jun 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oORMaF3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557A178377;
	Tue, 18 Jun 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746196; cv=fail; b=p5MKtWqt+MgeoH9vY6JcJLZB3nIcqXRfsKCHTG9OS6W4cuO/AGPpWq00VtTBuoC2SOAx5kLggoKekYmd/L09vogcDJOEcT9DzTAf5jKZmbaRBSXQtOuF92VFqEHQP1wk++NvLwJz1p1rzDeg/0w3EYKtWts6W7Njs421fG0MCzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746196; c=relaxed/simple;
	bh=8W+53oFKahbsHbXd+p+OmTw/zeY0r7Hi5P/uZO5TcS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WED/Uxa+1fCvrwM+U4eG1o9yB6FS2DBqRfCRhV9KuE98xhiSkHMT1rF0X8HUixN2HowK3l1dXjYcIIiMGNSbTZWSgS61qJ1i2/+E/WMWBljjmcamZwHGcOzoMZ4HUdtmleoQVSre9FKqUGP32RdWV4ACm29E0cXoru5ximgCMHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oORMaF3R; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyud1HZ4DSuUCFZ5vtul9CKcGrCAaiE5YjNJuzUrJyrZSunPXR27ajpcCjojA1BCZnZ1JTl4n5Am897thEkVhbRdYEI8DFMah5fjxwPd2xRL/UoS2jjHpEswq17KdFPz+u+1l4LRIoLxANHv3cSLKfladGsEhslwQGH95l0S0l0XcjXX8IkMxMHojE81Iq8aaDwQcXqEoK3VCEws0U5qQ6wcOe0NJLVOz6zxutrDdhVxwxPsVAfv6JbMxN8ma1QfOWfv/FxK2RTzgJcEpStKbxvyXSjJV4xEcJhxA0jAmkkIwlsHxD83o66s0hc6ItgxS8lC64u08wZmXUfZJfnGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vCH+75gUPyekADRTLAWxR9Lks+aGDTPRnPaoeLcJEQ=;
 b=MvkjB6IljGyQVR0qzTdosz1WwkxWgD1uA4YxS+hSrxlyLfQcZSgGm8oyuj4jnXVQtf1+/MkCNn59o4LNQrTDdLKsVbr57VyzAf58C7XTlj7MBaVT2BlhPJfVQ5EtpLq+iCJ0+ijVb8/ArYOATBXZw8NUgZNGbx7IWbkgOLwFvrQXG8N4QUQc4VEGZ/dUjxePGYBw+BZ05ULyJNFEnaUOYN/B0EjLC3anbvQJT3H6EuGAGTv9j07DvxnhmVfIUcrZNFJXmo3Cdn6AGWGv0KXtDo9oVVbkyFenOm2W5Ag7/finYmDDpx++SW7oAyEF8gfEw0NM1D3i2QyrZZvcklpf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vCH+75gUPyekADRTLAWxR9Lks+aGDTPRnPaoeLcJEQ=;
 b=oORMaF3RY0Ax2ohnpulZ0aSuRMu+tMbtNaDBTQRUJW3UhfeomxQEhLPh5EHCjmzo9OB9UaL27fT/IIwJ0hr7g0eGW3UVYw5CR8ubuWMzFqhs1GOHffEopp570xui6JZ1m1kzutoQr7WBNppUjCOD+N6Bo7WZKMuyUkhHU3U26ZfeVlYIxLAOScQ3/F/y29YaT+isSUkvnbj1lgiUJrMpqdAnEaw6IOQIfOhatNhY5rysei9HONrw8hg7Kzhk+uarT9oJSsWS+KpHyF4S7IP01vq8nWkIgLhC61xSi9YDC4dzPBkFrFQ1lcBQijvtEyfceyWiOzqG8Six8vldTpRZmA==
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:29:50 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::17) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 21:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 21:29:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:29:34 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:29:33 -0700
Message-ID: <ee207aed-d116-49b4-a5cc-91385c52e258@nvidia.com>
Date: Tue, 18 Jun 2024 14:29:32 -0700
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
 <9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
 <916f5ba4-02c4-4a33-97e1-5343bde5ae54@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <916f5ba4-02c4-4a33-97e1-5343bde5ae54@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a8dd8c-d395-4f83-5657-08dc8fddc920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|376011|1800799021|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alQ4anhLTXo0UzMwMDlSSFNGRXVXUVBJWjBIbEMzcC9NeTdwQUJuUWdmMXpw?=
 =?utf-8?B?WEhHcndBd0E2K09rQ2toWWI1a04xdzVtdlBVZW5sK052RGQ1M0dEZDVNNjJO?=
 =?utf-8?B?L2doN1A1RnRMQzdUZWtha0NSM0xZWUxZVjBqMWIvOEc2ajJNU1pydnp4bldm?=
 =?utf-8?B?bXVvTGxmWCtFMVZweVlneGJ6SmhYNWJBZlRBdngwTzI1TlBzdkxVS3ZQa0Jj?=
 =?utf-8?B?WHB5ck1oNGFobEcrVTg1ME11WmRrOEFOelpLVGVDQlJHVUc5T2ZFRG5Cc0o2?=
 =?utf-8?B?b2laZ0xmajdGN1dOaWtsUnorWW9EVjVYWGpSeHJUSGpmL0l4aDluU2owY3Y5?=
 =?utf-8?B?Y2tNTlo0U3VVR1V1VlVDZ243U3A0ZURnV1NRYTQwS2t4dUdndmpoUDNvWERG?=
 =?utf-8?B?SUNOSURvSjJKc2swbnh2ZWd6Uzl5R2RSZWhzU1BQSllkcUx3ZGoyL1lNMFJp?=
 =?utf-8?B?SE82MlNlN2RvMjlER3I1M0hnWXRQU0Q2WGRuM0RxU0hlemV5WmM3NjJDRzJJ?=
 =?utf-8?B?QzF3NzBBWkpQL2xHdkRkbFBsbkdUK2ExTExNUGhqQmhvc3NmRzl1UFQzZ0Fn?=
 =?utf-8?B?SWVnTmVnOUt0OVNXdkZOYUd3WHFGR0lVdkx0T2dzQWNnNVJ5N1lVMzVDTUpj?=
 =?utf-8?B?ZXJCSTFCMUhtaXo4Yk83TnN6Qk5sQzBoNzk4a1JOa2lKSHN3VFlTeGVtWHRW?=
 =?utf-8?B?OTYwcjZua2VJMENDaUNUL01lcXVBTnFFRTNHeEZMUlk3MHpoNzVobjJMcXhi?=
 =?utf-8?B?R01OMnlLdlpoWUdVL1dlN2g0a3hFWndtOHkyUVF0R3JCaDJ5L1BDRU96YVRV?=
 =?utf-8?B?ZG1rQ1dlZ1laYlRvdGJkQjNyNmdsMTFPZFZvMEtBQlZuRE4yZjJreWZXdmhw?=
 =?utf-8?B?K1p3SmhSZ3J2NXgvekJPd3hKSXFJTnpsdmFBT2dHTXdsNUJ3RnNhMTBGMHpv?=
 =?utf-8?B?ZXFPN0Zjc1hud1Z4RGpYRzBzYTN2TUpodDlyclFCN1VkS1VrQXdmNWg2Q2h0?=
 =?utf-8?B?N293UHA2VkRKTEhOa3VyZXVTZXZwN1J4UnoxM211K3UzelVWNUpCMHpmaUd6?=
 =?utf-8?B?eU1ndEVyN09rendXamcwaVd6Q0VUa3dYby9Bdi9jUy9ScC9mQjFmWmJRN0hq?=
 =?utf-8?B?ZVdzdi8xaU9FQnhQU1grWXZwRzNNRGNZVGJGd3dUbEh2Ykd4ZGF6NkxnWXVD?=
 =?utf-8?B?bFQ0M2g4WkJsRFBGQ2JPYmZhZ2YvSlJmc25DUzJucHJJQlVxcFBSZ1pibTdN?=
 =?utf-8?B?b0RrNlFKcDlhRXZEMmZSS2N0Y1krWXdONGxIeEwxcGtORTFtWHJkZDd5R3VQ?=
 =?utf-8?B?K2xNUSsyejFUOTFUV25aN3Z1Y1RUcTdtR3Y0WEhpQmptM0lySzV0Tmt3djJX?=
 =?utf-8?B?MVpqWloydTBYNS8vNS93S0NSRWRrZ1VaS0x2VzkvdWFZaHlCa1NCRjZiZ1RP?=
 =?utf-8?B?OVVOcE5NU0NIL1pNU0Q0ZjIzbUhLZDYwQk1oL0tkQXI0c1Bic1NVeFN2aUdk?=
 =?utf-8?B?cVJRV2NzdmJKY0xpcGRQODhKbFdFdFBUNzZ5aGZVUDVKYXJlRTNBRkdZazlO?=
 =?utf-8?B?MVZ6amhOTUxXQVRwdDhKV1Bicmsyb05yQUFXb3VJVmZuZFR2MEtYaVdhdGdn?=
 =?utf-8?B?NUgvZTFjaU5ML2NhWVAzS3d5UEM5VzlBTnFVdjdXbFMvdFp0RSswdVNrVHhK?=
 =?utf-8?B?MnVQTlVnUG0zdzN1ZE9pMnRCTUR2TWQ5aEZyVW56alJBU1FMUkhmelBFclVa?=
 =?utf-8?B?bWFwZHZqK01xTFhobWVPUTV6MnFCRXhpMnh0eUpTZ0dOVkVJeHU3RFB2cUx0?=
 =?utf-8?B?RWVHOEhKaTRkZjROUGVXbHpPUjdIM0FIMXQxMGFqeGtNbEkvN3JvbmJoMTlT?=
 =?utf-8?B?NnBBLzFDV0U5TGgxakFXaGMrQThELzg2d3hvak5tVDBrdEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(376011)(1800799021)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:29:50.2620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a8dd8c-d395-4f83-5657-08dc8fddc920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On 6/18/24 1:54 PM, David Hildenbrand wrote:
> On 18.06.24 22:14, John Hubbard wrote:
>> On 6/17/24 11:56 PM, David Hildenbrand wrote:
>>> On 18.06.24 04:24, John Hubbard wrote:
>> ...
...
>> I can update the commit description with some of the above, if it helps.
> 
> I think it will. The main concern I had was that we could be ending up including headers with *wrong* data. As long as (a) it compiles where it's supposed to compile (b) it runs where it's supposed to run, we're good :)
> 

OK, I've drafted an updated commit description (below), and in order
to reduce email churn perhaps it's best for me to hold onto it for a
day or two, while we see how v3 fares in linux-next. (Thanks, Andrew,
for patching that up with my Makefile fix.)

Here's the draft:
selftests/mm: mseal, self_elf: fix missing __NR_mseal

The selftests/mm build isn't exactly "broken", according to the current
documentation, which still claims that one must run "make headers",
before building the kselftests. However, according to the new plan to
get rid of that requirement [1], they are future-broken: attempting to
build selftests/mm *without* first running "make headers" will fail due
to not finding __NR_mseal.

Therefore, include asm-generic/unistd.h, which has all of the system
call numbers that are needed, abstracted across the various CPU arches.

Some explanation in support of this "asm-generic" approach:

For most user space programs, the header file inclusion behaves as
per this microblaze example, which comes from David Hildenbrand
(thanks!) :

     arch/microblaze/include/asm/unistd.h
         -> #include <uapi/asm/unistd.h>

     arch/microblaze/include/uapi/asm/unistd.h
         -> #include <asm/unistd_32.h>
         -> Generated during "make headers"

     usr/include/asm/unistd_32.h is generated via
     arch/microblaze/kernel/syscalls/Makefile with the syshdr command.

     So we never end up including asm-generic/unistd.h directly on
     microblaze... [2]

However, those programs are installed on a single computer that has a
single set of asm and kernel headers installed.

In contrast, the kselftests are quite special, because they must provide
a set of user space programs that:

     a) Mostly avoid using the installed (distro) system header files.

     b) Build (and run) on all supported CPU architectures

     c) Occasionally use symbols that have so new that they have not
        yet been included in the distro's header files.

Doing (a) creates a new problem: how to get a set of cross-platform
headers that works in all cases.

Fortunately, asm-generic headers solve that one. Which is why we need to
use them here--at least, for particularly difficult headers such as
unistd.h.

The reason this hasn't really come up yet, is that until now, the
kselftests requirement (which I'm trying to eventually remove) was that
"make headers" must first be run. That allowed the selftests to get a
snapshot of sufficiently new header files that looked just like (and
conflict with) the installed system headers.

And as an aside, this is also an improvement over past practices of
simply open-coding in a single (not per-arch) definition of a new
symbol, directly into the selftest code.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

[2] https://lore.kernel.org/all/0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com/

Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


