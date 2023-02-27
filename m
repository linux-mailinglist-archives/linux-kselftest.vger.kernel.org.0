Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133316A4B54
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjB0TmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 14:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjB0TmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 14:42:09 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CF1987;
        Mon, 27 Feb 2023 11:41:59 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id ff4so5274117qvb.2;
        Mon, 27 Feb 2023 11:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+M8MoXObVraILUYUNZQa6sssikj2rSxS/rHvRcYnSnU=;
        b=tqRwiSoOrr6NgSBKXsY4e8QzhV/YLWAaQ+V140gnd6L4qJKPxHVIhNlmVPFsxFM8nX
         9VKE9iX7qrDPd5wh+6DPkz6OyDAvXXhG+ZuXN3nN6ZN8tMI9+57ij9WbDriQizDGuSBR
         jOw79IZxnMToqZ1kftRrXA0Q8U3zhHJh6WneWNmWcQzhNCDb6Cbcue1c3qCR2cnfDeee
         IlJ5p5ewvZXw028+UEBlsD2aMqdfrW3s/mdGG90PWTV4cTHs/1bMa/x5SFFResyJ2tr9
         /Faeq30aFJKQYFCfAEUALNRTSyX7Jdx/FRb09oyptGQT/PYU3gIoooSx34iDq2Wj4T/y
         0c1Q==
X-Gm-Message-State: AO0yUKUgv3Ip4GZ5mHbnabtqOb4YMXbtkgpnV3vBSGoUJXypcCoBnZGc
        R4C0Ft3dA6+QCbST8QaIxJeYmOC/5AjXPQ==
X-Google-Smtp-Source: AK7set+Cgaq9OLZxM8YPJKBrV5oh9tWORro2b8ykajTRjQY8seWjCiShmc/uHYQrw7nh7Tg/GT8b4A==
X-Received: by 2002:ad4:596d:0:b0:56b:340c:ee1a with SMTP id eq13-20020ad4596d000000b0056b340cee1amr881958qvb.49.1677526918140;
        Mon, 27 Feb 2023 11:41:58 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id f64-20020a37d243000000b0073ba46a585asm5389732qkj.64.2023.02.27.11.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 11:41:57 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536cb25982eso205947237b3.13;
        Mon, 27 Feb 2023 11:41:57 -0800 (PST)
X-Received: by 2002:a81:ad5c:0:b0:538:112b:67a0 with SMTP id
 l28-20020a81ad5c000000b00538112b67a0mr10431853ywk.5.1677526917514; Mon, 27
 Feb 2023 11:41:57 -0800 (PST)
MIME-Version: 1.0
References: <167751329962.149247.12935751231288858919.stgit@bazille.1015granger.net>
In-Reply-To: <167751329962.149247.12935751231288858919.stgit@bazille.1015granger.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2023 20:41:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU428G9=Vg6tc6JrWTkE-KD52Agasz3VY5KAJ+1DfT_Zg@mail.gmail.com>
Message-ID: <CAMuHMdU428G9=Vg6tc6JrWTkE-KD52Agasz3VY5KAJ+1DfT_Zg@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Let Kunit tests run with some enctypes compiled out
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

On Mon, Feb 27, 2023 at 4:58 PM Chuck Lever <cel@kernel.org> wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Allow the new GSS Kerberos encryption type test suites to run
> outside of the kunit infrastructure. Replace the assertion that
> fires when lookup_enctype() so that the case is skipped instead of
> failing outright.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>
> Hey Geert -
>
> This patch addresses part of your concern: with this patch applied,
> you should be able to run only the tests that target the encryption
> types that are enabled in your kernel. The other tests will be
> skipped rather than fail outright.

Thanks, works fine!

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
