Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D919B6A4B5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 20:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjB0Tnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 14:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjB0Tnk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 14:43:40 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D8C23C70;
        Mon, 27 Feb 2023 11:43:38 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id ev13so5238385qvb.10;
        Mon, 27 Feb 2023 11:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKY+VbY0FCl1BqoxDKxydDXKFwBbKHMwhMyu/F0WRtQ=;
        b=UTQFCucOBd2JrvE8P1M7K0WBL2Tuf8YRyKZwGZl7ReNmqgHVLL+hmitCniE8SvtLLy
         czCb5+JJvRCF47nWOHjvf4lEXbvIbWI3BO4/MMeyri04xLr8x7A0JglrlWiaM61NQQ4M
         kvfja83M+gBc3T7RdAGx1JI6iUwTfcLeOA2YvsKsjtSkhUkcSqCgrDFgOPJnwiA9KOVe
         1twI8SgN0kZSZLlmpxOJD4N8PZysV1Eyj8kfquAc3+jssuJxL7DjkUOf836O37veYXZQ
         +UjMgACMIKktroPSTrB6WZVI4y3Ya9dNxaj29+uQlU8kvCwkMsqH0Tv5+sPw0f9EwIMO
         YHug==
X-Gm-Message-State: AO0yUKU70MF2pAAWOtJMHrGabJm59sr7dJINwOgiS8PQLyQXscPKjBYL
        C5WdpVYhXxA5itwzPxP+hFjbwIoHa3+rzA==
X-Google-Smtp-Source: AK7set/mZgNy3RcEHjGRvdXejRBRSSW1YDYM93ryIFUo4mcucJwkYAqz4z/TtSATtwrdkeySiorUDA==
X-Received: by 2002:a05:6214:262d:b0:572:2aa2:6dfa with SMTP id gv13-20020a056214262d00b005722aa26dfamr1254056qvb.28.1677527017090;
        Mon, 27 Feb 2023 11:43:37 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 135-20020a37068d000000b006ff8a122a1asm5503601qkg.78.2023.02.27.11.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 11:43:36 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-536af432ee5so208705497b3.0;
        Mon, 27 Feb 2023 11:43:36 -0800 (PST)
X-Received: by 2002:a81:b603:0:b0:533:99bb:c296 with SMTP id
 u3-20020a81b603000000b0053399bbc296mr10724897ywh.5.1677527016482; Mon, 27 Feb
 2023 11:43:36 -0800 (PST)
MIME-Version: 1.0
References: <167751664019.187639.5290505948970809072.stgit@bazille.1015granger.net>
In-Reply-To: <167751664019.187639.5290505948970809072.stgit@bazille.1015granger.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2023 20:43:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7mKmji6yyd2w+TrX0toyMN5r=hWvyxtM8D=qdBLcdww@mail.gmail.com>
Message-ID: <CAMuHMdW7mKmji6yyd2w+TrX0toyMN5r=hWvyxtM8D=qdBLcdww@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Ensure test case arrays are properly terminated
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
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

Hi Chuck,

On Mon, Feb 27, 2023 at 5:53 PM Chuck Lever <cel@kernel.org> wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Geert Uytterhoeven reports:
>
> ...
>         ok 9 Encrypt 13 bytes with camellia256-cts-cmac
>         ok 10 Encrypt 30 bytes with camellia256-cts-cmac
>     # RFC 6803 encryption: pass:0 fail:0 skip:10 total:10
>     ok 3 RFC 6803 encryption # SKIP Encryption type is not available
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address 73657420 when execute
> [73657420] *pgd=00000000
> Internal error: Oops: 80000005 [#1] ARM
> CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.2.0-rc7-00133-g373f26a81164-dirty #9
> Hardware name: Generic DT based system
> PC is at 0x73657420
> LR is at kunit_run_tests+0x3e0/0x5f4
>
> On x86 with GCC 12, the missing array terminators did not seem to
> matter. Other platforms appear to be more picky.

Doesn't gcc on x86 align all arrays to a 16-byte boundary, hence
adding zero-padding here?

>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
