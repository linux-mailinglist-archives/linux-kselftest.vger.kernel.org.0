Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621151AA377
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506049AbgDONK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 09:10:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:53546 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504283AbgDONKZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 09:10:25 -0400
IronPort-SDR: gyTnjBNA8R3y/5mXi+2yUY6KqEQd4Is6AKxaYOV4aD3eJNYfSkJn49FSwbLK79F6pj//Yhpp5K
 kM9wPlNdeIfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 06:10:24 -0700
IronPort-SDR: R9aPDQqhW8bE+iyrhzMOLQ7KiXjLXMmRzQ6TZWEOdXM6PK+eecqc29weeKbLgq+fxMfoHPFBEb
 H5SehbGu+kIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="363666025"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Apr 2020 06:10:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Apr 2020 16:10:18 +0300
Date:   Wed, 15 Apr 2020 16:10:18 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] kobject: make sure parent is not released before
 children
Message-ID: <20200415131018.GO2828150@kuha.fi.intel.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com>
 <20200415084653.GM2828150@kuha.fi.intel.com>
 <CAJZ5v0hNemTDVa_S-FfVMbrKjM-RWYoHh88asnUvTNxZinY2cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hNemTDVa_S-FfVMbrKjM-RWYoHh88asnUvTNxZinY2cw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 11:21:03AM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 15, 2020 at 10:47 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Greg,
> >
> > On Wed, Apr 15, 2020 at 08:11:54AM +0200, Greg KH wrote:
> > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > index 83198cb37d8d..5921e2470b46 100644
> > > > --- a/lib/kobject.c
> > > > +++ b/lib/kobject.c
> > > > @@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> > > >   */
> > > >  static void kobject_cleanup(struct kobject *kobj)
> > > >  {
> > > > +   struct kobject *parent = kobj->parent;
> > > >     struct kobj_type *t = get_ktype(kobj);
> > > >     const char *name = kobj->name;
> > > >
> > > > @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
> > > >             kobject_uevent(kobj, KOBJ_REMOVE);
> > > >     }
> > > >
> > > > +   /* make sure the parent is not released before the (last) child */
> > > > +   kobject_get(parent);
> > > > +
> > > >     /* remove from sysfs if the caller did not do it */
> > > >     if (kobj->state_in_sysfs) {
> > > >             pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > > @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
> > > >             t->release(kobj);
> > > >     }
> > > >
> > > > +   kobject_put(parent);
> > > > +
> > >
> > > No, please don't do this.
> > >
> > > A child device should have always incremented the parent already if it
> > > was correctly registered.  We have had this patch been proposed multiple
> > > times over the years, and every time it was, we said no and went and
> > > fixed the real issue which was with the user of the interface.
> >
> > The parent ref count is incremented by the child, that is not the
> > problem. The problem is that when that child is released, if it's the
> > last child of the parent, and there are no other users for the parent,
> > then the parent is actually released _before_ the child. And that
> > happens in the above function kobject_cleanup().
> 
> In fact, it happens in kobject_del() invoked by kobject_cleanup() AFAICS.
> 
> So it appears incorrect to use kobject_del() as is in the latter.
> 
> > We can work around the problem by taking a reference to the parent
> > separately, but we have to do that everywhere separately (which I
> > guess is exactly what has been done so far). That workaroud still does
> > not really fix the core problem. The core problem is still that
> > lib/kboject.c is allowing the parent kobject to be released before the
> > child kobject, and that quite simply should not be allowed to happen.
> >
> > I don't have a problem if you want to have a better solution for this,
> > but the solution really can't anymore be that we are always expected
> > to separately increment the parent's ref count with every type of
> > kobject.
> 
> An alternative might be to define something like __kobject_del() doing
> everything that kobject_del() does *without* the
> kobject_put(kobj->parent).
> 
> Then, kobject_del() could be defined as something like (pseudocode):
> 
> kobject_del(kobj)
> {
>     kobject *perent = kobj->parent;
> 
>     __kobject_del(kobj);
>     kobject_put(parent);
> }
> 
> and kobject_cleanup() could call __kobject_del() instead of
> kobject_del() and then do the last kobject_put(parent) when it is done
> with the child.
> 
> Would that work?

I think so. Greg, what do you think?

thanks,

-- 
heikki
