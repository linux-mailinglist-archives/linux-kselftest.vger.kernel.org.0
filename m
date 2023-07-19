Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559C5759154
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGSJOJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGSJOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:14:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C5173B
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:14:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so178645e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689758043; x=1690362843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R9rG06RzODNts0epU6EHFd0/na7jafJXdbhHmRghUgg=;
        b=t6jcis/mn8Eqx9+EnBaKleFiq4W22tpDEJCwkWKaW2Jv0ev0nIs3etKMnoOXJ8ufUb
         AhATadobU6s9pQ0AJxJatc/UBhqeM3Dt0065rqMC2eq6zGa/VOQYm9hxm414VQ8Z5pus
         KfmDzeK/5Ys1/PZgBBCF83AEJ9SeWfvhMmCgfi+P0HmSQv0mEnHlESuFHa4Y0LnnOaEu
         2MLhRN3rkKpstYL2b3kMEQOvgWKXAF4OMXIkpxytpsX2gC6QwWLJtj5PMhPDTK/QIUKu
         nZI9i29H1AM0K0+D/QfsiqO/PyytcuBpizKg0qhp5Qs7/X9Tfy/2p35IbpI3HhygaL/f
         0Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758043; x=1690362843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9rG06RzODNts0epU6EHFd0/na7jafJXdbhHmRghUgg=;
        b=GWINdrkaDmCDrp3zFS3WhSAr0QjUsCGlmuJ2usBvPQr/uznJJN+qXiab/CKyc66Xui
         6HMdvyXkxdb2xEejLx0SPTVI3IWVgmsvY+nyBOKtJbMD8a5qyy4s609lgsx2kqrG1Wva
         JNA42yJwgxVNwYcwP3bmnYXa2v/wcV6/CPU9IZdvr7w44hD1c6KVz5bp0D8Rq1t02pG/
         UszvTdbwZgwBqFHqamaNZuCCZBAisfq68sCykDyXSGVttiby5ljovoPLHoAjH0UqoXFa
         Gzp5bFkKx1u4yYLWpfgxKDE0YSiYqi5s7JJeLEUgFQ8KN4jmFIo6lxOfjpAnYu5cpm+7
         8ypw==
X-Gm-Message-State: ABy/qLYm+78F6RgTA6vJiuxcJQNewOMyJWL/AjFbNGb9rNP8jMmN3dIT
        nLUGWZ3pekd+UTBwGxMUEtDYdN5dY3pK5eFRWSvKPQ==
X-Google-Smtp-Source: APBJJlErVMWAHJ5hRJz/s+G0tC3rsLepbHIzGVEk7KaTlciwjVbzjgOH8pjL2QKEUHv1iEQ4diirpXUAOjJ7PzOUBPo=
X-Received: by 2002:a05:600c:3ac5:b0:3f7:e463:a0d6 with SMTP id
 d5-20020a05600c3ac500b003f7e463a0d6mr215209wms.0.1689758042877; Wed, 19 Jul
 2023 02:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v2-2-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-2-19feb71e864b@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 17:13:50 +0800
Message-ID: <CABVgOS=-LCKpevBNO6SSBYXLAURa5AxXr34gOdt2xZSL+FwoXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drivers: base: Add basic devm tests for platform devices
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ebd9460600d37381"
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

--000000000000ebd9460600d37381
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jun 2023 at 17:49, Maxime Ripard <mripard@kernel.org> wrote:
>
> Platform devices show some inconsistencies with how devm resources are
> released when the device has been probed and when it hasn't. Let's add a
> few tests to exercise thos paths and odd cases.

Nit: "these".

Also, it'd be nice to call out the case that fails explicitly in the
commit message here, so it's obvious what the "inconsistency" is.

>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

This looks good to me. I think this is, if anything, even more
obviously important than the root device issues, so we definitely need
to fix or document it.

Reviewed-by: David Gow <davidgow@google.com>


