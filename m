Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0388749C0F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 02:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiAZB7w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 20:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiAZB7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 20:59:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5BC06161C;
        Tue, 25 Jan 2022 17:59:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u18so52231554edt.6;
        Tue, 25 Jan 2022 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7hJjtvNASRFLxoeYOzZBp+osaqL3whhxo0R5dd+2Po=;
        b=qWJ3dlraZZZZKWwdynj/Z8dMyQqrXGPccwct9B5ugsReSyhJDEF1R21LfyXKpzI1o8
         59QYHThcQ6GkiXmak2RbaFozBF+W29b5LRNce0J83c87qIcfMvNl1fpH9iH7VJtLwVGb
         7PwyW8QbtulcOtNmzHDjkuFhpaLoO/sZQhUjGfzykwHKjKrbPRSF92ZMWSIBq32w8S5y
         Oh3qvDVoXRNDWJD+igEg+Gzj/XszV1Vk/Ed3R2JbwrQVZYosnjfvLt1gO/oRs1wem5FN
         wsaOuIH3/Y+vaqexB4SceJtrOPXkl2+GC7eyLPZ/pd30eqQB3/d5zcxvwR7rwIZm+0ro
         peLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7hJjtvNASRFLxoeYOzZBp+osaqL3whhxo0R5dd+2Po=;
        b=oUGwhxLsAuxVDp2tziv8RETAW8z2UdR8bMxxHXdiIkdRfIv45LHPsQw+rdHcpQVFir
         Wjf4mhjIJuStu4kJvwCDZ9K4XKUkacCw7NDWQPtL8NF/6ZTzWPT8AiM2VNrGRytE2R80
         1MVOhA6yzyiIwWkVvHO7w2/dqmYdzOaobEpFIPSD6utDcuPARB8/0gJxm+EDwGD/i6rt
         z46le0mX/HMGabl4B8drrb4vsh3OOgi/84+OTZrRtGCyNzCz0xzPFOLOqxUbmrOKlqRc
         u/IIXFJdQGP8zJU6tpeeawxbkDq6FMMx6wOKutxDMqSmAe/eVRXKcpwrVVlmZCDMsnvc
         UBFQ==
X-Gm-Message-State: AOAM533TpvemLGlDATVHuWnQvE5uUx+WOp19joGPUdbj2L4UC5aerPbu
        YL7i9ojnGCL4zmgREqnlNpvgZyyL832nd7v6VvQm9Z3dv63EIA==
X-Google-Smtp-Source: ABdhPJzT1rpmfKi6ut849uVmvRAwzqMtjP7wdhUzXMFbY/iMYnh2Tm3HDul7oV1XgNvAl9dQTh/3gftRqig8iT/wyX0=
X-Received: by 2002:aa7:c989:: with SMTP id c9mr22618647edt.285.1643162389635;
 Tue, 25 Jan 2022 17:59:49 -0800 (PST)
MIME-Version: 1.0
References: <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
 <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1> <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1> <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
 <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com> <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 26 Jan 2022 09:59:32 +0800
Message-ID: <CAABZP2xGZ__8MZWL0kGAdYJ9ZNq2omw9-VTACmrG8wR8RswG2A@mail.gmail.com>
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

Thank Paul for your attention

On Wed, Jan 26, 2022 at 2:09 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Wed, Jan 26, 2022 at 12:19:58AM +0800, Zhouyi Zhou wrote:
> > Hi Paul
> >
> > On Fri, Jan 21, 2022 at 8:44 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrot=
e:
> > >
> > > Thank Paul for your guidance!
> > >
> > > On Fri, Jan 21, 2022 at 5:06 AM Paul E. McKenney <paulmck@kernel.org>=
 wrote:
> > > >
> > > > On Thu, Jan 20, 2022 at 03:30:54AM +0800, Zhouyi Zhou wrote:
> > > > > On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> > > > > >
> > > > > > On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wrot=
e:
> > > > > > > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> > > > > > > > Thanks Paul for looking into this
> > > > > > > >
> > > > > > > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenne=
y wrote:
> > > > > > > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel w=
rote:
> > > > > > > > > > > Dear Zhouyi,
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thank you for your quick response.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > > > > > > >
> > > > > > > > > > > > I have studied the rcu torture test recently. I am =
also interested in
> > > > > > > > > > > > this topic.
> > > > > > > > > > > > But I can't open
> > > > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf=
-Make.out.txt
> > > > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture=
-log.txt
> > > > > > > > > > >
> > > > > > > > > > > Sorry, about that. I should have checked those. I had=
 put them into a
> > > > > > > > > > > directory:
> > > > > > > > > > >
> > > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/a=
llmodconf-Make.out.txt
> > > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/r=
cutorture-log.txt
> > > > > > > > > > >
> > > > > > > > > > > I am going to try to test your suggestions at the end=
 of the day.
