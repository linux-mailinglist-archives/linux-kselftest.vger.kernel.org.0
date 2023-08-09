Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F615775E94
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjHIML2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHIMLX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:11:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E661FEF
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:11:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so9752a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691583080; x=1692187880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ch80sZySwK2H1WT73/ypZhoPOqBgd38Q2lXyWu0o+Fw=;
        b=z4mBqMJosgfQZ0UEAW4qJSjeMZo0kc/WG5xK8IKtcKWFVuqTLdJfKAh0rVbORIKEFp
         OkIbZFXiOPlX0zAlA9glN4Yuy6X3WR8hTlaHpCZuH7YdaxqaYa1T9sMetN+MZDW+6XKt
         Pa7jVvxGKW2J6gNrtG6hmbbQrtf8/biJ32oTbUB8TKCcv8x7W5TAvg164ktPU7x60KB1
         fJIptzOrjRBikCDi/IW+WWHgelMUgaFEWeCX74zWUrDVhgxur/95peyzYHYoPH0DU20I
         43RfX2JUo1WUGpH7k3if5Ul1mqB0C5EuVbPyKF3RX9cYmeP6usrcXDfVAo9U/La/4TNm
         ieew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691583080; x=1692187880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ch80sZySwK2H1WT73/ypZhoPOqBgd38Q2lXyWu0o+Fw=;
        b=YvxufJjOvX9DPKwpTi6D068mN9/IzSqd/LTrs7Zl9KCtO7OqNAM4JZJyT68M7TEew/
         XNnf5bsSQgQQsbq7jBOuMeRp/alCQG7EKnx7LzgAOcTz4HEcPyowIkTK0cWK7GNRRxbX
         0mHdz6kkMQrwIYQlqHY0LphGstH02+dUbNNyERCRyWnzY1RlAIk7VyfJbT/c03r6UynV
         mANr5Mw1nylnxphPI/PmVCy/H4Zb8wJA22GXqqq9Lpo84TbL9eca0SIw8VCCcPKuRxWT
         s38OOEV7rqxbYwv3dmlSmOFFUVAD3x0O2Qkrlive1jF3eGivKH3PewxUScaYdDHIo9z/
         Rn0Q==
X-Gm-Message-State: AOJu0Yx19UVlkLlC4Bmy4wPlBM4BXzIf7nskVE7qJvLBwH3S2uT+MCXt
        2hjvZDjyGMDg3N2wMuFSzsWIR4SGubl9yDZ2KHCM2A==
X-Google-Smtp-Source: AGHT+IFcbI7+TVqi1QnX1WIMCPoGpECfn+hk9799z7A6XqTqdUccO7axr6bw5nL0cGOAfwBKJzTDnzKc+m00mnbmWf0=
X-Received: by 2002:a50:cc9b:0:b0:523:193b:5587 with SMTP id
 q27-20020a50cc9b000000b00523193b5587mr87413edi.6.1691583079849; Wed, 09 Aug
 2023 05:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230808123529.4725-1-rf@opensource.cirrus.com>
 <20230808123529.4725-3-rf@opensource.cirrus.com> <CA+GJov79EJLbdptX+hhTqa90C7A0aJ-wzjxF1LDn++jWHeNXFA@mail.gmail.com>
 <371a6ba0-c076-8e44-ae2f-32429de507da@opensource.cirrus.com>
In-Reply-To: <371a6ba0-c076-8e44-ae2f-32429de507da@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 9 Aug 2023 20:11:08 +0800
Message-ID: <CABVgOSmO3cH_oDN1sNWaNYRy8uLxHHUkWPhTevWhHgMjd4LQ5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kunit: kunit-test: Add test cases for extending
 log buffer
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Rae Moar <rmoar@google.com>, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000099722706027c60e1"
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

