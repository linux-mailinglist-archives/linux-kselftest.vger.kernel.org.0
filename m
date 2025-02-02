Return-Path: <linux-kselftest+bounces-25525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D037A24FC8
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 20:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE35D18834EB
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523521FE44D;
	Sun,  2 Feb 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyPqvu97"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE5635;
	Sun,  2 Feb 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738524263; cv=none; b=JNxYPs/1Ow8IAS0FlpJraUeNt0bee081xS6/dL7W1103jDB6zfc0Lx0HIFcrD4qBT4ntQ8632FU+wJ//wDoMbfzOlfs4iHXy+U/JKSwKrB1R7/jbiCUp+VFdZpR0zeRNg8sDZgR3CLFLmz9tZMqUV35ALMDZdT+FKGmfXGvRRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738524263; c=relaxed/simple;
	bh=S+LZO6dATwza2HFHbHznlTKSBzQVwoyyzs1DMM8oUGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Cj139IGi6yoENC7iZUfRnXwj9R1lEzE1AtGJ1bB8grbPQ0tvULr5OBJqw6ZSa0CoI7CFXLxopWR6//IsiNz86AScOX6RvFpRvydBoSsJex3AxrDEzvT+A3PLTi+EA4oilmMRLozGdhIeXd950Mu0W9o74/+DbBruFjnYYqSoD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyPqvu97; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso22303395e9.1;
        Sun, 02 Feb 2025 11:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738524259; x=1739129059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ehGfOirhIOOasnif+JzQLELzhF9wvvAgIlZXMirXfFY=;
        b=kyPqvu97HnnjS6n57G3UpxU4Z+71hLGZigURRKljp5p+rbAT1P4vxYBs1t3pB8wmlI
         D3+lEmAuSXr2pdFl3/fOZqsVWCdLcpxiomuG/Zq7FfW7uQZBUjcfg3bsVjSW8jVaiJAS
         d3b38a4Jy8GjffA0aoXazO0w6VEaEs5S0/AVeOqIoxb6ThJs8Sn4qpsQQVGnn7I1CiG7
         r53bs1GspCDMXUmGa95/cH1/jvBUSSZaMW8uZSnfGBS/1Hm7oFkU5ge1swirseZ5+8NF
         J0IYSXyiOUrx63QYHdBwCPWs+BRXb8q+joBDj8I7k+GFV8XgOEytOLSyOoXP8Wk9greE
         jkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738524259; x=1739129059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehGfOirhIOOasnif+JzQLELzhF9wvvAgIlZXMirXfFY=;
        b=wvYEa/5swudK2J8hX7KzXsDpPu9ixae0+p6PnP+POxdWjpIMCVtwXaf2V+vTTwdppo
         vB3wYt5I+qU73E5SybYeV0+sYKx+2IwC4kHBbcRy8WtnPj+3bcrXDlYN0Ux86Z/J4ZgW
         X0q3j1g6iLJiypaCe9FaIX4Q1+qnrJGCfOWO4pNwgmgyeH/hrjN6IQixiNmQQ0v1rYBj
         DQ3wVlPrJv1hVvz/YHJnEYK8gk1t78XsPLgjQsQD/Wk1HtP/wdIIt+JA99UeRKmtuxd0
         nvh77eAtdA1s+ABKZTn07vvlj6r3NyUU1b0MOoveG1dm+DLnwWMtVdrtouqKnIS5u9uU
         SfvA==
X-Forwarded-Encrypted: i=1; AJvYcCUALE243zC+CaR0LHD3vvZXoPKb3NjBoB5ha2QjmKcr8DUHAc4wnz//OSV0gSlzYoYN9wBbjYhhtSLk8Gqfmg0=@vger.kernel.org, AJvYcCWvVmbh9rHzoml7iJAKmLg3f7fuXKmWk1ddRrfmc9NIGJoTUsXauOewWggcGNgVKgaGjNk6DTdEd5e2H58x+Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLbM3rXdFAqlUIDzjzmdYjbcVShRdcbybQp9HrejivaYsHVvE
	M34MxWCMYNLtAMpi+qjUUYR+/ET/lGat2Me1vu2Zr4LCRQDBnZ3X
X-Gm-Gg: ASbGncv+2fLuV+M4G/ImSg17q+2dwJXpK/M9XOZgD1C0GQFpFjSgmwef71OKRYD/Bzl
	5wF/Cn8Nidc+9RHAxaHo4trYrDztImTp9CBMWncPChGoNQo2EdNS7rhMKEyTV1W8NLCkTPPuvKb
	AboSEs/4jFqPy7F18YFtVA5rnUBSsGDKZw1rAKUhtLuFpP65mxSRvTOVZshCoZnAOmtCCiGNk6u
	yaoiTVAVXIOxoYU3qXotPEu65E39FdYaRPqU8PUrJ5/EPX6A0PEP1EgbFNH0X3djEG4HpVS/3wr
	/U2al67d/cvpaEMVrYkCp2JY+vu8hnwf2UDivTiREr06GD+wyuB4
X-Google-Smtp-Source: AGHT+IFkfctb30XhHnDPdgfee2ko/GBsx7CC/y1tK4IdyCvi6as6gVLRrMKXhcIJZTaGvjaAugpOgw==
X-Received: by 2002:a05:600c:45cc:b0:434:e892:1033 with SMTP id 5b1f17b1804b1-438e6ea8c74mr81665735e9.2.1738524259224;
        Sun, 02 Feb 2025 11:24:19 -0800 (PST)
