Return-Path: <linux-kselftest+bounces-13604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399D92EC84
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D321C21A08
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3816CD30;
	Thu, 11 Jul 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zH4sU3pq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0667288B5;
	Thu, 11 Jul 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714871; cv=fail; b=h5H+WiO0GQLTZt91LGfT1TFDsHXZhpYwfMaMWj+JBBor27/oIZ/1g++Ai34iVzKqQjwzKOnCNObzll/AH0LIpQrqmT/z3Pb9gMiAhDJbQIc76UOqOiEan3NjR9uhF1jU3Zuaj3n6LDGw6y5y3Jq0IHml/Q/vhPqRDyYYkEsqg0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714871; c=relaxed/simple;
	bh=ugC9N7hgYAQ4pn3i+MvsaVzkA/byEPw7UZn2FbuNzmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qNgKT2dsM0eMp1orn/0+7FPgPCfqTH2FY9VrOjzDUNUW2WSaI26tOpNGlIlpN9QFFSKhn1OFWQgFoMZQ3qH2iAChJHiZKmn/a/R2EG70wvCIewDLDmNffyVmTia3bmwZTNN6144jF4SY01QcBdZQ+AYHVQoZTSVzE5knKvbuim0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zH4sU3pq; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbZP/wkG+siLHrMi8rQShhra9jwCa7SLuMjVR6l7BD+Idt1nKyaHX3Y+2jbUPXBlD9giJ5EvbGoQDOrO3MbOPNMd5TniaQsm2bzScGTittFTvEx6sXhd7wbemf3rkyLYul7Bdk2p+i3i7RfYKDXmFFhOZysG+LJc4MixTgJPR9ueeoN7cmvljRyok9fcPW7kKwg5Le7fs5PTWcaPnrXVnYY+KunJD8RG2PtyTG1r+MSQbO1q7GbP1lnniUiGIva40PWvRHHQhR+/tn74RulAxQqQE27sFm0N4U9Pjj4BNAamktKYaSl5mZTaOx1RMOTTGDsKKU1H7wI2Hk8VhSTy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Y9D+/z+crwm8A5wrMIxz7LcxnnQp1OQ11/329GLH4=;
 b=PF0AHI7UHBVg5XUHfqNBR6tg/ll50uOvdZkOvWQGjXRhfNHHsg/SdjLVYRpkRI72aqg+0mTx6CiTxiWTRZ0m9At8BczLZpBjBloBNFbRhYJ6GGCO9pDkGC1xnvlgs9WtFE3fZ3YJ8upz+I/leFKrRHOPLdy5cG308jqwn7hAXrCw1pLSnutcGprd7PdriDXbGOyl2wIj9pcNHHic6CpmrS05XexMFMLS7PD+Llti/76WZsviajwb+xIyFoUow4IaKtknqwL7oOVEI+7eYh3up48ZRePVKwfj/DFiKlfwYi/FBjc+xroxa1iEhST/SqBr0MP5F6c0rPFEYp82OY8uuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Y9D+/z+crwm8A5wrMIxz7LcxnnQp1OQ11/329GLH4=;
 b=zH4sU3pquiMIf5qqtnsqpjE7o45zE4LxXDCqrhV45nxh/gaDMQW+/DFgpzFVKT+rqyL/fAqYD1n8busE+/6sD/GLEFe7BuFEXtnYWXjQaCXDUR9vlKzchZjLLxm/ly8tXIsz5+5eq7PSWdgeTMg1sG31LaMXdHHU/q+CiEhbhaY=
Received: from DS7PR05CA0041.namprd05.prod.outlook.com (2603:10b6:8:2f::8) by
 SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Thu, 11 Jul 2024 16:21:07 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::a0) by DS7PR05CA0041.outlook.office365.com
 (2603:10b6:8:2f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 16:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:21:07 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:21:05 -0500
Message-ID: <3c35c4fd-3cae-4779-8b54-24a6fccb3017@amd.com>
Date: Thu, 11 Jul 2024 11:21:05 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] selftests: KVM: Add a basic SNP smoke test
To: Peter Gonda <pgonda@google.com>
CC: <kvm@vger.kernel.org>, <shuah@kernel.org>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
 <CAMkAt6oc5YC8oLpvFDeCOrEH6Hm88M_U_eMBPXpQWvcqjL7nzg@mail.gmail.com>
