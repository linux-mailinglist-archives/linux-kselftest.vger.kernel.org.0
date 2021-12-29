Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E247C481360
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhL2NP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:28049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240223AbhL2NPB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783701; x=1672319701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/B3CMwcC2+SqTheNwneT6lzifg0GhLl6+B0jdQ01C3E=;
  b=EDfQYmjwhaXsqlxJZ4h4dL8B2Wj4YDWQJ+YS5xHNDrPcOXb/jrEWrC84
   F2VaiKWpUid588cweOaQHTvVDwyMNehJv/SfXqxPx9T4XlFfKQ4Dd1y8x
   C4fBMwGOy+qZ/FuLrGDTCoLauG1SMwgIT164ytCsypLOBJt/yne48YBgW
   5VIQgH5m7/8/xXx1F54zQk330Xirgj4XZFbmdTM70a7LBQopt/qVjsr/U
   8znK8/p3x/89VwY3IuzsWr/4W8Cpv7CB0udW9pZ0SrqLm8CcVyGhXGu02
   OAKUwMbh+vzUmMo6f/SrIQa2uJ1lZjN9rw4aYQAGzP8NiZxj1x7j5cYhx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876165"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876165"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281218"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:43 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 19/21] kvm: selftests: Add support for KVM_CAP_XSAVE2
Date:   Wed, 29 Dec 2021 05:13:26 -0800
Message-Id: <20211229131328.12283-20-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Wei Wang <wei.w.wang@intel.com>

When KVM_CAP_XSAVE2 is supported, userspace is expected to allocate
buffer for KVM_GET_XSAVE2 and KVM_SET_XSAVE using the size returned
by KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2).

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Guang Zeng <guang.zeng@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h         | 16 ++++-
 tools/include/uapi/linux/kvm.h                |  3 +
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +
 .../selftests/kvm/include/x86_64/processor.h  | 10 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++
 .../selftests/kvm/lib/x86_64/processor.c      | 67 ++++++++++++++++++-
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  2 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/state_test.c |  2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  2 +-
 10 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 5a776a08f78c..2da3316bb559 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -373,9 +373,23 @@ struct kvm_debugregs {
 	__u64 reserved[9];
 };
 
-/* for KVM_CAP_XSAVE */
+/* for KVM_CAP_XSAVE and KVM_CAP_XSAVE2 */
 struct kvm_xsave {
+	/*
+	 * KVM_GET_XSAVE2 and KVM_SET_XSAVE write and read as many bytes
+	 * as are returned by KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2)
+	 * respectively, when invoked on the vm file descriptor.
+	 *
+	 * The size value returned by KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2)
+	 * will always be at least 4096. Currently, it is only greater
+	 * than 4096 if a dynamic feature has been enabled with
+	 * ``arch_prctl()``, but this may change in the future.
+	 *
+	 * The offsets of the state save areas in struct kvm_xsave follow
+	 * the contents of CPUID leaf 0xD on the host.
+	 */
 	__u32 region[1024];
+	__u32 extra[0];
 };
 
 #define KVM_MAX_XCRS	16
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 1daa45268de2..f066637ee206 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
 #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
+#define KVM_CAP_XSAVE2 207
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1551,6 +1552,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_XSAVE */
 #define KVM_GET_XSAVE		  _IOR(KVMIO,  0xa4, struct kvm_xsave)
 #define KVM_SET_XSAVE		  _IOW(KVMIO,  0xa5, struct kvm_xsave)
+/* Available with KVM_CAP_XSAVE2 */
+#define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
 /* Available with KVM_CAP_XCRS */
 #define KVM_GET_XCRS		  _IOR(KVMIO,  0xa6, struct kvm_xcrs)
 #define KVM_SET_XCRS		  _IOW(KVMIO,  0xa7, struct kvm_xcrs)
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2d62edc49d67..65ace3f01fad 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -85,6 +85,7 @@ extern const struct vm_guest_mode_params vm_guest_mode_params[];
 int open_path_or_exit(const char *path, int flags);
 int open_kvm_dev_path_or_exit(void);
 int kvm_check_cap(long cap);
