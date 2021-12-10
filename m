Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0424947063C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbhLJQwI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:52:08 -0500
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:52385
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244287AbhLJQv5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeCx8/J8DUyHrTnSZos0RbnZvdxH/v1Z7tj3V70wnre5jJPVzKNC67KL/MrvIHK5N2/ckAY3CPUWYlmIl/388fjdMgPgLHcREyc7BkQrBhtPUF+vM4mokCO4pEzD2LwgjVU4VdX9yVifzNTpSA2giNznCac0/hQMtBXBYHouQMQ0S4/DZdPmkiFPCSjNzuxbP7xNXAbIOzjjVLsk2WFQmIUxY92z3WAO5MpCV+PEIPOCqV20W0O/3S65Ma8l/AUdg0a459RCtikHpwjU2MXpEZKVLjIReD28VxpRP50rf4dxXZuSBQmgBH9PhdVln41kMt5+emKNSYsYYLwKEyFh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mWO/8WOxEIkwLByFCfm7KVUDUjWvtOpS7pLVnYcF5A=;
 b=YZU/n21imR1G5ycCjJ3HJ2qvYtU7sWzsvh7e7ehRUckRCKxRNIMNkNU+zhisX3jLgP6G4HSfWF2+yiWIjE2//BglSA+jxDzRM2ox1xnNPkZ71sbK3M99aRFrKjPvMLVtnQL7SBxAs/4lLEXlSvYP8HJCZFcJ8/4hN86uXAUOU2DIYaZeJBVhfg3iiLk+XoxyAMH5CEwB0zDBIsZsoJnP60zggD+dcSB+RlJzD1nHV5/6E/dtdBTr8gbB7mYaU3F7K0QZFjW5VWGtOw9zdIG+4vUSAF5oQx9Pb0pQdjxTbby6AvxPBaniWGbqbK9byM2w6XIW/zKnPuwYFsp1VKC19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mWO/8WOxEIkwLByFCfm7KVUDUjWvtOpS7pLVnYcF5A=;
 b=QR2Q6JDr/jC11OKdWx1hizDepmrm57VzdqsJLjvnCa3F75JePWkADbDF9nd7zYTh0zTBdHphEE5i/3Dyb9UQ9CF+X92kUSZo9yzE09au/4agKVzH7j6eAzyWPWPnS9HEpg5XdLQ9F7Qo9b5voDddwtftv/AoJriwfdycPuPQU3g=
