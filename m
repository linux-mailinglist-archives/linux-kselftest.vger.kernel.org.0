Return-Path: <linux-kselftest+bounces-26200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA13A2F6D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B078018822B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC0255E45;
	Mon, 10 Feb 2025 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbnDdv9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA325B690;
	Mon, 10 Feb 2025 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211806; cv=none; b=LBYHc0EqOXpBNsayeAWGrAU5pxza3Lyl5lNupGA7SGsEB8Iii1hgyW5XRKoGtD4WkH64RwvnJtQ3PHQaoDYvPu+rXfuppoQpeqKzSEA3P+fKi5EHb8fXf4WFp849eZ+DzGNIX9kDZ5EfvLEjeVEqgS/AUSizAEaGqVet26cBVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211806; c=relaxed/simple;
	bh=eqq5ajvjea3MeOhWfO3+dxXQWvINLCgWfRuHmU74dSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FYyisZuZ6JxK6Z3eL41K+Y+ro+bzgxJnmNyy5l1HAiiVrkqZk5hyZ0W/uS4E6xog/LKX+VcnHqpASW3zEWHIm+gg0qwVs7Fjh2PmJSeQCO7gQ1rpQERbztVVmLwe7oEy8f0tShZzOnp9hE6d4qs1td7yygBK/Yl9hdVQvjypMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbnDdv9F; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8e8445219so37832656d6.0;
        Mon, 10 Feb 2025 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211804; x=1739816604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zywqNIFDXEwlE7hLyD+JRB5FcKOg2ioCGIncmY+HT84=;
        b=MbnDdv9FMhidJwSyokcNQpwikdHGjbCZGKdKBTrQsT7bYd9VqR6TUYZLqWAsRSuk2D
         Bz3mpdAahrmKmE+Y4xo1x63SU3TU7UImeEd+1Bmsv4FJk1iflTllkQVidPcqEbtQA81W
         FuePaX2t1Nd+05CUIIcCuD9MII3Mdh4pGH3EtiQehrGoUwiMj6Ar6jYNNcU4KbeDZ61+
         APSufWC2Xojj55ifCtOobZ6fIOO71UMWxhUqtOuwYzsHJDwm5dGpr8wLwORQvZKbGfYr
         /RR804as2O8a9G1zMYv0eyujlY9H0HE3JR8t1ZmXErpNRO+bkR8Txwn3G/DlHyakWkGj
         OfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211804; x=1739816604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zywqNIFDXEwlE7hLyD+JRB5FcKOg2ioCGIncmY+HT84=;
        b=FpvYO+RZNTjoT+hLg1au7oZa485RaGynaPZNPJbR5XIiN3W5uvMwM/0VMKKWtxMp8H
         6LinpmJXr/6J/27dPuEQPdE5vEOdiw3XlwhYVLepBykezCNM+9Qidcs/1iIJEa0snmtQ
         4e5E20K4U457LpfUWLp1uWwk/ViEx1Fc2WoRWGwXvPmF7ELSotmuCWENn2GePZTDHHM5
         ba6bNeLZxRTwa/05RZNl55kugtVJemxo/F/8SvrgLXKFHGhF+l0tKBc4++t+3cI8/xrN
         SnCsP6nPHghh3bxbdnpwvH0x+kRNxoQaRT4vO8DSSjw12+vhE9hC4RVZ2kNr6sR23Vx2
         wmuA==
X-Forwarded-Encrypted: i=1; AJvYcCW5nircOLbVEZVqh29DHWfmG0AFn5pi7yzJYTg6KoNckDX4MmfNlKBwFysTbBkRarQczJzG81iU4bo=@vger.kernel.org, AJvYcCXVuMxgKqnDBGa+jh2E2/0t+O5djOeeM3fYE/SNz6ATu9FFC0TDletGpdkAz9WxpPlvER8YbZ9JYQmdVRv2K1iK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QYDSoyyreii5m426juRuFwod4JH6MSih/BCemIWot1Fdapw4
	GH/bv6OKTNNLp2BfcjYCeGkeXWbFl4Z/2rS1dnD+DdxPz5ieJ/OF
X-Gm-Gg: ASbGncsGo7b3mNXX8rBHrZiUYnLzPHO5WNcGKxP8oUUUbgb2OHicrdKPsaSZ5TIrxxc
	rcmfG9PR15o5tVsW8cRGUQvPv1nYvcCpBW6QTpgKr9l1tn6sQjqItCi1cXznqJPkMArgUOq2ZNk
	+7vxJbeG1idMU7eFEQe984O2vpK1ak+0KQzn80ZBoIvoRQ5lDHgxcBM6YXKf6gdETs7wrDm/Ope
	i0Op5flE0iwepOtIPhCei8kn2f2OjigHsAk4vXzNUHDjVcO2jnnQ8l4UR2khcv2y665fHskDRN9
	djUgyxy9wkuhRsFYFIV+rPM5vK6ip5008ZoPG/MO1NS+Eu3ubACqxjUHTmaRnln7mMmQVDnHSXL
	lMj+jONZc/T2myTc4dQUSYdtg
X-Google-Smtp-Source: AGHT+IHJUbDxjdCsNNj+OQxZXpiKoN2yODdzK86kuSDraz80IM/wj9UOVb/ft5Ok46q9atDDV1Hi/g==
X-Received: by 2002:ad4:5dea:0:b0:6e4:29f5:b8b3 with SMTP id 6a1803df08f44-6e44562d887mr219755746d6.20.1739211804219;
        Mon, 10 Feb 2025 10:23:24 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e440d902d3sm45436456d6.7.2025.02.10.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:23:23 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/2] printf: convert self-test to KUnit
Date: Mon, 10 Feb 2025 13:23:21 -0500
Message-Id: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlEqmcC/3XNTQ6CMBCG4auQrq1pp+UnrryHcVHKABO1JQUbD
 eHuFtyw0OX7JfPMzEYMhCM7ZTMLGGkk71KoQ8Zsb1yHnJrUDATkQirJh0Buavnt6Wji1ruIYeJ
 to4UEYwBtwdLpELCl18Zerql7Gicf3tuXKNf1C4LQv8EoueBoW1lXujC6wXP3MHQ/Wv9gKxhhj
 5R/EEiIyMsaVFWICtQeWZblA0B3Ep79AAAA
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
Tamir Duberstein (2):
      printf: convert self-test to KUnit
      printf: break kunit into test cases

 Documentation/core-api/printk-formats.rst |   2 +-
 MAINTAINERS                               |   2 +-
 lib/Kconfig.debug                         |  12 +-
 lib/Makefile                              |   2 +-
 lib/{test_printf.c => printf_kunit.c}     | 429 +++++++++++++-----------------
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/printf.sh     |   4 -
 7 files changed, 192 insertions(+), 260 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250131-printf-kunit-convert-fd4012aa2ec6

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


