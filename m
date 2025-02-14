Return-Path: <linux-kselftest+bounces-26691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09EA367D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61A518936A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA71D6DD4;
	Fri, 14 Feb 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKcUvJMn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293D1C860C;
	Fri, 14 Feb 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569977; cv=none; b=Ogna4KNHgLpuv2WQnrnAdYdNiy5EDFp+vgQiuLRW7qITNoic3XA53tveO1pjVdFkPQ67YwNVfPO5h9ckujR8dial8UMeStN5y+3iIhKME0o4Ry321FUkr/SxWFUJAgtSMXi5h+anlwXy6mCnVQ/84JZzIMDD+u80rBTMcAnzo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569977; c=relaxed/simple;
	bh=cYHXN4WirskhlsZE2ge7GTpevcXDyiKQeYIflIaEL8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s5Ig8q8+dzutn6ldkmpeIOBtgdO9pJGL8n79raBx2tXkmIbL7cZULj5Kv1hYmd4RKckObgF9VNcs9YYcmRPUrlpejVZ5Nypy+b1vf7WJAZykytghPD+OMMPrD3peKy4WvtIjA5gx7uHX3yvDhNPPHlaQeoPGpN3pUq0fJ0D5Je8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKcUvJMn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be3f230436so225766385a.3;
        Fri, 14 Feb 2025 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739569974; x=1740174774; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oelTRyiq2uUQLScUvm+yzvdL+C/sBoOcsl6Ykq5dg44=;
        b=AKcUvJMnJxAcOXWFOg/R5v2XC326c8umOjE7dmJs3LDnKfgsawNTQzR4bs8o6OsX6l
         2FDIDPWCTR71HFQEBemAKxO172tmKELecY3N87tiai3rQMh1Fg0oAHNcAuTuYSFMUZ6R
         C/IeFDxoFBLcSZY6KM9MzHWi7nNF96qLwWXUugBLyxivu4oi+YhV6NJ5es98BTQ2sxDn
         Z3t+ThW0rP0r5VBBSy96+6aUa47RaEfNwa26nnDlx3zBq2uf9NFAKa92BDotUAkeQsfi
         vrdsyLgYmIrOsX1WYyahXscpTgFEnMQT3QCgMMuqj3LYXRovuyNRm7X6GBAIP/GOkJyt
         WNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569974; x=1740174774;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oelTRyiq2uUQLScUvm+yzvdL+C/sBoOcsl6Ykq5dg44=;
        b=T4t7jFb2O5l2G14ppkg4WIE9+4RtaexujJ5C9blDO7H7kZvx790vzfSrcykI1CHx2D
         JLFgWxcDsZKm9m+OQhX2rNwEM7qqRs+th63LvLogWwSuu/7JI7TvNkNk2jSohEbq+4XA
         1Xr5GZ+m8TLXuPtvvs3CikUTa/YgsBMQ9CWV7rB1jfP8nCMAVcBGAPZcGuC91F9ESCch
         QaOC/GTh0Iukc9XgQML34dHLjA9cP1edSo2Hw9tToUMWvTrh2nhJV61FBaENZIxQzq0O
         j8rx0Zle5pQNaEPy6zahx4ZftGvTBv5u9aMHjJzh136VSWXY7wWx9wiuPwKBvp5Qrd2u
         2Qlw==
X-Forwarded-Encrypted: i=1; AJvYcCUQWEkI2bjJ4Yy03R+hruvsq+i9e1HEI1AOHC7E9KPZlnd1QBc0z2EHbRNN3ziTDn+rlBTPOeLhInQ=@vger.kernel.org, AJvYcCX3Pfa2H91pYqDyH9HwVaRx2cPgZsVFjhwLb5eoYLOtaA9ShlSPQlpy/yuO8uBBED38DXCsi/YYvlxWD8uyWPaq@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFp/zDwkOV515LablKkBmuC4FV0EznVKrCvnJwk+Jz4oO4BmK
	dtA1Y24GVgVd36jDyx2hWGADtRRJM5UmYj3G9c6jZhT9tA/rjhyN
