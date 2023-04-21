Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858DB6EAFF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjDUQ7b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjDUQ7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 12:59:25 -0400
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552215607
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:58:59 -0700 (PDT)
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-24708bfb463so2215533a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682095992; x=1684687992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dM0sknYnz5Tr9YshwaHjySCVB3V9EWCXlRX5uFgEya8=;
        b=cKoOxJh4k5Df809KvDrC16SHpyyANbnD88ODpXNOuka0EEfmMXb9/GGZHQjZmiaSGC
         PHXwzp6oJJCuBjtwH55J3xqdIM10HnXCfOmj/GRFwtdNPqo3g+mBSidFvw86YFvbU0sY
         QFH5aE4DJ8NgYwN0BX1m2H/84CVYfPBQlivAZjfI0w0gbJssCQFPLo6dhrf9i30gQDYK
         RVT9NmA3RwkhJ9wGFaj9EOO7LpEIdOpFNM2q37g3x6fVQdiBTnwi7UMa2h5IS92inTkJ
         5XzKSeq94NI91RbwFfXmAf2d+oezqCbzgzE8MFn7zbTcJm/Y08tOtjCRc2EpRU8GmuIw
         Joug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095992; x=1684687992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dM0sknYnz5Tr9YshwaHjySCVB3V9EWCXlRX5uFgEya8=;
        b=RxDPkTrfqvn2qIPMNyZyrVIAQhZ5HmH1YgkyMvOM8AY0OcZDVLhqgunAl9CfwhlTHK
         DTXABXYzysvXebbJ79rRbxlodiu/FGMdt/43sJJNwm9azitEb5v7DKo9LlBRK2mMyAv4
         oCvpQuWxEYoT6jPzPAFwlIjpk784VI6W67mO6sjpr4N5BHPbMszOa5bZib2pMxNMAzuJ
         84qB8L/Dl35jZ6PRUoJz7KfE+YltEr9ORhXgrcmjjR12EbOQsenNg8XGCc+S6/iMUwjy
         rf2LAWXfKZ8hIHs5MVGgoz58ibknX3VutKfOSZc0i6uaqtMKWbjR1MX3LSxq1fIDqNx3
         38Aw==
X-Gm-Message-State: AAQBX9fq3b+g2LvoHYfdFlKSod1UmQ101dE+qGejPpzwoHw5JY/r8xiu
        +J8LNv7eu0LLFVQ3f6FoEdVcO0xjD2eT
X-Google-Smtp-Source: AKy350YMrLXAhkSUtVuYqUb/z6RwX7RpSjICLEgXjDkxf6HBxqanxF3VIJFd0FfCazAdAkwHsavol8ftYq4a
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:740d:b0:244:8f24:783d with SMTP id
 a13-20020a17090a740d00b002448f24783dmr1553862pjg.4.1682095992639; Fri, 21 Apr
 2023 09:53:12 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:52:58 -0700
In-Reply-To: <20230421165305.804301-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230421165305.804301-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421165305.804301-3-vipinsh@google.com>
Subject: [PATCH 2/9] KVM: selftests: Add optional delay between consecutive
 Clear-Dirty-Log calls
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In dirty_log_perf_test, add option "-l" to wait between consecutive
Clear-Dirty-Log calls. Accept delay in milliseconds.

This allows dirty_log_perf_test to mimic real world use where after
clearing dirty memory, some time is spent in transferring memory before
making a subsequeunt Clear-Dirty-Log call.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../testing/selftests/kvm/dirty_log_perf_test.c | 17 +++++++++++++++--
 tools/testing/selftests/kvm/include/memstress.h |  5 +++--
 tools/testing/selftests/kvm/lib/memstress.c     | 10 +++++++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 0852a7ba42e1..338f03a4a550 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -135,6 +135,7 @@ struct test_params {
 	uint32_t random_seed;
 	bool random_access;
 	uint64_t clear_chunk_size;
+	int clear_chunk_wait_time_ms
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
@@ -249,7 +250,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			clock_gettime(CLOCK_MONOTONIC, &start);
 			memstress_clear_dirty_log_in_chunks(vm, bitmaps, p->slots,
 							    pages_per_slot,
-							    pages_per_clear);
+							    pages_per_clear,
+							    p->clear_chunk_wait_time_ms);
 			ts_diff = timespec_elapsed(start);
 			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
 							     ts_diff);
