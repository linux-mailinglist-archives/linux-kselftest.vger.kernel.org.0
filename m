Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844E457B1F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 09:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiGTHm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiGTHmZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 03:42:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D54C608
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 00:42:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so12041799wrc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgwZs2dBOTcd13gSB9FHKKLgRMSu5BBmlcktNyWkEj0=;
        b=Djx2UzN0/14x9DNQyzgpDOQtCs3sXzBi04KJ5tBJgss0x63jVEIe8jeY3ZER+owQZw
         Wvtlv5BKvFne2AlzSOV/SdM07J4SZh3C4C52/feV73+4anZGXeToQkkBnp9Rw6fwGezt
         aTrOpbcpy7iuAnj9nRMwnw3F/f/WdOIzOIBJEUlF6QDwzDPixFHYOwyfHUC0zGFzDhVY
         TR0uzesmt1brBqjuCjqm2YpXiK+vcLsqzCc0Df1C78ntuDYLhW9a3FDeGXh9bCz3sU/4
         +06A9T+FDYvsjMTrLwCRTcU2EGHNdanOPDDxWUl2o/r32Ym/J/6Ni6qgNJP/r0OFdILb
         fkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgwZs2dBOTcd13gSB9FHKKLgRMSu5BBmlcktNyWkEj0=;
        b=h7n+lP+kFAsQFLJ4e+NSDeSAbhOMemyp5xxWLcGf5pLixiSK4rEy0tPHN1c18F8AD4
         Y9UQU8UzeMUysdegYnFqR7EqIYSjx2vF9qz/4kAv34UHx2AQE1yMgVGFZwN1SUR9csp/
         BXL5lm3Ca+NdHZ7h2q4MsqmqigoEMr6eq9CZlrkjRtFsPur8RmJmQhQB7tigfLyBRCLH
         56f70v2UQ5p0GNRcTxnGuIJzRa+BCxI2v7H/PHumqD4yyfN0hb86OsO8HXpOgR08uM8x
         /2OmoJ2EQ2zg4rty6LCKjaA7LkGTppQxXgwrWMv5L5B79U/u2TtOb+JKEmDeKq+Ktmc7
         Kedw==
X-Gm-Message-State: AJIora+6qUlWLaYbvmFqG5biwsBc30C3Fhu3eZu3+GL3fwhmSFakkaLB
        UBKR5FxvIiFU+5nSdbPeaCKGeY/0Oo03Yq6qq+d0ig==
X-Google-Smtp-Source: AGRyM1vRgR19NCJfJTThyBy72KUy+2l2jUQiKnrXY0BDlmBYKXGX0VUzC3S3g8p+1nnVo40mGHoKiAF4mm2lH8D/lfI=
X-Received: by 2002:adf:fd4a:0:b0:21d:8b59:dcb1 with SMTP id
 h10-20020adffd4a000000b0021d8b59dcb1mr29801603wrs.622.1658302942294; Wed, 20
 Jul 2022 00:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220719092214.995965-1-sadiyakazi@google.com>
In-Reply-To: <20220719092214.995965-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 20 Jul 2022 15:42:11 +0800
Message-ID: <CABVgOSk2PYruRHnU=VnkNo71J_s+0eysNszkFuLY3VD2DpKXGQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add CLI args for kunit_tool
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d35c3905e437bd15"
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

--000000000000d35c3905e437bd15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 5:22 PM Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> Run_wrapper.rst was missing some command line arguments. Added
> additional args in the file. Included all initial review comments.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

This looks pretty good, save for some minor nitpicks below. I also
echo Ma=C3=ADra's comments, though I'm not _too_ worried about having a
little bit of duplication if it means we get a complete (or
nearly-complete) list of arguments here, but still have them described
in the appropriate part of the rest of the documentation.

Cheers,
-- David

>  Documentation/dev-tools/kunit/run_wrapper.rst | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentatio=
n/dev-tools/kunit/run_wrapper.rst
> index 5e560f2c5fca..91f5dda36e83 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -257,3 +257,51 @@ command line arguments:
>              added or modified. Instead, enable all tests
>              which have satisfied dependencies by adding
>              ``CONFIG_KUNIT_ALL_TESTS=3Dy`` to your ``.kunitconfig``.
> +- ``--kunitconfig``: Specifies the path to the ``.kunitconfig`` file.
> +  This Kconfig fragment enables KUnit tests. The "/.kunitconfig" gets
> +  appended to the path specified. For example, If a directory path "lib/=
kunit"
> +  is given, the complete path will be "lib/kunit/.kunitconfig".

