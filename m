Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15B673B590
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 12:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFWKiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjFWKiO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 06:38:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967102697;
        Fri, 23 Jun 2023 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687516666; x=1719052666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7KoCv9Vo1qMt0K6xHBzZVraLcs3QK09dtvX+ljFZWQ=;
  b=T22SLwangIctOqT/DblciKNn1p4GpM8xLR1tRo0FJw+18TtP6VqbzmYk
   X6biFHESccRjcEliHEVE8rgYMRXVz3d4/iO+BTYtw22UpuV7BHCZMyj3Y
   6tEfWd0/5+e6/wVWk1mlggEmE3SGG/0VG6waMCg94+AzDy7oYwnXQPJVu
   rWiN9MgvHTtf+G9I84u+mr21PimHpOMCgnmddGwYQhz8jPnmeg+tAosu+
   TzxlXBZZCOorxZ6VvNDuPQwWpyaE7zRyi8K0aXEOV24mWwsYPcX4P/G/k
   li212YvlUvWjld7LXrTP4mYuwIrOouy7VSH7U0cS4OKRcYm99OPMXyAtW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447112990"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="447112990"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715276262"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715276262"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:37:06 -0700
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
Subject: [PATCH v4 11/12] KVM: riscv: selftests: Add finalize_vcpu check in run_test
Date:   Fri, 23 Jun 2023 18:40:13 +0800
Message-Id: <fa6b80b578553e561ccacaeb24091e0716975593.1687515463.git.haibo1.xu@intel.com>
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

Disable all vcpu extensions which were enabled by default
if they were available in the risc-v host, and only enable
the desired one for a vcpu_config.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/get-reg-list.c | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index 3beb6b62de0a..612dabc61137 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -138,11 +138,50 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm
 	prepare_vcpu_init(c, &init);
 	vcpu = __vm_vcpu_add(vm, 0);
 	aarch64_vcpu_setup(vcpu, &init);
-	finalize_vcpu(vcpu, c);
 
 	return vcpu;
 }
 #else
+static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+{
+	int ret;
+	unsigned long value;
+
+	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+	if (ret) {
+		printf("Failed to get ext %d", ext);
+		return false;
+	}
+
+	return !!value;
+}
+
+static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
+{
+	struct vcpu_reg_sublist *s;
+
+	/*
+	 * Disable all extensions which were enabled by default
+	 * if they were available in the risc-v host.
+	 */
+	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
+		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
+	}
+
+	for_each_sublist(c, s) {
+		if (!s->feature)
+			continue;
+
+		/* Try to enable the desired extension */
+		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
+
+		/* Double check whether the desired extension was enabled */
+		__TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
+			       "%s: %s not available, skipping tests\n",
+			       config_name(c), s->name);
+	}
+}
+
 static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm_vm *vm)
 {
 	return __vm_vcpu_add(vm, 0);
@@ -178,6 +217,7 @@ static void run_test(struct vcpu_reg_list *c)
 
 	vm = vm_create_barebones();
 	vcpu = vcpu_config_get_vcpu(c, vm);
+	finalize_vcpu(vcpu, c);
 
 	reg_list = vcpu_get_reg_list(vcpu);
 
-- 
2.34.1

