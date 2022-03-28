Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE44E9C5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiC1Qhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbiC1Qhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 12:37:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D22562BEB
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:35:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c10so11445904ejs.13
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwMy4MS8C7C8gzFiov5E/LSR2ViwcR0jmdDA7SujYjA=;
        b=V9W9p+XtclEqC4lFHujJCkNAwvr5bva2d1hg/1VTScBm5oBPLzPiK3VsCCyvx08zUx
         NZ6jBVYBltF7IMRPsw06HicPiu2bZrTMncHWALY6o+w7I3rVU1UDuq6j9z3tgoTQZ60M
         2ta1I+R+U2ZmLZwFMPfujJkiSx77UtxZW+8TitpxnVeOHJf7kBh7+BIp12hz4QwQxzUD
         6YwNNBg5ZnRoUBTkiaxe2Jr/h2JrIv7i/BjwDguSo7NFqDxXgSM4jEZLdYWemQHKhFTf
         AC29a+2Z3imHt0PX97Ad7cGrg/OZUkTIdol67k36TgWkXGfDS0Gy6akREHGAi1UAnUZ7
         K4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwMy4MS8C7C8gzFiov5E/LSR2ViwcR0jmdDA7SujYjA=;
        b=XaVI0GyF5ZGDhfF4+ER8bAgHHgdDZju+9ZIce2Cf8kuR5iuZVT1u2eoTfMiTS0PvqP
         Byg95Rg/QWd4wVMpRfLquGGt5AmUvcqPeSll6igOaMgpDpnBwPy9uZ86Cb6QVevVTQO6
         ivR1quIVNcFn1LCCQ37yGuTD9wv3GLOaZmhuM3ww4RzVX66I7jShBnMuvvMluCUfSwGW
         mt54LcLsLFUbk9nN0GvfE95TIezld3lgZfDreK4ZgaMrznXjwTghlWTMtzBv4QoG3w2b
         KxOtxGH4uIJbRGP1RCIdppMKyfDSIbq+7rjBr9pnhz/SqAwUTBLTF3vEBevM+qw5cgXi
         aOKQ==
X-Gm-Message-State: AOAM530fdZinRJJL/d3RlFC4TVU8IDRa/xEg+7Rn5AfNrAuxRt6qVb15
        63+rvQ9JnYdOzgl9clbzNgmkhNo7Wn6Z6nz2idYijdWfpCMCdQ==
X-Google-Smtp-Source: ABdhPJzEQcYDp2/qHU9fvLW0LgXzV02XSswT1eH2SnbmaDayw4XPT0FotUGC3PnjMKmAHq3k3RMUGAyOA9Is8fS79Ts=
X-Received: by 2002:a17:907:1622:b0:6df:d1a2:d4a3 with SMTP id
 hb34-20020a170907162200b006dfd1a2d4a3mr27667302ejc.542.1648485347621; Mon, 28
 Mar 2022 09:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com> <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
In-Reply-To: <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Mar 2022 11:35:36 -0500
Message-ID: <CAGS_qxq_vFtGS4BGieZz8L3QH7rZ7ZN25pGYmjWWoXbTGOKC9A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     David Gow <davidgow@google.com>
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

On Fri, Mar 25, 2022 at 9:56 PM David Gow <davidgow@google.com> wrote:
>

<snip>

> >         # Append coverage options to the current config
> > -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> >         $ ./tools/testing/kunit/kunit.py run
>
> Would we want to instead use a chain of --kconfig_add arguments? (I
> think there are advantages either way...)

I've been considering this ever since the --kconfig_add patch was accepted.
It's more compatible w/ commands using --kunitconfig, but it also
looks very verbose.
E.g. it looks like

$ tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
--kconfig_add=CONFIG_DEBUG_INFO=y
--kconfig_add=CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
--kconfig_add=CONFIG_GCOV=y

Neither looks very appealing to me, so I've just kept it as-is for now.

Maybe there's something we can do to make this easier (e.g. allowing
--kunitconfig to be repeated and mergable)?
