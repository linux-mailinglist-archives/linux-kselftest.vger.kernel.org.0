Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6D6CF4F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjC2VC5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC2VC4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 17:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D8244B8
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680123728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/gAyKsbcYAmql6gQCi7mrnJqGJrh4mY0IHWHb0hHQw=;
        b=f8XeReDnQSpuWv2khRccnAaKDE267bAwaJZ1OmW8rUpedHdWC5tiThxd6fceVLDQhPztCr
        ogl1tRJb5aiwbjz9k7zMvrPleH0CiEuoK7bZjIlIodHlyIdvhKeDwnaA8+mMMespGB+F7r
        7VhkQbsTpQ+6iB1Eggye5TC3opIEUu0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-6pOOy8tVPTO31nvL98w-LQ-1; Wed, 29 Mar 2023 17:02:06 -0400
X-MC-Unique: 6pOOy8tVPTO31nvL98w-LQ-1
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a05640242d600b004f5962985f4so24391997edc.12
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 14:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680123725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/gAyKsbcYAmql6gQCi7mrnJqGJrh4mY0IHWHb0hHQw=;
        b=frcWW2Baqd+UgtRovnEueZNNI0L2OWQ7c6553qAgpelmyxxz4aUwoyQdBSiregvgFl
         0hlJSVwC91UiNWwMhrPGiK/GKnEpFc1ZLa/713+eDuCxgkt2hQokV/tqYYdnFUEN0sIK
         GPmQPLQjnLKo01tAT5/o+vrqP+FKnp6uThVJJ14fta3gkjo9NvQGX7aohsNuvlOeiBr4
         TyVpX2aEHoHFMlp88tMy5L0hy2E8BsPN20ZcRv5kJAvr+FTiA/qRe3tBE0ef1+6LYOwz
         Mh/pFF3DfJnQ+5eBHrt6SFnivg9geWGM6gmQ9At13xZbxXxVuI3KvGeLSd+yDHjxvd5Z
         BU8g==
X-Gm-Message-State: AAQBX9ci1M05pEqrSR1x+kviefNQgc3K/UCDiMn0Kyy/W/+KAynRdHrT
        1cMCIs0yrDbPOHDGvKLbi33NRnOiDbI8w2NX6CIPxVZfF/WkLLqFKCXeJ+fOiaWoeR3gHS/xT/u
        Gg3WoxEuJXjGZ3FhzOTI1JXSBJFvZwoG7P92uEqRoYxUH
X-Received: by 2002:a17:907:6b8e:b0:8d7:edbc:a7b6 with SMTP id rg14-20020a1709076b8e00b008d7edbca7b6mr2389702ejc.2.1680123725312;
        Wed, 29 Mar 2023 14:02:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350bkKECxx31XV8EMnzwJEVU3Yd1nzb4cO0O6UeSIu/Ml4eJoNDyaYddS+3Uog+NjNHQMdwgKioYSQo3s2ImtmpY=
X-Received: by 2002:a17:907:6b8e:b0:8d7:edbc:a7b6 with SMTP id
 rg14-20020a1709076b8e00b008d7edbca7b6mr2389691ejc.2.1680123725010; Wed, 29
 Mar 2023 14:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230329092332.2143623-1-javierm@redhat.com>
In-Reply-To: <20230329092332.2143623-1-javierm@redhat.com>
From:   Enric Balletbo i Serra <eballetb@redhat.com>
Date:   Wed, 29 Mar 2023 23:01:54 +0200
Message-ID: <CALE0LRupieFVeiH7J8DHEko0kyCRdBPavskQkcmZVN0ggATG6A@mail.gmail.com>
Subject: Re: [PATCH] Input: Add KUnit tests for some of the input core helper functions
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
        kunit-dev@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Javier,

Many thanks for the patch and to work on this.


On Wed, Mar 29, 2023 at 11:23=E2=80=AFAM Javier Martinez Canillas
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
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

I'll let other more experienced people comment on the kunit tests. In
my opinion it's a starting point and after applying your patch and
giving a try I can confirm that it works as expected, so just wanted
to give my.

Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>

Thanks,
  Enric

> ---
>
>  drivers/input/Kconfig            |  12 +++
>  drivers/input/Makefile           |   1 +
>  drivers/input/tests/Makefile     |   3 +
>  drivers/input/tests/input_test.c | 144 +++++++++++++++++++++++++++++++
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
> +static void input_test_timestamp(struct kunit *test)
> +{
> +       const ktime_t invalid_timestamp =3D ktime_set(0, 0);
> +       struct input_dev *input_dev =3D test->priv;
> +       ktime_t *timestamp, time;
> +       int ret;
> +
> +       timestamp =3D input_get_timestamp(input_dev);
> +       time =3D timestamp[INPUT_CLK_MONO];
> +
> +       ret =3D ktime_compare(time, invalid_timestamp);
> +       KUNIT_ASSERT_EQ(test, ret, 1);
> +
> +       time =3D ktime_get();
> +       input_set_timestamp(input_dev, time);
> +
> +       timestamp =3D input_get_timestamp(input_dev);
> +       KUNIT_ASSERT_EQ(test, ktime_compare(timestamp[INPUT_CLK_MONO],
> +                                           time), 0);
> +}
> +
> +static void input_test_match_device_id(struct kunit *test)
> +{
> +       struct input_dev *input_dev =3D test->priv;
> +       struct input_device_id id;
> +
> +       id.flags =3D INPUT_DEVICE_ID_MATCH_BUS;
> +       id.bustype =3D BUS_VIRTUAL;
> +       KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
> +
> +       id.bustype =3D BUS_I2C;
> +       KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
> +
> +       id.flags =3D INPUT_DEVICE_ID_MATCH_VENDOR;
> +       id.vendor =3D 1;
> +       KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
> +
> +       id.vendor =3D 2;
> +       KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
> +
> +       id.flags =3D INPUT_DEVICE_ID_MATCH_PRODUCT;
> +       id.product =3D 1;
> +       KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
> +
> +       id.product =3D 2;
> +       KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
> +
> +       id.flags =3D INPUT_DEVICE_ID_MATCH_VERSION;
> +       id.version =3D 1;
> +       KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
> +
> +       id.version =3D 2;
> +       KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
> +
> +       id.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT;
> +       __set_bit(EV_KEY, id.evbit);
> +       KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
> +
> +       __set_bit(EV_ABS, id.evbit);
> +       KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
> +}
> +
> +static struct kunit_case input_tests[] =3D {
> +       KUNIT_CASE(input_test_polling),
> +       KUNIT_CASE(input_test_timestamp),
> +       KUNIT_CASE(input_test_match_device_id),
> +       { /* sentinel */ }
> +};
> +
> +static struct kunit_suite input_test_suite =3D {
> +       .name =3D "input_core",
> +       .init =3D input_test_init,
> +       .exit =3D input_test_exit,
> +       .test_cases =3D input_tests,
> +};
> +
> +kunit_test_suite(input_test_suite);
> +
> +MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
> +MODULE_LICENSE("GPL");
>
> base-commit: 3a93e40326c8f470e71d20b4c42d36767450f38f
> --
> 2.40.0
>

