Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60056AFE13
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 06:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCHFFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 00:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHFFC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 00:05:02 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE0521EB
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 21:05:00 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p2so10480337uap.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678251900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6O2w4hayVyPT8F/oQFPYfI2d6ILpOvdy1EAe0CHk+Mk=;
        b=std2CQ6VOd70JZUw9wG6BxkvPZ3Z7ltHS9dk8ntQIQmzImLvs2NQCVUjB6OD+yzrec
         M0uiyR5oC9SfSHwzf393fmwhqJo4A8TD+jRlIAHdg2c8TX5cUfQbXzH+io181cQ8ZzAA
         Fge4c5/yjQDxpKZ0/T81DsQPOfRnkYwWuJM55nabC0sHt88A5bDe32ggdbAVKt+8wCb+
         xBa61ptDUh+njC0cyKW6dC+xSqRDrnlda6uq/rRxPmOyxVRyQuag8K5vmkSk2TFFNrwU
         1Cfc8LSx8Lx630wFkPqODo82CraIlL5SJt9CBeBOH14G3DdQPkxNw9Os3ZynGmbnQLhj
         yeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678251900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6O2w4hayVyPT8F/oQFPYfI2d6ILpOvdy1EAe0CHk+Mk=;
        b=MLugT9hskfxUPl8IEO70FLbdtxKCA0ypygkPpTI92JUoEs+8lG35uz7x1QLlTl/buR
         ZFapXWdGP4ulgS8J9xZLMRqvWYAOFNm3307SyxDTU39173QcCv936UBMzlYvUUu7reEk
         5dcOi2uJmmibTH2YWMjFeE4NrzGDAvYq0GMF9Ie/uhPOLxTnYvg48Ifr+7XPFjNKM7Bi
         6Cmq0Dw2auZGlVKzYQeyrkdm5k1ZNOAeExs3uqXZ7whhLWjpMxqw2JPoMqfza3+kBesm
         n+HCmYcm6d3bPmHaxoohwybiqnk4jZjoMCnsRj0fdk1mjgHoS7whdxqgn9Gea9n/VLdz
         +8OQ==
X-Gm-Message-State: AO0yUKV1Jb2smEW81HRx+kk1y31LZkymBvxAqHPLcxTYZK2gPkQ2mumv
        qndprVS8dhXxIoPON3c2vCL0cDg3x3OeYYt0+eVnmQ==
X-Google-Smtp-Source: AK7set+4BUMsZ732fMW7noscfMsWblY0Bhmaj33UYRsgJCLObqhOnsFjfnZedoRcCJTf3jS5REOFPoRa49M6ces089Y=
X-Received: by 2002:ab0:4714:0:b0:68e:2ed3:92eb with SMTP id
 h20-20020ab04714000000b0068e2ed392ebmr5275409uac.1.1678251899774; Tue, 07 Mar
 2023 21:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20230307223937.2892762-1-rmoar@google.com>
In-Reply-To: <20230307223937.2892762-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 8 Mar 2023 13:04:47 +0800
Message-ID: <CABVgOSmwywCsUv6Bcd=b5jB_-g4W1XR1CBo2-6bsnABWgXsvTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: fix bug in debugfs logs of parameterized tests
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005aa96605f65c78ed"
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

--0000000000005aa96605f65c78ed
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Mar 2023 at 06:39, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug in debugfs logs that causes individual parameterized results to not
> appear because the log is reinitialized (cleared) when each parameter is
> run.
>
> Ensure these results appear in the debugfs logs, increase log size to
> allow for the size of parameterized results. As a result, append lines to
> the log directly rather than using an intermediate variable that can cause
> stack size warnings due to the increased log size.
>
> Here is the debugfs log of ext4_inode_test which uses parameterized tests
> before the fix:
>
>      KTAP version 1
>
>      # Subtest: ext4_inode_test
>      1..1
>  # Totals: pass:16 fail:0 skip:0 total:16
>  ok 1 ext4_inode_test
>
> As you can see, this log does not include any of the individual
> parametrized results.
>
> After (in combination with the next two fixes to remove extra empty line
> and ensure KTAP valid format):
>
>  KTAP version 1
>  1..1
>      KTAP version 1
>      # Subtest: ext4_inode_test
>      1..1
>         KTAP version 1
>          # Subtest: inode_test_xtimestamp_decoding
>          ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
>          ... (the rest of the individual parameterized tests)
>          ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra
>      # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
>      ok 1 inode_test_xtimestamp_decoding
>  # Totals: pass:16 fail:0 skip:0 total:16
>  ok 1 ext4_inode_test
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Thanks, this is working fine here!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David





