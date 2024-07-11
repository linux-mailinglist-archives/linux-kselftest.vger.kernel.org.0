Return-Path: <linux-kselftest+bounces-13603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922F92EC82
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76D51F23547
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4316CD12;
	Thu, 11 Jul 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YWF2IBjW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AF288B5;
	Thu, 11 Jul 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714809; cv=fail; b=dTKr7o1xBpWLjFDhGprXC56culk6oQyXPUovlBLe6zqqdp0IxyxeB1SMOzxh2bwcyljJ33LzutG6qBj+Wi64r64wsAbTKdSGl4ycFUakAfNEIjyKolDuPkToGmnda+2ilrgDkxmZrnv9CKFJuQvdUs9JLkF7AePgjxnDkOCFgFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714809; c=relaxed/simple;
	bh=ynC+jsqopGcr7CwEpI1Igb6ztWCrE7SWfhOZ8zmqCEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NX+kbbpySyBqAb9XSalbIdd+eyzGVN/GRv+mbby0Y+at27sOmlAYbHEOPJrJp20Hym27uhf/Mx0NcGtB1+SXqfQr4BO/FUxnaKyeOCFpVx1YI8GrlP+mWBFoToqHMnKqg1NPY5nqluBjmWcwu/s9Za3ChhXJ8M8xyfNlzIH71og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YWF2IBjW; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPzRcVomAO4OHaAVMuUqC9Gu4oi+E8WxK/qoGoWkEygG8X/4BLA9ZZWlI6WyoQx0zHxawm/X7dGa0jpFZoaXsM/b//6vF3e2c1LSU9JeZuZYhvLOgh0+R+ghpJ6ThqEHxslIPDRUA52dhoR+nYzZi+wUudBzF4F0dP8Rpni8bH5VofArCQenYhYo3R60kMQimrXBN8rcBKshc6OIt85NFzhEBz5vVAFcK259Fuh2jeDbM5CmtVNjyrdDsE4lZDSmRMbGJAsqLnge5MvgK3XyY2DXKRJdr3A/Q9jr1aiFsuq9mRZvC2EpU6FCtLchmOLh5hNlpjQstGFGq+6S4IJG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/deBz/vPvkacVpMn+G+ul0zuK5XjVOterg2hYExUWwE=;
 b=eGuGFpYSChMHO/n4xFlRAHY9IkeGRD6BZAYDWF0YctoIH9o4wuwJ7jZVyjcnJpbiICT3uxlYpQy96bCgiNWO5EJD1lwN8QTYV0D+kaocPt+kI8TEiMxjeJLjEolm082L86DcgfDGniwV8LBnpduVZE2Ct8wDMEnB4iBJVM7qkSdQchpEbqAbUKTFV99TWXb/VPre2ZkGdg8C2p6iDsJMkHDhB24Uc/pSzBh4MfK1jECkHdFMEuem2MNU/HSxv6FTOEEXLN1YK844787+7zGH6nJzwnvXFThuTsQWqk5M5ahHUph0Ds48Gko1ypctDCMvsW/M3alOmO1DqfpFOMRSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/deBz/vPvkacVpMn+G+ul0zuK5XjVOterg2hYExUWwE=;
 b=YWF2IBjWhLvK/7EXKWCfgNiW/3iOAH2ZBHtsPafodsK6LQtad/PCzspiGhqD5T90hikzbt2LGCx/548zSqVRkXm1ucSHBE7wKHjNiFMapLjc+Sm+XTqPp1gUsOMOfqP1ypkx9LzzT0/VLId5Bno3nPlzz174YYH2tMlJDgktEbg=
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 16:20:01 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e5) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Thu, 11 Jul 2024 16:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:20:01 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:19:59 -0500
Message-ID: <c0faf3d7-2589-4c51-a3c7-4e4a33c3baf5@amd.com>
Date: Thu, 11 Jul 2024 11:19:58 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Add SEV-ES shutdown test
To: Peter Gonda <pgonda@google.com>, <kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Alper Gun <alpergun@google.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
	<linux-kselftest@vger.kernel.org>
