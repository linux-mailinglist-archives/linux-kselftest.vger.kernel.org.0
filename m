Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B738E493417
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jan 2022 05:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiASEqz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 23:46:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49820 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351512AbiASEqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 23:46:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DC5AB80DF5;
        Wed, 19 Jan 2022 04:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8052C004E1;
        Wed, 19 Jan 2022 04:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642567609;
        bh=Vpa9UuAY53sQIkH/qLs8hCTyPnrtBhfyRRMGetWd0zg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n1S2mhG5HUzH/xvBwCylu2g6ulBxcKwrqQNkK0S2DMLjcvVBNl4ByXnN+lmrzhE5k
         qi3keMvXu1CwrE32b2SggbjpwyRYpG6i/7Mas9aSF3tS+yMfzirvC+WO3HevV05bvt
         2aUV/iltmmIJwrQ8sZ7gZ8s9AKN+/Oq5KL/qjNmjyyQ7ZKelJCTqmskSTC2y63e04p
         sS+0xHsmxutvuhn9ZA8PI9qEyINVq2VdYBLQhtbKNp5I6s7CQI0Kmk9NDFfes4iNc4
         UylgS0qZs9G3QZ+E+R0cQuAmg3CJgqcgKCMxAHBOYUMM5oORGHm38FIdqqmGmkiAqs
         18gIDCgfPVkkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 694C35C0A21; Tue, 18 Jan 2022 20:46:49 -0800 (PST)
Date:   Tue, 18 Jan 2022 20:46:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Message-ID: <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
 <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> Thanks Paul for looking into this
> 
> On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> > > > Dear Zhouyi,
> > > >
> > > >
> > > > Thank you for your quick response.
> > > >
> > > >
> > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > >
> > > > > I have studied the rcu torture test recently. I am also interested in
> > > > > this topic.
> > > > > But I can't open
> > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
> > > >
> > > > Sorry, about that. I should have checked those. I had put them into a
> > > > directory:
> > > >
> > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
> > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt
> > > >
> > > > I am going to try to test your suggestions at the end of the day.
> > >
> > > On x86 rcutorture builds successfully.  However, allmodconfig
> > > on semi-recent -next got me "Can't open perl script
> > > "./usr/include/headers_check.pl": No such file or directory".
> > > Which might well be a local problem or might well be fixed by now.
> >
> > Not fixed as of next-20220118.  Chasing it down...  ;-)
> I can do allmodconfig on -next,
> $git describe
> next-20220118
> $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
>  ---  tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
>  --- Results directory:  2022.01.19-09.14.39-torture
> $ ps -aux|grep qemu-system
> zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55  31:27
> qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none -machine
> q35,accel=kvm -cpu kvm64 -serial
> file:/tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> -append debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug
> console=ttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=1
> torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000
> rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> rcutree.gp_preinit_delay=12 rcutree.gp_init_delay=3
> rcutree.gp_cleanup_delay=3 rcutree.kthread_prio=2 threadirqs
> tree.use_softirq=0 rcutorture.n_barrier_cbs=4
> rcutorture.stat_interval=15 rcutorture.shutdown_secs=420
> rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
> zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59   0:00
> grep --color=auto qemu-system
> $ ls -l vmlinux
> -rwxrwxr-x 1 zzy zzy 69349872 1月  19 09:55 vmlinux
> 
> Could you please try the following command ?
> linux-next$ perl ./usr/include/headers_check.pl usr/include x86
> usr/include/rdma/hfi/hfi1_user.h
> linux-next$ echo $?
> 0
> The headers_check.pl in linux-next
> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/usr/include/headers_check.pl)
> is used to check the validity of head files in ./usr/include

I am currently bisecting, but once that finishes I will give this a
try, thank you!

							Thanx, Paul

> > > Either way, it looks like I need to upgrade the torture.sh script's
> > > checks for failed builds.  Thank you for reporting this!
> >
> > Does this make torture.sh more reliably report build failures?
> I studied this commit line by line several times and benefited a lot. Thank you!
> >
> >                                                 Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jan 18 15:40:49 2022 -0800
> >
> >     torture: Make kvm-find-errors.sh notice missing vmlinux file
> >
> >     Currently, an obtuse compiler diagnostic can fool kvm-find-errors.sh
> >     into believing that the build was successful.  This commit therefore
> >     adds a check for a missing vmlinux file.
> >
> >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de/
> >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > @@ -30,10 +30,15 @@ editor=${EDITOR-vi}
> >  files=
> >  for i in ${rundir}/*/Make.out
> >  do
> > +       scenariodir="`dirname $i`"
> >         if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
> >         then
> >                 egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
> >                 files="$files $i.diags $i"
> > +       elif ! test -f ${scenariodir}/vmlinux
> > +       then
> > +               echo No ${scenariodir}/vmlinux file > $i.diags
> > +               files="$files $i.diags $i"
> >         fi
> >  done
> >  if test -n "$files"
> Thanks
> Zhouyi
