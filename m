Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47DA648097
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLIKEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 05:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLIKEZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 05:04:25 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE8A63B8F;
        Fri,  9 Dec 2022 02:04:23 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id cg5so3186486qtb.12;
        Fri, 09 Dec 2022 02:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihXtAUazn+V3lw4sgrM4dxPP4Vq6tOqT1cB+Rh/ZS30=;
        b=oh9sOn+0WiGHB6Qnc5Vl0sxFgnEwskcnh2PQgNNVm/FJQGzACoOKyTtz5Ceyay6KXY
         0n+rQg+2myxXsPg1Sptfty0+5Nuf1RSEdqP5yO7OJ/LdzrJPcBl3batFRuxAcWUyxyzc
         dwGPJxx8chLE1Sq6hNifP5LvUQTbgoHlbgFxLT5th0SJNC5Z01wOabbBTxpR0XxIniS3
         o+0+cpROku4wUO+AlV63lj0LUh/J43l6qe82dl5XbKcsSQ4vhL/+SeN6rX9/yBPwV6Mm
         yY+mZaOw+/kjBVwOYhVJGPo17Cg0EFySq76aA70kas8FN04S2YkbsUvo3ZwDjhC5/xZU
         Dc4g==
X-Gm-Message-State: ANoB5pl1SLmzixsY0do3zdJ05fQzwnv6DadFj0aqVKRxIHrRfVtOeRWj
        ubswzOzEwR6bNpUxyQzl6DB8KyeBDeYFBQ==
X-Google-Smtp-Source: AA0mqf7W4C4jGHiKZqS9BqTop362HVzxLJhT37BW9EQaaAH6hCbf/1QKktWeh5JqTX5A8i81nQNn5g==
X-Received: by 2002:a05:622a:4a0d:b0:3a5:3230:5e6f with SMTP id fv13-20020a05622a4a0d00b003a532305e6fmr7025383qtb.8.1670580262065;
        Fri, 09 Dec 2022 02:04:22 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id v7-20020ac87487000000b003a7ec97c882sm629924qtq.6.2022.12.09.02.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 02:04:21 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3bf4ade3364so45993107b3.3;
        Fri, 09 Dec 2022 02:04:21 -0800 (PST)
X-Received: by 2002:a0d:cb4c:0:b0:38e:e541:d8ca with SMTP id
 n73-20020a0dcb4c000000b0038ee541d8camr22239587ywd.283.1670580260918; Fri, 09
 Dec 2022 02:04:20 -0800 (PST)
MIME-Version: 1.0
References: <4d07ad990740a5f1e426ce4566fb514f60ec9bdd.1670509558.git.geert+renesas@glider.be>
 <20221208145745.a0424a67725f431a28737b6a@linux-foundation.org>
In-Reply-To: <20221208145745.a0424a67725f431a28737b6a@linux-foundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Dec 2022 11:04:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVkdmnKDobfZHkk+Lxradq238wAcaLOyW-cmS7J3MS4g@mail.gmail.com>
Message-ID: <CAMuHMdXVkdmnKDobfZHkk+Lxradq238wAcaLOyW-cmS7J3MS4g@mail.gmail.com>
Subject: Re: [PATCH] lib: Add Dhrystone benchmark test
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kselftest@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Andrew,

On Thu, Dec 8, 2022 at 11:57 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu,  8 Dec 2022 15:31:28 +0100 Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > Hence make the classical Dhrystone 2.1 benchmark available as a Linux
> > kernel test module, based on[1].
>
> I can take a look at this after the merge window

Thanks!

> I'm not able to figure out the licensing of this.
> https://netlib.org/benchmark/dhry-c appears to be silent on the topic?

Searching the internet, people claim it's just public domain...

My topic/dhry-unsquashed branch has my rationale:

    FreeBSD uses BSD-2-Clause for this, which is probably the closest to the
    original intention of the authors.
    Augment with GPL-2.0-only, as this now calls into internal Linux APIs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
