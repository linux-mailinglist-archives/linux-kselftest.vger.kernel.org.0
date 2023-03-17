Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFAF6BE0CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 06:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCQFux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 01:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQFux (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 01:50:53 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3267019
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 22:50:41 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id x14so3555524vso.9
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679032240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1TdgtGtQnI7Fcq9FdiCbp7EdqdSwRhoi6Bg1VFKPwE=;
        b=aTwUgVIUvPVsOrcFG9z9n4WsFG6pJURJXNJCx+ND0KC+hMnQsAEVrP7Y/7F+/O+pzI
         PhCLZBVScFcUQ/7ZbtZ94zHie0CArmitKU1ZsWzumWeE7UjzGmVvRfNlErIZr+0Bx1ks
         C1fBOoTn31cPvZXn1ZfhBmAuA3Y53c8v8c+RYHwPfZ79uXWvjezNyg4Z2GOrqVfidrSo
         vDPXFAErtPaxfKmu0e90sw2CqS5HtxdVeGB59/DHXMEvYYYUzUdDIBONnXOIO41cSi3U
         hW9bUSsS7KCxDFpg90qiFfhZbkefwaGKaRUazIuLmY/gvlC2dqNRdzgnaYEKpwU+iWPN
         6QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679032240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1TdgtGtQnI7Fcq9FdiCbp7EdqdSwRhoi6Bg1VFKPwE=;
        b=ETBJvunlJMOqn3XzTWhbMT2sdp9vVeYIx5v0c0Nr5CPCHGUlf+2GmbR2BBjBTaF+mD
         oBgVEaEtm7G4aEvKRToVphxCzV1Cxr/mjrEWmfnUh8FtfCgudLuEU1KIcv+xgfMWyxFP
         Dy3JSPRRw2ryoHWsXmSV/hTt/wJI/BXTZkGVwH+G+NcdE96HXwQfsZt3BltzOCajjVXJ
         z60r+rYckxXYcDXFkHgdhDUFmWyy5lhydcRWKe6R7yturWCuzkLhn5J9tFAE+++a9+oE
         1kjahy9ighzxB/aa38PuMVwG9Hn/nivdoAUvCBY8XPa6FxCbK9j0PTbUZPWU+OHAiDJ/
         qcaQ==
X-Gm-Message-State: AO0yUKUZYACb1+ve1dGVzWv2OEbVz1Tkj+R65vXgvDMvTVIx2jn3SaoB
        +A9k0JUFvcS4FSa2VD2bnqpJaeGOijYTdOS6X+65Yg==
X-Google-Smtp-Source: AK7set/pknchOt6GCI5H8Bu87UK8KURx1NUaIfY4InP1m65Sx/uf0WqoAiGuY2ibGFJc+IPlfQGXQM7+P4WyMRSfTYk=
X-Received: by 2002:a67:b748:0:b0:425:bbc6:aa64 with SMTP id
 l8-20020a67b748000000b00425bbc6aa64mr5428301vsh.5.1679032240378; Thu, 16 Mar
 2023 22:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230316220638.983743-1-dlatypov@google.com> <20230316220638.983743-3-dlatypov@google.com>
In-Reply-To: <20230316220638.983743-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 17 Mar 2023 13:50:29 +0800
Message-ID: <CABVgOSn12OvyrmpED5Q5PEPfHCZNc1dqgct9m0L-TjNGMnwA5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: tool: fix pre-existing `mypy --strict`
 errors and update run_checks.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net, Johannes Berg <johannes.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000494e5505f7122829"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000494e5505f7122829
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Mar 2023 at 06:06, Daniel Latypov <dlatypov@google.com> wrote:
>
> Basically, get this command to be happy and make run_checks.py happy
>  $ mypy --strict --exclude '_test.py$' --exclude qemu_configs/ ./tools/testing/kunit/
>
> Primarily the changes are
> * add `-> None` return type annotations
> * add all the missing argument type annotations
>
> Previously, we had false positives from mypy in `main()`, see commit
> 09641f7c7d8f ("kunit: tool: surface and address more typing issues").
> But after commit 2dc9d6ca52a4 ("kunit: kunit.py extract handlers")
> refactored things, the variable name reuse mypy hated is gone.
>
> Note: mypy complains we don't annotate the types the unused args in our
> signal handler. That's silly.
> But to make it happy, I've copy-pasted an appropriate annotation from
> https://github.com/python/typing/discussions/1042#discussioncomment-2013595.
>
> Reported-by: Johannes Berg <johannes.berg@intel.com>
> Link: https://lore.kernel.org/linux-kselftest/9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net/
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

While I suspect we're pretty rapidly approaching the point of
diminishing returns with some of these (like the signal handler
annotation), I don't think there's any real harm in fixing them and
enabling strict mode.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit.py        | 24 ++++++++++++------------
>  tools/testing/kunit/kunit_config.py |  4 ++--
>  tools/testing/kunit/kunit_kernel.py | 29 +++++++++++++++--------------
>  tools/testing/kunit/run_checks.py   |  4 ++--
>  4 files changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 52853634ba23..3905c43369c3 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -269,7 +269,7 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
>  def get_default_jobs() -> int:
>         return len(os.sched_getaffinity(0))
>
> -def add_common_opts(parser) -> None:
> +def add_common_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--build_dir',
>                             help='As in the make command, it specifies the build '
>                             'directory.',
> @@ -320,13 +320,13 @@ def add_common_opts(parser) -> None:
>                             help='Additional QEMU arguments, e.g. "-smp 8"',
>                             action='append', metavar='')
>
> -def add_build_opts(parser) -> None:
> +def add_build_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
>                             'jobs (commands) to run simultaneously."',
>                             type=int, default=get_default_jobs(), metavar='N')
>
> -def add_exec_opts(parser) -> None:
> +def add_exec_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--timeout',
>                             help='maximum number of seconds to allow for all tests '
>                             'to run. This does not include time taken to build the '
> @@ -351,7 +351,7 @@ def add_exec_opts(parser) -> None:
>                             type=str,
>                             choices=['suite', 'test'])
>
> -def add_parse_opts(parser) -> None:
> +def add_parse_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
>                             'By default, filters to just KUnit output. Use '
>                             '--raw_output=all to show everything',
> @@ -386,7 +386,7 @@ def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree
>                         extra_qemu_args=qemu_args)
>
>
> -def run_handler(cli_args):
> +def run_handler(cli_args: argparse.Namespace) -> None:
>         if not os.path.exists(cli_args.build_dir):
>                 os.mkdir(cli_args.build_dir)
>
> @@ -405,7 +405,7 @@ def run_handler(cli_args):
>                 sys.exit(1)
>
>
> -def config_handler(cli_args):
> +def config_handler(cli_args: argparse.Namespace) -> None:
>         if cli_args.build_dir and (
>                         not os.path.exists(cli_args.build_dir)):
>                 os.mkdir(cli_args.build_dir)
> @@ -421,7 +421,7 @@ def config_handler(cli_args):
>                 sys.exit(1)
>
>
> -def build_handler(cli_args):
> +def build_handler(cli_args: argparse.Namespace) -> None:
>         linux = tree_from_args(cli_args)
>         request = KunitBuildRequest(build_dir=cli_args.build_dir,
>                                         make_options=cli_args.make_options,
> @@ -434,7 +434,7 @@ def build_handler(cli_args):
>                 sys.exit(1)
>
>
> -def exec_handler(cli_args):
> +def exec_handler(cli_args: argparse.Namespace) -> None:
>         linux = tree_from_args(cli_args)
>         exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
>                                         build_dir=cli_args.build_dir,
> @@ -450,10 +450,10 @@ def exec_handler(cli_args):
>                 sys.exit(1)
>
>
> -def parse_handler(cli_args):
> +def parse_handler(cli_args: argparse.Namespace) -> None:
>         if cli_args.file is None:
> -               sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
> -               kunit_output = sys.stdin
> +               sys.stdin.reconfigure(errors='backslashreplace')  # type: ignore
> +               kunit_output = sys.stdin  # type: Iterable[str]
>         else:
>                 with open(cli_args.file, 'r', errors='backslashreplace') as f:
>                         kunit_output = f.read().splitlines()
> @@ -475,7 +475,7 @@ subcommand_handlers_map = {
>  }
>
>
> -def main(argv):
> +def main(argv: Sequence[str]) -> None:
>         parser = argparse.ArgumentParser(
>                         description='Helps writing and running KUnit tests.')
>         subparser = parser.add_subparsers(dest='subcommand')
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 9f76d7b89617..eb5dd01210b1 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -8,7 +8,7 @@
>
>  from dataclasses import dataclass
>  import re
> -from typing import Dict, Iterable, List, Tuple
> +from typing import Any, Dict, Iterable, List, Tuple
>
>  CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
>  CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
> @@ -34,7 +34,7 @@ class Kconfig:
>         def __init__(self) -> None:
>                 self._entries = {}  # type: Dict[str, str]
>
> -       def __eq__(self, other) -> bool:
> +       def __eq__(self, other: Any) -> bool:
>                 if not isinstance(other, self.__class__):
>                         return False
>                 return self._entries == other._entries
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 775842b912d8..a3321a991f11 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -16,6 +16,7 @@ import shutil
>  import signal
>  import threading
>  from typing import Iterator, List, Optional, Tuple
> +from types import FrameType
>
>  import kunit_config
>  import qemu_config
> @@ -56,7 +57,7 @@ class LinuxSourceTreeOperations:
>         def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>                 return base_kunitconfig
>
> -       def make_olddefconfig(self, build_dir: str, make_options) -> None:
> +       def make_olddefconfig(self, build_dir: str, make_options: Optional[List[str]]) -> None:
>                 command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, 'olddefconfig']
>                 if self._cross_compile:
>                         command += ['CROSS_COMPILE=' + self._cross_compile]
> @@ -70,7 +71,7 @@ class LinuxSourceTreeOperations:
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> -       def make(self, jobs, build_dir: str, make_options) -> None:
> +       def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
>                 command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
>                 if make_options:
>                         command.extend(make_options)
> @@ -132,7 +133,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         """An abstraction over command line operations performed on a source tree."""
>
> -       def __init__(self, cross_compile=None):
> +       def __init__(self, cross_compile: Optional[str]=None):
>                 super().__init__(linux_arch='um', cross_compile=cross_compile)
>
>         def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> @@ -215,7 +216,7 @@ def _get_qemu_ops(config_path: str,
>
>         if not hasattr(config, 'QEMU_ARCH'):
>                 raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
> -       params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
> +       params: qemu_config.QemuArchParams = config.QEMU_ARCH
>         if extra_qemu_args:
>                 params.extra_qemu_params.extend(extra_qemu_args)
>         return params.linux_arch, LinuxSourceTreeOperationsQemu(
> @@ -229,10 +230,10 @@ class LinuxSourceTree:
>               build_dir: str,
>               kunitconfig_paths: Optional[List[str]]=None,
>               kconfig_add: Optional[List[str]]=None,
> -             arch=None,
> -             cross_compile=None,
> -             qemu_config_path=None,
> -             extra_qemu_args=None) -> None:
> +             arch: Optional[str]=None,
> +             cross_compile: Optional[str]=None,
> +             qemu_config_path: Optional[str]=None,
> +             extra_qemu_args: Optional[List[str]]=None) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
>                 if qemu_config_path:
>                         self._arch, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
> @@ -275,7 +276,7 @@ class LinuxSourceTree:
>                 logging.error(message)
>                 return False
>
> -       def build_config(self, build_dir: str, make_options) -> bool:
> +       def build_config(self, build_dir: str, make_options: Optional[List[str]]) -> bool:
>                 kconfig_path = get_kconfig_path(build_dir)
>                 if build_dir and not os.path.exists(build_dir):
>                         os.mkdir(build_dir)
> @@ -303,7 +304,7 @@ class LinuxSourceTree:
>                 old_kconfig = kunit_config.parse_file(old_path)
>                 return old_kconfig != self._kconfig
>
> -       def build_reconfig(self, build_dir: str, make_options) -> bool:
> +       def build_reconfig(self, build_dir: str, make_options: Optional[List[str]]) -> bool:
>                 """Creates a new .config if it is not a subset of the .kunitconfig."""
>                 kconfig_path = get_kconfig_path(build_dir)
>                 if not os.path.exists(kconfig_path):
> @@ -319,7 +320,7 @@ class LinuxSourceTree:
>                 os.remove(kconfig_path)
>                 return self.build_config(build_dir, make_options)
>
> -       def build_kernel(self, jobs, build_dir: str, make_options) -> bool:
> +       def build_kernel(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> bool:
>                 try:
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                         self._ops.make(jobs, build_dir, make_options)
> @@ -328,7 +329,7 @@ class LinuxSourceTree:
>                         return False
>                 return self.validate_config(build_dir)
>
> -       def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
> +       def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', timeout: Optional[int]=None) -> Iterator[str]:
>                 if not args:
>                         args = []
>                 if filter_glob:
> @@ -339,7 +340,7 @@ class LinuxSourceTree:
>                 assert process.stdout is not None  # tell mypy it's set
>
>                 # Enforce the timeout in a background thread.
> -               def _wait_proc():
> +               def _wait_proc() -> None:
>                         try:
>                                 process.wait(timeout=timeout)
>                         except Exception as e:
> @@ -365,6 +366,6 @@ class LinuxSourceTree:
>                         waiter.join()
>                         subprocess.call(['stty', 'sane'])
>
> -       def signal_handler(self, unused_sig, unused_frame) -> None:
> +       def signal_handler(self, unused_sig: int, unused_frame: Optional[FrameType]) -> None:
>                 logging.error('Build interruption occurred. Cleaning console.')
>                 subprocess.call(['stty', 'sane'])
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> index 61cece1684df..8208c3b3135e 100755
> --- a/tools/testing/kunit/run_checks.py
> +++ b/tools/testing/kunit/run_checks.py
> @@ -23,7 +23,7 @@ commands: Dict[str, Sequence[str]] = {
>         'kunit_tool_test.py': ['./kunit_tool_test.py'],
>         'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
>         'pytype': ['/bin/sh', '-c', 'pytype *.py'],
> -       'mypy': ['/bin/sh', '-c', 'mypy *.py'],
> +       'mypy': ['mypy', '--strict', '--exclude', '_test.py$', '--exclude', 'qemu_configs/', '.'],
>  }
>
>  # The user might not have mypy or pytype installed, skip them if so.
> @@ -73,7 +73,7 @@ def main(argv: Sequence[str]) -> None:
>                 sys.exit(1)
>
>
> -def run_cmd(argv: Sequence[str]):
> +def run_cmd(argv: Sequence[str]) -> None:
>         subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=TIMEOUT)
>
>
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>

--000000000000494e5505f7122829
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDq
lnG8A/HN+S7BsbuHpVxtvvBwMKdppdOe0y4SfwpfSjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMTcwNTUwNDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAsI+10/1b2n9RZPTZ2JTb
o9UY2Vm+GfwheNfq8xL081MX8/XhtKhymtXE43MVQb/+gKGLRYrjblAhteK51W0JrWxIrlzKbmPO
uTTKvLS2ysRmzytsmOXQFuIZdhVkGP60r586lwC0cPtkYqq98kKBZVjWn9U8b+hmXpOCHkcN6arg
Qv5Vu5ECHDqi4WK6b09moZe8ou4057zfB7OmgYUZDPUkRhhem+JkMIFK4/pSp/JEmE4F0BWcOTfM
sNS57jy2Op5O3mu4LGFmJe4y9IJgRk3tylvBdzsQbiEBI4JK3VFCkcAJbViv87tpGpz+rDYusIIg
VkKPtsDEwVgM0+4/Kw==
--000000000000494e5505f7122829--
