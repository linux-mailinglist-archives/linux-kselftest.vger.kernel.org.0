Return-Path: <linux-kselftest+bounces-26123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B198A2DA02
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 01:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82CB165AE1
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2520EB;
	Sun,  9 Feb 2025 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktz3dblL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EE749C;
	Sun,  9 Feb 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739061699; cv=none; b=hT4ko/7MdQJr7tXS4/FITT7Eanm/Aame5YtI9QMSSXOt7kE/6jafhnEbFvbMbXgNCXAoTP8E8Y1llDSCCLi5nx/sLGyksspXqj4vzz2nIwjZAq1FImGF4oCh0fo1i6aq0lyaAAKEmK2NQ7ct89nRMY2ladG+YOcU1U+WXcnL49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739061699; c=relaxed/simple;
	bh=3Ntw1nMsZpdhAGH2NBLsurbClWQ12hDFn1xti6airbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HLwDiruBvsi/556qaXosmq+Dq3jkzm7EVHL66ucC9ghgI+JBhj+lRz2yYco6BWDgmeXGrzEPDlmJ8EJdT6d/7C4DHY66vPWhmzIXQ9UfKrrgmpnmsBOAOJKc1b6rTRKzBrVM7ELgy5ymU39tq0oZAfAOQH4eEYC102oIpRFL7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktz3dblL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0590fdae5so42433085a.0;
        Sat, 08 Feb 2025 16:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739061697; x=1739666497; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2K4n+bY+3e264rcEDgvcosaB6GD+/SA0cAjuPaJOAl8=;
        b=Ktz3dblLcXRCNzUvPFNflzk5jcfaZJzmBjtaxmJ+Op4jVXmhftujmFrTcKH+Z2IGzC
         Bt6eocaPaJgWsklBy4HFg4b7ZHQuy9JklaKYYhmZeIAzSJ/CVMtoc+72sKNeHmPhZxcx
         h4kLYU+84/QaCx5TBW05CrfVoW58/Wr7cwMhAhw1SJhYXJ6Uja4nvP9MHDAui5wy3zHM
         wigvT4AHEB2AkVA6lyVXPfu/m0Znp9OeQu5UaFY8r7RCWsdrY2b1qGT3j0PLwObNIU4G
         Xa4t/yI2gII459OMIOo0zhd6wTphj3CVjDI0qbLY9Ij0GEhj0jLUR5RU8uwRBV7pRpAn
         V8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739061697; x=1739666497;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2K4n+bY+3e264rcEDgvcosaB6GD+/SA0cAjuPaJOAl8=;
        b=UkhtUqI8Dns3hZWOFyAqLMPZFHF7aCCBuuziDXxQvYFuBcuuswSSxDIdJJCmoy8RNs
         4NEfxRZwrh4DbpKepIy2Idm7Q1bm4UA07Na9cO/pMBD424+DjLE6rw5R8dubDeAFfeyz
         AfOqQkgD/jBQQan0/bniCHEs2jLM+8llbRzEOikdhtfGGOgWaor/FpMEFdJR7v25YLGk
         VDfOK/LAuYwyMfizaK3HT9RZSCpwg/kX//CiZO9M0YQwRFBNu8IsKpV83+fjM4vfRkQd
         SFkQHYXv4JoZ0XMdet45XyfOMVMfk7dIyye7QPAzd5k5pGWNZ7pcxQXd57GMzdFvZb3+
         5/hw==
X-Forwarded-Encrypted: i=1; AJvYcCWtWcgSGOqr9rniBGktoozEmVZPclhLDytMerSw6O7QGzApctuDDfZ8A7XItkjzsJQ9LX+BpESSuL7dX07t/AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzefy+fn/XYEgSeBK61pZreLULMs49AXWoKFpBIY1LDPk6ZFfx
	Z23er0rQc6zQdBa7SICQUrRgSy0DRnb0KXvri5CYWSUwFmC6AUCZ
X-Gm-Gg: ASbGncsFx3moRTE5dVKYLRYnoYOqrfRSRfV/wPBPkch5TN4COIgBv3BBTnfdHT20Ixy
	n2CU4j2zL0eM2PH6P6m3mvmNdl51VVHfOs8X9qfL8sNqCRD4T/JyqWLZw2fh7/OSNZ4GLVbxutl
	cVypJ93qLOPeiYQ/4qF1/9mJrsM8Of7bVUm9Z9WAJTmE4MrvbJvqe47ehauPtzTg7dUwWeBtZkV
	a6CUU/Q5XtVcCa2DkmSnmuUXSBFfZ9pqOqDE3svysWJ3ex3htZ8ob0viDu4LQSR2iw8jpHZrW9J
	laPx7SwIzsbxOOZzQgqMW93FvxmtO8vArJUSwxtQx8WWa35agaMLXRmcoz/d4NMJTsQ1+fa06XQ
	HVf4cnjBWN5tsuFS0AhQIMHJwmPWzXGeRpastDA==
X-Google-Smtp-Source: AGHT+IFneJ96NIpfK9iNqadLxsr9oshLnjGgxiVwutkYflM/BvNl27WpZLMmS9PaN1yk4MJG0Q/QTg==
X-Received: by 2002:a05:620a:3181:b0:7be:6eb1:f507 with SMTP id af79cd13be357-7c047bbc660mr1165091985a.16.1739061695460;
        Sat, 08 Feb 2025 16:41:35 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb7f94sm353272885a.96.2025.02.08.16.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 16:41:34 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/2] lib/prime_numbers: convert self-test to KUnit
Date: Sat, 08 Feb 2025 19:41:27 -0500
Message-Id: <20250208-prime_numbers-kunit-convert-v4-0-76e36bca06a5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALf5p2cC/5XNQQ7CIBCF4asY1mIYoKW68h7GGAtTnWhpA5Vom
 t5d6sq4MLr83+J7I4sYCCPbLEYWMFGkzufQywWz56M/ISeXm0khCyGF4X2gFg/+1tYYIr/cPA3
 cdj5hGLgBu66VBQdOsyz0ARu6v/TdPveZ4tCFx+sswbz+5ibggpeiNI2sjTWgtqf2SNeV7Vo2u
 0m+W9V3S2arKhXAWmuDQn9a6g9LzVbTuKKC0lXOvlvTND0BFolZhV4BAAA=
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
 lib/math/Makefile                            |  4 +-
 lib/math/prime_numbers.c                     | 76 ++++------------------------
 lib/math/prime_numbers_private.h             | 17 +++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 8 files changed, 102 insertions(+), 74 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


