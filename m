Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C22783636
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 01:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjHUX0o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 19:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHUX0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 19:26:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB15A1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 16:26:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fee2ba9d09so17485e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 16:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692660400; x=1693265200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGIsxcuS1Y4lS9oj6h1qlRyS7zpiuhX4lm65iH1boMw=;
        b=qqQVuT9hk3UznraHh5olr9MS1vW5VY0Pa4iFaEDePJW3E+wvWCrZm+NTNWOuHHTjpM
         Embugw8xCr7n+mxVHMzj+JnMGg5D/RlApfPzF98JPo0du1nQ6RO9X7gSVAXizTqOMvHN
         yxHvpMNArgehnGELZM6ARGpned+AOTiBxP0kOPkJl30PyhfJ9YTeCJVp3dEW7RRu9pGF
         PUFQbpRAhjLR5xiUAJoCo7aldqmY4StdaSW8gbm7M4TZ0ZLcThrIY3scfYu7hGiKhDNK
         wVUbgLGXrRofCJxVkDq9qoBHp8V9ogSGfkmhljuYZu9ZZmRRopYSbNw/NOmrjRumpDDr
         XqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692660400; x=1693265200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGIsxcuS1Y4lS9oj6h1qlRyS7zpiuhX4lm65iH1boMw=;
        b=Cd0XywBPgmWCBus/rpTMizVkbBfZdDaE+E+L+IWc/lv4WnikqpbQOk21S6XMPy9s/J
         f+dBq6rDW6TXXPkAM34ThJEhLDGEfyO8g3k6ENCjw6xZzaC7DbHRmUYBYYnHBk97TJDX
         OR7Xes1EuzMHQYjEz4mamAqm8CroOSdxoyXAMMgKkNdvXl5agurCRwqRf2tYbOfGfxAy
         ASNr+ArgAzlcoh+hlQUglbf/22Y+x4Baqjv1hOiRwSfLUo8Xz4sPWZhYuAp/66SaAYNN
         LGYOeV4Ojg7zNz04FkIadAMl7acM4TbWMmOe7YHSclLQE4M4SsY1O59UZ+qY5qRH7FKT
         dVng==
X-Gm-Message-State: AOJu0YzpncJ1Uo6kulykiqAJraWXl8Ysh7RrncdPEYCWx/BVT1x1UZ36
        JAOMsnlavtuBjL7C5+5O7ibwLSMrJfV/NJIksHFCxw==
X-Google-Smtp-Source: AGHT+IGnX9RjCHrnb/K0T/JB/xlTq4uin4K4kU47QkRsLqAPPdbmomkSs45W46x0anYc/DXtFyetXx3DW9AuyksLgwA=
X-Received: by 2002:a05:600c:82c8:b0:3f7:e4d8:2569 with SMTP id
 eo8-20020a05600c82c800b003f7e4d82569mr22225wmb.5.1692660400045; Mon, 21 Aug
 2023 16:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
 <20230814132309.32641-7-rf@opensource.cirrus.com> <CABVgOS=WoKEpPU=0f=mSfdx1g6AkEtx6QJTiNru1XSTev3sGaQ@mail.gmail.com>
 <a8804709-ee00-d2ea-d55d-f8138bd3a500@opensource.cirrus.com>
 <CABVgOSmPqM_zt9jGzYcJN-=AQW3z62cC7dzPJkV-jx6rCcMy=g@mail.gmail.com> <0b780ce7-66a4-1a36-2a8a-a69c95f73d8a@opensource.cirrus.com>
