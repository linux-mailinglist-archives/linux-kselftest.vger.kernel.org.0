Return-Path: <linux-kselftest+bounces-27230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A81A401A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3693018887C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0F253F0E;
	Fri, 21 Feb 2025 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4aHySA4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D957253B64;
	Fri, 21 Feb 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171821; cv=fail; b=s4zGV60x6a6bQ9sOnaUgSgKudXcuCFgjPVhgAKFaI7bkeIuKFGKTxK2HcTzK2neKf3yV+q+hjLDXqaktxV7/+ZSkwTU06n+EgeM+GI3+hVvjmMnELvQtmZTq76QjVtwKaazO0nYJfuyQ4UscBOpSBTXdAXs7+BSH8VGQu2jP7B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171821; c=relaxed/simple;
	bh=Z/qPvJHY6GtS3NljHu/XjpXo4lVqpdMLSYUiurP2cmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNGN+r+KmU7ZXHaICf5++SdOkNgfZJeycIW0Xfv0UNNa9W57a/Zb1tv0c7soXOzYjGGO3oVFYBR3V5pu5jSOTTEhy7rEFAAIhrYc91onGuI71RZ4+WGWt5jeNqV/vDoGczEtDVIuWkV9AJfv8n78IKoVx/suTkEgt2r/2xjqjZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4aHySA4i; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwMVH1dOlB+MXl51+aCfDbcqwF9crLVQX+8pkrGQ9X7RSHQ1evBS2Gd8v6uexABLtdRz2OElZrlYuouSukyT80WGG8FadLBUuHDLqiE3V/R3Hp8FdJvehGrjgo0rKHTBjtoEF6EIqO5RawxpRKpLSBEk2npW73pKfsYhgSFxyJOGdatzERV+6UHg61VQlC/K4xTmODsn2q/ZkC1qd8gOueK66QJCpHcRIrcJHv8zLXfyB2QKFb98h46rF0DGTFNxZhEVsMoRKJXGRWb9NwZ03EaAlhr9x58hnJZhS9aWdtYBnGj7PGrZeGtIJFNm+/D5ZrttyHo9mwXDdqL7MN46zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEoKaZ/ZkOb1PdTH/119TCEZO7XOkyfqFC1e8eKpKOk=;
 b=TgxxHkLfKQV8srlDC9nMyw9yktX/WjeD9906RZRi1qUZA/+zujLAZ4KjIUAyBGGrnn2rcATcK17PgNLU38+sX90Q3Sl7hnLm6tfjF7xAOmKthMZ9GsLYgJ4mAoZDp69Z9Uio/z95avxa0HVJIT5PI2vm/K1WztVG0MZNeACAV1d1qGkAEH2sgX3LSUmLX6TpwkjvmS+/tXRzbH34IbSqZ4qGgvNgQy5yCh5NbffyC96d5qqTnXbki3WvXChDH+rOjFFRcsXoDQfd2ygTyQ/KQRhZ8aVEfP4wUj3qZvq7Bhbc+A0vNB9PD76eNEnlphoPBJVRI/QltwU9ryPy049iJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEoKaZ/ZkOb1PdTH/119TCEZO7XOkyfqFC1e8eKpKOk=;
 b=4aHySA4isdfwJ7EC77rAM4pOUJJwgptJCkZV8VWNHFRqfof116/OuTtUMMWo+pfgvtZgiT0GxYsC3m490CARfSp6hx/yjs4zy1sqpRgeNuNEK/rt5BwMiLSQPOHwndOaEwbu9HI7xIVl535sbLYo/6v/rgHJJY+AU2irdLAM2As=
Received: from BL6PEPF0001641C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:11) by CH2PR12MB4231.namprd12.prod.outlook.com
 (2603:10b6:610:7d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 21:03:33 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2a01:111:f403:c803::4) by BL6PEPF0001641C.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 21:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:03:33 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:03:31 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 06/10] KVM: selftests: Introduce SEV VM type check
