Return-Path: <linux-kselftest+bounces-32481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB19AAB93C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24321C24256
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4626428EA53;
	Tue,  6 May 2025 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NpFXGh/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66531662E;
	Tue,  6 May 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746497137; cv=fail; b=UAyCCcIE1MeJiI5c73rrPdmaWsO5KbccxMvBbn8JQYC5tH21YSkYIyc0k6CpU2nerMM1V4sLwDyKQQOTR9qMZ+MNrJiwm4flif52zPvQMA8bG7mcN2ht8Vl4r/tW3KrbYFP4ij26MnUno/HKStTZHbjiLqecSg5SoXSGJxXEVoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746497137; c=relaxed/simple;
	bh=jZGJtFVPwUEIuG8TkTkF0mIzjNgDb6lz5s0kCgWL37k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgtvhZiEpr+judZtdZPx6Ilfo6zZjKKk24/B2BHUE04vNj/9bceleqzK8Z9bSmkaWT8Dj+AGgEPPsWjrvkfEynfm5efPh6fHYVfBSl5tGooaA/gs1b6eoJ5xBrtvxLiriGc2rR5knMo/LtnVaG/URc9KDpIGw3E/QwxkGdG1YuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NpFXGh/z; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4dRTZOwF9avyBJanKmuvL4QnpjW/ntmpe4GCtzxTHmSOrwvBlGLdP1Hl6JHw6cJirTc/DXJMZRXQUlxCIPU+IcvAfWgQFVLuQcJ9rgQczGfAJMSkW8O1YSpG5jbHMg6efDpGENEYWD4SnlIbqN0+yxr/Qc76g6mzcUbdGl5qQU/WvgAYyz//WcdegCNMxD6FW2aOQ5dWtkCRHEgvQwL3dgNrLKicE3I8za9GTPf9XNlNEW5fSqLManYscbV8tZ1xPe+lPDdfzxfXgmrz0D7/KfN0hxTkiszWdV0qPYXY5p9mHDrwokpUjzG+8/9Wj5sE1FZE4O5vhAA5qE87DxP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76QUTVsS3LSbjC8jp1m6fbOcUQKpsC9pD1ee42bo4Y8=;
 b=Dz4fxES8vm8wrbXHSVhagGYFmQ0sCFtAd1sMTKuQtFNnrE8VkNk6QMilft+1yYBPiIlH3OBByYe6RMG6ksuDTk8C2M7wWw9p9KayIIpw/VjsWL13+D/R03t4XrHcUDVltvjIT0AMndGbmK/Bm4ruoTddrDwwcOn8nZc9bUUunTVHFv7qkuve2yAIbR95fav4PI60S2bVECklZzd8VFfLaZfTf16g8QKCycoZMdB/BFBfVKYoIGlZ6XgQtMMUSEsl0vlZCgyUvy6PObWUmNCm7pbzC6dgci+xueFt4hQKjk5hyW8IhSQ4uoIBZLAsLnIxKmuE7JakpqH/0LqumBIiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76QUTVsS3LSbjC8jp1m6fbOcUQKpsC9pD1ee42bo4Y8=;
 b=NpFXGh/z9vlOPwpi/5hTbAcASe6+hRIwkcljFLjtjuKI/3fqIWtBZVKEn9T2dCgl4G+MpDFKTgoFO2aXzSPd6uWEuSQORDCEDnrPI2NAC4QGPK3Tb81JqEbVSUXjNzZFk7dNDvoPmhJVXZMtphsnnKJLrJEk+BEPtzT6X0tjzew=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 02:05:25 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::97) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 02:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 02:05:25 +0000
Received: from [172.31.11.224] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 21:05:23 -0500
Message-ID: <09ee8a01-9938-4ae7-bdbc-4754b7314e73@amd.com>
Date: Mon, 5 May 2025 21:05:22 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
To: Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <shuah@kernel.org>,
	<pgonda@google.com>, <ashish.kalra@amd.com>, <nikunj@amd.com>,
	<pankaj.gupta@amd.com>, <michael.roth@amd.com>, <sraithal@amd.com>