In-Reply-To: <0b780ce7-66a4-1a36-2a8a-a69c95f73d8a@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Aug 2023 07:26:27 +0800
Message-ID: <CABVgOSkYYMOmYdY4zm3i2aMDyTnDVY+53JTDyUBtP5Kaj7Bqsw@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] kunit: string-stream: Pass struct kunit to string_stream_get_string()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e5a76506037735e7"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000e5a76506037735e7
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Aug 2023 at 00:10, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 17/08/2023 07:26, David Gow wrote:
> > On Tue, 15 Aug 2023 at 17:57, Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> On 15/8/23 10:16, David Gow wrote:
> >>> On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
> >>> <rf@opensource.cirrus.com> wrote:
> >>>>
> >>>> Pass a struct kunit* and gfp_t to string_stream_get_string(). Allocate
> >>>> the returned buffer using these instead of using the stream->test and
> >>>> stream->gfp.
> >>>>
> >>>> This is preparation for removing the dependence of string_stream on
> >>>> struct kunit, so that string_stream can be used for the debugfs log.
> >>>>
> >>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >>>> ---
> >>>
> >>> Makes sense to me.
> >>>
> >>> I think that, if we weren't going to remove the struct kunit
> >>> dependency, we'd want to either keep a version of
> >>> string_stream_get_string() which uses it, or, e.g., fall back to it if
> >>> the struct passed in is NULL.
> >>>
> >>
> >> That was my first thought. But I thought that was open to subtle
> >> accidental bugs in calling code - it might return you a managed
> >> allocation, or it might return you an unmanaged allocation that you
> >> must free.
> >>
> >> As there weren't many callers of string_stream_get_string() I decided
> >> to go with changing the API to pass in test and gfp like other managed
> >> allocations. This makes it more generalized, since the returned buffer
> >> is not part of the stream itself, it's a temporary buffer owned by the
> >> caller. It also makes it clearer that what you are getting back is
> >> likely to be a managed allocation.
> >>
> >> If you'd prefer to leave string_stream_get_string() as it was, or make
> >> it return an unmanged buffer, I can send a new version.
> >>
> >>> The other option is to have a version which doesn't manage the string
> >>> at all, so just takes a gfp and requires the caller to free it (or
> >>
> >> I didn't add a companion function to get a raw unmanaged string buffer
> >> because there's nothing that needs it. It could be added later if
> >> it's needed.
> >>
> >
> > Fair enough.
> >
> >>> register an action to do so). If we did that, we could get rid of the
> >>> struct kunit pointer totally (though it may be better to keep it and
> >>> have both versions).
> >>>
> >>
> >> Another option is to make string_stream_get_string() return a raw
> >> buffer and add a kunit_string_stream_geT_string() that returns a
> >> managed buffer. This follows some consistency with the normal mallocs
> >> where kunit_xxxx() is the managed version.
> >>
> >
> > Ooh... I like this best. Let's go with that.
> >
>
> I was busy last week with other things and have only got back to looking
> at this.
>
> I'm trying to decide what to do with string_stream_get_string() and I'd
> value an opinion.
>
> The only use for a test-managed get_string() is the string_stream test.
> So I've thought of 4 options:
>
> 1) Add a kunit_string_stream_get_string() anyway. But only the test code
> uses it.
>
> 2) Change the tests to have a local function to do the same thing, and
> add an explicit test case for the (unmanaged)
> string_stream_get_string() that ensures it's freed.
>
> 3) Change the tests to have a local function to get the string, which
> calls string_stream_get_string() then copies it to a test-managed buffer
> and frees the unmanaged buffer.
>
> 4) Implement a kunit_kfree_on_exit() function that takes an already-
> allocated buffer and kfree()s it when the test exists, so that we can
> do:
>
>     // on success kunit_kfree_on_exit() returns the buffer it was given
>     str = kunit_kfree_on_exit(test, string_stream_get_string(stream));
>     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
>
> I'm leaning towards (2) but open to going with any of the other options.

I'd be happy with any of those options (though 3 is my least favourite).

There is already a kfree_at_end() function in the executor test. It's
not quite as nice as your proposed kunit_kfree_on_exit() function (I
like this idea of passing the pointer through), but it proves the
concept. I think your version of this would be a useful thing to have
as an actual part of the KUnit API, rather than just a per-test hack:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/kunit/executor_test.c#n131

Cheers,
-- David

--000000000000e5a76506037735e7
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHOBX7j6YmdTMbtcPLp
3a4wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA4MTUw
MjQyNDNaFw0yNDAyMTEwMjQyNDNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnYKS3ueVXUlVatkXVQgk8pbgZH4/s
KBKSGW9Z8e4hylAI35vqFf5f5D4U5KhUYUyG0+AYhurwEiUyZUhGcLqRNmSroohx9nbZjXDXjkVV
LXBAr7xaCU3DDQcA1SaxmALxBC7u4zlcVHfUKope2JNJ2xn5kU0Z/kr01tZuJD5/jn+2hp68jdym
tbFd3zzOJmtG6hb4ULJNXSi1qkjtZp6SyDLEsliQGRuI5AIha7GQPeSNsFmIpi+V5UxhrznuAv0y
Uxd27MtO+/mgSMpLmUb4vuSjy2zuftatzVYvFG00pfHldrnJ1od+kW8lAl6gyahVgMp+j3GAlO2M
oGCkihK9AgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJO3Y8Jq
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBV
H27UdWdbxd1N9SDrr9Y9Hx63Y5u8FLr0elceCt52+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjEyMzI2NDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIa/lb/XlY3M867+ruhk3
/atS4YlC57D20R+/GRxUzBFqD/I+qbQOlRuOIm2nY8wgakZG9SNKtYo6olfwhnQ0V+fG23kUUvwo
E+Isiu5srwARV7y8jz2inpAHFVCT2bjpZgl7Gs3kiVQFQk63aFZ/cTUjVut1vSjg58/yIGDydedW
UTc+MFtMNqDOu2xnmVGcku1YcAZD0LGClAKPA7ohUDZ0+m1axMl7ELZJaFxEpFKWqxDqykzd4Pd9
e+kAXTxYJgfLQafvyGH4hQk/5xHkrDz18+86y2uofpUvcLcryG7pO3BbGkwh5gnR4QdVZ4iKn6EK
DH/DHX58EUMVRjot+A==
--000000000000e5a76506037735e7--
