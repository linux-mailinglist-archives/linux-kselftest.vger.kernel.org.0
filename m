Return-Path: <linux-kselftest+bounces-28357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F5A53DEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986C116A892
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409A20A5DC;
	Wed,  5 Mar 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OUTOAGcN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FD1F7076;
	Wed,  5 Mar 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215750; cv=fail; b=JGlORMhuqrPfOicz5GkGbCLHztEPdAxfRAf/vH5N7xLTmk0WnAxLyhwlil7Nd/k/kyPwnvNl/zeKpyRDaggxH4ZspTacbDeyJtFvKeCxXcfcypvkN5ms7idyRuP85x1vj/8HErKfI3qN2FMDbSbSRYQxe3iAP/Ag6seVocRXbSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215750; c=relaxed/simple;
	bh=qMtFr+x2ZkJNsCqK82IKZg5c/ENlX69wHPRP1d/jgMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnSqFE8MzmbRNZOUo1EkN1xuKQKNt4I7BRsRgK9Q/1/w1vN/J63nhIUcH2pw8729I7B3Bey54Lv8B2BiufF9RqOtbvd8ftBF3qiDfyR8mG+sWqc6na0r0si591hoLJ/KUCC3AJgS13803q4Xdvoe+7S4YUNQhBHbpJ/KPXnsVpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OUTOAGcN; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydimhvS1yygjUbL5bv0Rdc6pjqFPJ7hwoLoi3lwqzut/2tIkRU5NJBAOcyHFi0Khxexzsiys9b6rfX/jpfQPXjl+GihlpWjLh9GEQ3igj2Y9CBN6nIA2pwakfM+Hsfh5YTs8CYpjwzih6pV4NHfOorHKWwBEg2sH0N1hO1dfn9PnhPIdgILZIekShCxsuSE+s9GRI32tLng0oS82DEzVI/lKhOC31J5jww/v9DSdCkGRc13qUdvRNdR2wK7pDGM3GKPkry2QQ7y+KFqb5jypxcOk7Q6hgN5/9QizoyVYDVUkHUsuwI8l2KNn68u7r/e1v8cILluVNBTfqon1Pm78Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wZDv370DRQqtBSv1Lhg+NuZ46P8LTX38bNAu3gbV3w=;
 b=T88ECyd54D6BQnArKg0O83KlGE6aIyZM6VdPUYJs7XXlDIvFeJXZIl+h4qJUdWSgel6bOj2PfbMIBMayMzPLspnbIEZ/aN4HvUTiGAQHB0EIhaxOaTxBJN8FdWSG0Z1fyCZT8e/GnE99wCHQwUsO9DeKFUlIBQFmTnqcGAsS3mV2xM8fTk52F50LVy0WeaveyULBfoQrSSETnkz93cNMl4I1WVahEnAMPDkjHW90calRQSrH00ZmlZl/vjnQ2s4qlqmyJP/L8JiErU8CqrkjbKoVTh0sF2DyU0HmBUQPFXlYJvXrSuJRxCAhz7+Ss1uV6N93c8m030bpakDZCeZFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wZDv370DRQqtBSv1Lhg+NuZ46P8LTX38bNAu3gbV3w=;
 b=OUTOAGcN7SyzASDLul4MYKMW4tsJy70fEVYIh1jKk/sZMfki9xVnCdLOZ1XdmXvvEOBZ1izs5LSlNMB1mjDHF06QVr9XWtwLW9nvpGBLGF1nNqOwAkC+9wVLhb65xTVn0+XzzvPL0ooHToiwFidohhABGSqC4U2lYMGrFKTWk8g=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 23:02:24 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::32) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:02:23 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:02:22 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 09/10] KVM: selftests: Abstractions for SEV to decouple policy from type
