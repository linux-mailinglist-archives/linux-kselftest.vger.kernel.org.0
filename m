Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89084C53B4
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 05:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiBZEaH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 23:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBZEaG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 23:30:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E890FE0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 20:29:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so7270203wrr.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 20:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+DOBzqQF23JL4rJrWl+773OvjGud4VEAaj0oSGMA0M=;
        b=nmlL9Y3KLTOad2RVOiIcDBl9BqX+VV4uwNOqdOHyy+Aty5sggFZVB2cJNCvosZZgtO
         RfS3lBPoSf+cbiCCZz+DRg3XDhFjrpf6+krAmy7RRJrhUheUZgwyHsgyM2sxmRaLdsvD
         canPY/xpHvUxXpXMzoFVSl5R3FVd87hsV8IVzgqFxpEK6rm0FQNcKyp4RKX78kNfYbnH
         0Cx1ViB78BSvB8I7KidG1iQt/3R1alW8Uyym9svIKoNNKq03X7Ccg8kh/fnpmdSuwRAz
         0clBGdCsH72CQdLWRGJZV6F44J6riwPOTPf33kMArhcNRa+/plFMn4UpMrX1iCET3ORw
         LH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+DOBzqQF23JL4rJrWl+773OvjGud4VEAaj0oSGMA0M=;
        b=w+qTl//Ej+JK1UdzG2f8jLtlbLcQcrur/wZHMl6gjPiKVq34UlfBDJkuabTUgA6/vt
         661Czj8h5rdQwcGX6wj6pidX0w/3MtKUAgyaBbooyIM9JAAdoH4UwH8e+jiL34r6KHxr
         oajru3MckeEp5vcpSPT33vNHnRiZ/Sy1rIXtk8J6RSU4moyXS9CCrKYY4ioI7ByFBZ2G
         7uqeUdYYNdIy0qWzVUesybTl3/7kgEvzZn+NGWnUR2ZCNb/S2OTx3KtPlN2/xYM6v7RS
         8HcuzkzyezqnJlSq9XBAba7lkiDwbO1GeXCIevmaygPyMARaRDqygYhKSZMcKuAHwc7N
         76sw==
X-Gm-Message-State: AOAM530fteq9hi1XegtzqakJ6CbTlK+k8ZcXuATP4GB2kStqZuDHK5en
        pokhFrPV4kKmrmVhqDNHZcj+nwVqyBI3SwAXgXpF4Q==
X-Google-Smtp-Source: ABdhPJwsgSQQzG89NMM0EyAWID//TTBRo1fc6iM/rxNstlX3A+V+eSE3Yx6oRWhlWxLa9nxh+S/AhAtju37j8J2Gnvw=
X-Received: by 2002:a5d:5446:0:b0:1ed:c29c:1a4d with SMTP id
 w6-20020a5d5446000000b001edc29c1a4dmr8274564wrv.46.1645849770685; Fri, 25 Feb
 2022 20:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20220226033054.2860933-1-dlatypov@google.com>
In-Reply-To: <20220226033054.2860933-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 26 Feb 2022 12:29:19 +0800
Message-ID: <CABVgOSksQBD4F8UaKE3N8D-_U65w_t+OwchQ1G52YnAb1a4YUg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: more descriptive metavars/--help output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f6763d05d8e44275"
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

--000000000000f6763d05d8e44275
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 26, 2022 at 11:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before, our help output contained lines like
>   --kconfig_add KCONFIG_ADD
>   --qemu_config qemu_config
>   --jobs jobs
>
> They're not very helpful.
>
> The former kind come from the automatic 'metavar' we get from argparse,
> the uppsercase version of the flag name.

Nit: "uppsercase" -> "uppercase"

> The latter are where we manually specified metavar as the flag name.

This was at least partly my fault: I didn't know what 'metavar' was
actually supposed to be, so assumed it was the name of the variable
the option set (hence them all being the same).

>
> After:
>   --build_dir DIR
>   --make_options X=Y
>   --kunitconfig KUNITCONFIG
>   --kconfig_add CONFIG_X=Y
>   --arch ARCH
>   --cross_compile PREFIX
>   --qemu_config FILE
>   --jobs N
>   --timeout SECONDS
>   --raw_output [{all,kunit}]
>   --json [FILE]
>
> This patch tries to make the code more clear by specifying the _type_ of
> input we expect, e.g. --build_dir is a DIR, --qemu_config is a FILE.
> I also switched it to uppercase since it looked more clearly like
> placeholder text that way.

Looks good. I like all of these except possibly KUNITCONFIG, which I
think should probably be FILE, too.

>
> This patch also changes --raw_output to specify `choices` to make it
> more clear what the options are, and this way argparse can validate it
> for us, as shown by the added test case.

Excellent: that's much more discoverable (and the validation will no
doubt be useful).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py           | 26 ++++++++++++--------------
>  tools/testing/kunit/kunit_tool_test.py |  5 +++++
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 9274c6355809..566404f5e42a 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -206,8 +206,6 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
>                         pass
>                 elif request.raw_output == 'kunit':
>                         output = kunit_parser.extract_tap_lines(output)
> -               else:
> -                       print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
>                 for line in output:
>                         print(line.rstrip())
>
> @@ -281,10 +279,10 @@ def add_common_opts(parser) -> None:
>         parser.add_argument('--build_dir',
>                             help='As in the make command, it specifies the build '
>                             'directory.',
> -                           type=str, default='.kunit', metavar='build_dir')
> +                           type=str, default='.kunit', metavar='DIR')
>         parser.add_argument('--make_options',
>                             help='X=Y make option, can be repeated.',
> -                           action='append')
> +                           action='append', metavar='X=Y')
>         parser.add_argument('--alltests',
>                             help='Run all KUnit tests through allyesconfig',
>                             action='store_true')
> @@ -292,11 +290,11 @@ def add_common_opts(parser) -> None:
>                              help='Path to Kconfig fragment that enables KUnit tests.'
>                              ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
>                              'will get  automatically appended.',
> -                            metavar='kunitconfig')
> +                            metavar='KUNITCONFIG')

