Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F73816AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 May 2021 09:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhEOH7e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 May 2021 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhEOH7d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 May 2021 03:59:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8DC061756
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 00:58:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so20708wmf.5
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SL2vqvXzqdCjd9kP5QudZx9jKMtEwDxxzaTafMUA1n4=;
        b=uYcfChCCOqtOqkH7/k7AjJdN7pC2S1+0KKfrd+K75UZwJYdYQGdF4zdEPKOVV61T8f
         PeMJ8j8G2BqNYV2vsbivb9FAneH5ujAYAHrVCcnOrMBHXr/NMQRAD7TfGST32hiaJ/rV
         nVncuvvoc7Bj6eFvPvFkVgf1RH9zM6k7+jTR0tCHN3hVfMBri3xOMSL4Ch0GfhgJNPNk
         UxSI3RdwPCOkOI76MijdEg5iFTeZpSIIZsn3mkTiCme+BULRCzajeYo04gwdSG/FllhB
         hgKAGENYi50ma7lyT4KVVvHHJ1wIufRtbLw9eOJoWpV8wNaoMC0iqrc8H+/Ex9iaUOOP
         x7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SL2vqvXzqdCjd9kP5QudZx9jKMtEwDxxzaTafMUA1n4=;
        b=XRvg+j2DGeW23/n24spZQrl6cf5lh/ax3OgzpeKByprQRCUtiiwC71Zi4wdq7caxcP
         yihkOzvBmdW4EDddKiT2j1840ajIt2H8XdqXUwAITC+t5lNGqIP9HM9FB0z80bAakEHP
         2FH+HFo0lG3TieJ91o3GEt0dc+Xs3DAvAE2nzV/sh40BIcNur3SYN3OloKnd8D8VIEr3
         XkEOI7fRCrM5W891vveeY5Bsi8PRQ0yYZDa2CwjCQXvr+UAB79CDFjKcaH1j7FPizM/H
         vpzbPXb2gOCGmuAqnUitmWh9X93idZDVH1aMRAS2POmFzCS6UchlnZk9X2+MsIHu6fgy
         XwKA==
X-Gm-Message-State: AOAM53266zFCs7cThNxQdiZbHavshpmjfdH66apCl6I4He4vlLKHmw9b
        si0h/lm25Vg3W8ioVlmUCms0LOwbDXPtuWsJL9mMXg9W9I35+w==
X-Google-Smtp-Source: ABdhPJxZSjlEs4lhOYcHSFP7XeWXGYCEwWe+6Moyq+QxDgwX95Df9Ate+/s2uq7owzYjUJZ5YoV5U+mypVQs+z+Vz/s=
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr13326454wme.151.1621065499581;
 Sat, 15 May 2021 00:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com> <20210507213110.155492-2-brendanhiggins@google.com>
In-Reply-To: <20210507213110.155492-2-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 May 2021 15:58:08 +0800
Message-ID: <CABVgOS=3ToE-w8PT_p_xqxqs4AR_a4u4LwFAFE-TrMtEEySG=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] kunit: Add 'kunit_shutdown' option
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000046e3af05c259b9f0"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000046e3af05c259b9f0
Content-Type: text/plain; charset="UTF-8"

On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> From: David Gow <davidgow@google.com>
>
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-By: Daniel Latypov <dlatypov@google.com>
> ---

Obviously I'm okay with this change, but I did find a minor whitespace
nitpick below.

>  lib/kunit/executor.c                | 20 ++++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 15832ed446685..7db619624437c 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/reboot.h>
>  #include <kunit/test.h>
>  #include <linux/glob.h>
>  #include <linux/moduleparam.h>
> @@ -18,6 +19,9 @@ module_param(filter_glob, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
>                 "Filter which KUnit test suites run at boot-time, e.g. list*");
>
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
>  static struct kunit_suite * const *
>  kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
>  {
> @@ -82,6 +86,20 @@ static struct suite_set kunit_filter_suites(void)
>         return filtered;
>  }
>
> +static void kunit_handle_shutdown(void)
> +{
> +       if (!kunit_shutdown)
> +               return;
> +
> +       if (!strcmp(kunit_shutdown, "poweroff"))
> +               kernel_power_off();
> +       else if (!strcmp(kunit_shutdown, "halt"))
> +               kernel_halt();
> +       else if (!strcmp(kunit_shutdown, "reboot"))
> +               kernel_restart(NULL);
> +
> +}
> +
>  static void kunit_print_tap_header(struct suite_set *suite_set)
>  {
>         struct kunit_suite * const * const *suites, * const *subsuite;
> @@ -112,6 +130,8 @@ int kunit_run_all_tests(void)
>                 kfree(suite_set.start);
>         }
>
> +       kunit_handle_shutdown();
> +
>         return 0;
>  }
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 89a7d4024e878..e22ade9d91ad5 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -208,7 +208,7 @@ class LinuxSourceTree(object):
>         def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
>                 if not args:
>                         args = []
> -               args.extend(['mem=1G', 'console=tty'])
> +               args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
Nit: space here between 'console=tty', and 'kunit_shutdown=halt'.


>                 if filter_glob:
>                         args.append('kunit.filter_glob='+filter_glob)
>                 self._ops.linux_bin(args, timeout, build_dir)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index e8bcc139702e2..8d8d4d70b39dd 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -49,7 +49,7 @@ class TestStatus(Enum):
>
>  kunit_start_re = re.compile(r'TAP version [0-9]+$')
>  kunit_end_re = re.compile('(List of all partitions:|'
> -                         'Kernel panic - not syncing: VFS:)')
> +                         'Kernel panic - not syncing: VFS:|reboot: System halted)')
>
>  def isolate_kunit_output(kernel_output) -> Iterator[str]:
>         started = False
> --
> 2.31.1.607.g51e8a6a459-goog
>

--00000000000046e3af05c259b9f0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB5j5li
TSYzMqxVRnyFvHZkg/R4+g5YVXPnETZiA4RyfDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA1MTUwNzU4MTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEADu6p9jMgHkqpMJdw1K54ONWR
/C6KGOTzrWTLGD1B2r0P28GCzCHBRL8MzM5aENGnVA48XPgJJZZw2YfIuz5QmpAOSJRqMhYin/Tb
8KFxJ3B4WYmvxGAwnllHRKknE42KcCI3UWvdhdP1Ihf2jFSfPX/M26S0DRFocfegSejtEI+kBdUO
crRYM3T+vlGTYHKd4upcCBey6wEX7oIW6r/bFztv0m3J30GfCheEJGdr/fT7tH40l8VVOXjhIOLG
KaW4XqI6xjtHAGJPCR1rDNr2f5k1a9VZ+pirZ+NUgP5qsACcyvzW5ZuXhn4DQBNAJlLhPKfTObYq
ww0+Vtbk5FO9HQ==
--00000000000046e3af05c259b9f0--
