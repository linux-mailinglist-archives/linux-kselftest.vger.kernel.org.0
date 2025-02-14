Return-Path: <linux-kselftest+bounces-26669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7AA362E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086B17A4E53
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C67267722;
	Fri, 14 Feb 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyoTGte8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E876267703;
	Fri, 14 Feb 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550020; cv=none; b=MuBc9gQo3hSsZ8jpfNndzNiEplzPIINOgaLv7k5VcaDbqA/HHwmvrGQAQRf8O3LikfwTnylJ0Kk+xSCR3FhnC031QJad5xEx41yI9SBiEmkpOdndnU9AqNMJVKvdtMFjy+/75drE6MixRbimQHkVcZZB8TGIn3aPI4UcfEeDDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550020; c=relaxed/simple;
	bh=w04qy4Y0Et0Rg+GX4a15bfGYKtii9SVsChClczIe+/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdXFaGtD7aSZd9ndOTEovNIJmfwuPWfYWRPqC62OcMOYZ7KMNhkdYtSWMVdGGzvNWa59wtR1pbfd7szbJ0csl+n2ur+TnKahPndN0+zACVXs4W7pFBmpqbfcdNQdDnW7yYt3ha5tjGk/q218FALcRBQPhv8G6fBVua7/tEFhr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyoTGte8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471b5372730so25927151cf.1;
        Fri, 14 Feb 2025 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550017; x=1740154817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQ1dqGAKYKMBZVkr6E0w87TNxfEIiyY2O6Uuan8/TUM=;
        b=iyoTGte8dndlvrxwmXbn8WpDdk6K4Offp3A4buNWyjKpmS9pXHO/GbUuoDCU0E0WA6
         ZtqBkp27vWUkB8PxNKmSgosQW4ye1LbGniKFh2G9uKEFV6WQMtU7nGuSSFMU76yhYk8x
         2ASRtOY9f463+6gCiBb0yYbLFuNgq9+qTjrl3lzKLI+goFhR0vfi01eu+jyXfJC9BceO
         cl5EYCgBD90RIXwvB3nimBbRf2bCdij5zqN5U5f4UbaEv11FW5wiwayAJKLsdXJqdkid
         Za/F5pj3kR1+osJo+Rbi7N2TdMdCb4nn4K50tysQDSOpQ0xt87tMpq8XL43qXHQ/Su0X
         zvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550017; x=1740154817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ1dqGAKYKMBZVkr6E0w87TNxfEIiyY2O6Uuan8/TUM=;
        b=RNFeyQ/6/gWXBZd9Vm198iFA7i+govJwLMVv7hCMhj1vRlqhp1iyWG8h/263VVwZo1
         cTNpzri27lLtWiiKbYUnCCftAj6ze1G2l2quqy3158amJodwYoqwurV4cuU4Ij2mPs8l
         rkdCDVLVyaMJASDKzHP44kCcRpRli/ykpZYTjiurRDvIzW/snpF9pelOrw5sZN2hXZyJ
         mpbhqyNKDsKRGTuWRXMlRtRBdH6CI43++LXv1Q1UJWbbsYC6E1NG3GX7IDhogE2h4XEc
         s3u8CweLyWYsXlyKnbDIyUSH7BOn/RQ96h0JLCruLtNyDtytbwsCemQAwSIdjz4fRezO
         bHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV07GcsNu8aTKnHw8JLVcih03viTe9SxCp2wClhzG8vqp1f1porxozh3a9CSnaqP48IOJ0eDgsa6Zm78uA=@vger.kernel.org, AJvYcCWNosSIjekwuGpcV+AEotiK2W/gsE281zSPHcgKYj775YUVR19VZujANd6GYoFiyc/WuURRxVUzBVU0hY9+yxpj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6dwPcr9KDD3POlb4FPv6zcgw7XJ+FokuM+Lr+ebOCEIOAbSF
	p6W/4gbc9tUUXlRgt7JheB6R07stZ5q2apFDC31C4SzFDVmDJic1
X-Gm-Gg: ASbGncvE69JdLQXFX7SAKIr4sV114WAzZyoLbvfD2uQl+ZfR74CwALIJC9SlwXwb6/S
	SSTPiJvD5YEc8fQFiqky1HSHdyjDTQWPpu/QGAo3f2pkd3ZtRVK0DrTuaimFQNMp8kp1GnLuffe
	nGVTif/SvPOdzWNfloeRkTiYV2sxYKVW2et09FYwdOKxme1oD39TYDXLlheUBeMnZe32wnhgrhM
	CAmQrsxVmSyvAbO6FzqOlG34bgIT69+p7lJvwsmEYSd/0WOcwLd4HytyHrBjPGHcKDlgAd/5oCH
	3E8ChCik79bLci8Dn/T6EVUYhLXY+SisSLL6WQ==
X-Google-Smtp-Source: AGHT+IEtGCLolLmoRwa5yC6C8RqZL3fVb/Jwme6jD923Jj3vW+H7s5w4ZUBfA0G1cPEvrszj7sfe0A==
X-Received: by 2002:a05:622a:14c9:b0:471:b192:16d1 with SMTP id d75a77b69052e-471bed86dd8mr122838891cf.30.1739550017129;
        Fri, 14 Feb 2025 08:20:17 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37c7sm19196911cf.61.2025.02.14.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:20:16 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 11:19:59 -0500
Subject: [PATCH v8 2/4] scanf: remove redundant debug logs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-scanf-kunit-convert-v8-2-5ea50f95f83c@gmail.com>
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

Remove `pr_debug` calls which emit information already contained in
`pr_warn` calls that occur on test failure. This reduces unhelpful test
verbosity.

Note that a `pr_debug` removed from `_check_numbers_template` appears to
have been the only guard against silent false positives, but in fact
this condition is handled in `_test`; it is only possible for `n_args`
to be `0` in `_check_numbers_template` if the test explicitly expects it
*and* `vsscanf` returns `0`, matching the expectation.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/test_scanf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index d1664e0d0138..efdde6f498d9 100644
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


