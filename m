Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0156E06FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDMGa2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 02:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDMGa1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 02:30:27 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F57DB3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 23:30:26 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id x8so1478683uau.9
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681367426; x=1683959426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk4EXv1uN2QIH5fcCW7yS2mPqDhHk9K4pJV8NhVW0Qg=;
        b=1/Uilmza7sFZoiNmqUHMUMXhO11eM0dXrcBijO6ESQxkZnh4kksr1i3UWif9IETl8z
         OPBwZ4L3YHZVRsvlwGwEZNxgAGGJq1ZaRfOZXE7LlP99pOVTskzRDq8K4d0CvzSLOc6K
         Mpn0fy0gzV0hz9naLb3Om0i+yPiOwgYiSkPIu7yb04qMAzIihxSFl8GDJiatUm1Lhji+
         bhXqwo08v7zD8jrdvsSlp24ka5jh/IsTvXmmL/E0lZ7UrwDiFOVSbddJ54iL+IqiGy/R
         k93/vwIHkk5GXm2ynO+B1NeJ4JNCRi6LKvqUgb/yRefkB7Cm8ENqstu2m4d5guy1MXMH
         Bx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681367426; x=1683959426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zk4EXv1uN2QIH5fcCW7yS2mPqDhHk9K4pJV8NhVW0Qg=;
        b=Jts6QrvbXjHaOKRQc3QCcVClVUxFwZYtpdM4jmUWv/smoxT0PqYsNl2lwi7uOJXBr7
         7NAljsEBM/wVjE2Mj7q9Xm9tfjYIKyedOKJUEgCnPIoR3eR1+jcp/GN3ulGrmUeqSK4A
         lPtMmeqM1l7iArAuqHBzW2S9TlV5juO4bJWRH9bnjdJauFoCtEX7Hvk9EpdOud6LNLAa
         qAuGKmJFNd5HhZQ3xWN8kawzT/6aZd5f5YP3QPbyWcYfwL/+XZLUqQsIZZ1wz3GGBbY3
         u8fm4+NRVaR66sjb6Ak+THIdQro7EQqRECX7kI95mlICyI8IKiybeUQLIvMuiWRJbaX7
         g6Vw==
X-Gm-Message-State: AAQBX9dx77e+JjLeGV9rRFAXQiT+WhTzfaY/g3UsVFupGyTzkpe30DFU
        iraf6MiwCE6AYkUhG8HWNQUHA3DWNRrZFKcJ9gGEzA==
X-Google-Smtp-Source: AKy350aXY0iLQd/LQYuoZT08QUoppELjyxcOXBRKSJK39vIXIm9zekESlLXtOwcJ9O0XgwTq1LQiKMoYz4vrcaGm2ds=
X-Received: by 2002:a9f:3053:0:b0:771:dcb0:4938 with SMTP id
 i19-20020a9f3053000000b00771dcb04938mr499978uab.1.1681367425684; Wed, 12 Apr
 2023 23:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com>
 <20230411160056.1586-2-michal.wajdeczko@intel.com> <CA+GJov4g+D=9nwcVUsKsmM_4j41J_eBee5Nmt-OmHqhfuEKqsg@mail.gmail.com>
In-Reply-To: <CA+GJov4g+D=9nwcVUsKsmM_4j41J_eBee5Nmt-OmHqhfuEKqsg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 13 Apr 2023 14:30:14 +0800
Message-ID: <CABVgOSkbU=f8WOgTW-N_BxuwXzfPdRdT4XVLMszb-7E+_XYESA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit/test: Add example test showing parameterized testing
To:     Rae Moar <rmoar@google.com>
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002a702405f931dcfe"
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

--0000000000002a702405f931dcfe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Apr 2023 at 04:51, Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
> >
> > Use of parameterized testing is documented [1] but such use case
> > is not present in demo kunit test. Add small subtest for that.
> >
> > [1] https://kernel.org/doc/html/latest/dev-tools/kunit/usage.html#param=
eterized-testing
> >
> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> > Cc: David Gow <davidgow@google.com>
> > ---
>
> Hello!
>
> This looks all pretty good to me! I only have one comment. In the KTAP ou=
tput:
>
>         KTAP version 1
>         # Subtest: example_params_test
>     # example_params_test: initializing
>         ok 1 example value 2
>     # example_params_test: initializing
>         ok 2 example value 1
>     # example_params_test: initializing
>        ok 3 example value 0 # SKIP unsupported param value
>     # example_params_test: pass:2 fail:0 skip:1 total:3
>     ok 6 example_params_test
>
> The init method is causing the "# example_params_test: initializing"
> to print lines for each case. However, since they are not inline with
> the correct indentation and they don't include helpful test data, I
> would consider finding a way to remove these.

I think this is probably a problem for the kunit_log() infrastructure,
rather than init functions in general.

I'm not worried about them in relation to this particular test.

>
> We could consider removing these lines from the test suite as a whole.
> However, they are helpful in that they show how to use the init
> function. Maybe check if the test is a param test case in the init
> function itself? Let me know what you think.
>

I'd rather keep these as-is: the idea is to have a very simple example
of an init function, and complicating further by checking which test
is running is needless complexity, IMO.

-- David

--0000000000002a702405f931dcfe
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAb
E2x42pTEIE4qqbm0ZCzjlw+d0CSaGMIhBSo0AXVQKzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTMwNjMwMjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACvQhe3RGn7k//pCue1LR
HWIlwxEGrkbSTW4hqlBB+iE1xcy9JFjDPNNMUnc7h2S8NrxPuEtyRG34GPutaB2YY+RKsWtOoIRL
H0Rh+Bl9N0EMLEC4QSOcjnQHBsOjTG2Kyhf2BPV1DkiKBKZ3+WvtdvavXxq50F1K+nc/eDxf9kgl
0/7HpR+3Re9ju8S+wfEsz3Q0Z83vju0da7ymKDA67JNxYrgDhqUttjg63QrysGMEpBIUP3tbLybL
61da343o8IG187bdyctcEHcFOvjf+UDtpbE9pE01HJoTeBXpxCeuIKUqhAGolnxYG4YDfeUDpGjg
N7ffa1Riutc7+IjUMg==
--0000000000002a702405f931dcfe--
