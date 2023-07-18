Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8520C75757F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGRHj7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjGRHj5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 03:39:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A77310CC
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86840c45dso2113e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689665982; x=1692257982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7SNNJhv3G2qziU8O7FOQKkgwfqlI7cpLxod074jjmE=;
        b=NMW09KklCEN2SsakTB4e5X81pjfKybGnkELj4xcLGYWnExE6v83AiKCIqUQcJeMo5Z
         1UH7BWcy4hMvgDTe41DDSTkj7UtV7G3OebN8uWBlyiqDdlIBYfWTS8TYmtN12mFa9QOD
         UnGaqRUddkRctqJeYhA49+pme9gkN+MOiq53RxYvXtb3pactiFy6sMl72qjpPTGv9iMZ
         n8bJTN8qnz6RCySk9wWPTjALWcTk8DEMx8X+53VGoophuOEMQ/3pom7jBlLneTdFO7cf
         Pj3YQMosNnquc7XdpT5EdLwr/NKqfrBV0nHEQGpxoFrGYC1UDHeOpPp5/uIGkKqEiLAe
         WzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665982; x=1692257982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7SNNJhv3G2qziU8O7FOQKkgwfqlI7cpLxod074jjmE=;
        b=RxB+dHF9KiCa+VnbXVc5B3hGSw8/VqCg5gv9/Mx+lAZwpqDEKWoBi5CjLyS4TIBnXY
         gwwCvDRKu9/RTFYbTFdmhUeW/btbx4coFVawApQ3QXt7ZnWalmsH+c1arDfXf9UL+zNy
         MqBHXKzXV5yHAFX5McC5sNYWYc/tf+Lgb3ZuL1V+1Qe2D++n5UKp1xBk6h/mogwYUpI0
         1mjiBOpCZoadtfriIbAMek2sjE59H2mFbn2pKtCDqy5J6EyLAqLriBhRchpADZzK4xG2
         Arb/wyRo8ZHigZqoqBFeUSxjB87nleMkyf+HkiGHVq33fwv5kRym6nRVH2LahjZ+sWc/
         tj6w==
X-Gm-Message-State: ABy/qLY5eAvrlSOrUeUTgjglKxCGqMZ7YdfPk+0Jk1jcdYdUVz7LsETS
        qHAR8/exEO+pdwU6Bu/+vE2CQH9v3F5ej5mbb6WuqA==
X-Google-Smtp-Source: APBJJlFZ+G0Y9w62eyGp93HUw8RKd7yX+UAgnwpcRHbd53jzva+BNayF/7q/5m1j2GMW3u0XkLr1o4m2mwvNWk/WmM0=
X-Received: by 2002:ac2:4835:0:b0:4f2:632d:4d5d with SMTP id
 21-20020ac24835000000b004f2632d4d5dmr58865lft.0.1689665982618; Tue, 18 Jul
 2023 00:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-10-rmoar@google.com>
In-Reply-To: <20230707210947.1208717-10-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 15:39:31 +0800
Message-ID: <CABVgOS=1kwHn8BtB55i3TMcXB9+RveiyGn4aYja_agkc4_yH-w@mail.gmail.com>
Subject: Re: [RFC v2 9/9] kunit: Add documentation of KUnit test attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b48c7c0600be04f4"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000b48c7c0600be04f4
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jul 2023 at 05:10, Rae Moar <rmoar@google.com> wrote:
>
> Add documentation on the use of test attributes under the section "Tips for
> Running KUnit Tests" in the KUnit docs.
>
> Documentation includes three sections on how to mark tests with attributes,
> how attributes are reported, and how the user can filter tests using test
> attributes.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good overall. Some nitpicks below.

Reviewed-by: David Gow <davidgow@google.com>

>
> Changes since v1:
> - This is a new patch
>
>  .../dev-tools/kunit/running_tips.rst          | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 8e8c493f17d1..c9bc5a6595d3 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -262,3 +262,166 @@ other code executed during boot, e.g.
>         # Reset coverage counters before running the test.
>         $ echo 0 > /sys/kernel/debug/gcov/reset
>         $ modprobe kunit-example-test
> +
> +
> +Test Attributes and Filtering
> +=============================
> +
> +Test suites and cases can be marked with test attributes, such as speed of
> +test. These attributes will later be printed in test output and can be used to
> +filter test execution.
> +
> +Marking Test Attributes
> +-----------------------
> +
> +Tests are marked with an attribute by including a ``kunit_attributes`` object
> +in the test definition.
> +
> +Test cases can be marked using the ``KUNIT_CASE_ATTR(test_name, attributes)``
> +macro to define the test case instead of ``KUNIT_CASE(test_name)``.
> +
> +.. code-block:: c
> +
> +       static const struct kunit_attributes example_attr = {
> +               .speed = KUNIT_VERY_SLOW,
> +       };
> +
> +       static struct kunit_case example_test_cases[] = {
> +               KUNIT_CASE_ATTR(example_test, example_attr),
> +       };
> +
> +.. note::
> +       To mark a test case as slow, you can also use ``KUNIT_CASE_SLOW(test_name)``.
> +       This is a helpful macro as the slow attribute is the most commonly used.
> +
> +Test suites can be marked with an attribute by setting the "attr" field in the
> +suite definition.
> +
> +.. code-block:: c
> +
> +       static const struct kunit_attributes example_attr = {
> +               .speed = KUNIT_VERY_SLOW,
> +       };
> +
> +       static struct kunit_suite example_test_suite = {
> +               ...,
> +               .attr = example_attr,
> +       };
> +
> +.. note::
> +       Not all attributes need to be set in a ``kunit_attributes`` object. Unset
> +       attributes will remain uninitialized and act as though the attribute is set
> +       to 0 or NULL. Thus, if an attribute is set to 0, it is treated as unset.
> +       These unset attributes will not be reported and may act as a default value
> +       for filtering purposes.
> +
> +Reporting Attributes
> +--------------------
> +
> +When a user runs tests, attributes will be present in kernel output (in KTAP
> +format). This is an example of how test attributes for test cases will be formatted
> +in Kernel output:
> +
> +.. code-block:: none
> +
> +       # example_test.speed: slow
> +       ok 1 example_test
> +
> +This is an example of how test attributes for test suites will be formatted in
> +Kernel output:
> +
> +.. code-block:: none
> +
> +         KTAP version 2
> +         # Subtest: example_suite
> +         # module: kunit_example_test
> +         1..3
> +         ...
> +       ok 1 example_suite
> +

