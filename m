Return-Path: <linux-kselftest+bounces-28482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A946A566B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5FD189A919
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AF62185AB;
	Fri,  7 Mar 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niOnerZ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E155217F40;
	Fri,  7 Mar 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346874; cv=none; b=UXwOn8nvTKMoeIExudEc8wA7/X/0bz0WjUhhDpLofdpa+HDC6VgqItY8grM1/o+xvRryim4/v6vgTh5c0hdDIka3rS+3lNK8WcC7Bxompf7nGqeFmT6T4nc4jT+lchFvVx8tB8g9fnqwCYGAehfq+hlWr/pyFOLbFnt7HhK6iGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346874; c=relaxed/simple;
	bh=n9gPbH2KRGPAhOb7xFcYWxt07vCwPYapd6uXvy48A6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvfK2d02jzgY5aUsv1X9h+Vj4rimByMFp2yuwfAiXQFir1H6XuIh7RqETy/bQfhx6zLaYw80rvVIM7m+vExaosQzh996CSDtRDbCxOQ/wxxMw6x+KV+KW3TWgs1oanO6jrMPKWBu8NjFeupcar9UWstcSRCzG/Z3NyAbLVcVTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niOnerZ4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fce04655so10400586d6.3;
        Fri, 07 Mar 2025 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346871; x=1741951671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNlOIuhqf+m77H9e5k86VtJMdPB8YXoMMeSA64b6Md0=;
        b=niOnerZ4OvYtgR4qvPnKNh+IYZ7UEfLdvvmvZ3LPdHTEdMrKBKpAvohfnA3oy9Sbud
         TA0XGN4SzKyhC/l/Qgtqnl47rizi7MOGMfpTsTA+NdKYMaXi+DaahF7BRCUwWZ+86hZF
         Brbr/XwCYn2vDBf4CD8vTXMheC6FRuB3LoJxbrzVTgctLmQwAC9XY88A/RSps6VezdWB
         4ez5AKhpYosKehAYW7QmaBBIIgX2nykPfcyu/WV2ugKGiTNNXCmTUVXdFeNRTWE4O5AB
         hfVuyGTjKeeJhLbS3erArumKZyZDszr/xNdE7RN8wowtgqzyY7glk256tkdpIb4jOkMs
         Y5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346871; x=1741951671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNlOIuhqf+m77H9e5k86VtJMdPB8YXoMMeSA64b6Md0=;
        b=Bcf7+UdfgEBO5iI9nNGdXOnypRnASUnC9rciNYYw2ot/54u6+5nND4+XaWkKAdn6eS
         yoEwCCfAG3M/05r35YZ3xY2MY9mFDO+AZQ1jAG/XdijcHEUSU283s/pfCtNRTh5lmiAh
         Prl1WT66VAJBK5AlPbS6BSrh9t4QFvP1BTXfFvQBCXGXYmNpZbMhK2/rjFNvaPIXY5je
         UZ/QzbEICN69DDs6TDd54cAwMpGW1J7L/uZhL5Qv9SRxAW16QIfYc7cb/W4u5jn07XIb
         yAo8zmelqh7KOItcwae7C4npmosThjhYbnZi6XKeiE8Rowj8LZXqV/OZVSaPPCECiGoF
         /QJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJCkYc7/U4IDIHBjnUTV+KiIekbsprHSYIK/hJT1wVQRiGW+GFpumgTcVG3ZFLXnhT49De0RK7Obk5Hxs=@vger.kernel.org, AJvYcCWbkIiR8hWYDbUyDkmzEYIcJv/kYd+SGrl8sBQ7Bxy/qgwSPdds91xgP7KOZEAZfpujy6Yl89+HIBPnmhRqhWQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzAojkzTmS7PLjW4WyN9zB5/MJELrX/TupWsqb6Mj44BA4p8vgt
	QoyljqZbFL2GGr6tEYB6FrZUMH7nln/jnP24v/kWjZ09dsegTZdBGQ5WaGIcS1U=
X-Gm-Gg: ASbGncsj48zpJYS6/rBBPlW8ZHfpIa1COvoTDqP/1e/OyL+C6WQUiZa4RjLdxe+tw7O
	xGmlJVqOVYNiJgKBRe8FKih+qSoDo+3hPqgaJjxTHS7HW+OhGZM6qFRy4XT6lplIipYmb++VyXq
	uwYYdhozCCfrB2wcXJ9NLFz5iL7KP8zCjmwzbtjHl/vHCo5s7njXEBokRthl6YmoqUdWGPRh3Vl
	sAKpDSFjkP8A2rhhR60azKG6nwFv/jgLPfet5UGaW9jo2aaeyB9NDOV61KcpsjCHlyGHIKDbwgu
	eO49kN6v1yFAe3tTkZJa+qBxw1nnXPsNqPk3PwF5oAIOdSP1y0DiNZKkUPwy97z3j9Y=
X-Google-Smtp-Source: AGHT+IF50GorM8FtTVkQSHHZeZbovohTOGSrw1UH9q95ZQ6eM053pu/3qfgM3YPUmQVajkH5HhII7g==
X-Received: by 2002:a05:6214:c83:b0:6e8:9dfa:d932 with SMTP id 6a1803df08f44-6e9005f7710mr39023866d6.15.1741346870920;
        Fri, 07 Mar 2025 03:27:50 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 06:27:35 -0500
Subject: [PATCH v9 2/6] scanf: remove redundant debug logs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-scanf-kunit-convert-v9-2-b98820fa39ff@gmail.com>
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

Remove `pr_debug` calls which emit information already contained in
`pr_warn` calls that occur on test failure. This reduces unhelpful test
verbosity.

Note that a `pr_debug` removed from `_check_numbers_template` appears to
have been the only guard against silent false positives, but in fact
this condition is handled in `_test`; it is only possible for `n_args`
to be `0` in `_check_numbers_template` if the test explicitly expects it
*and* `vsscanf` returns `0`, matching the expectation.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/test_scanf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index e65b10c3dc11..cb0b57dc7383 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -62,10 +62,8 @@ _test(const char *file, const int line, check_fn fn, const void *check_data, con
 
 #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
 do {										\
-	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
-		pr_debug("\t" arg_fmt "\n", got);				\
 		if (got != *expect) {						\
 			pr_warn("%s:%d, vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
 				file, line, str, fmt, *expect, got);		\
@@ -689,7 +687,6 @@ do {										\
 	total_tests++;								\
 	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
 	got = (fn)(test_buffer, &endp, base);					\
-	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);	\
 	if (got != (expect)) {							\
 		fail = true;							\
 		pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt "\n", \

-- 
2.48.1


