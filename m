Return-Path: <linux-kselftest+bounces-42112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E718BB94597
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657D2443E68
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02630CDBF;
	Tue, 23 Sep 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ddPNU3yc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F02E9741;
	Tue, 23 Sep 2025 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604577; cv=fail; b=PWSuQ8XBLmQtnh+qj3a1Cf/IUT26dJYMrQzUaTzf5+VvPwXSu/viujPkCZkgAtvPDlvNfuDhwu1FURKxbCvOEyErdCy0/ikAXt9nwS7vIw9eaLe/hGzIw+fdP6niGqvmemtN9R3fA3QpkHscdDfl+9FMlg7iN2F7jbF2GaYLHVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604577; c=relaxed/simple;
	bh=NgL8ZpjqU55F1d3K0/Ys0H4gYPM3wi+kC+6CNqW3Ggs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx67jd2/UhJ/J860/hSa8ek/9LCKlqQd0PvHJh8pvQ0X3YLWlj6YhNt2uca7dKG26z96iMS0sQWrHn0i8sXiab4tWHyCDamnYFbrKZxLKOLJSMat8H001tUoWZeAA0IfIj4tbzsty9gp6Dl3PMF9bPyJ2xJn8YpXevVLgh/+aJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ddPNU3yc; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZMl6NL8FtIBHsvz7FFVCvKK6UqvOy30bZ/zuUlQaQB12Bq/2BeurlIR4ER2vlRA6X5uPrgM3j41RZank0KMxytXKoJ5XCvsrKGk4kmqlOjYcj3LwlpsYx6uixhGSdzHvCo0Oevxf2fcy4b7N4xQcG1UrYCmVijtZcOBz3yS2jFA7xJNQ7xkgVvoLIDgjxSN6ulI37ZQU2g7fS8odmYFT3aOr9QaNT44lA3XaKjUgzQ8siZIidtQqJWvfW32Qz2H43zU/ONN2Bn3efO7guWAJCd0TptRN/COJgjYEGYJ7VVEF2nm78HpPC30mQM0K8BmRobebJSdAeMZSKgo/xMXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH6eC59Wn+K/0tK/CRZhm+gtcNjeYclYdoBj4dr8FNs=;
 b=tKQdb6J1Pe+0M+J6bRWbxcTwyVMxm9F+BSw3GMJwdw4/CagWKHpymnx8UxXSKgrKGJw6uQCPgk2Rnre4kwgFKdsADlZmuC6hoeaa3+wIlmmv1VCvj14K1D1CFO4iIC2R0Xe8DOiBYuRw1GpXRKcxMvcta+Olt26a2GzLz+QBsBn3zq3TVpAiQw7oHGZkdp7Wj1PRwhOcYcIsW0n91Lj7ufK5kJ+1p/RALpEKa07KHxwNqktbxwriHa7fCGpt6zR5iG48Szf+yDft3AdKO8USomh1M+vF80T/kiKpHWG4Szkw6ohlXdcDnp6ZwGzXtNWIxl8Sdv3a/BSYEoFoiqb8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH6eC59Wn+K/0tK/CRZhm+gtcNjeYclYdoBj4dr8FNs=;
 b=ddPNU3ycQANxW6i3fdft1/q8DUkrtugaRhGLJ2QvSx4Ibg9+KBVWo3gnjBYRJWIHxwLdC9GLmm8uo4e/RiAcndSNWYroDXYAw8wyv6LJ2s0FEluTO8PYjJSjs912TCpbbq6PA3c1NvyrQZBX34EUC+al6sWZ71yUq0tl51paR3w=
Received: from CH2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:5a::28)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:16:11 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::3a) by CH2PR08CA0018.outlook.office365.com
 (2603:10b6:610:5a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 05:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:16:10 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:16:03 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 21/35] KVM: selftests: Add SEV guest support in xapic_state_test
