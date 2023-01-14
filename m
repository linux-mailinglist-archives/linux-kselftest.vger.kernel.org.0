Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43866A983
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jan 2023 06:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjANFwB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Jan 2023 00:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjANFwA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Jan 2023 00:52:00 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865903AA9
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 21:51:58 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id z3so5806540uao.9
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 21:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+e6whvd1HbE7j+BDk/coeXXWC+R5xdYmPe+c6VZeSQ=;
        b=LDBWXbhOeBkm6SQ2A03zzp0MP12ch9+ZoE3h7dgVK+irmTRdDfERiVe0sT17JBs+JF
         Y7+1Nih+XtR0AXGUOwXfNQPmlIVOLnIdSiawxFQxo5/rtRe0oS6kTeRmjpChBGXdvvMq
         eyJgmf8EY3fadcqyfv9EqtHZOV8BXm4AHz/afC4K6k8v96jwiOF2WRHRDsgZU3FflzlD
         0PbMlWXPJs/gnHg74HEVfw6SCCDj22EfcQNmP9SKhkoV2KYQkLcOAYaS+u5ufl10pbTq
         GiZbG28D6dDFh9gRHit/FxZF3rjsbpOqIJooNNX8LByJW2nJtqyv3ezaZcQD8ykJiXX1
         xUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+e6whvd1HbE7j+BDk/coeXXWC+R5xdYmPe+c6VZeSQ=;
        b=Fe1OsOTLa7BuNQwZ2PQ2MUgreyxzLMus1EUcFlYdjm7fRIV2/cNuNBO40n5MRJfRg5
         e40WoeBqR6kOBgu3wTz7BhA+RvMT2lA4js0mwi/DpNpVhGhvjQ0gArY7Qael9QuD14Y2
         XCQmnX+PPIULZMief58tP5NIXjOoX+rxIypLfg9rTpwMtP41Op6eMNZClxQnz+LjovdA
         n0MlTfqG4Ctsx5CfyzDyPM+9qXFInTtnVq4ElgY/dST2qMwDewpL7nKYIfyDrqrGLHU6
         9xO3pNmeh/5cfBTWJaZ8yQ0MVKfwC23FFFgtiAcY/JZd7e/R9MDy9K7cAA+z62jXqZHY
         YIBw==
X-Gm-Message-State: AFqh2kqGu5ALG4d4Ka3HyizhfZDTecdYdfQc+kNkX+DBbGBjWDRwyU0o
        4MK/qzkbq2OjBzS0Awk5vHiXtICJbKc/daBaOv0n2g==
X-Google-Smtp-Source: AMrXdXvjT/ptjOXahe7s0A9YqLqSHG0K1RtB2MDvyAxSk4oJTOFtR5Gz22tLZXtvvjTVukculviiNbZQx3bmTyLPJEs=
X-Received: by 2002:ab0:59aa:0:b0:419:25c5:30dc with SMTP id
 g39-20020ab059aa000000b0041925c530dcmr10073685uad.26.1673675517426; Fri, 13
 Jan 2023 21:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20230113220718.2901010-1-dlatypov@google.com>
In-Reply-To: <20230113220718.2901010-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 Jan 2023 13:51:45 +0800
Message-ID: <CABVgOSnLq2=2dZ1424Z1jpws-boAwOCf=mmpbLvP1nnPvcYj_w@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_skip() should not overwrite KUNIT_FAIL()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b5eb1205f232f2a5"
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

