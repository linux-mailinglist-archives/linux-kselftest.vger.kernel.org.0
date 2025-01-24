Return-Path: <linux-kselftest+bounces-25081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA00A1B33E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C85164F18
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48E207A04;
	Fri, 24 Jan 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yGvlBlXU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5401B87C3;
	Fri, 24 Jan 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713025; cv=fail; b=Kk0Q7X/B6kvauUcdtWZBleKizcy2Uv+s6Bd3DinaeF10D9C3uliAUIfZXmLFM2aLKxSJgl46iQZ+s/mFjRC50yIPkQL2I8loOxMwL3jPbjVGzsYjwksfYYnn6mXmT7ueCScfWGEyH6l5SCh9KITcLAgLoI/pZQgPdF+OZBhKwqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713025; c=relaxed/simple;
	bh=hKeHTBts3hxY9vFA5pZekxnyu1EaJ9fAHd9KqrQ27Xs=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuIsHRJxKY7M9+URkHp9pm00DKqUvA0R8Wp+U/xy8Erkp875d1Yn+PHhoxOAIkAUJWIaMRrURIBHPfaZeIiu+H96lG0mhRFSu0Dwam9UNTpGwpRSMDvAfBdifwhMtw9kdxI4JVnimFmC3F3GN4GRGDcpotPmt7k2M4SlFyLWkBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yGvlBlXU; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/xy2zA8PZtabILWLj1jqcbNUUNXXd0JsWc8qS6ymP+jMie/2QB7ig8SfmYVMaj/QkfHBIK6/4lSBoMFrLjpAGV+D7DVqMuDrHWYqaGzPeXhLTCzcJRwsTPPjy3Cew6NUo6QZwWx/dJwGA0TTU3pU7Q3b2PbPDCx+vSHoAurIQG7L90/PKVxjio/YNRuW69Af3d9cN4G0IqYmm1DrvSlmTaNw56KovHRK/pGG+Sj+19kcH4I4MiLii7gWQ3mnQGDI3aVJ91Vo/zL+TZ6rox8PS/Eua3letviBh5F5SgaG6yCMcFFrHv1ZGkNOwi/3okWfK20BPbrxd9NUBUZHb0wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfx5c3nI4SerKtS+AP6aljq58CbYnC4tsg9nzdST0W0=;
 b=ld6uTAOepCY/d0noc7ZK1dh8tHNvG90UNlK3/MjSNAbLSUnEEYjrH/xiPYyvpF5OMYn7gWc7IRhiE31NquAX4axgXQ7vZLonjGadqlA84Q9XvmdRK13zjnIigAPM0SauYZ6AhvN7+TLcaxTy6Q4q0bg+/xp2kSVTHf8NOr5Lp1X5wLs/FTr6Z5mKkat5wbNyF7oGDUGJf1lodzmVnG/i20YuGfmZoBfflsrfT2PvpmmlBjhbd4SaA4//PgpzF1FhMasLPhaQP+vBrdLUfYlCX8ThYtHFrx2eXBAg4Y41gh3qoaP4+k+o8Yn9+I/YbWR6pIkjDo82uSzHYrla+OnwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfx5c3nI4SerKtS+AP6aljq58CbYnC4tsg9nzdST0W0=;
 b=yGvlBlXUySZqmMNXW5j1v1pJnRw1jE8E9D+fM4kujUOWeeAt45wKtleZenoMGju6EfKpvap49ofTnONtZ3E4Ll1d58P2N5OTQ4lZw2IeN6wu+pNklUrAx8WYPYdtdurwdikMMmyqFt7zIu+4iPjIGba7SJNKkWe3LK3CptWFAZQ=
