Return-Path: <linux-kselftest+bounces-27233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A382CA401B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752F1168AE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD604256C70;
	Fri, 21 Feb 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RzLUusTC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E342566FE;
	Fri, 21 Feb 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171855; cv=fail; b=Kuvli7gPjYoNdBdCaS2kfGhmxYxN2m23hGgq46KUCfXFbjKNVeUz5n15g2cu7Y6KKw7nGG6FJsg0gCpIPghMud0guT6ipXztqjBlXEJjBbo5R76y6y9eiYFiko1tYi8TMUO1JKS4snoktBujefqfzpkwiWAxMJCCayHKXdqRVMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171855; c=relaxed/simple;
	bh=ixJK/CP2k2A81zoZaeIc2hb5z3TbTa9HA77/twLMXNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkQEj8sLHAdTYHnRS376WWVnUKqwqXQmrPlqh6F5jl8JVuvfWSe5BL9teKPntBW/a/EpQZ+xDqKTjVWgl8wWKFP0bLTzy1lnaFZYqT8In42D7287jg4ks4kgYihsVHseZwF8GYHxD2GAeSambrsTKiIcf5g+5zkwjasYh6qRqm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RzLUusTC; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFcZ9VeGQKxRLaJjDoTk4NnLzZH5oJgNp4WxevIZGgW0+57w7bymPctXqWDvZ87RV0dRSlQzSPMxYzCA8OLBj3oVcU9OiUgYnkIcIwQvz0JQYy0HxI3QyCdWZZC5fR7oOVGE00jjfU+DlBz2kRr9K2dNjUQNHHeD5LrIhVqME8ZJTavJRqQ+/MOtEqHrERFIIbXX2JGxPnfDtDGmMDUdjZOm6kyfZ+bClJ4Zns6jQOdxFgi3Cb6ASJ5wWmN6yxaBG9esxryAATu4Pe4ibvAAlOV+0ISVeFfxpJKdTnrf2HLxGiB7Ddv2N58xZTfatKKQLq2YrQo24DA7z/VWMTETZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj0g5jDg/+Rd3ezcsVtzEm1qZyuHkgSjTft0xKmnT9s=;
 b=fcwGLsO4KulgQfcbxGI3WAP2vPqOe0iJOt6atqHRkscm/qo2/SEYoxIcLWkB8wnl/0s/Xsz1CjPwvbf1qjaZOovb9sx2TkXXZXLrzyR/ute7Z+wCS/YG1SFdrfQxYK3Jr2MMpxApNP9BuTKARdnWwyLOBp1l+8rxPctgskmlWyKcUv1FvGEDFuNsQqx4MB7Olo9TxvwdsGd2qOlhNmgxwI/T7SPJe4+doQwpeWS9O5+NlHPMYPSNeBpFafCna20DTGXiPkDUdR30xTgs8+e78Vz20fpYTYbXU1gy/z3kI6WhnvB3xjOlvNh9mXy+QbaB01KFU3GvadFRUqARQaq7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj0g5jDg/+Rd3ezcsVtzEm1qZyuHkgSjTft0xKmnT9s=;
 b=RzLUusTCBZYsh8coCB95BGRCvtYNmt/xbumFif9y2q17P7Hx4CBA/CBfUcMycxfPEEFqk11STzVrnzYwWRKRQ5H6NnLARUMKF7xg+jBjCX/FHTMi5Na18NwJC8a0JJlpa/mDBfFn4/vfMO25iS11GAaJI88TgD8OgqWwL4H9NHs=
Received: from MN2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:208:23c::8)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 21:04:10 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::86) by MN2PR18CA0003.outlook.office365.com
 (2603:10b6:208:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 21:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:04:10 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:04:08 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 09/10] KVM: selftests: Abstractions for SEV to decouple policy from type