+int vm_check_cap(struct kvm_vm *vm, long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
 int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
 		    struct kvm_enable_cap *cap);
@@ -316,6 +317,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
  *   guest_code - The vCPU's entry point
  */
 void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
+void vm_xsave_req_perm(void);
 
 bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 05e65ca1c30c..58633e51960f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -10,8 +10,10 @@
 
 #include <assert.h>
 #include <stdint.h>
+#include <syscall.h>
 
 #include <asm/msr-index.h>
+#include <asm/prctl.h>
 
 #include "../kvm_util.h"
 
@@ -352,6 +354,7 @@ struct kvm_x86_state;
 struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_x86_state *state);
+void kvm_x86_state_cleanup(struct kvm_x86_state *state);
 
 struct kvm_msr_list *kvm_get_msr_index_list(void);
 uint64_t kvm_get_feature_msr(uint64_t msr_index);
@@ -443,4 +446,11 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 /* VMX_EPT_VPID_CAP bits */
 #define VMX_EPT_VPID_CAP_AD_BITS       (1ULL << 21)
 
+#define XSTATE_XTILE_CFG_BIT		17
+#define XSTATE_XTILE_DATA_BIT		18
+
+#define XSTATE_XTILE_CFG_MASK		(1ULL << XSTATE_XTILE_CFG_BIT)
+#define XSTATE_XTILE_DATA_MASK		(1ULL << XSTATE_XTILE_DATA_BIT)
+#define XFEATURE_XTILE_MASK		(XSTATE_XTILE_CFG_MASK | \
+					XSTATE_XTILE_DATA_MASK)
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 53d2b5d04b82..318ac76fd2f1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -85,6 +85,33 @@ int kvm_check_cap(long cap)
 	return ret;
 }
 
+/* VM Check Capability
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   cap - Capability
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   On success, the Value corresponding to the capability (KVM_CAP_*)
+ *   specified by the value of cap.  On failure a TEST_ASSERT failure
+ *   is produced.
+ *
+ * Looks up and returns the value corresponding to the capability
+ * (KVM_CAP_*) given by cap.
+ */
+int vm_check_cap(struct kvm_vm *vm, long cap)
+{
+	int ret;
+
+	ret = ioctl(vm->fd, KVM_CHECK_EXTENSION, cap);
+	TEST_ASSERT(ret >= 0, "KVM_CHECK_EXTENSION VM IOCTL failed,\n"
+		"  rc: %i errno: %i", ret, errno);
+
+	return ret;
+}
+
 /* VM Enable Capability
  *
  * Input Args:
@@ -344,6 +371,11 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 	struct kvm_vm *vm;
 	int i;
 
+	/*
+	 * Permission needs to be requested before KVM_SET_CPUID2.
+	 */
+	vm_xsave_req_perm();
+
 	/* Force slot0 memory size not small than DEFAULT_GUEST_PHY_PAGES */
 	if (slot0_mem_pages < DEFAULT_GUEST_PHY_PAGES)
 		slot0_mem_pages = DEFAULT_GUEST_PHY_PAGES;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index eef7b34756d5..f19d6d201977 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -650,6 +650,45 @@ static void vcpu_setup(struct kvm_vm *vm, int vcpuid)
 	vcpu_sregs_set(vm, vcpuid, &sregs);
 }
 
