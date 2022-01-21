Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003549577A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 01:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378456AbiAUAoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 19:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378443AbiAUAoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 19:44:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFEC061574;
        Thu, 20 Jan 2022 16:44:37 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so36180631edn.0;
        Thu, 20 Jan 2022 16:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GEbqewhb4r560pxZXW9RNmb2mb7VvxMPldZNYw3HCiE=;
        b=ThXy29JV1w13VlSDN9F1KqU3F7UMTQzUIIfvAyLsZ/BvLS6N2vWS4vXGvNG/BVvDLE
         SCJbPOh8j8nO4WiR9yDJcRXV/Ric+FwsHcgpKWMPszDccD1NQMJYrrZMTFVmaTKH9w2c
         pwN9y/6nPyX0vg9mvXu0mUg4RIcHKD15fQd5dLu30g/cLDWTjpwau6xglmX6bLa7QZaQ
         hLCbAG9fqU+LY1z8UBx0UGu98PHgIkWXl/HXT7lV8VQIjnlftBCEuoTMim3TW0VoE5OC
         4AzoWMEZCMnnnRdYO+Q1K3K+ISjkcBSpv9nj7JMN+FTj9G516d9GzTB3QhwCQsQVjDGF
         +Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GEbqewhb4r560pxZXW9RNmb2mb7VvxMPldZNYw3HCiE=;
        b=4zs/wXVU01BxI9DvGeL0E8nTDzOg2zoums7L1gM/Rxea/8+SfkYW3VMqGiCU4njwpM
         bqa4onbOGKikJCYqJqn8ZCSG9Y/v7XST1EtDL9M40dAEOnoAowOI5aBeBFeDqLXamWN0
         quRVa8an/FZmeUw/4JOPIHtBPQaBAvmx5GyPrX4KhmhhArYxKVii6i1SAcVXv2KgnCMj
         wNo0ZHQcHWQXXcZJ1GY6sB3Gd2HG7mLVEweJRv6pwbZLQeERfq7pl/fLnXksrznl3HjP
         A7FVUEmXINEt9+8398yT4TKiBkg0jy7X2nJni61SpAKP1Di5k8Sx7LCGCHqe43fxpc7A
         ojWg==
X-Gm-Message-State: AOAM531OuT2G93Nl/TIYJOxsLH9iYLwLwawWK5P3sa1cw439GHS+hljI
        0ZHJ4/XPnSE6vUMNwysh0zyycXka6ZriOQIanb0=
X-Google-Smtp-Source: ABdhPJwUngEtx48pQz4bPo8SOnRuB8qk+9wVoBAMhbL+rHJE3TxpkdyUxAEKNp6FkC7/xxGPNbv9kkNuPCRkpU/EiXA=
X-Received: by 2002:aa7:dd59:: with SMTP id o25mr1785698edw.288.1642725875540;
 Thu, 20 Jan 2022 16:44:35 -0800 (PST)
MIME-Version: 1.0
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de> <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1> <CAABZP2yffDyg31smcCyqENFBvQPfmFCT_YwDM_DJ=S-3rjxKuQ@mail.gmail.com>
 <20220119044649.GL947480@paulmck-ThinkPad-P17-Gen-1> <20220119182143.GA2183703@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x-esy+9R4iiMZR5UV7YnYQxikAgsAQM+PU-o9+m9WMpw@mail.gmail.com> <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220120210636.GR947480@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 21 Jan 2022 08:44:23 +0800
Message-ID: <CAABZP2zCWJ1S3We1f6UNVW=Q6h7cz8uMbR7PTzt9UWH9CjSZuw@mail.gmail.com>
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

Thank Paul for your guidance!

On Fri, Jan 21, 2022 at 5:06 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Thu, Jan 20, 2022 at 03:30:54AM +0800, Zhouyi Zhou wrote:
> > On Thu, Jan 20, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > >
> > > On Tue, Jan 18, 2022 at 08:46:49PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Jan 19, 2022 at 10:07:42AM +0800, Zhouyi Zhou wrote:
> > > > > Thanks Paul for looking into this
> > > > >
> > > > > On Wed, Jan 19, 2022 at 7:46 AM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> > > > > >
> > > > > > On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wrot=
e:
> > > > > > > On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> > > > > > > > Dear Zhouyi,
> > > > > > > >
> > > > > > > >
> > > > > > > > Thank you for your quick response.
> > > > > > > >
> > > > > > > >
> > > > > > > > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > > > > > > >
> > > > > > > > > I have studied the rcu torture test recently. I am also i=
nterested in
> > > > > > > > > this topic.
> > > > > > > > > But I can't open
> > > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.=
out.txt
> > > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.t=
xt
> > > > > > > >
> > > > > > > > Sorry, about that. I should have checked those. I had put t=
hem into a
> > > > > > > > directory:
> > > > > > > >
> > > > > > > > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodc=
onf-Make.out.txt
> > > > > > > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutort=
ure-log.txt
> > > > > > > >
> > > > > > > > I am going to try to test your suggestions at the end of th=
e day.
> > > > > > >
> > > > > > > On x86 rcutorture builds successfully.  However, allmodconfig
> > > > > > > on semi-recent -next got me "Can't open perl script
> > > > > > > "./usr/include/headers_check.pl": No such file or directory".
> > > > > > > Which might well be a local problem or might well be fixed by=
 now.
