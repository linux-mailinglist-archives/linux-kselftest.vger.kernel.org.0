Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7591764893
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjG0H0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjG0HZn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:25:43 -0400
Received: from mgamail.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFEE6A60;
        Thu, 27 Jul 2023 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690442150; x=1721978150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NsStjbCQjlnQYvLgrTgV2SD7Xv4q7PhNaVzmvY/YSHs=;
  b=mwLv3MwfBjzw3I8OeXbZLsQjXz9Y3umgYyX9lKzuSHHZ2tAarhYFurFS
   pzs5/bmSrUJC4lCVMC/DFgrI70kbqe3MP/fe1kHOIiP6Y6VtlhepaVa6+
   OiI/sfGXFsgZ1GMd52BY0bkzuPUhxP2m5wRdkZi4CEBX+qTZZ10Zo9IwS
   ZWJWb8rfhxrNzcvHZzIy8AM8hwSjpGXDRr9OpPSDzpsuV9zFqkCdQm/9J
   8DySrWeDijpftmvkB4fMMjP89SFrOeSuRAzScPbTDv02WqmHgg5SKUd2T
   c3P+wPZawesPPY2q8gAmJAyUNj5qII60SR9I5oOf0/3Mpvqw7VxvZF1Uv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367102383"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367102383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720785833"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720785833"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:42 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vipin Sharma <vipinsh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 3/4] KVM: riscv: selftests: Add guest helper to get vcpu id
Date:   Thu, 27 Jul 2023 15:20:07 +0800
Message-Id: <36b5837e9e94465dd2b7d7a17bb84dea082f2ffa.1690364259.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690364259.git.haibo1.xu@intel.com>
References: <cover.1690364259.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add guest_get_vcpuid() helper to simplify accessing to per-cpu
private data. The sscratch CSR was used to store the vcpu id.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 9ea6e7bedc61..ca53570ce6de 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -165,4 +165,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+uint32_t guest_get_vcpuid(void);
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index f1b0be58a5dc..b8ad3e69a697 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -316,6 +316,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_size);
 	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
 
+	/* Setup scratch regiter of guest */
+	vcpu_set_reg(vcpu, RISCV_CSR_REG(sscratch), vcpu_id);
+
 	/* Setup default exception vector of guest */
 	vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
 
@@ -424,3 +427,8 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, void (*handler)(struct ex_r
 
 	handlers->exception_handlers[1][0] = handler;
 }
+
+uint32_t guest_get_vcpuid(void)
+{
+	return csr_read(CSR_SSCRATCH);
+}
-- 
2.34.1

