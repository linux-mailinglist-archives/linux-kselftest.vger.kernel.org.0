Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE881A974D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895015AbgDOIrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 04:47:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:56295 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895009AbgDOIq7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 04:46:59 -0400
IronPort-SDR: Oe18Imx/71bJpDJYWK5nbi8LZ9xsC6/ceq+4iy7Ho2WWZIOMJucVuDEUINXeI5wmKM2jKBvjOl
 qVAzBGYwQmYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:46:58 -0700
IronPort-SDR: 3u20hooD25XQZI2V8xRYlsnfiBRb/6zG30Vc6mYtVCu8ifitQBI+BbTf0GsayPFQNB4mvD/KZu
 ufb2UKMyswdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="363615514"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Apr 2020 01:46:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Apr 2020 11:46:53 +0300
Date:   Wed, 15 Apr 2020 11:46:53 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20200415084653.GM2828150@kuha.fi.intel.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415061154.GA2496263@kroah.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

On Wed, Apr 15, 2020 at 08:11:54AM +0200, Greg KH wrote:
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 83198cb37d8d..5921e2470b46 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> >   */
> >  static void kobject_cleanup(struct kobject *kobj)
> >  {
> > +	struct kobject *parent = kobj->parent;
> >  	struct kobj_type *t = get_ktype(kobj);
> >  	const char *name = kobj->name;
> >  
> > @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
> >  		kobject_uevent(kobj, KOBJ_REMOVE);
> >  	}
> >  
> > +	/* make sure the parent is not released before the (last) child */
> > +	kobject_get(parent);
> > +
> >  	/* remove from sysfs if the caller did not do it */
> >  	if (kobj->state_in_sysfs) {
> >  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
> >  		t->release(kobj);
> >  	}
> >  
> > +	kobject_put(parent);
> > +
> 
> No, please don't do this.
> 
> A child device should have always incremented the parent already if it
> was correctly registered.  We have had this patch been proposed multiple
> times over the years, and every time it was, we said no and went and
> fixed the real issue which was with the user of the interface.

The parent ref count is incremented by the child, that is not the
problem. The problem is that when that child is released, if it's the
last child of the parent, and there are no other users for the parent,
then the parent is actually released _before_ the child. And that
happens in the above function kobject_cleanup().

We can work around the problem by taking a reference to the parent
separately, but we have to do that everywhere separately (which I
guess is exactly what has been done so far). That workaroud still does
not really fix the core problem. The core problem is still that
lib/kboject.c is allowing the parent kobject to be released before the
child kobject, and that quite simply should not be allowed to happen.

I don't have a problem if you want to have a better solution for this,
but the solution really can't anymore be that we are always expected
to separately increment the parent's ref count with every type of
kobject.


thanks,

-- 
heikki