References: <20250305230000.231025-1-prsampat@amd.com>
 <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com> <aBlGp8i_zzGgKeIl@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <aBlGp8i_zzGgKeIl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c2e67b-8942-499a-79bc-08dd8c427767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTVKU2JJN0tKei85d1Ftc1lXeVlsM3U5d3RRREo5NUpwQU41dE9CMzJXQVho?=
 =?utf-8?B?ZXhMWm55b0M5QytBNVcxUDJtc1p2a1JXMkE0Ym43akFjd1JaeE5RSTl3K2pK?=
 =?utf-8?B?ZURBN1pKM0hVU2V3eE9CMCswZnl4QkdBT2IvMVRySW9BSGl5cDAwMkRPQjN3?=
 =?utf-8?B?K1JrMzdYQkdlbmIveUJKQW9sM1pNV3pvb2pXM3hOMFI1YmNYdWZuRTFTTnU3?=
 =?utf-8?B?LzBnb2plK09YUGEwM3I0WUJNTmx5cTAzb0JUZ1ZTWm5NY0MyeHQraVB3dkVI?=
 =?utf-8?B?MDVaZy9GVVlqay80NEEwd2NmM0dhTnVSN1lCeGp3UHRMRzQrRktOY3cxSUdO?=
 =?utf-8?B?UGpaYmIvRXE2UThwdVgyUVY3ZU9pb3ErdjRmQVo3cUNSVSs0VVNmZFRwMGZL?=
 =?utf-8?B?d1hPb2g0bXFrUFFGWUw2UXovbDlNSEVYVXZFYlZhSllGT1BKQVYzV0EzT255?=
 =?utf-8?B?QnR5cmgwNXVPd0FsU1psOWNlcFNFejRsYjgrekdsVmdvbkM5a3Fzc1NJZXJr?=
 =?utf-8?B?MnhPWXhSMHNiKzA0N1FGUjVqb0RpOXRtYWZXbGVpSC9FMVNSRExMcSswcDQw?=
 =?utf-8?B?YTBFZnNJNzdZZ0dJUFFrd2d1Q0p0UllnZ1Q3cXVqMEVWRjlHY1g3Tk5uNEVi?=
 =?utf-8?B?ZDBOdUdUV1dyUklLYWNYY3hhL0xpZktoYWc0QUxMMmtNeGFNZHZaZFl1RHJn?=
 =?utf-8?B?cVpoajhiVnRGZ21paUVUWnlNUUVSOGQweCtuekx4d2ZWUDNSRmJST09NZ3JJ?=
 =?utf-8?B?R1g2dEtzNlcxQ1BvY3R5dU1OT2hGSUhHRmg5d0YwUi94alREQm9zcnlwWGlL?=
 =?utf-8?B?V25KVlMzOEVsWG50UVVyS05Tb0tBKzE2THFXSWExRW5tWVdibGdIN1dQWExT?=
 =?utf-8?B?SmtwakpMQVFoY1RhakkzZWlvU243MnJTMURqWmtLTDJEc3YvcnN3N2YvYzZH?=
 =?utf-8?B?Tk5Bb2dhSncxcXdwQU9FR3Vvd1JRT1ZyeUU4VWhlQ3h2MkFCblowdGZhVmJt?=
 =?utf-8?B?Y09SWlB1akZCNjliT0twZnNwZTNyOWszY3lHdktINC8rWjhOMGg3cEw2QU9h?=
 =?utf-8?B?WWk0R2pIZDFoYWtSRDJrL1JKNFc4OWdYZnBlZjZjU2Qya1pVcU41cWoxL0Yx?=
 =?utf-8?B?Wi9vT0U3ZVZ5VlBuNlp1YStpV3M0WHcrT1dKUHlERFM2eHBrWHJCcjRrOVQv?=
 =?utf-8?B?QS9HMTJVWVMvcUl1YzRqbWZvb1lVYWFnQmd5ck9BYm5LYjdZSzZvTWJvQVAz?=
 =?utf-8?B?bEd1eTVnMWg4RVVkY3ZlV3pGazM1ZlFZOVhRcUoyNWtyV1czWFRMK1R0TmpP?=
 =?utf-8?B?WkVNSFNOL0JTaGFOYUVkMVJ4dWlkSkFEeTl4d1FySWZHbGtPNHJaNVZ1ZFYz?=
 =?utf-8?B?V1h4RHRQSGhiTXg0dDZYRVphUG02VTc4OWsyUFc3enFIclo5bW05Q2xDSUUx?=
 =?utf-8?B?cFNXUVdQVGx4VHpKVXR1aTYyaExROFJQTEdzY3FwMG1XYWE1NFJNNWxjb2t6?=
 =?utf-8?B?YjdOR1ppSGgrR2tsMzQxalNJaU03a0RpOTh4K0RnQVhDb0hPSnkvalhpNEo2?=
 =?utf-8?B?bzJjVVpKeU9wb1E4L21ZRmoyMHZlRTNMSkdhTzlNaS94UnY1TkFmRGpud2tS?=
 =?utf-8?B?Smt0dGNjdlZHNkhVYmljL2NvcTlzcmZZUzlvbFdlQWkrSlVXVDk4RlFsb0pH?=
 =?utf-8?B?cTNxL1pTcDVXRUczRWlSZjJGSzJ4ODViUEptcU41c2ViOGNNT0xXNllPYnFT?=
 =?utf-8?B?OElncmJCV3NSSHp3ZkNxZitKaWFVQkRRWk1nUHpuVW1pSHVLRVFxWEtTL3hZ?=
 =?utf-8?B?OHRBMnBHMXZxMFV0dkZvTkxrK1JkZnVCUmRoa1h0QkVRVjVrb0NKNWUvYnFp?=
 =?utf-8?B?Y0ZzejU2Z0hLakluMDhLenFMSVA3czlIbDJ6a1pvbStQcEdtelVmZkUzVlBE?=
 =?utf-8?B?aEdLSmt1V3Q4MlV6dkdpUDV6a3RhWWNhYUVpMm5JckcwdnZmeHN0ZlFJaUVX?=
 =?utf-8?B?WUR4WGxrNFdtMlJVM0ZkQVVMU3BWR2hKbjVQQXJSVENQWkpyR1BwVElVd3Fm?=
 =?utf-8?Q?nryO/m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 02:05:25.3943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c2e67b-8942-499a-79bc-08dd8c427767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512



