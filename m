Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E058B27E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 00:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiHEWrA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 18:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiHEWq7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 18:46:59 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7E1E3EC
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 15:46:58 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q190so3813254vsb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DCbCGrw2l7IbRb1Rv9teTj/WKNMg19aGlHwU1Cu46Rw=;
        b=nAgdBIhmdGMQFH3F0qrd2im4EZx6aMf/lNr6y2+z4dLfyg0P1S2zQ3QliVmLEFw+OD
         f+xt5ChdnCiXLEbMGuOAMaxDVkbpVuS1jsmsl8PXR9dncFuwyCn9wZv0z0WCilh6BQIp
         KFeTwylPpOd1jHy0ahE6nlJed3Wo+GW1/BaxF59Bog7rWRNxnn+ABGjZLb5ZnnrFyf8I
         pJPuC7Qy5yZJ4yOh+0axljpW2UkB3SIgDquc/Xj1yeD4m6hr4fGBMcNx1lObMtP/xIlj
         wjK+SjjP8jyLdoKLnUe2NdmMWCTzPxb+IpvPWzVuteMTOnUwUUi7IBjJI7tWWD1X3LJe
         9tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DCbCGrw2l7IbRb1Rv9teTj/WKNMg19aGlHwU1Cu46Rw=;
        b=RA6rDsJwG7h9K1IbpHGiurkGcaRpjyenP0iMZS/MYtU5ULBsYyALxB8LJtbmQnVRW0
         VBQkOs2C6EagspCfkONIYakoDxpnecK3ltxzNnBG0DUskoS6K+dRAbML8F3YgtgKC0G1
         oB7Jc1iEp4ooh7RB6klIQxoZ3Bjg3Lq/8Sh6dMege+bF3AyTDa3hU9zsqymrPlq99j/e
         X+UanfRcZ0Xof9nbXPAza/CM32B/BSjIt3369V3zj6ARGdVPdcR09xbaAGGTdDn34PIG
         S/T/7HSqat0+/CPO9gZnBm/MERZKL8+fedWf5meNY7PU2uSXqkRHF15v2S/6lNKQ2tI5
         4Tfw==
X-Gm-Message-State: ACgBeo18gvcUjN77ovgSuMTxtr1ATiEhBPoCAFcq78FJqGoD33conNLC
        9embwLl8t3mTCetg5Sj/g8fTNOs721gcGXUlDDpjOQ==
X-Google-Smtp-Source: AA6agR6G9llgTVmgHqydeiuj9quI7QP6bB3GwyFOI78OQRgDpiC9rcqH4OMeNnz4fcU10XQddl5R1CuQftRrmyDFdTc=
X-Received: by 2002:a67:c895:0:b0:357:48d2:fa1 with SMTP id
 v21-20020a67c895000000b0035748d20fa1mr4072773vsk.22.1659739617498; Fri, 05
 Aug 2022 15:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220803215855.258704-1-mairacanal@riseup.net>
 <CABVgOS=Yq2+uDw_iVK11eqBjEB-BErEr6naYpTswtTvyehAzYw@mail.gmail.com> <ad483719-24b2-3207-cdcc-f5055d7a8895@riseup.net>
In-Reply-To: <ad483719-24b2-3207-cdcc-f5055d7a8895@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Sat, 6 Aug 2022 06:46:46 +0800
Message-ID: <CABVgOSm_59Yr82deQm2C=18jjSv_akmn66zs4jxx3hfziXPeHg@mail.gmail.com>
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
        boundary="000000000000579e1805e5863e3f"
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

--000000000000579e1805e5863e3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 5, 2022 at 8:18 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> On 8/5/22 01:44, David Gow wrote:
> > On Thu, Aug 4, 2022 at 5:59 AM Ma=C3=ADra Canal <mairacanal@riseup.net>=
 wrote:
