Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838602679D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgILLLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgILLIw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:08:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B193C0617B1
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so832987plz.2
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4bs7CzTnl1kRyMgFNAx/cMdF4zfB7LMPrNYc0foUqg=;
        b=dIji5loM94lPX2BlTVOZY2wSfFrN4iEdIXvEB9ZXwb9K/O+5wmsPzNlErfm8yXGVnj
         TZPx65IreQCDy5KfHVk+h3ribfRTCS3w07xBw9RenEHHmWnwHiCYzDqMOh8nMd28EDm/
         Boz7+C1dQLQJ9R1+3Y82JwQo1BdlrCLDw68lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4bs7CzTnl1kRyMgFNAx/cMdF4zfB7LMPrNYc0foUqg=;
        b=QL/aTv4ZhkBouk3PKqdALvFdRc8eEmxOhwcTJwBwk25MGRBjHRMhSOuJ0FB1M4Oi9b
         oEOt6ZYdx6n2e9KOXAzOc6jmpj325u466IrF2vNmr68EAujhJzEIQ45i0sGK5zEQAd4K
         2MnYkOsYHB1GcgG7JOiqC/P/B1uLR+kanlQI7kkLPez4x8QFrPyQJgnsj9o0op0w2Lo7
         IEtQG7KuRc78TvMjWbMjqdcOK3kZvq+QTz81XDFJ+9034jJ/2+DBCSUdZM8mqjZ1VIjO
         ls9BAefYRKZbTbmYuxG1DY1aN7en1dlWrxzWl22RHMg13o3bWqPzBal23xhb7xAlFH75
         nUBQ==
X-Gm-Message-State: AOAM530/cuEjA2ZdQ5ZNJ8tCigWWejNuGcKzHepE2B9iC/v7XlOZ+/XP
        +YTioRmEXdzYt7UNNj1jEDvoMA==
X-Google-Smtp-Source: ABdhPJx1tWnz+cXsPRMCEeezndnRWBXI9qrLyAtAljqVPQP8qrRmd00oQlT/nRtVdCFkQkBaLysfAw==
X-Received: by 2002:a17:902:c404:: with SMTP id k4mr5997422plk.70.1599908909955;
        Sat, 12 Sep 2020 04:08:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bx22sm4345524pjb.23.2020.09.12.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/15] selftests/seccomp: Convert HAVE_GETREG into ARCH_GETREG/ARCH_SETREG
Date:   Sat, 12 Sep 2020 04:08:13 -0700
Message-Id: <20200912110820.597135-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of special-casing the get/set-registers routines, move the
HAVE_GETREG logic into the new ARCH_GETREG() and ARCH_SETREG() macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 3b77bdbe7125..a986f2332327 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1821,20 +1821,21 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 	} while (0)
 #endif
 
-/* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
+/*
+ * Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
  * architectures without HAVE_ARCH_TRACEHOOK (e.g. User-mode Linux).
  */
 #if defined(__x86_64__) || defined(__i386__) || defined(__mips__)
-#define HAVE_GETREGS
+# define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS, tracee, 0, &(_regs))
+# define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS, tracee, 0, &(_regs))
 #endif
 
 /* Architecture-specific syscall fetching routine. */
 int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 {
 	ARCH_REGS regs;
-#ifdef HAVE_GETREGS
-	EXPECT_EQ(0, ptrace(PTRACE_GETREGS, tracee, 0, &regs)) {
-		TH_LOG("PTRACE_GETREGS failed");
+#ifdef ARCH_GETREGS
+	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return -1;
 	}
 #else
@@ -1855,17 +1856,19 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 void change_syscall(struct __test_metadata *_metadata,
 		    pid_t tracee, int syscall, int result)
 {
-	int ret;
 	ARCH_REGS regs;
-#ifdef HAVE_GETREGS
-	ret = ptrace(PTRACE_GETREGS, tracee, 0, &regs);
+#ifdef ARCH_GETREGS
+	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
+		return;
+	}
 #else
+	int ret;
 	struct iovec iov;
 	iov.iov_base = &regs;
 	iov.iov_len = sizeof(regs);
 	ret = ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov);
-#endif
 	EXPECT_EQ(0, ret);
+#endif
 
 	SYSCALL_NUM_SET(regs, syscall);
 
@@ -1878,14 +1881,14 @@ void change_syscall(struct __test_metadata *_metadata,
 #endif
 
 	/* Flush any register changes made. */
-#ifdef HAVE_GETREGS
-	ret = ptrace(PTRACE_SETREGS, tracee, 0, &regs);
+#ifdef ARCH_SETREGS
+	EXPECT_EQ(0, ARCH_SETREGS(regs));
 #else
 	iov.iov_base = &regs;
 	iov.iov_len = sizeof(regs);
 	ret = ptrace(PTRACE_SETREGSET, tracee, NT_PRSTATUS, &iov);
-#endif
 	EXPECT_EQ(0, ret);
+#endif
 }
 
 void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
-- 
2.25.1

