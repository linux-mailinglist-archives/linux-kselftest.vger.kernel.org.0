Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6695E7925CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbjIEQHq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353680AbjIEHNC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 03:13:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37885CC2
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 00:12:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52c96d5df86so16237a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 00:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693897973; x=1694502773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kkiu/4cdTx1FHq+ZuEIoI2XAIjTNPzAcyEHuEDrhni4=;
        b=niAK6HPXakfelykze69q28bRz78D1B2jbQ5JNcoFq4Ptv2TkqLn06wedqWl6BiU/Lc
         YGbrbWl8MtgyGiquPFZMQEILzgBc9RotJa0kI6qpHTuBZ3ntfzSQiijj1tml5RGZuiDv
         yKax98SOZD6GK85xw2C+t7jTKeKrwpBawMoqFmKj0lhvCgSAkw+eh0L/uJK8DNWYqN/p
         w0APPpxcpCG8T3sqZTCfXwuhWajUJCUhxtxfnQDK4yuJbBNrj6qr67+JXnY5pBK13XTL
         12U2ppWh+p4SbdPXMfxsRZz79Rp1KoaRMFEq9YEeFUJ0fw20MtVn4gDTtnhBf9yGc5Tc
         dMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897973; x=1694502773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkiu/4cdTx1FHq+ZuEIoI2XAIjTNPzAcyEHuEDrhni4=;
        b=aIP8JRyvVC0Pc8cYLLE1JCII8+G1AtjC/X4kn8r3aYTTBo8cVrSzzdki0zC7Tn1XX4
         IPSP8T4Nwx1oWdHFd+hkCSvAdri4k8gcOqpWt74Yl1CjFqiW1NJIpUo0PKKgEJZKgpNG
         DMzqCulHh9Fkrr+pu1pYaPmOV0i7JUNLzJhQsRsB0xX2LUzELXBQmbxWsozKhmwrMY31
         VNsD0AkjXpKutcjDqQUqaggyW7202NF5rn3ZmffQAiVGgjAdExLrN+1hSMzWPdbWCFSW
         btHYY5cfbQlSYDG4qnhzVzXETVpgN8MgF8Fycu10wU9sE8D1kAhgHlNe/Ti4/zTXmK4i
         MwDA==
X-Gm-Message-State: AOJu0YxBTUCKAYA1kWT2E263ekYE3JmZKg0QSRT/3idjMUH1KRwNPhM0
        a9/79Rg0VYtNgfwrgwGOSYQdxcTPRbaKUxR8HuU8K8pDcX+LkFgcNHKPKQ==
X-Google-Smtp-Source: AGHT+IFujouFJUZb/bn1CunL9t8D1TWLwKiYfe4/5CoRo6o5j7Lo8DF2FmilrB8+1M08LmDsfF/DR6OwuElESqkRYE0=
X-Received: by 2002:a50:9ee4:0:b0:523:d5bc:8424 with SMTP id
 a91-20020a509ee4000000b00523d5bc8424mr210650edf.5.1693897973549; Tue, 05 Sep
 2023 00:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230903071028.1518913-1-ruanjinjie@huawei.com> <20230903071028.1518913-3-ruanjinjie@huawei.com>
In-Reply-To: <20230903071028.1518913-3-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Sep 2023 15:12:42 +0800
Message-ID: <CABVgOSkWVmX485X1w09oMgY6Y=f1ecwQ2nqAtLrPDzBPQAh-7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: Fix the wrong err path and add goto labels
 in kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        jk@codeconstruct.com.au, dlatypov@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000068c1a0604975b04"
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

--000000000000068c1a0604975b04
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Sept 2023 at 15:11, 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Take the last kfree(parsed_filters) and add it to be the first. Take
> the first kfree(copy) and add it to be the last. The Best practice is to
> return these errors reversely.
>
> And as David suggested, add several labels which target only the things
> which actually have been allocated so far.
>
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_suites()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Suggested-by: David Gow <davidgow@google.com>
> ---
> v2:
> - Add err path labels.
> - Update the commit message and title.
> ---

This looks good to me. The kernel test robot does complain about
unused labels, so it might make sense to wait to introduce the labels
in the later patches (or merge patches 2,3,4 together), but personally
I'm okay with it as-is, as these should be merged in one go.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  lib/kunit/executor.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 5181aa2e760b..0eda42b0c9bb 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -166,7 +166,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                 for (j = 0; j < filter_count; j++)
>                         parsed_filters[j] = kunit_next_attr_filter(&filters, err);
>                 if (*err)
> -                       goto err;
> +                       goto free_parsed_filters;
>         }
>
>         for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
> @@ -178,7 +178,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                                         parsed_glob.test_glob);
>                         if (IS_ERR(filtered_suite)) {
>                                 *err = PTR_ERR(filtered_suite);
> -                               goto err;
> +                               goto free_parsed_filters;
>                         }
>                 }
>                 if (filter_count > 0 && parsed_filters != NULL) {
> @@ -195,10 +195,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                                 filtered_suite = new_filtered_suite;
>
>                                 if (*err)
> -                                       goto err;
> +                                       goto free_parsed_filters;
> +
>                                 if (IS_ERR(filtered_suite)) {
>                                         *err = PTR_ERR(filtered_suite);
> -                                       goto err;
> +                                       goto free_parsed_filters;
>                                 }
>                                 if (!filtered_suite)
>                                         break;
> @@ -213,17 +214,19 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>         filtered.start = copy_start;
>         filtered.end = copy;
>
> -err:
> -       if (*err)
> -               kfree(copy);
> +free_parsed_filters:
> +       if (filter_count)
> +               kfree(parsed_filters);
>
> +free_parsed_glob:
>         if (filter_glob) {
>                 kfree(parsed_glob.suite_glob);
>                 kfree(parsed_glob.test_glob);
>         }
>
> -       if (filter_count)
> -               kfree(parsed_filters);
> +free_copy:
> +       if (*err)
> +               kfree(copy);
>
>         return filtered;
>  }
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230903071028.1518913-3-ruanjinjie%40huawei.com.

--000000000000068c1a0604975b04
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBC
OuqX09Wmh5qJKulddcjVIih3a/qi7nfjNgpfJOmDKDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDUwNzEyNTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbRYFtgExbhcP7IfmDqPs
zVM5Fd0Pfn0STz9XYtrKckG9h46yomgM+xfLfZku79JAjFl/L2H7XKRyagOMVNIbwqJLb5wLLz13
4XK1YymFZuN2iueISu+5ODYMjysE3oWMFI2RyPj5sxuRWcK3gSgm5E2f6RYcRpEdQhGaAweGn1n/
rcG4OHcDrNvvb2KJIVNgg7Gkmh7u6vBqFbyo2n4Ow4+PRm2MH8qQTEqUhXYeHrBNAQ+e2Yks8y28
7gReNOzth9x1N4rxU2Jm6zYiDgTPRykWIOZXXMakjJFWDGppFYU9ZqTlAZ01FMFqWpwrKWtjFuWk
6rKsl4eFWkp+BGhpkQ==
--000000000000068c1a0604975b04--
