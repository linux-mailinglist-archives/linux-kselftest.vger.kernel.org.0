Return-Path: <linux-kselftest+bounces-18318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A38984A3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D35B1F2459A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613181AB6E4;
	Tue, 24 Sep 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FezHFyjM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C952941B;
	Tue, 24 Sep 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198654; cv=none; b=CP3M4gtttwprFHbHUiVp394LIakMnyhCIOGQJvHmzQ6RIb0ht95/+5KKEqgYQJBknTR2tDvTFV+4VP26flx9W2SFkqgVE1zCHugIngJpoAZUr/KjEPIRK5bgVOxUlFVi1kzF9/FHeliYYxjC1hnwQi/JvU5R20Fv+TyNb5tdnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198654; c=relaxed/simple;
	bh=i2prbdZtMoWVyDoI4r/p//WUM6FxFMImdthGTI/8140=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uQdHa40EaduNuD+jCcQPNOq+/VrnJrFt8eks9LlvYtY3wvEcDOZ8ekMayTtNM6D9x3rR93tjvBCWUq+yCO9EusGugrNpNp290gfSof4QTKjXMaiw3TFWc6hGlA6CZ8eE8N6VU7AjpEZGnlgkhCDdM1nSCL8KmFYVEOwgJxQ8in8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FezHFyjM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374cacf18b1so3442443f8f.2;
        Tue, 24 Sep 2024 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727198651; x=1727803451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xa6ya8wdG3acprFrPFVxBRwnaLHUBcbgW6iKZmyPgA=;
        b=FezHFyjMx+oBsTD5KHmdoHR025oK8TKFM3tf+LzyyWa14jRKpdxV2/85gWMwZf2ofU
         V0/HtrzUhuAf7KNHetdu5HpcHBkRzqOCSxlZ+gBr5+bROzPk3rSy1cFlHcvQAUWqG61U
         Shltg40Dij6WQwPgJBLTDHrtUf1zY/CFmpA/oadolVrqc7cgQTYrnWdUttsiEP/PKT2T
         aNM+wuaIHiI+B0g/MF+p4TEElTKYEAL/Q2GAjtfjyleimLkA2NrtAk/A7qgfTCl2xgeX
         ztPFoz6oDJrKTWmoHo++bulIyy334TSA2x3kGoqUtz9UfZsSIb3IuwjXZPeBcRjnlCWx
         Kr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727198651; x=1727803451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Xa6ya8wdG3acprFrPFVxBRwnaLHUBcbgW6iKZmyPgA=;
        b=f8AUX5b3s5nt9k+eG60ggUBg30pv4iiMqTXhy8DPePsWGpzm5ZfLHaURL/FofvmMVo
         UwxvWk9mbcKm1YWFlO7XbEN1y0LJm5qW67TCgJOqYQrkbq8Ym2koiy2+5uwfwFf/klqd
         OrhzuI2G7OTowlyiQJHURyRITN3h8cWjcJkengttjd1ajxmrQMvlHy56zoZa5pcTxsaz
         lgCv9UFWStDqFISMfrK1J+h9maBHLFxaU0u3EKnRXBzmU6mtX3drM4NLosx14blQwcAF
         33fBHdiRQ3DJYPbm4vM+aSvbhE/m5wU03GJ/qMuLKhEzah8oDXBuNqbmTvxXQFQtgYb5
         do4w==
X-Forwarded-Encrypted: i=1; AJvYcCVGntmKTJOIJu6NMmnfaXQx/TH6j8Pg5TSEJFBvoex/B41mru9nKJVOkOjdV8d779Mq4WfenCvC4tUpv9Q6p9s=@vger.kernel.org, AJvYcCVdUT6GL5TgX0cy3jamLhz7/3F78nND8tfqpdAsAVmlrCUtZX4B6tgFPRmYZcTqpcDmcf+WFu0DcVg5PijF5lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzjoKClfAKP5pe8qMtJedYB9aY7eaAmdNnpCOa9pAOh0PhBfR
	V6UjO4+gFeygf6zdLGBPz9Bt5cQLRS8vyAYAgR7A2BSQG718VU1z
