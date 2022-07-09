Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2456C65B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 05:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiGIDZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 23:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGIDZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 23:25:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FEA6C112
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 20:25:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so227618wmi.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MppQ7PhRtgyFl4DUXfuvvWPWLp0qiiL+BxkF4ixWhKo=;
        b=Ckzphb6d9iKtUOfJnDaMXF0nrjocSE1rE0GI6LyDY9hLBVgwab6siOsu5VAlhHdV3W
         JBuf6LPohVer001dAYgggblqkZi8iMI+XfT6LMFIOwJceqdqt1s+nlVZs/980RUeWyY/
         gWLXCCe1R2EOFdUZ8puSHSQCSBOQzHamh93nUV63rm+osP6pOZUY6HZCeZC9KhxiLVym
         JI2AazrSZFPHjiasbwcjWzUEjRzIScYejhC9/naKArlRHK0znRo9IMumNM+bHjm7Jam8
         cPOQi67DecHGUJ5rC7CxhBQVLS67yDkUiaGnHJCoP12MqtOYyTAcjOfXRu19MNb8R3IV
         xIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MppQ7PhRtgyFl4DUXfuvvWPWLp0qiiL+BxkF4ixWhKo=;
        b=glnFQfAqEHLRLm1qEcpe5LQBp6+EQp5M653pl9NAyuMu04hn+9sW1mJwmiZyDfBj4Q
         HjdG61sqo9Ux7FnLo2E6m5Dw162GmmSVYatPAQVlSB6tTOzghutYc4+3Q0cw99gAva5g
         KBgFfLagF98XMNac9fklkcF1zBl7lI+w/BW0ODjiut339WXBkP047iqUDgBl4h3xHoaH
         5ixnHFIIyoobycKD/nAh+qC0FouONoAx60OBw2Bf1aZzXi+1yHkalokJylCybSWs7VPr
         d9uS9dp2Sq1szGaB4cwqDpwyNJoyTUxZ5ig3PnSeh2DKeZcdMI3UKMHBPIthqSrnHVI5
         anqg==
X-Gm-Message-State: AJIora9eJ0AC4g4xBn8VPzE9ig64sROUYtii/b3ho4VcGFjYDIqVpVfZ
        YFldrstLUim8vvel/KCkOm6Cli8tAO2ZHx1+gePMPopZOmHlmA==
X-Google-Smtp-Source: AGRyM1swXGC1sfaXQRy1Xn69Dt8GxfoLuFYMy74dgllMBgXsH8MqmBm3CWHwxaQO0WXjO23yCp57TBd/Ze4MIb/YpdM=
X-Received: by 2002:a05:600c:4fc8:b0:3a1:99cf:800 with SMTP id
 o8-20020a05600c4fc800b003a199cf0800mr3054967wmq.60.1657337117577; Fri, 08 Jul
 2022 20:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-2-davidgow@google.com>
 <CAGS_qxrGwVL37AOUWCxwx=qg6YvXCDSSu4p_PSt7_87N3RxJZw@mail.gmail.com>
In-Reply-To: <CAGS_qxrGwVL37AOUWCxwx=qg6YvXCDSSu4p_PSt7_87N3RxJZw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 9 Jul 2022 11:25:06 +0800
Message-ID: <CABVgOS=AfJ7X5xqEKvXCzQ=UzOWrmR9KBO_TnkQw4Ti3fmKHBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] kunit: unify module and builtin suite definitions
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-usb@vger.kernel.org, linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f74f405e356de27"
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

