Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912824BC6DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Feb 2022 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiBSIAz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Feb 2022 03:00:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiBSIAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Feb 2022 03:00:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF0202075
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Feb 2022 00:00:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h6so18134230wrb.9
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Feb 2022 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bm2cjDotHNnlgdOiZHlYtdCU72n38X9c1F5BAycuCQ=;
        b=GJ2U1dnWktgqlNLOjX2RzpceEY3xsM5EDB49H/lsK6GTLRFyM7vcw/xsFWBWlkknDq
         FwfB/Kk07B4D2wQ5+jvvyAB+SoZn3VBT6fP7NUAzMcVt3XsIm4TsehhVNIH+eYkGs80Y
         IWwxNyCJHDxs+XGJo3CwZD0mayLATPX+/bld+U8kBGhSqSRnr3em3i0ULE7D9ayJW0+K
         LAlgPwa5vaxwvH8kvNsxbg/aaJ1hzikN02dRdbO5f1NhxqSIVTgqE51WdDJ8QF0l5UzN
         +V/HQpIik1B7oJEjP/IMvOy3Livo1FbfsUsxmmUVDT5JSLLQWmNTnqbUts3TOndSodPy
         yKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bm2cjDotHNnlgdOiZHlYtdCU72n38X9c1F5BAycuCQ=;
        b=LMFrrbSiLHw2PrAtpuPYZP4xJ8HGBqbHNfhwwpj7nCyoPV40MVYA63MlrVd8RVlAQb
         3x+cZQJ6K6aReKHmROACAJq6c4JEVJFFPCls0h1Gxm+TCeEFv2k3Bwv1xiMFgKQml70O
         Ghc7oZz8yCaf+HqwYEm/LkB5qgv8ZuTEoQcKs9Xmp4Nm6hRDlcgfuwkCSck3YEZDR1TB
         H/MKTEe4Ey/X4Fz2lWIS4tRUkm/4i2bt9iGd16Bb7//y8TEu1Y+8aJu6KRr78Jvuie9C
         PNQ5RN3c3hzaPMw8n8s/woWO2zsqTW1hLo4FaGOYBLg/5KYSLlehjnsYcx2RhVQSYyW6
         EvdQ==
X-Gm-Message-State: AOAM533621BoQ7HX2ZlKl2VhCSChoxGlwCKiZ5mjFvdDQr8DWJqkBhRi
        CHrxAaSlY2m58iucnjiRhdFrKTlpaGub6G91I5XZDw==
X-Google-Smtp-Source: ABdhPJwZr3Wnjgl9INswmRX8j6PE+U9N5T0seoUM0s29l+SpYSFVVzVA2VAhljcYE2g84EpAA0a4jn2GXa2Q4MVs80M=
X-Received: by 2002:adf:f109:0:b0:1e3:e2d:e6e0 with SMTP id
 r9-20020adff109000000b001e30e2de6e0mr8501855wro.177.1645257634157; Sat, 19
 Feb 2022 00:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com> <20220218075727.2737623-2-davidgow@google.com>
 <ef8eee23-ba8c-e76a-d32d-68658841708d@amd.com>
In-Reply-To: <ef8eee23-ba8c-e76a-d32d-68658841708d@amd.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 19 Feb 2022 16:00:22 +0800
Message-ID: <CABVgOSnFjDnjbPh_E+GSzp-8WoRVPFa36=5GUpPtC-ba-fGkaw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix compilation under UML
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-rdma@vger.kernel.org,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ddc89005d85a6478"
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

--000000000000ddc89005d85a6478
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 19, 2022 at 12:39 AM Felix Kuehling <felix.kuehling@amd.com> wr=
ote:
>
>
> Am 2022-02-18 um 02:57 schrieb David Gow:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > cpuinfo_x86 and its associated macros are not available under ARCH=3Dum=
,
> > even though CONFIG_X86_64 is defined.
> >
> > This patch (and discussion) were originally posted here:
> > https://lkml.org/lkml/2022/1/24/1547
> >
> > This produces the following build errors:
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1556:9: note: in=
 expansion of macro =E2=80=98cpu_data=E2=80=99
