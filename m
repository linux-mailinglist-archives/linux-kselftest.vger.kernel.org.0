Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607D677CA4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjHOJTZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjHOJSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:18:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D82D7C
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so9704a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692091040; x=1692695840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bKK0e8251j/eltAS2Y9HiiamxKszuiqlIfSiFjb9+Q=;
        b=BSoSJn28/nyw9iFamDyICjO5w4akdIfVezzFm6Rj3LdPh3a3uoUrEk9sBIH8Zh8tX/
         W8WWGiuErW9RCuKzqT7mbj93kluNMIne/7l2WZ8LCwV9iMTXgaofogqc0HWgDPekLJq4
         cmwwSO2VGIX3YDbnGvrrMuKDwAgjd3gQX1qe+up4THyoA6H2U3mhGmuZQ7UBYH/luaMX
         gwHVRDkZwwK5Rtpk7zZk8DlgBTSVm150o/jsN+yiudXGtjiQhF9CZcc/20wNKxj5AsVT
         2LR2n7TTcBKM8NGLIbdgXN8vgwBHf0AybE/BiIfwEMO0WNbB8Lql5mGGc3L/zD+W8uKG
         sA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091040; x=1692695840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bKK0e8251j/eltAS2Y9HiiamxKszuiqlIfSiFjb9+Q=;
        b=VZ5dbUsewFiog1nvyYQNaLyxAIqOdLbvbSO61m0e8Mi4Sl+FZpvJfWuY6KMrLE4r4r
         VH/N8P8KfguqCfkCvhoIIjsdO/cHkFOIQ/yi/I6UozRDM3VMFsFvYxnfb8BEIRqI4M7X
         DtuHHoZSAbXtnls5mSydm5YU+JxZINbAKllx2n780CrELvgycslzJs7tmeQJYXvieO7s
         SfDgM32l2INrEX4nz+dS+3BBSjDrmm3kbvfcI3iOPZdBesh1NfhKkE/FBgYSwCwbSAIo
         9TW4Eofkf993UvH26oXi+G3Px8mGyfOAY12y0oNbnewmeD9buKJ8rp69Ml1O12DVo/Wz
         HItg==
X-Gm-Message-State: AOJu0Ywt0naWp11P0PIgWhHgMnFoHC7lTea078VJOD/kZXzKtKd8YY8O
        766LUqXgUchTSaNzBC0vLkahBfNb09HbfxdrGYkGyQ==
X-Google-Smtp-Source: AGHT+IGwbqz+YZ8sdyPZmGmvywa7X0eMrTUDYaElxGTX0/mUDeGDmG1largsuPeknJs4wSAxN2F7O1wAmHP8zNJ2qjY=
X-Received: by 2002:a50:8a83:0:b0:523:caae:d6ee with SMTP id
 j3-20020a508a83000000b00523caaed6eemr307523edj.2.1692091040353; Tue, 15 Aug
 2023 02:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-11-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-11-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:17:08 +0800
Message-ID: <CABVgOSnXHg9Vf=818P3usDquF0JWx2oem48fSV4krL_MTGcVCA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] kunit: string-stream: Test performance of string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000068d42f0602f2a53d"
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

--00000000000068d42f0602f2a53d
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add a test of the speed and memory use of string_stream.
>
> string_stream_performance_test() doesn't actually "test" anything (it
> cannot fail unless the system has run out of allocatable memory) but it
> measures the speed and memory consumption of the string_stream and reports
> the result.
>
> This allows changes in the string_stream implementation to be compared.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Thanks, this is very useful.

My results are (UML):
   # string_stream_performance_test: Time elapsed:           5021 us
   # string_stream_performance_test: Total string length:    573890
   # string_stream_performance_test: Bytes requested:        823930
   # string_stream_performance_test: Actual bytes allocated: 1048312