--00000000000099722706027c60e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2023 at 17:39, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 8/8/23 22:16, Rae Moar wrote:
> > On Tue, Aug 8, 2023 at 8:35=E2=80=AFAM Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Add test cases for the dynamically-extending log buffer.
> >>
> >> kunit_log_extend_test_1() logs a series of numbered lines then tests
> >> that the resulting log contains all the lines.
> >>
> >> kunit_log_extend_test_2() logs a large number of lines of varying leng=
th
> >> to create many fragments, then tests that all lines are present.
> >>
> >> kunit_log_frag_sized_line_test() logs a line that exactly fills a
> >> fragment. This should not cause an extension of the log or truncation
> >> of the line.
> >>
> >> kunit_log_newline_test() has a new test to append a line that is exact=
ly
> >> the length of the available space in the current fragment and check th=
at
> >> the resulting log has a trailing '\n'.
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >
> > Hello!
> >
> > I am happy to see so many tests in this patch series. I've been
> > working with these patches and the debugfs logs seem to be working
> > well.
> >
> > However, when I ran the new kunit-log-test tests three of the tests
> > failed: kunit_log_extend_test_1(), kunit_log_extend_test_2(), and
> > kunit_log_newline_test().
> >
> > The diagnostic info for kunit_log_extend_test_1() reports:
> >
> > [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> > lib/kunit/kunit-test.c:705
> > [20:55:27] Expected p =3D=3D line, but
> > [20:55:27]     p =3D=3D "xxxxxx=E2=80=A6xxxx12345678"
> > [20:55:27]     line =3D=3D "The quick brown fox jumps over the lazy pen=
guin 0"
> > =E2=80=A6
> > [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> > lib/kunit/kunit-test.c:705
> > [20:55:27] Expected p =3D=3D line, but
> > [20:55:27]     p =3D=3D "The quick brown fox jumps over the lazy pengui=
n 1"
> > [20:55:27]     line =3D=3D "The quick brown fox jumps over the lazy pen=
guin 4"
> > [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> > lib/kunit/kunit-test.c:705
> > [20:55:27] Expected p =3D=3D line, but
> > [20:55:27]     p =3D=3D "The quick brown fox jumps over the lazy pengui=
n 2"
> > [20:55:27]     line =3D=3D "The quick brown fox jumps over the lazy pen=
guin 5"
> > =E2=80=A6
> > [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> > lib/kunit/kunit-test.c:709
> > [20:55:27] Expected i =3D=3D num_lines, but
> > [20:55:27]     i =3D=3D 64 (0x40)
> > [20:55:27]     num_lines =3D=3D 141 (0x8d)
> >
> > So it looks like the log contains a different number of lines than
> > expected which is causing the difference of 3 between expected and
> > what was obtained. Potentially the log is not getting cleared/freed
> > properly in between test cases?
> >
> > The diagnostic info for kunit_log_extend_test_2() reports:
> >
> > [20:55:27]     # kunit_log_extend_test_2: EXPECTATION FAILED at
> > lib/kunit/kunit-test.c:776
> > [20:55:27]     Expected p =3D=3D &line[i], but
> > [20:55:27]         p =3D=3D
> > "xxxxx...xxxxx123456780123456789abcdef101112131415161718191a1b1c1d1e1f2=
02122232425262728292a2b2c2d2e2f30313233343536373839"
> > [20:55:27]         &line[i] =3D=3D
> > "0123456789abcdef101112131415161718191a1b1c1d1e1f202122232425262728292a=
2b2c2d2e2f30313233343536373839"
> > [20:55:27]     # kunit_log_extend_test_2: EXPECTATION FAILED at
> > lib/kunit/kunit-test.c:781
> > [20:55:27]     Expected n =3D=3D num_lines, but
> > [20:55:27]         n =3D=3D 147 (0x93)
> > [20:55:27]         num_lines =3D=3D 155 (0x9b)
> > [20:55:27] Not enough lines.
> >
> > Similar difference in the number of lines here.
> >
> > The diagnostic info for kunit_log_newline_test() reports that the test
> > fails on this line:
> >
> > KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
> >
> > Let me know if you are seeing similar errors. I can post the full log
> > if that would be helpful.
> >
> > -Rae
> >
>
> Ah, I see a bug in get_concatenated_log().
> Does this change fix it for you?
>
>         len++; /* for terminating '\0' */
> -       p =3D kunit_kmalloc(test, len, GFP_KERNEL);
> +       p =3D kunit_kzalloc(test, len, GFP_KERNEL);

This fixes what seems to be the same issue for me, under x86_64/qemu.

Thanks,
-- David

--00000000000099722706027c60e1
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBX
7V3HU8N/FHUutyhL9Ibhg+KnWEjwhce6wMNyG2iECjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDkxMjExMjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANcUJnBizVUxVRZJn1PVZ
vgeRsTNR9+erhk++q9s6PFpiulJEmYFATNiZvw40e0DQEvX+7k9gxVj2MzB0IUH8CDI+T1nQ3e40
FOao9K36G/ZHlIXg5OQ2/LDrv++nC44sQ79F8UHaOamr5gHNIErzWOp/YTf7gu1n54zfeac0fw4j
qZmH9AZM+9FaOsPjKPglkZfPzaxns1N47htzh0srVPqKryOonTO/oiX+fwi1aF+BeSZqHiohz7qt
AUSef3T3CabNfpyJhwv236+8NMcFlcY4oUFd77BDa91ZLva9NvxEuDgodoSng5LlkDBtTU8Mskeu
94+d26mgLxLaKKig9Q==
--00000000000099722706027c60e1--
