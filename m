Return-Path: <linux-kselftest+bounces-20308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217259A9108
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC542810D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBB61FDFBE;
	Mon, 21 Oct 2024 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4zOl42o7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B041FBCBC;
	Mon, 21 Oct 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542200; cv=fail; b=OYhUjFZ9eHGB7wPVcp+C21Ts+qlFZB2v4j+SF2yDhB7jnBcqZZlaUaxmYWr9KWSZPCKWZnOTYgt7X/CBvTskDzdf0njGowD+QPR/APgqm9G1jSZqWz960onxFwJ9Z4B2Hd7ei7uw80jAk8O5DvcluOsWsGnBTFCxuJER8XRwWR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542200; c=relaxed/simple;
	bh=TWAHcGJmuD6zluOy5Emcw7udWvmIWnJCSXHyWKAacp0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=YYc/nlqWihkcFPd5mVImuU671n32UZPqRWhM2qYIRJeMlNXAzmuHs3+JvCJbfdia6+gvv071JmGzgxqNY8D8TtPRfhdyim/NB+l3I55LsXVeq2kDXsOL9vcCa82+9MSTQzs/040zDGU/LOcccXETWJm5CDrOf+M+V0osoJd3/e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4zOl42o7; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC0yGOTxQGwGzJMeOoEM7ujrAeMdl27+SnjsNk2YrIJeD4KZnamMpxIhv/6FJSq4gbWgSVQ17iCwluqhZ3MlvvXIHxojqPp54cVSSh2NVR8wDLr6xxgteVQIZ+HEWltRjaG+TNwkeiJHq039YYXhsZ8NclwfQeEPTE/aURmCjBwDFYWhBE9BxIpOiCK03nl1XroCjDwf74VNC9lNOEqzfHDNrCjLlxUuyGiOfxR9CD/BLbAQj+hGFPnUEUNccWEwhtYiploTQWdFrCJq5XAXUEsPBaN6RpQnT9kaHC8tBp3z5D6CQiIWhztSu5LzWxk4C5y3ElRVQd9k3SymyXkvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhY+6oxjHedkqRjVIx+0Lyroc0qw0/FnmxE5/miRpwM=;
 b=tc+B4vJAYhRr6ZNpEtsswPnwEjsCh6/+SszP6+eS8qK6jfOleF3hz+4pFqIvD+/XNrpeD2wpC1ZuAkWbJYenoFUTf/jjdOQqmrKQly/Kpm5ttChskwKT25lL+NQjXItwaOS+ez9m+uweaEaXIN6ObV8SfiWpeg8EvpvQtaLJtdmRGUM7CvDbLdb0LkVsgG18pKWPxRfu/bIyI7O8pwAv6V9EnXptQ5MCoOyPE6Qz4iNhQxEMoPEtMRQcug6AYB9XEZsmtit2/LtuVuAUk7kSOZ6nhr+pZUC1F1+G5ozxm9phHBXA7HF445+4yalmorI1YMm4otHYY0kISAnpplm+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhY+6oxjHedkqRjVIx+0Lyroc0qw0/FnmxE5/miRpwM=;
 b=4zOl42o7IEgh5uWqAmAAygzUcEpCNUBR6KAvdtacCS4ohapVAP20OY30f1HGXheBT7fszYbCQgOE9634bSroazkHN6/G7eOZROpvbRVba28iKvMi/tbleY9JTWZWpusAJYIXtSEpg4cPTofHVdYe4IBlKqni7WTTqVpCBfb7h2Q=
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 21 Oct
 2024 20:23:14 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::df) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 20:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 20:23:14 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 15:23:12 -0500
Message-ID: <7ea459c0-7e9b-4274-a888-5f42a90aecc1@amd.com>
Date: Mon, 21 Oct 2024 15:23:12 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Subject: Re: [PATCH v3 1/9] KVM: selftests: Decouple SEV ioctls from asserts
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-2-pratikrajesh.sampat@amd.com>
 <Zw2Yz3mOMYggOPKK@google.com>
