Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CC759152
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGSJOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGSJOB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:14:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC919B4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:13:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so178605e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689758037; x=1690362837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8avoM1cp/AD9plDYRUlXqiJIDHdEBvE+NlQf6juyrzk=;
        b=a2cyPjxHqJjolGsvgQs6s6R4j73GaFvFpVoNoo6uMJVS5U8BmWQo7f5SU4uWgi6Stv
         BICBUbvRwlyNFYQyvxWmwlNm1iM5fvrv+m4bkzKgRrk9aUQof4oeCo5IGVir8+wevZ6h
         NcHMQ/MCXr89uolkbiXzbsau+oYio2njLDtElbjihFb86OUUSJDWfxTtJIGXssAviPVU
         Kf/6//pp5XO33zJW65AfvXi03VyyBIZuNAfOFi8RPAVKk16HO7I8WzzM9rVWFG+22sL2
         X5MUl/9gyI2s/QqHgr3shOxVY/onr/KaCzRR2S9mYR8i+SX1esJfRqJTleexalirAWoT
         B0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758037; x=1690362837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8avoM1cp/AD9plDYRUlXqiJIDHdEBvE+NlQf6juyrzk=;
        b=ZZPcLBnzUDPQc/aisuy6Ygqrmi8P6UsVatj3KUCnhQdAUhNKbgSZTOCbr0nMvS4lSo
         DwfKMOGBG3JgcEoCJ1jz0Qglg2tLM8tBHyOUVjcFKW36CUgYzHcO8cpKtugeoLABbB5K
         u+nD+ubu9Dvm4j4OAkd9BGOE/1z2u8ZxJPnV3Kv6lNrIT6o4ssstJmjoQeLQiL9wZjN9
         4fPdM4n1vGkI7iuT8o8KlbZecQsOmLJDKzj19SluQw9vNOYgE22YaSx8O8UaioZMtI/U
         XwII1SePd/hrRvUJ20dkAm2dBUi8HKo/jC3JIlsUS7xMPlhnw97FyLVHQZWuFKh8Pq3R
         lmdw==
X-Gm-Message-State: ABy/qLa9+IXP/9lnyi+wxxSQGqX0YU9b77ygvYToOimJ/CVhLyqXmRJ4
        p4vr1nXXOL9/CkA8iJ1NKmICpqfVQsTtM4djyiKmVQ==
X-Google-Smtp-Source: APBJJlHhm6pQjqfatWQlzJH7wPyTMyBC7Di50WQHUxvV3vm5yqOYn3YIOvsfhVv4xXAZu2qyl9PL0dXnOJuZKAe/tBE=
X-Received: by 2002:a05:600c:358d:b0:3f1:73b8:b5fe with SMTP id
 p13-20020a05600c358d00b003f173b8b5femr187675wmq.3.1689758037155; Wed, 19 Jul
 2023 02:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v2-1-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-1-19feb71e864b@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 17:13:45 +0800
Message-ID: <CABVgOSmUZw3CpzpduAjDx+eZCU5tm=5Pq8dyVt+d7oXb6-_h=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: base: Add basic devm tests for root devices
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000963e780600d37324"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000963e780600d37324
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jun 2023 at 17:49, Maxime Ripard <mripard@kernel.org> wrote:
>
> The root devices show some odd behaviours compared to regular "bus" devices
> that have been probed through the usual mechanism, so let's create kunit
> tests to exercise those paths and odd cases.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: David Gow <davidgow@google.com>

There's definitely an argument that root devices are not supposed to
be like regular devices, and so devm_ managed resources aren't
supposed to work with them. Either way:
- It needs to be documented somewhere (and this test makes for good
documentation, IMO).
- It should be consistent: if devm_ isn't to be used with root
devices, it should fail everywhere, and if it is, it should work in
all the cases below.

So I'm all in favour of including this test and making root devices work.

That being said, I am planning to send out a patchset adding a struct
kunit_device for use in tests, which will be attached to a "kunit"
bus. I think the combination of "fix devm_ with root devices" and
"don't recommend root devices as a 'fake' device for testing" is
probably the longer-term solution everyone can agree upon?

Cheers,
-- David


>  drivers/base/test/.kunitconfig       |   2 +
>  drivers/base/test/Kconfig            |   4 ++
>  drivers/base/test/Makefile           |   2 +
>  drivers/base/test/root-device-test.c | 110 +++++++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+)
>
> diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitconfig
> new file mode 100644
> index 000000000000..473923f0998b
> --- /dev/null
> +++ b/drivers/base/test/.kunitconfig
> @@ -0,0 +1,2 @@
> +CONFIG_KUNIT=y
> +CONFIG_DM_KUNIT_TEST=y
> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> index 610a1ba7a467..9d42051f8f8e 100644
> --- a/drivers/base/test/Kconfig
> +++ b/drivers/base/test/Kconfig
> @@ -9,6 +9,10 @@ config TEST_ASYNC_DRIVER_PROBE
>
>           If unsure say N.
>
> +config DM_KUNIT_TEST
> +       tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
> +       depends on KUNIT

