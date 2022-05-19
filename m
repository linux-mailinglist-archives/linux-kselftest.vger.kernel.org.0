Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7052D3CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbiESNUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiESNU2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 09:20:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE1C8BEC
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:20:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso3541132wmq.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KJ6/5NQJ6oBQAhz5pY02dkoJHRW57gGapyDdRnlMRg=;
        b=UXS/EiOAgZNqbxIpkwo0ymEj7uyK/MzjurEScxRaymp+YBD9pO1D8S6fBr2NMb+AHL
         zy7exuULAiivBWfZ5aq3Npx+7ozPqHy+L1bHkLovyTHhPn/petB9td9Hxh+5OaFjqHV5
         027Nu723Pi4B8Q9crxMRMrcJk7Hn22Rm2aORVR6zooZ4tWPOrnqE301viYKD4fygckHl
         OaZMvwazoNAL1o8hjv+gpR8ri5mIifLfdNbu4PjyQ/esPh60KF9D7YYEELVyF+dpKePH
         NzgQKdUcEitnFBOgiHpw1AjhcnGNjxrjSKzGzXA94A3tKfWbEqJY5nJ8l186D70P0qIo
         49jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KJ6/5NQJ6oBQAhz5pY02dkoJHRW57gGapyDdRnlMRg=;
        b=iQ4K0uUEuN3D9PnyDbbD2WX4GXTywjtB1DpugOVzT6JyG6eismbgGSeoQGAXWmyUQr
         Rhntkn24OZIwBjuRcGznZoH4loDHy8b/RujUmZJbpwXMhkbVnUcctnrFoUYMz/fxWYYo
         YJxZH+WsPCSVM5TuSJxwmo42EVqctAeL2A0vx/g1cEblcCkf3xCz9ApsnGAdbcMhy4ZP
         tglO6iIzi0T7if5oGYXfuq86cCS4nj54e2v1lsq0ybb/JXYC0cAnUcGkc378dq5wfFjx
         +carg12dWmMIvhTcgq8DZSVJvk4fNAyEnF4NZODdF6Z7qU4f3eA3RS/0bAGK8zHdfbHF
         1qYQ==
X-Gm-Message-State: AOAM533SJqg3zUGNUsbhbD32jGq/MtvP6ugV3X7Ehqu0kHNpvbJ70zLx
        KKTBZgU0Cjlu64Mb3OFRgqDTli8RTrdsQ9Mc84828KF9LYY=
X-Google-Smtp-Source: ABdhPJzf+YVKzMJ0WUcQvvR2NQhOzMuZpSOeBQSEMvhMViw20cHbIkPpTkwydXNhsqDBuwCAFgTxusRopOf6jLHqSAI=
X-Received: by 2002:a05:600c:1f08:b0:394:9060:bb54 with SMTP id
 bd8-20020a05600c1f0800b003949060bb54mr3859375wmb.73.1652966424279; Thu, 19
 May 2022 06:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com> <20220518170124.2849497-4-dlatypov@google.com>
In-Reply-To: <20220518170124.2849497-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 19 May 2022 21:20:12 +0800
Message-ID: <CABVgOSkTc08s=0Ai=utBv2UpM48M--b64xJGC=Gj8PCZ9yJ1_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: introduce --qemu_args
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000935e4c05df5d3c54"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000935e4c05df5d3c54
Content-Type: text/plain; charset="UTF-8"

