Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC449B881
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352321AbiAYQVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 11:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583619AbiAYQUN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 11:20:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A6C06173E;
        Tue, 25 Jan 2022 08:20:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ka4so31515630ejc.11;
        Tue, 25 Jan 2022 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I21zLtkJJw74Rgbkqsfor3YfqbdAOO68wYYb+2dGeFg=;
        b=N0qsnWvr/3yli/h2Wjp2mBD9QjbB/VGNjDTjlQa1IEYxSW80xcjLsovAGHNAOFxpnc
         kiwueyeItHUCy8/OVC+F2XLDqXPb/WQa4xIblg03wopl/N6Lz6Chv4R9UOyhj4lTzXrG
         US3BX2iOoCAsKhNsTTe90XAjhinxvrnSmbjVDvNwmtRJ8X1OMcQ9IxhJ0r7e62LAgaa5
         QRcezNJsG/uDS7jsuASAxWVjH+Cfsf2Uf6Iy9hnYgVD1OJPVvjPlU1f9xh6pWnQvU/h8
         S1X2jlgbC3Q/dlQv6XkvRYWswSdMcM83zuJZLVRezbrSItTKxB/zQ5E1yz35iSGfHprK
         f65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I21zLtkJJw74Rgbkqsfor3YfqbdAOO68wYYb+2dGeFg=;
        b=Rg+YEkHQv6v7wTDX96oUCLCuZ3kJi70k4OfHKHM5tPByDUFi9ssPWjuU0Ojm5mwV+A
         oPXNHY6c5NZ2hGwK50Q1UOZEuseFtD6zL/cN8sZFH5kf6MJbC1l6/A5PNNznVtPnu/Ly
         6lhLuM6uMMHpcBZ0xIAC5oAaxx3NT5yAIqK3ezGOCx6zW8c5hc3TMLd4BL5yOO5DE53v
         sTrjtkdskO5td3ZEx3ET74ksPSH/kW21EzJAJ6o6E9FSbSZZa+en8vgwLu4MfDw1+V8P
         uf57IhAizbjd1f33nlSbQo9jn3auY4F7QrvZVtOu73GaoTNsH1gpvDDhvb+JYDoNJA4X
         DbrA==
X-Gm-Message-State: AOAM532/8Z9wahzdBDi0pwlIfLL9d3z18XkPXNH8KU/8qVg4UU5F4a6d
        ABSKuxNC2C78iJd+kCkzjEdmEnEKHnGvY8nXqex88jFR1OY/NQ==
X-Google-Smtp-Source: ABdhPJwUffwjdoQhViu2SIO4FwYR+i7PnTdQ/SBE8D73puWpQJLyJRwOFv2nnoil7i56EyZYN/uZSlyjZEFRhG15nk4=
X-Received: by 2002:a17:906:ce55:: with SMTP id se21mr2074388ejb.545.1643127610541;
 Tue, 25 Jan 2022 08:20:10 -0800 (PST)
MIME-Version: 1.0
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de> <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1> <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1> <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
In-Reply-To: <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 26 Jan 2022 00:19:58 +0800
Message-ID: <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other failures
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul

On Fri, Jan 21, 2022 at 8:44 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Thank Paul for your guidance!
>
> On Fri, Jan 21, 2022 at 5:06 AM Paul E. McKenney <paulmck@kernel.org> wro=
te:
> >
> > On Thu, Jan 20, 2022 at 03:30:54AM +0800, Zhouyi Zhou wrote:
> > > On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org>=
 wrote:
> > > >
> > > > On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> > > > > > Thanks Paul for looking into this
> > > > > >
> > > > > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wr=
ote:
> > > > > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote=
:
> > > > > > > > > Dear Zhouyi,
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thank you for your quick response.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > > > > >
> > > > > > > > > > I have studied the rcu torture test recently. I am also=
 interested in
> > > > > > > > > > this topic.
> > > > > > > > > > But I can't open
> > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Mak=
e.out.txt
> > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log=
.txt
> > > > > > > > >
> > > > > > > > > Sorry, about that. I should have checked those. I had put=
 them into a
> > > > > > > > > directory:
> > > > > > > > >
> > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmo=
dconf-Make.out.txt
> > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcuto=
rture-log.txt
> > > > > > > > >
> > > > > > > > > I am going to try to test your suggestions at the end of =
the day.
> > > > > > > >
> > > > > > > > On x86 rcutorture builds successfully.  However, allmodconf=
ig
> > > > > > > > on semi-recent -next got me "Can't open perl script
> > > > > > > > "./usr/include/headers_check.pl": No such file or directory=
".
> > > > > > > > Which might well be a local problem or might well be fixed =
by now.
> > > > > > >
> > > > > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > > > > I can do allmodconfig on -next,
> > > > > > $git describe
> > > > > > next-20220118
> > > > > > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 1=
0
> > > > > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh --durat=
ion 10
> > > > > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > > > > $ ps -aux|grep qemu-system
> > > > > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55  31=
:27
> > > > > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none -ma=
chine
> > > > > > q35,accel=3Dkvm -cpu kvm64 -serial
> > > > > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/res/202=
2.01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > > > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcutortu=
re/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > > > > -append debug_boot_weak_hash panic=3D-1 selinux=3D0 initcall_de=
bug debug
> > > > > > console=3DttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=3D1
> > > > > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=
=3D30000
> > > > > > rcutorture.onoff_interval=3D200 rcutorture.onoff_holdoff=3D30
> > > > > > rcutree.gp_preinit_delay=3D12 rcutree.gp_init_delay=3D3
> > > > > > rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 threadirq=
s
> > > > > > tree.use_softirq=3D0 rcutorture.n_barrier_cbs=3D4
> > > > > > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D420
> > > > > > rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1
> > > > > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59   0=
:00
> > > > > > grep --color=3Dauto qemu-system
> > > > > > $ ls -l vmlinux
> > > > > > -rwxrwxr-x 1 zzy zzy 69349872 1=E6=9C=88  19 09:55 vmlinux
> > > > > >
> > > > > > Could you please try the following command ?
> > > > > > linux-next$ perl ./usr/include/headers_check.pl usr/include x86
> > > > > > usr/include/rdma/hfi/hfi1_user.h
> > > > > > linux-next$ echo $?
> > > > > > 0
> > > > > > The headers_check.pl in linux-next
> > > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git/tree/usr/include/headers_check.pl)
> > > > > > is used to check the validity of head files in ./usr/include
> > > > >
> > > > > I am currently bisecting, but once that finishes I will give this=
 a
