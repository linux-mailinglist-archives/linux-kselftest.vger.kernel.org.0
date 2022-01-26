Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AF49C33B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 06:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiAZF3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 00:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiAZF3N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 00:29:13 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324DC061744;
        Tue, 25 Jan 2022 21:29:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j23so62077465edp.5;
        Tue, 25 Jan 2022 21:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PDdpxJRSa9UjiKgrk6TgyjF82dXoOGQZ1P6ZtEXjA8=;
        b=nHjo7L8Jh50vZ/kfcUkLlOiGHLl5EcW8v2dxLfCuByJLDkpoJwGbV5Pg2x/lG4ys/r
         4fbehsQkVZ1IRNFMnvErMvh6toF5nwbPW0Ff3ag82xXKU+cNHeXI64PZuPDf4KS1RqFI
         u7+mX7OwCHI7nfMU+A/fVFbcw81ieY/poVAbrjjZThh0o2TkHhpr1h7MXlSxbypOdfUh
         1yWRshYq+Ho1/YrQJ0QoC4nHFQhRKr03MlCBsAS8Yh7JgKveg+JP13SV3xwDgzLUnAQI
         GppaHODCRrA0DIovHxtVmoLAg3LI0IeOu+xcazzCSDba3o/F3pEee2zC6LLbmfjzONlv
         ROaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PDdpxJRSa9UjiKgrk6TgyjF82dXoOGQZ1P6ZtEXjA8=;
        b=jShjjnFgVWL2vK9t7DTBB32H5RXitq26SIgsZnxYz4IN26lKh3TLhtVJTCjbr7RQWX
         s1hbnlm9zx3bcH393qLCCi/Sx0FICD07KghRIwN7w0S7bHsPaAzlJfk2RE8in/KsYL8M
         9PCpKng3Xbi3F59bgTf4vLq3LcoOn1Mbo7maUrde61eRYn6SRW8ZHeovVSwEaGe3tGe2
         PNX317TmDrkfQl63T1QPpKmXzcnj3rKnUc1mrX9fMQ0esAOEsKTRjfCPRU8AxTfrcdiT
         FsDWDUrRxxHoiceqLXeo2fJYJTC4GpY0T5uc9nH7IZdU2rTsDYGEArj3QmwcMePTGs08
         jKaQ==
X-Gm-Message-State: AOAM5319XSRnBFLYjRZYcPfozWtbw9/cft4kmVjhkGW1p8Kl2gGGE0S3
        CzJ+HqwemPZ4e1YKwMdn51xhqEDbpSz0xrO0TP8=
X-Google-Smtp-Source: ABdhPJzNKB74HAnXwYwW9pgAXKjSKdOAdu5HGEb+K9iclcF4wwab6A0jW0r7EX3QD0vKy/JUnZKZfTk9dSwX7g2KINo=
X-Received: by 2002:a05:6402:270f:: with SMTP id y15mr1528219edd.329.1643174951510;
 Tue, 25 Jan 2022 21:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1>
 <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1> <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
 <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
 <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2xGZ__8MZWL0kGAdYJ9ZNq2omw9-VTACmrG8wR8RswG2A@mail.gmail.com>
 <CAABZP2wt03juddoKfxO0m=+kn407267jLJn+gPRzU-w3nUBkAQ@mail.gmail.com>
 <20220126045022.GW4285@paulmck-ThinkPad-P17-Gen-1> <20220126051427.GA3240075@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220126051427.GA3240075@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 26 Jan 2022 13:28:59 +0800
Message-ID: <CAABZP2wsR+nXWK1mdZxJ3FjSfgQ+Dx3HTa6gaEZPCysABrrY2g@mail.gmail.com>
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

Thanks Paul for fixing it

I will perform the tests now, since
"tools/testing/selftests/rcutorture/bin/torture.sh --duration 10"  may
last for some hours, I guess I will send the test results late at
night (Pacific Time) ;-)

Thanks again
Cheers
Zhouyi


