Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB664533F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 06:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLGFJi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 00:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLGFJh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 00:09:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18315477F
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 21:09:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so8502707pfk.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 21:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cp5ETJqrHiYeFuGRnxKQskAPFmw24R1Q/UXHvZqZ/1M=;
        b=lB0Ys8xXH8tH632Sew02fiki9qGB/9NwBf9xBrSCxqmzCu0IoP2x7t5wXOYDpqE11d
         QpOab+YYbaWwwMiSzaX28q3+e9BC5Wx/drzZEkqvxw+QNX4V4qA/sKPl/juzuXZbyuQ7
         zvpg0FxcSH2CSJPfSNCISDBmESTYhaLLKL3vE6odPgB/QR2yKikuVRSActMx7xsD338G
         8Xc4sYP0AR6zI1f2qgfTLq7bR5KGOhmfkBeAFh2bodipGxg4Dp3loPt5jGsh/6edgMW2
         E/VayagUCT9nmF15fqLV0inBwCqmtWcs3e5nb/z+5U+yRLt72O9XxEmvbwPGDtFnCy9D
         0AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cp5ETJqrHiYeFuGRnxKQskAPFmw24R1Q/UXHvZqZ/1M=;
        b=vpDl7Qxq03z55gt48NN9lMtEjvqbc2N2Ig641/Ipq442gxtH7hQh12EDrDpfBXqb3X
         O07p2R3+Be8iDc30+H3/UevUYgK0TIMGoUUs0TvUQtGLgNBIVLPJ0x+T/lHOQ9r/9ujv
         4Iohuz3B72//Z891Jobyy0vh1yREuGiclIR8tI4DvTN4VBjwy3nX6E+Qdue2keBrm5ZN
         5wdaHTxFi06ZSuAddbEmAjkGgec1cZXmtzvzNn9IXuahu16FoEQIWpQ7AIURNaEO2aIq
         3K7mHrGAvywLGY8LDfIiyJq6q9tsI6aGfwhobruc7llTufGNZlHQyFVT8aTGsntQAFKc
         7Ekw==
X-Gm-Message-State: ANoB5pkkJf+QP26DF1p+ENeM2UiaAMA8/pXYCcLGHPRDcwYIFv4CVGWx
        lImPyVmKdEgjnuZCZf3LN5phWuo5a0yqJmYZpIqXrA==
X-Google-Smtp-Source: AA0mqf7Et/VLeZ5aIDMgiK8fgy8CIkxCZi3dHoTOg2e1YBUh5gq0elD3jqrAT94H+1ZHeMnc9mFzf1j9/i9S2TiZ7iw=
X-Received: by 2002:a62:1c49:0:b0:575:b4c0:f664 with SMTP id
 c70-20020a621c49000000b00575b4c0f664mr36432897pfc.56.1670389775190; Tue, 06
 Dec 2022 21:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20221207043319.1890954-1-davidgow@google.com>
In-Reply-To: <20221207043319.1890954-1-davidgow@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Wed, 7 Dec 2022 10:39:24 +0530
Message-ID: <CAO2JNKXtay6fkDvJkievhPypK+hAY=EsoJp1C9dxdpxhB54t+w@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Fix "How Do I Use This" / "Next
 Steps" sections
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 7, 2022 at 10:03 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The "How Do I Use This" section of index.rst and "Next Steps" section of
> start.rst were just copies of the table of contents, and therefore
> weren't really useful either when looking a sphinx generated output
> (which already had the TOC visible) or when reading the source (where
> it's just a list of files that ls could give you).
>
> Instead, provide a small number of concrete next steps, and a bit more
> description about what the pages contain.
>
> This also removes the broken reference to 'tips.rst', which was
> previously removed.
>
> Fixes: 4399c737a97d ("Documentation: kunit: Remove redundant 'tips.rst' page")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Thanks everyone for reviewing v1. Since this is pretty much a complete
> rewrite, I've left Reviewed-by tags off, as I don't feel the previous
> reviews totally apply. Feel free to review again if you have any
> comments.
>
> Cheers,
> -- David
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20221129094732.306449-1-davidgow@google.com/
> - Totally rewrite both sections to only include (and provide more
>   context for) the most concrete next steps.
>   - Thanks Bagas for pointing out that this basically duplicates the TOC
>     as-is.
>
This still looks good to me, thanks!

Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

> ---
>  Documentation/dev-tools/kunit/index.rst | 19 ++++++++-----------
>  Documentation/dev-tools/kunit/start.rst | 19 +++++++++----------
>  2 files changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index d5629817cd72..b3593ae29ace 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -99,14 +99,11 @@ Read also :ref:`kinds-of-tests`.
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
> +You can find a step-by-step guide to writing and running KUnit tests in
> +Documentation/dev-tools/kunit/start.rst
> +
> +Alternatively, feel free to look through the rest of the KUnit documentation,
> +or to experiment with tools/testing/kunit/kunit.py and the example test under
> +lib/kunit/kunit-example-test.c
> +
> +Happy testing!
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index f4f504f1fb15..224387a43543 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -294,13 +294,12 @@ Congrats! You just wrote your first KUnit test.
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
> +If you're interested in using some of the more advanced features of kunit.py,
> +take a look at Documentation/dev-tools/kunit/run_wrapper.rst
> +
> +If you'd like to run tests without using kunit.py, check out
> +Documentation/dev-tools/kunit/run_manual.rst
> +
> +For more information on writing KUnit tests (including some common techniques
> +for testing different things), see Documentation/dev-tools/kunit/usage.rst
> +
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221207043319.1890954-1-davidgow%40google.com.
