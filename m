Return-Path: <linux-kselftest+bounces-15228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6619508F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE47E1F25720
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95731A01C9;
	Tue, 13 Aug 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBhKxUY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DB19925A;
	Tue, 13 Aug 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562609; cv=fail; b=F3tcRDDu+wj7joNtVvkBjWm3McEmrjJMq3/FJ7b2gAVHVHSV8/qfXvNLJsYTgDgDiahyL/nGG5R9c/njPYHcrtaVP9F2J+5PIktyajGqDFgq1/7Qie1I2EHF2Ydec8tHb7Q7zkkDJUBP1UYbhX2lt6lMnV3aeUa48VVKle8u/HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562609; c=relaxed/simple;
	bh=A0GCPFPdtokvpOhZItbsthPxWH2DzRh7SgOOliZ00Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PARw8IjcHeIGetfJzakP7Af67duRUr8gD/3dShL6GQ6/kTAz0Go5crsOSVo7/Ik7mNaYh+iFZqmOBXvVimHF4kgCXZQmU1uikk0jmT9C9eY9pYaJq6Bw7kw55SZIjKsE9PZdGkZethrI0v3BWUaRzGyDQ9OZzRcm0DkLNsuYOC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBhKxUY6; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fW0/Q2QdKSNVfEPF6B7ot0P0y49VQVKgZQtP6SfJAmreZ6HyGx6DPHAmgFRJ7S1331JX34e62efNjXDHiYnkxmjFtGZGC+PjTFMx4tDAQdV6a9G0AETdu5KDcuDOvIAJo/644UxYc43efy0KHTmV1ld2vDVuTNYsWuBxRYbDY3npxIkwHOhJ0gIM/8W7FFaiDb9x7EaihTy4VYKcJSreneuQ8fkhBKoB/nS1DBz9ZtqM8vgvE8YT6KiRrBfSR/VZOXnZ+kxUI8jRsVDN40Z8VULIB5Cje5t6s13vIj6/4r7r/DPES2EtAHyBJ6Wzg/5BbTruJB7bKSUET5o15qlFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87YXr56BOy5MRLZRCZkDDEMyV6/bqYLUVPpn9RiTdEM=;
 b=GNfDuzz/qcGIRPjf8WHXRCbSqsg6Y7kA2YrWUcT6+Gpgc2JuAwyvNdsW5jORUPCTPaPC/f26k1TS1/LfGak2xXJYJqhTrCDIZphgtsMXWzfexfsF5L21O25RYVEF3xoTBm+wfzG0lkx8XtHWzL6RqoD4NrD0u8eMhyIxwqf/lksms2HzlBhqpIZy/PwA3A/c2jPDhf8u4Gw963OTmkny10hrfSVDOm9FkTPXiVsR5nZRVVupfkKWdsOOegakjs8T0jRxxBsV2PGsnUDCdj2hwtP+lmElaNqkYy6e0a4u0RsujdPhBn0Rb4N3WCg6ZlygikdJElg0QG0+QFExvIKUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87YXr56BOy5MRLZRCZkDDEMyV6/bqYLUVPpn9RiTdEM=;
 b=OBhKxUY6o+ByenQnFw55HEunufHIe6momSfVNVlKMZ7eJlKdux8pWgm3gw8Qp3Or3aAFhcuOJswsUIeKxkFMrA7nkl+Xgrxkn831dc8XRe2R2Y85yj4vNZWgLNEM66B8p0pfG364TYBXBXg2J2150DUOpc7+wx8ZvRIRQAhW2RQ=
