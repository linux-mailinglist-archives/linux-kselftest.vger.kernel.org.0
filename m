Return-Path: <linux-kselftest+bounces-6312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48C87B750
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 06:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E01F2320A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055F8F62;
	Thu, 14 Mar 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="poDjluEU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BAFC02;
	Thu, 14 Mar 2024 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394557; cv=fail; b=q78vwkbHG9taSwpGWdhB+3lz0DHHATszrAyYVuDQo7bKncBq/E9ftSLLwVlxoS1u8ST3MEHn+C88nQMraW/n96AiTJJ88IENQKDJWiW4yO3/+8ADN8S/7MXNYlceRnRZdYOelLH5twUiDaVDmuZFRzGN0YshgOurE8cNEwveoFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394557; c=relaxed/simple;
	bh=z8yYhDp/NMwb7/SYGa+aLCdMbTuXNShlfpx/qgQhr4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FKskRL3VyV8m3Cmy7mFOOMKi1OjoDDYUtW1f3gDlSifGS0fETLAbp+KAKV/BgVBKSdgREnTR1Pf8oArBpQFCqh8rN+HtLjsEzTz/a0Tt5yAVE1swnGHUd8zD7/3qxBwls28usRSrVdGUhNKAgCdVgdsKsRzHLW9Pe5qlBPw6iYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=poDjluEU; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJTV9K6t5KxX3UZb6Xfrv74/+yINkLy0avOkdI8xJ99PJzI0SCCe/XD+8wta4Q17zqK9RMemYCUfa1ue7T4AxZ1DTExtOlQ57rUJ7jeAjxmx7tK5K32azBEwUgY3YdgZiRKE/7/A4+Ax6vC7oIWRxGDuGjt+2DpCzh8BILXRBWlb94o8wtDLtSbXCqDrus653rU2YREUyQC8POFbCtkixWTzK6wbdMd3cFL9Rx4kH3n3VkayAlcEdkLZ7S4EsWaJZcAGh47KN3R7KvmaEf7UrRmYmgDpY9vzWAkAYnn/zjKjmqtoxpi/fGLOA/I4BM824zsARyIljdUDthPHgJvJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5l0DC2+krG6dOlNAl+kZ0w1LMhiaoY9OVqaxGRDWSU=;
 b=kE67RZewxE9Boh8phHKag4LZcU1eSFBulZSJ+0iLGVljj2ycb8iLxgw7+X+TePRo4WGhaWTl2tTk1PCGHp8d6IIz+r+MeOrjuQo309CTpKXQuWF0qKZLYRAN4RhZRaENQOAhX+rVHHmJzrt5v3K9uQl5tchxjkmauhWQaS3ecFKBeeo0i39JOMzZo6ekgYeIqH2wska//eWEawiw1BCC1mL83BAAZ9vBW7V0XCBMFmJZIjbGE0y1xmgP0OrFVIAukycwky8pOxuIpUYCGUTz1SOPlr+qZjrI3vl4/l1Y1uQvrP/OUQgz2ZBIqjmq+3Ygao2I0ue4LPiyAh+P+KuJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5l0DC2+krG6dOlNAl+kZ0w1LMhiaoY9OVqaxGRDWSU=;
 b=poDjluEUL0egGY/RLFvhK6jFKhUtCgXMHtms5l1RrAKwfj8BJgYi4ubZw9e/xlWTp99RGr4tB8h5XfZUQviDzXpTyICxGKjXvlmGKE7rhrNlh6ytdue+h/3cFS+PbXmr7Dfbs/EjLWMG8UsY2fwVbAmjWanQK+pJgIrctWWRuFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 05:35:52 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%5]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 05:35:51 +0000
