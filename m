Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A162679B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgILLJz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgILLJI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223CC0617BE
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j34so8200351pgi.7
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9Scn27yFC+W9ArnzObQ75YlAm/mAi2yXdvN+WcxI8I=;
        b=NvsFIwxBor6gbhPRLZwb/jVT/T+nX6Z+XVHXFtFu/TcUGNP3/MncUQtopjc936YDWp
         R3xYst7NJXA6aVBOzW2yqYtx004tCHQMSEjrxUDj6uvghiw4gRHuKyf6orJdFpOnqppR
         k41JqT9G2h68b34eiIX80bwMoGJZHY/CSxIQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9Scn27yFC+W9ArnzObQ75YlAm/mAi2yXdvN+WcxI8I=;
        b=AahceZcwIB/aI8s2Vp7x0bJWFmve/5cIOaPqsFL5mXnI6x27xjQb9gqs0eL1WM4cu5
         EaPz3ODFwUvdfXbx7rlEC+/9R89W8PZlHlrdY0KAeKXmLChwMJjshxV9qKEJfi7RVoFJ
         H58iTu6EhZ0YARRb3FNdmuStxBje6xiVjDeV6QlT3pTIh74FdibBu/E6wRLBjxj6lBM2
         WML+NVL7hQ2VT6kV17r7xuczpZxy4e0RJEJUQ25xLRm57yGduaTuQcYDEBNmqa6W1KWJ
         idQoF8qeb3p5R+iAsfnybNw+y2ZZPE4IdTIkZot2EBszQURHk5uJ03XSIgydz1nrWVNZ
         cX5w==
X-Gm-Message-State: AOAM530QK1wkHmS3SkV+67PjdVgwhuWrPo7xh8pvuJAgZm5n7U3mrDy4
        ZNYpQft0suYww3ItbwulGoxL6Q==
X-Google-Smtp-Source: ABdhPJxOfgT/KlEkxzDrBNa4LGCxQcYJ5lPhAwfQMk4WTnlFoUysQ4K+RWVpU1AXIS+4PLjRZ0yExg==
X-Received: by 2002:a63:60e:: with SMTP id 14mr4570723pgg.343.1599908911776;
        Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm4139666pjv.16.2020.09.12.04.08.26
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
Subject: [PATCH 09/15] selftests/seccomp: Convert REGSET calls into ARCH_GETREG/ARCH_SETREG
Date:   Sat, 12 Sep 2020 04:08:14 -0700
Message-Id: <20200912110820.597135-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Consolidate the REGSET logic into the new ARCH_GETREG() and
ARCH_SETREG() macros, avoiding more #ifdef code in function bodies.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 42 +++++++------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index a986f2332327..d9346121b89b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1828,26 +1828,29 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #if defined(__x86_64__) || defined(__i386__) || defined(__mips__)
 # define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS, tracee, 0, &(_regs))
 # define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS, tracee, 0, &(_regs))
+#else
+# define ARCH_GETREGS(_regs)	({					\
+		struct iovec __v;					\
+		__v.iov_base = &(_regs);				\
+		__v.iov_len = sizeof(_regs);				\
+		ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &__v);	\
+	})
+# define ARCH_SETREGS(_regs)	({					\
+		struct iovec __v;					\
+		__v.iov_base = &(_regs);				\
+		__v.iov_len = sizeof(_regs);				\
+		ptrace(PTRACE_SETREGSET, tracee, NT_PRSTATUS, &__v);	\
+	})
 #endif
 
 /* Architecture-specific syscall fetching routine. */
 int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 {
 	ARCH_REGS regs;
-#ifdef ARCH_GETREGS
-	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
-		return -1;
-	}
-#else
-	struct iovec iov;
 
-	iov.iov_base = &regs;
-	iov.iov_len = sizeof(regs);
-	EXPECT_EQ(0, ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov)) {
-		TH_LOG("PTRACE_GETREGSET failed");
+	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return -1;
 	}
-#endif
 
 	return SYSCALL_NUM(regs);
 }
@@ -1857,18 +1860,10 @@ void change_syscall(struct __test_metadata *_metadata,
 		    pid_t tracee, int syscall, int result)
 {
 	ARCH_REGS regs;
-#ifdef ARCH_GETREGS
+
 	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return;
 	}
-#else
-	int ret;
-	struct iovec iov;
-	iov.iov_base = &regs;
-	iov.iov_len = sizeof(regs);
-	ret = ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov);
-	EXPECT_EQ(0, ret);
-#endif
 
 	SYSCALL_NUM_SET(regs, syscall);
 
@@ -1881,14 +1876,7 @@ void change_syscall(struct __test_metadata *_metadata,
 #endif
 
 	/* Flush any register changes made. */
-#ifdef ARCH_SETREGS
 	EXPECT_EQ(0, ARCH_SETREGS(regs));
-#else
-	iov.iov_base = &regs;
-	iov.iov_len = sizeof(regs);
-	ret = ptrace(PTRACE_SETREGSET, tracee, NT_PRSTATUS, &iov);
-	EXPECT_EQ(0, ret);
-#endif
 }
 
 void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
-- 
2.25.1

