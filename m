Return-Path: <linux-kselftest+bounces-49136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF7D2EC2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 10:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39F44301330C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79705357A30;
	Fri, 16 Jan 2026 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1uBQOYOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7C242D62
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555842; cv=pass; b=jbd4lbVHA/yB0twWfTorRydmAYi8XQjPHIt64LgAUXyy/3s7EpSECvqQ0Kb2JGLUrEkME+2oab8BxKjc8S54yuVE9QmHKP7vw3MKaBqb3LMZ3Q4uG5tM1WtUAdPheN9VXv/4lfXS4S7M2eYw6CJ1AlfKarD/3zIHR43w6nkQwL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555842; c=relaxed/simple;
	bh=w6sYV/AUyf270NsloBcksa9+y2sFqJCpbebqaVD1ai0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRZHuEbwaUtBMjodGr2kLNuz8ZitAjpiDeyLXQIQKeL1/aHBWGROV/1x05t/iZPcnbbD5EIRbQ0Z/YESxDKLvpM/XdEZKvFmUtN5rL+YuL4Jk/lLLRUh+hqHMyiobIaLn438QCgii/fYR/aJOZY9nFWwz3AmfFHPyMQMzA0ciK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1uBQOYOZ; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee974e230so16074325e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 01:30:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768555836; cv=none;
        d=google.com; s=arc-20240605;
        b=PEg6LieFAZamvNyyxEbI1jRQ3dUSSEQ0l7VjXBoCSsih5p7JODwnZFkVzjb3/wADk3
         72s5G8VIzEAY37ZYCpCeZGRaYawkws+cnbvDNXnMXTTTqIr5ZHdpzYDNO8gPJn7o2IIm
         Opu8Xi4j2+F1md5P2CG3X343GeWHhWxG54oFy9R4y1UZgFojbcYi1jluUO+W4IKovqmM
         e6/XjQTsFwqPvQpl7xTgk4E75p0DcWe8SAE50pPzUOBpHreC5AKZdeuKWFjmecWLl7kq
         HveDVZlQ3q5zmVq7Y1iQVO1xN67F0U+0PeDcR1T6i0P2/XO0fdIVD/CHMVaxrN638zHO
         gXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OntQoz3I9EUsl3kN0fTTi6tO3SgZ8DSb/O0cRDbjxwQ=;
        fh=bUAloTkJUMVoPp+RbR7sHeVLbwTVOxpJTXItb06nQxY=;
        b=gjQH8XNSvYH7WwgmywXFm1V2EkhvRmNZvyIb7EjFByo3GoiTm83QEaYlDQoOBpKQ3Y
         mv1CONtvOt1yNuYMyW+EExf7Sdv0pjDxJNAGmPooOTd3v4mKlQL4HVyaTrfCbBRVYf5N
         B40C7cUcCqQAy+8iIv9uSNnQ4kQp6Q1o3eTFJi+NE91Gis5SmlyqdVkOBUEM7KubrNen
         YmIN9mqcfRWU2eOtfvWqcDA10drOFEDSlIAoULrE++vUiVklEWxJwh6gIIXTU0LioYU0
         2vmwfj+TELMinEdTh0rnb6zak4fsjMcNMMBs6PoDAW1sit+Axdoy/Mo7ts4k+abskOjs
         yTmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768555836; x=1769160636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OntQoz3I9EUsl3kN0fTTi6tO3SgZ8DSb/O0cRDbjxwQ=;
        b=1uBQOYOZKTWMyNuA58dPMJ0YH4JoF0uh7HDBHZHErMQWm9UTQcexdzh2yrpbBhi2iJ
         19UTiyDcK/tPbkH4AMZkS6c9R1A9ksQOqzvfUa52z3uWECg3stRu3DjT0ITdNWtuDs0W
         x8lLyBVxM8h1X/sexWgKniC/vrdmwPu0xXxMc1fdESoI57M+3NP7xQ6EzJLiyWoAd3TH
         lfbz7YUWc1/JdQRlGCvPkNTCUcOAmN/nNxyIL/gRn9lt1bsTxrn/1FXqlPptmyoGziwM
         2ZCfY1d+9SHGap8JGRTMuM2OhLIsg2Cj2nDg2y6a7eLbFSQRU/zAwusfThkwGfTxrou7
         sRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768555836; x=1769160636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OntQoz3I9EUsl3kN0fTTi6tO3SgZ8DSb/O0cRDbjxwQ=;
        b=o6qhRyruOOOU35LK9volDXGKB037lTJWwGubckw6H84PBvipupCho9frEdrI+WRdgh
         94s691fc0UG1oMuJ5iiWwPP4qnQuimp+p8GOyPo+dkznnm2HOXauGRlINg0AHwOu9JTr
         N2SCS41negD9MYh7laopiN8pdkujXqZrmiPSfVmofeLSXb9WCKcSHWoY9HSxqVrUV3BX
         l1c0SmzIISoB2m4F1QBOJwIM9HrW4faF+ZvIbobFMD1ZDXnj/kcUDboqapWalngojJO2
         ghkwnu+14DhuaFOGhIrg0FUws55cQSrnxYxQYEh6JASUhCpTcyvWnu5NoqoH6Lw2OP53
         QENg==