Content-Language: en-US
In-Reply-To: <Zw2Yz3mOMYggOPKK@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 35252ee6-a212-4a17-e149-08dcf20e30c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy8wWDFTTng0LzMxYkdkaUtCbklVMzVlVUlkUUZLcUFZSE5ndW00a3QyREpG?=
 =?utf-8?B?bGM2Wk5lR1AzTTZnVWk3RVU4dFVTR1dPVWpiWDJaUFNJVGhnMDN2MHRrem9T?=
 =?utf-8?B?TjJXNWw5bzlZN1pUMW12V210cllSM0RCY3NqSmV4SmowYVcvejZQV1lFM3A2?=
 =?utf-8?B?RHR6dlJ2QU1salhUODlmR0JUdW1oOVd1OEY0ME1UNTh1b3VTMWo3WWQ2Q3Bw?=
 =?utf-8?B?cnJEamVyaTBOeGJFemprTFlvL3dTQVNuRE44ZDQ2eXZPbDA3aWtraGd6Tk02?=
 =?utf-8?B?THFwNVh2LzlXdHlCbWQwK0xJTytVZ2ZGaUI5Tm5CN0M5V01aWE5KZVE2SjFU?=
 =?utf-8?B?cTJhTDZhQ1hiNEhHYW9KVTY3QjZvMk1PVXNyY0Uvd1F1bldCNTlJbyszQXp5?=
 =?utf-8?B?TlgzNE0yUlh3QlNsYUc1c21jNVgrdU54VnJKOFl4d3VOYzRrWWN2NnBLU3FF?=
 =?utf-8?B?K08wRi9xUGxLdWZTeG5CVVhSSDdnYW40dlhDbUZaMXl4TkkyczEvWDk0Y2Ja?=
 =?utf-8?B?NzlHb3Bxck1Fb1VRK0tOVnNwcFdHQzBSNFNWVitCWGhsOHNaNUk0ejl5S051?=
 =?utf-8?B?UVJVNUtlRnhvaDdWTmxTU2t6S3JQUkRpbE1TR200b3FxVU5UYkg5amJFUitw?=
 =?utf-8?B?UjlZVG9YUlRGVThTc0pjTzdhbmFkRmpkRit6RFE2aEhuSUlZd1VWZmZoYXd1?=
 =?utf-8?B?Y1Zrc3pMOEx0ck02ODJaQkM3VDJkWFV3cmQ0QU9sTllST1JyWHU4UEZ0M2ls?=
 =?utf-8?B?ZHczMW9pUUtTKy9VMFNHbE5NRE9TTHhHUnpxTmRNSWd0VjVkcHJTRWxaUW84?=
 =?utf-8?B?V0JVRjZSVVhEdnBHV2NkMmRzTXpKSXg5SUwxQlRvc0JnTUprWXVlYjhEVHVT?=
 =?utf-8?B?VzEzQy9oaHFHeFZyRm0zK3dTZFQyZ1J4bUtjampSWmhtNktzeDZaUWFnQ0Yw?=
 =?utf-8?B?blcxZk5QV1NOQTdFZVQrL2ZxcWVTQSthQUJBZDlaY3k1VFNSOTQ3OTYzeVVC?=
 =?utf-8?B?Q1JVdTFPdzdGaVFRaFM3eVRjRm5UWVJjUXU1UU1aRDhWVlJWazNjbytraDZI?=
 =?utf-8?B?UktKYWJTSXhsSmpiOVJ2VithWjB2RE9CYmR3SWtENys5VTV6S1A3dkhOVDBp?=
 =?utf-8?B?ZzhHVWk0U3dlVnpDRGFGOUJpdmJlU24vS2VYeXUxYysvZE5UTXIrWUlSMGp0?=
 =?utf-8?B?T2tQTktCa0tGRlJSOWZrWDEralFFNFREa2tadTdtL3NQbmZwVStQZ2Jmdmox?=
 =?utf-8?B?SDJnNEdYdlNVd3c2emlhMVE0bzNUQWlKSTErT21nVmxBcjZSVDdwMThBUUpa?=
 =?utf-8?B?b1dMYjJYOFd3cUQrMXRiZ2hzRWwyNW02bHVIU3A0TklmT3BIOWFNeGY4OFFD?=
 =?utf-8?B?ZlZGT2FiblhIRHUzYzl0aHBkbHd6dDhyT0M1NkpIZE5BZ21RbTB6RDFRTnJO?=
 =?utf-8?B?ZDltSm1GMHphdWpMeGNIaFVZWUFlMU5IeURnTFRtOXN5K2s2ckNpaldOeHJ3?=
 =?utf-8?B?ZkNNUm9BQW9GbWZuS3VON0U4SWFUSTBSbVM5cHl6amxkc0V4Zm5XWU5LL1No?=
 =?utf-8?B?dlZNc1pNMS9SSStFcXJiUWpmQ1NyQ1FTMDR3Ukh3eHh5TklmOVVoeWU5MzJ4?=
 =?utf-8?B?ZVRpVFgzdVVoM3kyUU9GM3krV3BLOFNJSDN2cENMVVdIalcwRVAvWjAySFpK?=
 =?utf-8?B?ZEE2RU1YRWxHS3BzL2tlVFgrYVp0amxrdDdETG9aU0pQdTFMRzBIeW1Wc0Fa?=
 =?utf-8?B?d01la3RKOW5lRFRjaFMwbDNERFdxVXFnUjJJV21seHMxeDVCdmNWbnRIVGpm?=
 =?utf-8?B?eHVuSlVrd0F6UEVYNzF0ZjBTQklxdithcE1TZnM3cTJLQWs5cENVb0lTTWI2?=
 =?utf-8?B?RkxiWU5XN0IrQnYra282M3BrVXRpK3phYnlKQUlrY0tyTnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:23:14.0165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35252ee6-a212-4a17-e149-08dcf20e30c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878

