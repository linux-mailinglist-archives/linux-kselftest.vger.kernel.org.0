Return-Path: <linux-kselftest+bounces-33785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C36AC4059
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD7718886A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E20459A;
	Mon, 26 May 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E19TnGdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF33202C30
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266103; cv=none; b=txlJGvjGbFWZdiJfXnRwkJYlEyHDjgwvjew+v8pz7mz6wdDuIjLft4i4lmzdFhCckVrI8gDhAdUR2fX+BNe5SIswc98B8Y5SdpMXq3SY6M3WzrAOAUcFzFq3eOWeuq5F0RsSRugkZXACm1ti4z2JsEjZxDMygU+O6SwstrI97lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266103; c=relaxed/simple;
	bh=n5d4OGoYqctd2xiuPMjzJfNMCDRu7K0X6TIZ9vKgqEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=g925rbLHMuhEReLEbFpARHJk5T3EHLwEQ1XhS4dL8i/CpVz8GPB/WHob8PQ00ZWCW+Ga4RTHZnxAkodQ3RBlXUbvZxWKQMfpIG8bxW1AVYAXxK7hdTyLUAdA4tHnrNj/iLrJkd5l7TaEiOD9ShXw2Y0LVcK19aahNRGDzrRMugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E19TnGdb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748266100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9vjEnV/6++7H0UqvKE3E1Ij3XuBUAM7NnKxdzBpzS8=;
	b=E19TnGdbKKuh1GsfFkaRw8NyqWWIdO8e33lFqBgHS/Wpk6p4L+vud6vZUgFaszqOH/uJ3o
	OU4QAMDLsaXnXx3nR3Mu7JgiTioGoIPblFO4dbxwPF8x4Pu5s4QYKLX4ytScv5KJTUOW/x
	1Qzmc5P9ZUZgFLzfEt34OSY4MnIspWo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-aZncPSswMS2g9shL-PcgcQ-1; Mon, 26 May 2025 09:28:18 -0400
X-MC-Unique: aZncPSswMS2g9shL-PcgcQ-1
X-Mimecast-MFC-AGG-ID: aZncPSswMS2g9shL-PcgcQ_1748266098
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so1248538f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 06:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266097; x=1748870897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9vjEnV/6++7H0UqvKE3E1Ij3XuBUAM7NnKxdzBpzS8=;
        b=VfXinXFYctF0nBO+IS/HtgqylrkIeFn1D7yRptprYr13bEckdyKCdE8MpO4O72E21u
         9gwapuwontX3K3gxCqyItlgKamJMeKlIWu7aYCUoR/8wJ92Cb5gGocsKfBR6medpD2Wj
         b8Q0sag2I4HKkiGNx4AVFXl+DuF5dbZhYD/WWlNSd04SmZN+MoXEcyzcECWOclvyCVfg
         uJQToCO3MP3obevMTiefAGItDImaMyYEZog67VJqG+uIKOGTd5Jp7pQyuyvOw30VHa7b
         ptA28bJNk5hn/I8HPtE1zOEX9wmaMxa1Pqtw6Cn5L2RP74/Q1Uw/tIpBkkRyEsAtIRHM
         +a0A==
X-Gm-Message-State: AOJu0Yz8FN/UBLKvxU6F0IuqbNrkpazcocGsMsvuqlfuPonOV12twEqW
	pDdf4kXYlrfWTaSd2Vept7igX4OF2xUzn6Mfxx5iyn8+pY2PTp3+FNz+DNV8zJIQEAJac3ojR/B
	GFiPkFidcq7W3FajWCLwPIDQp9Fs7sDLYGUZmcj0ZpJGcKYyWrPhLsgMrsB6uVlmXhbvQi1t+3Z
	c2r5bOIMcV8wQWvaVkTFvUFYyFJjHeOty7RpOcNTgNV/VPA5+4BP4qpZaa
X-Gm-Gg: ASbGnctUv4o6TXNrdlolSUAWIHp1JquiY6uufCXWtqF8lW8hAuVKmlg0QBSg0kE9PK0
	jUVL3/N2BDCqi5JpZ25Xc4paxDfuWYbujG37AmvypW4dX5VAKJ+t8vLcduI7KrhSfYY//fDz+3n
	f5jxhL2ScGdlJ/gL6VXiTIdR+/VJTLAzAHxnbgkWjDomag/QlxAVzAJZFVVJbQ6S0hYmntj6EMr
	tXe6a/AEFhtxmr52h43hQti1fC0kNmmfliBlTKGuc3RZTVtxW6vwX2CW79Ol15TF6GisxK24qq+
	N2DUAgY36H0JNRIP
