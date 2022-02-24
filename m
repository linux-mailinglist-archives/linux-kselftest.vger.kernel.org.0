Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59B24C2411
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 07:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiBXG1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 01:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiBXG1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 01:27:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3E8B7DC
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:26:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so1354666wrb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NL1FJiEW7xIyU+CCXWgQuZdx+KXm4C3VFTrdVsIyKxc=;
        b=qDLBOlimunSfCQ6RsZA49t9M6kdGd64RMHIhvMMzHZa3kpaWrndiGZ+FWGwyexMOs4
         DAazPGaT77q43UYhxqXJZ5Ox6RJVS2qnyr/7by6IE3cOmIFxl40x3HSuOBhVtdhSxP6l
         2+cKoV4OepxGkQ+qIOzqsBhSyWF308uzDsS8feCn75Y8rs5suxfaCTy6RV0xId0CGHW2
         P3VTVjSouThMPKWxCpBEp0dkL8CfpaYQQ7g1Kq3FubhgAUhcFZqLV5VJ+3mZpp/2kQ6h
         tQNdOqDlpw8kZ2OTNbxxtpakO/ZFvJHpaCqUCVr04zyWpuhoyyziz+WmjRrYX5o3lvj/
         uZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NL1FJiEW7xIyU+CCXWgQuZdx+KXm4C3VFTrdVsIyKxc=;
        b=LUlra9Jl0BHXwKeqPopCjY9flIZoI4HJoqPovXgyk2MymuV60d5DutbCbU1fwZuENN
         8f4eHDluohSE1gUXy/esc0Q3Zf9Sjihv5aKb7q+Bf+lEop2M1ijo27dAXH4s30tbM7e2
         eje0oLuwtuHdVY2mDfqREc9ZU5NYKyVd/g4ubiGoW8iBtqCIn0cYZhtfrsXsKEMXA5ud
         mMVd1iuri9hvLmxIusBy+x5w2RyQX8FpZrbYy+OCuRnJZwoXLYXf0gnh/bQjGIOuvzJD
         Ivvr7vh3LfHVarXJ/dhBEAXkXpg85eETf8thTp3SJ6NJOMWKxOVS3juIK8mtijKCTjsz
         simQ==
X-Gm-Message-State: AOAM533nm/HWZJnymUMeNo30HivwAYlFJsPgqoA6XZ5CoTDiNTByNovD
        EgjbARUSn6PYk5dItbdKMaIVuJ6/AfoONprSqt61GF/GrMA=
X-Google-Smtp-Source: ABdhPJyyP0xvWOK9mg2Xt+P13712OBJ8o0tX0rY7uOmJesWVq/8DjhNwQqf6631T1cXY1Eox8fGa2yNBtsYNe2yYph8=
X-Received: by 2002:adf:d1c9:0:b0:1ea:8b11:98a4 with SMTP id
 b9-20020adfd1c9000000b001ea8b1198a4mr930894wrd.220.1645684006544; Wed, 23 Feb
 2022 22:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com> <20220217205227.4098452-3-dlatypov@google.com>
In-Reply-To: <20220217205227.4098452-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Feb 2022 14:26:35 +0800
Message-ID: <CABVgOSmayxKsZYi36gbMWxExhE+=ae8PfFA_tbCGogPnwkw0gA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: properly report the used arch for
 --json, or '' if not known
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a3795905d8bdaafc"
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

--000000000000a3795905d8bdaafc
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 18, 2022 at 4:52 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before, kunit.py always printed "arch": "UM" in its json output, but...
> 1. With `kunit.py parse`, we could be parsing output from anywhere, so
>     we can't say that.
> 2. Capitalizing it is probably wrong, as it's `ARCH=um`
> 3. Commit 87c9c1631788 ("kunit: tool: add support for QEMU") made it so
>    kunit.py could knowingly run a different arch, yet we'd still always
>    claim "UM".
>
Agreed on all counts!

> This patch addresses all of those. E.g.
>
> 1.
> $ ./tools/testing/kunit/kunit.py parse .kunit/test.log --json | grep -o '"arch.*' | sort -u
> "arch": "",
>
> 2.
> $ ./tools/testing/kunit/kunit.py run --json | ...
> "arch": "um",
>
> 3.
> $ ./tools/testing/kunit/kunit.py run --json --arch=x86_64 | ...
> "arch": "x86_64",
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good, and works well here. One question/comment below, but in general:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py        | 4 ++--
>  tools/testing/kunit/kunit_kernel.py | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 7dd6ed42141f..5ccdafd4d5aa 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -153,7 +153,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                                 test_glob = request.filter_glob.split('.', maxsplit=2)[1]
>                                 filter_globs = [g + '.'+ test_glob for g in filter_globs]
>
> -       metadata = kunit_json.Metadata(build_dir=request.build_dir)
> +       metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir)
>
>         test_counts = kunit_parser.TestCounts()
>         exec_time = 0.0
> @@ -506,7 +506,7 @@ def main(argv, linux=None):
>                         with open(cli_args.file, 'r', errors='backslashreplace') as f:
>                                 kunit_output = f.read().splitlines()
>                 # We know nothing about how the result was created!
> -               metadata = kunit_json.Metadata()
> +               metadata = kunit_json.Metadata(arch='', build_dir='', def_config='')

Why do we explicitly pass empty strings in here, rather than making
the defaults correct for this case?


>                 request = KunitParseRequest(raw_output=cli_args.raw_output,
>                                             json=cli_args.json)
>                 result, _ = parse_tests(request, metadata, kunit_output)
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index fe159e7ff697..bbbe2ffe30b7 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -248,6 +248,8 @@ class LinuxSourceTree(object):
>                         kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
>                         self._kconfig.merge_in_entries(kconfig)
>
> +       def arch(self) -> str:
> +               return self._arch
>
>         def clean(self) -> bool:
>                 try:
> --
> 2.35.1.473.g83b2b277ed-goog
>

--000000000000a3795905d8bdaafc
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCx
J4+sjI0iHI+B1kLb+Ca5iDUlBZ/6wEfEurvRE3Ca/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjQwNjI2NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGFBl3224vPFhuecQA2eH
bpHQ3hVvswBBQpNLISeWKw93/cayVD5D7T/htKPelTRHATltE7cmK5t7VkA3h2aX1/hRx9tdHGO4
fqMETu4B+eKl0YuIDGCSJ2LjeIfHr7pOmygRtMdWG9tXq59p/pLI8si8BSMlP00csLqW6z4L/6SJ
yrm5UCPVqeOUI/gOqL+0vnFFOekSNwp578B1ih0fYqWgW5i8kNrsoU3xaQuOJ1caeuBkcU0pzF4q
ya+wai8bFYdDpR1HBK6rcoKW4lFKsPeW/p7I82Z1Mm3/YBVrrLTRrCiPLgAMM6iWITqbjYdBapd6
xWCuFfJAGN5lSFKakg==
--000000000000a3795905d8bdaafc--
