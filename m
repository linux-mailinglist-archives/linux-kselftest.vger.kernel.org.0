Return-Path: <linux-kselftest+bounces-13624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D97192F00F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5134D1C20FE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539B14F121;
	Thu, 11 Jul 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EExAuQ/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28712E1CA;
	Thu, 11 Jul 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728181; cv=fail; b=PdpaAp9BVzqj7SPQkPyzEyw7HZ1NgtXHgFHtb98mjrIWH/UHBjFJVRKos5RKtR3TxuQkmL2DiGK0wkIl22gIUOTx/xx3/LHShxAVDbUwXgYP3JT6b5WQ2uw4vnSs03WHkGZL8kp+f0dCEHqfEwl93MCehf6QXkT4qfo+36Q8w5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728181; c=relaxed/simple;
	bh=zAa83el1u5mXjCSLs7Ru3DlneQsAoSx8fuNCZspd/kA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=q/g6NlPkfuDd+4ze1BQE83Xi3YtKYaKCvAHdjPXldT0ytl1mJVEKHYfhGak/+hSOHq7kMBpQM158P9A4Gwjrw5yhxaqxy5VmQ0LEbVIuZlnmI7sjwM1vZ555osGUspHbln5iYL1fFQmjx3VS+xYZuwsLUXKOfQxBlr5BWcqoiiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EExAuQ/n; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0Ss2mndhxai800zxW1FKETkXa+FeHiRyQlXv8QSJsJDMEmCR0/K5P03pi1UmavZiRaAf/cbTyFqahDIOaeV4JALWufvePsehbGD652cO7XPVTJSmmJKe6J5rS5gZvtz5ByC0d9Fx3WwkNNcvXSSN3Sa9qdnzVrQEzbammuFaYgDcWYbXU/ZE68u1mE442KXjbQbdS8gVcMp85cK2CeInfpwKet9hhi3DEytVwIBDl92PacM9HH7GKotbgc+aI6s28z9itxqDmNIqGnDmrmCxKAzkeGEQhp2CW+TWqd4Sh5uYjdbvMl+rX2e0FSt8BgXqikvHqM0txCFMaUSBbT0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AUE+gg4fRtkVbI6855PHnVfhbc295MxS+o308yrrVo=;
 b=E8lYBhZnXRzyCpraLqP0wBvYE80L8HQkYq0MCamTJZGxAkX4kUJbifr/85yEliMHfuwLHCvA9grPnQPuBYs/fFc77Cg4mwq1d+DcgSqfo3ff0jjr4/iew1bWUkVfZcqlZcwQZLpYjNVNG7ZEcIWIGH0/rzEnJ6A1Shxbc2mDDN+VD4iplhzPiydO8xudSpu4TtLuqLr5q2jU4CFuJqZY/aQy+mCBlr5WbWhYt5l6DISlDVmCQaZPnOIDuNR0cpEd9WSTIFkHFv11vsZzL9I0Ha4EEcsIpY1jJE0ww4NXYjbzUNWtWey9Uttqz+4ThOVpiVVxwLxT4LBxK1x7VM6hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AUE+gg4fRtkVbI6855PHnVfhbc295MxS+o308yrrVo=;
 b=EExAuQ/n+Cq9dyCe8wJGpk28wRVoZ5uPYR/ecKmCS7GOwihhGPf29MpYABg/cf7VlfFr6fPjCBZbBr6ttH9+IN67eYxtWqMrpK02tg/u+rhjYFFH1Zr/MeINgWNy9+/Pq1R/pMAdG4qez09RbHhlk2Q4l5Ied6it28tqQ5HP980=