Message-ID: <075ff472-67c7-4cb1-a344-9c1066821eb4@amd.com>
Date: Thu, 14 Mar 2024 11:05:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 5/5] selftests: KVM: SVM: Add Idle HLT intercept test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 Manali Shukla <manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
 <20240307054623.13632-6-manali.shukla@amd.com> <ZeoF2vfrUMCja0x7@google.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZeoF2vfrUMCja0x7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba4bf74-8286-42f9-cd0f-08dc43e89c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QDjN9Ih6UuWXLylSYhGXNu1xQ7+cSK4WzY60V/HaisZysPGNZJrqI66fCFHequEiWAKdmxxnae59/avyLpTQkim6NA05fGWsmA+zeNL/v8epizRS/3AWp55g+6NyEyagynvzMO2ErXg8diwopRS7AU7uZs5M8TL5K9FdoJ+eTrlmBEFYhO3EaaZot/c6S+rp6pf0N0jukeHV5pgqcoYeV/acMvKrn6LXtvtQDRXVnL7sTVlZuP99uAOb0HIemkCazPxD/ADrXfzBLZBRbI3gU/J5+ASZNhO1dGyNCXy4/ft6OuvjGA96JMSL+2/MEQX+cYj4WhEQ/GoVI/kKoicE1G9y2Nj3BEgJoMe2jfhJTGppLMBVrl+5+LPLvd0UBkobPJIC37J7gw8TdxP2iadSR0FSmIMAD/irPDppVova3Hzn38U6pXhnbltBuMay64ZT0IaIV0TjPZ6LAsPmt8n1A6eKIEzl1ZEwO+dfyIHpaJOco1xtb4lQlzT0WEEbFvjWmu20fvuONrroddrwYf9DTlcITlk7MTEO0D9diRmyZjVcolH94tvF4q6pjEb1bdEPBHksKTxm41yJgzfx7VaPPnND4o8USToiDPk98sW9KFq76I701UsOhkPD2CmT+Ipj7XSiXcPHyo9JAvYVGaqsWct/bmbXv/ywSny8lr30dpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0R5VERXMXdXUk1EeWw1d3l5UzcyUkxOYTYvdllqWWl4SHphWUNsTENoWEVD?=
 =?utf-8?B?SUZiZnp3NXJZcFdlN2V1TEY5SUhieGJRa0IxT0l2M0JXWVFrKzBwVVdiRHJ4?=
 =?utf-8?B?c0FxTjdWYzdxenN4ZDl3eVJtMDMxTHpvWkU4OEdGdTlJS296VHBVSWNVVytY?=
 =?utf-8?B?MU45bWlIeVJwM085eEU2V1YxbU05ZjBBQlYzUmVTeFdBbDE1blArUFdJY0c5?=
 =?utf-8?B?aG1zUDBMM0oxcTd4dzNnRmFScDZ0eUZrUkduT2NvclNMOUdwUWd2aWRPbmJR?=
 =?utf-8?B?OXhOcmJCSXhzZHM3Sm9UcmJlTGgrR01rbElTNjg2YURQZCtodnNXQWNxREs4?=
 =?utf-8?B?RGdNVU53S2gyaC9mZzVRZEN5Nm03Rm90UllsZXQreVBRbzlmdkNqenB1Zks0?=
 =?utf-8?B?ZzIvejRKODJ3K3owcTJWTnlRVFBBbTdwNDI0ajY3ZWI2NzIxb3ZPWFJveXo3?=
 =?utf-8?B?M3RJY2FyNmlhdllxZTd1bmhwWUUrRENOcGFCNjFYMEtUcUdHSUFITHRobC9M?=
 =?utf-8?B?cVpWQ0FIMUxNUVVNSkFuZ1Y4NDFXS2U2M3JYdjNIMnBrdGhVbC9TOEh2emlE?=
 =?utf-8?B?L2RUUllmWmE0NVpMekpnbGM0QnJyQnVtcEhuRjU1Qlc4c2hvSjNoR1hYcEFu?=
 =?utf-8?B?V3R0cDRrK1E2QzRrdlZQMXducStzcWJXTE5RVW1QaS84cG9IVVFtVzNPeW1a?=
 =?utf-8?B?Ly9uNkNBc1NBcnJHU2NsUTRNOWZudDRBZDFXOVh5cHVWSEVINUppeXRKNEo3?=
 =?utf-8?B?Nko2dVNkL2d6eTBYQ1RMNTdqZmNTT3VQd0lIaG5XT2FrTm9nRnNEc0VFL3I0?=
 =?utf-8?B?N1VtVlQxa3lzQkluNDYxOEJRNXhkN2lnQ25PZENJd2IydmlTckJITEFFMUt2?=
 =?utf-8?B?OFVoMHh0U3hxbjVZTzF6MmhrSWJpV0xtOWVBTlBaaktiNU5FbHJPZ3NtS0Z5?=
 =?utf-8?B?NTlqUlA5TVhkc3hrNlI3MUZNb0M1aHpRZFRtRGY1WCsvZ3h3d3hNdEVmalhE?=
 =?utf-8?B?azlPcFh3ZmNPUUlNaXFtdXJ1cFlzUldhQnpCaHNlSFJiWURIbXMyWFFsZzlH?=
 =?utf-8?B?T1FtR2lRcnZmM2JwRGtBRkRIbG1EZ2NsanJ3SnJjM3Q3REtJNzBvZWtOWWZi?=
 =?utf-8?B?dXJBdzhGMktZV2dIUDVzQnNoeGEyYzlmdHFiS1hjZ0VXcVZueDZvajZzVE90?=
 =?utf-8?B?SE9CRHBJUS82dHBOWXYzZjVuemRVcXh5NlBDMzAzOVZsRUEwNkxpUTJrR1k5?=
 =?utf-8?B?Q21RTFJ4QmFXaFJwUVRoWlhSMDRyUWFHYnJiUTNvZ2ZJdG5BQ0liTGZ6QnRX?=
 =?utf-8?B?V0c2MFhxaGM0d3d3UHEySzcySjRqVE5lVmFDajdZc1p4bm9uU09VYStmenJn?=
 =?utf-8?B?OEg2bmI0UmMycUNBWUVzNFF2ZENoT3ZUMnI2VThrcjNneWFNQ0ZzYktYdXlu?=
 =?utf-8?B?NDFDMUkxKzdDVU5YNzVGRmExZzg4K2MyS3JsZGd6ZWJTcXBuWlk2VmJHQW5v?=
 =?utf-8?B?V0xlK29Hb0ZqU2RQckpsWlRxZG5nN2VUNmV4M0ZVOWdMSXQrLzBtRGlIeGc5?=
 =?utf-8?B?cUNmb3pOaW54K1Y1NlBhdDNITDNYUlFRNnhVQWpFTW05NEIyNXhML3ZiODFN?=
 =?utf-8?B?NkFralMvS25Wa251ZDlOODdGRkpPWkViYm9LQkd3YWllQmRneWdlS3dMODBn?=
 =?utf-8?B?RjN5ZUw3YVNDamc5S3k2MklyaEY5VHI1eDJBVjQ5TTdGMnFmR256MEs4a0xt?=
 =?utf-8?B?dnd3RjNZbTFPZ0Z6YXJwUmh1T2QyMk9yeGZBa0JXQVJ2QVlhdVFmbWNzZ3FO?=
 =?utf-8?B?ZVFCbkFYc0hNZ0kyVlhCWjEzL25VMEVGUEdqSWxRdjVidDNaNWxvTEFWbSsv?=
 =?utf-8?B?NEhMK2lnNGJDalFEcEVKcnp1aGtDZ24rcVhUQ01YbEJrcTl5dGtYdnFyY2hS?=
 =?utf-8?B?MHNhMWdFdW92RzZ6ZjdORUZWUXNkUU9zd1V5UlZBZWZVdXp1VjdCV1ROcWF2?=
 =?utf-8?B?aGpMME83ejdvNERzdXcrQm9Jc1pmNjAyRjNwd2p4eUxoY2ZyazZOTHpmL09H?=
 =?utf-8?B?L0RadnlydjlNOVFWYmhZUkorazFJUFdYZVpTcENodWppMG1JZHMvZ0RVdms2?=
 =?utf-8?Q?fNbw0z3A9JjmZIdwwZ94/4Pym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba4bf74-8286-42f9-cd0f-08dc43e89c63
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 05:35:51.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8FoUI3fjRVV4vjY/oI7AqoSUIzjJNFdbVzevweEMLBeX7Sn4tF7mt6eSMWDbAgz3qrH5ZdM/6j6EkmjEIdDuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

