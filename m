Return-Path: <linux-kselftest+bounces-26354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214AA30AE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6263A24C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CFB22069F;
	Tue, 11 Feb 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OJ9TTkuI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501841F8BBF
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273856; cv=none; b=iKpPQktitS4ExrU4LoT2WaUlMBb50eAarpOBYFQh9IqNQP+8/0zG1n56aLrGRbYFSDzGEwNDwcY6K7BkMP5dkmaRBe6dYD95vKxBognyHRcem5ddhkGP9nhA+8pBtJ7dySESu2nbCorEHcYhD5jJ/X7pL7xwZ9CbT2ijFHKCK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273856; c=relaxed/simple;
	bh=Isw94ovMrGIt7xIhkRscpqDWQBBdqOokXkCb0GLdTv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0hJVXRAXn0AeLvtQxNQ4BKc9kJzfdWVns6wXngttIVwvwRDIxVDCHp6myq14Q1yTEbkwTptEDZOxRtl09Z6yAduhIayU6ArRZwIqRlZ4KHnSqt7SBgZCaPSMPgO/4nMKAYOvX+Rel6LhWT4r6tC903V2x+2pVcfkT+xKTY4o1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OJ9TTkuI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso902974666b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 03:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739273852; x=1739878652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30J+8hnH01ZCyYK4D97nQcb4ktlfTXmAerP39L8FzFQ=;
        b=OJ9TTkuIPTglLl/1UFb/jTLUUof7vLTs9RodqZI1kYs5I1eHnV3VkmuCShrL4+cTSZ
         D4pbTgDmssfVNgwoGLaSUBqsX1oVtI6177YYIheL9ap+MGHCaOQOGI/zHQWTOpucizMo
         jiFJKZHjxBPqroOtOkf1ZC5vt7+kBnBWX7z5Ze3RVi521pZsvKOSrtGnRm1SdXPDUPNl
         /of0ow4vd34TJ8aus3IaGK6sBq6N7Yj8oCsvk0w08h6RfEuCyzvf1gURH51Q3ZAphFib
         sO4s0mTAzbPFSPsO68UT8FsXy5MY5KjkiyEjP3ZweYKzB8IX3Xhx9zCwMR5qdd45V1QD
         KzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273852; x=1739878652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30J+8hnH01ZCyYK4D97nQcb4ktlfTXmAerP39L8FzFQ=;
        b=CV+OXZcTL60NvXq/EMgxwzs2NDRdgC2UdDAO2JrFhtfBJYH5PvUcdD75BM3hcBZFQQ
         9Zgf6vvpnHIpk7+l8K+J3MeTvA+4Q1ggAMo+hmcN/RWEC1G+qpXv/+8sEQmehGaZgg99
         K4RfAfWARhWPstoK8YcmE2f1+vtDukiGOLCIHeIy28HSuJ3g7wFTwHwG5f5WZ+uSB+8S
         lvrZXep8DflsGZj+q9+avTC7mwZbcNzGv/ZGJPcqan+z2syfoLXv+PBJgypIoyw8cdsY
         9D72Y5Mr0mquljDvzJPAp6phNUZvGLndaO5cjBED5FM1kBf50W16fKiKnT5F1lY0er+h
         v0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW8M4TKfH7LtAYQ4Wmogr0mWvAq+nE+FKrEzh3EP5dhQ7z0+Sg2HpJb3ZwhTBPErrhKsVyQQ9xWOhZtq2rkmw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqIC7PskYbSnWJG2fx2pYf8V3z05W84gSBSB16Ua1xKXP/fDQ
	BI/TOj1fvVFCcGEz8EoYseaOvr7eLTHQAz4cbnNpd7whUB0czPhhn3hskBuR3NY=