--0000000000002f74f405e356de27
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 9, 2022 at 2:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 10:10 PM David Gow <davidgow@google.com> wrote:
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 8ffcd7de9607..54306271cfbf 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -250,41 +250,8 @@ static inline int kunit_run_all_tests(void)
> >  }
> >  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> >
> > -#ifdef MODULE
> > -/**
> > - * kunit_test_suites_for_module() - used to register one or more
> > - *                      &struct kunit_suite with KUnit.
> > - *
> > - * @__suites: a statically allocated list of &struct kunit_suite.
> > - *
> > - * Registers @__suites with the test framework. See &struct kunit_suite for
> > - * more information.
> > - *
> > - * If a test suite is built-in, module_init() gets translated into
> > - * an initcall which we don't want as the idea is that for builtins
> > - * the executor will manage execution.  So ensure we do not define
> > - * module_{init|exit} functions for the builtin case when registering
> > - * suites via kunit_test_suites() below.
> > - */
> > -#define kunit_test_suites_for_module(__suites)                         \
>
> Deleting this bit now causes merge conflicts with Shuah's kunit
> branch, due to https://patchwork.kernel.org/project/linux-kselftest/patch/20220702040959.3232874-3-davidgow@google.com/
> I.e. We added in a MODULE_INFO(test, "Y") in this to-be-deleted section.

Nice catch. I've rebased this series on top of the taint stuff:
https://lore.kernel.org/linux-kselftest/20220709032001.819487-2-davidgow@google.com/T/#u

> Perhaps something like this would be a fix?

Thanks.The rebased version is basically this, but without the #ifdef
MODULE indirection, as MODULE_INFO() will decay to nothing if MODULE
is not defined, anyway.

>   #ifdef MODULE
>   #define _kunit_mark_test_module MODULE_INFO(test, "Y")
>   #else
>   #define _kunit_mark_test_module
>   #endif /* MODULE */
>
>   #define __kunit_test_suites(unique_array, unique_suites, ...)
>           \
>           _kunit_mark_test_module;
>           \
>           static struct kunit_suite *unique_array[] = { __VA_ARGS__,
> NULL };     \
>           static struct kunit_suite **unique_suites
>           \
>           __used __section(".kunit_test_suites") = unique_array
>
>
> > -       static int __init kunit_test_suites_init(void)                  \
> > -       {                                                               \
> > -               return __kunit_test_suites_init(__suites);              \
> > -       }                                                               \
> > -       module_init(kunit_test_suites_init);                            \
> > -                                                                       \
> > -       static void __exit kunit_test_suites_exit(void)                 \
> > -       {                                                               \
> > -               return __kunit_test_suites_exit(__suites);              \
> > -       }                                                               \
> > -       module_exit(kunit_test_suites_exit)
> > -#else
> > -#define kunit_test_suites_for_module(__suites)
> > -#endif /* MODULE */
> > -
> >  #define __kunit_test_suites(unique_array, unique_suites, ...)                 \
> >         static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> > -       kunit_test_suites_for_module(unique_array);                            \
> >         static struct kunit_suite **unique_suites                              \
> >         __used __section(".kunit_test_suites") = unique_array
> >

--0000000000002f74f405e356de27
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBl
JmrHJzQ0vK1xYKaDEDYwR3rzNd2KyrVjy2GQK6mVbzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MDkwMzI1MTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlhD8Y9l2qJpJSHbsezKz
AoI+Xv+FHHBzuTK2N9hJyGjtt7jFiiPYYf4bGpzIFX/sSTpd0Z7xOXtE5UpyA1lArMmWvWnFshJk
JaaeTfJqrFEnPBv2QLVKFb+oBSjSFF6SbymFOnqs3v83Wu4ICwP+iZNYqaMSPsv4V4qEbIoUtKm7
gl8ecAoPtoZRoek0wE49XtF1yCBLS3gKvrcCfpKw0L8ZSKPLssfO4gUakft6tLpi9PG+96CTGK1Z
wXl8h+QlaYFi/oP83EPkJbc08GIegicX/2Y2q0T7h2v2v6QV7/Xz/jRYTrz1+rbFZ8hjWpZydZRy
vZ8yWuqbB0qhxbm59Q==
--0000000000002f74f405e356de27--
