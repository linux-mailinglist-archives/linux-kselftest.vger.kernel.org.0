Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676C5758D90
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGSGP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 02:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGSGPx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 02:15:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839742110
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 23:15:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e55517de3so21024a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689747328; x=1692339328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSTlZdRlVAACC3bnjX7hW8lzChnuwC7IAJFOpqXr28Q=;
        b=s07HirVuYDnBOREsfuOay7B7/pJzCNqelNIu9Rir55GhNjrSjMNEVGQcPeno0Iahua
         iv29mzlpR+oGZismvyjKH+yA+/cVFcalgJkB02WKrsXoPqKw3SIlNzU8RNTsu0b6CP8X
         x83OG7eyaQvL2Zqrl9g7kjcO/rooq1op8n1Q3i43S81mOeiV8ybnKuqh51BEsqgQ0KqB
         DnqWeicwJV032uqFczlPH1ajtoDtNv4rKXKhBhAIO/FlUr3mf3hpS1KvxyJTq6kMTAwm
         jokb8HcI1qJwc6RvaKM34S7lE20Gyt0A8jNa0bH9XIiFn9fJuiKHfvREx67mDeSrfRxn
         5J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747328; x=1692339328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSTlZdRlVAACC3bnjX7hW8lzChnuwC7IAJFOpqXr28Q=;
        b=eGgIvi793+hRxFlbwfqDWlTkzWa/PplOU5GI2JIB2+as+ULc7ItdFkKOUIujMCFCWP
         /+mwh+JMLJE7Hk3xOmXow+YT36tOaiM1dBAJhQlZ0q2e6jhIA+W56kdYIXZ30fpaa/wh
         KFOODYsf5RqCTXw+149p9ZErubrRAp58OwCIrtuYgoVXspYCTTJePVcoLRbjjEan+H6b
         CjbWPBuQVM2lTcrBruGklUKvPTrWbhm4x7BT5XWQfE4z+yRw9QUkZoEwDKbQJtV8E6KJ
         G5LQqm82O742OmBo4fCaSE90eApU2DWbcIw4cN984+QZ/+JtKpRQq6GXp2i07dOEHRHi
         gDlQ==
X-Gm-Message-State: ABy/qLY92In/+0TIHTPhCacdspAd0JD6rtUbcgotdj4Qeok1iPJGs6wM
        D5XmvNIsGz2MlzNB8cnXHgvugqufq2QviEiJ/xN7iA==
X-Google-Smtp-Source: APBJJlH133wUxgyrdA/7qJZWYjm2Xbv2xO8/WlsRZE6rxJK9taCvIhXePuAkjEI8bFr5+PI2/WozZ6iYQjRND2XJBnw=
X-Received: by 2002:a50:8e02:0:b0:51e:5773:891d with SMTP id
 2-20020a508e02000000b0051e5773891dmr223126edw.4.1689747328290; Tue, 18 Jul
 2023 23:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com> <20230718211147.18647-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230718211147.18647-2-andriy.shevchenko@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 14:15:15 +0800
Message-ID: <CABVgOS=3F07Qdu2oc9UWgqqVEYeEFW5dHv+g6_FKafpxAnZjjA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kernel.h: Split out COUNT_ARGS() and CONCATENATE()
 to args.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004a3d180600d0f58b"
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

--0000000000004a3d180600d0f58b
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jul 2023 at 05:11, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> without need of the full kernel.h dependency train with it.
>
> Here is the attempt on cleaning it up by splitting out these macros().
>
> While at it, include new header where it's being used.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Works fine here.

Acked-by: David Gow <davidgow@google.com> # KUnit

Cheers,
-- David

>  include/kunit/test.h      |  1 +
>  include/linux/args.h      | 28 ++++++++++++++++++++++++++++
>  include/linux/kernel.h    |  7 -------
>  include/linux/pci.h       |  2 +-
>  include/trace/bpf_probe.h |  2 ++
>  5 files changed, 32 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/args.h
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 23120d50499e..107c81431634 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -12,6 +12,7 @@
>  #include <kunit/assert.h>
>  #include <kunit/try-catch.h>
>
> +#include <linux/args.h>
>  #include <linux/compiler.h>
>  #include <linux/container_of.h>
>  #include <linux/err.h>
> diff --git a/include/linux/args.h b/include/linux/args.h
> new file mode 100644
> index 000000000000..8ff60a54eb7d
> --- /dev/null
> +++ b/include/linux/args.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_ARGS_H
> +#define _LINUX_ARGS_H
> +
> +/*
> + * How do these macros work?
> + *
> + * In __COUNT_ARGS() _0 to _12 are just placeholders from the start
> + * in order to make sure _n is positioned over the correct number
> + * from 12 to 0 (depending on X, which is a variadic argument list).
> + * They serve no purpose other than occupying a position. Since each
> + * macro parameter must have a distinct identifier, those identifiers
> + * are as good as any.
> + *
> + * In COUNT_ARGS() we use actual integers, so __COUNT_ARGS() returns
> + * that as _n.
> + */
> +
> +/* This counts to 12. Any more, it will return 13th argument. */
> +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +
> +/* Concatenate two parameters, but allow them to be expanded beforehand. */
> +#define __CONCAT(a, b) a ## b
> +#define CONCATENATE(a, b) __CONCAT(a, b)
> +
> +#endif /* _LINUX_ARGS_H */
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0b00e1aef33d..15d9496db169 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -419,13 +419,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
>  static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  #endif /* CONFIG_TRACING */
>
> -/* This counts to 12. Any more, it will return 13th argument. */
> -#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> -#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> -
> -#define __CONCAT(a, b) a ## b
> -#define CONCATENATE(a, b) __CONCAT(a, b)
> -
>  /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ff7500772e6..eeb2e6f6130f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -23,7 +23,7 @@
>  #ifndef LINUX_PCI_H
>  #define LINUX_PCI_H
>
> -
> +#include <linux/args.h>
>  #include <linux/mod_devicetable.h>
>
>  #include <linux/types.h>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 1f7fc1fc590c..e609cd7da47e 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -12,6 +12,8 @@
>  #undef __perf_task
>  #define __perf_task(t) (t)
>
> +#include <linux/args.h>
> +
>  /* cast any integer, pointer, or small struct to u64 */
>  #define UINTTYPE(size) \
>         __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
> --
> 2.40.0.1.gaa8946217a0b
>

--0000000000004a3d180600d0f58b
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBq
1IFw7fjOO6YIiKAH1Rz9noBlchDrBvRQSZ8hleSQ3DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwNjE1MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEDvGSVZByFw9TfVPGfXg
YDGwdM3z9OptBUTjYAsjgg0DdNEHAFJlKIArezNZDZOcO+s305lTBoun4qBa7nIWMZDwZHxhpzRl
q9YFQt3WwuqBT763XPwajNtyYUq9Wpd+328GUWzdaOuYhCBlhvQEazkHmXnUl6tsIHV3zkxic67t
I+QyyzVUfndZMV2EtCHdDOV4ztJYdlxCj4YiV3eQn3jW7D3N5tV3ac2sKa1C0vK+RoOxu0ZjSc6y
d5Upi7l1Dz8/zyFXCfEgCGQK3WHNaQPiclC1AslaMHmzVdGd09T9Ixk+loVIYSkD0q6lqBg/UWve
TKKA+sjgLIO0q7X9EA==
--0000000000004a3d180600d0f58b--
