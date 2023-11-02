Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F27DF7B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjKBQd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjKBQdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 12:33:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD913D;
        Thu,  2 Nov 2023 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698942798; x=1730478798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y/7/R0T7sdWEW0G4FlYJVCB4cGKVbltohN+8VyJwxuQ=;
  b=n5lZzrvIkY3+/gIF+yIt2C12k7jCcJesKF4pD7rxFb2GcILtqkfmC0JO
   Pi3g1NG8WhQDRzMP5ftWOqD3JxeLhCJqbZRmMtDjyJGixbV3kTsO9BF66
   WM6iVSbMmbocClaq9sTDj6n/+KssUEkWeEYb0IkVsm1OIw2OaBCKjrrGt
   c1DBitNHTRk3LuUTmQqt6/3fJCfNswpmbjlOa7XMHz0pXnerS8YaPc8t0
   uDX3VfknsiSjbVNqeHk8IM/J0h0JjQyaWzQkMKUFo5YS/Ywvsm8tWT15T
   gvqDAeFQRr+zV8/uFgNOOTaT3kOND0SwFMZd/2r8eTLl7vSDcCPlGqMZc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388570922"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388570922"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9448464"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:14 -0700
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
Subject: [RFC PATCH v1 3/8] KVM: selftests: Add virt_arch_ucall_prealloc() arch specific implementation
Date:   Thu,  2 Nov 2023 23:51:06 +0800
Message-Id: <20231102155111.28821-4-guang.zeng@intel.com>
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

Add virt_arch_ucall_prealloc() which allows to preprocess the memory
allocated to ucall_pool as per arch specific requirement.

For X86 platform, it needs to adjust the address to corresponding
address space based on the operation mode, i.e. user or supervisor
mode, at runtime.

There is no change for other platforms(aarch64/riscv/s390x).

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 .../selftests/kvm/include/kvm_util_base.h       | 17 +++++++++++++++++
 .../selftests/kvm/lib/aarch64/processor.c       |  5 +++++
 .../testing/selftests/kvm/lib/riscv/processor.c |  5 +++++
 .../testing/selftests/kvm/lib/s390x/processor.c |  5 +++++
 tools/testing/selftests/kvm/lib/ucall_common.c  |  2 ++
 .../selftests/kvm/lib/x86_64/processor.c        | 12 ++++++++++++
 6 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a18db6a7b3cf..dbaa2cf83c1c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -917,6 +917,23 @@ static inline void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	virt_arch_dump(stream, vm, indent);
 }
 
+/*
+ * Virtual UCALL memory pre-processing
+ *
+ * Input Args:
+ *   ucall_gva - Guest virtual address point to memory of ucall pool
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Processed guest virtual address point to memory of ucall pool
+ */
+void *virt_arch_ucall_prealloc(uint64_t ucall_gva);
+
+static inline void *virt_ucall_prealloc(uint64_t ucall_gva)
+{
+	return virt_arch_ucall_prealloc(ucall_gva);
+}
 
 static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
 {
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 3a0259e25335..3a1827cce615 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -238,6 +238,11 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
+void *virt_arch_ucall_prealloc(uint64_t ucall_gva)
+{
+	return (void *)ucall_gva;
+}
+
 void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 {
 	struct kvm_vcpu_init default_init = { .target = -1, };
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d146ca71e0c0..d3f7eed84195 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -180,6 +180,11 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
+void *virt_arch_ucall_prealloc(uint64_t ucall_gva)
+{
+	return (void *)ucall_gva;
+}
+
 void riscv_vcpu_mmu_setup(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vm *vm = vcpu->vm;
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 15945121daf1..b7c86649807d 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -155,6 +155,11 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	virt_dump_region(stream, vm, indent, vm->pgd);
 }
 
+void *virt_arch_ucall_prealloc(uint64_t ucall_gva)
+{
+	return (void *)ucall_gva;
+}
+
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				  void *guest_code)
 {
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 816a3fa109bf..5afa32d77427 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -51,6 +51,8 @@ static struct ucall *ucall_alloc(void)
 	if (!ucall_pool)
 		goto ucall_failed;
 
+	ucall_pool = (struct ucall_header *)virt_ucall_prealloc((uint64_t)ucall_pool);
+
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (!test_and_set_bit(i, ucall_pool->in_use)) {
 			uc = &ucall_pool->ucalls[i];
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 6f4295a13d00..525b714ee13c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -388,6 +388,18 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
+void *virt_arch_ucall_prealloc(uint64_t ucall_gva)
+{
+	unsigned short desc_cs;
+
+	asm volatile ("mov %%cs,%0" :  "=r" (desc_cs));
+
+	if (desc_cs & 0x3)
+		return (void *)(ucall_gva & ~KERNEL_LNA_OFFSET);
+	else
+		return (void *)(ucall_gva | KERNEL_LNA_OFFSET);
+}
+
 /*
  * Set Unusable Segment
  *
-- 
2.21.3

