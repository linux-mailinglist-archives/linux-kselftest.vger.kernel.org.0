Return-Path: <linux-kselftest+bounces-6940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D7893AF8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08821C20D92
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A337374C1;
	Mon,  1 Apr 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aYTQ5WUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2120.outbound.protection.outlook.com [40.107.94.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D31DFFC;
	Mon,  1 Apr 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974709; cv=fail; b=uxA5XMJPH053YthP3M3tf0XS41A7RY/f8+JRAoLGFKF0Ctlf5soT9VL0xpbtKheR7CmHe+t0kPUT3ZUfLnkDyqrSRG0IQhTfHudjsp9MwngSISXpkVVCT/O/6N+RH49bm71ZT0tNge+bV9D4Frn9dzJ3vN6MxXf4FYwRtCoxQ9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974709; c=relaxed/simple;
	bh=L5eILxTRUckxgXovtuoqon3QFQijmVLKCgLbOHrI+sY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uxne4u+7FeJSUIxLNJgka0L0dcEGZzcrNCOFMrziMxMuprdhG7vaI58N3O9hFB2l56Mb/VfPaqv7Z3ZeR8NPF0HwVAJpaR0xqzdT9+HeiIAuLTORBdzqdsgbtzbLZPn38b428Xq7dtmhI5Bpj8w4iwZXMNRZkM40HfI1/Q63ycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aYTQ5WUu; arc=fail smtp.client-ip=40.107.94.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSLh88/26NBR3ih+r0YVhP49MqRJRitJsjAxXhpoT55hU7gkQuFFHny+KpwRoZiyIqckaNZmG4spvb1Y3E+sMKjaP+acC5QAaFlDIkF/P3W9o4TXv/o8G1xHdowipI8fLpPWog3iWJu7RwTLK97boofKuPDIpvrnti62QdTMZd3p371qxT6ret++St5l/qb0fhBjpmoQaZw1OVm7S3yOkYJzL+hi6Uu+1EYLm7AkD3WjMYsv9wcp4FKS6c0whM8ryJI6AdEFWkb6ZDghB5Aw1Jg0p/2SZYy3zMn1JHTf4ot6PVRwHo4RVf5vhWJ8RM/xemco3kKogDkjjimdteLScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfDRXyAYJp6cDKCs2wWNU8CaOPp/R95sL9slBqsoalA=;
 b=eUIGWCxldbJeIIGvZhHK+HitwsSpZmmUE9Mth83AOODbEpzVA7MnDIuDvaYnDL56AqGC89zaKUBKHB/d2zbgNtCn5Skl9cBqerPqPw3/Ub9qnDFrt3F6K+UTL7Wu2+34RhN0N1//Ib/Wmf4O6GvcYPYnqjUl0eMWzH/RzMab2e/Q5sQ+lZukg82L5O4kKmP+ZgBLulQJyYvQfMHOhFwRydeisIb8h1lw+AltXyerTXB3WebqAnW7en7ETQLTSSMnoOeWAB3iY2VvffIONQHg7eR8HR+IceFYq7U78UXQ5tjg+jDeWkTFnSQQZjeO5MqYcp4uLpYrf4r3D9GdO5j9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfDRXyAYJp6cDKCs2wWNU8CaOPp/R95sL9slBqsoalA=;
 b=aYTQ5WUuxKSs3B9zDLNSy0kwoZoFuAJAVXolID7/KmuJjoGNU1oELRjeGTKXBphxSoIBldXAzyksh2ipQUFngVY6SA+HmQ6TqiBXHACnzeDDyFMaJpLemUProsudMlyav/lezDDhXVQRw806eLcEEby2TXrDSGgivbCBa+Vxnbg=
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 12:31:43 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%6]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 12:31:43 +0000
Message-ID: <c40ac406-fc59-d50f-02fb-d30fbdad0c74@amd.com>
Date: Mon, 1 Apr 2024 18:01:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/3] KVM: selftests: Add a test case for
 KVM_X86_DISABLE_EXITS_HLT
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com,
 linux-kselftest@vger.kernel.org, Manali Shukla <manali.shukla@amd.com>
