Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34598708D3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjESBTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjESBTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 21:19:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792310C6
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-530638a60e1so2470913a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684459171; x=1687051171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzO3EawE44DmDL2RDFGxHbI+J47AsuGzE5x/fc5YRSs=;
        b=Xz+5GZCb3fba+tXdlILZoYQkV4SVPHj5Vwq3DIRmzGvX64eYAzu0JkwUukNwnffs54
         M9v00G5vG3JMYqhRAZSNj3NjdZf+5DSxJMHNq9AQDEWFtawgnIFbemZ5wunbbCOLlxtw
         ghWDWiFb7TtOseQ9yPeyC/EQ4o67LIc0xOhfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459171; x=1687051171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzO3EawE44DmDL2RDFGxHbI+J47AsuGzE5x/fc5YRSs=;
        b=beD2Vzm6RCSRunA/p2yTES4ZsmDZnWDUWpylFkTILziu8RISPd9lyn9CnzQYb8bh/l
         Oatx7vWzYyuAnXiDElI/JZ372k5K/ngxFT4DyuN5o1d87AOlqa1S1bJDmhyX51Jq6lpp
         iH/++Y0ijmZusOyx8KgOTJsPoybrllx84oAfEvxkw9+UIbTP5kQdxAJwN1PSPdrjxXjF
         5zwp8uHrPNFtEvEX6rqNk+Gu4XQRo/V1GzKhTj+ZMzTGokoX7GTI1x+unxJffFsToxEv
         XWB+2u182sqcFoK3Me+463WvC7HIk2KrtBZxbabfZ18VTTVckx3JKWihzjcAPQMD4aeD
         VYTw==
X-Gm-Message-State: AC+VfDw7UOPUzxytwx4APF7kz+c661WgikYx9+4OTAaiPPo9DxF3Ce7U
        m37JjAadsTXCy6wZwLewCiJRew==
X-Google-Smtp-Source: ACHHUZ6Fs6CYowy/agA+FF47C4n9YuZUo/3YX8PaB++LosNzsroEAzIx6Gf688Y9ZcsCjvKb79F0WQ==
X-Received: by 2002:a05:6a20:c18d:b0:102:7aec:6dcc with SMTP id bg13-20020a056a20c18d00b001027aec6dccmr299922pzb.27.1684459170711;
        Thu, 18 May 2023 18:19:30 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id f62-20020a17090a704400b0023d386e4806sm294372pjk.57.2023.05.18.18.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:19:30 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 4/6] PKEY:selftest pkey_enforce_api for mprotect
Date:   Fri, 19 May 2023 01:19:12 +0000
Message-ID: <20230519011915.846407-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
References: <20230519011915.846407-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for pkey_enforce_api for mprotect.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/pkey_enforce_api.c | 875 ++++++++++++++++++
 2 files changed, 876 insertions(+)
 create mode 100644 tools/testing/selftests/mm/pkey_enforce_api.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23af4633f0f4..93437a394128 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -71,6 +71,7 @@ CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_pr
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
 VMTARGETS := protection_keys
+VMTARGETS += pkey_enforce_api
 BINARIES_32 := $(VMTARGETS:%=%_32)
 BINARIES_64 := $(VMTARGETS:%=%_64)
 