Hi Sean,

Thank you for reviewing my patches.

On 3/7/2024 11:52 PM, Sean Christopherson wrote:
> On Thu, Mar 07, 2024, Manali Shukla wrote:
>> From: Manali Shukla <Manali.Shukla@amd.com>
>>
>> The Execution of the HLT instruction results in a VMEXIT. Hypervisor
>> observes pending V_INTR and V_NMI events just after the VMEXIT
>> generated by the HLT for the vCPU and causes VM entry to service the
>> pending events.  The Idle HLT intercept feature avoids the wasteful
>> VMEXIT during the halt if there are pending V_INTR and V_NMI events
>> for the vCPU.
>>
>> The selftest for the Idle HLT intercept instruments the above-mentioned
>> scenario.
>>
>> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../selftests/kvm/x86_64/svm_idlehlt_test.c   | 118 ++++++++++++++++++
>>  2 files changed, 119 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 492e937fab00..7ad03dc4f35e 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/svm_idlehlt_test
> 
> Uber nit, maybe svm_idle_hlt_test?  I find "idlehlt" hard to parse.
Sure I will change it to svm_idle_hlt_test.

> 
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
>> new file mode 100644
>> index 000000000000..1564511799d4
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  svm_idlehalt_test
>> + *
> 
> Please omit this, file comments that state the name of the test inevitably
> become stale (see above).

