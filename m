Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE7728D7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbjFICHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbjFICHf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 22:07:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E832685;
        Thu,  8 Jun 2023 19:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686276454; x=1717812454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBFu+kBGGrTvYe0HgskYar8sc+5gymxxNHT6tyryTg0=;
  b=faO2DABKC6Zs6MjRQ862kBVRtxJrHECIdUX06jtuFaVc7WYdNNSJroR5
   omBWJoCDOpCIPpF90LRHKwoE+2repFMNZWWdGGY93zF8QVfElkkFdTpl3
   x2lt22XuRmph5liQ8rGmDwuaYOkpi9EqPxh1b2bvNly6vp71+WsnhpRoJ
   9OXUARpB/vGTs76iFssJLtQ5L89RkvAuPB9YJcXdEnvCes5LKEVA1mpPH
   IhspGM48RJ1AluFe63oMl4Lyn2DiHs//LxxqjK4vAw1BXP7p6M5z9sIue
   m78bQCsM43TwxssQWuHgYbNn4kG/nlPxHZ/0srSST1y3rrfoDh+Bxavnj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="359975423"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="359975423"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 19:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713334760"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713334760"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 19:07:15 -0700
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
Subject: [PATCH v3 05/10] KVM: arm64: selftests: Delete core_reg_fixup
Date:   Fri,  9 Jun 2023 10:12:13 +0800
Message-Id: <9cd851e16921829d68b00f10e33a427824088b91.1686275310.git.haibo1.xu@intel.com>
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

core_reg_fixup() complicates sharing the get-reg-list test with
other architectures. Rather than work at keeping it, with plenty
of #ifdeffery, just delete it, as it's unlikely to test a kernel
based on anything older than v5.2 with the get-reg-list test,
which is a test meant to check for regressions in new kernels.
(And, an older version of the test can still be used for older
kernels if necessary.)

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 83 +++----------------
 1 file changed, 10 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index aae2056379f7..c8b44389d2ee 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -17,12 +17,10 @@
  * by running the test with the --list command line argument.
  *
  * Note, the blessed list should be created from the oldest possible
- * kernel. We can't go older than v4.15, though, because that's the first
- * release to expose the ID system registers in KVM_GET_REG_LIST, see
- * commit 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features
- * from guests"). Also, one must use the --core-reg-fixup command line
- * option when running on an older kernel that doesn't include df205b5c6328
- * ("KVM: arm64: Filter out invalid core register IDs in KVM_GET_REG_LIST")
+ * kernel. We can't go older than v5.2, though, because that's the first
+ * release which includes df205b5c6328 ("KVM: arm64: Filter out invalid
+ * core register IDs in KVM_GET_REG_LIST"). Without that commit the core
+ * registers won't match expectations.
  */
 #include <stdio.h>
 #include <stdlib.h>
@@ -269,63 +267,6 @@ static void print_reg(const char *prefix, __u64 id)
 	}
 }
 
-/*
- * Older kernels listed each 32-bit word of CORE registers separately.
- * For 64 and 128-bit registers we need to ignore the extra words. We
- * also need to fixup the sizes, because the older kernels stated all
- * registers were 64-bit, even when they weren't.
- */
-static void core_reg_fixup(void)
-{
-	struct kvm_reg_list *tmp;
-	__u64 id, core_off;
-	int i;
-
-	tmp = calloc(1, sizeof(*tmp) + reg_list->n * sizeof(__u64));
-
-	for (i = 0; i < reg_list->n; ++i) {
-		id = reg_list->reg[i];
-
-		if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM_CORE) {
-			tmp->reg[tmp->n++] = id;
-			continue;
-		}
-
-		core_off = id & ~REG_MASK;
-
-		switch (core_off) {
-		case 0x52: case 0xd2: case 0xd6:
-			/*
-			 * These offsets are pointing at padding.
-			 * We need to ignore them too.
-			 */
-			continue;
-		case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
-		     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
-			if (core_off & 3)
-				continue;
-			id &= ~KVM_REG_SIZE_MASK;
-			id |= KVM_REG_SIZE_U128;
-			tmp->reg[tmp->n++] = id;
-			continue;
-		case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-		case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-			id &= ~KVM_REG_SIZE_MASK;
-			id |= KVM_REG_SIZE_U32;
-			tmp->reg[tmp->n++] = id;
-			continue;
-		default:
-			if (core_off & 1)
-				continue;
-			tmp->reg[tmp->n++] = id;
-			break;
-		}
-	}
-
-	free(reg_list);
-	reg_list = tmp;
-}
-
 static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
 {
 	struct vcpu_reg_sublist *s;
@@ -364,7 +305,6 @@ static void check_supported(struct vcpu_reg_list *c)
 
 static bool print_list;
 static bool print_filtered;
-static bool fixup_core_regs;
 
 static void run_test(struct vcpu_reg_list *c)
 {
@@ -385,9 +325,6 @@ static void run_test(struct vcpu_reg_list *c)
 
 	reg_list = vcpu_get_reg_list(vcpu);
 
-	if (fixup_core_regs)
-		core_reg_fixup();
-
 	if (print_list || print_filtered) {
 		putchar('\n');
 		for_each_reg(i) {
@@ -515,7 +452,7 @@ static void help(void)
 
 	printf(
 	"\n"
-	"usage: get-reg-list [--config=<selection>] [--list] [--list-filtered] [--core-reg-fixup]\n\n"
+	"usage: get-reg-list [--config=<selection>] [--list] [--list-filtered]\n\n"
 	" --config=<selection>        Used to select a specific vcpu configuration for the test/listing\n"
 	"                             '<selection>' may be\n");
 
@@ -529,7 +466,6 @@ static void help(void)
 	"\n"
 	" --list                      Print the register list rather than test it (requires --config)\n"
 	" --list-filtered             Print registers that would normally be filtered out (requires --config)\n"
-	" --core-reg-fixup            Needed when running on old kernels with broken core reg listings\n"
 	"\n"
 	);
 }
@@ -561,9 +497,7 @@ int main(int ac, char **av)
 	pid_t pid;
 
 	for (i = 1; i < ac; ++i) {
-		if (strcmp(av[i], "--core-reg-fixup") == 0)
-			fixup_core_regs = true;
-		else if (strncmp(av[i], "--config", 8) == 0)
+		if (strncmp(av[i], "--config", 8) == 0)
 			sel = parse_config(av[i]);
 		else if (strcmp(av[i], "--list") == 0)
 			print_list = true;
@@ -606,8 +540,11 @@ int main(int ac, char **av)
 }
 
 /*
- * The current blessed list was primed with the output of kernel version
+ * The original blessed list was primed with the output of kernel version
  * v4.15 with --core-reg-fixup and then later updated with new registers.
+ * (The --core-reg-fixup option and it's fixup function have been removed
+ * from the test, as it's unlikely to use this type of test on a kernel
+ * older than v5.2.)
  *
  * The blessed list is up to date with kernel version v6.4 (or so we hope)
  */
-- 
2.34.1