Received: from DM5PR07CA0155.namprd07.prod.outlook.com (2603:10b6:3:ee::21) by
 BN8PR12MB2916.namprd12.prod.outlook.com (2603:10b6:408:6a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 16:48:11 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::9f) by DM5PR07CA0155.outlook.office365.com
 (2603:10b6:3:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Fri, 10 Dec 2021 16:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:48:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:48:10 -0600
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
Subject: [PATCH RFC 01/10] kvm: selftests: move base kvm_util.h declarations to kvm_util_base.h
Date:   Fri, 10 Dec 2021 10:46:11 -0600
Message-ID: <20211210164620.11636-2-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2210f964-c16f-431f-dcf4-08d9bbfcd9fd
X-MS-TrafficTypeDiagnostic: BN8PR12MB2916:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2916223C32EC1188D79767B595719@BN8PR12MB2916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpMfuXfhQGgMFo+tWK/qhS4x2Px/DqzQq0hEgMOVvx/RcmC9NtUwz9UyTTVjdVcaYliTUqYRxF9QRTFuEz1Yrc+xk/5N33fB6+bTS8hAd1/YTn8NgTS1KNPo7hRaiTEGjEBO4ByvWfYzMeZgjnnhNX7rAldnl40LTZlHgOS/5bcqWm3dwWdrrq6uMRaKdjZwa+fBuIJ39XPFYEcCMRFVAkP6y6dJGlu0+xvx9K8GrzI92Y5Ow5ikX/uU731lTY2J06kBkhvy8L46jswC8JWzdah25QTxn249tgbMx2BP0ONeGyBwYRFwQWjO+Ces94J3354tclIQdYDfT1FxztfpfM9Ia7ILCzK/gfwU1jpbVpUl5KbnAVSDs84BBfUMUlQv9vUPm9kySA6aCbcNGZPBByopHx//TmGlo+SxPpr5gid97VUWz7CWnL6VhZgu513sM63MDT7UvCG0pL8OCoZc9YR84Y8Qd3mE1kuiJuI7Q820IxSzMPvKkHgcJ8DP6GjCQ3wlT1NJtoBF3vUwsqzq4Ztv+fihWRV1cilUHf55hfwB+7p9I+sKWQ/rVc+5/mtQmuPoPSRwFDjFFtNoN5GmXsbljc8pLMtI2asJJdOcCAAAnd8VVx9xxVSrGUAKpflhWDf1JE8CwfamGlsnz+cDHjMQFexSnuRyf5DHhpY1XX5gHKcMF2HQfeRuPtiPQ2N7Q0ZLFgjwXKayOstWABd2kw5kndR3H8FQY72dsMUs+8dfMj6LKnU0SUCJWh+mSZ1m8H0HJbPAdODciQc3grS1F4sWQ5XIynz0Y4QVDaVII9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(86362001)(8936002)(81166007)(336012)(70206006)(16526019)(426003)(2906002)(4326008)(82310400004)(186003)(2616005)(40460700001)(47076005)(8676002)(26005)(7416002)(30864003)(356005)(5660300002)(44832011)(54906003)(36860700001)(6916009)(36756003)(70586007)(83380400001)(316002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:48:11.2218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2210f964-c16f-431f-dcf4-08d9bbfcd9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2916
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Between helper macros and interfaces that will be introduced in
subsequent patches, much of kvm_util.h would end up being declarations
specific to ucall. Ideally these could be separated out into a separate
header since they are not strictly required for writing guest tests and
are mostly self-contained interfaces other than a reliance on a few
core declarations like struct kvm_vm. This doesn't make a big
difference as far as how tests will be compiled/written since all these
interfaces will still be packaged up into a single/common libkvm.a used
by all tests, but it is still nice to be able to compartmentalize to
improve readabilty and reduce merge conflicts in the future for common
tasks like adding new interfaces to kvm_util.h.

Furthermore, some of the ucall declarations will be arch-specific,
requiring various #ifdef'ery in kvm_util.h. Ideally these declarations
could live in separate arch-specific headers, e.g.
include/<arch>/ucall.h, which would handle arch-specific declarations
as well as pulling in common ucall-related declarations shared by all
archs.

One simple way to do this would be to #include ucall.h at the bottom of
kvm_util.h, after declarations it relies upon like struct kvm_vm.
This is brittle however, and doesn't scale easily to other sets of
interfaces that may be added in the future.

Instead, move all declarations currently in kvm_util.h into
kvm_util_base.h, then have kvm_util.h #include it. With this change,
non-base declarations can be selectively moved/introduced into separate
headers, which can then be included in kvm_util.h so that individual
tests don't need to be touched. Subsequent patches will then move
ucall-related declarations into a separate header to meet the above
goals.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 407 +----------------
 .../selftests/kvm/include/kvm_util_base.h     | 417 ++++++++++++++++++
 2 files changed, 418 insertions(+), 406 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util_base.h

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 6a1a37f30494..c860ced3888d 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -7,411 +7,6 @@
 #ifndef SELFTEST_KVM_UTIL_H
 #define SELFTEST_KVM_UTIL_H
 
-#include "test_util.h"
-
-#include "asm/kvm.h"
-#include "linux/list.h"
-#include "linux/kvm.h"
-#include <sys/ioctl.h>
-
-#include "sparsebit.h"
-
-#define KVM_DEV_PATH "/dev/kvm"
-#define KVM_MAX_VCPUS 512
-
-#define NSEC_PER_SEC 1000000000L
-
-/*
- * Callers of kvm_util only have an incomplete/opaque description of the
- * structure kvm_util is using to maintain the state of a VM.
- */
-struct kvm_vm;
-
-typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
-typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
-
-/* Minimum allocated guest virtual and physical addresses */
-#define KVM_UTIL_MIN_VADDR		0x2000
-#define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
-
-#define DEFAULT_GUEST_PHY_PAGES		512
-#define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
-#define DEFAULT_STACK_PGS		5
-
-enum vm_guest_mode {
-	VM_MODE_P52V48_4K,
-	VM_MODE_P52V48_64K,
-	VM_MODE_P48V48_4K,
-	VM_MODE_P48V48_64K,
-	VM_MODE_P40V48_4K,
-	VM_MODE_P40V48_64K,
-	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
-	VM_MODE_P47V64_4K,
-	VM_MODE_P44V64_4K,
-	NUM_VM_MODES,
-};
-
-#if defined(__aarch64__)
-
-#define VM_MODE_DEFAULT			VM_MODE_P40V48_4K
-#define MIN_PAGE_SHIFT			12U
-#define ptes_per_page(page_size)	((page_size) / 8)
-
-#elif defined(__x86_64__)
-
-#define VM_MODE_DEFAULT			VM_MODE_PXXV48_4K
-#define MIN_PAGE_SHIFT			12U
-#define ptes_per_page(page_size)	((page_size) / 8)
-
-#elif defined(__s390x__)
-
-#define VM_MODE_DEFAULT			VM_MODE_P44V64_4K
-#define MIN_PAGE_SHIFT			12U
-#define ptes_per_page(page_size)	((page_size) / 16)
-
-#endif
-
-#define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
-#define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
-
-struct vm_guest_mode_params {
-	unsigned int pa_bits;
-	unsigned int va_bits;
-	unsigned int page_size;
-	unsigned int page_shift;
-};
-extern const struct vm_guest_mode_params vm_guest_mode_params[];
-
-int open_path_or_exit(const char *path, int flags);
-int open_kvm_dev_path_or_exit(void);
-int kvm_check_cap(long cap);
-int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
-int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
-		    struct kvm_enable_cap *cap);
-void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
-const char *vm_guest_mode_string(uint32_t i);
-
-struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
-void kvm_vm_free(struct kvm_vm *vmp);
-void kvm_vm_restart(struct kvm_vm *vmp, int perm);
-void kvm_vm_release(struct kvm_vm *vmp);
-void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log);
-void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
-			    uint64_t first_page, uint32_t num_pages);
-uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm);
-
-int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, const vm_vaddr_t gva,
-		       size_t len);
-
-void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
-
-void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
-
-/*
- * VM VCPU Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   vm     - Virtual Machine
- *   vcpuid - VCPU ID
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the current state of the VCPU specified by @vcpuid, within the VM
- * given by @vm, to the FILE stream given by @stream.
- */
-void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
-	       uint8_t indent);
-
-void vm_create_irqchip(struct kvm_vm *vm);
-
-void vm_userspace_mem_region_add(struct kvm_vm *vm,
-	enum vm_mem_backing_src_type src_type,
-	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-	uint32_t flags);
-
-void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
-		void *arg);
-int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
-		void *arg);
-void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
-void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-int _kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
-void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
-void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
-void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
-vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
-vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
-vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
-
-void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
-	      unsigned int npages);
-void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
-void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
-vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
-void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
-
-/*
- * Address Guest Virtual to Guest Physical
- *
- * Input Args:
- *   vm - Virtual Machine
- *   gva - VM virtual address
- *
- * Output Args: None
- *
- * Return:
- *   Equivalent VM physical address
- *
- * Returns the VM physical address of the translated VM virtual
- * address given by @gva.
- */
-vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
-
-struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
-int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
-int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
-			  struct kvm_guest_debug *debug);
-void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
-		       struct kvm_mp_state *mp_state);
-struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
-void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
-
-/*
- * VM VCPU Args Set
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   num - number of arguments
- *   ... - arguments, each of type uint64_t
- *
- * Output Args: None
- *
- * Return: None
- *
- * Sets the first @num function input registers of the VCPU with @vcpuid,
- * per the C calling convention of the architecture, to the values given
- * as variable args. Each of the variable args is expected to be of type
- * uint64_t. The maximum @num can be is specific to the architecture.
- */
-void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
-
-void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_sregs *sregs);
-void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_sregs *sregs);
-int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_sregs *sregs);
-void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
-		  struct kvm_fpu *fpu);
-void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
-		  struct kvm_fpu *fpu);
-void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
-void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
-#ifdef __KVM_HAVE_VCPU_EVENTS
-void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_vcpu_events *events);
-void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_vcpu_events *events);
-#endif
-#ifdef __x86_64__
-void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
-			   struct kvm_nested_state *state);
-int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			  struct kvm_nested_state *state, bool ignore_error);
-#endif
-void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
-
-int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
-int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
-int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd);
-int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test);
-int _kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
-		       void *val, bool write);
-int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
-		      void *val, bool write);
-
-int _vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr);
-int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			 uint64_t attr);
-int _vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr, void *val, bool write);
-int vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			 uint64_t attr, void *val, bool write);
-
-const char *exit_reason_str(unsigned int exit_reason);
-
-void virt_pgd_alloc(struct kvm_vm *vm);
-
-/*
- * VM Virtual Page Map
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vaddr - VM Virtual Address
- *   paddr - VM Physical Address
- *   memslot - Memory region slot for new virtual translation tables
- *
- * Output Args: None
- *
- * Return: None
- *
- * Within @vm, creates a virtual translation for the page starting
- * at @vaddr to the page starting at @paddr.
- */
-void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
-
-vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
-			     uint32_t memslot);
-vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
-			      vm_paddr_t paddr_min, uint32_t memslot);
-vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
-
-/*
- * Create a VM with reasonable defaults
- *
- * Input Args:
- *   vcpuid - The id of the single VCPU to add to the VM.
- *   extra_mem_pages - The number of extra pages to add (this will
- *                     decide how much extra space we will need to
- *                     setup the page tables using memslot 0)
- *   guest_code - The vCPU's entry point
- *
- * Output Args: None
- *
- * Return:
- *   Pointer to opaque structure that describes the created VM.
- */
-struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
-				 void *guest_code);
-
-/* Same as vm_create_default, but can be used for more than one vcpu */
-struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_mem_pages,
-					    uint32_t num_percpu_pages, void *guest_code,
-					    uint32_t vcpuids[]);
-
-/* Like vm_create_default_with_vcpus, but accepts mode and slot0 memory as a parameter */
-struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
-				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
-				    uint32_t num_percpu_pages, void *guest_code,
-				    uint32_t vcpuids[]);
-
-/*
- * Adds a vCPU with reasonable defaults (e.g. a stack)
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - The id of the VCPU to add to the VM.
- *   guest_code - The vCPU's entry point
- */
-void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
-
-bool vm_is_unrestricted_guest(struct kvm_vm *vm);
-
-unsigned int vm_get_page_size(struct kvm_vm *vm);
-unsigned int vm_get_page_shift(struct kvm_vm *vm);
-uint64_t vm_get_max_gfn(struct kvm_vm *vm);
-int vm_get_fd(struct kvm_vm *vm);
-
-unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
-unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_guest_pages);
-unsigned int vm_num_guest_pages(enum vm_guest_mode mode, unsigned int num_host_pages);
-static inline unsigned int
-vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
-{
-	unsigned int n;
-	n = vm_num_guest_pages(mode, vm_num_host_pages(mode, num_guest_pages));
-#ifdef __s390x__
-	/* s390 requires 1M aligned guest sizes */
-	n = (n + 255) & ~255;
-#endif
-	return n;
-}
-
-struct kvm_userspace_memory_region *
-kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
-				 uint64_t end);
-
-struct kvm_dirty_log *
-allocate_kvm_dirty_log(struct kvm_userspace_memory_region *region);
-
-int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
-
-#define sync_global_to_guest(vm, g) ({				\
-	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
-	memcpy(_p, &(g), sizeof(g));				\
-})
-
-#define sync_global_from_guest(vm, g) ({			\
-	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
-	memcpy(&(g), _p, sizeof(g));				\
-})
-
-void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
-
-/* Common ucalls */
-enum {
-	UCALL_NONE,
-	UCALL_SYNC,
-	UCALL_ABORT,
-	UCALL_DONE,
-	UCALL_UNHANDLED,
-};
-
-#define UCALL_MAX_ARGS 6
-
-struct ucall {
-	uint64_t cmd;
-	uint64_t args[UCALL_MAX_ARGS];
-};
-
-void ucall_init(struct kvm_vm *vm, void *arg);
-void ucall_uninit(struct kvm_vm *vm);
-void ucall(uint64_t cmd, int nargs, ...);
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
-
-#define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
-				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
-#define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
-#define GUEST_DONE()		ucall(UCALL_DONE, 0)
-#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
-	if (!(_condition))                                              \
-		ucall(UCALL_ABORT, 2 + _nargs,                          \
-			"Failed guest assert: "                         \
-			_condstr, __LINE__, _args);                     \
-} while (0)
-
-#define GUEST_ASSERT(_condition) \
-	__GUEST_ASSERT(_condition, #_condition, 0, 0)
-
-#define GUEST_ASSERT_1(_condition, arg1) \
-	__GUEST_ASSERT(_condition, #_condition, 1, (arg1))
-
-#define GUEST_ASSERT_2(_condition, arg1, arg2) \
-	__GUEST_ASSERT(_condition, #_condition, 2, (arg1), (arg2))
-
-#define GUEST_ASSERT_3(_condition, arg1, arg2, arg3) \
-	__GUEST_ASSERT(_condition, #_condition, 3, (arg1), (arg2), (arg3))
-
-#define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
-	__GUEST_ASSERT(_condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
-
-#define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
-
-int vm_get_stats_fd(struct kvm_vm *vm);
-int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
-
-uint32_t guest_get_vcpuid(void);
+#include "kvm_util_base.h"
 
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
new file mode 100644
index 000000000000..8fb6aeff5469
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -0,0 +1,417 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tools/testing/selftests/kvm/include/kvm_util_base.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ */
+#ifndef SELFTEST_KVM_UTIL_BASE_H
+#define SELFTEST_KVM_UTIL_BASE_H
+
+#include "test_util.h"
+
+#include "asm/kvm.h"
+#include "linux/list.h"
+#include "linux/kvm.h"
+#include <sys/ioctl.h>
+
+#include "sparsebit.h"
+
+#define KVM_DEV_PATH "/dev/kvm"
+#define KVM_MAX_VCPUS 512
+
+#define NSEC_PER_SEC 1000000000L
+
+/*
+ * Callers of kvm_util only have an incomplete/opaque description of the
+ * structure kvm_util is using to maintain the state of a VM.
+ */
+struct kvm_vm;
+
+typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
+typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
+
+/* Minimum allocated guest virtual and physical addresses */
+#define KVM_UTIL_MIN_VADDR		0x2000
+#define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
+
+#define DEFAULT_GUEST_PHY_PAGES		512
+#define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
+#define DEFAULT_STACK_PGS		5
+
+enum vm_guest_mode {
+	VM_MODE_P52V48_4K,
+	VM_MODE_P52V48_64K,
+	VM_MODE_P48V48_4K,
+	VM_MODE_P48V48_64K,
+	VM_MODE_P40V48_4K,
+	VM_MODE_P40V48_64K,
+	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
+	VM_MODE_P47V64_4K,
+	VM_MODE_P44V64_4K,
+	NUM_VM_MODES,
+};
+
+#if defined(__aarch64__)
+
+#define VM_MODE_DEFAULT			VM_MODE_P40V48_4K
+#define MIN_PAGE_SHIFT			12U
+#define ptes_per_page(page_size)	((page_size) / 8)
+
+#elif defined(__x86_64__)
+
+#define VM_MODE_DEFAULT			VM_MODE_PXXV48_4K
+#define MIN_PAGE_SHIFT			12U
+#define ptes_per_page(page_size)	((page_size) / 8)
+
+#elif defined(__s390x__)
+
+#define VM_MODE_DEFAULT			VM_MODE_P44V64_4K
+#define MIN_PAGE_SHIFT			12U
+#define ptes_per_page(page_size)	((page_size) / 16)
+
+#endif
+
+#define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
+#define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
+
+struct vm_guest_mode_params {
+	unsigned int pa_bits;
+	unsigned int va_bits;
+	unsigned int page_size;
+	unsigned int page_shift;
+};
+extern const struct vm_guest_mode_params vm_guest_mode_params[];
+
+int open_path_or_exit(const char *path, int flags);
+int open_kvm_dev_path_or_exit(void);
+int kvm_check_cap(long cap);
+int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
+int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
+		    struct kvm_enable_cap *cap);
+void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
+const char *vm_guest_mode_string(uint32_t i);
+
+struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
+void kvm_vm_free(struct kvm_vm *vmp);
+void kvm_vm_restart(struct kvm_vm *vmp, int perm);
+void kvm_vm_release(struct kvm_vm *vmp);
+void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log);
+void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
+			    uint64_t first_page, uint32_t num_pages);
+uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm);
+
+int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, const vm_vaddr_t gva,
+		       size_t len);
+
+void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
+
+void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
+
+/*
+ * VM VCPU Dump
+ *
+ * Input Args:
+ *   stream - Output FILE stream
+ *   vm     - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   indent - Left margin indent amount
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Dumps the current state of the VCPU specified by @vcpuid, within the VM
+ * given by @vm, to the FILE stream given by @stream.
+ */
+void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
+	       uint8_t indent);
+
+void vm_create_irqchip(struct kvm_vm *vm);
+
+void vm_userspace_mem_region_add(struct kvm_vm *vm,
+	enum vm_mem_backing_src_type src_type,
+	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+	uint32_t flags);
+
+void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
+		void *arg);
+int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
+		void *arg);
+void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
+int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
+void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
+int _kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
+void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
+void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
+void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
+void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
+vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
+
+void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+	      unsigned int npages);
+void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
+void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
+vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
+void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
+
+/*
+ * Address Guest Virtual to Guest Physical
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gva - VM virtual address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent VM physical address
+ *
+ * Returns the VM physical address of the translated VM virtual
+ * address given by @gva.
+ */
+vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
+
+struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_guest_debug *debug);
+void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
+		       struct kvm_mp_state *mp_state);
+struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
+void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
+
+/*
+ * VM VCPU Args Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   num - number of arguments
+ *   ... - arguments, each of type uint64_t
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the first @num function input registers of the VCPU with @vcpuid,
+ * per the C calling convention of the architecture, to the values given
+ * as variable args. Each of the variable args is expected to be of type
+ * uint64_t. The maximum @num can be is specific to the architecture.
+ */
+void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
+
+void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid,
+		    struct kvm_sregs *sregs);
+void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
+		    struct kvm_sregs *sregs);
+int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
+		    struct kvm_sregs *sregs);
+void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
+		  struct kvm_fpu *fpu);
+void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
+		  struct kvm_fpu *fpu);
+void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
+void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
+#ifdef __KVM_HAVE_VCPU_EVENTS
+void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
+		     struct kvm_vcpu_events *events);
+void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
+		     struct kvm_vcpu_events *events);
+#endif
+#ifdef __x86_64__
+void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
+			   struct kvm_nested_state *state);
+int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_nested_state *state, bool ignore_error);
+#endif
+void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
+
+int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
+int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
+int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd);
+int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test);
+int _kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
+		       void *val, bool write);
+int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
+		      void *val, bool write);
+
+int _vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
+			  uint64_t attr);
+int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
+			 uint64_t attr);
+int _vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
+			  uint64_t attr, void *val, bool write);
+int vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
+			 uint64_t attr, void *val, bool write);
+
+const char *exit_reason_str(unsigned int exit_reason);
+
+void virt_pgd_alloc(struct kvm_vm *vm);
+
+/*
+ * VM Virtual Page Map
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vaddr - VM Virtual Address
+ *   paddr - VM Physical Address
+ *   memslot - Memory region slot for new virtual translation tables
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within @vm, creates a virtual translation for the page starting
+ * at @vaddr to the page starting at @paddr.
+ */
+void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
+
+vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
+			     uint32_t memslot);
+vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+			      vm_paddr_t paddr_min, uint32_t memslot);
+vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
+
+/*
+ * Create a VM with reasonable defaults
+ *
+ * Input Args:
+ *   vcpuid - The id of the single VCPU to add to the VM.
+ *   extra_mem_pages - The number of extra pages to add (this will
+ *                     decide how much extra space we will need to
+ *                     setup the page tables using memslot 0)
+ *   guest_code - The vCPU's entry point
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ */
+struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
+				 void *guest_code);
+
+/* Same as vm_create_default, but can be used for more than one vcpu */
+struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_mem_pages,
+					    uint32_t num_percpu_pages, void *guest_code,
+					    uint32_t vcpuids[]);
+
+/* Like vm_create_default_with_vcpus, but accepts mode and slot0 memory as a parameter */
+struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
+				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+				    uint32_t num_percpu_pages, void *guest_code,
+				    uint32_t vcpuids[]);
+
+/*
+ * Adds a vCPU with reasonable defaults (e.g. a stack)
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - The id of the VCPU to add to the VM.
+ *   guest_code - The vCPU's entry point
+ */
+void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
+
+bool vm_is_unrestricted_guest(struct kvm_vm *vm);
+
+unsigned int vm_get_page_size(struct kvm_vm *vm);
+unsigned int vm_get_page_shift(struct kvm_vm *vm);
+uint64_t vm_get_max_gfn(struct kvm_vm *vm);
+int vm_get_fd(struct kvm_vm *vm);
+
+unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
+unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_guest_pages);
+unsigned int vm_num_guest_pages(enum vm_guest_mode mode, unsigned int num_host_pages);
+static inline unsigned int
+vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
+{
+	unsigned int n;
+	n = vm_num_guest_pages(mode, vm_num_host_pages(mode, num_guest_pages));
+#ifdef __s390x__
+	/* s390 requires 1M aligned guest sizes */
+	n = (n + 255) & ~255;
+#endif
+	return n;
+}
+
+struct kvm_userspace_memory_region *
+kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end);
+
+struct kvm_dirty_log *
+allocate_kvm_dirty_log(struct kvm_userspace_memory_region *region);
+
+int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
+
+#define sync_global_to_guest(vm, g) ({				\
+	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
+	memcpy(_p, &(g), sizeof(g));				\
+})
+
+#define sync_global_from_guest(vm, g) ({			\
+	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
+	memcpy(&(g), _p, sizeof(g));				\
+})
+
+void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
+
+/* Common ucalls */
+enum {
+	UCALL_NONE,
+	UCALL_SYNC,
+	UCALL_ABORT,
+	UCALL_DONE,
+	UCALL_UNHANDLED,
+};
+
+#define UCALL_MAX_ARGS 6
+
+struct ucall {
+	uint64_t cmd;
+	uint64_t args[UCALL_MAX_ARGS];
+};
+
+void ucall_init(struct kvm_vm *vm, void *arg);
+void ucall_uninit(struct kvm_vm *vm);
+void ucall(uint64_t cmd, int nargs, ...);
+uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
+
+#define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
+				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
+#define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
+#define GUEST_DONE()		ucall(UCALL_DONE, 0)
+#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
+	if (!(_condition))                                              \
+		ucall(UCALL_ABORT, 2 + _nargs,                          \
+			"Failed guest assert: "                         \
+			_condstr, __LINE__, _args);                     \
+} while (0)
+
+#define GUEST_ASSERT(_condition) \
+	__GUEST_ASSERT(_condition, #_condition, 0, 0)
+
+#define GUEST_ASSERT_1(_condition, arg1) \
+	__GUEST_ASSERT(_condition, #_condition, 1, (arg1))
+
+#define GUEST_ASSERT_2(_condition, arg1, arg2) \
+	__GUEST_ASSERT(_condition, #_condition, 2, (arg1), (arg2))
+
+#define GUEST_ASSERT_3(_condition, arg1, arg2, arg3) \
+	__GUEST_ASSERT(_condition, #_condition, 3, (arg1), (arg2), (arg3))
+
+#define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
+	__GUEST_ASSERT(_condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
+
+#define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
+
+int vm_get_stats_fd(struct kvm_vm *vm);
+int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
+
+uint32_t guest_get_vcpuid(void);
+
+#endif /* SELFTEST_KVM_UTIL_BASE_H */
-- 
2.25.1

