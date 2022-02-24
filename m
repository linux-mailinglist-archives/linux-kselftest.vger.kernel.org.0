Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950934C240E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 07:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiBXG1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 01:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiBXG1N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 01:27:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800C25CC
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:26:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j17so1417663wrc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D50ZR/WdGoZqxTELDMt4mSXfS93JdtQW34WfX/73k0s=;
        b=ZsFFEvJxk1rCBaAYs9YiGkKAiLXpMEirxeBFcGOpRlZGNNfcDHZvc0Vjt5DdkjZOSm
         KQcZhfEK0eNvhz7KZzsDygtLLhX+MbWpYdGCtfgkPj5aKb+yphEV6IEokFeEmk3rkVrU
         jAB3LvpQaPNzV+R0GxXNEy5+Ueim1wSDFsI39XPvb3HTUEINAqRgS2Zz4Lr01YNZvji0
         Ub7Gsey5RgKdsk4GrKGKS6P/tEc6ZRu6eVC7EcIvnnjOfCRyPJbHK5vEvgog633eMPX+
         XfzCiC2ynQwYzk/ZXXQUSHWb+EIjgawCQ/SM2cAQnxKKKUIVE0m3AlPlLJRanr0cp3Gl
         Sh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D50ZR/WdGoZqxTELDMt4mSXfS93JdtQW34WfX/73k0s=;
        b=0ejtbgPuY1g6ppgpKq1q0xzSdsnBLyREDZBYBVBvkcWk5x9GzHXNhvu6UzvYHxuO6K
         d5SNVqZVctVI52MMP0jwYqxWfZCiOetLQdEsTBjzv0B3VXHqQ2QmOmzKpK0BIOQUs3Vc
         WFVlV0jpCXMwySsIa6B2DtxNj4jR0XDEmRRooKqpJepa72LFp/+5au8cp8/1PxVOCLSa
         YKpXNjdrzuIORqL9RJkP0r8lpQs4sBV1bjHe68JQVJIIIgHIx1sD8FJCs03cK+9uuCEI
         uZzRtuVq6cXC0tqP0k/8EU5v7L6VuQQ/y1h4BqLNLWhTMZ4JM/g99FtY7uXj8LSk98sh
         SWkQ==
X-Gm-Message-State: AOAM530zC95CIZjpInosSos99GwkiOwvrVTRvVsLjkLZBJfz6H/XxGOc
        h+H12NCrnxydj/MDGCpB3b6map6rn4Yg98gSU/tyjg==
X-Google-Smtp-Source: ABdhPJzC8Giz2wiCWShDAJ3Q4xF084oOC/NH4Ybaxg6U2Vn5atxKRheJ88JSsPMrTFOZ/Dmsm4Xbb6HfJs27r68ZDOM=
X-Received: by 2002:a05:6000:186d:b0:1e8:49fc:69ce with SMTP id
 d13-20020a056000186d00b001e849fc69cemr947417wri.80.1645684001411; Wed, 23 Feb
 2022 22:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com> <20220217205227.4098452-2-dlatypov@google.com>
In-Reply-To: <20220217205227.4098452-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Feb 2022 14:26:30 +0800
Message-ID: <CABVgOSk9kCm=-C4HWdNHUdRJtPxxV0pL0=TN9vFWpwN+PHzSLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: refactor how we plumb metadata into JSON
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000570cda05d8bdaa77"
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

