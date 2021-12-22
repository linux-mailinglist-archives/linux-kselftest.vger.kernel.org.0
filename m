Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71947D21E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbhLVMl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:11441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245251AbhLVMl2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176888; x=1671712888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuUN6BnAHq4uqBB38FajF/LIQIO4hVtwHMMH/T44dv0=;
  b=h7GRwaZa0IL+2bq5qAdkBerewDOrVrW8MW6uu+vkXaEaLjyWl9QG3TNo
   svPeaH/k1fqpLjrXt7EclT4hGPWc+XXqCMWcUi200icf6l9rF5nzzt1ZQ
   xJ9PMwr+p5sBFLxhIuKcjK5SVYOh1IWahWmGXEmQb/Qe7e+G3ITKMi72l
   DrjGQ8V8KVONQxXgmM+I7wXnXofsd2GhkC5Nfm1W01eb0weFQihcbRKku
   0XZQumybGPYYbSplFJnC9gLFW/e6TJkSPFssuoZsHQaR5TnniEXt3Qldj
   gW1bFyy+7UZoX4fOLJ+jmWPvoku4nbTN9dGP2kUcdq6a0ey7QhBStuuS1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833435"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833435"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002780"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:07 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
Date:   Wed, 22 Dec 2021 04:40:49 -0800
Message-Id: <20211222124052.644626-20-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Guang Zeng <guang.zeng@intel.com>

When AMX is enabled it requires a larger xstate buffer than
the legacy hardcoded 4KB one. Exising kvm ioctls
(KVM_[G|S]ET_XSAVE under KVM_CAP_XSAVE) are not suitable for
this purpose.

A new capability (KVM_CAP_XSAVE2) is introduced to mark an
extended kvm_xsave format to support >4KB fpstate. The expanded
fpstate size is returned to userspace when it checks the
KVM_CAP_XSAVE2 capability.

Introduce a new KVM_GET_XSAVE2 under this capability to use the
new format for copying guest fpstate to userspace. Reuse
KVM_SET_XSAVE for both old/new formats by reimplementing it to
do properly-sized memdup_user() based on the guest fpu container.

Also, update the api doc with the new KVM_GET_XSAVE2 ioctl.

Signed-off-by: Guang Zeng <guang.zeng@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 Documentation/virt/kvm/api.rst  | 42 +++++++++++++++++++++++++++++++--
 arch/x86/include/uapi/asm/kvm.h | 16 ++++++++++++-
 arch/x86/kvm/x86.c              | 39 +++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h        |  4 ++++
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1cf2483246cd..e48f7de5f23a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1566,6 +1566,7 @@ otherwise it will return EBUSY error.
 
   struct kvm_xsave {
 	__u32 region[1024];
+	__u32 extra[0];
   };
 
 This ioctl would copy current vcpu's xsave struct to the userspace.
@@ -1574,7 +1575,7 @@ This ioctl would copy current vcpu's xsave struct to the userspace.
 4.43 KVM_SET_XSAVE
 ------------------
 
-:Capability: KVM_CAP_XSAVE
+:Capability: KVM_CAP_XSAVE and KVM_CAP_XSAVE2
 :Architectures: x86
 :Type: vcpu ioctl
 :Parameters: struct kvm_xsave (in)
@@ -1585,9 +1586,18 @@ This ioctl would copy current vcpu's xsave struct to the userspace.
 
   struct kvm_xsave {
 	__u32 region[1024];
+	__u32 extra[0];
   };
 
-This ioctl would copy userspace's xsave struct to the kernel.
+This ioctl would copy userspace's xsave struct to the kernel. It copies
+as many bytes as are returned by KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2),
+when invoked on the vm file descriptor. The size value returned by
+KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2) will always be at least 4096.
+Currently, it is only greater than 4096 if a dynamic feature has been
+enabled with ``arch_prctl()``, but this may change in the future.
+
+The offsets of the state save areas in struct kvm_xsave follow the
+contents of CPUID leaf 0xD on the host.
 
 
 4.44 KVM_GET_XCRS
@@ -5507,6 +5517,34 @@ the trailing ``'\0'``, is indicated by ``name_size`` in the header.
 The Stats Data block contains an array of 64-bit values in the same order
 as the descriptors in Descriptors block.
 
+4.42 KVM_GET_XSAVE2
+------------------
+
+:Capability: KVM_CAP_XSAVE2
+:Architectures: x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_xsave (out)
+:Returns: 0 on success, -1 on error
+
+
+::
+
+  struct kvm_xsave {
+	__u32 region[1024];
+	__u32 extra[0];
+  };
+
+This ioctl would copy current vcpu's xsave struct to the userspace. It
+copies as many bytes as are returned by KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2)
+when invoked on the vm file descriptor. The size value returned by
+KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2) will always be at least 4096.
+Currently, it is only greater than 4096 if a dynamic feature has been
+enabled with ``arch_prctl()``, but this may change in the future.
+
+The offsets of the state save areas in struct kvm_xsave follow the contents
+of CPUID leaf 0xD on the host.
+
+
 5. The kvm_run structure
 ========================
 
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 5a776a08f78c..2da3316bb559 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c558c098979a..3b756ff13103 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4297,6 +4297,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		else
 			r = 0;
 		break;
+	case KVM_CAP_XSAVE2:
+		r = kvm->vcpus[0]->arch.guest_fpu.uabi_size;
+		if (r < sizeof(struct kvm_xsave))
+			r = sizeof(struct kvm_xsave);
+		break;
 	default:
 		break;
 	}
@@ -4900,6 +4905,16 @@ static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
 				       vcpu->arch.pkru);
 }
 
+static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
+					  u8 *state, unsigned int size)
+{
+	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
+		return;
+
+	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu,
+				       state, size, vcpu->arch.pkru);
+}
+
 static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
@@ -5367,7 +5382,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SET_XSAVE: {
-		u.xsave = memdup_user(argp, sizeof(*u.xsave));
+		int size = vcpu->arch.guest_fpu.uabi_size;
+
+		u.xsave = memdup_user(argp, size);
 		if (IS_ERR(u.xsave)) {
 			r = PTR_ERR(u.xsave);
 			goto out_nofree;
@@ -5376,6 +5393,26 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_x86_set_xsave(vcpu, u.xsave);
 		break;
 	}
+
+	case KVM_GET_XSAVE2: {
+		int size = vcpu->arch.guest_fpu.uabi_size;
+
+		u.xsave = kzalloc(size, GFP_KERNEL_ACCOUNT);
+		if (!u.xsave) {
+			r = -ENOMEM;
+			break;
+		}
+
+		kvm_vcpu_ioctl_x86_get_xsave2(vcpu, u.buffer, size);
+
+		if (copy_to_user(argp, u.xsave, size)) {
+			r = -EFAULT;
+			break;
+		}
+		r = 0;
+		break;
+	}
+
 	case KVM_GET_XCRS: {
 		u.xcrs = kzalloc(sizeof(struct kvm_xcrs), GFP_KERNEL_ACCOUNT);
 		r = -ENOMEM;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1daa45268de2..9d1c01669560 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
 #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
+#define KVM_CAP_XSAVE2 207
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1610,6 +1611,9 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
+/* Available with KVM_CAP_XSAVE2 */
+#define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
+
 struct kvm_s390_pv_sec_parm {
 	__u64 origin;
 	__u64 length;
-- 
2.27.0

