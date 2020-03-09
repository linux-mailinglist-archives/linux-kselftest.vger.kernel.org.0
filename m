Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F717EA1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgCIUfg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 16:35:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38343 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIUfg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 16:35:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so4475774plz.5
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Mar 2020 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRk1pke9YTA7cKz/JhbTTwHB3/WLWvrK7Ig2WxoYgI8=;
        b=X/Ye0ndiT6/vRdYfa8lbznwxNncY7a4bxQhLjQFBDxsxTu/rRPSzWcz2h0sI9lmNuA
         hAsOCgP2jlB34NAGbuTpEtDK9cLWgSY9FunbCNYCgu8l5nhUPNcItCXxOQzONgIHkgQ2
         upyb1xJRUv/E1Kt80Uz0oG90aTJ09KRL6VP2NjwdgAnDeVoDBq/vrkkfFU2z3rOqbPjZ
         RqCX7nXl/mFiViARqSjbJdGsL2EY1L2h1SFwLo8ZXmUEC3LKMaD6Vg7bzWKZLW2QQNaM
         6hM23O96i1X7VrHAQpQQc2EfrTC0Hpfxx7BnPqPzjdJyvixCT1GTHKx0xlO5MFARX2gj
         VHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRk1pke9YTA7cKz/JhbTTwHB3/WLWvrK7Ig2WxoYgI8=;
        b=kmMZ83qv9gvE1hPwOBzWvN5G7OFn8SCBAfyTWuExGnCUYgwd15u5XolT//Vkn+bqNc
         xFZ2PZNM9TtOIu0RQTnQEcq+WCWwoXNv4WYmlE2/PBkqV+146rxgVj/a6UUT3lR9OK8k
         b+EjMDt2uAe0B3IewfVXpfyytvgvrW+bcnAibc9LdNEL8NP0essG1St01K2udGwdwDfg
         j0xpXFgxbePEhnj4I2M/SOvhItn+eVJXt8T32WP0WqetFXSfQWGmLz7OZtDdz4zlCqzk
         wfhAIZ7lrflNIGepehOQB2yHo+Ha4GjEJPoSv0yD1FGy2eXEdx+dPCVhEji5rMhpxdQH
         +HpQ==
X-Gm-Message-State: ANhLgQ1QivcC6mIiAhQdrt5K+PJhNfO5aSm5T1GSyy6HPu2tZR7Rfpqv
        2YhNQUbel/pBOO3hj+iQNo3F/fbg9U69I8xU4y5Xeg==
X-Google-Smtp-Source: ADFU+vuTyH584565MPNLkZHFudtSZ511Yzn6t9GqkWntGqhnAo7bwReMKNH0tmqTxBu0WOoLRryCBshsqZ+Lm8AbPrw=
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr9045912plt.232.1583786132922;
 Mon, 09 Mar 2020 13:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRZ9eCE29FjXkv1dQfrdGO3uWp4Tvkip5Z_jsgjVJeAQ@mail.gmail.com>
 <CAHp75VfhKoLtWkLHUyzg6m=rx833qiCVimWJVKU13qrX+aJz-Q@mail.gmail.com>
 <CAFd5g45GbSX1BkuaH=8639ESHi-MCGkpFhEZZpycm9=jQb93rg@mail.gmail.com>
 <CAFd5g47aaE+tGeHPrQmhfi6_nrvi1K4DvtRodh=zN21-uiQ1DQ@mail.gmail.com>
 <20200305223350.GA2852@mara.localdomain> <20200306120525.GC68079@kuha.fi.intel.com>
In-Reply-To: <20200306120525.GC68079@kuha.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 9 Mar 2020 13:35:22 -0700
Message-ID: <CAFd5g45c9L4BBRNtxtQf_NFr2bR6Wgt9uOHW86gzb6Ozeb0SBA@mail.gmail.com>
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

