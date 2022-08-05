Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A658A57E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 06:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiHEEpR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 00:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHEEpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 00:45:15 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08414329
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 21:45:12 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id t21so656380uaq.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Aug 2022 21:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OxVG8BisdY99UVLYKcT77zuLjZOqaFc59OU2pyKzIsA=;
        b=W4FpEbo5r4UsA/yLVImJKls5rW9tpBL2X34KpRIOdh/4NwNCDMI7N8JW80wl2gMu8z
         Ta4NsvOOCn9rCE9nSuXvuGvILdZspNhv6XmsLqxQ8oJwVjfus6fwHjlrwavoExtb7T+R
         Vcs0KgRI+YQvKecZtvA5FbzqTunzy/F7fxE/j21VQlpyTnF/6X0Ih27HMehV3LvtrRsY
         erWoWazHkhDXYCqgAAF48IwCjux3Rj08z/FcZm4m7ow574NZf6+UjBZKF1jjqG+oCEWd
         /4MbNd3WgLip3k9ZZGCC3AyXtTFCAp8eBzax+bsZ6PnGHAzpumQndoibWjeOZKDF23ft
         NR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OxVG8BisdY99UVLYKcT77zuLjZOqaFc59OU2pyKzIsA=;
        b=HtvC1hFVVpjs0CWsk/VbDSPbzP3HI7oGOfqUmxXBArqHPk3vjCKMV8DCJFsIWtP73C
         Jj7cAJ9yWaN3WvjP6eRkSnpMt4JIS7t4inZiFiOXJWXwVUy5X7OYmW+0qB7ILPTjF7Gl
         36koCUINoLtGovYqqLQTYv69ur3vOigdtN37tu1hqRPl2GpSsOr2am5kb4pO9uFk3yLk
         SMgVD9bNKcSHzMNR5b3WmMCjN0tUPqRT2egO7SPOlkPsw9dtzabpM2NiwI74m9pGQzWW
         +6PoxAjg8dHN/VFmts5LwtdY0RJ1XwzQzse3ulDGo423gwV6vBuwZWnhqeYZP0zf8833
         k4xw==
X-Gm-Message-State: ACgBeo1qqwQPlCFoGGfXgYWmHNR/a87RIjFKrf2fGtY5WsS0XuIE82Ns
        elS/kPevO0CtTVuM91q5U2ncaaq6Uz3vvDtQNVHTjA==
X-Google-Smtp-Source: AA6agR7I6LEq0MLgn4Py74lPw3J8bWJF3cArGgoQ457MPC0oyijprVZ6/Ti2DsN1bIrNSryDMYyH8VvuSS7I2asWaFA=
X-Received: by 2002:ab0:6197:0:b0:387:8e6e:91b8 with SMTP id
 h23-20020ab06197000000b003878e6e91b8mr2509072uan.26.1659674710874; Thu, 04
 Aug 2022 21:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220803215855.258704-1-mairacanal@riseup.net>
In-Reply-To: <20220803215855.258704-1-mairacanal@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Fri, 5 Aug 2022 12:44:58 +0800
Message-ID: <CABVgOS=Yq2+uDw_iVK11eqBjEB-BErEr6naYpTswtTvyehAzYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009aa4ef05e5772114"
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

