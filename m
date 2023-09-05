Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB77926E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbjIEQH0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353683AbjIEHNp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 03:13:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D43CC2
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 00:13:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52c96d5df86so16252a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693898019; x=1694502819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tKLxD+gN1zixDT+CN7RoSGgjaoaC0QEpeT8gEho2zE=;
        b=CfImJeCzt5IYM/A2aVBmyMe5kK+gc2eDO05BTM0Lc5iSc1Zs/FcDH3or5fbqyThtCM
         BAGJfZyQ4FynWBSmeKPnL6K7QAMkW4MR1WeZTtTQPpaYzOs9syxRHxxi6CnJSoAeMT7E
         oFTTub1eAhbblGJ/vqSa9po5zGLo6unpCMwAxGiRONXbz+yg6YbqTNV9BaQfmX2/MB6+
         h9aQ6ha5pHjo3IIsM5EysDB+v1hS3q44A47KaMopKnk3+UGJPfvouQdFDGCzq4YVratm
         frjmJkuPaOyWQJ+ZLpIKhpoquONJiLtDyE3oxnccQp3fd/RDpBKVNdjDAgsSxUx8q8lc
         HGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898019; x=1694502819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tKLxD+gN1zixDT+CN7RoSGgjaoaC0QEpeT8gEho2zE=;
        b=OJcDIs/vhBNTNP19qfGjSbzOKNvM6Nrz8buqc9tBVaZ09i2UYsaxdk8LiAHdyhoKaN
         QjStq6qZZ0HF1jwcI7U/2duvn9JfZkvWfRai7Y1qkJ12S8T3w+f4IKwLXAfzLEje5hmQ
         Rp2L4BiqSA2AQ8IRJV5yiE5qHp5ZTdcHO3Y0ZgWdoE2F9i+cDhJIlCVVTakgPyTaenFI
         U3+ZXp5CxWhZR3+/QlH5mnPiEV6Ub9X9aMbFiMVU6V52Ydpex4xdXnRekyMq6rwNb/PX
         +jUr6Qj3PdkWCwNIqtjLua3hKxzIXfz18GF2a5zI4Rqwu3Hoz247aYxMZBidFxdL7yG7
         QFoQ==
X-Gm-Message-State: AOJu0YxX19VWU2Fqw/PT4d0+raqHKJ4dfbFzMU2GKEPgK49Syqv4qlpq
        cDDrPM2hTI3iV8+9WrNQc3TeLqOIM59gcUBnRruyHtPGn6qm+YKFcdyQ+g==
X-Google-Smtp-Source: AGHT+IGOM/Vf225apo+BFAqzLAArYSjs9L9GwkEC9UwfUzRqw1vyTpdj9ZZG25VMrKT+GCP3kcEPryDX5/xZbeMTPiU=
X-Received: by 2002:a50:9f6f:0:b0:506:b280:4993 with SMTP id
 b102-20020a509f6f000000b00506b2804993mr277376edf.2.1693898018759; Tue, 05 Sep
 2023 00:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230903071028.1518913-1-ruanjinjie@huawei.com> <20230903071028.1518913-4-ruanjinjie@huawei.com>
