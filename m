Return-Path: <linux-kselftest+bounces-26197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704AA2F68F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CBF3A678F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A72566C0;
	Mon, 10 Feb 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5OnN/v9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2ED24FBFC;
	Mon, 10 Feb 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211248; cv=none; b=ultsavv1247xYHRvoWQiTAlURTh5fjEKpPnG89f1STts1iyPFhfrSN7jhxjkyAS/UL0jclNfZ52JdyPOPpLiBcVRNBVbT/Gk48l4txVaI4GbfBMVV2lZ1iCbvqr1sSASi6S7X0DsKWSqjvGbeWZWJ5h1UsDtQz4hDgafgAaKZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211248; c=relaxed/simple;
	bh=nRcH5Hz0q1ullj8yTF8GaEpinRzNK4zRqpuhzpLRTLA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oQQeS6yQJ8ZP73isJrpT00SIkbMAurSriVe687mxa0rhff+A0jgdJBerdMgcujMD8qeZfa2gwlfzG3Ub+EH+++kjfJ8kkw++zGzFTL22Bn9UteUqvGADB3clgoXFs+vs292h8PV6qrhW790EqyjlyTL6y4dVeuEhuEyKj2zo5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5OnN/v9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e454a513a6so17132856d6.3;
        Mon, 10 Feb 2025 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211245; x=1739816045; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwp8UWbY5oQw6Z0KvUX1iraF4vSnDy1XElecNLXTj2o=;
        b=G5OnN/v9PdK9PRlAfFBdNjapznWa24SuNHe/+6hzjzZuLBtZJdTiioSHpV8jFgmk/T
         4dVZoVnvnsISKDOJVgzojHaYozVb++bIbefYceJM8lRmZ2IyblQPjUw8cFIh4jiuPZHC
         HSXe54yzRnPlkSEMh6VErT08OKIT67rAZDKq7KdfpCexB8QUs6QPVU6PYVCcFi8/7055
         AZrGaWWmHpQ7KVK4ijshuFNpHskVDUQjPwlGDyY0HbkF/GWu0ApuidT+7iUDI3Sgs9w7
         OXCQkIk5gri1V2mSMlSKhxb0Q/BINvhCtyhDa5Hht0eky3npFET4lbFA/DDcdQfkOTof
         Ys9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211245; x=1739816045;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwp8UWbY5oQw6Z0KvUX1iraF4vSnDy1XElecNLXTj2o=;
        b=uW8pYH0X86uRGTl8eKedks2nioYf3RambvAE6OONEazogvsUXM9kASkDh8km4FLBFx
         HfHbocTpxGNvvzWeqM6j6s1w4YU8sVC5Y07zD27qM6A3/lKAJownKupm6hZ6biHuj9RO
         jcDFrWcYTG/O7b/+050RhiGYThFVOrDjF9jHvPs9nwH7aS8UhQvKYa2AXCyz7PR+V7aI
         x70aEa0f/JWNJKxn3R5OikCwfQkQxsEh/wnFE2OERmeYKNofoL91YZJWVupaPn3iBwsf
         CNYhyNOaWyBeMZRYHXrld3ar+jSy//Lfqz2/OsH08p4p3ENnGb56gUYRoVg/bAsf841M
         ON7A==
X-Forwarded-Encrypted: i=1; AJvYcCUKW8dUmdiayUgh9Di2zK+uh0ATF4ZhKLkByuRKHiOIP5W6EkrgCz7vfNmegXqgqUCEa2SqaVpAUzgXDXc=@vger.kernel.org, AJvYcCUk7E9w3sVh32mGo2/d3gQd1mPqKdYtz9cPkp9EporKd1TixdX3onhEwA4WBMlse/GwnDYY5w8Jrg4Ot0x6g/WV@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzAvrrDX8dyQhUwUMcrI6fW9r2h0H9BK/v5fjqMG+KQlhOz7J
	haGsLyjsv0kX6vIDUq1EQ1sP6DzzQ1+lqQ9y6itThB0g2KlteBmhRRMs3aBP
X-Gm-Gg: ASbGnctsZ/TuSXRT8uMszPxud2RN0EB/NQfKxjOK2XtLGT4X4jfqnRomithWptn4Kci
	eMFBlZ4A1T+YzLfDiXk+8gKOL7rnuCKY12kM7O+QRE7guDFkx4Y0aj4fxUHj4GThusa7dwB91Od
	5whqhNKHGC2OJHc/UYMCtUVtc420XZ+kigB3JWSDKX3uR1NzJkEtHnHr8OSSaCRUkcx/1ikBuL5
	HKNGa/VaWaZWWM0arvQWZmTKF3GzBVNtf9ty1uafeAtrKwtHl3+EqQ6LR3Mqhi7XI2oaFRKuQFl
	UaT3JDOi5PmRmXodCyLstjLh591JDmsWJUSfcBY5qo4V6K4ihWt/sie3XywN5udPGRW/Mf6Pcjg
	zxT0KguwPkaGofA1pwORUzDHy
X-Google-Smtp-Source: AGHT+IGIsDwXtX0LULH/WyZAs5KYpe6PhK1JPTM4GOC7XoAu1Zxisd0nec40zcPIGLxqm1Oz2IP5qw==
X-Received: by 2002:a05:6214:27ef:b0:6e1:5076:c400 with SMTP id 6a1803df08f44-6e4456f8ccbmr151939326d6.39.1739211245128;
        Mon, 10 Feb 2025 10:14:05 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacbbasm49591376d6.73.2025.02.10.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:14:04 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v6 0/2] scanf: convert self-test to KUnit
Date: Mon, 10 Feb 2025 13:13:47 -0500
Message-Id: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtBqmcC/33NQW7DIBCF4atErEsEDAacVe5RZYFhSFAbHIGLU
 kW+e0k2sSyry/9J882DFMwRCznsHiRjjSWOqYX62BF3semMNPrWRDDRMQ6cFmdToF8/KU7Ujal
 inmjQzDuAYQDpSLu8ZQzx/lI/T60vsUxj/n09qfy5/u9VTjllvVadkIHhYI/nq43fezdeydOr4
 m0IBtuGaIbQ2ipuvGES1wYsDbltAGUUjPLaAaLmcm3IpaG3DdkMKwCFDRY9mrXRLQzOto2uGQa
 VDGC1x75fGvM8/wFhcXDmxgEAAA==
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
Changes in v6:
- s/at boot/at runtime/ for consistency with the printf series.
- Go back to kmalloc. (Geert Uytterhoeven)
- Link to v5: https://lore.kernel.org/r/20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com

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
 lib/{test_scanf.c => scanf_kunit.c}  | 274 +++++++++++++++++------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 7 files changed, 145 insertions(+), 152 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


