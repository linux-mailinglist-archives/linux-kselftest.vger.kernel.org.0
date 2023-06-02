Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D097206F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjFBQJ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjFBQJ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:09:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE411B3
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so20407187b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722164; x=1688314164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=reSpQux61RJZJqDsTFoDFmSOkfig6/G5ur1FFXdW+Iw=;
        b=Nery7N09ub9ZwszJcaP2RaQeFUpVfIUClULYoJNCv0nmmaSATwziFhFG6U3dYDLKoQ
         L9drpqC2yL+EBnwjo9iEoiI5SqrPJ4COUeKCUkto6WScJ4k7QxjCwWO+xu6zR2w8Ms7Y
         g71MEHJild0QfvuE9EvmodRfRpkB6FSwoCyRei/rwamIW8aYnRWnvssNIV+xig+yToqy
         7LLYR4U6K3iWH99NzWXy3BA1U6+xbZoa0eqzZ6Q+yGdcRqc3MVym+ONWDEZ2yy/xmSHV
         b2XWmusMNnhXq3avpcOVHAJU3vLRZTkYx3P/807P0dyObmLHptHPl4+5txiV/ugQdwi2
         WupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722164; x=1688314164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reSpQux61RJZJqDsTFoDFmSOkfig6/G5ur1FFXdW+Iw=;
        b=dA8Aq6fDUmkxUgeGX4XfGJ6+tpatD4Lrpacw8Cu5CZd7x3hwgk6GrPqrTZ6H6o72nM
         ZLgPpodPT5y82XUn6ZI2m4daG9t3+duL43NxRF4aFa7uD7LwiZ+1ytSOuUTLe7hyt2Id
         TtHT43TgWNv4AB5UQBak+MpZZ/BrVvzBj1NL+8Nq755ChnmyplysaIO+bdG4h0+FpDW1
         wmwTHd37l/Mk3oYY4NU/HskT8Osqc0QAN/c/mALxuWVVzwGJU7pRFOWQmSZDJIQYMGeF
         geEGt5S8hzBQGfJKI4LCOiRK1fItrHkr+30zt1cEKUn7b6whBqOZIEPjWF4SgFQxJk31
         x9CQ==
X-Gm-Message-State: AC+VfDyZv8XLuBcZ+sz1fAcYBpSHdpkg2Kmqa6PnXll7SLRHFkxwyBr/
        O3yLFyRXa57jksUc8BcZ4xkYp5jy21ir
X-Google-Smtp-Source: ACHHUZ4Q3v0w4Q5HlE0q/no23AAAdsXEAJElE4UvgXKrVWGxv34xFISO1VT+CZ5ao9TA8TGy/Rc8XIiLO5th
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a25:cd0a:0:b0:ba8:918a:ceec with SMTP id
 d10-20020a25cd0a000000b00ba8918aceecmr470216ybf.4.1685722163747; Fri, 02 Jun
 2023 09:09:23 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:00 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-3-vipinsh@google.com>
Subject: [PATCH v2 02/16] KVM: selftests: Add optional delay between
 consecutive clear-dirty-log calls
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

In dirty_log_perf_test, add option "-l" to wait between consecutive
clear-dirty-log calls. Accept delay from user in milliseconds. If option
is not provided then fallback to no wait between clear calls.

This allows dirty_log_perf_test to mimic real world use where after
clearing dirty memory, some time is spent in transferring memory before
making a subsequeunt clear-dirty-log call.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 35 +++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 119ddfc7306e..2e31f13aaba6 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -135,6 +135,7 @@ struct test_params {
 	uint32_t random_seed;
 	bool random_access;
 	uint64_t clear_chunk_size;
+	int clear_chunk_wait_time_ms;
 };
 
 static void toggle_dirty_logging(struct kvm_vm *vm, int slots, bool enable)
@@ -173,8 +174,14 @@ static void get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int slots
 static void clear_dirty_log_in_chunks(struct kvm_vm *vm,
 				      unsigned long *bitmaps[], int slots,
 				      uint64_t pages_per_slot,
-				      uint64_t pages_per_clear)
+				      uint64_t pages_per_clear, int wait_ms,
+				      struct timespec *time_taken)
 {
+	struct timespec wait = {
+		.tv_sec = wait_ms / 1000,
+		.tv_nsec = (wait_ms % 1000) * 1000000ull,
+	};
+	struct timespec start, end;
 	uint64_t from, clear_pages_count;
 	int i, slot;
 
@@ -186,12 +193,17 @@ static void clear_dirty_log_in_chunks(struct kvm_vm *vm,
 		while (from < pages_per_slot) {
 			if (from + clear_pages_count > pages_per_slot)
 				clear_pages_count = pages_per_slot - from;
+			clock_gettime(CLOCK_MONOTONIC, &start);
 			kvm_vm_clear_dirty_log(vm, slot, bitmaps[i], from,
 					       clear_pages_count);
+			end = timespec_elapsed(start);
+			*time_taken = timespec_add(*time_taken, end);
 			from += clear_pages_count;
+			if (wait_ms)
+				nanosleep(&wait, NULL);
+
 		}
 	}
-
 }
 
 static unsigned long **alloc_bitmaps(int slots, uint64_t pages_per_slot)
@@ -329,11 +341,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		if (dirty_log_manual_caps) {
-			clock_gettime(CLOCK_MONOTONIC, &start);
 			clear_dirty_log_in_chunks(vm, bitmaps, p->slots,
 						  pages_per_slot,
-						  pages_per_clear);
-			ts_diff = timespec_elapsed(start);
+						  pages_per_clear,
+						  p->clear_chunk_wait_time_ms,
+						  &ts_diff);
 			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
 							     ts_diff);
 			pr_info("Iteration %d clear dirty log time: %ld.%.9lds\n",
@@ -435,6 +447,11 @@ static void help(char *name)
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
@@ -451,6 +468,7 @@ int main(int argc, char *argv[])
 		.random_seed = 1,
 		.write_percent = 100,
 		.clear_chunk_size = UINT64_MAX,
+		.clear_chunk_wait_time_ms = 0,
 	};
 	int opt;
 
@@ -461,7 +479,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ab:c:eghi:k:m:nop:r:s:v:x:w:")) != -1) {
+	while ((opt = getopt(argc, argv, "ab:c:eghi:k:l:m:nop:r:s:v:x:w:")) != -1) {
 		switch (opt) {
 		case 'a':
 			p.random_access = true;
@@ -488,6 +506,11 @@ int main(int argc, char *argv[])
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
-- 
2.41.0.rc0.172.g3f132b7071-goog

