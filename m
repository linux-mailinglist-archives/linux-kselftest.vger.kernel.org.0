Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D09746C2E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGDIlY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 04:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjGDIlX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 04:41:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD07CE5
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 01:41:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so169575e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688460079; x=1691052079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwysegYJOiLhGBKJBOSxCr4gli6dDpC7NJvtYVGuOSQ=;
        b=JXXkkKckyznduCK+iOb9deFONYkmssWOjRx5UMQJdu1DLD4/TPxVK1BGR+bB3fIufc
         tZ7R4uWRTw9upRLaevWcnpWlIoxagbESTTRtUTAGT1QAUgqHPM9Af94lZO83s87zbXRX
         VBJGkulcTO9OxCX2KmxcWBOStLFDJ253FEhk8mT5Cw6gdZeAL3Zc3VNbr/cdqSQn6lhl
         kyIw/0E5sYT/WqIInaXMsXX5hxqpefzc/bIjgODN0V8IE2thIVjlYgYAmk6PqUiRMh1j
         fOzVqaRbFxwCrQ1g0h+OFezejpxF3olLC/PzPhmSCOJ3UcWAWElW4RTm5pH/Ev1l4UBF
         GNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688460079; x=1691052079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwysegYJOiLhGBKJBOSxCr4gli6dDpC7NJvtYVGuOSQ=;
        b=kWo3ouR95l5KZpHbeP1/XDp2h0QLpeW+3e+PnNsDaKPMWqmkdsDzUIgPSDBiX4gzrw
         Sjmu9IM7YlOv8ufXyjne9m9ewystF//qdFJ1ZNS+X8yACYNq9BqagT1rzKeIZpH0p632
         yP8Cf0HZAgvGh+z+SZyh22i7Ml2MtLK7ItxdivBROvyHRxi7zZjo93g/tQ8pRR4nh+hE
         Nmvk/TDRcwYDCLD2S63N7sl/4/lI5L/p5vqzQ3MSgcUPaoyXRVAr2X59Pq82o3wbE2Wp
         rFDgiNCwqlbH0h9iHJ2k6Qglps8ChdVX5KByXcCzvbf/r8TPsdr2yVqdha6Vn0p+Zqpx
         XlKA==
X-Gm-Message-State: ABy/qLb2K9Io5GbN89d9RClJwxavm083G8ujGpSarpMEpaEYRTx27WVT
        6jo2YLxKuicZ0jK5ph+YIzhrnoVHtIvAGe1FtPSbWg==
X-Google-Smtp-Source: APBJJlEuEnmBA5af/MAoK/iZHp3rFZ7SraJDuhFTo+XJ22hYUX8HUIPSs/v1uNUpR9NCrJT+9qJkiLGGdP0ggryEJTA=
X-Received: by 2002:a05:600c:511a:b0:3fb:ccae:cd4b with SMTP id
 o26-20020a05600c511a00b003fbccaecd4bmr48177wms.2.1688460079006; Tue, 04 Jul
 2023 01:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <168503771547.404.3649540312110626967.tip-bot2@tip-bot2> <CAMuHMdWs5zXW8xRQCgNHJSeFbJTE6JMjO-T1fi9dgP3ugnWhfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWs5zXW8xRQCgNHJSeFbJTE6JMjO-T1fi9dgP3ugnWhfQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Jul 2023 16:41:06 +0800
Message-ID: <CABVgOS=NzGU5_DVbFjR8Ch8MYDLkZga93WH5i8bYFbBEMLZ1qw@mail.gmail.com>
Subject: Re: [tip: x86/misc] x86/csum: Improve performance of `csum_partial`
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000409d5405ffa53f7d"
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

