Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC446A58B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjB1L5s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjB1L5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 06:57:46 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0FB35B1;
        Tue, 28 Feb 2023 03:57:43 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id z6so10124883qtv.0;
        Tue, 28 Feb 2023 03:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBqG4RFiho8wLx0OkbNeTLwcZ0cErBkreFsGBchxVJA=;
        b=6OcHzVJusgLqez/BWdTOQmXxkHKYamekUrF9Eop6h80ei/YNfdwuKRf6kREYcSgxhg
         fT/Ldh+ifZSgctBOCRkHrQI35dAf+JYOqyKcsrHaP0uZxJOKxEX7oxEq03gQMR1XysAE
         OXU0j4CmKExRTwiv8J+AZC80tqwSISB4oSvTgRhjHS3Ivn2ZFCQj9+6c8b3DN4hYfm9M
         0FU5T+O4GkJMrhLfBL8mXGAvsmX07MEQksl/Go+MDQKHaJQutLzzMaLTwLdfJdp3pFO3
         xZgmWGaoe8NfIChYuZrpHVm48Yv7376DFfKwnSv0mf4Bj871fGTmjsYybBPI4EjdzP+e
         v5yA==
X-Gm-Message-State: AO0yUKXaMgUzlSnK5Tx96+szOg8YjHXF8i86suCTj2l+G2pMOmwyEI7l
        wJ4PHimLKjyh4ypKdkXjgh0el0oOweVWeA==
X-Google-Smtp-Source: AK7set8To/p/AS4FtLwNVfuzu7jwpHG0s+mHMrtTwRBGXQPI1rJ7T0qpEAeWCJul6zqCvFA5L2Qu1Q==
X-Received: by 2002:a05:622a:48c:b0:3a8:e35:258f with SMTP id p12-20020a05622a048c00b003a80e35258fmr3594209qtx.31.1677585462263;
        Tue, 28 Feb 2023 03:57:42 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a111000b007343fceee5fsm6658131qkk.8.2023.02.28.03.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 03:57:41 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5384ff97993so265123397b3.2;
        Tue, 28 Feb 2023 03:57:41 -0800 (PST)
X-Received: by 2002:a81:ad43:0:b0:533:91d2:9d94 with SMTP id
 l3-20020a81ad43000000b0053391d29d94mr1472680ywk.5.1677585461211; Tue, 28 Feb
 2023 03:57:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677579750.git.geert+renesas@glider.be> <e72dd5e0af2df190d7bb52ba36e44391d59da59e.camel@physik.fu-berlin.de>
In-Reply-To: <e72dd5e0af2df190d7bb52ba36e44391d59da59e.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Feb 2023 12:57:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWEzvbXYSaMDQcqvMFDDNPxp16N6250FRxt8KbBv2b_5w@mail.gmail.com>
Message-ID: <CAMuHMdWEzvbXYSaMDQcqvMFDDNPxp16N6250FRxt8KbBv2b_5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] kunit: tool: Add support for SH under QEMU
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Adrian,

On Tue, Feb 28, 2023 at 12:55 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2023-02-28 at 11:31 +0100, Geert Uytterhoeven wrote:
> > This patch series adds support to run tests via kunit_tool on the
> > SuperH-based virtualized r2d platform.  As r2d uses the second serial
> > port as the console, this needs a small modification of the core
> > infrastructure.
>
> Very cool idea. I have never used the kunit testsuite before, I will have
> a look at it. Is there documentation available which shows how to get
> started?

Run e.g.:

./tools/testing/kunit/kunit.py run --arch=sh
--cross_compile=sh4-linux-gnu- --raw_output=all --kunitconfig
fs/ext4/.kunitconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