Received: from PH7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::15)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 20:02:55 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::a7) by PH7P222CA0004.outlook.office365.com
 (2603:10b6:510:33a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 20:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 20:02:54 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 15:02:53 -0500
Message-ID: <98c1f8e2-3b24-49c4-b5fc-506e4283248d@amd.com>
Date: Thu, 11 Jul 2024 15:02:52 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
Subject: Re: [RFC 3/5] selftests: KVM: SEV IOCTL test
To: Tom Lendacky <thomas.lendacky@amd.com>, <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <michael.roth@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
 <8870ca39-f5a9-8d33-3372-77a6693ad739@amd.com>
Content-Language: en-US
In-Reply-To: <8870ca39-f5a9-8d33-3372-77a6693ad739@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f19d82-7c55-4ea1-cf2a-08dca1e47416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tml5T05YQnE4c0dZVkc4RlpHZW81WVRhN1hKS0VyLzlKd25EbkJsSDYvWUsx?=
 =?utf-8?B?T29rTGJoMExSam9YR0k2MENHbE5lQVN3UlpxaW1EeTB3R1dyZzJTWS9hamZw?=
 =?utf-8?B?NzdkWGJqTGVyQ2cwUVcvaW9RZFFNVHVVaC9hRVB6VFdPdVM0TFRFeXRhc2VZ?=
 =?utf-8?B?N3F5TGh5dU56RDV5K0orOGViRFM1TXdLWG5GYm9NMDhEUmZIVm9NQm1kTk1G?=
 =?utf-8?B?UDR5ZkUxVEcwbW1pL2hDc0N3QzVHQjRXblBTTC9xK2FqdFBvcGlmZ3VhRGlD?=
 =?utf-8?B?MkxxMFIzK2dKbktQRFZZR0dwcEdjL0NOejZWQnlUOGl4QUlMY3kyTzZxbWNk?=
 =?utf-8?B?bml2ZDhEM3gvZzI0N2VxVkY3blU0dzJ1d1JqNkZzK0tLQjlXREhGUUtvUENV?=
 =?utf-8?B?bzlaamJUT1BpaSs4Z1hEeGZKYzErL09WZEZmU01rZ00wWE5qNmQyTklaZkZC?=
 =?utf-8?B?WHVxUVBpS1NGL3RmWXluU1B5RFVrZ1FMczY1RGNlR0grWGFiMUhOdEdtM2dU?=
 =?utf-8?B?WVFqWUMyRnVSSnRxdk9kRm9tZjZvYngzZVh5RVh0R3pLZ0Q2S04yM1ZaS0cr?=
 =?utf-8?B?cy96UmlwbUxNRlVST1NFNHhObEdFNnlxZFBaUjlCallRTkVtZGllSkpDM0p2?=
 =?utf-8?B?RVVXQU16WnBvS1Z4U042TDNnQVdISHp1T3ZweWhPN1JxSFFjMzU1Rk1rWWls?=
 =?utf-8?B?ZmhYTmdjSXJ3eUJ3cU9mMXhZeTB3Rnl4MUZCUURzUVp5eDdnZnlTeFI5aDFS?=
 =?utf-8?B?Y3V0d2FjSFpBWCtEenI5MzA2YTNDcEJZNzFnaGU2NGVoUm1VQlA4WWNBMkxS?=
 =?utf-8?B?QlVhSVdkMmI0bWhTblYvTHIxY2d1ZE5hcXdDQTNJSThrcWxXSnc2Zkg5cXBX?=
 =?utf-8?B?cHE2WTBBOGdJQ1F4alRxUjg5VXB4RndlWDFSU2l6ZGRwTjZaME12c2M2a1hC?=
 =?utf-8?B?d1pKQVA2c1A4bnNKVmk4Z2FGWXM4VW11YU1Fb2hOQ2Y3TllBUlA2QlZWRmRI?=
 =?utf-8?B?d3NkaWdzNXVjdzBzc0x2Nk1XWTdmL1JCUU5lNGhGdWVTSmZDZHFTb2VaTGRh?=
 =?utf-8?B?S0JzclpEU2hFYXpKVVp6YjZCZmpWdHVhYmV4RnZ6SWcySUYzVEhLNmxleXNC?=
 =?utf-8?B?RDV1M0ExbGxNOTVhY2ZLT05LS1Axd1RvR2xyQXdmeHhzZnJpRjRZcGlxTk9h?=
 =?utf-8?B?NVVSQ3ozdWRjSGk0cXVsMGo2TE1CSDIvVzJnNEdRWlNuMTB5ZkhvMWV3b1I5?=
 =?utf-8?B?bzFOa0xSZFBnYXQ4MFVVMXFJQ0k3c0Y5MjhBS29XUzh5cE5abDUzdHNHVi9X?=
 =?utf-8?B?blhuNGJFQXhKRzhUYTZzNGJURzZpTVhrUnAwcU04dXlmWDFVbWtjbG9kMmRH?=
 =?utf-8?B?OEpmbWxSVFhibVhkTmZCalUwRXVXcnBQeVprcHMvVHpxRlQ0WWUxQk44YXIv?=
 =?utf-8?B?bElwenNOWGZhNlRaY2xZNEhLWmdrUlRUK3JTVjZlaytrYWY2NTlqUWdhbDI5?=
 =?utf-8?B?MEIrQnZ1WTZQTEwzQXBrcGZIZ253R2QyRVlvR3ZjUm8vZUZsSGhkTkh0OG00?=
 =?utf-8?B?b2dCakJhUjBPSjZLVk9vOE1UemtLbVdPaWFjd1VwU0tEeEtCY3lZNCtsWUlm?=
 =?utf-8?B?V2QzMjI5cFlqNk9Demd6ZWM5RmNUZW12b1Z2ZXBPWFJxTkxhU2I0NXAzblRp?=
 =?utf-8?B?WWpCTU9mZGlSRTdqbFFxLzcyWWt6eHpIcVI3cFkyeVREbEUvREtYbTdiSElZ?=
 =?utf-8?B?SG9oQ0lPYnNGd0dPakN6aXJOL1RpWmhEUXdzVmxzQnROU0lZMW5WQVRkU2xQ?=
 =?utf-8?B?ODlTc1RjeTl2aEExaFFXL3hxcXVmSEtjS3VKalNVUE1jV1J3ZHpNbVdQa0I0?=
 =?utf-8?B?WXBTUjRKU05xeERLKzJxaHAreVZtVmVoTFVNWjdibzA5VzVuSGtuRGZkdTlI?=
 =?utf-8?Q?P+J2ZCesDtJJvDXiBaCNnXFfdgJsNV67?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 20:02:54.9066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f19d82-7c55-4ea1-cf2a-08dca1e47416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

Hi Tom

On 7/11/2024 1:34 PM, Tom Lendacky wrote:
> On 7/10/24 17:05, Pratik R. Sampat wrote:
>> Introduce tests for sev and sev-es ioctl that exercises the boot path
>> of launch, update and finish on an invalid policy.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 57 +++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> index 1a50a280173c..500c67b3793b 100644
>> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> @@ -131,12 +131,69 @@ static void test_sync_vmsa(uint32_t type, uint32_t policy)
>>  	kvm_vm_free(vm);
>>  }
>>  
>> +static void sev_guest_status_assert(struct kvm_vm *vm, uint32_t type)
>> +{
>> +	struct kvm_sev_guest_status status;
>> +	bool cond;
>> +	int ret;
>> +
>> +	ret = __vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +	TEST_ASSERT(cond,
>> +		    "KVM_SEV_GUEST_STATUS should fail, invalid VM Type.");
>> +}
>> +
>> +static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	struct ucall uc;
>> +	bool cond;
>> +	int ret;
>> +
> 
> Maybe a block comment here indicating what you're actually doing would
> be good, because I'm a bit confused.
> 
> A policy value of 0 is valid for SEV, so you expect each call to
> succeed, right? And, actually, for SEV-ES the launch start will succeed,
> too, but the launch update will fail because LAUNCH_UPDATE_VMSA is not
> valid for SEV, but then the launch measure should succeed. Is that
> right? What about the other calls?
> 

