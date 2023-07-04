Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40960746DE9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGDJqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDJqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 05:46:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAA9A3
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 02:46:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51db8a4dc60so16332a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688463968; x=1691055968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqQShIlAl3UXzT6lNSIXxTs4Kf4wburjPazj7lBubZk=;
        b=GiT2GDjTHjtPqymC02u1J9K2tGMmmFLnV7A2mqcAcy1i5r1raa8oFdR1rp6jKnyXBr
         TLqIjeP3GlZvEGx7YxD2zgFQpTvGCzww9KFN/6wjV/63oJlqzkKybXD5VlRUcCEWjieR
         yREkzyIhl/k/8dMJME1cpRWSAD0r3jZJjPgAAmZoTLcNdqN2aCRQOHUGIMzaTUi+TYAH
         dxzWoLF7gl7rkShs7XM4vR0uZ5WbjPaGUZWhR5L1tQGoURDdThT5HZzRv4E60SzRWeaV
         GKo2ILVN+AJ7fm0h0B66x7u/cGRxmKg0hbbkuMvxUeDElQjm0utvg0+uU/Xg53T640+G
         +xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688463968; x=1691055968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqQShIlAl3UXzT6lNSIXxTs4Kf4wburjPazj7lBubZk=;
        b=VxCnoHuUo9e0h5ddU0sQQ2zoa28gevOxqmcqve7VboHxDeHJGCTwxKjJLDZ7/HHJ5W
         mMdxPQ8rPQlJamhkyg/wFGOGwgAoGl/JxpDx55B+95/XkvL168su4K3RbpzIVCPkvky9
         TOdh3ZjJqNR67ObVYWwBH6vvRLbDkQJjo/xtHjNoKu/a9zDNt3g96d5n/0yGdjWTUSNd
         VbLzs2bDcGuOwCqr1dzm8Orl32OlhtRqhGnATTg715ZvdzO1ZbpC2Goz+CzccoZrKvNz
         xeUqGxXLKWFzSYbkGRfb0+Yxca3dWb38sW8rbM+VSvUmcKr0gVoe8bf1hhhAX+VJsPK1
         byvg==
X-Gm-Message-State: ABy/qLZ9pI8OcaERg2R3M+sRW8e8JE34+atO0ihY9mkFvu4JKyZ7/ANy
        6rF2vzBvr5RADl7i4cSAVeGEPB8+YQYk0n2X7UL88Q==
X-Google-Smtp-Source: APBJJlHWF8irYy8HCjDNlQtUrGBi3Wbbxms3hLedpgY8bPSqYStNXhvGrq1ZfBgzGehE+twd3Wxf/fS2cAR88SWGdx0=
X-Received: by 2002:a50:9f66:0:b0:514:95d4:c2bb with SMTP id
 b93-20020a509f66000000b0051495d4c2bbmr33896edf.2.1688463967936; Tue, 04 Jul
 2023 02:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230702092308.4a022336@sal.lan>
In-Reply-To: <20230702092308.4a022336@sal.lan>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Jul 2023 17:45:54 +0800
Message-ID: <CABVgOSk2uW6DN8682om3Mxn9O3oF4mDYY1vdG-R9z6YC0B+Ndw@mail.gmail.com>
Subject: Re: Tests documentation
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        mauro.chehab@intel.com, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000d306f05ffa6277b"
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

--0000000000000d306f05ffa6277b
Content-Type: text/plain; charset="UTF-8"

(+CC Rae, for attributes/fields)

On Sun, 2 Jul 2023 at 15:23, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Hi Jon, Shuah & others,
>
> I'd like to discuss with you with regards to test documentation.
>
> I had some preliminary discussions with people interested on improving
> tests during EOSS last week in Prague, as we're working to improve media
> test coverage as well. During such discussions, I talked with developers
> from several companies that have been collaboration and/or using Kernel
> CI. I also talked with Nikolai from Red Hat, who gave a presentation about
> Kernel CI, which points that one of the areas to be improved there is
> documentation.
>
> So, it seems it is worth having some discussions about how to improve
> Kernel test documentation.
>

