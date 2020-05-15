Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305021D583A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 May 2020 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEORme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727012AbgEORme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 13:42:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41EC05BD09
        for <linux-kselftest@vger.kernel.org>; Fri, 15 May 2020 10:42:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f3so3651002ioj.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 May 2020 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=kbz+a7Ana/YpiS97SnU2yCU3oWm5l70NClekg1sSYX0=;
        b=QecfGUnpZA54+h22b3dmbpxn6J/pei7LP7Ci/GKCuh91Uu2w+j2sECO+I/YCbtHdRU
         Z2APnq52h7RmgsNHaLAB/GEetuxrDU1mTk8GGIvs6JgDhqv8WaTmj9K1Pj/OZrzKUdeP
         fsbCl9fwFOxkCQZXlmzP5mHV6VKWdCitFh+JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=kbz+a7Ana/YpiS97SnU2yCU3oWm5l70NClekg1sSYX0=;
        b=UOQmN6V76xKXrvAQlZ4BtxWHhQ3u4Vaf26UZ+P+wweF8rLGjTofQg9iZb8aLdWeIj6
         0imJFEIqKoKHIfIL1bpp2lJl3ZSpyzANGaQPvbHYKVbAfTvl2fDIS377AU8QeYjlVaoI
         hYKcdxbxT/wFanUUoJOjpczkkLE1lSVCLS4VOKPZnfKQ0ZMj02pif52+A8IKj15C3pxj
         gvCLEa/VALkdYTBIIRTk9nhGrPfTyInOxltSWutw4YT+GSNzl2O7nelBzGWho2UMW378
         PSwUyrjiDCtxlkfBONw5bho7psHU7MAuObdI5xC9kGfkkUMgnqU34GCLoiqugRGS362l
         +Udg==
X-Gm-Message-State: AOAM5306A+MGhIoVEPn527MSLrqM/IFmVfn2lKSzOzZfcZMFaGzxAHh/
        0XroSS6vn7ha5Zvh5AoJlW/TVA==
X-Google-Smtp-Source: ABdhPJy9mEwxgkBjK+X3qlQCx34qqPGIFsQmw8+/SE2MW76LXRWTQE49t4vHSagKfBWkE0ZeB3Yyhw==
X-Received: by 2002:a02:2708:: with SMTP id g8mr4390363jaa.52.1589564552985;
        Fri, 15 May 2020 10:42:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c13sm1157502ilu.81.2020.05.15.10.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 10:42:32 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Kees Cook <keescook@chromium.org>,
        shuah <shuah@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.7-rc6
Message-ID: <0cb258e7-e5ef-b42d-ef9b-2ee979a91aa0@linuxfoundation.org>
Date:   Fri, 15 May 2020 11:42:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------94BD8472E23703DFEF42AF49"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------94BD8472E23703DFEF42AF49
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.7-rc6.

This Kselftest update for Linux 5.7-rc6 consists of

- lkdtm runner fixes to prevent dmesg clearing and shellcheck errors
- ftrace test handling when test module doesn't exist
- nsfs test fix to replace zero-length array with flexible-array
- dmabuf-heaps test fix to return clear error value

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

   Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.7-rc6

for you to fetch changes up to 851c4df54dc1bcae41d07e46e3d89e035b0a7140:

   selftests/lkdtm: Use grep -E instead of egrep (2020-05-08 09:46:17 -0600)

----------------------------------------------------------------
linux-kselftest-5.7-rc6

This Kselftest update for Linux 5.7-rc6 consists of

- lkdtm runner fixes to prevent dmesg clearing and shellcheck errors
- ftrace test handling when test module doesn't exist
- nsfs test fix to replace zero-length array with flexible-array
- dmabuf-heaps test fix to return clear error value

----------------------------------------------------------------
Gustavo A. R. Silva (1):
       tools/testing: Replace zero-length array with flexible-array

John Stultz (1):
       kselftests: dmabuf-heaps: Fix confused return value on expected 
error testing

