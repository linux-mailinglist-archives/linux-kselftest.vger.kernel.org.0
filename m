Return-Path: <linux-kselftest+bounces-28354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8CA53DD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A0516A525
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D3207A1D;
	Wed,  5 Mar 2025 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ApbmRED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E232066EE;
	Wed,  5 Mar 2025 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215715; cv=fail; b=tm/SJ+83TmBGqzARCVlwzeQCMqFXpZWumqyy/N69GqZxQbdzBb0ktqF/DWMXYaZS6gSHM296se1tWuYaCYThCl0Uw+h0jR4xNElIkzfvdc3mV7rHAvZbF91K9+YA2d/WVMthj0ck2dJ5+MUeM5l+5V7mYsBvl5IBIxzLBTHEens=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215715; c=relaxed/simple;
	bh=YCLeVbxyeg3lU+UdIBWeGDbIcB+rfaM+5ge12v6DKew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlgiICHTjoHHspt+XwwcHXHHIn6Pxev2/Sgb7SzKlvT2p1LKMxFHpF3+9ux7ocZu3CGWob0Mit0l96ePrOBNvsJ0jRPvoNuaB7irsTLs7jLQu9p85vkQ0VoA9nIAPYq4ewCniasT/2x14v8NJHf6b9NG1trARJUOcpcpZnogpI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ApbmRED; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WobSiKbWLuyAHEsp1TKLxKthV/42Scm4R6pVryemPegqDw+nhdq99y7OcPkn5bitw2eSiEnnwxlxdAj/Bmkhv/AiXwuR7J5tXH/0FlvOxgBv4VHSwS6kNcnfHeC6gPcy3gnR7YeSzXGgF6qDqM5Vs3k5hu8dQjov27b1IvehA+mZnzr5V2j2L18Ar1Mt0JMD63lVotYXa2Hk3PCGPGT7ue7LhUo3su1BZnyq3ZKUtBu3Dq5z6m1abxObtn34ayQePFLc4NeKOMbDqAQ2QABOMyVI1UKYaxdiZzHEQH3OAvN3hEpvFXGTJL2HDRvz2a9Olll7GEFUBfSKgAhdtF5g8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM3Dv+Gxe2NlEj2wfiGq1HyLq9rQxhupuuAloJuhmE4=;
 b=DqJ7qU1PgLG4ajqPJnhb+VdmPaZlFpukhQmKkV6F3y9n/i+k2T04TnbKTZWOIHDfXTvyogFrGzRhIQzEn3D7j6jjZG1OSRJTGmgyaxIE6KVvxSl0k8Pk8O5O90oLFGBnYTQzV7BA9RLaTJ3Kd6Cmah6UJAiXBR65JKWkuQy+O3pyjm6KRez961zDlYspDcft8xCJqda1URwaTCEgS2+hWsH1XSla9I15KEzc/CjUvteHJX2L4d8IaaY/sNcdt3BKGsqiyWo3nvpsfsKNGpT0YwnuQNwTgkb6zAna+3qUNlfFEqEGUxKhPULX05F4lWQsl1gUJQrOwPISzl+5jVutlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM3Dv+Gxe2NlEj2wfiGq1HyLq9rQxhupuuAloJuhmE4=;
 b=4ApbmREDXIGbKMq7olgs1OcT6P6pDO2ntXh6K4sxQBKXhXFwgJTdxbNsL4LFF303dM7XECkcxyNYxMPtYBpef291W3U0O/xhmbnF+yDrbX4Tlj8du+SKg3lCzS+j/KJXhBtU4CSgs254yNGi8kV1dsBKeHYIGGH74hiJmhfeQZk=
Received: from BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 23:01:48 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::28) by BN8PR07CA0034.outlook.office365.com
 (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 23:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:01:47 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:01:45 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 06/10] KVM: selftests: Introduce SEV VM type check