Awesome: it'd definitely be nice to have some better documentation for
specific tests. While the documentation for test systems as a whole
seems okay (though could always do with improvement), I agree that
documentation for individual test suites seems to mostly be either
nonexistent, or exists only as unstructured text somewhere in the
subsystem docs (or worse, a random wiki).

I've left a few first impressions / notes below:

> While kernel_doc does a pretty decent job documenting functions and data
> structures, for tests, the most important things to be documented are:
>
>         a. what the tests do;
>         b. what functionalities they are testing.
>
> This is a lot more important than documenting functions - and the used
> data structures on tests are typically the ones that are part of the
> driver's kAPI or uAPI, so they should be documented somewhere else.
>
> Usually, (b) is not so simple, as, at least for complex hardware,
> the tested features are grouped on an hierarchical way, like:
>
>         1. hardware
>         1.1 DMA engine
>         1.2 output ports
>         ...
>         2. firmware
>         2.1 firmware load
>         2.2 firmware DMA actions
>         ...
>         3. kernel features
>         3.1 memory allocation
>         3.2 mmap
>         3.3 bind/unbind
>         ...
>
> CI engines running the test sets usually want to produce a report that will
> be providing pass rates for the tested features and functionalites that
> are available at the driver's and their respective hardware and firmware.
>
> I've doing some work at the tool we use to test DRM code [1] in order to
> have a decent documentation of the tests we have hosted there, focusing
> mostly on tests for i915 and Xe Intel drivers, also covering documentation
> for DRM core tests - while providing support for other vendors to also
> improve their test documentation for IGT - IGT GPU tools and tests.
>
> The documentation tool I developed is generic enough to be used for other
> test sets and I believe it could be useful as well to document Kselftest
> and KUnit.
>
> The core of the tool (at test_list.py) is a Python class, with some callers
> (igt_doc.py, xls_to_doc.py, doc_to_xls.py), being extensible enough to
> also have other callers to integrate with external tools. We are
> developing internally one to integrate with our internal Grafana reports
> to report the pass rate per documented feature, in an hierarchical way.

A lot of tests/test frameworks already have some sort of hierarchy: I
suspect there'll be some cases where it makes sense to either
duplicate that, or deviate from it, but it'd be nice to reuse it where
it makes sense.

I imagine this gets more interesting as we have tests which span
different frameworks, or if we have tests which need to show up
multiple times.

> Something similar to:
>
>         1. hardware        pass rate:  98% (98 tests passed of 100)
>         1.1 DMA engine     pass rate:  80% (8  tests passed of  10)
>         1.2 output ports   pass rate: 100% (10 tests passed of  10)
>         ...
>
> It is based on the concept that test documentation should be placed as
> close as possible to the actual code implementing the test sets. It was
> also be developed in a way that the documentation grouping is flexible.
> The code was written from the scratch in Python and was implemented
> inside a class that can also be re-used to do do other nice things,
> like importing/exporting test documentation to spreadsheets and
> integration with other tools (like Grafana).
>
> The actual documentation tags look like this:
>
>         /**
>          * TEST: Check if new IGT test documentation logic functionality is working
>          * Category: Software build block
>          * Sub-category: documentation
>          * Functionality: test documentation
>          * Issue: none
>          * Description: Complete description of this test
>          *
>          * SUBTEST: foo
>          * Description: do foo things
>          *      description continuing on another line
>          *
>          * SUBTEST: bar
>          * Description: do bar things
>          *      description continuing on another line
>          * Functionality: bar test doc
>          */

How would these test/subtest names fit with, e.g., KUnit test/suite
names? Would we want to require them to be the same, in which case can
we parse them from the actual test declarations? Or would tests end up
with multiple names?

>
> And it has support for wildcards.
>
> There, "TEST" is associated to the contents of the file, while "SUBTEST"
> refers to each specific subtest inside it. The valid fields are imported
> from JSON config files, and can be placed into an hierarchical way, in
> order to produce an hierarchical documentation. Fields defined at the
> "TEST" level are imported on "SUBTEST", but can be overriden.

If we assume that for KUnit, TEST == suite and SUBTEST == test, we hit
the small issue that there can be multiple test suites per file.
Ideally, we'd support a more arbitrary hierarchy here.

