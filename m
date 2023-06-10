Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80072AA41
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjFJI3U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFJI3U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 04:29:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C702134
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso16335e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686385756; x=1688977756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XT0F3EapytPO8OWbfyahQcQluVhTi+UoHkkRnSVkupM=;
        b=1uljp6NkWnw5d6nLAWiBpMkRao3/qZQtBwEf58NoEyXBxppv/EMKMfVnfsHEzl7bBl
         7PyrgY1TaGjfv9hAnSGqptw9BG8Os35ud6sTHn48IkVO14e/oyVZoUIZfxFt+I71GpZ9
         0WIKom2dPAKoQfXuj5yCmVnJ66zAM2sMzXyWDJI3acp3DRqSAHRPbvu1bpipE04lUmlu
         lS6Ugj/pduj//2osYsNUw+KSJdJvPy+1GVPeqbaUoTiop0z9ZSlcXUNEuZ9Rgka0JKO0
         WmtHyCJIzLRx8l/QKhsBGIj2MKTgCShxBvo0FHaEdc8E/whHkVCvO22elcVud4xBwOrr
         ZDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686385756; x=1688977756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XT0F3EapytPO8OWbfyahQcQluVhTi+UoHkkRnSVkupM=;
        b=ixFFnwvBaQIHkX8lv4BgVSRqJ5PhyVkylUarJZKyWlzxVTUgjWhAxGCcfFt0dHODPr
         RbLNy20oNU9eFn79/msy5x0Zsz66FS2uJuNuc8UxgKa6Rl6jmkS3ntme6MdP/Fj+IQd1
         5pnpHAlmRdTvyH56mFs7QqbWvqkfjg6mVvc2IS1jLLDquaNwXLIdX17AK812lIsqBAe9
         W/KmNcpR6ylFmEFMm+XfU3ybQHV80SsT3XLdMqmV9cB5WAUhDF4lcX7iI57jQNLPF0Ov
         Z0Uyhf5TRn3Ta8hfLqOWPrDv3Nm92N6jCjWvyn/NWCwPh/cUdFHkPyzQ1aU7DPX3Hr3F
         9yMQ==
X-Gm-Message-State: AC+VfDxqO9PvXrvxhTRlM0wTValLYQ5CtpyzPyzS1Vf9fcF1mlC+VT22
        V4NpunqDj0QuIsHc+lGiKIeXrFZOjwdMvncEPKJTyA==
X-Google-Smtp-Source: ACHHUZ61Krth5dwEP3jMbulnS/O/xKnuAhK/3DsvjjVvCVnmzavCCZIiP85C2OM1DoMtChnNkqNYUw7oapQnSpLUBdA=
X-Received: by 2002:a05:600c:45c8:b0:3f7:3654:8d3 with SMTP id
 s8-20020a05600c45c800b003f7365408d3mr77190wmo.2.1686385756267; Sat, 10 Jun
 2023 01:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 10 Jun 2023 16:29:03 +0800
Message-ID: <CABVgOS=By=bpUELmNBMv39Swx+-Ec_XHo-=3yUfmcpOPU7N=8A@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: Add test attributes API
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fb805d05fdc247c4"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000fb805d05fdc247c4
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
>
> Hello everyone,
>
> This is an RFC patch series to propose the addition of a test attributes
> framework to KUnit.
>
> There has been interest in filtering out "slow" KUnit tests. Most notably,
> a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude
> particularly slow memcpy tests
> (https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).

Awesome: this is a long overdue feature.

> This proposed attributes framework would be used to save and access test
> associated data, including whether a test is slow. These attributes would
> be reportable (via KTAP and command line output) and some will be
> filterable.

Why wouldn't they all be filterable? I guess I can imagine some where
filtering wouldn't be useful, but I can't think of a technical reason
why the filter shouldn't work.

Also, as I understand it, I think this could also work with data which
is not "saved" in this kunit_attributes struct you define. So we could
have attributes which are generated automatically from other
information about the test.
 I could definitely see value in being able to filter on things like
"is_parameterised" or "runs_at_init" or similar.

Finally, it'd be really great if these attributes could apply to
individual parameters in parameterised tests, in which case we could
have and filter on the parameter value. That seems like it could be
incredibly useful.

>
> This framework is designed to allow for the addition of other attributes in
> the future. These attributes could include whether the test is flaky,
> associated test files, etc.

