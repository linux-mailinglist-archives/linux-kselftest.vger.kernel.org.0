Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB386A91D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 08:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCCHml convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 02:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCHmi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 02:42:38 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC953280;
        Thu,  2 Mar 2023 23:42:37 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id y10so2018766qtj.2;
        Thu, 02 Mar 2023 23:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9nCVf6WNNlYssKnigBAOjxStMo9e30edFuPkTaqO20=;
        b=PyNdMKUeaFW0v1h2dSrluh7d1nUmOhfyXOWhnbs6Ic1kFtHhL91VAnOpmCgUdEkv2z
         k7vGEfmGKvl+CdBFeiFU+g4TJVaLrR5BQ55O0PSlEv09UdPo7K7O8lzkFxgcAjY0+44O
         3P5jdALAJPnpqL9Mc5Vl9w00kIv0/zl2H/IsM+SKlUsg8L6pOIQVLsvl9KRhYoyT9BK6
         92V3xpXSc1scURS1NgXU8UzIi1yELwYm4sT8ns6t0b3B0/uELJ1phd5rWCvKY/KYoM5L
         w8DH46Ckjs5OIX9JozAupnl71L6wAz9dmlOD3GM1SY2/6btEQp7ssGeGXSfue5ftWa3Q
         WuCg==
X-Gm-Message-State: AO0yUKWn9+TQo9cbIe5IV307TqHQVJc9FMLTBPXq96Jgzy3NQMyKcy2p
        ylUqxhBVUlLgy2umfhdp4oW4kO3JhJGPLQ==
X-Google-Smtp-Source: AK7set+w5sXXW/EKbc7gh/lynnM0p1cewxgiKgF66F7wPsLpKmWxPu0eUcIbPFEC0AaBmwyePWB58g==
X-Received: by 2002:ac8:7f16:0:b0:3bf:d0b1:433d with SMTP id f22-20020ac87f16000000b003bfd0b1433dmr1577005qtk.60.1677829356263;
        Thu, 02 Mar 2023 23:42:36 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id i65-20020a378644000000b00725d8d6983asm1231426qkd.61.2023.03.02.23.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:42:35 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536cb25982eso27676037b3.13;
        Thu, 02 Mar 2023 23:42:35 -0800 (PST)
X-Received: by 2002:a81:af0c:0:b0:52f:1c23:ef1 with SMTP id
 n12-20020a81af0c000000b0052f1c230ef1mr371968ywh.5.1677829355540; Thu, 02 Mar
 2023 23:42:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677579750.git.geert+renesas@glider.be> <CABVgOS=vXSuqrJ=6rbAZ1vT3Y=SR69T9EFikXKPY_hmv25riwQ@mail.gmail.com>
In-Reply-To: <CABVgOS=vXSuqrJ=6rbAZ1vT3Y=SR69T9EFikXKPY_hmv25riwQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Mar 2023 08:42:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4_FBsSYMF3Yvw3v_g6tdS=WVJGeuPmH3XRUiyYNBPmQ@mail.gmail.com>
Message-ID: <CAMuHMdX4_FBsSYMF3Yvw3v_g6tdS=WVJGeuPmH3XRUiyYNBPmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] kunit: tool: Add support for SH under QEMU
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org
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

Hi David,

On Fri, Mar 3, 2023 at 8:26 AM David Gow <davidgow@google.com> wrote:
> On Tue, 28 Feb 2023 at 18:31, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series adds support to run tests via kunit_tool on the
> > SuperH-based virtualized r2d platform.  As r2d uses the second serial
> > port as the console, this needs a small modification of the core
> > infrastructure.
> >
> > Thanks for your comments!
>
> This series looks good to me, but I've not been able to successfully
> get qemu to boot anything on SuperH (it just seems to hang with no
> output).
>
> Is there anything like magic config or firmware images (I didn't think
> so for r2d: shix prints out an error, though) required to get this
> going?

No idea. I thought it just works.

> The qemu command KUnit is using seems correct (and none of the obvious
> permutations, particularly around the serial ports seem to help):
> qemu-system-sh4 -nodefaults -m 1024 -kernel .kunit/arch/sh/boot/zImage
> -append 'kunit.enable=1 console=ttySC1 kunit_shutdown=reboot'
> -no-reboot -nographic -serial null -machine r2d -serial mon:stdio

That works just fine for me.

On plain v6.2 with this series applied:
$ ./tools/testing/kunit/kunit.py run --arch=sh
--cross_compile=sh4-linux-gnu- --raw_output=all --kunitconfig
fs/ext4/.kunitconfig
[08:38:59] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=sh O=.kunit olddefconfig CROSS_COMPILE=sh4-linux-gnu-
[08:39:01] Building KUnit Kernel ...
Populating config with:
$ make ARCH=sh O=.kunit olddefconfig CROSS_COMPILE=sh4-linux-gnu-
Building with:
$ make ARCH=sh O=.kunit --jobs=12 CROSS_COMPILE=sh4-linux-gnu-
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
[... more warnings ...]
[08:39:51] Starting KUnit Kernel (1/1)...
Running tests with:
$ qemu-system-sh4 -nodefaults -m 1024 -kernel
.kunit/arch/sh/boot/zImage -append 'kunit.enable=1 console=ttySC1
kunit_shutdown=reboot' -no-reboot -nographic -serial null -machine r2d
-serial mon:stdio
Linux version 6.2.0-00002-g5b394444bb0d (geert@rox) (sh4-linux-gnu-gcc
(Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0, GNU ld (GNU Binutils for
Ubuntu) 2.38) #3 Fri Mar  3 08:39:50 CET 2023
...

$ qemu-system-sh4 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.6)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
