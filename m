Return-Path: <linux-kselftest+bounces-14817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1B94851B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755F52816F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 21:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1953616C426;
	Mon,  5 Aug 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCEty5Jo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3B14A099;
	Mon,  5 Aug 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895019; cv=none; b=BZLv3EJseZI5s1GOycfBYD9liCDpn9wFHCwrEEvu1wXTv3c5Qdi4cv0Pw6fHA2MidwkPq4RSSy8jn0/4ttgT2Bs5fJsNxfhFsrx1AgefA0bzBuLfwNxwUYqI753EIIWtwHP64ht6F7PRUmio5PkC5LLbOCoHOSdEvVhnLZGngR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895019; c=relaxed/simple;
	bh=ZgDcPUTpCF4Mm5Z/yZQGDB6kwws0YMUdErBwO2XQ4o8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UI3HBQRZt2PR39w6pZNNJbTC+u3lvMVx+f6UF+Jwrdkkx+pOutICZYPEteNnc82ZQVrviH4QmRuuN1b1sbyN+Ihgu66uJ/j+1/To/bFzU+VXr/FhORKCOx6MGjxDe4JNfOtVju6fkFTh9o5AiV5duh81khnP1UWPaNJuHadxQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCEty5Jo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280bca3960so470965e9.3;
        Mon, 05 Aug 2024 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722895015; x=1723499815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28/uDi1EiKJll8jhWDtTNE12TCXwHFNwlesnqMVZB28=;
        b=kCEty5Jo+Ha9JjKsz/4muyXjcre7KEeWtEg7uub5aqaHBaqlbEEHIksf0SmWljek0p
         BxCPfFI2hKSJjP8SIQPeR4HK/gzY9bAHYyB4OGpX3khNvdFGmig38lM7iiw+lzP1Jv2G
         hlnCd9phYtMEkPxTR+Br8IOnPLXk5k+0ZklRQkjSNVIlGee5iglPomNXHLE1sP7El83Z
         59sWK//GPp0x2cT6aQRqtF6j9rBhbUl41HILE4iHG9Hx+yv9JRLY4z/FRTuTwxqOFyWw
         EXRWo0xW+THtQ/5SdhoNjNvH5ehfTfQQGxx+qxgA29mGHgkAMjw8tTw9HGfyalWsYbFs
         t42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722895015; x=1723499815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28/uDi1EiKJll8jhWDtTNE12TCXwHFNwlesnqMVZB28=;
        b=ENZjvPI40J5Kj4HZIm3jsvGyjsz/RjsBz0+c2lTo6m5UNh1Ig/CBV1ouGWXYDU6Zkw
         PbWukAty7fXUa59ZYkW8nSD80oh5rhDcTyeEL4Sba+n8E+Ve5M4U9/zhDnjbPf56uG3w
         xizegrytLiLTf8XsDN7qj+vGaW7oJ1OdCYFOXC5tzz14+3aUoLwT/l2+OF7FymH/WKVS
         LwUSTrWzdkXfXYgUdylWwLSfWzs+hg5eJ4BXeBPy/LWt1/thk1AZuCLIE5pqVEnKOWBP
         vbSw1hmqXEopejm92IT3UBZVvTAZrqt7eOuCErTk2vBpdgSeI2SIvGmhBiWciDDPKvQ2
         KZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUO/+CJbT2TWEjNjO+pXTM66ebsmL1t0u2RIQ42ojIe+pTzCpiqYhq21czxtXdFhx2nL2Z2S6wRvkFhhoSccK8T7hrx8fOA6AoKUJUeGNXEXgacfAz0eqLAbRjN/dSNoc7ry80PiGgUP36LeACB6+E=
X-Gm-Message-State: AOJu0YwUoJlZLXU7Fz1/gwBBoGFdHmmPe+pBSB7PlVfzMTa1EBxDloFw
	10lSxhP9UVJ6xHMonN3K80tI1uWMAjHcukzxC1Jv1EGmkJVzUpKW
X-Google-Smtp-Source: AGHT+IEUPcGHYYsoUSKcErZm6gE08kk6KDrurtp/QGjGvauxalr2L6o0kQ5GMjJyBLFnQKsWU77Ytg==
X-Received: by 2002:a05:600c:4e16:b0:426:5b51:109d with SMTP id 5b1f17b1804b1-428e6b83835mr81794195e9.36.1722895015250;
        Mon, 05 Aug 2024 14:56:55 -0700 (PDT)
Received: from laptop.. (220.red-83-52-58.dynamicip.rima-tde.net. [83.52.58.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428fe2d4adcsm2688085e9.1.2024.08.05.14.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:56:54 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	sergio.collado@gmail.com
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v3] Kunit to check the longest symbol length
Date: Mon,  5 Aug 2024 23:56:22 +0200
Message-Id: <20240805215622.102133-1-sergio.collado@gmail.com>
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

[1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/

Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
V1 -> V2: corrected CI tests. Added fix proposed at [2]

[2] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12bb834d01ed1ebdcae12ef5f2add342077
---
V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR()
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
index a30c03a66172..4587466f7d07 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2783,6 +2783,15 @@ config FORTIFY_KUNIT_TEST
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
index 322bb127b4dc..4241807025b8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -388,6 +388,8 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
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

base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.39.2


