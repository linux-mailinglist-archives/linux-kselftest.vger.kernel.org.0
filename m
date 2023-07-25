Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBDA760D66
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGYIoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjGYIns (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDF3A86
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so58665e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690274569; x=1690879369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+RDS5NRcLAtuwBHn7yk278x72WmpR8QjmHxYjmbOCqY=;
        b=RD6xQj7GXScR+Ob7NvKuhFC8uEdbOZirmdVe9sUcWHgoKQIV75hFJLGk1oqxUejk+k
         AwKQ1zFgnD6s3yOxPMN0zNUqxw8TV4AA2mvH8NCKjwfh+/7VTQAT3GF7ov7YybVtNx52
         bcVybCCEAGIA0fntIt7TFC+WgP+IEfbzPjZKug44bdwyli88gb028KClJU44N2pNy5/w
         rmH5vxF+RWbuxYYCDIny9otNn0XTxWoqZAfvMO2RlYJjh4rjP8pxZJQepg8vsSyhi+y6
         St4ijPUartW4oThXAcsTeCqjkBOMpzU8iTXB+95ziad0wJg4c7mU+dF2dhqKl2/rgdMj
         zz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274569; x=1690879369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RDS5NRcLAtuwBHn7yk278x72WmpR8QjmHxYjmbOCqY=;
        b=Is8sZhsXdIoMSYWmWL8Ln/z6ihxvx0etvdURnRBzJKDRcIcD36HL6DfAMxE8Mcrp9r
         XJTZd4/pXwsHOPWlHKYd9eZFmOtEYKex7oYV/q03mLgSH/9zkNB1EgMS41cOx2NALoed
         2hb8ws5bfeJ5aNjGqYM+t/Z7Bo9VO7Eel4LpmAbmmiDcVo8weZ6NmgSRCc0vqysoS8CQ
         huObAzad0ufvvdu1QHkfKH9bjYwyFT1MY7Z0awPQAgDZ8J+5NzlwyjIRS4gSk7Wv0hrc
         dR0sOmOO0Zsvw1VWw+6hFSzf7PWtqQfaGaPjF/5yEFprgWUvd3MZPDWYzcntDA+eKkNK
         6WVA==
X-Gm-Message-State: ABy/qLZUf8UPbWHLzzhghPoF9nXQGpTJ4qWyfYWqDS+LEcERq/AuSLKB
        gYnuloh8plXYIXN5Fr3CnfM78eW82v7O54xrr21XZA==
X-Google-Smtp-Source: APBJJlFqVyjYNgKMjQJuIt2opgmQvOpaRtg6cUU0hzKNtoRZzvXWh+ZlcFOOlwb0OGV0GX+Tiuny5Vv28eb5Kn9ksQQ=
X-Received: by 2002:a05:600c:5111:b0:3f1:73b8:b5fe with SMTP id
 o17-20020a05600c511100b003f173b8b5femr34645wms.3.1690274569559; Tue, 25 Jul
 2023 01:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com> <20230724162834.1354164-9-rmoar@google.com>
In-Reply-To: <20230724162834.1354164-9-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Jul 2023 16:42:35 +0800
Message-ID: <CABVgOSm2iRBNpZ2_CJ=4LbdQ=Pcp=aWRFBGBW-rQF6o6hCciLA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] kunit: add tests for filtering attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004fd50706014bb7d2"
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

