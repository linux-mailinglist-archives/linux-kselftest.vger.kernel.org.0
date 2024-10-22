Return-Path: <linux-kselftest+bounces-20368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23D9A98E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 07:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82101F2417E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79613CFA5;
	Tue, 22 Oct 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="20Tin1hZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DF13AA4C;
	Tue, 22 Oct 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576114; cv=fail; b=mMUN1gnYP3OBgFgLBwcWTH14F8GH04joUL4SlcdZMXjbb7xDguE1pVbXq7O9J+Z3RgIwa4o6HPonEhmj+LNVaADLnHsiK27jz9K3MZdGWTz4kiO1k1PxVTND/9pvkx8vm701/QI0TYpfOgWMzA83bWeYEyMq5rZFJZQ0/W2dq14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576114; c=relaxed/simple;
	bh=8G2UBTnNk6rmQuWOIrhpwjZAqb+Gcj/3d6etHKN0NEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meXH1kdfuvTV6oxZAAJTuo6CUv9qM9dy3IStP4sABOQ0L5aYrlzQhtOV/R9koMmRLllFxZV4hS1tvFXIntp79H6zp8ythdbjdLpoJ8VbmvDkEg2rqchwi8ohfl5AvRdaHlZD1/FS9UdgZpql/s5ugz8TGmMkI1yYQFwrm/DHrKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=20Tin1hZ; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5Ywa4lq5UEMHcRwArUXILyEx75I8rxudIEZ++ng6QSGasDDAFkef6fkMk8ETaS0o47Gk4riz71kzn6O8U2CDw9YHQSSlHzJSYau4Q/y+etRZuTsoeHFZuX4mz57AbPK2imcbbIKSFaX63svGz2Qv8iN/qITMZVOoWhuxACakO2l+cmZEYKii8kln/3sgbO1SX4RQoEbbMly6YDoWgPEM/QclG2PDLbTi37Bl1kwuHPXtZwj6rBOPdg62pnji8eigiHUrLd0qFiDnncX2B7m8dFrq3ZR6gFjEonph/U2gRok59A/BC7kuHMR5IfunSakT18OSr7NfMe6xdbnsM0UNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbmSpe7yBEKtmmMtQlzdmhivP1zDgXZjr9lx5yr7P0c=;
 b=pihTKs9xobLQu687gOUF5qBES6Wh//KKRViNxCzhyeKqbRkHSpRU0xg0hVem5jT0dG6S4aMqy26PvyT7KyKzkxiQyHr+2hN/RTcErl5sfUS1Nc9MwiWSccaq4bIbbfj6y5KDhgqMwIJwk3g0gJ9/Xoy6aIFifjo4nONZBTtwBix9xPRZO/I7o5+sK/WsVcyeC7jH6Kcp8VST2MYgkkc7o3R2dOOrQpaDZlbAMja6CkdvFnmz4c4+1KOLSzluqlotkFqqZjklsvxx0ZXHksEA8FCOc3yVEaddX9nSVYaTemvZANtbHqi5oUi1p9UceNeDUzdC4Qi9a20DMe8I+cFgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbmSpe7yBEKtmmMtQlzdmhivP1zDgXZjr9lx5yr7P0c=;
 b=20Tin1hZATkaE9w0wYlS614RjAowerkzHKZewnT2vLj20dqzVurKx5+C08pPRvF1MXsfIJzzgMgYYDNCfP+1YalCyY30eIS4sOCxrIfWgS2VQl7Dhtic6GwfDa+3esuMTLxMULCVTERQccYaLAIbnD1s02EGsjVrU+c/woe4jyI=
Received: from BYAPR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:40::24)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 22 Oct
 2024 05:48:28 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::ee) by BYAPR04CA0011.outlook.office365.com
 (2603:10b6:a03:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 05:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 05:48:28 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 00:48:26 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v4 2/4] KVM: SVM: Add Idle HLT intercept support
