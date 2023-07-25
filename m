Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BD760D2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGYIiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGYIhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:37:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72DB1990;
        Tue, 25 Jul 2023 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274252; x=1721810252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJ2nqGe74BjaRFSg6RxzVzjGtWxWkMd4I6poPlzEJrw=;
  b=PZpjBRAJ0Leo1SqD7hEE+puGmfVJYrfBVdkJH9o5iHoSMp59VtK02fj+
   9Sakzp60gJ9Xbn75w0EmEGA49f4OYJ43j+16G96rIFz2KDMaZpM9xEyQQ
   gHgDhUWdq9/AsSxVwEj1bbqaxG9HfSEzaMd2XCQw3RIlBbh+ngmgOOtqf
   b/vQmW+CFoL2+HxsuFkys3Txpgz1xUYI1CctL14WFSBU1sO4eXyGRqekz
   3B4XDRIdLkLyUcfLwJsS4aSsz/LwoScoC2nLwfFKu2kStnbvEUrFJ1b+B
   DFVcZPve0nbVlEGGhWl3rg0k1f8rvscjVoNMb+rIX7FyzqJZzUEqSQnhu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371264608"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371264608"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761130336"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761130336"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:37:23 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        maz@kernel.org, oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 06/13] KVM: arm64: selftests: Split get-reg-list test code
Date:   Tue, 25 Jul 2023 16:41:32 +0800
Message-Id: <1f25f27d1316bc91e1e31cd3d50a1d20f696759a.1690273969.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690273969.git.haibo1.xu@intel.com>
References: <cover.1690273969.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Jones <ajones@ventanamicro.com>

Split the arch-neutral test code out of aarch64/get-reg-list.c into
get-reg-list.c. To do this we invent a new make variable
$(SPLIT_TESTS) which expects common parts to be in the KVM selftests
root and the counterparts to have the same name, but be in
$(ARCH_DIR).

There's still some work to be done to de-aarch64 the common
get-reg-list.c, but we leave that to the next patch to avoid
modifying too much code while moving it.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |  12 +-
 .../selftests/kvm/aarch64/get-reg-list.c      | 367 +----------------
 tools/testing/selftests/kvm/get-reg-list.c    | 377 ++++++++++++++++++
 3 files changed, 398 insertions(+), 358 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/get-reg-list.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c692cc86e7da..95f180e711d5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -140,7 +140,6 @@ TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
 TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
 TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
-TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
 TEST_GEN_PROGS_aarch64 += aarch64/psci_test
@@ -152,6 +151,7 @@ TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
+TEST_GEN_PROGS_aarch64 += get-reg-list
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += memslot_modification_stress_test
@@ -181,6 +181,8 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
+SPLIT_TESTS += get-reg-list
+
 TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
@@ -228,11 +230,14 @@ LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
+SPLIT_TESTS_TARGETS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
+SPLIT_TESTS_OBJS := $(patsubst %, $(ARCH_DIR)/%.o, $(SPLIT_TESTS))
 
 TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
 TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
 -include $(TEST_DEP_FILES)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
@@ -240,7 +245,10 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
 $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
+$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
+
+EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLIT_TESTS_OBJS) cscope.*
 
 x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c
diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 11630bbfb86b..f72f1a522ff4 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -4,37 +4,17 @@
  *
  * Copyright (C) 2020, Red Hat, Inc.
  *
