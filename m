Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF277CA3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjHOJRv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjHOJQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:16:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86061BD7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:16:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so6717a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692090983; x=1692695783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YmHmIxlhUng6RfJq+0sCFaKeMeyJGlQL9yeccOGARrA=;
        b=lyi6Adl1xRhfN5sgWPM/JhigCXRBaffrn5jE6v5e5dNqaAg05i5e5uewAGqBhw8ISL
         xYphOy3CFIlVRMIssJlRFE+9AA9lvNtaOByA70BUbtD8f2L1ZA05KsCOhx31elTq72u1
         wWgsQHXxAU1+bCEAeDbP1nPaT04EvqJELTt+SBxKxZkIcSAv649xuwm1qLDCntB4uwsi
         snZ1TWWanXxpc0aF8icv4Dp8/euPKISA2UZpyN/D4DEnk3hEbTCVMicN42d5Wn4rrtyd
         QFkb0msPZdaPBrCmiaX1cauT5B6Y1aIbo0ekxiMKJgUzyqPlKDV89lNI8xXo5TnHtQgV
         hnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090983; x=1692695783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmHmIxlhUng6RfJq+0sCFaKeMeyJGlQL9yeccOGARrA=;
        b=RKBTvnfb2vJYtgBXY3mSIP4NDRWR3hALBMqbBWq3EqS9M3sShR78OjVqJBgWF64TOp
         sL6PXdbwjDsxlM8/EqmiSX4bKLnDRuEpJ8QtvIvHBJTAPH+4JSfAzIYDxBxjHSAg7eI1
         ol9bZahbrW8s2np49L6kU/49qEw0DZReXoZRony/ZYK0gLVhrbnuC4Oz//Q0/Ci4gMAW
         dHFjJ8po9sZy872Mjrx3jK+wMtopMYXPIf3W/j1zrYFxQl0t0K47fjgywKwrdTAyyd2e
         Ag8Vvz8ZqaP3Krz+k1c64smLt+72N7nPIInF2MKqn2iSKR6sx5Ncc8rjhkCQf57YCS9w
         hwHw==
X-Gm-Message-State: AOJu0YzDWFfMUulPQ3HzkI2saVmPpOoE1ggF0RcECPfnw5E1lq3Pc+rP
        2L+1MmdtbCTikGCUFFJRPuPjFQtnF+xq5AJc4C+oeZX3DGr5O7HXwCY=
X-Google-Smtp-Source: AGHT+IFSK9E765mZKS2GND3zbp6h8T9YOwnKkiGxhu7v4oJW2u3F7IiQr7YS/80+Z7vohmhjppwT9m1lp8io+8yx3M4=
X-Received: by 2002:a50:9fa4:0:b0:506:b280:4993 with SMTP id
 c33-20020a509fa4000000b00506b2804993mr328840edf.2.1692090983551; Tue, 15 Aug
 2023 02:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-4-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-4-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:16:11 +0800
Message-ID: <CABVgOS=j0RJ0i64yQ3tz_e+ZeCS+Pfj0_GZy02UWJnV9TePgTA@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] kunit: string-stream: Add cases for adding empty
 strings to a string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000668600602f2a2ca"
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

--0000000000000668600602f2a2ca
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Adds string_stream_append_empty_string_test() to test that adding an
> empty string to a string_stream doesn't create a new empty fragment.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Looks good. One minor note below (not worth resending the series to
fix by itself, though).

If you wanted to combine this with the previous patch, that'd be fine
too. (I don't mind either way.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/string-stream-test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 1d46d5f06d2a..efe13e3322b5 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -206,11 +206,32 @@ static void string_stream_append_test(struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
>  }
>
> +/* Adding an empty string should not create a fragment. */
> +static void string_stream_append_empty_string_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Formatted empty string */
> +       string_stream_add(stream, "%s", "");
> +       KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +
> +       /* Adding an empty string to a non-empty stream */
> +       string_stream_add(stream, "Add this line");
> +       string_stream_add(stream, "%s", "");
> +       KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), 1);

While this is fine, I do wonder whether the more future-proof thing to
do would be to check that the number of fragments hasn't changed after
adding the empty string, rather than that it's definitely 1.

(In practice, even with a fancier allocation strategy, I can't imagine
us splitting "Add this line" into multiple fragments, but I think it's
slightly clearer that what we're testing is that the empty string
doesn't increase it.)


> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
> +}
> +
>  static struct kunit_case string_stream_test_cases[] = {
>         KUNIT_CASE(string_stream_init_test),
>         KUNIT_CASE(string_stream_line_add_test),
>         KUNIT_CASE(string_stream_variable_length_line_test),
>         KUNIT_CASE(string_stream_append_test),
> +       KUNIT_CASE(string_stream_append_empty_string_test),
>         {}
>  };
>
> --
> 2.30.2
>

--0000000000000668600602f2a2ca
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAb
r5IPAm0huoydSffFc1f7aBnJI1We3nqN6pppi8ufZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE2MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAU5Ud5HgbU7FFUr7pOxBq
NX2YmXyYO9UJIGdmV8WdrtILQNrKIdVGb3f9EUgiQ4YvMMKDj+GtqodP2kyI5ZPyIEMEkNvS8A1C
xyEJ8+DNFdp63dNrx9FaN3MsH/iY9gheKBisuZWwlVDDN9BvKHuupojQC2votvuSaflveunQ2L1H
tK59kO+ZBsPk/TnwRjFLuydcwWlN6gJAgJ7X8StZ+VrRxobSdxafDrWgqiGQC2Zkglksn/4DRFba
j73gBj3jXeHcRsHZCd7r8jHAJaf9m1+qVoLpyYwMgNCCfuNgBLMzQ1JvG6VmueFFediJ8NP3lK0+
LsqAzDyiTFIJDX2MVw==
--0000000000000668600602f2a2ca--