Received: from CH0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:610:11a::6)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:23:22 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::1a) by CH0PR03CA0357.outlook.office365.com
 (2603:10b6:610:11a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 15:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 15:23:22 +0000
Received: from [10.236.31.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 10:23:21 -0500
Message-ID: <5556f872-22fa-44dc-8c25-037b30797fed@amd.com>
Date: Tue, 13 Aug 2024 10:23:15 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] selftests: KVM: SNP IOCTL test
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <shuah@kernel.org>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
 <ZrY6Z4mbbohVRbEh@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZrY6Z4mbbohVRbEh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3b32dd-a3b6-423c-a0ff-08dcbbabde37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3BDWS9iSHJxalNZSGtycnJldXY2Z2VYN0xHZGZxWGlaMW1FWWN2U1ZETEE1?=
 =?utf-8?B?aWR2OTZqSUwydG1oMk1UdjBVY3VLZG1WRVc3ZXE3dC8zNWlmcWhBemkxWVRC?=
 =?utf-8?B?MndqQU1Rc3pCUEsrdit5eU5nMVhMcU85ekhPcGtMb1BiZWN6NkdGUjA2NFFk?=
 =?utf-8?B?Z2xZWjBBb2VNU0F4SVhGT2l3N2hqZU82Q1hlazFZdk5zYVk0Q0xCazZRUjVu?=
 =?utf-8?B?YVNsMGpuMG5SNXNrek0yUG1DV25OeXRBcjU0aVpGZDBhVlB3VmxySDNnek1s?=
 =?utf-8?B?RDBmWHgzU2tsWlZhQi9CTWpodGpNemFPMVdQRU1STFNkaU5DRTdFc3dmOHVX?=
 =?utf-8?B?anJmWURQNW5HeUJvMXRRZW9qMGlqYmZhMHJQNmxRVW83dm96cGp3bEdocGJ0?=
 =?utf-8?B?VUJxeTdKZ0NUaER5dDZXbmhKQmQzVTdyMTc5Z0tLVVRGVzRLVFlWVXR6NXdB?=
 =?utf-8?B?b28yME1SSXFBTy80Z3BOWDJ6cUhIV2FZdTc3dyt5a0ZCMW9xUEFjQmkzYk9X?=
 =?utf-8?B?WmJzRkVndVV0WXNUZHJUYXljaWRLUlpBUW94MmpjUHJzaUM2SDdHTjMzZFBz?=
 =?utf-8?B?ZjBoczZxbFZVNXQzZlBYQ3pVMDQ0bTZqUjJmd3FVampIZmlkUDFldHBNZm5Q?=
 =?utf-8?B?VTNKZ2x1cjd5M1pYbGk3U3NKbSsxNHdJYVZINVpYRHJ5bzBiR3FLUnhCaW5D?=
 =?utf-8?B?U0Q2K3NFeVc1WnNNb3dBV1VLWFl1Vnkzd0tPL3ZsVktKUzg1TWt4ZitWRFJj?=
 =?utf-8?B?RCtjRE9hbWVLOExzMW1iM3pSOE90RkxEOXFFK1JaY2JxaVNsZWx6M2llZ1M1?=
 =?utf-8?B?akJzUWJNc1NoNVpWd252NjNQWkU2MS9WVkJlbFU3N2pGVFZDOG8vblFiTDF3?=
 =?utf-8?B?RDRQb1Vwc0NPWWlNSnlBQVVaR1prNVR3V1hvcFM3cmExUDF3bGtGRllBdnFM?=
 =?utf-8?B?Z3FiSXJCVVpwa2Z6TWg5R0xWMkZxT3ZmRU1JK1RpYWc3OFVlVFRXTGFYajdK?=
 =?utf-8?B?VGVxSk1RbWp2Qm9KODUvY254aDJ3NFZmaEg0SGZFRWQxSEc1WURQK1A2bUts?=
 =?utf-8?B?RjZOZXBFZjBtUTVsWDJWdm1UQUJyOEtvbnMzL25QbWo2eGZuQWNTbXVFQVJ2?=
 =?utf-8?B?MFNlZkFDQTljbzV6UmF6N1RKQmU4NCttWWJrU1oxcHdOY0lSTC9zbk9uZ2to?=
 =?utf-8?B?UExCZEtUTUdlWE5WZkdJazRWRWd5Rlp2ZFZIeTFUMXpWZHpYNGpEajVWazlx?=
 =?utf-8?B?TGhiekNDUlR6ZktZb3BpUWExUDNrbC9Rc3hlN3NjZmJtbS9lT2wxb3k0RXZR?=
 =?utf-8?B?Y2lYMHp6OFhxandrOHUxTm5CWTM0aHBBVFQrMHA2Nk9QYmVxakxYWjIwSk9C?=
 =?utf-8?B?Ynl2ZVlocUtNMThBdlBKc2grRGhtVTFlQ2tOelFWUmU1MUFiSDVLczJKTHZo?=
 =?utf-8?B?YU4yZE5Sc200VWw3MHV4L1dFS0ZGb01oUFA1ZkFhQ0NrRzc3dHZFTzV2VWQr?=
 =?utf-8?B?REE2RDdGb25PclV4WFlnRW1SNDczRjlHa1ZnZy9MZjdLWkdMUmdVaVhJaTYw?=
 =?utf-8?B?cmR2Mkl3UXVkemNzTFV3VmlpUmZ6VkRhcmcwNTl2OEtuOCtvLzhnWm5UWm14?=
 =?utf-8?B?MmxGZkMyenRiYVdHbWRUQTFKaUJiR3VhR3RVQStBZmthQXdTTE91MS9VNEVy?=
 =?utf-8?B?VFY3RGIxUm5xUUlsL0oxYVl5cDhkbUdRZUU1NE1xTW44VDFLUTNuemoyTkM0?=
 =?utf-8?B?RHJzc0tTcHM1LzBKcGk5ZDVBckpFaER0Z3NzNjRtOEF4d3FzcTZ4bFJnbW1F?=
 =?utf-8?B?akk5ekJYZXNMSmlIVXFWSlJucFpyS0VLWE5oanlFK2pxVFVNTWFBaG1DZEd6?=
 =?utf-8?B?bnhTRFhuY1ZWdmpDSGJQODE3elZxTytyNURkRXBDZG9uejNXSWQ3QkUvQnhk?=
 =?utf-8?Q?dHKP2oy2kIedwQcqtF6toT7T2g2/TBj9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:23:22.0819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3b32dd-a3b6-423c-a0ff-08dcbbabde37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522



On 8/9/2024 10:48 AM, Sean Christopherson wrote:
> On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
>> Introduce testing of SNP ioctl calls. This patch includes both positive
>> and negative tests of various parameters such as flags, page types and
>> policies.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 119 +++++++++++++++++-
>>  1 file changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> index 500c67b3793b..1d5c275c11b3 100644
>> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> @@ -186,13 +186,130 @@ static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
>>  	kvm_vm_free(vm);
>>  }
>>  
>> +static int spawn_snp_launch_start(uint32_t type, uint64_t policy, uint8_t flags)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	int ret;
>> +
>> +	vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> 
> Is a vCPU actually necessary/interesting?
> 

