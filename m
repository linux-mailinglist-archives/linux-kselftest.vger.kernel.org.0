Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB39710676
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbjEYHgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjEYHfp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 03:35:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665CE68;
        Thu, 25 May 2023 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685000134; x=1716536134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xygKw/lutXpoT+xBrrnIsigg+qVl1ffYhJioaYUxoVg=;
  b=lhj8PnLcwwX1W2hwZqW48N3mNAdw1FI8QlTfb/YzgRVDodHt7E2NkzMR
   4etOMqQeX3rcqSyQi8eNWA3UQeHmS6TyjtYAEKPTHZbiJ/kYSVUizM5W3
   P7viPkrCU7/BmJbAUpnMEui6ia/SEvQ/wwh7MIhnZDqjlKanRW5MQA9/B
   V6FqNreFgWAEHGm4F/6sN1+Ry7lqq9kekJbPuD2Wje+1LtblXLFNnro1v
   N9rG63F56vM7BfM1BkavqEJoZYTFxLJCTPLPxl7YoBznhSXPofafvmhZe
   oFGAMBZ/14jEPyPmOSBwHyBn4MesxCQAQCiu09w9lda0kcaAkXmsmg5qL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="356164523"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="356164523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769776060"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="769776060"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:34:35 -0700
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
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v2 09/11] KVM: riscv: selftests: Make check_supported arch specific
Date:   Thu, 25 May 2023 15:38:33 +0800
Message-Id: <26dea518fc5e8da51e61db279d175364bfecd009.1684999824.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684999824.git.haibo1.xu@intel.com>
References: <cover.1684999824.git.haibo1.xu@intel.com>
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

check_supported() was used to verify whether a feature/extension was
supported in a guest in the get-reg-list test. Currently this info
can be retrieved through the KVM_CAP_ARM_* API in aarch64, but in
riscv, this info was only exposed through the KVM_GET_ONE_REG on
KVM_REG_RISCV_ISA_EXT pseudo registers.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/get-reg-list.c | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index f6ad7991a812..f1fc113e9719 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -99,6 +99,20 @@ void __weak print_reg(const char *prefix, __u64 id)
 }
 
 #ifdef __aarch64__
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
 static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
 {
 	struct vcpu_reg_sublist *s;
@@ -126,6 +140,8 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm
 	struct kvm_vcpu_init init = { .target = -1, };
 	struct kvm_vcpu *vcpu;
 
+	check_supported(c);
+
 	prepare_vcpu_init(c, &init);
 	vcpu = __vm_vcpu_add(vm, 0);
 	aarch64_vcpu_setup(vcpu, &init);
@@ -140,20 +156,6 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm
 }
 #endif
 
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
 static bool print_list;
 static bool print_filtered;
 
@@ -165,8 +167,6 @@ static void run_test(struct vcpu_reg_list *c)
 	struct kvm_vm *vm;
 	struct vcpu_reg_sublist *s;
 
-	check_supported(c);
-
 	vm = vm_create_barebones();
 	vcpu = vcpu_config_get_vcpu(c, vm);
 
-- 
2.34.1

