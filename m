Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CA4DC18A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 09:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiCQIoY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 04:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiCQIoX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 04:44:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D307C14C
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 01:43:06 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id hu12so3723062qvb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OFboGfiEbRd0O5jj9TIAUxi2dz+c1bHC8t00SDVTDM=;
        b=SahyL1AqHeuhrk241s8/9DKPhKUAdmDWHLHUAQnqzZ1xNJpgaU10ZsbZTqNGgfz4Tx
         LJh3nyz4vabNczkJDneHMc/il1XT9a+SMbkas6epsh26CAGpByI2mn7iGvI+HEtLhl9o
         VQXN5d3zk4weYXm6G167h+ySW1yRT1Dj7djwwD45oFCyQoTiH6bMwgQLWIilOYnPGU1e
         BaOiVqtqwI3vx4zqqq+Vf2lXIGNAapRsYXleOc6TjUpj4jBfyEN2HOk8y4MSMJqvJV0/
         D71URdDhTNm4jykH2CodK2H0pMJ8yGHLOUQxFd90NnsYCa7eVCGeZ1XCz8rCScRIBa57
         zeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OFboGfiEbRd0O5jj9TIAUxi2dz+c1bHC8t00SDVTDM=;
        b=e/PW2/SJ+MyXX3kq9ZOf5Nxl1RUKC8IoTOFogOzDtPKdZL/8kM1vl4EMABs8renWnx
         WN0jSYFYA/2e+u4kwdhsysQg6C+ojlzLC/hJ2rs+bKcni7Npye76haKXvqqvMMPvRWWK
         AUQOxxkx7k98stPh0acpZKY819tTj0GYUtxqF0LHbKz5cZdanaGWtnftLLNXKcDxe7mA
         oHWqzNIRTxRWJYMQKrdN9+9KjZ77LLpqSPw4XoSRpoWKYCnmkYL8lYzjP23vlWGHRkNX
         dMTIUEWXkMvinLApov2oZWmFHq/NOOghgtdwWDvPHxiXEVRn7SSZvai/xAKWLFzRTQ8d
         SH4w==
X-Gm-Message-State: AOAM531FN15p//Wxe2LVAnNickHAvYPGgxYQPuPJrqQ1a253vJiosAJi
        ZYN8wAc+SG2TrrnQA9RF64WufBD+BWwQ5klmBFnM/A==
X-Google-Smtp-Source: ABdhPJyMaPc+wBVz0IYSasdBtgb8T2E7a2EUZN9kgmCOuoZkWd/JEx7gXuELJXoMc1WGWhFBoNA5i3897Jj4qXASHbc=
X-Received: by 2002:a05:6214:29c7:b0:435:d0ae:dcd9 with SMTP id
 gh7-20020a05621429c700b00435d0aedcd9mr2559194qvb.101.1647506585131; Thu, 17
 Mar 2022 01:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220316202622.324866-1-frowand.list@gmail.com>
In-Reply-To: <20220316202622.324866-1-frowand.list@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 17 Mar 2022 16:42:50 +0800
Message-ID: <CABVgOSmkvxhHSJx0W6BEYz=Ai9vB=nCz625dSKLLUfU0rMLkFA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Documentation: dev-tools: begin KTAP spec v2 process
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cb994b05da6604e6"
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

--000000000000cb994b05da6604e6
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 17, 2022 at 4:26 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> An August 2021 RFC patch [1] to create the KTAP Specification resulted in
> some discussion of possible items to add to the specification.
> The conversation ended without completing the document.
>
> Progress resumed with a December 2021 RFC patch [2] to add a KTAP
> Specification file (Version 1) to the Linux kernel.  Many of the
> suggestions from the August 2021 discussion were not included in
> Version 1.  This patch series is intended to revisit some of the
> suggestions from the August 2021 discussion.

Thanks for kicking this off again. There were definitely a lot of good
ideas in those threads which we haven't got to yet.

I think there is an interesting line to walk between keeping KTAP
sufficiently "TAP-like" (particularly w/r/t being able to reuse
existing TAP parsers), and actually adding features, but I don't
recall seeing many such issues in the previous threads.

>
> Patch 1 changes the Specification version to "2-rc" to indicate
> that following patches are not yet accepted into a final version 2.

I'm okay with this, though I'd want us to be a little careful with the
timing so we don't end up with, for example, 5.18 having a KTAP spec
called 2-rc which is functionally indistinguishable from v1.

>
> Patch 2 is an example of a simple change to the Specification.  The
> change does not change the content of the Specification, but updates
> a formatting directive as suggested by the Documentation maintainer.

Thanks -- personally, I'd rather this change _does_ go in straight
away, even before the 2-rc renaming.

> I intend to take some specific suggestions from the August 2021
> discussion to create stand-alone RFC patches to the Specification
> instead of adding them as additional patches in this series.  The
> intent is to focus discussion on a single area of the Specification
> in each patch email thread.

Seems like a sensible way to structure the discussion. It could get a
little bit messy if there end up being merge conflicts, but the whole
thing could be collapsed into a single patchset later if that ended up
making more sense. (Though that might remove the need for the "rc"
version, depending on exactly when and how it happened.)

I'd also be curious to see patches to tests and/or test parsers to
show off any particularly compatibility-breaking and/or interesting
changes, though I don't think that _has_ to be a prerequisite for
discussion or the spec.

>
> [1] https://lore.kernel.org/r/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com
> [2] https://lore.kernel.org/r/20211207190251.18426-1-davidgow@google.com
>
> Frank Rowand (2):
>   Documentation: dev-tools: KTAP spec change version to 2-rc
>   Documentation: dev-tools: use literal block instead of code-block
>
>  Documentation/dev-tools/ktap.rst | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> --
> Frank Rowand <frank.rowand@sony.com>
>

Cheers,
-- David

--000000000000cb994b05da6604e6
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBn
daIT+gpBNflXR4eLXrgbGfvj3MmwMqJl0RWGuPkw1DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMTcwODQzMDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAo8L6wf0I/ZY1xewwSQTI
EhaTLXZy/q023l2Lse8T/Zpk9V0p80n8P9lnY9fj8Pzs4YRM7NWQywvXhI8JctLfQIPpKN6cP4WZ
ke44wDVqyD2WZJCFeumnrS3TRLKXYKZ9NjQ7BWRvxsogcsgKmPRrEbDb6OiWz1fbNCjWhrl6rzyy
usM5r4ZheVxA55ua/MleCH8DnzVwNIardaYtA3hDap4D8fA4PeGFWAxlos++gyKaLLF9UijfNmyw
zKPd01WixgDbhL4f5Z60VRry/0ntcMF68A0HEUvSx2XrtNvl+SDdltYB6+SRjVdUMQ6Yib6KHAjp
R0Xsncfu+A1WRlXOIg==
--000000000000cb994b05da6604e6--
