Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252D66BE0BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 06:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCQFrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 01:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCQFrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 01:47:40 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDAA2BF15
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 22:47:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id c1so815524vsk.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679032055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqyMKVLiw5ozZTt6n8jJx/6bBTe2Tol2z3utiS2wWfI=;
        b=MpWRGZ9TA3O3Cv5IYXG3HADkhf0N+iXPDw+SP5SGyWRJuR9lq4qiyLkv7+BNuIrqsi
         NxSt4eogUmpfqEhECG4Sz2+9ZUd3qTCD7OFx4tUoVPFlsYVj9C5IUvE0o9zI5aLlb1Yn
         M3FjSIAVmk5xmEkcQdxxn2jrPDkK1kh6hQFy6Pa2po4VWDHZcZ8+m25O9lRae83CZug2
         m5iKwKyVmbt6b8ZiZYca+ObrLUhvehtnJodcV73rgbDTQ0TWRjwSYsS5aUg/NXkeMmoc
         Z+jHmr1uhQG61qhKScZ7rP84CyG8KCg1L1HkDULTzamYNxgK+jSDxY0XqYy6MM45FD+3
         cc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679032055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqyMKVLiw5ozZTt6n8jJx/6bBTe2Tol2z3utiS2wWfI=;
        b=er8bq3mvSJm260sCcWtpE3n3C5RmbbiBrzyUQcfUNxXajyVfVJsUJ1AYlPHqF7EqHW
         bCloxTlW0DUfTNInS7DO4SuvYKdwJ8+OsgWI4JIfaa2XKZv+ds7FmNp+mVPZnOhmvzar
         qEVsEZCn9HW69R2FLpfMUABO2ju1WKMogJRtnauBcHszDZwCQwS9VRafFpb9YYiQOoyn
         GNMcut0Whwn3WXLK3Ex198KrI96enKsQRPD2cBPiVPRnHuGvYsLE8GPy640H19XzLhj5
         gobPGxx8QRROwn9HqIBPv0lwYXj4f4ArniSsx6MMllQ+Nd9UKzBNL/JVnFz95OTInmI+
         XI3g==
X-Gm-Message-State: AO0yUKXhF/AxePFKFaCWwjpJAhBs0pmF1hGzA1ZvJhzGK9lPs6RfndZd
        ncJ9+4WVlwYgKOacH0dmWLNKbvWPMTu82E6WfTQeBA==
X-Google-Smtp-Source: AK7set9auaedY47x9XhulJotGnjmD3QCOlItuX1CQyuC/eJwFDMkCPLLKn0EzBIpDlClf+qwDO4fcUAgQ01bNid48/8=
X-Received: by 2002:a67:b748:0:b0:425:bbc6:aa64 with SMTP id
 l8-20020a67b748000000b00425bbc6aa64mr5424769vsh.5.1679032055357; Thu, 16 Mar
 2023 22:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230316220638.983743-1-dlatypov@google.com> <20230316220638.983743-2-dlatypov@google.com>
In-Reply-To: <20230316220638.983743-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 17 Mar 2023 13:47:24 +0800
Message-ID: <CABVgOSk3BOyNsV77YohgV5L8cN+j67m7PNa36HFhdb5vN2SRtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: tool: remove unused imports and variables
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003fdf0905f7121d2d"
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

--0000000000003fdf0905f7121d2d
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Mar 2023 at 06:06, Daniel Latypov <dlatypov@google.com> wrote:
>
> We don't run a linter regularly over kunit.py code (the default settings
> on most don't like kernel style, e.g. tabs) so some of these imports
> didn't get removed when they stopped being used.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

While personally, I don't lose sleep over the occasional unused
variable, these (and particularly the imports) seem sensible.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Note: this is unchanged, just added a 3rd patch to this series.
> ---
>  tools/testing/kunit/kunit.py           | 2 +-
>  tools/testing/kunit/kunit_config.py    | 2 +-
>  tools/testing/kunit/kunit_kernel.py    | 1 -
>  tools/testing/kunit/kunit_parser.py    | 1 -
>  tools/testing/kunit/kunit_tool_test.py | 2 +-
>  5 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 741f15420467..52853634ba23 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -123,7 +123,7 @@ def _suites_from_test_list(tests: List[str]) -> List[str]:
>                 parts = t.split('.', maxsplit=2)
>                 if len(parts) != 2:
>                         raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
> -               suite, case = parts
> +               suite, _ = parts
>                 if not suites or suites[-1] != suite:
>                         suites.append(suite)
>         return suites
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 48b5f34b2e5d..9f76d7b89617 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -8,7 +8,7 @@
>
>  from dataclasses import dataclass
>  import re
> -from typing import Dict, Iterable, List, Set, Tuple
> +from typing import Dict, Iterable, List, Tuple
>
>  CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
>  CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index e6fc8fcb071a..775842b912d8 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -18,7 +18,6 @@ import threading
>  from typing import Iterator, List, Optional, Tuple
>
>  import kunit_config
> -from kunit_printer import stdout
>  import qemu_config
>
>  KCONFIG_PATH = '.config'
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index a225799f6b1b..fbc094f0567e 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -12,7 +12,6 @@
>  from __future__ import annotations
>  from dataclasses import dataclass
>  import re
> -import sys
>  import textwrap
>
>  from enum import Enum, auto
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 0c2190514103..be35999bb84f 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -328,7 +328,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_parse_subtest_header(self):
>                 ktap_log = test_data_path('test_parse_subtest_header.log')
>                 with open(ktap_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       kunit_parser.parse_run_tests(file.readlines())
>                 self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
>
>         def test_show_test_output_on_failure(self):
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>

--0000000000003fdf0905f7121d2d
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBz
qgtaRvVmahVCeZq/8wMFZtfPpRIhv8K8iqswYvdloTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMTcwNTQ3MzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAA9T94saO5ApKMJv2QLsO
n/JOStodq0yYU9Ji7TgPchnbfyS9esYSbNZ41fFClXFvJ9M5OYk0viVGbF+0BtxHiJb6JKmp016W
R5Pw8AsL9at1Jeu7WGe0hXMnatfaiDBH2fNx6YcCf2ub1oF+ltJM3wtTHh8j7FyNMViKnauQTHY9
5pXLksrHothg8CmU+hHxYgweXrt4K0q20OQbkn+TH4zkamqWP+AnxdPwpUrz92VDOS82UbB6/xJ+
1hf9zdmuJB5Ew1C57MA2ny9hWuOxEM0aMUBRcjny2AwyRpIeVtsW7qIfWkh5hPyZ4X51NWD63DCh
XxTgY8QL8RVVmd8qHQ==
--0000000000003fdf0905f7121d2d--
