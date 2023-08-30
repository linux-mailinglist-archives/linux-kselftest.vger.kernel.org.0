Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059578D11D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbjH3AYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbjH3AYf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 20:24:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D43CCA
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Aug 2023 17:24:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so6331a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Aug 2023 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693355071; x=1693959871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/0cCbq73DJcgUiHy85zBh0jiyUrFXV/uxi+Mebnok8=;
        b=CHSF2PQ0ghLpaX1aECagRv8OXtuQu4HVdYVtcV8QmkKIajrope98i8p5qpKRXErGxD
         kGNWz4M+7nHLgFZcwfngAIUQ/sTtnJHAi21P6Lytu/vKF+ns2YMf4kPVrUU2xMKtNhtv
         aB5HFFiGQCXtV8oOo9zjTFjg4WbOI580LYDYABBDTy5uowLrjBFNdh7f4pzKMj7IKKeb
         K1F2K2ihs5alPkPYTB5Pj2Ubk6Ozb17UmBWOrhGaKN6oj8Xf2Qm+F/0QF/WTb/0K0koQ
         vIU08aNlj2n6wUiJgsZhfPxq/m00xUtG3iVgzAJrPvOIN+App5Q/d6Bp5iTXaclZnjP5
         5s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355071; x=1693959871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/0cCbq73DJcgUiHy85zBh0jiyUrFXV/uxi+Mebnok8=;
        b=Xsdpu+R41K2EvRAwcjjfUlBzClj8jmei6TWdAE+EToBrVUU6a4ojHb8Z6dR4ATFhP3
         dZrlcYPDB3so1JER8Vh+Zk+O0bwi2706lJE/aR8xlbKMv3be8iuEguNodhgixSQKNaro
         ACYdCPplRCaloh6JBzn+uw8iuB9Ddu+Ii0jzJyPELOOQhxHSirZ2rQYREtXRzy7viRJr
         9XrxAtFiQkmNnCJiwc7r6ltW4KTqnEvbZQ7b35XaHFiV3MNvH7ElelbfVhNx8zzY1Zzl
         M5nHwpS0NVAIhjHMSPSuCevh/CY7L6Ip1itfe/bwND4WcI62dKBpS/117qnqGqBfXeis
         cm6g==
X-Gm-Message-State: AOJu0YzyziD+KfmkRlQetc5/1+chhNteeKxGH/a0uhVVg2WdGrRDi9m1
        L+Ot8XmNKLbjK9AW8Tyny/kjrfrIQfk8IRMPbUiOjA==
X-Google-Smtp-Source: AGHT+IFe+HgBDmw1umB9qhVBGRkzFg4ih/VWzz3NQMSS0GdLoi1LDq3STzVRiYJ4w/t9UI5jSPKGyZBFKsk8T5hM7ro=
X-Received: by 2002:a50:f696:0:b0:522:4741:d992 with SMTP id
 d22-20020a50f696000000b005224741d992mr261470edn.4.1693355070402; Tue, 29 Aug
 2023 17:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com> <20230725212522.1622716-5-rmoar@google.com>
 <55950256-c00a-4d21-a2c0-cf9f0e5b8a9a@roeck-us.net>
In-Reply-To: <55950256-c00a-4d21-a2c0-cf9f0e5b8a9a@roeck-us.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 30 Aug 2023 08:24:17 +0800
Message-ID: <CABVgOS=7vtnJ09SRptaW6Gpv2nKVvc1hssL+6K29u5VeL8hYdw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] kunit: Add ability to filter attributes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rae Moar <rmoar@google.com>, shuah@kernel.org, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007c916e060418f3ae"
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