Content-Language: en-US
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
In-Reply-To: <CAMkAt6oc5YC8oLpvFDeCOrEH6Hm88M_U_eMBPXpQWvcqjL7nzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 79647990-a41f-4b09-ebd9-08dca1c5780e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3psTUh2NXdVVVRIQTBpKzhPdHoyTHFYN3l0K0FUYjNhWjlSODFJREdpYTBw?=
 =?utf-8?B?VnNJZGpOSG9xODhpWG1CZWY4UXVlMlBHWGNZWExSMHJ2QlYzK3cwbnVtWXVG?=
 =?utf-8?B?WHJSekxncDA1WDl1UnBqVnRkVXllRmNiTjQ0S1M1QlErMHdOY3ZpNWxUS09L?=
 =?utf-8?B?eDArNjJDZE9qRW5IVzN1ditmV0pjWldzWVFjZDJvM1FNdTZJMWR5VkE0ODRo?=
 =?utf-8?B?ZXJYZUtxNXlPczhZZW9vYU84aENPQitrMFdGZ0dEVmFpWUY2eU5hN2xkREkx?=
 =?utf-8?B?ZGVSZkw3SExoSTN4WkdyRitmRlBtRyttd3dteXFqRXQxVnVhNWpoNk8wWjZn?=
 =?utf-8?B?ZmhEN05QM2tsdzBCOVhtUmFqdm5Od1NpSEIwTXdWVnpJYVpKV3lHd1E0UEsx?=
 =?utf-8?B?R1BlRyt3VS9xN2hvQUw4WCtEdWdhTDlPdjY4MUk5U0VhajIyd1g2UitlY09L?=
 =?utf-8?B?dnlVMERORDZXMk1EcHJaMEdXTFMrZjJkdGc0dzFVRm8xcWtpK3dNU0xwZ1FJ?=
 =?utf-8?B?ZTA0VUNrdkxXTWMzQkdlNHI0Sm9KQ0dOeXpGV29jTWlSeUNSL2tsUGV4ZkhS?=
 =?utf-8?B?ZmhVelliRG5iWjRSODRDbGpCamIrRFVlWDBXOHJyc3NDL3Vwd05ZdVZxMjVz?=
 =?utf-8?B?QzYrbEtVckp2ZnJ6TDVXbXFSbWg1NWJPSGhoYjU2a0hDdlFHbjZNYjJ0dTVx?=
 =?utf-8?B?WG9WWU54RUxZcGdUZVJnSEczTkpsTGZKUTdDMzI0d0twdTBzZlh3QVNLRy9t?=
 =?utf-8?B?YkkrRDM2dFl4aTJFd1I1eFE5YVZ5VlgveGpDS2hGaGJjTDNCa2pGSitXby9H?=
 =?utf-8?B?VXVadGhhOTVNYkM4VHNxM1FUR2cvTjZsRXBkK3BGOHh6VHBvdmdUNmg2N1Bx?=
 =?utf-8?B?RFVlSHhhSjdyc1VNOUJzekFVb3Qrd3cxaFdrWTUwWmo2SDNzVGgyekVXb2Fj?=
 =?utf-8?B?MHdQcHd2bGlPaUFEOG9JNU80emxQSGZJSTRYdUx4b2JGUDF3WnB0bklKQ24y?=
 =?utf-8?B?QklaOVJ1d0xrU2lzbDRvQ09VUXg0VU5uTFVndEh1MngwVHhvYU1QVE9scWh3?=
 =?utf-8?B?TDFSNFFvRE5QTHJ5dVhPazhiZFdCZjdwcGl5b0hLOWlnKzBQSGlIMmYwcWRk?=
 =?utf-8?B?aGIwRjYvRXc5UVBtQ1Z6K2F4cklKU1lkbGJmZlpFZUJ4TS9LQnVTQytzdmQr?=
 =?utf-8?B?c3hkWW9pNnhRQkNWenVBQkM2eFcwQjB1SGhzeGpDRWVZNURmQ1VPTGlNRGpR?=
 =?utf-8?B?VzZQeEtRK2lJZ3NXN1FiMm5LWURic3BNY2JqY3lxN1BWblJZbU1LUEFxblJs?=
 =?utf-8?B?RnNSaHJCQjJsOHhtcCtMeHBYcUxId1A2aWZZVGptNGRRRkI4cUNNRWt4cXFC?=
 =?utf-8?B?RGlkcXRIUG9IZzlSSEw3WGdoWVBoa3JxbUxyMUd3NThta2QwL0dFZldTMG8y?=
 =?utf-8?B?c1EvS3RoNUk3S29iWGxMcjBNTmVoQ2VnTW91WkpmYk9HTDJ6dXhLWkZXTW40?=
 =?utf-8?B?ejVxUTFWK3VQQlpwZC9kWk0vbHkzM3kvQ1BXV1RFSUFPbXYvdlp1bGNuYmEy?=
 =?utf-8?B?K2U5MUVCQzJCWUZ6ZkhOTU14Um0yMFpDd1plaUF2S2dzeHJ2U3RIMEdVV1B0?=
 =?utf-8?B?R25TaGJibUhuOU5lVEtBUzU1QU5rVTdla056SStLWUVKMnVZenhMSHZoQTdK?=
 =?utf-8?B?TnltdzhZbHcrSmZld3gwRmNxdlErZWhNWVlzWDhDdHVRL0FpU2VOTUl2SUdO?=
 =?utf-8?B?cHgyVnVCMGtJMU50R3NuK1BZWTB6RUFGa21PMmpSOXJDbVhqRWI0UjB4VTJh?=
 =?utf-8?B?bVRXR2JFblZ1THRtVHE2Vzg5SkNnS20xREE4eEVlL1pmWDlVYjd3SE96VERh?=
 =?utf-8?B?S29zNkhEOFFPRjlHNndvQ20zZkM3a3RZbGlWWTBOMTc4dGxxaER3N1E3aVFO?=
 =?utf-8?Q?BW7Yx0aLc2GlHKZ/pTmZ592iuz/kZXAz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:21:07.1672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79647990-a41f-4b09-ebd9-08dca1c5780e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