On Fri, Mar 6, 2020 at 4:05 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Mar 06, 2020 at 12:33:50AM +0200, Sakari Ailus wrote:
> > Hi Brendan,
> >
> > On Thu, Mar 05, 2020 at 11:51:20AM -0800, Brendan Higgins wrote:
> > > On Thu, Mar 5, 2020 at 11:40 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > On Thu, Mar 5, 2020 at 11:18 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > >
> > > > > +Cc: Sakari
> > > > >
> > > > > On Thu, Mar 5, 2020 at 6:00 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > > >
> > > > > > Regression reported on Linux next 5.6.0-rc4-next-20200305 on x86_64,
> > > > > > i386, arm and arm64. The steps to reproduce is running kselftests lib
> > > > > > printf.sh test case.
> > > > > > Which is doing modprobe operations.
> > > > > >
> > > > > > BTW, there are few RCU warnings from the boot log.
> > > > > > Please refer below link for more details.
> > > > > >
> > > > > > Steps reproduce by using kselftests,
> > > > > >
> > > > > >           - lsmod || true
> > > > > >           - cd /opt/kselftests/default-in-kernel/lib/
> > > > > >           - export PATH=/opt/kselftests/default-in-kernel/kselftest:$PATH
> > > > > >           - ./printf.sh || true
> > > > > >           - ./bitmap.sh || true
> > > > > >           - ./prime_numbers.sh || true
> > > > > >           - ./strscpy.sh || true
> > > > > >
> > > > > > x86_64 kernel BUG dump.
> > > > > > + ./printf.sh
> > > >
> > > > Oops, I am wondering if I broke this with my change "Revert "software
> > > > node: Simplify software_node_release() function"":
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d1c19322388d6935b534b494a2c223dd089e30dd
> > > >
> > > > I am still investigating, will update later.
> > >
> > > Okay, yeah, I am pretty sure I caused the breakage. I got an email
> > > from kernel test robot a couple days ago that I didn't see:
> > >
> > > https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/N3ZN5XH7HK24JVEJ5WSQD2SK6YCDRILR/
> > >
> > > It shows the same breakage after applying this change.
> > >
> > > I am still investigating how my change broke it, nevertheless.
> >
> > As nodes in the tree are being removed, the code before the patch that
> > "simplified" the software_node_release() function accessed the node's parent
> > in its release function.
> >
> > And if CONFIG_DEBUG_KOBJECT_RELEASE is defined, the release functions are no
> > longer necessarily called in order, leading to referencing released memory.
> > Oops!
> >
> > So Heikki's patch actually fixed a bug. :-)
>
> Well, I think it just hid the problem. It looks like the core
> (lib/kobject.c) allows the parent kobject to be released before the
> last child kobject is released. To be honest, that does not sound
> right to me...
>
> I think we can workaround this problem by taking reference to the
> parent when the child is added, and then releasing it when the child
> is released, and in that way be guaranteed that the parent will not
> disappear before the child is fully released, but that still does not
> feel right. It feels more like the core is not doing it's job to me.
> The parent just should not be released before its children.
>
> Either I'm wrong about that, and we still should take the reference on
> the parent, or we revert my patch like Brendan proposed and then fix

Either way, isn't it wrong to release the node ID before deleting the
sysfs entry? I am not sure that my fix was the correct one, but I
believe the bug that Heidi and I found is actually a bug.

> the core with something like this (warning, I did not even try to
> compile that):

I will try it out.

> diff --git a/lib/kobject.c b/lib/kobject.c
> index 83198cb37d8d..ec5774992337 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -680,6 +680,12 @@ static void kobject_cleanup(struct kobject *kobj)
>                 kobject_uevent(kobj, KOBJ_REMOVE);
>         }
>
> +       if (t && t->release) {
> +               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> +                        kobject_name(kobj), kobj);
> +               t->release(kobj);
> +       }
> +
>         /* remove from sysfs if the caller did not do it */
>         if (kobj->state_in_sysfs) {
>                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> @@ -687,12 +693,6 @@ static void kobject_cleanup(struct kobject *kobj)
>                 kobject_del(kobj);
>         }
>
> -       if (t && t->release) {
> -               pr_debug("kobject: '%s' (%p): calling ktype release\n",
> -                        kobject_name(kobj), kobj);
> -               t->release(kobj);
> -       }
> -
>         /* free name if we allocated it */
>         if (name) {
>                 pr_debug("kobject: '%s': free name\n", name);
>

Thanks!
