Return-Path: <linux-kselftest+bounces-20309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512289A910E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C8F1C212DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D181FCF7E;
	Mon, 21 Oct 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JYA9V1j3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C901FDF85;
	Mon, 21 Oct 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542220; cv=fail; b=gPmOx8qvKMrixEenoDNA0o0W/V4c6WIjeUh/WWuafns5WZ5k0UtKMa2sXxh+3xrGacVRgEQ6SbfexxAfqyoWzoF15HJoAUSswtZT9512vq3Fwq/idDNEUmmsMmyMIUKyVa0+3odXxKEyhdC70/2lOoJc8Ul2YhNcuy0t7kIeXoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542220; c=relaxed/simple;
	bh=Qmlu9gMISQvIqDq5GfHCSh6JCS+Ker3yoToLAh6XYk8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=cD8aejeYy3UdwsyrsSYN5jGIyPEnEz7NnaBe0bJ0Lk6cP4s5T09JM92BBNKKVpL4tJQ7av8U4Zho72GerzezH3Z5sVpa8ExSxRJrnr/n8mOgMMveeeF5Q8pHdYYh9lVsTyWdviyxLyCZF5dsKknPXBeD0pzD/joW+nmw4x7Vp+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JYA9V1j3; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffMSHIwegcJgRqPFM5+UjoawLwO/Pml4tf4wMKVSRBdbcaZjgEFr8jfROIh0ITEnT38IdODaaZj++Ki5sB42NhXqh6OgWwpeCKI5PaMd+1N5wMUwlysuzBRJ066Q1CFXMsHHMM888i4Fl8MbeMbShZ5le+1Yj72NAizIziU8cLiLzwicFAWtQK7XqpH9tdiLgRIZTtAmOZzH+y3YSxKQ4zI0236DOcXc+eGoofevsCDV+kfGfg8nLNwUxPdqVvdhUbap3jf+neU9hGwgcuEM3lIuecAGTu5bM2RFfCF9v+qB0DJntcfCjeSUqp9uLwtyV9wlbND36Cxaa0AWDFQjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oja/NE3BI1HSZKVhr4MBX0LsrSN32PUtYUUpghRzVhc=;
 b=bUqSjYanCB3Ohxz3Citdgk4iR+dinpt/kTG3gOA8QNwz282yCRk+//+PnI4YGXQhgcjfl6P8hJL7e9mmZCbBHyBJGdYez3LD0MFA3b7u6kULFd8qFRE9P4FJkKOmCeg6vdUbXk45eXuoOWMy1wvQm6B9iM6dPzYCs4SdxGPk1o/cBeLaQZYJ25Jn0ldp6MZSC6H31KypM2G38HCHJdfV83gWbirbrqSNqpRIt14hSqrkEH+GfY0nWgpDqN2JsuIzDYINMPEzOwC7eD8USH1rI13FCux3pTYqdinwkVeouwLkRt92zxSICS9jkf7Bb0nsKF+HrBr9ehZmM8MqR9l38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oja/NE3BI1HSZKVhr4MBX0LsrSN32PUtYUUpghRzVhc=;
 b=JYA9V1j3OLotIA6dnmEsiheli5pNLfSxh6v7947rZy4GOa3F/wBNHd7+IeOviz0nNmXJwkxsy7XFGS3NX+qlDlvo3yKfmY6z5yCwSNtgErRbwBSoBeMF5sWqQmDACXbZ5LwsoClRUSWcz0XPGaneLdHxwHTJz1fIsOagrR3dDi8=
