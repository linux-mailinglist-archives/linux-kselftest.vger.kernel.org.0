Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D974E4466F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhKEQ2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhKEQ23 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 12:28:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81DC061714
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 09:25:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g3so15868538ljm.8
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UrGzSNLl9hkWQ6FY0wrjlvm9IW4EhNpFnEOVw1+6lI0=;
        b=cVjspeqH37diRa4ySe6S2iiA1czmxfOtOWLfHoi5JdPW0nCQu/RUnglVsGr+rjbT6k
         u7eO1hSzHFioTYrxlCnLamDqmnjFC8lyLVdRPA3WCX56FEwRTsfbrZzX0yFKWlAIC18F
         0OTX/yMqnJFwPLjZcYAIEAsY5ncjbglIRVQ0TeWRNyPYuj/m4owkRTqfjkA5IOWPVUhk
         u4K3Pp4t5kgqyBpmbr0jy3gl3wS8BOJ4pNH3M6cPTnnKsSTWCcty+KuzN7c9gpU/Se5H
         OgXaAF0fE86e0wiqbxTbPyCRpV4OIwtXpFskRbopwuQ7RWJKvecgZ7YxM37qV7V51xsH
         o1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UrGzSNLl9hkWQ6FY0wrjlvm9IW4EhNpFnEOVw1+6lI0=;
        b=ouQsG87yipiSxyYrCzDGNHKf2HELB0BU2WBPXxsGC8XJCE5cp74m0S9XxDMj+HSBmr
         liQJF4PjUbMxmFcE1BK8sgpMPjpVYk++KXnGZkaqeKRtDo/tiIp+KgLXm0eX5wXJupxW
         hLn18Qox9idbZEht2YgWI2Y/TuWeVrF4MlXGkjRa0DabYI+9XHWo+U7Td+K9ujQskPKC
         c1dUTwqF65FLjs4+3/nWURFG42phF6wr/qqvoDo9VPcE3uiodMEMChEf+nzyYGFE+VmP
         pjnDZT/0RwNikFrMaQV6OV/KPdDDJWJ9z+qQPWsxpuS/fN5guxxAKMJTvvRAxv6XMa9m
         JOgQ==
X-Gm-Message-State: AOAM533W6I3QfG+o4SkshoNm3WGyyBE+o+boLYbjfqH9QA7O/ItAoCCs
        2w/KAg5YXzXhAkbSD6Cpz/DYkQ==
X-Google-Smtp-Source: ABdhPJxc+p+Sfr1lDnaHzVQSMv9ex6Kr2Ycy5rJpErG8VNnPs4Ud2FdjIX/NFVqB/7lmod7aZKjflA==
X-Received: by 2002:a2e:b8c3:: with SMTP id s3mr9383633ljp.496.1636129547776;
        Fri, 05 Nov 2021 09:25:47 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id x20sm874133lfu.196.2021.11.05.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:25:46 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, christian@brauner.io
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] selftests: cgroup: build error multiple outpt files
Date:   Fri,  5 Nov 2021 17:25:29 +0100
Message-Id: <20211105162530.3307666-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/cgroup: with clang the following error are seen:

clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
clang: error: cannot specify -o when generating multiple output files
make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1

Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
file lib.mk.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/cgroup/Makefile | 12 +++++++-----
 tools/testing/selftests/lib.mk          |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 59e222460581..745fe25fa0b9 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_kill
 
+LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
+
 include ../lib.mk
 
-$(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h ../pidfd/pidfd.h
+$(OUTPUT)/test_memcontrol: cgroup_util.c
+$(OUTPUT)/test_kmem: cgroup_util.c
+$(OUTPUT)/test_core: cgroup_util.c
+$(OUTPUT)/test_freezer: cgroup_util.c
+$(OUTPUT)/test_kill: cgroup_util.c
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index fe7ee2b0f29c..a40add31a2e3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -141,7 +141,7 @@ endif
 # Selftest makefiles can override those targets by setting
 # OVERRIDE_TARGETS = 1.
 ifeq ($(OVERRIDE_TARGETS),)
-LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
+LOCAL_HDRS += $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
 	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
 
-- 
2.33.0