> > > > > > > > > >
> > > > > > > > > > On x86 rcutorture builds successfully.  However, allmod=
config
> > > > > > > > > > on semi-recent -next got me "Can't open perl script
> > > > > > > > > > "./usr/include/headers_check.pl": No such file or direc=
tory".
> > > > > > > > > > Which might well be a local problem or might well be fi=
xed by now.
> > > > > > > > >
> > > > > > > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > > > > > > I can do allmodconfig on -next,
> > > > > > > > $git describe
> > > > > > > > next-20220118
> > > > > > > > $tools/testing/selftests/rcutorture/bin/torture.sh --durati=
on 10
> > > > > > > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh --d=
uration 10
> > > > > > > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > > > > > > $ ps -aux|grep qemu-system
> > > > > > > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55=
  31:27
> > > > > > > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none=
 -machine
> > > > > > > > q35,accel=3Dkvm -cpu kvm64 -serial
> > > > > > > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/res=
/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > > > > > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcut=
orture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > > > > > > -append debug_boot_weak_hash panic=3D-1 selinux=3D0 initcal=
l_debug debug
> > > > > > > > console=3DttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=3D1
> > > > > > > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeo=
ut=3D30000
> > > > > > > > rcutorture.onoff_interval=3D200 rcutorture.onoff_holdoff=3D=
30
> > > > > > > > rcutree.gp_preinit_delay=3D12 rcutree.gp_init_delay=3D3
> > > > > > > > rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 threa=
dirqs
> > > > > > > > tree.use_softirq=3D0 rcutorture.n_barrier_cbs=3D4
> > > > > > > > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D42=
0
> > > > > > > > rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1
> > > > > > > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59=
   0:00
> > > > > > > > grep --color=3Dauto qemu-system
> > > > > > > > $ ls -l vmlinux
> > > > > > > > -rwxrwxr-x 1 zzy zzy 69349872 1=E6=9C=88  19 09:55 vmlinux
> > > > > > > >
> > > > > > > > Could you please try the following command ?
> > > > > > > > linux-next$ perl ./usr/include/headers_check.pl usr/include=
 x86
> > > > > > > > usr/include/rdma/hfi/hfi1_user.h
> > > > > > > > linux-next$ echo $?
> > > > > > > > 0
> > > > > > > > The headers_check.pl in linux-next
> > > > > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux=
-next.git/tree/usr/include/headers_check.pl)
> > > > > > > > is used to check the validity of head files in ./usr/includ=
e
> > > > > > >
> > > > > > > I am currently bisecting, but once that finishes I will give =
this a
> > > > > > > try, thank you!
> > > > > >
> > > > > > And the bisection converged badly due to there being more than =
one build
> > > > > > failure.
> > > > > Sorry to hear the bisection is not successful.
> > > > > >
> > > > > > So I ran the command above and then the build succeeded.
> > > > > I'm very happy that the command works.
> > > > > >
> > > > > > Though it would be good if the build worked from "make distclea=
n"...
> > > > > I would be very honored if I could join the efforts to make the -=
next better.linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23=
.10.36-torture/allmodconfig
> > > >
> > > > One approach would be to download the -next kernels as they appear =
and
> > > > run tests on them.  Reporting bugs is good, and of course fixing th=
em
> > > > even better.
> > > This provides a nice way of participating the efforts to make -next
> > > better, and provides me a good way to learn new knowledge in -next!
> > >
> > > >
> > > > You can clone -next from here:
> > > >
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
> > > >
> > > > Individual -next releases are tagged, for example, "next-20220118".
> > > I will clone -next from the tree, and will download the -next release=
s from
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > I cloned -next, and try to test rcu:
> > $git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git=
/next/linux-next.git
> > (kernel.source.codeaurora.cn is Chinese mirror of  git.kernel.org)
> > $cd linux-next
> > $git describe
> > next-20220125
> > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > $cd linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23.10.=
36-torture/allmodconfig
> > $cat Make.exitcode
> > 2
> > $grep Stop Make.out
> > make[2]: *** No rule to make target
> > 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/sel=
ftests/rcutorture/kvm_main.o',
> > needed by 'arch/x86/kvm/kvm.o'.  Stop.
> > I tried the above two times in two different machines today, they all f=
ailed.
> >
> >
> > Meanwhile I can config and build the kernel successfully by invoking
> > the build commands by hand:
> > $git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git=
/next/linux-next.git
> > $cd linux-next
> > $git describe
> > next-20220125
>
> Huh.  What happens if you do a "make clean" betweentimes?
do a "make clean" between times also fails, sorry
>
> Alternatively, what happens if you change these two lines from torture.sh=
:
>
>         echo " --- make clean" > "$amcdir/Make.out" 2>&1
>         make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
>
> To this:
>
>         echo " --- make distclean" > "$amcdir/Make.out" 2>&1
>         make -j$MAKE_ALLOTED_CPUS distclean >> "$amcdir/Make.out" 2>&1
>
> And then run torture.sh in the same way that got you the error?
I do above, and also fails:
$git diff
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh
b/tools/testing/selftests/rcutorture/bin/torture.sh
index d1cb60085d8f..8ece2f0a51c7 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -319,8 +319,8 @@ then
        echo " --- allmodconfig:" Start `date` | tee -a $T/log
        amcdir=3D"tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
        mkdir -p "$amcdir"
