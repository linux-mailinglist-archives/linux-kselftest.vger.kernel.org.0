Return-Path: <linux-kselftest+bounces-27219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3FA40119
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A0E1890E9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8F2045A1;
	Fri, 21 Feb 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyo7YSp3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D9205AA7;
	Fri, 21 Feb 2025 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170078; cv=none; b=jcKr3SCTEUf0COo7fEzUaOWKDzwCJIWcsfTWaNZ+LqeVZg67i5i7gtXymhdWcK7Jj7LiXJvV4uXGcfrrD7O9tWx5gy9EYzZDldBwVXuHldQXypTxICeFINKZIaoDrppqlbE5uxJWdNxSOzLA1FNUV1+SMf8/EI7gIzvfxsF6cYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170078; c=relaxed/simple;
	bh=IjQZWCcChkAfXgxXMTbda7fIUbIn/z7Xqt4ADbGLfzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q0+yZ0eBuyFTIyet7vbN7g3gd/aRTGj0qWZ8gHnynySMxMYwJ61/F9nxkxjjERg16/hgdKOiO+r8n07aYNUc5ffP+DZIqkA9WPC6+leOMTQVbqyrllSnP7poBzsp3ZWRHWJFFIR81SaSPjKFlu6p0VvGIQIAnIxTd4kkC7VI3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hyo7YSp3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e69db792daso21081466d6.0;
        Fri, 21 Feb 2025 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170075; x=1740774875; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2QU0nOb5+Ymoq25Hm5zfDRVAmAik5t7toGKHPu7gD4=;
        b=Hyo7YSp3kRUX10cAaamokHoFpNZ9WsJl8JiFBsyyt5IQ2yVlvfhqNu7Vw3z5mfwTOy
         VJ0rhc7/GH513JXFLpBpxa5UeD5smwTrtz24FRPyq1GpzhLa5+xnPfWDBys069Y21VaR
         aGkVVcp0BpqNtytoZuYv6z8XIRSzkuduP9ADF+TOrKirs/5KsnODp+pVfdjfeLHa6u2B
         2HuwucOVbx/27jUM8FakoPZUzIBAjJs/aTQkC3mggpDfy7lTZdlyrkWalMCeFsbHdlwO
         4cK6PQXzlpaT8FgutvF8j4nVAKOmOZ7jkV+TzayDuWf9Z86ek9hU0yFF/PSLRP3q/Z/Z
         aOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170075; x=1740774875;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2QU0nOb5+Ymoq25Hm5zfDRVAmAik5t7toGKHPu7gD4=;
        b=kEzuCVTHj1eCq4pAw7no+7FGc3wB6lFa4K21m5KZnIK6VOo0pcVHpsTEm51kuDS9Wt
         9jMnQR4JMQP6a2KRlo/NkspNp1EF4Fdp4Lzl1uj1axb0ie4irxpNJEEayAIhseD/GO49
         4HodJuZIbD9wecVasE7yAAg65CsCeyvcX0XoylHxivRvOfxcNxePvqDBgAcZZD6tKCN7
         nR1O/o4ZL+8oFV7I82ZojYjld08Q436tCI4Iq1oTwzF0QsJZn2S16VUvhRnaFXGeX2t6
         XEc8OkICSmbX9G9tWV7jck0mgfr2QXOjVkK8NNyDUvDoRe0duMIBkgOPNxnd9fkg5d3R
         LFHA==
X-Forwarded-Encrypted: i=1; AJvYcCUp0ymnloiEMBZzF0dGva6NErdeFGFNp1z1MPoSJSuHhMR5txuYNkimKi+8+3jVjBo0MuZtJ/gmlLo=@vger.kernel.org, AJvYcCVnUZErYgA+SyOrg0FqP/u7G1vLOQwu9mkE0Pjo/grt4uGNYIrhJdX2nhwOnyJlBZFQRYu7UoIAYNf3/UW0YGP5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0m0LZ9IL2g2WKFDjnkTRPPziVyFaC1rSxQYyGrv4AmU+wGlW
	jEDSJxHyoTvkZTw4QhmrPlHZUZN9dnB0hoWFHt85V5sbkva3ZETtge3DHRyc+pk=
X-Gm-Gg: ASbGncvj739YFgubv2m7Ol+zOw+5oJDQxfsSaOPyQs7yy4s8UAVj3F/70cwatnS6Sbw
	3Y8wANWYNSi7HI3XkCq0HMS6VAV3O07CLyzNE65qbAggpQBDFGc8VkG9j8qo376qZGACF1Sr3iT
	oZ2dOAxTpU+npmT1pdC7Tj30Q1K9Eubgt+3lHLX63jGoOjsal7rMRG6jym6I3vR7KdHSykn1yyD
	fOgrzM1vfmBFKJvtudEcjJdp+t3VLpIpWMfgoH0Ca1BllraMc2ikakdJ0MexpFdv+ejpIPKSLpH
	ey0I7bxGu/hzC98KLIAPJT4fmPZMCrxpZF0SwcGs1Pji/5PNaw==
X-Google-Smtp-Source: AGHT+IHGad2s1TxSW80R91JGuuyplh1yLb8ON8Nsn5tAfbzywmLJ9mTYusIE0wz9lRGU2BfVKo1N8Q==
X-Received: by 2002:ad4:5aa8:0:b0:6d8:848e:76c8 with SMTP id 6a1803df08f44-6e6b01d78ddmr55815896d6.42.1740170075129;
        Fri, 21 Feb 2025 12:34:35 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:880f:47d4:56c6:b852])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f36easm101677546d6.74.2025.02.21.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:34:33 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v5 0/3] printf: convert self-test to KUnit
Date: Fri, 21 Feb 2025 15:34:29 -0500
Message-Id: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFXjuGcC/3XPwU7DMAwG4FeZcibIceK04sR7IA5Z6mwWLJ3SE
 oGmvjvpuFRAj78lf/59UxMX4Uk9HW6qcJVJxtwCPRxUPId8Yi1DywoBCYw1+lokz0m/fWSZdRx
 z5TLrNDgwGAJy9KqtXgsn+byzL68tn2Wax/J1v1LNOv0BEdz/YDUaNMdkjr3zwQ38fLoEeX+M4
 0WtYMUt0u0g2BCg7oi299Cj/Y3YDWJgB7FrE/YhEgEk+tPEbZG9d1xDIpKjDpMhT1tkWZZvvMB
 DE4cBAAA=
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
Changes in v5:
- Update `do_test` `__printf` annotation (Rasmus Villemoes).
- Link to v4: https://lore.kernel.org/r/20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com

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
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250131-printf-kunit-convert-fd4012aa2ec6

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