--000000000000409d5405ffa53f7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Jul 2023 at 23:19, Geert Uytterhoeven <geert@linux-m68k.org> wrot=
e:
>
> Hi Noah,
>
> On Thu, May 25, 2023 at 8:04=E2=80=AFPM tip-bot2 for Noah Goldstein
> <tip-bot2@linutronix.de> wrote:
> > The following commit has been merged into the x86/misc branch of tip:
> >
> > Commit-ID:     688eb8191b475db5acfd48634600b04fd3dda9ad
> > Gitweb:        https://git.kernel.org/tip/688eb8191b475db5acfd48634600b=
04fd3dda9ad
> > Author:        Noah Goldstein <goldstein.w.n@gmail.com>
> > AuthorDate:    Wed, 10 May 2023 20:10:02 -05:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Thu, 25 May 2023 10:55:18 -07:00
> >
> > x86/csum: Improve performance of `csum_partial`
> >
> > 1) Add special case for len =3D=3D 40 as that is the hottest value. The
> >    nets a ~8-9% latency improvement and a ~30% throughput improvement
> >    in the len =3D=3D 40 case.
> >
> > 2) Use multiple accumulators in the 64-byte loop. This dramatically
> >    improves ILP and results in up to a 40% latency/throughput
> >    improvement (better for more iterations).
> >
> > Results from benchmarking on Icelake. Times measured with rdtsc()
> >  len   lat_new   lat_old      r    tput_new  tput_old      r
> >    8      3.58      3.47  1.032        3.58      3.51  1.021
> >   16      4.14      4.02  1.028        3.96      3.78  1.046
> >   24      4.99      5.03  0.992        4.23      4.03  1.050
> >   32      5.09      5.08  1.001        4.68      4.47  1.048
> >   40      5.57      6.08  0.916        3.05      4.43  0.690
> >   48      6.65      6.63  1.003        4.97      4.69  1.059
> >   56      7.74      7.72  1.003        5.22      4.95  1.055
> >   64      6.65      7.22  0.921        6.38      6.42  0.994
> >   96      9.43      9.96  0.946        7.46      7.54  0.990
> >  128      9.39     12.15  0.773        8.90      8.79  1.012
> >  200     12.65     18.08  0.699       11.63     11.60  1.002
> >  272     15.82     23.37  0.677       14.43     14.35  1.005
> >  440     24.12     36.43  0.662       21.57     22.69  0.951
> >  952     46.20     74.01  0.624       42.98     53.12  0.809
> > 1024     47.12     78.24  0.602       46.36     58.83  0.788
> > 1552     72.01    117.30  0.614       71.92     96.78  0.743
> > 2048     93.07    153.25  0.607       93.28    137.20  0.680
> > 2600    114.73    194.30  0.590      114.28    179.32  0.637
> > 3608    156.34    268.41  0.582      154.97    254.02  0.610
> > 4096    175.01    304.03  0.576      175.89    292.08  0.602
> >
> > There is no such thing as a free lunch, however, and the special case
> > for len =3D=3D 40 does add overhead to the len !=3D 40 cases. This seem=
s to
> > amount to be ~5% throughput and slightly less in terms of latency.
> >
> > Testing:
> > Part of this change is a new kunit test. The tests check all
> > alignment X length pairs in [0, 64) X [0, 512).
> > There are three cases.
> >     1) Precomputed random inputs/seed. The expected results where
> >        generated use the generic implementation (which is assumed to be
> >        non-buggy).
> >     2) An input of all 1s. The goal of this test is to catch any case
> >        a carry is missing.
> >     3) An input that never carries. The goal of this test si to catch
> >        any case of incorrectly carrying.
> >
> > More exhaustive tests that test all alignment X length pairs in
> > [0, 8192) X [0, 8192] on random data are also available here:
> > https://github.com/goldsteinn/csum-reproduction
> >
> > The reposity also has the code for reproducing the above benchmark
> > numbers.
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>
> Thanks for your patch, which is now commit 688eb8191b475db5 ("x86/csum:
> Improve performance of `csum_partial`") in linus/master stable/master
>
> > Link: https://lore.kernel.org/all/20230511011002.935690-1-goldstein.w.n=
%40gmail.com
>
> This does not seem to be a message sent to a public mailing list
> archived at lore (yet).
>
> On m68k (ARAnyM):
>
>     KTAP version 1
>     # Subtest: checksum
>     1..3
>     # test_csum_fixed_random_inputs: ASSERTION FAILED at
> lib/checksum_kunit.c:243
>     Expected result =3D=3D expec, but
>         result =3D=3D 54991 (0xd6cf)
>         expec =3D=3D 33316 (0x8224)
>     not ok 1 test_csum_fixed_random_inputs
>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:267
>     Expected result =3D=3D expec, but
>         result =3D=3D 255 (0xff)
>         expec =3D=3D 65280 (0xff00)
>
> Endianness issue in the test?
>
>     not ok 2 test_csum_all_carry_inputs
>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c=
:306
>     Expected result =3D=3D expec, but
>         result =3D=3D 64515 (0xfc03)
>         expec =3D=3D 0 (0x0)
>     not ok 3 test_csum_no_carry_inputs
> # checksum: pass:0 fail:3 skip:0 total:3
> # Totals: pass:0 fail:3 skip:0 total:3
> not ok 1 checksum
>

This also seems to be broken (albeit slightly differently) on 32-bit
UML and non-UML x86 with CONFIG_M486=3Dy.

In those cases, it's an alignment issue, not an endianness one, but I
suspect this may be the first test to try calling the checksum
functions with unaligned data: certainly the x86 version seems to have
originally been written to assume 2-byte alignment (and the fixes for
unaligned data missed some corner cases like UML and pre-pentium-pro
codepaths).

It definitely looks like there are endianness issues as well, but do
be on the lookout for alignment ones, too.

Patches for the x86 and UML issues, FTR:
https://lore.kernel.org/linux-um/20230704083022.692368-2-davidgow@google.co=
m/
https://lore.kernel.org/linux-kselftest/20230704083206.693155-2-davidgow@go=
ogle.com/

-- David

--000000000000409d5405ffa53f7d
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCW
0QVujMzqutTsFPCUU8xO+01qs1DetIt/qs+/B+oBdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MDQwODQxMTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPt0+8KCC/DxtWIW2h6YH
yNRlpguyyOEEy+ZFqIlhILp4+2Z1MWnmqwjWjxMgzbjBjLaKVkvLI9+XYJO9QDesmM8n1+77dW75
Dvw17rUwFxiwb2wFaGtRzonoI2k9xvYIdV1OxWXm8aTGmrOXYhesTclclIy6GZFbq9GxE/aErRk8
5wV3S5Oaj6jIpkOlw+iMCxsHFuOvp/DXxaV1KxHGGMD5Z7vgAIaZyXRAOVYY5K/aylqC4Vb01EGo
Em1ZHl84KPqlH6aGV7Akfb9cdAggND3mEbiZZPYweAsOHQnddnlToN9bPaS+Eiji9S8AovuCgN4n
jU7aDO4n/nYXEJEGjw==
--000000000000409d5405ffa53f7d--
