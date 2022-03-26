Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112564E7EB2
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 03:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiCZC5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 22:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCZC5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 22:57:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC42B8310
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 19:56:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so5395708wme.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TynyZqc/4qYH3QQJEa9xpYm0hZC5c9V8jy9QGxp1bo=;
        b=mRzDyt4+UdZfFT4LhWPuFUivrktYj8qmiUoEUwGBZlNBI+7EtAw28Oqqjwj5fsGZzz
         GT+0PaFan2KLy1ahEIcaebvZWoSi1JsaUgAFckesqWQPfKa46u2WfUCrjfN75lPrfrl1
         /ubo1t/wKjJ8EVGP0BLWA1fHmruLa6Y7IDgrCNfJgJtXqhPQ9MYMTHG3b1YB18dUlPeK
         Qv0Tp9/vWeSMXFUjSlXBEOngjAJFqSk0Ts+1BiA3mP0DK7i67jobEcoQn9KhZir6Bu/6
         Cw7qR+aaIdo+KdjuCpZjfEzJvCz0PBeCSbcoRFmzoPUDRGB6z1OD1L45uSNRpvIHYHis
         QW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TynyZqc/4qYH3QQJEa9xpYm0hZC5c9V8jy9QGxp1bo=;
        b=gy/hvkDmJ9mC9T5TTPwdn8IaZBB4Y65dYO/OMAhh5uwEQvdCfYRWlUQQg9Ybd68q2Q
         QTRXMgkQMf0eIVIggBWb0Z4d0n+w/CKKZDQfcbVWDmQO6g7DFrR1LCBTpZMyuvdodugr
         jyP64aqh8QDhz5KZP6if/dDVH8UBbFGUFohmfwCGb0soUZ73IX7Yudi5w+3OOLfIKHQA
         +zXM/Yf4nVNGd7piOcX1gShjtuw1R/oIjr9O0iPa0hr2qXnBIVy21dOAICtwyzPWw90o
         00JlQssDxHVPMhtMSVGP2Y37UewmOIvGMQptAweE0lZrzxnXfpFBi4NVK/7NU39sYeow
         jc8Q==
X-Gm-Message-State: AOAM532xnvLfySme/IHDEHtUGMYaoVaSJhvU1dHf7SKHN1Mc0isQP7ns
        Ir2Pfy+FndABo5URVKPMRLIM469PS6CJ+7vPCAMzog==
X-Google-Smtp-Source: ABdhPJx4k8LpNcsm7FBHINOia75/EV1DinirlBR+snxBcS4S+MJ5U0vstGN44DglnvIL9XcnVS3ZFtv2uG2PChELQTQ=
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id
 m8-20020a05600c4f4800b0038ca4600cb6mr13287038wmq.96.1648263372852; Fri, 25
 Mar 2022 19:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com>
In-Reply-To: <20220326003356.487828-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 26 Mar 2022 10:56:01 +0800
Message-ID: <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 26, 2022 at 8:34 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Recent changes have made it so the current set is not sufficient.
> Namely, CONFIG_DEBUG_INFO is not being set even when explicitly asked.
>
> Specifying a version of the debug info fixes this.
> Pick CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as an option that's
> hopefully less fragile (esp. given we're tied to GCC 6 and lower).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me. One idea below, but it's a bit subjective and I'm
fine with this going in as-is if you prefer.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- Daivd

>  Documentation/dev-tools/kunit/running_tips.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 7b6d26a25959..c36f6760087d 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -114,6 +114,7 @@ Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
>
>         CONFIG_DEBUG_KERNEL=y
>         CONFIG_DEBUG_INFO=y
> +       CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>         CONFIG_GCOV=y
>
>
> @@ -122,7 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
>  .. code-block:: bash
>
>         # Append coverage options to the current config
> -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
>         $ ./tools/testing/kunit/kunit.py run

Would we want to instead use a chain of --kconfig_add arguments? (I
think there are advantages either way...)


>         # Extract the coverage information from the build dir (.kunit/)
>         $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
>
> base-commit: b14ffae378aa1db993e62b01392e70d1e585fb23
> --
> 2.35.1.1021.g381101b075-goog
>
