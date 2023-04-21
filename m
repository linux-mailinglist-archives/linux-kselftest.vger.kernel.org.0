Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1C6EB003
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDURCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjDURCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 13:02:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08B015461
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:02:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-3e6a9ef3e09so28328341cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682096511; x=1684688511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgxikP+X3kYGOAuFnf+zh/dPS0rwAngpLKDcQUsUAcM=;
        b=H6VBBYfARVXOeW0ZC61FUGxakG07vgO4XEerf2/L0OMLmp02RptF0KEKJ23yxiI95o
         KZPPcDPcnC8yycDkpuXfIhYP6Sw+lVrTCU318j/rkoA3IUTSOEnQ7nX872D8qsNse51u
         7nUQDsEYGBcKUtY8CKbTfXGrRc2TTMs61W1pwECER9okzCsLA4fmCZpkJr5ixo75brxq
         DIvp0VBgXUYXl/AJlbLwsbMt2Q9RcVICjrqQLXG9EqC3XDcATLDTk2MIFiNb9/nhzeY6
         jU9tUc/koInE9CTFIFX4h7RzuyvjDfhrT0SPH+jmI/q0emZmkoRv8OPtHxYI2bob7LX3
         tccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096511; x=1684688511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgxikP+X3kYGOAuFnf+zh/dPS0rwAngpLKDcQUsUAcM=;
        b=iJHej+jVaW5rptSbmxnQ3y9zTO9azYPwMYE85KGHND8GtzBDmZB7o3zTcvN4k8gErw
         AgDQ+202jSLLDSzwi+PZQAMbKO+N6fJsKVQW06jQ/t/+UlEpFdsXNWZAcNWVJ7PK71st
         cjy+OezVj5WtvB8GiVR088/j6ckJQUIxRzllZ0lzlyKWKSDgV1QzQe87OgQndmNX5buG
         Rp9V3iL+xswjPsRUEYeQr90zC5uxufvMuy8IPb8NRTzbvcZjWUAy7Z07TZmchfEl8F7u
         RyDQoKbrce2K5UUI/o3XJH5ZVsgWoTJMoRhUKHlea9qK9f79YXZ6qXxEzEF5Kcix0bqp
         RGlw==
X-Gm-Message-State: AAQBX9dpXi1yMcy5spiIW8EjXuapFf9zL+ie+/1+5DVr6EUOWiiA9dvU
        3gdT+OuFdN8u8i+43flioqSY4DXP+ZNc
X-Google-Smtp-Source: AKy350bLqvmQkloLHtSlULbO+KpqiU67EC/akbM+X8VT7JeFOolfsbExNw2my01sT0w0GqSqV5g1UxiZlB+p
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a63:f54b:0:b0:520:e728:8894 with SMTP id
 e11-20020a63f54b000000b00520e7288894mr1352406pgk.5.1682095990900; Fri, 21 Apr
 2023 09:53:10 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:52:57 -0700
In-Reply-To: <20230421165305.804301-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230421165305.804301-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421165305.804301-2-vipinsh@google.com>
Subject: [PATCH 1/9] KVM: selftests: Allow dirty_log_perf_test to clear dirty
 memory in chunks
From:   Vipin Sharma <vipinsh@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In dirty_log_perf_test, provide option 'k' to specify the size of the
chunks and clear dirty memory in chunks in each iteration. If this
option is not provided then fallback to old way of clearing whole
memslot in one call per iteration.

In production environment whole memslot is rarely cleared in a single
call, instead clearing operation is split across multiple calls to
reduce time between clearing and sending memory to a remote host. This
change mimics the production usecases and allow to get metrics based on
that.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 19 ++++++++++++---
 .../testing/selftests/kvm/include/memstress.h | 12 ++++++++--
 tools/testing/selftests/kvm/lib/memstress.c   | 24 ++++++++++++++-----
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 416719e20518..0852a7ba42e1 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -134,6 +134,7 @@ struct test_params {
 	uint32_t write_percent;
 	uint32_t random_seed;
 	bool random_access;
+	uint64_t clear_chunk_size;
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
@@ -144,6 +145,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	uint64_t guest_num_pages;
 	uint64_t host_num_pages;
 	uint64_t pages_per_slot;
+	uint64_t pages_per_clear;
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec get_dirty_log_total = (struct timespec){0};
@@ -164,6 +166,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
+	pages_per_clear = p->clear_chunk_size / getpagesize();
 
 	bitmaps = memstress_alloc_bitmaps(p->slots, pages_per_slot);
 
@@ -244,8 +247,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		if (dirty_log_manual_caps) {
 			clock_gettime(CLOCK_MONOTONIC, &start);
-			memstress_clear_dirty_log(vm, bitmaps, p->slots,
-						  pages_per_slot);
+			memstress_clear_dirty_log_in_chunks(vm, bitmaps, p->slots,
+							    pages_per_slot,
+							    pages_per_clear);
 			ts_diff = timespec_elapsed(start);
 			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
 							     ts_diff);
@@ -343,6 +347,11 @@ static void help(char *name)
 	       "     To leave the application task unpinned, drop the final entry:\n\n"
 	       "         ./dirty_log_perf_test -v 3 -c 22,23,24\n\n"
 	       "     (default: no pinning)\n");
