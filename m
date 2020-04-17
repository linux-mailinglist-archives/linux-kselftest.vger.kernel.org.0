Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512B71AE1D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Apr 2020 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgDQQIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgDQQIT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 12:08:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D6C061A0C;
        Fri, 17 Apr 2020 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=sQLrPZSB292xgwYR3ECM5Xmr1WY3xujzeEDsJwOuSKk=; b=RGrzQRJQG0jA774P/2t+rp/Pnb
        VB13vmxbZKRTHp9y6xPbdxOkMBFZM9xMJwioP8UiTWMotWZ/Q8IDrAPxgc6SCQwqP+QEwqxF/QFEj
        1GthXpsRwlTNdCwQlFFEo3D1qacEidIuQ0CZSS/NrdS9QxgHQu3ehvWJnYsYsm1F+eDhnFp+ddvNd
        ba3q4rX3Qwva8+QxYVyu2Y0hKZAySU/CWK1pxdpvVZHN2euWqpEhoYQSMAEhQuCB5CBzHPQgPogiI
        vGWii6zH8k8aUHyC+Br/K7bJjYP515BFVwlBnQHu7epiGeF8yjOAtXarngabuyj0jBRGvzQyz7AHQ
        3xuADlYg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPTXK-0003s9-GV; Fri, 17 Apr 2020 16:08:14 +0000
Subject: Re: [PATCH v1] kobject: make sure parent is not released before
 children
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
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
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com>
 <20200415084653.GM2828150@kuha.fi.intel.com>
 <CAJZ5v0hNemTDVa_S-FfVMbrKjM-RWYoHh88asnUvTNxZinY2cw@mail.gmail.com>
 <20200415131018.GO2828150@kuha.fi.intel.com>
 <20200415133122.GB3461248@kroah.com>
 <20200417113956.GA3728594@kuha.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e946febc-a1d6-6392-bb00-bc6a65d93c5a@infradead.org>
Date:   Fri, 17 Apr 2020 09:08:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417113956.GA3728594@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/17/20 4:39 AM, Heikki Krogerus wrote:
> Hi,
> 
>>>> An alternative might be to define something like __kobject_del() doing
>>>> everything that kobject_del() does *without* the
>>>> kobject_put(kobj->parent).
>>>>
>>>> Then, kobject_del() could be defined as something like (pseudocode):
>>>>
>>>> kobject_del(kobj)
>>>> {
>>>>     kobject *perent = kobj->parent;
>>>>
>>>>     __kobject_del(kobj);
>>>>     kobject_put(parent);
>>>> }
>>>>
>>>> and kobject_cleanup() could call __kobject_del() instead of
>>>> kobject_del() and then do the last kobject_put(parent) when it is done
>>>> with the child.
>>>>
>>>> Would that work?
>>>
>>> I think so. Greg, what do you think?
>>
>> Hm, maybe.  Can someone test it out with the reproducer?
> 
> Brendan, or Randy! Can you guys test Rafael's proposal? I think it
> would look like this:

patch is whitespace-damaged. did you copy-paste it from a screen?


Anyway, it works for me. I loaded & unloaded test_printf.ko 5 times
without a problem.

Thanks.

> diff --git a/lib/kobject.c b/lib/kobject.c
> index 83198cb37d8d..2bd631460e18 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -599,14 +599,7 @@ int kobject_move(struct kobject *kobj, struct kobject *new_parent)
>  }
>  EXPORT_SYMBOL_GPL(kobject_move);
>  
> -/**
> - * kobject_del() - Unlink kobject from hierarchy.
> - * @kobj: object.
> - *
> - * This is the function that should be called to delete an object
> - * successfully added via kobject_add().
> - */
> -void kobject_del(struct kobject *kobj)
> +static void __kobject_del(struct kobject *kobj)
>  {
>         struct kernfs_node *sd;
>         const struct kobj_type *ktype;
> @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
>  
>         kobj->state_in_sysfs = 0;
>         kobj_kset_leave(kobj);
> -       kobject_put(kobj->parent);
>         kobj->parent = NULL;
>  }
> +
> +/**
> + * kobject_del() - Unlink kobject from hierarchy.
> + * @kobj: object.
> + *
> + * This is the function that should be called to delete an object
> + * successfully added via kobject_add().
> + */
> +void kobject_del(struct kobject *kobj)
> +{
> +       struct kobject *parent = kobj->parent;
> +
> +       __kobject_del(kobj);
> +       kobject_put(parent);
> +}
>  EXPORT_SYMBOL(kobject_del);
>  
>  /**
> @@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>   */
>  static void kobject_cleanup(struct kobject *kobj)
>  {
> +       struct kobject *parent = kobj->parent;
>         struct kobj_type *t = get_ktype(kobj);
>         const char *name = kobj->name;
>  
> @@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
>         if (kobj->state_in_sysfs) {
>                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
>                          kobject_name(kobj), kobj);
> -               kobject_del(kobj);
> +               __kobject_del(kobj);
>         }
>  
>         if (t && t->release) {
> @@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
>                 pr_debug("kobject: '%s': free name\n", name);
>                 kfree_const(name);
>         }
> +
> +       kobject_put(parent);
>  }
> 
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> 
> 
> thanks,
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