-       echo " --- make clean" > "$amcdir/Make.out" 2>&1
-       make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
+       echo " --- make distclean" > "$amcdir/Make.out" 2>&1
+       make -j$MAKE_ALLOTED_CPUS distclean >> "$amcdir/Make.out" 2>&1
        echo " --- make allmodconfig" >> "$amcdir/Make.out" 2>&1
        make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
        echo " --- make " >> "$amcdir/Make.out" 2>&1
$tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
$grep kvm.o ./tools/testing/selftests/rcutorture/res/2022.01.26-09.08.53-to=
rture/allmodconfig/Make.out
make[2]: *** No rule to make target
'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftes=
ts/rcutorture/kvm_main.o',
needed by 'arch/x86/kvm/kvm.o'.  Stop.

I am very interested in this problem, and am willing to track this
problem with other developers in the coming days ;-)

Thanks
Zhouyi
>
>                                                         Thanx, Paul
>
> > $make allmodconfig
> > $make -j 16
> > Kernel: arch/x86/boot/bzImage is ready  (#2)
> >   GEN     Module.symvers
> > $echo $?
> > 0
> >
> > I am very interested in this problem and I am eager to try to dig out
> > what happened and fix it before this Sunday. And it is more delightful
> > to me that other developers can solve this problem because they are
> > more mature than me ;-)
> >
> > Many thanks
> > Zhouyi
> > > >
> > > > Me, I run torture.sh on them from time to time, depending on how mu=
ch
> > > > other testing I am doing.  So maybe once or twice a week.  ;-)
> > > You are the example worth learning in my life, to be honest , I will
> > > do the same way as you do!
> > >
> > > Sincerely
> > > Zhouyi
> > > >
> > > >                                                 Thanx, Paul
> > > >
> > > > > Many thanks
> > > > > Zhouyi
> > > > > >
> > > > > >                                                         Thanx, =
Paul
> > > > > >
> > > > > > > > > > Either way, it looks like I need to upgrade the torture=
.sh script's
> > > > > > > > > > checks for failed builds.  Thank you for reporting this=
!
> > > > > > > > >
> > > > > > > > > Does this make torture.sh more reliably report build fail=
ures?
> > > > > > > > I studied this commit line by line several times and benefi=
ted a lot. Thank you!
> > > > > > > > >
> > > > > > > > >                                                 Thanx, Pa=
ul
> > > > > > > > >
> > > > > > > > > ---------------------------------------------------------=
---------------
> > > > > > > > >
> > > > > > > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > > > > > > >
> > > > > > > > >     torture: Make kvm-find-errors.sh notice missing vmlin=
ux file
> > > > > > > > >
> > > > > > > > >     Currently, an obtuse compiler diagnostic can fool kvm=
-find-errors.sh
> > > > > > > > >     into believing that the build was successful.  This c=
ommit therefore
> > > > > > > > >     adds a check for a missing vmlinux file.
> > > > > > > > >
> > > > > > > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677=
-7fde-40295932a640@molgen.mpg.de/
> > > > > > > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > >
> > > > > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-f=
ind-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > > > > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-err=
ors.sh
> > > > > > > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-err=
ors.sh
> > > > > > > > > @@ -30,10 +30,15 @@ editor=3D${EDITOR-vi}
> > > > > > > > >  files=3D
> > > > > > > > >  for i in ${rundir}/*/Make.out
> > > > > > > > >  do
> > > > > > > > > +       scenariodir=3D"`dirname $i`"
> > > > > > > > >         if egrep -q "error:|warning:|^ld: .*undefined ref=
erence to" < $i
> > > > > > > > >         then
> > > > > > > > >                 egrep "error:|warning:|^ld: .*undefined r=
eference to" < $i > $i.diags
> > > > > > > > >                 files=3D"$files $i.diags $i"
> > > > > > > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > > > > > > +       then
> > > > > > > > > +               echo No ${scenariodir}/vmlinux file > $i.=
diags
> > > > > > > > > +               files=3D"$files $i.diags $i"
> > > > > > > > >         fi
> > > > > > > > >  done
> > > > > > > > >  if test -n "$files"
> > > > > > > > Thanks
> > > > > > > > Zhouyi