--000000000000570cda05d8bdaa77
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 18, 2022 at 4:52 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> When using --json, kunit.py run/exec/parse will produce results in
> KernelCI json format.
> As part of that, we include the build_dir that was used, and we
> (incorrectly) hardcode in the arch, etc.
>
> We'll want a way to plumb more values (as well as the correct `arch`),
> so this patch groups those fields into kunit_json.Metadata type.
> This patch should have no user visible changes.
>
> And since we only used build_dir in KunitParseRequest for json, we can
> now move it out of that struct and add it into KunitExecRequest, which
> needs it and used to get it via inheritance.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This is much nicer, thanks.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  tools/testing/kunit/kunit.py           | 16 +++++++-------
>  tools/testing/kunit/kunit_json.py      | 29 ++++++++++++++++++--------
>  tools/testing/kunit/kunit_tool_test.py |  9 ++++----
>  3 files changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 4cb91d191f1d..7dd6ed42141f 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -47,11 +47,11 @@ class KunitBuildRequest(KunitConfigRequest):
>  @dataclass
>  class KunitParseRequest:
>         raw_output: Optional[str]
> -       build_dir: str
>         json: Optional[str]
>
>  @dataclass
>  class KunitExecRequest(KunitParseRequest):
> +       build_dir: str
>         timeout: int
>         alltests: bool
>         filter_glob: str
> @@ -153,6 +153,8 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                                 test_glob = request.filter_glob.split('.', maxsplit=2)[1]
>                                 filter_globs = [g + '.'+ test_glob for g in filter_globs]
>
> +       metadata = kunit_json.Metadata(build_dir=request.build_dir)
> +
>         test_counts = kunit_parser.TestCounts()
>         exec_time = 0.0
>         for i, filter_glob in enumerate(filter_globs):
> @@ -165,7 +167,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                         filter_glob=filter_glob,
>                         build_dir=request.build_dir)
>
> -               _, test_result = parse_tests(request, run_result)
> +               _, test_result = parse_tests(request, metadata, run_result)
>                 # run_kernel() doesn't block on the kernel exiting.
>                 # That only happens after we get the last line of output from `run_result`.
>                 # So exec_time here actually contains parsing + execution time, which is fine.
> @@ -189,7 +191,7 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
>         else:
>                 return KunitStatus.TEST_FAILURE
>
> -def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
> +def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
>         parse_start = time.time()
>
>         test_result = kunit_parser.Test()
> @@ -216,8 +218,7 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
>         if request.json:
>                 json_str = kunit_json.get_json_result(
>                                         test=test_result,
> -                                       def_config='kunit_defconfig',
> -                                       build_dir=request.build_dir)
> +                                       metadata=metadata)
>                 if request.json == 'stdout':
>                         print(json_str)
>                 else:
> @@ -504,10 +505,11 @@ def main(argv, linux=None):
>                 else:
>                         with open(cli_args.file, 'r', errors='backslashreplace') as f:
>                                 kunit_output = f.read().splitlines()
> +               # We know nothing about how the result was created!
> +               metadata = kunit_json.Metadata()
>                 request = KunitParseRequest(raw_output=cli_args.raw_output,
> -                                           build_dir='',
>                                             json=cli_args.json)
> -               result, _ = parse_tests(request, kunit_output)
> +               result, _ = parse_tests(request, metadata, kunit_output)
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
>         else:
> diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> index 14a480d3308a..0a7e29a315ed 100644
> --- a/tools/testing/kunit/kunit_json.py
> +++ b/tools/testing/kunit/kunit_json.py
> @@ -6,6 +6,7 @@
>  # Copyright (C) 2020, Google LLC.
>  # Author: Heidi Fahim <heidifahim@google.com>
>
> +from dataclasses import dataclass
>  import json
>  import os
>
> @@ -14,6 +15,13 @@ import kunit_parser
>  from kunit_parser import Test, TestStatus
>  from typing import Any, Dict
>
> +@dataclass
> +class Metadata:
> +       """Stores metadata about this run to include in get_json_result()."""
> +       arch: str = 'UM'
> +       def_config: str = 'kunit_defconfig'
> +       build_dir: str = ''
> +
>  JsonObj = Dict[str, Any]
>
>  _status_map: Dict[TestStatus, str] = {
> @@ -22,14 +30,13 @@ _status_map: Dict[TestStatus, str] = {
>         TestStatus.TEST_CRASHED: "ERROR",
>  }
>
> -def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
> +def _get_group_json(test: Test, common_fields: JsonObj) -> JsonObj:
>         sub_groups = []  # List[JsonObj]
>         test_cases = []  # List[JsonObj]
>
>         for subtest in test.subtests:
>                 if subtest.subtests:
> -                       sub_group = _get_group_json(subtest, def_config,
> -                               build_dir)
> +                       sub_group = _get_group_json(subtest, common_fields)
>                         sub_groups.append(sub_group)
>                         continue
>                 status = _status_map.get(subtest.status, "FAIL")
> @@ -37,19 +44,23 @@ def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
>
>         test_group = {
>                 "name": test.name,
> -               "arch": "UM",
> -               "defconfig": def_config,
> -               "build_environment": build_dir,
>                 "sub_groups": sub_groups,
>                 "test_cases": test_cases,
> +       }
> +       test_group.update(common_fields)
> +       return test_group
> +
> +def get_json_result(test: Test, metadata: Metadata) -> str:
> +       common_fields = {
> +               "arch": metadata.arch,
> +               "defconfig": metadata.def_config,
> +               "build_environment": metadata.build_dir,
>                 "lab_name": None,
>                 "kernel": None,
>                 "job": None,
>                 "git_branch": "kselftest",
>         }
> -       return test_group
>
> -def get_json_result(test: Test, def_config: str, build_dir: str) -> str:
> -       test_group = _get_group_json(test, def_config, build_dir)
> +       test_group = _get_group_json(test, common_fields)
>         test_group["name"] = "KUnit Test Group"
>         return json.dumps(test_group, indent=4)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index a3c036a620b2..60806994683c 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -468,8 +468,7 @@ class KUnitJsonTest(unittest.TestCase):
>                         test_result = kunit_parser.parse_run_tests(file)
>                         json_obj = kunit_json.get_json_result(
>                                 test=test_result,
> -                               def_config='kunit_defconfig',
> -                               build_dir='.kunit')
> +                               metadata=kunit_json.Metadata())
>                 return json.loads(json_obj)
>
>         def test_failed_test_json(self):
> @@ -691,7 +690,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
>
>                 got = kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'suite'))
>
>                 self.assertEqual(got, want)
>                 # Should respect the user's filter glob when listing tests.
> @@ -706,7 +705,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*.test*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*.test*', None, 'suite'))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
> @@ -719,7 +718,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'test'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'test'))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
> --
> 2.35.1.473.g83b2b277ed-goog
>

--000000000000570cda05d8bdaa77
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCL
/lyXfaRPY7Bx8/EEnZKE7YhArRiQ9RERoeR02WEulTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjQwNjI2NDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAekTAmPAIFzIKZJenZvHM
//VGctWQ4446/drjTYyFvx0yCdWnzhC2/OZXTHUu0lmjBxjEojiikd+xsCGMuBlEpQFjIE3RQPFk
Ra4v3ZUHmAZ9NdKy9D1zUvMT9FZSZ19Wb3/lTKup2mkOl9XoyKt8B+zMSlesN/SC/meXs4eMj9wG
aYdLIPbz50je1c/YS9zk2pnDWYRcHMYaufOrS1Q0w0otjzudpVR+7IRj2AkN3QY5c4FWROBla6/f
erVhJf6w/WX5J6a//CFM/MFb858ftrS2h2Y/R0h2OBc2dPU53g0V9y7nTVWaTaEFO0pTrI9+Mk5D
Y2GlQl3/MAKMJKY6ww==
--000000000000570cda05d8bdaa77--
