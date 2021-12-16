Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE8477A6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhLPRTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:19:19 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:61504
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240193AbhLPRTK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:19:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+Qrho3d1C2vTNHi4L7J30vAK2NjchWqnlNYbIiDmZ0PpoIq/ygxAxhsnV/TftrUWVFAvsZYPZ8BIcG/e8MVsJfPa9QSqRjHOqvTQDaDM4rOnIpyDLJRjb/3sk8s1I80JUfVMccXwHFlraN0xQn88kLky3jjOwDfg/nfmfZIhUPjDcFteFn5QnSH4C9QptwXRAYowUAMzODtJidq3RB94jzPgfcGkIG+8dwemSKe3ukdI6FT8ALiULqZ3qZ9Bd0cRdVczzRBF8Y8r5h0wddXgua+nMxWOT6agKjK15fnl6qnB2xdR7k+3n5l8BLMg9IFzcy3Fl+jJ2xwjfMF/SSVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKcUBU4zbAu0FvRRdq6cBfs8I35aNIMc2lVXVRAXHwY=;
 b=Ofq878hPFgs06DFrUvEMCTL86DDqOPb4hjDo9H++FvF8HmifAC6eNJNMfJPhywH5XcNczeMTbhhxcRr5d2jZNaZ4vIegfOoaRuyRr/32gM4p2iJperZH/lTY8dktLbCTM8BwJ8DTwdUVaGI7VxyTVaXlRW8E3rRUkEaeluJuYnpFmf/lg46ph3q0FAVdgIpWQ6WvdkZVciR1vWwHTJZzb+4meQl/+YbN9nxh67shExRKNicghWbU6YRSZh6O62/yPIb74Mg0XbSi3FGD2cmIyzhzjezpZm3TzZH+WxutKUJacL4vIex8/tsnslrgMHBKae+X2q+679/1NzZVWGs9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKcUBU4zbAu0FvRRdq6cBfs8I35aNIMc2lVXVRAXHwY=;
 b=2oeUOdlkOjO2fPKo5npUWSoBoH5LKTmn0dlThSqJYSMIZ+LvQhbP8ozLqt8iS7YkJXcSpdj46kYF2IYMNZ4An6MzdE/YkoPJSnF2y94zDpxbLtbPMuaukYumPXUwuKFD/9KrcgE7Qn9MMsE1KwKVfVViMxSevtUJSODX4WQJHeU=
Received: from MWHPR17CA0051.namprd17.prod.outlook.com (2603:10b6:300:93::13)
 by MWHPR1201MB0144.namprd12.prod.outlook.com (2603:10b6:301:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:19:07 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::d2) by MWHPR17CA0051.outlook.office365.com
 (2603:10b6:300:93::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Thu, 16 Dec 2021 17:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Thu, 16 Dec 2021 17:19:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:19:05 -0600
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: [PATCH v2 08/13] KVM: selftests: add SEV boot tests
Date:   Thu, 16 Dec 2021 11:13:53 -0600
Message-ID: <20211216171358.61140-9-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216171358.61140-1-michael.roth@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edeac225-2507-4158-eb5f-08d9c0b82abb
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0144:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0144A38A13063E3161D24C8495779@MWHPR1201MB0144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsMJrNdXAj+GG4V6casFtPULtHQvd2JVy+lRnlHCLIM+vWGrlFdl/Q7b3fF9g/yTGsuodScif7pkwNzGXJXL7+OzKl5cv+61ICVY666H8/VA3aJzQgr+WvFltB39USGCM741unxRXq2TwGmZNlwkx5JDVMXITKqF+DTSWDeZUIcjzwu841aC0FzqRqz+b4+Z/UIaxpBByUc9d68vObeg5JbbTVulrk7QRN5LbWsfKDrSRZla8NM0klpI78ayqI6bs7BaFNl+V3taAtMPoF0a/rGAYUx6Bp1dgvGEBxyhepH+ZAiEufMIA0BkeUmIIqV3LIYFzyqFFjQRGm4R0g2qdJNey/vfF+WOJrz+MX7j7gvzsX6fUgr+FrbdLJPVG250GAT94RWovwx/U2KsOxy0BQGcnOoOWWhfFRtLi9amFwYHr6B4bV5PNm4NpyLCtEsyuGmcGnwHxMMTJEtiQ84AJbmULmawfEgHTbUYx1VwIKlryyAL4xrHBypUPKsDSTrIlAskQ8g7eg1ezTDau7a7TzKcdWxnhso0p+mnjUqYOYB98GNPt/oNsmwcxNg0HiPkVS4msTk3wZovnQ6Y97wiq5OjBpkRKRWq1EK7io5Dw2g6U6ZBzZCLT6VuTjf1vyHy/WgjAO/lOg3WvT3qNtk0Hnt3D/tMaZ9GR+fn4+w4FwpAja/R87JlTefUFhyiESGQamdHe8fg+jAFbyRm5NdbOql/9NiQA3wuVnWFiRWePRiHAKsi3wo2juxBDxnl70qgHhGuIT4a0GOHULgPLok4x0BdXePQiH2pQRPE8cerklQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7416002)(81166007)(6916009)(70206006)(70586007)(8936002)(8676002)(356005)(5660300002)(47076005)(1076003)(83380400001)(426003)(316002)(2906002)(4326008)(86362001)(36860700001)(2616005)(82310400004)(336012)(40460700001)(186003)(54906003)(508600001)(16526019)(44832011)(36756003)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:19:07.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edeac225-2507-4158-eb5f-08d9c0b82abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0144
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A common aspect of booting SEV guests is checking related CPUID/MSR
bits and accessing shared/private memory. Add a basic test to cover
this.

