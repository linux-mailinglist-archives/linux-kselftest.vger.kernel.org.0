Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B85DAE9DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfIJMDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:03:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJMDh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:03:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4CDFC056808;
        Tue, 10 Sep 2019 12:03:37 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E2160BE2;
        Tue, 10 Sep 2019 12:03:33 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:03:06 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH 1/6] selftests/clone3: convert test modes into an enum
Message-ID: <96cf2b235f525321a562e9727b3fa0b05675efe8.1568116761.git.esyr@redhat.com>
References: <cover.1568116761.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568116761.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 12:03:37 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* tools/testing/selftests/clone3/clone3.c (CLONE3_ARGS_NO_TEST,
CLONE3_ARGS_ALL_0, CLONE3_ARGS_ALL_1): Change into an enum.
(call_clone3): Change test_mode parameter type to enum test_mode;
use switch statement for actions that dependent on test_mode selection.
(test_clone3): Change test_mode parameter type to enum test_mode.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/clone3.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index a0f1989..7b65ee5 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -24,16 +24,18 @@
 /* V1 includes set_tid */
 #define CLONE3_ARGS_SIZE_V1 72
 
-#define CLONE3_ARGS_NO_TEST 0
-#define CLONE3_ARGS_ALL_0 1
-#define CLONE3_ARGS_ALL_1 2
+enum test_mode {
+	CLONE3_ARGS_NO_TEST,
+	CLONE3_ARGS_ALL_0,
+	CLONE3_ARGS_ALL_1,
+};
 
 static pid_t raw_clone(struct clone_args *args, size_t size)
 {
 	return syscall(__NR_clone3, args, size);
 }
 
-static int call_clone3(int flags, size_t size, int test_mode)
+static int call_clone3(int flags, size_t size, enum test_mode test_mode)
 {
 	struct clone_args args = {0};
 	pid_t ppid = -1;
@@ -46,7 +48,8 @@ static int call_clone3(int flags, size_t size, int test_mode)
 	if (size == 0)
 		size = sizeof(struct clone_args);
 
-	if (test_mode == CLONE3_ARGS_ALL_0) {
+	switch (test_mode) {
+	case CLONE3_ARGS_ALL_0:
 		args.flags = 0;
 		args.pidfd = 0;
 		args.child_tid = 0;
@@ -56,7 +59,9 @@ static int call_clone3(int flags, size_t size, int test_mode)
 		args. stack_size = 0;
 		args.tls = 0;
 		args.set_tid = 0;
-	} else if (test_mode == CLONE3_ARGS_ALL_1) {
+		break;
+
+	case CLONE3_ARGS_ALL_1:
 		args.flags = 1;
 		args.pidfd = 1;
 		args.child_tid = 1;
@@ -66,6 +71,7 @@ static int call_clone3(int flags, size_t size, int test_mode)
 		args. stack_size = 1;
 		args.tls = 1;
 		args.set_tid = 1;
+		break;
 	}
 
 	pid = raw_clone(&args, size);
@@ -91,7 +97,8 @@ static int call_clone3(int flags, size_t size, int test_mode)
 	return 0;
 }
 
-static int test_clone3(int flags, size_t size, int expected, int test_mode)
+static int test_clone3(int flags, size_t size, int expected,
+		       enum test_mode test_mode)
 {
 	int ret;
 
-- 
2.1.4

