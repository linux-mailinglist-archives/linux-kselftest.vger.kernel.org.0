Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC9612721
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 04:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ3DbQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3DbP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 23:31:15 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213C46D91
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Oct 2022 20:31:13 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 3so8477294vsh.5
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Oct 2022 20:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FYx9BuSkD3biD9oEGRo91/JJMds1MHru8rbjhRVb2T0=;
        b=TUO4K17nL/T9D8TxkEryUfiZ//zeSX119r18rcPvNVi4LbIDJr8tBjNLFiQP5t2de/
         1iGNOQcjRjpxn5Zl2tOEyu0Sfyrec3vXQrTjXPXi4E2QuAAsKC6qiNgPgtfZcuUz1BhR
         GNC+AP9PV/ZIxOccomYs+SWGk85vgqNyCalObHAMqKJdBH0DIsZ7ZqxzsMzBsL9WGpWw
         +q/9zXG3PitU5Eq2FAZxMWy/cyPs6RnBFXpk8U/QTc9qHbpuuSTL33lW5VrhnjW0l+tu
         eLfMPpqaTAM31aKLHfJMoZMT865+3rHD6aQ+TbZzZ27a86p3SAdzz+chiSQVJslyRLOr
         R9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYx9BuSkD3biD9oEGRo91/JJMds1MHru8rbjhRVb2T0=;
        b=DAmDTXqM9T1rDLFY4ZiHJpb7rDyzAnQgXLjNPx6wP94dmEWYBEUPOzPPd8u4fIUNJK
         0C6xU1i3gPlf7PV8jiYFNwrR9E1prqMXlWhulv0+E54HE3uTrjPAvn5Br9VLdF3TusZU
         nIamduGj3q/eiCAbxMpkLCZ86W6sBvVui6JTccN4C1Xrah74E3ckHebtSjc0MiSWHcNf
         gNrRp7JKQ8bGZi0nQV3T+CG390zfHVnsqwtzsUYUB+BOeT7gjeP/dQZyRWg1dBsCE3O+
         yvmYUsd39AhlHUMrgRbTF88qylvuowVFKgNgBXuG98iI6Hce05S/hDmrIY/M+lzU8euy
         NU4w==
X-Gm-Message-State: ACrzQf0YoSfz0us9MHEaDimc6hOyLaoau4gTMkI240MC8ex3yyASliXM
        X9Kl6v22/nsh5Va0iPogHXwD9vULwa5gVHVIqjs4NA==
X-Google-Smtp-Source: AMsMyM5kx7g+1XTgh54N1pWeneWGRG+yfMHypplxhY2W1ZkhiIk85rRNpts+1Y8lAqMudx4LzNKNyCtj2ew2clCBNp8=
X-Received: by 2002:a67:d20b:0:b0:3aa:52e6:9802 with SMTP id
 y11-20020a67d20b000000b003aa52e69802mr2338573vsi.35.1667100672812; Sat, 29
 Oct 2022 20:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221028210256.3776835-1-dlatypov@google.com>
In-Reply-To: <20221028210256.3776835-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sun, 30 Oct 2022 11:31:01 +0800
Message-ID: <CABVgOS=uAVc_nKRFYRiQtWFykyfWH6hWASK-yd+ZnH5UNmRgsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: make unit test not print parsed testdata
 to stdout
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006cea3a05ec381fa6"
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

--0000000000006cea3a05ec381fa6
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 29, 2022 at 5:03 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, if you run
> $ ./tools/testing/kunit/kunit_tool_test.py
> you'll see a lot of output from the parser as we feed it testdata.
>
> This makes the output hard to read and fairly confusing, esp. since our
> testdata includes example failures, which get printed out in red.
>
> Silence that output so real failures are easier to see.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks -- this has been annoying me for ages.

That being said, this isn't a perfect fix, the "usage" text and
"Reconfiguring .config"  still show up for me:
---
davidgow@slicestar:~/Development/linux-kselftest$
./tools/testing/kunit/kunit_tool_test.py
..............................usage: kunit_tool_test.py run [-h]
[--build_dir DIR] [--make_options X=Y] [--alltests] [--kunitconfig
PATHS] [--kconfig_add CONFIG_X=Y] [--arch ARCH] [--cross_compile
PREFIX] [--qemu_config FILE] [--qemu_ar
gs] [--jobs N]
                             [--timeout SECONDS] [--kernel_args]
[--run_isolated {suite,test}] [--raw_output [{all,kunit}]] [--json
[FILE]]
                             [filter_glob]
kunit_tool_test.py run: error: argument --raw_output: invalid choice:
'invalid' (choose from 'all', 'kunit')
..............................Generating .config ...
.Regenerating .config ...
.........
----------------------------------------------------------------------
Ran 70 tests in 0.232s

OK
---

That's still a significant improvement on what we had before, though, so:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_tool_test.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index e2cd2cc2e98f..a6e53945656e 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -80,6 +80,9 @@ class KconfigTest(unittest.TestCase):
>                 self.assertEqual(actual_kconfig, expected_kconfig)
>
>  class KUnitParserTest(unittest.TestCase):
> +       def setUp(self):
> +               self.print_mock = mock.patch('kunit_printer.Printer.print').start()
> +               self.addCleanup(mock.patch.stopall)
>
>         def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
>                 # Clone the iterator so we can print the contents on failure.
> @@ -485,6 +488,9 @@ class LinuxSourceTreeTest(unittest.TestCase):
>
>
>  class KUnitJsonTest(unittest.TestCase):
> +       def setUp(self):
> +               self.print_mock = mock.patch('kunit_printer.Printer.print').start()
> +               self.addCleanup(mock.patch.stopall)
>
>         def _json_for(self, log_file):
>                 with open(test_data_path(log_file)) as file:
>
> base-commit: 8f8b51f7d5c8bd3a89e7ea87aed2cdaa52ca5ba4
> --
> 2.38.1.273.g43a17bfeac-goog
>

--0000000000006cea3a05ec381fa6
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCu
dMEw1BIPsg8ftz0X6aTpMFn8qzQVXgrBqcz/twO9sjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMzAwMzMxMTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAopFyFx8CJeuCw4W58VRW
pemzoFh2T1Um45RQwHVsBKpMOD/7DvpXbuf7LWk6LUhaD09fBUMAtGsucvHnehq1aWLw6dMpoYZt
AeCO7xP0FjA0JGhIOMzF7ItxDUmqVRY0WwDcGD5XDOPHxTc0N4JymcILWIWSXnTt4gkj42uzORVa
Iochwo39X1q7LoEsV/Sti08HOtYmHwUM1b3QKSg35NTVgHMW+vZ+NJflLaCeyr0l6AvEG+4683gh
Q7lx9X8Goxifuv4xUnGDf1xXcbG0mn/J46uNP2DDMTEmtbQs3w+EzD8SChaQvt+MvLlZMj2RmvDN
lUBxsWdBfYUJI/6G/Q==
--0000000000006cea3a05ec381fa6--
