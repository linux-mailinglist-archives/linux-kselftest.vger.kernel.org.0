Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A51D73B581
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFWKhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFWKhO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 06:37:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B026AB;
        Fri, 23 Jun 2023 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687516603; x=1719052603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huYFizjiNe3K2RBGa8CWXKEW3c1iGOtXpXSOijiV/eg=;
  b=eQa1ruM8+HFeTOIUT1bvV0CiHTFa5wWfGW3A/XrFtmzunr5wgTb9Xy7r
   1J5Jk7aEcrKtO6Q9R164qMY6uc6YpBr5ICRpYPlaE5oP2QGZ+WQucqciQ
   4hfalnyOyPTDeOH7UE7CLgCDwKHpOgRuFeHovjvtnGONI6r5Uolxmg19C
   gUiaDJ2S/rlYZCCH9L9COkg+4kQFtrU+IBPm/zZY/SkIFAThbxpk2CxVD
   nfBeJJlkX8cyp1t3C4euaLLosykoOztPCflWpnmxo8cqPq4XqHKzvBq0u
   kPzPZaZZ2tFYFcYujZt7X0J98e1VkGFyCHPj3JlHf3fDBGGdeDrWTBAhY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447112678"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="447112678"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:36:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715276168"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715276168"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:36:35 -0700
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
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v4 09/12] KVM: selftests: Only do get/set tests on present blessed list
Date:   Fri, 23 Jun 2023 18:40:11 +0800
Message-Id: <47f0502d076c071260a87953cbabadfc85d278cf.1687515463.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687515463.git.haibo1.xu@intel.com>
References: <cover.1687515463.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Only do the get/set tests on present and blessed registers
since we don't know the capabilities of any new ones.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/get-reg-list.c | 29 ++++++++++++++--------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index b956ee410996..3beb6b62de0a 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -52,6 +52,10 @@ extern int vcpu_configs_n;
 	for_each_reg_filtered(i)						\
 		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
 
+#define for_each_present_blessed_reg(i)			\
+	for ((i) = 0; (i) < blessed_n; ++(i))		\
+		if (find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))
+
 static const char *config_name(struct vcpu_reg_list *c)
 {
 	struct vcpu_reg_sublist *s;
@@ -189,6 +193,16 @@ static void run_test(struct vcpu_reg_list *c)
 		return;
 	}
 
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
 	/*
 	 * We only test that we can get the register and then write back the
 	 * same value. Some registers may allow other values to be written
@@ -198,8 +212,11 @@ static void run_test(struct vcpu_reg_list *c)
 	 * be written need to have the other values tested, then we should
 	 * create a new set of tests for those in a new independent test
 	 * executable.
+	 *
+	 * Only do the get/set tests on present, blessed list registers,
+	 * since we don't know the capabilities of any new registers.
 	 */
-	for_each_reg(i) {
+	for_each_present_blessed_reg(i) {
 		uint8_t addr[2048 / 8];
 		struct kvm_one_reg reg = {
 			.id = reg_list->reg[i],
@@ -242,16 +259,6 @@ static void run_test(struct vcpu_reg_list *c)
 		}
 	}
 
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
 	for_each_new_reg(i)
 		++new_regs;
 
-- 
2.34.1

