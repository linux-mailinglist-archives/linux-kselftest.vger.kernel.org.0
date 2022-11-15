Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E730162AF32
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 00:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKOXMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 18:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKOXLf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 18:11:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93232E680
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so542238pjs.4
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkXZyYO2hGQH+BId88DD3kMOt/JKYNASeU3kq3/BxNg=;
        b=PJSFalW97JocjRPsweyy+GvKZWv53ItjFSUoPx5y9DdQ6EZ/fzc+SZpCngVuSd9ea1
         LlVOTnFpygwuMc3lztlKy+xmDdb+Jp/+xaSiCp9boUPxnjP7mObm84gEd526bQlKMdKW
         tIgzIfdG2ycjjmG23/XuePNtsMRIGoQMQNfwDlCWtaSjDiGY1UowCVM8bqRYoONG2bbc
         I+d6SnAqmdBy6cFZWgDfGsC9zzqcv8d4iGLP/cJX/FPyfHJrLqafXYRt827bXtjHLxHW
         lHyI34dIT86OTlpWY2FinxvlEhvZLL0UIdSVo1hAKM3l1YPJV1d/rsASSEGIkcIKAwnZ
         RwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkXZyYO2hGQH+BId88DD3kMOt/JKYNASeU3kq3/BxNg=;
        b=lg56whyyMzJpkGjmLnTriy4Hhr9/51B3XZ9rsiT8zEjDLZZByq2skbgrsT5K46rZzO
         bxPISmvMpdCLLaPlcqPr3mPIb65JviNcUib8M6orTKvPaAa7mS87rkD6B0wLPTJd16t6
         2wbmont8GwMlMJAsXuWK4lV12NTaQVK9YV2U/QyNw97GliYL2bf3SFgGtT+RQEJuz+qy
         mnsoatEwW1G7QOKG56eo48KEfCti+iJUQts5gOy8yopvEeFO8JQ1kPYwrhkWVs+omaEI
         WzYH91uZ5TolwXjBNWXzR176SwmbKKVfgW/4qRasU1FCTcDrzYMc6AhMMc2YVKSJbnDe
         CmfQ==
X-Gm-Message-State: ANoB5pnhLYeLEi39xERzn5XXmgjZoygx7lc3vl8XHn9HzFZAVCq9Bnpt
        Uigsop2cE71dfGbeByB2znJOGQ==
X-Google-Smtp-Source: AA0mqf75xxW4N9M95sb0sBsucwu2KWj9VrPDShkwX51uZY6Fbc5+qkz1jqYor6l+Fxz5aXrzC9V3Gw==
X-Received: by 2002:a17:903:228e:b0:177:faf5:58c5 with SMTP id b14-20020a170903228e00b00177faf558c5mr6230654plh.166.1668553894421;
        Tue, 15 Nov 2022 15:11:34 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm9308372pfa.9.2022.11.15.15.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:11:34 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>,
        Kyle Huey <me@kylehuey.com>
Subject: [PATCH v7 2/6] x86/fpu: Add a pkru argument to copy_uabi_from_kernel_to_xstate().
Date:   Tue, 15 Nov 2022 15:09:28 -0800
Message-Id: <20221115230932.7126-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115230932.7126-1-khuey@kylehuey.com>
References: <20221115230932.7126-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both KVM (through KVM_SET_XSTATE) and ptrace (through PTRACE_SETREGSET
with NT_X86_XSTATE) ultimately call copy_uabi_from_kernel_to_xstate(),
but the canonical locations for the current PKRU value for KVM guests
and processes in a ptrace stop are different (in the kvm_vcpu_arch and
the thread_state structs respectively). In preparation for eventually
handling PKRU in copy_uabi_to_xstate, pass in a pointer to the PKRU
location.

Signed-off-by: Kyle Huey <me@kylehuey.com>
---
 arch/x86/kernel/fpu/core.c   | 2 +-
 arch/x86/kernel/fpu/regset.c | 2 +-
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/fpu/xstate.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3b28c5b25e12..550157686323 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -406,7 +406,7 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
-	ret = copy_uabi_from_kernel_to_xstate(kstate, ustate);
+	ret = copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 75ffaef8c299..6d056b68f4ed 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -167,7 +167,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf, &target->thread.pkru);
 
 out:
 	vfree(tmpbuf);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 32ba5d95628d..a4d24ae66796 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1268,7 +1268,7 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
  * format and copy to the target thread. Used by ptrace and KVM.
  */
-int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru)
 {
 	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
 }
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index f08ee2722e74..a4ecb04d8d64 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -46,7 +46,7 @@ extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 				      u32 pkru_val, enum xstate_copy_mode copy_mode);
 extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 				    enum xstate_copy_mode mode);
-extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf);
+extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru);
 extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void __user *ubuf);
 
 
-- 
2.38.1

