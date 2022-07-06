Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E59569355
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiGFUa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 16:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiGFUaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 16:30:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278A22B0A
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 13:30:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so29023480ejb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ome3WV2zqgpoz6nNvDZ5tdpmyA06nr+gyTTqL4RUa1Y=;
        b=dGPHJYDYBYSWeHXfrzUTPGHm+/9Y/wG6x2JFcNxydb3lhzUQmgBIVLXE/ATZjAODNt
         d8V4dc40KhU3cCopsYwoT9aRB2Goj8PqlcQrq56fSKI14AehA2DIPlCHp13fWgsLqrxI
         /BQRB1sc6ZzzdyFNaDuCffblFf0HHnyoLBskvSfV6XjU587xk2GEqp9eyHM3aHofwAQC
         zeAtesQVATHBqbRqvE5GuuyDqGLddl0FhlcjsB5j9T72bd7ZEc6oPApUY+SrcB9zjlZi
         zDxoMQIiYNb1muQd8Ize97vYw84eA7OpV3U07JBPbykqgkeGb4oeEdqeKBm6uWG3u6oD
         3sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ome3WV2zqgpoz6nNvDZ5tdpmyA06nr+gyTTqL4RUa1Y=;
        b=sT4dWK74y91uM8q3ZG2Nt+9rGMqHL6uPMf5q8Z9L/veFMzzXb6SpxM4Id5gNckJQE6
         hkjbz6sswqSyQli4lTI/lsMOJkpJ8+cqzXpgAhUb1Y6GoGVUv14PPESt64VMOA3o6zda
         74dKbBwmiODLVUlw/z41ET9oBqMfbPh7Q2CWoDEeS2uGuaJ5eHYnJ/7Cf5g+jnS4+SYi
         go0AeNED766S6KgGBcei4coR1qW6JBbnx2T9n1k7+jeuF0KdNNt2YVDnh+6vXHDoGWu3
         5uG43jN8OVV3BjlwLgvnA0NucR+EFuKhFlLA5rvCtFl3uNlTBDtaJxPH1NMeJdwZ4zd5
         +1DQ==
X-Gm-Message-State: AJIora89926HWZexgY2EzdXLdBtmCqtElGY+3gfadc8L8DEu/wNQHqK7
        R1OaMve92SP5Iqy8a48bxw0MrvWl/+MQq74nDiV7nA==
X-Google-Smtp-Source: AGRyM1v+7p/rqQVvu0vi9jgaIPa9wTC18p3aoE53Cy8xHxVk7Erhm3tAegYPdFtN0V0JhXWagYt5tPT8Riy5PA/gOzU=
X-Received: by 2002:a17:907:168c:b0:726:c521:25aa with SMTP id
 hc12-20020a170907168c00b00726c52125aamr40617053ejc.46.1657139423066; Wed, 06
 Jul 2022 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221446.82157-1-dlatypov@google.com> <20220627221446.82157-2-dlatypov@google.com>
In-Reply-To: <20220627221446.82157-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:30:11 -0400
Message-ID: <CAFd5g44AkBpQeNr2WMf3e=-bHuEree_vH2sj3+JnsbBp=mQgyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: tool: make --kunitconfig repeatable,
 blindly concat
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 27, 2022 at 6:14 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> It's come up a few times that it would be useful to have --kunitconfig
> be repeatable [1][2].
>
> This could be done before with a bit of shell-fu, e.g.
>   $ find fs/ -name '.kunitconfig' -exec cat {} + | \
>     ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin
> or equivalently:
>   $ cat fs/ext4/.kunitconfig fs/fat/.kunitconfig | \
>     ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin
>
> But this can be fairly clunky to use in practice.
>
> And having explicit support in kunit.py opens the door to having more
> config fragments of interest, e.g. options for PCI on UML [1], UML
> coverage [2], variants of tests [3].
> There's another argument to be made that users can just use multiple
> --kconfig_add's, but this gets very clunky very fast (e.g. [2]).
>
> Note: there's a big caveat here that some kconfig options might be
> incompatible. We try to give a clearish error message in the simple case
> where the same option appears multiple times with conflicting values,
> but more subtle ones (e.g. mutually exclusive options) will be
> potentially very confusing for the user. I don't know we can do better.
>
> Note 2: if you want to combine a --kunitconfig with the default, you
> either have to do to specify the current build_dir
> > --kunitconfig=.kunit --kunitconfig=additional.config
> or
> > --kunitconfig=tools/testing/kunit/configs/default.config --kunitconifg=additional.config
> each of which have their downsides (former depends on --build_dir,
> doesn't work if you don't have a .kunitconfig yet), etc.
>
> Example with conflicting values:
> > $ ./tools/testing/kunit/kunit.py config --kunitconfig=lib/kunit --kunitconfig=/dev/stdin <<EOF
> > CONFIG_KUNIT_TEST=n
> > CONFIG_KUNIT=m
> > EOF
> > ...
> > kunit_kernel.ConfigError: Multiple values specified for 2 options in kunitconfig:
> > CONFIG_KUNIT=y
> >   vs from /dev/stdin
> > CONFIG_KUNIT=m
> >
> > CONFIG_KUNIT_TEST=y
> >   vs from /dev/stdin
> > # CONFIG_KUNIT_TEST is not set
>
> [1] https://lists.freedesktop.org/archives/dri-devel/2022-June/357616.html
> [2] https://lore.kernel.org/linux-kselftest/CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com/
> [3] https://lore.kernel.org/linux-kselftest/CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
