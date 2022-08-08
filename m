Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9838758CA44
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiHHOQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbiHHOPn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 10:15:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9337CDA
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 07:15:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so7907340pjm.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Aug 2022 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pG2ctVJXo4i6wIZyM4i+Ghh/SkIZeHnSqWmH/J73kw8=;
        b=i8sQzDFJxieaZCTqiKpLCFMcNqzUHDOyA/vmoIry52AIjdnuvgIIIOvvlCNhnNfatA
         L1UnXotKwRIMEQzg6nZV63Dn1djXASTnou8zHkDWnS01Ibt2jCOdOLjtqGVpWL7DIkNM
         ncU1jmQd8cVh7R9WNPQDd+U+8tdk8VGTrpqL3HEtWHWQJPaK5b6drxtryK50bglJzZyt
         3lGqKOcUKvtuWm66RlMLRgnDs7eLeSbKOU9rOedrsIGeIUiysmF33pylYH3rmlQ2ILt4
         ObvJHyQdSVOWOECriVn3XpPYy4tca/mfeWFYLnvV4zuV/qK7JtuHDvJmAc5ZAQjaIFEZ
         NQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pG2ctVJXo4i6wIZyM4i+Ghh/SkIZeHnSqWmH/J73kw8=;
        b=Yn/ZGETAgrPqf5TOtu7ziX3p6Lrk4mFoteKWgZ+sVESuiXu9c9ZMG+lWnGiTE1rSoO
         ZsHGrVSBGDFD2mcb32GNqRsJ7Q8QPaJy0dSCfKzjTG7dt3GJimwTuyhegO0mwRtic4JB
         S18f+4nVoIaOlc1HbAdZGeo7LvdgWeM/rOz8QIsAZO2D/bmpZmr3loc4DrQleN8eA/pq
         OhHVJLehNiTQLTZUWWVzj1/DgceS53/Xc00OkPSxBbYHy+IuaUg11NElVl68rGiStJEU
         PTZxZDQc03e0ji3C3Ko6a40E1NetCVeVaOt6PwOjJDheahWtiOBYp+54/oLek+bi5jgW
         9Xvw==
X-Gm-Message-State: ACgBeo3KWlL8cUpKgNQzYLuYTETAdu6spvFwcY5ONwxZSRrpulTtVrli
        DRHVDbh70p0LDugyk0WQ8LU3ug==
X-Google-Smtp-Source: AA6agR6OFDGCCYGm5yHn9DjQ4qQFexr/TGf+qoDuw2FHA1wa/C5koEX7nKBtA8GC21ShSl8MJjDlNQ==
X-Received: by 2002:a17:902:f688:b0:16f:28:ea27 with SMTP id l8-20020a170902f68800b0016f0028ea27mr18424504plg.151.1659968142316;
        Mon, 08 Aug 2022 07:15:42 -0700 (PDT)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b0016eede528b4sm8967357plg.61.2022.08.08.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:15:42 -0700 (PDT)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>,
        Kyle Huey <me@kylehuey.com>
Subject: [PATCH v5 2/2] selftests/vm/pkeys: Add a regression test for setting PKRU through ptrace
Date:   Mon,  8 Aug 2022 07:15:38 -0700
Message-Id: <20220808141538.102394-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808141538.102394-1-khuey@kylehuey.com>
References: <20220808141538.102394-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kyle Huey <me@kylehuey.com>

This tests PTRACE_SETREGSET with NT_X86_XSTATE modifying PKRU directly and
removing the PKRU bit from XSTATE_BV.

Signed-off-by: Kyle Huey <me@kylehuey.com>
---
 tools/testing/selftests/vm/pkey-x86.h        |  12 ++
 tools/testing/selftests/vm/protection_keys.c | 131 ++++++++++++++++++-
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index b078ce9c6d2a..72c14cd3ddc7 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -104,6 +104,18 @@ static inline int cpu_has_pkeys(void)
 	return 1;
 }
 
+static inline int cpu_max_xsave_size(void)
+{
+	unsigned long XSTATE_CPUID = 0xd;
+	unsigned int eax;
+	unsigned int ebx;
+	unsigned int ecx;
+	unsigned int edx;
+
+	__cpuid_count(XSTATE_CPUID, 0, eax, ebx, ecx, edx);
+	return ecx;
+}
+
 static inline u32 pkey_bit_position(int pkey)
 {
 	return pkey * PKEY_BITS_PER_PKEY;
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 291bc1e07842..95f403a0c46d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -18,12 +18,13 @@
  *	do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
  *
  * Compile like this:
- *	gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
- *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
+ *	gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
+ *	gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
  */
 #define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__
 #include <errno.h>
+#include <linux/elf.h>
 #include <linux/futex.h>
 #include <time.h>
 #include <sys/time.h>
@@ -1550,6 +1551,129 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
 }
 
+#if defined(__i386__) || defined(__x86_64__)
+void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+{
+	u32 new_pkru;
+	pid_t child;
+	int status, ret;
+	int pkey_offset = pkey_reg_xstate_offset();
+	size_t xsave_size = cpu_max_xsave_size();
+	void *xsave;
+	u32 *pkey_register;
+	u64 *xstate_bv;
+	struct iovec iov;
+
+	new_pkru = ~read_pkey_reg();
+	/* Don't make PROT_EXEC mappings inaccessible */
+	new_pkru &= ~3;
+
+	child = fork();
+	pkey_assert(child >= 0);
+	dprintf3("[%d] fork() ret: %d\n", getpid(), child);
+	if (!child) {
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		/* Stop and allow the tracer to modify PKRU directly */
+		raise(SIGSTOP);
+
+		/*
+		 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
+		 * checking
+		 */
+		if (__read_pkey_reg() != new_pkru)
+			exit(1);
+
+		/* Stop and allow the tracer to clear XSTATE_BV for PKRU */
+		raise(SIGSTOP);
+
+		if (__read_pkey_reg() != 0)
+			exit(1);
+
+		/* Stop and allow the tracer to examine PKRU */
+		raise(SIGSTOP);
+
+		exit(0);
+	}
+
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	xsave = (void *)malloc(xsave_size);
+	pkey_assert(xsave > 0);
+
+	/* Modify the PKRU register directly */
+	iov.iov_base = xsave;
+	iov.iov_len = xsave_size;
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	pkey_register = (u32 *)(xsave + pkey_offset);
+	pkey_assert(*pkey_register == read_pkey_reg());
+
+	*pkey_register = new_pkru;
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	/* Test that the modification is visible in ptrace before any execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == new_pkru);
+
+	/* Execute the tracee */
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
+	/* Test that the tracee saw the PKRU value change */
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	/* Test that the modification is visible in ptrace after execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == new_pkru);
+
+	/* Clear the PKRU bit from XSTATE_BV */
+	xstate_bv = (u64 *)(xsave + 512);
+	*xstate_bv &= ~(1 << 9);
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	/* Test that the modification is visible in ptrace before any execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == 0);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
+	/* Test that the tracee saw the PKRU value go to 0 */
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	/* Test that the modification is visible in ptrace after execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == 0);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFEXITED(status));
+	pkey_assert(WEXITSTATUS(status) == 0);
+	free(xsave);
+}
+#endif
+
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
@@ -1585,6 +1709,9 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
 	test_pkey_alloc_free_attach_pkey0,
+#if defined(__i386__) || defined(__x86_64__)
+	test_ptrace_modifies_pkru,
+#endif
 };
 
 void run_tests_once(void)
-- 
2.37.1

