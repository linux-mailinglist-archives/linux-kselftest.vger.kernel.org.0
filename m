Return-Path: <linux-kselftest+bounces-25271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1247A20433
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 07:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852D21886B55
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9D150997;
	Tue, 28 Jan 2025 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PxwwtGdi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46B291E;
	Tue, 28 Jan 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738044184; cv=fail; b=eBOKrI23zzKlFCvZOBsI1OkgvlH6+dXeSfLZVj/KEgZnF7I3hhzqh7GLw6mnxmbI4QKSZ+dyFcn9EmYI4Vx0FRlsEQwGdEMhGLD71OaVL6X85JLlrHOfM6KAR9I7v+0F3xr1/MqAIt0sM/aOUWYKsQTHbRJhcom3FkhlFbyBtB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738044184; c=relaxed/simple;
	bh=a4EPT6jVXHH2zu//rB8XoS/KGz6t8ygZXpjPvKnoYGQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/gvARfFdfn4WRJoi8J0YR7MIe/W8mQkrZxCySewx08ulAwpJ39NfLailG/skMhIfpNYEh4yj2Qfc1tpkHluCN2zXtRDnYooMFhZ154CYMyVViC1KRpPdBZmWn7q6b5BqXZ65RXlOi7G+U+lmdnMyAS2oImtAV61wh929+2iMjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PxwwtGdi; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8f0SFkBt5Q5/kWDhFihuSPIiKdG5KgVj4LUxbWaWSXaerUeArCGe4vSgJyO4rMjm3VxhnY1a5rFpbsQOosepTyMM+vwMb0134LJl+A3nflF8jbBrtxPHdpYU54IsWqWMyMTMyp/YRmvrx87tYv/VQz5UotH02S8emwdaWpGcFT6eEVKKKyqSaCnelqaxNvgDhpsmYsR3JknVvcD0bgDzCIqFsxdCHG+RU317Uzw/U38+RVYX3eKon1tXfR+1pMKt8+4XajcdT3aGdEgbfuid99DQaYZdu5vB+NDxE80O+tdjFV1gkiPkLNayKcd9yrzr7nsBSTIaAl10aYElgZHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9zpkBNPsrQnhRZuWwMf7HwGrtH6RRqYoep6RfDsEbg=;
 b=KM88btNSkzy0hT7nUNt+/AGy1QEWTkTxMktV1xJvEFiqXqMI93StZ8Dzhig3jNCGUrc9sM2GFU5M/xdejdPu5MPQ11+xSNL7FleWecPdQSVptqKUyJU00+2D/BAuNaT5ubgmAvO9NiFXmQHhOivdid63duypHjYMMnhDOj9fPKRw/emdcvwc/nwFKhABDUhSPsqWfU4jsOTBBaVudhtQjdyno7es7BiXtD5BE9cMBlxGXG2De1lhj5z3GvWwEIE6+qrekMCD+EG1si8dYxPopfwu3DI29umRR4fcFgMYYhWdHFh2GNSD78j2JYWbo1vWucE8jRbMO6y0Z9aaWPnHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9zpkBNPsrQnhRZuWwMf7HwGrtH6RRqYoep6RfDsEbg=;
 b=PxwwtGdiLBLCHwpNgSStTuHGZEDcuXbxk+BUWh4XdIuB3f8ozksm5ta2WD5+LoCQ/9k1x7Nvij9kAxNEfIGDq7uMWUvlPChPbQY88ULlNiH/Z4zOjezLo5olj8QjwRY1UFnWE/Xv4xpMYusvpwsP+nB0vm3K68k1Vl7ao1P+Loc=
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 06:02:58 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::d6) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 06:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 06:02:57 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 00:02:15 -0600
From: Nikunj A Dadhania <nikunj@amd.com>
To: Manali Shukla <manali.shukla@amd.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<thomas.lendacky@amd.com>, <vkuznets@redhat.com>, <manali.shukla@amd.com>,
	<bp@alien8.de>, <babu.moger@amd.com>
