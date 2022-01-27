Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7C49D786
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 02:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiA0BiL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 20:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiA0BiK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 20:38:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E38DC06161C;
        Wed, 26 Jan 2022 17:38:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j2so1536082edj.8;
        Wed, 26 Jan 2022 17:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvJNY/0XI0Ylta2Q4tpOKR92HP13p4JOaiJ1Bv4J1WM=;
        b=j/HalyxknFy8YBrieYTXS3p2UEFuvtKMcfrjMaol2HkO2lv1D3gbV6aNov41qyF+DY
         Kpk8IheJ7V2kp/KfFQ8RWXxexDvFlI477F0hLLaVknmoZQGKHlw4HQw2ID4OdolcdyJL
         jjY6fK3bSKdujpuSnNLntNqzCS/YubyspamERpl58AXUtHnjzCwEaE+AAN4lQz5TSZwG
         Tpe9LWzBGQrOY3aruCG7l2g+LP5jL+hd+MY85gaFAPvonks0san7SilDqGZdwmws+MmL
         pMfTQC8in6erS0MxYADFLErK7QeGG0ZDczvy/4Y9huH5SUrb5rTJcuKWS3r/fp/PQ3+a
         tXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvJNY/0XI0Ylta2Q4tpOKR92HP13p4JOaiJ1Bv4J1WM=;
        b=m3WPhitLv5ci+d3VxudUyAteKPg7Czc+wOJqj9dhFyXTgt7T0ehaY4V1axuJqePe1x
         qGD66xYUTBN4meIN35nm8L+KJHzOaFObQkTWmNJjkp29s7zfnBT9/EsUiqPqGIkHAZd6
         Z1pvSExKaAGY2swRJOlbnWM83pMSpKz8r1fcq81XOaY9W+zenrZIKaZq6zSLFPqP1x3Q
         f7ERUCPCHe6HEAVvKIb/oSwrgURMhHfLP89LCHyJeMMhBbpgWKLUh2XK01zVkg3U/Wui
         wlZKogUWMnbBNEmV0oDDvAYg6FU6nq8zaEY0uczicMHTQt/q8YEKGbgObxfy8hFgb2yR
         PBrA==
X-Gm-Message-State: AOAM531rTzNlAfLKyMjfmC0ju7G00wb7jrPZcqxhuNW/nx1kauhqX0Vi
        u1myKJPV5a/TJRDmjh80WGdJzmYsf0vhrOOex/c=
X-Google-Smtp-Source: ABdhPJz02JZbCJtpaUMjheuwdWeFT9XBnLY2eMsgQg7346zLY6fnin+ULMwT6Sy8X2XjvIYWVXBtaiaYxfrODh+FZOg=
X-Received: by 2002:aa7:cd0b:: with SMTP id b11mr1565170edw.412.1643247488526;
 Wed, 26 Jan 2022 17:38:08 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
 <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
 <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2xGZ__8MZWL0kGAdYJ9ZNq2omw9-VTACmrG8wR8RswG2A@mail.gmail.com>
 <CAABZP2wt03juddoKfxO0m=+kn407267jLJn+gPRzU-w3nUBkAQ@mail.gmail.com>
 <20220126045022.GW4285@paulmck-ThinkPad-P17-Gen-1> <20220126051427.GA3240075@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xEQCCz3WKP8XbRmfb+F0e7DP9U+OHn30iHqnHEe0YR_g@mail.gmail.com> <20220127012003.GB4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220127012003.GB4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 27 Jan 2022 09:37:56 +0800
