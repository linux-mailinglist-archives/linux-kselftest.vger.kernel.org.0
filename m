Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E663CC04
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 00:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiK2X6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 18:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiK2X6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 18:58:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428057B40;
        Tue, 29 Nov 2022 15:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0665B8196F;
        Tue, 29 Nov 2022 23:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D75CC433C1;
        Tue, 29 Nov 2022 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766311;
        bh=B1DKOoizHL7L5RKrV8h2vvs/4QEuWHFY9k9GAypOiJM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q30Fx8mKGa/5f01H0qEQU8/d0ri74h8s7PRXcAOhCslHLwJ2s4Z8Zx3Ff5wMqm3iI
         3NXPEKoXKfleTBK34hs/gWeWW3/oxaBj6ln0MpJOBENSINgcvVp1LDyIz1e+1HY3ch
         DttZqxHjm/rd+7OUebcPgUWeWHFPdtB/7n4EpyD3JAxs6bgnh0q3WZYPsnINFUh/gv
         2SWA/0ogHqih7FsmM8ct9nGbsBXOv56BcyhYh3NWITw3yuLrraxRIni1+eEUCu9N7b
         tozLZjwjjT7Vsqcw3SzonKToq/K379hJdvnqaqaypjSS0u4+kotqbrhTy77h7ptNT9
         drYq6rR7VOWSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D0735C0584; Tue, 29 Nov 2022 15:58:31 -0800 (PST)
Date:   Tue, 29 Nov 2022 15:58:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 0/6] selftests: Use "grep -E" instead of "egrep"
Message-ID: <20221129235831.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
 <bf9b26b5-2793-204f-ba9c-4d9cd55b08ad@loongson.cn>
 <dc7cb519-584c-55f1-4baa-44cd4e0bbfe9@linuxfoundation.org>
 <20221129221344.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <d48804d5-2ad5-fbfb-ce17-83fbc450d3d6@linuxfoundation.org>
 <20221129232212.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <07f475de-98ae-87b2-0215-12a4a2b054d6@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f475de-98ae-87b2-0215-12a4a2b054d6@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 29, 2022 at 04:30:39PM -0700, Shuah Khan wrote:
> On 11/29/22 16:22, Paul E. McKenney wrote:
> 
> > Lazybones that I am, I would rather carry the patch than resolve
> > conflicts.  Especially given the tendency for new rcutorture patches to
> > appear, thus changing the conflict resolution.
> > 
> 
> Sounds good. I will drop the one I applied to my tree.
> 
> > My guess is that the patch is this one:
> > 
> > https://lore.kernel.org/lkml/1669165413-12035-2-git-send-email-yangtiezhu@loongson.cn/
> > 
> > Or should I be looking elsewhere?
> 
> Yup that is one.

Very good, thank you!  I have queued it as shown below.

							Thanx, Paul

------------------------------------------------------------------------

commit 72dcfda0e73be7e2e8b7faf0299b0f43c20af015
Author: Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Wed Nov 23 09:03:28 2022 +0800

    selftests: rcutorture: Use "grep -E" instead of "egrep"
    
    The latest version of grep is deprecating the egrep command, so that
    its output contains warnings as follows:
    
            egrep: warning: egrep is obsolescent; using grep -E
    
    Fix this using "grep -E" instead.
    
      sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests/rcutorture`
    
    Here are the steps to install the latest grep:
    
      wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
      tar xf grep-3.8.tar.gz
      cd grep-3.8 && ./configure && make
      sudo make install
      export PATH=/usr/local/bin:$PATH
    
    Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 69f8a5958cefc..aad51e7c0183d 100755
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
index e28a82851f7c4..11f8d232b0ee7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -44,10 +44,10 @@ fi
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
index d4dc059843a43..28981007465bd 100755
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
 	elif ! test -f ${scenariobasedir}/vmlinux && ! test -f ${scenariobasedir}/vmlinux.xz && ! test -f "${rundir}/re-run"
 	then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7710b1e1cddab..3025a949bc99e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -585,7 +585,7 @@ awk < $T/cfgcpu.pack \
 echo kvm-end-run-stats.sh "$resdir/$ds" "$starttime" >> $T/script
 
 # Extract the tests and their batches from the script.
-egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+grep -E 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 	sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
 	awk '
 	/^----Start/ {
@@ -622,7 +622,7 @@ then
 elif test "$dryrun" = sched
 then
 	# Extract the test run schedule from the script.
-	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+	grep -E 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
 	nbuilds="`grep 'Starting build\.' $T/script |
 		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 822eb037a0573..9ab0f6bc172cd 100755
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