Subject: Re: [PATCH v5 2/3] KVM: SVM: Add Idle HLT intercept support
In-Reply-To: <20250103081828.7060-3-manali.shukla@amd.com>
References: <20250103081828.7060-1-manali.shukla@amd.com>
 <20250103081828.7060-3-manali.shukla@amd.com>
Date: Tue, 28 Jan 2025 06:02:13 +0000
Message-ID: <855xlzwk62.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: b92e6948-321e-4458-aed7-08dd3f6169f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0VnOVR4eEdNMllSdk5SeEY0TnUwNUNqL2JlMXZNTUpVZWgrRGNDMzVYandh?=
 =?utf-8?B?ZFN1QjdMdDVrVlEzc2VSQSthRk84UE1NYWpEWVppeG0zTVJjN3JnejR3L0pU?=
 =?utf-8?B?dUVBdXhNekRmOWR3WWlGQU5qSXZUcDZEcnhCdE9nY2JhUkpSaVhWWG1IMUJB?=
 =?utf-8?B?RFRBamhOaVFhdHFxQnh2WEpDTlhIUzBmRjNkdzRHZmdQaVQ3eExuWktKaSt1?=
 =?utf-8?B?V2tnN0tobWZpdytxMkdIOUFNSm54WG1PUVpyZUNvWnptOUlnUUVOYVl3aUJu?=
 =?utf-8?B?UlZ0SnRiVHpjU1RScE8zeDBJdllCQ2tXZDh2OGZYZEpxWDlLMnVWUG1jL3pT?=
 =?utf-8?B?S3dCWUxKNDNRR2wydEFxUkRmRjc4dzZrUG5jMXAzMHhDek55NEx2U2J4UEVI?=
 =?utf-8?B?RGZXMmxWUU5vVVlVTjdOVGxCL3pMT0ZtN3JvRGhzY0Z5Sy9WajNENW1SMm8v?=
 =?utf-8?B?dDBCRXp1bmc4Q2lXODhVc1RtVGdTV3grOUdTcVRJVDlteXZVbUozNkhQRS91?=
 =?utf-8?B?OEVKeGxvTW1rNS93YzRRMmFaeFpIMzV3a25KdVRKNUhhbFROa3dpRmZkOTlE?=
 =?utf-8?B?OTlQYXdmN0V1UjZWR09iS1IzajJjVE5WeHV1MThZbFRCVXZZLzd2ZiswREpF?=
 =?utf-8?B?R3YvMTA0UHZ2ck93UnhpK004S2w4THI4NnU3V0ludzNyYU8zWUgwQVNRVkpL?=
 =?utf-8?B?WWFFeDh0K0U5cElEZ29wNlNWT3JLRkY1eHVpaGdvdDRGYjVqTStiM0x6aC9F?=
 =?utf-8?B?MFltQnNLM0NzWVpYT2N5Tk55OVh3MVRKWVhwSnl2eGltTDNWTGU3Zmw1RURr?=
 =?utf-8?B?QnppWm9uY0ZpOWlNR2RZQkNQSmN3TVovWjhwUzN1RlJnbloxeGJtZVpVZkFK?=
 =?utf-8?B?bXAyUnUvMHpuK21INTdpTTFwYXVxck0yeitjSFk3RWlFZjdPVjA4ZFUrZGhz?=
 =?utf-8?B?Y1JEb0VoK1NaeFRNakxMcUhwVlV5MHlpcFgxTmdya3VQdkdiWlZQSjdNNHVw?=
 =?utf-8?B?OWlieDQ1QlI1NEVlL2RTcW83L09tM0R6WFhEMEpBcndnVHFEZHlVK0dWUTVi?=
 =?utf-8?B?ajh5YWRUV3BOdHJPczJEci9qL2MvUTRwRG81cGxQL1BTb1B0V2lrQXd2dkd4?=
 =?utf-8?B?Rk84QlM1TkVnZFBkSFVsSUJJWjRYdXI1ejJIRTZVb21FR2hiODBoS1Z2RnNT?=
 =?utf-8?B?bHZMZkZUdFhPWWk3aXN4eVNxTDNaNWcrVkdBRTlKQWszUkpBN0NocUh0T1VC?=
 =?utf-8?B?T2FyTlpIdDF5N1JBa2llY1BFUkFnY09mNUdEMEJmU2VvUUpJQjVMZXI2ZXN2?=
 =?utf-8?B?MGQydWNyU1RiazZFaFliT1c5bWdzMllSbkRhd2hJZTQ2Tmp2bGdzdXVSODlx?=
 =?utf-8?B?bWhYd20rZENIZjlqK1B6aGdUV3Qva2lkOEorSlVmY2tLZzVxMTV0cVpGR0RI?=
 =?utf-8?B?SURJZjNMSVpPQnJmMEZhTEorTExNUWt2TVVnZHAyVE5QQ1AzMHFkVmxFSnEx?=
 =?utf-8?B?NGVzYjFGS0hkc293YVFxQkVNbUpXOWRjNDgvZDg3QU4rQzYrV0VRMSt2ellx?=
 =?utf-8?B?TXg5bWV0RGpWNGUrYVB5R2h2SFRhbXhDWENRQ3hZU1BHNDBvZ1dPUDQ3UDUy?=
 =?utf-8?B?My9lb01uemJyZFgvYTVLeE1SWHFnYmV2VXVXV3hYMnF6ejRaUkdJbUFKTnFm?=
 =?utf-8?B?Ri9McE1za0pVMld6NFJVQlV3MURYTVgvemhmYldUUm5LV2I5eCtVZElQNThW?=
 =?utf-8?B?c0tBVkRlVlc5UFVVdGxJN0xJSzNZcVJXWURBbmwxbnUwRXo0dG0wTzlMQzJs?=
 =?utf-8?B?dVlrSEhTQ1VhUTZwUGFnZUNZNWozcEh6MEVrMnRUK09CRjBTM0l3OXhNc2dV?=
 =?utf-8?B?RUNIUHptVS9XeEFzTHI0cng1aHI2WVJCQXJMWVBnL2dzQWd1YXdHWlhMYk9a?=
 =?utf-8?Q?Nvy6GKhzHtk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:02:57.8136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92e6948-321e-4458-aed7-08dd3f6169f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

