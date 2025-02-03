Return-Path: <linux-kselftest+bounces-25613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D2A266C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3563B1881DEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BF321128F;
	Mon,  3 Feb 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hS3U7/vb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EA21127A;
	Mon,  3 Feb 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622047; cv=fail; b=UZHoSBuI+ssQ7GvAAqgOB0ngnwDJq/UU8h6to13IveIOmsoPbSHUa+mWWP8HRXPjMA5zmALgUXZGiYk6TpYQSIwa5bZFBnl6iHggbil9ifSw677dlmGsWV5s5gJ8W40Tgh3i+OlLtVKwjMxsP5cc9p7H1cmD8ynqrjnNZNWTFfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622047; c=relaxed/simple;
	bh=gjF6RwvFM3+AxLkfdzH5nG84Xlmb7qkJUly30/YWM+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdjQdPeI1+vCCEq53VAr4O7GTCDk3gsDjt87doWzfv+Yqoamp4J2noqi8N515DYdF8RiI5g7ih6/QtO+FRzrVfPduzEauQIvA0rS6bc59g0uR+PRgIpq/DT/6LPrSpir2wfxJVLeUhXamL2UeiiDKVo31o132VihR2g1d6SOk7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hS3U7/vb; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjQufW9N4TRPh8lpEhYuZ2XanJ4xYvGbFDWV87YrZiz4/+VVKgydjGbku9f+MEJ1ruXqH4UvOWOyxEkalZDFpKGJxdvCf6PBpXf6MeswVnT2SghSXXajUG255GDd4bPJOfLpkp7wGrEZ80kNhsc2Cnp4x2uduCAN+MI+D0DU2aT5DqaVuDJ/irahZYqPcr7Nfw0wLU4NPknUJV9d1MUTVSYI7L2g9pB4O6jEPQAg7+ETdXlRjI+KsAmN1hfmsI43p55UiAgqe2DGbVQEZH94hJtoOXBf9btgjYDDYNi26/MEnWR7iUcX2Tv/PKb/D7AGQ4AK0rohTU2Jd5Z+JNEfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8rOb7xOLAnHjqTXAMw0UrPPaw8BFnYRv+6NKczzBfU=;
 b=EdvEYzeDnZLipFtyT1c6ZXemxw4yLGDUXzHjarw4cF2s9tWNEQ2Y+YE9rGbie/a7tDJwhghGJF6sazQngDAxDiGlgQ+N3G3RBhOnQaRChaZBNWvCerqeuisrcmVdNW0Dy/fmvv4frm4D4hkqJSufpiBkJet+kC/+0MdpXs3B3m9ZxjEaIS+OUGFQCk3lY2WWfC1g4Aqwc0ccNrpxqmuUxxOc5iq1WCq8ns5PNRiLahe/gzRM9nPFV+r/Hsez6EDFfULmjbiUy/+97vM/6Y0eiHyGS/f10e84McRpKlW0gkhKX8lUo90AHHI7Mh258byh0xK6agVHKZESrEND565F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8rOb7xOLAnHjqTXAMw0UrPPaw8BFnYRv+6NKczzBfU=;
 b=hS3U7/vbQ8pBhLiCqF9CqNZV3GGNMTC9AJcZBw/qyv6u3O0y+AAwaW0YKSywf5+a/XP14J7YhhBpvTmPm4iv8/dYEAWc7KyWOrrvrZJ3ioLjCpFQev2Ri80ZRj5/uzES5djDXPEeAIU/Eb1nZT1meM31K+z/2F6B742ZIEqU6m8=
Received: from SA9PR13CA0076.namprd13.prod.outlook.com (2603:10b6:806:23::21)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 22:34:01 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::e6) by SA9PR13CA0076.outlook.office365.com
 (2603:10b6:806:23::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Mon,
 3 Feb 2025 22:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:34:00 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:33:59 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 8/9] KVM: selftests: Abstractions for SEV to decouple policy from type
