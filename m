Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AF4B164F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 20:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbiBJT3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 14:29:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbiBJT3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 14:29:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573DE49;
        Thu, 10 Feb 2022 11:29:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 3A3D91F4679F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644521355;
        bh=81KG+Px6CHUUDoEbvuzYOMSKjQRQ8tqsMXL7xZrswZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mamsQisTOW/gwdOo3yQwQ7kvGXJT4HYkL5+9MDfD/s5EH8bBRiDkd3lY9sMrTLPGl
         oLQ2QbRwWNc0bQ8LsP1gP3lFqW2F/rTEdAHDeiVncDGcugPzW5aEPSYJ154wbzYiNf
         qxkkYsTrcuY2bjoIEfROyGHcjW1/tirBf6YgaDqGgT8SHfDVMk/qmbCZrhFxwXQb/0
         KH40sMwe2pUg8gwlDEQH+Wt0rYqYgHCzU8xH51wzHo4CJjJAvLigsMjAKwXXcw9/2O
         4ABhw/a/CxMTlUXXelT207QVWsAPwaNT+s8hHu8aU4U06eV/axA1wT9XdtrepnZyY8
         XbRHMr+weQZ6g==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/exec: Rename file binfmt_script to binfmt_script.py
Date:   Fri, 11 Feb 2022 00:28:45 +0500
Message-Id: <20220210192845.1533204-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename file for readability purpose. Update its usage and references.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
This path was suggested while review of the following patch. Please
apply it after applying that one first:
	selftests/exec: Add non-regular to TEST_GEN_PROGS
---
 tools/testing/selftests/exec/Makefile          |  2 +-
 .../exec/{binfmt_script => binfmt_script.py}   | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)
 rename tools/testing/selftests/exec/{binfmt_script => binfmt_script.py} (90%)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index a89ba6de79870..a0b8688b08369 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,7 +3,7 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script
+TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
diff --git a/tools/testing/selftests/exec/binfmt_script b/tools/testing/selftests/exec/binfmt_script.py
similarity index 90%
rename from tools/testing/selftests/exec/binfmt_script
rename to tools/testing/selftests/exec/binfmt_script.py
index 05f94a741c7aa..6f717fedc97bd 100755
--- a/tools/testing/selftests/exec/binfmt_script
+++ b/tools/testing/selftests/exec/binfmt_script.py
@@ -28,11 +28,11 @@ foreach my $a (@ARGV) {
 '''
 
 ##
-# test - produce a binfmt_script hashbang line for testing
+# test - produce a binfmt_script.py hashbang line for testing
 #
 # @size:     bytes for bprm->buf line, including hashbang but not newline
 # @good:     whether this script is expected to execute correctly
-# @hashbang: the special 2 bytes for running binfmt_script
+# @hashbang: the special 2 bytes for running binfmt_script.py
 # @leading:  any leading whitespace before the executable path
 # @root:     start of executable pathname
 # @target:   end of executable pathname
@@ -45,7 +45,7 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
     global test_num, tests, NAME_MAX
     test_num += 1
     if test_num > tests:
-        raise ValueError("more binfmt_script tests than expected! (want %d, expected %d)"
+        raise ValueError("more binfmt_script.py tests than expected! (want %d, expected %d)"
                          % (test_num, tests))
 
     middle = ""
@@ -68,7 +68,7 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
     if len(newline) > 0:
         buf += 'echo this is not really perl\n'
 
-    script = "binfmt_script-%s" % (name)
+    script = "binfmt_script.py-%s" % (name)
     open(script, "w").write(buf)
     os.chmod(script, 0o755)
 
@@ -78,17 +78,17 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
 
     if proc.returncode == 0 and b'Executed interpreter' in stdout:
         if good:
-            print("ok %d - binfmt_script %s (successful good exec)"
+            print("ok %d - binfmt_script.py %s (successful good exec)"
                   % (test_num, name))
         else:
-            print("not ok %d - binfmt_script %s succeeded when it should have failed"
+            print("not ok %d - binfmt_script.py %s succeeded when it should have failed"
                   % (test_num, name))
     else:
         if good:
-            print("not ok %d - binfmt_script %s failed when it should have succeeded (rc:%d)"
+            print("not ok %d - binfmt_script.py %s failed when it should have succeeded (rc:%d)"
                   % (test_num, name, proc.returncode))
         else:
-            print("ok %d - binfmt_script %s (correctly failed bad exec)"
+            print("ok %d - binfmt_script.py %s (correctly failed bad exec)"
                   % (test_num, name))
 
     # Clean up crazy binaries
@@ -167,5 +167,5 @@ test(name="two-under-leading",   size=int(SIZE/2), leading=" ")
 test(name="two-under-lead-trunc-arg", size=int(SIZE/2), leading=" ", arg=" ")
 
 if test_num != tests:
-    raise ValueError("fewer binfmt_script tests than expected! (ran %d, expected %d"
+    raise ValueError("fewer binfmt_script.py tests than expected! (ran %d, expected %d"
                      % (test_num, tests))
-- 
2.30.2

