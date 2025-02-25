Return-Path: <linux-kselftest+bounces-27482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB02A4471B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C40174F8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48831624E9;
	Tue, 25 Feb 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4JtFQ2m0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB2440C;
	Tue, 25 Feb 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502220; cv=fail; b=fZQap5BJ9hlQfJqeKUjuOf3hCpi77cQ2JbCr6EjYL51MIa3XlF/C20thxXD3qWMOh5FxPYdZvfv5bZW2fcOQ2JfWNgrGJ8VBWZxxJqig7bF3z5wT1tYYScoTpC4rx06byy4Wjh+VhEpjANrFYkI/ljJu2IpSTUcirt9hYc6qSJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502220; c=relaxed/simple;
	bh=XQQsODO8wZWerJBF31WxiewZg16STYQqqKXs1zqpbM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dWKZmIXsZ2ABMBsH01AG4H8nJ+gEBSibKC9RujUw5RYc2rzli7u2LdUuKt6QbNLHhy1w7jigHcwatmadvKm/uQvs4hxckZfLDfNOII9kKeREyBzAV2EvlfoJy7BgX7+f314F8aRH5S3aozQb4QSR/WgjEbK/KEXIg28S4aDAxcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4JtFQ2m0; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmNSscw8ModOJtl+jL/jWd8vTwAp0HJ3cGKax7FOHvlyXL+1xFl86496Usbin1ERNvP3kLtOzNW25R39ezGBt4uAEScPaehsW6YkkUEpxN+lEcpgi764/1s+j+aoizzNtesKMeir9HZpeUj/hueksEZAFMjTJ0/SoOUT1vDUTrhgcFp5DFRklaHMPmWdshd4o5Pray4ikoBvzCvD4kguTt7cQ+vagzDrKNgB1Za7aU4f5ff5KCgDLj2Tg26NOQ2d8dOUUn0K4taghiOqHcH8uVF97FNzrnscdzH+Hd2DE1nKlPQnhPvQzv9TSX8j55wgC9Sv9NEij6YhEdNgurS1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUsFI2J7KQTplpsnCqkn6dN5Y6psR3kEJbYFpTXAnVg=;
 b=fqYUek4dyugd51kyU2DbzhNkgX8BYzFofvcMW9tfXa8kgT+SBhTfanj5y3U2+JyFNTVCAhMQOwZP3N/RM6LCZPCKWNi+1UM7YUuQ1odYsz28ZVP/Q8qPVQSYPf6XG0tGWKJiLrDEfMSUQNePjIDvzZGQJqqQu4c5tLyU83QzJ0aFl2FA4neW/B9pBa5WDlIpKz/FV5/iC1ZERhRVc1Bp2VYOpomlVDaO4Pdqy7RQNOnVTzMhbRECH0SFuC3iX0qTw+I2gsmyFA2V6CGq4dW34AvDxKYdsEDvNaJ4La11uqeLkdJ8OQNdT/IH5ljYBvNJ7MThq0tdveiacow8PhlEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUsFI2J7KQTplpsnCqkn6dN5Y6psR3kEJbYFpTXAnVg=;
 b=4JtFQ2m0IYnBgrkTrAzaKbkHIyuPxo0U3ZDAiMuYhjuXsTboCJMDLQQoEYRalJ6U8jpR8bKqU5wOqquPqQz4A/+NgFEVnSG/xaY1/0Y55bzMFqx0HsZIP71sNHJdGqW5MmprznEM0/kJbSQX4rkuRSWAyZSwZXk6ULJshm/lh6M=
