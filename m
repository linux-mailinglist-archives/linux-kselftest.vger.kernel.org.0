Return-Path: <linux-kselftest+bounces-28480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1674A566B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F2C1899C59
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16C217673;
	Fri,  7 Mar 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6tgUgQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED40213252;
	Fri,  7 Mar 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346869; cv=none; b=aJbDis0KbpQq4k4kZ7UuGRGO+EVBC2Es8y8BuVgBVb6twlMZE+J3Fxof5pwBGuHYI1/r0NrUdSY7riyh2RSKAcArtRt1LfS4Pao3vFO48IzkVEbUQ04bgo4itjOK1bCXWIU6Ti5qCk9kqiaRIEcCq+Vgdg7pF6wTirxERCCTxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346869; c=relaxed/simple;
	bh=ylxScfKTNCFu+UpEsGa/mhjpsyQ8gq/Ch3uBfdHP8CA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OzjxRjjWEJk8oLV4RXoaMNpmgtYUIsXYF2Q+S6IayyQTxkL3GtoBvODtr0ZSGUGO4cyn1JbBHbzMDiWu3uN0uz60RdzwcNPLtf90TXI96nqrhDz4mk23e5gcHWVfhGRJYV9qbZ4yMCkOMmxDmb9M16NIfifzxICZ4yU6jnm0pb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6tgUgQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8ec399427so11430956d6.2;
        Fri, 07 Mar 2025 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346866; x=1741951666; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PViXvgr7+AksTv5jRkRgKLWPpVwtKlnjDY8GR6GZb2c=;
        b=TB6tgUgQvectD41cOBAdURsIEGI6cz9tZ6zd0hGc4xrghKoIpMf04BVt+Wv8qGy6E7
         ri2RbIh6rQV/30TSD2soEznRffDzotkTxXdqJ1Bo5mAbGlJfAThX1uufJeXHcFv4QhWP
         tgTttHr46A4OV8KsDm2xTt9oDdAIrZyEfIA7woy/TzOzxgbHqJykC6HdQzhGGiv5R5Ku
         uZ91DFkmpuns8YDzMXKq8AzhudYtvomH/HyOSulwXKIe7nzXK0YarJR+cU46Uhb/KXnq
         Bk8QCDV1xwucCX2kiIz+7mQqLG42DallyMIhnkvJqVI+gvCkQvi56wRzfV0d/Z4AmvqG
         zV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346866; x=1741951666;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PViXvgr7+AksTv5jRkRgKLWPpVwtKlnjDY8GR6GZb2c=;
        b=EKXTONraAhyRfQFHSz2WsWVAqXgUACJ6v8+uJX/YoTUR5zzrpltdYpg7/6Y2+FI80C
         TqfHqHeaxhK3Na/Uh4INaYFRPeJxFo1k4/ZhkXFfWSR6dt0pXDmWqCUCOgbltJMWF6gS
         55qgUPCXCoBxuBEaoJqDBDBdlahi8qDpaWWByQx1CktK+BWyjAf79FCZ4E5+Jr2xSwc8
         Ei6eTRE5/p0D8sOr9fFRnL271PySmwmWcKd9joPMRyEDP6yPU7mjZ74wCjbuLZSxg9J8
         Rm99vovfnCKPP03MccMUTd5zDgfSujd35Oj0iwlGhzIipafQEBiVaCJd8HD9/+mIwam+
         v6fw==
X-Forwarded-Encrypted: i=1; AJvYcCU7MGnZTSL87ohBJJU73Lk1lL/PdHjWMZ2YpImetTOtlSeNGYW52FDB9e+VYjEz+kV3JUc6L+NHLNG679c=@vger.kernel.org, AJvYcCXI6NcZ2/m+9ggVQ8H14f6cv9hFouJVgTlbfnMY1NhJ0uydib1fOG9qJ1D5lDDE4rjd/98nVPn5tYE3sWosXyyt@vger.kernel.org
X-Gm-Message-State: AOJu0YzteULbYv2/x+sS1+ZFi0iDDNvj9zjGFH+PghPVOzi1n7Nz/T8R
	8qCyIaDDixMdN+6y7EWk4cjC7C8EFetNuAfthUdME/8NNycbNI4ExCSyz+yZh5U=
X-Gm-Gg: ASbGncsCPKXUiauqeSbe0TN5gO/Q8348MReujaCZLQcHgOlcwjQk5YmC0Bl+Yw1fMxC
	KA5p+SlfQBuJwT8ZCZOTEY8y76cO0Ixv++KZRE92+sR0XctKTI8hiRJEiV1Wufsjv7JiPMakleD
	vfzqvPTDqD9zjVqHmf1eEtl6npuKz88GzzWJgBfVVv9GCFpjV56ZYHL/89uhcUNMarqM7NOCgJ3
	44EtwY59Ob4m4rFJb/rCnM2T9bU8gTjbhYpkWGF/jI9dWD3ly0Ms5R7/ssO1iDTen9XuriH9clv
	wT1e0dAOCt5dWWgqUN8Qixt0frlppo+qnzNPmYaQC5qG5cGlj0Bkiae9sb5BfOFZsJg=