Sure, I can do that.
Yes for SEV, the policy value of 0 succeeds for everything except when
we try to run and we see a KVM_EXIT_IO.

For SEV-ES, with the policy value of 0 - we don't see launch_start
succeed. It fails with EIO in this case. Post that all the calls for
SEV-ES also fail subsequent to that. I guess the core idea behind this
test is to ensure that once the first bad case of launch_start fails, we
should see a cascading list of failures.

Thank you!
Pratik

> Thanks,
> Tom
> 
>> +	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>> +	ret = sev_vm_launch_start(vm, 0);
>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +	TEST_ASSERT(cond,
>> +		    "KVM_SEV_LAUNCH_START should fail, invalid policy.");
>> +
>> +	ret = sev_vm_launch_update(vm, policy);
>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +	TEST_ASSERT(cond,
>> +		    "KVM_SEV_LAUNCH_UPDATE should fail, invalid policy.");
>> +	sev_guest_status_assert(vm, type);
>> +
>> +	ret = sev_vm_launch_measure(vm, alloca(256));
>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +	TEST_ASSERT(cond,
>> +		    "KVM_SEV_LAUNCH_MEASURE should fail, invalid policy.");
>> +	sev_guest_status_assert(vm, type);
>> +
>> +	ret = sev_vm_launch_finish(vm);
>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +	TEST_ASSERT(cond,
>> +		    "KVM_SEV_LAUNCH_FINISH should fail, invalid policy.");
>> +	sev_guest_status_assert(vm, type);
>> +
>> +	vcpu_run(vcpu);
>> +	get_ucall(vcpu, &uc);
>> +	cond = type == KVM_X86_SEV_VM ?
>> +		vcpu->run->exit_reason == KVM_EXIT_IO :
>> +		vcpu->run->exit_reason == KVM_EXIT_FAIL_ENTRY;
>> +	TEST_ASSERT(cond,
>> +		    "vcpu_run should fail, invalid policy.");
>> +
>> +	kvm_vm_free(vm);
>> +}
>> +
>>  static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
>>  {
>>  	struct kvm_vcpu *vcpu;
>>  	struct kvm_vm *vm;
>>  	struct ucall uc;
>>  
>> +	test_sev_launch(guest_code, type, policy);
>> +
>>  	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>>  
>>  	/* TODO: Validate the measurement is as expected. */

