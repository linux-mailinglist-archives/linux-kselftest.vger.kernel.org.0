Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6B3CB1B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jul 2021 06:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhGPEyV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jul 2021 00:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhGPEyU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jul 2021 00:54:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7EC06175F
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jul 2021 21:51:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n4so5008394wms.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jul 2021 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85RDOttSLdCQ/Xyz4VD+XOldAK+DCkx7pxNry+NihG4=;
        b=Z7achgQAHgXiBmTslVrq2ykLRkqrGHPNQQM6wwNK5MOifeOpajQeg5YpFKc4ngLyeg
         0xfAiXIz5/z9ynkRzl8jKx/7XwRWd2OGokoyQ2E/s/C3dSS/CsfuLTw+Jniydt0EiEEx
         1FvVLKgYr+VcVtKr5KIasxtB+ad7oXw99AFJDXPFynUFXn4ZDaYLcgkbjK1ydlFTdS9N
         Aa4opO6nLfYbENEzHTtvdq5z1gRMVk3ZW6SzTgYvLCYb+TGYnOu/tEVIiIKc7rPYwInB
         7Y1eGX5KTSeO/nBDSijxfL/ZT90Q92QIPvenmjNOmIKjdw49z0R7bWWHMVNQBGxA0WL9
         5mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85RDOttSLdCQ/Xyz4VD+XOldAK+DCkx7pxNry+NihG4=;
        b=STZDVEConDOYc/ZVCcPfQFcE1vp3Bz34152MCHX4ephfFfRoILEKz6bY0rgdSzUyae
         7a9ylf/iVFLX5DNafC0FsELJITAUZK5kktxkO5K+h43BCY+aSmQDOsR/ftwROHIUUivV
         reEc/8lE2AZyJgEWEGkc/TuryWxQS/3zAOBhRRalsPFjP/nnOzsILnx5pzh5QFX8acZ7
         4HlhtRREhbSWoIwwb4x5vB5XzbXtaKeUAc7bhpTXmercCAXaUAJBaRxtRN74PoV/thWM
         LklKedcTEQ3Ep1/ppQSBQhDRmlcIJuG8Ndv6JjPPUGsKk6zbexJYnPlurNYSXfM1lszp
         1MlA==
X-Gm-Message-State: AOAM533PNvQPJL24EUT1wupZOlcYhfGlK56rqxXs3eEJkA4LuTBnTFel
        bY+GZMlLyBwDCdabPhsTHPOc6nx5M09GzTUX95DDVQ==
X-Google-Smtp-Source: ABdhPJy+NmUdOCfJKrOvRvkgDncc1RIGn/wS7oht/FyXYUg0KhAI5wEthePpsuVFuCg0Kn2CgpEUvVNvIMh7PacCHGI=
X-Received: by 2002:a1c:494:: with SMTP id 142mr8355224wme.60.1626411083733;
 Thu, 15 Jul 2021 21:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210715160819.1107685-1-dlatypov@google.com>
In-Reply-To: <20210715160819.1107685-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Jul 2021 12:51:12 +0800
Message-ID: <CABVgOSn375JYVjv3b92UedyfjnsawpFTXSJfY0cf5wb1hXrZ2g@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: tool: add --kernel_args to allow setting module params
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f0857a05c73656b8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000f0857a05c73656b8
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 16, 2021 at 12:08 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit.py currently does not make it possible for users to specify module
> parameters (/kernel arguments more generally) unless one directly tweaks
> the kunit.py code itself.
>
> This hasn't mattered much so far, but this would make it easier to port
> existing tests that expose module parameters over to KUnit and/or let
> current KUnit tests take advantage of them.
>
> Tested using an kunit internal parameter:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit \
>     --kernel_args=kunit.filter_glob=kunit_status
> ...
> Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks! This looks good now:

Reviewed-by: David Gow <davidgow@google.com>

-- David

