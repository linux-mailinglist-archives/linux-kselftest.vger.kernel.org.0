Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7349C281
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiAZEJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 23:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiAZEJ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 23:09:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A56C06161C;
        Tue, 25 Jan 2022 20:09:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me13so35870267ejb.12;
        Tue, 25 Jan 2022 20:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hHAtSdar2cVZQNNWR/+WuO6cKLrdUGYT57vYaceB/3Y=;
        b=YGvIZ7nupSmOaDUCl0iuavbufacV+kHQ4K6eren+/uyqjSgT+srVFrs0r2/lw6GM7H
         z5pd/b7+AfOYkt0j70n4S5ygsxgQPRO8kx9uezqZGRIYJ0eq9L8r7WXIrvaN4q/CvB1g
         gDczqLo8eD43z5ZzaPpmwf9KOhL8htMZW6fIV/3HK4Z80fyGyMVCXn5ZsMRrdDT42uZE
         /JoTib9otBeiMsbPOSaxcoW/cJlz063+V8P+VO/K4EfTjli52po0lQYADNog5QJY2Pf9
         1qVzEOeehhIjEdXNseBa5kz3MTR/tzq1zz2/YUVgEnA5xYALnhwJRxrwC4ciwPAM0JsK
         hnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hHAtSdar2cVZQNNWR/+WuO6cKLrdUGYT57vYaceB/3Y=;
        b=Rzo72bjSXu51+mHrhl3/s5eIKpdO5gnLyLIaMjeqF2rDLWICKrqVYODA/7+uVagD+w
         t8SEfEIB2ZBmWQORFUVkWmqveEbWAv2Sk//BmnKtG1VIjCB2sLiNuiex3P+D46KFCwlf
         jVNZm5z/zpPihMS6BCiJQzf49mJdC5K/CLX+t2FbnPjBS0fa0I2cuggYzXKizJr+A4om
         B2KRt0BfAY/vlvyCVM4ESXNyD5h3sN2DTT4VUlTiVsgIvIAerKny3YUI81czHAqAmRhX
         ZugfrG7up8ZIVZgAjB/tCruQxgzJMMf/F+lFRyXsZCVVbZylxLxRB17EirJS91IM3Twb
         rDqg==
X-Gm-Message-State: AOAM531AiFn/wMdiREYqaB5CSUUGU4Gdf5gnW/xTtKCHn6HhkhtKrvO4
        fhkGd46mEDaxGqnDo/iEWDA/Hw0I2Hf29RVtFY2z+dAX8lXJ/g==
X-Google-Smtp-Source: ABdhPJzAP2+dWkvGk2rAyRXrkHF7nLoYw0ej2alfgMQk3iHWGiOtn+bMoxbskBN7ZD2bx8Pd8f9olQZT2+muktBjfZQ=
X-Received: by 2002:a17:906:99c3:: with SMTP id s3mr18956353ejn.486.1643170164021;
 Tue, 25 Jan 2022 20:09:24 -0800 (PST)
MIME-Version: 1.0
References: <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
 <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1> <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1> <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
 <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
 <CAABZP2z=ESWA1EYf1LGS40ipJxcVOAUkvJHA-rdDP6_0Oqjgsg@mail.gmail.com>
 <20220125180907.GN4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2xGZ__8MZWL0kGAdYJ9ZNq2omw9-VTACmrG8wR8RswG2A@mail.gmail.com>
In-Reply-To: <CAABZP2xGZ__8MZWL0kGAdYJ9ZNq2omw9-VTACmrG8wR8RswG2A@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 26 Jan 2022 12:09:12 +0800
Message-ID: <CAABZP2wt03juddoKfxO0m=+kn407267jLJn+gPRzU-w3nUBkAQ@mail.gmail.com>
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

Great Discovery !!
Hi Paul,
I track the log
make[2]: *** No rule to make target
'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selftes=
ts/rcutorture/kvm_main.o',
needed by 'arch/x86/kvm/kvm.o
into the file virt/kvm/Makefile.kvm:
1# SPDX-License-Identifier: GPL-2.0
 2#
 3# Makefile for Kernel-based Virtual Machine module
 4#
 5
 6KVM ?=3D ../../../virt/kvm
 7
 8kvm-y :=3D $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
 9kvm-$(CONFIG_KVM_VFIO) +=3D $(KVM)/vfio.o