>
> The JSON config file looks like this:
>         https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/158feaa20fa2b9424ee544efd2e0e0892562f8f0/tests/xe/xe_test_config.json

We're looking into having support for some level of test metadata in
both KTAPv2[1] and KUnit[2], which might be an interesting point of
comparison. (Things like inheritence work similarly.)

The advantages of having some of these fields being stored as a part
of the test itself include having more self-descriptive results (being
more readable without the source code / docs open) and the ability to
filter test runs based on these fields.

I'd be really interested in working out what sorts of
fields/attributes would be useful, too. I'm sure there'd be a lot of
"general" ones, which it'd be nice to keep consistent across different
subsystems. Though per-subsystem attributes are also really
interesting: it'd be great if we could easily have tooling filter
tests by "needs this GPU" or similar.

>
> The output is in ReST, which can be generated in hierarchical or per-file
> way. The hierarchical output looks like this:
>
>         $ ./scripts/igt_doc.py --config tests/xe/xe_test_config.json --file fubar_tests.c
>
>         ===============================
>         Implemented Tests for Xe Driver
>         ===============================
>
>         Category: Software build block
>         ==============================
>
>         Sub-category: documentation
>         ---------------------------
>
>         Functionality: bar test doc
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
>         ``igt@fubar_tests@bar``
>
>         :Description: do bar things description continuing on another line
>         :Issue: none
>
>         Functionality: test documentation
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
>         ``igt@fubar_tests@foo``
>
>         :Description: do foo things description continuing on another line
>         :Issue: none
>
> (if --file is not used, it will use all C files specified at the
> configuration)
>
> The tool already skips tags like the ones used by kernel-doc[1], so one
> could have both function documentation and per-test documentation on
> the same file, if needed.
>
> While such tool was conceived to be part of IGT, it doesn't have anything
> specific for it [2], and I do believe it would be a great contribution to
> the Kernel to have such tool upstreamed, and integrated as a Sphinx
> extension.
>
> If we decide to go ahead adding it, I can work on a patchset to apply
> it to the Kernel, modifying the scripts to better fit at the Kernel
> needs and start with some documentation examples for i915,
> DRM core and upcoming Xe KUnit tests.
>
> Comments?

I like the idea overall, but do feel it'd be nice to integrate enough
with the various test systems to avoid any rough edges where things
like test layout crash, or we end up with too much duplication of
features.
That being said, I'd rather have a bit of redundancy and a few
mismatches if it keeps this simple and more easily used with arbitrary
test systems.

>
> Regards,
> Mauro
>
> [1] It should be trivial to patch kernel-doc for it to skip TEST and
>     SUBTEST tags if we decide to integrate it to the kernel.
>
> [2] except that tests there are named after IGT, as
>     <igt <test>@<subtest>@<dynamic_subtest>, but a change to a
>     Kernel-specific namespace would be trivial

[1]: https://lore.kernel.org/all/20230420205734.1288498-1-rmoar@google.com/
[2]: https://lore.kernel.org/linux-kselftest/20230610005149.1145665-1-rmoar@google.com/

--0000000000000d306f05ffa6277b
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCN
tRjjgrNtF0q+XCCM8DaFseT6p04MZPNCZJj1hfVc8jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MDQwOTQ2MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAD6AHM48qzPgvW/FpRsG5
En7CrcZFwvFPhKCphUOFRG1Ba3dPE1j6sGG8SuXp84nja3K79O2X5zpxdvZXSPRRGfsfTE1ZIEw2
JoutOmdiXowkwH5Zal6XLx5JXexwDQSGgIKYSqLgbdWBubmVWQyMEYJLBuDDA3L9VSkMmlrZQRUv
ajAWkVcDTbLcxFij6lKgJiyI7CpFTVd7/ojGpLQsifAreejkf/BmzHyfRq5VlMz6cDHjiAzTEsAh
AWMquw20bmnSermY7UuM1wZHWxcbxx7KwONNDwdE/etKum15T3uhr332bzHaNZh6MZ2Z/bY2JRed
pegjPpCVv61Rxu4UpA==
--0000000000000d306f05ffa6277b--
