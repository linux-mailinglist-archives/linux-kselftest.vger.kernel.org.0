Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B349BAFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbiAYSJN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 13:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbiAYSJJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 13:09:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B8C061744;
        Tue, 25 Jan 2022 10:09:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08ED361559;
        Tue, 25 Jan 2022 18:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBDDC340E0;
        Tue, 25 Jan 2022 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643134147;
        bh=RCwubrryEcnOGjNUPjDunBN36HJmqoNuQe1mX3V8b90=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hhV16HqANs3S39YkxwkTuGzIzTuVPDFdJyyEwuzVN2gupGy5MsJ42Cgy4I0cjrhJZ
         hp4BZvsm1UQEowJOyGVuKjyMiR23DcaiGpFsmKsAkhTGZpAtCv9kKGK30Uy3vhma4Z
         g0WvNyAjN0GgGRnnYZAST34DWEpL5RuB5n0uVrfNy58+7y7Qv5AP7ZPg32JvkUfL7x
         XdNvdDiAJEhv6dIAEeohf+I691BOEz/hCkQ8DUn+Bhut+Yy7VOcumAv9Y4WAF1u0sq
         41oRwEnhTtIYVDMGOoiv51fBpnFrBQgNPU4H/U4F52Wgj6YxTgvd7tZtriK9Isoes4
         bAjBgbBm0hZTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 219025C0641; Tue, 25 Jan 2022 10:09:07 -0800 (PST)
Date:   Tue, 25 Jan 2022 10:09:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Message-ID: <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
 <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1>
 <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
 <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 12:19:58AM +0800, Zhouyi Zhou wrote:
> Hi Paul
> 
> On Fri, Jan 21, 2022 at 8:44 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > Thank Paul for your guidance!
> >
> > On Fri, Jan 21, 2022 at 5:06 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Jan 20, 2022 at 03:30:54AM +0800, Zhouyi Zhou wrote:
> > > > On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> > > > > > > Thanks Paul for looking into this
> > > > > > >
> > > > > > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wrote:
> > > > > > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> > > > > > > > > > Dear Zhouyi,
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thank you for your quick response.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > > > > > >
> > > > > > > > > > > I have studied the rcu torture test recently. I am also interested in
> > > > > > > > > > > this topic.
> > > > > > > > > > > But I can't open
> > > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> > > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
> > > > > > > > > >
> > > > > > > > > > Sorry, about that. I should have checked those. I had put them into a
> > > > > > > > > > directory:
> > > > > > > > > >
> > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
> > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt
> > > > > > > > > >
> > > > > > > > > > I am going to try to test your suggestions at the end of the day.
> > > > > > > > >
> > > > > > > > > On x86 rcutorture builds successfully.  However, allmodconfig
> > > > > > > > > on semi-recent -next got me "Can't open perl script
> > > > > > > > > "./usr/include/headers_check.pl": No such file or directory".
> > > > > > > > > Which might well be a local problem or might well be fixed by now.
> > > > > > > >
> > > > > > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > > > > > I can do allmodconfig on -next,
> > > > > > > $git describe
> > > > > > > next-20220118
> > > > > > > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > > > > > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > > > > > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > > > > > $ ps -aux|grep qemu-system
> > > > > > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55  31:27
> > > > > > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none -machine
> > > > > > > q35,accel=kvm -cpu kvm64 -serial
> > > > > > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > > > > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > > > > > -append debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug
> > > > > > > console=ttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=1
> > > > > > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000
> > > > > > > rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> > > > > > > rcutree.gp_preinit_delay=12 rcutree.gp_init_delay=3
> > > > > > > rcutree.gp_cleanup_delay=3 rcutree.kthread_prio=2 threadirqs
> > > > > > > tree.use_softirq=0 rcutorture.n_barrier_cbs=4
> > > > > > > rcutorture.stat_interval=15 rcutorture.shutdown_secs=420
> > > > > > > rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
> > > > > > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59   0:00
> > > > > > > grep --color=auto qemu-system
> > > > > > > $ ls -l vmlinux
> > > > > > > -rwxrwxr-x 1 zzy zzy 69349872 1月  19 09:55 vmlinux
> > > > > > >
> > > > > > > Could you please try the following command ?
> > > > > > > linux-next$ perl ./usr/include/headers_check.pl usr/include x86
> > > > > > > usr/include/rdma/hfi/hfi1_user.h
> > > > > > > linux-next$ echo $?
> > > > > > > 0
> > > > > > > The headers_check.pl in linux-next
> > > > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/usr/include/headers_check.pl)
> > > > > > > is used to check the validity of head files in ./usr/include
> > > > > >
> > > > > > I am currently bisecting, but once that finishes I will give this a
> > > > > > try, thank you!
> > > > >
> > > > > And the bisection converged badly due to there being more than one build
> > > > > failure.
> > > > Sorry to hear the bisection is not successful.
> > > > >
> > > > > So I ran the command above and then the build succeeded.
> > > > I'm very happy that the command works.
> > > > >
> > > > > Though it would be good if the build worked from "make distclean"...
> > > > I would be very honored if I could join the efforts to make the -next better.linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23.10.36-torture/allmodconfig
> > >
> > > One approach would be to download the -next kernels as they appear and
> > > run tests on them.  Reporting bugs is good, and of course fixing them
> > > even better.
> > This provides a nice way of participating the efforts to make -next
> > better, and provides me a good way to learn new knowledge in -next!
> >
> > >
> > > You can clone -next from here:
> > >
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >
> > > Individual -next releases are tagged, for example, "next-20220118".
> > I will clone -next from the tree, and will download the -next releases from
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> I cloned -next, and try to test rcu:
> $git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git
> (kernel.source.codeaurora.cn is Chinese mirror of  git.kernel.org)
> $cd linux-next
> $git describe
> next-20220125
> $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> $cd linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23.10.36-torture/allmodconfig
> $cat Make.exitcode
> 2
> $grep Stop Make.out
> make[2]: *** No rule to make target
> 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftests/rcutorture/kvm_main.o',
> needed by 'arch/x86/kvm/kvm.o'.  Stop.
> I tried the above two times in two different machines today, they all failed.
> 
> 
> Meanwhile I can config and build the kernel successfully by invoking
> the build commands by hand:
> $git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git
> $cd linux-next
> $git describe
> next-20220125