diff --git a/tools/testing/selftests/mm/pkey_enforce_api.c b/tools/testing/selftests/mm/pkey_enforce_api.c
new file mode 100644
index 000000000000..23663c89bc9c
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_enforce_api.c
@@ -0,0 +1,875 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests pkey_enforce_api
+ *
+ * Compile like this:
+ * gcc -mxsave      -o pkey_enforce_api    -O2 -g -std=gnu99 -pthread -Wall pkey_enforce_api.c \
+ * -lrt -ldl -lm
+ * gcc -mxsave -m32 -o pkey_enforce_api_32 -O2 -g -std=gnu99 -pthread -Wall pkey_enforce_api.c \
+ * -lrt -ldl -lm
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <linux/elf.h>
+#include <linux/futex.h>
+#include <pthread.h>
+#include <time.h>
+#include <sys/time.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <ucontext.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ptrace.h>
+#include <setjmp.h>
+#include "../kselftest.h"
+#include <sys/prctl.h>
+
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+
+#define dprintf0(args...)
+#define dprintf1(args...)
+#define dprintf2(args...)
+#define dprintf3(args...)
+#define dprintf4(args...)
+
+#ifndef u16
+#define u16 __u16
+#endif
+
+#ifndef u32
+#define u32 __u32
+#endif
+
+#ifndef u64
+#define u64 __u64
+#endif
+
+#ifndef PTR_ERR_ENOTSUP
+#define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
+#endif
+
+int read_ptr(int *ptr)
+{
+	return *ptr;
+}
+
+void expected_pkey_fault(int pkey)
+{
+}
+
+#include "pkey-x86.h"
+
+#ifndef PKEY_ENFORCE_API
+#define PKEY_ENFORCE_API 1
+#endif
+
+#define PKEY_MASK (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+
+#define LOG_TEST_ENTER(x)                                                      \
+	{                                                                      \
+		printf("%s, enforce=%d\n", __func__, x);                       \
+	}
+static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/* mask out bits from pkey in old value */
+	reg &= ~((u64)PKEY_MASK << shift);
+	/* OR in new bits for pkey */
+	reg |= (flags & PKEY_MASK) << shift;
+	return reg;
+}
+
+static inline u64 get_pkey_bits(u64 reg, int pkey)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/*
+	 * shift down the relevant bits to the lowest two, then
+	 * mask off all the other higher bits
+	 */
+	return ((reg >> shift) & PKEY_MASK);
+}
+
+static u32 get_pkey(int pkey)
+{
+	return (u32)get_pkey_bits(__read_pkey_reg(), pkey);
+}
+
+static void set_pkey(int pkey, unsigned long pkey_value)
+{
+	u32 mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
+	u64 new_pkey_reg;
+
+	assert(!(pkey_value & ~mask));
+	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
+	__write_pkey_reg(new_pkey_reg);
+}
+
+void pkey_disable_set(int pkey, int value)
+{
+	int pkey_new;
+
+	assert(value & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	pkey_new = get_pkey(pkey);
+	pkey_new |= value;
+	set_pkey(pkey, pkey_new);
+}
+
+void pkey_disable_clear(int pkey, int value)
+{
+	int pkey_new;
+
+	assert(value & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	pkey_new = get_pkey(pkey);
+	pkey_new &= ~value;
+
+	set_pkey(pkey, pkey_new);
+}
+
+void pkey_write_allow(int pkey)
+{
+	pkey_disable_clear(pkey, PKEY_DISABLE_WRITE);
+}
+void pkey_write_deny(int pkey)
+{
+	pkey_disable_set(pkey, PKEY_DISABLE_WRITE);
+}
+void pkey_access_allow(int pkey)
+{
+	pkey_disable_clear(pkey, PKEY_DISABLE_ACCESS);
+}
+void pkey_access_deny(int pkey)
+{
+	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
+}
+
+int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(SYS_mprotect, ptr, size, prot);
+	return sret;
+}
+
+int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		      unsigned long pkey)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(SYS_mprotect_key, ptr, size, orig_prot, pkey);
+	return sret;
+}
+
+int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
+{
+	int ret = syscall(SYS_pkey_alloc, flags, init_val);
+	return ret;
+}
+
+int sys_pkey_free(unsigned long pkey)
+{
+	int ret = syscall(SYS_pkey_free, pkey);
+	return ret;
+}
+
+bool can_create_pkey(void)
+{
+	int pkey;
+
+	pkey = sys_pkey_alloc(0, 0);
+	if (pkey <= 0)
+		return false;
+
+	sys_pkey_free(pkey);
+	return true;
+}
+
+static inline int is_pkeys_supported(void)
+{
+	/* check if the cpu supports pkeys */
+	if (!cpu_has_pkeys() || !can_create_pkey())
+		return 0;
+	return 1;
+}
+
+int pkey_alloc_with_check(bool enforce)
+{
+	int pkey;
+
+	if (enforce)
+		pkey = sys_pkey_alloc(PKEY_ENFORCE_API, 0);
+	else
+		pkey = sys_pkey_alloc(0, 0);
+
+	assert(pkey > 0);
+	return pkey;
+}
+
+void *addr1 = (void *)0x5000000;
+void *addr2 = (void *)0x5001000;
+void *addr3 = (void *)0x5002000;
+void *addr4 = (void *)0x5003000;
+
+void setup_single_address_with_pkey(bool enforce, int size, int *pkeyOut,
+				    void **ptrOut)
+{
+	int pkey;
+	void *ptr;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+}
+
+void setup_single_fixed_address_with_pkey(bool enforce, int size, int *pkeyOut,
+					  void **ptrOut)
+{
+	int pkey;
+	void *ptr;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(addr1, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr == (void *)addr1);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+}
+
+void clean_single_address_with_pkey(int pkey, void *ptr, int size)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+void setup_two_continues_fixed_address_with_pkey(bool enforce, int size,
+						 int *pkeyOut, void **ptrOut,
+						 void **ptr2Out)
+{
+	void *ptr;
+	void *ptr2;
+	int pkey;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	ptr2 = mmap(addr2, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr2 == addr2);
+
+	// assign pkey to both addresses in the same call (merged)
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	assert(!ret);
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+	*ptr2Out = ptr2;
+}
+
+void clean_two_address_with_pkey(int size, int pkey, void *ptr, void *ptr2)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = munmap(ptr2, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// pkey_alloc with flags.
+void test_pkey_alloc(bool enforce)
+{
+	int ret;
+
+	LOG_TEST_ENTER(enforce);
+
+	ret = sys_pkey_alloc(0, 0);
+	assert(ret > 0);
+	ret = sys_pkey_free(ret);
+	assert(ret == 0);
+
+	if (enforce) {
+		ret = sys_pkey_alloc(PKEY_ENFORCE_API, 0);
+		assert(ret > 0);
+		ret = sys_pkey_free(ret);
+		assert(ret == 0);
+
+		// invalid flag.
+		ret = sys_pkey_alloc(0x4, 0);
+		assert(ret != 0);
+	}
+}
+
+// mmap one address.
+// assign pkey on the address.
+// mprotect is denied when no-writeable PKRU in enforce mode.
+void test_mprotect_single_address(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_single_fixed_address_with_pkey(enforce, size, &pkey, &ptr);
+
+	// disable write access.
+	pkey_write_deny(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ | PROT_WRITE, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(ret == 0);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	assert(ret == 0);
+
+	clean_single_address_with_pkey(pkey, ptr, size);
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to them with one mprotect_pkey call (merged address).
+// mprotect is denied when non-writeable PKRU in enforce mode.
+void test_mprotect_two_address_merge(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_with_pkey(enforce, size, &pkey, &ptr,
+						    &ptr2);
+
+	// disable write.
+	pkey_write_deny(pkey);
+
+	// modify the protection on both addresses (merged).
+	ret = sys_mprotect(ptr, size * 2, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	// modify the protection on both addresses (merged).
+	ret = sys_mprotect(ptr, size * 2, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	assert(!ret);
+
+	clean_two_address_with_pkey(size, pkey, ptr, ptr2);
+}
+
+void setup_two_continues_fixed_address_protect_second_with_pkey(
+	bool enforce, int size, int *pkeyOut, void **ptrOut, void **ptr2Out)
+{
+	void *ptr;
+	void *ptr2;
+	int pkey;
+	int ret;
+
+	LOG_TEST_ENTER(enforce);
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	// mmap two addresses (continuous two pages).
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	ptr2 = mmap(addr2, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr2 == addr2);
+
+	// assign pkey to the second page.
+	ret = sys_mprotect_pkey(addr2, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+				pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+	*ptr2Out = ptr2;
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to the second address.
+// mprotect on the second address is denied properly.
+// mprotect on both addresses (merged) is denied properly.
+void test_mprotect_two_address_deny_second(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_protect_second_with_pkey(
+		enforce, size, &pkey, &ptr, &ptr2);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify the first addr is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify the second mmap is protected by pkey.
+	ret = sys_mprotect(ptr2, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	// mprotect both addresses (merged).
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size * 2, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size * 2, PROT_READ, pkey);
+	assert(!ret);
+
+	ret = sys_mprotect(ptr, size * 2, PROT_READ);
+	assert(!ret);
+
+	clean_two_address_with_pkey(size, pkey, ptr, ptr2);
+}
+
+void setup_4pages_fixed_protect_second_page(bool enforce, int size,
+					    int *pkeyOut, void **ptrOut,
+					    void **ptr2Out, void **ptr3Out)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	// allocate 4 pages.
+	ptr = mmap(addr1, size * 4, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	// assign pkey to the second address.
+	ret = sys_mprotect_pkey(addr2, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+				pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+	*ptr2Out = addr2;
+	*ptr3Out = addr3;
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// mprotect on the first page is allowed.
+// mprotect on the second page is protected in enforce mode.
+// mprotect on memory range that includes the second pages is protected.
+void test_mprotect_vma_middle_addr(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify to the first page is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the third page is allowed.
+	ret = sys_mprotect(ptr3, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the second page is protected by pkey.
+	ret = sys_mprotect(ptr2, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	// modify to memory range that includes the second page is protected.
+	ret = sys_mprotect_pkey(ptr, size * 4,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size * 4, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect(addr2, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	ret = sys_mprotect_pkey(ptr, size * 4,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	assert(!ret);
+
+	clean_single_address_with_pkey(pkey, ptr, size * 4);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// mprotect on the second page, but size is unaligned.
+void test_mprotect_unaligned(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify to the first page is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the second page is protected by pkey.
+	ret = sys_mprotect(ptr2, size - 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect(addr2, size - 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	clean_single_address_with_pkey(pkey, ptr, size * 4);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// mprotect on the second page, but size is unaligned.
+void test_mprotect_unaligned2(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify to the first page is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the second page is protected by pkey.
+	ret = sys_mprotect(ptr2, size + 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect(addr2, size + 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	clean_single_address_with_pkey(pkey, ptr, size * 4);
+}
+
+void setup_address_with_gap_two_pkeys(bool enforce, int size, int *pkeyOut,
+				      int *pkey2Out, void **ptrOut,
+				      void **ptr2Out)
+{
+	int pkey, pkey2;
+	void *ptr, *ptr2;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+	pkey2 = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == (void *)addr1);
+
+	ptr2 = mmap(addr3, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr2 == (void *)addr3);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr2, size, PROT_READ, pkey2);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+
+	*pkey2Out = pkey2;
+	*ptr2Out = ptr2;
+}
+
+void clean_address_with_pag_two_pkeys(int pkey, void *ptr, int pkey2,
+				      void *ptr2, int size)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+
+	ret = munmap(ptr2, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey2);
+	assert(ret == 0);
+}
+
+// mmap two addresses, with a page gap between two.
+// assign pkeys on both address.
+// disable access to the second address.
+// mprotect from start of address1 to the end of address 2,
+// because there is a gap in the memory range, mprotect will fail.
+void test_mprotect_gapped_address_with_two_pkeys(bool enforce)
+{
+	int pkey, pkey2;
+	int ret;
+	void *ptr, *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_address_with_gap_two_pkeys(enforce, size, &pkey, &pkey2, &ptr,
+					 &ptr2);
+
+	// disable write access.
+	pkey_write_deny(pkey2);
+
+	ret = sys_mprotect_pkey(ptr, size * 3, PROT_READ | PROT_WRITE, pkey);
+	assert(ret < 0);
+
+	ret = sys_mprotect(ptr, size * 3, PROT_READ | PROT_WRITE);
+	assert(ret < 0);
+
+	pkey_write_allow(pkey2);
+
+	ret = sys_mprotect_pkey(ptr, size * 3, PROT_READ, pkey);
+	assert(ret < 0);
+
+	ret = sys_mprotect(ptr, size * 3, PROT_READ);
+	assert(ret < 0);
+
+	clean_address_with_pag_two_pkeys(pkey, ptr, pkey2, ptr2, size);
+}
+
+struct thread_info {
+	int pkey;
+	void *addr;
+	int size;
+	bool enforce;
+};
+
+void *thread_mprotect(void *arg)
+{
+	struct thread_info *tinfo = arg;
+	void *ptr = tinfo->addr;
+	int size = tinfo->size;
+	bool enforce = tinfo->enforce;
+	int pkey = tinfo->pkey;
+	int ret;
+
+	// disable write access.
+	pkey_write_deny(pkey);
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ | PROT_WRITE, pkey);
+
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(ret == 0);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	assert(ret == 0);
+	return NULL;
+}
+
+// mmap one address.
+// assign pkey on the address.
+// in child thread, mprotect is denied when no-writeable PKRU in enforce mode.
+void test_mprotect_child_thread(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+	pthread_t thread;
+	struct thread_info tinfo;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_single_fixed_address_with_pkey(enforce, size, &pkey, &ptr);
+	tinfo.size = size;
+	tinfo.addr = ptr;
+	tinfo.enforce = enforce;
+	tinfo.pkey = pkey;
+
+	ret = pthread_create(&thread, NULL, thread_mprotect, (void *)&tinfo);
+	assert(ret == 0);
+	pthread_join(thread, NULL);
+
+	clean_single_address_with_pkey(pkey, ptr, size);
+}
+
+void test_enforce_api(void)
+{
+	for (int i = 0; i < 2; i++) {
+		bool enforce = (i == 1);
+
+		test_pkey_alloc(enforce);
+
+		test_mprotect_single_address(enforce);
+		test_mprotect_two_address_merge(enforce);
+		test_mprotect_two_address_deny_second(enforce);
+		test_mprotect_vma_middle_addr(enforce);
+		test_mprotect_unaligned(enforce);
+		test_mprotect_unaligned2(enforce);
+		test_mprotect_child_thread(enforce);
+		test_mprotect_gapped_address_with_two_pkeys(enforce);
+	}
+}
+
+int main(void)
+{
+	int pkeys_supported = is_pkeys_supported();
+
+	printf("pid: %d\n", getpid());
+	printf("has pkeys: %d\n", pkeys_supported);
+	if (!pkeys_supported) {
+		printf("PKEY not supported, skip the test.\n");
+		exit(0);
+	}
+
+	test_enforce_api();
+	printf("done (all tests OK)\n");
+	return 0;
+}
+#else /* arch */
+int main(void)
+{
+	printf("SKIP: not supported arch\n");
+	return 0;
+}
+#endif /* arch */
-- 
2.40.1.606.ga4b1b128d6-goog

