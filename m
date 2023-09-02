Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984CA7907F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349438AbjIBMye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352224AbjIBMyd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 08:54:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5C1736;
        Sat,  2 Sep 2023 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693659260; x=1725195260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YJhysFvLd1mPdbyv9dkpgRLSMU/lWlm/UKAdUMSaGc=;
  b=A0KTalc6Rjs0y4pBO5V55S070f+Ie/iqaZLOXJZzEWVLLCxLDHBiTryG
   fQ4/Bw5I0LEBP0mYN0VqxDx+858Ki3WG1w3DDqN/SnUU/HC4IsHSJIFAh
   950wYpZEVb+iDYO+jaLdRpaQD+MjycjW1U5VNNAQkLa2JqkMhAsKQmO+F
   ED3fiAe22GryxkumsG+NAGe5PhRI0hQL3efZVwsrWAk9CRDXcjgBFhrqj
   ITY1lX0cp5GcGcy4HrvebKl+d0AWeFdaDhz3gYmWiKqwKNL+x1l1bKzAU
   yZxS2sIfZNar3nRlfoxkiFT/BggJs92XRyc1yIM0w6Xgv4gE4FtNgVPNR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366599408"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366599408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855022263"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="855022263"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:54:10 -0700
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
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Like Xu <likexu@tencent.com>, Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, Paul Durrant <paul@xen.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v2 7/8] KVM: riscv: selftest: Change vcpu_has_ext to a common function
Date:   Sat,  2 Sep 2023 20:59:29 +0800
Message-Id: <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693659382.git.haibo1.xu@intel.com>
References: <cover.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move vcpu_has_ext to the processor.c so that other test cases
can use it for vCPU extension check.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../selftests/kvm/include/riscv/processor.h        |  2 ++
 tools/testing/selftests/kvm/lib/riscv/processor.c  |  9 +++++++++
 tools/testing/selftests/kvm/riscv/get-reg-list.c   | 14 --------------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index d1e5d9f7ad45..6087c8fc263a 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
 					     idx, KVM_REG_SIZE_ULONG)
 
+bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 39a1e9902dec..5ececa566f24 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -15,6 +15,15 @@
 
 static vm_vaddr_t exception_handlers;
 
+bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+{
+	unsigned long value = 0;
+
+	vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+
+	return !!value;
+}
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index d8ecacd03ecf..c4028bf32e3f 100644
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
-- 
2.34.1