Date: Wed, 5 Mar 2025 16:59:56 -0600
Message-ID: <20250305230000.231025-7-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305230000.231025-1-prsampat@amd.com>
References: <20250305230000.231025-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 67533831-fb92-4c7a-b94b-08dd5c39b53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74P0TnipvEcIMp+Ff0mbyx57kASPlOS/2z5asbGqAHFP5G4uR9sxa3XfPAnw?=
 =?us-ascii?Q?4PETDag013F47gaTKXofjo4upUReuG+qWNCG1JnQ2KGonmyYUcODZDkNeVJB?=
 =?us-ascii?Q?qqxXznrjaS6RdkucrnDzIwb8u5Q6HHq1v5MvkduRAQt7gafofuJRMSw7FItw?=
 =?us-ascii?Q?/JSSdb4v2dtU4tDK96GnV3XdFF9o85K3Vjwmt0SWWcnObd+tqXrjrdgu6ZD5?=
 =?us-ascii?Q?GtfPVXmG6M59XXPFBL69QQ/niloWnpIRyaBGT7IzYlYnBmcLyIP93KB4cb5P?=
 =?us-ascii?Q?SHEf0g3jjNdiXkF3nALPJEUZv6u/0ZIycWYKk+rNLXwrQ0j5XePcAIgTKA95?=
 =?us-ascii?Q?lLJAkKhBjA2QRd/HjUZkl5HqiBpeR/psLOLu2o0XNhU+BfWKiaiKKg/YEmDA?=
 =?us-ascii?Q?kFE5bQoY5aktmy+ykhem1sLDzRXWc9Hnov3FI1/4FsEE9l5+Y+4YI2cTx2BK?=
 =?us-ascii?Q?vGxJLcwjKbb9lqu+/xXsrbXkP1zaCSGGh2nXXKrrDbO5LySEVAeYgVSaB8F0?=
 =?us-ascii?Q?scyrHLqYt2/j5VcehJpH0ahdfW7v0BWNObjEIgpU8aUkUQsDNG0fFu6y1eW8?=
 =?us-ascii?Q?AvX8+yvV3DGDtl3TgjhgZ6YRs1+/HYGS7ztG9DzDa864bxd7CyFv+sR2i5w/?=
 =?us-ascii?Q?HSu/YUlMMyeZnsAhR13Qb/vUW4KiTBM6/LIbLaxLpHdWrjEKDWgL6aopC1wI?=
 =?us-ascii?Q?sMktdhKB6eMSVKELLonm6LqtZzxe4aEHKyg6uJFh79UH4IRFemWmOSTyV+Dl?=
 =?us-ascii?Q?iEx3Ssdi5g0yQietrqX63dK4I57iEju8hJwZG1PtF/Y49bBh4jrRWPuQ66aw?=
 =?us-ascii?Q?kRe2nbWHrAb9J1BRlTcvzDMPpuWhOj0J+sPfnmjJFObkj9snNu8baPSvlID9?=
 =?us-ascii?Q?l3zd6Z2rH3ika4OuzpWzNu7RxEc06b0Q44NHW2LQqOZAR0WWn9YvKKYevgac?=
 =?us-ascii?Q?lrtmKZtoB5FrfxKXGt1eH/oMDGQGBtWlb4ChN2EcjMAv9SsjYPnM5B0Pq8+G?=
 =?us-ascii?Q?dIASQXEyINgLWcCw66a0Tc4/XOiMfoXIBM7OZT7Da43k7bImDfnoGYVPDdly?=
 =?us-ascii?Q?Gtu/ofM64jDj9qdHrVkDK0mlg9p0yOMpEfFygO7DgjEo8p23od5DrRFtIx1c?=
 =?us-ascii?Q?WFTlO0cEN3DcO/QhN24Ia3RmlT94N+C0wWvMVhMkxQNCgqOOZeSn3sc8pOjE?=
 =?us-ascii?Q?3sI0LwjDacaQUF5V9JU51ZKgZfSdYfOD+hdjPdcX/8khdNinsZAoViYlGT1t?=
 =?us-ascii?Q?eOCd0YIgFoAvnmlRIEqX/Vtlu+BFt9TCsT4ZKm14QGKQgsSlPA5FkU4aHVR1?=
 =?us-ascii?Q?bti/psg3kT9p2THcVUGwmiFpTAAYjfXLYjftX0VnsTqjUorze53yvqlPMfm1?=
 =?us-ascii?Q?rGUt8PQwCNBKWiISwJaKBh6kEd2r/SW8lNCa7b0RBtOZxUmkHsrW29M1SpNf?=
 =?us-ascii?Q?rb1NoFfObLBiE06RP1tFNkrDwO/5cErlYyApbsWdsBHAlrd2xgB+IpTCwL8d?=
 =?us-ascii?Q?Icut04QtoRfKxzM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:01:47.9753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67533831-fb92-4c7a-b94b-08dd5c39b53f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

In preparation for SNP, declutter the vm type check by introducing a
SEV-SNP VM type check as well as a transitive set of helper functions.

The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
types are subset of the SEV VM type check.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
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


