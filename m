Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85AC15AA9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgBLOAv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 09:00:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40377 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBLOAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 09:00:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2574897wmi.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2020 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3+13tIKTDO43P03qEQWz4Nr4xrTb2HjHzMbiw8Y1no=;
        b=STO8HDkTM/llblvCu5xNJ5PHGWn5qt5gn4AsCxw2m+xsQo7V4i5WVDv74Gyr1VBvdx
         oYgR8QHRfs2fscm8j2jjzApk7LiwG8raJ5cbqbvABIrcfcox39IX+0TLnzGHdC5ptLXu
         hgQyss3zQc0c72APgC8UrAhckZWc6aVwhnLcwSPpE80f7sxdwBcGEdV9bf7pQ0bTUMYi
         zsIySlxRpgaRfFn8fbENPbnTUuI/bQ4XuLfCrPjFr5aJwiiEL/O+CNtbDOH9/sZE957x
         9rXciZUl1GXD0P1y0dr4U77pV21uUTuFoJiNE6TR27dw16KaMaNI6goHbs9cu6oK7HhZ
         u1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3+13tIKTDO43P03qEQWz4Nr4xrTb2HjHzMbiw8Y1no=;
        b=XsTp0GM3AtqoFkfX1HJR5Cff9WVnUlPlU0BxNPMCAFJRilZYKVxRKbt/CR+CtSXuPD
         Va3N/TBPDLIpRxwh18t0tPlfNlwaWslcY5XvFbLP6svgZJJrNlQoE1U7DWWo08EXm1GC
         Cga0GXZynklVL7GeuQ3xTJzhiexRFrKS2ckT88wPlFctvUlLTV2//X2Gre3d0SRi3S+j
         KEhGenGxDZ4YRdYSDBpOtL/mKGy6n+orr7619Xqm06Ltr9yQkEnaBN2wpa39vwcCm07D
         lW0+S9Y8njukhtPWjTAzZ1Q1xdLO/Um2NY/MbcBkp3aU1RF4Sa73K+DOTP7Sd1ujasyS
         l7tQ==
X-Gm-Message-State: APjAAAVv4ZY4tybALRi1Ya2zmMZv1jvK7N16f9fBDx3/vXrPqX+N/IbL
        MT00MsM7nvDiMw5XfnyxEfV/7A==
X-Google-Smtp-Source: APXvYqxm4ipUGduLevWwoiijnkjuyD6K6bNZolT+FtOLldoOcm0yjRD8ZM1F5mCUyCpm7yhgk6rmUg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr12707947wma.31.1581516048180;
        Wed, 12 Feb 2020 06:00:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s23sm802694wra.15.2020.02.12.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 06:00:46 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, avagin@gmail.com,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>, Shuah Khan <skhan@kernel.org>
Subject: [PATCH] selftests: use LDLIBS for libraries instead of LDFLAGS
Date:   Wed, 12 Feb 2020 14:00:40 +0000
Message-Id: <20200212140040.126747-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While building selftests, the following errors were observed:
> tools/testing/selftests/timens'
> gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o tools/testing/selftests/timens/timens
> /usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
> timens.c:(.text+0x65a): undefined reference to `timer_create'
> collect2: error: ld returned 1 exit status

Quoting commit 870f193d48c2 ("selftests: net: use LDLIBS instead of
LDFLAGS"):

The default Makefile rule looks like:

$(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)

When linking is done by gcc itself, no issue, but when it needs to be passed
to proper ld, only LDLIBS follows and then ld cannot know what libs to link
with.

More detail:
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker,
‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
instead.

LDLIBS
Library flags or names given to compilers when they are supposed to invoke the
linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
variable.

While at here, correct other selftests, not only timens ones.

Reported-by: Shuah Khan <skhan@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 tools/testing/selftests/net/Makefile              | 4 ++--
 tools/testing/selftests/rtc/Makefile              | 2 +-
 tools/testing/selftests/timens/Makefile           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 30996306cabc..23207829ec75 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../
 CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
-LDFLAGS := $(LDFLAGS) -pthread -lrt
+LDLIBS := -lpthread -lrt
 
 HEADERS := \
 	../include/futextest.h \
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b5694196430a..287ae916ec0b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -27,5 +27,5 @@ KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
-$(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
-$(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
+$(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
+$(OUTPUT)/tcp_inq: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index de9c8566672a..2d93d65723c9 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O3 -Wl,-no-as-needed -Wall
-LDFLAGS += -lrt -lpthread -lm
+LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = rtctest
 
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index e9fb30bd8aeb..b4fd9a934654 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -2,6 +2,6 @@ TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
-LDFLAGS := -lrt -ldl
+LDLIBS := -lrt -ldl
 
 include ../lib.mk
-- 
2.25.0