Received: from BY3PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:39a::10)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 10:03:40 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::41) by BY3PR03CA0005.outlook.office365.com
 (2603:10b6:a03:39a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Fri,
 24 Jan 2025 10:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 10:03:40 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 04:03:34 -0600
From: Nikunj A Dadhania <nikunj@amd.com>
To: "Pratik R. Sampat" <prsampat@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <michael.roth@amd.com>, <sraithal@amd.com>,
	<prsampat@amd.com>
Subject: Re: [PATCH v5 1/9] KVM: SEV: Disable SEV-SNP on FW validation failure
In-Reply-To: <20250123220100.339867-2-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
 <20250123220100.339867-2-prsampat@amd.com>
Date: Fri, 24 Jan 2025 10:03:26 +0000
Message-ID: <85ikq4msup.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: daecd36f-dbe3-4e67-58a3-08dd3c5e60ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Id2UWeEkcCqZRmfxLKR0nWFlstj30keOW8nOT3032BkvrKZlBtNEdjOL6MR2?=
 =?us-ascii?Q?bMEeXRI2k2zzl0gxK7xj2n6uGZHHWRcmOFafUfJR+bI9vIlOh5SFMMjp4shw?=
 =?us-ascii?Q?/g9ax+FEkLGoDZQ/j00OzyXMi/mX4Wm8puOlARjspfzUXUNQ9X9HZHkd68Fn?=
 =?us-ascii?Q?6ll9cLnWOazz3okQDVNTOwQaX8zQ1NPF1RmUjYePdnXqOq5I4R8HRTVpRHLm?=
 =?us-ascii?Q?CFEuH1g7+3Wg/Sum7HymDxPfLtG0RiV3r77oLpgiZvbTKrY0iTQRv9MbXdB6?=
 =?us-ascii?Q?xTzfeWYLQYd/ECEzyfoAf5sBe9UrG23tNKBxwvmBOh52dLalMdnnuvaETFsK?=
 =?us-ascii?Q?9hZdHd+eKatBEp4sMj50IamDJRHvmEmewIj0HFsPeeLpBGd4hdf8Ctz8ZPu8?=
 =?us-ascii?Q?Y3E4f2BxcdEcTneQfgTrJJr8y9Cny/lrfSQvY4yT3qsG7mBAQWY7GP2a7+Uq?=
 =?us-ascii?Q?UyYBxEc2/d6/ALrJXPBgTR4vBJ2b65Oqpj+RX0ChabYAPlma6gUMOwGR0RPh?=
 =?us-ascii?Q?+kE95IoaD6ZVkiAn6cT54CpgrTLeExJo/MH13VUd7ashtrpnG+X8vhH+/Yfl?=
 =?us-ascii?Q?DgYXOt1fTaEQCujT92cUTA3BUEsGc28oFX3OCUWgcJR7RMdrLBYla/jPNGg8?=
 =?us-ascii?Q?kyECsVma8+KCHVTm1GlNMhnd+cABo52x5RmRxHwr1MH3WRshRep6NM1gqlM5?=
 =?us-ascii?Q?7a8i/d0KnNZsn/Y2mFUjGRwFQvAFJ05+/JF1c9GPO1VFTQZwAxgy7Fqr4gZu?=
 =?us-ascii?Q?GxMbtM+ynLkCmKH7ZEbk3qjpshQaoxKuopxFnP+en++MeZzkvgrCMtCmAhP6?=
 =?us-ascii?Q?1DXFjk2MdK9SDs6vxeKkCTUlxrRAxhF7qAxMPCBL+uBDFu6wc5rZniADrAfs?=
 =?us-ascii?Q?TuZ9+rmp+75GMIrksg23jLYHGmbcRqAV0KOK/CPArL6obxrr6uzYaZ6cVqrI?=
 =?us-ascii?Q?KHD4ObrGdUGiYGMnZh8kPnwGZLP6letfI7+R7EF/vtSXPajMQQCKogQaek+i?=
 =?us-ascii?Q?4emAZrLWvR8SQK01vYNTYwkHb7PrWyEBTEOysED+boGC4F1MsC+XsrAEGVKP?=
 =?us-ascii?Q?20fu0H3+UQiHVsKwFwdr+d0J0lCGZ4Utv4xcxoMREvjHEiDz5L5DlMJ54WEE?=
 =?us-ascii?Q?ECfI1K/amuhGx+rgXVZqwbAdu5F1ov+76RUQNEnAE6dZd/X3ztN4abzm4/7v?=
 =?us-ascii?Q?5yTrNRyNdtiS+ZrD3ER/CiBVDWSt/+bqPo3iV38KnrMvGSNTB4EkAYOE4LLX?=
 =?us-ascii?Q?r5DxZinU5DwGRsNAe/5/iJ/ByK/5qbazwlXD5Je9WP5ow2LrE+Wbl1uqN+in?=
 =?us-ascii?Q?vrdwKyLSCBEbaWJV1sJ0yqV6TA4/YcYnY2eNvVj6djpveX44zAFKdwASmPgQ?=
 =?us-ascii?Q?P2EBP3oihd8XGR1Bf/u+3s0i4Eq1EyEmtWXDdfGiulTJVVWAXpVgwUaAcYeh?=
 =?us-ascii?Q?v9/UMv3iR+xbZHrZJlbTm4sBiMzSw9qhrgnt2sTCryjzhe32NXhfUjG1LPZT?=
 =?us-ascii?Q?i/isLgucL9jduAo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 10:03:40.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daecd36f-dbe3-4e67-58a3-08dd3c5e60ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

"Pratik R. Sampat" <prsampat@amd.com> writes:

> On incompatible firmware versions, SEV-SNP support is pulled and the
> setup is not performed. However, the platform and subsequently the KVM
> capability may continue to advertise support for it. Disable support for
> SEV-SNP if the FW version validation fails.
>
> Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/kvm/svm/sev.c       | 4 +++-
>  drivers/crypto/ccp/sev-dev.c | 6 ++++++
>  include/linux/psp-sev.h      | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0f04f365885c..b709c2f0945c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3040,7 +3040,9 @@ void __init sev_hardware_setup(void)
>  	sev_es_asid_count = min_sev_asid - 1;
>  	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
>  	sev_es_supported = true;
> -	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +	sev_snp_supported = (sev_snp_enabled &&
> +			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
> +			    snp_fw_valid());
>  
>  out:
>  	if (boot_cpu_has(X86_FEATURE_SEV))
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index af018afd9cd7..b45cd60c19b0 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -122,6 +122,12 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>  	return false;
>  }
>  
> +bool snp_fw_valid(void)
> +{
> +	return sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
> +}
> +EXPORT_SYMBOL_GPL(snp_fw_valid);
> +
>  static void sev_irq_handler(int irq, void *data, unsigned int status)
>  {
>  	struct sev_device *sev = data;
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index 903ddfea8585..e841a8fbbb15 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -945,6 +945,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
>  void *psp_copy_user_blob(u64 uaddr, u32 len);
>  void *snp_alloc_firmware_page(gfp_t mask);
>  void snp_free_firmware_page(void *addr);
> +bool snp_fw_valid(void);
>  
>  #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
>  
> @@ -979,6 +980,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
>  
>  static inline void snp_free_firmware_page(void *addr) { }
>  
> +static inline bool snp_fw_valid(void) { return false; }
> +
>  #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
>  
>  #endif	/* __PSP_SEV_H__ */
> -- 
> 2.43.0

