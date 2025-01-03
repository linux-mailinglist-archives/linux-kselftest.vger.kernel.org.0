Return-Path: <linux-kselftest+bounces-23850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E982A005A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BA71883B5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8541CDFAC;
	Fri,  3 Jan 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fDVYiv2w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AE1C5F38;
	Fri,  3 Jan 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892336; cv=fail; b=SQscFXZBjKa3SZY1nnfvTT4jCt4RiXbb8/Wj7q/x9e8hTyXgvumE9uU/rmRI6nUyqW1+QT4z2AjJ8ObL4Z8vULcVPCTykFc8vZOs+Cj20eNxr0iJku1GbSlUuDDtT7K/7Y9GDWr27O0SerkHcB6nTOYSDKzoT4w34mo27y4oXUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892336; c=relaxed/simple;
	bh=OluUnzRJIt9HxfvzNQ2E+b4trgLt4WEmEmw08MGotVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gan5m42BBfL+Y+F7RbPc00WgaQapO0rAwz55oGgkK3Z3TnMQsL9gmnbYY9FtZVM++o/sQQ/9t8lAdCWT670zJ2myF/HaoHDm7LNRDamClHhzB0NC/4wrH8h1L/KaQydKzc0eyBBNf+EyKXI0GmLjh0DN/uq/6F8B2AKwYEV8/lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fDVYiv2w; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+ySbTszCtfNQXE1j6ou5M4Z0/clIDCwf/qqj3eHydjliQiTvJ8JMrSu33RYXeekVNg1DRUvBlHDUOimqOG1IA/IPdaI08oHJGkpltwRiU0dGh+vzsbtBnj5QqZNezDeRSVA4EwIikTX27FnZ11S+jOvHlNQipOgXUPAnhv7EobbXhK+6HXdBKrUKCXKiH8OD8Q4ptvqoh53U1bM99lIuizE+eY1HGoNXRlwI55Bh+Gy15nwX/pvgpdd6H9d06sL4/T4kKjhTPqSanFqAq+imlNN5uL1oKdtzJnnD3dx67Gn1NH8r3Zc5ziOg87oN4QtbKvthSRoz2tU0/qxiNPKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auOWSh9x6pE0Kir9tlEna/TO7Bk3zjU2GgWIEfQjFmE=;
 b=LUIUvqHdbJqg3KYSXBO45oMROG/Dz4HiFU9ypyDi/gB5j0pHiXvF8QU/iCnNQ6HuqUXlVDSQonrc1PQ78xj+AJ45fZNSDA9wURoD4ABhdQ0+wNdxs8ux3vKrE+X/O0AsID7CXptoVAWvytqIV3RoUo2tbESay+lPieo5fYuujIi1D7uwLwSv5QlsZ9J6KxGnXVNA3GBephgW3V8n5GcxtHRxb3eHWZP1xUH9be6B+D5Hf4J/x+0Y6GJLC3NquBBCL5lySU+0WSFo7JJ/QvaiWZT+L5nlgGw7WwsmPSUTlrY9H9w1ZwEJ1G0tF9EYnOqtnsLAKX1lt2Nv7fukc7bOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auOWSh9x6pE0Kir9tlEna/TO7Bk3zjU2GgWIEfQjFmE=;
 b=fDVYiv2wr/idv/qa9aBrvOXc0+jAWccJiXxgVPFnl8CkXFsWhOTvXec/Akj3s3qplSeR7Kczi+oTkB0+VNRfQyyfuM4RZOqakb7TyUQkDppioiyNtDK6vZIncDxz8awMjxd+uh5M+DQJsUXXPquOdJF6CaFB95q+4bbQLKFA9gs=
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 08:18:46 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::1a) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 08:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 08:18:45 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Jan
 2025 02:18:44 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v5 2/3] KVM: SVM: Add Idle HLT intercept support
