Return-Path: <linux-kselftest+bounces-26668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971CA362E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C393A8C49
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0E2676EF;
	Fri, 14 Feb 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsuDqKTb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A371E04AC;
	Fri, 14 Feb 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550017; cv=none; b=sZXU1eCCPuRaJtW+v8Md3P+OaBJvNXiwNPA4CnnwGSEvpWJDuvf0OOetDk8C1U0lRT9Cnk5aQd9u+JnghUDuUn+iRSTcvbkZLz/C4E9d7CuLSAauNQYqauxS2HJdBvNjs5e3vUu48ljsdeKmNk+XRnw6dkj+v1LJAWIMAxC55SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550017; c=relaxed/simple;
	bh=Co60+0XLQSGJuVYCgHFZFSYSARsz/MWSsGWThrUxsl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dumlNKLoNszEvU6ei6l32Cm7eiawEDFhONjE0DmPNQM3651obO3bYGB4Xz8Mayp8J/6qS0EjaNt97pOIW/NwrAes5ZaVtdqLVu5a/I3KKaRMo3yaRuzNosy4xqUdhjctLGRoeDB6CjbSaCl/ocvKPLRVwfBna8kfjzG0PKWpa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsuDqKTb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471c8bdabcfso13872041cf.2;
        Fri, 14 Feb 2025 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550014; x=1740154814; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1vLUvv5G8gI5Dm90TOMD0iNfnTNFxwwgB19DOSwu0U=;
        b=JsuDqKTbTV+G04gmXCv84xo1LRSzKHliGImUHY2H+bLJfYaPaljoYbIcDINASuTvXx
         TeDcWMitFPWKiSHfcScCqGGXqSafe89UMl7YvB498O3N5OgBIiYC7a0uNUPEzzjU6jpp
         5HBLghKjzb4W1+lOBB3UJ6xNV65Grfv7JoASFiIofbdh6vTgCPos7VqQaXb+hAeuB8AZ
         VrzpZKVz7XvaWvzcCNPFiF0aj1+7O2O4H5n6ZANZCEHX1m030rN5Zy5mKGSM1sww0UDE
         Z1YyJtFfW1TWDaL/TTjIYFHkjCyeK79uDE2si4TVdhpnv9NGUcM/pPK571/UwtUfRo78
         SOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550014; x=1740154814;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1vLUvv5G8gI5Dm90TOMD0iNfnTNFxwwgB19DOSwu0U=;
        b=XNYtuoTMD1kYA/feA48BaeUrwZV5H+OhSHC7gfOlMpcgqrQINByVEXOh8w+jsSa/Mw
         JcTLWsI4ZhJDeD0N88egQpmsMJWtVLinC+5FT0PuA0/pmmBjGYgwGd2rWoc12ALEgs4A
         g/uFAWqsGneo/zmUXEuIGTmS0RYtvTIXqzQ0h0tV/YXQgk7TQ1k4uYvLNj32yjanp+vj
         notstKJlb1KYVEvbpQJFlzfvykQQiZM8/10sPeeoXRX324nmV9uu+A73sOxR/uq81fHD
         30d/eip/t7w8HW4Ju2Ojmh1b2H0IEkcO+EP2x0BT0ojGsA0yewaU+38pCz3x6BiRoFG+
         nkpg==
X-Forwarded-Encrypted: i=1; AJvYcCUcCVpo+cJESwI1YQBLNzKScN2Y/jtBmr1fwb9VXd3PL+btVPrasamaeAgRnmUlStP3vu9LlcjXSfmdl0iN0UIr@vger.kernel.org, AJvYcCWDOEt6bfU97hrCI4p4WOnNTFIszRRks8nYfA7iegY5Ru4N5SU7ZTLWTzjdP6IuGk8ewKnM3/KhhxYHDtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiH4U2F/IY17IW+h6wt1G9cxLqb1/BvOegZM+iaOYaG9sVamWw
	owjpUwLAQTzfcOoYpIN+3COTZ1VKsElSeMLfAg0k8lCGywCdKoW0
X-Gm-Gg: ASbGncvncd5JnVMKVBK2iJCUGfDYj3kdenfgVVIvWMru6T0VJPsk9woibg5up7E5wwS
	Qe5eHAs9+qSXe9bea+4jFuxZJudAaZS+xALvtQD4pZ1+xqoGGOSqfoVonnX+WtGz21PBT7aY6tw
	XOUBQyg2S3C6636kUlY+e1PZa2EPGrmXBV8xrO064d+40KuW84APy/Gt42CLnDMUKcF0Z8UA42D
	d0DVtZwguTuU2gKO/zeAqYQCWl63m/Tyu39wByys0vsuPCWyP5w4N79uFqRMGL9OuwtQgrzhhYR
	+CpjGl7Q6G8tAGhUx0+qlsC9m3FTI2Z4+gwvyw==
X-Google-Smtp-Source: AGHT+IHYWZn2GNkBkk7wTrIASNLt/U68QgJ6I7GpkioNs9UTVDHNec4Qp+4fwQZP1vTGkKNr3j20nw==
X-Received: by 2002:ac8:5a93:0:b0:471:9721:7482 with SMTP id d75a77b69052e-471bed2f155mr99709181cf.27.1739550014341;
        Fri, 14 Feb 2025 08:20:14 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37c7sm19196911cf.61.2025.02.14.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:20:13 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v8 0/4] scanf: convert self-test to KUnit
Date: Fri, 14 Feb 2025 11:19:57 -0500
Message-Id: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1tr2cC/43RwU7DMAwG4FeZcibIiZM45cR7IA5p4mwRrEVtq
 UBT351sF0pVEMffkr9fli9i5KHwKB4OFzHwXMbSdzX4u4OIp9AdWZZUs9CgLShUcoyhy/LlvSu
 TjH038zDJTJAiYtuiiaJuvg2cy8dNfXqu+VTGqR8+byWzuk7/9mYllYSGnNUmA7fh8XgO5fU+9
 mdx9Wb9bWjAfUNXQxMFp3zyYHhr4Now+wZKkOhdoojMpMzWMGuD9g1TjaCRdciBE/utYVeGgn3
 DVsOzMxkDJW6areH+YbhqmGQ9JqDc6LQ1aG388heqRgRLGQKmJv24ZVmWL3UB3RdOAgAA
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
Tamir Duberstein (4):
      scanf: implicate test line in failure messages
      scanf: remove redundant debug logs
      scanf: convert self-test to KUnit
      scanf: break kunit into test cases

 MAINTAINERS                               |   2 +-
 lib/Kconfig.debug                         |  12 +-
 lib/Makefile                              |   1 -
 lib/tests/Makefile                        |   1 +
 lib/{test_scanf.c => tests/scanf_kunit.c} | 299 +++++++++++++++---------------
 tools/testing/selftests/lib/Makefile      |   2 +-
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/scanf.sh      |   4 -
 8 files changed, 160 insertions(+), 162 deletions(-)
---
base-commit: 7b7a883c7f4de1ee5040bd1c32aabaafde54d209
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