References: <20240327054255.24626-1-manali.shukla@amd.com>
 <20240327054255.24626-4-manali.shukla@amd.com>
 <7e093e45-9349-4cfd-a0ad-78ae66edda90@collabora.com>
 <5d667c81-56a8-95bd-4aa1-4df16c42dabf@amd.com>
 <de7835fe-0f60-451c-9f7b-b380e1c65273@collabora.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <de7835fe-0f60-451c-9f7b-b380e1c65273@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ0PR12MB6990:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CvT7CFhXeRCxc9K5nrLn2CuPfTLOG3oTbPN8vyM0PbycYL29H2h3DPN/KuQuYgjeWT6F241MrgmqYe3SOCQDz6SmkH9v5k2folM+wlwU1Nfa7oi5+MgLBFBMZY8dxFw8OZwOolrrFWlwI8hGYdxS72olIrJZMjOR/5bTg/kOp3A5i//67j1YACza3x4xFcJg2embBI3R2vAWrMyYj3PpAeG+NmKNG1kJUhw4gRQTW0jbaoeSMlOtaGOYuYauYofmSGK/LP6vmIEplu/RHwi2KyYnNzUmsRd+eFElFp254zLbF2S0dUdTI7nKLjy4pLyXuxjCwWD8v8B9EYzte/MlJ4zryZZgDbcQgKrRrEaUvBl0KccaXa9RhdUuc/wtigNWeIh//pQAfff5bABKOgoYb3V1IRqOd48k6ENyBCXefsvPCF/MdKXcttl1LcZG6rJAQR5MBHaoIC5GdQVJiCDHm0Whs644W1ZvzFRsQ4rXdZ7lQbZNjcIAiIBtpbDRo5jVcJbY+vPWEANTRuJViiRQpo0TvB6+n7Gd5qfKo14UxuA9VqrOgNaFj/er/kug/Q9+teLT0LPDghT2A5ORPCGygYNE30ePbtcZF3lX0X8M6xAOhQb0tjWH1paRqAHJZ6F5ug0QT9UhpxX5UFr9bTYPZ2MWWag7L3KkVGPlkdVWJ2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEVDM1JYYlcrSGN2aWc2WUVCemxkRVRwMklLdVY1N3RvRjRqNGQ4Mk94RWIy?=
 =?utf-8?B?MWlGdzgyanFKcEFuT3M1clZrSDhxWWUvUWRHRlpWVmx5NGp6Zm9OQ0h5aUFF?=
 =?utf-8?B?U2N6TFpMSlNvU3BQNEdsWjFZaVZqWDZmOWxlQ1B1SzQ0bDFFRnZyQmFIL1Ar?=
 =?utf-8?B?WnBXRlR6L3A3R1dtcEZZQWNHMUJLQzZKTnQ5dFVDTURrc1pCZkk5SWMwTWNC?=
 =?utf-8?B?RzNibkNCRW5zTHJJZ0dqL0lndnZSV0VrRDhBcTFydE5kTXNLQ1hjdmtpZTly?=
 =?utf-8?B?YjBPSllrbzl0VEI0SmZ4dVFxSXhTNFFMdDRDMWQwNzlaWEpPeWk4T3RRR0dy?=
 =?utf-8?B?UURCQ3U0M3QxSXFwMlI1cElVRkxUTWJUdjluMXhySzgxMmpWQnA2REx3TVZY?=
 =?utf-8?B?cXNkNk81amlvVmI1bWQwRXY5TnhTeGNDbTNXNzlqWkw2U1ZWYUdncnExWUp5?=
 =?utf-8?B?a2daV0VxaEs4ZUl4WnNHWHpkR2YxK3hpN2RNcEI0RklCdlRheFVPQWVJVWc1?=
 =?utf-8?B?eC81RHI1cWRBekxzV2krTVkyUmdlamswN1FTVzQ3clRlWmYrSlNSdzdRRUs2?=
 =?utf-8?B?ODVTS1lNbkdodlpuaWRaUlNsblIwcjNseGFiZjNISlkyTzE2TnJYTS9UdE1K?=
 =?utf-8?B?UWdZWHdkNzM0eUlIRDRhZEVFQXRmendrWlJLRkFmdDdkMTVjM0s2cThmb0lY?=
 =?utf-8?B?QVYveS9WdHVabHI4c3lnWGszWHJPbWYreGhzc3phNThmU1IzenBtOHExbFg0?=
 =?utf-8?B?QVRmcit2aTNRQmZyWEdWMmIwWExxTWV2NVZrZnkrUnJWQTFIZmhmV3RZeHhl?=
 =?utf-8?B?MmRFTm1Ca09sTVBVYlB4Q1U4N3gzYXRGTW1UaFVhNU9YSFVIT1FPUWttRER6?=
 =?utf-8?B?cDl6Mk9YZG14Y0VnY2phbVUzNlZBSSt2VjhpY2JVTDRMRlMvbVR1Tkg5TFRp?=
 =?utf-8?B?ODJjSnYzSlA3Y3hzZUVHZGR4UWVPL0k2RUNPSE85NTMxTm5xeUErNSs2cWZO?=
 =?utf-8?B?Mjk3M1UwQklIZk4ycjlVU01kT1RzWlBNUzZvSHhpYWljdkpHT1d5dExBb01T?=
 =?utf-8?B?RUIzaHNlb0ZFZHJBTVpRc29VODZZQ2syaXRJeTBnNjVBRTl1K2RxbGRYNjlE?=
 =?utf-8?B?SjI0RFF2MjdFcXB5WC9DeFhObStyTFdLSlZzdFR4V1JoZjZUZjYyYktRUE03?=
 =?utf-8?B?a0l5d3Y1dHd4Sm9xenhyVGRuQnpHaUNxdVVGYWtDbDJKWGh4ZG9LZ3ZZblVY?=
 =?utf-8?B?SFNLODBuSXFFemFoWlVrUjVCUVpINHZTWmtzaFczQ3AxSVVzYU43WkRJSkFS?=
 =?utf-8?B?RW5rcEw3R3F3YzU2Y2hjQmtsTi8vYWY3LzFES1JNODMwUUFmRmV4M1l3MEs1?=
 =?utf-8?B?Qm5TLzd1UnFod2xpRGRPTkhZbGFwWElDRTdESEwvQjhCZ1d4SnFzOXVySXNj?=
 =?utf-8?B?M3FLaW1CcGlWdnpLL2RCMjFGSGkxYittbXo3bnp2dko5WWt2akNxdlhoeW1k?=
 =?utf-8?B?Zkdzbk1hTUl2NkV5OXNPRTFhSlAvWEVaZTU4aXRjMm4yOUZ1OTBGZGE0eVhn?=
 =?utf-8?B?aXR6RUtEbW9vUUF1bDkzc2VFREpCUDlhY2RRMElsMTYvbmtoSWhJUVNBOEx5?=
 =?utf-8?B?Q1g3eGRhaFA3WllxUVVUNVhmWHhrT0k5eThGdzhoQmVuVGdGRURSVWpxRlBY?=
 =?utf-8?B?dW1ka3Fhdmg5czVqeWFSbmZrWEtJYlpyRVFuME4yKzJoMkIxaTExbWVYcThJ?=
 =?utf-8?B?UGNURWdYc2pLUHh0SnpMVlVhWDdrSVUzTXl1ZDNoNyt3SXYxQ1hsYUxxbGt5?=
 =?utf-8?B?dkhGSjhxWENDQ3p2ZjF3Sjg4YXFSQjN1NlJNZWN3S3dyWWs3cUJBQS9xQW4x?=
 =?utf-8?B?OEhZYVd6bTlUTCs1VTlVaWxET1hCa21YaEFSWGVLMlVqNm05N2hUNW1KaUhy?=
 =?utf-8?B?dFpLWDAvSlgzOU9zTkhKOEFjeGd3MytlbzRUdk9Kb01yMFVJTTFJWnBvbHh4?=
 =?utf-8?B?VkhCQjlvbEg5OUQ2V0F4SG9kYTF0RGFxaVVXendkZDZVejIrc0s0OVZlMmFh?=
 =?utf-8?B?K0J1dGw4QkJkRCt0eWZXbG1OTnpBaGRyaW9HVnlrUm1Bby9ORUYyTmxiYXEr?=
 =?utf-8?Q?JmP+TbtmlXjFP1YkVRjQ/z+Ep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2099ce58-bef4-442d-aa9c-08dc5247afd0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 12:31:42.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAFg4tM0cOAWibAfUwABkGhQoGDqwBJvAen4DHBCAKrGy21ssjf/2YU6qaHtj1G3gy8OZW9ld6RixfXKChn39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990

