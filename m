Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7F4DAA04
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 06:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiCPFms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 01:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353667AbiCPFmo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 01:42:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D774F6006C
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 22:41:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d7so1373528wrb.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CgOflaIFT2zQB7GUqlcue5Vz9JVdcBgxocVQYRRVl8=;
        b=ltaGBFUG62bkOgMAxGp3Tt6/OFUXw4ljHn+e6P5/Okv7pBbsPZ0V56rSza8QN64na+
         a8Q00o/l85+b0qoWXPzZBB0h6y9QICcNiYCsCaKGqSjXUFdqz4YEbj5RnSF8/+R8fW58
         zW7E0Qcuwg0U7PIL2FerDUSys1GpFGfNlyxkBL1YWsR+JelWzMurBYy7PlCy9rPSyzKZ
         o0q6PbqTQmbtzGr3yy+A9PKJa8fHKKqsqvSQCUPT3xkti47LpZXmHBWIoTa+84yGvDWM
         FRUerXXv9dP13Aw++DtRBG+2QTAOCsK8ktq1rbNWYLi7AzrIVEwwaHoBMPwlIV2rLZNH
         gi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CgOflaIFT2zQB7GUqlcue5Vz9JVdcBgxocVQYRRVl8=;
        b=2IcRNCs8HBKPIindXfe31/y2frerG8RzxPOLFRD9TRIBpUBESqoAmTrzlKftXEdUa4
         /Dq2p455CmWdST37dQIg3zSZ/WdOvSFKbZTvgvPaQSuUZK1QGQG85UvkAurGjnTvaUwV
         52QCGZBFQfDzYSj0bOIOKowy3E5bTBtVg2/t2qB2RyZsmha2SWLGudHI0e0WebyM/lOO
         drl8+cFUiKLC6d6DSPfTdIvJUHBz8iMhX50UOGD4o+61ZEDX1HvRK5diITmL9MZkjwsb
         QiZMRRPlcHLQW/uMoMUf4FLMAXGccSPoZbUzgTtIR50k4yOhoyLqBovCidlJFEOr//HO
         QRaA==
X-Gm-Message-State: AOAM532/nTiBSNyld9bHi72Vaeyd1pCqJtuAse2ShknO9juYnk5GHyCS
        Q9u/LHHodfmiGkcQEP4HDT4et8ZVaLF1Zvc/MrBOYQ==
X-Google-Smtp-Source: ABdhPJzP3wMa3CEaqjp2bA68Mrq2PljNjiNHG8G0hLA5n2ChsHaCqyNPl7XrjAehrMfB0lLK0oPNQXX9hCKNpKfED5o=
X-Received: by 2002:adf:dd8e:0:b0:1f0:22f1:aed8 with SMTP id
 x14-20020adfdd8e000000b001f022f1aed8mr22868673wrl.269.1647409287159; Tue, 15
 Mar 2022 22:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220316024432.1454366-1-dlatypov@google.com>
In-Reply-To: <20220316024432.1454366-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 16 Mar 2022 13:41:15 +0800
Message-ID: <CABVgOSkvmuiHfG11VRsQhigOLw_-5HYWjJrQrA4Vy18MvUpW9w@mail.gmail.com>
Subject: Re: [PATCH] kunit: split resource API from test.h into new resource.h
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000630eea05da4f5d08"
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

--000000000000630eea05da4f5d08
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 16, 2022 at 10:44 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Background:
> Currently, a reader looking at kunit/test.h will find the file is quite
> long, and the first meaty comment is a doc comment about struct
> kunit_resource.
>
> Most users will not ever use the KUnit resource API directly.
> They'll use kunit_kmalloc() and friends, or decide it's simpler to do
> cleanups via labels (it often can be) instead of figuring out how to use
> the API.
>

A depressing (but probably not untrue) thought. I think that, even if
most people were to use the resource API, having it in test.h makes it
harder, as having the resource functions separate makes it easier to
understand as well.

> It's also logically separate from everything else in test.h.
> Removing it from the file doesn't cause any compilation errors (since
> struct kunit has `struct list_head resources` to store them).
>
> This commit:
> Let's move it into a kunit/resource.h file and give it a separate page
> in the docs, kunit/api/resource.rst.

Yay! This makes a lot of sense to me, as I've wasted a lot of time
scrolling through test.h.

>
> We include resource.h at the bottom of test.h since
> * don't want to force existing users to add a new include if they use the API
> * it accesses `lock` inside `struct kunit` in a inline func
>   * so we can't just forward declare, and the alternatives require
>     uninlining the func, adding hepers to lock/unlock, or other more
>     invasive changes.

I don't like this, but still think it's an improvement on what we have
now. Ultimately, I think adding helpers to lock/unlock or similar and
making users include this separately is probably the right thing to
do, as nesting the headers like this is a bit ugly, but I won't lose
sleep over leaving it till later.

>
> Now the first big comment in test.h is about kunit_case, which is a lot
> more relevant to what a new user wants to know.
>
> A side effect of this is git blame won't properly track history by
> default, users need to run
> $ git blame -L ,1 -C17 include/kunit/resource.h

This is a pain, but is probably worth it. Thanks for including the
command in the commit message, which should mitigate it slightly.

>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This was starting to annoy me, too, as it was a pain to read through
everything in test.h. It'll be a bit of short-term pain,
merge-conflict wise if we have other changes to the resource system
(which I fear is likely), but is worth it.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>
> NOTE: this file doesn't split out code from test.c to a new resource.c
> file.
> I'm primarily concerned with users trying to read the headers, so I
> didn't think messing up git blame (w/ default settings) was worth it.
> But I can make that change if it feels appropriate (it might also be
> messier).

Personally, I think it's probably worth splitting this out as well.
And the sooner we do it, the less history we'll obscure. :-)

But I agree, it's less of an issue as it only directly affects people
working on KUnit itself. Though making it easier for users to find and
read the implementation of these functions could help them understand
API "gotchas", so I think it's worthwhile.

>
> ---
>  Documentation/dev-tools/kunit/api/index.rst   |   5 +
>  .../dev-tools/kunit/api/resource.rst          |  13 +
>  include/kunit/resource.h                      | 319 ++++++++++++++++++
>  include/kunit/test.h                          | 301 +----------------
>  4 files changed, 339 insertions(+), 299 deletions(-)
>  create mode 100644 Documentation/dev-tools/kunit/api/resource.rst
>  create mode 100644 include/kunit/resource.h
>
<...snip...>

--000000000000630eea05da4f5d08
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC5
dX+kXCwlQxJZbjfVMW9V+5NxFQMh+9cx8fGikPOZjjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMTYwNTQxMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASgvUSU+sPMwhuht+bqvn
ihitwFEQFnJBfxEd0JhrtQGigHcE08JH/rtUGfo4FMNFj0uxQyfTnA5lBnJRZxKNmcHPOXj2DqqE
ySfoSkxgB4sJ6w+gv/Ye2bUZ+Tdf573OtxX+5sqlfvuRzvawdL/yjgzFtqPZvqMmfPMWbmNhPIzv
aCEayw5UxjCovMAVZ8csZbRJcHbRgBNgg5FDVS09CHrGlFsy0fs+TSbRu20y7471U/CHR6ADcasb
e7H3vOL6bgxfngTaRPF1b/MPLGvvK3DzXBxu+1tVsIDfx070ZYZuxtSoDilhYOk1ltHG4gAGfSlI
4XqJDZyoDIn9dmzS/w==
--000000000000630eea05da4f5d08--