Date: Tue, 23 Sep 2025 10:39:28 +0530
Message-ID: <20250923050942.206116-22-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 362a5ab2-13ef-4fe8-cd88-08ddfa604f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNKRxRLThDt84Vo57yy66kmoTxQCBMdrFavnOTA6RKU/Ts/Jg8djb9d29r8c?=
 =?us-ascii?Q?yPr6QCS24kKdNeVjX4A4D6SGhCQls2d5QwLBPKOZBxy7qs5+BHV5qx78bjx6?=
 =?us-ascii?Q?V2B/zBcg7mbzBmfKnrT6zaINCQWiMfv6ihf8t709i+kE+qFdVOf6Na9qqMrG?=
 =?us-ascii?Q?+OqolrYQW5fLv2Jj/YfwpeIB+tqBi5fnP0p38BAZ2MQn1zy8uBWupHcrrcRJ?=
 =?us-ascii?Q?VT60jf9QpEwUfualSQs+OE/7reDFhpuPSe6FaoiBJ8a6fzC6SUANKyXhKMGP?=
 =?us-ascii?Q?hS48lUY9ZDo6LL/K4uJfbBeGANMUe5IAj1k4Pew6QRIIfq3TabD6KjWUnLNr?=
 =?us-ascii?Q?zMJzHS8mFEOzqyuWFWW6QeoZJ90u/XAs/ypzFwhQeVS5Y13ssrEsQgcE5DoC?=
 =?us-ascii?Q?knZN39PDRV1h5qdppCbD1V1Cxsa+YIR0YVacE/k3CTZ+sMOnsOk5VqNCaZ5r?=
 =?us-ascii?Q?m8aOVF2irVOUmQj1Jczhlg307OKtFISiJa+vzd1V5nH0AZBdf5UHn1ZJAPw0?=
 =?us-ascii?Q?VP+hMnr5AOZFIGo13IS8IC8unFg9q+l40NZq4hm2X34dRQfYuKMJn88H8aBm?=
 =?us-ascii?Q?d0ReV8DepEyH9GBGHJYWjcwfOKCzUZVKrZSM0BrXts99cc2AsQuEFIqTKAwe?=
 =?us-ascii?Q?zLiyGDPBK/zQPyOR2ZFZhnYOQdpfG80FMvanRNRFPVPc67abznkr64G4MHIz?=
 =?us-ascii?Q?pqPgiF9BmhsY2XudQDsXOVln4UE5rE7zw4kZX3h8n1iK6YhxqYFjC4lx+AxQ?=
 =?us-ascii?Q?Wxwjwqt92GXqtHEbC8GnwyBl9AmljkP9qGjroZxwvWva94A9PHln4dFpuefN?=
 =?us-ascii?Q?UgsWRD57TWJ0zkffnbRspXhF19+ptozMMgRWeFtmUyeKELNU4sEtkXycwZym?=
 =?us-ascii?Q?V8Uzg7ht82XkugnvLi40nyzRXZ8M8FHzFQUvtf70wlSzenvzGQKHP7ENoxZM?=
 =?us-ascii?Q?CBSHuEnPPFvwIv2gVbFyW6xftGC2prtVSNQiSBgf5zz68NqiI7I3MyodKvxc?=
 =?us-ascii?Q?cMbg7Nf6Qrah5AHSBJGhTf43uDnjjOpy1zsRprc/CdTTce2yP8q0ctyj5YiG?=
 =?us-ascii?Q?o3vqbGQkpISikNcNeiu7DKuSfkpMKFAZYgkp4IW5UApGyU9GgSKywOZBVgrc?=
 =?us-ascii?Q?Ajm7ytUuKKegQ8XgBmg+7RxCuqzxHzQdfyOkuoDdo2SiYAQ0XQsnNoczo9SN?=
 =?us-ascii?Q?R0MNV9k6oEA7zYXmroDujN5e5+G0tflA/givz7iQBDC5heA49b3WKNZZp9ID?=
 =?us-ascii?Q?wGXss0iqv+BRQSDoTTFDrEZcbDidg5G5URU1XgTDbAxUSltuSCWjVapTZBZt?=
 =?us-ascii?Q?v/J3olV+FrSnLQva/0V3ZKZZWkwpbW03cRKSGnswjr0ZdIuULfu5bGPde+6w?=
 =?us-ascii?Q?CgrQGXGlpvdivVNgJDvd9tfppcauFr5FW+nvKmwoDS2J0dcL3/ZGYZFo9Y8R?=
 =?us-ascii?Q?WNmH/L1UupmJWm3YaWdUZoBwO63hqD7Th+y9kDN9wlNIsTbjY8/u91/bOrWB?=
 =?us-ascii?Q?0To/+mU20WZz80IB4FR0in2ynpQxU4eaZI3+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:16:10.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362a5ab2-13ef-4fe8-cd88-08ddfa604f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

The xapic_state_test validates the behavior of the local APIC across
different states and modes (xAPIC vs. x2APIC). Previously, this test
only ran on standard, unencrypted VMs.

With the recent addition of a #VC handler to emulate MMIO accesses for
SEV-ES guests, the necessary infrastructure is in place to test APIC
functionality within encrypted environments.

Extend xapic_state_test to support SEV, SEV-ES, and SNP guests. This
provides crucial regression testing for APIC functionality in these
confidential computing environments.

The test functions are refactored to handle the new VM setup flow,
enabling existing APIC tests to run transparently on encrypted guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/x86/xapic_state_test.c      | 117 ++++++++++++++++--
 1 file changed, 109 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools/testing/selftests/kvm/x86/xapic_state_test.c
index fdebff1165c7..91f593ef22dc 100644
--- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
@@ -9,6 +9,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "test_util.h"
+#include "sev.h"
 
 struct xapic_vcpu {
 	struct kvm_vcpu *vcpu;
@@ -160,6 +161,27 @@ static void __test_apic_id(struct kvm_vcpu *vcpu, uint64_t apic_base)
 		    expected, apic_id);
 }
 
