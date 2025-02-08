Return-Path: <linux-kselftest+bounces-26100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9690EA2D67C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 14:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B116A2EA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E82475EB;
	Sat,  8 Feb 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz1lnoHN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE98F5B;
	Sat,  8 Feb 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739023115; cv=none; b=XUmhD3sN/7Iulx1IWZMiMWdew9Ac64xfPfLPlltgWnlcIAolmob4YpCRayHSn/ayb9RpEGXOJxrCe0PrKpEfJurtu+dNRo6IfftWjEdNpQj41YsEQpxHWJqvHC0Ong23yirVyIWHZOmnk+kAMCz/2jL8yNowZl+FFu/VqkuoUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739023115; c=relaxed/simple;
	bh=4J2pCMft8Eygz2X4LFNbMlwR82WXKgn8HLMP+R75lf8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JuImaxPYS2fCXfuf0HJlEstNowrF/VjV+0qxubKmPIBTcmFG5lurJ1pEDV4sv3ynyTVW5cCY8GceSSYUqxaGhgHAN+8t17Ko04DdeRAg/DslcfsG0ZPXdfwtp5FY18LP6J7GyKWFLxdFZe4ugiOhYOgC6J2nOzDFmw7mFEL6Es8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz1lnoHN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46e28597955so26441551cf.0;
        Sat, 08 Feb 2025 05:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739023113; x=1739627913; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liyNbe7I3VQ6j3aIb4CNitPB4kxDl7AGYlkp+r+2abA=;
        b=Kz1lnoHNitDGX/ykxEWKc6BtXQ502t/3OaepaRZlzDCK5a5Dw7yZPgXk6bpkP2D0Fg
         HtiKi2gU9dHhFRsYHXLJPXrk5TtfNHojDtUwwJsV0H2TOO3leseKNvYMg7BDauu6tWce
         ox7o2UDKLGtvSfhku1LPOduqhGQZfGvL/9oOkoSsCa5f6XodSt7py1FKqkbHOvD9TDE/
         QIaKbOR68DLIzHaUf7H3OIfNs550dphz1abAjdl3W8Um9TEHuGiDDEj7YCQh7Zt5O60O
         Q0Ymw23lUF3trgnwhzldq07OcDb7VMW33/GnPbQwK7l4bdL1RNcvLAFDs0vIJD0VHFbP
         G7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739023113; x=1739627913;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liyNbe7I3VQ6j3aIb4CNitPB4kxDl7AGYlkp+r+2abA=;
        b=o2iqLgW26kKA9kaKAeyKNRNFWg5aIqZGXF1XYyNABQ4tT8o/JUaE1soGydFMSs1MN+
         UQFdPQjNnfaMMT1AsVir+89f1J+vLvmhPPuGZepLClvRjrf5YVpBAgHn1S7Uih4EJ9sk
         Lyx134hNXN5u0Iqxxe8g03zf68wjXYM5kXHHRRplintPoAP/o9HvOZO5l0fNh4pScwwy
         FG0RDgk8kHUJKh2GH7UmRhXFePd+qBcA5Zv9QcA6lC1lkhyw2Hd9EB/CA5yu174plFGN
         TmjhwAaiA//l0iV6etVuqtEC3+VhVQ5hvVCFrpO+I4mqiO6JUYAtDbZrMZZiUWlQKedw
         8ZVg==
X-Forwarded-Encrypted: i=1; AJvYcCVgpz+4TjPqA7F/cER6vTPMXzWAGO7PNniTCzn3z+SksQW4EhjteWdmuWuvlS9cAAZVHoSXGgmUkeNNhKy46Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQkT5ONqrLRzGd1ia4GoljYjcLQD0lZRMP5Rxi3L0Ka4HlRuc
	7cwJdl9PCS8U5sMvQcaipJyyvzWcFrQvc/zyb5ZaxDuqsAN4wqn1
X-Gm-Gg: ASbGncvHEIApejuCAadyXe+pJCY6cODZ0Xy6BNOTGzwW+/6r/x6Ch9qDFyxPkQ+P6Ad
	b31vvbiZF8hAyG/OC7Fn/H1eB0iEEWixJayhIJuDiGiCcqDNKRgbI7gTTD2C0vVPLjsRIrSjeZE
	+YWKoda0VU+Ka/ul1TK1/AjoB/b3HGvHh8JH9atFgTTWla1/uAzNCSzT0LwUJK7eBgGi18J07Cx
	vHWYWdbi+GPwfcO8SbN6lxNnmkw/DPia6XzeM9FIU0idpTk2FR5JJjLx4tJOYSlefDJV1F8odgb
	3oUfVsdMtij/KrEj87Y8l5uQ4zrVGtzhf2Y4q2NWUOhrCyx6XA==
X-Google-Smtp-Source: AGHT+IEMHeOIvmcWQOK97rnqv2c6634Scsh2/9IOc6/FcWgNTDx6aSrOa0LgT0lOVMn/X0mX6YncNg==
X-Received: by 2002:a05:622a:608f:b0:467:5da6:8096 with SMTP id d75a77b69052e-47167b04892mr119259091cf.44.1739023112867;
        Sat, 08 Feb 2025 05:58:32 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471810804e9sm3268471cf.80.2025.02.08.05.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 05:58:31 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] lib/prime_numbers: convert self-test to KUnit
Date: Sat, 08 Feb 2025 08:58:27 -0500
Message-Id: <20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANjp2cC/43NQQ6CMBCF4auQWVvTFqXRlfcwxEAZYKJtyRQaD
 eHuVk7g8nuL/60QkQkjXIsVGBNFCj5DHwqwY+MHFNRlg5b6LLU0YmJy+PCLa5GjeC6eZmGDT8i
 zMMpe2tKqTnUnyIWJsaf3Xr/X2SPFOfBnP0vqt/7XTUpIUcnK9Lo11qjyNriGXkcbHNTbtn0B1
 n9g7MYAAAA=
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
 lib/math/prime_numbers.c                     | 82 ++++------------------------
 lib/math/prime_numbers_private.h             | 17 ++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 ++++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 8 files changed, 104 insertions(+), 78 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