Yes, vcpu is not really needed here.
I could get away with a simple vm_create variant where I can pass the type.

>> +	ret = snp_vm_launch(vm, policy, flags);
>> +	kvm_vm_free(vm);
>> +
>> +	return ret;
>> +}
>> +
>> +static void test_snp_launch_start(uint32_t type, uint64_t policy)
>> +{
>> +	uint8_t i;
>> +	int ret;
>> +
>> +	ret = spawn_snp_launch_start(type, policy, 0);
> 
> s/spawn/__test, because "spawn" implies there's something living after this.
> 

Ack. Changed.

>> +	TEST_ASSERT(!ret,
>> +		    "KVM_SEV_SNP_LAUNCH_START should not fail, invalid flag.");
> 
> This should go away once vm_sev_ioctl() handles the assertion, but this assert
> message is bad (there's no invalid flag).
> 
>> +
>> +	for (i = 1; i < 8; i++) {
>> +		ret = spawn_snp_launch_start(type, policy, BIT(i));
>> +		TEST_ASSERT(ret && errno == EINVAL,
>> +			    "KVM_SEV_SNP_LAUNCH_START should fail, invalid flag.");
> 
> Print the flag, type, and policy.  In general, please think about what information
> would be helpful if this fails.

Right, I'll be more mindful of the error messages shown and try to
display more useful information from them for the overall series.

Thanks!
Pratik