Date: Tue, 22 Oct 2024 05:48:08 +0000
Message-ID: <20241022054810.23369-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022054810.23369-1-manali.shukla@amd.com>
References: <20241022054810.23369-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: a12727cd-bbdf-4fbe-29bd-08dcf25d2751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3ZrUDFOY2ZmRmN2TkhTVldOYmRXdC9SdnhjWVBwUk40WitwQXZFZGpmSWRD?=
 =?utf-8?B?UmhCRHJuWkN6VFhoTnR0OW1RTkhWUW5ndlZpZGE1Tm4zNnkvWjRmUXE5c1J0?=
 =?utf-8?B?RmpnMlFVU1JVTkNLbEhzZko2bi83SXpibFFqQXRub2c1TWtaNkRDclAwcmdL?=
 =?utf-8?B?YUptMHM3SzR5MXhwYTdlNVA0Znk3ZTB0OXIreU1JSUJQVDBZOHhGdkcrdzVM?=
 =?utf-8?B?amNKRDRHRjFFRXYwMTFSNVlXU09rR0pnOTRTYXozYmZ6VFZYMTFLT0FpaGhp?=
 =?utf-8?B?TTFBVWFNSnJJTzJSRjJMMHFUTE9hdEVPQkdZRW1CT3VaOTlxa3crUDVlRUow?=
 =?utf-8?B?RTNDNkdlQm5XMC9iR3Y5L1FBK0xIYVRRMmtFMWozQ213amFNU0IxckRPU2pG?=
 =?utf-8?B?cU90ZUYzNmlvajhOd0xObkROYlo1MmlBSjY4d2dvcTlITlR1anR1WW1xN2Rm?=
 =?utf-8?B?eEVoT0QzbTR0N2l6NWZURzhhUGR0MmVHVU9rT2hMYVFsR2lLU0FxMU9rSUJ6?=
 =?utf-8?B?UXAxUS9Sc0RhRmVvM3RUNnhPRnlmaUxhSHQrYi9CQTg0bWxCTlE2UnhzQm5n?=
 =?utf-8?B?SUVVMmF0WXRhWEdOTmgwb0xSZCtjYk1hWWxZMnZUTVJiZldDKzZIT09KZlRX?=
 =?utf-8?B?M0Yxb1lOR2ZGbGVTckhyOE1adHlHNTZRSE5tWE5pYk45R1NjUFcvd1Y2Y1oy?=
 =?utf-8?B?N1lVU2U0bGFIdzdjVUxzTVlqbE1PQ21RQ2VvUGtMTjdSeDQrMHEyL3Q2MXk2?=
 =?utf-8?B?QlorazlNYkM4Y3hDWU5EdE9ORWVDZ2FhSkpJV1NKNHdtNHl6eHY0OFdlaktL?=
 =?utf-8?B?enQrRDBOVlpCeCsrMXRyZEoxRS9ROGlvODBEcHVTVnF1L0dwbU5XMHd4UFRo?=
 =?utf-8?B?WjZFbVBPQnREMGRKd3h0d3FDcGVSQ1Q1bXRhU0lmTGh2QnR6aUl6bmswNGFB?=
 =?utf-8?B?YlVSKzl4dkR6Z0dQZER6aFo5aTFTWU9YSHloem9SWVQvaCtkV2tJTnpoQXdj?=
 =?utf-8?B?Qzloc1ViVEF1RmlEVFdMc1FOYkhwTWp6bE40NmVmWXB1U053ZzkyY0JjdGJv?=
 =?utf-8?B?VUFSNHNoNTMwT2lvT1o5WjFiYmQrZStTcXVTWUttT05ET3lNNDFxOVZxYWJw?=
 =?utf-8?B?d2VWQ0JCYVRBeHQvV21aZmp4RzVUMkhUbE91bHhYOHBEUHZydmhKU0xuc0lX?=
 =?utf-8?B?bzZzSkxnVEtwR0piWUtyMjRrQ1lTUm1WS08zSTV6Tk9lTis5akpxQWc3UUY3?=
 =?utf-8?B?YUUxM3hjYzh1T2VGc1VvcUpobFRjaDIxUzBxTDhRZ1d4WUZvY3FyRmZFZjFE?=
 =?utf-8?B?UUZrQUpWUzRnWkcvNzF4WUpOSFAxOHRzTWF5aVFRRG1TWDVTS1AydjZtQ2F0?=
 =?utf-8?B?UFRMb1I5Tm1IbW5UeDBvYWhFd0l2ckwzelNCbnlvRUt5ZFlldHdHSURCaFV1?=
 =?utf-8?B?NE4vUDFzVmRWRURkZ21wblhyY05BR0FNR3JCS3BOb2ttaUFQdlZPK0ZQbVg5?=
 =?utf-8?B?V2JMNTZtQWdoRm91L1hjbStqUkF6SnZzRHJoOGlua29JWm9nRjRsUDB1UXlF?=
 =?utf-8?B?MFh2aTNmdUpIa3NIUWt3TjdvOVZaZkxGSmI0d05IWEFuakdPRmlOV2NsS3Zn?=
 =?utf-8?B?MG9OZ2JEL1YzYXUwSHBDUmxzT0tFc1EzaDdCV214L0ZyNXFkZjFjTG5rZmwx?=
 =?utf-8?B?OW9Ga0tIRCtvdFlremlJTEJ1WnJEWExXa2MwTzlDbU9MOXRoN2NOWmJGL1ZF?=
 =?utf-8?B?L0phS2xBV2xFU09tV0pURmppVHZNMEdUU2hSZmNHcHBvZ0hET3RPMHJUblZY?=
 =?utf-8?B?QjdKdjY0TTdtam5MVVlZcFpha0VTN3pLbkRLMTNOejdRVlYyMytXYkljU1Nr?=
 =?utf-8?B?cW4yQnYvdzRDU0xyNG54aWhJeVVnL3p5NExkVUwvaTQvK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:48:28.3559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12727cd-bbdf-4fbe-29bd-08dcf25d2751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

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
 arch/x86/kvm/svm/svm.c          | 11 ++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

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
index 9df3e1e5ae81..e86b79e975d3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1298,8 +1298,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
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
@@ -3353,6 +3357,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -3515,7 +3520,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 		return interrupt_window_interception(vcpu);
 	else if (exit_code == SVM_EXIT_INTR)
 		return intr_interception(vcpu);
-	else if (exit_code == SVM_EXIT_HLT)
+	else if (exit_code == SVM_EXIT_HLT || exit_code == SVM_EXIT_IDLE_HLT)
 		return kvm_emulate_halt(vcpu);
 	else if (exit_code == SVM_EXIT_NPF)
 		return npf_interception(vcpu);
-- 
2.34.1