Date: Fri, 21 Feb 2025 15:01:56 -0600
Message-ID: <20250221210200.244405-7-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221210200.244405-1-prsampat@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c45d20-d4ba-438c-4bf7-08dd52bb3379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HdIcJqQ4FL7sYMVe6iVvD1sBSLZ+Rn8aJQgQrmr1y8eW3lsCjOM0y4sjrfKe?=
 =?us-ascii?Q?8fCMDCmWBOEf85t5tgIQggIvmF9nT6C6JryqUAfVMK3FUMoxEAwRQKVmOK4J?=
 =?us-ascii?Q?FGuGUIax+n+Uvg8LYUn9u6qL32qE556J3k/lemqFC6MsBFXUcy2A5h7ON0ef?=
 =?us-ascii?Q?pXBRMmqH5bcpkm3JkIAE8JIN6Cm7k41gWSa6+jSAUWW3po9uMDP3V+yIsrdD?=
 =?us-ascii?Q?cvRgwixcfzwIWIyCyWbrKf3fqJFZSXPdDI75wrSXCdgJ4HGigH8GJK+6CCEj?=
 =?us-ascii?Q?US85m4TZtwuV3PJVG9u+zD/tPmx5fj278fooWBiRmgWgzKhfBIqriBTyLocQ?=
 =?us-ascii?Q?cA7HuAYi9ieYVIV+5LNth3GGYpSulLIws+lTwlwOdZlzef1NnEbKf32lsD/p?=
 =?us-ascii?Q?bDJImj2Gmg9tdyDHd5Dkengbn29xVXL8Y4R0tIE5P0QgH7K4tB+9BAFAZilp?=
 =?us-ascii?Q?qZQ39K6YjlGrxoBR1fpL/k/x7l3M09jFci6tSnqdlJhFQQrcf1X+TCVcTQuh?=
 =?us-ascii?Q?NFmk9Sa0BAqnSz7GMClMYtg2btt1mrOgxYCeoHVLtqVLjJuueI26eDhHpytt?=
 =?us-ascii?Q?at46o6mJrbYtEaXWNFFKk/lwAxinhafkgVyXm01q3/JQJST4s8bQPRUYQ4mD?=
 =?us-ascii?Q?trI8ZVozDCpt2TVW/3HkHzM6NG046DpFK0VxZDWmqgTDfzAqzyDtAfObkwK0?=
 =?us-ascii?Q?DeETxdwhnPNWgP5m3SkpAefhOYEhYZFfHDhizHlcPOXj5woYXdzeg11Z0MQF?=
 =?us-ascii?Q?JfGMqk/VsKe7iV579uzBph9gR8iFqhtq+6avFHbsjMTlfgoOJT/8AdwkSqVN?=
 =?us-ascii?Q?cmN9AJCE4oCIvHgfeigfHg2/OgJbZrniqZqSvxXk8jBGF7LoiAjQCypjogXw?=
 =?us-ascii?Q?e/FFmsfQoYqLTZiJCPa44NeB3xRLsIaE965aJ2b/bjenxTuzZfY/AG6x2aEV?=
 =?us-ascii?Q?PCTINx2o7HdHJmot314+y1eHEZoQ9T69XqxIPCaKGboHD56hnS+YEN3NZVcV?=
 =?us-ascii?Q?pWqeCWUnwLVZ00GwPUwwrNuUV/JfP0acxmp6bAgMLMqmpBW7WK52C0sJAja5?=
 =?us-ascii?Q?pHG0K13KMyGAbyZye69xm9kvv+L5awgXLIRZO7pAct2RlG1Yhz0yHZIqokr0?=
 =?us-ascii?Q?kylyQP16g7+N/NWTYCcnwoN4k8vkoAGNJlxCZhZud47dsLJU472AFR9mY4bR?=
 =?us-ascii?Q?G+mp8wF+cz9R+jMMLUrFXSrn2PI2ZhG1wU5hgkCV0a0U2jd4F/+g2NGDE/Nz?=
 =?us-ascii?Q?OZ2jhL/qT8A7zgIN3QmWV3xW2H5FUi1IThLqYlrTjHYTftxO6kuDFBgSC5N6?=
 =?us-ascii?Q?kvN3W4DPFvpHsXyZ7K2+z3Y7bS0ZpH4ixv/gsfWfFxezT/b3kwObXCv5Xl4f?=
 =?us-ascii?Q?EgIfw7cLbEXn9je5oyvckjeHRrloGpOaVI0cvjqi+bwC6iUuSQmkd6OabkdJ?=
 =?us-ascii?Q?5/90Lc07b00qKWYGYJaqUkgNWmEX7OhusHi1tVNJ5zjgXdnUH7DmdjRdokau?=
 =?us-ascii?Q?OqymTR08I2Hx1Fk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:03:33.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c45d20-d4ba-438c-4bf7-08dd52bb3379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

In preparation for SNP, declutter the vm type check by introducing a
SEV-SNP VM type check as well as a transitive set of helper functions.

The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
types are subset of the SEV VM type check.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* No change
---
 tools/testing/selftests/kvm/include/x86/sev.h   |  4 ++++
 tools/testing/selftests/kvm/lib/x86/processor.c |  4 ++--
 tools/testing/selftests/kvm/lib/x86/sev.c       | 17 +++++++++++++++++
 .../testing/selftests/kvm/x86/sev_smoke_test.c  |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 3003dc837fb7..b112f7664534 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -27,6 +27,10 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+bool is_sev_vm(struct kvm_vm *vm);
+bool is_sev_es_vm(struct kvm_vm *vm);
+bool is_sev_snp_vm(struct kvm_vm *vm);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index bd5a802fa7a5..a92dc1dad085 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -639,7 +639,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (is_sev_vm(vm)) {
 		struct kvm_sev_init init = { 0 };
 
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
@@ -1156,7 +1156,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 60d7a03dc1c2..4587f2b6bc39 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -4,6 +4,23 @@
 
 #include "sev.h"
 
+bool is_sev_snp_vm(struct kvm_vm *vm)
+{
+	return vm->type == KVM_X86_SNP_VM;
+}
+
+/* A SNP VM is also a SEV-ES VM */
+bool is_sev_es_vm(struct kvm_vm *vm)
+{
+	return is_sev_snp_vm(vm) || vm->type == KVM_X86_SEV_ES_VM;
+}
+
+/* A SEV-ES and SNP VM is also a SEV VM */
+bool is_sev_vm(struct kvm_vm *vm)
+{
+	return is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;
+}
+
 /*
  * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
  * -1 would then cause an underflow back to 2**64 - 1. This is expected and
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 6812b94bf5b6..a2de1e63c3cb 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -123,7 +123,7 @@ static void test_sev(void *guest_code, uint64_t policy)
 	for (;;) {
 		vcpu_run(vcpu);
 
-		if (policy & SEV_POLICY_ES) {
+		if (is_sev_es_vm(vm)) {
 			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
 				    "Wanted SYSTEM_EVENT, got %s",
 				    exit_reason_str(vcpu->run->exit_reason));
-- 
2.43.0


