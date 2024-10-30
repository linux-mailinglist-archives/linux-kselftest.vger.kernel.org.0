Return-Path: <linux-kselftest+bounces-21143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE69B6947
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528251F221FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028E2144C9;
	Wed, 30 Oct 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ISa0fKPU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8D214412;
	Wed, 30 Oct 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306166; cv=fail; b=WiIEI13ug5a4wQmKMYcNq1jmQvtk/RgFFScJETw/w5PVjP0yCsOZi1clx/SGZ/Jwha3i8nU0vR91LAzf1Us2Emk6/qNo6ftx2wOTLfEG2Uo43K/OAdNpE1kvbDoCiM7KmPha5yG5De0vs8QkHt49v7XAjWXDoZVrvhSYCw4+iJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306166; c=relaxed/simple;
	bh=QNsfkGj4PuZ4k6gUo0SGvlKFXCm4RXNVuu2vonCLFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c7uY1KX0JvUmdyYsrFZM/pAp0U6Fr67EIi+k8SVuykHDn/hQLpt/Os/l2Q6JHJNYBSCBd9f5E5eNbD/H/4+WEMPtn9D5eiDfbWi0ZqpuvRpDk/020h3O0vVB6WnW/PQCymBObzGaDb5cDoWqBfBJxQ2N/ONZNhdw+Fj68lu4aIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ISa0fKPU; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lck9fW9PoEVCXNObeapjULpihUrWbtbN2y092ow5W+61D8bxm1uJwgpoNFtOWaHLUDIPJn2kmDVZEwn0GEfWGny3xgC+BORKveV+i8yDZBEDh5xYq1eFKTUOP2xFn3etoKtA7adinDgdTMGMe1la3xoykYX8WbOfmrL7/vYIo7Sn/718VDfI01LmvBeCiZv94RDTIsL+YcHE482m+6di/LBQwxFix3jFe8DhoWMCYlsxR7eH8MMqzgQlXzxS7tgRIcvAHElW7SnFCD/sblKPTWvZxAa3N5zQqsklitlcvPJw7B/TyhTp8VdkYocD3QdKYwj55o2VBHH0yQsqB99cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv6YLn4RWGqUIXoFxjILXNt6pCY047Y8gcK09VR5NOc=;
 b=EXpuArf3+WQN0gVUv4hqh+/jLuZZhXI/zZK5IeDstVjTsRPROlr4N/jrPrJp+SEh6edbB/sXkpCHJwg4FqxEkMN49ezKNRCAy5TCCvOlkw/9DvTCDDzFY9qPLzKRkk+a8Ll4Jf2USB8JOohQgnrA3Av7o9KmrKmFyn2PC+JysEENLilK0A23Zsi2Wfy9z0MfFQV9/W1+MvSGY23HKURvIpf7bJKFFsCzAkL8UEKysUAupXqUpIzjh9QdSbhFhZpoopc2Upn1E3DQfgKDl4WdtY3zf8xSRj/0DdEKD+ghEnpCVQ/blu3C6ckND/OgMnPL8cDfq4JWep0birtBio7sNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv6YLn4RWGqUIXoFxjILXNt6pCY047Y8gcK09VR5NOc=;
 b=ISa0fKPUes8sYDEZofI4Pq5FLtQ38XFhvf0QmRal3Hdi8ztq8cygFRux7jFYtdL2zkCw2S/QpsZViDw/txJ9yzQ27RrCm9EPAGUXSggmrD8lb5hD7F88AJ1vuVk9KrkOdotl24KaaFuK1pVphxx/36qeLIFqrXF+vuB5ZkHWTD8=
