Return-Path: <linux-kselftest+bounces-6933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA77893815
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 07:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610711C20AA8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 05:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3578C1D;
	Mon,  1 Apr 2024 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QO0gxodT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2131.outbound.protection.outlook.com [40.107.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D31C0DD3;
	Mon,  1 Apr 2024 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711949330; cv=fail; b=VxqZRbhOd5N0IhtiMLGbDrzLS6cKjDs1jwVszs5Ku8lEPmizPowGkU0hfKJJCvNBblrBCFT1pxarwpwAfJNZsW8N2gmnKKZk7KF4g+O1AAcG9Cy0hEBOJo2bCUhoxzdjU0XehFTzOzRkWAFR39wzhCclzFpF7vSy8WeLYM3pCdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711949330; c=relaxed/simple;
	bh=JAaBtA0Oxt3mABjyHCPU7QXFZ1I+oQxeliLLPmf943E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mcAdQZEIRLfCGNXZilTSFRsqSGcz+zJzto+b7WWLah+KgPYCQWIvqeqhAKOMIvYhmabdhr/DqM6c+aGKuswODlFWMkn0Ca+QxqC9ehwrXF2wtkvVJBCFGMoCapwqMoAPIOQZ+Z5NgEvg9PhdspSmXT3yEkT8rgZjt03CJlMSigM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QO0gxodT; arc=fail smtp.client-ip=40.107.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMnLWOhP5yHQ0wxpmKeYl71Bps6LnpnS594PsqMwiwR2LAe4gPjpKqDItcE3H9FbqpDZc8823Id2K8v57OMl2wY3d+SpRTjIWjMiCiEqnEsyIgjlffnQvAxdyHEz6Q1CDr6DBLViGb/x2vg5bRnFZrInrzypZiL8A4nyUo+Xl1g+Cb7LS2FIISmkuc3YTMsUQ/Q02ZaqnPuAfcCmc5xC2If/S3Lvpm3CryilwZ+xDWoT4rO00A9hQZ+7g6kXy2BxaKCBdwXici7xUOA4oVCeA6c4N/3bs8BH0njQ/PRoDaQc88oKYcuzUfR7WHNmU4mh2vx6ibNt9mjNeESh2ij8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z4RAHVWU2vt5tQSIhTVKASopLjqKu7Qgqpsh3DGndk=;
 b=C0A5gwyHSs74jDKEMwNg/F+xoWFn261hMi9l2DBrR4SedFtLIX9DTh/ahLBNWQFofSP6MxPY30kdXKdguzTK2pwlH371QlD6ETxF3NjMfCh4XzlNg0vSlPDVxKUdHg9vakjUDFZEMg8oT5DliiBmBCgBXoQT1RTOn9eB+ElDn7kqcNhcGmP3Uz9+VIdKWeIUUG9PaoxD5aHZoeNekqAO8ah1WmkNYsoufhpjXtroXJ0kaFYpo9YWRDoYq6U6n0TJUoTOGvRKcDvRi9ITUdX11+++iBzZF2CRglakypMMnmQCufXx/0ifuPOkai8CU9u/dLhRt4CrUpSnn8W0LgwbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z4RAHVWU2vt5tQSIhTVKASopLjqKu7Qgqpsh3DGndk=;
 b=QO0gxodTYLvDm8bMKbLmZHSZYyHpUnkB/3uWWq5cg65XVOqlsElXeoevPSdKrl6zDd01LhiLLqZAbFYFLpobFWen1HZTyMI8UYu+IbihuymysgO7lRQdI4E31skKUmDxi51kGvhqCFSEWuyyFA368uBlV+YQL7NRSiwwplvtlaw=
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 05:28:45 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%6]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 05:28:45 +0000
Message-ID: <5d667c81-56a8-95bd-4aa1-4df16c42dabf@amd.com>
Date: Mon, 1 Apr 2024 10:58:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/3] KVM: selftests: Add a test case for
 KVM_X86_DISABLE_EXITS_HLT
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240327054255.24626-1-manali.shukla@amd.com>
 <20240327054255.24626-4-manali.shukla@amd.com>
 <7e093e45-9349-4cfd-a0ad-78ae66edda90@collabora.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <7e093e45-9349-4cfd-a0ad-78ae66edda90@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CY5PR12MB6597:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7lpP1UJ+nL0SHumYi+UN/PFv3sbovrtq5Bs6s96R/rZ+atk/j9UMQKcVEhfliqDMHJK2Fpthg6mJNMRSOl21pq4NwVr/lzqltrbXKLZqMgr1mKgznlmTe+9qpIczaxBKloL+IPwOaXRrCPccdNKIcBLTLYTtqlZc6UTFs5S9RtJI3RoUtmp3DAExeTIXWI881hDrRbjd/8FMAJthUPFioiUPKV1XjG25zUzZJsvijku3a+wtVv7zRz6ieaOntx56/MomYY88/VMIrbG21vPB//XR03f9EwLX2b+2lB5jxxjl7azHvEHZc28AcDQEUivgr0WyxkfmtxKk3E6a56bgnz1+XSfJiyQLPO+cJLfbHOfI/kAyBOkr5k4Loav5htr0ypOZWD05ByshWJmFgeQCQbEoHLSIwwVCqVJbHu+pfft2ndHk6MH6AOkgAeGwoiwAJsci057OV7ZWJLPV56RQnkavOgpCusgwFyY2uAKlAKVLTeF1qWW0cSw9qBonUNDdnVUxpqVJd6UfXLAk5umQ8EPIdiKuRChf740a/69dxTNGLg4qmRUJij24e4rvOJzyMO4Do+Pefbvb7c7SFL7UYSmmPy6aTKwoP9Y/+S7Ig5flbVoqJ4agQxTOsoGWL8RGN686s3iwQhhJJQmLYK/cILtSUEXx+LRGtryeAOJ3vFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUM5eHJBQ3hZWU0wY0YxMlp5YWI1V0FVYTY1dXFEVit6bkNJYjJKb2Y4ZEVi?=
 =?utf-8?B?SEFVRFhQcm5jTHE1bW56dG93YWFwZTRiYVM3NURpVnJpMTlJc0UzK2RqVzl5?=
 =?utf-8?B?MjFuSzZBaDVqd01yQ0Q4N1UrTnVheUlkeFo5eDRWdkN0b3FaTGlyUk9leW0z?=
 =?utf-8?B?MVkxRnJiUmRuQzdWaEY3aC9sUEVJK2t4OURXNGU3WTBJZDVMc0c5d1haekVr?=
 =?utf-8?B?UjFoOU9Fcnl6YUdzSUtTVmhNNDhxeDMvSUNpY3Y5QlJwSUFOcUtwbWFWTU5k?=
 =?utf-8?B?QWhMS09LcDF5ZWpVVjlJczdyQmlxNGFsQnFTYVd6UFFxSm5kb0xxNmR4QUtD?=
 =?utf-8?B?Z1JoZEVpVFYxZjNSa1lCT3UrK3krMk1yak5BUHpaTEJqNVVuS3lOU1dvNmFM?=
 =?utf-8?B?K1BNd2psdjFQdFdWTmFoNWlnOUplR1FjcEhkTGlheGpzZ1crWmZ2b3pZQWZV?=
 =?utf-8?B?dmwvWUZlT0gxREp0YXA4MDZKd3QxWWZweDZ2RlhVbk1oYUsvWmRmYnRaRHVm?=
 =?utf-8?B?RFc4Sk9LNUE0RTJ1RUtTcFFQeFZ3S1YxSVZ4Ry9teVhqUVkrcTZIc21LTmJC?=
 =?utf-8?B?eFZNNjh1YWhCcVlBdGg1dndXU2dhaVNpREpzeko4bUpDdTdwTEdjenBYbkRo?=
 =?utf-8?B?cGxnd3g5ak1YZkxzTkpzTTBDY0VaUkFFMGVxbVpsSElCUEJ0ZTVxZXVOUmVH?=
 =?utf-8?B?UytzWVFhaXowWUtYbThBKytuUjhUTERGK0dDT3JBTVJlOWxpLzlocS90cTJy?=
 =?utf-8?B?MUlvN2wrUzhpM25veUhwLzVmYkVLN3RCTnZmUEVFL1M3VFoxUmxnVVd5Y3NV?=
 =?utf-8?B?dm5YQVpSL210dlByNU82a091NmxnZ1JybitVelJXdUhidzVxTS9BUm1ZQUpS?=
 =?utf-8?B?TU1KeC9RWXNuaHQ1eno3QkVGMU9qeWY5dGZBV09lTGd6R3IxVUtVek5kKzZ0?=
 =?utf-8?B?bnAwUDBlbVRFS3hIa0NzcXpGMUd2K3k5djNJNmNxTUpaRXkyekZnY09OZXQv?=
 =?utf-8?B?d3psbmpqWm5EUUtjQ1NKWEphWGdJRXpTb1cxTXRTbVA1SDE0TGk5ZURZSGlq?=
 =?utf-8?B?T1o5cjhQR3lRVG56UE13TEdTaU8ydFd1angva1ZpMCtYNFZiOWR4UFlqd1p1?=
 =?utf-8?B?alVoMjdCOGVTTzJ5YmFteG9tb2VXTk9JU2JsOVFuR2Z0VElQcmJib1dadldh?=
 =?utf-8?B?MG10eFA0Q3U1S2dYMFRqSGc5cGs1dWR2VFQ1bXNhN0NUVGR0V3M2UzVCd05l?=
 =?utf-8?B?TUhpSUhNaXRibWZrMTRhSWVveVpZYkJ6a2lZUXlrY1A4Y2ZQdU1LY0hvdm4y?=
 =?utf-8?B?Z04xVnhWc3lhYTFsc1FkY1pEWGhxaEU2MHQ5NlhpVGhFVVRidWtic2tIREJa?=
 =?utf-8?B?dDJsaDJvRTkyZFkySVVNOGtWMloyWFY2Ynh0LzVPcGlIaFhQWVhUbGhpRldX?=
 =?utf-8?B?NTVKdGZTZkxWL2FCY1JRMG9OZUhxY0ZaZjhrekZHSTlaWGNFSjVQYmFOcHhN?=
 =?utf-8?B?L1hqcUZRNC9uZEU2ODE4a1llY1pWRlV4QzJxV3lOdHdYQTVvWXVVWmVKbUd0?=
 =?utf-8?B?Z2ZlRFlQQVpaY0R3NTVnZHpkekM0elFBMXZZWlk3ZlE3bG95OFJMQ2ordExD?=
 =?utf-8?B?RUZEUmlQZkpxQ1JFbWhrL1RVV1lxR2ltbFFvb1FTZ2NmS2M3TTJRNW1RaTlH?=
 =?utf-8?B?ZFIyeHVLemYxcWFocnlhaFBHNElGdXZmYVBvZ3NDVmFYQWMxaEdkV09CZE1P?=
 =?utf-8?B?ZzR5KzdnL1dzWldmSEJ1cVkwbTRrMnoxcFM4OC9wUkdyT0ZIUzErN1RWTTlh?=
 =?utf-8?B?T2FVRjMreng4UzY4a1FYWEM2T3I0VkFQTDd3RGVuc2Evb0M0UVJSYnU4ZTJt?=
 =?utf-8?B?R25aVmw0Z29RK3dIYTlMdDQxM1dwckpMVURJNHVRQ0RiOXRDSllwMURqZUNT?=
 =?utf-8?B?L2tmc0xYaXpEQVduN0tWZlZQSklyMFlMK3NRazBaYTVsakR6MjNid1pjVW5x?=
 =?utf-8?B?Tm1JTnJwcnhXMGN6SnBHelNKV3Z5Y2lsQTR0Rlo2VTJzS21rR25kT3pRVGZU?=
 =?utf-8?B?M2FJbnB5SUxkNloxMnpUYnBJQ0I3djVyMS8wK2pNb0ZycjVMZG0vN0VPbzcx?=
 =?utf-8?Q?x8wkd7CJz4C18dWmnTwQXsyWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb22a2e-ee94-4f85-470c-08dc520c995b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 05:28:44.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAMcuUGemC0swOyd7aU1w+ofusjIprfPv87fZ+vE0T+lCIAHxx25a88JiGMjOf9j6H7YLq1sEyyUFVoDXdv0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597

