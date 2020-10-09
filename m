Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523DA288D74
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbgJIP4V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389355AbgJIP4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 11:56:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDDC0613D6
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Oct 2020 08:56:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q21so9399196ota.8
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Oct 2020 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhVKT+1Dp3cLQ927y3IeE45PijqPHl/y1tcL0VMnAkY=;
        b=MJ59A2zSUmOd4vH98m00yfAlFCElHYcQzDfBMYHrVQy7lR2WZx36tRcnEIiex/HpTh
         psiwZkcYnFqUu7CqyFJf/2WggvVUrR8lhitdRnQgqBvey72k6+WleuW5MyqR1ij81nka
         s1sooOAOzyxbgRa3UcAAW84OfUXQpR1PvmUpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhVKT+1Dp3cLQ927y3IeE45PijqPHl/y1tcL0VMnAkY=;
        b=aI87CwbuB6NIEZyFAdrlRiJN1ziu99XY5v2h4PkHY2icxr2HfiFCkk+7a1HYjs7l+J
         Yvr42cf9s9mOQDgFRdWhteCIXHvaVgZyGs+qj2YOX++vcCN9rsXovhNlPV6oMSoERJQX
         N6qWRfGh+ITIRdyy3oDGnM96B5qTwKcfDnvjl03EvaHnOoLRUCEi6hmqIfeR4F0JarwO
         zWmn5spBFOOMAVPyShIquzZEr1xHte5QVOB91O5rIo4jLHgjgferAMz7EZiWRV+OD7xt
         eyJl/ukVSK8Ynhq9qGaq1zJck65pXRXQpFctkRtkGqUX9xeosolhf/wZORyPUodRwsCG
         PM8A==
X-Gm-Message-State: AOAM533WzdeVuengUEfWNNltswr9VO5uV+7eNaH4Gdkp5ogC83OWGP7o
        HoFS/T8Z9muIy3SfGz+PyPhE1A==
X-Google-Smtp-Source: ABdhPJxStfMuXX1WzYtWLp3zKvwHlUVTk033Hdfs1+nAN/BlfU0MSSy8ICasd76nlLmEKo4UR+BpUQ==
X-Received: by 2002:a05:6830:1d75:: with SMTP id l21mr8771101oti.89.1602258972855;
        Fri, 09 Oct 2020 08:56:12 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:12 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 02/11] selftests:lib:test_counters: add new test for counters
Date:   Fri,  9 Oct 2020 09:55:57 -0600
Message-Id: <688424d7ff981d34523cd6794d7ce3c27cfe57b4.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new selftest for testing counter_atomic* Counters API. This test
load test_counters test modules and unloads.

The test module runs tests and prints results in dmesg.

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting and not for managing object lifetime. In
some cases, atomic_t might not even be needed.

The purpose of these counters is to clearly differentiate atomic_t
counters from atomic_t usages that guard object lifetimes, hence prone
to overflow and underflow errors. It allows tools that scan for underflow
and overflow on atomic_t usages to detect overflow and underflows to scan
just the cases that are prone to errors.

Simple atomic counters api provides interfaces for simple atomic counters
that just count, and don't guard resource lifetimes. The interfaces are
built on top of atomic_t api, providing a smaller subset of atomic_t
interfaces necessary to support simple counters.

Counter wraps around to INT_MIN when it overflows and should not be used
to guard resource lifetimes, device usage and open counts that control
state changes, and pm states. Overflowing to INT_MIN is consistent with
the atomic_t api, which it is built on top of.

Using counter_atomic* to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS                                  |  1 +
 tools/testing/selftests/lib/Makefile         |  1 +
 tools/testing/selftests/lib/config           |  1 +
 tools/testing/selftests/lib/test_counters.sh | 10 ++++++++++
 4 files changed, 13 insertions(+)
 create mode 100755 tools/testing/selftests/lib/test_counters.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e82d0ffcab0..26719b8dd48e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15845,6 +15845,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	include/linux/counters.h
 F:	lib/test_counters.c
+F:	tools/testing/selftests/lib/test_counters.sh
 
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index a105f094676e..e8960d7934e2 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -5,5 +5,6 @@
 all:
 
 TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
+TEST_PROGS += test_counters.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..6ed25024d371 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -3,3 +3,4 @@ CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
+CONFIG_TEST_COUNTERS=m
diff --git a/tools/testing/selftests/lib/test_counters.sh b/tools/testing/selftests/lib/test_counters.sh
new file mode 100755
index 000000000000..78726cad5c7a
--- /dev/null
+++ b/tools/testing/selftests/lib/test_counters.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+# Copyright (c) 2020 The Linux Foundation
+#
+# Tests the Simple Atomic Counters interfaces using test_counters
+# kernel module
+#
+$(dirname $0)/../kselftest/module.sh "test_counters" test_counters
-- 
2.25.1