Received: from CH2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:610:20::38)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:35:57 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::4c) by CH2PR07CA0025.outlook.office365.com
 (2603:10b6:610:20::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 16:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:35:57 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 11:35:56 -0500
Message-ID: <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com>
Date: Wed, 30 Oct 2024 11:35:55 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com>
 <Zw2fW2AJU-_Yi5U6@google.com> <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
 <Zx_QJJ1iAYewvP-k@google.com> <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
 <ZyI4cRLsaTQ3FMk7@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZyI4cRLsaTQ3FMk7@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: b09d6639-208d-424b-41de-08dcf900ee59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cllBTEZKeXFPeGdKY2tuR2M0ZnlNZERDMHZETEUySm5yVzRIeFg3YzZFN2VB?=
 =?utf-8?B?TXI5cVh1enRKUVRTL0xTQ2Nvb1UyWnlyTHdMeFoyUXVzRFNoNkFZZGpMaFBY?=
 =?utf-8?B?Rkl6ZGNUL25DYU5sQVg4Znk1cVRFRVpZY1diNEo2VEQxTXBFS3dyOEg2UDFQ?=
 =?utf-8?B?OTZscVhsRXJVclhGeFNHdDlmQUtWeFBURWdSU3ZpY0RUbFlmRC9VTHhHOWUy?=
 =?utf-8?B?VkpzYXRmak5UWU81RmRNamhIajQ5amZkMkY2aFc2dDBiNjVhT3VnYjZBWUpp?=
 =?utf-8?B?bnR4dU5iZm56dElOOW1wZGhueFdHZTd5L2Q4Q05ybkZQNUFSQk5aZyt0MGxW?=
 =?utf-8?B?aFBoeGFFL3dTNlhST2dIK2tMUmMweWwrTHozN1M4OFhXNU1POGROdFpVckho?=
 =?utf-8?B?ZW0zWGduWUFsbngwYmh5VytYa0hEVnIwMUZiM2djVXEreGVLdkp3QVlkREl1?=
 =?utf-8?B?bzFoaW1VVmNhVm5HdXJJMVdwd2plM2s5cVpXT01YVzV6L3M4aGdseU1yK3Ja?=
 =?utf-8?B?ZC91N0RsSzdZNEM1Q0d4OUt3V3pBL0tHLzhxdEFBU3NETG9GaUNLTDNjK3I3?=
 =?utf-8?B?V0h4MVpwQjlZV0NTRG9UK1dtNy9kNXAxWlhKOVZuY3ZLR2ZPV0hiLzczWUFJ?=
 =?utf-8?B?Yk92MTFFcjQ4VCt2eFdob3dXQkk0am5ocE9Xd01NSHFVa3d2cXJlOHZJU0th?=
 =?utf-8?B?TnNFMjRuSVpmRE13UHRQbm1seWQwT3RpVkJTOWlwVkp1eC9hZ0ZmN1lwNTBE?=
 =?utf-8?B?N3RDZitZYy9LUnQzbFFYNE5oenNURVVnYUdlZ3JTQnY3L3JybTB2N2lObUE1?=
 =?utf-8?B?MXMzbmJyTDJIMGU4TVhaNlpCK2VWd09Xb2FEUmtrY0ViMk5vc2dmdGZkRTh5?=
 =?utf-8?B?TCtSSkpsVFF4b2FRcFFiZHFqWGN0bk5SMFRnY2hkM3FJL01YU0ZNQnAva09I?=
 =?utf-8?B?eU5BWFNYY0IwV2xPNk5NNzdoV3dSYU8wN1M3cERBSnRWczJOdnp3eTRpVFNP?=
 =?utf-8?B?bkthc2pUNzJwa3NQN3R5MW1iVHNZbERLT1VCV3FIOFNyOGw3aFdBL2xzQUw1?=
 =?utf-8?B?VlZVRzU3S0FMRHdkNU1XdGszcXBOWEg0Skp6SGdCSW1LYVBiR2VWNkp5aXAy?=
 =?utf-8?B?NFhFQ0o1NU1vLytLV1hROHZmSjNHTm52UFFFZ3UzNmtqZ055NWdXWmpoMjd3?=
 =?utf-8?B?OWRLMEVnWjhjRVh4WXBieGsxZkxRTjUwVE5MOS9wdFFtSzZFeXZBcDRlQ0Fk?=
 =?utf-8?B?T2xoTmpUV01INVJHVXNDMFBISjVaZ3d3MmdEcnQzMDF0aDBoY09PR0ZoSnJC?=
 =?utf-8?B?bUdncTQrNldlRHo3YmwyY2lxaWNYS1czTnV1RXFNRWFQU1E0ZXJjRU5OV3FN?=
 =?utf-8?B?aGhhZUZFMTRvaC9JcXNWSkJnaThmUlh1dUNZVWxrYmVjUWNBK2Rhek1KcWVs?=
 =?utf-8?B?KzN2dkYrcmdQOGN5ZU9KWHViVVc0WFU5WitNYzVQckpaL3hwVFl2MGtoZzQ5?=
 =?utf-8?B?dkM4cXlJN3gzaEV5STBmUjNFSGtrVFIvQksybFgzRkU0WDdPVURsSm90WHR6?=
 =?utf-8?B?SmovTjNkRmV3QUJSQWRLbW05dUtyQTV3SzhzL3JRZVplRW9YWXVZOW1oS2Iv?=
 =?utf-8?B?aHNVSkxGdFpmY2FqM1M5WDFLM3h3bU5NNndMOSttWXVUdjZYZXllZmE1NnRa?=
 =?utf-8?B?ZTdWYWpyYm96RjF2VnZtVkZTS25iaGNYWkJGQVpBc3hjbU5yTDNZdmFRa2xZ?=
 =?utf-8?B?Nk1xQXNRUW9zSDBockNoTkpNSWhLMG1wSGltcmRRMnM0VFN4UFNYVEF3MExT?=
 =?utf-8?Q?dU5jcab5yb+Nm5UKWn6y4L42+ilDE1tmDFBXU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:35:57.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09d6639-208d-424b-41de-08dcf900ee59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

Hi Sean,

On 10/30/2024 8:46 AM, Sean Christopherson wrote:
> On Mon, Oct 28, 2024, Pratik R. Sampat wro4te:
>> On 10/28/2024 12:55 PM, Sean Christopherson wrote:
>>> On Mon, Oct 21, 2024, Pratik R. Sampat wrote:
>>>>>> +		if (unlikely(!is_smt_active()))
>>>>>> +			snp_policy &= ~SNP_POLICY_SMT;
>>>>>
>>>>> Why does SNP_POLICY assume SMT?  And what is RSVD_MBO?  E.g. why not this?
>>>>>
>>>>> 		u64 policy = is_smt_active() ? SNP_POLICY_SMT : SNP_POLICY;
>>>>>
>>>>
>>>> I think most systems support SMT so I enabled the bit in by default and
>>>> only unset it when there isn't any support.
>>>
>>> That's confusing though, because you're mixing architectural defines with semi-
>>> arbitrary selftests behavior.  RSVD_MBO on the other is apparently tightly coupled
>>> with SNP, i.e. SNP can't exist without that bit, so it makes sense that RSVD_MBO
>>> needs to be part of SNP_POLICY
>>>
>>> If you want to have a *software*-defined default policy, then make it obvious that
>>> it's software defined.  E.g. name the #define SNP_DEFAULT_POLICY, not simply
>>> SNP_POLICY, because the latter is too easily misconstrued as the base SNP policy,
>>> which it is not.  That said, IIUC, SMT *must* match the host configuration, i.e.
>>> whether or not SMT is set is non-negotiable.  In that case, there's zero value in
>>> defining SNP_DEFAULT_POLICY, because it can't be a sane default for all systems.
>>>
>>
>> Right, SMT should match the host configuration. Would a
>> SNP_DEFAULT_POLICY work if we made it check for SMT too in the macro?
>>
>> Instead of,
>> #define SNP_POLICY	(SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
>>
>> Have something like this instead to make it generic and less ambiguous?
>> #define SNP_DEFAULT_POLICY()		 			       \
>> ({								       \
>> 	SNP_POLICY_RSVD_MBO | (is_smt_active() ? SNP_POLICY_SMT : 0);  \
>> })
> 
> No, unless it's the least awful option, don't hide dynamic functionality in a macro
> that looks like it holds static data.  The idea is totally fine, but put it in an
> actual helper, not a macro, _if_ there's actually a need for a default policy.
> If there's only ever one main path that creates SNP VMs, then I don't see the point
> in specifying a default policy.
> 

Currently, there just seems to be one path of doing (later the prefault
tests exercise it) so I'm not too averse to just dropping it and having
what bits needs to be set during the main path.

I had only introduced it so that it would be easy to specify a minimal
working SNP policy as it was for SEV and SEV-ES without too much
ambiguity. But if it's causing more issues than resolving, I can
definitely get rid of it.

>>> Side topic, I assume one of SEV_POLICY_NO_DBG or SNP_POLICY_DBG *must* be specified, 
>>> and that they are mutualy exclusive?  E.g. what happens if the full policy is simply
>>> SNP_POLICY_RSVD_MBO?
>>
>> SEV_POLICY_NO_DBG is mainly for the guest policy structure of SEV and
>> SEV-ES - pg 31, Table 2
>> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55766_SEV-KM_API_Specification.pdf
>>
>> and, SNP_POLICY_DBG is a bit in the guest policy structure of SNP - pg
>> 27, Table 9
>> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf
>>
>> In the former, a SEV guest disables debugging if SEV_POLICY_NO_DBG is
>> set. Similarly, a SNP guest enables debugging if SNP_POLICY_DBG is set.
> 
> Ugh, one is SEV_xxx, the other is SNP_xxx.  Argh!  And IIUC, they are mutually
> exclusive (totally separate thigns?), because SNP guests use an 8-byte structure,
> whereas SEV/SEV-ES use a 4-byte structure, and with different layouts.
> 
> That means this is _extremely_ confusing.  Separate the SEV_xxx defines from the
> SNP_xxx defines, because other than a name, they have nothing in common.
> 

Right. I see how that can be confusing. Sure I can make sure not to
bundle up these defines together.

> +/* Minimum firmware version required for the SEV-SNP support */
> +#define SNP_FW_REQ_VER_MAJOR   1
> +#define SNP_FW_REQ_VER_MINOR   51
> 
> Side topic, why are these hardcoded?  And where did they come from?  If they're
> arbitrary KVM selftests values, make that super duper clear.

Well, it's not entirely arbitrary. This was the version that SNP GA'd
with first so that kind of became the minimum required version needed.

I think the only place we've documented this is here -
https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.

Maybe, I can modify the comment above to say something like -
Minimum general availability release firmware required for SEV-SNP support.

> 
> +#define SNP_POLICY_MINOR_BIT   0
> +#define SNP_POLICY_MAJOR_BIT   8
> 
> s/BIT/SHIFT.  "BIT" implies they are a single bit, which is obviously not the
> case.  But I vote to omit the extra #define entirely and just open code the shift
> in the SNP_FW_VER_{MAJOR,MINOR} macros.

Sure, I'll get rid of those couple of #defines and use them directly in
the macros.

Thanks!
Pratik

> 
>  #define SEV_POLICY_NO_DBG      (1UL << 0)
>  #define SEV_POLICY_ES          (1UL << 2)
> +#define SNP_POLICY_SMT         (1ULL << 16)
> +#define SNP_POLICY_RSVD_MBO    (1ULL << 17)
> +#define SNP_POLICY_DBG         (1ULL << 19)
> +#define SNP_POLICY             (SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
> +
> +#define SNP_FW_VER_MAJOR(maj)  ((uint8_t)(maj) << SNP_POLICY_MAJOR_BIT)
> +#define SNP_FW_VER_MINOR(min)  ((uint8_t)(min) << SNP_POLICY_MINOR_BIT)


