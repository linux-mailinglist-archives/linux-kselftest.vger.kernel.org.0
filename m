Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB66776F5D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjHCWqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjHCWpE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 18:45:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC030C2
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 15:45:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5229e0603edso1934a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691102701; x=1691707501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+6smnJ5pF8HUrKYLrYO8s3lDcgGNpNsYKDGlsiPBw0U=;
        b=m75TjT8R2WjgM2vazVNguss8LygmT5e8ZRaNoBZBBnyj8FDSjNEBP3ItJGsx83oSy0
         BnwLkOEbv+ydKQbItcBYaxe3/vmi7q71GZmj5TuCV1LIZ9y9Jc/TIYB1DnzjQ6z+LZyE
         oiCk4EeyvXBlchmXO8t3/zNXBFgLO2yes790nqbei0Ll8f8NkvG/mc9FbPKvNVxTth0d
         zdudXCn1R6Anu2h2yn76dKCtNoINsQy19ApHO6jD0MzJGgXR7S0sF1Z91P614je3eTf1
         +SRNYlGnTrbBj1aq7HOsCl+ndVEiHGStaNCklWf4sxXYTLYboiNoxrjaiuD4Qzl51cFE
         oSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691102701; x=1691707501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6smnJ5pF8HUrKYLrYO8s3lDcgGNpNsYKDGlsiPBw0U=;
        b=eiz1SB1ALiC0gQe8dW66LdfHZ1z1x5IO70rRD551ag7d8VsUUakpXvLipjHTSjpy+f
         Bg9F0DS13aKQrubekx4nIyE8U3Rc0tSQNRpf4MyOdTKIkHbUzr1GQG/YbK/tsgh1K+8A
         9ck6O+yirFyfolTpOSBya8zjqorQ7bmU95PNu/oQ0RZZb4I7alOkHMo/x+/P5cRQf2yj
         tM5jzlJATk9F5nHsGPmQAn9lgvgD4Jt1lJPPFt0zWsKZUI0XvclDLWxTdC/c9dp/UqH1
         Pw7Oio0hd/vVOFedO+gJATRQQPzwrO8qExkiSbHH8wua6uBy2CevHIGktvZgTe0jYFKN
         JcbQ==
X-Gm-Message-State: AOJu0Yz/xSLvxTkJ1o6Z2WwbsZp2OTL5GSbWHwxvYvGet/hFOkhnjS8r
        P+oiheggnyxE8U5GoD+MSp+P7KCbcRp/h7SBeSAiKg==
X-Google-Smtp-Source: AGHT+IFwt7FHYToqP4OA8hrQda2zpIiHH27fhxUzTMyYE2OUsvTzOiAF61m89sTN0bLIm/O2GG/BTWxyM0OhUCPBv4s=
X-Received: by 2002:a50:9e43:0:b0:519:7d2:e256 with SMTP id
 z61-20020a509e43000000b0051907d2e256mr22206ede.0.1691102700947; Thu, 03 Aug
 2023 15:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230801073700.3740895-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801073700.3740895-1-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Aug 2023 06:44:48 +0800
