Return-Path: <linux-kselftest+bounces-15227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3679508EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C56D1C22F08
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6619EEB7;
	Tue, 13 Aug 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DtXFdbM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854619925A;
	Tue, 13 Aug 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562594; cv=fail; b=riXR+UryLSr3vP+NYHcbqLzUyQeagjUGinfzUBFvzuE5hJjwrIw6tvAbmNfuRsgqX9Jz8w6TzKZ20Ja7EYdX7eczt/t+RTJLHg/9S/eSdV5DWeQNLTratTCS+0q3FJrEc7PvlTrAqy+wahixa6dBlx96qsqMiMZveO1K/VE4FKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562594; c=relaxed/simple;
	bh=XdVejaol+qYWTcvE/i7YtC0X9y7hlnG5WNkPISoz7uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vn1XPf+awPEwT2m9KFYPqKKKcrcFvU0vrF/gslptk3ZbYN8GFjl+USC3Bd9EJrRQmbIJjjk4Cw8eC2e+AFQZdZXSh4lv3CY7TCR3b1Z97ZNWZJhRLAhMu1UZfKr9tBK5NLcygjHDZ/8MDui3GJ6rz327hew3Ytp5hG9rfUliKcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DtXFdbM/; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdhzsisqQhzakOoP8zgU5FiALv8lVhDKZmQNFTjRYgmZ7NvhTnRgJ6rd15Or4DRrEeDmdYZV+fJbZEsLHLL+nkioa5WlacoV0vGHnpGJnDnJZxKBV/Lil5zYwFgl26beCdxvPs/3E1NqTUR6qXCYQB0ZMx7I5By9qa4eWEblfSWNlaFvz67kC56fhDcc2MGoMgor0zZT9C5KVxpj86bFHpuZD2QhOwAnQzcy349QrcmPal5p6LfQvvOutksMuWrNkdTD1F00n1z4aiWZTW2BzZraqkEyYZ6onsD9N7FwOnHTmeEEDlRjXkogl0Rl0jqus8hVMbCtdtMzBrB6zbHaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyQN+7vMFubnfGPDH818CrGGJWmV01Hkr4KzaR6GEAk=;
 b=G3CTAxlKrZ9v688Olfs939wJtTp4KSRXPanzcpCnKuua7LtGLv0JtQfbCo4xIWVsB/jwfgwc8ZJwyYoIf2wZpzsq2CnpxOFhyfBz6NaIcFt62JldfZwA55YFhcATUCgqkzxs8bATlDkoqzZQe1IcOT5jLb3PhPexjT2bWDolZFsAxlpaMc/u5XCfTiEpf32MMxIa1XO6qWoXDdqy6j/cUBJbxIfaWPKtBM4itlQhX7vuu2mE4uw9K8+t2MzaGZvj/l9EEYlq0bRRvtTlvdJuOL7ut6aMEqM/GlwtE3XQSlRG29tFLQiCMooWTH2YLQs/FVnJi7/MON70r1PAABNS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyQN+7vMFubnfGPDH818CrGGJWmV01Hkr4KzaR6GEAk=;
 b=DtXFdbM/JJDMjaZCpsNzH18GtmMMb219lh2A7qlq/h005tkqckXpoLueQZzHwQoIfX6jVam9kYCQWRyUJvYwNpaWDAVDBnx8314q99F5gLlpN25Kesgi8FqtVDRfC6EMdVs3Ve0lT65Tv2psO6KfYnFNR6ksICIuXbSl8NAGR1U=
