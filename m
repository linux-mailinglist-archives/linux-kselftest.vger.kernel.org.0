Return-Path: <linux-kselftest+bounces-13606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E692EC9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25875B238B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765E16D4D0;
	Thu, 11 Jul 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TUIwDaFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21E16CD1A;
	Thu, 11 Jul 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715021; cv=fail; b=KhE9zFXZ4VN3cJiD74GcJC1Ut+sxUWih6WZpzbHs+4PHe9i8CcfkAUrqAtp2x01a7XQPxFWvRmQOc0leqf0XZGJvkZV622IVAqRBjn2cdR2kFXspYZkPSod9YMKIdDkASYW5hh1w8bK9q55gd14nXOVg3qwGZNdxZXNcx9rpTW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715021; c=relaxed/simple;
	bh=LS8ZeQLtWtgtDzSaZw3TE8C83VAj/v8ptkzbWVAm8tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hKY6dPaihuAVVFL1Eo36BZPeLex7zctwTuprKlEqTqntszl9M55OBbbZZZfbirURA/CRe6y7KC7Tukhr0dAc9p+O3NFK938M0ja6mEJRelN9VpAD6f2Sjo+1OBmaOJ7vYbUgQR0UwNWrJKwaJvOHocIAgLicBj/1EfhyFsx04sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TUIwDaFa; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB9L4zUOCOEMhOQApG6u++CevjcXpxWLPlVKsCXbt/9awnzjNwnQmsj654owUAivI+kDHg0oIOWmCpZpmtm7Ob3JTzVvswdCHYBEDDmYX/jj2dIICzZnrpod+Epb5J3Yp17YU5jkoHGLrnIwF8yEwx9hIQwuyPzover35Zd3UQr91HceiEDjTjmsku459QOeZI5PCe7NveiXVTpssR1h0ZVm+LKEKgLn0y4AfOlcKjQ7vWBoHznaXvrO1aQFLSsiKhMjTto2Zn+DzoqO8uh0N9ERLHjpuU+QhLwsinQUOBGG2KhmBU0hMf9J1CUaZ0Qw1T19rjbL2lVk5dNLjAod7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdZf9I8B2q4T1E2mHs9h0oMhxTn+2MLv3kjlaa+u2p4=;
 b=GkML/AuG6b8zkLBoEC5PlWLvzx+qaYEnHycugrm1dPPDgvWSylZFj7EUUnnwAcicGLfJcJzW3AIlqBLX9MJKZ229YJrRrlXxqdk/sIgDyIjOhYvy/E/r2rXyD/oU2+Q/hPtxjeCQQKdPABjt948OqSY3BJWtXfNa+35+IU6L7t+dYKoYjnA5lQ93fHKEnG7bMzynqSvfWGWAJ/MqMD6n3jI+tkgijtmMMbWKmUMBIWpRedbGiiThEpF+pMeY2lmW2G4UDqdbsasg6eB4ZZVgjGS5+jA3N3r1F9twECJN1mc4C9E+es1QLJCesWAdK8ol97CAmJxv74ZuIN8FOIptgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdZf9I8B2q4T1E2mHs9h0oMhxTn+2MLv3kjlaa+u2p4=;
 b=TUIwDaFa4mBxfEXg4f5kby0T8kynZuZa292UDC4aUd1msDIDyzWzmQ8QNMFVCt7gJEUVY/1dBMhdUVk9Y2GrkQ+fboThbiGUnoxUNbHEEaMahST7ejgXhA7BW99xZqGkvlE7ldSC+z+oY3gQyeTiJajUX+TnTOSZDDrJRY4htT4=
Received: from SA9PR13CA0069.namprd13.prod.outlook.com (2603:10b6:806:23::14)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 16:23:37 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::fd) by SA9PR13CA0069.outlook.office365.com
 (2603:10b6:806:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 16:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:23:35 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:23:33 -0500
Message-ID: <b41f3149-1020-4996-911f-7f357db81376@amd.com>
Date: Thu, 11 Jul 2024 11:23:32 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] selftests: KVM: Add a basic SNP smoke test
To: Tom Lendacky <thomas.lendacky@amd.com>, <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <michael.roth@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
 <b7c4316a-1b00-521c-991a-57e1d105952f@amd.com>
