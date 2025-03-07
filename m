Return-Path: <linux-kselftest+bounces-28525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1612A574B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5911737A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9642250C1C;
	Fri,  7 Mar 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vyv6pbZB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5D7E9;
	Fri,  7 Mar 2025 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385396; cv=none; b=ABgXXyzpDXFft320nGSeed5aXmoj5uWCLZGg5UqLImRLzQw7Et/9LSHeNxFi7HQL7BYBisG7V9nNEYj/cTnJEsxzXIqBdqJjnFKWaZjZTebAP+aQFbjeBYVOezOwInPSnfrM5bx2F/hZACGDQUwDLzDuoI8uOT2yydvfcoAIFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385396; c=relaxed/simple;
	bh=SrDccJOqaJC+5/wA1pdnTwa1tJez7kYmHdz4b6r//PE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CnqY0j0hgcadM5dMZVxaKA7mZvHmm1+Sv0LWJUfUCNMQsd/zXmbZ51ANKCxdN5z5pI+S5mhhPfW7HbwVvJ2yd52d40hKxJ7MMRf5+kPlcl9E4k7nd9skLTbm6GISRtDIoPuzxLfDQW8jBmFzG8C1xI16Z9nXiIzHrOLzkfNJ098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vyv6pbZB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3c9f7b1a6so229542885a.1;
        Fri, 07 Mar 2025 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741385394; x=1741990194; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQDcn8+Kkg+VJ3ToAm89lGpGIwYRFzkG+NUBWjAN8J8=;
        b=Vyv6pbZBaOqzSV0lDiXvc0XABoIT8PCdF3oUsCglzJyMUI2k3ccpcjgH51pBhuXIzG
         wx2sKlFUJyDKghSFExU9W7aAZ0J/qWXB5rsedYEy/9+ZPAnHk5BncdN9/mLAdfRXfE8t
         BjbmvZ1dlrNPHBJrY8jYkv3Obhtz3c0s8j9K82BAvmqaUeQqyU83IX4IYhqOlfVQ5obH
         bSq8wMmBMj7QT5O/n/uFPn+39HLKyleCNMFNlct8VfJjUtZf6m7ZLtLbFDOHMFKHdTfk
         MUIweVINNRr2Lh0j6xPe9f5Fwi3rUnx0Y66QGBV6VZz8+6OXXAlII9/VaTipwOZZT5+t
         z7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741385394; x=1741990194;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQDcn8+Kkg+VJ3ToAm89lGpGIwYRFzkG+NUBWjAN8J8=;
        b=A/2KrLtqr6zppOSUWeU6JBZ2zLECa8386nTUrx+Lomi+qMgSlIXUPVArQQnt8hAulm
         ydTH+T4OS28YPcLjFkMkh05s2L26yk9JmLmQ/8owEMsehsqQmb7FVsBS22N5qVv62M6O
         0xEIBu7rCflMTAgVDP2BMOSj3slQ/9TLlYCyiJKPX6+lHwWXhp/NuTHgh6w6VOsejmDY
         h3vnQkzSCWsfboQm99cXHyzR3FRzqU826wEOOGQipAn3LDJqzMY++AFMOndFvn5BBGz5
         YJBYmBx6h+jWE90gLihFAapBtzIr0/m/JR/SuoqWV0U59HkXxFhsq6Pl8sHfU6h5y+nG
         FKXw==
X-Forwarded-Encrypted: i=1; AJvYcCVeyi0dHNWAE/BaohFgvW5eVrUyqHLtJcp8wVVMnScqRnGDUitC8SaEmwNJlSJ/N3AYuIg7Zx34XVg1@vger.kernel.org, AJvYcCVqbYESK92IGUto/OQuegEtEVjZWc6A36yOvRZefBtL8oEunMAjfhgv8mdsGJhjA4sjLOPSDNtuZXY=@vger.kernel.org, AJvYcCWngjLfVJVVnvHnP+zIT3cTEux7P5/d/o+0jS6Lawl19N9wEH2rUtfrgJ64Alxmo8LB2xyN+rG1fwfsojhDazXI@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcThzgw2cMeG9/xJfQVdiPt/huvb65tfgJDXSNcLnCgiKZsU3
	6qKFKq7D/4KJ1Z7OuWcWhfaOYN8siVreYKX4oeQVyXKsfms0i+BmLtag9Jq2OhE=
