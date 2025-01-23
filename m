Return-Path: <linux-kselftest+bounces-25049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F275A1AC54
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC87D1630BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE31CD205;
	Thu, 23 Jan 2025 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2nHyenGJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF71CAA91;
	Thu, 23 Jan 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669731; cv=fail; b=pnqkIg912VM/d3rjjZ4mAb/tRB+EP71iHVAoLZbWpRCR1YVlA2fK8pJl8ZCAfL+pVeUchM46aUBrCuPaXIsAI5XekDjb7V6kXbGn3WuIdzgy5YJHBv7Ur1llvD6XJbUwnfzDW9mQPgiuR//qCn2ZrZFkclNPfcOFCWbQgAOQ3fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669731; c=relaxed/simple;
	bh=KKR1mpQCDXA4TYk0dd5J/Rp1/USOtoo+VuoKP6fHtV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx8L0IXi3OE1g4IC9HZYOgt9SF6zWCHHkA+Fs4DeH0OSzpdreHYvHf1zbUUxu6he6lBin8qcgLdCh43aeS0uxUyEBGLr/IZQWmDnfyKiYNHl1caE4qSmEW+a3FNpWiHCOT1SMcI4jAp6HNhJyNsnIX907mgQbctt8AD8wbjMEmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2nHyenGJ; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfTkmRfT0N3tYGgil7KhXGcoIS3rQJ/4bl3cZ6QIwI4Nww5Jo0WbB8R2aP+Qg3+731ph7aJKd9k3g1wlGxXo1haNUloac3vSaTLh66nIzjGGujKAAK0kazTfnVmH0mYBz0Egjiy2wVjVRJsA6hgghM24XhNtKr0HPEzs7jLEiCp7ghcbRveFVgTAUWMRHF0d4sHgij22BVhe6BAMNvdKUiHAvevwNH46WlmKOel4kve97tJfv7rljGQ1qAdFMEEDrx0Bs/HvlhAhQ67dpm2cfQzeLXsBAkiS8uUtvxtO/fmxrw6iKrfDUwwKJFRjgWA9DbaTnif9bPQFMo9jmcETYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZjcclSsB4qTaRCWtRynJMuCA+yj5ZCReoe/Rfw0maM=;
 b=E3NezZ8E6b5s+e7Y1g7ZZQfUzUWQswDXcKkoRJQMMHbwKdmw7ReUQGCrFC9dqx9DPrAwnBrp1Q4GA44zFvVUEEo9Wm14f3pE8UQ1jb3RvbkG5AtT92Plgi3PWfif6eOVxao8HUSJBh3EbhVUx8j8WRBFPYYyMVkmcAPI425CHdz9u6WrLYoMY0+BXK1K+YlPQEg0jKXT8s47YzRiHovK5gh5aKlnAwBVcj70uwF/K47Dbyzt2UBeYHZTAoGkgJ51OyHl5BUVpi7eQcV5FoDoMubezjV9ETsp70Lw+MZrifI9ZbZyum7H942xV6F8TU34frnmZzTShSSYC0l/3FLiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZjcclSsB4qTaRCWtRynJMuCA+yj5ZCReoe/Rfw0maM=;
 b=2nHyenGJOZye1IvdkjT3tMyeANNuhnXiHVVRcPEwUyedeHEBaUWYsN2+RGfzieP8DejCxyzooYZ0C/JJoSTVLRdyh9I6FyiPOMFzPc/4rdhYYCd793Lk46QCLAsoqscMnCDeJ1rc7MTy4aClU10KqeW+IBIbBAZ7j58QLhnXRFI=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Thu, 23 Jan
 2025 22:02:05 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5d) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.10 via Frontend Transport; Thu,
 23 Jan 2025 22:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:02:05 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:02:03 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 5/9] KVM: selftests: Introduce SEV VM type check
