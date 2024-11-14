Return-Path: <linux-kselftest+bounces-22072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CD9C9653
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DDC283625
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB91B6D14;
	Thu, 14 Nov 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y58dZ3uo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881E1B3925;
	Thu, 14 Nov 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627764; cv=fail; b=m1X1ZjV00B1OJ/dvybTQhnt5cyOdbkPIRuutO9v0ki6rrx0ln2D+t8iLZHmEVC9Wx6S35mKlvjgJKTHRWgUCMD9mFex1NWHlqwtB18/7dS32w8ize8CfY55xc+PEFgCr6NMuoRD4zPAPfxzCern4vzORol6D1V6eucR1Hvvfm2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627764; c=relaxed/simple;
	bh=K7FCSCB1/UdCGXN0skk7P9qLphpfWoki6WDNPCOhjwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGqjdgi60zp6nTXuudiFru7Jt8uu/VUG6Mc52nPiJM9zQ21I4o+Q3XVr0eSWUvU666KdvvMPzDFI60RJ8vMUghADHb9DKJpzez2S+59jQ8is52ajUIOldaDqhvGGhoz7zDvCg/+Muc98AJZ750DKv9xe30WpyMyICryz36FOnmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y58dZ3uo; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJcFagszi0OXrxZEae3/hs8qES/NofTT+Jfv1oFCTEFSKo7A+n1bWqeJrhbU+oGxnEw44/uBhA56PYRrHPqZuKtEPXsaCImbpXv6QsX/JwTryXT0Xy37aBfMSV2lxaLLVz9H66u/Af1AdBFh8xxRiNzULDGpuaQcfSgeZmBylkEeBcz/UdOB9JZtfZ68MetCa5HUe+wTtQDA6iM3vPyVbnOrb/c0LZydEMfc7r5yhGnDe8QdeBLyONIC83FBZ2kukye4Pfn7bt1w84/uPOJtYDDZHBPz8fnDK/tKX5bk5UfJaMJywD/x79mIBcf1rBQDOc54sRGKfCMuX5JMDOXmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx8EBTottlb086y5AJDbfeJB1cpERe97usByQVnBg10=;
 b=heYHijdp1u9pTBL+tOxTtDvY7CKqcspQ90yUEPFK3lGKMFYfZG/YW2uKTvrvAuWDGzST8Zy8zZ+r8iTfitpaWly3jISzLDM0JgCrbeXGNKJOT//45Czkcpq7PC2ZN4PdD5W5o4yoQYjw7zRXyNcdnZd+2CXRNTSQckiPsQ4leQBoapGLiRv37Hpkm+/2lAPKbpHICGZbsBGcNaE9a3cIht2rHdV0G6cFeRDJivNE1kaJammMKN7/MBkS/NI+OhA0XIvws2/c4ETVFx0ii9sKkKHuklWboLK+b4ppz8iKBff4W+mLN3Rw1ooI3h/slbFjPoFgv7nQ2Shn2laxhjlPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx8EBTottlb086y5AJDbfeJB1cpERe97usByQVnBg10=;
 b=Y58dZ3uooRGONFrQBGo1wFrUk1isCR11kln+W1cUjEkAtQWHSF5bNlcUePkjwtHfwizK9qzePUidtlKRwNkNx2ACRd9J9K2vcuLMl4xSxNsCcI/hzqPttz7u9734XBVA50I3UI0Qb+2EMsUkhBIeni/S4tL9SN9yQR1qw++eUEY=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 23:42:39 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::71) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 23:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:42:38 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:42:37 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 7/8] KVM: selftests: Abstractions for SEV to decouple policy from type