>
> Changes from v2 -> v3:
> - Fix a off-by-one bug in the kunit_log_append method.
>
> Changes from v1 -> v2:
> - Remove the use of the line variable in kunit_log_append that was causing
>   stack size warnings.
> - Add before and after to the commit message.
>
>  include/kunit/test.h |  2 +-
>  lib/kunit/test.c     | 18 ++++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 08d3559dd703..0668d29f3453 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>  struct kunit;
>
>  /* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 512
> +#define KUNIT_LOG_SIZE 1500
>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9e15bb60058..c4d6304edd61 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -114,22 +114,27 @@ static void kunit_print_test_stats(struct kunit *test,
>   */
>  void kunit_log_append(char *log, const char *fmt, ...)
>  {
> -       char line[KUNIT_LOG_SIZE];
>         va_list args;
> -       int len_left;
> +       int len, log_len, len_left;
>
>         if (!log)
>                 return;
>
> -       len_left = KUNIT_LOG_SIZE - strlen(log) - 1;
> +       log_len = strlen(log);
> +       len_left = KUNIT_LOG_SIZE - log_len - 1;
>         if (len_left <= 0)
>                 return;
>
> +       /* Evaluate length of line to add to log */
>         va_start(args, fmt);
> -       vsnprintf(line, sizeof(line), fmt, args);
> +       len = vsnprintf(NULL, 0, fmt, args) + 1;
> +       va_end(args);
> +
> +       /* Print formatted line to the log */
> +       va_start(args, fmt);
> +       vsnprintf(log + log_len, min(len, len_left), fmt, args);
>         va_end(args);
>
> -       strncat(log, line, len_left);
>  }
>  EXPORT_SYMBOL_GPL(kunit_log_append);
>
> @@ -437,7 +442,6 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         struct kunit_try_catch_context context;
>         struct kunit_try_catch *try_catch;
>
> -       kunit_init_test(test, test_case->name, test_case->log);
>         try_catch = &test->try_catch;
>
>         kunit_try_catch_init(try_catch,
> @@ -533,6 +537,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 struct kunit_result_stats param_stats = { 0 };
>                 test_case->status = KUNIT_SKIPPED;
>
> +               kunit_init_test(&test, test_case->name, test_case->log);
> +
>                 if (!test_case->generate_params) {
>                         /* Non-parameterised test. */
>                         kunit_run_case_catch_errors(suite, test_case, &test);
>
> base-commit: 60684c2bd35064043360e6f716d1b7c20e967b7d
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>

--0000000000005aa96605f65c78ed
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAH
lXb2GNYyVcJNVYgaK3W4YXjQEzQg/F7LEOQDXEr4sTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDgwNTA1MDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATY+89nXp0/eMii2wg4tc
D9PMKe4WA4uUCfBUpohNkTN+EVcnccGZFrd/nCeTYPT3cd3e/JG5T9r6+NkpM4ML5BuPGe1W5tGC
CfvqP2yFjTqxVOlUVdL4vNYYYUf1oTD18W4etgxaErwQia7AnhmYQZ/HBlRRkJgWbYaFFb0jL0a9
IGEUqhTjbFpnLJWaEbIIkwDn0bs0LOTRC3wnq/+77sqjPoR+ZMg2ETIGUOh128ZDcrLcvrvgPzU5
sD4m8woH1oIY4fhXG7xWXjmYqxyzFeyvKYpRyYxH8jIQc+6jm5yjPJ1tPMLslsT4fqgH+THAdktL
rqRTYZboErZIhvmPcQ==
--0000000000005aa96605f65c78ed--