X-Forwarded-Encrypted: i=1; AJvYcCXuGCpI9zfLlpZ0CjSD3X+lpZL0LfApPtxDmaYmCTpOSiDD4/nE49kb4g5XAthSYNZbQvvhKlzxFvrQwh1wlK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIDAUJrNnW7TRTJjvPxsVb0QSYk0C/OVpicyYYhwENrtDHjqk
	VG+oDBBlazL6sd17ExViHxvQPOFPKCoWsDgeQKb/BibwfxuJIt6ojFcvHsrHhueMVRtoqFK/Ns/
	HbEVDAuJTEwgV4ulom3EYoemmJBYm1gZydyIHZ9q/
X-Gm-Gg: AY/fxX49V1M6HIwYz48ebROFvI/cpB3ggnDC/tdkutWf5jkbba/YAm4Mt/X1bzBifei
	J+A7nRcmtbJJvmVOqPwgFc7Bl7nItHU3rPJftm9KQ7aOLVHYO9pfTJivJA3EXf+H9T0bLDptngt
	pSPHaXDmujPEc+/83nvrn5grLfmSES+WVGDUghfPSvfGLsIHWcEZia3oo8tPDbXhQs6Uk56Wc5U
	ulAiTJPORxsW1VOI+5RGWcCPZ21qP4L2NlD7HYoL8aQYzyBL8FSstQiE5cYKSUBU1CWnQ==
X-Received: by 2002:a05:6000:2988:10b0:431:808:2d32 with SMTP id
 ffacd0b85a97d-43569972f16mr1760851f8f.7.1768555835970; Fri, 16 Jan 2026
 01:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
In-Reply-To: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 16 Jan 2026 17:30:22 +0800
X-Gm-Features: AZwV_QhfntKzWRKn8eedZ2ZfHJTcL48vYxb_AbvQqRBtGp1aNuBGm3qt5xljFg0
Message-ID: <CABVgOS=Yn3K+Xzq_3tb0LCrX2eJjU5AG38uMwHaa21nXfxsjEQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: add bash completion
To: Ryota Sakamoto <sakamo.ryota@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000679d7e06487dfe13"

--000000000000679d7e06487dfe13
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 22:54, Ryota Sakamoto <sakamo.ryota@gmail.com> wrote:
>
> Currently, kunit.py has many subcommands and options, making it difficult
> to remember them without checking the help message.
>
> Add --list-cmds and --list-opts to kunit.py to get available commands and
> options, use those outputs in kunit-completion.sh to show completion.
>
> This implementation is similar to perf and tools/perf/perf-completion.sh.
>
> Example output:
>   $ source tools/testing/kunit/kunit-completion.sh
>   $ ./tools/testing/kunit/kunit.py [TAB][TAB]
>   build   config  exec    parse   run
>   $ ./tools/testing/kunit/kunit.py run --k[TAB][TAB]
>   --kconfig_add  --kernel_args  --kunitconfig
>
> Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
> ---

This is awesome!