Received: from BN9PR03CA0928.namprd03.prod.outlook.com (2603:10b6:408:107::33)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 16:50:16 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::5d) by BN9PR03CA0928.outlook.office365.com
 (2603:10b6:408:107::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 16:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 16:50:16 +0000
Received: from [10.236.185.178] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 10:50:13 -0600
Message-ID: <f66c47d0-d111-45a8-8cf5-bd4577bbe6e5@amd.com>
Date: Tue, 25 Feb 2025 10:50:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on
 initialization failure
To: Liam Merwick <liam.merwick@oracle.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
 <20250221210200.244405-2-prsampat@amd.com>
 <593571c4-39c5-4647-82f2-98094ec9f437@oracle.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <593571c4-39c5-4647-82f2-98094ec9f437@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c93964-b002-4a24-f11e-08dd55bc7ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enMxS2FRbXNnNVJ4NzVNaEx5S3Y2b2h5a3FFRzZWdHpNUFBWWEo0RGxJVzNs?=
 =?utf-8?B?Q3ZSejdwOFZtMGp5Nzlhenl1T1VCeWgrRlJ6Z0kvcjVyZkNnWHY4Z0hpcXd5?=
 =?utf-8?B?aERDQ1psVnEyNXRDMHhpQU5EaUlJYXYyOTFZaENDd3hiQUkxVzJYTUN1MlpC?=
 =?utf-8?B?cllXekk3eVhJSmJ1cUVEMnNjWmN0Q0NBVnRZOW4zY3FYVHhOeVlRZHlDbERo?=
 =?utf-8?B?SU1ONjJydDQyM2JzMG1oTElzd0U3aWdCN1JWT01TaGxLSXJYNDZZcDRmcXZw?=
 =?utf-8?B?Ulpqa2oxdExEbnBqYjN6UXRtZS9XVUtpcEFzK1puRTdFR2RwQ3B1NHdRSDYy?=
 =?utf-8?B?ekpKN09uZmFQcjA2QnJkVTlySzhhQ3VscUtZZG1sNGFJTkJQVWc3TWo5UTRW?=
 =?utf-8?B?NWpwVXVPekZGODhZNkZPVktzNmp3TElWNEoxaGF0dWdHM1lhM1g4djFjRjlK?=
 =?utf-8?B?OVFPMitBVmRXdGxHa2xwUVRidEtvd2pmNUh5bW1wazZZV3g4NlhxUWxpeFhQ?=
 =?utf-8?B?QzBtdUZJMkxKQTJ2YjJhWUtpTUlBVmhKL2VuZXUvY1hSb3FoRUI4YVpKMWEy?=
 =?utf-8?B?V1pYc2hPanluNDFWaFdnSzdBUnNHMy9uTCtNV0JxVk5TS1Rvbk1SSVBEVVpu?=
 =?utf-8?B?MG02K25GNldHcWl6NXRhdHlnVjE3MkcyUnlNWmhWTCs3S1plbFpNZXpQOXh1?=
 =?utf-8?B?UHBISjk5aTdJczlmUzRLMTB6c0piUXUzeE9CYURjSjFyWFd5bHNVVzRHRXQ2?=
 =?utf-8?B?TnA3d1lFRldJRS9EWVNVM3kxeHEwRFRrNWVQMk93SmVlQW5VMm1ja0FRNGJi?=
 =?utf-8?B?UVZ0bnpYQ0o0NWlPS3lVNHZHU0hNOENWTmVVYVlQOVg4MHR3R3VQNXVRWUlH?=
 =?utf-8?B?V01EOFR5b3BOcjNXVklCSkJHTzIzeTNJSDh4R3FxZGxCL2l1bFdCMCtnTnZM?=
 =?utf-8?B?TjNNTVRJLytNbDR1OU92NWhyQVFZUGN6TWU0TE4rOWFLc3pUMFpidDRVRVV3?=
 =?utf-8?B?SkxXeFVwWnB6TFhPRFRzWkdPRFErSkg2K3FUM285UmNFMVVWK1hkNmdTQldR?=
 =?utf-8?B?V2FmUEtBR0xsUzg3elJHV0dQbU5hWmwvRExWcDlta2NDZlZleXpBZklBVW5J?=
 =?utf-8?B?akxtZUdzRGRPWldJUmUwSTJ6UEtENTFJYm1GM1R3YjZXNkp6dDNhNlBBTEJP?=
 =?utf-8?B?cC8rK0c3UlhqUTlNclpOVGl0WWpSbjl6L3I4aDk5eU91TllTMTVrVmxwVWhR?=
 =?utf-8?B?OWI3REpWdjF1dlU5SmFXUnhsZnB1TzVmbDkyMk9aRGErTkJpa0xEamZqTCtk?=
 =?utf-8?B?VE8weTVaMURxZmVkcUVmVU83TWlPUGErYjJSUXBZdFJJazZHbkNWQWNBYk4r?=
 =?utf-8?B?ZTY4WXZuQ00veXpCWS9xMmQwbFg3S3V5bXBPVVUxOHFXVWF6U2k2NGF5YTk1?=
 =?utf-8?B?Ukg2UEdmdFlDS3ZVdXFZYVM1UDNCZXBDRFBxWnk4S1crS2kwT042NDdJcVh4?=
 =?utf-8?B?UVQ5R3BxZ1dJcXFoWmx4VTNGZzhGTjdKMzJPRjRXNzhOcldXVFRtSG1zVzlK?=
 =?utf-8?B?VWxCLzJUTjJXOGRuTlBvcEZYZWVFdnJDN0ZDd2xDNkxPOFcyY3ROWHdZbVkx?=
 =?utf-8?B?VzRtaFp6TnNKSzRGWW1mM0pqbHJIR3pCREpzSi8wMklCTmFlek5zRCttaFlI?=
 =?utf-8?B?bEt3aC84VFNmSHBRN283ZGVWR0VPdkZmRmZ5cytDRXQrMmN0L25GWjd3ZitR?=
 =?utf-8?B?eVIvdGovU2N0bGxUTWc5QVA2UDBwYXlpZURGZWtFdnJqYjFuZk4xMG8zMnVF?=
 =?utf-8?B?UjJtUllUR1hLNW1YZ0M0YjhRZitsOEpZVFQ1M2FDNWgrbXZnaGRSVExoajhy?=
 =?utf-8?B?aTVERitHYXZKd1Fjd3JxdjNmTmZSeC9NbHNPSWQ5Z1FwcGFqNkFseHVrRWVF?=
 =?utf-8?B?MDZGRUVQSjd0Tkd5aXMzS0F4WGcxd2hOUVo4UVBIK0xNVzBpYjA2T0lObndt?=
 =?utf-8?Q?rykh8LPAaqu2UOCrXgU1PjaER/0yzs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:50:16.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c93964-b002-4a24-f11e-08dd55bc7ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709

Hi Liam,

Thanks for review!

On 2/24/2025 1:01 PM, Liam Merwick wrote:
> 
> 
> On 21/02/2025 21:01, Pratik R. Sampat wrote:
>> During platform init, SNP initialization may fail for several reasons,
>> such as firmware command failures and incompatible versions. However,
>> the KVM capability may continue to advertise support for it. Export this
>> information to KVM and withdraw SEV-SNP support if has not been
>> successfully initialized.
>>
>> Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> ---
>> v6..v7:
>>
>> * Replace FW version check with sev->snp_initialized (Sean)
>> ---
>>   arch/x86/kvm/svm/sev.c       | 4 +++-
>>   drivers/crypto/ccp/sev-dev.c | 8 ++++++++
>>   include/linux/psp-sev.h      | 3 +++
>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 0dbb25442ec1..87b5d63a5817 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -3050,7 +3050,9 @@ void __init sev_hardware_setup(void)
>>       sev_es_asid_count = min_sev_asid - 1;
>>       WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES,
>> sev_es_asid_count));
>>       sev_es_supported = true;
>> -    sev_snp_supported = sev_snp_enabled &&
>> cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>> +    sev_snp_supported = (sev_snp_enabled &&
>> +                cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
>> +                snp_initialized());
>>     out:
>>       if (boot_cpu_has(X86_FEATURE_SEV))
>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>> index 2e87ca0e292a..8d2cf8552bc2 100644
>> --- a/drivers/crypto/ccp/sev-dev.c
>> +++ b/drivers/crypto/ccp/sev-dev.c
>> @@ -1352,6 +1352,14 @@ int sev_platform_init(struct
>> sev_platform_init_args *args)
>>   }
>>   EXPORT_SYMBOL_GPL(sev_platform_init);
>>   +bool snp_initialized(void)
>> +{
>> +    struct sev_device *sev = psp_master->sev_data;
> 
> 
> Should check psp_master isn't NULL before accessing just in case
> (particularly for future potential callers).
> 
> (e.g. see ccb88e9549e7 ("crypto: ccp - Fix null pointer dereference in
> __sev_platform_shutdown_locked")
> 

Thanks for pointing this out, if I end up using this interface, I'll put
the NULL check in.

Thanks!
Pratik
> 
> 
> 
>> +
>> +    return sev->snp_initialized;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_initialized);
>> +
>>   static int __sev_platform_shutdown_locked(int *error)
>>   {
>>       struct psp_device *psp = psp_master;
>> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
>> index f3cad182d4ef..d34068c87a28 100644
>> --- a/include/linux/psp-sev.h
>> +++ b/include/linux/psp-sev.h
>> @@ -954,6 +954,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
>>   void *psp_copy_user_blob(u64 uaddr, u32 len);
>>   void *snp_alloc_firmware_page(gfp_t mask);
>>   void snp_free_firmware_page(void *addr);
>> +bool snp_initialized(void);
>>     #else    /* !CONFIG_CRYPTO_DEV_SP_PSP */
>>   @@ -988,6 +989,8 @@ static inline void
>> *snp_alloc_firmware_page(gfp_t mask)
>>     static inline void snp_free_firmware_page(void *addr) { }
>>   +static inline bool snp_initialized(void) { return false; }
>> +
>>   #endif    /* CONFIG_CRYPTO_DEV_SP_PSP */
>>     #endif    /* __PSP_SEV_H__ */
> 