On 4/1/2024 3:11 PM, Muhammad Usama Anjum wrote:
> On 4/1/24 10:28 AM, Manali Shukla wrote:
>> Hi Muhammad Usama Anjum,
>>
>> Thank you for reviewing my patch.
>>
>> On 3/30/2024 1:43 AM, Muhammad Usama Anjum wrote:
>>> On 3/27/24 10:42 AM, Manali Shukla wrote:
>>>> By default, HLT instruction executed by guest is intercepted by hypervisor.
>>>> However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
>>>> HLT by setting KVM_X86_DISABLE_EXITS_HLT.
>>>>
>>>> Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.
>>>>
>>>> Suggested-by: Sean Christopherson <seanjc@google.com>
>>>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>>> Thank you for the new test patch. We have been trying to ensure TAP
>>> conformance for tests which cannot be achieved if new tests aren't using
>>> TAP already. Please make your test TAP compliant.
>>
>> As per my understanding about TAP interface, kvm_test_harness.h file includes a MACRO,
>> which is used to create VM with one vcpu using vm_create_with_one_vcpu(), but
>> halt_disable_exit_test creates a customized VM with KVM_CAP_X86_DISABLE_EXITS
>> capability set and different vm_shape parameters to start a VM without in-kernel
>> APIC support. AFAIU, I won't be able to use KVM_ONE_VCPU_TEST_SUITE MACRO as is.
>> How do you suggest to proceed with this issue? 
> TAP interface is just a way to print logs which are machine readable for
> CIs. So log messages, test pass or fail should be marked by
> tools/testing/selftests/kselftest.h or
> tools/testing/selftests/kselftest_harness.h. It depends on the design of
> your test that which would be suitable.
> 
> It seems that most tests in KVM suite aren't TAP compliant. In this case,
> I'm okay with non-TAP compliant test as the whole suite is far from compliance.
> 

