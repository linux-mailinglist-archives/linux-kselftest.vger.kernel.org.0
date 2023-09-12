Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED88E79D2D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjILNvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjILNvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 09:51:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4EFD10D7;
        Tue, 12 Sep 2023 06:50:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C146EC15;
        Tue, 12 Sep 2023 06:51:35 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642633F5A1;
        Tue, 12 Sep 2023 06:50:56 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Florent Revest <revest@chromium.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, oe-lkp@lists.linux.dev, lkp@intel.com
Subject: [PATCH v1] selftests: Link libasan statically for tests with -fsanitize=address
Date:   Tue, 12 Sep 2023 14:50:48 +0100
Message-Id: <20230912135048.1755771-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When dynamically linking, Address Sanitizer requires its library to be
the first one to be loaded; this is apparently to ensure that every call
to malloc is intercepted. If using LD_PRELOAD, those listed libraries
will be loaded before the libraries listed in the program's ELF and will
therefore violate this requirement, leading to the below failure and
output from ASan.

commit 58e2847ad2e6 ("selftests: line buffer test program's stdout")
modified the kselftest runner to force line buffering by forcing the
test programs to run through `stdbuf`. It turns out that stdbuf
implements line buffering by injecting a library via LD_PRELOAD.
Therefore selftests that use ASan started failing.

Fix this by statically linking libasan in the affected test programs,
using the `-static-libasan` option. Note this is already the default for
Clang, but not got GCC.

Test output sample for failing case:

  TAP version 13
  1..3
  # timeout set to 300
  # selftests: openat2: openat2_test
  # ==4052==ASan runtime does not come first in initial library list;
  you should either link runtime to your application or manually preload
  it with LD_PRELOAD.
  not ok 1 selftests: openat2: openat2_test # exit=1
  # timeout set to 300
  # selftests: openat2: resolve_test
  # ==4070==ASan runtime does not come first in initial library list;
  you should either link runtime to your application or manually preload
  it with LD_PRELOAD.
  not ok 2 selftests: openat2: resolve_test # exit=1

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: 58e2847ad2e6 ("selftests: line buffer test program's stdout")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309121342.97e2f008-oliver.sang@intel.com
---
 tools/testing/selftests/fchmodat2/Makefile | 2 +-
 tools/testing/selftests/openat2/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 20839f8e43f2..71ec34bf1501 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later

-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
 TEST_GEN_PROGS := fchmodat2_test

 include ../lib.mk
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 843ba56d8e49..254d676a2689 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later

-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test

 include ../lib.mk
--
2.25.1

