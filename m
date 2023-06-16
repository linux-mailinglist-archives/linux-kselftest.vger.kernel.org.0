Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A09732656
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 06:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjFPEve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 00:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFPEvd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 00:51:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB32D5E
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 21:51:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so63815e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686891089; x=1689483089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z56boQSsNwOBqLSY9wFGdNBHgu9yQ7dwEWW7p2DORcU=;
        b=CDDp1pDSxj0LkHfYQiczu7uOPESvyCX8ED+qtso/R8hnBRQsGPjCdd5LKVADCcuxVk
         4LJZ+134cEQ3ki1Pqz453dVuZ+IzZp36g/dR+Cl/DdCs0+afheVTTth+esOD6GkWwLr7
         I9knD2Ae6rIl9LnsnnV/Sm3k+eNDjF3erVxYxf63OqOls+W2g4qtxCK48X30JmlE3Mz9
         AoNdlYBM0BpO+qwLBfOWJ1wgw4eebkAcQ6tXCWO4mmZyp4x7a5CmcNNcAprx5eFb9feu
         T1fP1iUgmY3ZOT9xFsYXZnY+LD7/GOteZcjvx7DDsCwImgOewjLdrzSafclWMIzutXsL
         higw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686891089; x=1689483089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z56boQSsNwOBqLSY9wFGdNBHgu9yQ7dwEWW7p2DORcU=;
        b=gaS9sG4E1kIzH2GIFIw2bRHpDhZBSNPRAC1oZRagSGRItISgkKkRXhCqoJZHZoDWGP
         uQ6lNjXTc4a77hlRQ/9WYniHI6d9VhMmc2Pb3K75RDP+VTCBSpLrOYnWC6EYDcE1P9sT
         ZILNQyRA/N3ys5vJ0KxgYfV3QIjzDwJlUCvOVxw3HDM7mRfVESz1G8Tx1yaxbtinOc4y
         XoIRavxuTt5Uk5oUhWvIMcs+oMFjQMwL/oepY8s/0ewTdlmpic5pclAc87cc5vk3KNrQ
         E4R75rLzHd3tOwU5SY/ynqIzdl6wbECtF6JbrbJeSx6UMtWYACPES2JAadeCJl+u7uQc
         o4ZA==
X-Gm-Message-State: AC+VfDyydRH2f+pYEGNfVf0RycA9LzjVaGcwn20Igxb6xffy2dO9b5oF
        QWdeDoTAkX+mvcGf3XdEH6EnkKJ0AstUZcYsfLaipw==
X-Google-Smtp-Source: ACHHUZ7FR3MPBinMMBNYI1cpnVFLVNY1HWK/H3/0/hgiIgUYEYCAqFHD2AIQ7yOQiQsq3WJSFAR3iKQKYM9g/iLtAog=
X-Received: by 2002:a05:600c:4e52:b0:3f7:e4d8:2569 with SMTP id
 e18-20020a05600c4e5200b003f7e4d82569mr328353wmq.5.1686891089101; Thu, 15 Jun
 2023 21:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-1-ojeda@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Jun 2023 12:51:15 +0800
Message-ID: <CABVgOSnprvxzi-z42KFjOZsiRUv7u7E2poVGJNmTfS2OU4x4AA@mail.gmail.com>
Subject: Re: [PATCH 0/6] KUnit integration for Rust doctests
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002aa5ba05fe37f094"
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

--0000000000002aa5ba05fe37f094
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jun 2023 at 02:09, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> This is the initial KUnit integration for running Rust documentation
> tests within the kernel.
>
> Thank you to the KUnit team for all the input and feedback on this
> over the months, as well as the Intel LKP 0-Day team!
>
> This may be merged through either the KUnit or the Rust trees. If
> the KUnit team wants to merge it, then that would be great.
>
> Please see the message in the main commit for the details.
>
>

Thanks very much for putting this together! I've been looking forward
to it, and it works well here.

I've been running it on linux-next to get both the pending KUnit and
Rust changes, and it works well apart from needing to fix a couple of
conflicts from
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=260755184cbdb267a046e7ffd397c1d2ba09bb5e

In particular, the tests run with:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_RUST=y
--make_options LLVM=1 'rust_doctests_kernel'

And also under QEMU / x86_64 with:
./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add
CONFIG_RUST=y --make_options LLVM=1 'rust_doctests_kernel'

(And I'm looking forward to trying out the other architecture support
patches with it, too)

The doctests also run nicely as part of the default test suite when
CONFIG_RUST=y. At some point, we might want to add a Rust-specific
.kunitconfig to make it easier to just run Rust-related test suites,
but it's not a big deal for just these.

I assume we'll take this in via the kselftest/kunit tree for 6.6, but
if you'd rather take them via the Rust tree, that's fine too.

Cheers,
-- David

> Miguel Ojeda (6):
>   rust: init: make doctests compilable/testable
>   rust: str: make doctests compilable/testable
>   rust: sync: make doctests compilable/testable
>   rust: types: make doctests compilable/testable
>   rust: support running Rust documentation tests as KUnit ones
>   MAINTAINERS: add Rust KUnit files to the KUnit entry
>
>  MAINTAINERS                       |   2 +
>  lib/Kconfig.debug                 |  13 +++
>  rust/.gitignore                   |   2 +
>  rust/Makefile                     |  29 ++++++
>  rust/bindings/bindings_helper.h   |   1 +
>  rust/helpers.c                    |   7 ++
>  rust/kernel/init.rs               |  25 +++--
>  rust/kernel/kunit.rs              | 156 ++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                |   2 +
>  rust/kernel/str.rs                |   4 +-
>  rust/kernel/sync/arc.rs           |   9 +-
>  rust/kernel/sync/lock/mutex.rs    |   1 +
>  rust/kernel/sync/lock/spinlock.rs |   1 +
>  rust/kernel/types.rs              |   6 +-
>  scripts/.gitignore                |   2 +
>  scripts/Makefile                  |   4 +
>  scripts/rustdoc_test_builder.rs   |  73 ++++++++++++++
>  scripts/rustdoc_test_gen.rs       | 162 ++++++++++++++++++++++++++++++
>  18 files changed, 484 insertions(+), 15 deletions(-)
>  create mode 100644 rust/kernel/kunit.rs
>  create mode 100644 scripts/rustdoc_test_builder.rs
>  create mode 100644 scripts/rustdoc_test_gen.rs
>
>
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
> --
> 2.41.0
>

--0000000000002aa5ba05fe37f094
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBh
brAPq8qwowPYpxbubQesKqsKSMPOB3lxN08UqPGxxDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTYwNDUxMjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAc9R1iFjzspMO7nbxCAhO
3MFy0KH6RDo6pHQHqT7ZF/OK5QxG/ws+Qs0pQmWKaAJUHjsLM+mqNS8SqKZbzASP27S7f7j6KOk4
dkuhRqoOs6i8xNT6VdBCiUXT4bzUsU8l7RWUdq1Rn2N9C8UAfdOqBBrlAlUOCmyR5656B+cayImE
lcB5WW3JE7c+vbDOOBHUd0mrZHHtYjsNUf5Ebr04h6EICAU8XCZp/WmjOM45Gx420XEaGigoOnZg
t8S0GWd7T4Wqn41v9YzqNI+v6DMpjTi+ezpX2zo79Vd7AT9/luC69khIkyLTOrE3JH4p980uG4kI
mEXTmwrD15dTnw0CqA==
--0000000000002aa5ba05fe37f094--
