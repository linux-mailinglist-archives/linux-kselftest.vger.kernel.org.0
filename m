Return-Path: <linux-kselftest+bounces-25209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F305DA1CF04
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E9E3A5FD6
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF076C61;
	Sun, 26 Jan 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h31j1HX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D4AD39;
	Sun, 26 Jan 2025 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737931008; cv=none; b=ItC2VlzxQYdvN0Mtdaw3UOSZqpeqMLQqgW0pTk0f8s8NRT3GwyIgLsgIhcdoa2lb2Vw4h07jUuQYzZkZM8/Ti3KA/5ryAw+2Q9mYaGAOLmXwWTlVrVXJX7v5gZKYQbhcF7hxYyuYTvqJ93tDcIUCTL933ztZ6NuHIy19Md06J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737931008; c=relaxed/simple;
	bh=zGRnCZw8lUSv5ff0ytQ1sXTGvvDD+BS/qzjMqLoPadY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ShFQ98N62g15+Kn0niXnE8eUPTGwwXcUQS0ajUogIGSzV6tHaSjma5bwdaDsCiNiiYwioHUFyXBF+6ELyStMpixChjH33mGWRKbYY6x+rCI1o5EhXFuSYu4XZr5MNYRSwbneZpz1aQaEXbzXxeYeMEqNMeJv6hXQbcdPtFQLhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h31j1HX1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863703258fso3030775f8f.1;
        Sun, 26 Jan 2025 14:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737931005; x=1738535805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEUocpE7ltOnPKxqoqb5K1toLBI300wp5cHAtZcVdeQ=;
        b=h31j1HX1WZj+qbw8Xm1hJeUzn+pDcscEuMlm6nglNrQpcHbQFr6cfs2h8DDgp/FHu+
         ovc/kvtiQzXn9ENWrXm3052VFzOiGGqeZCq7uQfpdeyT6p1lCjkeIRtK3D1a5HHbtwkU
         60RbU+PIyyw9ZwlV3jiS8dXBaNrxMpdCGS89rj7OQPGn3+jWZ3wBWwHmitrEhY+8/Hws
         aes+vaxJXR9Sq7yI8RZHSC5VBlhaYd0QoEkWBuV5vlxfuRjk335mg+67JWHY5pdWIxCM
         N6H4NNLVh02YP22nrYR2lQhfMlRampROHLCL+2n2th+E5SAIhSc9kBPINI7xsWpMA+PW
         H6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737931005; x=1738535805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEUocpE7ltOnPKxqoqb5K1toLBI300wp5cHAtZcVdeQ=;
        b=mGSrLFsBs/yL3mIj3eZtSVD60XXKZPYHRPT8MUvRYW5lShJgFMswPbnqVLWVoHGzD6
         78RIYcTA2z3fi/ZCfbvk4nCdu3RKoL0WhjufnlqJOzr+qY/H1hXmZN2YO47tClkx6bXd
         ja0oEKmYnVGAnnzNtruRdL0EFYqeyjsTLMGKtn0Hk4Vr71yS7RVa4C213UNjSoc9Ir4x
         erXqbtxSBz3GHsRrPzTVXoPOir/Ahggxk+Ev5y98hFtejZKU1GvLixEzX8tZPQzF21C3
         n/bK5VSvhL9THpt+x7Z0qz6xyNtPgc4LhcgR7GRP0iD5usi2Sy5Y+MhbJVy74AbHi9SV
         0v7A==
X-Forwarded-Encrypted: i=1; AJvYcCU06mdEpiMwkdENAhFqtiLjBtxtOfoHtGHOWp0VkVHyTrwN7wFbQMH1P9Yn2pkxnyFbNyheutTl0mU2t3jNJl0=@vger.kernel.org, AJvYcCWna3JHPzKtG8ZeOlwxgqdjnKq7PsMSwg2DlyGQ19+SaKZILbhx4rPRYLH490yH0ebMc6GtLLFro1vZYIBSWO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzavb9t41tCM9Bm7/urjWpYOKTKw0lUL+Wl8xPOqhUMmBMoTGeN
	2Fwk84GLMXgJcOInLAom5KqShZfgNtO4R/oxh1PJhmfbnvXLutUc
X-Gm-Gg: ASbGnct95T2BKEMjZMFyN5zpb0xgvTKp1ODJWCkTkefOXXv5D7+lN7fFtR7/JmsW5+S
	PYMW68Vc0/slbIZiSdNU6Fj2Jcn/2JkoskVFOfG+mtm6N2pMqhzSOBRc9V5DvW1rR9BYIbnYhoH
	7+kI8PDUJ+Xznpl1izeYmiVRtiBwnHkFcvubLDTLxhYUfHykHAqkl6TFoq8ZWFSRCMEkcRhYE7x
	lJklZ//tPihxsV5pOTOm7FLKFyn1q53rtq1y5BxkS0qnWO/WZnFmM32C+5XL3FAsBBnjNn8ACeL
	1mRE3exmuw537yG1qwVCbKaU3zZLHP56F5I5+WvyCg==
X-Google-Smtp-Source: AGHT+IEvf6Aj5nmtEW4W5Zj0k/wWNUEjvhQEr6jwMu2FbS2VQL+gGRkiusobaZk35IaqjsFKD/SAPA==
X-Received: by 2002:a5d:5f47:0:b0:386:3672:73e7 with SMTP id ffacd0b85a97d-38c2b772610mr9936724f8f.9.1737931004479;
        Sun, 26 Jan 2025 14:36:44 -0800 (PST)
Received: from laptop.home (84.50.134.37.dynamic.jazztel.es. [37.134.50.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188a77sm9398842f8f.51.2025.01.26.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 14:36:44 -0800 (PST)
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
Subject: [PATCH v6] Kunit to check the longest symbol length
Date: Sun, 26 Jan 2025 23:36:27 +0100
Message-Id: <20250126223627.732451-1-sergio.collado@gmail.com>
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
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/504
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
index 5f1874622175..4c3a61862281 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2828,6 +2828,15 @@ config FORTIFY_KUNIT_TEST
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
-- 
2.39.2


