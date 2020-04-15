Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39971A9875
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408420AbgDOJVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 05:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405298AbgDOJVS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 05:21:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9CB20768;
        Wed, 15 Apr 2020 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586942477;
        bh=0zIrIYGU4YZzUsCcRWcNAZ9y7zWKPYfCHAgCLWK7wLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1kOvyWOkKrBt2dWPmJGa+IeML3i482ZhZNhxpmHODicI75ahW0n93JJXEP5E0fg1
         goktsU48PgKPVtA6I1ch2csn7uc8pRFEU6rwzeP/yFtdIM92NfPWcsXJXhko6Ox4I2
         gwfomh2q/BWCNJEJ1FeWelFmAK35i9c4Yq+h9WZE=
Date:   Wed, 15 Apr 2020 11:21:15 +0200
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
Message-ID: <20200415092115.GA2565850@kroah.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com>
 <20200415084653.GM2828150@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415084653.GM2828150@kuha.fi.intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 11:46:53AM +0300, Heikki Krogerus wrote:
> Hi Greg,
> 
> On Wed, Apr 15, 2020 at 08:11:54AM +0200, Greg KH wrote:
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index 83198cb37d8d..5921e2470b46 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> > >   */
> > >  static void kobject_cleanup(struct kobject *kobj)
> > >  {
> > > +	struct kobject *parent = kobj->parent;
> > >  	struct kobj_type *t = get_ktype(kobj);
> > >  	const char *name = kobj->name;
> > >  
> > > @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
> > >  		kobject_uevent(kobj, KOBJ_REMOVE);
> > >  	}
> > >  
> > > +	/* make sure the parent is not released before the (last) child */
> > > +	kobject_get(parent);
> > > +
> > >  	/* remove from sysfs if the caller did not do it */
> > >  	if (kobj->state_in_sysfs) {
> > >  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
> > >  		t->release(kobj);
> > >  	}
> > >  
> > > +	kobject_put(parent);
> > > +
> > 
> > No, please don't do this.
> > 
> > A child device should have always incremented the parent already if it
> > was correctly registered.  We have had this patch been proposed multiple
> > times over the years, and every time it was, we said no and went and
> > fixed the real issue which was with the user of the interface.
> 
> The parent ref count is incremented by the child, that is not the
> problem. The problem is that when that child is released, if it's the
> last child of the parent, and there are no other users for the parent,
> then the parent is actually released _before_ the child. And that
> happens in the above function kobject_cleanup().
> 
> We can work around the problem by taking a reference to the parent
> separately, but we have to do that everywhere separately (which I
> guess is exactly what has been done so far). That workaroud still does
> not really fix the core problem. The core problem is still that
> lib/kboject.c is allowing the parent kobject to be released before the
> child kobject, and that quite simply should not be allowed to happen.
> 
> I don't have a problem if you want to have a better solution for this,
> but the solution really can't anymore be that we are always expected
> to separately increment the parent's ref count with every type of
> kobject.

Why is this suddenly showing up as a issue and it hasn't ever before?
Because of that I would argue that the problem is not in the kobject
core, but the use of it.

When a child object is created, it should have already incremented the
parent reference count before it is registered, to ensure that the
parent does not go away before the child is finished being registered.
Then, when the child is removed, it decrements the reference count of
the parent as it "knows" it is done with that pointer.

So perhaps this new swnode code is just wrong?  Dealing with "raw"
kobjects is hard, and not generally recommended due to issues like this.
When you use the driver core, all of this logic is already handled for
you...

And I just looked at the code swnode_register() needs to increment the
parent kobject's reference, as it is saving a pointer to it away to be
used later.  That's just basic reference-counted-pointer logic here,
please fix the issue there.

thanks,

greg k-h
