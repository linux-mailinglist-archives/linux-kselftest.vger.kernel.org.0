Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94D604AF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiJSPP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiJSPO6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 11:14:58 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A62408B
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 08:07:57 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id d8so32678uaw.11
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0OCLMXdljmb7tsitkYAddZXNEDhf+1O2z3U2UnTWMA=;
        b=QBVh0bFj5Y1XVrA2OvCE90Vg7qPGZc0U+I+ANIr0A7AhW7YzY3yLb+KEawkDNlBKOz
         A2ZFE0YHWFSKdnK+4ivvDQkkS/9yAwtdCtVhW70wk0s7kkFBeucimTbAmB1VMSlyczZH
         lqkVcvkFaOzniJqoBUcGIJZvjqUHWzunWdfEDZeBBb7kkwQkMDUbRectbc0/CnBdAaH8
         v9udSUt3hQJbUI8IuSKN+31GvnC+QtHIvun/10FvbOTiTWaA/af6HLrWddSmwhYSJhKS
         pRJuCEPmgU4Ax99+DuKIBjvTvxHcfbJhtdv1IUTZt5gQZ+38A7Ieyb3tAy+xaqbSyB5j
         fBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0OCLMXdljmb7tsitkYAddZXNEDhf+1O2z3U2UnTWMA=;
        b=DrF/kRmxANNNklI8WLBzhZoTVrQMeWSrNDTl2POP53dBMIh4wkXLEdjAhVPqI7+8ZS
         U/jVAqnPdpiAeu8BFkIsliyAdUJHIeZOWIa04BmkC+2OlVqHpdQ16RifFL5ulOFXH+rL
         wMa8JRG1NFuwV1ZpyQlnx52VdaSLVbmzqIPLwFF+jiJLNk9YXa0DpgUhAcDxRSb7/v6C
         mWFIVE+3dYKU6f3L4HnUX3aU5t+/PVoIVbVSbxIBARidw8Nh3aZIN+4jZpzYp+NCpEHf
         R72AKE/zaFawXPdffw2Qlv9Af3sYVCT7u0ceMC4kY+8A4jwOzE/UbQg7wFUxU5pqyWQf
         87QQ==
X-Gm-Message-State: ACrzQf2HhvgcQ89S5m2OK+8KYemckfLjaXnm865XjfMjYWzrkQLOVXsC
        wA5qni0W8qVvxBnrWxGKo7oCCLUXAzGeO55vYWxjWA==
X-Google-Smtp-Source: AMsMyM76OQe3S8cwnAvt4Cbdk32ddxVZeEtldri65X72U1svVcdayCy1VfgBBMiUs3nSs8jJKVF6gHmB38/HSAoXq2U=
X-Received: by 2002:ab0:7412:0:b0:3d1:c2f7:3250 with SMTP id
 r18-20020ab07412000000b003d1c2f73250mr4374614uap.21.1666191975065; Wed, 19
 Oct 2022 08:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221019085747.3810920-1-davidgow@google.com> <CA+fCnZdPwjThjY7fd7vBkMzS1eFXySR2AKrDK8weJ3p25fzS3g@mail.gmail.com>
In-Reply-To: <CA+fCnZdPwjThjY7fd7vBkMzS1eFXySR2AKrDK8weJ3p25fzS3g@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 23:06:03 +0800
Message-ID: <CABVgOSmP1A4d_-SNrWg7VruxpKj3SZz=Bzb2Xebd=EXw1imXyA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Enable KUnit integration whenever CONFIG_KUNIT is enabled
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d20dee05eb648ce8"
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

--000000000000d20dee05eb648ce8
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 19, 2022 at 10:18 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 10:58 AM 'David Gow' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Enable the KASAN/KUnit integration even when the KASAN tests are
> > disabled, as it's useful for testing other things under KASAN.
> > Essentially, this reverts commit 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT").
> >
> > To mitigate the performance impact slightly, add a likely() to the check
> > for a currently running test.
> >
> > There's more we can do for performance if/when it becomes more of a
> > problem, such as only enabling the "expect a KASAN failure" support wif
> > the KASAN tests are enabled, or putting the whole thing behind a "kunit
> > tests are running" static branch (which I do plan to do eventually).
> >
> > Fixes: 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT")
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Basically, hiding the KASAN/KUnit integration broke being able to just
> > pass --kconfig_add CONFIG_KASAN=y to kunit_tool to enable KASAN
> > integration. We didn't notice this, because usually
> > CONFIG_KUNIT_ALL_TESTS is enabled, which in turn enables
> > CONFIG_KASAN_KUNIT_TEST. However, using a separate .kunitconfig might
> > result in failures being missed.
> >
> > Take, for example:
> > ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y \
> >         --kunitconfig drivers/gpu/drm/tests
> >
> > This should run the drm tests with KASAN enabled, but even if there's a
> > KASAN failure (such as the one fixed by [1]), kunit_tool will report
> > success.
>
> Hi David,
>
> How does KUnit detect a KASAN failure for other tests than the KASAN
> ones? I thought this was only implemented for KASAN tests. At least, I
> don't see any code querying kunit_kasan_status outside of KASAN tests.

Yeah, there aren't any other tests which set up a "kasan_status"
resource to expect specific failures, but we still want the fallback
call to kunit_set_failure() so that any test which causes a KASAN
report will fail:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/kasan/report.c#n130

> I'm currently switching KASAN tests from using KUnit resources to
> console tracepoints [1], and those patches will be in conflict with
> yours.

Ah, sorry -- I'd seen these go past, and totally forgot about them! I
think all we really want to keep is the ability to fail tests if a
KASAN report occurs. The tricky bit is then disabling that for the
KASAN tests, so that they can have "expected" failures.

-- David

--000000000000d20dee05eb648ce8
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAx
P3UYKjpLkVFR1w2fhFjJSDECimirl3RIC4Ton/PbojAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMTkxNTA2MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAI7d5VhZPkeOj+nVmZAgt
JhYzppd/+bwOeuXrU6fmr/P5oL1rH74x+YLhqOQzbpEh4Y92oc9DXlAvWTTL0HnWMxyzIs/EM3l7
uNgtvzQAmxhBsIMKWBlkDxrBhfW+6b8OVsBiB9coM+SxLcebcErOHQCEuzT+OaenYHaWge6+xVOc
Jm+faszP0EU4UZinG0HKK3G7fC0FwzqGwfjT8J21qrnmuaE8jiSXv+H74zo5Qbnp8uZX7QX43PVM
wQsSn8eN+T6tqDD5bN0mJmQut/dt3gLqZJPMaoyz8ik5RCc9Sm9t4fbN0HSsPy8gbmLecKWCNxZR
sntQX9fgWKb/DV6avQ==
--000000000000d20dee05eb648ce8--
