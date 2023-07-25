Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9680E760D17
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGYIg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjGYIgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:36:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DB10F4;
        Tue, 25 Jul 2023 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274174; x=1721810174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yr2c82vvYounMyQZs9HpLVAhecSGGU31n1wJ5nIhmUA=;
  b=BCgDEHGjQvVoeMuUxJWP/4Zit1higoSCsGEoFfnbX9KASs3ePSca0UKw
   hx2fELqZwvZt3rI2uuHNM3MSuQvcirvKNKpCJoPyU07SQbW7BpYrt5SSZ
   G0wy6gHjFzQtCMIRKaooGVZJHfZhIc2ZA0t85x2TQsDX6nmY0gHxuRx56
   zUagUXTQjktqfdroAAQR2fcITIdAWxezumGHVkTkUEWpi0oIAOaiVWbUr
   79cDK3N5hSiHAbBCejd2z21cxozkn7OyiNC34Dtyen/r++U4npDDF2Ked
   6vu8+cz/glL6E0pJ50HCKiRCAOUfYnMjPjDLiuJTD5Wt6xkVZD+k5hmQF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371264236"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371264236"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761130067"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761130067"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:36:03 -0700
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
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 01/13] KVM: arm64: selftests: Replace str_with_index with strdup_printf
Date:   Tue, 25 Jul 2023 16:41:27 +0800
Message-Id: <a21ada0dabbe6dbf962b7f0ab7d28c1368389981.1690273969.git.haibo1.xu@intel.com>
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

The original author of aarch64/get-reg-list.c (me) was wearing
tunnel vision goggles when implementing str_with_index(). There's
no reason to have such a special case string function. Instead,
take inspiration from glib and implement strdup_printf. The
implementation builds on vasprintf() which requires _GNU_SOURCE,
but we require _GNU_SOURCE in most files already.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 23 ++++---------------
 .../testing/selftests/kvm/include/test_util.h |  2 ++
 tools/testing/selftests/kvm/lib/test_util.c   | 15 ++++++++++++
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 4f10055af2aa..52244de20dce 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -180,19 +180,6 @@ static bool check_supported_feat_reg(struct kvm_vcpu *vcpu, __u64 reg)
 	return true;
 }
 
-static const char *str_with_index(const char *template, __u64 index)
-{
-	char *str, *p;
-	int n;
-
-	str = strdup(template);
-	p = strstr(str, "##");
-	n = sprintf(p, "%lld", index);
-	strcat(p + n, strstr(template, "##") + 2);
-
-	return (const char *)str;
-}
-
 #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_COPROC_MASK)
 
 #define CORE_REGS_XX_NR_WORDS	2
@@ -211,7 +198,7 @@ static const char *core_id_to_str(struct vcpu_config *c, __u64 id)
 	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
 		idx = (core_off - KVM_REG_ARM_CORE_REG(regs.regs[0])) / CORE_REGS_XX_NR_WORDS;
 		TEST_ASSERT(idx < 31, "%s: Unexpected regs.regs index: %lld", config_name(c), idx);
-		return str_with_index("KVM_REG_ARM_CORE_REG(regs.regs[##])", idx);
+		return strdup_printf("KVM_REG_ARM_CORE_REG(regs.regs[%lld])", idx);
 	case KVM_REG_ARM_CORE_REG(regs.sp):
 		return "KVM_REG_ARM_CORE_REG(regs.sp)";
 	case KVM_REG_ARM_CORE_REG(regs.pc):
@@ -226,12 +213,12 @@ static const char *core_id_to_str(struct vcpu_config *c, __u64 id)
 	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
 		idx = (core_off - KVM_REG_ARM_CORE_REG(spsr[0])) / CORE_SPSR_XX_NR_WORDS;
 		TEST_ASSERT(idx < KVM_NR_SPSR, "%s: Unexpected spsr index: %lld", config_name(c), idx);
-		return str_with_index("KVM_REG_ARM_CORE_REG(spsr[##])", idx);
+		return strdup_printf("KVM_REG_ARM_CORE_REG(spsr[%lld])", idx);
 	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
 	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
 		idx = (core_off - KVM_REG_ARM_CORE_REG(fp_regs.vregs[0])) / CORE_FPREGS_XX_NR_WORDS;
 		TEST_ASSERT(idx < 32, "%s: Unexpected fp_regs.vregs index: %lld", config_name(c), idx);
-		return str_with_index("KVM_REG_ARM_CORE_REG(fp_regs.vregs[##])", idx);
+		return strdup_printf("KVM_REG_ARM_CORE_REG(fp_regs.vregs[%lld])", idx);
 	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
 		return "KVM_REG_ARM_CORE_REG(fp_regs.fpsr)";
 	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
@@ -260,13 +247,13 @@ static const char *sve_id_to_str(struct vcpu_config *c, __u64 id)
 		n = (id >> 5) & (KVM_ARM64_SVE_NUM_ZREGS - 1);
 		TEST_ASSERT(id == KVM_REG_ARM64_SVE_ZREG(n, 0),
 			    "%s: Unexpected bits set in SVE ZREG id: 0x%llx", config_name(c), id);
-		return str_with_index("KVM_REG_ARM64_SVE_ZREG(##, 0)", n);
+		return strdup_printf("KVM_REG_ARM64_SVE_ZREG(%lld, 0)", n);
 	case KVM_REG_ARM64_SVE_PREG_BASE ...
 	     KVM_REG_ARM64_SVE_PREG_BASE + (1ULL << 5) * KVM_ARM64_SVE_NUM_PREGS - 1:
 		n = (id >> 5) & (KVM_ARM64_SVE_NUM_PREGS - 1);
 		TEST_ASSERT(id == KVM_REG_ARM64_SVE_PREG(n, 0),
 			    "%s: Unexpected bits set in SVE PREG id: 0x%llx", config_name(c), id);
-		return str_with_index("KVM_REG_ARM64_SVE_PREG(##, 0)", n);
+		return strdup_printf("KVM_REG_ARM64_SVE_PREG(%lld, 0)", n);
 	case KVM_REG_ARM64_SVE_FFR_BASE:
 		TEST_ASSERT(id == KVM_REG_ARM64_SVE_FFR(0),
 			    "%s: Unexpected bits set in SVE FFR id: 0x%llx", config_name(c), id);
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6e9f215ce70..7e0182f837b5 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -186,4 +186,6 @@ static inline uint32_t atoi_non_negative(const char *name, const char *num_str)
 	return num;
 }
 
+char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2), nonnull(1)));
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index b772193f6c18..3e36019eeb4a 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2020, Google LLC.
  */
 
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdarg.h>
 #include <assert.h>
 #include <ctype.h>
 #include <limits.h>
@@ -377,3 +380,15 @@ int atoi_paranoid(const char *num_str)
 
 	return num;
 }
+
+char *strdup_printf(const char *fmt, ...)
+{
+	va_list ap;
+	char *str;
+
+	va_start(ap, fmt);
+	vasprintf(&str, fmt, ap);
+	va_end(ap);
+
+	return str;
+}
-- 
2.34.1