@@ -352,6 +354,11 @@ static void help(char *name)
 	       "     the memslot size then whole memslot is cleared in one call.\n"
 	       "     Size must be aligned to the host page size. e.g. 10M or 3G\n"
 	       "     (default: UINT64_MAX, clears whole memslot in one call)\n");
+	printf(" -l: Specify time in milliseconds to wait after Clear-Dirty-Log\n"
+	       "     call. This allows to mimic use cases where flow is to get\n"
+	       "     dirty log followed by multiple clear dirty log calls and\n"
+	       "     sending corresponding memory to destination (in this test\n"
+	       "     sending will be just idle waiting)\n");
 	puts("");
 	exit(0);
 }
@@ -368,6 +375,7 @@ int main(int argc, char *argv[])
 		.random_seed = 1,
 		.write_percent = 100,
 		.clear_chunk_size = UINT64_MAX,
+		.clear_chunk_wait_time_ms = 0,
 	};
 	int opt;
 
@@ -378,7 +386,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ab:c:eghi:k:m:nop:r:s:v:x:w:")) != -1) {
+	while ((opt = getopt(argc, argv, "ab:c:eghi:k:l:m:nop:r:s:v:x:w:")) != -1) {
 		switch (opt) {
 		case 'a':
 			p.random_access = true;
@@ -405,6 +413,11 @@ int main(int argc, char *argv[])
 		case 'k':
 			p.clear_chunk_size = parse_size(optarg);
 			break;
+		case 'l':
+			p.clear_chunk_wait_time_ms =
+					atoi_non_negative("Clear dirty log chunks wait time",
+							  optarg);
+			break;
 		case 'm':
 			guest_modes_cmdline(optarg);
 			break;
diff --git a/tools/testing/selftests/kvm/include/memstress.h b/tools/testing/selftests/kvm/include/memstress.h
index 2acc93f76fc3..01fdcea80360 100644
--- a/tools/testing/selftests/kvm/include/memstress.h
+++ b/tools/testing/selftests/kvm/include/memstress.h
@@ -78,12 +78,13 @@ void memstress_get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int sl
 void memstress_clear_dirty_log_in_chunks(struct kvm_vm *vm,
 					 unsigned long *bitmaps[], int slots,
 					 uint64_t pages_per_slot,
-					 uint64_t pages_per_clear);
+					 uint64_t pages_per_clear,
+					 int wait_ms);
 static inline void memstress_clear_dirty_log(struct kvm_vm *vm,
 					     unsigned long *bitmaps[], int slots,
 					     uint64_t pages_per_slot) {
 	memstress_clear_dirty_log_in_chunks(vm, bitmaps, slots, pages_per_slot,
-					    pages_per_slot);
+					    pages_per_slot, 0);
 }
 unsigned long **memstress_alloc_bitmaps(int slots, uint64_t pages_per_slot);
 void memstress_free_bitmaps(unsigned long *bitmaps[], int slots);
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index e0c701ab4e9a..483ecbc53a5b 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -358,10 +358,15 @@ void memstress_get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int sl
 void memstress_clear_dirty_log_in_chunks(struct kvm_vm *vm,
 					 unsigned long *bitmaps[], int slots,
 					 uint64_t pages_per_slot,
-					 uint64_t pages_per_clear)
+					 uint64_t pages_per_clear,
+					 int wait_ms)
 {
 	int i, slot;
 	uint64_t from, clear_pages_count;
+	struct timespec wait = {
+		.tv_sec = wait_ms / 1000,
+		.tv_nsec = (wait_ms % 1000) * 1000000ull,
+	};
 
 	for (i = 0; i < slots; i++) {
 		slot = MEMSTRESS_MEM_SLOT_INDEX + i;
@@ -374,6 +379,9 @@ void memstress_clear_dirty_log_in_chunks(struct kvm_vm *vm,
 			kvm_vm_clear_dirty_log(vm, slot, bitmaps[i], from,
 					       clear_pages_count);
 			from += clear_pages_count;
+			if (wait_ms)
+				nanosleep(&wait, NULL);
+
 		}
 	}
 
-- 
2.40.0.634.g4ca3ef3211-goog

