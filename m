Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED7113C64
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 08:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLEHdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 02:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfLEHdZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 02:33:25 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27AB206DB;
        Thu,  5 Dec 2019 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575531204;
        bh=edquYFBHaofPMU3DDDEksKNwbLIT1/Uva327KZiKnv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjbV3N6MS6y+wZWwjqYf10xMmqJY+IW2ckjoi4h8dlvO/2LEPXhIZXNlw/7LHytGO
         EPwpu5uj1i8X52mn56mlMkBKBwvNzqBmKTktEgkC5tfviBxubtccc3xjtBrboW8/2x
         VY6QXjRx5MDxghbLts2s9hvhTEm13Sy+Flz4K778=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH 1/2] selftests: safesetid: Move link library to LDLIBS
Date:   Thu,  5 Dec 2019 16:33:21 +0900
Message-Id: <157553120126.17524.14737256452305682171.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157553119188.17524.1379079312058580155.stgit@devnote2>
References: <157553119188.17524.1379079312058580155.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move -lcap to LDLIBS from CFLAGS because it is a library
to be linked.

Without this, safesetid failed to build with link error
as below.

----
/usr/bin/ld: /tmp/ccL8rZHT.o: in function `drop_caps':
safesetid-test.c:(.text+0xe7): undefined reference to `cap_get_proc'
/usr/bin/ld: safesetid-test.c:(.text+0x107): undefined reference to `cap_set_flag'
/usr/bin/ld: safesetid-test.c:(.text+0x10f): undefined reference to `cap_set_proc'
/usr/bin/ld: safesetid-test.c:(.text+0x117): undefined reference to `cap_free'
/usr/bin/ld: safesetid-test.c:(.text+0x136): undefined reference to `cap_clear'
collect2: error: ld returned 1 exit status
----

Fixes: c67e8ec03f3f ("LSM: SafeSetID: add selftest")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/safesetid/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index 98da7a504737..cac42cd36a1b 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -Wall -lcap -O2
+CFLAGS = -Wall -O2
+LDLIBS = -lcap
 
 TEST_PROGS := run_tests.sh
 TEST_GEN_FILES := safesetid-test

