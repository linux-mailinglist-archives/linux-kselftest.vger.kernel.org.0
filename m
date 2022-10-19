Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E9603A28
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 08:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJSGyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJSGx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 02:53:58 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007376EF27
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 23:53:55 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id i16so6677832uak.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULA+5xu2ctF0bXh6or31Ls/glV5W3hGu5AenpKoGykw=;
        b=MlmGqYMBU+hSXRonqY65wFYJf5CrvLLG7feheumPduaCF4EIFYKr5WLHfkwTXIOZSI
         yf79SJ2zu5xnSX9CaM85VkOj0++Uc/EZT0J5lWFLzMbiaW4X5bZUKxL0UkETRm7++WkG
         /WB/yFM7bLgWb+inSOwvTFdbEh5OcH3kX+pBP8tE7do68c5q9nUUIw4KWQoqBkIc2TAH
         rp1qlnjR36VzF5I7nOyf+MoeeiqlQ0bKlW5RIahLiBpUub1VZXxVFPUX5qyhiBpxPZzU
         WRHC5KCuF0YG4KlOT/3FQ30bVg3QDTjrXpZbutFscSEOkLDcdwzjkbAT6f4qZshh/vAh
         k02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULA+5xu2ctF0bXh6or31Ls/glV5W3hGu5AenpKoGykw=;
        b=TsjOZYG8ajF41vvkyHa3BX7auPwVypipdhhwFFUMYT8cYfIXO8+109I3wz2gmFal38
         Tpo5YteXZizuvCkD6GkBQ/Ph4vNjZ/5ltxRlTB88+enOhOnfNje5FacFpr3YKBW7T4I0
         633TsrZZ1IYk0+kzSk3KIFA/Xm5X9KM2n+qD8NQQZGGzGQTM30KaiuAhnnr8DWqy9mtH
         kHDtaCbaoxPgjpUBCVu4XQYH8nNkOT0fyGe238pzqlHCcDp/OLyWfkoRFOLciBrLACf3
         GjLZyiq2Nka7Qa7fS8OiNG1kb9q6IhL35m1veg/xqIuapRn7PnudrY3U5zmKGCAEBr/G
         S17g==
X-Gm-Message-State: ACrzQf2vzxhG4xm/hDNcfDoZjle+ahChAmXuLkq8FsGr9TX1a0D2qZvp
        ifStr/RkTAQlILGu5XAN7FZR1aDar/ZCzsbiCxjW6w==
X-Google-Smtp-Source: AMsMyM6NMY+qXQ4LgWtLTq7vQ0/WROxThEfmPDyNNw0p49cZr3vWGI3Tj6y/8Lvi93Co2T9OXVRUQgpB2H7KGHFYL58=
X-Received: by 2002:ab0:621a:0:b0:3d6:b05c:11e2 with SMTP id
 m26-20020ab0621a000000b003d6b05c11e2mr1024009uao.107.1666162435023; Tue, 18
 Oct 2022 23:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221018190541.189780-1-mairacanal@riseup.net>
In-Reply-To: <20221018190541.189780-1-mairacanal@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 14:53:42 +0800
Message-ID: <CABVgOSmzP9BQyusYL8btZLkCBmnMss26Rx8oF==VpVs82rH5hw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000018424d05eb5dac83"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000018424d05eb5dac83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 3:06 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_E=
Q or
> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp functio=
n,
> such as:
>   KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
>
> Although this usage produces correct results for the test cases, if the
> expectation fails the error message is not very helpful, indicating only =
the
> return of the memcmp function.
>
> Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ that compare memory blocks until a determined size. I=
n
> case of expectation failure, those macros print the hex dump of the memor=
y
> blocks, making it easier to debug test failures for memory blocks.
>
> The v6 has some changes on the first patch, due to rebase on top of Linux=
 6.1,