KUnit isn't really ideal for performance testing, but this works well
enough and fits in well alongside the other string stream tests.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream-test.c | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 05bfade2bd8a..b55cc14f43fb 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -8,7 +8,9 @@
>
>  #include <kunit/static_stub.h>
>  #include <kunit/test.h>
> +#include <linux/ktime.h>
>  #include <linux/slab.h>
> +#include <linux/timekeeping.h>
>
>  #include "string-stream.h"
>
> @@ -370,6 +372,57 @@ static void string_stream_auto_newline_test(struct kunit *test)
>                            "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
>  }
>
> +/*
> + * This doesn't actually "test" anything. It reports time taken
> + * and memory used for logging a large number of lines.
> + */
> +static void string_stream_performance_test(struct kunit *test)
> +{
> +       struct string_stream_fragment *frag_container;
> +       struct string_stream *stream;
> +       char test_line[101];
> +       ktime_t start_time, end_time;
> +       size_t len, bytes_requested, actual_bytes_used, total_string_length;
> +       int offset, i;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       memset(test_line, 'x', sizeof(test_line) - 1);
> +       test_line[sizeof(test_line) - 1] = '\0';
> +
> +       start_time = ktime_get();
> +       for (i = 0; i < 10000; i++) {
> +               offset = i % (sizeof(test_line) - 1);
> +               string_stream_add(stream, "%s: %d\n", &test_line[offset], i);
> +       }
> +       end_time = ktime_get();
> +
> +       /*
> +        * Calculate memory used. This doesn't include invisible
> +        * overhead due to kernel allocator fragment size rounding.
> +        */
> +       bytes_requested = sizeof(*stream);
> +       actual_bytes_used = ksize(stream);
> +       total_string_length = 0;
> +
> +       list_for_each_entry(frag_container, &stream->fragments, node) {
> +               bytes_requested += sizeof(*frag_container);
> +               actual_bytes_used += ksize(frag_container);
> +
> +               len = strlen(frag_container->fragment);
> +               total_string_length += len;
> +               bytes_requested += len + 1; /* +1 for '\0' */
> +               actual_bytes_used += ksize(frag_container->fragment);
> +       }
> +
> +       kunit_info(test, "Time elapsed:           %lld us\n",
> +                  ktime_us_delta(end_time, start_time));
> +       kunit_info(test, "Total string length:    %zu\n", total_string_length);
> +       kunit_info(test, "Bytes requested:        %zu\n", bytes_requested);
> +       kunit_info(test, "Actual bytes allocated: %zu\n", actual_bytes_used);
> +}
> +
>  static int string_stream_test_init(struct kunit *test)
>  {
>         struct string_stream_test_priv *priv;
> @@ -400,6 +453,7 @@ static struct kunit_case string_stream_test_cases[] = {
>         KUNIT_CASE(string_stream_append_empty_string_test),
>         KUNIT_CASE(string_stream_no_auto_newline_test),
>         KUNIT_CASE(string_stream_auto_newline_test),
> +       KUNIT_CASE(string_stream_performance_test),
>         {}
>  };
>
> --
> 2.30.2
>

--00000000000068d42f0602f2a53d
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBn
PxcF1RGyEThu8UWg+RKPY8jN+WGr7oAl5mwanGTkXjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE3MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl+i4MZe8HMPua/eKTBtJ
L4grw9oymU3fDnIGH2f/ETWh9M5Ui1rQyYLiPEEe/FBV1tGVUMiNDLFGx/Z0IVNEmjGJr/SCvi5i
9/oZQ3/nUTGgcohAuoYdtvwUYQSrgnU2ARmr8ps5KEzg8DtoTYj8uSV5c36yDOEsoBUVbmeALCuB
Zo5QSKRAIK0HDdtsO12r9SvQSgDBLGOXO8kjPfLoj/uogL+5vaLjAhoza3IAEZzM6A5zD5rtDgV1
7GJpiCqys2q6RAFtTF/1uYUpo3XFGxFl7oiKxmdH35bXajAR9KZFLs6Ac92/GfvrXAzOpypkmcY+
rKBI8qchH7ZVW+Ivaw==
--00000000000068d42f0602f2a53d--
