Return-Path: <linux-kselftest+bounces-25300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D9A20A6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D834166B87
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067E1A38E4;
	Tue, 28 Jan 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L8/iQUN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164201A2C06;
	Tue, 28 Jan 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066437; cv=fail; b=qnWZgx1q/Wa29GQ3awxv/zBA8puOcAFjLAex3x74OND7AFZ+QqTSYVzhEm5uqD2GYTcusfXp+br3b9ztj/heQ3GKxtgNUxWNyyPg94csWNRUSpq10j1UtQ2F5fJ7ThLCrzVxK+jj+QDPc8YVrSeySQZ6KKkkBcH75pGsUCyoZb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066437; c=relaxed/simple;
	bh=CK+VtMOeY46MVI6oYANWDUeay+q6O2cePdZdXT+K5l8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PrSohtnuxCJT32E3Op7KFNkJs2ypUfcnJ8tgelVYAMx9EtZuTdF0aYw2dv3C5kX2rQy4dyCKpZ2RLzGzcabWanksKnROxg4drN4H48GxRke8tyNda+vhw4MQGY++ObclsF6u3nJKTN/uqhQ8aYsjMopD59g7ZndDRYvLRvX7lKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L8/iQUN9; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKDZze1Hu66WXvOl8pVE6H7Q0ONRXQTfhZoMQ08Sjuz7sGZSbQlFn/KR89HWiwxocybCCM7OLupGc4YBeE7LDP5Ib7lifTkOze0Pw9Lb2niNCb8m4nBhVQZ3f9LFmneaD8EVV/6bQexyONpG+ScMJWDfdOcHhVgIDnhH1F3wUdOAshY6QzGo9itDtq332ecIz4eDXuZY0JsF4SYA+i8bP45Hb8IcGNyGgPfgKfWbrjzSqaCnNigAvyBU7R7JSwjfrxcGH2B91VDm5KWTrBzl/H/xHBaMKvT6Ok0kqYphB7YXH2pU2/pkRbvopymej86APkbPl53kv8PALzaUfT5UjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itc1QvToGoe+J9d2UwWhwo8C6yFjsoavWAQJrBR4Q0w=;
 b=LaaLHMMvo1UXqC21mZPgsmYAsaGForUzvT06eGJ8FdGiS5aB3iIKHPyLqJuJcmXmz/c4q4kINceqQmdrtKFDywGHuj1ETyErhYSVtojvMcyWbTVtCPurVXDF7hnbzCKBQU74xhnCfx3cndINKkbMnblecLzxNxSl0ep39kaFycH7HGkR95hOzG23dUJKW7EtyLMXjRqz6J4UZ4CM6+ZmHlxWQNca+CVJUkYRIPNBWbpTfPysUoKuriw1GV9LCQCP3PJkg13qmJi93fTXaiQMhcbL19aXcXAQuLFaBaXsy4dQzUtswQk8rg3DtwEsIZU/D1baFhI0QaIUtavCsFe7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itc1QvToGoe+J9d2UwWhwo8C6yFjsoavWAQJrBR4Q0w=;
 b=L8/iQUN9XJDJxqy0y0fKm4b/yEDkc2SYynhTTYsYjIStSBxf63Xe3c0PLoWLATV6mWjQcUaDvUoc2P+KPlQAD2tnuaBZMR59OPFFhLyN69oTMHBHzTIfprvrRCi7m6FQhl11JaqUI0HleIqmGNnyOAOnA0EIiPLIdZDt5LluvJs=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 12:13:50 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::69) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 12:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 12:13:50 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 06:13:44 -0600
From: Nikunj A Dadhania <nikunj@amd.com>
To: "Pratik R. Sampat" <prsampat@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <michael.roth@amd.com>, <sraithal@amd.com>,
	<prsampat@amd.com>
Subject: Re: [PATCH v5 3/9] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
In-Reply-To: <20250123220100.339867-4-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
 <20250123220100.339867-4-prsampat@amd.com>
