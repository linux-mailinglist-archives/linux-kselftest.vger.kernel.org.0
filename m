Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28F3744FA2
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGBSUn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBSUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 14:20:42 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10766A0;
        Sun,  2 Jul 2023 11:20:41 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5703cb4bcb4so38089277b3.3;
        Sun, 02 Jul 2023 11:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688322040; x=1690914040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKh5KqdrwuQG18TgxeMA+E0eI4gePeGoB28R4nIaZ1w=;
        b=OejTZtHWgQVMkr4btEvnPLTghOC5pu9TfM7/4eoowR++LsyePDx68hnp0wEpxEq+Oe
         zxowNpFzOG5QyO0U31ihcfhRgpaQ7aKNDvJKyIeIqr9GwPdstfqA1NLYyZ0jg1RE3qV/
         kYU5xzD7B2usY8nMNQZINHkS/BQIsfgDblus87sdRnkFo4HYIjPdNE+0fvQ4fdFRnbnT
         U+lcIpyG/IlhrlI+gx5Seyd7WH52rH4p73uz9YqOqb/FmOt1W8Ojd0JJplq1zUjE/VSj
         nfLAThsTS1LAbGnhmTS43zSKCf/PJhqRSc0UYeOtji4Zombx9fHvHjjnBzQdbCClCqB3
         MvUA==
X-Gm-Message-State: ABy/qLYZBSwYA5PXxH8A/i2++dLx8FekZYdrU3LtVBVg3XcU450MeeXK
        eU8NzEpUEl9gj8a6GNqOY5jOg2dgeCmFHA==
X-Google-Smtp-Source: APBJJlFHbNFrgGH6ISpcKT8EpXsG8eXt8caltAV7GUnsIEEXZZnmMQOTUBsrphexnKItZ4R9JoM3EQ==
X-Received: by 2002:a81:68c5:0:b0:577:2709:6089 with SMTP id d188-20020a8168c5000000b0057727096089mr9017306ywc.12.1688322039736;
        Sun, 02 Jul 2023 11:20:39 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id r206-20020a0de8d7000000b0057060bb2874sm4684021ywe.37.2023.07.02.11.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 11:20:38 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bb15165ba06so3232055276.2;
        Sun, 02 Jul 2023 11:20:38 -0700 (PDT)
X-Received: by 2002:a25:ac1f:0:b0:bab:ef61:8b31 with SMTP id
 w31-20020a25ac1f000000b00babef618b31mr7966031ybi.53.1688322038540; Sun, 02
 Jul 2023 11:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com> <20230518145544.1722059-34-Liam.Howlett@oracle.com>
In-Reply-To: <20230518145544.1722059-34-Liam.Howlett@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Jul 2023 20:20:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com>
Message-ID: <CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com>
Subject: Re: [PATCH v4 33/35] maple_tree: Update testing code for mas_{next,prev,walk}
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
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

Hi Liam,

On Thu, May 18, 2023 at 9:37 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> Now that the functions have changed the limits, update the testing of
> the maple tree to test these new settings.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks for your patch, which is now commit eb2e817f38cafbf7
("maple_tree: update testing code for mas_{next,prev,walk}") in

> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
>
>         val = mas_next(&mas, ULONG_MAX);
>         MT_BUG_ON(mt, val != NULL);
> -       MT_BUG_ON(mt, mas.index != ULONG_MAX);
> +       MT_BUG_ON(mt, mas.index != 0x7d6);

On m68k (ARAnyM):

    TEST STARTING

    BUG at next_prev_test:2014 (1)
    Pass: 3749128 Run:3749129

And after that it seems to hang[*].

After adding a debug print (thus shifting all line numbers by +1):

    next_prev_test:mas.index = 0x138e
    BUG at next_prev_test:2015 (1)

0x138e = 5006, while the expected value is 0x7d6 = 2006.

I guess converting this test to the KUnit framework would make it a
bit easier to investigate failures...

[*] Left the debug one running, and I got a few more:

    BUG at check_empty_area_window:2656 (1)
    Pass: 3754275 Run:3754277
    BUG at check_empty_area_window:2657 (1)
    Pass: 3754275 Run:3754278
    BUG at check_empty_area_window:2658 (1)
    Pass: 3754275 Run:3754279
    BUG at check_empty_area_window:2662 (1)
    Pass: 3754275 Run:3754280
    BUG at check_empty_area_window:2663 (1)
    Pass: 3754275 Run:3754281
    maple_tree: 3804518 of 3804524 tests passed

So the full test took more than 20 minutes...

>         MT_BUG_ON(mt, mas.last != ULONG_MAX);
>
>         val = mas_prev(&mas, 0);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
