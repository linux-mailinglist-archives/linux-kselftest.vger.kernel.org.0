Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5E180984
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 21:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCJUqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 16:46:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36535 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgCJUqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 16:46:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id c7so1121669pgw.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Mar 2020 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHDyU6G/3PWCtvFuoOre6k3J3Ww9bHTi6I8bhr1RLW0=;
        b=tDPEiTZKCuFr5c8YQDWtpPPSo7JCZb7nKqNKQNeGP9nOeNUhC90ePx39hzySMLqK33
         QzIq0KL8ZRIeqbeB69KpcCB/RMTclqIJDfoRG0tobaaKa3nCqZHXSag47wP3cM53mHE9
         wjFx9vgpyPPGqS1xQjAq7xWXCiq1KdfE9+OPhd6FTtG3ypRW6f6l3mul4lcEF66DpTI7
         7n84nB29mXG0j8Stfr4L8H0zuvTkCXhA0s3QPsBzE6BsrCprl6n+K4Fu76Lap0hu23mt
         NHIONPSkJEJqLsIZZumc0N+JWzB88aTI705HtK0CPuUHIq2SzvribqanW8ct/ZwcCQnL
         ne+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHDyU6G/3PWCtvFuoOre6k3J3Ww9bHTi6I8bhr1RLW0=;
        b=tr6Q4/miQC0dlmcjeEn4qWNo+DdsT3XhuhI5amEsMTUhFiK4+7gfvRz7d8C/51/y8T
         Pf7O3rzlEfeK19sRz/caoLsagJ4Fk5pvdyXn0ApGupVKosq++c4asm6LpZRY6wxnu/TI
         BnY0Lca+NlTiCqp/yogK6lfcnPbLsMbmtI8QXoGEBxIHBika3tzluZf4CHFRsyY+SbN7
         h7S0T4eGL60fuAGbdG01twTcK/Pvl+Ff5Gg61Uufy9AMVkMl/6OuP2Jzg9bSrHxRZ5tA
         m8BT6wMO7HmMwfn06xKgsIotT1ybJNs6ThjyRuiBS1aOfzQ1DG1lmU2Xh/dN+OUiMzUl
         gnDA==
X-Gm-Message-State: ANhLgQ17Q8lJDEYJt93BWHPLr1mW8C55rrpjqm7PnYk1UIPBmlq29FDj
        29Rtx/mJ6qkg6Zn3y1jdhhzJN+WP/RbTMcjV3uea/w==
X-Google-Smtp-Source: ADFU+vtebrezbE+L8+EnJ9bmiGBw5xqzW3DLk2kpHmj22qMrFN+n/T0GaAX4j09XTTZS0PnyDxdBlWlsjMyndKyxUOI=
X-Received: by 2002:a63:650:: with SMTP id 77mr16283706pgg.201.1583873195939;
 Tue, 10 Mar 2020 13:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRZ9eCE29FjXkv1dQfrdGO3uWp4Tvkip5Z_jsgjVJeAQ@mail.gmail.com>
 <CAHp75VfhKoLtWkLHUyzg6m=rx833qiCVimWJVKU13qrX+aJz-Q@mail.gmail.com>
 <CAFd5g45GbSX1BkuaH=8639ESHi-MCGkpFhEZZpycm9=jQb93rg@mail.gmail.com>
 <CAFd5g47aaE+tGeHPrQmhfi6_nrvi1K4DvtRodh=zN21-uiQ1DQ@mail.gmail.com>
 <20200305223350.GA2852@mara.localdomain> <20200306120525.GC68079@kuha.fi.intel.com>
 <CAFd5g45c9L4BBRNtxtQf_NFr2bR6Wgt9uOHW86gzb6Ozeb0SBA@mail.gmail.com>
 <CAFd5g45cdygYfxGoCkk710tLXFADeLNb+6w-=vhkDMLP9OM7bw@mail.gmail.com> <20200310111837.GA1368052@kuha.fi.intel.com>