Date: Mon, 3 Feb 2025 16:32:04 -0600
Message-ID: <20250203223205.36121-9-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203223205.36121-1-prsampat@amd.com>
References: <20250203223205.36121-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfc476d-459a-4882-b5e0-08dd44a2db11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VfVHTL3s7KN6ZRoo6pX6jWIojH549pUeLK0BlSDUc2dkuuTBxJtlaqt1oDT?=
 =?us-ascii?Q?i3OGcmUGPXKDhsAdkB9z1jR69u2XLPXgDtC6b2/VeBLK0mOhRm46sXFRLoVf?=
 =?us-ascii?Q?gQj6W/zEI3NOXue0ecftrmO8U6mc3g521ocHN0i806FOQ1bqBwLE3M+vZ3vZ?=
 =?us-ascii?Q?uEMKEx4vQqz1S0kDrkYlAiG/NS/fYmpiEp7UmavNTjU2sqNy3XRaFkqMn1QB?=
 =?us-ascii?Q?PUvPITOQs1RxDtbL+goZAYVk6XPTAAiwERkQ0SAfhz2cdljx5fU5jhe7cLSg?=
 =?us-ascii?Q?bkqF+Ea/XaeT46TNyOR0Um6rNP9V4lZf+nZVbKb0VXI98DBUDH/Rl9FzuMWe?=
 =?us-ascii?Q?YMMTr+8tWDSC2ccG7ws3kA1cdhbmgj+HQ62VaYqUayAuDSO/vOCYGycQl2hc?=
 =?us-ascii?Q?mXUCdZoriOoIrtbtkmAZDpgT4s5itbDVdh5odo5AtLXQLzF1tJ76Q5kbspbA?=
 =?us-ascii?Q?TvHo8YeMlU0JRN1wA1PK1CtGrhCG5NEIECjDB5Q4hbUOhLs/CdkzlqLzY/Sx?=
 =?us-ascii?Q?0ldmGSMQIufGIV65PiKTSQsEO6pkkeg+/Pp/v0vuu5tXMzsRHDO+MZT9FF6N?=
 =?us-ascii?Q?RW7Lg2qZ6PcXDo3MtUtabIk48f9NeHjDiWya5rY2YFAW7L2xSQB8gLfpj0Xg?=
 =?us-ascii?Q?P4ErTy14S6j6rrx1Uha4MIWH9lMDv8P7joDBOGQKt4xEuukkcB7opxUqRHYV?=
 =?us-ascii?Q?CdjFkpd0zE0P/FM8RqycYaXLGIVdsRWj48sBGI5TYnYhS4pEooxayVUzjvZu?=
 =?us-ascii?Q?zvG0g8cwz30X7+SeZgFxgf8cIvixRww2QbagtDZIiAt4xqh+0MeSxMxt7LY8?=
 =?us-ascii?Q?eaEFAMI3hoJU4eFtnMlRk3QOiN0+jqxqzKIOcJZXKmY5hYBeC5aYG//eawgO?=
 =?us-ascii?Q?qa6VzcEa99U+xBlFCWTQqaL/9NRBXH8FCbHgLD1Q9RT/Wg5A8zlLLGfqtfC4?=
 =?us-ascii?Q?U9CAY8npLMfFvtQi6x6LvD6XEw6KeS4wNap7hqz0wvs8DkzEJbSIWrYx10Pb?=
 =?us-ascii?Q?H+8927DDnhGlitD5KCj9/Ti3SGnqnWHT+a0arKsRhxf8jV7HxYgp6zfUeXj9?=
 =?us-ascii?Q?rYXcGMQVM0W7IiiDx+8HJCXY3hhec95upGymj7NB38pK9h/xVffp4kyaXFnu?=
 =?us-ascii?Q?870TRs9VSAQA0hNMH8J8tFDx5RkIk8YoMo7ZMK5pYJ44YIkQeCjCZh2H3vWJ?=
 =?us-ascii?Q?jD0xEU0ENJDjdSCBMZRlPoPAM/B8uhbqt+c0DCuYd72ZMzfyVH+HBm5stJYn?=
 =?us-ascii?Q?oKnFaEKFb7livwxI/hyTe7WWop6oiy2pb+wxWZN5n+bg2RGpICbkdCHP6HhF?=
 =?us-ascii?Q?2Azj/yb6Rxz40eqmReuiJvPnFnCWpydgvyTJ3pi4+d6uOVPbpw7hawRboxGV?=
 =?us-ascii?Q?wyiO7ECGaxo28x23+fLDNTdBmr8rF8DaqnDMtVMGSmklGc/NGIkKQfdu6PgG?=
 =?us-ascii?Q?OVyAh39CfAWUK0c8rN4Fbwn95GbMRNrzmILLz4+yCcpa6tTXV+3ooTqtiRuq?=
 =?us-ascii?Q?f8ihGhhKJBjQ+44=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:34:00.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfc476d-459a-4882-b5e0-08dd44a2db11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

In preparation for SNP, cleanup the smoke test to decouple deriving
type from policy. Introduce, wrappers for SEV and SEV-ES types to
abstract the parametrized launch tests calls and reduce verbosity.

No functional change intended.

Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Collected tags from Srikanth.
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 50 ++++++++++++-------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index b18c78314d5b..3a36cd3ca151 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -61,7 +61,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
 		abort();
 }
 
-static void test_sync_vmsa(uint32_t policy)
+static void __test_sync_vmsa(uint32_t type, uint64_t policy)
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
+static void __test_sev(void *guest_code, uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	uint32_t type = policy & SEV_POLICY_ES ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
 	/* TODO: Validate the measurement is as expected. */
@@ -149,6 +147,21 @@ static void test_sev(void *guest_code, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
+static void test_sev(uint64_t policy)
+{
+	__test_sev(guest_sev_code, KVM_X86_SEV_VM, policy);
+}
+
+static void test_sev_es(uint64_t policy)
+{
+	__test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, policy);
+}
+
+static void test_sync_vmsa_sev_es(uint64_t policy)
+{
+	__test_sync_vmsa(KVM_X86_SEV_ES_VM, policy);
+}
+
 static void guest_shutdown_code(void)
 {
 	struct desc_ptr idt;
@@ -160,16 +173,14 @@ static void guest_shutdown_code(void)
 	__asm__ __volatile__("ud2");
 }
 
-static void test_sev_es_shutdown(void)
+static void __test_sev_shutdown(uint32_t type, uint64_t policy)
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
@@ -179,25 +190,30 @@ static void test_sev_es_shutdown(void)
 	kvm_vm_free(vm);
 }
 
+static void test_sev_es_shutdown(uint64_t policy)
+{
+	__test_sev_shutdown(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+}
+
 int main(int argc, char *argv[])
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
-	test_sev(guest_sev_code, 0);
+	test_sev(SEV_POLICY_NO_DBG);
+	test_sev(0);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_ES)) {
-		test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
-		test_sev(guest_sev_es_code, SEV_POLICY_ES);
+		test_sev_es(SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+		test_sev_es(SEV_POLICY_ES);
 
-		test_sev_es_shutdown();
+		test_sev_es_shutdown(SEV_POLICY_ES);
 
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
-			test_sync_vmsa(0);
-			test_sync_vmsa(SEV_POLICY_NO_DBG);
+			test_sync_vmsa_sev_es(SEV_POLICY_ES);
+			test_sync_vmsa_sev_es(SEV_POLICY_NO_DBG | SEV_POLICY_ES);
 		}
 	}
 
-- 
2.43.0


