Return-Path: <linux-kselftest+bounces-26178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE98A2F09C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB0F167BBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971123C37C;
	Mon, 10 Feb 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEF40A5q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF722E3F8;
	Mon, 10 Feb 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199613; cv=none; b=er9zoGO3lOp83CXNrhkd4P7+ojzNeBkKI5GR6tztpU90xxmJaNhlg6eZ3DdDDUxcShXhh04I8oHNnpQfn9+Sq28HNnbYkFaUZsjTozpIlUcheOBnJ+HQaKPGZaCKxMe3NwpdgXFVuZ1Lyh0ii38isuvm/XHkpnDNb2F6hc6asaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199613; c=relaxed/simple;
	bh=V+Q335CbsCq7NJtWE2GHfskGtPy4agBbvr1NZ5SQ2dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kMZuAll6S3+L8yKKoGEouvjCk6hdhDRDDeXNMwE8JohVU1tm3vkSCi0u8lNMi69WQ+VruSXZxJZegs1KW7lKsDohqCP8Powowxp8heq9NE9Cohb9zGN2Kl3XWqbFJHM2MuvBcmK/dYnMhR/u3HfrG4u81qiiWwOwBhdQ2daRmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEF40A5q; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd43aa1558so34042066d6.0;
        Mon, 10 Feb 2025 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739199608; x=1739804408; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc1qR49KOqu85K8R5u7fUtI38ozpTGSkW1QTQ1KnsZI=;
        b=fEF40A5qVAQDA0XsSLgkhP79TtYhfAotEHBGfvLFlMxUcu43yvlOaRfsoTw9iXe3QI
         RiwsLL3zbPrbkSxlAa8FEgYLfevSib97AEwS9m7LMJXx5385fNq9rdWG4pTiiZ8u+bT5
         yje4RMvBEBKbhu/6bxSrgvP+JedmpMtu1rUW/Dj+fJw8w85uvXd8Weu8N5zfCPqXoDBV
         hFENAcHHE/NjrnDbDbmOrjjfFJyFshKdCQ6GlKgJdSdnDArdNGzT1NwbAVTk9Jc/fcW+
         2ZcilPrbY/rmQGzKcXxGTokQKF7mYUWXazzFPOqX0vXnrHd+zoMOPRnKzBZLrKHk3EWx
         +/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199608; x=1739804408;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc1qR49KOqu85K8R5u7fUtI38ozpTGSkW1QTQ1KnsZI=;
        b=c7oQtxAsNDrTscLDY9U07rB9lO1AdNj4tnoAJMV5Ci5rI3voL5cZidN2cifxfDjMDA
         pUz8eIwQaEm19OBnWXRm2ZgoYbtZZnzCwDEpQPtSt8e9hQ3MY7M5LaBdMa9xK0A2I63V
         ebMvBcHKxu8p6UXCGBaUNS45A1qPDIWcbvCJjYK70GUvejrHTq48kfA7VBaLSPz3shq3
         pxVUlX04EtFiN5KKojg811W0y/DcNb401kPveiiAWQqzxVhxfMSayG9aoc6tbrT4B+Dg
         G+zRads9QOLsnWJkXPOZizsnGzt+7VLCsltKMVIpkkFjoKg2GLxJbRVOgFsytUGmtXFS
         7QSg==
X-Forwarded-Encrypted: i=1; AJvYcCU88iU0p98tHlunwJ6NY/U6GPDklHRVped+Zw5JJJ1rxoGh1BiakwtoLxv/uwExxoQRxeb/g0AjVWgQ60c=@vger.kernel.org, AJvYcCVHHINDJrXQxRe1T7qzE9EFUFlGW8B0LFLh/tFTIv826av8dCXm8wWP05QFMhOa6t3cRwyhf0a7It/a/phOYt+u@vger.kernel.org
X-Gm-Message-State: AOJu0YyY85LujDJcwfPzW2OoNeYgBhbeQgM77OnoSgC9GO19j9T1/yRS
	522D6OMShlAQEQuPbDiDtn4Op1p8E4Gzm0P1d4NDKNpp+zrh0w1P3lEGZNsY
X-Gm-Gg: ASbGncvbLhCNuHF4RJsM9XlMY2Q6C3NOGcijqJJ7yVtAOsXGtdyJRHHqQBG6zWqvt7H
	hgOofRg1mSIS4Zz+czjmpy6vl+2jEsPedsAAE+9RNUTLqiB2QY/4A0dOfoMJMA2YChFLHb1p4D6
	JW+RO04eumx+sIYb8Xmi2+F+8bJSznivk7JVv8aHWiti5fZqcR6i4EQ9EkIZCZ3RZIUvApXVgVA
	vNr/f/dwmNkMeYXf9/1nGQdU5qsPX6BjHWA067QYbbsqg5yWHdMYbL87dJMaIvQFVCf/BEp1/B2
	xzo78HouvcgVVCbqbxwKeGRyrokVKVqli/iW2uJH4uFacwUVqSV9U9JHEI7HsxNMbrVtw8oPuEb
	KGsahU5RmtK3c6mGBGiULL5jy
