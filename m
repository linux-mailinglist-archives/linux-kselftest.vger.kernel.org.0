Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C64CCE1D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiCDGwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 01:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCDGwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 01:52:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5018DAA0
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 22:51:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so11168827wra.12
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 22:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myQ6qd3Jp5Va79RBEXM+mUKQWfnCOiudSwe3B3dV7tQ=;
        b=oIdJYzJZrLMUzIzvHXwmJ5RdPCD3HJ9ojROl+ugz5+Ac5LJCvWEXBHKJU6JsFiFgFN
         D6gSMngoQ2uKcMjpXZ8cdUyoAq+J1O7r3Uo+isN6ME2W0GIOOIjg1gLmBF8JEKIrRDlP
         TOWGeXQHVe1Detr5rcWw/C+w+TZGqJQFu9q+qszjwVFy3abmpGtbBtYx6qnVTFQ0DZ0C
         PKrtLNWEG8i6vdCfvShX42QBWcbZSg23M/RKM4bOkke/JRl8cprOo+6XW/UjwZyOHytM
         RhLAODM20hd+mx4cCd+yboPV88D0f+WEGWooDB2fpFefatbAI6hMJcEFDw9ByuA05ZSa
         vHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myQ6qd3Jp5Va79RBEXM+mUKQWfnCOiudSwe3B3dV7tQ=;
        b=Wr+UcuFKEFcfV783b/iMD/7qf0rBQ2t5ihQrlFQEOr6qTaFEmDWgCvJHvPChVYCzB1
         RFHqlFMqatkfvI9bh8kuHo63aBOOqqsMyjwDxQN9JKp1yEEQxs5A9AspmUu/GkwsoQKH
         hYEXmlU05M9BgspAN+IM5J5zA00GmiQt1Cap/dq5+5J5/vSHsuRbYiBH2R4rYDN5yNkB
         rFerJX2Z5dd8OuwseIi/coDT4IF/ENeyGxm4VN9pmQ5SX9DpyyoknBMwhaDQrBvbkQG0
         w+3nTE1nIU27ImcBmzk4gw/78AgcNCpLh8bsP3zRbfR/OsKkOPWg0nD7eN/zoM3doCei
         Ba/g==
X-Gm-Message-State: AOAM533OjiPx172OcITB3QhiOcgCh15YbNQPmUezjDXyLPZ18Z9fO/9U
        89e32NHlfLFsV7DU+W8ZdqIhDpF/y767R+rzXGF4zA==
X-Google-Smtp-Source: ABdhPJxiVAtU1A7z1i59IHCoGvemYK4OIg1qA96J/v4q3pxraY3oW56Zz4BtnLSZ2OAKjPIQoPXo/xJwv+/P/w68Q8k=
X-Received: by 2002:adf:fd0a:0:b0:1f0:25fd:4082 with SMTP id
 e10-20020adffd0a000000b001f025fd4082mr8680894wrr.501.1646376687561; Thu, 03
 Mar 2022 22:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20220303090643.241747-1-davidgow@google.com> <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
In-Reply-To: <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Mar 2022 14:51:16 +0800
Message-ID: <CABVgOSkQPNK59vvhAMFM_5jWF-hNPZXdou8UC31RM0TEXT-=Fg@mail.gmail.com>
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a66b6a05d95ef1d4"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000a66b6a05d95ef1d4
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 4, 2022 at 1:30 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi David,
>
> On Thu, Mar 03, 2022 at 05:06:42PM +0800, David Gow wrote:
> > The things built with USER_CFLAGS don't seem to recognise it as a
> > compiler option, and print a warning:
> > clang: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]
> >
> > Fixes: 744814d2fa ("um: Allow builds with Clang")
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > This warning shows up after merging:
> > https://lore.kernel.org/lkml/20220227184517.504931-6-keescook@chromium.org/
> >
> > I'm not 100% sure why this is necessary, but it does seem to work. All
> > the attempts to get rid of -mno-global-merge entirely have been met with
> > skepticism, but I'm guessing that it's not a problem for just the UML
> > "user" files, as they shouldn't(?) interact too much with modules.
>
> Thank you for the patch! I think it is correct, as this flag only works
> for AArch64 and ARM, as it is only used in Clang::AddAArch64TargetArgs()
> and Clang::AddARMTargetArgs() in clang/lib/Driver/ToolChains/Clang.cpp,
> which are obviously never called with UML. I am not sure why we do not
> see warning during regular kernel builds, maybe something about how UML
> objects are compiled exposes this?

Yeah: this only seems to show up with UML source compiled as "user"
files (i.e., talking to the host system). Most of the kernel source
doesn't show the warning because -Qunused-arguments is set somewhere,
probably in KBUILD_CPPFLAGS, which doesn't filter down into
USER_CFLAGS:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?id=7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3#n784

Is this flag supposed to only work on ARM/AArch64, or is it just
currently not implemented anywhere else. If it's actually
ARM-specific, then moving it to the arch/arm{,64} makefile as in Kees'
patch definitely makes more sense. If it's going to show up on other
architectures at some point anyway, maybe something like this makes
sense.

>
> Regardless, I would definitely like to clean up this instance of the
> warning because I would like to make this warning a hard error so that
> we do not get cryptic cc-option failures:
>
> https://github.com/ClangBuiltLinux/linux/issues/1587
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> One small comment below.
>
> >  arch/um/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/um/Makefile b/arch/um/Makefile
> > index f2fe63bfd819..320b09cd513c 100644
> > --- a/arch/um/Makefile
> > +++ b/arch/um/Makefile
> > @@ -75,6 +75,10 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
> >               -D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
> >               -idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
> >
> > +ifdef CONFIG_CC_IS_CLANG
>
> Is this ifdef needed?
>
No: it works fine without the ifdef: I just wanted to limit the damage
I could do playing with things I didn't fully understand. :-)

> > +USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
> > +endif
> > +
> >  #This will adjust *FLAGS accordingly to the platform.
> >  include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
> >

Cheers,
-- David

--000000000000a66b6a05d95ef1d4
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCo
gZZNfyHC7gt32VURB7bs1waIRwAVDcFVg+WAp+4WPzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMDQwNjUxMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAT4EZ9MXnq6fg9Dha0yqy
ueRk6qFYjNDrL33X/dy8jrP2j4Z+SCgRWnxM73PN4kGbQUksGTqkOl3uBJ5gF96+DHphqLQJFCxZ
8I+MMkY9XQ1hK6sxugoNxwDXGsBbXFBuRYCKAUIeDM2wel2nj/foSO8kf+O5wbzIx5gBXJa4SdWu
JAVKmSJtjlspiPZOKvtsWPM2EyetLWOf29VX+fT2LHHn2sO/zCqmrtrgn306Zl629PMDBVG+j//k
mPZHPc9hijjliTjp5MvzCtqH5eAX/kT4MfE85F3tJM2fPJ/+Iq0f8reHT/TdCS59CGEYg++SZunD
qfwkhyGcsIj0Ha9zDg==
--000000000000a66b6a05d95ef1d4--
