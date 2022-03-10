Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C554D3E43
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 01:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiCJAhl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 19:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiCJAhd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 19:37:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC911AA20
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 16:36:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so6723743lfh.2
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tU+Fe+vcmWYII8bcpQckbuUOYQxVwc8Ms6FjnpeZUXo=;
        b=L/mvPUr5+ed9/8F1xYBeOkHEQX/N5BqBnxQcWBYwpz8RAerWYK3vG+jQ8UcnJ76O8n
         Z6F8qP7cE8tNgjablMkD4TSjih/QPIMEsvNLTgmbdeWBRVediWkgAMhZdVVhEgcgGEdK
         lMZ1J3pO3p0Ql46BLe9TS7msF+0WkJiXc3GEYEhfXxvSABXRpmnJrXBNidzsucgWij7W
         h71P/xxdG4gMnr+gam3ehpQ7R8zTNQQGhJ/hYPRcyYsfLb7u+8rs0B5WjYUfbEvSpW08
         3VtCaxMUJjZ5zrZuYEdWuLeNzUmAVqnhioFkV1FhQj3OlGZ8RQb3TRq3538igabd/3yR
         jrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tU+Fe+vcmWYII8bcpQckbuUOYQxVwc8Ms6FjnpeZUXo=;
        b=5V65gq+nYz8fDS0z9/CAK4R2/UQc84FRqSAjyXhJBpMkt1abXYlFLWIyikh9I8EGw3
         dc4j1hExLz8J4KCfj5SwSLH8pvpEfeVb139/SfLqF4c8+KAr2Cm8PKV7q7wNpOnyunZj
         1ti9U2lNVwSNSVsSLl7v5TaVGZAKedygGVpgmLNsFmxaiLsAXz8RfbfKkbuqWagGnZkw
         adgrvMxjczqqlTVcaA3LLfVX3HkSJsFjKxNEf46z2JSCe5BkQjmeW0Z7d+/VKKKPQQ6G
         APjoUNqUrbrVObVEEfN8726QqZoutRNYBPKWPRx4s0SG/GuGsRkLLu2wMYlbDY02eauz
         GW8w==
X-Gm-Message-State: AOAM531t3M5G6Xi8bi7BEEmfSnoJhsBqJ+eV/4zmrGOHOKUILIfWeUoO
        ojiekq8eho0QOYGu9EaYh/DjAJ+SJJig+rnIJnezug==
X-Google-Smtp-Source: ABdhPJytXKwI98E3nQqK0BdQ0dFxt9GnezH6c63KyMKM/BPYYzDCKWIjWSo338Qxmgo/66zO3+BC+IAEhGNy/BYPIF4=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr1387380lfl.87.1646872591569; Wed, 09 Mar
 2022 16:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org> <CAKwvOd=Q-7vPaRPj1wQagFsY3txcAKzrqU_D2UAX3h4ym91uUA@mail.gmail.com>
 <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X>
In-Reply-To: <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Mar 2022 16:36:20 -0800
Message-ID: <CAKwvOd=0tn3DeqDkKxxk61EvHY9Vb+SnHkXugUmHCMFF_0VVoQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 8, 2022 at 7:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Mar 07, 2022 at 11:08:29AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 4, 2022 at 9:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > +If your LLVM tools are not available in your PATH, you can supply their
> > > +location using the LLVM variable with a trailing slash: ::
> > > +
> > > +       make LLVM=/path/to/llvm/
> > > +
> > > +which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
> >
> > I don't think we should do this; `PATH=/path/to/llvm/ make LLVM=1`
> > works and (my interpretation of what) Masahiro said "if anyone asks
> > for this, here's how we could do that."  I don't think I've seen an
> > explicit ask for that. I'd rather LLVM= have 2 behaviors than 3, but I
> > won't hold this patch up over that.  Either way:
>
> Right, there has not been an explicit ask for the prefix support yet,
> although I know I personally would use it,

Then let that be reason enough. :)
-- 
Thanks,
~Nick Desaulniers