Hi Sean,

On 10/14/2024 5:18 PM, Sean Christopherson wrote:
> On Thu, Sep 05, 2024, Pratik R. Sampat wrote:
>> +static inline int __sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>> +					   uint64_t hva, uint64_t size)
>>  {
>>  	struct kvm_sev_launch_update_data update_data = {
>> -		.uaddr = (unsigned long)addr_gpa2hva(vm, gpa),
>> +		.uaddr = hva,
>>  		.len = size,
>>  	};
>>  
>> -	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
>> +	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
>> +}
>> +
>> +static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>> +					  uint64_t hva, uint64_t size)
>> +{
>> +	int ret = __sev_launch_update_data(vm, gpa, hva, size);
>> +
>> +	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
>>  }
>>  
>>  #endif /* SELFTEST_KVM_SEV_H */
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> index e9535ee20b7f..125a72246e09 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> @@ -14,15 +14,16 @@
>>   * and find the first range, but that's correct because the condition
>>   * expression would cause us to quit the loop.
>>   */
>> -static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
>> +static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
> 
> This is all kinds of wrong.  encrypt_region() should never fail.  And by allowing
> it to fail, any unexpected failure becomes harder to debug.  It's also a lie,
> because sev_register_encrypted_memory() isn't allowed to fail, and I would bet
> that most readers would expect _that_ call to fail given the name.
> 
> The granularity is also poor, and the complete lack of idempotency is going to
> be problematic.  E.g. only the first region is actually tested, and if someone
> tries to do negative testing on multiple regions, sev_register_encrypted_memory()
> will fail due to trying to re-encrypt a region.
> 
> __sev_vm_launch_update() has similar issues.  encrypt_region() is allowed to
> fail, but its call to KVM_SEV_LAUNCH_UPDATE_VMSA is not.
> 
> And peeking ahead, passing an @assert parameter to __test_snp_launch_start() (or
> any helper) is a non-starter.  Readers should not have to dive into a helper's
> implementation to understand that this
> 
>   __test_snp_launch_start(type, policy, 0, true);
> 
> is a happy path and this
> 
>   ret = __test_snp_launch_start(type, policy, BIT(i), false);
> 
> is a sad path.
> 
> And re-creating the VM every time is absurdly wasteful.  While performance isn't
> a priority for selftests, there's no reason to make everything as slow as possible.
> 
> Even just passing the page type to encrypt_region() is confusing.  When the test
> is actually going to run the guest, applying ZERO and CPUID types to _all_ pages
> is completely nonsensical.
> 
> In general, I think trying to reuse the happy path's infrastructure is going to
> do more harm than good.  This is what I was trying to get at in my feedback for
> the previous version.
> 
> For negative tests, I would honestly say development them "from scratch", i.e.
> deliberately don't reuse the existing SEV-MEM/ES infrastructure.  It'll require
> more copy+paste to get rolling, but I suspect that the end result will be less
> churn and far easier to read.

This makes sense. I was trying to be as minimal as possible without a
lot of replication while trying to introduce the negative tests. I see
that this has created several issues of granularity, even general
correctness and overall has created more problems than it solves.

I will try to develop the negative interface separately tailored for
this specific use-case rather than piggybacking on the happy path when I
send out the patchset #2.

