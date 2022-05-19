Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18752D3CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiESNU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiESNUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 09:20:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6122CC158
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:20:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r23so7180918wrr.2
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxP1eXpHQasxcKMjUUeYg5dj19GoGhUV86ktTTRRLSU=;
        b=JRKmS6W6QOug4DTeEWlwu6MTF1x0aWsEA0EdUm68SueWTVbY9igIcKxRjUaP5VJzHF
         FPeMjCViizxv5fXi8tbt7YmWqlGn3Q+fcumpJ38eqD31IbNy/GMeSznkgkkqwnxnusQQ
         TV8Jyh1XNcmIu1prfnbDkcvqPz0Hp/YVmddGiYjnIWEIItG4x29zYLWY+wFkoYyAjPCF
         K6zQ3ePHtAtclwr45scRhgCnURH1CN+D7L5UXDaVv/mZsL4yANFzCg06K0hblrE8cjrt
         bjwrj9K/mCGDz96INv/TKF4fCi87Poh/Um6oSxDXQet7lMswm5ldxxs3cc3G1WR7ypwX
         e2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxP1eXpHQasxcKMjUUeYg5dj19GoGhUV86ktTTRRLSU=;
        b=VoaA2/R0xOf32YLjzhOKKh30t/o7xuEwLR+b+6/MNhONwbrsd+Eswa9DEqX2y4DR7l
         XMC2WM4tgisxfZSv+RCC7JgAgoxl1wuMnOxzlvF4E5goA7Bv2JDCZzpAvo85JcGUKwyd
         6XarbN8TcGhggwSkzrKzTmaf+sK+rEQ47uCwM0jyBkM5nb8olEtpXpSwerT8NZBhmE2s
         ySPYSUyWOHH+lgYwmMFUcXBOn9hgQBTzTvVBs4c16gOjC1M9NDhoWkRvMzIHWuBA4tVT
         p2eZmGR4uxPjPN8Xcc8Ky3SQeuWga5DrmCYwAhVf7cgqBNgXs7qy+br5z7LXx0wFx+3d
         1Fsw==
X-Gm-Message-State: AOAM531+47S1I/Nl9LWjhFSqwtvvR4sVNedlzCNylNEUiJ6kw8dZXiyX
        vkZ1lUwPPd30c9UMymizkVRCGs9O3RsbEifnB6C79A==
X-Google-Smtp-Source: ABdhPJzaQubC/sn58boJYovlbx+y1unf0GOzD0AFuI4HZVFZnVaQRFF2urelyzN+BCaGVzayZxLfXLdwNuBQEVT8KB8=
X-Received: by 2002:a5d:6041:0:b0:20d:8e4:7bb8 with SMTP id
 j1-20020a5d6041000000b0020d08e47bb8mr4018587wrt.652.1652966418564; Thu, 19
 May 2022 06:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com> <20220518170124.2849497-3-dlatypov@google.com>
In-Reply-To: <20220518170124.2849497-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 19 May 2022 21:20:07 +0800
Message-ID: <CABVgOSmgxYtA0cudjHy130gMQAYBp27C8D_i2u3Zb+Jahd1toQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: simplify creating LinuxSourceTreeOperations
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
        boundary="0000000000003c34f205df5d3c04"
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

--0000000000003c34f205df5d3c04
Content-Type: text/plain; charset="UTF-8"

On Thu, May 19, 2022 at 1:01 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Drop get_source_tree_ops() and just call what used to be
> get_source_tree_ops_from_qemu_config() in both cases.
>
> Also rename the functions to have shorter names and add a "_" prefix to
> note they're not meant to be used outside this function.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  tools/testing/kunit/kunit_kernel.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 8bc8305ba817..e93f07ac0af1 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -178,19 +178,16 @@ def get_old_kunitconfig_path(build_dir: str) -> str:
>  def get_outfile_path(build_dir: str) -> str:
>         return os.path.join(build_dir, OUTFILE_PATH)
>
> -def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
> +def _default_qemu_config_path(arch: str) -> str:
>         config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
> -       if arch == 'um':
> -               return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
>         if os.path.isfile(config_path):
> -               return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
> +               return config_path
>
>         options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
>         raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
>
> -def get_source_tree_ops_from_qemu_config(config_path: str,
> -                                        cross_compile: Optional[str]) -> Tuple[
> -                                                        str, LinuxSourceTreeOperations]:
> +def _get_qemu_ops(config_path: str,
> +                 cross_compile: Optional[str]) -> Tuple[str, LinuxSourceTreeOperations]:
>         # The module name/path has very little to do with where the actual file
>         # exists (I learned this through experimentation and could not find it
>         # anywhere in the Python documentation).
> @@ -226,11 +223,14 @@ class LinuxSourceTree:
>               qemu_config_path=None) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
>                 if qemu_config_path:
> -                       self._arch, self._ops = get_source_tree_ops_from_qemu_config(
> -                                       qemu_config_path, cross_compile)
> +                       self._arch, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
>                 else:
>                         self._arch = 'um' if arch is None else arch
> -                       self._ops = get_source_tree_ops(self._arch, cross_compile)
> +                       if self._arch == 'um':
> +                               self._ops = LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
> +                       else:
> +                               qemu_config_path = _default_qemu_config_path(self._arch)
> +                               _, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
>
>                 if kunitconfig_path:
>                         if os.path.isdir(kunitconfig_path):
> --
> 2.36.1.124.g0e6072fb45-goog
>

--0000000000003c34f205df5d3c04
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCS
+4L4X841OFguBpDzYW6T3+kArPb2TgVQu00u9g6PhDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MTkxMzIwMTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAi+fKwkMOBkX9ie7pFvMY
WbzrQkSX+xiM1XbYVLXgNmycbwnmmDKXbZH7A+y5qfg4TYAAXa6xXNNAimSUesa9ycPVfI+SoW4S
618se3HPWJb4Vl1b4Flo1P2XIhVbGKLc0gztWuQz6/2Enrzy8Sba53XIFqlZ/pDgXL+6IMOq9G0U
y4KeZHfThnpWoOwT/bOfDQs5s5JQvfMPX6q+2z0ee94SClIx5RMEUwj3fhMyUqKQ1tOXMVWw+DqF
d4xXUPZ3NzRkjBh9J+4jJIDM8y5cPu1YY5iebRplsXfw8Y0QUCr8pO4JQRNUyzGPo6IgoP/03pWC
brSHtWEfvU8/vecI9Q==
--0000000000003c34f205df5d3c04--
