Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5922E58B293
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 01:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiHEXCG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbiHEXCF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 19:02:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C95FAD1
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 16:02:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so3422395pfb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nFYDqdYlKjDN/X9hygUy8BrADildhN55ltpacqhkjvk=;
        b=Ub3SJjm4lKtLgOBKlk6F0NN6b1z1p0/7UOM205dCDKd00WpkwlCyMquyC48vh26HIN
         AVj+rJuIZ/MSzJYPOHfeasr/8Ptjd9hcbaG7mCh4CcKVIV6KGlLp4LMDfRQLpK0V2uFI
         sa6gu0npzlMwUn4NaoewDvikeJhWC4WItKEoeY1ka87GBAp0Pggs5I83tZDz3A183AP0
         bry8r1oFq0y9dkh7Fnnv9EjGJyJUw8dBejX7HxmYZFF7oFUqAk68mv8/sjxcCYCkeucJ
         6KImTMRFEdsmYxb1zT2bEAwb4/oO3nsdvGQYoLB3JZ5jI2Pnz6Zf+4/wNEfb3aGzP6pY
         1QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nFYDqdYlKjDN/X9hygUy8BrADildhN55ltpacqhkjvk=;
        b=C8jJY1jZJjxRSjnxaOk3Kw/THqUSFbHNeqj/0O2DFBrfMouQDirlqTUCwEo1zvszkI
         ZE22x8FgCYws8hLcKMaYX0tyj22VT/QoeqzKQ7uzmEvjU13ekdXMwfbLAyRKeSQMvMPN
         DTp48wv3US7+DWqgsBAeZ1lFfUq9Ut7KXTAOwOdISmHWuG2VRmWAo5LMD3sD1CZDg7Pi
         bSFgNfZL4BJ0ijrO6XL0NC/8dcfzpGFBpWYq/uozJvnsUb3qTB3gEd7JZkULc3YlCkas
         OSmPfbRseDHoApAEta0Wtu0V6AZv3fsh0rLV6pNK/sZ/1DedRd6kKOERUBYG6/3xCqn1
         YibQ==
X-Gm-Message-State: ACgBeo0XVqz/gf5roBDCSxpJ42q2nBEw/BArkrhPVL8O5sOTKhkuZQ4S
        0d+UvFEQ54TIwKx0zO0KDoYgOg==
X-Google-Smtp-Source: AA6agR4bTfP1/w3A+DEkFJCGOJfEqaQeFteArUJJ+Jh14QBa7OAVShI1FIYTgY0tQSaGOH4Gxk7IoQ==
X-Received: by 2002:a05:6a00:1248:b0:52b:ca7:f2b6 with SMTP id u8-20020a056a00124800b0052b0ca7f2b6mr8878508pfi.82.1659740522715;
        Fri, 05 Aug 2022 16:02:02 -0700 (PDT)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id g18-20020a635652000000b0041af82dacf7sm1958702pgm.73.2022.08.05.16.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 16:02:02 -0700 (PDT)
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
Subject: [PATCH v4 2/2] selftests/vm/pkeys: Add a regression test for setting PKRU through ptrace
Date:   Fri,  5 Aug 2022 16:01:58 -0700
Message-Id: <20220805230158.39378-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805230158.39378-1-khuey@kylehuey.com>
References: <20220805230158.39378-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 tools/testing/selftests/vm/pkey-x86.h        | 12 +++
 tools/testing/selftests/vm/protection_keys.c | 88 +++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

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
index 291bc1e07842..27759d3ed9cd 100644
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
@@ -1550,6 +1551,86 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
 }
 
+#if defined(__i386__) || defined(__x86_64__)
+void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+{
+	pid_t child;
+	int status, ret;
+	int pkey_offset = pkey_reg_xstate_offset();
+	size_t xsave_size = cpu_max_xsave_size();
+	void *xsave;
+	u32 *pkey_register;
+	u64 *xstate_bv;
+	struct iovec iov;
+
+	child = fork();
+	pkey_assert(child >= 0);
+	dprintf3("[%d] fork() ret: %d\n", getpid(), child);
+	if (!child) {
+		u32 pkey_register = read_pkey_reg();
+
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		raise(SIGSTOP);
+
+		/*
+		 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
+		 * checking
+		 */
+		if (pkey_register == __read_pkey_reg())
+			exit(1);
+
+		raise(SIGSTOP);
+
+		exit(__read_pkey_reg());
+	}
+
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	xsave = (void *)malloc(xsave_size);
+	pkey_assert(xsave > 0);
+
+	iov.iov_base = xsave;
+	iov.iov_len = xsave_size;
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	pkey_register = (u32 *)(xsave + pkey_offset);
+	pkey_assert(*pkey_register == read_pkey_reg());
+
+	*pkey_register = !read_pkey_reg();
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	xstate_bv = (u64 *)(xsave + 512);
+	*xstate_bv &= ~(1 << 9);
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
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
@@ -1585,6 +1666,9 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
 	test_pkey_alloc_free_attach_pkey0,
+#if defined(__i386__) || defined(__x86_64__)
+	test_ptrace_modifies_pkru,
+#endif
 };
 
 void run_tests_once(void)
-- 
2.37.0