X-Gm-Gg: ASbGnctuhNfUjWjjIyQS1vlC8EzSKi9CaXay3iOeuDZ0nWLD41oNV3sJ68Sr5rMIVv8
	6ffATJ5rQ+cjKVYJGyQ39L95IXrhnwH6Tglf4NoLGFmIIzUwZHY4Yaut0PgFdIpy+BJ3eZl3h9X
	vM+AD8iikDrwMTMe687DpgefHHbukLAK0plgTUretJ6HTe0neh85oD5ctY37k4HxRc5+32Ug/HQ
	Epo8CLruyrabFlg31RcXTpxXR6rcovuSDBCu4ZiR34hGbnIJv20H0oeUupLk+k7Ifi8V0Mtz/Df
	FQNmoplWUKdabJYrww==
X-Google-Smtp-Source: AGHT+IE/fcC1z7FZ4Uz4GEDftErGuIDd5X/YKScsDrkJqaN8PCBwF76UGye+otvE3nMknKMSl2lxjQ==
X-Received: by 2002:a17:907:6d24:b0:ab7:8507:fcc9 with SMTP id a640c23a62f3a-ab789a67b00mr1802722166b.12.1739273852574;
        Tue, 11 Feb 2025 03:37:32 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de541fb84bsm7279093a12.54.2025.02.11.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:37:31 -0800 (PST)
Date: Tue, 11 Feb 2025 12:37:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] scanf: convert self-test to KUnit
Message-ID: <Z6s2eqh0jkYHntUL@pathway.suse.cz>
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>

On Mon 2025-02-10 13:13:48, Tamir Duberstein wrote:
> Convert the scanf() self-test to a KUnit test.
> 
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
> 
> Acked-by: Petr Mladek <pmladek@suse.com>

Please, remove this. The patchset has changed a lot and it is not
longer true.

> --- a/lib/test_scanf.c
> +++ b/lib/scanf_kunit.c
> @@ -15,67 +13,49 @@
[...]
>  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
>  do {										\
> -	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\
> +	kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);	\

The switch from pr_debug() to kunit_printk() causes printing huge
amount of messages even when the test passes.

[ 5780.664377] KTAP version 1
[ 5780.664891] 1..1
[ 5780.665376]     KTAP version 1
[ 5780.665765]     # Subtest: scanf
[ 5780.666104]     # module: scanf_kunit
[ 5780.666112]     1..10
[ 5780.667354]     # numbers_simple: "0", "%llu" ->
[ 5780.667371]     # numbers_simple:    0
[ 5780.667923]     # numbers_simple: "0", "%llu" ->
[ 5780.668321]     # numbers_simple:    0
[ 5780.668803]     # numbers_simple: "1", "%llu" ->
[ 5780.669175]     # numbers_simple:    1
[ 5780.669624]     # numbers_simple: "18446744073709551615", "%llu" ->

[... skipping 7500+ lines ...]

[ 5783.157777]     # test_simple_strtol: simple_strtol("0x7fffffffffffffff", 0) -> 0x7fffffffffffffff
[ 5783.158229]     # test_simple_strtol: simple_strtol("0x8000000000000001", 0) -> 0x8000000000000001
[ 5783.158683]     # test_simple_strtol: simple_strtol("0x8000000000000000", 0) -> 0x8000000000000000
[ 5783.159131]     # test_simple_strtol: simple_strtol("0x8000000000000000", 0) -> 0x8000000000000000
[ 5783.159586]     # test_simple_strtol: simple_strtol("0x8000000000000001", 0) -> 0x8000000000000001
[ 5783.160048]     # test_simple_strtol: simple_strtol("0x7fffffffffffffff", 0) -> 0x7fffffffffffffff
[ 5783.160506]     # test_simple_strtol: simple_strtol("0xfffffffffffffffe", 0) -> 0xfffffffffffffffe
[ 5783.160957]     # test_simple_strtol: simple_strtol("0x2", 0) -> 0x2
[ 5783.161467]     # test_simple_strtol: simple_strtol("0xffffffffffffffff", 0) -> 0xffffffffffffffff
[ 5783.161806]     # test_simple_strtol: simple_strtol("0x1", 0) -> 0x1
[ 5783.162564]     ok 10 test_simple_strtol
[ 5783.163145] # scanf: pass:10 fail:0 skip:0 total:10
[ 5783.163537] # Totals: pass:22 fail:0 skip:0 total:22
[ 5783.164052] ok 1 scanf