Michael Ellerman (2):
       selftests/lkdtm: Don't clear dmesg when running tests
       selftests/lkdtm: Use grep -E instead of egrep

Po-Hsu Lin (1):
       selftests/ftrace: mark irqsoff_tracer.tc test as unresolved if 
the test module does not exist

  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |  1 +
  .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |  9 ++++++++-
  tools/testing/selftests/lkdtm/run.sh               | 22 
++++++++++++----------
  tools/testing/selftests/nsfs/pidns.c               |  2 +-
  4 files changed, 22 insertions(+), 12 deletions(-)
----------------------------------------------------------------

--------------94BD8472E23703DFEF42AF49
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.7-rc6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.7-rc6.diff"

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index cd5e1f602ac9..909da9cdda97 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -351,6 +351,7 @@ static int test_alloc_errors(char *heap_name)
 	}
 
 	printf("Expected error checking passed\n");
+	ret = 0;
 out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
index cbd174334a48..2b82c80edf69 100644
--- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -17,7 +17,14 @@ unsup() { #msg
     exit_unsupported
 }
 
-modprobe $MOD || unsup "$MOD module not available"
+unres() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unresolved
+}
+
+modprobe $MOD || unres "$MOD module not available"
 rmmod $MOD
 
 grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index dadf819148a4..ee64ff8df8f4 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -25,13 +25,13 @@ fi
 # Figure out which test to run from our script name.
 test=$(basename $0 .sh)
 # Look up details about the test from master list of LKDTM tests.
-line=$(egrep '^#?'"$test"'\b' tests.txt)
+line=$(grep -E '^#?'"$test"'\b' tests.txt)
 if [ -z "$line" ]; then
 	echo "Skipped: missing test '$test' in tests.txt"
 	exit $KSELFTEST_SKIP_TEST
 fi
 # Check that the test is known to LKDTM.
-if ! egrep -q '^'"$test"'$' "$TRIGGER" ; then
+if ! grep -E -q '^'"$test"'$' "$TRIGGER" ; then
 	echo "Skipped: test '$test' missing in $TRIGGER!"
 	exit $KSELFTEST_SKIP_TEST
 fi
@@ -59,30 +59,32 @@ if [ -z "$expect" ]; then
 	expect="call trace:"
 fi
 
-# Clear out dmesg for output reporting
-dmesg -c >/dev/null
-
 # Prepare log for report checking
-LOG=$(mktemp --tmpdir -t lkdtm-XXXXXX)
+LOG=$(mktemp --tmpdir -t lkdtm-log-XXXXXX)
+DMESG=$(mktemp --tmpdir -t lkdtm-dmesg-XXXXXX)
 cleanup() {
-	rm -f "$LOG"
+	rm -f "$LOG" "$DMESG"
 }
 trap cleanup EXIT
 
+# Save existing dmesg so we can detect new content below
+dmesg > "$DMESG"
+
 # Most shells yell about signals and we're expecting the "cat" process
 # to usually be killed by the kernel. So we have to run it in a sub-shell
 # and silence errors.
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg -c >"$LOG"
+dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+
 cat "$LOG"
 # Check for expected output
-if egrep -qi "$expect" "$LOG" ; then
+if grep -E -qi "$expect" "$LOG" ; then
 	echo "$test: saw '$expect': ok"
 	exit 0
 else
-	if egrep -qi XFAIL: "$LOG" ; then
+	if grep -E -qi XFAIL: "$LOG" ; then
 		echo "$test: saw 'XFAIL': [SKIP]"
 		exit $KSELFTEST_SKIP_TEST
 	else
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
index e0d86e1668c0..e3c772c6a7c7 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -27,7 +27,7 @@
 #define __stack_aligned__	__attribute__((aligned(16)))
 struct cr_clone_arg {
 	char stack[128] __stack_aligned__;
-	char stack_ptr[0];
+	char stack_ptr[];
 };
 
 static int child(void *args)

--------------94BD8472E23703DFEF42AF49--
