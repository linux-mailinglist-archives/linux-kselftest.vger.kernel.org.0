Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E56BE0B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 06:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCQFqA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 01:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQFp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 01:45:58 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C62BF17
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 22:45:56 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o32so3550507vsv.12
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679031955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=foSYZOI6ac8T7ySsmnW1w6nWE5bDx6RiSNHtPZxaXJU=;
        b=UAXvzGb3Gy8QzyEMaZY5Ye1FXsRhRw7hYZEW1THHVDuQZQxDgz3mZ+zxkC8r922na+
         DBZMohtG2VpPllI1MKVRFEfTl1QfAZYGBZ70vtSczQa87c8nuwP7dhtGuBB8Qw6HJDvc
         Q4dSBG01JlcdrW952AywZqS7RNOYqn9VdJvGO2rPDNBks56U4D7PmA5z8eELhwVKYqNK
         3GKczjDF6nZsE/f03LPcPdvyO+rdBvBb2q9qwN1t9JSs1o+caKj6x0e+xKELxM8pFkZN
         r+gk7CLJXC+iuB9slj9T4PIVE1ekkV5+4iUVBznQ3bZdKv0S/VGSWVMOUa15pDoVeUvq
         G8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679031955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foSYZOI6ac8T7ySsmnW1w6nWE5bDx6RiSNHtPZxaXJU=;
        b=M8n1iZJdJGmwh9at03nkcT0tALUkC7D04Vqm0uX6pky0n04RREM7f8p8vuZV4Se2OS
         ySBKKXmsZv8shu0LkpbOlNa13XNMzHiwuRzZEGgrG6ZyLjSd9HDCjn3DV3592xpfq08l
         HKXv2D6sRdExvHnmK8hLqVaoVLyzmrgMmxe8cFjXIvAJi8VGy+5eFyvnMFj6rAHLNAKt
         JyHt/uOkeN+HM+GWc/ciLXuoLuC10+YwKyCl5b9Aud5upZ+mUzjF2snUDsoIMFeEiWcr
         twu6TkbssjyxBVuKXQRaSBxjjs/HcXJvyDpFCiuBNUFhyKkLsivjqebhyc6kKEDLvBsd
         ghCw==
X-Gm-Message-State: AO0yUKX/eElAR48Qii0fqAnpePJANXKtUG1TeGAtZlsMh+6tGhCpdVzG
        QTBVMkkzBKrAsywsP/8Go07djqe0MmfOSTrqX/VD3A==
X-Google-Smtp-Source: AK7set90JJQbFJkQO4hcrHUk9LVi8ZNSMyQov5YcMecPr2OaLUAPFnBATLPixowinlqOdesGRu8JCP69D/1ULTTLCn8=
X-Received: by 2002:a05:6102:ed4:b0:421:c4a3:b607 with SMTP id
 m20-20020a0561020ed400b00421c4a3b607mr1458561vst.3.1679031955581; Thu, 16 Mar
 2023 22:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230316220638.983743-1-dlatypov@google.com>
In-Reply-To: <20230316220638.983743-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 17 Mar 2023 13:45:43 +0800
Message-ID: <CABVgOS=1WQ1m7-fFuPNZBQ+CbfnDofKQ-xcknqnSDgUFEsR7EA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: tool: add subscripts for type annotations
 where appropriate
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net, Johannes Berg <johannes.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004ceaf605f7121732"
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

--0000000000004ceaf605f7121732
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Mar 2023 at 06:06, Daniel Latypov <dlatypov@google.com> wrote:
>
> E.g. for subprocess.Popen, it can be opened in `text=True` mode where it
> returns strings, or `text=False` where it returns bytes.
> To differentiate, you can annotate types as `Popen[str]` or
> `Popen[bytes]`.
>
> This patch should add subscripts in all the places we were missing them.
>
> Reported-by: Johannes Berg <johannes.berg@intel.com>
> Link: https://lore.kernel.org/linux-kselftest/20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid/
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> Note: this is unchanged, just added a 3rd patch to this series.
> ---

Looks good.

Reviewed-by: David Gow <davidgow@google.com>

Thanks, Johannes and Daniel!

-- David

>  tools/testing/kunit/kunit_kernel.py  | 6 +++---
>  tools/testing/kunit/kunit_printer.py | 2 +-
>  tools/testing/kunit/run_checks.py    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 53e90c335834..e6fc8fcb071a 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -92,7 +92,7 @@ class LinuxSourceTreeOperations:
>                 if stderr:  # likely only due to build warnings
>                         print(stderr.decode())
>
> -       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
>                 raise RuntimeError('not implemented!')
>
>
> @@ -112,7 +112,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 kconfig.merge_in_entries(base_kunitconfig)
>                 return kconfig
>
> -       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
>                 kernel_path = os.path.join(build_dir, self._kernel_path)
>                 qemu_command = ['qemu-system-' + self._qemu_arch,
>                                 '-nodefaults',
> @@ -141,7 +141,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                 kconfig.merge_in_entries(base_kunitconfig)
>                 return kconfig
>
> -       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
>                 """Runs the Linux UML binary. Must be named 'linux'."""
>                 linux_bin = os.path.join(build_dir, 'linux')
>                 params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
> diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
> index 5f1cc55ecdf5..015adf87dc2c 100644
> --- a/tools/testing/kunit/kunit_printer.py
> +++ b/tools/testing/kunit/kunit_printer.py
> @@ -15,7 +15,7 @@ _RESET = '\033[0;0m'
>  class Printer:
>         """Wraps a file object, providing utilities for coloring output, etc."""
>
> -       def __init__(self, output: typing.IO):
> +       def __init__(self, output: typing.IO[str]):
>                 self._output = output
>                 self._use_color = output.isatty()
>
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> index 066e6f938f6d..61cece1684df 100755
> --- a/tools/testing/kunit/run_checks.py
> +++ b/tools/testing/kunit/run_checks.py
> @@ -37,7 +37,7 @@ def main(argv: Sequence[str]) -> None:
>         if argv:
>                 raise RuntimeError('This script takes no arguments')
>
> -       future_to_name: Dict[futures.Future, str] = {}
> +       future_to_name: Dict[futures.Future[None], str] = {}
>         executor = futures.ThreadPoolExecutor(max_workers=len(commands))
>         for name, argv in commands.items():
>                 if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
>
> base-commit: 2c6a96dad5797e57b4cf04101d6c8d5c7a571603
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>

--0000000000004ceaf605f7121732
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB2
eyy/lX/gfLIGBw8fdCjBZb+v4jbvJA8Q5uWe+PIcnDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMTcwNTQ1NTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAojiaFw6vNQQX8ZUMXA7m
7G7SUpxyK1n4aUTL9Mt+QD2YtCHgrV02ep89Nq3iZ6DXTXe654/xgkmfVakH8oKW+Ywg72JW5fTM
g7Uzq+OgSy7N3stPdF6OFzk8LDa8OG2gyXolUH4CCB461GbwA6lDKW7q8Q9FqAPe76+wKxYpl4sf
1pFIEahsxc6NJjrmzGxEGSeG4jno1cW2DF2vTSAKjr3FXJGsk8mnVgPLVx3/PcZNFNsVHAungHXj
tJIuQTBs8U/js0kRn7Z0+X77bnQSl2LJR1TyseA6u2wCyIi91wQsmRTJIVzZoUUQsPzfUv5Ua7Ys
4gDojT6a2IsJDuMjmg==
--0000000000004ceaf605f7121732--
