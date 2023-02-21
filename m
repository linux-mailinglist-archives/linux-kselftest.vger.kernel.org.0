Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FCB69E4C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjBUQhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjBUQhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:20 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D48C279AB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:19 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id s9-20020a056a00194900b005a8c5cd5ae9so2629923pfk.22
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2iAI7qeN019fW7cnXiCIU1jbXC6JQmM9w058O8z3YH8=;
        b=XdkwDudCAzkUeqDZelIh5hAd5V3dHZzXBuFYZkqJd4pFfa+UTybJ8/AW+lAhYwqmS+
         tbVt7VgxCnQmFM8/M2zF08LXl+P5rYttqkZsSMpRyNm2aUA2qkAZtGyIcbLnnVGKH7MB
         vhtd85nvW4gXenpyrZSEHHvz0+5qG0Ei5unm5oCB1/Qmmt3XyFzr8cJWPQfnh05mvVAV
         jpcjB8DFA/xaMuE68egf7ZIkGP57N7Fc7cCyBUTy31SaY7FwcTnTA1B86Fv9eMZ5LzA+
         OY1P17jE1KaBI0GR9zW0iasO6w+Zn6hq5XF74zuLr9/ITXX3ToAx4IVTHsLJQoRAX22W
         ccKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iAI7qeN019fW7cnXiCIU1jbXC6JQmM9w058O8z3YH8=;
        b=jsClZ+jE1QoiC3lPoje9snHnr9ULBO3o2t2Qc/Glfs+cgVIRSzVzdZrCfTWMe675nS
         FhU3zyai1OpQpdyeyd4NpPRckuKYNs35J/7vL0kREeoUGK3o5TG86+NjXviOjLV2mKhR
         BUFZ8btfME3HKM1k3+PmXdr+lt+0TZwoJQBZ0VC/zx8UgS+u+5oqSUJlIzHbrf75vyOS
         ql8lRswUR0sfAZc+ZOLdLUVRbsnefKynQlxJ6LTaOG2lCIDEQpKhDS9oiBQ2L+5Wpa1o
         DxIB1Shyr0yFJaXGnwnuqxW+MEt3pXsMmSGfm5Nja3SbS9r+YFOtjTEo9RnCT7oLsA/p
         wm7w==
X-Gm-Message-State: AO0yUKW/hUfkzqT29wGP5c11VLnKHCFL5TgaLrD76qZCpMDECNnCpFdS
        2wxH1SUUyrfL87oqp96W2UZkssI3aUKt
X-Google-Smtp-Source: AK7set8LvhHN5qmTlVL5B5s+7zuXmCqcFbefrPXxO60eZ8HvEU34oKqDiVYD48Dd6NrtMWxW9iZ6W1TH5i+F
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:2c4f:0:b0:502:2111:ba7c with SMTP id
 s76-20020a632c4f000000b005022111ba7cmr669064pgs.2.1676997438814; Tue, 21 Feb
 2023 08:37:18 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:43 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-2-mizhang@google.com>
Subject: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid getting xstate address of init_fpstate if fpstate contains the xstate
component. Since XTILEDATA (bit 18) was turned off in xinit, when KVM calls
__raw_xsave_addr(xinit, 18), it triggers a warning as follows.

__raw_xsave_addr() is an internal function that assume caller does the
checking, ie., all function arguments should be checked before calling.
So, instead of removing the WARNING, add checks in
__copy_xstate_to_uabi_buf().