Is it worth making this something like FILE or PATH instead.
PATH_TO_KUNITCONFIG would be verbose, but this is a path being given,
so just KUNITCONFIG is still a bit useless.

>         parser.add_argument('--kconfig_add',
>                              help='Additional Kconfig options to append to the '
>                              '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
> -                           action='append')
> +                           action='append', metavar='CONFIG_X=Y')
>
>         parser.add_argument('--arch',
>                             help=('Specifies the architecture to run tests under. '
> @@ -304,7 +302,7 @@ def add_common_opts(parser) -> None:
>                                   'string passed to the ARCH make param, '
>                                   'e.g. i386, x86_64, arm, um, etc. Non-UML '
>                                   'architectures run on QEMU.'),
> -                           type=str, default='um', metavar='arch')
> +                           type=str, default='um', metavar='ARCH')
>
>         parser.add_argument('--cross_compile',
>                             help=('Sets make\'s CROSS_COMPILE variable; it should '
> @@ -316,18 +314,18 @@ def add_common_opts(parser) -> None:
>                                   'if you have downloaded the microblaze toolchain '
>                                   'from the 0-day website to a directory in your '
>                                   'home directory called `toolchains`).'),
> -                           metavar='cross_compile')
> +                           metavar='PREFIX')
>
>         parser.add_argument('--qemu_config',
>                             help=('Takes a path to a path to a file containing '
>                                   'a QemuArchParams object.'),
> -                           type=str, metavar='qemu_config')
> +                           type=str, metavar='FILE')
>
>  def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
>                             'jobs (commands) to run simultaneously."',
> -                           type=int, default=get_default_jobs(), metavar='jobs')
> +                           type=int, default=get_default_jobs(), metavar='N')
>
>  def add_exec_opts(parser) -> None:
>         parser.add_argument('--timeout',
> @@ -336,7 +334,7 @@ def add_exec_opts(parser) -> None:
>                             'tests.',
>                             type=int,
>                             default=300,
> -                           metavar='timeout')
> +                           metavar='SECONDS')
>         parser.add_argument('filter_glob',
>                             help='Filter which KUnit test suites/tests run at '
>                             'boot-time, e.g. list* or list*.*del_test',
> @@ -346,7 +344,7 @@ def add_exec_opts(parser) -> None:
>                             metavar='filter_glob')
>         parser.add_argument('--kernel_args',
>                             help='Kernel command-line parameters. Maybe be repeated',
> -                            action='append')
> +                            action='append', metavar='')
>         parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
>                             'individual suite/test. This is can be useful for debugging '
>                             'a non-hermetic test, one that might pass/fail based on '
> @@ -357,13 +355,13 @@ def add_exec_opts(parser) -> None:
>  def add_parse_opts(parser) -> None:
>         parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
>                             'If set to --raw_output=kunit, filters to just KUnit output.',
> -                           type=str, nargs='?', const='all', default=None)
> +                            type=str, nargs='?', const='all', default=None, choices=['all', 'kunit'])
>         parser.add_argument('--json',
>                             nargs='?',
>                             help='Stores test results in a JSON, and either '
>                             'prints to stdout or saves to file if a '
>                             'filename is specified',
> -                           type=str, const='stdout', default=None)
> +                           type=str, const='stdout', default=None, metavar='FILE')
>
>  def main(argv, linux=None):
>         parser = argparse.ArgumentParser(
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 352369dffbd9..eb2011d12c78 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -595,6 +595,11 @@ class KUnitMainTest(unittest.TestCase):
>                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
>                         self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
>
> +       def test_run_raw_output_invalid(self):
> +               self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> +               with self.assertRaises(SystemExit) as e:
> +                       kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
> +
>         def test_run_raw_output_does_not_take_positional_args(self):
>                 # --raw_output is a string flag, but we don't want it to consume
>                 # any positional arguments, only ones after an '='
>
> base-commit: 5debe5bfa02c4c8922bd2d0f82c9c3a70bec8944
> --
> 2.35.1.574.g5d30c73bfb-goog
>

--000000000000f6763d05d8e44275
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCP
UYE9nbjX+cNPlsAlplbO920P6oKdrl6fqj6R+fETzzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjYwNDI5MzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASrUDjpwcpKiJZsG/66+p
iBZtepfjeoxXhyxND46HHpB6bx6uKuMcLXTz1M8AlaRLH6pJXDGJ1i6ky+X0tPin4J06Y0nUd7w5
YFDpU+iISjnltWA8DvMabIJ4TF4rsQGYSaG0YeHDfetIkuucb4h5JfUZ3LJUcGgp/XTw6mKDITvX
Mf/mKxpwNMobi85I0C+yWQhZN8DHXcZJnKaVr18Tac2t6XHqgUUmjJL7sKQJwVFEdQg53bwOfV4g
CfHnmjSjTl/v4ZLIOGZbYbrsg3+0HQ6oIyytXk9vtITmsoTJwYbs8sTocGZNpQgAQdZDQXLEMzO7
wM75AouzOCLfPfPq8A==
--000000000000f6763d05d8e44275--
