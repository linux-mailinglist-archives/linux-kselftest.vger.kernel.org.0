Return-Path: <linux-kselftest+bounces-20852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7E9B3C09
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5488AB2105D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262871DE4DC;
	Mon, 28 Oct 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ff/T1fCi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C018E03D;
	Mon, 28 Oct 2024 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148127; cv=fail; b=GFPy1JKdNL+Mf2ul7j5XjSGbo4ki8KXQa50C2x3B5MQuvCuIUPLJ4XY/J/uSbj0TP2XzfdvoKW17KUfYBWkrbQfzoR/qiRxjXOtktpRA4GwU7iZ+uPIt0sLATjSgXdPUahi2YQieiK8j76qVyue+oiVIBKWc9zpd66Rip6sh3tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148127; c=relaxed/simple;
	bh=xAQ6PS4BMWy1lVKRXUE4yey9i2sVQDbC6Ts9OltcxDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aYUPQ06RJWtcn9Qz600NYdEJ02CLax3UqAKhALBBvNYtLVQsrou6ZIDIb5XZg7BkC9EZygCWh8G6Wt4qAeBWSavXanL/s4h7MgXx4JhcIH355F5TN/2itVPmkq8vZMCxKIoBSUjZD6luF/A0iUQA2kxZ57irk7CRSWG6gRD8GUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ff/T1fCi; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUz/to6yYq09stePRb/J9//ikKCFq4V1PISngd9Q6gvfLH3JUqAZK/8Ypo/EV3GgElqVBMIi1jzxWa+CaHY8p3woBnnR884+obu9TZ04GLobn8iUE5aOUsJvjT7MJl1Qpnm4NGmw4zNI85EebsXx/Jo/x5hfxrLH4KuRglJH8xvH2uvUmZ/CQVTlTW0hB2a200G/0H9DczbQA1FxrzNKdQhnXwphG4fpmx2dFlAXYO9I+H1eN1e+jv7bC1H2g4EW4hmTO2jX7j1IAIu2kutEcDI+QTtk6XAm1/HoqH+Cpgp7BUi+SFDbHq9wHI1NKJRxAs9ZoFGo/LRG+/fRbOmhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDhD5dppCsY4cRUKzVEhB00cZFCNeWQmsAsS/2A8Flc=;
 b=R/wrvIHxx8Au3JoE+X6puxL7HIFlhJHL86w1DYVQK94MGBKGtojJZIBAX3JgQZYxnXhj0F30TsFMoWoXPndlVKChjQ9hNZbNJt58TrriRQgZ0wVaVvm6Ef4ToH+PuzKYycjCXrqzneuJoZj4s5TDLi+hieDuhl0Eudabifm/XjbI24r/9m0gARKVWYHn6dNAL8G6WYkaDXLiPsBBDZk412v7FPFXn30Fq4tCV9oy2Twqwbe9dFAwLCr7LQ5/eVdeVz9SSSThnA6WglNJTf+TnDI36XDgEj74SR2qf6Zx/Gq7XkYJuUCnexk/cKjeiCTLmvUD5CcO/5XqGY0zzfKu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDhD5dppCsY4cRUKzVEhB00cZFCNeWQmsAsS/2A8Flc=;
 b=ff/T1fCiQu+0XUDbwyet5a0KOs8bgOPg2LEF7ajMGdQebRkffUi5Ees5+V9/tx9WlzsWCQZfFX9NJm2uggbJMM/9VifG6cICLhkq5Dbj1HAvVq88HwsJP395dJkY6cfC8JVxs/KSq39yjhq1enoj4zpS+9By5GjVYP37ivD6c7g=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 20:42:01 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::b6) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 20:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 20:42:01 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 15:41:59 -0500