X-Google-Smtp-Source: AGHT+IGTKSfyy9/yRkrIFuC7cBO7/BvzSRmazQjP6DBcmTpxOZ4uat6YRdZE94fpH202GnM/mUk8dA==
X-Received: by 2002:a05:6000:8f:b0:374:c79b:ca5f with SMTP id ffacd0b85a97d-37cc24c26e2mr80226f8f.46.1727198650417;
        Tue, 24 Sep 2024 10:24:10 -0700 (PDT)
Received: from laptop.home (188.75.217.87.dynamic.jazztel.es. [87.217.75.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f6e1sm2109535f8f.111.2024.09.24.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:24:09 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	sergio.collado@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	David Rheinsberg <david@readahead.eu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	ricardo.marliere@suse.com,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4] Kunit to check the longest symbol length
Date: Tue, 24 Sep 2024 19:23:51 +0200
Message-Id: <20240924172351.23225-1-sergio.collado@gmail.com>
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
in the reference [1]. This patch adds a kunit test to check the longest
symbol length.

This test can also help other efforts for longer symbol lenght,
like [2].

[1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/
[2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/

Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
V1 -> V2: corrected CI tests. Added fix proposed at [3]

[3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12bb834d01ed1ebdcae12ef5f2add342077
---
V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR()
---
V3 -> V4: add x86 mantainers, add new reference.
---
 arch/x86/tools/insn_decoder_test.c |   3 +-
 lib/Kconfig.debug                  |   9 +++
 lib/Makefile                       |   2 +
 lib/longest_symbol_kunit.c         | 124 +++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)
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
index bc8faa4509e1..09015e7e07f3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2805,6 +2805,15 @@ config FORTIFY_KUNIT_TEST
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
index 773adf88af41..fc878e716825 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,8 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
new file mode 100644
index 000000000000..557ad6eae56c
--- /dev/null
+++ b/lib/longest_symbol_kunit.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the longest symbol length. Execute with:
+ *  ./tools/testing/kunit/kunit.py run longest-symbol
+ *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
+ *  --kconfig_add CONFIG_RETPOLINE=n
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
+/*Generate a symbol whose name length is 512 */
+#define LONGEST_SYM_NAME_PLUS1 PLUS1(LONGEST_SYM_NAME)
+
+#define RETURN_LONGEST_SYM 0xAAAAA
+#define RETURN_LONGEST_SYM_PLUS1 0x55555
+
+noinline int LONGEST_SYM_NAME(void);
+noinline int LONGEST_SYM_NAME(void)
+{
+	return RETURN_LONGEST_SYM;
+}
+
+noinline int LONGEST_SYM_NAME_PLUS1(void);
+noinline int LONGEST_SYM_NAME_PLUS1(void)
+{
+	return RETURN_LONGEST_SYM_PLUS1;
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
+static void test_longest_symbol_plus1(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM_PLUS1, LONGEST_SYM_NAME_PLUS1());
+};
+
+static void test_longest_symbol_plus1_kallsyms(struct kunit *test)
+{
+	unsigned long (*kallsyms_lookup_name)(const char *name);
+	static int (*longest_sym_plus1)(void);
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
+	kunit_warn(test, "test_longest_symbol_plus1 kallsyms: kprobe registered\n");
+	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
+	unregister_kprobe(&kp);
+
+	longest_sym_plus1 =
+		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME_PLUS1));
+	KUNIT_EXPECT_NULL(test, longest_sym_plus1);
+};
+
+static struct kunit_case longest_symbol_test_cases[] = {
+	KUNIT_CASE(test_longest_symbol),
+	KUNIT_CASE(test_longest_symbol_kallsyms),
+	KUNIT_CASE(test_longest_symbol_plus1),
+	KUNIT_CASE(test_longest_symbol_plus1_kallsyms),
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

base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d
-- 
2.39.2


