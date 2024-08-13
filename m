Return-Path: <linux-kselftest+bounces-15229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A99508F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCE1282D75
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C61A08C2;
	Tue, 13 Aug 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y4K/7lF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D241A01BD;
	Tue, 13 Aug 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562611; cv=fail; b=pxuFN6iXckJITKJ93hMzRMjqiTIWtpLzJdZHaFTTcvmOzgn2Ub7hfRYbwY/P3+SxVDJo78nQIlvGIPS2vE0C0D+iqY76Pt1BRUOYOzTmcX56tpGmau9dYUqsMTOtC3+3aDm0QtTLzHCvwVYCPfJnOc6cziNwNA8HWgKqX+XvoFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562611; c=relaxed/simple;
	bh=1T1wm7ygHUC02a6ofkTksImo7ghgUAekxLom39zOTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kt+iMu9U6M1Emf1G9tF2Y0MUVvmSiq108x6f2s7yDEaVTorJidJSGZiaUdZzkGwyt8YrKmCQKqT2E02Nt+Ka0CSpN1RFsUkzKT76KIocmR2vFqF/PYC9jEvpaQCG2DNKlkH8BCg+wi1f14A2kovp5SiCCrBvR628wPuVBHkXPjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y4K/7lF3; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb8O74ssQActOFQPdSjycJLorykoNlvefXpSdc3/vx2XeoDKWSxZ1Ah4DF3OpaspTIe0+ejGjRZJzz2xSElWV64imf5St41L0+t5TeAfHsD2u+CMY+NtnwGSLDgmOa+gPM7dlu+MqwOhRbVVsAmlWobO4qDGnUBNiiUW9R2TNgudAbWVp6IMfoA3dXFIJ2aNYyjNIeF1aBMWoBXJNtMT63tyDhu//qzIluCmYoPNM9ov9XwBagxw7gO+ja58JiknHcIDBtwTw1IUaIKZr+pRu4+JZbYYkcFVicbEmsrbPKh3j63+yh7D6mbYZJ3L9/2woC0Pz80kcISmOPkA9R32OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX9U3yB+V6te+R78dFiai9zIP54SNW/FBGZPet5f97M=;
 b=tJfNt8O98G8OZfDikpPFjnDmdT5TBa+dEKu31xmsG+INdVk4uBxt6xtQFl9Y7S2mZdSa9Uxh2RQeMmh9D36PSRpOjPD8lqpP13QehTv9tYzN4O6lLeC5gZN5jlgFDm117/ytsXEZxUNtu4BG7bEOnwnY6OCngpQefmylSQTFefkP3bJeDdq1/BQOhLLtgy0Yx2Ie9JBAbcvaM+/q1GCIolXYGESKG2nSD99VAwDCfSN4aCG1lAogxhZkwTnJ924U+gff+X6PgCZCyfehthtn0RbbZz8FJL/x4eg0lovZKoUGBFrtxrrv4jVcFynXFI6x62WT/SX0vr1cB82qZCa+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX9U3yB+V6te+R78dFiai9zIP54SNW/FBGZPet5f97M=;
 b=y4K/7lF3aypAkW7ycLkMY7rahI+3F/lmmQ4vWxnoesHppThyMyI9ojidvzYJmoIx959YWStL1EkYIHGzlJee2zBeLLrHB/a2vtBgCs6FHP1p/Jj+QrUOk9h1fRnr2ltVg88FOtdxJZ5JMyOhnY2ZTxhfNKnQznjJ/VHlLK/kEB8=
