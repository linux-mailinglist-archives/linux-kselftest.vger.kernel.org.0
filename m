Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94D48135C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhL2NPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240163AbhL2NO7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783699; x=1672319699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvAB52X/ljBvqkVXOmDEHx2ZRunQtii5wpMqCx6Dy3Y=;
  b=Ym4zqplEDexE+EbYBHQcmjz64qy3BuhKALOn/IpCq9sKStuppdmNL0N7
   65Yi1gla9Jbze1ZnjNnXc8LsHZSwP+rkuA6YHhnt1krTKhBXNkGdNY/zf
   +zS3ehRiL6QicqIJA0BLWKoc9nX5XeQ2qJAnwfeuSFnCxA0RUhoma2C0s
   sDHWOkrWZpbPtH7E92owSquXZSJ4Ovph4Rp2krHao2fM5GidH9M8TYnEE
   tGmIjE8SCH8004LcUpBeSvtgQ27OeEwbBX58Q79rJiYJ1u7urIDBZTOi0
   mDuapzzKvh3j08ENs2U5pXU2toErG5qmxvQi1U0RBonqMCoVSsvGHPm8a
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876162"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281214"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:42 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 18/21] kvm: x86: Add support for getting/setting expanded xstate buffer
Date:   Wed, 29 Dec 2021 05:13:25 -0800
Message-Id: <20211229131328.12283-19-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Guang Zeng <guang.zeng@intel.com>

With KVM_CAP_XSAVE, userspace uses a hardcoded 4KB buffer to get/set
xstate data from/to KVM. This doesn't work when dynamic xfeatures
(e.g. AMX) are exposed to the guest as they require a larger buffer
size.

Introduce a new capability (KVM_CAP_XSAVE2). Userspace VMM gets the
required xstate buffer size via KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2).
KVM_SET_XSAVE is extended to work with both legacy and new capabilities
by doing properly-sized memdup_user() based on the guest fpu container.
KVM_GET_XSAVE is kept for backward-compatible reason. Instead,
KVM_GET_XSAVE2 is introduced under KVM_CAP_XSAVE2 as the preferred
interface for getting xstate buffer (4KB or larger size) from KVM
(Link: https://lkml.org/lkml/2021/12/15/510)

Also, update the api doc with the new KVM_GET_XSAVE2 ioctl.

Signed-off-by: Guang Zeng <guang.zeng@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Documentation/virt/kvm/api.rst  | 42 ++++++++++++++++++++++++++++++--
 arch/x86/include/uapi/asm/kvm.h | 16 +++++++++++-
 arch/x86/kvm/x86.c              | 43 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h        |  4 +++
 4 files changed, 101 insertions(+), 4 deletions(-)

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
index bdf89c28d2ce..76e1941db223 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4296,6 +4296,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
@@ -4899,6 +4904,16 @@ static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
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
@@ -5352,6 +5367,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_GET_XSAVE: {
+		r = -EINVAL;
+		if (vcpu->arch.guest_fpu.uabi_size > sizeof(struct kvm_xsave))
+			break;
+
 		u.xsave = kzalloc(sizeof(struct kvm_xsave), GFP_KERNEL_ACCOUNT);
 		r = -ENOMEM;
 		if (!u.xsave)
@@ -5366,7 +5385,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -5375,6 +5396,26 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
