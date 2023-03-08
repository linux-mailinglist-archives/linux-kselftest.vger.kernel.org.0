Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F326AFE17
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 06:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCHFFe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 00:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCHFFc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 00:05:32 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FCBA5903
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 21:05:19 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d7so14416092vsj.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 21:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678251918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EKHQJjiGetoDgFpAMKQbB6RWvGBS4zXsJp+ht5MoDc=;
        b=E3jhblX6Qs5kwy7PciL0b0DUYkpqiSxhtQZrUmYopWfP7zrzbBjWxQt5JxNjoQgkPy
         Skau9rdQCGgP9lVgJHA/5fb2OXf7h+9mrzCq8A1qFsT08r4xFw14kD9S2uIsYwd1LCDl
         K+6N1nO++KMBY5rsRqz7ewVR4MKBcWBIkPuZ7fTFNl4RAqLuDQ6fXgoRciLtEmfzHqrA
         2y9nCP1hGMYZcZfmPu3S/s5Rc9GROcU/Oa7ovFaMg2lomT3DMSV6AiF5ZaroQp7VOpmw
         qWxelBvNtGIDnnHL/TvD+inyQSg40aRMiUEgxx6IuSpxLb/35imSKp68ZmJ8dyui+27n
         3FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678251918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EKHQJjiGetoDgFpAMKQbB6RWvGBS4zXsJp+ht5MoDc=;
        b=VyNkuj0gxv2XtQzi0z8tsstMa7vrbgDr7tYJHOYmcar486eNOrIV0xgB90MVoy/XMU
         IBNQQYYwfRsCPp/Q4Omna/CS9WVrglcg/GuFZQrg1KGW6VK9xdhq9P4GIw61tTagcrcA
         xDoYBDK/FJDLV5MQ9gDkJGYthWeqz9bI/volpaMkJDQSnt6yWZxmQjEhynARB+tQ8JGi
         s372VL/YUUI3MWv8bMabuGiazDbRq4ILKtKvjX196KgiuKLRGi5CWPfjaidmnGZQiS7F
         OMXLs007lyg5S/IZfpk2tjjZRhFtalirfeqv1gwlM3JMsMOmc6bV66nuFxs3yXw0VCku
         CRpw==
X-Gm-Message-State: AO0yUKW67a+Ce3zpZLyQpPOB3vdJH1fnr5I0ogbUILHtGCPghn5UlKa9
        nWmsQx2UHGiok1e5tR/4AYtdeZ4AgDRUyoJaCJ0rPQ==
X-Google-Smtp-Source: AK7set+m9UfoInekb41pOvyMngyCYf6YcpXBmSWH7rkYaQvJPk7PT3SRG6A8k6Eq7fE+yTCynyUVeInebRRDWqyWFF4=
X-Received: by 2002:a67:ff1a:0:b0:422:1687:f239 with SMTP id
 v26-20020a67ff1a000000b004221687f239mr636084vsp.2.1678251917952; Tue, 07 Mar
 2023 21:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20230307223937.2892762-1-rmoar@google.com> <20230307223937.2892762-3-rmoar@google.com>
In-Reply-To: <20230307223937.2892762-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 8 Mar 2023 13:05:06 +0800
Message-ID: <CABVgOS=BxtQR=7JVX2SQ9jyySHDH9QTKw9PHC5VQWWWZVbtFTw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kunit: fix bug of extra newline characters in
 debugfs logs
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006fcd6405f65c790c"
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

