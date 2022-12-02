Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3663FD58
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiLBAxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLBAxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:53:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9CC8D64E
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:53:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so6843636pjh.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Dec 2022 16:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyBUNma2/pYbDUwd0AEpCfAW8UmvTyVIMQbvVCIhkjM=;
        b=bVgUeTsrg8bzGvV93UtCv9XNcvszgWb7QAtIdDr7Me2tepgdsPs2kw+4W0Ika1rn3X
         dXkgt53D7jkEl0t6LV+LV8A6bjJdYd4q9LxE3xMmUp/ElJdVnmMkT+HbVKl+BcJQrYBP
         22wTub10PuwV0PKzdO/bFm+2lWgIWrEIiH/fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyBUNma2/pYbDUwd0AEpCfAW8UmvTyVIMQbvVCIhkjM=;
        b=czbYAGGIXq5sXrUPS2pGwm389b2W7jEqeQdBpe5I+g86r5EoSnREfdg40N55TIeZKV
         WSIAl52A+Fve6qRpNH1XN368IzHcV6rQ54aG5nmXQZatVEM1HR2My+L9bNwJ/whpAT5Y
         tZODyWf/IhxOJDcPbpNK47HMVDaR8OOVN2YLG4KWWIvwUpxtS2WXrd6c4sTyxWCF0TXb
         ryqhoxhDCx38IFBwwAS/7htp5CddmvKaRxDb3XuZFaOyQ/FpCSYvFHJg3rp36ptwutZ3
         vf+AjYmD37k48oeVl7lcuKLRZh/6ZViecw6g+hIohSWuXcCVMBjMB7lPliZm74UhvZiT
         NBQw==
X-Gm-Message-State: ANoB5plrqt+mNMo4wwmg0bvh1d59bEJj9ELd+TbLjKnZ8ByTOQ4hxZ3/
        oQ7ADPL2je2qFg6WA8dM8cMq3g==
X-Google-Smtp-Source: AA0mqf5kY7K6H1Eeevu9SIZH52BCxqvw1zVXLhAShSeJAlQdO1Y5eaWkEBpwalGdUhJ9r/q94Gifsw==
X-Received: by 2002:a17:902:a514:b0:189:97c3:6382 with SMTP id s20-20020a170902a51400b0018997c36382mr18353098plq.168.1669942388918;
        Thu, 01 Dec 2022 16:53:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9-20020a628309000000b00574de4a2fbasm3808867pfe.196.2022.12.01.16.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:53:07 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:53:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
Message-ID: <202212011652.4E8CB40@keescook>
References: <20221125084306.1063074-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125084306.1063074-1-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 25, 2022 at 04:43:04PM +0800, David Gow wrote:
> KUnit does a few expensive things when enabled. This hasn't been a
> problem because KUnit was only enabled on test kernels, but with a few
> people enabling (but not _using_) KUnit on production systems, we need a
> runtime way of handling this.
> 
> Provide a 'kunit_running' static key (defaulting to false), which allows
> us to hide any KUnit code behind a static branch. This should reduce the
> performance impact (on other code) of having KUnit enabled to a single
> NOP when no tests are running.
> 
> Note that, while it looks unintuitive, tests always run entirely within
> __kunit_test_suites_init(), so it's safe to decrement the static key at
> the end of this function, rather than in __kunit_test_suites_exit(),
> which is only there to clean up results in debugfs.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> ---
> This should be a no-op (other than a possible performance improvement)
> functionality-wise, and lays the groundwork for a more optimised static
> stub implementation.
> 
> The remaining patches in the series add a kunit_get_current_test()
> function which is a more friendly and performant wrapper around
> current->kunit_test, and use this in the slub test. They also improve
> the documentation a bit.
> 
> If there are no objections, we'll take the whole series via the KUnit
> tree.
> 
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20221119081252.3864249-1-davidgow@google.com/
> - Use DECLARE_STATIC_KEY_FALSE() -- thanks Daniel!
> 
> No changes since v2:
> https://lore.kernel.org/all/20221025071907.1251820-1-davidgow@google.com/
> 
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/
> - No changes in this patch.
> - Patch 2/3 is reworked, patch 3/3 is new.
> 
> ---
>  include/kunit/test.h | 4 ++++
>  lib/kunit/test.c     | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 4666a4d199ea..87ea90576b50 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -16,6 +16,7 @@
>  #include <linux/container_of.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> +#include <linux/jump_label.h>
>  #include <linux/kconfig.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -27,6 +28,9 @@
>  
>  #include <asm/rwonce.h>
>  
> +/* Static key: true if any KUnit tests are currently running */
> +DECLARE_STATIC_KEY_FALSE(kunit_running);
> +
>  struct kunit;
>  
>  /* Size of log associated with test. */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 1c9d8d962d67..87a5d795843b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -20,6 +20,8 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>  
> +DEFINE_STATIC_KEY_FALSE(kunit_running);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  /*
>   * Fail the current test and print an error message to the log.
> @@ -615,10 +617,14 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>  		return 0;
>  	}
>  
> +	static_branch_inc(&kunit_running);

Is it expected there will be multiple tests running? (I was expecting
"static_branch_enable").

> +
>  	for (i = 0; i < num_suites; i++) {
>  		kunit_init_suite(suites[i]);
>  		kunit_run_tests(suites[i]);
>  	}
> +
> +	static_branch_dec(&kunit_running);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
