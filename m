Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D177CA95
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHOJiW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjHOJiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:38:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2935B3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:19:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so53525e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692091146; x=1692695946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bQZ8uRm4H5rHqIZzNe+kjx4WaRLtZn8DSG7vt1E/qsM=;
        b=zZxA6fERC9CvfSDdAVYA1CvuL3jzN4DNl4HxyX33CXNv3+JUdnPrTHq1KvQSt9b0y6
         ylnMHpdFBDYqLeKhRqXFVxWk3CD046Kt3Got1daEbW7JoTAkAfyUELFFt1kbIJJaFY1a
         ga9BP0r+Y4cuXwUneosS1tXsekCw23l/chFmKPagUgAIGUBznjtuJ31EcR4whnRtXDKj
         yJPGNbGHm+aNfBJmkSLasrFFtPo3tWGlBEmYtLmayfrL0UsdVKMV67dhj8e2W0BVDts3
         Jr0qZz2NWbQck4vTa0K6R5DfdpDkIcOa7xt+IFSKjpvBB5hAsMLMvsjk2SugTBSiekHR
         ZuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091146; x=1692695946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQZ8uRm4H5rHqIZzNe+kjx4WaRLtZn8DSG7vt1E/qsM=;
        b=abs96u1qxWxMFr6ZYdr/ky++OFAcmoFTwcNIweC69Xox1fZI+UhNU+RGJrQwO4t8GU
         hVQcEucn2dhCZbONIym3xipPxOr6cGle8UDO+xw6ximkj6s2h9jX/gHsEI/AwJmJnL15
         BEymKP14QnA4qaZqEo7VIEAPWQCH0mHeLw7fumk2D9f4Z4hIOvYw4Vvk+tsCbDy8m3RQ
         8pyAk9LkFml672r9iD3Atl9iqfzLPc5MftyUjUu3+F9zQOzIzxCrbCGF3Xjs+xLIq+Rk
         CC5HcYnHRNBN6RsEBEZuXWlVoI+HHOtIUunwqfTInfSTaxtIR1kvMG7ZRxXNxOjIgLKC
         DOsw==
X-Gm-Message-State: AOJu0YwuGNk1SSX5XxMsp8WsW1oDpOLQy6HmPsDsmoElKHJZKHZU/8p6
        /+NSAv4eiPPMH8mwNmXtTHE2nb4nTyFX9XIQhUBQ2g==
X-Google-Smtp-Source: AGHT+IEKeUvKTJjYp0XpJCMpH4AK1KyMOUn3d2BryMTCqxpIA34+EW7nu4vNU6hTtkZhjJRmRA0alZggEV1GoJTleMo=
X-Received: by 2002:a05:600c:602a:b0:3fe:b38:5596 with SMTP id
 az42-20020a05600c602a00b003fe0b385596mr390546wmb.6.1692091146677; Tue, 15 Aug
 2023 02:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:18:54 +0800
Message-ID: <CABVgOSkHm0DuftswzOve3i4c0SO+KGN4k4zMbbG3u0rxsiUkoA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] kunit: Add dynamically-extending log
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000be73b70602f2ab38"
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

--000000000000be73b70602f2ab38
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> This patch chain changes the logging implementation to use string_stream
> so that the log will grow dynamically.
>
> The first 8 patches add test code for string_stream, and make some
> changes to string_stream needed to be able to use it for the log.
>
> The final patch adds a performance report of string_stream.
>
> CHANGES SINCE V3:
>
> Completely rewritten to use string_stream instead of implementing a
> separate extending-buffer implementation for logging.
>
> I have used the performance test from the final patch on my original
> fixed-size-fragment implementation from V3 to get a comparison of the
> two implementations (run on i3-8145UE CPU @ 2.20GHz):
>
>                         string_stream     V3 fixed-size-buffer
> Time elapsed:           7748 us           3251 us
> Total string length:    573890            573890
> Bytes requested:        823994            728336
> Actual bytes allocated: 1061440           728352
>
> I don't think the difference is enough to be worth complicating the
> string_stream implementation with my fixed-fragment implementation from
> V3 of this patch chain.
>

Thanks very much! I think this is good to go: I've added a few small
comments on various patches, but none of them are serious enough to
make me feel we _need_ a new version.
I'll leave it for a day or two in case there are any other comments or
any changes you want to make, otherwise this can be merged.

I agree the performance difference isn't worth the effort. If we
change our minds and want to change the implementation over later,
that shouldn't be a problem either. So let's stick with it as is.

Cheers,
-- David


> Richard Fitzgerald (10):
>   kunit: string-stream: Improve testing of string_stream
>   kunit: string-stream: Don't create a fragment for empty strings
>   kunit: string-stream: Add cases for adding empty strings to a
>     string_stream
>   kunit: string-stream: Add option to make all lines end with newline
>   kunit: string-stream: Add cases for string_stream newline appending
>   kunit: string-stream: Pass struct kunit to string_stream_get_string()
>   kunit: string-stream: Decouple string_stream from kunit
>   kunit: string-stream: Add test for freeing resource-managed
>     string_stream
>   kunit: Use string_stream for test log
>   kunit: string-stream: Test performance of string_stream
>
>  include/kunit/test.h           |  14 +-
>  lib/kunit/Makefile             |   5 +-
>  lib/kunit/debugfs.c            |  36 ++-
>  lib/kunit/kunit-test.c         |  52 +---
>  lib/kunit/log-test.c           |  72 ++++++
>  lib/kunit/string-stream-test.c | 447 +++++++++++++++++++++++++++++++--
>  lib/kunit/string-stream.c      | 129 +++++++---
>  lib/kunit/string-stream.h      |  22 +-
>  lib/kunit/test.c               |  48 +---
>  9 files changed, 656 insertions(+), 169 deletions(-)
>  create mode 100644 lib/kunit/log-test.c
>
> --
> 2.30.2
>

--000000000000be73b70602f2ab38
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCZ
cbosotLro9R4bwRRlGoW6ey2IrT72dwydgtuWvf7ZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE5MDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbpBMD6GnXrhrrQbBtAwx
3B2S4TrswRiT8h3hJwoPc7gWr1EJoJo/jN/S7H9ZzYf6YASU8By+i7XLC6Umfw+lI6IjMO3KAcrN
dmVMYM/hLGR1tQNAiCjEMTz4bqlmTnLLmAUCyEZIJKoMRoPAtJEfJtKZACgatZPh074Ey+T9T0B+
JerLxBNaHUE0xf5Bbk/wdgsVXd/eKpQahDN/mEhJpbIN3ocBe8jYmXnmpdrT4+tS5VT6adbPEY1+
ZcQF/xFvl+WgOoPZfG5qZd1iylI2/UrRaXWTuLTNOV4SZuhnKbSannKDiGJP5KNrOesxbUQCQNK1
hA87J+o84F/K40JSrw==
--000000000000be73b70602f2ab38--
