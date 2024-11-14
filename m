Return-Path: <linux-kselftest+bounces-22069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23E9C964A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14C11F22938
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61E1B4F1F;
	Thu, 14 Nov 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gk0Gocok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229621B3925;
	Thu, 14 Nov 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627735; cv=fail; b=ZuTy/6wjkdozoRnGKjKbk9pHBZ9vEAk5Lp9mvo/Ay58QZsZoiN86hpl+fB9zVFkrqG7EJnKWcloY2zH5fcKzpWMNLZn8kPtD6TsPIwl0pBkY/5wwCeMhHDNYy7Y/4gpeENdYBuBmWxl+RqC2m2G1qw548KbzeNSitRUF8fGbDxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627735; c=relaxed/simple;
	bh=HxfR3OZsiTl+fWWaGmWoeIImmcYnoFoUXeboVRUWm5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPzREr3TQIzhyZHJPG5Lu1Ee3JQPXMz7ceMLUAJxLsWXw1CxKPb3r1H727Epy5TQSO6N9T7gR/01I26CdTW8jNx7UhkBN3PlroqpclHtEc/1HY+ZKp0bgQ1eS9xEWELffRqlb6bpLjQaMEEkvb/pwZSzUwtWPR4CpuL6KjfK0d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gk0Gocok; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhKQn0+gkU2vPMN5szWJmO9+SeO23KSUNErasUk1+i8NvjJ2quKNgjXgttGN9Uu5QvmqI9nKt4hclTLuJvtwtRXZfyZIs9fElN4uJ+F2mIvzvczKol8D10RmBTsVJAVmjXn7LhjcHs8igE4RfZvCATRfYpQc1aTqSeg5uofSFTwvw0Je7AXHPnaXdDmipxKfnGo6nvX6tVXvLhpiowKHWa6YaLdqaAsP9QIMxOzEkqnhl1dOWnhxL35sfM+TXCAvwwFhSA8ISYnZAoWIMFKM4deHJ2KNaopsMQw7koJIuGBNj10Kegq/IRg7zWV3CJukVLqmfVnGdHUPxa0CQkvs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4uAUInR5wQDF32eHx/fVslll2B4JSnf6NenT3BdblA=;
 b=jF/Cl8K1tlCnQ9zZpkkHWLnMbZBUzRVzKnhrWcP+7f0cR4/4js69SqBQyPoa4nPEi03YoDfh77HsKERuKrbLhgAyoPdNWfLS1PdUBYEWLx7K1bQCOfu+uQJKMVYXw2T+lRO3uU8a1eM7YaJioC4Ok8vxopXwpNhtuoHh7uhxlm+otl8nmEQyOTBKAYcvURBAR9I26QIfLT7Z3ABe2R51Y4DyCGWbRnpE9LWz30odu5hjc/nCXF5rcmKKxvZv4wBorgyz8iM1HS3aD7mvnncjPIDCiJ1Yl2MQiVu5S0gs/zNIA3vHoAGmyGcK8S1T/Ab3feT62T7IMsxiSxxDfkYLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4uAUInR5wQDF32eHx/fVslll2B4JSnf6NenT3BdblA=;
 b=Gk0Gocok3JPro9E+J8yLK7GjkOw0zkDJWB1u6gZ9sY8mtRfNpi1HmszXNS4OoRljbLrLuOLAP5YyZU5p2yMGw6QJx3dRSn52vhYKKrRCFVSYSxGvifrqNddjqipSLOESi1nM+L/KBCkVk2QmK1c8ZkmXEMBoAMYH8M0ZcdHfesw=
Received: from BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 23:42:09 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0::4) by BY5PR03CA0005.outlook.office365.com
 (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 23:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:42:08 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:42:04 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 4/8] KVM: selftests: Introduce SEV VM type check
