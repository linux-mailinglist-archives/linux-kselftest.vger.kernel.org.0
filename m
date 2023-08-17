Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89C77F074
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348193AbjHQGZP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 02:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348192AbjHQGYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 02:24:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D842D57
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 23:24:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so40395e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692253481; x=1692858281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/c2Bbz0bnrlrt772laKRTJ7w8mOeXA0ciLSoNwE/yk=;
        b=InH6ltmyQwS/7Ett++2cpDCgqL7GCI3yjk/qihW1NhDenMbWU8tkntYyn2lkmpyJzw
         HqDh6OX0qtujidyGy08Wpofa/ETlFWwegIaxy3EC2g4de76OX1Soe8mVc25WK0/WZ6WF
         bFFnKjB6cB7Z8FJDzag1S08EKM/4LPiwb8IHvFZS7oWmtSK+8muWIMvtMBeT8DkPob2H
         Ykh+WJ1k/O/LzVOB/zYF3X9CYueZHXqiPyaqCdHiTE2snjiLDd6bKGMkzV6NI/Mqylkp
         xxyAya6yuwYA+dAjAVsgCzvNZ+DMB8LRZ3FWMpCb8/HZZLXo/+JMADlLJXsEcNh487Bs
         iOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692253481; x=1692858281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/c2Bbz0bnrlrt772laKRTJ7w8mOeXA0ciLSoNwE/yk=;
        b=OjtV+psh8TbOixG/NfzWILPlRxKWiProx/BsRajbe1oRuDVSG2mHc6Z1s9DZxsX0zQ
         IG8Ac7NnV1pjBAV9buJSZgpuCHCe3bFi5S+VHe4IPFCEQfndaEILg/WrWkjj0GMI895h
         m0SIhd/1ks4vFq78kal5qJozokDH6v6/kw5L/Bm10/WymYuGp8leF/JjKivBKdbIqZkL
         yINt2pelBY8p/FRQFSelT1NcMLKX7RfO6xeMYPGNvUvefeEzHeqGJB1KJLDYyHmP0XSK
         Ngxr3jalWa9IXj2st36X7F+jChUU/xsVFHFURVw8cOof8SinJAeUzF/1f5fxjf/7nFMh
         YIYQ==
X-Gm-Message-State: AOJu0YxxVltbN1vN+0UmOLCf+IPprCUYLFbmtk86acSCyAaFO47S3U4l
        W5T+GYW/cSVqk6VjnQJjNx+33z01gVm/43Ht2MEkyw==
X-Google-Smtp-Source: AGHT+IF+AeagfVLNt4/hfG/la2nStXk5QW4UOnnRV6i+zHgygb6u9ApAhmAgrxe3tuzrIxUl5PsYrgGh3HyFTiCfiOM=
X-Received: by 2002:a05:600c:1906:b0:3f4:fb7:48d4 with SMTP id
 j6-20020a05600c190600b003f40fb748d4mr48747wmq.3.1692253481269; Wed, 16 Aug
 2023 23:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
 <20230814132309.32641-8-rf@opensource.cirrus.com> <CABVgOSmBD7zWjn5ovwUAv23r=O5Z6q8+k=vUD6Jh=MZ3prUuDg@mail.gmail.com>
 <c787061d-b478-6ec4-9a7f-091baf2864a3@opensource.cirrus.com>
In-Reply-To: <c787061d-b478-6ec4-9a7f-091baf2864a3@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 17 Aug 2023 14:24:28 +0800
Message-ID: <CABVgOS=1Vp+bLidUsK7Dv+3=0x0FE3xJzaQH53nzrdBknMLu-A@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] kunit: string-stream: Decouple string_stream
 from kunit
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a61b360603187783"
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

--000000000000a61b360603187783
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Aug 2023 at 18:51, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 15/8/23 10:16, David Gow wrote:
> > On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Re-work string_stream so that it is not tied to a struct kunit. This is
> >> to allow using it for the log of struct kunit_suite.
> >>
> >> Instead of resource-managing individual allocations the whole string_stream
> >> object can be resource-managed as a single object:
> >>
> >>      alloc_string_stream() API is unchanged and takes a pointer to a
> >>      struct kunit but it now registers the returned string_stream object to
> >>      be resource-managed.
> >>
> >>      raw_alloc_string_stream() is a new function that allocates a
> >>      bare string_stream without any association to a struct kunit.
> >>
> >>      free_string_stream() is a new function that frees a resource-managed
> >>      string_stream allocated by alloc_string_stream().
> >>
> >>      raw_free_string_stream() is a new function that frees a non-managed
> >>      string_stream allocated by raw_alloc_string_stream().
> >>
> >> The confusing function string_stream_destroy() has been removed. This only
> >> called string_stream_clear() but didn't free the struct string_stream.
> >> Instead string_stream_clear() has been exported, and the new functions use
> >> the more conventional naming of "free" as the opposite of "alloc".
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> ---
> >
> > I'm in favour of this. Should we go further and get rid of the struct
> > kunit member from string_stream totally?
> >
>
> I can do that. I was worried about some hairy-looking code in assert.c
> that used stream->test. But I've just looked at it again and it's
> really quite simple, and doesn't even need ->test. is_literal()
> allocates a temporary managed buffer, but it frees it before returning
> so it doesn't need to be managed.
>

Yeah, let's get rid of that. Having a stream->kunit exist but be NULL
half the time is asking for issues down the line.

> > Also, note that the kunit_action_t casting is causing warnings on some
> > clang configs (and technically isn't valid C). Personally, I still
> > like it, but expect more emails from the kernel test robot and others.
> >
>
> I can send a new version to fix that.
>

That's probably best. If you want to keep it as-is, I'll fight for it,
but it's probably better to err on the side of not introducing the
warnings.

Thanks,
-- David

--000000000000a61b360603187783
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAo
kCelWpfu2q7nQzoyG6nClyiKfk1zLdmIqwH4RIDT/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTcwNjI0NDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIx8KDFD3usmiVsiNkpES
xwOwe07uBFkKUmszZhPxk+fN9OXTgcnVgAbS/XMESUWw9x2XPwwMNc7r4kCr5gxjzOd0WE2r9WU2
d7yAXioY9x0cO/hoI2OBqvwmV3xhAS22B2W0MFdHKVKUNzZ+A8Ftx7qB2ZZHvKQ+7MN33juKVocT
pDYa36XrOO4S5A+6NfW6F6Ui6j/hnwXNEwMUBJlTsp85Zw4Kk7cWiBBzbYHSKh6MdIv10/C/feqi
1Nj5iDWrS8X3yXdp66k9SIZV16/ebHmlC0Nvzq5O5FPAhuK69a3fvF886QYMCnd/+tgAybBAq36S
ottopjRuHjc8SVehcg==
--000000000000a61b360603187783--
