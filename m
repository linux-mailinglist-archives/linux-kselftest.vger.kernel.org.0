Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1432477A67
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhLPRSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:18:51 -0500
Received: from mail-mw2nam08on2084.outbound.protection.outlook.com ([40.107.101.84]:9107
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235807AbhLPRSu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:18:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/CpB2kq2Q86/8PZVIXgQBQ+KBWFUSxr0TylcgIG0Y0fA01e6mlDkuiC5mgMyPez9109s4fZ14vB/tGXuJT8l330z0JWze1Y/HCQpZQhJ93MmObC/IWqPN4Eg02/gEr+8uNo4JhhE8GAvwL3w/myMD03notKPoKzrqI+wr/VjXHYygH5+75WrH71pt+g5XPORSONmO7w8gAZdBk6s2lxmVWtNjlyp8i/nJt9llZwaaB7kB4GP0F70W9EKlJY8+gQrE+AZhxZViN9R3iyS1mpgH2ybu3A428HUSJKFjLblp+F3zXYl/BBaEdjLw9wbvubuJbIsDqWdj2qS8ZNXRAP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFfZhGFN66+QWWYSKv5ywbdVukOhsQS8QZefG2AoLTg=;
 b=nWTBNT9f6pk5MHDUXT6xc7KFFQMkhbsNi5O92lEAT2Wx5ZCYcZNAaj2c+5U3d98daaFwqGMk8UUiSzLxFP9hYA7Ojxkp5uPf/mKigye1IfncadzmJmOldufPnVzasHg+cFkbmGBHfrVeWWZk3AwqUnuLTRIYhhO6H1BxhxoyGniyFdM/yeTsQSfxOPHTNZACLHetpmbzKh3LEABxiL/yi1dlhpok9+2GqAXIdqU1KqN/rR+J323bPkrEAP6Ho7zzSwzn3JfkKGh/YceuG7RDJ6tUKJLKmez2/nf1wknTn2nDC/VGoKgKUqBbD4wSjxthB6XzN2ZAFnwlFRwtslJLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFfZhGFN66+QWWYSKv5ywbdVukOhsQS8QZefG2AoLTg=;
 b=VXn7JrD2cw7o1IV7zQWrgvyQagNqsh6BnHPjCk7jKy+rGHca4U93F5x64Ms9pNrRwl2VDNIgj93vonSc1Mpw2E1qC53GD/COtS1lxOin7e0UCBiqEAFxf9b2tizQEG9B+F8xk85xXiNsweC8lFsPAkYtF3CNkm4JJ6pEHhAIaGU=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:18:46 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::9d) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Thu, 16 Dec 2021 17:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:18:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:18:44 -0600
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
Subject: [PATCH v2 07/13] KVM: selftests: add library for creating/interacting with SEV guests
Date:   Thu, 16 Dec 2021 11:13:52 -0600
Message-ID: <20211216171358.61140-8-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f841ae3a-b5d9-49ac-3800-08d9c0b81e1d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1459931C99D691DB7AF7831995779@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIdL5phAzTxFm8c8d7QzTdBy5RGGNR3hJsU7DBqqrKgLkmLBt2+MvhpxA8OnDYCnCtQq4tP7aJBdZZ0N54J/dQ94IQosP4Imd/insgT5L7VhBHB4wbmPLYABAL7P4rDsBbFLLulB4ZzUugAuGufehUDEdatvoL8sVowJTHN0MZ7Zg6Fmu+FXQUzfhKePteLrGilROU4SmaZgja+6q8oW1Dq7PsaN1g8rTcRb3vePLAHhE57jaGCXdvPIhRyTHKkaRFYXWrvH+Hk4IbQBPknDgZC4qod6NJUePa9cw8gu7tbhkLODYWFjh58TSptzlHjz5XnPzkrgH2+PG8hTcX/o2DzoB2OQdsmRgcsrEKfVIPvYDsQFZB+VFEWpv8lAqCyzL9z4zRl8IyHUbRamc4eNE3NvGfNJue79qP9VeEo0hnPgaEGE3bwCkyznRo0eMPpyxkfrM1duLivclp0CMySpiG6kwXmhWTTaWquCN4ieRHkLjambbjSQ/mvw/UzV4tULjVVsWGMfq9Xs+cLPffQ5HM1HP6UlRA0CagdEaotf3WlYg7mmfJBC4AXKl35i0Gan7p27eD0U3NEDtTuoY5L4fFNfFU3nxJz+Oj1QixSeQn3DiYAPvx9V4YoWPJ2NeB+WIx+ZwoltBioXtJuONHF25On5FbRi8mUuTxzdpyFwFPP1oKYeB+BtqPDviiccGrr4GEz4YUhl6zuxv4TGu0SATfLYxJDtwe/QsFTQt0r8v1OGxUnobzCZPk7sZHvbYKa8Z1v30QU8YNb3veKtJtkySGFTymsCbIWi0xzmTO5m2vQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(70586007)(4326008)(36860700001)(54906003)(5660300002)(316002)(83380400001)(8676002)(2906002)(1076003)(26005)(7416002)(70206006)(30864003)(8936002)(6916009)(81166007)(2616005)(186003)(336012)(86362001)(426003)(47076005)(44832011)(356005)(36756003)(16526019)(508600001)(40460700001)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:18:45.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f841ae3a-b5d9-49ac-3800-08d9c0b81e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add interfaces to allow tests to create/manage SEV guests. The
additional state associated with these guests is encapsulated in a new
struct sev_vm, which is a light wrapper around struct kvm_vm. These
VMs will use vm_set_memory_encryption() and vm_get_encrypted_phy_pages()
under the covers to configure and sync up with the core kvm_util
library on what should/shouldn't be treated as encrypted memory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   9 +-
 .../selftests/kvm/include/x86_64/sev.h        |  44 ++++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 245 ++++++++++++++++++
 3 files changed, 297 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 412de8093e6c..ccc382a827f1 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -33,8 +33,14 @@ ifeq ($(ARCH),s390)
 	UNAME_M := s390x
 endif
 
