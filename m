Return-Path: <linux-kselftest+bounces-28486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D5A566BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC11188AB57
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C3A2192EB;
	Fri,  7 Mar 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuZ7/pji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94D218AC4;
	Fri,  7 Mar 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346883; cv=none; b=IpU8ZCNKv3+M/Dfh4X+gj/Y8oEdo02M7+10fnjymPpJiLXL/MBSrLnS1rEewhDlhqqWWDg3R4Mb4mQBF95B70oz6ktZZAaqM+Zu5LpkonuMD3kgQjWzQlhxn3xjKnLMsVIcSiTwPXXdl4xDqgV9/U8xRQI6W1udw/Ot1LtKRiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346883; c=relaxed/simple;
	bh=WMRpjACzk4VO0An9XD7k3Ws5EqbeN/Qdyl5iBDK/vAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzXhNqjJVm9zfY0JB4QFwrFXyuao0kGlVi3uaM8ieeLef4yaIR/kbaS4kxWKUTFiCuWknVdK9SCP5NJktM0HKVN5IORELUYDPbEKe2FJCxMJRjbVR/bp91MPR4lB4xSK5Ufl1+mwpPgsHzY8VPJ8kYeIsGosCxqn8z1LUlg9EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuZ7/pji; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd01781b56so19059466d6.0;
        Fri, 07 Mar 2025 03:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346879; x=1741951679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayI/af+TSyQ1KE77y+2nHn400A/mD2p9rOFZzbDzfrs=;
        b=VuZ7/pji+c1AKvxUWvvEEG4aCNvzoyWC02r6qsaOtZvA6Y2rSBIRL1DOV+tZzTVBRa
         0/NHjpdfjfE4ZIfXsV6r5yh0v43h5D/JTePLDMiH+F2SfucCudWM/EKKbe2S6nPJ7ZIu
         iWgge5RH0P/uW2dN9npv0B6NwXyHTuz8KCASfdJK/Woihc/9MkLYM3xMqUpjINbQvRYh
         hwBwWvAlZr3Rjw5aZ9Z3nxaoIsz46fONHj0/oxwik83KO0lOR9u+do+Z1Sm2rrcPgqC9
         RLu0ygX2iZxf9aWfN0T0wvLKeGULnNy7jI33s9eFOUgK4jCUIftzmYgrtE0GHQCIyUR/
         nxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346879; x=1741951679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayI/af+TSyQ1KE77y+2nHn400A/mD2p9rOFZzbDzfrs=;
        b=lVbxriRRNp5wYCyrZ+jCImpn/jZoh5zY8sVoZRsXqxMQyWuD7Fy7tW6NIFwZ5c0q1t
         BFrIxugUaatYHtbN520l0KBx4W4jbKjyg6hvHRGZm+fjg4siSt1xOc+nzsTC7O9FyoVw
         yhbSKT44bpqcrY42s6cXkapsf9In2+fyX07XHWoL7T92HWLyf3sd9grh9zgoAcDvIh1p
         uuyWWjNLCqqyef1//rJPMlB+YYBFGGnHGCo8DOsTrGgwDUtKRT4OOqMjpiFuh5bPXZjW
         4CJwYGYFOu8jq0SXDfVd5PBsPlGIXRS0T8M0uOxvoHwU3oRcAavOFpjIlJVi9l63oa3B
         4IHg==
X-Forwarded-Encrypted: i=1; AJvYcCU68KgCHVcgLkqNv1tWYTpDbQJWpnwxs6VxL7F7vG0cvo0Kl1DxRmux+rEM/YkTioLaS28M55X9xMyZw4T3iz/m@vger.kernel.org, AJvYcCUcL4em76cxZW8e4CdYckdtk52Cgs8AO53GQKw2WcpoqTw4uX6AbSwhHOZteWEN0wannDRC2tG+pG/3PIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBlx3ub7mIQfRv+uKTRxR7Hd5aAVZ60dbJ2/G9TXPsf3RFfWV
	pghGh0HsWK99H1DFMJJCsHRKjH2mHmgPfv0P0/Z3BbnRKwZx0HGbuD3lS6jd7EI=
