Return-Path: <linux-kselftest+bounces-6934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5989385A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6848D2818D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093F8F4E;
	Mon,  1 Apr 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oA+sfzJN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DB1C0DD3;
	Mon,  1 Apr 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952852; cv=fail; b=ux/JmcQXBFQ/5hhlHJx93bMgl4lfDJn3Ow6ZjroX+GMh6Qx1kdySXtCUHZtHZm4J0aD5iyy8RnkiioQBTfF3kGVbOiVWjUUdv2oqNG0LFu+YY35AvglBJPFVBFGCgUmLQhVygeemLdOQZACCLiy/VIk+m2V6OEKud1Xke3Lq9Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952852; c=relaxed/simple;
	bh=qmWrJ/NDUEAJhiEL70retjTWq/rMM/pI8B24gYiuApU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rx4OmSrZ7BayjMQrs7tv6yH8oPnfrYWOy+DIDaXzi9tpIZM+lcUjb6TyIxTrNQXHsGjBQ2sFqn8gWFQ95JCIy1ufAPBCYfitLjYjNaWvoU7vIKXwwutOU5W+SO3/oo7/ptt4zaZxvmDLasrUcN08jBuI21h8eTNdSITASOd5kz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oA+sfzJN; arc=fail smtp.client-ip=40.107.223.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0m49e/aXBwyYPe3ZMvVDR8uZRJ4c8dsSTY2n62nviAyGBYc2+C1onAkBY9v5drbgfKD22jC+MwQmaA2V0pr47p4N694aZQoKrp1c9efv8h+xDSSeQv7Nxuu75xWlst/4k2Emqk0HTwDbRxNb4zpU1oZqef7pNQ3HHUMSM+9fYP86gT2O33pKmSLU8sYThugPc1twrwRK6w635jp+mxcFABxpC1bYG2v63Bbt2E37ZDrCQfTZQBbAsJ9SqRYf0xxDefg92fLUka+mV67npgRNa5vFcfvVbibJbZqizvtEWJFOuw0IYhNYts0hEjwQZYus7tLo9emHoYYbevNC+vBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQJk5GDrSJprdcS6uzDJ+PyLVCEiUC9jU4I9FE7EJsE=;
 b=II4yiTLGhWjExxxThAAnKDhAj65R+hOSiQGunDVOKSYolexs220zIg42YuBjj4zILaDqSviPC8h+uGjJp1CeqKQEYGNlAXaQssa6H/nEzszJYpfPNV/KWdaZTrP1n69uctGxiivbsfJQGbRdAFiA8x+E0xIs8gHIa6SXiSRM0BSwAWUU15MKnXHAPXAyYUW9/qn7X2YlbVF6VFWV/E5wwk5ds+cXanFtNIpsoCupIDZX34fvQpe9XgQv1O/GB8Vygj7jlCSFZU1eXwc32x2uZu5oyEkDBt4iq4AJE3gPikJAvz0h58Oj2HavrORwBKQWbj+uUf5cEYXJSzUNw7VnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQJk5GDrSJprdcS6uzDJ+PyLVCEiUC9jU4I9FE7EJsE=;
 b=oA+sfzJNgDIw28m4FnQITnN/+LE0/6KVkHF8qYTf3AOmZaRs/4SnUuZfrKIFexEJcJKGweXojpK4jYIJgCOvAGud/wwbAkxxmPuCHeSn9zlQQ+8Rsn7SQwvyGfbqtbT1ZzEGZAJffwAupz6Kb87BWqqjT68i9YQ/6MDBKN3Pt8k=
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 06:27:28 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%6]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 06:27:28 +0000
Message-ID: <52357c8d-2e1a-75c6-9f73-2da7b510b711@amd.com>
Date: Mon, 1 Apr 2024 11:57:18 +0530
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
 <5d667c81-56a8-95bd-4aa1-4df16c42dabf@amd.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <5d667c81-56a8-95bd-4aa1-4df16c42dabf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::21) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ2PR12MB8182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1M5Z2x2XOCOV2gCow/SNjXROfnQm7g9t+bnqtMHYyYzKPjiCf/6g3d3lo3kLZVPPn2T0EJzdBmAn4nridfVf33OLDjfL2Ac3DPEnDjgEUthysmzmqL4FzuxpRAVGLFHMULtsT0lZnB8Azc81/rnJWuBvB+HhbxAKnzjSdtm5CQZO6h1/NE5wguIILReMkmdbww3tDVDSueVfx5+u2r9Gp1UCxlRkMjMFrBaNsokr6YVL4Fsg8AnsZWRnaa9Smlk0HLbHfnHa8dt96+vYu/UUaNKw2s9QDbs8TNzmpI9KnAlaNhzHh9XjJDtmkVHOSwweAuZx5jPsAisQ99ZlIcmCGAzMsAGejhj3ehCHjWqysFSBZDsCoqkDe+RA3AKzVLLnrGiZrvDbJ66Q9v3GRb+fFCdXw8zeZQFS6ujz2agMU2GbrOap/KDzMbOUJaFQUxqJGQYx3nYwcQhRRuO1v9RZf46dPwoF4kzCW8fRrchSkg2jQY9YlO4K6b7OVFe8EKuO+mw7oCDGRaMKBkS1Qu7xYKdH+tGy+fritdAXY3sbpD3gl/hu8xHeAXGuXVhCd5Ex6/L3LMk79JbEk0mVBQ4s7Xf1eF+NN9OeHY30wKT/+jjTnHzGXrL3ETjavTC7jVyizIfrBy276TyaUfnkGtPJS4tpKaRTHdcbL2TFRtuAU+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2Z5UWEvWmZiSE5FSTdnTHJvSWJVeWtGNWZnektCWS95ZWZTNTV6Q1BVYmc5?=
 =?utf-8?B?bEszdStTbkNhQmoxdmR2SGMxdGxRamcrK0MwL29EckwwUVpJRUx6UjFaZy9J?=
 =?utf-8?B?bkxmc0hrS2oraGwxQVFmUUdjRkZLbzExS3QrWG1GdjVGTUJFblNkWmpZK3M2?=
 =?utf-8?B?N1oxNGtUTzlFL0x6cmhseVV2VVVUTFJpdEJ4V0g1MjgxaGVPUWZEcHdWQTFJ?=
 =?utf-8?B?SE5xWXVrY05yNlBaUDhkMHlEaTNhbHlsbGpNZUE1VFFWd0dNcURadUZORXk1?=
 =?utf-8?B?MmhKSS9PYjAxM0UxYS9rOXNxQ0lRWmdXS1RLQXpGZngwQ1VYS1VrQkk3Smwz?=
 =?utf-8?B?dTVDUUF1SmVXekZ3UDhFbjFySUtjU3dldzRCY3lzRFdVYUEyRDRJa200NVJB?=
 =?utf-8?B?aUVuMnE5UG9xMjdvR1R5YkNsaHdTZHFtc0toamI0bTU1Q3hKM1JHNlJkVWVl?=
 =?utf-8?B?dUxZTHdUZmloaUd6NlVKbFRnMHpJMjFETWhtRGJ6bm1ac3lCc3p5cDdjY2Fl?=
 =?utf-8?B?b1Y5cmlWK0MzUERXblZMSmt4VGs4VlpWWWZVUGlXcEFkc2R1ZmN0K1JyYkRx?=
 =?utf-8?B?VHMzKzZOb0RxNFVXZ0xqU1N6TXIvUmY5NTBLZ0trNDZnQk1GQzh3S0pPWTdQ?=
 =?utf-8?B?d1FleW5maUxrQ1E2eFlhWmxCeHVZVWJtdGdDK25UU3haakdYUTNXTHI2Z3FB?=
 =?utf-8?B?ay9TYjlMR1o0VzJza0pSTlR6bUE1TWpyem1zWW92L20rcWlGMU5NNWJqbDF3?=
 =?utf-8?B?YU1tcURrakVHdDRJeHpRNTBXYnR3R1lSckNHa3dVaE5iSFRTZi8ydTZ0cys3?=
 =?utf-8?B?Z0dtMUMvak94dllQUWFSTTF6TldLOFd0WVQ0anJ5YW41ck9DMnFTYnR1a2Zn?=
 =?utf-8?B?dVpqVGNSSVRpb0JURW5UWlA1MWw3S25qTmk2VzRvWUNkQkgrZnorRnhpVEdh?=
 =?utf-8?B?cDVIREJ5N3ZLa1ZBRmRsalpuZUs2T0d4TU5MeUhCRHNwOWtzODZGQlFiRlZM?=
 =?utf-8?B?aGp0akd4K29TZDZQY29aYzVqZ3BZRzhwbnNQdXdZc1I3aHQ0RzB4R0Fwa3Yy?=
 =?utf-8?B?SHQra3JqS09VSWVJTGIzVFRlR3Zuamx1Z0tPTEh1YzdhNzdrMTdscml0aSsy?=
 =?utf-8?B?N1Uzek1TNGFXQlI2SDM1ZEMzV0g0QzFZR09sV1hZMFR1VFZWZ05TQVJYSXFo?=
 =?utf-8?B?aHNSYmV4N0RkbU82WG00ZkdoR1VkcmNIQm1UcnI5MUpVOTBsQlBxNzJzOG83?=
 =?utf-8?B?SUJxMWs5Y1NQWGxieTJLY3VHc0prUE5UYkc5U2lTRy9nakNFT2FKdWFBUWpk?=
 =?utf-8?B?U3JOWnc5bGpVU3ZORmlBTjg4Ylh0b0tKKzVZUFNERFN1a09yM2NrcTlHanZ0?=
 =?utf-8?B?ckZOc3I3ZEwzV0hwb0NURmFUR29OUVJZUGxBNlV1eENMV2x1cWJBWkRHY2dR?=
 =?utf-8?B?UWdkY2FpL0FxYU9NUHpUTUd5YVlreHNoTElXRkdrMWdtamJRN3NZbngvWjB2?=
 =?utf-8?B?alZ3OVB2WmtBM29VSWIvRWlZbmlnNjBsTmFRSWRyWnl1eXVoVlBsR3Zac3Fn?=
 =?utf-8?B?cWl2TzRVdlhnMGQ1UVczaXArOXVhQnh0UXBnL1FydFFyUDM3dzNSWHJnMStv?=
 =?utf-8?B?M1Y4MHpEYmhBOTdrenVnYWNuRGtpTHVVUmREbmhlRk9QUks4blZuTmZJaEZ1?=
 =?utf-8?B?MGx6eTJ2VkJjUGtwRTZFYk8wa2lNcUNrcDhyVXJRYUsxWVBpVmJmM0ZiZy9K?=
 =?utf-8?B?MHIwem5mS0FnRE9jQTZEbXBxRmcyNEdNbklEcVprQUJBQWNoc2JkR2kzdy8w?=
 =?utf-8?B?aXUvRXhVd3Z0M25NSWdCdzZFcThaeGdoN2VHd2hLa0M4cGpTeEV5cXdNbFVS?=
 =?utf-8?B?MEYwNHFoSHRTZk54MnZKOG5wNTRlRGt6ak9sVlVyc0ZxY0NkSlFxSldNQkZo?=
 =?utf-8?B?ZWtsZGNYVmg2dDgxQ1lCc0tmcTdMYTU2WGZIVUhnb3hadkpLSCtyMW5kRCtG?=
 =?utf-8?B?a1ZDL2hlVE5CT2kzUUhvMEJZT0wzYkRQeGlKSFRwUWhUODhqZ3ZtdmVLa2ZM?=
 =?utf-8?B?T0FHclpDYU9ZcGdFQzNxbWdVdkEyQ2J5Kzdxcmx5cVJsWnptOTMyaVFvR1Rv?=
 =?utf-8?Q?DwwRVbapETZW4CtuhSA5+/ZpY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23674b06-a9ce-4443-94b1-08dc5214cd34
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 06:27:27.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN738tXD064w29Ito4lu0Sj+4yDFiP1SsGlCQnGDbuxHzx3P43G5BDAxmkgRJEaxD1SNdXyoyCO+lVHePSojyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182

