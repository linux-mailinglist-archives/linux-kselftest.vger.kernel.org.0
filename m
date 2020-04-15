Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340C1A9873
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 11:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgDOJVR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 05:21:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39380 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbgDOJVP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 05:21:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id 8so2690966oiy.6;
        Wed, 15 Apr 2020 02:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENUjVHSFzJbsMq60w+xL843S4EzRyzEe3gtRyR28J9s=;
        b=lyoKpCPaVHACix6JaO4Oj96be5CpdX+pSwk8Pco4B+UUCHz41NRkZ1VeIDKomy4dw5
         aUMvKoktzzO2lmQgnTh/JKj5s4cmqN7dNAVZDIKGKcRZm0UDI0OTSvgv8zWY+9stPX2Z
         TzvAtt7PT2g4HD3ahgma6nTtqR1MA0eUlqCkv7mfMEo4rEcaEQ4ROni6bGEEatEKx8pR
         wtZxgqrGwJyrglhsy9tnXlLFqKIKPXC5wPvB8YnyRSClmXCd6quS+n8459iwLDsuxe6v
         RfKcCNLDVHoDBumJbi3lBk5fNJWzOOsN8ta8BMZSQ/WaxmaTCUxjxEJXD6FWdUZjv8sb
         VUQQ==
X-Gm-Message-State: AGi0PuavEjvdoDffbbg1WtBv44JbaNLi8vZJTGZlMCLUU6Iku8ea3D1b
        Rueo+3tNoUHsH1V5Bs72dYyYaP9LoM0Xi94rh9Q=
X-Google-Smtp-Source: APiQypLTWr8XuYskhr44dR0bI+qedO3/+PH/UcHAaHnsqCHF0mVUYZiL79OBbyo/DWML3sV06die2E6qJn30gsERLA0=
X-Received: by 2002:a05:6808:81:: with SMTP id s1mr553605oic.68.1586942474204;
 Wed, 15 Apr 2020 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com> <20200415084653.GM2828150@kuha.fi.intel.com>
In-Reply-To: <20200415084653.GM2828150@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Apr 2020 11:21:03 +0200
Message-ID: <CAJZ5v0hNemTDVa_S-FfVMbrKjM-RWYoHh88asnUvTNxZinY2cw@mail.gmail.com>
Subject: Re: [PATCH v1] kobject: make sure parent is not released before children
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 10:47 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
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
> > > +   struct kobject *parent = kobj->parent;
> > >     struct kobj_type *t = get_ktype(kobj);
> > >     const char *name = kobj->name;
> > >
> > > @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
> > >             kobject_uevent(kobj, KOBJ_REMOVE);
> > >     }
> > >
> > > +   /* make sure the parent is not released before the (last) child */
> > > +   kobject_get(parent);
> > > +
> > >     /* remove from sysfs if the caller did not do it */
> > >     if (kobj->state_in_sysfs) {
> > >             pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> > > @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
> > >             t->release(kobj);
> > >     }
> > >
> > > +   kobject_put(parent);
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

In fact, it happens in kobject_del() invoked by kobject_cleanup() AFAICS.

So it appears incorrect to use kobject_del() as is in the latter.

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

An alternative might be to define something like __kobject_del() doing
everything that kobject_del() does *without* the
kobject_put(kobj->parent).

Then, kobject_del() could be defined as something like (pseudocode):

kobject_del(kobj)
{
    kobject *perent = kobj->parent;

    __kobject_del(kobj);
    kobject_put(parent);
}

and kobject_cleanup() could call __kobject_del() instead of
kobject_del() and then do the last kobject_put(parent) when it is done
with the child.

Would that work?
