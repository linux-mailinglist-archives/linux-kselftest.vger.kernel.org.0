Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BFB7D7D4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 09:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJZHG6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 03:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJZHG5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 03:06:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2590F1A6
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Oct 2023 00:06:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so5508a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Oct 2023 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698304012; x=1698908812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIY57MrujmKId5+jCxgUo7McJ/NDQkTulF6/sNW7MFM=;
        b=TLAjVn9n4ibQX6l9S78+XcrurM8dIA4ym4e2n4UYWkPVEXts1fhv9x4CEfcjTaruS7
         u+V7ieCY7jWa8vvHvIcUgDGlfPGLqH919QHUzt9x6CFLIoqD/FlLu8Ei3RPwtIwkuqlx
         OvQMVUOycA8p+gasEabCWdg3Ojsx3AmDpIEPQSSabcbg6ZPgWopyPx14M3QrPkuw2X3k
         TjwCKbF2yrjfDXOltePwTvQ6i/7vPSlZwc3sAmkqdBMbplSMyV3Ge6mGpeULVwx2ZCBI
         KhngbBtY9Q1R5JxTuECZuWfpYw+eXoqqbLXA68yp5WgbnD3BC4FnTdd1z0EkND76WkUI
         4nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304012; x=1698908812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIY57MrujmKId5+jCxgUo7McJ/NDQkTulF6/sNW7MFM=;
        b=VD7eVKnPafdQw1RPkza/2UkVc7kmZwWFvz0jw/Oz8AF80CR0Ot9TGYhZl8fzAyLitu
         G7vVHVddLvhqaguM6qV2CDpO4pcGffXGJIwr9EYaL6NBmeSe2wa4oMn4i5ZqZBDSchE2
         Hf1/Iv/giU8igKolfUIZowekhnynEvYW+1Fg6gk+07g7PPuN2u/hBjPDHAvbFRGzkvp3
         Lh4vT+jgAAlwzY1Q5RN9w8g5CwKltRbNvqSmk1po6TMFMSvHet6v05Qh0mihBma6+/PW
         lAu5pXEiqfeRt0e2xeelsKNzS27/C61ADyJOAErqdbZgJpzaQvTBEplw5MaFKNrZx7SU
         G7WQ==
X-Gm-Message-State: AOJu0YwDw2GITCAaE7iOEAJ8WbIERtFj0t7gbkYKolNIVRl8kChOSToz
        yxes77QcRBwwh+5/ln+CYLUpfKjk74vsiwgiaWsZOA==
X-Google-Smtp-Source: AGHT+IG8vm3Uip2ivuxFo/k7R3FDjsV9UbIHQD68sEtm1182NzoGXHpySaD3KgZzkKoqrZs2rBv/5VocL8Avdjz5t50=
X-Received: by 2002:a50:9ec5:0:b0:540:9444:222c with SMTP id
 a63-20020a509ec5000000b005409444222cmr206310edf.6.1698304012444; Thu, 26 Oct
 2023 00:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230920084903.1522728-1-mripard@kernel.org>
In-Reply-To: <20230920084903.1522728-1-mripard@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 26 Oct 2023 15:06:39 +0800
Message-ID: <CABVgOSkLSSkuwM6SqmLKtS3WbCH2SJRcqT8mmv8WwJaYine1yQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Warn if tests are slow
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000687fca06089937ec"
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

--000000000000687fca06089937ec
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Sept 2023 at 16:49, Maxime Ripard <mripard@kernel.org> wrote:
>
> Kunit recently gained support to setup attributes, the first one being
> the speed of a given test, then allowing to filter out slow tests.
>
> A slow test is defined in the documentation as taking more than one
> second. There's an another speed attribute called "super slow" but whose
> definition is less clear.
>
> Add support to the test runner to check the test execution time, and
> report tests that should be marked as slow but aren't.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>
> ---
>
> To: Brendan Higgins <brendan.higgins@linux.dev>
> To: David Gow <davidgow@google.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
>
> Changes from v1:
> - Split the patch out of the series
> - Change to trigger the warning only if the runtime is twice the
>   threshold (Jani, Rae)
> - Split the speed check into a separate function (Rae)
> - Link: https://lore.kernel.org/all/20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org/
> ---

