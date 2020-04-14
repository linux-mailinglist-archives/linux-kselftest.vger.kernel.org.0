Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCC1A8AB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504731AbgDNT2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504700AbgDNT2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 15:28:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF515C061A41
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 12:28:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so318246plo.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiyjoFUmTHBG6YEVo1NHYgGy2iN8bLQCqYt4d6ZBgrI=;
        b=cG8zsow6fDjmmBzMDOL5spBv5Oobh5HVccnfN9dOiWAtvHCtEWThawbmibde4HXwYA
         SzuWW1VJ/e8TF2P9t3VbspAWN3+/V/aXMgfnOcJyKV1LZ/h+HNX84VtXQw0tkOSTwy5j
         k5uMu8UR62Bfkh1UlrdC5nFBnUDjeF93svlzyOy6MvTRIteSYPew9llaidfo9CMAt7z5
         EA/jQf25DUf8SWrUf2tkux7ZpPlPjtaZs3r1Ue8E5z0RaIHO50NiQIyrjGoHollZooaU
         Vi4kxT+QZ5ZaiplnLhqp1BJ+zF8YM0jQvF2EjVC1WYjAfxI0V3KPakD06RdHqwctOq2Q
         rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiyjoFUmTHBG6YEVo1NHYgGy2iN8bLQCqYt4d6ZBgrI=;
        b=EDvRvQNcDXq2YD17+nNEacmy9j8m3ImEiGAKmxaYMLUoFGUeFVZV1UQjrv/nTI0/67
         7/ADiPLAorChsWgG5pPqXYRux2OlP+dbAN8g6/VOqjBYm2+KM7S1q3UOiZ9IO1pT2zF8
         DxZFlYpIDLpXvtucFyNNUpiRu9BtH5p1YB1nqVD5IuD9EsLUmjdSe5oYArFWSslNABls
         +6aFeyXZT1RVpaycd87SgXm2/RfReeoYG+XVmli/oDIqNO8g2M0oa77WkZUAxBFco89s
         J6LNShDPgRIaQIHDcVHwSlgwRk1+f2fjvlX+om2MNp/91RWztY0gUgHQ8RWmThY8lvVr
         wwHA==
X-Gm-Message-State: AGi0PubehRANss+OebPS0DWv2fCFVmWC16o7IBk/NfV8Sr6VAlidB9xl
        PvDJvvTs5s52hm/241NogKLQnVyRxPoUMuVyJsit0Q==
X-Google-Smtp-Source: APiQypLZW47Xw7GMs1CPAO0uL/mcCGHvnKcgs29F1QTxAPh3JKODOoxO3KdWxckOuv3HO2cVgoUCqk6+t8paeSaYxas=
X-Received: by 2002:a17:90a:e28e:: with SMTP id d14mr1930278pjz.29.1586892486063;
 Tue, 14 Apr 2020 12:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd5g45GbSX1BkuaH=8639ESHi-MCGkpFhEZZpycm9=jQb93rg@mail.gmail.com>
 <CAFd5g47aaE+tGeHPrQmhfi6_nrvi1K4DvtRodh=zN21-uiQ1DQ@mail.gmail.com>
 <20200305223350.GA2852@mara.localdomain> <20200306120525.GC68079@kuha.fi.intel.com>
 <CAFd5g45c9L4BBRNtxtQf_NFr2bR6Wgt9uOHW86gzb6Ozeb0SBA@mail.gmail.com>
 <CAFd5g45cdygYfxGoCkk710tLXFADeLNb+6w-=vhkDMLP9OM7bw@mail.gmail.com>
 <20200310111837.GA1368052@kuha.fi.intel.com> <CAFd5g452sDMZToU+FDa-Odbkd_t1708gcRMAZQG+U4LnV=Xqgw@mail.gmail.com>
 <CA+G9fYuwv+TEhgi46pjs2-GCe0mmMHyki9nAokvGCEA2syK5Dg@mail.gmail.com>
 <CAFd5g46Bwd8HS9-xjHLh_rB59Nfw8iAnM6aFe0QPcveewDUT6g@mail.gmail.com>
 <20200414081513.GD2828150@kuha.fi.intel.com> <CAFd5g46KeNu6bmDHBiJtGqEBQEyo1ooh=wK_PJbNih+2UCLoNQ@mail.gmail.com>
In-Reply-To: <CAFd5g46KeNu6bmDHBiJtGqEBQEyo1ooh=wK_PJbNih+2UCLoNQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Apr 2020 12:27:54 -0700
Message-ID: <CAFd5g44s5NQvT8TG_x4rwbqoa7zWzkV0TX+ETZoQdOB7OwXCPQ@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00 - ida_free+0x76/0x140
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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