X-Received: by 2002:a05:6000:2389:b0:3a4:d238:682c with SMTP id ffacd0b85a97d-3a4d2386cfbmr4387702f8f.53.1748266096856;
        Mon, 26 May 2025 06:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+TzELYirrzRn6GPl7VyqI1Bh67rUmwdFP6IvCc7nKkcDX0YZ4TFGDqi0wpDkJs21TebdnUg==
X-Received: by 2002:a05:6000:2389:b0:3a4:d238:682c with SMTP id ffacd0b85a97d-3a4d2386cfbmr4387648f8f.53.1748266096286;
        Mon, 26 May 2025 06:28:16 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4c8455e7dsm8836663f8f.9.2025.05.26.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:28:15 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning backtraces
Date: Mon, 26 May 2025 13:27:51 +0000
Message-Id: <20250526132755.166150-2-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526132755.166150-1-acarmina@redhat.com>
References: <20250526132755.166150-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Some unit tests intentionally trigger warning backtraces by passing bad
parameters to kernel API functions. Such unit tests typically check the
return value from such calls, not the existence of the warning backtrace.

Such intentionally generated warning backtraces are neither desirable
nor useful for a number of reasons:
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

Solve the problem by providing a means to identify and suppress specific
warning backtraces while executing test code. Support suppressing multiple
backtraces while at the same time limiting changes to generic code to the
absolute minimum.

Implementation details:
Check suppression directly in the `WARN()` Macros.
This avoids the need for function symbol resolution or ELF section
modification.
Suppression is implemented directly in the `WARN*()` macros.

A helper function, `__kunit_is_suppressed_warning()`, is used to determine
whether suppression applies. It is marked as `noinstr`, since some `WARN*()`
sites reside in non-instrumentable sections. As it uses `strcmp`, a
`noinstr` version of `strcmp` was introduced.
The implementation is deliberately simple and avoids architecture-specific
optimizations to preserve portability. Since this mechanism compares
function names and is intended for test usage only, performance is not a
primary concern.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 include/asm-generic/bug.h | 41 ++++++++++++++++----------
 include/kunit/bug.h       | 61 +++++++++++++++++++++++++++++++++++++++
 include/kunit/test.h      |  1 +
 lib/kunit/Kconfig         |  9 ++++++
 lib/kunit/Makefile        |  6 ++--
 lib/kunit/bug.c           | 50 ++++++++++++++++++++++++++++++++
 6 files changed, 151 insertions(+), 17 deletions(-)
 create mode 100644 include/kunit/bug.h
 create mode 100644 lib/kunit/bug.c

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973..3cc8cb100ccd 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -18,6 +18,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
+#include <kunit/bug.h>
 #include <linux/panic.h>
 #include <linux/printk.h>
 
@@ -61,9 +62,12 @@ struct bug_entry {
  */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
-	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
-	barrier_before_unreachable(); \
-	panic("BUG!"); \
+	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {			\
+		printk("BUG: failure at %s:%d/%s()!\n", __FILE__,	\
+			__LINE__, __func__);				\
+		barrier_before_unreachable();				\
+		panic("BUG!");						\
+	}
 } while (0)
 #endif
 
@@ -95,21 +99,26 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #ifndef __WARN_FLAGS
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
-		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
-		instrumentation_end();					\
+		if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {		\
+			instrumentation_begin();			\
+			warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);\
+			instrumentation_end();				\
+		}
 	} while (0)
 #else
 #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
-		__warn_printk(arg);					\
-		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
-		instrumentation_end();					\
+		if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {		\
+			instrumentation_begin();			\
+			__warn_printk(arg);				\
+			__WARN_FLAGS(BUGFLAG_NO_CUT_HERE |		\
+				BUGFLAG_TAINT(taint));			\
+			instrumentation_end();				\
+		}							\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
-	if (unlikely(__ret_warn_on))				\
+	if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__func__))	\
 		__WARN_FLAGS(BUGFLAG_ONCE |			\
 			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
@@ -121,7 +130,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #ifndef WARN_ON
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__func__))	\
 		__WARN();						\
 	unlikely(__ret_warn_on);					\
 })
@@ -138,7 +147,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #define WARN_TAINT(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__func__))	\
 		__WARN_printf(taint, format);				\
 	unlikely(__ret_warn_on);					\
 })
@@ -157,8 +166,10 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do {		\
-	do {} while (1);	\
-	unreachable();		\
+	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {			\
+		do {} while (1);					\
+		unreachable();						\
+	}								\
 } while (0)
 #endif
 