X-Google-Smtp-Source: AGHT+IFr6s9DfnKItfwASDMfKh5qY46cMyQ8mlyJJ626h0vPU3ljWWT3gvPm797nbddpF3hS9qbzeg==
X-Received: by 2002:a05:6214:1d29:b0:6e6:61a5:aa54 with SMTP id 6a1803df08f44-6e900693575mr32260986d6.44.1741346866341;
        Fri, 07 Mar 2025 03:27:46 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:45 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v9 0/6] scanf: convert self-test to KUnit
Date: Fri, 07 Mar 2025 06:27:33 -0500
Message-Id: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXYymcC/43RzU7DMAwH8FeZcibIifO5E++BOKSJs0WwFrWlA
 k17d7JdiEqHOP4t+WfZPrOJxkIT2+/ObKSlTGXoa/APOxaPoT8QL6lmJkFqECj4FEOf+etHX2Y
 eh36hcebZQoqIXYcqstr5PlIunzf1+aXmY5nmYfy6DVnEtfq3twguOHhrtFQZqAtPh1Mob49xO
 LGrt8gfQwJuG7Ia0tpghEsOFK0NbA21bSAHjs4kG5HICrU2VGvYbUNVI0gkGXKgRG5t6MYQsG3
 oajgyKmOwibxfG+YfhqmGStphApu9TGvDtsadv9hqRNA2Q8Dk069dXGvcuamrhqagIXudHcbWu
 Fwu3zwu+tWSAgAA
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

Failure output before this series:
  [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4hx %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959881
  [  383.102843] test_scanf: vsscanf("f12:2:d:2:c166:1:36b:1906", "%3hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...) expected 131085 got 851970
  [  383.105376] test_scanf: vsscanf("4,b2fe,3,593,6,0,3bde,0", "%1hx,%4hx,%1hx,%3hx,%1hx,%1hx,%4hx,%1hx", ...) expected 93519875 got 242430
  [  383.105659] test_scanf: vsscanf("6-1-2-1-d9e6-f-93e-e567", "%1hx-%1hx-%1hx-%1hx-%4hx-%1hx-%3hx-%4hx", ...) expected 65538 got 131073
  [  383.106127] test_scanf: vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...) expected 125069 got 3901554741
  [  383.106235] test_scanf: vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...) expected 571539457 got 106936
  ...
  [  383.106398] test_scanf: failed 6 out of 2545 tests

Failure output after this series:
      # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
  lib/scanf_kunit.c:555: vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
          not ok 1 " "
      # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
  lib/scanf_kunit.c:555: vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
          not ok 2 ":"
      # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
  lib/scanf_kunit.c:555: vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
          not ok 3 ","
      # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
  lib/scanf_kunit.c:555: vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
          not ok 4 "-"
      # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
  lib/scanf_kunit.c:555: vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
          not ok 5 "/"

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v9:
- Use __scanf correctly on `_test`. (Thanks to Petr Mladek).
- Split header `#include` cleanup into separate patch. (Petr Mladek)
- In "scanf: break kunit into test cases", revert to KUNIT_FAIL. (Petr
  Mladek)
- Rebase on linux-next.
- Add provisional patch "scanf: further break kunit into test cases".
  Please feel free to take this series without this patch if you prefer.
- Link to v8: https://lore.kernel.org/r/20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com

Changes in v8:
- Expand "scanf: remove redundant debug logs" commit message. (Andy
  Shevchenko)
- Add patch "implicate test line in failure messages".
- Rebase on linux-next, move scanf_kunit.c into lib/tests/.
- Link to v7: https://lore.kernel.org/r/20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com

Changes in v7:
- Remove redundant debug logs. (Petr Mladek)
- Drop Petr's Acked-by.
- Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-parse
  messages. The new failure output is:
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
Tamir Duberstein (6):
      scanf: implicate test line in failure messages
      scanf: remove redundant debug logs
      scanf: convert self-test to KUnit
      scanf: break kunit into test cases
      scanf: tidy header `#include`s
      scanf: further break kunit into test cases

 MAINTAINERS                               |   2 +-
 lib/Kconfig.debug                         |  12 +-
 lib/Makefile                              |   1 -
 lib/tests/Makefile                        |   1 +
 lib/{test_scanf.c => tests/scanf_kunit.c} | 360 ++++++++++++++++--------------
 tools/testing/selftests/lib/Makefile      |   2 +-
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/scanf.sh      |   4 -
 8 files changed, 201 insertions(+), 182 deletions(-)
---
base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