> >    return cpu_data(first_cpu_of_numa_node).apicid;
> >           ^~~~~~~~
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1560:1: error: c=
ontrol reaches end of non-void function [-Werror=3Dreturn-type]
> >
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function =E2=80=
=98kfd_fill_iolink_info_for_cpu=E2=80=99:
> > ../arch/um/include/asm/processor-generic.h:103:19: error: called object=
 is not a function or function pointer
> >   #define cpu_data (&boot_cpu_data)
> >                    ~^~~~~~~~~~~~~~~
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1688:27: note: in ex=
pansion of macro =E2=80=98cpu_data=E2=80=99
> >    struct cpuinfo_x86 *c =3D &cpu_data(0);
> >                             ^~~~~~~~
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1691:7: error: deref=
erencing pointer to incomplete type =E2=80=98struct cpuinfo_x86=E2=80=99
> >    if (c->x86_vendor =3D=3D X86_VENDOR_AMD)
> >         ^~
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1691:23: error: =E2=
=80=98X86_VENDOR_AMD=E2=80=99 undeclared (first use in this function); did =
you mean =E2=80=98X86_VENDOR_ANY=E2=80=99?
> >    if (c->x86_vendor =3D=3D X86_VENDOR_AMD)
> >                         ^~~~~~~~~~~~~~
> >                         X86_VENDOR_ANY
> >
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function =E2=80=
=98kfd_create_vcrat_image_cpu=E2=80=99:
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1742:11: warning: un=
used variable =E2=80=98entries=E2=80=99 [-Wunused-variable]
> >    uint32_t entries =3D 0;
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 6 +++---
> >   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_crat.c
> > index 9624bbe8b501..b1e2d117be3d 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -1682,7 +1682,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_nod=
e_id, int *avail_size,
> >       return 0;
> >   }
> >
> > -#ifdef CONFIG_X86_64
> > +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>
> I don't think it makes sense to compile a hardware device driver in a
> UML config. Instead of scattering UML #ifdefs through our code, I would
> recommend adding this to Kconfig:
>

There are cases where I think it could make sense to have a hardware
driver under UML, though I agree they're pretty rare.

In particular, there's the virtio PCI support in UML, which one could
potentially hook up a GPU to. The case I care more about is the
ability to run KUnit tests under UML: if amdgpu wanted to have KUnit
tests, it could still run them in qemu (or on real hardware), but UML
is faster and more convenient, if the code being tested can compile
under it.

So I have a slight preference personally for fixing this, to unblock those =
uses.

That being said, it's definitely not worth placing a significant
burden on you maintaining these things if no-one uses them. And since
there doesn't appear to be any such use at the moment[1], I've no
strong objection to just disabling this for now (it can always be
re-enabled and fixed if it becomes useful later).

Cheers,
-- David

[1] The proposed DRM KUnit tests don't require any actual hardware
drivers, as I understand it:
https://lore.kernel.org/all/20220117232259.180459-5-michal.winiarski@intel.=
com/T/

--000000000000ddc89005d85a6478
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAD
bDG4S/ht/giejbOZGd/p6/lp8S/M/DHA3U+Ot88qtDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMTkwODAwMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKANLJk4i7jUMAjnEhFHl
o2f9h+XHj1vfL7KVXEc1ciAAUdpZxezlv2cCZEdq9krX+jtap9bTVtJzyLMbVr5SixD3Ob5tVk0f
E8+a8irhK9+YVAQchpYBa8+RJdqH0J1HeFb80T5P1jN73CevRgcoGDjd1izkE9NKJ0l6lvoHv8LF
0p0HA2IHK6nYYs3xdRkVCL7Nu8cFQxkDf7TjmBiqrIH2GxVwU84dpMTrkzBqT7ZswXYZ/LrcUcNp
Jr3U0AY9S11MadPemWc97d53FMqEtCy2rLB/pEIcKioSUIKRbbtLM/QKotZO07I6xLDzGnXHDP2T
kczRI/2I9zlFWB7rVg==
--000000000000ddc89005d85a6478--