Manali Shukla <manali.shukla@amd.com> writes:

> From: Manali Shukla <Manali.Shukla@amd.com>
>
> The hypervisor can intercept the HLT instruction by setting the
> HLT-Intercept Bit in VMCB, causing a VMEXIT. This can be wasteful if
> there are pending V_INTR and V_NMI events, as the hypervisor must then
> initiate a VMRUN to handle them.
>
> If the HLT-Intercept Bit is cleared and the vCPU executes HLT while
> there are pending V_INTR and V_NMI events, the hypervisor won=E2=80=99t d=
etect
> them, potentially causing indefinite suspension of the vCPU. This poses
> a problem for enlightened guests who  wish to securely handle the
> events.
>
> For Secure AVIC scenarios, if a guest does a HLT while an interrupt is
> pending (in IRR), the hypervisor does not have a way to figure out
> whether the guest needs to be re-entered, as it cannot read the guest
> backing page.  The Idle HLT intercept feature allows the hypervisor to
> intercept HLT execution only if there are no pending V_INTR and V_NMI
> events.
>
> There are two use cases for the Idle HLT intercept feature:
> - Secure VMs that wish to handle pending events securely without exiting
>   to the hypervisor on HLT (Secure AVIC).
> - Optimization for all the VMs to avoid a wasteful VMEXIT during HLT
>   when there are pending events.
>
> On discovering the Idle HLT Intercept, the KVM hypervisor,
> Sets the Idle HLT Intercept bit (bit (6), offset 0x14h) in the VMCB.
> When the Idle HLT Intercept bit is set, HLT Intercept bit (bit (0),
> offset 0xFh) should be cleared.
>
> Before entering the HLT state, the HLT instruction performs checks in
> following order:
> - The HLT intercept check, if set, it unconditionally triggers
>   SVM_EXIT_HLT (0x78).
> - The Idle HLT intercept check, if set and there are no pending V_INTR
>   or V_NMI events, triggers SVM_EXIT_IDLE_HLT (0xA6).
>
> Details about the Idle HLT intercept feature can be found in AMD APM [1].
>
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April
>      2024, Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>      https://bugzilla.kernel.org/attachment.cgi?id=3D306250
>
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>