Received: from CH2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:610:4c::29)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 15:23:07 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::2d) by CH2PR10CA0019.outlook.office365.com
 (2603:10b6:610:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Tue, 13 Aug 2024 15:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 15:23:06 +0000
Received: from [10.236.31.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 10:23:05 -0500
Message-ID: <5b32da03-addf-4f34-bcf4-76fbe420b8f5@amd.com>
Date: Tue, 13 Aug 2024 10:23:04 -0500
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
 <ZrY4e39Q2_WxhrkI@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZrY4e39Q2_WxhrkI@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 355200c3-5ced-44d8-cde7-08dcbbabd536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2FabEh2MTNpVjl2ekh6L01SMlozUU5hKzdrTVRDb1VqdEhNWEY1d25NRk5J?=
 =?utf-8?B?T2pTSEttdzhJbjJwRWVrUXJoeTVhWEJSbkcrMjR2dTM2bGZXdXpONEtYZFR5?=
 =?utf-8?B?RU1DbHYzb2o0UDJLMUNWR3dqbkNzRWEzNFlJV2N3T09GQVBjd0xSaUNRbnov?=
 =?utf-8?B?MFFjb1QyMk1TVUkvUHhnVWxYUUI2MFNhYkxmUTZ1OG0rYkhFbGRDWWxackhq?=
 =?utf-8?B?L2ZzY3hXWFIzZlp6NlpHcVdaVDh1MEJ3eXRWbGFoOXVCSzRUS2xhcFNYTW4y?=
 =?utf-8?B?ZFcrci8xZWQ1Y0Frd2hyMDNnWHdhdUpRYnZtZ003Q05WaTdwUWVXS0N6WndT?=
 =?utf-8?B?SlZnNS9EdHoyMGEwcjNtVy9aOThicHhFcnBib1JSZXl4RGVSeGs2MHRzcUZ4?=
 =?utf-8?B?ZzZTUnpicXAwZ3RJNVRoOEF6UFpXTUo3NHlaajZ1Rlk4YTVqZ1ZTNlVKWVM2?=
 =?utf-8?B?Z0krN3UyTC84OTVNMHpxMExxbGJIS0UvNTl4UHk2TmZMR0JlNXdpbmRCYzgw?=
 =?utf-8?B?aFVpOWVPRzZmRGErT1hkTTU1aG05a0laZzlUZWVOeFpGU29TM2Y0K2pleDZm?=
 =?utf-8?B?TFc4MENBdEpaUXBJa0UzQ2NsbnloYjhlQ2VlZzFqalZCVHBaZVZhOWVrUkY5?=
 =?utf-8?B?cTI5eW1PVFhISU03ZkR1L0NZclRPckozREhsdjRvWWZIU2FhVmdDcHdpMHEz?=
 =?utf-8?B?VyswZWd4Z0cxSEt6Q3E0Y0ZBMTcwY1BxNzQ5TWRxOHVlUnVKTlZjNlBXd1RL?=
 =?utf-8?B?dUppMWErRnRhbzVBNDF2Um9rdUlxY0wwdnF6TnF6cXBURDFXOHNoV2IyMmhS?=
 =?utf-8?B?dG9FKzdmMjU5Z3FDRXpPVmRkTnlBOHVhRGdNMk1JRTh1bHJnem10akVndDBl?=
 =?utf-8?B?MTVqQ3VDLzZjSEN0ZDh4MGQ4SDBoeGZQZzhtTnZzUStSdTBDYlV2aTNDWkhh?=
 =?utf-8?B?V1BsRVkweUJIVnpzeTB0bi9XSVU2RWRhSkRYWnRGNnQ0dzlkdTJLZktneE9T?=
 =?utf-8?B?YWtPb2RtNFZ3RlJseGZHMnd1Q2lhM3FVMTFUUmVBK0c2WHk2VWY1bm55UlNq?=
 =?utf-8?B?UkxkY1hBRkhBVXRscXdoK3FqbFVrSmxrU0FTN2hDOFllQ1h6eUxOQW4wMnhM?=
 =?utf-8?B?bHY5ajh6U3IveVk1MEo4c2JwZzgvRTB4Wk05a28vSzNYRm11dU5NbkM4WENh?=
 =?utf-8?B?WVZWZFJJcHNBeUpQODAyVU44S0o1OE8vRjRWS3h3cmYxSG96WVVUSFl1dUty?=
 =?utf-8?B?a01QZGFwUHdlSldNKzZZaDVKdHlXMTdlcDRNSmhNem1NcHdJYnlINmhwSmZB?=
 =?utf-8?B?YWI1RGljTVljc0FYRUdqRkVpbzZqUnI3V3hDMHVKcFUwRVc3QWhKazZGTlN2?=
 =?utf-8?B?ZkQwYmxmenZ4dWs4S1pYdnFVakp1NFlhVDNyeThzUFgrYTB6VVo4REN0bU1H?=
 =?utf-8?B?SUJFbHpZK0ZHTnJWbGdzdzdXc3REWS9Mb0J6MzdEdmliU3BpSVFtQ3FjSGp2?=
 =?utf-8?B?OHhwT3dEZnBiV29wcE1vUmo0dHRWZlJBWU1LS3JibTRYYllDKzErbU12aXdP?=
 =?utf-8?B?T1RVMEtrU2lPQ3FSd3QxR29uRFl0eWNiOU5Na1VpZHdZZ2duT0lCZG1XU09M?=
 =?utf-8?B?MG1EWW9USWRUbk5qaTlwOXh0S25JejNzSUhxRzloV05HMzNKZlRWSnVvQVcw?=
 =?utf-8?B?Q0xpNjR5bHN6bThxSFVHZktiWUthVzg2NjZTYllZTUljVUwwNURUbE5NUEoz?=
 =?utf-8?B?VmJaY2VKYVpISVJYbFFVMW5tbFBVZ3doa2lKS2pGVjlsTTFMQ3pnMWtsWlBn?=
 =?utf-8?B?MDUwVllQbXZpUXNjcjhNTW4wb2RTMmlwZDlVa1hyemowQTF4eCtWNkFVbUZ1?=
 =?utf-8?B?bld5b0VCWFJRay9WNWRzVDIvV2p3UVVtdUtMbEtnQmU5a1NyM3VlM1BpekZT?=
 =?utf-8?Q?H8q1LuffESkz1rpM10VmSt03OZCzsGSe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:23:06.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355200c3-5ced-44d8-cde7-08dcbbabd536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538

Hi Sean,

Thanks for your review.

On 8/9/2024 10:40 AM, Sean Christopherson wrote:
> On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
>> This commit separates the SEV, SEV-ES, SEV-SNP ioctl calls from its
> 
> Don't start with "This commit".  Please read Documentation/process/maintainer-kvm-x86.rst,
> and by extension, Documentation/process/maintainer-tip.rst.

Sure, I will frame the message better.

> 
>> positive test asserts. This is done so that negative tests can be
>> introduced and both kinds of testing can be performed independently
>> using the same base helpers of the ioctl.
>>
>> This commit also adds additional parameters such as flags to improve
>> testing coverage for the ioctls.
>>
>> Cleanups performed with no functional change intended.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../selftests/kvm/include/x86_64/sev.h        |  20 +--
>>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 145 ++++++++++++------
>>  2 files changed, 108 insertions(+), 57 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
>> index 43b6c52831b2..ef99151e13a7 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/sev.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
>> @@ -37,14 +37,16 @@ enum sev_guest_state {
>>  #define GHCB_MSR_TERM_REQ	0x100
>>  
>>  void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
>> -void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
>> -void sev_vm_launch_finish(struct kvm_vm *vm);
>> +int sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy);
>> +int sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy);
>> +int sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
>> +int sev_vm_launch_finish(struct kvm_vm *vm);
>>  
>>  bool is_kvm_snp_supported(void);
>>  
>> -void snp_vm_launch(struct kvm_vm *vm, uint32_t policy);
>> -void snp_vm_launch_update(struct kvm_vm *vm);
>> -void snp_vm_launch_finish(struct kvm_vm *vm);
>> +int snp_vm_launch(struct kvm_vm *vm, uint32_t policy, uint8_t flags);
>> +int snp_vm_launch_update(struct kvm_vm *vm, uint8_t page_type);
>> +int snp_vm_launch_finish(struct kvm_vm *vm, uint16_t flags);
>>  
>>  struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
>>  					   struct kvm_vcpu **cpu);
>> @@ -98,7 +100,7 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
>>  	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
>>  }
>>  
>> -static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>> +static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>>  					   uint64_t size, uint8_t type)
>>  {
>>  	struct kvm_sev_snp_launch_update update_data = {
>> @@ -108,10 +110,10 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>>  		.type = type,
>>  	};
>>  
>> -	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
>> +	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
> 
> Don't introduce APIs and then immediately rewrite all of the users.  If you want
> to rework similar APIs, do the rework, then add the new APIs.  Doing things in
> this order adds a pile of pointless churn.
> 
> But that's a moot point, because it's far easier to just add __snp_launch_update_data().
> And if you look through other APIs in kvm_util.h, you'll see that the strong
> preference is to let vm_ioctl(), or in this case vm_sev_ioctl(), do the heavy
> lifting.  Yeah, it requires copy+pasting marshalling parameters into the struct,
> but that's relatively uninteresting code, _and_ piggybacking the "good" version
> means you can't do things like pass in a garbage virtual address (because the
> "good" version always guarantees a good virtual address).

I am a little confused by this.

Are you suggesting that I leave the original functions intact with using
vm_sev_ioctl() and have an additional variant such as
__snp_launch_update_data() which calls into __vm_sev_ioctl() to decouple
the ioctl from the assert for negative asserts?

Or, do you suggest that I alter vm_sev_ioctl() to handle both positive
and negative asserts?

Thanks!
-Pratik