--0000000000006fcd6405f65c790c
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Mar 2023 at 06:39, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug of the extra newline characters in debugfs logs. When a
> line is added to debugfs with a newline character at the end,
> an extra line appears in the debugfs log.
>
> This is due to a discrepancy between how the lines are printed and how they
> are added to the logs. Remove this discrepancy by checking if a newline
> character is present before adding a newline character. This should closely
> match the printk behavior.
>
> Add kunit_log_newline_test to provide test coverage for this issue.  (Also,
> move kunit_log_test above suite definition to remove the unnecessary
> declaration prior to the suite definition)
>
> As an example, say we add these two lines to the log:
>
> kunit_log(..., "KTAP version 1\n");
> kunit_log(..., "1..1");
>
> The debugfs log before this fix:
>
>  KTAP version 1
>
>  1..1
>
> The debugfs log after this fix:
>
>  KTAP version 1
>  1..1
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks, this is looking good to me! One very minor formatting issue
below, otherwise:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>
> Changes from v2 -> v3:
> - Changes to commit message.
>
> Changes from v1 -> v2:
> - Changed the way extra newlines are removed. Instead of removing extra
>   newline characters, add a newline if one is not present. This is a bit
>   cleaner.
> - Note: I looked into using KERN_CONT to match the printk behavior
>   to vsnprintf but this could cause issues with KTAP printing on the same
>   line as interrupting kernel messages. I also looked at just adding
>   KERN_CONT functionality to kunit_log and I did get this to work but it
>   was a bit messy because it required a few calls to kunit_log_newline in
>   kunit_run_tests. If this is very desired functionality, happy to add this
>   to version 3.
>
>  include/kunit/test.h   |  2 +-
>  lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++------------
>  lib/kunit/test.c       | 18 ++++++++++++++++++
>  3 files changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 0668d29f3453..bd9dbae5e48d 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -420,7 +420,7 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>  #define kunit_log(lvl, test_or_suite, fmt, ...)                                \
>         do {                                                            \
>                 printk(lvl fmt, ##__VA_ARGS__);                         \
> -               kunit_log_append((test_or_suite)->log,  fmt "\n",       \
> +               kunit_log_append((test_or_suite)->log,  fmt,    \

Nit: the trailing '\' here is misaligned.


>                                  ##__VA_ARGS__);                        \
>         } while (0)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 4df0335d0d06..b63595d3e241 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite = {
>         .test_cases = kunit_resource_test_cases,
>  };
>
> -static void kunit_log_test(struct kunit *test);
> -
> -static struct kunit_case kunit_log_test_cases[] = {
> -       KUNIT_CASE(kunit_log_test),
> -       {}
> -};
> -
> -static struct kunit_suite kunit_log_test_suite = {
> -       .name = "kunit-log-test",
> -       .test_cases = kunit_log_test_cases,
> -};
> -
>  static void kunit_log_test(struct kunit *test)
>  {
>         struct kunit_suite suite;
> @@ -481,6 +469,29 @@ static void kunit_log_test(struct kunit *test)
>  #endif
>  }
>
> +static void kunit_log_newline_test(struct kunit *test)
> +{
> +       kunit_info(test, "Add newline\n");
> +       if (test->log) {
> +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
> +                       "Missing log line, full log:\n%s", test->log);
> +               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
> +       } else {
> +               kunit_skip(test, "only useful when debugfs is enabled");
> +       }
> +}
> +
> +static struct kunit_case kunit_log_test_cases[] = {
> +       KUNIT_CASE(kunit_log_test),
> +       KUNIT_CASE(kunit_log_newline_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_log_test_suite = {
> +       .name = "kunit-log-test",
> +       .test_cases = kunit_log_test_cases,
> +};
> +
>  static void kunit_status_set_failure_test(struct kunit *test)
>  {
>         struct kunit fake;
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 811fcc376d2f..e2910b261112 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -108,6 +108,22 @@ static void kunit_print_test_stats(struct kunit *test,
>                   stats.total);
>  }
>
> +/**
> + * kunit_log_newline() - Add newline to the end of log if one is not
> + * already present.
> + * @log: The log to add the newline to.
> + */
> +static void kunit_log_newline(char *log)
> +{
> +       int log_len, len_left;
> +
> +       log_len = strlen(log);
> +       len_left = KUNIT_LOG_SIZE - log_len - 1;
> +
> +       if (log_len > 0 && log[log_len - 1] != '\n')
> +               strncat(log, "\n", len_left);
> +}
> +
>  /*
>   * Append formatted message to log, size of which is limited to
>   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> @@ -135,6 +151,8 @@ void kunit_log_append(char *log, const char *fmt, ...)
>         vsnprintf(log + log_len, min(len, len_left), fmt, args);
>         va_end(args);
>
> +       /* Add newline to end of log if not already present. */
> +       kunit_log_newline(log);
>  }
>  EXPORT_SYMBOL_GPL(kunit_log_append);
>
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>

--0000000000006fcd6405f65c790c
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB9
8GHI+crU+L2HiVgwWBEAaceFpmUSR1P253PH+rAonzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDgwNTA1MThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl50SjT5IjFOTpt6Wpq30
nnqV0SEQ40RqKLaZ4b/brhdPf+7ksADWYhMEAXYOMB8pSKLFrsFtE6UE1wFuSBM+USSPx4ea58Q3
Oq9IQ9ZFJA588WYHb9R+pB8xOWz1thqV6rJuGPSTBKNOUxmVOBIbvFlAavaQsAMx+fYKnwacoYj5
6SJKOYOmb7ZZh7EiHPYLyiZms6PS32Jgnxb6UQjira/eupikA3yiT4z/4DPyxCn6Isq5t7hNK6ig
l3773sFlhNdnANT4l5PcFOlHOrWFKpwz1hN3lNJJWihiYyYnZMMrKRDeeB+tRsIKYTBQzRZtU7q0
0QKrzksZjqwzDLahzQ==
--0000000000006fcd6405f65c790c--