Could we add "default KUNIT_ALL_TESTS" here? Or if there's a good
reason to not make this run by default, remove the "if
!KUNIT_ALL_TESTS" condition above.


> +
>  config DRIVER_PE_KUNIT_TEST
>         bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
>         depends on KUNIT=y
> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index 7f76fee6f989..d589ca3fa8fc 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)  += test_async_driver_probe.o
>
> +obj-$(CONFIG_DM_KUNIT_TEST)    += root-device-test.o
> +
>  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
>  CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
> new file mode 100644
> index 000000000000..9a3e6cccae13
> --- /dev/null
> +++ b/drivers/base/test/root-device-test.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2023 Maxime Ripard <mripard@kernel.org>
> +
> +#include <kunit/resource.h>
> +
> +#include <linux/device.h>
> +
> +#define DEVICE_NAME "test"
> +
> +struct test_priv {
> +       bool probe_done;
> +       bool release_done;
> +       wait_queue_head_t release_wq;
> +       struct device *dev;
> +};
> +
> +static int root_device_devm_init(struct kunit *test)
> +{
> +       struct test_priv *priv;
> +
> +       priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +       init_waitqueue_head(&priv->release_wq);
> +
> +       test->priv = priv;
> +
> +       return 0;
> +}
> +
> +static void devm_device_action(void *ptr)
> +{
> +       struct test_priv *priv = ptr;
> +
> +       priv->release_done = true;
> +       wake_up_interruptible(&priv->release_wq);
> +}
> +
> +#define RELEASE_TIMEOUT_MS     100
> +
> +/*
> + * Tests that a bus-less, non-probed device will run its device-managed
> + * actions when unregistered.
> + */
> +static void root_device_devm_register_unregister_test(struct kunit *test)
> +{
> +       struct test_priv *priv = test->priv;
> +       int ret;
> +
> +       priv->dev = root_device_register(DEVICE_NAME);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> +
> +       ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       root_device_unregister(priv->dev);
> +
> +       ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static void devm_put_device_action(void *ptr)
> +{
> +       struct test_priv *priv = ptr;
> +
> +       put_device(priv->dev);
> +       priv->release_done = true;
> +       wake_up_interruptible(&priv->release_wq);
> +}
> +
> +/*
> + * Tests that a bus-less, non-probed device will run its device-managed
> + * actions when unregistered, even if someone still holds a reference to
> + * it.
> + */
> +static void root_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
> +{
> +       struct test_priv *priv = test->priv;
> +       int ret;
> +
> +       kunit_skip(test, "This needs to be fixed in the core.");
> +
> +       priv->dev = root_device_register(DEVICE_NAME);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> +
> +       get_device(priv->dev);
> +
> +       ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       root_device_unregister(priv->dev);
> +
> +       ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static struct kunit_case root_device_devm_tests[] = {
> +       KUNIT_CASE(root_device_devm_register_unregister_test),
> +       KUNIT_CASE(root_device_devm_register_get_unregister_with_devm_test),
> +       {}
> +};
> +
> +static struct kunit_suite root_device_devm_test_suite = {
> +       .name = "root-device-devm",
> +       .init = root_device_devm_init,
> +       .test_cases = root_device_devm_tests,
> +};
> +
> +kunit_test_suite(root_device_devm_test_suite);
>
> --
> 2.40.0
>

--000000000000963e780600d37324
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBQ
5S2uzESpjVky3tM8utyU8gGedU62654v2GnL/oph2jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwOTEzNTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAe+vQAXo1w9dr+ugsPF2S
aFVYHHw7EHa4QDK+bzpTaUHlfAMqeLqESTsTl1XWtApAHrKcxAXuHN0uL/m9FVurcPwHHzv/lRGK
kIhoy0NIrLbBc6mgW13ULLx9NYKOiVcyjPjAuQ98Ovw1w8bs708uoYl9a49NZovUlgBDOAbYdRsI
PrZXFe/ftp2NVXaolcbgPCpIvODrSixhrD2lhLjHOVEPYtP+g1cIuZ8ZEUR9xzbF/BRWmZjO1hmG
2yq+HGlMyg55klcbn48WKHVylAeVC8qM9Zq9pIYTkAgnnF9DG7F0OMmcDpOXYyQvdWIvGRWqTSDg
pG1vMuT93A5WZoVabw==
--000000000000963e780600d37324--
