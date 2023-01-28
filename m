Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9F67F5D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jan 2023 08:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjA1H5g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Jan 2023 02:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjA1H5f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Jan 2023 02:57:35 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A9B402CC
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 23:57:34 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 187so7538366vsv.10
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 23:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGQQuRQc/dTfORygglHNKbj/63uwgfeJN1UmtUBEN3Y=;
        b=rOq9NQTaFDG6F6749dTpbMMLMt9N86/Z6r89UhYBdjdetBW6Sx/SvNM5W8ypFrKyrH
         QmWI2T7O4wbQPRXEUdOBC+w9s6NPdovcdRXo2XCEjsL0jMXijcrGS3kLygK0JugvbBjn
         qUB1dnZEf4EO0CIB0JQfmsGukM08q4wVTGCXGazTolcekQf7nTWNpaYP81YMx1C5UkTx
         zg9bz3zJzpSnSVjRG8HvQnQ2RYzf2hT1SanvXzHZ9PpHTWExeXNCFs/PqaRg6D0yMHJ6
         jnHhBh1L4y7x5w98wdf6VJb2vJd4OnQWY+D+FKaMK8cSSW7jdO5WahHgRhVmSNXOpFCs
         GBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGQQuRQc/dTfORygglHNKbj/63uwgfeJN1UmtUBEN3Y=;
        b=PKWSGL7e7jLaM6oeYKUaKUUIGGle2t++P2GTYp3fTU9qLbvS+jkM4v2FDz9+OJnyp3
         Nzz4rRCQ3EAlHElr5ro1CSO0FMPccNuFGCWC7G9I2embW3q4Qg7m1pE45lQ+8kQ8QnKr
         56GPahGJ2lZEfvyotvfzGemsb7d9+NOyAoiwx5g0zW/liTFQSZZaDpCY6oXgdxo0auER
         QYYKJQgTpLRNQAL3wNhyOLbw63Fs6bixyX7UmwVmRnjyZwq6Ej+LAgK9CEQRt4fBFvrQ
         qMksHGl5E6NRDJWMPg4TKABZzYwMRE7StA5VWL9tN1WkviuWstqD3OusyKoNQYrKKYer
         vsVQ==
X-Gm-Message-State: AO0yUKW3xJeNChDo2UPTg6kw1XNZLI8/KEQotMqrtqewYaEYrP55kxe7
        5+f+lhxXMfzgs4QhkzclUY91AS20emkcCVfN8v9MqQ==
X-Google-Smtp-Source: AK7set+iAC1O7VcJefkNLU+iAkowg6dLtYAv0wDfDSmWSjN0LAOMdOFF2U0W2cto4q6oFAOPlRj70oqd4400Vl3gCsU=
X-Received: by 2002:a67:2686:0:b0:3eb:b8d8:6b3e with SMTP id
 m128-20020a672686000000b003ebb8d86b3emr1003951vsm.22.1674892653209; Fri, 27
 Jan 2023 23:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20230127203950.781709-1-rmoar@google.com>
In-Reply-To: <20230127203950.781709-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 28 Jan 2023 15:57:21 +0800
Message-ID: <CABVgOS=c5JhPT+GZ-f43ff5cGS3oR=NnL9K8vuk8nDv_jngHvA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix bug in KUNIT_EXPECT_MEMEQ
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a7ba4105f34e55ff"
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