--000000000000b5eb1205f232f2a5
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jan 2023 at 06:07, 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Currently, kunit_skip() and kunit_mark_skipped() will overwrite the
> current test's status even if it was already marked FAILED.
>
> E.g. a test that just contains this
>  KUNIT_FAIL(test, "FAIL REASON");
>  kunit_skip(test, "SKIP REASON");
> will be marked "SKIPPED" in the end.
>
> Now, tests like the above don't and shouldn't exist.
> But what happens if non-test code (e.g. KASAN) calls kunit_fail_current_test()?
>
> E.g. if we have
>   if (do_some_invalid_memory_accesses())
>     kunit_skip(");
> then the KASAN failures will get masked!
>
> This patch: make it so kunit_mark_skipped() does not modify the status
> if it's already set to something (either already to SKIPPED or FAILURE).
>
> Before this change, the KTAP output would look like
>     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:23
> FAIL REASON
>     ok 1 example_simple_test # SKIP SKIP REASON
>
> After this change:
>     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:23
> FAIL REASON
>     # example_simple_test: status already changed, not marking skipped: SKIP REASON
>     not ok 1 example_simple_test
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks very much: this makes much more sense than the old behaviour.

My only suggestion is that we add a test to verify this behaviour to
the kunit_status suite, such as:
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 4df0335d0d06..fa114785b01e 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -510,9 +510,33 @@ static void kunit_status_mark_skipped_test(struct
kunit *test)
       KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format
string: YES");
}

+static void kunit_status_skip_after_fail_test(struct kunit *test)
+{
+       struct kunit fake;
+
+       kunit_init_test(&fake, "fake test", NULL);
+
+       /* Test starts off SUCCESS. */
+       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
+
+       /* Fail the test. */
+       kunit_set_failure(&fake);
+       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_FAILURE);
+
+       /* Now mark it as skipped. */
+       kunit_mark_skipped(&fake, "Skip message");
+
+       /* The test has still failed. */
+       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_FAILURE);
+
+       /* We shouldn't use the skip reason as a status comment. */
+       KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
+}
+
static struct kunit_case kunit_status_test_cases[] = {
       KUNIT_CASE(kunit_status_set_failure_test),
       KUNIT_CASE(kunit_status_mark_skipped_test),
+       KUNIT_CASE(kunit_status_skip_after_fail_test),
       {}
};


--

Otherwise, this looks great!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
>  include/kunit/test.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87ea90576b50..39936463dde5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -386,11 +386,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>   *
>   * Marks the test as skipped. @fmt is given output as the test status
>   * comment, typically the reason the test was skipped.
> + * This has no effect if the test has already been marked skipped or failed.
>   *
>   * Test execution continues after kunit_mark_skipped() is called.
>   */
>  #define kunit_mark_skipped(test_or_suite, fmt, ...)                    \
>         do {                                                            \
> +               if (READ_ONCE((test_or_suite)->status) != KUNIT_SUCCESS) {\
> +                       kunit_warn(test_or_suite, "status already "     \
> +                                  "changed, not marking skipped: " fmt,\
> +                                  ##__VA_ARGS__);                      \
> +                       break;                                          \
> +               }                                                       \
>                 WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);     \
>                 scnprintf((test_or_suite)->status_comment,              \
>                           KUNIT_STATUS_COMMENT_SIZE,                    \
>
> base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> --
> 2.39.0.314.g84b9a713c41-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230113220718.2901010-1-dlatypov%40google.com.

--000000000000b5eb1205f232f2a5
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAW
GXlYw+U1NRo2laDI8pBzkd4ZbE0E6Jnrx0m3/8aKtjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTQwNTUxNTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABXTrQcXKB4BrHK/nAtIx
/8SYEx/8LuBUjd7AutgRp3VNjyUuU1aNjZVyJGMco7eBnmh0hraKqJwHW5MrlcspEHEcmNNfC93c
VX2mEpNusFApjL9NhnDpf4U40Mj/rh0Eg8VTRd+td/8mpTWOxMNcZnU8fLcaD7XiSjd3wGhpKgSm
eYxOTD483crYO42nJ9kSoDCLNqHOsa5YmD2a4qjTHKP9nRtp3FX/HHTLpCF5U/0AoC593leYX0Zs
BsNxBCdcRwX31dMVGP33wVzunQEv+QTO1Kvu8CrGG6DRCzm7P7k2Adhvj50tdCJTgGCowoOO1UOg
SBky4l3qVwA3gALMkw==
--000000000000b5eb1205f232f2a5--
