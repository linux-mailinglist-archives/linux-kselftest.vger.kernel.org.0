Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F92285359
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 22:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgJFUpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgJFUpq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 16:45:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55757C061755
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Oct 2020 13:45:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so126555ilt.6
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Oct 2020 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJIYIgyrqCiWMzT/Dqk/C0paHkprMmoejDFq2Ds2CjI=;
        b=HBjUSoVMYo8I4oCixKd5VLIoFWCMgqEJyqLPLBTGkQI1cx6K7VnUUVX4diQfmHLv38
         lPbI4K0+lx9jSjEbth/nCH5yLUDfzgHM24DLLQZPcXltwt4nZnbovHlOpmL1+94E9/70
         g+nIUflrO9XI+RYG3SCv7e1dzay94aAMpuFyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJIYIgyrqCiWMzT/Dqk/C0paHkprMmoejDFq2Ds2CjI=;
        b=HABbmT5cUsOlW0ISkvGl1Neop4b4BoOeyDPni+bznYgny20Brkg0ItWTcNB/GKhNOJ
         vLTsuYgvSYaQMnqy7prPduVYwWpSMxbMs2gqfH38/8yKo0mRqjKiPQ8wwbNfVMzAjHst
         0mPAMPddLFP6oRQXsujXga/865NTn2MHTCgHMykeR3CuO2VVPAQPMdqz/owc85v5OeO1
         WYXKDKMomcwp5rM5jCKT0nuxjChwpPYILxDcQpU5hjwTNgqbifewoVBUtEz+sHEr3VeG
         qR0DTruzITIfgagYetUsDaHHpzzR2JpajuGbPPmXqS/vYuX0RbH1WmH/IKtehKGRu7EM
         kIDQ==
X-Gm-Message-State: AOAM5321Lea5XS/z9MBNLjeChpmZnAdIbCodwbvfJhGEiCXCEp3sIaI0
        RwJXGSHUASZP7eN/fxATrjz+YQ==
X-Google-Smtp-Source: ABdhPJzgXRZJcYVcGpyc+YcMGHiDUBKQng+aWWzztb5Xctf9UkSeR+DUoU879vSnxa+MSYIlQjAA5Q==
X-Received: by 2002:a05:6e02:44d:: with SMTP id a13mr5245547ils.273.1602017145731;
        Tue, 06 Oct 2020 13:45:45 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:45:45 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 02/11] selftests:lib:test_counters: add new test for counters
Date:   Tue,  6 Oct 2020 14:44:33 -0600
Message-Id: <dd751c3ecedef23f3bd12c043863a6233fceb0d9.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
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
that just count, and don't guard resource lifetimes. Counter will wrap
around to 0 when it overflows and should not be used to guard resource
lifetimes, device usage and open counts that control state changes, and
pm states.

Using counter_atomic* to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS                                  | 1 +
 tools/testing/selftests/lib/Makefile         | 1 +
 tools/testing/selftests/lib/config           | 1 +
 tools/testing/selftests/lib/test_counters.sh | 5 +++++
 4 files changed, 8 insertions(+)
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
index 000000000000..c8731aef2498
--- /dev/null
+++ b/tools/testing/selftests/lib/test_counters.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Tests the Simple Atomic Counters interfaces using test_counters
+# kernel module
+$(dirname $0)/../kselftest/module.sh "test_counters" test_counters
-- 
2.25.1

