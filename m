Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD579C374
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 04:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbjILC7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 22:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjILC7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 22:59:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A51167F3;
        Mon, 11 Sep 2023 18:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7AC4163C;
        Tue, 12 Sep 2023 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694481043;
        bh=cf5PfHaoDvF33waw1C2kNoX3JgbXMSowbmOHkiQVico=;
        h=From:To:Cc:Subject:Date:From;
        b=rUpXzRmyrgMOHSAyaDOPqyjt+q4z8siykatkYlee6noxCM9t1IUjTrEWYdebarssO
         DpNHGJ+dOuykNLhsjybrOXdzqUVCHx+AeJv2XZtklXAH4N8FuJXvGrkm8AkawqKDIr
         zHDs4bsXzmb4j17kGfOycSVKSU5usAJTmF5Ojsx0GJEIbK0vEAzJt1sgFtnlGC2Fy2
         IbwL4Qr7vD+Uya4E0EjBKqKgLwqlk01w0etDhxMWzwuOeGPKur1jca3maw9FALzB6I
         CCAf3vYFm7n8LbVovFNMcPYEmg+yA6nH9odQ+k2Z3V4Or+p6jzkNbkFXGVSiNE4WJK
         GHQcXGCk8w55w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [FIX PATCH v2] selftests: tracing: Fix to unmount tracefs for recovering environment
Date:   Tue, 12 Sep 2023 10:10:39 +0900
Message-Id: <169448103881.242465.4589561134225171701.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to unmount the tracefs if the ftracetest mounted it for recovering
system environment. If the tracefs is already mounted, this does nothing.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk/
Fixes: cbd965bde74c ("ftrace/selftests: Return the skip code when tracing directory not configured in kernel")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
   - use -n option explictly for testing the string is non-zero.
---
 tools/testing/selftests/ftrace/ftracetest |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index cb5f18c06593..d68264a5f3f0 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -31,6 +31,9 @@ err_ret=1
 # kselftest skip code is 4
 err_skip=4
 
+# umount required
+UMOUNT_DIR=""
+
 # cgroup RT scheduling prevents chrt commands from succeeding, which
 # induces failures in test wakeup tests.  Disable for the duration of
 # the tests.
@@ -45,6 +48,9 @@ setup() {
 
 cleanup() {
   echo $sched_rt_runtime_orig > $sched_rt_runtime
+  if [ -n "${UMOUNT_DIR}" ]; then
+    umount ${UMOUNT_DIR} ||:
+  fi
 }
 
 errexit() { # message
@@ -160,11 +166,13 @@ if [ -z "$TRACING_DIR" ]; then
 	    mount -t tracefs nodev /sys/kernel/tracing ||
 	      errexit "Failed to mount /sys/kernel/tracing"
 	    TRACING_DIR="/sys/kernel/tracing"
+	    UMOUNT_DIR=${TRACING_DIR}
 	# If debugfs exists, then so does /sys/kernel/debug
 	elif [ -d "/sys/kernel/debug" ]; then
 	    mount -t debugfs nodev /sys/kernel/debug ||
 	      errexit "Failed to mount /sys/kernel/debug"
 	    TRACING_DIR="/sys/kernel/debug/tracing"
+	    UMOUNT_DIR=${TRACING_DIR}
 	else
 	    err_ret=$err_skip
 	    errexit "debugfs and tracefs are not configured in this kernel"