Message-ID: <CAABZP2yhWPKDp15i+qerg0m2aXywgShRq87Hq4KQ0R6knHLZyA@mail.gmail.com>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other failures
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 9:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jan 27, 2022 at 08:57:02AM +0800, Zhouyi Zhou wrote:
> > Hi Paul
> >
> > Thank you for your perfect patch!
> >
> > After apply your patch, I invoke
> > "tools/testing/selftests/rcutorture/bin/torture.sh --duration 10" on
> > next-20220125. we succeed in allmodconfig!
>
> Very good!
>
> > Following are the test logs (154.223.142.244 is my own internet cloud
> > server maintained by myself, I believe it is safe to access the text
> > content via web, but not so sure)
> >
> > 1. torture log
> > http://154.223.142.244/logs/20220127/2022.01.26-19.43.04.log (there
> > are many Chinese words "Thursday" in it because I forget to set
> > terminal locale to English, I am sorry), I excerpt some content here:
>
> Not a problem, Google Translate decided that this was the corresponding
> English:
>
>         Thursday January 27th, 2022
>
> I really do need to get my browser to do the Chinese characters.  My
> vim displays them just fine.  :-/
Thank Paul for your interest in Chinese culture, to be honest ;-)
>
> > SUCCESSES:
> > allmodconfig(0)
> > tools/testing/selftests/rcutorture/res/2022.01.26-19.43.04-torture/allmodconfig
> > FAILURES:
> > rcutorture(2) /home/zzy/Program/linux-next/linux-next/tools/testing/selftests/rcutorture/res/2022.01.26-19.43.04-torture/results-rcutorture
> >   Summary: Warnings: 1 Call Traces: 1
> >   Summary: Warnings: 1 Call Traces: 1
> >   Summary: Warnings: 1 Call Traces: 1
> >   Summary: Warnings: 1 Call Traces: 1
> >   Summary: Warnings: 1 Call Traces: 1
> >
> > 2. Make.exitcode for allmodeconfig
> > http://154.223.142.244/logs/20220127/allmodconfig/Make.exitcode
>
> Zero, which is good.  ;-)
glad you like it ;-)
>
> > 3. Make.out for allmodeconfig
> > http://154.223.142.244/logs/20220127/allmodconfig/Make.out
> >
> > 4. result of invoking: find 2022.01.26-19.43.04-torture -name
> > console.log.diags|xargs -I{} echo "echo {}; cat {}"|xargs -I{} bash -c
> > "{}":
> > http://154.223.142.244/logs/20220127/consoles.logs.diags
> > All of the console.log.diags complain about one thing:
> > 2022.01.26-19.43.04-torture/results-refscale-clock/NOPREEMPT/console.log.diags
> > [    0.017721] WARNING: CPU: 0 PID: 0 at
> > kernel/trace/trace_events.c:417 trace_event_raw_init+0xea/0x580
> > [    0.017754] Call Trace:
> > 2022.01.26-19.43.04-torture/results-rcuscale-kvfree-kasan/TREE/console.log.diags
> > [    0.102911] WARNING: CPU: 0 PID: 0 at
> > kernel/trace/trace_events.c:417 trace_event_raw_init+0x113/0x6e0
> > [    0.102992] Call Trace:
> > 2022.01.26-19.43.04-torture/results-rcuscale-tasks-tracing-kasan/TREE/console.log.diags
> > [    0.060924] WARNING: CPU: 0 PID: 0 at
> > kernel/trace/trace_events.c:417 trace_event_raw_init+0x113/0x6e0
> > [    0.061006] Call Trace:
> > I am glad to study these warnings further but they don't seem to be
> > related to this patch.
>
> There was at least one RCU bug in this -next, fixed by this commit:
>
> da123016ca8c ("rcu-tasks: Fix computation of CPU-to-list shift counts")
>
> But this warning looks like something else.  For one thing, you would
> have had to be running on a system with exactly three CPUs to trigger
> the RCU bug given the usual rcutorture scenarios.
This give me new orientation to studying!
>
> May I add your Tested-by to this commit?
I feel greatly honored and encouraged!
>
>                                                 Thanx, Paul
Thanks again
Sincerely
Zhouyi
>
> > Thanks again
> > Sincerely
> > Zhouyi
> >
> > On Wed, Jan 26, 2022 at 1:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Tue, Jan 25, 2022 at 08:50:22PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Jan 26, 2022 at 12:09:12PM +0800, Zhouyi Zhou wrote:
> > > > > Great Discovery !!
> > > > > Hi Paul,
> > > > > I track the log
> > > > > make[2]: *** No rule to make target
> > > > > 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftests/rcutorture/kvm_main.o',
> > > >
> > > > That does look like a very odd pathname, now that you mention it.
> > > >
> > > > > needed by 'arch/x86/kvm/kvm.o
> > > > > into the file virt/kvm/Makefile.kvm:
> > > > > 1# SPDX-License-Identifier: GPL-2.0
> > > > >  2#
> > > > >  3# Makefile for Kernel-based Virtual Machine module
> > > > >  4#
> > > > >  5
> > > > >  6KVM ?= ../../../virt/kvm
> > > > >  7
> > > > >  8kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> > > > >  9kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> > > > > 10kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
> > > > > 11kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
> > > > > 12kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
> > > > > 13kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
> > > > > 14kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
> > > > > line 6's ?= indicates to set the KDIR variable only if it's not
> > > > > set/doesn't have a value.
> > > > >
> > > > > I guess we have set the variable KVM somewhere before make, I will
> > > > > continue tracking it.
> > > >
> > > > But if you build an allmodconfig kernel by hand afterwards, it works?
> > > >
> > > > I wonder if I need to use a different environment variable in my scripts.
> > > > For example, from tools/testing/selftests/rcutorture/bin/kvm.sh:
> > > >
> > > > KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > > PATH=${KVM}/bin:$PATH; export PATH
> > > >
> > > > Maybe like the (untested) patch shown below.
> > >
> > > A somewhat more official version below.  Thank you for following up
> > > on this!
> > >
> > >                                                         Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > commit 6b5cdbe80b01ce604fdf0f3ef6717a6466aca041
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Jan 25 21:08:55 2022 -0800
> > >
> > >     torture: Change KVM environment variable to RCUTORTURE
> > >
> > >     The torture-test scripting's long-standing use of KVM as the environment
> > >     variable tracking the pathname of the rcutorture directory now conflicts
> > >     with allmodconfig builds due to the virt/kvm/Makefile.kvm file's use
> > >     of this as a makefile variable.  This commit therefore changes the
> > >     torture-test scripting from KVM to RCUTORTURE, avoiding the name conflict.
> > >
> > >     Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> > > index 5a0023d183dac..0941f1ddab658 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> > > @@ -47,8 +47,8 @@ else
> > >         exit 1
> > >  fi
> > >
> > > -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > -PATH=${KVM}/bin:$PATH; export PATH
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > >  . functions.sh
> > >
> > >  dryrun=
> > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
> > > index 370406bbfeedc..f17000a2ccf1f 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
> > > @@ -49,8 +49,8 @@ fi
> > >  mkdir $resdir/$ds
> > >  echo Results directory: $resdir/$ds
> > >
> > > -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > -PATH=${KVM}/bin:$PATH; export PATH
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > >  . functions.sh
> > >  echo Using all `identify_qemu_vcpus` CPUs.
> > >
> > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
> > > index e4a00779b8c69..ee886b40a5d2c 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
> > > @@ -22,8 +22,8 @@ T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
> > >  trap 'rm -rf $T' 0
> > >  mkdir $T
> > >
> > > -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > -PATH=${KVM}/bin:$PATH; export PATH
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > >  . functions.sh
> > >  default_starttime="`get_starttime`"
> > >  starttime="${2-default_starttime}"
> > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
> > > index 29b068a55b466..8c4c1e4792d02 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
> > > @@ -19,8 +19,8 @@ then
> > >         exit 1
> > >  fi
> > >
> > > -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > -PATH=${KVM}/bin:$PATH; export PATH
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > >  . functions.sh
> > >
> > >  starttime="`get_starttime`"
> > > @@ -108,8 +108,8 @@ else
> > >                 cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
> > >                 exit 2
> > >         fi
> > > -       cp -a "$rundir" "$KVM/res/"
> > > -       oldrun="$KVM/res/$ds"
> > > +       cp -a "$rundir" "$RCUTORTURE/res/"
> > > +       oldrun="$RCUTORTURE/res/$ds"
> > >  fi
> > >  echo | tee -a "$oldrun/remote-log"
> > >  echo " ----" kvm-again.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
> > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> > > index 348ad177a5acc..55b2c15332827 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> > > @@ -25,15 +25,15 @@ LANG=en_US.UTF-8; export LANG
> > >
> > >  dur=$((30*60))
> > >  dryrun=""
> > > -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > -PATH=${KVM}/bin:$PATH; export PATH
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > >  . functions.sh
> > >
> > >  TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
> > >  TORTURE_DEFCONFIG=defconfig
> > >  TORTURE_BOOT_IMAGE=""
> > >  TORTURE_BUILDONLY=
> > > -TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
> > > +TORTURE_INITRD="$RCUTORTURE/initrd"; export TORTURE_INITRD
> > >  TORTURE_KCONFIG_ARG=""
> > >  TORTURE_KCONFIG_GDB_ARG=""
> > >  TORTURE_BOOT_GDB_ARG=""
> > > @@ -262,7 +262,7 @@ else
> > >         exit 1
> > >  fi
> > >
> > > -CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
> > > +CONFIGFRAG=${RCUTORTURE}/configs/${TORTURE_SUITE}; export CONFIGFRAG
> > >
> > >  defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
> > >  if test -z "$configs"
> > > @@ -272,7 +272,7 @@ fi
> > >
> > >  if test -z "$resdir"
> > >  then
> > > -       resdir=$KVM/res
> > > +       resdir=$RCUTORTURE/res
> > >  fi
> > >
> > >  # Create a file of test-name/#cpus pairs, sorted by decreasing #cpus.
> > > @@ -386,7 +386,7 @@ END {
> > >  # Generate a script to execute the tests in appropriate batches.
> > >  cat << ___EOF___ > $T/script
> > >  CONFIGFRAG="$CONFIGFRAG"; export CONFIGFRAG
> > > -KVM="$KVM"; export KVM
> > > +RCUTORTURE="$RCUTORTURE"; export RCUTORTURE
> > >  PATH="$PATH"; export PATH
> > >  TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
> > >  TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
> > > @@ -569,7 +569,7 @@ ___EOF___
> > >  awk < $T/cfgcpu.pack \
> > >         -v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
> > >         -v CONFIGDIR="$CONFIGFRAG/" \
> > > -       -v KVM="$KVM" \
> > > +       -v RCUTORTURE="$RCUTORTURE" \
> > >         -v ncpus=$cpus \
> > >         -v jitter="$jitter" \
> > >         -v rd=$resdir/$ds/ \
> > > diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> > > index d1cb60085d8f2..e00e60efb2310 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> > > @@ -13,8 +13,8 @@
> > >  scriptname=$0
> > >  args="$*"
> > >
> > > -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > > -PATH=${KVM}/bin:$PATH; export PATH
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > >  . functions.sh
> > >
> > >  TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