diff --git a/include/kunit/bug.h b/include/kunit/bug.h
new file mode 100644
index 000000000000..9a4eff2897e9
--- /dev/null
+++ b/include/kunit/bug.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#ifndef _KUNIT_BUG_H
+#define _KUNIT_BUG_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/kconfig.h>
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+
+#include <linux/stringify.h>
+#include <linux/types.h>
+
+struct __suppressed_warning {
+	struct list_head node;
+	const char *function;
+	int counter;
+};
+
+void __kunit_start_suppress_warning(struct __suppressed_warning *warning);
+void __kunit_end_suppress_warning(struct __suppressed_warning *warning);
+bool __kunit_is_suppressed_warning(const char *function);
+
+#define KUNIT_DEFINE_SUPPRESSED_WARNING(func)	\
+	struct __suppressed_warning __kunit_suppress_##func = \
+		{ .function = __stringify(func), .counter = 0 }
+
+#define KUNIT_START_SUPPRESSED_WARNING(func) \
+	__kunit_start_suppress_warning(&__kunit_suppress_##func)
+
+#define KUNIT_END_SUPPRESSED_WARNING(func) \
+	__kunit_end_suppress_warning(&__kunit_suppress_##func)
+
+#define KUNIT_IS_SUPPRESSED_WARNING(func) \
+	__kunit_is_suppressed_warning(func)
+
+#define KUNIT_SUPPRESSED_WARNING_COUNT(func) \
+	(__kunit_suppress_##func.counter)
+
+#define KUNIT_SUPPRESSED_WARNING_COUNT_RESET(func) \
+	__kunit_suppress_##func.counter = 0
+
+#else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
+#define KUNIT_DEFINE_SUPPRESSED_WARNING(func)
+#define KUNIT_START_SUPPRESSED_WARNING(func)
+#define KUNIT_END_SUPPRESSED_WARNING(func)
+#define KUNIT_IS_SUPPRESSED_WARNING(func) (false)
+#define KUNIT_SUPPRESSED_WARNING_COUNT(func) (0)
+#define KUNIT_SUPPRESSED_WARNING_COUNT_RESET(func)
+
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+#endif /* __ASSEMBLY__ */
+#endif /* _KUNIT_BUG_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 39c768f87dc9..bd810ea2f869 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -10,6 +10,7 @@
 #define _KUNIT_TEST_H
 
 #include <kunit/assert.h>
+#include <kunit/bug.h>
 #include <kunit/try-catch.h>
 
 #include <linux/args.h>
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd964..201402f0ab49 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,6 +15,15 @@ menuconfig KUNIT
 
 if KUNIT
 
+config KUNIT_SUPPRESS_BACKTRACE
+	bool "KUnit - Enable backtrace suppression"
+	default y
+	help
+	  Enable backtrace suppression for KUnit. If enabled, backtraces
+	  generated intentionally by KUnit tests are suppressed. Disable
+	  to reduce kernel image size if image size is more important than
+	  suppression of backtraces generated by KUnit tests.
+
 config KUNIT_DEBUGFS
 	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 5aa51978e456..3195e861d63c 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -16,8 +16,10 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
 
-# KUnit 'hooks' are built-in even when KUnit is built as a module.
-obj-y +=				hooks.o
+# KUnit 'hooks' and bug handling are built-in even when KUnit is built
+# as a module.
+obj-y +=				hooks.o \
+					bug.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
new file mode 100644
index 000000000000..4da9ae478f25
--- /dev/null
+++ b/lib/kunit/bug.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/bug.h>
+#include <linux/export.h>
+#include <linux/list.h>
+
+static LIST_HEAD(suppressed_warnings);
+
+void __kunit_start_suppress_warning(struct __suppressed_warning *warning)
+{
+	list_add(&warning->node, &suppressed_warnings);
+}
+EXPORT_SYMBOL_GPL(__kunit_start_suppress_warning);
+
+void __kunit_end_suppress_warning(struct __suppressed_warning *warning)
+{
+	list_del(&warning->node);
+}
+EXPORT_SYMBOL_GPL(__kunit_end_suppress_warning);
+
+static noinstr int kunit_strcmp(const char *s1, const char *s2) {
+	while (*s1 != '\0' && *s1 == *s2) {
+		s1++;
+		s2++;
+	}
+	return *(const unsigned char*)s1 - *(const unsigned char*)s2;
+}
+
+noinstr bool __kunit_is_suppressed_warning(const char *function)
+{
+	struct __suppressed_warning *warning;
+
+	if (!function)
+		return false;
+
+	list_for_each_entry(warning, &suppressed_warnings, node) {
+		if (!kunit_strcmp(function, warning->function)) {
+			warning->counter++;
+			return true;
+		}
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning);
-- 
2.34.1


