Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7189B1ADC52
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Apr 2020 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgDQLkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 07:40:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:29509 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730267AbgDQLkC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 07:40:02 -0400
IronPort-SDR: gOSgi6dyB2HIpaZ4iiiCka2axyLdwUgYFHVRdlHIsXgNrS7sibASaFZhpQoY+U+iW5tWZAtpYx
 FXmZkjNGaUoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 04:40:01 -0700
IronPort-SDR: oP0RLO0DDSPGTTioOXJpCXJ8YdMDAAAJUCRYNC+hjLaVGun12dGAjHLNZpbvsmG2nHw1KVzkMS
 GuXeyDqlKQ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="364307781"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Apr 2020 04:39:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 Apr 2020 14:39:56 +0300
Date:   Fri, 17 Apr 2020 14:39:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200417113956.GA3728594@kuha.fi.intel.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com>
 <20200415084653.GM2828150@kuha.fi.intel.com>
 <CAJZ5v0hNemTDVa_S-FfVMbrKjM-RWYoHh88asnUvTNxZinY2cw@mail.gmail.com>
 <20200415131018.GO2828150@kuha.fi.intel.com>
 <20200415133122.GB3461248@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415133122.GB3461248@kroah.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> > > An alternative might be to define something like __kobject_del() doing
> > > everything that kobject_del() does *without* the
> > > kobject_put(kobj->parent).
> > > 
> > > Then, kobject_del() could be defined as something like (pseudocode):
> > > 
> > > kobject_del(kobj)
> > > {
> > >     kobject *perent = kobj->parent;
> > > 
> > >     __kobject_del(kobj);
> > >     kobject_put(parent);
> > > }
> > > 
> > > and kobject_cleanup() could call __kobject_del() instead of
> > > kobject_del() and then do the last kobject_put(parent) when it is done
> > > with the child.
> > > 
> > > Would that work?
> > 
> > I think so. Greg, what do you think?
> 
> Hm, maybe.  Can someone test it out with the reproducer?

Brendan, or Randy! Can you guys test Rafael's proposal? I think it
would look like this:

diff --git a/lib/kobject.c b/lib/kobject.c
index 83198cb37d8d..2bd631460e18 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -599,14 +599,7 @@ int kobject_move(struct kobject *kobj, struct kobject *new_parent)
 }
 EXPORT_SYMBOL_GPL(kobject_move);
 
-/**
- * kobject_del() - Unlink kobject from hierarchy.
- * @kobj: object.
- *
- * This is the function that should be called to delete an object
- * successfully added via kobject_add().
- */
-void kobject_del(struct kobject *kobj)
+static void __kobject_del(struct kobject *kobj)
 {
        struct kernfs_node *sd;
        const struct kobj_type *ktype;
@@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
 
        kobj->state_in_sysfs = 0;
        kobj_kset_leave(kobj);
-       kobject_put(kobj->parent);
        kobj->parent = NULL;
 }
+
+/**
+ * kobject_del() - Unlink kobject from hierarchy.
+ * @kobj: object.
+ *
+ * This is the function that should be called to delete an object
+ * successfully added via kobject_add().
+ */
+void kobject_del(struct kobject *kobj)
+{
+       struct kobject *parent = kobj->parent;
+
+       __kobject_del(kobj);
+       kobject_put(parent);
+}
 EXPORT_SYMBOL(kobject_del);
 
 /**
@@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
  */
 static void kobject_cleanup(struct kobject *kobj)
 {
+       struct kobject *parent = kobj->parent;
        struct kobj_type *t = get_ktype(kobj);
        const char *name = kobj->name;
 
@@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
        if (kobj->state_in_sysfs) {
                pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
                         kobject_name(kobj), kobj);
-               kobject_del(kobj);
+               __kobject_del(kobj);
        }
 
        if (t && t->release) {
@@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
                pr_debug("kobject: '%s': free name\n", name);
                kfree_const(name);
        }
+
+       kobject_put(parent);
 }

 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE


thanks,

-- 
heikki
