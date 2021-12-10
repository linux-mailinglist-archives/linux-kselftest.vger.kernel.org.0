Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F214B47061D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhLJQvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:51:08 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:53409
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243935AbhLJQvH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWZ0doW7COeEektDqC7gA/ZCbb25069ahLJ4RAKo5KyPmb+NUAMfjJiM7oLHpp2h3NLfGAxJFbidXjSjMP1PXuH3IayvqUAXPlWprO83GWJL866eRkx/ur/FfcvUZM8pkjjfYePTDyWZrX02wwm/GWC1PRLMzjADeA2wUbtrTwESpZbizJPMT4ODD1qYl2tw6iyQaQ1ilCaxlxdMlbVVW7WbUU8ID8DLUs/YWP2grbn29Pil8by5YkQmvgCpEpz1rGyv0CbLOIro5W6zCj9nWNAJBZkHxMOpS9jrM/KaEFELZP3BZe6ueOdVRF92+D+0Ih5lDCmDNfoNphxdaiOsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVePAZMnyynrWGF7TPR9d4//6tOFHnhk271ltjU1AgA=;
 b=ZYMUlLeyaEfuz0ZAD5Pg7OzmMUxyHYAzuxN8A9Y8qDIkuAMyMTruv34SfmhQPqg8A1a05eccvByx/B2HnTmPg2iulLHiUOlizjM9Jz3WuAHKt435ZHrK7mK/FHPSREJ89T/GuFXhe+a8TQdMY32Qm8JsvI8v08cLbrFo+M/B1tO+BDDD2TEKK+HJ7rxBXbi95D45VNneFwsVGhDdfe8WA690jSmNrHDQTTKkLbO+uRGzPAUKkcGC9wZ6O2eae6aqB3wPntAKCaDokbIsfYPLJRbXoyJV29UaEWw4Fie95d2tScdwck4iOdxWakmbafQ+Cl5UlmlHHngLQl7Z8np6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVePAZMnyynrWGF7TPR9d4//6tOFHnhk271ltjU1AgA=;
 b=I35TrDd8iKtEfgcc1PMxeklWPrMQUn6TgGm54ll2b3qkNRy24de2S7yPSpte0tFGJ9kvnTx3UaUcvkBot+UdN+7NTSpkQqWb5lZewivMoV8KqsY2Qbyivua8nCOabd5UTiIKliyNhqqyqfkz31FlgW8YohQaTFb4gcsZsFuswvw=
Received: from DS7PR03CA0265.namprd03.prod.outlook.com (2603:10b6:5:3b3::30)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 16:47:29 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::28) by DS7PR03CA0265.outlook.office365.com
 (2603:10b6:5:3b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 16:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:47:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:47:28 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        "Steve Rutherford" <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH RFC 10/10] kvm: selftests: add ucall_test to test various ucall functionality
Date:   Fri, 10 Dec 2021 10:46:20 -0600
Message-ID: <20211210164620.11636-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210164620.11636-1-michael.roth@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d90dda22-d6ba-4a5d-9f53-08d9bbfcc0e9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55397F28F5AAE9BF9F21B2D595719@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IiJkq39z+MDrAfOtDv70LiGPCgMQ2/Vpl2iYAKEGeiNzFPuuyENuoBiH5CHX7lx823MZcXu9aqYmLXNw0dTPLK+oXriZEb2vwS+4TuLTLJnpPIN9vxUUyXFoDXvTu16jALmBz30z9DB5iRPvFl2uAxU++8v0xSLP+yxdGsahi1vTxAHuCDYZg9xd4G4TRDW95/P8cObU7j+J+0W/xQs0+yx06YoONdYQBprvBbklGAL0R2LBK0+egKcJDygETsPsw9H+6GWQy6ee8TSNljDY8CoAD7+qwxIDJvIQ539aJCW4+rvb7Zg4L2oLlKBOfE1kEWBVcvY28Nd6xdcH8MPkjdz8zyiTfl2scX1cqvBeW9BzsxI6+U+r1y23XhDXJ9tAMa4piJPcVVNpeEkX8yM2i3A8A0uL+od4O2kZEbK55UyEoJnuB0dm/ImGCP3YmgE3orZVP6cU43kuD80N4xSVtnVw13XppHfH5BegcGOEhMv5VPyC+lRgzFKzNIjd4CUCz/UNygVgP2epetfBkhRh/1PWxRRQpqJBsAiZcn/LYa4v622hjtDvJ27H3+frt/kZSpP2s8A2WRNpBgRFfJmQjITZk5f8QWx8HA/Ee9z4O5VB/ccpaKePu54Mj4SFw8uxrJkpj1XI34HZ8RRoz34X0m7mAHQJxGs0+t6Ix267wQb6POAYQ/+80E3OZJQnMQIhUYGWKf079P0jzNyiSOMNcueUfl/v4U3SXHvZLsAtcYk684uyme/+a8cqqvgt/112GbhHRwdfSwO1rJSyKC0U1kq/JgK+7JC2LDmfMV1jIdQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(70586007)(47076005)(44832011)(2616005)(54906003)(70206006)(86362001)(36860700001)(508600001)(2906002)(6666004)(7416002)(8676002)(1076003)(26005)(40460700001)(36756003)(82310400004)(16526019)(5660300002)(186003)(426003)(356005)(6916009)(316002)(8936002)(336012)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:47:29.1387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d90dda22-d6ba-4a5d-9f53-08d9bbfcc0e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests will initialize the ucall implementation in 3 main ways,
depending on the test/architecture:

 1) by relying on a default ucall implementation being available
    without the need to do any additional setup
 2) by calling ucall_init() to initialize the default ucall
    implementation
 3) by using ucall_init_ops() to initialize a specific ucall
    implementation

