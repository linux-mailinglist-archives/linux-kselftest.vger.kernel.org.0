Return-Path: <linux-kselftest+bounces-26670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE8A362E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB267A4A31
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F726772B;
	Fri, 14 Feb 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJGz/Tq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB7267700;
	Fri, 14 Feb 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550020; cv=none; b=qqrt0soZFJtCdzv5tkpbLUYT2C1aySrHdl8c2OGTqPCS/GQ1XCCcCfitj8kaCTu+JdR9+Zp7S1/jTh5PsE1JHAsJzvovraP9s0n6NJBIcfbJadoV9pFRWPAmaOjvfNi2RMMKO3lDcvhbJ2ayyQpt8Q+6LcfaOUWXjx7Zb/Th464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550020; c=relaxed/simple;
	bh=O4XRHx00u8LeMOTlb8oINWTn9rn9zg1L6QMp1wkUCkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6dXqQ6ga1q7YKq86RvmbyAm/urUC5s6nv5bkI5yGkawfXda7hBM9i45xgW7BUy6AUFtVTYYO/jxQjJYG8bau8VNWB0giObCD90pMB/kp3jSVleAGURiVUJ7ja3DKZwE7+ZOUEPDR427fhPmFEzBtnR82z+tWYGArBRbb9Yrz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJGz/Tq3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46b1d40abbdso17833871cf.2;
        Fri, 14 Feb 2025 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550016; x=1740154816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUz+jjCFU1ufbjv5/7ngcTa5QZ/QALO1ok87HNfKxfo=;
        b=eJGz/Tq3xFgxXquYQXqu1gdKcC1kyk7DDeRj5aeEoSHU4tHQku8FOpuHuVNhD68sl5
         qDiH4n8tKsUszS/9eUL0ggU8ejmJrE9EYAXBsUqBKafI8bsE1pNi+XvhUQ0T6tmGbjZF
         PX5wchJzJdJ7MVtzyga9rm8BeZxPAhM/17KvG1RqHFRowE97LRUuaZh5whgf77vCE1bG
         E3SJRodgEDnIiZt5240fVYYEuGRtItMQTaaLxa9flt7bYoXZs1nsW+mxLWyCZL0pSaUS
         DJ9ZcmlNRZr3E2b399ziyzaWssJuDxvQAb+c2hRkA1mS94cd1Xwmhhwjy+0PTjNKuNtx
         XJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550016; x=1740154816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUz+jjCFU1ufbjv5/7ngcTa5QZ/QALO1ok87HNfKxfo=;
        b=H+PBy9JfKVCAqZlimFgPkmEvEdWNiThKst9/29xbB+J9ovrpg9deTgpDmYJy5REkVQ
         NyGBCAK0dk1gWgVrYmANr9ygYaSsUbGqjxUQgbbVh9muO3tE3CbkbbasBf+TOdKa6nRF
         qBAAWso4W1cBa7HJzzaDSvHMwZRDmf3k99Bpk5vKN29PowkVBfbG/JaTXDVEaSm1TGhO
         3vnKwgL/uxSj1i8u56cRJ3R6QpsXyFlmUCFthunXeBrbczn1IDKGu3tGdz9jnJeUzxtE
         nXbR6oUmz35/zetuRkDHnMBjOJgh5e7bIgqz+Jw/aKXJmeX6KKdlx6eSweowetXWx/PK
         LuWg==
X-Forwarded-Encrypted: i=1; AJvYcCVWiwRofVRnuJzEndcXXFV+gIdw4DlK1oav9FJ83wpK/9Hypk88E8XxBwLBfxT4kz1XDRA5zcCJIwh8jp8=@vger.kernel.org, AJvYcCWVfbsOEGtIL7rpWIx3ZTNpL1AeBZeFsrcPwY6SFa5gSt/g0GT3UTsPC8E3Be+/9y8i5pN/dTvy0gRh3+aa1Ve+@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhZG6aKKcZhniz/uyGdz1MxkyYYUY6C+xlC/LQNsMaVO71dbg
	Y2yeX59WZhywGcbyUmgxT58dSS9gVXc1IfuzaMwgFBc67znP+WYM
X-Gm-Gg: ASbGncv/RuidUllomHYFw8NydG603TdvTIZoJ33fMwWklSWnQAR66iGZjojrnAwoTGT
	klSQJm7yS1bvIuuTzHO+Rhb8OI/BjpH8Q/ieK1nlkisybtfCiAqpCaQG+9oc65m9hpZ4b+FsCGx
	TOICsH+w2gtATgaSBoENQk8HEvWYak6gvDuU6lQb5oK/3vDws4v+NxSroIOxGGqw2xDbMmroZ09
	885Gre5S+T5Vld7Ck5aQvEzeH/q37h6DNs5H6KRyDOw1IkHXn2naeYmH276jHXKJrDWEQxF2ix8
	/yYbVejULyikMe9WCPhQSoyzPuklkZ+3eiF6UA==
X-Google-Smtp-Source: AGHT+IFspXCCtEtBaZbuATrzMaOpYK1v7G3V5p66Nt1kRfWM+DKYIFnFRn31Y162VPQqPh0Usv8/CQ==
X-Received: by 2002:a05:622a:8c08:b0:471:b403:59cf with SMTP id d75a77b69052e-471b4035a7dmr141019211cf.4.1739550016081;
        Fri, 14 Feb 2025 08:20:16 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37c7sm19196911cf.61.2025.02.14.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:20:14 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 11:19:58 -0500