This is definitely a bit confusing: it seems to describe "how it
works" more than "what is it, and when do you use it". Perhaps
something more like:

"Specifies a .kunitconfig file to use to build and run with a
predefined set of tests and their dependencies. (e.g., to run tests
for a given subsystem). This can be the path to a file, or to a
directory (in which case a file named ".kunitconfig" in said directory
will be used.)"

> +
> +- ``--kconfig_add``: Specifies additional configuration options to be
> +  appended to the ``.kunitconfig`` file. For example, ``CONFIG_KASAN=3Dy=
``.
> +
> +- ``--arch``: Runs tests with the specified architecture. The architectu=
re
> +  specified must match the string passed to the ARCH make parameter.
> +  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on =
QEMU.
> +  Default to 'um'.
> +
> +- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
> +  same argument as passed to the ``CROSS_COMPILE`` variable used by
> +  Kbuild. This will be the prefix for the toolchain
> +  binaries such as GCC. For example:
> +
> +  - ``sparc64-linux-gnu`` if we have the sparc toolchain installed on
> +    our system.

This example should be ``sparc64-linux-gnu-`` (with the extra
hyphen-minus at the end). It's concatenated to produce, e.g.,
sparc64-linux-gnu-gcc.

> +
> +  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/=
microblaze-linux``
> +    if we have downloaded the microblaze toolchain from the 0-day
> +    website to a specified path in our home directory called toolchains.
> +
> +- ``--qemu_config``: Specifies the path to the file containing a
> +  custom qemu architecture definition. This should be a python file
> +  containing a QemuArchParams object.
> +
> +- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-s=
mp 8".
> +
> +- ``--jobs``: Specifies the number of jobs (commands) to run simultaneou=
sly.
> +  By default, this is set to the number of cores on your system.
> +
> +- ``--timeout``: Specifies the maximum number of seconds allowed for all=
 tests to run.
> +  This does not include the time taken to build the tests.
> +
> +- ``--kernel_args``: Specifies the kernel command-line arguments. Might =
be repeated.

Nit: maybe "Specifies _additional_ kernel command-line arguments".
kunit_tool already sets some.

> +
> +- ``--run_isolated``: If set, boots the kernel for each individual suite=
/test.
> +  This is useful for debugging a non-hermetic test, one that
> +  might pass/fail based on what ran before it.



> +
> +- ``--raw_output``: If set, generates unformatted output from kernel.
> +  If set to ``--raw_output=3Dkunit``, filters to just KUnit output.

--raw_output=3Dkunit is the default if just --raw_output is set. You
need to specify --raw_output=3Dall for the full kernel output.

> +
> +- ``--json``: If set, it stores the test results in a JSON format and pr=
ints to stdout or
> +  saves to a file if a filename is specified.

Nit: let's remove the first 'it' to be consistent with the previous
entries. i.e., "If set, stores..."

> --
> 2.37.0.170.g444d1eabd0-goog
>

--000000000000d35c3905e437bd15
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCK
fw6QY6Kbpl+Cx8AvAu8sJw4Y0IIUN2am4pNi4k3wYDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MjAwNzQyMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEPPwSKQVi/rgYulroxdd
XW+ennLNOfkbkQG+cUbYoX90edp1zcpJZFKu7xVEC58t9vCHQsY1wPqlEYMrM1JLnlJ1xkDBiT3Z
LWCbxHFLvTNWTgvqm6rLNOGnZ9xdBkDBL3gmz4++XMS6FibOJ1PNb8MLyiayaQk3Dx8tbqoDTPZk
PAYuvTIlOTEKJKuW/iO9rO7BWQRtZhcSzFbLx07RLBXFlsC+ZJAWUfz2gTKsbvkJ2pL1wvrx6bxm
1FGLlp2lKvH5zcCSIkrp5zfTRU1lduxCuX2KqAUghGHpl54hcg2NIH1jkofAMWM4Nvo1GPynw3aU
O8mK37V9NbZPaLBOFw==
--000000000000d35c3905e437bd15--