10kvm-$(CONFIG_KVM_MMIO) +=3D $(KVM)/coalesced_mmio.o
11kvm-$(CONFIG_KVM_ASYNC_PF) +=3D $(KVM)/async_pf.o
12kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) +=3D $(KVM)/irqchip.o
13kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) +=3D $(KVM)/dirty_ring.o
14kvm-$(CONFIG_HAVE_KVM_PFNCACHE) +=3D $(KVM)/pfncache.o
line 6's ?=3D indicates to set the KDIR variable only if it's not
set/doesn't have a value.

I guess we have set the variable KVM somewhere before make, I will
continue tracking it.

Thanks
Zhouyi






On Wed, Jan 26, 2022 at 9:59 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Thank Paul for your attention
>
> On Wed, Jan 26, 2022 at 2:09 AM Paul E. McKenney <paulmck@kernel.org> wro=
te:
> >
> > On Wed, Jan 26, 2022 at 12:19:58AM +0800, Zhouyi Zhou wrote:
> > > Hi Paul
> > >
> > > On Fri, Jan 21, 2022 at 8:44 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wr=
ote:
> > > >
> > > > Thank Paul for your guidance!
> > > >
> > > > On Fri, Jan 21, 2022 at 5:06 AM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > > > >
> > > > > On Thu, Jan 20, 2022 at 03:30:54AM +0800, Zhouyi Zhou wrote:
> > > > > > On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wr=
ote:
> > > > > > > > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote=
:
> > > > > > > > > Thanks Paul for looking into this
> > > > > > > > >
> > > > > > > > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck=
@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKen=
ney wrote:
> > > > > > > > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel=
 wrote:
> > > > > > > > > > > > Dear Zhouyi,
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Thank you for your quick response.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > > > > > > > >
> > > > > > > > > > > > > I have studied the rcu torture test recently. I a=
m also interested in
> > > > > > > > > > > > > this topic.
> > > > > > > > > > > > > But I can't open
> > > > > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodco=
nf-Make.out.txt
> > > > > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutortu=
re-log.txt
> > > > > > > > > > > >
> > > > > > > > > > > > Sorry, about that. I should have checked those. I h=
ad put them into a
> > > > > > > > > > > > directory:
> > > > > > > > > > > >
> > > > > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture=
/allmodconf-Make.out.txt
> > > > > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture=
/rcutorture-log.txt
> > > > > > > > > > > >
> > > > > > > > > > > > I am going to try to test your suggestions at the e=
nd of the day.
> > > > > > > > > > >
> > > > > > > > > > > On x86 rcutorture builds successfully.  However, allm=
odconfig
> > > > > > > > > > > on semi-recent -next got me "Can't open perl script
> > > > > > > > > > > "./usr/include/headers_check.pl": No such file or dir=
ectory".
> > > > > > > > > > > Which might well be a local problem or might well be =
fixed by now.
> > > > > > > > > >
> > > > > > > > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > > > > > > > I can do allmodconfig on -next,
> > > > > > > > > $git describe
> > > > > > > > > next-20220118
> > > > > > > > > $tools/testing/selftests/rcutorture/bin/torture.sh --dura=
tion 10
> > > > > > > > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh -=
-duration 10
> > > > > > > > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > > > > > > > $ ps -aux|grep qemu-system
> > > > > > > > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:=
55  31:27
> > > > > > > > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net no=
ne -machine
> > > > > > > > > q35,accel=3Dkvm -cpu kvm64 -serial
> > > > > > > > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/r=
es/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > > > > > > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rc=
utorture/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > > > > > > > -append debug_boot_weak_hash panic=3D-1 selinux=3D0 initc=
all_debug debug
> > > > > > > > > console=3DttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=
=3D1
> > > > > > > > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_tim=
eout=3D30000
> > > > > > > > > rcutorture.onoff_interval=3D200 rcutorture.onoff_holdoff=
=3D30
> > > > > > > > > rcutree.gp_preinit_delay=3D12 rcutree.gp_init_delay=3D3
> > > > > > > > > rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 thr=
eadirqs
> > > > > > > > > tree.use_softirq=3D0 rcutorture.n_barrier_cbs=3D4
> > > > > > > > > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D=
420
> > > > > > > > > rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1
> > > > > > > > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:=
59   0:00
> > > > > > > > > grep --color=3Dauto qemu-system
> > > > > > > > > $ ls -l vmlinux
> > > > > > > > > -rwxrwxr-x 1 zzy zzy 69349872 1=E6=9C=88  19 09:55 vmlinu=
x
> > > > > > > > >
> > > > > > > > > Could you please try the following command ?
> > > > > > > > > linux-next$ perl ./usr/include/headers_check.pl usr/inclu=
de x86
> > > > > > > > > usr/include/rdma/hfi/hfi1_user.h
> > > > > > > > > linux-next$ echo $?
> > > > > > > > > 0
> > > > > > > > > The headers_check.pl in linux-next
> > > > > > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/lin=
ux-next.git/tree/usr/include/headers_check.pl)
> > > > > > > > > is used to check the validity of head files in ./usr/incl=
ude
> > > > > > > >
> > > > > > > > I am currently bisecting, but once that finishes I will giv=
e this a
> > > > > > > > try, thank you!
> > > > > > >
> > > > > > > And the bisection converged badly due to there being more tha=
n one build
> > > > > > > failure.
> > > > > > Sorry to hear the bisection is not successful.
> > > > > > >
> > > > > > > So I ran the command above and then the build succeeded.
> > > > > > I'm very happy that the command works.
> > > > > > >
> > > > > > > Though it would be good if the build worked from "make distcl=
ean"...
> > > > > > I would be very honored if I could join the efforts to make the=
 -next better.linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-=