In-Reply-To: <20200310111837.GA1368052@kuha.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Mar 2020 13:46:24 -0700
Message-ID: <CAFd5g452sDMZToU+FDa-Odbkd_t1708gcRMAZQG+U4LnV=Xqgw@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00 - ida_free+0x76/0x140
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        hdegoede@redhat.com,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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

On Tue, Mar 10, 2020 at 4:18 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Mar 09, 2020 at 02:43:13PM -0700, Brendan Higgins wrote:
> > On Mon, Mar 9, 2020 at 1:35 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Fri, Mar 6, 2020 at 4:05 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > On Fri, Mar 06, 2020 at 12:33:50AM +0200, Sakari Ailus wrote:
> > > > > Hi Brendan,
> > > > >
> > > > > On Thu, Mar 05, 2020 at 11:51:20AM -0800, Brendan Higgins wrote:
> > > > > > On Thu, Mar 5, 2020 at 11:40 AM Brendan Higgins
> > > > > > <brendanhiggins@google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 5, 2020 at 11:18 AM Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > +Cc: Sakari
> > > > > > > >
> > > > > > > > On Thu, Mar 5, 2020 at 6:00 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Regression reported on Linux next 5.6.0-rc4-next-20200305 on x86_64,
> > > > > > > > > i386, arm and arm64. The steps to reproduce is running kselftests lib
> > > > > > > > > printf.sh test case.
> > > > > > > > > Which is doing modprobe operations.
> > > > > > > > >
> > > > > > > > > BTW, there are few RCU warnings from the boot log.
> > > > > > > > > Please refer below link for more details.
> > > > > > > > >
> > > > > > > > > Steps reproduce by using kselftests,
> > > > > > > > >
> > > > > > > > >           - lsmod || true
> > > > > > > > >           - cd /opt/kselftests/default-in-kernel/lib/
> > > > > > > > >           - export PATH=/opt/kselftests/default-in-kernel/kselftest:$PATH
> > > > > > > > >           - ./printf.sh || true
> > > > > > > > >           - ./bitmap.sh || true
> > > > > > > > >           - ./prime_numbers.sh || true
> > > > > > > > >           - ./strscpy.sh || true
> > > > > > > > >
> > > > > > > > > x86_64 kernel BUG dump.
> > > > > > > > > + ./printf.sh
> > > > > > >
> > > > > > > Oops, I am wondering if I broke this with my change "Revert "software
> > > > > > > node: Simplify software_node_release() function"":
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d1c19322388d6935b534b494a2c223dd089e30dd
> > > > > > >
> > > > > > > I am still investigating, will update later.
> > > > > >
> > > > > > Okay, yeah, I am pretty sure I caused the breakage. I got an email
> > > > > > from kernel test robot a couple days ago that I didn't see:
> > > > > >
> > > > > > https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/N3ZN5XH7HK24JVEJ5WSQD2SK6YCDRILR/
> > > > > >
> > > > > > It shows the same breakage after applying this change.
> > > > > >
> > > > > > I am still investigating how my change broke it, nevertheless.
> > > > >
> > > > > As nodes in the tree are being removed, the code before the patch that
> > > > > "simplified" the software_node_release() function accessed the node's parent
> > > > > in its release function.
> > > > >
> > > > > And if CONFIG_DEBUG_KOBJECT_RELEASE is defined, the release functions are no
> > > > > longer necessarily called in order, leading to referencing released memory.
> > > > > Oops!
> > > > >
> > > > > So Heikki's patch actually fixed a bug. :-)
> > > >
> > > > Well, I think it just hid the problem. It looks like the core
> > > > (lib/kobject.c) allows the parent kobject to be released before the
> > > > last child kobject is released. To be honest, that does not sound
> > > > right to me...
> > > >
> > > > I think we can workaround this problem by taking reference to the
> > > > parent when the child is added, and then releasing it when the child
> > > > is released, and in that way be guaranteed that the parent will not
> > > > disappear before the child is fully released, but that still does not
> > > > feel right. It feels more like the core is not doing it's job to me.
> > > > The parent just should not be released before its children.
> > > >
> > > > Either I'm wrong about that, and we still should take the reference on
> > > > the parent, or we revert my patch like Brendan proposed and then fix
> > >
> > > Either way, isn't it wrong to release the node ID before deleting the
> > > sysfs entry? I am not sure that my fix was the correct one, but I
> > > believe the bug that Heidi and I found is actually a bug.
>
> I agree.
>
> > > > the core with something like this (warning, I did not even try to
> > > > compile that):
> > >
> > > I will try it out.
> > >
> > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > index 83198cb37d8d..ec5774992337 100644
> > > > --- a/lib/kobject.c
> > > > +++ b/lib/kobject.c
> > > > @@ -680,6 +680,12 @@ static void kobject_cleanup(struct kobject *kobj)
> > > >                 kobject_uevent(kobj, KOBJ_REMOVE);
> > > >         }
> > > >
> > > > +       if (t && t->release) {
> > > > +               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> > > > +                        kobject_name(kobj), kobj);
> > > > +               t->release(kobj);
> > > > +       }
> > > > +
> > > >         /* remove from sysfs if the caller did not do it */
> > > >         if (kobj->state_in_sysfs) {
> > > >                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > > @@ -687,12 +693,6 @@ static void kobject_cleanup(struct kobject *kobj)
> > > >                 kobject_del(kobj);
> > > >         }
> > > >
> > > > -       if (t && t->release) {
> > > > -               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> > > > -                        kobject_name(kobj), kobj);
> > > > -               t->release(kobj);
> > > > -       }
> > > > -
> > > >         /* free name if we allocated it */
> > > >         if (name) {
> > > >                 pr_debug("kobject: '%s': free name\n", name);
> >
> > Alright, so I tried it and it looks like Heikki's suggestion worked.
> >
> > Is everyone comfortable going this route?
>
> Hold on. Another way to fix the problem is to increment the parent's
> reference count before that kobject_del(kobj) is called, and then
> decrementing it after t->release(kobj) is called. It may be safer to
> fix the problem like that.

Right, this was your first suggestion above, right? That actually made
more sense to me, but you seemed skeptical of it due to it being
messier, which makes sense.

Nevertheless, having children take a reference seems like the right
thing to do because the children need to degregister themselves from
the parent. Calling t->release() ahead of kobject_del() seems to
reintroduce the problem that I pointed out, albeit *much* more
briefly. If I understand correctly, it is always wrong to have a sysfs
entry that points to a partially deallocated kobject. Please correct
me if I am wrong.

So I think there are two solutions: Either we have to ensure that each
child is deallocated first so we can preserve the kobject_del() and
then t->release() ordering, or we have to add some sort of "locking"
mechanism to prevent the kobject from being accessed by anything other
than the deallocation code until it is fully deallocated; well, it
would have to prevent any access at all :-). I think it goes without
saying that this "locking" idea is pretty flawed.

The problem with just having children take a reference is that the
kobject children already take a reference to their parent, so it seems
like the kobject should be smart enough to deallocate children rather
than having swnode have to keep a separate tally of children, no?

Sorry if this all seems obvious, I am not an expert on this part of the kernel.

> My example above proofs that there is the problem, but it changes the
> order of execution which I think can always have other consequences.
>
> > Also, should I send this fix as a separate patch? Or do people want me
> > to send an updated revision of my revert patch with the fix?
>
> This needs to be send in its own separate patch. Ideally it could be
> send together with the revert in the same series, but I'm not sure
> that's possible anymore. Didn't Greg pick the revert already?

Sounds good.

I did already let Greg know when he emailed us on backporting the
patch to stable, and he acked saying he removed them. So as long as
these are not in the queue for 5.6 (it is not in Linus' tree yet), we
should be good.

Cheers
