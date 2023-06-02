Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB25D7206DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjFBQJZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbjFBQJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:09:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA81BC
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-65356ed7053so604755b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722162; x=1688314162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpCi+Z+5IrlXYT4x1uPx6ey3Kh6k4RwU4EEsfyAeFCY=;
        b=HfcMR6iJ3p+XpoWwwGnuCf8DXEruqodHMrgo0qRUl9XKRxAQVZGiN8TxS7KXZ6liYk
         IHfRjrAnrHvGlvRXdd0vMGLUxjqvqzDBCEZqkZ+AlgA2D+HqWzekq3osmRA2k0du5O5o
         kCcbGty+UgEm8rxi/OLq7qgVCFwHH13HTXpftBj1XaM0i7tjBO9lKRJTdTnJF5R/3t6c
         JrkS5ti9XRCTfaa1D8P3ktMUx2ASyp8GqB5XYe9RG7pBvxny7Wq3BWLQtvGrXB/UToqw
         xyXoWdXWsB9HM0UfeGzOOvYeGlmazG1w/VKQFNAblPuwmKiFaBvQdPac1I4EbR7ShaXp
         NDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722162; x=1688314162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpCi+Z+5IrlXYT4x1uPx6ey3Kh6k4RwU4EEsfyAeFCY=;
        b=M/4yvPeYl5dKM4kgDr7APK8GGZtWqFor6edWp1+xLF60/3cO/hok3Kgjm0Orn6lOfa
         hva2VVYMVKOaov7rRFjOlAg7X17jEwEhspFv5ASy2wSSxAeSSIZKwZzLhmn3HaZwX2vx
         UoO9rfet056ra4xHZDAsEMtB+G+nXP74rlxPMhhREWM71JvYUQ92pvQzchLaOpDt3KSE
         XdcQEBMbjIp8IGKIiWT2uvAcWvuBYk09X1YaXjV7eY8LV17P8MgBsquV2lJXeBi199qo
         kcSOB0lMhdtTthYb8IMRAUAj+oxgXlZMPX9h8c4R4IuRGJG4vH5/wHvoHc6sZNyDCdkX
         8CEA==
X-Gm-Message-State: AC+VfDyVfkzHjvtwAkatM2oX1lv4oWJ4zG7sC4xyMHfuG+0M2Nvzsw2q
        6P9vzOzzFpfXeU7sYiOR4cUoCzNhOsoJ
X-Google-Smtp-Source: ACHHUZ7r4si2IcQKI55bOSM8SHxJbAhndrnIqDFmjr9vqnHPxyaBa77OMmwMCW0FKU1TUemviXs4kKMtvfhR
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:2183:b0:643:a542:b311 with SMTP
 id h3-20020a056a00218300b00643a542b311mr4840248pfi.0.1685722161708; Fri, 02
 Jun 2023 09:09:21 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:08:59 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-2-vipinsh@google.com>
Subject: [PATCH v2 01/16] KVM: selftests: Clear dirty logs in user defined
 chunks sizes in dirty_log_perf_test
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In dirty_log_perf_test, provide a new option 'k' to specify the size of
the chunks and clear dirty memory in chunks in each iteration. If option
is not provided then fallback to the old way of clearing whole memslot
in one call in each iteration.

In production environment whole memslot is rarely cleared in a single
call, instead clearing operation is split across multiple calls to
reduce time between clearing and sending memory to a remote host. This
change mimics the production usecases and allows to get performance
numbers based on that.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index e9d6d1aecf89..119ddfc7306e 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -134,6 +134,7 @@ struct test_params {
 	uint32_t write_percent;
 	uint32_t random_seed;
 	bool random_access;
+	uint64_t clear_chunk_size;
 };
 
 static void toggle_dirty_logging(struct kvm_vm *vm, int slots, bool enable)
@@ -169,16 +170,28 @@ static void get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int slots
 	}
 }
 
-static void clear_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[],
-			    int slots, uint64_t pages_per_slot)
+static void clear_dirty_log_in_chunks(struct kvm_vm *vm,
+				      unsigned long *bitmaps[], int slots,
+				      uint64_t pages_per_slot,
+				      uint64_t pages_per_clear)
 {
-	int i;
+	uint64_t from, clear_pages_count;
+	int i, slot;
 
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
 
 static unsigned long **alloc_bitmaps(int slots, uint64_t pages_per_slot)
@@ -215,6 +228,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	uint64_t guest_num_pages;
 	uint64_t host_num_pages;
 	uint64_t pages_per_slot;
+	uint64_t pages_per_clear;
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec get_dirty_log_total = (struct timespec){0};
@@ -235,6 +249,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
+	pages_per_clear = p->clear_chunk_size / getpagesize();
 
 	bitmaps = alloc_bitmaps(p->slots, pages_per_slot);
 
@@ -315,7 +330,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		if (dirty_log_manual_caps) {
 			clock_gettime(CLOCK_MONOTONIC, &start);
-			clear_dirty_log(vm, bitmaps, p->slots, pages_per_slot);
+			clear_dirty_log_in_chunks(vm, bitmaps, p->slots,
+						  pages_per_slot,
+						  pages_per_clear);
 			ts_diff = timespec_elapsed(start);
 			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
 							     ts_diff);
@@ -413,6 +430,11 @@ static void help(char *name)
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
@@ -428,6 +450,7 @@ int main(int argc, char *argv[])
 		.slots = 1,
 		.random_seed = 1,
 		.write_percent = 100,
+		.clear_chunk_size = UINT64_MAX,
 	};
 	int opt;
 
@@ -438,7 +461,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ab:c:eghi:m:nop:r:s:v:x:w:")) != -1) {
+	while ((opt = getopt(argc, argv, "ab:c:eghi:k:m:nop:r:s:v:x:w:")) != -1) {
 		switch (opt) {
 		case 'a':
 			p.random_access = true;
@@ -462,6 +485,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			p.iterations = atoi_positive("Number of iterations", optarg);
 			break;
+		case 'k':
+			p.clear_chunk_size = parse_size(optarg);
+			break;
 		case 'm':
 			guest_modes_cmdline(optarg);
 			break;
-- 
2.41.0.rc0.172.g3f132b7071-goog

