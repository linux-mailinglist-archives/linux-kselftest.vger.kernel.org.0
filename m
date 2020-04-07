Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541D41A170F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGU43 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 16:56:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37680 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGU42 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 16:56:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id r4so2299486pgg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Apr 2020 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M31Vt51G6lrjKFub44bROR6Mn7Nx2RyB3L3aJk9q12s=;
        b=dEhWiCWmROcLRgbz1CLMLRw3perMxP5eFyh9QSaFeByj2fSoL1dUX2yn/k+VApuLWC
         T+6HqwaXmrBC08to4TpStHwLosi97rNyVXAjkiY7pVW42VhXwu4Fs86dlOMC5R2IGe9w
         iZ8WX6NkAGi810/sO9R+l161t66nAnSOvRPzaXkxs/O2V7rVvdvLgO95D+de5XKmFjnO
         pNUR+NWiDQwxAycxURMAh7lJsyitcswrOnge9YfWsTOdJFemikCKGLHMWcExM4K0s6xF
         YdrqEaD7CYoDaQUmhnA9fihLyw8a74FWLNC+LQCjDySnRDdfCvAwBPf9yn0Pr/rcMmGP
         LJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M31Vt51G6lrjKFub44bROR6Mn7Nx2RyB3L3aJk9q12s=;
        b=PEZftRA5mzhVPqVVBn/cTEKpqlBr6d6qyolxC5dyaT12pm0mbRuC6I5DF5hhBHtAvp
         3TgwnyPddnYw2S0TnmmP1/YyoxjOcpr80s+ZUONqZfjN1MeH+HXsegbfGjIWuA4RiH3+
         Gp+gk10/X6D8SYaa5yXYvDkXkzz+91Jxz7iTxkX5jeK4lmilcpTxrCChQdeVpuhXYANE
         OQSWgXDE0v+UEelxnorMFUWD5ClzYK2F8RM6wS8yn3LfG7Yd0x3j7Oaq4HAzP0u8nwWO
         eCXjyb1pn6P/kqiojmdA4ThdmSQTKE/nFYXwyLYQN2V2kdFuEUHCTzYVoK6FuxWRjRDL
         bIPQ==
X-Gm-Message-State: AGi0Puan8JMNdBF5oqbt52kHzQwRbQ0z4y1NX/25BzJddsoT8GT8vdX4
        rtOoeIeDtNQrwH/maiysjfAH9lAYfy7hDvUWlv2n1g==
X-Google-Smtp-Source: APiQypKCp9eTKpI99BlhbFlRuGYtYA+KWvY4dYGMUexNvezSCeYGWmpl6PE3TLnBx964Toc2IveCOgI6g5G5CF7sKt0=
X-Received: by 2002:a62:8343:: with SMTP id h64mr4551572pfe.166.1586292987080;
 Tue, 07 Apr 2020 13:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRZ9eCE29FjXkv1dQfrdGO3uWp4Tvkip5Z_jsgjVJeAQ@mail.gmail.com>
 <CAHp75VfhKoLtWkLHUyzg6m=rx833qiCVimWJVKU13qrX+aJz-Q@mail.gmail.com>
 <CAFd5g45GbSX1BkuaH=8639ESHi-MCGkpFhEZZpycm9=jQb93rg@mail.gmail.com>
 <CAFd5g47aaE+tGeHPrQmhfi6_nrvi1K4DvtRodh=zN21-uiQ1DQ@mail.gmail.com>
 <20200305223350.GA2852@mara.localdomain> <20200306120525.GC68079@kuha.fi.intel.com>
 <CAFd5g45c9L4BBRNtxtQf_NFr2bR6Wgt9uOHW86gzb6Ozeb0SBA@mail.gmail.com>
 <CAFd5g45cdygYfxGoCkk710tLXFADeLNb+6w-=vhkDMLP9OM7bw@mail.gmail.com>
 <20200310111837.GA1368052@kuha.fi.intel.com> <CAFd5g452sDMZToU+FDa-Odbkd_t1708gcRMAZQG+U4LnV=Xqgw@mail.gmail.com>
 <CA+G9fYuwv+TEhgi46pjs2-GCe0mmMHyki9nAokvGCEA2syK5Dg@mail.gmail.com>
