Return-Path: <linux-kselftest+bounces-16340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3AF95FC5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB6A1C22320
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9513A899;
	Mon, 26 Aug 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JCTC4DzS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40E199E9E;
	Mon, 26 Aug 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709623; cv=fail; b=PyJ3KF84C7o7fZDut5eopqW2Xv18E9MgLLX0IoIQ4u5xcgNcvTtCdZArZujHHmFJKKS1pW4kidViqTCd7TmLAu10I7md81/M28a0vskIZH0ByRpjc54ZnMIYhZTbuLs/GRgS3QvLUnCBa42zW84EZ0qhfRp9W5y4cQD1bjq604I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709623; c=relaxed/simple;
	bh=Gl4J/XBf+faPVBuJyjucfT5tmd0bdSb1R+/Rc3sM6+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L3mGCv/X7u38ngLdOkuMzPLdDAn9ukJL2EvG/lRm+epUujduXxhjx1dyfI8VfLLCfcJl+509fXwO0okVExldS/YZIW3R3+Z0k2fXNSuo4Gs5qsHQebh5hIQ4sXSmvZ2ktqt3Kt07/yHJh/5NaHbEad2LXrJQ7SpZX29xRuBBKoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JCTC4DzS; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1Us4G4CVw4JL0ewt0+S6E24i6mbHYk3rdMgZj70f2qG2O4LM8a/hNfLtez9yHyeNidVYyZuBcgMnz8knxhv8YDd78nowlVu5iqctrlFP8hirfYbnLZn5NwsYSnUJFY36BsUZACJQ7ItmJ8fXkkrdtZLRgH4YAQvT8JvGqLK9wfxorv+FLFN1utFX//AiLbCSXcqWQZ2mERMnMTILglPtbEHwFlQRlqPYUpdRlIqOopernEQYFrQwDqU1kKx43GPiBFtZ3NtECUPEkSs+3frb1mjWXTsHuIaBQgEjHTvwcspgl7EaCg1EisjinClVzxKw8mRJmndVVbBjhH9VIhkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGQKXscoKJXwr5zOqTTC0d5Au5j07QtpRyRzKuFSPXo=;
 b=MslOiEU32cklYIS6k05mjP8kx9AHl2xtF19a2w/SJqsO8Eam87eUcQFXVIXw0zZ16jwxQRNJu/BC3iRyCPlWt1s+PBpVRY8M9i8Ov+F0VvmjPZjh2peM/EbV/bCKCGOCW0LIZ4B0fZtpWp5p4asmC1WPggXci6r1QGTQAoHjzBWwF18969hh6zSgK+qZhMZ7yNSvFksoenR8+soC5dyiweC31LoPF4Ry5SHEVaih/65nlCJVbIrwdkRYts4Fy7q8Bp9CmsNMSawD2ye5bF/mfFKsnqv7Emv04dN1KsRZFL/cQ8a1G80Hoa+hJJPywopZHVR+gAo8zZCsoWi2YYrZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGQKXscoKJXwr5zOqTTC0d5Au5j07QtpRyRzKuFSPXo=;
 b=JCTC4DzSR9EK7PZc30aeplCXoeIDgZ6QkFmJqYKv5pq442OueOwhI/FhKv4YD1BHWQR9QGVYAVc/d4rBITAGEljEzkDe1WpDwvUA5wrw80VPfuHk/2I9I3r2YyOyKFl8V5w1e4fqnI8Awllsmj+Fr1Dblf9uyFu3qMaN6krqMTk=
Received: from BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 22:00:16 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::59) by BYAPR08CA0068.outlook.office365.com
 (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 22:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 22:00:15 +0000
Received: from [10.236.30.198] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 17:00:11 -0500
Message-ID: <7634bee3-7918-47bb-8bd6-b2ad85d1299c@amd.com>
Date: Mon, 26 Aug 2024 17:00:11 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] KVM: selftests: Add a CoCo-specific test for
 KVM_PRE_FAULT_MEMORY