Message-ID: <CABVgOS=KKnn2-axsmtnoJvepLpMKFENjn_oe3nkCyK=Ng6TyMg@mail.gmail.com>
Subject: Re: [PATCH -next] kunit: fix possible memory leak in kunit_filter_suites()
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cad4af06020c8740"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000cad4af06020c8740
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Aug 2023 at 15:37, 'Ruan Jinjie' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Inject fault while probing drm_kunit_helpers.ko, if one of
> kunit_next_attr_filter(), kunit_filter_glob_tests() and
> kunit_filter_attr_tests() fails, parsed_filters,
> parsed_glob.suite_glob/test_glob alloced in
> kunit_parse_glob_filter() is leaked.
> And the filtered_suite->test_cases alloced in kunit_filter_glob_tests()
> or kunit_filter_attr_tests() may also be leaked.
>
> unreferenced object 0xff110001067e4800 (size 1024):
>   comm "kunit_try_catch", pid 96, jiffies 4294671796 (age 763.547s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000116e8eba>] __kmalloc_node_track_caller+0x4e/0x140
>     [<00000000e2f9cce9>] kmemdup+0x2c/0x60
>     [<000000002a36710b>] kunit_filter_suites+0x3e4/0xa50
>     [<0000000045779fb9>] filter_suites_test+0x1b7/0x440
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000105d79b00 (size 192):
>   comm "kunit_try_catch", pid 96, jiffies 4294671796 (age 763.547s)
>   hex dump (first 32 bytes):
>     f0 e1 5a 88 ff ff ff ff 60 59 bb 8a ff ff ff ff  ..Z.....`Y......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<000000006afe50bd>] kunit_filter_suites+0x424/0xa50
>     [<0000000045779fb9>] filter_suites_test+0x1b7/0x440
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff110001067e6000 (size 1024):
>   comm "kunit_try_catch", pid 98, jiffies 4294671798 (age 763.545s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000116e8eba>] __kmalloc_node_track_caller+0x4e/0x140
>     [<00000000e2f9cce9>] kmemdup+0x2c/0x60
>     [<000000002a36710b>] kunit_filter_suites+0x3e4/0xa50
>     [<00000000f452f130>] filter_suites_test_glob_test+0x1b7/0x660
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000103f3a800 (size 96):
>   comm "kunit_try_catch", pid 98, jiffies 4294671798 (age 763.545s)
>   hex dump (first 32 bytes):
>     f0 e1 5a 88 ff ff ff ff 40 39 bb 8a ff ff ff ff  ..Z.....@9......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<000000006afe50bd>] kunit_filter_suites+0x424/0xa50
>     [<00000000f452f130>] filter_suites_test_glob_test+0x1b7/0x660
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000101a72ac0 (size 16):
>   comm "kunit_try_catch", pid 104, jiffies 4294671814 (age 763.529s)
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 e0 2a a7 01 01 00 11 ff  .........*......
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c7b724e7>] kunit_filter_suites+0x108/0xa50
>     [<00000000bad5427d>] filter_attr_test+0x1e9/0x6a0
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000103caf880 (size 32):
>   comm "kunit_try_catch", pid 104, jiffies 4294671814 (age 763.547s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
>     [<00000000bad5427d>] filter_attr_test+0x1e9/0x6a0
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000101a72ae0 (size 16):
>   comm "kunit_try_catch", pid 106, jiffies 4294671823 (age 763.538s)
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 00 2b a7 01 01 00 11 ff  .........+......
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c7b724e7>] kunit_filter_suites+0x108/0xa50
>     [<0000000096255c51>] filter_attr_empty_test+0x1b0/0x310
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000103caf9c0 (size 32):
>   comm "kunit_try_catch", pid 106, jiffies 4294671823 (age 763.538s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
>     [<0000000096255c51>] filter_attr_empty_test+0x1b0/0x310
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000101a72b00 (size 16):
>   comm "kunit_try_catch", pid 108, jiffies 4294671832 (age 763.529s)
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
>     [<00000000881258cc>] filter_attr_skip_test+0x148/0x770
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
>
> Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filter suites")
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---

Looks good to me. Thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/executor.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 5b5bed1efb93..481901d245d0 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -151,7 +151,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                 for (j = 0; j < filter_count; j++)
>                         parsed_filters[j] = kunit_next_attr_filter(&filters, err);
>                 if (*err)
> -                       return filtered;
> +                       goto err;
>         }
>
>         for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
> @@ -163,7 +163,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                         parsed_glob.test_glob);
>                         if (IS_ERR(filtered_suite)) {
>                                 *err = PTR_ERR(filtered_suite);
> -                               return filtered;
> +                               goto err;
>                         }
>                 }
>                 if (filter_count) {
> @@ -172,15 +172,18 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                                 parsed_filters[k], filter_action, err);
>
>                                 /* Free previous copy of suite */
> -                               if (k > 0 || filter_glob)
> +                               if (k > 0 || filter_glob) {
> +                                       kfree(filtered_suite->test_cases);
>                                         kfree(filtered_suite);
> +                               }
> +
>                                 filtered_suite = new_filtered_suite;
>
>                                 if (*err)
> -                                       return filtered;
> +                                       goto err;
>                                 if (IS_ERR(filtered_suite)) {
>                                         *err = PTR_ERR(filtered_suite);
> -                                       return filtered;
> +                                       goto err;
>                                 }
>                                 if (!filtered_suite)
>                                         break;
> @@ -194,6 +197,10 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>         }
>         filtered.end = copy;
>
> +err:
> +       if (*err)
> +               kfree(copy);
> +
>         if (filter_glob) {
>                 kfree(parsed_glob.suite_glob);
>                 kfree(parsed_glob.test_glob);
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230801073700.3740895-1-ruanjinjie%40huawei.com.

--000000000000cad4af06020c8740
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCg
vR2LJansRUh66MFWkQwE8V+J5wz4aneTTZ8oG5oQhjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDMyMjQ1MDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjJ3DC592RqC09YNeAp6o
noXusmZAW/Kh2RuGHp8/+t/v1lLT3glr5p+2ifqbzsPQjFwxciLRiqyHVk5mCGD6DnZ9p+YUQjZg
h7NrTr2ATBnvWeuMgsHWlnTjOOHj9XxC6879V7WxdV36IBQBxnAMu9JC6rcFpOIm6GuhTLaho1ks
iGJ3DJDCQJwPiNdUxMglJmzPpvL8KhpFscLiMXqj5ZTq/ejqG8oBnTjlKKUipHfJf3LslHyJRreX
PIcsnYkhKiFeUsERPRMdH3YV6prhCgD8ex3+r3oPRi//52CkOoST7fPRTkybKfjHWderPGBwrhpa
7tUboxomn8dDTWFDjA==
--000000000000cad4af06020c8740--