On Thu, May 19, 2022 at 1:01 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Example usage:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>   --kconfig_add=CONFIG_SMP=y --qemu_args='-smp 8'
>
> Looking in the test.log, one can see
> > smp: Bringing up secondary CPUs ...
> > .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> > smp: Brought up 1 node, 8 CPUs
>
> This flag would allow people to make tweaks like this without having to
> create custom qemu_config files.
>
> For consistency with --kernel_args, we allow users to repeat this
> argument, e.g. you can tack on a --qemu_args='-m 2048', or you could
> just append it to the first string ('-smp 8 -m 2048').
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I like this -- it's definitely something I've wanted to have in the
past. I was a bit worried about how we'd handle longer strings of
arguments, but the combination of the shlex-based splitting and
repeated arguments seems to work for all the cases I can think of.
(And it's much nicer than, e.g, passing linker flags with -Wl,a,b,c in
my opinion!)

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  tools/testing/kunit/kunit.py           | 14 +++++++++++++-
>  tools/testing/kunit/kunit_kernel.py    | 10 +++++++---
>  tools/testing/kunit/kunit_tool_test.py | 20 +++++++++++++++++---
>  3 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 8a90d80ee66e..e01c7964f744 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -10,6 +10,7 @@
>  import argparse
>  import os
>  import re
> +import shlex
>  import sys
>  import time
>
> @@ -323,6 +324,10 @@ def add_common_opts(parser) -> None:
>                                   'a QemuArchParams object.'),
>                             type=str, metavar='FILE')
>
> +       parser.add_argument('--qemu_args',
> +                           help='Additional QEMU arguments, e.g. "-smp 8"',
> +                           action='append', metavar='')
> +
>  def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
> @@ -368,12 +373,19 @@ def add_parse_opts(parser) -> None:
>
>  def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
>         """Returns a LinuxSourceTree based on the user's arguments."""
> +       # Allow users to specify multiple arguments in one string, e.g. '-smp 8'
> +       qemu_args: List[str] = []
> +       if cli_args.qemu_args:
> +               for arg in cli_args.qemu_args:
> +                       qemu_args.extend(shlex.split(arg))
> +
>         return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
>                         kunitconfig_path=cli_args.kunitconfig,
>                         kconfig_add=cli_args.kconfig_add,
>                         arch=cli_args.arch,
>                         cross_compile=cli_args.cross_compile,
> -                       qemu_config_path=cli_args.qemu_config)
> +                       qemu_config_path=cli_args.qemu_config,
> +                       extra_qemu_args=qemu_args)
>
>
>  def main(argv):
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index e93f07ac0af1..a791073d25f9 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -187,6 +187,7 @@ def _default_qemu_config_path(arch: str) -> str:
>         raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
>
>  def _get_qemu_ops(config_path: str,
> +                 extra_qemu_args: Optional[List[str]],
>                   cross_compile: Optional[str]) -> Tuple[str, LinuxSourceTreeOperations]:
>         # The module name/path has very little to do with where the actual file
>         # exists (I learned this through experimentation and could not find it
> @@ -207,6 +208,8 @@ def _get_qemu_ops(config_path: str,
>         if not hasattr(config, 'QEMU_ARCH'):
>                 raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
>         params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
> +       if extra_qemu_args:
> +               params.extra_qemu_params.extend(extra_qemu_args)
>         return params.linux_arch, LinuxSourceTreeOperationsQemu(
>                         params, cross_compile=cross_compile)
>
> @@ -220,17 +223,18 @@ class LinuxSourceTree:
>               kconfig_add: Optional[List[str]]=None,
>               arch=None,
>               cross_compile=None,
> -             qemu_config_path=None) -> None:
> +             qemu_config_path=None,
> +             extra_qemu_args=None) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
>                 if qemu_config_path:
> -                       self._arch, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
> +                       self._arch, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
>                 else:
>                         self._arch = 'um' if arch is None else arch
>                         if self._arch == 'um':
>                                 self._ops = LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
>                         else:
>                                 qemu_config_path = _default_qemu_config_path(self._arch)
> -                               _, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
> +                               _, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
>
>                 if kunitconfig_path:
>                         if os.path.isdir(kunitconfig_path):
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index baee11d96474..7fe5c8b0fb57 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -649,7 +649,8 @@ class KUnitMainTest(unittest.TestCase):
>                                                 kconfig_add=None,
>                                                 arch='um',
>                                                 cross_compile=None,
> -                                               qemu_config_path=None)
> +                                               qemu_config_path=None,
> +                                               extra_qemu_args=[])
>
>         def test_config_kunitconfig(self):
>                 kunit.main(['config', '--kunitconfig=mykunitconfig'])
> @@ -659,7 +660,8 @@ class KUnitMainTest(unittest.TestCase):
>                                                 kconfig_add=None,
>                                                 arch='um',
>                                                 cross_compile=None,
> -                                               qemu_config_path=None)
> +                                               qemu_config_path=None,
> +                                               extra_qemu_args=[])
>
>         def test_run_kconfig_add(self):
>                 kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
> @@ -669,7 +671,19 @@ class KUnitMainTest(unittest.TestCase):
>                                                 kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
>                                                 arch='um',
>                                                 cross_compile=None,
> -                                               qemu_config_path=None)
> +                                               qemu_config_path=None,
> +                                               extra_qemu_args=[])
> +
> +       def test_run_qemu_args(self):
> +               kunit.main(['run', '--arch=x86_64', '--qemu_args', '-m 2048'])
> +               # Just verify that we parsed and initialized it correctly here.
> +               self.mock_linux_init.assert_called_once_with('.kunit',
> +                                               kunitconfig_path=None,
> +                                               kconfig_add=None,
> +                                               arch='x86_64',
> +                                               cross_compile=None,
> +                                               qemu_config_path=None,
> +                                               extra_qemu_args=['-m', '2048'])
>
>         def test_run_kernel_args(self):
>                 kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
> --
> 2.36.1.124.g0e6072fb45-goog
>

--000000000000935e4c05df5d3c54
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAFB5XJs46lHhs45dlgv
lPcwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjAyMDcy
MDA0MDZaFw0yMjA4MDYyMDA0MDZaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0RBy/38QAswohnM4+BbSvCjgfqx6l
RZ05OpnPrwqbR8foYkoeQ8fvsoU+MkOAQlzaA5IaeOc6NZYDYl7PyNLLSdnRwaXUkHOJIn09IeqE
9aKAoxWV8wiieIh3izFAHR+qm0hdG+Uet3mU85dzScP5UtFgctSEIH6Ay6pa5E2gdPEtO5frCOq2
PpOgBNfXVa5nZZzgWOqtL44txbQw/IsOJ9VEC8Y+4+HtMIsnAtHem5wcQJ+MqKWZ0okg/wYl/PUj
uaq2nM/5+Waq7BlBh+Wh4NoHIJbHHeGzAxeBcOU/2zPbSHpAcZ4WtpAKGvp67PlRYKSFXZvbORQz
LdciYl8fAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKbSiBVQ
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBE
l8eGuobgbxdCXiWAycy3h0d/f9+NM+9vSaZi/bkNdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MTkxMzIwMjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcovz9H1vfWX6ORKauN2N
3Bor/je/s0QqpHbV90DL988XL69myUtmlOs8A2pK+nPWL1Ig25RBclQuHxe+ypgo8sjNYexO1aDn
VDBYGwSgLWrcjXR3Ja4E8nBAYpqUgZi9qvtJEZCTj5oragrRE5CsnmPPM7pdEQmu/evZcTeuCYd8
NfS6x7PI8ORWc+e7if+eVdvYQgjdhCCrbLwjNsG2sGR/9xHgycfbP/w5uCwpoB0Yuu1T3gXiztHE
oNpIslenqVaV6wSizunmc++n9w1FNzbayrcx8ACB41eOcNRfTnA3+wy/3LGg+YYnY8AYKvp/i8YO
dlKEqt1Q8ELKzQFxFQ==
--000000000000935e4c05df5d3c54--
