Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94B2AE03A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 20:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgKJTyf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 14:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbgKJTye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:34 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B30C0613D1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 11:54:34 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id y9so6264364ilb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNTmliIHaPLQZebq8is9WVHRvSAsyFCf7oine4LHGdQ=;
        b=Dra4b9f8OTQAbW/JrFJp1zGPEVaVaMjdVuAO+zZnM31ynFQ1pcUQG/MykpsdVBTxVI
         Vc1cnZuJaSZdSJaO1Rj6ij001WeAHh7v8IHibrcPUiej+9QN/Q/Ent5I4ppTsq0Exydb
         1hW9yuzFYX/JERJaQp2SVW/mtiR0Evm6TI0B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNTmliIHaPLQZebq8is9WVHRvSAsyFCf7oine4LHGdQ=;
        b=l6H7hyWu8A3WgNmriVJSmcv3vrko8TXwlLdxjR1YAaWg1yw8IpyLQrijJ2SYl1VxhW
         Jdmc9VdXzrJDv/hf/kbkrQudl8lacdIq5xfgwnMJL95cwMmRW/8y9W0khWEtZX3CAWbe
         Ep+qr6Oj/gmb7Pm+89hDbUF08DvSV4joAwetc+I2c5fdQr+pilrizB5soPUkCwpgVT1W
         Dqu/ZpcjQm9yVlTlQw1NG45S7/JAydlZFpjbIpZXxbuezVWDPYVTvJAgOQl7pSO1N0fS
         3anN4LMXHt6qBsMa38J21/WdbgCt3tOn7lxTA6TE16h10xO56hWHJJTT6lqOScf/7OZ/
         60Bw==
X-Gm-Message-State: AOAM531x/+MEIXpcT19/44G8YUuMVnbHzBeMBYC3CGQscdkDVHIsn07u
        mTTYEL7fNylTard4CUVDNfkeEw==
X-Google-Smtp-Source: ABdhPJxzA358t+ZLJ7cPi/ahlO0VWxzydi1uFZzn9mE+PIU3atrO2j9vDN2cI/cgRZQ1e7wHVri0yw==
X-Received: by 2002:a05:6e02:1305:: with SMTP id g5mr16156375ilr.237.1605038073364;
        Tue, 10 Nov 2020 11:54:33 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:32 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 02/13] selftests:lib:test_seqnum_ops: add new test for seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:28 -0700
Message-Id: <754c8befc6ec6deea20c01b9a663a818c5726b88.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new selftest for testing seqnum_ops. This test loads test_seqnum_ops
test module and unloads it. The test module runs tests and prints results
to dmesg.

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting sequence numbers and other statistical
counters and not for managing object lifetime.

The purpose of these Sequence Number Ops is to clearly differentiate
atomic_t counter usages from atomic_t usages that guard object lifetimes,
hence prone to overflow and underflow errors.

The atomic_t api provides a wide range of atomic operations as a base
api to implement atomic counters, bitops, spinlock interfaces. The usages
also evolved into being used for resource lifetimes and state management.
The refcount_t api was introduced to address resource lifetime problems
related to atomic_t wrapping. There is a large overlap between the
atomic_t api used for resource lifetimes and just counters, stats, and
sequence numbers. It has become difficult to differentiate between the
atomic_t usages that should be converted to refcount_t and the ones that
can be left alone. Introducing seqnum_ops to wrap the usages that are
stats, counters, sequence numbers makes it easier for tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors.

Sequence Number api provides interfaces for simple atomic_t counter usages
that just count, and don't guard resource lifetimes. The seqnum_ops are
built on top of atomic_t api, providing a smaller subset of atomic_t
interfaces necessary to support atomic_t usages as simple counters.
This api has init/set/inc/dec/read and doesn't support other atomic_t
ops with the intent to restrict the use of these interfaces as simple
counting usages.

Sequence Numbers wrap around to INT_MIN when it overflows and should not
be used to guard resource lifetimes, device usage and open counts that
control state changes, and pm states. Overflowing to INT_MIN is consistent
with the atomic_t api, which it is built on top of.

Using seqnum to guard lifetimes could lead to use-after free when it
overflows and undefined behavior when used to manage state changes and
device usage/open states.

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
index 7a396c2cda19..3a9ddba985f2 100644
--- a/Documentation/core-api/seqnum_ops.rst
+++ b/Documentation/core-api/seqnum_ops.rst
@@ -115,3 +115,12 @@ Decrements sequence number and doesn't return the new value. ::
 
         seqnum32_dec() --> atomic_dec()
         seqnum64_dec() --> atomic64_dec()
+
+Where are the seqnum_ops and how to use and test them?
+------------------------------------------------------
+
+.. kernel-doc:: include/linux/seqnum_ops.h
+
+Please see lib/test_seqnum_ops.c for examples usages.
+Please find selftest: testing/selftests/lib/test_seqnum_ops.sh
+Please check dmesg for results after running test_seqnum_ops.sh.
diff --git a/MAINTAINERS b/MAINTAINERS
index c83a6f05610b..e6ae131836a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15983,6 +15983,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	include/linux/seqnum_ops.h
 F:	lib/test_seqnum_ops.c
+F:	tools/testing/selftests/lib/test_seqnum_ops.sh
 
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
diff --git a/include/linux/seqnum_ops.h b/include/linux/seqnum_ops.h
index b97c7f310beb..a1def2ad5bc2 100644
--- a/include/linux/seqnum_ops.h
+++ b/include/linux/seqnum_ops.h
@@ -28,6 +28,8 @@
  *
  * Reference and API guide:
  *	Documentation/core-api/seqnum_ops.rst for more information.
+ *	lib/test_seqnum_ops.c - example usages
+ *	tools/testing/selftests/lib/test_seqnum_ops.sh
  *
  */
 
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