> > > > > >
> > > > > > Not fixed as of next-20220118.  Chasing it down...  ;-)
> > > > > I can do allmodconfig on -next,
> > > > > $git describe
> > > > > next-20220118
> > > > > $tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> > > > >  ---  tools/testing/selftests/rcutorture/bin/torture.sh --duratio=
n 10
> > > > >  --- Results directory:  2022.01.19-09.14.39-torture
> > > > > $ ps -aux|grep qemu-system
> > > > > zzy       470309  773  0.3 1876544 153936 pts/0  Sl+  09:55  31:2=
7
> > > > > qemu-system-x86_64 -enable-kvm -nographic -smp 16 -net none -mach=
ine
> > > > > q35,accel=3Dkvm -cpu kvm64 -serial
> > > > > file:/tmp/linux-next/tools/testing/selftests/rcutorture/res/2022.=
01.19-09.14.39-torture/results-rcutorture/TREE03/console.log
> > > > > -m 512 -kernel /tmp/linux-next/tools/testing/selftests/rcutorture=
/res/2022.01.19-09.14.39-torture/results-rcutorture/TREE03/bzImage
> > > > > -append debug_boot_weak_hash panic=3D-1 selinux=3D0 initcall_debu=
g debug
> > > > > console=3DttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=3D1
> > > > > torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=3D3=
0000
> > > > > rcutorture.onoff_interval=3D200 rcutorture.onoff_holdoff=3D30
> > > > > rcutree.gp_preinit_delay=3D12 rcutree.gp_init_delay=3D3
> > > > > rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 threadirqs
> > > > > tree.use_softirq=3D0 rcutorture.n_barrier_cbs=3D4
> > > > > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D420
> > > > > rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1
> > > > > zzy       755865  0.0  0.0  17676  2876 pts/2    S+   09:59   0:0=
0
> > > > > grep --color=3Dauto qemu-system
> > > > > $ ls -l vmlinux
> > > > > -rwxrwxr-x 1 zzy zzy 69349872 1=E6=9C=88  19 09:55 vmlinux
> > > > >
> > > > > Could you please try the following command ?
> > > > > linux-next$ perl ./usr/include/headers_check.pl usr/include x86
> > > > > usr/include/rdma/hfi/hfi1_user.h
> > > > > linux-next$ echo $?
> > > > > 0
> > > > > The headers_check.pl in linux-next
> > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git/tree/usr/include/headers_check.pl)
> > > > > is used to check the validity of head files in ./usr/include
> > > >
> > > > I am currently bisecting, but once that finishes I will give this a
> > > > try, thank you!
> > >
> > > And the bisection converged badly due to there being more than one bu=
ild
> > > failure.
> > Sorry to hear the bisection is not successful.
> > >
> > > So I ran the command above and then the build succeeded.
> > I'm very happy that the command works.
> > >
> > > Though it would be good if the build worked from "make distclean"...
> > I would be very honored if I could join the efforts to make the -next b=
etter.
>
> One approach would be to download the -next kernels as they appear and
> run tests on them.  Reporting bugs is good, and of course fixing them
> even better.
This provides a nice way of participating the efforts to make -next
better, and provides me a good way to learn new knowledge in -next!

>
> You can clone -next from here:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
> Individual -next releases are tagged, for example, "next-20220118".
I will clone -next from the tree, and will download the -next releases from
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
> Me, I run torture.sh on them from time to time, depending on how much
> other testing I am doing.  So maybe once or twice a week.  ;-)
You are the example worth learning in my life, to be honest , I will
do the same way as you do!

Sincerely
Zhouyi
>
>                                                 Thanx, Paul
>
> > Many thanks
> > Zhouyi
> > >
> > >                                                         Thanx, Paul
> > >
> > > > > > > Either way, it looks like I need to upgrade the torture.sh sc=
ript's
> > > > > > > checks for failed builds.  Thank you for reporting this!
> > > > > >
> > > > > > Does this make torture.sh more reliably report build failures?
> > > > > I studied this commit line by line several times and benefited a =
lot. Thank you!
> > > > > >
> > > > > >                                                 Thanx, Paul
> > > > > >
> > > > > > ---------------------------------------------------------------=
---------
> > > > > >
> > > > > > commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
> > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > Date:   Tue Jan 18 15:40:49 2022 -0800
> > > > > >
> > > > > >     torture: Make kvm-find-errors.sh notice missing vmlinux fil=
e
> > > > > >
> > > > > >     Currently, an obtuse compiler diagnostic can fool kvm-find-=
errors.sh
> > > > > >     into believing that the build was successful.  This commit =
therefore
> > > > > >     adds a check for a missing vmlinux file.
> > > > > >
> > > > > >     Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-=
40295932a640@molgen.mpg.de/
> > > > > >     Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-er=
rors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > index 2e9e9e2eedb69..7d3e11a6b8290 100755
> > > > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
> > > > > > @@ -30,10 +30,15 @@ editor=3D${EDITOR-vi}
> > > > > >  files=3D
> > > > > >  for i in ${rundir}/*/Make.out
> > > > > >  do
> > > > > > +       scenariodir=3D"`dirname $i`"
> > > > > >         if egrep -q "error:|warning:|^ld: .*undefined reference=
 to" < $i
> > > > > >         then
> > > > > >                 egrep "error:|warning:|^ld: .*undefined referen=
ce to" < $i > $i.diags
> > > > > >                 files=3D"$files $i.diags $i"
> > > > > > +       elif ! test -f ${scenariodir}/vmlinux
> > > > > > +       then
> > > > > > +               echo No ${scenariodir}/vmlinux file > $i.diags
> > > > > > +               files=3D"$files $i.diags $i"
> > > > > >         fi
> > > > > >  done
> > > > > >  if test -n "$files"
> > > > > Thanks
> > > > > Zhouyi