+	printf(" -k: Specify the chunk size in which dirty memory gets cleared\n"
+	       "     in memslots in each iteration. If the size is bigger than\n"
+	       "     the memslot size then whole memslot is cleared in one call.\n"
+	       "     Size must be aligned to the host page size. e.g. 10M or 3G\n"
+	       "     (default: UINT64_MAX, clears whole memslot in one call)\n");
 	puts("");
 	exit(0);
 }
@@ -358,6 +367,7 @@ int main(int argc, char *argv[])
 		.slots = 1,
 		.random_seed = 1,
 		.write_percent = 100,
+		.clear_chunk_size = UINT64_MAX,
 	};
 	int opt;
 
@@ -368,7 +378,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ab:c:eghi:m:nop:r:s:v:x:w:")) != -1) {
+	while ((opt = getopt(argc, argv, "ab:c:eghi:k:m:nop:r:s:v:x:w:")) != -1) {
 		switch (opt) {
 		case 'a':
 			p.random_access = true;
@@ -392,6 +402,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			p.iterations = atoi_positive("Number of iterations", optarg);
 			break;
+		case 'k':
+			p.clear_chunk_size = parse_size(optarg);
+			break;
 		case 'm':
 			guest_modes_cmdline(optarg);
 			break;
diff --git a/tools/testing/selftests/kvm/include/memstress.h b/tools/testing/selftests/kvm/include/memstress.h
index ce4e603050ea..2acc93f76fc3 100644
--- a/tools/testing/selftests/kvm/include/memstress.h
+++ b/tools/testing/selftests/kvm/include/memstress.h
@@ -75,8 +75,16 @@ void memstress_setup_nested(struct kvm_vm *vm, int nr_vcpus, struct kvm_vcpu *vc
 void memstress_enable_dirty_logging(struct kvm_vm *vm, int slots);
 void memstress_disable_dirty_logging(struct kvm_vm *vm, int slots);
 void memstress_get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int slots);
-void memstress_clear_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[],
-			       int slots, uint64_t pages_per_slot);
+void memstress_clear_dirty_log_in_chunks(struct kvm_vm *vm,
+					 unsigned long *bitmaps[], int slots,
+					 uint64_t pages_per_slot,
+					 uint64_t pages_per_clear);
+static inline void memstress_clear_dirty_log(struct kvm_vm *vm,
+					     unsigned long *bitmaps[], int slots,
+					     uint64_t pages_per_slot) {
+	memstress_clear_dirty_log_in_chunks(vm, bitmaps, slots, pages_per_slot,
+					    pages_per_slot);
+}
 unsigned long **memstress_alloc_bitmaps(int slots, uint64_t pages_per_slot);
 void memstress_free_bitmaps(unsigned long *bitmaps[], int slots);
 
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 3632956c6bcf..e0c701ab4e9a 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -355,16 +355,28 @@ void memstress_get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int sl
 	}
 }
 
-void memstress_clear_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[],
-			       int slots, uint64_t pages_per_slot)
+void memstress_clear_dirty_log_in_chunks(struct kvm_vm *vm,
+					 unsigned long *bitmaps[], int slots,
+					 uint64_t pages_per_slot,
+					 uint64_t pages_per_clear)
 {
-	int i;
+	int i, slot;
+	uint64_t from, clear_pages_count;
 
 	for (i = 0; i < slots; i++) {
-		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
-
-		kvm_vm_clear_dirty_log(vm, slot, bitmaps[i], 0, pages_per_slot);
+		slot = MEMSTRESS_MEM_SLOT_INDEX + i;
+		from = 0;
+		clear_pages_count = pages_per_clear;
+
+		while (from < pages_per_slot) {
+			if (from + clear_pages_count > pages_per_slot)
+				clear_pages_count = pages_per_slot - from;
+			kvm_vm_clear_dirty_log(vm, slot, bitmaps[i], from,
+					       clear_pages_count);
+			from += clear_pages_count;
+		}
 	}
+
 }
 
 unsigned long **memstress_alloc_bitmaps(int slots, uint64_t pages_per_slot)
-- 
2.40.0.634.g4ca3ef3211-goog

