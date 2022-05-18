Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207F52B42B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiERH7p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiERH7o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 03:59:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451181271A7
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:59:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so2679334wmj.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xrKfHXzENUKfZfrSxeeJkFUdKwqShdFovzR9IeZc3E=;
        b=fvNoVrbs7WYvuyl2fQzeDKxfeUY58UIlDGrfek9qyRO+2CEeAmVWusKwf9ZG0XPS7p
         Uez/o2H7O79CL9jspYhwMffiwk/HJteVL/2uK5x9x1RGf2AlPqRRViWZbjSA1sNkv9p/
         EJfM0W/xNmv26SLLAQ/76Fgyuio5kz0mamK5FpJV+KTg8q3iSqbCaGKyPEtQ/6sfbRAu
         ETJxtPFfWUPXCXAxpx6Xifvz9WUu4rTlyiFFS0akE9TKadz51omSu1zzbwih9/Pv1INW
         uaN4K5SXsomxRS8A4/es26zHi88YRtrKVa60pmmwtRnUGDtQ4vfcI9wSJmY8aRSa2Uma
         eT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xrKfHXzENUKfZfrSxeeJkFUdKwqShdFovzR9IeZc3E=;
        b=wa61Rxbm4WHXQwBtOL7MUA3818US1rUybwg7PhPf7++3XjffYCkyrYk5CHXCFG9g5l
         0S/LYKYmkL93Llz4o73t/1O9yxCjNDOm4ctbfluriK2ZVyfT0dta3oHwSGDGZXlqCH2r
         MpMFdiCulYScY8toVrdk7JcX2OiGuQ5jlgE4RuK3r6TUJBlMhQ/Psx/xZTOLop2E4Fpn
         iWoxPgtfAj2YAKhdgOxtFw9Mw6OnhTj5rdbYxyte2T8WmJQCqvfC+/T9ShWJGWqz8YFv
         Sao9r/P+0mpV740Zm0TBOh0rwsp8hkgmYTpC3aCRhz+Ieu1JIf3r8qjKxFC+ouQ7g/ke
         kyzg==
X-Gm-Message-State: AOAM532q6EThftVpBapIzdc0ygwr70LP/Squckp8t8dT1cWezwneclue
        t+iyefDiaeyLG3MxA7jV+ck08xERsDPQrVn30ROUPQ==
X-Google-Smtp-Source: ABdhPJwegnkje+Jgg7NNxzXZ4UchLta3+c/kfL5JdSjYS7XpBINQ/6CEF8S+8QuMw0CBjf6wCkeIgrhkH6c2eZnLHpY=
X-Received: by 2002:a05:600c:6021:b0:394:56be:18e with SMTP id
 az33-20020a05600c602100b0039456be018emr24290795wmb.86.1652860782644; Wed, 18
 May 2022 00:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165446.1246262-1-dlatypov@google.com>
In-Reply-To: <20220516165446.1246262-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 18 May 2022 15:59:31 +0800
Message-ID: <CABVgOS=rs97gnSJ+_uJwnNXRHkxvQXJxUS2s0vvNw+Vaoi8JYA@mail.gmail.com>
Subject: Re: [PATCH] kunit: use kmemdup in kunit_filter_tests(), take suite as const
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d63f6505df44a345"
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

--000000000000d63f6505df44a345
Content-Type: text/plain; charset="UTF-8"

On Tue, May 17, 2022 at 12:54 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> kmemdup() is easier than kmalloc() + memcpy(), per lkp bot.
>
> Also make the input `suite` as const since we're now always making
> copies after commit a127b154a8f2 ("kunit: tool: allow filtering test
> cases via glob").
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Ah, this is definitely better. Thanks. I ran it under KASAN to double
check, and no issues there, either.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/executor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 2f73a6a35a7e..43e15112460a 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -55,7 +55,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
>
>  /* Create a copy of suite with only tests that match test_glob. */
>  static struct kunit_suite *
> -kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
> +kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
>  {
>         int n = 0;
>         struct kunit_case *filtered, *test_case;
> @@ -69,11 +69,9 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
>         if (n == 0)
>                 return NULL;
>
> -       /* Use memcpy to workaround copy->name being const. */
> -       copy = kmalloc(sizeof(*copy), GFP_KERNEL);
> +       copy = kmemdup(suite, sizeof(*copy), GFP_KERNEL);
>         if (!copy)
>                 return ERR_PTR(-ENOMEM);
> -       memcpy(copy, suite, sizeof(*copy));
>
>         filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
>         if (!filtered)
>
> base-commit: 9660209d9418f2295d31fea0d32e313e9b2c1200
> --
> 2.36.0.550.gb090851708-goog
>

--000000000000d63f6505df44a345
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDw
o01xzHM5aJUZJoDoBqnyp6fghiaAaqC31a4o2sqGhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MTgwNzU5NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAZZC9pKsR/iC4Q+GB04Dc
L0j+MLqBaoS+atiUEnP1Rzk1KBu5rTieFb3hMNtcmkx8EH+h4zkvbPkSq8duuw+ttRLw+LIyDTtC
RN4T5o1GYAfXZ0BDLOTZG9QAKGDU6fMtWE1Un5bmpWlShvOQeLYOSCb2vK4o/CBTsLACeRgMmvOT
42EInL3jJ3NohpXYCdjx17LASqRb2ltOcM3HvWgS/PscetvMOOx44mJgfrEroz9ArCuHhkxgOJCS
i7NFBdAijH87Nrpo8WOJ52rRRUKdgTL/cjI+X0MLBGeTRusma6zgkd7fdVPIVWY8XUPjP1iTB9os
Ge4jdRocfOuKIBV9YQ==
--000000000000d63f6505df44a345--
