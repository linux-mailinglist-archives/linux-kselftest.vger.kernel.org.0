Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1D6D198F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjCaIP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCaIP5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:15:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6851B10E
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:15:56 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id bl9so9411298iob.8
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680250556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ffRqsNvfkDmV4wJywYbipv4WJ5GK5lgWX/rB+U2+x0k=;
        b=hl98ooJOqFp/xRstIEq5+LCOVMStYhhaP5jMrmRFaR2SGUOF8a1ZUkWGZgcSW9wJoX
         hss/NTAV+zPmNANhhGK0AK7z0xG4aPCX573PIwsEbk4VerQ3XflzqR20JqObtnG1e3Ef
         CSnd1E9BK18VM4KiTUk9JNUHUpEieN3TffNUcwfJ7aPrfQBI3o40WEmPWvniRkXg1j1Z
         Qie+ZBKrpntX/dbxlGjLzORsbDeGzu8k+NNG7ALwWbeLOGuq7s1QYF8jg8XVQDqqvR3z
         vd8erzrFAnJ1DkBD+omvP//i4NFgeHvzUputuhg7+qsOJKeYw2vg40eC4bTuY66FM+3O
         rXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680250556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffRqsNvfkDmV4wJywYbipv4WJ5GK5lgWX/rB+U2+x0k=;
        b=TEDCRlUaL7ChPEAkvbqnyaG2erloFh/1jOm4SzkWHLerlD/zpl4YAlhNV/I8K6sYoF
         /srTWe9F/UC5oMcnphK5tLGBMO8EAvKU3IlxmggD9QI2FLonsZLvCRxw5it8K5QMmKw/
         yBu0UrBFgX3g0Rya265IJhWopfnnzcbZGDNbtPfCkYRCT+5mE7gWxhR9JUMJRrLzGCp4
         QTagbZ+/uDB3ZvRrET/kjGWFzoil3xeEaFONHRPGTGBIDZA+xNt528vlvI0fN9i/oEm5
         eOuOukxDO3lIPQpgoX6SOmfz/t4Ywd+8Rsl3KHe1mBPosOIBsP80M8q+jrPDQY0Y7bYj
         u47g==
X-Gm-Message-State: AO0yUKXBmTIjL7xdXP7w4NA+Y2xYYBQTNccIwqQnfPRQUbISU6e+gYUT
        PYvwSx8AB1Mp2YtqhXrsBa2eEK3DtJaL7QMocr/vaw==
X-Google-Smtp-Source: AK7set8Xj2aM7CPfBxqKMgcJsCcdrj5tNUM56sQrxwn1iKlLHI9ArVggLcbSrIvclow7J3ZFmUN7IZf0VN3OhXOTE40=
X-Received: by 2002:a5d:980c:0:b0:753:113d:3c66 with SMTP id
 a12-20020a5d980c000000b00753113d3c66mr9240451iol.4.1680250555626; Fri, 31 Mar
 2023 01:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230330220506.1399796-1-rmoar@google.com> <CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr+f+mOVKT1bGvA@mail.gmail.com>
In-Reply-To: <CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr+f+mOVKT1bGvA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 31 Mar 2023 16:15:44 +0800
Message-ID: <CABVgOSmVq2NGuDoKuLqhdTBA8NzwBAiC9pDhf3PiKS1zLhgZjw@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add tests for using current KUnit test field
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008653b805f82dd169"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000008653b805f82dd169
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Mar 2023 at 06:21, 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> I've got a few minor comments below, but this otherwise looks good.
> I like the idea of testing knuit_fail_current_test().
>
>
> On Thu, Mar 30, 2023 at 3:05=E2=80=AFPM Rae Moar <rmoar@google.com> wrote=
:
> >
> > +static void kunit_current_kunit_test_field(struct kunit *test)
> > +{
> > +       struct kunit *current_test;
> > +
> > +       /* Check to ensure the result of current->kunit_test
> > +        * is equivalent to current test.
> > +        */
> > +       current_test =3D current->kunit_test;
> > +       KUNIT_EXPECT_PTR_EQ(test, test, current_test);
>
> Perhaps we can combine this and the next test case down to
> static void kunit_current_test(struct kunit *test) {
>   /* There are two different ways of getting the current test */
>   KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
>   KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
> }
> ?
>

Agreed: checking current->kunit_test twice feels a bit odd.


> > +}
> > +
> > +static void kunit_current_get_current_test(struct kunit *test)
> > +{
> > +       struct kunit *current_test1, *current_test2;
> > +
> > +       /* Check to ensure the result of kunit_get_current_test()
> > +        * is equivalent to current test.
> > +        */
> > +       current_test1 =3D kunit_get_current_test();
> > +       KUNIT_EXPECT_PTR_EQ(test, test, current_test1);
> > +
> > +       /* Check to ensure the result of kunit_get_current_test()
> > +        * is equivalent to current->kunit_test.
> > +        */
> > +       current_test2 =3D current->kunit_test;
> > +       KUNIT_EXPECT_PTR_EQ(test, current_test1, current_test2);
>
> > +}
> > +
> > +static void kunit_current_fail_current_test(struct kunit *test)
> > +{
> > +       struct kunit fake;
> > +
> > +       /* Initialize fake test and set as current->kunit_test. */
>
> Nit: I think the code is self-explanatory enough that we can drop this co=
mment.
>
> > +       kunit_init_test(&fake, "fake test", NULL);
> > +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> > +       current->kunit_test =3D &fake;
> > +
> > +       /* Fail current test and expect status of fake test to be faile=
d. */
>
> Nit: I think this comment could also be dropped or maybe shortened to
>   kunit_fail_current_test("This should make `fake` fail");
>
> or
>   /* Now kunit_fail_current_test() should modify `fake`, not `test` */
>   kunit_fail_current_test("This should make `fake` fail");
>
> > +       kunit_fail_current_test("This test is supposed to fail.");
> > +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAI=
LURE);
> > +
>
> Hmm, should we try calling
>   kunit_cleanup(&fake);
> ?
>
> Right now this does resource cleanups, but we might have other state
> to cleanup for our `fake` test object in the future.

I could go either way here. We currently don't do this with the other
status tests (kunit_status), only with the resource ones.
But it doesn't hurt to add it...

>
> Daniel
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr%2Bf%2BmOVKT1bGvA%40mail.=
gmail.com.

--0000000000008653b805f82dd169
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBe
G4H2Y11XPwSxMn/CJtv+NfdwtyQzN7W4NqTA5fe+YjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMzEwODE1NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAK6qv5XIYct6yz+wC7e3Q
ua3Ovh9wmatPFXdgR0DD8FXeejlT8uji4HSGtQEZeQcv3FYtbEmBy0ZSxh7mYm9tvvpKcqcgY/37
XX6h8VGxJlFV4jR5vdbdGP5K3o/VFKsE45cSHqQ57IFg/g3C3eZ+49KgdoEpCcJhvvriJZVBmDC9
NtR85/jcxWcB3rjbLmLnCbF79KEdVbHWcg8Py5VT91MO3O/+SB+QD5UYNhyVwInmty7ZI12XLcob
5Jwt7if8NkkhBKBefAjzuvMFBHjbHj96IR5WcwCtGcpA27EEURQQWsUEYNTgCU7GqPumvLhTj+pp
zwLibANCyw4eSLQWcA==
--0000000000008653b805f82dd169--
