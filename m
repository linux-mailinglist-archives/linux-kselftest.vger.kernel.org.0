Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0F7DF7C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 17:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376975AbjKBQeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347663AbjKBQeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 12:34:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE08185;
        Thu,  2 Nov 2023 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698942840; x=1730478840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Nbhi+Lxa9AGjvct6KXRPu7ZYORV4sX+cH5+O4Ji6OnI=;
  b=gbewLks/8QT5Uf9CVVVDqRPSe7I34IZH4YpKdYn8dyn/oguXuNdq2JF+
   MvG5DIZxNffE44fgACwdg+2RFLLpdzpJRbmq9bqJiT6MsKAg/6c/J8agv
   Y4JIKi1gE5N9LJJcRAbpGwwrQimn2SYbyomRCx5sn1bzJvwJ7dD8leuyQ
   +CXIGIEVnK/iK8bogWzlwSzDrwmeFi7iXzRFfsQJ9FraO0NbqtV2abJ84
   nQnTGfCayONpdq+NWleCidIS6/EGbAEShGLun6e0a94/sjp1HULoxWLK+
   xmTWs6aA6OcPsJvgQQac5OYp8OPQq9HS1M44dJuDamafg8oXxou9U1Vu4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388571121"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388571121"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9448555"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:42 -0700
From:   Zeng Guang <guang.zeng@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, Zeng Guang <guang.zeng@intel.com>
Subject: [RFC PATCH v1 8/8] KVM: selftests: x86: Add KVM forced emulation prefix capability
Date:   Thu,  2 Nov 2023 23:51:11 +0800
Message-Id: <20231102155111.28821-9-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102155111.28821-1-guang.zeng@intel.com>
References: <20231102155111.28821-1-guang.zeng@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce KVM selftest exception fixup using forced emulation prefix to
emulate instruction unconditionally when kvm.force_emulation_prefix is
enabled.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 2534bdf8aa71..a1645508affc 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1110,6 +1110,10 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 			void (*handler)(struct ex_regs *));
 
+/* Forced emulation prefix for KVM emulating instruction unconditionally */
+#define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
+#define KVM_FEP_LENGTH 5
+
 /* If a toddler were to say "abracadabra". */
 #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
 
@@ -1149,6 +1153,22 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	"mov  %%r9b, %[vector]\n\t"				\
 	"mov  %%r10, %[error_code]\n\t"
 
+/*
+ * KVM selftest exception fixup using forced emulation prefix enforces KVM
+ * on emulating instruction unconditionally when kvm.force_emulation_prefix
+ * is enabled.
+ */
+#define KVM_FEP_ASM_SAFE(insn)					\
+	"mov $" __stringify(KVM_EXCEPTION_MAGIC) ", %%r9\n\t"	\
+	"lea 1f(%%rip), %%r10\n\t"				\
+	"lea 2f(%%rip), %%r11\n\t"				\
+	KVM_FEP							\
+	"1: " insn "\n\t"					\
+	"xor %%r9, %%r9\n\t"					\
+	"2:\n\t"						\
+	"mov  %%r9b, %[vector]\n\t"				\
+	"mov  %%r10, %[error_code]\n\t"
+
 #define KVM_ASM_SAFE_OUTPUTS(v, ec)	[vector] "=qm"(v), [error_code] "=rm"(ec)
 #define KVM_ASM_SAFE_CLOBBERS	"r9", "r10", "r11"
 
-- 
2.21.3