Received: from CH0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:610:11a::17)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:23:25 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::86) by CH0PR03CA0354.outlook.office365.com
 (2603:10b6:610:11a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 15:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 15:23:25 +0000
Received: from [10.236.31.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 10:23:24 -0500
Message-ID: <37fe0c7f-a99d-4c16-86d5-24b45ce2bbb4@amd.com>
Date: Tue, 13 Aug 2024 10:23:24 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] selftests: KVM: SEV IOCTL test
To: Sean Christopherson <seanjc@google.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <kvm@vger.kernel.org>,
	<shuah@kernel.org>, <michael.roth@amd.com>, <pbonzini@redhat.com>,
	<pgonda@google.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
 <8870ca39-f5a9-8d33-3372-77a6693ad739@amd.com>
 <98c1f8e2-3b24-49c4-b5fc-506e4283248d@amd.com> <ZrY5h746smS4j5ak@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZrY5h746smS4j5ak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7e8062-88fe-40fb-8892-08dcbbabe065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlBSU05ZT2FuNFY1MUdDcysxakhCNFl1UzUyUEhVRXNWOWNmYkxkTUZqTjl6?=
 =?utf-8?B?c2w2QzRRaWZjL3Q5RDlkczFHQW1zSW9OQmJIdTIwbko4amxiR1RjQWh2ckt2?=
 =?utf-8?B?cUNhbVNibDI5UklSeVBmcWVoM2ZUUGlTM0pyazN0Rm44K1JDU2JyL0FHaEg2?=
 =?utf-8?B?ZENiNUdWaTcyZ0NnU0RmOXg1dXZwSmtyaUN6RzMvNmV5ZHVDM0t0cTVUK3JH?=
 =?utf-8?B?TVRHakxveWdsdlRWSGZuR0JPWkd2Ni9wa2d0VC9PaDZVb0g4c2M3eWErZ3l3?=
 =?utf-8?B?dCtSVFpVMTNycDNlRk1kcmduaDJZc0JmVGYrWWFvTnJtc0xPK3Nybll6QWxQ?=
 =?utf-8?B?aUcxbXpoNUN5V0pJd3VhN3Z1QjlrMEI5djY2SC8rYUYwbDNRVWlyM3dQc2Vr?=
 =?utf-8?B?WmxoSk8rbWM0NVh6MU9iR2NEcEdoRFZzZys2UXVIM0U4VDlSRTQ4QWxBK3ZT?=
 =?utf-8?B?Qk0yY2RRcmZhd3JPYiswZ3hlVkY5YytxaVFKYkN2b0xZd0tyeWhEa05Jb2Vl?=
 =?utf-8?B?dGVQS3JpOG5VcVpCc3U5c2NNYXpNU3cyVFZ4enFCUDNNazRBWDRzME5MVmVQ?=
 =?utf-8?B?bW13ZzZ6NkVYdnBqcE9yeU5pYitSN29SamNhVThrbmw0dFhWOFpwWE5xRjlu?=
 =?utf-8?B?bVVXcG5CY0RDV0wrb2dDeXhRWjJpMU9XTHlyK1pSS3NUZzNlNDJrVjFReDBq?=
 =?utf-8?B?eW1FTFdISW9jQTdlSGkzbVBrMjluaTJsa3F3VUM5eDJCY245dkFIbzV2Ni81?=
 =?utf-8?B?M3JpcEhOVUxIbnhNV05ZTGhhZ2VJMUFOK0owbHpONm5HWUswaFlPS2ZHRlc5?=
 =?utf-8?B?TDRHcEd2YXNwdGpLaHpqU3RZR202S0pYampiMk40YWUwN0lZOUtVWTB5Wm9E?=
 =?utf-8?B?aUVsMlgwSUc4RDFVdGZpbWE5RjI3TWpDUE1NRU1IOFdWb0FjZU9aSG94RW93?=
 =?utf-8?B?Ym90V0krc1pKR0pPellpTTNqcVZ0Rk15TmZHcElRdEh2dHd0K3luNStXQi9W?=
 =?utf-8?B?WUE1bGlNZ05MTjI2Zk8wb3FSem8vVDYrV1hERzI5OTZranFnVThYaWVuNmNr?=
 =?utf-8?B?aEVYdEUxRjNjQkdtZkJyZ3lHMnQ5cWUyWnZzeWNIZ254OG5Ga01GNUhUT3M3?=
 =?utf-8?B?T25yb1ROV2E4dkpYcDcrVXF5cUtJTkR4aC96d28rTHl1Q1JHWUwwa3pFeUxh?=
 =?utf-8?B?MWluTjc4c2ZYYU1la2dlN2NHRkxCZVZ4d1VMVXJ2NUM2clhKeFFhajFodlR3?=
 =?utf-8?B?UldBelpwVkpwdEk2YVQzNC9VTkFnbHFvUzlPK1JBUERLVTBvUDVINHhrYUVD?=
 =?utf-8?B?T3FjNFdBbXBWeFh5czd0QXQ1b0FvNzA4RDlaZTduT1BSZE1ISTlXMVduZlFa?=
 =?utf-8?B?QU9nNGVaNmxsbU1SWFIyYStGUngzYklReTlyUFF1aGgyV1lUVUxNdytLaFNj?=
 =?utf-8?B?N0tLTmlvU2R4aloxa05kR0RqaXdSaFBQQ1paODYxbW5YSDhSSzlPekZIbTcv?=
 =?utf-8?B?L0hPL2NWV3ZvVWNNQTFZcit3T296dnFYUTE3YWdCOUxpNFc1Q296cm0zOUlz?=
 =?utf-8?B?YmI3U284STY0bjl4dFFLRlNSUW1SdnhjWUNrMHBocWpFTWgvRlVkU0NXYVBW?=
 =?utf-8?B?YWMvNUFVTVFwN3pvM1BsY0RmMW1jbngyVXNjWGVUNmdtcTU0ZW1sRzdiL1Fp?=
 =?utf-8?B?TEo5RUVvZ09wVGFiVFRLWFpVNmUvR1hzb3FEcTlMbnF0cXM4RWtmWWoxRXJZ?=
 =?utf-8?B?bWNCaHFXMWtSNE1EWHA0VjlHTFMrVzhGU3M0WVpWMG1TNzQzRnNZVHFEczdC?=
 =?utf-8?B?eERBQVpHQ01qMmtzNUFGVW01T1B1YzFQUzJHYzF5Z0ZDNkpkMzR2eEtaSEZF?=
 =?utf-8?B?TjB0akhESE01TVdXVkI5dHlLTVR6UE1LdCs0Y1NuZVpJYWx1WlFvS0VZcmEw?=
 =?utf-8?Q?xBRaT+p0AtGsKAo98sL0/kD+PvHqME3G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:23:25.7382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7e8062-88fe-40fb-8892-08dcbbabe065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268



On 8/9/2024 10:45 AM, Sean Christopherson wrote:
> On Thu, Jul 11, 2024, Pratik Rajesh Sampat wrote:
>>>> +static void sev_guest_status_assert(struct kvm_vm *vm, uint32_t type)
>>>> +{
>>>> +	struct kvm_sev_guest_status status;
>>>> +	bool cond;
>>>> +	int ret;
>>>> +
>>>> +	ret = __vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
>>>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>>>> +	TEST_ASSERT(cond,
>>>> +		    "KVM_SEV_GUEST_STATUS should fail, invalid VM Type.");
>>>> +}
>>>> +
>>>> +static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
>>>> +{
>>>> +	struct kvm_vcpu *vcpu;
>>>> +	struct kvm_vm *vm;
>>>> +	struct ucall uc;
>>>> +	bool cond;
>>>> +	int ret;
>>>> +
>>>
>>> Maybe a block comment here indicating what you're actually doing would
>>> be good, because I'm a bit confused.
>>>
>>> A policy value of 0 is valid for SEV, so you expect each call to
>>> succeed, right? And, actually, for SEV-ES the launch start will succeed,
>>> too, but the launch update will fail because LAUNCH_UPDATE_VMSA is not
>>> valid for SEV, but then the launch measure should succeed. Is that
>>> right? What about the other calls?
>>>
>>
>> Sure, I can do that.
>> Yes for SEV, the policy value of 0 succeeds for everything except when
>> we try to run and we see a KVM_EXIT_IO.
>>
>> For SEV-ES, with the policy value of 0 - we don't see launch_start
>> succeed. It fails with EIO in this case. Post that all the calls for
>> SEV-ES also fail subsequent to that. I guess the core idea behind this
>> test is to ensure that once the first bad case of launch_start fails, we
>> should see a cascading list of failures.
>>
>>>> +	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>>>> +	ret = sev_vm_launch_start(vm, 0);
>>>> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
>>>> +	TEST_ASSERT(cond,
> 
> Don't bury the result in a local boolean.  It's confusing, and _worse_ for debug
> as it makes it impossible to see what actually failed (the assert message will
> simply print "cond", which is useless).
> 

Ack, I will make sure all the other occurrences of using similar boolean
are also removed and the conditions themselves are passed into the assert.

> 
>>>> +		    "KVM_SEV_LAUNCH_START should fail, invalid policy.");
> 
> This is a blatant lie, because the KVM_X86_SEV_VM case apparently expects success.
> Similar to Tom's comments about explaing what this code is doing, these assert
> messages need to explain what the actually expected result it, provide a hint as
> to _why_ that result is expected, and print the result.  As is, this will be
> unnecessarily difficult to debug if/when it fails.

Right. I'll make the error messages more reflective of what they are as
well as have an explanation to why we expect this behavior.

Thanks!
- Pratik


