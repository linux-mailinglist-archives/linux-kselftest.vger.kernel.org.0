Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4F9728D85
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 04:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjFICHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 22:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbjFICHg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 22:07:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7964B269A;
        Thu,  8 Jun 2023 19:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686276454; x=1717812454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6K9gSvU7bcUbXrx95jbbHrZ95LKmm3Z9olehgFYx8q4=;
  b=fTSEem9efcUd43nppI5ue6eS8joh2JxURu2yWrlaoqO9GuIFG13KtRVf
   WwcGYzD4iZH9QLJT/lY3IG8+BOxYgWEqUntPo4MwgWwufJlRs7vvRKk2z
   igJjEBUcVe2UcU6CDMSyW5b8l+jPr0p454B8albzcqEv3X0snM8e9mvzg
   NYKp+Yt0ZzO0zHA+CZs4rSGH51xtxgZ8yseynWHES8dJ3fKg+WXeCBxWW
   jr/hS4FtPaShV72hA18sqJOZ6L2sso1I+in51g9mKfqJBbLzSTBnoX2t+
   dMd4NrXq5P6s38C0dMfuJAPecoy+8hZP5t5XgeDJPyjpQz5XEGp2oEeMn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="359975336"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="359975336"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 19:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713334688"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713334688"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 19:07:01 -0700
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
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v3 04/10] KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
Date:   Fri,  9 Jun 2023 10:12:12 +0800
Message-Id: <90c0c3edb2f61b70ff563f13e405d5dcee7f81d6.1686275310.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1686275310.git.haibo1.xu@intel.com>
References: <cover.1686275310.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Jones <ajones@ventanamicro.com>

Rename vcpu_config to vcpu_reg_list to be more specific and add
it to kvm_util.h. While it may not get used outside get-reg-list
tests, exporting it doesn't hurt, as long as it has a unique enough
name. This is a step in the direction of sharing most of the get-
reg-list test code between architectures.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 60 +++++++------------
 .../selftests/kvm/include/kvm_util_base.h     | 16 +++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 424285d39965..aae2056379f7 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -37,23 +37,7 @@
 static struct kvm_reg_list *reg_list;
 static __u64 *blessed_reg, blessed_n;
 
-struct reg_sublist {
-	const char *name;
-	long capability;
-	int feature;
-	bool finalize;
-	__u64 *regs;
-	__u64 regs_n;
-	__u64 *rejects_set;
-	__u64 rejects_set_n;
-};
-
-struct vcpu_config {
-	char *name;
-	struct reg_sublist sublists[];
-};
-
-static struct vcpu_config *vcpu_configs[];
+static struct vcpu_reg_list *vcpu_configs[];
 static int vcpu_configs_n;
 
 #define for_each_sublist(c, s)							\
@@ -74,9 +58,9 @@ static int vcpu_configs_n;
 	for_each_reg_filtered(i)						\
 		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
 
-static const char *config_name(struct vcpu_config *c)
+static const char *config_name(struct vcpu_reg_list *c)
 {
-	struct reg_sublist *s;
+	struct vcpu_reg_sublist *s;
 	int len = 0;
 
 	if (c->name)
@@ -342,18 +326,18 @@ static void core_reg_fixup(void)
 	reg_list = tmp;
 }
 
-static void prepare_vcpu_init(struct vcpu_config *c, struct kvm_vcpu_init *init)
+static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
 {
-	struct reg_sublist *s;
+	struct vcpu_reg_sublist *s;
 
 	for_each_sublist(c, s)
 		if (s->capability)
 			init->features[s->feature / 32] |= 1 << (s->feature % 32);
 }
 
-static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_config *c)
+static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
-	struct reg_sublist *s;
+	struct vcpu_reg_sublist *s;
 	int feature;
 
 	for_each_sublist(c, s) {
@@ -364,9 +348,9 @@ static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_config *c)
 	}
 }
 