Received: from laptop.home (84.50.134.37.dynamic.jazztel.es. [37.134.50.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c122539sm10668006f8f.46.2025.02.02.11.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 11:24:18 -0800 (PST)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	David Rheinsberg <david@readahead.eu>,
	rust-for-linux@vger.kernel.org,
	x86@kernel.org,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v8] Kunit to check the longest symbol length
Date: Sun,  2 Feb 2025 20:24:12 +0100
Message-Id: <20250202192412.340848-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
in the reference [1]. This patch adds kunit test suite to check the longest
symbol length. These tests verify that the longest symbol length defined
is supported.

This test can also help other efforts for longer symbol length,
like [2].

The test suite defines one symbol with the longest possible length.

The first test verify that functions with names of the created
symbol, can be called or not.

The second test, verify that the symbols are created (or
not) in the kernel symbol table.

[1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/
[2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/

Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/504
---
V7 -> V8: typo fixed & rebased
---
V6 -> V7: rebased
---
V5 -> V6: remove tests with symbols of length KSYM_NAME_LEN+1
---
V4 -> V5: fixed typo, added improved description
---
V3 -> V4: add x86 mantainers, add new reference.
---
V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR()
---
V1 -> V2: corrected CI tests. Added fix proposed at [3]

[3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12bb834d01ed1ebdcae12ef5f2add342077

The test execution should result in something like:
```
[20:04:35] =============== longest-symbol (4 subtests) ================
[20:04:35] [PASSED] test_longest_symbol
[20:04:35] [PASSED] test_longest_symbol_kallsyms
[20:04:35] ================= [PASSED] longest-symbol ==================
[20:04:35] ============================================================
[20:04:35] Testing complete. Ran 4 tests: passed: 4
```
---
 arch/x86/tools/insn_decoder_test.c |  3 +-
 lib/Kconfig.debug                  |  9 ++++
 lib/Makefile                       |  2 +
 lib/longest_symbol_kunit.c         | 84 ++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 lib/longest_symbol_kunit.c

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..6c2986d2ad11 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,6 +10,7 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <linux/kallsyms.h>
 
 #define unlikely(cond) (cond)
 
@@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-#define BUFSIZE 256
+#define BUFSIZE (256 + KSYM_NAME_LEN)
 
 int main(int argc, char **argv)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..62d43aa9e8f0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2838,6 +2838,15 @@ config FORTIFY_KUNIT_TEST
 	  by the str*() and mem*() family of functions. For testing runtime
 	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
 
+config LONGEST_SYM_KUNIT_TEST
+	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
+	depends on KUNIT && KPROBES
+	default KUNIT_ALL_TESTS
+	help
+	  Tests the longest symbol possible
+
+	  If unsure, say N.
+
 config HW_BREAKPOINT_KUNIT_TEST
 	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
 	depends on HAVE_HW_BREAKPOINT
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..e8fec9defec2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -393,6 +393,8 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
new file mode 100644
index 000000000000..2a2dd1151097
--- /dev/null
+++ b/lib/longest_symbol_kunit.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the longest symbol length. Execute with:
+ *  ./tools/testing/kunit/kunit.py run longest-symbol
+ *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
+ *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
+ *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/stringify.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+
+#define DI(name) s##name##name
+#define DDI(name) DI(n##name##name)
+#define DDDI(name) DDI(n##name##name)
+#define DDDDI(name) DDDI(n##name##name)
+#define DDDDDI(name) DDDDI(n##name##name)
+
+#define PLUS1(name) __PASTE(name, e)
+
+/*Generate a symbol whose name length is 511 */
+#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
+
+#define RETURN_LONGEST_SYM 0xAAAAA
+
+noinline int LONGEST_SYM_NAME(void);
+noinline int LONGEST_SYM_NAME(void)
+{
+	return RETURN_LONGEST_SYM;
+}
+
+_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) == KSYM_NAME_LEN,
+"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
+__stringify(KSYM_NAME) ", but found: "
+__stringify(sizeof(LONGEST_SYM_NAME)));
+
+static void test_longest_symbol(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
+};
+
+static void test_longest_symbol_kallsyms(struct kunit *test)
+{
+	unsigned long (*kallsyms_lookup_name)(const char *name);
+	static int (*longest_sym)(void);
+
+	struct kprobe kp = {
+		.symbol_name = "kallsyms_lookup_name",
+	};
+
+	if (register_kprobe(&kp) < 0) {
+		pr_info("%s: kprobe not registered\n", __func__);
+		KUNIT_FAIL(test, "test_longest_symbol kallsyms: kprobe not registered\n");
+		return;
+	}
+
+	kunit_warn(test, "test_longest_symbol kallsyms: kprobe registered\n");
+	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
+	unregister_kprobe(&kp);
+
+	longest_sym =
+		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME));
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
+};
+
+static struct kunit_case longest_symbol_test_cases[] = {
+	KUNIT_CASE(test_longest_symbol),
+	KUNIT_CASE(test_longest_symbol_kallsyms),
+	{}
+};
+
+static struct kunit_suite longest_symbol_test_suite = {
+	.name = "longest-symbol",
+	.test_cases = longest_symbol_test_cases,
+};
+kunit_test_suite(longest_symbol_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test the longest symbol length");
+MODULE_AUTHOR("Sergio González Collado");

base-commit: a86bf2283d2c9769205407e2b54777c03d012939
-- 
2.39.2