On 5/5/2025 6:15 PM, Sean Christopherson wrote:
> On Mon, May 05, 2025, Pratik R. Sampat wrote:
>> Hi Sean,
>>
>> On 5/2/25 4:50 PM, Sean Christopherson wrote:
>>> On Wed, 05 Mar 2025 16:59:50 -0600, Pratik R. Sampat wrote:
>>>> This patch series extends the sev_init2 and the sev_smoke test to
>>>> exercise the SEV-SNP VM launch workflow.
>>>>
>>>> Primarily, it introduces the architectural defines, its support in the
>>>> SEV library and extends the tests to interact with the SEV-SNP ioctl()
>>>> wrappers.
>>>>
>>>> [...]
>>>
>>> Applied 2-9 to kvm-x86 selftests.  AIUI, the KVM side of things should already
>>> be fixed.  If KVM isn't fixed, I want to take that discussion/patch to a
>>> separate thread.
>>>
>>
>> Thanks for pulling these patches in.
>>
>> For 1 - Ashish's commit now returns failure for this case [1].
>> Although, it appears that the return code isn't checked within
>> sev_platform_init()[2], so it shouldn't change existing behavior. In the
>> kselftest case, if platform init fails, the selftest will also fail — just as
>> it does currently too.
> 
> Argh, now I remember the issue.  But _sev_platform_init_locked() returns '0' if
> psp_init_on_probe is true, and I don't see how deferring __sev_snp_init_locked()
> will magically make it succeed the second time around.
> 
> So shouldn't the KVM code be this?
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index e0f446922a6e..dd04f979357d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3038,6 +3038,14 @@ void __init sev_hardware_setup(void)
>         sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +       if (sev_enabled) {
> +               init_args.probe = true;
> +               if (sev_platform_init(&init_args))
> +                       sev_supported = sev_es_supported = sev_snp_supported = false;
> +               else
> +                       sev_snp_supported &= sev_is_snp_initialized();
> +       }
> +
>         if (boot_cpu_has(X86_FEATURE_SEV))
>                 pr_info("SEV %s (ASIDs %u - %u)\n",
>                         sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
>  
>         if (!sev_enabled)
>                 return;
> -
> -       /*
> -        * Do both SNP and SEV initialization at KVM module load.
> -        */
> -       init_args.probe = true;
> -       sev_platform_init(&init_args);
>  }
>  
>  void sev_hardware_unsetup(void)
> --
> 

I agree with this approach. One thing maybe to consider further is to also call
into SEV_platform_status() to check for init so that SEV/SEV-ES is not
penalized and disabled for SNP's failures. Another approach could be to break
up the SEV and SNP init setup so that we can spare a couple of platform calls
in the process?

> Ashish, what am I missing?
> 
>> Regardless of what we decide on what the right behavior is, fail vs skip (I
>> don't mind the former) we can certainly do that over new patches rebased over
>> the new series.
> 
> FAIL, for sure.  Unless someone else pipes up with a good reason why they need
> to defer INIT_EX, that's Google's problem to solve.
Ack!

Pratik


