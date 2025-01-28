Return-Path: <linux-kselftest+bounces-25273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DDAA204BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 08:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC01D163B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B2218DF8D;
	Tue, 28 Jan 2025 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBOn6G8v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27434430;
	Tue, 28 Jan 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738047879; cv=none; b=ZnvmlvdHayaBoWZ9abQpqNAkvps9W1vxtHfhH1SiPzWBPsRknG5FKDBT9Y65HHVSG21u5TpP6BScRCClLJBaPYyCeSwyDC9dAaNc0kkyT5tvPZDuD3XIMuxjp/coujOJOvagqKhwujfmlojqXUG5rHobj2MHCeRztyQhCT/11kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738047879; c=relaxed/simple;
	bh=5I2E5tXA63xLZ6ll0orakXqi9vAq4Gg9Eyc9w9aWkXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ENeYy74FHJFBnaxqTsJvTTkXqXrJBoWvXCFTOok0i+c9gMD1ztb7ifzfWwsWM57+CqQVH/bntVuKpsQHBJPgOuKFQwBh6GRxj9mpkfV4AHSNMn5YdSmzJFIc7J0vh7+VQBd2gEaInAeDzJVfKN116VYgFpRCgHke9hxC/Uf2wds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBOn6G8v; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436a39e4891so34905005e9.1;
        Mon, 27 Jan 2025 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738047876; x=1738652676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbeJAgKp37mw/Qtj1tIJCQjnNCJRZyhSKGjq05+T6zs=;
        b=SBOn6G8v3jqGrhWNagwBfJNbPln+aDdvVHENYBS+aXj7abyAztWqzvsnSkGEViVcZt
         6hv33O/UMKEN6dJtiV0rIHn4dtgMoUGdK2j0voQxlaY6TWkRRf5EgLOkHgMWK7tOiXcN
         bu5DzJrC9h5R/GOsnc+lgug+POyx7t/YodDKrsHWecuyQuEtjml7ku0xAKfXyLav6l+a
         8FmdAnuUpeS1F1Mmn8yY95VYG9oYJzxXuyL/6H2TuMYYC5JnRRr7zW3KWHKfwsO+4mNO
         jJDoJSfn749rXSL7sY3mI8bN+KhDbpY0vsQsSq8TyXGcmSaiZHGwN9EKp+ZmD/BgOFZK
         EkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738047876; x=1738652676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbeJAgKp37mw/Qtj1tIJCQjnNCJRZyhSKGjq05+T6zs=;
        b=jGDHdNd9CagnWVRtFTN/LbhwNUMYEgXhHgkcNb6BoKQU6e704IuChDqNTcwZvXyn//
         LYm5E5Ep+rpzlWu16TDb8JRGTDpKoYLEV9WaExs1SH1QCZsJnwPgxl4ekzS15LdUsGI2
         gGnTPYmAy+2ZraMnwqsneoWfkS4i2bFK44JR7n/gP6MNP3gjsrmeM86F70eGkm9qHNHe
         vRo0q5EjyN805rjKzzDNBClXNSZ7ht+pH/zqYtK/KH7YLPPTGg02sG1kGSikyUmIunhP
         Unp3oRmMNaNDOuhhjTHArSkQ63Aku9GnOp9tvKqOz1xOA9N2IHTGBLBElIGBgt4gvNUD
         AyNg==
X-Forwarded-Encrypted: i=1; AJvYcCWCO8vb4+I1rbQN6u7fT0H1sJJenXkKpLLcosGgDRPrmvlaOZIiZq+Oma2VEqph1ccVOOUX7nPUan4hWdKWeaE=@vger.kernel.org, AJvYcCXQyF9+iS7GgjSsjCtY8YZE3SCx9oZbRe1HoOS5P4oLEBc/lQqBZ5ydQwD7VbvAURDeKa8qGQMUWNaRdrXUd1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhHL7mfcjMfnziakXKvZq0Sznm0hT9MA5MkEYA/rE/4PtsBfZ
	wMZjkXW7Glk8pSCKYBcv5zxfKSNOEXmHGLwo0SbDSGAtdcuhf5o1
X-Gm-Gg: ASbGncspr27bj4LZkHarCh2BxrLN0pgMYuZNJxlN4Hq06fJ6BZHQZkFeMcjVOasxevK
	Zrw4vMgFZ/MAmt4MWdJcsPJLmFsK4efgopjdFx0fP+zdTaYM9vagEGzNd13kuicN8qHV1RzwS9b
	bj5BeJKzo2YQuGoBLqDGgWs0x9jBK2Bste9Jxjhi+vQQksbfGtCizVzHydy4Jw/oLvkrc8iswLs
	IKadq76zfmJvVIAYyEsmLPHrUWIJsQ1WT0Ul+x6HnCKukh0HariVcX5ah1ZzJad2DBvOZHyn47s
	FargQDFhkW9MtYf8BPOCJQ1QgUPssM7JuQLIQ/gmLKUVfL6vtIl8
X-Google-Smtp-Source: AGHT+IFBcHU3xuJQgw1B4ZMz6jwrG71kgA40Gx3Tq8Ew0S5WeaCzlley393K3MDoG5W2Lmsw2A+/Rg==
X-Received: by 2002:a05:600c:5101:b0:434:f925:f5c9 with SMTP id 5b1f17b1804b1-438913c85e0mr389267215e9.6.1738047875611;
        Mon, 27 Jan 2025 23:04:35 -0800 (PST)
Received: from laptop.home (84.50.134.37.dynamic.jazztel.es. [37.134.50.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4900e2sm158406885e9.24.2025.01.27.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 23:04:35 -0800 (PST)
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
Subject: [PATCH v7] Kunit to check the longest symbol length
Date: Tue, 28 Jan 2025 08:04:17 +0100
Message-Id: <20250128070417.46632-1-sergio.collado@gmail.com>
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
---
 arch/x86/tools/insn_decoder_test.c |  3 +-
 lib/Kconfig.debug                  |  9 ++++
 lib/Makefile                       |  2 +
 lib/longest_symbol_kunit.c         | 84 ++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 lib/longest_symbol_kunit.c

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..3bde35ea4188 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,6 +10,7 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <linux/kallsysms.h>
 
 #define unlikely(cond) (cond)
 
@@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-#define BUFSIZE 256
+#define BUFSIZE (256 + KSYM_NAME_LEN)
 
 int main(int argc, char **argv)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 775966cf6114..9bab160efa4a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2852,6 +2852,15 @@ config FORTIFY_KUNIT_TEST
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
index f1c6e9d76a7c..33b5ef908764 100644
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
index 000000000000..38ae117647e4
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
+		KUNIT_FAIL(test, "test_longest_symbol kallsysms: kprobe not registered\n");
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

base-commit: 6d61a53dd6f55405ebcaea6ee38d1ab5a8856c2c
-- 
2.39.2