>  drivers/base/test/Makefile               |   1 +
>  drivers/base/test/platform-device-test.c | 222 +++++++++++++++++++++++++++++++
>  2 files changed, 223 insertions(+)
>
> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index d589ca3fa8fc..e321dfc7e922 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)  += test_async_driver_probe.o
>
>  obj-$(CONFIG_DM_KUNIT_TEST)    += root-device-test.o
> +obj-$(CONFIG_DM_KUNIT_TEST)    += platform-device-test.o
>
>  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
>  CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
> new file mode 100644
> index 000000000000..b6ebf1dcdffb
> --- /dev/null
> +++ b/drivers/base/test/platform-device-test.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/resource.h>
> +
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +
> +#define DEVICE_NAME "test"
> +
> +struct test_priv {
> +       bool probe_done;
> +       bool release_done;
> +       wait_queue_head_t probe_wq;
> +       wait_queue_head_t release_wq;
> +       struct device *dev;
> +};
> +
> +static int platform_device_devm_init(struct kunit *test)
> +{
> +       struct test_priv *priv;
> +
> +       priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +       init_waitqueue_head(&priv->probe_wq);
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
> +static void devm_put_device_action(void *ptr)
> +{
> +       struct test_priv *priv = ptr;
> +
> +       put_device(priv->dev);
> +       priv->release_done = true;
> +       wake_up_interruptible(&priv->release_wq);
> +}
> +
> +#define RELEASE_TIMEOUT_MS     100
> +
> +/*
> + * Tests that a platform bus, non-probed device will run its
> + * device-managed actions when unregistered.
> + */
> +static void platform_device_devm_register_unregister_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct test_priv *priv = test->priv;
> +       int ret;
> +
> +       pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       ret = platform_device_add(pdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       priv->dev = &pdev->dev;
> +
> +       ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       platform_device_unregister(pdev);
> +
> +       ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +/*
> + * Tests that a platform bus, non-probed device will run its
> + * device-managed actions when unregistered, even if someone still holds
> + * a reference to it.
> + */
> +static void platform_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct test_priv *priv = test->priv;
> +       int ret;
> +
> +       kunit_skip(test, "This needs to be fixed in the core.");
> +
> +       pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       ret = platform_device_add(pdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       priv->dev = &pdev->dev;
> +
> +       get_device(priv->dev);
> +
> +       ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       platform_device_unregister(pdev);
> +
> +       ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static int fake_probe(struct platform_device *pdev)
> +{
> +       struct test_priv *priv = platform_get_drvdata(pdev);
> +
> +       priv->probe_done = true;
> +       wake_up_interruptible(&priv->probe_wq);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver fake_driver = {
> +       .probe  = fake_probe,
> +       .driver = {
> +               .name = DEVICE_NAME,
> +       },
> +};
> +
> +/*
> + * Tests that a platform bus, probed device will run its device-managed
> + * actions when unregistered.
> + */
> +static void probed_platform_device_devm_register_unregister_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct test_priv *priv = test->priv;
> +       int ret;
> +
> +       ret = platform_driver_register(&fake_driver);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       priv->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, priv);
> +
> +       ret = platform_device_add(pdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       ret = wait_event_interruptible_timeout(priv->probe_wq, priv->probe_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_ASSERT_GT(test, ret, 0);
> +
> +       ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       platform_device_unregister(pdev);
> +
> +       ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_EXPECT_GT(test, ret, 0);
> +
> +       platform_driver_unregister(&fake_driver);
> +}
> +
> +/*
> + * Tests that a platform bus, probed device will run its device-managed
> + * actions when unregistered, even if someone still holds a reference to
> + * it.
> + */
> +static void probed_platform_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct test_priv *priv = test->priv;
> +       int ret;
> +
> +       ret = platform_driver_register(&fake_driver);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       priv->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, priv);
> +
> +       ret = platform_device_add(pdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       ret = wait_event_interruptible_timeout(priv->probe_wq, priv->probe_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_ASSERT_GT(test, ret, 0);
> +
> +       get_device(priv->dev);
> +
> +       ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       platform_device_unregister(pdev);
> +
> +       ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +                                              msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +       KUNIT_EXPECT_GT(test, ret, 0);
> +
> +       platform_driver_unregister(&fake_driver);
> +}
> +
> +static struct kunit_case platform_device_devm_tests[] = {
> +       KUNIT_CASE(platform_device_devm_register_unregister_test),
> +       KUNIT_CASE(platform_device_devm_register_get_unregister_with_devm_test),
> +       KUNIT_CASE(probed_platform_device_devm_register_unregister_test),
> +       KUNIT_CASE(probed_platform_device_devm_register_get_unregister_with_devm_test),
> +       {}
> +};
> +
> +static struct kunit_suite platform_device_devm_test_suite = {
> +       .name = "platform-device-devm",
> +       .init = platform_device_devm_init,
> +       .test_cases = platform_device_devm_tests,
> +};
> +
> +kunit_test_suite(platform_device_devm_test_suite);
>
> --
> 2.40.0
>

--000000000000ebd9460600d37381
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAV
1m1LthvGRxI6CCz6lggQWy/WziY0/Tj5xqnAi+D8ojAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwOTE0MDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAO03tTbPuFQt6V3AZn8VZ
arMEG5xOLlZ315i3+ux9YSMLiWrMrCllR+ITdL5kfoH+V9WlgQbuXrkVbU9idP1vR+f1caGOg3oq
jUmhOtXV877D/v9AS4y1RKpqwHPh8uu6sWq0W1WINYnNAnzXbDhzG/ld1z2jgDDLXPCL98yWCVbC
X8SHqGImB+EMNNkOz+PCBqdhUM34+Y2dhkxHhIHiHTWGO2o9sE+5uPqsZxtZCkkecAkgISwVVq2m
AdOEFR6OnJh5fjB252fOWLv98+23NsO+VFU1Z+bPfzbc6iW9zDaojm57NXrCfA+dAbii+LsN106v
on2bp5v6jyPckd49IA==
--000000000000ebd9460600d37381--