Date: Thu, 14 Nov 2024 17:41:00 -0600
Message-ID: <20241114234104.128532-5-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2b42b7-aa3c-427f-116b-08dd0505f45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQXyZBsKu6Y8JgnxXkgyqStt09/7M2SrhLNGeVl9yyNKdO7d/Wp0ZuT/5nHP?=
 =?us-ascii?Q?MB6X3RslpUGCYV1/zDLFzix65beg5S3Vs+FVJKKRhcA/W4K8i0YdSiw0nYN4?=
 =?us-ascii?Q?dgW/ufEeBJnGNSR3n1bCc6pniPGOdexXRXBCeVa5Jt2MzGzw096Zbs99w/yn?=
 =?us-ascii?Q?3sRY8B5M3dxA09CbWGKYbVoPChFafL+jEc/h9ChFXveFYcf7UPFG1A2ljI5x?=
 =?us-ascii?Q?W9u/t81b0N3TlLh5vZR5PrTcTxcHXl2kGVYzClRbUmQp2Fns9twix7iED7MR?=
 =?us-ascii?Q?IrQXNqjbZXvjc6O/8rfqHuRBezeCN1nMqxdWBv2dd1NlhwisgPJhdCEVCjsX?=
 =?us-ascii?Q?jf2xH21V47S6RQMZ0ZglJkNQGoS+2iMvom7R56OlAy5AYDtFIqO0A8x6bOAy?=
 =?us-ascii?Q?svz4rna6JXSGqCOYDzfyteTghEzOnEkdkVkbEXFnn2p+RgdIZhbnz5UunLaJ?=
 =?us-ascii?Q?hPnaZJgD0HVaIWvDRaU3oJu3Va7T5/n+irJBsY2La03EfKYpHXuv6/djPBQ9?=
 =?us-ascii?Q?BCNafDckLKvnXcyiyXD732a7CwEQFqLSceSph68LDhyVoMi5lJHo8q3rLsEB?=
 =?us-ascii?Q?eoWgycjZ7iz5jjL8Lluqelzl2Unz1aZwjnvSV+SMwQCllCAVI1JH9W+nbRAR?=
 =?us-ascii?Q?0/1wOVWUL1LBL1Shl+7DVUQfv988M/Oq4lyb64pL3VM4WXniYwez5NUQToIm?=
 =?us-ascii?Q?2AzZdS9sCMGMKs4BUKwZcIUjhnWbSVxZH2MzwUEvOKLi4COt41gNZE1dFzHn?=
 =?us-ascii?Q?cSISlBQZK6t4xJJFy46XQXrvLKe3ce4a5k2DSj4Kj7bK+zUo1ANowfyYVudw?=
 =?us-ascii?Q?IQ29El0V834uNeTEKNBindu3PqzDjRLhA/eQrmXHh1CiGfLpM16RZUAg0p0i?=
 =?us-ascii?Q?Xbug3fWu2vvT1pPSKwOhHhRttnReEj1TVrCkmObjUl/qeSBzHAcvMKKUjbR5?=
 =?us-ascii?Q?6w/coROmn4uag4g5wUE1otvgfgB/ahhG51U4xJNbfBUwy4eOhNfzyrqjX6du?=
 =?us-ascii?Q?2lJJoOZhgjmUdfTrKe7S+G0rg2ONoXJ3RaCvpZDJA5CQpoeE0bO/aTTSk1Kl?=
 =?us-ascii?Q?mevayOEtPapnSHshWQ8LJgTyUnPO/uBnH2/vM0fmOm2DZ7/ubM2XXdpuFGJ9?=
 =?us-ascii?Q?mVTwLpTMCe9nZSQAd0rBhaU3fnKXyGN289Kk1WDAVjCYyDNPWl8q+ZeryThc?=
 =?us-ascii?Q?Jy/KwZoAXrFfzD90TViWtFHftcMGJwejBvOu8ZA5VBG2IvuwlkJcA5AvBwA8?=
 =?us-ascii?Q?lT83uaCaH3tev4qe4MNtn6EX627mRhbJewb6h1WOTMs8w4FU7ozYLiXxT2l0?=
 =?us-ascii?Q?hc92w4EejmQfWINz7+wO+RDpCB9R1c1rFIq/d64ntFXesK7WwMHeZSoFp8w6?=
 =?us-ascii?Q?BcwBSVxZPrN1ReO2tT+rCub8Ep4xw2kmKLFCF5+FNtMX1Awvfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:42:08.7344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2b42b7-aa3c-427f-116b-08dd0505f45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

In preparation for SNP, declutter the vm type check by introducing a
SEV-SNP VM type check as well a transitive set of helper functions.

The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
types are subset of the SEV VM type check.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../testing/selftests/kvm/include/x86_64/sev.h  |  4 ++++
 .../selftests/kvm/lib/x86_64/processor.c        |  4 ++--
 tools/testing/selftests/kvm/lib/x86_64/sev.c    | 17 +++++++++++++++++
 .../selftests/kvm/x86_64/sev_smoke_test.c       |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index e7df5d0987f6..faed91435963 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -29,6 +29,10 @@ enum sev_guest_state {
 
 #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
 
+bool is_sev_vm(struct kvm_vm *vm);
+bool is_sev_es_vm(struct kvm_vm *vm);
+bool is_sev_snp_vm(struct kvm_vm *vm);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 636b29ba8985..13f060748fc2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -641,7 +641,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (is_sev_vm(vm)) {
 		struct kvm_sev_init init = { 0 };
 
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
@@ -1158,7 +1158,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index e9535ee20b7f..d6e7a422b69d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
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
+	return is_sev_snp_vm(vm) || is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;
+}
+
 /*
  * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
  * -1 would then cause an underflow back to 2**64 - 1. This is expected and
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 97d9989c8011..53bc0af62bad 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
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


