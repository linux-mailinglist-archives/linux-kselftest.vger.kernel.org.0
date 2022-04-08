Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084634F8D5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiDHEUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 00:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiDHEUQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 00:20:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DC9BBBC
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 21:18:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d3so11019407wrb.7
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 21:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf6k+xg0cOorpz2SfKZVAriYbOHJ8FizJbt8o9l4H0s=;
        b=iu1zsRPHlQzZNFgeS/U3oqAhF988AEhXI7QmSI7Fl916GE5Gqi+s/a/UCQY4y0PxiG
         22yXyhKspuW5Y7rwqQ6ubRtjPTmX0MPgTyyP01mXBZ6bQVi+CN++jpvavPSKW1EiHNVp
         oSU/6bfPljvWwwk487XKoqHldHURsg/fyOxZ2RLYBU7gF0TkBAhJjbmuPfraZZnoB9iV
         vV0XimLhJ+Cambqbr7gN6a7sUEaNJTASFws7bP9NljPnHUpoqvztbzlj5HIHThypapP0
         8xskayJH2txcsxHD1xaofDPjrKEolyPmOpbUciPhqQ7aC8nrjvp40yMj5A3C950mgPGe
         Dy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf6k+xg0cOorpz2SfKZVAriYbOHJ8FizJbt8o9l4H0s=;
        b=oRXRSwToRBUxnZ/sY94vznwekNKW8a8uPi3knCW1A2OKbD4ffAI8znSVX9tuG8tVsf
         ScnTGVwjU8hc8O2buWcXM64YGKBRxcuoA4KJ2K6CpXYyz7je9Gi8vhldYdbkbUxDK8fQ
         DOZjCkkt4UaC9B65KAObRzZY8SZLWTeDK7gDZuqdN7dgp//ub7f74XELUJOQDZTk4oBi
         64dKd8vEjAink29DIdPh+QRjaT0KIe4WwgnC2SaA8DO5VZkh9GybJlZ6pCysXNUe4bSQ
         H3t0DUYkyzeu40zivOqhFza5vyjOz2+Vh14VwoEbv5TO4XuKo3kCgAzEVH5Cxvw1Tzl/
         3Q/g==
X-Gm-Message-State: AOAM532lI8X/mkWoh4qrJ2x28t5IgtbEyeHsflSTGqFoPdidcy3cnA+a
        R/2qvxp/4wVMOR+t2VELij/oCMC1m0seKqww+1/zPg==
X-Google-Smtp-Source: ABdhPJzN/0IdhOHQvPpjJZy/3tqBtke+9+ux15v9hrs6oRQgSb6lf1wtIjRFCutlZA2DYeodgdxwvWrxg4BP4lMxrgM=
X-Received: by 2002:adf:fe84:0:b0:206:1212:8c00 with SMTP id
 l4-20020adffe84000000b0020612128c00mr13235837wrr.269.1649391491662; Thu, 07
 Apr 2022 21:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223019.2066361-1-dlatypov@google.com> <20220408034848.2081355-1-davidgow@google.com>
 <CAGS_qxrNOPq+akyt2Ee4NXySP+Zxqis2H5CwKs_kNWNvJ+bo5A@mail.gmail.com>
In-Reply-To: <CAGS_qxrNOPq+akyt2Ee4NXySP+Zxqis2H5CwKs_kNWNvJ+bo5A@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 8 Apr 2022 12:18:00 +0800
Message-ID: <CABVgOSkKuHCkfpQhzNmzufaVw_6qO-Ve_t5oTub1JeweTiC9RQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Print a total count of tests.
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000faba3305dc1ce15a"
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

--000000000000faba3305dc1ce15a
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 8, 2022 at 11:59 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Thu, Apr 7, 2022 at 10:48 PM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Add a count of the total number of tests run (including skipped tests,
> > which do run a little bit until they decide to skip themselves) to the
> > summary line.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > This patch depends on:
> > https://lore.kernel.org/linux-kselftest/20220407223019.2066361-1-dlatypov@google.com/
> >
> >  tools/testing/kunit/kunit_parser.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index 957907105429..da01998d29b1 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -96,7 +96,7 @@ class TestCounts:
> >                 """
> >                 statuses = [('Passed', self.passed), ('Failed', self.failed),
> >                         ('Crashed', self.crashed), ('Skipped', self.skipped),
> > -                       ('Errors', self.errors)]
> > +                       ('Errors', self.errors), ('Total', self.total())]
>
> Hmm, I've never really felt the need for a total to be printed out.
> We've had few enough tests and different statuses that the mental
> addition is easy enough.

It's useful just often enough as a sanity check (were those failures /
skipped tests fixed, or did we just stop running them): having one
number to check for "did some more tests run at all" is quite
convenient. Particularly when dealing with nasty dependency chains and
"all tests" builds.

This is also particularly useful when running on setups where
scrollback is more of a pain, as the summary line is absolutely
invaluable there.

>
> Bikeshedding:
> This current output of
>   Passed: 40, Skipped: 2, Total: 42
> feels a bit awkward to me.
> If we did print one out, I think it should probably go first, e.g.
>   Ran 42 tests: 40 passed, 2 skipped.
>
> Wdyt?

I personally don't find having "Total" at the end awkward -- putting
the sum at the end has been done on ledgers for years -- but do admit
it's even more convenient to have it first (so it's at the same place
on the screen every run, regardless of the rest). So "Ran 42 tests: 40
passed..." would emphasise the "total" over the "passed" count here.
Personally, I think that's probably a good thing: I think what most
people really want at a glance is effectively "Failed / Total" (or,
more realistically a sort-of "Problems / Total", where problems is
Failed + Error). But the combination of the colour (did it pass
overall) and the total are the things I'd usually want to look for
first.

So, tl;dr: I'd be all for the "Ran n tests: a passed, b failed, etc" wording.

Cheers,
-- David

--000000000000faba3305dc1ce15a
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAP
veLigB2Q5Maujb8/KvkuuYPqWjunM9AizLfFYWuRQDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MDgwNDE4MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAII4M7kuYvqeDmrzBpM7i
xgIUTvlv4I5+4Vke5rrWV1ZTfNxObDGH1KKNVxkJdkZmvXgbFILhKeS+b1mRjWQBKPDJNFRs6Pkm
b1thQQX2y1f8BHBstbjUJvXYx5Yk43vh+qKEPoZxPg2sSrlTET30/zkt6pOq1UMsigqEwNZ34g3X
xSy7Yr4BJ7m5FP18D/wbnZKa1/8cScTYRoOA+186kbF9v8gj9YOYzqVhmOqvfIkR4B6/JvJDujdb
4P70jw9AqkD/HFZOYmmLV5gntttIdZ5BGn/lqhyPtf6n6UEzTvx6T9HfN8K7wYQd3S0pMG+xp2fO
QpbF/lk19w0k2dYO/g==
--000000000000faba3305dc1ce15a--
