Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7422A6CFABA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 07:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC3F24 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 01:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC3F2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 01:28:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41AF5BAF
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 22:28:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z19so17078989plo.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680154130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqVI8CoL+hm/7lSZW5GkB0l5kQIBCPwbwoQ7U3eg71s=;
        b=Ce5bVelcLjEUuy26UGZxkv3U6psA9wfsghPXPloY7QVJoaoy9wJm0UZi0mHHAFENxh
         q2ZNf6/tOTeBzNue4Z1RYFnP5lpcFPpIon6vJbeaQcWTaE6+Ez52gW4eUgJUoJ552Qx1
         BUhdt9zjhfzfROAzq2+f41aZSsT2hV6CqKqHtEpm4G634GMatHCsh7QDmP6g8PWaOgev
         5fBVnpROcp0HBNwBUQajxAp6Cnyq1xSyq71pajiKWkfMdJGd9nLbxglgA2pgLyydPu3d
         GD3iYROR1VuwZT1HAlD+FDc8TgU6EzjqF4ufP3hReRMFMkqbsDR/xk3oBfM/Uhav5AD2
         U6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680154130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqVI8CoL+hm/7lSZW5GkB0l5kQIBCPwbwoQ7U3eg71s=;
        b=lmUp1HzfPKJNoZIIbmcq3BL2bzMoeyBt8z+6qVBuxZ3H65PsN0ieJCuwMgUgWgeYVg
         ODoPtu3qRoL6q5NhELLKyVez6ZUuxKWSuy6gEq1Wa5sw49lkPGIEg/V1ef84nlrEjDiv
         wgKyjlgcPKSu8o69oiUGfMeXSoGlHN0v6p9MoRzMPtTyRWQLhzW6Kc7IjapYIiBxiQ5f
         9vgH1SfF2HhOxA4ls+1LebjHg/asjAnJcfYB/U8gwGp5jG65A3T3UXpIg9COJeBBqs9D
         FoJJJLwlcwM5f0KLMDYsv+jg229UXTTiSuYyI6Px8Lx9lZk38lxfHYC4xJRLqKq2ch/K
         2UVw==
X-Gm-Message-State: AAQBX9flKBh12eAR/3xChcUH6lZxoqZN2CWqiOp66RmClbq9vRUZmYIz
        5QQXsYjoigrsuk9iakk3rVMWZzpSSCPUf+Epp5Ot8A==
X-Google-Smtp-Source: AKy350b6ps0Rvhl5ZmokYglpnvFAca+Eck+gMmZYamR16d6R8+zxb8WbckccVzHIZcTozk9UBb4ZVcr4zWea2es0tT8=
X-Received: by 2002:a17:903:489:b0:1a2:8c7e:f325 with SMTP id
 jj9-20020a170903048900b001a28c7ef325mr239042plb.11.1680154130181; Wed, 29 Mar
 2023 22:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230329092332.2143623-1-javierm@redhat.com>
In-Reply-To: <20230329092332.2143623-1-javierm@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 29 Mar 2023 22:28:38 -0700
Message-ID: <CAGS_qxpEzXRWqy2Xd8qJn7GRxv+8HF40Lxt8esD-59CzeePZSw@mail.gmail.com>
Subject: Re: [PATCH] Input: Add KUnit tests for some of the input core helper functions
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kselftest@vger.kernel.org,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 29, 2023 at 2:23=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The input subsystem doesn't currently have any unit tests, let's add a
> CONFIG_INPUT_KUNIT_TEST option that builds a test suite to be executed
> with the KUnit test infrastructure.
>
> For now, only three tests were added for some of the input core helper
> functions that are trivial to test:
>
>   * input_test_polling: set/get poll interval and set-up a poll handler.
>
>   * input_test_timestamp: set/get input event timestamps.
>
>   * input_test_match_device_id: match a device by bus, vendor, product
>                                 and events that is capable of handling.
>
> But having the minimal KUnit support allows to add more tests and suites
> as follow-up changes. The tests can be run with the following command:
>
>   $ ./tools/testing/kunit/kunit.py run \
>     --kunitconfig=3Ddrivers/input/tests/.kunitconfig

Nice!
A few small suggestions below as someone who has worked on KUnit.

FYI, to save a few keystrokes, you can omit the "/.kunitconfig" and
just pass the dir, i.e.
  --kunitconfig=3Ddrivers/input/tests

>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/input/Kconfig            |  12 +++
>  drivers/input/Makefile           |   1 +
>  drivers/input/tests/Makefile     |   3 +
>  drivers/input/tests/input_test.c | 144 +++++++++++++++++++++++++++++++

I don't see the .kunitconfig in the diff.
Was it accidentally forgotten or does this patch apply to a tree that
already has the file?

