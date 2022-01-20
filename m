Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D924955C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 22:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377745AbiATVGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 16:06:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50282 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiATVGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 16:06:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD6FB81E59;
        Thu, 20 Jan 2022 21:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1258DC340E0;
        Thu, 20 Jan 2022 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642712797;
        bh=S9QnDhcgdyuPZyPA8X/jn7u7JAnGBTg9Yxm2/sK9Nlg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=npEotK2Uq41vIQFgwRUxSIun0qx3U8zC+2bXqFKmLY0iZ0VQFe68BPvD3YXXHt9kK
         SaXq1lfPxdLNVIEcs5D1LBxpCTYHIgDofF6bmOduZ2p0etVtrA6XjXY0oP7ANDTN8F
         YQy/YfOoSfd0VtgFPSNuJm25XUWcGZ/eI4pya+3VCUHNGEcm7yICYpokPQbmd+3MAC
         Yseo2cfGmJ5cz1XjpTYMUIRfsgj0fZ945Okr/wNR5wUBl5fIPEKoZ4HEF4jbMjuFoS
         uu9PKQn0DZikp2p/p+qMaGmehpnzvjQPbUH+DiSZTWgyTRaxe+nmsQmXKCoZjICYf8
         FF/U3gIJs3KQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C68835C0367; Thu, 20 Jan 2022 13:06:36 -0800 (PST)
Date:   Thu, 20 Jan 2022 13:06:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Message-ID: <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
 <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1>
 <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 20, 2022 at 03:30:54AM +0800, Zhouyi Zhou wrote:
> On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wrote:
> > > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> > > > Thanks Paul for looking into this
> > > >
> > > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wrote:
> > > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> > > > > > > Dear Zhouyi,
> > > > > > >
> > > > > > >
> > > > > > > Thank you for your quick response.
> > > > > > >
> > > > > > >
> > > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > > >
> > > > > > > > I have studied the rcu torture test recently. I am also interested in
> > > > > > > > this topic.
> > > > > > > > But I can't open
> > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
> > > > > > >
> > > > > > > Sorry, about that. I should have checked those. I had put them into a
> > > > > > > directory:
> > > > > > >
> > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
> > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt
> > > > > > >
> > > > > > > I am going to try to test your suggestions at the end of the day.
> > > > > >
> > > > > > On x86 rcutorture builds successfully.  However, allmodconfig
> > > > > > on semi-recent -next got me "Can't open perl script
> > > > > > "./usr/include/headers_check.pl": No such file or directory".
> > > > > > Which might well be a local problem or might well be fixed by now.
> > > > >
> > > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > > I can do allmodconfig on -next,
> > > > $git describe
> > > > next-20220118
> > > > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > > $ ps -aux|grep qemu-system
> > > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55  31:27
> > > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none -machine
> > > > q35,accel=kvm -cpu kvm64 -serial
> > > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > > -append debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug
> > > > console=ttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=1
> > > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000
> > > > rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> > > > rcutree.gp_preinit_delay=12 rcutree.gp_init_delay=3
> > > > rcutree.gp_cleanup_delay=3 rcutree.kthread_prio=2 threadirqs
> > > > tree.use_softirq=0 rcutorture.n_barrier_cbs=4
> > > > rcutorture.stat_interval=15 rcutorture.shutdown_secs=420
> > > > rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
> > > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59   0:00
> > > > grep --color=auto qemu-system
> > > > $ ls -l vmlinux
> > > > -rwxrwxr-x 1 zzy zzy 69349872 1月  19 09:55 vmlinux
> > > >
> > > > Could you please try the following command ?
> > > > linux-next$ perl ./usr/include/headers_check.pl usr/include x86
> > > > usr/include/rdma/hfi/hfi1_user.h
> > > > linux-next$ echo $?
> > > > 0
> > > > The headers_check.pl in linux-next
> > > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/usr/include/headers_check.pl)
> > > > is used to check the validity of head files in ./usr/include
> > >
> > > I am currently bisecting, but once that finishes I will give this a
> > > try, thank you!
> >
> > And the bisection converged badly due to there being more than one build
> > failure.
> Sorry to hear the bisection is not successful.
> >
> > So I ran the command above and then the build succeeded.
> I'm very happy that the command works.
> >
> > Though it would be good if the build worked from "make distclean"...
> I would be very honored if I could join the efforts to make the -next better.

One approach would be to download the -next kernels as they appear and
run tests on them.  Reporting bugs is good, and of course fixing them
even better.

You can clone -next from here:

	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Individual -next releases are tagged, for example, "next-20220118".

Me, I run torture.sh on them from time to time, depending on how much
other testing I am doing.  So maybe once or twice a week.  ;-)

						Thanx, Paul

> Many thanks
> Zhouyi
> >
> >                                                         Thanx, Paul
> >
> > > > > > Either way, it looks like I need to upgrade the torture.sh script's
> > > > > > checks for failed builds.  Thank you for reporting this!
> > > > >
> > > > > Does this make torture.sh more reliably report build failures?
> > > > I studied this commit line by line several times and benefited a lot. Thank you!
> > > > >
> > > > >                                                 Thanx, Paul
> > > > >
> > > > > ------------------------------------------------------------------------
> > > > >
> > > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > > >
> > > > >     torture: Make kvm-find-errors.sh notice missing vmlinux file
> > > > >
> > > > >     Currently, an obtuse compiler diagnostic can fool kvm-find-errors.sh
> > > > >     into believing that the build was successful.  This commit therefore
> > > > >     adds a check for a missing vmlinux file.
> > > > >
> > > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de/
> > > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > >
> > > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > @@ -30,10 +30,15 @@ editor=${EDITOR-vi}
> > > > >  files=
> > > > >  for i in ${rundir}/*/Make.out
> > > > >  do
> > > > > +       scenariodir="`dirname $i`"
> > > > >         if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
> > > > >         then
> > > > >                 egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
> > > > >                 files="$files $i.diags $i"
> > > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > > +       then
> > > > > +               echo No ${scenariodir}/vmlinux file > $i.diags
> > > > > +               files="$files $i.diags $i"
> > > > >         fi
> > > > >  done
> > > > >  if test -n "$files"
> > > > Thanks
> > > > Zhouyi