X-Gm-Gg: ASbGnctHQ6WGNIQRQFt5KAipvcORLlH4TTK+g3Th/1Ve115xVF1ddqRwEOsHxZax8Gz
	eTZYVfTRW34DEH2Lxr7zdmxoq2zFIbeDzv1g9PsNU92Xc7pYqqJnd5uDxxPTWbEEuXpDU+ABJUI
	k48DTkNT6SN3CWrz9BqEvmBeEkKlLpjM4KJQoxrjna3+xROQ5ZSC2k9FRIZfX23NEunMlXIGtcB
	WkekyAo9986qTgYoNcsEB6MrZ3D5tGw6GiCpDkByHUM6GLVDpv1urA7loH+yD8LClctSXMMBtxG
	ZGFwwvBUmAIkbO/K5H23PBArrMZ9wuYJZ700nRe49KfI5jaCc8+7SBUIRaMAsMiBpTs=
X-Google-Smtp-Source: AGHT+IHwrYuYUInVetAgUWMiXJhkVXRVylqnhUV+4QY+2mH3K0buQDTc+qLsoHa7qXkQOV2kdyXJNQ==
X-Received: by 2002:a05:6214:212b:b0:6e4:4393:de7 with SMTP id 6a1803df08f44-6e9005b5e1emr30380416d6.2.1741346879049;
        Fri, 07 Mar 2025 03:27:59 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:57 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 06:27:39 -0500
Subject: [PATCH v9 6/6] scanf: further break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-scanf-kunit-convert-v9-6-b98820fa39ff@gmail.com>
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

This gives us more granular test output.

Output before:

> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: scanf
>     # module: scanf_kunit
>     1..10
>     ok 1 numbers_simple
>         KTAP version 1
>         # Subtest: numbers_list
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list: pass:5 fail:0 skip:0 total:5
>     ok 2 numbers_list
>         KTAP version 1
>         # Subtest: numbers_list_field_width_typemax
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_typemax: pass:5 fail:0 skip:0 total:5
>     ok 3 numbers_list_field_width_typemax
>         KTAP version 1
>         # Subtest: numbers_list_field_width_val_width
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_val_width: pass:5 fail:0 skip:0 total:5
>     ok 4 numbers_list_field_width_val_width
>     ok 5 numbers_slice
>     ok 6 numbers_prefix_overflow
>     ok 7 test_simple_strtoull
>     ok 8 test_simple_strtoll
>     ok 9 test_simple_strtoul
>     ok 10 test_simple_strtol
> # scanf: pass:10 fail:0 skip:0 total:10
> # Totals: pass:22 fail:0 skip:0 total:22
> ok 1 scanf

Output after:

> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: scanf
>     # module: scanf_kunit
>     1..21
>     ok 1 numbers_simple
>         KTAP version 1
>         # Subtest: numbers_list_ll
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_ll: pass:5 fail:0 skip:0 total:5
>     ok 2 numbers_list_ll
>         KTAP version 1
>         # Subtest: numbers_list_l
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_l: pass:5 fail:0 skip:0 total:5
>     ok 3 numbers_list_l
>         KTAP version 1
>         # Subtest: numbers_list_d
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_d: pass:5 fail:0 skip:0 total:5
>     ok 4 numbers_list_d
>         KTAP version 1
>         # Subtest: numbers_list_h
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_h: pass:5 fail:0 skip:0 total:5
>     ok 5 numbers_list_h
>         KTAP version 1
>         # Subtest: numbers_list_hh
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_hh: pass:5 fail:0 skip:0 total:5
>     ok 6 numbers_list_hh
>         KTAP version 1
>         # Subtest: numbers_list_field_width_ll
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_ll: pass:5 fail:0 skip:0 total:5
>     ok 7 numbers_list_field_width_ll
>         KTAP version 1
>         # Subtest: numbers_list_field_width_l
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_l: pass:5 fail:0 skip:0 total:5
>     ok 8 numbers_list_field_width_l
>         KTAP version 1
>         # Subtest: numbers_list_field_width_d
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_d: pass:5 fail:0 skip:0 total:5
>     ok 9 numbers_list_field_width_d
>         KTAP version 1
>         # Subtest: numbers_list_field_width_h
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_h: pass:5 fail:0 skip:0 total:5
>     ok 10 numbers_list_field_width_h
>         KTAP version 1
>         # Subtest: numbers_list_field_width_hh
>         ok 1 " "
>         ok 2 ":"
>         ok 3 ","
>         ok 4 "-"
>         ok 5 "/"
>     # numbers_list_field_width_hh: pass:5 fail:0 skip:0 total:5
>     ok 11 numbers_list_field_width_hh
>         KTAP version 1
>         # Subtest: numbers_list_field_width_val_ll
>         ok 1 ""
>         ok 2 " "
>         ok 3 ":"
>         ok 4 ","
>         ok 5 "-"
>         ok 6 "/"
>     # numbers_list_field_width_val_ll: pass:6 fail:0 skip:0 total:6
>     ok 12 numbers_list_field_width_val_ll
>         KTAP version 1
>         # Subtest: numbers_list_field_width_val_l
>         ok 1 ""
>         ok 2 " "
>         ok 3 ":"
>         ok 4 ","
>         ok 5 "-"
>         ok 6 "/"
>     # numbers_list_field_width_val_l: pass:6 fail:0 skip:0 total:6
>     ok 13 numbers_list_field_width_val_l
>         KTAP version 1
>         # Subtest: numbers_list_field_width_val_d
>         ok 1 ""
>         ok 2 " "
>         ok 3 ":"
>         ok 4 ","
>         ok 5 "-"
>         ok 6 "/"
>     # numbers_list_field_width_val_d: pass:6 fail:0 skip:0 total:6
>     ok 14 numbers_list_field_width_val_d
>         KTAP version 1
>         # Subtest: numbers_list_field_width_val_h
>         ok 1 ""
>         ok 2 " "
>         ok 3 ":"
>         ok 4 ","
>         ok 5 "-"
>         ok 6 "/"
>     # numbers_list_field_width_val_h: pass:6 fail:0 skip:0 total:6
>     ok 15 numbers_list_field_width_val_h
>         KTAP version 1
>         # Subtest: numbers_list_field_width_val_hh
>         ok 1 ""
>         ok 2 " "
>         ok 3 ":"
>         ok 4 ","
>         ok 5 "-"
>         ok 6 "/"
>     # numbers_list_field_width_val_hh: pass:6 fail:0 skip:0 total:6
>     ok 16 numbers_list_field_width_val_hh
>     ok 17 numbers_prefix_overflow
>     ok 18 test_simple_strtoull
>     ok 19 test_simple_strtoll
>     ok 20 test_simple_strtoul
>     ok 21 test_simple_strtol
> # scanf: pass:21 fail:0 skip:0 total:21
> # Totals: pass:86 fail:0 skip:0 total:86
> ok 1 scanf

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/tests/scanf_kunit.c | 170 ++++++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 76 deletions(-)

diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
index d96d7ca85b52..2193937039a4 100644
--- a/lib/tests/scanf_kunit.c
+++ b/lib/tests/scanf_kunit.c
@@ -383,8 +383,11 @@ do {										\
 	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
 } while (0)
 
