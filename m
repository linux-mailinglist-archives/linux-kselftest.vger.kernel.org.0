Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E110D1A9F7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898097AbgDOMMx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 08:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898092AbgDOMMr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 08:12:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305DB206F9;
        Wed, 15 Apr 2020 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586952766;
        bh=igVI36iDNGRhuszqw7VerGu4dV6pg7haWxWetqUUod4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbxDMYJt+2Knxbi3gEES365lKDiULRU1vLt3mxZjhKYRcfGXgLr1M1bnmWblDVs7V
         qJTUIDnJjfgs7ZY9hoa7vz5G4S00yI27x7HYb8bnhpXnqCsv4+Y/mYq67tgEonmykL
         JdWR+RwSm8cFujgNjLBzfNhTTxw+4mNmSXSKcFsk=
Date:   Wed, 15 Apr 2020 14:12:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        sakari.ailus@linux.intel.com, andy.shevchenko@gmail.com,
        hdegoede@redhat.com, rafael.j.wysocki@intel.com,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        shuah@kernel.org, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH v1] kobject: make sure parent is not released before
 children
Message-ID: <20200415121238.GA3101727@kroah.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com>
 <20200415084653.GM2828150@kuha.fi.intel.com>
 <20200415092115.GA2565850@kroah.com>
 <20200415112503.GN2828150@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415112503.GN2828150@kuha.fi.intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 02:25:03PM +0300, Heikki Krogerus wrote:
> On Wed, Apr 15, 2020 at 11:21:15AM +0200, Greg KH wrote:
> > On Wed, Apr 15, 2020 at 11:46:53AM +0300, Heikki Krogerus wrote:
> > > Hi Greg,
> > > 
> > > On Wed, Apr 15, 2020 at 08:11:54AM +0200, Greg KH wrote:
> > > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > > index 83198cb37d8d..5921e2470b46 100644
> > > > > --- a/lib/kobject.c
> > > > > +++ b/lib/kobject.c
> > > > > @@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> > > > >   */
> > > > >  static void kobject_cleanup(struct kobject *kobj)
> > > > >  {
> > > > > +	struct kobject *parent = kobj->parent;
> > > > >  	struct kobj_type *t = get_ktype(kobj);
> > > > >  	const char *name = kobj->name;
> > > > >  
> > > > > @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
> > > > >  		kobject_uevent(kobj, KOBJ_REMOVE);
> > > > >  	}
> > > > >  
> > > > > +	/* make sure the parent is not released before the (last) child */
> > > > > +	kobject_get(parent);
> > > > > +
> > > > >  	/* remove from sysfs if the caller did not do it */
> > > > >  	if (kobj->state_in_sysfs) {
> > > > >  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > > > @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
> > > > >  		t->release(kobj);
> > > > >  	}
> > > > >  
> > > > > +	kobject_put(parent);
> > > > > +
> > > > 
> > > > No, please don't do this.
> > > > 
> > > > A child device should have always incremented the parent already if it
> > > > was correctly registered.  We have had this patch been proposed multiple
> > > > times over the years, and every time it was, we said no and went and
> > > > fixed the real issue which was with the user of the interface.
> > > 
> > > The parent ref count is incremented by the child, that is not the
> > > problem. The problem is that when that child is released, if it's the
> > > last child of the parent, and there are no other users for the parent,
> > > then the parent is actually released _before_ the child. And that
> > > happens in the above function kobject_cleanup().
> > > 
> > > We can work around the problem by taking a reference to the parent
> > > separately, but we have to do that everywhere separately (which I
> > > guess is exactly what has been done so far). That workaroud still does
> > > not really fix the core problem. The core problem is still that
> > > lib/kboject.c is allowing the parent kobject to be released before the
> > > child kobject, and that quite simply should not be allowed to happen.
> > > 
> > > I don't have a problem if you want to have a better solution for this,
> > > but the solution really can't anymore be that we are always expected
> > > to separately increment the parent's ref count with every type of
> > > kobject.
> > 
> > Why is this suddenly showing up as a issue and it hasn't ever before?
> > Because of that I would argue that the problem is not in the kobject
> > core, but the use of it.
> 
> The problem has showed up before, and you pointed that out yourself in
> your previous mail.
> 
> The thing is that we are going to continue to have this issue over and
> over again until the core issue is fixed.
> 
> > When a child object is created, it should have already incremented the
> > parent reference count before it is registered, to ensure that the
> > parent does not go away before the child is finished being registered.
> > Then, when the child is removed, it decrements the reference count of
> > the parent as it "knows" it is done with that pointer.
> 
> Please note that when you add a kobject, its parent ref count gets
> incremented (line 240 in lib/kobject.c). Are you saying here that that
> is actually not necessary, as the code that registers the new (child)
> kobject should _always_ be responsible of holding a reference to the
> parent? Because if that is the case, then we should actually cleanup
> lib/kboject.c and remove all parent reference handling. We obviously
> need to fix the documentation as well in this case.

Hm, no, I think the code is all correct as-is, with one exception that I
think you all are triggering now.

kobject_add() ends up incrementing the parent and then will properly
drop it when kobject_del() is called.

The issue is that kobject_cleanup() is only called when the memory of
the object needs to go away.  It has long been removed from sysfs
(hopefully, if not that's already handled in the call).

But, the parent could be gone here, as you all are seeing, so I think
the line:

       pr_debug("kobject: '%s' (%p): %s, parent %p\n",
                 kobject_name(kobj), kobj, __func__, kobj->parent);

Is causing the problem, as kobj->parent could be gone.  Well, it's not a
problem as that's just a pointer (odd call that one, should be fixed up
one day...)

But later on we try to call kobject_uevent() and that looks for the
parent in the fill_kobj_path() call, right?

Can someone provide a stack trace for the issue?  The patch here just
papers over the race condition, should we move the kobject_put() of the
parent into this function instead?

> > So perhaps this new swnode code is just wrong?  Dealing with "raw"
> > kobjects is hard, and not generally recommended due to issues like this.
> > When you use the driver core, all of this logic is already handled for
> > you...
> > 
> > And I just looked at the code swnode_register() needs to increment the
> > parent kobject's reference, as it is saving a pointer to it away to be
> > used later.  That's just basic reference-counted-pointer logic here,
> > please fix the issue there.
> 
> That is fair, however, it still does not fix the core problem.
> 
> Even if we did not need to save the pointer to the parent, we would
> still need to increment the parents reference count, because we have
> to prevent the parent from being released before us.
> 
> There are two ways we can fix the situation:
> 
> 1) We can make it clear that lib/kboject.c does not take any
>    responsibility over the reference counting of the parents, and
>    remove all the parent reference handling from it.
> 
> 2) We fix this by guaranteeing that the parent kboject can not be
>    released before its children.

I think 2 is the key here, and we used to do this, but something got
tweaked over the years with the kobject_cleanup() changes and the fact
that the driver core handles this already for us by incrementing the
parent and doing it in the correct order.

thanks,

greg k-h
