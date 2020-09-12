Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E872679DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgILLLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgILLIs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:08:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC09C0617A1
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so8185361pgd.12
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1U82n+b6P1wGMlr0n/lm8DqFMBKpyd7dLyrkvRpbNk=;
        b=Qf2k8aw+QpxPUC+okglry6q3bVbH3jKZsyuLzav4/0cOGrbWLhJCSFaj1PEq6tcYip
         cuLmT6KIbM3WOoZcf0/LFo4j2n7CM514U3FYPw2+tttxkQZAULy8Rm5GeDsNU+3BKVoc
         NRHsw3rDvlbw+As6Aw0BRlGiWP+5YqgU+1uN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1U82n+b6P1wGMlr0n/lm8DqFMBKpyd7dLyrkvRpbNk=;
        b=aDcJe28eRyiEuGSA/CFOSlX0Q9dvbMlTNjElFQtd4cf8wGXb13HaICPw/tdHxuOp8c
         +qT/5OHa+wnb6lpQRVfvQiY/q2ehOKyHb0Tc/hfZcg5pd7MB/0H3ajP5sjjskJNrMbgq
         oZmFDIBCmj9vZ3NyQlI6iUFUzY+y0aHGRDy/l2NDlCYpk/BZDqc3FOFro7jAaot7attY
         CFXOtajv09c6gLujtaC6lsfx2kLMC2ynapDQbggTuTm8J0FeVkkQMv9MN1La0aVBplPV
         8wKXyx7IygAoDlNfwNS/wZEnEoVEAm4vJJ564swFpGEgeJCg0TgHxq+ORb6tPh6meDj3
         CzAA==
X-Gm-Message-State: AOAM532K0YmaEGUJ22Gkpj4FcrCMlKn2VQdQ9LlsA3zViDysVourBVG+
        MbxiYqijWUkadd9cXZEN3KVG5Q==
X-Google-Smtp-Source: ABdhPJyIeKXZzrcW8QXXXcIxMUHiRH2LjdHzWxFK1aSkuh5GSRlfE14+bSH/SUUsXgpGMgWZ3MHufQ==
X-Received: by 2002:a62:8011:: with SMTP id j17mr5948038pfd.98.1599908906421;
        Sat, 12 Sep 2020 04:08:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm4788707pfg.83.2020.09.12.04.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:23 -0700 (PDT)
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
Subject: [PATCH 01/15] selftests/seccomp: Refactor arch register macros to avoid xtensa special case
Date:   Sat, 12 Sep 2020 04:08:06 -0700
Message-Id: <20200912110820.597135-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid an xtensa special-case, refactor all arch register macros to
take the register variable instead of depending on the macro expanding
as a struct member name.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++----------
 1 file changed, 47 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c5002fc25b00..fef15080b575 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1698,64 +1698,64 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 }
 
 #if defined(__x86_64__)
-# define ARCH_REGS	struct user_regs_struct
-# define SYSCALL_NUM	orig_rax
-# define SYSCALL_RET	rax
+# define ARCH_REGS		struct user_regs_struct
+# define SYSCALL_NUM(_regs)	(_regs).orig_rax
+# define SYSCALL_RET(_regs)	(_regs).rax
 #elif defined(__i386__)
-# define ARCH_REGS	struct user_regs_struct
-# define SYSCALL_NUM	orig_eax
-# define SYSCALL_RET	eax
+# define ARCH_REGS		struct user_regs_struct
+# define SYSCALL_NUM(_regs)	(_regs).orig_eax
+# define SYSCALL_RET(_regs)	(_regs).eax
 #elif defined(__arm__)
-# define ARCH_REGS	struct pt_regs
-# define SYSCALL_NUM	ARM_r7
-# define SYSCALL_RET	ARM_r0
+# define ARCH_REGS		struct pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).ARM_r7
+# define SYSCALL_RET(_regs)	(_regs).ARM_r0
 #elif defined(__aarch64__)
-# define ARCH_REGS	struct user_pt_regs
-# define SYSCALL_NUM	regs[8]
-# define SYSCALL_RET	regs[0]
+# define ARCH_REGS		struct user_pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).regs[8]
+# define SYSCALL_RET(_regs)	(_regs).regs[0]
 #elif defined(__riscv) && __riscv_xlen == 64
-# define ARCH_REGS	struct user_regs_struct
-# define SYSCALL_NUM	a7
-# define SYSCALL_RET	a0
+# define ARCH_REGS		struct user_regs_struct
+# define SYSCALL_NUM(_regs)	(_regs).a7
+# define SYSCALL_RET(_regs)	(_regs).a0
 #elif defined(__csky__)