This test will be expanded to cover basic boot of SEV-ES and SEV-SNP in
subsequent patches.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 255 ++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 4a801cba9c62..cc73de938a2a 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -43,6 +43,7 @@
 /x86_64/xen_vmcall_test
 /x86_64/xss_msr_test
 /x86_64/vmx_pmu_msrs_test
+/x86_64/sev_all_boot_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ccc382a827f1..6f250e190fde 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -81,6 +81,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
+TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
new file mode 100644
index 000000000000..329a740a7cb2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Basic SEV boot tests.
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
+#include "svm_util.h"
+#include "linux/psp-sev.h"
+#include "sev.h"
+
+#define VCPU_ID			2
+#define PAGE_SIZE		4096
+#define PAGE_STRIDE		32
+
+#define SHARED_PAGES		8192
+#define SHARED_VADDR_MIN	0x1000000
+
+#define PRIVATE_PAGES		2048
+#define PRIVATE_VADDR_MIN	(SHARED_VADDR_MIN + SHARED_PAGES * PAGE_SIZE)
+
+#define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
+
+static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
+{
+	int i, j;
+
+	for (i = 0; i < pages; i++)
+		for (j = 0; j < PAGE_SIZE; j += stride)
+			buf[i * PAGE_SIZE + j] = val;
+}
+
+static bool check_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
+{
+	int i, j;
+
+	for (i = 0; i < pages; i++)
+		for (j = 0; j < PAGE_SIZE; j += stride)
+			if (buf[i * PAGE_SIZE + j] != val)
+				return false;
+
+	return true;
+}
+
+static void guest_test_start(struct ucall *uc)
+{
+	/* Initial guest check-in. */
+	GUEST_SHARED_SYNC(uc, 1);
+}
+
+static void test_start(struct kvm_vm *vm, struct ucall *uc)
+{
+	vcpu_run(vm, VCPU_ID);
+
+	/* Initial guest check-in. */
+	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 1);
+}
+
+static void
+guest_test_common(struct ucall *uc, uint8_t *shared_buf, uint8_t *private_buf)
+{
+	bool success;
+
+	/* Initial check-in for common. */
+	GUEST_SHARED_SYNC(uc, 100);
+
+	/* Ensure initial shared pages are intact. */
+	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
+	GUEST_SHARED_ASSERT(uc, success);
+
+	/* Ensure initial private pages are intact/encrypted. */
+	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
+	GUEST_SHARED_ASSERT(uc, success);
+
+	/* Ensure host userspace can't read newly-written encrypted data. */
+	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
+
+	GUEST_SHARED_SYNC(uc, 101);
+
+	/* Ensure guest can read newly-written shared data from host. */
+	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
+	GUEST_SHARED_ASSERT(uc, success);
+
+	/* Ensure host can read newly-written shared data from guest. */
+	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
+
+	GUEST_SHARED_SYNC(uc, 102);
+}
+
+static void
+test_common(struct kvm_vm *vm, struct ucall *uc,
+		  uint8_t *shared_buf, uint8_t *private_buf)
+{
+	bool success;
+
+	/* Initial guest check-in. */
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 100);
+
+	/* Ensure initial private pages are intact/encrypted. */
+	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
+	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
+
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 101);
+
+	/* Ensure host userspace can't read newly-written encrypted data. */
+	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
+	TEST_ASSERT(!success, "Modified guest memory not encrypted!");
+
+	/* Ensure guest can read newly-written shared data from host. */
+	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
+
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 102);
+
+	/* Ensure host can read newly-written shared data from guest. */
+	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
+	TEST_ASSERT(success, "Host can't read shared guest memory!");
+}
+
+static void
+guest_test_done(struct ucall *uc)
+{
+	GUEST_SHARED_DONE(uc);
+}
+
+static void
+test_done(struct kvm_vm *vm, struct ucall *uc)
+{
+	vcpu_run(vm, VCPU_ID);
+	CHECK_SHARED_DONE(vm, VCPU_ID, uc);
+}
+
+static void __attribute__((__flatten__))
+guest_sev_code(struct ucall *uc, uint8_t *shared_buf, uint8_t *private_buf)
+{
+	uint32_t eax, ebx, ecx, edx;
+	uint64_t sev_status;
+
+	guest_test_start(uc);
+
+	/* Check SEV CPUID bit. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	GUEST_SHARED_ASSERT(uc, eax & (1 << 1));
+
+	/* Check SEV MSR bit. */
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	GUEST_SHARED_ASSERT(uc, (sev_status & 0x1) == 1);
+
+	guest_test_common(uc, shared_buf, private_buf);
+
+	guest_test_done(uc);
+}
+
+static struct sev_vm *
+setup_test_common(void *guest_code, uint64_t policy, struct ucall **uc,
+		  uint8_t **shared_buf, uint8_t **private_buf)
+{
+	vm_vaddr_t uc_vaddr, shared_vaddr, private_vaddr;
+	uint8_t measurement[512];
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+	int i;
+
+	sev = sev_vm_create(policy, TOTAL_PAGES);
+	if (!sev)
+		return NULL;
+	vm = sev_get_vm(sev);
+
+	/* Set up VCPU and initial guest kernel. */
+	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	/* Set up shared ucall buffer. */
+	uc_vaddr = ucall_shared_alloc(vm, 1);
+
+	/* Set up buffer for reserved shared memory. */
+	shared_vaddr = vm_vaddr_alloc_shared(vm, SHARED_PAGES * PAGE_SIZE,
+					     SHARED_VADDR_MIN);
+	*shared_buf = addr_gva2hva(vm, shared_vaddr);
+	fill_buf(*shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
+
+	/* Set up buffer for reserved private memory. */
+	private_vaddr = vm_vaddr_alloc(vm, PRIVATE_PAGES * PAGE_SIZE,
+				       PRIVATE_VADDR_MIN);
+	*private_buf = addr_gva2hva(vm, private_vaddr);
+	fill_buf(*private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
+
+	/* Set up guest params. */
+	vcpu_args_set(vm, VCPU_ID, 4, uc_vaddr, shared_vaddr, private_vaddr);
+
+	/*
+	 * Hand these back to test harness, translation is needed now since page
+	 * table will be encrypted after SEV VM launch.
+	 */
+	*uc = addr_gva2hva(vm, uc_vaddr);
+	*shared_buf = addr_gva2hva(vm, shared_vaddr);
+	*private_buf = addr_gva2hva(vm, private_vaddr);
+
+	/* Allocations/setup done. Encrypt initial guest payload. */
+	sev_vm_launch(sev);
+
+	/* Dump the initial measurement. A test to actually verify it would be nice. */
+	sev_vm_launch_measure(sev, measurement);
+	pr_info("guest measurement: ");
+	for (i = 0; i < 32; ++i)
+		pr_info("%02x", measurement[i]);
+	pr_info("\n");
+
+	sev_vm_launch_finish(sev);
+
+	return sev;
+}
+
+static void test_sev(void *guest_code, uint64_t policy)
+{
+	uint8_t *shared_buf, *private_buf;
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+	struct ucall *uc;
+
+	sev = setup_test_common(guest_code, policy, &uc, &shared_buf, &private_buf);
+	if (!sev)
+		return;
+	vm = sev_get_vm(sev);
+
+	/* Guest is ready to run. Do the tests. */
+	test_start(vm, uc);
+	test_common(vm, uc, shared_buf, private_buf);
+	test_done(vm, uc);
+
+	sev_vm_free(sev);
+}
+
+int main(int argc, char *argv[])
+{
+	/* SEV tests */
+	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_code, 0);
+
+	return 0;
+}
-- 
2.25.1

