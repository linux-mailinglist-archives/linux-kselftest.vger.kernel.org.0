Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3479F65E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 03:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjINBaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 21:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjINB37 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 21:29:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1331BD5;
        Wed, 13 Sep 2023 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694654995; x=1726190995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kszkck1bItOmesIM2X4z8f1oz4GhWjlcbd0j7Gr185w=;
  b=J4jGbeHrrkCh6XtJrj1EnXl4iYsSNOU7uYepInvyBkHthN4g1HYg2VJX
   9z7ccx0zhChzXqGrqPPkUUqkr22xeQRCm1qccCrpiBus5kYV3AWzZL3fA
   YAobGC+xzhxMffDBeFpRNOc5diVp8VXNDCapd84D5/DlpnBi9zJvAFAJp
   Kur8VA7s5JuzK6GhENYQKyVtdur38tUDSQUAWbE9kNW0Qb0ATAwKfG7eJ
   Tlqoqp8DM3AnZWZ8g5AxlYixiWnYlKK/IjkPo8949ZDSrl1nfdibEm9qE
   OjYt4cISBOwZHC6NBOIJ0ni1vIegRz6yrtY19e/e4vtm/09eog+rHM5X/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377734275"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377734275"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694049579"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="694049579"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:29:47 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v3 8/9] KVM: riscv: selftests: Change vcpu_has_ext to a common function
Date:   Thu, 14 Sep 2023 09:37:02 +0800
Message-Id: <dd81ef2b87e4cc160cb0ee782010dcf3543e065a.1694421911.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694421911.git.haibo1.xu@intel.com>
References: <cover.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
so that other test cases can use it for vCPU extension check.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../selftests/kvm/include/riscv/processor.h      |  2 ++
 .../testing/selftests/kvm/lib/riscv/processor.c  |  9 +++++++++
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 +---------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 2c975d9cead2..7d5517648ea7 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
 					     idx, KVM_REG_SIZE_ULONG)
 
+bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 39a1e9902dec..e527ad0abc30 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -15,6 +15,15 @@
 
 static vm_vaddr_t exception_handlers;
 
+bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+{
+	unsigned long value = 0;
+
+	__vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+
+	return !!value;
+}
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index d8ecacd03ecf..0dcff823f287 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -44,20 +44,6 @@ bool check_reject_set(int err)
 	return err == EINVAL;
 }
 
-static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
-{
-	int ret;
-	unsigned long value;
-
-	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
-	if (ret) {
-		printf("Failed to get ext %d", ext);
-		return false;
-	}
-
-	return !!value;
-}
-
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
 	struct vcpu_reg_sublist *s;
@@ -77,7 +63,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
 
 		/* Double check whether the desired extension was enabled */
-		__TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
+		__TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
 			       "%s not available, skipping tests\n", s->name);
 	}
 }
-- 
2.34.1