-# define ARCH_REGS	struct pt_regs
-#if defined(__CSKYABIV2__)
-# define SYSCALL_NUM	regs[3]
-#else
-# define SYSCALL_NUM	regs[9]
-#endif
-# define SYSCALL_RET	a0
+# define ARCH_REGS		struct pt_regs
+#  if defined(__CSKYABIV2__)
+#   define SYSCALL_NUM(_regs)	(_regs).regs[3]
+#  else
+#   define SYSCALL_NUM(_regs)	(_regs).regs[9]
+#  endif
+# define SYSCALL_RET(_regs)	(_regs).a0
 #elif defined(__hppa__)
-# define ARCH_REGS	struct user_regs_struct
-# define SYSCALL_NUM	gr[20]
-# define SYSCALL_RET	gr[28]
+# define ARCH_REGS		struct user_regs_struct
+# define SYSCALL_NUM(_regs)	(_regs).gr[20]
+# define SYSCALL_RET(_regs)	(_regs).gr[28]
 #elif defined(__powerpc__)
-# define ARCH_REGS	struct pt_regs
-# define SYSCALL_NUM	gpr[0]
-# define SYSCALL_RET	gpr[3]
+# define ARCH_REGS		struct pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).gpr[0]
+# define SYSCALL_RET(_regs)	(_regs).gpr[3]
 #elif defined(__s390__)
-# define ARCH_REGS     s390_regs
-# define SYSCALL_NUM   gprs[2]
-# define SYSCALL_RET   gprs[2]
+# define ARCH_REGS		s390_regs
+# define SYSCALL_NUM(_regs)	(_regs).gprs[2]
+# define SYSCALL_RET(_regs)	(_regs).gprs[2]
 # define SYSCALL_NUM_RET_SHARE_REG
 #elif defined(__mips__)
-# define ARCH_REGS	struct pt_regs
-# define SYSCALL_NUM	regs[2]
-# define SYSCALL_SYSCALL_NUM regs[4]
-# define SYSCALL_RET	regs[2]
+# define ARCH_REGS		struct pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).regs[2]
+# define SYSCALL_SYSCALL_NUM	regs[4]
+# define SYSCALL_RET(_regs)	(_regs).regs[2]
 # define SYSCALL_NUM_RET_SHARE_REG
 #elif defined(__xtensa__)
-# define ARCH_REGS	struct user_pt_regs
-# define SYSCALL_NUM	syscall
+# define ARCH_REGS		struct user_pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).syscall
 /*
  * On xtensa syscall return value is in the register
  * a2 of the current window which is not fixed.
  */
-#define SYSCALL_RET(reg) a[(reg).windowbase * 4 + 2]
+#define SYSCALL_RET(_regs)	(_regs).a[(_regs).windowbase * 4 + 2]
 #elif defined(__sh__)
-# define ARCH_REGS	struct pt_regs
-# define SYSCALL_NUM	gpr[3]
-# define SYSCALL_RET	gpr[0]
+# define ARCH_REGS		struct pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).gpr[3]
+# define SYSCALL_RET(_regs)	(_regs).gpr[0]
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
@@ -1804,10 +1804,10 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 #endif
 
 #if defined(__mips__)
-	if (regs.SYSCALL_NUM == __NR_O32_Linux)
+	if (SYSCALL_NUM(regs) == __NR_O32_Linux)
 		return regs.SYSCALL_SYSCALL_NUM;
 #endif
-	return regs.SYSCALL_NUM;
+	return SYSCALL_NUM(regs);
 }
 
 /* Architecture-specific syscall changing routine. */
@@ -1830,14 +1830,14 @@ void change_syscall(struct __test_metadata *_metadata,
 	defined(__s390__) || defined(__hppa__) || defined(__riscv) || \
 	defined(__xtensa__) || defined(__csky__) || defined(__sh__)
 	{
-		regs.SYSCALL_NUM = syscall;
+		SYSCALL_NUM(regs) = syscall;
 	}
 #elif defined(__mips__)
 	{
-		if (regs.SYSCALL_NUM == __NR_O32_Linux)
+		if (SYSCALL_NUM(regs) == __NR_O32_Linux)
 			regs.SYSCALL_SYSCALL_NUM = syscall;
 		else
-			regs.SYSCALL_NUM = syscall;
+			SYSCALL_NUM(regs) = syscall;
 	}
 
 #elif defined(__arm__)
@@ -1871,11 +1871,8 @@ void change_syscall(struct __test_metadata *_metadata,
 	if (syscall == -1)
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
-
-#elif defined(__xtensa__)
-		regs.SYSCALL_RET(regs) = result;
 #else
-		regs.SYSCALL_RET = result;
+		SYSCALL_RET(regs) = result;
 #endif
 
 #ifdef HAVE_GETREGS
-- 
2.25.1