X-Gm-Gg: ASbGnctNah9zJYvCJhVqA0QLSBS9YLt/1UeqlSJ/HRBTwflhhZE2QcdBDab3kNoZbpD
	jwFUJLwEzTHsHziD5IeM/vJv5eBI+qeXliW8pPjdHekTKEbl/F14KEdHxVqJSTq1Aoe75ZPsiyF
	sqaFrudW5wwVq+bN4kwc+Bty84uOC354AgkJa5Ix8kscZsal/rexphHgYtta/uNhvmrVaFfaQ1n
	qQkQPMaIbF879ochQwVrQcK6cnZuN/Qs6nIbzvX8tR2GCQvAPsU6C0XiWj5EMH+NkNEkXBhxvPV
	8GmvT+k3KOlHuRtdi4HL7cUqSonq/8nFzDV/cstDvIYnQVVs14jUEeozoQqjWrlkSFbFs0AvgK2
	8
X-Google-Smtp-Source: AGHT+IGQES6u145PCL7njlniOUgI19DACMWBXh7cghgv/R6KrBR+utSuxWgPw2eW3fPWcgc8Tk2fOA==
X-Received: by 2002:a05:620a:4c8a:b0:7c5:3da4:5bed with SMTP id af79cd13be357-7c53da45ccamr69321485a.17.1741385393990;
        Fri, 07 Mar 2025 14:09:53 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a095sm295001385a.3.2025.03.07.14.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:09:53 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v6 0/3] printf: convert self-test to KUnit
Date: Fri, 07 Mar 2025 17:08:55 -0500
Message-Id: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHduy2cC/3XQzW7DIAwH8FepOI/JGEyinfoeUw+UmBZtJRXJU
 Kcq7z7SXVC3HP+W/PPHXUycI0/ibXcXmUuc4phqsC874c8unVjGoWaBgARKK3nNMc1BfnylOEs
 /psJ5lmEwoNA5ZG9Fbb1mDvH2YN8PNZ/jNI/5+zGlqLX6CyKY/8GiJEj2QR17Y50ZeH+6uPj56
 seLWMGCLdJtIFgRoO6IurfQo35GdIMo2ED0uglb54kAAv3ZxLTI1jmmIh7JUIdBkaVnhBoEN55
 cqCI01I+ABtVpaJFlWX4A+w6Oo8wBAAA=
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
 linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and scanf), the rest having been converted to KUnit.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf

I have also sent out a series converting scanf[0].

Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v6:
- Use __printf correctly on `__test`. (Petr Mladek)
- Rebase on linux-next.
- Remove leftover references to `printf.sh`.
- Update comment in `hash_pointer`. (Petr Mladek)
- Avoid overrun in `KUNIT_EXPECT_MEMNEQ`. (Petr Mladek)
- Restore trailing newlines on printk strings and add some missing ones.
  (Petr Mladek)
- Use `kunit_skip` on not-yet-initialized crng. (Petr Mladek)
- Link to v5: https://lore.kernel.org/r/20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com

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
 Documentation/dev-tools/kselftest.rst       |   2 +-
 MAINTAINERS                                 |   2 +-
 lib/Kconfig.debug                           |  12 +-
 lib/Makefile                                |   1 -
 lib/tests/Makefile                          |   1 +
 lib/{test_printf.c => tests/printf_kunit.c} | 442 ++++++++++++----------------
 tools/testing/selftests/kselftest/module.sh |   2 +-
 tools/testing/selftests/lib/Makefile        |   2 +-
 tools/testing/selftests/lib/config          |   1 -
 tools/testing/selftests/lib/printf.sh       |   4 -
 11 files changed, 207 insertions(+), 266 deletions(-)
---
base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
change-id: 20250131-printf-kunit-convert-fd4012aa2ec6

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


