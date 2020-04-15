Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9B1A92F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 08:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393488AbgDOGMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 02:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbgDOGL6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 02:11:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C0820737;
        Wed, 15 Apr 2020 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586931118;
        bh=6pe4+qaI7ju1Sn4wwK8IEsC+9CafQ0CfM86Yc2BJYys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMwl6bwrm7LYbjWQghiA1uHB2jlaKSVoPOoQ5oMcUlOV3jsvnLpwtWLt7yWEsFnKt
         LTT8/5ozJsp3O1QR6xEK9mUKJWHses15cO0jAi8TPYH1/mGVbDjSyIhxRm44YufI2S
         5fif3j2wUzVFn1B99967fEl3zbIQwCsIArdtX3jk=
Date:   Wed, 15 Apr 2020 08:11:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        naresh.kamboju@linaro.org, sakari.ailus@linux.intel.com,
        andy.shevchenko@gmail.com, hdegoede@redhat.com,
        rafael.j.wysocki@intel.com, linux-kselftest@vger.kernel.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, shuah@kernel.org,
        anders.roxell@linaro.org, lkft-triage@lists.linaro.org,
        linux@rasmusvillemoes.dk,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1] kobject: make sure parent is not released before
 children
Message-ID: <20200415061154.GA2496263@kroah.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414204240.186377-1-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 01:42:40PM -0700, Brendan Higgins wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Previously, kobjects were released before the associated kobj_types;
> this can cause a kobject deallocation to fail when the kobject has
> children; an example of this is in software_node_unregister_nodes(); it
> calls release on the parent before children meaning that children can be
> released after the parent, which may be needed for removal.

The simple solution for this is "don't do this" :)

> So, take a reference to the parent before we delete a node to ensure
> that the parent is not released before the children.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Link: https://lore.kernel.org/linux-kselftest/CAFd5g44s5NQvT8TG_x4rwbqoa7zWzkV0TX+ETZoQdOB7OwXCPQ@mail.gmail.com/T/#m71f37f3985f2abd7209c8ca8e0fa4edc45e171d6
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> 
> This patch is based on the diff written by Heikki linked above.
> 
> Heikki, can you either reply with a Signed-off-by? Otherwise, I can
> resend with me as the author and I will list you as the Co-developed-by.
> 
> Sorry for all the CCs: I just want to make sure everyone who was a party
> to the original bug sees this.
> 
> ---
>  lib/kobject.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 83198cb37d8d..5921e2470b46 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>   */
>  static void kobject_cleanup(struct kobject *kobj)
>  {
> +	struct kobject *parent = kobj->parent;
>  	struct kobj_type *t = get_ktype(kobj);
>  	const char *name = kobj->name;
>  
> @@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
>  		kobject_uevent(kobj, KOBJ_REMOVE);
>  	}
>  
> +	/* make sure the parent is not released before the (last) child */
> +	kobject_get(parent);
> +
>  	/* remove from sysfs if the caller did not do it */
>  	if (kobj->state_in_sysfs) {
>  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> @@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
>  		t->release(kobj);
>  	}
>  
> +	kobject_put(parent);
> +

No, please don't do this.

A child device should have always incremented the parent already if it
was correctly registered.  We have had this patch been proposed multiple
times over the years, and every time it was, we said no and went and
fixed the real issue which was with the user of the interface.

So, what code is causing this to happen?  What parent firmware device is
being removed that the code didn't walk the tree properly and remove the
children first?

thanks,

greg k-h