Sure. I will remove it.
> 
>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + *
>> + *  For licencing details see kernel-base/COPYING
> 
> This seems gratuitous, doesn't the SPDX stuff take care this?

Agreed, I will remove this.

> 
>> + *
>> + *  Author:
>> + *  Manali Shukla  <manali.shukla@amd.com>
>> + */
>> +#include "kvm_util.h"
>> +#include "svm_util.h"
>> +#include "processor.h"
>> +#include "test_util.h"
>> +#include "apic.h"
>> +
>> +#define VINTR_VECTOR     0x30
>> +#define NUM_ITERATIONS 100000
> 
> What's the runtime?  If it's less than a second, then whatever, but if it's at
> all longer than that, then I'd prefer to use a lower default and make this user-
> configurable.

It takes ~34s to run this test. 
> 
>> +/*
>> + * Incremented in the VINTR handler. Provides evidence to the sender that the
>> + * VINR is arrived at the destination.
> 
> Evidence is useless if there's no detective looking for it.  Yeah, it gets
> printed out in the end, but in reality, no one is going to look at that.
> 
> Rather than read this from the host, just make it a non-volatile bool and assert
> that it set after every 
> 

Sure. I can do that.

>> + */
>> +static volatile uint64_t vintr_rcvd;
>> +
>> +void verify_apic_base_addr(void)
>> +{
>> +	uint64_t msr = rdmsr(MSR_IA32_APICBASE);
>> +	uint64_t base = GET_APIC_BASE(msr);
>> +
>> +	GUEST_ASSERT(base == APIC_DEFAULT_GPA);
>> +}
>> +
>> +/*
>> + * The halting guest code instruments the scenario where there is a V_INTR pending
>> + * event available while hlt instruction is executed. The HLT VM Exit doesn't
>> + * occur in above-mentioned scenario if the Idle HLT intercept feature is enabled.
>> + */
>> +
>> +static void halter_guest_code(void)
> 
> Just "guest_code()".  Yeah, it's a weird generic name, but at this point it's so
> ubiquitous that it's analogous to main(), i.e. readers know that guest_code() is
> the entry point.  And deviating from that suggests that there is a second vCPU
> running _other_ guest code (otherwise, why differentiate?), which isn't the case.
> 

Sure.

