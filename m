Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75577925F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbjIEQHt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353679AbjIEHMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 03:12:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445EBCC2
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 00:12:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so21234a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693897970; x=1694502770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xO7LtF7pg9kxayvxL/JvI59Ebyv7N6JDPJg5W/aTLLo=;
        b=zNlkyDW1JUlqaUWsZwz6OvWnR7PclQj5iAu3BcKr+22GWRORPEgLWbXMGVAR2h9fJE
         lhLN4Gg35ZU/zugs/wozpJalbJc6xNJzNCSY5egT23q7zr1ocg6mKApMY9hVn/KwOu/U
         xN8QpIhzftXF5atupvKW2ZQb01QTkGxTt6ajyj8r+SUnQBZ5Ms62v3X7iem9gYADHkxr
         vAZGJRZo4CFn17Plp0tikM0AARnxWaVR9ixjMUDRFpow+u8wtYChSEKGpOZx1ZRl3rvU
         Z8PHEsJVrS6afO4xsFeaz2BfMG8RY7fnX2BmFEmFd9YP0237rTS8YOhN6resV6m8H7QV
         D/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897970; x=1694502770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO7LtF7pg9kxayvxL/JvI59Ebyv7N6JDPJg5W/aTLLo=;
        b=jjt8O2wwtWcBxjK/WEYtvMZZI7IrImUr2kvB9qAPEmrpaysPIFyH2zTMq6C6cqEj3M
         qGFBRlAhgYyPmYHvU9o67eWUTFRax4M98KQBJyJiovrGHT4Mk6eY3ID2tLLkDpp3gjGi
         +E50rrfBrRniqHWk88pXXiW0jI9roIN1owhwbsXtF9Lw/AnkinOJeQqSPAGX5HBQPlSN
         GfrVgziPwqifI5FgpzW+wSFHPw1ZZ8MCZAsrAgIRpx+PtW9EokOIR8GxcyMxyGSDhm5W
         Arzi8EXfYBi3UJx+wdGYj3NJN49hkht/KGYutXXfNUuTCdcf/guJwYzKRCQ3yh/7vaSC
         XOwQ==
X-Gm-Message-State: AOJu0YwANKZTtvYyhLDwqWOIEOS/PKHQG4ri3Q9ZbmvS0cHxwu6OrkxJ
        R+N+7loEhjlI0OESULd29OWBLWj8umiYVfhdZ1MiAw==
X-Google-Smtp-Source: AGHT+IGQuVqsAYCHA2zkucEPjCLPSjr4Bv27qQj7wMr2oXb4iD5ms8oXKwAIiN3WtnNiZBMTeDFTZ8IgtMYLc8nSSiU=
X-Received: by 2002:a50:baad:0:b0:523:193b:5587 with SMTP id
 x42-20020a50baad000000b00523193b5587mr172836ede.6.1693897969652; Tue, 05 Sep
 2023 00:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230903071028.1518913-1-ruanjinjie@huawei.com> <20230903071028.1518913-2-ruanjinjie@huawei.com>
In-Reply-To: <20230903071028.1518913-2-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Sep 2023 15:12:35 +0800
Message-ID: <CABVgOS=8Jw1ExrpY_6-a3Nc6NJRf0Jb17D-WS33JwED6Xz95bQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: Fix wild-memory-access bug in kunit_free_suite_set()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        jk@codeconstruct.com.au, dlatypov@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ca8afd0604975ac8"
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

