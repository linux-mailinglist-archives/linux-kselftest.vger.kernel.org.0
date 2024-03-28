Return-Path: <linux-kselftest+bounces-6757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3463288FDD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575C61C2678C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB897D400;
	Thu, 28 Mar 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kIucKUep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A657CF21;
	Thu, 28 Mar 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624372; cv=fail; b=EEwTvoQaPuhqM2EsNxTihzRqeyYOZktMxHJKsibOmP6KRRDRwt3m5KH5l+slayzF2BKO4EcHO30Z2d6pBj7ZAgDs8vIRVXz81lde+RmEKGcgA5YqDCheN+ArHTI9kKg+wbrU/4xGmX3pSUAW+wkikoSrEj54LhAvd3LgN7oPXMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624372; c=relaxed/simple;
	bh=ZSWANyOF4oCnIm1EfIWatxZ9Wq19blHnJwdDJO4SeFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rH4h1eXxa90rzmvpBiKpymwQgCoFs+hXpg/IyscS72tuQsGmLvDM7zEll6UqxboAgAcQ8GtehGUPduZdL54/7jTpWzhZCYtPrx/sFSG03L+WMkOiCDaO1Qy5SDudUC9UuGQInb8JDkrixB++gnQ1iL04nPONpsPC2eNpgBgT/x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kIucKUep; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eslctlch5rmZ3RKKZjcpTlrXbkTY55k9ykbvjySgCcD/3T6vPEeJpEE5vUdZN9hx1qqkzhI1Qw0fUgs9V4jgjiA+CRWDzvQsWVmnf1Uplug7TSnqlsR43iKU0pHGIAg2jlULEV40fJlgGUI9i3QStmb8kZMQw/sSYos0sx58qeOFx8SLiYFOAM5ts18xoApZ62csKTzVpbYi15mVsWiiBFbQEyEbOrGEcbo9Qsg8w7FOqr7xNz1Or5kAp8C3AxCVncNZEJFVJHaVLZtFJmbijaFHYz4fvBy3ihCC4csAW8fcf1IprQXzS5pYOHXGOv5ewWiYsgYTu3uumdZaFs5L8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ufdNThy1pSnwJ+k9MnBeX2ZBnTKTt7bReeoqmlDpE=;
 b=nSgNXjiajOuynBVf7sO5D1LvObozHAwvt0q3UYeqasgBeRHW4zuRStaa/bSA9dEXkahSIbxyZSvn6gC8DbH2TbZGzfkqHLXYncQvV6dqbBB6A+/tHlWPpFnERcHL02wRziuSUQ4bpz+gh1w4ZkXp1BA3rPDk9z1LiHc9G0g5RN5kvK99M4QmhwoPUrP/gnpdcGrrz1xwS7Pji82oG0HhBlS+kLzlqLB/bF5RNRWzHF4UIg4aruKcZ4LKwyQtU824AHVidJrlQWFwR0t6NNEwmGqz1RjmMt3x2ZGlZ+SJr84MrTMkWTwccBgWBuc1LFTa8ULGYlFe2WcHYyqVMBIXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ufdNThy1pSnwJ+k9MnBeX2ZBnTKTt7bReeoqmlDpE=;
 b=kIucKUepQDYb1xyEYJVta6fJe4QXIoCc8FZvCrAEok2UBKuSBvE4mHdgMtUGdMvugh8oQt1/0oAnWcDa1GhkrJ89LgEZ0pQHK2juBwqKWlQGrj5kBIeZg/JZIusRcMuKl7MZ4AIJrrjG+TXhJPhcocUtuxXESQFGs/cslp89TCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 11:12:43 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 11:12:43 +0000