Yes, it would help with debugging. But we should print these details
only when the test fails!

Partial solution might be to use pr_debug(). The messages will be
disabled by default and can be enabled via /sys/kernel/debug/dynamic_debug/control

Here is some POC:

From 7ea79fd67c4a7d8dff9d9fa986bb8dc037087c47 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Tue, 11 Feb 2025 12:24:40 +0100
Subject: [POC] kunit/scanf_knunit: Add kunit_debug() to allow using the
 dynamic debug facility

Do not fill the kernel logbuffer with debug messages by default.
Allow to enable them via /sys/kernel/debug/dynamic_debug/control

The question is whether we want to print them into the kunit log.

FIXME: This use just a POC. The right solution should reduce
       cut&paste.
---
 include/kunit/test.h | 30 ++++++++++++++++++++++++++++++
 lib/scanf_kunit.c    |  6 +++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 58dbab60f853..23fa3d6b3735 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -637,6 +637,36 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 #define kunit_err(test, fmt, ...) \
 	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * pr_debug and log to per-test or per-suite log buffer.  Logging only done
+ * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
+ *
+ * The special variant is needed to allow using the printk dynamic debug
+ * infrastructure, see CONFIG_DYNAMIC_DEBUG.
+ */
+#define kunit_log_debug(test_or_suite, fmt, ...)			\
+	do {								\
+		pr_debug(fmt, ##__VA_ARGS__);				\
+		kunit_log_append((test_or_suite)->log,	fmt,		\
+				 ##__VA_ARGS__);			\
+	} while (0)
+
+#define kunit_printk_debug(test, fmt, ...)				\
+	kunit_log_debug(test, KUNIT_SUBTEST_INDENT "# %s: " fmt,	\
+		  (test)->name,	##__VA_ARGS__)
+
+/**
+ * kunit_debug() - Prints an DEBUG level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints an error level message.
+ */
+#define kunit_debug(test, fmt, ...) \
+	kunit_printk_debug(test, fmt, ##__VA_ARGS__)
+
+
 /*
  * Must be called at the beginning of each KUNIT_*_ASSERTION().
  * Cf. KUNIT_CURRENT_LOC.
diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index 7e2e7d891e41..e45f3c4f0437 100644
--- a/lib/scanf_kunit.c
+++ b/lib/scanf_kunit.c
@@ -42,10 +42,10 @@ _test(struct kunit *test, check_fn fn, const void *check_data, const char *strin
 
 #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
 do {										\
-	kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);	\
+	kunit_debug(test, "\"%s\", \"%s\" ->", str, fmt);	\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
-		kunit_printk(KERN_DEBUG, test, "\t" arg_fmt, got);		\
+		kunit_debug(test, "\t" arg_fmt, got);		\
 		KUNIT_EXPECT_EQ_MSG(test, got, *expect,				\
 				    "vsscanf(\"%s\", \"%s\", ...)", str, fmt);  \
 	}									\
@@ -677,7 +677,7 @@ do {										\
 										\
 	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
 	got = (fn)(test_buffer, &endp, base);					\
-	kunit_printk(KERN_DEBUG, test, #fn "(\"%s\", %d) -> " gen_fmt, test_buffer, base, got);	\
+	kunit_debug(test, #fn "(\"%s\", %d) -> " gen_fmt, test_buffer, base, got); \
 	if (got != (expect)) {							\
 		KUNIT_FAIL(test, #fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt, \
 			   test_buffer, base, got, expect);			\
-- 
2.48.1


But when thinking more about it. I think that even pr_debug() is not
the right solution.

IMHO, we really want to print these details only when the test fails.

Best Regards,
Petr

