Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF61E421A6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhJDXGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 19:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhJDXGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 19:06:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A55C06174E
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 16:04:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so11353364pgi.19
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bTLk6HK8OPa0GS0nwkteXIFrPCger7fzttlDtWpROA0=;
        b=c7hzuuMzyoYAY62bnHYCb4jz0UQxRkbYpJlNKPaE2VoqWVXupCAi3XUmjS80dBi263
         JaWw3FvLouaZ6pzUl2lWbA0Zz2ZRCTWpJEPHlB8TnBPoEaT/XBT3cJWFfoJcecVZ5pjs
         hxJguuemEFPQJMLo1WUiIxtmjn0nzV5z0lEcdC3KQEP3WFkZdPDrnZwDjmeBxVE9vn7z
         2zLgSb/sj/Tzem86uqi0gXEdH/rak84DMiAzqlFTDdSaRdG81OCuyG4CaRZmvmMLAQLo
         qDaT+2Vz0KbPDooueSvObDJls4c3rYaQOYkrm2rJlbSeRGsSWBnx79AlUxGa8QtHXhID
         iVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bTLk6HK8OPa0GS0nwkteXIFrPCger7fzttlDtWpROA0=;
        b=3mCkb/iXz6oTEUi/GkNgOnpqcj67D4Eo8SPtN36lxXSrJJ1f28II3bjoHSd3RSHIab
         mqAxMYysdB0F2dtlgViJrUUZtasQ9l8/WcThV4+pDTcEIOiBLtwMQTh/H9BlB9HX8Oo6
         k9ut6u3lPCTVjTaDvNOND3urbnv0rf6jToWrpn4z/rp8XPYIULmK1gubgK9X31pLngUi
         C2sjvCVgP7wRRTLa3T8fpIaSQeNCaHH3LC1OUYZnGGSjc+7Ju1TIyO1Ca+tJReR+/sm/
         FB3bx+ummuuc04BgOyRd8qhBka6NU4qclF20CvXr01oD7/BcbTBjX9IjOEiEf9ZkMg6e
         XKtA==
X-Gm-Message-State: AOAM5307S483oRyfh2OhckSCPXaF2qfu4uT8AEWn4s7LhPrByxP1f21L
        z80rRXnAI2/eiwFoD/SunfVBcnSDfw==
X-Google-Smtp-Source: ABdhPJywseErdtKgBHYp4/z7Yp1lUzOBtNo3+SaMbflHl1S90FluFR6TA2oQ9rQiDsXEZUqdtWNFybTS1g==
X-Received: from adelg-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d1f])
 (user=adelg job=sendgmr) by 2002:a05:6a00:1901:b0:44b:e041:f07f with SMTP id
 y1-20020a056a00190100b0044be041f07fmr27116737pfi.52.1633388673658; Mon, 04
 Oct 2021 16:04:33 -0700 (PDT)
Date:   Mon,  4 Oct 2021 23:04:31 +0000
Message-Id: <20211004230431.2321009-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] selftests: Remove explicit headers for clang
From:   Andrew Delgadilo <adelg@google.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, gthelen@google.com,
        Andrew Delgadillo <adelg@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Delgadillo <adelg@google.com>

GCC allows paths to header files to be passed on the command line while
using -o, but clang does not:

$ make -C tools/testing/selftests TARGETS=futex

$ make -C tools/testing/selftests TARGETS=futex LLVM=1
clang -Wall   -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include \
-I../../ -I../../../../../usr/include/ -I/kselftest/usr/include \
futex_wait_timeout.c ../include/futextest.h ../include/atomic.h \
../include/logging.h -lpthread -lrt -o \
tools/testing/selftests/futex/functional/futex_wait_timeout
clang: error: cannot specify -o when generating multiple output files

To fix this, remove explicit paths to headers from the commandline in
lib.mk. We must explicitly remove them for x86 and binderfs as they are
not filtered out by the change to lib.mk, but the compiler search paths
for includes are already setup correctly, so the compiler finds the
correct headers.

Tested: selftests build with LLVM=1 now.
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
 tools/testing/selftests/filesystems/binderfs/Makefile | 2 +-
 tools/testing/selftests/lib.mk                        | 2 +-
 tools/testing/selftests/x86/Makefile                  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index 8af25ae96049..58e41bd98200 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,6 @@
 CFLAGS += -I../../../../../usr/include/ -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
+binderfs_test: binderfs_test.c
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index fa2ac0e56b43..fb152e20c86a 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -142,7 +142,7 @@ endif
 ifeq ($(OVERRIDE_TARGETS),)
 LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
-	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
+	$(LINK.c) $(filter-out %.h,$^) $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
 	$(COMPILE.S) $^ -o $@
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index b4142cd1c5c2..68967006b3e9 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -72,10 +72,10 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h,$^) -lrt -ldl -lm
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h,$^) -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
-- 
2.33.0.800.g4c38ced690-goog

