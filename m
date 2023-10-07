Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8E7BC65E
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjJGJON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 05:14:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8EB9
        for <linux-kselftest@vger.kernel.org>; Sat,  7 Oct 2023 02:14:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053f24c900so23205e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Oct 2023 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696670050; x=1697274850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GtK8odGjbOVHYY+Xok+8TgiA1aXPluw7HxWyIj8DzCk=;
        b=aCQ+UIEYRmdZt7ihCqFe427EXXxjBFlktIDHarmz612JmPXam54m2C369g7UTvvX1r
         kEtR48WKzccR8LqobC4B8WgEEAaek4lKZNT87wUbi62UBE3KPtJQOo+OapkPv7eQDmX0
         3jj3hR5GpD2YmbWUotq3goOL9QtE0/TfDRbGBUk/T9ihLbHkYQuC99DmE34GknFV8n/A
         eOPeWrADHWTEB9lIknxmtikvBmVLAVjBTd6W4SlZPm1kpnsnpVOU1BBHHOskhaFYFSK8
         Zad/5BGN66u/KtjVufc0anAGSPloOovAY4KWngAYlvikEQqwaMZGk6vxzUtqNcHSreQK
         okug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696670050; x=1697274850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtK8odGjbOVHYY+Xok+8TgiA1aXPluw7HxWyIj8DzCk=;
        b=uNx2WE0SDizbJ3wvP4ukhTt2iMz4Vl5BhKh+OSp53qAlzW2ug4+ireDJPJgsgCZvC9
         scQsnzQt+DVYLVORAYnvibkmouSoFxSa1AnRrIySjIGGP+w8FCe5OycrbWA07ZNDRtku
         qkmAnjVugqPviSj3WjSXdsPHh/UmdUJsf5zcgY580sjvQ1t5lJ4/M9rVuJuMTCcGvkY4
         E17czuF7Akd989OKaji+nL8praZKmtdN0hYMUgji6I9Ymbk92NqMjCSyljhsSLOeg7Eb
         79m/OqoeghvRCY4IT74YhoO7FldoC/xJLmtElpXJOTo+U9E3XIsc4jzn0TkswB0ItpCl
         kyNg==
X-Gm-Message-State: AOJu0Yx4h0NTWa5ynPPAgrGI5MBWXgv08Y4ksYNGkvN5pZOsx91sMc1h
        hTr97GKvDA2HznjnsFYukHp18DtHrOfM9otjtaUmaQ==
X-Google-Smtp-Source: AGHT+IFk9ixRvMJ8hcSwY+SG2LWnK+meGNUgF/XXA9tamWtwiC+Ru0d6qSS3+1LXK+cQgsvlgbxChxJDZ7+n/or8h+M=
X-Received: by 2002:a05:600c:2182:b0:404:7462:1f87 with SMTP id
 e2-20020a05600c218200b0040474621f87mr245670wme.6.1696670049821; Sat, 07 Oct
 2023 02:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com>
 <20230925175733.1379-5-michal.wajdeczko@intel.com> <CA+GJov4o9ixrbSma-9SABH4n88AXFD=nDG6+C=wfVVMgzLoprA@mail.gmail.com>
 <80c0f713-662a-9cdb-e430-88c854ab2192@intel.com>
In-Reply-To: <80c0f713-662a-9cdb-e430-88c854ab2192@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Oct 2023 17:13:58 +0800
Message-ID: <CABVgOSnWk69_QO1ec3H698asAGvBBigVOD428u1H0Rckt188rA@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: Prepare test plan for parameterized subtests
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a6185c06071cc7ee"
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

--000000000000a6185c06071cc7ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Oct 2023 at 21:55, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
>
>
> On 28.09.2023 22:54, Rae Moar wrote:
> > On Mon, Sep 25, 2023 at 1:58=E2=80=AFPM Michal Wajdeczko
> > <michal.wajdeczko@intel.com> wrote:
> >>
> >> In case of parameterized tests we are not providing a test plan
> >> so we can't detect if any result is missing.
> >>
> >> Count available params using the same generator as during a test
> >> execution
> >>
> >> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Rae Moar <rmoar@google.com>
> >> ---

<...snip...>

> >
> > Hello!
> >
> > This change largely looks good to me. However, I am not 100 percent
> > confident that the function to generate parameters always produces the
> > same output (or same number of test cases). I would be interested in
> > David's opinion on this.
>
> Right, it's not explicitly specified in KUNIT_CASE_PARAM nor
> test_case.generate_params documentation, but I would assume that while
> generating different output could be fine (and harmless to this patch),
> like based on a random seed, but IMO at the same time it should be
> prohibited to generate different number of params, as this would make
> harder to compare each execution for regression.

There are definitely some valid cases for parameterised tests to
generate different numbers of tests in different configs /
environments (e.g., there are some where the number of parameters
depends on the number of CPUs). That being said, it shouldn't be a
problem in a relatively standard test environment with any of the
tests we currently have.

Some of these issues can be got around by having tests be generated
regardless, but having those tests be skipped if required.

>
> Alternatively we can introduce some flag to indicate whether provided
> param generator is stable or not and then provide test plan only for the
> former.

I think this sounds like a good idea, and a use for the KUnit
attributes system. I'd thought that a 'deterministic' attribute would
make sense, but it may make sense to split it into a 'deterministic'
and 'fixed structure' flag (the latter only requiring that the number,
order, names, etc of tests and subtests be the same).

There have been a couple of people asking for a feature to
deliberately randomise test ordering, too. We'd want to clear these
flags if that's in use.
Of course, ideally anyone doing regression testing would be able to
use the test/parameter name/description instead of test number, so
ordering of tests shouldn't matter unless tests were buggy.

--000000000000a6185c06071cc7ee
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBs
XtrZlss9IfwGzntRLXQ/v4VCH7pW1Pp+Nhdzu5dRgDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEwMDcwOTE0MTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkh0mH0nC3A1IwU9A9bcR
4nhijR5OKglzcUP9XTFreuNew95CqS8mWf0AaOpEAS/jnTfWnN2SHSdGnaGP1xdZf0ivJWKtlKkM
0IAeCOdRkuOtLjhmb11uG0ASRefTEviQ5NGMGFEMrmLPqKcYsg1Wlh9FEqYctwPJcGahNiOA4LV0
WW3TmDFuXh6r/Frf/X7oq77mZHXZxIsK2kY5Y+uq4K6WL/x2uc8OI0Yi5bSmiaCRyFKWKSCzSc/s
COuNWQDMuAmU1FlJoQCSYumldFw+mvvYuONuZsOYMPnrZ+1SGRvUYcWwNQlctFlQWzXzVZUD0etD
yW52hmrNY2EHMT8rrw==
--000000000000a6185c06071cc7ee--
