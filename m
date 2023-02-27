Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7856A462C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjB0PhU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 10:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB0PhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 10:37:19 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588FA2310C;
        Mon, 27 Feb 2023 07:37:18 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id ks17so4692856qvb.6;
        Mon, 27 Feb 2023 07:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y6TQuxqGxL/zvrpovcLVAHICHhhLF7siniZA3gFbXI=;
        b=hcf1/Hd2e+v8nF4kT+ZG0lQUrsHSJlLL00LCsV1PoFY2kZ1y8SiHK+89XhJWq7HWFa
         bI+d9S1OiBvZT89JubwPfb1p8WIAL4HneN++NM1OHWaoFNz0pC0fHwkYXGfneHPVevDw
         J45LqtfmKW218UD1yLh/NEarP4M7YRIuSWACw1FgN6rWevnB9rbPUqmcVmkeb1IBEF+i
         /xvjJsVhK5bQmjJrDHNG/ODBOEZ4WSZXynf10/CsxRr+E6AuSYfk4MayIzkaOAwY/Qq9
         bRQ3ldLE1GAWN3MD05preIlicm3mMJBGysNwVpP3foi1AFq5vtaOZZxzOx2PxBi8cdOG
         5XCg==
X-Gm-Message-State: AO0yUKUB/ILIX3gjv9R/qaBPemD0e0fuOaZ+xVMGRPQg/CSM5kS7Ccyk
        UIUhxewb2f6FGhSawe5QCNdFi4ag4fgJKQ==
X-Google-Smtp-Source: AK7set9cpAuZo3q1FfwC8v5VmtldXa+1d4qE4LCnNV8ocBHMNmIsYZwqURH+AoQv9/EFC77LAzCqxw==
X-Received: by 2002:a05:6214:3017:b0:56e:bc57:d646 with SMTP id ke23-20020a056214301700b0056ebc57d646mr51862835qvb.43.1677512237244;
        Mon, 27 Feb 2023 07:37:17 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a025b00b0073b575f3603sm5014703qkn.101.2023.02.27.07.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 07:37:16 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-536af432ee5so188391237b3.0;
        Mon, 27 Feb 2023 07:37:16 -0800 (PST)
X-Received: by 2002:a81:ad43:0:b0:532:e887:2c32 with SMTP id
 l3-20020a81ad43000000b00532e8872c32mr10398864ywk.5.1677512236398; Mon, 27 Feb
 2023 07:37:16 -0800 (PST)
MIME-Version: 1.0
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org> <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
 <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com> <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
 <CAMuHMdXYXO+D==BrN4h57cmuNyOG2Jd3_NwOWNgpjaoBdWQvOg@mail.gmail.com> <7ECA014B-3910-4E65-9084-32F790A733D3@oracle.com>
In-Reply-To: <7ECA014B-3910-4E65-9084-32F790A733D3@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2023 16:37:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWNbwJDXJO8YJkJic-AN64LsUAEf6Jzrur_Ky0j_L=49g@mail.gmail.com>
Message-ID: <CAMuHMdWNbwJDXJO8YJkJic-AN64LsUAEf6Jzrur_Ky0j_L=49g@mail.gmail.com>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Chuck,

On Mon, Feb 27, 2023 at 4:06 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Feb 27, 2023, at 4:51 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Feb 23, 2023 at 5:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Thu, Feb 23, 2023 at 5:19 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>> On Feb 23, 2023, at 10:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> Unable to handle kernel access at virtual address af06da84
> >>
> >>>> I.e. a slightly different crash.
> >>>> As the difference between the two crashes is modular vs. builtin,
> >>>> this looks like an out-of-bound access in the test.
> >
> > Just ran it on physical arm32 and arm64 (Renesas APE6EVM and
> > Salvator-XS), and the test crashes there, too.
> >
> >>> Why not run the test suite just as I suggested?
> >
> > kunit_kernel.ConfigError: m68k is not a valid arch, options are
> > ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc',
> > 'x86_64']
> >
> > Will look into adding m68k support ;-)
> >
> > But the issue can easily be reproduced using
> > ".../tools/testing/kunit/kunit.py run --arch=arm
> > --cross_compile=arm-linux-gnueabihf- --raw_output=all --kunitconfig
> > ./net/sunrpc/.kunitconfig" on current upstream[1]:

> I'm still not able to reproduce:
>
> [cel@bazille odd-releases]$ tools/testing/kunit/kunit.py run --arch=arm
> --cross_compile=arm-linux-gnueabihf- --raw_output=all --kunitconfig
> ./net/sunrpc/.kunitconfig
> [10:04:14] Configuring KUnit Kernel ...
> Generating .config ...
> Populating config with:
> $ make ARCH=arm O=.kunit olddefconfig
> [10:04:18] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=arm O=.kunit olddefconfig
> Building with:
> $ make ARCH=arm O=.kunit --jobs=4
> ERROR:root:gcc: error: unrecognized argument in option ‘-mabi=aapcs-linux’
> gcc: note: valid arguments to ‘-mabi=’ are: ms sysv
> gcc: error: unrecognized argument in option ‘-mabi=aapcs-linux’
> gcc: note: valid arguments to ‘-mabi=’ are: ms sysv
> gcc: error: unrecognized command-line option ‘-mlittle-endian’
> gcc: error: unrecognized command-line option ‘-mlittle-endian’
> gcc: error: unrecognized command-line option ‘-mtp=cp15’
> gcc: error: unrecognized command-line option ‘-mtp=cp15’
> gcc: error: unrecognized command-line option ‘-mfpu=vfp’
> make[2]: *** [../scripts/Makefile.build:252: scripts/mod/empty.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> gcc: error: unrecognized command-line option ‘-mfpu=vfp’
> make[2]: *** [../scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
> make[1]: *** [/home/cel/src/linux/odd-releases/Makefile:1297: prepare0] Error 2
> make: *** [Makefile:242: __sub-make] Error 2
>
> -bash: --cross_compile=arm-linux-gnueabihf-: command not found
> -bash: ./net/sunrpc/.kunitconfig: Permission denied
> [cel@bazille odd-releases]$ gcc --version
> gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
> Copyright (C) 2022 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> [cel@bazille odd-releases]$
>
> What am I missing?

Please run that as a single command, not split across 3 lines.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
