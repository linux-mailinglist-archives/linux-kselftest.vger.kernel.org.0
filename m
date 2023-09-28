Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C37B0FD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 02:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjI1AUE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 20:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjI1AUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 20:20:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1152BF
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:01 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2790596f212so1755568a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695860401; x=1696465201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7k/cxJ1J05mXofpy+yLrAPKcq05pdFZcXDQm+nHvOh0=;
        b=Jix9Z+z1mgZim2DhEo3+oKGsCuAjr9wIhjUtAFyli3RdoF/8Dr+cUv7HSW/WDYUj5m
         1Zq2pWhjO2XZuDI54BRxXCl3uA5NGsR61qdjaT9kRpgh0vIVUXqZrsfc5ClWqZgGM2W+
         ridPyL9U/Ae7UWkHRKvKlm/GK/YGu2d1bp5GZNm+QDU+Rwm8oYbiK05nZA3fYzhoYFZe
         ENJWY0wtt8LcWmHlE23CyXlsSrkuvP28IarWQZr14S8cw7pXtFTj9vDTnS3rwceMIEE3
         Pd8wb9aI7047LrsIBuTyHr9+mNvhfBfyg8kI4qXBkWBM/2KHRiczC8DqHqCTJGNIPZaK
         Hxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860401; x=1696465201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7k/cxJ1J05mXofpy+yLrAPKcq05pdFZcXDQm+nHvOh0=;
        b=GjpqDDiAwDErg6zE/YgmY7d1UHSpgLsPH9e4dBz58qsULFhYEQAbV0BP8hpSIHTfvT
         qnndm+EQwNgIsOH3NcViAOnIXRT9I+8NPKtal8vGLdNf0N8SVSOvlsLqZCB+6bRLBSAc
         P1xH8uhpP6QnBU2hS6wBbCVfQiivqiAPfoUSJYiaicmJlzYPusshQ4CwhVIEneYgk/eZ
         5sh8xZoWJFV4q27cLA3/bcQ2swcP3B5EoVuSxH+Opw1a5BVUsMsoRniVhuHX1ZhtlEm0
         niIrNFdG1VMPH/eqnt6KcQZ+trei125Ao763+SjYs76sjFtqrg0FolwjL1ssQ+sa6Bm0
         4YdQ==
X-Gm-Message-State: AOJu0Yw6C4/n5cP2C7VyvvOptr+VcD4E9MxUORLygrDGrHxtSQ0gx/KQ
        djadq4HzP6NBAkneC8gYNF6aWiOp5BI=
X-Google-Smtp-Source: AGHT+IHUHbIQ6PPrXr871nzGKn8uvOKQadMijarjccPvoUFTuvaHfSFH6uboJDbvWzUn4a9M0jJjxQFQUF8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:230f:b0:1bf:559a:7bd6 with SMTP id
 d15-20020a170903230f00b001bf559a7bd6mr47609plh.3.1695860401273; Wed, 27 Sep
 2023 17:20:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Sep 2023 17:19:52 -0700
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928001956.924301-2-seanjc@google.com>
Subject: [PATCH 1/5] x86/fpu: Allow caller to constrain xfeatures when copying
 to uabi buffer
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Plumb an xfeatures mask into __copy_xstate_to_uabi_buf() so that KVM can
constrain which xfeatures are saved into the userspace buffer without
having to modify the user_xfeatures field in KVM's guest_fpu state.

KVM's ABI for KVM_GET_XSAVE{2} is that features that are not exposed to
guest must not show up in the effective xstate_bv field of the buffer.
Saving only the guest-supported xfeatures allows userspace to load the
saved state on a different host with a fewer xfeatures, so long as the
target host supports the xfeatures that are exposed to the guest.

