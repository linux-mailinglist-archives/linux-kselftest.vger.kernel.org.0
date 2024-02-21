Return-Path: <linux-kselftest+bounces-5139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135385D377
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E95283682
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4F3D3A8;
	Wed, 21 Feb 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGrfOqHQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266C3D0C0
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507684; cv=none; b=SWvwz5DIY+AJP7qYSXtRpcfZ8afmGqVVzkfZ2R2xRgo6rC2oZMgjrBI19pp46aruUxTuJZECs+ZRij0IDHgmxv7q5oRwmbbRA+TFFkLM0uMEuywQPJtGjpGxO0vm/lUUukI3QfUOf9K+ZUaS3syC6IppOAr387ad4SdA8z60VCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507684; c=relaxed/simple;
	bh=rqOJUF9M6mrQc8dXD7M61zFQtSxp3b+ZbBeG2t6aQ78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a0VxXfYL2kiuyB00Oh6epBrj5SIK43GTSxti2B73G50K/YM1M5qvvYAiGEN+Gv548/DkQhqjrCZZSMh9oSQp+WaqS/t7SnXpwf4RSuS1t9xk3vKjqGlV5JYq4X62j4d/UTifmruHFXADjByCfWvpip2t1zWNouv56dMIPnhsmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGrfOqHQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608852fc324so4950097b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507680; x=1709112480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eT/uH0qZq3eqCfd94wgAJ0+lZ7IXzMci6RxxltQCKcU=;
        b=KGrfOqHQz28RK8t77rt5ggx03KxOwAFzkpedVpi5057cKMpApzJygU4Zjxbktz584G
         pzqxZcplfxBJKKStCROql6+LlpHjEulo+NwsaS66AWIcNfNiFyMXg72DJHI9kAxkAwpD
         pjgwbVfBhM7xVRkBB1bdlqUIWkkb3TJ/O88666LvBVWwzVGcOB6BXvfjx/RZxCNLi7jJ
         84ETuusGPKXg2Zwn0kK6WPg1CW5dpLKKbr9Hcs66so2YNmPhh2EjamJsxJ/rTIP2q8qX
         IoDqNKMITG2fR3csA4vkehNX+mQssYD3GEGKCsIWfnTZsCL4qeqqTBJZZ9P3ix5CPaJO
         tScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507680; x=1709112480;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eT/uH0qZq3eqCfd94wgAJ0+lZ7IXzMci6RxxltQCKcU=;
        b=B48iFd/PFY0LD3tAZ/DVhB0LYxRAfdplnJ3apROWQQvM/bYOXHOV4h4wyyv4qWRFIk
         W36mdlWKbquCsCSWkiIesFv7i52ewcEgHsWd2578MII6zoDtZ05Tdk81NYp3gCXfPC+u
         Ia7Haixd05bRhPZFzV/aVAkpqjVQMCk0wyGXTgtrai24o+Qh3Q6T4bb9Oqy4no07t60e
         Xv2YztqClGyl0yzDiYs36+tZae3IqUPblAgfxoHBKCHblDrvcJD1ShSHywdvSRRI+XDD
         iyEBE+RBxVyiFVT3+4nBZz5B4LFXiFNBJ6xDv8y8bL8UWxSQLTS5kmdR5qFQIG+Xwgmz
         JpTA==
X-Forwarded-Encrypted: i=1; AJvYcCVhyEO5gIMPAfrjG9sK0WLjEqDEZh2N6DdBcMHBhGXdES1NS+ig1hOmDGDFc6TNoJGgKbLWbOdFfGniA0LHT5zubjjUZw6USyt1vmtAUAh0
X-Gm-Message-State: AOJu0YwCWrNDPd1jjFNtMXpn8mm+5f1cRcTQlX49aIFyimM3nZV3bXLi
	wPh7EmMyFHnsAL8IqeBSy0epSEzx7pGNKVO9Fk/9/VRmV6mpYzvUe7Jd8eEmv6SULbgKk2axRVF
	PcXBaew0ZSQ==
X-Google-Smtp-Source: AGHT+IGgpxMwkWEuztRpScY6gpG7tiyfC6FQuhNT36WOurGMxJcdy1PSlvVZEYKt9//gZI89E5vnji5S6AEFRQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:188f:b0:dc6:dfc6:4207 with SMTP
 id cj15-20020a056902188f00b00dc6dfc64207mr4738387ybb.10.1708507680618; Wed,
 21 Feb 2024 01:28:00 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-1-davidgow@google.com>
Subject: [PATCH 0/9] kunit: Fix printf format specifier issues in KUnit assertions
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUnit has several macros which accept a log message, which can contain
printf format specifiers. Some of these (the explicit log macros)
already use the __printf() gcc attribute to ensure the format specifiers
are valid, but those which could fail the test, and hence used
__kunit_do_failed_assertion() behind the scenes, did not.

These include:
- KUNIT_EXPECT_*_MSG()
- KUNIT_ASSERT_*_MSG()
- KUNIT_FAIL()

This series adds the __printf() attribute, and fixes all of the issues
uncovered. (Or, at least, all of those I could find with an x86_64
allyesconfig, and the default KUnit config on a number of other
architectures. Please test!)

The issues in question basically take the following forms:
- int / long / long long confusion: typically a type being updated, but
  the format string not.
- Use of integer format specifiers (%d/%u/%li/etc) for types like size_t
  or pointer differences (technically ptrdiff_t), which would only work
  on some architectures.
- Use of integer format specifiers in combination with PTR_ERR(), where
  %pe would make more sense.
- Use of empty messages which, whilst technically not incorrect, are not
  useful and trigger a gcc warning.

We'd like to get these (or equivalent) in for 6.9 if possible, so please
do take a look if possible.

Thanks,
-- David

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-kselftest/CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com/

David Gow (9):
  kunit: test: Log the correct filter string in executor_test
  lib/cmdline: Fix an invalid format specifier in an assertion msg
  lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
  time: test: Fix incorrect format specifier
  rtc: test: Fix invalid format specifier.
  net: test: Fix printf format specifier in skb_segment kunit test
  drm: tests: Fix invalid printf format specifiers in KUnit tests
  drm/xe/tests: Fix printf format specifiers in xe_migrate test
  kunit: Annotate _MSG assertion variants with gnu printf specifiers

 drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
 drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
 drivers/gpu/drm/xe/tests/xe_migrate.c  |  8 ++++----
 drivers/rtc/lib_test.c                 |  2 +-
 include/kunit/test.h                   | 12 ++++++------
 kernel/time/time_test.c                |  2 +-
 lib/cmdline_kunit.c                    |  2 +-
 lib/kunit/executor_test.c              |  2 +-
 lib/memcpy_kunit.c                     |  4 ++--
 net/core/gso_test.c                    |  2 +-
 10 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