I quite like this, though agree somewhat with Rae's comments below.

I personally think the time thresholds are, by necessity, very
'fuzzy', due to the varying speeds of different hardware. Fortunately,
the actual runtime of tests seems pretty well stratified, so the exact
threshold doesn't really matter much.

I ran some tests here, and all of the tests currently not marked slow
take <1s on every machine I tried (including the ancient 66MHz 486),
except for the drm_mm_* ones (which takes ~6s on my laptop, and times
out after 15 minutes on the aforementioned 486). Both the 1s and 2s
timeouts successfully distinguish those cases.

Ideally, I think we'd have something like:
#define KUNIT_SPEED_SLOW_THRESHOLD_S 1 /* 1 sec threshold for 'slow' tests */
#define KUNIT_SPEED_WARNING_MULTIPLIER 2 /* Warn when a test takes >
twice the threshold. */
#define KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S
(KUNIT_SPEED_WARNING_MULTIPLIER * KUNIT_SPEED_SLOW_THRESHOLD_S)

Which is perhaps excessively verbose, but is very clear as to what
we're doing. It also gives more scope to allow the ratio to be
configured for people with very slow / fast machines in the future.

Thoughts?

Otherwise, this looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..a1d5dd2bf87d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -372,6 +372,25 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> +#define KUNIT_SPEED_SLOW_THRESHOLD_S   1
> +
> +static void kunit_run_case_check_speed(struct kunit *test,
> +                                      struct kunit_case *test_case,
> +                                      struct timespec64 duration)
> +{
> +       enum kunit_speed speed = test_case->attr.speed;
> +
> +       if (duration.tv_sec < (2 * KUNIT_SPEED_SLOW_THRESHOLD_S))
> +               return;
> +
> +       if (speed == KUNIT_SPEED_VERY_SLOW || speed == KUNIT_SPEED_SLOW)
> +               return;
> +
> +       kunit_warn(test,
> +                  "Test should be marked slow (runtime: %lld.%09lds)",
> +                  duration.tv_sec, duration.tv_nsec);
> +}
> +
>  /*
>   * Initializes and runs test case. Does not clean up or do post validations.
>   */
> @@ -379,6 +398,8 @@ static void kunit_run_case_internal(struct kunit *test,
>                                     struct kunit_suite *suite,
>                                     struct kunit_case *test_case)
>  {
> +       struct timespec64 start, end;
> +
>         if (suite->init) {
>                 int ret;
>
> @@ -390,7 +411,13 @@ static void kunit_run_case_internal(struct kunit *test,
>                 }
>         }
>
> +       ktime_get_ts64(&start);
> +
>         test_case->run_case(test);
> +
> +       ktime_get_ts64(&end);
> +
> +       kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
>  }
>
>  static void kunit_case_internal_cleanup(struct kunit *test)
> --
> 2.41.0
>

--000000000000687fca06089937ec
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAX
7q9nlEMs6XmGaKPOqA1TiTG+NuZZaPJWkT1iSe7fjDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEwMjYwNzA2NTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEUDtJnC2+2M1hoq4HI9r
b0zA19I0RYAjhSxN7Ge7yLEvqLjnX8X51J8Q6s5VKI5ITl1lqPkA8YLZp71PbwddWdHLzDaYk61h
YF15pGf2Mulw7tCGnJ7JIi7js9dnfAS51bSbrPFgtmI5fijrUXD1U6llrNWlViRYOo6r4EPIKWKm
O3/wYblGwWeCjJjJCaTnKJjtcxKQFcYJdbG97P2jj4mCmE9WzOjexwForGaC/CWgmL8RMtPrsPbX
a77F6dHH0VV/DlaWSUDD1OekLv5J4xl+g5fDB4obZZS5IK6Pz4QvCPq4dgFmxZWzT1hiOimHEYQd
iRQObv7W0YVNMEsQrA==
--000000000000687fca06089937ec--
