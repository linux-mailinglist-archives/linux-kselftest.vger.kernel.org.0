Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DE623B09
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 05:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiKJErl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 23:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKJErj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 23:47:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA625E94
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 20:47:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so680841pgh.4
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Nov 2022 20:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sj8wNl0C9PC/zOv2XJt8nA/5SMVTgoTRqXcZ5Z4tzIk=;
        b=Gh8kF88uBhB9HnMImspkPpjsknFP9/ULBYIRZrBVgNeLP52LCYRPyQqxCqQOCwZYlC
         YALYtdSgRJ0qAVlU+fCj7rNgKmgqHN359Me6Xrb/g3AdKzC5gdLr2klBeJG/gP2UXl8Q
         sf/LSGN/sLnyc1p8CjugPgtCPZrldgiVo7hhI5VH77b3e2jHq0K/q7XsboB4zS9fSujO
         2I9VnKtPW1MIBGpb+fvE+sCEeIyC7GtAuithJcXjngPwURBbLqew3DoOHOhOK59p/Yc1
         7EUKj2ReFEhp2NclJa9Rc4p1HStOZ4UTD2L8LQtspvSW4dJihG0FdA/jM3MvuezCU7bz
         Evyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sj8wNl0C9PC/zOv2XJt8nA/5SMVTgoTRqXcZ5Z4tzIk=;
        b=goBko3tkep0/uIoD4k2oV52NTM5bKtcAupNsRw6OuldVVg6ACWgJb4TKyd8VEnAPMn
         uniDZ2u9wuysoa1yImh6QZNx3VOT9S96remX702SwLoGu7GMT7hiqUbrfjxzkN7EEwP4
         nrUcwuymjxvyYBeXMsyrhmYZFCq0lYUmrtoW6qw8oYoUmpTRUZqKeUbqO8HYv61KaMWu
         l0xz9zWh3Ef4FEek10bQl3SW5gXBlirSbWeTxysT1PDa+TboOdaE1KSWmzj5kVaH2+aa
         smZgAESFo6KcwI66keqqm4vQVeLxBUxwLq9zUTFytp87l10er4JUn7t20zjIl4PDp70p
         0qfQ==
X-Gm-Message-State: ACrzQf2ppzd4IuwkUMf0G34fTtKXZHAui4FIUq43LEirAPMiH3nTwu03
        8rYRLZFJ6vHOc3u99Yu5fl307eIFjtHmi3aaZcy9vw==
X-Google-Smtp-Source: AMsMyM52e4/tCYL5lYWN2KRPu0ZCHV+FC9Vtib9AbB/WFNG054nqHRmiS9UH70RBix7QF7qTnRR0HJAyWfOm/XGh1vI=
X-Received: by 2002:a63:d44c:0:b0:470:1a08:248d with SMTP id
 i12-20020a63d44c000000b004701a08248dmr1588270pgj.393.1668055657785; Wed, 09
 Nov 2022 20:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20221109003618.3784591-1-dlatypov@google.com>
In-Reply-To: <20221109003618.3784591-1-dlatypov@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Thu, 10 Nov 2022 10:17:26 +0530
Message-ID: <CAO2JNKUrTqn_2drc0k5nQH5DO+8uPG8MY7=+u8fkS4C9zvFphw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation: KUnit: make usage.rst a superset of
 tips.rst, remove duplication
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 9, 2022 at 6:06 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> usage.rst had most of the content of the tips.rst page copied over.
> But it's missing https://www.kernel.org/doc/html/v6.0/dev-tools/kunit/tips.html#customizing-error-messages
> Copy it over so we can retire tips.rst w/o losing content.
>
> And in that process, it also gained a duplicate section about how
> KUNIT_ASSERT_*() exit the test case early. Remove that.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks Daniel. This looks fine to me.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Best Regards,
Sadiya

>  Documentation/dev-tools/kunit/usage.rst | 49 ++++++++++++++++---------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 2737863ef365..b0a6c3bc0eeb 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -118,6 +118,37 @@ expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
>  to bail out of the test case if the appropriate conditions are not satisfied to
>  complete the test.
>
> +Customizing error messages
> +--------------------------
> +
> +Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG``
> +variant.  These take a format string and arguments to provide additional
> +context to the automatically generated error messages.
> +
> +.. code-block:: c
> +
> +       char some_str[41];
> +       generate_sha1_hex_string(some_str);
> +
> +       /* Before. Not easy to tell why the test failed. */
> +       KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
> +
> +       /* After. Now we see the offending string. */
> +       KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
> +
> +Alternatively, one can take full control over the error message by using
> +``KUNIT_FAIL()``, e.g.
> +
> +.. code-block:: c
> +
> +       /* Before */
> +       KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
> +
> +       /* After: full control over the failure message. */
> +       if (some_setup_function())
> +               KUNIT_FAIL(test, "Failed to setup thing for testing");
> +
> +
>  Test Suites
>  ~~~~~~~~~~~
>
> @@ -546,24 +577,6 @@ By reusing the same ``cases`` array from above, we can write the test as a
>                 {}
>         };
>
> -Exiting Early on Failed Expectations
> -------------------------------------
> -
> -We can use ``KUNIT_EXPECT_EQ`` to mark the test as failed and continue
> -execution.  In some cases, it is unsafe to continue. We can use the
> -``KUNIT_ASSERT`` variant to exit on failure.
> -
> -.. code-block:: c
> -
> -       void example_test_user_alloc_function(struct kunit *test)
> -       {
> -               void *object = alloc_some_object_for_me();
> -
> -               /* Make sure we got a valid pointer back. */
> -               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
> -               do_something_with_object(object);
> -       }
> -
>  Allocating Memory
>  -----------------
>
>
> base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
> --
> 2.38.1.431.g37b22c650d-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221109003618.3784591-1-dlatypov%40google.com.
