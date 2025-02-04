Return-Path: <linux-kselftest+bounces-25727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2515A27B29
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0493A1035
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AB52165E8;
	Tue,  4 Feb 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrRMHiLu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA872147E9;
	Tue,  4 Feb 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697165; cv=none; b=pcv+57tnU4zjgKB++THPhBSq6wEMs0M880rdOxuBKyQDLqhNDdf5nP8h76k1NDVtCIhV2WZP6ce0mKxR9A8OkL560WxPGn4veT4CvZilXYXhWK00N1WWF2rNKZ+Gaa+o1JLwmE88sx5IrSjL2cRt1dDNLG5Tka3p8zalOz5ZoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697165; c=relaxed/simple;
	bh=wKhs2aD0ynISzsKTkz1zYz/D+m17iObWon1lOTEZYS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xwiar7mAt9qWDGVPs28T4U+FTKl63r1Ntsjk57/r3LgWxzOtlALPQHJTEYWYz7FP49SmX5H9wDmieH3Tw1JRNxFA8DUQ0+d7zBygnZpoVHhlapYoaOmTE/EglQq5uGcxF98bl2fvZsGgtaJg08rc3gKQRGW3wbreAXkb62vk8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrRMHiLu; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e5c74cb7so501455985a.2;
        Tue, 04 Feb 2025 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697162; x=1739301962; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7SLBjn1DVctu90gMXy4A+sG2WNv/p/T3csymSiwOk0=;
        b=SrRMHiLugNYPZaIyCBIKDcnUZvp1pBVFHHaEz7xEovSU+VPJGQMn7EO+f4mrJ9vDdc
         9cgvybIsuVq0RyuTSZN06hk8jqhpyRGOBAy6lJfv1Ao+/UqKodJ10tOMctyoUZ9w77UD
         w24X19O+FjSlbYK41j+ZNdewF29fK1h9qyCs/cZs8H64N+h/XpUFgHs46XCjbYL/11Qu
         MM5gVEcLYguqp6OnzC/jxMySjUmrnPlgRKOwsbsRjlyR3wBgS0BnG3oVNmIcgdvIAwq1
         gBcLEjCVYAbRiNzsboTODAJRB1EiYa4LtIKkJj3/sZofESRdkUygu7RJaBmp+gbLBw63
         j4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697162; x=1739301962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7SLBjn1DVctu90gMXy4A+sG2WNv/p/T3csymSiwOk0=;
        b=EqtnDersqe4WgCXYWrHY9s2UNnPy74CpCEJ5iTQwGL0Z9s78+IhWKBAJj20TfDM6Ud
         MLrThqvJXjxH2aSawVtoa/WcHJdMBfeMw/d9IzJSXW0UEkpuSUOkEypV76WyrPokQq6P
         rCCsTWD5CEUf/jFeooELjNXVb/3122i23Wl75pqFRLvaTsHRJ58MCcXsgWw6FdNrj/KX
         N1ycL6wKZtRESU00LmLBk4P3Nvg9acJgSomXqQv7ra2ccGkfBeyLA5a6MMe8Pt/RZa8O
         qZjDwJloL++m/944EfXH0Zr0ZKYba/roQqIv6v2zikZpeiKITGVkw8ztIlbu8edbjzXh
         Hzlg==
X-Forwarded-Encrypted: i=1; AJvYcCXBGoKjZ2QYVuKtUKD5b8qV8MDskuE5AG+2ITFgtX7LIZ9Lgxt+IWisf5qPPTULtleDWvoQ5CTrtDEkjNvhWso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RwH2XNqAS4zNTQolnfXGWfn0cT+zeVV79FhHSFCPVltmsREc
	0KsiJUjm0ViczTJn4hKA/N+FA8AUo4RieD2xTQ/JE7XxLMeVXVtb1BYMaGsO
X-Gm-Gg: ASbGnctSphZ0GBgbSqyRwDrmK1SugYW0RR58foBjpchssahcqesa7chUlbmGuKa/wwA
	Eihgf9D4luqUyDPNfOjygkgfvfHul2bH+FqFIiQwcV7kBg40eUPXh+Z670gifNHOlaDD5V/Tqpa
	8dqKyIKp1PJJ18q/sFJb8kZtqlLmxLHhPYncpXMuu46PIMxMtUprkuGdrow5S/yBhSr+st8wMvW
	z4+wEenkZ/F1bsqDPpBGhQl1my5gcAePFr4TB/Y7GKqhcp1WTczMi2iQrh+sjf3LPzfjDJq9cmS
	zdYTiOXxwnTljMaNThZGuINoFBZO3BAvfO9vOL20B1hRSqxMnIuf0jTlIQrQbeTb6mP767ipfw/
	5fdBnR+tEgEjk+78d/7kMnmpf
X-Google-Smtp-Source: AGHT+IGQ9sW4QyCtX6z4HIqF49UaH4XNVbM3WI3BiYb3ljaoAbUaSo+Kg9O2RenDprKKmCu8vtqBqQ==
X-Received: by 2002:a05:620a:996:b0:7b6:deaa:3189 with SMTP id af79cd13be357-7bffcda49d7mr4113490985a.54.1738697162552;
        Tue, 04 Feb 2025 11:26:02 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90d032sm668429685a.107.2025.02.04.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:26:02 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/2] scanf: convert self-test to KUnit
Date: Tue, 04 Feb 2025 14:25:54 -0500
Message-Id: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJpomcC/33NTQ6CMBCG4auQrq3pD1B05T2Mi1KmMFFa02KjI
 dzdwkYXxuX7JfPMTCIEhEiOxUwCJIzoXQ65K4gZtOuBYpebCCYqxiWn0Whn6fXhcKLGuwRhola
 xzkjZtrI0JF/eA1h8bur5knvAOPnw2p4kvq7/vcQpp+yg6kqUlkGrT/2o8bY3fiSrl8THEEz+N
 kQ2hFK65k3XsBK+jWVZ3prSss36AAAA
X-Change-ID: 20250131-scanf-kunit-convert-f70dc33bb34c
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and printf), the rest having been converted to KUnit. In
addition to the enclosed patch, please consider this an RFC on the
removal of the "Test Module" kselftest machinery.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 scanf

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
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
 arch/m68k/configs/amiga_defconfig    |   1 -
 arch/m68k/configs/apollo_defconfig   |   1 -
 arch/m68k/configs/atari_defconfig    |   1 -
 arch/m68k/configs/bvme6000_defconfig |   1 -
 arch/m68k/configs/hp300_defconfig    |   1 -
 arch/m68k/configs/mac_defconfig      |   1 -
 arch/m68k/configs/multi_defconfig    |   1 -
 arch/m68k/configs/mvme147_defconfig  |   1 -
 arch/m68k/configs/mvme16x_defconfig  |   1 -
 arch/m68k/configs/q40_defconfig      |   1 -
 arch/m68k/configs/sun3_defconfig     |   1 -
 arch/m68k/configs/sun3x_defconfig    |   1 -
 arch/powerpc/configs/ppc64_defconfig |   1 -
 lib/Kconfig.debug                    |  20 +-
 lib/Makefile                         |   2 +-
 lib/scanf_kunit.c                    | 800 ++++++++++++++++++++++++++++++++++
 lib/test_scanf.c                     | 814 -----------------------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 21 files changed, 820 insertions(+), 838 deletions(-)
---
base-commit: a86bf2283d2c9769205407e2b54777c03d012939
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


