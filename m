Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D667E2DBB3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 07:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLPG3k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 01:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLPG3j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 01:29:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CFC061794
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 22:28:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a9so45557957lfh.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 22:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ww7aeu/Z4elX7AuHvJcuCx+zzSZJwqDNPIn3+rmh+8=;
        b=rO4jeDLV7JQlp2BhoLVB6XHsbRVNFaQ+YKtJQTb0Rx3HYpT0g7/dnvwME7ClyALdny
         m54pTfcIWPkNtmROWOHdQ8EydviuI/KUdkiRux9cdV4luUK+GnNn+BxUcNQUL6D6JhuJ
         a2ECr2v3pP2siu8rzP6HlONXeJNlxR0peF8F9Xxhqt0uvS99W3yWT2niqeWkZApQL3pO
         p/h39Qz3JjFF7eGIezaGPq9CdyZKXX0VGgjwSTGZ/RmsMxtDjisHjGILgpJrTDtDw8xU
         bbEq2PrZhtA4NdQhPwMyRm1EM59Z0pcet/2DzDTd0zpft7+q/Xh/khtjhxtcEm20bhZ8
         PDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ww7aeu/Z4elX7AuHvJcuCx+zzSZJwqDNPIn3+rmh+8=;
        b=jUs9avSYzAelrmMps8OG/gsa1NiubqHfB//oCSmveVKoDsrKPYfE5snJdvJl8LfDPd
         kyDXU4YZxTslQ8pFW5hlP0PsriQ4+Gc6Vmh8Ak57h3VXOm07lXM02Hfbso8jmeVI9zna
         9CckvLwxbLvLxUCSObDXh8UGbhHs9Ke+8XZCtOIGBEBaE59F4RtdbjGrID/XmmaaTXty
         Plf+1hN3S5VUFpQ1ceQrLYXpH8xOa8p8iotJzG+rgBa1sQiY9kSGq7TVULalOxvjHrdG
         HcrDQjTFsVcsoopdd56wS/Zq68euO3fBG9WS3Bp1LOQLKnbWUAyI5jC8KRQ46NsEsYMU
         A7YQ==
X-Gm-Message-State: AOAM532fe6/6mXe8ME32UpJ0mLwIuXP8TA7Zi4BL3+gWxwqvu4aVnO9+
        aHY7hieZldgW7lLyqWXLo23XRuIGPY2aER0yTgKReyJLLTOYag==
X-Google-Smtp-Source: ABdhPJyA7aVZZT+npeB4dB88zypsKHi05NxwR3e9rhXfg2LJaLUy+/AlI/f/XPHx1St8ksTEeGzM74ODceLOSrDdJpU=
X-Received: by 2002:a2e:9ad3:: with SMTP id p19mr13563371ljj.286.1608100137480;
 Tue, 15 Dec 2020 22:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20201216002246.3580422-1-dlatypov@google.com>
In-Reply-To: <20201216002246.3580422-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 16 Dec 2020 14:28:45 +0800
Message-ID: <CABVgOSmy7av=7QjGmgELhVDDUtQxJ9Tb5aeNJBNQ5M3VUW80+A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: include example of a parameterized test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007a9c7f05b68efd4e"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000007a9c7f05b68efd4e
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 16, 2020 at 8:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit fadb08e7c750 ("kunit: Support for Parameterized Testing")
> introduced support but lacks documentation for how to use it.
>
> This patch builds on commit 1f0e943df68a ("Documentation: kunit: provide
> guidance for testing many inputs") to show a minimal example of the new
> feature.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks good to me. Thanks!

Reviewed-by: David Gow <davidgow@google.com>

-- David

--0000000000007a9c7f05b68efd4e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
6ATY1rl7H5KHpxPHHrSGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCGZt7Kw+clplWDUcyH
Vga1sfYg4uoC6PbkLullW57eVhnlS6kzSfBa9s7SJDNBFSijZBudxEH2/4o80/bgcOy2885DjBWz
xIHwcOe7cUxRPfvIjjEWw8xcvUHyf9I1j3BpTmeXOqYIXmqFDtFOBK20+IuUIeel3BQz/ysWBJbX
06V0h2+mTthoiR9VB7Gs8/Ke0fxNK6KNsqsKqS7s5lxF786QyDGkUvEw+ttoyhY7fL9IHm2HeM5Z
/7SQGzhj5ZL7KCV+4b11Mu2fEBkPOnUjkh2ltL8irXc2AHkp86iROexPXajhUIqHIXT0aoXUXSTI
dcl5F5gYy4SVinoF3iPIMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABFerwMCZ+gKzahpx3ewIGMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBGpezK
0yRjL2mmkMJqoaJAfOQBoo0FbqmsN4TxSJIucDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMDEyMTYwNjI4NTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASqTXD1+bncF+hfGltTzrwaPJ
AoT+MzakJ/MIh1ofXT2Yd0V6dLm5SeVpcfiCUI/5YGubh5Lkj/hfP79TQTjGY8/S86xztGUaJH2r
1gtizoOvCxYRP17CZqt9VjI0iew8r1c4e5eTV4ej/j9gHECD9UHwTcg8F3cAd8P77+mpwNVaszmQ
3I4xhOg2BW+5m6AcavT8c2yYET5A6h2th6fzDYGfLfJaOLwR5bIEUw2o6FQ4+a/RDs1aiLI5ImMq
jCiM6EfHrVqpS7QfsA/DMEndNYANNR0i56sh/qblVMwZyVR/bJtTr4Kyi9DwGUtZk0eSjUMtE3fj
yPxDyTyju0gBUQ==
--0000000000007a9c7f05b68efd4e--
