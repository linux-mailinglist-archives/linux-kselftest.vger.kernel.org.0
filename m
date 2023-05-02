Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAC6F480D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjEBQKu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjEBQKN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 12:10:13 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADB11997;
        Tue,  2 May 2023 09:10:05 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5529f3b8623so37529507b3.2;
        Tue, 02 May 2023 09:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043805; x=1685635805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B0HvX2nGzxUhkZvCD432MN6qQWUyvh7KEoB0EI6v8I=;
        b=K/diUuseYVVyggeT9nylJBglUBxd5PPk72D3anqdElFClsXbdip6II6v3FUnX8avRl
         tDu1SLsQInUXtEqPGQ1u8OZRShTVlF6vYHix73j+MO0XwDtvmQFAcrAFN6L+vj5WJnNH
         X1f9Co65KPtfB7Xa2tXi6eyOVyQ9cZoYm1fXhd7a9x694ntbAdy49SPQ86jWEPqjir7D
         vRFbu8Xd28h9I+5z5YHM9UKuWJQQVz2EaE4TXyAoPQADzCsTLivgcshpaYBWCHIpRkTx
         dDfJLN8N0tQ3si+sidWfk7xz2yoWf4yVuVuVoeFO9wzotbtvhtsAaQlpwef2dD04UtZY
         mlGQ==
X-Gm-Message-State: AC+VfDyeCkGeCp8wA6ATJbQUW7bx0x4cpcPil3o/3cJ4vMoaGZLXFRHT
        WbfrH26sm0foICenqdbWXL6TJ17QwUyapA==
X-Google-Smtp-Source: ACHHUZ6j7sPS+7ctgZXxn7Mqb3pA6gtYjitizY4pnWxMo9S7RBTN04OPNGcgaIx2spG6okK/iTyrVA==
X-Received: by 2002:a25:ea04:0:b0:b9a:7693:93f7 with SMTP id p4-20020a25ea04000000b00b9a769393f7mr15651671ybd.45.1683043804666;
        Tue, 02 May 2023 09:10:04 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 62-20020a251241000000b00b9db62abff3sm1837597ybs.58.2023.05.02.09.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 09:10:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-55a829411b5so16329407b3.1;
        Tue, 02 May 2023 09:10:02 -0700 (PDT)
X-Received: by 2002:a25:142:0:b0:b9e:7613:fcb1 with SMTP id
 63-20020a250142000000b00b9e7613fcb1mr1967815ybb.63.1683043802650; Tue, 02 May
 2023 09:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683022164.git.geert+renesas@glider.be>
In-Reply-To: <cover.1683022164.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 May 2023 18:09:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
Message-ID: <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Input: tests - miscellaneous fixes
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Javier,

On Tue, May 2, 2023 at 12:17 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series fixes a crash in the new input selftest, and makes the
> test available when the KUnit framework is modular.
>
> Unfortunately test 3 still fails for me (tested on Koelsch (R-Car M2-W)
> and ARAnyM):
>
>         KTAP version 1
>         # Subtest: input_core
>         1..3
>     input: Test input device as /devices/virtual/input/input1
>         ok 1 input_test_polling
>     input: Test input device as /devices/virtual/input/input2
>         ok 2 input_test_timestamp
>     input: Test input device as /devices/virtual/input/input3
>         # input_test_match_device_id: ASSERTION FAILED at # drivers/input/tests/input_test.c:99
>         Expected input_match_device_id(input_dev, &id) to be true, but is false
>         not ok 3 input_test_match_device_id
>     # input_core: pass:2 fail:1 skip:0 total:3
>     # Totals: pass:2 fail:1 skip:0 total:3
>     not ok 1 input_core

Adding more debug code shows that it's the test on evbit [1] in
input_match_device_id() that fails.
Looking at your input_test_match_device_id(), I think you expect
the checks for the various bitmaps to be gated by
"if (id->flags & INPUT_DEVICE_ID_MATCH_EVBIT)", like is done for the
other checks?

[1] https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1021

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
