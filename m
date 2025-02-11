Return-Path: <linux-kselftest+bounces-26367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A532A30F5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FAF1637C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F325291B;
	Tue, 11 Feb 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSbDAd1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB73D69;
	Tue, 11 Feb 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286822; cv=none; b=uCrQeY1aYWDNvTSrvIwMWKOAiPnSM6pTNk6aUhV9OflKszkNE9W3qvSVwz581+96yVjrWE1sBCYHuyx6ctrCf1YJpHcOO1dXCprW39H25Z+tQvLOKNhx9Dg6fejPvDPzed/VXlQhgKH9VjYeBfnyc5N13usgV0tiD9qTkt8+WTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286822; c=relaxed/simple;
	bh=PQO1HNETqHO+CjYUl36CkrHEYK6wG0TaXkQPKysBzCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nE0XvU57Vn7wROeokkQ8QftcMCAQC9NwwggiemkjC9HfoapzVEbjsY5EzxpnaWmco0Y79tbyCUjW98PUtv2PYYyp4t36uyWW30GAdCeImFR3tq5qkNxv2zq+8NHnXW5hG/ds+3OozvQvPvqva8vewwd/TyN9WGzm91odf8sZmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSbDAd1v; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be8f281714so562340985a.1;
        Tue, 11 Feb 2025 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286819; x=1739891619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXFuMHmv9FkdofzVg960jul3uUUg0TNK3Z/UA6I4Qec=;
        b=DSbDAd1vYuBNFuSE7fa0+0NbqfAZS6QKeqk1KMxHfF188c4vVEVcjtXETnwQtfoUk4
         cLKCYV8voqBLNouKzqO7JMul3UrJs4FNASF9sK4/9kMFj265xX8bSjr0XmUBPNzFMDqi
         OJc7g8rpcsEuZBi81CNOjJ3gZ/g7vR1+Q/0A2/xRTcwFXIKiPkeCHsNzsTUbbPFC4y9A
         QNSETJskHlLxcxIzki+hiqYwRYM8IPspujf+htNqY5P1o/RnrDYk1pluomvO7VK71Z2T
         /kytiG2n+xQK1xDxf+l4GXDY+vsL9kVhAsTjTaaA5FD642vZvZHZnsR6GiYSTMyi4l2j
         m7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286819; x=1739891619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXFuMHmv9FkdofzVg960jul3uUUg0TNK3Z/UA6I4Qec=;
        b=YXCl0Gb81FTTsVht/Fvuyk1yozq8lFO5bbd7XDOL7KJs5xjCwSaTO2rLC/X79rSO3Q
         Na8ijKucZKdkyUNJcmDz73+xFvIgSqN6CgAD8rkxAcyE25PUYHpku8IXEwYWAsEeB+NS
         toj9RNm1zdr6h/+FoCOQwVwgcoQ5eG/4yI/9MNV5zwOxVddL0gDBbF1YiSFMStYIeklb
         HourqWUYhvEjmV9uLF7JDvqRQK3xrNwApR2gzHjCs53162UCUWkGBsypX9qTv+EdNhVk
         hwCye+9gNo46w/+/xOQKiq/pMm5VD0dEDnKcwxtYhFw0cXa+0KiTiYsLRunUi9yUNbyB
         NkDA==
X-Forwarded-Encrypted: i=1; AJvYcCUE5HUKKxP0be1jCVuH0epKQsfqx54ZvqqFPCTrT6KJpvVzhYw1/K25JsBs6LxcDDmLWe4rwaSOhXA4WO4=@vger.kernel.org, AJvYcCUljHy8LFE6OjicW4OkUW/i6AnIbTlmFjB0Co8HnZ5qIsYM9d2GFYoQtiO7yxO27ATIX0hT2FEC7rMp4U1tQmnV@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPEVFuhyM6Bg5l8deVKC4SR0gDmgOtysBc+d51htBaLUnWCqn
	ovBOTbyw/YnD+mZ5gS+cvA4znjqHzP1scb24myf9Qrp+E4mbSLwR
X-Gm-Gg: ASbGncug3Yqup4EH/WQgwoJyJ8LIBJK/gq2h+LlWejw7m6IuYpE80OOhTqUcjODirG+
	/kn9qQqmDmfUirxVU6oAUOggIVRDEAmTqtK20W35Otw744RueozeKvjzM8ci/Bw7g0gTETjv0U4
	zQDAHHwSpabuz4GG+xt0oHtoH29VOYcW5ylMDTqoLm3xQe4wOsStmObzuHtnBT1tRUwyr4i0k9U
	CMUtpi+OpQO1I8+TV8eTXdGQ9VtnCxXS5wUCk4EHmroG0NX32orEfrSp2b15EcXju4RhKvYDaHb
	gsk1IXN4gP1fijtQ0S9ZmlLbIDuGkr9ktWZu
X-Google-Smtp-Source: AGHT+IEW4/iW2cGe7i6aWFxBmjfVsckg+jqj44b2ciTXZ1WH+/R9Db9PyC9AcOTrPtEDZtQtH3xREQ==
X-Received: by 2002:a05:620a:4151:b0:7c0:6e5a:662f with SMTP id af79cd13be357-7c06e5a684amr110356685a.39.1739286818922;
        Tue, 11 Feb 2025 07:13:38 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2620:10d:c091:600::1:b3ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47193e581cesm26852561cf.40.2025.02.11.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:13:38 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v7 0/3] scanf: convert self-test to KUnit
Date: Tue, 11 Feb 2025 10:13:36 -0500
Message-Id: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBpq2cC/43NTW7DIBCG4atErEsFDH/uqveossAwJKgNrsBBr
 SLfvSSbWpZVdfl+0jxzIxVLwkpeDjdSsKWaptzDPB2IP7t8QppCbyKYUIwDp9W7HOn7NaeZ+ik
 3LDONhgUPMI4gPemXnwVj+nqob8fe51TnqXw/njR+X//2GqecssFoJWRkOLrX08Wlj2c/Xcjda
 +LXEAz2DdENYYzT3AbLJG4NWBty3wDKKFgdjAdEw+XWkGvD7BuyG04AChcdBrRbQ60MzvYN1Q2
 LWkZwJuAwbA39D0N3QwZlITATBxHWxrIsP6tZaM4KAgAA
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
Changes in v7:
- Remove redundant debug logs. (Petr Mladek)
- Drop Petr's Acked-by.
- Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-parse
  messages. The new failure output is:

    vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
            not ok 1 " "
        # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
    vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
            not ok 2 ":"
        # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
    vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
            not ok 3 ","
        # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
    vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
            not ok 4 "-"
        # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
    vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
            not ok 5 "/"
        # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 total:5
        not ok 4 numbers_list_field_width_val_width
        # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:92
    vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4hx%4hx%1hx", ...) expected 1257942031 got 2886715518

- Link to v6: https://lore.kernel.org/r/20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com

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
Tamir Duberstein (3):
      scanf: remove redundant debug logs
      scanf: convert self-test to KUnit
      scanf: break kunit into test cases

 MAINTAINERS                          |   2 +-
 lib/Kconfig.debug                    |  12 +-
 lib/Makefile                         |   2 +-
 lib/{test_scanf.c => scanf_kunit.c}  | 270 +++++++++++++++++------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 7 files changed, 143 insertions(+), 150 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


