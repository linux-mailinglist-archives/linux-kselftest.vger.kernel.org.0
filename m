Return-Path: <linux-kselftest+bounces-25052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1312AA1AC68
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230473AF891
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598481CEEA0;
	Thu, 23 Jan 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ht2KMQc/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0501CDA3F;
	Thu, 23 Jan 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669765; cv=fail; b=Djjnv1yKobCCtSxBVDvdgpwU7az7/vCdL0jV0WI6xbKJcFpzgx9+9n+loep87e7mfexw126UVlVc6ArrGfrdC7tOFMsSGJuDMPyW+cNlH5Bfx0ZBuSrt+NMmwTTf9uwJIGlrW1pkFfJW8ijuuyzbAWBaPOroovumYnaxoTYm2+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669765; c=relaxed/simple;
	bh=MdohzQwl4m5/0EOWMrzox0t0l8LgxvQGRZkx85JR3WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvoTlg2MnII5sU5clQSorFAGYDzDxcbG8g7umPD75jTqhkn8oKUcXP/b44CQAO0PsF1QPTlUbvN4V5MLqHxKA14fFIAyGIHcDtirjVbcB+aOYrYiFBy9HfafK6CeYxsK9F4xfJg9gzZQLyB1Z+wmrb80G9xyPhXLlTPsSIEtk7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ht2KMQc/; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxcjXDttc4qP3h/HLFta4zvj4nwTC/9gpfjU7siYzQT9ejyRYTo4urH0UZidevtjlXIJgDzP40WU6grBN3FYM893vBWXLzfUwiVzc96hlFdvwhNs8OCDhcxjcg1tsGNFQo/8iPUwHwdmynSZEyGL5lfmNcqfm6ry0pQjFTN32wY1xUefMLSLZl2JxaiqQMKDk/iygsE0c4hzKDpkaLUPU6FTRXVIz2xdClG2NDk2oIXetN/jS3+Sp+CkvZHKzHSCyiND4JMc5yuzhMzTjFi3G094SjLmmBO3bf+1bmYiUHrAP0G8Sps6nBKkpA3N+HoCjs2tT1q1sDbSOF6dPGLKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E3LkbUAGEKYNAIktDqZTu/UV4pNwsMNzsMfnnwn0Oo=;
 b=TiZKLJBBOyY/PL+83H3QdwodsUE6OH3X0JE8zsYamIRnx5ZXPrzyW8Wg653pG0Kp6hSkRsvdx0YbAT1MkWOJBI/P+fyXHBoKRaPw/DTipvmZFtglK+f6D+uvs9k4eb5nP647V6lVPpvFae1ukZ0ky1Hpa6TUisfWCWk4epTdosk9G2DLiF/mJoCC9MNmexcq11iB1ggsRtL96vLRTMfw14poeHXQ3jaFO10Vz6FbGsjfc9dJpt1t18WSvb1jkF3CjbdBM3sj1sfeUJot7k8Xvo4Dmu8ZkXC3PncVb12E5yqKf/VMoj4pnUyjIG4Fh8MOG4bEqyrjO9DH5lJmm3wJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E3LkbUAGEKYNAIktDqZTu/UV4pNwsMNzsMfnnwn0Oo=;
 b=ht2KMQc/12mn786VRqzX0Zyx1CSUiDXUIYl795PoRZ8LevqYev5tebwpp7g2H+AScRgYGUHsFyxOuuHn6t/I47pYbKIsNiE+ANlxahYLRVeO82sfkJMKw0mqrndO2lw/LahIifdR8vYB8peZ9ih8WTyRXPn20epJfGOd3J1gu6U=
Received: from BYAPR08CA0018.namprd08.prod.outlook.com (2603:10b6:a03:100::31)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 23 Jan
 2025 22:02:39 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::4) by BYAPR08CA0018.outlook.office365.com
 (2603:10b6:a03:100::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Thu,
 23 Jan 2025 22:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:02:39 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:02:38 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 8/9] KVM: selftests: Abstractions for SEV to decouple policy from type