--0000000000004fd50706014bb7d2
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 00:31, Rae Moar <rmoar@google.com> wrote:
>
> Add four tests to executor_test.c to test behavior of filtering attributes.
>
> - parse_filter_attr_test - to test the parsing of inputted filters
>
> - filter_attr_test - to test the filtering procedure on attributes
>
> - filter_attr_empty_test - to test the behavior when all tests are filtered
>   out
>
> - filter_attr_skip_test - to test the configurable filter_action=skip
>   option
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Glad to see some tests for the parser-y bits.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>
> Changes since v1:
> - No changes.
> Changes since RFC v2:
> - Change fake suite and test case names.
> - Add a few ASSERT statements.
> Changes since RFC v1:
> - This is a new patch.
>
>  lib/kunit/executor_test.c | 116 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index d7ab069324b5..01280cb8d451 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <kunit/test.h>
> +#include <kunit/attributes.h>
>
>  static void kfree_at_end(struct kunit *test, const void *to_free);
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> @@ -108,11 +109,126 @@ static void filter_suites_to_empty_test(struct kunit *test)
>                                 "should be empty to indicate no match");
>  }
>
> +static void parse_filter_attr_test(struct kunit *test)
> +{
> +       int j, filter_count;
> +       struct kunit_attr_filter *parsed_filters;
> +       char *filters = "speed>slow, module!=example";
> +       int err = 0;
> +
> +       filter_count = kunit_get_filter_count(filters);
> +       KUNIT_EXPECT_EQ(test, filter_count, 2);
> +
> +       parsed_filters = kunit_kcalloc(test, filter_count + 1, sizeof(*parsed_filters),
> +                       GFP_KERNEL);
> +       for (j = 0; j < filter_count; j++) {
> +               parsed_filters[j] = kunit_next_attr_filter(&filters, &err);
> +               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
> +       }
> +
> +       KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
> +       KUNIT_EXPECT_STREQ(test, parsed_filters[0].input, ">slow");
> +
> +       KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[1]), "module");
> +       KUNIT_EXPECT_STREQ(test, parsed_filters[1].input, "!=example");
> +}
> +
> +static struct kunit_case dummy_attr_test_cases[] = {
> +       /* .run_case is not important, just needs to be non-NULL */
> +       { .name = "slow", .run_case = dummy_test, .module_name = "dummy",
> +         .attr.speed = KUNIT_SPEED_SLOW },
> +       { .name = "normal", .run_case = dummy_test, .module_name = "dummy" },
> +       {},
> +};
> +
> +static void filter_attr_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] = {NULL, NULL};
> +       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> +       struct suite_set got;
> +       int err = 0;
> +
> +       subsuite[0] = alloc_fake_suite(test, "normal_suite", dummy_attr_test_cases);
> +       subsuite[1] = alloc_fake_suite(test, "slow_suite", dummy_attr_test_cases);
> +       subsuite[1]->attr.speed = KUNIT_SPEED_SLOW; // Set suite attribute
> +
> +       /*
> +        * Want: normal_suite(slow, normal), slow_suite(slow, normal),
> +        *              NULL -> normal_suite(normal), NULL
> +        *
> +        * The normal test in slow_suite is filtered out because the speed
> +        * attribute is unset and thus, the filtering is based on the parent attribute
> +        * of slow.
> +        */
> +       got = kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL, &err);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> +       KUNIT_ASSERT_EQ(test, err, 0);
> +       kfree_at_end(test, got.start);
> +
> +       /* Validate we just have normal_suite */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> +       KUNIT_EXPECT_STREQ(test, got.start[0]->name, "normal_suite");
> +       KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> +
> +       /* Now validate we just have normal test case */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> +       KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
> +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> +}
> +
> +static void filter_attr_empty_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] = {NULL, NULL};
> +       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> +       struct suite_set got;
> +       int err = 0;
> +
> +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
> +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
> +
> +       got = kunit_filter_suites(&suite_set, NULL, "module!=dummy", NULL, &err);
> +       KUNIT_ASSERT_EQ(test, err, 0);
> +       kfree_at_end(test, got.start); /* just in case */
> +
> +       KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
> +                               "should be empty to indicate no match");
> +}
> +
> +static void filter_attr_skip_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[2] = {NULL};
> +       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[1]};
> +       struct suite_set got;
> +       int err = 0;
> +
> +       subsuite[0] = alloc_fake_suite(test, "suite", dummy_attr_test_cases);
> +
> +       /* Want: suite(slow, normal), NULL -> suite(slow with SKIP, normal), NULL */
> +       got = kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip", &err);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> +       KUNIT_ASSERT_EQ(test, err, 0);
> +       kfree_at_end(test, got.start);
> +
> +       /* Validate we have both the slow and normal test */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> +       KUNIT_ASSERT_EQ(test, kunit_suite_num_test_cases(got.start[0]), 2);
> +       KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "slow");
> +       KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[1].name, "normal");
> +
> +       /* Now ensure slow is skipped and normal is not */
> +       KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
> +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
> +}
> +
>  static struct kunit_case executor_test_cases[] = {
>         KUNIT_CASE(parse_filter_test),
>         KUNIT_CASE(filter_suites_test),
>         KUNIT_CASE(filter_suites_test_glob_test),
>         KUNIT_CASE(filter_suites_to_empty_test),
> +       KUNIT_CASE(parse_filter_attr_test),
> +       KUNIT_CASE(filter_attr_test),
> +       KUNIT_CASE(filter_attr_empty_test),
> +       KUNIT_CASE(filter_attr_skip_test),
>         {}
>  };
>
> --
> 2.41.0.487.g6d72f3e995-goog
>

--0000000000004fd50706014bb7d2
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAM
cSsNUwGwfGuutWEXqPOXNK9BCNuXTnWlxpodF4NN/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MjUwODQyNDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAFfwf2edLxQ31qbL/hbQs
HcG/TYjNsFVo6eoWD2zoF1RiJNyzJJ/A+8Vedm8IJ0RdPnby7OSArVg041MTugiau0apgoVC1EVr
OAy4xYyMtOzDS5MBHUW8y21O4UT+YO5kkTDhDHPgAyM9nfQ6Ljk28CYoF9u2AeBkJCOg4dZJierF
NRgIevSPt0hOa2rHnZhrY2I5hpYj5xZyfnMO5JpyzFbgXHcZ1kd1uLhxA9qA6q8uofzaCeoXmt8q
0dtChRiKXDMtiC3t1+jSMGqpk3d3CHfgXyMlKI+FdEC4nnOJBumo9nFrvW5lfeodwc+s1WxFkFxN
Q7R22hC0wIBix6XUWw==
--0000000000004fd50706014bb7d2--
