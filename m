Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7D30E22E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 19:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBCSO3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 13:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbhBCSNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 13:13:11 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54EC061353
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 10:12:19 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id p15so102540ilq.8
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Us34ijyq5YldDgoM68M19WNAuZlemdS7tunn1EAeqK0=;
        b=AGLM7izY/rKHCOxp7cxBmTm/tVSqPW7ZIDhByLc5ZUs5fT9iVWlpKxs0rLvrlh1mCo
         rUiu/sshU1xp9YhketiJr9uBHZ5yjx9c65M+Ez/Sds7s9ZGZ30Vm/e1O5nR7ry/Ri6kk
         55jue1iwccIWPtSDFXvnqOff+FiLMnDHgx7uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Us34ijyq5YldDgoM68M19WNAuZlemdS7tunn1EAeqK0=;
        b=X7y4XrAzu8BiQxNgvohv7qpQ5b0KOWQujnaUfQQU1K2l4Vx6RwCKzfXivRndijB39C
         gLKt5rJaoShPSmGtyN6rn8lhDNO7W1x0VOdUWbpYcAlEw9u4DDX4HuZhsy93gpewjmg+
         X9cifm5a8Bm2atv3AX8MJxBw8XgQ/ISiAL/GRQZzJo1a9Tu9g3lkDjS/ZFmTIu8Sh/vA
         DYCnQnjiXN0llyOE/VWQnlbB9BML4+T7GvGudbyvEEPVdCVOhHQTnUyyLCY5DF0kf4F5
         1AfMAimVBlLU2RCKD55JLMtnthvsK2KBJVVVsiDuIuBihqjLiYfYdbu9Scsf4j4oJvvE
         D3Kw==
X-Gm-Message-State: AOAM530akzUvMmfFwU79DGnsGsZNNCR02i/hc4WwsIvP4HcW3kuh8dLV
        FUNyHexhrz64qUarsJQI/b9mFQ==
X-Google-Smtp-Source: ABdhPJyuJchmuxTVpwILYv0SxXq+AaTfD/pPbWAbbGIQDB/rEG3yKWTEsN9alX7Ngl05yOUMaGN1bA==
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr3711883ilu.277.1612375935896;
        Wed, 03 Feb 2021 10:12:15 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm399684iob.30.2021.02.03.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:12:15 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 2/7] selftests: lib:test_seqnum_ops: add new test for seqnum_ops
Date:   Wed,  3 Feb 2021 11:11:58 -0700
Message-Id: <08e6ceb7608d008faf9e28e4f08361af5618cf07.1612314468.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612314468.git.skhan@linuxfoundation.org>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new selftest for testing seqnum_ops. This test loads test_seqnum_ops
test module and unloads it. The test module runs tests and prints results
to dmesg.

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

There are a number of atomic_t usages in the kernel where atomic_t api
is used for counting sequence numbers and other statistical counters.
Several of these usages, convert atomic_read() and atomic_inc_return()
return values to unsigned. Introducing sequence number ops supports
these use-cases with a standard core-api.

Sequence Number ops provide interfaces to initialize, increment and get
the sequence number. These ops also check for overflow and log message to
indicate when overflow occurs.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/core-api/seqnum_ops.rst          |  9 +++++++++
 MAINTAINERS                                    |  1 +
 include/linux/seqnum_ops.h                     |  2 ++
 tools/testing/selftests/lib/Makefile           |  1 +
 tools/testing/selftests/lib/config             |  1 +
 tools/testing/selftests/lib/test_seqnum_ops.sh | 10 ++++++++++
 6 files changed, 24 insertions(+)
 create mode 100755 tools/testing/selftests/lib/test_seqnum_ops.sh

diff --git a/Documentation/core-api/seqnum_ops.rst b/Documentation/core-api/seqnum_ops.rst
index ed4eba394799..6db2c9120885 100644
--- a/Documentation/core-api/seqnum_ops.rst
+++ b/Documentation/core-api/seqnum_ops.rst
@@ -51,3 +51,12 @@ Returns sequence number value. ::
 
 .. warning::
         seqnum32 wraps around to INT_MIN when it overflows.
+
+Where are the seqnum_ops and how to use and test them?
+------------------------------------------------------
+
+.. kernel-doc:: include/linux/seqnum_ops.h
+
+Please see lib/test_seqnum_ops.c for examples usages and test module.
+Please find selftest: testing/selftests/lib/test_seqnum_ops.sh
+Please check dmesg for results after running test_seqnum_ops.sh.
diff --git a/MAINTAINERS b/MAINTAINERS
index f9fe1438a8cd..70b9eeb995f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16241,6 +16241,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	include/linux/seqnum_ops.h
 F:	lib/test_seqnum_ops.c
+F:	tools/testing/selftests/lib/test_seqnum_ops.sh
 
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
diff --git a/include/linux/seqnum_ops.h b/include/linux/seqnum_ops.h
index e8d8481445d3..d540b62d1aa4 100644
--- a/include/linux/seqnum_ops.h
+++ b/include/linux/seqnum_ops.h
@@ -18,6 +18,8 @@
  *
  * Reference and API guide:
  *	Documentation/core-api/seqnum_ops.rst for more information.
+ *	lib/test_seqnum_ops.c - example usages and test module
+ *	tools/testing/selftests/lib/test_seqnum_ops.sh
  */
 
 #ifndef __LINUX_SEQNUM_OPS_H
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index a105f094676e..1818444f0e97 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -5,5 +5,6 @@
 all:
 
 TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
+TEST_PROGS += test_seqnum_ops.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..674ed2a2ac82 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -3,3 +3,4 @@ CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
+CONFIG_TEST_SEQNUM_OPS=m
diff --git a/tools/testing/selftests/lib/test_seqnum_ops.sh b/tools/testing/selftests/lib/test_seqnum_ops.sh
new file mode 100755
index 000000000000..fdce16b220ba
--- /dev/null
+++ b/tools/testing/selftests/lib/test_seqnum_ops.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+# Copyright (c) 2020 The Linux Foundation
+#
+# Tests the Sequence Number Ops interfaces using test_seqnum_ops
+# kernel module
+#
+$(dirname $0)/../kselftest/module.sh "test_seqnum_ops" test_seqnum_ops
-- 
2.27.0