Date: Thu, 23 Jan 2025 16:00:59 -0600
Message-ID: <20250123220100.339867-9-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220100.339867-1-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5a68b5-d557-4477-9fd1-08dd3bf9a730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kHcl3cBjpBV9z9qWc1EVvWLsDYPvwWXVsTvJ5WAiA10mI1r9omQ7FfX3Sk4o?=
 =?us-ascii?Q?j+/+ef9adv/6zUkqrljjwWOVwGWYJfb0SCM7caKeVNSQgnC2P74BDokYS40P?=
 =?us-ascii?Q?gzWInl9HEEv5pmFBIBuVHrbC7ODsTa+PGjkqhqrYdgs2S9XPVzvOJIRb4fgV?=
 =?us-ascii?Q?w+kKjgUYxwsbpMI6hXT5RhzaUYT06i11VHmUCJqJ/7y2xDg5x560pESm559v?=
 =?us-ascii?Q?htWGNnWS1HRJAqaaqNIaB1gQjJKzATQ/A+Q+4aDBrweQ8tIWyzDSuIuet4+F?=
 =?us-ascii?Q?rnY5kIlRFFk2nf8+uI/HVy+US8Aam/9xBaxeFUKdOG6vBcs+6iy1l7HuvfjR?=
 =?us-ascii?Q?wFN2pkissK7TqucF5Bi50TNP/CgSgr3k10mvb002jp+D+8/OVxO1YPBtjXew?=
 =?us-ascii?Q?6liDAbqr4vyM1q21CPtXt174xS6Zf3gKt2IF2ag41jxu5G27ugcuRAj3vEkb?=
 =?us-ascii?Q?aCM0JpnByYe4Xgqaemn1242d6SuQ3zUW4SaJVqDBHjkw4rA8uIbwlkZMTQ5O?=
 =?us-ascii?Q?+1JKjb5dw8ltIVts2o0arHZtLMEt81Kl6f/+HrgJe8Ox8r+qd3gDd68jeaZe?=
 =?us-ascii?Q?9zktEHQW8hldr2wOkaIE88LdN6meNu+7n4MQ/CEHqLWupUa4c78PnWuPymMd?=
 =?us-ascii?Q?2aK+M1B7N7MRSwTGcEu1vWH2vTZdRYWJ9q0h5piej0TDhOmR0bjunlYoN2y4?=
 =?us-ascii?Q?rojOWQkCYyRBXkryW2o2GDzZND+/+zlKIbQ5l1jl3YMXEZpUnF8qHodMZa6m?=
 =?us-ascii?Q?3ezRYMfELaNVKhjZjXlrSXMEGVY/PblcEngtHqlC9u3pOuDrqdQg3bUxSuag?=
 =?us-ascii?Q?nUujt1eOWpgsxtvfp8XHVUa9FwOpN+9TIz0ujViPqZMoZvggOFN/3aim31/U?=
 =?us-ascii?Q?970/+7+U9GKSi6BK+7i0HLIdxuRGYFFlPq062rg1Qv5E7sG5Xm9XelFxUqUj?=
 =?us-ascii?Q?YmjpVXqf0t+4eCnIS3ewLnrNF63tVwnWnWz2tYJ/uFAEKtfRmYdn5dA6DttR?=
 =?us-ascii?Q?y5aGZ75wiiTN7+JZ/qrs5yu7QWbNvgAvsJ/qvkzUpYwnS9P7m2UGU4xzWBws?=
 =?us-ascii?Q?uZmEN2g/UbaWKDmzJrbx9wCebpBnlTeG5mzkjQuNmTP3wDMH40NPEcl5Bhrr?=
 =?us-ascii?Q?dMEQozEz4DbnioAhBz8N7vInCOdCfyqvRA/J+vFyPfsptlYkIAwoezttD8E/?=
 =?us-ascii?Q?S6GaEWHd5RW+EtGCM9H9SwrTbSE0cdjB7E1nzGOm+rFDDYlEkTu2VhXdm/5E?=
 =?us-ascii?Q?Q3JdDRvm6guMw3SMUfPA6xbKvO/x9TLQ+cBYDotgajOWr8wYxdnEDrCRg3Tc?=
 =?us-ascii?Q?uKXvfZDaHFxdT9egz6d/ymU107go/6OCkucdTTtmth/D8XkjqriUp8HIx38l?=
 =?us-ascii?Q?SiDG/JG1MmoyQHZAOgnLcgPfHjL1h7DExXfgqNmqSECgJlN3z3KybtT6MNqh?=
 =?us-ascii?Q?LsXTP7rWNvHCxR2cBVCjnMWFYIQlwiw/XTL1E82QA545p7x+KV+2w91NsaVI?=
 =?us-ascii?Q?6BpFLKXqxbHa9Q4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:02:39.2636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5a68b5-d557-4477-9fd1-08dd3bf9a730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

In preparation for SNP, cleanup the smoke test to decouple deriving
type from policy. Introduce, wrappers for SEV and SEV-ES types to
abstract the parametrized launch tests calls and reduce verbosity.

No functional change intended.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
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


