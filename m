Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4C759157
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGSJOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGSJOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:14:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F7C19BE
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:14:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so171785e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689758050; x=1690362850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXgbjwJVAGS9qimK+IPbeqmra6I9/Hh0T1u0uLK3OSo=;
        b=5L4rD2xYLzlrvxrMdxWizsrhXQFfED47WonvUs+8sVtstCWvu6A6QjTumK+pgeciRZ
         /qyw7h6lxtz6g1PjSVqcUsyaOwj5dUT13UShzdDdDTM981HT/E/ugvkauSNyJpLCycq0
         o6KZVeWB+4uke3I6Lr1+4HcmmgT8/fvrPm1+NJpHGknk40U/1vuATIJFWu1HBJ+AjDZj
         WzcOWsMXluQ0fP5ZFW/uz780alVbe/Vz6jWT18TNisl6+UWZ6fDK9t8HghMqn7dl9QCZ
         ZtBTxGENm7ORatArgL57jJjsNQ15/GPhRvUxp4OfTqJnzi28Yiyhe9KOvYc0vQYrhtS8
         wAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758050; x=1690362850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXgbjwJVAGS9qimK+IPbeqmra6I9/Hh0T1u0uLK3OSo=;
        b=J96IVRj5g2enY9Bgg9PlekqQK4fdFEyBkYIQ1XUcFL+x0wm/CCsh3pM9Tk1+2me9X5
         OKm3WiTkGBJDzmQlsEGgCWWAq00w8IXePwtmuK9Hpa/J+q6UdxUtbC/fhEQ4dO71ZWL8
         ShnLo2IarTPvF0MxhXj9dTfgoJO5nMZifsd84DvN91dAv4/7o5ZB4PBLvGkA081rY65b
         tolruh6ayA6sLpUNaErHMOpab292feyRWiZkIHVskhcnoqqD3JQEy/ebH9OidS3fWFHt
         CieHIhfxYt0bOquwGeUUKftcA5TWcB+PVSk22IyNVEs6+3koxHxPQX7knfoGu2TzEHR5
         OmTg==
X-Gm-Message-State: ABy/qLavQuQCvKeqebpFs8ICQyFnrAwoiBNrltucwJGJAggSHrDyTY4+
        LgEiYOH/XJXS54WkJnV9rKB7g+E64rtANP4RM+MT+IjAjRdzShTNK+gXTg==
X-Google-Smtp-Source: APBJJlGH7WzaWYeVZoi4gY6oUHy3k+FC5or6lg9Asu0UBJ11sGsKgmH4ktoFVAKWZdUruaBbasXM4e6LbEH53YGIt5Q=
X-Received: by 2002:a05:600c:12d5:b0:3f7:3e85:36a with SMTP id
 v21-20020a05600c12d500b003f73e85036amr186944wmd.7.1689758050368; Wed, 19 Jul
 2023 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v2-3-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-3-19feb71e864b@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 17:13:58 +0800
Message-ID: <CABVgOSmBcSA69SXEOh8_A7=aSigv5vztkhPYt9TBSNnxhiRSYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drivers: base: Free devm resources when
 unregistering a device
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005d18a60600d37466"
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

--0000000000005d18a60600d37466
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jun 2023 at 17:50, Maxime Ripard <mripard@kernel.org> wrote:
>
> From: David Gow <davidgow@google.com>
>
> In the current code, devres_release_all() only gets called if the device
> has a bus and has been probed.
>
> This leads to issues when using bus-less or driver-less devices where
> the device might never get freed if a managed resource holds a reference
> to the device. This is happening in the DRM framework for example.
>
> We should thus call devres_release_all() in the device_del() function to
> make sure that the device-managed actions are properly executed when the
> device is unregistered, even if it has neither a bus nor a driver.
>
> This is effectively the same change than commit 2f8d16a996da ("devres:
> release resources on device_del()") that got reverted by commit
> a525a3ddeaca ("driver core: free devres in device_release") over
> use-after-free concerns.
>
> It's not clear whether those concerns are legitimate though, but I would
> expect drivers not to register new resources in their device-managed
> actions.

It might be clearer to notice that this patch effectively combines the
two patches above, freeing _both_ on device_del() and
device_release(). This should give us the best of both worlds. I'm not
aware of a use-after-free issue that could result here, though it's
possible there's a double free I'm missing now that we are freeing
things twice. My understanding is that commit a525a3ddeaca ("driver
core: free devres in device_release") was more to avoid a leak than a
use-after-free, but I could be wrong.


> Fixes: a525a3ddeaca ("driver core: free devres in device_release")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Signed-off-by: David Gow <davidgow@google.com>

Personally, I feel that this is the right way to go, but I'm
definitely not an expert, so I'll let someone else review it in case
there's something I'm missing.

Cheers,
-- David



>  drivers/base/core.c                      | 11 +++++++++++
>  drivers/base/test/platform-device-test.c |  2 --
>  drivers/base/test/root-device-test.c     |  2 --
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3dff5037943e..6ceaf50f5a67 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3817,6 +3817,17 @@ void device_del(struct device *dev)
>         device_platform_notify_remove(dev);
>         device_links_purge(dev);
>
> +       /*
> +        * If a device does not have a driver attached, we need to clean
> +        * up any managed resources. We do this in device_release(), but
> +        * it's never called (and we leak the device) if a managed
> +        * resource holds a reference to the device. So release all
> +        * managed resources here, like we do in driver_detach(). We
> +        * still need to do so again in device_release() in case someone
> +        * adds a new resource after this point, though.
> +        */
> +       devres_release_all(dev);
> +
>         bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
>         kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>         glue_dir = get_glue_dir(dev);
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
> index b6ebf1dcdffb..1ae5ce8bd366 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -87,8 +87,6 @@ static void platform_device_devm_register_get_unregister_with_devm_test(struct k
>         struct test_priv *priv = test->priv;
>         int ret;
>
> -       kunit_skip(test, "This needs to be fixed in the core.");
> -
>         pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
>
> diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
> index 9a3e6cccae13..780d07455f57 100644
> --- a/drivers/base/test/root-device-test.c
> +++ b/drivers/base/test/root-device-test.c
> @@ -78,8 +78,6 @@ static void root_device_devm_register_get_unregister_with_devm_test(struct kunit
>         struct test_priv *priv = test->priv;
>         int ret;
>
> -       kunit_skip(test, "This needs to be fixed in the core.");
> -
>         priv->dev = root_device_register(DEVICE_NAME);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
>
>
> --
> 2.40.0
>

--0000000000005d18a60600d37466
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAc
wm3A5jQhGhLKuzjTPqRDl74KhPufWlsGh6CKM3A20zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwOTE0MTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASP12E7UOShfxxVcuGuS6
SPxYJWESSdXOi9eoRg0fEGuyXa6cS4QKzstLUbMe+aCWo+o8x4KewT8suZ/Wv8GYFliM8H2LeUyK
ydxZ2v9WD2lnAD//WgY83H920sDkhxcocOUr6Aw7cuFgXWmPSjFhmUzNcz+vByL9wepGRWq+JJ+q
910EKxRFmqiRbsKGpcBUou09Zzomr8SmzEapXhD+8rcQXgWgqE75TiV5IGANdvXQwDpntprN8gvc
ECBa2m1jBqMOLSik44dpJ4hFOHD/DdL3zR06GGPVJ01jgWlD7nhotvSGz7RyYa7/1S9+6bbonCow
2pzruzj0QAZ6SRcJZg==
--0000000000005d18a60600d37466--
