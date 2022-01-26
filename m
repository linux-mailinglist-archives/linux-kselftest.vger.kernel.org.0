Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B25B49C2D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 05:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiAZEu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 23:50:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48616 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiAZEuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 23:50:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 412D2B81B96;
        Wed, 26 Jan 2022 04:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE593C340E3;
        Wed, 26 Jan 2022 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643172622;
        bh=shs7769C4RT+qwkFZwCKZ/aAXrMWLytTFS4f56hiP/8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oz1jAjGjT0QTsLoqHw4Q3aaLOUDOiWAl4M2lEHIXSl4Qz/IHbjhkyMBFD2BgCr0Th
         AazJTsZ6SAXfrz7ZEe9q/461IllAV8k9FJfI6J6+BqUfNdpkDaWFu9sO7TXmOonXk7
         DETEcJvnKq2oQ5QmAmB28BmeyMvPGaoujppp2q3Qqr6Un+HuEAAsq/SqDtPVrEcZK2
         xgeSbP6Drk8h5rxpzDgBetFJH8Tth7l2xQGDyPBW5hbW0uI6ZgxukbT/dDgdXvxkbC
         JknyEKRuz46ERaMEhH5GMnkkvLX7yjHoP99Arl++U0fE3AfSatF+ED8wZ2sDCsBlWt
         3DDNeGeTwtWeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A39A55C102F; Tue, 25 Jan 2022 20:50:22 -0800 (PST)
Date:   Tue, 25 Jan 2022 20:50:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Message-ID: <20220126045022.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1>
 <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
 <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
 <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xGZ__8MZWL0kGAdYJ9ZNq2omw9-VTACmrG8wR8RswG2A@mail.gmail.com>
 <CAABZP2wt03juddoKfxO0m=+kn407267jLJn+gPRzU-w3nUBkAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2wt03juddoKfxO0m=+kn407267jLJn+gPRzU-w3nUBkAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 12:09:12PM +0800, Zhouyi Zhou wrote:
> Great Discovery !!
> Hi Paul,
> I track the log
> make[2]: *** No rule to make target
> 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftests/rcutorture/kvm_main.o',

That does look like a very odd pathname, now that you mention it.

> needed by 'arch/x86/kvm/kvm.o
> into the file virt/kvm/Makefile.kvm:
> 1# SPDX-License-Identifier: GPL-2.0
>  2#
>  3# Makefile for Kernel-based Virtual Machine module
>  4#
>  5
>  6KVM ?= ../../../virt/kvm
>  7
>  8kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
>  9kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> 10kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
> 11kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
> 12kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
> 13kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
> 14kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
> line 6's ?= indicates to set the KDIR variable only if it's not
> set/doesn't have a value.
> 
> I guess we have set the variable KVM somewhere before make, I will
> continue tracking it.

But if you build an allmodconfig kernel by hand afterwards, it works?

I wonder if I need to use a different environment variable in my scripts.
For example, from tools/testing/selftests/rcutorture/bin/kvm.sh:

KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
PATH=${KVM}/bin:$PATH; export PATH

Maybe like the (untested) patch shown below.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 5a0023d183dac..0941f1ddab658 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -47,8 +47,8 @@ else
 	exit 1
 fi
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 dryrun=
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
index 370406bbfeedc..f17000a2ccf1f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -49,8 +49,8 @@ fi
 mkdir $resdir/$ds
 echo Results directory: $resdir/$ds
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 echo Using all `identify_qemu_vcpus` CPUs.
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
index e4a00779b8c69..ee886b40a5d2c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
@@ -22,8 +22,8 @@ T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
 trap 'rm -rf $T' 0
 mkdir $T
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 default_starttime="`get_starttime`"
 starttime="${2-default_starttime}"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 29b068a55b466..8c4c1e4792d02 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -19,8 +19,8 @@ then
 	exit 1
 fi
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 starttime="`get_starttime`"
@@ -108,8 +108,8 @@ else
 		cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
 		exit 2
 	fi
-	cp -a "$rundir" "$KVM/res/"
-	oldrun="$KVM/res/$ds"
+	cp -a "$rundir" "$RCUTORTURE/res/"
+	oldrun="$RCUTORTURE/res/$ds"
 fi
 echo | tee -a "$oldrun/remote-log"
 echo " ----" kvm-again.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 348ad177a5acc..55b2c15332827 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -25,15 +25,15 @@ LANG=en_US.UTF-8; export LANG
 
 dur=$((30*60))
 dryrun=""
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_BUILDONLY=
-TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
+TORTURE_INITRD="$RCUTORTURE/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
 TORTURE_BOOT_GDB_ARG=""
@@ -262,7 +262,7 @@ else
 	exit 1
 fi
 
-CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
+CONFIGFRAG=${RCUTORTURE}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
 defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
 if test -z "$configs"
@@ -272,7 +272,7 @@ fi
 
 if test -z "$resdir"
 then
-	resdir=$KVM/res
+	resdir=$RCUTORTURE/res
 fi
 
 # Create a file of test-name/#cpus pairs, sorted by decreasing #cpus.
@@ -386,7 +386,7 @@ END {
 # Generate a script to execute the tests in appropriate batches.
 cat << ___EOF___ > $T/script
 CONFIGFRAG="$CONFIGFRAG"; export CONFIGFRAG
-KVM="$KVM"; export KVM
+RCUTORTURE="$RCUTORTURE"; export RCUTORTURE
 PATH="$PATH"; export PATH
 TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
 TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
@@ -569,7 +569,7 @@ ___EOF___
 awk < $T/cfgcpu.pack \
 	-v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
 	-v CONFIGDIR="$CONFIGFRAG/" \
-	-v KVM="$KVM" \
+	-v RCUTORTURE="$RCUTORTURE" \
 	-v ncpus=$cpus \
 	-v jitter="$jitter" \
 	-v rd=$resdir/$ds/ \
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d1cb60085d8f2..e00e60efb2310 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -13,8 +13,8 @@
 scriptname=$0
 args="$*"
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
