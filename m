Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF89270BAC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Sep 2020 10:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgISIGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Sep 2020 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgISIGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Sep 2020 04:06:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45636C0613CF
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k133so96915pgc.7
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35YzUlNbVtiet2PZ45LS5yY7R0/2AJJr6WQjB9kb9DQ=;
        b=NPIiKYArpLnpWfZp2HXxYn+rhNR6sHO84+EVXiHS/T9DNxwqVpJsTgJu6e6UOqIac5
         bDkvvguK356n60RctscGCaXQ5NOApiENU+nr9wKDX2+G6Dwk6/Kt2ohTlILyR4XhG7Vd
         EmOtzDVI6LSIRYyfxPFLa8F7JELTXGEK7gbOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35YzUlNbVtiet2PZ45LS5yY7R0/2AJJr6WQjB9kb9DQ=;
        b=AZ0ZrNrsDKYi+ITiAbam6UixSiiox3d/O/vDdtM28SMlPoVAH2hN+XP6jPmyfHyxkx
         pzufSfWuAnM/pKT7qS+gVI1O+9XrmLhsjIcvSwq7u/GO4In8kvv83KuZ57PAjPP/4AqG
         5Jv7udPe1vDC5ywXOPd6nUyRQbS7I3zlZTbwNemXBhEyj3CXN040RtA33+IugQfBOibf
         F/rilZ9yquaiWo15i6ffydG/oz8NEzD4FWQL/SHPiBFAUL2iEFgY+pu2CwuW59SBygmM
         7YE68eI8qeEnKE3Mvmg8+vzVo16XxOeHFi5QLrXM8C3L9PRM1E7aI4LsuBDtHzvXHBdC
         SK7A==
X-Gm-Message-State: AOAM531ylP63bDAzd1vWIlI6ULeOznN2LlLjUHMk0caX/8b/yD49LLdw
        WkQkOMbj8VS5D4LeixOUDT24Jw==
X-Google-Smtp-Source: ABdhPJyNRXL2Utm2uMp6p2aTrp/bIX0uxScQD/cHSmnwCqXqPd9T4QRySA1oqwyg3Lqotd99libtWg==
X-Received: by 2002:a65:6449:: with SMTP id s9mr21340653pgv.388.1600502806814;
        Sat, 19 Sep 2020 01:06:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e27sm5744480pfj.62.2020.09.19.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:06:45 -0700 (PDT)
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
Subject: [PATCH v2 3/4] selftests/seccomp: powerpc: Set syscall return during ptrace syscall exit
Date:   Sat, 19 Sep 2020 01:06:36 -0700
Message-Id: <20200919080637.259478-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200919080637.259478-1-keescook@chromium.org>
References: <20200919080637.259478-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some archs (like powerpc) only support changing the return code during
syscall exit when ptrace is used. Test entry vs exit phases for which
portions of the syscall number and return values need to be set at which
different phases. For non-powerpc, all changes are made during ptrace
syscall entry, as before. For powerpc, the syscall number is changed at
ptrace syscall entry and the syscall return value is changed on ptrace
syscall exit.

Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
Fixes: 58d0a862f573 ("seccomp: add tests for ptrace hole")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 98ce5e8a6398..894c2404d321 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1765,6 +1765,7 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 			(_regs).ccr &= ~0x10000000;		\
 		}						\
 	} while (0)
+# define SYSCALL_RET_SET_ON_PTRACE_EXIT
 #elif defined(__s390__)
 # define ARCH_REGS		s390_regs
 # define SYSCALL_NUM(_regs)	(_regs).gprs[2]
@@ -1853,6 +1854,18 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 	} while (0)
 #endif
 
+/*
+ * Some architectures (e.g. powerpc) can only set syscall
+ * return values on syscall exit during ptrace.
+ */
+const bool ptrace_entry_set_syscall_nr = true;
+const bool ptrace_entry_set_syscall_ret =
+#ifndef SYSCALL_RET_SET_ON_PTRACE_EXIT
+	true;
+#else
+	false;
+#endif
+
 /*
  * Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
  * architectures without HAVE_ARCH_TRACEHOOK (e.g. User-mode Linux).
@@ -2006,11 +2019,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	 */
 	if (entry)
 		self->syscall_nr = get_syscall(_metadata, tracee);
-	else
-		return;
 
-	syscall_nr = &syscall_nr_val;
-	syscall_ret = &syscall_ret_val;
+	/*
+	 * Depending on the architecture's syscall setting abilities, we
+	 * pick which things to set during this phase (entry or exit).
+	 */
+	if (entry == ptrace_entry_set_syscall_nr)
+		syscall_nr = &syscall_nr_val;
+	if (entry == ptrace_entry_set_syscall_ret)
+		syscall_ret = &syscall_ret_val;
 
 	/* Now handle the actual rewriting cases. */
 	switch (self->syscall_nr) {
-- 
2.25.1

