Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A8A744961
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGANkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Jul 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGANkM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Jul 2023 09:40:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFE44B0;
        Sat,  1 Jul 2023 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688218782; x=1719754782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tib4u7zV9bvH0+hgUwQFMOHqdNc+6PnMdDY7xbrMXoM=;
  b=FWBmVC60w/si5dyPOXZ2/9A4mMSKz9L8aV8NgFZ9Wgj0ZP0IeesLQWWS
   ZPq9uCInRJT1+xmGFSusD4NnsSdZ+jUPHigfiKdlT3RqeDdL4ZJYLYD0U
   ZVbR6Rc8PvlN8YC7/KXmj7FjdmaDoXcRGhFzL0Yeur9zH5c2aH2KrTZHc
   HppscNOunMGlxQLJE1KMrbTcWoxh2Za1uiTtMg5hlh/f7WvGikv5x4ccp
   45PI2H2iQvJl/swpATmSQa8U6/HPzqsoyfQu26don5lQta/WNpxnB5mfP
   m64mCj+BQPFDsHLeUojOBZxJcqrleD96InVAfjK6TPLvfxmYgogFXR0Df
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="342926300"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="342926300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 06:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="747694279"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="747694279"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 06:39:34 -0700
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
Subject: [PATCH v5 11/13] KVM: selftests: Add skip_set facility to get_reg_list test
Date:   Sat,  1 Jul 2023 21:42:59 +0800
Message-Id: <0a418f26388e744b6ae2f17639bea08a05643549.1688010022.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688010022.git.haibo1.xu@intel.com>
References: <cover.1688010022.git.haibo1.xu@intel.com>
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

Add new skips_set members to vcpu_reg_sublist so as to skip
set operation on some registers.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/get-reg-list.c    | 20 +++++++++++++------
 .../selftests/kvm/include/kvm_util_base.h     |  2 ++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index 74fb6f6fdd09..1a32a900aeea 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -157,6 +157,7 @@ static void run_test(struct vcpu_reg_list *c)
 {
 	int new_regs = 0, missing_regs = 0, i, n;
 	int failed_get = 0, failed_set = 0, failed_reject = 0;
+	int skipped_set = 0;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct vcpu_reg_sublist *s;
@@ -210,7 +211,7 @@ static void run_test(struct vcpu_reg_list *c)
 			.id = reg_list->reg[i],
 			.addr = (__u64)&addr,
 		};
-		bool reject_reg = false;
+		bool reject_reg = false, skip_reg = false;
 		int ret;
 
 		ret = __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
@@ -221,8 +222,8 @@ static void run_test(struct vcpu_reg_list *c)
 			++failed_get;
 		}
 
-		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
 		for_each_sublist(c, s) {
+			/* rejects_set registers are rejected for set operation */
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
 				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
@@ -234,9 +235,16 @@ static void run_test(struct vcpu_reg_list *c)
 				}
 				break;
 			}
+
+			/* skips_set registers are skipped for set operation */
+			if (s->skips_set && find_reg(s->skips_set, s->skips_set_n, reg.id)) {
+				skip_reg = true;
+				++skipped_set;
+				break;
+			}
 		}
 
-		if (!reject_reg) {
+		if (!reject_reg && !skip_reg) {
 			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 			if (ret) {
 				printf("%s: Failed to set ", config_name(c));
@@ -281,9 +289,9 @@ static void run_test(struct vcpu_reg_list *c)
 	}
 
 	TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !failed_reject,
-		    "%s: There are %d missing registers; "
-		    "%d registers failed get; %d registers failed set; %d registers failed reject",
-		    config_name(c), missing_regs, failed_get, failed_set, failed_reject);
+		    "%s: There are %d missing registers; %d registers failed get; "
+		    "%d registers failed set; %d registers failed reject; %d registers skipped set",
+		    config_name(c), missing_regs, failed_get, failed_set, failed_reject, skipped_set);
 
 	pr_info("%s: PASS\n", config_name(c));
 	blessed_n = 0;
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e4480049000d..67c031fe89a1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -134,6 +134,8 @@ struct vcpu_reg_sublist {
 	__u64 regs_n;
 	__u64 *rejects_set;
 	__u64 rejects_set_n;
+	__u64 *skips_set;
+	__u64 skips_set_n;
 };
 
 struct vcpu_reg_list {
-- 
2.34.1