Two small suggestions:
- Could we add './tools/testing/kunit/kunit.py' to the list of
commands? That's what's recommended in lots of documentation, emails,
etc.
- It'd be great to rebase this on top of kselftest/kunit -- there's a
conflict with your previous patch.

Otherwise, this is great!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/run_wrapper.rst |  9 ++++++++
>  tools/testing/kunit/kunit-completion.sh       | 33 +++++++++++++++++++++++++++
>  tools/testing/kunit/kunit.py                  | 30 ++++++++++++++++++++++++
>  tools/testing/kunit/kunit_tool_test.py        | 21 +++++++++++++++++
>  4 files changed, 93 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index 6697c71ee8ca020b8ac7e91b46e29ab082d9dea0..3c0b585dcfffbd3929d0eef1ab9376fa4f380872 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -335,3 +335,12 @@ command line arguments:
>
>  - ``--list_tests_attr``: If set, lists all tests that will be run and all of their
>    attributes.
> +
> +Command-line completion
> +==============================
> +
> +The kunit_tool comes with a bash completion script:
> +
> +.. code-block:: bash
> +
> +       source tools/testing/kunit/kunit-completion.sh
> diff --git a/tools/testing/kunit/kunit-completion.sh b/tools/testing/kunit/kunit-completion.sh
> new file mode 100644
> index 0000000000000000000000000000000000000000..3b9b68e3bc384c026f10f74b8a1df2129cb2cd50
> --- /dev/null
> +++ b/tools/testing/kunit/kunit-completion.sh
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# bash completion support for KUnit
> +
> +_kunit_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
> +
> +_kunit()
> +{
> +       local cur prev words cword
> +       _init_completion || return
> +
> +       local script="${_kunit_dir}/kunit.py"
> +
> +       if [[ $cword -eq 1 && "$cur" != -* ]]; then
> +               local cmds=$(${script} --list-cmds 2>/dev/null)
> +               COMPREPLY=($(compgen -W "${cmds}" -- "$cur"))
> +               return 0
> +       fi
> +
> +       if [[ "$cur" == -* ]]; then
> +               if [[ -n "${words[1]}" && "${words[1]}" != -* ]]; then
> +                       local opts=$(${script} ${words[1]} --list-opts 2>/dev/null)
> +                       COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
> +                       return 0
> +               else
> +                       local opts=$(${script} --list-opts 2>/dev/null)
> +                       COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
> +                       return 0
> +               fi
> +       fi
> +}
> +
> +complete -o default -F _kunit kunit.py
> +complete -o default -F _kunit kunit

Can we add:
complete -o default -F _kunit  ./tools/testing/kunit/kunit.py

as well?

> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index cd99c1956331dbbfb06cf4ddf130db3dcf2a7c31..a5aee1eb88e65fa2387b2623642d2ee9a66db600 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -323,6 +323,17 @@ def get_default_jobs() -> int:
>                 return ncpu
>         raise RuntimeError("os.cpu_count() returned None")
>
> +def add_completion_opts(parser: argparse.ArgumentParser) -> None:
> +       parser.add_argument('--list-opts',
> +                           help=argparse.SUPPRESS,
> +                           action='store_true')
> +
> +def add_root_opts(parser: argparse.ArgumentParser) -> None:
> +       parser.add_argument('--list-cmds',
> +                           help=argparse.SUPPRESS,
> +                           action='store_true')
> +       add_completion_opts(parser)
> +
>  def add_common_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--build_dir',
>                             help='As in the make command, it specifies the build '
> @@ -374,6 +385,8 @@ def add_common_opts(parser: argparse.ArgumentParser) -> None:
>                             help='Additional QEMU arguments, e.g. "-smp 8"',
>                             action='append', metavar='')
>
> +       add_completion_opts(parser)
> +
>  def add_build_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
> @@ -569,6 +582,7 @@ subcommand_handlers_map = {
>  def main(argv: Sequence[str]) -> None:
>         parser = argparse.ArgumentParser(
>                         description='Helps writing and running KUnit tests.')
> +       add_root_opts(parser)
>         subparser = parser.add_subparsers(dest='subcommand')
>
>         # The 'run' command will config, build, exec, and parse in one go.
> @@ -603,12 +617,28 @@ def main(argv: Sequence[str]) -> None:
>         parse_parser.add_argument('file',
>                                   help='Specifies the file to read results from.',
>                                   type=str, nargs='?', metavar='input_file')
> +       add_completion_opts(parse_parser)
>
>         cli_args = parser.parse_args(massage_argv(argv))
>
>         if get_kernel_root_path():
>                 os.chdir(get_kernel_root_path())
>
> +       if cli_args.list_cmds:
> +               print(" ".join(subparser.choices.keys()))
> +               return
> +
> +       if cli_args.list_opts:
> +               target_parser = subparser.choices.get(cli_args.subcommand)
> +               if not target_parser:
> +                       target_parser = parser
> +
> +               # Accessing private attribute _option_string_actions to get
> +               # the list of options. This is not a public API, but argparse
> +               # does not provide a way to inspect options programmatically.
> +               print(' '.join(target_parser._option_string_actions.keys()))
> +               return
> +
>         subcomand_handler = subcommand_handlers_map.get(cli_args.subcommand, None)
>
>         if subcomand_handler is None:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bbba921e0eacb18663abfcabb2bccf330d8666f5..a7f09a6c97a473ff85e087d17c2f5faf7755b994 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -11,11 +11,13 @@ from unittest import mock
>
>  import tempfile, shutil # Handling test_tmpdir
>
> +import io
>  import itertools
>  import json
>  import os
>  import signal
>  import subprocess
> +import sys
>  from typing import Iterable
>
>  import kunit_config
> @@ -855,5 +857,24 @@ class KUnitMainTest(unittest.TestCase):
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', filter='', filter_action=None, timeout=300),
>                 ])
>
> +       @mock.patch.object(sys, 'stdout', new_callable=io.StringIO)
> +       def test_list_cmds(self, mock_stdout):
> +               kunit.main(['--list-cmds'])
> +               output = mock_stdout.getvalue()
> +               output_cmds = sorted(output.split())
> +               expected_cmds = sorted(['build', 'config', 'exec', 'parse', 'run'])
> +               self.assertEqual(output_cmds, expected_cmds)
> +
> +       @mock.patch.object(sys, 'stdout', new_callable=io.StringIO)
> +       def test_run_list_opts(self, mock_stdout):
> +               kunit.main(['run', '--list-opts'])
> +               output = mock_stdout.getvalue()
> +               output_cmds = set(output.split())
> +               self.assertIn('--help', output_cmds)
> +               self.assertIn('--kunitconfig', output_cmds)
> +               self.assertIn('--jobs', output_cmds)
> +               self.assertIn('--kernel_args', output_cmds)
> +               self.assertIn('--raw_output', output_cmds)
> +
>  if __name__ == '__main__':
>         unittest.main()
>
> ---
> base-commit: b71e635feefc852405b14620a7fc58c4c80c0f73
> change-id: 20260114-kunit-completion-265889f59c52
>
> Best regards,
> --
> Ryota Sakamoto <sakamo.ryota@gmail.com>
>

--000000000000679d7e06487dfe13
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgDUWk8rEMZgpcEMAO3/v+59ldsjga
qfYEdnoViiZtLO0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTE2MDkzMDM2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAkdKfpvd/lmCz0a4D82FKAiM60g0fAIodYpbhWZ41BPFlbkoMtue7QC+A/jd2VaaU
ZtytmeQAKYip5FXb4No6VAhZoHRI/WhQOHI076YVjXr40EVSr8TJZtbq76JHzt/V+kGzafpZ9CgV
BDUdA6/cxEnWQd6JOQbi5WdUPq0hz76oPYaUktMbV3cywdCToOcHc5r2b7GjNAcptebiwgRn7C5L
Dc38nXoHe/2JqEWrgQ2QZISPLR2bBEBoZ0JFNlxvxn22mgcBqJPOJG9Ad20kjTVOicVwvbNeuY+R
vNX1BY6x2SJ7bYPol7nBRAtUopiS0kNlbbQqG4ux7w/8vI1EiQ==
--000000000000679d7e06487dfe13--