On 4/1/2024 10:58 AM, Manali Shukla wrote:
> Hi Muhammad Usama Anjum,
> 
> Thank you for reviewing my patch.
> 
> On 3/30/2024 1:43 AM, Muhammad Usama Anjum wrote:
>> On 3/27/24 10:42 AM, Manali Shukla wrote:
>>> By default, HLT instruction executed by guest is intercepted by hypervisor.
>>> However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
>>> HLT by setting KVM_X86_DISABLE_EXITS_HLT.
>>>
>>> Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.
>>>
>>> Suggested-by: Sean Christopherson <seanjc@google.com>
>>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> Thank you for the new test patch. We have been trying to ensure TAP
>> conformance for tests which cannot be achieved if new tests aren't using
>> TAP already. Please make your test TAP compliant.
> 
> As per my understanding about TAP interface, kvm_test_harness.h file includes a MACRO,
> which is used to create VM with one vcpu using vm_create_with_one_vcpu(), but
> halt_disable_exit_test creates a customized VM with KVM_CAP_X86_DISABLE_EXITS
> capability set and different vm_shape parameters to start a VM without in-kernel
> APIC support. AFAIU, I won't be able to use KVM_ONE_VCPU_TEST_SUITE MACRO as is.
> How do you suggest to proceed with this issue? 
> 
>>
>>> ---
>>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>>  .../kvm/x86_64/halt_disable_exit_test.c       | 113 ++++++++++++++++++
>> Add generated object to .gitignore file.
> 
> Sure. I will do it.

I think adding of generated object to .gitignore is not needed because
/tools/testing/selftests/kvm/.gitignore uses pattern matching to exclude
everything except .c, .h, .S, and .sh files from Git, which was committed
via below commit.

commit 43e96957e8b87bad8e4ba666750ff0cda9e03ffb
KVM: selftests: Use pattern matching in .gitignore

>>>>>  2 files changed, 114 insertions(+)
>>>  create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>> index c75251d5c97c..9f72abb95d2e 100644
>>> --- a/tools/testing/selftests/kvm/Makefile
>>> +++ b/tools/testing/selftests/kvm/Makefile
>>> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>> +TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>>> diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>> new file mode 100644
>>> index 000000000000..b7279dd0eaff
>>> --- /dev/null