Subject: [PATCH v8 1/4] scanf: implicate test line in failure messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
In-Reply-To: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This improves the failure output by pointing to the failing line at the
top level of the test.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/test_scanf.c | 66 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 44f8508c9d88..d1664e0d0138 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -24,12 +24,12 @@ static char *test_buffer __initdata;
 static char *fmt_buffer __initdata;
 static struct rnd_state rnd_state __initdata;
 
-typedef int (*check_fn)(const void *check_data, const char *string,
-			const char *fmt, int n_args, va_list ap);
+typedef int (*check_fn)(const char *file, const int line, const void *check_data,
+			const char *string, const char *fmt, int n_args, va_list ap);
 
-static void __scanf(4, 6) __init
-_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
-	int n_args, ...)
+static void __scanf(6, 0) __init
+_test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
+	const char *fmt, int n_args, ...)
 {
 	va_list ap, ap_copy;
 	int ret;
@@ -42,12 +42,12 @@ _test(check_fn fn, const void *check_data, const char *string, const char *fmt,
 	va_end(ap_copy);
 
 	if (ret != n_args) {
-		pr_warn("vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
-			string, fmt, ret, n_args);
+		pr_warn("%s:%d: vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
+			file, line, string, fmt, ret, n_args);
 		goto fail;
 	}
 
-	ret = (*fn)(check_data, string, fmt, n_args, ap);
+	ret = (*fn)(file, line, check_data, string, fmt, n_args, ap);
 	if (ret)
 		goto fail;
 
@@ -67,88 +67,88 @@ do {										\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
 		pr_debug("\t" arg_fmt "\n", got);				\
 		if (got != *expect) {						\
-			pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
-				str, fmt, *expect, got);			\
+			pr_warn("%s:%d, vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
+				file, line, str, fmt, *expect, got);		\
 			return 1;						\
 		}								\
 	}									\
 	return 0;								\
 } while (0)
 
-static int __init check_ull(const void *check_data, const char *string,
-			    const char *fmt, int n_args, va_list ap)
+static int __init check_ull(const char *file, const int line, const void *check_data,
+			    const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long long *pval = check_data;
 
 	_check_numbers_template("%llu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ll(const void *check_data, const char *string,
-			   const char *fmt, int n_args, va_list ap)
+static int __init check_ll(const char *file, const int line, const void *check_data,
+			   const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const long long *pval = check_data;
 
 	_check_numbers_template("%lld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ulong(const void *check_data, const char *string,
-			   const char *fmt, int n_args, va_list ap)
+static int __init check_ulong(const char *file, const int line, const void *check_data,
+			      const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long *pval = check_data;
 
 	_check_numbers_template("%lu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_long(const void *check_data, const char *string,
-			  const char *fmt, int n_args, va_list ap)
+static int __init check_long(const char *file, const int line, const void *check_data,
+			     const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const long *pval = check_data;
 
 	_check_numbers_template("%ld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uint(const void *check_data, const char *string,
-			     const char *fmt, int n_args, va_list ap)
+static int __init check_uint(const char *file, const int line, const void *check_data,
+			     const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned int *pval = check_data;
 
 	_check_numbers_template("%u", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_int(const void *check_data, const char *string,
-			    const char *fmt, int n_args, va_list ap)
+static int __init check_int(const char *file, const int line, const void *check_data,
+			    const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const int *pval = check_data;
 
 	_check_numbers_template("%d", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ushort(const void *check_data, const char *string,
-			       const char *fmt, int n_args, va_list ap)
+static int __init check_ushort(const char *file, const int line, const void *check_data,
+			       const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned short *pval = check_data;
 
 	_check_numbers_template("%hu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_short(const void *check_data, const char *string,
-			       const char *fmt, int n_args, va_list ap)
+static int __init check_short(const char *file, const int line, const void *check_data,
+			      const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const short *pval = check_data;
 
 	_check_numbers_template("%hd", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uchar(const void *check_data, const char *string,
-			       const char *fmt, int n_args, va_list ap)
+static int __init check_uchar(const char *file, const int line, const void *check_data,
+			      const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned char *pval = check_data;
 
 	_check_numbers_template("%hhu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_char(const void *check_data, const char *string,
-			       const char *fmt, int n_args, va_list ap)
+static int __init check_char(const char *file, const int line, const void *check_data,
+			     const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const signed char *pval = check_data;
 
@@ -196,7 +196,7 @@ do {									\
 	T result = ~expect_val; /* should be overwritten */		\
 									\
 	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
-	_test(fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
+	_test(__FILE__, __LINE__, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
 } while (0)
 
 #define simple_numbers_loop(T, gen_fmt, scan_fmt, fn)			\
@@ -344,7 +344,7 @@ static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len
 #define test_array_8(fn, check_data, string, fmt, arr)				\
 do {										\
 	BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);					\
-	_test(fn, check_data, string, fmt, 8,					\
+	_test(__FILE__, __LINE__, fn, check_data, string, fmt, 8,		\
 		&(arr)[0], &(arr)[1], &(arr)[2], &(arr)[3],			\
 		&(arr)[4], &(arr)[5], &(arr)[6], &(arr)[7]);			\
 } while (0)
@@ -608,7 +608,7 @@ do {										\
 	const T expect[2] = { expect0, expect1 };				\
 	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
-	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
+	_test(__FILE__, __LINE__, fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
 } while (0)
 
 /*

-- 
2.48.1