>> +{
>> +	uint32_t icr_val;
>> +	int i;
>> +
>> +	verify_apic_base_addr();
> 
> Why?  The test will fail if the APIC is borked, this is just unnecessary noise
> that distracts readers.
> 
> Sure. I will remove it in V2.

>> +	xapic_enable();
>> +
>> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
>> +
>> +	for (i = 0; i < NUM_ITERATIONS; i++) {
>> +		xapic_write_reg(APIC_ICR, icr_val);
>> +		asm volatile("sti; hlt; cli");
> 
> Please add safe_halt() and cli() helpers in processor.h.  And then do:
> 
> 		cli();
> 		xapic_write_reg(APIC_ICR, icr_val);
> 		safe_halt();
> 
> to guarantee that interrupts are disabled when the IPI is sent.  And as above,
> 
> 		GUEST_ASSERT(READ_ONCE(irq_received));
> 		WRITE_ONCE(irq_received, false);
> 

Sure.
>> +	}
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_vintr_handler(struct ex_regs *regs)
>> +{
>> +	vintr_rcvd++;
>> +	xapic_write_reg(APIC_EOI, 0x30);
> 
> EOI is typically written with '0', not the vector, because the legacy EOI register
> clears the highest ISR vector, not whatever is specified.  IIRC, one of the Intel
> or AMD specs even says to use '0'.
> 
> AMD's Specific EOI register does allow targeting a specific vector, but that's
> not what's being used here.

Sure.
> 
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +	struct ucall uc;
>> +	uint64_t  halt_exits, vintr_exits;
>> +	uint64_t *pvintr_rcvd;
>> +
>> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> 
> No, this test doesn't require SVM, which is KVM advertising *nested* SVM.  This
> test does require idle-hlt support though...

Sure. I will add it in V2.

> 
>> +	/* Check the extension for binary stats */
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, halter_guest_code);
>> +
>> +	vm_init_descriptor_tables(vm);
>> +	vcpu_init_descriptor_tables(vcpu);
>> +	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
>> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
>> +
>> +	vcpu_run(vcpu);
>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>> +
>> +	halt_exits = vcpu_get_stat(vcpu, "halt_exits");
> 
> Is there really no way to get binary stats without having to pass in strings?

I could see one of the test case is passing the strings to get binary stats of
vm. That is why I used strings to get binary stats of vcpu. I will try to find another
way to get the binary stats.

> 
>> +	vintr_exits = vcpu_get_stat(vcpu, "irq_window_exits");
>> +	pvintr_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)&vintr_rcvd);
>> +
>> +	switch (get_ucall(vcpu, &uc)) {
>> +	case UCALL_ABORT:
>> +		REPORT_GUEST_ASSERT(uc);
>> +		/* NOT REACHED */
> 
> Eh, just put a "break;" here and drop the comment.
> 
Sure.

>> +	case UCALL_DONE:
>> +		goto done;
> 
> break;
> 
>> +	default:
>> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>> +	}
>> +
>> +done:
>> +	TEST_ASSERT(halt_exits == 0,
> 
> So in all honesty, this isn't a very interesting test.  It's more of a CPU test
> than a KVM test.  I do think it's worth adding, because why not.
> 
> But I'd also like to see a testcase for KVM_X86_DISABLE_EXITS_HLT.  It would be
> a generic test, i.e. not specific to idle-hlt since there is no dependency and
> the test shouldn't care.  I _think_ it would be fairly straightforward: create
> a VM without an in-kernel APIC (so that HLT exits to userspace), disable HLT
> interception, send a signal from a different task after some delay, and execute
> HLT in the guest.  Then verify the vCPU exited because of -EINTR and not HLT.

I will create this test.
> 
>> +		    "Test Failed:\n"
>> +		    "Guest executed VINTR followed by halts: %d times\n"
>> +		    "The guest exited due to halt: %ld times and number\n"
>> +		    "of vintr exits: %ld and vintr got re-injected: %ld times\n",
>> +		    NUM_ITERATIONS, halt_exits, vintr_exits, *pvintr_rcvd);
> 
> I appreciate the effort to provide more info, but this is way too noisy.  If
> anything, print gory details in a pr_debug() *before* the assert (see below),
> and then simply do:
> 
> 	TEST_ASSERT_EQ(halt_exits, 0);
> 
Sure.

>> +	fprintf(stderr,
>> +		"Test Successful:\n"
>> +		"Guest executed VINTR followed by halts: %d times\n"
>> +		"The guest exited due to halt: %ld times and number\n"
>> +		"of vintr exits: %ld and vintr got re-injected: %ld times\n",
>> +		NUM_ITERATIONS, halt_exits, vintr_exits, *pvintr_rcvd);
> 
> And this should be pr_debug(), because no human is going to look at this except
> when the test isn't working correctly.

I will change it to pr_debug() in V2.
> 
>> +
>> +	kvm_vm_free(vm);
>> +	return 0;
>> +}
>> -- 
>> 2.34.1
>> /pvintr_rcvd
> 