Date: Thu, 23 Jan 2025 16:00:56 -0600
Message-ID: <20250123220100.339867-6-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: c1909a44-30c4-4a39-8974-08dd3bf992e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/hPhQSP10eTG+QgiRHZDax/Zozx1q3C/HIjz4nnWD6gOF5WlBne7fEN9SHH?=
 =?us-ascii?Q?XK96MbttFcgxIMjfWzix4MuVqhNZG6y1R+sXQEpA/VJNmknzm1MxG7Rt97fM?=
 =?us-ascii?Q?mEnOMFsxXcjlbx1i26gb7tA+ykjNA/kcG3kMxBEMvrW0LNnogWSuZ2p34F8Z?=
 =?us-ascii?Q?dkoGsXFJpxBSXTgiunBkivj2/J/9AVwK5/yKV+KCSbX4ZpJVXXSjwhCahNQ1?=
 =?us-ascii?Q?VFXGW5cCAa2r3MR4HkCxF1Zlwbt49KQU294ULamNnxYtppe35fN6mx9YFsfp?=
 =?us-ascii?Q?uxOYlWvGoBIX7YqJ9A/5TdzWsOme2Ayv6kmwbr7rkCBK9daFJjEnKvBB776R?=
 =?us-ascii?Q?9fLdaECEwx7ANODOg9YYzsMaOb6WFnN+ZB+Lgbp9lalDnx9ZwMHz8h++B0iP?=
 =?us-ascii?Q?nYr2PBsPRbb9A0mY5AOg+6IoVU6zxj5GVCcg4P6Ay3lG08DXQxGvrdxCYnOJ?=
 =?us-ascii?Q?12bHXGyocKWiB5DoVgXS2bZh36KiIfesFfMZq2AsvO3hyplZ0eq2rHr4j/Zw?=
 =?us-ascii?Q?9r+T5jx1+6wq+36phwqZRjXM9yunx0BhepnRARuAoUI973cfheXn6PBMDG8g?=
 =?us-ascii?Q?L5ODS60UDgynfIyupjNQUrMJ5pL+DlfGXUTLrEu0CbcDukKGvyK566XDzNb7?=
 =?us-ascii?Q?+1B6/SX+gySo/0rCCEWwwEZqRipkYkO6ojRiVR0BIWTt1d0RBE/E8bomialV?=
 =?us-ascii?Q?BFg+ADBdS4XZvcwS+KY6xfQ9SfvyjthFsGxXOfX6/lt6dPm8U1VTamd5kNmW?=
 =?us-ascii?Q?rEYM5mwKcnrUl+kSisW16lzk8RrT1swdMMJH8NkC3aSC0eQ6EesLtvlAWIQL?=
 =?us-ascii?Q?7dojtqPuC+e+fiwHNbcnvJpVMpx/whE3GabEQdW1L9iX/F5Y0xKlCJh5DHk6?=
 =?us-ascii?Q?zzSKAzNXU7axLEfqXQqNc0V20SusfPn/BFLMt8P2FWXR8MLbHDt5pfskOGeO?=
 =?us-ascii?Q?tZzUoGmGhui7p/3WcoAuKXN6n7PhpudUCCDc/C10agWqyokFXILEiDa2NJlr?=
 =?us-ascii?Q?2gRAYC0xWqX4ELdmwF1VcZuZ4+7PSVT2F1Uqk+20DXzlQE5EPnxYIEOKO/54?=
 =?us-ascii?Q?ZvPH03R7L5DKaCSBwqBK/c9dbiJRclJXoLeuywkJrVSDMBaWXaRRdP+xLuOv?=
 =?us-ascii?Q?Toj0vffAqVZBMY1ycHvxEy5eRStqvUw55BB5N1IDSNab6NnqWWEGl0OBQxOg?=
 =?us-ascii?Q?aOmZO755G8YrNyXk3FYUHT7fTXuJRdrHkeajxkB1U4si6IHbP+NqF8QjyqCm?=
 =?us-ascii?Q?N/Asjz5KkMYzZjw7xIuP6ycLGfbJYQD03kOPR6IWIl3cH/Pn5up6ZofV+mfU?=
 =?us-ascii?Q?Df5JEZHN/DdqLgenZlWlDvXi3vTso+vEKajnaLta5MGb+xnXDlYmemvG2J2B?=
 =?us-ascii?Q?IHkLkqiMLFWRR8ggGVjsSQLwEksOr/qy3n8NnDr69E68yr3k32SUVLjGg7GQ?=
 =?us-ascii?Q?G/l1H/LvvcxC/RD3yH7oD1mjp5fgT+Om5qf3wdmaRUBD/N+faIaSJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:02:05.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1909a44-30c4-4a39-8974-08dd3bf992e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

In preparation for SNP, declutter the vm type check by introducing a
SEV-SNP VM type check as well a transitive set of helper functions.

The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
types are subset of the SEV VM type check.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v4..v5
* Remove redundant snp check within is_sev_vm()
---
---
 tools/testing/selftests/kvm/include/x86/sev.h   |  4 ++++
 tools/testing/selftests/kvm/lib/x86/processor.c |  4 ++--
 tools/testing/selftests/kvm/lib/x86/sev.c       | 17 +++++++++++++++++
 .../testing/selftests/kvm/x86/sev_smoke_test.c  |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index e7df5d0987f6..faed91435963 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -29,6 +29,10 @@ enum sev_guest_state {
 
 #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
 
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
index e9535ee20b7f..280ec42e281b 100644
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
index 38f647fe55d2..b18c78314d5b 100644
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