In-Reply-To: <20230903071028.1518913-4-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Sep 2023 15:13:27 +0800
Message-ID: <CABVgOS=5mA6eaHNnn0yrZt3g03ZaAW112KotaBO6u2Lm+66aEA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        jk@codeconstruct.com.au, dlatypov@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b609d80604975def"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000b609d80604975def
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Sept 2023 at 15:11, 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Inject fault while probing kunit-example-test.ko, if kzalloc fails
> in kunit_parse_glob_filter(), strcpy() or strncpy() to NULL will
> cause below null-ptr-deref bug. So check NULL for kzalloc() and
> return int instead of void for kunit_parse_glob_filter().
>
>  Unable to handle kernel paging request at virtual address dfff800000000000
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  [dfff800000000000] address between user and kernel address ranges
>  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>  Modules linked in: kunit_example_test cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: kunit_example_test]
>  CPU: 4 PID: 6047 Comm: modprobe Tainted: G        W        N 6.5.0-next-20230829+ #141
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : strncpy+0x58/0xc0
>  lr : kunit_filter_suites+0x15c/0xa84
>  sp : ffff800082a17420
>  x29: ffff800082a17420 x28: 0000000000000000 x27: 0000000000000004
>  x26: 0000000000000000 x25: ffffa847e40a5320 x24: 0000000000000001
>  x23: 0000000000000000 x22: 0000000000000001 x21: dfff800000000000
>  x20: 000000000000002a x19: 0000000000000000 x18: 00000000750b3b54
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 0000000000000000 x13: 34393178302f3039 x12: ffff7508fcea4ec1
>  x11: 1ffff508fcea4ec0 x10: ffff7508fcea4ec0 x9 : dfff800000000000
>  x8 : ffff6051b1a7f86a x7 : ffff800082a17270 x6 : 0000000000000002
>  x5 : 0000000000000098 x4 : ffff028d9817b250 x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : ffffa847e40a5320 x0 : 0000000000000000
>  Call trace:
>   strncpy+0x58/0xc0
>   kunit_filter_suites+0x15c/0xa84
>   kunit_module_notify+0x1b0/0x3ac
>   blocking_notifier_call_chain+0xc4/0x128
>   do_init_module+0x250/0x594
>   load_module+0x37b0/0x44b4
>   init_module_from_file+0xd4/0x128
>   idempotent_init_module+0x2c8/0x524
>   __arm64_sys_finit_module+0xac/0x100
>   invoke_syscall+0x6c/0x258
>   el0_svc_common.constprop.0+0x160/0x22c
>   do_el0_svc+0x44/0x5c
>   el0_svc+0x38/0x78
>   el0t_64_sync_handler+0x13c/0x158
>   el0t_64_sync+0x190/0x194
>  Code: 5400028a d343fe63 12000a62 39400034 (38f56863)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: 0x284761400000 from 0xffff800080000000
>  PHYS_OFFSET: 0xfffffd7380000000
>  CPU features: 0x88000203,3c020000,1000421b
>  Memory Limit: none
>  Rebooting in 1 seconds..
>
> Fixes: a127b154a8f2 ("kunit: tool: allow filtering test cases via glob")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> v2:
> - goto the new add identical purpose free_copy label.
> ---

Looks good to me.

This is still,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/executor.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 0eda42b0c9bb..28f144de748b 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -65,7 +65,7 @@ struct kunit_glob_filter {
>  };
>
>  /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
> -static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
> +static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
>                                     const char *filter_glob)
>  {
>         const int len = strlen(filter_glob);
> @@ -73,16 +73,28 @@ static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
>
>         if (!period) {
>                 parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
> +               if (!parsed->suite_glob)
> +                       return -ENOMEM;
> +
>                 parsed->test_glob = NULL;
>                 strcpy(parsed->suite_glob, filter_glob);
> -               return;
> +               return 0;
>         }
>
>         parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
> +       if (!parsed->suite_glob)
> +               return -ENOMEM;
> +
>         parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
> +       if (!parsed->test_glob) {
> +               kfree(parsed->suite_glob);
> +               return -ENOMEM;
> +       }
>
>         strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
>         strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
> +
> +       return 0;
>  }
>
>  /* Create a copy of suite with only tests that match test_glob. */
> @@ -152,8 +164,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>         }
>         copy_start = copy;
>
> -       if (filter_glob)
> -               kunit_parse_glob_filter(&parsed_glob, filter_glob);
> +       if (filter_glob) {
> +               *err = kunit_parse_glob_filter(&parsed_glob, filter_glob);
> +               if (*err)
> +                       goto free_copy;
> +       }
>
>         /* Parse attribute filters */
>         if (filters) {
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230903071028.1518913-4-ruanjinjie%40huawei.com.

--000000000000b609d80604975def
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD+
ojkSFyC2ov7UrzIhM1lncq35cCzT8qI7BBIOVvr7gzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDUwNzEzMzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJowAclDVFph6QK4Z7ieG
fMPLr+ug1dFmul67ULh2+20V5Gu4GYTBTD0gKMOP7htTlKqOGUpmAgEyPsz6KmEg1ARCy7bnDvIW
e+NceZJuq4V5BSNj1vUELbkI4+73FuT/m+RV+9tOp5hh8Jn7VXZQXYPgp137WGZrzYr2L32rkpHB
vRloE/BE+ypJ5cgUWqYADX0xl0cYvn1R7OB5ti8PUcd+VmBbxYDeBmC1jt5EVyqrOMQH5cvlDmzM
9Y9hF3nEKOS1x/k2Na/bqMaIgqtb0ih7gOG/A45LVKjt2RdvzJCcKgq7/iAzyBnYud3csvkYCGwr
3Ui/5bQbDNeTZ0PI6Q==
--000000000000b609d80604975def--