Hi Muhammad Usama Anjum,

Thank you for reviewing my patch.

On 3/30/2024 1:43 AM, Muhammad Usama Anjum wrote:
> On 3/27/24 10:42 AM, Manali Shukla wrote:
>> By default, HLT instruction executed by guest is intercepted by hypervisor.
>> However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
>> HLT by setting KVM_X86_DISABLE_EXITS_HLT.
>>
>> Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> Thank you for the new test patch. We have been trying to ensure TAP
> conformance for tests which cannot be achieved if new tests aren't using
> TAP already. Please make your test TAP compliant.

As per my understanding about TAP interface, kvm_test_harness.h file includes a MACRO,
which is used to create VM with one vcpu using vm_create_with_one_vcpu(), but
halt_disable_exit_test creates a customized VM with KVM_CAP_X86_DISABLE_EXITS
capability set and different vm_shape parameters to start a VM without in-kernel
APIC support. AFAIU, I won't be able to use KVM_ONE_VCPU_TEST_SUITE MACRO as is.
How do you suggest to proceed with this issue? 

> 
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../kvm/x86_64/halt_disable_exit_test.c       | 113 ++++++++++++++++++
> Add generated object to .gitignore file.

Sure. I will do it.
> 
>>  2 files changed, 114 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index c75251d5c97c..9f72abb95d2e 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>> new file mode 100644
>> index 000000000000..b7279dd0eaff
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * KVM disable halt exit test
>> + *
>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + */
>> +#include <pthread.h>
>> +#include <signal.h>
>> +#include "kvm_util.h"
>> +#include "svm_util.h"
>> +#include "processor.h"
>> +#include "test_util.h"
>> +
>> +pthread_t task_thread, vcpu_thread;
>> +#define SIG_IPI SIGUSR1
>> +
>> +static void guest_code(uint8_t is_hlt_exec)
>> +{
>> +	while (!READ_ONCE(is_hlt_exec))
>> +		;
>> +
>> +	safe_halt();
>> +	GUEST_DONE();
>> +}
>> +
>> +static void *task_worker(void *arg)
>> +{
>> +	uint8_t *is_hlt_exec = (uint8_t *)arg;
>> +
>> +	usleep(1000);
>> +	WRITE_ONCE(*is_hlt_exec, 1);
>> +	pthread_kill(vcpu_thread, SIG_IPI);
>> +	return 0;
>> +}
>> +
>> +static void *vcpu_worker(void *arg)
>> +{
>> +	int ret;
>> +	int sig = -1;
>> +	uint8_t *is_hlt_exec = (uint8_t *)arg;
>> +	struct kvm_vm *vm;
>> +	struct kvm_run *run;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_signal_mask *sigmask = alloca(offsetof(struct kvm_signal_mask, sigset)
>> +						 + sizeof(sigset_t));
>> +	sigset_t *sigset = (sigset_t *) &sigmask->sigset;
>> +
>> +	/* Create a VM without in kernel APIC support */
>> +	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0, false);
>> +	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
>> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
>> +	vcpu_args_set(vcpu, 1, *is_hlt_exec);
>> +
>> +	/*
>> +	 * SIG_IPI is unblocked atomically while in KVM_RUN.  It causes the
>> +	 * ioctl to return with -EINTR, but it is still pending and we need
>> +	 * to accept it with the sigwait.
>> +	 */
>> +	sigmask->len = 8;
>> +	pthread_sigmask(0, NULL, sigset);
>> +	sigdelset(sigset, SIG_IPI);
>> +	vcpu_ioctl(vcpu, KVM_SET_SIGNAL_MASK, sigmask);
>> +	sigemptyset(sigset);
>> +	sigaddset(sigset, SIG_IPI);
>> +	run = vcpu->run;
>> +
>> +again:
>> +	ret = __vcpu_run(vcpu);
>> +	TEST_ASSERT_EQ(errno, EINTR);
>> +
>> +	if (ret == -1 && errno == EINTR) {
>> +		sigwait(sigset, &sig);
>> +		assert(sig == SIG_IPI);
>> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTR);
>> +		goto again;
>> +	}
>> +
>> +	if (run->exit_reason == KVM_EXIT_HLT)
>> +		TEST_FAIL("Expected KVM_EXIT_INTR, got KVM_EXIT_HLT");
>> +
>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>> +	kvm_vm_free(vm);
>> +	return 0;
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int ret;
>> +	void *retval;
>> +	uint8_t is_halt_exec;
>> +	sigset_t sigset;
>> +
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_DISABLE_EXITS));
>> +
>> +	/* Ensure that vCPU threads start with SIG_IPI blocked.  */
>> +	sigemptyset(&sigset);
>> +	sigaddset(&sigset, SIG_IPI);
>> +	pthread_sigmask(SIG_BLOCK, &sigset, NULL);
>> +
>> +	ret = pthread_create(&vcpu_thread, NULL, vcpu_worker, &is_halt_exec);
>> +	TEST_ASSERT(ret == 0, "pthread_create vcpu thread failed errno=%d", errno);
>> +
>> +	ret = pthread_create(&task_thread, NULL, task_worker, &is_halt_exec);
>> +	TEST_ASSERT(ret == 0, "pthread_create task thread failed errno=%d", errno);
>> +
>> +	pthread_join(vcpu_thread, &retval);
>> +	TEST_ASSERT(ret == 0, "pthread_join on vcpu thread failed with errno=%d", ret);
>> +
>> +	pthread_join(task_thread, &retval);
>> +	TEST_ASSERT(ret == 0, "pthread_join on task thread failed with errno=%d", ret);
>> +
>> +	return 0;
>> +}
> 
- Manali


