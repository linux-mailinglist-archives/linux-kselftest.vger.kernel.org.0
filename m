Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF284940E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jan 2022 20:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiASTbI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jan 2022 14:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiASTbI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jan 2022 14:31:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95331C061574;
        Wed, 19 Jan 2022 11:31:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so17985668edd.12;
        Wed, 19 Jan 2022 11:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFLkwq9ILntjoTbPnCbgmF8nw7LijTYV9rnbvr3N6yA=;
        b=ieNzRjm0dLjX15Rfz7yokFtdZHLKV7MqAJ1KmgF/W3D8xHxCX6x1Bzlu6tpq2LML0/
         /R9tD/bDCCXoqPbRBKNVCW27uC3KplsUeAYqm1fchMFn5WLxTxYHb8lx3AZN3ejXr+Er
         U0gnOkVt0/3S60l3GI4frX/HJHO0EkqeiHT3j2f4BG3+N3+n9cXWsu7WVbnwJyygs8mU
         mIH2RvvwsOCYe4y3BNlmEcr8xjmhTDwULCH3tH+nsTuHvaWKwxjjrGchwPTiquEuBZkB
         2JOhIsm7rAr9AhLh4b+4JabfEGUh9kxGaRlzRQPwG47KjMOvPTyURdF9/NiqHK4bPmBW
         NRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFLkwq9ILntjoTbPnCbgmF8nw7LijTYV9rnbvr3N6yA=;
        b=wBKxS0fkZY2BzbYF4uNC6akkr1n3YUzPdcURecNTZ5a1jEf3tA4pBuA8w3ZjWoyG47
         0/cv0RTGd9DzP1CVW2EjjujDDg2HbSj/9DuBsst08v2xST5/9U9L9hBl1PhWAoQiErcq
         kYQmLvTAN9Cb9At7dHPKMXOatS/liiO5skjQZCNVREEX7wEyK8u3Xxt/ClHILUuzWm0j
         us6/G6rEaN/5EcJil/PXSdncisgSv8LJqYhopS1g0E+XOs5r5D9A8KtqvZyuzSDINVax
         MGUNMZT1prGSpIWFCvB2jhAhOb+cexxXDVN2GEoqO3zVsCK7tKe7A+w0+iRA/sTCJApq
         wK7Q==
X-Gm-Message-State: AOAM530ZGuefONb3uVSHc2AAi9c64NI8QOViKkUl9vcZz04dWNJGC6Gc
        PgjxmlGepMLoNcmRjiyZ6lIXuRRwziIYhfGd1gV4PnfiJm0l6w==
X-Google-Smtp-Source: ABdhPJxWDztlubLb7m4pJ4Gx2ESusr3iob4fAnJguVes9BJkrJ3YpmDCF8VQWMXp4PXU3qPNKrR0uiNg+4JCHYkETZo=
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr32046635edd.129.1642620666019;
 Wed, 19 Jan 2022 11:31:06 -0800 (PST)
MIME-Version: 1.0
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de> <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1> <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1> <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 20 Jan 2022 03:30:54 +0800
Message-ID: <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com>
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

On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> > > Thanks Paul for looking into this
> > >
> > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@kernel.org>=
 wrote:
> > > >
> > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> > > > > > Dear Zhouyi,
> > > > > >
> > > > > >
> > > > > > Thank you for your quick response.
> > > > > >
> > > > > >
> > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > >
> > > > > > > I have studied the rcu torture test recently. I am also inter=
ested in
> > > > > > > this topic.
> > > > > > > But I can't open
> > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.=
txt
> > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
> > > > > >
> > > > > > Sorry, about that. I should have checked those. I had put them =
into a
> > > > > > directory:
> > > > > >
> > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-=
Make.out.txt
> > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-=
log.txt
> > > > > >
> > > > > > I am going to try to test your suggestions at the end of the da=
y.
> > > > >
> > > > > On x86 rcutorture builds successfully.  However, allmodconfig
> > > > > on semi-recent -next got me "Can't open perl script
> > > > > "./usr/include/headers_check.pl": No such file or directory".
> > > > > Which might well be a local problem or might well be fixed by now=
.
> > > >
> > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > I can do allmodconfig on -next,
> > > $git describe
> > > next-20220118
> > > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > $ ps -aux|grep qemu-system
> > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55  31:27
> > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none -machine
> > > q35,accel=3Dkvm -cpu kvm64 -serial
> > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.01.1=
9-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcutorture/res=
/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > -append debug_boot_weak_hash panic=3D-1 selinux=3D0 initcall_debug de=
bug
> > > console=3DttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=3D1
> > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=3D30000
> > > rcutorture.onoff_interval=3D200 rcutorture.onoff_holdoff=3D30
> > > rcutree.gp_preinit_delay=3D12 rcutree.gp_init_delay=3D3
> > > rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 threadirqs
> > > tree.use_softirq=3D0 rcutorture.n_barrier_cbs=3D4
> > > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D420
> > > rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1
> > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59   0:00
> > > grep --color=3Dauto qemu-system
> > > $ ls -l vmlinux
> > > -rwxrwxr-x 1 zzy zzy 69349872 1=E6=9C=88  19 09:55 vmlinux
> > >
> > > Could you please try the following command ?
> > > linux-next$ perl ./usr/include/headers_check.pl usr/include x86
> > > usr/include/rdma/hfi/hfi1_user.h
> > > linux-next$ echo $?
> > > 0
> > > The headers_check.pl in linux-next
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
tree/usr/include/headers_check.pl)
> > > is used to check the validity of head files in ./usr/include
> >
> > I am currently bisecting, but once that finishes I will give this a
> > try, thank you!
>
> And the bisection converged badly due to there being more than one build
> failure.
Sorry to hear the bisection is not successful.
>
> So I ran the command above and then the build succeeded.
I'm very happy that the command works.
>
> Though it would be good if the build worked from "make distclean"...
I would be very honored if I could join the efforts to make the -next bette=
r.

Many thanks
Zhouyi
>
>                                                         Thanx, Paul
>
> > > > > Either way, it looks like I need to upgrade the torture.sh script=
's
> > > > > checks for failed builds.  Thank you for reporting this!
> > > >
> > > > Does this make torture.sh more reliably report build failures?
> > > I studied this commit line by line several times and benefited a lot.=
 Thank you!
> > > >
> > > >                                                 Thanx, Paul
> > > >
> > > > -------------------------------------------------------------------=
-----
> > > >
> > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > >
> > > >     torture: Make kvm-find-errors.sh notice missing vmlinux file
> > > >
> > > >     Currently, an obtuse compiler diagnostic can fool kvm-find-erro=
rs.sh
> > > >     into believing that the build was successful.  This commit ther=
efore
> > > >     adds a check for a missing vmlinux file.
> > > >
> > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-4029=
5932a640@molgen.mpg.de/
> > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors=
.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > @@ -30,10 +30,15 @@ editor=3D${EDITOR-vi}
> > > >  files=3D
> > > >  for i in ${rundir}/*/Make.out
> > > >  do
> > > > +       scenariodir=3D"`dirname $i`"
> > > >         if egrep -q "error:|warning:|^ld: .*undefined reference to"=
 < $i
> > > >         then
> > > >                 egrep "error:|warning:|^ld: .*undefined reference t=
o" < $i > $i.diags
> > > >                 files=3D"$files $i.diags $i"
> > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > +       then
> > > > +               echo No ${scenariodir}/vmlinux file > $i.diags
> > > > +               files=3D"$files $i.diags $i"
> > > >         fi
> > > >  done
> > > >  if test -n "$files"
> > > Thanks
> > > Zhouyi