Date: Thu, 14 Nov 2024 17:41:03 -0600
Message-ID: <20241114234104.128532-8-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 79db32d0-cd8b-476c-e39d-08dd0506064e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1YAs6oISW0AMDWpOKtD0B9FmeMb43dwtVflnYgmy9Y8r0NAMaGIZjFbYj07?=
 =?us-ascii?Q?Xbka+3Sl16IubqqpcSkWC90mMJfvgICfj6VQ2r7BrDY7lGbBAE2UyTEoko0O?=
 =?us-ascii?Q?M4CuPaHHSjeY6o7evLDHfGGwN3ponoEZjUq8IRVkJHWhBPFhKqk/V8gODAob?=
 =?us-ascii?Q?Vt1UEar9o7jo/v+RWTjaaXgvD78Rcr4apXabSsGJ7Q9NdxTKUQnUGIu42VYY?=
 =?us-ascii?Q?qczTupgUKv+bVpnXqO2QEiM+R5qQ1cHqdFrT3QzCJAEp6TLM8t36C+oGypV3?=
 =?us-ascii?Q?/TjXx0mUB3epfrfG6vpHdpfmBZ4r5waqPNk6HwtdjgQmfi6tHMYO9g9U74ow?=
 =?us-ascii?Q?BHGn5yZe1g56MegFvp0n1S6JpdK5zARKrVVgiMtsmhy2toQK49Ne+hThYIB8?=
 =?us-ascii?Q?B8hpnsVbK4vpQrpSrp7MT6l4MfieBJI9XeD7G/LJDRW6VeKo/YTATR4PgR2S?=
 =?us-ascii?Q?E4lrsKci59iMiwAfFrL1itxx6+BbKQ0B1qAmDmiVCrSV/CeskaXHYWIqS5Q+?=
 =?us-ascii?Q?ujAQnmQbzWh0imFqCEuGJprllNAda0x6V4KcEae0XmodvKpv6kVyFXCHZDNt?=
 =?us-ascii?Q?dOHYb5eBp8wIJJR0rYY2gaatXYp8oG2IhOKfEzDGxpY2IS6efAf/c8Uluwt3?=
 =?us-ascii?Q?vg5xTop10PeSJqvDTJLzBZ7f0yqJ+6+R/upbbhRA4JwJdZatCQ9YrwavLeen?=
 =?us-ascii?Q?tOcwLD47S+vhSiJG03XC2fYSs7lE8b2IQWC6EGmt0gv7rDZ1Y1ys7N7dWBs5?=
 =?us-ascii?Q?HoBBfTlSkEv+KB1W8S2krU8cp6K5J30AcyV1PIhd/7bYuOtSUR9xYpUO8ok2?=
 =?us-ascii?Q?8+Y7iYGzP6jj8IgZYgk2ddZJh9qniXbiWEYAlhVxtDR93nars2u+NH1PXoge?=
 =?us-ascii?Q?qSBTnDPPLjHcwHgJEqeqSMHhxbkvQr4dniYFWWK4GfVi9TWHc/cHFk+tI8EU?=
 =?us-ascii?Q?B9dYnc2+uYpc0kZNnnox3+F6AoHASNM6Lv+gnoSoYn7bEfLO67v18wq+LX6r?=
 =?us-ascii?Q?2bgqvEhdg90+gbLdJOa9WhK5WO/fE/xZeufaFaVfnlKhsCd1/CcMKfmRMkXa?=
 =?us-ascii?Q?vcJJA3i3bG2bFHkO7kV3fotMkDQFJcb9Tvk1K7vVXyY8yPA15lSJcg3dcly3?=
 =?us-ascii?Q?yywjSI/Noqd4RQIb6RzsnESXQe9D98pHYDvLE6oPY+ODfBFYlvt9nQsxlEMh?=
 =?us-ascii?Q?dVJImnER2le5GvQ9+Ia9OIlNJv+AdsQdWg2PrYM3fpiVjgHvZhF+H7VTx908?=
 =?us-ascii?Q?6x8qIBebG2hT1IyT2kExsppGNdJveIL4GLJ/YOkEa7tcr6Qe+C69eU52dRZU?=
 =?us-ascii?Q?tuTGVnsLaxANMzrBsNq8CqAMORSH4ZRyeUyyZR8fnH/j0uBwzl9uZfatqTKK?=
 =?us-ascii?Q?EPNZXtkiWf+JM+fN+ucYslQIL4jbbudmjiM00UEhWWtPZjxl3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:42:38.8379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79db32d0-cd8b-476c-e39d-08dd0506064e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127

In preparation for SNP, cleanup the smoke test to decouple deriving
type from policy. Introduce, wrappers for SEV and SEV-ES types to
abstract the parametrized launch tests calls and reduce verbosity.

No functional change intended.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 50 ++++++++++++-------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 53bc0af62bad..af1beabbbf8e 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
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


