Return-Path: <linux-kselftest+bounces-8261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC38A8871
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CF61F21358
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB61487D2;
	Wed, 17 Apr 2024 16:07:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AECC1487C0
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370077; cv=none; b=TzYQZx2CdFb0mELnlEZtP0pQlqNTBmNNq5UhXcqGymN5+MMn0Feb5GGFwQLdmT1QabnffhW+4NJXIDeU/CxNEi5vSHc49kf5uB/Y+dbjR2h9QC29cJC3k/4a+zQPTgE0VDIwQZofUegKOV7RoInW1DpKNRnhGu2XDKMFKQAZiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370077; c=relaxed/simple;
	bh=CQbouKF6TmFvPaEviWNdSnywfj9tnXssXppxPfpOkUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IOBoNcw3E06g6dwl2E1LcjqxBs4DhVTNi52P/IfHbrUIAi9wet8b1WSssRj8HmX9RuKmZp0FsO7y3pEhbsDcAZG115d4XsYOl33ZmBOREg+S9jWFml9I9TddnmE/vJEJSuIikVvp6san5/5OF2aEQ8CpQ74O7m5OEdM/70sdb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B002339;
	Wed, 17 Apr 2024 09:08:21 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B64F3F792;
	Wed, 17 Apr 2024 09:07:52 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel test robot <yujie.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] selftests: Fix asan linkage to work with clang
Date: Wed, 17 Apr 2024 17:07:40 +0100
Message-Id: <20240417160740.2019530-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both fchmodat2 and openat2 statically link against libasan (for
explanation of why, look at the fixes commit). This is done using
`-static-libasan`. However, it turns out that clang uses a different
option, `-static-libsan`. This caused clang to fail to compile the
tests.

Fix this by using cc-option to figure out which variant to use.

While we are at it, stop passing helpers.h as a compilation unit. This
was causing another clang error due to name conflict with helpers.c's
object file. This header shouldn't be directly compiled anyway.

Fixes: c652df8a4a9d ("selftests: link libasan statically for tests with -fsanitize=address")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202404141807.LgsqXPY5-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on v6.9-rc4.

Thanks,
Ryan

 tools/testing/selftests/fchmodat2/Makefile | 5 ++++-
 tools/testing/selftests/openat2/Makefile   | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 71ec34bf1501..a68bb5a00797 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include

-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan)
 TEST_GEN_PROGS := fchmodat2_test

 include ../lib.mk
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 254d676a2689..02af9b6ca5eb 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,8 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include

-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan)
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test

 include ../lib.mk

-$(TEST_GEN_PROGS): helpers.c helpers.h
+$(TEST_GEN_PROGS): helpers.c
--
2.25.1