References: <20240709182936.146487-1-pgonda@google.com>
Content-Language: en-US
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
In-Reply-To: <20240709182936.146487-1-pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 53da9e32-32af-4cb8-3c36-08dca1c5509b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnVpZEZsNE9pTGIwdUNNa0kzWUJ5cUZLc2gwNmZyM1FYL2l2a0xKQW1NYWQy?=
 =?utf-8?B?MTFJQW9vaFNFR2FFamtnVlZJMUZOM0pZb1gyZUFPQzFDLzZ5UUJvL2JnVmZP?=
 =?utf-8?B?R1ljeWpJSStIVFVqYTNrL0lLaXpJMlNJcy85YW5ZMFBEMWZvQ3U3c0xjaGdP?=
 =?utf-8?B?WjV5YkZNTmlIMEZCSlhZalI2N0JBVHRSZ2cyQVVHZkVpQ3NuR0xJbTEwUGo3?=
 =?utf-8?B?LzJMekZaNFVHQktLV3BjS3M4akNYOU52S213bUpoZUVKbmoySEJUMHpVeFBn?=
 =?utf-8?B?eEFZNmxKSW4zODdva3NVeWQ4Tkd3bHArYTBFejJMVUhEc1FMekFNVkNDdXNP?=
 =?utf-8?B?ejJkRy9aS3FZOEw0VFAwaFRVU2dHdGVVc2krbnd6MDBxSkt2NnFvNnpyT0Qz?=
 =?utf-8?B?NDYvRFEyZ2ZZc1J5T0NrY1ZjV2hESGI2elRWSW5uQWRYZEJRdnJlem9TODNJ?=
 =?utf-8?B?NXZxNjNRNlJ6cUVGdk5CdGRSNWtkM09GaVNFbnJPUTZLY3RBdHIzbnhqWjlI?=
 =?utf-8?B?WGtVZDVVbUVpdDZOS3VEaU9hOFBXSTYrYUViOE5UVG9zcXd4dVVzTGpqdVFR?=
 =?utf-8?B?TWh1bTVkemdjVjBNMXdVN3FUWG1JSjVsY0NpSGlqcXdOYUZ5YlNYOGh4ekdw?=
 =?utf-8?B?THJXT3Y0WlViL3ExTndZcFRzZkprRDdoemZZeGJoeG5lZTNRTEJuRi9qeXIw?=
 =?utf-8?B?QTEvZ2Z6a3FYdFBtN1hUSW9JeEFCaGVnSnlQRUZvNkUvM1F3eCtNVWNxc2F4?=
 =?utf-8?B?b2pDTk9tUkdRQVozSkwvdnZqZmhsT3oxM2VHbXRyblQxL0hra1BGTUhNR1BG?=
 =?utf-8?B?aEZPT0c1MzJyY2VFRWwwWStWdXJPdlN1U3BteWk4U0k0VU5aYWErL1ZBdEN6?=
 =?utf-8?B?S0pORkpIaFJWMW41elE0Q3JxV2RMYmVoSWtrOFhnZ1dUejEySVZjZFplMkVZ?=
 =?utf-8?B?MG85bmprbmFieUdYV1lOSzYyNFB2bzhFRmcyZzQrbXovSEhyWE53eWxycUVK?=
 =?utf-8?B?eDVDN0dlM0hVT0cxOVBMT1orSngvVkllWWFOaXRjaHV0Rm5FaHdvNGYrem5J?=
 =?utf-8?B?NU1qWkdHa0ZJWjV6Y1hnYS9seDZzU1ROVWdrTXFEcmZFYnR3dllZRmVYcWRo?=
 =?utf-8?B?SWxqcWJRZ1EwV09SbHJCSzRrZmJvT2VVaEcvU3J6eGNtV0ZaWFplUEpVWCt3?=
 =?utf-8?B?UEZIOElDV1lWYmhvaEZmNE9VbTBIWnpwb21ReE5KM2x0ZmxiN0FmUktNYWFk?=
 =?utf-8?B?MlE2dGlSeUZiSmtOQWVhUnNPUWhydTc2R1BOQUE1YUR4YlBrYkFZeFkwenMv?=
 =?utf-8?B?a2hYRG5wV1EvSU9OMUdyTTVQb3NoVmFVbUZUeDNsTStPb0hFT0llRVluVTNv?=
 =?utf-8?B?UjErSjZWSnF3TFVlRWRMRGdoL0pORkpEcXJmYU5HUWxYZG5NVWRiTlpZTWlx?=
 =?utf-8?B?NkpxR1laYU1aTm4zc1kyNjRmakpobW95b2hlYzFuOUNnSXJLLy94dDhTRWNq?=
 =?utf-8?B?UjhYa2lhSG80MDh4RFFLZ3FxNkJQb2xLQ0lBaVBTUHlJNXgwZW5nYUMwNTA3?=
 =?utf-8?B?MExaNW80dncxbGRSanRYZUo0aE5FSUJteHZmWkNJM3FacmdmQ1FJQTJ6U09o?=
 =?utf-8?B?dG5ZbjM3Tm9lZXQ3WVV5Uzk5MTlLTDBUOG1wc0p2clZTdVRzakVJOWJiMUhy?=
 =?utf-8?B?MlRxcVBwNTJoc2w0U2FtU1VTb2x2aDh3ci9sbUlhcll1STJKTkQ2U2ZKZFA1?=
 =?utf-8?B?czBkZVQ3ZFBmY1NwZkk0NjQ3ZC9NaXQrVEwrOXpuWk4rTnd1TmR0ZmFMYUlM?=
 =?utf-8?B?RzVIaHREa2cwRGUyN3RhejEyU0ZzRk90K3FvMlRnSTUrU1liTG1BY2Z6ckJD?=
 =?utf-8?B?cy80MUxncUJzWThTbSt6MzV3TTZwWTIwWUw0WWdnYXhpdGpPTFoxdjFUbzFq?=
 =?utf-8?Q?H7wlJQ9Q5w7qrvMkyS67CxPkKVI1HNEY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:20:01.0091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53da9e32-32af-4cb8-3c36-08dca1c5509b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