- * When attempting to migrate from a host with an older kernel to a host
- * with a newer kernel we allow the newer kernel on the destination to
- * list new registers with get-reg-list. We assume they'll be unused, at
- * least until the guest reboots, and so they're relatively harmless.
- * However, if the destination host with the newer kernel is missing
- * registers which the source host with the older kernel has, then that's
- * a regression in get-reg-list. This test checks for that regression by
- * checking the current list against a blessed list. We should never have
- * missing registers, but if new ones appear then they can probably be
- * added to the blessed list. A completely new blessed list can be created
- * by running the test with the --list command line argument.
- *
- * Note, the blessed list should be created from the oldest possible
- * kernel. We can't go older than v5.2, though, because that's the first
+ * While the blessed list should be created from the oldest possible
+ * kernel, we can't go older than v5.2, though, because that's the first
  * release which includes df205b5c6328 ("KVM: arm64: Filter out invalid
  * core register IDs in KVM_GET_REG_LIST"). Without that commit the core
  * registers won't match expectations.
  */
 #include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include "kvm_util.h"
 #include "test_util.h"
 #include "processor.h"
 
-static struct kvm_reg_list *reg_list;
-static __u64 *blessed_reg, blessed_n;
-
 struct feature_id_reg {
 	__u64 reg;
 	__u64 id_reg;
@@ -63,55 +43,7 @@ static struct feature_id_reg feat_id_regs[] = {
 	}
 };
 
-static struct vcpu_reg_list *vcpu_configs[];
-static int vcpu_configs_n;
-
-#define for_each_sublist(c, s)							\
-	for ((s) = &(c)->sublists[0]; (s)->regs; ++(s))
-
-#define for_each_reg(i)								\
-	for ((i) = 0; (i) < reg_list->n; ++(i))
-
-#define for_each_reg_filtered(i)						\
-	for_each_reg(i)								\
-		if (!filter_reg(reg_list->reg[i]))
-
-#define for_each_missing_reg(i)							\
-	for ((i) = 0; (i) < blessed_n; ++(i))					\
-		if (!find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))	\
-			if (check_supported_feat_reg(vcpu, blessed_reg[i]))
-
-#define for_each_new_reg(i)							\
-	for_each_reg_filtered(i)						\
-		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
-
-static const char *config_name(struct vcpu_reg_list *c)
-{
-	struct vcpu_reg_sublist *s;
-	int len = 0;
-
-	if (c->name)
-		return c->name;
-
-	for_each_sublist(c, s)
-		len += strlen(s->name) + 1;
-
-	c->name = malloc(len);
-
-	len = 0;
-	for_each_sublist(c, s) {
-		if (!strcmp(s->name, "base"))
-			continue;
-		strcat(c->name + len, s->name);
-		len += strlen(s->name) + 1;
-		c->name[len - 1] = '+';
-	}
-	c->name[len - 1] = '\0';
-
-	return c->name;
-}
-
-static bool filter_reg(__u64 reg)
+bool filter_reg(__u64 reg)
 {
 	/*
 	 * DEMUX register presence depends on the host's CLIDR_EL1.
@@ -123,16 +55,6 @@ static bool filter_reg(__u64 reg)
 	return false;
 }
 
-static bool find_reg(__u64 regs[], __u64 nr_regs, __u64 reg)
-{
-	int i;
-
-	for (i = 0; i < nr_regs; ++i)
-		if (reg == regs[i])
-			return true;
-	return false;
-}
-
 static bool check_supported_feat_reg(struct kvm_vcpu *vcpu, __u64 reg)
 {
 	int i, ret;
@@ -152,6 +74,11 @@ static bool check_supported_feat_reg(struct kvm_vcpu *vcpu, __u64 reg)
 	return true;
 }
 
+bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
+{
+	return check_supported_feat_reg(vcpu, reg);
+}
+
 #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_COPROC_MASK)
 
 #define CORE_REGS_XX_NR_WORDS	2
@@ -235,7 +162,7 @@ static const char *sve_id_to_str(const char *prefix, __u64 id)
 	return NULL;
 }
 
-static void print_reg(const char *prefix, __u64 id)
+void print_reg(const char *prefix, __u64 id)
 {
 	unsigned op0, op1, crn, crm, op2;
 	const char *reg_size = NULL;
@@ -315,278 +242,6 @@ static void print_reg(const char *prefix, __u64 id)
 	}
 }
 
-static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
-{
-	struct vcpu_reg_sublist *s;
-
-	for_each_sublist(c, s)
-		if (s->capability)
-			init->features[s->feature / 32] |= 1 << (s->feature % 32);
-}
-
-static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
-{
-	struct vcpu_reg_sublist *s;
-	int feature;
-
-	for_each_sublist(c, s) {
-		if (s->finalize) {
-			feature = s->feature;
-			vcpu_ioctl(vcpu, KVM_ARM_VCPU_FINALIZE, &feature);
-		}
-	}
-}
-
-static void check_supported(struct vcpu_reg_list *c)
-{
-	struct vcpu_reg_sublist *s;
-
-	for_each_sublist(c, s) {
-		if (!s->capability)
-			continue;
-
-		__TEST_REQUIRE(kvm_has_cap(s->capability),
-			       "%s: %s not available, skipping tests\n",
-			       config_name(c), s->name);
-	}
-}
-
-static bool print_list;
-static bool print_filtered;
-
-static void run_test(struct vcpu_reg_list *c)
-{
-	struct kvm_vcpu_init init = { .target = -1, };
-	int new_regs = 0, missing_regs = 0, i, n;
-	int failed_get = 0, failed_set = 0, failed_reject = 0;
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-	struct vcpu_reg_sublist *s;
-
-	check_supported(c);
-
-	vm = vm_create_barebones();
-	prepare_vcpu_init(c, &init);
-	vcpu = __vm_vcpu_add(vm, 0);
-	aarch64_vcpu_setup(vcpu, &init);
-	finalize_vcpu(vcpu, c);
-
-	reg_list = vcpu_get_reg_list(vcpu);
-
-	if (print_list || print_filtered) {
-		putchar('\n');
-		for_each_reg(i) {
-			__u64 id = reg_list->reg[i];
-			if ((print_list && !filter_reg(id)) ||
-			    (print_filtered && filter_reg(id)))
-				print_reg(config_name(c), id);
-		}
-		putchar('\n');
-		return;
-	}
-
-	/*
-	 * We only test that we can get the register and then write back the
-	 * same value. Some registers may allow other values to be written
-	 * back, but others only allow some bits to be changed, and at least
-	 * for ID registers set will fail if the value does not exactly match
-	 * what was returned by get. If registers that allow other values to
-	 * be written need to have the other values tested, then we should
-	 * create a new set of tests for those in a new independent test
-	 * executable.
-	 */
-	for_each_reg(i) {
-		uint8_t addr[2048 / 8];
-		struct kvm_one_reg reg = {
-			.id = reg_list->reg[i],
-			.addr = (__u64)&addr,
-		};
-		bool reject_reg = false;
-		int ret;
-
-		ret = __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
-		if (ret) {
-			printf("%s: Failed to get ", config_name(c));
-			print_reg(config_name(c), reg.id);
-			putchar('\n');
-			++failed_get;
-		}
-
-		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
-		for_each_sublist(c, s) {
-			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
-				reject_reg = true;
-				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
-				if (ret != -1 || errno != EPERM) {
-					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
-					print_reg(config_name(c), reg.id);
-					putchar('\n');
-					++failed_reject;
-				}
-				break;
-			}
-		}
-
-		if (!reject_reg) {
-			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
-			if (ret) {
-				printf("%s: Failed to set ", config_name(c));
-				print_reg(config_name(c), reg.id);
-				putchar('\n');
-				++failed_set;
-			}
-		}
-	}
-
-	for_each_sublist(c, s)
-		blessed_n += s->regs_n;
-	blessed_reg = calloc(blessed_n, sizeof(__u64));
-
-	n = 0;
-	for_each_sublist(c, s) {
-		for (i = 0; i < s->regs_n; ++i)
-			blessed_reg[n++] = s->regs[i];
-	}
-
-	for_each_new_reg(i)
-		++new_regs;
-
-	for_each_missing_reg(i)
-		++missing_regs;
-
-	if (new_regs || missing_regs) {
-		n = 0;
-		for_each_reg_filtered(i)
-			++n;
-
-		printf("%s: Number blessed registers: %5lld\n", config_name(c), blessed_n);
-		printf("%s: Number registers:         %5lld (includes %lld filtered registers)\n",
-		       config_name(c), reg_list->n, reg_list->n - n);
-	}
-
-	if (new_regs) {
-		printf("\n%s: There are %d new registers.\n"
-		       "Consider adding them to the blessed reg "
-		       "list with the following lines:\n\n", config_name(c), new_regs);
-		for_each_new_reg(i)
-			print_reg(config_name(c), reg_list->reg[i]);
-		putchar('\n');
-	}
-
-	if (missing_regs) {
-		printf("\n%s: There are %d missing registers.\n"
-		       "The following lines are missing registers:\n\n", config_name(c), missing_regs);
-		for_each_missing_reg(i)
-			print_reg(config_name(c), blessed_reg[i]);
-		putchar('\n');
-	}
-
-	TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !failed_reject,
-		    "%s: There are %d missing registers; "
-		    "%d registers failed get; %d registers failed set; %d registers failed reject",
-		    config_name(c), missing_regs, failed_get, failed_set, failed_reject);
-
-	pr_info("%s: PASS\n", config_name(c));
-	blessed_n = 0;
-	free(blessed_reg);
-	free(reg_list);
-	kvm_vm_free(vm);
-}
-
-static void help(void)
-{
-	struct vcpu_reg_list *c;
-	int i;
-
-	printf(
-	"\n"
-	"usage: get-reg-list [--config=<selection>] [--list] [--list-filtered]\n\n"
-	" --config=<selection>        Used to select a specific vcpu configuration for the test/listing\n"
-	"                             '<selection>' may be\n");
-
-	for (i = 0; i < vcpu_configs_n; ++i) {
-		c = vcpu_configs[i];
-		printf(
-	"                               '%s'\n", config_name(c));
-	}
-
-	printf(
-	"\n"
-	" --list                      Print the register list rather than test it (requires --config)\n"
-	" --list-filtered             Print registers that would normally be filtered out (requires --config)\n"
-	"\n"
-	);
-}
-
-static struct vcpu_reg_list *parse_config(const char *config)
-{
-	struct vcpu_reg_list *c;
-	int i;
-
-	if (config[8] != '=')
-		help(), exit(1);
-
-	for (i = 0; i < vcpu_configs_n; ++i) {
-		c = vcpu_configs[i];
-		if (strcmp(config_name(c), &config[9]) == 0)
-			break;
-	}
-
-	if (i == vcpu_configs_n)
-		help(), exit(1);
-
-	return c;
-}
-
-int main(int ac, char **av)
-{
-	struct vcpu_reg_list *c, *sel = NULL;
-	int i, ret = 0;
-	pid_t pid;
-
-	for (i = 1; i < ac; ++i) {
-		if (strncmp(av[i], "--config", 8) == 0)
-			sel = parse_config(av[i]);
-		else if (strcmp(av[i], "--list") == 0)
-			print_list = true;
-		else if (strcmp(av[i], "--list-filtered") == 0)
-			print_filtered = true;
-		else if (strcmp(av[i], "--help") == 0 || strcmp(av[1], "-h") == 0)
-			help(), exit(0);
-		else
-			help(), exit(1);
-	}
-
-	if (print_list || print_filtered) {
-		/*
-		 * We only want to print the register list of a single config.
-		 */
-		if (!sel)
-			help(), exit(1);
-	}
-
-	for (i = 0; i < vcpu_configs_n; ++i) {
-		c = vcpu_configs[i];
-		if (sel && c != sel)
-			continue;
-
-		pid = fork();
-
-		if (!pid) {
-			run_test(c);
-			exit(0);
-		} else {
-			int wstatus;
-			pid_t wpid = wait(&wstatus);
-			TEST_ASSERT(wpid == pid && WIFEXITED(wstatus), "wait: Unexpected return");
-			if (WEXITSTATUS(wstatus) && WEXITSTATUS(wstatus) != KSFT_SKIP)
-				ret = KSFT_FAIL;
-		}
-	}
-
-	return ret;
-}
-
 /*
  * The original blessed list was primed with the output of kernel version
  * v4.15 with --core-reg-fixup and then later updated with new registers.
@@ -1073,7 +728,7 @@ static struct vcpu_reg_list pauth_pmu_config = {
 	},
 };
 
-static struct vcpu_reg_list *vcpu_configs[] = {
+struct vcpu_reg_list *vcpu_configs[] = {
 	&vregs_config,
 	&vregs_pmu_config,
 	&sve_config,
@@ -1081,4 +736,4 @@ static struct vcpu_reg_list *vcpu_configs[] = {
 	&pauth_config,
 	&pauth_pmu_config,
 };
-static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
+int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
new file mode 100644
index 000000000000..a29e548643d1
--- /dev/null
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check for KVM_GET_REG_LIST regressions.
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ *
+ * When attempting to migrate from a host with an older kernel to a host
+ * with a newer kernel we allow the newer kernel on the destination to
+ * list new registers with get-reg-list. We assume they'll be unused, at
+ * least until the guest reboots, and so they're relatively harmless.
+ * However, if the destination host with the newer kernel is missing
+ * registers which the source host with the older kernel has, then that's
+ * a regression in get-reg-list. This test checks for that regression by
+ * checking the current list against a blessed list. We should never have
+ * missing registers, but if new ones appear then they can probably be
+ * added to the blessed list. A completely new blessed list can be created
+ * by running the test with the --list command line argument.
+ *
+ * The blessed list should be created from the oldest possible kernel.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+
+static struct kvm_reg_list *reg_list;
+static __u64 *blessed_reg, blessed_n;
+
+extern struct vcpu_reg_list *vcpu_configs[];
+extern int vcpu_configs_n;
+
+#define for_each_sublist(c, s)							\
+	for ((s) = &(c)->sublists[0]; (s)->regs; ++(s))
+
+#define for_each_reg(i)								\
+	for ((i) = 0; (i) < reg_list->n; ++(i))
+
+#define for_each_reg_filtered(i)						\
+	for_each_reg(i)								\
+		if (!filter_reg(reg_list->reg[i]))
+
+#define for_each_missing_reg(i)							\
+	for ((i) = 0; (i) < blessed_n; ++(i))					\
+		if (!find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))	\
+			if (check_supported_reg(vcpu, blessed_reg[i]))
+
+#define for_each_new_reg(i)							\
+	for_each_reg_filtered(i)						\
+		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
+
+static const char *config_name(struct vcpu_reg_list *c)
+{
+	struct vcpu_reg_sublist *s;
+	int len = 0;
+
+	if (c->name)
+		return c->name;
+
+	for_each_sublist(c, s)
+		len += strlen(s->name) + 1;
+
+	c->name = malloc(len);
+
+	len = 0;
+	for_each_sublist(c, s) {
+		if (!strcmp(s->name, "base"))
+			continue;
+		strcat(c->name + len, s->name);
+		len += strlen(s->name) + 1;
+		c->name[len - 1] = '+';
+	}
+	c->name[len - 1] = '\0';
+
+	return c->name;
+}
+
+bool __weak check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
+{
+	return true;
+}
+
+bool __weak filter_reg(__u64 reg)
+{
+	return false;
+}
+
+static bool find_reg(__u64 regs[], __u64 nr_regs, __u64 reg)
+{
+	int i;
+
+	for (i = 0; i < nr_regs; ++i)
+		if (reg == regs[i])
+			return true;
+	return false;
+}
+
+void __weak print_reg(const char *prefix, __u64 id)
+{
+	printf("\t0x%llx,\n", id);
+}
+
+static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
+{
+	struct vcpu_reg_sublist *s;
+
+	for_each_sublist(c, s)
+		if (s->capability)
+			init->features[s->feature / 32] |= 1 << (s->feature % 32);
+}
+
+static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
+{
+	struct vcpu_reg_sublist *s;
+	int feature;
+
+	for_each_sublist(c, s) {
+		if (s->finalize) {
+			feature = s->feature;
+			vcpu_ioctl(vcpu, KVM_ARM_VCPU_FINALIZE, &feature);
+		}
+	}
+}
+
+static void check_supported(struct vcpu_reg_list *c)
+{
+	struct vcpu_reg_sublist *s;
+
+	for_each_sublist(c, s) {
+		if (!s->capability)
+			continue;
+
+		__TEST_REQUIRE(kvm_has_cap(s->capability),
+			       "%s: %s not available, skipping tests\n",
+			       config_name(c), s->name);
+	}
+}
+
+static bool print_list;
+static bool print_filtered;
+
+static void run_test(struct vcpu_reg_list *c)
+{
+	struct kvm_vcpu_init init = { .target = -1, };
+	int new_regs = 0, missing_regs = 0, i, n;
+	int failed_get = 0, failed_set = 0, failed_reject = 0;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct vcpu_reg_sublist *s;
+
+	check_supported(c);
+
+	vm = vm_create_barebones();
+	prepare_vcpu_init(c, &init);
+	vcpu = __vm_vcpu_add(vm, 0);
+	aarch64_vcpu_setup(vcpu, &init);
+	finalize_vcpu(vcpu, c);
+
+	reg_list = vcpu_get_reg_list(vcpu);
+
+	if (print_list || print_filtered) {
+		putchar('\n');
+		for_each_reg(i) {
+			__u64 id = reg_list->reg[i];
+			if ((print_list && !filter_reg(id)) ||
+			    (print_filtered && filter_reg(id)))
+				print_reg(config_name(c), id);
+		}
+		putchar('\n');
+		return;
+	}
+
+	/*
+	 * We only test that we can get the register and then write back the
+	 * same value. Some registers may allow other values to be written
+	 * back, but others only allow some bits to be changed, and at least
+	 * for ID registers set will fail if the value does not exactly match
+	 * what was returned by get. If registers that allow other values to
+	 * be written need to have the other values tested, then we should
+	 * create a new set of tests for those in a new independent test
+	 * executable.
+	 */
+	for_each_reg(i) {
+		uint8_t addr[2048 / 8];
+		struct kvm_one_reg reg = {
+			.id = reg_list->reg[i],
+			.addr = (__u64)&addr,
+		};
+		bool reject_reg = false;
+		int ret;
+
+		ret = __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
+		if (ret) {
+			printf("%s: Failed to get ", config_name(c));
+			print_reg(config_name(c), reg.id);
+			putchar('\n');
+			++failed_get;
+		}
+
+		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
+		for_each_sublist(c, s) {
+			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
+				reject_reg = true;
+				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+				if (ret != -1 || errno != EPERM) {
+					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
+					print_reg(config_name(c), reg.id);
+					putchar('\n');
+					++failed_reject;
+				}
+				break;
+			}
+		}
+
+		if (!reject_reg) {
+			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+			if (ret) {
+				printf("%s: Failed to set ", config_name(c));
+				print_reg(config_name(c), reg.id);
+				putchar('\n');
+				++failed_set;
+			}
+		}
+	}
+
+	for_each_sublist(c, s)
+		blessed_n += s->regs_n;
+	blessed_reg = calloc(blessed_n, sizeof(__u64));
+
+	n = 0;
+	for_each_sublist(c, s) {
+		for (i = 0; i < s->regs_n; ++i)
+			blessed_reg[n++] = s->regs[i];
+	}
+
+	for_each_new_reg(i)
+		++new_regs;
+
+	for_each_missing_reg(i)
+		++missing_regs;
+
+	if (new_regs || missing_regs) {
+		n = 0;
+		for_each_reg_filtered(i)
+			++n;
+
+		printf("%s: Number blessed registers: %5lld\n", config_name(c), blessed_n);
+		printf("%s: Number registers:         %5lld (includes %lld filtered registers)\n",
+		       config_name(c), reg_list->n, reg_list->n - n);
+	}
+
+	if (new_regs) {
+		printf("\n%s: There are %d new registers.\n"
+		       "Consider adding them to the blessed reg "
+		       "list with the following lines:\n\n", config_name(c), new_regs);
+		for_each_new_reg(i)
+			print_reg(config_name(c), reg_list->reg[i]);
+		putchar('\n');
+	}
+
+	if (missing_regs) {
+		printf("\n%s: There are %d missing registers.\n"
+		       "The following lines are missing registers:\n\n", config_name(c), missing_regs);
+		for_each_missing_reg(i)
+			print_reg(config_name(c), blessed_reg[i]);
+		putchar('\n');
+	}
+
+	TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !failed_reject,
+		    "%s: There are %d missing registers; "
+		    "%d registers failed get; %d registers failed set; %d registers failed reject",
+		    config_name(c), missing_regs, failed_get, failed_set, failed_reject);
+
+	pr_info("%s: PASS\n", config_name(c));
+	blessed_n = 0;
+	free(blessed_reg);
+	free(reg_list);
+	kvm_vm_free(vm);
+}
+
+static void help(void)
+{
+	struct vcpu_reg_list *c;
+	int i;
+
+	printf(
+	"\n"
+	"usage: get-reg-list [--config=<selection>] [--list] [--list-filtered]\n\n"
+	" --config=<selection>        Used to select a specific vcpu configuration for the test/listing\n"
+	"                             '<selection>' may be\n");
+
+	for (i = 0; i < vcpu_configs_n; ++i) {
+		c = vcpu_configs[i];
+		printf(
+	"                               '%s'\n", config_name(c));
+	}
+
+	printf(
+	"\n"
+	" --list                      Print the register list rather than test it (requires --config)\n"
+	" --list-filtered             Print registers that would normally be filtered out (requires --config)\n"
+	"\n"
+	);
+}
+
+static struct vcpu_reg_list *parse_config(const char *config)
+{
+	struct vcpu_reg_list *c = NULL;
+	int i;
+
+	if (config[8] != '=')
+		help(), exit(1);
+
+	for (i = 0; i < vcpu_configs_n; ++i) {
+		c = vcpu_configs[i];
+		if (strcmp(config_name(c), &config[9]) == 0)
+			break;
+	}
+
+	if (i == vcpu_configs_n)
+		help(), exit(1);
+
+	return c;
+}
+
+int main(int ac, char **av)
+{
+	struct vcpu_reg_list *c, *sel = NULL;
+	int i, ret = 0;
+	pid_t pid;
+
+	for (i = 1; i < ac; ++i) {
+		if (strncmp(av[i], "--config", 8) == 0)
+			sel = parse_config(av[i]);
+		else if (strcmp(av[i], "--list") == 0)
+			print_list = true;
+		else if (strcmp(av[i], "--list-filtered") == 0)
+			print_filtered = true;
+		else if (strcmp(av[i], "--help") == 0 || strcmp(av[1], "-h") == 0)
+			help(), exit(0);
+		else
+			help(), exit(1);
+	}
+
+	if (print_list || print_filtered) {
+		/*
+		 * We only want to print the register list of a single config.
+		 */
+		if (!sel)
+			help(), exit(1);
+	}
+
+	for (i = 0; i < vcpu_configs_n; ++i) {
+		c = vcpu_configs[i];
+		if (sel && c != sel)
+			continue;
+
+		pid = fork();
+
+		if (!pid) {
+			run_test(c);
+			exit(0);
+		} else {
+			int wstatus;
+			pid_t wpid = wait(&wstatus);
+			TEST_ASSERT(wpid == pid && WIFEXITED(wstatus), "wait: Unexpected return");
+			if (WEXITSTATUS(wstatus) && WEXITSTATUS(wstatus) != KSFT_SKIP)
+				ret = KSFT_FAIL;
+		}
+	}
+
+	return ret;
+}
-- 
2.34.1