LGTM

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/include/asm/svm.h      |  1 +
>  arch/x86/include/uapi/asm/svm.h |  2 ++
>  arch/x86/kvm/svm/svm.c          | 13 ++++++++++---
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 2b59b9951c90..992050cb83d0 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -116,6 +116,7 @@ enum {
>  	INTERCEPT_INVPCID,
>  	INTERCEPT_MCOMMIT,
>  	INTERCEPT_TLBSYNC,
> +	INTERCEPT_IDLE_HLT =3D 166,
>  };
>=20=20
>=20=20
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/=
svm.h
> index 1814b413fd57..ec1321248dac 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -95,6 +95,7 @@
>  #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
>  #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
>  #define SVM_EXIT_INVPCID       0x0a2
> +#define SVM_EXIT_IDLE_HLT      0x0a6
>  #define SVM_EXIT_NPF           0x400
>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
> @@ -224,6 +225,7 @@
>  	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
>  	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
>  	{ SVM_EXIT_INVPCID,     "invpcid" }, \
> +	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
>  	{ SVM_EXIT_NPF,         "npf" }, \
>  	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
>  	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 78daedf6697b..36f307e71d5d 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1296,8 +1296,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>  		svm_set_intercept(svm, INTERCEPT_MWAIT);
>  	}
>=20=20
> -	if (!kvm_hlt_in_guest(vcpu->kvm))
> -		svm_set_intercept(svm, INTERCEPT_HLT);
> +	if (!kvm_hlt_in_guest(vcpu->kvm)) {
> +		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
> +			svm_set_intercept(svm, INTERCEPT_IDLE_HLT);
> +		else
> +			svm_set_intercept(svm, INTERCEPT_HLT);
> +	}
>=20=20
>  	control->iopm_base_pa =3D iopm_base;
>  	control->msrpm_base_pa =3D __sme_set(__pa(svm->msrpm));
> @@ -3341,6 +3345,7 @@ static int (*const svm_exit_handlers[])(struct kvm_=
vcpu *vcpu) =3D {
>  	[SVM_EXIT_CR4_WRITE_TRAP]		=3D cr_trap,
>  	[SVM_EXIT_CR8_WRITE_TRAP]		=3D cr_trap,
>  	[SVM_EXIT_INVPCID]                      =3D invpcid_interception,
> +	[SVM_EXIT_IDLE_HLT]			=3D kvm_emulate_halt,
>  	[SVM_EXIT_NPF]				=3D npf_interception,
>  	[SVM_EXIT_RSM]                          =3D rsm_interception,
>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		=3D avic_incomplete_ipi_interception,
> @@ -3503,7 +3508,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, =
u64 exit_code)
>  		return interrupt_window_interception(vcpu);
>  	else if (exit_code =3D=3D SVM_EXIT_INTR)
>  		return intr_interception(vcpu);
> -	else if (exit_code =3D=3D SVM_EXIT_HLT)
> +	else if (exit_code =3D=3D SVM_EXIT_HLT || exit_code =3D=3D SVM_EXIT_IDL=
E_HLT)
>  		return kvm_emulate_halt(vcpu);
>  	else if (exit_code =3D=3D SVM_EXIT_NPF)
>  		return npf_interception(vcpu);
> @@ -5224,6 +5229,8 @@ static __init void svm_set_cpu_caps(void)
>  		if (vnmi)
>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>=20=20
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
> +
>  		/* Nested VM can receive #VMEXIT instead of triggering #GP */
>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>  	}
> --=20
> 2.34.1