> v1 -> v2:
> s/kernel_arg/kernel_args in documentation
> v2 -> v3:
> Fix up kunit_tool_test.py, add a test case.
> ---
>  .../dev-tools/kunit/running_tips.rst          | 10 ++++++++++
>  tools/testing/kunit/kunit.py                  | 16 +++++++++++----
>  tools/testing/kunit/kunit_tool_test.py        | 20 +++++++++++++------
>  3 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 7d99386cf94a..ebaaa2764207 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -80,6 +80,16 @@ file ``.kunitconfig``, you can just pass in the dir, e.g.
>         automagically, but tests could theoretically depend on incompatible
>         options, so handling that would be tricky.
>
> +Setting kernel commandline parameters
> +-------------------------------------
> +
> +You can use ``--kernel_args`` to pass arbitrary kernel arguments, e.g.
> +
> +.. code-block:: bash
> +
> +       $ ./tools/testing/kunit/kunit.py run --kernel_args=param=42 --kernel_args=param2=false
> +
> +
>  Generating code coverage reports under UML
>  ------------------------------------------
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index be8d8d4a4e08..03f3bc406955 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -28,12 +28,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
>                                ['jobs', 'build_dir', 'alltests',
>                                 'make_options'])
>  KunitExecRequest = namedtuple('KunitExecRequest',
> -                             ['timeout', 'build_dir', 'alltests', 'filter_glob'])
> +                              ['timeout', 'build_dir', 'alltests',
> +                               'filter_glob', 'kernel_args'])
>  KunitParseRequest = namedtuple('KunitParseRequest',
>                                ['raw_output', 'input_data', 'build_dir', 'json'])
>  KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
>                                            'build_dir', 'alltests', 'filter_glob',
> -                                          'json', 'make_options'])
> +                                          'kernel_args', 'json', 'make_options'])
>
>  KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
>
> @@ -92,6 +93,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
>         kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
>         test_start = time.time()
>         result = linux.run_kernel(
> +               args=request.kernel_args,
>                 timeout=None if request.alltests else request.timeout,
>                  filter_glob=request.filter_glob,
>                 build_dir=request.build_dir)
> @@ -150,7 +152,8 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
>                 return build_result
>
>         exec_request = KunitExecRequest(request.timeout, request.build_dir,
> -                                       request.alltests, request.filter_glob)
> +                                request.alltests, request.filter_glob,
> +                                request.kernel_args)
>         exec_result = exec_tests(linux, exec_request)
>         if exec_result.status != KunitStatus.SUCCESS:
>                 return exec_result
> @@ -236,6 +239,9 @@ def add_exec_opts(parser) -> None:
>                             nargs='?',
>                             default='',
>                             metavar='filter_glob')
> +       parser.add_argument('--kernel_args',
> +                           help='Kernel command-line parameters. Maybe be repeated',
> +                            action='append')
>
>  def add_parse_opts(parser) -> None:
>         parser.add_argument('--raw_output', help='don\'t format output from kernel',
> @@ -307,6 +313,7 @@ def main(argv, linux=None):
>                                        cli_args.build_dir,
>                                        cli_args.alltests,
>                                        cli_args.filter_glob,
> +                                      cli_args.kernel_args,
>                                        cli_args.json,
>                                        cli_args.make_options)
>                 result = run_tests(linux, request)
> @@ -361,7 +368,8 @@ def main(argv, linux=None):
>                 exec_request = KunitExecRequest(cli_args.timeout,
>                                                 cli_args.build_dir,
>                                                 cli_args.alltests,
> -                                               cli_args.filter_glob)
> +                                               cli_args.filter_glob,
> +                                               cli_args.kernel_args)
>                 exec_result = exec_tests(linux, exec_request)
>                 parse_request = KunitParseRequest(cli_args.raw_output,
>                                                   exec_result.result,
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bdae0e5f6197..93fda23f446c 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -346,7 +346,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       build_dir='.kunit', filter_glob='', timeout=300)
> +                       args=None, build_dir='.kunit', filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_passes_args_pass(self):
> @@ -354,7 +354,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       build_dir='.kunit', filter_glob='', timeout=300)
> +                       args=None, build_dir='.kunit', filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_exec_passes_args_fail(self):
> @@ -393,7 +393,7 @@ class KUnitMainTest(unittest.TestCase):
>                 timeout = 3453
>                 kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       build_dir='.kunit', filter_glob='', timeout=timeout)
> +                       args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_timeout(self):
> @@ -401,7 +401,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       build_dir='.kunit', filter_glob='', timeout=timeout)
> +                       args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_builddir(self):
> @@ -409,7 +409,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       build_dir=build_dir, filter_glob='', timeout=300)
> +                       args=None, build_dir=build_dir, filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_config_builddir(self):
> @@ -426,7 +426,7 @@ class KUnitMainTest(unittest.TestCase):
>                 build_dir = '.kunit'
>                 kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       build_dir=build_dir, filter_glob='', timeout=300)
> +                       args=None, build_dir=build_dir, filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> @@ -451,5 +451,13 @@ class KUnitMainTest(unittest.TestCase):
>                                                         cross_compile=None,
>                                                         qemu_config_path=None)
>
> +       def test_run_kernel_args(self):
> +               kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'], self.linux_source_mock)
> +               self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> +               self.linux_source_mock.run_kernel.assert_called_once_with(
> +                     args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
> +               self.print_mock.assert_any_call(StrContains('Testing complete.'))
> +
> +
>  if __name__ == '__main__':
>         unittest.main()
>
> base-commit: 8096acd7442e613fad0354fc8dfdb2003cceea0b
> --
> 2.32.0.93.g670b81a890-goog
>

--000000000000f0857a05c73656b8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
/nKVAPkPCzwfEPbL1262MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA+XCDyl6gdUzbfGv+D
Xg1PhWeHLeXCPc9+sNLwRPD9AYET0o6RJYqNAVFC77sI4quIUtKk+H44VwMwNOhX3PY+69dzUd2E
XLgutq81YK/Kt/wRUdEbgvDhvjumsVENI6xc4xZzAXAZqJLK+AR5oNtx0o9GC2el89ZF3yPI8KqH
1aOYvtgDisoXXmst9rm6Njnt9AitTax0LwWdl1yGwnA6cqJfq8h7Ehg+6X3TGW4wMM1RsB9tLL2d
osQsJT49+adAbU2yODf/XkIQevor0sIhJuxYkLay9G2GK1DCEmqUfbXWF5yQRxBkhVXHodFI2+V1
OPxk5TOVVOId6G/60Hq4MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABeyW1Dfueu+w9B/G1jwK+MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAJrfv0
ksLJojuOEWBoH4tlRYav8l2wlRid4NMr7QGXITAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA3MTYwNDUxMjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAWjtux5ETQnugcAt0TUj2Ws8a
vToe7Z+hb2hQQ12iimqPggjdOc7jD1M9Cev4V5KYsCjoaobqU9VJEdo/5CFLEufkaG9JMR8OUu61
Ak7PWb4Wzm56UdTl2+bTmJAx8U8sburvzKTE2VtBXxKYcEiZM8L6iaxAfWwvSBGRhowNLwnmNoY9
L9g1TgqSBKCVdLUMHRSXtwjSR+s0iiZ5MLGE1h5tgUEqul5ljgB/0J4wrLculu0RiP8RcazUJXTZ
LQAbRMOZQ4lhvbiRP1Qu3nTpsKeUMWBUfeL8tVqFV3tW3Ee+e4xXLURh1gc2aVWOKEzUPAFKAk8q
2Ml6cjaWRifvvA==
--000000000000f0857a05c73656b8--
