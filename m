Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81D07A1BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjIOKDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjIOKDw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 06:03:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5135A9
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 03:01:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1661510f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694772077; x=1695376877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YXFI+WhfAISDbsXD1xioqZrn+hF0Uu9c9p7iUiwhwc=;
        b=deGzgNWQix/q7NKb17Nk2nCXzUBteH08tH4BnpE+JPpoinZr/yNgvOLzGa0as0qloq
         Sk/9/2e/iIwsNF4mcplA0+7ROleKXuVwk1vswydk7BPDTPINzmeCZ3GhJc7QgdgLAZiS
         fA79w+nIuy1EYxy6RvostX31XC0G4896EwWgESDmm9bYOj5+yGvwFwEZhz262yAPObk9
         qxRDrXT6fldL7CReO1TEtTGAQetrAhjDxEc+ObxgkJNXk9Dt7MmpP0u8Twa9eNd0fbFI
         80Tf75AD4PSXWMxmXITdfrGQ+wFwQRaN2K1UAPs/KcAX0wbOlImAOh5GwXPojtSlpiob
         lACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772077; x=1695376877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YXFI+WhfAISDbsXD1xioqZrn+hF0Uu9c9p7iUiwhwc=;
        b=TjB5ULsyVeVZApIlcgfb2F3DNum0TGGLqAL4D6ZcrJEO/hYQPU4OjklbVpi8SLTj5e
         ppmbPdbZOT4hw/e0rq7W8njDUdX932K2Di/g1C6g4kZQsjcPVaOo8p1QZ5nbOf6xYs8x
         YvI1xcpo+OjepY2iUjqihT9XHybp1Yr5RJMAC5i9WkFGSz1SxQpLvkO5Hbz62Pvk/Fae
         ub0SxGK/i9j9reT02cX97LiZBDZGTC6poIJHtYPL2JKTuEVctdKboSqBf5NHtXlIgmKw
         RaYCLW3i1DPhaIeBYQAXfY5dQkc0W3PETERhENMAvr6gErNCv4gYY21K73vbBdxQStRU
         3XPw==
X-Gm-Message-State: AOJu0Yyrz1qqrTfB3B47vbPBfyb9x4hslRLhx2tW+Gbw3Zd4qXdH0q4L
        o3tYMqAVFw6wq5pbVMdkTl7kskj97DVlxyIPkgA=
X-Google-Smtp-Source: AGHT+IFjJ+aht9zx/gPFks21b7hJ4FuUG1vcbtzV4LI5E5IEoy/v218pa5LbKYLuHYFo6Stc9Z5KtA==
X-Received: by 2002:adf:a303:0:b0:31f:f84e:f63e with SMTP id c3-20020adfa303000000b0031ff84ef63emr540429wrb.54.1694772076646;
        Fri, 15 Sep 2023 03:01:16 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f4-20020adfdb44000000b00317f29ad113sm4057900wrj.32.2023.09.15.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:01:15 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: kselftests: Fix mm build by removing testcases subdirectory
Date:   Fri, 15 Sep 2023 12:01:13 +0200
Message-Id: <20230915100113.13131-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftests fails to build because the mm/testcases subdirectory is not
created and then the compiler fails to output the binary there.

So fix this by simply removing this subdirectory which is not very
useful.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/testing/selftests/riscv/mm/Makefile                   | 6 +++---
 .../selftests/riscv/mm/{testcases => }/mmap_bottomup.c      | 2 +-
 .../selftests/riscv/mm/{testcases => }/mmap_default.c       | 2 +-
 .../testing/selftests/riscv/mm/{testcases => }/mmap_test.h  | 0
 .../testing/selftests/riscv/mm/{testcases => }/run_mmap.sh  | 0
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_bottomup.c (97%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_default.c (97%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_test.h (100%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/run_mmap.sh (100%)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index 11e0f0568923..c333263f2b27 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -5,11 +5,11 @@
 # Additional include paths needed by kselftest.h and local headers
 CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
 
-TEST_GEN_FILES := testcases/mmap_default testcases/mmap_bottomup
+TEST_GEN_FILES := mmap_default mmap_bottomup
 
-TEST_PROGS := testcases/run_mmap.sh
+TEST_PROGS := run_mmap.sh
 
 include ../../lib.mk
 
-$(OUTPUT)/mm: testcases/mmap_default.c testcases/mmap_bottomup.c testcases/mmap_tests.h
+$(OUTPUT)/mm: mmap_default.c mmap_bottomup.c mmap_tests.h
 	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
similarity index 97%
rename from tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
rename to tools/testing/selftests/riscv/mm/mmap_bottomup.c
index b29379f7e478..1757d19ca89b 100644
--- a/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <sys/mman.h>
-#include <testcases/mmap_test.h>
+#include <mmap_test.h>
 
 #include "../../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
similarity index 97%
rename from tools/testing/selftests/riscv/mm/testcases/mmap_default.c
rename to tools/testing/selftests/riscv/mm/mmap_default.c
index d1accb91b726..c63c60b9397e 100644
--- a/tools/testing/selftests/riscv/mm/testcases/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <sys/mman.h>
-#include <testcases/mmap_test.h>
+#include <mmap_test.h>
 
 #include "../../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
similarity index 100%
rename from tools/testing/selftests/riscv/mm/testcases/mmap_test.h
rename to tools/testing/selftests/riscv/mm/mmap_test.h
diff --git a/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh b/tools/testing/selftests/riscv/mm/run_mmap.sh
similarity index 100%
rename from tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
rename to tools/testing/selftests/riscv/mm/run_mmap.sh
-- 
2.39.2