KVM currently sets user_xfeatures directly to restrict KVM_GET_XSAVE{2} to
the set of guest-supported xfeatures, but doing so broke KVM's historical
ABI for KVM_SET_XSAVE, which allows userspace to load any xfeatures that
are supported by the *host*.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/fpu/api.h |  3 ++-
 arch/x86/kernel/fpu/core.c     |  5 +++--
 arch/x86/kernel/fpu/xstate.c   |  7 +++++--
 arch/x86/kernel/fpu/xstate.h   |  3 ++-
 arch/x86/kvm/x86.c             | 23 ++++++++++-------------
 5 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 31089b851c4f..a2be3aefff9f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -157,7 +157,8 @@ static inline void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd) {
 static inline void fpu_sync_guest_vmexit_xfd_state(void) { }
 #endif
 
-extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
+extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
+					   unsigned int size, u64 xfeatures, u32 pkru);
 extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
 
 static inline void fpstate_set_confidential(struct fpu_guest *gfpu)
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a86d37052a64..a21a4d0ecc34 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -369,14 +369,15 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpstate);
 
 void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
-				    unsigned int size, u32 pkru)
+				    unsigned int size, u64 xfeatures, u32 pkru)
 {
 	struct fpstate *kstate = gfpu->fpstate;
 	union fpregs_state *ustate = buf;
 	struct membuf mb = { .p = buf, .left = size };
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
-		__copy_xstate_to_uabi_buf(mb, kstate, pkru, XSTATE_COPY_XSAVE);
+		__copy_xstate_to_uabi_buf(mb, kstate, xfeatures, pkru,
+					  XSTATE_COPY_XSAVE);
 	} else {
 		memcpy(&ustate->fxsave, &kstate->regs.fxsave,
 		       sizeof(ustate->fxsave));
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cadf68737e6b..76408313ed7f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1049,6 +1049,7 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
  * __copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
  * @fpstate:	The fpstate buffer from which to copy
+ * @xfeatures:	The mask of xfeatures to save (XSAVE mode only)
  * @pkru_val:	The PKRU value to store in the PKRU component
  * @copy_mode:	The requested copy mode
  *
@@ -1059,7 +1060,8 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
  * It supports partial copy but @to.pos always starts from zero.
  */
 void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
-			       u32 pkru_val, enum xstate_copy_mode copy_mode)
+			       u64 xfeatures, u32 pkru_val,
+			       enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit = &init_fpstate.regs.xsave;
@@ -1083,7 +1085,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 		break;
 
 	case XSTATE_COPY_XSAVE:
-		header.xfeatures &= fpstate->user_xfeatures;
+		header.xfeatures &= fpstate->user_xfeatures & xfeatures;
 		break;
 	}
 
@@ -1185,6 +1187,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
 	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu.fpstate,
+				  tsk->thread.fpu.fpstate->user_xfeatures,
 				  tsk->thread.pkru, copy_mode);
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..3518fb26d06b 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -43,7 +43,8 @@ enum xstate_copy_mode {
 
 struct membuf;
 extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
-				      u32 pkru_val, enum xstate_copy_mode copy_mode);
+				      u64 xfeatures, u32 pkru_val,
+				      enum xstate_copy_mode copy_mode);
 extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 				    enum xstate_copy_mode mode);
 extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9f18b06bbda6..41d8e6c8570c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5382,17 +5382,6 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
-					 struct kvm_xsave *guest_xsave)
-{
-	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
-		return;
-
-	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu,
-				       guest_xsave->region,
-				       sizeof(guest_xsave->region),
-				       vcpu->arch.pkru);
-}
 
 static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 					  u8 *state, unsigned int size)
@@ -5400,8 +5389,16 @@ static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return;
 
-	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu,
-				       state, size, vcpu->arch.pkru);
+	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu, state, size,
+				       vcpu->arch.guest_fpu.fpstate->user_xfeatures,
+				       vcpu->arch.pkru);
+}
+
+static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
+					 struct kvm_xsave *guest_xsave)
+{
+	return kvm_vcpu_ioctl_x86_get_xsave2(vcpu, (void *)guest_xsave->region,
+					     sizeof(guest_xsave->region));
 }
 
 static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
-- 
2.42.0.582.g8ccd20d70d-goog

