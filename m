Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07D5A337F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 03:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiH0BfD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 21:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiH0BfC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 21:35:02 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955C4B48F
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 18:35:00 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id g185so1425428vkb.13
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o5jBNv5KifQbOEln9zkICvSTEk9zgR5fH5JiXZPy/VY=;
        b=Vx3egqTz0UlAHJYIyg5m8XpYUiulvE8yWvOCHhhGqixP/BsIIoy1vJEOqybLk3rdLS
         b86dFG3MmovrDhgtTi5M5Ow0a9YdOk5wOnzbGKdiDQ+srleW6gjmi3znkye57b0E64BY
         j4xULch9kCSIvVXGpF3Cuo4umGlHv+A/6OrL42rYtglAceiwgl6wb1sEnpflwPVpzIM+
         6vSr3MZibL0rHzAkvqwAnq6s7ZGRoxerFw43KVoj6Pbc6JTkfCGP3USzW2qo092WiIVT
         0hq8RBFRH4Cl/0MCzqPkrik4KMQNcJeN9dg0ZqjDJR2ycO/3BRZbPJzJ4wGeOWEoDH6H
         azMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o5jBNv5KifQbOEln9zkICvSTEk9zgR5fH5JiXZPy/VY=;
        b=3tGM8ApNN5KgQ6oQqEL40EUBnuzysDUX6wg9xMsNVmcteY3iJomlcbp+2I8Gtr5i6A
         A5SOb4OOT9y4kKY8MnBuCx1lBMYa91d4tRhdQU0vXoXEpYb1E+UsE/5mkm6FbXMXf3ET
         GPiWIoif54PTtpjbOOv+pwetHoJbD9cF98ExiK/S8S9LvOeuqLNZMdfGqQLwYh+9hfzS
         zjphr8rmppZF80OcFB8UlxiYgbMmrK4bRGSgdxcdcn52/cqLOFK32quY1dhMH3geEPmq
         0WH9WP6mByj86jy+/SoHpWMA+QHILSdE9Jg+9yK1RmRBv3QHtMk26M6mp9VpOJtLPq7I
         7qwQ==
X-Gm-Message-State: ACgBeo3hqOMt0tatsIW57AV0mW5EaLUI3AUeeHyK8Ayzy+7v0tRhd8zw
        xwymkMHwLeQJ+jQh7BOFFl5NWAL4S52KMn81kd+jeA==
X-Google-Smtp-Source: AA6agR6676kPEu/Rev8uWZa5ZYlMoLTmvo5rd3tPzM8wt5AUslnUJFy5aBd6xqx6TXoMybSzZ3rR05p2w+9Q4niQfNo=
X-Received: by 2002:a05:6122:178a:b0:380:c120:6760 with SMTP id
 o10-20020a056122178a00b00380c1206760mr795027vkf.7.1661564099282; Fri, 26 Aug
 2022 18:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220825154429.6169b270@canb.auug.org.au> <05664203-6e3d-1417-e28f-0389437a8943@infradead.org>
In-Reply-To: <05664203-6e3d-1417-e28f-0389437a8943@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 27 Aug 2022 09:34:47 +0800
Message-ID: <CABVgOSmNJgKZ4x-HgON3SB8av=sz=R2wmsUoo7N6wZ4V+b5crg@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 25 (kunit: virt/nitro_enclaves; also kexec)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Alexandru Vasile <lexnv@amazon.com>,
        Alexandru Ciobotaru <alcioa@amazon.com>,
        kexec <kexec@lists.infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ed124f05e72f0954"
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

--000000000000ed124f05e72f0954
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 26, 2022 at 4:18 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/24/22 22:44, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20220824:
> >
>
> on x86_64:
>
> ld: vmlinux.o: in function `kunit_kcalloc':
> include/kunit/test.h:369: undefined reference to `kunit_kmalloc_array'
> ld: vmlinux.o: in function `ne_misc_dev_test_merge_phys_contig_memory_regions':
> drivers/virt/nitro_enclaves/ne_misc_dev_test.c:120: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:128: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:128: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:129: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:129: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:135: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:135: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:137: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:137: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:141: undefined reference to `kunit_kfree'
>
> ld: vmlinux.o: in function `kexec_purgatory_size':
> (.rodata+0x209ee0): undefined reference to `kunit_unary_assert_format'
>
>
> Full randconfig file is attached.
>
> --
> ~Randy

Thanks. This should be fixed by:
https://lore.kernel.org/lkml/20220810234056.2494993-1-npache@redhat.com/

Cheers,
-- David

--000000000000ed124f05e72f0954
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB9
sgiwKpg9BWCisMK40o/9zEdgvHxhms9x2aHMJzTQZDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjcwMTM0NTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAqc/NXpo2Q8vY3pKg46Rx
mJwoK4l5CQWXAcrcsC8CE0TCrWvs+dg/z5vtnaWheztS/JIQenYlOZQaWTRgGWzSQjXbTJr6+wiQ
P4RWOzSEln2HWrMvu0o1Tm+Ji6nppmz+AhK0wAGEqaqYAFEeNm4d1pyV1gqj4izIfkw2QhPZjZfk
XUrQir9R4mtzJZggZL7lbz6Jtkzy0o+B/rTQWfvBkfVmQSsrPI3QgIwEFtid6JhtdoCbHp1TaE0e
UXE/zbos4jPiqiWESvPDnDa3bSBFWFhbLKbvTtXYQ1SITF2vcLViBTnIjOHORP2X7BP5ahQTNNzQ
vU/Yx1PIRDlH7c9/PQ==
--000000000000ed124f05e72f0954--