Hi Peter,

On 7/9/2024 1:29 PM, Peter Gonda wrote:
> Regression test for ae20eef5 ("KVM: SVM: Update SEV-ES shutdown intercepts
> with more metadata"). Test confirms userspace is correctly indicated of
> a guest shutdown not previous behavior of an EINVAL from KVM_RUN.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Alper Gun <alpergun@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Peter Gonda <pgonda@google.com>

Tested-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

> 
> ---
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 7c70c0da4fb74..04f24d5f09877 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -160,6 +160,30 @@ static void test_sev(void *guest_code, uint64_t policy)
>  	kvm_vm_free(vm);
>  }
>  
> +static void guest_shutdown_code(void)
> +{
> +	__asm__ __volatile__("ud2");
> +}
> +
> +static void test_sev_es_shutdown(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	uint32_t type = KVM_X86_SEV_ES_VM;
> +
> +	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
> +
> +	vm_sev_launch(vm, SEV_POLICY_ES, NULL);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN,
> +		    "Wanted SHUTDOWN, got %s",
> +		    exit_reason_str(vcpu->run->exit_reason));
> +
> +	kvm_vm_free(vm);
> +}
> +

I guess this case also applies to SNP. So maybe once this patch is
queued up I could spin another patch in my SNP kselftest patch series
that parameterizes this function to test SNP as well.

Thanks!
Pratik

>  int main(int argc, char *argv[])
>  {
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
> @@ -171,6 +195,8 @@ int main(int argc, char *argv[])
>  		test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
>  		test_sev(guest_sev_es_code, SEV_POLICY_ES);
>  
> +		test_sev_es_shutdown();
> +
>  		if (kvm_has_cap(KVM_CAP_XCRS) &&
>  		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
>  			test_sync_vmsa(0);