Message-ID: <9cf21f90-87eb-5a20-6501-111fbd08a31c@amd.com>
Date: Thu, 28 Mar 2024 16:42:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/3] KVM: selftests: Change __vm_create() to create a
 vm without in-kernel APIC
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240327054255.24626-1-manali.shukla@amd.com>
 <20240327054255.24626-3-manali.shukla@amd.com>
 <20240327-7ffafaa84cf972c38cc5f33c@orel>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20240327-7ffafaa84cf972c38cc5f33c@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b1a804-bc59-4da3-30a8-08dc4f17fd31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q0Jc1lXu5OXe7idjJZb/2aZugip34ybw4SGCROB2Sse6H5Sa/Y0e0h/B18UpMmwo4CdP0gwNwOMaMQ0cyRyyr+PwrVX5KgaKw+TGPco7qLp8e7g69Ww/srA2hEWzv1Ng+aNZKt5lBfmJuzDU3yajgJT0Ky+2FwrpQKwNM6xuGHuCFyvW4u7ZRJOKoOyMJ/vsJRXBldRCEdcQvf0iGpbmhs+hxo5v7LkMb+hLWdXgKnpEkGHrXmMyzEBIgV+ZuhDQGz5vvj3osnm527SfOcm+j5w8veYml8ofGwUfOtV/iZQKCuqMHzkWOhE4zKkV7ROH6GK6GAAZl2lT2bwn8dO5DSsZF77Z7BVzna2guFVDNup8C18mOw9J3YpYlIa4TMu0+JKyajjIyZJ1GSKK1HhSZOI5nEWm3uqAhavC/+JfAaj+Fs9JqJDscjazKWTcVbOlxiSQ554IN2PCC/gqHCj3ZkcQ3UKYavHzl+aZuMW7FdFwZVqkisK4ryM3P/M3qn7SoEgRs5gfcUComxFrqR0XhmwQ8PZKhFRe55r6QuuVKsZEQzatdFuT6vbD9sa5UMg9kv37aGEXs8fVn/MLKIPuQeJcgkBVuyJpWwXVGYViYiMdo4l7UesjdizlvT/SK9HWLo86DnBd3W5Yw9pqmSXRtifeEpK83oy00iA2TOHnzdM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlgwT2JXVVNwcXd4TkpuWjRvK2Z2cjVBeFZrbFBOeGxUeVNLcnhWYnByekFF?=
 =?utf-8?B?UzRSNnIvUG5uR1NRb0tPKzhQL0U4YVU2eXl0Zk9iQklEWmgzaU9ZdlF5eHM0?=
 =?utf-8?B?L0o2L2J3WEJweWtUMVhBVHY2cE1hMU94ampRcm9DSWJUdzVtWXZqMUhnMW9G?=
 =?utf-8?B?cFpYL3lKaGtxQkpGZDM1RzBIYThFVFE4eDY0UUhXbzlld3hwYjJmUlhRMXZN?=
 =?utf-8?B?dWhoaVNzUWd4eUN5aFNWcnhuendSR0VOcWFBNDRhUHE2cGxmQXUxdmtzYjZC?=
 =?utf-8?B?OGdWa0UvdEtCRkRtU0FpOUJHdUZTUUZSRkVBZmNYVlhZdGt0cnpOanJFSW9V?=
 =?utf-8?B?YnVJemFhRGdpWTFKV2RhamJoVkdUUGdGaGZMcmxVd1g5RWJrdnNERFRleE5u?=
 =?utf-8?B?T2tWU2w2YjZ3TnpsQ0JaTzZ5d2g0dWs2YURzNHAvMHZ5VEZqTGJTRXJiK0pO?=
 =?utf-8?B?ZmNGTG5ZUmNzckFTei9TWGIvOU1pZDBxOUdlUEIvbWx5Wk0zaXVJZkJPdkJh?=
 =?utf-8?B?TFBUdXllenNwM1VwYWFRcWRwd2RyUFhDRUNIeEo1RHc2Qm1VRUxKUjNZakFY?=
 =?utf-8?B?NDBpK0JFR0FNUURiU3ZmVFhCYUFFKzhPQm1MaHNHSkZyTDJ4T0NSVXc5VHBO?=
 =?utf-8?B?VnZhOWNraXVjdFFReElwWUJiMXpoZkh1YmEwaXNiNW1EeVRDblZTZkk0M1hw?=
 =?utf-8?B?RGtSK1ZSWk9wN1M0anpaQ3B6V0IrQktsNjMzSk1TRkU5R3BjRisyNDVqM05Z?=
 =?utf-8?B?blE1Rzgwa1ltbTBQQktBVTlvajFqWXBGbDJXM2tuL1R2OHUwU3RiSEZiL0NE?=
 =?utf-8?B?Z09JTlhMUmR4RkFSNnRtZVZmK1NhV0VSQnFKdGtxeHdIV0NDNS9UZ1dxalZv?=
 =?utf-8?B?YUdHUVM1TEd6bE16elJ2bkdMU2dHOE9PWmVaUVlEOVI3WUQrMmpFWEV3OUdS?=
 =?utf-8?B?aFQxMm91Uk9pNURnZStHTUZFbEt4RkJuQ09PZE90ZGVJenVnazZCR0NSOXll?=
 =?utf-8?B?dytKdjJMRGcwVWNMS241WTJNcVVhZHNFaXRSVU1KSlpZNE01REtHbDR1Z01T?=
 =?utf-8?B?MkNyaTZPSEN1cW1NK1JQL0R2Wk91YXpYckx3VWw0SldhREhnaFgxSFpsVFZX?=
 =?utf-8?B?blJJOHYzNzNCWVdYWTU1ekJOTkZIOXV4UThFMjY1V3BpUHYrN0JZUzd1NEVy?=
 =?utf-8?B?dElmY3FMbHp0SFFPc2tTSzVLcDNkSlorR0M3QTZpbmZnVENTTUtYbTRwQWZ6?=
 =?utf-8?B?ZFpBN0N1aDF1WUU4eGdnUi9OMWt5L1FHVXF3T1J1TTUzaGhMSDZ3ZEhzNUV4?=
 =?utf-8?B?RklnNnA5aTlmVUZGREVpUHc3dEdoVXFWdStkZzM5eHJlTDZzckZhNnhEdzZM?=
 =?utf-8?B?YnZNcEMrTlNBWkNMVHVDeTJLMjF0bXhhdDJJVmZ4ZTd1TkhPdklOcE11MHJY?=
 =?utf-8?B?L2dzOXkrbVU3ZlBaM2kvbXVtbklSc1FzMzNLOFRoRnh2ODE2R1JDT093THh2?=
 =?utf-8?B?a0Q2cWtycENGUHIxbGdWSFJNMzR4bFpCZjZNT29RNXU1Q1BaOElIaEprUm40?=
 =?utf-8?B?bTFIMU1DZTVrRE9RaFh5RC9jZHNPTzVsQStoTnozQ2xtbkJmb25oTE91VlZH?=
 =?utf-8?B?TDRJZGQzVkx2Y1hrMUJvWjRNZEMwY2M3UTdnSFVCNGJzdG93S29pWjJJUDF6?=
 =?utf-8?B?YWpwcGliU3NYWkxrZGQ1Vm9QU1FYbGUxdVNDYjZZNDE4cnFWWW10MmNpeU1j?=
 =?utf-8?B?dmpTMVYvZWV3b1dDZkVRRlpHeVRKSStrV01TRjBsK2thM1gvVEt6S25jc0JO?=
 =?utf-8?B?T3p3RUVrYWhXOHBvNHJTd0lrRlA4SFJKUzk4NzJKZ3gyMEJkdk0xYnZLRUFu?=
 =?utf-8?B?MVJMTE9leEtoK0VrazVpZWlWVHV1clBPdzFUYXRVWjE4Tkh4WHZmR0h5c1RY?=
 =?utf-8?B?ZDVZZGQwdkxiZEpCU1ZTUmJRTlc4QzlsWGovUERvTVZ2ckttYVBESmlGZmtQ?=
 =?utf-8?B?L2E2OGh6N2F1U0drUzRnbHdVQXJzZVh6MUlvRkRnNWdBZjJXTEVTZUZISjVQ?=
 =?utf-8?B?MUVIZENxbHJrU2w1SmM1Z3MyK0Fsdll6bTk0c2Z3ajZQMHMyWlpHVUlZdmhv?=
 =?utf-8?Q?6aFQkC3F5jVK+ZgYAcxl20bx8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b1a804-bc59-4da3-30a8-08dc4f17fd31
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 11:12:43.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EOXsRK2516B/o8yXNc1etmbJ4Us6pWLxCorggxhd3TvY+RXozFVLdIDvJfIR5GqeXwVt+IkiOElZN7LtFjqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

