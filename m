Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A15F1A60
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 08:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJAGvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJAGvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 02:51:43 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282817BED0
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 23:51:42 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id m65so6872563vsc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 23:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=blOXX8Hd1gaXIsyrVPfWSD6op7pv6+4ipBEJwf4vcDw=;
        b=jKjHuTh4kdrKERF3Hr6Lnv9WOKPVDm9QEQUq7dfWpUtCWrJBDg41JgZVc99myjTkUR
         of1oLH1YZqmOJ621FLiS/2nPiILjmOnXH3fcCd8BcSEK7XaBgBx9vHAViLDYuw7eOGVi
         nvMGxtHPGotf63LodXVUbKg9xiQKpJ/0PZELVa4r1CgSjeFiQCjCjavdCPlsfUn8ENjv
         fKa+WYYHXRZioRnUJ95Gi8TsAQ3rKEu/fJy0Bmeus9y+0tqksZpqRc6XmuQ9nTXGU8nq
         g/5Sa+tlkBf8Cyih7aAOJOi1skGIBTKVcJy3OZFNzTw4udXymB/Q5gRLZ/Mqq8TlOmoW
         LUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=blOXX8Hd1gaXIsyrVPfWSD6op7pv6+4ipBEJwf4vcDw=;
        b=hcYHXq+aHMDkWF2TPs5Ge6qN8y/DZVPEdIkK5+kJmXFNfnavxI8WHG5fzuod4ie4VZ
         fTFN13BFhpgYkI34FVwxCQs5A4tIRM1HrupaFo0hDosU56q/l3SeSqU3ltK0DNdxyhw+
         BOyrWLGY2kJVfnUMbhjsFg3JAbeIImVdUc+Xb7nonp/JxhTdhUBiod7Ig6FI6ewI9PCc
         KfBp33E6vtKRUEbNRRwhOxrC6OrthvU64PTR4073v+SFwXcckz5islW4vdWuWjGUN8x9
         UMCxW3373DNWPaN//DzhWy3yf5AkfTHNJDXMBmNpOseDcnyO2ZciUL74XO2ENUfTh22C
         QzwA==
X-Gm-Message-State: ACrzQf2zqFZZjjNzBxYRcuOb5iVV7eRTk6t6zk78L059cnLQeR7InHKN
        /oS8eu/V+oyxmyor0bv/7wKracwRiE+ziebRvG3l3Q==
X-Google-Smtp-Source: AMsMyM6Ian4kpqEw1eufy0DzSSHRP7bY8VgN6YA/tMLLKtNDQjZ6zvg1xki0AgKM5ClkPDUnluSXD/BdQpVi9o0Nym8=
X-Received: by 2002:a67:6d44:0:b0:3a2:9816:20f6 with SMTP id
 i65-20020a676d44000000b003a2981620f6mr6237022vsc.18.1664607100225; Fri, 30
 Sep 2022 23:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220929132549.56452-1-bagasdotme@gmail.com> <CABVgOSkT-EWLqr6R=RvbEgmkMAY0680YbRnEBg1un6h-=TzrUg@mail.gmail.com>
 <464981b6-d9d7-e656-261f-ef48661deaa2@gmail.com> <CABVgOSko6kgA_T3LNgTPxQZS8Ab8E+XhMcOGHFx76nd2HN_RBg@mail.gmail.com>
 <41fe0989-9157-944d-c796-21e28c8265b9@gmail.com>
In-Reply-To: <41fe0989-9157-944d-c796-21e28c8265b9@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Oct 2022 14:51:29 +0800
Message-ID: <CABVgOSkbBPmNROt2h=M5tZk4OFhsysA8F_GTrPMG1M3e-QzNyg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: rewrite writing first test instructions
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f6bd7b05e9f38add"
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

--000000000000f6bd7b05e9f38add
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 1, 2022 at 11:07 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 9/30/22 17:32, David Gow wrote:
> >>
> >> The indentation for code-block directive is required, since the preceding
> >> paragraph is multiline; otherwise there will be Sphinx warnings.
> >>
> >
> > I don't see any such warnings on my machine (which claims to have
> > sphinx-build 4.5.0).
> >
> > Could you send an example warning, and your sphinx version to me so I
> > can try to reproduce it.
> >
> > Regardless, if it's causing warnings, keep these changes. (Though it'd
> > be nice to include the warnings in the commit message, so it's obvious
> > that these are being re-aligned for a reason.)
> >
>
> I'm using Sphinx 2.4.4 (as installed from pip through
> Documentation/sphinx/requirements.txt).
>
> Sorry I can't reproduce the warning I mentioned earlier (I forget
> the recipe that triggers it when writing the improv).
>
> In any case, I'd like to keep code block aligning in the separate patch.
> It would be nice to see code blocks aligned to the instructions list.
>

Sounds good. I tried to read through the reStructuredText spec to see
what it said about indentation here, and it was pretty vague, but if
it's causing warnings, we definitely should fix it. It would be nicer
(though not essential) to have it as a separate patch to the other
content changes.

Either way, feel free to send a new version (ideally based on top of
the kselftest/kunit tree, which has just had a number of patches
merged, including v1 of [1]).

Cheers,
-- David

[1]: https://lore.kernel.org/linux-doc/20220929085332.4155-1-khalid.masum.92@gmail.com/

--000000000000f6bd7b05e9f38add
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCH
aKhzVyVH3HgJH4WEPXM3/Z6Dr2bCUZTVD6FFgA09FjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMDEwNjUxNDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHoW3FA9c8XYmMr6jaC47
syD6yDADlyacLWZPnJtGDAHmSeaBAM7gnbbRx9pbBK1kBR1OGxnEDGyjkILLanzeTiWA+PcFLwSs
v+M0Ge2malH3VBjGvpoenf9kvWf03B6LdySYvKK3uxvGSK6QSjOMvRCRZQrhfatQ0cQfdye/j68l
7wnR3UvV9Iotsbf87ZxwBVsNm8QVLrgKQr2U6iqSHlrqR4IC496B3houH5nzwB6YBwRttyl/dpcQ
DVDNzlsa2PNELwFXd1uhn2zC915znvZ1dWA9EQ/VWAy/a+pOnSr49xaUq0NYVFBona+WxTHnT26q
t/+njuioRCJP6cO4JA==
--000000000000f6bd7b05e9f38add--