(it's easy to forget since git will still ignore it by default, IIRC)

>  4 files changed, 160 insertions(+)
>  create mode 100644 drivers/input/tests/Makefile
>  create mode 100644 drivers/input/tests/input_test.c
>
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index e2752f7364bc..e094e5bbaa0c 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -166,6 +166,18 @@ config INPUT_EVBUG
>           To compile this driver as a module, choose M here: the
>           module will be called evbug.
>
> +config INPUT_KUNIT_TEST
> +       tristate "KUnit tests for Input" if !KUNIT_ALL_TESTS
> +       depends on INPUT && KUNIT=3Dy
> +       default KUNIT_ALL_TESTS
> +       help
> +         Say Y here if you want to build the KUnit tests for the input
> +         subsystem. For more information about KUnit and unit tests in
> +         general, please refer to the KUnit documentation in
> +         Documentation/dev-tools/kunit/.
> +
> +         If in doubt, say "N".

FYI, I know this is in the style guide, but I'd personally feel free
to leave out this paragraph.

Having such "advertising" about what KUnit is made more sense when
less people knew about it.
It's not known by everyone in the community yet, but we might be
getting to a point where this turns into repetitive bloat.

> +
>  config INPUT_APMPOWER
>         tristate "Input Power Event -> APM Bridge" if EXPERT
>         depends on INPUT && APM_EMULATION
> diff --git a/drivers/input/Makefile b/drivers/input/Makefile
> index 2266c7d010ef..c78753274921 100644
> --- a/drivers/input/Makefile
> +++ b/drivers/input/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_INPUT_JOYSTICK)  +=3D joystick/
>  obj-$(CONFIG_INPUT_TABLET)     +=3D tablet/
>  obj-$(CONFIG_INPUT_TOUCHSCREEN)        +=3D touchscreen/
>  obj-$(CONFIG_INPUT_MISC)       +=3D misc/
> +obj-$(CONFIG_INPUT_KUNIT_TEST) +=3D tests/
>
>  obj-$(CONFIG_INPUT_APMPOWER)   +=3D apm-power.o
>
> diff --git a/drivers/input/tests/Makefile b/drivers/input/tests/Makefile
> new file mode 100644
> index 000000000000..90cf954181bc
> --- /dev/null
> +++ b/drivers/input/tests/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_INPUT_KUNIT_TEST) +=3D input_test.o
> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input=
_test.c
> new file mode 100644
> index 000000000000..25bbf51b5c87
> --- /dev/null
> +++ b/drivers/input/tests/input_test.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the input core.
> + *
> + * Copyright (c) 2023 Red Hat Inc
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/input.h>
> +
> +#include <kunit/test.h>
> +
> +#define POLL_INTERVAL 100
> +
> +static int input_test_init(struct kunit *test)
> +{
> +       struct input_dev *input_dev;
> +       int ret;
> +
> +       input_dev =3D input_allocate_device();
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, input_dev);
> +
> +       input_dev->name =3D "Test input device";
> +       input_dev->id.bustype =3D BUS_VIRTUAL;
> +       input_dev->id.vendor =3D 1;
> +       input_dev->id.product =3D 1;
> +       input_dev->id.version =3D 1;
> +       input_set_capability(input_dev, EV_KEY, BTN_LEFT);
> +       input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
> +
> +       ret =3D input_register_device(input_dev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);

(very unlikely that this matters, but...)
Hmm, should we call input_free_device() if this fails?
i.e. something like

ret =3D ...;
if (ret) {
  input_free_device(input_dev);
  KUNIT_ASSERT_FAILURE(test, "failed to register device: %d", ret);
}

KUNIT_ASSERT_FAILURE() is like KUNIT_ASSERT_*(), but doesn't do any compari=
son.
It just unconditionally aborts the test after printing the given message.

We could alternatively do
  kunit_err(test, "failed to register device: %d", ret);
  return ret;
but this version won't show a file and line number.

> +
> +       test->priv =3D input_dev;
> +
> +       return 0;
> +}
> +
> +static void input_test_exit(struct kunit *test)
> +{
> +       struct input_dev *input_dev =3D test->priv;
> +
> +       input_unregister_device(input_dev);
> +}
> +
> +static void input_test_poll(struct input_dev *input) { }
> +
> +static void input_test_polling(struct kunit *test)
> +{
> +       struct input_dev *input_dev =3D test->priv;
> +       int ret;
> +
> +       ret =3D input_get_poll_interval(input_dev);
> +       KUNIT_ASSERT_EQ(test, ret, -EINVAL);

minor suggestion: can we inline these? E.g.
  KUNIT_ASSERT_EQ(test, -EINVAL, input_get_poll_interval(input_dev));
This way on failure, KUnit can print the function call instead of just `ret=
`.

Users could always find out what failed by the line #, but including
it in the output would be a bit nicer.

E.g. w/ KUNIT_EXPECT_EQ(test, 0, ...)

    # example_simple_test: EXPECTATION FAILED at
lib/kunit/kunit-example-test.c:29
    Expected 0 =3D=3D input_get_poll_interval(input_dev), but
        input_get_poll_interval(input_dev) =3D=3D 42 (0x2a)

verus

    # example_simple_test: EXPECTATION FAILED at
lib/kunit/kunit-example-test.c:28
    Expected ret =3D=3D 0, but
        ret =3D=3D 42 (0x2a)


> +
> +       ret =3D input_setup_polling(input_dev, input_test_poll);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       input_set_poll_interval(input_dev, POLL_INTERVAL);
> +
> +       ret =3D input_get_poll_interval(input_dev);
> +       KUNIT_ASSERT_EQ(test, ret, POLL_INTERVAL);
> +}
> +

Thanks,
Daniel
