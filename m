Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA3760D65
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGYIoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGYInY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602661FE3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so37135e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690274537; x=1690879337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dF+FPN15gaH4vcP0PRyQwuauoPONp3hYihOafEtEyeA=;
        b=0SncupGj+5GP5Mb6mLfJYz0+/o8S8KmF9u4j4Un+SJyYTWBd3ZzcejnbZXodYgy6Kr
         sFQdKT8OirTPoMdR5+v+Bczl1hbQDdlJnhH0dWOIyR4WTvKpboNVGX+OGpxCxnn25iuQ
         hGrpy9hp7DD6OV+N2Yp9g3vhSuLTTh7o4KSJTXz+m3KK9dCAPGmGh1WwmsDkhEdiN/kM
         HVOt97D0pc5qDshjckVRd2ky5F18yvK9Zk9DLSmQc+AHSCAup/mzSSFDLr8kZZYewRVg
         wiZ4XVqAN5IOXukRO+krIV4OWImTW5clx7yTojJbIiqvNy3QnUH6oZG97Y8W8ML3+Prz
         FdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274537; x=1690879337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF+FPN15gaH4vcP0PRyQwuauoPONp3hYihOafEtEyeA=;
        b=OEHidZ1gGLFk/5G+12v7xtL8VVNGfmN08ANMztcG7Es8GMboFd9cfT/gUYw4aBtx+a
         RVQnu3LQo+48xMiAONBe246gVVp5MlGjMIDcv8qP1VMUqvm9UVvQEOEV9/wFeVssgwVE
         buwnDcNjPz3KNNG1Cr7MxA4FeVjUd+AuTNvMOWw4G+p3QHw1L2BSwIFj0UI3tJfyZXZk
         NGtox9L3xysDfOvMXo/l2eJeJVITQc+rviQ4/EZBjSynAcOwLUR82/oFvrpf21TYB6rY
         MAQojiRo+5QRzQHKWrXDggs83Zosz/g6sPfNHoER6sqhinm7mtME1zhuXjlA4P/tkY3R
         paJQ==
X-Gm-Message-State: ABy/qLYQlu24B/YgyaP2DbH6fZrRo44pjynTK7s2hkRHfbQ6OP5VRXgb
        RvQnx7VUDaiBD2LsAjMkF6CNsG/4J31xyU0E92eW4g==
X-Google-Smtp-Source: APBJJlEYQvQ7LGPHUHiU+muxsE6z7ZKiP7EIo3l0Qt9m3JTMw9dCByuK1JICVSPHt43vbxvk2OSnbmc9GW2N+p6i1o0=
X-Received: by 2002:a05:600c:4d10:b0:3f1:70d1:21a6 with SMTP id
 u16-20020a05600c4d1000b003f170d121a6mr54485wmp.0.1690274536751; Tue, 25 Jul
 2023 01:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com> <20230724162834.1354164-10-rmoar@google.com>
In-Reply-To: <20230724162834.1354164-10-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Jul 2023 16:42:03 +0800
Message-ID: <CABVgOSnWXdpdUdPL498XM3=ienZK1w6PPEfyhwg3Bbdd=nTSWw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] kunit: Add documentation of KUnit test attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005c358706014bb5c9"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000005c358706014bb5c9
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 00:31, Rae Moar <rmoar@google.com> wrote:
>
> Add documentation on the use of test attributes under the section "Tips for
> Running KUnit Tests" in the KUnit docs.
>
> Documentation includes three sections on how to mark tests with attributes,
> how attributes are reported, and how the user can filter tests using test
> attributes.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This still looks good, but an idea for an improvement (either in this
patch or a future series) would be to add some docs for --filter and
--filter_action to run_wrapper.rst, which has a list of kunit.py
options.

> Changes since v1:
> - No changes.
>
> Changes since RFC v2:
> - Add comment on KUNIT_CASE_SLOW() to documentation.
> - Add comment on how to expose raw kernel output.
> - Remove an extra line at the end of file.
>
> Changes since RFC v1:
> - This is a new patch.
>
>  .../dev-tools/kunit/running_tips.rst          | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 8e8c493f17d1..766f9cdea0fa 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -262,3 +262,169 @@ other code executed during boot, e.g.
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
> +When a user runs tests, attributes will be present in the raw kernel output (in
> +KTAP format). Note that attributes will be hidden by default in kunit.py output
> +for all passing tests but the raw kernel output can be accessed using the
> +``--raw_output`` flag. This is an example of how test attributes for test cases
> +will be formatted in kernel output:
> +
> +.. code-block:: none
> +
> +       # example_test.speed: slow
> +       ok 1 example_test
> +
> +This is an example of how test attributes for test suites will be formatted in
> +kernel output:
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
> +``--filter_action=skip`` flag to skip filtered tests instead. These tests will be
> +shown in the test output in the test but will not run. To use this feature when
> +running KUnit manually, use the module param ``kunit.filter_action=skip``.
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
> +
> +The macro ``KUNIT_CASE_SLOW(test_name)`` can be easily used to set the speed
> +of a test case to "slow".
> +
> +``module``
> +
> +This attribute indicates the name of the module associated with the test.
> +
> +This attribute is automatically saved as a string and is printed for each suite.
> +Tests can also be filtered using this attribute.
> --
> 2.41.0.487.g6d72f3e995-goog
>

--0000000000005c358706014bb5c9
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD0
85YC/d2GHtdpoojpdUaDM/hV43X7Na19IIBNJMnQPzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MjUwODQyMTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATZLCDr7gipq+yJEfmRS8
/BW7h8OgoesCZpjbmDIslL+HFHk5W8BF2LtkuLR16Uw8xbN7nqY9fEYTOcyqyAU31wxshBUJO6Kz
vDrXixrMsq5955WFJVcsixtA63l+EocnPdeIPejj3YsVQ8BAc7KxDeo1GX8Uy4aKKB7EtH0mkcrZ
olGJf6CjYh1JLF/NW6+3MHA63qQcZHKksuofOAhlvmJj/9Vule9uidf+eq6K4CWd8zrUNJVUC6iW
aS3R3BERKURB51tMSQI8SvL7D+wzSW9BbWyqKo2LNSmQJpF90Cds7T/zEpGiwyWHg7C8dOnBDFFC
AOtRVbpHDcY/47xszg==
--0000000000005c358706014bb5c9--
