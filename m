Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E401A8EB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 00:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgDNWjB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729629AbgDNWi7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 18:38:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D771AC061A0C;
        Tue, 14 Apr 2020 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=5JBZjn7sy5GQCd0bRK3Ru9SkD6beDun/x68fbss5o7E=; b=oU9Ij/oNfaefY44bgvBm5o1a42
        Mn5zWr00gZJ9EkND9EkEp2nxCWFvFaV/9qKVALtZXgm/Eig4RoJQkvJKw+AFTobpnVL0HyWA4mBLS
        zAFLTPuEbY0+spcUsStPCfNIkzTZOfeoP2FwBZe/Ngo0+dolVEixoQDCAIgvT3OemekSLJHidwlLD
        P57PeW6dktFb+AaN/HdnMcEGjzqU/1bX48hpcGLmtvwOg7niEhnKI0IW/XeXtqid23y0+U3i6uokN
        lDmiVU0kZLpIxVyHy96nItHc+mtlX/zY+LiyBguHJbZ1LHr/hCHlcsml8lEVW/yLcy1nsrX5feLUG
        Gxfz23Sw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOUCg-0005Kp-UP; Tue, 14 Apr 2020 22:38:51 +0000
Subject: Re: [PATCH v1] kobject: make sure parent is not released before
 children
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        sakari.ailus@linux.intel.com, andy.shevchenko@gmail.com,
        hdegoede@redhat.com, rafael.j.wysocki@intel.com,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        shuah@kernel.org, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org, linux@rasmusvillemoes.dk,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <71775e76-6175-d64b-0f4e-1beeb6b589b3@infradead.org>
Date:   Tue, 14 Apr 2020 15:38:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414204240.186377-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/20 1:42 PM, Brendan Higgins wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Previously, kobjects were released before the associated kobj_types;
> this can cause a kobject deallocation to fail when the kobject has
> children; an example of this is in software_node_unregister_nodes(); it
> calls release on the parent before children meaning that children can be
> released after the parent, which may be needed for removal.
> 
> So, take a reference to the parent before we delete a node to ensure
> that the parent is not released before the children.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Link: https://lore.kernel.org/linux-kselftest/CAFd5g44s5NQvT8TG_x4rwbqoa7zWzkV0TX+ETZoQdOB7OwXCPQ@mail.gmail.com/T/#m71f37f3985f2abd7209c8ca8e0fa4edc45e171d6
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Fixes the lib/test_printf.ko use-after-free on linux-next 20200410
that I reported last week.


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
>  	/* free name if we allocated it */
>  	if (name) {
>  		pr_debug("kobject: '%s': free name\n", name);
> 
> base-commit: 8632e9b5645bbc2331d21d892b0d6961c1a08429
> 

Thanks.
-- 
~Randy