[  168.814082] ------------[ cut here ]------------
[  168.814083] WARNING: CPU: 35 PID: 15304 at arch/x86/kernel/fpu/xstate.c:934 __raw_xsave_addr+0xc8/0xe0
[  168.814088] Modules linked in: kvm_intel dummy bridge stp llc cdc_ncm cdc_eem cdc_ether usbnet mii ehci_pci ehci_hcd vfat fat cdc_acm xhci_pci xhci_hcd idpf(O)
[  168.814100] CPU: 35 PID: 15304 Comm: amx_test Tainted: G S         O       6.2.0-smp-DEV #6
[  168.814103] RIP: 0010:__raw_xsave_addr+0xc8/0xe0
[  168.814105] Code: 83 f9 40 72 b0 eb 10 48 63 ca 44 8b 04 8d 60 13 1e 82 eb 03 41 89 f8 44 89 c1 48 01 c8 48 83 c4 08 5d c3 cc 0f 0b 31 c0 eb f3 <0f> 0b 48 c7 c7 c7 28 11 82 e8 da 30 b0 00 31 c0 eb e1 66 0f 1f 44
[  168.814106] RSP: 0018:ff110020ef79bc90 EFLAGS: 00010246
[  168.814108] RAX: ffffffff821e0340 RBX: 0000000000000012 RCX: 0000000000000012
[  168.814109] RDX: 0000000000000012 RSI: 80000000000206e7 RDI: 0000000000040000
[  168.814110] RBP: ff110020ef79bc98 R08: 0000000000000a00 R09: 0000000000000012
[  168.814112] R10: 0000000000000012 R11: 0000000000000004 R12: ffa00000089f2a40
[  168.814113] R13: 0000001200000000 R14: 0000000000000012 R15: ff110020ef288b00
[  168.814114] FS:  00007f1812761300(0000) GS:ff11003fff4c0000(0000) knlGS:0000000000000000
[  168.814116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.814117] CR2: 00007f1812555008 CR3: 0000002093a80002 CR4: 0000000000373ee0
[  168.814118] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  168.814119] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  168.814120] Call Trace:
[  168.814121]  <TASK>
[  168.814122]  __copy_xstate_to_uabi_buf+0x3cb/0x520
[  168.814125]  fpu_copy_guest_fpstate_to_uabi+0x29/0x50
[  168.814127]  kvm_arch_vcpu_ioctl+0x9f7/0xee0
[  168.814130]  ? __kmem_cache_free+0x16b/0x220
[  168.814133]  kvm_vcpu_ioctl+0x47c/0x5a0
[  168.814136]  __se_sys_ioctl+0x77/0xc0
[  168.814138]  __x64_sys_ioctl+0x1d/0x20
[  168.814139]  do_syscall_64+0x3d/0x80
[  168.814142]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  168.814146] RIP: 0033:0x7f1812892c87
[  168.814148] Code: 5d c3 cc 48 8b 05 39 1d 07 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 cc cc cc cc cc cc cc cc cc cc b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 1d 07 00 f7 d8 64 89 01 48
[  168.814149] RSP: 002b:00007ffc4cebf538 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  168.814151] RAX: ffffffffffffffda RBX: 00007f1812761280 RCX: 00007f1812892c87
[  168.814152] RDX: 00000000004dcda0 RSI: 000000009000aecf RDI: 0000000000000007
[  168.814153] RBP: 0000000000002b00 R08: 00000000004d5010 R09: 0000000000002710
[  168.814154] R10: 00007f1812906980 R11: 0000000000000246 R12: 00000000004d8110
[  168.814155] R13: 0000000000000004 R14: 00000000004d78b0 R15: 0000000000000004
[  168.814156]  </TASK>
[  168.814157] ---[ end trace 0000000000000000 ]---

Fixes: e84ba47e313d ("x86/fpu: Hook up PKRU into ptrace()")
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kernel/fpu/xstate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 714166cc25f2..5cc1426c3800 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1063,6 +1063,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	struct xregs_state *xsave = &fpstate->regs.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
+	void *xsave_addr;
 	u64 mask;
 	int i;
 
@@ -1151,10 +1152,11 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			pkru.pkru = pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
-				     __raw_xsave_addr(xsave, i),
-				     __raw_xsave_addr(xinit, i),
-				     xstate_sizes[i]);
+			xsave_addr = (header.xfeatures & BIT_ULL(i)) ?
+				__raw_xsave_addr(xsave, i) :
+				__raw_xsave_addr(xinit, i);
+
+			membuf_write(&to, xsave_addr, xstate_sizes[i]);
 		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
-- 
2.39.2.637.g21b0678d19-goog