Message-ID: <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
Date: Mon, 28 Oct 2024 15:41:58 -0500
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
 <Zx_QJJ1iAYewvP-k@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <Zx_QJJ1iAYewvP-k@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a2d235-1a82-42c7-e9f4-08dcf790f996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJsVzlqeE1RL05xbE9GSTBScmxnOVdvSGlyam52ZVlrTlpUblZHM3pjOFBi?=
 =?utf-8?B?ZHRNTEgxZlJIYTFlZ3RyaURUQnVTekJ1QzFkNm9kT2VwZmxNYmVGdUdYUisx?=
 =?utf-8?B?OFJpWlBKcEc3aXQraitmU3VqNk5jZVUrd2hUQ3RUYkNVMVZSU0lzeWpxeEVu?=
 =?utf-8?B?WVFzZ296QlA2ZVJ2QmlNenc5NHFqdHpGWFQrazFWYWlZNzBLMmNlZTAyUHVa?=
 =?utf-8?B?TndUTVRvSUNtM2ZiOWhSQkZablpIZjJ4bklIY0VRMWhDYVRHUExiVmw3eHg0?=
 =?utf-8?B?ZWtkb2JjZm9oZmJTeENDOEFPTzJuMTQ5My9sTXF2c1NyVmtMWDRjeVp6MHJQ?=
 =?utf-8?B?NERVWkRpR3JBdk5VbHFCVVMvdWRYeDZiaXdNZ01IR0pRQmpQeTdBS0gvdklL?=
 =?utf-8?B?ZDhpdlBTMU5VeWY4VVUvREQ5WTN3em9aWExrMFBGK0M2NFIxeW9qWVRKdjNz?=
 =?utf-8?B?RW8xV0pPRHg4dDFCdFlKOXlUV0thWnpJWGpibGNrQUpqRW9ZWDkvb2c2NllO?=
 =?utf-8?B?Ny9icjJQVDJkNDF5alQyUHlSUEtGRlB4MU5rQmxiTXFhMUwzNkMzQnFOcEM0?=
 =?utf-8?B?czUvTmkydWlnZTlNSU1rNFBndEx3MHBlYkFEUjBCcXFUMXNMcklxREViVzVK?=
 =?utf-8?B?eThPREZwUFdXTnZFWDlFQmRwZG51dnBHL1RBNStQL21PWUhjUUVjUEZ4VXdp?=
 =?utf-8?B?YXFxRzFBN29JYlRyTHErd0cwYlYxUHVCc3pXQTA5OFpIdXJJdU9ndUx4UElN?=
 =?utf-8?B?OWQ3b1VZbnNEYVJOdE01ckRvenNhVG9JeHVzZDloSUdJU1JLUnRiQ1V3cDFj?=
 =?utf-8?B?bVhXb3M5UG4wdFA5cFN2T3puMC8rU1NQdkJCSEZjWnhRbFRWaVFiVGxNTEYw?=
 =?utf-8?B?TkNLWG5ORmVMWk92aEVMVTRrQ1R6c0xkTlZENm8xS2pvMzlBYisrZnhlYkJF?=
 =?utf-8?B?Yjc1UDZiSWdnbjduWXF3SXcrVXQ3SVdGL2JRZlNrQTJJNTZNcE9VblRPVjFG?=
 =?utf-8?B?N3pKTHo4cGxIZ21xdmFYaXB6UjhtQXdZckM2dTB3UHRXRndHdGJDUXZuaFU2?=
 =?utf-8?B?K0twUWxnTWdzdWtnSGdSeWwzQ3JjNnorN1MrckVEOE1KSHR2RERDN1dLTXQv?=
 =?utf-8?B?YUZjeE1BZ0FIQWMxa2c0SGVhTUFZVlZVNnYvSkpkQWo4dzZCUGh0TzloWEFN?=
 =?utf-8?B?V1gzUkVUbXZMcGNYMDI5RnR4N3RMemw0bGZ5dXRqeE4wYU9YVi9yL2hJcjh2?=
 =?utf-8?B?bjJDL0pCSVE3Z1RWQTVEV3B3di84Smk5WlhmTHJrVHdEZk51RG5UZnF0UkYw?=
 =?utf-8?B?Q29tSWt6ZXRzdEo1amhPellhdUdONWw2U3ByS3RQb3JhZktSbld4TXlEWUxY?=
 =?utf-8?B?eUZnNHBUallBb0N4UjFTcmhjKzF1eUVzSWRiYnBWdTVTbTBKTmFtQzVwM2tp?=
 =?utf-8?B?eWtETGg2NWZ2TW8rWXpQUVNDYkNhMlIxbUJQU08xYUo1U1M0SExGSGF3cDhv?=
 =?utf-8?B?R0szS3p4SjJ1czlMRGRDdHRpVzBRTUQxMnFVV2NPY21NaU1OMGIvelluWXYw?=
 =?utf-8?B?RFAzU1VHTWMvZGd4TTM1YTcraHRmZFNmaGRNcnNKYUgxMndzbVFPd09SOVlR?=
 =?utf-8?B?enJoSkZCdVptYkNpblhQd0dmTHBUZ1ZQdzc3d0FPQmJXVGVsVk44eFBBZDZs?=
 =?utf-8?B?cDMrSkpwL0VzOVRCL1UwOUxOWWJqVzBXbEUzaEI1L0VQdmM5ZExZYzRwS3c4?=
 =?utf-8?B?L1NPTFF0Z0lQcFZZbTNRcDh1Vmd2NUV0NDRDSkpTM2RGR3lXSEFMWnliaVRj?=
 =?utf-8?B?VDA3eC9WMWozaUNra092VW04T2Z6RHhzQVFYNVVCTHZ6bDN3T2JFZmdFOFIy?=
 =?utf-8?B?bWxEb2pXTUxNWUpiM0NIUGlIK0VxdEl6eWhTc3FKWFBiaFJMRXpqY2VNcUlJ?=
 =?utf-8?Q?TtDHmqTEVSw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:42:01.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a2d235-1a82-42c7-e9f4-08dcf790f996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