Date: Tue, 28 Jan 2025 12:13:41 +0000
Message-ID: <85ikpzm8zu.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1c99fe-3882-42e7-1ada-08dd3f953977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Due0T+XMAiE6VvkKmehubJOYtImITBnmz2Dq4nPBsTVPOWshAA2F2tUw6OfG?=
 =?us-ascii?Q?A5dKYQYdo66GjQc/A1nghZQx8gC9xgYwdJDgakWqa2NI5luBtfi0Sry45JtV?=
 =?us-ascii?Q?gUvcfQu/lBnn3HG8P/vs+cJw9t2zcxgeYyHGbC8KWeOZdYTIAA67gJdR1va7?=
 =?us-ascii?Q?6n5rHSby5rtwlsVR1BB+P7BrTjl/09J+jLWdX1iSS2Ldih1tkgb+qGXZJOlB?=
 =?us-ascii?Q?m6th55YFO4LBYlE7ZtwdXe+SAfERnMi1N9lEalYGFXPMroDQqPkem3FAhggL?=
 =?us-ascii?Q?t2Z5GZDzzqKitrVm4nlxd+xWg6qI8NfculI+tuG8BUp5VcLW5X80AtNJb9rY?=
 =?us-ascii?Q?/y5z7txOOyLrJ2ITFEsfIt2beaS+mNiehnrc50AxrU/qnzoZ3jSxZNn+Ezxy?=
 =?us-ascii?Q?+ufAvkIouqMACmYEgpfXQoXPVX54OchUwwO3CDBq0VSS0jdb/6B4V9y3uQ4y?=
 =?us-ascii?Q?uDNedezomU59uD5GpnbVA5FIVwRfXMMYfiwTV9KrTsV1c6ecOnSaBw2R96Lq?=
 =?us-ascii?Q?oXZ1bUFXfmCwlzJMC+YNw+znxmHIh2iY+m3Z1qeSccEFrOtuKcG3MiIDBoCX?=
 =?us-ascii?Q?vCTyGL1LJ+scFFg+KIHgYD/RoLyuOUKFAAC796i9cceAQfk5FfEPF7eSRTVz?=
 =?us-ascii?Q?+PlbE4Ozwpdd7rBio3OSoV5J73xXsIIrTGCysQ5Rqpt99xFIyAycEl7PZjbD?=
 =?us-ascii?Q?mwqhjgwM3P+ZQJRUbKW4tPCWXJO98YQis2vNsI+PklVCS+D1F26FhUME0Af/?=
 =?us-ascii?Q?Z01uLbhe4tlW2eMVIKgQ0kytbYqNLh2Ondlr/1GA4vWjTAFmODsH4mNFn5sS?=
 =?us-ascii?Q?vcRwWJ0FUnRWCesECfX25DKlXXLOC06HJKz+FrloAO1I8tfTZvgeohhPqKf0?=
 =?us-ascii?Q?2Qs/XwYyA2G6BSj3puH04nSdhWA2VOGQbq2rI9bhG/lLe5Z8R87wovoPWe0h?=
 =?us-ascii?Q?BdlXGlS4YgYjZl2U3Hk6FBxPFQidmUX0AFVuYXxYr1Wfglx3rLDEHYytSqGO?=
 =?us-ascii?Q?4lUhOTClo/jh92dyzk1PRUeDICVAaxzuyLFBhC87e7cSIX+1GcZ+gglWdnBj?=
 =?us-ascii?Q?xvLeTgTdy20YjzT+Wwqx+ubYHaDNd8bF2XVWX/tL7JAsE/zXWfyMg0y4HURK?=
 =?us-ascii?Q?4mZqVDf3wKMFBvQ6zJI0nj+yDVtkz0tgLCM3mqVq6tEO21c7xDyfk/nuEWDk?=
 =?us-ascii?Q?6q9bxssKFdstRA0zUzE+0mbLUrRTMIL4lq7J8ULTcXbH2/xMzGT6Z4TABAKK?=
 =?us-ascii?Q?CM2vLcBQEkG7tHxjwMhW59LcV/a3H/CLPRmc4WbB0WQsUEfeHD/s6ak5nBph?=
 =?us-ascii?Q?Aw7+gMboxvQvSEZ2jHkE8CB8n2dPnCZxQ63cazuKCZlNXDGr/iHybmSI+8qH?=
 =?us-ascii?Q?Dpmi5oHS8mR4gDV5DxZdFASYOHzNVgEgsgDOTr6VDOKzNc3polS1WBpwNpo+?=
 =?us-ascii?Q?xM7cn2uc1IpVGz0lJ3hWipmYaJrGhhfH7ybWjWYCaE6ywRbf0LJDvbDMeryl?=
 =?us-ascii?Q?EG123Hvzo4T0BAc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 12:13:50.2168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c99fe-3882-42e7-1ada-08dd3f953977
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

"Pratik R. Sampat" <prsampat@amd.com> writes:

> Add the X86_FEATURE_SNP CPU feature to the architectural definition for
> the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
> SNP test is skipped in scenarios where CPUID supports it but KVM does
> not, preventing reporting of failure in such cases.
>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

With a minor nit below:

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  tools/testing/selftests/kvm/include/x86/processor.h |  1 +
>  tools/testing/selftests/kvm/x86/sev_init2_tests.c   | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index d60da8966772..1e05e610bb06 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
> +#define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)

Can we keep the naming same as in cpufeatures.h: X86_FEATURE_SEV_SNP ?

Regards
Nikunj

>
>  /*
>   * KVM defined paravirt features.
> diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> index 3fb967f40c6a..3f8fb2cc3431 100644
> --- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> +++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> @@ -28,6 +28,7 @@
>  int kvm_fd;
>  u64 supported_vmsa_features;
>  bool have_sev_es;
> +bool have_snp;
>  
>  static int __sev_ioctl(int vm_fd, int cmd_id, void *data)
>  {
> @@ -83,6 +84,9 @@ void test_vm_types(void)
>  	if (have_sev_es)
>  		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
>  
> +	if (have_snp)
> +		test_init2(KVM_X86_SNP_VM, &(struct kvm_sev_init){});
> +
>  	test_init2_invalid(0, &(struct kvm_sev_init){},
>  			   "VM type is KVM_X86_DEFAULT_VM");
>  	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
> @@ -138,15 +142,24 @@ int main(int argc, char *argv[])
>  		    "sev-es: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
>  		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_ES_VM);
>  
> +	have_snp = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM);
> +	TEST_ASSERT(!have_snp || kvm_cpu_has(X86_FEATURE_SNP),
> +		    "sev-snp: KVM_CAP_VM_TYPES (%x) indicates SNP support (bit %d), but CPUID does not",
> +		    kvm_check_cap(KVM_CAP_VM_TYPES), KVM_X86_SNP_VM);
> +
>  	test_vm_types();
>  
>  	test_flags(KVM_X86_SEV_VM);
>  	if (have_sev_es)
>  		test_flags(KVM_X86_SEV_ES_VM);
> +	if (have_snp)
> +		test_flags(KVM_X86_SNP_VM);
>  
>  	test_features(KVM_X86_SEV_VM, 0);
>  	if (have_sev_es)
>  		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features);
> +	if (have_snp)
> +		test_features(KVM_X86_SNP_VM, supported_vmsa_features);
>  
>  	return 0;
>  }
> -- 
> 2.43.0

