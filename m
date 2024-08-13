Return-Path: <linux-kselftest+bounces-15232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D2950926
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A79C1F21932
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87A199245;
	Tue, 13 Aug 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FP3Rgjmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F91DFFD;
	Tue, 13 Aug 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563067; cv=fail; b=iQYPJ8JUb85t4qQhxt2kC6lMVZ/bxeB7dwkRBbk8763P1NHvF/WYxLFA6S3RvcZna9w5gDR5mSl9ns95FNxbJ64S30+9PxdvT2CzfS0thsIhAxM+3zpphRbKntBvbvSNYEgmkww/M3NpFmvbZVsnTIZtxatjbQmXrUUxO7AFnwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563067; c=relaxed/simple;
	bh=Ar23bZqxejZc31E5EOWqQvQ5StT3EUD6lGESeNXBnEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TWyR7zgZasFgzvr1Y9I/zanikxlMiTPeFtUOJWyit3MYsPzltJ94Q60BA4bLEg+Afbi/jfdAJvVeQowTW7+/UcRnheqTIaFN+rpYPoPoNfH47Pv517qQk3DmmMVWX/yPqttRKHUhFcR77XxV8HXRXpcTscLvRWG+Wfqw44MUzG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FP3Rgjmj; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmNluyWsEyeyy50C4KHDngfyc7CTV9t53H6ZPmxGTGa3knV8tTyOThCgTfbhVZXFmyycapLKqXBPNV1VlkTgs863gyXAvTUReat763r67odpwVWNsoRlcxwyDjlG8q3qUz12L3C4AnXvKjzpx61roOd5RTibWeYDCK+ow/MkfyVLNqC8aXz1ttmcew1D3to7INd4FIHhSu3G02lwfDHI9skNhopHQ0Z0hQwupIJabw03lpzei2aVaKZB7LD7MawExa3+enmSQiVtzSS8CrOeQrX4blGv+3GU5bnbiOqJE3n3eIFkQn0sVVsbUf1IYS8sQ+Nrn4a2cvQHdBxevPQgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TMegl5NFJuVy0YFZiStcxOqDI4Iit5tsPyIsuahTUM=;
 b=IyVZzH1/5JABvSYemxfUGsAhk53DbxUE4++N762xSXXtkJZo/m2trpCNrB/c0uArsGbNdE2Ag1x/x24lSEAV6jqadAztsjVuMvVyadrxm5/zaip02VgBGdsCI1C5miv9K035cRCfDaEUMBKvejS6aBYYEYmWxRp+Hnrhz4bHJ3JKohOlKNerwE6l4Wq1B+L279Zrr3QO8xiQEXjlVfxseMzcrkEfCvovMeq7AJG1UtOzLY1xFEIFu+ReddGA/izvookxnFbe7QiwSmFkJ1AMr8/GNZUrlbj3rdBkgZJ9H6tNR9Wt4a7P12ZQLqBYhJFu+TlWgVoCO2JUT+2tev6odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TMegl5NFJuVy0YFZiStcxOqDI4Iit5tsPyIsuahTUM=;
 b=FP3RgjmjYlXuRC3NftV+iCCsP8Q0/g1r2BOEAe+P++HVgtARwwHEPr+w2goReEA0ODs7mwqGaLubwFy33G2uK8OM3tSJF1n0cbk+xoqcAdOL9CgeEUhv2HBEjCjFSFhtCjOAvQl3bgSS7tnq/Ih36b6MA4Kt6EGLziqKnYZbspA=