Date: Fri, 3 Jan 2025 08:18:27 +0000
Message-ID: <20250103081828.7060-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103081828.7060-1-manali.shukla@amd.com>
References: <20250103081828.7060-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 483e5510-c37c-45d8-abd0-08dd2bcf3e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXRpZlpnaFc1NHNXNFJjdVdKaUprd1Y4ZE80VW1FQVJJdm5rQys1RXV0SzRX?=
 =?utf-8?B?NThpRlkwcWNhakRmVGUwNHRqeXBTK041cW5mN3ZhUW1lK1lQeEZ4dzdoa01X?=
 =?utf-8?B?WnZyNEszMWxSTHZyK3U0RVVRbjloSmpEbmNSMkFYSE9ON3d6MzlXdVNLdDIz?=
 =?utf-8?B?MFRuRXR1Yk9PdnRSZXV6QWcvVTBBTW5hdEt4WmpUZ2NqMHZzUUtLR3lRWEJY?=
 =?utf-8?B?cjBPT0tEaC9kMXFaOUpCMnA3YUwrZWppbENuU3ozNWpMNmFwUWt0bWJZMEo1?=
 =?utf-8?B?ZzBWK2cvNjhDZ0lNeE80OU9MMkQvN0p4UmtaajQ2V2FKZyt0c0t1UjRqd0hP?=
 =?utf-8?B?R1VuUlVlVThaQzJUYkM4Z0VUMjlJbFN6clNsRSthK2JYWjJWWVE2T3dWRjZ1?=
 =?utf-8?B?Y25hU3U5RWIzUmdIejBIQWdpcS9NNVlqUmR6T1NhZSs2bGhZaFhUUDNvMEZ5?=
 =?utf-8?B?bnJNVFowU2F5K0lST1FQdHBZT1pRTkhBTGpwaDB6Yy9ocjROSjdHTUFrdHV0?=
 =?utf-8?B?VENIN21YenpZTzVBVGUvMVpCQUJJQTh3RllsMzU3YmNBRGFyZ3FHa0RVTWg3?=
 =?utf-8?B?RFVPaFR5TGk1bkQwTTg3cGZzQnNOV2tCWDNxR3FkODB4cTJmTGxSK0hMN3R6?=
 =?utf-8?B?S1V2cUpYVnE3Yi9yb0svQjRMaEhIR21xVkYrR0dCQ0NyN25UMVRONUVZYU5Q?=
 =?utf-8?B?R1k4a3JRV3pKQUhGNjFDVS9GdmQ3UzZCT2RrU09Kd2pteERTRGlORjRNaGNF?=
 =?utf-8?B?SUZmQ2RHTzU0azhQV3g4dUpNazR0YWVQVmFQQ1dYRkZBcUFtTHpoUW9TVWZu?=
 =?utf-8?B?SmcrME5YbUkvR25tVnFyOFk5RjZCZm9aYTVJbGZQb0JYVEtXTWpCNnAzZ1lv?=
 =?utf-8?B?N1ZwTldKRTdySndKSU9rSk0yR1Rpam9CZGhwcXpwZE5lUDduS1I5WjlYQXB2?=
 =?utf-8?B?dE4xbVhDc3ZpZmlOOE9HbWJpbDJ3dHA4eFRuZ2JhalY0VDZJY05XZzc2V2lF?=
 =?utf-8?B?OWxaeTlrK093RFc4Wk8rRmhDdTYvMFZ3ZlE0VUd4QUw5QlIyVS9hNHYzYkZm?=
 =?utf-8?B?clRFcno4NVRSZlpGV3BQNWRkajJOV1BDVTErVU9wV29KcnVkTWxPdDY1YVV0?=
 =?utf-8?B?eUVwOSs1QUhxdVF0R1laQlNMdy9pZy9WbmorUTVmMDFjVkxGbFk3ZENrN0ls?=
 =?utf-8?B?N25VSDZjNFY0elM0bDdCUkhsamhyRFFyT0Y4R0sxVFkxY1hNUDVkcjRHMUU5?=
 =?utf-8?B?Q0FDQ2lJckNLdkFPUEo5Nm90akZPUHgrS1Zwb24zamIveEFVb25YMW5jRytR?=
 =?utf-8?B?MHZ5T1pTY09SSVJuSy9zRHRUMjRyU0ZNazNWUXA3aVNQNzIvd3drTWZBWHIw?=
 =?utf-8?B?cEhkdHhXNGhYV2h5anRPYTBMK25JSVg2VDRHaldVK0h1YllRaDE5cUlJSW9u?=
 =?utf-8?B?a1ZnaGY0eFR2ODBQazZSUVpsMmU1U2RLbW5QY0I3NkpJUXNwczliVGFEMjhT?=
 =?utf-8?B?LzJwd3lKaEQ5RkxKVG5oeW9ZNE9ydDE1SnhyQjdnSVpTMVJsbTQvY1F6cE51?=
 =?utf-8?B?UXZ1NWthZjM5S2poTnpnNitHZlJ3KzdGWS9rcGt0NThtZEd2ZGdNRW5RdHJ4?=
 =?utf-8?B?VjZaYkxUa251M1I3TDVRUStPQlp2MXhzbmxtaHpyWGtSb3RybE51NHc4a2Nw?=
 =?utf-8?B?QkhvS2tvMEw0YTBmMmJYaGhTYnJLSFZtVUpYQkIxNm5rNWdBQlpKMWhXdHZC?=
 =?utf-8?B?eGZUZkxFem1QV3BGK3c4MkxTSE14SHI1VGxHOHVYeEpTMWp3RXl3OGJENHhE?=
 =?utf-8?B?SFJmSHpOcy9kM1VpVm1LYUtETmYvakZVNE9JK0x6SXNPWFMvenhHWnFoSStn?=
 =?utf-8?B?aUEvUzhCaG1jblBNaXFhMHFXK1RZNDBMK1BjRzdxNHpNV0thM3FBbzUzc0Q5?=
 =?utf-8?B?VkUxVGEvWDdVQXVQSmVSSUFCZTlGZ1czVWlSZGFMcUVPYThjNEFUU0h4RTdp?=
 =?utf-8?Q?6A2azW0Ru2kXdrwN3f65vEfGLx/gjw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:18:45.8418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483e5510-c37c-45d8-abd0-08dd2bcf3e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363