Hi Andrew,
Thank you for reviewing my patches.

On 3/27/2024 4:57 PM, Andrew Jones wrote:
> On Wed, Mar 27, 2024 at 05:42:54AM +0000, Manali Shukla wrote:
> ...
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
>> index 4a40b332115d..00e37c376cf3 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
>> @@ -879,7 +879,7 @@ static inline vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>>   */
>>  struct kvm_vm *____vm_create(struct vm_shape shape);
>>  struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>> -			   uint64_t nr_extra_pages);
>> +			   uint64_t nr_extra_pages, bool is_in_kernel_apic);
> 
> Adding boolean flag parameters to functions, which will 99% of the time be
> called with the same value set for them, is not nice.

Agreed.

> 
> ...
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index adc51b0712ca..9c2a9e216d80 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -354,7 +354,7 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
>>  }
>>  
>>  struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>> -			   uint64_t nr_extra_pages)
>> +			   uint64_t nr_extra_pages, bool is_in_kernel_apic)
>>  {
>>  	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>>  						 nr_extra_pages);
>> @@ -382,7 +382,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>>  	slot0 = memslot2region(vm, 0);
>>  	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
>>  
>> -	kvm_arch_vm_post_create(vm);
>> +	if (is_in_kernel_apic) {
>> +		kvm_arch_vm_post_create(vm);
>> +	} else {
>> +		sync_global_to_guest(vm, host_cpu_is_intel);
>> +		sync_global_to_guest(vm, host_cpu_is_amd);
>> +	}
> 
> __vm_create() is shared with other architectures, and duplicating part of
> kvm_arch_vm_post_create() here is not a good approach, even if the
> framework was only for x86.
> 
> I suggest:
> 
>  1. Extend vm_shape to include a flags field and create a flag called
>     NO_IRQCHIP
> 
>  2. Add a flags member to kvm_vm and set it to the value of vm_shape.flags
>     in ____vm_create()
> 
>  3. Check !(vm.flags & NO_IRQCHIP) in x86's kvm_arch_vm_post_create()
>     before calling vm_create_irqchip()
>     
> Then, in your tests, you'll create your vm shape with the NO_IRQCHIP flag
> set.

Sure. I will incorporate your suggestions in the next version.

> 
> Thanks,
> drew

- Manali