A small part of me is hesitant to add this much framework code for
only one attribute, so it'd be nice to look into at least having an
RFC for some of these. Hopefully we don't actually have flaky tests,
but "is_deterministic" would be nice (alongside a future ability to
inject a random seed, or similar). Other properties like
"is_threadsafe", "is_reentrant", etc could be useful for future
features. And I'm sure there could be some more subsystem-specific
things which would be useful to filter on, too.

Some of these could probably replace the need for custom code to make
the test skip itself if dependencies aren't met, too, which would be
fun.

I'm not sure "associated test files" quite gels perfectly with this
system as-is (assuming I understand what that refers to). If it's the
ability to "attach" extra data (logs, etc) to the KTAP output, that's
possibly best injected at runtime, or added by the separate parser,
rather than hardcoded in the kernel.

>
> Note that this could intersect with the discussions on how to format
> test-associated data in KTAP v2 that I am also involved in
> (https://lore.kernel.org/all/20230420205734.1288498-1-rmoar@google.com/).
>
I definitely need to re-read and respond to that. I'm not 100%
thrilled with the output format here, and I think the goal with KTAP
"test associated data" is, as you say, related, but not identical to
this. There'd definitely be data which doesn't make sense as a KUnit
attribute which we might want to add to the output (e.g., data only
calcuated while the test runs), and attributes which we might not want
to always print out with the results.

> If the overall idea seems good, I'll make sure to add tests/documentation,
> and more patches marking existing tests as slow to the patch series.
>

I think the series is good overall. If no-one else objects, let's move
forward with it.
I'd definitely prefer to see a few more tests and some documentation.
Having another attribute would be great, too, though I can certainly
live with that being a separate series.


> Thanks!
> Rae
>
> Rae Moar (6):
>   kunit: Add test attributes API structure
>   kunit: Add speed attribute
>   kunit: Add ability to filter attributes
>   kunit: tool: Add command line interface to filter and report
>     attributes
>   kunit: memcpy: Mark tests as slow using test attributes
>   kunit: time: Mark test as slow using test attributes
>
>  include/kunit/attributes.h             |  41 ++++
>  include/kunit/test.h                   |  62 ++++++
>  kernel/time/time_test.c                |   2 +-
>  lib/kunit/Makefile                     |   3 +-
>  lib/kunit/attributes.c                 | 280 +++++++++++++++++++++++++
>  lib/kunit/executor.c                   |  89 ++++++--
>  lib/kunit/executor_test.c              |   8 +-
>  lib/kunit/kunit-example-test.c         |   9 +
>  lib/kunit/test.c                       |  17 +-
>  lib/memcpy_kunit.c                     |   8 +-
>  tools/testing/kunit/kunit.py           |  34 ++-
>  tools/testing/kunit/kunit_kernel.py    |   6 +-
>  tools/testing/kunit/kunit_tool_test.py |  41 ++--
>  13 files changed, 536 insertions(+), 64 deletions(-)
>  create mode 100644 include/kunit/attributes.h
>  create mode 100644 lib/kunit/attributes.c
>
>
> base-commit: fefdb43943c1a0d87e1b43ae4d03e5f9a1d058f4
> --
> 2.41.0.162.gfafddb0af9-goog
>

--000000000000fb805d05fdc247c4
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD/
5V7mOVQBtw2t91HW33C3dkHqAdMg5JI3guMDq4iGXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTAwODI5MTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlRTL1Ytl9KzrIqKSQpiQ
34iMq4NHPDuo/OygRdRayFRFoQ1Q+b4gEFGw/SDSm719j3SE4qTBn7ZU/2mNedXet5aAso0Z7S7E
k2VDopBtWj1RjqoCQFIorXUrblkMccLVRAOAXVQY2Utepaa2xSAmwvjG5Nec3nrAVfGHcDI4yuam
9sFYU0TggJNJ0W/lEGsiz4Ili8xMnKUwiSpN5l7YzstOlW/uXqKag3Z6YQYJF7YAtgjLrpg8FG7+
5j87MdLrxj1mWM1BdWZvTVi59aChy2wxjDDzWYYekIXYQZtqE3IRxWrHsi6hK/9XQsvKahBeJKV2
Ii+Hel8vTLY4acm9JQ==
--000000000000fb805d05fdc247c4--