Maybe worth noting that kunit.py will hide these for passing tests by
default, and --raw_output is needed to see them?

> +Additionally, users can output a full attribute report of tests with their
> +attributes, using the command line flag ``--list_tests_attr``:
> +
> +.. code-block:: bash
> +
> +       kunit.py run "example" --list_tests_attr
> +
> +.. note::
> +       This report can be accessed when running KUnit manually by passing in the
> +       module_param ``kunit.action=list_attr``.
> +
> +Filtering
> +---------
> +
> +Users can filter tests using the ``--filter`` command line flag when running
> +tests. As an example:
> +
> +.. code-block:: bash
> +
> +       kunit.py run --filter speed=slow
> +
> +
> +You can also use the following operations on filters: "<", ">", "<=", ">=",
> +"!=", and "=". Example:
> +
> +.. code-block:: bash
> +
> +       kunit.py run --filter "speed>slow"
> +
> +This example will run all tests with speeds faster than slow. Note that the
> +characters < and > are often interpreted by the shell, so they may need to be
> +quoted or escaped, as above.
> +
> +Additionally, you can use multiple filters at once. Simply separate filters
> +using commas. Example:
> +
> +.. code-block:: bash
> +
> +       kunit.py run --filter "speed>slow, module=kunit_example_test"
> +
> +.. note::
> +       You can use this filtering feature when running KUnit manually by passing
> +       the filter as a module param: ``kunit.filter="speed>slow, speed<=normal"``.
> +
> +Filtered tests will not run or show up in the test output. You can use the
> +``--filter_skip`` flag to skip filtered tests instead. These tests will be
> +shown in the test output in the test but will not run. To use this feature when
> +running KUnit manually, use the ``kunit.filter`` module param with
> +``kunit.filter_action=skip``.
> +
> +Rules of Filtering Procedure
> +----------------------------
> +
> +Since both suites and test cases can have attributes, there may be conflicts
> +between attributes during filtering. The process of filtering follows these
> +rules:
> +
> +- Filtering always operates at a per-test level.
> +
> +- If a test has an attribute set, then the test's value is filtered on.
> +
> +- Otherwise, the value falls back to the suite's value.
> +
> +- If neither are set, the attribute has a global "default" value, which is used.
> +
> +List of Current Attributes
> +--------------------------

I wonder whether this should end up part of the KTAP spec (or as an
appendix/supplement to it). Or even as a separate page within the
KUnit documentation to avoid running_tips.rst from getting too huge.

> +
> +``speed``
> +
> +This attribute indicates the speed of a test's execution (how slow or fast the
> +test is).
> +
> +This attribute is saved as an enum with the following categories: "normal",
> +"slow", or "very_slow". The assumed default speed for tests is "normal". This
> +indicates that the test takes a relatively trivial amount of time (less than
> +1 second), regardless of the machine it is running on. Any test slower than
> +this could be marked as "slow" or "very_slow".

Is it worth noting that "KUNIT_CASE_SLOW()" can be used to easily set
this to slow?


> +
> +``module``
> +
> +This attribute indicates the name of the module associated with the test.
> +
> +This attribute is automatically saved as a string and is printed for each suite.
> +Tests can also be filtered using this attribute.
> +
> --
> 2.41.0.255.g8b1d071c50-goog

>

Error: new blank line at EOF.

--000000000000b48c7c0600be04f4
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBU
hZmKueetvb8ekYMi7G1YjP161TV2lQPPVkf6mlQPVTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwNzM5NDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAaC7izUpsCfpV2OPx4psB
uhdQ8GHq0Tav9ixJGFAOIa2MO2w/XqVCub3C0QDtT4vU2gdaFsIyD3YzDK5FrkGmm9pfMUwWJvjo
i9BGJnMuvjvqRSikQnr0PWhjwnCR8K2qO2SLG0jAgSdt/LakRzOdpYjLGZ5C9t1BxRFwmH/s+ZQG
evhhxLDGW93BC1ZTyGflVE6QE1y/CV5n9CZPNTpyURCi0c9jobEMzjVT124sdwAOkfDXtvgJHT9Z
HXZ6AfjYrW1AkRlH/Swtyuv+ooiSsQ/uGzt/iVG1wjH1ffNazfGtTdDE4IzqPoha1zAewC+a8Ggo
7MHUR9WkRUpNz8Z86g==
--000000000000b48c7c0600be04f4--