Huh.  What happens if you do a "make clean" betweentimes?

Alternatively, what happens if you change these two lines from torture.sh:

	echo " --- make clean" > "$amcdir/Make.out" 2>&1
	make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1

To this:

	echo " --- make distclean" > "$amcdir/Make.out" 2>&1
	make -j$MAKE_ALLOTED_CPUS distclean >> "$amcdir/Make.out" 2>&1

And then run torture.sh in the same way that got you the error?

							Thanx, Paul

> $make allmodconfig
> $make -j 16
> Kernel: arch/x86/boot/bzImage is ready  (#2)
>   GEN     Module.symvers
> $echo $?
> 0
> 
> I am very interested in this problem and I am eager to try to dig out
> what happened and fix it before this Sunday. And it is more delightful
> to me that other developers can solve this problem because they are
> more mature than me ;-)
> 
> Many thanks
> Zhouyi
> > >
> > > Me, I run torture.sh on them from time to time, depending on how much
> > > other testing I am doing.  So maybe once or twice a week.  ;-)
> > You are the example worth learning in my life, to be honest , I will
> > do the same way as you do!
> >
> > Sincerely
> > Zhouyi
> > >
> > >                                                 Thanx, Paul
> > >
> > > > Many thanks
> > > > Zhouyi
> > > > >
> > > > >                                                         Thanx, Paul
> > > > >
> > > > > > > > > Either way, it looks like I need to upgrade the torture.sh script's
> > > > > > > > > checks for failed builds.  Thank you for reporting this!
> > > > > > > >
> > > > > > > > Does this make torture.sh more reliably report build failures?
> > > > > > > I studied this commit line by line several times and benefited a lot. Thank you!
> > > > > > > >
> > > > > > > >                                                 Thanx, Paul
> > > > > > > >
> > > > > > > > ------------------------------------------------------------------------
> > > > > > > >
> > > > > > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > > > > > >
> > > > > > > >     torture: Make kvm-find-errors.sh notice missing vmlinux file
> > > > > > > >
> > > > > > > >     Currently, an obtuse compiler diagnostic can fool kvm-find-errors.sh
> > > > > > > >     into believing that the build was successful.  This commit therefore
> > > > > > > >     adds a check for a missing vmlinux file.
> > > > > > > >
> > > > > > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de/
> > > > > > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > >
> > > > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > > > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > > > @@ -30,10 +30,15 @@ editor=${EDITOR-vi}
> > > > > > > >  files=
> > > > > > > >  for i in ${rundir}/*/Make.out
> > > > > > > >  do
> > > > > > > > +       scenariodir="`dirname $i`"
> > > > > > > >         if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
> > > > > > > >         then
> > > > > > > >                 egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
> > > > > > > >                 files="$files $i.diags $i"
> > > > > > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > > > > > +       then
> > > > > > > > +               echo No ${scenariodir}/vmlinux file > $i.diags
> > > > > > > > +               files="$files $i.diags $i"
> > > > > > > >         fi
> > > > > > > >  done
> > > > > > > >  if test -n "$files"
> > > > > > > Thanks
> > > > > > > Zhouyi