From: Manali Shukla <Manali.Shukla@amd.com>

The hypervisor can intercept the HLT instruction by setting the
HLT-Intercept Bit in VMCB, causing a VMEXIT. This can be wasteful if
there are pending V_INTR and V_NMI events, as the hypervisor must then
initiate a VMRUN to handle them.

If the HLT-Intercept Bit is cleared and the vCPU executes HLT while
there are pending V_INTR and V_NMI events, the hypervisor won’t detect
them, potentially causing indefinite suspension of the vCPU. This poses
a problem for enlightened guests who  wish to securely handle the
events.

For Secure AVIC scenarios, if a guest does a HLT while an interrupt is
pending (in IRR), the hypervisor does not have a way to figure out
whether the guest needs to be re-entered, as it cannot read the guest
backing page.  The Idle HLT intercept feature allows the hypervisor to
intercept HLT execution only if there are no pending V_INTR and V_NMI
events.

There are two use cases for the Idle HLT intercept feature:
- Secure VMs that wish to handle pending events securely without exiting
  to the hypervisor on HLT (Secure AVIC).
- Optimization for all the VMs to avoid a wasteful VMEXIT during HLT
  when there are pending events.

On discovering the Idle HLT Intercept, the KVM hypervisor,
Sets the Idle HLT Intercept bit (bit (6), offset 0x14h) in the VMCB.
When the Idle HLT Intercept bit is set, HLT Intercept bit (bit (0),
offset 0xFh) should be cleared.

Before entering the HLT state, the HLT instruction performs checks in
following order:
- The HLT intercept check, if set, it unconditionally triggers
  SVM_EXIT_HLT (0x78).
- The Idle HLT intercept check, if set and there are no pending V_INTR
  or V_NMI events, triggers SVM_EXIT_IDLE_HLT (0xA6).

Details about the Idle HLT intercept feature can be found in AMD APM [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April
     2024, Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 arch/x86/include/asm/svm.h      |  1 +
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c          | 13 ++++++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2b59b9951c90..992050cb83d0 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_IDLE_HLT = 166,
 };
 
 
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 1814b413fd57..ec1321248dac 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_IDLE_HLT      0x0a6
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
@@ -224,6 +225,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 78daedf6697b..36f307e71d5d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1296,8 +1296,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_MWAIT);
 	}
 
-	if (!kvm_hlt_in_guest(vcpu->kvm))
-		svm_set_intercept(svm, INTERCEPT_HLT);
+	if (!kvm_hlt_in_guest(vcpu->kvm)) {
+		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
+			svm_set_intercept(svm, INTERCEPT_IDLE_HLT);
+		else
+			svm_set_intercept(svm, INTERCEPT_HLT);
+	}
 
 	control->iopm_base_pa = iopm_base;
 	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
@@ -3341,6 +3345,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -3503,7 +3508,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 		return interrupt_window_interception(vcpu);
 	else if (exit_code == SVM_EXIT_INTR)
 		return intr_interception(vcpu);
-	else if (exit_code == SVM_EXIT_HLT)
+	else if (exit_code == SVM_EXIT_HLT || exit_code == SVM_EXIT_IDLE_HLT)
 		return kvm_emulate_halt(vcpu);
 	else if (exit_code == SVM_EXIT_NPF)
 		return npf_interception(vcpu);
@@ -5224,6 +5229,8 @@ static __init void svm_set_cpu_caps(void)
 		if (vnmi)
 			kvm_cpu_cap_set(X86_FEATURE_VNMI);
 
+		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
-- 
2.34.1


