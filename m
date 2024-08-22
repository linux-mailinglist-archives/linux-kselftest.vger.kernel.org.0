Return-Path: <linux-kselftest+bounces-16112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E895BBFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00335B213FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D81CCED5;
	Thu, 22 Aug 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cPfwhELY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C43282FC;
	Thu, 22 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344330; cv=fail; b=Q+8jxJ+q4jSV3s9+k532bTgLL+Gtw+DPMmBn+Y9Q7N80bu3HzAfIqmyB8mm+dUUtulUUxubnwxes5vJneXb/PUUnnN9Gb/t4VaJLydZPFOrfcykjAhchCihoRWUPeDs/nMhc+ZApLkNAu4RAOWgmboOtU8p+Wr9GiPGSBv2cUEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344330; c=relaxed/simple;
	bh=lwY+jG3lJRVNXtoEoxUvc4EDYm8cR7A4eGjnEXzCMrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RvPeHAFChBrwRkEjXY4SZO/PDnfjK2fgLTX7y+Jb/yVJCtrqAgfJQJtWnHnSKn6a1oUPGJixrUJjff/CiKYa59SQST86iJfYLHIE93wylupn8Ch1okrH/6n6ztrhnJjt6YidcaMweCCrOVkRzB6zip218ECTVBRLZS9tog+8tas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cPfwhELY; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZaQ7PFDVeVa3XyO92otXg1aHXTHgPhPoXLKD8Rm0ksmo7Q3P2+vvKLOw5K3ah16A0Hvf7NKuomd/dJiBivApRLJQS8WuIRZ5tQybUldZCAWJhYxQ675Pyneu8bn7vh5jmS7dmJuNXF8HX5kKpglg7jUfyAqu4c6sWqYlMyKON7Nnsiz+lLpvieaFIhp8DOrFGCPWdqypCMxq9qHNQAxXvnDaNsaAIxGoumgC+DRnPr3RhLqRiGtx3RhSm3dktete34wMR+RLqslm6/Oy9HuQWk4rkdKQ6BXokWTwnIup9vfX0f//lT52Xf84Im1kvf4TOb1vKJsfK6WLd6rRRVccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8H1fOQPDLdTnOsXgRh/BkThRnzW3N3HPDN35VhlHzI=;
 b=n681KoY1Bs2sCizpNRM1CnZYOIArN6x25Zrkr7yYIorZbWsiCId9lb9Y5IoePQxBkCGNmwHWdwbMQ4L8EPfb9XNelyhu1xNqOUJOErCWfctnmP2S4i/+NC1gibP4P4De7GU9YzqDyhOZRPXscigGElQxwO/BaFLi+/A0zrSETHJ1BJmqCo3g2hS5X7/1yDJ/triky8qdeYZWM/Z9IYBxgskuMPIBkRF+XMnSA0E5ZucHBrYGnDM+yiNS+ESmKr1PA0m+QAhUS+ZWQZDxblD6L5++cdCy/uuu3xHFOpO2D2fLim4+KMyhRDOTOsQhoaf1IiF2ximhZK7C8JK+7nwqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8H1fOQPDLdTnOsXgRh/BkThRnzW3N3HPDN35VhlHzI=;
 b=cPfwhELYZU4utm2yBEMfcYQI+P+9yb7Pz2cm864/AEsQEqfRDu+atuqc1GSczvRbc82xS7zOXaQCxe71ceLoziJ6Gs0GRccl6KGhRb10+N7M+uEPf8V0oOAxN6pyej6lVWqpp/nbuIUJZcvpfCYEvOjnh9lpXBr2ZG8IyRebcR8=
