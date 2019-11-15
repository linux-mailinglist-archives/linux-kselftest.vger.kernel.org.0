Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA969FD855
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 10:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOJEC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 04:04:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKOJEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 04:04:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVXWG-00004x-EZ; Fri, 15 Nov 2019 09:03:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ftrace/selftests: fix spelling mistake "wakeing" -> "waking"
Date:   Fri, 15 Nov 2019 09:03:56 +0000
Message-Id: <20191115090356.39572-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few identical spelling mistakes, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
index cbc7a30c2e0f..d75a8695bc21 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -11,7 +11,7 @@ fi
 echo "Let the module run a little"
 sleep 1
 
-grep -q "my_direct_func: wakeing up" trace
+grep -q "my_direct_func: waking up" trace
 
 rmmod ftrace-direct
 
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 017a7409b103..801ecb63e84c 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -16,7 +16,7 @@ fi
 echo "Let the module run a little"
 sleep 1
 
-grep -q "my_direct_func: wakeing up" trace
+grep -q "my_direct_func: waking up" trace
 
 rmmod ftrace-direct
 
@@ -26,7 +26,7 @@ start_direct() {
 	echo > trace
 	modprobe ftrace-direct
 	sleep 1
-	grep -q "my_direct_func: wakeing up" trace
+	grep -q "my_direct_func: waking up" trace
 }
 
 stop_direct() {
-- 
2.20.1