-static void numbers_list_ll(struct kunit *test, const char *delim)
+static void numbers_list_ll(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
 	numbers_list_8(long long,	   "%lld",   delim, "lld", check_ll);
 	numbers_list_8(long long,	   "%lld",   delim, "lli", check_ll);
@@ -393,8 +396,11 @@ static void numbers_list_ll(struct kunit *test, const char *delim)
 	numbers_list_8(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void numbers_list_l(struct kunit *test, const char *delim)
+static void numbers_list_l(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_8(unsigned long,	   "%lu",    delim, "lu", check_ulong);
 	numbers_list_8(long,		   "%ld",    delim, "ld", check_long);
 	numbers_list_8(long,		   "%ld",    delim, "li", check_long);
@@ -403,8 +409,11 @@ static void numbers_list_l(struct kunit *test, const char *delim)
 	numbers_list_8(long,		   "0x%lx",  delim, "li", check_long);
 }
 
-static void numbers_list_d(struct kunit *test, const char *delim)
+static void numbers_list_d(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_8(unsigned int,	   "%u",     delim, "u", check_uint);
 	numbers_list_8(int,		   "%d",     delim, "d", check_int);
 	numbers_list_8(int,		   "%d",     delim, "i", check_int);
@@ -413,8 +422,11 @@ static void numbers_list_d(struct kunit *test, const char *delim)
 	numbers_list_8(int,		   "0x%x",   delim, "i", check_int);
 }
 
-static void numbers_list_h(struct kunit *test, const char *delim)
+static void numbers_list_h(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_8(unsigned short,	   "%hu",    delim, "hu", check_ushort);
 	numbers_list_8(short,		   "%hd",    delim, "hd", check_short);
 	numbers_list_8(short,		   "%hd",    delim, "hi", check_short);
@@ -423,8 +435,11 @@ static void numbers_list_h(struct kunit *test, const char *delim)
 	numbers_list_8(short,		   "0x%hx",  delim, "hi", check_short);
 }
 
-static void numbers_list_hh(struct kunit *test, const char *delim)
+static void numbers_list_hh(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_8(unsigned char,	   "%hhu",   delim, "hhu", check_uchar);
 	numbers_list_8(signed char,	   "%hhd",   delim, "hhd", check_char);
 	numbers_list_8(signed char,	   "%hhd",   delim, "hhi", check_char);
@@ -433,20 +448,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
 	numbers_list_8(signed char,	   "0x%hhx", delim, "hhi", check_char);
 }
 
-static void numbers_list(struct kunit *test)
+static void numbers_list_field_width_ll(struct kunit *test)
 {
 	const char * const *param = test->param_value;
 	const char *delim = *param;
 
-	numbers_list_ll(test, delim);
-	numbers_list_l(test, delim);
-	numbers_list_d(test, delim);
-	numbers_list_h(test, delim);
-	numbers_list_hh(test, delim);
-}
-
-static void numbers_list_field_width_ll(struct kunit *test, const char *delim)
-{
 	numbers_list_fix_width(unsigned long long, "%llu",   delim, 20, "llu", check_ull);
 	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lld", check_ll);
 	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lli", check_ll);
@@ -455,8 +461,11 @@ static void numbers_list_field_width_ll(struct kunit *test, const char *delim)
 	numbers_list_fix_width(long long,	   "0x%llx", delim, 18, "lli", check_ll);
 }
 
-static void numbers_list_field_width_l(struct kunit *test, const char *delim)
+static void numbers_list_field_width_l(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 #if BITS_PER_LONG == 64
 	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 20, "lu", check_ulong);
 	numbers_list_fix_width(long,		"%ld",	     delim, 20, "ld", check_long);
@@ -474,8 +483,11 @@ static void numbers_list_field_width_l(struct kunit *test, const char *delim)
 #endif
 }
 
-static void numbers_list_field_width_d(struct kunit *test, const char *delim)
+static void numbers_list_field_width_d(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_fix_width(unsigned int,	"%u",	     delim, 10, "u", check_uint);
 	numbers_list_fix_width(int,		"%d",	     delim, 11, "d", check_int);
 	numbers_list_fix_width(int,		"%d",	     delim, 11, "i", check_int);
@@ -484,8 +496,11 @@ static void numbers_list_field_width_d(struct kunit *test, const char *delim)
 	numbers_list_fix_width(int,		"0x%x",	     delim, 10, "i", check_int);
 }
 
-static void numbers_list_field_width_h(struct kunit *test, const char *delim)
+static void numbers_list_field_width_h(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_fix_width(unsigned short,	"%hu",	     delim, 5, "hu", check_ushort);
 	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hd", check_short);
 	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hi", check_short);
@@ -494,8 +509,11 @@ static void numbers_list_field_width_h(struct kunit *test, const char *delim)
 	numbers_list_fix_width(short,		"0x%hx",     delim, 6, "hi", check_short);
 }
 
-static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
+static void numbers_list_field_width_hh(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_fix_width(unsigned char,	"%hhu",	     delim, 3, "hhu", check_uchar);
 	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhd", check_char);
 	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhi", check_char);
@@ -504,24 +522,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
 	numbers_list_fix_width(signed char,	"0x%hhx",    delim, 4, "hhi", check_char);
 }
 
-/*
- * List of numbers separated by delim. Each field width specifier is the
- * maximum possible digits for the given type and base.
- */
-static void numbers_list_field_width_typemax(struct kunit *test)
+static void numbers_list_field_width_val_ll(struct kunit *test)
 {
 	const char * const *param = test->param_value;
 	const char *delim = *param;
 
-	numbers_list_field_width_ll(test, delim);
-	numbers_list_field_width_l(test, delim);
-	numbers_list_field_width_d(test, delim);
-	numbers_list_field_width_h(test, delim);
-	numbers_list_field_width_hh(test, delim);
-}
-
-static void numbers_list_field_width_val_ll(struct kunit *test, const char *delim)
-{
 	numbers_list_val_width(unsigned long long, "%llu",   delim, "llu", check_ull);
 	numbers_list_val_width(long long,	   "%lld",   delim, "lld", check_ll);
 	numbers_list_val_width(long long,	   "%lld",   delim, "lli", check_ll);
@@ -530,8 +535,11 @@ static void numbers_list_field_width_val_ll(struct kunit *test, const char *deli
 	numbers_list_val_width(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void numbers_list_field_width_val_l(struct kunit *test, const char *delim)
+static void numbers_list_field_width_val_l(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_val_width(unsigned long,	"%lu",	     delim, "lu", check_ulong);
 	numbers_list_val_width(long,		"%ld",	     delim, "ld", check_long);
 	numbers_list_val_width(long,		"%ld",	     delim, "li", check_long);
@@ -540,8 +548,11 @@ static void numbers_list_field_width_val_l(struct kunit *test, const char *delim
 	numbers_list_val_width(long,		"0x%lx",     delim, "li", check_long);
 }
 
-static void numbers_list_field_width_val_d(struct kunit *test, const char *delim)
+static void numbers_list_field_width_val_d(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_val_width(unsigned int,	"%u",	     delim, "u", check_uint);
 	numbers_list_val_width(int,		"%d",	     delim, "d", check_int);
 	numbers_list_val_width(int,		"%d",	     delim, "i", check_int);
@@ -550,8 +561,11 @@ static void numbers_list_field_width_val_d(struct kunit *test, const char *delim
 	numbers_list_val_width(int,		"0x%x",	     delim, "i", check_int);
 }
 
-static void numbers_list_field_width_val_h(struct kunit *test, const char *delim)
+static void numbers_list_field_width_val_h(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
 	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
 	numbers_list_val_width(short,		"%hd",	     delim, "hi", check_short);
@@ -560,8 +574,11 @@ static void numbers_list_field_width_val_h(struct kunit *test, const char *delim
 	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
 }
 
-static void numbers_list_field_width_val_hh(struct kunit *test, const char *delim)
+static void numbers_list_field_width_val_hh(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_val_width(unsigned char,	"%hhu",	     delim, "hhu", check_uchar);
 	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhd", check_char);
 	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhi", check_char);
@@ -570,38 +587,6 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
 	numbers_list_val_width(signed char,	"0x%hhx",    delim, "hhi", check_char);
 }
 
-/*
- * List of numbers separated by delim. Each field width specifier is the
- * exact length of the corresponding value digits in the string being scanned.
- */
-static void numbers_list_field_width_val_width(struct kunit *test)
-{
-	const char * const *param = test->param_value;
-	const char *delim = *param;
-
-	numbers_list_field_width_val_ll(test, delim);
-	numbers_list_field_width_val_l(test, delim);
-	numbers_list_field_width_val_d(test, delim);
-	numbers_list_field_width_val_h(test, delim);
-	numbers_list_field_width_val_hh(test, delim);
-}
-
-/*
- * Slice a continuous string of digits without field delimiters, containing
- * numbers of varying length, using the field width to extract each group
- * of digits. For example the hex values c0,3,bf01,303 would have a
- * string representation of "c03bf01303" and extracted with "%2x%1x%4x%3x".
- */
-static void numbers_slice(struct kunit *test)
-{
-	const char *delim = "";
-
-	KUNIT_ASSERT_PTR_EQ(test, test->param_value, NULL);
-	test->param_value = &delim;
-
-	numbers_list_field_width_val_width(test);
-}
-
 #define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
 do {										\
 	const T expect[2] = { expect0, expect1 };				\
@@ -758,16 +743,49 @@ static void number_delimiter_param_desc(const char * const *param,
 
 KUNIT_ARRAY_PARAM(number_delimiters, number_delimiters, number_delimiter_param_desc);
 
+static const void *optional_number_delimiters_gen_params(const void *prev, char *desc)
+{
+	static const char * const blank = "";
+
+	if (prev == NULL) {
+		number_delimiter_param_desc(&blank, desc);
+		return &blank;
+	}
+	if (prev == &blank)
+		return number_delimiters_gen_params(NULL, desc);
+	return number_delimiters_gen_params(prev, desc);
+}
+
 static struct kunit_case scanf_test_cases[] = {
 	KUNIT_CASE(numbers_simple),
 	/* String with multiple numbers separated by delimiter. */
-	KUNIT_CASE_PARAM(numbers_list, number_delimiters_gen_params),
-	/* Field width may be longer than actual field digits. */
-	KUNIT_CASE_PARAM(numbers_list_field_width_typemax, number_delimiters_gen_params),
-	/* Each field width exactly length of actual field digits. */
-	KUNIT_CASE_PARAM(numbers_list_field_width_val_width, number_delimiters_gen_params),
-	/* Slice continuous sequence of digits using field widths. */
-	KUNIT_CASE(numbers_slice),
+	KUNIT_CASE_PARAM(numbers_list_ll, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_l, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_d, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_h, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_hh, number_delimiters_gen_params),
+
+	/*
+	 * Lists of numbers separated by delim. Each field width specifier is the
+	 * maximum possible digits for the given type and base.
+	 */
+	KUNIT_CASE_PARAM(numbers_list_field_width_ll, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_l, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_d, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_h, number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_hh, number_delimiters_gen_params),
+
+	/*
+	 * Lists of numbers separated by delim. Each field width specifier is the
+	 * exact length of the corresponding value digits in the string being scanned.
+	 * The empty string is included in the list of delimiters.
+	 */
+	KUNIT_CASE_PARAM(numbers_list_field_width_val_ll, optional_number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_val_l, optional_number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_val_d, optional_number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_val_h, optional_number_delimiters_gen_params),
+	KUNIT_CASE_PARAM(numbers_list_field_width_val_hh, optional_number_delimiters_gen_params),
+
 	KUNIT_CASE(numbers_prefix_overflow),
 
 	KUNIT_CASE(test_simple_strtoull),

-- 
2.48.1


