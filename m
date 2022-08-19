Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9961F59A663
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbiHSTUQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351339AbiHSTTt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973DD4F67B
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 12:19:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334ab1f0247so90471037b3.7
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=FN3l7Edmt0N8hD2i6jpuTBKf9D3zI43oI6ElWLITPto=;
        b=Bw9oxVuL1mAMELgMlLatOutDlRfcfibuHS7Gw4khLfV8nWDrryFaFTnzdZn3sfxren
         0NqPTWft+mcVVbDVIVZq19iU1Ahayk8YBEPxIyyLuh5E23B78obW2Yxv1OB+To4Aasta
         fCVHg5lzI4hthdRL/CdRCNSdTLkr3SOmoDGHwv2gZiYyiUXLyWnsNfFPdyCrBXioTAe3
         0CUTZBzcknar9aL2UbV9WEw8MHWjNXWfuu4roNfPfS/o0Di0da3tEV8oEFRiPUxM4jAm
         zz+rDt9NdjR3WyAqSpMGQ6gxSKLVUvyIa/1BvU8bp1vsx2sEGvCPUwvpLGkDDVC8X6VT
         BHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FN3l7Edmt0N8hD2i6jpuTBKf9D3zI43oI6ElWLITPto=;
        b=mszOtwxIFrAyqy2BfXo6KnpgYYcXetu26axXKdjxzmCPhPdAOlKMkmdJrUEzGDXgp8
         EtsPePVIFIQFhSqWdNxhf4RLI8PueLR/y2J6LimBL2WklgiYlHFvknx9CiebL27bIwMV
         2/6Qpaapc+4sxmCQaqaQVni2zBCehgS7JNucA2W4UBwsK1qU+n55rvAodZ8nCzbKUHgL
         teSIA/ZSeGm5uYMnnIGdp7As1d2xKt1EznShaBkcmfMRBmtbqiOaVr8BbAw0CvD+Dpdb
         jS9gMBvE1J7eG1s3UCyHfkoSd8fi5jmHu32w40aa1BiT2FnQB96cEUGT4EJqxIsG1SCN
         5jnA==
X-Gm-Message-State: ACgBeo1C6OKf3NIB/WOJE8xiBv6z5hJb2iuWUk9a0Tu39lm0TapWXbrM
        iJ+sKPEBNW9Lf1h3qHQFX9m/2JVJFrWHuCLk0Syx
X-Google-Smtp-Source: AA6agR6pQKrmoSd2Cuf9uYE0qJgeOlGD73u5ApSsOVKBUEzalfKaGHLjncY5Vt7iMPjrqZKhAvEfz7m2wAkDHWBAAYrt
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:676:8328:93fe:a318])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:10c:b0:671:68b7:ab41 with
 SMTP id o12-20020a056902010c00b0067168b7ab41mr8569977ybh.608.1660936774945;
 Fri, 19 Aug 2022 12:19:34 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:19:29 -0700
In-Reply-To: <20220819191929.480108-1-axelrasmussen@google.com>
Message-Id: <20220819191929.480108-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220819191929.480108-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 2/2] selftests/vm: use top_srcdir instead of recomputing
 relative paths
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In various places both in t/t/s/v/Makefile as well as some of the test
sources, we were referring to headers or directories using some fairly
long relative paths.

Since we have a working top_srcdir variable though, which refers to the
root of the kernel tree, we can clean up all of these "up and over"
relative paths, just relying on the single variable instead.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/Makefile    | 2 +-
 tools/testing/selftests/vm/gup_test.c  | 2 +-
 tools/testing/selftests/vm/hmm-tests.c | 4 ++--
 tools/testing/selftests/vm/ksm_tests.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d9fa6a9ea584..d516b8c38eed 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,7 +25,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index a309876d832f..e43879291dac 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -10,7 +10,7 @@
 #include <sys/types.h>
 #include <pthread.h>
 #include <assert.h>
-#include "../../../../mm/gup_test.h"
+#include <mm/gup_test.h>
 #include "../kselftest.h"
 
 #include "util.h"
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 529f53b40296..98b949c279be 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -35,8 +35,8 @@
  * This is a private UAPI to the kernel test module so it isn't exported
  * in the usual include/uapi/... directory.
  */
-#include "../../../../lib/test_hmm_uapi.h"
-#include "../../../../mm/gup_test.h"
+#include <lib/test_hmm_uapi.h>
+#include <mm/gup_test.h>
 
 struct hmm_buffer {
 	void		*ptr;
diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index f5e4e0bbd081..0d85be2350fa 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -11,7 +11,7 @@
 #include <err.h>
 
 #include "../kselftest.h"
-#include "../../../../include/vdso/time64.h"
+#include <include/vdso/time64.h>
 #include "util.h"
 
 #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
-- 
2.37.1.595.g718a3a8f04-goog