--0000000000009aa4ef05e5772114
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 4, 2022 at 5:59 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
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
> Other than the style changes, this v3 brings alignment to the bytes, maki=
ng
> it easier to identify the faulty bytes. So, on the previous version, the
> output from a failure would be:
> [14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/d=
rm/tests/drm_format_helper_test.c:248
> [14:27:42] Expected dst =3D=3D result->expected, but
> [14:27:42] dst =3D=3D
> [14:27:42] 33 0a <60> 12 00 a8 00 00 <00> 00 8e 6b <33> 0a 60 12
> [14:27:42] 00 00 <00> 00 00 a8 <8e> 6b 33 0a 00 00 <00> 00
> [14:27:42] result->expected =3D=3D
> [14:27:42] 33 0a <61> 12 00 a8 00 00 <01> 00 8e 6b <31> 0a 60 12
> [14:27:42] 00 00 <01> 00 00 a8 <81> 6b 33 0a 00 00 <01> 00
>
> Now, with the alignment, the output is:
> [14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/d=
rm/tests/drm_format_helper_test.c:248
> [14:27:42] Expected dst =3D=3D result->expected, but
> [14:27:42] dst =3D=3D
> [14:27:42] 33  0a <60> 12  00  a8  00  00 <00> 00  8e  6b <33> 0a  60  12
> [14:27:42] 00  00 <00> 00  00  a8 <8e> 6b  33  0a  00  00 <00> 00
> [14:27:42] result->expected =3D=3D
> [14:27:42] 33  0a <61> 12  00  a8  00  00 <01> 00  8e  6b <31> 0a  60  12
> [14:27:42] 00  00 <01> 00  00  a8 <81> 6b  33  0a  00  00 <01> 00
>
> Moreover, on the raw output, there were some indentation problems. Those
> problems were solved with the use of KUNIT_SUBSUBTEST_INDENT.
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
>
> Ma=C3=ADra Canal (3):
>   kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
>   kunit: Add KUnit memory block assertions to the example_all_expect_macr=
os_test
>   kunit: Use KUNIT_EXPECT_MEMEQ macro
>
>  .../gpu/drm/tests/drm_format_helper_test.c    |  6 +-
>  include/kunit/assert.h                        | 34 +++++++++
>  include/kunit/test.h                          | 76 +++++++++++++++++++
>  lib/kunit/assert.c                            | 56 ++++++++++++++
>  lib/kunit/kunit-example-test.c                |  7 ++
>  net/core/dev_addr_lists_test.c                |  4 +-
>  6 files changed, 178 insertions(+), 5 deletions(-)
>
> --
> 2.37.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20220803215855.258704-1-mairacanal%40riseup.net.

These patches look pretty good to me overall, but I was unable to
apply v3 to test -- it looks like the mail client has wrapped some
lines or something...

davidgow@slicestar:~/linux-kselftest$ git am
./v3_20220803_mairacanal_introduce_kunit_expect_memeq_and_kunit_expect_memn=
eq_macros.mbx
Applying: kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macro=
s
error: corrupt patch at line 24
Patch failed at 0001 kunit: Introduce KUNIT_EXPECT_MEMEQ and
KUNIT_EXPECT_MEMNEQ macros

Checkpatch also picks up an issue:
ERROR: patch seems to be corrupt (line wrapped?)
#62: FILE: include/kunit/assert.h:255:
                                   const struct va_format *message,

v2 applied clearnly, so it seems to be specific to v3.

In general, I like the patches, though. While I think there are a few
places it'd be slightly suboptimale if it's being used to compare more
structured data, such as the prospect of comparing padding between
elements, as well as the output formatting not being ideal. It's
perfect for the cases where memcmp() otherwise would be used, though.

Cheers,
-- David

--0000000000009aa4ef05e5772114
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCg
1HZnL6aAsmsUuyzXP/zXvF6dl3sgpBzH8wI3Qf5lxzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MDUwNDQ1MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAOZPaooEr75zGI/JrhVKB
NQWUQGZ7AFh/SddpEqx/znkHhHNyS3VCoej5DpKN5IgwXEGK2B94CpZ9BLMQGjkbjPoOPteWyVb/
kptXdx1q1yo7AU5sgUXBMu3Q61pV4fZollWNvD5o/0PraPJASpnAiFNq4BUDgPslBOG4hkX3wIif
btT82DSffusZpPHjd+lSgTrD4OzOcwqsocNVehA9TUE8+9z+/OxzGubfRzqNSMyEfcdhba84Aar9
O1mNgPoIiEsK6uXrOjaAcoTqdbxva9lRYdQ2Z9hgvc6Ms4hEeun4QsHBV0a0RJKE1NlwheevolvP
EcURJwImJ2DjInoFiA==
--0000000000009aa4ef05e5772114--
