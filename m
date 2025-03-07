Return-Path: <linux-kselftest+bounces-28481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398EDA566B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37E63B1E8B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178F21771F;
	Fri,  7 Mar 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4jDiw6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7F21767C;
	Fri,  7 Mar 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346871; cv=none; b=Kku4ODuCrZahQuNFxmDSPI6DWKpQjdW88cpjWgP9s5bCTwdCcOEC/d8Odlq77pHBjtafyaBKOKKh7/m+WAKBczjGwqPquCfH+yEHvf1M6p8j1Nr9O7OOeuy9rcta2Rsx7MOe6nFk5+SDmTswi5dIfrSlbDjZ4exw359YjI9wttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346871; c=relaxed/simple;
	bh=Xq1CgqkhKVay0fmc3VZLK9DJdEUj+jB1Kujma3ZvEBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqT4r7zmwicQ15Pc/CP+vTm1EyXRYiXqQwfhJlLCXV7gU7Eh5UfOGb9SKHyPEOS50PQ9RiWaeSHG4Y8tJBL+bDkOvIhLog4+IyXtZXP2rYbt986asGZaakGY/alSw2guefwCAztxlOalOigIL3nByGaIiGv0HrKMyUARnG8LkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4jDiw6o; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8fb83e137so10236076d6.0;
        Fri, 07 Mar 2025 03:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346868; x=1741951668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yv/FuUw1j15MVfw0RP9extfwGFNvHE/nh1IKfaWNJPs=;
        b=H4jDiw6ohaImPSsqFYXPju3GW3PinzSis/HJbGAiC3PHuqnLY9hUn0W/qCTHH9jMLW
         qO+L+/XhXH48UJdngjJfrjjHxAM/E2drZNHXLgMjg3uFg+Eh4LSQh+4OCZR9rnRRXmBF
         tcEb9xj62zy6GJaYSdsGy2X+F5GXUShoqUNJ78PmYAqVgCPq1qt6Xwcz6MdJr/1ymWXG
         NzlPi31Ta9HcGjdbCv/7dn6voFCdHm+G8cAfeTmFcMqHQ5RPQyAPGWUnFp1d4woIh1ZD
         LvuakMSlbTUcqQnizbmXREAppBliDICItB1j0LVHRYNO1OeDuJ5WhbJCPwFM+MIWVGFh
         i7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346868; x=1741951668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv/FuUw1j15MVfw0RP9extfwGFNvHE/nh1IKfaWNJPs=;
        b=TP2W6zgyhqnPdLBoq8vIVCEZghesiPVilueYSksPahC8y1yqCRbPnTyaq/jQMTX5FI
         83NK5oRrVX75tWQ8OHoXnVo3YbjNFq5FdsBk06LRodEwdbwj1gp0e0KA5sm0L79puMlg
         40SEFhYAZNlYpp66JiVmydbWCoga+owsImvGa4kdXEnnXiyIg7sLR3RrYUoxoeaevm6r
         PCaapCY+TlDy8IDh7UgXPUpd92e9fL6uD/zqdV06wz4cKac/CllonmvCBwWsCQ0fsXE6
         8mdDoQdFhmEuUeUR9qHYHyOdOQK/Qu2OyDwuNmlvwWwVhrHItI8hqlmaAlE9EQSsRK2b
         QjRA==
X-Forwarded-Encrypted: i=1; AJvYcCVS+3ltlhMZyaiLIpljp5f4FSPNCSkjkg1U5d48FVXI/H4uFMZwgB9gO4l38JNBOJF/qjFXZSxqrPuQR2K4G6I1@vger.kernel.org, AJvYcCXpporVZEk8qng3l/U4nQl+r7IVfjs3R9pySPwkoRnmqsQCH0gkbJjP4R5N5BOOA7CkTiO7aCoh2rN7jg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG83DuDLeUGIrBpLLyP6EM4GvafJS832OQTm+mPI2gPckWty+a
	1YMuBDQZZq42t5lBQX4IxAC4NnpEvT18iJ+yqyIbpxVpJ4OlhrL6IOUqGat9+lM=
X-Gm-Gg: ASbGnctwYPECpzqIeC4Ku5E3mxuYVzdOqeSsSpuhqTK8GJbY2rxHQL7PvUEYVOt9xqy
	cm2z/imrpRIbeqaQ0sWB3e1yfcq2vZUXR4lkbyPPOtMvsnG5+j4UNGXlC7XVQ710HEwf3QgMVL5
	a3lzx78rbOHcojkueP3qOuZsfo6ItDrlJQxEcepOkrPx0rPxc7bDgIJV6Cjp8MJ2UQk4QrhNzAT
	Wgkyp3KTfu+Cy4aKifWvG4LzaI1H8zLrH0xpiBaErsoQrP3xg4TUQI9pp63mW8H1fXCbzRxPmHr
	2BWThqTaz+1zhBO0akUdcFHDgFB2/G5qykQP0EfpGeGfS2edbRtqQcH9BX8s4XuBPJ0=
X-Google-Smtp-Source: AGHT+IGCKCP58Au7POQ5+P4R8NPFSZly8QjaikPhj6dM5ZcGsyMPEmvswiQqFeiZ2UjvRbib422I4Q==
X-Received: by 2002:a05:6214:2584:b0:6e8:fb7e:d335 with SMTP id 6a1803df08f44-6e9004df813mr40029296d6.0.1741346868300;
        Fri, 07 Mar 2025 03:27:48 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 06:27:34 -0500
Subject: [PATCH v9 1/6] scanf: implicate test line in failure messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-scanf-kunit-convert-v9-1-b98820fa39ff@gmail.com>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
In-Reply-To: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
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

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/test_scanf.c | 66 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 44f8508c9d88..e65b10c3dc11 100644
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
+static void __scanf(6, 8) __init
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