On Wed, Jan 26, 2022 at 1:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jan 25, 2022 at 08:50:22PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 26, 2022 at 12:09:12PM +0800, Zhouyi Zhou wrote:
> > > Great Discovery !!
> > > Hi Paul,
> > > I track the log
> > > make[2]: *** No rule to make target
> > > 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftests/rcutorture/kvm_main.o',
> >
> > That does look like a very odd pathname, now that you mention it.
> >
> > > needed by 'arch/x86/kvm/kvm.o
> > > into the file virt/kvm/Makefile.kvm:
> > > 1# SPDX-License-Identifier: GPL-2.0
> > >  2#
> > >  3# Makefile for Kernel-based Virtual Machine module
> > >  4#
> > >  5
> > >  6KVM ?= ../../../virt/kvm
> > >  7
> > >  8kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> > >  9kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> > > 10kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
> > > 11kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
> > > 12kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
> > > 13kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
> > > 14kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
> > > line 6's ?= indicates to set the KDIR variable only if it's not
> > > set/doesn't have a value.
> > >
> > > I guess we have set the variable KVM somewhere before make, I will
> > > continue tracking it.
> >
> > But if you build an allmodconfig kernel by hand afterwards, it works?
> >
> > I wonder if I need to use a different environment variable in my scripts.
> > For example, from tools/testing/selftests/rcutorture/bin/kvm.sh:
> >
> > KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> > PATH=${KVM}/bin:$PATH; export PATH
> >
> > Maybe like the (untested) patch shown below.
>
> A somewhat more official version below.  Thank you for following up
> on this!
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 6b5cdbe80b01ce604fdf0f3ef6717a6466aca041
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jan 25 21:08:55 2022 -0800
>
>     torture: Change KVM environment variable to RCUTORTURE
>
>     The torture-test scripting's long-standing use of KVM as the environment
>     variable tracking the pathname of the rcutorture directory now conflicts
>     with allmodconfig builds due to the virt/kvm/Makefile.kvm file's use
>     of this as a makefile variable.  This commit therefore changes the
>     torture-test scripting from KVM to RCUTORTURE, avoiding the name conflict.
>
>     Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> index 5a0023d183dac..0941f1ddab658 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> @@ -47,8 +47,8 @@ else
>         exit 1
>  fi
>
> -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> -PATH=${KVM}/bin:$PATH; export PATH
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
>  . functions.sh
>
>  dryrun=
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
> index 370406bbfeedc..f17000a2ccf1f 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
> @@ -49,8 +49,8 @@ fi
>  mkdir $resdir/$ds
>  echo Results directory: $resdir/$ds
>
> -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> -PATH=${KVM}/bin:$PATH; export PATH
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
>  . functions.sh
>  echo Using all `identify_qemu_vcpus` CPUs.
>
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
> index e4a00779b8c69..ee886b40a5d2c 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
> @@ -22,8 +22,8 @@ T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
>  trap 'rm -rf $T' 0
>  mkdir $T
>
> -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> -PATH=${KVM}/bin:$PATH; export PATH
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
>  . functions.sh
>  default_starttime="`get_starttime`"
>  starttime="${2-default_starttime}"
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
> index 29b068a55b466..8c4c1e4792d02 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
> @@ -19,8 +19,8 @@ then
>         exit 1
>  fi
>
> -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> -PATH=${KVM}/bin:$PATH; export PATH
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
>  . functions.sh
>
>  starttime="`get_starttime`"
> @@ -108,8 +108,8 @@ else
>                 cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
>                 exit 2
>         fi
> -       cp -a "$rundir" "$KVM/res/"
> -       oldrun="$KVM/res/$ds"
> +       cp -a "$rundir" "$RCUTORTURE/res/"
> +       oldrun="$RCUTORTURE/res/$ds"
>  fi
>  echo | tee -a "$oldrun/remote-log"
>  echo " ----" kvm-again.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index 348ad177a5acc..55b2c15332827 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -25,15 +25,15 @@ LANG=en_US.UTF-8; export LANG
>
>  dur=$((30*60))
>  dryrun=""
> -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> -PATH=${KVM}/bin:$PATH; export PATH
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
>  . functions.sh
>
>  TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
>  TORTURE_DEFCONFIG=defconfig
>  TORTURE_BOOT_IMAGE=""
>  TORTURE_BUILDONLY=
> -TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
> +TORTURE_INITRD="$RCUTORTURE/initrd"; export TORTURE_INITRD
>  TORTURE_KCONFIG_ARG=""
>  TORTURE_KCONFIG_GDB_ARG=""
>  TORTURE_BOOT_GDB_ARG=""
> @@ -262,7 +262,7 @@ else
>         exit 1
>  fi
>
> -CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
> +CONFIGFRAG=${RCUTORTURE}/configs/${TORTURE_SUITE}; export CONFIGFRAG
>
>  defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
>  if test -z "$configs"
> @@ -272,7 +272,7 @@ fi
>
>  if test -z "$resdir"
>  then
> -       resdir=$KVM/res
> +       resdir=$RCUTORTURE/res
>  fi
>
>  # Create a file of test-name/#cpus pairs, sorted by decreasing #cpus.
> @@ -386,7 +386,7 @@ END {
>  # Generate a script to execute the tests in appropriate batches.
>  cat << ___EOF___ > $T/script
>  CONFIGFRAG="$CONFIGFRAG"; export CONFIGFRAG
> -KVM="$KVM"; export KVM
> +RCUTORTURE="$RCUTORTURE"; export RCUTORTURE
>  PATH="$PATH"; export PATH
>  TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
>  TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
> @@ -569,7 +569,7 @@ ___EOF___
>  awk < $T/cfgcpu.pack \
>         -v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
>         -v CONFIGDIR="$CONFIGFRAG/" \
> -       -v KVM="$KVM" \
> +       -v RCUTORTURE="$RCUTORTURE" \
>         -v ncpus=$cpus \
>         -v jitter="$jitter" \
>         -v rd=$resdir/$ds/ \
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> index d1cb60085d8f2..e00e60efb2310 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -13,8 +13,8 @@
>  scriptname=$0
>  args="$*"
>
> -KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
> -PATH=${KVM}/bin:$PATH; export PATH
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
>  . functions.sh
>
>  TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
