Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1BB7ADC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfG3Qdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 12:33:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37194 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbfG3Qdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 12:33:50 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so9780647iog.4
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2019 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=KDoydqM/4PNQk1C3wiilLCzdxfZ2P2ofICXyjT/BiWg=;
        b=AFlQcULevo63D36h/Zb6unEW2gvSjI9MHiceRZdIS88Q+ngp+E+CsCyiMJ9KX0ZbRp
         N4NcU4yHLlwj0uB9BZGJ7QMHWzwdC+PLuku5yV+r11DDAwhkizHHLj3QdwLbf5A3iIO3
         a6xO0MFHtRmXWO9RJ43RrLtmqyT3ByBAokmBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=KDoydqM/4PNQk1C3wiilLCzdxfZ2P2ofICXyjT/BiWg=;
        b=B8HE5Eb1dD7yQw/ztY7O3gpMYWwBJO6hfFj6oWQe5+u1MEmIa2myt2vnSOr7sws7dF
         0wGaRF/ukSZAFor5ym2Gceg7aHK+PItZR98LfQ8OIJzQSfFoCR0tU6EOEP0Qhd0h+qJN
         vg9XSslBlahje91rombowgC1PxFhsaOD4kyS8FQhjEb2VmBDynPaRjjaXJ0Bm4qBTqYp
         +N5T/wrmcEQ71U40/Z5PQvyksUqjyse2vUnhyGqcPFsLkoovGxOOYC9o4fgBN6b9t9lU
         AlWqT80eCO8xLYUNkSCYMHNywq0DeA9TDAguq++KArrPnskEX/G7qwXkOTV4gvSAfbms
         MM8A==
X-Gm-Message-State: APjAAAXpgFGEJ9xJJbu/isgL2Rpclfb0GuzNxYuy2L0jyYBp+uFA+Obf
        W/V6FkkrMMAZ0yGtfn29d7Gh2rqBvvs=
X-Google-Smtp-Source: APXvYqySJCCDz9k+CCH4hXgB2ZZY0msNGZoC4JCZ2dYyOQnEbdov7u9e4hWkSnO3/U7n568ZJuzfjQ==
X-Received: by 2002:a02:6616:: with SMTP id k22mr80748842jac.100.1564504429163;
        Tue, 30 Jul 2019 09:33:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm59733545iob.57.2019.07.30.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:33:48 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, joe.lawrence@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.3-rc3
Message-ID: <9b7fa63d-7c3f-bb3a-663b-e5279a0a0086@linuxfoundation.org>
Date:   Tue, 30 Jul 2019 10:33:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------24AF2ECE419D14C7D78A028E"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------24AF2ECE419D14C7D78A028E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.3-rc3.

This Kselftest update for Linux 5.3-rc3 consists of minor fixes to
tests and one major fix to livepatch test to add skip handling to
avoid false fail reports when livepatch is disabled.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.3-rc3

for you to fetch changes up to 527d37e9e575bc0e9024de9b499385e7bb31f1ad:

   selftests/livepatch: add test skip handling (2019-07-24 14:17:46 -0600)

----------------------------------------------------------------
linux-kselftest-5.3-rc3

This Kselftest update for Linux 5.3-rc3 consists of minor fixes to
tests and one major fix to livepatch test to add skip handling to
avoid false fail reports when livepatch is disabled.

----------------------------------------------------------------
Colin Ian King (1):
       selftests/x86: fix spelling mistake "FAILT" -> "FAIL"

Joe Lawrence (1):
       selftests/livepatch: add test skip handling

Masanari Iida (2):
       selftests: kmod: Fix typo in kmod.sh
       selftests: mlxsw: Fix typo in qos_mc_aware.sh

  .../selftests/drivers/net/mlxsw/qos_mc_aware.sh      |  4 ++--
  tools/testing/selftests/kmod/kmod.sh                 |  6 +++---
  tools/testing/selftests/livepatch/functions.sh       | 20 
++++++++++++++++++++
  tools/testing/selftests/x86/test_vsyscall.c          |  2 +-
  4 files changed, 26 insertions(+), 6 deletions(-)