Content-Language: en-US
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
In-Reply-To: <b7c4316a-1b00-521c-991a-57e1d105952f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d08b9f-433c-48bc-5c8e-08dca1c5d07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkcrdXBHODhMQmtiV09JSUYzVFdUMHdrR0NZUVphYkZxYW5PTVIwclZLMG9t?=
 =?utf-8?B?NDhueGFRaHZDTEhhaVVnNExOZHRBdHNLak91ZkozUWI5cUJxWFFSekNnbVdO?=
 =?utf-8?B?eHVpSXBRNlRqY2hZYnBvcVI2WlplSWk5bDVYMmRTU0pESkNWV1hzZ2wrR29r?=
 =?utf-8?B?eGk5Zlk5cDZWUmNnamFwTHR2ZUpDMVBsNXNyaVZkRVhudm1nVm9SS29ubWw5?=
 =?utf-8?B?bUVGWWorQTZOOTE1SkNMdDY0VkdvTHlOQ0p3dTA0a00yK3FQUGc2RVNvYXR4?=
 =?utf-8?B?c3ZjMjFJVmc1WFVUVUtYNzgydTkrcFN1ODJPVTVTL0syZjd2Q2dFY0dMS3ht?=
 =?utf-8?B?dDJWUURXc3JYSVVNaFdianA5djI5OG8vOGYrQXhBY1FhTnhjQmo1WU5Oemcz?=
 =?utf-8?B?NlQ0R1VPS3VVaStOTGVTOEc1dUVFRWJNUHhFa1MvMlZQVG13a0ZidElFb3RO?=
 =?utf-8?B?Q1c5R2d1TFVBYzR3MVRyOWU2bVRWR25HSjhxK1RIb25ERENRMTlQYWRRdFJo?=
 =?utf-8?B?dUV4cUsreFRBeWRxL1Y5N1hRcUZzOTRnSWcxbU5rbkpma2hwS1ZkSXBES2xK?=
 =?utf-8?B?OStaeHlmWnphRUJjaUhidElkdU83M2I4SW9oY0x3RFMrUXh1UmRnL1pEWXNz?=
 =?utf-8?B?b2tpUUJMZnhMWmxDUjEyb2dQdmhIM0hHQ0pKQlRQYUt6anBOdVVJOVJOWTl2?=
 =?utf-8?B?NHJNVFlBT3FORitwNFRCVElTQ1BheWJpOFFzdVhBNjZVMHZidERxbEEwMngv?=
 =?utf-8?B?K3cyb0lTKzJudmoxYXZhVUk1OHdRcFJJZkh2NWIweUVKSFpRbndxeHB0dVRM?=
 =?utf-8?B?a2tkRWhLOE1OT2ZnenRiVjNaZ1B3WHZSNzd6d0cwbDk5WVM0RStMRmF6blBk?=
 =?utf-8?B?eG9jak14WEVyc2dKaFl5UFE3RVUyK1lVOTIzZEpiYXZsdU5Rb1pnZUFCbG55?=
 =?utf-8?B?Q3NoYVFTdTJISUtMVUFnSXB3NlZZZjBBV2p0SUp0M1JoTmxnTjZ3K3c3M0Rm?=
 =?utf-8?B?ZEpEWGlzWUhmbWRYNjREMTZNYmFWQVJiMUlTL2xIV3czejNMcUNjN0JwNXdn?=
 =?utf-8?B?ZVdCd0xJYXo1ei96bnQ5bG9HUUJ0VWVWWWIyaDhES2g4SVh5L1kvNVV6T0R0?=
 =?utf-8?B?VnYwaGgzTHJiT3BPWVF1VjB3ekpteis3d1NxUFA1Z243Y3pENkZBTXlSc1Nl?=
 =?utf-8?B?Q2hKK2lhWUlpeXFxUms4bDRDcm1PUS93Z3ljdHZMK2o0aGQ0YndUT0c1TzM4?=
 =?utf-8?B?ck0vcEdmU2JMS2IxdWIyeXd4S3JDb0JYaFI3Q29kMWI5QnB6dUtFY1NUTVBZ?=
 =?utf-8?B?NVVDWTIrYWNab3pHOWJjL3VlSTlUemRZMlVGSGRXUjI0aTVaR1JTbzNPdUVE?=
 =?utf-8?B?em42c29RNTFwWkppU29rZGVndmJtU1plYzNZL1hpVVNsQjJDU2JjclNlU0I3?=
 =?utf-8?B?c2R1dmtuM3pNSEhZazNOR1VPT2V6d0dyTXp4Y0hNSkVGZ1ZCUmgwRTl5Nm1j?=
 =?utf-8?B?VnJNK3N6ZlJLRytKYnNHYVN4YzJlUXRCNGtxQkZNdTlENllmYUxObjNNNVhL?=
 =?utf-8?B?ckxNczNyblZzYmtpcnlCd2xpNm84TFdCckd2cjJzeUptVkp3MUFBNGpWak1S?=
 =?utf-8?B?MSt1bTNzTnhTQjNzOUZmSEhKSllMQWV4cDEyUElHK01TVmpjR1YzbmNoWTFp?=
 =?utf-8?B?MTZDOU11Y01UOUJHUllEcitLK0xTNHFsaG1WU2FMRktNNjliVld3NktkYWhi?=
 =?utf-8?B?dGhYSUtpdElhUWtaRlMvYnFLajhGZ0dFVzM3bXRSOElHTlNBdGRNWjlibHdm?=
 =?utf-8?B?NnhJYjk0OC9jLzlHQkg1UVk3aDVmNUFLQXpXSERsMEozd2d4bHA4bUN6S1lx?=
 =?utf-8?B?am5FN1hWYzZLOGExU0h6Tk0xVUthUWFBNmtrNGdKekhyc1BEYmt2VFBHVm9P?=
 =?utf-8?Q?rcFcJwoMNnjQbEJ4uyqAddUCCnmJU79Y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:23:35.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d08b9f-433c-48bc-5c8e-08dca1c5d07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

