Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D3674D68
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 07:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjATGgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 01:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjATGgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 01:36:12 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB67857B
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jan 2023 22:36:04 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id j185so4655540vsc.13
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jan 2023 22:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qy5QpkDgKcjRmFyzlbMv6YwYo7DTNQxGKeHuIVIPSu8=;
        b=NeDqDQdcv2k6m/cdNqbIYMncK6cS4acU5m9UCI6gyMwh/GrhUCHSoHIpnAaXek+9GL
         k0/SffdqdkIYMXAFcn1yClJuTAssIehJ/aEHhkNOdW2kvGe2EvUOTssk+6lonuJeg/kl
         gjeDtTu07DPLfWXr3LXe3QKh5+0itA/+Jb3Ui25nJSlKzrOJ9QX8QqUvdBHsjSJxXRIw
         Z84cSJV0W6+NwQTU1fHgJ+78zzpzfyKhwACb/LDRro+HEr1tNnrX39aM8HUJ9Y4LgtzF
         70UvD5fXQfqB7GSpV+gcYoeCzgJfq1VRBqFHWB8v2oJvUoQb6GCTei/rI/C4HTS81xeX
         xIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy5QpkDgKcjRmFyzlbMv6YwYo7DTNQxGKeHuIVIPSu8=;
        b=G3zrJRJjKqGElsggDuTM7RWz9CY6Me8bETK2viGUvN1v+snzJleFv+SrP13VRV7kNd
         Hj3URly+Kw6tHClpEyRDvYldaahaONHjmcty1UgKehcsBEYWlLAlBerzqoFvA1zGwhaT
         mVJi3bSLB6+Fzxbw5SZ8U/1Cat49E8omF2wdKulybMSkMUplfTDlJEshWuk70r8q62zj
         0UAg0A4z7/IUD4b/9YvEB4N/jX8r+xBix4FJhWsuXmLHgVZcZRYJxYsUhHCHe2+HGe+K
         PP9eH6lYJvWZUbm3m73VXbhRiEeDnk0CtN0kXXhA1gBjNfH0+RMlMs6q7+nYQouPuzPf
         +r7g==
X-Gm-Message-State: AFqh2kqw5/4B1tui2AyYGEq43qG9L9vrRiCEN3Ni+ljVLwFiOFBwb63R
        regJgrzPXNSH/ixbtyyAAu0omXKVJipCJHAvuNkzNg==
X-Google-Smtp-Source: AMrXdXvjSeaQUrsDI/wO8qCs8/GgwXFzMxE0oFHyVynypIpjETKCEgLlZZot1a6rPy5p9zsFNN++VkiPNSsKCmq2id4=
X-Received: by 2002:a05:6102:316f:b0:3d2:30a3:70d1 with SMTP id
 l15-20020a056102316f00b003d230a370d1mr1947808vsm.38.1674196563825; Thu, 19
 Jan 2023 22:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20230118074219.3921-1-apantykhin@gmail.com>
In-Reply-To: <20230118074219.3921-1-apantykhin@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 20 Jan 2023 14:35:51 +0800
Message-ID: <CABVgOSn9ULgwDNTz3V=n+OM088jS7NsJ1mrfcQv-mYVy6zNbVg@mail.gmail.com>
Subject: Re: [PATCH V2] tools/testing/kunit/kunit.py: remove redundant double check
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007ca05005f2ac4398"
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

--0000000000007ca05005f2ac4398
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jan 2023 at 15:42, Alexander Pantyukhin <apantykhin@gmail.com> wrote:
>
> The build_tests function contained double checking for not success
> result. It is fixed in the current patch. Additional small
> simplifications of code like using ternary if were applied (avoid using
> the same operation by calculation times differ in two places).
>
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> ---

Looks good, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 43fbe96318fe..0e3e08cc0204 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -77,11 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
>         config_start = time.time()
>         success = linux.build_reconfig(request.build_dir, request.make_options)
>         config_end = time.time()
> -       if not success:
> -               return KunitResult(KunitStatus.CONFIG_FAILURE,
> -                                  config_end - config_start)
> -       return KunitResult(KunitStatus.SUCCESS,
> -                          config_end - config_start)
> +       status = KunitStatus.SUCCESS if success else KunitStatus.CONFIG_FAILURE
> +       return KunitResult(status, config_end - config_start)
>
>  def build_tests(linux: kunit_kernel.LinuxSourceTree,
>                 request: KunitBuildRequest) -> KunitResult:
> @@ -92,14 +89,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>                                      request.build_dir,
>                                      request.make_options)
>         build_end = time.time()
> -       if not success:
> -               return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  build_end - build_start)
> -       if not success:
> -               return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  build_end - build_start)
> -       return KunitResult(KunitStatus.SUCCESS,
> -                          build_end - build_start)
> +       status = KunitStatus.SUCCESS if success else KunitStatus.BUILD_FAILURE
> +       return KunitResult(status, build_end - build_start)
>
>  def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
>                            request: KunitBuildRequest) -> KunitResult:
> @@ -145,7 +136,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                 tests = _list_tests(linux, request)
>                 if request.run_isolated == 'test':
>                         filter_globs = tests
> -               if request.run_isolated == 'suite':
> +               elif request.run_isolated == 'suite':
>                         filter_globs = _suites_from_test_list(tests)
>                         # Apply the test-part of the user's glob, if present.
>                         if '.' in request.filter_glob:
> --
> 2.25.1
>

--0000000000007ca05005f2ac4398
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBc
Hee2zGQkbKY++RPOkOwGHwW2Zo6Gzl9RuGezlAHKVjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMjAwNjM2MDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAg30BpaJZJKfObeSMb/5W
C2xKu7zwz+66LYk/e0mXJVXBEXpwJEcby751gFFNv5bkYlq4UvhdMncAh9l8vThQfY3+Wv02IVNL
8L2UOVgzoJ0NkcV+vT+8zequQJ2k/sGlUo6kk3yJNx8avJa0njvXr4RNdNm4RgUg5gzs6+WuKtz1
MhipZeHdGTpl5QMOcT7uYfrSwFnn92RBL12dHYd8Ni64A+VlwLQFr0ohTeLT9PRUk0chJ97g2qpA
sP5K1to6u7TJNW/K1wgi5IvTSvUhMtfVmsERkNNtevy6Zn+3q+4QE5hmomdtS6xS2DZmaO5zjI7E
fhpa8/GbYRR7PRC1LQ==
--0000000000007ca05005f2ac4398--
