Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1362062AF30
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 00:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKOXMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 18:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKOXLe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 18:11:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0A2E6A6
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso533517pjg.5
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhCq8AfDMkagyPimKyHUX7gwQAIYuE0429CZlbx4GKo=;
        b=GimrCofVDchBbipFskt1iUCOXnsWmIdeeUhJXRau6K5YrKcWWLcbm4F6m/Rt+KUJAw
         +WRhPd+7BzDfOsxy0qrFpcfJzeV+BcJpYPqUUHzjI40fCqFnDZ/60Sn/OqkCFCwvJ1Pa
         8fbLcULMD5kLsZxJQx+HNteTzYyOKSAqUvU6rdjNsW8sgOgMMV75IDivsBzAHyMGZTSN
         1LCWAgm2a9FTx2BX9r0sq0SdTky6C/z5V1IyDlILeX5grbmZ82gCRccKNehMA4xWGVLe
         jDkvaMW/D3aT8UGl4tk5nqXwC7c4CNpe93sbiL70+q70UZ6IwOrMNi/O9mCpoQygC8oy
         X3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhCq8AfDMkagyPimKyHUX7gwQAIYuE0429CZlbx4GKo=;
        b=1MbGKlJhIGh1OoSl72QjS37c5qo5UCQa5Je5sTz083Vq9rAmB8OA5Tf12oCQKY5jzh
         b8wOLapTQBJBUbzi83pkzQcQm9zrK6VJJlW24RxCM8l3CTknbrmAuTz82qKiVdFD9xty
         PPDJhfnaUjY7J5zER9wqA6K9ud+RcYBMNYDFJnRQ//O0pdj6t8Tg+mnN/mJcLvQDqxsH
         YcpP0j82IhACbdMLcg8EcCBSNe1hDbsG7G4XKz6+QsH/OwwugJqf5eOIhIp000bU68qs
         u3iMwW2qZqsHE47yuBtpgv/56ubT1+Y96dgB4c9fQNQWuBWQjn0F5w22BZo9oRbR4n6x
         I/Mg==
X-Gm-Message-State: ANoB5pmdYsub1z8a8BGNh0RFDaq+/8vN5wwNlyyHS8MS2d3rnWNhL8G9
        CpOEJ3qkYUXfIbuCpETOTE+qow==
X-Google-Smtp-Source: AA0mqf50b32MPLpexUP0a4tDcIJCk5x0ZodYS2aCyV4pcpz0b8K3PiqlqkiYrSo+RAIM5LHM0r8f/w==
X-Received: by 2002:a17:902:e483:b0:188:b44b:598 with SMTP id i3-20020a170902e48300b00188b44b0598mr6272266ple.54.1668553892785;
        Tue, 15 Nov 2022 15:11:32 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm9308372pfa.9.2022.11.15.15.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:11:32 -0800 (PST)
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
Subject: [PATCH v7 1/6] x86/fpu: Take task_struct* in copy_sigframe_from_user_to_xstate()
Date:   Tue, 15 Nov 2022 15:09:27 -0800
Message-Id: <20221115230932.7126-2-khuey@kylehuey.com>
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

This will allow copy_sigframe_from_user_to_xstate() to grab the address of
thread_struct's pkru value in a later patch.

Signed-off-by: Kyle Huey <me@kylehuey.com>
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 arch/x86/kernel/fpu/xstate.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 91d4b6de58ab..558076dbde5b 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -396,7 +396,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 
 	fpregs = &fpu->fpstate->regs;
 	if (use_xsave() && !fx_only) {
-		if (copy_sigframe_from_user_to_xstate(fpu->fpstate, buf_fx))
+		if (copy_sigframe_from_user_to_xstate(tsk, buf_fx))
 			return false;
 	} else {
 		if (__copy_from_user(&fpregs->fxsave, buf_fx,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 59e543b95a3c..32ba5d95628d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1278,10 +1278,10 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf)
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate,
+int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(fpstate, NULL, ubuf);
+	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf);
 }
 
 static bool validate_independent_components(u64 mask)
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 5ad47031383b..f08ee2722e74 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -47,7 +47,7 @@ extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 				    enum xstate_copy_mode mode);
 extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf);
-extern int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate, const void __user *ubuf);
+extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void __user *ubuf);
 
 
 extern void fpu__init_cpu_xstate(void);
-- 
2.38.1

