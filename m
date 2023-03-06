Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225AF6ACBF8
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 19:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCFSHV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCFSHF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 13:07:05 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A431FC4;
        Mon,  6 Mar 2023 10:06:42 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17683b570b8so9549212fac.13;
        Mon, 06 Mar 2023 10:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTLypR7XgARTJbCy5jf1iSb8cf8N3ZXFx7hGaEE6omA=;
        b=2eIbzFV3T3fIDqYMSQ83JJQU2+SlXjTxyHMjV40CGFSu1b85LqtNemMxHTa5/ZtBon
         IIx/pJrGXRFyz8YThxHhIpiW6ybdw+TdfS6/hBfYIQMfzJ2Cruf6Rwj9Ak/bMC31sMpI
         kZZls3nEKLjt5aepqUVSHLXc+MYqnuUw4b90zNlVNRyzdonBqATsDteaH/nBuhQQTe9E
         +/G3c4OI3RQI6I0sG3oBqocrk7stwAxQWhER/Id7pvs2izK5KygO4/ZeTWlnCr0Q2mEz
         SjSoIyB70jaYCFIGqOJSJ7BxvbKRMxF+ojOLMjJ0UVHz75MS/7DKdSR8JHA0wb4G5CWg
         AkAQ==
X-Gm-Message-State: AO0yUKUIyII8SoLDDMDsFZHvtZNeu109jZac9qHH0v3LSCbdcevXStdE
        wWUxl7hSwB/jmdKk1Nrx/nsm63Lz9EnYwA==
X-Google-Smtp-Source: AK7set/2SJdpIFEa+3IDgzJOc67ijCh1FFNgJgfDShpVt773WWwEzKRmSB1H3oSpYRIsaM9mzzpsJA==
X-Received: by 2002:a05:6870:e0c6:b0:176:8f34:2609 with SMTP id a6-20020a056870e0c600b001768f342609mr5636400oab.58.1678125700280;
        Mon, 06 Mar 2023 10:01:40 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id d199-20020ae9efd0000000b007423e52f9d2sm7866627qkg.71.2023.03.06.10.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:01:39 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id x12so9034073ybt.7;
        Mon, 06 Mar 2023 10:01:39 -0800 (PST)
X-Received: by 2002:a05:6902:208:b0:a98:bd27:91de with SMTP id
 j8-20020a056902020800b00a98bd2791demr6926193ybs.7.1678125699092; Mon, 06 Mar
 2023 10:01:39 -0800 (PST)
MIME-Version: 1.0
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <167380331214.10651.11224254824457738270.stgit@bazille.1015granger.net>
 <1331f5b4-66cb-4afa-4e81-64cf4bc696d@linux-m68k.org> <D157AE63-73DD-4CCE-B43E-AC0D92F35038@oracle.com>
In-Reply-To: <D157AE63-73DD-4CCE-B43E-AC0D92F35038@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 19:01:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUMV0grWS7c5N4wCZn+MuN4ysCBqY3zDJjW9q5siBFsQ@mail.gmail.com>
Message-ID: <CAMuHMdVUMV0grWS7c5N4wCZn+MuN4ysCBqY3zDJjW9q5siBFsQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/41] SUNRPC: Enable rpcsec_gss_krb5.ko to be built
 without CRYPTO_DES
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Chuck,

On Mon, Mar 6, 2023 at 5:17 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Mar 6, 2023, at 3:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 15 Jan 2023, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Because the DES block cipher has been deprecated by Internet
> >> standard, highly secure configurations might require that DES
> >> support be blacklisted or not installed. NFS Kerberos should still
> >> be able to work correctly with only the AES-based enctypes in that
> >> situation.
> >>
> >> Also note that MIT Kerberos has begun a deprecation process for DES
> >> encryption types. Their README for 1.19.3 states:
> >>
> >>> Beginning with the krb5-1.19 release, a warning will be issued
> >>> if initial credentials are acquired using the des3-cbc-sha1
> >>> encryption type.  In future releases, this encryption type will
> >>> be disabled by default and eventually removed.
> >>>
> >>> Beginning with the krb5-1.18 release, single-DES encryption
> >>> types have been removed.
> >>
> >> Aside from the CONFIG option name change, there are two important
> >> policy changes:
> >>
> >> 1. The 'insecure enctype' group is now disabled by default.
> >>  Distributors have to take action to enable support for deprecated
> >>  enctypes. Implementation of these enctypes will be removed in a
> >>  future kernel release.
> >>
> >> 2. des3-cbc-sha1 is now considered part of the 'insecure enctype'
> >>  group, having been deprecated by RFC 8429, and is thus disabled
> >>  by default
> >>
> >> After this patch is applied, SunRPC support can be built with
> >> Kerberos 5 support but without CRYPTO_DES enabled in the kernel.
> >> And, when these enctypes are disabled, the Linux kernel's SunRPC
> >> RPCSEC GSS implementation fully complies with BCP 179 / RFC 6649
> >> and BCP 218 / RFC 8429.
> >>
> >> Tested-by: Scott Mayhew <smayhew@redhat.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > Thanks for your patch, which is now commit dfe9a123451a6e73 ("SUNRPC:
> > Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES") in v6.3-rc1.
> >
> >> --- a/net/sunrpc/Kconfig
> >> +++ b/net/sunrpc/Kconfig
> >> @@ -19,10 +19,10 @@ config SUNRPC_SWAP
> >> config RPCSEC_GSS_KRB5
> >>      tristate "Secure RPC: Kerberos V mechanism"
> >>      depends on SUNRPC && CRYPTO
> >> -    depends on CRYPTO_MD5 && CRYPTO_DES && CRYPTO_CBC && CRYPTO_CTS
> >> -    depends on CRYPTO_ECB && CRYPTO_HMAC && CRYPTO_SHA1 && CRYPTO_AES
> >>      default y
> >>      select SUNRPC_GSS
> >> +    select CRYPTO_SKCIPHER
> >> +    select CRYPTO_HASH
> >>      help
> >>        Choose Y here to enable Secure RPC using the Kerberos version 5
> >>        GSS-API mechanism (RFC 1964).
> >
> > While updating my defconfigs for v6.3-rc1, I noticed this change has an
> > interesting side-effect: if any of the CRYPTO_* algorithms were modular
> > before, RPCSEC_GSS_KRB5 was modular, too.
> > After this change, RPCSEC_GSS_KRB5 is promoted to builtin.
>
> I'm not following. Which CRYPTO_ options trigger the behavior?
> On my test system, CONFIG_RPCSEC_GSS_KRB5=m and the CRYPTO stuff
> is all =y.

On v6.2, "make ARCH=m68k defconfig" gives you
CONFIG_RPCSEC_GSS_KRB5=m
On v6.3, it became builtin, due to dropping the dependencies on
the individual crypto modules.

$ grep -E "CRYPTO_(MD5|DES|CBC|CTS|ECB|HMAC|SHA1|AES)" .config
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_HMAC=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m

> > This is not necessarily bad in-se, but you might want to be aware of it,
> > and perhaps change the "default y".
>
> Well that might be there to address the need for GSS to be
> enabled if NFSv4 support is built. See commit df486a25900f
> ("NFS: Fix the selection of security flavours in Kconfig")
>
> I'm not claiming I understand exactly how that fix works.

And that was changed again a little bit later in commit
e3b2854faabd1043 ("SUNRPC: Fix the SUNRPC Kerberos V RPCSEC_GSS
module dependencies").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