23.10.36-torture/allmodconfig
> > > > >
> > > > > One approach would be to download the -next kernels as they appea=
r and
> > > > > run tests on them.  Reporting bugs is good, and of course fixing =
them
> > > > > even better.
> > > > This provides a nice way of participating the efforts to make -next
> > > > better, and provides me a good way to learn new knowledge in -next!
> > > >
> > > > >
> > > > > You can clone -next from here:
> > > > >
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
> > > > >
> > > > > Individual -next releases are tagged, for example, "next-20220118=
".
> > > > I will clone -next from the tree, and will download the -next relea=
ses from
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > I cloned -next, and try to test rcu:
> > > $git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/g=
it/next/linux-next.git
> > > (kernel.source.codeaurora.cn is Chinese mirror of  git.kernel.org)
> > > $cd linux-next
> > > $git describe
> > > next-20220125
> > > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > > $cd linux-next/tools/testing/selftests/rcutorture/res/2022.01.25-23.1=
0.36-torture/allmodconfig
> > > $cat Make.exitcode
> > > 2
> > > $grep Stop Make.out
> > > make[2]: *** No rule to make target
> > > 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/s=
elftests/rcutorture/kvm_main.o',
> > > needed by 'arch/x86/kvm/kvm.o'.  Stop.
> > > I tried the above two times in two different machines today, they all=
 failed.