In-Reply-To: <CA+G9fYuwv+TEhgi46pjs2-GCe0mmMHyki9nAokvGCEA2syK5Dg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Apr 2020 13:56:16 -0700
Message-ID: <CAFd5g46Bwd8HS9-xjHLh_rB59Nfw8iAnM6aFe0QPcveewDUT6g@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00 - ida_free+0x76/0x140
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 7, 2020 at 2:25 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 11 Mar 2020 at 02:16, Brendan Higgins <brendanhiggins@google.com> wrote:
> > > > > > > > > > > Steps reproduce by using kselftests,
> > > > > > > > > > >
> > > > > > > > > > >           - lsmod || true
> > > > > > > > > > >           - cd /opt/kselftests/default-in-kernel/lib/
> > > > > > > > > > >           - export PATH=/opt/kselftests/default-in-kernel/kselftest:$PATH
> > > > > > > > > > >           - ./printf.sh || true
> > > > > > > > > > >           - ./bitmap.sh || true
> > > > > > > > > > >           - ./prime_numbers.sh || true
> > > > > > > > > > >           - ./strscpy.sh || true
> > > > > > > > > > >
> > > > > > > > > > > x86_64 kernel BUG dump.
> > > > > > > > > > > + ./printf.sh
> > > > > > > > >
> > > > > > > > > Oops, I am wondering if I broke this with my change "Revert "software
> > > > > > > > > node: Simplify software_node_release() function"":
> > > > > > > > >
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d1c19322388d6935b534b494a2c223dd089e30dd
> > > > > > > > >
> > > > > > > > > I am still investigating, will update later.
> > > > > > > >
> > > > > > > > Okay, yeah, I am pretty sure I caused the breakage. I got an email
> > > > > > > > from kernel test robot a couple days ago that I didn't see:
> > > > > > > >
> > > > > > > > https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/N3ZN5XH7HK24JVEJ5WSQD2SK6YCDRILR/
> > > > > > > >
> > > > > > > > It shows the same breakage after applying this change.
> > > > > > > >
> > > > > > > > I am still investigating how my change broke it, nevertheless.
> > > > > > >
> > > > > > > As nodes in the tree are being removed, the code before the patch that
> > > > > > > "simplified" the software_node_release() function accessed the node's parent
> > > > > > > in its release function.
> > > > > > >
> > > > > > > And if CONFIG_DEBUG_KOBJECT_RELEASE is defined, the release functions are no
> > > > > > > longer necessarily called in order, leading to referencing released memory.
> > > > > > > Oops!
> > > > > > >
> > > > > > > So Heikki's patch actually fixed a bug. :-)
> > > > > >
> > > > > > Well, I think it just hid the problem. It looks like the core
> > > > > > (lib/kobject.c) allows the parent kobject to be released before the
> > > > > > last child kobject is released. To be honest, that does not sound
> > > > > > right to me...
> > > > > >
> > > > > > I think we can workaround this problem by taking reference to the
> > > > > > parent when the child is added, and then releasing it when the child
> > > > > > is released, and in that way be guaranteed that the parent will not
> > > > > > disappear before the child is fully released, but that still does not
> > > > > > feel right. It feels more like the core is not doing it's job to me.
> > > > > > The parent just should not be released before its children.
> > > > > >
> > > > > > Either I'm wrong about that, and we still should take the reference on
> > > > > > the parent, or we revert my patch like Brendan proposed and then fix
> > > > >
> > > > > Either way, isn't it wrong to release the node ID before deleting the
> > > > > sysfs entry? I am not sure that my fix was the correct one, but I
> > > > > believe the bug that Heidi and I found is actually a bug.
> > >
> > > I agree.
> > >
> > > > > > the core with something like this (warning, I did not even try to
> > > > > > compile that):
> > > > >
> > > > > I will try it out.
> > > > >
> > > > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > > > index 83198cb37d8d..ec5774992337 100644
> > > > > > --- a/lib/kobject.c
> > > > > > +++ b/lib/kobject.c
> > > > > > @@ -680,6 +680,12 @@ static void kobject_cleanup(struct kobject *kobj)
> > > > > >                 kobject_uevent(kobj, KOBJ_REMOVE);
> > > > > >         }
> > > > > >
> > > > > > +       if (t && t->release) {
> > > > > > +               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> > > > > > +                        kobject_name(kobj), kobj);
> > > > > > +               t->release(kobj);
> > > > > > +       }
> > > > > > +
> > > > > >         /* remove from sysfs if the caller did not do it */
> > > > > >         if (kobj->state_in_sysfs) {
> > > > > >                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > > > > @@ -687,12 +693,6 @@ static void kobject_cleanup(struct kobject *kobj)
> > > > > >                 kobject_del(kobj);
> > > > > >         }
> > > > > >
> > > > > > -       if (t && t->release) {
> > > > > > -               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> > > > > > -                        kobject_name(kobj), kobj);
> > > > > > -               t->release(kobj);
> > > > > > -       }
> > > > > > -
> > > > > >         /* free name if we allocated it */
> > > > > >         if (name) {
> > > > > >                 pr_debug("kobject: '%s': free name\n", name);
> > > >
> > > > Alright, so I tried it and it looks like Heikki's suggestion worked.
> > > >
> > > > Is everyone comfortable going this route?
> > >
> > > Hold on. Another way to fix the problem is to increment the parent's
> > > reference count before that kobject_del(kobj) is called, and then
> > > decrementing it after t->release(kobj) is called. It may be safer to
> > > fix the problem like that.
> >
> > Right, this was your first suggestion above, right? That actually made
> > more sense to me, but you seemed skeptical of it due to it being
> > messier, which makes sense.
> >
> > Nevertheless, having children take a reference seems like the right
> > thing to do because the children need to degregister themselves from
> > the parent. Calling t->release() ahead of kobject_del() seems to
> > reintroduce the problem that I pointed out, albeit *much* more
> > briefly. If I understand correctly, it is always wrong to have a sysfs
> > entry that points to a partially deallocated kobject. Please correct
> > me if I am wrong.
> >
> > So I think there are two solutions: Either we have to ensure that each
> > child is deallocated first so we can preserve the kobject_del() and
> > then t->release() ordering, or we have to add some sort of "locking"
> > mechanism to prevent the kobject from being accessed by anything other
> > than the deallocation code until it is fully deallocated; well, it
> > would have to prevent any access at all :-). I think it goes without
> > saying that this "locking" idea is pretty flawed.
> >
> > The problem with just having children take a reference is that the
> > kobject children already take a reference to their parent, so it seems
> > like the kobject should be smart enough to deallocate children rather
> > than having swnode have to keep a separate tally of children, no?
> >
> > Sorry if this all seems obvious, I am not an expert on this part of the kernel.
> >
> > > My example above proofs that there is the problem, but it changes the
> > > order of execution which I think can always have other consequences.
> > >
> > > > Also, should I send this fix as a separate patch? Or do people want me
> > > > to send an updated revision of my revert patch with the fix?
> > >
> > > This needs to be send in its own separate patch. Ideally it could be
> > > send together with the revert in the same series, but I'm not sure
> > > that's possible anymore. Didn't Greg pick the revert already?
> >
> > Sounds good.
> >
> > I did already let Greg know when he emailed us on backporting the
> > patch to stable, and he acked saying he removed them. So as long as
> > these are not in the queue for 5.6 (it is not in Linus' tree yet), we
> > should be good.
>
> The reported bug is still noticed on Linux mainline master branch
> The Kernel BUG noticed on x86_64 and i386 running selftest on Linux
> mainline kernel 5.6.0.

Oh sorry, I thought that this patch was dropped from the maintainer's
for-next branch.

Heikki, what do you think about my suggestion of having kobject
deallocate its children?

In the meantime, are people cool with the patch that Heikki proposed
as a temporary mitigation? I think my solution might be a bit more
involved. If I don't hear anything back, I will send out Heikki's
suggestion as a patch.

> Linux version 5.6.0 (oe-user@oe-host) (gcc version 7.3.0 (GCC)) #1 SMP
> Mon Apr 6 17:25:26 UTC 2020
> <>
> [  270.580905] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  270.588978] #PF: supervisor read access in kernel mode
> [  270.594114] #PF: error_code(0x0000) - not-present page
> [  270.599247] PGD 800000026b340067 P4D 800000026b340067 PUD 26b34e067 PMD 0
> [  270.606119] Oops: 0000 [#1] SMP PTI
> [  270.609604] CPU: 1 PID: 4688 Comm: modprobe Tainted: G        W
>     5.6.0 #1
> [  270.616996] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [  270.624381] RIP: 0010:ida_free+0x76/0x140
> [  270.628391] Code: 45 d0 00 00 00 00 48 89 45 b0 0f 88 c4 00 00 00
> 89 f3 e8 0d 51 02 00 48 8d 7d a8 49 89 c6 e8 e1 04 01 00 a8 01 49 89
> c5 75 42 <4c> 0f a3 20 72 76 48 8b 7d a8 4c 89 f6 e8 18 53 02 00 89 de
> 48 c7
> [  270.647128] RSP: 0018:ffffbd8841d07a50 EFLAGS: 00010046
> [  270.652346] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff978be6ac48c0
> [  270.659468] RDX: 0000000000000000 RSI: ffff978beb346780 RDI: ffff978be6ac5138
> [  270.666595] RBP: ffffbd8841d07aa8 R08: 0000000000000001 R09: 0000000000000000
> [  270.673725] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [  270.680850] R13: 0000000000000000 R14: 0000000000000246 R15: ffffffffc0383b3c
> [  270.687973] FS:  00007fc8e92c2740(0000) GS:ffff978befa80000(0000)
> knlGS:0000000000000000
> [  270.696052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  270.701790] CR2: 0000000000000000 CR3: 000000021f2b0003 CR4: 00000000003606e0
> [  270.708920] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  270.716043] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  270.723169] Call Trace:
> [  270.725618]  software_node_release+0x2b/0xb0
> [  270.729886]  kobject_put+0xad/0x1c0
> [  270.733378]  kobject_del+0x4a/0x60
> [  270.736776]  kobject_put+0x92/0x1c0
> [  270.740270]  fwnode_remove_software_node+0x32/0x40
> [  270.745061]  software_node_unregister_nodes+0x2a/0x50
> [  270.750114]  test_printf_init+0xf30/0x1c16 [test_printf]
> [  270.755422]  ? test_hashed+0x75/0x75 [test_printf]
> [  270.760211]  ? test_hashed+0x75/0x75 [test_printf]
> [  270.765003]  do_one_initcall+0x61/0x2f0
> [  270.768842]  ? rcu_read_lock_sched_held+0x4f/0x80
> [  270.773541]  ? kmem_cache_alloc_trace+0x282/0x2b0
> [  270.778247]  do_init_module+0x5f/0x22b
> [  270.781999]  load_module+0x24e6/0x2ac0
> [  270.785754]  ? security_kernel_post_read_file+0x3f/0x60
> [  270.790979]  __do_sys_finit_module+0xfc/0x120
> [  270.795334]  ? __do_sys_finit_module+0xfc/0x120
> [  270.799862]  __x64_sys_finit_module+0x1a/0x20
> [  270.804219]  do_syscall_64+0x55/0x200
> [  270.807885]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [  270.812938] RIP: 0033:0x7fc8e8bcaf59
> [  270.816516] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f ff 2b 00 f7 d8 64 89
> 01 48
> [  270.835253] RSP: 002b:00007ffe9a4fb6f8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000139
> [  270.842810] RAX: ffffffffffffffda RBX: 0000000000cdfaf0 RCX: 00007fc8e8bcaf59
> [  270.849934] RDX: 0000000000000000 RSI: 0000000000418cce RDI: 0000000000000005
> [  270.857057] RBP: 0000000000418cce R08: 0000000000000000 R09: 0000000000000000
> [  270.864180] R10: 0000000000000005 R11: 0000000000000202 R12: 0000000000000000
> [  270.871306] R13: 0000000000040000 R14: 0000000000000000 R15: 0000000000000000
> [  270.878433] Modules linked in: test_printf(+) cls_bpf sch_fq 8021q
> sch_ingress veth algif_hash x86_pkg_temp_thermal fuse [last unloaded:
> gpio_mockup]
> [  270.891812] CR2: 0000000000000000
> [  270.895130] ---[ end trace 151cfe414205f0bc ]---
> [  270.899742] RIP: 0010:ida_free+0x76/0x140
> [  270.903752] Code: 45 d0 00 00 00 00 48 89 45 b0 0f 88 c4 00 00 00
> 89 f3 e8 0d 51 02 00 48 8d 7d a8 49 89 c6 e8 e1 04 01 00 a8 01 49 89
> c5 75 42 <4c> 0f a3 20 72 76 48 8b 7d a8 4c 89 f6 e8 18 53 02 00 89 de
> 48 c7
> [  270.922489] RSP: 0018:ffffbd8841d07a50 EFLAGS: 00010046
> [  270.927706] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff978be6ac48c0
> [  270.934831] RDX: 0000000000000000 RSI: ffff978beb346780 RDI: ffff978be6ac5138
> [  270.941954] RBP: ffffbd8841d07aa8 R08: 0000000000000001 R09: 0000000000000000
> [  270.949078] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [  270.956204] R13: 0000000000000000 R14: 0000000000000246 R15: ffffffffc0383b3c
> [  270.963328] FS:  00007fc8e92c2740(0000) GS:ffff978befa80000(0000)
> knlGS:0000000000000000
> [  270.971414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  270.977158] CR2: 0000000000000000 CR3: 000000021f2b0003 CR4: 00000000003606e0
> [  270.984281] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  270.991407] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  270.998540] BUG: sleeping function called from invalid context at
> /usr/src/kernel/include/linux/percpu-rwsem.h:49
> [  271.008782] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
> 4688, name: modprobe
> [  271.016771] INFO: lockdep is turned off.
> [  271.020691] irq event stamp: 4812
> [  271.024011] hardirqs last  enabled at (4811): [<ffffffffb5be42f1>]
> kfree+0x181/0x2e0
> [  271.031748] hardirqs last disabled at (4812): [<ffffffffb67d2b68>]
> _raw_spin_lock_irqsave+0x18/0x50
> [  271.040778] softirqs last  enabled at (4496): [<ffffffffb6a00348>]
> __do_softirq+0x348/0x459
> [  271.049117] softirqs last disabled at (4487): [<ffffffffb59be298>]
> irq_exit+0xb8/0xc0
> [  271.056933] CPU: 1 PID: 4688 Comm: modprobe Tainted: G      D W
>     5.6.0 #1
> [  271.064317] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [  271.071702] Call Trace:
> [  271.074147]  dump_stack+0x7a/0xa5
> [  271.077465]  ___might_sleep+0x163/0x250
> [  271.081296]  __might_sleep+0x4a/0x80
> [  271.084868]  exit_signals+0x33/0x2f0
> [  271.088446]  do_exit+0xb6/0xcd0
> [  271.091586]  rewind_stack_do_exit+0x17/0x20
> [  271.095770] RIP: 0033:0x7fc8e8bcaf59
> [  271.099349] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f ff 2b 00 f7 d8 64 89
> 01 48
> [  271.118093] RSP: 002b:00007ffe9a4fb6f8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000139
> [  271.125649] RAX: ffffffffffffffda RBX: 0000000000cdfaf0 RCX: 00007fc8e8bcaf59
> [  271.132775] RDX: 0000000000000000 RSI: 0000000000418cce RDI: 0000000000000005
> [  271.139897] RBP: 0000000000418cce R08: 0000000000000000 R09: 0000000000000000
> [  271.147022] R10: 0000000000000005 R11: 0000000000000202 R12: 0000000000000000
> [  271.154146] R13: 0000000000040000 R14: 0000000000000000 R15: 0000000000000000
> [  271.161274] note: modprobe[4688] exited with preempt_count 1
>
> Full test log:
> https://lkft.validation.linaro.org/scheduler/job/1341945#L8386
> https://lkft.validation.linaro.org/scheduler/job/1341969#L8023
>
>
> - Naresh