Received: from SN7PR04CA0179.namprd04.prod.outlook.com (2603:10b6:806:125::34)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 16:32:05 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::d8) by SN7PR04CA0179.outlook.office365.com
 (2603:10b6:806:125::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 16:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 16:32:05 +0000
Received: from [10.236.31.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 11:32:04 -0500
Message-ID: <05e8d2ae-e978-44b0-b433-b72f38aed60e@amd.com>
Date: Thu, 22 Aug 2024 11:32:04 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] KVM: selftests: Add a CoCo-specific test for
 KVM_PRE_FAULT_MEMORY
To: "Aithal, Srikanth" <sraithal@amd.com>, <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
 <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
 <2996bcee-4687-4822-a5a0-e83d89301477@amd.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <2996bcee-4687-4822-a5a0-e83d89301477@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 685310b1-f643-4d0b-7ad3-08dcc2c7f59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFRpZ3hQNDJtUStLNmRYd0lkSzVGWVJleWpVWFJ2ajJmT2I2WmpxMFNXeHBT?=
 =?utf-8?B?UGdVTUlTYmtKNW5IU21hcTlrSXFXM3NOYWhXTU1seTcrcW1IVDVVcHhQYjBV?=
 =?utf-8?B?S1hBV2prVVUxU0RyRWJuTE81dGlIVzAycnJ2eHJReFE4S1liMkVtMy84N3hX?=
 =?utf-8?B?VGdUZFZMcXZRNlJUd3ZYbHB6SFFraVNETkVTd1MwUGxwaExjRFEvbUllNGJV?=
 =?utf-8?B?VkVHb1YrWE4wTFZ1a2lQdGpxdjNubEtpNDlKTysvZm5nVG9PL2xFSlhjdlV6?=
 =?utf-8?B?K09pT1ZLYkhheE1mZXNhS1NaK2pXMi9PT3FweWNqV1BBRzczdDZ0SXBJc2Ja?=
 =?utf-8?B?K3YzZ2JuRnptclBaZnVYTndmZUE4Y0lZZnpSM2gwaFVwWCtnM3ZlVGlnMXph?=
 =?utf-8?B?RWszdEExR3I5RDhIZ0p1MUJwQm12Q3lYVEx3QzREaFlIT2tIUDNZZVFlMW4z?=
 =?utf-8?B?aWxjNkdxaGtsS3N4K1dkcnlaa3FQZ2ZuV1V5cy8xMGRoOVVHMHliS25nQjRK?=
 =?utf-8?B?NlU3aDMvM2pYTFErS0UvcFB5Ris3MG80N1E4SFZmK2dwdUxhcEtJTTUxYUxp?=
 =?utf-8?B?Z2Zrd3M1S3dsNkFyQmE3elQzWml6blZQT1Jyb1ZzcnE1Mkx3T2s0RUErSzli?=
 =?utf-8?B?ZDBXa2g3a1Y3NTkrT1dyTHI5cEx1ZjJIUGxPeFpNMkx4dWh6WDJBWFQrUlhK?=
 =?utf-8?B?dlZubFpOVVJnQmUvQzd4ZnFpdmpmR0pmSkJ1akZtZzl2UWdRczhGaTZTQlMx?=
 =?utf-8?B?WTZ2Y2h2SXhLQklqMys0T1NyQnYydWF6eVVOdkhzWm1NVWQ4aFpnZ3NyUWkw?=
 =?utf-8?B?eS9kS3ZEbzMyR09mZFltdmpIVCt2aVBwd2kvbW8rNmFYWU5MNHF6MllXQXUr?=
 =?utf-8?B?NWFiUDY4VmRUbTh4T0dabWpDZ2RScitLaCtMNC9nMFdueEl3UnRXYmdKZVVH?=
 =?utf-8?B?SHRtRjlCbTVKdDFXbVlwMUpJNjFINkVabDdsMXRXdzRSMjNqZFJUaGh0RXZY?=
 =?utf-8?B?OHcrQlZDcjA1TGxid0RoaHp2bTkxK0tpVUdEUWVlV1N5OWJGbUVicndPYjhz?=
 =?utf-8?B?T29DL1ZXOGZWSXlYMG5ucVN4T0dEMjl1TzVlcVZGYWlUY1BxSkxuQ3U4YzFL?=
 =?utf-8?B?T2VJMXVubWJYUkZjSU4zck92d3RVVk1PYzlKeXNFcDVVRkxvYlI0Uk4wN0s5?=
 =?utf-8?B?R0txQXI1L1hDUUwyQmhRekozL3JhZUczSlEvWmlEZFd0dWtSeS9KMDVWMVFN?=
 =?utf-8?B?UHdzWFVXSFM1OUtCT1hhMSt4aitrblBGa0ZCRlpZa2dNaDJsTTVLT1o3Ukhq?=
 =?utf-8?B?U0tYU3RCaTUwYk8vSlNqbm1YVytRUlZVaXBsK3crelZyaHZKR3dHTTgxUHFh?=
 =?utf-8?B?bVhRRGtyVmhWbUxSZ2kvSnJIQkhPUm04TGhDUzNjeUwwcGpSbzl4alNuY01X?=
 =?utf-8?B?Mm55NXFXRzRXV1FsYW1YQTl3OGFHcjdEU21MdmNmV1pMdHI2WEhibS8vNkIy?=
 =?utf-8?B?YTRpSXNvdjdiVjFicU5tZHFLRE9zdzRRSEErZEVNTS9mNE5Gek5WeVJIaVVR?=
 =?utf-8?B?VEx1VEpnY3dmSEc1ZUMzMkdrT3VKMDVpZGRCRDNvS1VrMktBZzlRNGNnRitF?=
 =?utf-8?B?THRTaDZ5UVZpZ0xBTk9QWGFsZExnTXJMTHY1aE4rSHZQSVl6R1JDdi9yZ1ZK?=
 =?utf-8?B?dHhLRUFJaW11OC92d0tLUVBja3dsMm5pRmNhTEMzNGh5RWdHVlUrMFpxOFFE?=
 =?utf-8?B?MFQ0SEMvTS9lMjdjSDl0RUdCZ29ReW4zQzVUdXZaT0RzR0U4aXlHUStLV1dq?=
 =?utf-8?B?bW81M3pJTnhBMU14bDY1Nk1TejZzZkQvNnlzTG5rVFZFQlBSU1kzY3hlSnZq?=
 =?utf-8?B?SFc1VSttcUpLbGVwZ1o0VE1zTWM3bnpPMEN3VzI3SjJDV3FhbllUT0xHY0tP?=
 =?utf-8?Q?enyMPh3pOCfk0EXR4Zy1STA7WiIEA4jK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:32:05.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685310b1-f643-4d0b-7ad3-08dcc2c7f59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410



On 8/20/2024 1:24 AM, Aithal, Srikanth wrote:
> On 8/17/2024 12:53 AM, Pratik R. Sampat wrote:
>> From: Michael Roth <michael.roth@amd.com>
>>
>> SEV, SEV-ES, and SNP have a few corner cases where there is potential
>> for KVM_PRE_FAULT_MEMORY to behave differently depending on when it is
>> issued during initial guest setup. Exercising these various paths
>> requires a bit more fine-grained control over when the
>> KVM_PRE_FAULT_MEMORY requests are issued while setting up the guests.
>>
>> Since these CoCo-specific events are likely to be architecture-specific
>> KST helpers, take the existing generic test in pre_fault_memory_test.c
>> as a starting template, and then introduce an x86-specific version of
>> it with expanded coverage for SEV, SEV-ES, and SNP.
>>
>> Since there's a reasonable chance that TDX could extend this for similar
>> testing of TDX, give it a "coco-" prefix rather than an SEV-specific
>> one.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> Co-developed-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile          |   1 +
>>   .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
>>   2 files changed, 315 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/x86_64/
>> coco_pre_fault_memory_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/
>> selftests/kvm/Makefile
>> index 48d32c5aa3eb..65d19b277b06 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
>>   TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
>>   TEST_GEN_PROGS_x86_64 += demand_paging_test
>>   TEST_GEN_PROGS_x86_64 += dirty_log_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/
>> coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/
>> coco_pre_fault_memory_test.c
>> new file mode 100644
>> index 000000000000..e16fe185fb5a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>> @@ -0,0 +1,314 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/sizes.h>
>> +
>> +#include <test_util.h>
>> +#include <kvm_util.h>
>> +#include <processor.h>
>> +#include "sev.h"
>> +
>> +/* Arbitrarily chosen values */
>> +#define TEST_SIZE        (SZ_2M + PAGE_SIZE)
>> +#define TEST_NPAGES        (TEST_SIZE / PAGE_SIZE)
>> +#define TEST_SLOT        10
>> +#define TEST_GPA        0x100000000ul
>> +#define TEST_GVA        0x100000000ul
>> +
>> +enum prefault_snp_test_type {
>> +    /* Skip pre-faulting tests. */
>> +    NO_PREFAULT_TYPE = 0,
>> +    /*
>> +     * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping non-private memory
>> +     * before finalizing the initial guest contents (e.g. via
>> +     * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>> +     *
>> +     * This should result in failure since KVM explicitly disallows
>> +     * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
>> +     * initial guest contents.
>> +     */
>> +    PREFAULT_SHARED_BEFORE_FINALIZING = 0,
>> +    /*
>> +     * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping private memory
>> +     * before finalizing the initial guest contents (e.g. via
>> +     * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>> +     *
>> +     * This should result in failure since KVM explicitly disallows
>> +     * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
>> +     * initial guest contents.
>> +     */
>> +    PREFAULT_PRIVATE_BEFORE_FINALIZING,
>> +    /*
>> +     * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping shared/private
>> +     * memory after finalizing the initial guest contents
>> +     * (e.g. via * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>> +     *
>> +     * This should succeed since pre-faulting is supported for both
>> +     * non-private/private memory once the guest contents are finalized.
>> +     */
>> +    PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
>> +};
>> +
>> +static void guest_code_sev(void)
>> +{
>> +    int i;
>> +
>> +    GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
>> +
>> +    for (i = 0; i < TEST_NPAGES; i++) {
>> +        uint64_t *src = (uint64_t *)(TEST_GVA + i * PAGE_SIZE);
>> +        uint64_t val = *src;
>> +
>> +        /* Validate the data stored in the pages */
>> +        if ((i < TEST_NPAGES / 2 && val != i + 1) ||
>> +            (i >= TEST_NPAGES / 2 && val != 0)) {
>> +            GUEST_FAIL("Inconsistent view of memory values in guest");
>> +        }
>> +    }
>> +
>> +    if (rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED) {
>> +        wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
>> +        __asm__ __volatile__("rep; vmmcall");
>> +        GUEST_FAIL("This should be unreachable.");
>> +    }
>> +
>> +    GUEST_DONE();
>> +}
>> +
>> +static void __pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
>> +                   u64 left, bool expect_fail)
>> +{
>> +    struct kvm_pre_fault_memory range = {
>> +        .gpa = gpa,
>> +        .size = size,
>> +        .flags = 0,
>> +    };
>> +    int ret, save_errno;
>> +    u64 prev;
>> +
>> +    do {
>> +        prev = range.size;
>> +        ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
>> +        save_errno = errno;
>> +        TEST_ASSERT((range.size < prev) ^ (ret < 0),
>> +                "%sexpecting range.size to change on %s",
>> +                ret < 0 ? "not " : "",
>> +                ret < 0 ? "failure" : "success");
>> +    } while (ret >= 0 ? range.size : save_errno == EINTR);
>> +
>> +    TEST_ASSERT(expect_fail ? !(range.size == left) : (range.size ==
>> left),
>> +            "[EXPECT %s] completed with %lld bytes left, expected %"
>> PRId64,
>> +            expect_fail ? "FAIL" : "PASS",
>> +            range.size, left);
>> +
>> +    if (left == 0) {
>> +        TEST_ASSERT(expect_fail ? ret : !ret,
>> +                "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
>> +                expect_fail ? "FAIL" : "PASS");
>> +    } else {
>> +        /*
>> +         * For shared memory, no memory slot causes RET_PF_EMULATE. It
>> +         * results in -ENOENT.
>> +         *
>> +         * For private memory, no memory slot is an error case returning
>> +         * -EFAULT, but it also possible the only the GPA ranges backed
>> +         *  by a slot are marked as private, in which case the noslot
>> +         *  range will also result in -ENOENT.
>> +         *
>> +         *  So allow both errors for now, but in the future it would be
>> +         *  good to distinguish between these cases to tighten up the
>> +         *  error-checking.
>> +         */
>> +        TEST_ASSERT(expect_fail ? !ret :
>> +                (ret && (save_errno == EFAULT || save_errno == ENOENT)),
>> +                "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
>> +                expect_fail ? "FAIL" : "PASS");
>> +    }
>> +}
>> +
>> +static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa,
>> +                 u64 size, u64 left)
>> +{
>> +    __pre_fault_memory(vcpu, gpa, size, left, false);
>> +}
>> +
>> +static void pre_fault_memory_negative(struct kvm_vcpu *vcpu, u64 gpa,
>> +                      u64 size, u64 left)
>> +{
>> +    __pre_fault_memory(vcpu, gpa, size, left, true);
>> +}
>> +
>> +static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm
>> *vm,
>> +                 bool private, enum prefault_snp_test_type p_type)
>> +{
>> +    if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +        pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +
>> +    snp_vm_launch_start(vm, SNP_POLICY);
>> +
>> +    if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +        pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +
>> +    if (private) {
>> +        /*
>> +         * Make sure when pages are pre-faulted later after
>> +         * finalization they are treated the same as a private
>> +         * access by the guest so that the expected gmem
>> +         * backing pages are used.
>> +         */
>> +        vm_mem_set_private(vm, TEST_GPA, TEST_SIZE);
>> +        if (p_type == PREFAULT_PRIVATE_BEFORE_FINALIZING)
>> +            pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +    } else {
>> +        if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +            pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +    }
>> +
>> +    snp_vm_launch_update(vm);
>> +
>> +    if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +        pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +
>> +    snp_vm_launch_finish(vm);
>> +
>> +    /*
>> +     * After finalization, pre-faulting either private or shared
>> +     * ranges should work regardless of whether the pages were
>> +     * encrypted as part of setting up initial guest state.
>> +     */
>> +    if (p_type == PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING) {
>> +        pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +        pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2,
>> PAGE_SIZE);
>> +        pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE,
>> PAGE_SIZE);
>> +    }
>> +}
>> +
>> +static void pre_fault_memory_sev(unsigned long vm_type, struct
>> kvm_vcpu *vcpu,
>> +                 struct kvm_vm *vm)
>> +{
>> +    uint32_t policy = (vm_type == KVM_X86_SEV_ES_VM) ?
>> SEV_POLICY_ES : 0;
>> +
>> +    pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +    pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +    pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +
>> +    sev_vm_launch(vm, policy);
>> +
>> +    pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +    pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +    pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +
>> +    sev_vm_launch_measure(vm, alloca(256));
>> +
>> +    pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +    pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +    pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +
>> +    sev_vm_launch_finish(vm);
>> +
>> +    pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +    pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +    pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +}
>> +
>> +static void test_pre_fault_memory_sev(unsigned long vm_type, bool
>> private,
>> +                      enum prefault_snp_test_type p_type)
>> +{
>> +    struct kvm_vcpu *vcpu;
>> +    struct kvm_vm *vm;
>> +    struct ucall uc;
>> +    int i;
>> +
>> +    vm = vm_sev_create_with_one_vcpu(vm_type, guest_code_sev, &vcpu);
>> +
>> +    vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
>> +                    TEST_GPA, TEST_SLOT, TEST_NPAGES,
>> +                    (vm_type == KVM_X86_SNP_VM) ?
>> KVM_MEM_GUEST_MEMFD : 0);
>> +
>> +    /*
>> +     * Make sure guest page table is in agreement with what pages
>> will be
>> +     * initially encrypted by the ASP.
>> +     */
>> +    if (private)
>> +        vm_mem_set_protected(vm, TEST_SLOT, TEST_GPA, TEST_NPAGES);
>> +
>> +    virt_map(vm, TEST_GVA, TEST_GPA, TEST_NPAGES);
>> +
>> +    /*
>> +     * Populate the pages to compare data read from the guest
>> +     * Populate the first half with data and second half as all zeros.
>> +     */
>> +    for (i = 0; i < TEST_NPAGES; i++) {
>> +        uint64_t *hva = addr_gva2hva(vm, TEST_GVA + i * PAGE_SIZE);
>> +
>> +        if (i < TEST_NPAGES / 2)
>> +            *hva = i + 1;
>> +        else
>> +            *hva = 0;
>> +    }
>> +
>> +    if (vm_type == KVM_X86_SNP_VM)
>> +        pre_fault_memory_snp(vcpu, vm, private, p_type);
>> +    else
>> +        pre_fault_memory_sev(vm_type, vcpu, vm);
>> +
>> +    vcpu_run(vcpu);
>> +
>> +    if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
>> +        TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
>> +                "Wanted SYSTEM_EVENT, got %s",
>> +                exit_reason_str(vcpu->run->exit_reason));
>> +        TEST_ASSERT_EQ(vcpu->run->system_event.type,
>> KVM_SYSTEM_EVENT_SEV_TERM);
>> +        TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
>> +        TEST_ASSERT_EQ(vcpu->run->system_event.data[0],
>> GHCB_MSR_TERM_REQ);
>> +        goto out;
>> +    }
>> +
>> +    switch (get_ucall(vcpu, &uc)) {
>> +    case UCALL_DONE:
>> +        break;
>> +    case UCALL_ABORT:
>> +        REPORT_GUEST_ASSERT(uc);
>> +    default:
>> +        TEST_FAIL("Unexpected exit: %s",
>> +              exit_reason_str(vcpu->run->exit_reason));
>> +    }
>> +
>> +out:
>> +    kvm_vm_free(vm);
>> +}
>> +
>> +static void test_pre_fault_memory(unsigned long vm_type, bool private)
>> +{
>> +    int pt;
>> +
>> +    if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
>> +        pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
>> +        return;
>> +    }
>> +
>> +    switch (vm_type) {
>> +    case KVM_X86_SEV_VM:
>> +    case KVM_X86_SEV_ES_VM:
>> +        test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE);
>> +        break;
>> +    case KVM_X86_SNP_VM:
>> +        for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING;
>> pt++)
>> +            test_pre_fault_memory_sev(vm_type, private, pt);
>> +        break;
>> +    default:
>> +        abort();
>> +    }
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
>> +
>> +    test_pre_fault_memory(KVM_X86_SEV_VM, false);
>> +    test_pre_fault_memory(KVM_X86_SEV_VM, true);
>> +    test_pre_fault_memory(KVM_X86_SEV_ES_VM, false);
>> +    test_pre_fault_memory(KVM_X86_SEV_ES_VM, true);
>> +    test_pre_fault_memory(KVM_X86_SNP_VM, false);
>> +    test_pre_fault_memory(KVM_X86_SNP_VM, true);
>> +
>> +    return 0;
>> +}
> 
> Hello Pratik,
> I see below failure while running this test [kvm-x86/next + mentioned
> patches]:
> 
> # selftests: kvm: coco_pre_fault_memory_test
> # Random seed: 0x6b8b4567
> # ==== Test Assertion Failure ====
> #   x86_64/coco_pre_fault_memory_test.c:145: expect_fail ? !(range.size
> == left) : (range.size == left)
> #   pid=202665 tid=202665 errno=9 - Bad file descriptor
> #      1        0x0000000000402870: __pre_fault_memory at
> coco_pre_fault_memory_test.c:145
> #      2        0x00000000004031c9: pre_fault_memory_negative at
> coco_pre_fault_memory_test.c:184
> #      3         (inlined by) pre_fault_memory_snp at
> coco_pre_fault_memory_test.c:202
> #      4         (inlined by) test_pre_fault_memory_sev at
> coco_pre_fault_memory_test.c:344
> #      5        0x00000000004033c0: test_pre_fault_memory at
> coco_pre_fault_memory_test.c:401 (discriminator 3)
> #      6        0x00000000004024d7: main at
> coco_pre_fault_memory_test.c:417 (discriminator 2)
> #      7        0x00007f9474829d8f: ?? ??:0
> #      8        0x00007f9474829e3f: ?? ??:0
> #      9        0x0000000000402574: _start at ??:?
> #   [EXPECT FAIL] completed with 0 bytes left, expected 0
> not ok 66 selftests: kvm: coco_pre_fault_memory_test # exit=254
> 

Hi Srikanth,

Thanks for testing these patches.

I believe that you may have to test these patches either over the
kvm-x86/fixes branch or over kvm/[queue/next] since there are a few
fixes (eg. KVM: x86: disallow pre-fault for SNP VMs before
initialization, etc.) which are not present in kvm-x86/next.

Do let me know if that works for you instead for the tests?

Thanks!
Pratik
> 
> 


