Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF924BC6DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Feb 2022 09:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiBSIAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Feb 2022 03:00:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBSIAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Feb 2022 03:00:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31B202075
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Feb 2022 00:00:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso7908369wmb.4
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Feb 2022 00:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G51UX3AVEsugVQxKX5ONqBXMOPDOOXrNFxnuO2/wc3c=;
        b=A6pACAEZnztDG+RUZUCJmYbDLfGgp3M0m8AZ6QFiWptZ+xSjPv1XonaA2F2Hb7ILmo
         3y+ap7IP65TtiXc/E+wXiBpxRnLPYseU1gllpHZ+wGzFb0XrCP08ZVmvtQt7kKaX4zGQ
         Le26+Rnuab8qjoal6dkO4dK3minIxw71tLcnrngo9VdOYj3UXcjfy3LPS2BHZIksAfQ+
         zk7+PmdwPu+GLSHmlSJpM1FRbYurE5igjCdCMImi2ev7cZCqv2mJq0USPvIz9N8r1bmT
         OS5KUyQ5eE+6Q/Qw8C5JUDemGXeo+MpApDIii0zDCVnyUrb1qO8NOHLl2O3wW0PaHX6n
         scRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G51UX3AVEsugVQxKX5ONqBXMOPDOOXrNFxnuO2/wc3c=;
        b=wkteLU0poivO/rl2D+P3QcEIEIjXxQ0W7kShNj9xYO6nbnqGiBDn5MGWRp85IS5zR4
         nN1zqXC1MhOqxL2Cs/TsLFbbvkyDMTb2fKCMBbZ8SsTbpg2VxEH4PTBMxjCq44seCK1A
         Ke7rLj5LOV5n+66qiVuAXYbqjzAuJiVKdNr9deFchyL43GYP/qlsMx6kzPrU35js53xQ
         reqleTTDNBVaFJrfsudX2/MT0fb+JxGo6qy2+sGzGgkuj31Q9ELJv/WXFKJevbfR58UN
         jFhA6pK9q5WQikHCZTpoJI4g4I29KVgXhLHdmxY7RF7xDah6geJnRAcgUH/oyYOKAcmC
         S5Bg==
X-Gm-Message-State: AOAM5301kCnqSlCMTCFjetK0WQ69skRSKdiTCuYMP3yuR5uy0aURaKXH
        x5DXY+nJuPdQvC0+moNl2czp+Lg+pSYsIUwjWxVKiA==
X-Google-Smtp-Source: ABdhPJzbJOrM/2OLBtDRNHfACqh08uaaCdcmb5NeBmC69hAFuvYRavqZoqsRXsCrlc74PcOn8wHgcFrPuLcM4oK0IOY=
X-Received: by 2002:a05:600c:215:b0:37c:729:f84d with SMTP id
 21-20020a05600c021500b0037c0729f84dmr9399022wmi.131.1645257615313; Sat, 19
 Feb 2022 00:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com> <20220218075727.2737623-5-davidgow@google.com>
 <ac4c5f8c890e5bdd7ad7ecc04a51e72fa3ac1703.camel@sipsolutions.net>
In-Reply-To: <ac4c5f8c890e5bdd7ad7ecc04a51e72fa3ac1703.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Sat, 19 Feb 2022 16:00:04 +0800
Message-ID: <CABVgOSnBq0QE+Cq+SDeV-LxOQYbGZ6Bqbjix6h-UpNj0GMicPA@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
To:     Johannes Berg <johannes@sipsolutions.net>
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
        x86@kernel.org, felix.kuehling@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000beb73e05d85a6383"
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

--000000000000beb73e05d85a6383
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2022 at 8:26 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Fri, 2022-02-18 at 15:57 +0800, David Gow wrote:
> >
> > Note that, while this does build again, it still segfaults on startup,
> > so more work remains to be done.
>
> That's probably just a lot more stuff getting included somehow?
>

Yeah: it used to work (a couple of years ago), but something has
broken it in the meantime. It's just a shame that bisecting things
with allyesconfig takes so long...