To: Tom Lendacky <thomas.lendacky@amd.com>, <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
 <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
 <607e76c0-6e9a-4961-873b-0b952b51faff@amd.com>
 <9079a7e7-17e6-72eb-3510-b07a60ce78df@amd.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <9079a7e7-17e6-72eb-3510-b07a60ce78df@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d74367a-1e2f-4cfd-39cf-08dcc61a77ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWlwOEk4M25oU29MM3FzOEloY250dGZjV3V1ZVM3SWRrUUMwbU1mMkZHTU9R?=
 =?utf-8?B?Qm1QUEd5R0g3VWhVWHh1MSs5bWZFWXQ3eDdTYXFITFdiS3dXZjBWbXR3blNw?=
 =?utf-8?B?aU1iMExScksyTFA2OGV4RDlqK0VHcUhvWDRJcTg1d2F1MlJOYVp0YWtEMUsy?=
 =?utf-8?B?RmhMbnNxTnpuMDRIQzgvWnZPZUF4TTJQaUZ3ZmNURW8xUVdmRFFJSzF4Kzl2?=
 =?utf-8?B?VXZWMEtIa0IzSmJWZnlCaXh6YzFKeEprUDVzcCtJMTdqWE5ZSDAwWUY3bEpn?=
 =?utf-8?B?bXJRVUIrOFJneXhBT1JuUzJMS1YzcmkyV3dmend2NFJGRXY0ZlpHZ1h5V0V3?=
 =?utf-8?B?ajN0VTVvUEloeXZRQzliUVgxd1QwK29iWHVCV3BkYlgzYW11VWY4dDR3dHha?=
 =?utf-8?B?SVJQU1puM1hjTGFkbUp4MnB6cHAxanB3dmxYcTVybFFLQjRkZTd2WGhGOFo5?=
 =?utf-8?B?K1BmTjJJV2VhRHA1MlFCMCtGbndVckltR1lGeVhZdEJESGVrazAzNkx1RDk4?=
 =?utf-8?B?VTA4UEM2cndKS2MrTE02ZlBzUjRvVjRYYkdid0pmWE9iMVVIVW9VcmR1ZjN4?=
 =?utf-8?B?MWJVazNsM011WkExeVduR3lORFdWcmtNeGlqa0NWMDNNeGNYLzdiZmhkV0Qv?=
 =?utf-8?B?QmM4UC9wRzlPWnYrSnZ2QnkvRUNnWFgvQjZYV3RjV1VXRHBUR3ROOHJjUWlR?=
 =?utf-8?B?ck9hWGc1eFFCMTF0YzJJV3dZMk5MY2tIcS9UYXN6VXJQQXk2NUNJZUNkbHla?=
 =?utf-8?B?c3lFa3c1Y1UvK2xQdTU0L2tHcHpQRDRkaUN4MS9aUnBqb29JMWZqcGx1Vm9h?=
 =?utf-8?B?K3RoaGd5N0FpUk14NU41VHFCQXVTWFJTb2pyazdCTWlHR2p5NjB5akpyekZq?=
 =?utf-8?B?blZuTno2elcyQTV2UCswaG9zMzQ4dmttb0RGSDRoSWwzeURPeHNJRFNMVG1Z?=
 =?utf-8?B?N2JZRjFIeSt2V1ByUHJIY1pPRUlsS1lYVTVVeXdXdGVwY3gwS3E5NDVLUHh2?=
 =?utf-8?B?Sm8vREppRG9VZU12eWdDRmt2alQzNEl6MHZhcTZJYXpmcGc2SndONE90UVly?=
 =?utf-8?B?NU81Z3psOHNJdmxnMUVYU1EzNjFyLzZScEFRZURmM1NSOTNDcWZwcmlDcUtn?=
 =?utf-8?B?RVRiTVlLWWFTb2NBU1ZGMkxLclNjbWVOdG5jVUN4bHFEamN0OU0vazBkbVJU?=
 =?utf-8?B?VEg3UmlLanZ5Z3doMlFKR3RjMS9ON20yZ3A5Yi9GSEtTSHhVanc0cjJtMWxI?=
 =?utf-8?B?ZXpzblRMaUpGRHVNUDhTekMrQ3NtRXk4aE5aRlRqOGJReVFMVTk4eUhBUTFM?=
 =?utf-8?B?Y2pqV0NDekN3amNPWmY5N3ZYNjFCNHE2WGtaZVZBQWlOaVo4RE85V3E3Wkdw?=
 =?utf-8?B?SU1HUDNVYmJaWFNRVG5sQXBzRi9oZ0RHS2M3RXhKWUtlcnhmd2NLcVBwZ3pY?=
 =?utf-8?B?VWtoN2JrTWNwN1JDbmE1SzMyT0JWS2FWR0hhL2ZDY2F6Vm1PdXJVRGR3OU8v?=
 =?utf-8?B?SWFYUXRmR0NDT1dPOC9WeHRUY1NIMUFidkRLZmhtSlJzZVFmR0loTHVuWFlL?=
 =?utf-8?B?R1RlZ2NOanhvcW84MFVzV3M0UmtTMnM4d1pUSEErQ0NzL3pDMmU0ZE1Dajc2?=
 =?utf-8?B?VWpFaUM5eDh0Y0tjTHZ5dzVDYm81bHZuYzJTWmk5cEt3NjRvc2FFanhKWUhB?=
 =?utf-8?B?T0pkS2RVU25uWWVyNkY1MnQxdG5zdTU0OE5tZWViQndhRVR0bm02UmxXd0Nv?=
 =?utf-8?B?UU55N0VDSHhwcnRRczFwd1BnQ0RONkhpakphZTBjOTlsRVZpNFVsc1hzVlkz?=
 =?utf-8?B?cEVESXpJNU9WZjRhNFJnVzF2QUJWR3RKYkZkMUxTdXRoejBKbUFzaElqc2ZK?=
 =?utf-8?B?R1pWNnp3Wkg5MUpTSVJkL0JTZGorc0tCSXVhdHFCbVFNNU9zLyttbUg3Sm1r?=
 =?utf-8?Q?PPhEynO3j65iH0waUd8vk/WnDAXx1PFy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 22:00:15.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d74367a-1e2f-4cfd-39cf-08dcc61a77ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849