Received: from BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42) by
 CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Tue, 13 Aug 2024 15:30:59 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::63) by BYAPR01CA0065.outlook.office365.com
 (2603:10b6:a03:94::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Tue, 13 Aug 2024 15:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 15:30:58 +0000
Received: from [10.236.31.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 10:30:57 -0500
Message-ID: <526c4e76-9269-4570-a13e-09171648a25d@amd.com>
Date: Tue, 13 Aug 2024 10:30:57 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <shuah@kernel.org>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
 <ZrY4e39Q2_WxhrkI@google.com> <5b32da03-addf-4f34-bcf4-76fbe420b8f5@amd.com>
 <Zrt7bRGQJ1C9XZGy@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <Zrt7bRGQJ1C9XZGy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7719c02c-3123-4b56-cbdf-08dcbbacee74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZta1hWZXZad004ZDhTRTNUZzVXUDdBeEMxQ3p6dnpzaE1RMmtjLzM2MGdh?=
 =?utf-8?B?MnZDM1plWWFURjErVWp4NjdSTXNqZ3czSmhPSDN5R1luaE9QZUZsaUMxY1Jk?=
 =?utf-8?B?OUQzZlozUHlxRThIUWlzRG5XQ3h4UDE0NzZKRGdBZFJ5OVpKNUtmS0x1eFVR?=
 =?utf-8?B?RXdobHRId1YvdDMwR0dodTNEczE4eEZCUW9YZEFjZ0o2bk45UTRWV011WjFG?=
 =?utf-8?B?RnB4Zm5BbUUxeHRjK3Y4TnhEN3lER3Q1UFhReU9vUWJHRm5WWjZkMHZHMXFh?=
 =?utf-8?B?MXEzd01Ec3Y1ZW9za2p6ZStRZTdGaHRHZW1SbGpKYy9ZSGJIckNWTGp4Tk1X?=
 =?utf-8?B?UXQybWFCMm1DR1VadWoyS3Q4LzVWbkU0ODNTVVNzTGZuREs4Z3BoaFh0d1c1?=
 =?utf-8?B?ZFZCS2N6U21pRFVBNW5pd2UyUDlNVDBES1hEWkI5Mi9ZWkxLbm9pWTlDczM3?=
 =?utf-8?B?ODVDczZ2Z21OTEVnRFkwODZINUw0Tm1EQzY5NElKSE9oQWR5djJ6bGlnbFZN?=
 =?utf-8?B?ZkF6ZURPZExja0hHbU45a1pCekJURWxsV082NnRHTUlRWklSbEpZT0dWLzNP?=
 =?utf-8?B?ZzZsRmdGbjYxcTlVeXhvWXMrTzMxWDh6SStwYnhXejI4VnptcG5UK2VkZFBL?=
 =?utf-8?B?Qmt0YnBlQzNZc0JqS0M3Rmk0ZDVPbzRwWWdLZzNCRUtGSHVFSGhZM1JEMVc2?=
 =?utf-8?B?M0lMMy8wd2pXcElicnRwMkRvK0pVRGVFRUd4ZXc3Mnd2djZJazRydEgwREtR?=
 =?utf-8?B?RDVWZDZ4ZnFPc0g5NXE4QURTMVd0ejBQQmtNZXVlcEt4VTR5bE1WcXY3ZHJ1?=
 =?utf-8?B?VnZ0d2QrU2NPQVZsaHg0Qm4vWnpwUjBFV213bHg0Yk83dE4weGNrR3dkd3lZ?=
 =?utf-8?B?ZDdGY1JCVVRFbndFZDdtUERDWENrbXVOU3dpQm1vVGhnbGY4d0l2R1oybXo0?=
 =?utf-8?B?OHhVSlhUUHFaTmowYTNtL0ZjUENBVVlpQzBsUWFmQUJOcXRaMXZ6dU1wMnZp?=
 =?utf-8?B?WTIyaEk4bUQwMEkvVW9JVFZtMnhmMk90UVNQcitRYzk5RDhvSDlvaFY0WW5j?=
 =?utf-8?B?cSt1OG5icGxGaDBmL1BWUGlMOHRVUnFQNUxrUUN3bzBnNjd4M1VqOEo2SmN0?=
 =?utf-8?B?bVJ2YjdsQTBScjJhbDE5MGxxNFJ6NEI3dUUyMkExVUx4L1hVTGd5Tm4vM3JL?=
 =?utf-8?B?ZHVxWUROdU5EbkNENUVSZUNSaUo0Ukd0MGlIbUpTRjEwRWszQlY2VWI1cm9F?=
 =?utf-8?B?K3VENk4yWk5xMDNNUmk1RDNZV0xZZVRaM2RTc200OFJJRzM3SEdjc0xSMnBa?=
 =?utf-8?B?eTMvNWxnYkFqeFA2VW8ySVFPMFpHQTl5bjJWcEIvL1hJZDJtT2QrenBONVhn?=
 =?utf-8?B?YXcxanVBNXlSL1VIeExVMVU4SEdQKzBPZkV3Q0pjOFN5Zml4SWxYZk81K09z?=
 =?utf-8?B?R0RXTDBUYlpGWmJzakVSM1ozYlBhSFlGVXVhaXZVOUVFRHJ0bzlrNXhRTmVY?=
 =?utf-8?B?RDlrUGRnVjhLNVBQT2hDd1dkYXZsNWRSRFBTMlRweCtucEtlRzFOYXVTVmhr?=
 =?utf-8?B?OFZmT3lrV1pzelducFR5THhYUy9QMDFBNW1zN3JzSjFQUUZManA5NE83NGhS?=
 =?utf-8?B?S05wSUkyamNPVnE1VEZsTzJ3dGR6eTljR0ZxY3ZGay9VVVZBNkxtNWl3dEFy?=
 =?utf-8?B?SkxoL0xOTVFVSGlzdkQrNFdYNkVrRHdoV2hYemt0YklTUTV1cDU2a201Y0RY?=
 =?utf-8?B?REZDbWphcWxLdGtGeXR6eGFXMEM3ZlBBaVBxM0tzNEZuR1lpVzNPMVJGcjJD?=
 =?utf-8?B?QlFaUDQrNzJKK0phR1IzMHhTVWhCV3ZFdmhCYk1pdll4YWdVTS83YzUvMVI2?=
 =?utf-8?B?RmIySWt2YTQ4a2VtejJ4TTFyRmdHVjBBQnBZTk5Od0RBV0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:30:58.7293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7719c02c-3123-4b56-cbdf-08dcbbacee74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708



On 8/13/2024 10:27 AM, Sean Christopherson wrote:
> On Tue, Aug 13, 2024, Pratik R. Sampat wrote:
>> On 8/9/2024 10:40 AM, Sean Christopherson wrote:
>>> On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
>>>> @@ -98,7 +100,7 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
>>>>  	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
>>>>  }
>>>>  
>>>> -static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>>>> +static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>>>>  					   uint64_t size, uint8_t type)
>>>>  {
>>>>  	struct kvm_sev_snp_launch_update update_data = {
>>>> @@ -108,10 +110,10 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>>>>  		.type = type,
>>>>  	};
>>>>  
>>>> -	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
>>>> +	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
>>>
>>> Don't introduce APIs and then immediately rewrite all of the users.  If you want
>>> to rework similar APIs, do the rework, then add the new APIs.  Doing things in
>>> this order adds a pile of pointless churn.
>>>
>>> But that's a moot point, because it's far easier to just add __snp_launch_update_data().
>>> And if you look through other APIs in kvm_util.h, you'll see that the strong
>>> preference is to let vm_ioctl(), or in this case vm_sev_ioctl(), do the heavy
>>> lifting.  Yeah, it requires copy+pasting marshalling parameters into the struct,
>>> but that's relatively uninteresting code, _and_ piggybacking the "good" version
>>> means you can't do things like pass in a garbage virtual address (because the
>>> "good" version always guarantees a good virtual address).
>>
>> I am a little confused by this.
>>
>> Are you suggesting that I leave the original functions intact with using
>> vm_sev_ioctl() and have an additional variant such as
>> __snp_launch_update_data() which calls into __vm_sev_ioctl() to decouple
>> the ioctl from the assert for negative asserts?
> 
> Yes, this one.

Got it. Thanks a lot!

> 
>> Or, do you suggest that I alter vm_sev_ioctl() to handle both positive
>> and negative asserts?
>>
>> Thanks!
>> -Pratik
>>