+# On some systems the SEV device path may not be present in the standard
+# location, so allow it to be configured via, e.g.:
+#   make TARGETS=kvm SEV_PATH=/path/to/sev_device ...
+SEV_PATH=/dev/sev
+
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c lib/ucall_common.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
+LIBKVM_x86_64 += lib/x86_64/sev.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
@@ -134,7 +140,8 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I..
+	-I$(<D) -Iinclude/$(UNAME_M) -I.. \
+	-DSEV_DEV_PATH=\"$(SEV_PATH)\"
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
new file mode 100644
index 000000000000..2f7f7c741b12
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers used for SEV guests
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+#ifndef SELFTEST_KVM_SEV_H
+#define SELFTEST_KVM_SEV_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include "kvm_util.h"
+
+/* Makefile might set this separately for user-overrides */
+#ifndef SEV_DEV_PATH
+#define SEV_DEV_PATH		"/dev/sev"
+#endif
+
+#define SEV_FW_REQ_VER_MAJOR	0
+#define SEV_FW_REQ_VER_MINOR	17
+
+#define SEV_POLICY_NO_DBG	(1UL << 0)
+#define SEV_POLICY_ES		(1UL << 2)
+
+enum {
+	SEV_GSTATE_UNINIT = 0,
+	SEV_GSTATE_LUPDATE,
+	SEV_GSTATE_LSECRET,
+	SEV_GSTATE_RUNNING,
+};
+
+struct sev_vm;
+
+void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data);
+struct kvm_vm *sev_get_vm(struct sev_vm *sev);
+uint8_t sev_get_enc_bit(struct sev_vm *sev);
+
+struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages);
+void sev_vm_free(struct sev_vm *sev);
+void sev_vm_launch(struct sev_vm *sev);
+void sev_vm_launch_measure(struct sev_vm *sev, uint8_t *measurement);
+void sev_vm_launch_finish(struct sev_vm *sev);
+
+#endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
new file mode 100644
index 000000000000..4a99862d62e6
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helpers used for SEV guests
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include "kvm_util.h"
+#include "linux/psp-sev.h"
+#include "processor.h"
+#include "sev.h"
+
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		(1UL << PAGE_SHIFT)
+
+struct sev_vm {
+	struct kvm_vm *vm;
+	int fd;
+	int enc_bit;
+	uint32_t sev_policy;
+};
+
+/* Common SEV helpers/accessors. */
+
+struct kvm_vm *sev_get_vm(struct sev_vm *sev)
+{
+	return sev->vm;
+}
+
+uint8_t sev_get_enc_bit(struct sev_vm *sev)
+{
+	return sev->enc_bit;
+}
+
+void sev_ioctl(int sev_fd, int cmd, void *data)
+{
+	int ret;
+	struct sev_issue_cmd arg;
+
+	arg.cmd = cmd;
+	arg.data = (unsigned long)data;
+	ret = ioctl(sev_fd, SEV_ISSUE_CMD, &arg);
+	TEST_ASSERT(ret == 0,
+		    "SEV ioctl %d failed, error: %d, fw_error: %d",
+		    cmd, ret, arg.error);
+}
+
+void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data)
+{
+	struct kvm_sev_cmd arg = {0};
+	int ret;
+
+	arg.id = cmd;
+	arg.sev_fd = sev->fd;
+	arg.data = (__u64)data;
+
+	ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_OP, &arg);
+	TEST_ASSERT(ret == 0,
+		    "SEV KVM ioctl %d failed, rc: %i errno: %i (%s), fw_error: %d",
+		    cmd, ret, errno, strerror(errno), arg.error);
+}
+
+/* Local helpers. */
+
+static void
+sev_register_user_region(struct sev_vm *sev, void *hva, uint64_t size)
+{
+	struct kvm_enc_region range = {0};
+	int ret;
+
+	pr_debug("%s: hva: %p, size: %lu\n", __func__, hva, size);
+
+	range.addr = (__u64)hva;
+	range.size = size;
+
+	ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_REG_REGION, &range);
+	TEST_ASSERT(ret == 0, "failed to register user range, errno: %i\n", errno);
+}
+
+static void
+sev_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
+{
+	struct kvm_sev_launch_update_data ksev_update_data = {0};
+
+	pr_debug("%s: addr: 0x%lx, size: %lu\n", __func__, gpa, size);
+
+	ksev_update_data.uaddr = (__u64)addr_gpa2hva(sev->vm, gpa);
+	ksev_update_data.len = size;
+
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_DATA, &ksev_update_data);
+}
+
+static void sev_encrypt(struct sev_vm *sev)
+{
+	const struct sparsebit *enc_phy_pages;
+	struct kvm_vm *vm = sev->vm;
+	sparsebit_idx_t pg = 0;
+	vm_paddr_t gpa_start;
+	uint64_t memory_size;
+
+	/* Only memslot 0 supported for now. */
+	enc_phy_pages = vm_get_encrypted_phy_pages(sev->vm, 0, &gpa_start, &memory_size);
+	TEST_ASSERT(enc_phy_pages, "Unable to retrieve encrypted pages bitmap");
+	while (pg < (memory_size / vm_get_page_size(vm))) {
+		sparsebit_idx_t pg_cnt;
+
+		if (sparsebit_is_clear(enc_phy_pages, pg)) {
+			pg = sparsebit_next_set(enc_phy_pages, pg);
+			if (!pg)
+				break;
+		}
+
+		pg_cnt = sparsebit_next_clear(enc_phy_pages, pg) - pg;
+		if (pg_cnt <= 0)
+			pg_cnt = 1;
+
+		sev_encrypt_phy_range(sev,
+				      gpa_start + pg * vm_get_page_size(vm),
+				      pg_cnt * vm_get_page_size(vm));
+		pg += pg_cnt;
+	}
+}
+
+/* SEV VM implementation. */
+
+static struct sev_vm *sev_vm_alloc(struct kvm_vm *vm)
+{
+	struct sev_user_data_status sev_status = {0};
+	uint32_t eax, ebx, ecx, edx;
+	struct sev_vm *sev;
+	int sev_fd;
+
+	sev_fd = open(SEV_DEV_PATH, O_RDWR);
+	if (sev_fd < 0) {
+		pr_info("Failed to open SEV device, path: %s, error: %d, skipping test.\n",
+			SEV_DEV_PATH, sev_fd);
+		return NULL;
+	}
+
+	sev_ioctl(sev_fd, SEV_PLATFORM_STATUS, &sev_status);
+
+	if (!(sev_status.api_major > SEV_FW_REQ_VER_MAJOR ||
+	      (sev_status.api_major == SEV_FW_REQ_VER_MAJOR &&
+	       sev_status.api_minor >= SEV_FW_REQ_VER_MINOR))) {
+		pr_info("SEV FW version too old. Have API %d.%d (build: %d), need %d.%d, skipping test.\n",
+			sev_status.api_major, sev_status.api_minor, sev_status.build,
+			SEV_FW_REQ_VER_MAJOR, SEV_FW_REQ_VER_MINOR);
+		return NULL;
+	}
+
+	sev = calloc(1, sizeof(*sev));
+	sev->fd = sev_fd;
+	sev->vm = vm;
+
+	/* Get encryption bit via CPUID. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	sev->enc_bit = ebx & 0x3F;
+
+	return sev;
+}
+
+void sev_vm_free(struct sev_vm *sev)
+{
+	kvm_vm_free(sev->vm);
+	close(sev->fd);
+	free(sev);
+}
+
+struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
+{
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+
+	/* Need to handle memslots after init, and after setting memcrypt. */
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	sev = sev_vm_alloc(vm);
+	if (!sev)
+		return NULL;
+	sev->sev_policy = policy;
+
+	kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
+
+	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
+	sev_register_user_region(sev, addr_gpa2hva(vm, 0),
+				 npages * vm_get_page_size(vm));
+
+	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
+		sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
+
+	return sev;
+}
+
+void sev_vm_launch(struct sev_vm *sev)
+{
+	struct kvm_sev_launch_start ksev_launch_start = {0};
+	struct kvm_sev_guest_status ksev_status = {0};
+
+	/* Need to use ucall_shared for synchronization. */
+	ucall_init_ops(sev_get_vm(sev), NULL, &ucall_ops_halt);
+
+	ksev_launch_start.policy = sev->sev_policy;
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_START, &ksev_launch_start);
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
+	TEST_ASSERT(ksev_status.policy == sev->sev_policy, "Incorrect guest policy.");
+	TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE,
+		    "Unexpected guest state: %d", ksev_status.state);
+
+	sev_encrypt(sev);
+}
+
+void sev_vm_launch_measure(struct sev_vm *sev, uint8_t *measurement)
+{
+	struct kvm_sev_launch_measure ksev_launch_measure = {0};
+	struct kvm_sev_guest_status ksev_guest_status = {0};
+
+	ksev_launch_measure.len = 256;
+	ksev_launch_measure.uaddr = (__u64)measurement;
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_MEASURE, &ksev_launch_measure);
+
+	/* Measurement causes a state transition, check that. */
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_guest_status);
+	TEST_ASSERT(ksev_guest_status.state == SEV_GSTATE_LSECRET,
+		    "Unexpected guest state: %d", ksev_guest_status.state);
+}
+
+void sev_vm_launch_finish(struct sev_vm *sev)
+{
+	struct kvm_sev_guest_status ksev_status = {0};
+
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
+	TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE ||
+		    ksev_status.state == SEV_GSTATE_LSECRET,
+		    "Unexpected guest state: %d", ksev_status.state);
+
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_FINISH, NULL);
+
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
+	TEST_ASSERT(ksev_status.state == SEV_GSTATE_RUNNING,
+		    "Unexpected guest state: %d", ksev_status.state);
+}
-- 
2.25.1