--000000000000a7ba4105f34e55ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Jan 2023 at 04:40, Rae Moar <rmoar@google.com> wrote:
>
> In KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ, add check if one of the
> inputs is NULL and fail if this is the case.
>
> Currently, the kernel crashes if one of the inputs is NULL. Instead,
> fail the test and add an appropriate error message.
>
> Fixes: b8a926bea8b1 ("kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPEC=
T_MEMNEQ macros")
>
> This was found by the kernel test robot:
> https://lore.kernel.org/all/202212191448.D6EDPdOh-lkp@intel.com/
>
> Reported-by: kernel test robot <lkp@intel.com>
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> - Fix formatting of backslashes
> - Add Fixes: ... statement to commit message
>

Looks good to me, now.

Thanks.
=E2=80=94 David

>  include/kunit/test.h |  5 +++--
>  lib/kunit/assert.c   | 40 +++++++++++++++++++++++++---------------
>  2 files changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87ea90576b50..a20bff149bdf 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -683,8 +683,9 @@ do {                                                 =
                              \
>                 .right_text =3D #right,                                  =
        \
>         };                                                               =
      \
>                                                                          =
      \
> -       if (likely(memcmp(__left, __right, __size) op 0))                =
      \
> -               break;                                                   =
      \
> +       if (likely(__left && __right))                                   =
      \
> +               if (likely(memcmp(__left, __right, __size) op 0))        =
      \
> +                       break;                                           =
      \
>                                                                          =
      \
>         _KUNIT_FAILED(test,                                              =
      \
>                       assert_type,                                       =
      \
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index f5b50babe38d..05a09652f5a1 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -241,24 +241,34 @@ void kunit_mem_assert_format(const struct kunit_ass=
ert *assert,
>         mem_assert =3D container_of(assert, struct kunit_mem_assert,
>                                   assert);
>
> -       string_stream_add(stream,
> -                         KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n"=
,
> -                         mem_assert->text->left_text,
> -                         mem_assert->text->operation,
> -                         mem_assert->text->right_text);
> +       if (!mem_assert->left_value) {
> +               string_stream_add(stream,
> +                                 KUNIT_SUBTEST_INDENT "Expected %s is no=
t null, but is\n",
> +                                 mem_assert->text->left_text);
> +       } else if (!mem_assert->right_value) {
> +               string_stream_add(stream,
> +                                 KUNIT_SUBTEST_INDENT "Expected %s is no=
t null, but is\n",
> +                                 mem_assert->text->right_text);
> +       } else {
> +               string_stream_add(stream,
> +                               KUNIT_SUBTEST_INDENT "Expected %s %s %s, =
but\n",
> +                               mem_assert->text->left_text,
> +                               mem_assert->text->operation,
> +                               mem_assert->text->right_text);
>
> -       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=3D\n",
> -                         mem_assert->text->left_text);
> -       kunit_assert_hexdump(stream, mem_assert->left_value,
> -                            mem_assert->right_value, mem_assert->size);
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D\n",
> +                               mem_assert->text->left_text);
> +               kunit_assert_hexdump(stream, mem_assert->left_value,
> +                                       mem_assert->right_value, mem_asse=
rt->size);
>
> -       string_stream_add(stream, "\n");
> +               string_stream_add(stream, "\n");
>
> -       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=3D\n",
> -                         mem_assert->text->right_text);
> -       kunit_assert_hexdump(stream, mem_assert->right_value,
> -                            mem_assert->left_value, mem_assert->size);
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D\n",
> +                               mem_assert->text->right_text);
> +               kunit_assert_hexdump(stream, mem_assert->right_value,
> +                                       mem_assert->left_value, mem_asser=
t->size);
>
> -       kunit_assert_print_msg(message, stream);
> +               kunit_assert_print_msg(message, stream);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
>
> base-commit: 5835ffc27381c2d32c3f0d7b575cb3397555ab47
> --
> 2.39.1.456.gfc5497dd1b-goog
>

--000000000000a7ba4105f34e55ff
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCw
CQVba67xjdrZzx8PR4MfUh+HMEWmTxKj4or546+7xjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMjgwNzU3MzNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAWPh9W9DvXoyMAay9sHlC
IJAkjWcPxP8SyYZe2lKWxyAjKZU3+w1eDxysZpQlC3GvpJlkRfb7AMdPOODK6mj+1KbAvdNt27sl
WsTHZxfll8kL2RO1v0FSNqQ2xps1M9OMRWrKjDmAvLLw/3qzs7sw7+1mrWsg/Imxi1SsywGsfRYO
XQ7CdEG3uYEqvl0/sf7ujNDLJhWh5yucZcjGi704Hd7h60N/yAHym/jHpiXIuNOmLEyRD2S7xjYu
82lXoXpScujmzLwItD39FI/stqAIGrXe+FHKuixBVVyCmQDzSgdTRLDbtIAxPJsjw9Y/AdRuD8B5
5P01WItm24b7K0lDbQ==
--000000000000a7ba4105f34e55ff--