--0000000000007c916e060418f3ae
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Aug 2023 at 06:46, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Tue, Jul 25, 2023 at 09:25:15PM +0000, Rae Moar wrote:
> > Add filtering of test attributes. Users can filter tests using the
> > module_param called "filter".
> >
> > Filters are imputed in the format: <attribute_name><operation><value>
> >
> > Example: kunit.filter="speed>slow"
> >
> > Operations include: >, <, >=, <=, !=, and =. These operations will act the
> > same for attributes of the same type but may not between types.
> >
> > Note multiple filters can be inputted by separating them with a comma.
> > Example: kunit.filter="speed=slow, module!=example"
> >
> > Since both suites and test cases can have attributes, there may be
> > conflicts. The process of filtering follows these rules:
> > - Filtering always operates at a per-test level.
> > - If a test has an attribute set, then the test's value is filtered on.
> > - Otherwise, the value falls back to the suite's value.
> > - If neither are set, the attribute has a global "default" value, which
> >   is used.
> >
> > Filtered tests will not be run or show in output. The tests can instead be
> > skipped using the configurable option "kunit.filter_action=skip".
> >
> > Note the default settings for running tests remains unfiltered.
> >
> > Finally, add "filter" methods for the speed and module attributes to parse
> > and compare attribute values.
> >
> > Note this filtering functionality will be added to kunit.py in the next
> > patch.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: Rae Moar <rmoar@google.com>
>
> This patch causes all my s390 boot tests to crash.
>

Thanks: I can reproduce this here.

Looks like this is an issue with string constants in the tests not
being writable. (I'd've thought my testing with KASAN would pick up on
this, but I guess string literals are in a writable segment on
x86_64?)

Regardless, using char[] for the filters seems to work here. I've sent
out a patch to do so:
https://lore.kernel.org/linux-kselftest/20230830002116.3768675-1-davidgow@google.com/