> specially the renaming of KUNIT_ASSERTION macro to _KUNIT_FAILED
> (97d453bc4007d4ac148c2ba89904026612b91ec9). Moreover, the DRM KUnit tests=
 were
> mainlined in 6.1.
>
> The first patch of the series introduces the KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ. The second patch adds an example of memory block
> expectations on the kunit-example-test.c. And the last patch replaces the
> KUNIT_EXPECT_EQ for KUNIT_EXPECT_MEMEQ on the existing occurrences.
>
> Best Regards,
> - Ma=C3=ADra Canal
>
> v1 -> v2: https://lore.kernel.org/linux-kselftest/2a0dcd75-5461-5266-2749=
-808f638f4c50@riseup.net/T/#m402cc72eb01fb3b88d6706cf7d1705fdd51e5da2
>
> - Change "determinated" to "specified" (Daniel Latypov).
> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to =
make
> it easier for users to infer the right size unit (Daniel Latypov).
> - Mark the different bytes on the failure message with a <> (Daniel Latyp=
ov).
> - Replace a constant number of array elements for ARRAY_SIZE() (Andr=C3=
=A9 Almeida).
> - Rename "array" and "expected" variables to "array1" and "array2" (Danie=
l Latypov).
>
> v2 -> v3: https://lore.kernel.org/linux-kselftest/20220802212621.420840-1=
-mairacanal@riseup.net/T/#t
>
> - Make the bytes aligned at output.
> - Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Daniel L=
atypov).
> - Line up the trailing \ at macros using tabs (Daniel Latypov).
> - Line up the params to the functions (Daniel Latypov).
> - Change "Increament" to "Augment" (Daniel Latypov).
> - Use sizeof() for array sizes (Daniel Latypov).
> - Add Daniel Latypov's tags.
>
> v3 -> v4: https://lore.kernel.org/linux-kselftest/CABVgOSm_59Yr82deQm2C=
=3D18jjSv_akmn66zs4jxx3hfziXPeHg@mail.gmail.com/T/#t
>
> - Fix wrapped lines by the mail client (David Gow).
> - Mention on documentation that KUNIT_EXPECT_MEMEQ is not recommended for
> structured data (David Gow).
> - Add Muhammad Usama Anjum's tag.
>
> v4 -> v5: https://lore.kernel.org/linux-kselftest/20220808125237.277126-1=
-mairacanal@riseup.net/
>
> - Rebase on top of drm-misc-next.
> - Add David Gow's tags.
>
> v5 -> v6: https://lore.kernel.org/linux-kselftest/20220921014515.113062-1=
-mairacanal@riseup.net/
>
> - Rebase on top of Linux 6.1.
> - Change KUNIT_ASSERTION macro to _KUNIT_FAILED.
>

Thanks a bunch for rebasing this. It works well here, and I'm planning
to use it in some tests I'm writing!

One minor formatting comment on patch 1/3, otherwise this whole series
is good to go.

Cheers,
-- David

--00000000000018424d05eb5dac83
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAi
tfU3jNFdpwHqfA8I7aRvIPe6xZ2Xt9hX/BZNnpxChDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMTkwNjUzNTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAa3mb+s2zLkRdTVDChkHV
/hjIMWBLTygm8ef9iGaDljdCP4TukSKDg7D0XvhZD4J58OjWF51Yeg6SDIPt+m3NMk7jRgNMOvFa
m6QT39S170ocof4CtXZ1hALAgjqgrBQB7PkjHtQfzmeI4e1dwYlvOifGO24RLErl81RMq8mYo07j
aS8pVylVU3Eav4ydi0STd96Gvn9q7PD2ui9Uqy/H1upGEznaLcJlh+94sVKEN+kYzi4W5d1BK4hW
TiHsRFIRXu8w17JQPTdlUoUOMzYuwK7NAjqKwPLn1gYA+T9BE6G4ZB6M/o8v0Y/+NCBO653yfoO3
DABeqfUt7WvN7i6bGw==
--00000000000018424d05eb5dac83--