Hi Peter,

Thank you for your review!

On 7/11/2024 10:16 AM, Peter Gonda wrote:
> On Wed, Jul 10, 2024 at 4:06 PM Pratik R. Sampat
> <pratikrajesh.sampat@amd.com> wrote:
>>
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
> 
> Tested-by: Peter Gonda <pgonda@google.com>
> 
>>
>> -       test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
>> -       test_sev(guest_sev_code, 0);
>> +       test_sev(guest_sev_code, KVM_X86_SEV_VM, SEV_POLICY_NO_DBG);
>> +       test_sev(guest_sev_code, KVM_X86_SEV_VM, 0);
>>
>>         if (kvm_cpu_has(X86_FEATURE_SEV_ES)) {
>> -               test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>> -               test_sev(guest_sev_es_code, SEV_POLICY_ES);
>> +               test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>> +               test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
>> +
>> +               if (kvm_has_cap(KVM_CAP_XCRS) &&
>> +                   (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
>> +                       test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
>> +                       test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>> +               }
>> +       }
>> +
>> +       if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
>> +               test_sev(guest_snp_code, KVM_X86_SNP_VM, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO);
> 
> I'd guess most systems have SMT enabled, but is there a way we can
> check and toggle the SNP_POLICY_SMT policy bit programmatically?
> 

We could do that by making a check to /sys/devices/system/cpu/smt/active
maybe?

> Also should we have a base SNP policy so we don't have to read
> `SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO` every time? Not sure I think
> selftests prefer more verbosity.

Sure, that makes sense. I can also include the following to save us a
few keystrokes and help read easier.
#define SNP_POLICY	SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO

Thanks!
Pratik