> >>
> >> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPEC=
T_EQ or
> >> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp func=
tion,
> >> such as:
> >>   KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
> >>
> >> Although this usage produces correct results for the test cases, if th=
e
> >> expectation fails the error message is not very helpful, indicating on=
ly the
> >> return of the memcmp function.
> >>
> >> Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
> >> KUNIT_EXPECT_MEMNEQ that compare memory blocks until a determined size=
. In
> >> case of expectation failure, those macros print the hex dump of the me=
mory
> >> blocks, making it easier to debug test failures for memory blocks.
> >>
> >> Other than the style changes, this v3 brings alignment to the bytes, m=
aking
> >> it easier to identify the faulty bytes. So, on the previous version, t=
he
> >> output from a failure would be:
> >> [14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gp=
u/drm/tests/drm_format_helper_test.c:248
> >> [14:27:42] Expected dst =3D=3D result->expected, but
> >> [14:27:42] dst =3D=3D
> >> [14:27:42] 33 0a <60> 12 00 a8 00 00 <00> 00 8e 6b <33> 0a 60 12
> >> [14:27:42] 00 00 <00> 00 00 a8 <8e> 6b 33 0a 00 00 <00> 00
> >> [14:27:42] result->expected =3D=3D
> >> [14:27:42] 33 0a <61> 12 00 a8 00 00 <01> 00 8e 6b <31> 0a 60 12
> >> [14:27:42] 00 00 <01> 00 00 a8 <81> 6b 33 0a 00 00 <01> 00
> >>
> >> Now, with the alignment, the output is:
> >> [14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gp=
u/drm/tests/drm_format_helper_test.c:248
> >> [14:27:42] Expected dst =3D=3D result->expected, but
> >> [14:27:42] dst =3D=3D
> >> [14:27:42] 33  0a <60> 12  00  a8  00  00 <00> 00  8e  6b <33> 0a  60 =
 12
> >> [14:27:42] 00  00 <00> 00  00  a8 <8e> 6b  33  0a  00  00 <00> 00
> >> [14:27:42] result->expected =3D=3D
> >> [14:27:42] 33  0a <61> 12  00  a8  00  00 <01> 00  8e  6b <31> 0a  60 =
 12
> >> [14:27:42] 00  00 <01> 00  00  a8 <81> 6b  33  0a  00  00 <01> 00
> >>
> >> Moreover, on the raw output, there were some indentation problems. Tho=
se
> >> problems were solved with the use of KUNIT_SUBSUBTEST_INDENT.
> >>
> >> The first patch of the series introduces the KUNIT_EXPECT_MEMEQ and
> >> KUNIT_EXPECT_MEMNEQ. The second patch adds an example of memory block
> >> expectations on the kunit-example-test.c. And the last patch replaces =
the
> >> KUNIT_EXPECT_EQ for KUNIT_EXPECT_MEMEQ on the existing occurrences.
> >>
> >> Best Regards,
> >> - Ma=C3=ADra Canal
> >>
> >> v1 -> v2: https://lore.kernel.org/linux-kselftest/2a0dcd75-5461-5266-2=
749-808f638f4c50@riseup.net/T/#m402cc72eb01fb3b88d6706cf7d1705fdd51e5da2
> >>
> >> - Change "determinated" to "specified" (Daniel Latypov).
> >> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order =
to make
> >> it easier for users to infer the right size unit (Daniel Latypov).
> >> - Mark the different bytes on the failure message with a <> (Daniel La=
typov).
> >> - Replace a constant number of array elements for ARRAY_SIZE() (Andr=
=C3=A9 Almeida).
> >> - Rename "array" and "expected" variables to "array1" and "array2" (Da=
niel Latypov).
> >>
> >> v2 -> v3: https://lore.kernel.org/linux-kselftest/20220802212621.42084=
0-1-mairacanal@riseup.net/T/#t
> >>
> >> - Make the bytes aligned at output.
> >> - Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Danie=
l Latypov).
> >> - Line up the trailing \ at macros using tabs (Daniel Latypov).
> >> - Line up the params to the functions (Daniel Latypov).
> >> - Change "Increament" to "Augment" (Daniel Latypov).
> >> - Use sizeof() for array sizes (Daniel Latypov).
> >>
> >> Ma=C3=ADra Canal (3):
> >>   kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
> >>   kunit: Add KUnit memory block assertions to the example_all_expect_m=
acros_test
> >>   kunit: Use KUNIT_EXPECT_MEMEQ macro
> >>
> >>  .../gpu/drm/tests/drm_format_helper_test.c    |  6 +-
> >>  include/kunit/assert.h                        | 34 +++++++++
> >>  include/kunit/test.h                          | 76 ++++++++++++++++++=
+
> >>  lib/kunit/assert.c                            | 56 ++++++++++++++
> >>  lib/kunit/kunit-example-test.c                |  7 ++
> >>  net/core/dev_addr_lists_test.c                |  4 +-
> >>  6 files changed, 178 insertions(+), 5 deletions(-)
> >>
> >> --
> >> 2.37.1
> >>
> >> --
> >> You received this message because you are subscribed to the Google Gro=
ups "KUnit Development" group.
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to kunit-dev+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/m=
sgid/kunit-dev/20220803215855.258704-1-mairacanal%40riseup.net.
> >
> > These patches look pretty good to me overall, but I was unable to
> > apply v3 to test -- it looks like the mail client has wrapped some
> > lines or something...
> >
> > davidgow@slicestar:~/linux-kselftest$ git am
> > ./v3_20220803_mairacanal_introduce_kunit_expect_memeq_and_kunit_expect_=
memneq_macros.mbx
> > Applying: kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ m=
acros
> > error: corrupt patch at line 24
> > Patch failed at 0001 kunit: Introduce KUNIT_EXPECT_MEMEQ and
> > KUNIT_EXPECT_MEMNEQ macros
> >
> > Checkpatch also picks up an issue:
> > ERROR: patch seems to be corrupt (line wrapped?)
> > #62: FILE: include/kunit/assert.h:255:
> >                                    const struct va_format *message,
> >
> > v2 applied clearnly, so it seems to be specific to v3.
>
> I'll check this issue and submit a v4. Thank you!
>

Thanks!

> >
> > In general, I like the patches, though. While I think there are a few
> > places it'd be slightly suboptimale if it's being used to compare more
> > structured data, such as the prospect of comparing padding between
> > elements, as well as the output formatting not being ideal. It's
> > perfect for the cases where memcmp() otherwise would be used, though.
>
> Do you any take on how to make the output formatting more ideal?
>

I don't actually think we need to change any of the formatting in this
patch, I'm just noting that usinng MEMEQ()/MEMNEQ() might not be the
best choice for comparing, e.g., structs (and that comparing their
members individually might be better there).
_Maybe_ that's something that could be mentioned in the documentation,
but I wouldn't change the code at all.

Cheers,
-- David

--000000000000579e1805e5863e3f
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDH
iivf8RUxQXK3eAwTl3dnJUCEwlnwNSr5hpbk9BdCADAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MDUyMjQ2NTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAI+6+5vnGO8beMJiMK6ip
cuNB2H6ZDr43T/PrTitfRfTwt3VobnzDaYaTFZiZtXXYn7AsjvHy/2BxjdDPP1tSkspuOqxkXoJ2
/KTrfFJOy3/ob80hh/Rqo8IevKnQASECKoOvJQn+wXEC1AUgos7mVS2uYSxnrWhShTzZLtbvNmKF
ZXg8Si3tM4npcKlZIDQqjOkZaj4vbXHP4+iyLsRLORzSjSFuxEwWHAAXwLQ5S1qQvJ0DoZStGnNx
SWyxiYwrAvhjt/FY8wtkJp/96IXotfCbJmc+uJvnBQyEm+9ZRAJHxw7enr6F9zSilkJzEl8O4Gjy
5Yv6OOGZQFk4pYNEtg==
--000000000000579e1805e5863e3f--
