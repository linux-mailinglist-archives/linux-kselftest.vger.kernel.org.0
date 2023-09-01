Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012278F7F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 07:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbjIAFSY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 01:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjIAFSY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 01:18:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83EE7E
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 22:18:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso15375e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 22:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693545500; x=1694150300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHfVVUBWXGH9NKNkO2QfNNqETFtY2+rFSyYsQwBA1ik=;
        b=QpZnsgNUeE1a6wNOiZD1nxVxJpjZdCU8vJuKA/fdyz+yTwH6QLa1eopUZ0IDnka4aW
         9DhFQCxuiFMIkEfHjHlgcFO8+AfLLZbdw4uQ3rX5FcPgUsp/J0mabzaXXtvaqW1bkouo
         k2MjwzCgL0PCAOuEDctTFDXaZ77gzj0LeT+WeM07F7v+5yXTUAo7O8ztg4nuhMqXRnf6
         A9nresZGTbhmIpuo3CVy9TgN0R6Nv8OZsP1Ga7N8SCI30eivmXpwn3eOJb2iolMs/2sh
         pKHGIrEMCSWEyOiTqfxx175ny1PXOCIdJvQtqwqUiWFDoK/Oiofo1XJM6Vo7kKgCcmTk
         +iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693545500; x=1694150300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHfVVUBWXGH9NKNkO2QfNNqETFtY2+rFSyYsQwBA1ik=;
        b=F6G9z7bpSyxQQdWyD7NWWyBeTa3cpjJAp06flOEJEux10Y4vzD5KEjDx6h/Vyb7vgW
         8xQLEWAYgbetZ/iZAlUq1dBsIRSV49Mfmt8HFL7a8kODBzXQescBMT+jIj8Owww2Aw2p
         hE5C05D0tjdD28MAnLFRBL/RHxRMiWicoqRxgddG99Cim2Vdjln4S9JZhrlJ8klthU7d
         7VM/777L9D5Ih739qZYCWXEbG1/HJS7TYAocSKX1PXyfplpHZXTEYI8xfElBkumI/fh6
         worWTvQNpCn/FpGuvuYL3UfuIscKI31IQCs7pnZXJ78HkzPtOyesuHKhj5DHg06SbDrf
         iYaA==
X-Gm-Message-State: AOJu0Yza2HWZli5rS01wo6YVoWBGUlkDmZIPhPzJ5G2C9UkAwK3NIJfv
        CP3LxwYal9ZbrU3QBlAtWmfKlOoGTtt5EJDohEMPYg==
X-Google-Smtp-Source: AGHT+IF5GKpXfyVsrjpA4RouF8T6ABiOKk25dsj7ldFy/WWFHrI35LS7qJbWG/x8ojLLWeeUcTpe1lIpxupZcFghbWs=
X-Received: by 2002:a05:600c:3ba9:b0:3fe:eb42:7ec with SMTP id
 n41-20020a05600c3ba900b003feeb4207ecmr62453wms.1.1693545499805; Thu, 31 Aug
 2023 22:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071655.2907683-1-ruanjinjie@huawei.com> <20230831071655.2907683-4-ruanjinjie@huawei.com>
In-Reply-To: <20230831071655.2907683-4-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Sep 2023 13:18:08 +0800
Message-ID: <CABVgOS=NyNaoHAm+qBY7oDqxdjr=4N-aZj=0y+dCWwOSyOb9og@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Fix possible memory leak in kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        jk@codeconstruct.com.au, dlatypov@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f3531906044549e7"
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

--000000000000f3531906044549e7
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Aug 2023 at 15:17, 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> If both filter_glob and filters are not NULL, and kunit_parse_glob_filter()
> succeed, but kcalloc parsed_filters fails, the suite_glob and test_glob of
> parsed kzalloc in kunit_parse_glob_filter() will be leaked.
>
> Fixes: 1c9fd080dffe ("kunit: fix uninitialized variables bug in attributes filtering")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---

As Rae points out, I don't think this is correct. If filter_count is
non-zero, but parsed_filters is NULL due to an allocation failure,
we'll still end up trying to kfree() a NULL pointer.

That's why this didn't goto err; before: we explicitly _don't_ want to
free parsed_filters here. We could set filter_count = 0 before goto
err, but I think either wrapping the kfree() call in if
(parsed_filters), or

Indeed, this may be the case for most of the cleanup here: we're
checking if we intended to allocate something (e.g., the filter_count
is nonzero, the filter_glob is set), rather than whether we
successfully allocated something, so can kfree(NULL) on failure. The
issues with ordering (that you fix in the next patch) could help if we
had several labels to jump to after each allocation, or just checking
that what we're freeing was non-NULL (and initialising them to NULL if
needed).

Thanks,
-- David


>  lib/kunit/executor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 25ce8d6e5fe7..7654c09c1ab1 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -176,10 +176,8 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>         if (filters) {
>                 filter_count = kunit_get_filter_count(filters);
>                 parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
> -               if (!parsed_filters) {
> -                       kfree(copy);
> -                       return filtered;
> -               }
> +               if (!parsed_filters)
> +                       goto err;
>                 for (j = 0; j < filter_count; j++)
>                         parsed_filters[j] = kunit_next_attr_filter(&filters, err);
>                 if (*err)
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230831071655.2907683-4-ruanjinjie%40huawei.com.

--000000000000f3531906044549e7
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBM
fg4MYrJqcrQjxsEpGDda7ztcQKWcK/It8oRUcMHe4DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDEwNTE4MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALdQ4CrbS6Ky+DAYVMAcE
ZHnPmc+lNuqF1qSDGhUs+eRJSurA/Jdv58IXmWGDCGyooQ6IkubsvY/XNYM75Cay8AO58CbwnaN9
8wqmSF3KgKZPylpJt/7CB3vgmGS7SCuBzQNcjQL2R/O0wY+9huFW9ll1gb0cKx7raJGJzOWvh+bL
GG6beRDiM5JT/W6JiDrQf/6yfdmpIuFac1nt/BP7YIwpbp1p2PtGXhnP98O//niwq+FRa9Qe2A+O
gLG2lKBtb0fn4CfZJuaiFP9x41wOCgJyqtMuYLCW64OeI4gSFisV11Adr9loBnm0lki5/ezyKYDn
O1aJSyUl+ar7t2qOdw==
--000000000000f3531906044549e7--
