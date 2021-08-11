Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421103E911E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhHKMbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 08:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230195AbhHKMa6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 08:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628685035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqva//46G3P1W1i9qkUsNb1aFp4F8WxoMORniqRpjcI=;
        b=GOczVkFvyRyZtUq21yNMqHHFGxF1bRMpbBnbphtgwNDF5mBPNZqEInhZ+L8uF1eF/TD3Up
        hel8Vl9eaMbwtasgcaheMyj0KGLZeZ0Si16d5dK/SlUVS9G+E57/w3ZAGrT3C0oGrvMQpB
        wMGDi1BG9ZYOseuhItLs4sgRAaoVXcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-mHUc_4R9Om65EV7jJRPEKA-1; Wed, 11 Aug 2021 08:30:33 -0400
X-MC-Unique: mHUc_4R9Om65EV7jJRPEKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C678799FB;
        Wed, 11 Aug 2021 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F14955D9C6;
        Wed, 11 Aug 2021 12:30:14 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 5/6] KVM: x86: implement KVM_GUESTDBG_BLOCKIRQ
Date:   Wed, 11 Aug 2021 15:29:26 +0300
Message-Id: <20210811122927.900604-6-mlevitsk@redhat.com>
In-Reply-To: <20210811122927.900604-1-mlevitsk@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_GUESTDBG_BLOCKIRQ will allow KVM to block all interrupts
while running.

This change is mostly intended for more robust single stepping
of the guest and it has the following benefits when enabled:

* Resuming from a breakpoint is much more reliable.
  When resuming execution from a breakpoint, with interrupts enabled,
  more often than not, KVM would inject an interrupt and make the CPU
  jump immediately to the interrupt handler and eventually return to
  the breakpoint, to trigger it again.

  From the user point of view it looks like the CPU never executed a
  single instruction and in some cases that can even prevent forward
  progress, for example, when the breakpoint is placed by an automated
  script (e.g lx-symbols), which does something in response to the
  breakpoint and then continues the guest automatically.
  If the script execution takes enough time for another interrupt to
  arrive, the guest will be stuck on the same breakpoint RIP forever.

* Normal single stepping is much more predictable, since it won't
  land the debugger into an interrupt handler.

* RFLAGS.TF has less chance to be leaked to the guest:

  We set that flag behind the guest's back to do single stepping
  but if single step lands us into an interrupt/exception handler
  it will be leaked to the guest in the form of being pushed
  to the stack.
  This doesn't completely eliminate this problem as exceptions
  can still happen, but at least this reduces the chances
  of this happening.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 Documentation/virt/kvm/api.rst  | 1 +
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/include/uapi/asm/kvm.h | 1 +
 arch/x86/kvm/x86.c              | 4 ++++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 86d7ad3a126c..4ea1bb28297b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3357,6 +3357,7 @@ flags which can include the following:
   - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
   - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
   - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
+  - KVM_GUESTDBG_BLOCKIRQ:      avoid injecting interrupts/NMI/SMI [x86]
 
 For example KVM_GUESTDBG_USE_SW_BP indicates that software breakpoints
 are enabled in memory so we need to ensure breakpoint exceptions are
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 72fe03506018..a12db20069d5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -222,7 +222,8 @@ enum x86_intercept_stage;
 	KVM_GUESTDBG_USE_HW_BP | \
 	KVM_GUESTDBG_USE_SW_BP | \
 	KVM_GUESTDBG_INJECT_BP | \
-	KVM_GUESTDBG_INJECT_DB)
+	KVM_GUESTDBG_INJECT_DB | \
+	KVM_GUESTDBG_BLOCKIRQ)
 
 
 #define PFERR_PRESENT_BIT 0
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index a6c327f8ad9e..2ef1f6513c68 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -295,6 +295,7 @@ struct kvm_debug_exit_arch {
 #define KVM_GUESTDBG_USE_HW_BP		0x00020000
 #define KVM_GUESTDBG_INJECT_DB		0x00040000
 #define KVM_GUESTDBG_INJECT_BP		0x00080000
+#define KVM_GUESTDBG_BLOCKIRQ		0x00100000
 
 /* for KVM_SET_GUEST_DEBUG */
 struct kvm_guest_debug_arch {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e5c7b8fa1f7f..d7fade9e3b94 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8883,6 +8883,10 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 		can_inject = false;
 	}
 
+	/* Don't inject interrupts if the user asked to avoid doing so */
+	if (vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ)
+		return 0;
+
 	/*
 	 * Finally, inject interrupt events.  If an event cannot be injected
 	 * due to architectural conditions (e.g. IF=0) a window-open exit
-- 
2.26.3

