Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99A17576C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGRIit (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjGRIir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 04:38:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD38E4C
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 01:38:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e55517de3so6693a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689669522; x=1692261522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CXjo17g/HrSepma2bzToty6GDvDOHso8NcPZymz7duQ=;
        b=u2K8P9czN+rE6s/qLYIsneQzBQ5iBUspAjSRBavaZodeVInshTCrARTC28GRgq9ntj
         cE7g1dhRbKXKYNL1WMGmqP8sGPnijqEP7qYInmIpZonk2Uj947X6VyVWDt5nofu9ZVVF
         ADhfQcC1vitxRK/oQ9YqLRkBjUZ6qMyELGkNcKuHjDsHvNE+YsNpgcXohsJNsgU1ugkM
         hcydX8cz1dwVW6D8tisS3Kgc2TCfXneLh/87pyLxz2BGK36lByjLepUoAd5bOMBQs3+j
         mIqxsMBW6XoqJ4NjJS5N4APfijSIdRE/2AeDJnpIruJ9sfnmBwo+6GPJwrbyaB8BVhiS
         NffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669522; x=1692261522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXjo17g/HrSepma2bzToty6GDvDOHso8NcPZymz7duQ=;
        b=jphQOBb02UDc4/I0bGOmf3GRp5ZPgwRYqMMy0oA3z17EbCliaep1WxwIvIeLr2MHUR
         fSN98OfkXRxzKRvsScfOjwV6+QvQ9CYsJZZMw1mWKwN848XYayLc5NFe/RDUNMpJrwXE
         CbDVkNqBDCTNsGqAM16FtUAE0XtKEhYFqWzuueF2OnZLfUTjVq+2kPbjqrb4tb7yjQYe
         v6aWTYamUN1Y8XspniDaQrwL8FO3Z6/pF+humRKpVHaluAKWkBMLmfm4RDrMzAQpdZPp
         Ak07nC0cXB4qgsTkVly/nu6R+7+CwHUNi5DoO8qMQCeWcA4NYvQCzSX5qkbb1G2XCIHl
         CBGw==
X-Gm-Message-State: ABy/qLa+N+oGRdka863zZzyrE6uV01QssAoagkJDZo8+Sa6ht+Bo8BfD
        A7Dlz5pZGgxmlc1NiziCJSd8MIbySGVF/XdRo4RJUg==
X-Google-Smtp-Source: APBJJlELxqy4p6FfNJYs0goPKVXBJfIsLgM+mD9tNuIBZTJs/qI2calR4cQTqLiotqBf9FqHEHRFKqoKNgY1LQvUBpA=
X-Received: by 2002:a50:8e02:0:b0:51e:5773:891d with SMTP id
 2-20020a508e02000000b0051e5773891dmr83977edw.4.1689669521576; Tue, 18 Jul
 2023 01:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230718052752.1045248-1-ojeda@kernel.org>
In-Reply-To: <20230718052752.1045248-1-ojeda@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 16:38:28 +0800
Message-ID: <CABVgOSk+YOdmpnBpLcx2sC3NN7amdpLf-C35EpvYmzq3SWHAqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KUnit integration for Rust doctests
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a58d230600bed793"
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

--000000000000a58d230600bed793
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jul 2023 at 13:28, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> v1: https://lore.kernel.org/rust-for-linux/20230614180837.630180-1-ojeda@kernel.org/
> v2:
>
>   - Rebased on top of v6.5-rc1, which requires a change from
>     `kunit_do_failed_assertion` to `__kunit_do_failed_assertion` (since
>     the former became a macro) and the addition of a call to
>     `__kunit_abort` (since previously the call was done by the old
>     function which we cannot use anymore since it is a macro). (David)
>
>   - Added prerequisite patch to KUnit header to include `stddef.h` to
>     support the `KUNIT=y` case. (Reported by Boqun)
>
>   - Added comment on the purpose of `trait FromErrno`. (Martin asked
>     about it)
>
>   - Simplify code to use `std::fs::write` instead of `write!`, which
>     improves code size too. (Suggested by Alice)
>
>   - Fix copy-paste type in docs from "error" to "info" and, to make it
>     proper English, copy the `printk` docs style, i.e. from "info"
>     to "info-level message" -- and same for the "error" one. (Miguel)
>
>   - Swap `FILE` and `LINE` `static`s to keep the same order as done
>     elsewhere. (Miguel)
>
>   - Rename config option from `RUST_KERNEL_KUNIT_TEST` to
>     `RUST_KERNEL_DOCTESTS` (and update its title), so that we can use
>     the former for the "normal" (i.e. non-doctests, e.g. `#[test]` ones)
>     tests in the future. (David)
>
>   - Follow the syntax proposed for declaring test metadata in the KTAP
>     v2 spec, which may also get used for the KUnit test attributes API.
>
>     Thus, instead of "# Doctest from line {line}", use
>     "# {test_name}.location: {file}.{line}", which ideally will allow to
>     migrate to a KUnit attribute later.
>
>     This is done in all cases, i.e. when the tests succeeds, because
>     it may be useful for users running KUnit manually, or when passing
>     `--raw_output` to `kunit.py`. (David)
>
>     David: I used "location" instead of your suggested "line" alone, in
>     order to have both in a single line, which looked nice and closer to
>     the "ASSERTION FAILURE" case/line, since now we do have the original
>     file (please see below).

I like "location" better, personally. The attributes work is still
ongoing, and while there's some benefit to having "file" and "line"
separate (it could potentially simplify some implementation on the C
side), we'll cross that bridge when we come to it.

>
>   - Figure out the original line. This is done by deploying an anchor
>     so that the difference in lines between the beginning of the test
>     and the assert, in the generated file, can be computed. Then, we
>     offset the line number of the original test, which is given by
>     `rustdoc`. (developed by Boqun)
>
>   - Figure out the original file. This is done by walking the
>     filesystem, checking directory prefixes to reduce the amount of
>     combinations to check, and it is only done once per file (rather
>     than per test).
>
>     Ambiguities are detected and reported. It does limit the filenames
>     (module names) we can use, but it is unlikely we will hit it soon
>     and this should be temporary anyway until `rustdoc` provides us
>     with the real path. (Miguel)
>
>     Tested with both in-tree and `O=` builds, but I would appreciate
>     extra testing on this one, including via the `kunit.py` script.
>

This seems to be working well on the existing cases under kunit.py
here. I'll continue to play with it, but no worries on my end thus
far.

>   - The three last items combined means that we now see this output even
>     for successful cases:
>
>         # rust_doctest_kernel_sync_locked_by_rs_0.location: rust/kernel/sync/locked_by.rs:28
>         ok 53 rust_doctest_kernel_sync_locked_by_rs_0
>
>     Which basically gives the user all the information they need to go
>     back to the source code of the doctest, while keeping them fairly
>     stable for bisection, and while avoiding to require users to write
>     test names manually. (David + Boqun + Miguel)
>
>     David: from what I saw in v2 of the RFC for the test attributes API,
>     the syntax still contains the test name when it is not a suite, so
>     I followed that, but if you prefer to omit it, please feel free to
>     do so (for me either way it is fine, and if this is the expected
>     attribute syntax, I guess it is worth to follow it to make migration
>     easier later on):
>
>         # location: rust/kernel/sync/locked_by.rs:28
>         ok 53 rust_doctest_kernel_sync_locked_by_rs_0

Thanks: while we're still arguing a bit about exactly what the format
of these will look like in the KUnit/KTAP attributes spec/patches,
what you've used matches what we've been proposing so far.

Let's stick with <test name>.location for now, and change it if needed
when the attributes spec is finalised.

>
>   - Collected `Reviewed-by`s and `Tested-by`s, except for the main
>     commit due to the substantial changes.
>
> Miguel Ojeda (7):
>   kunit: test-bug.h: include `stddef.h` for `NULL`
>   rust: init: make doctests compilable/testable
>   rust: str: make doctests compilable/testable
>   rust: sync: make doctests compilable/testable
>   rust: types: make doctests compilable/testable
>   rust: support running Rust documentation tests as KUnit ones
>   MAINTAINERS: add Rust KUnit files to the KUnit entry

These are all (still) looking pretty good to me. If there are no
objections, I'd like to take these into kselftest/kunit as-is and if
we need to change anything (e.g. for consistency with attributes when
they land), do that as a follow-up.

Thanks again, Miguel, for all the work getting this going!

Cheers,
-- David

>
>  MAINTAINERS                       |   2 +
>  include/kunit/test-bug.h          |   2 +
>  lib/Kconfig.debug                 |  13 ++
>  rust/.gitignore                   |   2 +
>  rust/Makefile                     |  29 ++++
>  rust/bindings/bindings_helper.h   |   1 +
>  rust/helpers.c                    |   7 +
>  rust/kernel/init.rs               |  26 +--
>  rust/kernel/kunit.rs              | 163 +++++++++++++++++++
>  rust/kernel/lib.rs                |   2 +
>  rust/kernel/str.rs                |   4 +-
>  rust/kernel/sync/arc.rs           |   9 +-
>  rust/kernel/sync/lock/mutex.rs    |   1 +
>  rust/kernel/sync/lock/spinlock.rs |   1 +
>  rust/kernel/types.rs              |   6 +-
>  scripts/.gitignore                |   2 +
>  scripts/Makefile                  |   4 +
>  scripts/rustdoc_test_builder.rs   |  72 +++++++++
>  scripts/rustdoc_test_gen.rs       | 260 ++++++++++++++++++++++++++++++
>  19 files changed, 591 insertions(+), 15 deletions(-)
>  create mode 100644 rust/kernel/kunit.rs
>  create mode 100644 scripts/rustdoc_test_builder.rs
>  create mode 100644 scripts/rustdoc_test_gen.rs
>
>
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230718052752.1045248-1-ojeda%40kernel.org.

--000000000000a58d230600bed793
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAEDPnEOWzT2vYIrJhGq
c1swDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA1MTIx
NjMzMjlaFw0yMzExMDgxNjMzMjlaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfIQuFV9ECjSKrnHc+/gEoEHeMu29G
hkC9x5KA7Tgm7ZISSdxxP+b9Q23vqKKYcaXlXzxDUweAEa7KrhRdZMpcF1p14/qI6AG7rBn8otbO
t6QSE9nwXQRL5ITEHtPRcQzLU5H9Yyq4b9MmEZAq+ByKX1t6FrXw461kqV8I/oCueKmD0p6mU/4k
xzQWik4ZqST0MXkJiZenSKDDN+U1qGgHKC3HAzsIlWpNh/WsWcD4RRcEtwfW1h9DwRfGFp78OFQg
65qXbeub4G7ELSIdjGygCzVG+g1jo6we5uqPep3iRCzn92KROEVxP5lG9FlwQ2YWMt+dNiGrJdKy
Kw4TK7CrAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFG/UTu3x
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBU
/Kej+GuGGXDnTLvxu6bkGrQf8lVKtiJd9KuXLwDAojAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwODM4NDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAK/pldqEKqu8x4YvHaPWf
pmFHWBrsSBSFPqIrPEseiJRLRO2DYZ846i6fQEgUGwNU1sAqWrsJUWE0hjw/lfop+FdbPP+vJpz3
26fL1LIBgmnvabn6nGjNBKuumKibXnEt0Eedv3zbpSG4SZBbG9x7Oygt6tqqDgvVWAmTVyyqhGfm
Ft2CYjqiLoN0uvW36OpQ7wcRbOM5UxTk/iSXS20JKauA61+4RdopgYcoE49W4QgoRdBSXtCgvWE8
9lbFZuc170vwqzCQaufhEgk8u97w6UBaHoywpKKy5/wuz2e5yAWa8uNNLj0SAjyCfciA8jsYyGnL
U43CEIyKWZi80TZTlA==
--000000000000a58d230600bed793--
