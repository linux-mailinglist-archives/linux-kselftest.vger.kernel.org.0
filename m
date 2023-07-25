Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25D760D3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjGYIit (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGYIi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:38:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A810172A;
        Tue, 25 Jul 2023 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274298; x=1721810298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tweL8MC1Z4PsW8REKGjDOZBcdwCj7tnWBl0dpmE8j5k=;
  b=LoZUiGhmGhwIUvvQWWoKutFIou/2vGmQiDbmaFuWbAtwIV3CE5syrpl7
   GdquQWM5zmGm/xPdM/0pWpY6S2c1qOC18GthuqXWgX3ZRO3xqAgXb2mtD
   AOR1ODiBbejD3DK/oRAppLWfTzUH2zxvPPCabnbZd1WS1sZ7AvPiZvg6v
   wHqj8zzgoibMt1zpjfNkuzUnPxJiacRmHNbKojsVR8ObX0m6ycbFzIb8G
   l9+dpVPX5MnqpbvP9hHenm0d5Gb5d19nhLmGKn6gXRbHr8pzcPePD276O
   cKkGFE7PHP/SrLKL6kI7+t0XZs37MNPIGl3Oa0fSNFaCYSA1oN6CDgyMR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371264870"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371264870"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761130932"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761130932"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:38:09 -0700
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
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 09/13] KVM: arm64: selftests: Move finalize_vcpu back to run_test
Date:   Tue, 25 Jul 2023 16:41:35 +0800
Message-Id: <753d160e49e193f2800fdf45ad6d9af8c6828067.1690273969.git.haibo1.xu@intel.com>
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

No functional changes. Just move the finalize_vcpu call back to
run_test and do weak function trick to prepare for the opration
in riscv.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 13 +++++++++++
 tools/testing/selftests/kvm/get-reg-list.c    | 22 +++++--------------
 .../selftests/kvm/include/kvm_util_base.h     |  3 +++
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index f8ebc058b191..709d7d721760 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -84,6 +84,19 @@ bool check_reject_set(int err)
 	return err == EPERM;
 }
 
+void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
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
 #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_COPROC_MASK)
 
 #define CORE_REGS_XX_NR_WORDS	2
diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index 1df94e8e9ed5..43a919f2208f 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -34,9 +34,6 @@ static __u64 *blessed_reg, blessed_n;
 extern struct vcpu_reg_list *vcpu_configs[];
 extern int vcpu_configs_n;
 
-#define for_each_sublist(c, s)							\
-	for ((s) = &(c)->sublists[0]; (s)->regs; ++(s))
-
 #define for_each_reg(i)								\
 	for ((i) = 0; (i) < reg_list->n; ++(i))
 
@@ -109,6 +106,10 @@ bool __weak check_reject_set(int err)
 	return true;
 }
 
+void __weak finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
+{
+}
+
 #ifdef __aarch64__
 static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
 {
@@ -119,19 +120,6 @@ static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *ini
 			init->features[s->feature / 32] |= 1 << (s->feature % 32);
 }
 
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
 static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm_vm *vm)
 {
 	struct kvm_vcpu_init init = { .target = -1, };
@@ -140,7 +128,6 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm
 	prepare_vcpu_init(c, &init);
 	vcpu = __vm_vcpu_add(vm, 0);
 	aarch64_vcpu_setup(vcpu, &init);
-	finalize_vcpu(vcpu, c);
 
 	return vcpu;
 }
@@ -180,6 +167,7 @@ static void run_test(struct vcpu_reg_list *c)
 
 	vm = vm_create_barebones();
 	vcpu = vcpu_config_get_vcpu(c, vm);
+	finalize_vcpu(vcpu, c);
 
 	reg_list = vcpu_get_reg_list(vcpu);
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 1a455511503e..ec65c292b5fd 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -141,6 +141,9 @@ struct vcpu_reg_list {
 	struct vcpu_reg_sublist sublists[];
 };
 
+#define for_each_sublist(c, s)		\
+	for ((s) = &(c)->sublists[0]; (s)->regs; ++(s))
+
 #define kvm_for_each_vcpu(vm, i, vcpu)			\
 	for ((i) = 0; (i) <= (vm)->last_vcpu_id; (i)++)	\
 		if (!((vcpu) = vm->vcpus[i]))		\
-- 
2.34.1

