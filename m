Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3F63CE70
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 05:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiK3Epo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 23:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiK3Epj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 23:45:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBAB6F0C2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 20:45:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so781967pjs.4
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 20:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hp5+nokbDdYXmeHO6l8YHhyQIpP1MoZJd+AqChAXdY=;
        b=A7YLPBgwqI3LKlRDSIarExvCnxRY/Z/n/cUvePTHoIP7Cp08vix7ODXgQ26YFyzD7/
         uS6k8LHazIo+ZbSxlJ6uHZRhv49CiUsJDug0tglJV4shM8McXhzEOynKymIeIUUJOql+
         vTGcZgF4JcnkIJZucv2j8y+KxICagsaXvqvsO5x0sXpX7fGHcQJy9s2lIUWEnRZM6HSB
         LOKLyk4xagb9xSlZox0y2nyYB2DhARXzSTPlRjfxwqW4/r7QEVvPYEcSNer4HjYmLQ/p
         6zMUXACH2/R46EdPMBmKuqyk97kNBXRj9xTP7nTf1fF7MQTTH8bTeQGFkk9ssTVIiFks
         hrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Hp5+nokbDdYXmeHO6l8YHhyQIpP1MoZJd+AqChAXdY=;
        b=ve7aAHxu/6QhCaQ8VEGWj3mWQ7Gy69LvOaNJxIpn/9r6mcD0tz0PYgOInEkLTQDPVz
         zY/ocnk/UvlcY+wd8UpQu9T8/wrpIcFw3PJBOD8gK+JpFVoJDK2t/PVWyGBZcvrU4YFS
         lDyXdfU9OF9cEcRjMSihUU+pRlKvdgR+LK5LH1UeHoGPrmpsY+gUfl3xXbMXk21tw1my
         dUC3J7VzwIg1phNUxt6+3IiU41AkGfoVJoNj4I4nGC37uXQM0Y+PpS+JlL4MOpIs4cyx
         6rUMSk4Xycok2F0Rxrkutk7uhhMsNO4mOW2Yz2CVuC/e2b1H2jYDkOw9LAC/Y7fho/KK
         1qpw==
X-Gm-Message-State: ANoB5pkCTiZvJqTODnPCtLUwX/i1CKtf9anLcGJX3MRFeg4I82H2D/rM
        Elugf/jCOTDpajYUsE67u6flWzaH2wg7xJ7hJwH71Q==
X-Google-Smtp-Source: AA0mqf4Y/2dD9r4Ax34JaCVyP8lY70LEm6ZPf1Ide4lZgtW6pWmoThjhpN6O5PaVs7SLlSLu8QxOxQfuqvWgMSZ4NyE=
X-Received: by 2002:a17:90a:dc06:b0:218:9196:1cd1 with SMTP id
 i6-20020a17090adc0600b0021891961cd1mr56371277pjv.230.1669783536628; Tue, 29
 Nov 2022 20:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20221129094732.306449-1-davidgow@google.com>
In-Reply-To: <20221129094732.306449-1-davidgow@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Wed, 30 Nov 2022 10:15:25 +0530
Message-ID: <CAO2JNKU2jfdTMC2NXeyVdnE=nf5sQe8S7tvORUpbOgN-Ccx7RQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Fix "How Do I Use This" / "Next
 Steps" sections
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
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

Thank you David. This looks fine to me except for some very minor
suggestions below. Please feel free to ignore it if you do not agree.
Also, I can send out another patch to change the occurrences of
kunit_tool to kunit.py on run_wrapper.rst and run_manual.rst page to
maintain consistency across as they are referenced on index.rst and
start.rst.

Regards,
Sadiya


On Tue, Nov 29, 2022 at 3:17 PM David Gow <davidgow@google.com> wrote:
>
> The 'index' and 'start' pages end with very similar "How Do I Use This"
> / "Next Steps" sections respectively, which link to the other
> documentation pages. This wasn't updated when the tips.rst page was
> removed.
>
> Remove the reference to tips.rst, as well as tidy up the descriptions on
> all of the links (especially given that sphinx gives the page titles
> anyway.
>
> Fixes: 4399c737a97d ("Documentation: kunit: Remove redundant 'tips.rst' page")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kunit/index.rst | 18 +++++++-----------
>  Documentation/dev-tools/kunit/start.rst | 16 ++++++----------
>  2 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index d5629817cd72..beec6f847ef4 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -99,14 +99,10 @@ Read also :ref:`kinds-of-tests`.
>  How do I use it?
>  ================
>
> -*   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
> -*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
> -*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
> -*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
> -*   Documentation/dev-tools/kunit/usage.rst - write tests.
> -*   Documentation/dev-tools/kunit/tips.rst - best practices with
> -    examples.
> -*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
> -    used for testing.
> -*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
> -    answers.
> +*   Documentation/dev-tools/kunit/start.rst - for new KUnit users
How about - start using KUnit
> +*   Documentation/dev-tools/kunit/architecture.rst - how KUnit is put together
How about - get to know Kunit's design
> +*   Documentation/dev-tools/kunit/run_wrapper.rst - run tests via kunit.py
How about - run tests with kunit.py
> +*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit.py
How about - run tests without kunit.py
> +*   Documentation/dev-tools/kunit/usage.rst - write tests
> +*   Documentation/dev-tools/kunit/api/index.rst - API reference
> +*   Documentation/dev-tools/kunit/faq.rst - common questions and answers
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index f4f504f1fb15..58c176348885 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -294,13 +294,9 @@ Congrats! You just wrote your first KUnit test.
>  Next Steps
>  ==========
>
> -*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
> -*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
> -*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
> -*   Documentation/dev-tools/kunit/usage.rst - write tests.
> -*   Documentation/dev-tools/kunit/tips.rst - best practices with
> -    examples.
> -*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
> -    used for testing.
> -*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
> -    answers.
> +*   Documentation/dev-tools/kunit/architecture.rst - how KUnit is put together
same as above
> +*   Documentation/dev-tools/kunit/run_wrapper.rst - run tests via kunit.py
same as above
> +*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit.py
same as above
> +*   Documentation/dev-tools/kunit/usage.rst - write tests
> +*   Documentation/dev-tools/kunit/api/index.rst - API reference
> +*   Documentation/dev-tools/kunit/faq.rst - common questions and answers
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
