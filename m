Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA4575BCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGOGtr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jul 2022 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGOGtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jul 2022 02:49:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BDA52FCE
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 23:49:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so5423310wrd.13
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GQVBaumRbJidGppy8MPgMJddOLw5VSfmgxfsm7IP98=;
        b=JthHUMx/ezt/ohwdlsial3ln+xmRNp5cRV4fqrFQH+ecbMc/rMBxMBtrodgH2LgWx8
         Qr+jK7wUJexExj0sToOUN/lifI/oZXhmI2H8kNYeNYkp4Haz+pkHldwxeyJXSU5sBF/U
         8BkjBjUNWXH0BuMMR0wvxNg0iRFOCg8aLKIs0pB9bakUWMUlUka/INjv1mEDfRfBIDqn
         v9IFh+Dm4l8vUkX2qv7ozpkARn98kYODp/bavFpRfucCnkFa4DBMfydMcDrWt5FOqKI2
         bKEdSXc6Qv/Qa/o0GW7tH9mnI/g0ivk/+ZAbwG+qc1+O9qJ9gafsyOOiGF9rmxixTZf0
         hn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GQVBaumRbJidGppy8MPgMJddOLw5VSfmgxfsm7IP98=;
        b=XZoka9fE7zFl64kGDoflHHgv0Mx8fFCMy6W1RQVMt6v2xo/84fqKC/nwKcM1lhKn/g
         bSZrxs2Y1ARaFHkI+sLnu44gf4equ0vQrq555TczR3RD73HkcTPzMoVEFi+vU0wgN8eQ
         MdZVMy4AFNculETveGPW0xPwL6fd/PJG+Xbtmq048DkHscwsB4RndcKYBbin0olH9LO7
         Q9kVk6VOBxnzaVJ2DGhfADHKe0/AIQoApwMJ65wuneBpbZV6zYKTFj8rwK9aVPsdxoNF
         IFKut+fPNwlCOfaYPrKTVSBQMg+A7e7l3QpZBIh3iskjHMl4nwYO4Yeu/XNiwItqdANQ
         53RA==
X-Gm-Message-State: AJIora9Z8jYOfowmWKNmJ7UZ8LbVFbpHvPgUiA7NXVwAPJLDZW+CIlPp
        /n9IYwUKTRLVKDtU4f9MgNOGR3feKQljKguem1J5iw==
X-Google-Smtp-Source: AGRyM1spS0A9XyUAjzNKptCozoKQpSOM4yj8yB7lV4IQ7nzqzA0j7GNtj5+JXp2msed0t09Cn2Tp87p9xK9XuMBgJKk=
X-Received: by 2002:adf:fd4a:0:b0:21d:8b59:dcb1 with SMTP id
 h10-20020adffd4a000000b0021d8b59dcb1mr11302010wrs.622.1657867784809; Thu, 14
 Jul 2022 23:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
 <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
 <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com>
 <CANpmjNP-YYB05skVuJkk9CRB=KVvS+5Yd+yTAzXC7MAkKAe4jw@mail.gmail.com>
 <CAGS_qxq5AAe0vB8N5Eq+WKKNBchEW++Cap2UDo=2hqGzjAekCg@mail.gmail.com> <CAGS_qxpNHrWxGBV6jcee7wPzkWTb1Mh0fpE7j4_0LrgeLv+4Ow@mail.gmail.com>
In-Reply-To: <CAGS_qxpNHrWxGBV6jcee7wPzkWTb1Mh0fpE7j4_0LrgeLv+4Ow@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 15 Jul 2022 14:49:33 +0800
Message-ID: <CABVgOSnK6pd2yPdxX6F+JNCdtk+xKVzbWyy9ffJeDM1eC5SsTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006a4b3705e3d26c56"
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

--0000000000006a4b3705e3d26c56
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 15, 2022 at 7:48 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Jul 14, 2022 at 4:45 PM Daniel Latypov <dlatypov@google.com> wrote:
> > Ack.
> > So concretely, so then a final result like this?
> >
> > $ cat kernel/kcsan/.kunitconfig
> > # Note that the KCSAN tests need to run on an SMP setup.
> > # Under kunit_tool, this can be done by using the x86_64-smp
> > # qemu-based architecture:
>
> Oops, this bit would need to be updated to something like:
>
> # Under kunit_tool, this can be done by using --qemu_args:
>
> > # ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
> > --arch=x86_64 --qemu_args='-smp 8'
> >
> > CONFIG_KUNIT=y
> >
> > CONFIG_DEBUG_KERNEL=y
> >
> > CONFIG_KCSAN=y
> > CONFIG_KCSAN_KUNIT_TEST=y
> >
> > # Need some level of concurrency to test a concurrency sanitizer.
> > CONFIG_SMP=y
> >
> > # This prevents the test from timing out on many setups. Feel free to remove
> > # (or alter) this, in conjunction with setting a different test timeout with,
> > # for example, the --timeout kunit_tool option.
> > CONFIG_KCSAN_REPORT_ONCE_IN_MS=100


Thanks everyone. I've sent out a v2 with just this patch here:
https://lore.kernel.org/linux-kselftest/20220715064052.2673958-1-davidgow@google.com/

I expect we'll take it in via the KUnit branch, as it's most useful
with the --qemu_args option.

Cheers,
-- David

--0000000000006a4b3705e3d26c56
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD6
Gi0j2hMDLEzvaBl193pAKOfw6C/mR9ImhmUaK3wwqzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MTUwNjQ5NDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAZ8bjw0I4IHzJa1/jxZsX
09uyTuCgJuGkJuuLGlGoQ4cWZ+kFt+QGSuTZzG3z1LlriPJI6yU+tp3ICCpznawFsvj7g9YoalK8
TO2kqfy/YKKm+I1pahWLZt1s2pAA69Q01sZwZZaEwILAQMfdnfcv+AgwATFSTLLJBvQqZvNIEj0N
Wg7H/CjNGLjILymYq77k2N9KosE/7rf+6mV1NhdDNXYryzdIP01WvK6uhy2uKnvzCzoZqe57OyN6
qgxQ6+GZxg8DHkVs29KYmehc1XIQEDW0EDIepY613udBQ3Sh3trbMwo52cPLIhCIOI5YnYgrjdld
Y/znKCgzyvRU+MHrhg==
--0000000000006a4b3705e3d26c56--
