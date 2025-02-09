Return-Path: <linux-kselftest+bounces-26127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87822A2DA69
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 03:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EC61886FBC
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E37482;
	Sun,  9 Feb 2025 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="devJUVdk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D4243384;
	Sun,  9 Feb 2025 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739069085; cv=none; b=Jz+lKRHr65ro+0mtROCR4dBf97VxS3f4uu62tS5By+mbLaJVI0UnBZEfKzgRkM36YlxjA4msItyyWXPLxTBzy600go11Z+alrP3xWQKVwdeAWKeBtv0QoiezhgMs/aGug8XNwU7Vzg++g4tbF1L9J8nMmiGqM9CrQ93Fe4iJiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739069085; c=relaxed/simple;
	bh=hugJMx9TMp5sjOHz6mg+YYAbaf3117ciS6HNnyBTTY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UwBczHysUQbO8aRHD4mxJB0kCbNMEa4FMxeSC0b/cAMDcyfe21Z0wUfChzthiXRC5YbnPvwIu/jlKOcHwoq7M5jydw7Z+U46ITVvQvYyt6dFpTwxHjJuD84f89v3l22R/wCjFW9fo4GaBWcSmT38mrmR+z5Zda2KfAy6ngUWlMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=devJUVdk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e41e18137bso28769346d6.1;
        Sat, 08 Feb 2025 18:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739069083; x=1739673883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqum1OHdajLLiOJ40Qf9f/qY6S4g8prcGmnaxi592bc=;
        b=devJUVdki6rmgGXz1iZDVYRPBoMR9ofGQhogPpJFVGguUpwIGN5PRFGDoOtfn+a2e+
         WJjzdm4bqeoFASLF6RpN/jUI8/vZGR4z2bL/IZZ5Fb6Q6TUNcKkMFnPgPIHnOuf2l5rZ
         FJG0FTNTlEBwPJGa4Df0cWep38cOLZoFWTBj5sGSaZl0/qePyLya7M/xfay/0iFHgMRe
         ibaA9I0od/YLnPD6BJXssEuoQoKh/3i7C777d5aHWZloKDE29AeW1KJCeShU+dyedc7J
         +OIekTFWNPX644uQctCMdfIH4LVPci2+ud/HtEZRJYEYQtSCp6xzei3S1xYC3OxpLBzk
         gOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739069083; x=1739673883;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqum1OHdajLLiOJ40Qf9f/qY6S4g8prcGmnaxi592bc=;
        b=o/k5ckW2bxppk3hCoJSjcX28UU9mkqIvwhcws+ufuY3aQ3t+mOZvgFIaikxvs0kb1M
         AVx4L2ZKxu/YITutE/L9uUxEJGWo0IreDj4AUcFULZ2ADJ54stC2mQ5VV/jKkQUbCIzM
         dghjCoTVpsZ5NJ7G2fPsxyEhgRry9VFakq/FcdJbaDggUkwrETJx9nR8QeUnfCw2FTBA
         9yn4XpOj9o6AbK0/r9WUCM1gjCRkzlCmx4jy6s1zDmvqJSNbz2HkBa09z5pNSW4KePsO
         m2OGI55Fv0Atzeyos5wsPM+3hVoEuGbSWY0YCrVgp3eOYBC9nv8KL/UkUk0LdvAfcPMY
         OD2w==
X-Forwarded-Encrypted: i=1; AJvYcCUjR11zPikuAlwGIN9oD9eNlLGMvrv0JC9G+0bM4f8bMxrOhEfenRxEQLZ2oASGQyV26CRtmjIx9CtFNATLTPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zypReS5STZtVpbYePrzpgeAR1YJ3t+nf8oF4JS8lKcu3bAhm
	h0SI7N9LJJfCAATJCKAgOQcr5Rh9/b8RpA9vGJyR9vRhjk9cTWaB
X-Gm-Gg: ASbGncttigTEFISQDT8xCas8rac2gVQyTkBbvkrelL+Nj9Z2qOB0I0YPdPhnt71BrBc
	3NHJuPDWUue+daEe1CSqV6+uU0Nj4YSPNl/YAg8u0GWCO6GVBH7E5jNI+vNXFs4aS0V+dR0OLwk
	TAAKtLN34sgS8T4/j94KaqzEngmzKg4nZEA8luDgt3Z7ezje8vc0DR+VtZDu5so6E9AzOX860ku
	mwq3U5nmRcOX9MAWrWW4jRCHHb2bKhN5hEQwjgQZzZmBiSLcp0PYR/TazWDOFInDguGtnTFUnls
	jCre0m2AFdFXpz8GLxfMs6JQ2pL4CmP2/AOYwTO3mjKohu1bHaVNyltzwFsDMLazl26ntq8K8VB
	wzgpDAMC1OIXFe1GP9+bgLC2mKZ2g8qPzEJhTjQ==