+static inline bool is_sev_vm_type(int type)
+{
+	return type == KVM_X86_SEV_VM ||
+		type == KVM_X86_SEV_ES_VM ||
+		type == KVM_X86_SNP_VM;
+}
+
+static inline uint64_t get_sev_policy(int vm_type)
+{
+	switch (vm_type) {
+	case KVM_X86_SEV_VM:
+		return SEV_POLICY_NO_DBG;
+	case KVM_X86_SEV_ES_VM:
+		return SEV_POLICY_ES;
+	case KVM_X86_SNP_VM:
+		return snp_default_policy();
+	default:
+		return 0;
+	}
+}
+
 /*
  * Verify that KVM switches the APIC_ID between xAPIC and x2APIC when userspace
  * stuffs MSR_IA32_APICBASE.  Setting the APIC_ID when x2APIC is enabled and
@@ -168,16 +190,22 @@ static void __test_apic_id(struct kvm_vcpu *vcpu, uint64_t apic_base)
  * attempted to transition from x2APIC to xAPIC without disabling the APIC is
  * architecturally disallowed.
  */
-static void test_apic_id(void)
+static void test_apic_id(int vm_type)
 {
 	const uint32_t NR_VCPUS = 3;
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	uint64_t apic_base;
 	struct kvm_vm *vm;
 	int i;
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = vm_type,
+	};
 
-	vm = vm_create_with_vcpus(NR_VCPUS, NULL, vcpus);
+	vm = __vm_create_with_vcpus(shape, NR_VCPUS, 0, NULL, vcpus);
 	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);
+	if (is_sev_vm(vm))
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
 
 	for (i = 0; i < NR_VCPUS; i++) {
 		apic_base = vcpu_get_msr(vcpus[i], MSR_IA32_APICBASE);
@@ -195,15 +223,21 @@ static void test_apic_id(void)
 	kvm_vm_free(vm);
 }
 
-static void test_x2apic_id(void)
+static void test_x2apic_id(int vm_type)
 {
 	struct kvm_lapic_state lapic = {};
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int i;
+	bool is_sev = is_sev_vm_type(vm_type);
 
-	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, NULL, &vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	vcpu_set_msr(vcpu, MSR_IA32_APICBASE, MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
 
 	/*
 	 * Try stuffing a modified x2APIC ID, KVM should ignore the value and
@@ -222,6 +256,46 @@ static void test_x2apic_id(void)
 	kvm_vm_free(vm);
 }
 
+void get_cmdline_args(int argc, char *argv[], int *vm_type)
+{
+	for (;;) {
+		int opt = getopt(argc, argv, "t:");
+
+		if (opt == -1)
+			break;
+		switch (opt) {
+		case 't':
+			*vm_type = parse_size(optarg);
+			switch (*vm_type) {
+			case KVM_X86_DEFAULT_VM:
+				break;
+			case KVM_X86_SEV_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
+				break;
+			case KVM_X86_SEV_ES_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_ES));
+				break;
+			case KVM_X86_SNP_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
+				break;
+			default:
+				TEST_ASSERT(false, "Unsupported VM type :%d",
+					    *vm_type);
+			}
+			break;
+		default:
+			TEST_ASSERT(false,
+				    "Usage: -t <vm type>. Default is %d.\n"
+				    "Supported values:\n"
+				    "0 - default\n"
+				    "2 - SEV\n"
+				    "3 - SEV-ES\n"
+				    "4 - SNP",
+				    KVM_X86_DEFAULT_VM);
+		}
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	struct xapic_vcpu x = {
@@ -229,8 +303,24 @@ int main(int argc, char *argv[])
 		.is_x2apic = true,
 	};
 	struct kvm_vm *vm;
+	int vm_type = KVM_X86_DEFAULT_VM;
+	bool is_sev;
+
+	get_cmdline_args(argc, argv, &vm_type);
+	is_sev = is_sev_vm_type(vm_type);
+
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, x2apic_guest_code,
+				&x.vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
+
+	if (is_sev_es_vm(vm))
+		vm_install_exception_handler(vm, 29, sev_es_vc_handler);
+
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
 
-	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
 	test_icr(&x);
 	kvm_vm_free(vm);
 
@@ -239,7 +329,15 @@ int main(int argc, char *argv[])
 	 * the guest in order to test AVIC.  KVM disallows changing CPUID after
 	 * KVM_RUN and AVIC is disabled if _any_ vCPU is allowed to use x2APIC.
 	 */
-	vm = vm_create_with_one_vcpu(&x.vcpu, xapic_guest_code);
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, xapic_guest_code,
+				&x.vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&x.vcpu, xapic_guest_code);
+
+	if (is_sev_es_vm(vm))
+		vm_install_exception_handler(vm, 29, sev_es_vc_handler);
+
 	x.is_x2apic = false;
 
 	/*
@@ -254,9 +352,12 @@ int main(int argc, char *argv[])
 	vcpu_clear_cpuid_feature(x.vcpu, X86_FEATURE_X2APIC);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
+
 	test_icr(&x);
 	kvm_vm_free(vm);
 
-	test_apic_id();
-	test_x2apic_id();
+	test_apic_id(vm_type);
+	test_x2apic_id(vm_type);
 }
-- 
2.34.1