-static void check_supported(struct vcpu_config *c)
+static void check_supported(struct vcpu_reg_list *c)
 {
-	struct reg_sublist *s;
+	struct vcpu_reg_sublist *s;
 
 	for_each_sublist(c, s) {
 		if (!s->capability)
@@ -382,14 +366,14 @@ static bool print_list;
 static bool print_filtered;
 static bool fixup_core_regs;
 
-static void run_test(struct vcpu_config *c)
+static void run_test(struct vcpu_reg_list *c)
 {
 	struct kvm_vcpu_init init = { .target = -1, };
 	int new_regs = 0, missing_regs = 0, i, n;
 	int failed_get = 0, failed_set = 0, failed_reject = 0;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	struct reg_sublist *s;
+	struct vcpu_reg_sublist *s;
 
 	check_supported(c);
 
@@ -526,7 +510,7 @@ static void run_test(struct vcpu_config *c)
 
 static void help(void)
 {
-	struct vcpu_config *c;
+	struct vcpu_reg_list *c;
 	int i;
 
 	printf(
@@ -550,9 +534,9 @@ static void help(void)
 	);
 }
 
-static struct vcpu_config *parse_config(const char *config)
+static struct vcpu_reg_list *parse_config(const char *config)
 {
-	struct vcpu_config *c;
+	struct vcpu_reg_list *c;
 	int i;
 
 	if (config[8] != '=')
@@ -572,7 +556,7 @@ static struct vcpu_config *parse_config(const char *config)
 
 int main(int ac, char **av)
 {
-	struct vcpu_config *c, *sel = NULL;
+	struct vcpu_reg_list *c, *sel = NULL;
 	int i, ret = 0;
 	pid_t pid;
 
@@ -1053,14 +1037,14 @@ static __u64 pauth_generic_regs[] = {
 		.regs_n		= ARRAY_SIZE(pauth_generic_regs),	\
 	}
 
-static struct vcpu_config vregs_config = {
+static struct vcpu_reg_list vregs_config = {
 	.sublists = {
 	BASE_SUBLIST,
 	VREGS_SUBLIST,
 	{0},
 	},
 };
-static struct vcpu_config vregs_pmu_config = {
+static struct vcpu_reg_list vregs_pmu_config = {
 	.sublists = {
 	BASE_SUBLIST,
 	VREGS_SUBLIST,
@@ -1068,14 +1052,14 @@ static struct vcpu_config vregs_pmu_config = {
 	{0},
 	},
 };
-static struct vcpu_config sve_config = {
+static struct vcpu_reg_list sve_config = {
 	.sublists = {
 	BASE_SUBLIST,
 	SVE_SUBLIST,
 	{0},
 	},
 };
-static struct vcpu_config sve_pmu_config = {
+static struct vcpu_reg_list sve_pmu_config = {
 	.sublists = {
 	BASE_SUBLIST,
 	SVE_SUBLIST,
@@ -1083,7 +1067,7 @@ static struct vcpu_config sve_pmu_config = {
 	{0},
 	},
 };
-static struct vcpu_config pauth_config = {
+static struct vcpu_reg_list pauth_config = {
 	.sublists = {
 	BASE_SUBLIST,
 	VREGS_SUBLIST,
@@ -1091,7 +1075,7 @@ static struct vcpu_config pauth_config = {
 	{0},
 	},
 };
-static struct vcpu_config pauth_pmu_config = {
+static struct vcpu_reg_list pauth_pmu_config = {
 	.sublists = {
 	BASE_SUBLIST,
 	VREGS_SUBLIST,
@@ -1101,7 +1085,7 @@ static struct vcpu_config pauth_pmu_config = {
 	},
 };
 
-static struct vcpu_config *vcpu_configs[] = {
+static struct vcpu_reg_list *vcpu_configs[] = {
 	&vregs_config,
 	&vregs_pmu_config,
 	&sve_config,
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a089c356f354..ac4aaa21deee 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/kvm.h>
 #include "linux/rbtree.h"
+#include <linux/types.h>
 
 #include <asm/atomic.h>
 
@@ -124,6 +125,21 @@ struct kvm_vm {
 	uint32_t memslots[NR_MEM_REGIONS];
 };
 
+struct vcpu_reg_sublist {
+	const char *name;
+	long capability;
+	int feature;
+	bool finalize;
+	__u64 *regs;
+	__u64 regs_n;
+	__u64 *rejects_set;
+	__u64 rejects_set_n;
+};
+
+struct vcpu_reg_list {
+	char *name;
+	struct vcpu_reg_sublist sublists[];
+};
 
 #define kvm_for_each_vcpu(vm, i, vcpu)			\
 	for ((i) = 0; (i) <= (vm)->last_vcpu_id; (i)++)	\
-- 
2.34.1