X-Gm-Gg: ASbGncsJaMye7EY5Dfr4SyfJ37j7V5q/o9hdV5NXbLGt6OLHuQdNDXHTMULuaTnxbZQ
	UJ56JvXrK5SuLmBmtu6zeHJw6RJJqOArqXt+Sq29QfErqhnwrjAGWOP7xvxIZz1N4hykE7a2B0w
	Qtxs7BPuNvaI00mXZ8FFObWZtGWXIeiopRLL3D54kJ2MP34Ne74KGkdLi3PzxKGLSIholQq0V3s
	erF8B9sR224uLH7Ej/dZSuRzwmCqJQEf0/dXHOO5IjJMRb+lTnomQYLJoycNXRDMD3KTH+DgvIR
	+k/gjhx956R7QGN6s4RIGabpdU9tPoSJWOmf6A==
X-Google-Smtp-Source: AGHT+IF4uKo/kzj1TcgrhYbwG/5VYUbRGcDZFwUtTMQKwOkAQIIBdKv6vbbSZxzo9Ggb97riNE72Rw==
X-Received: by 2002:a05:6214:5190:b0:6e6:617c:abb6 with SMTP id 6a1803df08f44-6e66cc7febdmr16020726d6.6.1739569973947;
        Fri, 14 Feb 2025 13:52:53 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af3367sm21844451cf.59.2025.02.14.13.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:52:52 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/3] printf: convert self-test to KUnit
Date: Fri, 14 Feb 2025 16:52:38 -0500
Message-Id: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACa7r2cC/3XOQQ7CIBAF0KsY1mKGAWrjynsYF0gHnai0oZVoT
 O8u1Y0aXf5J5v1/Fz0lpl6sZneRKHPPbSzBzGfCH1zck+SmZIGAFpRWskschyCPl8iD9G3MlAY
 ZGgMKnUPylSivXaLA1ye72ZZ84H5o0+3ZktV0fYEI5jeYlQRJPqhdbSpnGlrvz45PC9+exQRmf
 EeWfxAsCNjlDnVdQY36G9FviII/iJ6WUOW8tQDBfiwZx/EBRqyiUEIBAAA=
X-Change-ID: 20250131-printf-kunit-convert-fd4012aa2ec6
To: Arpitha Raghunandan <98.arpi@gmail.com>, 
 David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and scanf), the rest having been converted to KUnit.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf

I have also sent out a series converting scanf[0].

Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v4:
- Add patch "implicate test line in failure messages".
- Rebase on linux-next, move scanf_kunit.c into lib/tests/.
- Link to v3: https://lore.kernel.org/r/20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com

Changes in v3:
- Remove extraneous trailing newlines from failure messages.
- Replace `pr_warn` with `kunit_warn`.
- Drop arch changes.
- Remove KUnit boilerplate from CONFIG_PRINTF_KUNIT_TEST help text.
- Restore `total_tests` counting.
- Remove tc_fail macro in last patch.
- Link to v2: https://lore.kernel.org/r/20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com

Changes in v2:
- Incorporate code review from prior work[0] by Arpitha Raghunandan.
- Link to v1: https://lore.kernel.org/r/20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com

Link: https://lore.kernel.org/lkml/20200817043028.76502-1-98.arpi@gmail.com/t/#u [0]

---
Tamir Duberstein (3):
      printf: convert self-test to KUnit
      printf: break kunit into test cases
      printf: implicate test line in failure messages

 Documentation/core-api/printk-formats.rst   |   4 +-
 MAINTAINERS                                 |   2 +-
 lib/Kconfig.debug                           |  12 +-
 lib/Makefile                                |   1 -
 lib/tests/Makefile                          |   1 +
 lib/{test_printf.c => tests/printf_kunit.c} | 437 ++++++++++++----------------
 tools/testing/selftests/lib/config          |   1 -
 tools/testing/selftests/lib/printf.sh       |   4 -
 8 files changed, 200 insertions(+), 262 deletions(-)
---
base-commit: 7b7a883c7f4de1ee5040bd1c32aabaafde54d209
change-id: 20250131-printf-kunit-convert-fd4012aa2ec6

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