X-Google-Smtp-Source: AGHT+IGQECCaSqrE1aZsbabVFGEqwI771NatlwDloukiFO8+FbxOgGDx4MHMk3BzJq8/aFdO8mIeTw==
X-Received: by 2002:a05:6214:5297:b0:6d8:af66:6344 with SMTP id 6a1803df08f44-6e4678418e0mr399586d6.2.1739199606844;
        Mon, 10 Feb 2025 07:00:06 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e445c50a10sm38875896d6.91.2025.02.10.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:00:06 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v5 0/2] scanf: convert self-test to KUnit
Date: Mon, 10 Feb 2025 10:00:00 -0500
Message-Id: <20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEUqmcC/33NQW7DIBCF4atErDsRzGDjdtV7VF1gGBKUBFfgo
 laR7x6STa3I6vJ/0nxzFYVz5CLedleRucYSp9Sie9kJd7TpwBB9a4ESO6lIQXE2BTh9pziDm1L
 lPEMw0juicSTtRLv8yhziz0P9+Gx9jGWe8u/jSVX39X+vKlAgX03foQ6SR/t+uNh43rvpIu5ex
 T8DJW0b2Aw0xvZq8IPU/GzQ2tDbBoEEGnpvHDEbpZ8NvTbMtqGbYZEYbbDseVgby7LcAPYARdm
 CAQAA
X-Change-ID: 20250131-scanf-kunit-convert-f70dc33bb34c
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and printf), the rest having been converted to KUnit. In
addition to the enclosed patch, please consider this an RFC on the
removal of the "Test Module" kselftest machinery.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 scanf

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v5:
- Remove extraneous trailing newlines from failure messages.
- Replace `pr_debug` with `kunit_printk`.
- Use static char arrays instead of kmalloc.
- Drop KUnit boilerplate from CONFIG_SCANF_KUNIT_TEST help text.
- Drop arch changes.
- Link to v4: https://lore.kernel.org/r/20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com

Changes in v4:
- Bake `test` into various macros, greatly reducing diff noise.
- Revert control flow changes.
- Link to v3: https://lore.kernel.org/r/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com

Changes in v3:
- Reduce diff noise in lib/Makefile. (Petr Mladek)
- Split `scanf_test` into a few test cases. New output:
  : =================== scanf (10 subtests) ====================
  : [PASSED] numbers_simple
  : ====================== numbers_list  =======================
  : [PASSED] delim=" "
  : [PASSED] delim=":"
  : [PASSED] delim=","
  : [PASSED] delim="-"
  : [PASSED] delim="/"
  : ================== [PASSED] numbers_list ===================
  : ============ numbers_list_field_width_typemax  =============
  : [PASSED] delim=" "
  : [PASSED] delim=":"
  : [PASSED] delim=","
  : [PASSED] delim="-"
  : [PASSED] delim="/"
  : ======== [PASSED] numbers_list_field_width_typemax =========
  : =========== numbers_list_field_width_val_width  ============
  : [PASSED] delim=" "
  : [PASSED] delim=":"
  : [PASSED] delim=","
  : [PASSED] delim="-"
  : [PASSED] delim="/"
  : ======= [PASSED] numbers_list_field_width_val_width ========
  : [PASSED] numbers_slice
  : [PASSED] numbers_prefix_overflow
  : [PASSED] test_simple_strtoull
  : [PASSED] test_simple_strtoll
  : [PASSED] test_simple_strtoul
  : [PASSED] test_simple_strtol
  : ====================== [PASSED] scanf ======================
  : ============================================================
  : Testing complete. Ran 22 tests: passed: 22
  : Elapsed time: 5.517s total, 0.001s configuring, 5.440s building, 0.067s running
- Link to v2: https://lore.kernel.org/r/20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com

Changes in v2:
- Rename lib/{test_scanf.c => scanf_kunit.c}. (Andy Shevchenko)
- Link to v1: https://lore.kernel.org/r/20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com

---
Tamir Duberstein (2):
      scanf: convert self-test to KUnit
      scanf: break kunit into test cases

 MAINTAINERS                          |   2 +-
 lib/Kconfig.debug                    |  12 +-
 lib/Makefile                         |   2 +-
 lib/{test_scanf.c => scanf_kunit.c}  | 278 ++++++++++++++++-------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 7 files changed, 138 insertions(+), 163 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


