Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C190964529F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 04:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLGDns (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 22:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLGDnp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 22:43:45 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9951CB57
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 19:43:43 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id 97so5656803uam.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5poCNn0ZYnIBK8HtDg1QpowuuOSdQyeWrpAEHCBQkuQ=;
        b=X+7qp9Ic6n2opixQPB0R3o+MEcxmsPpxqqFEp1cAscCcJj2q8ecuDQxozFlXhqY7Ae
         StG7nVX/tnZifDJXUEOUzaP9yLjEUjzyJ5zoCQuQc2LvGcO0syAaTfDFCVv4RVBDk7JG
         ioWWedExUuxQjbxyTeA4cKVVqXvu1J70A0+SKbupZZZV0kwwTu/ee2M+1fNxRqfTEEze
         nBsbnYt6Ki3+/8OlZBrbrH8o//wpQQGpRrQlxctoBqjp9Ozcin+yChDn+Y1E+6iXt6Pn
         aeghqsrDkgeXRjTQjlFAqzBbl/GC8LF6uYG70slk5Hb8ezaXRM8klyQhCSt0ktUs7Lrt
         vk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5poCNn0ZYnIBK8HtDg1QpowuuOSdQyeWrpAEHCBQkuQ=;
        b=sbQ/Ksft9vhujP/En1GjDNhAC1esZUFw9xIRplfsnjZvfNV1gLbkclZ6biHxXMIrX/
         aeaIaWaJcf9AwJZqMWnHutjjTPyyIj7iZ/WN5lRc5Lnp0BKirUWVvZqOPSytVeOp935s
         u28faUlc7Q+IK84YG/cNaIh7XLaHxtC9ghcyeFZPnOUI+8k5SU00rWLYplV+LQMn2uPH
         g2X6+lkUxhCIl36123aIxNv76m1NuchUFgzcUWbhuo1S+yhdRAqplndvRCOFWJ6S7ILL
         jIc922RiAqEaJQFNstgasUncRjVg7oZHfvGp/cE6Pl7VKAnKi2uKd0SYyCIx7bKms7rQ
         KFLQ==
X-Gm-Message-State: ANoB5pk0Leu2qWdlCJu9XWvWjWXGfqbpF1OQE0f4qF/iDVFsbRnF3w/k
        ea7e1pUYSpUN/Df1MVt7ACfqPALgqaxRY/avgdjL8w==
X-Google-Smtp-Source: AA0mqf6sklV7YR6WTKjIDRJijy4i01TVd+/k09s6PNC/+tgdSO1vDdORhvElloknpxEjTQcYNPD7wXD2EcbeuA7D+Xc=
X-Received: by 2002:ab0:7028:0:b0:419:e6:4af6 with SMTP id u8-20020ab07028000000b0041900e64af6mr29654866ual.52.1670384622594;
 Tue, 06 Dec 2022 19:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20221130185419.2552673-1-dlatypov@google.com>
In-Reply-To: <20221130185419.2552673-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 7 Dec 2022 11:43:31 +0800
Message-ID: <CABVgOSm_J878tGhWzvGa_y4fYZEUDrSaZN49=kKnn0W7ESe2wA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make parser preserve whitespace when
 printing test log
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001709cb05ef34ba8f"
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

--0000000000001709cb05ef34ba8f
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 1, 2022 at 2:54 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Currently, kunit_parser.py is stripping all leading whitespace to make
> parsing easier. But this means we can't accurately show kernel output
> for failing tests or when the kernel crashes.
>
> Embarassingly, this affects even KUnit's own output, e.g.
> [13:40:46] Expected 2 + 1 == 2, but
> [13:40:46] 2 + 1 == 3 (0x3)
> [13:40:46] not ok 1 example_simple_test
> [13:40:46] [FAILED] example_simple_test
>
> After this change, here's what the output in context would look like
> [13:40:46] =================== example (4 subtests) ===================
> [13:40:46] # example_simple_test: initializing
> [13:40:46] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> [13:40:46] Expected 2 + 1 == 2, but
> [13:40:46]     2 + 1 == 3 (0x3)
> [13:40:46] [FAILED] example_simple_test
> [13:40:46] [SKIPPED] example_skip_test
> [13:40:46] [SKIPPED] example_mark_skipped_test
> [13:40:46] [PASSED] example_all_expect_macros_test
> [13:40:46]     # example: initializing suite
> [13:40:46] # example: pass:1 fail:1 skip:2 total:4
> [13:40:46] # Totals: pass:1 fail:1 skip:2 total:4
> [13:40:46] ===================== [FAILED] example =====================
>
> This example shows one minor cosmetic defect this approach has.
> The test counts lines prevent us from dedenting the suite-level output.
> But at the same time, any form of non-KUnit output would do the same
> unless it happened to be indented as well.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I agree that this is a good idea.

Personally, I think we could avoid some of the 'dedent' issues by
disabling the test statistics lines when run via kunit.py (if
raw_output is not enabled). That's probably better as a separate
patch, though, so this looks good to go.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py           |  2 +-
>  tools/testing/kunit/kunit_parser.py    | 27 +++++++++++++-------------
>  tools/testing/kunit/kunit_tool_test.py |  2 ++
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e7b6549712d6..43fbe96318fe 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -202,7 +202,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                 if request.raw_output == 'all':
>                         pass
>                 elif request.raw_output == 'kunit':
> -                       output = kunit_parser.extract_tap_lines(output, lstrip=False)
> +                       output = kunit_parser.extract_tap_lines(output)
>                 for line in output:
>                         print(line.rstrip())
>                 parse_time = time.time() - parse_start
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 99b8f058db40..a225799f6b1b 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -13,6 +13,7 @@ from __future__ import annotations
>  from dataclasses import dataclass
>  import re
>  import sys
> +import textwrap
>
>  from enum import Enum, auto
>  from typing import Iterable, Iterator, List, Optional, Tuple
> @@ -208,12 +209,12 @@ class LineStream:
>
>  # Parsing helper methods:
>
> -KTAP_START = re.compile(r'KTAP version ([0-9]+)$')
> -TAP_START = re.compile(r'TAP version ([0-9]+)$')
> -KTAP_END = re.compile('(List of all partitions:|'
> +KTAP_START = re.compile(r'\s*KTAP version ([0-9]+)$')
> +TAP_START = re.compile(r'\s*TAP version ([0-9]+)$')
> +KTAP_END = re.compile(r'\s*(List of all partitions:|'
>         'Kernel panic - not syncing: VFS:|reboot: System halted)')
>
> -def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
> +def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
>         """Extracts KTAP lines from the kernel output."""
>         def isolate_ktap_output(kernel_output: Iterable[str]) \
>                         -> Iterator[Tuple[int, str]]:
> @@ -239,11 +240,8 @@ def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
>                                 # stop extracting KTAP lines
>                                 break
>                         elif started:
> -                               # remove the prefix and optionally any leading
> -                               # whitespace. Our parsing logic relies on this.
> +                               # remove the prefix, if any.
>                                 line = line[prefix_len:]
> -                               if lstrip:
> -                                       line = line.lstrip()
>                                 yield line_num, line
>         return LineStream(lines=isolate_ktap_output(kernel_output))
>
> @@ -298,7 +296,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
>         lines.pop()
>         return True
>
> -TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
> +TEST_HEADER = re.compile(r'^\s*# Subtest: (.*)$')
>
>  def parse_test_header(lines: LineStream, test: Test) -> bool:
>         """
> @@ -322,7 +320,7 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
>         lines.pop()
>         return True
>
> -TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
> +TEST_PLAN = re.compile(r'^\s*1\.\.([0-9]+)')
>
>  def parse_test_plan(lines: LineStream, test: Test) -> bool:
>         """
> @@ -350,9 +348,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
>         lines.pop()
>         return True
>
> -TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
> +TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
>
> -TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
> +TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
>
>  def peek_test_name_match(lines: LineStream, test: Test) -> bool:
>         """
> @@ -511,8 +509,9 @@ def print_test_header(test: Test) -> None:
>
>  def print_log(log: Iterable[str]) -> None:
>         """Prints all strings in saved log for test in yellow."""
> -       for m in log:
> -               stdout.print_with_timestamp(stdout.yellow(m))
> +       formatted = textwrap.dedent('\n'.join(log))
> +       for line in formatted.splitlines():
> +               stdout.print_with_timestamp(stdout.yellow(line))
>
>  def format_test_result(test: Test) -> str:
>         """
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 1ef921ac4331..0c2190514103 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -336,12 +336,14 @@ class KUnitParserTest(unittest.TestCase):
>                 KTAP version 1
>                 1..1
>                   Test output.
> +                   Indented more.
>                 not ok 1 test1
>                 """
>                 result = kunit_parser.parse_run_tests(output.splitlines())
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
>
>                 self.print_mock.assert_any_call(StrContains('Test output.'))
> +               self.print_mock.assert_any_call(StrContains('  Indented more.'))
>                 self.noPrintCallContains('not ok 1 test1')
>
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
>
> base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221130185419.2552673-1-dlatypov%40google.com.

--0000000000001709cb05ef34ba8f
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAG
KwPA66sM05FsqPgvQdH9ARPUWLeimeXcH0mpVwTPBjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMDcwMzQzNDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAA8jdtAoUs+HO9gZeHmiY
S2M8/slIVJsduTIUPWXViQJ1+pqZlcbS1VDkKG6v/SqedjyaykgJuNjKypCYxL3JAbARYzFMpCDp
qqAlMSLVc+mimHsz639rI9VuRspmg9UoVone5x3aRCW2cmPvfGx1Myd3Z5jataX6Q5/lk/uzq3KW
oOyrb2RnMeXGpsdojuuCqRIqdTeiBwUk708REo9LfiNIspz0wxijCIFNmMEZK5J1OPQHAdsFTBmH
lc/flnKaJX3wCI3WuPcTdYwDtA7RUUq6wiXevURartXIZWGhxeFuc7HGo0WF9R7Q8sLL5YWJcT32
cXQXtonZp2VQ3iU91A==
--0000000000001709cb05ef34ba8f--