Date: Wed, 5 Mar 2025 16:59:59 -0600
Message-ID: <20250305230000.231025-10-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bbc7ad-1119-49d3-4008-08dd5c39caaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydKQG8duj464eCZQnVDs7mgdGrETtWsPYQf02K4huiPxI40zVT6yMJy9jsIy?=
 =?us-ascii?Q?TesD/E1LeOZtJ3xruhaLTefeP7pRUovCEntD9ny9xoaWiSu6HFB6gu7tkPMp?=
 =?us-ascii?Q?d4x5Ssy+RGQoUoHXTNEEeBd0B/hj81HHwEf9Msi3r/EW6O27hrTQ8zHZpsP8?=
 =?us-ascii?Q?vUrLuOM4SVUSbM3x2Gmm6vq2EHpDZJlcMn8ExZ2IWpkNpIk9nYKZdZkaEqUi?=
 =?us-ascii?Q?/dzVtym9w7ThltFkiazmSkaNLCoqOI4ibiPwzIOMCZpd1kwkIfMnerav1PQm?=
 =?us-ascii?Q?L5EdfRicDYarhKuGKhh0OsCAkBguJ9vovKXwl9r+Riad+7Q+gqFx1JotPZb7?=
 =?us-ascii?Q?mNxuNHhyA2dzW+4ueygfjj9Jtnso70ia1Kx/emLKZUZMpszqoEW1DApBuXf0?=
 =?us-ascii?Q?EUduH5zyRJBhmLKI0uCAdugdqkg4Uu8/0xNONozOBwSzTfbFIfQxIFuKQCrp?=
 =?us-ascii?Q?IQEXVuN5RkOxMluOEzBSMqr7vaPhXBBx2y8mYPEde88xVBL3jj028d9i5Mnw?=
 =?us-ascii?Q?q3oEvAKdtyc6mgkUn4VvmO7jxF+uGiWmcrSiK8/uxXTEeOBTGpwoT98Tx6wM?=
 =?us-ascii?Q?Ai+TmtMnBikpKlkLkh6uy6qgPkvS1pdA2TfTJqUqKqWm6SW+4nZJsfH5MfUR?=
 =?us-ascii?Q?3VfYZRg+iKAEUSOHFddA9t9pyjQewtmEvfhsjddmMlRp3i5VldUeRFKx+L6B?=
 =?us-ascii?Q?EB8OXCkAU5HGZs6Xzon5La92i+bxegC1Dmkp4pn0hnPq5rw7IlEpLWeiLldq?=
 =?us-ascii?Q?6nzMnqmqik7Js68tZDn5g2+xiBIGWnU2WbjVlrwHQEQdwOAnAKwE7FgyTsTH?=
 =?us-ascii?Q?siFLzEEC3gs9mmV89s6wJb2hkVGcYeHnR7s/lH6RJlF/uFriL7m1HEX5mW+a?=
 =?us-ascii?Q?MZHIi+fYCbrfe+ysdhJPdMgB/90I/fEk1nGaec1gwYyuAQdbzxkp/O1ibQD8?=
 =?us-ascii?Q?NY2m6Z8iWXOnwCrvsvu/0w90WX1CpRK7cNwGtN2ogmi+T+lCdi9pVuTc4T3O?=
 =?us-ascii?Q?GvAwjZ/CS5xHszq4RB1SHepzUxiQW9Kg6J21qw6IVXA463lReuuYr1ztZElA?=
 =?us-ascii?Q?tbZONM0qWupiK6/2qFTN476DBAA+8yaoZ0I8l5n3Bi8h+GY5gLM9ZDib/sGx?=
 =?us-ascii?Q?Q20AwxYVhDtmEvNtHigeNQdNvaKJ424ZAVwcgxOYG45RvAmZO6dJUsm1pZdV?=
 =?us-ascii?Q?T/egaftdcWnjxBDGENZYjeRw8FEbkd6zvsFwMTccshuq5wIr63tJ3J5n5tD0?=
 =?us-ascii?Q?wYWuEqWde8cliorQWC4NnYcGr+4cWSolFbFIgsdWGhi5wWr5fJQlGwCvcFwV?=
 =?us-ascii?Q?wydePQ9ArvIvp4PA+EJhrbgBHSF5+n2r5o8jZfzkOBmWp2pR7nhYrCory6C9?=
 =?us-ascii?Q?sajT9alCbg1GQoqqjr6meZ/fbKbazQY9upr78wnkvL9NW207YccG4fANe2La?=
 =?us-ascii?Q?5rx6aSUanpEZ20Z5O1tKm45Qy2W6yoi/exGF68p71ILwQz3uLQnA034k/SA5?=
 =?us-ascii?Q?E4BeuTYiraTHSQg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:02:23.9212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bbc7ad-1119-49d3-4008-08dd5c39caaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