+#define CPUID_XFD_BIT (1 << 4)
+static bool is_xfd_supported(void)
+{
+	int eax, ebx, ecx, edx;
+	const int leaf = 0xd, subleaf = 0x1;
+
+	__asm__ __volatile__(
+		"cpuid"
+		: /* output */ "=a"(eax), "=b"(ebx),
+		  "=c"(ecx), "=d"(edx)
+		: /* input */ "0"(leaf), "2"(subleaf));
+
+	return !!(eax & CPUID_XFD_BIT);
+}
+
+void vm_xsave_req_perm(void)
+{
+	unsigned long bitmask;
+	long rc;
+
+	if (!is_xfd_supported())
+		return;
+
+	rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM,
+		     XSTATE_XTILE_DATA_BIT);
+	/*
+	 * The older kernel version(<5.15) can't support
+	 * ARCH_REQ_XCOMP_GUEST_PERM and directly return.
+	 */
+	if (rc)
+		return;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_GUEST_PERM, &bitmask);
+	TEST_ASSERT(rc == 0, "prctl(ARCH_GET_XCOMP_GUEST_PERM) error: %ld", rc);
+	TEST_ASSERT(bitmask & XFEATURE_XTILE_MASK,
+		    "prctl(ARCH_REQ_XCOMP_GUEST_PERM) failure bitmask=0x%lx",
+		    bitmask);
+}
+
 void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 {
 	struct kvm_mp_state mp_state;
@@ -1018,10 +1057,10 @@ void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 }
 
 struct kvm_x86_state {
+	struct kvm_xsave *xsave;
 	struct kvm_vcpu_events events;
 	struct kvm_mp_state mp_state;
 	struct kvm_regs regs;
-	struct kvm_xsave xsave;
 	struct kvm_xcrs xcrs;
 	struct kvm_sregs sregs;
 	struct kvm_debugregs debugregs;
@@ -1069,6 +1108,22 @@ struct kvm_msr_list *kvm_get_msr_index_list(void)
 	return list;
 }
 
+static int vcpu_save_xsave_state(struct kvm_vm *vm, struct vcpu *vcpu,
+				 struct kvm_x86_state *state)
+{
+	int size;
+
+	size = vm_check_cap(vm, KVM_CAP_XSAVE2);
+	if (!size)
+		size = sizeof(struct kvm_xsave);
+
+	state->xsave = malloc(size);
+	if (size == sizeof(struct kvm_xsave))
+		return ioctl(vcpu->fd, KVM_GET_XSAVE, state->xsave);
+	else
+		return ioctl(vcpu->fd, KVM_GET_XSAVE2, state->xsave);
+}
+
 struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
@@ -1112,7 +1167,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
         TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_REGS, r: %i",
                 r);
 
-	r = ioctl(vcpu->fd, KVM_GET_XSAVE, &state->xsave);
+	r = vcpu_save_xsave_state(vm, vcpu, state);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_XSAVE, r: %i",
                 r);
 
@@ -1157,7 +1212,7 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	int r;
 
-	r = ioctl(vcpu->fd, KVM_SET_XSAVE, &state->xsave);
+	r = ioctl(vcpu->fd, KVM_SET_XSAVE, state->xsave);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XSAVE, r: %i",
                 r);
 
@@ -1198,6 +1253,12 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
 	}
 }
 
+void kvm_x86_state_cleanup(struct kvm_x86_state *state)
+{
+	free(state->xsave);
+	free(state);
+}
+
 bool is_intel_cpu(void)
 {
 	int eax, ebx, ecx, edx;
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 2b46dcca86a8..4c7841dfd481 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -129,7 +129,7 @@ static void save_restore_vm(struct kvm_vm *vm)
 	vcpu_set_hv_cpuid(vm, VCPU_ID);
 	vcpu_enable_evmcs(vm, VCPU_ID);
 	vcpu_load_state(vm, VCPU_ID, state);
-	free(state);
+	kvm_x86_state_cleanup(state);
 
 	memset(&regs2, 0, sizeof(regs2));
 	vcpu_regs_get(vm, VCPU_ID, &regs2);
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index d0fe2fdce58c..2da8eb8e2d96 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -212,7 +212,7 @@ int main(int argc, char *argv[])
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
 		run = vcpu_state(vm, VCPU_ID);
-		free(state);
+		kvm_x86_state_cleanup(state);
 	}
 
 done:
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 32854c1462ad..2e0a92da8ff5 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -218,7 +218,7 @@ int main(int argc, char *argv[])
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
 		run = vcpu_state(vm, VCPU_ID);
-		free(state);
+		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
 		vcpu_regs_get(vm, VCPU_ID, &regs2);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index a07480aed397..ff92e25b6f1e 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -244,7 +244,7 @@ int main(int argc, char *argv[])
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
 		run = vcpu_state(vm, VCPU_ID);
-		free(state);
+		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
 		vcpu_regs_get(vm, VCPU_ID, &regs2);