Hi Sean,

On 10/28/2024 12:55 PM, Sean Christopherson wrote:
> On Mon, Oct 21, 2024, Pratik R. Sampat wrote:
>>>> +		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
>>>>  
>>>>  		test_sev_es_shutdown();
>>>>  
>>>>  		if (kvm_has_cap(KVM_CAP_XCRS) &&
>>>>  		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
>>>> -			test_sync_vmsa(0);
>>>> -			test_sync_vmsa(SEV_POLICY_NO_DBG);
>>>> +			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
>>>> +			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
>>>
>>> Why do we need both?  KVM shouldn't advertise SNP if it's not supported.
>>
>> My rationale behind needing this was that the feature can be advertised
>> but it may not have the right API major or minor release which could be
>> updated post boot and could determine it's support during runtime.
> 
> KVM will never determine support after KVM has been loaded.  If *KVM* has a
> dependency on the API major.minor, then X86_FEATURE_SNP must be set if and only
> if the supported API version is available.
> 
> If the API major.minor is purely a userspace thing, then is_kvm_snp_supported()
> is misnamed, because the check has nothing to do with KVM.  E.g. something like
> is_snp_api_version_supported() would be more appropriate.

That's fair. It is related to the FW supplied to it from userspace and
naming it with kvm prefix is misleading. I'll change that.

> 
>>>> +		unsigned long snp_policy = SNP_POLICY;
>>>
>>> u64, no?
>>
>> Yes, sorry for the oversight. Will change it to u64.
>>
>>>
>>>> +
>>>> +		if (unlikely(!is_smt_active()))
>>>> +			snp_policy &= ~SNP_POLICY_SMT;
>>>
>>> Why does SNP_POLICY assume SMT?  And what is RSVD_MBO?  E.g. why not this?
>>>
>>> 		u64 policy = is_smt_active() ? SNP_POLICY_SMT : SNP_POLICY;
>>>
>>
>> I think most systems support SMT so I enabled the bit in by default and
>> only unset it when there isn't any support.
> 
> That's confusing though, because you're mixing architectural defines with semi-
> arbitrary selftests behavior.  RSVD_MBO on the other is apparently tightly coupled
> with SNP, i.e. SNP can't exist without that bit, so it makes sense that RSVD_MBO
> needs to be part of SNP_POLICY
> 
> If you want to have a *software*-defined default policy, then make it obvious that
> it's software defined.  E.g. name the #define SNP_DEFAULT_POLICY, not simply
> SNP_POLICY, because the latter is too easily misconstrued as the base SNP policy,
> which it is not.  That said, IIUC, SMT *must* match the host configuration, i.e.
> whether or not SMT is set is non-negotiable.  In that case, there's zero value in
> defining SNP_DEFAULT_POLICY, because it can't be a sane default for all systems.
> 

Right, SMT should match the host configuration. Would a
SNP_DEFAULT_POLICY work if we made it check for SMT too in the macro?

Instead of,
#define SNP_POLICY	(SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)

Have something like this instead to make it generic and less ambiguous?
#define SNP_DEFAULT_POLICY()		 			       \
({								       \
	SNP_POLICY_RSVD_MBO | (is_smt_active() ? SNP_POLICY_SMT : 0);  \
})

> Side topic, I assume one of SEV_POLICY_NO_DBG or SNP_POLICY_DBG *must* be specified, 
> and that they are mutualy exclusive?  E.g. what happens if the full policy is simply
> SNP_POLICY_RSVD_MBO?

SEV_POLICY_NO_DBG is mainly for the guest policy structure of SEV and
SEV-ES - pg 31, Table 2
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55766_SEV-KM_API_Specification.pdf

and, SNP_POLICY_DBG is a bit in the guest policy structure of SNP - pg
27, Table 9
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf

In the former, a SEV guest disables debugging if SEV_POLICY_NO_DBG is
set. Similarly, a SNP guest enables debugging if SNP_POLICY_DBG is set.

An SNP guest can certainly just have the policy SNP_POLICY_RSVD_MBO,
barring the case on a SMT system where that bit must be set too for a
successful launch.