> > They are:
> > - CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
> > - CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache
> > - CONFIG_BNXT: Failing under UML with -Werror
> > ERROR:root:../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In functio=
n =E2=80=98bnxt_ptp_enable=E2=80=99:
> > ../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:400:43: error: array s=
ubscript 255 is above array bounds of =E2=80=98struct pps_pin[4]=E2=80=99 [=
-Werror=3Darray-bounds]
> >   400 |                         ptp->pps_info.pins[pin_id].event =3D BN=
XT_PPS_EVENT_EXTERNAL;
> >       |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~
> > - CONFIG_PATA_CS5535: Needs MSR access (__tracepoint_{read,write}_msr)
> > - CONFIG_VDPA: Enables CONFIG_DMA_OPS, which is unimplemented. ('dma_op=
s' is not defined)
> >
> > These are all issues which should be investigated properly and the
> > corresponding options either fixed or disabled under UML. Having this
> > list of broken options should act as a good to-do list here, and will
> > allow these issues to be worked on independently, and other tests to
> > work in the meantime.
> >
>
> I'm not really sure it makes sense to even do anything other than
> disabling these.
>
> It looks like all of them are just exposed by now being able to build
> PCI drivers on UML. Surely the people writing the driver didn't expect
> their drivers to run over simulated PCI (which is what the UML PCI
> support is all about).
>
> Now from a PCI driver point of view you can't really tell the difference
> (and anyway the driver won't be probed), but the issues (at least the
> build time ones) come from having
>
>     UML && PCI && X86_64
>
> or
>
>     UML && PCI && X86_32
>
> because drivers typically depend on X86_64 or X86_32, rather than on
> "X86 && X86_64" or "X86 && X86_32". In a sense thus, the issue is those
> drivers don't know that "!X86 && (X86_32 || X86_64)" can happen (with
> UML).
>
>
> Now you could say that's the driver bug, or you could say that they
> should just add "depends on !UML" (though that's basically equivalent to
> adding "depends on X86" and the latter may be preferable in some cases).
>
> Or actually in the three patches you have (1-3) it's in the code, but
> same thing, you can either add && !UML (like you did) or add && X86.
>

I didn't realise X86 wasn't defined in UML: that's definitely a bit
cleaner than !UML in a number of these cases.

Not all of those issues are fundamentally solved by "depends on X86",
though: there are a few which might be other missing things in UML
(maybe the 'dma_ops' issues?), and/or might be the result of -Werror
being enabled.

>
> Arguably, however, building PCI drivers by default is somewhat
> questionable in the first place?

We do want the ability to build PCI drivers under UML, as it makes
running KUnit tests for PCI drivers much simpler and more pleasant.
And indeed, it does work for KUnit in general, it's just that some
drivers do have the issues mentioned above, so allyesconfig picks up
every broken driver.

We don't actually build the PCI drivers by default, only if the
"--alltests" option is passed, which does include them, as we do have
tests which depend on PCI we'd like to run (like the thunderbolt
test).

>
> So maybe you should just add
>
>     # CONFIG_UML_PCI_OVER_VIRTIO is not set
>
> to the broken_on_uml.config since it exposes all these issues, and
> really is not very useful since you're not going to actually run with
> any simulated PCI devices anyway, so drivers will not be probed.

I did try this as well, and it just got us a different set of issues
(there are a bunch of drivers which depend on IOMEM but don't state it
-- I'll try to send fixes for those out next week). And we'd lose
things like the thunderbolt test if PCI

Ultimately, the 'broken_on_uml.config' file is just there to pare back
allyesconfig a bit for KUnit's purposes, but we still definitely want
as many options (and hence tests) enabled as possible long-term. So I
think actual fixes to either the code or Kconfig do make sense.

Is 'make ARCH=3Dum allyesconfig' something we actually want to be able
to build? If so, no amount of adding things to KUnit's
broken_on_uml.config will solve the underlying issues, and we'll need
to at least update the Kconfig entries.

Cheers,
-- David

--000000000000beb73e05d85a6383
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC1
hK5mkWbXD3kQGhQArPS3EpKnqjuOZpFfFWnAx7DK6DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMTkwODAwMTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjnpewcuZUJVS6VIu0yi4
03UYYnjQhPEECv0bhdeu4hsYPRtRxIiCLf3pHo16X6hgQixHb8uSkg5VJDcLfSKM6CCkOQLj8Zt8
tZ1qXXWuD2yF+nWgcW0zHG9zpfGy2g5v0H3e4z3XswHVBQdgFcsY/N2v/m+7FlSlIKp4eKHVUyWQ
QDocj2QwLwrPTzvToOVgfvnPDNf3CuMwA80C7v9WEX/syUDQMaQSWCyfuxTiaUHfBdvRCGgZt+M7
XGmNI+IWcxeYhj5xZo4LWkK8APgeCTs5d+MhF0JpZK1QqJnb9rWSjyf7hOJdwPpedIOyrjQDfmbx
pB+HTOm+2IxT/N2jYA==
--000000000000beb73e05d85a6383--