> > >
> > >
> > > Meanwhile I can config and build the kernel successfully by invoking
> > > the build commands by hand:
> > > $git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/g=
it/next/linux-next.git
> > > $cd linux-next
> > > $git describe
> > > next-20220125
> >
> > Huh.  What happens if you do a "make clean" betweentimes?
> do a "make clean" between times also fails, sorry
> >
> > Alternatively, what happens if you change these two lines from torture.=
sh:
> >
> >         echo " --- make clean" > "$amcdir/Make.out" 2>&1
> >         make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
> >
> > To this:
> >
> >         echo " --- make distclean" > "$amcdir/Make.out" 2>&1
> >         make -j$MAKE_ALLOTED_CPUS distclean >> "$amcdir/Make.out" 2>&1
> >
> > And then run torture.sh in the same way that got you the error?
> I do above, and also fails:
> $git diff
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh
> b/tools/testing/selftests/rcutorture/bin/torture.sh
> index d1cb60085d8f..8ece2f0a51c7 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -319,8 +319,8 @@ then
>         echo " --- allmodconfig:" Start `date` | tee -a $T/log
>         amcdir=3D"tools/testing/selftests/rcutorture/res/$ds/allmodconfig=
"
>         mkdir -p "$amcdir"
> -       echo " --- make clean" > "$amcdir/Make.out" 2>&1
> -       make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
> +       echo " --- make distclean" > "$amcdir/Make.out" 2>&1
> +       make -j$MAKE_ALLOTED_CPUS distclean >> "$amcdir/Make.out" 2>&1
>         echo " --- make allmodconfig" >> "$amcdir/Make.out" 2>&1
>         make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
>         echo " --- make " >> "$amcdir/Make.out" 2>&1
> $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> $grep kvm.o ./tools/testing/selftests/rcutorture/res/2022.01.26-09.08.53-=
torture/allmodconfig/Make.out
> make[2]: *** No rule to make target
> 'arch/x86/kvm//home/zzy/Program/linux-next/linux-next/tools/testing/selft=
ests/rcutorture/kvm_main.o',
> needed by 'arch/x86/kvm/kvm.o'.  Stop.
>
> I am very interested in this problem, and am willing to track this
> problem with other developers in the coming days ;-)
>
> Thanks
> Zhouyi
> >
> >                                                         Thanx, Paul
> >
> > > $make allmodconfig
> > > $make -j 16
> > > Kernel: arch/x86/boot/bzImage is ready  (#2)
> > >   GEN     Module.symvers
> > > $echo $?
> > > 0
> > >
> > > I am very interested in this problem and I am eager to try to dig out
> > > what happened and fix it before this Sunday. And it is more delightfu=
l
> > > to me that other developers can solve this problem because they are
> > > more mature than me ;-)
> > >
> > > Many thanks
> > > Zhouyi
> > > > >
> > > > > Me, I run torture.sh on them from time to time, depending on how =
much
> > > > > other testing I am doing.  So maybe once or twice a week.  ;-)
> > > > You are the example worth learning in my life, to be honest , I wil=
l
> > > > do the same way as you do!
> > > >
> > > > Sincerely
> > > > Zhouyi
> > > > >
> > > > >                                                 Thanx, Paul
> > > > >
> > > > > > Many thanks
> > > > > > Zhouyi
> > > > > > >
> > > > > > >                                                         Thanx=
, Paul
> > > > > > >
> > > > > > > > > > > Either way, it looks like I need to upgrade the tortu=
re.sh script's
> > > > > > > > > > > checks for failed builds.  Thank you for reporting th=
is!
> > > > > > > > > >
> > > > > > > > > > Does this make torture.sh more reliably report build fa=
ilures?
> > > > > > > > > I studied this commit line by line several times and bene=
fited a lot. Thank you!
> > > > > > > > > >
> > > > > > > > > >                                                 Thanx, =
Paul
> > > > > > > > > >
> > > > > > > > > > -------------------------------------------------------=
-----------------
> > > > > > > > > >
> > > > > > > > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > > > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > > > > > > > >
> > > > > > > > > >     torture: Make kvm-find-errors.sh notice missing vml=
inux file
> > > > > > > > > >
> > > > > > > > > >     Currently, an obtuse compiler diagnostic can fool k=
vm-find-errors.sh
> > > > > > > > > >     into believing that the build was successful.  This=
 commit therefore
> > > > > > > > > >     adds a check for a missing vmlinux file.
> > > > > > > > > >
> > > > > > > > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-56=
77-7fde-40295932a640@molgen.mpg.de/
> > > > > > > > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org=
>
> > > > > > > > > >
> > > > > > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm=
-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > > > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > > > > > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-e=
rrors.sh
> > > > > > > > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-e=
rrors.sh
> > > > > > > > > > @@ -30,10 +30,15 @@ editor=3D${EDITOR-vi}
> > > > > > > > > >  files=3D
> > > > > > > > > >  for i in ${rundir}/*/Make.out
> > > > > > > > > >  do
> > > > > > > > > > +       scenariodir=3D"`dirname $i`"
> > > > > > > > > >         if egrep -q "error:|warning:|^ld: .*undefined r=
eference to" < $i
> > > > > > > > > >         then
> > > > > > > > > >                 egrep "error:|warning:|^ld: .*undefined=
 reference to" < $i > $i.diags
> > > > > > > > > >                 files=3D"$files $i.diags $i"
> > > > > > > > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > > > > > > > +       then
> > > > > > > > > > +               echo No ${scenariodir}/vmlinux file > $=
i.diags
> > > > > > > > > > +               files=3D"$files $i.diags $i"
> > > > > > > > > >         fi
> > > > > > > > > >  done
> > > > > > > > > >  if test -n "$files"
> > > > > > > > > Thanks
> > > > > > > > > Zhouyi