On 8/23/2024 5:16 PM, Tom Lendacky wrote:
> On 8/23/24 15:23, Pratik R. Sampat wrote:
>>
>>
>> On 8/16/2024 2:23 PM, Pratik R. Sampat wrote:
>>> From: Michael Roth <michael.roth@amd.com>
>>>
>>> SEV, SEV-ES, and SNP have a few corner cases where there is potential
>>> for KVM_PRE_FAULT_MEMORY to behave differently depending on when it is
>>> issued during initial guest setup. Exercising these various paths
>>> requires a bit more fine-grained control over when the
>>> KVM_PRE_FAULT_MEMORY requests are issued while setting up the guests.
>>>
>>> Since these CoCo-specific events are likely to be architecture-specific
>>> KST helpers, take the existing generic test in pre_fault_memory_test.c
>>> as a starting template, and then introduce an x86-specific version of
>>> it with expanded coverage for SEV, SEV-ES, and SNP.
>>>
>>> Since there's a reasonable chance that TDX could extend this for similar
>>> testing of TDX, give it a "coco-" prefix rather than an SEV-specific
>>> one.
>>>
>>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>>> Co-developed-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>>> ---
>>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>>  .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
>>>  2 files changed, 315 insertions(+)
>>>  create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>> index 48d32c5aa3eb..65d19b277b06 100644
>>> --- a/tools/testing/selftests/kvm/Makefile
>>> +++ b/tools/testing/selftests/kvm/Makefile
>>> @@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
>>> +TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
>>>  TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
>>>  TEST_GEN_PROGS_x86_64 += demand_paging_test
>>>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>>> diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>>> new file mode 100644
>>> index 000000000000..e16fe185fb5a
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>>> @@ -0,0 +1,314 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <linux/sizes.h>
>>> +
>>> +#include <test_util.h>
>>> +#include <kvm_util.h>
>>> +#include <processor.h>
>>> +#include "sev.h"
>>> +
>>> +/* Arbitrarily chosen values */
>>> +#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
>>> +#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)
>>> +#define TEST_SLOT		10
>>> +#define TEST_GPA		0x100000000ul
>>> +#define TEST_GVA		0x100000000ul
>>> +
>>> +enum prefault_snp_test_type {
>>> +	/* Skip pre-faulting tests. */
>>> +	NO_PREFAULT_TYPE = 0,
>>> +	/*
>>> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping non-private memory
>>> +	 * before finalizing the initial guest contents (e.g. via
>>> +	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>>> +	 *
>>> +	 * This should result in failure since KVM explicitly disallows
>>> +	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
>>> +	 * initial guest contents.
>>> +	 */
>>> +	PREFAULT_SHARED_BEFORE_FINALIZING = 0,
>>
>> Just spotted that I have initialized both NO_PREFAULT_TYPE and
>> PREFAULT_SHARED_BEFORE_FINALIZING to 0, effectively running the latter
>> test type twice. I will fix in the next iteration that I post.
> 
> Enums start at 0, so you can just eliminate the assignments.
> 

Ack. I Will get rid of it here and the next patch as well.

Thanks!

> Thanks,
> Tom
> 
>>
>> Thanks!
>> Pratik
>>
>>> +	/*
>>> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping private memory
>>> +	 * before finalizing the initial guest contents (e.g. via
>>> +	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>>> +	 *
>>> +	 * This should result in failure since KVM explicitly disallows
>>> +	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
>>> +	 * initial guest contents.
>>> +	 */
>>> +	PREFAULT_PRIVATE_BEFORE_FINALIZING,
>>> +	/*
>>> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping shared/private
>>> +	 * memory after finalizing the initial guest contents
>>> +	 * (e.g. via * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>>> +	 *
>>> +	 * This should succeed since pre-faulting is supported for both
>>> +	 * non-private/private memory once the guest contents are finalized.
>>> +	 */
>>> +	PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
>>> +};
>>> +
>>> +static void guest_code_sev(void)
>>> +{
>>> +	int i;
>>> +
>>> +	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
>>> +
>>> +	for (i = 0; i < TEST_NPAGES; i++) {
>>> +		uint64_t *src = (uint64_t *)(TEST_GVA + i * PAGE_SIZE);
>>> +		uint64_t val = *src;
>>> +
>>> +		/* Validate the data stored in the pages */
>>> +		if ((i < TEST_NPAGES / 2 && val != i + 1) ||
>>> +		    (i >= TEST_NPAGES / 2 && val != 0)) {
>>> +			GUEST_FAIL("Inconsistent view of memory values in guest");
>>> +		}
>>> +	}
>>> +
>>> +	if (rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED) {
>>> +		wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
>>> +		__asm__ __volatile__("rep; vmmcall");
>>> +		GUEST_FAIL("This should be unreachable.");
>>> +	}
>>> +
>>> +	GUEST_DONE();
>>> +}
>>> +
>>> +static void __pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
>>> +			       u64 left, bool expect_fail)
>>> +{
>>> +	struct kvm_pre_fault_memory range = {
>>> +		.gpa = gpa,
>>> +		.size = size,
>>> +		.flags = 0,
>>> +	};
>>> +	int ret, save_errno;
>>> +	u64 prev;
>>> +
>>> +	do {
>>> +		prev = range.size;
>>> +		ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
>>> +		save_errno = errno;
>>> +		TEST_ASSERT((range.size < prev) ^ (ret < 0),
>>> +			    "%sexpecting range.size to change on %s",
>>> +			    ret < 0 ? "not " : "",
>>> +			    ret < 0 ? "failure" : "success");
>>> +	} while (ret >= 0 ? range.size : save_errno == EINTR);
>>> +
>>> +	TEST_ASSERT(expect_fail ? !(range.size == left) : (range.size == left),
>>> +		    "[EXPECT %s] completed with %lld bytes left, expected %" PRId64,
>>> +		    expect_fail ? "FAIL" : "PASS",
>>> +		    range.size, left);
>>> +
>>> +	if (left == 0) {
>>> +		TEST_ASSERT(expect_fail ? ret : !ret,
>>> +			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
>>> +			    expect_fail ? "FAIL" : "PASS");
>>> +	} else {
>>> +		/*
>>> +		 * For shared memory, no memory slot causes RET_PF_EMULATE. It
>>> +		 * results in -ENOENT.
>>> +		 *
>>> +		 * For private memory, no memory slot is an error case returning
>>> +		 * -EFAULT, but it also possible the only the GPA ranges backed
>>> +		 *  by a slot are marked as private, in which case the noslot
>>> +		 *  range will also result in -ENOENT.
>>> +		 *
>>> +		 *  So allow both errors for now, but in the future it would be
>>> +		 *  good to distinguish between these cases to tighten up the
>>> +		 *  error-checking.
>>> +		 */
>>> +		TEST_ASSERT(expect_fail ? !ret :
>>> +			    (ret && (save_errno == EFAULT || save_errno == ENOENT)),
>>> +			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
>>> +			    expect_fail ? "FAIL" : "PASS");
>>> +	}
>>> +}
>>> +
>>> +static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa,
>>> +			     u64 size, u64 left)
>>> +{
>>> +	__pre_fault_memory(vcpu, gpa, size, left, false);
>>> +}
>>> +
>>> +static void pre_fault_memory_negative(struct kvm_vcpu *vcpu, u64 gpa,
>>> +				      u64 size, u64 left)
>>> +{
>>> +	__pre_fault_memory(vcpu, gpa, size, left, true);
>>> +}
>>> +
>>> +static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm *vm,
>>> +				 bool private, enum prefault_snp_test_type p_type)
>>> +{
>>> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>>> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>>> +
>>> +	snp_vm_launch_start(vm, SNP_POLICY);
>>> +
>>> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>>> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>>> +
>>> +	if (private) {
>>> +		/*
>>> +		 * Make sure when pages are pre-faulted later after
>>> +		 * finalization they are treated the same as a private
>>> +		 * access by the guest so that the expected gmem
>>> +		 * backing pages are used.
>>> +		 */
>>> +		vm_mem_set_private(vm, TEST_GPA, TEST_SIZE);
>>> +		if (p_type == PREFAULT_PRIVATE_BEFORE_FINALIZING)
>>> +			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>>> +	} else {
>>> +		if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>>> +			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>>> +	}
>>> +
>>> +	snp_vm_launch_update(vm);
>>> +
>>> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>>> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>>> +
>>> +	snp_vm_launch_finish(vm);
>>> +
>>> +	/*
>>> +	 * After finalization, pre-faulting either private or shared
>>> +	 * ranges should work regardless of whether the pages were
>>> +	 * encrypted as part of setting up initial guest state.
>>> +	 */
>>> +	if (p_type == PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING) {
>>> +		pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>>> +		pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>>> +		pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>>> +	}
>>> +}
>>> +
>>> +static void pre_fault_memory_sev(unsigned long vm_type, struct kvm_vcpu *vcpu,
>>> +				 struct kvm_vm *vm)
>>> +{
>>> +	uint32_t policy = (vm_type == KVM_X86_SEV_ES_VM) ? SEV_POLICY_ES : 0;
>>> +
>>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>>> +
>>> +	sev_vm_launch(vm, policy);
>>> +
>>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>>> +
>>> +	sev_vm_launch_measure(vm, alloca(256));
>>> +
>>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>>> +
>>> +	sev_vm_launch_finish(vm);
>>> +
>>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>>> +}
>>> +
>>> +static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
>>> +				      enum prefault_snp_test_type p_type)
>>> +{
>>> +	struct kvm_vcpu *vcpu;
>>> +	struct kvm_vm *vm;
>>> +	struct ucall uc;
>>> +	int i;
>>> +
>>> +	vm = vm_sev_create_with_one_vcpu(vm_type, guest_code_sev, &vcpu);
>>> +
>>> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
>>> +				    TEST_GPA, TEST_SLOT, TEST_NPAGES,
>>> +				    (vm_type == KVM_X86_SNP_VM) ? KVM_MEM_GUEST_MEMFD : 0);
>>> +
>>> +	/*
>>> +	 * Make sure guest page table is in agreement with what pages will be
>>> +	 * initially encrypted by the ASP.
>>> +	 */
>>> +	if (private)
>>> +		vm_mem_set_protected(vm, TEST_SLOT, TEST_GPA, TEST_NPAGES);
>>> +
>>> +	virt_map(vm, TEST_GVA, TEST_GPA, TEST_NPAGES);
>>> +
>>> +	/*
>>> +	 * Populate the pages to compare data read from the guest
>>> +	 * Populate the first half with data and second half as all zeros.
>>> +	 */
>>> +	for (i = 0; i < TEST_NPAGES; i++) {
>>> +		uint64_t *hva = addr_gva2hva(vm, TEST_GVA + i * PAGE_SIZE);
>>> +
>>> +		if (i < TEST_NPAGES / 2)
>>> +			*hva = i + 1;
>>> +		else
>>> +			*hva = 0;
>>> +	}
>>> +
>>> +	if (vm_type == KVM_X86_SNP_VM)
>>> +		pre_fault_memory_snp(vcpu, vm, private, p_type);
>>> +	else
>>> +		pre_fault_memory_sev(vm_type, vcpu, vm);
>>> +
>>> +	vcpu_run(vcpu);
>>> +
>>> +	if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
>>> +		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
>>> +			    "Wanted SYSTEM_EVENT, got %s",
>>> +			    exit_reason_str(vcpu->run->exit_reason));
>>> +		TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
>>> +		TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
>>> +		TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
>>> +		goto out;
>>> +	}
>>> +
>>> +	switch (get_ucall(vcpu, &uc)) {
>>> +	case UCALL_DONE:
>>> +		break;
>>> +	case UCALL_ABORT:
>>> +		REPORT_GUEST_ASSERT(uc);
>>> +	default:
>>> +		TEST_FAIL("Unexpected exit: %s",
>>> +			  exit_reason_str(vcpu->run->exit_reason));
>>> +	}
>>> +
>>> +out:
>>> +	kvm_vm_free(vm);
>>> +}
>>> +
>>> +static void test_pre_fault_memory(unsigned long vm_type, bool private)
>>> +{
>>> +	int pt;
>>> +
>>> +	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
>>> +		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
>>> +		return;
>>> +	}
>>> +
>>> +	switch (vm_type) {
>>> +	case KVM_X86_SEV_VM:
>>> +	case KVM_X86_SEV_ES_VM:
>>> +		test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE);
>>> +		break;
>>> +	case KVM_X86_SNP_VM:
>>> +		for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING; pt++)
>>> +			test_pre_fault_memory_sev(vm_type, private, pt);
>>> +		break;
>>> +	default:
>>> +		abort();
>>> +	}
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
>>> +
>>> +	test_pre_fault_memory(KVM_X86_SEV_VM, false);
>>> +	test_pre_fault_memory(KVM_X86_SEV_VM, true);
>>> +	test_pre_fault_memory(KVM_X86_SEV_ES_VM, false);
>>> +	test_pre_fault_memory(KVM_X86_SEV_ES_VM, true);
>>> +	test_pre_fault_memory(KVM_X86_SNP_VM, false);
>>> +	test_pre_fault_memory(KVM_X86_SNP_VM, true);
>>> +
>>> +	return 0;
>>> +}
>>