Sure. I can keep it non-TAP compliant for now.

>>
>>>
>>>> ---
>>>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>>>  .../kvm/x86_64/halt_disable_exit_test.c       | 113 ++++++++++++++++++
>>> Add generated object to .gitignore file.
>>
>> Sure. I will do it.
>>>
>>>>  2 files changed, 114 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>>> index c75251d5c97c..9f72abb95d2e 100644
>>>> --- a/tools/testing/selftests/kvm/Makefile
>>>> +++ b/tools/testing/selftests/kvm/Makefile
>>>> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>>>>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>>> +TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
>>>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>>>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>>>> diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>>> new file mode 100644
>>>> index 000000000000..b7279dd0eaff
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>>> @@ -0,0 +1,113 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * KVM disable halt exit test
>>>> + *
>>>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>>>> + */
>>>> +#include <pthread.h>
>>>> +#include <signal.h>
>>>> +#include "kvm_util.h"
>>>> +#include "svm_util.h"
>>>> +#include "processor.h"
>>>> +#include "test_util.h"
>>>> +
>>>> +pthread_t task_thread, vcpu_thread;
>>>> +#define SIG_IPI SIGUSR1
>>>> +
>>>> +static void guest_code(uint8_t is_hlt_exec)
>>>> +{
>>>> +	while (!READ_ONCE(is_hlt_exec))
>>>> +		;
>>>> +
>>>> +	safe_halt();
>>>> +	GUEST_DONE();
>>>> +}
>>>> +
>>>> +static void *task_worker(void *arg)
>>>> +{
>>>> +	uint8_t *is_hlt_exec = (uint8_t *)arg;
>>>> +
>>>> +	usleep(1000);
>>>> +	WRITE_ONCE(*is_hlt_exec, 1);
>>>> +	pthread_kill(vcpu_thread, SIG_IPI);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void *vcpu_worker(void *arg)
>>>> +{
>>>> +	int ret;
>>>> +	int sig = -1;
>>>> +	uint8_t *is_hlt_exec = (uint8_t *)arg;
>>>> +	struct kvm_vm *vm;
>>>> +	struct kvm_run *run;
>>>> +	struct kvm_vcpu *vcpu;
>>>> +	struct kvm_signal_mask *sigmask = alloca(offsetof(struct kvm_signal_mask, sigset)
>>>> +						 + sizeof(sigset_t));
>>>> +	sigset_t *sigset = (sigset_t *) &sigmask->sigset;
>>>> +
>>>> +	/* Create a VM without in kernel APIC support */
>>>> +	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0, false);
>>>> +	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
>>>> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
>>>> +	vcpu_args_set(vcpu, 1, *is_hlt_exec);
>>>> +
>>>> +	/*
>>>> +	 * SIG_IPI is unblocked atomically while in KVM_RUN.  It causes the
>>>> +	 * ioctl to return with -EINTR, but it is still pending and we need
>>>> +	 * to accept it with the sigwait.
>>>> +	 */
>>>> +	sigmask->len = 8;
>>>> +	pthread_sigmask(0, NULL, sigset);
>>>> +	sigdelset(sigset, SIG_IPI);
>>>> +	vcpu_ioctl(vcpu, KVM_SET_SIGNAL_MASK, sigmask);
>>>> +	sigemptyset(sigset);
>>>> +	sigaddset(sigset, SIG_IPI);
>>>> +	run = vcpu->run;
>>>> +
>>>> +again:
>>>> +	ret = __vcpu_run(vcpu);
>>>> +	TEST_ASSERT_EQ(errno, EINTR);
>>>> +
>>>> +	if (ret == -1 && errno == EINTR) {
>>>> +		sigwait(sigset, &sig);
>>>> +		assert(sig == SIG_IPI);
>>>> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTR);
>>>> +		goto again;
>>>> +	}
>>>> +
>>>> +	if (run->exit_reason == KVM_EXIT_HLT)
>>>> +		TEST_FAIL("Expected KVM_EXIT_INTR, got KVM_EXIT_HLT");
>>>> +
>>>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>>>> +	kvm_vm_free(vm);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int main(int argc, char *argv[])
>>>> +{
>>>> +	int ret;
>>>> +	void *retval;
>>>> +	uint8_t is_halt_exec;
>>>> +	sigset_t sigset;
>>>> +
>>>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_DISABLE_EXITS));
>>>> +
>>>> +	/* Ensure that vCPU threads start with SIG_IPI blocked.  */
>>>> +	sigemptyset(&sigset);
>>>> +	sigaddset(&sigset, SIG_IPI);
>>>> +	pthread_sigmask(SIG_BLOCK, &sigset, NULL);
>>>> +
>>>> +	ret = pthread_create(&vcpu_thread, NULL, vcpu_worker, &is_halt_exec);
>>>> +	TEST_ASSERT(ret == 0, "pthread_create vcpu thread failed errno=%d", errno);
>>>> +
>>>> +	ret = pthread_create(&task_thread, NULL, task_worker, &is_halt_exec);
>>>> +	TEST_ASSERT(ret == 0, "pthread_create task thread failed errno=%d", errno);
>>>> +
>>>> +	pthread_join(vcpu_thread, &retval);
>>>> +	TEST_ASSERT(ret == 0, "pthread_join on vcpu thread failed with errno=%d", ret);
>>>> +
>>>> +	pthread_join(task_thread, &retval);
>>>> +	TEST_ASSERT(ret == 0, "pthread_join on task thread failed with errno=%d", ret);
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>> - Manali
>>
> 


