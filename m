Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA9759150
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGSJNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGSJNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:13:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D9A4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:13:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so22605a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689758030; x=1690362830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+qdDSRHvj9mPp0igku0NCTtWyb0KxGqxe7sUWNwZWI=;
        b=m257DcKQ9cEWdukNn1kmnfSlBUTUwcf73oKvW9T6mJxVY97Exeb0mC++zBN3KJyhKS
         MLl+wi0ODrpKzqwOBE5kuw2la6+2rVftKvv7tUj7DX/DLRFaG11o3QgUsMKMw375F9Gu
         QwjyB8DNAwKXWnIDyAuC6uhkQUWQhiqD95sZUyTOH+inLmIDHp/AOjbI9RHHcjy0Z5h0
         88xJV5zcAxw8IkJzOUuiuMxRrNYHEWS0pjXOEHQatScmCdAcmjP+LHFeB42Tor+Mwrp4
         hLcBFxyvKOqpORvjj51NBVIrI5X4gC+pOgyHvgGw0H+4ZEdA0ikQM5hc1vWTUQhJLp6M
         JprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758030; x=1690362830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+qdDSRHvj9mPp0igku0NCTtWyb0KxGqxe7sUWNwZWI=;
        b=bsxVgi7SB7UKV/eGbF9UBvPXc4chN9AoAGtW8aTAMvBv3EIAxnemokvi0mTDqBnxD+
         3uHMwAe6fBQ/xTwRedKtLVXC7flT85JPY2RMdGQ781P+o737i7f8fVIVtEhq+ayS/igA
         irnmPa0TQf1pzQKzx9u4+A/uSr9Z8ysQx3rC+kM8yZm8zcbPAmZqTpdXozoYA02s351b
         +E3UpW0Ji1DhmMrJioN13I6kXnyNtqHc6sMEcksCnSs7k5Km/3KsUbAwcbjmCAkwMAYk
         ZI+mKNTYkc9DRqX7cCWwpP0u9tHv1O29uXjehaamjW8so50wZPVUbDAX+ZzOZLHBVe+F
         Qj9w==
X-Gm-Message-State: ABy/qLbkaf4N5hQ+Jl7KwaM3+kgzOmq1vo6SvTAKHizqAyqNpn7mGZJc
        4UNTLhQn53g5qkn9jv4gWNk5YXIxYF37eQ7mAlguLQ==
X-Google-Smtp-Source: APBJJlG88xsR/5uyJpHjV11JlBE8kPjPYsOAnlNwoDUatB8cu5lLfxTspsrgDzO1/Ty8BfW5YjodsljdZ+oq3bEfA1A=
X-Received: by 2002:a50:a6c6:0:b0:514:92e4:ab9f with SMTP id
 f6-20020a50a6c6000000b0051492e4ab9fmr211619edc.7.1689758030393; Wed, 19 Jul
 2023 02:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 17:13:38 +0800
Message-ID: <CABVgOSnwQ5a+G99b5QcZjS2pZk7TivQSJJ6it3ie33igvjGcAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drivers: base: Add tests showing devm handling inconsistencies
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002ec5d00600d373a6"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000002ec5d00600d373a6
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jun 2023 at 17:50, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> This follows the discussion here:
> https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/
>
> This shows a couple of inconsistencies with regard to how device-managed
> resources are cleaned up. Basically, devm resources will only be cleaned up
> if the device is attached to a bus and bound to a driver. Failing any of
> these cases, a call to device_unregister will not end up in the devm
> resources being released.
>
> We had to work around it in DRM to provide helpers to create a device for
> kunit tests, but the current discussion around creating similar, generic,
> helpers for kunit resumed interest in fixing this.
>
> This can be tested using the command:
> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/
>
> I added the fix David suggested back in that discussion which does fix
> the tests. The SoB is missing, since David didn't provide it back then.
>
> Let me know what you think,
> Maxime
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Whoops, sorry. This managed to hide in my inbox. I think it looks
good, and am happy for you to add by SoB to the patch.

I've sent out reviews to the others with some small nitpicky things.

Thanks a bunch,
-- David

> Changes in v2:
> - Use an init function
> - Document the tests
> - Add a fix for the bugs
> - Link to v1: https://lore.kernel.org/r/20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech
>
> ---
> David Gow (1):
>       drivers: base: Free devm resources when unregistering a device
>
> Maxime Ripard (2):
>       drivers: base: Add basic devm tests for root devices
>       drivers: base: Add basic devm tests for platform devices
>
>  drivers/base/core.c                      |  11 ++
>  drivers/base/test/.kunitconfig           |   2 +
>  drivers/base/test/Kconfig                |   4 +
>  drivers/base/test/Makefile               |   3 +
>  drivers/base/test/platform-device-test.c | 220 +++++++++++++++++++++++++++++++
>  drivers/base/test/root-device-test.c     | 108 +++++++++++++++
>  6 files changed, 348 insertions(+)
> ---
> base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
> change-id: 20230329-kunit-devm-inconsistencies-test-5e5a7d01e60d
>
> Best regards,
> --
> Maxime Ripard <mripard@kernel.org>
>

--0000000000002ec5d00600d373a6
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB6
nhSW228fPx1SV7AqHm6VTOMvSsyge31E8HuB8VpTczAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwOTEzNTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAE9weZSc/AvLQ/osrUlVR
E/kyaqqw8BmRLP/+0M1+wPJ9cyBx71lJEzIaIuMOJ7WMfD/rufb5X1Bh+ST/jGH3EIWWVFuPqaHx
2m+gYqyHWPhW6m0OOWM/CKum6A2YA09ysvXGs3BwKWUtlOYkfHcBMPa9l9Q2z76g5paUb3VIw1ox
gmozdg6W98xRCB4vWGAy3mW7+3s3cdg7WzDZrcFhONLjdjIz2FcuJBdP+El42cE+wKmvwuqeWBLS
bC6RkmIWxD5LuAe8mE55j9PaRsGIv0Tnyi1dnrj/iLP2q9xs7rFfPWS4fr+XCUQdiKQ7rcNMOA/w
9uMy42J45wuLWnUnXQ==
--0000000000002ec5d00600d373a6--
