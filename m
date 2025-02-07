Return-Path: <linux-kselftest+bounces-25992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B6A2C1E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C12162A93
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42DD1DED6D;
	Fri,  7 Feb 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpJH5huM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56B1DE2C5;
	Fri,  7 Feb 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928963; cv=none; b=ATaP35hqpxJXBgqVoy6ORU+euxuHR15tUwJYMN547VHNjg7oRxuvd5YzGXvFOCoE9g/uXLPmYDDQffrlZJPNn5rCfzgUwUhDm76Cal0FlxKSW3LGq+AanBxhcZmCDAPJWbCsvvG90l7w+wDSG+v/KdamzyNF/H5dLidg4P2OaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928963; c=relaxed/simple;
	bh=0Yf/Rfr+NHX2/Q4mKwJy176ogs/lxV/TndOmxnrns74=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BvGE4BXkgCtZkMKkrA3HMup6YzQ2lSu3azHkxLz0jaWqSrLvsxu9mj7E8mj9WB7qVYnRQVRrP86RwoIc4E6UuJQU1/UMDhatbW+VtAlk88uBqhZeJnwavAXZM+kAHPHoiHRgP4V7K53qdG1W03kfxI/+ufPdiBd4Ejk2y8zGNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpJH5huM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4679eacf2c5so18810791cf.0;
        Fri, 07 Feb 2025 03:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738928961; x=1739533761; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sw/J6qj2MKqhorzz/+v7HPrex3uNLaL4DKE5oDSkpI=;
        b=WpJH5huMEHBjpA41nvYG52gMEWJl+Wu31aeD5ZL63JMRQjCiA0IPHFagAWP7f7NcPj
         1R7h8khC4OibOBnGE8ha1ihtXl25j1QvkKbCrbU6b2+InhZeCs4tygSXcTUhWa6L9O1L
         jf21Bj5rM3kW5iKPSHr+gLvZhXnUc9qeGLGf5UUdYcGmr0GO4mH54w7UDrUG8fTl+erh
         Hx2Z0wVMf66vi8UeQxg5LhqTAW0uze+yMfQY9ocX+vLAP4thkx72uIZKIYOAako4E2Rt
         EtgudzC4IXS7CvNu/mw2J6KIup//GQ4Nn7mMCHPuhiId4edZ2Ef4V/MVWAgEVugvzTcr
         oh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928961; x=1739533761;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Sw/J6qj2MKqhorzz/+v7HPrex3uNLaL4DKE5oDSkpI=;
        b=PnIunVrrYuNrVWeeXWuqAwMJHyW2biZZq3K0IoFbmhb+K5BY1wNULA+8eJpTH5kT6+
         7yk7ZaEd5MtmFAqDNFyfDdaJH4k7O9xHsqlC3Wvhm5Och76x/1Ma37Nn7U7mCpguScO6
         x8hzewUeP+IqtSZ4X0jUp/H/je9rc9eftn9sk1BeEClDz/RJGBOy+psIl8ujLNzUpDVl
         Qff202+rCgBzCwSQkhHJQGUKPtQ5Vb/23qEsv8BUFDAZ07xQFMLCRqrBq15D4dhvS4SU
         s9uR4PIvkQqb8xU/HYuO5IpJEJB6uHMeQX1f/7YEzf7hTaDKXNhYLIyHryE6GK6/uieX
         G6kA==
X-Forwarded-Encrypted: i=1; AJvYcCWAXwT3lZZnTtRJSdYkwVBYx0wMiq9JdFAXG8z+oJcCDisFgG5U7NobyDpyqONN6Xf5CDqeQxWh6pqCYm087iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+x4VH7Q5iAzXaFki0StBGsU8AAh024E2lRu3uyeHRBdVpyzpl
	9koT7H1a7Es1YVSOvCUy8IqQXLOHCGEH09PVkOqt0rbpfq6AFgr/
X-Gm-Gg: ASbGncuP03JjYXGoPLklgzysV8MsTol4+bnTm2zjDl9M7olslPfF6hZGXpsY1OdhfuV
	ZV07vwMj3/wBjTGjo+iSGQOnmXeK+X/tWfmBsdBQVmGNFgczOI90EXXLmjt1mnbRZhxgAZE/60w
	lfC5EWbIVpfa15kCD+OKdbnXwEsbAgRb5h725mkwVRIli4Yd1S9fZ4xGrjwVl6lkA1XzhDbeSPf
	qOd9qTSRIutIIegO9vdJJBnaxtjC7e3lnt+tMyxgx/IcAQTLX700GarAhIan/AIFl/KB5VkgR4i
	93wbSBVKac7TycZEuJiAUpyrU+GnSSETP0w8
X-Google-Smtp-Source: AGHT+IHkFVQChPxz9j2Un74KGPPMKNixrHI7/GTnMnz7ga7iR+in4Q1VqQqga8PB9wfht5h6kyyAqA==
X-Received: by 2002:a05:622a:281:b0:467:5712:a69a with SMTP id d75a77b69052e-47167a2b105mr39805311cf.29.1738928960844;
        Fri, 07 Feb 2025 03:49:20 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492763ebsm15533731cf.1.2025.02.07.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:49:19 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/2] scanf: convert self-test to KUnit
Date: Fri, 07 Feb 2025 06:49:10 -0500
Message-Id: <20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbzpWcC/33NQQ7CIBCF4asY1o4BhpbqynsYF5ROlajUQCWap
 neXdmNjjMv/JfPNwCIFR5HtVgMLlFx0nc+h1itmz8afCFyTm0kuCy5QQLTGt3B5eNeD7Xyi0EO
 reWMR6xqVZfnyHqh1z1k9HHOfXey78JqfJDGt/70kQADf6rKQquVUm/3pZtx1Y7sbm7wkP4bk+
 NuQ2ZBam1JUTcUVfRu4NNRvA4EDVmWjLRJpoZbGOI5vnxPVxz4BAAA=
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
 lib/Kconfig.debug                    |  20 ++-
 lib/Makefile                         |   2 +-
 lib/{test_scanf.c => scanf_kunit.c}  | 260 +++++++++++++++++------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 20 files changed, 149 insertions(+), 155 deletions(-)
---
base-commit: a86bf2283d2c9769205407e2b54777c03d012939
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