In preparation for SNP, cleanup the smoke test to decouple deriving type
from policy. This enables us to reuse existing interfaces as well as
deduplicate the test calls that are called for SEV and SEV-ES.

No functional change intended.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index a2de1e63c3cb..620aa7c41f7a 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -61,7 +61,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
 		abort();
 }
 
-static void test_sync_vmsa(uint32_t policy)
+static void test_sync_vmsa(uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -71,7 +71,7 @@ static void test_sync_vmsa(uint32_t policy)
 	double x87val = M_PI;
 	struct kvm_xsave __attribute__((aligned(64))) xsave = { 0 };
 
-	vm = vm_sev_create_with_one_vcpu(KVM_X86_SEV_ES_VM, guest_code_xsave, &vcpu);
+	vm = vm_sev_create_with_one_vcpu(type, guest_code_xsave, &vcpu);
 	gva = vm_vaddr_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
 				    MEM_REGION_TEST_DATA);
 	hva = addr_gva2hva(vm, gva);
@@ -88,7 +88,7 @@ static void test_sync_vmsa(uint32_t policy)
 	    : "ymm4", "st", "st(1)", "st(2)", "st(3)", "st(4)", "st(5)", "st(6)", "st(7)");
 	vcpu_xsave_set(vcpu, &xsave);
 
-	vm_sev_launch(vm, SEV_POLICY_ES | policy, NULL);
+	vm_sev_launch(vm, policy, NULL);
 
 	/* This page is shared, so make it decrypted.  */
 	memset(hva, 0, 4096);
@@ -107,14 +107,12 @@ static void test_sync_vmsa(uint32_t policy)
 	kvm_vm_free(vm);
 }
 
-static void test_sev(void *guest_code, uint64_t policy)
+static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	uint32_t type = policy & SEV_POLICY_ES ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
 	/* TODO: Validate the measurement is as expected. */
@@ -160,16 +158,14 @@ static void guest_shutdown_code(void)
 	__asm__ __volatile__("ud2");
 }
 
-static void test_sev_es_shutdown(void)
+static void test_sev_shutdown(uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	uint32_t type = KVM_X86_SEV_ES_VM;
-
 	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
 
-	vm_sev_launch(vm, SEV_POLICY_ES, NULL);
+	vm_sev_launch(vm, policy, NULL);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN,
@@ -179,27 +175,33 @@ static void test_sev_es_shutdown(void)
 	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+static void test_sev_smoke(void *guest, uint32_t type, uint64_t policy)
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
-
-	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
-	test_sev(guest_sev_code, 0);
+	test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
+	test_sev(guest, type, policy);
 
-	if (kvm_cpu_has(X86_FEATURE_SEV_ES)) {
-		test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
-		test_sev(guest_sev_es_code, SEV_POLICY_ES);
+	if (type == KVM_X86_SEV_VM)
+		return;
 
-		test_sev_es_shutdown();
+	test_sev_shutdown(type, policy);
 
-		if (kvm_has_cap(KVM_CAP_XCRS) &&
-		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
-			test_sync_vmsa(0);
-			test_sync_vmsa(SEV_POLICY_NO_DBG);
-		}
+	if (kvm_has_cap(KVM_CAP_XCRS) &&
+	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
+		test_sync_vmsa(type, policy);
+		test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
 	}
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
+
+	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+
+	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
+		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
 	return 0;
 }
-- 
2.43.0