and in each of these cases it may use the ucall implementation to
execute the standard ucall()/get_ucall() interfaces, or the new
ucall_shared()/get_ucall_shared() interfaces.

Implement a basic self-test to exercise ucall under all the scenarios
that are applicable for a particular architecture.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/.gitignore   |   1 +
 tools/testing/selftests/kvm/Makefile     |   3 +
 tools/testing/selftests/kvm/ucall_test.c | 182 +++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/ucall_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 3763105029fb..4a801cba9c62 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -57,3 +57,4 @@
 /steal_time
 /kvm_binary_stats_test
 /system_counter_offset_test
+/ucall_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 06a02b6fa907..412de8093e6c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -88,6 +88,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
+TEST_GEN_PROGS_x86_64 += ucall_test
 
 TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
@@ -105,6 +106,7 @@ TEST_GEN_PROGS_aarch64 += rseq_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
 TEST_GEN_PROGS_aarch64 += kvm_binary_stats_test
+TEST_GEN_PROGS_aarch64 += ucall_test
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/resets
@@ -116,6 +118,7 @@ TEST_GEN_PROGS_s390x += kvm_page_table_test
 TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
+TEST_GEN_PROGS_s390x += ucall_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/ucall_test.c b/tools/testing/selftests/kvm/ucall_test.c
new file mode 100644
index 000000000000..f0e6e4e79786
--- /dev/null
+++ b/tools/testing/selftests/kvm/ucall_test.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ucall interface/implementation tests.
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "processor.h"
+
+#define VCPU_ID			2
+#define TOTAL_PAGES		512
+
+enum uc_test_type {
+	UC_TEST_WITHOUT_UCALL_INIT,
+	UC_TEST_WITH_UCALL_INIT,
+	UC_TEST_WITH_UCALL_INIT_OPS,
+	UC_TEST_WITH_UCALL_INIT_OPS_SHARED,
+	UC_TEST_MAX,
+};
+
+struct uc_test_config {
+	enum uc_test_type type;
+	const struct ucall_ops *ops;
+};
+
+static void test_ucall(void)
+{
+	GUEST_SYNC(1);
+	GUEST_SYNC(2);
+	GUEST_DONE();
+	GUEST_ASSERT(false);
+}
+
+static void check_ucall(struct kvm_vm *vm)
+{
+	struct ucall uc_tmp;
+
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(get_ucall(vm, VCPU_ID, &uc_tmp) == UCALL_SYNC, "sync failed");
+
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(get_ucall(vm, VCPU_ID, &uc_tmp) == UCALL_SYNC, "sync failed");
+
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(get_ucall(vm, VCPU_ID, &uc_tmp) == UCALL_DONE, "done failed");
+
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(get_ucall(vm, VCPU_ID, &uc_tmp) == UCALL_ABORT, "abort failed");
+}
+
+static void test_ucall_shared(struct ucall *uc)
+{
+	GUEST_SHARED_SYNC(uc, 1);
+	GUEST_SHARED_SYNC(uc, 2);
+	GUEST_SHARED_DONE(uc);
+	GUEST_SHARED_ASSERT(uc, false);
+}
+
+static void check_ucall_shared(struct kvm_vm *vm, struct ucall *uc)
+{
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 1);
+
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 2);
+
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_DONE(vm, VCPU_ID, uc);
+
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_ABORT(vm, VCPU_ID, uc);
+}
+
+static void __attribute__((__flatten__))
+guest_code(struct ucall *uc)
+{
+	if (uc)
+		test_ucall_shared(uc);
+	else
+		test_ucall();
+}
+
+static struct kvm_vm *setup_vm(void)
+{
+	struct kvm_vm *vm;
+
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, TOTAL_PAGES, 0);
+
+	/* Set up VCPU and initial guest kernel. */
+	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	return vm;
+}
+
+static void setup_vm_args(struct kvm_vm *vm, vm_vaddr_t uc_gva)
+{
+	vcpu_args_set(vm, VCPU_ID, 1, uc_gva);
+}
+
+static void run_ucall_test(const struct uc_test_config *config)
+{
+	struct kvm_vm *vm = setup_vm();
+	const struct ucall_ops *ops = config->ops;
+	bool is_default_ops = (!ops || ops == &ucall_ops_default);
+	bool shared = (config->type == UC_TEST_WITH_UCALL_INIT_OPS_SHARED);
+
+	pr_info("Testing ucall%s ops for: %s%s\n",
+		shared ? "_shared" : "",
+		ops ? ops->name : "unspecified",
+		is_default_ops ? " (via default)" : "");
+
+	if (config->type == UC_TEST_WITH_UCALL_INIT)
+		ucall_init(vm, NULL);
+	else if (config->type == UC_TEST_WITH_UCALL_INIT_OPS ||
+		 config->type == UC_TEST_WITH_UCALL_INIT_OPS_SHARED)
+		ucall_init_ops(vm, NULL, config->ops);
+
+	if (shared) {
+		struct ucall *uc;
+		vm_vaddr_t uc_gva;
+
+		/* Set up ucall buffer. */
+		uc_gva = ucall_shared_alloc(vm, 1);
+		uc = addr_gva2hva(vm, uc_gva);
+
+		setup_vm_args(vm, uc_gva);
+		check_ucall_shared(vm, uc);
+	} else {
+		setup_vm_args(vm, 0);
+		check_ucall(vm);
+	}
+
+	if (config->type == UC_TEST_WITH_UCALL_INIT)
+		ucall_uninit(vm);
+	else if (config->type == UC_TEST_WITH_UCALL_INIT_OPS ||
+		 config->type == UC_TEST_WITH_UCALL_INIT_OPS_SHARED)
+		ucall_uninit_ops(vm);
+
+	kvm_vm_free(vm);
+}
+
+static const struct uc_test_config test_configs[] = {
+#if defined(__x86_64__)
+	{ UC_TEST_WITHOUT_UCALL_INIT,		NULL },
+	{ UC_TEST_WITH_UCALL_INIT,		NULL },
+	{ UC_TEST_WITH_UCALL_INIT_OPS,		&ucall_ops_default },
+	{ UC_TEST_WITH_UCALL_INIT_OPS,		&ucall_ops_pio },
+	{ UC_TEST_WITH_UCALL_INIT_OPS_SHARED,	&ucall_ops_pio },
+	{ UC_TEST_WITH_UCALL_INIT_OPS_SHARED,	&ucall_ops_halt },
+#elif defined(__aarch64__)
+	{ UC_TEST_WITH_UCALL_INIT,		NULL },
+	{ UC_TEST_WITH_UCALL_INIT_OPS,		&ucall_ops_default },
+	{ UC_TEST_WITH_UCALL_INIT_OPS,		&ucall_ops_mmio },
+#elif defined(__s390x__)
+	{ UC_TEST_WITHOUT_UCALL_INIT,		NULL },
+	{ UC_TEST_WITH_UCALL_INIT,		NULL },
+	{ UC_TEST_WITH_UCALL_INIT_OPS,		&ucall_ops_default },
+	{ UC_TEST_WITH_UCALL_INIT_OPS,		&ucall_ops_diag501 },
+#endif
+	{ UC_TEST_MAX,				NULL },
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	for (i = 0; test_configs[i].type != UC_TEST_MAX; i++)
+		run_ucall_test(&test_configs[i]);
+
+	return 0;
+}
-- 
2.25.1