Hi Tom,

On 7/11/2024 10:56 AM, Tom Lendacky wrote:
> On 7/10/24 17:05, Pratik R. Sampat wrote:
>> Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
>> initializes and sets up private memory regions required to run a simple
>> SEV-SNP guest.
>>
>> Similar to it's SEV-ES smoke test counterpart, this also does not support
>> GHCB and ucall yet and uses the GHCB MSR protocol to trigger an exit of
>> the type KVM_EXIT_SYSTEM_EVENT.
>>
>> Also, decouple policy and type and require functions to provide both
>> such that there is no assumption regarding the type using policy.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>>  .../selftests/kvm/include/x86_64/sev.h        | 29 ++++++++
>>  tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
>>  .../selftests/kvm/lib/x86_64/processor.c      |  6 +-
>>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 70 ++++++++++++++++++-
>>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 51 ++++++++++----
>>  6 files changed, 146 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> index 8eb57de0b587..5683fc9794e4 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> 
>> +
>> +	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
>> +		test_sev(guest_snp_code, KVM_X86_SNP_VM, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO);
>> +		/* Test minimum firmware level */
>> +		test_sev(guest_snp_code, KVM_X86_SNP_VM,
>> +			 SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO |
>> +			 (SNP_FW_REQ_VER_MAJOR * SNP_POLICY_ABI_MAJOR) |
>> +			 (SNP_FW_REQ_VER_MINOR * SNP_POLICY_ABI_MINOR));
> 
> This seems an odd way of setting these fields. Maybe, instead, use a
> couple of macros that take the values and shift appropriately and ensure
> that they don't exceed the 8-bits each field occupies.
> 

Sure, I will clean this up and ensure the flags are set up more elegantly.

> Thanks,
> Tom
> 
>>  

