Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B262AF33
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 00:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiKOXME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 18:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiKOXLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 18:11:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267832E9C8
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id l2so14766904pld.13
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qpXWSCDrMjTrrN7DSUZrVNnGlngy6qbcHa+BWaBxfw=;
        b=by3OpFNkQCvqiF7Z+Ei1ZUihu4ifOPLgyDRqCGJ9mDwSmsppwq5B3L7OSbVs6FSzZq
         uhL+U8YozGaxewngILbOAgMLv44xfey9tO53DDpqYVyjzvahWzl8o30YKcgVXdT8kNm+
         yVYA2KpHsHz+kaX5LE4vA2BwqI/ZXosIYX/iaFNgbaNHzVkjrTPfHjGOFLGbgOY2TEO8
         UoZlZ+woOIAoxIsgvz0lPHGOU7pjF/pHTS8lE2M3ixMF41UBdWT/uVG4VyrikJK0hbZp
         ANMTkWGeITdPtIEs873AmNugHQc01OnW4Tepj+jV9QwKdUq+iq1VRDxQMMnKRRXkkUfl
         w74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qpXWSCDrMjTrrN7DSUZrVNnGlngy6qbcHa+BWaBxfw=;
        b=WPKQn4xn2YjQ1zcPpX1JuUOKFjkED+y9gns19hFZiLGhKyNZhQzespzLnId3NENHFt
         YBLjrUzDGEjCzG22/JOBL9lV06hymEA7w9SvYfBRyjsQLg6xgOsU2Ru550a4vq5c9MR3
         qNIg+Zjke1naQYDgu+qZRgZ5+z/jwqm5W5mypK+CZnpu0I7TfNEjJ0WuCgxFmv8zX7k2
         L+sGaa+8v8NOMJJsEHfjUZz3LfUYTpZzEUsbVHEswrATIlpY61O4XtY5SzdbhiAoJ3j2
         cM9eJv8FEi7373t8m40iCnOZCWwjj8ixoBtBacaExFjrxw5K0e5PcPgsXW7KRyR0jmpi
         TU6A==
X-Gm-Message-State: ANoB5plNiLKHigKFJXvmGRCvVtZFOcJLZ02o3HNnX6xCgd5MwZJe9POF
        DwNNOeVPEg68lc31OTcA2Fme2w==
X-Google-Smtp-Source: AA0mqf6g2OWKVo26BWZuPzVY1oFYsPcCmZrMrHsai4e2FYYAhJslj93GI6fE4NLB74yKH7+yJpSz+w==
X-Received: by 2002:a17:902:8649:b0:187:3921:2b2d with SMTP id y9-20020a170902864900b0018739212b2dmr6440688plt.13.1668553899569;
        Tue, 15 Nov 2022 15:11:39 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm9308372pfa.9.2022.11.15.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:11:39 -0800 (PST)
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
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@suse.de>,
        stable@vger.kernel.org
Subject: [PATCH v7 5/6] x86/fpu: Emulate XRSTOR's behavior if the xfeatures PKRU bit is not set
Date:   Tue, 15 Nov 2022 15:09:31 -0800
Message-Id: <20221115230932.7126-6-khuey@kylehuey.com>
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

The hardware XRSTOR instruction resets the PKRU register to its hardware
init value (namely 0) if the PKRU bit is not set in the xfeatures mask.
Emulating that here restores the pre-5.14 behavior for PTRACE_SET_REGSET
with NT_X86_XSTATE, and makes sigreturn (which still uses XRSTOR) and
ptrace behave identically. KVM has never used XRSTOR and never had this
behavior, so KVM opts-out of this emulation by passing a NULL pkru pointer
to copy_uabi_to_xstate().

Fixes: e84ba47e313d ("x86/fpu: Hook up PKRU into ptrace()")
Signed-off-by: Kyle Huey <me@kylehuey.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org # 5.14+
---
 arch/x86/kernel/fpu/core.c   |  8 ++++++++
 arch/x86/kernel/fpu/xstate.c | 15 ++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 46b935bc87c8..8d0f6019c21d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -404,6 +404,14 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
+	/*
+	 * Nullify @vpkru to preserve its current value if PKRU's bit isn't set
+	 * in the header.  KVM's odd ABI is to leave PKRU untouched in this
+	 * case (all other components are eventually re-initialized).
+	 */
+	if (!(ustate->xsave.header.xfeatures & XFEATURE_MASK_PKRU))
+		vpkru = NULL;
+
 	return copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bebc30c29ed3..193c6e95daa8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1219,8 +1219,14 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
  *	it is harmless.
  * 2.	When called from ptrace the PKRU register will be restored from the
  *	thread_struct's pkru field. A pointer to that is passed in @pkru.
+ *	The kernel will restore it manually, so the XRSTOR behavior that resets
+ *	the PKRU register to the hardware init value (0) if the corresponding
+ *	xfeatures bit is not set is emulated here.
  * 3.	When called from KVM the PKRU register will be restored from the vcpu's
- *	pkru field. A pointer to that is passed in @pkru.
+ *	pkru field. A pointer to that is passed in @pkru. KVM hasn't used
+ *	XRSTOR and hasn't had the PKRU resetting behavior described above. To
+ *	preserve that KVM behavior, it passes NULL for @pkru if the xfeatures
+ *	bit is not set.
  */
 static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 			       const void __user *ubuf, u32 *pkru)
@@ -1277,6 +1283,13 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 
 		xpkru = __raw_xsave_addr(xsave, XFEATURE_PKRU);
 		*pkru = xpkru->pkru;
+	} else {
+		/*
+		 * KVM may pass NULL here to indicate that it does not need
+		 * PKRU updated.
+		 */
+		if (pkru)
+			*pkru = 0;
 	}
 
 	/*
-- 
2.38.1

