Return-Path: <linux-kselftest+bounces-27990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604FA4B53A
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 23:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B8E188EC11
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1D1ACED2;
	Sun,  2 Mar 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpwTPxVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225217BB6;
	Sun,  2 Mar 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740953738; cv=none; b=st7UTUQ8dG33HwTZvD6vs5yyWTJ/KhddKqsp12KyBmJfaVWkmKd3nbAdw1AOSJZIvtxU9BWt4zU+fKd4KqmKKWBXSG06zo0EPgTFFxRHnWwOYlcW2ajwF6na6lHoK3Bn58aCAKTEkwewp6f4uaeYxB2wGsphpfndoShHc5PFxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740953738; c=relaxed/simple;
	bh=qgWzzYGzUOfsYbt9FY1EPcFX/oxGx1+IZLhtkajYQ/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cUC9X/rh6FdWY/0IxmfO0aiWiLicvwMcpTp37+WgdER9tNJp/Ro0EMSOFcMhnwgsaN+uaHGzb3jBYtYCOS7dfQOkaLZUo+sh7Bi836p0w+A0QfbQin1EEXGGPFLTsS/w4TDFMC3KSZlreIITACj4xOhB32z/MCkutpd99640pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpwTPxVQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so1611522f8f.1;
        Sun, 02 Mar 2025 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740953735; x=1741558535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT3jJdhNiK5oqPQud6J/jLWDQY6RlU4jpu3M/YNdZZQ=;
        b=EpwTPxVQFgqu0nCchIn02Df2PlVPTJ+JE81X0lReTbsoVk0fGEm23jJ3R/4CPXY+/H
         +2Q4ly/xjUmtSiZvWLKyyRYIZEuNFRso+smPaHmzcS5Nnm8MnMKZ3oZmXiYZo8NoSHdb
         80PBtbEsA4B4Jyk04rwwt1BgK2CEmG0doonUnD9/cLzSskMStMUZaA+oX/O+9Mi0BsZ5
         Z8pOE5UzjoAlFvGeuBlsAhfprcyj5GhHQzR6w6o8GxEOevvBt02RfKNMpLwk1RZVhOCR
         ZXnNQDWQ4KsT6CqioPipSUVhkVolTpoNrher7VG09kCaerDjDpvOa/XmXVsWlIeBXv4Y
         vQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740953735; x=1741558535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WT3jJdhNiK5oqPQud6J/jLWDQY6RlU4jpu3M/YNdZZQ=;
        b=XSRtG7+TDPRPRn7mkWB9WBZYC7Co9reQrFY18KOaFvNNWcIPIook5kFKyyDRkfBKOs
         AmscyND/FmPMsVsKtcRFhXGwNJbxV6sVn0kr/oomLDD4uYPBPOhP2QAzR5oCVQdeChlI
         M4wGrc9XwkzG7mHRaqBELydSqF3VLgaJtCpJgiKo8VgEGn7+6zwdHWzz1wU7rIMNNoxM
         MNEyaRWJ0MhIfc0C/BkcGjvxIHPyoe4A5/A8pXCzaiRIgufY3z8zIQRchDfiUZs4DeBI
         /6HyeTA7IAapYPq/vzxUqiKPMCiQSNTXRsFSyqWtv89NV7rjbj8dcPznSE7q1yUpdg4M
         kyBg==
X-Forwarded-Encrypted: i=1; AJvYcCUgrLhSvxjevYzsfQTiu6QRP4hFwgnHwQShBVZEVq3W4O5bythI8joDFHnXNuWZtZRcucNbkIA+MB45Ncw3m0o=@vger.kernel.org, AJvYcCV7yUvZHtOy6nSOS2TF0pYrdi8cx+mflkI1AC07H6OB1sQueE+qWcHjkFvBgWi0Zz8mfcZyV9ukgfUmQfNnU9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qsjQty6RIYp77AckccpxCI6AOm+uARQ1EOjl5Hv57/RJ8W4I
	zvN3ZxBL/jZKgP7VagdGH6g6RetCsw2HX1tKPyrG2IE5KzEeU8x0
X-Gm-Gg: ASbGncuel6+DmeAslZEHXTF9wiK331awaus+INBCFkk1t+2YybTi0EbYYGgVulXM/Cl
	2IIs2KD1wWBMX8RzO0SLknqDm94bZn3x5DJjmbjT2TChWiObxZR8GmQAk8L/5imZgXwGB+0nWbe
	C7RYrejgjnt0nF1v8XWN65mQEO4XxZzjNurrS2Fd7+CJZ3CZt6p5gH3b454SQjR9NHbFPVSHlr/
	+dXK5VI1yxAdvQk+VBt2M7LAl+9bRg9BWKMq0RbfIARIeHuz+jqJJEQD3WxJX+lyHVN3pi7k7MD
	PItEy8fruJUts7++H+Oa3GJ5CJ5VlWToEng/GwIYBgdblA4JyXmrPW/AzscBYDgtNO15Ceusu4t
	Yc5QPgw==
X-Google-Smtp-Source: AGHT+IH6L0sOdkgHGckLHV6nuv+0myO3j+DW23brq0tQNP52mD9oSUgU+q68zbe0oayyo0WsBqJYQw==
X-Received: by 2002:a5d:6d87:0:b0:390:f738:246b with SMTP id ffacd0b85a97d-390f73829e8mr5514704f8f.15.1740953734674;
        Sun, 02 Mar 2025 14:15:34 -0800 (PST)
Received: from laptop.home (84.50.134.37.dynamic.jazztel.es. [37.134.50.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc06eba55sm17660205e9.21.2025.03.02.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 14:15:34 -0800 (PST)
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
Subject: [PATCH v9] Kunit to check the longest symbol length
Date: Sun,  2 Mar 2025 23:15:18 +0100
Message-Id: <20250302221518.76874-1-sergio.collado@gmail.com>
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
V8 -> V9: removed unused macro & corrected error message
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
 lib/longest_symbol_kunit.c         | 82 ++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
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
index 000000000000..e3c28ff1807f
--- /dev/null
+++ b/lib/longest_symbol_kunit.c
@@ -0,0 +1,82 @@
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
+__stringify(KSYM_NAME_LEN) ", but found: "
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
+		pr_info("%s: kprobe not registered", __func__);
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

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.39.2


