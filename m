Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9692F73B57D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFWKhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWKg5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 06:36:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA342968;
        Fri, 23 Jun 2023 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687516589; x=1719052589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9hxFxP3+aBRBc+Ceyr9PCiVTSv/k2Q6TXUwS8frSIo=;
  b=FNDW5Uv7uS0EQ5tXmYgO3+KVGdkpqj9xD9tEu9jPiIQ4gq01pX9GoQZG
   5lKfooi9MNp1JoHwcSQueutFhanLu6Yut6QZwsiezfTD5A+8wYcWjTYGj
   A1Aq0vXyUV3T3jwGXA4kSrTu2Y1U7A3p4082bUnjupFMZWYo/m1qhfqEK
   iZw7xoVzjyPsd3ZXRbcXMVyVqEEIv9/4/b86iJiQnBR4UZefWmlgquJDL
   MRaGAIdoKPc1yvWRc6EoDsUgAWSnNtzJb3dj+Qi7sDBtIi9V9/vI1UK2p
   IaDy0k8+48QJlNX4b6ygFz3tN4iya2Dt7XV96V/5CB8AgwiT0LN+GQ5ln
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447112630"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="447112630"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715276142"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715276142"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:36:20 -0700
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
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v4 08/12] KVM: arm64: selftests: Move reject_set check logic to a function
Date:   Fri, 23 Jun 2023 18:40:10 +0800
Message-Id: <341feff384c9f8a20ed4aac6e2dda0440d6b84f2.1687515463.git.haibo1.xu@intel.com>
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

No functional changes. Just move the reject_set check logic to a
function so we can check for specific errno for specific register.
This is a preparation for support reject_set in riscv.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 8 ++++++++
 tools/testing/selftests/kvm/get-reg-list.c         | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index aaf035c969ec..4e2e1fe833eb 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -27,6 +27,14 @@ bool filter_reg(__u64 reg)
 	return false;
 }
 
+bool reject_set_fail(__u64 reg)
+{
+	if (reg == KVM_REG_ARM64_SVE_VLS)
+		return (errno != EPERM);
+
+	return false;
+}
+
 #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_COPROC_MASK)
 
 #define CORE_REGS_XX_NR_WORDS	2
diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index f6ad7991a812..b956ee410996 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -98,6 +98,11 @@ void __weak print_reg(const char *prefix, __u64 id)
 	printf("\t0x%llx,\n", id);
 }
 
+bool __weak reject_set_fail(__u64 reg)
+{
+	return false;
+}
+
 #ifdef __aarch64__
 static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
 {
@@ -216,7 +221,7 @@ static void run_test(struct vcpu_reg_list *c)
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
 				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
-				if (ret != -1 || errno != EPERM) {
+				if (ret != -1 || reject_set_fail(reg.id)) {
 					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
 					print_reg(config_name(c), reg.id);
 					putchar('\n');
-- 
2.34.1