On Tue, Apr 14, 2020 at 12:18 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Apr 14, 2020 at 1:15 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 07, 2020 at 01:56:16PM -0700, Brendan Higgins wrote:
> > > On Tue, Apr 7, 2020 at 2:25 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Mar 2020 at 02:16, Brendan Higgins <brendanhiggins@google.com> wrote:
> > > > > > > > > > > > > > Steps reproduce by using kselftests,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >           - lsmod || true
> > > > > > > > > > > > > >           - cd /opt/kselftests/default-in-kernel/lib/
> > > > > > > > > > > > > >           - export PATH=/opt/kselftests/default-in-kernel/kselftest:$PATH
> > > > > > > > > > > > > >           - ./printf.sh || true
> > > > > > > > > > > > > >           - ./bitmap.sh || true
> > > > > > > > > > > > > >           - ./prime_numbers.sh || true
> > > > > > > > > > > > > >           - ./strscpy.sh || true
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > x86_64 kernel BUG dump.
> > > > > > > > > > > > > > + ./printf.sh
> > > > > > > > > > > >
> > > > > > > > > > > > Oops, I am wondering if I broke this with my change "Revert "software
> > > > > > > > > > > > node: Simplify software_node_release() function"":
> > > > > > > > > > > >
> > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d1c19322388d6935b534b494a2c223dd089e30dd
> > > > > > > > > > > >
> > > > > > > > > > > > I am still investigating, will update later.
> > > > > > > > > > >
> > > > > > > > > > > Okay, yeah, I am pretty sure I caused the breakage. I got an email
> > > > > > > > > > > from kernel test robot a couple days ago that I didn't see:
> > > > > > > > > > >
> > > > > > > > > > > https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/N3ZN5XH7HK24JVEJ5WSQD2SK6YCDRILR/
> > > > > > > > > > >
> > > > > > > > > > > It shows the same breakage after applying this change.
> > > > > > > > > > >
> > > > > > > > > > > I am still investigating how my change broke it, nevertheless.
> > > > > > > > > >
> > > > > > > > > > As nodes in the tree are being removed, the code before the patch that
> > > > > > > > > > "simplified" the software_node_release() function accessed the node's parent
> > > > > > > > > > in its release function.
> > > > > > > > > >
> > > > > > > > > > And if CONFIG_DEBUG_KOBJECT_RELEASE is defined, the release functions are no
> > > > > > > > > > longer necessarily called in order, leading to referencing released memory.
> > > > > > > > > > Oops!
> > > > > > > > > >
> > > > > > > > > > So Heikki's patch actually fixed a bug. :-)
> > > > > > > > >
> > > > > > > > > Well, I think it just hid the problem. It looks like the core
> > > > > > > > > (lib/kobject.c) allows the parent kobject to be released before the
> > > > > > > > > last child kobject is released. To be honest, that does not sound
> > > > > > > > > right to me...
> > > > > > > > >
> > > > > > > > > I think we can workaround this problem by taking reference to the
> > > > > > > > > parent when the child is added, and then releasing it when the child
> > > > > > > > > is released, and in that way be guaranteed that the parent will not
> > > > > > > > > disappear before the child is fully released, but that still does not
> > > > > > > > > feel right. It feels more like the core is not doing it's job to me.
> > > > > > > > > The parent just should not be released before its children.
> > > > > > > > >
> > > > > > > > > Either I'm wrong about that, and we still should take the reference on
> > > > > > > > > the parent, or we revert my patch like Brendan proposed and then fix
> > > > > > > >
> > > > > > > > Either way, isn't it wrong to release the node ID before deleting the
> > > > > > > > sysfs entry? I am not sure that my fix was the correct one, but I
> > > > > > > > believe the bug that Heidi and I found is actually a bug.
> > > > > >
> > > > > > I agree.
> > > > > >
> > > > > > > > > the core with something like this (warning, I did not even try to
> > > > > > > > > compile that):
> > > > > > > >
> > > > > > > > I will try it out.
> > > > > > > >
> > > > > > > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > > > > > > index 83198cb37d8d..ec5774992337 100644
> > > > > > > > > --- a/lib/kobject.c
> > > > > > > > > +++ b/lib/kobject.c
> > > > > > > > > @@ -680,6 +680,12 @@ static void kobject_cleanup(struct kobject *kobj)
> > > > > > > > >                 kobject_uevent(kobj, KOBJ_REMOVE);
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > +       if (t && t->release) {
> > > > > > > > > +               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> > > > > > > > > +                        kobject_name(kobj), kobj);
> > > > > > > > > +               t->release(kobj);
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > >         /* remove from sysfs if the caller did not do it */
> > > > > > > > >         if (kobj->state_in_sysfs) {
> > > > > > > > >                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > > > > > > > @@ -687,12 +693,6 @@ static void kobject_cleanup(struct kobject *kobj)
> > > > > > > > >                 kobject_del(kobj);
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -       if (t && t->release) {
> > > > > > > > > -               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> > > > > > > > > -                        kobject_name(kobj), kobj);
> > > > > > > > > -               t->release(kobj);
> > > > > > > > > -       }
> > > > > > > > > -
> > > > > > > > >         /* free name if we allocated it */
> > > > > > > > >         if (name) {
> > > > > > > > >                 pr_debug("kobject: '%s': free name\n", name);
> > > > > > >
> > > > > > > Alright, so I tried it and it looks like Heikki's suggestion worked.
> > > > > > >
> > > > > > > Is everyone comfortable going this route?
> > > > > >
> > > > > > Hold on. Another way to fix the problem is to increment the parent's
> > > > > > reference count before that kobject_del(kobj) is called, and then
> > > > > > decrementing it after t->release(kobj) is called. It may be safer to
> > > > > > fix the problem like that.
> > > > >
> > > > > Right, this was your first suggestion above, right? That actually made
> > > > > more sense to me, but you seemed skeptical of it due to it being
> > > > > messier, which makes sense.
> > > > >
> > > > > Nevertheless, having children take a reference seems like the right
> > > > > thing to do because the children need to degregister themselves from
> > > > > the parent. Calling t->release() ahead of kobject_del() seems to
> > > > > reintroduce the problem that I pointed out, albeit *much* more
> > > > > briefly. If I understand correctly, it is always wrong to have a sysfs
> > > > > entry that points to a partially deallocated kobject. Please correct
> > > > > me if I am wrong.
> > > > >
> > > > > So I think there are two solutions: Either we have to ensure that each
> > > > > child is deallocated first so we can preserve the kobject_del() and
> > > > > then t->release() ordering, or we have to add some sort of "locking"
> > > > > mechanism to prevent the kobject from being accessed by anything other
> > > > > than the deallocation code until it is fully deallocated; well, it
> > > > > would have to prevent any access at all :-). I think it goes without
> > > > > saying that this "locking" idea is pretty flawed.
> > > > >
> > > > > The problem with just having children take a reference is that the
> > > > > kobject children already take a reference to their parent, so it seems
> > > > > like the kobject should be smart enough to deallocate children rather
> > > > > than having swnode have to keep a separate tally of children, no?
> > > > >
> > > > > Sorry if this all seems obvious, I am not an expert on this part of the kernel.
> > > > >
> > > > > > My example above proofs that there is the problem, but it changes the
> > > > > > order of execution which I think can always have other consequences.
> > > > > >
> > > > > > > Also, should I send this fix as a separate patch? Or do people want me
> > > > > > > to send an updated revision of my revert patch with the fix?
> > > > > >
> > > > > > This needs to be send in its own separate patch. Ideally it could be
> > > > > > send together with the revert in the same series, but I'm not sure
> > > > > > that's possible anymore. Didn't Greg pick the revert already?
> > > > >
> > > > > Sounds good.
> > > > >
> > > > > I did already let Greg know when he emailed us on backporting the
> > > > > patch to stable, and he acked saying he removed them. So as long as
> > > > > these are not in the queue for 5.6 (it is not in Linus' tree yet), we
> > > > > should be good.
> > > >
> > > > The reported bug is still noticed on Linux mainline master branch
> > > > The Kernel BUG noticed on x86_64 and i386 running selftest on Linux
> > > > mainline kernel 5.6.0.
> > >
> > > Oh sorry, I thought that this patch was dropped from the maintainer's
> > > for-next branch.
> > >
> > > Heikki, what do you think about my suggestion of having kobject
> > > deallocate its children?
> >
> > I'm not sure what was this suggestion?
> >
> > > In the meantime, are people cool with the patch that Heikki proposed
> > > as a temporary mitigation? I think my solution might be a bit more
> > > involved. If I don't hear anything back, I will send out Heikki's
> > > suggestion as a patch.
> >
> > Why not just take the reference to the parent like I proposed?
> >
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 83198cb37d8d..173046c423f8 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> >   */
> >  static void kobject_cleanup(struct kobject *kobj)
> >  {
> > +       struct kobject *parent = kobj->parent;
> >         struct kobj_type *t = get_ktype(kobj);
> >         const char *name = kobj->name;
> >
> > @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
> >                 kobject_uevent(kobj, KOBJ_REMOVE);
> >         }
> >
> > +       /* make sure the parent is not released before the (last) child */
> > +       kobject_get(parent)
> > +
> >         /* remove from sysfs if the caller did not do it */
> >         if (kobj->state_in_sysfs) {
> >                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
> >                 t->release(kobj);
> >         }
> >
> > +       kobject_put(parent);
> > +
> >         /* free name if we allocated it */
> >         if (name) {
> >                 pr_debug("kobject: '%s': free name\n", name);
>
> Ah, I think that will work. Sorry, I just thought that was a bit
> kludgy, but if you are okay with doing it that way, I think it will
> work.
>
> I will try it and send out a patch.

I think I am also going to send out a new test case, in a separate
patch of course, that exercises this logic. Kind of annoying having
the printf test catching this.
