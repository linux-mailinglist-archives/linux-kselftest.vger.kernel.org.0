Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333CF62AF2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 00:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKOXMB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 18:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiKOXLh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 18:11:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C362E688
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so681222pji.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkcqOwsa0mNg6ehrFGqMru8FrDdXrPVN26VUHl2O8Uk=;
        b=COkajg1xfIWppQNgvV1yPMUIBGJNDsN7XOZhgcmUBNkuQT5h7POGLw7aCrSgOJf1TM
         fi7NPk3zvATxjZv2bNJcrHavWcRc2UgJAIP6OCemRQn3b/U6IWlcE7pn+5h1em+rNTul
         dzS9rv2/1ApGIHuka4h6ZnT7Kkg/TNMxfv+hcGk4Brs4h4vfyIqc/JprwgljCNFZg+/x
         3nAyLM4Y+r/cslbUQ7jeW+L9I4aGcWyK0cnm1r5cbcnQtlYkw/v6LwqzmcrfBRb9dOQH
         Vos5+xpdw5OowrlXFlUM6umMxnMY9+Y3UBnE2eqKNCAOLOgVeg0qKEGNs0Bv4+m4ydV6
         QivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkcqOwsa0mNg6ehrFGqMru8FrDdXrPVN26VUHl2O8Uk=;
        b=yUdpm75dvAdAaqApputDnUUETBYy67mONgQ3Do+PXg6Y9BcSBEVf2se2FHYj/UYukP
         Ul1EaZKW4/0ebV9Nl7ZfsLfH2uJEbjOo18kECsCW84hL7jM8X1TYSgCT29k24Lb3/aFn
         9Swe0N2cAM+GcDdvSInKgsFtE7milRRGxhd7TRj49zwG4Io/0tFd10ws2aEN7DgeXvwd
         IE66Fn7x4RWpkLhxELOhWzNorUOlTDi/W6/khL8bI91pe03zvs5TMln7xadZvm5qt8ty
         8nDAOCNArNhfuAN3AQq3cYNGVLt+qun1uWVhScUkqLBR3f/JeDQn8pAWRLFn2hlUSfoX
         elDw==
X-Gm-Message-State: ANoB5pn/YwUFdPIHDiXE4j/9IQIlfa3dJ4QNO7t47HFkIei/82t5Yfmf
        b9nqbiS9B97spV3Yvx13rTNvzg==
X-Google-Smtp-Source: AA0mqf4dptDJmAPgoQ4OkUe9nMGJp9rh79WYxrBrUwxXp0R9JuF4HjY7fHwca8S1czlJLhZS8jHY5g==
X-Received: by 2002:a17:902:8c8d:b0:17f:73d6:4375 with SMTP id t13-20020a1709028c8d00b0017f73d64375mr6208515plo.24.1668553896035;
        Tue, 15 Nov 2022 15:11:36 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm9308372pfa.9.2022.11.15.15.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:11:35 -0800 (PST)
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
Subject: [PATCH v7 3/6] x86/fpu: Add a pkru argument to copy_uabi_to_xstate()
Date:   Tue, 15 Nov 2022 15:09:29 -0800
Message-Id: <20221115230932.7126-4-khuey@kylehuey.com>
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

In preparation for moving PKRU handling code out of
fpu_copy_uabi_to_guest_fpstate() and into copy_uabi_to_xstate(), add an
argument that copy_uabi_from_kernel_to_xstate() can use to pass the
canonical location of the PKRU value. For
copy_sigframe_from_user_to_xstate() the kernel will actually restore the
PKRU value from the fpstate, but pass in the thread_struct's pkru location
anyways for consistency.

Signed-off-by: Kyle Huey <me@kylehuey.com>
---
 arch/x86/kernel/fpu/xstate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a4d24ae66796..3a6ced76e932 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1200,8 +1200,18 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
 }
 
 
+/**
+ * copy_uabi_to_xstate - Copy a UABI format buffer to the kernel xstate
+ * @fpstate:	The fpstate buffer to copy to
+ * @kbuf:	The UABI format buffer, if it comes from the kernel
+ * @ubuf:	The UABI format buffer, if it comes from userspace
+ * @pkru:	unused
+ *
+ * Converts from the UABI format into the kernel internal hardware
+ * dependent format.
+ */
 static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
-			       const void __user *ubuf)
+			       const void __user *ubuf, u32 *pkru)
 {
 	struct xregs_state *xsave = &fpstate->regs.xsave;
 	unsigned int offset, size;
@@ -1270,7 +1280,7 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
  */
 int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru)
 {
-	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
+	return copy_uabi_to_xstate(fpstate, kbuf, NULL, pkru);
 }
 
 /*
@@ -1281,7 +1291,7 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u
 int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf);
+	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf, &tsk->thread.pkru);
 }
 
 static bool validate_independent_components(u64 mask)
-- 
2.38.1