> > > > > try, thank you!
> > > >
> > > > And the bisection converged badly due to there being more than one =
build
> > > > failure.
> > > Sorry to hear the bisection is not successful.
> > > >
> > > > So I ran the command above and then the build succeeded.
> > > I'm very happy that the command works.
> > > >
> > > > Though it would be good if the build worked from "make distclean"..=
.
> > > I would be very honored if I could join the efforts to make the -next=
 better.linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23.10.=
36-torture/allmodconfig
> >
> > One approach would be to download the -next kernels as they appear and
> > run tests on them.  Reporting bugs is good, and of course fixing them
> > even better.
> This provides a nice way of participating the efforts to make -next
> better, and provides me a good way to learn new knowledge in -next!
>
> >
> > You can clone -next from here:
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it
> >
> > Individual -next releases are tagged, for example, "next-20220118".
> I will clone -next from the tree, and will download the -next releases fr=
om
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
I cloned -next, and try to test rcu:
$git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/nex=
t/linux-next.git
(kernel.source.codeaurora.cn is Chinese mirror of  git.kernel.org)
$cd linux-next
$git describe
next-20220125
$tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
$cd linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23.10.36-t=
orture/allmodconfig
$cat Make.exitcode
2
$grep Stop Make.out
make[2]: *** No rule to make target
'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftes=
ts/rcutorture/kvm_main.o',
needed by 'arch/x86/kvm/kvm.o'.  Stop.
I tried the above two times in two different machines today, they all faile=
d.


Meanwhile I can config and build the kernel successfully by invoking
the build commands by hand:
$git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/nex=
t/linux-next.git
$cd linux-next
$git describe
next-20220125
$make allmodconfig
$make -j 16
Kernel: arch/x86/boot/bzImage is ready  (#2)
  GEN     Module.symvers
$echo $?
0

I am very interested in this problem and I am eager to try to dig out
what happened and fix it before this Sunday. And it is more delightful
to me that other developers can solve this problem because they are
more mature than me ;-)

Many thanks
Zhouyi
> >
> > Me, I run torture.sh on them from time to time, depending on how much
> > other testing I am doing.  So maybe once or twice a week.  ;-)
> You are the example worth learning in my life, to be honest , I will
> do the same way as you do!
>
> Sincerely
> Zhouyi
> >
> >                                                 Thanx, Paul
> >
> > > Many thanks
> > > Zhouyi
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > > > > Either way, it looks like I need to upgrade the torture.sh =
script's
> > > > > > > > checks for failed builds.  Thank you for reporting this!
> > > > > > >
> > > > > > > Does this make torture.sh more reliably report build failures=
?
> > > > > > I studied this commit line by line several times and benefited =
a lot. Thank you!
> > > > > > >
> > > > > > >                                                 Thanx, Paul
> > > > > > >
> > > > > > > -------------------------------------------------------------=
-----------
> > > > > > >
> > > > > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > > > > >
> > > > > > >     torture: Make kvm-find-errors.sh notice missing vmlinux f=
ile
> > > > > > >
> > > > > > >     Currently, an obtuse compiler diagnostic can fool kvm-fin=
d-errors.sh
> > > > > > >     into believing that the build was successful.  This commi=
t therefore
> > > > > > >     adds a check for a missing vmlinux file.
> > > > > > >
> > > > > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fd=
e-40295932a640@molgen.mpg.de/
> > > > > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > >
> > > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-=
errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.=
sh
> > > > > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.=
sh
> > > > > > > @@ -30,10 +30,15 @@ editor=3D${EDITOR-vi}
> > > > > > >  files=3D
> > > > > > >  for i in ${rundir}/*/Make.out
> > > > > > >  do
> > > > > > > +       scenariodir=3D"`dirname $i`"
> > > > > > >         if egrep -q "error:|warning:|^ld: .*undefined referen=
ce to" < $i
> > > > > > >         then
> > > > > > >                 egrep "error:|warning:|^ld: .*undefined refer=
ence to" < $i > $i.diags
> > > > > > >                 files=3D"$files $i.diags $i"
> > > > > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > > > > +       then
> > > > > > > +               echo No ${scenariodir}/vmlinux file > $i.diag=
s
> > > > > > > +               files=3D"$files $i.diags $i"
> > > > > > >         fi
> > > > > > >  done
> > > > > > >  if test -n "$files"
> > > > > > Thanks
> > > > > > Zhouyi