----------------------------------------------------------------

--------------24AF2ECE419D14C7D78A028E
Content-Type: text/x-patch;
 name="linux-kselftest-5.3-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.3-rc3.diff"

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
index 71231ad2dbfb..47315fe48d5a 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -262,7 +262,7 @@ test_mc_aware()
 
 	stop_traffic
 
-	log_test "UC performace under MC overload"
+	log_test "UC performance under MC overload"
 
 	echo "UC-only throughput  $(humanize $ucth1)"
 	echo "UC+MC throughput    $(humanize $ucth2)"
@@ -316,7 +316,7 @@ test_uc_aware()
 
 	stop_traffic
 
-	log_test "MC performace under UC overload"
+	log_test "MC performance under UC overload"
 	echo "    ingress UC throughput $(humanize ${uc_ir})"
 	echo "    egress UC throughput  $(humanize ${uc_er})"
 	echo "    sent $attempts BC ARPs, got $passes responses"
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 0a76314b4414..8b944cf042f6 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -28,7 +28,7 @@
 # override by exporting to your environment prior running this script.
 # For instance this script assumes you do not have xfs loaded upon boot.
 # If this is false, export DEFAULT_KMOD_FS="ext4" prior to running this
-# script if the filesyste module you don't have loaded upon bootup
+# script if the filesystem module you don't have loaded upon bootup
 # is ext4 instead. Refer to allow_user_defaults() for a list of user
 # override variables possible.
 #
@@ -263,7 +263,7 @@ config_get_test_result()
 config_reset()
 {
 	if ! echo -n "1" >"$DIR"/reset; then
-		echo "$0: reset shuld have worked" >&2
+		echo "$0: reset should have worked" >&2
 		exit 1
 	fi
 }
@@ -488,7 +488,7 @@ usage()
 	echo Example uses:
 	echo
 	echo "${TEST_NAME}.sh		-- executes all tests"
-	echo "${TEST_NAME}.sh -t 0008	-- Executes test ID 0008 number of times is recomended"
+	echo "${TEST_NAME}.sh -t 0008	-- Executes test ID 0008 number of times is recommended"
 	echo "${TEST_NAME}.sh -w 0008	-- Watch test ID 0008 run until an error occurs"
 	echo "${TEST_NAME}.sh -s 0008	-- Run test ID 0008 once"
 	echo "${TEST_NAME}.sh -c 0008 3	-- Run test ID 0008 three times"
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30195449c63c..edcfeace4655 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -13,6 +13,14 @@ function log() {
 	echo "$1" > /dev/kmsg
 }
 
+# skip(msg) - testing can't proceed
+#	msg - explanation
+function skip() {
+	log "SKIP: $1"
+	echo "SKIP: $1" >&2
+	exit 4
+}
+
 # die(msg) - game over, man
 #	msg - dying words
 function die() {
@@ -43,6 +51,12 @@ function loop_until() {
 	done
 }
 
+function assert_mod() {
+	local mod="$1"
+
+	modprobe --dry-run "$mod" &>/dev/null
+}
+
 function is_livepatch_mod() {
 	local mod="$1"
 
@@ -75,6 +89,9 @@ function __load_mod() {
 function load_mod() {
 	local mod="$1"; shift
 
+	assert_mod "$mod" ||
+		skip "unable to load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
+
 	is_livepatch_mod "$mod" &&
 		die "use load_lp() to load the livepatch module $mod"
 
@@ -88,6 +105,9 @@ function load_mod() {
 function load_lp_nowait() {
 	local mod="$1"; shift
 
+	assert_mod "$mod" ||
+		skip "unable to load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
+
 	is_livepatch_mod "$mod" ||
 		die "module $mod is not a livepatch"
 
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 4602326b8f5b..a4f4d4cf22c3 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -451,7 +451,7 @@ static int test_vsys_x(void)
 		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
 		       segv_err);
 	} else {
-		printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
+		printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
 		       segv_err);
 		return 1;
 	}

--------------24AF2ECE419D14C7D78A028E--
