Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98BD52D39A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiESNIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiESNIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 09:08:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9994DBDA20
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:08:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso264155wma.4
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5JbYtq4yhCasQlqmdpC0D/BGyzCKs/i7QzQjlYtYHo=;
        b=AwFuDbp7qBiunKO6Bj3f7eJLJbhBcTofDf7IFDBiJkNpF/Uf0z2ZvE2xuATFe9kNoF
         Dfk0ZSaRLp2/ppaSwHAF/KnzH7o2sD6A7JrRjxKOBxr1O30fHHOmh9UnpEa/Qc3F6+fe
         1+sz8nxS7PCSAiryPk+MpLaWQ/eQ3KhyQ2FC3iJ3Ntj7TjP+U7zsIcOWEEIFqrUrE9tU
         wg6+oo3vDemayTYiRfcIWOUH8LEnmAVhugNlsdDPNMJK3lJQxcWGujBwxMaqY1IxNpPP
         0wpTfmNmTItuvmqbl2kl6dyNI04tQqUMwyUbwdel8UWS0k0v+LHw/TJFj7i4NljwjyBI
         DSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5JbYtq4yhCasQlqmdpC0D/BGyzCKs/i7QzQjlYtYHo=;
        b=2wgB6f0aGV7Puv19/8Ja1bghy6Ioc9aNunRAL6MLJB8bAqfa0xD4bDX3YRJqa5vxmP
         3XV3Db2nUihSsK12+B1MqMs8ePrUtfafvQM4rPa4bxUU589524yvJ3s582l+QVEfCOTo
         fVClx1jGTEym0V/K3JkNUv4fFHRDQaB1M9CmVVhlfZEs7LC4OzdQMKjcpVEc+uJpQomf
         vVI/ChgHKN+ejVRqgvmDoDK27trgb0LIgrCSlpzNrHMbH36TEW/FuIDNnYTfQNCG0Bnl
         pMNR2BX33M97WfGHXZlfrxCg6QDtmkMBWGyRBiVb+fh2t1QG0nn8U7tQUjrpEjFbsB82
         t17A==
X-Gm-Message-State: AOAM533JmtkYe8RbvW525CihXJQjnSB5bEEQm4MXTzSVr6qDBTf3PYuR
        acGuw+ClFOaYlgtH3dIgcKJfricXfBp5AEr8nnHDnQ==
X-Google-Smtp-Source: ABdhPJzQpY+yMjZVmgtaOFUvmT8ZEJ3HHMAQXO1OUYKovuWCaNYpGtUEB6f6TAYmh8qO1k1RyYjaAXhumAR5PPHoWzc=
X-Received: by 2002:a05:600c:3512:b0:394:7c3b:53d1 with SMTP id
 h18-20020a05600c351200b003947c3b53d1mr4253775wmq.197.1652965722897; Thu, 19
 May 2022 06:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com>
In-Reply-To: <YoS6rthXi9VRXpkg@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 19 May 2022 21:08:31 +0800
Message-ID: <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c4608d05df5d1251"
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

--000000000000c4608d05df5d1251
Content-Type: text/plain; charset="UTF-8"

On Wed, May 18, 2022 at 5:21 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, May 18, 2022 at 03:32PM +0800, David Gow wrote:
> > Add a .kunitconfig file, which provides a default, working config for
> > running the KCSAN tests. Note that it needs to run on an SMP machine, so
> > to run under kunit_tool, the x86_64-smp qemu-based setup should be used:
> > ./tools/testing/kunit/kunit.py run --arch=x86_64-smp --kunitconfig=kernel/kcsan
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Thanks for adding this.
>
> > ---
> >  kernel/kcsan/.kunitconfig | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 kernel/kcsan/.kunitconfig
> >
> > diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
> > new file mode 100644
> > index 000000000000..a8a815b1eb73
> > --- /dev/null
> > +++ b/kernel/kcsan/.kunitconfig
> > @@ -0,0 +1,20 @@
> > +# Note that the KCSAN tests need to run on an SMP setup.
> > +# Under kunit_tool, this can be done by using the x86_64-smp
> > +# qemu-based architecture:
> > +# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan --arch=x86_64-smp
> > +
> > +CONFIG_KUNIT=y
> > +
> > +CONFIG_DEBUG_KERNEL=y
> > +
> > +CONFIG_KCSAN=y
> > +CONFIG_KCSAN_KUNIT_TEST=y
> > +
> > +# Needed for test_barrier_nothreads
> > +CONFIG_KCSAN_STRICT=y
> > +CONFIG_KCSAN_WEAK_MEMORY=y
>
> Note, KCSAN_STRICT implies KCSAN_WEAK_MEMORY.
>
> Also, a bunch of the test cases' outcomes depend on KCSAN's
> "strictness". I think to cover the various combinations would be too
> complex, but we can just settle on testing KCSAN_STRICT=y.

It's definitely possible to either have multiple .kunitconfigs, each
of which could have slightly different setups, e.g.:
- kernel/kcsan/.kunitconfig (defualt)
- kernel/kcsan/strict.kunitconfig (passed explicitly when desired)

Equally, if we got rid of KCSAN_STRICT in the .kunitconfig, you could
override it with --kconfig_add, e.g.
-  ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
--arch=x86_64-smp
- ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
--arch=x86_64-smp --kconfig_add CONFIG_KSCAN_STRICT=y

> The end result is the same, but you could drop the
> CONFIG_KCSAN_WEAK_MEMORY=y line, and let the latest KCSAN_STRICT
> defaults decide (I don't expect them to change any time soon).
>
> If you want it to be more explicit, it's also fine leaving the
> CONFIG_KCSAN_WEAK_MEMORY=y line in.

Do you have a preference here? Or to get rid of both and default to
the non-strict version mentioned above?

>
> > +# This prevents the test from timing out on many setups. Feel free to remove
> > +# (or alter) this, in conjunction with setting a different test timeout with,
> > +# for example, the --timeout kunit_tool option.
> > +CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
> > --
> > 2.36.0.550.gb090851708-goog
> >

--000000000000c4608d05df5d1251
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBg
3kxCA+bJ6Pr4EBE/BjEv2DIDDLIxlJZejM8ULg1uHjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MTkxMzA4NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAOcrOtFS8EmyO69KlOQpt
k5aC+qmT0fDIITppu2U+rbI3kDeLODV6pF1NossdT5AWE0cDI+F9vcog6dhUSGfLGYhydyk47q5x
nS4t4r/49lv3eTp2hQbGW1p8WiqALEteCTrGV61BZXkCF/Pc3U6aslyGmUVIHNWSqsX8tT4LohCO
9FHFyUVsoHdUuQ4JHD0sSqCbrhrQJDIlWwAL+AtNgtNJal0NJdMZSap7dmYwNhm3SJSQh3TcHPO9
eff8cNgbWO3zB5kLz9dk58r0G1evCmFl8bfEMcpQqZnD+6z4zDrCUDDdfItb/ZkKEKXvPxod2HdZ
l2y22awXtQfHaW9imA==
--000000000000c4608d05df5d1251--