Date: Fri, 21 Feb 2025 15:01:59 -0600
Message-ID: <20250221210200.244405-10-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ead7977-6b1c-4590-885e-08dd52bb498c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGAOC5iiQVYl+dQ0j6GcJXabyaMi2KAaZjp84yuVayxCBQtGgrR2EkI6neY7?=
 =?us-ascii?Q?ADf/w03P/B+RGODYAQJsMbRCydBzcRe7kF2LDzHWXq/t1bE8T4HCT2O3Se6X?=
 =?us-ascii?Q?bJMPGd05YeglqR8jIWuVLTsXpnkXelB//gXdMtT0PSv8IR+ZlLtZG8Tiuwt4?=
 =?us-ascii?Q?yIbxo3qXcW9axMfpKcQpvcnRFuXS/pR0BONGG+EamlrtbfLjPpbCrsfufxYA?=
 =?us-ascii?Q?NYK7Ot2FNVhq6o8ra5+5Q3FGid58dFhNdK38TdN+BlSIlIP72NHvf+kbDNba?=
 =?us-ascii?Q?PWkcRiiBwG3kB/dmzNoyZN/zIfgpt8WvOZ9rNVEClUhQB5BvITXWL8KWBMR/?=
 =?us-ascii?Q?ohOsrOxPZ1PQK/8HdfGt9JmocjzcBwgLtGiMX2PUYgnfI0EA3sXNfF79HPZ7?=
 =?us-ascii?Q?LX84TNt1iTfQVSTHUZSOrJi+g+jw/BAep0+swEuPFlNVjdHxAihFqTvVKXC6?=
 =?us-ascii?Q?aTnKOP3EhzIJFpSO8YTEBqwN9VworzLrJvhUH2dUsjwvP/EPxMfFd2lNt4CD?=
 =?us-ascii?Q?Brti6dvGyLzudwQOWGyNE5hnNJU1M/yB3ra6ZtnnL7zhqwI2DHfhxQqqrK2Z?=
 =?us-ascii?Q?WMWsXA89wKyHYrIW/ptJy4DHKVWPADUe9fmoelJDmqp3Qhqef2qTKGankbXi?=
 =?us-ascii?Q?enXAiaGmjErEyCTSS0ZX9wFZMan54B+PiBVVqpY0XBz//JLgloLshORBizGX?=
 =?us-ascii?Q?mdhI6MDtU7QVJZmw+R/fbW0+VA+J0AT+2h/+WpZb3m5KtReiUffOPEmP4ZGc?=
 =?us-ascii?Q?b/9OHvQ7IPqSYic0LjphiNqesQSejPPZuJij8//rasRxsAucqHPCJh0Zc/dP?=
 =?us-ascii?Q?/yShnPy6YrXAFNJY2zTz1LWax5XYTDtvEX9OtcVdFxafOuFe/5aD/kwP5Vka?=
 =?us-ascii?Q?SUBZzt8fk+YnQvcLJK1hjadYq5+s/HF77toBGRiA3TaWYaOZKcqTmoYsAedP?=
 =?us-ascii?Q?HVyfbCRuSzLhjHPdf5//91sqoBaQbhlPnedvD5kSRf3AgbjqzsN5oEAID1C4?=
 =?us-ascii?Q?nyloVRe1QkrkrXKovQCeB3cHpJMHGUK/77eA8sWRcISnAKzoortTvL3vsGbr?=
 =?us-ascii?Q?Zw+C/a0zR4hVXznZG73GSgUjR5mZMEoltCCaEGLAJo0NCka0G9d5ea4cXYIS?=
 =?us-ascii?Q?icnjniwIkDQt4VYCGXqVw+6kZyaKXvhDC6KnbFFweF2q0AYLTx1dv5zS+POd?=
 =?us-ascii?Q?3TEKH5P9YgGimEiIdiMAcaTnnxuFIbU33znFv7d1brN4tNzHf0T0J5ZY5bx0?=
 =?us-ascii?Q?+wASQrPWtfQBZFbdXAj9do1BsAEP2bD7y6fjCX5vKYzTq9C4r06UdWwLpErX?=
 =?us-ascii?Q?yMS6V2VNlWWvcIoJUjViD5v6RhdCpYB1jND7NMITVNNk1pCUr1qOfvifeTh/?=
 =?us-ascii?Q?ofdHOr8mB/D6u19CnxbNyk9aHU+o6zB2sznKX59PlFr/ucQk+ri8xgX77enc?=
 =?us-ascii?Q?YN8Zewu+80Udrklouj3+AGf7V0tWMDoJ0L7HH0TymEZn+KS7O/vQrZr6Mzl3?=
 =?us-ascii?Q?NoVT8MgLngaZPk4RRuuX1CWcFhpHjq3ZnEYY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:04:10.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ead7977-6b1c-4590-885e-08dd52bb498c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

In preparation for SNP, cleanup the smoke test to decouple deriving type
from policy. This enables us to reuse existing interfaces as well as
deduplicate the test calls that are called for SEV and SEV-ES.

No functional change intended.

[seanjc@google.com: deduplication of common SEV+ test calls]
Link: https://lore.kernel.org/kvm/Z6wIDsbjt2ZaiX0I@google.com/
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* Remove individual wrappers around sev and sev-es helpers
* Combine common tests and deduplicate the SEV, SEV-ES calls from the
  main function (Sean)
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


