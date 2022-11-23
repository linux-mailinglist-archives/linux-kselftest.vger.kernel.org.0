Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30378634BF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiKWBDw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 20:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiKWBDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 20:03:47 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AABCDA4F8;
        Tue, 22 Nov 2022 17:03:45 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxE_BvcX1jjiMAAA--.420S3;
        Wed, 23 Nov 2022 09:03:43 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJldqcX1js24YAA--.45400S3;
        Wed, 23 Nov 2022 09:03:40 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] selftests: rcutorture: Use "grep -E" instead of "egrep"
Date:   Wed, 23 Nov 2022 09:03:28 +0800
Message-Id: <1669165413-12035-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxJldqcX1js24YAA--.45400S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XFWkGF4UJFWxuw1UJFWUArb_yoWxZFW3pa
        yktwnagr18JFy5Ja18AFZ2qFW5KFs3AF4Utr18WryUZ3W5GFn2vr1IqFnxJF9rGrZYqw1S
        vas2gryxuw4UJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        W8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests/rcutorture`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm-build.sh       |  4 ++--
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh |  4 ++--
 tools/testing/selftests/rcutorture/bin/kvm.sh             |  4 ++--
 tools/testing/selftests/rcutorture/bin/parse-console.sh   | 10 +++++-----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 69f8a59..aad51e7 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -10,7 +10,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-egrep 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 5ad973d..9052c4c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -45,10 +45,10 @@ fi
 ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
-if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
+if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | grep -E -q "Stop|Error|error:|warning:" || grep -E -q "Stop|Error|error:" < $resdir/Make.out
 then
 	echo Kernel build error
-	egrep "Stop|Error|error:|warning:" < $resdir/Make.out
+	grep -E "Stop|Error|error:|warning:" < $resdir/Make.out
 	echo Run aborted.
 	exit 3
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 88983cb..0840c44 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -32,9 +32,9 @@ for i in ${rundir}/*/Make.out
 do
 	scenariodir="`dirname $i`"
 	scenariobasedir="`echo ${scenariodir} | sed -e 's/\.[0-9]*$//'`"
-	if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
+	if grep -E -q "error:|warning:|^ld: .*undefined reference to" < $i
 	then
-		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
+		grep -E "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
 	elif ! test -f ${scenariobasedir}/vmlinux && ! test -f "${rundir}/re-run"
 	then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6c73481..58ccd34 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -586,7 +586,7 @@ awk < $T/cfgcpu.pack \
 echo kvm-end-run-stats.sh "$resdir/$ds" "$starttime" >> $T/script
 
 # Extract the tests and their batches from the script.
-egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+grep -E 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 	sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
 	awk '
 	/^----Start/ {
@@ -623,7 +623,7 @@ then
 elif test "$dryrun" = sched
 then
 	# Extract the test run schedule from the script.
-	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+	grep -E 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
 	nbuilds="`grep 'Starting build\.' $T/script |
 		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 822eb03..9ab0f6b 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -65,7 +65,7 @@ then
 	fi
 
 	grep --binary-files=text 'torture:.*ver:' $file |
-	egrep --binary-files=text -v '\(null\)|rtc: 000000000* ' |
+	grep -E --binary-files=text -v '\(null\)|rtc: 000000000* ' |
 	sed -e 's/^(initramfs)[^]]*] //' -e 's/^\[[^]]*] //' |
 	sed -e 's/^.*ver: //' |
 	awk '
@@ -128,17 +128,17 @@ then
 	then
 		summary="$summary  Badness: $n_badness"
 	fi
-	n_warn=`grep -v 'Warning: unable to open an initial console' $file | grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process' | egrep -c 'WARNING:|Warn'`
+	n_warn=`grep -v 'Warning: unable to open an initial console' $file | grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process' | grep -E -c 'WARNING:|Warn'`
 	if test "$n_warn" -ne 0
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c '\bBUG|Oops:' $file`
+	n_bugs=`grep -E -c '\bBUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
 	fi
-	n_kcsan=`egrep -c 'BUG: KCSAN: ' $file`
+	n_kcsan=`grep -E -c 'BUG: KCSAN: ' $file`
 	if test "$n_kcsan" -ne 0
 	then
 		if test "$n_bugs" = "$n_kcsan"
@@ -158,7 +158,7 @@ then
 	then
 		summary="$summary  lockdep: $n_badness"
 	fi
-	n_stalls=`egrep -c 'detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state' $file`
+	n_stalls=`grep -E -c 'detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state' $file`
 	if test "$n_stalls" -ne 0
 	then
 		summary="$summary  Stalls: $n_stalls"
-- 
2.1.0