Received: from MW3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:303:2b::18)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 20:23:33 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::fa) by MW3PR05CA0013.outlook.office365.com
 (2603:10b6:303:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 20:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 20:23:33 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 15:23:30 -0500
Message-ID: <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
Date: Mon, 21 Oct 2024 15:23:25 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com>
 <Zw2fW2AJU-_Yi5U6@google.com>
Content-Language: en-US
In-Reply-To: <Zw2fW2AJU-_Yi5U6@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eee86f0-d611-4d4d-fe61-08dcf20e3c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTRabFhXZTlpcHlXOFRiZXp5Sm45U3FKTGVIMS9pcE9MSlpkNlVLdW05WUZK?=
 =?utf-8?B?QkFyRy9IMm9OY001NHZaRWU0RXVMMkhveEtKdUNNSmRzM1RxaDFRUGVUVzVC?=
 =?utf-8?B?ZlZHV2NEN2h1a2wxU0pNcnBrc2l1bDRLZlhYV3dSOXRNY1ZmNnZJRllzcVhp?=
 =?utf-8?B?b2dOUFhONlBBRTk1UHBKUEVaZjVSRTdoL1RQQWRhcnpnNlRvYW9NVmN4OUEx?=
 =?utf-8?B?SjBDcUFWcnZJWktBS29vdDZHK2FFU2lpUk5NZFRYR1VUTlREOTVrZTdSbkc4?=
 =?utf-8?B?ZkN3RnNseHUzcnJYanBGMUUwTWhOUXoyeWN3Uno2dEQyZ3hmb21LOGN5bkxx?=
 =?utf-8?B?eDVJc0hxZ2FSZVIvN0pDTk5iSmtrSTlDODN2bjNPaVpXSXdpejREbXF4RVFG?=
 =?utf-8?B?NjcxQTNOb3FoTFhLcGJ5TVMvMThFTGNtM2liMS9MME4xRjhOelFpVlQyWUVM?=
 =?utf-8?B?UEFqR2dQTUg5dEZLRmVJczl2akluRjV2SUhTam1UbzRTejBDUVNJcGZ5MUtu?=
 =?utf-8?B?NXB1UmNpTmh2eUk1VGRuRTlpZ3gxZmpoc3hHOW9TQ3poMGw1T0cvelc4cWky?=
 =?utf-8?B?ZlFvZ3BOMGppdGNjNzlwSDJpakwvVnY3M296blZKVW1rcEtraXJyYng2dDU2?=
 =?utf-8?B?RDljRzlVeVZkN0lzVllSaXE5eGNMZ2pZcEVrRVNtcXgvdFlHUTRJNkNvTVhM?=
 =?utf-8?B?ci9sQjNlQnhlenU5RlBFSkh2WTcrSXUxZUxDVVUwNThCTlVrclV1dnVsMmc0?=
 =?utf-8?B?UG5tN3BkaHJ4Ty84MnBIbmRDS210K3R5MlRXZVh5VElBRjM0TGRmcFZtZmtv?=
 =?utf-8?B?MmdIMEVRTTFPcldMSUIrVTdETlh3My9TQXA4Q2FCVFEydEhkSVBrams0TW9s?=
 =?utf-8?B?dXRXa0FxU3o4Q3pmZlgxTE8raFhGRHFIc2pDeW5CUTZsc0krN0pITFZzY2pU?=
 =?utf-8?B?UzB5VGtzUkI0M1N4OXZGSjV3dWxXeHZIS1RaZjNNQ0NrMmhTVnlVaXpPM1Z0?=
 =?utf-8?B?NWJBQUVsNS9namI1OS9mdFVCNEpNc2djYkdFM0Q5b29taGRkWUNGSi90c0lR?=
 =?utf-8?B?dWZhT1haTTdOMDBrNC9iWXN0aHRUbTI2aVRic0JPQ0hSeDlYVHdsbUdBVGxi?=
 =?utf-8?B?MkluSTNRZEdOK1djVkhjbTY4MjMrWDFFTExNeWdqRG82QWU3MVBsdzdsMXlz?=
 =?utf-8?B?SlBYQzhpK1ZpeXh6QUpyYVRPeXpNMmJlcDkvUklOeG1mZ1BMYm9UZGFOWlo1?=
 =?utf-8?B?NEJLSWcwLzI1VG43dGRySm1scTR6dDRzUnBBaThxZjMwUXpndVJ0eDdySk1S?=
 =?utf-8?B?bGFsNkd6b29uWkNmdzJMaEluVFU1MXc0YkJiQ25PS2JFeXM0NXJqa0NkaVky?=
 =?utf-8?B?clRkVnhYSFlZV01iVlJ2K3ZPbUlOR1I1cXJtVnJRZjFyTURIMENqcDVOQXN1?=
 =?utf-8?B?UVpnN1hLcDJSdEFVUWhDQWRIZjhwcjhPYi8xOTVIUE1HUHN4M3FPUSt4YlJy?=
 =?utf-8?B?WktTVWtPSVBWSzNpdzNQRCswdXF3OGFFdzNGSk5WWXBBY1lvdWlpR3QySnZm?=
 =?utf-8?B?SEdYWCtwclZ2TW5NdFgrM0lCRjMwVXEvM3NlNnVhYjJPclJablBQc2RXdGgw?=
 =?utf-8?B?YXpvU3RIbkdIWlhTN0I2YUM2cWt5MUpJdXAwVERPcEp2aWt5MG96dFFLRVBL?=
 =?utf-8?B?WFdBWFZlamd3L3hJVGRMaHdNOWFVRXRFRm5qSTVYR1F3MGNFYTQzS3ZvUkFj?=
 =?utf-8?B?b1liVnRpQTEzRXRPa1ZyQ0kxbDFzQ2djUlJqbHZtWi9ndmwxelR1a0I1c2Ft?=
 =?utf-8?B?QVhyWjJueUQzdFNsV3lRUnhKeG5xb1BSRFlYVXp2b3Ixb0RJdlFWQ215OCt5?=
 =?utf-8?B?K1FNWmh1L1Rac1pvMWhFdlZFLzFHRnlha3RtQi84V25ZMGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:23:33.3111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eee86f0-d611-4d4d-fe61-08dcf20e3c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483

Hi Sean,

Thank you for your comments.
...

>>  .../selftests/kvm/include/x86_64/processor.h  |   1 +
>>  .../selftests/kvm/include/x86_64/sev.h        |  54 +++++++-
>>  tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +-
>>  .../selftests/kvm/lib/x86_64/processor.c      |   6 +-
>>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 116 +++++++++++++++++-
>>  .../selftests/kvm/x86_64/sev_smoke_test.c     |  67 ++++++++--
>>  6 files changed, 230 insertions(+), 22 deletions(-)
> 
> There is *way* too much going on in this one patch.  There's at least 6+ patches
> worth of stuff here:
> 
>  1. Add x86 architectural defines
>  2. SNP ioctl() plumbing
>  3..N. Other misc plumbing, e.g. is_smt_active()
>  N+1. __vm_create() change to force GUEST_MEMFD for SNP
>  N+2. Whatever the ASSERT_SEV_POLICY() thing is doing, if it's actually necessary
>  N+3..M. Refactorings to existing code to prep for SNP
>  M+1. SNP support
> 
> In general, if you feel the urge to start a changelog paragraph with "Also,"
> that's a sign you need to break up the patch.

Sure. I will split this into multiple patches which should
form the basis of the #1 patch series.

> 
>> @@ -74,8 +95,18 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
>>  	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
>>  })
>>  
>> +/* Ensure policy is within bounds for SEV, SEV-ES */
>> +#define ASSERT_SEV_POLICY(type, policy)				\
>> +({									\
>> +	if (type == KVM_X86_SEV_VM || type == KVM_X86_SEV_ES_VM) {	\
>> +		TEST_ASSERT(policy < ((uint32_t)~0U),			\
>> +			    "Policy beyond bounds for SEV");		\
> 
> This is asinine.  First, there's one user, i.e. I see no reason to have a funky
> macro to assert on the type.  Second, _if_ this is a common macro, "type" can and
> should be incorporated into the assert.  Third, I have no idea why selftests is
> validating its own inputs to KVM.

It wasn't strictly necessary to validate this. Since the function
vm_sev_launch() now took a u64 in policy (for SNP), I thought it maybe
useful to validate u32 for the rest, as library function can be called
by other selftests as well. However, I do see your point that it doesn't
make too much sense for selftests to try and validate it's own inputs.

I'm open to both - reducing the macro to a just a check within the
function or removing the macro altogether.

> 
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> index 974bcd2df6d7..981f3c9fd1cf 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> @@ -625,7 +625,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
>>  	sync_global_to_guest(vm, host_cpu_is_amd);
>>  	sync_global_to_guest(vm, is_forced_emulation_enabled);
>>  
>> -	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
>> +	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
>> +	    vm->type == KVM_X86_SNP_VM) {
> 
> Probably time to add a helper, e.g. is_sev_vm() or something.  If we follow KVM's
> lead, then we'd have is_sev_vm(), is_sev_es_vm(), and is_sev_snp_vm(), where an
> SNP VM returns true for all of them.  Not sure I love that idea, just throwing it
> out there as one possibility.

Agreed. It will be cleaner to have helpers since similar checks are
being made in multiple places.

> 
>>  		struct kvm_sev_init init = { 0 };
>>  
>>  		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>> @@ -1134,7 +1135,8 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>>  
>>  void kvm_init_vm_address_properties(struct kvm_vm *vm)
>>  {
>> -	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
>> +	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
>> +	    vm->type == KVM_X86_SNP_VM) {
>>  		vm->arch.sev_fd = open_sev_dev_path_or_exit();
>>  		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
>>  		vm->gpa_tag_mask = vm->arch.c_bit;
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> index 125a72246e09..ff3824564854 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> @@ -14,7 +14,8 @@
>>   * and find the first range, but that's correct because the condition
>>   * expression would cause us to quit the loop.
>>   */
>> -static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
>> +static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
>> +			  uint8_t page_type)
>>  {
>>  	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
>>  	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
>> @@ -25,12 +26,23 @@ static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region
>>  	if (!sparsebit_any_set(protected_phy_pages))
>>  		return 0;
>>  
>> -	sev_register_encrypted_memory(vm, region);
>> +	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM)
> 
> And then this would be
> 
> 	if (!is_sev_snp_vm())

Ack.

> 
>> +		sev_register_encrypted_memory(vm, region);
>>  
>>  	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
>>  		const uint64_t size = (j - i + 1) * vm->page_size;
>>  		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
>>  
>> +		if (vm->type == KVM_X86_SNP_VM) {
>> +			vm_mem_set_private(vm, gpa_base + offset, size);
> 
> Setting memory private seems like something that should be done by common code,
> not by SNP specific code.

That's fair. I will make a helper for this and call this common code
separate from encrypt_region()

> 
>> @@ -158,6 +213,45 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
>>  	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
>>  }
>>  
>> +void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy)
>> +{
>> +	int ret = __snp_vm_launch_start(vm, policy, 0);
>> +
>> +	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_SNP_LAUNCH_START, ret, vm);
> 
> Please use vm_ioctl().  TEST_ASSERT_VM_VCPU_IOCTL() should pretty much never be
> used directly, the only exceptions are cases where '0' is not the only success
> value, e.g. for ioctls that return a file descriptor.

Sure. This was done for trying to be inclusive for the negative cases by
decoupling ioctl calls from their asserts. Since, code for negative
tests is are going to architected separately altogether, I will make
sure to clean this up with vm_ioctl() everywhere.

>> +static void guest_snp_code(void)
>> +{
>> +	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
>> +	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
>> +	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_SNP_ENABLED);
> 
> Read the MSR once.
> 
>> +
>> +	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
>> +	__asm__ __volatile__("rep; vmmcall");
> 
> Please add a vmgexit() helper (which I should have done as part of commit
> 40e09b3ccfac ("KVM: selftests: Add a basic SEV-ES smoke test")).
> 

Sure, will do so for this and apply to the other guest_code as well.

>> +}
>> +
>>  static void guest_sev_es_code(void)
>>  {
>>  	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
>> @@ -61,7 +82,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
>>  		abort();
>>  }
>>  
>> -static void test_sync_vmsa(uint32_t policy)
>> +static void test_sync_vmsa(uint32_t type, uint64_t policy)
>>  {
>>  	struct kvm_vcpu *vcpu;
>>  	struct kvm_vm *vm;
>> @@ -77,7 +98,10 @@ static void test_sync_vmsa(uint32_t policy)
>>  		.xcrs[0].value = XFEATURE_MASK_X87_AVX,
>>  	};
>>  
>> -	vm = vm_sev_create_with_one_vcpu(KVM_X86_SEV_ES_VM, guest_code_xsave, &vcpu);
>> +	TEST_ASSERT(type != KVM_X86_SEV_VM,
>> +		    "sync_vmsa only supported for SEV-ES and SNP VM types");
>> +
>> +	vm = vm_sev_create_with_one_vcpu(type, guest_code_xsave, &vcpu);
>>  	gva = vm_vaddr_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
>>  				    MEM_REGION_TEST_DATA);
>>  	hva = addr_gva2hva(vm, gva);
>> @@ -99,7 +123,7 @@ static void test_sync_vmsa(uint32_t policy)
>>  	    : "ymm4", "st", "st(1)", "st(2)", "st(3)", "st(4)", "st(5)", "st(6)", "st(7)");
>>  	vcpu_xsave_set(vcpu, &xsave);
>>  
>> -	vm_sev_launch(vm, SEV_POLICY_ES | policy, NULL);
>> +	vm_sev_launch(vm, policy, NULL);
>>  
>>  	/* This page is shared, so make it decrypted.  */
>>  	memset(hva, 0, 4096);
>> @@ -118,14 +142,12 @@ static void test_sync_vmsa(uint32_t policy)
>>  	kvm_vm_free(vm);
>>  }
>>  
>> -static void test_sev(void *guest_code, uint64_t policy)
>> +static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
>>  {
>>  	struct kvm_vcpu *vcpu;
>>  	struct kvm_vm *vm;
>>  	struct ucall uc;
>>  
>> -	uint32_t type = policy & SEV_POLICY_ES ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
>> -
>>  	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>>  
>>  	/* TODO: Validate the measurement is as expected. */
>> @@ -134,7 +156,7 @@ static void test_sev(void *guest_code, uint64_t policy)
>>  	for (;;) {
>>  		vcpu_run(vcpu);
>>  
>> -		if (policy & SEV_POLICY_ES) {
>> +		if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
>>  			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
>>  				    "Wanted SYSTEM_EVENT, got %s",
>>  				    exit_reason_str(vcpu->run->exit_reason));
>> @@ -194,19 +216,38 @@ int main(int argc, char *argv[])
>>  {
>>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
>>  
>> -	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
>> -	test_sev(guest_sev_code, 0);
>> +	test_sev(guest_sev_code, KVM_X86_SEV_VM, SEV_POLICY_NO_DBG);
>> +	test_sev(guest_sev_code, KVM_X86_SEV_VM, 0);
> 
> To cut down on the amount of copy+paste, and line lengths, I vote to add separate
> wrappers, e.g.
> 
> 	test_sev(<policy>)
> 	test_sev_es(<policy>)
> 	test_sev_snp(<policy>);

Sure.

>>  
>>  	if (kvm_cpu_has(X86_FEATURE_SEV_ES)) {
>> -		test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>> -		test_sev(guest_sev_es_code, SEV_POLICY_ES);
>> +		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
> 
> Please wrap at ~80 chars.

Ack. Will do.

> 
> 
>> +		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
>>  
>>  		test_sev_es_shutdown();
>>  
>>  		if (kvm_has_cap(KVM_CAP_XCRS) &&
>>  		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
>> -			test_sync_vmsa(0);
>> -			test_sync_vmsa(SEV_POLICY_NO_DBG);
>> +			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
>> +			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>> +		}
>> +	}
>> +
>> +	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
> 
> Why do we need both?  KVM shouldn't advertise SNP if it's not supported.

My rationale behind needing this was that the feature can be advertised
but it may not have the right API major or minor release which could be
updated post boot and could determine it's support during runtime.

> 
>> +		unsigned long snp_policy = SNP_POLICY;
> 
> u64, no?

Yes, sorry for the oversight. Will change it to u64.

> 
>> +
>> +		if (unlikely(!is_smt_active()))
>> +			snp_policy &= ~SNP_POLICY_SMT;
> 
> Why does SNP_POLICY assume SMT?  And what is RSVD_MBO?  E.g. why not this?
> 
> 		u64 policy = is_smt_active() ? SNP_POLICY_SMT : SNP_POLICY;
> 

I think most systems support SMT so I enabled the bit in by default and
only unset it when there isn't any support.

RSVD_MBO is a reserved bit that must be set to one for SNP guest policy
to be enabled. The FW spec specifies this - Sec 4.3 Pg 27 - Guest Policy
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf

>> +
>> +		test_sev(guest_snp_code, KVM_X86_SNP_VM, snp_policy);
>> +		/* Test minimum firmware level */
>> +		test_sev(guest_snp_code, KVM_X86_SNP_VM,
>> +			 snp_policy |
>> +			 SNP_FW_VER_MAJOR(SNP_FW_REQ_VER_MAJOR) |
>> +			 SNP_FW_VER_MINOR(SNP_FW_REQ_VER_MINOR));
>> +
>> +		if (kvm_has_cap(KVM_CAP_XCRS) &&
>> +		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
> 
> Curly braces are unnecessary.

Ack.

Thanks again for the detailed review!

