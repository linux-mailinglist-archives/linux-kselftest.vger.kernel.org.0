Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B940E6376AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKXKnh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXKng (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 05:43:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3AC654F;
        Thu, 24 Nov 2022 02:43:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mv18so1104718pjb.0;
        Thu, 24 Nov 2022 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7o+Q8FQkVVgAzFcN2NLb4oct6J+vhahcI9ZllaC/xc=;
        b=ENsiMTLYW6pY+TXqiwMe9yAzE7xIxAHAvYojejnnesfbaPTF5du1evCp+LELcqgtMr
         wzilBepNEBUOE7+O4lTmQfemPvWz3bxjj2Hl/O3Pwwj2kOc5dvKQ1ZVhLe+ymVFQ/BO+
         E1k/tmWy3r+gFaGtbElSPzOj1d5t7Q71hPD2JiwwNhtDYNbtp8Tmnd1q1j7d+mrS0UVr
         Tds3ILmu6Ow78KSNg4dgQGC3ZAIIEqeZmGTyBSTywL39zfkxGP4v3IKoxi++qshC4Pu7
         N+aaSzPH80DmRqy9UhgaQI9g4OBKiTCY/JCx3rrQTZMw/+2lx/yiD5mumTi2kUSQAXqV
         RnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7o+Q8FQkVVgAzFcN2NLb4oct6J+vhahcI9ZllaC/xc=;
        b=nv9+Y2sixytkR4+d8u2Lp/CYmrNr/n8KAp/4GnAkRRJF249CJvLmFk/zMP7TueS/69
         jlD/2qUVn9LikDCAorz46X0vGV7DsSgChxpaEsxhPoSdaEquu1NoPmphLC7xPXh2gT+o
         0lgLjG5QGUvWV3e88taFdW5y+aASB2JoC2aBA4wJiw+xJ2lwby5pQdUDushnzPX32Uic
         DDMALV1vTjSCM2hCtb7a55CO9WRQmckeQqptfSsdaID2lDsICuR04gqo48KNkJZTQUmP
         18GFPYVE13mIuWhWqx+LIQGfWFmXEObkZIbaHyX8dJxVIRts6Adr62jbgmlntDzK7hSx
         Nw0A==
X-Gm-Message-State: ANoB5pkpF5h/wi+VMA3goboxT5z51NasJloT0JhBenTIXfITXV+ABkK3
        cmDszFPYN0SlHiZ8bFM5iXk=
X-Google-Smtp-Source: AA0mqf7c9YI5PVHpS7E9uLy+27+srHAfhZGrYwmsFfYo8ZR+kxjl6k3hhHGTmywFRno2JGEJ9BHXPQ==
X-Received: by 2002:a17:90a:2b0e:b0:20b:cd9:be6d with SMTP id x14-20020a17090a2b0e00b0020b0cd9be6dmr21891498pjc.198.1669286614949;
        Thu, 24 Nov 2022 02:43:34 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b00185402cfedesm924727plr.246.2022.11.24.02.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:43:34 -0800 (PST)
Date:   Thu, 24 Nov 2022 19:43:27 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/3] mm: slub: test: Use the kunit_get_current_test()
 function
Message-ID: <Y39Kz0hI3IOKoqrJ@hyeyoo>
References: <20221119081252.3864249-1-davidgow@google.com>
 <20221119081252.3864249-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119081252.3864249-3-davidgow@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 19, 2022 at 04:12:52PM +0800, David Gow wrote:
> Use the newly-added function kunit_get_current_test() instead of
> accessing current->kunit_test directly. This function uses a static key
> to return more quickly when KUnit is enabled, but no tests are actively
> running. There should therefore be a negligible performance impact to
> enabling the slub KUnit tests.
> 
> Other than the performance improvement, this should be a no-op.
> 
> Cc: Oliver Glitta <glittao@gmail.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
with small comment:

> ---
> 
> This is intended as an example use of the new function. Other users
> (such as KASAN) will be updated separately, as there would otherwise be
> conflicts.
> 
> We'll take this whole series via the kselftest/kunit tree.
> 
> Changes since v2:
> https://lore.kernel.org/all/20221025071907.1251820-3-davidgow@google.com/
> - Get rid of a redundant 'likely' (Thanks Vlastimil Babka)
> - Use current->kunit_test directly when we already know a test is
>   running. (Thanks Vlastimil Babka)
> - Add Vlastimil's Acked-by.
> 
> There was no v1 of this patch. v1 of the series can be found here:
> https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/T/#u
> 
> Cheers,
> -- David
> 
> ---
>  lib/slub_kunit.c | 1 +
>  mm/slub.c        | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 7a0564d7cb7a..8fd19c8301ad 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>

Is this #include needed in slub_kunit.c?

>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..1887996cb703 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -39,6 +39,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>  #include <linux/sort.h>
>  
>  #include <linux/debugfs.h>
> @@ -603,7 +604,7 @@ static bool slab_add_kunit_errors(void)
>  {
>  	struct kunit_resource *resource;
>  
> -	if (likely(!current->kunit_test))
> +	if (!kunit_get_current_test())
>  		return false;
>  
>  	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 

-- 
Thanks,
Hyeonggon