--000000000000ca8afd0604975ac8
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Sept 2023 at 15:11, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Inject fault while probing kunit-example-test.ko, if kstrdup()
> fails in mod_sysfs_setup() in load_module(), the mod->state will
> switch from MODULE_STATE_COMING to MODULE_STATE_GOING instead of
> from MODULE_STATE_LIVE to MODULE_STATE_GOING, so only
> kunit_module_exit() will be called without kunit_module_init(), and
> the mod->kunit_suites is no set correctly and the free in
> kunit_free_suite_set() will cause below wild-memory-access bug.
>
> The mod->state state machine when load_module() succeeds:
>
> MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_LIVE
>          ^                                              |
>          |                                              | delete_module
>          +---------------- MODULE_STATE_GOING <---------+
>
> The mod->state state machine when load_module() fails at
> mod_sysfs_setup():
>
> MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_GOING
>         ^                                               |
>         |                                               |
>         +-----------------------------------------------+
>
> Call kunit_module_init() at MODULE_STATE_COMING state to fix the issue
> because MODULE_STATE_LIVE is transformed from it.
>
>  Unable to handle kernel paging request at virtual address ffffff341e942a88
>  KASAN: maybe wild-memory-access in range [0x0003f9a0f4a15440-0x0003f9a0f4a15447]
>  Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000441ea000
>  [ffffff341e942a88] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>  Modules linked in: kunit_example_test(-) cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: kunit_example_test]
>  CPU: 3 PID: 2035 Comm: modprobe Tainted: G        W        N 6.5.0-next-20230828+ #136
>  Hardware name: linux,dummy-virt (DT)
>  pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : kfree+0x2c/0x70
>  lr : kunit_free_suite_set+0xcc/0x13c
>  sp : ffff8000829b75b0
>  x29: ffff8000829b75b0 x28: ffff8000829b7b90 x27: 0000000000000000
>  x26: dfff800000000000 x25: ffffcd07c82a7280 x24: ffffcd07a50ab300
>  x23: ffffcd07a50ab2e8 x22: 1ffff00010536ec0 x21: dfff800000000000
>  x20: ffffcd07a50ab2f0 x19: ffffcd07a50ab2f0 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: ffffcd07c24b6764
>  x14: ffffcd07c24b63c0 x13: ffffcd07c4cebb94 x12: ffff700010536ec7
>  x11: 1ffff00010536ec6 x10: ffff700010536ec6 x9 : dfff800000000000
>  x8 : 00008fffefac913a x7 : 0000000041b58ab3 x6 : 0000000000000000
>  x5 : 1ffff00010536ec5 x4 : ffff8000829b7628 x3 : dfff800000000000
>  x2 : ffffff341e942a80 x1 : ffffcd07a50aa000 x0 : fffffc0000000000
>  Call trace:
>   kfree+0x2c/0x70
>   kunit_free_suite_set+0xcc/0x13c
>   kunit_module_notify+0xd8/0x360
>   blocking_notifier_call_chain+0xc4/0x128
>   load_module+0x382c/0x44a4
>   init_module_from_file+0xd4/0x128
>   idempotent_init_module+0x2c8/0x524
>   __arm64_sys_finit_module+0xac/0x100
>   invoke_syscall+0x6c/0x258
>   el0_svc_common.constprop.0+0x160/0x22c
>   do_el0_svc+0x44/0x5c
>   el0_svc+0x38/0x78
>   el0t_64_sync_handler+0x13c/0x158
>   el0t_64_sync+0x190/0x194
>  Code: aa0003e1 b25657e0 d34cfc42 8b021802 (f9400440)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: 0x4d0742200000 from 0xffff800080000000
>  PHYS_OFFSET: 0xffffee43c0000000
>  CPU features: 0x88000203,3c020000,1000421b
>  Memory Limit: none
>  Rebooting in 1 seconds..
>
> Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> v2:
> - Add Reviewed-by.
> - Adjust the 4th patch to be the second.
> ---

Still looks good, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..421f13981412 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -784,12 +784,13 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>
>         switch (val) {
>         case MODULE_STATE_LIVE:
> -               kunit_module_init(mod);
>                 break;
>         case MODULE_STATE_GOING:
>                 kunit_module_exit(mod);
>                 break;
>         case MODULE_STATE_COMING:
> +               kunit_module_init(mod);
> +               break;
>         case MODULE_STATE_UNFORMED:
>                 break;
>         }
> --
> 2.34.1
>

--000000000000ca8afd0604975ac8
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCs
aGruJfyyz0vrNRPjDCgfnoKnvViBTpxL7/IAHaMLyDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDUwNzEyNTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAj0BjUfEjPT+S3v7XI/xm
xAYIo1NnHTgXkmyHJjo7RnMVA34NXtJsYmTBwYJyN71S0EC9FI+wmaYhr1r7zMibPg8vkIGwBHp5
mfGiu9T9K3WNTu0QBOrmOdLOaKYr0oocs5BkZKyqQuoa1IUug6pgs48szov/6lNjDdW6jVQyDh2J
QHpofn9dyuKjWCtMZEinhWeRki3H3oTAKfGFjB90Vc71qhKmMTUDjDY+kKC0KHEnQicif2xlchef
NCkZKx3yS2gNghtJsgRR+oyimJEwv3PT3UowseVEXndDj76Cr31pe3sLEbGR/PF5zgbuY79Iaa4Q
IVf+ec1F8pFmfmY3kg==
--000000000000ca8afd0604975ac8--