That fixes the issue with the stacktrack below, but if you bisected it
to this patch, maybe there's another issue. The tests weren't
introduced until 76066f93f1df ("kunit: add tests for filtering
attributes"). I don't get any crashes with this patch applied, though,
so let me know if something's still broken.

Cheers,
-- David


> [   17.009188]     # module: kunit
> [   17.009239]     1..8
> [   17.014967]     ok 1 parse_filter_test
> [   17.020755]     ok 2 filter_suites_test
> [   17.026350]     ok 3 filter_suites_test_glob_test
> [   17.033102]     ok 4 filter_suites_to_empty_test
> [   17.035422] Unable to handle kernel pointer dereference in virtual kernel address space
> [   17.035546] Failing address: 0000000001501000 TEID: 0000000001501407
> [   17.035617] Fault in home space mode while using kernel ASCE.
> [   17.035833] AS:0000000002164007 R3:000000001f71c007 S:000000001f711000 P:000000000150131f
> [   17.036313] Oops: 0004 ilc:2 [#1] SMP
> [   17.036851] Modules linked in:
> [   17.037026] CPU: 0 PID: 193 Comm: kunit_try_catch Tainted: G                 N 6.5.0-01207-g1c59d383390f #1
> [   17.037106] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [   17.037199] Krnl PSW : 0704e00180000000 0000000000950e18 (kunit_next_attr_filter+0xc8/0x1c8)
> [   17.037451]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> [   17.037531] Krnl GPRS: 0000037f00000000 000000000150120a 000000000000003e 000000000000003e
> [   17.037583]            0000038000197e04 0000038000197c04 0000038000197df0 000003800000000a
> [   17.037629]            0000038000000005 0000000001501203 00000000015011fe 0000037f0000000c
> [   17.037675]            0000000005404100 0000038000197e08 0000000000950dda 0000038000197cd8
> [   17.038176] Krnl Code: 0000000000950e0a: b9180098            agfr    %r9,%r8
> [   17.038176]            0000000000950e0e: a7080000            lhi     %r0,0
> [   17.038176]           #0000000000950e12: e32090000090        llgc    %r2,0(%r9)
> [   17.038176]           >0000000000950e18: 92009000            mvi     0(%r9),0
> [   17.038176]            0000000000950e1c: b904003a            lgr     %r3,%r10
> [   17.038176]            0000000000950e20: c418007bd73c        lgrl    %r1,00000000018cbc98
> [   17.038176]            0000000000950e26: b25d0013            clst    %r1,%r3
> [   17.038176]            0000000000950e2a: a714fffe            brc     1,0000000000950e26
> [   17.038625] Call Trace:
> [   17.038679]  [<0000000000950e18>] kunit_next_attr_filter+0xc8/0x1c8
> [   17.038749]  [<000000000094e5f2>] parse_filter_attr_test+0x92/0x360
> [   17.038796]  [<000000000094e39a>] kunit_generic_run_threadfn_adapter+0x32/0x48
> [   17.038840]  [<0000000000186702>] kthread+0x142/0x148
> [   17.038884]  [<0000000000103138>] __ret_from_fork+0x40/0x58
> [   17.038927]  [<000000000102df9a>] ret_from_fork+0xa/0x30
> [   17.038984] INFO: lockdep is turned off.
> [   17.039027] Last Breaking-Event-Address:
> [   17.039062]  [<0000000000950da4>] kunit_next_attr_filter+0x54/0x1c8
> [   17.039303] Kernel panic - not syncing: Fatal exception: panic_on_oops
>
> Bisect log is attached.
>
> Guenter
>
> ---
> # bad: [1c59d383390f970b891b503b7f79b63a02db2ec5] Merge tag 'linux-kselftest-nolibc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> git bisect start '1c59d383390f' 'v6.5'
> # good: [42a7f6e3ffe06308c1ec43a7dac39a27de101574] Merge tag 'x86_microcode_for_v6.6_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 42a7f6e3ffe06308c1ec43a7dac39a27de101574
> # good: [330235e87410349042468b52baff02af7cb7d331] Merge tag 'acpi-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 330235e87410349042468b52baff02af7cb7d331
> # good: [5a31cc7297072a7266a910ca5266b640d27803b4] Merge tag 'linux-kselftest-next-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> git bisect good 5a31cc7297072a7266a910ca5266b640d27803b4
> # good: [eea70cdac61087fdb7a1c1e6f306c0bf38ec39d4] tools/nolibc: riscv: shrink _start with _start_c
> git bisect good eea70cdac61087fdb7a1c1e6f306c0bf38ec39d4
> # good: [faeb4e09fe77262f9a6b2f9f874eec0b6850721e] selftests/nolibc: add test support for ppc64
> git bisect good faeb4e09fe77262f9a6b2f9f874eec0b6850721e
> # bad: [76066f93f1df27657eb937b7c9c091e3a6abf4db] kunit: add tests for filtering attributes
> git bisect bad 76066f93f1df27657eb937b7c9c091e3a6abf4db
> # good: [64bd4641310c41a1ecf07c13c67bc0ed61045dfd] MAINTAINERS: add Rust KUnit files to the KUnit entry
> git bisect good 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
> # bad: [529534e8cba3e60f843a682e2a3149612b30d608] kunit: Add ability to filter attributes
> git bisect bad 529534e8cba3e60f843a682e2a3149612b30d608
> # good: [02c2d0c2a84172c3c7ec0229c61db55d23dd4730] kunit: Add speed attribute
> git bisect good 02c2d0c2a84172c3c7ec0229c61db55d23dd4730
> # good: [a00a72709175a4d53096301a8792b8171d1223e5] kunit: Add module attribute
> git bisect good a00a72709175a4d53096301a8792b8171d1223e5
> # first bad commit: [529534e8cba3e60f843a682e2a3149612b30d608] kunit: Add ability to filter attributes

--0000000000007c916e060418f3ae
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBD
NeZDNFdG9dXf8+oH73AVBRAauqGpfXYryStaekOOJjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MzAwMDI0MzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjVS/9QIVfKbPVyFT6l1J
yO2NcNwb4yIqmdnr80Q7HmU6Vp8bC92jOHGn06HY+CgiZvVhAtGT5GH/YQWPXjpAjfw+SRSclcCW
Z/L7ktDfvKLdD0HR0alSsl2Xx1a35aP2SaNN9D9JBTGEdJ1WKaPHe0mZFfzbEZuhEpG/GkxxhvRi
JvsZvHCzwlszbeKRIcavK+brxc6ADBzqxmlD0Y6adQUHsR/3qUz9v+WFBg5Vhzz/ZZRB4r/+2rgW
vT3m2/yGzWXb5jON9Ssfs2HJAsE88X4Kw398tKGOQfHCMlV0NnDaUkw0PleuEZjykzjF4sWAdLK+
v/ds/9kJkdtW6ogGkA==
--0000000000007c916e060418f3ae--
