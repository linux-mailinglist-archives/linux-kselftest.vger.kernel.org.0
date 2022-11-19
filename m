Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30A630D4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Nov 2022 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiKSIcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Nov 2022 03:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKSIcR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Nov 2022 03:32:17 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A60B1BB1
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:32:15 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id p1so2469033uak.11
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2anjEpl2g1pR4+oCYvGxImYfgW0sy59SCg3VJ6e8+KE=;
        b=KQ/Ld3e5PHojBFmay1M4xpDCi9Cr6gPVYCKmWdAZWNv9qDWJ6KnoOPAiE9fPoqEJq3
         VLZeNge8ax/zpjAdLud+pEFMSKWBh8oKKAzTriTxCUtdBttEKCcVcK3Ee3oq6dBP4hsT
         5G17hkFdJ+WsNt6qtxjB5LK/WD80Xz5fB3J01Zn3CKiRbv+2jbHOXt6Piulqk4El++E5
         IEzHsy+pwGONrl492d9bn/Af9ndT2e2zZMmuZyeYQBpGfXQYQMm1hvo9b13vlbTfO27M
         OPuBgjcerc1b5A1AQl4T6KCI+eM41i254AXjcRlOdaHGJteXMbRNVHBF66IRAPq4UM8Q
         yTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2anjEpl2g1pR4+oCYvGxImYfgW0sy59SCg3VJ6e8+KE=;
        b=Hk3MY00l8NB/2jXN1r9A3BmVHJ8ZMd/mVGDNntNr5FcrUxhgpK741Wb9LbGhKe2Gbm
         bt6AiFcPpEHEw6rVZEDnWAWvfarnAWKmgwD8B08lXH2qrvOcxMzUStf6F/Ajj8D1PHRm
         m2HSG51qzD8DExjsYIbLAGvcTlHgUtAFY9j9mcuVaBxAMCAsromwfZaTHXj1PeiKiQkE
         9/KQHuI2yCMEizAv0Tyi2jvmDzwoUU5sgU5hLIuyboBi/U1ZcgekSkkbGBnIW12ezjV3
         4CJY+YOK2CnvTMJuz+baNJTMuGpAV4w7ScMW3nkZX5ZD69ylBCpajAXTJ5aaqZXVfZLS
         QaZA==
X-Gm-Message-State: ANoB5plauyOV7p1uwBmg07HjHLjs88xakzQ/eMZ9ADGUXjSznF4w4GlE
        xZJC/ShzAViVHX6v8HJPC2r3eTVCkiBk0W1Q+GgItQ==
X-Google-Smtp-Source: AA0mqf4to+L5gnkUZClqyxSvKxQsE6HDZJBr2+90z8ErkvAaSScaQ/oODtb/Ufn/8ZwhbHBoNorVhqgLoAKnFQKYO9g=
X-Received: by 2002:ab0:238f:0:b0:411:968:212 with SMTP id b15-20020ab0238f000000b0041109680212mr6176340uan.107.1668846734518;
 Sat, 19 Nov 2022 00:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20221111031855.592333-1-dlatypov@google.com>
In-Reply-To: <20221111031855.592333-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 19 Nov 2022 16:32:03 +0800
Message-ID: <CABVgOSn6CaPfr_ceOzu3RUJ46TajLe7icLYsi-psnJt_knCh0g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: tweak error message when no KTAP found
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d0e25005edcea86a"
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

--000000000000d0e25005edcea86a
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 11, 2022 at 11:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We currently tell people we "couldn't find any KTAP output" with no
> indication as to what this might mean.
>
> After this patch, we get:
>
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> ============================================================
> [ERROR] Test: <missing>: Could not find any KTAP output. Did any KUnit tests run?
> ============================================================
> Testing complete. Ran 0 tests: errors: 1
>
> Note: we could try and generate a more verbose message like
> > Please check .kunit/test.log to see the raw kernel output.
> or the like, but we'd need to know what the build dir was to know where
> test.log actually lives.
>
> This patch tries to make a more minimal improvement.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I agree that this is clearer.

One minor nitpick is that we still have the (useless) 'Test:
<missing>:' prefix, which also makes the error much longer than the
'===' dividers. I think the error would be more aesthetically pleasing
if we could fix that.

That's a very minor point, though, so regardless:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_parser.py    | 2 +-
>  tools/testing/kunit/kunit_tool_test.py | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index a56c75a973b5..d0ed5dd5cfc4 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -782,7 +782,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
>         test = Test()
>         if not lines:
>                 test.name = '<missing>'
> -               test.add_error('could not find any KTAP output!')
> +               test.add_error('Could not find any KTAP output. Did any KUnit tests run?')
>                 test.status = TestStatus.FAILURE_TO_PARSE_TESTS
>         else:
>                 test = parse_test(lines, 0, [])
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 90c65b072be9..84a08cf07242 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -207,7 +207,7 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(crash_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
> -               print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
> +               print_mock.assert_any_call(StrContains('Could not find any KTAP output.'))
>                 print_mock.stop()
>                 self.assertEqual(0, len(result.subtests))
>                 self.assertEqual(result.counts.errors, 1)
> @@ -588,7 +588,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(e.exception.code, 1)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> -               self.print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
> +               self.print_mock.assert_any_call(StrContains('Could not find any KTAP output.'))
>
>         def test_exec_no_tests(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
>
> base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
> --
> 2.38.1.431.g37b22c650d-goog
>

--000000000000d0e25005edcea86a
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAZ
h9J0IXeqtlsoMuEDIIlnTTv58OemGp3sTuIyUXVUnzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTkwODMyMTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoldagdXLHnSiCai5PFnk
BdYTnmWVNeSDsR5xGwjUfyWZlRlTICYQOGA8xuV+JlzcJQToJ7ZQ7eyFpb0uaDHryVF7turIkgDz
yLjbAhPrq+jtEfxTz34wImqgF/35jP8zr/2/lABB3sfG+4Bn4wUndkRDY1fGsZIMcbNovQ98dcd7
Ic5RkowIs3bjGPYUNpL91jtSLyMsD/Ckk0vVzfdlvFULSw3Krf/bz+SBf/319hIslnyToJ9ofHrS
fEc3N+niiOPYJgkOL9P2bAla3M/f7z40jFoCdCpmrD8iJCuQ2K9Pj9Mhwh2a6STcvzWiDtHdfhEa
TvTXRph/FviLBHDEFw==
--000000000000d0e25005edcea86a--