X-Google-Smtp-Source: AGHT+IHv9ounm1lKLXQpVJDDIUZywJElMzXgoi5o1ApiFNUxFU5N6UQgOghhbcL02C3oxU6o/Jh46A==
X-Received: by 2002:a05:6214:5188:b0:6e1:fe68:11c0 with SMTP id 6a1803df08f44-6e4455e6b73mr124703406d6.12.1739069082933;
        Sat, 08 Feb 2025 18:44:42 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e451a83cbcsm11572356d6.102.2025.02.08.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 18:44:41 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v5 0/2] lib/prime_numbers: convert self-test to KUnit
Date: Sat, 08 Feb 2025 21:44:37 -0500
Message-Id: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJUWqGcC/5XNQW7DIBCF4atErEvEAAanq96jqiobxskoNbbAQ
 Y0s3z04KyuLKFn+b/G9mSWMhIl97mYWMVOiIZSoPnbMnZpwRE6+NJNCVkIKy8dIPf6GS99iTPx
 8CTRxN4SMceIW3KFVDjx4zYowRuzo/65//5Q+UZqGeL2fZVjX19wMXHAjjO1ka50F9XXsG/rbu
 6Fnq5vl1qqfW7JYtVEAB60tCv1oqTcstVpd56sajK+9e7T0G5YuljWoTOsaYZpqay3LcgMEWIV
 HqgEAAA==
X-Change-ID: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is a clear example of a unit test.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 math-prime_numbers

On success:
; [08:51:41] ============== math-prime_numbers (1 subtest) ==============
; [08:51:41] [PASSED] prime_numbers_test
; [08:51:41] =============== [PASSED] math-prime_numbers ================
; [08:51:41] ============================================================
; [08:51:41] Testing complete. Ran 1 tests: passed: 1

On failure:
; [08:50:19] ============== math-prime_numbers (1 subtest) ==============
; [08:50:19]     # prime_numbers_test: ASSERTION FAILED at lib/math/tests/prime_numbers_kunit.c:28
; [08:50:19]     Expected slow == fast, but
; [08:50:19]         slow == 0 (0x0)
; [08:50:19]         fast == 1 (0x1)
; [08:50:19] is-prime(2)
; [08:50:19] [FAILED] prime_numbers_test
; [08:50:19] # module: prime_numbers_kunit
; [08:50:19] # math-prime_numbers: primes.{last=61, .sz=64, .primes[]=...x28208a20a08a28ac} = 2-3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61
; [08:50:19] =============== [FAILED] math-prime_numbers ================
; [08:50:19] ============================================================
; [08:50:19] Testing complete. Ran 1 tests: failed: 1

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v5:
- Rebase against mm/mm-everything.
- Correctly EXPORT_SYMBOL(with_primes).
- Link to v4: https://lore.kernel.org/r/20250208-prime_numbers-kunit-convert-v4-0-76e36bca06a5@gmail.com

Apologies for the churn.

Changes in v4:
- Use `#if IS_ENABLED` to handle `CONFIG_PRIME_NUMBERS_KUNIT_TEST=m`.
  (Andrew Morton)
- Link to v3: https://lore.kernel.org/r/20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com

Changes in v3:
- Remove `selftest_max` again; snuck into v2.
- Restore `#include <linux/slab.h>`.
- Sending v3 early because kernel test robot is sad.
- Link to v2: https://lore.kernel.org/r/20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com

Changes in v2:
- Keep all the details hidden in prime_numbers.c; expose `with_primes`
  for debug logging in the test. (David Gow)
- Link to v1: https://lore.kernel.org/r/20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com

---
Tamir Duberstein (2):
      lib/math: Hook up tests/Makefile
      lib/prime_numbers: convert self-test to KUnit

 lib/Kconfig.debug                            | 14 +++++
 lib/math/Makefile                            |  5 +-
 lib/math/prime_numbers.c                     | 87 +++++-----------------------
 lib/math/prime_numbers_private.h             | 17 ++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 8 files changed, 108 insertions(+), 80 deletions(-)
---
base-commit: feb950f421d199acfe2503302f49632abfcf8663
change-id: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


